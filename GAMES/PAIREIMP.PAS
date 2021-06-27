Uses Adele,Systex,Systems,Video,Goldnaxe;

Var Img:Array[0..5]of Pointer;Const PalCGA:Array[0..3]of Byte=(0,$E,$C,$F);

Procedure TurboAfficheCase(Y1,Y2:Byte;Var x0);Var H,I,J:Byte;TBuf:TByte Absolute x0;Begin
 For H:=Y1 to Y2 do For I:=0to 79do For J:=0to 3do
  Mem[$A000:H*320+I*4+3-J]:=PalCGA[(TBuf[H*80+I]shr(J*2))and 3];
End;

Procedure TurboAfficheCase2(Var x0);Var H,I,J:Byte;TBuf:TByte Absolute x0;Begin
 For H:=0to 183do For I:=0to 55do For J:=0to 3do
  Mem[$A000:H*320+I*4+3-J]:=PalCGA[(TBuf[H*80+I]shr(J*2))and 3];
End;

Var TJ:Array[0..1,0..15]of Int;CJ:Array[0..1,0..48]of Int;
    D:Array[0..4]of Int;P:Array[0..1,0..6]of Int;
    G:Array[0..10]of Int;E:Array[0..1]of Int;
    Chaine:Array[0..1]of String;Z:Array[0..7]of Int;
    Handle:Hdl;I:Array[0..3]of Int;VA:Array[0..2]of Int;
    V,M,CO,NM,B,ZZ,HH,OK,O1,B1,W,A:Long;
    XP,YP,L,TypeCase,I2:Byte;

Procedure PaireImpaire;Label 270,420,590,600,630,640;

 Procedure SP870;Var T,VA,VB:Long;L:Byte;M:Long;Begin
  VA:=0;VB:=1;V:=1;G[1]:=W;
  Repeat
   For L:=VA+1to VB do For M:=1to 4do Begin
    T:=G[L]+D[M];
    If((CJ[0,T]<>0)and(CJ[1,T]=0))Then Begin Inc(V);G[V]:=T;CJ[1,T]:=HH;End;
   End;
   VA:=VB;VB:=V;
  Until V=VB;
 End;

 Procedure AfficheCase(X,Y,C:Byte);Begin
  If(C=0)and((X+Y*5)and 1=0)Then C:=3;
  PutFillCircle(230+16*X+8,50+16*Y+8,6,C);
 End;

Begin { Main Paire-Impaire }
 For I2:=0to 5do GetMem(Img[I2],16000);
 FillClr(TJ,SizeOf(TJ));FillClr(CJ,SizeOf(CJ));FillClr(G,SizeOf(G));FillClr(E,SizeOf(E));
 For I[0]:=0to 1do Begin CJ[0,8+I[0]]:=1;CJ[0,11+I[0]]:=1;CJ[0,36+I[0]]:=1;CJ[0,39+I[0]]:=1;End;
 For I[0]:=0to 4do CJ[0,22+I[0]]:=1;
 D[1]:=-7;D[2]:=1;D[3]:=7;D[4]:=-1;
 P[0,1]:=15;P[1,1]:=10;P[0,2]:=17;P[1,2]:=16;P[0,3]:=19;P[1,3]:=18;
 P[0,4]:=29;P[1,4]:=30;P[0,5]:=31;P[1,5]:=32;P[0,6]:=33;P[1,6]:=38;
 Z[0]:=1;Z[1]:=3;Z[2]:=4;Z[3]:=6;Z[4]:=7;Z[5]:=7;Z[6]:=-7;Z[7]:=-7;
 SetVideoMode(vmGrf320x200c256);
 GetFile('Resource.001',3,16000,Img[0]^);
 Handle:=FileOpen('Resource.002',fmRead);
 For I[0]:=0to 4do GetRec(Handle,I[0],16000,Img[I[0]+1]^);
 FileClose(Handle);
 TurboAfficheCase(0,199,Img[0]^);
 PutTxtXY(30,2,'Paire -',$B);
 PutTxtXY(32,4,'Impaire',$9);
 TypeCase:=0;
 For XP:=0to 4do Begin
  For YP:=0to 4do Begin
   If TypeCase=0Then Begin
    PutFillBox(230+XP*16,50+YP*16,230+XP*16+15,50+YP*16+15,3);
    PutRect(230+XP*16,50+YP*16,230+XP*16+15,50+YP*16+15,1);
   End
    else
   PutFillBox(230+XP*16,50+YP*16,230+XP*16+15,50+YP*16+15,0);
   TypeCase:=(TypeCase+1)and 1;
  End;
 End;
 AfficheCase(2,0,1); AfficheCase(0,1,2); AfficheCase(1,1,1); AfficheCase(2,1,2);
 AfficheCase(3,1,1); AfficheCase(4,1,2); AfficheCase(0,3,2); AfficheCase(1,3,1);
 AfficheCase(2,3,2); AfficheCase(3,3,1); AfficheCase(4,3,2); AfficheCase(2,4,1);
 For I2:=0to 4do SetChr(29+I2 shl 1,17,Chr(65+I2));
  { Qui comence ... }
{ If Random(1)<>1Then Begin
  For I[0]:=1to 6do Begin I[1]:=P[1,I[0]];P[1,I[0]]:=P[0,I[0]];P[0,I[0]]:=I[1];End;
  CO:=1;
  Goto 690
 End
  else}
 Begin
  I[2]:=Random(4);I[0]:=Z[I[2]];I[1]:=Z[I[2]+4];NM:=1;Goto 640
 End;
