{ Cette unit‚ est destin‚ … l'utilisation du jeux Tetris au niveau d'une
 application.
}

Unit Tetris;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                                 INTERFACE
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Uses Restex,Isatex;

Function  TetrisInit(Var Context;X1,Y1,X2,Y2:Byte):Boolean;
Procedure TetrisStart(Var Q:TetrisGame);
Procedure TetrisRefresh(Var QX);
Procedure TetrisInputMode(Var Context;Mode:GameInputMode);
Function  TetrisPlay(Var QX):Word;
Function  TetrisTitle(Var QX;Max:Byte):String;
Procedure TetrisSetLevel(Var Q:TetrisGame);
Procedure TetrisSetScrn(Var Q:TetrisGame;Full:Boolean);
Procedure TetrisMove2(Var QX;X,Y:Byte);
Function  TetrisDone(Var Q):Word;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                             IMPLEMENTATION
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Uses
 Systex,Memories,Systems,Adele,Mouse,Video,Dialex,Registry,Sound,Dials;

Const
 HomeX=15;
 HomeY=1;

Function GetJoyButton:Byte;Near;Assembler;ASM
 MOV DX,0201h
 IN  AL,DX
 NOT AL
 MOV CL,4
 SHR AL,CL
END;

Function TetrisInit{Var Q;X1,Y1,X2,Y2:Byte):Boolean};
Var
 Q:TetrisGame Absolute Context;
 X,Y:Word;
Begin
 FillClr(Q,SizeOf(Q));
 Q.Level:=1;
 Q.Mode:=tmStart;
 Q.InputMode:=imKeyboard;
 X:=JoyPos(Q.CurrJoy shl 1);
 Y:=JoyPos((Q.CurrJoy shl 1)+1);
 Q.XBrut:=(X*16)div JoyPotentioMeter;
 Q.YBrut:=(Y*7)div JoyPotentioMeter;
 WEInit(Q.MainWin,X1,Y1,X2,Y2);
 MoveLeft(Q.MainWin.T.X1,Q.OX1,SizeOf(Byte)*4);
 ReadMainKey(HKEY_CURRENT_USER,'Games\Tetris','HighScore',Q.HighScore);
 ReadMainKey(HKEY_CURRENT_USER,'Games\Tetris','Input',Q.InputMode);
End;

Procedure TetrisSetScrn(Var Q:TetrisGame;Full:Boolean);Begin
 Q.FullScrn:=Full;
 If Not(Full)Then WEInit(Q.MainWin,Q.OX1,Q.OY1,Q.OX2,Q.OY2);
End;

Procedure TetrisInputMode(Var Context;Mode:GameInputMode);
Var
 Q:TetrisGame Absolute Context;
Begin
 Q.InputMode:=Mode;
 CreateKeyFormat(HKEY_CURRENT_USER,'Games\Tetris','Input',tdByte,Q.InputMode);
End;

Procedure TetrisStart{Var Q:TetrisRec};
Var
 I:Byte;
Begin
 FillClr(Q.Tbl,SizeOf(Q.Tbl));
 FillChr(Q.Tbl[20],SizeOf(Q.Tbl[20]),Byte(Ya));
 Q.Score:=0;Q.Bar:=0;Q.SleepDelay:=25;Q.Level:=Q.SLevel;
 For I:=0to(Q.SLevel)do If Q.SleepDelay>6Then Dec(Q.SleepDelay,2);
 Q.FBar:=Q.Level shl 4;
 Q.Mode:=tmStart;
End;

Procedure TetrisRefresh{Var QX};
Var
 Q:TetrisGame Absolute QX;
 I,J:Byte;
 W:Window;
 Kr:MtxColors;
