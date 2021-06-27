Program Chess;

{$G+,R-,Q-,S-,W-}

Uses Chantal,Systex,Systems,Video,Mouse,Dials,
     Memory,App,Views,Dialogs,Menus,Objects,Drivers,ColorSel,HistList,
     Validate,StdDlg,Dos,Strings,MsgBox;

Const
 Back=-104;
 MaxPly=23;
 MaxGames=5;

 LoseValue=$7D00;
 MateValue=$7C80;
 DepthFactor=$80;

  { Move event }
 evMove=$0400;

  { Game Menu }
 cmRunDemo=100;
 cmStop=101;

  { Edit menu }
 cmRedo=110;
 cmComputerMove=111;
 cmEnterMove=112;
 cmShowHint=113;

  { Options Menu }
 cmSettings=120;

  { Game control }
 cmSubmitMove=1000;
 cmMovePiece=1001;
 cmUndoMove=1002;
 cmClearBoard=1003;
 cmFindPiece=1004;
 cmGameOver=1005;
 cmRegisterSave=1006;
 cmTimeOptChg=1007;

  { Pawn Promotion }
 cmQueen=2000;
 cmRook=2001;
 cmBishop=2002;
 cmKnight=2003;

 gmOnePlay=$0000;
 gmTwoPlay=$0001;
 gmDemo=$0002;
 gmGameMagic=$4246;

 hoAttacks=$0001;
 hoJeopardies=$0002;
 hoBestLine=$0004;
 hoRtClickHints=$0008;
 hoThinkAhead=$0010;

 otChessPiece=5001;
 otTimeLabel=5002;
 otTimeInput=5003;
 otSettingsDlg=5004;
 otPromoteDialog=5005;
 otGlyphButton=5006;
 otTimerView=5007;

 plOnePlayer=$0000;
 plTwoPlayer=$0001;

 tmGameLimit=$0000;
 tmTurnLimit=$0001;
 tmMatchUser=$0002;
 tmInfinite=$0003;

 tmFindMove=1;
 tmThinkAhead=2;
 tmResume=3;
 tmComplete=4;
 tmEnterMove=5;
 tmTimeExpired=6;
 tmAbort=7;
 tmTerminate=$FFFF;

 DoIt=No;
 UndoIt=Ya;

Type
 CastDirType=(Long,Short);
 ColorType=(White,Black);
 LevelType=(Normal,PlySearch,MateSearch);
 PieceType=(Empty,King,Queen,Rook,Bishop,Knight,Pawn);
 StateTypes=(GameOver,InLibrary,Analysis,OppAnalysis,MovePending);
 TChessError=(ceOK,ceInvalidHandle,ceIllegalState,ceOutOfMemory,
	      ceTooManyGames,ceInvalidMove,ceIllegalMove,ceInvalidSyntax,
	      ceAmbiguousMove,ceNoMovesLeft);
 TChessStatus=(csNormal,csCheck,csCheckMate,csStaleMate,csResigns,
	       csMateFound,csFiftyMoveRule,csRepetitionRule);
 TColor=(cWhite,cBlack);
 TKind=(kNormal,kEnPassant,kCastling,kPawnPromote);
 TSearchStatus=(ssComplete,ssMoveSearch,ssThinkAhead,ssGameOver);
 TTimerStatus=(tsStopped,tsRunning);
 TPiece=(pEmpty,pKing,pQueen,pRook,pBishop,pKnight,pPawn);
 TSquare=Record Piece:TPiece; Color:TColor; End;
 TLocation=Record X,Y:0..8;End;
 PChange=^TChange;
 TChange=Record Piece:TPiece; Source,Dest:TLocation; End;
 PMove=^TMove;

 TMove=Record
  Change:TChange;
  Capture:Bool;
  Contents:TPiece;
  Case Kind:TKind of
   kEnPassant:(EPCapture:TLocation);
   kCastling:(RookSource,RookDest:TLocation);
 End;

 TBoard=Array[1..8,1..8]of TSquare;

 PChessSurface=^TChessSurface;
 TChessSurface=Object(TView)
  ValidMoves:Array[1..8,1..8]of Bool;
  Squares:Array[1..8,1..8]of PView;
  Procedure Clear;
  Procedure Draw;Virtual;
 End;

 PMoveList=^TMoveList;
 TMoveList=Object(TCollection)
  UndoPos:Int;
  Constructor Init(ALimit,ADelta:Int);
  Constructor Load(Var S:TStream);
  Procedure AddMove(Move:TMove);
  Procedure FreeItem(Item:Pointer);Virtual;
  Function GetItem(Var S:TStream):Pointer;Virtual;
  Function GetNumMoves:Int;
  Procedure Purge;
  Procedure PutItem(Var S:TStream;Item:Pointer);Virtual;
  Procedure Redo(Var Move:TMove);
  Function RedoAvail:Bool;
  Procedure Store(Var S:TStream);
  Procedure Undo(Var Move:TMove);
  Function UndoAvail:Bool;
 End;

 PChessTimer=^TChessTimer;
 TChessTimer=Object(TObject)
  Status:TTimerStatus;
  TotalTime:Longint;
  constructor Init;
  constructor Load(Var S:TStream);
  function AddTo(ATimer:PChessTimer):Longint;
  procedure Clear;
  function GetCurrentTicks:Longint;
  function GetMarkTime:Longint;
  procedure Mark;
  procedure Start;
  procedure Stop;
  procedure Store(Var S:TStream);
  PRIVATE
  MarkTime,TimeAtStart:Longint;
  Function TicksSinceStart:Longint;
 End;

 PChessBoard=^TChessBoard;
 TChessBoard=Object(TGroup)
  Surface:PChessSurface;
  Game:Word;
  Computer,Player:TColor;
  GameMode:Word;
  GameOver:Bool;
  MoveHistory:PMoveList;
  GameName:String;
  ThinkState:TSearchStatus;
  ChessTimers:Array[TColor]of PChessTimer;
  ValidMoves,OpponentMoves:Array[0..28*16+1]of TMove;
  QSquare:TLocation;
  Constructor Init(Var Bounds:TRect);
  Destructor Done; Virtual;
  procedure AddToHistory(Const AMove:TMove);
  procedure AcceptComputerMove;
  function CanMovePiece(Color:TColor):Bool;
  function CheckActiveGame:Word;
  procedure ClearBoard;
  procedure DoThink;
  procedure DrawSurface;
  procedure DrawValidMoves(Empty: Bool);
  function GetComputerTime: Longint;
  function GetPalette: PPalette; virtual;
  procedure HandleEvent(var Event: TEvent); virtual;
  procedure InitGameBoard;
  procedure InsertPiece(Piece: PView; Location: TLocation);
  procedure MovePiece(Piece: PView; FromLoc, ToLoc: TLocation);
  procedure Process;
  procedure ReadGame;
  procedure Redo;
  procedure RemovePiece(Piece: PView; Location: TLocation);
  procedure ResetCurrentPlayer;
  procedure ResetValidMoves;
  function SaveGame:Word;
  function SaveGameAs:Word;
  procedure SetGameBoard(Const ABoard:TBoard);
  procedure SetupNewGameBoard;
  procedure ShowEndGame(Reason:Int);
  procedure StartComputerMove;
  procedure Undo;
  function ValidateMove(Var C:TChange): TChessError;
  function Valid(Command:Word):Bool;Virtual;
  procedure Update;
  procedure UpdateCommands;
 End;

Const
  ChessBoard:PChessBoard=Nil;

  RMoveList:TStreamRec=(ObjType:5000;VmtLink:Ofs(TypeOf(TMoveList)^);
			Load:@TMoveList.Load;Store:@TMoveList.Store);

Type
 TTaskInfo=Record SPtr,SSeg,Size:Word; End;

 TStopWatch=Object(TObject)
    StartTime:Longint;
    ElapsedTime:Longint;    { base unit is bios tics }
    Constructor Init;
    Procedure Start;
    Procedure Resume;
    Procedure Stop;
    Procedure Reset;
    Function  GetString:String;
    Function  GetElapsedTime:Longint;
    Procedure Update;
    Function  Running:Bool;
  end;

  PTaskTimer=^TTaskTimer;
  TTaskTimer=Object(TStopWatch)
   TimeLimit:Longint;
   Procedure SetLimit(A:Longint);
   Function  TimeExpired:Bool;
   Function  TimeRemaining:Longint;
  End;

Type
  { Squarenumbers. a1=0, b1=1,..., a2=$10,..., h8=$77 }
  SquareType=$00..$77;
  EdgeSquareType=-$21..$98;
  IndexType=0..15;

  BoardType=Record Piece:PieceType;Color:ColorType;Index:0..16;End;
  MoveType=Record New1,Old:SquareType;Spe:Bool;MovPiece,Content:PieceType;End;

Const
 ZeroMove:MoveType=(New1:8;Old:8;Spe:No;MovPiece:Empty;Content:Empty);
 Pieces:Array[0..7]of PieceType=(Rook,Knight,Bishop,Queen,King,Bishop,Knight,Rook);
 PieceLetter:Array[Empty..Pawn]of Char=' KQRBNP';

Var
 PieceLetterS:Array[TPiece]of Char Absolute PieceLetter;

Type
 DepthType=Back..MaxPly;
 MoveTabType=Array[depthtype]of movetype;
 LineType=Array[0..MaxPly]of MoveType;
 StateSet=Set of StateTypes;
 PGameData=^TGameData;
 TGameData=Record
  Magic:Word;
  Board:Array[SquareType]of BoardType;
  PieceTab:Array[ColorType,IndexType]of record
   ISquare:SquareType;
   IPiece:PieceType;
  End;
  OfficerNo,PawnNo:Array[ColorType]of -1..15;
  Player,Opponent:ColorType;
  Depth:DepthType;
  MovTab:MoveTabType;
  PVTable:Array[ColorType,King..Pawn,SquareType]of -64..191;
  NextMove:MoveType;
  Buffer:Array[1..80]of MoveType;
  BufCount,BufPnt:0..80;
  ProgramColor:ColorType;
  MaxDepth,LegalMoves,MoveNo:Int;
  MainLine:LineType;
  MainEvalu:Int;
  Nodes:LongInt;
  Clock:TTaskTimer;
  TaskTimer:TTaskTimer;
  PlayerMove:MoveType;
  ChessTime:Array[ColorType]of TStopWatch;
  RunColor:ColorType;
  Running:Bool;
  KeyMove:MoveType;
  HintLine:LineType;
  HintEvalu:Int;
  OpCount:-1..61;
  LibNo,UseLib:Int;
  Level:LevelType;
  MaxLevel:Byte;
  AverageTime:Longint;
  State:StateSet;
  Engaged:Bool;
  AppStack,GameStack:TTaskInfo;
 End;

Var
 GameList:Array[1..MaxGames]of TGameData;
 CCHandle:Word;
 CC:TGameData;

Type
 CastType=Set of CastDirType;
 FiftyType=0..150;
 RepeatType=1..4;
 DirType=0..7;

Const
 DirTab:Array[DirType]of Int=(1,-1,$10,-$10,$11,-$11,$F,-$F);
 KnightDir:Array[DirType]of Int=($E,-$E,$12,-$12,$1F,-$1F,$21,-$21);
 PawnDir:Array[ColorType] of Int=($10,-$10);
 CastMove:Array[ColorType,CastDirType]of Record CastNew,CastOld:SquareType;End=
  (((CastNew:  2;CastOld:  4),(CastNew:  6;CastOld:  4)),
   ((CastNew:$72;CastOld:$74),(CastNew:$76;CastOld:$74)));

Type
 TSpawnProc=Procedure;
 TSettings=Record TimeMode:Word; GameTime,TurnTime:Longint; Hints,Players:Word End;

Const
  { Color palettes }
 CChessAppColor=CAppColor+
#$1E#$20#$40#$07#$70#$0F#$7F#$78#$18#$20#$70#$07#$7F#$0F#$1E#$7F#$0F#$3E#$20#$40;
 CChessAppBlackWhite=CAppBlackWhite+
#$07#$07#$07#$07#$70#$0F#$7F#$07#$07#$07#$70#$07#$7F#$0F#$70#$7F#$0F#$70#$07#$07;
 CChessAppMonochrome=CAppMonochrome+
#$07#$07#$07#$07#$70#$0F#$7F#$07#$07#$07#$70#$07#$7F#$0F#$70#$7F#$0F#$70#$07#$07;

 CChessBoard=#128#129#130#131#132#133#134#146#147;
 CSettingsDlg=CGrayDialog+#135#136;
 CStatusDialog=CCyanDialog+#142#143#144#145;
 CPromoteDialog=CGrayDialog+#137#138#139#140#141;
 CTimeLabel=#33#33#33#33;
 CTimeInput=#34#34#34#34;
 CGlyphButton=#33#34#35#36#37#15;

 CBestLine=#33;
 CWTimerView=#34;
 CBTimerView=#35;
 CGTimerView=#36;

 Settings:TSettings=(TimeMode:tmTurnLimit;GameTime:10;TurnTime:10;
  Hints:hoAttacks+hoJeopardies+hoBestLine+hoRtClickHints+hoThinkAhead;
  Players:plOnePlayer);

Type

{ TGlyphButton }

  { Palette layout }
  { 1 = Button background }
  { 2 = Normal white piece }
  { 3 = Normal black piece }
  { 4 = Selected white piece }
  { 5 = Selected black piece }
  { 6 = Shadow }

  PGlyphButton=^TGlyphButton;
  TGlyphButton=Object(TButton)
   Piece:TPiece;
   Color:TColor;
   Constructor Init(Var Bounds:TRect;APiece:TPiece;AColor:TColor;
    ATitle:TTitleStr;ACommand:Word;AFlags:Byte);
   Constructor Load(Var S: TStream);
   Procedure Draw; Virtual;
   Procedure DrawState(Down:Bool);
   Function GetPalette:PPalette; Virtual;
   Procedure HandleEvent(Var Event:TEvent); Virtual;
   Procedure Store(Var S:TStream);
  End;

{ TPromoteDialog }

  { Palette layout }
  { 1..32 = CGrayDialog }
  { 33 = Button background }
  { 34 = Normal white piece }
  { 35 = Normal black piece }
  { 36 = Selected white piece }
  { 37 = Selected black piece }
  { 38 = Shadow }

 PPromoteDialog=^TPromoteDialog;
 TPromoteDialog=Object(TDialog)
  Constructor Init(AColor:TColor);
  Function GetPalette:PPalette; Virtual;
  Procedure HandleEvent(Var Event:TEvent); Virtual;
 End;

{ TChessPiece}

 PChessPiece=^TChessPiece;
 TChessPiece=Object(TView)
  PieceType:TSquare;
  Location:TLocation;
  InJeopardy:Bool;
  Constructor Init(Var Bounds:TRect;APieceType:TSquare;ALocation:TLocation);
  Constructor Load(Var S:TStream);
  Procedure CapturePiece;
  Procedure CheckJeopardy(Var MoveArray:Array of TMove);
  Procedure Draw; Virtual;
  Function GetPromotionPiece:TPiece;
  Procedure HandleEvent(Var Event:TEvent); Virtual;
  Procedure MoveToSquare(ALocation: TLocation);
  Function PerformMove(C:TChange):Bool;
  Procedure RawDraw(Var B:TDrawBuffer;BufPos,Line:Int;Var XOfs,XLen:Int);
  Procedure SnapToSquare;
  Procedure Store(Var S:TStream);
 End;

Const
 RChessPiece:TStreamRec=(ObjType:otChessPiece;VmtLink:Ofs(TypeOf(TChessPiece)^);
			 Load:@TChessPiece.Load;Store:@TChessPiece.Store);
 RGlyphButton:TStreamRec=(ObjType:otGlyphButton;VmtLink:Ofs(TypeOf(TGlyphButton)^);
			  Load:@TGlyphButton.Load;Store:@TGlyphButton.Store);
 RPromoteDialog:TStreamRec=(ObjType:otPromoteDialog;VmtLink:Ofs(TypeOf(TPromoteDialog)^);
			    Load:@TPromoteDialog.Load;Store:@TPromoteDialog.Store);

Type
 TTimerColor=(tcWhite,tcBlack,tcTotal);

{ TTimerView }

 PTimerView=^TTimerView;
 TTimerView=Object(TParamText)
  Color:TTimerColor;
  Constructor Init(Var Bounds:TRect;AText:String;AParamCount:Int;AColor:TTimerColor);
  Constructor Load(Var S:TStream);
  Function GetPalette:PPalette; Virtual;
  Procedure Store(Var S:TStream);
 End;

{ TTurnText }

 PTurnText=^TTurnText;
 TTurnText=Object(TTimerView)
  Function DataSize:Word; Virtual;
  Procedure SetData(Var Rec); Virtual;
 End;

{ TBestLine }

 PBestLine=^TBestLine;
 TBestLine=Object(TParamText)
  Function GetPalette:PPalette; Virtual;
 End;

{ TMoveListBox }

 PMoveListBox=^TMoveListBox;
 TMoveListBox=Object(TListViewer)
  List:PMoveList;
  Constructor Init(Var Bounds:TRect;AScrollBar:PScrollBar);
  Function GetText(Item:Int;AMaxLen:Int):String; virtual;
  Procedure Update(AMoveList:PMoveList);
 End;

{ TStatusDialog }

 PStatusDialog=^TStatusDialog;
 TStatusDialog=Object(TDialog)
  LastNodes:Longint;
  LastSec:Word;
  MoveListBox:PMoveListBox;
  Constructor Init(Var Bounds:TRect);
  Function GetPalette:PPalette; Virtual;
  Procedure Update(Game:Word;ATimers:Array of PChessTimer;Nodes:Longint;MoveNumber:Int;GMode:Word);
  Procedure UpdateList(AMoveList:PMoveList);
 End;

 PGameStatus=^TGameStatus;
 TGameStatus=Record
  MoveColor:TColor;
  MoveNo:Longint;
  ToMove,Mode,GameTime,WhtTime,BlkTime:PString;
  Value,Nodes,NodesSec:Longint;
  SearchSt,MainLine:PString;
 End;

Const
  StatusDialog:PStatusDialog=Nil;

  CurPlayer:String[5]='';
  BestLine:String='';
  GTime:String[11]='';
  TimeStrs:Array[TColor]of String[11]=('','');
  GameMode:String[11]='';
  SearchStatus:String[14]='';
  GameStatus:TGameStatus=(
    MoveColor:cWhite;
    MoveNo:0;
    ToMove:@CurPlayer;
    Mode:@GameMode;
    GameTime:@GTime;
    WhtTime:@TimeStrs[cWhite];
    BlkTime:@TimeStrs[cBlack];
    Value:0;
    Nodes:0;
    NodesSec:0;
    SearchSt:@SearchStatus;
    MainLine:@BestLine);

Type
 PChessStatusLine=^TChessStatusLine;
 TChessStatusLine=Object(TStatusLine)
  ChessStatus:TChessStatus;
  MateInMoves:Longint;
  Procedure Draw; Virtual;
  Function Hint(Ctx:Word):String; virtual;
  Procedure SetStatus(AChessStatus:TChessStatus;Count:Int);
 End;

Const
  ChessSignature:Array[0..33]of Char='Chess saved game'#26#0;

Type

 PValidateMove=^TValidateMove;
 TValidateMove=Object(TValidator)
  Function IsValid(Const S:String):Bool;Virtual;
  Procedure Error;Virtual;
  Function Transfer(Var S:String;Buffer:Pointer;Flag:TVTransfer):Word;Virtual;
 End;

 PChessApp=^TChessApp;
 TChessApp=Object(TApplication)
  ConfigFile:String;
  Constructor Init;
  Destructor Done; Virtual;
  Function GetPalette:PPalette; Virtual;
  Procedure HandleEvent(Var Event:TEvent); Virtual;
  Procedure Idle; Virtual;
  Procedure InitChessBoard;
  Procedure InitMenuBar; Virtual;
  Procedure InitStatusLine; Virtual;
  Procedure InitDesktop; Virtual;
  Procedure InitStatusDialog;
  Procedure InitScreenMode;
  Procedure LoadConfig;
  Procedure SaveConfig;
 End;

 PTimeLabel=^TTimeLabel;
 TTimeLabel=Object(TLabel)
  Function GetPalette:PPalette; Virtual;
 End;

 PTimeInput=^TTimeInput;
 TTimeInput=Object(TInputLine)
  function GetPalette:PPalette; Virtual;
  procedure SetOpt(AOptions:Word;Enable:Bool);
 End;

 PTimeSettings=^TTimeSettings;
 TTimeSettings=Object(TRadioButtons)
  Procedure MovedTo(Item:Int); Virtual;
  Procedure Press(Item:Int); Virtual;
  Procedure SetData(Var Rec); Virtual;
 End;

 PSettingsDlg=^TSettingsDlg;
 TSettingsDlg=Object(TDialog)
  TurnLabel,GameLabel:PTimeLabel;
  TurnInput,GameInput:PTimeInput;
  Minutes,Seconds:PTimeLabel;
  Constructor Load(Var S:TStream);
  Procedure EnableSet(Game,Turn:Bool);
  Function GetPalette:PPalette;Virtual;
  Procedure HandleEvent(Var Event:TEvent);Virtual;
  Procedure ShowSet(Game,Turn:Bool);
  Procedure Store(Var S:TStream);
 End;

Const
  RTimeLabel:TStreamRec=(ObjType:otTimeLabel;VmtLink:Ofs(TypeOf(TTimeLabel)^);
			 Load:@TTimeLabel.Load;Store:@TTimeLabel.Store);
  RTimeInput:TStreamRec=(ObjType:otTimeInput;VmtLink:Ofs(TypeOf(TTimeInput)^);
			 Load:@TTimeInput.Load;Store:@TTimeInput.Store);
 RSettingsDlg:TStreamRec=(ObjType:otSettingsDlg;VmtLink:Ofs(TypeOf(TSettingsDlg)^);
			  Load:@TSettingsDlg.Load;Store:@TSettingsDlg.Store);
 RChessTimer:TStreamRec=(ObjType:5005;VmtLink:Ofs(TypeOf(TChessTimer)^);
			 Load:@TChessTimer.Load;Store:@TChessTimer.Store);

