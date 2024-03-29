{KitText.Inc}

{$IFNDEF __KitText}
 {$DEFINE __KitText}

Const
 kTSMVersion=1;                                 { Version du Gestionnaire des Services texte }
 kTextService='tsvc';                           { Type de "Component" pour la description de "Component" }
 kInputMethodService='inpm';                    { Sous-type de "Component" pour la description de "Component" }
 bTakeActiveEvent=15;                           { Ensemble de bit s'il prend "Component" d'�v�nement actif }
 bScriptMask=$00007F00;                         { Bits de 8 � 14 }
 bLanguageMask=$000000FF;                       { Bits de 0 � 7 }
 bScriptLanguageMask=bScriptMask+blanguageMask; { Bits de 0 � 14 }

  { Styles Hilite }
 kCaretPosition=1;       { Sp�cifie la position du "Caret" }
 kRawText=2;             { Sp�cifie la rang� du texte brute }
 kSelectRawText=3;       { Sp�cifie la rang� de s�lection du texte brute }
 kConvertedText=4;       { Sp�cifie la rang� de texte converti }
 kSelectConvertedText=5; { Sp�cifie la rang� de s�lection de texte converti }

  { Constantes d'Apple Event }
 kTextServiceClass=kTextService; { Classe d'�v�n�ment }
 kUpDateActiveInputArea='updt';  { Mise � jour le region inline }
 kPos2Offset='p2st';             { Converti globalement les coordonn�es de la position de caract�re }
 kOffset2Pos='st2p';             { Converti la position de caract�re � aux coordonn�es globale }
 kShowHideInputWindow='shiw';    { Affiche oui/non la fen�tre d'entr�e }

  { Ev�nement des mots-cl� }
 keyAETSMDocumentRefcon='refc'; { Document refcon TSM }
 keyAEServerInstance='srvi';    { Cas de serveur }
 keyAEETheData='kdat';          { typeText }
 keyAEScriptTag='sclq';         { �tiquette de scripte }
 keyAEFixLength='fix1';
 keyAEHiliteRange='hrng';       { Rang� d'"array" d'Hilite }
 keyAEUpdateRange='udng';       { Mise � jour de rang� "array" }
 keyAEClauseOffsets='clau';     { Clause des offsets "array" }
 keyAECurrentPoint='cpos';      { Point courant }
 keyAEDragging='bool';          { Drapeau "Dragging" }
 keyAEOffset='ofst';            { Offset }
 keyAERegionClass='rgnc';       { Classe de r�gion }
 keyAEBufferSize='buff';        { Demande la taille de tampon texte }
 keyAERequestedType='rtyp';     { Type de texte requis }
 keyAEMoveView='mvvw';          { D�place le drapeau de fen�tre }
 keyAELength='leng';            { Longueur }
 keyAENextBody='nxbd';          { Prochain ou dernier "body" }

  { Mots-cl� optionel pour Offset2Pos }
 keyAETextFont='ktxf';
 keyAETextPointSize='ktps';
 keyAETextLineHeight='ktlh';
 keyAETextLineAscent='ktas';
 keyAEAngle='kang';

  { Mots-cl� optionel pour Pos2Offset }
 keyAELeft='klef'; { Type Boolean }

  { Mots-cl� optionel pour kShowHideInputWindow }
 keyAEShowHideInputWindow='shiw'; { Type Boolean }

  { Mots-cl� pour PinRange }
 keyAEPinRange='pnrg';

  { Description des types... }
 typeComponentInstance='cmpi'; { Cas de "Component" }
 typeTextRange='txrn';         { Texte de rang� "array" }
 typeOffsetArray='ofay';       { Offset d'"array" }
 typeIntlWritingCode='intl';   { Code de scripte }
 typeQDPoint='QDpt';           { Point QuickDraw }
 typeAEText='tTXT';            { Apple Event de texte }
 typeText='TEXT';              { Plein de texte }

  { Constante de descripteur de type d'�v�nement Apple }
 kTSMOutsideOfBody=1;
 kTSMInsideOfBody=2;
 kTSMInsideOfActiveInputArea=3;

 kNextBody=1;
 kPrevious=2;

  { Constante d'erreur d'�v�nement Apple }
 errOffsetInvalid=-1800;
 errOffsetIsOutsideOfView=-1801;
 errTopOfDocument=-1810;
 errTopOfBody=-1811;
 errEndOfDocument=-1812;
 errEndOfBody=-1813;

Type
 TextRange=Record fStart,fEnd:LongInt; fHiliteStyle:Integer; End;
 TextRangePtr=^TextRange;
 TextRangeHandle=^TextRangePtr;
 TextRangeArray=Record fNumOfRanges:Integer; fRange:Array[0..0] of TextRange; End;
 TextRangeArrayPtr=^TextRangeArray;
 TextRangeArrayHandle=^TextRangeArrayPtr;

 OffsetArray=Record fNumOfOffsets:Integer; fOffset:Array[0..0] of LongInt; End;
 OffsetArrayPtr=^OffsetArray;
 OffsetArrayHandle=^OffsetArrayPtr;

 TextServiceInfo=Record FComponent:Component;fItemName:String; End;
 TextServicesInfoPtr=^TextServiceInfo;
 TextServiceList=Record fTextServiceList=Record
  fTextServiceCount:Integer; fServices:Array[0..0] of TextServiceInfo;
 End;
 TextServiceListPtr=^TextServiceList;
 TextServiceListHandle=^TextServiceListPtr;

 ScriptLanguageRecord=Record fScript:ScriptCode; fLanguage:LangCode; End;
 ScriptLanguageSupport=Record
  FScriptLanguageCount:Integer; fScriptLanguageArray:Array[0..0] of ScriptLanguageRecord;
 End;
 ScriptLanguageSupportPtr=^ScriptLanguageSuppport;
 ScriptLanguageSupportHandle=^ScriptLanguageSupportPtr;

 InterfaceTypeList=Array[0..0] of OSType;
 TSMDocumentID=Ptr;

 { Initialise/Termine une Application TSM-Aware }
Function InitTSMAwareApplication:OSErr;Forward;
Function CloseTSMAwareApplication:OSErr;Forward;

 { Cr�ation & Activation des Documents TSM }
Function NewTSMDocument(NmOfInt:Integer;Var sIT:InterfaceTypeList; Var iodcID:TSMDocumentID;rC:LongInt):OSErr;Forward;
Function ActivateTSMDocument(idocID:TSMDocumentID):OSErr;Forward;
Function DeactivateTSMDocument(idoID:TSMDocumentID):OSErr;Forward;
Function DeleteTSMDocument(idoID:TSMDocumentID):OSErr;Forward;

 { Passage d'�v�nement au service texte "composents" }
Function TSMEvent(Var event:EventRecord):Boolean;Forward;

 { Passage des s�lections de Menu et ajustement de curseur }
Function TSMMenuSelect(menuResult:LongInt):Boolean;Forward;
Function SetTSMCursor(mousePos:Point):Boolean;Forward;

 { Confirmation entr�e active dans un document TSM }
Function FixTSMDocument(iodocID:TSMDocumentID):OSErr;Forward;

 { Faire des services texte utilisable par l'usager }
Function GetServiceList(nOIT:Integer;sIT:InterfaceTypeList;Var sI:TextServiceListHandle;Var sV:LongInt):OSErr;Forward;
Function OpenTextService(idocID:TSMDocumentID;aC:Component;Var aCI:ComponentInstance):OSErr;Forward;
Function CloseTextService(iID;TSMDocumentID;aCI:ComponemtInstance):OSErr;Forward;

 { Requis pour un entr�e de fen�tre flotante }
Function UseInputWindow(idoID:TSMDocumentID;useWindow:Boolean):OSErr;Forward;

 { Association Scriptes & Langage avec "Components" }
Function SetDefaultInputMethod(ts:Component;Var slRecord:ScriptLanguageRecord):OSErr;Forward;
Function GetDefaultInputMethod(Var ts:Component;Var slRecord:ScriptLanguageRecord):OSErr;Forward;
Function SetTextServiceLanguage(Var slRecord:ScriptLanguageRecord):OSErr;Forward;
Function GetTextServiceLanguage(Var slRecord:ScriptLanguageReocrd):OSErr;Forward;

 { Lecture d'�v�nement Apple d'un Application Client }
Function SendAEFromTSMComponent(Var eAE:AppleEvent;Var rep:AppleEvent;sM:AESendMode;sP:AESendPriority;
                                tOIT:LongInt;idlProc:IdleProcPtr;filterProc:EventFilterProcPtr):OSErr;Forward;

 { Ouverture de fen�tre d'utilitaire flottante }
Function NewServiceWindow(wS:Ptr;boundsRect;t:String;v:Boolean;tP:Integer;b:WindowPtr;g:Boolean;
                          ts:ComponentInstance;Var w:WindowPtr):OSErr;Forward;
Function CloseServiceWindow(window:WindowPtr):OSErr;Forward;
Function FindServiceWindow(tP:Point;Var tW:WindowPtr):Integer;Forward;

 { Pourvu du Service Texte }
Function InitialiseTextService(ts:ComponentInstance):ComponentResult;Forward;
Function ActivateTextService(ts:ComponentInstance):ComponentResult;Forward;
Function DeactiveTextService(ts:ComponentInstance):ComponentResult;Forward;
Function HidePaletteWindows(ts:ComponentInstance):ComponentResult;Forward;
Function TerminateTextService(ts:ComponentInstance):ComponentResult;Forward;

 { Responsable des �v�nements et de la mise � jour du Curseur du Menu }
Function TextServiceEvent(ts:ComponentInstance;numOfEvent:Integer;;Var event:EventRecord):ComponentResult;Forward;
Function TextServiceMenuSelect(ts:ComponentInstance;serviceMenu:MenuHandle;item:Integer):ComponentResult;Forward;
Function SetTextServiceCursor(ts:ComponentInstance;mousePos:Point):ComponentResult;Forward;
Function GetTextServiceMenu(ts:ComponentInstance;Var serviceMenu:MenuHandle):ComponentResult;Forward;

 { Confirme l'activation dans un Document TSM }
Function FixTextService(ts:ComponentInstance):ComponentResult;Forward;

 { Identificateur de support scripte et langage }
Function GetScriptLanguageSupport(ts:ComponentInstance;Var scriptHandle:ScriptLanguageHandle):ComponentResult;Forward;

{$ENDIF}