Begin
 WEPutWn(Q.MainWin,'Tetris',CurrKrs.MalteDos.Window);
 WECloseIcon(Q.MainWin);
 Q.MainWin.CurrColor:=$10*(Q.Level+1);
 WEClrScr(Q.MainWin);
 If(IsGrf)Then Begin
  WEClrWn(Q.MainWin,2,1,12,10,$F);
  If Not(HoleMode)Then
   PutRect((WEGetRX1(Q.MainWin)+2)shl 3,GetRawY(WEGetRY1(Q.MainWin)+1),
          ((WEGetRX1(Q.MainWin)+12)shl 3)+7,GetRawY(WEGetRY1(Q.MainWin)+10+1)-1,$F);
  I:=$E;
 End
  Else
 I:=$1E+Q.Level*$10;
 Q.MainWin.CurrColor:=I+1;
 WEPutTxtXY(Q.MainWin,3,2,'Niveau:');
 Q.MainWin.CurrColor:=I;
 WEPutTxtXY(Q.MainWin,4,3,IntToStr(Q.Level));
 Q.MainWin.CurrColor:=I+1;
 WEPutTxtXY(Q.MainWin,3,5,'Pointage:');
 Q.MainWin.CurrColor:=I;
 WEPutTxtXY(Q.MainWin,4,6,'0');
 Q.MainWin.CurrColor:=I+1;
 WEPutTxtXY(Q.MainWin,3,8,'Ligne:');
 Q.MainWin.CurrColor:=I;
 WEPutTxtXY(Q.MainWin,4,9,IntToStr(Q.Bar));
 WESubWins(Q.MainWin,HomeX-1,HomeY-1,HomeX+10,HomeY+20,W);
 FillClr(Kr,SizeOf(Kr));
 If Not(IsGrf)Then Kr.Border:=$F;
 WEPutWn(W,'',Kr);
 If Not(IsGrf)Then Begin
  SetBorderAvenger;
  __PutBorderUnKr(W.T.X1);
 End;
 If(Q.Mode)in[tmPlay,tmGameOver]Then Begin
  For J:=0to 19do For I:=0to 9do If Q.Tbl[J,I]Then Begin
   _WESetCube(Q.MainWin,HomeX+I,HomeY+J,'ş',$81);
  End;
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Proc‚dure Play                           Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure est le coeur du jeu lui-mˆme. C'est lui bougeant les
 objets et les fesant descendre.


 Remarques
 ÍÍÍÍÍÍÍÍÍ

  ş Cette  proc‚dure  r‚clame  le  fichier  dessin  ®TETRIS.GFX¯  pour
    afficher une toile de fond style russie … l'arriŠre du jeu.

  ş Les objets compos‚  de 4 bloques  ont dans  ce programme  des noms
    diff‚rent dont voici leur sens:
    ÚÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄ¿
    ³ Barre  ³ BoŒte ³    V     ³   L    ³   L    ³Serpent ³ Serpent ³
    ³        ³       ³          ³ gauche ³ droite ³ romain ³  arabe  ³
    ÆÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍµ
    ³ş       ³       ³şşş     ş ³ ş   şş ³  ş  şş ³  şş    ³ şş      ³
    ³ş  şşşş ³   şş  ³ ş  ş  şşş³ ş    ş ³  ş  ş  ³ şş     ³  şş     ³
    ³ş       ³   şş  ³    şş    ³ şş   ş ³ şş  ş  ³        ³         ³
    ³ş       ³       ³    ş     ³        ³        ³        ³         ³
    ÀÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÙ
}

