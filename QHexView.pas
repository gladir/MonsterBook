{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                                                                         Û
 ³                      Malte Genesis/QuickHexView                         Û
 ³                                                                         Û
 ³            dition Chantal pour Mode R‚el/IV - Version 1.1              Û
 ³                              1994/12/30                                 Û
 ³                                                                         Û
 ³          Tous droits r‚serv‚s par les Chevaliers de Malte (C)           Û
 ³                                                                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Nom du programmeur
 ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ

  Sylvain Maltais


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette unit‚ est utiliser pour visualiser de fa‡on hexad‚cimal des donn‚es
 divers originaire du disque.
}

Unit QHexView;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                                  INTERFACE
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

{$I DEF.INC}

Uses {$IFDEF __Windows__}
      WinProcs,WinTypes,
     {$ENDIF}
     Systex,Isatex,Dialex;

Const
 HexViewNumXTxts=74; {Largeur de la boŒte de dialogue visualisateur hexad‚cimal}
 HexViewNumYTxts=21; {Hauteur de la boŒte de dialogue visualisateur hexad‚cimal}

Function  HVInit(Var Q:HexEditApp;X,Y:Byte;Const Name:String):Boolean;
Procedure HVLoad(Var Q;X1,Y1,X2,Y2:Byte;Const Name:String);
Function  HVSave(Var QX):Boolean;
Function  HVRun(Var Qx):Wd;
Function  HVGetPath(Var Q:HexEditApp):PathStr;
Procedure HVEditMode(Var Q:HexEditApp;X:Boolean);
Procedure HVGotoLine(Var Q:HexEditApp;Line:Byte);
Procedure HVGotoRow(Var Q:HexEditApp;Row:Byte);
Procedure HVRefresh(Var Qx);
Procedure HVFiltre(Var Q:HexEditApp);
Function  HVTitle(Var Context;Max:Byte):String;
Procedure HVMove2(Var Context;X,Y:Byte);
Function  HVDone(Var Q):Word;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                               IMPLEMENTATION
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Uses
 Adele,Memories,SysInter,Systems,Video,Dials,Sourcer,Disk,
 DialPlus,ResTex,ResServD,Mouse,Math;

Procedure HVPutCurrRec(Var Q:HexEditApp);Near;Forward;
{$I \Source\Chantal\Library\Disk\Bios\ReadPart.Inc}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                             Fonction HVInit                           Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet d'initialiser l'object de visualisation de donn‚es
 hexad‚cimal.


 Remarque
 ÍÍÍÍÍÍÍÍ

  ş Les formats de fichiers  pour acc‚der  au disque  doit avoir le format
    suivant:
    ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
    ³ Syntaxe                         ³ Description                      ³
    ÆÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍµ
    ³ unit‚:[DSK]                     ³ AccŠs direct  DOS … la  FAT d'un ³
    ³                                 ³ unit‚ logique                    ³
    ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
    ³ unit‚phys:[PARTITION]|partition ³ AccŠde … paritition  directement ³
    ³                                 ³ sans   utiliser    le    systŠme ³
    ³                                 ³ d'exploitation.                  ³
    ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
}

Function HVInit;
Var
 Handle:Hdl;
 ParSec:PartSec;
Begin
 If(MaxXTxts<HexViewNumXTxts)Then Begin
  ErrNoMsgOk(errScrnTooSmallForApp);
  HVInit:=False;
  Exit;
 End;
 HVInit:=True;
 FillClr(Q,SizeOf(Q));
 Q.ViewName:=Name;
 Q.Moved:=True;
 If Pos('[PARTITION]',StrUp(Q.ViewName))>0Then Begin
  Q.FS.Dsk:=(Byte(Q.ViewName[1])-Byte('0'))+$80;
  Q.DskView:=True;
  Q.Partition:=Byte(Q.ViewName[Length(Q.ViewName)])-Byte('0');
  ReadPartSec(Q.FS.Dsk,0,1,ParSec);
  GetSectCyl(ParSec.PartTable[Q.Partition].StartSec.SectCyl,Q.SectorMin,Q.TrackMin);
  Q.HeadMin:=ParSec.PartTable[Q.Partition].StartSec.Tete;
  GetSectCyl(ParSec.PartTable[Q.Partition].EndSec.SectCyl,Q.SectorMax,Q.TrackMax);
  Q.HeadMax:=ParSec.PartTable[Q.Partition].EndSec.Tete;
  Q.CurrTrack:=Q.TrackMin;Q.CurrHead:=Q.HeadMin;Q.CurrSector:=Q.SectorMin;
  Q.MaxRec:=ParSec.PartTable[Q.Partition].NbreSec;
 End
  else
 Begin
  Q.DskView:=Pos('[DSK]',StrUp(Q.ViewName))>0;
  Q.FS.Dsk:=Path2Dsk(Q.ViewName);
  Q.Partition:=$FF;
  Q.Mount:=DriveFormat[Q.FS.Dsk]=dfiMount;
  If(Q.Mount)Then Begin
   Q.ViewName:=StrPas(DriveMount[Q.FS.Dsk]);
   If FSOpen(Q.FS,Q.ViewName,True)Then FileClose(Q.FS.Handle);
  End;
 End;
 WEInit(Q.W,X,Y,X+HexViewNumXTxts,Y+HexViewNumYTxts);
 {$IFNDEF H}WEPushWn(Q.W);{$ENDIF}
 HVRefresh(Q);
