Uses Systex,Systems,DrvVESA;

{{{{$M 16384,0,0}

{$DEFINE _640}

Var I:Word;Buffer:Array[0..255]of Byte;

BEGIN
 InitSystems(suIsabel);
 For I:=0to 255do Buffer[I]:=I;
 ASM
  {$IFDEF _640}MOV AX,$5F      {  $5C} {$ELSE}MOV AX,$38{$ENDIF}
  INT $10
 END;
 Init;
 BarSpcHor(0,0,3,$C0);
 ClrWn(4,4,{$IFDEF _640}78,24{$ELSE}120,44{$ENDIF},$B0);
 For I:=0to {$IFDEF _640}79{$ELSE}127{$ENDIF}do SetGCubeT(I shl 3,4*16,'M',$5);
 PutTxtXY(8,8,'Salut',$90);
 FillBox(10,10,{$IFDEF _640}70,20{$ELSE}121,40{$ENDIF},'@',$7E);
 SetPixel(512,70,$C);
 {$IFDEF _640}
  For I:=300to 399do
 {$ELSE}
  For I:=600to 699do
 {$ENDIF}
  PutLnHor(257,I,{$IFDEF _640}350{$ELSE}800{$ENDIF},$9);
 {$IFDEF _640}
  For I:=200to 479do
 {$ELSE}
  For I:=700to 767do
 {$ENDIF}
  ClrLnHorImg(0,I,256,8,Buffer);
 For I:=0to 479do Begin
  GetLnHorImg(0,I,640,Buffer);
  ClrLnHor(0,I,640,0);
  ClrLnHorImg(0,I,640,8,Buffer);
 End;
 Done;
 DoneSystems;
END.