{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴콘
 �                                                              �
 �                S   Y   S    I    N    F     O                �
 �                                                              �
 �                             pour                             �
 �                                                              �
 �      L'ensemble Malte Genesis III & IV: Isabel & Chantal     �
 � Tous droits r굎erv굎 par les Chevaliers de Malte 1995 � 1997 �
 �                                                              �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複蔔


 Description
 袴袴袴袴袴�

  Cette programme permet de conna똳re diverses informations sur la machine
 actuellement en fonction  tout comme le fait par exemple le  췚ysInfo� de
 Norton ou 췚I� de Central-Point.
}

Program SystemeInformation;
{$I Def.Inc}
Uses {$IFDEF Adele}Adele,{$ELSE}Chantal,{$ENDIF}Dialex,DialPlus,ToolView,Math,
     Dos,Systex,Isatex,Systems,Video,Mouse,Dials,ToolInfo,InfoMemory,ToolVid,
     SysInter,BBStex,CommBase;

Const siNew=$F001;
      siSomary=$F002;
      siCountry=$F003;
      siSoftInt=$F004;
      siConfigSys=$F005;
      siAutoExecBat=$F006;
      siDblSpaceIni=$F007;
      siControlIni=$F008;
      siSystemIni=$F009;
      siWinIni=$F00A;
      siGeosIni=$F00B;
      siMbIni=$F00C;
      siMCB=$F00D;
      siCmos=$F00E;
      siRAMBIOS=$F00F;
      siVideo1=$F010;
      siVideo2=$F011;
      siKeyboard=$F012;
      siJoystick=$F013;
      siMouse=$F014;
      siMultiplexInt=$F015;
      siDevice=$F016;
      siDskLogical=$F017;
      siModemRegister=$F018;
      siVESA=$F019;
      siTestScroll=$F01A;
      siAbout=$F01B;
      siShell=$F01C;
      siUtilityMemory=$F01D;
      siExit=$F0FF;

