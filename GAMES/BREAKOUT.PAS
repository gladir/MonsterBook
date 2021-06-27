{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                                                             Û
 ³                       B r e a k O u t                       Û
 ³                                                             Û
 ³                            pour                             Û
 ³                                                             Û
 ³     L'ensemble Malte Genesis III & IV: Isabel & Chantal     Û
 ³ Tous droits r‚serv‚ par les Chevaliers de Malte 1990 … 1996 Û
 ³                                                             Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ}

Program BreakOut;

{$I \Source\Chantal\DEF.INC}

Uses {$IFDEF Adele}Adele,{$ELSE}{$IFDEF Chantal}Chantal,{$ENDIF}{$ENDIF}
     Systex,Systems,Video,Mouse,Dials,Arcade,Crt;

Const
 FileNameHighScore='BREAKOUT.HGH';

 Bar:Array[0..9,0..39]of Byte=(
( 0, 0, 0, 0,37,37,35,37,37,37,37,37,37,37,37,37,37,36,35,37,37,37,37,37,37,37,37,37,37,37,37,37,37,37,35,37, 0, 0, 0,0),
( 0, 0,37,37,38,38,35,38,38,38,38,38,38,38,38,38,38,36,35,38,38,38,38,38,38,38,38,38,38,38,38,38,38,38,35,38,37,37, 0,0),
( 0,37,39,39,39,39,35,39,39,39,39,39,39,39,39,39,39,36,35,39,39,39,39,39,39,39,39,39,39,39,39,39,39,39,35,39,39,39,37,0),
( 0,37,39,40,40,40,35,40,35,35,35,35,40,35,35,35,40,36,35,40,35,35,35,35,40,35,35,35,35,35,40,35,35,35,35,40,40,39,37,0),
(37,39,40,41,41,41,35,41,35, 9, 9,35,41,35, 1,35,41,36,35,41,35,12,12,35,41,35,14,14,14,35,41,35, 4,4,35,41,41,40,39,37),
(37,39,40,41,41,41,35,41,35, 9, 9,35,41,35, 1,35,41,36,35,41,35,12,12,35,41,35,14,14,14,35,41,35, 4,4,35,41,41,40,39,37),
( 0,37,39,40,40,40,35,40,35,35,35,35,40,35,35,35,40,36,35,40,35,35,35,35,40,35,35,35,35,35,40,35,35,35,35,40,40,39,37,0),
( 0,37,39,39,39,39,35,39,39,39,39,39,39,39,39,39,39,36,35,39,39,39,39,39,39,39,39,39,39,39,39,39,39,39,35,39,39,39,37,0),
( 0, 0,37,37,38,38,35,38,38,38,38,38,38,38,38,38,38,36,35,38,38,38,38,38,38,38,38,38,38,38,38,38,38,38,35,38,37,37, 0,0),
( 0, 0, 0, 0,37,37,35,37,37,37,37,37,37,37,37,37,37,36,35,37,37,37,37,37,37,37,37,37,37,37,37,37,37,37,35,37, 0, 0, 0,0)
 );
MatrixRobotic:Array[0..15]of Byte=(37,38,39,40,41,42,43,44,43,42,41,40,39,38,37,36);

 BallImg:Array[0..7,0..7]of Byte=(
  ( 0,35,37,37,37,37,35, 0),
  (35,37,37,38,38,37,37,35),
  (36,37,38,39,39,38,37,36),
  (37,38,39,40,40,39,38,37),
  (37,38,39,40,40,39,38,37),
  (36,37,38,39,39,38,37,36),
  (35,37,37,38,38,37,37,35),
  ( 0,35,37,37,37,37,35, 0));

