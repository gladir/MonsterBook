BEGIN
 ASM
  MOV AX,3
  INT $10
 END;
{ Port[$3C0]:=$10;Port[$3C1]:=$40;
 Port[$3CE]:=$5;Port[$3CF]:=Port[$3CF]or$40;
 Port[$3CE]:=$6;Port[$3CF]:=Port[$3CF]and Not(12)+4;}
 Port[$3C4]:=$02;Port[$3C5]:=1;
 FillChar(Mem[$B800:0],$FF,$C);
 ASM
  XOR AX,AX
  INT $16
  MOV AX,3
  INT $10
 END;
END.