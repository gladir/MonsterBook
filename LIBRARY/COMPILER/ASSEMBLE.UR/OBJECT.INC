{\Source\Chantal\Library\Compiler\Assemble.ur\Object.Inc}

Const
 {Modäle d'entàte d'enregistrement Intel (Expanded INTEL OMF record types)}
  {x: Intel OMF (Standard)}
  {m: êtendu Intel OMF (Microsoft)}
  {l: Nouveau Intel OMF}
 RHeadr=$6E;{  Entàte d'enregistrement R-Module (R-Module Header Record)}
 RegInt=$70;{  Enregistrement de registre d'initialisation (Register Initialization Record)}
 REData=$72;{  Enregistrement d'Çnumaration de donnÇe rÇallouable (Relocatable Enumerated Data Record)}
 RIData=$74;{  (Relocatable Iterated Data Record)}
 OvlDef=$76;{  Enregistrement de dÇfinition de recouvrement (Overlay Definition Record)}
 EndRec=$78;{  Fin d'enregistrement (End Record)}
 BlkRec=$7A;{  DÇfinition du bloc d'enregistrement (Block Definition Record)}
 BlkEnd=$7C;{  Fin du bloc d'enregistrement (Block End Record)}
 DebSym=$7E;{  Enregistrement des symboles de dÇbuguage (Debug Symbols Record)}
 THeadr=$80;{x Entàte d'enregistrement T-Module (T-Module Header Record)}
 LHeadr=$82;{  Entàte d'enregistrement L-Module (L-Module Header Record)}
 PEData=$84;{  ênumÇration de donnÇe physique (Physical Enumerated Data (?))}
 PIData=$86;{  (Physical Iterated Data (?))}
 Coment=$88;{x Enregistrement de remarque (Comment Record)}
 ModEnd=$8A;{x Enregistrement de fin de module (Module End Record)}
 ModEndL=$8B;{l Enregistrement de fin de module (Module End Record)}
 ExtDef=$8C;{x (External Names Definition Record)}
 TypDef=$8E;{  Enregistrement du type des dÇfinitions (Type Definitions Record)}
 PubDef=$90;{x Enregistrement de dÇfinition des noms public (Public Names Definition Record)}
 PubDefL=$91;{l (Public Names Definition Record)}
 LocSym=$92;{  Enregistrement de symbol local (Local Symbols Record)}
 LinNum=$94;{  Enregistrement des numÇros de ligne (Line Numbers Record)}
 LNames=$96;{x Enregistrement de liste des noms (List of Names Record)}
 SegDef=$98;{x Enregistrement d'une dÇfinition de segment (Segment Definition Record)}
 SegDefL=$99;{l Enregistrement d'une dÇfinition de segment (Segment Definition Record)}
 GrpDef=$9A;{x Enregistrement d'une dÇfinition de groupe (Group Definition Record)}
 FixUpp=$9C;{x (Fix-Up Record)}
 FixUppL=$9D;{l (Fix-Up Record)}
 LEData=$A0;{x DonnÇe logique d'ÇnumÇration (Logical Enumerated Data)}
 LEDataL=$A1;{l DonnÇe logique d'ÇnumÇration (Logical Enumerated Data)}
 LIData=$A2;{x (Logical Iterated Data)}
 LIDataL=$A3;{l (Logical Iterated Data)}
 LibHed=$A4;{  Entàte d'enregistrement de bibliothäque (Library Header Record)}
 LibNam=$A6;{  Enregistrement des noms de module de la bibliothäque (Library Module Names Record)}
 LibLoc=$A8;{  (Library Module Locations Record)}
 LibDic=$AA;{  Enregistrement dictionnaire de la bibliothäque (Library Dictionary Record)}
 ComDef=$B0;{m (Communal Data Definition Record)}
 LExtDef=$B4;{m (Local External Definition)}
 LPubDef=$B6;{m (Local Public Definition)}
 LPubDf2=$B7;{m (Local Public Definition (2nd case?))}
 LComDef=$B8;{m (Local Communal Data Definition)}
 LibHdr=$F0;{m Entàte d'enregistrement de bibliothäque (Library Header Record)}
 LibEnd=$F1;{m Queue de l'enregistrement de bibliothäque (Library Trailer Record)}
 {Type d'enregistrement de commentaire}
 MSLang=$00;{Nom du langage}
 MSDosV=$9C;{Version de Dos}
 MSModl=$9D;{Optionnel, modäle mÇmoire (compact,large,huge,...)}
 MSDSeg=$9E;{Switch foráant 'DOSSEG'}
 MSILib=$9F;{Directive conditionnel INCLUDELIB}
 MSExtn=$A1;{Extensions active}
 Unknwn=$A2;{Inconnu (?)}
 MSLNam=$A3;{Nom du module de bibliothäque (Library Module Name)}
 PATime=$DD;{(Phoenix Time Stamp)}
 PACmnt=$FF;{Commentaire de type Phoenix (Phoenix Comment)}
 TCXSYMTYPIX=$E0;
 TCPubSymTyp=$E1;
 TCStruct=$E2;
 TCTypDef=$E3;
 TCEnum=$E4;
 TCBegSCP=$E5;
 TCLocDef=$E6;
 TCEndSCP=$E7;
 TCSource=$E8;
 TCDEPFIL=$E9;
 TCXLATOR=$EA;
 TCMANGLE=$F8;
 {eeModäle de Groupe}
 GrpAbs=$FA;{Groupe absolue}
 GrpLTL=$FB;{(Load Time Locatable)}
 GrpSCO=$FD;{(Segment/Class/Overlay Indices)}
 GrpEI=$FE;{Groupe d'index externe (External Index)}
 GrpSI=$FF;{Groupe d'index segment (Segment Index)}