End;

Procedure HVLoad(Var Q;X1,Y1,X2,Y2:Byte;Const Name:String);Begin
 HVInit(HexEditApp(Q),X1,Y1,Name);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                            Proc‚dure HVRefresh                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet r‚actualiser l'affichage l'object de visualisation
 de donn‚es hexad‚cimal.
}

Procedure HVRefresh;
Var
 I,J:Byte;             { Compteur de boucle }
 Handle:Hdl;
 FS:Long;
 Buffer:Array[0..511]of Byte;
 Q:HexEditApp Absolute Qx;
 GX1,GY1,GX2,GY2:Word; { Coordonn‚e graphiques }
Begin
 If(Q.DskView)Then Begin
  If Q.Partition=$FFThen Begin
   ReadDsk(Q.FS.Dsk,0,1,Buffer);
   FillClr(Q.MaxRec,SizeOf(Q.MaxRec));
   MoveLeft(Buffer[19],Q.MaxRec,2);
   If Q.MaxRec=0Then MoveLeft(Buffer[$20],Q.MaxRec,4);
   FS:=Q.MaxRec*512;
   If(Q.Mode=Hex)Then Q.MaxRec:=Q.MaxRec shl 1;
   Dec(Q.MaxRec);
  End;
 End
  Else
 Begin
  Handle:=FileOpen(Q.ViewName,fmRead);
  FS:=FileSize(Handle);
  If(Q.Mode=Hex)Then Begin
   Q.MaxRec:=(FS shr 8)-1;
   If FS and$FF>0Then Inc(Q.MaxRec);
  End
   Else
  Begin
   Q.MaxRec:=(FS shr 10)-1;
   If FS and 1023>0Then Inc(Q.MaxRec);
  End;
  FileClose(Handle);
 End;
 WEPutWn(Q.W,HVTitle(Q.W,Q.W.MaxX),CurrKrs.HexView.Window);
 WECloseIcon(Q.W);
 WEPutBarMsRight(Q.W);
 WEBar(Q.W);
 WEPutSmlTxtXY(Q.W,0,1,'Courant:');
 WEPutSmlTxtXY(Q.W,20,1,'Maximum:');
 WEPutSmlTxtXY(Q.W,40,1,'Taille:');
 If(IsGrf)and(Not HoleMode)Then Begin
  GY1:=GetRawY(5)shr 1;
  GX2:=((HexViewNumXTxts-2)shl 3)-1;
  WEPutLnHor(Q.W,0,GY1,GX2,Black);
  WEPutLnHor(Q.W,0,GY1+1,GX2,White);
 End
  Else
 WEPutTxtXY(Q.W,0,2,MultChr('Ä',HexViewNumXTxts-1));
 WESetKrHigh(Q.W);
 WEPutTxtXY(Q.W,30,1,HexLong2Str(Q.MaxRec));
 WEPutTxtXY(Q.W,49,1,CStr(FS)+' octet(s)');
 If(IsGrf)and(Not HoleMode)Then Begin
  If(Q.Mode=Hex)Then Begin
   GX1:=(WEGetRX1(Q.W)+7+16*3)shl 3;GX2:=GX1+((16)shl 3);Dec(GX1);
   GY1:=GetRawY(WEGetRY1(Q.W)+4);GY2:=GY1+GetRawY(16);Dec(GY1);
   GraphBoxRelief(GX1,GY1,GX2,GY2,1);
   WEClrWn(Q.W,7+16*3,4,wnMax-1,wnMax,CurrKrs.Dialog.Env.List.Border);
   WESetKr(Q.W,CurrKrs.Dialog.Env.List.Border);
   GX1:=((WEGetRX1(Q.W)+7)shl 3)-1;
   For I:=0to 15do Begin
    GraphBoxRelief(GX1,GY1,GX1+1+(2 shl 3),GY2,1);
    WEClrWn(Q.W,7+I*3,4,7+I*3+1,4+15,CurrKrs.Dialog.Env.List.Border);
    Inc(GX1,8*3);
   End;
  End
   Else
  Begin
   WEClrWn(Q.W,7,4,wnMax-1,wnMax,CurrKrs.Dialog.Env.List.Border);
   GX1:=(WEGetRX1(Q.W)+7)shl 3;GX2:=GX1+((64)shl 3);Dec(GX1);
   GY1:=GetRawY(WEGetRY1(Q.W)+4);GY2:=GY1+GetRawY(16);Dec(GY1);
   GraphBoxRelief(GX1,GY1,GX2,GY2,1);
  End;
 End
  Else
 WEClrWn(Q.W,7,4,wnMax,wnMax,CurrKrs.HexView.Window.High);
 If(Q.Mode=Hex)Then Begin
  WESetKrBorder(Q.W);
  WEPutSmlTxtXY(Q.W,7,3,'0  1  2  3  4  5  6  7  8  9  A  B  C  D  E  F  0123456789ABCDEF');
  For J:=0to 15do WEPutSmlTxtXY(Q.W,0,J+4,HexWord2Str(J*16)+' -');
 End
  Else
 For J:=0to 15do WEPutSmlTxtXY(Q.W,0,J+4,HexWord2Str(J*64)+' -');
 WESetKrHigh(Q.W);
 SetAllKr($1B,$1F);
 Case(Q.Mode)of
  Hex: WEPutLastBar('^F1^ Aide  ^F9^ Edit  ^F10^ Mode Plain');
  Else WEPutLastBar('^F1^ Aide  ^F9^ Edit  ^F10^ Mode Hexad‚cimal');
 End;
 HVPutCurrRec(Q);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Fonction HVGetPath                     Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de connaŒtre le nom du fichier actuellement
 en utilisation sous l'objet de visualisation hexad‚cimal.
}