Type
 Location=Object
  X,Y:Int;Visible:Bool;
  Constructor Init(InitX,InitY:Int);
  Procedure Relocate(NewX,NewY:Int);
  Procedure MoveTo(NewX,NewY:Int);Virtual;
  Procedure Show;Virtual;
  Procedure Hide;Virtual;
  Function GetX:Int;
  Function GetY:Int;
  Function IsVisible:Bool;
 End;

 Block=object(Location)
  Color,Width:Int;BChar:Char;
  Constructor Init(InitX,InitY,InitColor,InitWidth:Int;InitChr:Char);
  procedure Show;Virtual;
  procedure Hide;Virtual;
 end;

 Ball=object(Block)
  XVel,YVel:Int;
  Constructor Init(InitX,InitY,InitXVel,InitYVel:Int);
  Function NextX:Int;
  Function NextY:Int;
  Procedure MoveX;
  Procedure MoveY;
  Procedure ReverseX;
  Procedure ReverseY;
  Procedure ChangeXVel(Delta:Int);
 End;

 Brick=Object(Block)
  Value:Int;
  Constructor Init(InitX,InitY,InitColor,InitValue:Int);
  Function GetValue:Int;
 End;

 Counter=Object(Location)
  Value,BaseValue:Int;
  Constructor Init(InitValue,InitX,InitY:Int);
  Procedure Show;Virtual;
  Procedure Hide;Virtual;
  Procedure ShowVal;Virtual;
  Procedure HideVal;Virtual;
  Procedure SetValue(NewValue:Int);
  Procedure Reset;
  Procedure Increment;
  Procedure Decrement;
  Procedure Add(Incr:Int);
  Function Equal(TestValue:Int):Bool;
  Function GetValue:Int;
 End;

 ObstaclePtr=^Obstacle;

 Obstacle=Object(Location)
  Width:Int;Trap:Bool;NextPtr:ObstaclePtr;
  Constructor Init(InitX,InitY,InitWidth:Int;SetTrap:Bool);
  Destructor Done;Virtual;
  Function Collide(var B:Ball):Bool;Virtual;
  Function IsTrap:Bool;Virtual;
  Function GetValue:Int;Virtual;
 End;

 ObstacleList=Object
  Head:Obstacle;Tail:ObstaclePtr;
  Constructor Init;
  Destructor Done;Virtual;
  Procedure Append(NewObstacle:ObstaclePtr);
  Procedure Show;
  Procedure Hide;
  Function CheckCollisions(Var B:Ball;Var Score:Counter):Bool;
 End;

 Paddle=Object(Obstacle)
  Constructor Init(InitX,InitY:Int);
  Destructor Done;Virtual;
  Procedure Show;Virtual;
  Procedure Hide;Virtual;
  Procedure MoveTo(NewX,NewY:Int);Virtual;
  Function Collide(var B:Ball):Bool;virtual;
 End;

 Boundary=Object(Obstacle)
  Constructor Init(InitX,InitY,InitWidth:Int;SetTrap:Bool);
 End;

 LeftBound=Object(Boundary)
  Constructor Init(InitX,InitY,InitWidth:Int;SetTrap:Bool);
  Function Collide(Var B:Ball):Bool;virtual;
 End;

 UpperBound=Object(Boundary)
  Constructor Init(InitX,InitY,InitWidth:Int;SetTrap:Bool);
  Function Collide(Var B:Ball):Bool;Virtual;
 End;

 RightBound=Object(Boundary)
  Constructor Init(InitX,InitY,InitWidth:Int;SetTrap:Bool);
  Function Collide(Var B:Ball):Bool;Virtual;
 end;

 LowerBound=Object(Boundary)
  Constructor Init(InitX,InitY,InitWidth:Int;SetTrap:Bool);
  Function Collide(Var B:Ball):Bool;Virtual;
 End;

 BrickPtr=^Brick;
 BW=Array[1..1000]of Brick;
 WallPtr=^BW;

 Wall=object(Obstacle)
  BrickWall:WallPtr;Height,NumLeft,Value,NCells:Int;
  Constructor Init(InitX,InitY,InitWidth,InitHeight:Int);
  Destructor Done;Virtual;
  Procedure Show;Virtual;
  Procedure Hide;Virtual;
  Function Collide(var B:Ball):Bool;Virtual;
  Function GetValue:Int;Virtual;
  Procedure Reset;
 End;

 HighScoreFile=Array[0..9]of Record
  Name:String[31];Score:Long;Level:Wd;
 End;