Function TetrisPlay;Label _Exit;Const
      BlkHeight:Array[0..6,0..3]of Byte=(
       (4,1,4,1), { Barre }
       (2,2,2,2), { BoŒte }
       (3,2,3,2), { V }
       (3,2,3,2), { L gauche }
       (3,2,3,2), { L droite }
       (3,2,3,2), { Serpent romain }
       (3,2,3,2));{ Serpent arabe }
      BlkLength:Array[0..6,0..3]of Byte=( {Largeur des objets:}
       (1,4,1,4), { Barre }
       (2,2,2,2), { BoŒte }
       (2,3,2,3), { V }
       (2,3,2,3), { L gauche }
       (2,3,2,3), { L droite }
       (2,3,2,3), { Serpent romain }
       (2,3,2,3));{ Serpent arabe }
      BlkFormat:Array[0..6,0..3,0..3]of Record X,Y:Byte;End=(
       (((X:0;Y:0),(X:0;Y:1),(X:0;Y:2),(X:0;Y:3)),   { şşşş }
	((X:0;Y:0),(X:1;Y:0),(X:2;Y:0),(X:3;Y:0)),
	((X:0;Y:0),(X:0;Y:1),(X:0;Y:2),(X:0;Y:3)),
	((X:0;Y:0),(X:1;Y:0),(X:2;Y:0),(X:3;Y:0))),
       (((X:0;Y:0),(X:1;Y:0),(X:0;Y:1),(X:1;Y:1)),   { şş }
	((X:0;Y:0),(X:1;Y:0),(X:0;Y:1),(X:1;Y:1)),   { şş }
	((X:0;Y:0),(X:1;Y:0),(X:0;Y:1),(X:1;Y:1)),
	((X:0;Y:0),(X:1;Y:0),(X:0;Y:1),(X:1;Y:1))),
       (((X:1;Y:0),(X:0;Y:1),(X:1;Y:1),(X:1;Y:2)),   { şşş }
	((X:1;Y:0),(X:0;Y:1),(X:1;Y:1),(X:2;Y:1)),   {  ş  }
	((X:0;Y:0),(X:0;Y:1),(X:1;Y:1),(X:0;Y:2)),
	((X:0;Y:0),(X:1;Y:0),(X:2;Y:0),(X:1;Y:1))),
       (((X:0;Y:0),(X:0;Y:1),(X:0;Y:2),(X:1;Y:2)),
	((X:0;Y:1),(X:1;Y:1),(X:2;Y:1),(X:2;Y:0)),   { ş  }
	((X:0;Y:0),(X:1;Y:0),(X:1;Y:1),(X:1;Y:2)),   { ş  }
	((X:0;Y:0),(X:1;Y:0),(X:2;Y:0),(X:0;Y:1))),  { şş }
       (((X:1;Y:0),(X:1;Y:1),(X:1;Y:2),(X:0;Y:2)),
	((X:0;Y:1),(X:1;Y:1),(X:2;Y:1),(X:0;Y:0)),   {  ş }
	((X:1;Y:0),(X:0;Y:0),(X:0;Y:1),(X:0;Y:2)),   {  ş }
	((X:0;Y:0),(X:1;Y:0),(X:2;Y:0),(X:2;Y:1))),  { şş }
       (((X:0;Y:0),(X:0;Y:1),(X:1;Y:1),(X:1;Y:2)),
	((X:1;Y:0),(X:2;Y:0),(X:0;Y:1),(X:1;Y:1)),
	((X:0;Y:0),(X:0;Y:1),(X:1;Y:1),(X:1;Y:2)),
	((X:1;Y:0),(X:2;Y:0),(X:0;Y:1),(X:1;Y:1))),
       (((X:1;Y:0),(X:0;Y:1),(X:1;Y:1),(X:0;Y:2)),
	((X:0;Y:0),(X:1;Y:0),(X:1;Y:1),(X:2;Y:1)),
	((X:1;Y:0),(X:0;Y:1),(X:1;Y:1),(X:0;Y:2)),   {şş  }
	((X:0;Y:0),(X:1;Y:0),(X:1;Y:1),(X:2;Y:1)))); { şş }
