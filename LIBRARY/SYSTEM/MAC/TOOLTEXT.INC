{ToolText.Inc}

{$IFNDEF __ToolText}
 {$DEFINE __ToolText}

{$I \Source\Chantal\Library\System\Mac\Types\Base.Inc}

Const
  { �tat des valeurs de StringToDate & StringToTime }
 longDateFound=1;         { Masque � longue date trouv� }
 leftOverChars=2;         { Masque d'avertissement de gauche sur les caract�res }
 sepNotIntlSep=4;         { Masque d'avertissement des s�parateurs non-standard }
 fieldOrderNotIntl=8;     { Masque d'avertissement d'ordre de champs non-standard }
 extraneousStrings=16;    { Masque d'avertissement d'une cha�ne de caract�re en texte "unparsable" }
 tooManySeps=32;          { Masque d'avertissement de beaucoup trop de s�parateur }
 sepNotConsistent=64;     { Masque d'avertissement des s�parateurs inconsistant }
 fatalDateTime=$8000;     { Masque d'un erreur fatale }
 tokenErr=$8100;          { Masque pour 'tokenizer err encountered' }
 cantReadUtilities=$8200; { Masque pour ne pas avoir besoin d'acc�der au resource }
 dateTimeNotFount=$8400;  { Masque pour l'heure et la date introuvable }
 dateTimeInvalid=$8800;   { Masque pour le format du temps invalide }

  { Constantes pour o� trunquer l'argument dans TruncString & TruncText }
 truncEnd=0;        { Tronque � la fin }
 truncMiddle=$4000; { Tronque au milieu }

  { Constantes pour le r�sultat de TruncString & TruncText }
 NoTruncated=0; { N'est pas n�cessairement tronqu� }
 Truncated=1;   { Tronquage accomplie }
 TruncErr=-1;   { Erreur g�n�ral }

  { Code des valeurs de langage sp�cial pour un autre langage }
 systemCurLang=-2;  { Langage courant pour le scripte du syst�me (de 'itlb') }
 systemDefLang=-3;  { Langage par d�faut pour le scripte du syst�me (de 'itlm') }
 currentCurLang=-4; { Langage courant pour le scripte courant (de 'itlb') }
 currentDefLang=-5; { Langage par d�faut pour le scripte courant (de 'itlm') }
 scriptCurLang=-6;  { Langage courant pour le scripte sp�cifi� (de 'itlb') }
 scriptDefLang=-7;  { Langage par d�faut pour le scripte sp�cifi� (de 'itlb') }

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

 { D�finition et sp�cification des cha�nes de caract�res }
Function  NewString(theString:String):StringHandle;Forward;
Procedure SetString(theString:StringHandle;StrNew:String);Forward;
Function  GetString(stringID:Integer):StringHandle;Forward;
Procedure GetIndString(Var theString:String;strListID,index:Integer);Forward;

 { Compare l'�galit� des cha�nes de caract�re }
Function EqualString(aStr,bStr:String;caseSens,diacSens:Boolean):Boolean;Forward;
Function IdenticalString(aStr,bStr:String;itl2Handle:Handle):Integer;Forward;
Function IdenticalText(aPtr,bPtr:Ptr;aLen,bLen:Integer;itl2Handle:Handle):Integer;Forward;

 { D�termine l'ordre des cha�nes de caract�re dans les diff�rents langage }
Function ScriptOrder(script1,script2:ScriptCode):Integer;Forward;
Function LanguageOrder(lang1,lang2:LangCode):Integer;Forward;
Function StringOrder(aStr,bStr:String;aScript,bScript:ScriptCode;aLang,bLang:LangCode):Integer;Forward;
Function TextOrder(aPtr,bPtr:Ptr;aLen,bLen:Integer;aScript,bScript:ScriptCode;aLang,bLang:LangCode):Integer;Forward;

 { D�termine l'ordre des cha�nes de caract�re pour les m�mes langage }
Function RelString(aStr,bStr:String;caseSens,diacSens:Boolean):Integer;Forward;
Function CompareString(aStr,bStr:String;itl2Handle:Handle):Integer;Forward;
Function CompareText(aPtr,bPtr:Ptr;aLen,bLen:Integer):Integer;Forward;

 { Modification des caract�res et des marques "Diacritical" }
Procedure UpperString(Var thString:String;diacSens:Boolean);Forward;
Procedure LowercaseText(textPtr:Ptr;Len:Integer;script:ScriptCode);Forward;
Procedure UppercaseText(textPtr:Ptr;Len:Integer;script:ScriptCode);Forward;
Procedure StripDiacritics(textPtr:Ptr;Len:Integer;ScriptCode);Forward;
Procedure UppercaseStripDiacritics(textPtr:Ptr;Len:Integer;script:ScriptCode);Forward;

 { Tronqu� les cha�nes de caract�re }
Function TruncString(width:Integer;Var theString:String;truncWhere:TruncCode):Integer;Forward;
Function TruncText(width:Integer;textPtr:Ptr;Var Length:Integer;truncWhere:TruncCode):Integer;Forward;

 { Rechercher pour et replacage de cha�ne de caract�re }
Function ReplaceText(baseText:substitutionText:Handle;key:Str15):Integer;Forward;
Function Munger(h:Handle;offset:LongInt;ptr1:Ptr;len1:LongInt;ptr2:Ptr;Len2:LongInt):LongInt;Forward;

 { Travaille avec Mot, Sous-Scripte, et Ligne destinaire }
Procedure FindWorkBreaks(textPtr:Ptr;textLength,offset:Integer;leadingEdge:Boolean;
                         nBreaks:NBreakTablePtr;Var offsets:OffsetTable);Forward;
Function  StyledLineBreak(textPtr:Ptr;TextLen:LongInt;textStart,textEnd,flags:LongInt;
                          Var textWidth:Fixed;Var TextOffset:LongInt):StyledLineBreakCode;Forward;
Function  FindScriptRun(textPtr:Ptr;textLen:LongInt;Var LenUsed:LongInt):ScriptRunStatus;Forward;

 { Conversion des cha�nes de caract�re de la Date et de l'Heure en leurs repr�sentations num�rique }
Function InitDateCache(theCache:DateCachePtr):OSErr;
Function StringToDate(textPtr:Ptr;textLen:LongInt;theCache:DateCachePtr;Var LengthUsed;LongInt;
                      Var dateTie:LongDateRec):StringToDateStatus;Forward;
Function StringToTime(textPtr:Ptr;textLen:LongInt;theCache:DateCachePtr;Var lengthUsed:LongInt;
                      Var dateTime:LongDateRec):StringToDateStatus;Forward;

 { Conversion de leurs repr�sentations num�rique en des cha�nes de caract�re de la Date et de l'Heure }
Procedure DateString(dateTime:LongInt;longFlag:DateForm;Var Result:String;intlHandle:Handle);Forward;
Procedure TimeString(dateTime:LongInt;wantSeconds:Boolean;Var Result:String;intlHandle:Handle);Forward;

 { Conversion longue de la valeur de la Date et de l'Heure en cha�ne de caract�re }
Procedure LongDateString(Var dateTime:LongDateTime;longFlag:DateForm;Var result:String;intlHandle:Handle);Forward;
Procedure LongTimeString(Var dateTime:LongDateTime;wantSeconds:Boolean;Var result:String;intlHandle:Handle);Forward;

 { Conversion entre Entier et cha�nes de caract�res }
Procedure NumToString(theNum:LongInt;Var theString:String);Forward;
Procedure StringToNum(theString:String;Var theNum:LongInt);Forward;

 { Utilisation de format de nombre sp�cifique � des cha�nes de caract�re pour les
   formats de nombre International }
Function StringToFormatRec(inString:String;partsTable:NumberParts;Var outString:NumFormatString):ForamtStatus;Forward;
Function FormatRecToString(myFormatRec:NumFormatString;partTable:NumberParts;Var outString:String;
                           Var positions:TripleInt):FormatStatus;Forward;

 { Conversion entre cha�ne de caract�re et nombre � virgule flottante }
Function StringToExtended(source:String;myFormatRec:NumFormatString;
                          partsTable:NumberParts;Var X:Extended80):FormatStatus;Forward;
Function ExtendedToString(x:Extended80;myFormatRec:NumFormatString;partsTable:NumberParts;
                          Var outString:String):FormatStatus;Forward;

{$ENDIF}