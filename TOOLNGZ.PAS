Unit ToolNGZ;

{ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ}
                                   INTERFACE
{ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ}

Uses Systex;

Const
 NameLen=40;   { Longueur maximal de la base de donnÇes }
 CreditsStrLen=65;   { max. length of credits strings }
 CreditsNm=5;   { max. no. of credits strings }
 MaxMnus=10;   { max. no. of (horizontal) menus }
 MaxItems=8;   { max. no. of items per menu (less title) }
 LongStrLen=78;   { max. displayed length of 'long entry' string, does not include attrib signs }
 LongStrucSizeMax=17*1024;  { 17 KB is max. size for a long entry in source format }
 HeaderSize=378;   { file offset 0..377 }
 crypto=$1A; { except for file header, ALL file bytes are encrypted }
 FixedStrucSize=$1A;
 ShortID=0; LongID=1; MnuID=2;
 ExtNGO='.NGO';  { Extension rÇservÇ pour les objets NG }
 ExtNG='.NG' ;   { Fait., Fichier de base donnÇes NG }
 ExtASC='.ASC';  { Fichier de sortie de donnÇes en ASCII }
 ExtLCF='.LCF';  { Fichier de lien de contrìle }
 ExtMAK='.MAK';  { Fichier Ö fabriquer }
 ExtRPT='.RPT';  { Fichier rapport }
{ Non des fichiers de sortie:
   data  : NAMEnnn.ASC     nnn = compteur (VAR OutFilesNm)
   linkf : NAME.LCF        NAME = Les 4 premiers caractäres du fichier sortie
   makef : NAME.MAK
   reptf : NAME.RPT}
 crlf=#13#10;
 OneHundred=78+22+40;{ expanded NG strings: add space for attribute signs }

Type
 BigBuf=Array[0..LongStrucSizeMax-1+$1A]of Byte; { 17 Ko }
 str40=String[NameLen];
 str65=String[CreditsStrLen];
 DropMnu=Record
  txt:str40;
  fptr:Long;
  datn:Wd;
  End;
 TopMnu=Record
  toptxt:str40;
  items:Wd;
  drop:Array[0..MaxItems-1]of DropMnu;
 End;
 StrucRecPtr=^StrucRec;
 StrucRec=Record
  ID:Wd;
  FileOfs,ParPtr,FirstPtr,LastPtr:Long;
  TgtFile:Wd;
  Txt:String[55];
  Next:StrucRecPtr;
 End;

 NGZRec=Record
  InName:PathStr;
  DirInf:SearchRec;
  NGf:FILE;
  datf,Scr,reptf:Hdl;
  buf,sbuf:BigBuf;
  VarStrucSize:Wd;
  fprefix:String[4];
  OutFilesNm:Wd;
  LastReadPos:Long;
  rc:Byte;
  cmd:String[127];
  IsInfReq,IsQuiet,IsReptOnly,IsPartial:Bool;
  PartialOfs:Long;
  NGName:str40;
  credits:Array[0..CreditsNm-1]of str65;
  LastID:Wd;
  Mnu:Array[0..MaxMnus-1]of TopMnu;
  NmMnus,NmShort:Wd;
  NmLong,FS:Long;
  CurrMnu,CurrItem:Wd;
  srm,sra,sr1,srp,src:StrucRecPtr;
 End;

Procedure GetMnuStruc(Var Q:NGZRec);
Function  GetNGstr(Var Q:NGZRec;i:Wd;Var sz:Wd):String;
Function  LookUpFileNO(Var Q:NGZRec;fp:Long):Wd;
Procedure LstPtrs(Var Q:NGZRec;f:Wd);
Procedure LstStats(Var Q:NGZRec;f:Wd);
Function  ParseCmd(Var Q:NGZRec;Var sce:PathStr):Byte;
Function  ProcessStruc(Var Q:NGZRec;Var datf:Hdl;fpos:Long;FileNo:Wd;lookup:Bool):Byte;
Function  ReadNVerifyHeader(Var Q:NGZRec):Byte;
Function  ReadNDecryptStruc(Var Q:NGZRec;Var ID:Wd;Varia2:Bool):Byte;
Function  RegStrucs(Var Q:NGZRec):Byte;
Function  RunNGZ(FileName:PathStr):Byte;
Procedure WriteLnkFile(Var Q:NGZRec);
Procedure WriteMakeFile(Var Q:NGZRec);

{ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ}
                                 IMPLEMENTATION
{ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ}

Uses Memories,Systems,Dials,DialPlus;

Function GetW(Var Q:NGZRec;i:Word):Word;
Var
 W:Word;
Begin
 System.Move(Q.Buf[i],W,2);
 GetW:=W;
End;

Function GetDW(Var Q:NGZRec;i:Word):LongInt;
Var
 DW:LongInt;
Begin
 System.Move(Q.Buf[i],DW,4);
 GetDW:=DW;
End;

Function GetWS(Var Q:NGZRec;i:Word):Word;
Var
 W:Word;
Begin
 System.Move(Q.sbuf[i],W,2);
 GetWS:=W;
End;

Function GetLS(Var Q:NGZRec;i:Word):LongInt;
Var
 DW:LongInt;
Begin
 System.Move(Q.sbuf[i],dw,4);
 GetLS:=DW;
End;

Function RunNGZ;
Label Xit;
Var
 i,j,ThisNm:Word;
 ThisPos:LongInt;
 x0:^NGZRec;
 CurrMnu,CurrItem:Word;
 xc:Byte;
 {$IFNDEF DosPrompt}
  W:Window;
 {$ENDIF}
 Begin
 x0:=MemNew(SizeOf(NGZRec));
 {$IFDEF DosPrompt}
  x0^.rc:=ParseCmd(x0^,x0^.InName);
 {$ELSE}
  If(x0=NIL)Then Begin
   __OutOfMemory;
   Exit;
  End;
  WEInitO(W,50,10);
  WEPushWn(W);
  WEPutWnKrDials(W,'Guide Norton');
  WELn(W);
  WEPutTxtLn(W,'DÇcompilation du guide en cours...');
  WELn(W);
  x0^.InName:=FileName;x0^.IsQuiet:=Ya;
 {$ENDIF}
 If(x0^.IsInfReq)Then Begin RunNGZ:=1;Goto Xit;End;
 If x0^.rc>0Then Begin RunNGZ:=2;Goto Xit;End;
 If(x0^.IsReptOnly)Then x0^.IsPartial:=No;
 Assign(x0^.NGf,x0^.InName);
 FileMode:=0;
 Reset(x0^.NGf,1);
 If IOresult<>0Then Begin RunNGZ:=4;Goto Xit;End;
 x0^.FS:=System.FileSize(x0^.NGf);
 x0^.NmShort:=0; x0^.NmLong:=0;
 x0^.OutFilesNm:=0;
 x0^.fprefix:='____';
 i:=Length(x0^.InName); j:=1;
 While(i>1)and Not(x0^.InName[Pred(i)]in[':','\'])do Dec(i);
 While(x0^.InName[i]<>'.')and(j<=4)do Begin
  x0^.fprefix[j]:=x0^.InName[i];
  Inc(i);
  Inc(j);
 End;
 If(x0^.IsQuiet)Then x0^.Scr:=hdlNUL
                Else x0^.Scr:=hdlSCR;
 If(x0^.IsPartial)Then Begin
  x0^.sr1:=NIL;
  x0^.datf:=FileCreate(x0^.fprefix+'112'+ExtASC);
  xc:=ProcessStruc(x0^,x0^.datf,x0^.PartialOfs,112,No);
  If xc<>$FFThen Goto Xit;
  FileClose(x0^.datf);
  RunNGZ:=0; Goto Xit;
 End;
 FindFirst(x0^.fprefix+'*.*',faArchive,x0^.DirInf);
 If(SysErr=0)and(Pos(ExtNG,x0^.DirInf.Name)=0)Then Begin
  {$IFDEF DosPrompt}
   _PutFileTxtLn(x0^.Scr,'* ATTENTION *');
   _PutFileTxtLn(x0^.Scr,'Le rÇpertoire courant Ö des fichiers comme '+x0^.fprefix+'*.*');
   _PutFileTxtLn(x0^.Scr,'Presse Break (Ctrl+C) maintenant pour Çviter que je rÇÇcrive les fichiers.');
   _PutFileLn(x0^.Scr);
  {$ELSE}
  If(WarningMsgYesNo('Le rÇpertoire courant Ö des fichiers comme '+x0^.fprefix+'*.*.'+
                  'Presse Break (Ctrl+C) maintenant pour Çviter que je rÇÇcrive'+
                  'les fichiers.')<>kbYes)Then Begin
   WEPutTxtLn(W,'êchec de dÇcompilation!');
   Goto Xit;
  End;
  {$ENDIF}
 End;
 If(x0^.IsReptOnly)Then
 {$IFDEF DosPrompt}
  _PutFileTxtLn(x0^.Scr,'Seulement le rapport');
 {$ELSE}
  WEPutTxtLn(W,'Seulement le rapport');
 {$ENDIF}
 x0^.ReptF:=FileCreate(x0^.fprefix+ExtRPT);
 xc:=ReadNVerifyHeader(x0^);
 If xc<>$FFThen Goto Xit;
 x0^.CurrMnu:=0;
 Repeat
  xc:=ReadNDecryptStruc(x0^,x0^.LastID,Ya);
  If xc<>$FFThen Goto Xit;
  If(x0^.LastID=MnuID)Then Begin
   GetMnuStruc(x0^);
   Inc(x0^.CurrMnu);
  End;
 Until(x0^.CurrMnu=x0^.NmMnus)or(x0^.LastID<>MnuID)or Eof(x0^.NGf);
 If(x0^.CurrMnu<>x0^.NmMnus)Then Begin
  RunNGZ:=9;
  Goto Xit;
 End;
 If(x0^.LastID>MnuID)Then Begin
  RunNGZ:=12;
  Goto Xit;
 End;
 x0^.src:=NIL;
 Mark(x0^.srm);
 New(x0^.src);
 x0^.sr1:=x0^.src;
 xc:=RegStrucs(x0^);
 If xc<>$FFThen Goto Xit;
 LstStats(x0^,x0^.Scr);
 x0^.sra:=x0^.sr1;
 While(x0^.sra<>NIL)do Begin
  If(x0^.IsReptOnly)Then x0^.datf:=hdlNUL Else x0^.DatF:=FileCreate(x0^.fprefix+Str0(x0^.sra^.TgtFile,3)+ExtASC);
  xc:=ProcessStruc(x0^,x0^.datf,x0^.sra^.FileOfs,x0^.sra^.TgtFile,Ya);
  If xc<>$FFThen Goto Xit;
  FileClose(x0^.datf);
  x0^.sra:=x0^.sra^.next;
 End;
 For CurrMnu:=0to Pred(x0^.NmMnus)do For CurrItem:=0to Pred(x0^.Mnu[CurrMnu].items)do Begin
  ThisPos:=x0^.Mnu[CurrMnu].drop[CurrItem].fptr;
  ThisNm:=LookUpFileNO(x0^,ThisPos);
  x0^.Mnu[CurrMnu].drop[CurrItem].datn:=ThisNm; x0^.sra:=x0^.sr1;
  While(x0^.sra^.TgtFile<>ThisNm)and(x0^.sra<>NIL)do x0^.sra:=x0^.sra^.next;
  If(x0^.sra^.TgtFile=ThisNm)Then
   x0^.sra^.txt:=Left(x0^.Mnu[CurrMnu].toptxt,8)+': '+x0^.Mnu[CurrMnu].drop[CurrItem].txt;
 End;
 {$IFDEF DosPrompt}
  _PutFileTxtLn(x0^.Scr,'êcrit le fichier de rapport');
 {$ELSE}
  WEPutTxtLn(W,'êcrit le fichier de rapport');
 {$ENDIF}
 LstStats(x0^,x0^.reptf);
 LstPtrs(x0^,x0^.reptf);
 x0^.sra:=x0^.sr1;
 While(x0^.sra<>NIL)do Begin
  _PutFileTxtLn(x0^.reptf,x0^.fprefix+Str0(x0^.sra^.TgtFile,3)+ExtASC+': '+x0^.sra^.txt);
  x0^.sra:=x0^.sra^.next;
 End;
 FileClose(x0^.reptf);
 If Not(x0^.IsReptOnly)Then Begin
  {$IFDEF DosPrompt}
   _PutFileTxtLn(x0^.Scr,'êcrit les fichiers de liens et de fabrication');
  {$ELSE}
   WEPutTxtLn(W,'êcrit les fichiers de liens et de fabrication');
  {$ENDIF}
  WriteLnkFile(x0^);
  WriteMakeFile(x0^);
 End;
 Release(x0^.srm);
 RunNGZ:=0;
Xit:
 {$IFNDEF DosPrompt}While WEOk(W)do;{$ENDIF}
 FreeMemory(x0,SizeOf(NGZRec));
End;

Function GetStr(Var Q:NGZRec;i:Wd):str65;
Var
 s:str65;
 j:Word;
Begin
 j:=0;
 While Q.buf[i]>0do Begin
  Inc(j);
  s[j]:=Chr(Q.buf[i]);
  Inc(i)
 End;
 s[0]:=Chr(j);GetStr:=s;
End;

Function ParseCmd;
Var
 i,j:Word;
 Tst:Integer;
 PStr:^String;
Begin
 sce:=StrUp(ParamStr(1));PStr:=Ptr(PrefixSeg,$80);Q.Cmd:=StrUp(PStr^);
 Q.IsInfReq:=Pos('?',Q.Cmd)>0;Q.IsQuiet:=Pos('/Q',Q.Cmd)>0;
 Q.IsReptOnly:=Pos('/R',Q.Cmd)>0;Q.IsPartial:=Pos('/P',Q.Cmd)>0;ParseCmd:=0;
 If(Q.IsInfReq)Then Exit;
 ParseCmd:=1;
 If Q.Cmd=''Then Exit;
 If sce=''Then Exit;
 If(Q.IsPartial)Then Begin
  i:=Pos('/P',Q.Cmd)+2;j:=i;
  While Q.Cmd[j]in['0'..'9','A'..'F']do Inc(j);
  Val('$'+Copy(Q.Cmd,i,j-i),Q.PartialOfs,Tst);
  If(Tst>0)or(Q.PartialOfs<0)Then Exit;
 End;
 ParseCmd:=0;
End;

Procedure WriteLnkFile;
Var
 i,j:Word;
 st:String;
 LinkF:Hdl;
Begin
 LinkF:=FileCreate(Q.fprefix+ExtLCF);
 _PutFileTxtLn(linkf,crlf+StrUSpc('!Name:',12)+Q.NGName+crlf);
 _PutFileTxtLn(linkf,'!Credits:');
 st:='';
 For i:=0to Pred(CreditsNm)do AddStr(st,Q.credits[i]);
 If st<>''Then For i:=0to Pred(CreditsNm)do _PutFileTxtLn(linkf,Q.credits[i]);
 _PutFileLn(LinkF);
 For i:=0to Pred(Q.NmMnus)do Begin
  _PutFileTxt(linkf,StrUSpc('!Menu:',12));
  _PutFileTxtLn(linkf,Q.Mnu[i].toptxt);
  For j:=0to Pred(Q.Mnu[i].items)do Begin
   st:=Q.Mnu[i].drop[j].txt;
   _PutFileTxtLn(linkf,Spc(12)+StrUSpc(st,Succ(NameLen))+Q.fprefix+Str0(Q.Mnu[i].drop[j].datn,3)+ExtNGO);
  End;
  _PutFileLn(linkf);
 End;
 FileClose(linkf);
End;

Procedure WriteMakeFile;
Var
 i,j,k:Word;
 st:String;
 makef:Hdl;
Begin
 MakeF:=FileCreate(Q.fprefix+ExtMAK);
 _PutFileTxtLn(makef,'# Type:  MAKE -f'+Q.fprefix+ExtMAK+crlf);
 _PutFileTxtLn(makef,ExtASC+ExtNGO+':');
 _PutFileTxtLn(makef,Spc(12)+'NGC $<'+crlf);
 _PutFileTxt(makef,'OBJECTS= ');
 k:=9;
 For i:=1to(Q.OutFilesNm)do Begin
  _PutFileTxt(makef,StrUSpc(Q.fprefix+Str0(i,3)+ExtNGO,14));
  Inc(k,14);
  If k>=65Then Begin
   _PutFileTxt(makef,'\'+crlf+Spc(9));
   k:=9;
  End;
 End;
 _PutFileTxtLn(makef,crlf+crlf+'NEWNG.NG:   $(OBJECTS)');
 _PutFileTxtLn(makef,Spc(9)+'NGML '+Q.fprefix+ExtLCF);
 FileClose(makef);
End;

Function GetNGstr;
Var
 j,k,z:Word;
 st:String;
Begin
 j:=0; z:=i;
 While(Q.buf[i]>0)and(j<OneHundred)do Begin
  Inc(j);
  If(Q.buf[i]=255)and(Q.buf[i+1]>0)Then Begin
   For k:=1to Q.buf[i+1]do If(j<OneHundred)Then Begin
    st[j]:=#32;
    Inc(j)
   End;
   Dec(j);Inc(i);
  End
   Else
  st[j]:=Chr(Q.buf[i]);
  Inc(i);
 End;
 st[0]:=Chr(j);sz:=i-z;GetNGstr:=st;
End;

Function GetNGStrS(Var Q:NGZRec;i:Word;Var sz:Word):String;
Var
 j,k,z:Word;
 st:String;
Begin
 j:=0; z:=i;
 While(Q.sbuf[i]>0)and(j<OneHundred)do Begin
  Inc(j);
  If(Q.sbuf[i]=255)and(Q.sbuf[i+1]>0)Then Begin
   For k:=1to Q.sbuf[i+1]do If(j<OneHundred)Then Begin
    st[j]:=#32;
    Inc(j)
   End;
   Dec(j);Inc(i);
  End
   Else
  st[j]:=Chr(Q.sbuf[i]);
  Inc(i);
 End;
 st[0]:=Chr(j);sz:=i-z;GetNGStrS:=st;
End;

Function ReadNVerifyHeader;
Var
 I:Word;
 St:String[2];
Begin
 Q.buf[0]:=Byte('N')xor Byte('G');
 BlockRead(Q.NGf,Q.buf,HeaderSize);
 System.Move(Q.Buf[0],St[1],2);
 St[0]:=#2;
 If St<>'NG'Then Begin
  ReadNVerifyHeader:=5;
  Exit;
 End;
 Q.NmMnus:=GetW(Q,6); Q.NGName:=GetStr(Q,8);
 For I:=0to Pred(CreditsNm)do Q.Credits[I]:=GetStr(Q,48+I*Succ(CreditsStrLen));
 ReadNVerifyHeader:=$FF;
End;

Function ReadNDecryptStruc;
Var
 i,j,k:Word;

 Function Just0(a,z:Wd):Boolean;Begin
  While(Q.buf[a]=0)and(a<z)do Inc(a);
  If Q.buf[a]<>0Then Just0:=No
   Else
  Begin
   Seek(Q.NGf,System.FileSize(Q.NGf));
   Just0:=Ya;
  End;
 End;

Begin
 ReadNDecryptStruc:=$FF;
 If Eof(Q.NGf)Then Exit;
 Q.LastReadPos:=FilePos(Q.NGf);
 BlockRead(Q.NGf,Q.buf[0],FixedStrucSize,j);
 For i:=0to Pred(j)do Q.buf[i]:=Q.buf[i]xor crypto;
 If(j<>FixedStrucSize)or(getW(Q,2)=0)Then
  If Not Just0(0,Pred(j))Then Begin
   ReadNDecryptStruc:=8;
   Exit;
  End
   Else
  Begin
   ID:=99;
   Exit;
  End;
 ID:=getW(Q,0);
 If(ID>MnuID)Then Exit;
 Q.VarStrucSize:=getW(Q,2);
 If Not(Varia2)Then Begin
  Seek(Q.NGf,Q.LastReadPos+$1A+Q.VarStrucSize);
  Exit;
 End;
 BlockRead(Q.NGf,Q.buf[FixedStrucSize],Q.VarStrucSize,j);
 k:=Pred(FixedStrucSize+j);
 For i:=FixedStrucSize to(k)do Q.buf[i]:=Q.buf[i]xor crypto;
 If(j<>Q.VarStrucSize)Then
  If Just0(FixedStrucSize,k)Then Begin
   ID:=99;
   Exit;
  End
   Else
  If Q.VarStrucSize-j<=2Then Begin
   Q.buf[$1A+j]:=0;
   Exit;
  End
  Else Begin;ReadNDecryptStruc:=8;Exit;End;
End;

Procedure GetMnuStruc;
Var
 i,j,it,len:Word;
Begin
 it:=getW(Q,4);
 Q.Mnu[Q.CurrMnu].items:=it-1;
 Q.Mnu[Q.CurrMnu].toptxt:=getNGstr(Q,$1A+4*Pred(it)+8*it,len);
 For i:=0to Pred(it)-1do Begin
  Q.Mnu[Q.CurrMnu].drop[i].fptr:=GetDW(Q,$1A+4*i);
  j:=GetW(Q,$1A+4*Pred(it)+8*i); Q.Mnu[Q.CurrMnu].drop[i].txt:=GetNGstr(Q,$1A+j,len);
 End;
End;

Function RegStrucs;
Var
 i,cnt:Word;
 ParDW:LongInt;
 Xit:Byte;
Begin
 RegStrucs:=$FF;
 Seek(Q.NGf,Q.Mnu[0].drop[0].fptr);
 If IOresult<>0Then Begin RegStrucs:=13; Exit; End;
 _PutFileTxtLn(Q.Scr,'Indexation');
 cnt:=0;
 Repeat
  Xit:=ReadNDecryptStruc(Q,Q.LastID,No);
  If Xit<>$FFThen Begin;RegStrucs:=Xit;Exit;End;
  Case(Q.LastID)of
  ShortID: Inc(Q.NmShort);
   LongID: Inc(Q.NmLong);
  End;
  If Q.LastID=99Then Exit Else If(Q.LastID=MnuID)Then Begin
   RegStrucs:=9;
   Exit;
  End
   Else
  If Not(Q.LastID in[ShortID,LongID])Then Begin
   RegStrucs:=12;
   Exit;
  End;
  ParDW:=getDW(Q,$0A);
  If(Q.LastID=ShortID)or((Q.LastID=LongID)and(ParDW=-1))Then Begin
   Inc(Q.OutFilesNm);Q.Src^.ID:=Q.LastID;Q.Src^.FileOfs:=Q.LastReadPos;
   Q.Src^.ParPtr:=ParDW;
   If(Q.LastID=LongID)Then Q.Src^.FirstPtr:=Q.LastReadPos Else Q.Src^.FirstPtr:=-1;
   Q.Src^.LastPtr:=Q.Src^.FirstPtr; Q.Src^.TgtFile:=Q.OutFilesNm; Q.Src^.Next:=NIL;
   If(Q.Src<>Q.sr1)Then Q.srp^.Next:=Q.Src;
   Q.srp:=Q.Src;
   New(Q.Src);
  End
   Else
  Begin
   Q.Sra:=Q.sr1;
   While(Q.sra^.FileOfs<>ParDW)and(Q.sra<>NIL)do Q.sra:=Q.sra^.next;
   If(Q.sra^.FileOfs=ParDW)Then Begin
    If Q.sra^.FirstPtr=-1Then Begin Q.sra^.FirstPtr:=Q.LastReadPos;Q.sra^.LastPtr:=Q.LastReadPos;End
     Else
    Begin
     If(Q.sra^.FirstPtr>Q.LastReadPos)Then Q.sra^.FirstPtr:=Q.LastReadPos;
     If(Q.sra^.LastPtr<Q.LastReadPos)Then Q.sra^.LastPtr:=Q.LastReadPos;
    End;
   End
    Else
   _PutFileTxtLn(Q.reptf,'ATTENTION: Le Parent est introuvable '+HexLong2Str(Q.LastReadPos));
  End;
  Inc(cnt);
  If cnt mod 10=0Then _PutFileTxt(Q.Scr,'.');
  If cnt mod 500=0Then _PutFileLn(Q.Scr);
 Until Eof(Q.NGf);
 _PutFileLn(Q.Scr);
End;

Procedure LstStats;Begin
 _PutFileTxtLn(f,Q.InName);
 _PutFileTxtLn(f,Q.NGName);
 _PutFileLn(f);
 _PutFileTxtLn(f,'Taille du fichier: '+'  '+IntToStr(Q.FS)+' ('+HexLong2Str(Q.FS)+'h)');
 _PutFileTxtLn(f,Str2(Q.NmMnus,8)+' menu(s)');
 _PutFileTxtLn(f,Str2(Q.NmShort,8)+' petite structure(s)');
 _PutFileTxtLn(f,Str2(Q.NmLong,8)+' longue structure(s)');
 _PutFileTxtLn(f,' --> '+Str2(Q.OutFilesNm,3)+' fichiers.');
 _PutFileLn(f);
End;

Procedure LstPtrs;
Var
 sra:StrucRecPtr;
Begin
 sra:=Q.sr1;
 _PutFileLn(f);
 _PutFileTxtLn(f,'Les nombres sont en hexadÇcimal, Ö l''exception du numÇro de fichier');
 _PutFileTxtLn(f,'destinataire');
 _PutFileLn(f);
 _PutFileTxtLn(f,'ID    FileOffs  1stptr    Lastptr   Tgt  Parent');
 While(sra<>NIL)do Begin
  _PutFileTxt(f,HexWord2Str(sra^.ID)+'  '+HexLong2Str(sra^.FileOfs)+'  ');
  _PutFileTxt(f,HexLong2Str(sra^.FirstPtr)+'  '+HexLong2Str(sra^.LastPtr)+'  ');
  _PutFileTxtLn(f,Str0(sra^.TgtFile,3)+'  '+HexLong2Str(sra^.ParPtr));
  sra:=sra^.next;
 End;
 _PutFileLn(f);
End;

Function LookUpFileNO;
Var
 sra:StrucRecPtr;
Begin
 sra:=Q.sr1;
 While(sra^.FileOfs<>fp)and(sra<>NIL)do sra:=sra^.next;
 If(sra^.FileOfs=fp)Then LookUpFileNO:=sra^.TgtFile
                    Else LookUpFileNO:=999;
End;

Function LookupRef(Var Q:NGZRec;fp:Long):Word;
Var
 sra:StrucRecPtr;
 Ok:Boolean;
Begin
 sra:=Q.sr1;Ok:=No;
 While Not(Ok)and(sra<>NIL)do
  If(fp>=sra^.FirstPtr)and(fp<=sra^.LastPtr)Then Ok:=Ya Else sra:=sra^.next;
 If(Ok)Then LookupRef:=sra^.TgtFile Else LookupRef:=999;
End;

Procedure ProcessLongStruc(Var Q:NGZRec;Var f:Hdl;CurrFile:Wd;lookup:Bool);
Var
 lines,ix,j,k,len,SAOfs,Sano:Word;
Begin
 ix:=FixedStrucSize;lines:=getW(Q,4);
 For j:=0to Pred(lines)do Begin
  _PutFileTxtLn(f,getNGstr(Q,ix,len));
  Inc(ix,Succ(len));
 End;
 If Not(lookup)or(GetW(Q,6)=0)Then Exit;
 SAOfs:=FixedStrucSize+GetW(Q,6); Sano:=GetW(Q,SAOfs);
 If Sano=0Then Exit;
 _PutFileTxt(f,'!Seealso:');
 ix:=SAOfs+2+Sano*4;
 For j:=0to Pred(Sano)do Begin
  k:=LookupRef(Q,GetDW(Q,SAOfs+2+j*4));
  If(k<>CurrFile)Then Begin
   _PutFileTxt(f,Q.fprefix+Str0(k,3)+ExtNGO+':');
   If k=999Then _PutFileTxtLn(Q.Reptf,'Non rÇsolu S/A (Fichier: '+Str0(CurrFile,3)+')');
  End;
  _PutFileTxt(f,'"'+getNGstr(Q,ix,len)+'"  ');
  Inc(ix,Succ(len));
 End;
 _PutFileLn(f);
End;

Function ProcessStruc;
Var
 it,i,len,num,itc:Word;
 srt:StrucRecPtr;
 caption:String;
 EntryPos:LongInt;
 Xit:Byte;
Begin
 ProcessStruc:=$FF;
 _PutFileTxtLn(Q.Scr,'Fichier: '+Q.fprefix+Str0(FileNo,3)+ExtASC);
 Seek(Q.NGf,fpos);
 Xit:=ReadNDecryptStruc(Q,Q.LastID,Ya);
 If Xit<>$FFThen Begin ProcessStruc:=Xit; End;
 If(Q.LastID>MnuID)Then Begin ProcessStruc:=12; Exit; End;
 If(Q.LastID=LongID)Then Begin
  _PutFileTxtLn(Q.Scr,'l');
  ProcessLongStruc(Q,datf,FileNo,lookup);
  Exit;
 End;
 it:=getW(Q,4);
 System.Move(Q.buf,Q.sbuf,FixedStrucSize+GetW(Q,2));
 For itc:=0to Pred(it)do Begin
  caption:=GetNGStrS(Q,$1A+GetWS(Q,$1A+itc*6),len);EntryPos:=GetLS(Q,$1A+2+itc*6);
  _PutFileTxtLn(datf,'!Short:'+caption);
  If EntryPos=-1Then Else If LookUpFileNO(Q,EntryPos)=999Then Begin
   If itc=0Then _PutFileTxt(Q.Scr,'s');
   _PutFileTxt(Q.Scr,'l');
   Seek(Q.NGf,EntryPos);
   Xit:=ReadNDecryptStruc(Q,Q.LastID,Ya);
   If Xit<>$FFThen Begin ProcessStruc:=Xit; End;
   ProcessLongStruc(Q,datf,FileNo,lookup)
  End
   Else
  Begin
   srt:=Q.sr1;
   While(srt^.TgtFile<>LookUpFileNO(Q,EntryPos))and(srt<>NIL)do srt:=srt^.next;
   If srt^.TgtFile=LookUpFileNO(Q,EntryPos)Then srt^.txt:=caption Else srt^.txt:='';
   _PutFileTxt(Q.Scr,'f');
   _PutFileTxtLn(datf,'!File:'+Q.fprefix+Str0(LookUpFileNO(Q,EntryPos),3)+ExtNGO);
  End;
 End;
 _PutFileLn(Q.Scr);
End;

{ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ}
END.