Var
 Q:TetrisGame Absolute QX;
 I,J:Byte;
 XJ,YJ,K,MB:Word;
 Touch,Ok,NoAction:Boolean;
 OldAttr,H,XT,MX,MY,WaitJoy,JB:Byte;
 OldScr:ImgRec;
 OldDialTimer:Boolean;
 Pause:Window;

 Procedure PutForm(Clr:Boolean);
 Var
  Chr:Char;
  I,Attr,X,Y:Byte;
  InZone:Boolean;
 Begin
  X:=WEGetRX1(Q.MainWin)+HomeX+Q.X;
  Y:=WEGetRY1(Q.MainWin)+HomeY+Q.Y;
  InZone:=(LastMouseX>=X)and(LastMouseX<=X+4)and
          (LastMouseY>=Y)and(LastMouseY<=Y+4);
  If(InZone)Then __HideMousePtr;
  If(Clr)Then Begin
   Chr:=' ';Attr:=7;
  End
   Else
  Begin
   Chr:='ş';Attr:=$81+Q.Form;
  End;
  For I:=0to 3do _WESetCube(Q.MainWin,HomeX+Q.X+BlkFormat[Q.Form,Q.Move,I].X,
			    HomeY+Q.Y+BlkFormat[Q.Form,Q.Move,I].Y,Chr,Attr);
 If(InZone)Then __ShowMousePtr;
 End;

 Procedure Init;Begin
  Q.Form:=Random(6);
  If Q.Form=5Then Inc(Q.Form,Random(2));
  Q.X:=5;Q.Y:=0;
  Q.Move:=0;Q.Sleep:=0;
  PutForm(No);
 End;

 Function UpDateData:Boolean;
 Var
  H,I,J,JK:Byte;
  Bonus:Byte;
  LnChk:Boolean;
 Begin
  UpDateData:=Ya;Q.Sleep:=0;
  PutForm(No);
  Touch:=No;Ok:=No;
  PutForm(Ya);
  Inc(Q.Y);
  For I:=0to 3do Begin
   Touch:=Touch or Q.Tbl[Q.Y+BlkFormat[Q.Form,Q.Move,I].Y,Q.X+BlkFormat[Q.Form,Q.Move,I].X];
  End;
  If(Touch)Then Dec(Q.Y);
  PutForm(No);
  If(Touch)Then Begin
   While(Q.Sleep>Q.SleepDelay)do Dec(Q.Sleep);
   Q.Sleep:=0;Ok:=Ya;
   For I:=0to 3do Q.Tbl[Q.Y+BlkFormat[Q.Form,Q.Move,I].Y,Q.X+BlkFormat[Q.Form,Q.Move,I].X]:=Ya;
   If Q.Level>7Then Begin
    Inc(Q.Score,Long(5)*Q.Level);
    If(IsGrf)Then Q.MainWin.CurrColor:=$E
             Else Q.MainWin.CurrColor:=$1E+Q.Level*$10;
    WEPutTxtXY(Q.MainWin,4,6,IntToStr(Q.Score));
   End;
   Bonus:=0;
   For J:=0to 19do Begin
    Touch:=Ya;
    For I:=0to 9do Touch:=Touch and Q.Tbl[J,I];
    If(Touch)Then Inc(Bonus);
   End;
   If Bonus>0Then Dec(Bonus);
   Touch:=No;
   For JK:=0to 7do Begin
    For J:=0to 19do Begin
     LnChk:=Ya;
     For I:=0to 9do LnChk:=LnChk and Q.Tbl[J,I];
     If(LnChk)Then Begin
      If Not(Touch)Then Begin
       Touch:=True;
       _LoadWave(MaltePath+'NIII.WAV');
       _PlayWave;
      End;
      If JK and 1=0Then Q.MainWin.CurrColor:=$FF
                   Else Q.MainWin.CurrColor:=7;
      WEBarSpcHor(Q.MainWin,HomeX,HomeY+J,HomeX+9);
     End;
    End;
    WaitRetrace;WaitRetrace;WaitRetrace;
   End;
   If Not(Touch)Then Begin
    _LoadWave(MaltePath+'PROUTE.WAV');
    _PlayWave;
   End;
   For J:=0to 19do Begin
    Touch:=True;
    For I:=0to 9do Touch:=Touch and Q.Tbl[J,I];
    If(Touch)Then Begin
     MoveRight(Q.Tbl[0,0],Q.Tbl[1,0],10*J);
     FillClr(Q.Tbl[0,0],10);
     MoveText(WEGetRX1(Q.MainWin)+HomeX,WEGetRY1(Q.MainWin)+HomeY,
              WEGetRX1(Q.MainWin)+HomeX+9,WEGetRY1(Q.MainWin)+HomeY+J-1,
              WEGetRX1(Q.MainWin)+HomeX,WEGetRY1(Q.MainWin)+HomeY+1);
     Inc(Q.Score,Long(5)+(Bonus*4)*(Q.Level+1)+10*Q.Level); Inc(Q.Bar);
     If(IsGraf)Then Q.MainWin.CurrColor:=$E
               Else Q.MainWin.CurrColor:=$1E+Q.Level*$10;
     WEPutTxtXY(Q.MainWin,4,6,IntToStr(Q.Score));
     WEPutTxtXY(Q.MainWin,4,9,IntToStr(Q.Bar));
     I:=(Q.Bar+Q.FBar)shr 4;
     If(Q.Level<>I)Then Begin
      Q.Level:=I;
      {If(IsGraf)Then Begin
       For H:=0to 19do For I:=0to 9do Begin
	OldAttr:=GetAttr(WEGetRX1(Q.MainWin)+HomeX+I,
                         WEGetRY1(Q.MainWin)+HomeY+H);
	If OldAttr>$FThen
         WESetAttr(Q.MainWin,HomeX+I,HomeY+H,OldAttr+$10);
       End;
       Q.MainWin.Kr:=$E;
      End
       Else}
      Begin
       For H:=0to Q.MainWin.MaxY do For I:=0to Q.MainWin.MaxX do Begin
	OldAttr:=GetAttr(WEGetRX1(Q.MainWin)+I,WEGetRY1(Q.MainWin)+H);
	If OldAttr>$FThen WESetAttr(Q.MainWin,I,H,OldAttr+$10);
       End;
       Q.MainWin.CurrColor:=$E{ $1E+Q.Level*$10};
      End;
      WEPutTxtXY(Q.MainWin,4,3,IntToStr(Q.Level+1));
      If Q.SleepDelay>6Then Dec(Q.SleepDelay,2);
     End;
    End;
   End;
   If Q.Y<=1Then Begin
    UpDateData:=No;
    Exit;
   End;
   Init;
  End;
 End;

 Procedure UpDateHighScore;
 Var
  I:Byte;
  TName,Title:String;
 Begin
 For I:=0to 9do Begin
  If(Q.Score>=Q.HighScore.User[I].Score)Then Begin
   If I<9Then MoveRight(Q.HighScore.User[I],Q.HighScore.User[I+1],SizeOf(Q.HighScore.User[0])*(9-I));
   TName:='';
   Case I of
    0:Title:='PremiŠre place des meilleurs pointages';
    1:Title:='DeuxiŠme place des meilleurs pointages';
    2:Title:='TroisiŠme place des meilleurs pointages';
    3:Title:='QuatriŠme place des meilleurs pointages';
    4:Title:='CinquiŠme place des meilleurs pointages';
    5:Title:='SixiŠme place des meilleurs pointages';
    6:Title:='SeptiŠme place des meilleurs pointages';
    7:Title:='HuitiŠme place des meilleurs pointages';
    8:Title:='NeuviŠme place des meilleurs pointages';
    9:Title:='DixiŠme place des meilleurs pointages';
   End;
   Repeat Until
    WinInp(40,Title,'Veuillez S.V.P. entrer votre nom:',
	   CurrKrs.Dialog.Window,False,TName)=kbEnter;
   Q.HighScore.User[I].Name:=Left(TName,31); Q.HighScore.User[I].Score:=Q.Score;
   Q.HighScore.User[I].Level:=Q.Level;
   Q.HighScore.User[I].Bar:=Q.Bar;
   Q.HighScore.Len:=SizeOf(TetrisHighScoreFile)-2;
   CreateKeyFormat(HKEY_CURRENT_USER,'Games\Tetris','HighScore',tdBlob,Q.HighScore);
   Break;
  End;
 End;
