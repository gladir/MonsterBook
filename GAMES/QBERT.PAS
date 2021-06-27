Program QBert;

Uses Chantal,Systex,Systems,Video,GoldNaxe;

Var

    ManBackSize   : Word;
    ManBackBuffer : Pointer;
    ManSize,K : Word;
    ManBuffer : Pointer;

Procedure SaveImage;
Begin
 PutFillCircle(9,9,8,255);
 ManBackSize:=GetSizeSmlImg(0,0,19,19);
 GetMem(ManBackBuffer,ManBackSize);
 GetSmlImg(0,0,19,19,ManBackBuffer^);
 PutSmlImg(0,0,19,19,ManBackBuffer^);
 GetSmlImg(0,0,19,19,ManBackBuffer^);
 PutSmlImg(0,0,19,19,manBackBuffer^);
 PutFillCircle(9,9,8,15);
 ManSize:=GetSizeSmlImg(0,0,19,19);
 GetMem(ManBuffer,ManSize);
End;

Procedure PutBrick(X,Y,L:Integer);
Var HL : Integer;
Begin
 _SetKr(15);
 HL := (L shr 1);
 _Move2(X,Y);
 _Ln2(X+L,Y+HL);
 _Ln2(X,Y+L);
 _Ln2(X-L,Y+HL);
 _Ln2(X,Y);
 _Move2(X-L,Y+HL);
 _Ln2(X-L,Y+L+HL);
 _Ln2(X,Y+(L shl 1));
 _Ln2(X,Y+L);
 _Move2(X,Y+(L shl 1));
 _Ln2(X+L,Y+L+HL);
 _Ln2(X+L,Y+HL);
{ SetFullPattern(57);
 FloodFill(X,Y+1,15);
 SetFullPattern(1);
 FloodFill(X-3,Y+L,15);
 SetFullPattern(9);
 FloodFill(X+3,Y+L,15);}
End;

Procedure PutPyramid(X,Y,L:Integer);
Var I,S : Byte;
    J   : Integer;
Begin
 For I := 0 to 6 do
 Begin
  S := 0;
  For J := -I to I do
  Begin
   If(S = 0)Then PutBrick(X+(J*L),Y+(L+(L shr 1))*I,L);
   S := (S + 1) and 1;
  End;
 End;
End;

BEGIN
 InitSystems(suIsabel);
 SetVideoModeDeluxe(vmGrf320x200c256);
 SaveImage;
 PutPyramid(GetMaxX shr 1,0,15);
 PutSprite(149,20,149+19,20+19,ManBackBuffer^);
 _Move2(0,0);
 Draw('R319D199L319U199');
 K:=ReadKey;
 DoneLuxeVideo;
END.