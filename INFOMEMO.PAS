{⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
 ≥           Malte Genesis/Information MÇmoire         ≥
 ≥   Edition Chantal pour Mode RÇel/IV - Version 1.0   ≥
 ≥                       1997/01/25                    ≥
 ≥                                                     ≥
 ≥ Tous droits rÇservÇ par les Chevaliers de Malte (C) ≥
 ¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ


 Description
 ÕÕÕÕÕÕÕÕÕÕÕ

  Cette unitÇ est si l'on veut une suite de l'unitÇ ToolInfo. Elle permet
 d'obtenir des informations plus poussez sur la mÇmoire de tous genres.
}

Unit InfoMemo;

{ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ}
                                  INTERFACE
{ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ}

{$I DEF.INC}

Procedure CarteBios;
Procedure CmosInfo;
Procedure DeviceInfo;
Procedure MCBInfo;
Procedure MemInfo;
Procedure MultiplexIntInfo;
Procedure SoftwareIntrInfo;
Procedure GraphResource;

{ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ}
                                IMPLEMENTATION
{ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ}

Uses Adele,Math,Memories,
     {$IFDEF Overlay}Overlay,{$ENDIF}SysPlus,Mouse,Restex,ResServD,
     Goldnaxe,Dostex,Systex,Isatex,Systems,Video,Dialex,Dials,DialPlus;

{⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ∑}
{≥                     Z o n e  P r i v Ç s                    ∫}
{‘ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕº}

Function  CmosTimeFormat(Var Cmos:CmosType):Byte;Near;Forward;
Function  CmosVideo(Var Cmos:CmosType):Byte;Near;Forward;
Function  CmosWord(Var Cmos:CmosType;P:Byte):Wd;Near;Forward;
Procedure GetCmos(Var Cmos:CmosType);Near;Forward;
Function  ReadRomAddr(Buf:Pointer;Len:Byte):String;Near;Forward;
Function  Str2Aucun(V:Long;X:Byte):String;Near;Forward;

{$F-}
{$I Library\Disk\CDROM\Number.Inc}
{$I Library\Disk\CDROM\StartDrv.Inc}
{$F+}

{⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ‹
 ≥                        ProcÇdure CarteBios                        €
 ¿‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹€


 Description
 ÕÕÕÕÕÕÕÕÕÕÕ

  Cette procÇdure affiche une boåte de dialogue permettant l'affichage
 des donnÇes situÇs en RAM au segment 0040h.
}

Procedure CarteBIOS;
Label
 UpDt,RunKey;
Const
 HotKey=12;
 HotKeyAT=13;
 HorlogeLo=37;
 HorlogeHi=38;
 HorlogeReel=72;
Var
 XC,YC,Segment,OffSet:Wd;
 Boucle,Debut,Fin,T,P,X,Y:Byte;
 K:Word;
 W:Window;
 RamBios:DataSetInMemory;

 Procedure AfficheHotKey;
 Label 10;
 Var
  I,Boucle:Byte;
  W:Window;

  Procedure AfficheEtat;Var HotKey:Byte{$IFDEF Real}Absolute $0040:$17{$ENDIF};Begin
   {$IFDEF NotReal}
    HotKey:=Mem[_0040:$17];
   {$ENDIF}
   WESetKrHigh(W);
   If HotKey and 1=1Then WEPutTxtXY(W,4,2,'ActionnÇ')Else WEPutTxtXY(W,4,2,'LachÇ   ');
   If HotKey and 2=2Then WEPutTxtXY(W,4,3,'ActionnÇ')Else WEPutTxtXY(W,4,3,'LachÇ   ');
   If HotKey and 4=4Then WEPutTxtXY(W,4,4,'ActionnÇ')Else WEPutTxtXY(W,4,4,'LachÇ   ');
   If HotKey and 8=8Then WEPutTxtXY(W,4,5,'ActionnÇ')Else WEPutTxtXY(W,4,5,'LachÇ   ');
   If HotKey and 16=16Then WEPutTxtXY(W,4,6,'AllumÇ')Else WEPutTxtXY(W,4,6,'Eteint');
   If HotKey and 32=32Then WEPutTxtXY(W,4,7,'AllumÇ')Else WEPutTxtXY(W,4,7,'Eteint');
   If HotKey and 64=64Then WEPutTxtXY(W,4,8,'AllumÇ')Else WEPutTxtXY(W,4,8,'Eteint');
   If HotKey and 128=128Then WEPutTxtXY(W,4,9,'Ouvert')Else WEPutTxtXY(W,4,9,'Fermer');
  End;

 Begin
  WEInitO(W,29,11);
  WEPushWn(W);
  WEPutWnKrDials(W,'êtat du clavier');
  WEPutTxtXY(W,0,0,'Bit Valeur   Description');
  WEPutTxtXY(W,0,1,'ƒƒƒ ƒƒƒƒƒƒƒƒ ƒƒƒƒƒƒƒƒƒƒƒƒ');
  For I:=0 to 7 do WESetCube(W,1,2+I,Chr(48+I));
  WEPutTxtXY(W,13,2,'Shift droite');
  WEPutTxtXY(W,13,3,'Shift gauche');
  WEPutTxtXY(W,13,4,'Controle');
  WEPutTxtXY(W,13,5,'Alternate');
  WEPutTxtXY(W,13,6,'Scroll Lock');
  WEPutTxtXY(W,13,7,'Num Lock');
  WEPutTxtXY(W,13,8,'Caps Lock');
  WEPutTxtXY(W,13,9,'Insert');
  Boucle:=0;
  _InitKbd;
