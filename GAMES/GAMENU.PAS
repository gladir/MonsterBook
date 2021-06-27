Program GaMenu;

{$M 16384,0,32768}

Uses Chantal,Dos,Systex,Systems,Video,Mouse;

Label 0,Quit;

Const HomeY=9;Max=10;Y:Byte=0;D:Byte=0;
      Menu:Array[0..Max]of Record Name:String[12];Title:String[20];End=(
       (Name:'BREAKOUT.EXE';Title:'BreakOut'),
       (Name:'CHESS.EXE';   Title:'êchec'),
       (Name:'MISSILE.EXE'; Title:'Missile Command'),
       (Name:'MOON.EXE';    Title:'Moon Mission'),
       (Name:'NIBBLES.EXE'; Title:'Nibbles'),
       (Name:'PATIENCE.EXE';Title:'Patience'),
       (Name:'PEGLEAP.EXE'; Title:'Peg Leap'),
       (Name:'SOKOBAN.EXE'; Title:'Soko-Ban'),
       (Name:'TETRIS.EXE';  Title:'Tetris'),
       (Name:'HANOIS.EXE';  Title:'Tour d''Hanois'),
       (Name:'EXIT';        Title:'Quitter')
      );
Var K,I,Wait:Wd;XM,YM,BM:Wd;

Procedure ExecPrg(Path:String);Begin
 ClrScrBlack;
 PutTxtCenter(12,__Justified__,'Un instant S.V.P. ...',$C);
 FreeMaxHeap;
 Exec(FSearch(Path,MaltePath+';\OUTPUT'),'');
 MaxExpandHeap;
End;

Procedure PutBar;Begin
 BarSelHor(6,Y+HomeY,MaxXTxts-6,$A0);
 SetMousePos(0,Y*8);
End;

Procedure UndoBar;Begin
 BarSelHor(6,Y+HomeY,MaxXTxts-6,$9);
End;

Procedure Show;Begin
 For I:=0to 39do Begin
  SetCube(I,5,#7,(I+D)and $F);
  SetCube(39-I,24,#7,(I+D+10)and $F);
 End;
 For I:=6to 23do Begin
  SetCube(0,23-I+6,#7,(I+D+12)and $F);
  SetCube(39,I,#7,(I+D+2)and $F);
 End;
 Case(D)of
  0:PutTxtCenter(2,__Justified__,'GaMenu',$B);
  8:PutTxtCenter(2,__Justified__,'GaMenu',$E);
 End;
 D:=(D+1)and 15;
End;

BEGIN
 InitSystems(suIsabel);
 Repeat
  SetVideoMode(vmTxtC40);
  SetBlink(No);
  CloseCur;
  __InitMouse;
  SetMouseMoveAreaY(0,Max*8);
  Show;
  SetKr($9);
  For I:=0to(Max)do _PutTxtXY(8,HomeY+I,Menu[I].Title);
  PutBar;
  Wait:=0;
  Repeat
   Repeat
    WaitRetrace;
    Inc(Wait);
    If Wait=4Then Begin
     Show;
     Wait:=0;
    End;
    GetMouseSwitch(XM,YM,BM);
    If(YM shr 3<>Y)Then Begin
     UndoBar;
     Y:=YM shr 3;
     PutBar;
    End;
    If BM>0Then Goto 0;
   Until KeyPress;
   K:=ReadKey;
   Case(K)of
    kbHome:Begin
     UndoBar;
     Y:=0;
     PutBar;
    End;
    kbUp,kbLeft:Begin
     UndoBar;
     Y:=MinByte(Y,Max);
     PutBar;
    End;
    kbDn,kbTab,kbRight:Begin
     UndoBar;
     Y:=MaxByte(Y,Max);
     PutBar;
    End;
    kbEnd:Begin
     UndoBar;
     Y:=Max;
     PutBar;
    End;
    kbEnter:0:Case(Y)of
     Max:Goto Quit;
     Else Begin;ExecPrg(Menu[Alpha(Y,Max-1)].Name);Break;End;
    End;
    kbEsc:Begin
Quit:DoneLuxeVideo;
     DoneSystems;
     Halt;
    End;
   End;
  Until No;
 Until No;
END.