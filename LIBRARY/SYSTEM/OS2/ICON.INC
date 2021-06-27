{\Source\Chantal\Library\System\OS2\Icon.Inc}

{$IFNDEF __IconOS2}
 {$DEFINE __IconOS2}

Type
 IconOS2DirEntry=Record
  Sign:Array[0..2]of Char;    { Signature de l'Icon 'C1'#26 }
  ResA:Char;ResB:Word;        { R‚serv‚s }
  NumXPixels,NumYPixels:Word; { Largeur et Hauteur de l'Ic“ne }
  PosAbs,ResC:LongInt;        { Position absolue depuis le d‚but du fichier }
  ResD,ResE:Word;             { R‚serv‚s }
  Plane,BitsPerPixel:Word;    { Nombre de plane, Bits par pixel }
  ResF,ResG,ResH:Word;        { R‚serv‚s }
 End;

 ExtIconOS2DirEntry=Record
  Sign:Array[0..1]of Char;    { Signature 'BA' }
  Size:LongInt;               { Taille de l'entˆte }
  ResA:Array[6..13]of Byte;   { R‚serv‚s }
  Data:IconOS2DirEntry;       { Comme l'Ancien }
 End;

{$ENDIF}