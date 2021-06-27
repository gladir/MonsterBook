{ Programmeurs
  НННННННННННН

   Justin Pierce
   Jarrad Giles
   Sylvain Maltais
}

{$DEFINE HIGH}

Uses Adele,Systex,Systems,Video,Crt,Drivers;

{$IFDEF HIGH}
Procedure GetImage(X1,Y1,X2,Y2:Word;Var Buffer);Assembler;ASM
 CLD
 LES DI,Buffer
 MOV AX,X1
 SUB AX,X2
 INC AX
 STOSB
 MOV AX,Y1
 SUB AX,Y2
 INC AX
 STOSB
 PUSH X1
 PUSH Y1
 PUSH X2
 PUSH Y2
 PUSH ES
 PUSH DI
 CALL GetSmlImg
END;

Procedure PutImage(X,Y:Word;Var Buffer);Assembler;ASM
 PUSH DS
  CLD
  LDS SI,Buffer
  PUSH X
  PUSH Y
  LODSW
  ADD Byte Ptr X,AL
  ADC Byte Ptr X[1],0
  DEC X
  ADD Byte Ptr Y,AH
  ADC Byte Ptr Y[1],0
  DEC Y
  PUSH X
  PUSH Y
  PUSH DS
  PUSH SI
  CALL PutSprite
{  CALL PutSmlImg}
 POP DS
END;
{$ENDIF}

Const
 numofpictures=50;
 numofpatterns=10;
 numofstars=20;
 numofmovers=10;
 maxnumoflasers=50;
 maxnumofenemylasers=100;
 maxnumofenemies=15;
 maxnumofexplosions=16;
 maxtypesoflasers=20;
 maxtypesofenemies=100;
 maxpartsofmap=10;
 initialmoney=10000;
 initialshields=40;

Type
 s10=String[10];

 Pictures=Record
  Name:String[10];
  XDim,YDim:byte;
  Pic:Pointer;
 End;

 LaserTypes=Record
  picn:Byte;
  jump:Byte;
  del:Integer;
  link:Byte;
  linkspace:Byte;
  num:Byte;
  price:LongInt;
  possess:Boolean;
  damage:Byte;
  xdim,ydim:Byte;
  range:Integer;
  limit:Byte;
  orrientation:Byte;
  name:String[30];
  cdel:Integer;
  des:String;
 End;

 Laser=Record
  X,Y:Integer;
 End;

 EnemyLaser=Record
  X,Y:Integer;
  LType:Integer;
  Et:Byte;
 End;

 Enemies=Record
  Strength:Integer;
  X,Y:Integer;
  Et:Byte;
  Stage,CDel:Byte;
 end;

 Animation=Record
  BPic,LPic:Byte;
  Name:String[10];
 End;

 Movers=Record
  BPic,LPic:Byte;
  Name:String[10];
  PatName:String[10];
  CDel,Del,X,Y:Integer;
  Repeater:Boolean;
  Onpic:Byte;
 End;

 Stars=Record
  X,Y:Integer;
  SType:Byte;
  PicN:Byte;
 End;

 MapPosition=Record
  FileN:String;
  Del:LongInt;
  OnPart:Byte;
  OnLevel:Byte;
  LastLine:Integer;
  Name:String;
 End;

 EnemyTypes=Record
  PointValue:LongInt;
  Strength,WeapPow:Integer;
  Jump:Byte;
  PicN:Byte;
  Del:Integer;
  DamageByRam:Byte;
  WNum:Byte; {weapon type}
  ChanceOfShot:Integer; {higher the number lower the chance}
  Orrientation:Byte;
  MidX,MidY:Byte;
 End;

 Explosions=Record
  X,Y:Integer;
  Dim,On,Last:Byte;
 End;

Var
 Pics:Array[1..NumOfPictures]of Pictures;
 Ani:Array[1..NumOfPatterns]of Animation;
 Mov:Array[1..numofmovers] of movers;
 LType:Array[1..maxtypesoflasers] of lasertypes;
 Las:Array[1..maxnumoflasers] of laser;
 ELas:Array[1..maxnumofenemylasers] of enemylaser;
 E:Array[1..maxnumofenemies] of enemies;
 S:Array[1..numofstars] of stars;
 Et:Array[1..maxtypesofenemies] of enemytypes;
 Exp:Array[1..maxnumofexplosions] of explosions;
 Mp:MapPosition;
 Part:Array[1..maxpartsofmap]Of String;
 BgiDirec,PicDirec,WorkDirec,PP:String;
 KEvent,MoEvent:TEvent;
 Proc:s10;
 Direct,BurnNum,OnWeapon,OnLaser,EOnLaser,OnEnemy,OnExp,EWeap,SCDel,B10,B20,B30,B40,B50,LMX,LMY,Cont,Flamex,Warp:Byte;
 SX,SY,FY,Error:Integer;
 GlobalDel,Money,GShipStrength,GShipStrengthTotal,Total:LongInt;
 Map:Text;
 ClearD,NoStar:Boolean;
 X,Y:Integer;
 SlowDown:Byte;

Procedure Fatal(Const FCall:String);Begin
 TextMode(CO80);
 ClrScr;
 WriteLn('A fatal error has occured');
 WriteLn('Error: ',fcall);
 WriteLn;
 Write('Hit enter to halt program--');
 ReadLn;
 Halt;
End;

Procedure GInit640x480x16(Direc:String);Var Grd,GrMode,ErrCode:Integer;Begin
 {$IFNDEF HIGH}
  CloseGraph;
  Grd:=9;
  GrMode:=2;
  InitGraph(Grd,GrMode,Direc);
  ErrCode:=GraphResult;
  If(ErrCode<>grOk)Then Fatal('PROC[GINIT640X480X16]- CANNOT INITIALIZE 640x480x16 GRAPHICS MODE');
  SetGraphMode(2);
 {$ENDIF}
 {$IFDEF HIGH}
  SetVideoModeDeluxe(vmGrf640x480c256);
{  LoadMtx('8X10.FNT');
  SetFontName('COMPUTER.POL');
  FontDegraded:=No;SizeMulFont:=2;}
 {$ELSE}
  SetVideoModeDeluxe(vmGrf640x480c16)
 {$ENDIF}
End;

Procedure MouseChk;Var lk:tevent;Func:char;Name:String[12];Begin
 {$IFDEF High}
  ClrScrBlack;
{  LoadMtx('8X10.FNT');}
  OutTxtXY(110,0,'This game requires a mouse, to enter left click now',GraphColor);
  OutTxtXY(0,460,'If you do not have a mouse driver installed hit "Q" to exit to your Operating',7);
  OutTxtXY(0,470,'System so you can install a mouse driver',7);
  OutTxtXY(0,290,'Read Before Continuing:',Red);
  OutTxtXY(0,300,'It is not suggested that this game be run under any other operating system',Red);
  OutTxtXY(0,310,'than higher versions MS or PC DOS. It is recommended that you do not use Windows.',Red);
  OutTxtXY(0,320,'The author of this software is not responsible for any damage this software',Red);
  OutTxtXY(0,330,'causes to anything. Though I hardly see how it could.',Red);
  SizeMulFont:=5;
  Name:='IronClad';
  OutFTxtXY(6,26,Name,4);
  OutFTxtXY(5,25,Name,7);
  OutFTxtXY(0,20,Name,8);
 {$ELSE}
 ClearDevice;
 OutTextXY(110,0,'This game requires a mouse, to enter left click now');
 GotoXY(1,15);
 SetColor(7);
 OutTextXY(0,460,'If you do not have a mouse driver installed hit "Q" to exit to your Operating');
 OutTextXY(0,470,'System so you can install a mouse driver');
 SetColor(Red);
 OutTextXY(0,290,'Read Before Continuing:');
 OutTextXY(0,300,'It is not suggested that this game be run under any other operating system');
 OutTextXY(0,310,'than higher versions MS or PC DOS. It is recommended that you do not use Windows.');
 OutTextXY(0,320,'The author of this software is not responsible for any damage this software');
 OutTextXY(0,330,'causes to anything. Though I hardly see how it could.');
 SetTextStyle(0,0,8);
 Name:='IronClad';
 SetColor(4);
 OutTextXY(((640-(Length(Name)*8*8))shr 1)-6,26,Name);
 SetColor(7);
 OutTextXY(((640-(Length(Name)*8*8))shr 1)-5,25,Name);
 SetColor(8);
 OutTextxy((640-(Length(Name)*8*8))div 2,20,Name);
 SetTextStyle(0,0,1);
{$ENDIF}
 ShowMouse;
 Repeat
  GetMouseEvent(lk);
  Func:='@';
  If KeyPressed Then Func:=Chr(ReadKey);
  {begin
  Read(Kbd,Func);
  Func:=UpCase(Func);
  End;}
 Until (Func='Q')or(lk.Buttons=mbLeftButton);
 If Func='Q'Then Begin
  TextMode(CO80);
  ClrScr;
  Halt;
 End;
 HideMouse;
 {$IFNDEF High}
  ClearDevice;
 {$ENDIF}
End;

Function FindNextPic:Byte;Var C:Byte;Begin
 C:=0;
 Repeat Inc(C)Until(Pics[C].Name='')or(C>NumOfPictures);
 If(C>NumOfPictures)Then Fatal('FUNC[FINDNEXTPIC]- MAXIMUM NUMBER OF PICTURES USED');
 FindNextPic:=C;
End;

Function FindNextAni:Byte;Var C:Byte;Begin
 C:=0;
 Repeat Inc(C)Until(Ani[C].Name='')or(C>NumOfPatterns);
 If(C>NumOfPatterns)Then Fatal('FUNC[FINDNEXTANI]- MAXIMUM NUMBER OF PATTERNS USED');
 FindNextAni:=C;
End;

Function FindNextMover:Byte;Var C:Byte;Begin
 C:=0;
 Repeat;Inc(C)Until(Mov[C].Name='')or(C>NumOfMovers);
 If(C>NumOfMovers)Then Fatal('FUNC[FINDNEXTMOVER]- MAXIMUM NUMBER OF ANIMATIONS USED');
 FindNextMover:=C;
End;

Function FindPic(Name:s10):Byte;Var C:Byte;Begin
 C:=0;
 Repeat;Inc(C)Until(StrUp(Pics[C].Name)=StrUp(Name))or(C>NumOfPictures);
 If(C>NumOfPictures)Then Fatal(CONCAT('FUNC[FINDPIC]- PICTURE NAME: ',NAME,' NOT FOUND'));
 FindPic:=C;
End;

Function FindPattern(Name:s10):Byte;Var C:Byte;Begin
 C:=0;
 Repeat;Inc(C)Until(StrUp(Ani[C].Name)=StrUp(Name))or(C>NumOfPatterns);
 If(C>NumOfPatterns)Then Fatal(CONCAT('FUNC[FINDPATTERN]- PATTERN NAME: ',NAME,' NOT FOUND'));
 FindPattern:=C;
End;

Function FindMover(Name:s10):Byte;Var C:Byte;Begin
 C:=0;
 Repeat
  Inc(C);
 Until(StrUp(Mov[C].Name)=StrUp(Name))or(C>NumOfMovers);
 If(C>NumOfMovers)Then Fatal(CONCAT('FUNC[FINDMOVER]- MOVER NAME: ',NAME,' NOT FOUND'));
 FindMover:=C;
End;

Procedure LoadPic(FileN:String;Name:s10);Var Work:Text;Handle:Hdl;WW:Wd;S,X,Y,O:Byte;Begin
 {$IFDEF HIGH}
  Handle:=FileOpen(Path2NoExt(FileN)+'.GFX',fmRead);
  If(Handle<>errHdl)Then Begin
   S:=FindNextPic;
   Pics[S].Name:=Name;
   Pics[S].Pic:=MemAlloc(FileSize(Handle));
   _GetAbsRec(Handle,0,FileSize(Handle),Pics[S].Pic^);
   _GetAbsRec(Handle,0,2,WW);
   Pics[S].XDim:=Lo(WW);
   Pics[S].YDim:=Hi(WW);
   FileClose(Handle)
  End;
 {$ELSE}
  Assign(Work,FileN);
  {$I-}
  Reset(Work);
  {$I+}
  If IOResult<>0 Then Fatal(CONCAT('PROC[LOADPIC]- DRW FILE: ',FILEN,' DOES NOT EXIST!'));
  S:=FindNextPic;
  Pics[S].Name:=Name;
  ReadLn(Work,Pics[S].XDim);
  ReadLn(Work,Pics[S].YDim);
  GetMem(Pics[S].Pic,ImageSize(0,0,Pics[s].XDim,Pics[S].YDim));
  Total:=Total+ImageSize(0,0,Pics[S].XDim,Pics[S].YDim);
  ClearDevice;
  Y:=1;
  Repeat
   X:=1;
   Repeat
    ReadLn(Work,O);
    PutPixel(X-1,Y-1,O);
    Inc(X);
   Until(X>Pics[S].XDim)or(Eof(Work));
   Inc(Y);
  Until(Y>Pics[S].YDim)or(Eof(Work));
  If(X<=Pics[S].XDim)or(Y<=Pics[S].YDim)Then Begin
   Fatal(CONCAT('PROC[LOADPIC]- DRW FILE: ',FILEN,' DOES NOT APPEAR TO BE A VALID DWG FILE'))
  End;
  GetImage(0,0,Pics[S].XDim,Pics[S].YDim,Pics[S].Pic^);
  System.Close(Work);
 {$ENDIF}
End;

Procedure LoadAni(Name:s10;Bp,Lp:S10);Var S:Byte;Begin
 S:=FindNextAni;
 Ani[S].BPic:=FindPic(Bp);
 Ani[S].LPic:=FindPic(Lp);
 Ani[S].Name:=Name;
End;

