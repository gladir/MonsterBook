{$M 16384,0,65536}

Uses Dos;

Procedure CheckNameFCB(Var Param,FCB);Assembler;ASM
 PUSH DS
  MOV AX,2901h
  LDS SI,Param
  LES DI,FCB
  INT 21h
 POP DS
END;

Procedure SaveCPURegisters;Assembler;ASM
 DW 0 { SS }
 DW 0 { SP }
 DW 0 { BP }
 DW 0 { DS }
END;

Procedure Exec(Name,Param:String);
Type
 SaveCPURegistersRec=Record
  SS:Word;
  SP:Word;
  BP:Word;
  DS:Word;
 End;
Var
 DataParam:Record
  AddrEnv:Word;
  Command:Pointer;
  FCB1:Pointer;
  FCB2:Pointer;
  FCBData1:Array[0..36]of Byte;
  FCBData2:Array[0..36]of Byte;
 End;
Begin
 FillChar(DataParam,SizeOf(DataParam),0);
 Param:=Param+^M;
 Name:=Name+#0;
{ CheckNameFCB(Param[1],DataParam.FCBData1);
 CheckNameFCB(Param[1],DataParam.FCBData2);}
 DataParam.Command:=@Param;
 DataParam.FCB1:=@DataParam.FCBData1;
 DataParam.FCB2:=@DataParam.FCBData2;
 ASM
  MOV Word Ptr SaveCPURegisters.SaveCPURegistersRec.&SS,SS
  MOV Word Ptr SaveCPURegisters.SaveCPURegistersRec.&SP,SP
  MOV Word Ptr SaveCPURegisters.SaveCPURegistersRec.&BP,BP
  MOV Word Ptr SaveCPURegisters.SaveCPURegistersRec.&DS,DS
  PUSH SS
  POP ES
  MOV BX,Offset DataParam
  ADD BX,BP
  PUSH SS
  POP DS
  MOV DX,Offset Name[1]
  ADD DX,BP
  MOV AX,04B00h
  INT 21h
  MOV SS,Word Ptr SaveCPURegisters.SaveCPURegistersRec.&SS
  MOV SP,Word Ptr SaveCPURegisters.SaveCPURegistersRec.&SP
  LDS BP,DWord Ptr SaveCPURegisters.SaveCPURegistersRec.&BP
 END;
End;

Procedure SwapVectors;Assembler;
Const
 Intr:Array[0..18]of Byte=(
  $00,$02,$1B,$21,$23,
  $24,$34,$35,$36,$37,
  $38,$39,$3A,$3B,$3C,
  $3D,$3E,$3F,$75
 );
ASM
 XOR AX,AX
 MOV ES,AX
 MOV CX,TYPE Intr
 CLD
 MOV DI,Offset SaveInt00
 MOV SI,Offset Intr
@1:
 LODSB
 MOV AH,35h
 INT 21h
 PUSH ES
  PUSH BX
   PUSH DS
    LDS DX,[DI]
    MOV AH,025h
    INT 21h
   POP DS
  POP Word Ptr [DI]
 POP Word Ptr [DI+2]
 ADD DI,0004h
 LOOP @1
END;

BEGIN
 SwapVectors;
{ Exec('C:\COMMAND.COM','');}
 Exec('D:\SYMANTEC\NC3\NC.EXE','');
 SwapVectors;
 WriteLn('Fin du programme');
END.