Procedure MakeMnu;Begin
 PMInit;
 PMAddMnu('^S^yst둴e');
  PMAddItemKey('^S^ommaire',kbNoKey,siSomary,'Permet de conna똳re les informations sommaire relativement � ce syst둴e');
  PMAddItemKey('^P^ays',kbNoKey,siCountry,'Indique la configuration du pays ou r괾ion '+
               'actuellement en op굍ation sur le syst둴e');
  PMAddItemKey('^D^evice',kbNoKey,siDevice,'Permet de conna똳re la composition des devices du syst둴e d''exploitation');
  PMAddItemKey('Interruption ^L^ogiciel',kbNoKey,siSoftInt,'Permet d''examiner la liste des interruptions');
  PMAddItemKey('Interruption ^M^ultiplex (2Fh)',kbNoKey,siMultiplexInt,'Permet de conna똳re les pilotes '+
                                                            'suppl굆entaire install굎 au syst둴e d''exploitation.');
  PMAddItemKey('S^h^ell et ses extensions',kbNoKey,siShell,'Permet de conna똳re l''existe des Shells de remplacement.');
  PMAddBarItem;
  PMAddItemKey('^1^ CONFIG.SYS',kbNoKey,siConfigSys,'Permet de conna똳re le contenu du fichier configuration 췈ONFIG.SYS�');
  PMAddItemKey('^2^ AUTOEXEC.BAT',kbNoKey,siAutoExecBat,
               'Permet de conna똳re le contenu du fichier de d굆arrage 췆UTOEXEC.BAT�');
  PMAddItemKey('^3^ DBLSPACE.INI',kbNoKey,siDblSpaceIni,
               'Permet de conna똳re le contenu du fichier de configuration de DoubleSpace');
  PMAddItemKey('^4^ CONTROL.INI',kbNoKey,siControlIni,'Permet de conna똳re le contenu du fichier de contr뱇e de Windows');
  PMAddItemKey('^5^ SYSTEM.INI',kbNoKey,siSystemIni,'Permet de conna똳re le contenu du fichier de syst둴e de Windows');
  PMAddItemKey('^6^ WIN.INI',kbNoKey,siWinIni,'Permet de conna똳re le contenu du fichier d''initialisation de Windows');
  PMAddItemKey('^7^ GEOS.INI',kbNoKey,siGeosIni,'Permet de conna똳re le contenu du fichier d''initialisation de GeoWorks');
  PMAddItemKey('^8^ MB.INI',kbNoKey,siMbIni,'Permet de conna똳re le contenu du fichier d''initialisation du MonsterBook');
  PMAddBarItem;
  PMAddItemKey('^Q^uitter',kbAltX,siExit,'Quitter le programme');
 PMAddMnu('^M^굆oire');
  PMAddItemKey('^C^mos',kbNoKey,siCmos,'Pour conna똳re les informations contenu dans l''horloge sur pile (CMOS)');
  PMAddItemKey('RAM ^B^IOS',kbNoKey,siRAMBIOS,'Permet d''obtenir le contenu des informations sur le segment 0040h du BIOS');
  PMAddItemKey('Bloc de m굆oire DOS (^M^CB)',kbNoKey,siMCB,'Pour conna똳re les informations '+
               'sur les structures m굆oires des programmes');
  PMAddBarItem;
  PMAddItemKey('^U^tilitaire m굆oire',kbNoKey,siUtilityMemory,
               'Permet de conna똳re les informations sp괹ifique au pilote m굆oire');
 PMAddMnu('^V^id굊');
  PMAddItemKey('^S^ommaire primaire',kbNoKey,siVideo1,'Permet de conna똳re '+
               'des informations sommaires con놽rnant le vid굊 active');
  PMAddItemKey('Sommaire secon^d^aire',kbNoKey,siVideo2,'Permet de conna똳re '+
               'des informations sommaires con놽rnant le vid굊 inactive');
  PMAddItemKey('^V^ESA',kbNoKey,siVESA,'Permet de conna똳re les informations sur le standard VESA de votre carte');
  PMAddBarItem;
  PMAddItemKey('^T^este de d괽ilement',kbNoKey,siTestScroll,'Teste le d괽ilement des cartes VGA ou post굍ieurs');
 PMAddMnu('^D^isque');
  PMAddItemKey('^L^ogique',kbNoKey,siDskLogical,'Information sur les unit굎 logique du syst둴e');
 PMAddMnu('M^o^dem');
  PMAddItemKey('^R^egistre',kbNoKey,siModemRegister,'Information sur les registres de votre modem');
 PMAddMnu('^E^ntr괻');
  PMAddItemKey('^C^lavier',kbNoKey,siKeyboard,'Permet de conna똳re les informations de base sur le clavier');
  PMAddItemKey('Manette de ^J^eux',kbNoKey,siJoystick,'Permet de savoir les informations de base sur la manette de jeux');
  PMAddItemKey('^S^ouris',kbNoKey,siMouse,'Permet dans conna똳re le mod둳e de souris install괻');
 PMAddMnu('^A^ide');
  PMAddItemKey('^A^ propos...',kbNoKey,siAbout,'A propos de ce programme...');
 PMPutMnuBar;
End;

Var K,M:Wd;

