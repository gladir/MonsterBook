{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
 �                                                               �
 �                   Monster Book/Debogueur                      �
 � Malte Genesis/Edition Chantal pour Mode R괻l/IV - Version 1.2 �
 �                          1997/02/18                           �
 �                                                               �
 �      Tous droits r굎erv� par les Chevaliers de Malte (C)      �
 �                                                               �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�


 Nom des programmeurs
 袴袴袴袴袴袴袴袴袴袴

  Sylvain Maltais ainsi que Dieu Tout-Puissant


 Description
 袴袴袴袴袴�

  Cette unit� est la base m늤e du d괷ogueur ne pouvant surtout pas
 ce promener all괾rement  dans la m굆oire sous risque de plantage.
 Alors hors de sa vue le recouvrement de cette unit�.  Vous pouvez
 l'appelez quand m늤e pour  que l'application MonsterBook ou Power
 Hacken puissent suive  des programmes  pas � pas  et 굃iminer les
 probl둴es de comportement � votre 괾ard.
}

Unit MBDebug;

INTERFACE

Uses Systex,Isatex;

Const DebugPrg:Boolean=No;
Var DebAX,DebBX,DebCX,DebDX,DebSI,DebDI,DebDS,DebES,
    DebBP,DebFlags,DebSS,DebSP:Wd;PrgInstr:Pointer;

Procedure DELoadProgram(Var Q;X1,Y1,X2,Y2:Byte;Const Path:String);
Procedure OpenDebugProgram(Var Q:DebugRec;Path:String;X1,Y1,X2,Y2:Byte);
Function  RunDebugProgram(Var Q):Wd;
Function  DoneDebug(Var Q):Wd;
Procedure RefreshDebug(Var Q);

IMPLEMENTATION

Uses Systems,Video,Dials,DialPlus,MalEnv,MalLibra,
     MBDebugT,MBCortex,Dialex,Apps;

{$DEFINE OldDebug}

Const
 FSDebug:Word=0;
 PrgPtr:^TByte=NIL;
Var
 OldInt01h:Pointer;
 DebugSkip:Boolean;

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
 �                         Proc괺ure DoneDebug                       �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�


 Description
 袴袴袴袴袴�

  Cette proc괺ure d괷ranche les m괹anismes de d괷oguage et 굃imine les
 donn괻s m굆oire ainsi que vid굊 en r굎ultat.
}

Function DoneDebug;Begin
 SetIntVec($01,OldInt01h);
 If(DebugPrg)Then Begin
  DebugPrg:=No;
  If(PrgPtr<>NIL)Then ASM
   MOV ES,PrgPtr.Word[2]
   INT $9C
   MOV PrgPtr.Word[2],0
   MOV PrgPtr.Word[0],0
  END;
(*  WEDone({WinPtr^}WinRec(Windows.CurrModel^).P.Debug.W);*)
  WEDone(DebugRec(HPtr(Windows)^).W);
  DoneDebug:=0;
 End;
End;

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴콘
 �                      Enregistrement DataReg                        �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複蔔


 Description
 袴袴袴袴袴�

  Cette proc괺ure  est r괶lit�  un enregistrement contenu les variables
 crucialement pour repartir l'application MonsterBook/PowerHacken apr둺
 une ex괹ution plus ou moins br둽e du programme � d괷oguer.
}

Procedure DataReg;Assembler;ASM
 DD FSDebug
 DD 0
 DW 0
END;

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴콘
 �                             Proc괺ure EndPoint                         �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複蔔


 Description
 袴袴袴袴袴�

  Cette proc괺ure est un branchement permettant � l'application MonsterBook/
 PowerHacken de reprendre  le contr뱇e tout  de suite apr둺 un d괹lenchement
 d'interruption 01h de d괷oguage pas � pas.
}

Procedure EndPoint;Far;Begin
 ASM
  NOP
  NOP
  NOP
  NOP
  MOV DS,CS:Word Ptr DataReg[2]
  CLI
  MOV SP,CS:Word Ptr DataReg[4]
  MOV SS,CS:Word Ptr DataReg[6]
  STI
  MOV BP,CS:Word Ptr DataReg[8]
 END;
End;

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴콘
 �                          Interruption 01h                        �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複蔔


 Description
 袴袴袴袴袴�

  Cette proc괺ure est en fa똳e une interruption visant � effectuer un
 d괷oguage pas � pas du programme.
}

{$L INT01H.OBJ}
Procedure Int01h;External;

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
 �                        Proc괺ure RunDebugPtr                    �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�


 Description
 袴袴袴袴袴�

  Cette proc괺ure est utilis� apr둺 un retour  d'une interruption de
 d괷oguage pas � pas du programme pour la restitution des donn괻s et
 une facilitation de retour au fen늯re d'application.
}

Procedure RunDebugPtr;Far;Begin
 DebugSkip:=Ya;
 ASM
  MOV CS:Word Ptr DataReg[4],SP
  MOV CS:Word Ptr DataReg[8],BP
  PUSH DebFlags
  POP AX
  OR  AX,1 shl 8
  PUSH AX
  MOV AX,DebAX
  MOV BX,DebBX
  MOV CX,DebCX
  MOV DX,DebDX
  MOV SI,DebSI
  MOV DI,DebDI
  MOV ES,DebES
  MOV BP,DebBP
  MOV DS,DebDS
  POPF
  JMP PrgInstr
 END;