Function  AbortSearch(CH:Word):TChessError; Forward;
Procedure AdjustMoves;Forward;
Procedure AllocateTask(Size:Word); Forward;
Function  Attacks(AColor:ColorType;Square:SquareType):Bool;Forward;
Procedure CalcAttackTab; Forward;
Procedure CalcCastling(InColor:ColorType;Var Cast:CastType); Forward;
Procedure CalcLibNo; Forward;
Procedure CalcPieceTab; Forward;
Function  CalcSquare(a,b:Char):EdgeSquareType;Forward;
Procedure ChangeType(NewType:PieceType;InSquare:SquareType); Forward;
Procedure ClearHint;Forward;
Function  ComputerMove(CH:Word;TimeLimit:LongInt):TChessError; Forward;
Procedure ConvertTicks(TotalTicks:Longint;var Hours,Minutes,Seconds,Ticks:Word); Forward;
Function  CreateSettingsDlg:PDialog; Forward;
Procedure DeletePiece(InSquare:SquareType); Forward;
Function  DisposeGame(CH:Word):TChessError; Forward;
Procedure DisposeMove(Move:PMove); Forward;
Procedure DisposeTask; Forward;
Procedure DoGameTask; Forward;
Procedure EnterKeyMove; Forward;
Procedure EnterMove(Move:MoveType);Forward;
Function  EqMove(Var A,B:MoveType):Bool;Forward;
Function  FiftyMoveCnt:FiftyType; Forward;
Function  FindMove(MaxLevel:Int):Int; Forward;
Procedure FindOpeningMove; Forward;
Function  ForceMove(CH:Word):TChessError; Forward;
Function  FuncThinkAhead(CH:Word):TChessError; Forward;
Procedure GenCastSquare(New1:SquareType;Var CastSquare,CornerSquare:SquareType); Forward;
Function  GetBoard(CH:Word;Var ABoard:TBoard):TChessError; Forward;
Function  GetChessStatus(CH:Word;Var Count:Int):TChessStatus; Forward;
Function  GetCurrentMove(CH:Word;Var Move:TMove):TChessError; Forward;
Function  GetLastMove(CH:Word;Var Move:TMove):TChessError; Forward;
Function  GetHintMove(CH:Word;Var Move:TMove):TChessError; Forward;
Function  GetMainLine(CH:Word;Var Value:Int;Var Line:Array of TMove):TChessError; Forward;
Function  GetNodes(CH:Word):LongInt; Forward;
Function  GetPlayer(CH:Word):TColor; Forward;
Function  GetSearchStatus(CH:Word):TSearchStatus; Forward;
Function  GetValidMoves(CH:Word;Change:TChange;Var Moves:Array of TMove):TChessError; Forward;
Function  IllegalMove(Move:MoveType):Bool; Forward;
Procedure InitChessTime; Forward;
Procedure InitMovGen; Forward;
Procedure InitPawnStrTables; Forward;
Procedure InsertPiece(InPiece:PieceType;InColor:ColorType;InSquare:SquareType); Forward;
Function  KillMovGen(Move:MoveType):Bool; Forward;
Procedure InitBoard; Forward;
Function  MakeChange(CH:Word;Color:TColor;Const Change:TChange):TChessError; Forward;
Procedure MakeMove(Move:MoveType); Forward;
Function  Max(A,B:Int):Int; Forward;
Function  Message(Msg:Word):Word; Forward;
Function  Min(A,B:Int):Int; Forward;
Function  MoveCheck(Const Move:MoveType):TChessError;Forward;
Procedure MovePiece(New1,Old:SquareType); Forward;
Function  MoveToStr(Const Move:TMove;Var Str:Array of Char):TChessError; Forward;
Procedure MovGen; Forward;
Function  NewGame(Var GameHandle:Word):TChessError; Forward;
Function  NewMove(Move:TMove):PMove; Forward;
Function  Opponent(Color:TColor):TColor;Forward;
Function  ParseMove(Move:PChar;Var Change:TChange):TChessError; Forward;
Procedure Perform(Move:MoveType;ResetMove:Bool); Forward;
Function  PieceAttacks(APiece:PieceType;AColor:ColorType;ASquare,Square:SquareType):Bool; Forward;
Procedure PointInSquare(P:TPoint;Var ALocation:TLocation); Forward;
Function  RepeatMove(Move:MoveType):Bool; Forward;
Function  Repetition(Immediate:Bool):RepeatType; Forward;
Procedure ResetMoves;Forward;
Function  RetractMove(CH:Word;Const Move:TMove):TChessError; Forward;
Function  SetBoard(CH:Word;Const ABoard:TBoard):TChessError; Forward;
Function  SetPlayer(CH:Word;APlayer:TColor):TChessError; Forward;
Procedure Spawn(Proc:TSpawnProc); Forward;
Procedure SquareToLocal(ALocation:TLocation;Var P: TPoint;Size:Int); Forward;
Procedure StartChessTime(Color:ColorType); Forward;
Procedure StopChessTime; Forward;
Procedure StoreMoves;Forward;
Function  SubmitMove(CH:Word;Const Change:TChange):TChessError; Forward;
Procedure TakeBackMove(Move:MoveType); Forward;
Function  Think(CH:Word;TimeLimit:LongInt;Var Status:TSearchStatus):TChessError; Forward;
Function  VerifyMove(CH:Word;Const Change:TChange):TChessError; Forward;
Procedure Wait(Ticks:Longint); Forward;

Function Opponent;Begin
 If(Color=cWhite)Then Opponent:=cBlack else Opponent:=cWhite;
End;

Function TValidateMove.IsValid;Var Change:TChange;MoveStr:Array[0..20]of Char;Begin
 StrPCopy(MoveStr,S);
 IsValid:=ParseMove(MoveStr,Change)=ceOK;
End;

Procedure TValidateMove.Error;Begin
 MessageBox(^C'Syntaxe du dÇplacement invalide',nil,mfError+mfOKButton+mfInsertInApp);
End;

Function TValidateMove.Transfer;Var Change:TChange; MoveStr:Array[0..20]of Char;Begin
 Case(Flag)of
  vtGetData:Begin
   FillClr(Change,SizeOf(Change));
   StrPCopy(MoveStr,S);
   If(ParseMove(MoveStr,Change)=ceOK)Then PChange(Buffer)^:=Change
				     else FillClr(Buffer^,SizeOf(TChange));
  End;
 End;
 Transfer:=SizeOf(TChange);
End;

Procedure TChessSurface.Clear;Begin
 FillClr(Squares,SizeOf(Squares));
End;

Procedure TChessSurface.Draw;Var Border,White,Black,Color:Word;B:TDrawBuffer;I,J,K,Line:Int;DrawChr:Char;XOfs,XLen:Int;

 Procedure TellPieceToDraw(P:PView); Begin
  If(P<>Nil)and(P^.State and sfDragging=0)Then PChessPiece(P)^.RawDraw(B,2+6*K,I,XOfs,XLen);
 End;

Begin
 Border:=GetColor($0101);
 White:=GetColor($0802);
 Black:=GetColor($0903);
 Line:=0;
 For J:=7downto 0do Begin
  If J=7Then Begin
   MoveChar(B,' ',Border,2);
   For I:=0to 7do Begin
    MoveChar(B[2+6*I],' ',Border,3);
    MoveChar(B[5+6*I],Chr($41+I),Border,1);
    MoveChar(B[6+6*I],' ',Border,2);
   End;
   MoveChar(B[Size.X-2],' ',Border,2);
   WriteBuf(0,Line,Size.X,1,B);
   Inc(Line);
  End;
  For I:=0to 2do Begin
   MoveChar(B,' ',Border,2);
   If I=1Then MoveChar(B,Chr($31+J),Border,1);
   For K:=0to 7do Begin
    If(K+J)and 1=0Then Color:=Black else Color:=White;
    DrawChr:=' ';
    If ValidMoves[K+1,J+1]Then Color:=Swap(Color);
    MoveChar(B[2+6*K],DrawChr,Color,6);
    TellPieceToDraw(Squares[K+1,J+1])
   End;
   MoveChar(B[Size.X-2],' ',Border,2);
   WriteBuf(0,Line,Size.X,1,B);
   Inc(Line);
  End;
 End;
End;

Constructor TChessBoard.Init;Var Color:TColor;Begin
 Inherited Init(Bounds);
 EventMask:=EventMask or evMove;Options:=Options or ofPostprocess;
 Surface:=System.New(PChessSurface,Init(Bounds));
 Insert(Surface);
 Computer:=cBlack; Player:=cWhite; GameMode:=Settings.Players;
 For Color:=cWhite to cBlack do ChessTimers[Color]:=System.New(PChessTimer,Init);
 MoveHistory:=System.New(PMoveList,Init(20,10));
 If(NewGame(Game)<>ceOK)Then Game:=0 else SetupNewGameBoard;
 If(StatusDialog<>Nil)and(Game<>0)Then StatusDialog^.Update(Game,ChessTimers,0,0,GameMode);
end;

Destructor TChessBoard.Done;Begin
 If Game<>0Then DisposeGame(Game);
 Inherited Done;
End;

Procedure TChessBoard.AcceptComputerMove;Var Move:TMove;Begin
 If(GetLastMove(Game,Move)=ceOK)Then Begin
  AddToHistory(Move);
  Views.Message(@Self,evMove,cmMovePiece,@Move);
  Wait(5);
  Views.Message(@Self,evMove,cmUndoMove,@Move);
  Wait(5);
  Views.Message(@Self,evMove,cmMovePiece,@Move);
  If(GameMode and gmDemo<>0)and Not GameOver Then StartComputerMove
   else
  Begin
   If Settings.Hints and hoThinkAhead<>0Then FuncThinkAhead(Game);
   ChessTimers[GetPlayer(Game)]^.Mark;
   ChessTimers[GetPlayer(Game)]^.Start;
   ThinkState:=GetSearchStatus(Game);
  End;
  ResetValidMoves;
  Update;
 End;
End;

Procedure TChessBoard.AddToHistory;Var ChessPiece:PChessPiece;Begin
 If(MoveHistory<>Nil)Then MoveHistory^.AddMove(AMove);
 If(StatusDialog<>Nil)Then StatusDialog^.UpdateList(MoveHistory);
End;

Function TChessBoard.CanMovePiece;Begin
 CanMovePiece:=No;
 If(Game<>0)and(GetSearchStatus(Game)in[ssComplete,ssThinkAhead])and(Color=GetPlayer(Game))Then CanMovePiece:=Ya;
End;

Function TChessBoard.CheckActiveGame;Var Result,K:Word;Begin
 If(MoveHistory<>Nil)and(MoveHistory^.Count<>0)Then Begin
  K:=WarningMsgYesNo('Sauvegarde la partie?');
  Case(K)of
   kbYes:Result:=SaveGame;
   kbNo:Result:=cmNo;
   kbAbort:Result:=cmCancel;
  End;
{  Result:=MessageBox('Sauvegarde la partie?',Nil,mfError+mfYesNoCancel+mfInsertInApp);
  If(Result=cmYes)Then Result:=SaveGame;}
 End
  else
 Result:=cmOK;
 CheckActiveGame:=Result;
end;

Procedure TChessBoard.ClearBoard;Var KillCollection:TCollection;Begin
 Surface^.Clear;
 KillCollection.Init(32,0);
 Views.Message(@Self,evBroadcast,cmRegisterSave,@KillCollection);
 KillCollection.Done;
End;

Procedure TChessBoard.DoThink;Begin
 If(Game<>0)and Not GameOver and Not(ThinkState in[ssComplete,ssGameOver])Then Process;
 If Not(GameOver)Then Update;
end;

Procedure TChessBoard.DrawSurface;Begin
 Surface^.DrawView;
End;

Procedure TChessBoard.DrawValidMoves;

 Procedure TestAndInvert(Test,Show:TLocation);Var R:TRect;Begin
  If Word(Test)=Word(QSquare)Then Surface^.ValidMoves[Show.X,Show.Y]:=Ya;
 End;

Var X:Int;
Begin
 FillClr(Surface^.ValidMoves,SizeOf(Surface^.ValidMoves));
 If Not(Empty)Then Begin
  X:=0;
  While(X<=High(ValidMoves))and(ValidMoves[X].Change.Piece<>pEmpty)do Begin
   With ValidMoves[X].Change do TestAndInvert(Source,Dest);
   Inc(X);
  End;
  X:=0;
  While(X<=High(ValidMoves))and(OpponentMoves[X].Change.Piece<>pEmpty)do Begin
   With OpponentMoves[X].Change do TestAndInvert(Source,Dest);
   Inc(X);
  End;
 End
  else
 Begin
  X:=0;
  While(X<=High(ValidMoves))and(ValidMoves[X].Change.Piece<>pEmpty)do Begin
   With ValidMoves[X].Change do TestAndInvert(Dest,Source);
   Inc(X);
  End;
  X:=0;
  While(X<=High(OpponentMoves))and(OpponentMoves[X].Change.Piece<>pEmpty)do Begin
   With OpponentMoves[X].Change do TestAndInvert(Dest,Source);
   Inc(X);
  End;
 End;
End;

Function TChessBoard.GetComputerTime;Var MarkTime:Longint;Begin
 Case(Settings.TimeMode)of
  tmGameLimit:Begin
   MarkTime:=(Settings.GameTime*1092-ChessTimers[Computer]^.GetCurrentTicks)div 44;
   If MoveHistory^.UndoPos shr 1<=40Then MarkTime:=91+(MarkTime-91)*((80-MoveHistory^.UndoPos shr 1)div 40);
   GetComputerTime:=MarkTime;
  End;
  tmTurnLimit:GetComputerTime:=Settings.TurnTime*18;
  tmMatchUser:Begin
   MarkTime:=ChessTimers[Opponent(GetPlayer(Game))]^.GetMarkTime;
   If MarkTime>0Then GetComputerTime:=MarkTime else GetComputerTime:=5*18;
  End;
  tmInfinite:GetComputerTime:=High(Longint);
 End;
End;

Function TChessBoard.GetPalette;Const P:String[Length(CChessBoard)]=CChessBoard;Begin
 GetPalette:=@P;
End;

Procedure TChessBoard.HandleEvent;Var Move:TMove;LastSquare:TLocation;

 Procedure HandEventToPiece(P:PView);Begin
  If Event.What and P^.EventMask<>0Then P^.HandleEvent(Event);
 End;

 Function ContainsMouse(P:PView):Bool;Far;Begin;ContainsMouse:=P^.MouseInView(Event.Where)End;

 Procedure EnterMove;Var Dlg:PDialog;R:TRect;Control:PView;Change:TChange;P:PChessPiece;Result:TChessError;Begin
  R.Assign(0,0,39,7);
  System.New(Dlg,Init(R,'Entrez le dÇplacement'));
  With Dlg^do Begin
   Options:=Options or ofCentered;
   R.Assign(14,2,36,3);
   Control:=System.New(PInputLine,Init(R,20));
   PInputLine(Control)^.SetValidator(System.New(PValidateMove,Init));
   PInputLine(Control)^.Validator^.Options:=voTransfer;
   Insert(Control);
   R.Assign(2,2,14,3);
   Insert(System.New(PLabel,Init(R,'~E~nter move ',Control)));
   R.Assign(8,4,18,6);
   Insert(System.New(PButton,Init(R,'O~K~',cmOK,bfDefault)));
   Inc(R.A.X,14); Inc(R.B.X,14);
   Insert(System.New(PButton,Init(R,'Cancel',cmCancel,bfNormal)));
   SelectNext(No);
  End;
  If(Application^.ExecView(Dlg)<>cmCancel)Then Begin
   Dlg^.GetData(Change);
   Result:=ValidateMove(Change);
   If Result in[ceOK,ceAmbiguousMove]Then Begin
    P:=Views.Message(@Self,evMove,cmFindPiece,Ptr(0,Word(Change.Source)));
    If(P=Nil)Then MessageBox(^C'Piece not located there.',Nil,mfError+mfOKButton+mfInsertInApp)
     else
    Begin
     If(Result=ceAmbiguousMove)Then Change.Piece:=P^.GetPromotionPiece;
     Views.Message(@Self,evMove,cmSubmitMove,@Change);
    End;
   End
    else
   MessageBox(^C'DÇplacement invalide.',Nil,mfError+mfOKButton+mfInsertInApp);
  End;
  Dispose(Dlg, Done);
 End;

 Procedure ShowHint;Var Move:TMove;Begin
  GetHintMove(Game,Move);
  If(VerifyMove(Game,Move.Change)=ceOK)Then Begin
   Views.Message(@Self,evMove,cmMovePiece,@Move);
   Wait(5);
   Views.Message(@Self,evMove,cmUndoMove,@Move);
   Wait(5);
   Views.Message(@Self,evMove,cmMovePiece,@Move);
   Wait(5);
   Views.Message(@Self,evMove,cmUndoMove,@Move);
   Wait(5);
  End
   else
  MessageBox(^C'No hint available',Nil,mfInformation+mfOKButton+mfInsertInApp);
 End;

Begin
 Case(Event.What)of
  evMove:Case(Event.Command)of
   cmSubmitMove:Begin
    ChessTimers[GetPlayer(Game)]^.Stop;
    If(SubmitMove(Game,TChange(Event.InfoPtr^))=ceOK)Then Begin
     If(GetLastMove(Game,Move)=ceOK)Then Begin
      AddToHistory(Move);
      Views.Message(@Self,evMove,cmMovePiece,@Move);
      ResetValidMoves;
     End;
     If(GameMode and gmTwoPlay<>gmTwoPlay)Then StartComputerMove
      else
     Begin
      ResetCurrentPlayer;
      ChessTimers[Player]^.Mark;
      ChessTimers[Player]^.Start;
     End;
     Exit;
    End;
   End;
  End;
  evMouseDown:Begin
   If(Event.Buttons=mbRightButton)Then Begin
    If Settings.Hints and hoRtClickHints<>0Then Begin
     LastSquare:=QSquare;
     Repeat
      PointInSquare(Event.Where,QSquare);
      If Word(QSquare)<>Word(LastSquare)Then Begin
       DrawValidMoves(Views.Message(@Self,evMove,cmFindPiece,Ptr(0,Word(QSquare)))=Nil);
       Surface^.DrawView;
       LastSquare:=QSquare;
      End;
     Until Not MouseEvent(Event,evMouseMove+evMouseAuto);
     Word(Qsquare):=0;
     DrawValidMoves(No);
     Surface^.DrawView;
    End;
    ClearEvent(Event);
    Exit;
   End;
   HandEventToPiece(FirstThat(@ContainsMouse));
  End;
 End;
 Inherited HandleEvent(Event);
 Case(Event.What)of
  evCommand:Begin
   Case(Event.Command)of
    cmNew:Begin
     If GameOver or(CheckActiveGame<>cmCancel)Then Begin
      DisposeGame(Game);
      If(NewGame(Game)<>ceOK)Then Game:=0;
      SetupNewGameBoard;
      If Game<>0Then StatusDialog^.Update(Game,ChessTimers,0,0,GameMode);
     End;
    End;
    cmComputerMove:If ThinkState in[ssComplete,ssThinkAhead]Then StartComputerMove;
    cmRunDemo:If GameMode and gmDemo=0Then Begin
     GameMode:=GameMode or gmDemo;
     If ThinkState in[ssComplete,ssThinkAhead]Then StartComputerMove;
    End;
    cmStop:If(Game<>0)and(ThinkState=ssMoveSearch)Then Begin
     ForceMove(Game);
     Computer:=GetPlayer(Game); Player:=Opponent(Computer);
     GameMode:=GameMode and Not gmDemo;
    End;
    cmUndo:Undo;
    cmRedo:Redo;
    cmGameOver:ShowEndGame(Event.InfoInt);
    cmSave:SaveGame;
    cmSaveAs:SaveGameAs;
    cmOpen:ReadGame;
    cmEnterMove:EnterMove;
    cmShowHint:ShowHint;
    else Exit
   End;
   ClearEvent(Event);
  End;
  evKeyDown:If ThinkState in[ssComplete,ssThinkAhead]Then Begin
   PutEvent(Event);
   EnterMove;
   ClearEvent(Event);
  End;
 End;
End;

Procedure TChessBoard.InitGameBoard;Var I,J:Int;P:PChessPiece;
R:TRect;Board:TBoard;Location:TLocation;ChessStatus:TChessStatus;Begin
 If Game<>0Then Begin
  If(GetBoard(Game,Board)=ceOk)Then For J:=1to 8do For I:=1to 8do If(Board[I,J].Piece<>pEmpty)Then Begin
   Location.X:=I; Location.Y:=J;
   SquareToLocal(Location,R.A,Size.Y);
   R.Assign(R.A.X,R.A.Y,R.A.X+6,R.A.Y+3);
   P:=System.New(PChessPiece,Init(R,Board[I,J],Location));
   P^.Hide;
   InsertPiece(P,P^.Location);
  End;
  Player:=cWhite;Computer:=cBlack;GameMode:=GameMode and not gmDemo;
  GameOver:=No;ThinkState:=GetSearchStatus(Game);
  Update;
 End;
End;

Procedure TChessBoard.InsertPiece;Begin
 Insert(Piece);
 Surface^.Squares[Location.X,Location.Y]:=Piece;
End;

Procedure TChessBoard.MovePiece;Begin
 Surface^.Squares[FromLoc.X,FromLoc.Y]:=Nil;
 Surface^.Squares[ToLoc.X,ToLoc.Y]:=Piece;
 DrawSurface;
End;

Procedure TChessBoard.Process;Var OldState:TSearchStatus;ChessStatus:TChessStatus;
Move:TMove;Event:TEvent;ComputerPlayer:TColor;I:Int;Begin
 OldState:=ThinkState;
 If(GetPlayer(Game)=Computer)or(GameMode and gmDemo<>0)Then Begin
  ComputerPlayer:=GetPlayer(Game);
  ChessTimers[ComputerPlayer]^.Start;
  Think(Game,4,ThinkState);
  ChessTimers[ComputerPlayer]^.Stop;
 End
  else
 Think(Game,2,ThinkState);
 If(OldState=ssMoveSearch)and(ThinkState=ssComplete)Then AcceptComputerMove;
End;

Procedure TChessBoard.ReadGame;
Var S:PBufStream; Test:Array[0..SizeOf(ChessSignature)]of Char;
    NewMoveList:PMoveList; FileDialog:PFileDialog; AGameName:String; X:Int;

 Function ReplayMoves(P:PMove):Bool;Far;Begin
  SubmitMove(Game,P^.Change);
  ReplayMoves:=X>=MoveHistory^.UndoPos; Inc(X);
 End;

Begin
 If(CheckActiveGame<>cmCancel)Then Begin
  FileDialog:=System.New(PFileDialog,Init('*.CHS','Ouvre une partie','~G~ame',fdOpenButton,100));
  If(Application^.ExecView(FileDialog)<>cmCancel)Then Begin
   FileDialog^.GetFileName(AGameName);
   S:=System.New(PBufStream,Init(AGameName,stOpenRead,1024));
   S^.Read(Test,SizeOf(ChessSignature));
   If(S^.Status<>stOK)Then MessageBox('Erreur de lecture du fichier',Nil,mfError+mfOKButton+mfInsertInApp)else
   If StrLComp(ChessSignature,Test,SizeOf(ChessSignature))<>0Then
    MessageBox('Ce n''est pas un fichier d''Çchec',Nil,mfError+mfOKButton+mfInsertInApp)else
   Begin
    NewMoveList:=PMoveList(S^.Get);
    If(S^.Status<>stOK)Then MessageBox('Erreur de lecture du fichier',Nil,mfError+mfOKButton+mfInsertInApp)
     else
    Begin
     ClearBoard;
     DisposeGame(Game);
     If(NewGame(Game)<>ceOK)Then Game:=0
      else
     Begin
      Dispose(MoveHistory,Done);
      MoveHistory:=NewMoveList;
      X:=0;
      MoveHistory^.FirstThat(@ReplayMoves);
      If(StatusDialog<>Nil)Then StatusDialog^.UpdateList(MoveHistory);
      InitGameBoard;
      ResetValidMoves;
      Update;
     End;
    End;
   End;
   Dispose(S,Done);
  End;
 End;
