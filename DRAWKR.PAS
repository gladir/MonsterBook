Unit DrawKr;

INTERFACE

Uses Systex,Isatex;

Function  ChoiceRGBColor(Var Q:RGB):Boolean;
Procedure DWBrightnessContrast(Var Q:DrawEditApp);
Procedure DWChannelMixer(Var Q:DrawEditApp);
Procedure DWLoadPalette(Var Q:DrawEditApp);

IMPLEMENTATION

Uses
 Adele,Video,Systems,Math,Dialex,DialPlus,Restex,ResServI,DrawEdit,Dials;

{ Cette proc‚dure permet d'ajuster le luminosit‚ et la contraste d'une
 image du programme de dessin.
}

Procedure DWBrightnessContrast(Var Q:DrawEditApp);
Var
 FormBrightnessContrast:Record
  Brightness:MScrollBar; { Luminosit‚ }
  Contrast:MScrollBar;   { Contraste }
 End;
 Tab:Array[0..255]of Byte;

 Procedure ComputeContrast;
 Var
  I:Integer;
  X,Y:Word;
 Begin
  X:=FormBrightnessContrast.Contrast.Position shr 5;
  For I:=0to Q.Canvas.Res.NumPal-1do Begin
   Y:=((I shr X)shl X)+FormBrightnessContrast.Brightness.Position;
   If Y>255Then Y:=255;
   Tab[I]:=Y;
  End;
 End;

 Procedure ComputePalette256;
 Var
  I:Integer;
 Begin
  If(Q.Canvas.PaletteRGB<>NIL)Then Begin
   For I:=0to Q.Canvas.Res.NumPal-1do Begin
    Q.Canvas.PaletteRGB^[I].R:=Tab[Q.Canvas.PaletteRGB^[I].R];
    Q.Canvas.PaletteRGB^[I].G:=Tab[Q.Canvas.PaletteRGB^[I].G];
    Q.Canvas.PaletteRGB^[I].B:=Tab[Q.Canvas.PaletteRGB^[I].B];
   End;
   XSetAbsRec(Q.Canvas.Image,SizeOf(ImageHeaderRes)+
              Mul2Word(Q.Canvas.Res.BytesPerLine,Q.Canvas.Res.NumYPixels),
              Q.Canvas.Res.NumPal*3,Q.Canvas.PaletteRGB^);
  End;
 End;

 Procedure Compute16;
 Var
  I,J:Integer;
  Buffer:Array[0..2047]of Word;
  Color:RGB;
  P:LongInt;
  X:Word;
 Begin
  If Q.Canvas.Res.BytesPerLine<=SizeOf(Buffer)Then Begin
   P:=SizeOf(ImageHeaderRes);
   For J:=0to(Q.Canvas.Res.NumYPixels)do Begin
    XGetAbsRec(Q.Canvas.Image,P,Q.Canvas.Res.BytesPerLine,Buffer);
    For I:=0to Q.Canvas.Res.NumXPixels-1do Begin
     _Color2RGB(Buffer[I],Q.Canvas.Res.BitsPerPixel,Color);
     Color.R:=Tab[Color.R];
     Color.G:=Tab[Color.G];
     Color.B:=Tab[Color.B];
     Buffer[I]:=_RGB2Color(Q.Canvas.Res.BitsPerPixel,Color.R,Color.G,Color.B);
    End;
    XSetAbsRec(Q.Canvas.Image,P,Q.Canvas.Res.BytesPerLine,Buffer);
    Inc(P,Q.Canvas.Res.BytesPerLine);
   End;
  End;
 End;

Begin
 FillClr(FormBrightnessContrast,SizeOf(FormBrightnessContrast));
 If ExecuteAppDPU(119,FormBrightnessContrast)Then Begin
  ComputeContrast;
  Case(Q.Canvas.Res.BitsPerPixel)of
   8:ComputePalette256;
   15,16:Compute16;
  End;
  XFreeMem(Q.Canvas.Miroir);
  RIMakeDoublon(Q.Canvas.Image,rmAllResSteady,False,Q.Canvas);
  DWRefresh(Q);
 End;
