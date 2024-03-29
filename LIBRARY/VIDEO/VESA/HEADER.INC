{\Source\Chantal\Library\Video\VESA\Header.Inc}

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
 �                 Malte Genesis/Biblioth둸ue individuel                 �
 �                    릁ition Chantal/IV - Version 1.1                   �
 �                             1997/04/01                                �
 �                                                                       �
 �         Tous droits r굎erv굎 par les Chevaliers de Malte (C)          �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�


 Nom des programmeurs
 袴袴袴袴袴袴袴袴袴袴

  Sylvain Maltais


 Description
 袴袴袴袴袴�

  Cette inclusion vise  � permettre une universialisation des donn괻s �
 compiler  ind굋endament  des conditions  sous  lequel  la fonction est
 tra똳er.  En centralisant toutes les proc괺ures au m늤e point central,
 on aboutira une technique de 췈roiser�, celle-ci permet d'굃iminer les
 bugs par le raisonnement suivant:Maintenant sa fonctionne parfaitement
 ou sa plante comme jamais avant...
}

{$I \Source\Chantal\Library\TWord.Inc}

Type
 {Structure d'information d'ent늯e VESA (Interruption 10h, Fonction 4Fh, Sous-Fonction 00h)}
 VesaHeaderInfo=Record
  Sign:Array[0..3]of Char;        {Signature du pilote 췝ESA�}
  Ver:Word;                       {Version du pilote VESA}
  OEMname:Pointer;                {Nom de l'OEM (exemple:"761295520"pour ATI)}
  Capabilities:Array[0..3]of Byte;{Octet de compatibilit�?}
  Modes:^TWord;                   {Pointeur de la table des modes vid굊 support�.}
  NmBnk64K:Word;                  {Nombre de banque de m굆oire en 64 Ko}
  Reserved:Array[0..235]of Byte;  {R굎erv� pour un usage futur...}
 End;{Taille: Minimum 256 octets}

 {Structure d'information actuel VESA (Interruption 10h, Fonction 4Fh, Sous-Fonction 01h)}
 VesaInfo=Record
  Mode:Record Case Byte of
   0:(Attr:Word);                 {Mode d'attributs}
   1:(X:Set of(viBit0,viOEM,viBIOS,viColor,viGraf));
  End;
  WindowAAttr,WindowBAttr:Byte;   {Fen늯re A et B d'attributs }
  Granularity,WindowSize,         {Granulation et taille de la fen늯re en Ko }
  SegWinA,SegWinB:Word;           {Segment de d굋art de la fen늯re A et B }
  WinPos:Pointer;                 {Routine de positionnement de la fen늯re }
  BytesPerScanLine,               {Octets par lignes de balayages }
   {Information Optionnel requ둹e les modes OEM}
  L,H:Word;                       {Largeurs et hauteur en pixels}
  LC,HC,                          {Largeur et hauteur d'un caract둹e texte }
  NumMemPlanes,BitsPerPixel,      {Nombre de plages de m굆oire, nombre de bits par pixel }
  NumBanks,MemoryType,            {Nombre de banque, type de m굆oire.}
  SizeOfBank:Byte;                {Taille de la banque en Ko }
  Reserved:Array[0..226]of Byte;  {R굎erv� pour un usage futur...}
 End;{Taille: Minimum 256 octets}