Unit DrawMove;

INTERFACE

Uses Isatex;

Procedure DWRotate90(Var Q:DrawEditApp);
Procedure DWRotate180(Var Q:DrawEditApp);
Procedure DWRotate270(Var Q:DrawEditApp);

IMPLEMENTATION

Uses Adele,Math;

Procedure DWRotate90(Var Q:DrawEditApp);
Var
 SizeImage:LongInt;
Begin
 SizeImage:=Mul2Word(Q.Canvas.Res.BytesPerLine,Q.Canvas.Res.NumYPixels);
 Case(Q.Canvas.Res.BitsPerPixel)of
  15,16:Begin

  End;
 End;
 Case(BitsPerPixel)of{Traitement de l'image Miroir}
  8:Begin
  End;
 End;
End;

Procedure DWRotate180(Var Q:DrawEditApp);Begin
End;

Procedure DWRotate270(Var Q:DrawEditApp);Begin
End;

END.
