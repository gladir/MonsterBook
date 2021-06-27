Var
 NtwRec:Record
  Command:Byte;
  FirstReturn:Byte;
  SessionNum:Byte;
  Num:Byte;
  Buffer:Pointer;
  Len:Word;
  FarName:Array[0..15]of Char;
  LocalName:Array[0..15]of Char;
  ToReception:Byte;
  ToEmission:Byte;
  PointerPost:Pointer;
  Adaptor:Byte;
  LastReturn:Byte;
  Reserved:Array[0..13]of Byte;
 End;

BEGIN
 FillChar(NtwRec,SizeOf(NtwRec),0);
 NtwRec.Command:=$90;
 ASM
  PUSH SS
  POP ES
  MOV BX,Offset NtwRec
  INT 5Ch
 END;
END.