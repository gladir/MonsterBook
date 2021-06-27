{\Source\Chantal\Library\System\DOS\Country3.Inc}

Type
 {Structure de pays utilisable avec un DOS 3.0+}
 CountryRec=Record
  Date:Word;               { Format de la date mdy, dmy,...}
  Curr:Array[0..4]of Char; { Symbole de la monnaie }
  ThSep,                   { Code ASCII du s‚parateur de millier }
  DeSep,                   { Code ASCII du symbole de d‚cimal }
  DtSep,                   { Code ASCII du s‚parateur dans la date }
  TmSep:Array[0..1]of Char;{ Code ASCII du s‚parateur de l'heure }
  CurrStyle,Digits:Byte;   { Format de la monnaie, pr‚cision d‚cimal }
  Time:TimeType;           { Format de l'heure: AM/PM (12h), Militaire 24h}
  CaseUp:Pointer;          { Adresse d'une routine de conversion en majuscule}
  DaSep:Array[0..1]of Char;{ S‚parateur de liste de donn‚e }
  Fill:Array[0..10]of Byte;{ R‚serv‚ }
 End;