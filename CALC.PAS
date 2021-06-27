{Remarque
 ÍÍÍÍÍÍÍÍ

  þ Cette unit‚ est bƒtie … partir du tableau de Borland Turbo Pascal 5.5.
}

Unit Calc;

INTERFACE
{$I DEF.INC}

Uses {$IFDEF Adele}Adele,{$ELSE}Chantal,{$ENDIF}
     Systex,Systems,Video,Dials,Dos,Numerix,CalcType;

Function GetKeyUpCase:Wd;
Function GetKeyChar(Legal:CharSet):Char;
Function Col2Str(Col:Wd):String;
Function Str2Col(S:String;MaxCols:Wd):Wd;
Function Str2Row(Const S:String;MaxRows:Wd):Wd;

Type
 BasePtr=^Base;
 Base=Object
  Destructor Done;Virtual;
 End;

 StreamPtr=^Stream;
 Stream=Object(Base)
  TypeCount:Wd;
  TypeList:STypeListPtr;
  ProcList:SProcListPtr;
  Status:Int;
  Constructor Init;
  Destructor Done;Virtual;
  Procedure Error(Code:Int);Virtual;
  Procedure Flush;Virtual;
  Function GetPos:Long;Virtual;
  Procedure Read(Var Buf;Count:Wd);Virtual;
  Procedure RegisterTypes;Virtual;
  Procedure SetPos(Pos:Long;Mode:Byte);Virtual;
  Procedure Truncate; Virtual;
  Procedure Write(Var Buf;Count:Wd);Virtual;
  Function Get:BasePtr;
  Function GetSize:Long;
  Procedure Put(B:BasePtr);
  Procedure Register(TypePtr,StorePtr,LoadPtr:Pointer);
  Procedure Seek(Pos:Long);
 End;

 DosStreamPtr=^DosStream;
 DosStream=Object(Stream)
  Handle:Wd;
  Constructor Init(FileName:PathStr;Mode:Wd);
  Destructor Done;Virtual;
  Function GetPos:Long;Virtual;
  Procedure Read(Var Buf;Count:Wd);Virtual;
  Procedure SetPos(Pos:Long;Mode:Byte);Virtual;
  Procedure Truncate;Virtual;
  Procedure Write(Var Buf;Count:Wd);Virtual;
  Procedure Close;
  Procedure Open(Var Name;Mode:Wd);
 End;

 BufStreamPtr=^BufStream;
 BufStream=Object(DosStream)
  Buffer:Pointer; BufSize,BufPtr,BufEnd:Wd;
  Constructor Init(FileName:PathStr;Mode,Size:Wd);
  Destructor Done; Virtual;
  Procedure Flush; Virtual;
  Function GetPos:Long; Virtual;
  Procedure Read(Var Buf;Count:Wd); Virtual;
  Procedure Write(Var Buf;Count:Wd); Virtual;
 End;

 InputField=Record
  W:Wins; StartCol:Byte; StopCol,InputRow:Int; MaxInputLen:Wd;
  Quit:Bool;InputData:LStringPtr;UCase:Bool;
  {InputArea:ScreenArea;}
 End;

 BucketRange=1..MaxBuckets;
 HashItemSizeRange=1..MaxHashItemSize;
 HashItemData=Array[0..Pred(MaxHashItemSize)]of Byte;
 HashItemDataPtr=^HashItemData;
 HashItemPtr=^HashItem;
 HashItem=Record Next:HashItemPtr; Data:HashItemData; End;
 HashItemArray=Array[BucketRange]of HashItemPtr;
 HashTable=Object
  Buckets:BucketRange; Items:Long; CurrItem:HashItemPtr;
  CurrBucket:BucketRange; HashData:^HashItemArray;
  Constructor Init(InitBuckets:BucketRange);
  Destructor Done;
  Function Add:Bool;
  Procedure Delete(Deleted:Pointer);
  Function FirstItem:HashItemPtr;
  Function NextItem:HashItemPtr;
  Function Change:Bool;
  Function Search:HashItemPtr;
  Function HashValue:Wd;Virtual;
  Function Found(Item:HashItemPtr):Bool;Virtual;
  Procedure CreateItem(Var Item:HashItemPtr);Virtual;
  Function ItemSize:HashItemSizeRange;Virtual;
  Function CurrItemSize(Item:HashItemPtr):HashItemSizeRange;Virtual;
 End;

 SSStream=Object(DosStream)Procedure RegisterTypes;Virtual;End;

 Block=Record
  Start,Stop:CellPos;
 End;

 CellHashTablePtr=^CellHashTable;
 CellPtr=^Cell;
 CellHashTable=Object(HashTable)
  CurrCell:CellPtr;
  CurrLoc:CellPos;
  Constructor Init(InitBuckets:BucketRange);
  Destructor Done;
  Function Add(ACell:CellPtr):Bool;
  Procedure Delete(DelLoc:CellPos;Var DeletedCell:CellPtr);
  Function Search(SPos:CellPos):CellPtr;
  Function HashValue:Wd;Virtual;
  Function Found(Item:HashItemPtr):Bool;Virtual;
  Procedure CreateItem(Var Item:HashItemPtr);Virtual;
  Function ItemSize:HashItemSizeRange;Virtual;
  Procedure Load(Var S:SSStream;Total:Long);
  Procedure Store(Var S:SSStream);
  Function FirstItem:CellPtr;
  Function NextItem:CellPtr;
 End;

 FormatHashTable=Object(HashTable)
  CurrStart,CurrStop:CellPos;
  CurrFormat:Byte;
  Constructor Init;
  Destructor Done;
  Function Overwrite(NewStart,NewStop:CellPos):Bool;
  Function Add(NewStart,NewStop:CellPos;NewFormat:Byte):Bool;
  Function Delete(DStart,DStop:CellPos):Bool;
  Function Search(SPos:CellPos;Var F:Byte):Bool;
  Function HashValue:Wd;Virtual;
  Function Found(Item:HashItemPtr):Bool;Virtual;
  Procedure CreateItem(Var Item:HashItemPtr);Virtual;
  Function ItemSize:HashItemSizeRange;Virtual;
  Procedure Load(Var S:SSStream;Total:Long);
  Procedure Store(Var S:SSStream);
 End;

 WidthHashTable=Object(HashTable)
  CurrCol:Wd; CurrWidth,DefaultColWidth:Byte;
  Constructor Init(InitBuckets:BucketRange;InitDefaultColWidth:Byte);
  Destructor Done;
  Function Add(SCol:Wd;NewWidth:Byte):Bool;
  Procedure Delete(Col:Wd);
  Function Search(Col:Wd):Byte;
  Function HashValue:Wd;Virtual;
  Function Found(Item:HashItemPtr):Boolean;Virtual;
  Procedure CreateItem(Var Item:HashItemPtr);Virtual;
  Function ItemSize:HashItemSizeRange;Virtual;
  Function GetDefaultColWidth:Byte;
  Procedure Load(Var S:SSStream;Total:Long);
  Procedure Store(Var S:SSStream);
 End;

 OverwriteHashTable=Object(HashTable)
  CurrCell:CellPtr; CurrPos:CellPos; EndCol:Wd;
  Constructor Init(InitBuckets:BucketRange);
  Destructor Done;
  Function Add(SCell:CellPtr;Overwritten:Wd):Bool;
  Procedure Delete(SPos:CellPos);
  Function Change(SCell:CellPtr;Overwritten:Wd):Bool;
  Function Search(SPos:CellPos):CellPtr;
  Function HashValue:Wd;Virtual;
  Function Found(Item:HashItemPtr):Bool;Virtual;
  Procedure CreateItem(Var Item:HashItemPtr);Virtual;
  Function ItemSize:HashItemSizeRange;Virtual;
 End;

 GetColWidthFunc=Function(Var WHash:WidthHashTable;C:Wd):Byte;

 Cell=Object(Base)
  Loc:CellPos;
  Constructor Init(InitLoc:CellPos);
  Destructor Done;Virtual;
  Function CellType:CellTypes;Virtual;
  Function LegalValue:Bool;Virtual;
  Function Name:String;Virtual;
  Function Format(Var FHash:FormatHashTable;FormulasDisplayed:Bool):Byte;Virtual;
  Function Width(Var FHash:FormatHashTable;FormulasDisplayed:Bool):Wd;Virtual;
  Function Overwritten(Var CHash:CellHashTable;Var FHash:FormatHashTable;
   Var WHash:WidthHashTable;Var LastPos:CellPos;MaxCols:Wd;
   GetColWidth:GetColWidthFunc;FormulasDisplayed:Bool):Wd;Virtual;
  Function ShouldUpdate:Bool;Virtual;
  Function HasError:Bool;Virtual;
  Function CurrValue:Extended;Virtual;
  Function OverwriteStart(Var FHash:FormatHashTable;Var WHash:WidthHashTable;
   GetColWidth:GetColWidthFunc;EndCol:Wd;DisplayFormulas:Bool):Wd;Virtual;
  Procedure EditString(MaxDecPlaces:Byte;Var L:LStringPtr);Virtual;
  Function DisplayString(FormulasDisplayed:Bool;MaxDecPlaces:Byte):String;Virtual;
  Function FormattedString(Var OHash:OverwriteHashTable;Var FHash:FormatHashTable;
   Var WHash:WidthHashTable;GetColWidth:GetColWidthFunc;CPos:CellPos;
   FormulasDisplayed:Bool;Start:Wd;ColWidth:Byte;Var DString:DollarStr;
   Var Color:Byte):String;Virtual;
  Function CopyString(ColLit,RowLit:Bool;Diff:Long;Var L:LStringPtr):LStringPtr;Virtual;
 End;

 EmptyCellPtr=^EmptyCell;
 EmptyCell=Object(Cell)
  Constructor Init;
  Function CellType:CellTypes;Virtual;
  Function LegalValue:Bool;Virtual;
  Function Name:String;Virtual;
  Function Format(Var FHash:FormatHashTable;FormulasDisplayed:Bool):Byte;Virtual;
  Function Width(Var FHash:FormatHashTable;FormulasDisplayed:Bool):Wd;Virtual;
  Function Overwritten(Var CHash:CellHashTable;Var FHash:FormatHashTable;
   Var WHash:WidthHashTable;Var LastPos:CellPos;MaxCols:Wd;
   GetColWidth:GetColWidthFunc;FormulasDisplayed:Boolean):Wd;Virtual;
  Function ShouldUpdate:Bool;Virtual;
  Function HasError:Bool;Virtual;
  Function CurrValue:Extended;Virtual;
  Function OverwriteStart(Var FHash:FormatHashTable;Var WHash:WidthHashTable;
   GetColWidth:GetColWidthFunc;EndCol:Wd;DisplayFormulas:Bool):Wd;Virtual;
  Procedure EditString(MaxDecPlaces:Byte;Var L:LStringPtr);Virtual;
  Function DisplayString(FormulasDisplayed:Bool;MaxDecPlaces:Byte):String;Virtual;
  Function FormattedString(Var OHash:OverwriteHashTable;Var FHash:FormatHashTable;
   Var WHash:WidthHashTable;GetColWidth:GetColWidthFunc;CPos:CellPos;
   FormulasDisplayed:Bool;Start:Wd;ColWidth:Byte;Var DString:DollarStr;
   Var Color:Byte):String;Virtual;
  Function CopyString(ColLit,RowLit:Bool;Diff:Long;Var L:LStringPtr):LStringPtr;Virtual;
 End;

 ValueCellPtr=^ValueCell;
 ValueCell=Object(Cell)
  Error:Bool; Value:Extended;
  Constructor Init(InitLoc:CellPos;InitError:Bool;InitValue:Extended);
  Function CellType:CellTypes;Virtual;
  Function LegalValue:Bool;Virtual;
  Function Name:String;Virtual;
  Function Format(Var FHash:FormatHashTable;FormulasDisplayed:Bool):Byte;Virtual;
  Function Width(Var FHash:FormatHashTable;FormulasDisplayed:Bool):Wd;Virtual;
  Function Overwritten(Var CHash:CellHashTable;Var FHash:FormatHashTable;
   Var WHash:WidthHashTable;Var LastPos:CellPos;MaxCols:Wd;
   GetColWidth:GetColWidthFunc;FormulasDisplayed:Boolean):Wd;Virtual;
  Function ShouldUpdate:Bool;Virtual;
  Function HasError:Bool;Virtual;
  Function CurrValue:Extended;Virtual;
  Function OverwriteStart(Var FHash:FormatHashTable;Var WHash:WidthHashTable;
   GetColWidth:GetColWidthFunc;EndCol:Wd;DisplayFormulas:Bool):Wd;Virtual;
  Procedure EditString(MaxDecPlaces:Byte;Var L:LStringPtr);Virtual;
  Function DisplayString(FormulasDisplayed:Bool;MaxDecPlaces:Byte):String;Virtual;
  Function FormattedString(Var OHash:OverwriteHashTable;Var FHash:FormatHashTable;
   Var WHash:WidthHashTable;GetColWidth:GetColWidthFunc;CPos:CellPos;
   FormulasDisplayed:Bool;Start:Wd;ColWidth:Byte;Var DString:DollarStr;
   Var Color:Byte):String;Virtual;
  Function CopyString(ColLit,RowLit:Bool;Diff:Long;Var L:LStringPtr):LStringPtr;Virtual;
  Constructor Load(Var S:SSStream);
  Procedure Store(Var S:SSStream);
 End;

 TextCellPtr=^TextCell;
 TextCell=Object(Cell)
  Txt:LStringPtr;
  Constructor Init(InitLoc:CellPos;InitTxt:LStringPtr);
  Destructor Done;Virtual;
  Function CellType:CellTypes;Virtual;
  Function LegalValue:Bool;Virtual;
  Function Name:String;Virtual;
  Function Format(Var FHash:FormatHashTable;FormulasDisplayed:Bool):Byte;Virtual;
  Function Width(Var FHash:FormatHashTable;FormulasDisplayed:Bool):Wd;Virtual;
  Function Overwritten(Var CHash:CellHashTable;Var FHash:FormatHashTable;
   Var WHash:WidthHashTable;Var LastPos:CellPos;MaxCols:Wd;
   GetColWidth:GetColWidthFunc;FormulasDisplayed:Bool):Wd;Virtual;
  Function ShouldUpdate:Bool;Virtual;
  Function HasError:Bool;Virtual;
  Function CurrValue:Extended;Virtual;
  Function OverwriteStart(Var FHash:FormatHashTable;Var WHash:WidthHashTable;
   GetColWidth:GetColWidthFunc;EndCol:Wd;DisplayFormulas:Bool):Wd;Virtual;
  Procedure EditString(MaxDecPlaces:Byte;Var L:LStringPtr);Virtual;
  Function DisplayString(FormulasDisplayed:Bool;MaxDecPlaces:Byte):String;Virtual;
  Function FormattedString(Var OHash:OverwriteHashTable;Var FHash:FormatHashTable;
   Var WHash:WidthHashTable;GetColWidth:GetColWidthFunc;CPos:CellPos;
   FormulasDisplayed:Bool;Start:Wd;ColWidth:Byte;Var DString:DollarStr;
   Var Color:Byte):String;Virtual;
  Function CopyString(ColLit,RowLit:Bool;Diff:Long;Var L:LStringPtr):LStringPtr;Virtual;
  Constructor Load(Var S:SSStream);
  Procedure Store(Var S:SSStream);
 End;

 FormulaCellPtr=^FormulaCell;
 FormulaCell=Object(Cell)
  Error:Bool; Value:Extended; Formula:LStringPtr;
  Constructor Init(InitLoc:CellPos;InitError:Bool;InitValue:Extended;InitFormula:LStringPtr);
  Destructor Done;Virtual;
  Function CellType:CellTypes;Virtual;
  Function LegalValue:Bool;Virtual;
  Function Name:String;Virtual;
  Function Format(Var FHash:FormatHashTable;FormulasDisplayed:Bool):Byte;Virtual;
  Function Width(Var FHash:FormatHashTable;FormulasDisplayed:Bool):Wd;Virtual;
  Function Overwritten(Var CHash:CellHashTable;Var FHash:FormatHashTable;
   Var WHash:WidthHashTable;Var LastPos:CellPos;MaxCols:Wd;
   GetColWidth:GetColWidthFunc;FormulasDisplayed:Bool):Wd;Virtual;
  Function ShouldUpdate:Bool;Virtual;
  Function HasError:Bool;Virtual;
  Function CurrValue:Extended;Virtual;
  Function OverwriteStart(Var FHash:FormatHashTable;Var WHash:WidthHashTable;
   GetColWidth:GetColWidthFunc;EndCol:Wd;DisplayFormulas:Bool):Wd;Virtual;
  Procedure EditString(MaxDecPlaces:Byte;Var L:LStringPtr);Virtual;
  Function DisplayString(FormulasDisplayed:Bool;MaxDecPlaces:Byte):String;Virtual;
  Function FormattedString(Var OHash:OverwriteHashTable;Var FHash:FormatHashTable;
   Var WHash:WidthHashTable;GetColWidth:GetColWidthFunc;CPos:CellPos;
   FormulasDisplayed:Bool;Start:Wd;ColWidth:Byte;Var DString:DollarStr;
   Var Color:Byte):String;Virtual;
  Function CopyString(ColLit,RowLit:Bool;Diff:Long;Var L:LStringPtr):LStringPtr;Virtual;
  Constructor Load(Var S:SSStream);
  Procedure Store(Var S:SSStream);
  Function GetFormula:LStringPtr;
 End;

 RepeatCellPtr=^RepeatCell;
 RepeatCell=Object(Cell)
  RepeatChar:Char;
  Constructor Init(InitLoc:CellPos;InitChar:Char);
  Function CellType:CellTypes;Virtual;
  Function LegalValue:Bool;Virtual;
  Function Name:String;Virtual;
  Function Format(Var FHash:FormatHashTable;FormulasDisplayed:Bool):Byte;Virtual;
  Function Width(Var FHash:FormatHashTable;FormulasDisplayed:Bool):Wd;Virtual;
  Function Overwritten(Var CHash:CellHashTable;Var FHash:FormatHashTable;
   Var WHash:WidthHashTable;Var LastPos:CellPos;MaxCols:Wd;
   GetColWidth:GetColWidthFunc;FormulasDisplayed:Bool):Wd;Virtual;
  Function ShouldUpdate:Bool;Virtual;
  Function HasError:Bool;Virtual;
  Function CurrValue:Extended;Virtual;
  Function OverwriteStart(Var FHash:FormatHashTable;Var WHash:WidthHashTable;
   GetColWidth:GetColWidthFunc;EndCol:Wd;DisplayFormulas:Bool):Wd;Virtual;
  Procedure EditString(MaxDecPlaces:Byte;Var L:LStringPtr);Virtual;
  Function DisplayString(FormulasDisplayed:Bool;MaxDecPlaces:Byte):String;Virtual;
  Function FormattedString(Var OHash:OverwriteHashTable;Var FHash:FormatHashTable;
   Var WHash:WidthHashTable;GetColWidth:GetColWidthFunc;CPos:CellPos;
   FormulasDisplayed:Bool;Start:Wd;ColWidth:Byte;Var DString:DollarStr;
   Var Color:Byte):String;Virtual;
  Function CopyString(ColLit,RowLit:Bool;Diff:Long;Var L:LStringPtr):LStringPtr;Virtual;
  Constructor Load(Var S:SSStream);
  Procedure Store(Var S:SSStream);
 End;

 ParserObj=Record
  Inp:LStringPtr;
  ParserHash:CellHashTablePtr;
  PMaxCols,PMaxRows,Position:Wd;
  CurrToken:TokenRec;
  StackTop:0..ParserStackSize;
  TokenError:ErrorRange;
  ParseError:Bool;
  CType:CellTypes;
  ParseValue:Extended;
  Stack:Array[1..ParserStackSize]of TokenRec;
  TokenType:TokenTypes;
  TokenLen:Wd;
  MathError,IsFormula:Bool;
 End;

 ColStartArray=Array[0..80]of Byte;
 ColStartPtr=^ColStartArray;
 SpreadsheetPtr=^Spreadsheet;
 Spreadsheet=Record
  W:Wins;Number:Byte;MaxRows,MaxCols:Wd;
  MaxDecimalPlaces,MaxColWidth,MaxScreenCols,DefaultColWidth:Byte;
  DefaultDecimalPlaces,RowNumberSpace,ColSpace:Byte; Current,Changed:Bool;
  CurrPos,LastPos:CellPos; ScreenBlock,CurrBlock:Block; BlockOn:Bool;
  FileName:PathStr; TotalRows:Byte; DisplayArea,BlankArea:ScreenArea;
  NoBlankArea:Bool; ColStart:ColStartPtr; DisplayFormulas,AutoCalc:Bool;
  CellHash:CellHashTable; OverwriteHash:OverwriteHashTable;
  WidthHash:WidthHashTable; FormatHash:FormatHashTable; Next:SpreadsheetPtr;
 End;

 Lotus=Record
  W:Wins;
  SSData,CurrSS:SpreadSheetPtr;TotalSheets:Byte;
  CellInput:InputField;MaxSpreadSheets:Byte;
 End;

Function  IFInit(Var Q:InputField;C1:Byte;C2,R:Int;InitMaxInputLen:Wd;InitUCase:Bool):Bool;
Procedure IFDone(Var Q:InputField);
Function  IFGetQuit(Var Q:InputField):Bool;
Procedure IFEdit(Var Q:InputField;StartCursor:Wd);
Procedure IFClearInput(Var Q:InputField);
Procedure BKInit(Var Q:Block;InitStart:CellPos);
Function  BKExtendTo(Var Q:Block;NewLoc:CellPos):Boolean;
Function  BKCellInBlock(Var Q:Block;CheckCell:CellPos):Bool;
Procedure SAInit(Var Q:ScreenArea;InitX1,InitY1,InitX2,InitY2,InitAttrib:Byte);
Procedure SAClear(Var Q:ScreenArea);
Procedure POInit(Var Q:ParserObj;InitHash:CellHashTablePtr;InitInp:LStringPtr;InitPMaxCols,InitPMaxRows:Wd);
Procedure POPush(Var Q:ParserObj;Token:TokenRec);
Procedure POPop(Var Q:ParserObj;Var Token:TokenRec);
Procedure POShift(Var Q:ParserObj;State:Wd);
Procedure POReduce(Var Q:ParserObj;Reduction:Wd);
Procedure POParse(Var Q:ParserObj);
Function  POCellValue(Var Q:ParserObj;P:CellPos):Extended;
Function  POGotoState(Var Q:ParserObj;Production:Wd):Wd;
Function  POIsFunc(Var Q:ParserObj;Const S:String):Bool;
Function  PONextToken(Var Q:ParserObj):TokenTypes;
Function  SSInit(Var Q:Spreadsheet;InitCells:Long;InitMaxCols,InitMaxRows:Wd;
   InitMaxDecimalPlaces,InitDefaultDecimalPlaces,InitDefaultColWidth:Byte):Bool;