Function HVGetPath;Begin
 HVGetPath:=Q.ViewName;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                       Proc‚dure HVEditMode                   Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de fixer le mode d'‚dition de l'‚diteur/
 visualisateur hexad‚cimal.
}

Procedure HVEditMode(Var Q:HexEditApp;X:Boolean);Begin
 Q.EditMode:=X;
End;

Procedure HVGotoLine(Var Q:HexEditApp;Line:Byte);Begin
 Q.Y:=Line And $F;
End;

Procedure HVGotoRow(Var Q:HexEditApp;Row:Byte);Begin
 If(Q.Mode=Hex)Then Q.X:=Row And $F
               Else Q.X:=Row And $3F;
End;

{Applique l'interpr‚tation binaire appropri‚ si l'utilisateur le souhaite}
Procedure HVSetting(Var Q:HexEditApp;Size:Word;Var Buffer);
Var
 I:Word;
 BufferSec:Array[0..511]of Byte Absolute Buffer;
Begin
 If(Q.Operator.NotOp)Then For I:=0to 511do BufferSec[I]:=Not BufferSec[I];
 If(Q.Operator.XorOp)Then For I:=0to 511do BufferSec[I]:=$80 xor BufferSec[I];
 If(Q.Operator.OrOp)Then For I:=0to 511do BufferSec[I]:=$80 or BufferSec[I];
 If(Q.Operator.AndOp)Then For I:=0to 511do BufferSec[I]:=BufferSec[I]and $7F;
End;

Procedure HVReadCurrRec(Var Q:HexEditApp;Size:Word;Var Buffer);
Var
 Handle:Hdl;
 I:Byte;
 Head,SecCyl:Word;
 BufferSec:Array[0..3,0..511]of Byte Absolute Buffer;
Begin
 Repeat
  If(Q.DskView)Then Begin
   If(Q.Mount)Then Begin
    Handle:=FileOpen(Q.ViewName,fmRead);
    If(Handle<>errHdl)Then Begin
     _GetAbsRec(Handle,Q.FS.FileStart+Mul2Word(Q.CurrRec,Size),Size,Buffer);
     FileClose(Handle);
    End;
   End
    Else
   Begin
    If Q.Partition=$FFThen Begin
     Case(Size)of
      1024:For I:=0to 1do ReadDsk(Q.FS.Dsk,Q.CurrRec*2+I,1,BufferSec[I]);
      256:ReadDsk(Q.FS.Dsk,Q.CurrRec shr 1,1,Buffer);
      Else ReadDsk(Q.FS.Dsk,Q.CurrRec,1,Buffer);
     End;
    End
     Else
    Begin
     Head:=Q.CurrHead+((Q.CurrTrack shr 10)shl 6);
     SecCyl:=Q.CurrSector+
             (Lo(Q.CurrTrack)shl 8)+
             ((Hi(Q.CurrTrack)and 3)shl 6);
     ReadPartSec(Q.FS.Dsk,Head,SecCyl,Buffer);
    End;
    If Size=256Then Begin
     If Q.CurrRec and 1=1Then MoveLeft(BufferSec[0,256],BufferSec[0],256);
    End;
   End;
  End
   else
  GetFile(Q.ViewName,Q.CurrRec,Size,Buffer);
  If GetSysErr<>0Then If kbCancel=__DiskNotReady(Q.FS.Dsk+1)Then Exit;
 Until GetSysErr=0;
 HVSetting(Q,Size,Buffer);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                     Proc‚dure HVPutCurrRec                    Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet d'afficher l'enregistrement courant ‚tant
 actuellement en utilisation dans le visualisateur hexad‚cimal.
}

Procedure HVPutCurrRec;
Var
 Handle:Hdl;
 BufferSec:Array[0..3,0..511]of Byte;
 Buffer:Array[0..15,0..63]of Char Absolute BufferSec;
 I,J,X:Byte;
 BufferHex:Array[0..15,0..15]of Byte Absolute Buffer;