End;

 Function GameOver:Word;
 Var
  OldWinType:WinModelType;
  W:Window;
  Kr:MtxColors;
  I:Byte;
 Begin
  SetShade(No);
  OldWinType:=WinType;WinType:=Robotic;
  WESubWins(Q.MainWin,10,5,28,9,W);
  WinType:=Normal;
  Kr.Border:=$F0;
  WEPutWn(W,'',Kr);
  WELn(W);
  WEPutOTxt(W,'Partie Terminer');
  If(Q.UpDate)Then Begin
   If Q.Score<>0Then UpDateHighScore;
   Q.UpDate:=No;
  End;
  Q.MainWin.Y:=10;
  WEPutOTxt(Q.MainWin,'Les meilleurs pointages');
  For I:=0to 9do Begin
   Q.MainWin.X:=0;
   Inc(Q.MainWin.Y);
   WEPutTxt(Q.MainWin,
	    StrUSpc(Q.HighScore.User[I].Name,12)+
	    Str2(Q.HighScore.User[I].Level+1,3)+
	    Str2(Q.HighScore.User[I].Bar,6)+
	    Str2(Q.HighScore.User[I].Score,8));
  End;
  If(Q.InputMode=imJoystick)Then Begin
   __ShowMousePtr;
   Repeat
    K:=WEBackReadk(Q.MainWin);
    If K>0Then Begin
     If(K=kbClose)Then WaitMouseBut0;
     __HideMousePtr;
     Break;
    End;
    _BackKbd;
    __GetMouseTextSwitch(MX,MY,MB);
    WaitRetrace;
    If WaitJoy=0Then Begin
     If(GetJoyButton shr(Q.CurrJoy shl 1)>0)Then K:=kbEnter;
    End;
    WaitJoy:=(WaitJoy+1)and 7;
    If(KeyPress)Then K:=WEReadk(Q.MainWin);
   Until K>0;
   __HideMousePtr;
  End
   Else
  Begin
   __ShowMousePtr;
   K:=WEReadk(Q.MainWin);
   __HideMousePtr;
  End;
  If(K=kbEnter)or(Chr(K)=' ')Then Q.Mode:=tmStart;
  WinType:=OldWinType;
  GameOver:=K;
 End;