Procedure SSDone(Var Q:Spreadsheet);
Function  SSGetColStart(Var Q:Spreadsheet;Col:Wd):Byte;
Procedure _SSSetAreas(Var Q:Spreadsheet;NewNumber:Wd;X1,Y1,X2,Y2:Byte);
Procedure SSDisplayCols(Var Q:Spreadsheet);
Procedure SSDisplayRows(Var Q:Spreadsheet);
Procedure SSDisplayInfo(Var Q:Spreadsheet);
Procedure SSDisplayAllCells(Var Q:Spreadsheet);
Procedure SSDisplay(Var Q:Spreadsheet);
Procedure SSDisplayCell(Var Q:Spreadsheet;P:CellPos);
Procedure SSDisplayCellData(Var Q:Spreadsheet);
Procedure SSDisplayCellBlock(Var Q:Spreadsheet;C1,R1,C2,R2:Wd);
Procedure SSDisplayBlock(Var Q:Spreadsheet;B:Block);
Procedure SSDisplayBlockDiff(Var Q:Spreadsheet;B1,B2:Block);
Procedure SSDisplayCol(Var Q:Spreadsheet;Col:Wd);
Procedure SSDisplayRow(Var Q:Spreadsheet;Row:Wd);
Procedure SSDisplayFileName(Var Q:Spreadsheet);
Procedure SSSetChanged(Var Q:Spreadsheet;IsChanged:Bool);
Procedure SSMakeCurrent(Var Q:Spreadsheet);
Procedure SSMakeNotCurrent(Var Q:Spreadsheet);
Procedure SSUpdate(Var Q:Spreadsheet;UDisplay:Bool);
Procedure SSToggleFormulaDisplay(Var Q:Spreadsheet);
Procedure SSSetScreenColStart(Var Q:Spreadsheet;NewCol:Wd);
Procedure SSSetScreenColStop(Var Q:Spreadsheet;NewCol:Wd);
Procedure SSSetScreenRowStart(Var Q:Spreadsheet;NewRow:Wd);
Procedure SSSetScreenRowStop(Var Q:Spreadsheet;NewRow:Wd);
Procedure SSFindScreenColStart(Var Q:Spreadsheet);
Procedure SSFindScreenColStop(Var Q:Spreadsheet);
Procedure SSFindScreenRowStart(Var Q:Spreadsheet);
Procedure SSFindScreenRowStop(Var Q:Spreadsheet);
Procedure SSSetBlankArea(Var Q:Spreadsheet);
Function  SSAddCell(Var Q:Spreadsheet;CellType:CellTypes;P:CellPos;E:Bool;V:Extended;I:LStringPtr):Bool;
Procedure SSDeleteCell(Var Q:Spreadsheet;P:CellPos;var Deleted:Bool);
Procedure SSDeleteBlock(Var Q:Spreadsheet;B:Block;var Deleted:Bool);
Function  SSCellToFString(Var Q:Spreadsheet;P:CellPos;var Color:Byte):String;
Procedure SSSetLastPos(Var Q:Spreadsheet;DPos:CellPos);
Function  SSGetCurrCol(Var Q:Spreadsheet):Wd;
Function  SSGetCurrRow(Var Q:Spreadsheet):Wd;
Function  SSColToX(Var Q:Spreadsheet;Col:Wd):Byte;
Function  SSRowToY(Var Q:Spreadsheet;Row:Wd):Byte;
Function  SSColWidth(Var Q:Spreadsheet;Col:Wd):Byte;
Function  SSSameCellPos(Var Q:Spreadsheet;P1,P2:CellPos):Bool;
Procedure SSFixOverwrite(Var Q:Spreadsheet);
Function  SSFromFile(Var Q:Spreadsheet;Name:PathStr):Bool;
Procedure SSToFile(Var Q:Spreadsheet;Name:PathStr);
Procedure SSCheckForSave(Var Q:Spreadsheet);
Procedure SSChangeWidth(Var Q:Spreadsheet);
Function  SSCellHashStart(Var Q:Spreadsheet;TotalCells:Long):BucketRange;
Function  SSWidthHashStart(Var Q:Spreadsheet;TotalCells:Long):BucketRange;
Function  SSOverwriteHashStart(Var Q:Spreadsheet;TotalCells:Long):BucketRange;
Procedure SSPrint(Var Q:Spreadsheet);
Procedure SSDeleteColumn(Var Q:Spreadsheet);
Procedure SSInsertColumn(Var Q:Spreadsheet);
Procedure SSDeleteRow(Var Q:Spreadsheet);
Procedure SSInsertRow(Var Q:Spreadsheet);
Procedure LSInit(Var Q:LString);
Procedure LSDone(Var Q:LString);
Function  LSSetValue(Var Q:LString;NewLen:LStringRange;NewData:Pointer):Bool;
Function  LSFromString(Var Q:LString;Const S:String):Bool;
Function  LS2String(Var Q:LString):String;
Function  LSCopy(Var Q:LString;Start,Amt:LStringRange):String;
Function  LSInsert(Var Q:LString;S:String;Start:LStringRange):Bool;
Procedure LSDelete(Var Q:LString;Start,Amt:LStringRange);
Function  LSAppend(Var Q:LString;Const S:String):Boolean;
Procedure LSChange(Var Q:LString;Ch:Char;Start:LStringRange);
Function  LSAssign(Var Q:LString;LS:LString):Bool;
Function  LSFromStream(Var Q:LString;Var S:DosStream):Bool;
Procedure LS2Stream(Var Q:LString;Var S:DosStream);
Procedure SCInit(Var Q:Lotus);
Procedure SCDone(Var Q:Lotus);
Function  SCRun(Var Q:Lotus):Wd;
Procedure SCMovePgRight(Var Q:Lotus);
Procedure SCMovePgLeft(Var Q:Lotus);
Procedure SCMoveRight(Var Q:Lotus);
Procedure SCMoveLeft(Var Q:Lotus);
Procedure SCMovePgDn(Var Q:Lotus);
Procedure SCMovePgUp(Var Q:Lotus);
Procedure SCMoveDown(Var Q:Lotus);
Procedure SCMoveUp(Var Q:Lotus);
Procedure SCMoveEnd(Var Q:Lotus);
Procedure SCMoveHome(Var Q:Lotus);
Procedure SCRemoveCell(Var Q:Lotus);
Procedure SCToggleCurrBlock(Var Q:Lotus);
Procedure SCExtendCurrBlock(Var Q:Lotus;Redraw:Bool);
Procedure SCEditInput(Var Q:Lotus;Ch:Wd;Editing:Bool);
Procedure SCOpenSpreadSheet(Var Q:Lotus;Const Name:String);
Procedure SCClearCurrBlock(Var Q:Lotus);
Procedure SCReplaceSpreadSheet(Var Q:Lotus);
Procedure SCNameSaveSpreadSheet(Var Q:Lotus);
Procedure SCZapSpreadSheet(Var Q:Lotus);
Procedure SCSaveCurrSpreadSheet(Var Q:Lotus);
Procedure SCCloseSpreadSheet(Var Q:Lotus);
Procedure SCNextSpreadSheet(Var Q:Lotus);
Procedure SCNewSpreadSheet(Var Q:Lotus);
Procedure SCNewBlankSpreadSheet(Var Q:Lotus);
Procedure SCPrintSpreadSheet(Var Q:Lotus);
Procedure SCHandleInput(Var Q:Lotus;Ch:Wd);
Procedure SCCopyBlock(Var Q:Lotus);
Procedure SCDeleteBlock(Var Q:Lotus);
Procedure SCFormatBlock(Var Q:Lotus);
Procedure SCFormatDefault(Var Q:Lotus);
Procedure SCColInsert(Var Q:Lotus);
Procedure SCColDelete(Var Q:Lotus);
Procedure SCChangeColWidth(Var Q:Lotus);
Procedure SCRowInsert(Var Q:Lotus);
Procedure SCRowDelete(Var Q:Lotus);
Procedure SCRecalc(Var Q:Lotus);
Procedure SCToggleFormulas(Var Q:Lotus);
Procedure SCToggleAutoCalc(Var Q:Lotus);
Procedure SCFormatCell(Var Q:Lotus);
Procedure SCGotoCell(Var Q:Lotus);
Procedure SCEditCell(Var Q:Lotus);
Procedure SCSetDisplayAreas(Var Q:Lotus);
Procedure SCDisplayAll(Var Q:Lotus);
Function  SCGetFormat(Var Q:Lotus;Var Format:Byte):Bool;
Function  SCAddSheet(Var Q:Lotus;Name:PathStr):Bool;
Procedure SCDeleteSheet(Var Q:Lotus);

Procedure FixFormulaCol(CP:CellPtr;Diff:Long;MaxCols,MaxRows:Wd);
Procedure FixFormulaRow(CP:CellPtr;Diff:Long;MaxCols,MaxRows:Wd);

Function GetColumn(Const Prompt:String;MaxCols,ColSpace:Wd):Wd;
Function GetLegalChar(Const Prompt:String;Legal:CharSet;Var ESCPressed:Boolean):Char;
Function GetNumber(Const Prompt:String;Low,High:Longint;Var Result:Boolean):Longint;
Function GetRow(Const Prompt:String;MaxRows:Wd):Wd;
Function GetCellPos(Const Prompt:String;MaxCols,MaxRows,ColSpace,
		    RowNumberSpace:Wd;Var P:CellPos):Boolean;
Function FormulaStart(Inp:LStringPtr;Start,MaxCols,MaxRows:Wd;
		      Var P:CellPos;Var FormLen:Wd):Boolean;
Function GetColWidth(Var WHash:WidthHashTable;C:Wd):Byte;
Function HashItemPtr2CellPtr(H:HashItemPtr):CellPtr;
Function ReadString(Const Prompt:String;Len:Wd;Var EscPressed:Bool):String;

Var
 Parser:ParserObj;
 Empty:CellPtr;

IMPLEMENTATION

{$F-}

Var SavedExitProc:Pointer;

Procedure PutFreeMemory;Begin;End;

Destructor Base.Done;Begin End;

Constructor Stream.Init;Begin
 TypeCount:=0;TypeList:=Nil;ProcList:=Nil;Status:=0;
 RegisterTypes;
 TypeList:=MemAlloc(TypeCount*SizeOf(Wd));
 If(TypeList=Nil)Then Fail;
 ProcList:=MemAlloc(TypeCount*SizeOf(SProc));
 If(ProcList=Nil)Then Begin;FreeMem(TypeList,TypeCount*SizeOf(Wd));Exit;End;
 TypeCount:=0;
 RegisterTypes;
End;

Destructor Stream.Done;Begin
 FreeMem(ProcList,TypeCount*SizeOf(SProc));
 FreeMem(TypeList,TypeCount*SizeOf(Wd));
End;

Procedure Stream.Error;Begin;Status:=Code;End;
Procedure Stream.Flush;Begin;End;
Function Stream.GetPos;Begin;End;
Procedure Stream.Read;Begin;End;
Procedure Stream.RegisterTypes;Begin;End;
Procedure Stream.SetPos;Begin;End;
Procedure Stream.Truncate;Begin;End;
Procedure Stream.Write;Begin;End;

Function Stream.Get:BasePtr;Assembler;ASM
 PUSH AX
 MOV  AX,SP
 PUSH SS
 PUSH AX
 MOV  AX,2
 PUSH AX
 LES  DI,Self
 PUSH ES
 PUSH DI
 MOV  DI,ES:[DI]
 CALL Read
 POP  BX
 OR   BX,BX
 JE   @@2
 LES  DI,Self
 DEC  BX
 CMP  BX,ES:[DI].Stream.TypeCount
 JAE  @@1
 PUSH ES
 PUSH DI
 LES  DI,ES:[DI].Stream.TypeList
 SHL  BX,1
 PUSH WORD PTR ES:[DI+BX]
 XOR  AX,AX
 PUSH AX
 PUSH AX
 LES  DI,Self
 LES  DI,ES:[DI].Stream.ProcList
 SHL  BX,1
 SHL  BX,1
 CALL ES:[DI+BX].SProc.LoadProc
 JMP @@3
@@1:
 MOV AX,-2
 PUSH ES
  PUSH DI
   PUSH AX
   PUSH ES
   PUSH DI
   MOV DI,ES:[DI]
   CALL Error
  POP DI
 POP ES
@@2:
 XOR AX,AX
 MOV DX,AX
@@3:
END;

Function Stream.GetSize;Var P:Long;Begin
 P:=GetPos;
 SetPos(0,PosEnd);
 GetSize:=GetPos;
 SetPos(P,PosAbs);
End;

Procedure Stream.Put;Assembler;ASM
 LES     DI,B
 MOV     CX,ES
 OR      CX,DI
 JE      @@1
 MOV     AX,ES:[DI]
 LES     DI,Self
 MOV     CX,Stream(ES:[DI]).TypeCount
 JCXZ    @@2
 MOV     BX,CX
 LES     DI,Stream(ES:[DI]).TypeList
 CLD
 REPNE   SCASW
 JNE     @@2
 NEG     CX
 ADD     CX,BX
@@1:
 PUSH    CX
 MOV     AX,SP
 PUSH    SS
 PUSH    AX
 MOV     AX,2
 PUSH    AX
 LES     DI,Self
 PUSH    ES
 PUSH    DI
 MOV     DI,ES:[DI]
 CALL    Write
 POP     BX
 DEC     BX
 JS      @@3
 LES     DI,Self
 PUSH    ES
 PUSH    DI
 PUSH    B.Word[2]
 PUSH    B.Word[0]
 LES     DI,Stream(ES:[DI]).ProcList
 SHL     BX,1
 SHL     BX,1
 SHL     BX,1
 CALL    SProc(ES:[DI+BX]).StoreProc
 JMP @@3
@@2:
 LES DI,Self
 MOV AX,-1
 PUSH ES
  PUSH DI
   PUSH AX
   PUSH ES
   PUSH DI
   MOV DI,ES:[DI]
   CALL Error
  POP DI
 POP ES
@@3:
END;

Procedure StreamError;Near;Begin End;

Procedure Stream.Register;Begin
 Inc(TypeCount);
 If(TypeList<>Nil)Then Begin
  TypeList^[TypeCount]:=PtrRec(TypePtr).Ofs;
  With ProcList^[TypeCount]do Begin;StoreProc:=StorePtr;LoadProc:=LoadPtr;End;
 End;
End;

Procedure Stream.Seek;Begin;SetPos(Pos,PosAbs)End;

Constructor DosStream.Init;Var L:Int;Begin
 If Not(Stream.Init)Then Fail;
 L:=Length(FileName);
 MoveLeft(FileName[1],FileName[0],L);
 FileName[L]:=#0;
 Open(FileName,Mode);
{ If(Mode=sCreate)Then Handle:=Systems.New(FileName)
 Else Handle:=Systems.Open(FileName,fmDef);}
End;

Destructor DosStream.Done;Begin
 Systems.Close(Hdl(Handle));
 Stream.Done;
End;

Function DosStream.GetPos;Assembler;ASM
 XOR DX,DX
 XOR CX,CX
 MOV BX,Handle
 MOV AX,4201h
 INT $21
END;

Procedure DosStream.Read;Begin
 _GetRec(Handle,Count,Buf);
End;

Procedure DosStream.SetPos;Begin
 _SetFilePos(Handle,Pos,Mode);
End;

Procedure DosStream.Truncate;Assembler;ASM
 LES  DI,Self
 PUSH ES
  PUSH DI
   PUSH ES
   PUSH DI
   MOV DI,ES:[DI]
   CALL Flush
  POP DI
 POP ES
 CMP ES:[DI].Stream.Status,0
 JNE  @@1
 XOR  CX,CX
 MOV  BX,ES:[DI].DosStream.Handle
 MOV  AH,40h
 INT  21h
 JNC  @@1
 CALL StreamError
@@1:
END;

Procedure DosStream.Write;Begin
 _SetRec(Handle,Count,Buf)
End;

Procedure DosStream.Close;Assembler;ASM
 LES  DI,Self
 PUSH ES
  PUSH DI
   PUSH ES
   PUSH DI
   MOV DI,ES:[DI]
   CALL Flush
  POP DI
 POP ES
 CMP ES:[DI].Stream.Status,0
 JNE @@1
 MOV BX,ES:[DI].DosStream.Handle
 MOV AH,3EH
 INT 21H
@@1:
END;

Procedure DosStream.Open;Assembler;ASM
 LES DI,Self
 PUSH DS
  LDS DX,Name
  XOR CX,CX
  MOV AX,Mode
  INT 21H
 POP DS
 JNC @@1
 CALL StreamError
 MOV AX,0FFFFH
@@1:
 MOV ES:[DI].DosStream.Handle,AX
END;

Constructor BufStream.Init;Begin
 Buffer:=MemAlloc(Size);
 If(Buffer=Nil)Then Fail;
 If Not(DosStream.Init(FileName,Mode))Then Begin;FreeMem(Buffer,Size);Fail;End;
 BufSize:=Size;BufPtr:=0;BufEnd:=0;
End;

Destructor BufStream.Done;Begin
 DosStream.Done;
 FreeMem(Buffer,BufSize);
End;

Procedure BufStream.Flush;Assembler;ASM
 LES DI,Self
 CMP ES:[DI].Stream.Status,0
 JNE @@9
 MOV AL,2
 MOV CX,ES:[DI].BufStream.BufPtr
 SUB CX,ES:[DI].BufStream.BufEnd
 JE  @@4
 MOV BX,ES:[DI].DosStream.Handle
 JA  @@1
 CMP AL,1
 JE  @@4
 MOV DX,CX
 MOV CX,-1
 MOV AX,4201H
 INT 21H
 JMP @@3
@@1:
 CMP AL,0
 JE  @@4
 PUSH DS
  LDS DX,ES:[DI].BufStream.Buffer
  MOV AH,40H
  INT 21H
 POP DS
 JC @@2
 CMP AX,CX
 JE  @@3
 MOV AX,101
@@2:
 CALL StreamError
@@3:
 XOR AX,AX
 MOV ES:[DI].BufStream.BufPtr,AX
 MOV ES:[DI].BufStream.BufEnd,AX
 CMP AX,ES:[DI].Stream.Status
@@4:
@@9:
END;

Function BufStream.GetPos;Assembler;ASM
 LES DI,Self
 PUSH ES
 PUSH DI
 PUSH CS
 CALL DosStream.GetPos
 OR  DX,DX
 JS  @@1
 LES DI,Self
 SUB AX,ES:[DI].BufStream.BufEnd
 SBB DX,0
 ADD AX,ES:[DI].BufStream.BufPtr
 ADC DX,0
@@1:
END;

Procedure BufStream.Read;Assembler;ASM
 LES DI,Self
 CMP ES:[DI].Stream.Status,0
 JNE @@6
 MOV AL,1

 MOV CX,ES:[DI].BufStream.BufPtr
 SUB CX,ES:[DI].BufStream.BufEnd
 JE  @F4
 MOV BX,ES:[DI].DosStream.Handle
 JA  @F1
 CMP AL,1
 JE  @F4
 MOV DX,CX
 MOV CX,-1
 MOV AX,4201H
 INT 21H
 JMP @F3
@F1:
 CMP AL,0
 JE  @F4
 PUSH DS
  LDS DX,ES:[DI].BufStream.Buffer
  MOV AH,40H
  INT 21H
 POP DS
 JC @F2
 CMP AX,CX
 JE  @F3
 MOV AX,101
@F2:
 CALL StreamError
@F3:
 XOR AX,AX
 MOV ES:[DI].BufStream.BufPtr,AX
 MOV ES:[DI].BufStream.BufEnd,AX
 CMP AX,ES:[DI].Stream.Status
@F4:

 JNE @@6
 XOR DX,DX
@@1:
 MOV CX,Count
 SUB CX,DX
 JE  @@7
 LES DI,Self
 MOV AX,ES:[DI].BufStream.BufEnd
 SUB AX,ES:[DI].BufStream.BufPtr
 JA  @@2
 PUSH CX
  PUSH DX
   PUSH DS
    LDS DX,ES:[DI].BufStream.Buffer
    MOV CX,ES:[DI].BufStream.BufSize
    MOV BX,ES:[DI].DosStream.Handle
    MOV AH,3FH
    INT 21H
   POP DS
  POP DX
 POP CX
 JC @@5
 MOV ES:[DI].BufStream.BufPtr,0
 MOV ES:[DI].BufStream.BufEnd,AX
 OR AX,AX
 JE @@4
@@2:
 CMP CX,AX
 JB @@3
 MOV CX,AX
@@3:
 PUSH DS
  LDS SI,ES:[DI].BufStream.Buffer
  ADD SI,ES:[DI].BufStream.BufPtr
  ADD ES:[DI].BufStream.BufPtr,CX
  LES DI,Buf
  ADD DI,DX
  ADD DX,CX
  CLD
  REP MOVSB
 POP DS
 JMP @@1
@@4:
 MOV AX,101
@@5:
 CALL StreamError
@@6:
 LES DI,Buf
 MOV CX,Count
 XOR AL,AL
 CLD
 REP STOSB
@@7:
END;

Procedure BufStream.Write;Assembler;ASM
 LES DI,Self
 CMP ES:[DI].Stream.Status,0
 JNE @@4
 MOV AL,0

 MOV CX,ES:[DI].BufStream.BufPtr
 SUB CX,ES:[DI].BufStream.BufEnd
 JE  @F4
 MOV BX,ES:[DI].DosStream.Handle
 JA  @F1
 CMP AL,1
 JE  @F4
 MOV DX,CX
 MOV CX,-1
 MOV AX,4201H
 INT 21H
 JMP @F3
@F1:
 CMP AL,0
 JE  @F4
 PUSH DS
  LDS DX,ES:[DI].BufStream.Buffer
  MOV AH,40H
  INT 21H
 POP DS
 JC @F2
 CMP AX,CX
 JE  @F3
 MOV AX,101
@F2:
 CALL StreamError
@F3:
 XOR AX,AX
 MOV ES:[DI].BufStream.BufPtr,AX
 MOV ES:[DI].BufStream.BufEnd,AX
 CMP AX,ES:[DI].Stream.Status
@F4:

 JNE @@4
 XOR DX,DX
@@1:
 MOV CX,Count
 SUB CX,DX
 JE  @@4
 LES DI,Self
 MOV AX,ES:[DI].BufStream.BufSize
 SUB AX,ES:[DI].BufStream.BufPtr
 JA  @@2
 PUSH CX
  PUSH DX
   MOV AL,1

 MOV CX,ES:[DI].BufStream.BufPtr
 SUB CX,ES:[DI].BufStream.BufEnd
 JE  @E4
 MOV BX,ES:[DI].DosStream.Handle
 JA  @E1
 CMP AL,1
 JE  @E4
 MOV DX,CX
 MOV CX,-1
 MOV AX,4201H
 INT 21H
 JMP @E3
@E1:
 CMP AL,0
 JE  @E4
 PUSH DS
  LDS DX,ES:[DI].BufStream.Buffer
  MOV AH,40H
  INT 21H
 POP DS
 JC @E2
 CMP AX,CX
 JE  @E3
 MOV AX,101
@E2:
 CALL StreamError
@E3:
 XOR AX,AX
 MOV ES:[DI].BufStream.BufPtr,AX
 MOV ES:[DI].BufStream.BufEnd,AX
 CMP AX,ES:[DI].Stream.Status
@E4:

  POP DX
 POP CX
 JNE @@4
 MOV AX,ES:[DI].BufStream.BufSize
@@2:
 CMP CX,AX
 JB  @@3
 MOV CX,AX
@@3:
 PUSH DS
  MOV AX,ES:[DI].BufStream.BufPtr
  ADD ES:[DI].BufStream.BufPtr,CX
  LES DI,ES:[DI].BufStream.Buffer
  ADD DI,AX
  LDS SI,Buf
  ADD SI,DX
  ADD DX,CX
  CLD
  REP MOVSB
 POP DS
 JMP @@1
@@4:
END;

Procedure BKInit;Begin;Q.Start:=InitStart;Q.Stop:=Q.Start;End;

Function BKExtendTo;Begin
 If(NewLoc.Col>=Q.Start.Col)and(NewLoc.Row>=Q.Start.Row)Then Begin
  Q.Stop:=NewLoc;BKExtendTo:=Ya;
 End
  else
 BKExtendTo:=No;
End;

Function BKCellInBlock;Begin
 BKCellInBlock:=(CheckCell.Col>=Q.Start.Col)and(CheckCell.Col<=Q.Stop.Col)and
	        (CheckCell.Row>=Q.Start.Row)and(CheckCell.Row<=Q.Stop.Row);
End;

Constructor Cell.Init;Begin;Loc:=InitLoc;End;
Destructor Cell.Done;Begin;End;
Function Cell.CellType;Begin;End;
Function Cell.LegalValue;Begin;End;
Function Cell.Name;Begin;End;
Function Cell.Format;Begin;End;
Function Cell.Width;Begin;End;
Function Cell.Overwritten;Begin;End;
Function Cell.ShouldUpdate;Begin;End;
Function Cell.HasError;Begin;End;
Function Cell.CurrValue;Begin;End;
Function Cell.OverwriteStart;Begin;End;
Procedure Cell.EditString;Begin;End;
Function Cell.DisplayString;Begin;End;
Function Cell.FormattedString;Begin;End;
Function Cell.CopyString;Begin;End;

Constructor CellHashTable.Init;Begin
 If Not HashTable.Init(InitBuckets)Then Fail;
End;