Begin
 WEPutTxtXY(Q.W,10,1,HexLong2Str(Q.CurrRec));
 If Not(Q.Moved)Then Begin
  MoveLeft(Q.Buffer,Buffer,SizeOf(Q.Buffer));
 End;
 If(Q.Mode=Hex)Then Begin
  If(Q.Moved)Then HVReadCurrRec(Q,256,Buffer);
  For J:=0to 15do For I:=0to 15do Begin
   X:=BufferHex[J,I];
   WEPutTxtXYU(Q.W,7+I*3,J+4,HexByte2Str(X));
   If X=0Then X:=Byte(' ');
   WESetChr(Q.W,7+16*3+I,J+4,Char(X));
  End;
 End
  Else
 Begin
  HVReadCurrRec(Q,1024,Buffer);
  For J:=0to 15do For I:=0to 63do WESetChr(Q.W,7+I,J+4,Buffer[J,I]);
 End;
 If(Q.Moved)Then Begin
  MoveLeft(Buffer,Q.Buffer,SizeOf(Q.Buffer));
  MoveLeft(Buffer,Q.ModBoard,SizeOf(Q.ModBoard));
  Q.Moved:=False;
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Proc‚dure LookBoot                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure offre la possibilit‚ de visualiser la partie d‚marrable
 d'une unit‚ de  disque quelconque  avec un d‚sassemblage du code machine
 si trouvant.
}

Type
 WinBootDataRec=Record
  Buf:Array[0..2047]of Byte;
  PChr:Array[Byte]of Char;
  NmSec:Long;
 End;

Procedure LoadCodeMachine(Var L:LstMnu;Var Context);
Var
 I,J,K:Wd;
 S,S2:String;
 Q:WinBootDataRec Absolute Context;
Begin
 If(Q.Buf[510]=$55)and(Q.Buf[511]=$AA)Then Begin
   {D‚sassemblage de la partie en code machine}
  K:=Q.Buf[1]+2;
  While K<510do Begin
   S:='07C0h:'+HexWord2Str(K)+'h ';
   I:=K;
   S2:=Decode(Q.Buf,K);
   For J:=0to K-I-1do AddStr(S,HexByte2Str(Q.Buf[I+J]));
   AddStr(S,Spc(16-(J shl 1)));
   ALAddStr(L.List,S+S2);
  End;
 End
  Else
 ALAddStr(L.List,'Pas de code d‚marrage!');
End;

Procedure LookBoot(Var QX:HexEditApp;Dsk:Byte);
Var
 Q:WinBootDataRec;
 Boot:BootRec Absolute Q;
 Data:Record
  CaptionOEM:String[20];
  CaptionSizeSector:String[20];
  CaptionSectorPerCluster:String[30];
  CaptionNumHead:String[20];
  CaptionNumTotalSector:String[50];
  CaptionSectorHidden:String[50];
  CaptionNumFAT:String[50];
  CaptionEntry:String[10];
  CaptionTypeMedia:String[50];
  CaptionVolumeName:String[60];
  CodeMachine:Wd;
  LoadCodeMachine:Procedure(Var L:LstMnu;Var Context);
  OnMoveCodeMachine:Procedure(Var L:LstMnu;Var Context);
  ContextCodeMachine:Pointer;
 End;
 Head,SecCyl:Word;
Begin
 FillClr(Data,SizeOf(Data));
 HVReadCurrRec(QX,512,Q.Buf);
 MoveLeft(Boot.OEMName,Q.PChr,SizeOf(Boot.OEMName));
 Q.PChr[SizeOf(Boot.OEMName)]:=#0;
 Data.CaptionOEM:=StrPas(@Q.PChr);
 Data.CaptionSizeSector:=CStr(Boot.BytesPerSec)+' octets';
 Data.CaptionSectorPerCluster:=CStr(Boot.SecPerCluster)+
	      ', secteur par piste:'+CStrBasic(Boot.SecPerTrk);
 Data.CaptionNumHead:=CStr(Boot.NmHeads);
 If Boot.NmTotSec=0Then Q.NmSec:=Boot.HughNmSec
                   Else Q.NmSec:=Boot.NmTotSec;
 Data.CaptionNumTotalSector:=CStr(Q.NmSec)+
	      ', secteur r‚serv‚:'+CStrBasic(Boot.NmResSecs);
 Data.CaptionSectorHidden:=CStr(Boot.NmHiddenSec);
 Data.CaptionNumFAT:=CStr(Boot.NmFAT)+
     	             ', secteur par FAT:'+CStrBasic(Boot.SecPerFAT);
 Data.CaptionEntry:=CStr(Boot.NmRootDirEntries);
 Case Byte(Boot.Media)of
