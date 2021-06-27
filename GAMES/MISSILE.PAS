Program MissileCommand;

{$I \Source\Chantal\Def.Inc}
Uses {$IFDEF Adele}Adele,{$ELSe}Chantal,{$ENDIF}
     Video,Systex,Systems,Mouse,Math;

Var
 Score:LongInt;
 NmCity:Byte;

Function Canon(I:Byte):Byte;
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

Procedure PtrMs;Assembler;ASM
 DB 11111111b,00000000b,00000000b,11111111b
 DB 11111111b,11111111b,11111111b,11111111b
 DB 11111111b,11111111b,11111111b,11111111b
 DB 11111111b,11111111b,11111111b,11111111b
 DB 11111111b,11111111b,11111111b,11111111b
 DB 11111111b,11111111b,11111111b,11111111b
 DB 01111111b,11111111b,11111111b,11111110b
 DB 01111111b,11111111b,11111111b,11111110b
 DB 01111111b,11111111b,11111111b,11111110b
 DB 01111111b,11111111b,11111111b,11111110b
 DB 11111111b,11111111b,11111111b,11111111b
 DB 11111111b,11111111b,11111111b,11111111b
 DB 11111111b,11111111b,11111111b,11111111b
 DB 11111111b,11111111b,11111111b,11111111b
 DB 11111111b,11111111b,11111111b,11111111b
 DB 11111111b,00000000b,00000000b,11111111b

 DB 00000000b,01111100b,00111110b,00000000b
 DB 00000011b,10000000b,00000001b,11000000b
 DB 00001100b,00000000b,00000000b,00110000b
 DB 00110000b,00000000b,00000000b,00001100b
 DB 01000000b,00000000b,00000000b,00000010b
 DB 10000000b,00000001b,10000000b,00000001b
 DB 10000000b,00000001b,10000000b,00000001b
 DB 00000000b,00000111b,11100000b,00000000b
 DB 00000000b,00000111b,11100000b,00000000b
 DB 10000000b,00000001b,10000000b,00000001b
 DB 10000000b,00000001b,10000000b,00000001b
 DB 01000000b,00000000b,00000000b,00000010b
 DB 00110000b,00000000b,00000000b,00001100b
 DB 00001100b,00000000b,00000000b,00110000b
 DB 00000011b,10000000b,00000001b,11000000b
 DB 00000000b,01111100b,00111110b,00000000b
END;

Function PutMissile(X1,Y1,X2,Y2,Limit,Kr:Int;Var XOut,YOut:Int):Byte;Var D,DX,DY,I,J,Ainc,Binc,Ic,OK:Int;Begin
 PutMissile:=0;
 If AbsInt(X2-X1)<AbsInt(Y2-Y1)Then Begin
  If(Y1>Y2)Then ASM MOV AX,X1;XCHG AX,X2;MOV X1,AX;MOV AX,Y1;XCHG AX,Y2;MOV Y1,AX;END;
  If(X2>X1)Then Ic:=1 Else Ic:=-1;
  DY:=Y2-Y1;DX:=AbsInt(X2-X1);D:=(DX shl 1)-DY;Ainc:=(DX-DY)shl 1;Binc:=DX shl 1;J:=X1;
  SetPixel(X1,Y1,Kr);
  I:=Y1+1;
  While(I<=Y2)do Begin
   If D>=0Then Begin Inc(J,Ic);Inc(D,Ainc)End else Inc(D,Binc);
   OK:=GetPixel(J,I);
   If OK in[1,2,3]Then Begin XOut:=J;PutMissile:=OK;Exit;End;
   SetPixel(J,I,Kr);
   If(I>Limit)Then Begin XOut:=J;YOut:=I;Exit;End;
   Inc(I);
  End;
 End
  else
 Begin
{  If(X1>X2)Then ASM MOV AX,X1;XCHG AX,X2;MOV X1,AX;MOV AX,Y1;XCHG AX,Y2;MOV Y1,AX;END;}
  If(Y2>Y1)Then Ic:=1 else Ic:=-1;
  DX:=AbsInt(X2-X1);DY:=AbsInt(Y2-Y1);D:=(DY shl 1)-DX;AInc:=(DY-DX)shl 1;BInc:=DY shl 1;J:=Y1;
  SetPixel(X1,Y1,Kr);
  If(X1>X2)Then Begin
   I:=X1;
   While(I>=X2)do Begin
    If D>=0Then Begin Inc(J);Inc(D,Ainc)End else Inc(D,Binc);
    OK:=GetPixel(I,J);
    If OK in[1,2,3]Then Begin XOut:=I;PutMissile:=OK;Exit;End;
    SetPixel(I,J,Kr);
    If(J>Limit)Then Begin XOut:=I;YOut:=J;Exit;End;
    Dec(I);
   End;
  End
   Else
  Begin
   I:=X1+1;
   While(I<=X2)do Begin
    If D>=0Then Begin J:=J+Ic;Inc(D,Ainc)End else Inc(D,Binc);
    OK:=GetPixel(I,J);
    If OK in[1,2,3]Then Begin XOut:=I;PutMissile:=OK;Exit;End;
    SetPixel(I,J,Kr);
    If(J>Limit)Then Begin XOut:=I;YOut:=J;Exit;End;
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

Procedure _PutCity(X:Wd);Var I:Byte;Begin
 For I:=0to 22do _Ln(X+I,20*8+EY(I),X+I,22*8-1)
End;

Procedure PutCity(X:Wd);Begin _SetKr(3);_PutCity(X)End;