Procedure DrawDrwFile(XD,YD:Integer;N:String);Var W:Text;X,Y,C,CX,CY,Size:Integer;P:Pointer;Handle:Hdl;Begin
 {$IFDEF HIGH}
  Handle:=FileOpen(Path2NoExt(N)+'.GFX',fmRead);
  If(Handle<>errHdl)Then Begin
   Size:=FileSize(Handle);P:=MemAlloc(Size);
   _GetAbsRec(Handle,0,Size,P^);
   PutImage(XD,YD,P^);
   FreeMem(P,Size);
   FileClose(Handle)
  End;
 {$ELSE}
  Assign(W,N);
  {$I-}
  Reset(W);
  {$I+}
  If IOResult<>0Then Fatal(CONCAT('PROC[LOADPIC]- DRW FILE: ',N,' DOES NOT EXIST!'));
  ReadLn(W,X);
  ReadLn(W,Y);
  CY:=0;
  Repeat
   CX:=0;
   Repeat
    ReadLn(W,C);
    {$IFDEF High}SetPixel{$ELSE}PutPixel{$ENDIF}(XD+CX,YD+CY,C);
    Inc(CX);
   Until(CX>=X)or(Eof(W));
   Inc(CY);
  Until(CY>=Y)or(Eof(W));
  If Not(CY>=Y)Then Fatal(CONCAT('PROC[LOADPIC]- DRW FILE: ',N,' DOES NOT APPEAR TO BE A VALID DWG FILE'));
  System.Close(W);
 {$ENDIF}
End;

Procedure ShowPicByName(Name:S10;X,Y:Integer);Var C:Byte;Begin
 C:=FindPic(Name);
 PutImage(X,Y,Pics[C].Pic^{$IFNDEF High},NormalPut{$ENDIF});
End;

Procedure ShowPicByNum(N:Byte;X,Y:Integer);Begin
 PutImage(X,Y,Pics[N].Pic^{$IFNDEF High},NormalPut{$ENDIF});
End;

Procedure UpdateBoard(N:Byte);Var Per:Real;S:String;Begin
 {$IFDEF High}
  If(N=1)or(N=255)Then Begin
  Per:=(GShipStrength/GShipStrengthTotal)*100;
  System.Str(Per:0:0,S);
{  OutTxtXY(66,5,'ЫЫЫЫЫ',White);
  OutTxtXY(66,5,s+'%',0);}
  PutGTxtXY(66,3,StrUSpc(s+'%',5),(White shl 4)+Black);
 End;
 If(N=2)or(N=255)Then Begin
  Per:=(OnLaser/LType[OnWeapon].Limit)*100;
  System.Str(Per:0:0,S);
{  OutTxtXY(186,5,'ЫЫЫЫЫ',White);
  OutTxtXY(186,5,s+'%',0);}
  PutGTxtXY(186,3,StrUSpc(s+'%',5),(White shl 4)+Black);
 End;
 If(N=3)or(N=255)Then Begin
{  OutTxtXY(253,5,'ЫЫЫЫЫЫЫЫЫЫ',White);}
  System.Str(Money,S);
{  OutTxtXY(253,5,S,0);}
  PutGTxtXY(253,3,StrUSpc(S,10),Black+(White shl 4));
 End;
 If(N=4)or(N=255)Then Begin
{  OutTxtXY(360,5,'ЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫ',7);}
  If Not(OnWeapon in[11..16])Then
  {OutTxtXY(360,5,LType[OnWeapon].Name,Black);}
   PutGTxtXY(360,3,LType[OnWeapon].Name,Black+(LightGray shl 4));
  If OnWeapon in[11..16]Then Begin
   System.Str(LType[OnWeapon].Num,S);
{   OutTxtXY(360,5,Concat(LType[OnWeapon].Name,'[',S,']'),Black);}
   PutGTxtXY(360,3,StrUSpc(Concat(LType[OnWeapon].Name,'[',S,']'),27),Black+(LightGray shl 4));
  End;
 End;
 {$ELSE}
 If(N=1)or(N=255)Then Begin
  Per:=(GShipStrength/GShipStrengthTotal)*100;
  System.Str(Per:0:0,S);
  SetColor(White);
  OutTextXY(66,5,'ЫЫЫЫЫ');
  SetColor(0);
  OutTextXY(66,5,s+'%');
 End;
 If(N=2)or(N=255)Then Begin
  Per:=(OnLaser/LType[OnWeapon].Limit)*100;
  System.Str(Per:0:0,S);
  SetColor(White);
  OutTextXY(186,5,'ЫЫЫЫЫ');
  SetColor(0);
  OutTextXY(186,5,s+'%');
 End;
 If(N=3)or(N=255)Then Begin
  SetColor(White);
  OutTextXY(253,5,'ЫЫЫЫЫЫЫЫЫЫ');
  SetColor(0);
  System.Str(Money,S);
  OutTextXY(253,5,S);
 End;
 If(N=4)or(N=255)Then Begin
  SetColor(7);
  OutTextXY(360,5,'ЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫ');
  SetColor(Black);
  If Not(OnWeapon in[11..16])Then OutTextXY(360,5,LType[OnWeapon].Name);
  If OnWeapon in[11..16]Then Begin
   System.Str(LType[OnWeapon].Num,S);
   OutTextXY(360,5,Concat(LType[OnWeapon].Name,'[',S,']'));
  End;
 End;
 {$ENDIF}
End;

Procedure FireLaser;Begin
 If Not(OnWeapon in[11..16])Then Begin
  If(OnLaser<=LType[OnWeapon].Limit)and(OnLaser<=MaxNumOfLasers)Then Begin
   Inc(OnLaser);
   Las[OnLaser].X:=SX+LType[OnWeapon].Orrientation;
   Las[OnLaser].Y:=SY-Pics[LType[OnWeapon].PicN].YDim;
   UpDateBoard(2);
  End;
 End;
 If OnWeapon in[11..16]Then Begin
  If(OnLaser<=LType[OnWeapon].Limit)and(OnLaser<=MaxNumOfLasers)and(LType[OnWeapon].Num>0)Then Begin
   Inc(OnLaser);
   Las[OnLaser].X:=SX+LType[OnWeapon].Orrientation;
   Las[OnLaser].Y:=SY-Pics[LType[OnWeapon].PicN].YDim;
   Dec(LType[OnWeapon].Num);
   UpDateBoard(2);
   UpDateBoard(4);
  End;
 End;
End;

Procedure FireEnemyLaser(C:Byte);Begin
 If(EOnLaser+1<MaxNumOfEnemyLasers)Then Begin
  Inc(EOnLaser);
  ELas[EOnLaser].X:=E[C].X+Et[E[C].Et].Orrientation;
  ELas[EOnLaser].Y:=E[C].Y+Pics[Et[E[C].Et].PicN].YDim;
  ELas[EOnLaser].LType:=Et[E[C].Et].WNum;
  ELas[EOnLaser].Et:=E[C].Et;
 End;
End;

Procedure MakeEnemy(N:Byte);Begin
 If(OnEnemy+1<MaxNumOfEnemies)Then Begin
  Inc(OnEnemy);
  E[OnEnemy].X:=Random(639-(Pics[Et[N].PicN].XDim))+Pics[Et[N].PicN].XDim;
  E[OnEnemy].Y:=50;
  E[OnEnemy].Et:=N;
  E[OnEnemy].Strength:=Et[E[OnEnemy].Et].Strength;
  E[OnEnemy].Stage:=0;
 End;
End;

Procedure MakeEnemyFixed(N:Byte;X:Integer);Begin
 If OnEnemy+1<MaxNumOfEnemies Then Begin
  Inc(OnEnemy);
  E[OnEnemy].X:=X;
  E[OnEnemy].Y:=50;
  E[OnEnemy].Et:=N;
  E[OnEnemy].Strength:=Et[E[OnEnemy].Et].Strength;
 End;
End;

Procedure PrepBoard;Begin
 {$IFNDEF High}
  SetFillStyle(1,7);
  Bar(0,0,639,19);
  SetFillStyle(1,0);
 {$ELSE}
  PutFillBox(0,0,639,19,7);
 {$ENDIF}
 DrawDrwFile(0,0,Concat(PicDirec,'\BOARD1.DRW'));
 DrawDrwFile(55,0,Concat(PicDirec,'\BOARD2.DRW'));
 {$IFDEF High}
  OutTxtXY(5,3,'Shields ',0);
  _SetKr(0);
 {$ELSE}
  SetColor(0);
  OutTextXY(5,5,'Shields ');
 {$ENDIF}
 DrawDrwFile(120,0,ConCat(PicDirec,'\BOARD1.DRW'));
 drawdrwfile(175,0,ConCat(PicDirec,'\BOARD2.DRW'));
 {$IFDEF High}
  OutTxtXY(125,3,'Coolant',GraphColor);
 {$ELSE}
  OutTextXY(125,5,'Coolant');
 {$ENDIF}
 DrawDrwFile(240,0,ConCat(PicDirec,'\BOARD1.DRW'));
 DrawDrwFile(295,0,ConCat(PicDirec,'\BOARD2.DRW'));
 {$IFDEF High}
  OutTxtXY(245,3,'$',0);
  _SetKr(0);
 {$ELSE}
  SetColor(0);
  OutTextXY(245,5,'$');
 {$ENDIF}
End;

Procedure CleanPics;Var C,X,Y:Byte;Begin
 C:=1;
 Repeat;Pics[C].Name:='';Inc(C)Until C>NumOfPictures;
End;

Procedure CleanAnimations;Var C:Byte;Begin
 C:=1;
 Repeat Ani[C].Name:='';Inc(C)Until C>NumOfPatterns;
End;

Procedure CleanMovers;Var C:Byte;Begin
 C:=1;
 Repeat Mov[C].Name:='';Inc(C)Until C>NumOfMovers;
End;

Procedure CleanWeaponTypes;Var C:Byte;Begin
 ClearD:=False;Warp:=0;C:=1;
 Repeat
  LType[C].Name:='';LType[C].CDel:=0;LType[C].Num:=0;Inc(C)
 Until C>MaxTypesOfLasers;
End;

Procedure CleanLasers;Var C:Byte;Begin
 C:=1;
 OnLaser:=0;
 Repeat
  Las[C].X:=-1;
  Las[C].Y:=-1;
  Inc(C);
 Until C>MaxNumOfLasers;
 EOnLaser:=0;
 C:=1;
 Repeat
  ELas[C].X:=-1;
  ELas[C].Y:=-1;
  ELas[C].LType:=0;
  Inc(C);
 Until C>MaxNumOfEnemyLasers;
End;

Procedure CleanEnemies;Var C:Byte;Begin
 C:=1;OnEnemy:=0;
 Repeat
  E[C].X:=-1;E[C].Y:=-1;E[C].Et:=0;E[C].CDel:=0;Inc(C)
 Until C>MaxNumOfEnemies;
End;

Procedure CleanStars;Var C:Byte;Begin
 C:=1;
 Randomize;
 Repeat
  S[C].X:=-1;
  S[C].Y:=-1;
  S[C].SType:=Random(3)+1;
  If S[C].SType=1Then S[C].PicN:=FindPic('star1');
  If S[C].SType=2Then S[C].PicN:=FindPic('star2');
  If S[C].SType=3Then S[C].PicN:=FindPic('star3');
  Inc(C);
 Until C>NumOfStars;
End;

Procedure EndLevel;Var X1,Y1,X2,Y2,X3,Y3:Integer;Begin
 {$IFDEF High}
  SetVideoModeDeluxe(vmGrf640x480c256);
 {$ELSE}
  GInit640x480x16(BgiDirec);
  ClearDevice;
 {$ENDIF}
 X1:=(640 shr 1)-(PicS[1].XDim shr 1);
 Y1:=490;
 X2:=(X1-100);
 Y2:=520;
 X3:=((X1+Pics[1].XDim)+(100-(Pics[1].XDim)));
 Y3:=520;
 Repeat
  {delay(3);}WaitRetrace;
  ShowPicByNum(1,X1,Y1);
  ShowPicByNum(1,X2,Y2);
  ShowPicByNum(1,X3,Y3);
  {$IFDEF High}
   _SetKr(0);
   _Ln(X1,Y1+Pics[1].YDim,X1+Pics[1].XDim,Y1+Pics[1].YDim);
   _Ln(X2,Y2+Pics[1].YDim,X2+Pics[1].XDim,Y2+Pics[1].YDim);
   _Ln(X3,Y3+Pics[1].YDim,X3+Pics[1].XDim,Y3+Pics[1].YDim);
   SetPixel((X1+(Pics[1].XDim div 2)-1)+Random(3),Y1+Pics[1].YDim,4);
   SetPixel((X2+(Pics[1].XDim div 2)-1)+Random(3),Y2+Pics[1].YDim,4);
   SetPixel((X3+(Pics[1].XDim div 2)-1)+Random(3),Y3+Pics[1].YDim,4);
   SetPixel(((X1-1)+Random(3))+3,Y1+Pics[1].YDim,White);
   SetPixel(((X2-1)+Random(3))+3,Y2+Pics[1].YDim,White);
   SetPixel(((X3-1)+Random(3))+3,Y3+Pics[1].YDim,White);
   SetPixel((((X1+Pics[1].XDim)-1)+Random(3))-3,Y1+Pics[1].YDim,Blue);
   SetPixel((((X2+Pics[1].XDim)-1)+Random(3))-3,Y2+Pics[1].YDim,Blue);
   SetPixel((((X3+Pics[1].XDim)-1)+Random(3))-3,Y3+Pics[1].YDim,Blue);
  {$ELSE}
  SetColor(0);
  Line(X1,Y1+Pics[1].YDim,X1+Pics[1].XDim,Y1+Pics[1].YDim);
  Line(X2,Y2+Pics[1].YDim,X2+Pics[1].XDim,Y2+Pics[1].YDim);
  Line(X3,Y3+Pics[1].YDim,X3+Pics[1].XDim,Y3+Pics[1].YDim);
  PutPixel((X1+(Pics[1].XDim div 2)-1)+Random(3),Y1+Pics[1].YDim,4);
  PutPixel((X2+(Pics[1].XDim div 2)-1)+Random(3),Y2+Pics[1].YDim,4);
  PutPixel((X3+(Pics[1].XDim div 2)-1)+Random(3),Y3+Pics[1].YDim,4);
  PutPixel(((X1-1)+Random(3))+3,Y1+Pics[1].YDim,White);
  PutPixel(((X2-1)+Random(3))+3,Y2+Pics[1].YDim,White);
  PutPixel(((X3-1)+Random(3))+3,Y3+Pics[1].YDim,White);
  PutPixel((((X1+Pics[1].XDim)-1)+Random(3))-3,Y1+Pics[1].YDim,Blue);
  PutPixel((((X2+Pics[1].XDim)-1)+Random(3))-3,Y2+Pics[1].YDim,Blue);
  PutPixel((((X3+Pics[1].XDim)-1)+Random(3))-3,Y3+Pics[1].YDim,Blue);
  {$ENDIF}
  Dec(Y3);
  Dec(Y2);
  Dec(Y1);
 Until Y1=0;
 {$IFDEF High}
  OutTxtXY((640 shr 1)-((8*8*10)shr 1),300,'You Win!',White);
 {$ELSE}
  SetTextStyle(Defaultfont,0,10);
  SetColor(White);
  OutTextXY((640 shr 1)-((8*8*10)shr 1),300,'You Win!');
 {$ENDIF}
 ReadLn;
 {$IFNDEF High}
  SetTextStyle(DefaultFont,0,1);
  ClearDevice;
 {$ENDIF}
 Proc:='finish';
 Cont:=0;
 {$IFNDEF High}
  SetFillStyle(1,0);
 {$ENDIF}