dskMediaDbl8SecTrk:AddStr(Data.CaptionTypeMedia,'Disquette double face, 8 secteurs/piste');
dskMediaSmp8SecTrk:AddStr(Data.CaptionTypeMedia,'Disquette simple face, 8 secteurs/piste');
dskMediaDbl9SecTrk:AddStr(Data.CaptionTypeMedia,'Disquette double face, 9 secteurs/piste');
dskMediaSmp9SecTrk:AddStr(Data.CaptionTypeMedia,'Disquette simple face, 9 secteurs/piste');
dskMediaDbl15SecTrk:AddStr(Data.CaptionTypeMedia,'Disquette double face, 15 secteurs/piste');
dskMediaHardDsk:AddStr(Data.CaptionTypeMedia,'Disque dur');
Else AddStr(Data.CaptionTypeMedia,'Inconnu');
 End;
 MoveLeft(Boot.VolumeName,Q.PChr,SizeOf(Boot.VolumeName));
 Q.PChr[SizeOf(Boot.VolumeName)]:=#0;
 Data.CaptionVolumeName:=RTrim(StrPas(@Q.PChr))+
 ', le num‚ro de S‚rie est '+_GetSerialNmStr(Boot.SerialNm);
 Data.LoadCodeMachine:=LoadCodeMachine;
 Data.ContextCodeMachine:=@Q;
 ExecuteAppDPU(74,Data);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                       Proc‚dure HVSave                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de sauvegarder les donn‚es modifi‚es par
 l'utilisateur dans le bloque courant de l'objet de visualisation
 hexad‚cimal.
}

Function HVSave;
Var
 I,J:Byte;
 Head,SecCyl:Word;
 Q:HexEditApp Absolute QX;
Begin
 HVSave:=False;
 If(Q.Modified)Then Begin
  If(Q.Mode=Hex)Then Begin
   If Not(Q.Moved)Then Repeat
    If(Q.DskView)Then Begin
     If Q.Partition=$FFThen {WriteDsk(Q.Dsk,Q.CurrRec shr 1,1,Q.ModBoard)}
      Else
     Begin
      Head:=Q.CurrHead+((Q.CurrTrack shr 10)shl 6);
      SecCyl:=Q.CurrSector+
              (Lo(Q.CurrTrack)shl 8)+
              ((Hi(Q.CurrTrack)and 3)shl 6);
      {WritePartSec(Q.Dsk,Head,SecCyl,Q.ModBoard);}
     End;
    End
     else
    SetFile(Q.ViewName,Q.CurrRec,256,Q.ModBoard);
    If GetSysErr<>0Then If kbCancel=__DiskNotReady(Q.FS.Dsk+1)Then Exit;
   Until GetSysErr=0;
  End
   Else
  Begin
   If Not(Q.Moved)Then Repeat
    If(Q.DskView)Then {For I:=0to 1do WriteDsk(Q.Dsk,Q.CurrRec*2+I,1,Q.ModBoard[I shl 9])}
	         Else SetFile(Q.ViewName,Q.CurrRec,1024,Q.ModBoard);
    If GetSysErr<>0Then If kbCancel=__DiskNotReady(Q.FS.Dsk+1)Then Exit;
   Until GetSysErr=0;
  End;
  HVRefresh(Q);
  Q.Modified:=False;
 End;
 HVSave:=True;
End;

