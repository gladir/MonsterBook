{\Source\Chantal\Library\Files\TeleMate\TMDial30.Inc}

Type
  { Structure d'un Enregistrement d'une liste de t‚l‚phone du TeleMate V3.0}
 TMDialRec=Record
  Name:Array[0..29]of Char;{Nom du BBS}
  PassWord:Array[0..15]of Char;{Mot de passe sur ce BBS}
  Script:Array[0..8]of Char;{Nom du scripte … ex‚cut‚ lorsqu'une communication s'‚tablit}
  Log:Array[0..8]of Char;{Date du dernier branchement au BBS}
  Phone:Array[0..20]of Char;{Num‚ro de t‚l‚phone}
  Para:Array[0..8]of Char;{ParamŠtre g‚n‚raux}
  Port,f5:Char;{Port de communication}
  Total:Array[0..5]of Char;Last:Array[0..9]of Char;
  Term,Connect2,LineFeed,CarriageReturn,LocalEcho,Wrap,DestBS,AutoLog:Char;
  LongDistance,StripHigh,TagSeparator,GuessInitial:Char;
  Reserved:Array[0..1]of Char;Prefix,Suffix,Protocol:Char;
  CRLF:Array[0..1]of Char;{Retour de ligne}
 End;