270:
 NM:=100;ZZ:=0;
 For I[0]:=1to 6do Begin
  For I[1]:=1to 4do Begin
   B:=P[0,I[0]]+D[I[1]];
   If CJ[0,B]=0Then Goto 600;
   CJ[0,B]:=0;CJ[0,P[0,I[0]]]:=1;HH:=0;OK:=0;
   FillClr(CJ[1,8],66);
   For I[2]:=1to 4do Begin
    If Not((OK=1)and((CJ[0,B+D[I[2]]]=0)or(CJ[1,B+D[I[2]]]>0)))Then Begin
     W:=B+D[I[2]];Inc(HH);
     SP870;
     If Not((V<>CO+2)and(V<>CO+4))Then OK:=1;
    End;
   End;
   If OK=0Then Goto 590;
   For L:=0to 1do VA[L*2]:=0;
   Repeat
    Inc(VA[0]);VA[1]:=0;
    If VA[0]=7Then Begin
     If NM>VA[2]Then Begin
      NM:=VA[2];ZZ:=1;
      For L:=0to 1do TJ[L,1]:=I[L];
     End
      else
     Begin
      Inc(ZZ);
      For L:=0to 1do TJ[L,ZZ]:=I[L];
     End;
590: CJ[0,B]:=1;CJ[0,P[0,I[0]]]:=0;
600:End;
    IF ZZ=0Then Begin PutTxtXY(0,0,'Vous avez gagne!',$F0);Exit;End;
    A:=1+Random(ZZ);I[0]:=TJ[0,A];I[1]:=D[TJ[1,A]];
640:E[0]:=P[0,I[0]];E[1]:=E[0]+I[1];
    For L:=0to 1do Begin
     Chaine[L]:=Chr(E[L]-7*(E[L]div 7)+64)+Chr(E[L]div 7+48);
     AfficheCase(Byte(Chaine[L,1])-65,Byte(Chaine[L,2])-49,L*2);
    End;
    PutTxtXY(25,21,'Je joue: '+Chaine[0]+'-'+Chaine[1],7);
    If NM=0Then Begin PutTxtXY(0,0,'J''ai gagne!',$F0);Exit;End;
    CJ[0,P[0,I[0]]]:=1;Inc(P[0,I[0]],I[1]);CJ[0,P[0,I[0]]]:=0;
630:PutTxtXY(1,23,'Votre coup (Ex. A1-B1) ?',7);
    TurboAfficheCase2(Img[2]^);
    For I2:=0to 4do WaitRetrace;
    TurboAfficheCase2(Img[1]^);
    For I2:=0to 4do WaitRetrace;
    TurboAfficheCase2(Img[0]^);
    For I2:=0to 4do WaitRetrace;
    TurboAfficheCase2(Img[1]^);
    For I2:=0to 4do WaitRetrace;
    TurboAfficheCase2(Img[0]^);
    SetCurPos(26,23);
    ReadLn(Chaine[0]);
    If Chaine[0]=''Then Exit;
    PutTxtXY(30,23,'-',7);
    SetCurPos(32,23);
    ReadLn(Chaine[1]);
    For L:=0to 1do I[L]:=Byte(Chaine[L,1])-64+7*Byte(Chaine[L,2])-48;
    For L:=0to 1do CJ[0,I[L]]:=1-L;
    HH:=0;O1:=0;B1:=I[1];
    FillClr(CJ[1,8],66);
    For I[3]:=1to 4do Begin
     If Not((O1=1)and((CJ[0,B1+D[I[3]]]=0)or(CJ[1,B1+D[I[3]]]>0)))Then Begin
      W:=B1+D[I[3]];Inc(HH);
      SP870;
      If Not(V>1)Then Dec(V);
      If(V=3-CO)and(V=5-CO)Then O1:=1;
     End;
    End;
    If O1=1Then Begin
     For L:=0to 1do AfficheCase(Byte(Chaine[L,1])-65,Byte(Chaine[L,2])-49,L);
     For I[2]:=1to 6do If P[1,I[2]]=I[0]Then P[1,I[2]]:=I[1];
     Goto 270;
    End;
    For L:=0to 1do CJ[0,I[L]]:=L;
    PutTxtXY(2,23,'Vous ne pouvez pas jouer ce coup.',7);
    Goto 630;
420:Inc(VA[1]);
   Until VA[1]<>5;
   B1:=P[1,VA[0]]+D[VA[1]];
   If CJ[0,B1]=0Then Goto 420;
   CJ[0,B1]:=0;CJ[0,P[1,VA[0]]]:=1;HH:=0;O1:=0;
   FillClr(CJ[1,8],66);
   For I[3]:=1to 4do Begin
    If Not((O1=1)and((CJ[0,B1+D[I[3]]]=0)or(CJ[1,B1+D[I[3]]]>0)))Then Begin
     W:=B1+D[I[3]];Inc(HH);
     SP870;
     If Not(V>1)Then Dec(V);
     If(V=3-CO)and(V=5-CO)Then O1:=1;
    End;
   End;
   CJ[0,B1]:=1;CJ[0,P[0,VA[0]]]:=0;
   If O1=0Then Goto 420;
   Inc(VA[2]);
   If(VA[2]>NM)Then Goto 590 Else Goto 420;
  End;
 End;
End;

Begin
 InitSystems(suIsabel);
 PaireImpaire;
 DoneSystems;
End.