End;

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
 �                        Proc괺ure XChgOutput                     �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�


 Description
 袴袴袴袴袴�

  Cette proc괺ure 괹hange l'image vid굊 avec l'image de sortie si le
 d괷ogueur utilise la syst둴e vid굊 primaire.
}

Procedure XChgOutput;Var MS:ImgRec;Begin
 If(DebugRec(HPtr(Windows)^).Monitor=Primary)Then Begin
  PushScr(MS);
  {$IFDEF HeapVram}HeapVram:=No;{$ENDIF}
  PopScr(Output);
  Output:=MS;
 End;
End;

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
 �                     Fonction RunDebugProgram                  �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�


 Description
 袴袴袴袴袴�

  Cette fonction prend  en charge l'action utilisateur et retour �
 l'application l'applant en cas d'une action au sens ext굍ieure du
 d괷oguage.
}

Function RunDebugProgram;Var K:Wd;Begin
 Repeat
  K:=WEReadk(DebugRec(HPtr(Windows)^).W);
  Case(K)of
   kbF7:Begin
    XChgOutput;
    RunDebugPtr;
    XChgOutput;
    DEPutData(DebugRec(HPtr(Windows)^));
   End;
   Else Begin
    RunDebugProgram:=K;
    Break;
   End;
  End;
 Until No;
End;

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴콘
 �                         Proc괺ure RunDebug                         �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複蔔


 Description
 袴袴袴袴袴�

  Cette proc괺ure est un appel pour pouvoir remprendre le contr뱇e plus
 facilement � pendant le lancement du programme � d괷oguer.
}

Procedure RunDebug;Far;Begin
 ASM
  {$IFDEF OldDebug}
   MOV CS:Word Ptr DataReg[2],DS
   MOV CS:Word Ptr DataReg[4],SP
   MOV CS:Word Ptr DataReg[6],SS
   MOV CS:Word Ptr DataReg[8],BP
  {$ENDIF}
  PUSHF
  POP AX
  OR  AX,1 shl 8
  PUSH AX
  XOR AX,AX
  XOR BX,BX
  XOR CX,CX
  XOR DX,DX
  XOR DI,DI
  XOR SI,SI
  XOR BP,BP
  POPF
  JMP PrgPtr
 END;
End;

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
 �                        Proc괺ure OpenDebugProgram                     �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�


 Description
 袴袴袴袴袴�

  Cette proc괺ure  charge  et d굆arre l'ex괹ution  du programme � d괷oguer
 jusqu'� sa premi둹e instruction. L�, il faudra reprendre avec la fonction
 췙unDebugProgram� du m늤e unit� pour pouvoir continuer l'ex괹ution.
}

Procedure OpenDebugProgram;
Var PPath:Array[Byte]of Char;Data:Array[Byte]of Byte;Begin
 If Path2Ext(Path)='.EXE'Then Begin
  ErrMsgOk('D굎ol�, seul les .COM peuvent 늯re d괷oguer');
  Exit;
 End;
 If Path2Ext(Path)='.COM'Then Begin
  FSDebug:=GetFileSize(Path)+256;
  ASM
   MOV BX,FSDebug
   {$IFOPT G+}
    SHR BX,4
   {$ELSE}
    SHR BX,1
    SHR BX,1
    SHR BX,1
    SHR BX,1
   {$ENDIF}
   INC BX
   INT $9B
   MOV PrgPtr.Word[2],AX
  END;
  If(PrgPtr=NIL)Then Begin
   __OutOfMemory;
   Exit;
  End;
  PrgPtr^[0]:=$CD;PrgPtr^[1]:=$20;
  GetFile(Path,0,FSDebug,PrgPtr^[256]);
  ASM MOV PrgPtr.Word,100h;END;
 End;
 GetIntVec($01,OldInt01h);
 Q.Name:=Path;Q.Monitor:=Primary;
 WEInit(Q.W,X1,Y1,X2,Y2);
 DEPutWn(Q);
 SetMnuSwitch;
 SetIntVec($01,@Int01h);
 DebugPrg:=Ya;
 RunDebug;
 DEPutData(Q);
End;

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴콘
 �                       Proc괺ure RefreshDebug                     �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複蔔


 Description
 袴袴袴袴袴�

  Cette proc괺ure r괶ctualise la fen늯re de d괷oguage actuellement en
 op굍ation sous l'application MonsterBook/PowerHacken.
}

Procedure RefreshDebug;Begin
 DEPutWn({WinPtr^.P.Debug}DebugRec(Q));
 DEPutData({WinPtr^.P.Debug}DebugRec(Q));
End;

Procedure DELoadProgram(Var Q;X1,Y1,X2,Y2:Byte;Const Path:String);Begin
 OpenDebugProgram(DebugRec(Q),Path,X1,Y1,X2,Y2);
End;

END.