{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³           Malte Genesis/Module de chargement de l'‚diteur             Û
 ³           dition Chantal pour Mode R‚el/IV - Version 1.1             Û
 ³                             1996/10/10                                Û
 ³                                                                       Û
 ³         Tous droits r‚serv‚s par les Chevaliers de Malte (C)          Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Nom du programmeur
 ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ

  Sylvain Maltais


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette  proc‚dure  permet  le chargement  d'un document,  d'un fichier de
 langage de programmation, Batch ou ®.INI¯ pour l'‚diteur de traŒtement de
 texte utilisable par l'utilisateur dans l'unit‚ ®Editor¯.
}

Unit EdtLoad;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                                INTERFACE
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

{$I DEF.INC}

Uses Systex,Isatex;

Procedure TEInit(Var Q:EditorApp;Const Name:String);
Procedure TELoad2Save(Var Q:EditorApp;Const Name:String);
Function  TENew(Var Q;X1,Y1,X2,Y2:Byte):Boolean;
Function  TENewHTML(Var Context;X1,Y1,X2,Y2:Byte):Boolean;
Function  TENewHTMLDocument(Var Context;X1,Y1,X2,Y2:Byte):Boolean;
Procedure TENewDocument(Var Q:EditorApp;X1,Y1,X2,Y2:Byte);
Procedure TEOpen(Var Context;X1,Y1,X2,Y2:Byte;Const _Name:String);
Procedure TEOpenSpecialTitle(Var Q:EditorApp;X1,Y1,X2,Y2:Byte;Const Name,Title:String);
Procedure TEInsFile(Var Q:EditorApp;Const Path:String);
Procedure TEInsImage(Var Q:EditorApp;Path:String);
Procedure TEPasteClipBoard(Var Q:EditorApp);
Procedure TEPasteClipboardWindows(Var Q:EditorApp);

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                               IMPLEMENTATION
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Uses
 Adele,Memories,Systems,Dials,Dialex,DialPlus,Editex,Editor,EdtDone,EdtExtra,
 WordTex,Math,ResServI,ResLoadI,ResServD,ResTex,SysPlus;

{$I \Source\Chantal\_TESetMo.Inc}
{$I TESetPtr.Inc}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ·}
{³                     Z o n e  P r i v ‚ s                    º}
{ÔÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼}

Procedure _TEInsFile(Var Q:EditorApp;Path:String;ClipBoard:Boolean);Near;Forward;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                            Fonction CmpPLeft                             Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction compare le d‚but d'une chaŒnes de caractŠres de style ASCIIZ
 (genre C, PChar) avec une chaŒne de caractŠres de format Pascal.
}

Function CmpPLeft(Buffer:PChr;Const S:String):Boolean;Near;Assembler;ASM
 {$IFDEF FLAT386}
  LEA EAX,DWord Ptr Buffer
  LEA EBX,DWord Ptr S
  INC EBX
  MOVZX CX,Byte Ptr [EAX]
  CALL Compare
 {$ELSE}
  LES DI,Buffer
  PUSH ES
  PUSH DI
  LES DI,S
  PUSH ES
  MOV AX,DI
  INC AX
  PUSH AX
  MOV AL,ES:[DI]
  XOR AH,AH
  PUSH AX
  CALL Compare
 {$ENDIF}
END;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Proc‚dure _QGetRec                            Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


  Description
  ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de lire un num‚ro d'enregistrement … partir d'un
 fichier ou du presse-papier (si le Handle corrrespond … celui-ci).
}

Procedure QGetRec(Handle:Hdl;P,Size:Word;Var X);Begin
 If(Handle=hdlClipBoard)Then GetAbsClipBoard(P*Size,Size,X)
                        Else GetRec(Handle,P,Size,X);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Fonction _QGetAbsRec                          Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


  Description
  ÍÍÍÍÍÍÍÍÍÍÍ

   Cette proc‚dure permet de lire un enregistrement … une position absolue …
  partir d'un fichier ou du presse-papier (si le Handle corrrespond … celui-ci).
}

Function _QGetAbsRec(Handle:Hdl;P:LongInt;Size:Word;Var X):Word;Begin
 If(Handle=hdlClipBoard)Then _QGetAbsRec:=GetAbsClipBoard(P,Size,X)
                        Else _QGetAbsRec:=_GetAbsRec(Handle,P,Size,X);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                    Proc‚dure _QGetFileTxtLnClipBoard                  Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


  Description
  ÍÍÍÍÍÍÍÍÍÍÍ

   Cette proc‚dure permet de lire une ligne de texte de format Pascal … la
  position courante … partir du ClipBoard.  Le pointeur du ®ClipBoard¯ est
  positionn‚ sur la ligne texte suivante aprŠs la lecture de la ligne.
}

Procedure _GetFileTxtLnClipBoard(Var S:String);
Var
 Buf:PChrAByte;
Begin
 GetAbsClipBoard(ClipPos,SizeOf(Buf),Buf);
 ASM
  {$IFDEF FLAT386}
   MOV ESI,Offset Buf
   ADD ESI,EBP
   MOV EBX,-1
@1:INC BX
   OR  BH,BH
   JNE @3
   CMP Word Ptr [ESI+EBX],13+(10 shl 8)
   JNE @1
   JMP @2
@3:DEC BX
@2:LEA EDI,DWord Ptr S
   MOV [EDI],BL
   INC EDI
   CLD
   MOV ECX,EBX
   REP MOVSB
  {$ELSE}
   XOR AX,AX
   SUB AX,BP
   MOV SI,Offset Buf
   SUB SI,AX
   MOV BX,-1
@1:INC BX
   OR BH,BH
   JNE @3
   CMP Word Ptr SS:[SI+BX],13+(10 shl 8)
   JNE @1
   JMP @2
@3:DEC BX
@2:LES DI,S
   MOV ES:[DI],BL
   INC DI
   CLD
   MOV CX,BX
   PUSH DS
    PUSH SS
    POP DS
    REP MOVSB
   POP DS
  {$ENDIF}
 END;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Proc‚dure __QGetAbsFileTxtLn                    Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet la lecture  d'une ligne dans un fichier ou ClipBoard
 et d'adapter le pointeur du fichier ou du clipboard … la ligne suivante pour
 que la lecture de la ligne suivante ne n‚cessite pas d'ajustement.
}

Procedure __QGetAbsFileTxtLn(Handle:Hdl;Var FP:LongInt;Var S:String);Begin
 If(Handle=hdlClipBoard)Then Begin
  ClipPos:=FP;
  _GetFileTxtLnClipBoard(S);
  Inc(FP,Length(S)+2)
 End
  Else
 __GetAbsFileTxtLn(Handle,FP,S);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Fonction QFileSize                             Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction retourne la taille du fichier Handle ou la taille du contenu
 du "ClipBoard".
}

Function QFileSize(Handle:Hdl):LongInt;Begin
 If(Handle=hdlClipBoard)Then QFileSize:=SizeOfClipBoard
                        Else QFileSize:=FileSize(Handle)
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Proc‚dure InpPassWord                           Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


  Description
  ÍÍÍÍÍÍÍÍÍÍÍ

   Cette fonction interroge l'usager en lui demandant le mot de passe utilis‚
  par le fichier. Il retourne ®No¯ (®False¯) si l'utilisateur abandonne cette
  op‚ration,  dans le cas contraire ®Yes¯  (®True¯) indique que l'utilisateur
  est certain de son action.


  Remarques
  ÍÍÍÍÍÍÍÍÍ

   ş Il est destin‚  … un usage interne  seulement  (dans  cette  unit‚  tout
     simplement).  Car il est utilise  dans  cette  unit‚  par  2  proc‚dures
     distinguent (TEOpen, TEInsFile) mais pas dans d'autres unit‚s.

   ş Cette  fonction  d‚tourne  les  interruptions  de d‚bogage,  histoire de
     mettre des bƒtons dans les roues des Hackers! En plus il "gosse" avec le
     prefech Queue du processeur,  ainsi qu'avec une r‚entrance d'instruction
     assembleur.
}

Function InpPassWord(Var UserPassWord:String):Boolean;Near;
Var
 OldInt01h,OldInt03h:Pointer;
Begin
 {$IFNDEF __Windows__}
  GetIntVec($01,OldInt01h);
  GetIntVec($03,OldInt03h);
  ASM
   JMP @Next
   DB 'Salut les Hackers de la part du concepteur! '
   DB 'Vous avez faim, mais ne manger pas ce pain empoisonner...'
 @Next:
   PUSH AX
    JMP @NoStep+2
 @NoStep:
    MOV DS:Byte Ptr [06EBh],0
    MOV AX,4C01h
    INT 21h
   POP AX
  END;
  UserPassWord:='';
  SetIntVec($01,Ptr($FFFF,0));
  SetIntVec($03,Ptr($FFFF,0));
  ASM
   JMP @Next
   DB 'Si vous vous ˆtes rendus l…, pirate de mes fesses, '
   DB 'sachez que le systŠme que vous tentez de d‚plomber est '
   DB 'appeller par son concepteur le '
   {$IFDEF Adele}
    {$IFDEF Chantal}
     DB 'Malte Genesis IV & V: Chantal'
     DB 'Malte Genesis V: Extension AdŠle'
    {$ELSE}
     DB 'Malte Genesis V: AdŠle'
    {$ENDIF}
   {$ELSE}
    {$IFDEF Chantal}
     DB 'Malte Genesis IV: Chantal'
    {$ELSE}
     DB 'Malte Genesis III: Isabel'
    {$ENDIF}
   {$ENDIF}
   DB '! '
   DB ' Contrairement … vos pr‚jug‚s, elle N''EST pas une putte '
   DB 'dont vous pouvez en prendre plaisir!'
 @Next:
  END;
 {$ENDIF}
 InpPassWord:=WinInp(40,'Protection','Entrez le mot de passe',CurrKrs.Draw.Window,True,UserPassWord)=kbOk;
 {$IFNDEF __Windows__}
  SetIntVec($01,Ptr($FFFF,0));
 (* ASM
   PUSH DS {Fonctionne mal en multitƒche...}
    PUSH AX
     PUSH BX
      PUSH CS
      POP DS
      MOV CS:Word Ptr [@Int21Fonction],4CB4h
 @Int21Fonction:
      MOV AH,30h
      INT 21h
     POP BX
    POP AX
   POP DS
  END;*)
  SetIntVec($01,Ptr($FFFF,0));
  ASM
   PUSH AX
    JMP @NoStep+2
 @NoStep:
    MOV DS:Byte Ptr [06EBh],0
    MOV AX,4C01h
    INT 21h
   POP AX
  END;
  SetIntVec($03,Ptr($FFFF,0));
  SetIntVec($01,OldInt01h);
  SetIntVec($03,OldInt03h);
 {$ENDIF}
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                             Proc‚dure InvBuf                            Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure inverse les 4 bits du haut avec les 4 bits du bas de chaque
 octet d'un tableau de longueur ®Size¯ que vous sp‚cifi‚ par ®x0¯.
}

Procedure InvBuf(Var x0;Size:Word);Near;
Var
 TBuf:TByte Absolute x0;
 I:Word;
Begin
 ASM
  PUSH AX
   JMP @NoStep+2
@NoStep:
   MOV DS:Byte Ptr [06EBh],0
   MOV AX,4C01h
   INT 21h
  POP AX
 END;
 If Size=0Then Exit;
 For I:=0to Size-1do TBuf[I]:=(TBuf[I]shr 4)+(TBuf[I]shl 4);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Proc‚dure SetTab                            Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure ajuste les tabulations en 8 espaces dans une chaŒne de
 caractŠre ainsi que le code ASCII 0 en espace.
}

Procedure SetTab(Var S:String);
Label Break;
Var
 T:String;
 I:Byte;
 B:Boolean;
