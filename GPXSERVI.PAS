Unit GPXServices;

INTERFACE

Uses Isatex;

Procedure SaveImage(X1,Y1,X2,Y2,BitsPerPixel:Word;Const FileName:String);

IMPLEMENTATION

Uses Adele,Systex,Systems,Video;

Procedure SaveImage;Var Buffer:^TByte;SizeBuf,I2,I,J,L,Len:Wd;Handle:Hdl;PP,VP:Long;HeaderGPX:GPXHeader;Begin
 HeaderGPX.Sign:='GPX'#26;HeaderGPX.Len:=X2-X1+1;
 HeaderGPX.Height:=Y2-Y1+1;HeaderGPX.Ln:=HeaderGPX.Height shr 3;
 HeaderGPX.BitsPerPixel:=BitsPerPixel;
 SizeBuf:=X2-X1+1;Buffer:=MemAlloc(SizeBuf);
 If(Buffer<>NIL)Then Begin
  Handle:=NewNBak(FileName);
  If(Handle<>errHdl)Then Begin
   PP:=SizeOf(HeaderGPX);Len:=(X2-X1+1)shr 3;
   VP:=SizeOf(HeaderGPX)+SizeBuf*((Y2-Y1+1)shr 3);
   _SetAbsRec(Handle,0,SizeOf(HeaderGPX),HeaderGPX);
   For L:=0to(Y2-Y1)shr 3do Begin
    FillClr(Buffer^,SizeBuf);
    For I:=0to(X2-X1)do For J:=0to 7do
     Buffer^[I]:=Buffer^[I]or(Byte(GetPixel(X1+I,Y1+(L shl 3)+7-J)=$F)shl J);
    _SetAbsRec(Handle,PP,SizeBuf,Buffer^);
    Inc(PP,SizeBuf);
    FillClr(Buffer^,SizeBuf);
    For J:=0to 7do For I:=0to(X2-X1+1)shr 3do For I2:=0to 7do Begin
     Buffer^[Len*J+I]:=Buffer^[Len*J+I]or
      (Byte(GetPixel(X1+(I shl 3)+7-I2,Y1+(L shl 3)+J)=$F)shl I2);
    End;
    _SetAbsRec(Handle,VP,SizeBuf,Buffer^);
    Inc(VP,SizeBuf);
   End;
   Close(Handle);
  End;
  FreeMem(Buffer,SizeBuf);
 End;
End;

END.