Var HighScore:HighScoreFile;
 OldX:Wd;w:Wall;b:Ball;p:Paddle;Speed:Byte;Left:LeftBound;
 Top:UpperBound;Right:RightBound;Bottom:LowerBound;Obstacles:ObstacleList;
 Score:Counter;Balls,X:Int;Finished,FirstGame:Bool;

Procedure ClrCur;Begin PutFillBox(16+OldX,184-8,16+OldX+39,193-8,0)End;
Procedure PutCur;Begin PutSmlImg(16+OldX,184-8,16+OldX+39,193-8,Bar)End;

Procedure _OutTxtXY(X,Y:Wd;S:String;Attr:Byte);Var I:Byte;Begin
 For I:=0to Length(S)-1do SetGCube(X+(I shl 3),Y,S[I+1],Attr)
End;

Procedure InitScr;Var I:Byte;Begin
 For I:=0to 199do Begin
  ClrLnHorImg(0,I,16,8,MatrixRobotic);
  ClrLnHorImg(304-8,I,16,8,MatrixRobotic);
 End;
 PutFillBox(2*8,0,36*8+7,199,0);
 OutTxtXY(16,23*8+2,'POINTAGE:',1);
 OutTxtXY(160,23*8+2,'NIVEAU:',1);
 _OutTxtXY(224,23*8+2,StrW(Speed),9);
End;

Procedure UpDateHighScore;Var I:Byte;TName,Title:String;SP:PChr;BC:Array[0..255]of Chr;Begin
 For I:=0to 9do Begin
  If(Score.Value>=HighScore[I].Score)Then Begin
   If I<9Then MoveRight(HighScore[I],HighScore[I+1],SizeOf(HighScore[0])*(9-I));
   TName:='';
   Case I of
    0: Title:='PremiŠre place des meilleurs';
    1: Title:='DeuxiŠme place des meilleurs';
    2: Title:='TroisiŠme place des meilleurs';
    3: Title:='QuatriŠme place des meilleurs';
    4: Title:='CinquiŠme place des meilleurs';
    5: Title:='SixiŠme place des meilleurs';
    6: Title:='SeptiŠme place des meilleurs';
    7: Title:='HuitiŠme place des meilleurs';
    8: Title:='NeuviŠme place des meilleurs';
    9: Title:='DixiŠme place des meilleurs';
   End;
   PutTxtXY(2,5,Title,$F);
   FillClr(BC,SizeOf(BC));SP:=@BC;
   Repeat Until Input(2,6,36,31,No,SP)=kbEnter;
   TName:=StrPas(SP);
   HighScore[I].Name:=Systems.Left(TName,31); HighScore[I].Score:=Score.Value;
   HighScore[I].Level:=Speed;
   SetFile(FileNameHighScore,0,SizeOf(HighScore),HighScore);
   Break;
  End;
 End;
End;

Procedure PutHighScore;Var I:Byte;Begin
 PutTxtCenter(0,__Justified__,'BreakOut',$F);
 PutTxtCenter(1,__Justified__,'Les meilleurs pointages',$E);
 PutFillBox(2*8,4*8,36*8+7,24*8+7,0);
 For I:=0to 9do PutTxtXY(3,I+2,
			  StrUSpc(HighScore[I].Name,20)+
			  Str2(HighScore[I].Level,3)+
			  Str2(HighScore[I].Score,9),$7+Byte(I=0)*8);
End;

