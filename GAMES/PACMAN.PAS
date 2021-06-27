Program PacMan;

{$DEFINE Page}
{$I \SOURCE\CHANTAL\DEF.INC}
Uses {$IFDEF Adele}Adele{$ELSE}Chantal{$ENDIF},Systex,Systems,Video,Goldnaxe;

Const Tab001:Array[1..9,1..17]of Byte=(
(1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,1),
(1,2,2,2,1,2,2,2,2,2,2,1,2,2,2,1,1),
(1,7,1,2,1,2,1,1,1,1,2,1,2,1,7,1,1),
(0,2,2,2,2,2,2,2,2,2,2,2,2,2,2,1,1),
(1,1,2,1,1,2,1,1,1,1,2,1,1,2,1,1,1),
(1,2,2,2,1,2,2,2,2,2,2,1,2,2,2,0,1),
(1,7,1,2,1,2,1,1,1,1,2,1,2,1,7,1,1),
(1,2,2,2,2,2,2,3,2,2,2,2,2,2,2,1,1),
(1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1)
);

Const TabBig001:Array[1..17,1..17]of Byte=(
(1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,1),
(1,2,2,2,2,2,2,2,2,2,2,2,2,2,2,1,1),
(1,7,1,2,1,2,1,1,1,1,2,1,2,1,7,1,1),
(0,2,2,2,1,2,2,2,2,2,2,1,2,2,2,1,1),
(1,1,2,1,1,2,1,1,1,1,2,1,1,2,1,1,1),
(1,2,2,2,2,2,2,2,2,2,2,2,2,2,2,1,1),
(1,2,1,2,1,2,1,1,1,1,2,1,2,1,2,1,1),
(1,2,2,2,1,2,1,0,0,1,2,1,2,2,2,1,1),
(1,1,2,1,1,2,1,1,1,1,2,1,1,2,1,1,1),
(1,2,2,2,2,2,2,2,2,2,2,2,2,2,2,1,1),
(1,2,1,2,1,2,1,1,1,1,2,1,2,1,2,1,1),
(1,2,2,2,1,2,2,2,2,2,2,1,2,2,2,1,1),
(1,1,2,1,1,2,1,1,1,1,2,1,1,2,1,1,1),
(1,2,2,2,2,2,2,2,2,2,2,2,2,2,2,0,1),
(1,7,1,2,1,2,1,1,1,1,2,1,2,1,7,1,1),
(1,2,2,2,1,2,2,3,2,2,2,1,2,2,2,1,1),
(1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1));

 Width=17;
 {$IFDEF Page}Height=17;{$ELSE}Height=9;{$ENDIF}

Pastille:Array[0..2,0..2]of Byte=((8,7,8),(7,15,7),(8,7,8));

PalYellow:Array[0..7]of RGB=(
 (R:$FC-70;G:$FC-70;B:$24-35),
 (R:$FC-60;G:$FC-60;B:$24-30),
 (R:$FC-50;G:$FC-50;B:$24-25),
 (R:$FC-40;G:$FC-40;B:$24-20),
 (R:$FC-30;G:$FC-30;B:$24-15),
 (R:$FC-20;G:$FC-20;B:$24-10),
 (R:$FC-10;G:$FC-10;B:$24-5),
 (R:$FC;G:$FC;B:$24));

PalCyan:Array[0..7]of RGB=(
  (R:$00;G:$FC-105;B:$FC-105),
  (R:$00;G:$FC-90;B:$FC-90),
  (R:$00;G:$FC-75;B:$FC-75),
  (R:$00;G:$FC-60;B:$FC-60),
  (R:$00;G:$FC-45;B:$FC-45),
  (R:$00;G:$FC-30;B:$FC-30),
  (R:$00;G:$FC-15;B:$FC-15),
  (R:$00;G:$FC;B:$FC)
);

PalGreen:Array[0..7]of RGB=(
  (R:$00;G:$FC-120;B:0),
  (R:$00;G:$FC-105;B:0),
  (R:$00;G:$FC-90;B:0),
  (R:$00;G:$FC-75;B:0),
  (R:$00;G:$FC-60;B:0),
  (R:$00;G:$FC-45;B:0),
  (R:$00;G:$FC-30;B:0),
  (R:$00;G:$FC-15;B:0)
);

