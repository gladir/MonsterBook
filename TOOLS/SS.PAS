{$M 16384,0,0}

Uses Systex,Dos,Systems;

Function GetPixel(X,Y:Integer):Word;Assembler;ASM
 MOV AH,0Dh
 MOV BH,0
 MOV CX,X
 MOV DX,Y
 INT 10h
 MOV AH,0
END;

Procedure GetPaletteVGA(Var Palette;Start,Num:Word);Near;Assembler;ASM
 MOV AX,$1017
 LES DX,Palette
 MOV BX,Start
 MOV CX,Num
 INT $10
END;

Procedure Save;Var Handle:Hdl;I,J:Word;Buffer:Array[0..767]of Byte;Begin
 Handle:=New('TEST.DRW');
 If Mem[$0040:$49]=$10Then For J:=0to 349do Begin
  For I:=0to 639do Buffer[I]:=GetPixel(I,J);
  SetRec(Handle,J,640,Buffer);
 End
  Else
 If Mem[$0040:$49]=$13Then Begin
  GetPaletteVGA(Buffer,0,256);
  SetFile('PAL.DRW',0,768,Buffer);
  _SetAbsRec(Handle,0,64000,Mem[$A000:0]);
 End;
 Close(Handle);
End;

Procedure PrintScrn;Interrupt;Begin
 Save;
End;

Procedure NewInt1Ch;Interrupt;Begin
 If Port[$60]=$02Then Begin
  Save;
 End;
End;

BEGIN
 Dos.SetIntVec($5,@PrintScrn);
 Dos.SetIntVec($1C,@NewInt1Ch);
 WriteLn('Scrn Saver Install‚e.');
 Keep(0);
END.