End;

Procedure TChessBoard.Redo;Var Move:TMove;Begin
 AbortSearch(Game);
 ChessTimers[Player]^.Stop;
 MoveHistory^.Redo(Move);
 If(SubmitMove(Game,Move.Change)=ceOK)Then If(GetLastMove(Game,Move)=ceOK)Then Views.Message(@Self,evMove,cmMovePiece,@Move);
 If(GameMode=gmOnePlay)and(MoveHistory^.RedoAvail)and(Player<>GetPlayer(Game))Then Begin
  MoveHistory^.Redo(Move);
  If(SubmitMove(Game,Move.Change)=ceOK)Then If(GetLastMove(Game,Move)=ceOK)Then Views.Message(@Self,evMove,cmMovePiece,@Move);
 End
  else
 ResetCurrentPlayer;
 ResetValidMoves;
 ChessTimers[Player]^.Mark;
 ChessTimers[Player]^.Start;
 If(StatusDialog<>Nil)Then StatusDialog^.UpdateList(MoveHistory);
 Update;
End;

Procedure TChessBoard.RemovePiece;Begin
 If(Surface^.Squares[Location.X,Location.Y]=Piece)Then Surface^.Squares[Location.X,Location.Y]:=Nil;
End;

Procedure TChessBoard.ResetCurrentPlayer;Begin
 Player:=GetPlayer(Game);Computer:=Opponent(Player);
End;

Procedure TChessBoard.ResetValidMoves;Var Chg:TChange;PlayerColor:TColor;EmptyMove:TMove;

 Procedure DoAttacks(P:PView);Far;Begin
  If TypeOf(P^)=TypeOf(TChessPiece)Then
   If(PChessPiece(P)^.PieceType.Color<>PlayerColor)Then
    If Settings.Hints and hoAttacks<>0Then
     PChessPiece(P)^.CheckJeopardy(ValidMoves)
    Else PChessPiece(P)^.CheckJeopardy(EmptyMove);
 End;

 Procedure DoJeopardies(P:PView);Far;Begin
  If TypeOf(P^)=TypeOf(TChessPiece)Then
   If(PChessPiece(P)^.PieceType.Color=PlayerColor)Then
    PChessPiece(P)^.CheckJeopardy(OpponentMoves)
   Else PChessPiece(P)^.CheckJeopardy(EmptyMove);
 End;

Begin
 Chg.Piece:=pEmpty;Word(Chg.Source):=0;Word(Chg.Dest):=0;
 FillClr(EmptyMove,SizeOf(EmptyMove));
 PlayerColor:=GetPlayer(Game);
 If Settings.Hints and hoJeopardies<>0Then Begin
  SetPlayer(Game,Opponent(PlayerColor));
  GetValidMoves(Game,Chg,OpponentMoves);
  SetPlayer(Game,PlayerColor);
  If Settings.Hints and hoJeopardies<>0Then ForEach(@DoJeopardies);
 End
  else
 Begin
  OpponentMoves[0]:=EmptyMove;
  ForEach(@DoJeopardies);
 End;
 GetValidMoves(Game,Chg,ValidMoves);
 ForEach(@DoAttacks);
 DrawSurface;
End;

Function TChessBoard.SaveGame;Var S:PBufStream;Begin
 SaveGame:=cmCancel;
 If GameName=''Then Begin;SaveGame:=SaveGameAs;Exit;End
  else
 If Game<>0Then Begin
  S:=System.New(PBufStream,Init(GameName,stCreate,1024));
  S^.Write(ChessSignature,SizeOf(ChessSignature));
  S^.Put(MoveHistory);
  If(S^.Status<>stOK)Then MessageBox('Erreur d''Çcriture du fichier',Nil,mfError+mfOKButton+mfInsertInApp);
  Dispose(S,Done);
  SaveGame:=cmOK;
 End;
End;

Function TChessBoard.SaveGameAs;Var FileDialog:PFileDialog;Begin
 SaveGameAs:=cmCancel;
 FileDialog:=System.New(PFileDialog,Init('*.CHS','Sauve la partie sous','~S~ave game as',fdOKButton,101));
 If(Application^.ExecView(FileDialog)<>cmCancel)Then Begin
  FileDialog^.GetFileName(GameName);
  SaveGameAs:=SaveGame;
 End;
 Dispose(FileDialog,Done);
End;

Procedure TChessBoard.SetGameBoard;Begin
 If Game<>0Then If(SetBoard(Game, ABoard)<>ceOK)Then
  MessageBox('Erreur d''ajustement du plateau du jeux',nil,mfError+mfOKButton+mfInsertInApp);
End;

Procedure TChessBoard.SetupNewGameBoard;Var Color:TColor;Begin
 ClearBoard;
 If(MoveHistory<>Nil)Then MoveHistory^.Purge;
 GameName:='';
 For Color:=cWhite to(cBlack)do If(ChessTimers[Color]<>Nil)Then ChessTimers[Color]^.Clear;
 InitGameBoard;
 ResetValidMoves;
End;

Procedure TChessBoard.ShowEndGame;Type TWinRec=Record Winner,Loser:PString;End;
Var ReasonStr:String;Winner:TColor;WinRec:TWinRec;BStr,WStr:String[5];Begin
 Winner:=Opponent(GetPlayer(Game));BStr:='Noir';WStr:='Blanc';
 If(Winner=cBlack)Then Begin;WinRec.Winner:=@BStr;WinREc.Loser:=@WStr;End
		  else Begin;WinRec.Winner:=@WStr;WinREc.Loser:=@BStr;End;
 Case TChessStatus(Reason)of
  csCheckMate: ReasonStr:=^C'êchec et mate!'#13^C'%s gagnes!';
  csStaleMate: ReasonStr:=^C'Stalemate!';
  csResigns: ReasonStr:=^C'%s rÇsignÇ!'#13^C'%s gagne!';
  csFiftyMoveRule: ReasonStr:=^C'Stalemate!'#13^C'Fifty move rule.';
  csRepetitionRule: ReasonStr:=^C'Stalemate!'#13^C'Repitition rule.';
 End;
 MessageBox(ReasonStr,@WinRec,mfInformation+mfOKButton+mfInsertInApp);
End;

Procedure TChessBoard.StartComputerMove;Var ComputerTime:Longint;Begin
 AbortSearch(Game);
 Computer:=GetPlayer(Game); Player:=Opponent(Computer);
 ComputerTime:=GetComputerTime;
 ChessTimers[GetPlayer(Game)]^.Mark;
 ComputerMove(Game,ComputerTime);
 ThinkState:=GetSearchStatus(Game);
 If(StatusDialog<>Nil)Then StatusDialog^.LastNodes:=0;
End;

Procedure TChessBoard.Undo;Var Move:TMove;R:TRect;P:PChessPiece;Begin
 AbortSearch(Game);
 GameOver:=No;
 ChessTimers[Player]^.Stop;
 MoveHistory^.Undo(Move);
 If(RetractMove(Game,Move)=ceOK)Then Views.Message(@Self,evMove,cmUndoMove,@Move);
 If(GameMode=gmOnePlay)and(MoveHistory^.UndoAvail)and(Player<>GetPlayer(Game))Then Begin
  MoveHistory^.Undo(Move);
  If(RetractMove(Game,Move)=ceOK)Then Views.Message(@Self,evMove,cmUndoMove,@Move);
 End
  else
 ResetCurrentPlayer;
 ResetValidMoves;
 ChessTimers[Player]^.Mark;
 ChessTimers[Player]^.Start;
 If(StatusDialog<>Nil)Then StatusDialog^.UpdateList(MoveHistory);
 Update;
End;

Procedure TChessBoard.Update;Var ChessStatus:TChessStatus;MateInMoves:Int;Event:TEvent;Begin
 UpdateCommands;
 ChessStatus:=GetChessStatus(Game,MateInMoves);
 If(StatusLine<>nil)Then PChessStatusLine(StatusLine)^.SetStatus(ChessStatus,MateInMoves);
 If Not(ChessStatus in[csNormal,csCheck,csMateFound])Then Begin
  ChessTimers[cWhite]^.Stop;
  ChessTimers[cBlack]^.Stop;
  GameOver:=Ya;
  AbortSearch(Game);
  GameMode:=GameMode and not gmDemo;
  ThinkState:=GetSearchStatus(Game);
  UpdateCommands;
  Event.What:=evCommand;Event.Command:=cmGameOver;Event.InfoInt:=Int(ChessStatus);
  PutEvent(Event);
 End;
End;

Procedure TChessBoard.UpdateCommands;Begin
 If(MoveHistory<>Nil)Then Begin
  If(StatusDialog<>Nil)Then StatusDialog^.Update(Game,ChessTimers,GetNodes(Game),MoveHistory^.GetNumMoves,GameMode);
  SetCmdState([cmRedo],(MoveHistory^.RedoAvail)and(ThinkState<>ssMoveSearch));
  SetCmdState([cmUndo],(MoveHistory^.UndoAvail)and(ThinkState<>ssMoveSearch));
  SetCmdState([cmComputerMove,cmEnterMove,cmShowHint],(ThinkState<>ssMoveSearch)and Not GameOver);
  SetCmdState([cmStop],(GameMode and gmDemo<>0)or(ThinkState=ssMoveSearch));
  SetCmdState([cmRunDemo],(GameMode and gmDemo=0)and Not GameOver);
 End;
End;

Function TChessBoard.ValidateMove;Var X:Int;ValidMove:TMove;CurMove:TMove;Begin
 ValidateMove:=ceInvalidMove;
 If ThinkState in[ssComplete, ssThinkAhead]Then Begin
  X:=0;
  FillClr(CurMove,SizeOf(CurMove));
  While(X<=High(ValidMoves))and(ValidMoves[X].Change.Piece<>pEmpty)do Begin
   ValidMove:=ValidMoves[X];
   With ValidMove do
    If((Change.Piece=C.Piece)or(C.Piece=pEmpty))and
      ((Word(Change.Dest)=Word(C.Dest)) or (Word(C.Dest)=0))and
      ((Word(Change.Source)=Word(C.Source))or(Word(C.Source)=0))Then Begin
     If(CurMove.Change.Piece=pEmpty)Then CurMove:=ValidMove
      else
     Begin
      If(ValidMove.Change.Piece=pPawn)and(CurMove.Change.Piece<>pPawn)Then CurMove:=ValidMove else
      If(ValidMove.Change.Piece<>pPawn)and(CurMove.Change.Piece=pPawn)Then
       else
      Begin
       C:=CurMove.Change;ValidateMove:=ceAmbiguousMove;
       Exit;
      End;
     End;
    End;
   Inc(X);
  End;
  If(CurMove.Change.Piece<>pEmpty)Then Begin C:=CurMove.Change; ValidateMove:=ceOK; End;
 End;
End;

Function TChessBoard.Valid;Begin
 Valid:=Ya;
 If(Command=cmQuit)Then Valid:=CheckActiveGame<>cmCancel;
End;

Procedure TChessStatusLine.Draw;Var B:TDrawBuffer;CNormal:Word;StatBuf:String;Begin
 CNormal:=GetColor($0301);
 MoveChar(B,' ',Byte(CNormal),Size.X);
 StatBuf:=Hint(0);
 If(Length(StatBuf)>Size.X)Then StatBuf[0]:=Char(Size.X);
 MoveStr(B,StatBuf,Byte(CNormal));
 WriteLine(0,0,Size.X,1,B);
End;

Function TChessStatusLine.Hint;Var S:String;Begin
 Case(ChessStatus)of
  csNormal: Hint:='';
  csCheck: Hint:=' êchec!';
  csCheckMate: Hint:=' êchec et mate!';
  csStaleMate: Hint:=' Stalemate!';
  csResigns: Hint:=' RÇsignÇ!';
  csMateFound:
  Begin
   FormatStr(S,' êchec et mate dans les %d',MateInMoves);
   Hint:=S;
  End;
  csFiftyMoveRule: Hint:=' Fifty move rule!';
  csRepetitionRule: Hint:=' Repetition rule!';
 End;
End;

Procedure TChessStatusLine.SetStatus;Begin
 ChessStatus:=AChessStatus;MateInMoves:=Count;
 DrawView;
End;

Constructor TTimerView.Init;Begin
 Inherited Init(Bounds,AText,AParamCount);
 Color:=AColor;
End;

Constructor TTimerView.Load;Begin
 Inherited Load(S);
 S.Read(Color,SizeOf(Color));
End;

Function TTimerView.GetPalette;Const P:Array[TTimerColor]of String[Length(CWTimerView)]=(CWTimerView,CBTimerView,CGTimerView);
Begin
 GetPalette:=@P[Color]
End;

Procedure TTimerView.Store;Begin
 Inherited Store(S);
 S.Write(Color,SizeOf(Color));
End;

Function TTurnText.DataSize;Begin
 DataSize:=SizeOf(Color)+Inherited DataSize;
End;

Procedure TTurnText.SetData;Begin
 Color:=TTimerColor(Rec);
 ParamList:=Ptr(Seg(Rec),Ofs(Rec)+SizeOf(Color));
 DrawView;
End;

Function TBestLine.GetPalette;Const P:String[Length(CBestLine)]=CBestLine;Begin
 GetPalette:=@P;
End;

Constructor TMoveListBox.Init;Begin
 Inherited Init(Bounds,1,Nil,AScrollBar);
 List:=Nil;
 SetRange(0);
End;

{$V-}
Function TMoveListBox.GetText;Var White,Black:String[6];
P:Array[0..2]of Longint;Str:Array[0..6]of Char; Entry:String;Begin
 If(List<>nil)and(List^.Count>=Item*2)Then Begin
  P[0]:=Item+1;
  MoveToStr(PMove(List^.At(Item*2))^,Str);
  White:=StrPas(Str);
  If List^.Count>Item*2+1Then Begin
   MoveToStr(PMove(List^.At(Item*2+1))^,Str);
   Black:=StrPas(Str);
  End
   else
  Black:='';
  P[1]:=Longint(@White);P[2]:=Longint(@Black);
  FormatStr(Entry,'%3d  %6s  %6s',P);
 end
  else
 Entry:='';
 GetText:=Copy(Entry,1,AMaxLen);
End;
{$V+}

Procedure TMoveListBox.Update;Var ARange,AUndoPos,OldRange:Int;Begin
 List:=AMoveList;
 If(List<>Nil)Then Begin
  ARange:=(List^.Count+1)shr 1; AUndoPos:=List^.UndoPos shr 1;
  OldRange:=Range;
  SetRange(ARange);
  FocusItem(AUndoPos);
  If(OldRange=ARange)Then DrawView;
 End
  else
 SetRange(0);
End;

Constructor TStatusDialog.Init;Var R:TRect;SB:PScrollBar;Begin
 Inherited Init(Bounds,'');
 Flags:=0;
 R.Assign(1,1,7,2);
 Insert(System.New(PStaticText,Init(R,'Turn:')));
 R.Assign(7,1,Size.X-8,2);
 Insert(System.New(PTurnText,Init(R,' %-3d   %s',2,tcWhite)));
 Inc(R.A.Y); Inc(R.B.Y);
 R.Assign(1,R.A.Y,Size.X-1,R.B.Y);
 Insert(System.New(PParamText,Init(R,'Mode: %s',1)));
 Inc(R.A.Y); Inc(R.B.Y);
 R.Assign(Size.X shr 2,R.A.Y,Size.X shr 1+Size.X shr 2-1,R.B.Y);
 Insert(System.New(PTimerView,Init(R,^C'%s',1,tcTotal)));
 Inc(R.A.Y); Inc(R.B.Y);
 R.Assign(1,R.A.Y,(Size.X)shr 1,R.B.Y);
 Insert(System.New(PTimerView,Init(R,^C'%s',1,tcWhite)));
 R.Assign(Size.X div 2,R.A.Y,Size.X-1,R.B.Y);
 Insert(System.New(PTimerView,Init(R,^C'%s',1,tcBlack)));
 Inc(R.A.Y,2); Inc(R.B.Y,2);
 R.Assign(1,R.A.Y,Size.X-1,R.B.Y);
 Insert(System.New(PParamText,Init(R,'Value: %6d',1)));
 Inc(R.A.Y); Inc(R.B.Y);
 R.Assign(1,R.A.Y,Size.X-1,R.B.Y);
 Insert(System.New(PParamText,Init(R,'Nodes: %6d %5d/sec',2)));
 Inc(R.A.Y);
 R.Assign(Size.X-1,R.A.Y,Size.X,Size.Y-9);
 SB:=System.New(PScrollBar,Init(R));
 Insert(SB);
 R.Assign(1,R.A.Y,Size.X-1,R.B.Y);
 MoveListBox:=System.New(PMoveListBox,Init(R,SB));
 Insert(MoveListBox);
 R.Assign(1,Size.Y-9,Size.X-1,Size.Y-8);
 Insert(System.New(PParamText,Init(R,'Bestline: %s',1)));
 R.Assign(1,Size.Y-8,Size.X-1,Size.Y-1);
 Insert(System.New(PBestLine,Init(R,'%s',1)));
 SetData(GameStatus);
End;

Function TStatusDialog.GetPalette;Const P:String[Length(CStatusDialog)]=CStatusDialog;Begin
 GetPalette:=@P;
End;

{$V-}
Procedure TStatusDialog.Update;Var MLine:Array[0..10]of TMove;MainValue:Int;Str:Array[0..20]of Char;
I:Int;Params:Array[0..3]of Longint; LastSrch,SrchStat:TSearchStatus;

 Procedure GetTime(TickTime:Longint;Var Hours,Minutes,Seconds,Ticks:Longint);Var H,M,S,T:Word;Begin
  ConvertTicks(TickTime,H,M,S,T);
  Hours:=H;Minutes:=M;Seconds:=S;Ticks:=T;
 End;

Begin
 GameStatus.MoveColor:=GetPlayer(Game);
 If(GameStatus.MoveColor=cWhite)Then CurPlayer:='Blanc'Else CurPlayer:='Noir';
 GameStatus.MoveNo:=MoveNumber;GameStatus.Nodes:=Nodes;
 LastSrch:=SrchStat;SrchStat:=GetSearchStatus(Game);
 Case(SrchStat)of
  ssMoveSearch:SearchStatus:='Thinking';
  ssThinkAhead:SearchStatus:='Thinking ahead';
  Else SearchStatus:='';
 End;
 If GMode and gmDemo<>0Then GameMode:='DÇmo'else
 If(GMode=gmOnePlay)Then GameMode:='1 joueur'else GameMode:='2 joueurs';
 GetTime(ATimers[Ord(cWhite)]^.GetCurrentTicks+ATimers[Ord(cBlack)]^.GetCurrentTicks,
	 Params[0],Params[1],Params[2],Params[3]);
 FormatStr(GTime,'%02d:%02d:%02d.%02d',Params);
 If(SrchStat in[ssMoveSearch,ssThinkAhead])and(LastSec<>Params[2])Then Begin
  LastSec:=Params[2];
  If(LastSrch=SrchStat)Then GameStatus.NodesSec:=Nodes-LastNodes
		       else GameStatus.NodesSec:=0;
  LastNodes:=Nodes;
 End;
 For I:=Low(ATimers)to High(ATimers)do Begin
  GetTime(ATimers[I]^.GetCurrentTicks,Params[0],Params[1],Params[2],Params[3]);
  FormatStr(TimeStrs[TColor(I)],'%02d:%02d:%02d.%02d',Params);
 End;
 BestLine:='';
 GetMainLine(Game,MainValue,MLine);
 GameStatus.Value:=MainValue;
 If Settings.Hints and hoBestLine<>0Then Begin
  For I:=Low(MLine)to High(MLine)do Begin
   If(MLine[I].Change.Piece<>pEmpty)Then Begin
    MoveToStr(MLine[I],Str);
    BestLine:=BestLine+StrPas(Str)+' ';
   End
    else
   Break;
  End;
 End;
 SetData(GameStatus);
End;

Procedure TStatusDialog.UpdateList;Begin;MoveListBox^.Update(AMoveList)End;

Function MaxI(I1,I2:Int):Int;Inline($58/$5B/$3B/$C3/$7D/$01/$93);
Function MinI(I1,I2:Int):Int;Inline($58/$5B/$3B/$C3/$7E/$01/$93);

Procedure SquareToLocal(ALocation:TLocation;Var P:TPoint;Size:Int);Begin
 P.X:=(ALocation.X-1)*6+2;P.Y:=Size-ALocation.Y*3;
End;

Procedure PointInSquare(P:TPoint;Var ALocation:TLocation);Begin
 ALocation.X:=MinI(MaxI(1,((P.X - 2)div 6)+1),8);
 ALocation.Y:=MinI(MaxI(1,8-((P.Y-1)div 3)),8);
End;

Type TPictureType=Array[0..2]of Record X:Int; S:String[6]; End;

Const PiecePicture:Array[pKing..pPawn]of TPictureType=
   (((x:1;s:'++++'),
     (x:1;s:'Ù KÙ'),
     (x:1;s:'ıııı')),
    ((x:1;s:'ÈÈÈÈ'),
     (x:1;s:'∆ŒŒµ'),
     (x:1;s:'≥ Q≥')),
    ((x:1;s:'⁄““ø'),
     (x:1;s:'≥ R≥'),
     (x:1;s:'≥  ≥')),
    ((x:2;s:'⁄Íø'),
     (x:2;s:'≥ ≥'),
     (x:2;s:'≥B≥')),
    ((x:1;s:'⁄ƒƒø'),
     (x:1;s:'‘ø''≥'),
     (x:2;s:'≥N≥')),
    ((x:0;s:''),
     (x:3;s:'P'),
     (x:2;s:'')));

Constructor TGlyphButton.Init;Begin
 Inherited Init(Bounds,ATitle,ACommand,AFlags);
 Piece:=APiece;Color:=AColor;
End;

Constructor TGlyphButton.Load;Begin
 Inherited Load(S);
 S.Read(Piece,SizeOf(Piece));
 S.Read(Color,SizeOf(Color));
End;

Procedure TGlyphButton.Draw;Begin
 DrawState(No);
End;

Procedure TGlyphButton.DrawState;Var CButton,CShadow,CPiece:Word;Ch,SelCh:Char;I,S,Y,T:Int;B:TDrawBuffer;

 Procedure DrawPiece(Line:Byte);Var L,SCOff:Int;Begin
  If Flags and bfLeftJust<>0Then L:=1
   else
  Begin
   L:=(S-Length(PiecePicture[Piece][Line].s)-1)shr 1;
   If L<1Then L:=1;
  End;
  MoveCStr(B[I+L+PiecePicture[Piece][Line].x-1],PiecePicture[Piece][Line].s,CPiece);
  If ShowMarkers and Not(Down)Then Begin
   If State and sfSelected<>0Then SCOff:=0 else
   If(AmDefault)Then SCOff:=2 else SCOff:=4;
   WordRec(B[0]).Lo:=Byte(SpecialChars[SCOff]);
   WordRec(B[S]).Lo:=Byte(SpecialChars[SCOff+1]);
  End;
 End;

