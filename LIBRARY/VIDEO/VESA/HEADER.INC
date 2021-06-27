{\Source\Chantal\Library\Video\VESA\Header.Inc}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                 Malte Genesis/BibliothŠque individuel                 Û
 ³                    dition Chantal/IV - Version 1.1                   Û
 ³                             1997/04/01                                Û
 ³                                                                       Û
 ³         Tous droits r‚serv‚s par les Chevaliers de Malte (C)          Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Nom des programmeurs
 ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ

  Sylvain Maltais


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette inclusion vise  … permettre une universialisation des donn‚es …
 compiler  ind‚pendament  des conditions  sous  lequel  la fonction est
 traŒter.  En centralisant toutes les proc‚dures au mˆme point central,
 on aboutira une technique de ®Croiser¯, celle-ci permet d'‚liminer les
 bugs par le raisonnement suivant:Maintenant sa fonctionne parfaitement
 ou sa plante comme jamais avant...
}

{$I \Source\Chantal\Library\TWord.Inc}

Type
 {Structure d'information d'entˆte VESA (Interruption 10h, Fonction 4Fh, Sous-Fonction 00h)}
 VesaHeaderInfo=Record
  Sign:Array[0..3]of Char;        {Signature du pilote ®VESA¯}
  Ver:Word;                       {Version du pilote VESA}
  OEMname:Pointer;                {Nom de l'OEM (exemple:"761295520"pour ATI)}
  Capabilities:Array[0..3]of Byte;{Octet de compatibilit‚?}
  Modes:^TWord;                   {Pointeur de la table des modes vid‚o support‚.}
  NmBnk64K:Word;                  {Nombre de banque de m‚moire en 64 Ko}
  Reserved:Array[0..235]of Byte;  {R‚serv‚ pour un usage futur...}
 End;{Taille: Minimum 256 octets}

 {Structure d'information actuel VESA (Interruption 10h, Fonction 4Fh, Sous-Fonction 01h)}
 VesaInfo=Record
  Mode:Record Case Byte of
   0:(Attr:Word);                 {Mode d'attributs}
   1:(X:Set of(viBit0,viOEM,viBIOS,viColor,viGraf));
  End;
  WindowAAttr,WindowBAttr:Byte;   {Fenˆtre A et B d'attributs }
  Granularity,WindowSize,         {Granulation et taille de la fenˆtre en Ko }
  SegWinA,SegWinB:Word;           {Segment de d‚part de la fenˆtre A et B }
  WinPos:Pointer;                 {Routine de positionnement de la fenˆtre }
  BytesPerScanLine,               {Octets par lignes de balayages }
   {Information Optionnel requŠre les modes OEM}
  L,H:Word;                       {Largeurs et hauteur en pixels}
  LC,HC,                          {Largeur et hauteur d'un caractŠre texte }
  NumMemPlanes,BitsPerPixel,      {Nombre de plages de m‚moire, nombre de bits par pixel }
  NumBanks,MemoryType,            {Nombre de banque, type de m‚moire.}
  SizeOfBank:Byte;                {Taille de la banque en Ko }
  Reserved:Array[0..226]of Byte;  {R‚serv‚ pour un usage futur...}
 End;{Taille: Minimum 256 octets}