10:Repeat
   Boucle:=(Boucle+1)and$FF;
   If Boucle=1Then AfficheEtat;
   _BackKbd;
  Until KeyPress;
  If(ReadKey=kbIns)Then Goto 10;
  WEDone(W);
 End;

 Procedure AfficheHotKeyAT;
 Label 10;
 Var
  I,Boucle:Byte;
  W:Window;

  Procedure AfficheEtat;
  Var
   HotKey:Byte Absolute $0040:$18;
  Begin
   WESetKrHigh(W);
   If HotKey and 1=1Then WEPutTxtXY(W,4,2,'EnfoncÇ')Else WEPutTxtXY(W,4,2,'LachÇ  ');
   If HotKey and 2=2Then WEPutTxtXY(W,4,3,'EnfoncÇ')Else WEPutTxtXY(W,4,3,'LachÇ  ');
   If HotKey and 4=4Then WEPutTxtXY(W,4,4,'EnfoncÇ')Else WEPutTxtXY(W,4,4,'LachÇ  ');
   If HotKey and 8=8Then WEPutTxtXY(W,4,5,'ActionnÇ')Else WEPutTxtXY(W,4,5,'Absent  ');
   If HotKey and 16=16Then WEPutTxtXY(W,4,6,'EnfoncÇ')Else WEPutTxtXY(W,4,6,'LachÇ  ');
   If HotKey and 32=32Then WEPutTxtXY(W,4,7,'EnfoncÇ')Else WEPutTxtXY(W,4,7,'LachÇ  ');
   If HotKey and 64=64Then WEPutTxtXY(W,4,8,'EnfoncÇ')Else WEPutTxtXY(W,4,8,'LachÇ  ');
   If HotKey and 128=128Then WEPutTxtXY(W,4,9,'EnfoncÇ')Else WEPutTxtXY(W,4,9,'LachÇ  ');
  End;

 Begin
  WEInitO(W,29,11);
  WEPushWn(W);
  WEPutWnKrDials(W,'êtat actuel du clavier');
  WEPutTxtXY(W,0,0,'Bit Valeur   Description');
  WEPutTxtXY(W,0,1,'ƒƒƒ ƒƒƒƒƒƒƒƒ ƒƒƒƒƒƒƒƒƒƒƒƒ');
  For I:=0to 7do WESetCube(W,1,2+I,Chr(48+I));
  WEPutTxtXY(W,13,2,'Ctrl gauche');
  WEPutTxtXY(W,13,3,'Alt gauche');
  WEPutTxtXY(W,13,4,'SysReq');
  WEPutTxtXY(W,13,5,'Pause');
  WEPutTxtXY(W,13,6,'Scroll Lock');
  WEPutTxtXY(W,13,7,'Num Lock');
  WEPutTxtXY(W,13,8,'Caps Lock');
  WEPutTxtXY(W,13,9,'Insert');
  Boucle:=0;
  _InitKbd;
10:Repeat
   Boucle:=(Boucle+1)and$FF;
   If Boucle=1Then AfficheEtat;
   _BackKbd;
  Until KeyPress;
  If(ReadKey=kbIns)Then Goto 10;
  WEDone(W);
 End;

 Function Data(Numero:Byte):String;
 Type
  DataRec=Record
   Addr:Word;
   Len:Byte;
   Descr:String;
  End;
 Var
  T:String;
  PR:^DataRec;
 Begin
  PR:=@RamBios.Table^[RamBios.Index^[Numero]];
  T:='0040h:'+HexByte2Str(PR^.Addr)+'h ';
  If PR^.Len=1Then AddStr(T,HexByte2Str(Mem[_0040:PR^.Addr])+'h')
  else AddStr(T,HexWord2Str(MemW[_0040:PR^.Addr])+'h');
  Data:=StrUSpc(T,15)
 End;

 Procedure Adate(Numero:Byte);
 Var
  YP,Yn:Word;
  PtrFound:Boolean;
 Begin
  YP:=YC+2;
  If(P>Numero)Then T:=P-Numero Else T:=Numero-P;
  If(Numero>=Debut)and(Numero<=Fin)Then Begin
   If(P>Numero)Then Yn:=YP-T Else
   If(P<Numero)Then Yn:=YP+T
               Else Yn:=YP;
   WEPutTxtXYU(W,0,Yn,Data(Numero));
  End;
 End;

 Function GetDescr(P:Word):String;
 Type
  DataRec=Record
   Addr:Word;
   Len:Byte;
   Descr:String;
  End;
 Var
  PR:^DataRec;
 Begin
  PR:=@RamBios.Table^[RamBios.Index^[P]];
  GetDescr:=PR^.Descr;
 End;

Begin
 DBOpenServerName(ChantalServer,'CHANTAL:/Materiel/RamBios.Dat');
 DBCopyToMemory(ChantalServer,RamBios);
 WEInitO(W,53,16);
 X:=WEGetRX1(W);Y:=WEGetRY1(W);
 WEPushWn(W);
 WEPutWn(W,'Carte de la zone volatile Bios',CurrKrs.Dialog.Env.List);
 WECloseIcon(W);
 WEPutBarMsRight(W);
 WEPutTxtXY(W,0,0,'Adresse   DonnÇe Description');
 WEPutTxtXY(W,0,1,'ƒƒƒƒƒƒƒƒƒ ƒƒƒƒƒƒ ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ');
 For YC:=0to W.MaxY-2do Begin
  WESetKrHigh(W);
  WEPutTxtXY(W,0,2+YC,Data(YC));
  WESetKrBorder(W);
  WEPutTxtXY(W,17,2+YC,GetDescr(YC));
 End;
 P:=0;YC:=0;
 Repeat
  WESelRightBarPos(W,P,72);
  BarSelHor(X,Y+2+YC,X+50,$B);
  Boucle:=0;
  __ShowMousePtr;
  _InitKbd;
  Repeat
   K:=WEBackReadk(W);
   If K>0Then Begin
    Case(K)of
     kbClose:Begin
      K:=kbEsc;
      WaitMouseBut0;
      __HideMousePtr;
      Goto RunKey;
     End;
     kbRBarMsUp:Begin
      K:=kbUp;
      DelayMousePress(100);
      __HideMousePtr;
      Goto RunKey;
     End;
     kbRBarMsDn:Begin
      K:=kbDn;
      DelayMousePress(100);
      __HideMousePtr;
      Goto RunKey;
     End;
    End;
   End;
   Boucle:=(Boucle+1)and$FF;
   If Boucle=1Then Begin
    Debut:=P-YC;Fin:=Debut+W.MaxY;
    Adate(HotKey);
    Adate(HotKeyAT);
    Adate(HorlogeLo);
    Adate(HorlogeHi);
    Adate(HorlogeReel);
   End;
   _BackKbd;
  Until KeyPress;
  __HideMousePtr;
  K:=WEReadk(W);
RunKey:
  BarSelHor(X,Y+2+YC,X+16,W.Palette.High);
  BarSelHor(X+17,Y+2+YC,X+50,W.Palette.Border);
  Case(K)of
   kbCtrlF1,kbEnter:Case(P)of
    HotKey:AfficheHotKey;
  HotKeyAT:AfficheHotKeyAT;
   End;
   kbUp:If P>0Then Begin
    Dec(P);
    If YC>0Then Dec(YC)
     Else
    Begin
     WEScrollUp(W,0,2,wnMax,wnMax);
     Goto UpDt;
    End;
   End;
   kbDn:If P<72Then Begin
    Inc(P);
    If(YC<W.MaxY-2)Then Inc(YC)
     else
    Begin
     WEScrollDn(W,0,2,wnMax,wnMax);
UpDt:WEPutTxtXY(W,0,2+YC,Data(P));
     WEPutTxtXY(W,17,2+YC,GetDescr(P));
     WEClrEol(W);
    End;
   End;
  End;
 Until(K=kbEsc)or(K=kbClose);
 WEDone(W);
 DBDispose(RamBios);
End;

{⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ‹
 ≥                         Fonction CmosVideo                        €
 ¿‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹€


 Description
 ÕÕÕÕÕÕÕÕÕÕÕ

  Cette fonction retourne le format sous lequel la date et l'heure est
 stockÇ en  mÇmoire  CMOS Ö partir  d'un  tampon  CMOS  de  64  octets
 prÇchargÇ.
}

Function CmosTimeFormat;Begin
 If Cmos[11]and 4=0Then CmosTimeFormat:=CmosTimeBCD
                   Else CmosTimeFormat:=CmosTimeBinary;
End;

{⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ‹
 ≥                        Fonction CmosVideo                        €
 ¿‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹€


 Description
 ÕÕÕÕÕÕÕÕÕÕÕ

  Cette fonction retourne Ö partir d'un tampon CMOS prÇchargÇ le type
 de mode vidÇo utilisÇ au lancement du systäme.
}

Function CmosVideo;Begin
 CmosVideo:=(Cmos[$14]and 63)shr 4;
End;

{⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ‹
 ≥                         Fonction CmosWord                        €
 ¿‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹€


 Description
 ÕÕÕÕÕÕÕÕÕÕÕ

  Cette fonction lit un mot (2 octets) dans un tampon de format de 64
 octets de la mÇmoire CMOS.
}

Function CmosWord;Assembler;ASM{CmosWord:=Cmos[P]+(Cmos[P+1]shl 8)}
 LES DI,Cmos
 MOV BL,P
 XOR BH,BH
 MOV AX,ES:[DI+BX]
END;

{⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ‹
 ≥                          ProcÇdure GetCmos                         €
 ¿‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹€


 Description
 ÕÕÕÕÕÕÕÕÕÕÕ

  Cette procÇdure lit les donnÇes contenues dans la mÇmoire CMOS (ayant
 une taille de 64 octets).
}

Procedure GetCmos;Var I,J:Byte;Begin
 FillClr(Cmos,SizeOf(Cmos));
 If CtrlCmos in[ctrlCmosMM58167a,ctrlCmosMM58167b,ctrlCmosRTC58321]Then Exit;
 For I:=0to 63do Begin
  ASM
   MOV DX,CmosPort
   MOV AL,I
   OUT DX,AL
   NOP;NOP;NOP;NOP
   INC DX
   IN  AL,DX
   MOV J,AL
  END;
  Cmos[I]:=J;
  ASM NOP;NOP;NOP;NOP;END;
 End;
End;

{⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ‹
 ≥                         Fonction GetTypeDsk                       €
 ¿‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹€


 Description
 ÕÕÕÕÕÕÕÕÕÕÕ

  Cette fonction retourne une ligne indiquant le modäle d'unitÇ disque
 (selon le mode de la variable ÆXØ) spÇcifiÇ.
}

Function GetTypeDsk(X:Byte):String;Begin
 Case(X)of
  0:GetTypeDsk:='Aucun';
  1:GetTypeDsk:='360 Ko, 5¨"';
  2:GetTypeDsk:='1'+DeSep[0]+'2 Mo, 5¨"';
  3:GetTypeDsk:='720 Ko, 3´"';
  4:GetTypeDsk:='1'+DeSep[0]+'44 Mo, 3´"';
  5:GetTypeDsk:='2'+DeSep[0]+'88 Mo, 3´"';
Else GetTypeDsk:='Inconnue';
 End;
End;

{⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ‹
 ≥                        Fonction ReadRomAddr                       €
 ¿‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹€


 Description
 ÕÕÕÕÕÕÕÕÕÕÕ

  Cette fonction transforme une tampon situÇ Ö l'adresse de la variable
 ÆPtrØ en chaåne de caractäre de format Pascal.


 Remarque
 ÕÕÕÕÕÕÕÕ

  ˛ Cette fonction est Ö 100% identique avec la fonction ÆToolInfo.ReadRomØ
    dans ces codes  d'instructions mais pas sont entàte.  Il  suffira  donc
    d'Çcrire  par  exemple la petite  procÇdure  suivante  pour  Çviter  de
    rÇpÇter le màme code si vous le fusionner Ö cette unitÇ:
    ⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
    ≥ Function ReadRomAddr(Buf:Pointer;Len:Byte):String;Assembler;ASM     ≥
    ≥  JMP ReadRom.Near[3]                                                ≥
    ≥ END;                                                                ≥
    ¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
}

Function ReadRomAddr;Assembler;ASM
 CLD
 PUSH DS
  LES DI,@Result
  MOV CL,Len
  MOV ES:[DI],CL
  INC DI
  MOV CH,0
  MOV DS,Word Ptr Buf[2]
  MOV SI,Word Ptr Buf
  REP MOVSB
 POP DS
END;

{⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ‹
 ≥                         Fonction Str2Aucun                        €
 ¿‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹€


 Description
 ÕÕÕÕÕÕÕÕÕÕÕ

  Cette fonction retourne une chaåne de caractäre avec la valeur numÇrique
 dÇcimal de la variable ÆVØ si elle est diffÇrent de 0,  si elle est Çgale
 Ö 0, alors est retourne la chaåne de caractäre ÆAucunØ.
}

Function Str2Aucun;Begin
 If V=0Then Str2Aucun:='Aucun'
       Else Str2Aucun:=Str2(V,X)
End;

{⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ∑}
{≥                   Z o n e  P u b l i q u e                  ∫}
{‘ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕº}

{⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ‹
 ≥                        ProcÇdure CmosInfo                         €
 ¿‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹€


 Description
 ÕÕÕÕÕÕÕÕÕÕÕ

  Cette procÇdure retourne affiche une boåte de dialogue contenant les
 informations Çcrit dans le CMOS (Horloge sur piles...).
}

Procedure CmosInfo;
Var
 Cmos:CmosType;
 Data:Record
  Ctrl:String[70];
  PrimHD:String[10];
  SecHD:String[10];
  PrimFD:String[15];
  SecFD:String[15];
  Base:String[15];
  Xms:String[15];
  Batterie:String[30];
  Heure:String[30];
  DisqueDur:String[30];
  Memoire:String[30];
  Equipement:String[30];
  CheckSum:String[30];
  Date:String[30];
  Time:String[30];
 End;