Begin
 CButton:=GetColor($0101); CPiece:=$0402; SelCh:='∞';
 If State and sfActive<>0Then If State and sfSelected<>0Then Begin;CPiece:=Swap(CPiece);SelCh:=' 'End;
 If(Color=cBlack)Then Inc(CPiece,$0101);
 CPiece:=GetColor(CPiece);CShadow:=GetColor(6);
 S:=Size.X-1;T:=(Size.Y shr 1)-2;
 For Y:=0to Size.Y-2do Begin
  MoveChar(B,SelCh,Byte(CButton),Size.X);
  WordRec(B[0]).Hi:=CShadow;
  WordRec(B[0]).Lo:=Byte(' ');
  If(Down)Then Begin
   WordRec(B[1]).Hi:=CShadow;WordRec(B[1]).Lo:=Byte(' ');Ch:=' ';I:=2;
  End
   else
  Begin
   WordRec(B[S]).Hi:=Byte(CShadow);
   If(ShowMarkers)Then Ch:=' 'else
   Begin
    If Y=0Then WordRec(B[S]).Lo:=Byte('‹')else WordRec(B[S]).Lo:=Byte('€');
    Ch:='ﬂ';
   End;
   I:=1;
  End;
  If(Y>=T)and(Y<=T+2)Then DrawPiece(Y-T);
  If(ShowMarkers and not Down)Then Begin
   WordRec(B[1]).Lo:=Byte(' ');WordRec(B[S-1]).Lo:=Byte(' ');
  End;
  WriteLine(0,Y,Size.X,1,B);
 End;
 MoveChar(B[0],' ',Byte(CShadow),2);
 MoveChar(B[2],Ch,Byte(CShadow),S-1);
 WriteLine(0,Size.Y-1,Size.X,1,B);
End;

Function TGlyphButton.GetPalette;Const P:String[Length(CGlyphButton)]=CGlyphButton;Begin
 GetPalette:=@P;
End;

Procedure TGlyphButton.HandleEvent;Var Down:Bool;Mouse:TPoint;ClickRect:TRect;Begin
 GetExtent(ClickRect);
 Inc(ClickRect.A.X);Dec(ClickRect.B.X);Dec(ClickRect.B.Y);
 If(Event.What=evMouseDown)Then Begin
  MakeLocal(Event.Where,Mouse);
  If Not ClickRect.Contains(Mouse)Then ClearEvent(Event)
   else
  Begin
   If Flags and bfGrabFocus<>0Then TView.HandleEvent(Event);
   If State and sfDisabled=0Then Begin
    Inc(ClickRect.B.X);Down:=No;
    Repeat
     MakeLocal(Event.Where,Mouse);
     If Down<>ClickRect.Contains(Mouse)Then Begin
      Down:=Not Down;
      DrawState(Down);
     End;
    Until Not MouseEvent(Event,evMouseMove);
    If(Down)Then Begin
     Press;
     DrawState(No);
    End;
   End;
   ClearEvent(Event);
  End;
 End;
 Inherited HandleEvent(Event);
End;

Procedure TGlyphButton.Store;Begin
 Inherited Store(S);
 S.Write(Piece,SizeOf(Piece));
 S.Write(Color,SizeOf(Color));
End;

Constructor TPromoteDialog.Init;Var R:TRect;Begin
 R.Assign(0,0,44,7);
 Inherited Init(R,'Promote Pawn');
 Flags:=Flags and not(wfGrow+wfClose+wfZoom); Options:=Options or ofCentered;
 R.Assign(3,2,11,6);
 Insert(System.New(PGlyphButton,Init(R,pQueen,AColor,'~Q~',cmQueen,bfNormal+bfGrabFocus)));
 Inc(R.A.X,10); Inc(R.B.X,10);
 Insert(System.New(PGlyphButton,Init(R,pRook,AColor,'~R~',cmRook,bfNormal+bfGrabFocus)));
 Inc(R.A.X,10); Inc(R.B.X,10);
 Insert(System.New(PGlyphButton,Init(R,pBishop,AColor,'~B~',cmBishop,bfNormal+bfGrabFocus)));
 Inc(R.A.X,10); Inc(R.B.X,10);
 Insert(System.New(PGlyphButton,Init(R,pKnight,AColor,'~K~',cmKnight,bfNormal+bfGrabFocus)));
 SelectNext(No);
End;

Function TPromoteDialog.GetPalette;Const P:String[Length(CPromoteDialog)]=CPromoteDialog;Begin
 GetPalette:=@P;
End;

Procedure TPromoteDialog.HandleEvent;Begin
 Case(Event.What)of
  evCommand:Begin
   Case(Event.Command)of
    cmQueen,cmRook,cmKnight,cmBishop:If State and sfModal<>0Then EndModal(Event.Command);
    else Exit;
   End;
   ClearEvent(Event);
  End;
  evKeyDown:Case(Event.KeyCode)of
   kbEnter:Begin
    Event.What:=evBroadcast;Event.Command:=cmDefault;Event.InfoPtr:=NIL;
    PutEvent(Event);
    ClearEvent(Event);
   End;
   kbEsc:ClearEvent(Event);
  End;
 End;
 Inherited HandleEvent(Event);
End;

constructor TChessPiece.Init;Begin
 Inherited Init(Bounds);
 EventMask:=EventMask or(evMove+evBroadcast);
 PieceType:=APieceType; Location:=ALocation;
End;

Constructor TChessPiece.Load;Begin
 Inherited Load(S);
 S.Read(PieceType,SizeOf(PieceType)+SizeOf(TLocation));
End;

Procedure TChessPiece.CapturePiece;Begin
 PChessBoard(Owner)^.RemovePiece(@Self,Location);
 Free;
End;

Procedure TChessPiece.CheckJeopardy;Var X:Int;OldState:Bool;Begin
 OldState:=InJeopardy;InJeopardy:=No;X:=0;
 While(Not InJeopardy)and(X<=High(MoveArray))and(MoveArray[X].Change.Piece<>pEmpty)do Begin
  InJeopardy:=Word(MoveArray[X].Change.Dest)=Word(Location);Inc(X);
 End;
 If(OldState xor InJeopardy)Then DrawView;
End;

Procedure TChessPiece.Draw;Var I:Int;B:TDrawBuffer;R:TRect;XOfs,XLen:Int;WasVisible:Bool;

 Procedure DoDraws(P:PView);Var Bounds:TRect;Begin
  While(P<>Nil)do Begin
   If P^.State and sfVisible<>0Then Begin
    P^.GetBounds(Bounds);
    Bounds.Intersect(R);
    If Not(Bounds.Empty)Then P^.DrawView;
   End;
   P:=P^.NextView;
  End;
 End;

Begin
 Owner^.Lock;
 WasVisible:=State and sfVisible<>0;State:=State and not sfVisible;
 GetBounds(R);
 DoDraws(NextView);
 If Not(WasVisible)Then Begin;Owner^.Unlock;Exit;End;
 State:=State or sfVisible;
 For I:=0to 2do Begin
  RawDraw(B,0,I,XOfs,XLen);
  If XLen>0Then WriteBuf(XOfs,I,XLen,1,B[XOfs]);
 End;
 Owner^.Unlock;
End;

Function TChessPiece.GetPromotionPiece;Var P:PWindow;Result:Word;begin
 If(PieceType.Piece=pPawn)Then Begin
  P:=System.New(PPromoteDialog,Init(PieceType.Color));
  Result:=Application^.ExecView(Application^.ValidView(P));
  GetPromotionPiece:=TPiece(Result-cmQueen+Ord(pQueen));
  Dispose(P,Done);
 End
  else
 GetPromotionPiece:=PieceType.Piece;
End;

Procedure TChessPiece.HandleEvent;Var E:TEvent;R:TRect;P:PChessPiece;S:TSquare;Begin
 Inherited HandleEvent(Event);
 Case Event.What of
  evMouseDown:If PChessBoard(Owner)^.CanMovePiece(PieceType.Color)Then Begin
   MakeFirst;
   R.Assign(0,0,Owner^.Size.X,Owner^.Size.Y);
   Show;
   DragView(Event,dmDragMove,R,Size,Size);
   Hide;
   SnapToSquare;
  End;
  evMove:Case(Event.Command)of
   cmMovePiece:With PMove(Event.InfoPtr)^do
    If(Kind in[kNormal,kEnPassant,kPawnPromote,kCastling])and(Word(Change.Source)=Word(Location))Then
    Begin
     If(Kind=kPawnPromote)and(PieceType.Piece=pPawn)Then PieceType.Piece:=Change.Piece;
     MoveToSquare(Change.Dest);
    End
     else
    If(PieceType.Piece=Contents)and Capture and(Word(Change.Dest)=Word(Location))Then CapturePiece else
    If(Kind=kCastling)and(PieceType.Piece=pRook)and(Word(RookSource)=Word(Location))Then MoveToSquare(RookDest)else
    If(Kind=kEnPassant)and(PieceType.Piece=Contents)and Capture and(Word(EPCapture)=Word(Location))Then	CapturePiece;
   cmUndoMove:With PMove(Event.InfoPtr)^do If Word(Change.Dest)=Word(Location)Then Begin
    If(Kind=kPawnPromote)and(Change.Piece=PieceType.Piece)Then PieceType.Piece:=pPawn;
    MoveToSquare(Change.Source);
    If(Capture)Then Begin
     S.Piece:=Contents;
     If(PieceType.Color=cWhite)Then S.Color:=cBlack else S.Color:=cWhite;
     Case(Kind)of
      kNormal:Begin
       SquareToLocal(Change.Dest,R.A,Owner^.Size.Y);
       R.Assign(R.A.X,R.A.Y, R.A.X+6,R.A.Y+3);
       P:=System.New(PChessPiece,Init(R,S,Change.Dest));
      End;
      kEnPassant:Begin
       SquareToLocal(EPCapture,R.A,Size.Y);
       R.Assign(R.A.X,R.A.Y,R.A.X+6,R.A.Y+3);
       P:=System.New(PChessPiece,Init(R,S,EPCapture));
      End;
     End;
     PChessBoard(Owner)^.InsertPiece(P,P^.Location);
    End;
   End
    else
   If(Kind=kCastling)and(PieceType.Piece=pRook)and(Word(RookDest)=Word(Location))Then MoveToSquare(RookSource);
   cmFindPiece:If Event.InfoWord=Word(Location)Then ClearEvent(Event);
  End;
  evBroadcast:Case(Event.Command)of
   cmRegisterSave:PCollection(Event.InfoPtr)^.Insert(@Self);
  End;
 End;
End;

Procedure TChessPiece.MoveToSquare;Var Point:TPoint;Begin
 PChessBoard(Owner)^.MovePiece(@Self,Location,ALocation);
 Location:=ALocation;
 SquareToLocal(Location,Point,Owner^.Size.Y);
 MoveTo(Point.X,Point.Y);
End;

Function TChessPiece.PerformMove;Var Result:TChessError;Begin
 PerformMove:=Ya;Result:=PChessBoard(Owner)^.ValidateMove(C);
 Case(Result)of
  ceOK:Views.Message(Owner,evMove,cmSubmitMove,@C);
  ceAmbiguousMove:Begin
   C.Piece:=GetPromotionPiece;
   Views.Message(Owner,evMove,cmSubmitMove,@C);
  End;
  Else PerformMove:=No;
 End;
End;

procedure TChessPiece.RawDraw;Var Color:Word;Begin
 If(PieceType.Color=cBlack)Then Color:=$0404 else Color:=$0505;
 If(InJeopardy)Then Inc(Color,$0202);
 Color:=GetColor(Color);
 XOfs:=PiecePicture[PieceType.Piece][Line].x;
 XLen:=Length(PiecePicture[PieceType.Piece][Line].s);
 If XLen>0Then MoveStr(B[BufPos+XOfs],PiecePicture[PieceType.Piece][Line].s,Color);
End;

Procedure TChessPiece.SnapToSquare;Var S:TLocation;P:TPoint;C:TChange;Begin
 P.X:=Origin.X+(Size.X shr 1);P.Y:=Origin.Y+(Size.Y shr 1);
 PointInSquare(P,S);
 C.Piece:=pEmpty;C.Source:=Location;C.Dest:=S;
 If Not PerformMove(C)Then Begin
  SquareToLocal(Location,P,Owner^.Size.Y);
  MoveTo(P.X,P.Y);
 End;
 PChessBoard(Owner)^.DrawSurface;
End;

Procedure TChessPiece.Store;Begin
 Inherited Store(S);
 S.Write(PieceType,SizeOf(PieceType)+SizeOf(TLocation));
End;

Const
 ChessPalettes:Array[apColor..apMonochrome]of string[Length(CChessAppColor)] =
    (CChessAppColor,CChessAppBlackWhite,CChessAppMonochrome);
 ConfigSignature:Array[0..33]of Char='Chess Config'#26#0;
 ConfigName='CHESS.CFG';

Function TTimeLabel.GetPalette;Const P:String[Length(CTimeLabel)]=CTimeLabel;Begin
 If(Link<>Nil)and(Link^.Options and ofSelectable<>0)Then GetPalette:=Inherited GetPalette
						    Else GetPalette:=@P;
End;

Function TTimeInput.GetPalette;Const P:String[Length(CTimeInput)]=CTimeInput;Begin
 If Options and ofSelectable<>0Then GetPalette:=Inherited GetPalette
			       Else GetPalette:=@P;
End;

Procedure TTimeInput.SetOpt;Begin
 If(Enable)Then Options:=Options or AOptions
	   else Options:=Options and not AOptions;
 DrawView;
End;

Procedure TTimeSettings.MovedTo;Begin
 Inherited MovedTo(Item);
 Views.Message(Owner,evCommand,cmTimeOptChg,Pointer(Item));
End;

Procedure TTimeSettings.Press;Begin
 Inherited Press(Item);
 Views.Message(Owner,evCommand,cmTimeOptChg,Pointer(Item));
End;

Procedure TTimeSettings.SetData;Begin
 Inherited SetData(Rec);
 Views.Message(Owner,evCommand,cmTimeOptChg,Pointer(Value));
End;

Constructor TSettingsDlg.Load;Begin
 Inherited Load(S);
 GetSubViewPtr(S,TurnLabel);
 GetSubViewPtr(S,GameLabel);
 GetSubViewPtr(S,TurnInput);
 GetSubViewPtr(S,Gameinput);
 GetSubViewPtr(S,Minutes);
 GetSubViewPtr(S,Seconds);
End;

Procedure TSettingsDlg.EnableSet;Begin
 GameInput^.SetOpt(ofSelectable,Game);
 GameLabel^.DrawView;
 Minutes^.DrawView;
 TurnInput^.SetOpt(ofSelectable,Turn);
 TurnLabel^.DrawView;
 Seconds^.DrawView;
End;

Function TSettingsDlg.GetPalette;Const P:String[Length(CSettingsDlg)]=CSettingsDlg;Begin
 GetPalette:=@P;
End;

Procedure TSettingsDlg.HandleEvent;Begin
 Inherited HandleEvent(Event);
 If(Event.What=evCommand)and(Event.Command=cmTimeOptChg)Then Begin
  Case(Event.InfoInt)of
   0:ShowSet(Ya,No);
   1:ShowSet(No,Ya);
   2:EnableSet(No,No);
   3:EnableSet(No,No);
   else Exit;
  End;
  ClearEvent(Event);
 End;
End;

Procedure TSettingsDlg.ShowSet;Begin
 GameInput^.SetOpt(ofSelectable,No);
 TurnInput^.SetOpt(ofSelectable,No);
 GameLabel^.SetState(sfVisible,Game);
 Minutes^.SetState(sfVisible,Game);
 GameInput^.SetState(sfVisible,Game);
 TurnLabel^.SetState(sfVisible,Turn);
 Seconds^.SetState(sfVisible,Turn);
 TurnInput^.SetState(sfVisible,Turn);
 EnableSet(Game,Turn);
End;

Procedure TSettingsDlg.Store;Begin
 Inherited Store(S);
 PutSubViewPtr(S,TurnLabel);
 PutSubViewPtr(S,GameLabel);
 PutSubViewPtr(S,TurnInput);
 PutSubViewPtr(S,Gameinput);
 PutSubViewPtr(S,Minutes);
 PutSubViewPtr(S,Seconds);
End;

Function CreateSettingsDlg:PDialog;Var Dlg:PSettingsDlg;R:TRect;Control,Labl,Histry:PView;Begin
 R.Assign(0,0,56,15);
 System.New(Dlg,Init(R,'Ajustements'));
 With Dlg^do Begin
  Options:=Options or ofCentered;
  R.Assign(3,3,26,7);
  Control:=System.New(PTimeSettings,Init(R,
   NewSItem('Limit ~g~ame time',
   NewSItem('Limit t~u~rn time',
   NewSItem('~M~atch user''s time',
   NewSItem('~N~o time limit',Nil))))));
  Insert(Control);
  R.Assign(2,2,24,3);
  Labl:=System.New(PLabel,Init(R, 'Time limit selections',Control));
  Dlg^.Insert(Labl);
  R.Assign(14,9,22,10);
  GameInput:=System.New(PTimeInput,Init(R,6));
  GameInput^.SetValidator(System.New(PRangeValidator,Init(1,600)));
  With GameInput^.Validator^do Options:=Options or voTransfer;
  Insert(GameInput);
  R.Assign(2,9,12,10);
  GameLabel:=System.New(PTimeLabel,Init(R,'Gam~e~ time',GameInput));
  Insert(GameLabel);
  R.Assign(22,9,26,10);
  Minutes:=System.New(PTimeLabel,Init(R,'min',GameInput));
  Insert(Minutes);
  R.Assign(14,9,22,10);
  TurnInput:=System.New(PTimeInput,Init(R,6));
  TurnInput^.SetValidator(System.New(PRangeValidator,Init(1,36000)));
  With TurnInput^.Validator^do Options:=Options or voTransfer;
  Insert(TurnInput);
  R.Assign(2,9,12,10);
  TurnLabel:=System.New(PTimeLabel,Init(R,'Tu~r~n time',TurnInput));
  Insert(TurnLabel);
  R.Assign(22,9,26,10);
  Seconds:=System.New(PTimeLabel,Init(R,'sec',TurnInput));
  Insert(Seconds);
  R.Assign(28,3,53,8);
  Control:=System.New(PCheckboxes,Init(R,
   NewSItem('Show ~a~ttacks',
   NewSItem('Show ~j~eopardies',
   NewSItem('Show ~b~est-line',
   NewSItem('Right click ~q~ueries',
   NewSItem('T~h~ink ahead',Nil)))))));
  PCluster(Control)^.Value:=0;
  Insert(Control);
  R.Assign(27,2,33,3);
  Labl:=System.New(PLabel,Init(R,'Hints',Control));
  Insert(Labl);
  R.Assign(28,10,53,11);
  Control:=System.New(PRadioButtons,Init(R,
   NewSItem('~U~n     ',
   NewSItem('~D~eux',Nil))));
  PCluster(Control)^.Value:=0;
  Insert(Control);
  R.Assign(27,9,35,10);
  Labl:=System.New(PLabel,Init(R,'Joueurs',Control));
  Insert(Labl);
  R.Assign(31,12,41,14);
  Control:=System.New(PButton,Init(R,'O~K~',cmOK,bfDefault));
  Insert(Control);
  Inc(R.A.X,12); Inc(R.B.X,12);
  Control:=System.New(PButton,Init(R, 'Annule',cmCancel,bfNormal));
  Insert(Control);
  SelectNext(No);
 End;
 CreateSettingsDlg:=Dlg;
End;

Const TotalDayTime=$0017FE7F;

Function CurrentTicks:Longint;Begin;CurrentTicks:=MemL[Seg0040:$6C]End;
Function PastMidnight:Bool;Begin;PastMidnight:=Mem[Seg0040:$70]<>0;End;

Constructor TChessTimer.Init;Begin
 Status:=tsStopped;TimeAtStart:=0;TotalTime:=0;MarkTime:=0;
End;

Constructor TChessTimer.Load;Begin
 S.Read(Status,SizeOf(Status)+SizeOf(Longint));
 S.Read(MarkTime,SizeOf(Longint));
End;

Function TChessTimer.AddTo;Begin
 AddTo:=GetCurrentTicks+ATimer^.GetCurrentTicks;
End;

Procedure TChessTimer.Clear;Begin
 Stop;
 TotalTime:=0;
End;

Function TChessTimer.GetCurrentTicks;Begin
 If(Status=tsRunning)Then GetCurrentTicks:=TotalTime+TicksSinceStart
		     else GetCurrentTicks:=TotalTime;
End;

Function TChessTimer.GetMarkTime;Begin
 If(Status=tsRunning)Then GetMarkTime:=MarkTime+TicksSinceStart
		     else GetMarkTime:=MarkTime;
End;

Procedure TChessTimer.Mark;Begin;MarkTime:=0;End;

Procedure TChessTimer.Start;Begin
 If(Status=tsStopped)Then Begin;Status:=tsRunning;TimeAtStart:=CurrentTicks;End;
End;

Procedure TChessTimer.Stop;Begin
 If(Status=tsRunning)Then Begin
  Status:=tsStopped;Inc(TotalTime,TicksSinceStart);Inc(MarkTime,TicksSinceStart)
 End;
End;

Procedure TChessTimer.Store;Begin
 S.Write(Status,SizeOf(Status)+SizeOf(Longint));
 S.Write(MarkTime,SizeOf(Longint));
End;

Function TChessTimer.TicksSinceStart;Var Ticks,TickDif:Longint;Begin
 Ticks:=CurrentTicks;
 If(PastMidnight)Then TickDif:=TotalDayTime-TimeAtStart+Ticks
		 else TickDif:=Ticks-TimeAtStart;
 TicksSinceStart:=TickDif;
End;

Procedure ConvertTicks(TotalTicks:Longint;Var Hours,Minutes,Seconds,Ticks:Word);Var Temp:Longint;Begin
 Hours:=TotalTicks div 65520;Temp:=TotalTicks mod 65520;
 Minutes:=Temp div 1092;Temp:=Temp mod 1092;Seconds:=Temp div 91*5;
 Temp:=Temp mod 91;Inc(Seconds,Temp div 18);Ticks:=((Temp mod 18)*18)mod 100;
End;

Procedure Wait(Ticks:LongInt);Var StartTime,StopTime:Longint;Begin
 StartTime:=CurrentTicks;StopTime:=StartTime+Ticks;
 If(StopTime>TotalDayTime)Then StopTime:=TotalDayTime;
 Repeat Until CurrentTicks>=StopTime;
End;

Function LoadGameHandle(CH:Word):Bool;Begin
 If(CH>=1)and(CH<=MaxGames)and(GameList[CH].Magic=gmGameMagic)Then Begin
  LoadGameHandle:=Ya;CCHandle:=CH;CC:=GameList[CCHandle];
 End
  else
 LoadGameHandle:=No;
End;

Procedure StoreGameHandle;Begin;GameList[CCHandle]:=CC;End;

Function OppColor(Color:TColor):TColor;Begin
 If(Color=cWhite)Then OppColor:=cBlack else OppColor:=cWhite;
End;

Procedure ICoordToECoord(ICoord:Byte;Var Location:TLocation);Begin
 If ICoord and$88<>0Then Begin;Location.X:=0;Location.Y:=0;End
		    else Begin;Location.X:=ICoord and$F+1;Location.Y:=ICoord shr 4+1;End;