constructor Location.Init;begin X:=InitX;Y:=InitY;Visible:=False;end;
procedure Location.Relocate;begin X:=NewX;Y:=NewY;end;

procedure Location.MoveTo(NewX,NewY:Int);var Vis:Bool;Begin
 Vis:=Visible;
 if(Vis)Then Hide;
 X:=NewX;Y:=NewY;
 if(Vis)Then Show;
end;

Procedure Location.Show;Begin Visible:=Ya;End;
Procedure Location.Hide;Begin Visible:=No;End;
Function Location.GetX;Begin GetX:=X;End;
Function Location.GetY;Begin GetY:=Y;End;
Function Location.IsVisible;Begin IsVisible:=Visible;End;

Constructor Counter.Init;Begin
 Location.Init(InitX,InitY);
 BaseValue:=InitValue;Value:=InitValue;
End;

Procedure Counter.Show;Begin Visible:=Ya;End;
Procedure Counter.Hide;Begin Visible:=No;End;
Procedure Counter.ShowVal;Begin Visible:=Ya;End;
Procedure Counter.HideVal;Begin Visible:=No;End;

Procedure Counter.SetValue;Var Vis:Bool;Begin
 Vis:=Visible;
 If(Vis)Then HideVal;
 Value:=NewValue;
 If(Vis)Then ShowVal;
End;

Procedure Counter.Increment;Begin SetValue(Value+1)End;
Procedure Counter.Decrement;Begin SetValue(Value-1)End;
Procedure Counter.Add(Incr:Integer);Begin SetValue(Value+Incr)End;
Procedure Counter.Reset;Begin SetValue(BaseValue)End;
Function Counter.Equal;Begin Equal:=Value=TestValue;End;
Function Counter.GetValue;Begin GetValue:=Value;End;

Constructor Block.Init;Begin
 Location.Init(InitX,InitY);
 Color:=InitColor;Width:=InitWidth;BChar:=InitChr;
End;

Procedure Block.Show;Const RGBBlack:Array[0..2]of Byte=(0,0,0);
RGBWhite:Array[0..2]of Byte=(255,255,255);
Var I:Byte;BrickFormat:Pointer;Begin
 Location.Show;
 If BChar=#15Then Begin
  PutSmlImg((X+1)shl 3,(Y-1)shl 3,((X+1)shl 3)+7,((Y-1)shl 3)+7,BallImg);
  If((X<=0)or(X>35))and(Y>19)Then Begin
   PutTxtXY(12,7,'BURNIN''ALIVE',$C);
   SetPalRGB(RGBWhite,0,1);
   For I:=0to 49do Begin
    Inc(Score.Value);
    WaitRetrace;
    WaitRetrace;
    _OutTxtXY(12*8,23*8+2,StrW(Score.Value)+'    ',$C);
   End;
   SetPalRGB(RGBBlack,0,1);
   PutFillBox(12*8,7*16,(12+Length('BURNIN''ALIVE'))*8,9*16,0);
  End;
 End
  Else
{ PutFillBox((X+1)shl 3+1,(Y-1)shl 3+1,((X+1+4)shl 3)+7,((Y-1)shl 3)+7,Color)}
 Begin
  BrickFormat:=Ptr(Seg({$IFDEF Adele}Adele{$ELSE}Chantal{$ENDIF}.Init),(Speed+2)shl 9);
  PutSmlImg((X+1)shl 3+1,(Y-1)shl 3+1,((X+1+4)shl 3)+7,((Y-1)shl 3)+7,BrickFormat^)
 End;
End;

Procedure Block.Hide;Begin
 Location.Hide;
 PutFillBox((X+1)shl 3,(Y-1)shl 3,((X+Width)shl 3)+7,((Y-1)shl 3)+7,0)
End;

