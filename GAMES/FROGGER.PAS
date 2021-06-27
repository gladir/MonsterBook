{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                                                             Û
 ³                        F r o g g e r                        Û
 ³                                                             Û
 ³                            pour                             Û
 ³                                                             Û
 ³              L'ensemble Malte Genesis IV: AdŠle             Û
 ³    Tous droits r‚serv‚ par les Chevaliers de Malte 1998     Û
 ³                                                             Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  C'est le c‚lŠbre jeux de la grenouille devant traverser la rue.
}

Uses Adele,Systex,Systems,Video;

{$M 32768,0,655360}

Var CarX:Array[0..3,0..9]of Int;
    CarKr:Array[0..3,0..9]of Byte;
    WaitCar,NmWait,Timer:Word;
    FroggerX,FroggerY:Int;
    Accident,Life:Byte;

Procedure _PutFrogger(X,Y:Int);Begin
 _Move2(X+8,Y); {Affiche la grenouille}
 Draw('RFL3BL3L0BL2R0BR11R0BR2DL2BL2L5BL2L2FBR3R5BR3GL0BL2L5BL2FR7GL5R5BFBRL0BL2L5BL2DR9DBL3L3BL3DL2BR11R2');
End;

Procedure PutFrogger(X,Y:Int);Begin
 _SetKr(LightGreen);
 _PutFrogger(X,Y);
End;

Procedure UnputFrogger(X,Y:Int);Var Kr:Byte;Begin
 Case(Y)of
  3*12..10*12-1:Kr:=Blue;
  10*12..11*12-1:Kr:=Green;
  11*12..15*12-1:Kr:=LightGray;
  Else Kr:=Green;
 End;
 PutFillBox(X,Y,X+15,Y+11,Kr);
{ _PutFrogger(X,Y);}
End;

Procedure PutFeuille(X,Y:Int);Begin
 _Move2(X+8,Y); {Affiche la feuille}
 Draw('C3F3DFD2GDGL2H2UE2G3HBD2D0GBU2LHU2E4RE');
End;

Procedure PutBileau(X,Y:Int);Begin
 _Move2(X+48,Y); {Bileau}
 Draw('C2L45G2DGD2FDF2R46E2UEU2HUH2G2DGD2FDF2');
 _Move2(X+48,0); {Tiret b–che}
 Draw('C3BU3L3BD3L1BH2L2BG1BL4L3BH3L5BD3BG2R3BG3R5BR4R3BE2BR3R2');
End;

Procedure PutCarRight(X,Y,Kr:Int);Begin
 _Move2(X+8,Y); {Automobile vers la droite}
 _SetKr(Kr);
 Draw('R5FL8GRBR5R0BR4DBL4L0BL5LGR2BR5R0BR5R2FRL17GR19FL21DR21BDBLL4BL10L4BFBR2L2BR14R2BR2BE10');
End;

Procedure PutCarLeft(X,Y,Kr:Int);Begin
 _Move2(X+8,Y); {Automobile vers la gauche}
 _SetKr(Kr);
 Draw('L5GR8FLBL5L0BL4DBR4R0BR5RFL2BL5L0BL5L2GLR17FL19GR21DL21BDBRR4BR10R4BGBL2R2BL14L2BR26BE10');
End;