end;

Function ECoordToICoord(const Location:TLocation):Byte;Begin
 ECoordToICoord:=(Location.X-1)or(Location.Y-1)shl 4;
End;

Procedure ChangeToMoveType(Const Change:TChange;Var IMove:MoveType);Begin
 With Change,IMove do Begin
  If Source.X<>0Then Old:=ECoordToICoord(Change.Source)else Old:=$08;
  If Dest.X<>0Then New1:=ECoordToICoord(Dest)else New1:=$08;
  MovPiece:=PieceType(Piece); Spe:=No; Content:=Empty;
 End;
End;

Procedure MoveTypeToTMove(Const IMove:MoveType;Var EMove:TMove);

 Procedure GenCastLocation(New1:SquareType;Var CastLocation,CornerLocation:SquareType);Begin
  If New1 and 7>=4Then Begin;CastLocation:=New1-1;CornerLocation:=New1+1;End
		  else Begin;CastLocation:=New1+1;CornerLocation:=New1-2;End;
 End;

Var EpLocation:SquareType; CastLocation,CornerLocation:SquareType;
Begin
 With IMove,EMove do Begin
  Change.Piece:=TPiece(MovPiece);
  ICoordToECoord(Old,Change.Source);
  ICoordToECoord(New1,Change.Dest);
  Contents:=TPiece(Content); Capture:=Content<>Empty;
  If Not(Spe)Then Kind:=kNormal else
  If(MovPiece=King)Then Begin
   Kind:=kCastling;
   GenCastLocation(New1,CastLocation,CornerLocation);
   ICoordToECoord(CornerLocation,RookSource);
   ICoordToECoord(CastLocation,RookDest);
  End
   else
  If(MovPiece=Pawn)Then Begin
   Capture:=Ya;Kind:=kEnPassant;EpLocation:=(New1 and 7)+(Old and$70);
   ICoordToECoord(EpLocation,EPCapture);
  End
   else
  Kind:=kPawnPromote;
 End;
End;

Function NewGame(Var GameHandle:Word):TChessError;Var X:Int;Begin
 NewGame:=ceOK;GameHandle:=0;X:=0;
 Repeat Inc(X)Until(X>MaxGames)or(GameList[X].Magic<>gmGameMagic);
 If(X>MaxGames)Then Begin
  NewGame:=ceTooManyGames;
  Exit;
 End;
 CCHandle:=X;GameHandle:=X;CC:=GameList[CCHandle];
 FillClr(CC,SizeOf(TGameData));
 With CC do Begin
  Magic:=gmGameMagic;Level:=Normal;AverageTime:=15000;MaxLevel:=MaxPly;
  InitBoard;
  Player:=White;Opponent:=Black;ProgramColor:=White;
  ResetMoves;
  UseLib:=200;MovTab[-1].Content:=King;
  InitChessTime;
  MoveNo:=0;
  ClearHint;
  PlayerMove:=ZeroMove;Nodes:=0;
  Clock.Init;
  Clock.Reset;
  Clock.SetLimit(180);
  State:=[];
  AllocateTask(20000);
  Spawn(DoGameTask);
 End;
 StoreGameHandle;
End;

Function DisposeGame(CH:Word):TChessError;Begin
 DisposeGame:=ceInvalidHandle;
 If LoadGameHandle(CH)Then Begin
  DisposeGame:=ceOK;
  DisposeTask;
  GameList[CCHandle].Magic:=0;CCHandle:=0;
 End;
End;

Procedure CalcLocation(X,Y:Char;Var Location:TLocation);Begin
 If(X in['A'..'H'])and(Y in['1'..'8'])Then Begin
  Location.X:=Byte(X)-Byte('A')+1;Location.Y:=Byte(Y)-Byte('1')+1;
 End
  else
 Begin;Location.X:=0;Location.Y:=0;End;
End;

Function ParseMove(Move:PChar;Var Change:TChange):TChessError;Var APiece:TPiece;Begin
 ParseMove:=ceInvalidSyntax;
 With Change do Begin
  Source.X:=0;Dest.X:=0;Piece:=pEmpty;
  Case StrLen(Move)of
   4:Begin { Deux positions (e2e4) }
    CalcLocation(UpCase(Move[0]),Move[1],Change.Source);
    If Source.X=0Then Exit;
    CalcLocation(UpCase(Move[2]),Move[3], Change.Dest);
   End;
   3:Begin { Piäce et position (Pe4) }
    CalcLocation(UpCase(Move[1]),Move[2],Change.Dest);
    For APiece:=Low(TPiece)to High(TPiece)do If UpCase(Move[0])=PieceLetterS[APiece]Then Begin
     Piece:=APiece;
     Break;
    End;
    If(Piece=pEmpty)Then Exit;
   End;
   2:CalcLocation(UpCase(Move[0]),Move[1],Change.Dest); { Seulement position (e4) }
  End;
  If Dest.X=0Then Exit;
 End;
 ParseMove:=ceOk;
End;

Function RetractMove(CH:Word;Const Move:TMove):TChessError;Begin
 RetractMove:=ceInvalidHandle;
 If not LoadGameHandle(CH)Then Exit;
 With CC do TakeBackMove(MovTab[Depth]);
 RetractMove:=ceOk;
 StoreGameHandle;
End;

Function SubmitMove(CH:Word;Const Change:TChange):TChessError;Var Move:MoveType;Result:TChessError;Begin
 SubmitMove:=ceInvalidHandle;
 If not LoadGameHandle(CH)Then Exit;
 ChangeToMoveType(Change,Move);
 Result:=MoveCheck(Move);
 If(Result=ceOK)Then Message(tmEnterMove);
 SubmitMove:=Result;
 StoreGameHandle;
End;

Function VerifyMove(CH:Word;Const Change:TChange):TChessError;Var Move:MoveType;Begin
 VerifyMove:=ceInvalidHandle;
 If Not LoadGameHandle(CH)Then Exit;
 ChangeToMoveType(Change,Move);
 VerifyMove:=MoveCheck(Move);
End;

Function ComputerMove(CH:Word;TimeLimit:LongInt):TChessError;Begin
 ComputerMove:=ceInvalidHandle;
 If not LoadGameHandle(CH)Then Exit;
 With CC do Begin
  Clock.SetLimit(TimeLimit);
  Clock.Reset;
  Message(tmFindMove);
 End;
 ComputerMove:=ceOk;
 StoreGameHandle;
End;

Function ForceMove(CH:Word):TChessError;Begin
 ForceMove:=ceInvalidHandle;
 If Not LoadGameHandle(CH)Then Exit;
 CC.Clock.SetLimit(0);
 ForceMove:=ceOk;
 StoreGameHandle;
End;

Function FuncThinkAhead(CH:Word):TChessError;Begin
 FuncThinkAhead:=ceInvalidHandle;
 If not LoadGameHandle(CH)Then Exit;
 Message(tmThinkAhead);
 FuncThinkAhead:=ceOk;
 StoreGameHandle;
End;

Function AbortSearch(CH:Word):TChessError;Begin
 AbortSearch:=ceInvalidHandle;
 If Not LoadGameHandle(CH)Then Exit;
 Message(tmAbort);
 AbortSearch:=ceOk;
 StoreGameHandle;
End;

Function CalcSearchStatus:TSearchStatus;Begin
 With CC do Begin
  If(GameOver in State)Then CalcSearchStatus:=ssGameOver else
  If(Analysis in State)Then CalcSearchStatus:=ssMoveSearch else
  If(OppAnalysis in State)Then CalcSearchStatus:=ssThinkAhead
			  else CalcSearchStatus:=ssComplete;
 End;
End;

Function Think(CH:Word;TimeLimit:LongInt;Var Status:TSearchStatus):TChessError;Begin
 Think:=ceInvalidHandle;
 If Not LoadGameHandle(CH)Then Exit;
 With CC do Begin
  TaskTimer.SetLimit(TimeLimit);
  TaskTimer.Reset;
  TaskTimer.Start;
  Message(tmResume);
  Status:=CalcSearchStatus;
 End;
 Think:=ceOk;
 StoreGameHandle;
End;

Function SetBoard(CH:Word;Const ABoard:TBoard):TChessError;Begin
 SetBoard:=ceInvalidHandle;
 If Not LoadGameHandle(CH)Then Exit;
 SetBoard:=ceOk;
 StoreGameHandle;
End;

Function SetPlayer(CH:Word;APlayer:TColor):TChessError;Begin
 SetPlayer:=ceInvalidHandle;
 If Not LoadGameHandle(CH)Then Exit;
 With CC do Begin
  Player:=ColorType(APlayer);Opponent:=ColorType(Byte(APlayer)xor 1);
 End;
 SetPlayer:=ceOk;
 StoreGameHandle;
End;

Function MakeChange(CH:Word;Color:TColor;Const Change:TChange):TChessError;Begin
 MakeChange:=ceInvalidHandle;
 If Not LoadGameHandle(CH)Then Exit;
 MakeChange:=ceOk;
End;

Function GetChessStatus(CH:Word;Var Count:Int):TChessStatus;Var Check,PossibleMove,CheckMate:Bool;NumMoves:Int;Begin
 GetChessStatus:=csNormal;
 If Not LoadGameHandle(CH)Then Exit;
 With CC do Begin
  CheckMate:=No;Inc(Depth);PossibleMove:=No;
  InitMovGen;
  Repeat
   MovGen;
   If(NextMove.MovPiece<>Empty)Then If Not IllegalMove(NextMove)Then PossibleMove:=Ya;
  Until(NextMove.MovPiece=Empty)or PossibleMove;
  Dec(Depth);
  Check:=Attacks(Opponent,PieceTab[Player,0].ISquare);
  If Not(PossibleMove)Then Begin
   If(Check)Then GetChessStatus:=csCheckMate else GetChessStatus:=csStaleMate;
  End
   else
  If(Check)Then GetChessStatus:=csCheck else
  If FiftyMoveCnt>=100Then GetChessStatus:=csFiftyMoveRule else
  If Repetition(No)>=3Then GetChessStatus:=csRepetitionRule else
  If HintEvalu>=MateValue-DepthFactor*16Then Begin
   GetChessStatus:=csMateFound;
   Count:=(MateValue-HintEvalu+$40)div(DepthFactor*2);
  End
   else
  If(-25500<HintEvalu)and(HintEvalu<-$880)Then GetChessStatus:=csResigns;
 End;
End;

Function GetSearchStatus(CH:Word):TSearchStatus;Begin
 GetSearchStatus:=ssComplete;
 If not LoadGameHandle(CH)Then Exit;
 GetSearchStatus:=CalcSearchStatus;
End;

Function GetLastMove(CH:Word;Var Move:TMove):TChessError;Begin
 GetLastMove:=ceInvalidHandle;
 If not LoadGameHandle(CH)Then Exit;
 With CC do MoveTypeToTMove(MovTab[Depth],Move);
 GetLastMove:=ceOk;
End;

Function GetHintMove(CH:Word;Var Move:TMove):TChessError;Begin
 GetHintMove:=ceInvalidHandle;
 If Not LoadGameHandle(CH)Then Exit;
 With CC do MoveTypeToTMove(HintLine[0],Move);
 GetHintMove:=ceOk;
End;

Function MoveToStr(Const Move:TMove;Var Str:Array of Char):TChessError;Begin
 MoveToStr:=ceOk;Str[0]:=#0;
 If(High(Str)>=6)and(Move.Change.Piece<>pEmpty)Then With Move do Case(Kind)of
  kCastling:Begin
   If(Change.Source.X>Change.Dest.X)Then StrCopy(PChar(@Str),'O-O-O')
				    else StrCopy(PChar(@Str),'O-O');
  End;
  kNormal,kPawnPromote,kEnPassant:Begin
   Str[0]:=PieceLetterS[Change.Piece];
   Str[1]:=Chr(Byte('a')+Change.Source.X-1);
   Str[2]:=Chr(Byte('1')+Change.Source.Y-1);
   If(Capture)Then Str[3]:='x'else Str[3]:='-';
   Str[4]:=Chr(Byte('a')+Change.Dest.X-1);
   Str[5]:=Chr(Byte('1')+Change.Dest.Y-1);
   Str[6]:=#0;
  End;
 End
  else
 MoveToStr:=ceOutOfMemory;
end;

Function GetBoard(CH:Word;Var ABoard:TBoard):TChessError;Var I,J:Int;Index:Word;Begin
 GetBoard:=ceInvalidHandle;
 If Not LoadGameHandle(CH)Then Exit;
 With CC do For I:=Low(ABoard)to High(ABoard)do
  For J:=Low(ABoard[I])to High(ABoard[I])do With ABoard[J,I]do
 Begin
  Index:=(I-Low(ABoard))shl 4or(J-Low(ABoard[I]));
  Piece:=TPiece(Board[Index].Piece);Color:=TColor(Board[Index].Color);
 End;
 GetBoard:=ceOk;
End;

Function GetPlayer(CH:Word):TColor;Begin
 GetPlayer:=cWhite;
 If Not LoadGameHandle(CH)Then Exit;
 GetPlayer:=TColor(CC.Player);
End;

Function GetCurrentMove(CH:Word;Var Move:TMove):TChessError;Begin
 GetCurrentMove:=ceInvalidHandle;
 If Not LoadGameHandle(CH)Then Exit;
 GetCurrentMove:=ceOk;
End;

Function GetMainLine(CH:Word;Var Value:Int;Var Line:Array of TMove):TChessError;Var I:Int;Begin
 GetMainLine:=ceInvalidHandle;
 If not LoadGameHandle(CH)Then Exit;
 I:=0;
 With CC do Begin
  While(I<High(Line))and(MainLine[I].MovPiece<>Empty)do Begin
   MoveTypeToTMove(MainLine[I],Line[I]);
   Inc(I);
  End;
  Value:=MainEvalu;
 End;
 FillClr(Line[I],SizeOf(Line[I]));
 GetMainLine:=ceOk;
End;

Function GetValidMoves(CH:Word;Change:TChange;Var Moves:Array of TMove):TChessError;Var I,J,K:Int;Move:MoveType;Begin
 GetValidMoves:=ceInvalidHandle;
 If Not LoadGameHandle(CH)Then Exit;
 ChangeToMoveType(Change,Move);
 I:=0;
 With CC do Begin
  Inc(Depth);KeyMove:=ZeroMove;
  InitMovGen;
  Repeat
   MovGen;
   If(NextMove.MovPiece<>Empty)and
    ((NextMove.MovPiece=Move.MovPiece)or(Move.MovPiece=Empty))and
    ((NextMove.New1=Move.New1)or(Move.New1 and$88<>0))and
    ((NextMove.Old=Move.Old)or(Move.Old and$88<>0))and Not IllegalMove(NextMove)Then
   Begin
    MoveTypeToTMove(NextMove,Moves[I]);
    Inc(I);
   End;
  Until(NextMove.MovPiece=Empty)or(I>High(Moves));
  If I>High(Moves)Then Begin
   Dec(I);GetValidMoves:=ceOutOfMemory;
  End
   else
  GetValidMoves:=ceOK;
  FillClr(Moves[I],SizeOf(Moves[I]));
  Dec(Depth);
 End;
End;

Function GetNodes(CH:Word):LongInt;Begin
 If Not LoadGameHandle(CH)Then Exit;
 GetNodes:=CC.Nodes;
End;

Procedure EnterOppMove;Begin
 AdjustMoves;
 EnterKeyMove;
 StoreMoves;
 Exclude(CC.State,MovePending);
End;

Procedure RecordFindMove;Begin
 With CC do Begin
  MovTab[0]:=MainLine[0];
  Move(MainLine[1],HintLine[0],Sizeof(MainLine)-Sizeof(MoveType));
  HintEvalu:=MainEvalu;
  If(MovTab[0].MovPiece=Empty)Then Begin
   HintLine[0]:=ZeroMove;
   Include(State,GameOver);
   Exit;
  End;
  EnterMove(MovTab[Depth+1]);
  StoreMoves;
  PlayerMove:=ZeroMove;
  Exclude(State,Analysis);
 End;
End;

Procedure StartMove;Var Result:Int;Dep:DepthType;Msg:Word;Begin
 Include(CC.State,Analysis);
 Exclude(CC.State,OppAnalysis);
 Repeat Msg:=Message(tmComplete)Until Msg in[tmResume,tmAbort];
 If(Msg=tmAbort)Then Begin
  Exclude(CC.State,Analysis);
  Exit;
 End;
 AdjustMoves;
 CalcLibNo;
 With CC do Begin
  Depth:=0;
  If LibNo>0Then Begin
   Include(State,InLibrary);
   FindOpeningMove;
  End
   else
  Begin
   Exclude(State,InLibrary);
   FindMove(MaxLevel);
  End;
  Depth:=-1;
  If(Analysis in State)Then RecordFindMove;
 End;
End;

Procedure ThinkAhead;Var Msg:Word;Begin
 With CC do Begin
  If(HintLine[0].MovPiece=Empty)Then Exit;
  Exclude(State,Analysis);
  Include(State,OppAnalysis);
  Repeat Msg:=Message(tmComplete)Until Msg in[tmResume,tmAbort];
  If(Msg=tmAbort)Then Begin
   Exclude(State,OppAnalysis);
   Exit;
  End;
  AdjustMoves;
  MovTab[Depth+1]:=HintLine[0];
  MakeMove(MovTab[Depth+1]);
  StoreMoves;
  AdjustMoves;
  Depth:=0;
  FindMove(MaxLevel);
  Depth:=-1;
  If(MovePending in State)Then Begin
   TakeBackMove(MovTab[Depth]);
   EnterOppMove;
   Exclude(State,OppAnalysis);
   Repeat Msg:=Message(tmFindMove)Until Msg in[tmFindMove,tmAbort];
   If(Msg<>tmAbort)Then StartMove;
  End
   else
  If(Analysis in State)Then RecordFindMove else TakeBackMove(MovTab[Depth]);
  Exclude(State,OppAnalysis);
 End;
End;

Procedure DoGameTask;Begin
 Repeat Case Message(tmComplete)of
  tmEnterMove:EnterOppMove;
  tmFindMove:StartMove;
  tmThinkAhead:ThinkAhead;
  tmTerminate:Exit;
 End;Until No;
End;

Type FileType=0..7;RankType=0..7;

Const
  PieceValue:Array[Empty..Pawn]of Int=(0,$1000,$900,$4C0,$300,$300,$100);
  Tolerance=8;
  DistAn:Array[0..7]of Int=(3,2,1,0,0,1,2,3);
  PawnRank:Array[RankType]of Int=(0,0,0,2,4,8,30,0);
  PassPawnRank:Array[RankType]of Int=(0,0,10,20,40,60,70,0);
  PawnFileFactor:Array[FileType]of Int=(0,0,2,5,6,2,0,0);
  CastValue:Array[CastDirType]of Int=(4,32);
  ExchangeValue=32;
  IsolatedPawn=20;
  DoublePawn=8;
  SidePawn=6;
  ChainPawn=3;
  CoverPawn=3;
  NotMovePawn=3;
  BishopBlockValue=20;
  RookBehindPassPawn=16;
  SquareRankValue:Array[RankType]of Byte=(0,0,0,0,1,2,4,4);

Type SetofFile=Byte;
 PawnBitRec=Record One,Dob:SetofFile;End;
 PawnBitType=Array[ColorType]of PawnBitRec;

Const FileBitTab:Array[FileType]of SetofFile=(1,2,4,8,$10,$20,$40,$80);

Function PiecePosVal(Piece:PieceType;Color:ColorType;Square:SquareType):Int;Begin
 PiecePosVal:=PieceValue[Piece]+CC.PVTable[Color,Piece,Square];
End;

Var PawnStrDob,PawnStrIso:Array[0..255]of Byte;

Procedure InitPawnStrTables;Var I:Int;

 Function BitCount(B:SetOFFile):Int;Assembler;ASM
  XOR AX,AX
  MOV DL,B
  MOV CX,8
  CLC
@@1:
  SHR DL,1
  JNC @@2
  INC AX
@@2:
  JZ @@3
  LOOP @@1
@@3:
 END;

Begin
 For I:=0to 255do Begin
  PawnStrDob[I]:=BitCount(I)*DoublePawn;PawnStrIso[I]:=BitCount(I)*IsolatedPawn;
 End;
End;

Function PawnStrVal(Var PB:PawnBitRec):Int;Near;Assembler;ASM
 XOR AX,AX
 LES DI,PB
 MOV AL,ES:[DI].PawnBitRec.One
 MOV CX,AX
 MOV BX,AX
 SHR CX,1
 SHL BX,1
 OR  CX,BX
 NOT CX
 MOV BX,AX
 AND BX,CX
 MOV AL,ES:[DI].PawnBitRec.Dob
 MOV SI,AX
 MOV AL,BYTE PTR PawnStrDob[SI]
 ADD AL,BYTE PTR PawnStrIso[BX]
 ADC AH,0
 AND BL,ES:[DI].PawnBitRec.Dob
 ADD AL,BYTE PTR PawnStrIso[BX]
 ADC AH,0
 ADD AL,BYTE PTR PawnStrIso[BX]
 ADC AH,0
 NEG AX
END;

