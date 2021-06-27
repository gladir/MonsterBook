Unit DrawInfo;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                                  INTERFACE
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Uses Isatex;

Procedure DWInfo(Var Q:DrawEditApp);
Procedure DWHistogram(Var Q:DrawEditApp);
Procedure TDProprieties(Var Q:TechDrawApp);

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                                IMPLEMENTATION
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Uses Adele,Systex,Math,Restex,Systems,Video,Dialex,Dials,DialPlus,TechDraw;

Procedure DWInfoKey(Var R:ResourceWindow;Var Context);
Var
 Q:DrawEditApp Absolute Context;
Begin
 DWHistogram(Q);
End;

Procedure DWInfo(Var Q:DrawEditApp);
Var
 Data:Record
  CaptionName:String[12];
  CaptionSize:String[20];
  CaptionDimension:String[20];
  CaptionBitsPerPixel:String[10];
  CaptionBytesPerLine:String[10];
  CaptionShadow:String[20];
  CaptionOriginal:String[20];
  CaptionNumIndex:String[20];
  CaptionNumPal:String[20];
  Description:String[10];
  Key:KeyHoriProc;
 End;
Begin
 FillClr(Data,SizeOf(Data));
 Data.Key.OnPress:=DWInfoKey;
 Data.Key.Context:=@Q;
 Data.CaptionName:=Path2NoDir(Q.FileName);
 Data.CaptionSize:=CStr(Mul2Word(Q.Canvas.Res.BytesPerLine,Q.Canvas.Res.NumYPixels))+' octets';
 Data.CaptionDimension:=CStr(Q.Canvas.Res.NumXPixels)+'x'+CStr(Q.Canvas.Res.NumYPixels);
 Data.CaptionBitsPerPixel:=CStr(Q.Canvas.Res.BitsPerPixel);
 Data.CaptionBytesPerLine:=CStr(Q.Canvas.Res.BytesPerLine);
 If(Q.Canvas.Res.Shadow)Then Data.CaptionShadow:='Oui'
                        Else Data.CaptionShadow:='Non';
 Data.CaptionOriginal:=WordToStr(Q.Canvas.Res.Original);
 Data.CaptionNumIndex:=IntToStr(Q.Canvas.Res.Index);
 Data.CaptionNumPal:=CStr(Q.Canvas.Res.NumPal);
 Data.Description:=Q.Canvas.Res.Descr;
 ExecuteAppDPU(115,Data);
End;

Procedure DWHistogram(Var Q:DrawEditApp);
Var
 W:Window;
 Red:Array[0..255]of Word;
 Green:Array[0..255]of Word;
 Blue:Array[0..255]of Word;
 Normal:Array[0..255]of Word;
 GX1,GY1:Word;

 Procedure Compute256;
 Var
  Buffer:Array[0..4097]of Byte;
  J,I:Word;
  P:LongInt;
 Begin
  P:=SizeOf(ImageHeaderRes);
  For J:=0to(Q.Canvas.Res.NumYPixels)do Begin
   XGetAbsRec(Q.Canvas.Miroir,P,Q.Canvas.Res.BytesPerLine,Buffer);
   For I:=0to Q.Canvas.Res.NumXPixels-1do Begin
    Inc(Normal[Buffer[I]]);
    Inc(Red[Q.Canvas.PaletteRGB^[Buffer[I]].R]);
    Inc(Green[Q.Canvas.PaletteRGB^[Buffer[I]].G]);
    Inc(Blue[Q.Canvas.PaletteRGB^[Buffer[I]].B]);
   End;
   Inc(P,Q.Canvas.Res.BytesPerLine);
  End;
 End;

 Procedure PutHistogram;
 Var
  I:Byte;
  Max:Word;
  Echelle:Word;
 Begin
  Max:=0;
  For I:=0to 255do Begin
   If(Red[I]>Max)Then Max:=Red[I];
   If(Green[I]>Max)Then Max:=Green[I];
   If(Blue[I]>Max)Then Max:=Blue[I];
   If(Normal[I]>Max)Then Max:=Normal[I];
  End;
  Echelle:=Max shr 7;
  _SetKr(LightRed);
  _Move2(GX1,GY1);
  For I:=0to 255do Begin
   _Ln2(GX1+I,GY1-(Red[I]div Echelle));
  End;
  _SetKr(LightGreen);
  _Move2(GX1,GY1);
  For I:=0to 255do Begin
   _Ln2(GX1+I,GY1-(Green[I]div Echelle));
  End;
  _SetKr(LightBlue);
  _Move2(GX1,GY1);
  For I:=0to 255do Begin
   _Ln2(GX1+I,GY1-(Blue[I]div Echelle));
  End;
  _SetKr(Yellow);
  _Move2(GX1,GY1);
  For I:=0to 255do Begin
   _Ln2(GX1+I,GY1-(Normal[I]div Echelle));
  End;
 End;