Begin
 If Not(CmosExist)Then ErrNoMsgOk(errCmosNotFound)
  Else
 Begin
  GetCmos(Cmos);
  FillClr(Data,SizeOf(Data));
  Case(CtrlCmos)of
   ctrlCmosNo:Data.Ctrl:='Absent';
   ctrlCmosUnknown:Data.Ctrl:='Inconnu';
   ctrlCmosMM58167a,ctrlCmosMM58167b:Data.Ctrl:='RTC MM58167';
   ctrlCmosRTC58321:Data.Ctrl:='RTC-58321';
   ctrlCmosMC146818:Data.Ctrl:='MC146818 de Motorola';
  End;
  AddStr(Data.Ctrl,', Port: '+HexWord2Str(CmosPort)+'h');
  If CtrlCmos in[ctrlCmosMM58167a,ctrlCmosMM58167b]Then
   AddStr(Data.Ctrl,' Ö '+HexWord2Str(CmosPort+7+$18*
		Byte(CtrlCmos=ctrlCmosMM58167a))+'h');
  Data.PrimHD:=Str2Aucun(Cmos[$19],4);
  Data.SecHD:=Str2Aucun(Cmos[$1A],4);
  Data.PrimFD:=GetTypeDsk(Cmos[$10]shr 4);
  Data.SecFD:=GetTypeDsk(Cmos[$10]and$F);
  Data.Base:=WordToStr(CmosWord(Cmos,$15))+' Ko';
  Data.Xms:=WordToStr(CmosWord(Cmos,$17))+' Ko';
  If Cmos[$0E]and$80=$80Then Data.Batterie:='Perte d''alimentation'
                        Else Data.Batterie:='OpÇrationnel';
  If Cmos[$0E]and$4=4Then Data.Heure:='Invalide'
                     Else Data.Heure:='Valide';
  If Cmos[$0E]and$8=8Then Data.DisqueDur:='Incorrecte'
                     Else Data.DisqueDur:='Correcte';
  If Cmos[$0E]and$10=$10Then Data.Memoire:='Incorrecte'
                        Else Data.Memoire:='Correcte';
  If Cmos[$0E]and$20=$20Then Data.Equipement:='Incorrecte'
                        Else Data.Equipement:='Correcte';
  If Cmos[$0E]and$40=$40Then Data.CheckSum:='Incorrecte'
                        Else Data.CheckSum:='Correcte';
  Data.Date:=_CStrDate(ToBCD(Cmos[$32])*100+ToBCD(Cmos[9]),ToBCD(Cmos[8]),ToBCD(Cmos[7]),$FF);
  Data.Time:=CStrTimeDos(ToBCD(Cmos[4]),ToBCD(Cmos[2]),ToBCD(Cmos[0]));
  ExecuteAppDPU(86,Data);
 End;
End;

{⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ‹
 ≥                       ProcÇdure DeviceInfo                       €
 ¿‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹€


 Description
 ÕÕÕÕÕÕÕÕÕÕÕ

  Cette procÇdure affiche dans une boåte de dialogue les informations
 concernant les DEVICE du DOS.
}

Procedure DeviceInfo;
Var
 L:LstMnu;
 LT:ListTitle;
 I,S,O:Word;
 Str:String;
Begin
 LMInitCenter(L,76,20,'Device du systäme',CurrKrs.Dialog.Env.List);
 LTInitWithWins(LT,0,0,L.W.MaxX,'Device|UnitÇs|Entàte|Attributs|StratÇgie|Interruption',L.W);
 WESetHomeLine(L.W,1);
 LTSetColumnSize(LT,0,11);
 LTSetColumnSize(LT,1,6);
 LTSetColumnSize(LT,2,11);
 LTSetColumnSize(LT,3,17);
 LTSetColumnSize(LT,4,11);
 LTSetColumnSize(LT,5,12);
 LTRefresh(LT);
 S:=PtrRec(GetDosBlock).Seg;O:=PtrRec(GetDosBlock).Ofs+$0022+4;
 While(O<$FFFF)do Begin
  Str:='';
  If Mem[S:O+5]and$80=0Then AddStr(Str,Str2(Mem[S:O+10],15))
   else
  Begin
   For I:=10to 17do If Char(Mem[S:O+I])in[' '..'~']Then IncStr(Str,Char(Mem[S:O+I]))
                                                   Else IncStr(Str,'.');
   AddStr(Str,'       ')
  End;
  AddStr(Str,'    '+HexWord2Str(S)+'h:'+HexWord2Str(O)+'h ');
  AddStr(Str,BinByte2Str(Mem[S:O+4])+'_'+BinByte2Str(Mem[S:O+5])+' ');
  AddStr(Str,HexWord2Str(S)+'h:'+HexWord2Str(MemW[S:O+6])+'h ');
  AddStr(Str,HexWord2Str(S)+'h:'+HexWord2Str(MemW[S:O+8])+'h');
  ASM
   MOV ES,S
   MOV BX,O
   MOV AX,ES:[BX]
   MOV O,AX
   MOV AX,ES:[BX+2]
   MOV S,AX
  END;
  ALAddStr(L.List,Str);
 End;
 LMRun(L);
 LMDone(L);
End;

{Procedure MCBIconRoutine(X,Y:Byte;P:Word;Var Context);
Var
 Q:LstMnu Absolute Context;
 T:TextBoxRec;
 G:GraphBoxRec;
 PChrByte:^PCharByteRec;
 Len:Word;
Begin
 T.X1:=Q.W.T.X2-5;
 T.Y1:=Y;
 T.X2:=T.X1+3;
 T.Y2:=T.Y1;
 CoordTxt2Graph(T,G);
 Inc(G.Y1,2);
 Dec(G.X2);
 Dec(G.Y2,2);
 PChrByte:=_RBGetBuf(Q.List,P);
 Len:=StrToInt(DelChr(Copy(StrPas(PChrByte^.PChr),7,9),' '))div 20480;
 PutFillBox(G.X2-Len,G.Y1,G.X2,G.Y2,LightGreen);
End;}

{⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ‹
 ≥                         ProcÇdure MCBInfo                         €
 ¿‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹€


 Description
 ÕÕÕÕÕÕÕÕÕÕÕ

  Cette procÇdure retourne une boåte de dialogue contenant un schÇma prÇcis
 de la mÇmoire (basÇ sur les MCB du DOS).
}

Procedure MCBInfo;
Var
 L,LS:LstMnu;
 LT:ListTitle;
 W:Window;
 MCB,MCB2:^MCBRec;
 S,S2,S3:String;
 X,I,J:Byte;
 K:Word;
