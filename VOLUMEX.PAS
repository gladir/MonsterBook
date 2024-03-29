Unit Volumex;

INTERFACE

Const
 vxDOSEmu=0;               { Volume de format DOSEmu }
 vxVirtualPC=100;          { Volume de format Virtual PC }

Type
  {Ent�te de fichier image DOSEMU correspondant � des disques dur}
 DosEmuHeader=Record
  Sign:Array[0..6]of Char; { Signature: 'DOSEMU'#0 }
  Heads:LongInt;           { Nombre de t�te }
  SectorPerTrack:LongInt;  { Secteur par piste }
  Track:LongInt;           { Nombre de pistes }
  ResA:LongInt;            { �gale � 128 ?? }
  ResB:Array[23..127]of Byte;{ Inutilis�e }
 End;

  {Ent�te de fichier image Virtual PC de Connectix correspondant � des disques dur }
 ConnectixVirtualPCHeader=Record
  Sign:Array[0..7]of Char; { Signature: 'conectix' }
 End;

  {Secteur de d�marrage d'une partition HPFS }
 HPFSBootRec=Record
  ResA:Array[0..$35]of Byte;     { Signification inconnue??? }
  Sign:Array[0..3]of Char;       { Signature = 'HPFS' }
  ResB:Array[$3A..$1FF]of Byte;  { Signification inconnue??? }
 End;

IMPLEMENTATION

END.