Function FindMove(MaxLevel:Int):Int;
Var RootValue,TotalMaterial,PawnTotalMaterial,Material:Int;
    MaterialLevel:0..60; PawnBit:Array[-1..MaxPly]of PawnBitType;
    Mating:Bool;

 Procedure CalcPVTable;Type PawnTabType=Array[RankType]of SetofFile;
 Var PawnTab:Array[ColorType]of PawnTabType;
     PawnFileTab,Bit,OpPassTab,BehindOpPass,LeftSideTab,RightSideTab,
     SideTab,LeftChainTab,RightChainTab,ChainTab,LeftCoverTab,
     RightCoverTab:SetofFile;
     AttackValue:Array[ColorType,SquareType]of 0..120;
     PVControl:Array[ColorType,Rook..Bishop,SquareType]of 0..250;
     LosingColor:ColorType; PosVal,AttVal:Int; Line:FileType;
     Rank,Row:RankType; Dist,KingDist:0..14; Cast:CastType;
     Direct:Bool; Cnt,StrVal:Int; Color,OppColor:ColorType;
     PieceCount:PieceType; Square:SquareType; Dir:DirType;
     Sq:EdgeSquareType; Temp,Temp2:Int; TempColor:ColorType;
 Begin
  Mating:=No;TotalMaterial:=0;PawnTotalMaterial:=0;Material:=0;
  With CC do Begin
   For Square:=0to$77 do If Square and$88=0Then With Board[Square]do
    If(Piece<>Empty)Then If(Piece<>King)Then Begin
     Temp:=PieceValue[Piece];TotalMaterial:=TotalMaterial+Temp;
     If(Piece=Pawn)Then Inc(PawnTotalMaterial,PieceValue[Pawn]);
     If(Color=White)Then Temp:=-Temp;
     Dec(Material,Temp);
    End;
    MaterialLevel:=Max(0,TotalMaterial-$2000)div$100;
    If Material<0Then LosingColor:=White else LosingColor:=Black;
    Mating:=((TotalMaterial-Abs(Material))div 2<=PieceValue[Bishop]*2)and(Abs(Material)>=PieceValue[Rook]-PieceValue[Bishop]);
    For Rank:=0to 7do For Line:=0to 7do Begin
     Square:=Rank shl 4+Line;
     AttVal:=Max(0,8-3*(DistAn[Rank]+DistAn[Line]));
     For Color:=White to(Black)do Begin
      AttackValue[Color,Square]:=SquareRankValue[Rank]*3*(MaterialLevel+8)shr 5+AttVal;
      Square:=Square xor $70;
     End;
    End;
    For Color:=White to(Black)do Begin
     OppColor:=ColorType(1-Byte(Color));
     CalcCastling(OppColor,Cast);
     If Not(Short in Cast)and(MaterialLevel>0)Then
     With PieceTab[OppColor,0]do For Dir:=0to 7do Begin
      Sq:=ISquare+DirTab[Dir];
      If Sq and$88=0Then AttackValue[Color,Sq]:=AttackValue[Color,Sq]+12*(MaterialLevel+8)shr 5;
     End;
    End;
    For Square:=$77 downto 0do If Square and$88=0Then
     For Color:=White to(Black)do For PieceCount:=Rook to(Bishop)do PVControl[Color,PieceCount,Square]:=0;
    For Square:=$77 downto 0do If Square and$88=0Then For Color:=White to(Black)do Begin
     For Dir:=7downto 0do Begin
      If Dir<4Then PieceCount:=Rook else PieceCount:=Bishop;
      Cnt:=0;Sq:=Square;Direct:=Ya;
      Repeat
       Inc(Sq,DirTab[Dir]);
       If Sq and$88<>0Then Break;
       Temp:=AttackValue[Color,Sq];
       If(Direct)Then Inc(Cnt,Temp)else Inc(Cnt,Temp shr 1);
       With Board[Sq]do If(Piece <> Empty)Then
	If(Piece<>PieceCount)and(Piece<>Queen)Then Direct:=No;
      Until Board[Sq].Piece=Pawn;
      Inc(PVControl[Color,PieceCount,Square],Cnt shr 2);
     End;
    End;
    For Square:=$77 downto 0do If Square and$88=0Then Begin
     For Color:=White to(Black)do Begin
      OppColor:=ColorType(1-Byte(Color));Line:=Square and 7;Row:=Square shr 4;Rank:=Row;
      If(Color=Black)Then Rank:=7-Rank;
      Dist:=DistAn[Rank]+DistAn[Line];
      With PieceTab[OppColor,0]do KingDist:=Abs(Square shr 4-ISquare shr 4)+(Square-ISquare)and 7;
      For PieceCount:=King to(Pawn)do Begin
       PosVal:=0;
       If Mating and(PieceCount<>Pawn)Then Begin
	If(PieceCount=King)Then If(Color=LosingColor)Then Begin
	 PosVal:=128-16*DistAn[Rank]-12*DistAn[Line];
	 if DistAn[Rank]=3Then Dec(PosVal,16);
	End
	 else
	Begin
	 PosVal:=128-4*KingDist;
	 If(DistAn[Rank]>=2)or(DistAn[Line]=3)Then Dec(PosVal,16);
	End;
       End
	else
       Begin
	Temp:=PVControl[Color,Rook,Square];Temp2:=PVControl[Color,Bishop,Square];
	Case(PieceCount)of
	 King:If MaterialLevel<=0Then PosVal:=-2*Dist;
	 Queen:PosVal:=(Temp+Temp2)shr 2;
	 Rook:PosVal:=Temp;
	 Bishop:PosVal:=Temp2;
	 Knight:Begin
	  Cnt:=0;
	  For Dir:=0to 7do Begin
	   Sq:=Square+KnightDir[Dir];
	   If Sq and$88=0Then Inc(Cnt,AttackValue[Color,Sq]);
	  End;
	  PosVal:=Cnt shr 1-Dist*3;
	 End;
	 Pawn:If(Rank<>0)and(Rank<>7)Then PosVal:=PawnRank[Rank]+PawnFileFactor[Line]*(Rank+2)-12;
	End;
       End;
       PVTable[Color,PieceCount,Square]:=PosVal;
      End;
     End;
    End;
    For Color:=White to(Black)do For Rank:=0to 7do PawnTab[Color,Rank]:=0;
    For Square:=$77 downto 0do If Square and$88=0Then With Board[Square]do If(Piece=Pawn)Then Begin
     Rank:=Square shr 4;
     If(Color=Black)Then Rank:=7-Rank;
     PawnTab[Color,Rank]:=PawnTab[Color,Rank]or FileBitTab[Square and 7];
    End;
    For Color:=White to(Black)do With PawnBit[-1,Color]do Begin
     One:=0;Dob:=0;
     For Rank:=1to 6do Begin
      Temp:=PawnTab[Color,Rank];Dob:=Dob or One and Temp;One:=One or Temp;
     End;
    End;
    RootValue:=PawnStrVal(PawnBit[-1,Player])-PawnStrVal(PawnBit[-1,Opponent]);
    For Color:=White to(Black)do Begin
     OppColor:=ColorType(1-Byte(Color));PawnFileTab:=0;LeftSideTab:=0;
     RightSideTab:=0;OpPassTab:=$FF;BehindOpPass:=0;
     For Rank:=1to 6do Begin
      OpPassTab:=OpPassTab and Not(PawnFileTab or LeftSideTab or RightSideTab);
      BehindOpPass:=BehindOpPass or(OpPassTab and PawnTab[OppColor,7-Rank]);
      LeftChainTab:=LeftSideTab;RightChainTab:=RightSideTab;
      PawnFileTab:=PawnTab[Color,Rank];LeftSideTab:=(PawnFileTab shl 1)and$FF;
      RightSideTab:=(PawnFileTab shr 1)and$FF;SideTab:=LeftSideTab or RightSideTab;
      ChainTab:=LeftChainTab or RightChainTab;Temp:=PawnTab[Color,Succ(Rank)];
      LeftCoverTab:=(Temp shl 1)and$FF;RightCoverTab:=(Temp shr 1)and$FF;
      Sq:=Rank shl 4;If(Color=Black)Then Sq:=Sq xor$70;Bit:=1;
      While Bit<>0do Begin
       StrVal:=0;
       If Bit and SideTab<>0Then StrVal:=SidePawn else
       If Bit and ChainTab<>0Then StrVal:=ChainPawn;
       If Bit and LeftCoverTab<>0Then Inc(StrVal,CoverPawn);
       If Bit and RightCoverTab<>0Then Inc(StrVal,CoverPawn);
       If Bit and PawnFileTab<>0Then Inc(StrVal,NotMovePawn);
       Inc(PVTable[Color,Pawn,Sq],StrVal);
       If(MaterialLevel<=0)or(OppColor<>ProgramColor)Then Begin
	If Bit and OpPassTab<>0Then Inc(PVTable[OppColor,Pawn,Sq],PassPawnRank[7-Rank]);
	If Bit and BehindOpPass<>0Then Begin
	 Temp:=Sq xor$10;
	 For TempColor:=Black to(White)do Begin
	  Inc(PVTable[TempColor,Rook,Sq],RookBehindPassPawn);
	  If Rank=6Then Inc(PVTable[TempColor,Rook,Temp],RookBehindPassPawn);
	 End;
	End;
       End;
       Sq:=Succ(Sq);Bit:=(Bit shl 1)and$FF;
      End;
     End;
    End;
    For Sq:=3to 4do Begin
     With Board[Sq+$10]do
      If(Piece=Pawn)and(Color=White)Then Dec(PVTable[White,Bishop,Sq+$20],BishopBlockValue);
     With Board[Sq+$60]do
      If(Piece=Pawn)and(Color=Black)Then Dec(PVTable[Black,Bishop,Sq+$50],BishopBlockValue);
    End;
    For Square:=$77 downto 0do If Square and $88=0Then
     With Board[Square]do If(Piece<>Empty)Then If(Color=Player)Then
      Inc(RootValue,PiecePosVal(Piece,Player,Square))
     Else
      Dec(RootValue,PiecePosVal(Piece,Opponent,Square));
  End;
 End;

 Function DecPawnStrVal(Color:ColorType;Line:FileType):Int;Var Temp:Int;Begin
  With PawnBit[CC.Depth,Color]do Begin
   Temp:=Not FileBitTab[Line];One:=One and Temp or Dob;Dob:=Dob and Temp;
  End;
  DecPawnStrVal:=PawnStrVal(PawnBit[CC.Depth,Color])-PawnStrVal(PawnBit[Pred(CC.Depth),Color]);
 End;

 Function MovePawnStrVal(Color:ColorType;New1,Old:FileType):Int;Var Temp,Temp2:Int;Begin
  With PawnBit[CC.Depth,Color]do Begin
   Temp:=FileBitTab[New1]; Temp2:=not FileBitTab[Old];
   Dob:=Dob or One and Temp; One:=One and Temp2 or Dob or Temp;
   Dob:=Dob and Temp2;
  End;
  MovePawnStrVal:=PawnStrVal(PawnBit[CC.Depth,Color])-PawnStrVal(PawnBit[Pred(CC.Depth),Color]);
 End;

 Function StateValu(MoveIt:MoveType):Int;Var Value:Int;CastSquare,CornerSquare,EpSquare:SquareType;Begin
  With CC,MoveIt do Begin
   Value:=0;
   If(Spe)Then If(MovPiece=King)Then Begin
    GenCastSquare(New1,CastSquare,CornerSquare);
    Value:=PiecePosVal(Rook,Player,CastSquare)-PiecePosVal(Rook,Player,CornerSquare);
    If(New1>Old)Then Inc(Value,CastValue[Short])else Inc(Value,CastValue[Long]);
   End
    else
   If(MovPiece=Pawn)Then Begin
    EpSquare:=New1-PawnDir[Player];Value:=PiecePosVal(Pawn,Opponent,EpSquare)
   End
    else
   Value:=PiecePosVal(MovPiece,Player,Old)-PiecePosVal(Pawn,Player,Old)+DecPawnStrVal(Player,Old and 7);
   If(Content<>Empty)Then Begin
    Inc(Value,PiecePosVal(Content,Opponent,New1));
    If Abs(MainEvalu)>=$100Then If(Content<>Pawn)Then
     If(ProgramColor=Opponent)=(MainEvalu>=0)Then Dec(Value,ExchangeValue);
   End;
   PawnBit[Depth]:=PawnBit[Pred(Depth)];
   If(MovPiece=Pawn)and((Content<>Empty)or Spe)Then
    Inc(Value,MovePawnStrVal(Player,New1 and 7,Old and 7));
   If(Content=Pawn)or Spe and(MovPiece=Pawn)Then
    Dec(Value,DecPawnStrVal(Opponent,New1 and 7));
   StateValu:=Value+PiecePosVal(MovPiece,Player,New1)-PiecePosVal(MovPiece,Player,Old);
  End;
 End;

 Var KillingMove:Array[0..MaxPly,0..1]of MoveType;
     CheckTab:Array[-1..MaxPly]of Bool;
     PassedPawn:Array[-2..MaxPly]of EdgeSquareType;

 Procedure ClearKillMove;Const Rank7:Array[ColorType]of SquareType=($60,$10);
 Var Dep:DepthType;Col:ColorType;Sq:SquareType;i:Byte;Begin
  FillClr(KillingMove,SizeOf(KillingMove));
  CheckTab[-1]:=No; PassedPawn[-2]:=-1; PassedPawn[-1]:=-1;
  For Col:=White to(Black)do For Sq:=Rank7[Col]to Rank7[Col]+7do
  With CC,Board[Sq]do If(Piece=Pawn)and(Color=Col)Then If(Col=Player)Then
   PassedPawn[-2]:=Sq
  else
   PassedPawn[-1]:=Sq;
 End;

 Var SkipSearch:Bool;

 Procedure CallSmallTalk;Var SearchStateDepth:DepthType;StoredMove:MoveType;Msg:Word;OpAn:Bool;

  Procedure GetProgramState;Var OldPlayer:ColorType;Begin
   With CC do Begin
    SearchStateDepth:=Depth;
    While Depth>0do Begin
     Dec(Depth);OldPlayer:=Opponent;Opponent:=Player;Player:=OldPlayer;
     Perform(MovTab[Depth],Ya);
    End;
    Dec(Depth);
    If(OpAn)Then TakeBackMove(MovTab[Depth]);
   End;
  End;

  Procedure GetSearchState;Var OldPlayer:ColorType;Begin
   With CC do Begin
    If(OpAn)Then MakeMove(MovTab[Depth+1]);
    Inc(Depth);
    While(Depth<SearchStateDepth)do Begin
     Perform(MovTab[Depth],No);
     OldPlayer:=Player; Player:=Opponent; Opponent:=OldPlayer; Inc(Depth);
    End;
   End;
  End;

  Function WaitFor(Send,Receive:Word):Word;Var Msg:Word;Begin
   Repeat Msg:=Message(Send)Until Msg in[tmAbort,Receive];
   WaitFor:=Msg;
  End;

 Begin
  With CC do Begin
   If(TaskTimer.TimeExpired)Then Begin
    OpAn:=OppAnalysis in State;
    GetProgramState;
    StoredMove:=MovTab[Depth+1]; Msg:=Message(tmTimeExpired);
    Case(Msg)of
     tmEnterMove:Begin
      SkipSearch:=Ya;
      Include(State,MovePending);
      If(OppAnalysis in State)and EqMove(KeyMove,StoredMove)Then Begin
       Exclude(State,MovePending);
       Exclude(State,OppAnalysis);
       SkipSearch:=No;
       EnterKeyMove;
       Repeat Until Message(tmFindMove)=tmFindMove;
       Include(State,Analysis);
       If(WaitFor(tmFindMove,tmResume)<>tmAbort)Then Clock.Start
	else
       Begin
	Exclude(State,Analysis);
	SkipSearch:=Ya;
       End;
      End;
     End;
     tmAbort:Begin
      Exclude(State,Analysis);
      Exclude(State,OppAnalysis);
      SkipSearch:=Ya;
     End;
     tmResume:SkipSearch:=No;
    End;
    GetSearchState;
   End;
  End;
 End;

 Type InfType=Record PrincipVar:Bool;Value,Evaluation:Int;End;
 Var StartInf:InfType; AlphaWindow,RepeatEvalu:Int;

 Function Search(Alpha,Beta,Ply:Int;Inf:InfType;Var BestLine:LineType):Int;
 Var Line:LineType; CaptureSearch:Bool; MaxVal,NextPly:Int;
  NextInf:InfType; ZeroWindow:Bool; MovGenType:(Main,SpecialCap,Kill,Normal);

  Procedure UpdateKill(BestMove:MoveType);Begin
   With CC,BestMove do If(MovPiece<>Empty)Then Begin
    If(MovTab[Depth-1].MovPiece=Empty)or(New1<>MovTab[Depth-1].New1)Then
     If(KillingMove[Depth,0].MovPiece=Empty)or EqMove(BestMove,KillingMove[Depth,1])Then Begin
     KillingMove[Depth,1]:=KillingMove[Depth,0];
     KillingMove[Depth,0]:=BestMove;
    End
     else
    If Not EqMove(BestMove,KillingMove[Depth,0])Then KillingMove[Depth,1]:=BestMove;
   End;
  End;

  Function GeneratedBefore:Bool;Var i:0..1;Begin
   GeneratedBefore:=Ya;
   With CC do Begin
    If(MovGenType<>Main)Then Begin
     If EqMove(MovTab[Depth],BestLine[Depth])Then Exit;
     If Not(CaptureSearch)Then If(MovGenType<>Kill)Then
     For i:=0to 1do If EqMove(MovTab[Depth],KillingMove[Depth,i])Then Exit;
    End;
   End;
   GeneratedBefore:=No;
  End;

  Function Cut(CutVal:Int):Bool;Begin
   Cut:=No;
   If(CutVal<=Alpha)Then Begin
    Cut:=Ya;
    If(MaxVal<CutVal)Then MaxVal:=CutVal;
   End;
  End;

  Function Update:Bool;Var Selection:Bool;Label AcceptMove,TakeBackMove,CutMove;Begin
   With CC do Begin
    With MovTab[Depth]do Begin
     Inc(Nodes);NextPly:=Ply-1;
     If(Level=MateSearch)Then Begin
      Perform(MovTab[Depth],No);
      If Attacks(Opponent,PieceTab[Player,0].ISquare)Then Goto TakeBackMove;
      If Depth=0Then Inc(LegalMoves);
      CheckTab[Depth]:=No;PassedPawn[Depth]:=-1;NextInf.Value:=0;NextInf.Evaluation:=0;
      If NextPly<=0Then Begin
       If NextPly=0Then CheckTab[Depth]:=Attacks(Player,PieceTab[Opponent,0].ISquare);
       If Not CheckTab[Depth]Then Begin
	If Cut(NextInf.Value)Then Goto TakeBackMove;
       End;
      End;
      Goto AcceptMove;
     End;
     If MaxDepth<=1Then If CaptureSearch and(Depth>=2)Then
      If Not((Content<MovPiece)or(MovGenType=SpecialCap)or(Old=MovTab[Depth-2].New1))Then Goto CutMove;
     NextInf.Value:=-Inf.Value+StateValu(MovTab[Depth]);
     CheckTab[Depth]:=PieceAttacks(MovPiece,Player,New1,PieceTab[Opponent,0].ISquare);
     If CheckTab[Depth]Then NextPly:=Ply;
     PassedPawn[Depth]:=PassedPawn[Depth-2];
     If(MovPiece=Pawn)Then If(New1<$18)or(New1>=$60)Then Begin
      PassedPawn[Depth]:=New1;
      NextPly:=Ply;
     End;
     Selection:=(NextPly<=0)and not CheckTab[Depth]and(Depth>0);
     If(Selection)Then If Cut(NextInf.Value+0)Then Goto CutMove;
     Perform(MovTab[Depth],No);
     If Attacks(Opponent,PieceTab[Player,0].ISquare)Then Goto TakeBackMove;
     If PassedPawn[Depth]>=0Then With Board[PassedPawn[Depth]]do If(Piece<>Pawn)or(Color<>Player)Then PassedPawn[Depth]:=-1;
     If Depth=0Then Inc(LegalMoves);
     If Depth=0Then Inc(NextInf.Value,Random(4));
     NextInf.Evaluation:=NextInf.Value;
    End;
AcceptMove:
    Update:=No;
    Exit;
TakeBackMove:
    Perform(MovTab[Depth],Ya);
CutMove:
   End;
   Update:=Ya;
  End;

  Function DrawGame:Bool;Var DrawCount:0..4;SearchRepeat:RepeatType;SearchFifty:FiftyType;Begin
   DrawGame:=No;
   With CC do Begin
    If Depth=1Then Begin
     SearchFifty:=FiftyMoveCnt; SearchRepeat:=Repetition(No);
     If SearchRepeat>=3Then Begin;DrawGame:=Ya;NextInf.Evaluation:=0;Exit;End;
     DrawCount:=0;
     If SearchFifty>=96Then DrawCount:=3 else
     If SearchRepeat>=2Then DrawCount:=2 else
     If SearchFifty>=20Then DrawCount:=1;
     Inc(NextInf.Value,(RepeatEvalu shr 2)*DrawCount);
     Inc(NextInf.Evaluation,(RepeatEvalu shr 2)*DrawCount);
    End;
    If Depth>=3Then Begin
     SearchRepeat:=Repetition(Ya);
     If SearchRepeat>=2Then Begin
      DrawGame:=Ya;NextInf.Evaluation:=0;
      Exit;
     End;
    End;
   End;
  End;

  Procedure UpdateBestLine;Begin
   BestLine:=Line;
   With CC do Begin
    BestLine[Depth]:=MovTab[Depth];
    If Depth=0Then Begin
     MainEvalu:=MaxVal;
     If(Level=MateSearch)Then MaxVal:=AlphaWindow;
    End;
   End;
  End;

  Function LoopBody:Bool;Var OldPlayer:ColorType;LastAnalysis:Bool;Label RepeatSearch,NotSearch;Begin
   LoopBody:=No;
   If(GeneratedBefore)Then Exit;
   With CC do Begin
    If(Depth<MaxPly)Then Begin
     Line[Depth+1]:=ZeroMove;
     If(MovGenType=Main)Then Line:=BestLine;
    End;
    NextInf.PrincipVar:=No;ZeroWindow:=No;
    If(Inf.PrincipVar)Then If(MovGenType=Main)Then NextInf.PrincipVar:=BestLine[Depth+1].MovPiece<>Empty
                                              else ZeroWindow:=MaxVal>=Alpha;
RepeatSearch:
    If(Update)Then Exit;
    If(Level=MateSearch)Then If(NextPly<=0)and Not CheckTab[Depth]Then Goto NotSearch;
    If(DrawGame)Then Goto NotSearch;
    If(Depth>=MaxPly)Then Goto NotSearch;
    OldPlayer:=Player;Player:=Opponent;Opponent:=OldPlayer;Inc(Depth);
    If(ZeroWindow)Then NextInf.Evaluation:=-Search(-Alpha-1,-Alpha,NextPly,NextInf,Line)
		  else NextInf.Evaluation:=-Search(-Beta,-Alpha,NextPly,NextInf,Line);
    Dec(Depth);OldPlayer:=Opponent;Opponent:=Player;Player:=OldPlayer;
