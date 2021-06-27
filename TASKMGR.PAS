{ Cette unit‚ permet de g‚rer le gestionnaire de tƒche de l'Open DOS ou
 du DR-DOS.
}

Unit TaskMgr;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                                  INTERFACE
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Const
 InvalidTaskID=$FFFF;

 DPMSServerFastReset=1;
 DPMSServerEnabled=2;
 DPMSServerMapped=4;

Type
 TaskName=String[8];

 DPMSServerStructure=Record
  ID:Array[1..4]of char; {'DPMS'}
  MajorVersion:Byte;
  MinorVersion:Byte;
  OEMName:Array[1..8]of Char;
  OEMMajorVersion:Byte;
  OEMMinorVersion:Byte;
  Flags:Word;
  CPU:Byte;
 End;

 PDPMSServerStructure=^DPMSServerStructure;

Function  DPMSInstalled:Boolean;
Function  DPMSInformation:PDPMSServerStructure;
Function  GetPerTaskEMSLimit:Word;
Procedure GetVersion(Var MajorVersion,MinorVersion:Byte);
Procedure GetSwapSpaceInfo(Var AvailableKB,TotalKB:Word);
Function  IDToIndex(ID:Word):Word;
Function  IndexToID(Index:Word):Word;
Procedure NameTask(TaskIndex:Word;Const Name:TaskName;
                   Var Flag:Byte;Var ID:Word);{ ''=Efface renome }
Function  ReleaseTimeSlice:Boolean; { Vrai: Fait; Faux: impossible }
Procedure SetPerTaskEMSLimit(Limit:Word;Var NewLimit:Word);
Function  TMCheckOpenFiles(TaskIndex:Word):Word;
Function  TMGetForegroundTaskIndex:Word;
Procedure TMGetStatus(Var Tasks,MaximumTasks,ForegroundTaskIndex:Word);
Function  TMGetTaskName(Index:Word):TaskName;
Function  TMInstall:Boolean;
Procedure TMSwitchTo(TaskIndex:Word);
Procedure TMSwitchToTaskManager;
Procedure TMTaskShell(Const ComLine:String);

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                              IMPLEMENTATION
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Uses Systems;

Const
 PseudoMaxTasks=5000;

Type
 IDTable=Array[0..PseudoMaxTasks]of Word;
 PIDTable=^IDTable;
 TaskNameC=Array[0..7]of Char;
 NameTable=Array[0..PseudoMaxTasks]of TaskNameC;
 PNameTable=^NameTable;

Function TMInstall:Boolean;Assembler;ASM
 MOV AX,02700h
 INT 02Fh
 CMP AL,0FFh
 MOV AL,000h
 JNZ @@F01non
 INC AX
@@F01non:
END;

Procedure TMGetstatus(Var Tasks,MaximumTasks,ForegroundTaskIndex:Word);Assembler;ASM
 MOV AX,02701h
 INT 02Fh
 LES DI,Tasks
 MOV ES:[DI],CX
 LES DI,MaximumTasks
 MOV ES:[DI],AX
 LES DI,ForegroundTaskIndex
 MOV ES:[DI],BX
END;

Procedure Getversion(Var MajorVersion,MinorVersion:Byte);Assembler;ASM
 MOV AX,02701h
 INT 02Fh
 LES DI,MajorVersion
 MOV ES:[DI],DL
 LES DI,MinorVersion
 MOV ES:[DI],DH
END;

Function GetNameTablePointer:PNameTable;Assembler;ASM
 MOV AX,02701h
 INT 02Fh
 MOV DX,ES
 XCHG AX,DI {resultat <- Pointeur(DX,AX) }
END;

Function TMGetForegroundTaskIndex:Word;Assembler;ASM
 MOV AX,02701h
 INT 02Fh
 XCHG AX,BX
END;

Function GetPerTaskEMSlimit:Word;Assembler;ASM
 MOV AX,02702h
 INT 02Fh
 XCHG AX,DX
END;