Destructor CellHashTable.Done;Var CP:CellPtr;Begin
 CP:=FirstItem;
 While(CP<>Nil)do Begin;Dispose(CP,Done);CP:=NextItem;End;
 HashTable.Done;
End;

Function CellHashTable.Add;Begin
 CurrCell:=ACell;CurrLoc:=CurrCell^.Loc;Add:=HashTable.Add;
End;

Procedure CellHashTable.Delete;Begin
 CurrLoc:=DelLoc;
 HashTable.Delete(@DeletedCell);
End;

Function CellHashTable.Search;Var I:HashItemPtr;C:CellPtr;Begin
 CurrLoc:=SPos;
 I:=HashTable.Search;
 If(I=Nil)Then Search:=Empty
  else
 Begin
  MoveLeft(I^.Data,C,SizeOf(C));
  Search:=C;
 End;
End;

Function CellHashTable.HashValue;Begin;HashValue:=CurrLoc.Col+CurrLoc.Row;End;

Function CellHashTable.Found;Var C:CellPtr;Begin
 MoveLeft(Item^.Data,C,SizeOf(C));
 Found:=Compare(C^.Loc,CurrLoc,SizeOf(CurrLoc));
End;

Procedure CellHashTable.CreateItem;Begin
 MoveLeft(CurrCell,Item^.Data,SizeOf(CurrCell));
End;

Function CellHashTable.ItemSize;Begin;ItemSize:=SizeOf(CurrCell)End;

Procedure CellHashTable.Load;Var I:Long;Begin
 For I:=1to(Total)do Begin
  If Not Add(CellPtr(S.Get))Then Begin;__OutOfMemory;Exit;End;
 End;
End;

Procedure CellHashTable.Store;Var CP:CellPtr;Begin
 CP:=FirstItem;
 While(CP<>Nil)do Begin;S.Put(CP);CP:=NextItem;End;
End;

Function CellHashTable.FirstItem;Begin
 FirstItem:=HashItemPtr2CellPtr(HashTable.FirstItem);
End;

Function CellHashTable.NextItem;Begin
 NextItem:=HashItemPtr2CellPtr(HashTable.NextItem);
End;

Constructor EmptyCell.Init;Var NewLoc:CellPos;Begin
 NewLoc.Col:=0;NewLoc.Row:=0;
 Cell.Init(NewLoc);
End;

Function EmptyCell.CellType;Begin;CellType:=ClEmpty;End;
Function EmptyCell.LegalValue;Begin;LegalValue:=Ya;End;
Function EmptyCell.Name;Begin;Name:=EmptyCellName;End;
Function EmptyCell.Format;Begin;Format:=0;End;
Function EmptyCell.Width;Begin;Width:=0;End;
Function EmptyCell.Overwritten;Begin;Overwritten:=0;End;
Function EmptyCell.ShouldUpdate;Begin;ShouldUpdate:=No;End;
Function EmptyCell.HasError;Begin;HasError:=No;End;
Function EmptyCell.CurrValue;Begin;CurrValue:=0;End;
Function EmptyCell.OverwriteStart;Begin;OverwriteStart:=1;End;
Procedure EmptyCell.EditString;Begin;LSFromString(L^,'')End;
Function EmptyCell.DisplayString;Begin;DisplayString:=''End;

Function EmptyCell.FormattedString;Var CP:CellPtr;Begin
 CP:=OHash.Search(CPos);
 If(CP<>Empty)Then
  FormattedString:=CP^.FormattedString(OHash,FHash,WHash,GetColWidth,
   Loc,FormulasDisplayed,CP^.OverWriteStart(FHash,WHash,GetColWidth,CPos.Col,
   FormulasDisplayed),ColWidth,DString,Color)
  else
 Begin;FormattedString:='';DString:='';Color:=LotusColors.Blank;End;
End;

Function EmptyCell.CopyString;Begin;CopyString:=L;End;

Constructor FormatHashTable.Init;Begin
 If Not HashTable.Init(1)Then;
End;

Destructor FormatHashTable.Done;Begin;HashTable.Done;End;

Function FormatHashTable.Overwrite;Var H:HashItemPtr;AStart,AStop,BStart,BStop:CellPos;OldF,F:Byte;P:CellPos;Added:Bool;Begin
 Overwrite:=No; H:=HashData^[1];
 While(H<>Nil)do Begin
  MoveLeft(H^.Data,BStart,SizeOf(CellPos));
  MoveLeft(H^.Data[SizeOf(CellPos)],BStop,SizeOf(CellPos));
  If((((NewStart.Col>=BStart.Col)and(NewStart.Col<=BStop.Col))or
      ((NewStop.Col>=BStart.Col)and(NewStop.Col<=BStop.Col)))and
      (((NewStart.Row>=BStart.Row)and(NewStart.Row<=BStop.Row))or
       ((NewStop.Row>=BStart.Row)and(NewStop.Row<=BStop.Row))))or
     ((((BStart.Col>=NewStart.Col)and(BStart.Col<=NewStop.Col))or
       ((BStop.Col>=NewStart.Col)and(BStop.Col<=NewStop.Col)))and
      (((BStart.Row>=NewStart.Row)and(BStart.Row<=NewStop.Row))or
       ((BStop.Row>=NewStart.Row)and(BStop.Row<=NewStop.Row))))Then
  Begin
   MoveLeft(H^.Data[SizeOf(CellPos)shl 1],F,SizeOf(F));
   CurrStart:=BStart;CurrStop:=BStop;
   HashTable.Delete(Nil);
   If(BStart.Row<NewStart.Row)Then Begin
    AStart:=BStart;AStop.Col:=BStop.Col;AStop.Row:=Pred(NewStart.Row);
    If Not Add(AStart,AStop,F)Then Exit;
   End;
   If(BStop.Row>NewStop.Row)Then Begin
    AStart.Col:=BStart.Col;AStart.Row:=Succ(NewStop.Row);
    AStop.Col:=BStop.Col;AStop.Row:=BStop.Row;
    If Not(Add(AStart,AStop,F))Then Exit;
   End;
   If(BStart.Col<NewStart.Col)Then Begin
    AStart.Col:=BStart.Col;AStart.Row:=Omega(BStart.Row,NewStart.Row);
    AStop.Col:=Pred(NewStart.Col);AStop.Row:=Alpha(BStop.Row,NewStop.Row);
    If Not Add(AStart,AStop,F)Then Exit;
   End;
   If(BStop.Col>NewStop.Col)Then Begin
    AStart.Col:=Succ(NewStop.Col);AStart.Row:=Omega(BStart.Row,NewStart.Row);
    AStop.Col:=BStop.Col;AStop.Row:=Alpha(BStop.Row, NewStop.Row);
    If Not(Add(AStart,AStop,F))Then Exit;
   End;
  End;
  H:=H^.Next;
 End;
 Overwrite:=Ya;
End;

Function FormatHashTable.Add;Begin
 Add:=No;
 If Not Overwrite(NewStart,NewStop)Then Exit;
 CurrStart:=NewStart;CurrStop:=NewStop;CurrFormat:=NewFormat;Add:=HashTable.Add;
End;

Function FormatHashTable.Delete;Begin;Delete:=Overwrite(DStart,DStop)End;

Function FormatHashTable.Search;Var H:HashItemPtr;Begin
 CurrStart:=SPos; H:=HashTable.Search;
 If(H=Nil)Then Search:=No
  else
 Begin
  MoveLeft(H^.Data[SizeOf(CellPos)shl 1],F,SizeOf(F));
  Search:=Ya;
 End;
End;

Function FormatHashTable.HashValue;Begin;HashValue:=1;End;

Function FormatHashTable.Found;Var P:CellPos;B:Block;Start,Stop:CellPos;Begin
 MoveLeft(Item^.Data,Start,SizeOf(CellPos));
 MoveLeft(Item^.Data[SizeOf(CellPos)],Stop,SizeOf(CellPos));
 BKInit(B,Start);
 B.Stop:=Stop;Found:=BKCellInBlock(B,CurrStart);
End;

Procedure FormatHashTable.CreateItem;Begin
 With Item^do Begin
  MoveLeft(CurrStart,Data,SizeOf(CellPos));
  MoveLeft(CurrStop,Data[SizeOf(CellPos)],SizeOf(CellPos));
  MoveLeft(CurrFormat,Data[SizeOf(CellPos)shl 1],SizeOf(CurrFormat));
 End;
End;

Function FormatHashTable.ItemSize;Begin
 ItemSize:=(SizeOf(CellPos)shl 1)+SizeOf(Byte);
End;

Procedure FormatHashTable.Load;Var I:Long;C1,C2:CellPos;Format:Byte;Begin
 For I:=1to(Total)do Begin
  S.Read(C1,SizeOf(C1));
  S.Read(C2,SizeOf(C2));
  S.Read(Format,SizeOf(Format));
  If Not(Add(C1,C2,Format))Then Begin;__OutOfMemory;Exit;End;
 End;
End;

Procedure FormatHashTable.Store;Var H:HashItemPtr;C:CellPos;Format:Byte;Begin
 H:=FirstItem;
 While(H<>Nil)do Begin
  MoveLeft(H^.Data,C,SizeOf(C));
  S.Write(C,SizeOf(C));
  MoveLeft(H^.Data[SizeOf(CellPos)],C,SizeOf(C));
  S.Write(C,SizeOf(C));
  MoveLeft(H^.Data[SizeOf(CellPos)shl 1],Format,SizeOf(Format));
  S.Write(Format,SizeOf(Format));
  H:=NextItem;
 End;
End;

Constructor FormulaCell.Init;Begin
 Cell.Init(InitLoc);
 Formula:=System.New(LStringPtr);
 If(Formula=Nil)Then Fail Else LSInit(Formula^);
 If Not(LSAssign(Formula^,InitFormula^))Then Begin;Done;Fail;End;
 Error:=InitError; Value:=InitValue;
End;

Destructor FormulaCell.Done;Begin;LSDone(Formula^);Dispose(Formula)End;
Function FormulaCell.CellType;Begin;CellType:=ClFormula;End;
Function FormulaCell.LegalValue;Begin;LegalValue:=Ya;End;
Function FormulaCell.Name;Begin;Name:=FormulaCellName;End;

Function FormulaCell.Format;Var F:Byte;Begin
 If(FHash.Search(Loc,F))Then Format:=F else
 If(FormulasDisplayed)Then Format:=0 else Format:=(Byte(JRight)shl 4)+4;
End;

Function FormulaCell.Width;Var S:String;F:Byte;P,W:Wd;Begin
 If(FormulasDisplayed)Then Width:=Formula^.Len
  else
 Begin
  F:=Format(FHash,FormulasDisplayed);
  S:=RealStr2(Value,1,F and DecPlacesPart);
  W:=Length(S);
  If(F)and DollarPart<>0Then Inc(W,Length(DollarString));
  If(F)and CommasPart<>0Then Begin
   P:=Pos('.', S);
   If P=0Then P:=Length(S);
   Inc(W,(P-2)div 3);
  End;
  Width:=W;
 End;
End;

Function FormulaCell.Overwritten;Var CellWidth:Long;Total:Wd;P:CellPos;Begin
 P:=Loc;CellWidth:=Width(FHash,FormulasDisplayed);Total:=0;
 Repeat
  Inc(Total);Dec(CellWidth,GetColWidth(WHash,P.Col));Inc(P.Col)
 Until(CellWidth<=0)or(P.Col=MaxCols)or(CHash.Search(P)<>Empty);
 Dec(Total);Overwritten:=Total;
End;

Function FormulaCell.ShouldUpdate;Begin;ShouldUpdate:=Ya;End;
Function FormulaCell.HasError;Begin;HasError:=Error;End;
Function FormulaCell.CurrValue;Begin;CurrValue:=Value;End;

Function FormulaCell.OverwriteStart;Var F:Byte;C,Place:Wd;Begin
 F:=Format(FHash,DisplayFormulas);Place:=1;C:=Loc.Col;
 Repeat Inc(Place,GetColWidth(WHash,C));Inc(C)Until C=EndCol;
 If(Not(DisplayFormulas))and(F and DollarPart<>0)Then
 Dec(Place,Length(DollarString));OverwriteStart:=Place;
End;

Procedure FormulaCell.EditString;Begin;LSAssign(L^,Formula^)End;

Function FormulaCell.DisplayString;Begin
 If Not(FormulasDisplayed)Then DisplayString:=LS2String(Formula^)
			  else DisplayString:=RealStr2(Value,1,MaxDecPlaces);
End;

Function FormulaCell.FormattedString;Var S:String;I:Wd;F:Byte;Begin
 If(FormulasDisplayed)Then Begin
  DString:='';Color:=LotusColors.FormulaCell;
  FormattedString:=LSCopy(Formula^,1,ColWidth);
 End
  else
 Begin
  F:=Format(FHash,FormulasDisplayed);S:=RealStr2(Value,1,F and DecPlacesPart);
  If(Start=1)and(F and DollarPart<>0)Then DString:=' $ 'else DString:='';
  If F and CommasPart<>0Then Begin
   I:=Pos('.', S);
   If I=0Then I:=Length(S);
   While I>4do Begin;Insert(',',S,I-3);Dec(I,3)End;
  End;
  Color:=LotusColors.FormulaCell;FormattedString:=Copy(S,Start,ColWidth);
 End;
End;

Function FormulaCell.CopyString;Begin;LSAssign(L^,Formula^);CopyString:=L;End;

Constructor FormulaCell.Load;Begin
 S.Read(Loc,SizeOf(Loc));
 Formula:=System.New(LStringPtr);
 If(Formula=Nil)Then Begin;__OutOfMemory;Exit;End;
 LSInit(Formula^);
 If Not(LSFromStream(Formula^,S))Then Begin
  LSDone(Formula^);
  Dispose(Formula);
  __OutOfMemory;
 End;
End;

Procedure FormulaCell.Store;Begin
 S.Write(Loc,SizeOf(Loc));
 LS2Stream(Formula^,S);
End;

Function FormulaCell.GetFormula;Begin;GetFormula:=Formula;End;

Constructor HashTable.Init;Begin
 GetMem(HashData,InitBuckets*SizeOf(HashItemPtr));
 If(HashData=Nil)Then Fail;
 Buckets:=InitBuckets;
 FillClr(HashData^,Buckets*SizeOf(HashItemPtr));
 Items:=0;
End;

Destructor HashTable.Done;Var P,D:HashItemPtr;I:Wd;Begin
 For I:=1to(Buckets)do Begin
  P:=HashData^[I];
  While(P<>Nil)do Begin
   D:=P;P:=P^.Next;
   FreeMem(D,CurrItemSize(D)+SizeOf(HashItemPtr));
  End;
 End;
 FreeMem(HashData,Buckets*SizeOf(HashItemPtr));
End;

Function HashTable.Add;Var H,A:HashItemPtr;V:BucketRange;Begin
 Add:=No;V:=Succ(HashValue mod Buckets);H:=HashData^[V];A:=H;
 While(H<>Nil)do Begin
  H:=H^.Next;
  If(H<>Nil)Then A:=H;
 End;
 If(A=Nil)Then Begin
  GetMem(HashData^[V],ItemSize+SizeOf(HashItemPtr));
  A:=HashData^[V];
  If(A=Nil)Then Exit;
 End
  else
 Begin
  GetMem(A^.Next,ItemSize+SizeOf(HashItemPtr));
  If(A^.Next=Nil)Then Exit;
  A:=A^.Next;
 End;
 CreateItem(A);
 A^.Next:=Nil; Inc(Items); Add:=Ya;
End;

Procedure HashTable.Delete;Var H,D:HashItemPtr;V:BucketRange;Begin
 V:=Succ(HashValue mod Buckets);H:=HashData^[V];D:=H;
 While(H<>Nil)and(Not(Found(H)))do Begin
  H:=H^.Next;
  If Not(Found(H))Then D:=H;
 End;
 If(H=Nil)Then Begin
  If(Deleted<>Nil)Then FillClr(Deleted^,ItemSize);
  Exit;
 End
  else
 Begin
  If(H=HashData^[V])Then HashData^[V]:=HashData^[V]^.Next Else D^.Next:=H^.Next;
  If(Deleted<>Nil)Then MoveLeft(H^.Data,Deleted^,ItemSize);
  FreeMem(H,CurrItemSize(H)+SizeOf(HashItemPtr));
 End;
 Dec(Items);
End;

Function HashTable.FirstItem;Var I:Wd;Begin
 For I:=1to(Buckets)do Begin
  CurrBucket:=I;CurrItem:=HashData^[I];
  If(CurrItem<>Nil)Then Begin;FirstItem:=CurrItem;Exit;End;
 End;
 FirstItem:=Nil;
End;

Function HashTable.NextItem;Begin
 CurrItem:=CurrItem^.Next;
 If(CurrItem<>Nil)Then Begin;NextItem:=CurrItem;Exit;End;
 While(CurrBucket<Buckets)do Begin
  Inc(CurrBucket);CurrItem:=HashData^[CurrBucket];
  If(CurrItem<>Nil)Then Begin;NextItem:=CurrItem;Exit;End;
 End;
 NextItem:=Nil;
End;

Function HashTable.Change;Var H:HashItemPtr;Begin
 H:=HashData^[Succ(HashValue mod Buckets)];
 While(H<>Nil)and(Not(Found(H)))do H:=H^.Next;
 If(H<>Nil)Then Begin;CreateItem(H);Change:=Ya;End
  Else
 Change:=Add;
End;

Function HashTable.Search;Var H:HashItemPtr;Begin
 H:=HashData^[Succ(HashValue mod Buckets)];
 While(H<>Nil)and(Not(Found(H)))do H:=H^.Next;
 Search:=H;
End;

Function HashTable.HashValue;Begin;End;
Function HashTable.Found;Begin;End;
Procedure HashTable.CreateItem;Begin;End;
Function HashTable.ItemSize;Begin;End;
Function HashTable.CurrItemSize;Begin;CurrItemSize:=ItemSize;End;

Function IFInit;Begin
 IFInit:=No;
 WEInit(Q.W,0,0,wnMax,wnMax);
 Q.InputData:=System.New(LStringPtr);
 If(Q.InputData=Nil)Then Exit Else LSInit(Q.InputData^);
 Q.StartCol:=C1;Q.StopCol:=C2;Q.InputRow:=R;
 If InitMaxInputLen=0Then Q.MaxInputLen:=65521 Else Q.MaxInputLen:=InitMaxInputLen;
 Q.UCase:=InitUCase;Q.Quit:=No;IFInit:=Ya;
End;

Procedure IFDone;Begin
 WEDone(Q.W);
 LSDone(Q.InputData^);
 Dispose(Q.InputData)
End;

Function IFGetQuit;Begin;IFGetQuit:=Q.Quit;End;

Procedure IFEdit;Var CursorPos,Start,Cursor,Ch:Wd;Good,InsMode,Finished:Bool;R,SCol,ECol,EndCol:Byte;Begin
 With Q.InputData^do Begin
  Q.Quit:=No; SCol:=Q.StartCol;
  If Q.StopCol<=0Then EndCol:=Q.W.MaxX+1+Q.StopCol Else EndCol:=Q.StopCol;
  If Q.InputRow<=0Then R:=(Q.W.MaxY+1)+Q.InputRow Else R:=Q.InputRow;
  If(R=Q.W.MaxY+1)and(ECol=Q.W.MaxX+1)Then Dec(EndCol);
  ECol:=EndCol;
  {InputArea.Init(SCol,R,ECol,R,LotusColors.Input);
  InputArea.Clear;}
  BarSpcHor(Q.W.X1+1,Q.W.Y2,Q.W.X2-1,LotusColors.Input);
  If StartCursor=0Then CursorPos:=Succ(Len)else CursorPos:=StartCursor;
  Finished:=No; InsMode:=Ya; Cursor:=$0607;
  Start:=Omega(Long(CursorPos)-ECol-SCol+2,1);
  Repeat
   If(CursorPos>Len)Then ECol:=EndCol;
   If(CursorPos<Start)or(CursorPos>Start+ECol-SCol)Then
    Start:=Omega(Long(CursorPos)-ECol+SCol,1);
   If(Start=2)and(SCol<>Q.StartCol)Then Begin;SCol:=Q.StartCol;Start:=1;End;
   If Start>1Then Begin
    If(SCol=Q.StartCol)Then Begin;Inc(Start);SCol:=Succ(Q.StartCol)End;
   End
    else
   SCol:=Q.StartCol;
   If(Len>Start+ECol-SCol)Then Begin
    If(ECol=EndCol)Then Begin
     If(SCol<>Q.StartCol)Then Inc(Start);
     ECol:=Pred(EndCol);
    End;
   End
    else
   ECol:=EndCol;
{   SetPos(W.RX1+1+StartCol-1,W.RY2+R-1);
   SetAllColor(LotusColors.Input,LotusColors.InputArrow);}
   If(SCol<>Q.StartCol)Then PutTyping(LeftInputArrow);
   PutTxtXY(Q.W.X1+1+Q.StartCol-1,Q.W.Y2,
	     StrUSpc(LSCopy(Q.InputData^,Start,Succ(ECol-SCol)),
	     Succ(ECol-SCol)),LotusColors.InputArrow);
{   If(ECol <> EndCol)Then PutTyping(RightInputArrow);}
   SetCurPos(Q.W.X1+1+CursorPos-Start+SCol-1,Q.W.Y2{+R-1});
   SimpleCur;
   Ch:=ReadKey;
   CloseCur;
   Case(Ch)of
    kbHome:CursorPos:=1;
    kbEnd:CursorPos:=Succ(Len);
    kbBS:If CursorPos>1Then Begin;LSDelete(Q.InputData^,Pred(CursorPos),1);Dec(CursorPos)End;
    kbDel:If(CursorPos<=Len)Then LSDelete(Q.InputData^,CursorPos,1);
    kbLeft:If CursorPos>1Then Dec(CursorPos);
    kbRight:If(CursorPos<=Len)Then Inc(CursorPos);
    kbIns:Begin
     InsMode:=Not InsMode;
     {If(InsMode)Then Cursor:=Scr.InsCursor else Cursor:=Scr.OldCursor;}
    End;
    kbCtrlLeft:Begin
     If(CursorPos>1)and(Data^[CursorPos]<>' ')Then Dec(CursorPos);
     While(CursorPos>1)and(Data^[CursorPos]=' ')do Dec(CursorPos);
     While(CursorPos>1)and(Data^[Pred(CursorPos)]<>' ')do Dec(CursorPos);
    End;
    kbCtrlRight:Begin
     While(CursorPos<=Len)and(Data^[CursorPos]<>' ')do Inc(CursorPos);
     While(CursorPos<=Len)and(Data^[CursorPos]=' ')do Inc(CursorPos);
    End;
    kbEsc:Begin
     IFClearInput(Q);
     Q.Quit:=Ya;Finished:=Ya;
    End;
    kbEnter:Finished:=Ya;
    Else If Char(Ch)in[' '..'~']Then Begin
     If Not(InsMode and(Len=Q.MaxInputLen))Then Begin
      If(Q.UCase)Then Ch:=Byte(ChrUp(Chr(Ch)));
      If(InsMode)or(CursorPos>Len)Then Good:=LSInsert(Q.InputData^,Chr(Ch),CursorPos)
       else
      Begin
       Good:=Ya;
       LSChange(Q.InputData^,Chr(Ch),CursorPos);
      End;
      If(Good)Then Inc(CursorPos);
     End;
    End;
   End;
  Until Finished;
 End;
End;

Procedure IFClearInput;Begin;LSFromString(Q.InputData^,'')End;

Procedure SCInit;Begin
 FillClr(Q,SizeOf(Q));
 WEInit(Q.W,2,5,wnMax,wnMax-3);
 WEPushWn(Q.W);
 WEPutWnKrDials(Q.W,'Chiffrier Electronique');
 WESetEndBar(Q.W,LotusColors.FileName);
 Empty:=System.New(EmptyCellPtr,Init);
 Q.MaxSpreadSheets:=(Q.W.MaxY-EmptyRowsAtTop-EmptyRowsAtBottom)shr 2;
 Q.TotalSheets:=0;Q.SSData:=NIL;Q.CurrSS:=NIL;
 If Not SCAddSheet(Q,'')Then __OutOfMemory;
 SCSetDisplayAreas(Q);
 SCDisplayAll(Q);
 SSMakeCurrent(Q.CurrSS^);
 WEInit(Q.CurrSS^.W,Q.W.X1,Q.W.Y1,Q.W.X2,Q.W.Y2);
 SSDisplayCell(Q.CurrSS^,Q.CurrSS^.CurrPos);