NotSearch:
    Perform(MovTab[Depth],Ya);
    If(SkipSearch)Then Begin;LoopBody:=Ya;Exit;End;
    LastAnalysis:=Analysis in State;
    CallSmallTalk;
    If(Not SkipSearch)and(Analysis in State)Then SkipSearch:=Clock.TimeExpired;
    If(Analysis in State)and(MaxDepth<=1)Then SkipSearch:=No;
    MaxVal:=Max(MaxVal,NextInf.Evaluation);
    If EqMove(BestLine[Depth],MovTab[Depth])Then UpdateBestLine;
    If(Alpha<MaxVal)Then Begin
     UpdateBestLine;
     If(MaxVal>=Beta)Then Begin;LoopBody:=Ya;Exit;End;
     If(Ply>=2)and(Inf.PrincipVar)and Not(ZeroWindow)Then MaxVal:=Min(MaxVal+Tolerance,Beta-1);
     Alpha:=MaxVal;
     If(ZeroWindow)and Not(SkipSearch)Then Begin
      ZeroWindow:=No;
      Goto RepeatSearch;
     End;
    End;
   End;
   LoopBody:=SkipSearch;
  End;

  Function PawnPromotionGen:Bool;Var Promote:PieceType;Begin
   PawnPromotionGen:=Ya;
   With CC,MovTab[Depth]do Begin
    Spe:=Ya;
    For Promote:=Queen to(Knight)do Begin
     MovPiece:=Promote;
     If(LoopBody)Then Exit;
    End;
    Spe:=No;
   End;
   PawnPromotionGen:=No;
  End;

  Function CapMovGen(NewSq:SquareType):Bool;Var NextSq,Sq:EdgeSquareType;i:IndexType;Begin
   CapMovGen:=Ya;
   With CC,MovTab[Depth]do Begin
    Content:=Board[NewSq].Piece;Spe:=No;New1:=NewSq;MovPiece:=Pawn;NextSq:=New1-PawnDir[Player];
    For Sq:=NextSq-1to NextSq+1do With Board[Sq]do
    If(Sq<>NextSq)and(Sq and$88=0)and(Piece=Pawn)and(Color=Player)Then Begin
     Old:=Sq;
     If(New1<8)or(New1>=$70)Then Begin;If(PawnPromotionGen)Then Exit;End
			    else If(LoopBody)Then Exit;
    End;
    For i:=OfficerNo[Player]downto 0do
    With PieceTab[Player,i]do If(IPiece<>Empty)and(IPiece<>Pawn)and
     PieceAttacks(IPiece,Player,ISquare,NewSq)Then Begin
     Old:=ISquare; MovPiece:=IPiece;
     If(LoopBody)Then Exit;
    End;
   End;
   CapMovGen:=No;
  End;

  Function NonCapMovGen(OldSq:SquareType):Bool;Var First,Last,Dir:DirType;Direction:Int;NewSq:EdgeSquareType;Begin
   NonCapMovGen:=Ya;
   With CC,MovTab[Depth]do Begin
    Spe:=No;Old:=OldSq;MovPiece:=Board[OldSq].Piece;Content:=Empty;
    Case MovPiece of
     King:For Dir:=7downto 0do Begin
      NewSq:=Old+DirTab[Dir];
      If NewSq and$88=0Then If(Board[NewSq].Piece=Empty)Then Begin
       New1:=NewSq;
       If(LoopBody)Then Exit;
      End;
     End;
     Knight:For Dir:=7downto 0do Begin
      NewSq:=Old+KnightDir[Dir];
      If NewSq and$88=0Then If(Board[NewSq].Piece=Empty)Then Begin
       New1:=NewSq;
       If(LoopBody)Then Exit;
      End;
     End;
     Queen,Rook,Bishop:Begin
      First:=7;Last:=0;
      If(MovPiece=Rook)Then First:=3;
      If(MovPiece=Bishop)Then Last:=4;
      For Dir:=First downto(Last)do Begin
       Direction:=DirTab[Dir];NewSq:=Old+Direction;
       While NewSq and$88=0do Begin
	If(Board[NewSq].Piece<>Empty)Then Break;
	New1:=NewSq;
	If(LoopBody)Then Exit;
	NewSq:=New1+Direction;
       End;
      End;
     End;
     Pawn:Begin
      New1:=Old+PawnDir[Player];
      If(Board[New1].Piece=Empty)Then If(New1<8)or(New1>=$70)Then Begin
       If(PawnPromotionGen)Then Exit;
      End
       else
      Begin
       If(LoopBody)Then Exit;
       If(Old<$18)or(Old>=$60)Then Begin
	Inc(New1,New1-Old);
	If(Board[New1].Piece=Empty)Then If(LoopBody)Then Exit;
       End;
      End;
     End;
    End;
   End;
   NonCapMovGen:=No;
  End;

  Function CastlingMovGen:Bool;Var CastDir:CastDirType;Begin
   CastlingMovGen:=Ya;
   With CC,MovTab[Depth]do Begin
    Spe:=Ya;MovPiece:=King;Content:=Empty;
    For CastDir:=Short downto Long do With CastMove[Player,CastDir]do Begin
     New1:=CastNew; Old:=CastOld;
     If KillMovGen(MovTab[Depth])Then If(LoopBody)Then Exit;
    End;
   End;
   CastlingMovGen:=No;
  End;

  Function EpCapMovGen:Bool;Var Sq:EdgeSquareType;Begin
   EpCapMovGen:=Ya;
   With CC,MovTab[Depth-1]do If(MovPiece=Pawn)Then If Abs(New1-Old)>=$20Then Begin
    MovTab[Depth].Spe:=Ya;MovTab[Depth].MovPiece:=Pawn;
    MovTab[Depth].Content:=Empty;MovTab[Depth].New1:=(New1+Old)shr 1;
    For Sq:=New1-1to New1+1do If(Sq<>New1)Then If Sq and $88=0Then Begin
     MovTab[Depth].Old:=Sq;
     If KillMovGen(MovTab[Depth])Then If(LoopBody)Then Exit;
    End;
   End;
   EpCapMovGen:=No;
  End;

  Procedure SearchMovGen;Var Index:IndexType;KillNo:0..1;Begin
   With CC,MovTab[Depth]do Begin
    If(BestLine[Depth].MovPiece<>Empty)Then Begin
     MovTab[Depth]:=BestLine[Depth]; MovGenType:=Main;
     If(LoopBody)Then Exit;
    End;
    With MovTab[Depth-1]do If(MovPiece<>Empty)Then If(MovPiece<>King)Then Begin
     MovGenType:=SpecialCap;
     If CapMovGen(New1)Then Exit;
    End;
    MovGenType:=Kill;
    If Not(CaptureSearch)Then For KillNo:=0to 1do Begin
     MovTab[Depth]:=KillingMove[Depth,KillNo];
     If(MovPiece<>Empty)Then If KillMovGen(MovTab[Depth])Then If(LoopBody)Then Exit;
    End;
    MovGenType:=Normal;
    For Index:=1to PawnNo[Opponent]do
    With PieceTab[Opponent,Index]do If(IPiece<>Empty)Then
    With MovTab[Depth-1]do If(MovPiece=Empty)or(ISquare<>New1)Then If CapMovGen(ISquare)Then Exit;
    If(CaptureSearch)Then If PassedPawn[Depth-2]>=0Then
     With Board[PassedPawn[Depth-2]]do If(Piece=Pawn)and(Color=Player)Then
      If NonCapMovGen(PassedPawn[Depth-2])Then Exit;
    If Not(CaptureSearch)Then Begin
     If(CastlingMovGen)Then Exit;
     For Index:=PawnNo[Player]downto 0do With PieceTab[Player,Index]do
      If(IPiece<>Empty)Then If NonCapMovGen(ISquare)Then Exit;
    End;
    If(EpCapMovGen)Then Exit;
   End;
  End;

  Label Stop;
  Begin
   With CC do Begin
    CaptureSearch:=(Ply<=0)and Not CheckTab[Depth-1];
    If(CaptureSearch)Then Begin
     MaxVal:=-Inf.Evaluation;
     If(Alpha<MaxVal)Then Begin
      Alpha:=MaxVal;
      If(MaxVal>=Beta)Then Goto Stop;
     End;
    End
     else
    MaxVal:=-(LoseValue-Depth*DepthFactor);
    SearchMovGen;
    If(SkipSearch)Then Goto Stop;
    If MaxVal=-(LoseValue-Depth*DepthFactor)Then
    If Not Attacks(Opponent,PieceTab[Player,0].ISquare)Then Begin
     MaxVal:=0;
     Goto Stop;
    End;
    UpdateKill(BestLine[Depth]);
   End;
  Stop:
   Search:=MaxVal;
  End;

  Function CallSearch(Alpha,Beta:Int):Int;Var MaxVal:Int;Begin
   With CC do Begin
    StartInf.PrincipVar:=MainLine[0].MovPiece<>Empty;
    LegalMoves:=0;
    MaxVal:=Search(Alpha,Beta,MaxDepth,StartInf,MainLine);
    If LegalMoves=0Then MainEvalu:=MaxVal;
    CallSearch:=MaxVal;
   End;
  End;

  Function TimeUsed:Bool;Begin
   TimeUsed:=No;
   With CC do If(Analysis in State)Then TimeUsed:=Clock.TimeExpired;
  End;

Var MaxVal:Int;CalcPVTime:Real;
Begin
 With CC do Begin
  Clock.Start;
  Nodes:=0; SkipSearch:=No;
  ClearKillMove;
  CalcPVTable;
  CalcPVTime:=Clock.GetElapsedTime;
  StartInf.Value:=-RootValue; StartInf.Evaluation:=-RootValue; MaxDepth:=0;
  MainLine[0]:=ZeroMove; MainEvalu:=RootValue; AlphaWindow:=MaxInt;
  Repeat
   If MaxDepth<=1Then RepeatEvalu:=MainEvalu;
   AlphaWindow:=Min(AlphaWindow,MainEvalu-$80);
   If(Level=MateSearch)Then Begin
    AlphaWindow:=$6000;
    If MaxDepth>0Then Inc(MaxDepth);
   End;
   Inc(MaxDepth);
   MaxVal:=CallSearch(AlphaWindow,$7F00);
   If(MaxVal<=AlphaWindow)and Not(SkipSearch)and(Level<>MateSearch)and(LegalMoves>0)Then Begin
    MainEvalu:=AlphaWindow; MaxVal:=CallSearch(-$7F00,AlphaWindow-Tolerance*2);
    LegalMoves:=2;
   End;
  Until(SkipSearch)or(TimeUsed)or(MaxDepth>=MaxLevel)or(LegalMoves<=1)or(Abs(MainEvalu)>=MateValue-24*DepthFactor);
  Clock.Stop;
 End;
End;

Procedure AllocateTask(Size:Word);Var P:Pointer;Begin
 P:=MemAllocSeg(Size);
 If(P=Nil)Then Exit;
 With CC do Begin
  GameStack.SSeg:=Seg(P^);GameStack.Size:=Size;
  GameStack.SPtr:=Size-2;AppStack.SSeg:=SSeg;
 End;
End;

Procedure DisposeTask;Begin
 With CC.GameStack do If SSeg<>0Then FreeMem(Ptr(SSeg,0),Size);
 FillChr(CC.GameStack,0,SizeOf(CC.GameStack));
End;

Procedure TerminateTask(Dummy:Word);Far;Assembler;ASM
 MOV SS,CC.AppStack.SSeg
 MOV SP,CC.AppStack.SPtr
 MOV BP,SP
END;

Function Message(Msg:Word):Word;Assembler;ASM
 MOV AX,Msg
 MOV BX,SS
 CMP BX,CC.AppStack.SSeg
 JNE @@1
 MOV CC.AppStack.SPtr,SP
 MOV SS,CC.GameStack.SSeg
 MOV SP,CC.GameStack.SPtr
 JMP @@2
@@1:
 MOV CC.GameStack.SPtr,SP
 MOV SS,CC.AppStack.SSeg
 MOV SP,CC.AppStack.SPtr
@@2:
 MOV BP,SP
END;

Procedure Spawn(Proc:TSpawnProc);Assembler;ASM
 MOV AX,SS
 CMP AX,CC.AppStack.SSeg
 JNE @@1
 LES DI,DWORD PTR CC.GameStack.TTaskInfo.SPtr
 STD
 MOV AX,Seg TerminateTask
 STOSW
 MOV AX,Offset TerminateTask
 STOSW
 MOV AX,Proc.Word[2]
 STOSW
 MOV AX,Proc.Word
 STOSW
 MOV AX,DI
 STOSW
 CLD
 MOV CC.GameStack.TTaskInfo.SPtr,AX
 PUSH 0
 CALL Message
@@1:
END;

Procedure InitChessTime;Begin
 CC.ChessTime[White].Init;
 CC.ChessTime[Black].Init;
 CC.Running:=No;
End;

Procedure StopChessTime;Begin
 With CC do Begin
  If(Running)Then ChessTime[RunColor].Stop;
  Running:=No;
 End;
End;

Procedure StartChessTime(Color:ColorType);Begin
 StopChessTime;
 With CC do Begin
  RunColor:=Color;
  Running:=Ya;
  ChessTime[RunColor].Start;
 End;
End;

Function IllegalMove(Move:MoveType):Bool;Begin
 Perform(Move,DoIt);
 With CC do IllegalMove:=Attacks(Opponent,PieceTab[Player,0].ISquare);
 Perform(Move,UndoIt);
End;

Procedure MakeMove(Move:MoveType);Begin
 With CC do Begin
  Inc(Depth);Inc(MoveNo);
  Perform(Move,DoIt);
  ProgramColor:=Opponent;Opponent:=Player;Player:=ProgramColor;
 End;
End;

Procedure TakeBackMove(Move:MoveType);Begin
 With CC do Begin
  ProgramColor:=Opponent;Opponent:=Player;Player:=ProgramColor;
  Perform(Move,UndoIt);
  MoveNo:=Pred(MoveNo);Depth:=Pred(Depth);
 End;
End;

Procedure ResetMoves;Begin
 With CC do Begin;Depth:=-1;MovTab[-1]:=ZeroMove;End;
End;

Procedure AdjustMoves;Var i:Int;Begin
 If CC.Depth<>-1Then With CC do Begin
  For i:=Depth downto Back do MovTab[i-Succ(Depth)]:=MovTab[i];
  Depth:=-1;
 End;
End;

Procedure StoreMoves;Var i:int;Begin
 With CC do Begin
  Dec(Depth);
  For i:=Back to(Depth)do MovTab[i]:=MovTab[Succ(i)];
  MovTab[Back]:=ZeroMove;
 End;
End;

Procedure ClearHint;Begin
 With CC do Begin
  HintLine[0]:=ZeroMove;HintEvalu:=0;
 End;
End;

Procedure EnterMove(Move:MoveType);Begin
 MakeMove(Move);
 StartChessTime(CC.ProgramColor);
End;

Procedure EnterKeyMove;Begin
 With CC do Begin
  MovTab[Succ(Depth)]:=KeyMove;PlayerMove:=KeyMove;
  ClearHint;
  EnterMove(MovTab[Succ(Depth)]);
 End;
End;

Function CalcSquare(a,b:Char):EdgeSquareType;Begin
 If(a in['A'..'H'])and(b in['1'..'8'])Then CalcSquare:=(Byte(b)-Byte('1'))*16+(Byte(a)-Byte('A'))
				      else CalcSquare:=-1;
End;

Function MoveCheck(Const Move:MoveType):TChessError;Begin
 With CC do Begin
  Inc(Depth);KeyMove:=ZeroMove;
  InitMovGen;
  Repeat
   MovGen;
   If(NextMove.MovPiece<>Empty)and
     ((NextMove.MovPiece=Move.MovPiece)or(Move.MovPiece=Empty))and
     ((NextMove.New1=Move.New1)or(Move.New1 and$88<>0))and
     ((NextMove.Old=Move.Old)or(Move.Old and$88<>0))Then Begin
    If(KeyMove.MovPiece=Empty)Then KeyMove:=NextMove
     else
    Begin
     If(NextMove.MovPiece=Pawn)and(KeyMove.MovPiece<>Pawn)Then KeyMove:=NextMove else
     If Not((NextMove.MovPiece<>Pawn)and(KeyMove.MovPiece=Pawn))Then Begin
      Dec(Depth);
      MoveCheck:=ceAmbiguousMove;
      Exit;
     End;
    End;
   End;
  Until NextMove.MovPiece=Empty;
  Dec(Depth);
  If(KeyMove.MovPiece=Empty)Then MoveCheck:=ceInvalidMove else
  If IllegalMove(KeyMove)Then MoveCheck:=ceIllegalMove else MoveCheck:=ceOK;
 End;
End;

Const UnPlayMark=$3F;

Type
  POpeningLib=^TOpeningLib;
  TOpeningLib=Array[0..31999]of byte;

Var Openings:POpeningLib;

Procedure PreviousLibNo(Var Lib:Int);Var n:int;Begin
 n:=0;
 Repeat
  Dec(Lib);
  If Openings^[Lib]>=128Then Inc(n);
  If Openings^[Lib]and 64<>0Then Dec(n);
 Until n=0;
End;

Procedure FirstLibNo(Var Lib:Int);Begin
 While Openings^[Lib-1]and 64=0do PreviousLibNo(Lib);
End;

Procedure NextLibNo(Var Lib:Int;Skip:Bool);Var n:int;Begin
 If Openings^[Lib]>=128Then FirstLibNo(Lib)
  else
 Begin
  n:=0;
  Repeat
   If Openings^[Lib]and 64<>0Then Inc(n);
   If Openings^[Lib]>=128Then Dec(n);
   Inc(Lib);
  Until n=0;
  If Skip and(Openings^[Lib]=UnPlayMark)Then FirstLibNo(Lib);
 End;
End;

Procedure CalcLibNo;Var LibDepth:DepthType;Found:Bool;

 Procedure FindNode;Begin
  With CC do Begin
   Inc(LibNo);
   If(Depth>LibDepth)Then Begin
    Found:=Ya;
    Exit;
   End;
   OpCount:=-1;
   InitMovGen;
   Repeat
    Inc(OpCount);
    MovGen;
   Until(NextMove.MovPiece=Empty)or EqMove(NextMove,MovTab[Depth]);
   If(NextMove.MovPiece<>Empty)Then Begin
    While((Openings^[LibNo]and 63)<>OpCount)and(Openings^[LibNo]<128)do NextLibNo(LibNo,No);
    If Openings^[LibNo]and 127=OpCount+64Then Begin
     MakeMove(MovTab[Depth]);
     FindNode;
     TakeBackMove(MovTab[Depth-1]);
    End;
   End;
  End;
 End;

Begin
 With CC do Begin
  LibNo:=0;
  If(Openings=Nil)Then Begin
   UseLib:=200;
   Exit;
  End;
  If(MoveNo<UseLib)Then Begin
   LibDepth:=Depth;
   While(MovTab[Depth].MovPiece<>Empty)do TakeBackMove(MovTab[Depth]);
   Found:=No;
   If(MovTab[Depth].Content=King)Then Begin
    Inc(Depth);
    FindNode;
    Dec(Depth);
   End;
   While(Depth<LibDepth)do MakeMove(MovTab[Depth+1]);
   If(Found)Then UseLib:=200 else Begin;UseLib:=MoveNo;LibNo:=0;End;
  End;
 End;
End;

Procedure FindOpeningMove;Const Weight:Array[0..6]of Byte=(7,10,12,13,14,15,16);Var Cnt,r,p,CountP:Byte;Begin
 r:=Random(17); p:=0;
 While r>=Weight[p]do Inc(p);
 With CC do Begin
  For CountP:=1to p do NextLibNo(LibNo,Ya);
  OpCount:=Openings^[LibNo]and 63;
  InitMovGen;
  For Cnt:=0to(OpCount)do MovGen;
  MainLine[0]:=NextMove;MainLine[1]:=ZeroMove;MainEvalu:=0;MaxDepth:=0;LegalMoves:=0;Nodes:=0;
 End;
End;

Procedure LoadOpening;Const LibFileName='OPENING.LIB';Var LibFile:File of TOpeningLib;Begin
 Assign(LibFile,LibFileName);
 Reset(LibFile);
 If IoResult=0Then Begin
  System.New(Openings);
  Read(LibFile,Openings^);
  System.Close(LibFile);
  Openings^[0]:=$FF;
 End;
End;

Type
  SetOfPiece=Byte;
Const
  BitTab:Array[King..Pawn]of SetOfPiece=(1,2,4,8,$10,$20);

Var
  AttackTab:Array[-$77..$77]of Record PieceSet:SetOfPiece;Direction:Int;End;

Procedure CalcAttackTab;Var Dir:DirType;Sq:Int;i:Byte;Begin
 FillClr(AttackTab,Sizeof(AttackTab));
 For Dir:=7downto 0do Begin
  For i:=1to 7do With AttackTab[DirTab[Dir]*i]do Begin
   If Dir<4Then PieceSet:=BitTab[Queen]+BitTab[Rook]
	   else PieceSet:=BitTab[Queen]+BitTab[Bishop];
   Direction:=DirTab[Dir];
  End;
  With AttackTab[DirTab[Dir]]do Inc(PieceSet,BitTab[King]);
  With AttackTab[KnightDir[Dir]]do Begin
   PieceSet:=BitTab[Knight];
   Direction:=KnightDir[Dir];
  End;
 End;
End;

Function PieceAttacks(APiece:PieceType;AColor:ColorType;ASquare,Square:SquareType):Bool;Var Sq:EdgeSquareType;Begin
 If(APiece=Pawn)Then PieceAttacks:=Abs(Square-ASquare-PawnDir[AColor])=1
  else
 With AttackTab[Square-ASquare]do If PieceSet and BitTab[APiece]<>0Then
  If(APiece=King)or(APiece=Knight)Then PieceAttacks:=Ya
   Else
  Begin
   Sq:=ASquare;
   Repeat Inc(Sq,Direction)Until(Sq=Square)or(CC.Board[Sq].Piece<>Empty);
   PieceAttacks:=Sq=Square;
  End
   else
  PieceAttacks:=No;
End;

Function Attacks(AColor:ColorType;Square:SquareType):Bool;

 Function PawnAttacks(AColor:ColorType;Square:SquareType):Bool;Var Sq:EdgeSquareType;Begin
  PawnAttacks:=Ya; Sq:=Square-PawnDir[AColor]-1;
  If Sq and$88=0Then With CC.Board[Sq]do If(Piece=Pawn)and(Color=AColor)Then Exit;
  Inc(Sq,2);
  If Sq and$88=0Then With CC.Board[Sq]do If(Piece=Pawn)and(Color=AColor)Then Exit;
  PawnAttacks:=No;
 End;

Var i:IndexType;
Begin
 Attacks:=Ya;
 If PawnAttacks(AColor,Square)Then Exit;
 With CC do For i:=OfficerNo[AColor]downto 0do With PieceTab[AColor,i]do
  If(IPiece<>Empty)Then If PieceAttacks(IPiece,AColor,ISquare,Square)Then Exit;
 Attacks:=No;
End;

Procedure CalcCastling(InColor:ColorType;Var Cast:CastType);

 Function Check(Square:SquareType;InPiece:PieceType):Bool;Var Dep:DepthType;Begin
  Check:=No;
  With CC,Board[Square]do If(Piece=InPiece)and(Color=InColor)Then Begin
   Dep:=Depth-1;
   While(MovTab[Dep].MovPiece<>Empty)do Begin
    If(MovTab[Dep].New1=Square)Then Exit;
    Dec(Dep);
   End;
   Check:=Ya;
  End;
 End;

Var Square:SquareType;
Begin
 Square:=0;
 If(InColor=Black)Then Square:=$70;
 Cast:=[];
 If Check(Square+4,King)Then Begin
  If Check(Square,Rook)Then Cast:=Cast+[Long];
  If Check(Square+7,Rook)Then Cast:=Cast+[Short];
 End;
End;

Function RepeatMove(Move:MoveType):Bool;Begin
 With Move do RepeatMove:=(MovPiece<>Empty)and(MovPiece<>Pawn)and(Content=Empty)and not Spe;
End;

Function FiftyMoveCnt:FiftyType;Var Cnt:FiftyType;Begin
 Cnt:=0;
 With CC do While RepeatMove(MovTab[Depth-Cnt])do Inc(Cnt);
 FiftyMoveCnt:=Cnt;
End;