Begin
 T:='';B:=False;
 If Length(S)=255Then Begin
  ChgChr(S,#0,' ');
  ChgChr(S,#9,' ');
  Exit;
 End
  Else
 For I:=1to Length(S)do Begin
  Case S[I]of
   #0:Begin
{    If StrI(I+1,S)=#0Then Goto Break;}
    IncStr(T,' ')
   End;
   #9:AddStr(T,SpcTab);
  Else IncStr(T,S[I]);
  End;
  If S[I]>' 'Then B:=True
 End;
Break:
 If(B)Then S:=T
      Else S:=''
End;

Function GetLenGatPhys2Scr(Const S:String):Byte;
Var
 I,Len:Byte;
Begin
 Len:=0;
 For I:=1to Length(S)do Begin
  If S[I]>=' 'Then Inc(Len)Else
  If((S[I]<' ')and(Byte(S[I])and cgDouble=cgDouble))Then Inc(Len);
 End;
 GetLenGatPhys2Scr:=Len;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Fonction ReadLine                      Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de lire une ligne … l'int‚rieur d'un bloc de
 m‚moire charger … partir du disque.
}

Function ReadLine(Handle:Hdl;Var P:LongInt;Size:Word;Var Buffer;Var Pos:Word):Boolean;
Const
 Len:Word=0;
Begin
 If(Pos>=Size)Then Begin
  Inc(P,Size);Pos:=0;
 End;
 If Pos=0Then Len:=_QGetAbsRec(Handle,P,Size,Buffer);
 ASM
  {$IFDEF FLAT386}
   PUSH EDI
    PUSH EBX
     LEA EDI,Pos
     MOVZX EAX,Word Ptr [EDI]
     LEA EDI,Buffer
     MOV EDX,EDI
     ADD EDI,EAX
     MOVZX ECX,Len
     SUB ECX,EAX
     XOR BX,BX
     MOV AX,13+(10 shl 8)
   @1:
     SCASW
     JNZ @2
     MOV BL,1
     DEC EDI
     DEC EDI
     XOR AX,AX
     STOSW      { Marque la fin de la chaŒne avec un code ASCII 0 }
     XCHG AX,DI
     SUB AX,DX
     JMP @End
   @2:
     DEC EDI
     DEC CX
     JNZ @1
      {Non trouv‚e}
     LEA EDI,Pos
     MOV AX,[EDI]
     MOV CX,Len
     CMP Size,CX
     JE  @3
     OR  AX,AX
     JNZ @3
     MOV BL,1
     MOVZX ECX,Len
     SUB ECX,EAX
     XCHG EAX,ECX
     JMP @End
   @3:
     OR  AX,AX { Ligne trop longue? }
     JNZ @4
     MOVZX EAX,Len
     LEA EDI,Buffer
     DEC EAX
     DEC EAX
     ADD EDI,EAX
     MOV Byte Ptr [EDI],0 { Tronqu‚! }
   @4:
     LEA EDI,P
     ADD [EDI],EAX
     XOR AX,AX
   @End:
     LEA EDI,Pos
     STOSW
     MOV @Result,BL
    POP EBX
   POP EDI
  {$ELSE}
   CLD
   LES DI,Pos
   MOV AX,ES:[DI]
   LES DI,Buffer
   MOV DX,DI
   ADD DI,AX
   MOV CX,Len
   SUB CX,AX
   XOR BX,BX
   MOV AX,13+(10 shl 8)
 @1:
   SCASW
   JNZ @2
   MOV BL,1
   DEC DI
   DEC DI
   XOR AX,AX
   STOSW      { Marque la fin de la chaŒne avec un code ASCII 0 }
   XCHG AX,DI
   SUB AX,DX
   JMP @End
 @2:
   DEC DI
   DEC CX
   JNZ @1
    {Non trouv‚e}
   LES DI,Pos
   MOV AX,ES:[DI]
   MOV CX,Len
   CMP Size,CX
   JE  @3
   OR  AX,AX
   JNZ @3
   MOV BL,1
   MOV CX,Len
   SUB CX,AX
   XCHG AX,CX
   JMP @End
 @3:
   OR  AX,AX { Ligne trop longue? }
   JNZ @4
   MOV AX,Len
   LES DI,Buffer
   DEC AX
   DEC AX
   ADD DI,AX
   MOV Byte Ptr ES:[DI],0 { Tronqu‚! }
 @4:
   LES DI,P
   ADD Word Ptr ES:[DI],AX
   ADC Word Ptr ES:[DI+2],0
   XOR AX,AX
 @End:
   LES DI,Pos
   STOSW
   MOV @Result,BL
  {$ENDIF}
 END;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Proc‚dure TEInitDef                           Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure interne permet l'initialisation des donn‚es par d‚faut du
 traŒtement de texte.  Il ne touche  qu'aux donn‚es sans jamais les mettres
 en pratique … l'‚cran...
}

Procedure TEInitDef(Var Q:EditorApp);Near;Begin
 FillClr(Q,SizeOf(Q));
 Q.InsMode:=True;
 Q.MakeSpc:=True;
 Q.ChrAttr:=cgNormal;
 Q.Mode:=vtDefault
End;

{$I Library\XtrkWdIn.Inc}
{$I Library\XtrkLong.Inc}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ·}
{³                    Z o n e  P u b l i q u e                 º}
{ÔÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Proc‚dure TEInit                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure  cr‚e un  nouveau texte  pour l'‚diteur.  Si vous ne
 sp‚cifiez pas de nom, il consid‚rera le nom du fichier comme ®Pasnom¯
 jusqu'… ce que l'utilisateur en est rentr‚e un.
}

Procedure TEInit;Begin
 TEInitDef(Q);
 TEInitCoord(Q);
 ALInit(Q.List);
 TEInitLang(Q);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                            Proc‚dure TENew                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure cr‚e un nouveau fichier texte.
}

Function TENew;Begin
 TEOpen(EditorApp(Q),X1,Y1,X2,Y2,'');
 TENew:=True;
End;

Function TENewHTML(Var Context;X1,Y1,X2,Y2:Byte):Boolean;
Var
 Q:EditorApp Absolute Context;
Begin
 TEOpen(Q,X1,Y1,X2,Y2,'');
 Include(Q.Option,eNoRules);
 Q.Mode:=vtHTMLSourceCode;
 Q.FileSize:=283;
 Q.StrMX:=71;
 If(Rules)Then Inc(Q.W.MaxY);
 ALDelBuf(Q.List,0);
 ALAddStr(Q.List,'<HTML>');
 ALAddStr(Q.List,'<HEAD>');
 ALAddStr(Q.List,'<TITLE></TITLE>');
 ALAddStr(Q.List,'<META name="description" content="">');
 ALAddStr(Q.List,'<META name="keywords" content="">');
 ALAddStr(Q.List,'<META name="generator" content="MonsterBook">');
 ALAddStr(Q.List,'</HEAD>');
 ALAddStr(Q.List,'<BODY BGCOLOR="#FFFFFF" TEXT="#000000" LINK="#0000FF" VLINK="#800080">');
 ALAddStr(Q.List,'<!--Ins‚rer ici votre code-->');
 ALAddStr(Q.List,'</BODY>');
 ALAddStr(Q.List,'</HTML>');
 ALAddLn(Q.List);
 TERefresh(Q);
 TENewHTML:=True;
End;

Function TENewHTMLDocument(Var Context;X1,Y1,X2,Y2:Byte):Boolean;
Var
 Q:EditorApp Absolute Context;
Begin
 TEOpen(Q,X1,Y1,X2,Y2,'');
 Q.SheetFormat.X1:=10;
 Q.SheetFormat.X2:=70;
 Q.SheetFormat.Y1:=6;
 Q.SheetFormat.Y2:=60;
 Q.ScrollLock:=True;
 Q.ModeSub:=vtsHTML;
 TESetViewMode(Q,vtGat);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                       Proc‚dure TENewDocument                    Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure cr‚e un nouveau document de dimension standard sans
 demander … l'utilisateur si la taille lui convient.
}

Procedure TENewDocument;Begin
 TEOpen(Q,X1,Y1,X2,Y2,'');
 Q.SheetFormat.X1:=10;
 Q.SheetFormat.X2:=70;
 Q.SheetFormat.Y1:=6;
 Q.SheetFormat.Y2:=60;
 Q.ScrollLock:=True;
 TESetViewMode(Q,vtGat);
End;

Function SpaceInApostrophe(Const S:String):String;
Var
 I:Byte;
 T:String;