Procedure TestScroll;Var J,I,X,Y,XDir,YDir,IDir:Wd;Output:ImgRec;Begin
 PushScr(Output);
 SetVideoMode(vmTxtDef);
 If Not(IsVGA)Then Begin                                      { Les cartes MDA, CGA et EGA ne supporte pas cette technique}
  ErrMsgOk('Carte VGA r괹lam� pour ce genre d''effet sp괹iaux!');
  Exit;
 End;
 SetBytesPerLn(320);                                          { Double la largeur des bandes (normalement � 160) }
 FillBox(0,0,159,49,'-',7);                                   { Affiche une tapiserie vulgaire }
 For J:=0to 49do For I:=0to 15do PutTxtXYUnKr(10*I,J,Str(I)); { Affiche les chiffres de colonnes...}
  {***D굋lacement Vertical}
 Y:=0;YDir:=1;
 Repeat
  Inc(Y,YDir);If(Y<=0)or(Y>=NmYTxts*16)Then YDir:=-YDir;
  SetVerticalScale(Y);
 Until KeyPress;
 ReadKey;
  {***D굋lacement Horizontal***}
 X:=0;XDir:=1;
 Repeat
  Inc(X,XDir);If(X<=0)or(X>=NmXTxts*9)Then XDir:=-XDir;
  SetHorizontalScale(X);
 Until KeyPress;
 ReadKey;
  {***D굋lacement bidimensionnel***}
 Repeat
  Inc(X,XDir);If(X<=0)or(X>=NmXTxts*9)Then XDir:=-XDir;
  Inc(Y,YDir);If(Y<=0)or(Y>=NmYTxts*16)Then YDir:=-YDir;
  SetVerticalScale(Y);SetHorizontalScale(X);
 Until KeyPress;
 ReadKey;
  {***Superposition de page***}
 FillBox(0,0,159,49,'�',$70);
 SetPg(1);
 FillBox(0,0,159,49,'-',7);
 For J:=0to 49do For I:=0to 15do PutTxtXYUnKr(10*I,J,Str(I));
 X:=0;XDir:=1;Y:=0;YDir:=1;I:=0;IDir:=1;
 Repeat
  Inc(X,XDir);Inc(Y,YDir);Inc(I,IDir);
  If(I<=0)or(I>=NmYTxts*16)Then IDir:=-IDir;
  If(X<=0)or(X>=NmXTxts*9)Then XDir:=-XDir;
  If(Y<=0)or(Y>=NmYTxts*16)Then YDir:=-YDir;
  SplitScreen(I);
  SetVerticalScale(Y);
  SetHorizontalScale(X);
 Until KeyPress;
 ReadKey;
 SetVideoMode(vmTxtDef);
 PopScr(Output);
End;

Procedure ViewFiles(Path:String);Var Q:VA;W:Window;K:Wd;S:String;Begin
 S:=FSearch(Path,';C:\;'+GetEnv('PATH'));
 If S=''Then Begin
  For K:=67to 90do If DrvExist(Chr(K))Then Begin
   S:=FSearch(Path,Chr(K)+':\;'+Chr(K)+':\WINDOWS;'+Chr(K)+':\MALTE;'+
                   Chr(K)+':\GEOWORKS');
   If S<>''Then Break;
  End;
 End;
 If S=''Then Begin;__FileNotFound(Path);Exit;End;
 WEInit(W,1,3,MaxXTxts-1,MaxYTxts-1);WEPushWn(W);
 VAInit(Q,1,3,MaxXTxts-1,MaxYTxts-1,S,No);
 Repeat
  K:=VARun(Q);
  If(K=kbEsc)or(K=kbClose)Then Break;
 Until No;
 VADone(Q);
 WEDone(W);
End;

Function ChoiceModem:Byte;
Var
 L:LstMnu;
 K:Word;
Begin
 LMInitCenter(L,20,10,'Choisir Modem',CurrKrs.Dialog.Wins);
 RBAddStrByte(L.List,'COM1:',1);
 RBAddStrByte(L.List,'COM2:',2);
 RBAddStrByte(L.List,'COM3:',3);
 RBAddStrByte(L.List,'COM4:',4);
 RBAddStrByte(L.List,'COM5:',5);
 RBAddStrByte(L.List,'COM6:',6);
 RBAddStrByte(L.List,'COM7:',7);
 RBAddStrByte(L.List,'COM8:',8);
 LMGotoPos(L,M);
 ChoiceModem:=LMRun(L);
 LMDone(L);
End;

Procedure About;
Var
 W,W2:Window;
 I:Byte;
 K:Word;
Begin
 WEInitO(W,39,12);
 WEPushWn(W);
 WEPutWnKrDials(W,'A propos!');
 WELn(W);
 WEPutOTxt(W,'SysInfo');
 WELn(W);
 WEPutOTxt(W,'Version 3.0');
 WELn(W);
 WEPutOTxt(W,'Tous droits r굎erv굎 (c) par');
 WELn(W);
 WEPutOTxt(W,'Les Chevaliers de Malte');
 Repeat
  K:=WEGetkHorDn(W,'Correcte|D굏ails');
  Case(K)of
   0,kbAbort:Break;
   1:Begin
    WEInitO(W2,40,20);
    WEPushWn(W2);
    WEPutWnKrDials(W2,'A propos D굏aill�');
    WELn(W2);
    WEPutTxtLn(W2,'Fabriqu� au:      Qu괷ec Libre!!!');
    WEPutTxtLn(W2,'릀rit en:         Borland Pascal 7');
    WEPutTxtLn(W2,'Lignes de code:   10 000 Pascal');
    WEPutTxtLn(W2,'                  10 000 Assembleur');
    WEPutTxtLn(W2,'Taille du Source: 1,5 MegaOctets');
    WEPutTxtLn(W2,'Biblioth둸ues:    Malte Genesis IV');
    WEPutTxtLn(W2,'                  Alias Chantal');
    WEPutTxtLn(W2,'      & Extension Malte Genesis V');
    WEPutTxtLn(W2,'                  Alias Ad둳e');
    WEPutTxtLn(W2,'Date de frabric.: F굒rier 1998');
    WEPutTxtLn(W2,'M굏hode de fabr.: Un soir... et!');
    WELn(W2);
    WEPutTxtLn(W2,'Programmeur/Concepteur/Analyste:');
    WELn(W2);
    WEPutTxtLn(W2,' Sylvain Maltais');
    While WEOk(W2)do;
   End;
  End;
 Until No;
 WEDone(W);