End;

Procedure LoadNext;Var C:Byte;S:String;Begin
 MP.Del:=0;GlobalDel:=1;MP.OnPart:=1;Inc(MP.OnLevel);
 {$I-}
 Reset(Map);
 {$I+}
 If IOResult<>0Then Fatal(Concat('PROC[LOADNEXT]- CANNOT FIND MAP: ',MP.FileN));
 C:=1;
 Repeat
  ReadLn(Map,S);
  Inc(C)
 Until C>MP.LastLine;
 ReadLn(Map,S);
 Inc(MP.LastLine);
 If S='[End Level]'Then EndLevel;
 If S<>'[End Level]'Then Begin
  MP.Name:=S;
  If StrUp(s)<>'[NEW PART]'Then Fatal('PROC[LOADNEXT]- MAP CORRUPTED (2)');
  C:=1;
  Repeat
   If StrUp(s)<>'[END PART]'Then ReadLn(Map,Part[C]);
   S:=Part[C];
   Inc(MP.LastLine);
   Inc(C);
  Until(StrUp(s)='[END PART]')or(Eof(Map))or(C>MaxPartsOfMap);
  If Eof(Map)Then Fatal('PROC[LOADNEXT]- MAP CORRUPTED (3)');
  If C>MaxPartsOfMap Then Fatal('PROC[LOADNEXT]- MAP CORRUPTED, PART TOO LONG');;
 End;
End;

Procedure CleanMap;Var S:String;Begin
 {$I-}
 System.Close(Map);
 {$I+}
 If IOResult<>0Then S:='';
 MP.Del:=0;
 GlobalDel:=1;
 MP.OnPart:=1;
 MP.OnLevel:=1;
 MP.LastLine:=0;
 Assign(Map,MP.FileN);
 {$I-}
 Reset(Map);
 {$I+}
 If IOResult<>0Then Fatal(Concat('PROC[CLEANMAP]- CANNOT FIND MAP: ',MP.FileN));
 ReadLn(Map,MP.Name);
 If Pos('LEVEL NAME:',StrUp(MP.Name))=0Then Fatal('PROC[CLEANMAP]- MAP CORRUPTED (1)');
 Delete(MP.Name,1,11);
 ReadLn(Map,S);
 If StrUp(S)<>'[NEW PART]'Then Fatal('PROC[CLEANMAP]- MAP CORRUPTED (2)');
 MP.LastLine:=2;
 Repeat
  If StrUp(s)<>'[END PART]'Then ReadLn(Map,Part[MP.LastLine-1]);
  S:=Part[MP.LastLine-1];
  Inc(MP.LastLine)
 Until(StrUp(S)='[END PART]')or(Eof(Map))or(MP.LastLine-1>MaxPartsOfMap);
 If Eof(Map)Then Fatal('PROC[CLEANMAP]- MAP CORRUPTED (3)');
 If(MP.LastLine-1>MaxPartsOfMap)Then Fatal('PROC[CLEANMAP]- MAP CORRUPTED, PART TOO LONG (4)')
End;

Procedure CleanExplosions;Var C:Byte;Begin
 OnExp:=0;C:=1;
 Repeat
  Exp[C].X:=-1;Exp[C].On:=0;Exp[C].Dim:=0;Inc(C)
 Until C>MaxNumOfExplosions
End;

Procedure LoadGamePictures;Var W:Text;S,S2:String;S1:S10;Begin
 Assign(W,Concat(WorkDirec,'\ASSIGN.PIC'));
 {$I-}
 Reset(W);
 {$I+}
 If IOResult<>0Then Fatal('PROC[LOADGAMEPICTURES]- CANNOT FIND CRUCIAL FILE: ASSIGN.PIC');
 Repeat;ReadLn(W,S)Until(S='[Picture assignments]')or(Eof(W));
 If(S<>'[Picture assignments]')Then Fatal('PROC[LOADGAMEPICTURES(1)]- CORRUPTED GAME FILE: ASSIGN.PIC');
 Repeat
  ReadLn(W,S);
  If Pos(':',S)>0Then Begin
   S1:=Copy(S,1,Pos(':',s)-1);
   Delete(S,1,Pos(':',s));
   S2:=S;
   LoadPic(Concat(PicDirec,S2),S1);
  End;
 Until(S='[End. Picture assignments]')or(Eof(W));
 If(S<>'[End. Picture assignments]')Then Fatal('PROC[LOADGAMEPICTURES(2)]- CORRUPTED GAME FILE: ASSIGN.PIC');
 System.Close(W)
End;

Procedure LoadGameAni;Var W:Text;S,S2,Check:String;S1:S10;Begin
 Assign(W,Concat(WorkDirec,'\assign.pic'));
 {$I-}
 Reset(W);
 {$I+}
 If IOResult<>0Then Fatal('PROC[LOADGAMEANI]- CANNOT FIND CRUCIAL FILE: ASSIGN.PIC');
 Repeat;Readln(w,s)Until(S='[Animation assignments]')or(Eof(W));
 If(S<>'[Animation assignments]')Then Fatal('PROC[LOADGAMEANI(1)]- CORRUPTED GAME FILE: ASSIGN.PIC');
 Repeat
  ReadLn(W,Check);
  S1:='';
  If Check='[New]'Then Begin
   ReadLn(W,S1);
   ReadLn(W,S);
   ReadLn(W,S2);
  End;
  If S1[1]=':'Then Begin
   Delete(S1,1,1);
   LoadAni(S1,S,S2);
  End;
 Until(Check='[End. Animation assignments]')or(Eof(W));
 If Check<>'[End. Animation assignments]'Then Fatal('PROC[LOADGAMEANI(2)]- CORRUPTED GAME FILE: ASSIGN.PIC');
 System.Close(W);
End;

Procedure LoadGameWeapons;Var W:Text;S,F:String;N:Byte;

 Procedure FatalCall(N:Char);Begin
  Fatal(Concat('PROC[LOADGAMEWEAPONS] (',N,')- CORRUPTED CRUCIAL FILE: WEAPON.INF'));
 End;

Begin
 Assign(W,Concat(WorkDirec,'\WEAPON.INF'));
 {$I-}
 Reset(W);
 {$I+}
 OnWeapon:=1;
 If IOResult<>0Then Fatal('PROC[LOADGAMEWEAPONS]- CANNOT FIND CRUCIAL FILE: WEAPON.INF');
 N:=1;
 ReadLn(W,S);
 Repeat
  ReadLn(W,S);
  If S[1]<>'['Then FatalCall('1');
  If S[Length(S)]<>']'Then FatalCall('2');
  Delete(S,1,1);
  If Pos('//',S)=0Then LType[N].Name:=Systems.Left(S,Pos(']',S)-1);
  If Pos('//',S)>0Then Begin
   LType[N].Des:='';
   LType[N].Name:=Systems.Left(S,Pos('//',s)-1);
   Delete(S,1,Pos('//',s)+1);
   LType[N].Des:=Systems.Left(S,Pos(']',S)-1);
  End;
  Readln(W,S);
  F:='picture name=';
  If Pos(StrUp(F),StrUp(S))=0Then FatalCall('3');
  Delete(S,1,Length(F));
  LType[N].PicN:=FindPic(S);
  ReadLn(W,S);
  F:='jump=';
  If Pos(StrUp(F),StrUp(S))=0Then FatalCall('4');
  Delete(S,1,Length(F));
  Val(S,LType[N].Jump,Error);
  If Error<>0Then FatalCall('J');
  ReadLn(W,S);
  F:='delay=';
  If Pos(StrUp(F),StrUp(S))=0Then FatalCall('5');
  Delete(S,1,Length(F));
  Val(S,LType[N].Del,Error);
  If Error<>0Then FatalCall('D');
  ReadLn(W,S);
  F:='link=';
  If Pos(StrUp(F),StrUp(S))=0Then FatalCall('6');
  Delete(S,1,Length(F));
  Val(S,LType[N].Link,Error);
  If Error<>0Then FatalCall('L');
  ReadLn(W,S);
  F:='link space=';
  If Pos(StrUp(F),StrUp(S))=0Then FatalCall('7');
  Delete(S,1,Length(F));
  Val(S,LType[N].LinkSpace,Error);
  If Error<>0Then FatalCall('S');
  ReadLn(W,S);
  F:='price=';
  If Pos(StrUp(F),StrUp(S))=0Then FatalCall('8');
  Delete(S,1,Length(F));
  Val(S,LType[N].Price,Error);
  If Error<>0Then FatalCall('P');
  ReadLn(W,S);
  F:='possess=';
  If Pos(StrUp(f),StrUp(S))=0Then FatalCall('9');
  Delete(S,1,Length(F));
  If(StrUp(S)<>'TRUE')and(StrUp(S)<>'FALSE')Then FatalCall('H');
  If StrUp(S)='TRUE'Then LType[N].Possess:=True;
  If StrUp(s)='FALSE'Then LType[N].Possess:=False;
  ReadLn(W,S);
  F:='damage=';
  If Pos(StrUp(F),StrUp(S))=0Then FatalCall('Z');
  Delete(S,1,Length(F));
  Val(S,LType[N].Damage,Error);
  If Error<>0Then FatalCall('D');
  ReadLn(W,S);
  F:='range=';
  If Pos(StrUp(F),StrUp(S))=0Then FatalCall('Y');
  Delete(S,1,Length(F));
  Val(S,LType[N].Range,Error);
  If Error<>0Then FatalCall('R');
  ReadLn(W,S);
  F:='limit=';
  If Pos(StrUp(F),StrUp(S))=0Then FatalCall('X');
  Delete(S,1,Length(F));
  Val(S,LType[N].Limit,Error);
  If Error<>0Then FatalCall('T');
  ReadLn(W,S);
  F:='orrientation=';
  If Pos(StrUp(F),StrUp(S))=0Then FatalCall('W');
  Delete(S,1,Length(F));
  Val(S,LType[N].Orrientation,Error);
  If Error<>0Then FatalCall('O');
  LType[N].Num:=0;
  Inc(N);
 Until Eof(W);
 System.Close(W);
End;

Procedure LoadGameEnemies;Var W:Text;S,F:String;N:Byte;

Procedure FatalCall(N:Char);Begin
 Fatal(Concat('PROC[LOADGAMEENEMIES] (',N,')- CORRUPTED CRUCIAL FILE: ENEMY.INF'));
End;

Begin
 Assign(W,Concat(WorkDirec,'\ENEMY.INF'));
 {$I-}
 Reset(W);
 {$I+}
 If IOResult<>0Then Fatal('PROC[LOADGAMEENEMIES]- CANNOT FIND CRUCIAL FILE: ENEMY.INF');
 ReadLn(W,S);
 N:=1;
 Repeat
  ReadLn(W,S);
  If S<>'[New]'Then FatalCall('1');
  ReadLn(W,S);
  F:='picture name=';
  If Pos(StrUp(F),StrUp(S))=0Then FatalCall('2');
  Delete(S,1,Length(F));
  Et[N].PicN:=FindPic(S);
  Et[N].MidX:=Pics[Et[N].PicN].XDim div 2;
  Et[N].MidY:=Pics[Et[N].PicN].YDim div 2;
  ReadLn(W,S);
  F:='point value=';
  If Pos(StrUp(F),StrUp(S))=0Then FatalCall('3');
  Delete(S,1,Length(f));
  Val(S,Et[N].PointValue,Error);
  If Error<>0Then FatalCall('A');
  ReadLn(W,S);
  F:='strength=';
  If Pos(StrUp(F),StrUp(S))=0Then FatalCall('4');
  Delete(S,1,Length(F));
  Val(S,Et[N].Strength,Error);
  If Error<>0Then FatalCall('B');
  ReadLn(W,S);
  F:='jump=';
  If Pos(StrUp(F),StrUp(S))=0Then FatalCall('5');
  Delete(S,1,Length(F));
  Val(S,Et[N].Jump,Error);
  If Error<>0Then FatalCall('C');
  ReadLn(W,S);
  F:='delay=';
  If Pos(StrUp(F),StrUp(S))=0Then FatalCall('6');
  Delete(S,1,Length(F));
  Val(S,Et[N].Del,Error);
  If Error<>0Then FatalCall('D');
  ReadLn(W,S);
  F:='ram damage=';
  If Pos(StrUp(F),StrUp(S))=0Then FatalCall('7');
  Delete(S,1,Length(F));
  Val(S,Et[N].DamageByRam,Error);
  If Error<>0Then FatalCall('E');
  ReadLn(W,S);
  F:='weapon type=';
  If Pos(StrUp(F),StrUp(S))=0Then FatalCall('8');
  Delete(S,1,Length(F));
  Val(S,Et[N].WNum,Error);
  If Error<>0Then FatalCall('F');
  ReadLn(W,S);
  F:='chance of shot=';
  If Pos(StrUp(F),StrUp(S))=0Then FatalCall('9');
  Delete(S,1,Length(F));
  Val(S,Et[N].ChanceOfShot,Error);
  If Error<>0Then FatalCall('G');
  ReadLn(W,S);
  F:='weapon power=';
  If Pos(StrUp(F),StrUp(S))=0Then FatalCall('Z');
  Delete(S,1,Length(F));
  Val(S,Et[N].WeapPow,Error);
  If Error<>0Then FatalCall('H');
  ReadLn(W,S);
  F:='orrientation=';
  If Pos(StrUp(F),StrUp(S))=0Then FatalCall('Z');
  Delete(S,1,Length(F));
  Val(S,Et[N].Orrientation,Error);
  If Error<>0Then FatalCall('H');
  Inc(N);
 Until(Eof(W))or(N>MaxTypesOfEnemies);
 If N>MaxTypesOfEnemies Then Fatal('PROC[LOADGAMEENEMIES]- MAX. NUM OF ENEMIES USED');
 System.Close(W);
 {[New]
 picture name=bship1
 point value=50
 strength=2
 jump=3
 delay=20
 ram damage=20
 weapon type=Class I Lasers
 chance of shot=30
 orrientation=24}