End;

Procedure SCDone;Begin
 SSMakeNotCurrent(Q.CurrSS^);
 While(Q.SSData<>Nil)do Begin
  Q.CurrSS:=Q.SSData;Q.SSData:=Q.SSData^.Next;
  SSMakeCurrent(Q.CurrSS^);
  SSDisplayCell(Q.CurrSS^,Q.CurrSS^.CurrPos);
  SSCheckForSave(Q.CurrSS^);
  SSMakeNotCurrent(Q.CurrSS^);
  SSDisplayCell(Q.CurrSS^,Q.CurrSS^.CurrPos);
  SSDone(Q.CurrSS^);
  Dispose(Q.CurrSS);
 End;
 Dispose(Empty,Done);
 WEDone(Q.W)
End;

Function SCGetFormat;Var Places:Byte;J:Justification;ESCPressed,Good,Dollar,Commas:Bool;Ch:Char;Begin
 SCGetFormat:=No;Dollar:=WarningMsgYesNo(PromptFormatDollar)=kbYes;
 If(Dollar)Then Begin;Places:=2;J:=JRight;End
  else
 Begin
  Places:=GetNumber(PromptFormatPlaces,0,Q.CurrSS^.MaxDecimalPlaces,Good);
  If Not(Good)Then Exit;
  Ch:=GetLegalChar(PromptFormatJustification,LegalJustification,ESCPressed);
  If(ESCPressed)Then Exit;
  Case(Ch)of
   'L':J:=JLeft;
   'C':J:=JCenter;
   'R':J:=JRight;
  End;
 End;
 Commas:=WarningMsgYesNo(PromptFormatCommas)=kbYes;
 Format:=Places+(Byte(J)shl 4)+(Byte(Dollar)shl 6)+(Byte(Commas)shl 7);
 SCGetFormat:=Ya;
End;

Procedure SCEditInput;Var Good,FirstEdit,Deleted:Bool;P:CellPos;Buf:Pointer;PC:PChr;LenBuffer,K:Wd;PP:Wins;Begin
 With Q.CurrSS^do Begin
  WEInit(PP,W.X1+1,W.Y2,W.X2-1,W.Y2);
  WEPushWn(PP);
  If MaxAvail>=4096Then LenBuffer:=4096 Else LenBuffer:=MaxAvail;
  Buf:=MemAlloc(LenBuffer);
  If(Buf<>NIL)Then Begin
   PC:=Buf;
   {If(Editing)Then StrPCopy(PChr,CellInput.InputData);
	      Else }FillClr(PC^,LenBuffer);
   PushKey(Ch);
   SetAllKr(LotusColors.Input,LotusColors.Input);
   K:=Input(W.X1+1,W.Y2,W.X2-1,LenBuffer,No,PC);
   If(K<>kbEsc)Then With Q.CellInput.InputData^do Begin
    LSFromString(Q.CellInput.InputData^,StrPas(PC));
    POInit(Parser,@CellHash,Q.CellInput.InputData,MaxCols,MaxRows);
    Parser.Position:=1;
    POParse(Parser);
    If Parser.TokenError=0Then Begin
     SSDeleteCell(Q.CurrSS^,CurrPos,Deleted);
     SSAddCell(Q.CurrSS^,Parser.CType,CurrPos,Parser.ParseError,Parser.ParseValue,Q.CellInput.InputData);
    End;
    SSSetChanged(Q.CurrSS^,Ya);
    If(AutoCalc)Then SSUpdate(Q.CurrSS^,Ya);
    P:=CurrPos;
    For P.Col:=CurrPos.Col to(ScreenBlock.Stop.Col)do SSDisplayCell(Q.CurrSS^,P);
   End;
   FreeMem(Buf,LenBuffer);
  End;
  WEDone(PP);
(*  If Not(CellInput.Init(1,0,-1,0,NotUpper))Then Exit;
  CellInput.W.Init(W.RX1,W.RY1,W.RX2,W.RY2);
  CellInput.W.PushWindow;
  With CellInput.InputData^do
  Begin
   If(Editing)Then Begin
    Good:=Ya;
    CellHash.Search(CurrPos)^.EditString(MaxDecimalPlaces,CellInput.InputData)
   End
    else
   Good:=FromString(Chr(Ch));
   If Not(Good)Then Begin;CellInput.Done;Exit;End;
   FirstEdit:=Ya;
   Parser.Init(@CellHash,CellInput.InputData,MaxCols,MaxRows);
   Repeat
    If(FirstEdit)Then CellInput.Edit(0)else CellInput.Edit(Parser.Position);
    If Len>0Then Begin
     Parser.Parse;
     If Parser.TokenError=0Then Begin
      DeleteCell(CurrPos,Deleted);
      Good:=AddCell(Parser.CType,CurrPos,Parser.ParseError,Parser.ParseValue,CellInput.InputData);
     End;
    End;
    FirstEdit:=No;
   Until(Len=0)or(Parser.TokenError=0);
   If Len>0Then Begin
    SetChanged(Ya);
    If(AutoCalc)Then Update(DisplayYes);
    P:=CurrPos;
    For P.Col:=CurrPos.Col to(ScreenBlock.Stop.Col)do DisplayCell(P);
   End;
{   CellInput.InputArea.Clear;}
  End;
  CellInput.Done;*)
  PutFreeMemory;
 End;
End;

Procedure SCOpenSpreadsheet;Begin
 If Not SCAddSheet(Q,Name)Then Exit;
 SCSetDisplayAreas(Q);
 SCDisplayAll(Q);
 SSMakeCurrent(Q.CurrSS^);
 SSDisplayCell(Q.CurrSS^,Q.CurrSS^.CurrPos)
End;

Procedure SCClearCurrBlock;Begin
 With Q.CurrSS^do Begin
  If(BlockOn)Then Begin
   BlockOn:=No;
   SSDisplayBlock(Q.CurrSS^,Q.CurrSS^.CurrBlock)
  End;
 End;
End;

Procedure SCReplaceSpreadsheet;Var S:PathStr;ESCPressed:Bool;Begin
 With Q.CurrSS^do Begin
  S:=ReadString(PromptFileLoad,Pred(SizeOf(PathStr)),ESCPressed);
  If S=''Then Exit;
  SSCheckForSave(Q.CurrSS^);
  SSDone(Q.CurrSS^);
  If SSFromFile(Q.CurrSS^,S)Then Begin
   SSSetChanged(Q.CurrSS^,No);
   SSSetScreenColStart(Q.CurrSS^,1);
   SSSetScreenRowStart(Q.CurrSS^,1);
   SSDisplay(Q.CurrSS^);
   SSMakeCurrent(Q.CurrSS^);
   SSDisplayCell(Q.CurrSS^,CurrPos)
  End;
 End;
End;

Procedure SCNameSaveSpreadsheet;Var St:String;ESCPressed:Bool;Begin
 St:='';
 If(WinInp(40,'Sauve Chiffrier','Nom du fichier',CurrKrs.Dial.Wins,No,St)=kbEsc)Then Exit;
 SSToFile(Q.CurrSS^,St);
 SSDisplayFileName(Q.CurrSS^);
End;

Procedure SCSaveCurrSpreadsheet;Begin
 With Q.CurrSS^do If FileName=''Then SCNameSaveSpreadsheet(Q)
                                Else SSToFile(Q.CurrSS^,FileName);
End;

Procedure SCZapSpreadsheet;Var S:PathStr;Begin
 With Q.CurrSS^do Begin
  SSCheckForSave(Q.CurrSS^);
  S:=FileName;
  SSDone(Q.CurrSS^);
  SSInit(Q.CurrSS^,0,DefMaxCols,DefMaxRows,DefMaxDecimalPlaces,DefDecimalPlaces,DefColWidth);
  SSMakeCurrent(Q.CurrSS^);
  FileName:=S;
  SSSetScreenColStart(Q.CurrSS^,1);
  SSSetScreenRowStart(Q.CurrSS^,1);
  SSDisplay(Q.CurrSS^)
 End;
End;

Procedure SCCloseSpreadsheet;Begin
 With Q.CurrSS^do Begin
  If Q.TotalSheets=1Then Exit;
  SCDeleteSheet(Q);
 End;
End;

Procedure SCNextSpreadsheet;Begin
 If Q.TotalSheets=1Then Exit;
 With Q.CurrSS^do Begin
  SSMakeNotCurrent(Q.CurrSS^);
  SSDisplayCell(Q.CurrSS^,CurrPos);
 End;
 Q.CurrSS:=Q.CurrSS^.Next;
 If(Q.CurrSS=Nil)Then Q.CurrSS:=Q.SSData;
 With Q.CurrSS^do Begin
  SSMakeCurrent(Q.CurrSS^);
  SSDisplayCell(Q.CurrSS^,CurrPos);
 End;
End;

Procedure SCNewSpreadSheet;Var S:PathStr;ESCPressed:Bool;Begin
 If(Q.TotalSheets>=Q.MaxSpreadsheets)Then Exit;
 S:=ReadString(PromptFileLoad,Pred(SizeOf(PathStr)),ESCPressed);
 If S=''Then Exit;
 SCOpenSpreadsheet(Q,S)
End;

Procedure SCNewBlankSpreadsheet;Begin
 If(Q.TotalSheets>=Q.MaxSpreadsheets)Then Exit;
 SCOpenSpreadsheet(Q,'')
End;

Procedure SCPrintSpreadsheet;Begin;SSPrint(Q.CurrSS^);End;

procedure SCCopyBlock;
Var P,N,C:CellPos;Ok,ESCPressed,ColLit,RowLit,AnyChanged,Deleted:Bool;
    CP:CellPtr;L:LStringPtr;CopyTo:SpreadsheetPtr;CopySheet:Byte;I:Wd;
Begin
 With Q.CurrSS^,CurrBlock do Begin
  If Not(BlockOn)Then Exit;
  If Q.TotalSheets>1Then CopySheet:=GetNumber(PromptCopySpreadsheet,0,Q.TotalSheets,Ok)
		    Else CopySheet:=1;
  If Not(Ok)Then Exit;
  If Not(GetCellPos('Copie … la cellule',MaxCols,MaxRows,ColSpace,RowNumberSpace,P))Then Exit;
  ColLit:=WarningMsgYesNo(PromptColLiteral)=kbYes;
  RowLit:=WarningMsgYesNo(PromptRowLiteral)=kbYes;
  PutLastBar(2,MsgBlockCopy);
  If CopySheet=0Then CopyTo:=Q.CurrSS
   else
  Begin
   CopyTo:=Q.SSData;
   For I:=2to(CopySheet)do CopyTo:=CopyTo^.Next;
  End;
  AnyChanged:=No;C.Row:=P.Row;N.Row:=Start.Row;
  L:=System.New(LStringPtr);
  Ok:=L<>NIL;
  If(Ok)Then LSInit(L^);
  While(Ok)and(N.Row<=Stop.Row)do Begin
   C.Col:=P.Col; N.Col:=Start.Col;
   While(Ok)and(N.Col<=Stop.Col)do Begin
    If(Long(P.Col)+N.Col-Start.Col<=MaxCols)and(Long(P.Row)+N.Row-Start.Row<=MaxRows)Then Begin
     SSDeleteCell(CopyTo^,C,Deleted);
     If(Deleted)Then AnyChanged:=Ya;
     CP:=CellHash.Search(N);
     If(CP<>Empty)Then Begin
      AnyChanged:=Ya;
      With CP^do
       Ok:=SSAddCell(CopyTo^,CellType,C,HasError,CurrValue,CopyString(ColLit,RowLit,Long(C.Col)-N.Col,L));
      If(Ok)and((Not(ColLit))or(Not(RowLit)))Then Begin
       CP:=CopyTo^.CellHash.Search(C);
       If(CP^.ShouldUpdate)Then Begin
	If Not(ColLit)Then FixFormulaCol(CP,Long(C.Col)-N.Col,MaxCols,MaxRows);
	If Not(RowLit)Then FixFormulaRow(CP,Long(C.Row)-N.Row,MaxCols,MaxRows);
       End;
      End;
     End;
    End;
    Inc(C.Col);Inc(N.Col);
   End;
   Inc(C.Row);Inc(N.Row);
  End;
  If(AnyChanged)Then Begin
   If CopySheet=0Then BlockOn:=No;
   With CopyTo^do Begin
    SSSetLastPos(CopyTo^,LastPos);
    SSSetChanged(CopyTo^,Ya);
    If(AutoCalc)Then SSUpdate(CopyTo^,No);
    SSDisplayAllCells(CopyTo^);
    PutFreeMemory;
   End;
   If CopySheet<>0Then SCClearCurrBlock(Q);
  End
   else
  SCClearCurrBlock(Q);
  WEPutLastBar('');
 End;
 If(L<>NIL)Then Begin
  LSDone(L^);
  Dispose(L)
 End;
End;

Procedure SCDeleteBlock;Var Deleted:Bool;Begin
 With Q.CurrSS^,CurrBlock do Begin
  If Not(BlockOn)Then Exit;
  SSDeleteBlock(Q.CurrSS^,CurrBlock,Deleted);
  If(Deleted)Then Begin
   BlockOn:=No;
   SSSetLastPos(Q.CurrSS^,LastPos);
   SSSetChanged(Q.CurrSS^,Ya);
   If(AutoCalc)Then SSUpdate(Q.CurrSS^,No);
   PutFreeMemory;
   SSDisplayAllCells(Q.CurrSS^);
  End
   else
  SCClearCurrBlock(Q);
 End;
End;

Procedure SCFormatBlock;Var Format:Byte;Begin
 With Q.CurrSS^do Begin
  If Not(BlockOn)Then Exit;
  If Not SCGetFormat(Q,Format)Then Exit;
  With CurrBlock do Begin
   If Not FormatHash.Add(Start,Stop,Format)Then Exit;
   SSSetChanged(Q.CurrSS^,Ya);
   SSDisplayAllCells(Q.CurrSS^);
   PutFreeMemory;
  End;
 End;
End;

Procedure SCFormatDefault;Begin
 With Q.CurrSS^do Begin
  If Not(BlockOn)Then Exit;
  With CurrBlock do Begin
   If Not FormatHash.Delete(Start,Stop)Then Exit;
   SSSetChanged(Q.CurrSS^,Ya);
   SSDisplayAllCells(Q.CurrSS^);
   PutFreeMemory;
  End;
 End;
End;

Procedure SCColInsert;Begin;SSInsertColumn(Q.CurrSS^)End;
Procedure SCColDelete;Begin;SSDeleteColumn(Q.CurrSS^)End;
Procedure SCChangeColWidth;Begin;SSChangeWidth(Q.CurrSS^)End;
Procedure SCRowInsert;Begin;SSInsertRow(Q.CurrSS^)End;
Procedure SCRowDelete;Begin;SSDeleteRow(Q.CurrSS^)End;
Procedure SCRecalc;Begin;SSUpdate(Q.CurrSS^,Ya)End;
Procedure SCToggleFormulas;Begin;SSToggleFormulaDisplay(Q.CurrSS^)End;

Procedure SCToggleAutoCalc;Begin
 With Q.CurrSS^do Begin
  AutoCalc:=Not(AutoCalc);
  SSDisplayInfo(Q.CurrSS^);
  If(AutoCalc)Then SSUpdate(Q.CurrSS^,Ya)
 End;
End;

Procedure SCFormatCell;Var Format:Byte;P:CellPos;CP:CellPtr;Begin
 With Q.CurrSS^do Begin
  If Not(SCGetFormat(Q,Format))Then Exit;
  If Not(FormatHash.Add(CurrPos,CurrPos,Format))Then Exit;
  CP:=CellHash.Search(CurrPos);
  SSSetChanged(Q.CurrSS^,Ya);
  OverwriteHash.Delete(CurrPos);
  If(CP<>Empty)Then
   OverwriteHash.Add(CP,CP^.Overwritten(CellHash,FormatHash,
    WidthHash,LastPos,MaxCols,GetColWidth,DisplayFormulas));
  P:=CurrPos;
  For P.Col:=CurrPos.Col to(ScreenBlock.Stop.Col)do SSDisplayCell(Q.CurrSS^,P);
  PutFreeMemory;
 End;
End;

Procedure SCGotoCell;Var P,OldPos:CellPos;Begin
 With Q.CurrSS^do Begin
  If Not GetCellPos('Aller … la cellule',MaxCols,MaxRows,ColSpace,RowNumberSpace,P)Then Exit;
  If Not BKCellInBlock(ScreenBlock,P)Then Begin
   CurrPos:=P;
   SSSetScreenColStart(Q.CurrSS^,CurrPos.Col);
   SSSetScreenRowStart(Q.CurrSS^,CurrPos.Row);
   SSDisplay(Q.CurrSS^);
  End
   else
  Begin
   OldPos:=CurrPos;CurrPos:=P;
   SSDisplayCell(Q.CurrSS^,OldPos);
   SSDisplayCell(Q.CurrSS^,CurrPos);
  End;
 End;
End;

Procedure SCEditCell;Begin;SCEditInput(Q,0,Ya)End;

Procedure SCExtendCurrBlock;Var OldBlock:Block;Begin
 With Q.CurrSS^do Begin
  If(BlockOn)Then Begin
   Systems.MoveLeft(CurrBlock,OldBlock,SizeOf(CurrBlock));
   If BKExtendTo(CurrBlock,CurrPos)Then Begin
    If(Redraw)Then SSDisplayBlockDiff(Q.CurrSS^,OldBlock,CurrBlock);
   End
    else
   SCClearCurrBlock(Q);
  End;
 End;
End;

Procedure SCToggleCurrBlock;Begin
 With Q.CurrSS^do Begin
  If Not(BlockOn)Then Begin
   BlockOn:=Ya;
   BKInit(CurrBlock,CurrPos);
  End
   else
  SCClearCurrBlock(Q)
 End;
End;

Procedure SCRemoveCell;Var P:CellPos;Deleted:Bool;Begin
 With Q.CurrSS^do Begin
  SSDeleteCell(Q.CurrSS^,CurrPos,Deleted);
  If(Deleted)Then Begin
   SSSetLastPos(Q.CurrSS^,CurrPos);
   SSSetChanged(Q.CurrSS^,Ya);
   If(AutoCalc)Then SSUpdate(Q.CurrSS^,Ya);
   P.Row:=CurrPos.Row;
   For P.Col:=CurrPos.Col to(ScreenBlock.Stop.Col)do SSDisplayCell(Q.CurrSS^,P);
   PutFreeMemory;
  End;
 End;
End;

Procedure SCMoveHome;Var OldPos:CellPos;Begin
 With Q.CurrSS^do Begin
  OldPos:=CurrPos;CurrPos.Col:=1;CurrPos.Row:=1;
  If Not BKCellInBlock(ScreenBlock,CurrPos)Then Begin
   SCExtendCurrBlock(Q,No);
   SSSetScreenColStart(Q.CurrSS^,1);
   SSSetScreenRowStart(Q.CurrSS^,1);
   SSSetBlankArea(Q.CurrSS^);
   SSDisplay(Q.CurrSS^)
  End
   else
  Begin
   SCExtendCurrBlock(Q,Ya);
   SSDisplayCell(Q.CurrSS^,OldPos);
   SSDisplayCell(Q.CurrSS^,CurrPos);
  End;
  SSDisplayCellData(Q.CurrSS^)
 End;
End;

Procedure SCMoveEnd;Var OldPos:CellPos;Begin
 With Q.CurrSS^do Begin
  OldPos:=CurrPos; CurrPos:=LastPos;
  If Not BKCellInBlock(ScreenBlock,CurrPos)Then Begin
   SCExtendCurrBlock(Q,No);
   SSSetScreenColStop(Q.CurrSS^,CurrPos.Col);
   SSSetScreenRowStop(Q.CurrSS^,CurrPos.Row);
   SSSetBlankArea(Q.CurrSS^);
   SSDisplay(Q.CurrSS^)
  End
   else
  Begin
   SCExtendCurrBlock(Q,Ya);
   SSDisplayCell(Q.CurrSS^,OldPos);
   SSDisplayCell(Q.CurrSS^,CurrPos)
  End;
  SSDisplayCellData(Q.CurrSS^)
 End;
End;

Procedure SCMoveUp;Var OldPos:CellPos;Begin
 With Q.CurrSS^do Begin
  If CurrPos.Row>1Then Begin
   OldPos:=CurrPos;
   Dec(CurrPos.Row);
   SCExtendCurrBlock(Q,Ya);
   If(CurrPos.Row<ScreenBlock.Start.Row)Then Begin
    SSDisplayCell(Q.CurrSS^,OldPos);
    SSSetScreenRowStart(Q.CurrSS^,CurrPos.Row);
    SSDisplayRows(Q.CurrSS^);
    WESetKr(W,LotusColors.Blank);
    WEScrollUp(W,RowNumberSpace,1,wnMax,wnMax);
    SSDisplayRow(Q.CurrSS^,CurrPos.Row);
   End
    else
   Begin
    SSDisplayCell(Q.CurrSS^,OldPos);
    SSDisplayCell(Q.CurrSS^,CurrPos)
   End;
  End;
  SSDisplayCellData(Q.CurrSS^)
 End;
End;

Procedure SCMoveDown;Var OldPos:CellPos;Begin
 With Q.CurrSS^do Begin
  If(CurrPos.Row<MaxRows)Then Begin
   OldPos:=CurrPos;Inc(CurrPos.Row);
   If(CurrPos.Row>ScreenBlock.Stop.Row)Then Begin
    SCExtendCurrBlock(Q,No);
    SSDisplayCell(Q.CurrSS^,OldPos);
    SSSetScreenRowStop(Q.CurrSS^,CurrPos.Row);
    SSDisplayRows(Q.CurrSS^);
    WESetKr(W,LotusColors.Blank);
    WEScrollDn(W,RowNumberSpace,1,wnMax,wnMax);
    SSDisplayRow(Q.CurrSS^,CurrPos.Row);
   End
    else
   Begin
    SCExtendCurrBlock(Q,Ya);
    SSDisplayCell(Q.CurrSS^,OldPos);
    SSDisplayCell(Q.CurrSS^,CurrPos);
   End;
  End;
  SSDisplayCellData(Q.CurrSS^)
 End;
End;

Procedure SCMovePgUp;Var OldPos:CellPos;Begin
 With Q.CurrSS^do Begin
  If CurrPos.Row>1Then Begin
   OldPos:=CurrPos;
   CurrPos.Row:=Omega(1,Long(CurrPos.Row)-TotalRows);
   SCExtendCurrBlock(Q,No);
   If(CurrPos.Row<ScreenBlock.Start.Row)Then Begin
    SSSetScreenRowStart(Q.CurrSS^,CurrPos.Row);
    SSDisplayRows(Q.CurrSS^);
    SSDisplayAllCells(Q.CurrSS^);
   End
    else
   Begin
    SSDisplayCell(Q.CurrSS^,OldPos);
    SSDisplayCell(Q.CurrSS^,CurrPos);
   End;
  End;
  SSDisplayCellData(Q.CurrSS^)
 End;
 ClrKbd;
End;

Procedure SCMovePgDn;Var OldPos:CellPos;Begin
 With Q.CurrSS^do Begin
  If(CurrPos.Row<MaxRows)Then Begin
   OldPos:=CurrPos; CurrPos.Row:=Alpha(MaxRows,Long(CurrPos.Row)+TotalRows);
   SCExtendCurrBlock(Q,No);
   If(CurrPos.Row>ScreenBlock.Start.Row)Then Begin
    SSSetScreenRowStart(Q.CurrSS^,CurrPos.Row);
    SSDisplayRows(Q.CurrSS^);
    SSDisplayAllCells(Q.CurrSS^);
   End
    else
   Begin
    SSDisplayCell(Q.CurrSS^,OldPos);
    SSDisplayCell(Q.CurrSS^,CurrPos)
   End;
  End;
  SSDisplayCellData(Q.CurrSS^)
 End;
 ClrKbd;
End;

