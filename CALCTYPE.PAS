Unit CalcType;

INTERFACE

Uses Systex;

Const
 Letters:Set of Char=['A'..'Z', 'a'..'z'];
 Numbers:Set of Char=['0'..'9'];

 LotusColors:Record
  Col:Byte;
  Row:Byte;
  Info:Byte;
  Blank:Byte;
  Input:Byte;
  Block:Byte;
  Changed:Byte;
  CellError:Byte;
  CellData:Byte;
  TextCell:Byte;
  ValueCell:Byte;
  FormulaCell:Byte;
  RepeatCell:Byte;
  HighLight:Byte;
  InputArrow:Byte;
  Prompt:Byte;
  FileName:Byte;
 End=(
  Col:$D0;
  Row:$D0;
  Info:$B9;
  Blank:$10;
  Input:$0E;
  Block:$6E;
  Changed:$BC;
  CellError:$CF;
  CellData:$B1;
  TextCell:$1C;
  ValueCell:$19;
  FormulaCell:$1D;
  RepeatCell:$1A;
  HighLight:$09;
  InputArrow:$2E;
  Prompt:$96;
  FileName:$B8
 );

 MaxLStringLength=65521;

 LeftInputArrow=#17;
 RightInputArrow=#16;
 AllUpper=Ya;
 NotUpper=No;
 ErrCellError='Vous devez entr‚e une cellule valide';

 MaxBuckets=1000;
 MaxHashItemSize=256;

 DollarString=' $ ';
 RepeatFirstChar='\';
 TextFirstChar=' ';
 EmptyCellName='Vide';
 ValueCellName='Valeur';
 TextCellName='Texte';
 FormulaCellName='Formule';
 RepeatCellName='R‚p‚tition';
 DecPlacesPart=$0F;
 JustShift=4;
 JustPart=$03;
 DollarPart=$40;
 CommasPart=$80;

 SCreate=$3C00;
 SOpenRead=$3D00;
 SOpenWrite=$3D01;
 SOpen=$3D02;

 DefMaxCols=65535;
 DefMaxRows=65535;
 DefMaxDecimalPlaces=8;
 DefDecimalPlaces=4;
 DefColWidth=10;
 EmptyRowsAtTop=1;
 EmptyRowsAtBottom=2;
 MinColWidth=3;

 FreeListItems=1000;
 ParserStackSize=10;
 MaxFuncNameLen=5;
 ExpLimit=11356;
 SqrLimit=1E2466;
 MaxExpLen=4;
 TotalErrors=7;
 ErrParserStack=1;
 ErrBadRange=2;
 ErrExpression=3;
 ErrOperator=4;
 ErrOpenParen=5;
 ErrCell=6;
 ErrOpCloseParen=7;
 PrintNormalCols=80;
 PrintCompressedCols=132;
 PrintRows=66;
 PrintTopMargin=1;
 PrintBottomMargin=1;

 FileHeader='Malte Genesis Calculator'^Z;
 TempFileName='TEMP.TMP';
 PrinterName='PRN';
 PromptColumnWidth='Colonne … changer';
 PromptNewWidth='Nouvelle largeur';
 PromptColumnDelete='Colonne … effacer';
 PromptColumnInsert='Insertion d''une nouvelle colonne avant la colonne';
 PromptRowDelete='Ligne … effacer';
 PromptRowInsert='Insertion de nouvelle ligne avant cette ligne';
 PromptSaveYN='Sauvegarde le tableau';
 ErrNoOpen='Impossible d''ouvrir le fichier';
 ErrPrinterError='Erreur d''impression';
 ErrNotSpreadsheet='Ce n''est pas un fichier MGC';
 MsgRecalc='Recalculation des valeurs des cellules';
 MsgSave='Sauvegarde du tableau';
 MsgLoad='Chargement du tableau';
 MsgBlockDelete='Efface le bloc';
 LegalJustification=['L','C','R'];
 _HelpLine='F2 Sauve F3 Charge F7 Formule F8 AutoCalc F9 Recalc';
 PromptFileLoad='Fichier … charger';
 PromptColLiteral='Copy formula columns literally';
 PromptRowLiteral='Copy formula rows literally';
 PromptCopySpreadsheet='Copy to spreadsheet number (0=current)';
 PromptFormatPlaces='Places des nombres d‚cimal';
 PromptFormatJustification='Justification - (L)eft, (C)enter, (R)ight';
 PromptFormatDollar='Format dollar';
 PromptFormatCommas='Mettre une virgule entre les nombres';
 ErrFreeList='La liste libre est pleine';
 MsgBlockCopy='Copie un bloque';

 ErrorMessages:Array[1..TotalErrors]of String[33]=(
  'Parser stack overflow',
  'Mauvaise rang‚e de cellule',
  'Expression attendu',
  'Op‚rateur attendu',
  '''('' attendu',
  'Cellule attendu',
  'Op‚rateur ou '')'' attendu');

Type
 ScreenPos=Record Col,Row:Byte;End;
 ScreenArea=Record
  UpperLeft,LowerRight:ScreenPos; Attrib:Byte;
 End;

 LStringRange=0..MaxLStringLength;
 LStringData=Array[1..MaxLStringLength]of Char;
 LStringDataPtr=^LStringData;
 LStringPtr=^LString;
 LString=Record
  Len:LStringRange;
  MaxLen:LStringRange;
  Data:LStringDataPtr;
 End;

 STypeListPtr=^STypeList;
 STypeList=Array[1..256]of Wd;
 SProcListPtr=^SProcList;
 SProc=Object StoreProc,LoadProc:Pointer; End;
 SProcList=Array[1..256]of SProc;

 ErrorRange=0..TotalErrors;
 TokenTypes=(Plus,Minus,Times,Divide,Expo,Colon,OParen,CParen,Num,CellT,Func,EOL,Bad);

 CellTypes=(ClEmpty,ClValue,ClText,ClFormula,ClRepeat);
 CellPos=Record Col,Row:Wd; End;
 Justification=(JLeft,JCenter,JRight);
 DollarStr=String[Length(DollarString)];

 TokenRec=Record
  State:Byte;
  Case Byte of
   0:(Value:Extended);
   1:(CP:CellPos);
   2:(FuncName:String[MaxFuncNameLen]);
 End;

IMPLEMENTATION

END.