Var K,RA,I,J,SC,VC,VX,OXI,OYI,XI,YI,ID,BP:Integer;A,A2:Array[1..18,1..17]of Byte;
    OX,OY,X,Y,DX,DY,DA:Array[1..4]of Integer;J1,J2,J3,J4,F1,T1,T2,P1:Array[0..999]of Byte;
    TBi:Array[1..5,0..3999]of Byte;XP1,XP2,YP:Array[0..31]of Wd;Ok:Bool;
    Life:Integer;Nm:Array[0..9]of Array[0..8*16-1]of Byte;
{$IFDEF Page}
    CurrPg:Byte;
{$ELSE}
    BackgroundScreen:^TByte;
{$ENDIF}

{$IFNDEF Page}
 Procedure SetBckScr;Near;Begin
  SetVideoSeg(PtrRec(BackgroundScreen).Seg)
 End;

 Procedure SetVisualScr;Near;Begin
  SetVideoSeg($A000)
 End;
{$ENDIF}

Function Sgn(X:Integer):Integer;Near;Begin
 If X=0Then Sgn:=0 Else
 If X>0Then Sgn:=1 Else Sgn:=-1;
End;

Function _1(X:Integer):Wd;Near;Assembler;ASM
 MOV BX,X
 SHL BX,1
 MOV AX,Word Ptr XP1[BX]
END;

Function _2(X:Integer):Wd;Near;Assembler;ASM
 MOV BX,X
 SHL BX,1
 MOV AX,Word Ptr XP2[BX]
END;

Function peekA(Y,X:Integer):Byte;Near;Assembler;ASM
 MOV BX,Y
 SHL BX,1
 MOV AX,Word Ptr YP[BX]
 MOV BX,X
 DEC BX
 ADD BX,AX
 MOV AL,Byte Ptr A[BX]
END;

Function peekA2(Y,X:Integer):Byte;Near;Assembler;ASM
 MOV BX,Y
 SHL BX,1
 MOV AX,Word Ptr YP[BX]
 MOV BX,X
 DEC BX
 ADD BX,AX
 MOV AL,Byte Ptr A2[BX]
END;

Procedure pokeA(Y,X:Integer;Value:Byte);Near;Assembler;ASM
 MOV BX,Y
 SHL BX,1
 MOV AX,Word Ptr YP[BX]
 MOV BX,X
 DEC BX
 ADD BX,AX
 MOV AL,Value
 MOV Byte Ptr A[BX],AL
END;

Procedure pokeA2(Y,X:Integer;Value:Byte);Near;Assembler;ASM
 MOV BX,Y
 SHL BX,1
 MOV AX,Word Ptr YP[BX]
 MOV BX,X
 DEC BX
 ADD BX,AX
 MOV AL,Value
 MOV Byte Ptr A2[BX],AL
END;

Function A3(Y,X:Integer):Byte;Near;Begin
 If A[Y,X]=0Then Begin
  If(Y=1)and(X=8)Then A3:=1 Else
  If(Y=9)and(X=9)Then A3:=1 Else
  If(Y=4)and(X=1)Then A3:=1 Else
  If(Y=6)and(X=16)Then A3:=1
                  Else A3:=peekA(Y,X);
 End
  Else
 A3:=peekA(Y,X);
End;

Procedure PutBox(Y,X:Integer);Near;Begin
 Case peekA(Y,X)of
  1:PutSmlImg(_1(X),_1(Y),_2(X),_2(Y),T1);
  2:PutSmlImg(_1(X),_1(Y),_2(X),_2(Y),T2);
  7:PutSmlImg(_1(X),_1(Y),_2(X),_2(Y),P1);
  Else PutFillBox(_1(X),_1(Y),_2(X),_2(Y),Black);
 End;
End;