End;

{$I Library\System\Dos\Shell\KStack.Inc}
{$I Library\System\Dos\Shell\WildUnix.Inc}
{$DEFINE Macro}
{$I Library\System\Dos\Shell\Anarkey.Inc}
{$UNDEF Macro}

Procedure Shell;
Var
 W:Window;
 _AX,_CX:Word;
 _BL,_BH,_DL:Byte;
Begin
 WEInitO(W,70,10);
 WEPushWn(W);
 WEPutWnKrDials(W,'Shell et ses extensions');
 WEPutTxt(W,StrUSpc('Shell par d괽aut:',26));
 WESetKrHigh(W);
 WEPutTxtLn(W,GetEnv('COMSPEC'));
 WESetKrBorder(W);
 WEPutTxt(W,StrUSpc('4DOS (logiciel JP):',26));
 ASM
  MOV AX,0D44Dh
  XOR BX,BX
  XOR CX,CX
  XOR DX,DX
  INT 2Fh
  MOV _AX,AX
  MOV _CX,CX
  MOV _BL,BL
  MOV _BH,BH
  MOV _DL,DL
 END;
 WESetKrHigh(W);
 If _AX<>$44DDThen WEPutTxtLn(W,'Absent')
  Else
 WEPutTxtLn(W,'Pr굎ent; Version '+StrW(_BL)+DeSep[0]+StrW(_BH)+'; No: '+StrW(_DL)+' PSP: '+HexWord2Str(_CX)+'h');
 WESetKrBorder(W);
 WEPutTxt(W,StrUSpc('KSTACK.COM (logiciel JP):',26));
 WESetKrHigh(W);
 If(KStack)Then WEPutTxtLn(W,'Pr굎ent')Else WEPutTxtLn(W,'Absent');
 WESetKrBorder(W);
 WEPutTxt(W,StrUSpc('Norton NDOS (Symantec):',26));
 ASM
  MOV AX,0E44Dh
  XOR BX,BX
  XOR CX,CX
  XOR DX,DX
  INT 2Fh
  MOV _AX,AX
  MOV _BL,BL
  MOV _BH,BH
  MOV _DL,DL
  MOV _CX,CX
 END;
 WESetKrHigh(W);
 If _AX<>$44EEThen WEPutTxtLn(W,'Absent')
  Else
 WEPutTxtLn(W,'Pr굎ent; Version '+StrW(_BL)+DeSep[0]+StrW(_BH)+'; No: '+StrW(_DL)+' PSP: '+HexWord2Str(_CX)+'h');
 WESetKrBorder(W);
 WEPutTxt(W,StrUSpc('WildUnix:',26));
 WESetKrHigh(W);
 If(WildUnixShell)Then WEPutTxtLn(W,'Pr굎ent')Else WEPutTxtLn(W,'Absent');
 WESetKrBorder(W);
 WEPutTxt(W,StrUSpc('Anarkey:',26));
 WESetKrHigh(W);
 Case(AnarkeyShell)of
  $00:WEPutTxtLn(W,'Absent');
  $FE:WEPutTxtLn(W,'Pr굎ent mais suspendu');
  $FF:WEPutTxtLn(W,'Pr굎ent et actif');
  Else WEPutTxtLn(W,'Inconnu');
 End;
 WESetKrBorder(W);
 While WEOk(W)do;
