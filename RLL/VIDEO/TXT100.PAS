Uses DrvTxt,Chantal,Systex,Systems,Video;

Procedure SplitScreen(Y:Wd);Begin
 ASM
  MOV BX,Y
  MOV CX,BX
  MOV DX,3D4h
  MOV AL,07h
  OUT DX,AL
  INC DX
  IN  AL,DX
  AND AL,11101111b
  {$IFOPT G+}
   SHR CX,4
  {$ELSE}
   SHR CX,1
   SHR CX,1
   SHR CX,1
   SHR CX,1
  {$ENDIF}
  AND CL,16
  OR  AL,CL
  OUT DX,AL
  DEC DX
  MOV AL,09h
  OUT DX,AL
  INC DX
  IN  AL,DX
  AND AL,10111111b
  {$IFOPT G+}
   SHR BL,3
  {$ELSE}
   SHR BL,1
   SHR BL,1
   SHR BL,1
  {$ENDIF}
  AND BL,64
  OR  AL,BL
  OUT DX,AL
  DEC DX
  MOV AL,18h
  MOV AH,Byte Ptr Y
  OUT DX,AX
 END;
End;

Var I:Wd;

BEGIN
 InitSystems(suIsabel);
 CheckSvga:=Ya;
{ ASM
  MOV AX,$2A
  INT $10
 END;
 WriteLn(Port[$3CC]);
 ReadKey;}
 SetVideoMode(vmTxtC132x100);
 ASM
  MOV AX,$24
  INT $10
  MOV AX,$1112
  MOV BL,0
  INT $10
 END;
 WriteLn(Port[$3CC]);
 Port[$3C2]:=Port[$3CC]or$E0;
 Port[$3D4]:=$11;Port[$3D5]:=Port[$3D5]and$7F;
 ASM
  CLI
  MOV DX,$3D4
  MOV CL,99
  MOV AX,$7806;OUT DX,AX{ 6-120 }
  MOV AX,$F007;
{  MOV AX,$F007;}
  OUT DX,AX{ 7-240 }
  MOV AX,$7F09
{  MOV AX,$6E09;}
  OUT DX,AX{09h-110}
  MOV AX,$5C10;
{  MOV AX,$5C10;}
  OUT DX,AX{10h-92 }
  MOV AX,$7E11;OUT DX,AX{11h-142}
  MOV AX,$5712
{  MOV AX,$5712;}
  OUT DX,AX{12h-87 }
  MOV AX,$5B15;OUT DX,AX{15h-91 }
  MOV AX,$7516;OUT DX,AX{16h-117 }
  MOV AX,$A317;OUT DX,AX{17h-163 }
  XOR AX,AX
  MOV ES,AX
  MOV ES:[$484].Byte,CL
  MOV AX,$4509;OUT DX,AX{9-69}
  MOV AX,$040A;OUT DX,AX{10-4}
  MOV AX,$050B;OUT DX,AX{11-5}
  MOV ES:[$485].Word,6
  STI
 END;
 Init;
 FillBox(0,1,131,99,'-',$70);
 FillBox(0,99,131,99,'+',$40);
 I:=0;
 Repeat
  SplitScreen(I);
  WaitRetrace;
  Inc(I);
 Until KeyPress;
 ASM
  XOR AX,AX
  INT 16h
 END;
END.