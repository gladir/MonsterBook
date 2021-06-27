Program CheckBMPin16for19Mode;

Uses Systems,Systex,Drv19;

Const PtrDrv:Pointer=@_Driver19;
Var Int43h:Pointer;
Var HBMP:HeaderBMP;Handle:Hdl;Size:Long;I,J:Word;
    Buffer:Array[0..32767]of Byte;

BEGIN
 InitSystems(suIsabel);
 ASM
  MOV AX,$13
  INT $10
 END;
 Int43h:=TableInt[$43];
 ASM
  LES DI,PtrDrv
  MOV AX,Int43h.Word
  MOV ES:[DI+250].MIV.TxtMtx.Word,AX
  MOV AX,Int43h.Word[2]
  MOV ES:[DI+250].MIV.TxtMtx.Word[2],AX
 END;
 Init;
 Handle:=Open('\SOURCE\CHANTAL\GAMES\WORLD0.BMP',fmRead);
 GetRec(Handle,0,SizeOf(HeaderBMP),HBMP);
 If HBMP.Sign<>'BM'Then WriteLn('Ce n''est pas un fichier BitMap')
  Else
 Begin
  Size:=HBMP.Size-14;
  If Size>SizeOf(Buffer)Then Size:=SizeOf(Buffer);
  _GetAbsRec(Handle,HBMP.OffBits,Size,Buffer);
  I:=0;
  For J:=159downto 0do Begin
   ClrLnHorImg(0,J,159,4,Buffer[I]);
   Inc(I,80);
  End;
{  For J:=0to 159do For I:=0to 79do Begin
   SetPixel(I shl 1,J,Buffer[J*80+I]shr 4);
   SetPixel((I shl 1)+1,J,Buffer[J*80+I]and$F);
  End;}
 End;
 Close(Handle);
 ReadKey;
 Done;
 DoneSystems;
END.