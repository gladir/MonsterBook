Program TestCPU;

Uses Adele,Systex,Systems,Video,Dials;

Var
 OutputIPOfs:Word;

Procedure Int06h(Flags,CS,IP,AX,BX,CX,DX,SI,DI,DS,ES,BP:Word);Interrupt;Begin
 IP:=OutputIPOfs;
End;

Function TestSETALC:Boolean;
Label Xit;
Begin
 TestSETALC:=False;
 ASM
  MOV OutputIPOfs,Offset Xit
 END;
 InLine($D6); { SETALC }
 TestSETALC:=True;
Xit:
End;

Function TestUMOV:Boolean;
Label Xit;
Begin
 TestUMOV:=False;
 ASM
  MOV OutputIPOfs,Offset Xit
  DB  0Fh,010h,0D8h { MOV AL,BL }
  NOP
  NOP
  NOP
  NOP
 END;
 TestUMOV:=True;
Xit:
End;

Function TestXBTS:Boolean;
Label Xit;
Begin
 TestXBTS:=False;
 ASM
  MOV OutputIPOfs,Offset Xit
  MOV AX,1
  MOV BX,AX
  MOV CL,1
  MOV DX,AX
  DB  0Fh,0A6h,0DAh { XBTS BX,DX,AX,AL }
  NOP
  NOP
 END;
 TestXBTS:=True;
Xit:
End;

Function TestIBTS:Boolean;
Label Xit;
Begin
 TestIBTS:=False;
 ASM
  MOV OutputIPOfs,Offset Xit
  MOV AX,1
  MOV BX,AX
  MOV CL,1
  MOV DX,AX
  DB  0Fh,0A7h,0DAh { IBTS BX,DX,AX,AL }
  NOP
  NOP
 END;
 TestIBTS:=True;
Xit:
End;

Function TestRDTSC:Boolean;
Label Xit;
Begin
 TestRDTSC:=False;
 ASM
  MOV OutputIPOfs,Offset Xit
  DB 66h; XOR AX,AX { XOR EAX,EAX }
  DB 66h; XOR DX,DX { XOR EDX,EDX }
  DB  0Fh,031h      { RDTSC }
  NOP
  NOP
  NOP
  NOP
 END;
 TestRDTSC:=True;
Xit:
End;

Function TestAAMx:Boolean;
Label Xit;
Begin
 TestAAMx:=False;
 ASM
  MOV OutputIPOfs,Offset Xit
  MOV AX,0FF12h
  DB  0D4h,008h { AAM 8 }
  NOP
  NOP
  NOP
  NOP
  CMP AX,0202h
  JNE Xit
 END;
 TestAAMx:=True;
Xit:
End;

Function TestAADx:Boolean;
Label Xit;
Begin
 TestAADx:=False;
 ASM
  MOV OutputIPOfs,Offset Xit
  MOV AX,00705h
  DB  0D5h,010h { AAD 10h }
  NOP
  NOP
  NOP
  NOP
  CMP AX,0075h
  JNE Xit
 END;
 TestAADx:=True;
Xit:
End;

Function TestCPUID:Boolean;
Label Xit;
Begin
 TestCPUID:=False;
 ASM
  MOV OutputIPOfs,Offset Xit
  DB  66h;XOR AX,AX { XOR EAX,EAX }
  DB  00Fh,0A2h     { CPUID }
  NOP
  NOP
  NOP
  NOP
 END;
 TestCPUID:=True;
Xit:
End;

Function TestBSWAP:Boolean;
Label Xit;
Begin
 TestBSWAP:=False;
 ASM
  MOV OutputIPOfs,Offset Xit
  DB  00Fh,0C8h { BSWAP EAX }
  NOP
  NOP
  NOP
  NOP
 END;
 TestBSWAP:=True;
Xit:
End;

Procedure CheckUndocInstr;
Var
 OldInt06h:Pointer;
Begin
 If(CPU<cpu80286)Then ErrMsgOk('Microprocesseur 80286 ou plus requis')
  Else
 Begin
  GetIntVec($06,OldInt06h);
  SetIntVec($06,@Int06h);
  WriteLn('Teste avanc‚ des instructions du CPU');
  WriteLn;
  WriteLn('(D5h,xxh) AAD xxh: ',TestAADx);
  WriteLn('(D4h,xxh) AAM xxh: ',TestAAMx);
  WriteLn('(0Fh,C8h) BSWAP:   ',TestBSWAP);
  WriteLn('(0Fh,A2h) CPUID:   ',TestCPUID);
  WriteLn('(0Fh,A7h) IBTS:    ',TestIBTS);
  WriteLn('(0Fh,31h) RDTSC:   ',TestRDTSC);
  WriteLn('(D6h)     SETALC:  ',TestSETALC);
  WriteLn('(0Fh,1xh) UMOV:    ',TestUMOV);
  WriteLn('(0Fh,A6h) XBTS:    ',TestXBTS);
  SetIntVec($06,OldInt06h);
 End;
End;

BEGIN
 InitSystems(suIsabel);
 InitVideoDeluxe;
 CheckUndocInstr;
 UnLuxe;
END.