End;

{ Cette proc‚dure permet d'ajuster de mixer les couleurs RVB en fonction
 des valeurs RVB attribu‚ … chacune.
}

Procedure DWChannelMixer(Var Q:DrawEditApp);
Var
 FormChannelMixer:Record
  R:Record
   R,G,B:MScrollBar;
  End;
  G:Record
   R,G,B:MScrollBar;
  End;
  B:Record
   R,G,B:MScrollBar;
  End;
 End;

 Procedure ComputePalette256;
 Var
  I:Integer;
  T:Record
   R,G,B:Integer;
  End;
 Begin
  If(Q.Canvas.PaletteRGB<>NIL)Then Begin
   For I:=0to Q.Canvas.Res.NumPal-1do Begin
    T.R:=((Q.Canvas.PaletteRGB^[I].R*FormChannelMixer.R.R.Position)shr 8)+
         ((Q.Canvas.PaletteRGB^[I].G*FormChannelMixer.R.G.Position)shr 8)+
         ((Q.Canvas.PaletteRGB^[I].B*FormChannelMixer.R.B.Position)shr 8);
    T.G:=((Q.Canvas.PaletteRGB^[I].R*FormChannelMixer.G.R.Position)shr 8)+
         ((Q.Canvas.PaletteRGB^[I].G*FormChannelMixer.G.G.Position)shr 8)+
         ((Q.Canvas.PaletteRGB^[I].B*FormChannelMixer.G.B.Position)shr 8);
    T.B:=((Q.Canvas.PaletteRGB^[I].R*FormChannelMixer.B.R.Position)shr 8)+
         ((Q.Canvas.PaletteRGB^[I].G*FormChannelMixer.B.G.Position)shr 8)+
         ((Q.Canvas.PaletteRGB^[I].B*FormChannelMixer.B.B.Position)shr 8);
    If T.R>255Then T.R:=255;
    If T.G>255Then T.G:=255;
    If T.B>255Then T.B:=255;
    Q.Canvas.PaletteRGB^[I].R:=T.R;
    Q.Canvas.PaletteRGB^[I].G:=T.G;
    Q.Canvas.PaletteRGB^[I].B:=T.B;
   End;
   XSetAbsRec(Q.Canvas.Image,SizeOf(ImageHeaderRes)+
              Mul2Word(Q.Canvas.Res.BytesPerLine,Q.Canvas.Res.NumYPixels),
              Q.Canvas.Res.NumPal*3,Q.Canvas.PaletteRGB^);
  End;
 End;

 Procedure Compute16;
 Var
  I,J:Integer;
  Buffer:Array[0..2047]of Word;
  Color:RGB;
  P:LongInt;
  X:Word;
  T:Record
   R,G,B:Integer;
  End;
 Begin
  If Q.Canvas.Res.BytesPerLine<=SizeOf(Buffer)Then Begin
   P:=SizeOf(ImageHeaderRes);
   For J:=0to(Q.Canvas.Res.NumYPixels)do Begin
    XGetAbsRec(Q.Canvas.Image,P,Q.Canvas.Res.BytesPerLine,Buffer);
    For I:=0to Q.Canvas.Res.NumXPixels-1do Begin
     _Color2RGB(Buffer[I],Q.Canvas.Res.BitsPerPixel,Color);
     T.R:=((Color.R*FormChannelMixer.R.R.Position)shr 8)+
          ((Color.G*FormChannelMixer.R.G.Position)shr 8)+
          ((Color.B*FormChannelMixer.R.B.Position)shr 8);
     T.G:=((Color.R*FormChannelMixer.G.R.Position)shr 8)+
          ((Color.G*FormChannelMixer.G.G.Position)shr 8)+
          ((Color.B*FormChannelMixer.G.B.Position)shr 8);
     T.B:=((Color.R*FormChannelMixer.B.R.Position)shr 8)+
          ((Color.G*FormChannelMixer.B.G.Position)shr 8)+
          ((Color.B*FormChannelMixer.B.B.Position)shr 8);
     If T.R>255Then T.R:=255;
     If T.G>255Then T.G:=255;
     If T.B>255Then T.B:=255;
     Buffer[I]:=_RGB2Color(Q.Canvas.Res.BitsPerPixel,T.R,T.G,T.B);
    End;
    XSetAbsRec(Q.Canvas.Image,P,Q.Canvas.Res.BytesPerLine,Buffer);
    Inc(P,Q.Canvas.Res.BytesPerLine);
   End;
  End;
 End;