Procedure HVManuelStruct(Var Q:HexEditApp);
Const
 msBinary=$0001;      { D‚composeur binaire }
 msTagTiff=$0002;     { TAG d'entˆte TIFF }
 msHeaderBitMap=$0003;{ Entˆte de BitMap Windows }
Var
 L:LstMnu;
 K:Word;

 Function Start:Word;Begin
  If Not(Q.EditMode)Then Start:=0 Else
  If(Q.Mode=Hex)Then Start:=Q.X+(Q.Y shl 4)
                Else Start:=Q.X+(Q.Y shl 6);
 End;

 Procedure Binary;
 Var
  I:Word;
 Begin
  LMInitCenter(L,16,NmYTxts-5,'Binaire',CurrKrs.Dialog.Env.List);
  I:=Start;
  Repeat
   ALAddStr(L.List,BinByte2Str(Q.Buffer[I]));
   Inc(I);
  Until I>512;
  LMRun(L);
  LMDone(L);
 End;

 Procedure HeaderBitMap;
 {$I \Source\Chantal\Library\System\Windows\BitMap.Inc}
 Var
  TBitMap:^BitMapInfoHeader;
  Data:Record
   CaptionSize:String[40];
   CaptionWidth:String[40];
   CaptionHeight:String[40];
   CaptionPlanes:String[60];
   CaptionBitCount:String[50];
   CaptionCompression:String[50];
   CaptionSizeImage:String[60];
   CaptionXPelsPerMeter:String[60];
   CaptionYPelsPerMeter:String[60];
   CaptionClrUsed:String[60];
   CaptionClrImportant:String[60];
  End;
 Begin
  FillClr(Data,SizeOf(Data));
  TBitMap:=@Q.Buffer[Start];
  Data.CaptionSize:=CStr(TBitMap^.biSize)+' (Taille structure)';
  Data.CaptionWidth:=CStr(TBitMap^.biWidth)+' (Largeur en pixel(s))';
  Data.CaptionHeight:=CStr(TBitMap^.biHeight)+' (Hauteur en pixel(s))';
  Data.CaptionPlanes:=CStr(TBitMap^.biPlanes)+' (Nombre de plane pour la destination)';
  Data.CaptionBitCount:=CStr(TBitMap^.biBitCount)+' (Nombre de bit(s) par pixel)';
  Case(TBitMap^.biCompression)of
   0:Data.CaptionCompression:='RGB';
   1:Data.CaptionCompression:='RLE8';
   2:Data.CaptionCompression:='RLE4';
   Else Data.CaptionCompression:=HexWord2Str(TBitMap^.biCompression)+'h';
  End;
  AddStr(Data.CaptionCompression,' (Style de compression)');
  Data.CaptionSizeImage:=CStr(TBitMap^.biSizeImage)+' (Taille en octets pour l''image)';
  Data.CaptionXPelsPerMeter:=CStr(TBitMap^.biXPelsPerMeter)+' (Nombre horizontal de pixels par mŠtre)';
  Data.CaptionYPelsPerMeter:=CStr(TBitMap^.biYPelsPerMeter)+' (Nombre vertical de pixels par mŠtre)';
  Data.CaptionClrUsed:=CStr(TBitMap^.biClrUsed)+' (Nombre de couleurs index‚s dans la table)';
  Data.CaptionClrImportant:=CStr(TBitMap^.biClrImportant)+' (Nombre de couleurs index‚s dans la table)';
  ExecuteAppDPU(73,Data);
 End;

 Procedure TagTiff;
 Type TagRec=Record
  Tag,_Type:Word;
  Length,Offset:LongInt;
 End;
 Var
  L:LstMnu;
  I:Word;
  S:String;
  X:^TagRec;
  TX:TagRec;
  QD:DataSet;
  Data:Record
   Tag:Word;
   Name:String;
  End;

  {$I Library\Files\Images\TiffData.Inc}
 Begin
  LMInitCenter(L,NmXTxts-20,NmYTxts-5,'Tag d''entˆte TIFF',CurrKrs.Dialog.Window);
  I:=Start;
  DBInit(QD,MaltePath+'DATA\GRAPH\TIFF.DAT');
  Repeat
   X:=@Q.Buffer[I];TX:=X^;
   If DBLocateAbs(QD,0,TX.Tag,[])Then Begin
    DBReadRec(QD,Data);
    S:=Data.Name;
   End
    Else
   S:='Inconnue ('+HexWord2Str(TX.Tag)+'h)';
   S:=StrUSpc(S,20);
   If(TX._Type<>tiffLong)Then Begin
    TX.Length:=TX.Length and$FFFF;
    TX.Offset:=TX.Offset and$FFFF;
   End;
   AddStr(S,IntToStr(TX.Length)+','+IntToStr(TX.Offset));
   ALAddStr(L.List,S);
   Inc(I,SizeOf(TagRec));
  Until I>512;
  DBDone(QD);
  LMRun(L);
  LMDone(L);
 End;

Begin
 LMInitCenter(L,40,12,'D‚composeur Manuel',CurrKrs.Dialog.Env.List);
 ALAddStrByte(L.List,'Binaire',msBinary);
 ALAddStrByte(L.List,'Entˆte de BitMap Windows',msHeaderBitMap);
 ALAddStrByte(L.List,'Tag d''entˆte TIFF',msTagTiff);
 K:=LMRun(L);
 LMDone(L);
 Case(K)of
  msBinary:Binary;
  msTagTiff:TagTiff;
  msHeaderBitMap:HeaderBitMap;
 End;
End;

Procedure HVCheckSave(Var Q:HexEditApp);Near;Begin
 If(Q.Modified)Then Begin
  If(WarningMsgYesNo('Donn‚e modifi‚e! D‚sirez-vous les '+
      'sauvegarder avant de changer de bloque?')=kbYes)Then HVSave(Q);
 End;
End;

Procedure HVFirstPage(Var Q:HexEditApp);Near;Begin
 If Q.CurrRec<>0Then Begin
  HVCheckSave(Q);
  Q.CurrRec:=0;
  Q.CurrSector:=Q.SectorMin;
  Q.CurrTrack:=Q.TrackMin;
  Q.CurrHead:=Q.HeadMin;
  Q.Moved:=True;
  Q.Modified:=False;
  HVPutCurrRec(Q);
 End;
End;

Procedure HVEndPage(Var Q:HexEditApp);Near;Begin
 If(Q.CurrRec<>Q.MaxRec)Then Begin
  HVCheckSave(Q);
  Q.CurrRec:=Q.MaxRec;
  Q.CurrSector:=Q.SectorMax;
  Q.CurrTrack:=Q.TrackMax;
  Q.CurrHead:=Q.HeadMax;
  Q.Moved:=True;Q.Modified:=False;
  HVPutCurrRec(Q);
 End;
End;

Procedure HVPageUp(Var Q:HexEditApp);Near;Begin
 If Q.CurrRec>0Then Begin
  HVCheckSave(Q);
  Dec(Q.CurrRec);
  If Q.CurrRec and 1=1Then Dec(Q.CurrSector);
  If(Q.CurrSector<Q.SectorMin)Then Begin
   Q.CurrSector:=Q.SectorMax;
   Dec(Q.CurrTrack);
   If(Q.CurrTrack<Q.TrackMin)Then Begin
    Q.CurrTrack:=Q.TrackMax;
    Dec(Q.CurrHead)
   End;
  End;
  Q.Moved:=True;
  Q.Modified:=False;
  HVPutCurrRec(Q);
 End;
End;

Procedure HVPageDown(Var Q:HexEditApp);Near;Begin
 If(Q.CurrRec<Q.MaxRec)Then Begin
  HVCheckSave(Q);
  Inc(Q.CurrRec);
  If Q.CurrRec and 1=0Then Inc(Q.CurrSector);
  If(Q.CurrSector>Q.SectorMax)Then Begin
   Q.CurrSector:=Q.SectorMin;
   Inc(Q.CurrTrack);
   If(Q.CurrTrack>Q.TrackMax)Then Begin
    Q.CurrTrack:=Q.TrackMin;
    Inc(Q.CurrHead)
   End;
  End;
  Q.Moved:=True;Q.Modified:=False;
  HVPutCurrRec(Q);
 End;
End;

Procedure HVViewMode(Var Q:HexEditApp);Near;Begin
 HVCheckSave(Q);
 If(Q.Mode=Hex)Then Q.CurrRec:=Q.CurrRec shr 2
               Else Q.CurrRec:=Q.CurrRec shl 2;
 Byte(Q.Mode):=Byte(Q.Mode)xor 1;
 If(Q.Mode=Hex)and(Q.X>15)Then Q.X:=15;
 Q.Moved:=True;Q.Modified:=False;
 HVRefresh(Q);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Fonction HVRun                            Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de faire l'action que l'utilisateur souhaŒte si
 elle  s'applique  … cette objet  de visualisation hexad‚cimal sinon il
 retournera le code correspondant … l'action utilisateur.
}