Begin
 LMInitCenter(L,64,15,'Information MCB',CurrKrs.Dialog.Env.List);
 LTInitWithWins(LT,0,0,L.W.MaxX,'Segment|Taille|Description|CatÇgorie',L.W);
 WESetHomeLine(L.W,1);
 {If(IsGrf)Then Begin
  L.Context:=@L;
  L.IconRoutine:=MCBIconRoutine;
 End;}
 LTSetColumnSize(LT,0,7);
 LTSetColumnSize(LT,1,8);
 LTSetColumnSize(LT,2,24);
 LTRefresh(LT);
 ALAddStrWord(L.List,'0000h      1024  Table d''interruption     Systäme',1);
 ALAddStrWord(L.List,'0040h       256  Zone volatile du Bios    DonnÇe',$40);
 {$IFDEF Real}
  MCB:=@GetDosBlock^.FirstMCB^;{VideoPass:=No;}
  If PtrRec(MCB).Seg>$50Then
   ALAddStrWord(L.List,'0050h'+CStr2(Long(Long(PtrRec(MCB).Seg-$50)shl 4),10)+'  Systäme d''exploitation   Systäme',$50);
  While MCB^.ID in['M','Z']do Begin
   S:=CStr2(Long(Long(MCB^.Size)shl 4),10);
   If MCB^.Header.Comspec='COMSPEC='Then Begin
    S2:='Environnement';
    S3:='RÇgion Dos';
   End
    Else
   If MCB^.Header.Prg=$20CDThen Begin
    S2:='Programme';S3:=PrgPath(MCB^.PSP);
    If(S3='')or Not(StrI(1,S3)in MajRomanLetter)Then Begin
     S3:=ReadRomAddr(@MCB^.Name,8);I:=Pos(#0,S3);
     If I>0Then S3[0]:=Chr(I-1);
    End
     Else
    If Length(S3)>=25Then S3:=Path2NoDir(S3);
   End Else
   If MCB^.PSP=0Then Begin S2:='';S3:='ÆMÇmoire inutilisÇeØ';End Else
   Begin
    S2:='DonnÇe';
    Case(MCB^.PSP)of
     6:S3:='Digital Research UMB';
     7:S3:='Digital Research UMB hole';
     8:Begin
      If(MCB^.Name.Sign=$4353)and(Lo(GetDosVer)=5)Then S2:='Code';
      S3:='Systäme d''exploitation';
     End;
     Else Begin
      MCB2:=Ptr(MCB^.PSP-1,0);S3:=ReadRomAddr(@MCB2^.Name,8);I:=Pos(#0,S3);
      If I>0Then S3[0]:=Chr(I-1);
     End;
    End;
   End;
   ALAddStrWord(L.List,HexWord2Str(PtrRec(MCB).Seg)+'h'+S+'  '+StrUSpc(S3,25)+S2,PtrRec(MCB).Seg);
   Inc(PtrRec(MCB).Seg,MCB^.Size+1);
  End;
 {$ENDIF}
 WESetEndBar(L.W,CurrKrs.Desktop.DialStatus);
 WESetEndBarTxtX(L.W,1,'Nombre de MCB: '+CStr(L.List.Count),CurrKrs.Desktop.DialStatus);
 If(IsGrf)Then Begin
  BarSpcHorRelief(L.W.T.X1,L.W.T.Y2,L.W.T.X2,CurrKrs.Desktop.DialStatus);
  BarSpcHorReliefExt(L.W.T.X1+1,L.W.T.Y2,L.W.T.X2-2,CurrKrs.Desktop.DialStatus);
  LuxeBox(L.W.T.X2-1,L.W.T.Y2);
 End;
 Repeat
  K:=LMRun(L);
  If K=$40Then CarteBios Else
  If K<>0Then Begin
   If K=1Then SoftwareIntrInfo
    Else
   Begin
    MCB:=Ptr(K,0);
    If MCB^.Header.Comspec='COMSPEC='Then Begin
     LMInitCenter(LS,70,20,'Environnement',CurrKrs.Dialog.Env.List{Wins});
     K:=0;S:=PrgPath(MCB^.PSP);
     If(StrI(1,S)in MajRomanLetter)Then ALAddStr(LS.List,'Programme Parent: '+S);
     S:='';
     While MCB^.Header.Data[K]<>0do Begin
      IncStr(S,Chr(MCB^.Header.Data[K])); Inc(K);
      If MCB^.Header.Data[K]=0Then Begin
       ALAddStr(LS.List,S);
       S:='';Inc(K);
      End
     End;
     LMRun(LS);
     LMDone(LS);
    End
     Else
    Begin
     WEInitO(W,72,20);
     WEPushWn(W);
     WEPutWn(W,'Dump MÇmoire',CurrKrs.HexView.Window);
     WEClrWn(W,7,1,wnMax,wnMax,CurrKrs.HexView.Window.High);
     WEPutTxtXYU(W,7,0,'0  1  2  3  4  5  6  7  8  9  A  B  C  D  E  F  0123456789ABCDEF');
     For J:=0to 15do Begin
      WEPutTxtXYU(W,0,J+1,HexWord2Str(J*16)+' - ');
      For I:=0to 15do Begin
       X:=MCB^.Header.Data[J*16+I];
       WEPutTxtXYU(W,7+I*3,J+1,HexByte2Str(X));
       WESetChr(W,7+16*3+I,J+1,Char(X));
      End;
     End;
     While WEOk(W)do;
    End;
   End;
  End;
 Until K=0;
 LMDone(L);
End;

Type
 MapAreaObj=Record
  SegSize:Real;
  G,T:GraphBoxRec;
 End;

Procedure MAInit(Var Q:MapAreaObj;Const G:GraphBoxRec);Begin
 Q.SegSize:=(G.Y2-G.Y1)/65536;
 Q.G:=G;
 Inc(Q.G.X1);
 Dec(Q.G.X2);
End;

Procedure MAComputeArea(Var Q:MapAreaObj;Seg:Word;Len:LongInt);Begin
 Q.T.Y1:=Trunc(Seg*Q.SegSize);
 Q.T.Y2:=Trunc((Seg+(Len/16))*Q.SegSize);
End;

Procedure MAShowArea(Var Q:MapAreaObj;Color:Byte;Const Msg:String);Begin
 PutFillBox(Q.G.X1,Q.G.Y2-Q.T.Y2,Q.G.X2,Q.G.Y2-Q.T.Y1,Color);
 OutSmlTxtXY(Q.G.X1,Q.G.Y2-Q.T.Y1-((Q.T.Y2-Q.T.Y1)shr 1),Msg,Color shl 4);
End;

Procedure ShowConvMap(Var W:Window;X:Byte);
Var
 J:Byte;
 I:Word;
 T:TextBoxRec;
 G:GraphBoxRec;
 Q:MapAreaObj;
 SY1,SY2:Word;
Begin
 If W.MaxY=16Then Begin
  For J:=2to(W.MaxY)do If(J<>7)Then Begin
   WEPutSmlTxtXY(W,X-9,J,HexByte2Str((16-J))+'0000h');
  End;
 End
  Else
 Begin
  For J:=1to W.MaxY-1do WEPutTxtXY(W,X-3,J,'-');
  WEPutTxtXY(W,X-3,W.MaxY,'0');
 End;
 WEPutTxtXY(W,X-6,1,'1 Mo');
 MoveLeft(W.T,T,SizeOf(TextBoxRec));
 Inc(T.X1,X);
 Inc(T.Y1,2);
 Dec(T.X2,2);
 Dec(T.Y2);
 CoordTxt2Graph(T,G);
 PutFillBox(G.X1,G.Y1,G.X2,G.Y2,Blue);
 __PutRect(G,Black);
 MAInit(Q,G);
 MAComputeArea(Q,PrefixSeg,LongInt(PtrRec(HeapPtr).Seg-PrefixSeg)*16);
 MAShowArea(Q,LightBlue,'MonsterBook');
 MAComputeArea(Q,$A000,128*1024);
 MAShowArea(Q,Brown,'RAM VidÇo');
 MAComputeArea(Q,PtrRec(HeapPtr).Seg,MaxAvail);
 MAShowArea(Q,LightGreen,'Libre');
 MAComputeArea(Q,$A000,393216);
 WEPutTxtXY(W,X-8,Trunc(W.MaxY*(1024-(640/1024))),'640 Ko');
 MAComputeArea(Q,$F000,$FFFF);
 MAShowArea(Q,DarkGray,'BIOS ROM');
 I:=$C000;
 While(I<$F000)do Begin
  If MemW[I:0]=$AA55Then Begin
   MAComputeArea(Q,I,8192);
   MAShowArea(Q,DarkGray,'');
  End;
  Inc(I,$200);
 End;
 If EmmSeg>0Then Begin
  MAComputeArea(Q,EmmSeg,EmsSzPgDef shl 2);
  MAShowArea(Q,Yellow,'EMS');
 End;
 MAComputeArea(Q,OvrHeapPtr,OvrGetBuf);
 MAShowArea(Q,Yellow,'Recouvrement');
End;

{⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ‹
 ≥                           ProcÇdure MemInfo                             €
 ¿‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹€


 Description
 ÕÕÕÕÕÕÕÕÕÕÕ

  Cette procÇdure affiche les informations conáernant la mÇmoire (ressource)
 utilisÇe par l'application de faáon gÇnÇrale.
}

Procedure MemInfo;
Var
 W:Window;
 k:String;

 Procedure PutTypingLn(S1:String;X:Word;D:Byte);Begin
  WEPutTypingLn(W,S1+CStr2(Long(X)shl 10,D)+'^ octet(s)')
 End;

Begin
 WEInitO(W,55+Byte(IsGrf)*20,{$IFDEF Real}14+Byte(XmsExist)*2+Byte(EmmExist)*2{$ELSE}13{$ENDIF});
 WEPushWn(W);
 WEPutWnKrDials(W,'êtat de la mÇmoire');
 WECloseIcon(W);
 WELn(W);
 WEBar(W);
 SetAllKr(W.Palette.High,W.Palette.Border);
 If(VSwpInit)Then Begin
  WEPutTypingLn(W,'Nom du fichier ressource disque: ^'+Path2NoDir(PathDskSwp));
  PutTypingLn('^Ressource Disque total:^',AppResSize(rmDsk),19);
  PutTypingLn('Ressource Disque de libre:^',AppResFree(rmDsk),16);
 End;
 WELn(W);
 {$IFDEF Real}
  If(EmmExist)Then Begin
   PutTypingLn('Ressource EMS total:^',EmmTotalSize,22);
   PutTypingLn('Ressource EMS de libre:^',AppResFree(rmEms),19);
  End;
  If(XmsExist)Then Begin
   PutTypingLn('Ressource XMS total:^',XmsTotalSize,22);
   PutTypingLn('Ressource XMS de libre:^',AppResFree(rmXms),19);
  End;
 {$ENDIF}
 WEPutTypingLn(W,'Ressource VRAM total:^'+CStr2(GetVidMem,21)+'^ octet(s)');
 PutTypingLn('Ressource VRAM de libre:^',AppResFree(rmVram),18);
 PutTypingLn('Total de mÇmoire conventionnel:^',SizeOfRAMConv,12);
 {$IFDEF Real}
  WEPutTypingLn(W,'MÇmoire de recouvrement:^'+CStr2(OvrGetBuf,18)+'^ octet(s)');
 {$ENDIF}
 WEPutTypingLn(W,{$IFDEF Real}
                  'MÇmoire conventionnel de libre:^'
                 {$ELSE}
                  'MÇmoire mode protÇgÇ de libre:^'
                 {$ENDIF}
                 +CStr2(MemAvail,12)+'^ octet(s)');
 If(IsGrf)Then ShowConvMap(W,61);
 Repeat
  Case WEGetkHorDn(W,'Correcte|Graphique')of
   0,kbAbort:Break;
   1:GraphResource;
  End;
 Until No;
 WEDone(W);
End;

{⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ‹
 ≥                   ProcÇdure MultiplexIntInfo                     €
 ¿‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹€


 Description
 ÕÕÕÕÕÕÕÕÕÕÕ

  Cette procÇdure permet d'obtenir des informations dans une boåte de
 dialogue concernant l'interruption multiplex (2Fh).
}

Procedure MultiplexIntInfo;
Var
 W:Window;
 NmCDROM,Start,_SI,_DI,_BX:Word;
 P,_AH,_AL:Byte;
 Append:Boolean;
 PC:PChr;
 Data:Record
  ID:Byte;
  SubID:Byte;
  Mode:Byte;
  Name:String;
 End;
Begin
 Append:=Lo(GetDosVer)>=4;
 If(Append)Then Begin
  ASM
   MOV AX,0B700h
   INT 2Fh
   MOV _AL,AL
  END;
  Append:=_AL=$FF;
 End;
 WEInitO(W,80,16+(Byte(Append)shl 1));
 WEPushWn(W);
 WEPutWnKrDials(W,'Interruption Multiplex');
 WEBar(W);
 WELn(W);
 P:=0;
 DBOpenServerName(ChantalServer,'CHANTAL:/Materiel/InterruptionMultiplex.Dat');
 DBFirst(ChantalServer);
 While Not DBEOF(ChantalServer)do Begin
  DBReadRec(ChantalServer,Data);
  If P=1Then W.X:=40;
  WEPutTxt(W,StrUSpc(Data.Name+':',17));
  Case(Data.Mode)of
   1:Begin
    ASM
     MOV AX,2300h
     XOR BX,BX
     XOR CX,CX
     XOR DX,DX
     INT 2Fh
     MOV _AH,AH
    END;
    WESetKrHigh(W);
    If _AH=$FFThen WEPutTxt(W,'Oui')Else WEPutTxt(W,'Non; peut àtre charger');
   End;
   2:Begin
    NmCDROM:=NumberCDROM;Start:=StartDrvCDROM;
    WESetKrHigh(W);
    If NmCDROM=0Then WEPutTxt(W,'Non; peut àtre charger')
                Else WEPutTxt(W,'Oui; d''unitÇ '+Chr(Start+65)+': Ö '+Chr(Start+NmCDROM+65-1)+':');
   End;
   3:Begin
    ASM
     MOV AX,0B800h
     INT 2Fh
     MOV _AL,AL
     MOV _BX,BX
    END;
    WESetKrHigh(W);
    If _AL=0Then WEPutTxt(W,'Non; peut àtre charger')
     Else
    Begin
     WEPutTxt(W,'Oui; c''est un');
     If _BX and$40=$40Then WEPutTxt(W,' serveur')Else
     If _BX and$4=4Then WEPutTxt(W,'e messagerie')Else
     If _BX and$80=$80Then WEPutTxt(W,' receveur')Else
     If _BX and$8=8Then WEPutTxt(W,'e redirection')
                   Else WEPutTxt(W,' mode inconnue');
    End;
   End;
   4:Begin
    ASM
     MOV AX,0F100h
     XOR BX,BX
     XOR CX,CX
     XOR DX,DX
     INT 2Fh
     MOV _AL,AL
     MOV _SI,SI
     MOV _DI,DI
    END;
    WESetKrHigh(W);
    If(_AL=$FF)and(_SI=$444F{DO})and(_DI=$5358{SX})Then WEPutTxtLn(W,'Oui')
                                                   Else WEPutTxtLn(W,'Non; peut àtre charger');
   End;
   0:Begin
    ASM
     MOV AH,Data.ID
     XOR AL,AL
     XOR BX,BX
     XOR CX,CX
     XOR DX,DX
     INT 2Fh
     MOV _AL,AL
    END;
    WESetKrHigh(W);
    Case(_AL)of
     0:WEPutTxt(W,'Non; peut àtre charger');
     1:WEPutTxt(W,'Non; ne peut àtre charger');
     2,$FF:WEPutTxt(W,'Oui');
     Else WEPutTxt(W,'êtat '+HexByte2Str(_AL)+'h');
    End;
   End;
  End;
  WESetKrBorder(W);
  If P=1Then WELn(W);
  ASM XOR P,1;END;
 End;
 If(Append)Then Begin
  WEPutTxt(W,StrUSpc('APPEND:',17));
  WESetKrHigh(W);
  ASM
   MOV AX,0B706h
   INT 2Fh
   MOV _BX,BX
  END;
  If _BX and$1=1Then WEPutTxt(W,'actif ');
  If _BX and$2000=$2000Then WEPutTxt(W,'/PATH ');
  If _BX and$4000=$4000Then WEPutTxt(W,'/E ');
  If _BX and$8000=$8000Then WEPutTxt(W,'/X');
  WELn(W);
  W.X:=17;
  ASM
   MOV AX,0B704h
   INT 2Fh
   MOV Word Ptr PC,DI
   MOV Word Ptr PC[2],ES
  END;
  WEPutPTxtLn(W,PC);
  WESetKrBorder(W);
 End;
 While WEOk(W)do;
End;

Procedure ShowFuncIntr(Intr:Byte);
Var
 K:Word;
 L:LstMnu;
 Server:DataSet;
 Buffer:Record
  Intr:Byte;
  AH:Byte;
  AL,BH,BL,CH,CL,DH,DL:SmallInt;
  Name:String;
  Description:String;
 End;
 S:String;
 LT:ListTitle;
Begin
 LMInitCenter(L,76,15,'Fonctions de l''Interruption '+HexByte2Str(Intr)+'h',CurrKrs.Dialog.Env.List);
 LTInitWithWins(LT,0,0,L.W.MaxX,'AH|AL|BH|BL|CH|CL|DH|DL|Description',L.W);
 WESetHomeLine(L.W,1);
 LTSetColumnSize(LT,0,3);
 LTSetColumnSize(LT,1,3);
 LTSetColumnSize(LT,2,3);
 LTSetColumnSize(LT,3,3);
 LTSetColumnSize(LT,4,3);
 LTSetColumnSize(LT,5,3);
 LTSetColumnSize(LT,6,3);
 LTSetColumnSize(LT,7,3);
 LTSetColumnSize(LT,8,41);
 LTRefresh(LT);
 DBInitServer(Server,MaltePath+'DATA\AIDE.DAT');
 DBOpenServerName(Server,'AIDE:/Compilateur/Assembleur/InterruptionFonction.Dat');
 If DBLocateAbs(Server,0,Intr,[])Then Begin
  Repeat
   DBReadRec(Server,Buffer);
   If(Intr<>Buffer.Intr)Then Break;
   S:=HexByte2Str(Buffer.AH)+'h ';
   If Buffer.AL<>-1Then AddStr(S,HexByte2Str(Buffer.AL)+'h ')
                   Else AddStr(S,'    ');
   If Buffer.BH<>-1Then AddStr(S,HexByte2Str(Buffer.BH)+'h ')
                   Else AddStr(S,'    ');
   If Buffer.BL<>-1Then AddStr(S,HexByte2Str(Buffer.BL)+'h ')
                   Else AddStr(S,'    ');
   If Buffer.CH<>-1Then AddStr(S,HexByte2Str(Buffer.CH)+'h ')
                   Else AddStr(S,'    ');
   If Buffer.CL<>-1Then AddStr(S,HexByte2Str(Buffer.CL)+'h ')
                   Else AddStr(S,'    ');
   If Buffer.DH<>-1Then AddStr(S,HexByte2Str(Buffer.DH)+'h ')
                   Else AddStr(S,'    ');
   If Buffer.DL<>-1Then AddStr(S,HexByte2Str(Buffer.DL)+'h ')
                   Else AddStr(S,'    ');
   AddStr(S,Buffer.Name);
   ALAddStr(L.List,S);
  Until DBEOF(Server);
 End;
 DBDone(Server);
{ Repeat}
  K:=LMRun(L);
{ Until K=0;}
 LMDone(L);
End;

{⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ‹
 ≥                    ProcÇdure SoftwareIntrInfo                     €
 ¿‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹€


 Description
 ÕÕÕÕÕÕÕÕÕÕÕ

  Cette procÇdure affiche une boåte de dialogue permettant de voir les
 adresses des interruptions logiciels.


 Remarques
 ÕÕÕÕÕÕÕÕÕ

  ˛ Cette procÇdure s'inspire des utilitaires de ÆNortonØ et ÆCentral-
    PointØ: System Information. Dans sa rubrique ÆSoftware InterruptØ.

  ˛ Peut àtre  accessible  via  la procÇdure  ÆMCBInfoØ  car  celle-ci
    permet de sÇlectionner le 1ier Ko oó se trouve les interruptions.
}

Procedure SoftwareIntrInfo;
Var
 L:LstMnu;
 LT:ListTitle;
 K:Word;
 I:Byte;
 LastIntr:Byte;
 DataPtr:Pointer;
 PS:^String Absolute DataPtr;
 Buffer:Array[0..514]of Byte;
 S:String;

 Procedure PushLn(Const D:String;Int:Byte);
 Var
  S:String;
  Ptr:Pointer;
  PL,ML:LongInt;
  MCB:^MCBRec;
  I:Byte;
  SPtr,OPtr:Word;
 Begin
  GetIntVec(Int,Ptr);
  If(Ptr=NIL)Then S:='Inexistant'Else
  Begin
   S:='';
   {$IFNDEF NotReal}
    MCB:=@GetDosBlock^.FirstMCB^;PL:=AddrExt2Conv(Ptr);
    While MCB^.ID in['M','Z']do Begin
     ML:=AddrExt2Conv(MCB);
     If(PL>=ML)and(PL<=ML+Long(Long(MCB^.Size+1)shl 4))and
       (MCB^.Header.Prg=$20CD)Then Begin
      S:=PrgPath(MCB^.PSP);
      If(S='')or Not(StrI(1,S)in MajRomanLetter)Then Begin
       S:=ReadRomAddr(@MCB^.Name,8);I:=Pos(#0,S);
       If I>0Then S[0]:=Chr(I-1);
      End
       Else
      If Length(S)>=25Then S:=Path2NoDir(S);
      Break;
     End;
     Inc(PtrRec(MCB).Seg,MCB^.Size+1);
    End;
    If S=''Then Begin
     SPtr:=PtrRec(GetDosBlock).Seg;
     OPtr:=PtrRec(GetDosBlock).Ofs+$0022+4;
     While(OPtr<$FFFF)do Begin
      If(PL>=Long(Long(SPtr shl 4)+Long(OPtr)))and
        ((PL<=Long(Long(SPtr shl 4)+Long(MemW[SPtr:OPtr+6])))or
         (PL<=Long(Long(SPtr shl 4)+Long(MemW[SPtr:OPtr+8]))))Then Begin
       S:='';
       If Mem[SPtr:OPtr+5]and$80=0Then AddStr(S,Str2(Mem[SPtr:OPtr+10],15))
        Else
       Begin
        For I:=10to 17do If Char(Mem[SPtr:OPtr+I])in[' '..'~']Then
         IncStr(S,Char(Mem[SPtr:OPtr+I]))
        Else
         IncStr(S,'.');
       End;
       Break;
      End;
      ASM
       MOV ES,SPtr
       MOV BX,OPtr
       MOV AX,ES:[BX]
       MOV OPtr,AX
       MOV AX,ES:[BX+2]
       MOV SPtr,AX
      END;
     End;
    End;
   {$ENDIF}
   If S=''Then Begin
    If PtrRec(Ptr).Seg=$FFFFThen S:='HMA'Else
    If PtrRec(Ptr).Seg>=$C000Then S:='ROM Bios'
                             Else S:='Dos ou Application';
   End;
  End;
  ALAddStrByte(L.List,HexByte2Str(Int)+'h  '+StrUSpc(D,41)+
  HexWord2Str(PtrRec(Ptr).Seg)+'h:'+
  HexWord2Str(PtrRec(Ptr).Ofs)+'h '+S,Int);
 End;

Begin
 LMInitCenter(L,76,15,'Information sur les Interruptions logicielle',CurrKrs.Dialog.Env.List);
 LTInitWithWins(LT,0,0,L.W.MaxX,'#|Description|Adresse|PropriÇtaire',L.W);
 WESetHomeLine(L.W,1);
 LTSetColumnSize(LT,0,4);
 LTSetColumnSize(LT,1,40);
 LTSetColumnSize(LT,2,11);
 LTRefresh(LT);
 DBOpenServerName(ChantalServer,'CHANTAL:/Materiel/Interruption.Dat');
 DBFirst(ChantalServer);
 LastIntr:=$FF;
 Repeat
  DBReadRec(ChantalServer,Buffer);
  PS:=@Buffer;
  DBGotoColumnAbs(ChantalServer,2,DataPtr);
  If PS^=''Then Begin
   PS:=@Buffer;
   DBGotoColumnAbs(ChantalServer,1,DataPtr);
  End;
  If LastIntr<Buffer[0]-1Then For I:=LastIntr+1to Buffer[0]-1do Begin
   PushLn('RÇservÇ',I);
  End;
  LastIntr:=Buffer[0];
  PushLn(PS^,LastIntr);
 Until DBEOF(ChantalServer);
 For I:=$7Bto($7F)do PushLn('RÇservÇ',I);
 For I:=$80to($F0)do PushLn('RÇservÇ pour l''InterprÇteur Basic',I);
 For I:=$F1to($FF)do PushLn('RÇservÇ',I);
 Repeat
  K:=LMRun(L);
  Case(K)of
   $2F:MultiplexIntInfo;
   0:;
   Else ShowFuncIntr(K);
  End;
 Until K=0;
 LMDone(L);
End;

{⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ‹
 ≥                         ProcÇdure GraphResource                   €
 ¿‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹€


 Description
 ÕÕÕÕÕÕÕÕÕÕÕ

  Cette procÇdure permet de retournÇe divers information sous forme de
 graphique sur l'utilisation des ressources mÇmoires du systäme par le
 SEX et l'application.
}

Procedure GraphResource;
Var
 Data:Array[0..5]of Record
  Used:String[5];
  Free:String[5];
  Degree:Word;
 End;
 I:Byte;
 EArc:Word;
Begin
 If(IsGrf)Then Begin
  FillClr(Data,SizeOf(Data));
  For I:=0to 5do Begin
   Case(I)of
    0:Begin
     If SizeOfRAMConv=0Then EArc:=0
     Else EArc:=Trunc((MemAvail/(Long(SizeOfRAMConv)shl 10))*360);
    End;
    1:Begin
     If AppResSize(rmDsk)=0Then EArc:=0
     Else EArc:=Trunc((AppResFree(rmDsk)/AppResSize(rmDsk))*360);
    End;
    2:Begin
     If XmsTotalSize=0Then EArc:=0
     Else EArc:=Trunc((AppResFree(rmXms)/XmsTotalSize)*360);
    End;
    3:Begin
     If EmmTotalSize=0Then EArc:=0
     Else EArc:=Trunc((AppResFree(rmEms)/EmmTotalSize)*360);
    End;
    4:EArc:=DivLong(0,SizeOfUMB);
    5:Begin
     If GetVidMem=0Then EArc:=0
     Else EArc:=Trunc((AppResFree(rmVram)/(GetVidMem shr 10))*360);
    End;
   End;
   Data[I].Degree:=360-EArc;
   EArc:=Trunc(EArc/3.6);
   Data[I].Used:=WordToStr(100-EArc)+'%';
   Data[I].Free:=WordToStr(EArc)+'%';
  End;
  ExecuteAppDPU(83,Data);
 End;
End;

{ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ}
END.