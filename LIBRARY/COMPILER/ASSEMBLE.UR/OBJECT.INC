{\Source\Chantal\Library\Compiler\Assemble.ur\Object.Inc}

Const
 {Mod�le d'ent�te d'enregistrement Intel (Expanded INTEL OMF record types)}
  {x: Intel OMF (Standard)}
  {m: �tendu Intel OMF (Microsoft)}
  {l: Nouveau Intel OMF}
 RHeadr=$6E;{  Ent�te d'enregistrement R-Module (R-Module Header Record)}
 RegInt=$70;{  Enregistrement de registre d'initialisation (Register Initialization Record)}
 REData=$72;{  Enregistrement d'�numaration de donn�e r�allouable (Relocatable Enumerated Data Record)}
 RIData=$74;{  (Relocatable Iterated Data Record)}
 OvlDef=$76;{  Enregistrement de d�finition de recouvrement (Overlay Definition Record)}
 EndRec=$78;{  Fin d'enregistrement (End Record)}
 BlkRec=$7A;{  D�finition du bloc d'enregistrement (Block Definition Record)}
 BlkEnd=$7C;{  Fin du bloc d'enregistrement (Block End Record)}
 DebSym=$7E;{  Enregistrement des symboles de d�buguage (Debug Symbols Record)}
 THeadr=$80;{x Ent�te d'enregistrement T-Module (T-Module Header Record)}
 LHeadr=$82;{  Ent�te d'enregistrement L-Module (L-Module Header Record)}
 PEData=$84;{  �num�ration de donn�e physique (Physical Enumerated Data (?))}
 PIData=$86;{  (Physical Iterated Data (?))}
 Coment=$88;{x Enregistrement de remarque (Comment Record)}
 ModEnd=$8A;{x Enregistrement de fin de module (Module End Record)}
 ModEndL=$8B;{l Enregistrement de fin de module (Module End Record)}
 ExtDef=$8C;{x (External Names Definition Record)}
 TypDef=$8E;{  Enregistrement du type des d�finitions (Type Definitions Record)}
 PubDef=$90;{x Enregistrement de d�finition des noms public (Public Names Definition Record)}
 PubDefL=$91;{l (Public Names Definition Record)}
 LocSym=$92;{  Enregistrement de symbol local (Local Symbols Record)}
 LinNum=$94;{  Enregistrement des num�ros de ligne (Line Numbers Record)}
 LNames=$96;{x Enregistrement de liste des noms (List of Names Record)}
 SegDef=$98;{x Enregistrement d'une d�finition de segment (Segment Definition Record)}
 SegDefL=$99;{l Enregistrement d'une d�finition de segment (Segment Definition Record)}
 GrpDef=$9A;{x Enregistrement d'une d�finition de groupe (Group Definition Record)}
 FixUpp=$9C;{x (Fix-Up Record)}
 FixUppL=$9D;{l (Fix-Up Record)}
 LEData=$A0;{x Donn�e logique d'�num�ration (Logical Enumerated Data)}
 LEDataL=$A1;{l Donn�e logique d'�num�ration (Logical Enumerated Data)}
 LIData=$A2;{x (Logical Iterated Data)}
 LIDataL=$A3;{l (Logical Iterated Data)}
 LibHed=$A4;{  Ent�te d'enregistrement de biblioth�que (Library Header Record)}
 LibNam=$A6;{  Enregistrement des noms de module de la biblioth�que (Library Module Names Record)}
 LibLoc=$A8;{  (Library Module Locations Record)}
 LibDic=$AA;{  Enregistrement dictionnaire de la biblioth�que (Library Dictionary Record)}
 ComDef=$B0;{m (Communal Data Definition Record)}
 LExtDef=$B4;{m (Local External Definition)}
 LPubDef=$B6;{m (Local Public Definition)}
 LPubDf2=$B7;{m (Local Public Definition (2nd case?))}
 LComDef=$B8;{m (Local Communal Data Definition)}
 LibHdr=$F0;{m Ent�te d'enregistrement de biblioth�que (Library Header Record)}
 LibEnd=$F1;{m Queue de l'enregistrement de biblioth�que (Library Trailer Record)}
 {Type d'enregistrement de commentaire}
 MSLang=$00;{Nom du langage}
 MSDosV=$9C;{Version de Dos}
 MSModl=$9D;{Optionnel, mod�le m�moire (compact,large,huge,...)}
 MSDSeg=$9E;{Switch for�ant 'DOSSEG'}
 MSILib=$9F;{Directive conditionnel INCLUDELIB}
 MSExtn=$A1;{Extensions active}
 Unknwn=$A2;{Inconnu (?)}
 MSLNam=$A3;{Nom du module de biblioth�que (Library Module Name)}
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
 {eeMod�le de Groupe}
 GrpAbs=$FA;{Groupe absolue}
 GrpLTL=$FB;{(Load Time Locatable)}
 GrpSCO=$FD;{(Segment/Class/Overlay Indices)}
 GrpEI=$FE;{Groupe d'index externe (External Index)}
 GrpSI=$FF;{Groupe d'index segment (Segment Index)}