Begin
 If(Q.FullScrn)Then Begin
  OldDialTimer:=DialTimer;DialTimer:=No;
  PushScr(OldScr);
  SetVideoModeDeluxe(vmGrf320x200c256);
  __InitMouse;
  WEInit(Q.MainWin,0,0,MaxXTxts,MaxYTxts);
  TetrisRefresh(Q);
 End;
 K:=0;WaitJoy:=0;
 Repeat
  Case(Q.Mode)of
   tmStart:Begin
    TetrisStart(Q);
    TetrisRefresh(Q);
    Init;
    Q.Mode:=tmPlay;Q.UpDate:=Ya;
   End;
   tmPlay:Repeat
    __ShowMousePtr;
    _InitKbd;
    If(Q.InputMode=imJoystick)Then Begin
     Repeat
      K:=WEBackReadk(Q.MainWin);
      If K>0Then Begin
       If(K=kbClose)Then WaitMouseBut0;
       __HideMousePtr;
       Goto _Exit;
      End;
      _BackKbd;
      __GetMouseTextSwitch(MX,MY,MB);
      If(Q.Sleep>Q.SleepDelay)Then If Not(UpDateData)Then Begin
       Q.Mode:=tmGameOver;
       ClrKbd;
       Goto _Exit;
      End;
      If WaitJoy=0Then Begin
       JB:=GetJoyButton shr(Q.CurrJoy shl 1);
       If JB=2Then Begin
        WESubWins(Q.MainWin,10,5,28,9,Pause);
        WEPushWn(Pause);
        WEPutWn(Pause,'',CurrKrs.Dialog.Window);
        WELn(Pause);
        WEPutOTxt(Pause,'Pause');
        Repeat
         If(KeyPress)or(MouseMove)Then Break;
        Until GetJoyButton shr(Q.CurrJoy shl 1)=0;
        Repeat
         If(KeyPress)or(MouseMove)Then Break;
        Until GetJoyButton shr(Q.CurrJoy shl 1)<>0;
        Repeat
         If(KeyPress)or(MouseMove)Then Break;
        Until GetJoyButton shr(Q.CurrJoy shl 1)=0;
        WEDone(Pause);
       End
        Else
       If JB>0Then K:=kbKeyPad5
        Else
       Begin
        XJ:=(JoyPos(Q.CurrJoy shl 1)*16)div JoyPotentioMeter;
        YJ:=(JoyPos((Q.CurrJoy shl 1)+1)*7)div JoyPotentioMeter;
        If XJ<=1Then K:=kbLeft Else
        If XJ>Q.XBrut+1Then K:=kbRight Else
        If(YJ>Q.YBrut)Then Begin
         K:=kbDn;
         While((JoyPos((Q.CurrJoy shl 1)+1)*7)div JoyPotentioMeter>Q.YBrut)do
          If(KeyPress)or(__GetMouseButton>0)Then Break;
        End;
       End;
      End;
      WaitRetrace;
      Inc(Q.Sleep);
      WaitJoy:=(WaitJoy+1)and 7;
      If(KeyPress)Then K:=WEReadk(Q.MainWin);
     Until K>0;
     __HideMousePtr;
    End
     Else
    Begin
     Repeat
      K:=WEBackReadk(Q.MainWin);
      If K>0Then Begin
       If(K=kbClose)Then WaitMouseBut0;
       __HideMousePtr;
       Goto _Exit;
      End;
      _BackKbd;
      __GetMouseTextSwitch(MX,MY,MB);
      If(Q.Sleep>Q.SleepDelay)Then If Not(UpDateData)Then Begin
       Q.Mode:=tmGameOver;
       Goto _Exit;
      End;
      WaitRetrace;
      Inc(Q.Sleep);
     Until KeyPress;
     __HideMousePtr;
     K:=WEReadk(Q.MainWin);
    End;
    If Chr(K)='2'Then K:=kbDn;
    If Chr(K)='4'Then K:=kbLeft;
    If Chr(K)='6'Then K:=kbRight;
    NoAction:=No;
    Case(K)of
     kbLeft:If Q.X>0Then Begin
      Touch:=No;
      For I:=0to 3do Touch:=Touch or Q.Tbl[Q.Y+BlkFormat[Q.Form,Q.Move,I].Y,Q.X+BlkFormat[Q.Form,Q.Move,I].X-1];
      If Not(Touch)Then Begin
       PutForm(Ya);
       Dec(Q.X);
       PutForm(No);
      End;
     End;
     kbRight:If Q.X+BlkLength[Q.Form,Q.Move]-1<9Then Begin
      Touch:=No;
      For I:=0to 3do Touch:=Touch or Q.Tbl[Q.Y+BlkFormat[Q.Form,Q.Move,I].Y,Q.X+BlkFormat[Q.Form,Q.Move,I].X+1];
      If Not(Touch)Then Begin
       PutForm(Ya);
       Inc(Q.X);
       PutForm(No);
      End;
     End;
     kbDn:While(Ya)do Begin
      If Not(UpDateData)Then Begin
       Q.Mode:=tmGameOver;
       Goto _Exit;
      End;
      If(Ok)Then Break;
     End;
     Else NoAction:=Ya;
    End;
    If(NoAction)Then Begin
     If(K=kbKeyPad5)or(Char(K)in[' ','5'])Then Begin
      Touch:=No;
      For I:=0to 3do Begin
       XT:=Q.X+BlkFormat[Q.Form,(Q.Move+1)and 3,I].X; Touch:=Touch or(XT>9);
       Touch:=Touch or Q.Tbl[Q.Y+BlkFormat[Q.Form,(Q.Move+1)and 3,I].Y,XT];
      End;
      If Not(Touch)Then Begin
       PutForm(Ya);
       Q.Move:=(Q.Move+1)and 3;
       PutForm(No)
      End
       Else
      Begin
       Touch:=No;
       For I:=0to 3do Begin
        XT:=Q.X;
        If XT>0Then Dec(XT);
        Inc(XT,BlkFormat[Q.Form,(Q.Move+1)and 3,I].X); Touch:=Touch or(XT>9);
        Touch:=Touch or Q.Tbl[Q.Y+BlkFormat[Q.Form,(Q.Move+1)and 3,I].Y,XT];
       End;
       If Not(Touch)Then Begin
        PutForm(Ya);
        Dec(Q.X); Q.Move:=(Q.Move+1)and 3;
        PutForm(No);
       End;
      End;
     End
      Else
     Break;
    End;
   Until K=kbEsc;
   tmGameOver:K:=GameOver;
  End;
