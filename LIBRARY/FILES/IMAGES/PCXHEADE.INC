{\Source\Chantal\Library\Files\Images\PCXHeade.Inc}

Type
 {Entˆte de fichier .PCX}
 HeaderPCX=Record
  MagicID,Version,Encoding,BitsPerPixel:Byte;
  X1,Y1,X2,Y2,NumXDPI,NumYDPI:Word;
  PaletteRGB:Palette16RGB;
  Reserved,NumPlanes:Byte;
  BytesPerLinePerPlane,PaletteInfo,NumXPixels,NumYPixels:Integer;
  Filler:Array[74..127]of Byte;
 End;