Begin
 T:='';
 For I:=1to Length(S)do Begin
  If(I<Length(S))and(S[I]=' ')and(S[I-1]='''')Then Begin
   { Laissez passer ce caractŠres... }
  End
   Else
  IncStr(T,S[I]);
 End;
 SpaceInApostrophe:=T;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                            Proc‚dure _TEOpen                            Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure cr‚e un objet ®Editeur¯ en chargeant le fichier sp‚cifier.
 S'il n'existe pas,  il demande … l'utilisateur  s'il souhaŒte le cr‚er.  Il
 v‚rifie ‚galement par l'extension du fichier,  quel devra ˆtre le format de
 texte … charger (Gat, Pascal, C/C++,...).


 Remarques
 ÍÍÍÍÍÍÍÍÍ

  ş Il  reconnaŒt  le  format  de  traŒtement  de  texte   ®Premier  Choix¯.
    Toutefois,  il ‚prouve  beaucoup  plus  de  difficult‚  avec  le  format
    ®Professional Write¯ et celui n'est pas toujours correctement charg‚. Il
    comprend le code de compression du Basic en mode non-prot‚g‚ ceci aidant
    les retrouvailles des vieux programmes BASIC!!!

  ş Il est impensable  de  transformer  cette proc‚dure  pour un compilateur
    Borland inf‚rieure … la Version 7 (Borland Pascal, Turbo Pascal) … cause
    de l'utilisation de instruction Break, Continue et PChar!
}

Procedure _TEOpen(Var Q:EditorApp;X1,Y1,X2,Y2:Byte;Name:String;New:Boolean);
Label Brk;
Var
 E:ExtStr;                                   { Extension du fichier courant }
 S3:String[15];                              { Nom du fichier courant }
 Handle:Hdl;                                 { Handle attirbu‚ … l'ouverture du fichier }
 K,KR,Err,Slp:Word;
 I,FP:LongInt;                               { Boucle, position courant dans le fichier }
 S2,S:String;
 T,J:Byte;
 PC:PChr;                                    { Pointeur sur la ligne courant }
 Chr:Char;                                   { CaractŠre courant }
 Buffer:Array[0..4095]of Char;               { Tampon de chargement }
 PW:PWHeader Absolute Buffer;                { Entˆte ®Professionnel Write¯ }
 MsWord:MicrosoftWordHeader Absolute Buffer; { Entˆte ®Microsoft Word/Write¯ }
 PassWord,AddSpc,Tab8:Boolean;
 TChr:TChar Absolute PW;
 FirstChoice:FirstChoiceHeader Absolute Buffer; { Premier Choix }
 RTFSign:Array[0..4]of Char Absolute Buffer; { Signature du RTF }
 UserPassWord:String;                        { Mot de passe de l'utilisateur }
 NewLine:String Absolute UserPassword;       { Nouvelle ligne en voie d'interpr‚tation }
 Ptr:Pointer;
 TW:Array[0..3]of {$IFDEF Real}PWord{$ELSE}PLong{$ENDIF};
 TMtx:TByte Absolute Buffer;
 QX:EditorApp Absolute Q;
 Drw:DrawInEdt {Absolute Buffer};
 TImg:MCanvas;                               { Objet d'image }
 Res:ImageHeaderRes;                         { Ressource attribu‚ … l'image }
 PosBuf:Word;                                { Position dans le tampon ®InitLoadBuffer¯ }
 SizeBuf:Word;                               { Taille du tampon }
 FileSize:LongInt;                           { Taille du fichier … charger }
 Mode:Byte;                                  { Mode de lecture }
 ModeSub:Byte;                               { Sous-mode de lecture }
 OldActifScrSave:Boolean;                    { Ancienne valeur d'‚conomiseur d'‚cran }

 Function ALAdd(Size:Word):Pointer;Begin
  If(New)Then ALAdd:=Memories.ALAdd(Q.List,Size)
   Else
  Begin
   ALAdd:=Memories.ALIns(Q.List,Q.P,Size);
   Inc(Q.P);
  End;
 End;

 Function ALAddLn:Boolean;Begin
  If(New)Then ALAddLn:=Memories.ALAddLn(Q.List)
   Else
  Begin
   ALAddLn:=Memories.ALInsStr(Q.List,Q.P,'');
   Inc(Q.P);
  End;
 End;

 Function ALAddStr(Const S:String):Boolean;Begin
  If(New)Then ALAddStr:=Memories.ALAddStr(Q.List,S)
   Else
  Begin
   ALAddStr:=Memories.ALInsStr(Q.List,Q.P,S);
   Inc(Q.P);
  End;
 End;

 Function ALAddParagraph(S:String):Boolean;
 Var
  Trunc:Boolean;
  T:String;
  I:LongInt;
 Begin
  ALAddParagraph:=False;
  Repeat
   Trunc:=Length(S)=255;
   T:=S;
   Repeat
    If T[1]<>' 'Then Begin
     For I:=Q.SheetFormat.X2-Q.SheetFormat.X1-1downto 1do Begin
      If T[I]=' 'Then Begin
       If Not ALAddStr(Spc(Q.SheetFormat.X1)+SpaceInApostrophe(Left(T,I)))Then Exit;
       Break;
      End;
     End;
    End
     Else
    For I:=Q.SheetFormat.X2-1downto(Q.SheetFormat.X1)do Begin
     If T[I]=' 'Then Begin
      If Not ALAddStr(SpaceInApostrophe(Left(T,I)))Then Exit;
      Break;
     End;
    End;
    T:=Copy(T,I+1,255);
    If(Trunc)and(Length(T)<Q.SheetFormat.X2)Then Break;
   Until T='';
   If(Trunc)Then Begin
    __QGetAbsFileTxtLn(Handle,FP,S);
    If GetSysErr<>0Then Begin
     GetSysErr:=errEdtRead;
     Exit;
    End;
    If T<>''Then Begin
     If Length(T)+Length(S)>255Then Begin
      Dec(FP,Length(T));
     End;
     S:=T+S;
    End;
   End;
  Until Not Trunc;
  ALAddParagraph:=ALAddLn;
 End;

 Procedure InitLoadBuffer;Begin
  PosBuf:=$FFFF;FP:=0;SizeBuf:=SizeOf(Buffer);
  FileSize:=QFileSize(Handle);
 End;

 Function EOF:Boolean;Begin
  EOF:=(FP>=FileSize)and(PosBuf>=SizeBuf);
 End;

 Function ReadChar:Char;Begin
  If(PosBuf<>$FFFF)and(EOF)Then ReadChar:=#0
   Else
  Begin
   If(PosBuf>=SizeBuf)Then Begin
    SizeBuf:=_QGetAbsRec(Handle,FP,SizeOf(Buffer),Buffer);
    Inc(FP,LongInt(SizeBuf));
    PosBuf:=0;
   End;
   ReadChar:=Buffer[PosBuf];
   Inc(PosBuf);
  End;
 End;

 Procedure TEPutBarXYM(_X:Word;_Y:RBP;Mem:LongInt);Near;
 Var
  Color:Byte;
 Begin
  If(Q.Mode=vtHlp)Then
   WESetEndBarTxtX(Q.W,45,{$IFDEF __Windows__}
    IntToStr((DivLong(_Y,(Q.SheetFormat.Y2-Q.SheetFormat.Y1))+1))
   {$ELSE}
    WordToStr((_Y div(Q.SheetFormat.Y2-Q.SheetFormat.Y1))+1)
  {$ENDIF}+' Pages',Q.W.Palette.Title)
   Else
  Begin
   If(Q.Mode=vtPJ)Then Color:=$D5
                  Else Color:=CurrKrs.Editor.Env.Pos;
   WESetEndBarTxtX(Q.W,45,WordToStr(_X)+'x'+{$IFDEF __Windows__}
    IntToStr(_Y)
   {$ELSE}
    WordToStr(_Y)
   {$ENDIF}+': '+IntToStr(Mem)+' octet(s)',Color);
  End;
 End;

 Procedure PutTimer;Begin
  _BackKbd;
  If GetRawTimerB and 1=0Then Begin
   If(T<>GetRawTimerB)Then Begin
    PutMemory;
    TEPutBarXYM(Q.StrMX,Q.List.Count,FileSize);
    T:=GetRawTimerB;
   End;
  End;
 End;

 Procedure TEChkMaxLen(L:Word);Begin
  If L=255Then Exit;
  If(Q.StrMX<L)Then Q.StrMX:=L
 End;

 Procedure LoadPackBasic;
 Label
  XitOutOfMemory;
 Var
  X,I:Word;
  Buffer:^TByte;
  LS:String;
  Ok,InFunc:Boolean;
  Command:DataSetInMemory; { Commande Basic m‚moris‚e pour l'interpr‚tation du code }

  Procedure Def;Begin
   IncStr(LS,Char(Buffer^[I]));
   Inc(I)
  End;

 Begin
  Buffer:=MemAlloc(FileSize);
  If(Buffer=NIL)Then Exit;
  QGetRec(Handle,0,FileSize,Buffer^);
  DBOpenServerName(ChantalServer,'CHANTAL:/Compilateur/Basic/GWBasic.Dat');
  If Not DBCopyToMemory(ChantalServer,Command)Then Goto XitOutOfMemory;
  InFunc:=False;
  I:=3;
  LS:=_WordToStr(Buffer^[I])+' ';
  Inc(I,2);
  If Buffer^[I]=Byte(':')Then Inc(I);
  Repeat
   If DBLocateAbsIM(Command,0,Buffer^[I],[])Then Begin
    Case(Command.CurrRec.Byte^)of
     $C:Begin
      If Buffer^[I+1]=0Then AddStr(LS,HexByte2Str(Buffer^[I]))
                       Else AddStr(LS,HexWord2Str(Buffer^[I]+Buffer^[I+1]*256));
      Inc(I,2);
     End;
     $E7:InFunc:=True;
    End;
    Inc(PtrRec(Command.CurrRec).Ofs);
    AddStr(LS,Command.CurrRec.Str^);
    Inc(I);
   End
    Else
   Case Buffer^[I]of
    0:Begin
     TEChkMaxLen(Wd(Length(LS)));
     If LS<>''Then ALAddStr(LS);
     Inc(I,3);
     X:=Word(Buffer^[I]+Word(Buffer^[I+1])*256);
     If(X=0)and(Buffer^[I+2]=26)Then Begin
      LS:='';
      Break;
     End;
     LS:=WordToStr(X)+' ';
     Inc(I,2);
     If Buffer^[I]=Byte(':')Then Inc(I);
    End;
    $E,$10,$1C:Begin
     Inc(I);
     AddStr(LS,_WordToStr(Buffer^[I]));
     Inc(I,2)
    End;
    $F:Begin
     Inc(I);
     AddStr(LS,WordToStr(Buffer^[I]));
     Inc(I)
    End;
    $11..$1A:Begin
     IncStr(LS,Char(Buffer^[I]+31));
     Inc(I)
    End;
    $22:Begin
     Def;
     While(Buffer^[I]<>$22)do Begin
      If Buffer^[I]=0Then Break;
      IncStr(LS,Char(Buffer^[I]));Inc(I);
      If(I>FileSize)Then Break;
     End;
     Def;
    End;
    $3A:Case Buffer^[I+1]of
     $20:If Buffer^[I+2]=32Then Begin
      Inc(I);
      AddStr(LS,'GOSUB');
      Inc(I)
     End
      Else
     Begin
      Def;
      Def;
     End;
     $A1:Begin
      Inc(I);
      AddStr(LS,'ELSE');
      Inc(I)
     End;
     Else Begin
      Def;
      InFunc:=False;
     End;
    End;
    $85:Begin
     If(InFunc)Then AddStr(LS,'INT')
               Else AddStr(LS,'INPUT');
     Inc(I);
    End;
    $8F:Case Buffer^[I+1]of
     $D9:Begin
      Inc(I,2);
      IncStr(LS,'''');
      While Buffer^[I]<>0do Begin
       IncStr(LS,Char(Buffer^[I]));
       Inc(I);
       If(I>FileSize)Then Break;
      End;
     End;
     Else Begin
      Inc(I);
      AddStr(LS,'REM');
      Def;
      While Buffer^[I]<>0do Begin
      IncStr(LS,Char(Buffer^[I]));
      Inc(I);
      If(I>FileSize)Then Break;
     End;
     End;
    End;
    $B1:Case Buffer^[I+1]of
     $E9:Begin
      Inc(I);
      AddStr(LS,'WHILE');
      Inc(I)
     End;
     Else Def;
    End;
    $FE:Repeat
     Case Buffer^[I+1]of
      $81:AddStr(LS,'FILES');
      $83:AddStr(LS,'SYSTEM');
      $88:AddStr(LS,'PUT');
      $89:AddStr(LS,'GET');
      $8B:AddStr(LS,'COMMON');
      $8E:AddStr(LS,'TIME$');
      $8F:AddStr(LS,'PAINT');
      $91:AddStr(LS,'CIRCLE');
      $92:AddStr(LS,'DRAW');
      $93:AddStr(LS,'PLAY');
      $94:AddStr(LS,'TIMER');
      Else Begin
       Def;
       Break;
      End;
     End;
     Inc(I,2);
    Until True;
    $FF:Repeat
     Case Buffer^[I+1]of
      $81:AddStr(LS,'LEFT$');
      $82:AddStr(LS,'RIGHT$');
      $83:AddStr(LS,'MID$');
      $92:AddStr(LS,'LEN');
      $94:AddStr(LS,'VAL');
      $95:AddStr(LS,'ASC');
      $96:AddStr(LS,'CHR$');
      $97:AddStr(LS,'PEEK');
      Else Begin
       Def;
       Break;
      End;
     End;
     Inc(I,2);
    Until True;
    Else Def;
   End;
   PutTimer;
  Until I>FileSize;
  If LS<>''Then ALAddStr(LS);
  DBDispose(Command);
XitOutOfMemory:
  FreeMemory(Buffer,FileSize);
 End;

 Procedure LoadPW(Handle:Hdl;Var StrMx:Word;XW1:Word);
 Var
  I,ST:Word;
  Buffer:^TByte;
  Chr:Char;
  Str:String;
  PushLn,J:Byte;
 Begin
  ST:=FileSize-1025;Str:=Spc(XW1);
  Buffer:=MemAlloc(ST);
  If(Buffer=NIL)Then Exit;
  _QGetAbsRec(Handle,1025,ST,Buffer^);
  For I:=0to ST-1do Begin
   Chr:=Char(Buffer^[I]);
   Case(Chr)of
    #0:;
    #1:Begin
     PushLn:=0;
     For J:=Length(Str)downto XW1+1do Begin
      If Str[J]=' 'Then Begin
       Inc(PushLn);
       Dec(Byte(Str[0]));
      End
       Else
      Break;
     End;
     If(Length(Str)>StrMX)Then StrMX:=Length(Str);
     If Not ALAddStr(Str)Then Begin
      SetSysErr(errEdtFileTooBig);
      Break;
     End;
     For J:=1to(PushLn)do ALAddLn;
     Str:=Spc(XW1);
    End;
    #128..#255:Case Char(Buffer^[I+1])of
     #128..#143:IncStr(Str,Char(Byte(Chr)and$7F));
     #192:IncStr(Str,Chr);
     #255:IncStr(Str,' ');
    End;
    #14:Break;
    Else IncStr(Str,Chr);
   End;
   PutTimer;
  End;
  If(Length(Str)>StrMX)Then StrMX:=Length(Str);
  ALAddStr(Str);
  FreeMemory(Buffer,ST);
 End;

 Procedure MkWn;Begin
  If(New)Then Begin
   TEPutWn(Q,X1,Y1,X2,Y2);
   TEPutBar(Q)
  End;
 End;

 Procedure LoadMsWord;
 Label Restart;
 Var
  RealLen:Byte;         { Longueur r‚el }
  TmpWord:String;       { Mot temporaire d'interpr‚tation }
  Font:DataSetInMemory; { Pour la conversion de la police de caractŠres }
  NotFirst:Boolean;     { Pas le premier caractere? }

  Procedure DumpLine;
  Var
   X:Integer;       { Position X pour centr‚e }
   I:Byte;          { Compteur de boucle }
   OnlySpc:Boolean; { Ligne avec seulement des espaces? }
  Begin
   OnlySpc:=True;
   For I:=1to Length(NewLine)do If NewLine[I]<>' 'Then OnlySpc:=False;
   If(OnlySpc)Then NewLine:='';
   If NewLine=''Then ALAddLn
                Else ALAddStr(NewLine);
   TEChkMaxLen(Length(NewLine));
   NewLine:='';
   RealLen:=0;
  End;

  Procedure IncNewLine(Chr:Char);
  Var
   NewRealLen:Byte;
  Begin
   If NewLine=''Then Begin
    AddStr(NewLine,Spc(Q.SheetFormat.X1));
    Inc(RealLen,Q.SheetFormat.X1);
   End;
   IncStr(NewLine,Chr);
   Inc(RealLen);
   NewRealLen:=0;
   If(RealLen>=Q.SheetFormat.X2)Then Begin
    TmpWord:='';
    If NewLine[Length(NewLine)]<>' 'Then Begin
     While NewLine[Length(NewLine)]<>' 'do Begin
      Chr:=NewLine[Length(NewLine)];
      If Chr>' 'Then Inc(NewRealLen);
      TmpWord:=Chr+TmpWord;
      BackStr(NewLine);
      If(Length(NewLine)<=Q.SheetFormat.X1)Then Begin { Mot trop long? }
       AddStr(NewLine,TmpWord);
       TmpWord:='';
       Break;
      End;
     End;
    End;
    DumpLine;
    If TmpWord<>''Then Begin
     TmpWord:=Spc(Q.SheetFormat.X1)+TmpWord;
     RealLen:=NewRealLen+Q.SheetFormat.X1;
    End;
    NewLine:=TmpWord;
   End;
   If Length(NewLine)>=254Then DumpLine;
  End;

 Begin
  DBOpenServerName(ChantalServer,'CHANTAL:/Country/Ansi2ASCII.Dat');
  If Not DBCopyToMemory(ChantalServer,Font)Then Begin
   __OutOfMemory;
   Exit;
  End;
  If(New)Then Begin
   Q.SheetFormat.X1:=10;
   Q.SheetFormat.X2:=70;
   Q.SheetFormat.Y1:=6;
   Q.SheetFormat.Y2:=60;
  End;
  InitLoadBuffer;
  NewLine:='';
  RealLen:=0;
  Q.Mode:=vtGat;
  Q.ModeSub:=vtsMicrosoftWord;
  FP:=$600;
  NotFirst:=False;
  Repeat
Restart:
   Chr:=ReadChar;
   If DBLocateAbsIM(Font,0,Chr,[])Then Begin
    Inc(PtrRec(Font.CurrRec).Ofs);
    IncNewLine(Font.CurrRec.Str^[1]);
   End
    Else
   Case(Chr)of
    #$00:Begin
     If(NotFirst=False)Then Begin
      Dec(FP,LongInt(SizeBuf));
      Inc(FP,1024);
      PosBuf:=$FFFF;
      Goto Restart;
     End
      Else
     Break;
    End;
    #$01..#$0C,#$0E..#$1F:;
    #$0D:DumpLine;
    Else IncNewLine(Chr);
   End;
   NotFirst:=True;
   PutTimer;
  Until EOF;
  If NewLine<>''Then DumpLine;
  ALAddLn;
  DBDispose(Font);
 End;

 Procedure LoadDocumentHTML;
 Label Finish;
 Var
  Chr:Char;             { CaractŠre courant du tampon }
  OldAttrDoc:Byte;      { Ancienne attribut }
  AttrDoc:Byte;         { Attribut document }
  RealLen:Byte;         { Longueur r‚el }
  Mode:Set of (mCenter,mInTitle,mFont); { Partie Titre, centr‚e,...}
  TmpWord:String;       { Mot temporaire d'interpr‚tation }
  CharCode:Word;        { Code du caractŠre }
  Font:DataSetInMemory; { Pour la conversion de la police de caractŠres }

  Procedure DumpLine;
  Var
   X:Integer;       { Position X pour centr‚e }
   I:Byte;          { Compteur de boucle }
   OnlySpc:Boolean; { Ligne avec seulement des espaces? }
  Begin
   OnlySpc:=True;
   For I:=1to Length(NewLine)do If NewLine[I]<>' 'Then OnlySpc:=False;
   If(OnlySpc)Then NewLine:='';
   If NewLine=''Then ALAddLn
    Else
   Begin
    If(mCenter)in(Mode)Then Begin
     X:=((Q.SheetFormat.X2-Q.SheetFormat.X1)-(RealLen-Q.SheetFormat.X1))shr 1;
     If X>0Then NewLine:=Spc(X)+NewLine;
    End;
    ALAddStr(NewLine);
   End;
   TEChkMaxLen(Length(NewLine));
   NewLine:='';
   RealLen:=0;
  End;

  Procedure IncNewLine(Chr:Char);
  Var
   NewRealLen:Byte;
  Begin
   If(mInTitle in Mode)Then Exit;
   If NewLine=''Then Begin
    AddStr(NewLine,Spc(Q.SheetFormat.X1));
    Inc(RealLen,Q.SheetFormat.X1);
   End;
   If(AttrDoc>0)and(Chr<>' ')Then Begin
    IncStr(NewLine,Char(AttrDoc));
    If(AttrDoc and cgDouble=cgDouble)Then Inc(RealLen);
   End;
   IncStr(NewLine,Chr);
   Inc(RealLen);
   NewRealLen:=0;
   If(RealLen>=Q.SheetFormat.X2)Then Begin
    TmpWord:='';
    If NewLine[Length(NewLine)]<>' 'Then Begin
     While NewLine[Length(NewLine)]<>' 'do Begin
      Chr:=NewLine[Length(NewLine)];
      If Chr>' 'Then Inc(NewRealLen);
      TmpWord:=Chr+TmpWord;
      BackStr(NewLine);
      If(Length(NewLine)<=Q.SheetFormat.X1)Then Begin { Mot trop long? }
       AddStr(NewLine,TmpWord);
       TmpWord:='';
       Break;
      End;
     End;
    End;
    DumpLine;
    If TmpWord<>''Then Begin
     TmpWord:=Spc(Q.SheetFormat.X1)+TmpWord;
     RealLen:=NewRealLen+Q.SheetFormat.X1;
    End;
    NewLine:=TmpWord;
   End;
   If Length(NewLine)>=254Then DumpLine;
  End;

  Procedure XtrkWord;Begin
   Repeat
    Chr:=ReadChar;
    If Not((Chr)in['A'..'Z','a'..'z'])Then Break;
    IncStr(TmpWord,Chr);
   Until False;
  End;

  Procedure XtrkWordUpper;Begin
   XtrkWord;
   TmpWord:=StrUp(TmpWord);
  End;

 Begin
  DBOpenServerName(ChantalServer,'CHANTAL:/Country/Ansi2ASCII.Dat');
  If Not DBCopyToMemory(ChantalServer,Font)Then Begin
   __OutOfMemory;
   Exit;
  End;
  If(New)Then Begin
   Q.SheetFormat.X1:=10;
   Q.SheetFormat.X2:=70;
   Q.SheetFormat.Y1:=6;
   Q.SheetFormat.Y2:=60;
  End;
  If(New)Then TESetFormat(Q);
  InitLoadBuffer;
  NewLine:='';
  OldAttrDoc:=0;AttrDoc:=0;
  RealLen:=0;
  Mode:=[];
  Repeat
   Chr:=ReadChar;
   If DBLocateAbsIM(Font,0,Chr,[])Then Begin
    Case Font.CurrRec.Byte^of
     156:Begin
      IncNewLine('o');
      IncNewLine('e');
     End;
     Else Begin
      Inc(PtrRec(Font.CurrRec).Ofs);
      IncNewLine(Font.CurrRec.Str^[1]);
     End;
    End;
   End
    Else
   Case(Chr)of
    '<':Begin
     Case ChrUp(ReadChar)of
      'B':Begin
       Chr:=ReadChar;
       If Chr in['R','r']Then DumpLine
                         Else AttrDoc:=AttrDoc or cgBold;
       If Chr='>'Then Goto Finish;
      End;
      'C':Begin
       TmpWord:='C';
       XtrkWordUpper;
       If TmpWord='CENTER'Then Include(Mode,mCenter);
       If Chr='>'Then Goto Finish;
      End;
      'F':Begin
       TmpWord:='F';
       XtrkWordUpper;
       If TmpWord='FONT'Then Include(Mode,mFont);
       Repeat
        Chr:=ReadChar;
        If Chr='>'Then Goto Finish;
       Until Chr<>' ';
       TmpWord:=Chr;
       XtrkWordUpper;
       If Chr='>'Then Goto Finish;
       If TmpWord='SIZE'Then Begin
        Case(ReadChar)of
         '"':Begin
          Case(ReadChar)of
           '+':Begin
            Case(ReadChar)of
             '2'..'9':AttrDoc:=AttrDoc or cgDouble;
             '>':Goto Finish;
            End;
           End;
           '>':Goto Finish;
          End;
         End;
         '>':Goto Finish;
        End;
       End;
      End;
      'H':Begin
       Case(ReadChar)of
        '1':Begin
         OldAttrDoc:=AttrDoc;
         AttrDoc:=AttrDoc or cgDouble or cgBold;
        End;
        '2':Begin
         OldAttrDoc:=AttrDoc;
         AttrDoc:=AttrDoc or cgDouble;
        End;
        '3':Begin
         OldAttrDoc:=AttrDoc;
         AttrDoc:=AttrDoc or cgBold;
        End;
        '>':Goto Finish;
       End;
      End;
      'I':Begin
       Chr:=ReadChar;
       If Not(Chr in['A'..'Z','a'..'z'])Then AttrDoc:=AttrDoc or cgItalic;
       If Chr='>'Then Goto Finish;
      End;
      'P':Begin
       Repeat
        Chr:=ReadChar;
        If Chr='>'Then Goto Finish;
       Until Chr<>' ';
       TmpWord:=Chr;
       XtrkWordUpper;
       If Chr='>'Then Goto Finish;
       If TmpWord='ALIGN'Then Begin
        Case(ReadChar)of
         '=':Begin
          TmpWord:=ReadChar;
          Case TmpWord[1]of
           '"':TmpWord:='';
           '>':Goto Finish;
          End;
          XtrkWordUpper;
          If TmpWord='CENTER'Then Include(Mode,mCenter)Else
          If TmpWord='LEFT'Then Exclude(Mode,mCenter)Else
          If TmpWord='RIGHT'Then Exclude(Mode,mCenter);
         End;
         '>':Goto Finish;
        End;
       End;
      End;
      'S':Begin
       TmpWord:='S';
       XtrkWordUpper;
       If(TmpWord='SUP')or(TmpWord='SMALL')Then Begin
        OldAttrDoc:=AttrDoc;
        AttrDoc:=cgExposant;
       End;
       If Chr='>'Then Goto Finish;
      End;
      'T':Begin
       TmpWord:='T';
       XtrkWordUpper;
       If TmpWord='TITLE'Then Include(Mode,mInTitle);
       If Chr='>'Then Goto Finish;
      End;
      'U':AttrDoc:=AttrDoc or cgUnderline;
      '/':Begin
       Case ChrUp(ReadChar)of
        'B':Begin
         AttrDoc:=AttrDoc and Not(cgBold);
        End;
        'C':Begin
         TmpWord:='C';
         XtrkWordUpper;
         If TmpWord='CENTER'Then Begin
          If NewLine<>''Then DumpLine;
          Exclude(Mode,mCenter);
         End;
         If Chr='>'Then Goto Finish;
        End;
        'F':Begin
         TmpWord:='F';
         XtrkWordUpper;
         If TmpWord='FONT'Then Begin
          Exclude(Mode,mFont);
          AttrDoc:=AttrDoc and Not(cgDouble);
         End;
         If Chr='>'Then Goto Finish;
        End;
        'H':Begin
         Case(ReadChar)of
          '1','2','3':Begin
           AttrDoc:=OldAttrDoc;
           DumpLine;
          End;
          '>':Goto Finish;
         End;
        End;
        'I':AttrDoc:=AttrDoc and Not(cgItalic);
        'P':Begin
         While(NewLine[Length(NewLine)]=' ')and(Length(NewLine)>0)do BackStr(NewLine);
         DumpLine;
{         Case(ReadChar)of
          '>':Goto Finish;
          Else DumpLine;
         End;}
        End;
        'S':Begin
         TmpWord:='S';
         XtrkWordUpper;
         If(TmpWord='SUP')or(TmpWord='SMALL')Then Begin
          AttrDoc:=OldAttrDoc;
          OldAttrDoc:=cgNormal;
         End;
         If Chr='>'Then Goto Finish;
        End;
        'T':Begin
         TmpWord:='T';
         XtrkWordUpper;
         If TmpWord='TITLE'Then Exclude(Mode,mInTitle);
         If Chr='>'Then Goto Finish;
        End;
        'U':AttrDoc:=AttrDoc and Not(cgUnderline);
        '>':Goto Finish;
       End;
      End;
      '>':Goto Finish;
     End;
     While(ReadChar<>'>')and(Not EOF)do;
Finish:
    End;
    '&':Begin
     TmpWord:='';
     Repeat
      Chr:=ReadChar;
      If(Chr)in[';',#0]Then Break;
      IncStr(TmpWord,Chr);
     Until False;
     If TmpWord='amp'Then IncNewLine('&')Else
     If TmpWord='nbsp'Then IncNewLine(' ')Else
     If TmpWord='lt'Then IncNewLine('<')Else
     If TmpWord='gt'Then IncNewLine('>')
      Else
     Begin
      Chr:=TmpWord[1];
      TmpWord:=Copy(TmpWord,2,255);
      If Chr='#'Then Begin
       CharCode:=StrToWord(TmpWord);
       Case(CharCode)of
        156,339:Begin
         IncNewLine('o');
         IncNewLine('e');
        End;
        8212:Begin
         IncNewLine('Ä');
         IncNewLine('Ä');
        End;
        Else Begin
         If DBLocateAbsIM(Font,0,CharCode,[])Then Begin
          Inc(PtrRec(Font.CurrRec).Ofs);
          IncNewLine(Font.CurrRec.Str^[1]);
         End;
        End;
       End;
      End
       Else
      If TmpWord='acute'Then Begin
       Case(Chr)of
        'E':IncNewLine('');
        'a':IncNewLine(' ');
        'e':IncNewLine('‚');
        'i':IncNewLine('¡');
        'o':IncNewLine('¢');
        'u':IncNewLine('£');
        Else IncNewLine(Chr);
       End;
      End
       Else
      If TmpWord='cedil'Then Begin
       Case(Chr)of
        'C':IncNewLine('€');
        'c':IncNewLine('‡');
        Else IncNewLine(Chr);
       End;
      End
       Else
      If TmpWord='circ'Then Begin
       Case(Chr)of
        'a':IncNewLine('ƒ');
        'e':IncNewLine('ˆ');
        'i':IncNewLine('Œ');
        'o':IncNewLine('“');
        'u':IncNewLine('–');
        Else IncNewLine(Chr);
       End;
      End
       Else
      If TmpWord='grave'Then Begin
       Case(Chr)of
        'a':IncNewLine('…');
        'e':IncNewLine('Š');
        'i':IncNewLine('');
        'o':IncNewLine('•');
        'u':IncNewLine('—');
        Else IncNewLine(Chr);
       End;
      End
       Else
      If TmpWord='tilde'Then Begin
       Case(Chr)of
        'n':IncNewLine('¤');
        'N':IncNewLine('¥');
        Else IncNewLine(Chr);
       End;
      End
       Else
      If TmpWord='uml'Then Begin
       Case(Chr)of
        'A':IncNewLine('');
        'O':IncNewLine('™');
        'a':IncNewLine('„');
        'e':IncNewLine('‰');
        'i':IncNewLine('‹');
        'o':IncNewLine('”');
        'u':IncNewLine('');
        'y':IncNewLine('˜');
        Else IncNewLine(Chr);
       End;
      End;
     End;
    End;
    #13:If NewLine[Length(NewLine)]<>' 'Then IncNewLine(' ');
    #0..#12,#14..#31:;
    Else IncNewLine(Chr);
   End;
   PutTimer;
  Until EOF;
  If NewLine<>''Then DumpLine;
  DBDispose(Font);
 End;

 Procedure LoadFirstChoice;
 Var
  Chr:Char;        { CaractŠre courant }
  Chr2:Byte;       { CaractŠre suivant }
  RealLen:Byte;    { Longueur r‚el }
  AttrDoc:Byte;    { Attribut du caractŠre }
  TmpWord:String;  { Mot temporaire }
  NumLetters:Word; { Nombre de lettre de texte … lire }
  CurrLet:Word;    { Lettre courante }

  Procedure DumpLine;
  Var
   X:Integer;       { Position X pour centr‚e }
   I:Byte;          { Compteur de boucle }
   OnlySpc:Boolean; { Ligne avec seulement des espaces? }
  Begin
   OnlySpc:=True;
   For I:=1to Length(NewLine)do If NewLine[I]<>' 'Then OnlySpc:=False;
   If(OnlySpc)Then NewLine:='';
   If NewLine=''Then ALAddLn
                Else ALAddStr(NewLine);
   TEChkMaxLen(Length(NewLine));
   NewLine:='';
   RealLen:=0;
  End;

  Procedure IncNewLine(Chr:Char);
  Var
   NewRealLen:Byte;
  Begin
   If NewLine=''Then Begin
    AddStr(NewLine,Spc(Q.SheetFormat.X1));
    Inc(RealLen,Q.SheetFormat.X1);
   End;
   If(AttrDoc>0)and(Chr<>' ')Then Begin
    IncStr(NewLine,Char(AttrDoc));
    If(AttrDoc and cgDouble=cgDouble)Then Inc(RealLen);
   End;
   IncStr(NewLine,Chr);
   Inc(RealLen);
   NewRealLen:=0;
   If(RealLen>=Q.SheetFormat.X2)Then Begin
    TmpWord:='';
    If NewLine[Length(NewLine)]<>' 'Then Begin
     While NewLine[Length(NewLine)]<>' 'do Begin
      Chr:=NewLine[Length(NewLine)];
      If Chr>' 'Then Inc(NewRealLen);
      TmpWord:=Chr+TmpWord;
      BackStr(NewLine);
      If(Length(NewLine)<=Q.SheetFormat.X1)Then Begin { Mot trop long? }
       AddStr(NewLine,TmpWord);
       TmpWord:='';
       Break;
      End;
     End;
    End;
    DumpLine;
    If TmpWord<>''Then Begin
     TmpWord:=Spc(Q.SheetFormat.X1)+TmpWord;
     RealLen:=NewRealLen+Q.SheetFormat.X1;
    End;
    NewLine:=TmpWord;
   End;
   If Length(NewLine)>=254Then DumpLine;
  End;

 Begin
  If(Q.Mode in[vtGat,vtBas])and(IsGraf)Then Begin
   Include(Q.Option,eBarUp);
   TEPutKeyTxt(Q);
  End;
  InitLoadBuffer;
  NewLine:='';
  RealLen:=0;
  AttrDoc:=0;
  NumLetters:=FirstChoice.NumLetters;
  CurrLet:=0;
  FP:=SizeOf(FirstChoiceHeader);
  If(New)Then Inc(Q.SheetFormat.X2);
  Repeat
   Repeat
    Chr:=ReadChar;
    Inc(CurrLet);
    If Chr=#12Then DumpLine
              Else Break;
   Until False;
   If Byte(Chr)and 128>0Then Begin
    Chr2:=Byte(ReadChar);
    Inc(CurrLet);
    If(Chr2)and 128>0Then Begin
     AttrDoc:=0;
     If(Chr2)and 1>0Then AttrDoc:=AttrDoc or cgUnderline;
     If(Chr2)and 2>0Then AttrDoc:=AttrDoc or cgBold;
     If(Chr2)and 4>0Then AttrDoc:=AttrDoc or cgItalic;
     IncNewLine(Char((Byte(Chr)and$7F)+((Chr2 and 8)shl 4)));
     AttrDoc:=0;
    End;
   End
    Else
   IncNewLine(Chr);
   PutTimer;
   If(CurrLet>NumLetters)Then Break;
  Until EOF;
  If NewLine<>''Then DumpLine;
 End;

 Procedure LoadRTF;
 Label Nxt,XtrkCd;
 Var
  Chr:Char;             { CaractŠre courant }
  Chr2:Byte;            { CaractŠre suivant }
  RealLen:Byte;         { Longueur r‚el }
  AttrDoc:Byte;         { Attribut du caractŠre }
  TmpWord:String;       { Mot temporaire }
  S,SU:String;          { ChaŒne d'extraction }
  InstrWord:String;     { Mot d'instruction }
  Next:Boolean;         { Un mot suit imm‚diatement}
  LettrineSpc:Byte;     { Espace avant lettrine }
  Justified:Char;       { Mode de justification }
  I:Integer;            { Compteur de boucle }
  IW:Word;              { Compteur de position d'instruction }
  Num:Word;             { Nombre de sortie }
  Param:Boolean;        { ParamŠtre pr‚sent? }
  Font:DataSetInMemory; { Pour la conversion de la police de caractŠres }
  Instr:DataSetInMemory;{ Liste des instructions RTF }

  Procedure DumpLine;
  Var
   X:Integer;    { Position X pour centr‚e }
   I:Byte;       { Compteur de boucle }
   OnlySpc:Bool; { Ligne avec seulement des espaces? }
   Len:Byte;     { Longueur d'affichage de la ligne }
  Begin
   Len:=GetLenGatPhys2Scr(NewLine);
   Case(Justified)of
    'C':If(Len<Q.SheetFormat.X2)Then Begin
     NewLine:=Spc((Q.SheetFormat.X2-Len)shr 1)+NewLine;
    End;
    'R':If(Len<Q.SheetFormat.X2)Then Begin
     NewLine:=Spc(Q.SheetFormat.X2-Len)+NewLine;
    End;
   End;
   OnlySpc:=True;
   For I:=1to Length(NewLine)do If NewLine[I]<>' 'Then OnlySpc:=False;
   If(OnlySpc)Then NewLine:='';
   If NewLine=''Then ALAddLn
                Else ALAddStr(NewLine);
   TEChkMaxLen(Length(NewLine));
   NewLine:='';
   RealLen:=0;
  End;

  Procedure IncNewLine(Chr:Char);
  Var
   NewRealLen:Byte;
  Begin
   If NewLine=''Then Begin
    AddStr(NewLine,Spc(Q.SheetFormat.X1));
    Inc(RealLen,Q.SheetFormat.X1);
   End;
   If(AttrDoc>0)and(Chr<>' ')Then Begin
    IncStr(NewLine,Char(AttrDoc));
    If(AttrDoc and cgDouble=cgDouble)Then Inc(RealLen);
   End;
   IncStr(NewLine,Chr);
   Inc(RealLen);
   NewRealLen:=0;
   If(RealLen>=Q.SheetFormat.X2)Then Begin
    TmpWord:='';
    If NewLine[Length(NewLine)]<>' 'Then Begin
     While NewLine[Length(NewLine)]<>' 'do Begin
      Chr:=NewLine[Length(NewLine)];
      If Chr>' 'Then Inc(NewRealLen);
      TmpWord:=Chr+TmpWord;
      BackStr(NewLine);
      If(Length(NewLine)<=Q.SheetFormat.X1)Then Begin { Mot trop long? }
       AddStr(NewLine,TmpWord);
       TmpWord:='';
       Break;
      End;
     End;
    End;
    DumpLine;
    If TmpWord<>''Then Begin
     TmpWord:=Spc(Q.SheetFormat.X1)+TmpWord;
     RealLen:=NewRealLen+Q.SheetFormat.X1;
    End;
    NewLine:=TmpWord;
   End;
   If Length(NewLine)>=254Then DumpLine;
  End;

  Procedure AddNewLine(Const S:String);
  Var
   I:Byte;
  Begin
   For I:=1to Length(S)do IncNewLine(S[I]);
  End;

  Function XtrkString(Var Next:Boolean):String;
  Var
   S:String;
  Begin
   S:='';Next:=False;
   Repeat
    Chr:=ReadChar;
    If(Chr='''')and(S='')Then Break;
    If(Chr)in[#0,#10,#13,' ','\','{','}']Then Break;
    IncStr(S,Chr);
   Until False;
   If Chr='\'Then Next:=True;
   XtrkString:=S;
  End;

  Function IsWord(Const Word:String):Boolean;
  Var
   T:String;
  Begin
   IsWord:=False;
   If CmpLeft(SU,Word)Then Begin
    I:=Length(Word)+1;
    If IsRomanLetter(StrI(I,SU))Then Exit;
    T:='';
    Repeat
     If Not(StrI(I,SU)in['0'..'9','-'])Then Break;
     IncStr(T,SU[I]);
     Inc(I);
    Until Length(SU)<I;
    Param:=T<>'';
    Num:=StrToWord(T);
    S:=Copy(S,I,255);
    IsWord:=True;
   End;
  End;

  Function DumpMsg:Boolean;Begin
   Repeat
    Chr:=ReadChar;
   Until(Chr)in[#0,';','\'];
   DumpMsg:=Chr='\';
  End;

  Function XtrkMessage:String;
  Var
   S:String;
   Chr:Char;
  Begin
   S:='';
   Repeat
    Chr:=ReadChar;
    If(Chr)in[#0,';','\','}']Then Break;
    IncStr(S,Chr);
   Until False;
   XtrkMessage:=S;
  End;

 Begin
  DBOpenServerName(ChantalServer,'CHANTAL:/Country/Ansi2ASCII.Dat');
  If Not DBCopyToMemory(ChantalServer,Font)Then Begin
   __OutOfMemory;
   Exit;
  End;
  DBOpenServerName(ChantalServer,'CHANTAL:/Texte/Format/RTF.Dat');
  If Not DBCopyToMemory(ChantalServer,Instr)Then Begin
   DBDispose(Font);
   __OutOfMemory;
   Exit;
  End;
  Justified:='j';
  LettrineSpc:=0;
  Q.Mode:=vtGat;
  Q.ModeSub:=vtsRTF;
  If(New)Then Begin
   Q.SheetFormat.X1:=10;
   Q.SheetFormat.X2:=70;
   Q.SheetFormat.Y1:=6;
   Q.SheetFormat.Y2:=60;
  End;
{  If(New)Then TESetFormat(Q);}
  InitLoadBuffer;
  NewLine:='';
  RealLen:=0;
  AttrDoc:=0;
  Repeat
   Chr:=ReadChar;
   If DBLocateAbsIM(Font,0,Chr,[])Then Begin
    Inc(PtrRec(Font.CurrRec).Ofs);
    AddNewLine(Font.CurrRec.Str^);
   End
    Else
   Case(Chr)of
    #0,#13,#10:;
    '\':Begin
     Chr:=ReadChar;
     Case(Chr)of
      '*':Begin
       {Repeat
       Until Not((ReadChar)in[#0,'*']);}
      End;
      '~':IncNewLine(' ');
      '''':Begin
XtrkCd:Chr:=ReadChar;
       Case(Chr)of
        '0'..'9','A'..'F','a'..'f':Begin
         S:=Chr;
         Chr:=ReadChar;
         IncStr(S,Chr);
         If(Chr)in['0'..'9','A'..'F','a'..'f']Then Begin
          Num:=HexStrToInt(S);
          If Num>=32Then Begin
           If DBLocateAbsIM(Font,0,Num,[])Then Begin
            Inc(PtrRec(Font.CurrRec).Ofs);
            AddNewLine(Font.CurrRec.Str^);
           End
            Else
           IncNewLine(Char(Num));
          End;
         End
          Else
         AddNewLine(S);
        End;
        Else Begin
         AddNewLine('\''');
         IncNewLine(Chr);
        End;
       End;
      End;
      'A'..'Z','a'..'z':Begin
       S:=Chr+XtrkString(Next);
       Repeat
        SU:=StrUp(S);
        InstrWord:=SU;
        For IW:=1to Length(InstrWord)do Begin
         If Not(InstrWord[IW]in['A'..'Z'])Then Begin
          _Left(InstrWord,IW-1);
          Break;
         End;
        End;
        If DBLocateAbsIM(Instr,1,InstrWord,[])Then Begin
         IsWord(InstrWord);
         Case(Instr.CurrRec.Word^)of
          $0040:XtrkMessage; { ADDITIVE }
          $05B0:XtrkMessage; { AUTHOR }
          $0600:If(Param)Then Begin { B }
           Case(Num)of
            0:AttrDoc:=AttrDoc and Not(cgBold);
            1:AttrDoc:=AttrDoc or cgBold;
           End;
           AddNewLine(S);
          End
           Else
          AttrDoc:=AttrDoc or cgBold;
          $0A00:Begin
           If(DumpMsg)Then Goto Nxt;
          End;
          $0B00,
          $0C00:AddNewLine(S);
          $0D00:If(DumpMsg)Then Goto Nxt;
          $0F00:If(DumpMsg)Then Goto Nxt;
          $1000:If(DumpMsg)Then Goto Nxt;
          $1100:AddNewLine(S);
          $11A0:If(DumpMsg)Then Goto Nxt; { FLDINST }
          $1900:If(DumpMsg)Then Goto Nxt;
          $1B00:Begin { FS }
           Case(Num)of
            0..7:AttrDoc:=cgExposant;
            48..$FFFF:AttrDoc:=AttrDoc or cgDouble;
            Else Begin
             If(AttrDoc=cgExposant)Then AttrDoc:=cgNormal
                                   Else AttrDoc:=AttrDoc and Not(cgDouble);
            End;
           End;
          End;
          $2300:AttrDoc:=AttrDoc or cgItalic; { I }
          $2600:AddNewLine(S);                { LANG }
          $2680:IncNewLine('®');              { LDBLQUOTE }
          $2E00:AddNewLine(S);                { LI }
          $2F00:DumpLine;                     { LINE }
          $3600:Begin                         { LISTTEXT }
           AddNewLine(' ş ');
           AddNewLine(S);
          End;
          $3680:IncNewLine('`');              { LQUOTE }
          $3EA0:XtrkMessage; { OPERATOR }
          $3F00:Begin { Saut de page? }
           DumpLine;
           While(Q.List.Count)mod(Q.SheetFormat.Y2-Q.SheetFormat.Y1)<>0do Begin
            If Not(ALAddLn)Then Break;
           End;
          End;
          $3F80:XtrkMessage; { PANOSE }
          $4200:Begin { PAR }
           DumpLine;
           AttrDoc:=0;
           AddNewLine(Spc(LettrineSpc));
          End;
          $4500:Begin { PGDSCNXT }
           If(DumpMsg)Then Goto Nxt;
          End;
          $49A0,$49A4:XtrkMessage;
          $4A00:Begin { Q }
            { 'c'  Centrer?
              'j'  Justifier
              'l'  A gauche
              'r'  A droite }
           Justified:=SU[2];
           AddNewLine(Copy(S,3,255));
          End;
          $4A80:IncNewLine('¯');          { RDBLQUOTE }
          $4C00:AddNewLine(S);            { RI }
          $4C80:IncNewLine('''');         { RQUOTE }
          $5000:AddNewLine(S);            { SB }
          $5500:If(DumpMsg)Then Goto Nxt; { SNEXT }
          $5680:AddNewLine(SpcTab);       { TAB }
          $56B0:XtrkMessage;              { TITLE }
          $5900:Begin                     { U }
           AttrDoc:=AttrDoc or cgUnderline
          End;
          $5A00:Begin { UL }
           AttrDoc:=AttrDoc or cgUnderline;
           AddNewLine(S);
          End;
         End;
        End
         Else
        Begin
         IncNewLine('\');
         AddNewLine(S);
        End;
        If Not(Next)Then Break;
    Nxt:S:=XtrkString(Next);
        If Chr=''''Then Begin
         Goto XtrkCd;
        End;
       Until False;
      End;
      '{','}':IncNewLine(Chr);
      Else Begin
       IncNewLine('\');
       IncNewLine(Chr);
      End;
     End;
    End;
    '{':;
    '}':AttrDoc:=0;
    Else IncNewLine(Chr);
   End;
   PutTimer;
  Until EOF;
  If NewLine<>''Then DumpLine;
  DBDispose(Instr);
  DBDispose(Font);
 End;

Begin
 GetSysErr:=0;Slp:=0; { Initialise les erreurs }
 If(New)Then Begin
  Mode:=0;
  ModeSub:=0;
 End
  Else
 Begin
  Mode:=Q.Mode;
  ModeSub:=Q.ModeSub;
 End;
 If(New)Then Begin
  TEInitDef(Q);
  TEInitCoord(Q);
 End;
 Q.OldXRules:=$FF;
 AddSpc:=False;
 FP:=0;
 If Name<>''Then Begin
  If CmpLeft(Name,'NEW:')and(New)Then Begin
   Q.Mode:=vtGat;
   Q.EditName:='';
   ALInit(Q.List);
   TEPutWn(Q,X1,Y1,X2,Y2);
   TEPutBar(Q);
   If(Q.Mode=vtGat)Then Begin
    Q.SheetFormat.X1:=0;
    Q.SheetFormat.X2:=65520;
    Q.SheetFormat.Y1:=0;
    Q.SheetFormat.Y2:=87;
{    TESetFormat(Q);}
   End;
   If(Rules)Then Begin
    Dec(Q.W.MaxY);
    TEPutRules(Q);
   End;
   TEInitLang(Q);
   ALAddLn;
   ALSetPtr(Q.List,0);
   Q.CurrPtr:=ALPushCurrPtr(Q.List);
   GetSysErr:=0;{ R‚initialise les erreurs … 0, car tous a ‚t‚ corrig‚... }
   Exit;
  End
   Else
  Begin
   T:=$FF;
   If Name<>'CLIPBOARD'Then Begin
    Name:=StrUp(FileExpand(Name));
    E:=Path2Ext(Name);
    If Pos(E,StrPas(ExtRC))>0Then Mode:=vtRC;
    If Pos(E,StrPas(ExtPas))>0Then Mode:=vtPas;
    If Pos(E,StrPas(ExtFortran))>0Then Mode:=vtFortran;
    If Pos(E,StrPas(ExtEuphoria))>0Then Mode:=vtEuphoria;
    If Pos(E,StrPas(ExtC))>0Then Mode:=vtC;
    If Pos(E,StrPas(ExtBas))>0Then Mode:=vtBas;
    If Pos(E,StrPas(ExtAsm))>0Then Mode:=vtAsm;
    If Pos(E,StrPas(ExtAC))>0Then Mode:=vtAC;
    If(Length(E)>=4)and(Pos(E,'.CBL')>0)Then Mode:=vtCobol;
    If Pos(E,'.GAT')>0Then Mode:=vtGat;
    If Pos(E,'.INI')>0Then Mode:=vtIni;
    If Pos(E,'.BAT;.BTM')>0Then Mode:=vtBatch;
    If Pos(E,'.SQL')>0Then Mode:=vtSql;
    If Pos(E,'.HTM')>0Then Begin
     Case _InputMsg('Chargement du fichier HTML',
        'Voulez-vous charger le document ou le code source du fichier HTML ®'+
        Name+'¯?','Document|Code Source',wfLosange+wiInfo,CurrKrs.RemWin)of
      0:Begin
       Mode:=vtGat;
       ModeSub:=vtsHTML;
      End;
      1:Begin
       Mode:=vtHTMLSourceCode;
      End;
     End;
    End;
   End;
   If(New)Then Begin
    Q.Mode:=Mode;
    Q.ModeSub:=ModeSub;
   End;
  End;
 End;
 Tab8:=Mode in[vtAC,vtAsm,vtBas,vtC,vtEuphoria,vtFortran,vtPas,vtRC,vtSQL];
 If(New)Then Begin
  Q.EditName:=Name;
  ALInit(Q.List);
 End
  Else
 If(Q.Mode=vtGat)and(Tab8)Then AddSpc:=True;
 PutMemory;
 OldActifScrSave:=ActifScrSave;
 ActifScrSave:=False;
 _InitKbd;
 If Name<>''Then Begin
  If Name='CLIPBOARD'Then Begin
   Handle:=hdlClipboard; { Chargement … partir du presse-papier }
  End
   Else
  Begin
    {Dois ˆtre rechercher sur plusieurs unit‚s?}
   If(Length(Name)>=2)and(Name[1]in['?','*'])and(Name[2]=':')Then Begin
    For Chr:='C'to'Z'do Begin
     Handle:=FileOpen(Chr+Copy(Name,2,255),fmRead);
     If(Handle<>errHdl)Then Break;
    End;
   End
    Else
   Handle:=FileOpen(Name,fmRead);
  End;
  If(Handle=errHdl)Then Begin
   If Not(New)Then Exit;
   K:=WarningMsgYesNo('Le fichier '+Name+' n''existe pas! Dois-je le cr‚er?');
   If(K=kbNo)or(K=kbAbort)Then GetSysErr:=$FFFF
    Else
   Begin
    TEPutWn(Q,X1,Y1,X2,Y2);
    TEPutBar(Q);
    If(Mode=vtGat)Then Begin
     Q.SheetFormat.X1:=10;
     Q.SheetFormat.X2:=70;
     Q.SheetFormat.Y1:=6;
     Q.SheetFormat.Y2:=60;
     TESetFormat(Q);
    End;
    If(Rules)Then Begin
     Dec(Q.W.MaxY);
     TEPutRules(Q);
    End;
    TEInitLang(Q);
    ALAddLn;
    ALSetPtr(Q.List,0);
    Q.CurrPtr:=ALPushCurrPtr(Q.List);
    GetSysErr:=0;{ R‚initialise les erreurs … 0, car tous a ‚t‚ corrig‚... }
   End;
   Exit;
  End
   Else
  Begin
   FileSize:=QFileSize(Handle);
   If(New)Then Q.FileSize:=FileSize
          Else Inc(Q.FileSize,FileSize);
   {MkWn;}
   If(Handle<>hdlClipboard)Then WEPutLastBar('Chargement du Presse-Papier dans la texte en cours...')
                           Else WEPutLastBar('Chargement du fichier dans la m‚moire en cours...');
   QGetRec(Handle,0,SizeOf(PW),PW);
   If(Mode=vtGAT)and(ModeSub=vtsHTML)Then Begin
    MkWn;
    LoadDocumentHTML;
   End
    Else
   If(Mode=vtBas)and(TChr[0]in[#0..#31,#128..#255])Then Begin
    MkWn;
    LoadPackBasic;
   End
    Else
   If(MsWord.ID=$BE31)or(MsWord.ID=$BE32)or(MsWord.ID=$CFD0)Then Begin
    MkWn;
    LoadMsWord;
   End
    Else
   If FirstChoice.Sign='GERBILDOC   'Then Begin
    MkWn;
    Mode:=vtGat;
    ModeSub:=vtsFirstChoice;
    If(New)Then Begin
     Q.Mode:=vtGat;
     Q.ModeSub:=vtsFirstChoice;
     Q.SheetFormat.X1:=FirstChoice.X1;
     Q.SheetFormat.X2:=FirstChoice.X2;
     Q.SheetFormat.Y1:=FirstChoice.MargeUp;
     Q.SheetFormat.Y2:=FirstChoice.PageLen-FirstChoice.MargeDn;
    End;
    LoadFirstChoice;
   End
    Else
   If RTFSign='{\rtf'Then Begin
    MkWn;
    LoadRTF
   End
    Else
   If PW.Sign='TYPE 3'Then Begin
    MkWn;
    Q.Mode:=vtPW;
    Q.SheetFormat.X1:=PW.X1;
    Q.SheetFormat.X2:=PW.X2;
    LoadPW(Handle,Q.StrMx,Q.SheetFormat.X1);
   End
    else
   Begin
    If GetSysErr<>0Then GetSysErr:=errEdtFileSize;
    If(Mode=vtGat)Then Begin
     __QGetAbsFileTxtLn(Handle,FP,S);
     If GetSysErr<>0Then GetSysErr:=errEdtRead;
     If StrI(1,S)in[':',';']Then Begin
      PassWord:=S[1]=';';
      If(New)Then Begin
       TW[0]:=@Q.SheetFormat.X1;
       TW[1]:=@Q.SheetFormat.Y1;
       TW[2]:=@Q.SheetFormat.X2;
       TW[3]:=@Q.SheetFormat.Y2;
       J:={$IFDEF Real}XtrkWdInStr{$ELSE}XtrkLongInStr{$ENDIF}(S,4,TW);
       If J=0Then Begin
        If(WarningMsgYesNo('Entˆte de fichier GAT endomag‚! Dois-je utiliser le format par d‚faut?')=kbYes)Then Begin
         Q.SheetFormat.X1:=10;
         Q.SheetFormat.X2:=70;
         Q.SheetFormat.Y1:=6;
         Q.SheetFormat.Y2:=60;
        End;
       End;
       S2:=XtrkWord(J,S);
       If(S2='L')or(S2='LEFT')Then Q.PageNumIn:=ptLeft Else
       If(S2='R')or(S2='RIGHT')Then Q.PageNumIn:=ptRight Else
       If(S2='A')or(S2='ALTERNATE')Then Q.PageNumIn:=ptAltern
                                   Else Q.PageNumIn:=ptNone;
       SkipSpcInLn(J,S);
       S3:=XtrkDecNm(J,S);
       If S3<>''Then Begin
        Q.PageNumStart:=StrToInt(S3);
        SkipSpcInLn(J,S);
        Case StrI(J,S)of
         { Indicateur d'information compl‚mentaire }
         'I':Q.InfoCompl:=True;
        End;
       End;
      End;
      AddSpc:=False;
     End
      Else
     Begin
      Password:=False;
      AddSpc:=True;
      If(New)Then Begin
       Q.SheetFormat.X1:=10;
       Q.SheetFormat.X2:=70;
      End;
      FP:=0;
     End;
    End
     Else
    PassWord:=False;
    If X2-X1>Q.SheetFormat.X2+10Then X2:=X1+Q.SheetFormat.X2+10;
    MkWn;
    If(PassWord)Then Begin
     If Not(InpPassWord(UserPassWord))Then Begin
      GetSysErr:=errPassWord;
      Goto Brk;
     End;
     _QGetAbsRec(Handle,FP,SizeOf(QX.PassWord),Q.PassWord);
     InvBuf(Q.PassWord,SizeOf(QX.PassWord));
     If StrUp(UserPassWord)<>'FUCKPASSWORD'Then Begin
      If Q.PassWord<>StrUp(UserPassWord)Then Begin
       GetSysErr:=errPassWord;
       Goto Brk;
      End;
     End;
     Inc(FP,SizeOf(QX.PassWord));
     Repeat
      _QGetAbsRec(Handle,FP,SizeOf(Buffer),Buffer);
      If GetSysErr<>0Then Begin
       GetSysErr:=errEdtRead;
       Goto Brk;
      End;
      InvBuf(Buffer,SizeOf(Buffer));
      Slp:=StrLen(@Buffer);Inc(FP,Slp+1);
      TEChkMaxLen(Slp);
      Ptr:=ALAdd(Slp+1);
      If(Ptr=NIL)Then Begin
       GetSysErr:=errEdtFileTooBig;
       Goto Brk;
      End;
      MoveLeft(Buffer,Ptr^,Slp+1);
      PutTimer;
     Until FP>=FileSize
    End
     Else
    If(Tab8)or(AddSpc)Then Repeat
     __QGetAbsFileTxtLn(Handle,FP,S);
     If GetSysErr<>0Then Begin
      GetSysErr:=errEdtRead;
      Goto Brk;
     End;
     If(Mode=vtGat)and(CmpLeft(S,'[DC:')or CmpLeft(S,'[DD:'))Then Begin
      Drw.Model:=mtImage;
      Drw.Pos:=deCenter;
      Drw.Path:=Copy(S,5,255);
      GetFile(Drw.Path,0,SizeOf(GPXHeader),Drw.GPX);
      Drw.X1:=0;
      Drw.Y1:=Q.List.Count;
      Drw.X2:=Q.SheetFormat.X2;
      Drw.Y2:=Drw.Y1+Drw.GPX.Ln;
      Drw.Ofs:=SizeOf(GPXHeader)+Drw.GPX.Len*Drw.GPX.Ln;
      PC:=Memories.ALAdd(Q.Processus,SizeOf(DrawInEdt));
      If(PC=NIL)Then Begin
       GetSysErr:=errEdtFileTooBig;
       Goto Brk;
      End;
      MoveLeft(Drw,PC^,SizeOf(DrawInEdt));
     End;
     If(Tab8)Then SetTab(S);
     If(AddSpc)Then Begin
      SetTab(S);
      If(S<>'')and(Length(S)<>255)Then S:=Spc(Q.SheetFormat.X1)+S;
     End;
     If(Not(New))and(AddSpc)and(Q.Mode=vtGat)and(Length(S)>Q.SheetFormat.X2)Then Begin
      If Not ALAddParagraph(S)Then Begin
       If GetSysErr=0Then GetSysErr:=errEdtFileTooBig;
       Goto Brk;
      End;
     End
      Else
     Begin
      TEChkMaxLen(Wd(Length(S)));
      If Not ALAddStr(S)Then Begin
       ALDone(Q.List);
       ALInit(Q.List);
       GetSysErr:=errEdtFileTooBig;
       Goto Brk;
      End;
     End;
     PutTimer;
    Until FP>{=}FileSize
     Else
    Begin
     K:=0;KR:=0;
     Repeat
      If K>=SizeOf(Buffer)Then KR:=0 Else KR:=K;
      If Not ReadLine(Handle,FP,SizeOf(Buffer),Buffer,K)Then Begin
       KR:=0;K:=0;
       ReadLine(Handle,FP,SizeOf(Buffer),Buffer,K);
       Slp:=StrLen(@Buffer);
      End
       Else
      Slp:=K-KR;
      If GetSysErr<>0Then Begin
       GetSysErr:=errEdtRead;
       Goto Brk;
      End;
      If(CmpPLeft(@Buffer[KR],'[DC:')or CmpPLeft(@Buffer[KR],'[DD:'))Then Begin
       S:=StrPas(@Buffer[KR]);
       Drw.Model:=mtImage;
       Drw.Pos:=deCenter;Drw.Path:=Copy(S,5,255);
       If StrI(2,Drw.Path)<>':'Then Drw.Path:='?:'+Drw.Path;
       GetFile(Drw.Path,0,SizeOf(GPXHeader),Drw.GPX);
       If(RILoadImage(Drw.Path,diAutoDetect,0,$FFFF,rmAllResSteady,[],Drw.Res)=eriNone)Then Begin
        RIRes2WnImg(Drw.Res,TImg);
        RIMakeDoublon(Drw.Res,rmAllResSteady,True,TImg);
        XFreeMem(Drw.Res);
        Drw.Res:=TImg.Miroir;
        XGetAbsRec(Drw.Res,0,SizeOf(Res),Res);
        Drw.GPX.Len:=Res.NumXPixels;
        Drw.GPX.Ln:=Res.NumYPixels shr 3;
        If Res.NumYPixels and 7>0Then Inc(Drw.GPX.Ln);
       End;
       SysErr:=0;
       Drw.X1:=0;
       Drw.Y1:=Q.List.Count;
       Drw.X2:=Q.SheetFormat.X2;
       Drw.Y2:=Drw.Y1+Drw.GPX.Ln;
       Drw.Ofs:=SizeOf(GPXHeader)+Drw.GPX.Len*Drw.GPX.Ln;
       PC:=Memories.ALAdd(Q.Processus,SizeOf(DrawInEdt));
       If(PC=NIL)Then Begin
        GetSysErr:=errEdtFileTooBig;
        Goto Brk;
       End;
       MoveLeft(Drw,PC^,SizeOf(DrawInEdt));
      End;
      TEChkMaxLen(Slp);
      Ptr:=ALAdd(Slp+1);
      If(Ptr=NIL)Then Begin
       GetSysErr:=errEdtFileTooBig;
       Goto Brk;
      End;
      MoveLeft(Buffer[KR],Ptr^,Slp+1);
      PutTimer;
     Until FP+K>=FileSize;
    End;
Brk:
   End;
   Slp:=GetSysErr;
   If(Handle<>hdlClipBoard)Then FileClose(Handle);
   GetSysErr:=Slp;
  End;
 End
  Else
 Begin
  TEPutWn(Q,X1,Y1,X2,Y2);
  TEPutBar(Q);
  ALAddLn
 End;
 Slp:=GetSysErr;
 TEPutBarXYM(Q.StrMX,Q.List.Count,Q.FileSize);
 If(New)Then Begin
  If(Q.Mode=vtDefault)Then Begin
   PC:=_ALGetBuf(Q.List,0);
   If(PC<>NIL)Then Begin
    S:=StrUp(LTrim(StrPas(PC)));
    If PC^[0]='{'Then Q.Mode:=vtPas else
    If(PC^[0]='(')and(PC^[1]='*')Then Q.Mode:=vtPas else
    If(CmpLeft(S,'PROGRAM'))or(CmpLeft(S,'UNIT'))or
      (CmpLeft(S,'FUNCTION'))or(CmpLeft(S,'PROCEDURE'))Then Q.Mode:=vtPas;
   End;
  End;
  TEInitLang(Q);
  If(Rules)Then Dec(Q.W.MaxY);
 End;
 TEUpDateScr(Q);
 If(Q.Mode in[vtBas,vtGat])and(IsGraf)Then Begin
  TEPutKeyTxt(Q);
 End;
 TESetCur(Q);
 TEPutBar(Q);
 ActifScrSave:=OldActifScrSave; { R‚activation de l'‚conomiseur d'‚cran }
 If(Q.Mode=vtGat)Then Q.ScrollLock:=True;
 If(New)Then ALSetPtr(Q.List,0)
        Else ALSetPtr(Q.List,Q.P);
 Q.CurrPtr:=ALPushCurrPtr(Q.List);
 GetSysErr:=Slp;
 If GetSysErr>0Then Begin
  TEDone(Q);
  Slp:=SysErr;
  If(GetSysErr<>$FFFF)and(GetSysErr<>errPassWord)Then
   ErrNoMsgOk(GetSysErr);
  SysErr:=Slp;
 End
  Else
 Begin
  WESelRightBarPos(Q.W,Q.P,Q.List.Count-1);
  WriteLog('dition de '+Name);
  If SysErr>0Then SysErr:=errLog;
 End;
 PutMemory;
End;

Procedure TEOpen(Var Context;X1,Y1,X2,Y2:Byte;Const _Name:String);
Var
 Q:EditorApp Absolute Context;
Begin
 _TEOpen(Q,X1,Y1,X2,Y2,_Name,True);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Proc‚dure _TEInsFile                           Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


  Description
  ÍÍÍÍÍÍÍÍÍÍÍ

   Cette proc‚dure style objet, est utilis‚ pour ins‚rer un fichier existant
  sur disque  dans  le fichier ou … partir du Presse-Papier en plein ‚dition
  d‚finit dans l'‚tiquette ®Q¯.


  Remarques
  ÍÍÍÍÍÍÍÍÍ

   ş Utilis‚s dans le ®MonsterBook® par le Menu ®Fichier¯,  item  ®InsŠre un
     fichier¯.

   ş Il est portable aussi bien sur le ®Malte Genesis III: Isabel¯   que sur
     l'ensemble  ®Malte  Genesis  IV:  Chantal¯.    Malgr‚  tout,  certaines
     diff‚rences peuvent se manifester … cause de l'‚volution,  du d‚boguage
     et 56 raisons du mˆmes genre.

   ş Cette proc‚dure support n'importe  quel genre de fichier ®.GAT¯.  Aussi
     la version d'origine que la version prot‚g‚.
}

Procedure _TEInsFile(Var Q:EditorApp;Path:String;ClipBoard:Boolean);Begin
 If(Clipboard)Then Path:='CLIPBOARD';
 _TEOpen(Q,0,0,0,0,Path,False);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Proc‚dure TEInsFile                            Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


  Description
  ÍÍÍÍÍÍÍÍÍÍÍ

   Cette proc‚dure style objet, est utilis‚ pour ins‚rer un fichier existant
  sur disque dans le fichier en plein ‚dition d‚finit dans l'‚tiquette ®Q¯.


  Remarques
  ÍÍÍÍÍÍÍÍÍ

   ş Utilis‚s dans le ®MonsterBook® par le Menu ®Fichier¯,  item ®InsŠre un
     fichier¯.

   ş Il est portable aussi bien sur le ®Malte Genesis III: Isabel¯  que sur
     l'ensemble  ®Malte  Genesis  IV:  Chantal¯.   Malgr‚  tout,  certaines
     diff‚rences peuvent se manifester … cause de l'‚volution, du d‚boguage
     et 56 raisons du mˆmes genre.

   ş Cette proc‚dure support n'importe quel genre de fichier ®.GAT¯.  Aussi
     la version d'origine que la version prot‚g‚.
}

Procedure TEInsFile;Begin
 _TEInsFile(Q,Path,False)
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                       Proc‚dure TEOpenSpecialTitle                   Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure ouvre un texte comme la proc‚dure ®TEOpen¯ mais fixe un
 titre particulier (d‚finit par la variable de param‚trage ®Title¯)  … la
 place de son chemin ainsi qu'une toile de couleur d'aide plut“t  que cel
 destin‚ au traŒtement de texte.
}

Procedure TEOpenSpecialTitle;
Label Break;
Var
 Handle:Hdl;
 Err:Word;
 I,FP:LongInt;
 Str:String;
 T,J:Byte;
 PC:PChr;
 Chr:Char;
 AddSpc:Boolean;

 Procedure TEPutBarXYM(_X:Word;_Y:RBP;Mem:LongInt);Near;
 Var
  Color:Byte;
 Begin
  If(Q.Mode=vtHlp)Then
   WESetEndBarTxtX(Q.W,35,{$IFDEF __Windows__}
    IntToStr((DivLong(_Y,(Q.SheetFormat.Y2-Q.SheetFormat.Y1))+1))
   {$ELSE}
    WordToStr((_Y div(Q.SheetFormat.Y2-Q.SheetFormat.Y1))+1)
  {$ENDIF}+' Pages',Q.W.Palette.Title)
   Else
  Begin
   If(Q.Mode=vtPJ)Then Color:=$D5
                  Else Color:=CurrKrs.Editor.Env.Pos;
   WESetEndBarTxtX(Q.W,35,WordToStr(_X)+'x'+{$IFDEF __Windows__}
    IntToStr(_Y)
   {$ELSE}
    WordToStr(_Y)
   {$ENDIF}+': '+IntToStr(Mem)+' octet(s)',Color);
  End;
 End;

 Function XtrkDec:Word;Begin
  SkipSpcInLn(J,Str);
  XtrkDec:=StrToWord(XtrkDecNm(J,Str));
 End;

Begin
 TEInit(Q,Name);
 Q.Mode:=vtHlp;
 Q.EditName:=Name;
 Q.Title:=Title;
 TEPutWn(Q,X1,Y1,X2,Y2);
 TEPutBar(Q);
 GetSysErr:=0;
 AddSpc:=False;
 Handle:=FileOpen(Name,fmRead);
 If(Handle=errHdl)Then GetSysErr:=errEdtOpen
  Else
 Begin
  Q.FileSize:=FileSize(Handle);
  FP:=0;
  If GetSysErr<>0Then Begin
   GetSysErr:=errEdtFileSize;
   Exit;
  End;
  __GetAbsFileTxtLn(Handle,FP,Str);
  If GetSysErr<>0Then GetSysErr:=errEdtRead;
  If Str[1]=':'Then Begin
   J:=2;
   Q.SheetFormat.X1:=XtrkDec;
   Q.SheetFormat.Y1:=XtrkDec;
   Q.SheetFormat.X2:=XtrkDec;
   Q.SheetFormat.Y2:=XtrkDec;
   AddSpc:=False;
  End
   Else
  Begin
   AddSpc:=True;
   Q.SheetFormat.X1:=10;
   Q.SheetFormat.X2:=70;
   FP:=0;
  End;
  If(Q.Mode=vtHlp)Then AddSpc:=False;
  Repeat
   __GetAbsFileTxtLn(Handle,FP,Str);
   If GetSysErr<>0Then Begin
    GetSysErr:=errEdtRead;
    Goto Break;
   End;
   SetTab(Str);
   If(AddSpc)and(Str<>'')Then Str:=Spc(10)+Str;
   TEChkMaxLen(Q,Word(Length(Str)));
   If Not ALAddStr(Q.List,Str)Then Begin
    GetSysErr:=errEdtFileTooBig;
    Goto Break;
   End;
   If GetRawTimerB and 1=0Then Begin
    If(T<>GetRawTimerB)Then Begin
     PutMemory;
     TEPutBarXYM(Q.StrMX,Q.List.Count,Q.FileSize);
     T:=GetRawTimerB;
    End;
   End;
  Until FP>=Q.FileSize;
 Break:
  FileClose(Handle);
 End;
 TEInitLang(Q);
 If(Rules)Then Dec(Q.W.MaxY);
{ If(Edt(Q).Mode in[vtBas,vtGat])and(IsGraf)Then Begin
  TEPutKeyTxt(Edt(Q));
 End;}
 Q.ScrollLock:=Q.Mode=vtGat;
 If Q.List.Count=0Then ALAddLn(Q.List);
 ALSetPtr(Q.List,0);
 Q.CurrPtr:=ALPushCurrPtr(Q.List);
 TEUpDateScr(Q);
 TESetCur(Q);
 TEPutBar(Q);
 WESelRightBarPos(Q.W,Q.P,Q.List.Count-1);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Proc‚dure TEPasteClipBoard                      Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet d'ins‚rer le contenu du ®ClipBoard¯ dans l'‚diteur
 de texte d‚finit par la variable de param‚trage ®Q¯.
}

Procedure TEPasteClipBoard(Var Q:EditorApp);Begin
 _TEInsFile(Q,'',True);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                  Proc‚dure TEPasteClipboardWindows             Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de coller un bloc … partir de Windows vers
 le traŒtement de texte.
}

Procedure TEPasteClipboardWindows(Var Q:EditorApp);
Var
 Len:LongInt;    { Taille du presse-papier }
 Data:PChr;      { Pointeur sur le contenu du presse-papier }
 FP,P,I:Word;    { Position fichier et ligne, boucle }
 S:String;       { ChaŒne de contenant la ligne de traŒtement }
 AddSpc:Boolean; { Doit-il ajouter des espaces au d‚but de chaque ligne? }
 L:Window;       { Objet de sauvegarde de la ligne d'information }
Begin
 WEPushEndBar(L);
 WEPutLastBar('Chargement de donn‚e du presse-papier...');
 AddSpc:=Q.Mode=vtGat;
 If(ClipboardFunctionsAvailable)Then Begin
  If(OpenClipboard)Then Begin
   Len:=GetClipboardDataSize(cfOemText);
   If Len=0Then WarningMsgOk('Presse-papier vide!')Else
   If Len<=65520Then Begin
    Data:=MemAlloc(Len);
    GetClipboardData(cfOemText,Data);
     {Chargement du texte...}
    FP:=0;P:=Q.P;
    Repeat
     S:='';
     For I:=FP to Len-1do Begin
      If(Data^[FP]=#13)and(Data^[FP+1]=#10)Then Begin
       Inc(FP,2);
       Break;
      End;
      IncStr(S,Data^[FP]);
      Inc(FP);
      If(AddSpc)and(Length(S)+Q.SheetFormat.X1>=255)Then Break Else
      If Length(S)=255Then Break;
     End;
     If GetSysErr<>0Then Begin
      GetSysErr:=errEdtRead;
      Break;
     End;
     TEChkMaxLen(Q,Wd(Length(S)));
     If S<>''Then Begin
      If(AddSpc)Then S:=Spc(Q.SheetFormat.X1)+S;
      If Not ALInsStr(Q.List,P,S)Then Begin
       GetSysErr:=errEdtFileTooBig;
       Break;
      End;
     End;
     Inc(P);
    Until FP>=Len;
    Q.Modified:=True;
    TERefresh(Q);
     {Terminer}
    FreeMemory(Data,Len);
   End
    Else
   ErrNoMsgOk(ErrClipboardTooBig);
   CloseClipboard;
  End
   else
  ErrNoMsgOk(ErrCannotOpenClipboard);
 End
  Else
 ErrNoMsgOk(ErrClipboardWindows);
 WEDone(L);
End;

Procedure TEInsImage(Var Q:EditorApp;Path:String);
Var
 Drw:DrawInEdt;
 PC:PChr;                    { Pointeur sur la ligne courante }
 TImg:MCanvas;               { Objet d'image }
 Res:ImageHeaderRes;         { Ressource attribu‚ … l'image }
 I:Integer;                  { Compteur de boucle }
Begin
 If(StrI(2,Path)=':')and(Not(Path[1]in['?','*']))Then Path[1]:='?';
 Drw.Pos:=deCenter;Drw.Path:=Path;
 If StrI(2,Drw.Path)<>':'Then Drw.Path:='?:'+Drw.Path;
 GetFile(Drw.Path,0,SizeOf(GPXHeader),Drw.GPX);
 If(RILoadImage(Drw.Path,diAutoDetect,0,$FFFF,rmAllResSteady,[],Drw.Res)=eriNone)Then Begin
  RIRes2WnImg(Drw.Res,TImg);
  RIMakeDoublon(Drw.Res,rmAllResSteady,True,TImg);
  XFreeMem(Drw.Res);
  Drw.Model:=mtImage;
  Drw.Res:=TImg.Miroir;
  XGetAbsRec(Drw.Res,0,SizeOf(Res),Res);
  Drw.GPX.Len:=Res.NumXPixels;
  Drw.GPX.Ln:=Res.NumYPixels shr 3;
  If Res.NumYPixels and 7>0Then Inc(Drw.GPX.Ln);
 End
  Else
 ErrNoMsgOk(errImageNotFoundUnreadable);
 SysErr:=0;
 If(StrI(2,Path)=':')and(Path[1]in['?','*'])Then Path:=Copy(Path,3,255);
 ALInsStr(Q.List,Q.P,'[DC:'+Path);
 Drw.X1:=0;
 Drw.Y1:=Q.P;
 Drw.X2:=Q.SheetFormat.X2;
 Drw.Y2:=Drw.Y1+Drw.GPX.Ln;
 Drw.Ofs:=SizeOf(GPXHeader)+Drw.GPX.Len*Drw.GPX.Ln;
 PC:=ALAdd(EditorApp(Q).Processus,SizeOf(DrawInEdt));
 If(PC=NIL)Then Begin
  GetSysErr:=errEdtFileTooBig;
  __OutOfMemory;
  Exit;
 End;
 MoveLeft(Drw,PC^,SizeOf(DrawInEdt));
 For I:=(Drw.GPX.Ln)downto 1do Begin
  PC:=ALIns(Q.List,Q.P+1,1);
  If(PC<>NIL)Then Begin
   PC^[0]:=#0;
  End;
 End;
 TEUpDateScr(Q);
 TESetPtr(Q);
 _TESetModified(Q);
End;

{ Cette proc‚dure … pour but d'ouvrir un fichier document de format GAT
 dans le but ‚ventuel de le sauvegarder.
}

Procedure TELoad2Save(Var Q:EditorApp;Const Name:String);
Var
 Password:Boolean;
 FP:LongInt;
 J:Byte;
 E:ExtStr;
 TW:Array[0..3]of {$IFDEF Real}PWord{$ELSE}PLong{$ENDIF};
 S,S2,S3:String;
Begin
 FillClr(Q,SizeOf(Q));
 Q.EditName:=Name;
 Q.Handle:=FileOpen(Name,fmRead);
 Q.FileSize:=FileSize(Q.Handle);
 Q.List.Count:=$FFFF;
 Q.BY2:=$FFFF;
 E:=Path2Ext(Name);
 If E='.GAT'Then Begin
  Q.Mode:=vtGAT;
  FP:=0;
  __QGetAbsFileTxtLn(Q.Handle,FP,S);
  If GetSysErr<>0Then GetSysErr:=errEdtRead;
  If StrI(1,S)in[':',';']Then Begin
   PassWord:=S[1]=';';
   TW[0]:=@Q.SheetFormat.X1;
   TW[1]:=@Q.SheetFormat.Y1;
   TW[2]:=@Q.SheetFormat.X2;
   TW[3]:=@Q.SheetFormat.Y2;
   J:={$IFDEF Real}XtrkWdInStr{$ELSE}XtrkLongInStr{$ENDIF}(S,4,TW);
   If J=0Then Begin
    Q.SheetFormat.X1:=10;
    Q.SheetFormat.X2:=70;
    Q.SheetFormat.Y1:=6;
    Q.SheetFormat.Y2:=60;
   End;
   S2:=XtrkWord(J,S);
   If(S2='L')or(S2='LEFT')Then Q.PageNumIn:=ptLeft Else
   If(S2='R')or(S2='RIGHT')Then Q.PageNumIn:=ptRight Else
   If(S2='A')or(S2='ALTERNATE')Then Q.PageNumIn:=ptAltern
                               Else Q.PageNumIn:=ptNone;
   SkipSpcInLn(J,S);
   S3:=XtrkDecNm(J,S);
   If S3<>''Then Begin
    Q.PageNumStart:=StrToInt(S3);
    SkipSpcInLn(J,S);
    Case StrI(J,S)of
     { Indicateur d'information compl‚mentaire }
     'I':Q.InfoCompl:=True;
    End;
   End;
  End
 End
  Else
 Begin
  If Pos(E,StrPas(ExtPas))>0Then Q.Mode:=vtPas;
  If Pos(E,StrPas(ExtFortran))>0Then Q.Mode:=vtFortran;
  If Pos(E,StrPas(ExtEuphoria))>0Then Q.Mode:=vtEuphoria;
  If Pos(E,StrPas(ExtC))>0Then Q.Mode:=vtC;
  If Pos(E,StrPas(ExtBas))>0Then Q.Mode:=vtBas;
  If Pos(E,StrPas(ExtAsm))>0Then Q.Mode:=vtAsm;
 End;
End;

END.