Procedure SCMoveLeft;Var C:Wd;OldPos:CellPos;OldSCol:Wd;Begin
 With Q.CurrSS^do Begin
  If CurrPos.Col>1Then Begin
   OldPos:=CurrPos;Dec(CurrPos.Col);
   SCExtendCurrBlock(Q,Ya);
   If(CurrPos.Col<ScreenBlock.Start.Col)Then Begin
    OldSCol:=ScreenBlock.Start.Col; C:=SSGetColStart(Q.CurrSS^,1);
    SSDisplayCell(Q.CurrSS^,OldPos);
    SSSetScreenColStart(Q.CurrSS^,CurrPos.Col);
    SSSetBlankArea(Q.CurrSS^);
    SSDisplayCols(Q.CurrSS^);
    SCDisplayAll(Q);
    {WEScrollRight(W,RowNumberSpace,1,wnMax,wnMax,GetColStart(OldSCol-ScreenBlock.Start.Col)-GetColStart(0));
    If Not(NoBlankArea)Then BlankArea.Clear;
    For C:=ScreenBlock.Start.Col to CurrPos.Col do DisplayCol(C);}
   End
    else
   Begin
    SSDisplayCell(Q.CurrSS^,OldPos);
    SSDisplayCell(Q.CurrSS^,CurrPos)
   End;
  End;
  SSDisplayCellData(Q.CurrSS^)
 End;
End;

Procedure SCMoveRight;Var C:Wd;OldPos:CellPos;SaveColStart:Array[0..79]of Byte;OldSCol:Wd;Begin
 With Q.CurrSS^do Begin
  If(CurrPos.Col<MaxCols)Then Begin
   OldPos:=CurrPos;Inc(CurrPos.Col);
   If(CurrPos.Col>ScreenBlock.Stop.Col)Then Begin
    SCExtendCurrBlock(Q,No);
    For C:=0to Pred(MaxScreenCols)do SaveColStart[C]:=SSGetColStart(Q.CurrSS^,C);
    OldSCol:=ScreenBlock.Start.Col;
    SSDisplayCell(Q.CurrSS^,OldPos);
    C:=SSColWidth(Q.CurrSS^,ScreenBlock.Start.Col);
    SSSetScreenColStop(Q.CurrSS^,CurrPos.Col);
    SSSetBlankArea(Q.CurrSS^);
    SSDisplayCols(Q.CurrSS^);
    SCDisplayAll(Q);
    {WEScrollLeft(W,RowNumberSpace,1,wnMax,wnMax,SaveColStart[ScreenBlock.Start.Col-OldSCol]-ColStart^[0]);
    If Not(NoBlankArea)Then BlankArea.Clear;
    For C:=CurrPos.Col to ScreenBlock.Stop.Col do DisplayCol(C);}
   End
    else
   Begin
    SCExtendCurrBlock(Q,Ya);
    SSDisplayCell(Q.CurrSS^,OldPos);
    SSDisplayCell(Q.CurrSS^,CurrPos);
   End;
  End;
  SSDisplayCellData(Q.CurrSS^)
 End;
End;

Procedure SCMovePgLeft;Var OldPos:CellPos;Begin
 With Q.CurrSS^do Begin
  If CurrPos.Col>1Then Begin
   OldPos:=CurrPos;
   CurrPos.Col:=Omega(1,Pred(ScreenBlock.Start.Col));
   SCExtendCurrBlock(Q,No);
   If(CurrPos.Col<ScreenBlock.Start.Col)Then Begin
    SSSetScreenColStop(Q.CurrSS^,CurrPos.Col);
    SSSetBlankArea(Q.CurrSS^);
    SSDisplayCols(Q.CurrSS^);
    If Not(NoBlankArea)Then SAClear(BlankArea);
    SSDisplayAllCells(Q.CurrSS^);
   End
    else
   Begin
    SSDisplayCell(Q.CurrSS^,OldPos);
    SSDisplayCell(Q.CurrSS^,CurrPos);
   End;
  End;
  SSDisplayCellData(Q.CurrSS^)
 End;
 ClrKbd;
End;

Procedure SCMovePgRight;Var OldPos:CellPos;Begin
 With Q.CurrSS^do Begin
  If(CurrPos.Col<MaxCols)Then Begin
   OldPos:=CurrPos;CurrPos.Col:=Alpha(MaxCols,Succ(ScreenBlock.Stop.Col));
   SCExtendCurrBlock(Q,No);
   If(CurrPos.Col>ScreenBlock.Start.Col)Then Begin
    SSSetScreenColStart(Q.CurrSS^,CurrPos.Col);
    SSSetBlankArea(Q.CurrSS^);
    SSDisplayCols(Q.CurrSS^);
    If Not(NoBlankArea)Then SAClear(BlankArea);
    SSDisplayAllCells(Q.CurrSS^);
   End
    else
   Begin
    SSDisplayCell(Q.CurrSS^,OldPos);
    SSDisplayCell(Q.CurrSS^,CurrPos)
   End;
  End;
  SSDisplayCellData(Q.CurrSS^)
 End;
 ClrKbd;
End;

Procedure SCHandleInput;Begin;SCEditInput(Q,Ch,No)End;

Function SCRun;Label Break;Var K:Wd;Begin
 Repeat
  K:=WEReadk(Q.W);
  Case(K)of
   kbF2:SCNameSaveSpreadsheet(Q);
   kbF3:SCReplaceSpreadsheet(Q);
   kbIns:SCToggleCurrBlock(Q);
   kbDel:SCRemoveCell(Q);
   kbHome:SCMoveHome(Q);
   kbEnd:SCMoveEnd(Q);
   kbUp:SCMoveUp(Q);
   kbDn:SCMoveDown(Q);
   kbLeft:SCMoveLeft(Q);
   kbRight:SCMoveRight(Q);
   kbPgUp:SCMovePgUp(Q);
   kbPgDn:SCMovePgDn(Q);
   kbCtrlLeft:SCMovePgLeft(Q);
   kbCtrlRight:SCMovePgRight(Q);
   Else If Char(K)in[' '..'~']Then SCHandleInput(Q,K)Else Goto Break;
  End;
 Until No;
Break:
 SCRun:=K;
End;

Procedure SCSetDisplayAreas;Var S:SpreadsheetPtr;Total,StartRow,Amt:Wd;Begin
 S:=Q.SSData;StartRow:=Succ(EmptyRowsAtTop);
 Amt:=(Q.W.MaxY-EmptyRowsAtTop-EmptyRowsAtBottom)div Q.TotalSheets;Total:=1;
 Repeat
  If(S^.Next=Nil)Then Amt:=Succ(Q.W.MaxY-EmptyRowsAtBottom-StartRow)+5;
  WEInit(S^.W,Q.W.X1,Q.W.Y1,Q.W.X2,Q.W.Y2);
  _SSSetAreas(S^,Total,1,StartRow,Q.W.MaxX,Pred(StartRow+Amt));
  Inc(StartRow,Amt);S:=S^.Next;Inc(Total);
 Until S=NIL;
End;

Procedure SCDisplayAll;Var S:SpreadSheetPtr;Begin
 WESetKr(Q.W,LotusColors.Blank);
 WEClrScr(Q.W);
 WEPutLastBar(_HelpLine);
 PutFreeMemory;
 S:=Q.SSData;
 Repeat
  SSDisplay(S^);
  S:=S^.Next;
 Until S=NIL;
End;

Function SCAddSheet;Var A,S:SpreadsheetPtr;Good,AllocatingNext:Bool;Begin
 SCAddSheet:=No;
 If(Q.TotalSheets=Q.MaxSpreadsheets)Then Exit;
 S:=Q.SSData;
 While(S<>NIL)and(S^.Next<>NIL)do S:=S^.Next;
 If(Q.SSData<>NIL)Then Begin
  A:=S;
  System.New(S^.Next);
  S:=S^.Next;
  AllocatingNext:=Ya;
 End
  else
 Begin
  System.New(S);
  AllocatingNext:=No;
 End;
 If(S=NIL)Then Exit;
 If Name=''Then Good:=SSInit(S^,0,DefMaxCols,DefMaxRows,DefMaxDecimalPlaces,DefDecimalPlaces,DefColWidth)
  Else
 Good:=SSFromFile(S^,Name);
 If Not(Good)Then Begin
  Dispose(S);
  If(AllocatingNext)Then A^.Next:=NIL;
  Exit;
 End;
 If(Q.SSData=NIL)Then Q.SSData:=S;
 If(Q.CurrSS<>NIL)Then Q.CurrSS^.Current:=No;
 Q.CurrSS:=S;Inc(Q.TotalSheets);S^.Next:=NIL;SCAddSheet:=Ya;
End;

Procedure SCDeleteSheet;Var S:SpreadsheetPtr;Begin
 If Q.TotalSheets>1Then Begin
  S:=Q.SSData;
  If(S=Q.CurrSS)Then Q.SSData:=S^.Next
   else
  Begin
   While(S^.Next<>Q.CurrSS)do S:=S^.Next;
   S^.Next:=S^.Next^.Next;
  End;
 End;
 SSCheckForSave(Q.CurrSS^);
 SSDone(Q.CurrSS^);
 If Q.TotalSheets>1Then Begin
  FreeMem(Q.CurrSS,SizeOf(Spreadsheet));
  Dec(Q.TotalSheets);
  Q.CurrSS:=Q.SSData;
 End
  else
 SSInit(Q.CurrSS^,0,DefMaxCols,DefMaxRows,DefMaxDecimalPlaces,DefDecimalPlaces,DefColWidth);
 SCSetDisplayAreas(Q);
 SCDisplayAll(Q);
 SSMakeCurrent(Q.CurrSS^);
 SSDisplayCell(Q.CurrSS^,Q.CurrSS^.CurrPos);
End;

Procedure LSInit;Begin;Q.Len:=0;Q.MaxLen:=0;Q.Data:=NIL;End;
Procedure LSDone;Begin;If(Q.Data<>Nil)Then FreeMem(Q.Data,Q.MaxLen)End;

Function LSSetValue;Var Size:Wd;NData:Pointer;Begin
 Size:=(NewLen+15)shr 4shl 4;
 If(NewLen>Q.MaxLen)Then Begin
  GetMem(NData,Size);
  If(NData=Nil)Then Begin
   LSSetValue:=No;
   Exit;
  End;
  If(Q.Data<>Nil)Then Begin
   MoveLeft(Q.Data^,NData^,Q.Len);
   FreeMem(Q.Data,Q.MaxLen);
  End;
  Q.Data:=NData;Q.MaxLen:=Size;
 End;
 MoveLeft(NewData^,Q.Data^,NewLen);
 Q.Len:=NewLen;LsSetValue:=Ya;
End;

Function LSFromString;Begin
 If Not(LSSetValue(Q,Length(S),@S[1]))Then Begin LSSetValue(Q,0,NIL);LSFromString:=No;End
				      Else LSFromString:=Ya;
End;

Function LS2String;Var S:String;NewLen:Byte;Begin
 NewLen:=Alpha(255,Q.Len); S[0]:=Chr(NewLen);
 MoveLeft(Q.Data^,S[1],NewLen);
 LS2String:=S;
End;

Function LSCopy;Var S:String;Begin
 If(Start>Q.Len)Then Amt:=0 Else Amt:=Alpha(Amt,Succ(Q.Len-Start));
 S[0]:=Chr(Amt);
 MoveLeft(Q.Data^[Start],S[1],Amt);
 LSCopy:=S;
End;

Function LSInsert;Var OldLen:LStringRange;Size:Wd;NData:Pointer;Begin
 OldLen:=Q.Len;Inc(Q.Len,Length(S));
 If(Q.Len>Q.MaxLen)Then Begin
  Size:=(Q.Len+15)shr 4shl 4;
  GetMem(NData,Size);
  If(NData=Nil)Then Begin;Dec(Q.Len,Length(S));LSInsert:=No;Exit;End;
  If(Q.Data<>Nil)Then Begin
   MoveLeft(Q.Data^,NData^,OldLen);
   FreeMem(Q.Data,Q.MaxLen);
  End;
  Q.Data:=NData;Q.MaxLen:=Size;
 End;
 If(Start<=OldLen)Then Move(Q.Data^[Start],Q.Data^[Start+Length(S)],Succ(OldLen-Start));
 MoveLeft(S[1],Q.Data^[Start],Length(S));
 LSInsert:=Ya;
End;

Procedure LSDelete;Begin
 Amt:=Alpha(Amt,Succ(Q.Len-Start));
 If(Start+Amt<=Q.Len)Then MoveLeft(Q.Data^[Start+Amt],Q.Data^[Start],Succ(Q.Len-Amt-Start));
 Dec(Q.Len,Amt);
End;

Function LSAppend;Begin;LSAppend:=LSInsert(Q,S,Succ(Q.Len))End;
Procedure LSChange;Begin;MoveLeft(Ch,Q.Data^[Start],1)End;
Function LSAssign;Begin;LSAssign:=LSSetValue(Q,LS.Len,LS.Data)End;

Function LSFromStream;Var I,NewLen,Size:Wd;Dummy:Byte;NData:Pointer;Begin
 S.Read(NewLen,SizeOf(NewLen));
 Size:=(NewLen+15)shr 4shl 4;
 If(NewLen>Q.MaxLen)Then Begin
  GetMem(NData,Size);
  If(NData=Nil)Then Begin
   For I:=1to(NewLen)do S.Read(Dummy,1);
   LSFromStream:=No;
   Exit;
  End;
  If(Q.Data<>Nil)Then Begin
   MoveLeft(Q.Data^,NData^,Q.Len);
   FreeMem(Q.Data,Q.MaxLen);
  End;
  Q.Data:=NData;Q.MaxLen:=Size;
 End;
 S.Read(Q.Data^,NewLen);
 Q.Len:=NewLen;LSFromStream:=Ya;
End;

Procedure LS2Stream;Begin
 S.Write(Q.Len,SizeOf(Q.Len));
 S.Write(Q.Data^,Q.Len);
End;

Constructor OverwriteHashTable.Init;Begin
 If Not HashTable.Init(InitBuckets)Then Fail;
End;

Destructor OverwriteHashTable.Done;Begin;HashTable.Done;End;

Function OverwriteHashTable.Add;Var CP:CellPtr;Begin
 If Overwritten=0Then Begin;Add:=Ya;Exit;End;
 CP:=Search(SCell^.Loc);
 If(CP<>Empty)Then Begin
  If Not(Change(CP,Pred(SCell^.Loc.Col)))Then Begin
   Add:=No;
   Exit;
  End;
 End;
 CurrCell:=SCell; CurrPos:=SCell^.Loc; EndCol:=CurrPos.Col+Overwritten;
 Add:=HashTable.Add;
End;

Procedure OverwriteHashTable.Delete;Begin
 CurrPos:=SPos;
 HashTable.Delete(Nil);
End;

Function OverwriteHashTable.Change;Begin
 If Overwritten=0Then Begin
  Delete(SCell^.Loc);
  Change:=Ya;
 End
  else
 Begin
  CurrCell:=SCell; CurrPos:=CurrCell^.Loc;
  EndCol:=SCell^.Loc.Col+Overwritten;Change:=HashTable.Change;
 End;
End;

Function OverwriteHashTable.Search;Var I:HashItemPtr;C:CellPtr;Begin
 CurrPos:=SPos; I:=HashTable.Search;
 If(I=Nil)Then Search:=Empty
  else
 Begin
  MoveLeft(I^.Data,C,SizeOf(C));
  Search:=C;
 End;
End;

Function OverwriteHashTable.HashValue;Begin;HashValue:=CurrPos.Row;End;

Function OverwriteHashTable.Found;Var C:CellPtr;E:Wd;Begin
 MoveLeft(Item^.Data,C,SizeOf(C));
 MoveLeft(Item^.Data[SizeOf(C)],E,SizeOf(E));
 With CurrPos do Found:=(Row=C^.Loc.Row)and(Col>=C^.Loc.Col)and(Col<=E);
End;

Procedure OverwriteHashTable.CreateItem;Begin
 MoveLeft(CurrCell,Item^.Data,SizeOf(CurrCell));
 MoveLeft(EndCol,Item^.Data[SizeOf(CurrCell)],SizeOf(EndCol));
End;

Function OverwriteHashTable.ItemSize;Begin;ItemSize:=SizeOf(CurrCell)+SizeOf(EndCol)End;

Procedure POInit;Begin
 Q.ParserHash:=InitHash;Q.Inp:=InitInp;Q.PMaxCols:=InitPMaxCols;
 Q.PMaxRows:=InitPMaxRows;Q.Position:=1;Q.StackTop:=0;Q.TokenError:=0;
 Q.MathError:=No;Q.IsFormula:=No;Q.ParseError:=No;
End;

Function POIsFunc;Var I,SLen:Wd;Begin
 POIsFunc:=No;
 With Q.Inp^do Begin
  SLen:=Length(S);
  For I:=1to Length(S)do If ChrUp(Data^[Pred(Q.Position+I)])<>S[I]Then Exit;
  Q.CurrToken.FuncName:=StrUp(LSCopy(Q.Inp^,Q.Position,SLen));Inc(Q.Position,SLen);POIsFunc:=Ya
 End;
End;

Function PONextToken;Var NumString:String[80];FormLen,Place,TLen,NumLen,Check:Wd;Ch,FirstChar:Char;Decimal:Bool;Begin
 With Q.Inp^do Begin
  While(Q.Position<=Len)and(Data^[Q.Position]=' ')do Inc(Q.Position);
  Q.TokenLen:=Q.Position;
  If(Q.Position>Len)Then Begin;PONextToken:=EOL;Q.TokenLen:=0;Exit;End;
  Ch:=ChrUp(Data^[Q.Position]);
  If Ch in['0'..'9', '.']Then Begin
   NumString:='';TLen:=Q.Position;Decimal:=No;
   While(TLen<=Len)and((Data^[TLen]in['0'..'9'])or((Data^[TLen]='.')and(Not Decimal)))do Begin
    IncStr(NumString,Data^[TLen]);
    If Ch='.'Then Decimal:=Ya;
    Inc(TLen);
   End;
   If(TLen=2)and(Ch='.')Then Begin;PONextToken:=BAD;Q.TokenLen:=0;Exit;End;
   If(TLen<=Len)and((Data^[TLen]='E')or(Data^[TLen]='e'))Then Begin
    IncStr(NumString,'E');Inc(TLen);
    If Data^[TLen]in['+', '-']Then Begin;IncStr(NumString,Data^[TLen]);Inc(TLen)End;
    NumLen:=1;
    While(TLen<=Len)and(Data^[TLen]in['0'..'9'])and(NumLen<=MaxExpLen)do Begin
     IncStr(NumString,Data^[TLen]);Inc(NumLen);Inc(TLen)
    End;
   End;
   If NumString[1]='.'Then NumString:='0'+NumString;
   Val(NumString,Q.CurrToken.Value,Check);
   If Check<>0Then Q.MathError:=Ya;
   PONextToken:=NUM;Inc(Q.Position,Length(NumString));Q.TokenLen:=Q.Position-Q.TokenLen;
   Exit;
  End
   else
  If(Ch in Letters)Then Begin
   If(POIsFunc(Q,'ABS'))or(POIsFunc(Q,'ATAN'))or(POIsFunc(Q,'COS'))or(POIsFunc(Q,'EXP'))or
     (POIsFunc(Q,'LN'))or(POIsFunc(Q,'ROUND'))or(POIsFunc(Q,'SIN'))or(POIsFunc(Q,'SQRT'))or
     (POIsFunc(Q,'SQR'))or(POIsFunc(Q,'TRUNC'))Then Begin
    PONextToken:=FUNC; Q.TokenLen:=Q.Position-Q.TokenLen;
    Exit;
   End;
   If FormulaStart(Q.Inp,Q.Position,Q.PMaxCols,Q.PMaxRows,Q.CurrToken.CP,FormLen)Then Begin
    Inc(Q.Position,FormLen);Q.IsFormula:=Ya;PONextToken:=CELLT;Q.TokenLen:=Q.Position-Q.TokenLen;
    Exit;
   End
    else
   Begin;PONextToken:=BAD;Q.TokenLen:=0;Exit;End;
  End
   else
  Begin
   Case(Ch)of
    '+':PONextToken:=PLUS;
    '-':PONextToken:=MINUS;
    '*':PONextToken:=TIMES;
    '/':PONextToken:=DIVIDE;
    '^':PONextToken:=EXPO;
    ':':PONextToken:=COLON;
    '(':PONextToken:=OPAREN;
    ')':PONextToken:=CPAREN;
    Else Begin;PONextToken:=BAD;Q.TokenLen:=0;Exit;End;
   End;
   Inc(Q.Position);Q.TokenLen:=Q.Position-Q.TokenLen;
   Exit;
  End;
 End;
End;

Procedure POPush;Begin
 If(Q.StackTop=ParserStackSize)Then Q.TokenError:=ErrParserStack
 Else Begin;Inc(Q.StackTop);Q.Stack[Q.StackTop]:=Token;End;
End;

Procedure POPop;Begin;Token:=Q.Stack[Q.StackTop];Dec(Q.StackTop)End;

Function POGotoState;Var State:Wd;Begin
 State:=Q.Stack[Q.StackTop].State;
 If Production<=3Then Case(State)of
  0:POGotoState:=1;
  9:POGotoState:=19;
  20:POGotoState:=28;
 End
  else
 If Production<=6Then Case(State)of
  0,9,20:POGotoState:=2;
  12:POGotoState:=21;
  13:POGotoState:=22;
 End
  else
 If Production<=8Then Case(State)of
  0,9,12,13,20:POGotoState:=3;
  14:POGotoState:=23;
  15:POGotoState:=24;
  16:POGotoState:=25;
 End
  else
 If Production<=10Then Case(State)of
  0,9,12..16,20:POGotoState:=4;
 End
  else
 If Production<=12Then Case(State)of
  0,9,12..16,20:POGotoState:=6;
  5:POGotoState:=17;
 End
  else
 Case(State)of
  0,5,9,12..16,20:POGotoState:=8;
 End;
End;

Function POCellValue;Var CPtr:CellPtr;Begin
 CPtr:=Q.ParserHash^.Search(P);
 With CPtr^do Begin
  If(Not(LegalValue))or(HasError)Then Begin;Q.MathError:=Ya;POCellValue:=0;End
  Else POCellValue:=CurrValue;
 End;
End;

Procedure POShift;Begin
 Q.CurrToken.State:=State;
 POPush(Q,Q.CurrToken);
 Q.TokenType:=PONextToken(Q)
End;