Procedure MoveSprit;Near;Var X1,Y1,XP,YP,I:Integer;Begin
 {$IFDEF Page}
  CurrPg:=CurrPg xor 1;
  SetPg(CurrPg);
 {$ENDIF}
 For I:=1to 4do Begin;
  PutBox(Y[I],X[I]);
  If OX[I]<>X[I]Then Begin
   PutBox(Y[I],X[I]-1);
   PutBox(Y[I],X[I]+1);
  End
   else
  Begin
   PutBox(Y[I]-1,X[I]);
   PutBox(Y[I]+1,X[I]);
  End;
 End;
 PutBox(YI,XI);
 If(OXI<>XI)Then Begin;PutBox(YI,XI-1);PutBox(YI,XI+1)End
            else Begin;PutBox(YI-1,XI);PutBox(YI+1,XI)End;
 XP:=0;YP:=0;
 If(OXI<XI)Then XP:=RA shl 1;
 If(OXI>XI)Then XP:=-(RA shl 1);
 If(OYI<YI)Then YP:=RA shl 1;
 If(OYI>YI)Then YP:=-(RA shl 1);
 For I:=1to 4do Begin
  X1:=0;Y1:=0;
  If OX[I]<X[I]Then X1:=RA shl 1;
  If OX[I]>X[I]Then X1:=-(RA shl 1);
  If OY[I]<Y[I]Then Y1:=RA shl 1;
  If OY[I]>Y[I]Then Y1:=-(RA shl 1);
  PutSmlImg(_1(OX[I])+X1,_1(OY[I])+Y1,_2(OX[I])+X1,_2(OY[I])+Y1,F1);
 End;
 If(XP<>YP)Then Begin
  If ID=1Then Case(RA)of
   0,1,5,6,7:PutSmlImg(_1(OXI)+XP,_1(OYI)+YP,_2(OXI)+XP,_2(OYI)+YP,J1);
   2,3,4,8,9:PutSmlImg(_1(OXI)+XP,_1(OYI)+YP,_2(OXI)+XP,_2(OYI)+YP,J3);
  End
   Else
  Case(RA)of
   0,1,5,6,7:PutSmlImg(_1(OXI)+XP,_1(OYI)+YP,_2(OXI)+XP,_2(OYI)+YP,J2);
   2,3,4,8,9:PutSmlImg(_1(OXI)+XP,_1(OYI)+YP,_2(OXI)+XP,_2(OYI)+YP,J4);
  End;
 End
  Else
 If ID=1Then PutSmlImg(_1(XI),_1(YI),_2(XI),_2(YI),J1)
        Else PutSmlImg(_1(XI),_1(YI),_2(XI),_2(YI),J2);
 {$IFNDEF Page}
 MoveLeft(BackgroundScreen^[320*20],Mem[_A000:320*20],64000-320*60);
 {$ELSE}
  For I:=1to 4do GetSmlImg(_1(X[I])-5,_1(Y[I])-5,_2(X[I])+5,_2(Y[I])+5,TBi[I]);
  GetSmlImg(_1(XI)-5,_1(YI)-5,_2(XI)+5,_2(YI)+5,TBi[5]);
  _WaitRetrace;
  SetVisualPg(CurrPg);
  SetPg(CurrPg xor 1);
  For I:=1to 4do PutSmlImg(_1(X[I])-5,_1(Y[I])-5,_2(X[I])+5,_2(Y[I])+5,TBi[I]);
  PutSmlImg(_1(XI)-5,_1(YI)-5,_2(XI)+5,_2(YI)+5,TBi[5]);
 {$ENDIF}
End;

Procedure ClrBox;Near;Begin
 PokeA(YI,XI,0);  { A[YI,XI]:=0; }
 PokeA2(YI,XI,0); { A2[YI,XI]:=0; }
 {$IFDEF Page}
  SetPage(CurrPg);
 {$ENDIF}
 PutBox(YI,XI);
 {$IFDEF Page}
  SetPage(CurrPg xor 1);
  PutBox(YI,XI);
 {$ENDIF}
End;

Procedure PutScore;Var J,X:Wd;S:String;Begin
 S:=StrW(SC);X:=160;
 SetPage(CurrPg xor 1);
 For J:=1to Length(S)do Begin
  PutSmlImg(X,384,X+7,399,Nm[Byte(S[J])-48]);
  Inc(X,8);
 End;
 X:=160;
 SetPage(CurrPg);
 For J:=1to Length(S)do Begin
  PutSmlImg(X,384,X+7,399,Nm[Byte(S[J])-48]);
  Inc(X,8);
 End;
End;