End;

Procedure LoadInitialStarPattern;Var C:Byte;Begin
 C:=1;
 Repeat;S[C].X:=Random(639);S[C].Y:=Random(458)+20;Inc(C)Until C>NumOfStars;
End;

Procedure NewAnimation(Name,PatName:s10;Del:Integer;Repeater:Boolean;X,Y:Integer);Var P,N:Byte;Begin
 P:=FindPattern(PatName);
 N:=FindNextMover;
 Mov[N].BPic:=Ani[P].BPic;
 Mov[N].LPic:=Ani[P].LPic;
 Mov[N].Name:=Name;
 Mov[N].PatName:=PatName;
 Mov[N].CDel:=0;
 Mov[N].Repeater:=Repeater;
 Mov[N].OnPic:=Ani[P].BPic;
 Mov[N].Del:=Del;
 Mov[N].X:=X;
 Mov[N].Y:=Y;
End;

Procedure DeleteMovByNum(N:Byte);Begin
 {$IFDEF High}
  PutFillBox(Mov[N].X,Mov[N].Y,Mov[N].X+Pics[Mov[N].OnPic].XDim,Mov[N].Y+Pics[Mov[N].OnPic].YDim,0);
 {$ELSE}
  Bar(Mov[N].X,Mov[N].Y,Mov[N].X+Pics[Mov[N].OnPic].XDim,Mov[N].Y+Pics[Mov[N].OnPic].YDim);
 {$ENDIF}
 If Mov[N+1].Name=''Then Mov[N].Name:='';
 If Mov[N+1].Name<>''Then Repeat;Mov[N]:=Mov[N+1];Inc(N)Until Mov[N+1].Name='';
End;

Procedure DeleteMovByName(Name:s10);Var N:Byte;Begin
 N:=FindMover(Name);
 {$IFDEF High}
  PutFillBox(Mov[N].X,Mov[N].Y,Mov[N].X+Pics[Mov[N].OnPic].XDim,Mov[N].Y+Pics[Mov[N].OnPic].YDim,0);
 {$ELSE}
  Bar(Mov[N].X,Mov[N].Y,Mov[N].X+Pics[Mov[N].OnPic].XDim,Mov[N].Y+Pics[Mov[N].OnPic].YDim);
 {$ENDIF}
 If Mov[N+1].Name=''Then Mov[N].Name:='';
 If Mov[N+1].Name<>''Then Begin
  Repeat;Mov[N]:=Mov[N+1];Mov[N+1].Name:='';Inc(N)Until Mov[n+1].Name='';
 End;
End;

Procedure ChangeMovXYByName(Name:s10;X,Y:Integer;Clear:Boolean);Var N:Byte;Begin
 N:=FindMover(Name);
 If(Clear)Then Begin
  {$IFDEF High}
   PutFillBox(Mov[N].X,Mov[N].Y,Mov[N].X+Pics[Mov[N].OnPic].XDim,Mov[N].Y+Pics[Mov[N].OnPic].YDim,0)
  {$ELSE}
   Bar(Mov[N].X,Mov[N].Y,Mov[N].X+Pics[Mov[N].OnPic].XDim,Mov[N].Y+Pics[Mov[N].OnPic].YDim)
  {$ENDIF}
 End;
 Mov[N].X:=X;
 Mov[N].Y:=Y;
End;

Procedure ForceMoverFrame(N:Byte);Begin
 PutImage(Mov[N].X,Mov[N].Y,Pics[Mov[N].OnPic].Pic^{$IFNDEF High},NormalPut{$ENDIF});
End;

Procedure ChangeMovXYByNum(N:Byte;X,Y:Integer;Clear:Boolean);Begin
 If(Clear)Then Begin
  {$IFDEF High}
   PutFillBox(Mov[N].X,Mov[N].Y,Mov[N].X+Pics[Mov[N].OnPic].XDim,Mov[N].Y+Pics[Mov[N].OnPic].YDim,Black)
  {$ELSE}
   Bar(Mov[N].X,Mov[N].Y,Mov[N].X+Pics[Mov[N].OnPic].XDim,Mov[N].Y+Pics[Mov[N].OnPic].YDim)
  {$ENDIF}
 End;
 Mov[N].X:=X;Mov[N].Y:=Y;
 ForceMoverFrame(N)
End;

Procedure ShowAnimationFrame(N:Byte);Begin
 PutImage(Mov[N].X,Mov[N].Y,Pics[Mov[N].OnPic].Pic^{$IFNDEF High},NormalPut{$ENDIF});
 Inc(Mov[N].OnPic);
 Mov[N].CDel:=0;
 If(Mov[N].OnPic>Mov[N].LPic)Then Begin
  Mov[N].OnPic:=Mov[N].BPic;
  If Not(Mov[N].Repeater)Then DeleteMovByNum(n);
 End;
End;

Procedure ChangeIni(S,Val:string);Var T,W:Text;S1,S2:String;Begin
 Assign(W,WorkDirec+'\SHIP.INI');
 Assign(T,WorkDirec+'\INI.%mp');
 ReWrite(T);
 {$I-}
 Reset(W);
 {$I+}
 If IOResult<>0Then Fatal('PROC[CHANGEINI]- CANNOT FIND CRUCIAL FILE: SHIP.INI');
 Repeat
  ReadLn(W,S1);
  ReadLn(W,S2);
  If(S1<>S)Then Begin
   Writeln(T,S1);
   Writeln(T,S2);
  End;
 Until Eof(W);
 WriteLn(T,S);
 WriteLn(T,Val);
 Reset(T);
 ReWrite(W);
 Repeat
  ReadLn(T,S1);
  WriteLn(W,S1);
 Until Eof(T);
 System.Close(T);
 System.Close(W);
End;

Function FindIni(S:string):String;Var T:Text;F:String;Begin
 Assign(T,'ship.ini');
 {$I-}
 Reset(T);
 {$I+}
 If IOResult<>0Then Fatal('PROC[FINDINI]- CANNOT FIND CRUCIAL FILE: SHIP.INI');
 Repeat;ReadLn(T,F)Until(Eof(T))or(StrUp(S)=StrUp(F));
 If StrUp(S)<>StrUp(F)Then Fatal('PROC[FINDINI]- CANNOT FIND INI ENTRY: '+S);
 ReadLn(T,F);
 FindIni:=F;
 System.Close(T)
End;

Procedure Clean;Begin
 Total:=0;SlowDown:=1;NoStar:=False;
 If FindIni('[Stars]')='OFF'Then NoStar:=True;
 Val(FindIni('[Slow down]'),SlowDown,Error);
 BGIDirec:=FindIni('[Bgi Directory]');
 PicDirec:=FindIni('[Picture Directory]');
 WorkDirec:=FindIni('[Work Directory]');
 MP.FileN:=WorkDirec+'\MAINMAP.JJM';
 GInit640x480x16(BGIDirec);
 InitEvents;
 MouseChk;
 HideMouse;
 OnWeapon:=1;
 CleanPics;
 CleanAnimations;
 CleanMovers;
 CleanWeaponTypes;
 CleanLasers;
 CleanEnemies;
 CleanMap;
 CleanExplosions;
 {$IFNDEF High}
  SetVisualPage(0);
  SetActivePage(0);
  ClearDevice;
  SetColor(3);
  OutTextXY(0,0,'Loading graphics...');
  SetActivePage(1);
 {$ENDIF}
 LoadGamePictures;
 LoadGameAni;
 LoadGameWeapons;
 LoadGameEnemies;
 CleanStars;
 LoadInitialStarPattern;
 {$IFNDEF High}
  SetActivePage(0);
 {$ENDIF}
 HideMouse;
 Proc:='start';
 SX:=(639 shr 1)-(Pics[1].XDim shr 1);
 FY:=(479-(Pics[FindPic('burn1')].YDim));
 SY:=(FY-(Pics[1].YDim));
 FlameX:=(Pics[1].XDim shr 1)-(Pics[FindPic('burn1')].XDim shr 1);
 GShipStrengthTotal:=InitialShields;
 GShipStrength:=InitialShields;
 LMY:=0;
 LMX:=0;
 Money:=InitialMoney;
 {$IFDEF High}
  ClrScrBlack;
 {$ELSE}
  ClearDevice;
  SetFillStyle(1,0);
 {$ENDIF}
 Cont:=0;
End;

Procedure RemoveLaser(C:Byte);Begin
 If Las[C].Y<0Then Las[C].Y:=0;
 {$IFDEF High}
  PutFillBox(Las[C].X,Las[C].Y,Las[C].X+(Pics[LType[OnWeapon].PicN].XDim-1),
             Las[C].Y+(Pics[LType[OnWeapon].PicN].YDim-1),Black);
 {$ELSE}
  Bar(Las[C].X,Las[C].Y,Las[C].X+(Pics[LType[OnWeapon].PicN].XDim-1),Las[C].Y+(Pics[LType[OnWeapon].PicN].YDim-1));
 {$ENDIF}
 Repeat
  Las[C]:=Las[C+1];Las[C+1].X:=-1;Inc(C)
 Until(Las[C+1].X=-1)or(C>MaxNumOfLasers);
 If OnLaser>0Then Dec(OnLaser);
 UpdateBoard(2);
End;

Procedure RemoveExp(C:Byte);Var L,M:Byte;Begin
 L:=Exp[C].Dim shr 1;
 {$IFDEF High}
  PutFillBox(Exp[C].X-L,Exp[C].Y-L,Exp[C].X+L,Exp[C].Y+L,0);
  PutFillBox(Exp[C].X-25,Exp[C].Y-25,Exp[C].X+25,Exp[C].Y+25,0);
 {$ELSE}
  Bar(Exp[C].X-L,Exp[C].Y-L,Exp[C].X+L,Exp[C].Y+L);
  Bar(Exp[C].X-25,Exp[C].Y-25,Exp[C].X+25,Exp[C].Y+25);
 {$ENDIF}
 Repeat;Exp[C]:=Exp[C+1];Exp[C+1].X:=-1;Inc(C)Until(Exp[C+1].X=-1)or(C>MaxNumOfExplosions);
 Dec(OnExp)
End;

Procedure RemoveElaser(C:Byte);Begin
 {$IFDEF High}
 PutFillBox(ELas[C].X,ELas[C].Y,ELas[C].X+(Pics[LType[ELas[C].LType].PicN].XDim-1),
     ELas[C].Y+(Pics[LType[ELas[C].LType].PicN].YDim-1),Black);
 {$ELSE}
 Bar(ELas[C].X,ELas[C].Y,ELas[C].X+(Pics[LType[ELas[C].LType].PicN].XDim-1),
     ELas[C].Y+(Pics[LType[ELas[C].LType].PicN].YDim-1));
 {$ENDIF}
 Repeat
  Elas[C]:=ELas[C+1];Elas[C+1].X:=-1;Inc(c)
 Until(ELas[C+1].X=-1)or(C>MaxNumOfEnemyLasers);
 If EOnLaser>0Then Dec(EOnLaser);
End;

Procedure RemoveEnemy(C:Byte;Remove:Boolean);Begin
 E[C].Stage:=0;
 If(Remove)Then
 {$IFDEF High}
  PutFillBox(E[C].X,E[C].Y,E[C].X+(Pics[Et[E[C].Et].PicN].XDim-1),E[C].Y+(Pics[Et[E[C].Et].PicN].YDim-1),Black);
 {$ELSE}
  Bar(E[C].X,E[C].Y,E[C].X+(Pics[Et[E[C].Et].PicN].XDim-1),E[C].Y+(Pics[Et[E[C].Et].PicN].YDim-1));
 {$ENDIF}
 Repeat
  E[C]:=E[C+1];E[C+1].X:=-1;Inc(C)
 Until(E[C+1].X=-1)or(C>MaxNumOfEnemies);
 Dec(OnEnemy);
End;

Procedure Mess(Mes:Char;Col:Byte;On:Boolean);Begin
 If Not(On)Then Begin
  {$IFDEF High}
   PutFillBox(620,1,640,19,0);
  {$ELSE}
   SetFillStyle(1,7);
   Bar(620,1,640,19);
  {$ENDIF}
  ClearD:=False;
  {$IFDEF High}
   _SetKr(0);
  {$ELSE}
   SetFillStyle(1,0);
  {$ENDIF}
 End;
 If(On)Then Begin
  {$IFDEF High}
   PutFillBox(620,1,640,19,Col);
   OutTxtXY(627,9,Mes,White);
   _SetKr(0);
  {$ELSE}
   SetFillStyle(1,Col);
   Bar(620,1,640,19);
   SetColor(White);
   OutTextXY(627,9,Mes);
   SetFillStyle(1,0);
  {$ENDIF}
  ClearD:=True;
 End;
End;

Procedure Explode(X,Y:Integer;Dim:Byte);Begin
 If(OnExp+1<MaxNumOfExplosions)Then Begin
  Inc(OnExp);
  Exp[OnExp].X:=X;
  Exp[OnExp].Y:=Y;
  Exp[OnExp].Dim:=Dim;
  Exp[OnExp].On:=0;
  Exp[OnExp+1].X:=-1;
  Exp[OnExp+1].Y:=-1;
  Exp[OnExp+1].Dim:=0;
  Exp[OnExp+1].On:=0;
 End;