Procedure POReduce;Var Token1,Token2:TokenRec;I:CellPos;Begin
 Case(Reduction)of
  1:Begin
   POPop(Q,Token1);POPop(Q,Token2);POPop(Q,Token2);
   Q.CurrToken.Value:=Token1.Value+Token2.Value;
  End;
  2:Begin
   POPop(Q,Token1);POPop(Q,Token2);POPop(Q,Token2);
   Q.CurrToken.Value:=Token2.Value-Token1.Value;
  End;
  4:Begin
   POPop(Q,Token1);POPop(Q,Token2);POPop(Q,Token2);
   Q.CurrToken.Value:=Token1.Value*Token2.Value;
  End;
  5:Begin
   POPop(Q,Token1);POPop(Q,Token2);POPop(Q,Token2);
   If Token1.Value=0Then Q.MathError:=Ya else Q.CurrToken.Value:=Token2.Value/Token1.Value;
  End;
  7:Begin
   POPop(Q,Token1);POPop(Q,Token2);POPop(Q,Token2);
   If Token2.Value<=0Then Q.MathError:=Ya else
   If(Token1.Value*Ln(Token2.Value)<-ExpLimit)or(Token1.Value*Ln(Token2.Value)>ExpLimit)Then Q.MathError:=Ya
   Else Q.CurrToken.Value:=Exp(Token1.Value*Ln(Token2.Value));
  End;
  9:Begin
   POPop(Q,Token1);POPop(Q,Token2);
   Q.CurrToken.Value:=-Token1.Value;
  End;
  11:Begin
   POPop(Q,Token1);POPop(Q,Token2);POPop(Q,Token2);
   Q.CurrToken.Value:=0;
   If(Token1.CP.Row=Token2.CP.Row)Then Begin
    If(Token1.CP.Col<Token2.CP.Col)Then Q.TokenError:=ErrBadRange
     Else
    Begin
     I.Row:=Token1.CP.Row;
     For I.Col:=Token2.CP.Col to(Token1.CP.Col)do Q.CurrToken.Value:=Q.CurrToken.Value+POCellValue(Q,I);
    End;
   End
    else
   If(Token1.CP.Col=Token2.CP.Col)Then Begin
    If(Token1.CP.Row<Token2.CP.Row)Then Q.TokenError:=ErrBadRange
     else
    Begin
     I.Col:=Token1.CP.Col;
     For I.Row:=Token2.CP.Row to(Token1.CP.Row)do Q.CurrToken.Value:=Q.CurrToken.Value+POCellValue(Q,I);
    End;
   End
    else
   If(Token1.CP.Col>=Token2.CP.Col)and(Token1.CP.Row>=Token2.CP.Row)Then Begin
    For I.Row:=Token2.CP.Row to(Token1.CP.Row)do
     For I.Col:=Token2.CP.Col to(Token1.CP.Col)do
      Q.CurrToken.Value:=Q.CurrToken.Value+POCellValue(Q,I);
   End
    else
   Q.TokenError:=ErrBadRange;
  End;
  13:Begin
   POPop(Q,Q.CurrToken);
   Q.CurrToken.Value:=POCellValue(Q,Q.CurrToken.CP);
  End;
  14:Begin
   POPop(Q,Token1);POPop(Q,Q.CurrToken);POPop(Q,Token1);
  End;
  16:Begin
   POPop(Q,Token1);POPop(Q,Q.CurrToken);POPop(Q,Token1);POPop(Q,Token1);
   If Token1.FuncName='ABS'Then Q.CurrToken.Value:=Abs(Q.CurrToken.Value)else
   If Token1.FuncName='ATAN'Then Q.CurrToken.Value:=ArcTan(Q.CurrToken.Value)else
   If Token1.FuncName='COS'Then Q.CurrToken.Value:=Cos(Q.CurrToken.Value)else
   If Token1.FuncName='EXP'Then Begin
    If(Q.CurrToken.Value<-ExpLimit)or(Q.CurrToken.Value>ExpLimit)Then Q.MathError:=Ya
    Else Q.CurrToken.Value:=Exp(Q.CurrToken.Value);
   End
    else
   If Token1.FuncName='LN'Then Begin
    If Q.CurrToken.Value<=0Then Q.MathError:=Ya else Q.CurrToken.Value:=Ln(Q.CurrToken.Value);
   End
    else
   If Token1.FuncName='ROUND'Then Begin
    If(Q.CurrToken.Value<-1E9)or(Q.CurrToken.Value>1E9)Then Q.MathError:=Ya
    Else Q.CurrToken.Value:=Round(Q.CurrToken.Value);
   End
    else
   If Token1.FuncName='SIN'Then Q.CurrToken.Value:=Sin(Q.CurrToken.Value)else
   If Token1.FuncName='SQRT'Then Begin
    If Q.CurrToken.Value<0Then Q.MathError:=Ya else Q.CurrToken.Value:=Sqrt(Q.CurrToken.Value);
   End
    else
   If Token1.FuncName='SQR'Then Begin
    If(Q.CurrToken.Value<-SQRLIMIT)or(Q.CurrToken.Value>SQRLIMIT)Then Q.MathError:=Ya
    Else Q.CurrToken.Value:=Sqr(Q.CurrToken.Value);
   End
    else
   If Token1.FuncName='TRUNC'Then Begin
    If(Q.CurrToken.Value<-1E9)or(Q.CurrToken.Value>1E9)Then Q.MathError:=Ya
    Else Q.CurrToken.Value:=Trunc(Q.CurrToken.Value);
   End;
  End;
  3,6,8,10,12,15:POPop(Q,Q.CurrToken);
 End;
 Q.CurrToken.State:=POGotoState(Q,Reduction);
 POPush(Q,Q.CurrToken);
End;

Procedure POParse;Var FirstToken:TokenRec;Accepted:Bool;Begin
 Q.Position:=1;Q.StackTop:=0;Q.TokenError:=0;Q.MathError:=No;Q.IsFormula:=No;Q.ParseError:=No;
 With Q.Inp^do Begin
  If(Len=2)and(Data^[1]=RepeatFirstChar)Then Begin;Q.CType:=ClRepeat;Exit;End;
  If TextFirstChar=Data^[1]Then Begin;Q.CType:=ClText;Exit;End;
 End;
 Accepted:=No;FirstToken.State:=0;FirstToken.Value:=0;
 POPush(Q,FirstToken);
 Q.TokenType:=PONextToken(Q);
 Repeat
  Case(Q.Stack[Q.StackTop].State)of
   0,9,12..16, 20:Begin
    If(Q.TokenType=NUM)Then POShift(Q,10)else
    If(Q.TokenType=CELLT)Then POShift(Q,7)else
    If(Q.TokenType=FUNC)Then POShift(Q,11)else
    If(Q.TokenType=MINUS)Then POShift(Q,5)else
    If(Q.TokenType=OPAREN)Then POShift(Q,9)
     else
    Begin
     Q.TokenError:=ErrExpression;Dec(Q.Position,Q.TokenLen);
    End;
   End;
   1:Begin
    If(Q.TokenType=EOL)Then Accepted:=Ya else
    If(Q.TokenType=PLUS)Then POShift(Q,12)else
    If(Q.TokenType=MINUS)Then POShift(Q,13)
     else
    Begin
     Q.TokenError:=ErrOperator;Dec(Q.Position,Q.TokenLen);
    End;
   End;
   2:Begin
    If(Q.TokenType=TIMES)Then POShift(Q,14)else
    If(Q.TokenType=DIVIDE)Then POShift(Q,15)else POReduce(Q,3);
   End;
   3:POReduce(Q,6);
   4:If(Q.TokenType=EXPO)Then POShift(Q,16)else POReduce(Q,8);
   5:Begin
    If(Q.TokenType=NUM)Then POShift(Q,10)else
    If(Q.TokenType=CELLT)Then POShift(Q,7)else
    If(Q.TokenType=FUNC)Then POShift(Q,11)else
    If(Q.TokenType=OPAREN)Then POShift(Q,9)else Q.TokenError:=ErrExpression;
   End;
   6:POReduce(Q,10);
   7:If(Q.TokenType=COLON)Then POShift(Q,18)else POReduce(Q,13);
   8:POReduce(Q,12);
   10:POReduce(Q,15);
   11:If(Q.TokenType=OPAREN)Then POShift(Q,20)else Q.TokenError:=ErrOpenParen;
   17:POReduce(Q,9);
   18:If(Q.TokenType=CELLT)Then POShift(Q,26)else Q.TokenError:=ErrCell;
   19:Begin
    If(Q.TokenType=PLUS)Then POShift(Q,12)else
    If(Q.TokenType=MINUS)Then POShift(Q,13)else
    If(Q.TokenType=CPAREN)Then POShift(Q,27)else Q.TokenError:=ErrOpCloseParen;
   End;
   21:Begin
    If(Q.TokenType=TIMES)Then POShift(Q,14)else
    If(Q.TokenType=DIVIDE)Then POShift(Q,15)else POReduce(Q,1)
   End;
   22:Begin
    If(Q.TokenType=TIMES)Then POShift(Q,14)else
    If(Q.TokenType=DIVIDE)Then POShift(Q,15)else POReduce(Q,2)
   End;
   23:POReduce(Q,4);
   24:POReduce(Q,5);
   25:POReduce(Q,7);
   26:POReduce(Q,11);
   27:POReduce(Q,14);
   28:Begin
    If(Q.TokenType=PLUS)Then POShift(Q,12)else
    If(Q.TokenType=MINUS)Then POShift(Q,13)else
    If(Q.TokenType=CPAREN)Then POShift(Q,29)else Q.TokenError:=ErrOpCloseParen;
   End;
   29:POReduce(Q,16);
  End;
 Until(Accepted)or(Q.TokenError<>0);
 If(Q.TokenError<>0)Then Begin
  If(Q.TokenError=ErrBadRange)Then Dec(Q.Position,Q.TokenLen);
  ErrMsgOk(ErrorMessages[Q.TokenError]);
  Exit;
 End;
 If(Q.IsFormula)Then Q.CType:=ClFormula else Q.CType:=ClValue;
 If(Q.MathError)Then Begin;Q.ParseError:=Ya;Q.ParseValue:=0;Exit;End;
 Q.ParseError:=No;Q.ParseValue:=Q.Stack[Q.StackTop].Value;
End;

Constructor RepeatCell.Init;Begin
 Cell.Init(InitLoc);
 RepeatChar:=InitChar;
End;

Function RepeatCell.CellType;Begin;CellType:=ClRepeat;End;
Function RepeatCell.LegalValue;Begin;LegalValue:=No;End;
Function RepeatCell.Name;Begin;Name:=RepeatCellName;End;
Function RepeatCell.Format;Begin;Format:=0;End;
Function RepeatCell.Width;Begin;Width:=2;End;

Function RepeatCell.Overwritten;Var Total:Wd;P:CellPos;Begin
 P:=Loc;Total:=0;
 Repeat Inc(Total);Inc(P.Col)Until(P.Col>LastPos.Col)or(CHash.Search(P)<>Empty)or(P.Col=0);
 Dec(Total);
 If(P.Col>LastPos.Col)or(P.Col=0)Then Total:=MaxCols-Loc.Col;
 Overwritten:=Total;
End;

Function RepeatCell.ShouldUpdate;Begin;ShouldUpdate:=No;End;
Function RepeatCell.HasError;Begin;HasError:=No;End;
Function RepeatCell.CurrValue;Begin;CurrValue:=0;End;
Function RepeatCell.OverwriteStart;Begin;OverwriteStart:=1;End;

Procedure RepeatCell.EditString;Begin
 LSFromString(L^,RepeatFirstChar+RepeatChar);
End;

Function RepeatCell.DisplayString;Begin
 DisplayString:=MultChr(RepeatChar,GetNmXTxts);
End;

Function RepeatCell.FormattedString;Begin
 DString:='';Color:=LotusColors.RepeatCell;
 FormattedString:=PadChr('',RepeatChar,ColWidth);
End;

Function RepeatCell.CopyString;Begin
 EditString(0,L);
 CopyString:=L;
End;

Constructor RepeatCell.Load;Begin
 S.Read(Loc,SizeOf(Loc));
 S.Read(RepeatChar,SizeOf(RepeatChar))
End;

Procedure RepeatCell.Store;Begin
 S.Write(Loc,SizeOf(Loc));
 S.Write(RepeatChar,SizeOf(RepeatChar));
End;

Function SSInit;Begin
 SSInit:=No;
 If Not Q.CellHash.Init(SSCellHashStart(Q,InitCells))Then Begin;__OutOfMemory;Exit;End;
 If Not(Q.WidthHash.Init(SSWidthHashStart(Q,InitCells),InitDefaultColWidth))Then Begin
  Q.CellHash.Done;
  Exit;
 End;
 If Not Q.OverwriteHash.Init(SSOverwriteHashStart(Q,InitCells))Then Begin
  Q.CellHash.Done;
  Q.WidthHash.Done;
  Exit;
 End;
 If Not(Q.FormatHash.Init)Then Begin
  Q.CellHash.Done;
  Q.WidthHash.Done;
  Q.OverwriteHash.Done;
  Exit;
 End;
 Q.MaxCols:=InitMaxCols; Q.MaxRows:=InitMaxRows;
 Q.RowNumberSpace:=Byte(Q.MaxRows>=10000)+Byte(Q.MaxRows>=1000)+Byte(Q.MaxRows>=100)+Byte(Q.MaxRows>=10)+2;
 Q.MaxColWidth:=Q.W.MaxX-Q.RowNumberSpace;
 Q.MaxScreenCols:=Q.MaxColWidth div MinColWidth;
 GetMem(Q.ColStart,Q.MaxScreenCols);
 If(Q.ColStart=NIL)Then Begin
  Q.CellHash.Done;
  Q.WidthHash.Done;
  Q.OverwriteHash.Done;
  Q.FormatHash.Done;
  Exit;
 End;
 Q.CurrPos.Col:=1;Q.CurrPos.Row:=1;Q.LastPos:=Q.CurrPos;Q.BlockOn:=No;Q.FileName:='';
 Q.DisplayFormulas:=No;Q.AutoCalc:=No;Q.Current:=No;Q.Changed:=No;
 Q.ScreenBlock.Start.Col:=1;Q.ScreenBlock.Start.Row:=1;
 Q.ColSpace:=Succ(Byte(Q.MaxCols>=18279)+Byte(Q.MaxCols>=703)+Byte(Q.MaxCols>=27));
 Q.MaxDecimalPlaces:=InitMaxDecimalPlaces;Q.DefaultColWidth:=InitDefaultColWidth;
 Q.DefaultDecimalPlaces:=InitDefaultDecimalPlaces;
 SSInit:=Ya;
End;

Procedure SSDone;Begin
 Q.CellHash.Done;
 Q.WidthHash.Done;
 Q.OverwriteHash.Done;
 Q.FormatHash.Done;
 FreeMem(Q.ColStart,Q.MaxScreenCols);
End;

Function SSGetColStart;Begin;SSGetColStart:=Q.ColStart^[Col]End;

Procedure _SSSetAreas;Begin
 Q.Number:=NewNumber; Q.TotalRows:=Q.W.MaxY;
 SAInit(Q.DisplayArea,Q.W.X1+X1+Q.RowNumberSpace,Q.W.Y1+Succ(Y1),Q.W.X2,Q.W.Y2,LotusColors.Blank);
 SSSetScreenColStart(Q,Q.ScreenBlock.Start.Col);
 SSSetScreenRowStart(Q,Q.ScreenBlock.Start.Row);
 SSSetBlankArea(Q);
End;

Procedure SSDisplayCols;Var C:Wd;Begin { Affiche A   B   C   D   .... }
 WESetKr(Q.W,LotusColors.Col);
 With Q.ScreenBlock do Begin
  For C:=Start.Col to(Stop.Col)do
   WEPutTxtXY(Q.W,Q.ColStart^[C-Start.Col]-3,0,CenterStr(Col2Str(C),SSColWidth(Q,C)));
 End;
End;

Procedure SSDisplayRows;Var R:Wd;Begin
 With Q.ScreenBlock do Begin
  WESetKr(Q.W,LotusColors.Row);
  For R:=Start.Row to(Stop.Row)do
   WEPutTxtXY(Q.W,0,1+R-Start.Row,StrUSpc(Str(R),Q.RowNumberSpace));
 End;
End;