Begin
 FillClr(FormChannelMixer,SizeOf(FormChannelMixer));
 FormChannelMixer.R.R.Position:=255;
 FormChannelMixer.G.G.Position:=255;
 FormChannelMixer.B.B.Position:=255;
 If ExecuteAppDPU(120,FormChannelMixer)Then Begin
  Case(Q.Canvas.Res.BitsPerPixel)of
   8:ComputePalette256;
   15,16:Compute16;
  End;
  XFreeMem(Q.Canvas.Miroir);
  RIMakeDoublon(Q.Canvas.Image,rmAllResSteady,False,Q.Canvas);
  DWRefresh(Q);
 End;
End;

Procedure DWLoadPalette(Var Q:DrawEditApp);
Var
 Path:String;
 S:String;
 P:LongInt;
 I:Integer;
 J:Byte;
 N:Byte;      { Num‚ro de palette }
 Handle:Hdl;
 NumPal:Word;
Begin
 If Q.Canvas.Res.BitsPerPixel<=8Then Begin
  Path:=OpenWin(MaltePath+'DRAW\PALETTES\*.PAL','Choisissez une palette');
  If Path<>''Then Begin
   Handle:=FileOpen(Path,fmRead);
   If(Handle<>errHdl)Then Begin
    P:=0;
    __GetAbsFileTxtLn(Handle,P,Path);
    If Path='JASC-PAL'Then Begin
     __GetAbsFileTxtLn(Handle,P,Path);
     __GetAbsFileTxtLn(Handle,P,Path);
     NumPal:=StrToInt(Path);
     If(NumPal>Q.Canvas.Res.NumPal)Then NumPal:=Q.Canvas.Res.NumPal;
     __GetAbsFileTxtLn(Handle,P,Path);
     For I:=0to NumPal-1do Begin
      __GetAbsFileTxtLn(Handle,P,Path);
      S:='';N:=0;
      For J:=1to Length(Path)do Begin
       If Path[J]=' 'Then Begin
        Case(N)of
         0:Q.Canvas.PaletteRGB^[I].R:=StrToWord(S);
         1:Q.Canvas.PaletteRGB^[I].G:=StrToWord(S);
         2:Q.Canvas.PaletteRGB^[I].B:=StrToWord(S);
        End;
        Inc(N);
        S:='';
       End
        Else
       IncStr(S,Path[J]);
      End;
     End;
    End;
    FileClose(Handle);
    XSetAbsRec(Q.Canvas.Image,SizeOf(ImageHeaderRes)+
               Mul2Word(Q.Canvas.Res.BytesPerLine,Q.Canvas.Res.NumYPixels),
               Q.Canvas.Res.NumPal*3,Q.Canvas.PaletteRGB^);
    XFreeMem(Q.Canvas.Miroir);
    RIMakeDoublon(Q.Canvas.Image,rmAllResSteady,False,Q.Canvas);
    DWRefresh(Q);
   End;
  End;
 End
  Else
 ErrNoMsgOk(errPaletteNotSupported);
End;

Type
 SpecialRGBRec=Record
  R,G,B:MScrollBar;
  H:ScrollBarWordRec;
  S,V:MScrollBar;
  ColorCube:ColorCubeData;
 End;

