�
 TFORMDISQUEDUR 0�  TPF0TFormDisqueDurFormDisqueDurLeft� ToplWidth HeightwCaptionTable des disques durFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style PixelsPerInch`
TextHeight TDBGridDBGrid1LeftTopWidth�Height!
DataSourceDataSourceDisqueDurTabOrder TitleFont.CharsetDEFAULT_CHARSETTitleFont.ColorclWindowTextTitleFont.Height�TitleFont.NameMS Sans SerifTitleFont.Style Columns	FieldName
FABRIQUANTTitle.Caption
FabriquantWidthg 	FieldNameMODELETitle.CaptionMod�leWidthV 	FieldName	FORSIZEMBPickList.Strings  Title.CaptionTaille formatt�e en MoWidthL 	FieldName
FORMFACTORTitle.CaptionFormat de manufactureWidthy 	FieldName	INTERFACETitle.Caption	InterfaceWidth7 	FieldName
DATAENCMETTitle.CaptionM�thode d'encodage des donn�esWidth�  	FieldName
DATATRANRATitle.Caption)Vitesse de transfert des donn�es (Mbit/s) 	FieldNameTETETitle.CaptionT�te 	FieldNameCYLINDRETitle.CaptionCylindre 	FieldNameSECTEURTitle.CaptionSecteur total 	FieldName
SECTORTRACTitle.CaptionSecteur par piste 	FieldName
WRITPRECYLTitle.Caption)�criture de pr�composentation de cylindre 	FieldNameLANDZONETitle.Caption	Land Zone 	FieldName	REDWRICYLTitle.Caption)�criture de r�duction du cylindre courant 	FieldName
MINSTEPPULTitle.CaptionTemps minimum d'impulsion 	FieldName
UNFBYTRACKTitle.CaptionOctets par piste non-formatt�e 	FieldNameTPI 	FieldNameRPM 	FieldName	UNFSIZEMBTitle.CaptionTaille non-formatt�e en Mo 	FieldName
ACCSINGTRKTitle.CaptionTemps d'acc�s entre les pistes 	FieldNameAVERAGE_Title.CaptionTemps d'acc�s al�atoire 	FieldName
ACCMAXIMUMTitle.CaptionTemps d'acc�s maximum 	FieldNameWATTSTitle.CaptionWatts 	FieldNameCINQVDCTitle.Caption+5 V CC (+ ou - 5%)  	FieldNameDOUZEVDCTitle.Caption+12 V CC (+ ou - 5%) 	FieldName
MAXSTARTCUTitle.CaptionCourant maximal de d�part 	FieldNameHEIGHTTitle.CaptionHauteur 	FieldNameWIDTHTitle.CaptionLargeur 	FieldNameDEPTHTitle.Caption
Profondeur 	FieldNameWEIGHTTitle.CaptionPoids (livre) 	FieldNameMINTEMPTitle.CaptionTemp�rature minimum (C�) 	FieldNameMAXTEMPTitle.CaptionTemp�rature maximal (C�) 	FieldName
THERMALGRATitle.CaptionTemp�rature thermal (C�/Heure) 	FieldNameMTBFTitle.CaptionMTBF (Heures) 	FieldNameMTTRTitle.CaptionMTTR (Minutes) 	FieldName	YEARSLIFETitle.CaptionDur�e de vie (ann�es)    	TDatabaseDatabaseDisqueDur	Connected	DatabaseNameHARDDISK.BDF
DriverNameSTANDARDSessionNameDefaultLeft(Top   TQueryQueryDisqueDurActive	SQL.StringsSELECT FABRIQUANT,MODELE,*FORSIZEMB, /* || CAST(" Mo" AS NUMERIC),*/FORMFACTOR,
INTERFACE,DATAENCMET,DATATRANRA,	CYLINDRE,TETE,SECTEUR,SECTORTRAC,WRITPRECYL,	LANDZONE,
REDWRICYL,MINSTEPPUL,UNFBYTRACK,TPI,RPM,
UNFSIZEMB,ACCSINGTRK,AVERAGE_,ACCMAXIMUM,WATTS,CINQVDC,	DOUZEVDC,MAXSTARTCU,HEIGHT,WIDTH,DEPTH,WEIGHT,MINTEMP,MAXTEMP,THERMALGRA,MTBF,MTTR,	YEARSLIFEFROM HARDDISK ORDER BY FABRIQUANT, MODELE Left^Top   TDataSourceDataSourceDisqueDurDataSetQueryDisqueDurLeft� Top    