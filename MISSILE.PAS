Unit Missile;

{$I Def.Inc}
INTERFACE

Uses Isatex;

Function  MissileCommandInit(Var Context;X1,Y1,X2,Y2:Byte):Boolean;
Procedure MissileCommandStart(Var Q:MissileCommandGame);
Procedure MissileCommandRefresh(Var Context);
Procedure MissileCommandInputMode(Var Context;Mode:GameInputMode);
Function  MissileCommandPlay(Var Context):Word;
Function  MissileCommandTitle(Var QX;Max:Byte):String;
Procedure MissileCommandSetLevel(Var Q:MissileCommandGame);
Procedure MissileCommandSetScrn(Var Q:MissileCommandGame;Full:Boolean);
Procedure MissileCommandMove2(Var QX;X,Y:Byte);
Function  MissileCommandDone(Var Q):Word;

IMPLEMENTATION

Uses
 Adele,Video,Systex,Systems,Mouse,Math,Dials,Dialex;

Function Canon(I:Byte):Byte;Near;
Var
 S:String;
Begin
 S:=Chr(20*8-3)+Chr(20*8-5)+Chr(20*8-6)+Chr(20*8-7)+Chr(20*8-7)+Chr(20*8-8)+
    Chr(20*8-8)+Chr(20*8-8)+Chr(20*8-8)+Chr(20*8-8)+Chr(20*8-8)+Chr(20*8-7)+
    Chr(20*8-7)+Chr(20*8-6)+Chr(20*8-5)+Chr(20*8-3);
 Canon:=Byte(S[I+1]);
End;

Function XCity(I:Byte):Word;
Var
 S:String;
Begin
 S:=#5#10#15#23#28#33;
 XCity:=Byte(S[I+1])shl 3;
End;

Function PutMissile(Var Q:MissileCommandGame;X1,Y1,X2,Y2,Limit,Kr:Int;Var XOut,YOut:SmallInt):Byte;
Var
 D,DX,DY,I,J,Ainc,Binc,Ic:SmallInt;
 OK:Word;
Begin
 PutMissile:=0;
 If AbsInt(X2-X1)<AbsInt(Y2-Y1)Then Begin
  If(Y1>Y2)Then ASM MOV AX,X1;XCHG AX,X2;MOV X1,AX;MOV AX,Y1;XCHG AX,Y2;MOV Y1,AX;END;
  If(X2>X1)Then Ic:=1 Else Ic:=-1;
  DY:=Y2-Y1;DX:=AbsInt(X2-X1);D:=(DX shl 1)-DY;Ainc:=(DX-DY)shl 1;Binc:=DX shl 1;J:=X1;
  SetPixel(Q.G.X1+X1,Q.G.Y1+Y1,Kr);
  I:=Y1+1;
  While(I<=Y2)do Begin
   If D>=0Then Begin
    Inc(J,Ic);Inc(D,Ainc)
   End
    else
   Inc(D,Binc);
   OK:=GetPixel(Q.G.X1+J,Q.G.Y1+I);
   If(OK>0)and(OK<65535)Then Begin
    If(OK=Q.Color1)Then Begin;XOut:=J;PutMissile:=1;Exit;End;
    If(OK=Q.Color2)Then Begin;XOut:=J;PutMissile:=2;Exit;End;
    If(OK=Q.Color3)Then Begin;XOut:=J;PutMissile:=3;Exit;End;
   End;
   SetPixel(Q.G.X1+J,Q.G.Y1+I,Kr);
   If(I>Limit)Then Begin
    XOut:=J;YOut:=I;
    Exit;
   End;
   Inc(I);
  End;
 End
  else
 Begin
{  If(X1>X2)Then ASM MOV AX,X1;XCHG AX,X2;MOV X1,AX;MOV AX,Y1;XCHG AX,Y2;MOV Y1,AX;END;}
  If(Y2>Y1)Then Ic:=1 else Ic:=-1;
  DX:=AbsInt(X2-X1);DY:=AbsInt(Y2-Y1);D:=(DY shl 1)-DX;AInc:=(DY-DX)shl 1;BInc:=DY shl 1;J:=Y1;
  SetPixel(Q.G.X1+X1,Q.G.Y1+Y1,Kr);
  If(X1>X2)Then Begin
   I:=X1;
   While(I>=X2)do Begin
    If D>=0Then Begin
     Inc(J);Inc(D,Ainc)
    End
     Else
    Inc(D,Binc);
    OK:=GetPixel(Q.G.X1+I,Q.G.Y1+J);
    If(OK>0)and(OK<65535)Then Begin
     If(OK=Q.Color1)Then Begin;XOut:=J;PutMissile:=1;Exit;End;
     If(OK=Q.Color2)Then Begin;XOut:=J;PutMissile:=2;Exit;End;
     If(OK=Q.Color3)Then Begin;XOut:=J;PutMissile:=3;Exit;End;
    End;
    SetPixel(Q.G.X1+I,Q.G.Y1+J,Kr);
    If(J>Limit)Then Begin
     XOut:=I;YOut:=J;
     Exit;
    End;
    Dec(I);
   End;
  End
   Else
  Begin
   I:=X1+1;
   While(I<=X2)do Begin
    If D>=0Then Begin
     J:=J+Ic;
     Inc(D,Ainc)
    End
     Else
    Inc(D,Binc);
    OK:=GetPixel(Q.G.X1+I,Q.G.Y1+J);
    If(OK>0)and(OK<65535)Then Begin
     If(OK=Q.Color1)Then Begin;XOut:=J;PutMissile:=1;Exit;End;
     If(OK=Q.Color2)Then Begin;XOut:=J;PutMissile:=2;Exit;End;
     If(OK=Q.Color3)Then Begin;XOut:=J;PutMissile:=3;Exit;End;
    End;
    SetPixel(Q.G.X1+I,Q.G.Y1+J,Kr);
    If(J>Limit)Then Begin
     XOut:=I;YOut:=J;
     Exit;
    End;
    Inc(I);
   End;
  End;
 End;
