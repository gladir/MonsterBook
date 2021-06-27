Uses Video,DrvTxt,Systex;

Const PtrDrv:Pointer=@_DriverTxt;
Var I,J,X,Y,XDir,YDir,IDir:Wd;

Procedure SplitScreen(Y:Wd);Assembler;ASM
 XOR AX,AX
 MOV ES,AX
 MOV DX,ES:[463h]
 MOV BX,Y
 MOV CX,BX
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

{$I ..\Library\KeyPress.Inc}
{$I ..\Library\Str.Inc}

BEGIN
 ASM
  MOV AX,7
  INT $10
 END;
 ASM
  LES DI,PtrDrv
  MOV ES:[DI+166].PIV.EGA,Ya
  MOV ES:[DI+166].PIV.VGA,Ya
 END;
 Init;
 SetChrWidth(9);
 SetBytesPerLn(320);
 FillBox(0,0,159,49,'þ',$70);
 PutTxtXY(8,8,'Salut',$1F);
{ SetVisualPg(1);}
 SetPg(1);
 FillBox(0,0,159,49,'-',7);
 For J:=0to 49do For I:=0to 15do PutTxtXYUnKr(10*I,J,Str(I));
 X:=0;XDir:=1;
 Y:=0;YDir:=1;I:=0;IDir:=1;
 Repeat
  Inc(X,XDir);
  Inc(Y,YDir);
  Inc(I,IDir);
  If(I<=0)or(I>=25*16)Then IDir:=-IDir;
  If(X<=0)or(X>=80*9)Then XDir:=-XDir;
  If(Y<=0)or(Y>=25*16)Then YDir:=-YDir;
  SplitScreen(I);
  SetVerticalScale(Y);
  SetHorizontalScale(X);
 Until KeyPress;
 ASM
  XOR AX,AX
  INT $16
  MOV AX,3
  INT $10
 END;
END.