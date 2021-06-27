Uses Drv2,Systex,Systems;

Const PtrDrv:Pointer=@_Driver2;
Var I:Word;Buffer:Array[0..255]of Byte;Int43h:Pointer;

{Procedure Icon;Assembler;ASM
 DB 11111111b,11111111b,11111111b,11111111b,11111111b
 DB 11000000b,00000000b,01000000b,00000000b,01000001b
 DB 10100000b,00000000b,10100000b,00000000b,10100001b
 DB 10010000b,00000001b,00010000b,00000001b,00010001b
 DB 10001000b,00000010b,00001000b,00000010b,00001001b
 DB 10000100b,00000100b,00000100b,00000100b,00000101b
 DB 10000010b,00001000b,00000010b,00001000b,00000011b
 DB 10000001b,00010000b,00000001b,00010000b,00000001b
 DB 10000000b,10100000b,00000000b,10100000b,00000001b
 DB 10000000b,10100000b,00000000b,10100000b,00000001b
 DB 10000000b,01000000b,00000000b,01000000b,00000001b
 DB 11111111b,11111111b,11111111b,11111111b,11111111b
END;}

Const Icon:Array[0..6*17-1]of Byte=(
$00,$00,$00,$00,$00,$00,{0}
$00,$00,$F4,$09,$10,$00,{1}
$00,$04,$00,$00,$10,$00,{2}
$00,$01,$00,$00,$40,$00,{3}
$00,$00,$44,$11,$00,$00,{4}
$00,$00,$15,$54,$00,$00,{5}
$00,$00,$55,$55,$00,$00,{6}
$00,$01,$45,$45,$40,$00,{7}
$00,$05,$41,$41,$50,$00,{8}
$00,$55,$55,$55,$55,$00,{9}
$00,$41,$55,$55,$41,$00,{10}
$00,$40,$50,$05,$01,$00,{11}
$00,$41,$51,$45,$41,$00,{12}
$00,$44,$05,$50,$11,$00,{13}
$00,$44,$01,$40,$11,$00,{14}
$00,$41,$00,$00,$41,$00,{15}
$00,$40,$40,$01,$01,$00);{16}


BEGIN
 InitSystems(suIsabel);
 For I:=0to 255do Buffer[I]:=I;
 ASM
  MOV AX,6
  INT $10
 END;
 Int43h:=TableInt[$43];
 ASM
  LES DI,PtrDrv
  MOV ES:[DI+241].MIV.Mode,vmGrf640x200c2
  MOV AX,Int43h.Word
  MOV ES:[DI+241].MIV.TxtMtx.Word,AX
  MOV AX,Int43h.Word[2]
  MOV ES:[DI+241].MIV.TxtMtx.Word[2],AX
 END;
{ ASM
  MOV AX,17
  INT $10
 END;
 Int43h:=TableInt[$43];
 ASM
  LES DI,PtrDrv
  MOV ES:[DI+169].MIV.Mode,vmGrf640x480c2
  MOV AX,Int43h.Word
  MOV ES:[DI+169].MIV.TxtMtx.Word,AX
  MOV AX,Int43h.Word[2]
  MOV ES:[DI+169].MIV.TxtMtx.Word[2],AX
 END;}
 Init;
{ FillBnk(0,16000,$1);}
 BarSpcHor(0,0,3,$C0);
 BarSpcVer(3,1,23,$70);
 ClrWn(4,4,12{0},5{4},$F0);
 SetPixel(0,31,1);
 For I:=0to 12{7}do SetGCubeT(I shl 3,{4*}16,'M',$5);
 For I:=0to 12{7}do SetGCube(I shl 4,{4*}32,'A',$F0);
 PutTxtXY(8,8,'Salut',$90);
 For I:=0to 7do PutLnHor(I,100+I,111,1);
 For I:=0to 7do PutLnHor(I,120+I,103+I,1);
 For I:=0to 7do PutLnHor(I,140+I,7,1);
 For I:=0to 7do Copy8Bin(I,99-I,$AA,1,0);
 For I:=0to 24do FillBox(15,I,79,I,Chr(I),$F0);
 For I:=0to 7do PutLnHor(200+I,I,231+I,0);
 SetPixel(239,7,0);
 PutSmlImg(0,150,6*8-1,150+16,Icon);
{ PutSmlImg(0,150,5*8-1-1,161,Mem[Seg(Icon):Ofs(Icon)]);
 PutSmlImg(0,162,5*8-1,173,Mem[Seg(Icon):Ofs(Icon)]);
 PutSmlImg(2,174,2+5*8-1,185,Mem[Seg(Icon):Ofs(Icon)]);
 GetSmlImg(2,174,2+5*8-1,185,Mem[Seg(Icon):Ofs(Icon)]);
 PutSmlImg(0,0,5*8-1,11,Mem[Seg(Icon):Ofs(Icon)]);}
 MoveText(40,3,40+9,3+19-1,40,3+1);
 MoveText(61,3+1,69,3+19-1,61,3);
{ FillBox(10,10,121,40,'@',$7E);
 SetPixel(512,70,$C);
 For I:=600to 699do PutLnHor(257,I,800,$9);
 For I:=700to 767do ClrLnHorImg(0,I,256,8,Buffer);}
 Done;
 DoneSystems;
END.