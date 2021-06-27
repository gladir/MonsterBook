Program BanqueAuto;

Uses Isatex,Systex,Systems,Video,Dials;

Type AutoRec=Record
  Marque:String[63];      { Compagnie, exemple: Chrysler, Toyota,...}
  Modele:String[63];      { Exemple: Colt, Cellica,... L, GT, Luxe }
  Annees:Word;            { L'an 0 Ö 65 535 }
  Moteur:Record
   Cylindre:1..50;
   TypeMoteur:(EnLigne,Aplat,Etoile,EnH,EnU,EnV,EnW,EnX,AutreTypeMoteur);
   TypeMoteurAutre:String[31]; { En ligne, V, A plat,... }
   Distribution:(SimpleArbre,DblArbre);
   Distr2:(Entete,Base,SurAlimentation,AutreDist);
   DistributionAutre:String[63];
   Construction:String;
   Alesage:Record
    Format:(aCM,aMM,aPouce);
    Valeur:Word; { 0 Ö 25000 }
   End;
   Course:Record
    Format:(cCM,cMM,cPouce);
    Valeur:Word;
   End;
   TauxCompression:Byte;
   Distri:Record { Distribution }
    Descriptif:Byte; { 2, 3, 4, 5, 6 }
    TypeDistri:(Inclinee,ChambreHemispherique,L,Plat,AutreDistri);
    TypeAutre:String[63];
   End;
   Alimention:Record
    TypeAlimentation:(Injection,Carburateur,Compresseur,Turbo);
    Carburat:(Simple,Double,Triple,AutreCarbur);
    CarburatFormat:(Inversee,Autre);
    CarburatNombre:Byte; { 1, 2, 4, 6, 8,...}
    InjectionType:(Multi,Mono,Sequenciel,AutreInject);
    CompresseurType:String[63];
    TurboType:Record
     Nombre:Byte; { 1, 2, 3, 4,...}
     Intercooler:Boolean;
     IntercoolerDescriptif:(AirAir,AirEau); { Si oui...}
    End;
   End;
   Alumage:(BobineEtDistributeur,Magneto,Transistorisee,Direct,aDouble,AutreAlumage);
   AlumageAutre:String[63];
   PuissanceMax:Word; { chevaux Ö } TourMinute:Word; { tr/mn }
   CoupleMaxA,CoupleMaxB:Word;
  End;
  Transmission:Record
   TypeTransmission:(Manuel,Automatique,SemiAuto,AutreTypeTransmission);
   TypeTransmissionAutre:String[63];
   Rapport:Byte; { .... }
   TypeRapport:Array[1..10]of Record A,B:Word;End;
   RaportPont:String[15];
  End;
  CarroserieChassis:Record TypeDescription:String;End;
  Suspension:Record Avant,Arriere:String;End;
  Direction:String;
  Frein:Record
   Avant:(avDisque,avTambour,AutreAvant);
   AvantAutre:String[63];
   Arriere:(arDisque,arTambour,AutreArriere);
   ArriereAutre:String[63];
   Hydrolique:Boolean;
   Cable:Boolean;
   Servo:Boolean;
  End;
  Roue:Record
   TypeRoues:String[63];
   Pneu:String[63];
  End;
  DimensionEtPoids:Record
   Longueur:String[10];
   Largeur:String[10];
   Hauteur:String[10];
   VoieAvant:String[10];
   VoieArriere:String[10];
   Poids:String[10];
  End;
  Performance:Record
   Accelaration:String[10]; { 0 Ö 100 km/h }
   VitesseMax:String[10];
   Consammation:String[10];
   Prix:String[10];
   FormatMonnaie:(Can,American,Franc,Livres);
  End;
 End;

Procedure PutData;Var W:Wins;Auto:AutoRec;TypeMoteur,Distribution,Distr2:SwitchOption;Begin
 FillClr(Auto,SizeOf(Auto));
 WEInitO(W,70,20);
 WEPushWn(W);
 WEPutWnKrDials(W,'EntrÇe');
 WELn(W);
 WEPutTxt(W,'Marque:');
 WESetKr(W,$8F);WEBarSpcHorShade(W,8,1,8+15);WESetKrBorder(W);
 WELn(W);
 WELn(W);
 WEPutTxtLn(W,'Modäle:');
 WESetKr(W,$8F);WEBarSpcHorShade(W,8,3,8+15);WESetKrBorder(W);
 WEPutTxtXY(W,26,3,'AnnÇe:');
 WESetKr(W,$8F);WEBarSpcHorShade(W,33,3,32+5);WESetKrBorder(W);
 WELn(W);WELn(W);
 WEPutTxtLn(W,'ƒƒƒ MOTEUR ƒƒƒ');
 WELn(W);
 WEPutTxtLn(W,'N¯Cylindres:');
 WESetKr(W,$8F);WEBarSpcHorShade(W,13,7,13+5);WESetKrBorder(W);
 SetAllKr(W.XColrs.Border,W.XColrs.Border and$F0+$B);
 SOInit(TypeMoteur,W.X1+1,W.Y1+1+9,'Type de Moteur','A plat|En ligne|êtoile|En H|En U|En V|En W|En X',
 Byte(Auto.Moteur.TypeMoteur));
 SOInit(Distribution,W.X1+1+18,W.Y1+1+9,'Distribution','Simple Arbre|Double Arbres  ',Byte(Auto.Moteur.Distribution));
 SOInit(Distribution,W.X1+1+18,W.Y1+1+13,'Distribution','En tàte|Base|Suralimentation|Autre',Byte(Auto.Moteur.Distribution));
End;

BEGIN
 InitSystems(suIsabel);
 SetVideoModeDeluxe(vmTxtC80);
 InitEnv;
 PutTapis(0,MaxYTxts,$19);
 BarSpcHor(0,0,MaxXTxts,$1F);
 ConMacro('TO'#0#$1F'Auto$IC'#$FF#$1F);
 PutData;
 ReadKey;
 DoneLuxeVideo;
 DoneSystems;
END.