Function HVRun;
Label Break;
Var
 K,Base:Wd;           { Code clavier, position absolue dans le tampon }
 ChrK:Char Absolute K;{ Caractere du code clavier }
 TrueCode:0..15;      { Code entre 0 et 15 pour modification hexad‚cimal}
 Attr,X,Y:Byte;       { Attribut et coordonn‚es horizontal et vertical courant}
 PL:Record
  ModeHex:Boolean;
  Write:^Boolean;
  Boot:Boolean;
 End;
 Q:HexEditApp Absolute Qx;

 Procedure Right;Begin
  If(Q.Mode=Hex)Then Begin
   If Q.Plane=0Then Begin
    If Q.Bi=1Then Begin;Q.X:=(Q.X+1)and$F;Q.Bi:=0;End
             Else Q.Bi:=1;
   End
    Else
   Q.X:=(Q.X+1)and$F;
  End
   Else
  Q.X:=(Q.X+1)and$3F;
 End;

Begin
 Repeat
  If(Q.EditMode)Then Begin
   If(Q.Mode=Hex)Then Begin
    Base:=Q.X+(Q.Y shl 4);
    If Q.Plane=0Then Begin
     X:=Q.X*3+Q.Bi+7;Y:=Q.Y+4;
     If Q.Bi=0Then Begin
      If Q.Buffer[Base]shr 4=Q.ModBoard[Base]shr 4Then Attr:=CurrKrs.Dialog.Env.List.Border
                                                  Else Attr:=Q.W.Palette.Sel;
     End
      Else
     Begin
      If Q.Buffer[Base]and$F=Q.ModBoard[Base]and$FThen Attr:=CurrKrs.Dialog.Env.List.Border
                                                  Else Attr:=Q.W.Palette.Sel;
     End;
    End
     Else
    Begin
     X:=Q.X+7+16*3;Y:=Q.Y+4;
     If Q.Buffer[Base]=Q.ModBoard[Base]Then Attr:=CurrKrs.Dialog.Env.List.Border
                                       Else Attr:=Q.W.Palette.Sel;
    End;
   End
    Else
   Begin
    Base:=Q.X+(Q.Y shl 6);X:=Q.X+7;Y:=Q.Y+4;
    If Q.Buffer[Base]=Q.ModBoard[Base]Then Attr:=CurrKrs.Dialog.Env.List.Border
                                      Else Attr:=Q.W.Palette.Sel;
   End;
   WESetPos(Q.W,X,Y);
   WESetCurPos(Q.W,X,Y);
   WESimpleCur(Q.W);
  End;
  K:=WEReadk(Q.W);
  If(Q.EditMode)Then Begin
   WECloseCur(Q.W);
   If(IsGraf)Then WESetAttr(Q.W,X,Y,Attr);
  End;
  Case(K)of
   kbInWn:If LastMouseB=2Then Begin
    PL.ModeHex:=Q.Mode=Hex;
    PL.Write:=@Q.EditMode;
    PL.Boot:=(Q.DskView)and(Q.CurrRec=0);
    Case _RunMenuApp(156,PL)of
     $F001:HVFiltre(Q);
     $F002:HVFirstPage(Q);
     $F003:HVPageUp(Q);
     $F004:HVPageDown(Q);
     $F005:HVEndPage(Q);
     $F006:HVViewMode(Q);
     $F007:HVManuelStruct(Q);
     $F008:LookBoot(Q,Q.FS.Dsk);
     $F009:HVEditMode(Q,Not Q.EditMode);
    End;
   End
    Else
   Goto Break;
   kbTab:If(Q.EditMode)Then Q.Plane:=Q.Plane xor 1;
   kbLeft:If(Q.EditMode)Then Begin
    If(Q.Mode=Hex)Then Begin
     If Q.Plane=0Then Begin
      If Q.Bi=0Then Begin
       Q.X:=(Q.X-1)and$F;
       Q.Bi:=1;
      End
       Else
      Q.Bi:=0;
     End
      Else
     Q.X:=(Q.X-1)and$F;
    End
     Else
    Q.X:=(Q.X-1)and$3F;
   End;
   kbRight:If(Q.EditMode)Then Right;
   kbUp,kbRBarMsUp:If(Q.EditMode)Then Q.Y:=(Q.Y-1)and$F;
   kbDn,kbRBarMsDn:If(Q.EditMode)Then Q.Y:=(Q.Y+1)and$F;
   kbCtrlF1:If(Q.DskView)and(Q.CurrRec=0)Then LookBoot(Q,Q.FS.Dsk)
            Else HVManuelStruct(Q);
   kbF9:HVEditMode(Q,Not Q.EditMode);
   kbF10:HVViewMode(Q);
   kbCtrlHome:HVFirstPage(Q);
   kbCtrlEnd:HVEndPage(Q);
   kbRBarMsPgUp,kbPgUp:HVPageUp(Q);
   kbRBarMsPgDn,kbPgDn:HVPageDown(Q);
   Else If(Q.EditMode)Then Begin
    If Lo(K)=0Then Goto Break;
    If(Q.Plane=0)and(Q.Mode=Hex)Then Begin
     If Chr(K)in['0'..'9','A'..'F','a'..'f']Then Begin
      ChrK:=UpCase(Chr(K));
      Case Chr(K)of
       '0'..'9':TrueCode:=Byte(K)-Byte('0');
       Else TrueCode:=Byte(K)-Byte('A');
      End;
      If Q.Bi=0Then Q.ModBoard[Base]:=(Q.ModBoard[Base]and$F)+(TrueCode shl 4)
               Else Q.ModBoard[Base]:=(Q.ModBoard[Base]and$F0)+TrueCode;
      If Q.ModBoard[Base]=Q.Buffer[Base]Then Attr:=CurrKrs.Dialog.Env.List.Border
                                        Else Attr:=Q.W.Palette.Sel;
      _WESetCube(Q.W,X,Y,Chr(K),Attr);
      _WESetCube(Q.W,Q.X+7+16*3,Y,Chr(Q.ModBoard[Base]),Attr);
     End
      Else
     Goto Break;
    End
     Else
    Begin
     Q.ModBoard[Base]:=Byte(K);
     If Q.ModBoard[Base]=Q.Buffer[Base]Then Attr:=CurrKrs.Dialog.Env.List.Border
                                       Else Attr:=Q.W.Palette.Sel;
     _WESetCube(Q.W,X,Y,Chr(K),Q.W.Palette.Sel);
    End;
    Q.Modified:=True;
    Right;
   End
    Else
   Begin
    If Chr(K)in['n','N']Then Begin
     Q.Operator.NotOp:=Not(Q.Operator.NotOp);
     HVPutCurrRec(Q)
    End
     Else
    If Chr(K)in['x','X']Then Begin
     Q.Operator.XorOp:=Not(Q.Operator.XorOp);
     HVPutCurrRec(Q)
    End
     Else
    If Chr(K)in['o','O']Then Begin
     Q.Operator.OrOp:=Not(Q.Operator.OrOp);
     HVPutCurrRec(Q)
    End
     Else
    If Chr(K)in['a','A']Then Begin
     Q.Operator.AndOp:=Not(Q.Operator.AndOp);
     HVPutCurrRec(Q)
    End
     Else
    Goto Break;
   End;
  End;
 Until False;
