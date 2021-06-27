{\Source\Chantal\Library\System\Windows\Icon.Inc}

{$IFNDEF __IconWindows}
 {$DEFINE __IconWindows }

 {$I \Source\Chantal\Library\System\Windows\BitMap.Inc}
 {$I \Source\Chantal\Library\System\Windows\RGB.Inc}

Type

 IconDirEntry=Record
  bWidth:Byte;            { Largeur de l'ic“ne. 16, 32 ou 64 pixels. }
  bHeight:Byte;           { Hauteur de l'ic“ne. Doit ˆtre identique … bWidth }
  bColorCount:Byte;       { Nombre de couleurs. 2, 8 ou 16. }
  bReserved:Byte;         { R‚serv‚s, doit ˆtre … 0 pour l'instant, mais
                            pourra ˆtre utilis‚ ‚ventuellement pour
                            l'extension en 256 couleurs par exemples... }
  wPlanes:Word;           { Nombre de planes de couleurs dans l'ic“ne }
  wBitCount:Word;         { Nombre de bits par pixels }
  dwBytesInRes:LongInt;   { Grosseurs de la ressource en octets.}
  dwImageOffset:LongInt;  { Sp‚cifie la position absolue … partie du d‚but
                            du fichier en octets ou se trouve l'Ic“ne.}
 End;

 IconHeader=Record
  idReserved:Word;        { R‚serv‚; doit toujours ˆtre … 0 }
  idType:Word;            { Sp‚cifie le type de ressource, ce membre doit
                            donc ˆtre … 1 = Ic“ne, 2 = Curseur }
  idCount:Word;           { Nombre d'Ic“ne dans le r‚pertoire, C'est le
                            nombre dans le tableau ®idEntries¯!}
  idEntries:Array[0..1]of { D‚finit une structure contenant des }
            IconDirEntry; { indications d'une des Ic“nes du fichier.}
 End;

{$ENDIF}