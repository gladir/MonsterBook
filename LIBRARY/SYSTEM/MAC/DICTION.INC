{Diction.Inc}

{$IFNDEF __Diction}
 {$DEFINE __Diction}

Const
  { Mode de donn‚e d'insertion }
 kInsert=0;           { Insert seulement l'entr‚e s'il n'est pas dans le dictionaire des cl‚s }
 kReplace=1;          { Remplace seulement la cl‚ compatible avec l'entr‚e }
 kInsertOrReplace =2; { Combinaison de kInsert avec kReplace }

  { Constante de cl‚ d'attribut }
 kIsCaseSensitive=16;           { Marque de case sensitive "Diacritical" }
 kIsNotDiacriticalSensitive=32; { Marque de case non sensitive "Diacritical" }

  { Types d'attribut de registre }
 kNoun=-1;      { Nom }
 kVerb=-2;      { Verbe }
 kAdjective=-3; { Adjectif }
 kAdverb=-4;    { Adverbe }

Type
 InsertMode=Integer;
 AttributType=Integer;
 DictionaryInformation=Record
  dictionaryFSSpec:FSSpec;    { Sp‚cification d'enregistrement fichier systŠme pour ce dictionaire }
  numbreOfRecords:LongInt;    { Nombre d'enregistrement dans ce dictionaire }
  currentGarbageSize:LongInt; { Taille courant du garbage (inutilisable) de donn‚ dans le dictionnaire }
  script:ScriptCode;          { Scripte systŠme support‚ par ce dictionaire }
  maximumKeyLength:Integer;   { Longueur maximal de n'importe quel cl‚ dans ce dictionnaire }
  KeyAttributes:UnsignedByte; { Recherche de cl‚ critique }
 End;

 { Faire un Dictionnaire }
Function InitializeDictionary(theFSSpecPtr:FSSpecPtr;maxKeyLen:Integer;KeyAttr:Byte;script:ScriptCode):OSErr;Forward;

 { AccŠs au Dictionnaire }
Function OpenDictionary(theFSpecPTr:FSSpecPtr;accessPermission:SignedByte;Var dictionaryRef:LongInt):OSErr;Forward;
Function CloseDictionary(dictionaryReference:LongInt):OSErr;Forward;
Function GetDictionaryInformation(dictionaryReference:LongInt;Var theDictInfo:DictionaryInformation):OSErr;Forward;

 { Position de l'enregistrement dans un Dictionnaire }
Function FindRecordInDictionary(dictRef:LongInt;key:String;requAttrTablePtr:Ptr;recDataHandle:Handle):OSErr;Forward;
Function FindByIndexInDictionary(dictRef:LongInt;key:String;recDataHdl:Handle;whichMode:InsertMode):OSErr;Forward;

 { Modification d'un dictionaire }
Function InsertRecordToDictionary(dictRef:LongInt;rATP:Ptr;Var recK:String;rDH:Handle;wM:InsertMode):OSErr;Forward;
Function DeleteRecordFromDictionary(dictionaryReference:LongInt;key:String):OSErr;Forward;

 { Compactage d'un dictionaire }
Function CompactDictionary(dictionaryReference:LongInt):OSErr;Forward;

{$ENDIF}