End;

Procedure DamageGShip(C:Integer);Var Ch:Byte;Begin
 If(LType[19].Possess)Then Begin
  Ch:=Random(2);
  If Ch=0Then Dec(GShipStrength,C shr 1);
  If Ch=1Then Dec(GShipStrength,C);
 End;
 If Not(LType[19].Possess)Then Dec(GShipStrength,C);
 UpDateBoard(1);
 If(LType[17].possess)Then Mess('D',Red,True);
 If GShipStrength<=0Then Proc:='kill';
End;

Procedure DestroyEnemy(Ec:Byte);Begin
 Explode(E[Ec].X+(Pics[Et[E[Ec].Et].PicN].XDim shr 1),
 E[Ec].Y+(Pics[Et[E[Ec].Et].PicN].YDim shr 1),Pics[Et[E[Ec].Et].PicN].XDim);
 Inc(Money,Et[E[Ec].Et].PointValue);
 UpDateBoard(3);
 RemoveEnemy(Ec,False)
End;

Procedure ChkLaserPosition;Var N,Ec,Lc:Byte;Begin
 Ec:=1;
 Repeat
  Lc:=1;
  Repeat
   If(Las[Lc].X>(E[Ec].X-LType[OnWeapon].Range))and(Las[Lc].X<(E[Ec].X+Pics[Et[E[Ec].Et].PicN].XDim+LType[OnWeapon].Range))Then
   Begin
    If(Las[Lc].Y+LType[OnWeapon].Jump>E[Ec].Y)and
      (Las[Lc].Y<(E[Ec].Y+Pics[Et[E[Ec].Et].PicN].YDim)+LType[OnWeapon].Jump)Then Begin
     RemoveLaser(Lc);
     Dec(E[Ec].Strength,LType[OnWeapon].Damage);
    End;
   End;
   Inc(Lc);
  Until Lc>OnLaser;
  Inc(Ec);
 Until Ec>OnEnemy;
 Ec:=1;
 Repeat
  If E[Ec].Strength<=0Then Begin
   E[Ec].CDel:=0;
   DestroyEnemy(Ec);
  End;
  Inc(Ec);
 Until Ec>OnEnemy
End;

Procedure ChkEnemyLaserPosition;Var Lc:Byte;Begin
 Lc:=1;
 Repeat
  If(ELas[Lc].X>SX-LType[ELas[Lc].LType].Range)and(ELas[Lc].X<SX+Pics[1].XDim+LType[ELas[Lc].LType].XDim)Then Begin
   If(Elas[Lc].Y>SY-Pics[LType[ELas[Lc].LType].PicN].YDim)Then Begin
    DamageGShip(Et[ELas[Lc].Et].WeapPow);
    RemoveElaser(Lc);
   End;
  End;
  Inc(Lc);
 Until Lc>EOnLaser;
End;

Procedure ChkEnemyPosition;Var Ec:Byte;W:Integer;Begin
 Ec:=1;
 Repeat
  W:=E[Ec].X+Pics[Et[E[Ec].Et].PicN].XDim;
  If(E[Ec].Y+Pics[Et[E[Ec].Et].PicN].YDim>SY)Then Begin
   If((E[Ec].X<SX+Pics[1].XDim)and(E[Ec].X>SX))or((W<SX+Pics[1].XDim)and(W>SX))Then Begin
    DamageGShip(Et[E[Ec].Et].DamageByRam);
    DestroyEnemy(Ec);
   End;
  End;
  Inc(Ec);
 Until Ec>OnEnemy;
End;

Procedure UpDateExp;Var C,D:Byte;Begin
 If OnExp>0Then Begin
  C:=1;
  Repeat
   If Exp[C].On=255Then RemoveExp(c);
   Inc(C);
  Until C>OnExp;
  C:=1;
  Repeat
   Inc(Exp[C].On);
   Exp[C].Last:=Exp[C].On;
   If Exp[C].On=5Then ShowPicByNum(B50,Exp[C].X-25,Exp[C].Y-25);
   If(Exp[C].Dim>40)and(Exp[C].On=5)Then Exp[C].On:=255;
   If Exp[C].On=4Then ShowPicByNum(B40,Exp[C].X-20,Exp[C].Y-20);
   If(Exp[C].Dim<=40)and(Exp[C].On=4)Then Exp[C].On:=255;
   If(Exp[C].On=3)Then ShowPicByNum(B30,Exp[C].X-15,Exp[C].Y-15);
   If(Exp[C].Dim<=30)and(Exp[C].On=3)Then Exp[C].On:=255;
   If Exp[C].On=2Then ShowPicByNum(B20,Exp[C].X-10,Exp[C].Y-10);
   If(Exp[C].Dim<=20)and(Exp[C].On=2)Then Exp[C].On:=255;
   If Exp[C].On=1Then ShowPicByNum(B10,Exp[C].X-5,Exp[C].Y-5);
   If(Exp[C].Dim<=10)and(Exp[C].On=1)Then Exp[C].On:=255;
   Inc(C);
  Until C>OnExp;
 End;
End;

Procedure UpDateStars;Var C:Byte;Ly:Integer;Begin
 SCDel:=0;C:=1;
 Repeat
  {$IFDEF High}
   _PutFillBox(S[C].X,S[C].Y,S[C].X+(Pics[S[C].PicN].XDim-1),S[C].Y+(Pics[S[C].PicN].YDim-1));
  {$ELSE}
   Bar(S[C].X,S[C].Y,S[C].X+(Pics[S[C].PicN].XDim-1),S[C].Y+(Pics[S[C].PicN].YDim-1));
  {$ENDIF}
  Ly:=S[C].Y;
  If S[C].SType=1Then Inc(S[C].Y,6+Warp);
  If S[C].SType=2Then Inc(S[C].Y,10+Warp);
  If S[C].SType=3Then Inc(S[C].Y,3+Warp);
  If S[C].Y>479Then Begin
   S[C].Y:=LY;
   {$IFDEF High}
    _PutFillBox(S[C].X,S[C].Y,S[C].X+(Pics[S[C].PicN].XDim-1),S[C].Y+(Pics[S[C].PicN].YDim-1));
   {$ELSE}
    Bar(S[C].X,S[C].Y,S[C].X+(Pics[S[C].PicN].XDim-1),S[C].Y+(Pics[S[C].PicN].YDim-1));
   {$ENDIF}
   S[C].Y:=20;S[C].X:=Random(638)+1;
  End;
  ShowPicByNum(S[C].PicN,S[C].X,S[C].Y);
  Inc(C);
 Until C>NumOfStars;
End;

Procedure UpDateLasers;Var C:Byte;Ly:Integer;Begin
 LType[OnWeapon].CDel:=0;C:=1;
 If OnLaser>0Then Begin
  Repeat
   {$IFDEF High}
    _PutFillBox(Las[C].X,Las[C].Y-LType[OnWeapon].Jump,
    Las[C].X+(Pics[LType[OnWeapon].PicN].XDim-1),Las[C].Y+(Pics[LType[OnWeapon].PicN].YDim-1));
   {$ELSE}
    Bar(Las[C].X,Las[C].Y-LType[OnWeapon].Jump,
    Las[C].X+(Pics[LType[OnWeapon].PicN].XDim-1),Las[C].Y+(Pics[LType[OnWeapon].PicN].YDim-1));
   {$ENDIF}
   Ly:=Las[C].Y;
   Dec(Las[C].Y,LType[OnWeapon].Jump);
   If Las[C].Y<23Then Begin
    Las[C].Y:=LY;
    RemoveLaser(C);
   End;
   Inc(C);
  Until(Las[C].X=-1)or(C>MaxNumOfLasers);
  C:=1;
  While Las[C].X<>-1do Begin
   ShowPicByNum(LType[OnWeapon].PicN,Las[C].X,Las[C].Y);
   Inc(C);
  End;
 End;
End;

Procedure UpDateEnemyLasers;Var C:Byte;Ly:Integer;Begin
 C:=1;
 Repeat
  {$IFDEF High}
   _PutFillBox(ELas[C].X,(ELas[C].Y-(LType[ELas[C].LType].Jump+Warp)),ELas[C].X+(Pics[LType[ELas[C].LType].PicN].XDim-1),
   ELas[C].Y+(Pics[LType[ELas[C].LType].PicN].YDim-1));
  {$ELSE}
   Bar(ELas[C].X,(ELas[C].Y-(LType[ELas[C].LType].Jump+Warp)),ELas[C].X+(Pics[LType[ELas[C].LType].PicN].XDim-1),
   ELas[C].Y+(Pics[LType[ELas[C].LType].PicN].YDim-1));
  {$ENDIF}
  Ly:=ELas[C].Y;
  Inc(ELas[C].Y,LType[ELas[C].LType].Jump+Warp);
  If Elas[C].Y>470Then Begin
   ELas[C].Y:=Ly;
   RemoveELaser(C);
  End;
  Inc(C);
 Until(ELas[C].X=-1)or(C>MaxNumOfEnemyLasers);
 C:=1;
 While ELas[C].X<>-1do Begin
  ShowPicByNum(LType[ELas[C].LType].PicN,ELas[C].X,ELas[C].Y);
  Inc(C);
 End;
End;

Procedure EnemyInteligence;Var C,OkF:Byte;Begin
 C:=1;
 If OnEnemy>0Then Begin
  Repeat
   OkF:=0;
   If(SX<E[C].X+Pics[Et[E[C].Et].PicN].XDim)and(SX>E[C].X-Pics[Et[E[C].Et].PicN].XDim)Then OkF:=1;
   If(Random(Et[E[C].Et].ChanceOfShot)=0)and(Okf=1)and(Et[E[C].Et].WNum<>0)Then FireEnemyLaser(c);
   Inc(C);
  Until C>OnEnemy;
 End;
End;

Procedure CantSave;Begin
 {$IFDEF High}
  SetVideoMode(vmTxtDef);
 {$ELSE}
  RestorecrtMode;
 {$ENDIF}
 TextColor(White);
 WriteLn('You cannot save the game while enemies are present');
 WriteLn;
 Write('Hit enter to return to combat--');
 ReadLn;
 GInit640x480x16(BgiDirec);
 {$IFDEF High}
  _SetKr(0);
 {$ELSE}
  SetFillStyle(1,0);
 {$ENDIF}
 PrepBoard;
 UpDateBoard(255);
End;

