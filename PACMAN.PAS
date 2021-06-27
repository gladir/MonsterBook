Unit PacMan;

INTERFACE

Const
 MaxX=15;
 MaxY=16;

Type TabPacManRec=Array[0..MaxY,0..MaxX+1]of Byte;
PacManRec=Record
 GX:Array[0..5]of Byte; { Position horizontal des fant“mes }
 GY:Array[0..5]of Byte; { Position vertical des fant“mes }
 GD:Array[0..5]of Byte; { Direction des fant“mes }
 LH:Array[0..5]of Byte; { DerniŠre direction horizontal }
 LV:Array[0..5]of Byte; { DerniŠre direction vertical }
 CG:Byte;               { Num‚ro du fant“me courant }
 GXit:Byte;             { Nombre de fant“me sortie }
 Cycles:Word;           { Nombre de cycles depuis l'apparition du Pac-Man }
End;

Const TabBig001:TabPacManRec=(
(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1),
(1,2,2,2,2,2,2,2,2,2,2,2,2,2,2,1,1),
(1,7,1,2,1,2,1,1,1,1,2,1,2,1,7,1,1),
(1,2,2,2,1,2,2,2,2,2,2,1,2,2,2,1,1),
(1,1,2,1,1,2,1,1,1,1,2,1,1,2,1,1,1),
(1,2,2,2,2,2,2,2,2,2,2,2,2,2,2,1,1),
(1,2,1,2,1,2,1,1,1,1,2,1,2,1,2,1,1),
(1,2,2,2,1,2,1,0,0,1,2,1,2,2,2,1,1),
(1,1,2,1,1,2,1,1,1,1,2,1,1,2,1,1,1),
(1,2,2,2,2,2,2,2,2,2,2,2,2,2,2,1,1),
(1,2,1,2,1,2,1,1,1,1,2,1,2,1,2,1,1),
(1,2,2,2,1,2,2,2,2,2,2,1,2,2,2,1,1),
(1,1,2,1,1,2,1,1,1,1,2,1,1,2,1,1,1),
(1,2,2,2,2,2,2,2,2,2,2,2,2,2,2,1,1),
(1,7,1,2,1,2,1,1,1,1,2,1,2,1,7,1,1),
(1,2,2,2,1,2,2,0,2,2,2,1,2,2,2,1,1),
(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1));

Procedure InitPacMan(Var Q:PacManRec);
Procedure PlayPacMan(Var Q:PacManRec);

IMPLEMENTATION

Uses Adele,Systex,Systems,Video;

Const
 drRight=1;       { Droite }
 drLeft=2;        { Gauche }
 drUp=3;          { Haut }
 drDown=4;        { Bas }
 drNoDirection=5; { Aucune direction }

 OkPlaces:Set of Byte=[0,2,7];

 Buffer:^TabPacManRec=@TabBig001;

Procedure PMPut(X,Y,Item:Byte);Begin
 Case(Item)of
  0:SetCube(X,Y,' ',$F);
  1:SetCube(X,Y,'²',$91);
  2:SetCube(X,Y,'ú',7);
  7:SetCube(X,Y,'þ',$F);
  9:SetCube(X,Y,'F',$C);
 End;
End;

Function PMCanMove(X,Y,Direction:Byte):Boolean;Begin
 Case(Direction)Of
  drRight:PMCanMove:={(X=MaxX)or}(Buffer^[Y,X+1]in OKPlaces);
  drLeft:PMCanMove:={(X=0)or}(Buffer^[Y,X-1]in OKPlaces);
  drUp:PMCanMove:={(Y=0)or}(Buffer^[Y-1,X]in OKPlaces);
  drDown:PMCanMove:={(Y=MaxY)or}(Buffer^[Y+1,X]in OKPlaces);
  drNoDirection:PMCanMove:=Ya;
  Else PMCanMove:=No;
 End;
End;

Procedure PMSetPos(Direction:Byte;Var X,Y:Byte);Begin
 Case(Direction)of
  drRight:Inc(X);
  drLeft:Dec(X);
  drUp:Dec(Y);
  drDown:Inc(Y);
 End;
End;

Procedure PMMoveArround(Var Q:PacManRec;X,Y:Byte);Label ReCalc;
Const DirTable:Array[0..3]of Byte=(drDown,drUp,drRight,drLeft);
Var TX,TY,LD,IC:Byte;
Begin
 LD:=Q.GD[Q.CG];IC:=0;
 While Not PMCanMove(X,Y,Q.GD[Q.CG])do Begin
ReCalc:
  Q.GD[Q.CG]:=DirTable[Random(4)];
  Inc(IC);
  If IC<7Then Begin
   If(Q.GD[Q.CG]=Q.LH[Q.CG])or(Q.GD[Q.CG]=Q.LV[Q.CG])Then Goto Recalc;
  End;
 End;
 If Random(260)<300Then
  While Not PMCanMove(X,Y,Q.GD[Q.CG])do Q.GD[Q.CG]:=DirTable[Random(4)];
 Case Q.GD[Q.CG]of
  drUp,drDown:
   If PMCanMove(X,Y,drLeft)and(Random(500)<15)Then Q.GD[Q.CG]:=drLeft Else
   If PMCanMove(X,Y,drRight)and(Random(500)<15)Then Q.GD[Q.CG]:=drRight;
  drLeft,drRight:
   If PMCanMove(X,Y,drUp)and(Random(500)<15)Then Q.GD[Q.CG]:=drUp Else
   If PMCanMove(X,Y,drDown)and(Random(500)<15)Then Q.GD[Q.CG]:=drDown;
 End;
 Case Q.GD[Q.CG]of
  drUp,drDown:Q.LV[Q.CG]:=Q.GD[Q.CG];
  drLeft,drRight:Q.LH[Q.CG]:=Q.GD[Q.CG];
 End;
End;

Procedure InitPacMan;Var I,J:Byte;Begin
 FillClr(Q,SizeOf(PacManRec));
 For I:=0to 5do Begin
  Q.GX[I]:=8;Q.GY[I]:=6;
  Q.GD[I]:=drUp;
 End;
 For J:=0to(MaxY)do For I:=0to(MaxX)do PMPut(I,J,Buffer^[J,I]);
End;

Procedure PlayPacMan;Var I:Byte;Begin
 Repeat
  If Q.Cycles and$1F=$1FThen Begin
   If Q.GXit<3Then Inc(Q.GXit);
  End;
  For I:=0to(Q.GXit)do Begin
   PMPut(Q.GX[I],Q.GY[I],9);
  End;
  WaitRetrace;WaitRetrace;WaitRetrace;
  WaitRetrace;WaitRetrace;WaitRetrace;
  WaitRetrace;WaitRetrace;WaitRetrace;
  WaitRetrace;WaitRetrace;WaitRetrace;
  For I:=0to(Q.GXit)do Begin
   Q.CG:=I;
   PMPut(Q.GX[I],Q.GY[I],Buffer^[Q.GY[I],Q.GX[I]]);
   PMMoveArround(Q,Q.GX[I],Q.GY[I]);
   PMSetPos(Q.GD[I],Q.GX[I],Q.GY[I]);
  End;
  Inc(Q.Cycles);
 Until KeyPress;
End;

END.