Procedure SetPerTaskEMSLimit(Limit:Word;Var NewLimit:Word);Assembler;ASM
 MOV AX,02703h
 MOV DX,Limit
 INT 02Fh
 LES DI,NewLimit
 MOV ES:[DI],DX
END;

Procedure TMSwitchTo(TaskIndex:Word);Assembler;ASM
 MOV AX,02706h
 MOV DX,TaskIndex
 INT 02Fh
END;

Procedure TMSwitchToTaskManager;Assembler;ASM
 MOV AX,02715h
 INT 02Fh
END;

Function ReleaseTimeSlice:Boolean;Assembler;ASM
 MOV AX,01680h
 INT 02Fh
 AND AX,AX
 MOV AL,0
 JNZ @PasDepret
 INC AX
@PasDepret:
END;

Function TMGetTaskName(Index:Word):TaskName;
Var
 R:TaskName;
 N:TaskNameC;
Begin
 N:=GetNameTablePointer^[Index];
 R:='';
 While(Length(R)<=7)and(N[length(R)]<>#0)do IncStr(R,N[Length(R)]);
 TMGetTaskName:=R
End;

Procedure NameTaskC(TaskIndex,NSeg,NOfs:Word;Var Flag:Byte;Var ID:Word);Assembler;ASM
 PUSH DS
  MOV AX,02709h
  MOV DX,TaskIndex
  MOV BX,NSeg
  MOV CX,NOfs
  MOV DS,BX
  MOV SI,CX
  INT 02Fh
  LES DI,Flag
  MOV ES:[DI],AL
  LES DI,ID
  MOV ES:[DI],BX
 POP DS
END;

Procedure NameTask(TaskIndex:Word;Const Name:TaskName;Var Flag:Byte;Var ID:Word);
Var
 NameC:TaskNameC;
 I,L:Byte;
Begin
 FillClr(NameC,SizeOf(NameC));
 L:=Length(Name);
 If L>8Then L:=8;
 For I:=1to(L)do NameC[I-1]:=Name[I];
 NameTaskC(TaskIndex,Seg(NameC),Ofs(NameC),Flag,ID)
End;

Function IndexToID(Index:Word):Word;Assembler;ASM
 MOV AX,0270Ah
 MOV DX,Index
 INT 02Fh
 XCHG AX,DX
END;

Function IDToIndex(ID:Word):Word;Assembler;ASM
 MOV AX,0270Bh
 MOV DX,ID
 INT 02Fh
 XCHG AX,DX
END;

Function TMCheckOpenFiles(TaskIndex:word):Word;Assembler;ASM
 MOV AX,0270Ch
 MOV DX,TaskIndex
 INT 02Fh
END;

Procedure GetSwapSpaceInfo(Var AvailableKB,TotalKB:Word);Assembler;ASM
 MOV AX,02714h
 INT 02Fh
 LES DI,AvailableKB
 MOV ES:[DI],DX
 LES DI,TotalKB
 MOV ES:[DI],CX
END;

Procedure TMTaskShell(Const ComLine:String);

 Procedure Command(Const CP:String);Begin
  SwapVectors;
  Exec(GetEnv('OPENDOSCFG')+'\TASKMGR.EXE','/C'+CP);
  SwapVectors
 End;

Begin
 If(TMInstall)Then Begin
  If ComLine=''Then Command(GetEnv('COMSPEC'))
               Else Command(ComLine)
 End;
End;

Function DPMSInstalled:Boolean;Assembler;ASM
 MOV AX,043E0h
 XOR BX,BX
 MOV CX,04450h
 MOV DX,04D53h
 INT 02Fh
 AND AX,AX
 MOV AL,0
 JNZ @@DPMS01non
 INC AX
@@DPMS01non:
END;

Function DPMSInformation:PDPMSServerStructure;Assembler;ASM
 MOV AX,043E0h
 XOR BX,BX
 MOV CX,04450h
 MOV DX,04D53h
 INT 02Fh
 AND AX,AX
 MOV AX,0
 MOV DX,AX
 JNZ @@DPMS02non
 MOV DX,ES
 XCHG AX,DI
@@DPMS02non:
END;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
END.