Function Repetition(Immediate:Bool):RepeatType;Var LastDep,CompDep,TraceDep,CheckDep,SameDepth:DepthType;
TraceSq,CheckSq:SquareType; RepeatCount:RepeatType;Label 10;Begin
 With CC do Begin
  Repetition:=1;RepeatCount:=1;SameDepth:=Depth+1;
  CompDep:=SameDepth-4; LastDep:=SameDepth;
  While RepeatMove(MovTab[LastDep-1])and((CompDep<LastDep)or not Immediate)do Dec(LastDep);
  If(CompDep<LastDep)Then Exit;
  CheckDep:=SameDepth;
  Repeat
   Dec(CheckDep);
   CheckSq:=MovTab[CheckDep].New1;
   TraceDep:=CheckDep+2;
   While(TraceDep<SameDepth)do Begin
    If(MovTab[TraceDep].Old=CheckSq)Then Goto 10;
    Inc(TraceDep,2);
   End;
   TraceDep:=CheckDep;TraceSq:=MovTab[TraceDep].Old;
   Repeat
    If(TraceDep-2<LastDep)Then Exit;
    Dec(TraceDep,2);
    With MovTab[TraceDep]do If(TraceSq=New1)Then TraceSq:=Old;
   Until(TraceSq=CheckSq)and(TraceDep<=CompDep+1);
   If(TraceDep<CompDep)Then Begin
    CompDep:=TraceDep;
    If Odd(SameDepth-CompDep)Then Begin
     If(CompDep=LastDep)Then Exit;
     Dec(CompDep);
    End;
    CheckDep:=SameDepth;
   End;
10:If(CheckDep<=CompDep)Then Begin
    Inc(RepeatCount);Repetition:=RepeatCount;
    If(CompDep-2<LastDep)Then Exit;
    SameDepth:=CompDep;Dec(CompDep,2);CheckDep:=SameDepth;
   End;
  Until No;
 End;
End;

Function KillMovGen(Move:MoveType):Bool;Var CastSq:SquareType;Promote:PieceType;CastDir:CastDirType;Cast:CastType;Begin
 KillMovGen:=No;
 With CC,Move do Begin
  If Spe and(MovPiece=King)Then Begin
   CalcCastling(Player,Cast);
   If(New1>Old)Then CastDir:=Short else CastDir:=Long;
   If(CastDir in Cast)Then Begin
    CastSq:=(New1+Old)shr 1;
    If(Board[New1].Piece=Empty)Then If(Board[CastSq].Piece=Empty)Then
     If(New1>Old)or(Board[New1-1].Piece=Empty)Then
      If Not Attacks(Opponent,Old)Then If Not Attacks(Opponent,New1)Then
       If Not Attacks(Opponent,CastSq)Then KillMovGen:=Ya;
   End;
  End
   else
  If Spe and(MovPiece=Pawn)Then Begin
   With MovTab[Depth-1]do If(MovPiece=Pawn)Then If Abs(New1-Old)>=$20Then
   With Board[Move.Old]do If(Piece=Pawn)and(Color=Player)Then
    KillMovGen:=Move.New1=(New1+Old)shr 1;
  End
   else
  Begin
   If(Spe)Then Begin Promote:=MovPiece; MovPiece:=Pawn; End;
   If(Board[Old].Piece=MovPiece)and(Board[Old].Color=Player)and
     (Board[New1].Piece=Content)and((Content=Empty)or(Board[New1].Color=Opponent))Then
    If(MovPiece=Pawn)Then
     If Abs(New1-Old)<$20Then KillMovGen:=Ya
			 else KillMovGen:=Board[(New1+Old)div 2].Piece=Empty
		     Else KillMovGen:=PieceAttacks(MovPiece,Player,Old,New1);
   If(Spe)Then MovPiece:=Promote;
  End;
 End;
End;

Procedure InitMovGen;

 Procedure Generate;Begin
  With CC do Begin;Inc(BufCount);Buffer[BufCount]:=NextMove;End;
 End;

 Procedure PawnPromotionGen;Var Promote:PieceType;Begin
  With CC.NextMove do Begin
   Spe:=Ya;
   For Promote:=Queen to(Knight)do Begin
    MovPiece:=Promote;
    Generate;
   End;
   Spe:=No;
  End;
 End;

 Procedure CapMovGen;Var NextSq,Sq:EdgeSquareType;i:IndexType;Begin
  With CC,NextMove do Begin
   Spe:=No; Content:=Board[New1].Piece; MovPiece:=Pawn;
   NextSq:=New1-PawnDir[Player];
   For Sq:=NextSq-1to NextSq+1do If(Sq<>NextSq)Then If Sq and$88=0Then
    With Board[Sq]do If(Piece=Pawn)and(Color=Player)Then Begin
     Old:=Sq;
     If(New1<8)or(New1>=$70)Then PawnPromotionGen else Generate;
    End;
    For i:=OfficerNo[Player]downto 0do With PieceTab[Player,i]do
     If(IPiece<>Empty)and(IPiece<>Pawn)Then
      If PieceAttacks(IPiece,Player,ISquare,New1)Then Begin
       Old:=ISquare; MovPiece:=IPiece;
       Generate;
      End;
  End;
 End;

 Procedure NonCapMovGen;Var First,Last,Dir:DirType;Direction:Int;NewSq:EdgeSquareType;Begin
  With CC,NextMove do Begin
   Spe:=No;MovPiece:=Board[Old].Piece;Content:=Empty;
   Case(MovPiece)of
    King:For Dir:=7downto 0do Begin
     NewSq:=Old+DirTab[Dir];
     If NewSq and$88=0Then If(Board[NewSq].Piece=Empty)Then Begin
      New1:=NewSq;
      Generate;
     End;
    End;
    Knight:For Dir:=7 downto 0do Begin
     NewSq:=Old+KnightDir[Dir];
     If NewSq and$88=0Then If(Board[NewSq].Piece=Empty)Then Begin
      New1:=NewSq;
      Generate;
     End;
    End;
    Queen,Rook,Bishop:Begin
     First:=7;
     Last:=0;
     If(MovPiece=Rook)Then First:=3;
     If(MovPiece=Bishop)Then Last:=4;
     For Dir:=First downto(Last)do Begin
      Direction:=DirTab[Dir];NewSq:=Old+Direction;
      While NewSq and$88=0do Begin
       If(Board[NewSq].Piece<>Empty)Then Break;
       New1:=NewSq;
       Generate;
       NewSq:=New1+Direction;
      End;
     End;
    End;
    Pawn:Begin
     New1:=Old+PawnDir[Player];
     If(Board[New1].Piece=Empty)Then
      If(New1<8)or(New1>=$70)Then PawnPromotionGen
       else
      Begin
       Generate;
       If(Old<$18)or(Old>=$60)Then Begin
	Inc(New1,New1-Old);
	If(Board[New1].Piece=Empty)Then Generate;
       End;
      End;
    End;
   End;
  End;
 End;

Var CastDir:CastDirType;Sq:EdgeSquareType;Index:IndexType;
Begin
 With CC,NextMove do Begin
  BufCount:=0;BufPnt:=0;
  For Index:=1to PawnNo[Opponent]do With PieceTab[Opponent,Index]do If(IPiece<>Empty)Then Begin
   New1:=ISquare;
   CapMovGen;
  End;
  Spe:=Ya;MovPiece:=King;Content:=Empty;
  For CastDir:=Short downto(Long)do With CastMove[Player,CastDir]do Begin
   New1:=CastNew; Old:=CastOld;
   If KillMovGen(NextMove)Then Generate;
  End;
  For Index:=PawnNo[Player]downto 0do With PieceTab[Player,Index] do If(IPiece<>Empty)Then Begin
   Old:=ISquare;
   NonCapMovGen;
  End;
  With MovTab[Depth-1]do If(MovPiece=Pawn)Then If Abs(New1-Old)>=$20Then Begin
   NextMove.Spe:=Ya; NextMove.MovPiece:=Pawn; NextMove.Content:=Empty;
   NextMove.New1:=(New1+Old)shr 1;
   For Sq:=New1-1to New1+1do If(Sq<>New1)Then If Sq and$88=0Then Begin
    NextMove.Old:=Sq;
    If KillMovGen(NextMove)Then Generate;
   End;
  End;
 End;
End;

Procedure MovGen;Begin
 With CC do Begin
  If(BufPnt>=BufCount)Then NextMove:=ZeroMove else Begin;Inc(BufPnt);NextMove:=Buffer[BufPnt]End;
 End;
End;

Function EqMove(Var A,B:MoveType):Bool;Begin
 EqMove:=No;
 If(A.MovPiece=B.MovPiece)Then If(A.New1=B.New1)Then If(A.Old=B.Old)Then
  If(A.Content=B.Content)Then If(A.Spe=B.Spe)Then EqMove:=Ya;
end;

Function Min(A,B:Int):Int;Begin If(A<B)Then Min:=A else Min:=B;End;
Function Max(A,B:Int):Int;Begin If(A>B)Then Max:=A else Max:=B;End;

Procedure CalcPieceTab;Var Square:SquareType;Piece1:PieceType;

 Procedure ClearIndex;Var Square:SquareType;Col:ColorType;Index:IndexType;Begin
  With CC do Begin
   For Square:=0to$77 do Board[Square].Index:=16;
   For Col:=White to Black do For Index:=0to 15do PieceTab[Col,Index].IPiece:=Empty;
   PawnNo[White]:=-1; PawnNo[Black]:=-1; OfficerNo:=PawnNo;
  End;
 End;

Begin
 ClearIndex;
 For Piece1:=King to(Pawn)do With CC do Begin
  If(Piece1=Pawn)Then OfficerNo:=PawnNo;
  Square:=0;
  Repeat
   With Board[Square]do If(Piece=Piece1)Then Begin
    Inc(PawnNo[Color]);
    With PieceTab[Color,PawnNo[Color]]do Begin
     IPiece:=Piece1; ISquare:=Square;Index:=PawnNo[Color];
    End;
   End;
   Square:=Square xor$77;
   If Square and 4=0Then If Square>=$70Then Square:=(Square+$11)and$73
				       else Inc(Square,$10);
  Until Square=0;
 End;
End;

Procedure GenCastSquare(New1:SquareType;Var CastSquare,CornerSquare:SquareType);Begin
 If New1 and 7>=4Then Begin;CastSquare:=New1-1;CornerSquare:=New1+1;End
		 else Begin;CastSquare:=New1+1;CornerSquare:=New1-2;End;
End;

Procedure MovePiece(New1,Old:SquareType);Var B:BoardType;Begin
 With CC do Begin
  B:=Board[New1];Board[New1]:=Board[Old];Board[Old]:=B;
  With Board[New1]do PieceTab[Color,Index].ISquare:=New1;
 End;
End;

Procedure DeletePiece(InSquare:SquareType);Begin
 With CC,Board[InSquare]do Begin;Piece:=Empty;PieceTab[Color,Index].IPiece:=Empty;End;
End;

Procedure InsertPiece(InPiece:PieceType;InColor:ColorType;InSquare:SquareType);Begin
 With CC,Board[InSquare],PieceTab[InColor,Index]do Begin
  Piece:=InPiece;Color:=InColor;IPiece:=InPiece;ISquare:=InSquare;
 End;
End;

Procedure ChangeType(NewType:PieceType;InSquare:SquareType);Begin
 With CC,Board[InSquare]do Begin
  Piece:=NewType;
  PieceTab[Color,Index].IPiece:=NewType;
  If(OfficerNo[Color]<Index)Then OfficerNo[Color]:=Index;
 End;
End;

Procedure InitBoard;Var i:0..7;Begin
 With CC do Begin
  FillClr(Board,Sizeof(Board));
  For i:=0to 7do Begin
   InsertPiece(Pieces[i],White,i);
   InsertPiece(Pawn,White,i+$10);
   InsertPiece(Pawn,Black,i+$60);
   InsertPiece(Pieces[i],Black,i+$70);
  End;
 End;
 CalcPieceTab;
End;

Procedure Perform(Move:MoveType;ResetMove:Bool);Var New1,CastSquare,CornerSquare,EpSquare:SquareType;Begin
 With CC,Move do Begin
  If(ResetMove)Then Begin
   MovePiece(Old,New1);
   If(Content<>Empty)Then InsertPiece(Content,Opponent,New1);
  End
   else
  Begin
   If(Content<>Empty)Then DeletePiece(New1);
   MovePiece(New1,Old);
  End;
  If(Spe)Then
   If(MovPiece=King)Then Begin
    GenCastSquare(New1,CastSquare,CornerSquare);
    If(ResetMove)Then MovePiece(CornerSquare,CastSquare)
		 else MovePiece(CastSquare,CornerSquare);
   End
    else
   If(MovPiece=Pawn)Then Begin
    EpSquare:=(New1 and 7)+(Old and$70);
    If(ResetMove)Then InsertPiece(Pawn,Opponent,EpSquare)
		 else DeletePiece(EpSquare);
   End
    else
   If(ResetMove)Then ChangeType(Pawn,Old)else ChangeType(MovPiece,New1);
 End;
End;

Constructor TMoveList.Init;Begin
 Inherited Init(ALimit,ADelta);
 UndoPos:=0;
End;

Constructor TMoveList.Load;Begin
 Inherited Load(S);
 S.Read(UndoPos,SizeOf(UndoPos));
End;

Procedure TMoveList.AddMove;Var I:Int;Begin
 If UndoPos<Count-1Then While UndoPos<Count-1do AtFree(UndoPos+1);
 AtInsert(Count,NewMove(Move));
 UndoPos:=Count-1;
End;

Procedure TMoveList.FreeItem;Begin;DisposeMove(PMove(Item))End;

Function TMoveList.GetItem;Var Move:TMove;Begin
 S.Read(Move,SizeOf(Move));
 GetItem:=NewMove(Move);
End;

Function TMoveList.GetNumMoves;Begin;GetNumMoves:=(UndoPos+1)shr 1;End;

Procedure TMoveList.Purge;Begin
 FreeAll;
 UndoPos:=0;
End;

Procedure TMoveList.PutItem;Begin
 S.Write(PMove(Item)^,SizeOf(TMove));
End;

Procedure TMoveList.Redo;Begin
 If(RedoAvail)Then Begin;Inc(UndoPos);Move:=PMove(At(UndoPos))^End
              else FillClr(Move,SizeOf(Move));
End;

Function TMoveList.RedoAvail;Begin
 RedoAvail:=(Count>0)and(UndoPos<Count-1);
End;

Procedure TMoveList.Store;Begin
 Inherited Store(S);
 S.Write(UndoPos,SizeOf(UndoPos));
End;

Procedure TMoveList.Undo;Begin
 If(UndoAvail)Then Begin;Move:=PMove(At(UndoPos))^;Dec(UndoPos)End
	      else FillClr(Move,SizeOf(Move));
End;

Function TMoveList.UndoAvail;Begin;UndoAvail:=(Count>0)and(UndoPos>=0)End;

Function NewMove(Move:TMove):PMove;Var AMove:PMove;Begin
 GetMem(AMove,SizeOf(TMove));
 AMove^:=Move; NewMove:=AMove;
End;

Procedure DisposeMove(Move:PMove);Begin;FreeMem(Move,SizeOf(TMove))End;
Constructor TStopWatch.Init;Begin;Reset;End;
Procedure TStopWatch.Reset;Begin;StartTime:=0;ElapsedTime:=0;End;
Procedure TStopWatch.Start;Begin;StartTime:=MemL[Seg0040:$6C]End;
Procedure TStopWatch.Resume;Begin;StartTime:=MemL[Seg0040:$6C]End;

Procedure TStopWatch.Stop;Begin
 Update;
 StartTime:=0;
End;

Procedure TStopWatch.Update;Begin
 If LongBool(StartTime)Then Begin
  Inc(ElapsedTime,MemL[Seg0040:$6C]-StartTime);
  Resume;
 End;
End;

Function TStopWatch.GetString;Var Temp:String[20];Begin
 Update;
 System.Str(ElapsedTime,Temp);
 GetString:=Temp;
End;

Function TStopWatch.GetElapsedTime;Begin
 Update;
 GetElapsedTime:=ElapsedTime;
End;

Function TStopWatch.Running;Begin;Running:=StartTime<>0;End;
Procedure TTaskTimer.SetLimit;Begin;TimeLimit:=A;End;

Function TTaskTimer.TimeExpired;Begin
 Update;
 TimeExpired:=ElapsedTime>=TimeLimit;
End;

Function TTaskTimer.TimeRemaining;Begin
 Update;
 TimeRemaining:=TimeLimit-ElapsedTime;
End;

Constructor TChessApp.Init;Begin
 Inherited Init;
 InitScreenMode;
 LoadConfig;
 InitStatusDialog;
 InitChessBoard;
 If(ChessBoard<>Nil)Then Insert(ChessBoard);
 If(StatusDialog<>Nil)Then InsertWindow(StatusDialog);
 RegisterType(RMoveList);
End;

Destructor TChessApp.Done;Begin
 SaveConfig;
 Inherited Done;
End;

Function TChessApp.GetPalette;Begin;GetPalette:=@ChessPalettes[AppPalette]End;

Procedure TChessApp.HandleEvent;Var D:PDialog;Begin
 Inherited HandleEvent(Event);
 Case(Event.What)of
  evCommand:Case(Event.Command)of
   cmSettings:Begin
    D:=CreateSettingsDlg;
    D^.SetData(Settings);
    If(ExecView(ValidView(D))<>cmCancel)Then D^.GetData(Settings);
    Dispose(D,Done);
    ClearEvent(Event);
    With ChessBoard^do Begin
     ResetValidMoves;
     GameMode:=(GameMode and not gmTwoPlay)or Settings.Players;
    End;
   End;
   Else Exit;
  End;
 End;
 ClearEvent(Event);
End;

Procedure TChessApp.Idle;Begin
 Inherited Idle;
 If(ChessBoard<>Nil)Then ChessBoard^.DoThink;
End;

Procedure TChessApp.InitChessBoard;Var R:TRect;Begin
 GetExtent(R);
 Dec(R.B.X,28);
 ChessBoard:=System.New(PChessBoard,Init(R));
End;

Procedure TChessApp.InitMenuBar;Var R:TRect;Begin
 GetExtent(R);
 R.B.Y:=R.A.Y+1;
 R.A.X:=R.B.X-28;
 MenuBar:=System.New(PMenuBar,Init(R,NewMenu(
  NewSubMenu('~J~eux',hcNoContext,NewMenu(
   NewItem('~N~ouveau','',kbNoKey,cmNew,hcNoContext,
   NewItem('~C~harge','F3',kbF3,cmOpen,hcNoContext,
   NewItem('~S~auve','F2',kbF2,cmSave,hcNoContext,
   NewItem('Sauve s~o~us','',kbNoKey,cmSaveAs,hcNoContext,
   NewLine(
   NewItem('~R~un','',kbNoKey,cmRunDemo,hcNoContext,
   NewItem('S~t~op','Alt+T',kbAltT,cmStop,hcNoContext,
   NewLine(
   NewItem('~Q~uit', 'Alt+X',kbAltX,cmQuit,hcNoContext,Nil)))))))))),
  NewSubMenu('~M~ouve',hcNoContext,NewMenu(
   NewItem('~U~ndo','Alt+Bksp',kbAltBack,cmUndo,hcNoContext,
   NewItem('~R~edo','Ctrl+Bksp',kbCtrlBack,cmRedo,hcNoContext,
   NewLine(
   NewItem('Mouve d''~O~rdinateur','Alt+C',kbAltC,cmComputerMove,hcNoContext,
   NewItem('~E~ntrez Mouve...','Alt+E',kbAltE,cmEnterMove,hcNoContext,
   NewItem('~S~how hint','Alt+S',kbAltS,cmShowHint,hcNoContext,Nil))))))),
  NewSubMenu('~O~ptions',hcNoContext,NewMenu(
   NewItem('~A~justements','',kbNoKey,cmSettings,hcNoContext,Nil)),Nil))))));
End;

Procedure TChessApp.InitStatusLine;Var R:TRect;Begin
 GetExtent(R);
 R.A.Y:=R.B.Y-1; R.A.X:=R.B.X-28;
 StatusLine:=System.New(PChessStatusLine,Init(R,NewStatusDef($0,$FFFF,StdStatusKeys(Nil),Nil)));
End;

Procedure TChessApp.InitDesktop;Var R:TRect;Begin
 GetExtent(R);
 R.Grow(0,-1);
 R.A.X:=R.B.X-28; Desktop:=System.New(PDesktop,Init(R));
End;

Procedure TChessApp.InitStatusDialog;Var R:TRect;Begin
 R.Assign(0,0,Desktop^.Size.X,Size.Y-2);
 StatusDialog:=System.New(PStatusDialog,Init(R));
End;

Procedure TChessApp.InitScreenMode;Var I:Wd;B:Byte;Begin
 ShadowSize.X:=2;
 SetScreenMode(ScreenMode and(Not smFont8x8));
 InitVideoDeluxe;
 InitEnv;
 For I:=1to Length(ChessPalettes[apColor])do Begin
  B:=Byte(ChessPalettes[apColor][I]);
  If B and $7F=$7FThen Byte(ChessPalettes[apColor][I]):=(B or $80)and $F0 Else
  If B and $70=$70Then Byte(ChessPalettes[apColor][I]):=B or $80;
 End;
End;

Procedure TChessApp.LoadConfig;Var S:PBufStream;CfgName,Dir,Name,Ext:String;
Test:array[0..SizeOf(ConfigSignature)]of Char; NSettings:TSettings;
TempPalettes:array[apColor..apMonochrome]of String[Length(CChessAppColor)];I:Int;Begin
 Dir:=''; CfgName:=ParamStr(0);
 If CfgName=''Then CfgName:=FSearch('CHESS.EXE',GetEnv('PATH'));
 If CfgName<>''Then FSplit(CfgName,Dir,Name,Ext);
 CfgName:=Dir+ConfigName;
 S:=System.New(PBufStream,Init(CfgName,stOpenRead,1024));
 If(S^.Status=stOK)Then Begin
  S^.Read(Test, SizeOf(ConfigSignature));
  If(S^.Status=stOK)and(StrLComp(ConfigSignature,Test,SizeOf(ConfigSignature))=0)Then Begin
   S^.Read(NSettings,SizeOf(NSettings));
   S^.Read(TempPalettes,SizeOf(TempPalettes));
   LoadIndexes(S^);
   LoadHistory(S^);
   If(S^.Status=stOK)Then Begin
    Settings:=NSettings;
    ConfigFile:=CfgName;
    For I:=apColor to(apMonochrome)do ChessPalettes[I]:=TempPalettes[I];
   End;
  End;
 End;
 Dispose(S,Done);
End;

Procedure TChessApp.SaveConfig;Var S:PBufStream;Begin
 If ConfigFile=''Then ConfigFile:=ConfigName;
 S:=System.New(PBufStream,Init(ConfigFile,stCreate,1024));
 S^.Write(ConfigSignature,SizeOf(ConfigSignature));
 S^.Write(Settings,SizeOf(Settings));
 S^.Write(ChessPalettes,SizeOf(ChessPalettes));
 StoreIndexes(S^);
 StoreHistory(S^);
 Dispose(S,Done);
End;

Var ChessDLL:TChessApp;

BEGIN
 InitSystems(suIsabel);
 LoadOpening;
 FillClr(GameList,SizeOf(GameList));
 CCHandle:=0;
 CalcAttackTab;
 InitPawnStrTables;
 ChessDLL.Init;
 ChessDLL.Run;
 ChessDLL.Done;
 DoneLuxeVideo;
 DoneSystems;
END.