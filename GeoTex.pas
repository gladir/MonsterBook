{ Cette unit� contient les d�finitions de structure de PC GeoWorks.
}

Unit GeoTex;

INTERFACE

Const
 GeosSignID=$53CF45C7;{ Identificateur de fichier GeoWorks }
 Geos2SignID=$53C145C7;{ Identificateur de fichier GeoWorks 2 }

Type
 GeosToken=Record { Identificateur pour les types d'ic�nes }
  Str:Array[0..3]of Char;
  Num:Word;
 End;

 GeosProtocol=Record { Num�ro de Protocol et de version }
  Vers:Word; { Protocole }
  Rev:Word;  { Sous r�vision }
 End;

 GeosRelease=Record
  { Version de r�alisation }
  VersMaj,VersMin:Word; { "release" x.y }
  RevMaj,RevMin:Word;   { valeur "a-b" apr�s le "release" }
 End;

 GeosHeader=Record { Structure Standard GeoWorks }
  ID:LongInt;                     { Identificateur GeoWorks: C7 45 CF 53 }
  Class_:Word;                    { 00=application, 01=Fichier VM }
  Flags:Word;                     { Drapeau??? (toujours � 0000h) }
  Release:GeosRelease;            { "release" }
  Protocol:GeosProtocol;          { Protocole/version }
  Token:GeosToken;                { Type d'ic�ne fichier }
  Appl:GeosToken;                 { "token" de l'auteur de l'application }
  Name:Array[0..35]of Char;       { Nom long du fichier }
  Info:Array[0..99]of Byte;       { Information fichier utilisateur }
  Copyright:Array[0..23]of Char;  { Fichier original: Droit d'auteur }
 End;

 Geos2header=Record { Struture Standard de GeoWorks 2 }
  ID:LongInt;                     { 0-Identificateur GeoWorks 2: C7 45 C1 53 }
  Name:Array[0..35]of Char;       { 4-Nom long du fichier }
  Class_:Word;                    { 40-Type de fichier GeoWorks }
  Flags:Word;                     { 42-Attributs }
  Release:GeosRelease;            { 44-"release" }
  Protocol:GeosProtocol;          { 52-Protocole/version }
  Token:GeosToken;                { 56-Type de fichier ic�ne }
  Appl:GeosToken;                 { 62-"token" de l'auteur de l'application }
  Info:Array[0..99]of Char;       { 68-Information utilisateur de fichier }
  Copyright:Array[0..23]of Char;  { 168-Fichier original: Droit d'auteur }
  X:Array[0..7]of Char;           { 192 }
  PackedFileDate:Word;            { 200 }
  PackedFileTime:Word;            { 202 }
  Password:Array[0..7]of Char;    { 204-Mot de passe, encrypt� en cha�ne hexad�cimal }
  X2:Array[0..43]of Char;         { 212-R�serv� }
 End;

IMPLEMENTATION

END.