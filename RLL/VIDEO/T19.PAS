BEGIN
 ASM
  MOV AX,13h
  INT 10h
 END;
 Port[$3CE]:=$05;
 Port[$3CF]:=$40;
 PortW[$3CE]:=($1shl 8)+8;
 PortW[$3C4]:=$F02;
 FillChar(Mem[$A000:0],32000,$FF);
 ASM
  XOR AX,AX
  INT 16h
 END;
END.