{\Source\Chantal\Library\System\Windows\BitMap.Inc}

{$IFNDEF __BitmapWindows}
 {$DEFINE __BitmapWindows}

Type
 BitmapInfoHeader=Record
  biSize:LongInt;         { Sp‚cifie le nombre d'octets requis pour la structure }
  biWidth:LongInt;        { Sp‚cifie la largeur du BitMap en pixels }
  biHeight:LongInt;       { Sp‚cifie la hauteur du BitMap en pixels }
  biPlanes:Word;          { Sp‚cifie le nombre de plane pour la destination }
  biBitCount:Word;        { Sp‚cifie le nombre de bits par pixel (1, 4, 8, 24)}
  biCompression:LongInt;  { Sp‚cifie le style de compression: BI_RGB, BI_RLE8, BI_RLE4 }
  biSizeImage:LongInt;    { Sp‚cifie la taille en octets pour l'image }
  biXPelsPerMeter:LongInt;{ Sp‚cifie le nombre horizontal de pixels par mŠtre }
  biYPelsPerMeter:LongInt;{ Sp‚cifie le nombre vertical de pixels par mŠtre }
  biClrUsed:LongInt;      { Sp‚cifie le nombre de couleurs index‚s dans la table}
  biClrImportant:LongInt; { Sp‚cifie le nombre de couleurs index‚s dans la table
                            en comptant ceux ‚tant vraiment indispensable … l'affichage}
 End;

{$ENDIF}