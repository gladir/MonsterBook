Unit Soundex;

INTERFACE

Const
  { Signatures des fichiers RIFF/WAVE }
 RiffSignature='RIFF';
 WaveSignature='WAVE';
 FmtSignature='fmt ';
 DataSignature='data';

Type
 RiffFile=Record
  rID:Array [0..3]of Char;   { 0 … 3: Toujours "RIFF"}
  rLen:LongInt;              { 4 … 7: Taille des donn‚es}
  wID:Array [0..3]of Char;   { 8 … 11: Toujours "WAVE"}
  fID:Array [0..3]of Char;   { 9 … 15: Toujours "fmt "}
  fLen:LongInt;              { 16 … 19: Taille des donn‚es dans le format }
  wFormatTag:Word;           { 20 … 21: *}
  nChannels:Word;            { 22 … 23: Nombre de canal}
  nSamplesPerSec:Word;       { 24 … 25: Fr‚quence d'un "Sample"}
  nAvgBytesPerSec:Word;      { 26 … 27: **}
  nBlockAlign:Word;          { 28 … 29: ***}
  FormatSpecific:Word;       { 30 … 31: Format specifique … la r‚gion de donn‚e}
  Dummy:LongInt;             { 32 … 35 }
  dID:Array[0..3]of Char;    { 36 … 39: Toujours "data"}
  dLen:LongInt;              { 40 … 43: Taille des donn‚es}
  dData:Pointer;             { 44 … 47: Forme de donn‚e Wave actuel}
 End;

Const
  {Signature d'un fichier VOC de ®Creative Labs¯ }
 VocSign='Creative Voice File'+#$1A;

Type
  {Entˆte d'un fichier de format VOC de ®Creative Labs¯ }
 VocHeader=Record
  Sign:Array[0..19]of Char; { 0 … 19: Signature }
  SampOff:Word;             { 20 … 21 }
  VersLo:Byte;              { 22 }
  VersHi:Byte;              { 23 }
  {IdentCode:Word;          { 24 … 25 }
 End;

 VoiceBlock=Record
  IdentCode:Byte;           { 0: Code d'identification  }
  LongLo:Word;              { 1 … 2: Longueur de "Sample" }
  LongHi:Byte;              { 3: Longueur de "Sample"}
  X:Record Case Byte Of
   1:(TimeConstant:Byte;    { 4: Temps = 256 - 1000000 / "Sample" }
      PackType:Byte);       { 5: Type de packet: }
                            {     0 = 8 bits sans packet }
                            {     1 = 4 bits en packet   }
                            {     2 = 2,6 bits en packet }
                            {     3 = 2 bits en packet}
   2:(W:Word);              { 4 … 5 }
  End;
 End;

IMPLEMENTATION

END.