End;

{$I Library\LongCall.Inc}
{$I Library\Memories\EMS\386MaxHeader.Inc}

Procedure UtilityMemory;
Var
 W:Window;
 _AL,_AH,_CL,_CH,Id,T:Byte;
 _AX,_BX,_CX,_DX,_DS,_ES,_DI,_SI:Word;
 Ok:Boolean;
 Regs:Registers;
 S:String;
 V386MaxBuf:V386MaxBufType;
 Vec:Pointer;
Begin
 WEInitO(W,76,18);
 WEPushWn(W);
 WEPutWnKrDials(W,'Utilitaire m굆oire');
 WEPutTxt(W,StrUSpc('QEMM:',26));
 Id:=$D2;Ok:=No;
 Repeat
  ASM
   MOV AH,0D2h
   XOR AL,AL
   MOV BX,5144h {'QD'}
   MOV CX,4D45h {'ME'}
   MOV DX,4D30h {'M0'}
   INT 2Fh
   MOV _AL,AL
   MOV _BX,BX
   MOV _CX,CX
   MOV _DX,DX
  END;
  If(_AL=$FF)and(_BX=$4D45)and(_CX=$4D44)and(_DX=$5652)Then Ok:=Ya
   Else
  Begin
   If Id<$FFThen Inc(Id)Else Id:=$C0;
  End;
 Until(Ok)or(Id=$D2);
 WESetKrHigh(W);
 If Not(Ok)Then WEPutTxtLn(W,'Absent')
  Else
 Begin
  ASM
   MOV AH,Id
   MOV AL,1
   MOV BX,5145h {'QE'}
   MOV CX,4D4Dh {'MM'}
   MOV DX,3432h {'42'}
   INT 2Fh
   MOV _BX,BX
   MOV _ES,ES
   MOV _DI,DI
  END;
  If _BX=$4F4B{'OK'}Then Begin
   WEPutTxt(W,'Oui; Entr괻 API: '+HexWord2Str(_ES)+'h:'+HexWord2Str(_DI)+'h; Version ');
   LongCall(LongInt(_ES)shl 16+_DI,Regs);
   If Regs.Flags and$1=1Then WEPutTxtLn(W,StrW(ToBCD(Regs.BH))+DeSep[0]+StrW(ToBCD(Regs.BL)))
                        Else WEPutTxtLn(W,'Erreur');
  End
   Else
  WEPutTxtLn(W,'Non');
 End;
 WESetKrBorder(W);
 WEPutTxt(W,StrUSpc('Quarterdeck Manifest:',26));
 ASM
  MOV AH,Id
  MOV AL,1
  MOV BX,4D41h {'MA'}
  MOV CX,4E49h {'NI'}
  MOV DX,4645h {'FE'}
  INT 2Fh
  MOV _BX,BX
 END;
 WESetKrHigh(W);
 If _BX=$5354{'ST'}Then WEPutTxtLn(W,'Oui')Else WEPutTxtLn(W,'Non');
 WESetKrBorder(W);
 WEPutTxt(W,StrUSpc('Quarterdeck VIDRAM:',26));
 ASM
  MOV AH,Id
  MOV AL,1
  MOV BX,5649h {'VI'}
  MOV CX,4452h {'DR'}
  MOV DX,414Dh {'AM'}
  INT 2Fh
  MOV _BX,BX
  MOV _ES,ES
 END;
 WESetKrHigh(W);
 If _BX=$4F4B{'OK'}Then WEPutTxtLn(W,'Oui; au code de segment: '+HexWord2Str(_ES)+'h')
                   Else WEPutTxtLn(W,'Non');
 WESetKrBorder(W);
 WEPutTxt(W,StrUSpc('386Max:',26));
 WESetKrHigh(W);
 S:='386MAX$$'#0;_DS:=Seg(S);_DX:=Ofs(S)+1;
 ASM
  PUSH DS
   MOV AX,3D00h
   MOV DS,_DS
   MOV DX,_DX
   INT 21h
   LAHF
   AND AH,1
   MOV Ok,AH
   MOV _AX,AX
  POP DS
 END;
 If(Ok)Then WEPutTxtLn(W,'Non')
  Else
 Begin
  V386MaxBuf.Version:=3;_DS:=Seg(V386Maxbuf);_DX:=Ofs(V386Maxbuf);T:=_AX;
  ASM
   PUSH DS
    MOV AX,4402h
    MOV BX,_AX
    XOR BH,BH
    MOV CX,005Ah
    MOV DS,_DS
    MOV DX,_DX
    INT 21h
    LAHF
    AND AH,1
    MOV Ok,AH
   POP DS
  END;
  If(Ok)Then WEPutTxtLn(W,'Peut-늯re; mais l''appel au IOCTL a 괹hou�')Else
  If V386MaxBuf.Signature<>'386MAX'Then WEPutTxtLn(W,'Non; mauvais signature "'+V386MaxBuf.Signature+'"')
   Else
  Begin
   WEPutTxt(W,'Oui; Version '+V386MaxBuf.VerStr[1]+DeSep[0]+
              V386MaxBuf.VerStr[3]+V386MaxBuf.VerStr[4]+'; segment: '+
              HexWord2Str(V386MaxBuf.LowSeg)+'h; EMS ');
   If V386MaxBuf.Flags1 and$80=$80Then WEPutTxt(W,'actif')Else WEPutTxt(W,'inactif');
   If V386MaxBuf.Flags4 and$1<>1Then WEPutTxt(W,'; Windows 3 support�');
   WELn(W);
  End;
  ASM
   MOV AH,3Eh
   MOV BL,T
   XOR BH,BH
   INT 21h
  END;
 End;
 WESetKrBorder(W);
 WEPutTxt(W,StrUSpc('MICEMM:',26));
 WESetKrHigh(W);
 If Not(EmmExist)Then WEPutTxtLn(W,'Non')
  Else
 Begin
  ASM
   MOV AX,58F0h
   INT 67h
   MOV _AH,AH
   MOV _BX,BX
  END;
  If _AH<>0Then WEPutTxtLn(W,'Non')
           Else WEPutTxtLn(W,'Oui; Segment de code: '+HexWord2Str(_BX)+'h');
 End;
 WESetKrBorder(W);
 WEPutTxt(W,StrUSpc('EMM386:',26));
 If Not(EmmExist)Then WEPutTxtLn(W,'Non')
  Else
 Begin
  ASM
   MOV AX,0FFA5h
   INT 67h
   MOV _AX,AX
   MOV _BX,BX
   MOV _CX,CX
  END;
  WESetKrHigh(W);
  If _AX<>$845AThen WEPutTxtLn(W,'Non')
   Else
  Begin
   WEPutTxt(W,'Oui; Entr괻 API: '+HexWord2Str(_BX)+'h:'+HexWord2Str(_CX)+'h; 릘at: ');
   Regs.AH:=0;
   LongCall(LongInt(_BX)shl 16+_CX,Regs);
   If Regs.AL and$1=1Then WEPutTxtLn(W,'ouvert')Else WEPutTxtLn(W,'fermer');
   Regs.AX:=$0200;
   LongCall(LongInt(_BX)shl 16+_CX,Regs);
   WEPutTxt(W,Spc(26)+'Weitek: ');
   If Regs.AL and$1=1Then Begin
    If Regs.AL and$2=2Then WEPutTxtLn(W,'pr굎ent et actif')
                      Else WEPutTxtLn(W,'pr굎ent et inactif');
   End
    Else
   WEPutTxtLn(W,'pas pr굎ent');
  End;
 End;
 WESetKrBorder(W);
 WEPutTxt(W,StrUSpc('Virtual DMA Specifi.(VDS):',26));
 WESetKrHigh(W);
 GetIntVec($4B,Vec);
 If(Vec=NIL)Then WEPutTxtLn(W,'Non')
  Else
 Begin
  ASM
   MOV AX,8102h
   XOR DX,DX
   STC
   INT 4Bh
   MOV _AL,AL
   MOV _AH,AH
   MOV _BX,BX
   MOV _CL,CL
   MOV _CH,CH
   MOV _DX,DX
   MOV _SI,SI
   MOV _DI,DI
  END;
  WEPutTxt(W,'Oui; Version '+StrW(_AH)+DeSep[0]+StrW(_AL)+'; ');
  Case(_BX)of
   $0000:WEPutTxt(W,'QMAPS/HPMM');
   $0001:WEPutTxt(W,'EMM386.EXE');
   $0003:WEPutTxt(W,'Windows 3');
   $0EDC:WEPutTxt(W,'EMM386.SYS du DR-DOS 6.0');
   $4560:WEPutTxt(W,'386^Max');
   $4D53:WEPutTxt(W,'Memory Commander');
   $5145:WEPutTxt(W,'QEMM');
   $524D:WEPutTxt(W,'RM386');
   Else WEPutTxt(W,StrW(_BX));
  End;
  WEPutTxt(W,'; Revision '+StrW(_CH)+DeSep[0]+StrW(_CL));
  WELn(W);
  WEPutTxtLn(W,Spc(26)+'Taille maximal du tampon DMA: '+CStr((Long(_SI)*65536+_DI)shr 10)+' Ko');
  WEPutTxt(W,Spc(26)+'Transfert permit dans ');
  If _DX and$1=1Then WEPutTxtLn(W,'le premier 1 Mo')Else WEPutTxtLn(W,'n''importe quel adresse!');
  WEPutTxt(W,Spc(26)+'Tampon dans le premier Meg: ');
  If _DX and$2=2Then WEPutTxtLn(W,'Oui')Else WEPutTxtLn(W,'Non');
  WEPutTxt(W,Spc(26)+'Auto-r괶llocation active: ');
  If _DX and$4=4Then WEPutTxtLn(W,'Oui')Else WEPutTxtLn(W,'Non');
  WEPutTxt(W,Spc(26)+'M굆oire continue: ');
  If _DX and$8=8Then WEPutTxtLn(W,'Oui')Else WEPutTxtLn(W,'Non');
  WEPutTxt(W,Spc(26)+'Bit de donn괻 BIOS fix괻: ');
  If Mem[_0040:$7B]and$20=$20Then WEPutTxtLn(W,'Oui')Else WEPutTxtLn(W,'Non');
 End;
 WESetKrBorder(W);
 While WEOk(W)do;