Procedure SSDisplayInfo;Var S:String;Begin
 S:=Str(Q.Number);
 If(Q.Current)Then IncStr(S,#4)Else IncStr(S,' ');
 If(Q.AutoCalc)Then IncStr(S,'A')Else IncStr(S,' ');
 If(Q.DisplayFormulas)Then IncStr(S,'F')Else IncStr(S,' ');
 WESetKr(Q.W,LotusColors.Info);
 WEPutTxtXY(Q.W,0,0,StrUSpc(S,Q.RowNumberSpace));
End;

Procedure SSDisplayAllCells;Begin
{ DisplayArea.Clear;}
 ClrWn(Q.W.X1+1+Q.RowNumberSpace,Q.W.Y1+1+1,Q.W.X2-1,Q.W.Y2-1,LotusColors.Blank);
 SSDisplayBlock(Q,Q.ScreenBlock);
End;

Procedure SSDisplayCell;Var S:String;Begin { Bar se promenant }
 S:=SSCellToFString(Q,P,Q.W.Kr);
 WEPutTxtXY(Q.W,SSColToX(Q,P.Col)-1-Q.W.X1,SSRowToY(Q,P.Row)-1-Q.W.Y1-1,S);
End;

Procedure SSDisplayCellData;Var CP:CellPtr;Begin
 CP:=Q.CellHash.Search(Q.CurrPos);
 WESetEndBarTxtX(Q.W,1,StrUSpc(Col2Str(Q.CurrPos.Col)+
		 Str(Q.CurrPos.Row)+' '+CP^.Name,17),LotusColors.CellData);
 WEPutLastBar(CP^.DisplayString(Q.DisplayFormulas,Q.MaxDecimalPlaces));
End;

Procedure SSDisplayCellBlock;Var P:CellPos;Begin
 With Q.ScreenBlock do
  For P.Row:=Omega(R1,Start.Row)to Alpha(R2,Stop.Row)do
   For P.Col:=Omega(C1,Start.Col)to Alpha(C2,Stop.Col)do SSDisplayCell(Q,P);
End;

Procedure SSDisplayBlock;Begin
 With B do SSDisplayCellBlock(Q,Start.Col,Start.Row,Stop.Col,Stop.Row);
End;

Procedure SSDisplayBlockDiff;Var B:Block;DisplayMiddle:Bool;Begin
 If Compare(B1,B2,SizeOf(Block))Then Exit;
 With B do Begin
  DisplayMiddle:=No;
  If(B1.Stop.Col<>B2.Stop.Col)Then Begin
   B.Start.Row:=B1.Start.Row;
   B.Start.Col:=Alpha(Succ(B1.Stop.Col),Succ(B2.Stop.Col));
   B.Stop.Row:=Alpha(B1.Stop.Row,B2.Stop.Row);
   B.Stop.Col:=Omega(B1.Stop.Col,B2.Stop.Col);
   SSDisplayBlock(Q,B);
   DisplayMiddle:=Ya;
  End;
  If(B1.Stop.Row<>B2.Stop.Row)Then Begin
   B.Start.Row:=Alpha(Succ(B1.Stop.Row),Succ(B2.Stop.Row));
   B.Start.Col:=B1.Start.Col;
   B.Stop.Row:=Omega(B1.Stop.Row,B2.Stop.Row);
   B.Stop.Col:=Alpha(B1.Stop.Col,B2.Stop.Col);
   SSDisplayBlock(Q,B);
   DisplayMiddle:=Ya;
  End;
  If(DisplayMiddle)Then Begin
   B.Start.Row:=Alpha(Succ(B1.Stop.Row),Succ(B2.Stop.Row));
   B.Start.Col:=Alpha(Succ(B1.Stop.Col),Succ(B2.Stop.Col));
   B.Stop.Row:=Omega(B1.Stop.Row,B2.Stop.Row);
   B.Stop.Col:=Omega(B1.Stop.Col,B2.Stop.Col);
   SSDisplayBlock(Q,B);
  End;
 End;
End;

Procedure SSDisplayCol;Begin
 With Q.ScreenBlock do SSDisplayCellBlock(Q,Col,Start.Row,Col,Stop.Row);
End;

Procedure SSDisplayRow;Begin
 With Q.ScreenBlock do SSDisplayCellBlock(Q,Start.Col,Row,Stop.Col,Row);
End;

Procedure SSDisplayFileName;Var S:PathStr;Begin
 If Q.FileName=''Then S:='Aucun fichier'Else S:=FileExpand(Q.FileName);
 WESetEndBarTxtX(Q.W,18,'³',(LotusColors.FileName and $F0)+$F);
 WESetEndBarTxtX(Q.W,20,StrUSpc(S,Q.W.MaxX-20),LotusColors.FileName);
End;

Procedure SSDisplay;Begin
 SSDisplayCols(Q);
 SSDisplayRows(Q);
 SSDisplayInfo(Q);
 SSDisplayAllCells(Q);
 PutFreeMemory;
 SSDisplayCellData(Q);
 SSDisplayFileName(Q);
 SSSetChanged(Q,Q.Changed);
End;

Procedure SSSetChanged;Var C:Char;Begin
 Q.Changed:=IsChanged;
 If(Q.Changed)Then C:='*'Else C:=' ';
 WESetEndBarTxtX(Q.W,19,C,LotusColors.Changed);
End;

Procedure SSMakeCurrent;Begin
 Q.Current:=Ya;
 SSDisplayInfo(Q);
End;

Procedure SSMakeNotCurrent;Begin
 Q.Current:=No;
 SSDisplayInfo(Q);
End;

Procedure SSUpdate;Var P,U:CellPos;CP:CellPtr;O:Wd;Begin
 WEPutLastBar(MsgRecalc);
 With Q.CellHash do Begin
  For P.Row:=1to(Q.LastPos.Row)do Begin
   For P.Col:=1to(Q.LastPos.Col)do Begin
    CP:=Search(P);
    If(CP^.ShouldUpdate)Then Begin
     With FormulaCellPtr(CP)^do Begin
      POInit(Parser,@Q.CellHash,Formula,Q.MaxCols,Q.MaxRows);
      POParse(Parser);
      Value:=Parser.ParseValue;Error:=Parser.ParseError;
      O:=CP^.Overwritten(Q.CellHash,Q.FormatHash,Q.WidthHash,
       Q.LastPos,Q.MaxCols,GetColWidth,Q.DisplayFormulas);
      If((Q.OverwriteHash.Change(CP,O))and(UDisplay)and
	 (CP^.Loc.Col+O>=Q.ScreenBlock.Start.Col))Then Begin
       U:=CP^.Loc;
       For U.Col:=CP^.Loc.Col to(Q.ScreenBlock.Stop.Col)do Begin
       	If BKCellInBlock(Q.ScreenBlock,U)Then SSDisplayCell(Q,U);
       End;
      End;
     End;
    End;
   End;
  End;
 End;
 If(UDisplay)Then PutFreeMemory;
 WEPutLastBar('');
End;

Procedure SSToggleFormulaDisplay;Var CP:CellPtr;OChanged:Bool;Begin
 Q.DisplayFormulas:=Not Q.DisplayFormulas;
 SSDisplayInfo(Q);
 OChanged:=Ya;
 With Q.CellHash do Begin
  CP:=FirstItem;
  While(CP<>Nil)and(OChanged)do Begin
   If(CP^.ShouldUpdate)Then
    OChanged:=Q.OverwriteHash.Change(CP,CP^.Overwritten(Q.CellHash,
     Q.FormatHash,Q.WidthHash,Q.LastPos,Q.MaxCols,GetColWidth,Q.DisplayFormulas));
   CP:=NextItem;
  End;
 End;
 SSDisplayAllCells(Q);
 PutFreeMemory;
End;

Procedure SSSetScreenColStart;Begin
 Q.ScreenBlock.Start.Col:=NewCol;
 SSFindScreenColStop(Q);
 SSFindScreenColStart(Q);
End;

Procedure SSSetScreenColStop;Begin
 Q.ScreenBlock.Stop.Col:=NewCol;
 SSFindScreenColStart(Q);
 SSFindScreenColStop(Q);
End;

Procedure SSSetScreenRowStart;Begin
 Q.ScreenBlock.Start.Row:=NewRow;
 SSFindScreenRowStop(Q);
End;

Procedure SSSetScreenRowStop;Begin
 Q.ScreenBlock.Stop.Row:=NewRow;
 SSFindScreenRowStart(Q)
End;

Procedure SSFindScreenColStart;Var Index,Place:Int;Temp,Width:Byte;Begin
 With Q.ScreenBlock do Begin
  Index:=0;Place:=Succ(Q.DisplayArea.LowerRight.Col);Width:=SSColWidth(Q,Stop.Col);
  Repeat
   Q.ColStart^[Index]:=Place-Width; Dec(Place,Width); Inc(Index);
   If Stop.Col-Index=0Then Width:=0 Else Width:=SSColWidth(Q,Stop.Col-Index);
  Until(Width=0)or(Place-Width<Q.DisplayArea.UpperLeft.Col);
  Start.Col:=Succ(Stop.Col-Index);Dec(Index);
  If(Q.ColStart^[Index]<>Q.DisplayArea.UpperLeft.Col)Then Begin
   Temp:=Q.ColStart^[Index]-Q.DisplayArea.UpperLeft.Col;
   For Place:=0to Index do Dec(Q.ColStart^[Place],Temp);
  End;
  If Index>0Then For Place:=0to Pred(Index)shr 1do Begin
   Temp:=Q.ColStart^[Index-Place];Q.ColStart^[Index-Place]:=Q.ColStart^[Place];Q.ColStart^[Place]:=Temp;
  End;
 End;
End;

Procedure SSFindScreenColStop;Var Index,Place,Width:Byte;Begin
 With Q.ScreenBlock do Begin
  Index:=0;Place:=Q.DisplayArea.UpperLeft.Col;Width:=SSColWidth(Q,Start.Col);
  Repeat
   Q.ColStart^[Index]:=Place;Inc(Place,Width);Inc(Index);
   If(Long(Index)+Start.Col>Q.MaxCols)Then Width:=0 Else Width:=SSColWidth(Q,Index+Start.Col);
  Until(Width=0)or(Place+Width>Succ(Q.DisplayArea.LowerRight.Col));
  Stop.Col:=Pred(Start.Col+Index);
 End;
End;

Procedure SSFindScreenRowStart;Begin
 With Q.ScreenBlock do Begin
  If Long(Stop.Row)-Q.TotalRows<0Then Begin
   Start.Row:=1;
   SSFindScreenRowStop(Q);
  End
   Else
  Start.Row:=Succ(Stop.Row-Q.TotalRows);
 End;
End;

Procedure SSFindScreenRowStop;Begin
 With Q.ScreenBlock do Begin
  If Long(Start.Row)+Q.TotalRows>Succ(LongInt(Q.MaxRows))Then Begin
   Stop.Row:=Q.MaxRows;
   SSFindScreenRowStart(Q);
  End
   else
  Stop.Row:=Pred(Start.Row+Q.TotalRows);
 End;
End;

Procedure SSSetBlankArea;Var C:Wd;Begin
 With Q.BlankArea do Begin
  MoveLeft(Q.DisplayArea,Q.BlankArea,SizeOf(Q.DisplayArea));
  With Q.ScreenBlock do C:=Q.ColStart^[Stop.Col-Start.Col]+SSColWidth(Q,Stop.Col);
  If(C>Q.DisplayArea.LowerRight.Col)Then Q.NoBlankArea:=Ya
  Else Begin;Q.NoBlankArea:=No;UpperLeft.Col:=Q.W.X1+C;End;
 End;
End;

Function SSAddCell;Var CP,S:CellPtr;OldLastPos:CellPos;Good:Bool;Begin
 SSAddCell:=No;
 Case(CellType)of
  ClValue:CP:=System.New(ValueCellPtr,Init(P,E,V));
  ClFormula:CP:=System.New(FormulaCellPtr,Init(P,E,V,I));
  ClText:CP:=System.New(TextCellPtr,Init(P,I));
  ClRepeat:CP:=System.New(RepeatCellPtr,Init(P,I^.Data^[2]));
 End;
 If(CP=Nil)Then Exit;
 If Not(Q.CellHash.Add(CP))Then Begin;Dispose(CP,Done);Exit;End;
 OldLastPos:=Q.LastPos;Q.LastPos.Col:=Omega(P.Col,Q.LastPos.Col);Q.LastPos.Row:=Omega(P.Row,Q.LastPos.Row);
 If Not(Q.OverwriteHash.Add(CP,CP^.Overwritten(Q.CellHash,Q.FormatHash,
        Q.WidthHash,Q.LastPos,Q.MaxCols,GetColWidth,Q.DisplayFormulas)))Then Begin
  Q.LastPos:=OldLastPos;
  Q.CellHash.Delete(CP^.Loc,S);
  Dispose(CP,Done);
  Exit;
 End;
 S:=Q.OverwriteHash.Search(CP^.Loc);
 If(S<>Empty)Then
  Good:=Q.OverwriteHash.Change(S,S^.Overwritten(Q.CellHash,Q.FormatHash,
   Q.WidthHash,Q.LastPos,Q.MaxCols,GetColWidth,Q.DisplayFormulas));
 SSAddCell:=Ya;
End;

Procedure SSDeleteCell;Var CP:CellPtr;Good:Bool;Begin
 Q.CellHash.Delete(P,CP);
 If(CP<>Nil)Then Begin
  Dispose(CP,Done);
  Q.OverwriteHash.Delete(P);
  If P.Col>1Then Begin
   Dec(P.Col);
   CP:=Q.OverwriteHash.Search(P);
   If(CP=Empty)Then CP:=Q.CellHash.Search(P);
   If(CP<>Empty)Then
    Good:=Q.OverwriteHash.Change(CP,CP^.Overwritten(Q.CellHash,
     Q.FormatHash,Q.WidthHash,Q.LastPos,Q.MaxCols,GetColWidth,Q.DisplayFormulas));
  End;
  Deleted:=Ya;
 End
  else
 Deleted:=No;
End;

Procedure SSDeleteBlock;Var P:CellPos;H,D:HashItemPtr;I:Wd;CP:CellPtr;Begin
 WEPutLastBar(MsgBlockDelete);
 Deleted:=No;
 With Q.CellHash,B do Begin
  For I:=1to(Buckets)do Begin
   H:=HashData^[I];
   While(H<>Nil)do Begin
    D:=H;H:=H^.Next;
    MoveLeft(D^.Data,CP,SizeOf(CP));
    With CP^do If BKCellInBlock(B,Loc)Then SSDeleteCell(Q,Loc,Deleted);
   End;
  End;
 End;
 WEPutLastBar('');
End;

Function SSCellToFString;Var CP:CellPtr;S:String;S1:DollarStr;F:Byte;ColorFound:Bool;Colr:Byte;Begin
 ColorFound:=Ya;
 If(Q.Current)and(SSSameCellPos(Q,P,Q.CurrPos))Then Color:=LotusColors.HighLight else
 If(Q.BlockOn)and(BKCellInBlock(Q.CurrBlock,P))Then Color:=LotusColors.Block
					 Else ColorFound:=No;
 CP:=Q.CellHash.Search(P);
 If(CP^.HasError)Then Begin
  S:='ERREUR';S1:='';
  If(ColorFound)Then Inc(Color,$80)else Color:=LotusColors.CellError;
  F:=Byte(JCenter)shl JustShift;
 End
  Else
 Begin
  S:=CP^.FormattedString(Q.OverwriteHash,Q.FormatHash,Q.WidthHash,
   GetColWidth,P,Q.DisplayFormulas,1,SSColWidth(Q,P.Col),S1,Colr);
  If Not(ColorFound)Then Color:=Colr;
  F:=CP^.Format(Q.FormatHash,Q.DisplayFormulas);
 End;
 Case Justification((F shr JustShift)and JustPart)of
  JLeft:SSCellToFString:=StrUSpc(S,SSColWidth(Q,P.Col));
  JCenter:SSCellToFString:=S1+CenterStr(S,SSColWidth(Q,P.Col)-Length(S1));
  JRight:SSCellToFString:=S1+RightJustifyStr(S,SSColWidth(Q,P.Col)-Length(S1));
 End;
End;

Procedure SSSetLastPos;Var CP:CellPtr;I:Wd;ColFound,RowFound:Bool;Begin
 With Q.CellHash do Begin
  ColFound:=DPos.Col<Q.LastPos.Col;
  RowFound:=DPos.Row<Q.LastPos.Row;
  If(Not(ColFound))or(Not(RowFound))Then Begin
   If Not(ColFound)Then	Q.LastPos.Col:=1;
   If Not(RowFound)Then	Q.LastPos.Row:=1;
   CP:=FirstItem;
   While(CP<>Nil)do Begin
    If Not(ColFound)Then Begin
     If(CP^.Loc.Col>Q.LastPos.Col)Then Begin
      Q.LastPos.Col:=CP^.Loc.Col; ColFound:=Q.LastPos.Col=DPos.Col;
      If(ColFound)and(RowFound)Then Exit;
     End;
    End;
    If Not(RowFound)Then Begin
     If(CP^.Loc.Row>Q.LastPos.Row)Then Begin
      Q.LastPos.Row:=CP^.Loc.Row; RowFound:=Q.LastPos.Row=DPos.Row;
      If(ColFound)and(RowFound)Then Exit;
     End;
    End;
    CP:=NextItem;
   End;
  End;
 End;
End;

Function SSGetCurrCol;Begin;SSGetCurrCol:=Q.CurrPos.Col;End;
Function SSGetCurrRow;Begin;SSGetCurrRow:=Q.CurrPos.Row;End;

Function SSColToX;Begin
 SSColToX:=Q.ColStart^[Col-Q.ScreenBlock.Start.Col];
End;

Function SSRowToY;Begin
 SSRowToY:=Row+Q.DisplayArea.UpperLeft.Row-Q.ScreenBlock.Start.Row;
End;

Function SSColWidth;Var Width:Wd;Begin
 Width:=Q.WidthHash.Search(Col);
 If Width=0Then SSColWidth:=Q.DefaultColWidth Else SSColWidth:=Width;
End;

Function SSSameCellPos;Begin
 SSSameCellPos:=Compare(P1,P2,SizeOf(CellPos))
End;

Procedure SSFixOverwrite;Var CP,D:CellPtr;I:Wd;Good:Bool;Begin
 With Q.CellHash do Begin
  CP:=FirstItem;
  While(CP<>Nil)do Begin
   If Not(Q.OverwriteHash.Add(CP,CP^.Overwritten(Q.CellHash,Q.FormatHash,Q.WidthHash,
          Q.LastPos,Q.MaxCols,GetColWidth,Q.DisplayFormulas)))Then Begin
    Q.CellHash.Delete(CP^.Loc,D);
    Dispose(CP,Done);
    Exit;
   End;
   CP:=Q.OverwriteHash.Search(CP^.Loc);
   If(CP<>Empty)Then
    Good:=Q.OverwriteHash.Change(CP,CP^.Overwritten(Q.CellHash,
     Q.FormatHash,Q.WidthHash,Q.LastPos,Q.MaxCols,GetColWidth,Q.DisplayFormulas));
   CP:=NextItem;
  End;
 End;
End;

Function SSFromFile;Var Header:String[Length(FileHeader)];
TotalC:Long;TotalW:Wd;TotalF:Long;S:SSStream;NewLastPos:CellPos;Begin
 SSFromFile:=Ya;Name:=StrUp(Name);
 S.Init(Name,SOpen);
 If S.Status<>0Then Begin
  WEPutLastBar(ErrNoOpen);
  SSInit(Q,0,DefMaxCols,DefMaxRows,DefMaxDecimalPlaces,DefDecimalPlaces,DefColWidth);
  Exit;
 End
  Else
 Begin
  Header[0]:=Char(Length(FileHeader));
  S.Read(Header[1],Length(FileHeader));
  If(S.Status<>0)or(Header<>FileHeader)Then Begin
   ErrMsgOk(ErrNotSpreadsheet);
   S.Done;
   SSInit(Q,0,DefMaxCols,DefMaxRows,DefMaxDecimalPlaces,DefDecimalPlaces,DefColWidth);
   Exit;
  End;
  Q.FileName:=Name;
  S.Read(NewLastPos,SizeOf(NewLastPos));
  S.Read(TotalW,SizeOf(TotalW));
  S.Read(TotalF,SizeOf(TotalF));
  S.Read(TotalC,SizeOf(TotalC));
  If Not SSInit(Q,TotalC,DefMaxCols,DefMaxRows,DefMaxDecimalPlaces,DefDecimalPlaces,DefColWidth)Then Begin
   S.Done;
   SSFromFile:=No;
   Exit;
  End;
  Q.LastPos:=NewLastPos;
  WEPutLastBar(MsgLoad);
  Q.FileName:=Name;
  Q.WidthHash.Load(S,TotalW);
  Q.FormatHash.Load(S,TotalF);
  Q.CellHash.Load(S,TotalC);
  S.Done;
  SSFixOverwrite(Q);
  SSUpdate(Q,No);
  WEPutLastBar('');
 End;
 SSFromFile:=Ya;
End;

Procedure SSToFile;Var Header:String[Length(FileHeader)];S:SSStream;Begin
 S.Init(Name,SCreate);
 If S.Status<>0Then Begin;WEPutLastBar(ErrNoOpen);Exit;End;
 WEPutLastBar(MsgSave);
 Q.FileName:=Name;Header:=FileHeader;
 S.Write(Header[1],Length(Header));
 S.Write(Q.LastPos,SizeOf(Q.LastPos));
 S.Write(Q.WidthHash.Items,2);
 S.Write(Q.FormatHash.Items,SizeOf(Q.FormatHash.Items));
 S.Write(Q.CellHash.Items,SizeOf(Q.CellHash.Items));
 Q.WidthHash.Store(S);
 Q.FormatHash.Store(S);
 Q.CellHash.Store(S);
 WEPutLastBar('');
 S.Done;
 If S.Status<>0Then __DiskFull Else SSSetChanged(Q,No);
End;

Procedure SSCheckForSave;Var S:String;Begin
 If(Q.Changed)and(WarningMsgYesNo(PromptSaveYN)=kbYes)Then Begin
  S:=Q.FileName;
  If(WinInp(40,'Sauve Chiffrier','Nom du fichier',CurrKrs.Dialog.Wins,No,S)=kbEnter)Then Begin
   If Path2Ext(S)=''Then AddStr(S,'.MGC');
   SSToFile(Q,S);
  End;
 End;
End;

{ Description
  ÍÍÍÍÍÍÍÍÍÍÍ

   Cette proc‚dure/object est appell‚e pour modifier la largeur de la
  colonne courant (A,B,C,...).
}

Procedure SSChangeWidth;Var _W,C:Wd;P:CellPos;O:Wd;CP:CellPtr;Begin
 C:=SSGetCurrCol(Q);_W:=0;
 If(WinInpNmWord(40,'Largeur colonne','Entrez la largeur de la colonne:',
		 CurrKrs.Dialog.Wins,MinColWidth,Q.MaxColWidth,_W)=kbEsc)Then Exit;
 With Q.WidthHash do Begin
  Delete(C);
  If(_W<>DefaultColWidth)Then If Not Add(C,_W)Then Exit;
 End;
 SSSetScreenColStart(Q,Q.ScreenBlock.Start.Col);
 SSSetChanged(Q,Ya);
 With Q.OverwriteHash do Begin
  Done;
  Init(SSOverwriteHashStart(Q,Q.CellHash.Items));
 End;
 With Q.CellHash do Begin
  CP:=FirstItem;
  While(CP<>Nil)do Begin
   O:=CP^.Overwritten(Q.CellHash,Q.FormatHash,Q.WidthHash,Q.LastPos,Q.MaxCols,GetColWidth,Q.DisplayFormulas);
   If O<>0Then Q.OverwriteHash.Add(CP,O);
   CP:=NextItem;
  End;
 End;
 If(Q.CurrPos.Col>Q.ScreenBlock.Stop.Col)Then SSSetScreenColStart(Q,Q.CurrPos.Col);
 SSDisplay(Q)
End;

Function SSCellHashStart;Begin
 SSCellHashStart:=Omega(100,Alpha(MaxBuckets,TotalCells div 10))
End;

Function SSWidthHashStart;Begin;SSWidthHashStart:=10;End;
Function SSOverwriteHashStart;Begin;SSOverwriteHashStart:=10;End;

Procedure SSPrint;
Var S:String;PageCols:Byte;PageV,PageH,StartCol,StartRow:Wd;
Finished,GoodFile,Error,Compress,Border,ESCPressed:Bool;

 Procedure WString(Const S:String);Begin
  If Not Prn(S)Then Begin
   ErrMsgOk(ErrPrinterError);
   Error:=Ya;Finished:=Ya;
  End;
 End;

 Function RowStartString(Row:Wd):String;Begin
  If(PageH=1)and(Border)Then RowStartString:=LeftJustifyStr(Str(Row),Q.RowNumberSpace)
			else RowStartString:='';
 End;

 Procedure PrintPage;Var I:Wd;S:String;Color,Cols,Rows:Byte;P:CellPos;Begin
  For I:=1to(PrintTopMargin)do Begin
   WString('');
   If(Error)Then Exit;
  End;
  Rows:=Alpha(PrintRows-PrintTopMargin-PrintBottomMargin,Succ(Q.MaxRows-StartRow));
  If(Border)Then Dec(Rows);
  Cols:=0;I:=Length(RowStartString(StartRow));
  While(I<=PageCols)do Begin;Inc(I,SSColWidth(Q,Cols+StartCol));Inc(Cols)End;
  Dec(Cols);Cols:=Alpha(Cols,Succ(Q.MaxCols-StartCol));
  If(Border)and(PageV=1)Then Begin
   S:=Spc(Length(RowStartString(StartRow)));
   For I:=StartCol to Pred(StartCol+Cols)do AddStr(S,CenterStr(Col2Str(I),SSColWidth(Q,I)));
   WString(S);
   If(Error)Then Exit;
  End;
  For P.Row:=StartRow to Pred(StartRow+Rows)do Begin
   S:=RowStartString(P.Row);
   For P.Col:=StartCol to Pred(StartCol+Cols)do AddStr(S,SSCellToFString(Q,P,Color));
   WString(S);
   If(Error)Then Exit;
  End;
  Inc(StartCol,Cols);
  If(StartCol>Q.LastPos.Col)or(StartCol=0)Then Begin
   Inc(StartRow,Rows);
   If(StartRow>Q.LastPos.Row)or(StartRow=0)Then Finished:=Ya
    Else
   Begin;Inc(PageV);PageH:=1;StartCol:=1;End;
  End
   Else
  Inc(PageH);
  Prn(Chr(caFF));
 End;

Begin
 If(WinInp(40,'Imprime Chiffrier','Nom du fichier',CurrKrs.Dialog.Wins,No,S)=kbEsc)Then Exit;
 Compress:=WarningMsgYesNo('Impression Compress‚')=kbYes;
 Border:=WarningMsgYesNo('Imprime les bordures')=kbYes;Error:=No;
 If(Compress)Then Begin;PageCols:=PrintCompressedCols;Prn(#15)End
             Else PageCols:=PrintNormalCols;
 PageV:=1;PageH:=1;StartCol:=1;StartRow:=1;Finished:=No;
 Repeat PrintPage Until Finished;
End;

Procedure SSDeleteColumn;
Var C:Wd;Start,Stop,P,OldPos,OldSPos:CellPos;Deleted:Bool;
OldName:PathStr;CP:CellPtr;H:HashItemPtr;B:Block;Begin
 C:=GetColumn(PromptColumnDelete,Q.MaxCols,Q.ColSpace);
 If C=0Then Exit;
 OldPos:=Q.CurrPos;OldSPos:=Q.ScreenBlock.Start;P.Col:=C;Deleted:=No;
 If(P.Col<=Q.LastPos.Col)Then Begin
  With B do Begin
   Start.Col:=P.Col;Start.Row:=1;Stop.Col:=P.Col;Stop.Row:=Q.LastPos.Row;
   Q.FormatHash.Delete(Start,Stop);
  End;
  SSDeleteBlock(Q,B,Deleted);
 End;
 Dec(Q.LastPos.Col);
 Q.WidthHash.Delete(C);
 With Q.CellHash do Begin
  CP:=FirstItem;
  While(CP<>Nil)do Begin
   With CP^do Begin
    If(Loc.Col>C)Then Dec(Loc.Col);
    If(CP^.ShouldUpdate)and(Loc.Col>C)Then FixFormulaCol(CP,-1,Q.MaxCols,Q.MaxRows);
   End;
   CP:=NextItem;
  End;
 End;
 With Q.WidthHash do Begin
  H:=FirstItem;
  While(H<>Nil)do Begin
   If(PWord(@H^.Data)^>C)Then Dec(PWord(@H^.Data)^);
   H:=NextItem;
  End;
 End;
 With Q.FormatHash do Begin
  H:=FirstItem;
  While(H<>Nil)do Begin
   MoveLeft(H^.Data,Start,SizeOf(Start));
   MoveLeft(H^.Data[SizeOf(CellPos)],Stop,SizeOf(Stop));
   If(Start.Col=C)and(Stop.Col=C)Then Delete(Start,Stop)
    Else
   Begin
    If(Start.Col>C)Then Begin
     Dec(Start.Col);
     MoveLeft(Start,H^.Data,SizeOf(Start));
    End;
    If(Stop.Col>C)Then Begin
     Dec(Stop.Col);
     MoveLeft(Stop,H^.Data[SizeOf(CellPos)],SizeOf(Stop));
    End;
   End;
   H:=NextItem;
  End;
 End;
 OldName:=Q.FileName;
 SSToFile(Q,TempFileName);
 SSDone(Q);
 SSFromFile(Q,TempFileName);
 DelFile(TempFileName);
 Q.FileName:=OldName;
 If(Deleted)Then P.Row:=Q.LastPos.Row Else P.Row:=1;
 Dec(P.Col);
 SSSetLastPos(Q,P);
 SSMakeCurrent(Q);
 SSSetChanged(Q,Ya);
 Q.CurrPos:=OldPos;
 SSSetScreenColStart(Q,OldSPos.Col);
 SSSetScreenRowStart(Q,OldSPos.Row);
 SSDisplay(Q)
End;

Procedure SSInsertColumn;
Var C:Wd;Start,Stop,P,OldPos,OldSPos:CellPos;Deleted:Bool;
H:HashItemPtr;OldName:PathStr;CP:CellPtr;B:Block;Begin
 C:=GetColumn(PromptColumnInsert,Q.MaxCols,Q.ColSpace);
 If C=0Then Exit;
 OldPos:=Q.CurrPos;OldSPos:=Q.ScreenBlock.Start;Deleted:=No;
 If(Q.LastPos.Col=Q.MaxCols)Then Begin
  With B do Begin
   Start.Col:=Q.MaxCols; Start.Row:=1; Stop.Col:=Q.MaxCols; Stop.Row:=Q.LastPos.Row;
   Q.FormatHash.Delete(Start,Stop);
  End;
  SSDeleteBlock(Q,B,Deleted);
 End
  Else
 Inc(Q.LastPos.Col);
 P.Col:=C;
 Q.WidthHash.Delete(Q.MaxCols);
 With Q.CellHash do Begin
  CP:=FirstItem;
  While(CP<>Nil)do Begin
   With CP^do Begin
    If(Loc.Col>=C)Then Inc(Loc.Col);
    If(CP^.ShouldUpdate)and(Loc.Col>=C)Then FixFormulaCol(CP,1,Q.MaxCols,Q.MaxRows);
   End;
   CP:=NextItem;
  End;
 End;
 With Q.WidthHash do Begin
  H:=FirstItem;
  While(H<>Nil)do Begin
   If(PWord(@H^.Data)^>=C)Then Inc(PWord(@H^.Data)^);
   H:=NextItem;
  End;
 End;
 With Q.FormatHash do Begin
  H:=FirstItem;
  While(H<>Nil)do Begin
   MoveLeft(H^.Data,Start,SizeOf(Start));
   MoveLeft(H^.Data[SizeOf(CellPos)],Stop,SizeOf(Stop));
   If(Start.Col>=C)Then Begin
    Inc(Start.Col);
    MoveLeft(Start,H^.Data,SizeOf(Start));
   End;
   If(Stop.Col>=C)Then Begin
    Inc(Stop.Col);
    MoveLeft(Stop,H^.Data[SizeOf(CellPos)],SizeOf(Stop))
   End;
   H:=NextItem;
  End;
 End;
 OldName:=Q.FileName;
 SSToFile(Q,TempFileName);
 SSDone(Q);
 SSFromFile(Q,TempFileName);
 DelFile(TempFileName);
 Q.FileName:=OldName;
 If(Deleted)Then P.Row:=Q.LastPos.Row Else P.Row:=1;
 If(Q.LastPos.Col=Q.MaxCols)Then P.Col:=Q.MaxCols Else Inc(P.Col);
 SSSetLastPos(Q,P);
 SSMakeCurrent(Q);
 SSSetChanged(Q,Ya);
 Q.CurrPos:=OldPos;
 SSSetScreenColStart(Q,OldSPos.Col);
 SSSetScreenRowStart(Q,OldSPos.Row);
 SSDisplay(Q);
End;

Procedure SSDeleteRow;
Var R:Wd;Start,Stop,P,OldPos,OldSPos:CellPos;Deleted:Bool;
OldName:PathStr;CP:CellPtr;B:Block;H:HashItemPtr;Begin
 R:=GetRow(PromptRowDelete,Q.MaxRows);
 If(R=0)or(R>Q.LastPos.Row)Then Exit;
 OldPos:=Q.CurrPos;OldSPos:=Q.ScreenBlock.Start;P.Row:=R;
 If(P.Row<=Q.LastPos.Row)Then Begin
  With B do Begin
   Start.Col:=1;Start.Row:=P.Row;Stop.Col:=Q.LastPos.Col;Stop.Row:=P.Row;
   Q.FormatHash.Delete(Start,Stop);
  End;
  SSDeleteBlock(Q,B,Deleted);
 End;
 Dec(Q.LastPos.Row);
 With Q.CellHash do Begin
  CP:=FirstItem;
  While(CP<>Nil)do Begin
   With CP^do Begin
    If(Loc.Row>R)Then Dec(Loc.Row);
    If(CP^.ShouldUpdate)and(Loc.Row>R)Then FixFormulaRow(CP,-1,Q.MaxCols,Q.MaxRows);
   End;
   CP:=NextItem;
  End;
 End;
 With Q.FormatHash do Begin
  H:=FirstItem;
  While(H<>Nil)do Begin
   MoveLeft(H^.Data,Start,SizeOf(Start));
   MoveLeft(H^.Data[SizeOf(CellPos)],Stop,SizeOf(Stop));
   If(Start.Row=R)and(Stop.Row=R)Then Delete(Start,Stop)
    Else
   Begin
    If(Start.Row>R)Then Begin
     Dec(Start.Row);
     MoveLeft(Start,H^.Data,SizeOf(Start));
    End;
    If(Stop.Row>R)Then Begin
     Dec(Stop.Row);
     MoveLeft(Stop,H^.Data[SizeOf(CellPos)],SizeOf(Stop));
    End;
   End;
   H:=NextItem;
  End;
 End;
 OldName:=Q.FileName;
 SSToFile(Q,TempFileName);
 SSDone(Q);
 SSFromFile(Q,TempFileName);
 DelFile(TempFileName);
 Q.FileName:=OldName;
 If(Deleted)Then P.Col:=Q.LastPos.Col Else P.Col:=1;
 Dec(P.Row);
 SSSetLastPos(Q,P);
 SSMakeCurrent(Q);
 SSSetChanged(Q,Ya);
 Q.CurrPos:=OldPos;
 SSSetScreenColStart(Q,OldSPos.Col);
 SSSetScreenRowStart(Q,OldSPos.Row);
 SSDisplay(Q)
End;

Procedure SSInsertRow;
Var R:Wd;Start,Stop,P,OldPos,OldSPos:CellPos;Deleted:Bool;
OldName:PathStr;CP:CellPtr;B:Block;H:HashItemPtr;Begin
 R:=GetRow(PromptRowInsert,Q.MaxRows);
 If(R=0)or(R>Q.LastPos.Row)Then Exit;
 OldPos:=Q.CurrPos;OldSPos:=Q.ScreenBlock.Start;
 If(Q.LastPos.Row=Q.MaxRows)Then Begin
  With B do Begin
   Start.Col:=1;Start.Row:=Q.MaxRows;Stop.Col:=Q.LastPos.Col;Stop.Row:=Q.MaxRows;
   Q.FormatHash.Delete(Start,Stop);
  End;
  SSDeleteBlock(Q,B,Deleted);
 End
  Else
 Inc(Q.LastPos.Row);
 P.Row:=R;
 With Q.CellHash do Begin
  CP:=FirstItem;
  While(CP<>Nil)do Begin
   With CP^do Begin
    If(Loc.Row>=R)Then Inc(Loc.Row);
    If(CP^.ShouldUpdate)and(Loc.Row>=R)Then FixFormulaRow(CP,1,Q.MaxCols,Q.MaxRows);
   End;
   CP:=NextItem;
  End;
 End;
 With Q.FormatHash do Begin
  H:=FirstItem;
  While(H<>Nil)do Begin
   MoveLeft(H^.Data,Start,SizeOf(Start));
   MoveLeft(H^.Data[SizeOf(CellPos)],Stop,SizeOf(Stop));
   If(Start.Row>=R)Then Begin
    Inc(Start.Row);
    MoveLeft(Start,H^.Data,SizeOf(Start));
   End;
   If(Stop.Row>=R)Then Begin
    Inc(Stop.Row);
    MoveLeft(Stop,H^.Data[SizeOf(CellPos)],SizeOf(Stop));
   End;
   H:=NextItem;
  End;
 End;
 OldName:=Q.FileName;
 SSToFile(Q,TempFileName);
 SSDone(Q);
 SSFromFile(Q,TempFileName);
 DelFile(TempFileName);
 Q.FileName:=OldName;
 If(Deleted)Then P.Col:=Q.LastPos.Col Else P.Col:=1;
 If(Q.LastPos.Row=Q.MaxRows)Then P.Row:=Q.MaxRows Else Inc(P.Row);
 SSSetLastPos(Q,P);
 SSMakeCurrent(Q);
 SSSetChanged(Q,Ya);
 Q.CurrPos:=OldPos;
 SSSetScreenColStart(Q,OldSPos.Col);
 SSSetScreenRowStart(Q,OldSPos.Row);
 SSDisplay(Q)
End;

(*{$IFNDEF VER70}*)
Procedure SSStream.RegisterTypes;Begin
 DosStream.RegisterTypes;
 Register(TypeOf(ValueCell),@ValueCell.Store,@ValueCell.Load);
 Register(TypeOf(TextCell),@TextCell.Store,@TextCell.Load);
 Register(TypeOf(FormulaCell),@FormulaCell.Store,@FormulaCell.Load);
 Register(TypeOf(RepeatCell),@RepeatCell.Store,@RepeatCell.Load);
End;
(*{$ENDIF}*)

Constructor TextCell.Init;Begin
 Cell.Init(InitLoc);
 Txt:=System.New(LStringPtr);
 If(Txt=Nil)Then Fail Else LSInit(Txt^);
 If Not(LSAssign(Txt^,InitTxt^))Then Begin;Done;Fail;End;
End;

Destructor TextCell.Done;Begin
 LSDone(Txt^);
 Dispose(Txt)
End;

Function TextCell.CellType;Begin;CellType:=ClText;End;
Function TextCell.LegalValue;Begin;LegalValue:=No;End;
Function TextCell.Name;Begin;Name:=TextCellName;End;

Function TextCell.Format;Var F:Byte;Begin
 If FHash.Search(Loc,F)Then Format:=F else Format:=0;
End;

Function TextCell.Width;Begin;Width:=Txt^.Len;End;

Function TextCell.Overwritten;Var CellWidth:Long;Total:Wd;P:CellPos;Begin
 P:=Loc;CellWidth:=Width(FHash,FormulasDisplayed);Total:=0;
 Repeat
  Inc(Total);Dec(CellWidth,GetColWidth(WHash,P.Col));Inc(P.Col)
 Until(CellWidth<=0)or(P.Col=MaxCols)or(CHash.Search(P)<>Empty);
 Dec(Total);Overwritten:=Total;
End;

Function TextCell.ShouldUpdate;Begin;ShouldUpdate:=No;End;
Function TextCell.HasError;Begin;HasError:=No;End;
Function TextCell.CurrValue;Begin;CurrValue:=0;End;

Function TextCell.OverwriteStart;Var F:Byte;C,Place:Wd;Begin
 F:=Format(FHash,DisplayFormulas);Place:=1;C:=Loc.Col;
 Repeat
  Inc(Place,GetColWidth(WHash,C));Inc(C)
 Until C=EndCol;
 OverwriteStart:=Place;
End;

Procedure TextCell.EditString;Begin;LSAssign(L^,Txt^)End;
Function TextCell.DisplayString;Begin;DisplayString:=LSCopy(Txt^,2,GetNmXTxts)End;

Function TextCell.FormattedString;Begin
 DString:='';Color:=LotusColors.TextCell;FormattedString:=LSCopy(Txt^,Succ(Start),ColWidth)
End;

Function TextCell.CopyString;Begin
 LSAssign(L^,Txt^);
 CopyString:=L;
End;

Constructor TextCell.Load;Begin
 S.Read(Loc,SizeOf(Loc));
 Txt:=System.New(LStringPtr);
 If(Txt=Nil)Then Begin;__OutOfMemory;Exit;End;
 LSInit(Txt^);
 If Not(LSFromStream(Txt^,S))Then Begin
  LSDone(Txt^);
  Dispose(Txt);
  __OutOfMemory;
 End;
End;

Procedure TextCell.Store;Begin
 S.Write(Loc,SizeOf(Loc));
 LS2Stream(Txt^,S)
End;

Constructor ValueCell.Init;Begin
 Cell.Init(InitLoc);
 Error:=InitError;Value:=InitValue;
End;

Function ValueCell.CellType;Begin;CellType:=ClValue;End;
Function ValueCell.LegalValue;Begin;LegalValue:=Ya;End;
Function ValueCell.Name;Begin;Name:=ValueCellName;End;

Function ValueCell.Format;Var F:Byte;Begin
 If FHash.Search(Loc,F)Then Format:=F else Format:=(Byte(JRight)shl 4)+4;
End;

Function ValueCell.Width;Var S:String;F:Byte;P,W:Wd;Begin
 F:=Format(FHash,FormulasDisplayed);
 S:=RealStr2(Value,1,F and DecPlacesPart);W:=Length(S);
 If F and DollarPart<>0Then Inc(W,Length(DollarString));
 If F and CommasPart<>0Then Begin
  P:=Pos('.', S);
  If P=0Then P:=Length(S);
  Inc(W,(P-2)div 3);
 End;
 Width:=W;
End;

Function ValueCell.Overwritten;Var CellWidth:Long;Total:Wd;P:CellPos;Begin
 P:=Loc;CellWidth:=Width(FHash,FormulasDisplayed);Total:=0;
 Repeat
  Inc(Total);Dec(CellWidth,GetColWidth(WHash,P.Col));Inc(P.Col)
 Until (CellWidth<=0)or(P.Col=MaxCols)or(CHash.Search(P)<>Empty);
 Dec(Total);
 Overwritten:=Total;
End;

Function ValueCell.ShouldUpdate; Begin ShouldUpdate:=No; End;
Function ValueCell.HasError;Begin;HasError:=Error;End;
Function ValueCell.CurrValue;Begin;CurrValue:=Value;End;

Function ValueCell.OverwriteStart;Var F:Byte;C,Place:Wd;Begin
 F:=Format(FHash,DisplayFormulas);Place:=1;C:=Loc.Col;
 Repeat
  Inc(Place,GetColWidth(WHash,C));Inc(C)
 Until C=EndCol;
 If F and DollarPart<>0Then Dec(Place,Length(DollarString));
 OverwriteStart:=Place;
End;

Procedure ValueCell.EditString;Begin
 LSFromString(L^,RealStr2(Value,1,MaxDecPlaces));
End;

Function ValueCell.DisplayString;Begin
 DisplayString:=RealStr2(Value,1,MaxDecPlaces);
End;

Function ValueCell.FormattedString;Var I:Wd;S:String;F:Byte;Begin
 F:=Format(FHash,FormulasDisplayed); S:=RealStr2(Value,1,F and DecPlacesPart);
 If(Start=1)and(F and DollarPart<>0)Then DString:=' $ 'else DString:='';
 If F and CommasPart<>0Then Begin
  I:=Pos('.', S);
  If I=0Then I:=Length(S);
  While I>4do Begin
   InsStr(S,I-3,',');
   Dec(I,3);
  End;
 End;
 Color:=LotusColors.ValueCell;FormattedString:=Copy(S,Start,ColWidth);
End;

Function ValueCell.CopyString;Begin;CopyString:=L;End;

Constructor ValueCell.Load;Begin
 S.Read(Loc,SizeOf(Loc));
 S.Read(Error,SizeOf(Error));
 S.Read(Value,SizeOf(Value));
End;

Procedure ValueCell.Store;Begin
 S.Write(Loc,SizeOf(Loc));
 S.Write(Error,SizeOf(Error));
 S.Write(Value,SizeOf(Value));
End;

Constructor WidthHashTable.Init;Begin
 If Not HashTable.Init(InitBuckets)Then Fail;
 DefaultColWidth:=InitDefaultColWidth;
End;

Destructor WidthHashTable.Done;Begin
 HashTable.Done;
End;

Function WidthHashTable.Add;Begin;CurrCol:=SCol;CurrWidth:=NewWidth;Add:=HashTable.Add;End;

Procedure WidthHashTable.Delete;Begin
 CurrCol:=Col;
 HashTable.Delete(Nil);
End;

Function WidthHashTable.Search;Var I:HashItemPtr;W:Byte;Begin
 CurrCol:=Col;I:=HashTable.Search;
 If(I=Nil)Then Search:=0
  else
 Begin
  MoveLeft(I^.Data[SizeOf(CurrCol)],W,SizeOf(W));
  Search:=W;
 End;
End;

Function WidthHashTable.HashValue;Begin;HashValue:=CurrCol;End;

Function WidthHashTable.Found;Var C:Wd;Begin
 MoveLeft(Item^.Data,C,SizeOf(C));
 Found:=CurrCol=C;
End;

Procedure WidthHashTable.CreateItem(Var Item:HashItemPtr);Begin
 MoveLeft(CurrCol,Item^.Data,SizeOf(CurrCol));
 MoveLeft(CurrWidth,Item^.Data[SizeOf(CurrCol)],SizeOf(CurrWidth))
End;

Function WidthHashTable.ItemSize;Begin;ItemSize:=SizeOf(CurrCol)+SizeOf(CurrWidth)End;
Function WidthHashTable.GetDefaultColWidth;Begin;GetDefaultColWidth:=DefaultColWidth;End;

Procedure WidthHashTable.Load;Var I:Long;Col:Wd;Width:Byte;Begin
 For I:=1to(Total)do Begin
  S.Read(Col,SizeOf(Col));
  S.Read(Width,SizeOf(Width));
  If Not(Add(Col,Width))Then Begin;__OutOfMemory;Exit;End;
 End;
End;

Procedure WidthHashTable.Store;Var H:HashItemPtr;Col:Wd;Width:Byte;Begin
 H:=FirstItem;
 While(H<>Nil)do Begin
  MoveLeft(H^.Data,Col,SizeOf(Col));
  S.Write(Col,SizeOf(Col));
  MoveLeft(H^.Data[SizeOf(Col)],Width,SizeOf(Width));
  S.Write(Width,SizeOf(Width));
  H:=NextItem;
 End;
End;

Procedure FixFormulaCol;Var FormLen,Place,OldLen,NewLen:Wd;P:CellPos;S:String[10];Good:Bool;Begin
 With FormulaCellPtr(CP)^,GetFormula^do Begin
  Place:=1;Good:=Ya;
  While(Good)and(Place<=Len)do Begin
   If(FormulaStart(GetFormula,Place,MaxCols,MaxRows,P,FormLen))Then Begin
    OldLen:=Length(Col2Str(P.Col)); S:=Col2Str(Long(P.Col)+Diff);
    NewLen:=Length(S);
    If(NewLen>OldLen)Then Good:=LSInsert(GetFormula^,Spc(NewLen-OldLen),Place)else
    If(NewLen<OldLen)Then LSDelete(GetFormula^,Place,OldLen-NewLen);
    If(Good)Then Begin
     MoveLeft(S[1],Data^[Place],Length(S));
     Inc(Place,FormLen+NewLen-OldLen);
    End;
   End
    else
   Inc(Place);
  End;
 End;
End;

Procedure FixFormulaRow;Var ColLen,FormLen,Place,OldLen,NewLen:Wd;P:CellPos;S:String[10];Good:Bool;Begin
 With FormulaCellPtr(CP)^,GetFormula^do Begin
  Place:=1;Good:=Ya;
  While(Good)and(Place<=Len)do Begin
   If FormulaStart(GetFormula,Place,MaxCols,MaxRows,P,FormLen)Then Begin
    OldLen:=Length(Str(P.Row));S:=Str(P.Row+Diff);
    NewLen:=Length(S);ColLen:=Length(Col2Str(P.Col));
    If(NewLen>OldLen)Then Good:=LSInsert(GetFormula^,Spc(NewLen-OldLen),Place+ColLen)else
    If(NewLen<OldLen)Then LSDelete(GetFormula^,Place+ColLen,OldLen-NewLen);
    If(Good)Then Begin
     MoveLeft(S[1],Data^[Place+ColLen],Length(S));
     Inc(Place,FormLen+NewLen-OldLen);
    End;
   End
    else
   Inc(Place);
  End;
 End;
End;

Function FormulaStart;Var Col,Row:Wd;CS,RS:String[10];Begin
 With Inp^do Begin
  FormulaStart:=No;FormLen:=0;FillClr(P,SizeOf(P));CS:='';
  While(Start<=Len)and(Data^[Start]in Letters)do Begin;IncStr(CS,Data^[Start]);Inc(Start)End;
  Col:=Str2Col(CS,MaxCols);
  If Col=0Then Exit;
  RS:='';
  While(Start<=Len)and(Data^[Start]in Numbers)do Begin;IncStr(RS,Data^[Start]);Inc(Start)End;
  Row:=Str2Row(RS,MaxRows);
  If Row=0Then Exit;
  P.Col:=Col;P.Row:=Row;FormLen:=Length(CS)+Length(RS);FormulaStart:=Ya;
 End;
End;

Function GetCellPos;Var FormLen:Wd;S:String;CS,RS:String[10];Start:Byte;Col,Row:Wd;Begin
 GetCellPos:=No;S:='';
 If(WinInp(40,'Reposition',Prompt,CurrKrs.Dialog.Wins,No,S)=kbEnter)Then Begin
  Start:=1;CS:='';
  While(Start<=Length(S))and(S[Start]in Letters)do Begin;IncStr(CS,S[Start]);Inc(Start)End;
  Col:=Str2Col(CS,MaxCols);
  If Col=0Then Begin;ErrMsgOk(ErrCellError);Exit;End;
  RS:='';
  While(Start<=Length(S))and(S[Start]in Numbers)do Begin;IncStr(RS,S[Start]);Inc(Start)End;
  Row:=Str2Row(RS,MaxRows);
  If Row=0Then;Begin;ErrMsgOk(ErrCellError);Exit;End;
  P.Col:=Col;P.Row:=Row;GetCellPos:=Ya;
 End;
End;

Function GetColumn;Var I:InputField;S:String;C:Wd;Begin
 With I do Begin
  If Not(IFInit(I,Length(Prompt)+3,0,-1,ColSpace,AllUpper))Then Begin
   GetColumn:=0;
   Exit;
  End;
  PutTxtXY(0,MaxYTxts,Prompt+': ',LotusColors.Prompt);
  Repeat
   IFEdit(I,0);
   S:=LS2String(InputData^);
   If(Not(IFGetQuit(I)))and(S<>'')Then Begin
    C:=Str2Col(S,MaxCols);
    If C=0Then ErrMsgOk('Colonne invalide. Le nombre doit ˆtre compris entre 1 et '+Str(MaxCols));
   End
    else
   C:=0;
  Until(C<>0)or(S='');
  {InputArea.Clear;}
  IFDone(I);
 End;
 BarSpcHor(0,MaxYTxts-1,MaxXTxts,LotusColors.Blank);
 GetColumn:=C;
End;

Function GetColWidth(Var WHash:WidthHashTable;C:Wd):Byte;Var W:Wd;Begin
 W:=WHash.Search(C);
 If W=0Then GetColWidth:=WHash.GetDefaultColWidth Else GetColWidth:=W;
End;

Function GetLegalChar(Const Prompt:String;Legal:CharSet;Var EscPressed:Bool):Char;Var Ch:Char;Begin
{ PutTextXY(W.X1+1,W.Y2,Prompt+': ',LotusColors.Prompt);
 Ch:=GetKeyChar(Legal);
 BarSpaceHori(W.X1+1,W.Y2,W.X2-1,LotusColors.Blank);}
 GetLegalChar:={Ch}#0;
End;

Function GetNumber;Var I:InputField;S:String;Error:Int;L:Long;Begin
 With I do Begin
  If Not(IFInit(I,Length(Prompt)+3,0,-1,Omega(Length(Str(Low)),Length(Str(High))),NotUpper))Then Begin
   Result:=No;GetNumber:=0;Exit;
  End;
  PutTxtXY(W.X1+1,W.Y2,Prompt+': ',LotusColors.Prompt);
  Repeat
   IFEdit(I,0);
   S:=LS2String(InputData^);
   If(Not(IFGetQuit(I)))and(S<>'')Then Begin
    Val(S,L,Error);
    Result:=(Error=0)and(L>=Low)and(L<=High);
    If Not(Result)Then
     ErrMsgOk('Valeur incorrecte. Le nombre doit ˆtre compris entre '+Str(Low)+' et '+Str(High));
   End
    else
   Begin;Result:=No;L:=0;End;
  Until(Result)or(S='');
  BarSpcHor(W.X1+1,W.Y2,W.X2-1,LotusColors.Blank);
  IFDone(I);
 End;
 GetNumber:=L;
End;

Function GetRow;Var R:Wd;Good:Bool;Begin
 R:=GetNumber(Prompt,1,MaxRows,Good);
 If(Good)Then GetRow:=R else GetRow:=0;
End;

Function HashItemPtr2CellPtr;Var CP:CellPtr;Begin
 If(H=Nil)Then HashItemPtr2CellPtr:=Nil
  else
 Begin
  MoveLeft(H^.Data,CP,SizeOf(CP));
  HashItemPtr2CellPtr:=CP;
 End;
End;

Function ReadString;Var I:InputField;Begin
 With I do Begin
  If Not IFInit(I,Length(Prompt)+3,0,-1,Len,NotUpper)Then Begin
   EscPressed:=Ya;ReadString:='';
  End;
  PutTxtXY(W.X1+1,W.Y2,Prompt+': ',LotusColors.Prompt);
  IFEdit(I,0);
  ReadString:=LS2String(InputData^);
  EscPressed:=IFGetQuit(I);
  BarSpcHor(W.X1+1,W.Y2,W.X2-1,LotusColors.Blank);
  IFDone(I);
 End;
End;

Procedure SAInit;Begin
 Q.UpperLeft.Col:=InitX1;Q.UpperLeft.Row:=InitY1;
 Q.LowerRight.Col:=InitX2;Q.LowerRight.Row:=InitY2;Q.Attrib:=InitAttrib;
End;

Procedure SAClear;Begin
 ClrWn(Q.UpperLeft.Col-1,Q.UpperLeft.Row-1,Q.LowerRight.Col-1,Q.LowerRight.Row-1,Q.Attrib);
End;

Function GetKeyUpCase:Wd;Var Ch:Wd;Begin
 Ch:=ReadKey;
 If Char(Ch)in[' ','~']Then GetKeyUpCase:=Byte(UpCase(Chr(Ch)))Else GetKeyUpCase:=Ch;
End;

Function GetKeyChar(Legal:CharSet):Char;Var Ch:Wd;Begin
 Repeat Ch:=GetKeyUpCase Until(Ch=caESC)or(Chr(Ch)in Legal);
 GetKeyChar:=Chr(Ch)
End;

Function Col2Str(Col:Wd):String;Var S:String[4];W:Wd;Begin
 If Col>18278Then S:=Chr(Byte('A')+((Col-18279)div 17576))Else S:='';
 If Col>702Then IncStr(S,Chr(Byte('A')+(((Col-703)mod 17576)div 676)));
 If Col>26Then IncStr(S,Chr(Byte('A')+(((Col-27)mod 676)div 26)));
 IncStr(S,Chr(Byte('A')+(Pred(Col)mod 26)));
 Col2Str:=S;
End;

Function Str2Col(S:String;MaxCols:Wd):Wd;Var L:Byte;C:Long;Begin
 Str2Col:=0;L:=Length(S);
 If L=0Then Exit;
 S:=StrUp(S);
 For C:=1to L do If Not(S[C]in Letters)Then Exit;
 C:=Byte(S[L])-Byte('@');
 If L>1Then Inc(C,(Byte(S[Pred(L)])-Byte('@'))*26);
 If L>2Then Inc(C,(Byte(S[L-2])-Byte('@'))*676);
 If L>3Then Inc(C,Long(Byte(S[L-3])-Byte('@'))*17576);
 If(C>MaxCols)Then Exit;
 Str2Col:=C;
End;

Function Str2Row(Const S:String;MaxRows:Wd):Wd;Var R:Long;Err:Int;Begin
 Str2Row:=0;
 If S=''Then Exit;
 Val(S,R,Err);
 If(Err=0)and(R<=MaxRows)Then Str2Row:=R;
End;

END.