Program NGZ; { DÇsassembleur de fichier de donnÇe du Guide Norton }
{ Usage: NGZ ngfile.ng [/?][/R|/Poffs[/Q]] }

Uses Dos,Systex,Systems,ToolNGZ;

Procedure Xit(Var Q:NGZRec;X:Byte);
 Procedure WriteUsg; Begin Writeln('Syntaxe: NGZ ngfile.ng [/?][/R|/Poffset[/Q]]'); End;
Begin
 If X=$FFThen Exit;
 If(X=0)or(X>=5)Then Begin
  System.Close(Q.NGf);
  Close(Q.Scr);
 End;
 If Not(Q.IsPartial)and(X in[8,12])Then Begin
  LstPtrs(Q,Q.reptf);
  Close(Q.reptf);
 End;
 If X>2Then Write('Erreur: ');
 Case X of
  0: WriteLn('Terminer.');
  1: Begin
      WriteUsg;
      WriteLn('  /?  Affiche l''aide actuel');
      WriteLn('  /R  Le rapport seulement (',ExtRPT,')');
      WriteLn('  /Poffset  DÇsassemble partiellement le fichier Ö cette offset (en hex).');
      WriteLn('      Fait d''abord un rapport avant de demander par l''offset.');
      WriteLn('      Ne l''utilisez pas dans un menu ou une petite-Ö-petite structures.');
      WriteLn('  /Q  Supprime la sortie d''Çcran (Remarque: Ctrl+C est inactif)');
      WriteLn;
      X:=0;
     End;
  2: WriteUsg;
  4: WriteLn('Fichier introuvable!');
  5: WriteLn('Ce n''est pas un fichier de donnÇe NG valide.');
  8: WriteLn('Fin de fichier attentue.');
  9: WriteLn('Mauvaise structure de menu.');
 12: WriteLn('Identificateur de structure inconnue (',Q.LastID,').');
 13: WriteLn('Mauvais positionnement.');
 End;
 Halt(X);
End;

