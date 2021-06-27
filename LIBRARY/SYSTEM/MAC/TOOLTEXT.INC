{ToolText.Inc}

{$IFNDEF __ToolText}
 {$DEFINE __ToolText}

{$I \Source\Chantal\Library\System\Mac\Types\Base.Inc}

Const
  { êtat des valeurs de StringToDate & StringToTime }
 longDateFound=1;         { Masque Ö longue date trouvÇ }
 leftOverChars=2;         { Masque d'avertissement de gauche sur les caractäres }
 sepNotIntlSep=4;         { Masque d'avertissement des sÇparateurs non-standard }
 fieldOrderNotIntl=8;     { Masque d'avertissement d'ordre de champs non-standard }
 extraneousStrings=16;    { Masque d'avertissement d'une chaåne de caractäre en texte "unparsable" }
 tooManySeps=32;          { Masque d'avertissement de beaucoup trop de sÇparateur }
 sepNotConsistent=64;     { Masque d'avertissement des sÇparateurs inconsistant }
 fatalDateTime=$8000;     { Masque d'un erreur fatale }
 tokenErr=$8100;          { Masque pour 'tokenizer err encountered' }
 cantReadUtilities=$8200; { Masque pour ne pas avoir besoin d'accÇder au resource }
 dateTimeNotFount=$8400;  { Masque pour l'heure et la date introuvable }
 dateTimeInvalid=$8800;   { Masque pour le format du temps invalide }

  { Constantes pour oó trunquer l'argument dans TruncString & TruncText }
 truncEnd=0;        { Tronque Ö la fin }
 truncMiddle=$4000; { Tronque au milieu }

  { Constantes pour le rÇsultat de TruncString & TruncText }
 NoTruncated=0; { N'est pas nÇcessairement tronquÇ }
 Truncated=1;   { Tronquage accomplie }
 TruncErr=-1;   { Erreur gÇnÇral }

  { Code des valeurs de langage spÇcial pour un autre langage }
 systemCurLang=-2;  { Langage courant pour le scripte du systäme (de 'itlb') }
 systemDefLang=-3;  { Langage par dÇfaut pour le scripte du systäme (de 'itlm') }
 currentCurLang=-4; { Langage courant pour le scripte courant (de 'itlb') }
 currentDefLang=-5; { Langage par dÇfaut pour le scripte courant (de 'itlm') }
 scriptCurLang=-6;  { Langage courant pour le scripte spÇcifiÇ (de 'itlb') }
 scriptDefLang=-7;  { Langage par dÇfaut pour le scripte spÇcifiÇ (de 'itlb') }

Type
 FormatStatus=Integer;
 TruncCode=Integer;
 DateForm=(shortDate,longDate,abbrevDate);
 FormatResultType = (fFormatOk,fBestGuess,fOutOfSynch,fSpuriousChars,fMissingDelimiter,fExtraDecimal,
                               fMissingLiteral,fExtraExp,fFormatOverflow,fFormStrIsNAN,fBadPartsTable,fExtraPercent,
                               fExtraSeparator,fEmptyFormatString);
 FormatClass = (fPositive,fNegative,fZero);
 StyledLineBreakCode = (BreakWord,BreakChar,BreakOverflow);
 DateCacheRecord=Packed Record hidden:Array[0..255] of Integer; End; { Seulement pour usage temporaire }
 DateCachePtr=^DateCacheRecord;
 NumFormatStringRec=Packed Record fLength,fVersion:Byte;data:Packed Array[0..253]of SignedByte;End;
 FVector=Record start,length:Integer;End;
 TripleInt=Array[0..2]of FVector; { Index par [fPositive..fZero] }
 OffPair=Record offFirst,offSecond:Integer;End;
 OffsetTable=Array[0..2] of OffPair;
 ScriptRunStatus=Record script,variant:SignedByte;End;

 { DÇfinition et spÇcification des chaånes de caractäres }
Function  NewString(theString:String):StringHandle;Forward;
Procedure SetString(theString:StringHandle;StrNew:String);Forward;
Function  GetString(stringID:Integer):StringHandle;Forward;
Procedure GetIndString(Var theString:String;strListID,index:Integer);Forward;

 { Compare l'ÇgalitÇ des chaånes de caractäre }
Function EqualString(aStr,bStr:String;caseSens,diacSens:Boolean):Boolean;Forward;
Function IdenticalString(aStr,bStr:String;itl2Handle:Handle):Integer;Forward;
Function IdenticalText(aPtr,bPtr:Ptr;aLen,bLen:Integer;itl2Handle:Handle):Integer;Forward;

 { DÇtermine l'ordre des chaånes de caractäre dans les diffÇrents langage }
Function ScriptOrder(script1,script2:ScriptCode):Integer;Forward;
Function LanguageOrder(lang1,lang2:LangCode):Integer;Forward;
Function StringOrder(aStr,bStr:String;aScript,bScript:ScriptCode;aLang,bLang:LangCode):Integer;Forward;
Function TextOrder(aPtr,bPtr:Ptr;aLen,bLen:Integer;aScript,bScript:ScriptCode;aLang,bLang:LangCode):Integer;Forward;

 { DÇtermine l'ordre des chaånes de caractäre pour les màmes langage }
Function RelString(aStr,bStr:String;caseSens,diacSens:Boolean):Integer;Forward;
Function CompareString(aStr,bStr:String;itl2Handle:Handle):Integer;Forward;
Function CompareText(aPtr,bPtr:Ptr;aLen,bLen:Integer):Integer;Forward;

 { Modification des caractäres et des marques "Diacritical" }
Procedure UpperString(Var thString:String;diacSens:Boolean);Forward;
Procedure LowercaseText(textPtr:Ptr;Len:Integer;script:ScriptCode);Forward;
Procedure UppercaseText(textPtr:Ptr;Len:Integer;script:ScriptCode);Forward;
Procedure StripDiacritics(textPtr:Ptr;Len:Integer;ScriptCode);Forward;
Procedure UppercaseStripDiacritics(textPtr:Ptr;Len:Integer;script:ScriptCode);Forward;

 { TronquÇ les chaånes de caractäre }
Function TruncString(width:Integer;Var theString:String;truncWhere:TruncCode):Integer;Forward;
Function TruncText(width:Integer;textPtr:Ptr;Var Length:Integer;truncWhere:TruncCode):Integer;Forward;

 { Rechercher pour et replacage de chaåne de caractäre }
Function ReplaceText(baseText:substitutionText:Handle;key:Str15):Integer;Forward;
Function Munger(h:Handle;offset:LongInt;ptr1:Ptr;len1:LongInt;ptr2:Ptr;Len2:LongInt):LongInt;Forward;

 { Travaille avec Mot, Sous-Scripte, et Ligne destinaire }
Procedure FindWorkBreaks(textPtr:Ptr;textLength,offset:Integer;leadingEdge:Boolean;
                         nBreaks:NBreakTablePtr;Var offsets:OffsetTable);Forward;
Function  StyledLineBreak(textPtr:Ptr;TextLen:LongInt;textStart,textEnd,flags:LongInt;
                          Var textWidth:Fixed;Var TextOffset:LongInt):StyledLineBreakCode;Forward;
Function  FindScriptRun(textPtr:Ptr;textLen:LongInt;Var LenUsed:LongInt):ScriptRunStatus;Forward;

 { Conversion des chaånes de caractäre de la Date et de l'Heure en leurs reprÇsentations numÇrique }
Function InitDateCache(theCache:DateCachePtr):OSErr;
Function StringToDate(textPtr:Ptr;textLen:LongInt;theCache:DateCachePtr;Var LengthUsed;LongInt;
                      Var dateTie:LongDateRec):StringToDateStatus;Forward;
Function StringToTime(textPtr:Ptr;textLen:LongInt;theCache:DateCachePtr;Var lengthUsed:LongInt;
                      Var dateTime:LongDateRec):StringToDateStatus;Forward;

 { Conversion de leurs reprÇsentations numÇrique en des chaånes de caractäre de la Date et de l'Heure }
Procedure DateString(dateTime:LongInt;longFlag:DateForm;Var Result:String;intlHandle:Handle);Forward;
Procedure TimeString(dateTime:LongInt;wantSeconds:Boolean;Var Result:String;intlHandle:Handle);Forward;

 { Conversion longue de la valeur de la Date et de l'Heure en chaåne de caractäre }
Procedure LongDateString(Var dateTime:LongDateTime;longFlag:DateForm;Var result:String;intlHandle:Handle);Forward;
Procedure LongTimeString(Var dateTime:LongDateTime;wantSeconds:Boolean;Var result:String;intlHandle:Handle);Forward;

 { Conversion entre Entier et chaånes de caractäres }
Procedure NumToString(theNum:LongInt;Var theString:String);Forward;
Procedure StringToNum(theString:String;Var theNum:LongInt);Forward;

 { Utilisation de format de nombre spÇcifique Ö des chaånes de caractäre pour les
   formats de nombre International }
Function StringToFormatRec(inString:String;partsTable:NumberParts;Var outString:NumFormatString):ForamtStatus;Forward;
Function FormatRecToString(myFormatRec:NumFormatString;partTable:NumberParts;Var outString:String;
                           Var positions:TripleInt):FormatStatus;Forward;

 { Conversion entre chaåne de caractäre et nombre Ö virgule flottante }
Function StringToExtended(source:String;myFormatRec:NumFormatString;
                          partsTable:NumberParts;Var X:Extended80):FormatStatus;Forward;
Function ExtendedToString(x:Extended80;myFormatRec:NumFormatString;partsTable:NumberParts;
                          Var outString:String):FormatStatus;Forward;

{$ENDIF}