Procedure EraseCity(X:Wd);
Var
 I:Byte;
Begin
 For I:=0to 5do If(X>=XCity(I))and(X<=XCity(I)+22)Then Break;
 _SetKr(0);_PutCity(XCity(I));
 For I:=0to 2do Begin
  SetPalRGB(DefaultRGB[15],0,1);WaitRetrace;
  SetPalRGB(DefaultRGB[0],0,1);WaitRetrace
 End;
End;

Procedure InitScr;Var J:Byte;Begin
 _SetKr(1);_PutFillBox(0,22*8,319,191);
 _PutFillBox(0,19*8,15,22*8-1);_PutFillBox(38*8,19*8,319,22*8-1);
 For J:=0to 15do PutLn(20*8-4+J,Canon(J),20*8-4+J,20*8-1,2);
 _PutFillBox(19*8,20*8,22*8-1,22*8-1);
 For J:=0to 5do PutCity(XCity(J));
 BarSpcHor(0,24,MaxXTxts,$B0);
 PutTxtXY(1,24,'Pointage:',$B0);
End;

Var MI,ML:Array[0..19]of Byte;MX1,MX2:Array[0..19]of Wd;MaxMissile,Missile2Send:Int;Level:Wd;

Procedure MakeNewMissile(I:Byte);Begin
 MI[I]:=0;ML[I]:=1+Random(Level);
 MX1[I]:=Random(318);MX2[I]:=Random(38*8-34)+16;
End;

Procedure UpDateScore;Begin;PutTxtXY(11,24,CStr(Score),$B0)End;

Const LevelMissile:Array[0..5]of Byte=(10,10,20,50,100,200);
      LevelMaxMissile:Array[0..5]of Byte=(2,4,5,6,10,16);

Procedure Play;Label C,Chk,BreakAll;Var Out:Byte;XOut,T,YOut:Int;X,Y,B:Wd;I,J,KM:Int;Begin
 FillClr(MI,SizeOf(MI));FillClr(MX1,SizeOf(MX1));FillClr(MX2,SizeOf(MX2));
 Level:=0;Score:=0;NmCity:=6;
 Repeat
  If Level>5Then I:=5 Else I:=Level;
  MaxMissile:=LevelMaxMissile[I];Missile2Send:=LevelMissile[I];KM:=0;
  PutTxtXY(25,24,'Niveau: '+WordToStr(Level+1),$B0);
  UpDateScore;
  For I:=0to(MaxMissile)do MakeNewMissile(I);
  __ShowMousePtr;
  Repeat
   _BackKbd;
   I:=0;
   If(KeyPress)Then Begin;ReadKey;Exit;End;
 C:While(I<=MaxMissile)do Begin
    Out:=PutMissile(MX1[I],0,MX2[I],22*8-1,MI[I],15,XOut,YOut);
    If(Out>0)or(MI[I]>=22*8-1)Then Begin
     __HideMousePtr;
     PutMissile(MX1[I],0,MX2[I],22*8-1,MI[I],0,T,T);
     If Out=3Then Begin
      Dec(NmCity);
      EraseCity(XOut);
      If NmCity=0Then Begin
       PutTxtCenter(11,__Justified__,'TOUTES LES CITêS SONT DêTRUITES,',$C);
       PutTxtCenter(13,__Justified__,'PARTIE TERMINER!',$C);
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
     If Level<4Then WaitRetrace;
     GetMouseSwitch(X,Y,B);
     If B>0Then Begin
      If(X<=XOut)and(X+31>=XOut)and(Y<=YOut)and(Y+15>=YOut)Then Begin
       Inc(KM);
       __HideMousePtr;
       PutMissile(MX1[I],0,MX2[I],22*8-1,MI[I],0,T,T);
       __ShowMousePtr;
       Inc(Score,100);
       UpDateScore;
   Chk:If Missile2Send>0Then Begin
        MakeNewMissile(I);
        Dec(Missile2Send);
       End
        Else
       If MaxMissile>0Then Begin
        Repeat
         If(I=MaxMissile)or(MaxMissile=0)Then Break;
         For J:=I to MaxMissile-1do Begin;MI[J]:=MI[J+1];ML[J]:=ML[J+1];MX1[J]:=MX1[J+1];MX2[J]:=MX2[J+1]End;
        Until Ya;
        Dec(MaxMissile);I:=0;
        Goto C;
       End
        Else
       Goto BreakAll;
      End;
     End;
     Inc(MI[I],ML[I]);
    End;
    Inc(I);
   End;
  Until No;
BreakAll:
  __HideMousePtr;
  If KM>0Then For I:=0to(15*NmCity)do Begin
   WaitRetrace;
   WaitRetrace;
   Inc(Score,5);
   UpDateScore;
  End;
  Inc(Level);
  PutTxtCenter(12,__Justified__,'PRES POUR LE NIVEAU '+WordToStr(Level+1)+'!',$B);
  Repeat
   If GetMouseButton>0Then Break;
  Until KeyPress;
  If GetMouseButton=0Then ReadKey Else WaitMsBut0;
  PutFillBox(0,0,319,19*8-1,0);
 Until No;
End;

BEGIN
 Randomize;
 InitSystems(suIsabel);
 SetVideoModeDeluxe(vmGrf320x200c256);
 InitScr;
 __InitMouse;
 MakeMsPtrObj(32,16,@PtrMs);
 SetMouseMoveArea(0,0,319-32,19*8-1);
 __ShowMousePtr;
 Play;
 __HideMousePtr;
 DoneVideo;
 DoneSystems;
END.