Var i,j,ThisNm:Wd; ThisPos:Long; x0:^NGZRec; CurrMnu,CurrItem:Wd;
BEGIN
 WriteLn('NGZ 1.0  DÇsassembleur des fichiers de donnÇe NG (Norton Guide)');
 WriteLn('         Tous droits rÇservÇs par les Chevaliers de Malte (C) 1996');
 WriteLn;
 x0:=MemAlloc(SizeOf(NGZRec));
 x0^.rc:=ParseCmd(x0^,x0^.InName);
 If(x0^.IsInfReq)Then Xit(x0^,1);
 If x0^.rc>0Then Xit(x0^,2);
 If(x0^.IsReptOnly)Then x0^.IsPartial:=No;
 Assign(x0^.NGf,x0^.InName);
 FileMode:=0;
 Reset(x0^.NGf,1);
 If IOresult<>0Then Xit(x0^,4);
 x0^.FS:=System.FileSize(x0^.NGf); x0^.NmShort:=0; x0^.NmLong:=0;
 x0^.OutFilesNm:=0; x0^.fprefix:='____'; i:=Length(x0^.InName); j:=1;
 While(i>1)and Not(x0^.InName[i-1]in[':','\'])do Dec(i);
 While(x0^.InName[i]<>'.')and(j<=4)do Begin x0^.fprefix[j]:=x0^.InName[i]; Inc(i); Inc(j); End;
 If(x0^.IsQuiet)Then x0^.Scr:=hdlNUL Else x0^.Scr:=hdlSCR;
 If(x0^.IsPartial)Then Begin
  x0^.sr1:=NIL;
  x0^.datf:=New(x0^.fprefix+'112'+ExtASC);
  Xit(x0^,ProcessStruc(x0^,x0^.datf,x0^.PartialOfs,112,No));
  Close(x0^.datf);
  Xit(x0^,0);
 End;
 FindFirst(x0^.fprefix+'*.*',Archive,x0^.DirInf);
 If(DosError=0)and(Pos(ExtNG,x0^.DirInf.Name)=0)Then Begin
  _PutFileTxtLn(x0^.Scr,'* ATTENTION *');
  _PutFileTxtLn(x0^.Scr,'Le rÇpertoire courant Ö des fichiers comme '+x0^.fprefix+'*.*');
  _PutFileTxtLn(x0^.Scr,'Presse Break (Ctrl+C) maintenant pour Çviter que je rÇÇcrive les fichiers.');
  _PutFileLn(x0^.Scr);
 End;
 If(x0^.IsReptOnly)Then _PutFileTxtLn(x0^.Scr,'Seulement le rapport');
 x0^.ReptF:=New(x0^.fprefix+ExtRPT);
 Xit(x0^,ReadNVerifyHeader(x0^));
 x0^.CurrMnu:=0;
 Repeat
  Xit(x0^,ReadNDecryptStruc(x0^,x0^.LastID,Ya));
  If(x0^.LastID=MnuID)Then Begin
   GetMnuStruc(x0^);
   Inc(x0^.CurrMnu);
  End;
 Until(x0^.CurrMnu=x0^.NmMnus)or(x0^.LastID<>MnuID)or Eof(x0^.NGf);
 If(x0^.CurrMnu<>x0^.NmMnus)Then Xit(x0^,9);
 If(x0^.LastID>MnuID)Then Xit(x0^,12);
 x0^.src:=NIL;
 Mark(x0^.srm);
 System.New(x0^.src);
 x0^.sr1:=x0^.src;
 Xit(x0^,RegStrucs(x0^));
 LstStats(x0^,x0^.Scr);
 x0^.sra:=x0^.sr1;
 While(x0^.sra<>NIL)do Begin
  If(x0^.IsReptOnly)Then x0^.datf:=hdlNUL Else x0^.DatF:=New(x0^.fprefix+Str0(x0^.sra^.TgtFile,3)+ExtASC);
  Xit(x0^,ProcessStruc(x0^,x0^.datf,x0^.sra^.FileOfs,x0^.sra^.TgtFile,Ya));
  Close(x0^.datf);
  x0^.sra:=x0^.sra^.next;
 End;
 For CurrMnu:=0to Pred(x0^.NmMnus)do For CurrItem:=0to Pred(x0^.Mnu[CurrMnu].items)do Begin
  ThisPos:=x0^.Mnu[CurrMnu].drop[CurrItem].fptr; ThisNm:=LookUpFileNO(x0^,ThisPos);
  x0^.Mnu[CurrMnu].drop[CurrItem].datn:=ThisNm; x0^.sra:=x0^.sr1;
  While(x0^.sra^.TgtFile<>ThisNm)and(x0^.sra<>NIL)do x0^.sra:=x0^.sra^.next;
  If(x0^.sra^.TgtFile=ThisNm)Then
   x0^.sra^.txt:=Left(x0^.Mnu[CurrMnu].toptxt,8)+': '+x0^.Mnu[CurrMnu].drop[CurrItem].txt;
 End;
 _PutFileTxtLn(x0^.Scr,'êcrit le fichier de rapport');
 LstStats(x0^,x0^.reptf);
 LstPtrs(x0^,x0^.reptf);
 x0^.sra:=x0^.sr1;
 While(x0^.sra<>NIL)do Begin
  _PutFileTxtLn(x0^.reptf,x0^.fprefix+Str0(x0^.sra^.TgtFile,3)+ExtASC+': '+x0^.sra^.txt);
  x0^.sra:=x0^.sra^.next;
 End;
 Close(x0^.reptf);
 If Not(x0^.IsReptOnly)Then Begin
  _PutFileTxtLn(x0^.Scr,'êcrit les fichiers de liens et de fabrication');
  WriteLnkFile(x0^);
  WriteMakeFile(x0^);
 End;
 Release(x0^.srm);
 Xit(x0^,0);
 FreeMem(x0,SizeOf(NGZRec));
END.