Begin
 WEInitO(W,35,17);
 WEPushWn(W);
 WEPutWnKrDials(W,'Histogramme');
 WECloseIcon(W);
 WEBar(W);
 W.Y:=8;
 WEPutOTxt(W,'Compilation...');
 FillClr(Red,SizeOf(Red));
 FillClr(Green,SizeOf(Green));
 FillClr(Blue,SizeOf(Blue));
 FillClr(Normal,SizeOf(Normal));
 GX1:=(WEGetRX1(W)+1)shl 3;
 GY1:=GetRawY(WEGetRY1(W)+W.MaxY-3);
 Compute256;
 PutFillBox(GX1,GY1-127,GX1+255,GY1,White);
 PutHistogram;
 ClrLnHor(GX1,GY1,256,Black);
 PutLn(GX1,GY1-127,GX1,GY1,Black);
 While WEOk(W)do;
End;

Procedure TDProprieties(Var Q:TechDrawApp);
Var
 Data:Record
  CaptionNameProject:String[40];
  CaptionNameModele:String[40];
  CaptionVersion:String[10];
  CaptionAlias:String[30];
  CaptionAuthor:String[30];
  CaptionResponsable:String[30];
  CaptionEmail:String[60];
  CaptionDescription:String;
  CaptionNameOrganisme:String[50];
  CaptionLogo:String;
  ScaleX:Word;
  ScaleY:Word;
  NumModif:LongInt;
  CaptionDateCreated:String[20];
  CaptionDateModified:String[20];
  Key:Byte;
 End;
 OldScaleX,OldScaleY:Real;
Begin
 FillClr(Data,SizeOf(Data));
 Data.CaptionNameProject:=Q.FileInfo.NameProject;
 Data.CaptionNameModele:=Q.FileInfo.NameModele;
 Data.CaptionVersion:=Q.FileInfo.Version;
 Data.CaptionAlias:=Q.FileInfo.Alias;
 Data.CaptionAuthor:=Q.FileInfo.Author;
 Data.CaptionResponsable:=Q.FileInfo.Responsable;
 Data.CaptionEmail:=Q.FileInfo.Email;
 Data.CaptionDescription:=Q.FileInfo.Description;
 Data.CaptionNameOrganisme:=Q.FileInfo.NameOrganisme;
 Data.CaptionLogo:=Q.FileInfo.Logo;
 Data.NumModif:=Q.FileInfo.NumModified;
 Data.CaptionDateCreated:=CStrDate(Q.FileInfo.DateCreated);
 Data.CaptionDateModified:=CStrDate(Q.FileInfo.DateModified);
 OldScaleX:=Q.FileInfo.ScaleX;
 OldScaleY:=Q.FileInfo.ScaleY;
 Data.ScaleX:=Trunc(Q.FileInfo.ScaleX);
 Data.ScaleY:=Trunc(Q.FileInfo.ScaleY);
 If ExecuteAppDPU(130,Data)Then Begin
  Q.FileInfo.NameProject:=Data.CaptionNameProject;
  Q.FileInfo.NameModele:=Data.CaptionNameModele;
  Q.FileInfo.Version:=Data.CaptionVersion;
  Q.FileInfo.Alias:=Data.CaptionAlias;
  Q.FileInfo.Author:=Data.CaptionAuthor;
  Q.FileInfo.Responsable:=Data.CaptionResponsable;
  Q.FileInfo.Email:=Data.CaptionEmail;
  Q.FileInfo.Description:=Data.CaptionDescription;
  Q.FileInfo.NameOrganisme:=Data.CaptionNameOrganisme;
  Q.FileInfo.Logo:=Data.CaptionLogo;
  Q.FileInfo.ScaleX:=Data.ScaleX;
  Q.FileInfo.ScaleY:=Data.ScaleY;
  Q.Modified:=True;
  If(OldScaleX<>Q.FileInfo.ScaleX)or
    (OldScaleY<>Q.FileInfo.ScaleY)Then TDRefresh(Q);
 End;
End;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
END.