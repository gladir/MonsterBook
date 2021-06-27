{Fonts.Inc}

{$IFNDEF __Fonts}
 {$DEFINE __Fonts}

Const
 systemFont=0;
 applFont=1;
 newYork=2;
 geneva=3;
 monaco=4;
 venice=5;
 london=6;
 athens=7;
 sanFran=8;
 toronto=9;
 cairo=10;
 losAngeles=12;
 times=20;
 helvetica=21;
 courier=22;
 symbol=23;
 mobile=24;

{$I \Source\Chantal\Library\System\Mac\Types\Style.Inc}

Type
 FMInput=Packed Record
  family,size:Integer;  { Identificateur de la famille de police; Taille des points requis }
  face:Style;           { Style de police requis }
  needBits:Boolean;     { Si bitmaps peut avoir besoin de constructeur }
  device:Integer;       { Identificateur de device de pilote }
  numer,denom:Point;    { Facteur d'‚chelle des num‚rateurs; facteur d'‚chelle des d‚nominateurs }
 End;

           FMOutput=Packed Record
            errNum:Integer;               { R‚serv‚ pour usage interne }
            fontHandle:Handle;            { Handle de la police }
            bold,italic,ulOffset:Byte;    { Pour des styles de dessin respectivement gras, italique, soulignement }
            ulShadow,ulThick,shadow:Byte; { Pour des styles de dessin soulignement double, gras; style "shadow" }
            extra:SignedByte;             { # de pixel … additionner au style }
            ascent,descent,winMax:Byte;   { Mesure de mont‚/descente de la police; largeur max. du glyph dans la police }
            leading:SignedByte;           { PremiŠre valeur de la police }
            fOutCurStyle:Byte;            { Sortie actuel du style de police }
            numer,denom:Point;            { Facteur d'‚chelle du num‚rateur et du d‚nominateur }
           End;

           WidthTable=Packed Record
            tabData:Array[1..256] of Fixed; { Largeurs de caractŠre }
            tabFont:Handle;                 { Enregistrement de police utilis‚ pour la construction de la table }
            sExtra,style:LongInt;           { Espace de ligne extra; Espace de la ligne d– au style }
            fID,fSize:Integer;              { Identificateur de la famille de police; Taille requis pour la police }
            face,device:Integer;            { Style (face) requis; device requis }
            inNumer,inDenom:Point;          { Facteur d'‚chelle requis }
            aFID:Integer;                   { Identificateur de la famille de police actuel pour la table }
            fHand:Handle;                   { Famille d'enregistrement utilis‚ par haut-table de constructeur }
            usedFam:Boolean;                { Largeur de la famille utilisant des points fixe }
            aFace:Byte;                     { Face actuellement produit }
            vOutput,hOutput:Integer;        { Valeur de sortie de l'‚chelle respectivement vertical/horizontal }
            vFactor,hFactor:Integer;        { Valeur de sortie de l'‚chelle respectivement vertical/horizontal }
            aSize,tabSize:Integer;          { Taille la policve actuellement utilis‚; taille total de la table }
           End;

           FontRec=Record
            fontType,firstChar,lastChar:Integer;     { Type de police; code du caractŠre du premier/dernier "glyph" }
            widMax,kernMax:Integer;                  { Largeur maximal du "glyph"; Max n‚gatif du "glyph kern" }
            nDescent,fRestWidth,fRectHeight:Integer; { Descente n‚gative; largeur/hauteur de rectangle de la police }
            owTLoc,ascent,desent,leading:Integer;    { Position de la largeur/table offset; mont‚; descente; premier }
            rowWords:Integer;                        { Largeur de colonne de bit image / 2 }
           End;

           FamRec=Record
            ffFlags,ffFamID,ffFirstChar,ffLastChar:Integer; { Drapeau et num‚ro ID famile; 1er et dernier code carar. }
            ffAscent,ffDescent,ffLeading,ffWidMax:Integer;  { Max.: mont‚/descente/Premier/Largeur pour 1 pt de police }
            ffWTabOff,ffKernOff,ffStylOff:LongInt;          { Offset largeur/kerning/style de carte de la table }
            ffProperty:Array[1..9] of Integer;              { Information de style de propri‚t‚ }
            ffIntl:Array[1..2] of Integer;                  { Pour usage international }
            ffVersion:Integer;                              { Num‚ro de version }
           End;

           FontAssoc=Record numAssoc:Integer; End; { Nombre d'entr‚e - 1 }
           AsscEntry=Record fontSize,fontStyle,fontID:Integer; End; { Taille des points/style/ID de resource de police}
           WidTable=Record numWidths:Integer; End; { Nombre d'entr‚e - 1 }
           WidEntry=Record widStyle:Integer; End; { Style que l'entr‚e applique … }

           StyleTable=Record
            fontClass:Integer;                         { La classe de police de cette table }
            offset,reserved:LongInt;                   { Offset d'encodement de la sous-table glyph; r‚serv‚ }
            indexes:Packed Array[0..47] of SignedByte; { Index du nom de suffix de la table police suivant cette table }
           End;

           NameTable=Record stringCount:Integer; baseFontName:String;End; {Nombre d'entr‚e; Nom de la famille de police }
           KernTable=Record numKerns:Integer; End; { Nombre d'entr‚e de sous-table }
           KernEntry=Record kernStyle,kernLength:Integer; End; { Style d'entr‚ appliquable …; Longeur de cette entr‚e }

           KernPair=Record
            kernFirst,kernSecond:Char; { Code du premier/deuxiŠme des paires de "kerned" }
            kernWidth:Integer;         { Valeur du "Kerning" dans le format "fixed" }
           End;

           FMetricRec=Record
            ascent,descent,leading:Fixed;    { Base de la ligne au top/bottom; premier entre les lignes }
            widMax:Fixed; wTabHandle:Handle; { Largeur du glyph maximal; handle de la largeur de la table global }
           End;

           { Initialisation du gestionnaire de police }
          Procedure InitFonts;

           { Demande l'information de la police }
          Procedure GetFontName(familyID:Itneger;Var theName:String);
          Procedure GetFNum(theName:String;Var familyID:Integer);
          Procedure RealFont(fontNum,size:Integer):Boolean;

           { Utilisation courante, SystŠme, et des polices d'application }
          Function GetDefFontSize:Integer;
          Function GetSysFont:Integer;
          Function GetAppFont:Integer;

           { Demande les caract‚ristiques de la police }
          Procedure FontMetrics(theMatrics:FMetricRec);
          Function  OutlineMetrics(byteCount:Integer;textPtr:UNIV Ptr;numer,denom:Point;Var yMax,yMin:Integer;
                                   awArray,lsbArray:FixedPtr;boundsArray:RectPtr):OSErr;

           { Largeur de la Glyph fractionnel active }
          Procedure SetFractEnable(fractEnable:Boolean);

           { Echelle de police inactive }
          Procedure SetFScaleDisable(fscaleDisable:Boolean);

           { Police hors ligne favorite pour les polices Bitmap }
          Procedure SetOutlinePreferred(outlinePreferred:Boolean);
          Function  GetOutlinePreferred:Boolean;
          Function  IsOutLine(numer,denom:Point):Boolean;

           { Echelle de police hors ligne }
          Procedure SetPreserveGlyph(preserveGlyph:Boolean);
          Function  GetPreserveGlyph:Boolean;

           { AccŠs … l'information contenu dans la police }
          Function FMSwapFont(inRec:FMInput):FMOutPtr;

           { Handle de police en m‚moire }
          Procedure SetFontLock(lockFlag:Boolean);
          Function  FlushFonts:OSErr;

{$ENDIF}