Procedure PutPac;Near;Begin
 If peekA2(YI,XI)=7Then Begin
  Inc(SC,50);Inc(VC);
  PutScore;
{  _PutTxtXY(0,24,'POINTAGE='+StrW(SC));}
 End;
 If peekA2(YI,XI)=2Then Begin
  Inc(SC,5);Inc(VC);
  PutScore;
{  _PutTxtXY(0,24,'POINTAGE='+StrW(SC));}
 { SOUND 320,1:SOUND 310,1}
 End;
 pokeA(YI,XI,3);  { A[YI,XI]:=3; }
 pokeA2(YI,XI,3); { A2[YI,XI]:=3; }
 VX:=(VX+1)and 1;
End;

Procedure PutLife;Var J:Integer;Begin
 PutFillBox(0,340,159,399,0);
 For J:=1to(Life)do PutSmlImg(_1(J),340,_2(J),340+19,J1);
End;

BEGIN
 InitSystems(suIsabel);
 Randomize;
  {M‚morise les nombres}
 SetVideoModeDeluxe(vmGrf320x200c256);
 LoadMtx('APPLICAT.FNT');
 SetPalBlk(0,256);
 PutTxtXY(0,0,'0123456789',$F);
 For J:=0to 15do For I:=0to 8*10-1do Begin
  If GetPixel(I,J)<>0Then SetPixel(I,J,16+J);
 End;
 For J:=0to 9do Begin
  GetSmlImg(J shl 3,0,(J shl 3)+7,15,Nm[J]);
 End;
 {$IFNDEF Page}
 BackgroundScreen:=MemNew(64032);
 Inc(PtrRec(BackgroundScreen).Seg);PtrRec(BackgroundScreen).Ofs:=0;
 SetVideoModeDeluxe(vmGrf320x200c256);
 {$ELSE}
 SetVideoModeDeluxe(vmGrf320x400c256);
 CurrPg:=0;
 SetPg(1);
 {$ENDIF}
 SetPalRGB(PalGreen,228,8);
 SetPalRGB(PalCyan,236,8);
 SetPalRGB(PalYellow,244,8);
 {$IFNDEF Page}
  SetBckScr;
 {$ENDIF}
  {Pac-Man Droite}
 For I:=0to 7do PutFillCircle(10,10,10-I,244+I);
 PutFillCircle(10,5,2,15);
 SetPixel(11,5,0); SetPixel(12,5,7);
 GetSmlImg(1,1,20,20,J3);
 For I:=0to 9do ClrLnHor(11+I,10+I,10,Black);
 GetSmlImg(1,1,20,20,J1);
  {Pac-Man Gauche}
 For I:=0to 7do PutFillCircle(35,10,10-I,244+I);
 PutFillCircle(35,5,2,15);
 SetPixel(34,5,0);SetPixel(33,5,7);
 GetSmlImg(26,1,45,20,J4);
 For I:=0to 9do ClrLnHor(25-I,10+I,10,Black);
 GetSmlImg(26,1,45,20,J2);
 { Fant“me }
 PutFillCircle(60,10,10,LightGreen);
 PutFillBox(60-10,10,60+10,10+10,Black);
 PutFillBox(60-10,10,60+10,10+5,LightGreen);
 For I:=1to 5do Begin
  ClrLnHor(71-I,21-I,I,LightGreen);
  ClrLnHor(61-I,21-I,(I shl 1)-1,LightGreen);
  ClrLnHor(50,21-I,I,LightGreen);
 End;
 Draw('C10BM50,10D10E5F5E5F5U10');
 PutFillCircle(55,7,2,White);
 SetPixel(55,7,Black);
 PutFillCircle(65,7,2,White);
 SetPixel(65,7,Black);
 PutFillBox(70,0,71,199,0);
 For J:=0to 69do For I:=0to 7do Begin
  If(GetPixel(50+I,J)=LightGreen)Then SetPixel(50+I,J,228+I);
  If(GetPixel(70-I,J)=LightGreen)Then SetPixel(70-I,J,228+I);
 End;
 GetSmlImg(51,1,70,20,F1);
  { Mur }
 Draw('C252BM100,102D16FR16EU16HL16');
 For I:=0to 2do PutFillBox(101+I,102+I,101+16-I,102+16-I,253+I);
 GetSmlImg(100,100,119,119,T1);
  {Pastille}
 PutSmlImg(55,60,55+2,60+2,Pastille);
 PutSmlImg(65,60,65+2,60+2,Pastille);
 GetSmlImg(50,50,69,69,T2);
  { Pillule }
 For I:=0to 7do PutFillCircle(80,10,8-I,236+I);
 GetSmlImg(71,1,90,20,P1);
{ SetVisualScr;}
 {$IFDEF Page}
  MoveLeft(TabBig001,A,SizeOf(A));MoveLeft(TabBig001,A2,SizeOf(A2));
 {$ELSE}
  MoveLeft(Tab001,A,SizeOf(A));MoveLeft(Tab001,A2,SizeOf(A2));
 {$ENDIF}
 For I:=0to 31do Begin;XP1[I]:=(I-1)*20;XP2[I]:=(I*20)-1;YP[I]:=(I-1)*17;End;
 For YI:=1to(Height)do For XI:=1to 16do PutBox(YI,XI);
 XI:=8;YI:=Height-1;OXI:=XI;OYI:=YI;ID:=1;SC:=0;VC:=0;RA:=0;VX:=1;
 PutSmlImg(_1(XI),_1(YI),_2(XI),_2(YI),J1);
 For I:=1to 4do Begin
  DX[I]:=SGN(XI-X[I]);DY[I]:=SGN(YI-Y[I]);DA[I]:=0;
  X[I]:=(I+6)and $FFFE+(Not(I+6)and 1);Y[I]:=4;A[Y[I],X[I]]:=1;
  OX[I]:=X[I];OY[I]:=Y[I];
  PutSmlImg(_1(X[I]),_1(Y[I]),_2(X[I]),_2(Y[I]),F1);
 End;
 DX[1]:=-1;DX[2]:=-1;DX[4]:=1;RA:=0;BP:=0;Life:=5;
 PutLife;
 {$IFNDEF Page}
  MoveLeft(BackgroundScreen^,Mem[_A000:0],64000);
 {$ELSE}
  PCopy(1,0);
  SetVisualPg(0);
  SetPg(0);
 {$ENDIF}
 PutScore;
 Repeat
  Repeat
   ClrKbd;
   Inc(RA);
   {$IFNDEF Page}
    _WaitDisplay;
   {$ENDIF}
   If RA=5Then Begin
    {$IFDEF Page}
     SetPg(CurrPg);
    {$ENDIF}
    Case(BP)of
     0:Begin
      PutBox(3,2);PutBox(3,15);PutBox(Height-2,2);PutBox(Height-2,15);
     End;
     2:Begin
      PutFillBox(2*20-20,3*20-20,2*20-1,3*20-1,Black);
      PutFillBox(15*20-20,3*20-20,15*20-1,3*20-1,Black);
      PutFillBox(2*20-20,(Height-2)*20-20,2*20-1,(Height-2)*20-1,Black);
      PutFillBox(15*20-20,(Height-2)*20-20,15*20-1,(Height-2)*20-1,Black);
     End;
    End;
    {$IFDEF Page}
    SetPg(CurrPg xor 1);
    Case(BP)of
     0:Begin
      PutBox(3,2);PutBox(3,15);PutBox(Height-2,2);PutBox(Height-2,15);
     End;
     2:Begin
      PutFillBox(2*20-20,3*20-20,2*20-1,3*20-1,Black);
      PutFillBox(15*20-20,3*20-20,15*20-1,3*20-1,Black);
      PutFillBox(2*20-20,(Height-2)*20-20,2*20-1,(Height-2)*20-1,Black);
      PutFillBox(15*20-20,(Height-2)*20-20,15*20-1,(Height-2)*20-1,Black);
     End;
    End;
    SetPg(CurrPg);
    {$ENDIF}
    BP:=(BP+1)and 3;
   End;
   MoveSprit;
   If RA>=10Then Begin
    For I:=1to 4do Begin
     Ok:=No;OX[I]:=X[I];OY[I]:=Y[I];
     Case A3(Y[I],X[I]+DX[I])of
      0,2,7:Begin
       pokeA(Y[I],X[I],peekA2(Y[I],X[I]));
       X[I]:=X[I]+DX[I];
       pokeA(Y[I],X[I],4);
       Ok:=Ya;
      End;
      4:DA[I]:=DA[I]xor 1;
     End;
     If Not(Ok)Then Case A3(Y[I]+DY[I],X[I])of
      0,2,7:Begin
       pokeA(Y[I],X[I],peekA2(Y[I],X[I]));
       Y[I]:=Y[I]+DY[I];
       pokeA(Y[I],X[I],4);
       Ok:=Ya;
      End;
      4:DA[I]:=DA[I]xor 1;
     End;
     Case DA[I]of
      0:If Not(Ok)Then Case A3(Y[I],X[I]-DX[I])of
       0,2,7:Begin
        pokeA(Y[I],X[I],peekA2(Y[I],X[I]));
        X[I]:=X[I]-DX[I];
        pokeA(Y[I],X[I],4);
        Ok:=Ya;DX[I]:=-DX[I];DA[I]:=DA[I]xor 1;
       End;
      End;
      1:If Not(Ok)Then Case peekA(Y[I]-DY[I],X[I])of
       0,2,7:Begin
        pokeA(Y[I],X[I],peekA2(Y[I],X[I]));
        Y[I]:=Y[I]-DY[I];
        pokeA(Y[I],X[I],4);
        Ok:=Ya;DY[I]:=-DY[I];DA[I]:=DA[I]xor 1;
       End;
      End;
     End;
     Case DA[I]xor 1of
      0:If Not(Ok)Then Case A3(Y[I],X[I]-DX[I])of
       0,2,7:Begin
        pokeA(Y[I],X[I],peekA2(Y[I],X[I]));
        X[I]:=X[I]-DX[I];
        pokeA(Y[I],X[I],4);
        Ok:=Ya;DX[I]:=-DX[I];DA[I]:=DA[I]xor 1;
       End;
      End;
      1:If Not(Ok)Then Case peekA(Y[I]-DY[I],X[I])of
       0,2,7:Begin
        pokeA(Y[I],X[I],peekA2(Y[I],X[I]));
        Y[I]:=Y[I]-DY[I];
        pokeA(Y[I],X[I],4);
        Ok:=Ya;DY[I]:=-DY[I];DA[I]:=DA[I]xor 1;
       End;
      End;
     End;
    End;
    RA:=0;
    {$IFDEF Page}
     If VC=135Then Begin;_PutTxtXY(9,9,'BRAVO!');Halt;End;
    {$ELSE}
     If VC=67Then Begin;_PutTxtXY(9,9,'BRAVO!');Halt;End;
    {$ENDIF}
    OYI:=YI;OXI:=XI;
   End;
  Until(KeyPress)and(OXI=XI)and(OYI=YI);
  K:=ReadKey;
  Case(K)of
   kbEsc:Break;
   kbUp:Begin
    OYI:=YI;OXI:=XI;
    If(XI=8)and(YI=2)Then Begin;ClrBox;XI:=9;YI:=Height-1;PutPac;End Else
    Case peekA(YI-1,XI)of
     0,2,7:Begin;ClrBox;Dec(YI);PutPac;End;
    End;
   End;
   kbLeft:Begin
    OYI:=YI;OXI:=XI;
    ID:=0;
    If(YI=4)and(XI=2)Then Begin;ClrBox;YI:=6;XI:=15;PutPac;End Else
    If peekA(YI,XI-1)in[0,2,7]Then Begin;ClrBox;Dec(XI);PutPac;End;
   End;
   kbRight:Begin
    OYI:=YI;OXI:=XI;
    ID:=1;
    If(YI=6)and(XI=15)Then Begin;ClrBox;YI:=4;XI:=2;PutPac;End Else
    If peekA(YI,XI+1)in[0,2,7]Then Begin;ClrBox;Inc(XI);PutPac;End;
   End;
   kbDn:Begin
    OYI:=YI;OXI:=XI;
    If(XI=9)and(YI=Height-1)Then Begin;ClrBox;XI:=8;YI:=2;PutPac;End Else
    If peekA(YI+1,XI)in[0,2,7]Then Begin;ClrBox;Inc(YI);PutPac;End;
   End;
  End;
 Until No;
END.