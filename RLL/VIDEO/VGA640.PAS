BEGIN
 ASM
  MOV AX,$13
  INT $10
 END;
 Port[$3C4]:=1;Port[$3C5]:=Port[$3C5]and Not(1 shl 3);
{ Port[$3CE]:=$6;Port[$3CF]:=Port[$3CF]and Not(12)+8+4;}
 Mem[$A000:0]:=$C;
{ Mem[$B000:0]:=$E;}
 ASM
  XOR AX,AX
  INT $16
 END;
END.