End;

Function EY(I:Byte):Byte;Near;
Var
 S:String;
Begin
 S:=#0#0#0#0#6#6#2#2#4#4#4#1#5#0#0#0#4#4#2#2#4#0#1;
 EY:=Byte(S[I+1]);
End;

Procedure MissileCommandPutCity(Var Q:MissileCommandGame;X:Word;Color:Byte);
Var
 I:Byte;
Begin
 For I:=0to 22do WEPutLine(Q.MainWin,X+I,20*8+EY(I),X+I,22*8-1,Color)
End;

Procedure EraseCity(Var Q:MissileCommandGame;X:Word);
Var
 I:Byte;
Begin
 For I:=0to 5do If(X>=XCity(I))and(X<=XCity(I)+22)Then Break;
 MissileCommandPutCity(Q,XCity(I),0);
 For I:=0to 2do Begin
  SetPalRGB(DefaultRGB[15],0,1);
  WaitRetrace;
  SetPalRGB(DefaultRGB[0],0,1);
  WaitRetrace;
 End;
End;

Procedure MakeNewMissile(Var Q:MissileCommandGame;I:Byte);Begin
 Q.MI[I]:=0;
 Q.ML[I]:=1+Random(Q.Level);
 Q.MX1[I]:=Random(318);
 Q.MX2[I]:=Random(38*8-34)+16;
End;

Procedure UpDateScore(Var Q:MissileCommandGame);Begin
 WESetKr(Q.MainWin,$B0);
 WEPutTxtXY(Q.MainWin,11,Q.MainWin.MaxY,CStr(Q.Score));
End;

Procedure InitLevel(Var Q:MissileCommandGame);
Var
 I:SmallInt;
Begin
 If Q.Level>5Then I:=5
             Else I:=Q.Level;
 Q.MaxMissile:=Q.LevelMaxMissile[I];
 Q.Missile2Send:=Q.LevelMissile[I];
 Q.KM:=0;
 WESetKr(Q.MainWin,$B0);
 WEPutTxtXY(Q.MainWin,25,Q.MainWin.MaxY,'Niveau: '+WordToStr(Q.Level+1));
 UpDateScore(Q);
 For I:=0to(Q.MaxMissile)do MakeNewMissile(Q,I);
End;

Function MissileCommandInit(Var Context;X1,Y1,X2,Y2:Byte):Boolean;
Var
 Q:MissileCommandGame Absolute Context;
 S:String;
Begin
 FillClr(Q,SizeOf(Q));
 Randomize;
 Case(HeightChr)of
  14:Dec(Y2,7);
  16:Dec(Y2,10);
 End;
 WEInit(Q.MainWin,X1,Y1,X2,Y2);
 MissileCommandRefresh(Q);
 Q.PtrMs:=#$FF#$00#$00#$FF+
          #$FF#$FF#$FF#$FF+
          #$FF#$FF#$FF#$FF+
          #$FF#$FF#$FF#$FF+
          #$FF#$FF#$FF#$FF+
          #$FF#$FF#$FF#$FF+
          #$7F#$FF#$FF#$FE+
          #$7F#$FF#$FF#$FE+
          #$7F#$FF#$FF#$FE+
          #$7F#$FF#$FF#$FE+
          #$FF#$FF#$FF#$FF+
          #$FF#$FF#$FF#$FF+
          #$FF#$FF#$FF#$FF+
          #$FF#$FF#$FF#$FF+
          #$FF#$FF#$FF#$FF+
          #$FF#$00#$00#$FF+
          #$00#$7C#$3E#$00+
          #$03#$80#$01#$C0+
          #$0C#$00#$00#$30+
          #$30#$00#$00#$0C+
          #$40#$00#$00#$02+
          #$80#$01#$80#$01+
          #$80#$01#$80#$01+
          #$00#$07#$E0#$00+
          #$00#$07#$E0#$00+
          #$80#$01#$80#$01+
          #$80#$01#$80#$01+
          #$40#$00#$00#$02+
          #$30#$00#$00#$0C+
          #$0C#$00#$00#$30+
          #$03#$80#$01#$C0+
          #$00#$7C#$3E#$00;
 {MakeMsPtrObj(32,16,@Q.PtrMs[1]);}
 MissileCommandStart(Q);