Constructor Brick.Init;Begin
 Block.Init(InitX,InitY,InitColor,5,#$B2);
 Value:=InitValue;
End;

Function Brick.GetValue;Begin GetValue:=Value;End;

Constructor Ball.Init;Begin
 Block.Init(InitX,InitY,0,1,#15);
 XVel:=InitXVel;YVel:=InitYVel;
End;

Function Ball.NextX;Begin NextX:=X+XVel;End;
function Ball.NextY;Begin NextY:=Y+YVel;End;

Procedure Ball.MoveX;Begin
 Hide;
 X:=NextX;
 Show;
End;

Procedure Ball.MoveY;Begin
 Hide;
 Y:=NextY;
 Show;
End;

Procedure Ball.ReverseX;Begin XVel:=-XVel;End;
procedure Ball.ReverseY;Begin YVel:=-YVel;End;

Procedure Ball.ChangeXVel;Begin
 Inc(XVel,Delta);
 If XVel<-2Then XVel:=-2 else If XVel>2Then XVel:=2 else
 If XVel=0Then XVel:=Integer(Random(2))*2-1;
end;

constructor Obstacle.Init;Begin
 Location.Init(InitX,InitY);
 Width:=InitWidth;Trap:=SetTrap;NextPtr:=nil;
End;

Destructor Obstacle.Done;Begin End;

Function Obstacle.Collide;Begin Collide:=True;End;
Function Obstacle.IsTrap;Begin IsTrap:=Trap;End;
Function Obstacle.GetValue;Begin GetValue:=0;End;

Constructor ObstacleList.Init;Begin
 Head.Init(0,0,0,False);
 Tail:=@Head;
End;

Destructor ObstacleList.Done;Var Temp1,Temp2:ObstaclePtr;Begin
 Temp1:=Head.NextPtr;
 While(Temp1<>Nil)do begin
  Temp2:=Temp1;Temp1:=Temp1^.NextPtr;
  Temp2^.Done;
 End;
End;

Procedure ObstacleList.Append;Begin
 Tail^.NextPtr:=NewObstacle;Tail:=NewObstacle;
End;

Procedure ObstacleList.Show;Var Current:ObstaclePtr;Begin
 Current:=Head.NextPtr;
 While(Current<>Nil)do Begin
  Current^.Show;
  Current:=Current^.NextPtr;
 End;
End;

Procedure ObstacleList.Hide;Var Current:ObstaclePtr;Begin
 Current:=Head.NextPtr;
 While(Current<>Nil)do Begin
  Current^.Hide;
  Current:=Current^.NextPtr;
 End;
End;

Function ObstacleList.CheckCollisions;Var Current:ObstaclePtr;Begin
 CheckCollisions:=False;Current:=Head.NextPtr;
 While(Current<>nil)do Begin
  If Current^.Collide(B)Then Begin
   Score.Add(Current^.GetValue);
   If(Current^.IsTrap)Then CheckCollisions:=True;
  End;
  Current:=Current^.NextPtr;
 End;
End;

Constructor Paddle.Init;Begin
 Obstacle.Init(InitX,InitY,{5}6,False);
End;

Destructor Paddle.Done;Begin Obstacle.Done;End;
Procedure Paddle.Show;Begin Location.Show;End;
Procedure Paddle.Hide;Begin Location.Hide;End;

Procedure Paddle.MoveTo;Begin
 Hide;
 If NewX<1Then X:=1 else If(NewX>81-Width)Then X:=81-Width else X:=NewX;
 Y:=NewY;
 Show;
End;

Function Paddle.Collide;Var NewX,NewY:Int;Begin
 NewX:=B.NextX;NewY:=B.NextY;Collide:=No;
 If(NewY=Y)Then If((NewX>=X)and(NewX<X+Width))or((NewX<1)and(X=1))or((NewX>80)and(X+Width=81))Then Begin
  B.ReverseY;
  B.ChangeXVel(Int(Random(2))*2-1);
  Collide:=Ya;
 end;
end;

Constructor Boundary.Init;Begin Obstacle.Init(InitX,InitY,InitWidth,SetTrap)End;
Constructor LeftBound.Init;Begin Boundary.Init(InitX,InitY,InitWidth,SetTrap)End;

Function LeftBound.Collide;Begin
 Collide:=No;
 If(B.NextX<=X)and(B.NextY>=Y)and(B.NextY<=Y+Width)Then Begin
  B.ReverseX;
  Collide:=Ya;
 End;
End;

Constructor UpperBound.Init;Begin Boundary.Init(InitX,InitY,InitWidth,SetTrap)End;

Function UpperBound.Collide;Begin
 Collide:=No;
 If(B.NextY<=Y)and(B.NextX>=X)and(B.NextX<=X+Width)Then Begin
  B.ReverseY;
  Collide:=Ya;
 End;
End;

Constructor RightBound.Init;Begin Boundary.Init(InitX,InitY,InitWidth,SetTrap)End;

Function RightBound.Collide;Begin
 Collide:=No;
 If(B.NextX>=X)and(B.NextY>=Y)and(B.NextY<=Y+Width)Then Begin
  B.ReverseX;
  Collide:=Ya;
 End;
End;

Constructor LowerBound.Init;Begin Boundary.Init(InitX,InitY,InitWidth,SetTrap)End;

Function LowerBound.Collide;Begin
 Collide:=No;
 If(B.NextY>=Y)and(B.NextX>=X)and(B.NextX<=X+Width)Then Begin
  B.ReverseY;
  Collide:=Ya;
 End;
End;

Function RandomColor(MaxColors:Int):Int;Var C:Int;Begin
 C:=Random(MaxColors);
 While C=0do C:=Random(MaxColors);
 RandomColor:=C;
End;

Procedure Beep;Begin
 Sound(100);
 Delay(20);
 NoSound;
End;

Constructor Wall.Init;Begin
 Obstacle.Init(InitX,InitY,InitWidth,No);
 Height:=InitHeight;NCells:=Width*5;
 GetMem(BrickWall,Width*Height*SizeOf(Brick));
 Reset;
End;

Destructor Wall.Done;Begin FreeMem(BrickWall,Width*Height*SizeOf(Block))End;

Procedure Wall.Show;Var CurCol,Count,CurBlock:Integer;Begin
 Visible:=True;NumLeft:=Width*Height;
 For CurCol:=1to Width+Height-1do For Count:=0to Height-1do Begin
  CurBlock:=CurCol+Count*(Width-1);
  If(CurCol-Count>=1)and(CurCol-Count<=Width)Then Begin
   BrickWall^[CurBlock].Show;
   Delay(5);
  End;
 End;
End;

Procedure Wall.Hide;Var CurCol,Count,CurBlock:Int;Begin
 Visible:=No;
 For CurCol:=1to Width+Height-1do For Count:=0to Height-1do Begin
  CurBlock:=CurCol+Count*(Width-1);
  If(CurCol-Count>=1)and(CurCol-Count<=Width)Then Begin
   If(BrickWall^[CurBlock].IsVisible)Then Begin
    BrickWall^[CurBlock].Hide;
    Delay(5);
   End;
  End;
 End;
End;

Procedure UpDateBalls;Var I:Int;Begin
 For I:=0to Balls-1do PutSmlImg(312,I*9,319,(I*9)+7,BallImg);
 For I:=Balls to 6do PutFillBox(312,I*9,319,(I*9)+7,0);
End;

Procedure UpDateScore;Const OldScore:Wd=$FFFF;Begin
 If(OldScore<>Score.Value)Then Begin
  OldScore:=Score.Value;
  _OutTxtXY(12*8,23*8+2,StrW(OldScore)+'    ',9);
 End;
End;

Function Wall.Collide;Var CollideV,CollideH:Bool;

 Function CheckCollide(XPos,YPos:Int):Bool;Var ThisBrick:BrickPtr;Begin
  CheckCollide:=No;
  If(YPos<Y)or(YPos>Y+Height-1)or(XPos<X)or(XPos>X+NCells-1)Then Exit;
  ThisBrick:=@BrickWall^[1+((XPos-1)div 5)+Width*(YPos-1)];
  If(ThisBrick^.IsVisible)Then Begin
   CheckCollide:=Ya;Inc(Value,ThisBrick^.GetValue);
   ThisBrick^.Hide;
   Dec(NumLeft);
   Beep;
   If NumLeft=0Then Begin
    Inc(Speed);
    _OutTxtXY(224,23*8+2,StrW(Speed),9);
    If Balls<7Then Begin Inc(Balls);UpDateBalls;End;
    Show;
   End;
  End
 End;

Begin
 Collide:=No;Value:=0;CollideV:=CheckCollide(B.X,B.NextY);
 CollideH:=CheckCollide(B.NextX,B.Y);
 If(CollideV)Then Begin Collide:=True;B.ReverseY;End;
 If(CollideH)Then Begin Collide:=True;B.ReverseX;End;
 If Not(CollideV)and Not(CollideH)Then If CheckCollide(B.NextX,B.NextY)Then Begin
  Collide:=Ya;B.ReverseX;B.ReverseY;
 End;
End;

Function Wall.GetValue;Begin GetValue:=Value;End;

Procedure Wall.Reset;Var CurRow,CurCol,MaxColors:Int;Begin
 MaxColors:=16;NumLeft:=Width*Height;
 For CurRow:=0to Height-1do For CurCol:=0to Width-1do
  BrickWall^[CurRow*Width+CurCol+1].Init(X+CurCol*5,Y+CurRow,RandomColor(MaxColors),Height-Y-CurRow+1);
 If(Visible)Then Show;
End;

Function MainMenu:Bool;Var K:Wd;Begin
 MainMenu:=Ya;
 While(Ya)do Begin
  Repeat
   If __GetMouseButton>0Then Exit;
  Until KeyPress;
  K:=Systems.ReadKey;
  Case(K)of
   kbEsc:Begin MainMenu:=No;Break;End;
   kbEnter:Break;
   kbUp:Begin
    If Speed<10Then Inc(Speed);
    _OutTxtXY(224,23*8+2,StrW(Speed)+'  ',9);
   End;
   kbDn:Begin
    If Speed>1Then Dec(Speed);
    _OutTxtXY(224,23*8+2,StrW(Speed)+'  ',9);
   End;
  End;
 End;
End;

Procedure ProcessKeyStroke;Var K:Wd;Begin
 K:=Systems.ReadKey;
 case K of
  kbEsc:Finished:=Ya;
  kbLeft:Begin
   ClrCur;
   p.MoveTo(p.GetX-1,p.GetY);
   OldX:=(p.GetX-1)shl 3;
   SetMousePos(OldX,0);
   PutCur;
  End;
  kbRight:If(p.GetX+4+3+2<NmXTxts)Then Begin
   ClrCur;
   p.MoveTo(p.GetX+1,p.GetY);
   OldX:=(p.GetX-1)shl 3;
   SetMousePos(OldX,0);
   PutCur;
  End;
  else Begin
   Systems.ReadKey;
   b.Show;
  End;
 End;
End;

Procedure Play;Var KeyLoops,xr,iw:Int;Begin
 _OutTxtXY(224,23*8+2,StrW(Speed)+'  ',9);
 Balls:=5;
 Score.Reset;
 If Not(FirstGame)Then Begin
  InitScr;
  w.Reset;
 End;
 X:=Random(NmXTxts-7)+1;
 b.MoveTo(X,22);
 p.MoveTo(X-2,23);
 b.Show;
 p.Show;
 Dec(Balls);
 UpDateBalls;
 UpDateScore;
 FirstGame:=No;Finished:=No;KeyLoops:=0;OldX:=__GetMsXPixels;
 PutCur;
 Repeat
  X:=__GetMsXPixels;
  If(OldX<>X)Then Begin
   ClrCur;
   OldX:=X;
{   If(X and 7)shr 2=0Then xr:=1 else xr:=0;}
   p.MoveTo({xr+}(X shr 3)+1,p.GetY);
   PutCur;
  End;
  If(KeyPress)Then ProcessKeyStroke;
  Inc(KeyLoops);
  If(KeyLoops=10)and Not(Finished)Then Begin
   UpDateScore;
   KeyLoops:=0;
   If Obstacles.CheckCollisions(b,Score)Then Begin
    b.MoveY;
    p.MoveTo(b.GetX-2,p.GetY);
    sound(150);
    Delay(300);
    nosound;
    Dec(Balls);
    UpDateBalls;
    ClrKbd;
    If Balls<0Then PutTxtCenter(7,__Justified__,'Partie terminer',$C)
     Else
    Begin
     If Balls=0Then PutTxtCenter(7,__Justified__,'C''est votre derniere balles',3)
     Else PutTxtCenter(7,__Justified__,'Plus que '+StrW(Balls)+' balles',3);
     PutTxtCenter(8,__Justified__,'Presse une touche pour continuer',2);
    End;
    Repeat
     If __GetMouseButton>0Then Break;
    Until KeyPress;
    PutFillBox(2*8,14*8,36*8,20*8,0);
    ClrCur;
    OldX:=(p.GetX-1)shl 3;
    If OldX>247-7Then OldX:=240;
    SetMousePos(OldX,0);
    If Balls>=0Then PutCur;
   End;
   b.MoveX;
   b.MoveY;
  End;
  Delay(12-Speed);
 Until(Finished)or(Balls<0);
 UpDateHighScore;
 PutHighScore;
 Repeat Until __GetMouseButton=0;
End;

Var I:Byte;

Procedure PutMsg8x8(Msg:String);Var I,J:Byte;Begin
 For J:=0to 7do For I:=0to 7do
  Copy8Bin(312,100+I+J shl 3,TByte(GetVideoTxtMtxPtr^)[I+Byte(Msg[J+1])shl 3],0,16+I)
End;

BEGIN
 InitSystems(suIsabel);
 ASM {OR}MOV CheckSvga,$80;END;
 SetVideoModeDeluxe(vmGrf320x200c256);
 PutMsg8x8('BreakOut');
 __InitMouse;
 SetMouseMoveArea(0,0,247-7,0);
 OldX:=__GetMsXPixels;
 LoadMtx('COMPUTER.FNT');
 InitScr;
 Left.Init(0,0,27,No);
 Top.Init(0,0,NmXTxts+2,No);
 Right.Init(NmXTxts-4,0,27,No);
 Bottom.Init(0,24,NmXTxts+2,Ya);
 Score.Init(0,65shr 1,24);
 Score.Show;
 Balls:=5;Speed:=1;
 UpDateBalls;
 w.Init(1,1,7,10);
 w.Show;
 b.Init(10,22,1,-1);
 p.Init(8,23);
 Obstacles.Init;
 Obstacles.Append(@w);
 Obstacles.Append(@Left);
 Obstacles.Append(@Top);
 Obstacles.Append(@Right);
 Obstacles.Append(@Bottom);
 Obstacles.Append(@p);
 Randomize;
 GetFile(FileNameHighScore,0,SizeOf(HighScore),HighScore);
 FirstGame:=Ya;
 While(MainMenu)do Begin
  Play;
  Balls:=5;
  b.Hide;
  p.Hide;
 End;
{ b.Hide;
 Obstacles.Hide;
 Score.Hide;
 Obstacles.Done;}
 DoneLuxeVideo;
 DoneSystems;
 WriteLn('J''aime mieux Tetris!!!');
END.