Procedure SaveGame;Var Sg:Text;Name,T,S:String;C,CC:Byte;Func:Char;Begin
 {$IFDEF High}
  SetVideoMode(vmTxtDef);
 {$ELSE}
  RestoreCrtMode;
 {$ENDIF}
 Repeat
  Write('Enter a filename (or enter to cancel) [ex. mygame]: ');
  ReadLn(Name);
  If Name<>''Then Begin
   Assign(SG,WorkDirec+'\'+Name+'.sav');
   Func:='@';
   {$I-}
   Reset(SG);
   {$I+}
   If IOResult<>0Then Func:='Y';
   If Func='@'Then Begin
    WriteLn;
    Write('This file already exist! Overwrite [Y/N]?');
    {Read(Kbd,Func);}
    Func:=ChrUp(Func);
    If Func='N'Then System.Close(SG);
   End;
  End;
 Until(Func='Y')or(Name='');
 If Name<>''Then Begin
  ReWrite(SG);
  WriteLn(SG,MP.FileN);
  WriteLn(SG,MP.LastLine);
  C:=0;
  Repeat
   WriteLn(SG,Part[MP.OnPart+C]);
   Inc(C);
  Until(Part[MP.OnPart+(C-1)]='')or(C=MaxPartsOfMap);
  WriteLn(SG,'[End Parts]');
  WriteLn(SG,OnWeapon);
  WriteLn(SG,GShipStrength-540);
  WriteLn(SG,GShipStrengthTotal-383);
  System.Str(Money,T);
  S:='';
  Repeat
   Val(T[1],C,Error);
   S:=S+Char(c+65);
   Delete(T,1,1);
  Until T='';
  WriteLn(SG,S);
  C:=1;S:='';
  Repeat
   CC:=0;
   If(LType[C].Possess)Then S:=S+Char(C+65);
   Inc(C);
  Until C>20;
  WriteLn(SG,S);
  System.Close(SG);
 End;
 GInit640x480x16(BgiDirec);
 {$IFDEF High}
  _SetKr(0);
 {$ELSE}
  SetFillStyle(1,0);
 {$ENDIF}
 PrepBoard;
 UpDateBoard(255);
End;

Procedure LoadGame;Var SG:Text;C,L,CC,DB:Byte;DirInfo:SearchRec;S,Name,T,D:String;Func:Char;Begin
 {$IFDEF High}
  SetVideoMode(vmTxtDef);
 {$ELSE}
  RestoreCrtMode;
  TextMode(CO80+Font8x8);
 {$ENDIF}
 TextColor(White);
 Write('Do you wish to load a new map or a saved ["N" new map/"S" saved game]: ');
 {Read(Kbd,Func);}
 Func:=ChrUp({func}Char(ReadKey));
 If Func='N'Then Begin
  ChDir(WorkDirec);
  FindFirst('*.JJM',faArchive,DirInfo);
  C:=1;DB:=1;
  While SysErr=0do Begin
   GotoXY(((C-1)*8)+1,5+(DB-1));
   If Pos('.JJM',DirInfo.Name)>0Then Delete(DirInfo.Name,Pos('.JJM',DirInfo.Name),4);
   Writeln(DirInfo.Name);
   Inc(DB);
   If DB>35Then Begin;DB:=1;Inc(C)End;
   FindNext(DirInfo);
  End;
  GotoXY(1,1);
  WriteLn('Enter the name of the map to setup (nothing to cancel)');
  WriteLn('[ex. mymap]: ');
  WriteLn('Any maps found are listed below--');
  GotoXY(15,2);
  ReadLn(Name);
  If Name<>''Then Begin
   Assign(Map,WorkDirec+'\'+Name+'.JJM');
   l:=1;
   {$I-}
   Reset(Map);
   {$I+}
   If IOResult<>0Then L:=2;
   If L=2Then Begin
    ClrScr;
    WriteLn;
    WriteLn('This file does not exist (remember it must be contained in :',WorkDirec,')');
    WriteLn('Hit enter to continue--');
    ReadLn;
    Assign(Map,Concat(WorkDirec,'\MAINMAP.JJM'));
    Reset(Map);
   End;
   If L=1Then Begin
    System.Close(Map);
    MP.LastLine:=0;MP.FileN:=Name+'.JJM';
    CleanMap;
    ClrScr;
    WriteLn('Map successfully loaded-');
    WriteLn('Start new game to play!');
    WriteLn;
    Write('Hit enter to continue--');
    ReadLn;
    GInit640x480x16(BgiDirec);
   End;
  End;
 End;
 If Func='S'Then Begin
  ChDir(WorkDirec);
  FindFirst('*.SAV',faArchive,DirInfo);
  C:=1;DB:=1;
  While SysErr=0do Begin
   GotoXY(((C-1)*8)+1,5+(DB-1));
   If Pos('.SAV',DirInfo.Name)>0Then Delete(DirInfo.Name,Pos('.SAV',DirInfo.Name),4);
   Writeln(DirInfo.Name);
   Inc(DB);
   If DB>35Then Begin
    DB:=1;
    Inc(C)
   End;
   FindNext(DirInfo);
  End;
  GotoXY(1,1);
  WriteLn('Enter the name of the file to restore (nothing to cancel)');
  WriteLn('[ex. mygame]: ');
  WriteLn('Any games found are listed below--');
  GotoXY(15,2);
  ReadLn(Name);
  If Name<>''Then Begin
  Assign(SG,WorkDirec+'\'+Name+'.SAV');
  L:=1;
  {$I-}
  Reset(SG);
  {$I+}
  If IOResult<>0Then L:=2;
  If L=2Then Begin
   ClrScr;
   WriteLn;
   WriteLn('This file does not exist (remember it must be contained in :',workdirec,')');
   WriteLn('Hit enter to continue--');
   ReadLn;
  End;
  If L=1Then Begin
   Reset(SG);
   ReadLn(SG,MP.FileN);
   ReadLn(SG,MP.LastLine);
   C:=1;
   Repeat
    ReadLn(SG,S);
    If S<>'[End Parts]'Then Part[C]:=S;
    Inc(C);
   Until S='[End Parts]';
   MP.OnPart:=1;
   ReadLn(SG,OnWeapon);
   ReadLn(SG,GShipStrength);
   Inc(GShipStrength,540);
   ReadLn(SG,GShipStrengthTotal);
   Inc(GShipStrengthTotal,383);
   ReadLn(SG,S);
   T:='';
   Repeat
    System.Str(Byte(s[1])-65,D);
    T:=T+D;
    ClrScr;
    Delete(S,1,1);
   Until S='';
   Val(T,Money,Error);
   If Error<>0Then Fatal('PROC[LOADGAME]- LOADING SAVED GAME!');
   ReadLn(SG,S);
   Repeat
    LType[Byte(S[1])-65].Possess:=True;
    Delete(S,1,1);
   Until S='';
   System.Close(SG);
   {$I-}
   System.Close(Map);
   {$I+}
   If IOResult<>0Then L:=1;
    Assign(Map,MP.FileN);
    Reset(Map);
    Proc:='game';
    CleanLasers;
    CleanEnemies;
   End;
  End;
 End;
 GInit640x480x16(BgiDirec);
 {$IFDEF High}
  _SetKr(0)
 {$ELSE}
  SetFillStyle(1,0)
 {$ENDIF}
End;

Procedure UpdateEnemies;Var Ly:Integer;C:Byte;P:String[2];Begin
 C:=1;
 If OnEnemy>0Then Begin
  Repeat
   {$IFDEF High}
    _PutFillBox(E[C].X,E[C].Y,E[C].X+(Pics[Et[E[C].Et].PicN].XDim-1),E[C].Y+Et[E[C].Et].Jump);
   {$ELSE}
    Bar(E[C].X,E[C].Y,E[C].X+(Pics[Et[E[C].Et].PicN].XDim-1),E[C].Y+Et[E[C].Et].Jump);
   {$ENDIF}
   Ly:=E[C].Y;
   Inc(E[C].Y,Et[E[C].Et].Jump);
   If(E[C].Y+Pics[Et[E[C].Et].PicN].YDim-1)>479Then Begin
    E[C].Y:=Ly;
    RemoveEnemy(C,True)
   End;
   Inc(C);
  Until(E[C].X=-1)or(C>MaxNumOfEnemies);
  C:=1;
  While E[C].X<>-1do Begin
   If E[C].Stage=0Then ShowPicByNum(Et[E[C].Et].PicN,E[C].X,E[C].Y);
   Inc(C)
  End;
 End;
End;

Procedure KillGShip;Var X,Y:Integer;Begin
 GInit640x480x16(BgiDirec);
 {$IFDEF High}
  _SetKr(4);
 {$ELSE}
  SetFillStyle(1,0);
  SetColor(4);
 {$ENDIF}
 X:=(640shr 1)-(Pics[1].XDim shr 1);
 Y:=490;
 Repeat
  {delay(1);}WaitRetrace;
  ShowPicByNum(1,x,y);
  If Random(10)+1=1Then Explode(X+(Pics[1].XDim shr 1),Y+(Pics[1].YDim shr 1),52);
  If Y Mod 20=0Then UpDateExp;
  Dec(Y)
 Until Y=1;
 {$IFDEF High}
  _PutFillBox(X,Y,X+Pics[1].XDim,Y+Pics[1].YDim);
  OutFTxtXY(0,300,'Vous €tes morts!',LightRed);
 {$ELSE}
  Bar(X,Y,X+Pics[1].XDim,Y+Pics[1].YDim);
  SetTextStyle(DefaultFont,0,10);
  OutTextXY(0,300,'You Died');
 {$ENDIF}
 ReadLn;
 Proc:='finish';
 Cont:=0;
 {$IFDEF High}
  ClrScrBlack;
 {$ELSE}
  SetTextStyle(DefaultFont,0,1);
  ClearDevice;
 {$ENDIF}
End;

Procedure ChangeWeapon(C:Byte);Var N:Byte;Begin
 If(LType[C].Possess)Then Begin
  If OnLaser>0Then Repeat;RemoveLaser(1)Until OnLaser=0;
  OnWeapon:=C;
  UpDateBoard(4);
 End;
End;

Procedure Station;Var Men:Array[1..13]of String[12];Hit:String[12];
MEvent:TEvent;LL,Button,ButtonP:Byte;Mon:Array[1..10]of Byte;Del:Byte;

 Procedure Prep;Var C:Byte;Begin
  C:=1;
  Repeat;Men[C]:='@';Inc(C)Until C>13;
 End;

 Procedure Menu;Var C:Byte;Begin
  HideMouse;
  C:=1;
  Repeat
   ShowPicByNum(Button,0,(c-1)*24);
   Inc(C);
  Until Men[C]='@';
  C:=1;
  Repeat
   {$IFDEF High}
    OutTxtXY(((100-(Length(Men[C])*8))shr 1)+2,((C-1)*24)+5,Men[C],3);
   {$ELSE}
    SetColor(3);
    OutTextXY(((100-(Length(Men[C])*8))shr 1)+2,((C-1)*24)+5,Men[C]);
   {$ENDIF}
   Inc(C)
  Until Men[C]='@';
  ShowMouse;
 End;

 Procedure UnHighLight(C:Byte);Begin
  If Men[C]<>'@'Then Begin
   HideMouse;
   ShowPicByNum(Button,0,(C-1)*24);
   {$IFDEF High}
    OutTxtXY(((100-(Length(Men[C])*8))shr 1)+2,((C-1)*24)+5,Men[C],3);
   {$ELSE}
    SetColor(3);
    OutTextXY(((100-(Length(Men[C])*8))shr 1)+2,((C-1)*24)+5,Men[C]);
   {$ENDIF}
   ShowMouse;
  End;
 End;

 Procedure HighLight(C:Byte);Begin
  If Men[C]<>'@'Then Begin
   HideMouse;
   If LL<>255Then UnHighLight(LL);
   LL:=C;
   ShowPicByNum(ButtonP,0,(C-1)*24);
   {$IFDEF High}
    OutTxtXY(((100-(Length(Men[C])*8))shr 1)+2,((C-1)*24)+5,Men[C],0);
   {$ELSE}
    SetColor(0);
    OutTextXY(((100-(Length(Men[C])*8))shr 1)+2,((C-1)*24)+5,Men[C]);
   {$ENDIF}
   ShowMouse;
  End;
 End;

 Procedure Stats;Var Frx:Byte;NN,NN2,NN3:String;

 Procedure WriS(LI:String;N:Byte);Begin
  {$IFDEF High}
   OutTxtXY(225,75+(N*10),LI,GraphColor);
  {$ELSE}
   OutTextXY(225,75+(N*10),LI);
  {$ENDIF}
 End;

Begin
 {$IFDEF High}
  PutFillBox(220,70,620,300,7);
  PutRect(220,70,620,300,8);
  _SetKr(3);
  _PutRect(217,67,623,303);
  _PutRect(220,320,300,340);
 {$ELSE}
  SetLineStyle(1,1,3);
  SetColor(7);
  Bar(220,70,620,300);
  Rectangle(220,70,620,300);
  SetColor(8);
  SetLineStyle(0,0,3);
  Rectangle(217,67,623,303);
  Rectangle(220,320,300,340);
 {$ENDIF}
 If OnWeapon<=16Then ShowPicByNum(LType[OnWeapon].PicN,LType[OnWeapon].Orrientation+617-(Pics[1].XDim+5),75);
 Frx:=75+Pics[LType[OnWeapon].PicN].YDim;
 ShowPicByNum(1,617-(Pics[1].XDim+5),Frx+10);
 {$IFDEF High}
  OutTxtXY(350,74,'Ship statistics',White);
  _SetKr(2);
 {$ELSE}
  SetColor(White);
  OutTextXY(350,74,'Ship statistics');
  SetColor(2);
 {$ENDIF}
 System.Str(Money,NN);
 Wris(Concat('Money: $',NN),2);
 System.Str((GShipStrength*1000),NN);
 System.Str((GShipStrengthTotal*1000),NN2);
 Wris(Concat('Shields status: ',NN,Char(234),' of ',NN2,Char(234)),3);
 Wris(Concat('Weapon type: ',LType[OnWeapon].Name),4);
 If OnWeapon<=16Then Begin
  WriS('Weapon Diagnostic-',5);
  System.Str(LType[OnWeapon].Jump,NN);
  Wris(Concat('Speed: ',NN),6);
  System.Str(LType[OnWeapon].Damage,NN);
  Wris(Concat('Damage: ',NN),7);
  System.Str(LType[OnWeapon].Range,NN);
  Wris(Concat('Range: ',NN),8);
  System.Str(LType[OnWeapon].Limit,NN);
  Wris(Concat('Cooling rate: ',NN),9);
  If OnWeapon<=9Then Begin
   System.Str(OnWeapon,NN);
   Wris(Concat('Quick Call Key: ',NN),10);
  End;
  If OnWeapon>9Then Begin
   If OnWeapon=10Then NN:='0';
   If OnWeapon=11Then NN:='Q';
   If OnWeapon=12Then NN:='W';
   If OnWeapon=13Then NN:='E';
   If OnWeapon=14Then NN:='R';
   If OnWeapon=15Then NN:='T';
   If OnWeapon=16Then NN:='Y';
   Wris(Concat('Quick Call Key: ',NN),10);
  End;
 End;
 If OnWeapon in[11..16]Then Begin
  System.Str(LType[OnWeapon].Num,NN);
  System.Str(LType[OnWeapon].LinkSpace,NN2);
  Wris(Concat('Missle Track contains: ',NN,' of ',NN2,'max'),11);
 End;
End;

Procedure Monitor;Var C:Byte;Begin
 HideMouse;
 {$IFDEF High}
  _SetKr(3);
 {$ELSE}
  FloodFill(225,325,8);
  SetColor(3);
 {$ENDIF}
 C:=1;
 Repeat
  {$IFDEF High}
   _Ln(223+((C-1)*8),337,223+((C-1)*8),323+(Mon[C]));
  {$ELSE}
   Line(223+((C-1)*8),337,223+((C-1)*8),323+(Mon[C]));
  {$ENDIF}
  Inc(C);
 Until C>10;
 C:=1;
 Repeat;Mon[C]:=Mon[C+1];Inc(C)Until C=10;
 Mon[10]:=Random(10)+1;
 ShowMouse;
End;

Procedure ChkButtons;Var Num:Byte;Begin
 Num:=0;
 Repeat;Inc(Num)Until Men[Num]='@';
 Dec(Num);
 If Not(MEvent.Where.X in[0..11])Then Begin
  If LL<>255Then UnHighLight(ll);
  LL:=255;
 End;
 If MEvent.Where.X in[0..11]Then Begin
  If MEvent.Where.Y in[0..Num*3]Then Begin
   If MEvent.What<>EvNothing Then Begin
    If MEvent.Where.Y in[0..1]Then HighLight(1);
    If MEvent.Where.Y in[3..4]Then HighLight(2);
    If MEvent.Where.Y in[6..7]Then HighLight(3);
    If MEvent.Where.Y in[9..10]Then HighLight(4);
    If MEvent.Where.Y in[12..13]Then HighLight(5);
    If MEvent.Where.Y in[15..16]Then HighLight(6);
    If MEvent.Where.Y in[18..19]Then HighLight(7);
    If MEvent.Where.Y in[21..22]Then HighLight(8);
    If MEvent.Where.Y in[24..25]Then HighLight(9);
    If MEvent.Where.Y in[27..28]Then HighLight(10);
    If MEvent.Where.Y in[30..31]Then HighLight(11);
    If MEvent.Where.Y in[33..34]Then HighLight(12);
    If MEvent.Where.Y in[36..37]Then HighLight(13);
   End;
   If(MEvent.Buttons=mbLeftButton)Then hit:=men[ll];
  End;
 End;
End;

Procedure CleanMonitor;Var C:Byte;Begin
 C:=1;
 Repeat;Mon[C]:=Random(10)+1;Inc(C)Until C>10;
End;

Procedure Repair;Begin
 {$IFDEF High}
  ClrScrBlack;
 {$ELSE}
  ClearDevice;
 {$ENDIF}
 Prep;
 Men[1]:='Repair $100';
 Men[2]:='Repair $300';
 Men[3]:='Repair $500';
 Men[4]:='Main menu';
 Menu;
 Stats;
 ShowMouse;
 Repeat
  {delay(1);}WaitRetrace;
  Inc(del);
  GetMouseEvent(MEvent);
  ChkButtons;
  If Del=255Then Monitor;
  If Hit='Repair $100'Then Begin
   If(GShipStrength+1<=GShipStrengthTotal)and(Money>=100)Then Begin
    Dec(Money,100);
    Inc(GShipStrength);
    Stats;
    Hit:='';
   End;
  End;
  If Hit='Repair $300'Then Begin
   If(GShipStrength+3<=GShipStrengthTotal)and(Money>=300)Then Begin
    Dec(Money,300);
    Inc(gshipstrength,3);
    Stats;
    Hit:='';
   End;
  End;
  If Hit='Repair $500'Then Begin
   If(GShipStrength+5<=GShipStrengthTotal)and(money>=500)Then Begin
    Dec(Money,500);
    Inc(GShipStrength,5);
    Stats;
    Hit:='';
   End;
  End;
 Until Hit='Main menu'
End;

Procedure BuyWeap;Var C,NumW:Byte;

 Procedure Buy(N:Byte);Var Bef:Byte;Begin
  HideMouse;
  {$IFDEF High}
   ClrScrBlack;
  {$ELSE}
   ClearDevice;
  {$ENDIF}
  Bef:=OnWeapon;
  OnWeapon:=N;
  Dec(Money,LType[N].Price);
  Stats;
  Prep;
  Men[1]:='Buy';
  Men[2]:='Back';
  Menu;
  Hit:='';
  ShowMouse;
  Repeat
   {delay(1);}WaitRetrace;
   Inc(Del);
   GetMouseEvent(MEvent);
   ChkButtons;
   If Del=255Then monitor;
  Until Hit<>'';
  If Hit='Buy'Then Begin
   LType[OnWeapon].Possess:=True;
   If OnWeapon in[11..16]Then Begin
    Inc(LType[OnWeapon].Num,LType[OnWeapon].Link);
    If(LType[OnWeapon].Num>LType[OnWeapon].LinkSpace)Then LType[OnWeapon].Num:=LType[OnWeapon].LinkSpace;
   End;
   Hit:='Main menu';
  End;
  If Hit='Back'Then Begin
   Inc(Money,LType[OnWeapon].Price);
   OnWeapon:=Bef;
  End;
 End;

 Procedure Section1;

  Procedure Again;Var Sp:String;Begin
   HideMouse;
   {$IFDEF High}
    ClrScrBlack;
   {$ELSE}
    ClearDevice;
   {$ENDIF}
   System.Str(Money,SP);
   {$IFDEF High}
    OutTxtXY(500,0,'Money: $'+SP,White);
   {$ELSE}
    SetColor(White);
    OutTextXY(500,0,'Money: $'+SP);
   {$ENDIF}
   Prep;
   C:=1;
   {$IFDEF High}
    _SetKr(3);
   {$ELSE}
    SetColor(3);
   {$ENDIF}
   Repeat
    System.Str(C,Men[C]);
    Men[C]:=Concat(Men[C],'.');
    System.Str(LType[C].Price,SP);
    {$IFDEF High}_SetKr(3);{$ELSE}SetColor(3);{$ENDIF}
    If(Money<LType[C].Price)or(LType[C].Possess=True)Then {$IFDEF High}_SetKr(4);{$ELSE}SetColor(4);{$ENDIF}
    If LType[C].Des<>''Then
    {$IFDEF High}
     OutTxtXY(115,((c-1)*24),LType[C].Name+' '+LType[C].Des+' $'+SP,GraphColor);
    {$ELSE}
     OutTextXY(115,(c-1)*24,LType[C].Name+' '+LType[C].Des+' $'+SP);
    {$ENDIF}
    If LType[C].Des=''Then
    {$IFDEF High}
     OutTxtXY(115,(c-1)*24,LType[C].Name+' $'+SP,GraphColor);
    {$ELSE}
     OutTextXY(115,(c-1)*24,LType[C].Name+' $'+SP);
    {$ENDIF}
    Inc(C);
   Until C>10;
   Men[11]:='Section ][';
   Men[12]:='Main menu';
   Menu;
   {stats;}
   ShowMouse;
   Hit:='';
  End;

 Begin
  Again;
  Repeat
   {delay(1);}WaitRetrace;
   Inc(Del);
   GetMouseEvent(MEvent);
   ChkButtons;
   {If Del=255Then Monitor;}
   If Hit<>''Then Begin
    C:=1;
    If Pos('.',Hit)<>0Then Delete(Hit,Pos('.',Hit),1);
    Val(Hit,C,Error);
    If(Error=0)and(Money>=LType[C].Price)and(LType[C].Possess=False)Then Buy(C);
    If Hit='Back'Then Again;
   End;
  Until(Hit='Main menu')or(Hit='Section ][')
 End;

 Procedure section2;

  Procedure Again;Var SP:String;Begin
   HideMouse;
   {$IFDEF High}
    ClrScrBlack;
   {$ELSE}
    ClearDevice;
   {$ENDIF}
   Prep;
   System.Str(Money,SP);
   {$IFDEF High}
    OutTxtXY(500,0,'Money: $'+SP,GraphColor);
   {$ELSE}
    SetColor(White);
    OutTextXY(500,0,'Money: $'+SP);
   {$ENDIF}
   C:=1;
   {$IFDEF High}_SetKr(3);{$ELSE}SetColor(3);{$ENDIF}
   Repeat
    System.Str(C,Men[C]);
    System.Str(LType[C+10].Price,SP);
    Men[C]:=Concat(Men[C],'.');
    {$IFDEF High}_SetKr(3);{$ELSE}SetColor(3);{$ENDIF}
    If Not(C+10in[11..16])Then If(Money<LType[C+10].Price)or(LType[C+10].Possess)Then
    {$IFDEF High}_SetKr(4);{$ELSE}SetColor(4);{$ENDIF}
    If C+10in[11..16]Then If(LType[C+10].Link>LType[C+10].LinkSpace)or(Money<LType[c+10].Price)Then
    {$IFDEF High}_SetKr(4);{$ELSE}SetColor(4);{$ENDIF}
    If LType[C+10].Des<>''Then
    {$IFDEF High}
     OutTxtXY(115,(C-1)*24,LType[C+10].Name+' '+LType[C+10].Des+' $'+SP,GraphColor);
    {$ELSE}
     OutTextXY(115,(C-1)*24,LType[C+10].Name+' '+LType[C+10].Des+' $'+SP);
    {$ENDIF}
    If LType[C+10].Des=''Then
    {$IFDEF High}
     OutTxtXY(115,(C-1)*24,LType[C+10].Name+' $'+SP,GraphColor);
    {$ELSE}
     OutTextXY(115,(C-1)*24,LType[C+10].Name+' $'+SP);
    {$ENDIF}
    Inc(C);
   Until C>10;
   Men[11]:='Section I';
   Men[12]:='Main menu';
   Menu;
   {stats;}
   ShowMouse;
   Hit:='';
  End;

 Begin
  Again;
  Repeat
   {delay(1);}WaitRetrace;
   Inc(Del);
   GetMouseEvent(MEvent);
   ChkButtons;
   {If Del=255Then Monitor;}
   If Hit<>''Then Begin
    C:=1;
    If Pos('.',Hit)<>0Then Delete(Hit,Pos('.',Hit),1);
    Val(Hit,C,Error);
    If Not(C+10in[11..16])Then If(Error=0)and(Money>=LType[C+10].Price)and(LType[C+10].Possess=False)Then Buy(C+10);
    If C+10in[11..16]Then If(LType[C+10].Link<LType[C+10].LinkSpace)and(Error=0)and(Money>=LType[C+10].Price)Then Buy(C+10);
    If Hit='Back'Then Again;
   End;
  Until(Hit='Main menu')or(Hit='Section I')
 End;

Begin
 NumW:=0;
 Repeat Inc(NumW)Until LType[NumW].Name='';
 Dec(NumW);
 {$IFDEF High}
  ClrScrBlack;
 {$ELSE}
  ClearDevice;
 {$ENDIF}
 Hit:='Section I';
 ShowMouse;
 Repeat
  If Hit='Section ]['Then Section2;
  If Hit='Section I'Then Section1;
 Until Hit='Main menu';
End;

Procedure UpGradeShields;Var Price:Longint;S:String;Begin
 HideMouse;
 {$IFDEF High}
  ClrScrBlack;
 {$ELSE}
  ClearDevice;
 {$ENDIF}
 Stats;
 Prep;
 Price:=(((GShipStrengthTotal-40)div 10)*5000)+5000;;
 System.Str(Price,S);
 Men[1]:='1000'+Char(234)+'-$'+S;
 Men[2]:='Done';
 Menu;
 ShowMouse;
 Repeat
  {delay(1);}WaitRetrace;
  Inc(Del);
  GetMouseEvent(MEvent);
  ChkButtons;
  If Del=255Then Monitor;
  If Hit='1000'+Char(234)+'-$'+S Then Begin
   If(Money>=Price)Then Begin
    Dec(Money,Price);
    Inc(GShipStrengthTotal);
    GShipStrength:=GShipStrengthTotal;
    Stats;
    Hit:='';
   End;
  End;
 Until Hit='Done'
End;

Procedure Main;Begin
 HideMouse;
 {$IFDEF High}
  ClrScrBlack;
 {$ELSE}
  ClearDevice;
 {$ENDIF}
 Prep;
 Men[1]:='Items';
 Men[2]:='Repair';
 Men[3]:='Shields';
 Men[4]:='View Weapons';
 Men[5]:='Leave';
 Menu;
 Stats;
 Hit:='';
 ShowMouse;
End;

Procedure Dock;Var X:Integer;NN:Byte;Begin
 ChangeWeapon(OnWeapon);
 X:=0;
 NN:=FindPic('dock');
 If(SX-3>Pics[NN].XDim)Then Begin
  Repeat
   {delay(4);} WaitRetrace;
   ShowPicByNum(NN,X,SY);
   Inc(X);
   If X Mod(6*slowdown)=0Then Begin
    If Not(NoStar)Then UpDateStars;
    ShowPicByNum(1,SX,SY);
   End;
  Until X+(Pics[NN].XDim)>=SX-3;
 End;
 Delay(2000)
End;

Begin
 Dock;
 GInit640x480x16(BgiDirec);
 {$IFDEF High}
  ClrScrBlack;
  _SetKr(0);
 {$ELSE}
  SetFillStyle(1,0);
  ClearDevice;
 {$ENDIF}
 LL:=255;
 Button:=FindPic('BUTTON');
 ButtonP:=FindPic('BUTTONP');
 CleanMonitor;
 Main;
 Del:=0;
 Hit:='';
 ShowMouse;
 Repeat
  delay(1);{WaitRetrace;}
  Inc(Del);
  GetMouseEvent(MEvent);
  ChkButtons;
  If Del=255Then Monitor;
  If Hit='Repair'Then Begin
   Repair;
   Main;
  End;
  If Hit='Items'Then Begin
   BuyWeap;
   Main;
  End;
  If Hit='View Weapons'Then Begin
  Repeat
   Inc(OnWeapon);
   If OnWeapon>20Then OnWeapon:=1;
  Until LType[OnWeapon].Possess;
  Main;
  End;
  If Hit='Shields'Then Begin
   UpGradeShields;
   Main;
  End;
 Until Hit='Leave';
 If OnWeapon>16Then OnWeapon:=1;
 HideMouse;
 {$IFDEF High}
  ClrScrBlack;
 {$ELSE}
  ClearDevice;
 {$ENDIF}
 PrepBoard;
 UpDateBoard(255);
 ChangeWeapon(OnWeapon)
End;

Procedure Move;Var Chk:Byte;Begin
 GetKeyEvent(KEvent);
 GetMouseEvent(MoEvent);
 If(KEvent.What=EvKeyDown)Then Begin
  Case(KEvent.KeyCode)of
   kbRight:direct:=1;
   kbLeft:direct:=2;
   kbUp,kbDown:direct:=0;
  End;
  Case ChrUp(KEvent.CharCode)of
   'M':Proc:='menu';
   ' ':If LType[20].LinkSpace=0Then FireLaser;
   'S':Begin
    If OnEnemy=0Then SaveGame;
    If OnEnemy<>0Then CantSave;
   End;
   '`':Begin
    Chk:=0;
    If(LType[20].Possess)and(LType[20].LinkSpace=0)Then Begin
    Chk:=1;
    LType[20].LinkSpace:=1;
    Warp:=10;
    End;
    If(LType[20].Possess)and(LType[20].LinkSpace=1)and(Chk=0)Then Begin
     Warp:=0;
     LType[20].LinkSpace:=0;
    End;
   End;
   '1':ChangeWeapon(1);
   '2':ChangeWeapon(2);
   '3':ChangeWeapon(3);
   '4':ChangeWeapon(4);
   '5':ChangeWeapon(5);
   '6':ChangeWeapon(6);
   '7':ChangeWeapon(7);
   '8':ChangeWeapon(8);
   '9':ChangeWeapon(9);
   '0':ChangeWeapon(10);
   'Q':ChangeWeapon(11);
   'W':ChangeWeapon(12);
   'E':ChangeWeapon(13);
   'R':ChangeWeapon(14);
   'T':ChangeWeapon(15);
   'Y':ChangeWeapon(16);
  End;
 End;
 If(MoEvent.What<>evNothing)Then Begin
  If(MoEvent.Buttons=mbLeftButton)and(LType[20].LinkSpace=0)Then FireLaser;
  If(moEvent.Where.X>Lmx)Then Direct:=1;
  If(moEvent.Where.X<Lmx)Then Direct:=2;
  If(moEvent.Buttons=mbRightButton)Then Direct:=0;
  Lmx:=MoEvent.Where.X;
 End;
 If Direct=1Then Inc(SX,2);
 If Direct=2Then Dec(SX,2);
 If(SX+Pics[1].XDim)>638Then SX:=638-Pics[1].XDim;
 If SX<2Then SX:=2;
 ShowPicByNum(1,SX,SY);
 If Direct<>0Then ChangeMovXYByNum(BurnNum,SX+FlameX,FY,False)
End;

Procedure ReadMap;Var S:String;N:LongInt;O:Byte;X,Y:Integer;

 Procedure FatalCall(Nt:Char);Begin
  Fatal(Concat('PROC[READMAP]- CORRUPTED MAP: ',MP.FileN))
 End;

Begin
 MP.Del:=0;GlobalDel:=1;O:=MP.OnPart;
 If Part[O][1]='E'Then Begin
  Delete(Part[O],1,2);
  S:=Copy(Part[O],1,Pos('.',Part[O])-1);
  Delete(Part[O],1,Pos('.',Part[O]));
  Val(S,N,Error);
  If Error<>0Then FatalCall('D');
  MakeEnemy(n)
 End;
 If Part[O][1]='F'Then Begin
  Delete(Part[O],1,2);
  S:=Copy(Part[O],1,Pos('.',Part[O])-1);
  Delete(Part[O],1,Pos('.',Part[O]));
  Val(S,N,Error);
  If Error<>0Then FatalCall('D');
  X:=N;S:=Copy(Part[O],1,Pos('.',Part[O])-1);
  Delete(Part[O],1,Pos('.',Part[O]));
  Val(S,N,Error);
  If Error<>0Then FatalCall('D');
  MakeEnemyFixed(N,X);
 End;
 If Part[O][1]='D'Then Begin
  Delete(Part[O],1,2);
  S:=Copy(Part[O],1,Pos('.',Part[O])-1);
  Delete(Part[O],1,Pos('.',Part[O]));
  Val(S,N,Error);
  If Error<>0Then FatalCall('D');
  MP.Del:=N;
 End;
 If((Part[O][1]='S')and(OnEnemy>0))or((Length(Part[O])<15)and(Part[O][Length(Part[O])]='S'))Then Begin
  If(LType[18].Possess)Then Mess('S',Blue,True);
 End;
 If(Part[O][1]='S')and(OnEnemy=0)and(OnExp=0)and(EOnLaser=0)Then Begin
  Station;
  LoadNext;
 End;
 If Part[O]=''Then Begin
  Inc(mp.onpart);
  If(MP.OnPart>MaxPartSofmap)Then Fatal('PROC[READMAP]-CORRUPTED PATTERN')
 End;
End;

Procedure Multitasker;Const Wait:Byte=0;Var C:Byte;Begin
 If LType[20].LinkSpace=0Then Begin
  Wait:=(Wait+1);
  If Wait>3Then Wait:=0;
  If Wait=0Then {Delay(1);}WaitRetrace;
 End;
 {Inc global timer}
 Inc(GlobalDel);
 {End. inc global timer}
 {inc enemy weapon delay}
 Inc(EWeap);
 {End.inc enemy weapon delay}
 {inc star delay}
 Inc(SCDel);
 {End. inc star delay}
 {inc mover delays}
 C:=1;
 While Mov[C].Name<>''do Begin;Inc(Mov[C].CDel);Inc(C)End;
 {End. inc mover delays}
 {inc weapon delay}
 Inc(LType[OnWeapon].CDel);
 {End. inc weapon delay}
 {check mover timers}
 C:=1;
 While Mov[C].Name<>''do Begin
  If(Mov[C].CDel>=Mov[C].Del*SlowDown)Then ShowAnimationFrame(C);
  Inc(C)
 End;
 {End. check mover timers}
 {check weapon timer}
 If(LType[OnWeapon].CDel>=LType[OnWeapon].Del*SlowDown)Then Begin
  UpDateLasers;
  {check lasers}
  If(OnLaser>0)and(OnEnemy>0)Then ChkLaserPosition;
  {End. check lasers}
 End;
 {End. check weapon timer}
 {check enemy weapon timer}
 If(EWeap>3*SlowDown)Then Begin
  EWeap:=0;
  If EOnLaser>0Then UpDateEnemyLasers;
  {check enemy lasers}
  If EOnLaser>0Then ChkEnemyLaserPosition;
  {End. check enemy lasers}
  Move;
 End;
 {End. check enemy weapon timer}
 {check default timer}
 {If SCDel Mod 15=0Then Begin
  UpDateExp;
 End;}
 If(SCDel>=20*SlowDown)Then Begin
  UpDateExp;
  If Not(NoStar)Then UpDateStars;
  If(NoStar)Then SCDel:=0;
  UpDateEnemies;
  If LType[20].LinkSpace=0Then EnemyInteligence;
  If(Cleard)Then Mess('D',Red,False);
  If OnEnemy>0Then ChkEnemyPosition;
 End;
 {End. check star timer}
 If Proc='kill'Then killgship;
 {check for next action}
 If(GlobalDel>MP.Del*SlowDown)Then ReadMap;
 {End. check for next action}
End;

Function Menu:String;Var Name:String;Men:Array[1..10]of String;
Nom,On,Lon,OpenNum:Byte;Func:Char;K:Word;

 Procedure CleanMen;Var N:Byte;Begin
  N:=1;Nom:=0;On:=1;
  Repeat;Men[n]:='';Inc(N)Until N>10;
 End;

 Procedure ShowMen;Var N:Byte;Begin
  {$IFDEF High}
   ClrScrBlack;
  {$ELSE}
   ClearDevice;
   SetTextStyle(0,0,8);
   ClearDevice;
  {$ENDIF}
  Name:='IronClad';
  {$IFDEF High}
   SizeMulFont:=3;
   OutFTxtXY(((640-(Length(Name)*8*8))shr 1)-6,26,Name,4);
   OutFTxtXY(((640-(Length(Name)*8*8))shr 1)-5,25,Name,7);
   OutFTxtXY((640-(Length(Name)*8*8))shr 1,20,Name,8);
   SizeMulFont:=2;
  {$ELSE}
   SetColor(4);
   OutTextXY(((640-(Length(Name)*8*8))shr 1)-6,26,Name);
   SetColor(7);
   OutTextXY(((640-(Length(Name)*8*8))shr 1)-5,25,Name);
   SetColor(8);
   OutTextXY((640-(Length(Name)*8*8))shr 1,20,Name);
  {$ENDIF}
  N:=1;
  {$IFNDEF High}
   SetColor(Red);
   SetTextStyle(0,0,4);
  {$ENDIF}
  Repeat
   {$IFDEF High}
    OutFTxtXY((640-(Length(Men[N])*8*4))shr 1,100+(N-1)*60,Men[N],Red);
   {$ELSE}
    OutTextXY((640-(Length(Men[N])*8*4))shr 1,100+(N-1)*60,Men[N]);
   {$ENDIF}
   Inc(Nom);
   Inc(N)
  Until men[n]='';
 End;

Begin
 CleanMen;
 If Cont=0Then Begin
  Men[1]:='New Game';
  Men[2]:='Load Game/Map';
  Men[3]:='Options';
  Men[4]:='Help';
  Men[5]:='Quit';
 End;
 If Cont=1Then Begin
  Men[1]:='New Game';
  Men[2]:='Continue';
  Men[3]:='Load Game/Map';
  Men[4]:='Options';
  Men[5]:='Help';
  Men[6]:='Quit';
 End;
 ShowMen;
 Func:='@';
 NewAnimation('opener','opener',150,True,((640-(Length(Men[On])*8*4))shr 1)-60,100);
 OpenNum:=FindMover('opener');
 Repeat
  delay(1);{WaitRetrace;}
  Lon:=On;
  If(KeyPress)Then Begin
   K:=Systems.ReadKey;
   If Lo(K)=0Then Func:=Chr(Hi(K))Else Func:=Chr(Lo(K));
  End
   Else
  Func:=#0;
  {If KeyPressed Then Read(kbd,func);
  If Keypressed Then Read(kbd,func);}
  If Func='P'Then Inc(On);
  If Func='H'Then Dec(On);
  If(On>Nom)Then On:=1;
  If On<1Then On:=Nom;
  If(Lon<>On)Then Begin
   ChangeMovXYByNum(OpenNum,((640-(Length(Men[On])*8*4))shr 1)-60,100+(On-1)*60,True);
  End;
  Inc(Mov[OpenNum].CDel);
  If Mov[OpenNum].CDel>=Mov[OpenNum].Del Then ShowAnimationFrame(OpenNum);
  If Func<>#13Then Func:='@';
 Until Func=#13;
 Menu:=Men[On];
 {$IFDEF High}
  _SetKr(1);
 {$ELSE}
  SetTextStyle(0,0,1);
 {$ENDIF}
 DeleteMovByNum(OpenNum);
 {$IFDEF High}
  ClrScrBlack;
 {$ELSE}
  ClearDevice;
 {$ENDIF}
End;

Procedure Help;Begin
 {$IFDEF High}
  SetVideoMode(vmTxtDef);
 {$ELSE}
  RestoreCrtMode;
  TextMode(CO80+Font8x8);
 {$ENDIF}
 TextColor(White);
 WriteLn('Help file:');
 WriteLn;
 TextColor(Blue);
 Writeln('Operating Systems:');
 TextColor(white);
 WriteLn('Not compatible with Windows 95 or Windows NT 4.0');
 WriteLn('Not tested with Windows 3.x');
 WriteLn('Works in all higher versions of PC-MS DOS');
 WriteLn;
 TextColor(Blue);
 WriteLn('Keys:');
 TextColor(White);
 WriteLn('Use the space bar (or left mouse button) to fire your selected weapon');
 WriteLn('Use the right/left arrow keys to move respectively right/left');
 WriteLn('You can also use the mouse to move the ship');
 WriteLn('Use the up/down arrow keys to stop right/left motion');
 WriteLn('You can also use the right mouse button to stop motion');
 WriteLn('Use "S" to save the game (NOTE: no enemies can be present on screen)');
 WriteLn('Hit "M" to return to main menu, select "Continue" to resume play');
 WriteLn('Hit 1..0 to change weapons (NOTE you must have purchased the weapon already');
 WriteLn('Hit Q..Y to change to upper level weapons');
 WriteLn;
 TextColor(blue);
 WriteLn('Docking stations:');
 TextColor(White);
 WriteLn('To do anything inside a docking station you MUST have a mouse driver installed');
 WriteLn;
 WriteLn('Good Luck!');
 WriteLn;
 Write('Hit enter to continue--');
 ReadLn;
 TextMode(BW40);
 GInit640x480x16(BgiDirec);
 {$IFDEF High}
  _SetKr(0);
 {$ELSE}
  SetFillStyle(1,0);
 {$ENDIF}
End;

Procedure Options;Var Func:Char;Begin
 TextMode(CO80+Font8x8);
 ClrScr;
 WriteLn('1. Change star configuration');
 WriteLn('2. Change game speed');
 WriteLn;
 Write('Enter your choice: ');
 {Read(Kbd,Func);}
 Func:=Char(ReadKey);
 If Func='1'Then Begin
  ClrScr;
  Write('Do you want the stars on or off [N=On/F=Off]: ');
  {Read(Kbd,Func);}Func:=Char(ReadKey);
  If ChrUp(Func)='F'Then NoStar:=True;
  If ChrUp(Func)='N'Then NoStar:=False;
  If ChrUp(Func)='F'Then ChangeIni('[Stars]','OFF');
  If ChrUp(Func)='N'Then ChangeIni('[Stars]','ON');
  Func:='@';
 End;
 If Func='2'Then Begin
  Repeat
   ClrScr;
   WriteLn('Enter the factor to slow down by [1..9] ');
   Write('(ex. 1=normal speed 2=twice as slow etc.): ');
   {Read(Kbd,Func);}Func:=Char(ReadKey);
  Until Func In ['1'..'9'];
  ChangeIni('[Slow down]',Func);
  Val(Func,SlowDown,Error);
 End;
 GInit640x480x16(BgiDirec);
 {$IFDEF High}
  _SetKr(0);
 {$ELSE}
  SetFillStyle(1,0);
 {$ENDIF}
End;

BEGIN
 InitSystems(suIsabel);
 Clean;
 b10:=findpic('blow10');
 b20:=findpic('blow20');
 b30:=findpic('blow30');
 b40:=findpic('blow40');
 b50:=findpic('blow50');
 Repeat
  If Proc<>'quit'Then Begin
   PP:=Menu;
   If PP='Load Game/Map'Then LoadGame;
   If PP='Help'Then Help;
   If PP='Quit'Then Proc:='quit';
   If PP='Options'Then Options;
  End;
  If(PP='New Game')or(Proc='game')or(PP='Continue')Then Begin
   If Proc<>'quit'Then Begin;
    If(PP='New Game')and(Cont=1)Then Begin
     CleanLasers;
     CleanEnemies;
     CleanMap;
     CleanExplosions;
     LoadGameWeapons;
     GShipStrengthTotal:=InitialShields;
     GShipStrength:=InitialShields;
     Money:=InitialMoney;
    End;
    NewAnimation('burn','burner',100,True,SX+FlameX,FY);
    BurnNum:=FindMover('burn');
    PrepBoard;
    UpdateBoard(255);
    Proc:='';
    Repeat;MultiTasker;Until(Proc='menu')or(Proc='finish');
    DeleteMovByNum(BurnNum);
    If Proc='menu'Then Cont:=1;
    If Proc='finish'Then Begin
     CleanLasers;
     CleanEnemies;
     CleanMap;
     CleanExplosions;
     LoadGameWeapons;
     GShipStrengthTotal:=InitialShields;
     GShipStrength:=InitialShields;
     Money:=InitialMoney;
    End;
    Proc:='';
   End;
  End;
 Until Proc='quit';
 {$I-}
 Close(Map);
 {$I+}
 If IOResult<>0Then PP:='';
 TextMode(CO80);
 ClrScr;
 NoSound;
END.