_Exit:
  If K<>0Then Break;
 Until No;
 If(Q.FullScrn)Then Begin
  PopScr(OldScr);
  DialTimer:=OldDialTimer;
 End;
 TetrisPlay:=K;
End;

Procedure TetrisSetLevel{Var Q:TetrisRec};
Var
 L:LstMnu;
 K:Word;
Begin
 LMInitCenter(L,30,10,'Niveau de difficult‚',CurrKrs.Dialog.Window);
 For K:=1to 15do ALAddStrByte(L.List,'Niveau '+WordToStr(K-1),K);
 K:=LMRun(L);
 LMDone(L);
 If K>0Then Q.SLevel:=K-1;
End;

Function TetrisTitle;Begin
 TetrisTitle:='Tetris'
End;

Procedure TetrisMove2{Var QX;X,Y:Byte};
Var
 Q:TetrisGame Absolute QX;
 MX,MY:Byte;
Begin
 MX:=Q.MainWin.T.X2-Q.MainWin.T.X1;
 MY:=Q.MainWin.T.Y2-Q.MainWin.T.Y1;
 Q.MainWin.T.X1:=X;Q.MainWin.T.X2:=X+MX;
 Q.MainWin.T.Y1:=Y;Q.MainWin.T.Y2:=Y+MY;
 TetrisRefresh(Q);
End;

Function TetrisDone;Begin
 TetrisDone:=0;
End;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
END.