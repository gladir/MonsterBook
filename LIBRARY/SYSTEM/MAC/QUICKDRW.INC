{QuickDrw.Inc}

{$IFNDEF __QuickDraw}
 {$DEFINE __QuickDraw}

Const
  { Direction de CharToPixel }
 leftCaret=0;   { Place le "caret" pour le bloc de gauche }
 rightCaret=-1; { Place le "caret" pour le bloc de droite }
 hilite=1;      { Direction du SysDirection }

  { Constante pour les paramŠtres styleRunPosition dans PortionLine, DrawJustified,
    MeasureJustified, CharToPixel, & PixelToChar }
 onlyStyleRun=0;   { C'est seulement le style d'ex‚cution dans la ligne }
 leftStyleRun=1;   { C'est l'extrˆme gauche de style multiple ex‚cut‚ dans la ligne }
 rightStyleRun=2;  { C'est l'extrˆme droite de style multiple ex‚cut‚ dans la ligne }
 middleStyleRun=3; { Ce sont des styles multiple combinaisons de leftStyleRun & rightStyleRun }

Type
  { D‚claration de type pour GetFontInfo dans la variable de parmˆtre }
 FontInfo=Record ascent,descent,winMax,leading:Integer;End;

  { ChaŒnage de l'ordre de GetFormatOrder }
 FormatOrder=Array[0..0] of Integer;
 FormatOrderPtr=^FormatOrder;
 FormatStatus=Integer;

{$I \Source\Chantal\Library\System\Mac\Types\Style.Inc}

 { Ajustement des caract‚ristiques textes }
Procedure TextFont(font:Integer);Forward;
Procedure TextFace(face:Style);Forward;
Procedure TextMode(mode:Integer);Forward;
Procedure TextSize(size:Integer);Forward;
Procedure SpaceExtra(extra:Fixed);Forward;
Procedure CharExtra(extra:Fixed);Forward;
Procedure GetFontInfo(Var Info:FontInfo);Forward;

 { Dessinage de texte }
Procedure DrawChar(ch:Char);Forward;
Procedure DrawString(s:String);Forward;
Procedure DrawText(textBuf:Ptr;firstByte,byteCount:Integer);Forward;
Procedure DrawJustified(txtPtr:Ptr;txtLen:LongInt;slop:Fixed;styleRunPos:JustStyleCode;numer:Point;dn:Point);Forward;

 { Mesurage du texte }
Function  CharWidth(ch:Char):Integer;Forward;
Function  StringWidth(st:String):Integer;Forward;
Function  TextWidth(textBuf:Ptr;firstByte,byteCount:Integer):Integer;Forward;
Procedure MeasureText(count:Integer;textAddr:charLocs:Ptr);Forward;
Procedure MeasureJustified(tP:Ptr;tL:LongInt;slop:Fixed;chrLocs:Ptr;sRP:JustStyleCode;numer,denom:Point);Forward;

 { Sortir des fins de ligne texte }
Procedure GetFormatOrder(o:FormatOrderPtr;fF:Integer;lF:Integer;lR:Boolean;rDP:Ptr;dirParam:Ptr);Forward;
Function  VisibleLength(textPtr:Ptr;textLength:LongInt):LongInt;Forward;
Function  PortionLine(textPtr:Ptr;textLen:LongInt;sRP:JustifyStyleCode;numer,denom:Point):Fixed;Forward;

 { D‚termination la position "Caret", et s‚lection et texte "Hightlighting" }
Function  PixelToChar(tB:PTr;tL:LongInt;sl,pW:Fixed;Var lE:Boolean;Var wRP:JustStyleCode;n,d:Point):Integer;Forward;
Function  CharToPixel(tB:Ptr;tL:LongInt;s:Fixed;o:LongInt;dir:Integer;sRP:JustStyleCode;n,d:Point):Integer;Forward;
Procedure HiliteText(textPtr:Ptr;textLength,firstOffset,secondOffset:Integer;Var Offset:OffsetTable);Forward;

 { Bas niveau des routines texte du QuickDraw }
Procedure StdText(count:Integer;textAddr:Ptr;numer,denom:Point);Forward;
Function  StdMxMeas(byteCount:Integer;textAddr:Ptr;Var numer,denom:Point;Var info:FontInfo):Integer;Forward;

 { Routine flexible d'Application }
Function  MyRlDirProc(theFormat:Integer;dirParam:Ptr):Boolean;Forward;

{$ENDIF}