End;

Procedure MissileCommandStart(Var Q:MissileCommandGame);
Var
 S:String;
Begin
 FillClr(Q.MI,SizeOf(Q.MI));
 FillClr(Q.MX1,SizeOf(Q.MX1));
 FillClr(Q.MX2,SizeOf(Q.MX2));
 Q.Level:=0;
 Q.Score:=0;
 Q.NumCity:=6;
 S:=#10#10#20#50#100#200;
 MoveLeft(S[1],Q.LevelMissile,SizeOf(Q.LevelMissile));
 S:=#2#4#5#6#10#16;
 MoveLeft(S[1],Q.LevelMaxMissile,SizeOf(Q.LevelMaxMissile));
 InitLevel(Q);
End;

Procedure MissileCommandRefresh(Var Context);
Var
 Q:MissileCommandGame Absolute Context;
 J:Byte;
 OldColor:Word;
 T:TextBoxRec;
Begin
 T:=Q.MainWin.T;
 T.X1:=WEGetRX1(Q.MainWin);
 T.Y1:=WEGetRY1(Q.MainWin);
 CoordTxt2Graph(T,Q.G);
 If BitsPerPixel>8Then Begin
  OldColor:=GetPixel(0,0);
  SetPixel(0,0,1);
  Q.Color1:=GetPixel(0,0);
  SetPixel(0,0,2);
  Q.Color2:=GetPixel(0,0);
  SetPixel(0,0,3);
  Q.Color3:=GetPixel(0,0);
  SetPixel(0,0,OldColor);
 End
  Else
 Begin
  Q.Color1:=1;
  Q.Color2:=2;
  Q.Color3:=3;
 End;
 WEPutWn(Q.MainWin,'Missile Command',CurrKrs.MalteDos.Window);
 WECloseIcon(Q.MainWin);
 WEPutFillBox(Q.MainWin,0,0,319,199,Black);
 WEPutFillBox(Q.MainWin,0,22*8,319,191,1);
 WEPutFillBox(Q.MainWin,0,19*8,15,22*8-1,1);
 WEPutFillBox(Q.MainWin,38*8,19*8,319,22*8-1,1);
 For J:=0to 15do Begin
  WEPutLine(Q.MainWin,20*8-4+J,Canon(J),20*8-4+J,20*8-1,2);
 End;
 WEPutFillBox(Q.MainWin,19*8,20*8,22*8-1,22*8-1,1);
 For J:=0to 5do Begin
  MissileCommandPutCity(Q,XCity(J),3);
 End;
 WESetKr(Q.MainWin,$B0);
 WEBarSpcHor(Q.MainWin,0,Q.MainWin.MaxY,Q.MainWin.MaxX);
 WEPutTxtXY(Q.MainWin,1,Q.MainWin.MaxY,'Pointage:');
End;

Procedure MissileCommandInputMode(Var Context;Mode:GameInputMode);Begin
End;

Function MissileCommandPlay(Var Context):Word;
Label
 C,Chk,Restart;
Var
 Q:MissileCommandGame Absolute Context;
 Out:Byte;
 XOut,T,YOut:SmallInt;
 X,Y,B:Word;
 XT,YT:Byte;
 I,J:SmallInt;
Begin
Restart:
 __ShowMousePtr;
 Repeat
  _BackKbd;
  I:=0;
  If(KeyPress)Then Begin
   MissileCommandPlay:=WEReadk(Q.MainWin);
   Exit;
  End;