Procedure OnMoveColorX(Var R:ResourceWindow;Var Context);Far;
Var
 Data:SpecialRGBRec Absolute Context;
 H,S,V:Real;
Begin
 WEPutFillBox(R.W,1shl 3,GetRawY(16),R.W.MaxX shl 3,GetRawY(18)-1,
              RGB2Color(Data.R.Position,Data.G.Position,Data.B.Position));
 Data.ColorCube.Color.R:=Data.R.Position;
 Data.ColorCube.Color.G:=Data.G.Position;
 Data.ColorCube.Color.B:=Data.B.Position;
 RGB2HSV(Data.ColorCube.Color,H,S,V);
 Data.H.Value:=Trunc(H);
 Data.S.Position:=Trunc(S*100);
 Data.V.Position:=Trunc(V*256);
End;

Procedure OnMoveColorXHSV(Var R:ResourceWindow;Var Context);Far;
Var
 Data:SpecialRGBRec Absolute Context;
 Target:RGB;
Begin
 HSV2RGB(Data.H.Value,Data.S.Position/100,Data.V.Position/256,Target);
 WEPutFillBox(R.W,1shl 3,GetRawY(16),R.W.MaxX shl 3,GetRawY(18)-1,
              RGB2Color(Target.R,Target.G,Target.B));
 Data.ColorCube.Color.R:=Target.R;
 Data.ColorCube.Color.G:=Target.G;
 Data.ColorCube.Color.B:=Target.B;
 Data.R.Position:=Data.ColorCube.Color.R;
 Data.G.Position:=Data.ColorCube.Color.G;
 Data.B.Position:=Data.ColorCube.Color.B;
End;

Procedure OnMoveColorXCube(Var R:ResourceWindow;Var Context);Far;
Var
 Data:SpecialRGBRec Absolute Context;
Begin
 WEPutFillBox(R.W,1shl 3,GetRawY(16),R.W.MaxX shl 3,GetRawY(18)-1,
              RGB2Color(Data.ColorCube.Color.R,Data.ColorCube.Color.G,Data.ColorCube.Color.B));
 Data.R.Position:=Data.ColorCube.Color.R;
 Data.G.Position:=Data.ColorCube.Color.G;
 Data.B.Position:=Data.ColorCube.Color.B;
End;

Function ChoiceRGBColor(Var Q:RGB):Boolean;
Var
 Data:SpecialRGBRec;
 H,S,V:Real;
Begin
 ChoiceRGBColor:=False;
 FillClr(Data,SizeOf(Data));
 Data.R.OnScroll:=OnMoveColorX;
 Data.R.OnScrollContext:=@Data;
 Data.G.OnScroll:=OnMoveColorX;
 Data.G.OnScrollContext:=@Data;
 Data.B.OnScroll:=OnMoveColorX;
 Data.B.OnScrollContext:=@Data;
 Data.H.OnMove:=OnMoveColorXHSV;
 Data.H.Context:=@Data;
 Data.S.OnScroll:=OnMoveColorXHSV;
 Data.S.OnScrollContext:=@Data;
 Data.V.OnScroll:=OnMoveColorXHSV;
 Data.V.OnScrollContext:=@Data;
 Data.ColorCube.OnClick:=OnMoveColorXCube;
 Data.ColorCube.Context:=@Data;
 Data.B.Position:=Q.B;
 Data.G.Position:=Q.G;
 Data.R.Position:=Q.R;
 RGB2HSV(Q,H,S,V);
 Data.H.Value:=Trunc(H);
 Data.S.Position:=Trunc(S*100);
 Data.V.Position:=Trunc(V*256);
 If ExecuteAppDPU(80,Data)Then Begin
  Q.B:=Data.B.Position;
  Q.G:=Data.G.Position;
  Q.R:=Data.R.Position;
  ChoiceRGBColor:=True;
 End;
End;

END.