Function RunCar:Bool;Var I,J,K:Byte;CarFound:Bool;Begin
 RunCar:=Ya;
 For J:=0to 1do For I:=0to 9do Begin
  If CarX[J,I]=-1Then Begin
   CarFound:=No;
   For K:=0to 9do Begin
    If CarX[J,K]in[204..239]Then Begin;CarFound:=Ya;Break;End;
   End;
   If Not(CarFound)Then Begin
    If WaitCar=0Then Begin
     WaitCar:=Random(NmWait);
     CarX[J,I]:=204+J*12;CarKr[J,I]:=Random(15);
     If(CarKr[J,I]=LightGray)Then CarKr[J,I]:=LightRed;
     PutCarLeft(CarX[J,I],(11+J)*12,CarKr[I,J]);
    End
     Else
    Dec(WaitCar);
   End;
  End
   Else
  Begin
   PutCarLeft(CarX[J,I],(11+J)*12,LightGray);
   If CarX[J,I]<24Then CarX[J,I]:=-1
    Else
   Begin
    Dec(CarX[J,I],24);
    PutCarLeft(CarX[J,I],(11+J)*12,CarKr[I,J]);
   End;
  End;
  If(FroggerY=(11+J)*12)and((FroggerX-CarX[J,I])in[0..23])Then Exit;
 End;
 For J:=2to 3do For I:=0to 9do Begin
  If CarX[J,I]=-1Then Begin
   CarFound:=No;
   For K:=0to 9do Begin
    If CarX[J,K]in[0..23]Then Begin;CarFound:=Ya;Break;End;
   End;
   If Not(CarFound)Then Begin
    If WaitCar=0Then Begin
     WaitCar:=Random(NmWait);
     CarX[J,I]:=(J-2)*12;CarKr[J,I]:=Random(15);
     If(CarKr[J,I]=LightGray)Then CarKr[J,I]:=LightRed;
     PutCarRight(CarX[J,I],(11+J)*12,CarKr[I,J]);
    End
     Else
    Dec(WaitCar);
   End;
  End
   Else
  Begin
   PutCarRight(CarX[J,I],(11+J)*12,LightGray);
   Inc(CarX[J,I],24);
   If CarX[J,I]>(240-24)Then CarX[J,I]:=-1
   Else PutCarRight(CarX[J,I],(11+J)*12,CarKr[I,J]);
  End;
  If(FroggerY=(11+J)*12)and((FroggerX-CarX[J,I])in[0..23])Then Exit;
 End;
 RunCar:=No;
End;

Procedure PutTimer;Begin
 PutTxtXY(34,23,StrW(Timer)+'  ',LightRed);
End;

Procedure PutLife;Var J:Byte;Begin
 _SetKr(LightGreen);
 For J:=0to 3do Begin
  If(Life-1<J)Then _SetKr(Black);
  _PutFrogger(272,10+40*J);
 End;
End;

BEGIN
 Randomize;
 InitSystems(suIsabel);
 SetVideoModeDeluxe(vmGrf320x200c256);
 Life:=4;NmWait:=64;
 Repeat
  PutFillBox(0,0,239,35,Green);
  PutFillBox(0,3*12,239,10*12-1,Blue);
  PutFillBox(0,10*12,239,11*12-1,Green);
  PutFillBox(0,11*12,239,15*12-1,LightGray);
  PutFillBox(0,15*12,239,199,Green);
  PutRect(244,0,315,199,LightRed);
  PutTxtXY(31,21,'Horloge:',LightRed);
  PutLife;
  FillChr(CarX,SizeOf(CarX),$FF);
  WaitCar:=0;FroggerX:=120;FroggerY:=180;Timer:=400;Accident:=0;
  _SetKr(LightGreen);
  _PutFrogger(FroggerX,FroggerY);
  PutTimer;
  Repeat
   Repeat
    If(RunCar)Then Begin;Accident:=1;Break;End;
    WaitRetrace;WaitRetrace;WaitRetrace;WaitRetrace;
    WaitRetrace;WaitRetrace;WaitRetrace;WaitRetrace;
    WaitRetrace;WaitRetrace;WaitRetrace;WaitRetrace;
   { WaitRetrace;WaitRetrace;WaitRetrace;WaitRetrace;}
    Dec(Timer);
    PutTimer;
    If Timer=0Then Begin;Accident:=2;Break;End;
   Until KeyPress;
   If Accident>0Then Break;
   Case(ReadKey)of
    kbLeft:If FroggerX>0Then Begin
     UnputFrogger(FroggerX,FroggerY);
     Dec(FroggerX,12);
     PutFrogger(FroggerX,FroggerY);
    End;
    kbRight:If FroggerX<239-24Then Begin
     UnputFrogger(FroggerX,FroggerY);
     Inc(FroggerX,12);
     PutFrogger(FroggerX,FroggerY);
    End;
    kbUp:If FroggerY>47Then Begin
     UnputFrogger(FroggerX,FroggerY);
     Dec(FroggerY,12);
     PutFrogger(FroggerX,FroggerY);
    End;
    kbDn:If FroggerY<180Then Begin
     UnputFrogger(FroggerX,FroggerY);
     Inc(FroggerY,12);
     PutFrogger(FroggerX,FroggerY);
    End;
    kbEsc:Exit;
   End;
  Until No;
  ClrKbd;
  Case(Accident)of
   1:PutTxtXY(0,0,'cras‚ par une voiture!',LightRed+(Green shl 4));
   2:PutTxtXY(0,0,'Manque de temps!',LightRed+(Green shl 4));
  End;
  ReadKey;
  Dec(Life);
 Until Life=0;
END.