C:While(I<=Q.MaxMissile)do Begin
   Out:=PutMissile(Q,Q.MX1[I],0,Q.MX2[I],22*8-1,Q.MI[I],15,XOut,YOut);
   If(Out>0)or(Q.MI[I]>=22*8-1)Then Begin
    __HideMousePtr;
    PutMissile(Q,Q.MX1[I],0,Q.MX2[I],22*8-1,Q.MI[I],0,T,T);
    If Out=3Then Begin
     Dec(Q.NumCity);
     EraseCity(Q,XOut);
     If Q.NumCity=0Then Begin
      WESetKr(Q.MainWin,$C);
      Q.MainWin.Y:=11;
      WEPutOTxt(Q.MainWin,'TOUTES LES CITêS SONT DêTRUITES,');
      Q.MainWin.Y:=13;
      WEPutOTxt(Q.MainWin,'PARTIE TERMINER!');
      ReadKey;
      Exit;
     End;
    End;
    __ShowMousePtr;
    Goto Chk;
   End
    Else
   Begin
    WaitRetrace;
    If Q.Level<4Then WaitRetrace;
    __GetMouseTextSwitch(XT,YT,B);
    If Not WEInWindow(Q.MainWin,XT,YT)Then Begin
     If(Q.PtrOn)Then Begin
      DisposeMousePtr;
      Q.PtrOn:=False;
     End;
     If B>0Then Begin
      If WEInCloseIcon(Q.MainWin,XT,YT)Then Begin
       __HideMousePtr;
       WaitMouseBut0;
       MissileCommandPlay:=kbClose;
       Exit;
      End;
     End;
     If B>0Then Begin
      MissileCommandPlay:=WEReadk(Q.MainWin);
      Exit;
     End;
    End
     Else
    Begin
     If(Not Q.PtrOn)Then Begin
      MakeMousePtrObj(32,16,@Q.PtrMs[1]);
      Q.PtrOn:=True;
     End;
     GetMouseSwitch(X,Y,B);
     Dec(X,Q.G.X1);
     Dec(Y,Q.G.Y1);
     If B>0Then Begin
      If(X<=XOut)and(X+31>=XOut)and(Y<=YOut)and(Y+15>=YOut)Then Begin
       Inc(Q.KM);
       __HideMousePtr;
       PutMissile(Q,Q.MX1[I],0,Q.MX2[I],22*8-1,Q.MI[I],0,T,T);
       __ShowMousePtr;
       Inc(Q.Score,100);
       UpDateScore(Q);
   Chk:If Q.Missile2Send>0Then Begin
        MakeNewMissile(Q,I);
        Dec(Q.Missile2Send);
       End
        Else
       If Q.MaxMissile>0Then Begin
        Repeat
         If(I=Q.MaxMissile)or(Q.MaxMissile=0)Then Break;
         For J:=I to Q.MaxMissile-1do Begin
          Q.MI[J]:=Q.MI[J+1];
          Q.ML[J]:=Q.ML[J+1];
          Q.MX1[J]:=Q.MX1[J+1];
          Q.MX2[J]:=Q.MX2[J+1]
         End;
        Until True;
        Dec(Q.MaxMissile);I:=0;
        Goto C;
       End
        Else
       Begin
        __HideMousePtr;
        If Q.KM>0Then For I:=0to(15*Q.NumCity)do Begin
         WaitRetrace;
         WaitRetrace;
         Inc(Q.Score,5);
         UpDateScore(Q);
        End;
        Inc(Q.Level);
        WESetKr(Q.MainWin,$B);
        Q.MainWin.Y:=Q.MainWin.MaxY shr 1;
        WEPutOTxt(Q.MainWin,'PRES POUR LE NIVEAU '+WordToStr(Q.Level+1)+'!');
        Repeat
         If GetMouseButton>0Then Break;
        Until KeyPress;
        If GetMouseButton=0Then ReadKey
                           Else WaitMouseBut0;
        WEPutFillBox(Q.MainWin,0,0,319,19*8-1,Black);
        InitLevel(Q);
        Goto Restart;
       End;
      End;
     End;
    End;
    Inc(Q.MI[I],Q.ML[I]);
   End;
   Inc(I);
  End;
 Until No;
End;

Function MissileCommandTitle(Var QX;Max:Byte):String;Begin
 MissileCommandTitle:='Missile Command';
End;

Procedure MissileCommandSetLevel(Var Q:MissileCommandGame);Begin;End;
Procedure MissileCommandSetScrn(Var Q:MissileCommandGame;Full:Boolean);Begin;End;

Procedure MissileCommandMove2(Var QX;X,Y:Byte);
Var
 Q:MissileCommandGame Absolute QX;
 MX,MY:Byte;
Begin
 MX:=Q.MainWin.T.X2-Q.MainWin.T.X1;
 MY:=Q.MainWin.T.Y2-Q.MainWin.T.Y1;
 Q.MainWin.T.X1:=X;Q.MainWin.T.X2:=X+MX;
 Q.MainWin.T.Y1:=Y;Q.MainWin.T.Y2:=Y+MY;
 MissileCommandRefresh(Q);
End;

Function MissileCommandDone(Var Q):Word;Begin
 MissileCommandDone:=0;
End;

END.