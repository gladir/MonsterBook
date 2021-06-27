{⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ‹
 ≥                                                              €
 ≥           B   A   S    I    C        P    R    O             €
 ≥                                                              €
 ≥                             pour                             €
 ≥                                                              €
 ≥      L'ensemble Malte Genesis III & IV: Isabel & Chantal     €
 ≥ Tous droits rÇservÇs par les Chevaliers de Malte 1995 Ö 1997 €
 ≥                                                              €
 ¿‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹€


 Description
 ÕÕÕÕÕÕÕÕÕÕÕ

   Cette programme est l'Çquivalent d'un ÆQBasicØ en ceci qu'il permet
 d'Çditer de faáon confortable un programme en BASIC tout en disposant
 d'un interprÇteur.
}

Program BasicPro;

(*{$I DEF.INC}
{$E+,N+}*)

(*Uses {$IFDEF Adele}Adele,{$ELSE}Chantal,Goldnaxe,{$ENDIF}
     Dos,Systex,Isatex,Systems,Video,Mouse,Pritex,Dialex,Dials,DialPlus,
     Editor,EdtLoad,EdtSearc,EdtDone,InfoMemo,Numerix,H;*)

Uses BPOverlay,BasicInterpretor;

{$O Arcade}   {Arcade, animation et Çconomiseur d'Çcran}
{$O DrawEdit}
{$O EditIcon}
{$O EdtBlock} {Traåtement de texte - Gestion des blocs}
{$O EdtDone}  {Terminaison du traåtement de texte}
{$O EdtExtra} {Outils supplÇmentaire du traåtement de texte}
{$O EdtJust}  {Outils de justification du traåtement de texte}
{$O EdtLoad}  {Chargeur de document du traåtement de texte}
{$O EdtSave}  {Sauvegarde de document du traåtement de texte}
{$O EdtSearc} {Recherche dans le traåtement de texte}
{$O FileMana}
{$O FontEdt}
{$O Loader}
{$O MalCalc}
{$O Protocol}
{$O QHexView}
{$O ResLoadI}
{$O ResSaveI}
{$O Show}
{$O Sourcer}
{$O TMDials}
{$O ToolHead}
{$O ToolPrn}
{$O ToolTerm}
{$O FontEdt}  {Editeur de police de caractäres}
{$O FontMana} {Gestionnaire de police de caractäres}
{$O Goldnaxe} {Affichage de forme gÇomÇtrique complexe}
{$O InfoMemo} {Information sur les composants mÇmoires}
{$O Loader}   {Menu d'application texte}
{$O MalCalc}  {Tableur (chiffrier Çlectronique)}
{$O Numerix}  {Calculatrice programmable, conversion de donnÇes}
{$O PrnFileM} {Impression du Gestionnaire de fichiers}
{$O Protocol} {Protocol de communication (ASCII, XModem,...)}
{$O QHexView} {êditeur hexadÇcimal}
{$O ResLoadI} {Chargement de ressources d'image}
{$O ResSaveI} {Sauvegarde de ressources d'image}
{{$O ResServI}{Service de ressources d'image}
{$O Show}     {Visualisateur d'image}
{$O Sourcer}  {DÇsassembleur de code machine}
{$O SysPlus}  {SupplÇment au systäme d'exploitation}
{$O Terminal} {êmulateur de terminal}
{$O TMDials}  {Terminal avancÇe}
{$O Tools}    {Outils divers}
{$O ToolDsk}  {Outils disque}
{$O ToolFile} {Outils associÇ au Gestionnaire de fichiers}
{$O ToolHead} {Outils d'entàte de fichier}
{$O ToolInfo} {Informations systämes}
{$O ToolPrn}  {Outils d'impression}
{$O ToolTerm} {Prompt, Shell,...}
{$O ToolView} {Outils de visualisation ASCII}

(*Const
 bpNew=$F001;
 bpOpen=$F002;
 bpSave=$F003;
 bpSaveAs=$F004;
 bpRun=$F005;
 bpOutput=$F006;
 bpPreviousWn=$F007;
 bpNextWn=$F008;
 bpAbout=$F009;
 bpExit=$F00A;
 ExitProgramNow=-666;
 StopProgram=-777;

Type
 NmType=Record
  Format:Byte;
  Case Byte of
   0:(Int,IntHi:Integer);
   1:(Word:Word);
   2:(Long:LongInt);
   3:(Single:Single);
   4:(Double:Double);
 End;

Var K,IT,JT,SegBas:Wd;Output,MS:ImgRec;{$IFDEF HeapVram}OldHeapVram:Bool;{$ENDIF}
    OldMode:Byte;Boucle:Array[0..63]of Record Model:(BNo,BFor,BWhile,BDo);X,Y,X2,X3:Word;Data:Array[0..6]of Byte;End;
    Gosub:Array[0..63]of Record X,Y:Wd;End;
    BouclePos,GosubPos:Byte;
    Data:Array[0..47999]of Byte;CurData:Word;RunXit:Int;
    PC:PChr;InKeyB:Int;Regs:Registers;

Procedure SetPaletteRGB(A,R,G,B:Int);Var X:RGB;Begin
 X.R:=R;X.G:=G;X.B:=B;
 SetPalRGB(X,A,1);
End;

Procedure PutMnu;Begin
 WEPutLastBar('^F2^ Sauvegarder  ^F3^ Ouvre');
End;

Procedure About;Var W,W2:Wins;I:Byte;K:Wd;Begin
 WEInitO(W,39,12);
 WEPushWn(W);
 WEPutWnKrDials(W,'A propos!');
 WELn(W);
 WEPutOTxt(W,'Basic PRO');
 WELn(W);
 WEPutOTxt(W,'Version 1.0');
 WELn(W);
 WEPutOTxt(W,'Tous droits rÇservÇs (c) par');
 WELn(W);
 WEPutOTxt(W,'Les Chevaliers de Malte');
 Repeat
  K:=WEGetkHorDn(W,'Correcte|DÇtails');
  Case(K)of
   0,kbAbort:Break;
   1:Begin
    WEInitO(W2,40,20);
    WEPushWn(W2);
    WEPutWnKrDials(W2,'A propos DÇtaillÇ');
    WELn(W2);
    WEPutTxtLn(W2,'FabriquÇ au:      QuÇbec Libre!!!');
    WEPutTxtLn(W2,'êcrit en:         Borland Pascal 7');
    WEPutTxtLn(W2,'Lignes de code:   30 000 Pascal');
    WEPutTxtLn(W2,'                  10 000 Assembleur');
    WEPutTxtLn(W2,'Taille du Source: 3 MegaOctets');
    WEPutTxtLn(W2,'Bibliothäques:    Malte Genesis IV');
    WEPutTxtLn(W2,'                  Alias Chantal');
    WEPutTxtLn(W2,'      & Extension Malte Genesis V');
    WEPutTxtLn(W2,'                  Alias Adäle');
    WEPutTxtLn(W2,'Date de frabric.: Janvier 1998');
    WEPutTxtLn(W2,'MÇthode de fabr.: La patience voyont!');
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

{⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ‹
 ≥                           ProcÇdure LockOutput                        €
 ¿‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹€


 Description
 ÕÕÕÕÕÕÕÕÕÕÕ

  Cette procÇdure permet de voir l'Çcran de sortie de l'application. C'est
 l'Çcran DOS d'oó le programme arrive... (Output)!
}

Procedure LookOutput;Var MS:ImgRec;I:Wd;{$IFDEF HeapVram}OldHeapVram:Bool;{$ENDIF}
 Procedure PutErr;Begin If GetSysErr>0Then ErrMsgOk(StrW(I)+':'+GetDosErrMsg(GetSysErr))End;
Begin
 DialTimer:=No;{$IFDEF HeapVram}OldHeapVram:=HeapVram;{$ENDIF}
 __HideMousePtr;
 PushScr(MS);I:=1;PutErr;
 {$IFDEF HeapVram}HeapVram:=No;{$ENDIF}
 PopScr(Output);I:=2;PutErr;
 SimpleCur;
 __ShowMousePtr;
 Repeat{While ReadKey=7do CarteBios;}
  Case(ReadKey)of
   7:CarteBios;
{   kbCtrlIns:ClipBoardOutput;}
   Else Break;
  End;
 Until No;
 __HideMousePtr;
 PushScr(Output);I:=3;PutErr;
 {$IFDEF HeapVram}HeapVram:=OldHeapVram;{$ENDIF}
 PopScr(MS);I:=4;PutErr;
 __ShowMousePtr;
 DialTimer:=Ya;
End;

Procedure MakeMnu;Begin
 PMInit;
 PMSetWinBar(0,1,MaxXTxts);
 PMAddMnu('^F^ichier');
  PMAddItemKey('^N^ouveau',kbNoKey,bpNew,'CrÇe un nouveau programme BASIC');
  PMAddItemKey('^O^uvre',kbF3,bpOpen,'Ouvre un programme BASIC dÇjÖ existant ou en crÇe un s''il n''existe pas encore');
  PMAddItemKey('^S^auve',kbF2,bpSave,'Sauvegarde le programme sous son nom courant');
  PMAddItemKey('Sauve sous',kbNoKey,bpSaveAs,'Sauvegarde le programme sous un nom particulier');
  PMAddItemKey('^Q^uitter',kbAltX,bpExit,'Quitter le programme');
 PMAddMnu('^C^ommande');
  PMAddItemKey('E^x^Çcution',kbCtrlF9,bpRun,'ExÇcute le programme BASIC courant');
  PMAddItemKey('^S^ortie',kbAltF5,bpOutput,'Voir la sortie Çcran...');
 PMAddMnu('F^e^nàtre');
  PMAddItemKey('^S^uivante',kbF6,bpNextWn,'Passe Ö la fenàtre suivante');
  PMAddItemKey('^P^rÇcÇdente',kbShiftF6,bpPreviousWn,'Passe Ö la fenàtre prÇcÇdente');
 PMAddMnu('^A^ide');
  PMAddItemKey('^A^ propos',kbNoKey,bpAbout,'Indique les informations concernant ce programme...');
 PMPutMnuBar;
End;

{$I Library\Joystick\Button.Inc}
{$I Library\OctWord2Str.Inc}

{⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ‹
 ≥                         Fonction PXtrkWord                       €
 ¿‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹€


 Description
 ÕÕÕÕÕÕÕÕÕÕÕ

  Cette fonction permet d'extraire une mot littÇraire d'une chaåne de
 caractäres de style ASCIIZ (langage de programmation C).
}

Procedure PXtrkWord(Var W:String);Near;Assembler;ASM
 LES DI,PC
 ADD DI,IT
 MOV CL,ES:[DI]
 AND CL,0DFh
 CMP CL,'A'
 JB  @Empty
 CMP CL,'Z'
 JA  @Empty
 INC Word Ptr IT
 MOV AH,ES:[DI]
 MOV AL,1
 LES DI,W
 STOSW
@1:LES DI,PC
 ADD DI,IT
 MOV CL,ES:[DI]
 AND CL,0DFh
 CMP CL,'A'
 JB  @Brk
 CMP CL,'Z'
 JA  @Brk
 LES BX,W
 CMP Byte Ptr ES:[BX],255
 JE  @Brk
 INC Byte Ptr ES:[BX]
 ADD BL,ES:[BX]
 ADC BH,0
 MOV ES:[BX],CL
 INC IT
 JMP @1
@Empty:
 XOR AL,AL
 LES DI,W
 STOSB
@Brk:
END;

Const EndData=0;
      DataInteger=1;
      DataLong=2;
      DataSingle=3;
      DataDouble=4;
      DataString=5;
      DataPChar=6;
      DataTLong=7;
      DataSize:Array[EndData..DataTLong]of Word=(
       0,SizeOf(Integer),SizeOf(Long),SizeOf(Single),
       SizeOf(Double),SizeOf(String),0,SizeOf(Pointer)+SizeOf(Word)
      );

Procedure PushVarInt(X:Integer;Var N:String);Near;Label 1;Var Jmp,J,L,Ofs:Word;Begin
 {Recherche d'une variable existante}
 J:=0;
 While Data[J]<>0do Begin
  L:=DataSize[Data[J]]+3;
  If Compare(Data[L+J],N,Length(N)+1)Then Begin
   ASM
    MOV BX,J
    ADD BX,3
    MOV Ofs,BX
   END;
   Goto 1;
  End;
  ASM
   MOV BX,J
   INC BX
   MOV AX,Word Ptr Data[BX]
   MOV J,AX
  END;
 End;
 {Affectation}
 If CurData+Length(N)+6>SizeOf(Data)Then Exit;
 Data[CurData]:=DataInteger;Inc(CurData);Jmp:=CurData+2+SizeOf(Integer)+Length(N)+1;
 ASM
   {Fixe le Jump}
  MOV AX,Jmp
  MOV BX,CurData
  MOV Word Ptr Data[BX],AX
  ADD CurData,TYPE Integer
 END;
 Ofs:=CurData;Inc(CurData,SizeOf(Integer));
 MoveLeft(N,Data[CurData],Length(N)+1);
 Inc(CurData,Length(N)+1);
1:
 ASM
   { Copie les donnÇes }
  MOV AX,X
  MOV BX,Ofs
  MOV Word Ptr Data[BX],AX
 END;
End;

Procedure PushVarLong(X:Long;Var N:String);Near;Label 1;Var Jmp,J,L,Ofs:Word;Begin
 {Recherche d'une variable existante}
 J:=0;
 While Data[J]<>0do Begin
  L:=DataSize[Data[J]]+3;
  If Compare(Data[L+J],N,Length(N)+1)Then Begin
   ASM
    MOV BX,J
    ADD BX,3
    MOV Ofs,BX
   END;
   Goto 1;
  End;
  ASM
   MOV BX,J
   INC BX
   MOV AX,Word Ptr Data[BX]
   MOV J,AX
  END;
 End;
 {Affectation}
 If CurData+Length(N)+8>SizeOf(Data)Then Exit;
 Data[CurData]:=DataLong;Inc(CurData);Jmp:=CurData+2+SizeOf(Long)+Length(N)+1;
 ASM
   {Fixe le Jump}
  MOV AX,Jmp
  MOV BX,CurData
  MOV Word Ptr Data[BX],AX
  ADD CurData,TYPE Integer
 END;
 Ofs:=CurData;Inc(CurData,SizeOf(LongInt));
 MoveLeft(N,Data[CurData],Length(N)+1);
 Inc(CurData,Length(N)+1);
1:
 ASM
   { Copie les donnÇes }
  LES AX,X
  MOV BX,Ofs
  MOV Word Ptr Data[BX],AX
  MOV Word Ptr Data[BX+2],ES
 END;
End;

Procedure PushVarSingle(X:Single;Var N:String);Near;Label 1;Var Jmp,J,L,Ofs:Word;Begin
 {Recherche d'une variable existante}
 J:=0;
 While Data[J]<>0do Begin
  L:=DataSize[Data[J]]+3;
  If Compare(Data[L+J],N,Length(N)+1)Then Begin
   ASM
    MOV BX,J
    ADD BX,3
    MOV Ofs,BX
   END;
   Goto 1;
  End;
  ASM
   MOV BX,J
   INC BX
   MOV AX,Word Ptr Data[BX]
   MOV J,AX
  END;
 End;
 {Affectation}
 If CurData+Length(N)+8>SizeOf(Data)Then Exit;
 Data[CurData]:=DataSingle;Inc(CurData);Jmp:=CurData+2+SizeOf(Single)+Length(N)+1;
 ASM
   {Fixe le Jump}
  MOV AX,Jmp
  MOV BX,CurData
  MOV Word Ptr Data[BX],AX
  ADD CurData,TYPE Integer
 END;
 Ofs:=CurData;Inc(CurData,SizeOf(Single));
 MoveLeft(N,Data[CurData],Length(N)+1);
 Inc(CurData,Length(N)+1);
1:
 ASM
   { Copie les donnÇes }
  LES AX,X
  MOV BX,Ofs
  MOV Word Ptr Data[BX],AX
  MOV Word Ptr Data[BX+2],ES
 END;
End;

Procedure PushVarDouble(X:Double;Var N:String);Near;Label 1;Var Jmp,J,L,Ofs:Word;Begin
 {Recherche d'une variable existante}
 J:=0;
 While Data[J]<>0do Begin
  L:=DataSize[Data[J]]+3;
  If Compare(Data[L+J],N,Length(N)+1)Then Begin
   ASM
    MOV BX,J
    ADD BX,3
    MOV Ofs,BX
   END;
   Goto 1;
  End;
  ASM
   MOV BX,J
   INC BX
   MOV AX,Word Ptr Data[BX]
   MOV J,AX
  END;
 End;
 {Affectation}
 If CurData+Length(N)+12>SizeOf(Data)Then Exit;
 Data[CurData]:=DataDouble;Inc(CurData);Jmp:=CurData+2+SizeOf(Double)+Length(N)+1;
 ASM
   {Fixe le Jump}
  MOV AX,Jmp
  MOV BX,CurData
  MOV Word Ptr Data[BX],AX
  ADD CurData,TYPE Integer
 END;
 Ofs:=CurData;Inc(CurData,SizeOf(Double));
 MoveLeft(N,Data[CurData],Length(N)+1);
 Inc(CurData,Length(N)+1);
1:
 ASM
   { Copie les donnÇes }
  LES AX,DWord Ptr X
  MOV BX,Ofs
  MOV Word Ptr Data[BX],AX
  MOV Word Ptr Data[BX+2],ES
  LES AX,DWord Ptr X[4]
  MOV Word Ptr Data[BX+4],AX
  MOV Word Ptr Data[BX+6],ES
 END;
End;

Procedure PushVarString(Var X,N:String);Near;Label 1;Var Jmp,J,L,Ofs:Word;Begin
 {Recherche d'une variable existante}
 J:=0;
 While Data[J]<>0do Begin
  L:=DataSize[Data[J]]+3;
  If Compare(Data[L+J],N,Length(N)+1)Then Begin
   ASM
    MOV BX,J
    ADD BX,3
    MOV Ofs,BX
   END;
   Goto 1;
  End;
  ASM
   MOV BX,J
   INC BX
   MOV AX,Word Ptr Data[BX]
   MOV J,AX
  END;
 End;
 {Affectation}
 If CurData+Length(N)+4+SizeOf(String)>SizeOf(Data)Then Exit;
 Data[CurData]:=DataString;Inc(CurData);Jmp:=CurData+2+SizeOf(String)+Length(N)+1;
 ASM
   {Fixe le Jump}
  MOV AX,Jmp
  MOV BX,CurData
  MOV Word Ptr Data[BX],AX
  ADD CurData,TYPE Integer
 END;
 Ofs:=CurData;Inc(CurData,SizeOf(String));
 MoveLeft(N,Data[CurData],Length(N)+1);
 Inc(CurData,Length(N)+1);
1:
 MoveLeft(X,Data[Ofs],SizeOf(String));
End;

Function PushVarStr2PChr(Var X:String):PChar;Near;Var Jmp:Word;P:PChr;Begin
 If CurData+Length(X)+4>SizeOf(Data)Then Exit;
 Data[CurData]:=DataPChar;Inc(CurData);Jmp:=CurData+2+Length(X)+1;
 ASM
   {Fixe le Jump}
  MOV AX,Jmp
  MOV BX,CurData
  MOV Word Ptr Data[BX],AX
  ADD CurData,TYPE Integer
 END;
 P:=@Data[CurData];
 StrPCopy(P,X);Inc(CurData,Length(X)+1);
 PushVarStr2PChr:=PChar(P);
End;

Function ReadVarInt(Var N:String):Integer;Near;Var L,J:Wd;Begin
 J:=0;
 While Data[J]<>0do Begin
  L:=DataSize[Data[J]]+3;
  If Compare(Data[L+J],N,Length(N)+1)Then Begin
   ASM
    MOV BX,J
    ADD BX,3
    MOV AX,Word Ptr Data[BX]
    MOV @Result,AX
   END;
   Exit;
  End;
  ASM
   MOV BX,J
   INC BX
   MOV AX,Word Ptr Data[BX]
   MOV J,AX
  END;
 End;
 ReadVarInt:=0;
End;

Function ReadVarLong(Var N:String):Long;Near;Var L,J:Wd;Begin
 J:=0;
 While Data[J]<>0do Begin
  L:=DataSize[Data[J]]+3;
  If Compare(Data[L+J],N,Length(N)+1)Then Begin
   ASM
    MOV BX,J
    ADD BX,3
    LES AX,DWord Ptr Data[BX]
    MOV Word Ptr @Result,AX
    MOV Word Ptr @Result[2],ES
   END;
   Exit;
  End;
  ASM
   MOV BX,J
   INC BX
   MOV AX,Word Ptr Data[BX]
   MOV J,AX
  END;
 End;
 ReadVarLong:=0;
End;

Function ReadVarSingle(Var N:String):Single;Near;Var L,J:Wd;Begin
 J:=0;
 While Data[J]<>0do Begin
  L:=DataSize[Data[J]]+3;
  If Compare(Data[L+J],N,Length(N)+1)Then Begin
   ASM
    MOV BX,J
    ADD BX,3
    LES AX,DWord Ptr Data[BX]
    MOV Word Ptr @Result,AX
    MOV Word Ptr @Result[2],ES
   END;
   Exit;
  End;
  ASM
   MOV BX,J
   INC BX
   MOV AX,Word Ptr Data[BX]
   MOV J,AX
  END;
 End;
 ReadVarSingle:=0.0;
End;

Function ReadVarDouble(Var N:String):Double;Near;Var L,J:Wd;Begin
 J:=0;
 While Data[J]<>0do Begin
  L:=DataSize[Data[J]]+3;
  If Compare(Data[L+J],N,Length(N)+1)Then Begin
   ASM
    MOV BX,J
    ADD BX,3
    LES AX,DWord Ptr Data[BX]
    MOV Word Ptr @Result,AX
    MOV Word Ptr @Result[2],ES
    LES AX,DWord Ptr Data[BX+4]
    MOV Word Ptr @Result[4],AX
    MOV Word Ptr @Result[6],ES
   END;
   Exit;
  End;
  ASM
   MOV BX,J
   INC BX
   MOV AX,Word Ptr Data[BX]
   MOV J,AX
  END;
 End;
 ReadVarDouble:=0.0;
End;

Function ReadVarString(Var N:String):String;Near;Var L,J:Wd;P:Pointer;Begin
 J:=0;
 While Data[J]<>0do Begin
  L:=DataSize[Data[J]]+3;
  If Compare(Data[L+J],N,Length(N)+1)Then Begin
   ASM
    LES DI,@Result
    MOV Word Ptr P,DI
    MOV Word Ptr P[2],ES
   END;
   MoveLeft(Data[J+3],P^,SizeOf(String));
   Exit;
  End;
  ASM
   MOV BX,J
   INC BX
   MOV AX,Word Ptr Data[BX]
   MOV J,AX
  END;
 End;
 ReadVarString:='';
End;

Function PushVarTLong(Var N:String;T:Wd):Bool;Near;Var Jmp,J,L,Ofs:Wd;P:Pointer;Begin
 {Recherche d'une variable existante}
 J:=0;PushVarTLong:=No;
 While Data[J]<>0do Begin
  L:=DataSize[Data[J]]+3;
  If Compare(Data[L+J],N,Length(N)+1)Then Begin;RunXit:=VarDupl;Exit;End;
  ASM
   MOV BX,J
   INC BX
   MOV AX,Word Ptr Data[BX]
   MOV J,AX
  END;
 End;
 {Affectation}
 If CurData+Length(N)+8>SizeOf(Data)Then Begin;RunXit:=OutOfMemory;Exit;End;
 P:=MemNew(T shl 2);
 If(P=NIL)Then Begin;RunXit:=OutOfMemory;Exit;End;
 Data[CurData]:=DataTLong;Inc(CurData);Jmp:=CurData+2+(SizeOf(Pointer)+2)+Length(N)+1;
 ASM
   {Fixe le Jump}
  MOV AX,Jmp
  MOV BX,CurData
  MOV Word Ptr Data[BX],AX
  ADD CurData,TYPE Integer
 END;
 Ofs:=CurData;Inc(CurData,SizeOf(Pointer)+2);
 MoveLeft(N,Data[CurData],Length(N)+1);
 Inc(CurData,Length(N)+1);
 ASM
   { Copie les donnÇes }
  LES AX,P
  MOV BX,Ofs
  MOV Word Ptr Data[BX],AX
  MOV Word Ptr Data[BX+2],ES
  MOV AX,T
  MOV Word Ptr Data[BX+4],AX
 END;
 PushVarTLong:=Ya;
End;

Function AddrTLong(Var N:String;Var Size:Wd):Pointer;Near;Var L,J:Wd;Begin
 J:=0;
 While Data[J]<>0do Begin
  L:=DataSize[Data[J]]+3;
  If(Data[J]=DataTLong)and(Compare(Data[L+J],N,Length(N)+1))Then Begin
   ASM
    MOV BX,J
    ADD BX,3
    LES AX,DWord Ptr Data[BX]
    MOV Word Ptr @Result,AX
    MOV Word Ptr @Result[2],ES
    MOV AX,Word Ptr Data[BX+4]
    LES DI,Size
    STOSW
   END;
   Exit;
  End;
  ASM
   MOV BX,J
   INC BX
   MOV AX,Word Ptr Data[BX]
   MOV J,AX
  END;
 End;
 AddrTLong:=NIL;
End;

Procedure NewMem;Var T,Jmp,J,Ofs:Wd;P:Pointer;Begin
 {Recherche d'une variable existante}
 J:=0;
 While Data[J]<>0do Begin
  Case Data[J]of
   DataTLong:Begin
    Ofs:=J+3;
    ASM
     {Copie les donnÇes}
     MOV BX,Ofs
     LES AX,DWord Ptr Data[BX]
     MOV Word Ptr P,AX
     MOV Word Ptr P[2],ES
     MOV AX,Word Ptr Data[BX+4]
     MOV T,AX
    END;
    FreeMem(P,T shl 2);
   End;
  End;
  ASM
   MOV BX,J
   INC BX
   MOV AX,Word Ptr Data[BX]
   MOV J,AX
  END;
 End;
End;

Function OfsVar(Var N:String):Word;Near;Var L,J:Wd;P:Pointer;Begin
 J:=0;
 While Data[J]<>0do Begin
  L:=DataSize[Data[J]]+3;
  If Compare(Data[L+J],N,Length(N)+1)Then Begin;OfsVar:=J+3;Exit;End;
  ASM
   MOV BX,J
   INC BX
   MOV AX,Word Ptr Data[BX]
   MOV J,AX
  END;
 End;
 OfsVar:=$FFFF;
End;

Procedure SkipSpc;Near;Assembler;ASM {While PC^[IT]in[#9,' ']do Inc(IT);}
 LES DI,PC
 MOV BX,IT
 DEC BX
@1:
 INC BX
 CMP Byte Ptr ES:[DI+BX],9
 JE  @1
 CMP Byte Ptr ES:[DI+BX],' '
 JE  @1
 MOV IT,BX
END;

Function _Str2S(Var S:String):Boolean;Near;Forward;

Function Nm(Var Xt:NmType):Bool;Near;Label _A,_B,_C,_D,_E,_F,_G,_H,_I,_J,_K,_L,_M,_N,
_O,_P,_Q,_R,_S,_T,_U,_V,_W,_X,_Y,_Z,1,VarCheck;
Var S,S2:String;A,B,C,R:NmType;Z:Long;PC2:Pointer Absolute Z;Ok:Bool;Chr:Char;Begin
 Nm:=No;Xt.Format:=DataInteger;Xt.Int:=0;Chr:=#0;RunXit:=0;
 If PC^[IT]='-'Then Begin;Chr:='-';Inc(IT)End;
 Repeat
  SkipSpc;
  S:='';
  While PC^[IT]in['0'..'9']do Begin;IncStr(S,PC^[IT]);Inc(IT)End;
  If S=''Then Case PC^[IT]of
   '(':Begin
    Inc(IT);
    If Not Nm(R)Then Exit;
    SkipSpc;
    If PC^[IT]<>')'Then Begin;RunXit:=CloseParExpected;Exit;End;
    Inc(IT)
   End;
   '&':Begin
    Inc(IT);
    Case Char(Byte(PC^[IT])and$DF)of
     'B':Begin
      Inc(IT);S:='';
      While PC^[IT]in['0'..'9','A'..'F','a'..'f']do Begin;IncStr(S,PC^[IT]);Inc(IT)End;
      R.Format:=DataInteger;R.Int:=BinStr2Nm(S);
     End;
     'H':Begin
      Inc(IT);S:='';
      While PC^[IT]in['0'..'9','A'..'F','a'..'f']do Begin;IncStr(S,PC^[IT]);Inc(IT)End;
      R.Format:=DataInteger;R.Int:=HexStr2Nm(S)
     End;
     'O':Begin
      Inc(IT);S:='';
      While PC^[IT]in['0'..'7']do Begin;IncStr(S,PC^[IT]);Inc(IT)End;
      R.Format:=DataInteger;R.Int:=OctStr2Nm(S)
     End;
    End;
   End;
   Else Begin
    PXtrkWord(S);
    If S=''Then Break;
    ASM
     XOR AX,AX
     SUB AX,BP
     MOV DI,Offset S
     SUB DI,AX
     INC DI
     MOV BL,SS:[DI]
     AND BX,001Fh
     SHL BX,1
     JMP Word Ptr @Label[BX]
@Label:
     DW 0
     DW Offset _A
     DW Offset _B
     DW Offset _C
     DW Offset _D
     DW Offset _E
     DW Offset _F
     DW Offset _G
     DW Offset _H
     DW Offset _I
     DW Offset _J
     DW Offset _K
     DW Offset _L
     DW Offset _M
     DW Offset _N
     DW Offset _O
     DW Offset _P
     DW Offset _Q
     DW Offset _R
     DW Offset _S
     DW Offset _T
     DW Offset _U
     DW Offset _V
     DW Offset _W
     DW Offset _X
     DW Offset _Y
     DW Offset _Z
    END;
_A: If S='ABS'Then Begin
     SkipSpc;
     If PC^[IT]<>'('Then Begin;RunXit:=OpenParExpected;Exit;End;
     Inc(IT);
     If Not Nm(A)Then Exit;
     R.Int:=Abs(A.Int);
     If PC^[IT]<>')'Then Begin;RunXit:=CloseParExpected;Exit;End;
     Inc(IT);
     Goto 1;
    End;
    If S='ALTPRESS'Then Begin;R.Format:=DataInteger;R.Int:=Byte(AltPress);Goto 1;End;
    If S='ASC'Then Begin
     SkipSpc;
     If PC^[IT]<>'('Then Begin;RunXit:=OpenParExpected;Exit;End;
     Inc(IT);
     If Not _Str2S(S)Then Exit;
     R.Format:=DataInteger;R.Int:=Byte(StrI(1,S));
     If PC^[IT]<>')'Then Begin;RunXit:=CloseParExpected;Exit;End;
     Inc(IT);Goto 1;
    End;
    Goto VarCheck;
_B: If S='BUS'Then Begin;R.Format:=DataInteger;R.Int:=Bus;Goto 1;End;
    If S='BUTTON'Then Begin
     SkipSpc;
     If PC^[IT]<>'('Then Begin;RunXit:=OpenParExpected;Exit;End;
     Inc(IT);
     If Not Nm(A)Then Exit;
     R.Format:=DataInteger;R.Int:=Byte(Button(A.Int));
     If PC^[IT]<>')'Then Begin;RunXit:=CloseParExpected;Exit;End;
     Inc(IT);Goto 1;
    End;
    Goto VarCheck;
_C: If S='CAPSLOCK'Then Begin;R.Format:=DataInteger;R.Int:=Byte(GetCapsLck);Goto 1;End;
    If S='CMOS'Then Begin;R.Format:=DataInteger;R.Int:=CtrlCmos;Goto 1;End;
    If S='CMOSEXIST'Then Begin;R.Format:=DataInteger;R.Int:=Byte(CmosExist);Goto 1;End;
    If S='CMOSPORT'Then Begin;R.Format:=DataInteger;R.Int:=CmosPort;Goto 1;End;
    If S='CODEPAGE'Then Begin;R.Format:=DataInteger;R.int:=CodePage;Goto 1;End;
    If S='COLOR'Then Begin
     R.Format:=DataInteger;
     If(IsKr)Then R.Int:=Byte(GetNmColors)Else R.Int:=0;
     Goto 1;
    End;
    If S='COMPUTERNAME'Then Begin;R.Format:=DataInteger;R.Int:=ComputerName;Goto 1;End;
    If S='COUNTRY'Then Begin;R.Format:=DataInteger;R.Int:=CountryCode;Goto 1;End;
    If S='CURRDISK'Then Begin;R.Format:=DataInteger;R.Int:=GetDsk;Goto 1;End;
    If S='COS'Then Begin
     R.Format:=DataSingle;
     SkipSpc;
     If PC^[IT]<>'('Then Begin;RunXit:=OpenParExpected;Exit;End;
     Inc(IT);
     If Not Nm(A)Then Exit;
     Case(A.Format)of
      DataInteger:R.Single:=Cos(A.Int);
      DataLong:R.Single:=Cos(A.Long);
      DataSingle:R.Single:=Cos(A.Single);
      Else Begin;R.Format:=DataDouble;R.Double:=Cos(A.Double)End;
     End;
     If PC^[IT]<>')'Then Begin;RunXit:=CloseParExpected;Exit;End;
     Inc(IT);Goto 1;
     Goto 1;
    End;
    If S='CPU'Then Begin;R.Format:=DataInteger;R.Int:=CPU;Goto 1;End;
    If S='CSRLIN'Then Begin;R.Format:=DataInteger;R.Int:=GetYTxtsPos;Goto 1;End;
    If S='CTRLPRESS'Then Begin;R.Format:=DataInteger;R.Int:=Byte(CtrlPress);Goto 1;End;
    Goto VarCheck;
_D: If S='DATE'Then Begin;R.Format:=DataInteger;R.Int:=Date;Goto 1;End;
    If S='DIGITS'Then Begin;R.Format:=DataInteger;R.Int:=Digits;Goto 1;End;
    If S='DIREXIST'Then Begin
     If Not _Str2S(S)Then Exit;
     R.Format:=DataInteger;R.Int:=Byte(DirExist(S));
     Goto 1;
    End;
    If S='DOSVER'Then Begin;R.Format:=DataInteger;R.Int:=GetDosVer;Goto 1;End;
    Goto VarCheck;
_E: If S='EMSEXIST'Then Begin;R.Format:=DataInteger;R.Int:=Byte(EmmExist);Goto 1;End;
    If S='EMMNUMBERPAGE'Then Begin;R.Format:=DataInteger;R.Int:=EmmNumPage;Goto 1;End;
    If S='EMSSEG'Then Begin;R.Format:=DataInteger;R.Int:=EmmSeg;Goto 1;End;
    If S='EMSSIZE'Then Begin;R.Format:=DataInteger;R.Int:=EmmTotalSize;Goto 1;End;
    If S='EXTSIZE'Then Begin;R.Format:=DataInteger;R.Int:=ExtBiosSizeK;Goto 1;End;
    Goto VarCheck;
_F: If S='FILEEXIST'Then Begin
     If Not _Str2S(S)Then Exit;
     R.Format:=DataInteger;R.Int:=Byte(FileExist(S));
     Goto 1;
    End;
    If S='FLOPPY'Then Begin;R.Format:=DataInteger;R.Int:=NmFloppyDsk;Goto 1;End;
    If S='FRE'Then Begin;R.Format:=DataLong;R.Long:=SizeOf(Data)-CurData;Goto 1;End;
    Goto VarCheck;
_G: If S='GRAF'Then Begin;R.Format:=DataInteger;R.Int:=Byte(IsGraf);Goto 1;End;
    Goto VarCheck;
_H: If S='HARDDISK'Then Begin;R.Format:=DataInteger;R.Int:=NmHardDsk;Goto 1;End;
    If S='HEIGHTCHR'Then Begin;R.Format:=DataInteger;R.Int:=HeightChr;Goto 1;End;
    Goto VarCheck;
_I: If S='INP'Then Begin
     SkipSpc;
     If PC^[IT]<>'('Then Begin;RunXit:=OpenParExpected;Exit;End;
     Inc(IT);
     If Not Nm(A)Then Exit;
     R.Format:=DataInteger;R.Int:=Port[A.Int];
     If PC^[IT]<>')'Then Begin;RunXit:=CloseParExpected;Exit;End;
     Inc(IT);Goto 1;
    End;
    If S='INSERT'Then Begin;R.Format:=DataInteger;R.Int:=Byte(GetModeIns);Goto 1;End;
    If S='INSTR'Then Begin
     SkipSpc;
     If PC^[IT]<>'('Then Begin;RunXit:=OpenParExpected;Exit;End;
     Inc(IT);
     If Not _Str2S(S)Then Exit;
     If PC^[IT]<>','Then Begin;RunXit:=VirguleExpected;Exit;End;
     Inc(IT);
     If Not _Str2S(S2)Then Exit;
     If PC^[IT]<>')'Then Begin;RunXit:=CloseParExpected;Exit;End;
     Inc(IT);R.Format:=DataInteger;R.Int:=Pos(S2,S);
     Goto 1;
    End;
    If S='INSTAT'Then Begin
     R.Format:=DataInteger;
     If(KeyPress)Then R.Int:=-1 Else R.Int:=0;
     Goto 1;
    End;
    If S='INTERRUPT'Then Begin
     SkipSpc;
     If PC^[IT]<>'('Then Begin;RunXit:=OpenParExpected;Exit;End;
     Inc(IT);
     If Not Nm(A)Then Exit;
     If A.Format in[DataInteger,DataLong]Then Begin;RunXit:=TypeMistmatch;Exit;End;
     GetIntVec(A.Int,Pointer(PC2));
     R.Format:=DataLong;R.Long:=Long(PC2);
     If PC^[IT]<>')'Then Begin;RunXit:=CloseParExpected;Exit;End;
     Inc(IT);Goto 1;
    End;
    Goto VarCheck;
_J: If S='JOYBIOS'Then Begin;R.Format:=DataInteger;R.Int:=Byte(BiosJoy);Goto 1;End;
    If S='JOYEXIST'Then Begin;R.Format:=DataInteger;R.Int:=Byte(JoyExist);Goto 1;End;
    If S='JOYPORT'Then Begin;R.Format:=DataInteger;R.Int:=JoyPort;Goto 1;End;
    Goto VarCheck;
_K: If S='KBDCTRL'Then Begin;R.Format:=DataInteger;R.Int:=KbdCtrl;Goto 1;End;
    If S='KBDMODEL'Then Begin;R.Format:=DataInteger;R.Int:=KbdModel;Goto 1;End;
    If S='KBDREADPORT'Then Begin;R.Format:=DataInteger;R.Int:=KbdReadPort;Goto 1;End;
    If S='KEYPRESS'Then Begin
     Ok:=KeyPress;
     R.Format:=DataInteger;R.Int:=Byte(Ok);
     Goto 1;
    End;
    Goto VarCheck;
_L: If S='LEN'Then Begin
     SkipSpc;
     If PC^[IT]<>'('Then Begin;RunXit:=OpenParExpected;Exit;End;
     Inc(IT);
     If Not _Str2S(S)Then Exit;
     R.Format:=DataInteger;R.Int:=Length(S);
     If PC^[IT]<>')'Then Begin;RunXit:=CloseParExpected;Exit;End;
     Inc(IT);Goto 1;
    End;
    If S='LPT'Then Begin;R.Format:=DataInteger;R.Int:=NmLPT;Goto 1;End;
    Goto VarCheck;
_M: If S='MONITOR'Then Begin;R.Format:=DataInteger;R.Int:=GetVideoMonitor;Goto 1;End;
    If S='MONO'Then Begin;R.Format:=DataInteger;R.Int:=Byte(IsMono);Goto 1;End;
    If S='MOUSE'Then Begin;R.Format:=DataInteger;R.Int:={$IFDEF Adele}Adele{$ELSE}Chantal{$ENDIF}.Mouse;Goto 1;End;
    If S='MSBUTTON'Then Begin;R.Format:=DataInteger;R.Int:=MsButton;Goto 1;End;
    If S='MSVER'Then Begin;R.Format:=DataInteger;R.Int:=MouseVer;Goto 1;End;
    Goto VarCheck;
_N: If S='NEXTKEY'Then Begin;R.Format:=DataInteger;R.Int:=NxtKey;Goto 1;End;
    If S='NUMLOCK'Then Begin;R.Format:=DataInteger;R.Int:=Byte(GetNmLck);Goto 1;End;
    If S='NUMXTEXTS'Then Begin;R.Format:=DataInteger;R.Int:=NmXTxts;Goto 1;End;
    If S='NUMYTEXTS'Then Begin;R.Format:=DataInteger;R.Int:=NmYTxts;Goto 1;End;
    Goto VarCheck;
_O: Goto VarCheck;
_P: If S='POINT'Then Begin
     SkipSpc;
     If PC^[IT]<>'('Then Begin;RunXit:=OpenParExpected;Exit;End;
     Inc(IT);
     If Not Nm(A)Then Exit;
     R.Format:=DataInteger;
     If PC^[IT]=','Then Begin
      Inc(IT);
      If Not Nm(B)Then Exit;
      R.Int:=GetPixel(A.Int,B.Int);
     End
      Else
     Case Wd(A.Int)of
      0,2:R.Int:=VidBnkSwitch.XL;
      1,3:R.Int:=VidBnkSwitch.YL;
     End;
     If PC^[IT]<>')'Then Begin;RunXit:=CloseParExpected;Exit;End;
     Inc(IT);Goto 1;
    End;
    Goto VarCheck;
_Q: Goto VarCheck;
_R: If S='RAMCONV'Then Begin;R.Format:=DataInteger;R.Int:=MemTotalSize;Goto 1;End;
    If S='RAWTIMER'Then Begin;R.Format:=DataInteger;R.Int:=GetRawTimer;Goto 1;End;
    If S='READKEY'Then Begin;R.Format:=DataInteger;R.Int:=PMWaitForMnuAction;Goto 1;End;
    If S='REG'Then Begin
     SkipSpc;
     If PC^[IT]<>'('Then Begin;RunXit:=OpenParExpected;Exit;End;
     Inc(IT);
     If Not Nm(A)Then Exit;
     R.Format:=DataInteger;
     Case(A.Int)of
      0:R.Int:=Regs.Flags;
      1:R.Int:=Regs.AX;
      2:R.Int:=Regs.BX;
      3:R.Int:=Regs.CX;
      4:R.Int:=Regs.DX;
      5:R.Int:=Regs.SI;
      6:R.Int:=Regs.DI;
      7:R.Int:=Regs.BP;
      8:R.Int:=Regs.DS;
      9:R.Int:=Regs.ES;
      Else Begin;RunXit:=InvalidFunctionCall;Exit;End;
     End;
     If PC^[IT]<>')'Then Begin;RunXit:=CloseParExpected;Exit;End;
     Inc(IT);Goto 1;
    End;
    Goto VarCheck;
_S: If S='SCREEN'Then Begin
     SkipSpc;
     If PC^[IT]<>'('Then Begin;RunXit:=OpenParExpected;Exit;End;
     Inc(IT);
     If Not Nm(A)Then Exit;
     If PC^[IT]<>','Then Begin;RunXit:=VirguleExpected;Exit;End;
     Inc(IT);
     If Not Nm(B)Then Exit;
     R.Format:=DataInteger;
     If PC^[IT]=','Then Begin
      Inc(IT);
      If Not Nm(C)Then Exit;
      If C.Int<>0Then R.Int:=GetAttr(A.Int,B.Int)Else R.Int:=Byte(GetChr(A.Int,B.Int));
     End
      Else
     R.Int:=Byte(GetChr(A.Int,B.Int));
     If PC^[IT]<>')'Then Begin;RunXit:=CloseParExpected;Exit;End;
     Inc(IT);Goto 1;
    End;
    If S='SCROLLLOCK'Then Begin;R.Format:=DataInteger;R.Int:=Byte(GetScrollLck);Goto 1;End;
    IF S='SERIAL'Then Begin;R.Format:=DataInteger;R.Int:=NmSerial;Goto 1;End;
    If S='SHIFTPRESS'Then Begin;R.Format:=DataInteger;R.Int:=Byte(ShiftPress);Goto 1;End;
    If S='SIN'Then Begin
     R.Format:=DataSingle;
     SkipSpc;
     If PC^[IT]<>'('Then Begin;RunXit:=OpenParExpected;Exit;End;
     Inc(IT);
     If Not Nm(A)Then Exit;
     Case(A.Format)of
      DataInteger:R.Single:=Sin(A.Int);
      DataLong:R.Single:=Sin(A.Long);
      DataSingle:R.Single:=Sin(A.Single);
      Else Begin;R.Format:=DataDouble;R.Double:=Sin(A.Double)End;
     End;
     If PC^[IT]<>')'Then Begin;RunXit:=CloseParExpected;Exit;End;
     Inc(IT);Goto 1;
     Goto 1;
    End;
    If S='SOUNDMEM'Then Begin;R.Format:=DataInteger;R.Int:=SoundMem;Goto 1;End;
    If S='SPOOLER'Then Begin;R.Format:=DataInteger;R.Int:=Spooler;Goto 1;End;
    If S='SYSERR'Then Begin;R.Format:=DataInteger;R.Int:=SysErr;Goto 1;End;
    Goto VarCheck;
_T: If S='TAN'Then Begin
     R.Format:=DataSingle;
     SkipSpc;
     If PC^[IT]<>'('Then Begin;RunXit:=OpenParExpected;Exit;End;
     Inc(IT);
     If Not Nm(A)Then Exit;
     Case(A.Format)of
      DataInteger:R.Single:=Sin(A.Int)/Cos(A.Int);
      DataLong:R.Single:=Sin(A.Long)/Cos(A.Long);
      DataSingle:R.Single:=Sin(A.Single)/Cos(A.Single);
      Else Begin;R.Format:=DataDouble;R.Double:=Sin(A.Double)/Cos(A.Double)End;
     End;
     If PC^[IT]<>')'Then Begin;RunXit:=CloseParExpected;Exit;End;
     Inc(IT);Goto 1;
     Goto 1;
    End;
    If S='TIMER'Then Begin;R.Format:=DataLong;R.Long:=(GetRawTimer*901)shr 14;Goto 1;End;
    Goto VarCheck;
_U: Goto VarCheck;
_V: If S='VAL'Then Begin
     SkipSpc;
     If PC^[IT]='('Then Inc(IT);
     If Not _Str2S(S)Then Exit;
     SkipSpc;
     If PC^[IT]=')'Then Inc(IT);
     R.Long:=ValL(S);
     If R.IntHi<>0Then R.Format:=DataLong Else R.Format:=DataInteger;
     Goto 1;
    End;
    If S='VARPTR'Then Begin
     SkipSpc;
     If PC^[IT]='('Then Inc(IT);
     PXtrkWord(S);
     If PC^[IT]in['%','&','!','#','$']Then Begin;IncStr(S,PC^[IT]);Inc(IT)End;
     SkipSpc;
     If PC^[IT]=')'Then Inc(IT);
     R.Format:=DataInteger;R.Int:=OfsVar(S);Goto 1;
    End;
    If S='VIDEOCARD'Then Begin;R.Format:=DataInteger;R.Int:=GetVideoCard;Goto 1;End;
    If S='VARSEG'Then Begin
     If PC^[IT]='('Then Inc(IT);
     PXtrkWord(S);
     If PC^[IT]in['%','&','!','#','$']Then Begin;IncStr(S,PC^[IT]);Inc(IT)End;
     SkipSpc;
     If PC^[IT]=')'Then Inc(IT);
     R.Format:=DataInteger;R.Int:=DSeg;Goto 1;
    End;
    If S='VIDEOSTANDARD'Then Begin;R.Format:=DataInteger;R.Int:=GetVideoCardCat;Goto 1;End;
    Goto VarCheck;
_W: If S='WIDTH'Then Begin;R.Format:=DataInteger;R.Int:=GetNmXTxts;Goto 1;End;
    If S='WIDTHPIXEL'Then Begin;R.Format:=DataInteger;R.Int:=GetNmXPixels;Goto 1;End;
    Goto VarCheck;
_X: If S='XMSEXIST'Then Begin;R.Format:=DataInteger;R.Int:=Byte(XmsExist);Goto 1;End;
    If S='XMSSIZE'Then Begin;R.Format:=DataInteger;R.Int:=XmsTotalSize;Goto 1;End;
    Goto VarCheck;
_Y: Goto VarCheck;
_Z: Goto VarCheck;
    Begin
VarCheck:
     Case PC^[IT]of
      '%':Begin;Inc(IT);IncStr(S,'%');R.Format:=DataInteger;R.Int:=ReadVarInt(S)End;
      '&':Begin;Inc(IT);IncStr(S,'&');R.Format:=DataLong;R.Long:=ReadVarLong(S)End;
      '!':Begin;Inc(IT);IncStr(S,'!');R.Format:=DataSingle;R.Single:=Trunc(ReadVarSingle(S))End;
      '#':Begin;Inc(IT);IncStr(S,'#');R.Format:=DataDouble;R.Double:=Trunc(ReadVarDouble(S))End;
      '$':Begin;RunXit:=TypeMistmatch;Exit;End;
  '(','[':Begin
       Inc(IT);R.Format:=DataLong;
       If Not Nm(A)Then Exit;
       PC2:=AddrTLong(S,C.Word);
       If(PC2=NIL)Then Begin;RunXit:=VarNotFound;Exit;End;
       ASM
        LES DI,PC2
        MOV BX,A.Int
        {$IFOPT G+}SHL BX,2{$ELSE}SHL BX,1;SHL BX,1{$ENDIF}
        LES AX,ES:[DI+BX]
        MOV Word Ptr R.Long,AX
        MOV Word Ptr R.Long[2],ES
       END;
       If Not(PC^[IT]in[')',']'])Then Begin;RunXit:=CloseParExpected;Exit;End;
       Inc(IT);
      End;
     Else Begin;R.Format:=DataLong;R.Long:=ReadVarLong(S)End;
     End;
    End;
1:  While PC^[IT]in[#9,' ']do Inc(IT);
   End;
  End
   Else
  Begin
   SkipSpc;
   R.Format:=DataInteger;R.Int:=ValW(S)
  End;
  Word(Z):=IT;SkipSpc;PXtrkWord(S);
  If S='AND'Then Begin;B.Format:=Byte('Ô');Ok:=No;End
   Else
  Begin
   IT:=Word(Z);B.Format:=0;Ok:=Not(PC^[IT]in['+','-','*','/']);
  End;
  Case(Chr)of
   'Ô':Case(Xt.Format)of
    DataInteger:Case(R.Format)of
     DataInteger:Xt.Int:=Xt.Int and R.Int;
     DataLong:Begin;Xt.Format:=DataLong;Xt.IntHi:=0;Xt.Long:=Xt.Long and R.Long;End;
     Else Begin;RunXit:=TypeMistmatch;Exit;End;
    End;
    DataLong:Case(R.Format)of
     DataInteger:Xt.Long:=Xt.Long and R.Int;
     DataLong:Xt.Long:=Xt.Long and R.Long;
     Else Begin;RunXit:=TypeMistmatch;Exit;End;
    End;
    Else Begin;RunXit:=TypeMistmatch;Exit;End;
   End;
   '+':Begin
    If(Xt.Format or R.Format=DataInteger)Then Inc(Xt.Int,R.Int)
     Else
    Case(Xt.Format)of
     DataInteger:Case(R.Format)of
      DataLong:Begin;Xt.Format:=DataLong;Xt.Long:=Xt.Int+R.Long;End;
      DataSingle:Begin;Xt.Format:=DataSingle;Xt.Single:=Xt.Int+R.Single;End;
      Else Begin;Xt.Format:=DataDouble;Xt.Double:=Xt.Int+R.Double;End;
     End;
     DataLong:Case(R.Format)of
      DataInteger:Inc(Xt.Long,R.Int);
      DataLong:Inc(Xt.Long,R.Long);
      DataSingle:Begin;Xt.Format:=DataSingle;Xt.Single:=Xt.Long+R.Single;End;
      Else Begin;Xt.Format:=DataDouble;Xt.Double:=Xt.Long+R.Double;End;
     End;
     DataSingle:Case(R.Format)of
      DataInteger:Xt.Single:=Xt.Single+R.Int;
      DataLong:Xt.Single:=Xt.Single+R.Long;
      DataSingle:Xt.Single:=Xt.Single+R.Single;
      Else Begin;Xt.Format:=DataDouble;Xt.Double:=Xt.Double+R.Double;End;
     End;
     DataDouble:Case(R.Format)of
      DataInteger:Xt.Double:=Xt.Double+R.Int;
      DataLong:Xt.Double:=Xt.Double+R.Long;
      DataSingle:Xt.Double:=Xt.Double+R.Single;
      Else Xt.Double:=Xt.Double+R.Double;
     End;
    End;
   End;
   '-':Begin
    If(Xt.Format or R.Format=DataInteger)Then Dec(Xt.Int,R.Int)
     Else
    Case(Xt.Format)of
     DataInteger:Case(R.Format)of
      DataLong:Begin;Xt.Format:=DataLong;Xt.Long:=Xt.Int-R.Long;End;
      DataSingle:Begin;Xt.Format:=DataSingle;Xt.Single:=Xt.Int-R.Single;End;
      Else Begin;Xt.Format:=DataDouble;Xt.Double:=Xt.Int-R.Double;End;
     End;
     DataLong:Case(R.Format)of
      DataInteger:Dec(Xt.Long,R.Int);
      DataLong:Dec(Xt.Long,R.Long);
      DataSingle:Begin;Xt.Format:=DataSingle;Xt.Single:=Xt.Long-R.Single;End;
      Else Begin;Xt.Format:=DataDouble;Xt.Double:=Xt.Long-R.Double;End;
     End;
     DataSingle:Case(R.Format)of
      DataInteger:Xt.Single:=Xt.Single-R.Int;
      DataLong:Xt.Single:=Xt.Single-R.Long;
      DataSingle:Xt.Single:=Xt.Single-R.Single;
      Else Begin;Xt.Format:=DataDouble;Xt.Double:=Xt.Double-R.Double;End;
     End;
     DataDouble:Case(R.Format)of
      DataInteger:Xt.Double:=Xt.Double-R.Int;
      DataLong:Xt.Double:=Xt.Double-R.Long;
      DataSingle:Xt.Double:=Xt.Double-R.Single;
      Else Xt.Double:=Xt.Double-R.Double;
     End;
    End;
   End;
   '*':Begin
    If(Xt.Format or R.Format=DataInteger)Then Xt.Int:=Xt.Int*R.Int
     Else
    Case(Xt.Format)of
     DataInteger:Case(R.Format)of
      DataLong:Begin;Xt.Format:=DataLong;Xt.Long:=Xt.Int*R.Long;End;
      DataSingle:Begin;Xt.Format:=DataSingle;Xt.Single:=Xt.Int*R.Single;End;
      Else Begin;Xt.Format:=DataDouble;Xt.Double:=Xt.Int*R.Double;End;
     End;
     DataLong:Case(R.Format)of
      DataInteger:Xt.Long:=Xt.Long*R.Int;
      DataLong:Xt.Long:=Xt.Long*R.Long;
      DataSingle:Begin;Xt.Format:=DataSingle;Xt.Single:=Xt.Long*R.Single;End;
      Else Begin;Xt.Format:=DataDouble;Xt.Double:=Xt.Long*R.Double;End;
     End;
     DataSingle:Case(R.Format)of
      DataInteger:Xt.Single:=Xt.Single*R.Int;
      DataLong:Xt.Single:=Xt.Single*R.Long;
      DataSingle:Xt.Single:=Xt.Single*R.Single;
      Else Begin;Xt.Format:=DataDouble;Xt.Double:=Xt.Double*R.Double;End;
     End;
     DataDouble:Case(R.Format)of
      DataInteger:Xt.Double:=Xt.Double*R.Int;
      DataLong:Xt.Double:=Xt.Double*R.Long;
      DataSingle:Xt.Double:=Xt.Double*R.Single;
      Else Xt.Double:=Xt.Double*R.Double;
     End;
    End;
   End;
   '/':Begin
    If(Xt.Format or R.Format=DataInteger)Then Xt.Int:=Xt.Int div R.Int
     Else
    Case(Xt.Format)of
     DataInteger:Case(R.Format)of
      DataLong:Begin;Xt.Format:=DataLong;Xt.Long:=DivL(Xt.Int,R.Long);End;
      DataSingle:Begin;Xt.Format:=DataSingle;Xt.Single:=Xt.Int/R.Single;End;
      Else Begin;Xt.Format:=DataDouble;Xt.Double:=Xt.Int*R.Double;End;
     End;
     DataLong:Case(R.Format)of
      DataInteger:Xt.Long:=DivL(Xt.Long,R.Int);
      DataLong:Xt.Long:=DivL(Xt.Long,R.Long);
      DataSingle:Begin;Xt.Format:=DataSingle;Xt.Single:=Xt.Long/R.Single;End;
      Else Begin;Xt.Format:=DataDouble;Xt.Double:=Xt.Long/R.Double;End;
     End;
     DataSingle:Case(R.Format)of
      DataInteger:Xt.Single:=Xt.Single/R.Int;
      DataLong:Xt.Single:=Xt.Single/R.Long;
      DataSingle:Xt.Single:=Xt.Single/R.Single;
      Else Begin;Xt.Format:=DataDouble;Xt.Double:=Xt.Double/R.Double;End;
     End;
     DataDouble:Case(R.Format)of
      DataInteger:Xt.Double:=Xt.Double/R.Int;
      DataLong:Xt.Double:=Xt.Double/R.Long;
      DataSingle:Xt.Double:=Xt.Double/R.Single;
      Else Xt.Double:=Xt.Double/R.Double;
     End;
    End;
   End;
   Else Xt:=R;
  End;
  If Not(Ok)Then Begin
   If Char(B.Format)='Ô'Then Chr:='Ô'Else Begin;Chr:=PC^[IT];Inc(IT)End;
  End;
 Until Ok;
 Nm:=Ya;
End;

Function _Str2S(Var S:String):Boolean;Label 0,1,_A,_B,_C,_D,_E,_F,_G,_H,_I,_J,_K,
_L,_M,_N,_O,_P,_Q,_R,_S,_T,_U,_V,_W,_X,_Y,_Z,VarCheck;Var T,T2:NmType;OI:Int;ST:String;Begin
 _Str2S:=No;ST:='';
0:SkipSpc;
 If PC^[IT]='"'Then Begin
  Inc(IT);
  While Not(PC^[IT]in[#0,'"'])do Begin;IncStr(ST,PC^[IT]);Inc(IT)End;
  Inc(IT)
 End
  Else
 Begin
  OI:=IT;PXtrkWord(S);
  If(S<>'')and(PC^[IT]='$')Then Begin
   Inc(IT);IncStr(S,'$');
   ASM
    LES DI,S
    INC DI
    MOV BL,ES:[DI]
    AND BX,001Fh
    SHL BX,1
    JMP Word Ptr @Label[BX]
@Label:
    DW 0
    DW Offset _A
    DW Offset _B
    DW Offset _C
    DW Offset _D
    DW Offset _E
    DW Offset _F
    DW Offset _G
    DW Offset _H
    DW Offset _I
    DW Offset _J
    DW Offset _K
    DW Offset _L
    DW Offset _M
    DW Offset _N
    DW Offset _O
    DW Offset _P
    DW Offset _Q
    DW Offset _R
    DW Offset _S
    DW Offset _T
    DW Offset _U
    DW Offset _V
    DW Offset _W
    DW Offset _X
    DW Offset _Y
    DW Offset _Z
   END;
_A:Goto VarCheck;
_B:If S='BIN$'Then Begin
    If PC^[IT]<>'('Then Begin;IT:=OI;RunXit:=OpenParExpected;Exit;End;
    Inc(IT);
    If Not Nm(T)Then Exit;
    AddStr(ST,BinByte2Str(Lo(T.Int))+BinByte2Str(Hi(T.Int)));
    If PC^[IT]<>')'Then Begin;IT:=OI;RunXit:=CloseParExpected;Exit;End;
    Inc(IT);
    Goto 1;
   End;
   Goto VarCheck;
_C:If S='CHR$'Then Begin
    If PC^[IT]<>'('Then Begin;IT:=OI;RunXit:=OpenParExpected;Exit;End;
    Inc(IT);
    If Not Nm(T)Then Exit;
    IncStr(ST,Chr(T.Int));
    If PC^[IT]<>')'Then Begin;IT:=OI;RunXit:=CloseParExpected;Exit;End;
    Inc(IT);
    Goto 1;
   End;
   Goto VarCheck;
_D:Goto VarCheck;
_E:If S='ENVIRON$'Then Begin
    If PC^[IT]<>'('Then Begin;IT:=OI;RunXit:=OpenParExpected;Exit;End;
    Inc(IT);
    If Not _Str2S(S)Then Begin;IT:=OI;Exit;End;
    If PC^[IT]<>')'Then Begin;IT:=OI;RunXit:=CloseParExpected;Exit;End;
    AddStr(ST,GetEnv(S));Inc(IT);
    Goto 1;
   End;
_F:Goto VarCheck;
_G:Goto VarCheck;
_H:If S='HEX$'Then Begin
    If PC^[IT]<>'('Then Begin;IT:=OI;RunXit:=OpenParExpected;Exit;End;
    Inc(IT);
    If Not Nm(T)Then Exit;
    AddStr(ST,HexWord2Str(T.Int));
    If PC^[IT]<>')'Then Begin;IT:=OI;RunXit:=CloseParExpected;Exit;End;
    Inc(IT);
    Goto 1;
   End;
   Goto VarCheck;
_I:If S='INKEY$'Then Begin
    If InKeyB<>-1Then Begin;IncStr(ST,Chr(InKeyB));InKeyB:=-1;End Else
    If(KeyPress)Then Begin
     OI:=ReadKey;IncStr(ST,Chr(OI));
     If Lo(OI)=0Then InKeyB:=Hi(OI)Else InKeyB:=-1;
    End;
    Goto 1;
   End;
_J:Goto VarCheck;
_K:Goto VarCheck;
_L:If S='LEFT$'Then Begin
    If PC^[IT]<>'('Then Begin;IT:=OI;RunXit:=OpenParExpected;Exit;End;
    Inc(IT);
    If Not _Str2S(S)Then Begin;IT:=OI;Exit;End;
    If PC^[IT]<>','Then Begin;IT:=OI;RunXit:=VirguleExpected;Exit;End;
    Inc(IT);
    If Not Nm(T)Then Exit;
    If PC^[IT]<>')'Then Begin;IT:=OI;RunXit:=CloseParExpected;Exit;End;
    Inc(IT);
    AddStr(ST,Left(S,T.Int));
    Goto 1;
   End;
   Goto VarCheck;
_M:If S='MID$'Then Begin
    If PC^[IT]<>'('Then Begin;IT:=OI;RunXit:=OpenParExpected;Exit;End;
    Inc(IT);
    If Not _Str2S(S)Then Begin;IT:=OI;Exit;End;
    If PC^[IT]<>','Then Begin;IT:=OI;RunXit:=VirguleExpected;Exit;End;
    Inc(IT);
    If Not Nm(T)Then Exit;
    T2.Int:=255;
    If PC^[IT]=','Then Begin
     Inc(IT);
     If Not Nm(T2)Then Exit;
    End;
    If PC^[IT]<>')'Then Begin;IT:=OI;RunXit:=CloseParExpected;Exit;End;
    Inc(IT);
    AddStr(ST,Copy(S,T.Int,T2.Int));
    Goto 1;
   End;
   Goto VarCheck;
_N:Goto VarCheck;
_O:If S='OCT$'Then Begin
    If PC^[IT]<>'('Then Begin;IT:=OI;RunXit:=OpenParExpected;Exit;End;
    Inc(IT);
    If Not Nm(T)Then Exit;
    AddStr(ST,OctWord2Str(T.Int));
    If PC^[IT]<>')'Then Begin;IT:=OI;RunXit:=CloseParExpected;Exit;End;
    Inc(IT);
    Goto 1;
   End;
   Goto VarCheck;
_P:Goto VarCheck;
_Q:Goto VarCheck;
_R:If S='RIGHT$'Then Begin
    If PC^[IT]<>'('Then Begin;IT:=OI;RunXit:=OpenParExpected;Exit;End;
    Inc(IT);
    If Not _Str2S(S)Then Begin;IT:=OI;Exit;End;
    If PC^[IT]<>','Then Begin;IT:=OI;RunXit:=VirguleExpected;Exit;End;
    Inc(IT);
    If Not Nm(T)Then Exit;
    If PC^[IT]<>')'Then Begin;IT:=OI;RunXit:=CloseParExpected;Exit;End;
    Inc(IT);AddStr(ST,Copy(S,Length(S)-T.Int,T.Int));
    Goto 1;
   End;
   Goto VarCheck;
_S:If S='SPACE$'Then Begin
    If PC^[IT]<>'('Then Begin;IT:=OI;RunXit:=OpenParExpected;Exit;End;
    Inc(IT);
    If Not Nm(T)Then Exit;
    AddStr(ST,Spc(T.Int));
    If PC^[IT]<>')'Then Begin;IT:=OI;RunXit:=CloseParExpected;Exit;End;
    Inc(IT);Goto 1;
   End;
   If S='STR$'Then Begin
    If PC^[IT]<>'('Then Begin;IT:=OI;RunXit:=OpenParExpected;Exit;End;
    Inc(IT);
    If Not Nm(T)Then Exit;
    AddStr(ST,Str(T.Long));
    If PC^[IT]<>')'Then Begin;IT:=OI;RunXit:=CloseParExpected;Exit;End;
    Inc(IT);Goto 1;
   End;
   If S='STRING$'Then Begin
    If PC^[IT]<>'('Then Begin;IT:=OI;RunXit:=OpenParExpected;Exit;End;
    Inc(IT);
    If Not Nm(T)Then Exit;
    If PC^[IT]<>','Then Begin;IT:=OI;RunXit:=VirguleExpected;Exit;End;
    Inc(IT);
    If Not _Str2S(S)Then Begin
     If Not Nm(T2)Then Exit;
     S:=Chr(T2.Int);
    End;
    If PC^[IT]<>')'Then Begin;IT:=OI;RunXit:=CloseParExpected;Exit;End;
    Inc(IT);AddStr(ST,MultChr(S[1],T.Int));
    Goto 1;
   End;
   {Goto VarCheck;}
_T:{Goto VarCheck;}
_U:{Goto VarCheck;}
_V:{Goto VarCheck;}
_W:{Goto VarCheck;}
_X:{Goto VarCheck;}
_Y:{Goto VarCheck;}
_Z:{Goto VarCheck;}
VarCheck:
   ST:=ReadVarString(S);
1:End
   Else
  Begin;IT:=OI;RunXit:=SyntaxError;Exit;End;
 End;
 SkipSpc;
 If PC^[IT]='+'Then Begin;Inc(IT);Goto 0;End;
 S:=ST;_Str2S:=Ya;
End;

Procedure RunBasic;Label 1,2,3,_A,_B,_C,_D,_E,_F,_G,G1,G2,_H,_I,_J,_K,_L,_M,_N,VScale,
_O,_P,_Q,_R,_S,_T,_U,_V,_W,_X,_Y,_Z,VarCheck,Circl,Cls,_Draw,_Line,_Pres,Exit,Xit,Whil1;
Var L:RBuf;PC2,PC3:PChar;IO,JO,Size:Wd;S,S2,S3:String;A,B,C,D,E,F,G:NmType;_ELSE:Int;
    Ok,HScreen:Bool;TMenu:PullMnu;

 Function _FillBox:Bool;Begin
  _FillBox:=No;
  SkipSpc;
  If PC^[IT]<>'('Then Begin;RunXit:=OpenParExpected;System.Exit;End;
  Inc(IT);
  If Not Nm(A)Then System.Exit;
  If PC^[IT]<>','Then Begin;RunXit:=VirguleExpected;System.Exit;End;
  Inc(IT);
  If Not Nm(B)Then System.Exit;
  If PC^[IT]<>')'Then Begin;RunXit:=CloseParExpected;System.Exit;End;
  Inc(IT);
  SkipSpc;
  If PC^[IT]<>'-'Then Begin;RunXit:=MinusExpected;System.Exit;End;
  Inc(IT);
  SkipSpc;
  If PC^[IT]<>'('Then Begin;RunXit:=OpenParExpected;System.Exit;End;
  Inc(IT);
  If Not Nm(C)Then System.Exit;
  If PC^[IT]<>','Then Begin;RunXit:=VirguleExpected;System.Exit;End;
  Inc(IT);
  If Not Nm(D)Then System.Exit;
  If PC^[IT]<>')'Then Begin;RunXit:=CloseParExpected;System.Exit;End;
  Inc(IT);
  If PC^[IT]<>','Then Begin;RunXit:=VirguleExpected;System.Exit;End;
  Inc(IT);
  If Not Nm(E)Then System.Exit;
  If PC^[IT]=','Then Begin
   Inc(IT);
   If _Str2S(S)Then FillBox(A.Int,B.Int,C.Int,D.Int,S[1],E.Int)
    Else
   Begin
    PXtrkWord(S);Ok:=GetShade;
    SetShade(No);
    If S='B'Then PutFillBorder(A.Int,B.Int,C.Int,D.Int,E.Int)Else
    If S='BD'Then Begin;SetBorderDouble;PutFillBorder(A.Int,B.Int,C.Int,D.Int,E.Int)End Else
    If S='BL'Then Begin;SetBorderSimpleLuxe;PutFillBorder(A.Int,B.Int,C.Int,D.Int,E.Int)End Else
    If S='BS'Then Begin;SetBorderSimple;PutFillBorder(A.Int,B.Int,C.Int,D.Int,E.Int)End
     Else
    Begin;RunXit:=SyntaxError;System.Exit;End;
    SetShade(Ok);
   End;
  End
   Else
  ClrWn(A.Int,B.Int,C.Int,D.Int,E.Int);
  _FillBox:=Ya;
 End;

 Function MoveTxt:Bool;Begin
  MoveTxt:=No;
  SkipSpc;
  If PC^[IT]<>'('Then Begin;RunXit:=OpenParExpected;System.Exit;End;
  Inc(IT);
  If Not Nm(A)Then System.Exit;
  If PC^[IT]<>','Then Begin;RunXit:=VirguleExpected;System.Exit;End;
  Inc(IT);
  If Not Nm(B)Then System.Exit;
  If PC^[IT]<>')'Then Begin;RunXit:=CloseParExpected;System.Exit;End;
  Inc(IT);
  SkipSpc;
  If PC^[IT]<>'-'Then Begin;RunXit:=MinusExpected;System.Exit;End;
  Inc(IT);
  SkipSpc;
  If PC^[IT]<>'('Then Begin;RunXit:=OpenParExpected;System.Exit;End;
  Inc(IT);
  If Not Nm(C)Then System.Exit;
  If PC^[IT]<>','Then Begin;RunXit:=VirguleExpected;System.Exit;End;
  Inc(IT);
  If Not Nm(D)Then System.Exit;
  If PC^[IT]<>')'Then Begin;RunXit:=CloseParExpected;System.Exit;End;
  Inc(IT);
  SkipSpc;
  If PC^[IT]<>'-'Then Begin;RunXit:=MinusExpected;System.Exit;End;
  Inc(IT);
  SkipSpc;
  If PC^[IT]<>'('Then Begin;RunXit:=OpenParExpected;System.Exit;End;
  Inc(IT);
  If Not Nm(E)Then System.Exit;
  If PC^[IT]<>','Then Begin;RunXit:=VirguleExpected;System.Exit;End;
  Inc(IT);
  If Not Nm(F)Then System.Exit;
  If PC^[IT]<>')'Then Begin;RunXit:=CloseParExpected;System.Exit;End;
  MoveText(A.Int,B.Int,C.Int,D.Int,E.Int,F.Int);
  MoveTxt:=Ya;
 End;

 Function OpenBasic:Bool;Begin
  OpenBasic:=No;
  If Not _Str2S(S)Then System.Exit;
  S:=StrUp(S);
  If S='B'Then A.Int:=fmDef Else
  If S='O'Then A.Int:=fmWrite Else
  If S='I'Then A.Int:=fmRead Else
  If S='R'Then A.Int:=fmDef
   Else
  Begin;RunXit:=SyntaxError;System.Exit;End;
  SkipSpc;
  If PC^[IT]<>','Then Begin;RunXit:=VirguleExpected;System.Exit;End;
  Inc(IT);
  SkipSpc;
  If PC^[IT]<>'#'Then Begin;RunXit:=DieseExpected;System.Exit;End;
  Inc(IT);S:='#';
  While PC^[IT]in['0'..'9']do Begin;IncStr(S,PC^[IT]);Inc(IT)End;
  SkipSpc;
  If PC^[IT]<>','Then Begin;RunXit:=VirguleExpected;System.Exit;End;
  Inc(IT);
  If Not _Str2S(S3)Then System.Exit;
  B.Int:=Open(S3,A.Int);
  If(B.Int=hdlErr)Then Begin;RunXit:=SysErr;System.Exit;End;
  PushVarInt(B.Int,S);
  OpenBasic:=Ya;
 End;

 Function Screen:Bool;Begin
  Screen:=No;
  SkipSpc;
  IO:=IT;PXtrkWord(S);
  If(S='LUXE')or(S='DELUXE')Then Begin
   SetVideoModeDeluxe(vmTxtC80);
   HScreen:=No;Screen:=Ya;
  End
   Else
  Begin
   IT:=IO;
   If Not Nm(A)Then System.Exit;
   B.Word:=$FFFF;
   Case(A.Word)of
    0:If NmXTxts=40Then B.Word:=vmTxtC40 Else B.Word:=vmTxtC80;
    1:B.Word:=vmGrf320x200c4;
    2:B.Word:=vmGrf640x200c2;
    4:B.Word:=vmGrf640x400c2;
    7:B.Word:=vmGrf320x200c16;
    8:B.Word:=vmGrf640x200c16;
    9:B.Word:=vmTxtC80x43;
    10:B.Word:=vmGrf640x350c2;
    11:B.Word:=vmGrf640x350c2;
    12:B.Word:=vmGrf640x480c16;
    13:B.Word:=vmGrf320x200c256;
     {Non-standard}
    14:B.Word:=vmGrf320x400c256;
    15:B.Word:=vmGrf320x400c256;
    16:B.Word:=vmGrf360x480c256;
    17:B.Word:=vmTxtC80x28;
    18:B.Word:=vmTxtC80x50;
    19:B.Word:=vmTxtC80x60;
    20:B.Word:=vmTxtC100x40;
    21:B.Word:=vmTxtC132;
    22:B.Word:=vmGrf800x600c16;
    23:B.Word:=vmGrf640x350c256;
    24:B.Word:=vmGrf640x400c256;
   End;
   If B.Word<>$FFFFThen Begin
    If Not SetVideoMode(B.Word)Then Begin;RunXit:=InvalidFunctionCall;System.Exit;End;
    If A.Word=14Then SetChrWidth(0);
    SetPos(0,0);SetCurPos(0,0);
    HScreen:=No;Screen:=Ya;
    System.Exit;
   End;
   RunXit:=InvalidFunctionCall;
  End;
 End;

 Function Test:Bool;Label Restart;Var OI:Wd;Op:(Nada,_And,_Or,_Xor);OkT:Bool;Begin
  Test:=No;Op:=Nada;Ok:=No;
Restart:
  If _Str2S(S)Then Begin
   Case PC^[IT]of
    '=':Begin
     Inc(IT);
     If Not _Str2S(S2)Then System.Exit;
     OkT:=S=S2;
    End;
    '>':Begin
     Inc(IT);
     If PC^[IT]='='Then Begin
      Inc(IT);
      If Not _Str2S(S2)Then System.Exit;
      OkT:=S>=S2;
     End
     Else Begin
      If Not _Str2S(S2)Then System.Exit;
      OkT:=S>S2;
     End;
    End;
    '<':Begin
     Inc(IT);
     Case PC^[IT]of
      '>':Begin
       Inc(IT);
       If Not _Str2S(S2)Then System.Exit;
       OkT:=S<>S2;
      End;
      '=':Begin
       Inc(IT);
       If Not _Str2S(S2)Then System.Exit;
       Okt:=S<=S2;
      End;
      Else Begin
       If Not _Str2S(S2)Then System.Exit;
       OkT:=S<S2;
      End;
     End;
    End;
    Else Begin;RunXit:=SyntaxError;System.Exit;End;
   End;
  End
   Else
  Begin
   If Not Nm(A)Then System.Exit;
   Case PC^[IT]of
    '=':Begin
     Inc(IT);
     If Not Nm(B)Then System.Exit;
     OkT:=A.Int=B.Int;
    End;
    '>':Begin
     Inc(IT);
     If PC^[IT]='='Then Begin
      Inc(IT);
      If Not Nm(B)Then System.Exit;
      OkT:=A.Int>=B.Int;
     End
     Else Begin
      If Not Nm(B)Then System.Exit;
      OkT:=A.Int>B.Int;
     End;
    End;
    '<':Begin
     Inc(IT);
     Case PC^[IT]of
      '>':Begin
       Inc(IT);
       If Not Nm(B)Then System.Exit;
       OkT:=A.Int<>B.Int;
      End;
      '=':Begin
       Inc(IT);
       If Not Nm(B)Then System.Exit;
       Okt:=A.Int<=B.Int;
      End;
      Else Begin
       If Not Nm(B)Then System.Exit;
       OkT:=A.Int<B.Int;
      End;
     End;
    End;
    Else OkT:=A.Int<>0;
   End;
  End;
  Case(Op)of
   _And:Ok:=Ok and OkT;
   _Or:Ok:=Ok or OkT;
   _Xor:Ok:=Ok xor OkT;
   Else Ok:=OkT;
  End;
  OI:=IT;PXtrkWord(S);
  If S<>''Then Begin
   If S='AND'Then Begin;Op:=_And;Goto Restart;End;
   If S='OR'Then Begin;Op:=_Or;Goto Restart;End;
   If S='XOR'Then Begin;Op:=_Xor;Goto Restart;End;
   IT:=OI;
  End;
  Test:=Ya;
 End;

Begin
 L:=WinPtr^.P.Edit.Lst;JT:=0;RunXit:=0;InKeyB:=-1;TMenu:=MainMenu;
 PMInit;
 If L.NB>0Then Begin
  RBSetPtr(L,0);
  OldMode:=CurrVideoMode;
  DialTimer:=No;{$IFDEF HeapVram}OldHeapVram:=HeapVram;{$ENDIF}
  __HideMousePtr;
  PushScr(MS);
  {$IFDEF HeapVram}HeapVram:=No;{$ENDIF}
  PopScr(Output);
  If Not(IsGraf)Then SetBlink(Ya);
  ClrScrBlack;
  SetPosHome;SetCurPos(0,0);
  PushCur;
  SimpleCur;
  Repeat
   PC:=RBGetCurrBuf(L,Size);IT:=0;_ELSE:=0;
   SkipSpc;
   While PC^[IT]in['0'..'9']do Inc(IT);
 1:While(IT<Size)do Begin
    If(BrkOn)Then ASM MOV AX,BreakPressed;JMP Xit;END;
    If PC^[IT]=#0Then Break;
    SkipSpc;
    If IsRomanLetter(PC^[IT])Then Begin
     PXtrkWord(S);
     ASM
      XOR AX,AX
      SUB AX,BP
      MOV DI,Offset S
      SUB DI,AX
      INC DI
      MOV BL,SS:[DI]
      AND BX,001Fh
      SHL BX,1
      JMP Word Ptr @Label[BX]
@Label:
      DW 0
      DW Offset _A
      DW Offset _B
      DW Offset _C
      DW Offset _D
      DW Offset _E
      DW Offset _F
      DW Offset _G
      DW Offset _H
      DW Offset _I
      DW Offset _J
      DW Offset _K
      DW Offset _L
      DW Offset _M
      DW Offset _N
      DW Offset _O
      DW Offset _P
      DW Offset _Q
      DW Offset _R
      DW Offset _S
      DW Offset _T
      DW Offset _U
      DW Offset _V
      DW Offset _W
      DW Offset _X
      DW Offset _Y
      DW Offset _Z
     END;
_A:  If S='ATTR'Then Begin
      If Not Nm(A)Then Goto Exit;
      If PC^[IT]<>','Then ASM MOV AX,VirguleExpected;JMP Xit;END;
      Inc(IT);
      If Not Nm(B)Then Goto Exit;
      If(HScreen)Then Begin
       A.Int:=A.Int and 7;B.Int:=B.Int and 7;
       If PC^[IT]=','Then Begin
        Inc(IT);PXtrkWord(S);
        If Not((S='B')or(S='U'))Then ASM MOV AX,SyntaxError;JMP Xit;END;
        Case S[1]of
         'B':B.Int:=B.Int OR 8;
         'U':A.Int:=A.Int OR 8;
        End;
        If PC^[IT]=','Then Begin
         Inc(IT);PXtrkWord(S2);
         If Not((S2='B')or(S2='U'))Then ASM MOV AX,SyntaxError;JMP Xit;END;
         Case S2[1]of
         'B':B.Int:=B.Int OR 8;
         'U':A.Int:=A.Int OR 8;
         End;
        End;
       End;
      End;
      SetKr(A.Int+(B.Int shl 4));
      Goto 1;
     End;
     Goto VarCheck;
_B:  If S='BAR'Then Begin
      SkipSpc;
      PXtrkWord(S);
      If S='SELECT'Then Begin
       If Not Nm(A)Then Goto Exit;
       If PC^[IT]<>','Then ASM MOV AX,VirguleExpected;JMP Xit;END;
       Inc(IT);
       If Not Nm(B)Then Goto Exit;
       If PC^[IT]<>','Then ASM MOV AX,VirguleExpected;JMP Xit;END;
       Inc(IT);
       If Not Nm(C)Then Goto Exit;
       If PC^[IT]<>','Then ASM MOV AX,VirguleExpected;JMP Xit;END;
       Inc(IT);
       If Not Nm(D)Then Goto Exit;
       BarSelHor(A.Int,B.Int,C.Int,D.Int)
      End
       Else
      If(S='SPACE')or(S='SPC')Then Begin
       If Not Nm(A)Then Goto Exit;
       If PC^[IT]<>','Then ASM MOV AX,VirguleExpected;JMP Xit;END;
       Inc(IT);
       If Not Nm(B)Then Goto Exit;
       If PC^[IT]<>','Then ASM MOV AX,VirguleExpected;JMP Xit;END;
       Inc(IT);
       If Not Nm(C)Then Goto Exit;
       If PC^[IT]<>','Then ASM MOV AX,VirguleExpected;JMP Xit;END;
       Inc(IT);
       If Not Nm(D)Then Goto Exit;
       BarSpcHor(A.Int,B.Int,C.Int,D.Int);
      End
       Else
      ASM MOV AX,ValueExpected;JMP Xit;END;
      Goto 1;
     End;
     If S='BEEP'Then Begin;Beep;Goto 1;End;
     If S='BLOAD'Then Begin
      If _Str2S(S)Then Goto Exit;
      If PC^[IT]=','Then Begin
       Inc(IT);
       If Not Nm(A)Then Goto Exit;
       GetFile(S,0,GetFileSize(S),Mem[SegBas:A.Int]);
      End
       Else
      GetFile(S,0,GetFileSize(S),Mem[SegBas:0]);
      Goto 1;
     End;
     If S='BORDER'Then Begin
      If Not Nm(A)Then Goto Exit;
      SetBorderColor(A.Int);
      Goto 1;
     End;
     If S='BSAVE'Then Begin
      If _Str2S(S)Then Goto Exit;
      If PC^[IT]<>','Then ASM MOV AX,VirguleExpected;JMP Xit;END;
      Inc(IT);
      If Not Nm(A)Then Goto Exit;
      If PC^[IT]<>','Then ASM MOV AX,VirguleExpected;JMP Xit;END;
      Inc(IT);
      If Not Nm(B)Then Goto Exit;
      If(B.Format=DataInteger)Then B.IntHi:=0;
      SetFile(S,0,B.Long,Mem[SegBas:A.Int]);
      Goto 1;
     End;
     If S='BYE'Then Begin
      TimeOnLine:=GetRawTimer-TimeOnLine;
      A.Int:=DivL(TimeOnLine,60*60);B.Int:=Wd(DivL(TimeOnLine,60))mod 60;C.Int:=TimeOnLine mod 60;
      _PutTxtLn(CStrTimeDos(A.Int,B.Int,C.Int)+' temps dans le programme');
      ASM MOV AX,ExitProgramNow;JMP Xit;END;
     End;
     If S='BYTESPERLINE'Then Begin
      If Not Nm(A)Then Goto Exit;
      SetBytesPerLn(A.Int);
      Goto 1;
     End;
     Goto VarCheck;
_C:  If S='CALL'Then Begin
      SkipSpc;
      PXtrkWord(S);
      If S='INTERRUPT'Then Begin
       If Not Nm(A)Then Goto Exit;
       Intr(A.Int,Regs);
      End
       Else
      Begin
       If PC^[IT]in['%','&','!','#','$']Then Begin;IncStr(S,PC^[IT]);Inc(IT)End;
       A.Int:=OfsVar(S);
       If A.Word=$FFFFThen ASM MOV AX,VarNotFound;JMP Xit;END;
       PC:=System.Ptr(DSeg,A.Int);
       ASM CALL PC;END;
      End;
      Goto 1;
     End;
     If S='CAPSLOCK'Then Begin
      SkipSpc;
      PXtrkWord(S);
      If S='ON'Then SetCapsLck(Ya)Else
      If S='OFF'Then SetCapsLck(No)
                Else ASM MOV AX,ValueExpected;JMP Xit;END;
      Goto 1;
     End;
     If S='CHDIR'Then Begin
      If Not _Str2S(S)Then Goto Exit;
      ChDir(S);
      Goto 1;
     End;
     If S='CIRCLE'Then Begin
Circl:SkipSpc;
      If PC^[IT]<>'('Then ASM MOV AX,OpenParExpected;JMP Xit;END;
      Inc(IT);
      If Not Nm(A)Then Goto Exit;
      If PC^[IT]<>','Then ASM MOV AX,VirguleExpected;JMP Xit;END;
      Inc(IT);
      If Not Nm(B)Then Goto Exit;
      If PC^[IT]<>')'Then ASM MOV AX,CloseParExpected;JMP Xit;END;
      Inc(IT);
      SkipSpc;
      If PC^[IT]<>','Then ASM MOV AX,VirguleExpected;JMP Xit;END;
      Inc(IT);
      If Not Nm(C)Then Goto Exit;
      If PC^[IT]<>','Then ASM MOV AX,VirguleExpected;JMP Xit;END;
      Inc(IT);
      If Not Nm(D)Then Goto Exit;
      If PC^[IT]=','Then Begin
       Inc(IT);
       SkipSpc;
       PXtrkWord(S);
       If S='F'Then PutFillCircle(A.Int,B.Int,C.Int,D.Int)
               Else ASM MOV AX,ValueExpected;JMP Xit;END;
      End
       Else
      Circle(A.Int,B.Int,C.Int,D.Int);
      Goto 1;
     End;
     If S='CLEAR'Then Begin
      PXtrkWord(S);
      If(S='KEYBOARD')or(S='KBD')Then Begin;ClrKbd;Goto 1;End;
      If(S='MEMORY')or(S='MEM')Then Begin
       If Not Nm(A)Then Goto Exit;
       If PC^[IT]<>','Then ASM MOV AX,VirguleExpected;JMP Xit;END;
       Inc(IT);
       If Not Nm(B)Then Goto Exit;
       FillClr(Mem[SegBas:A.Int],B.Int);
       Goto 1
      End;
      ASM MOV AX,EndOfCommandExpected;JMP Xit;END;
     End;
     If S='CLOSE'Then Begin
      SkipSpc;
      If PC^[IT]<>'#'Then ASM MOV AX,DieseExpected;JMP Xit;END;
      Inc(IT);S:='#';
      While PC^[IT]in['0'..'9']do Begin;IncStr(S,PC^[IT]);Inc(IT)End;
      A.Int:=ReadVarInt(S);
      If A.Int=0Then ASM MOV AX,FileNotOpen;JMP Xit;END;
      Close(Hdl(A.Int));
      PushVarInt(0,S);
      Goto 1;
     End;
     If S='CLS'Then Begin
  Cls:If Not Nm(A)Then Goto Exit;
      If A.Int<=0Then ClrScrBlack Else ClrScr(A.Int shl 4);
      Goto 1;
     End;
     If S='COLOR'Then Begin
      If Not Nm(A)Then Goto Exit;
      If PC^[IT]=','Then Begin
       Inc(IT);
       If Not Nm(B)Then Goto Exit;
       If(IsGrf)Then _SetKr(A.Int);
       SetKr(A.Int+(B.Int shl 4));
      End
       Else
      Begin
       If(IsGrf)Then _SetKr(A.Int);
       SetKr(GetKr and$F+A.Int);
      End;
      Goto 1;
     End;
     If S='COPY'Then Begin
      If _Str2S(S)Then Begin
       If PC^[IT]=','Then Inc(IT);
       If Not Nm(C)Then Goto Exit;
       D.Int:=SegBas;
       If PC^[IT]=':'Then Begin
        Inc(IT);D.Int:=C.Int;
        If Not Nm(C)Then Goto Exit;
       End;
       If PC^[IT]<>','Then ASM MOV AX,VirguleExpected;JMP Xit;END;
       Inc(IT);
       If Not Nm(E)Then Goto Exit;
       If GetFile(S,0,Mem[D.Int:C.Int],E.Int)<>0Then ASM MOV AX,SysErr;JMP Xit;END;
      End
       Else
      Begin
       If Not Nm(A)Then Goto Exit;
       B.Word:=SegBas;
       If PC^[IT]=':'Then Begin
        Inc(IT);B:=A;
        If Not Nm(A)Then Goto Exit;
       End;
       If PC^[IT]<>','Then ASM MOV AX,VirguleExpected;JMP Xit;END;
       Inc(IT);
       If Not Nm(C)Then Goto Exit;
       D.Word:=SegBas;
       If PC^[IT]=':'Then Begin
        Inc(IT);D.Int:=C.Int;
        If Not Nm(C)Then Goto Exit;
       End;
       If PC^[IT]<>','Then ASM MOV AX,VirguleExpected;JMP Xit;END;
       Inc(IT);
       If Not Nm(E)Then Goto Exit;
       MoveLeft(Mem[B.Word:A.Word],Mem[D.Word:C.Word],E.Word)
      End;
      Goto 1;
     End;
     If S='CURSOR'Then Begin
      SkipSpc;
      PXtrkWord(S);
      If S='ON'Then SimpleCur Else
      If S='OFF'Then CloseCur
                Else ASM MOV AX,ValueExpected;JMP Xit;END;
      Goto 1;
     End;
     Goto VarCheck;
_D:  If S='DATA'Then Begin
      While Not(PC^[IT]in[#0,':'])do Inc(IT);
      Goto 1;
     End;
     If S='DEF'Then Begin
      SkipSpc;
      PXtrkWord(S);
      If S='SEG'Then Begin
       If PC^[IT]='='Then Begin
        Inc(IT);
        SkipSpc;
        PXtrkWord(S);
        If S=''Then Begin
         If Not Nm(A)Then Goto Exit;
         If Not(A.Format in[DataInteger,DataLong])Then Goto Exit;
         SegBas:=A.Word;
        End
         Else
        If S='EMS'Then SegBas:=EmmSeg Else
        If S='VIDEO'Then SegBas:=GetVideoSeg Else
        If S='VIDEOROM'Then SegBas:=GetVideoSegRom Else
        If S='VIDEOTEXT'Then SegBas:=GetVideoSegBuf
         Else
        ASM MOV AX,SyntaxError;JMP Xit;END;
       End
        Else
       SegBas:=DSeg;
       Goto 1;
      End
       Else
      ASM MOV AX,EndOfCommandExpected;JMP Xit;END;
     End;
     If S='DELAY'Then Begin
      If Not Nm(A)Then Goto Exit;
      Delay(A.Int);
      Goto 1;
     End;
     If S='DIM'Then Begin
      SkipSpc;PXtrkWord(S);
      If Not(PC^[IT]in['(','['])Then ASM MOV AX,OpenParExpected;JMP Xit;END;
      Inc(IT);
      If Not Nm(A)Then Goto Exit;
      If Not(PC^[IT]in[')',']'])Then ASM MOV AX,CloseParExpected;JMP Xit;END;
      Inc(IT);
      If Not PushVarTLong(S,A.Int)Then Goto Exit;
      Goto 1;
     End;
     If S='DO'Then Begin
      Inc(BouclePos);
      If BouclePos>63Then ASM MOV AX,TooManyBoucle;JMP Xit;END;
      Boucle[BouclePos].Model:=BDo;Boucle[BouclePos].X:=IT;
      Boucle[BouclePos].Y:=JT;
      Goto 1;
     End;
     If S='DRAW'Then Begin
_Draw:If Not _Str2S(S)Then Goto Exit;
      Draw(S);
      Goto 1;
     End;
     Goto VarCheck;
_E:  If S='ELSE'Then Begin
      If _ELSE>0Then Goto 2 Else ASM MOV AX,MisplacedElse;JMP Xit;END;
     End;
     If S='END'Then Goto 3;
     Goto VarCheck;
_F:  If S='FOR'Then Begin
      Inc(BouclePos);
      If BouclePos>63Then ASM MOV AX,TooManyBoucle;JMP Xit;END;
      SkipSpc;
      Boucle[BouclePos].Model:=BFor;Boucle[BouclePos].X:=IT;
      Boucle[BouclePos].Y:=JT;
      PXtrkWord(S);
      If PC^[IT]in['%','&']Then Begin;IncStr(S,PC^[IT]);Inc(IT)End;
      SkipSpc;
      If PC^[IT]<>'='Then ASM MOV AX,EqualExpected;JMP Xit;END;
      Inc(IT);
      If Not Nm(A)Then Goto Exit;
      If(A.Format=DataInteger)Then A.IntHi:=0;
      If S[Length(S)]='%'Then PushVarInt(A.Int,S)
                         Else PushVarLong(A.Long,S);
      PXtrkWord(S);
      If S<>'TO'Then ASM MOV AX,ToExpected;JMP Xit;END;
      Boucle[BouclePos].X2:=IT;
      If Not Nm(B)Then Goto Exit;
      PXtrkWord(S);
      If Length(S)>0Then Begin
       If S<>'STEP'Then ASM MOV AX,SyntaxError;JMP Xit;END;
       Boucle[BouclePos].X3:=IT;
       If Not Nm(C)Then Goto Exit;
      End
       Else
      Boucle[BouclePos].X3:=0;
      Goto 1;
     End;
     If S='FILLBOX'Then Begin
      If Not(_FillBox)Then Goto Exit;
      Goto 1;
     End;
     If S='FLASH'Then Begin;SetKr(GetKr or$80);Goto 1;End;
     Goto VarCheck;
_G:  If S='GET'Then Begin
      SkipSpc;
      Case PC^[IT]of
       '$':Begin
        Inc(IT);
        SkipSpc;
        If PC^[IT]<>'#'Then ASM MOV AX,DieseExpected;JMP Xit;END;
        Inc(IT);S:='#';
        While PC^[IT]in['0'..'9']do Begin;IncStr(S,PC^[IT]);Inc(IT)End;
        A.Int:=ReadVarInt(S);
        If A.Int=0Then ASM MOV AX,FileNotOpen;JMP Xit;END;
        If PC^[IT]<>','Then ASM MOV AX,VirguleExpected;JMP Xit;END;
        Inc(IT);
        If Not Nm(B)Then Goto Exit;
        If(B.Int>255)or(B.Int<1)Then ASM MOV AX,TooBigNumber;JMP Xit;END;
        PXtrkWord(S);
        If PC^[IT]<>'$'Then ASM MOV AX,DollarExpected;JMP Xit;END;
        IncStr(S,'$');Inc(IT);S3[0]:=Char(B.Int);
        If _GetRec(A.Int,B.Long,S3[1])<>0Then ASM MOV AX,SysErr;JMP Xit;END;
        PushVarString(S3,S);
        Goto 1;
       End;
       '(':Begin
        Inc(IT);
        If Not Nm(A)Then Goto Exit;
        If PC^[IT]<>','Then ASM MOV AX,VirguleExpected;JMP Xit;END;
        Inc(IT);
        If Not Nm(B)Then Goto Exit;
        If PC^[IT]<>')'Then ASM MOV AX,CloseParExpected;JMP Xit;END;
        Inc(IT);SkipSpc;
        If PC^[IT]<>'-'Then ASM MOV AX,MinusExpected;JMP Xit;END;
        Inc(IT);
        If PC^[IT]<>'('Then ASM MOV AX,OpenParExpected;JMP Xit;END;
        Inc(IT);
        If Not Nm(C)Then Goto Exit;
        If PC^[IT]<>','Then ASM MOV AX,VirguleExpected;JMP Xit;END;
        Inc(IT);
        If Not Nm(D)Then Goto Exit;
        If PC^[IT]<>')'Then ASM MOV AX,CloseParExpected;JMP Xit;END;
        Inc(IT);SkipSpc;
        If PC^[IT]<>','Then ASM MOV AX,VirguleExpected;JMP Xit;END;
        Inc(IT);SkipSpc;PXtrkWord(S);
        PC2:=AddrTLong(S,E.Word);
        If(PC2=NIL)Then ASM MOV AX,VarNameExpected;JMP Xit;END;
        If GetSizeSmlImg(A.Int,B.Int,C.Int,D.Int)+4>E.Word shl 2Then ASM MOV AX,ImageTooBig;JMP Xit;END;
        ASM
         LES DI,PC2
         MOV AX,C.Int
         SUB AX,A.Int
         STOSW
         MOV AX,D.Int
         SUB AX,B.Int
         STOSW
         ADD Word Ptr PC2,4
        END;
        GetSmlImg(A.Int,B.Int,C.Int,D.Int,PC2^);
        Goto 1;
       End;
       Else ASM MOV AX,SyntaxError;JMP Xit;END;
      End;
     End;
     If S='GOSUB'Then Begin
      Inc(GosubPos);
      If GosubPos>63Then ASM MOV AX,TooManyGosub;JMP Xit;END;
      If Not Nm(A)Then Goto Exit;
      C.Word:=JT;Gosub[GosubPos].X:=IT;Gosub[GosubPos].Y:=JT;JT:=0;
      RBSetPtr(L,0);
      For B.Word:=0to L.NB-1do Begin
       PC:=RBGetCurrBuf(L,Size);IT:=0;
       If(PC<>NIL)Then Begin
        SkipSpc;
        S:='';
        While PC^[IT]in['0'..'9']do Begin;IncStr(S,PC^[IT]);Inc(IT);End;
        If(ValW(S)=A.Word)Then Begin;IT:=0;_ELSE:=0;Goto 1;End;
       End;
       RBNext(L);Inc(JT)
      End;
      JT:=C.Word;ASM MOV AX,LabelExpected;JMP Xit;END;
     End;
     If S='GOTO'Then Begin
G1:   If Not Nm(A)Then Goto Exit;
G2:   C.Word:=JT;JT:=0;
      RBSetPtr(L,0);
      For B.Word:=0to L.NB-1do Begin
       PC:=RBGetCurrBuf(L,Size);IT:=0;
       If(PC<>NIL)Then Begin
        SkipSpc;
        S:='';
        While PC^[IT]in['0'..'9']do Begin;IncStr(S,PC^[IT]);Inc(IT);End;
        If(ValW(S)=A.Word)Then Begin;_ELSE:=0;Goto 1;End;
       End;
       RBNext(L);Inc(JT)
      End;
      JT:=C.Word;ASM MOV AX,LabelExpected;JMP Xit;END;
     End;
     If S='GR'Then Begin
      If Not SetVideoMode(vmGrf640x200c2)Then ASM MOV AX,InvalidFunctionCall;JMP Xit;END;
      Goto 1;
     End;
     Goto VarCheck;
_H:  If S='HOME'Then Begin;ClrScrBlack;Goto 1;End;
     If(S='HORIZONTALSCALE')or(S='HSCALE')Then Begin
      If Not Nm(A)Then Goto Exit;
      SetHorizontalScale(A.Word);
      Goto 1;
     End;
     If S='HTAB'Then Begin
      If Not Nm(A)Then Goto Exit;
      Dec(A.Word);
      SetPos(A.Word,GetYTxtsPos);SetCurPos(A.Word,GetYTxtsPos);
      Goto 1;
     End;
      {CompatibilitÇ avec le Basic Coco 3}
     DelChrAt(S,1);
     If S='CIRCLE'Then Goto Circl;
     If S='CLS'Then Goto Cls;
     If S='COLOR'Then Begin
      If Not Nm(A)Then Goto Exit;
      GraphColor:=A.Word;
      Goto 1;
     End;
     If S='DRAW'Then Goto _Draw;
     If S='LINE'Then Goto _Line;
     If S='PRINT'Then Begin
      If PC^[IT]<>'('Then ASM MOV AX,OpenParExpected;JMP Xit;END;
      Inc(IT);
      If Not Nm(A)Then Goto Exit;
      If PC^[IT]<>','Then ASM MOV AX,VirguleExpected;JMP Xit;END;
      Inc(IT);
      If Not Nm(B)Then Goto Exit;
      If PC^[IT]<>')'Then ASM MOV AX,CloseParExpected;JMP Xit;END;
      Inc(IT);
      If PC^[IT]<>','Then ASM MOV AX,VirguleExpected;JMP Xit;END;
      Inc(IT);
      If Not _Str2S(S)Then Begin
       If Not Nm(C)Then Goto Exit;
       Case(C.Format)of
        DataInteger:S:=Str(C.Int);
        DataLong:S:=Str(C.Long);
        DataSingle:S:=RealStr(C.Single);
        DataDouble:S:=RealStr(C.Double);
        Else ASM MOV AX,InternalError;JMP Xit;END;
       End;
      End;
      If(IsGrf)Then Begin
       B.Word:=B.Word*HeightChr;A.Word:=A.Word shl 3;
       SkipSpc;
       If PC^[IT]=','Then Begin
        Inc(IT);PXtrkWord(S3);
        If S3<>'SHADOW'Then ASM MOV AX,SyntaxError;JMP Xit;END;
        OutSTxtXY(A.Word,B.Word,S,GraphColor);
       End
        Else
       For C.Word:=1to Length(S)do Begin
        SetGCubeT(A.Word,B.Word,S[C.Word],GraphColor);
        Inc(A.Word,8)
       End;
      End
       Else
      PutTxtXY(A.Word,B.Word,S,GetKr);
      Goto 1;
     End;
     If S='RESET'Then Goto _Pres;
     If S='SCREEN'Then Begin
      If Not Nm(A)Then Goto Exit;
      Case(A.Word)of
       0:If NmXTxts>40Then B.Word:=vmTxtC80 Else B.Word:=vmTxtC40;
       1:B.Word:=vmGrf320x200c4;
       2:B.Word:=vmGrf320x200c256;
       3:B.Word:=vmGrf640x200c2;
       4:B.Word:=vmGrf640x200c16;
       Else ASM MOV AX,InvalidFunctionCall;JMP Xit;END;
      End;
      SetVideoMode(B.Word);
      If A.Word=0Then Begin;SetUnderline(Ya);SetKr(7)End;
      HScreen:=Ya;
      Goto 1;
     End;
     If S='SET'Then Begin
      If PC^[IT]<>'('Then ASM MOV AX,OpenParExpected;JMP Xit;END;
      Inc(IT);
      If Not Nm(A)Then Goto Exit;
      If PC^[IT]<>','Then ASM MOV AX,VirguleExpected;JMP Xit;END;
      Inc(IT);
      If Not Nm(B)Then Goto Exit;
      If PC^[IT]<>','Then ASM MOV AX,VirguleExpected;JMP Xit;END;
      Inc(IT);
      If Not Nm(C)Then Goto Exit;
      If PC^[IT]<>')'Then ASM MOV AX,CloseParExpected;JMP Xit;END;
      Inc(IT);
      SetPixel(A.Word,B.Word,C.Word);
      Goto 1;
     End;
     S:='H'+S;
     Goto VarCheck;
_I:  If S='IF'Then Begin
      If Not(Test)Then Goto Exit;
      PXtrkWord(S);If(Ok)Then Inc(_ELSE);
      SkipSpc;
      If S='GOTO'Then Begin
       If(Ok)Then Goto G1;
      End
       Else
      If S='THEN'Then Begin
       If(Ok)and(PC^[IT]in['0'..'9'])Then Goto G1;
      End
       Else
      ASM MOV AX,ThenExpected;JMP Xit;END;
      If Not(Ok)Then Begin
       While PC^[IT]<>#0do Begin
        If PC^[IT]='E'Then Begin
         PXtrkWord(S);
         If S='ELSE'Then Break;
        End
         Else
        Inc(IT);
       End;
      End;
      Goto 1;
     End;
     If S='ITEM'Then Begin
      If Not(_Str2S(S))Then Goto Exit;
      PC2:=PushVarStr2PChr(S);
      SkipSpc;
      If PC^[IT]<>','Then ASM MOV AX,VirguleExpected;JMP Xit;END;
      Inc(IT);
      If Not Nm(A)Then Goto Exit;
      If PC^[IT]=','Then Begin
       Inc(IT);
       If Not Nm(B)Then Goto Exit;
       If PC^[IT]=','Then Begin
        Inc(IT);
        If Not _Str2S(S)Then Goto Exit;
        PC3:=PushVarStr2PChr(S);
       End
        Else
       PC3:=NIL;
      End
       Else
      Begin;B.Word:=kbNoKey;PC3:=NIL;End;
      PMAddItemKey(PC2,B.Word,A.Word,PC3);
      Goto 1;
     End;
     Goto VarCheck;
_J:  Goto VarCheck;
_K:  If S='KILL'Then Begin
      If Not _Str2S(S)Then Goto Exit;
      DelFile(S);
      Goto 1;
     End;
     Goto VarCheck;
_L:  If S='LINE'Then Begin
_Line:SkipSpc;
      If PC^[IT]<>'('Then ASM MOV AX,OpenParExpected;JMP Xit;END;
      Inc(IT);
      If Not Nm(A)Then Goto Exit;
      If(A.Format>DataLong)Then ASM MOV AX,TypeMistmatch;JMP Xit;END;
      If PC^[IT]<>','Then ASM MOV AX,VirguleExpected;JMP Xit;END;
      Inc(IT);
      If Not Nm(B)Then Goto Exit;
      If(B.Format>DataLong)Then ASM MOV AX,TypeMistmatch;JMP Xit;END;
      If PC^[IT]<>')'Then ASM MOV AX,CloseParExpected;JMP Xit;END;
      Inc(IT);
      SkipSpc;
      If PC^[IT]<>'-'Then ASM MOV AX,MinusExpected;JMP Xit;END;
      Inc(IT);
      SkipSpc;
      If PC^[IT]<>'('Then ASM MOV AX,OpenParExpected;JMP Xit;END;
      Inc(IT);
      If Not Nm(C)Then Goto Exit;
      If(C.Format>DataLong)Then ASM MOV AX,TypeMistmatch;JMP Xit;END;
      If PC^[IT]<>','Then ASM MOV AX,VirguleExpected;JMP Xit;END;
      Inc(IT);
      If Not Nm(D)Then Goto Exit;
      If(D.Format>DataLong)Then ASM MOV AX,TypeMistmatch;JMP Xit;END;
      If PC^[IT]<>')'Then ASM MOV AX,CloseParExpected;JMP Xit;END;
      Inc(IT);
      If PC^[IT]<>','Then ASM MOV AX,VirguleExpected;JMP Xit;END;
      Inc(IT);PXtrkWord(S);
      If S='PRESET'Then E.Word:=0 Else
      If S='PSET'Then E.Word:=GraphColor Else
      If Not Nm(E)Then Goto Exit;
      If PC^[IT]=','Then Begin
       Inc(IT);
       SkipSpc;
       PXtrkWord(S);
       If S='B'Then Begin
        If PC^[IT]=','Then Begin
         Inc(IT);
         If Not Nm(F)Then Goto Exit;
         If PC^[IT]=','Then Begin
          Inc(IT);
          If Not Nm(G)Then Goto Exit;
          PutRoundRect(A.Word,B.Word,C.Word,D.Word,G.Word,F.Word,E.Word)
         End
          Else
         PutRoundRect(A.Word,B.Word,C.Word,D.Word,1,F.Word,E.Word)
        End
         Else
        PutRect(A.Word,B.Word,C.Word,D.Word,E.Word)
       End
        Else
       If(S='BF')or(S='FB')Then Begin
        If PC^[IT]=','Then Begin
         Inc(IT);
         SkipSpc;
         IF Not Nm(F)Then Goto Exit;
         PutFillRoundRect(A.Word,B.Word,C.Word,D.Word,F.Word,E.Word)
        End
         Else
        PutFillBox(A.Word,B.Word,C.Word,D.Word,E.Word)
       End
        Else
       If S<>'F'Then ASM MOV AX,SyntaxError;JMP Xit;END;
      End
       Else
      PutLn(A.Word,B.Word,C.Word,D.Word,E.Word);
      Goto 1;
     End;
     If S='LOCATE'Then Begin
      If Not Nm(A)Then Goto Exit;
      If Not(HScreen)Then Dec(A.Int);
      If PC^[IT]<>','Then ASM MOV AX,VirguleExpected;JMP Xit;END;
      Inc(IT);
      If Not Nm(B)Then Goto Exit;
      If Not(HScreen)Then Dec(B.Int);
      If(HScreen)Then Begin;SetCurPos(A.Int,B.Int);SetPos(A.Int,B.Int)End
                 Else Begin;SetCurPos(B.Int,A.Int);SetPos(B.Int,A.Int)End;
      Goto 1;
     End;
     If S='LOOP'Then Begin
      SkipSpc;
      If Not(Test)Then Goto Exit;
      If(Ok)Then Begin;Dec(BouclePos);Goto 1;End;
      If(Boucle[BouclePos].Y<>JT)Then Begin
       JT:=Boucle[BouclePos].Y;
       RBSetPtr(L,JT);
       PC:=RBGetCurrBuf(L,Size);
      End;
      IT:=Boucle[BouclePos].X;
      Goto 1;
     End;
     If S='LPRINT'Then Begin
      If Not _Str2S(S)Then Goto Exit;
      Prn(S);
      If PC^[IT]=';'Then Inc(IT)Else PrnLn;
      Goto 1;
     End;
     Goto VarCheck;
_M:  If S='MENU'Then Begin
      If Not _Str2S(S)Then Goto Exit;
      PMAddMnu(PushVarStr2PChr(S));
      Goto 1;
     End;
     If S='MKDIR'Then Begin
      If Not _Str2S(S)Then Goto Exit;
      MkDir(S);
      Goto 1;
     End;
     If S='MLOAD'Then Begin
      If Not _Str2S(S)Then Goto Exit;
      If Not LoadMtx(S)Then ASM MOV AX,FileNotFound;JMP Xit;END;
      Goto 1;
     End;
     If S='MOUSEPTR'Then Begin
      SkipSpc;
      PXtrkWord(S);
      If S='ON'Then __ShowMousePtr Else
      If S='OFF'Then __HideMousePtr
                Else ASM MOV AX,ValueExpected;JMP Xit;END;
      Goto 1;
     End;
     If S='MOVETEXT'Then Begin
      If Not(MoveTxt)Then Goto Exit;
      Goto 1;
     End;
     Goto VarCheck;
_N:  If S='NEXT'Then Begin
      If BouclePos=0Then ASM MOV AX,NextWithoutFor;JMP Xit;END;
      If(Boucle[BouclePos].Model<>BFor)Then ASM MOV AX,MisplacedNext;JMP Xit;END;
      IO:=IT;JO:=JT;
      If(Boucle[BouclePos].Y<>JT)Then Begin
       JT:=Boucle[BouclePos].Y;
       RBSetPtr(L,JT);
       PC:=RBGetCurrBuf(L,Size);
      End;
      IT:=Boucle[BouclePos].X;PXtrkWord(S);
      If PC^[IT]in['%','&']Then IncStr(S,PC^[IT]);
      If S[Length(S)]='%'Then Begin;A.Int:=ReadVarInt(S);A.IntHi:=0;End
                         Else A.Long:=ReadVarLong(S);
      IT:=Boucle[BouclePos].X2;Nm(B);
      If(B.Format=DataInteger)Then B.IntHi:=0;
      If Boucle[BouclePos].X3>0Then Begin
       IT:=Boucle[BouclePos].X3;
       Nm(C);
       If(C.Format=DataInteger)Then C.IntHi:=0;
      End
       Else
      C.Long:=1;
      If(A.Int+C.Int>B.Int)Then Begin
       JT:=JO;RBSetPtr(L,JT);
       PC:=RBGetCurrBuf(L,Size);IT:=IO;Dec(BouclePos);
       Goto 1;
      End;
      If S[Length(S)]='%'Then PushVarInt(A.Int+C.Int,S)Else PushVarLong(A.Long+C.Long,S);
      Goto 1;
     End;
     If S='NAME'Then Begin
      If Not _Str2S(S)Then Goto Exit;
      SkipSpc;
      PXtrkWord(S2);
      If S2<>'AS'Then ASM MOV AX,AsExpected;JMP Xit;END;
      If Not _Str2S(S3)Then Goto Exit;
      Ren(S,S3);
      Goto 1;
     End;
     If S='NEW'Then Goto 3;
     If S='NORMAL'Then Begin;SetKr(GetKr and$7F);Goto 1;End;
     If S='NUMLOCK'Then Begin
      SkipSpc;
      PXtrkWord(S);
      If S='ON'Then SetNmLck(Ya)Else
      If S='OFF'Then SetNmLck(No)
                Else ASM MOV AX,ValueExpected;JMP Xit;END;
      Goto 1;
     End;
     Goto VarCheck;
_O:  If S='OPEN'Then Begin
      If Not(OpenBasic)Then Goto Exit;
      Goto 1;
     End;
     If S='OUT'Then Begin
      If Not Nm(A)Then Goto Exit;
      If PC^[IT]<>','Then ASM MOV AX,VirguleExpected;JMP Xit;END;
      Inc(IT);
      If Not Nm(B)Then Goto Exit;
      Port[A.Word]:=B.Int;
      Goto 1;
     End;
     Goto VarCheck;
_P:  If S='PAGE'Then Begin
      If Not Nm(A)Then Goto Exit;
      SetPage(A.Int);
      Goto 1;
     End;
     If S='PALETTE'Then Begin
      If Not Nm(A)Then Goto Exit;
      If PC^[IT]<>','Then ASM MOV AX,VirguleExpected;JMP Xit;END;
      Inc(IT);
      If Not Nm(B)Then Goto Exit;
      If PC^[IT]=','Then Begin
       Inc(IT);
       If Not Nm(C)Then Goto Exit;
       If PC^[IT]<>','Then ASM MOV AX,VirguleExpected;JMP Xit;END;
       Inc(IT);
       If Not Nm(D)Then Goto Exit;
       SetPaletteRGB(A.Int,B.Int,C.Int,D.Int);
      End
       Else
      SetPaletteRGB(A.Int,(B.Int shr 4)shl 6,((B.Int shr 2)and 3)shl 6,(B.Int and 3)shl 6);
      Goto 1;
     End;
     If S='PCOPY'Then Begin
      If Not Nm(A)Then Goto Exit;
      SkipSpc;
      PXtrkWord(S);
      If S<>'TO'Then ASM MOV AX,ToExpected;JMP Xit;END;
      If Not Nm(B)Then Goto Exit;
      PCopy(A.Int,B.Int);
      Goto 1;
     End;
     If S='POKE'Then Begin
      If Not Nm(A)Then Goto Exit;
      If PC^[IT]<>','Then ASM MOV AX,VirguleExpected;JMP Xit;END;
      Inc(IT);
      If Not Nm(B)Then Goto Exit;
      Mem[SegBas:A.Word]:=B.Int;
      Goto 1;
     End;
     If S='PRESET'Then Begin
_Pres:If PC^[IT]<>'('Then ASM MOV AX,OpenParExpected;JMP Xit;END;
      Inc(IT);
      If Not Nm(A)Then Goto Exit;
      If PC^[IT]<>','Then ASM MOV AX,VirguleExpected;JMP Xit;END;
      Inc(IT);
      If Not Nm(B)Then Goto Exit;
      If PC^[IT]<>')'Then ASM MOV AX,CloseParExpected;JMP Xit;END;
      Inc(IT);
      SetPixel(A.Word,B.Word,0);
      Goto 1;
     End;
     If S='PRINT'Then Begin
      If Not _Str2S(S)Then Begin
       Case PC^[IT]of
        '#':Begin
         Inc(IT);S:='#';
         While PC^[IT]in['0'..'9']do Begin;IncStr(S,PC^[IT]);Inc(IT)End;
         A.Int:=ReadVarInt(S);
         If A.Int=0Then ASM MOV AX,FileNotOpen;JMP Xit;END;
         SkipSpc;
         If PC^[IT]<>','Then ASM MOV AX,VirguleExpected;JMP Xit;END;
         Inc(IT);
         If Not _Str2S(S3)Then Goto Exit;
         If PC^[IT]=';'Then Begin;Inc(IT);PutFileTxt(A.Int,S3)End
                       Else PutFileTxtLn(A.Int,S3);
         Goto 1;
        End;
        '@':Begin
         Inc(IT);
         If Not Nm(A)Then Goto Exit;
         If PC^[IT]<>','Then ASM MOV AX,VirguleExpected;JMP Xit;END;
         If Not _Str2S(S)Then Goto Exit;
         SetPos(A.Word mod NmXTxts,B.Word div NmXTxts);
         SetCurPos(A.Word mod NmXTxts,B.Word div NmXTxts);
        End;
        Else Begin
         IO:=IT;
         If Not Nm(A)Then Goto Exit;
         If(IO=IT)Then S:=''
          Else
         Case(A.Format)of
          DataInteger:S:=Str(A.Int);
          DataLong:S:=Str(A.Long);
          DataSingle:S:=RealStr(A.Single);
          DataDouble:S:=RealStr(A.Double);
          Else ASM MOV AX,InternalError;JMP Xit;END;
         End;
        End;
       End;
      End;
      If PC^[IT]=';'Then Begin;Inc(IT);_PutTxt(S)End
       Else
      Begin
       If(HScreen)Then Begin
        _PutTxt(S);
        ClrEol(GetKr);
        _Dn;VidBnkSwitch.XP:=0;
       End
        Else
       _PutTxtLn(S);
      End;
      Goto 1;
     End;
     If S='PSET'Then Begin
      If PC^[IT]<>'('Then ASM MOV AX,OpenParExpected;JMP Xit;END;
      Inc(IT);
      If Not Nm(A)Then Goto Exit;
      If PC^[IT]<>','Then ASM MOV AX,VirguleExpected;JMP Xit;END;
      Inc(IT);
      If Not Nm(B)Then Goto Exit;
      If PC^[IT]<>')'Then ASM MOV AX,CloseParExpected;JMP Xit;END;
      Inc(IT);
      If PC^[IT]<>','Then ASM MOV AX,VirguleExpected;JMP Xit;END;
      Inc(IT);
      If Not Nm(C)Then Goto Exit;
      SetPixel(A.Int,B.Int,C.Int);
      Goto 1;
     End;
     If S='PUT'Then Begin
      If PC^[IT]<>'('Then ASM MOV AX,OpenParExpected;JMP Xit;END;
      Inc(IT);
      If Not Nm(A)Then Goto Exit;
      If PC^[IT]<>','Then ASM MOV AX,VirguleExpected;JMP Xit;END;
      Inc(IT);
      If Not Nm(B)Then Goto Exit;
      If PC^[IT]<>')'Then ASM MOV AX,CloseParExpected;JMP Xit;END;
      Inc(IT);
      If PC^[IT]<>','Then ASM MOV AX,VirguleExpected;JMP Xit;END;
      Inc(IT);PXtrkWord(S);
      PC2:=AddrTLong(S,E.Word);
      If(PC2=NIL)Then ASM MOV AX,TypeMistmatch;JMP Xit;END;
      ASM
       LES DI,PC2
       MOV AX,ES:[DI]
       ADD AX,A.Int
       MOV C.Int,AX
       MOV AX,ES:[DI+2]
       ADD AX,B.Int
       MOV D.Int,AX
       ADD Word Ptr PC2,4
      END;
      PutSmlImg(A.Int,B.Int,C.Int,D.Int,PC2^);
      Goto 1;
     End;
     Goto VarCheck;
_Q:  Goto VarCheck;
_R:  If S='RANDOMIZE'Then Begin
      Randomize;
      Goto 1;
     End;
     If S='REG'Then Begin
      If Not Nm(A)Then Goto Exit;
      If PC^[IT]<>','Then ASM MOV AX,VirguleExpected;JMP Xit;END;
      Inc(IT);
      If Not Nm(B)Then Goto Exit;
      Case(A.Int)of
       0:Regs.Flags:=B.Word;
       1:Regs.AX:=B.Word;
       2:Regs.BX:=B.Word;
       3:Regs.CX:=B.Word;
       4:Regs.DX:=B.Word;
       5:Regs.SI:=B.Word;
       6:Regs.DI:=B.Word;
       7:Regs.BP:=B.Word;
       8:Regs.DS:=B.Word;
       9:Regs.ES:=B.Word;
       Else ASM MOV AX,InvalidFunctionCall;JMP Xit;END;
      End;
      Goto 1;
     End;
     If S='REM'Then Begin;IT:=Size;Goto 2;End;
     If S='RENDIR'Then Begin
      If Not _Str2S(S)Then Goto Exit;
      SkipSpc;
      PXtrkWord(S2);
      If S2<>'AS'Then ASM MOV AX,AsExpected;JMP Xit;END;
      If Not _Str2S(S3)Then Goto Exit;
      RenDir(S,S3);
      Goto 1;
     End;
     If S='RETURN'Then Begin
      If GosubPos=0Then ASM MOV AX,ReturnWithoutGosub;JMP Xit;END;
      If Nm(A)Then Begin;Dec(GosubPos);Goto G2;End;
      IT:=Gosub[GosubPos].X;JT:=Gosub[GosubPos].Y;
      RBSetPtr(L,JT);PC:=RBGetCurrBuf(L,Size);
      Dec(GosubPos);
      Goto 1;
     End;
     If S='RMDIR'Then Begin
      If Not _Str2S(S)Then Goto Exit;
      RmDir(S);
      Goto 1;
     End;
     Goto VarCheck;
_S:  If S='SCREEN'Then Begin
      If Not(Screen)Then Goto Exit;
      Goto 1;
     End;
     If S='SCROLLLOCK'Then Begin
      SkipSpc;
      PXtrkWord(S);
      If S='ON'Then SetScrollLck(Ya)Else
      If S='OFF'Then SetScrollLck(No)
                Else ASM MOV AX,ValueExpected;JMP Xit;END;
      Goto 1;
     End;
     If S='SEEK'Then Begin
      SkipSpc;
      If PC^[IT]<>'#'Then ASM MOV AX,DieseExpected;JMP Xit;END;
      Inc(IT);S:='#';
      While PC^[IT]in['0'..'9']do Begin;IncStr(S,PC^[IT]);Inc(IT)End;
      A.Int:=ReadVarInt(S);
      If A.Int=0Then ASM MOV AX,FileNotOpen;JMP Xit;END;
      SkipSpc;
      If PC^[IT]<>','Then ASM MOV AX,VirguleExpected;JMP Xit;END;
      Inc(IT);
      If Not Nm(B)Then Goto Exit;
      If(B.Format=DataInteger)Then B.IntHi:=0;
      SetFilePos(A.Int,B.Long);
      Goto 1;
     End;
     If S='SHELL'Then Begin
      If Not _Str2S(S)Then Goto Exit;
      {$IFNDEF DPMI}FreeMaxHeap;{$ENDIF}
      Exec(GetEnv('COMSPEC'),'/C'+S);
      {$IFNDEF DMPI}MaxExpandHeap;{$ENDIF}
      Goto 1;
     End;
     If S='SOUND'Then Begin
      If Not Nm(A)Then Goto Exit;
      If PC^[IT]<>','Then ASM MOV AX,VirguleExpected;JMP Xit;END;
      Inc(IT);
      If Not Nm(B)Then Goto Exit;
      Sound(A.Word);
      Delay(B.Word);
      NoSound;
      Goto 1;
     End;
     If S='SPLITSCREEN'Then Begin
      If Not Nm(A)Then Goto Exit;
      SplitScreen(A.Word);
      Goto 1;
     End;
     If S='STOP'Then ASM MOV AX,StopProgram;JMP Xit;END;
     If S='SYSTEM'Then ASM MOV AX,ExitProgramNow;JMP Xit;END;
     Goto VarCheck;
_T:  Goto VarCheck;
_U:  Goto VarCheck;
_V:  If S='VERTICALSCALE'Then Begin
VScale:If Not Nm(A)Then Goto Exit;
      SetVerticalScale(A.Word);
      Goto 1;
     End;
     If S='VIEW'Then Begin
      SkipSpc;
      PXtrkWord(S);
      If S='MENU'Then Begin;PMPutMnuBar;Goto 1;End;
      RunXit:=SyntaxError;Goto Exit;
     End;
     If S='VISUALPAGE'Then Begin
      If Not Nm(A)Then Goto Exit;
      SetVisualPg(A.Word);
      Goto 1;
     End;
     If S='VSCALE'Then Goto VScale;
     If S='VTAB'Then Begin
      If Not Nm(A)Then Goto Exit;
      Dec(A.Word);
      SetPos(GetNmXTxts,A.Word);SetCurPos(GetNmXTxts,A.Word);
      Goto 1;
     End;
     Goto VarCheck;
_W:  If S='WAITRETRACE'Then Begin;WaitRetrace;Goto 1;End;
     If S='WEND'Then Begin
      If(Boucle[BouclePos].Model<>BWhile)Then ASM MOV AX,MisplacedWend;JMP Xit;END;
      IT:=Boucle[BouclePos].X;
      If(JT<>Boucle[BouclePos].Y)Then Begin
       JT:=Boucle[BouclePos].Y;
       RBSetPtr(L,JT);
       PC:=RBGetCurrBuf(L,Size);
      End;
      Goto Whil1;
     End;
     If S='WIDTH'Then Begin
      If Not Nm(A)Then Goto Exit;
      If(IsGrf)Then Begin
       If(CurrVideoMode=6)and(A.Word=40)Then SetVideoMode(vmGrf320x200c4)Else
       If(CurrVideoMode=5)and(A.Word=80)Then SetVideoMode(vmGrf640x200c2)Else
       If Not SetVideoSize(BitsPerPixel,A.Word,NmYTxts)Then ASM MOV AX,InvalidFunctionCall;JMP Xit;END;
      End
       Else
      Begin
       If Not SetVideoSize(0,A.Word,NmYTxts)Then ASM MOV AX,InvalidFunctionCall;JMP Xit;END;
       If(HScreen)Then SetUnderline(Ya);
      End;
      Goto 1;
     End;
     If S='WHILE'Then Begin
      Inc(BouclePos);
      If BouclePos>63Then ASM MOV AX,TooManyBoucle;JMP Xit;END;
      SkipSpc;
      Boucle[BouclePos].Model:=BWhile;Boucle[BouclePos].X:=IT;
      Boucle[BouclePos].Y:=JT;
Whil1:If Not(Test)Then Goto Exit;
      If(Ok)Then Goto 1;
      Repeat
       While PC^[IT]<>#0do Begin
        If PC^[IT]='W'Then Begin
         PXtrkWord(S);
         If S='WEND'Then Begin;Dec(BouclePos);Goto 1;End;
        End
         Else
        Inc(IT);
       End;
       RBNext(L);Inc(JT);
       PC:=RBGetCurrBuf(L,Size);IT:=0;
      Until JT>=L.NB;
      ASM MOV AX,WhileWithoutWend;JMP Xit;END;
     End;
     If S='WRITE'Then Begin
      If Not _Str2S(S)Then Begin
       Case PC^[IT]of
        '#':Begin
         Inc(IT);S:='#';
         While PC^[IT]in['0'..'9']do Begin;IncStr(S,PC^[IT]);Inc(IT)End;
         A.Int:=ReadVarInt(S);
         If A.Int=0Then ASM MOV AX,FileNotOpen;JMP Xit;END;
         SkipSpc;
         If PC^[IT]<>','Then ASM MOV AX,VirguleExpected;JMP Xit;END;
         Inc(IT);
         If Not _Str2S(S3)Then Goto Exit;
         S3:='"'+S3;IncStr(S3,'"');
         If PC^[IT]=';'Then Begin;Inc(IT);PutFileTxt(A.Int,S3)End
                       Else PutFileTxtLn(A.Int,S3);
         Goto 1;
        End;
        Else Goto Exit;
       End;
      End;
      _PutTxt('"');
      IncStr(S,'"');
      If PC^[IT]=';'Then Begin;Inc(IT);_PutTxt(S)End Else _PutTxtLn(S);
      Goto 1;
     End;
     {Goto VarCheck;}
_X:  {Goto VarCheck;}
_Y:  {Goto VarCheck;}
_Z:  {Goto VarCheck;}
VarCheck:
     SkipSpc;
     Case PC^[IT]of
      '=':Begin
       Inc(IT);
       If Not Nm(A)Then Goto Exit;
       If(A.Format=DataInteger)Then A.IntHi:=0;
       PushVarLong(A.Long,S);
       Goto 1;
      End;
      '%':Begin
       Inc(IT);
       SkipSpc;
       If PC^[IT]='='Then Begin
        Inc(IT);
        If Not Nm(A)Then Goto Exit;
        IncStr(S,'%');
        PushVarInt(A.Int,S);
        Goto 1;
       End
        Else
       ASM MOV AX,SyntaxError;JMP Xit;END;
      End;
      '&':Begin
       Inc(IT);
       SkipSpc;
       If PC^[IT]='='Then Begin
        Inc(IT);
        If Not Nm(A)Then Goto Exit;
        IncStr(S,'&');
        PushVarLong(A.Long,S);
        Goto 1;
       End
        Else
       ASM MOV AX,SyntaxError;JMP Xit;END;
      End;
      '!':Begin
       Inc(IT);
       SkipSpc;
       If PC^[IT]='='Then Begin
        Inc(IT);
        If Not Nm(A)Then Goto Exit;
        IncStr(S,'!');
        PushVarSingle(A.Single,S);
        Goto 1;
       End
        Else
       ASM MOV AX,SyntaxError;JMP Xit;END;
      End;
      '#':Begin
       Inc(IT);
       SkipSpc;
       If PC^[IT]='='Then Begin
        Inc(IT);
        If Not Nm(A)Then Goto Exit;
        IncStr(S,'#');
        PushVarDouble(A.Double,S);
        Goto 1;
       End
        Else
       ASM MOV AX,SyntaxError;JMP Xit;END;
      End;
      '$':Begin
       Inc(IT);
       SkipSpc;
       If PC^[IT]='='Then Begin
        Inc(IT);
        If Not _Str2S(S3)Then Goto Exit;
        IncStr(S,'$');
        If S='INKEY$'Then Case Length(S3)of
         0:;
         1:PushKey(Byte(S3[1]));
         2:PushKey(Byte(S3[1])+(Byte(S3[2])shl 8));
        End
         Else
        PushVarString(S3,S);
        Goto 1;
       End;
      End;
'(','[':Begin
       Inc(IT);
       If Not Nm(A)Then Goto Exit;
       PC2:=AddrTLong(S,C.Word);
       If(PC2=NIL)Then ASM MOV AX,VarNotFound;JMP Xit;END;
       If Not(PC^[IT]in[')',']'])Then ASM MOV AX,CloseParExpected;JMP Xit;END;
       Inc(IT);
       If PC^[IT]<>'='Then ASM MOV AX,SyntaxError;JMP Xit;END;
       Inc(IT);
       If Not Nm(B)Then Goto Exit;
       If(B.Format=DataInteger)Then B.IntHi:=0;
       ASM
        LES DI,PC2
        MOV BX,A.Int
        {$IFOPT G+}SHL BX,2{$ELSE}SHL BX,1;SHL BX,1{$ENDIF}
        ADD DI,BX
        MOV AX,Word Ptr B.Long
        STOSW
        MOV AX,Word Ptr B.Long[2]
        STOSW
       END;
       Goto 1;
      End;
      Else ASM MOV AX,SyntaxError;JMP Xit;END;
     End;
    End;
    If PC^[IT]=''''Then Goto 2;
    If PC^[IT]<>':'Then ASM MOV AX,SyntaxError;JMP Xit;END;
    Inc(IT);
   End;
2: RBNext(L);Inc(JT);
  Until JT>=L.NB;
3:ClrKbd;
  PutTxtXY(0,MaxYTxts-1,'Presse une touche pour',7);
  PutTxtXY(0,MaxYTxts,'retourner au BasicPro...',7);
  ReadKey;
  ASM
   XOR AX,AX {RunXit:=0;}
Xit:
   MOV RunXit,AX
  END;
Exit:
  NewMem;
  PMDone;
  MainMenu:=TMenu;
  SetUnderline(No);
  PushScr(Output);
  {$IFDEF HeapVram}HeapVram:=OldHeapVram;{$ENDIF}
  PopScr(MS);
  __ShowMousePtr;
  DialTimer:=Ya;
 End;
End;

Function ErrCodeXit(Code:Int):String;Begin
 Case(Code)of
  0:;
  1..32767:ErrCodeXit:=GetDosErrMsg(Code);
  PointCommaExpected:ErrCodeXit:='";" attendu!';
  OpenEnsExpected:ErrCodeXit:='"{" attendu!';
  CloseEnsExpected:ErrCodeXit:='"}" attendu!';
  OpenArrayExpected:ErrCodeXit:='"[" attendu!';
  CloseArrayExpected:ErrCodeXit:='"]" attendu!';
  OpenParExpected:ErrCodeXit:='"(" attendu!';
  CloseParExpected:ErrCodeXit:='")" attendu!';
  AsterixExpected:ErrCodeXit:='"*" attendu!';
  NumExpected:ErrCodeXit:='Nombre attendu!';
  GrExpected:ErrCodeXit:='">" attendu!';
  GuillExpected:ErrCodeXit:='''"'' attendu!';
  CommaExpected:ErrCodeXit:='"." attendu!';
  EnumExpected:ErrCodeXit:='ênumÇration attendu!';
  NumberOfArrayExpected:ErrCodeXit:='Dimension du tableau attendu!';
  EndOfFunctionExpected:ErrCodeXit:='Fin de fonction omise!';
  EndOfSourceExpected:ErrCodeXit:='Fin du source attendu!';
  EndOfStringExpected:ErrCodeXit:='Fin de la chaåne de caractäres omise!';
  EndOfCommentExpected:ErrCodeXit:='Fin du commentaire omis!';
  EndOfCommandExpected:ErrCodeXit:='Fin de commande attendu!';
  EndOfArgumentExpected:ErrCodeXit:='Fin de l''argument attendu!';
  TypeVarExpected:ErrCodeXit:='Type de variable omis!';
  VarNameExpected:ErrCodeXit:='Nom de la variable omis!';
  DirectiveCommandExpected:ErrCodeXit:='Directive de commande attendu!';
  TypedefNameExpected:ErrCodeXit:='Nom du "typedef" attendu!';
  IncludeFileNameExpected:ErrCodeXit:='Nom du fichier d''inclusion attendu!';
  IfDirectNameExpected:ErrCodeXit:='Nom de la directive IF attendu!';
  IfDefDirectNameExpected:ErrCodeXit:='Directive IFDEF attendu!';
  IfNDefDirectNameExpected:ErrCodeXit:='Directive IFNDEF attendu!';
  WhileExpected:ErrCodeXit:='"WHILE" attendu!';
  BeginExpected:ErrCodeXit:='EntrÇe de boåte attendu!';
  NameExpected:ErrCodeXit:='Nom attendu!';
  ValueExpected:ErrCodeXit:='Valeur attendu!';
  TypeExpected:ErrCodeXit:='Type attendu!';
  OfExpected:ErrCodeXit:='"OF" attendu!';
  LabelExpected:ErrCodeXit:='êtiquette omise!';
  NamePrgExpected:ErrCodeXit:='Nom du programme attendu!';
  UnitNameExpected:ErrCodeXit:='Nom de l''unitÇ attendu!';
  ConstNameExpected:ErrCodeXit:='Nom de la constante attendu!';
  EndExpected:ErrCodeXit:='Fin de boåte attendu!';
  ColonExpected:ErrCodeXit:='":" attendu!';
  EqualExpected:ErrCodeXit:='"=" attendu!';
  CFExpected:ErrCodeXit:='"_CF" attendu!';
  IdentifierExpected:ErrCodeXit:='Identificateur attendu!';
  LowerExpected:ErrCodeXit:='"<" attendu!';
  PlusExpected:ErrCodeXit:='"+" attendu!';
  MinusExpected:ErrCodeXit:='"-" attendu!';
  VirguleExpected:ErrCodeXit:='"," attendu!';
  ThenExpected:ErrCodeXit:='"THEN" attendu!';
  EnumDupl:ErrCodeXit:='Duplication d''ÇnumÇration';
  VarStructDupl:ErrCodeXit:='Duplication de la structure de variable';
  DuplDefUnit:ErrCodeXit:='Duplication de la dÇfinition d''unitÇ';
  VarDupl:ErrCodeXit:='Duplication de variable';
  AsExpected:ErrCodeXit:='"AS" attendu';
  ToExpected:ErrCodeXit:='"TO" attendu';
  BreakPressed:ErrCodeXit:='Ctrl+Break enfoncÇ';
  VarNotFound:ErrCodeXit:='Variable introuvable!';
  NextWithoutFor:ErrCodeXit:='"NEXT" sans "FOR"';
  DieseExpected:ErrCodeXit:='"#" attendu!';
  InvalidFunctionCall:ErrCodeXit:='Appel de fonction invalide';
  DollarExpected:ErrCodeXit:='"$" attendu!';
  TooManyGosub:ErrCodeXit:='Trop de "GOSUB"';
  ReturnWithoutGosub:ErrCodeXit:='"RETURN" sans "GOSUB"';
  WhileWithoutWend:ErrCodeXit:='"WHILE" sans "WEND"';
  MisplacedWend:ErrCodeXit:='"WEND" mal placÇ';
  ImageTooBig:ErrCodeXit:='Image trop grosse';
  UsePascalReservedWordForVar:ErrCodeXit:='Utilisation de mot rÇservÇ Pascal pour une variable';
  EnumEmpty:ErrCodeXit:='EnumÇration vide!';
  StructEmpty:ErrCodeXit:='Structure vide!';
  TooManyPathInHeader:ErrCodeXit:='Trop rÇpertoire dans l''entàte';
  TooManyWarning:ErrCodeXit:='Trop de message d''attention!';
  UnknownIdentifier:ErrCodeXit:='Identificateur inconnue';
  UnknownType:ErrCodeXit:='Type inconnue';
  SyntaxError:ErrCodeXit:='Erreur de syntaxe';
  SyntaxNumber:ErrCodeXit:='Erreur de syntaxe du nombre';
  MisplacedNext:ErrCodeXit:='"NEXT" mal placÇ';
  MisplacedElse:ErrCodeXit:='"ELSE" mal placÇ';
  MisplacedBeginSymbol:ErrCodeXit:='Symbole de commencement mal placÇ';
  MisplacedCondDirective:ErrCodeXit:='Directive conditionnel mal placÇ';
  MisplacedEndSymbol:ErrCodeXit:='Symbole de fin mal placÇ';
  MisplacedPointComma:ErrCodeXit:='";" mal placÇ';
  TooManyBoucle:ErrCodeXit:='Trop de boucle en mÇmoire!';
  TooBigNumber:ErrCodeXit:='Nombre trop grand';
  TypeMistmatch:ErrCodeXit:='Type totalement incompatible!';
  OpCode186:ErrCodeXit:='Instruction rÇclamant un CPU 80186';
  OpCode286:ErrCodeXit:='Instruction rÇclamant un CPU 80286';
  OpCode287:ErrCodeXit:='Instruction rÇclamant un MPU 80287';
  OpCode386:ErrCodeXit:='Instruction rÇclamant un CPU 80386';
  OpCode387:ErrCodeXit:='Instruction rÇclamant un MPU 80387';
  FileNotOpen:ErrCodeXit:='Fichier pas ouvert!';
  FileNotFound:ErrCodeXit:='Fichier introuvable!';
  CannotCreateFile:ErrCodeXit:='Impossible de crÇer le fichier';
  FileReadError:ErrCodeXit:='Erreur de lecture du fichier';
  OutOfMemory:ErrCodeXit:='Manque de mÇmoire';
  InternalError:ErrCodeXit:='Erreur interne!!!';
  Else ErrCodeXit:='Erreur #'+StrW(AbsInt(RunXit));
 End;
End;

BEGIN
 InitSystems(suIsabel);
 PathDskSwp:=FileExpand('BASICPRO.$$$');
 InitMemManagers;
 PushScr(Output);
 DefaultMode:=vmTxtDef;
 SetVideoModeDeluxe(vmTxtDef);
 ExtBas:=PChr(PChar('*.BAS'));KrTapis:=$18;UpDateMnu:=PutMnu;
 MakeMnu;
 Init('Basic PRO',MtxBleuet);
 __InitMouse;
 Repeat
  K:=Run;
  Case(K)of
   kbAltF3,kbClose:CloseWindow;
   kbPrgMnuBar:PMGetMnuBar(LastMsX,LastMsY);
   kbPrgClsIcon:K:=bpExit;
   kbAltX:K:=bpExit;
   kbF2:K:=bpSave;
   kbF3:K:=bpOpen;
   kbF6:K:=bpNextWn;
   kbShiftF6:K:=bpPreviousWn;
   kbCtrlF9:K:=bpRun;
   kbAltF5:K:=bpOutput;
   Else Begin
    PushKey(K);
    K:=PMWaitForMnuAction;
   End;
  End;
  Case(K)of
   bpOpen:OpenX(vtBas);
   bpSave:Save;
   bpSaveAs:SaveAs;
   bpRun:Begin
    FillClr(Gosub,SizeOf(Gosub));GosubPos:=0;
    FillClr(Boucle,SizeOf(Boucle));BouclePos:=0;
    FillClr(Data,SizeOf(Data));CurData:=0;
    RunBasic;
    Case(RunXit)of
     -666:K:=bpExit;
     0:;
     Else Begin
      TEGotoXY(WinPtr^.P.Edit,IT,JT);
      TESetCur(WinPtr^.P.Edit);
      SimpleCur;
      SetAllKr($CE,$CF);
      PutLastBar(2,'Erreur: ^'+ErrCodeXit(RunXit)+'^');
      ReadKey;
      PutMnu;
     End;
    End;
   End;
   bpNew:MakeApplication(wnEdit,vtBas);
   bpOutput:LookOutput;
   bpNextWn:NextWindow;
   bpPreviousWn:PreviousWindow;
   bpAbout:About;
  End;
 Until K=bpExit;
 DoneLuxeVideo;
 PopScr(Output);
 DoneMemManagers;
 DoneSystems;
 WriteLn('Longue vie au peuple!!!!!!!!!!!!');
END.*)

BEGIN
 RunBasicInterpretor;
END.