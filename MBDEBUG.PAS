{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                                                               Û
 ³                   Monster Book/Debogueur                      Û
 ³ Malte Genesis/Edition Chantal pour Mode R‚el/IV - Version 1.2 Û
 ³                          1997/02/18                           Û
 ³                                                               Û
 ³      Tous droits r‚serv‚ par les Chevaliers de Malte (C)      Û
 ³                                                               Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Nom des programmeurs
 ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ

  Sylvain Maltais ainsi que Dieu Tout-Puissant


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette unit‚ est la base mˆme du d‚bogueur ne pouvant surtout pas
 ce promener all‚grement  dans la m‚moire sous risque de plantage.
 Alors hors de sa vue le recouvrement de cette unit‚.  Vous pouvez
 l'appelez quand mˆme pour  que l'application MonsterBook ou Power
 Hacken puissent suive  des programmes  pas … pas  et ‚liminer les
 problŠmes de comportement … votre ‚gard.
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

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Proc‚dure DoneDebug                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure d‚branche les m‚canismes de d‚boguage et ‚limine les
 donn‚es m‚moire ainsi que vid‚o en r‚sultat.
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

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                      Enregistrement DataReg                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure  est r‚alit‚  un enregistrement contenu les variables
 crucialement pour repartir l'application MonsterBook/PowerHacken aprŠs
 une ex‚cution plus ou moins brŠve du programme … d‚boguer.
}

Procedure DataReg;Assembler;ASM
 DD FSDebug
 DD 0
 DW 0
END;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                             Proc‚dure EndPoint                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure est un branchement permettant … l'application MonsterBook/
 PowerHacken de reprendre  le contr“le tout  de suite aprŠs un d‚clenchement
 d'interruption 01h de d‚boguage pas … pas.
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

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Interruption 01h                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure est en faŒte une interruption visant … effectuer un
 d‚boguage pas … pas du programme.
}

{$L INT01H.OBJ}
Procedure Int01h;External;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Proc‚dure RunDebugPtr                    Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure est utilis‚ aprŠs un retour  d'une interruption de
 d‚boguage pas … pas du programme pour la restitution des donn‚es et
 une facilitation de retour au fenˆtre d'application.
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

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Proc‚dure XChgOutput                     Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure ‚change l'image vid‚o avec l'image de sortie si le
 d‚bogueur utilise la systŠme vid‚o primaire.
}

Procedure XChgOutput;Var MS:ImgRec;Begin
 If(DebugRec(HPtr(Windows)^).Monitor=Primary)Then Begin
  PushScr(MS);
  {$IFDEF HeapVram}HeapVram:=No;{$ENDIF}
  PopScr(Output);
  Output:=MS;
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                     Fonction RunDebugProgram                  Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction prend  en charge l'action utilisateur et retour …
 l'application l'applant en cas d'une action au sens ext‚rieure du
 d‚boguage.
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

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Proc‚dure RunDebug                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure est un appel pour pouvoir remprendre le contr“le plus
 facilement … pendant le lancement du programme … d‚boguer.
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

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Proc‚dure OpenDebugProgram                     Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure  charge  et d‚marre l'ex‚cution  du programme … d‚boguer
 jusqu'… sa premiŠre instruction. L…, il faudra reprendre avec la fonction
 ®RunDebugProgram¯ du mˆme unit‚ pour pouvoir continuer l'ex‚cution.
}

Procedure OpenDebugProgram;
Var PPath:Array[Byte]of Char;Data:Array[Byte]of Byte;Begin
 If Path2Ext(Path)='.EXE'Then Begin
  ErrMsgOk('D‚sol‚, seul les .COM peuvent ˆtre d‚boguer');
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

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                       Proc‚dure RefreshDebug                     Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure r‚actualise la fenˆtre de d‚boguage actuellement en
 op‚ration sous l'application MonsterBook/PowerHacken.
}

Procedure RefreshDebug;Begin
 DEPutWn({WinPtr^.P.Debug}DebugRec(Q));
 DEPutData({WinPtr^.P.Debug}DebugRec(Q));
End;

Procedure DELoadProgram(Var Q;X1,Y1,X2,Y2:Byte;Const Path:String);Begin
 OpenDebugProgram(DebugRec(Q),Path,X1,Y1,X2,Y2);
End;

END.