End;

{$I Library\System\Malte\Presenta.tio\PutTapis.Inc}

Var Output:ImgRec;

BEGIN
 InitSystems(suIsabel);
 PathDskSwp:=FileExpand('SYSINFO.$$$');
 InitMemManagers;
 PushScr(Output);
 SetVideoModeDeluxe(vmTxtDef);
 InitEnv;
 PutTapis(0,MaxYTxts,$87);
 __InitMouse;
 MakeMnu;
 M:=1;
 Repeat
  K:=PMWaitForMnuAction;
  Case(K)of
   siSomary:SomaryInfo;
   siCountry:CountryInfo;
   siSoftInt:SoftwareIntrInfo;
   siConfigSys:ViewFiles('CONFIG.SYS');
   siAutoExecBat:ViewFiles('AUTOEXEC.BAT');
   siDblSpaceIni:ViewFiles('DBLSPACE.INI');
   siControlIni:ViewFiles('CONTROL.INI');
   siSystemIni:ViewFiles('SYSTEM.INI');
   siWinIni:ViewFiles('WIN.INI');
   siGeosIni:ViewFiles('GEOS.INI');
   siMBIni:ViewFiles('MB.INI');
   siCmos:CmosInfo;
   siMCB:MCBInfo;
   siRAMBIOS:CarteBios;
   siVideo1:VideoInfo(0);
   siVideo2:VideoInfo(1);
   siKeyboard:KeyboardInfo;
   siJoystick:JoystickInfo;
   siMouse:MouseInfo;
   siMultiplexInt:MultiplexIntInfo;
   siDevice:DeviceInfo;
   siDskLogical:DskInfo;
   siModemRegister:Begin
    M:=ChoiceModem;
    If M<>0Then Begin
     InitAC(0,0,0,0,0);
     ACOpen(M,BaudRate,Parity,DataBits,StopBits);
     ModemDoctor;
     ACClose(Ya);
    End;
   End;
   siVESA:VesaInfo;
   siTestScroll:TestScroll;
   siAbout:About;
   siShell:Shell;
   siUtilityMemory:UtilityMemory;
   kbAltX:K:=siExit;
  End;
 Until K=siExit;
 DoneLuxeVideo;
 PopScr(Output);
 DoneMemManagers;
 DoneSystems;
END.