Break:
 HVRun:=K;
End;

Procedure HVFiltre(Var Q:HexEditApp);Begin
 If ExecuteAppDPU(155,Q.Operator)Then HVPutCurrRec(Q);
End;

Function HVTitle(Var Context;Max:Byte):String;
Const
 Name='Edite/Regarde Hexad‚cimal ';
Var
 Q:HexEditApp Absolute Context;
Begin
 If(Q.DskView)Then Begin
  If Q.Partition<>$FFThen HVTitle:=Name+'Partition '+Char(Q.Partition+48)
                     Else HVTitle:=Name+'Unit‚ '+Char(Q.FS.Dsk+65);
 End
  Else
 HVTitle:=Name+TruncName(Q.ViewName,Max-Length(Name))
End;

Procedure HVMove2(Var Context;X,Y:Byte);
Var
 Q:HexEditApp Absolute Context;
 MX,MY:Byte;
Begin
 MX:=Q.W.T.X2-Q.W.T.X1;MY:=Q.W.T.Y2-Q.W.T.Y1;
 Q.W.T.X1:=X;Q.W.T.X2:=X+MX;
 Q.W.T.Y1:=Y;Q.W.T.Y2:=Y+MY;
 HVRefresh(Q);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Proc‚dure HVDone                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de mettre fin … l'objet de visualisation en
 hexad‚cimal et de lib‚rer les ressources utilis‚s.
}

Function HVDone;Begin
 WEDone(HexEditApp(Q).W);
 HVDone:=0;
End;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
END.