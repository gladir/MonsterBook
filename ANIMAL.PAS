{⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ‹
 ≥                                                              €
 ≥                A   N    M    I    N    A    L                €
 ≥                                                              €
 ≥                             pour                             €
 ≥                                                              €
 ≥      L'ensemble Malte Genesis III & IV: Isabel & Chantal     €
 ≥ Tous droits rÇservÇs par les Chevaliers de Malte 1995 Ö 1999 €
 ≥                                                              €
 ¿‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹€



 Noms des programmeurs
 ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕ

  Pierre BÇlanger
  Sylvain Maltais
}

{$M 32768,0,655360}
{$I DEF.INC}
Uses Math,Adele,Video,Systex,Systems,Isatex,Mouse,Dials,Dialex,DialPlus,Apps;

Const
 amNew=$F001;
 amOpen=$F002;
 amSave=$F003;
 amSaveAs=$F004;
 amRun=$F005;
 amOutput=$F006;
 amPreviousWn=$F007;
 amNextWn=$F008;
 amAbout=$F009;
 amExit=$F00A;
Mode:Byte=0;

Var
 x,y:Array[0..NmPntMxObj]of Integer;
 Output:ImgRec;

Procedure QuickSort(Var A:Array of Integer;L,R:Integer);
Var
 I,J,X:Integer;
Begin
 I:=L;J:=R;
 X:=A[(L+R)shr 1];
 While(I<J)do Begin
  While(A[I]<X)do Inc(I);
  While X<A[J]do Inc(J);
  If(I<=J)Then Begin
   SwapInt(A[I],A[J]);
   Inc(I);
   Dec(J)
  End;
 End;
 If(L<J)Then QuickSort(A,L,J);
 If(I<R)Then QuickSort(A,I,R);
End;

Procedure PutFillBoxAnimal(Var Q:Anim3D;X1,Y1,X2,Y2,Color:Word);
Var
 Base:LongInt;
 Len,RealLen:Word;
 J:Word;
 Line:Array[0..1280]of Byte;
Begin
 If(X1>X2)Then ASM
  MOV AX,X1
  XCHG AX,X2
  MOV X1,AX
 END;
 If(Y1>Y2)Then ASM
  MOV AX,Y1
  XCHG AX,Y2
  MOV Y1,AX
 END;
 If BitsPerPixel<8Then PutFillBox(X1,Y1,X2,Y2,Color)
  Else
 Begin
  Base:={GetRealRawY(Y1)}Mul2Word(Y1,BytesPerLine)+LongInt(X1);
  Len:=X2-X1;RealLen:=Len;
  If BitsPerPixel>16Then Begin
   Inc(Base,LongInt(X1));
  End;
  If BitsPerPixel>8Then Begin
   Inc(Base,LongInt(X1));
   ASM SHL RealLen,1;END;
  End;
  If RealLen>SizeOf(Line)Then Exit;
  If BitsPerPixel=8Then FillChr(Line,Len,Color)
                   Else FillWord(Line,Len,Color);
  For J:=Y1 to(Y2)do Begin
   XSetAbsRec(Q.VirtualScreen,Base,RealLen,Line);
   Inc(Base,LongInt(GetBytesPerLine));
  End;
 End;
End;

Procedure ClrScrAnimal(Var Q:Anim3D;Attr:Byte);
Var
 Color:Word;
 Attribut:Byte;
Begin
 If BitsPerPixel<8Then ClrScr(Attr)
  Else
 Begin
  Attribut:=Attr shr 4;
  Color:=RGB2Color(DefaultRGB[Attribut].R,DefaultRGB[Attribut].G,DefaultRGB[Attribut].B);
  PutFillBoxAnimal(Q,0,0,GetMaxXPixels,GetMaxYPixels,Color);
 End;
End;

Procedure PutLnHorAnimal(Var Q:Anim3D;X1,Y,X2,Color:Word);Begin
 PutFillBoxAnimal(Q,X1,Y,X2,Y,Color);
End;

Procedure SetPixelAnimal(Var Q:Anim3D;X,Y,Color:Word);
Var
 Base:LongInt;
 Len:Word;
Begin
 If BitsPerPixel<8Then SetPixel(X,Y,Color)
  Else
 Begin
  Base:={GetRealRawY(Y)}Mul2Word(Y,BytesPerLine)+LongInt(X);
  Len:=1;
  If BitsPerPixel>16Then Begin
   Inc(Base,LongInt(X));
   Inc(Len);
  End;
  If BitsPerPixel>8Then Begin
   Inc(Base,LongInt(X));
   Inc(Len);
  End;
  XSetAbsRec(Q.VirtualScreen,Base,Len,Color);
 End;
End;

Procedure PutLineAnimal(Var Q:Anim3D;X1,Y1,X2,Y2,Color:Word);
Var
 D,DX,DY,I,J,Ainc,Binc,Ic:Integer;
Begin
 If BitsPerPixel<8Then PutLine(X1,Y1,X2,Y2,Color)
  Else
 Begin
  If(Y2=Y1)Then Begin
   PutLnHorAnimal(Q,X1,Y1,X2,Color);
   Exit;
  End;
  If AbsInt(X2-X1)<AbsInt(Y2-Y1)Then Begin
   If(Y1>Y2)Then ASM
    MOV AX,X1
    XCHG AX,X2
    MOV X1,AX
    MOV AX,Y1
    XCHG AX,Y2
    MOV Y1,AX
   END;
   If(X2>X1)Then Ic:=1 Else Ic:=-1;
   DY:=Y2-Y1;DX:=AbsInt(X2-X1);D:=(DX shl 1)-DY;
   Ainc:=(DX-DY)shl 1;Binc:=DX shl 1;J:=X1;
   SetPixel(X1,Y1,Color);
   I:=Y1+1;
   While(I<=Y2)do Begin
    If D>=0Then Begin
     Inc(J,Ic);
     Inc(D,Ainc)
    End
     Else
    Inc(D,Binc);
    SetPixel(J,I,Color);
    Inc(I);
   End;
  End
   else
  Begin
   If(X1>X2)Then ASM
    MOV AX,X1
    XCHG AX,X2
    MOV X1,AX
    MOV AX,Y1
    XCHG AX,Y2
    MOV Y1,AX
   END;
   If(Y2>Y1)Then Ic:=1
            Else Ic:=-1;
   DX:=X2-X1;DY:=AbsInt(Y2-Y1);D:=(DY shl 1)-DX;
   AInc:=(DY-DX)shl 1;BInc:=DY shl 1;J:=Y1;
   SetPixel(X1,Y1,Color);
   I:=X1+1;
   While(I<=X2)do Begin
    If D>=0Then Begin
     Inc(J,Ic);
     Inc(D,Ainc)
    End
     Else
    Inc(D,Binc);
    SetPixel(I,J,Color);
    Inc(I);
   End;
  End;
 End;
End;

Procedure PCopy2ImgAnimal(Var Q:Anim3D;Page,X1,Y1,X2,Y2:Word);
Var
 Base:LongInt;
 Len,RealLen:Word;
 J:Word;
 Line:Array[0..1280]of Byte;
Begin
 If(X1>X2)Then ASM
  MOV AX,X1
  XCHG AX,X2
  MOV X1,AX
 END;
 If(Y1>Y2)Then ASM
  MOV AX,Y1
  XCHG AX,Y2
  MOV Y1,AX
 END;
 If BitsPerPixel<8Then PCopy2Img(Page,X1,Y1,X2,Y2)
  Else
 Begin
  Base:={GetRealRawY(Y1)}Mul2Word(Y1,BytesPerLine)+LongInt(X1);
  Len:=X2-X1;RealLen:=Len;
  If BitsPerPixel>16Then Begin
   Inc(Base,LongInt(X1));
  End;
  If BitsPerPixel>8Then Begin
   Inc(Base,LongInt(X1));
   ASM SHL RealLen,1;END;
  End;
  If RealLen>SizeOf(Line)Then Exit;
  For J:=Y1 to(Y2)do Begin
   XGetAbsRec(Q.VirtualScreen,Base,RealLen,Line);
   Inc(Base,LongInt(GetBytesPerLine));
   ClrLnHorImg(X1,J,Len,BitsPerPixel,Line);
  End;
 End;
End;

Procedure DrawPoly(Var Q:Anim3D;Var x0:TObjet;N:Integer;Kr:Byte);Var I:Integer;Begin
 For i:=0to x0.face[N].nbPixs-1do
  PutLineAnimal(Q,x[x0.face[N].Pix[i]],y[x0.face[N].Pix[i]],
                  x[x0.face[N].Pix[i+1]],y[x0.face[N].Pix[i+1]],Kr);
End;

Procedure FillPoly(Var Q:Anim3D;Var x0:TObjet;nf:Integer;Kr:Byte);
Var
 n,i,j,yMin,yMax,PixMin,PixMax,DPixs,k,Chk:Integer;
 xg,xd:Array[0..200]of Integer;
 Dx,Dy,signe,Nx,Ny:Array[0..NmPntMxFace]of Integer;
Begin
 yMax:=-1;yMin:=y[x0.face[nf].Pix[0]];PixMin:=0;
 For n:=0to x0.face[nf].nbPixs-1do Begin
  If(y[x0.face[nf].Pix[n]]<yMin)Then Begin
   yMin:=y[x0.face[nf].Pix[n]];
   PixMin:=n;
  End
   Else
  If(y[x0.face[nf].Pix[n]]>yMax)Then Begin
   yMax:=y[x0.face[nf].Pix[n]];
   PixMax:=n;
  End;
 End;
 i:=0;
 For n:=PixMin to x0.face[nf].nbPixs-1do Begin
  Nx[i]:=x[x0.face[nf].Pix[n]];
  Ny[i]:=y[x0.face[nf].Pix[n]];Inc(i)
 ENd;
 Nx[x0.face[nf].nbPixs]:=x[x0.face[nf].Pix[PixMin]];
 Ny[x0.face[nf].nbPixs]:=y[x0.face[nf].Pix[PixMin]];
 For n:=0to PixMin-1do Begin
  Nx[i]:=x[x0.face[nf].Pix[n]];
  Ny[i]:=y[x0.face[nf].Pix[n]];Inc(i)
 End;
 If(PixMax>PixMin)Then DPixs:=PixMax-PixMin
                  Else DPixs:=x0.face[nf].nbPixs-PixMin+PixMax;
 For i:=0to x0.face[nf].nbPixs-1do Begin
  Dx[i]:=Nx[i+1]-Nx[i];Dy[i]:=Ny[i+1]-Ny[i];
  if Dx[i]<0Then signe[i]:=-1 Else signe[i]:=1;
  if Dy[i]<0Then Dy[i]:=-Dy[i];
  if Dx[i]<0Then Dx[i]:=-Dx[i];
 End;
 j:=0;
 For n:=0to DPixs-1do if Dy[n]<Dx[n]Then Begin
  Chk:=Dx[n]-Dy[n];i:=Ny[n];k:=Nx[n];
  While i<>Ny[n+1]do Begin
   While Chk>0do Begin
    Dec(Chk,Dy[n]);
    Inc(k,signe[n])
   End;
   Inc(Chk,Dx[n]);xd[j]:=k;Inc(i);Inc(j)
  End;
 End
  else
 Begin
  Chk:=Dy[n]-Dx[n];i:=Ny[n];k:=Nx[n];
  While i<>Ny[n+1]do Begin
   If Chk<0Then Begin
    Inc(Chk,Dy[n]);
    Inc(k,signe[n])
   End;
   Dec(Chk,Dx[n]);xd[j]:=k;Inc(i);Inc(j)
  End;
 End;
 j:=0;
 For n:=x0.face[nf].nbPixs downto DPixs+1do If Dy[n-1]<Dx[n-1]Then Begin
  Chk:=Dx[n-1]-Dy[n-1];i:=Ny[n];k:=Nx[n];
  While i<>Ny[n-1]do Begin
   While Chk>0do Begin
    Dec(Chk,Dy[n-1]);
    Dec(k,signe[n-1])
   End;
   Inc(Chk,Dx[n-1]);xg[j]:=k;Inc(i);Inc(j)
  End;
 End
  else
 Begin
  Chk:=Dy[n-1]-Dx[n-1];i:=Ny[n];k:=Nx[n];
  While i<>Ny[n-1]do Begin
   If Chk<0Then Begin
    Inc(Chk,Dy[n-1]);
    Dec(k,signe[n-1])
   End;
   Dec(Chk,Dx[n-1]);xg[j]:=k;Inc(i);Inc(j)
  End;
 End;
 If xg[5]<xd[5]Then Begin
  I:=0;
  For N:=yMin to yMax-1do Begin
   PutLnHorAnimal(Q,xg[I],N,xd[I],Kr);
   Inc(I)
  End;
 End;
End;

Procedure InitSinCos(Var Q:Anim3D);
Var
 N:Integer;
Begin
 For N:=0to 359do Begin
  Q.TCos[N]:=Trunc(Cos(N*3.141592654/180)*Delta);
  Q.TSin[N]:=Trunc(Sin(N*3.141592654/180)*Delta);
 End;
End;

Procedure A3Refresh(Var Q);Begin
 WEPutWnKrDials(Anim3D(Q).W,'Animation 3D');
End;

Function A3Init(Var Context;X1,Y1,X2,Y2:Byte):Boolean;
Var
 Q:Anim3D Absolute Context;
Begin
 A3Init:=No;
 FillClr(Q,SizeOf(Anim3D));
 If BitsPerPixel>=8Then XAllocMem(rmAllRes,Mul2Word(BytesPerLine,GetNumYPixels),Q.VirtualScreen);
 InitSinCos(Q);
 Q.Speed:=1;
 Q.X1:=(X1+1)shl 3;
 Q.Y1:=(Y1+1)*HeightChr;
 Q.X2:=(X2 shl 3)-1;
 Q.Y2:=Y2*HeightChr-1;
 Q.XC:=(Q.X2-Q.X1+1)shr 1;
 Q.YC:=(Q.Y2-Q.Y1+1)shr 1;
 WEInit(Q.W,X1,Y1,X2,Y2);
 A3Refresh(Q);
 A3Init:=Ya;
End;

Procedure A3Open(Var Context;X1,Y1,X2,Y2:Byte;Const Name:String);
Var
 f:Text;
 i,n:Integer;
 Q:Anim3D Absolute Context;
Begin
 A3Init(Q,X1,Y1,X2,Y2);
 If Q.CurObj>7Then Exit;
 Assign(f,Name);
 Reset(f);
 ReadLn(f,Q.Objet[Q.CurObj].NbPixs);
 ReadLn(f,Q.Objet[Q.CurObj].NbFaces);
 Dec(Q.Objet[Q.CurObj].NbFaces);
 ReadLn(f);
 For n:=0to Q.Objet[Q.CurObj].nbPixs-1do
  ReadLn(f,Q.Objet[Q.CurObj].x3d[n],
           Q.Objet[Q.CurObj].y3d[n],
           Q.Objet[Q.CurObj].z3d[n]);
 ReadLn(f);
 For N:=0to(Q.Objet[Q.CurObj].NbFaces)do Begin
  Q.Objet[Q.CurObj].Face[n].Kr:=Random(15);
  If Q.Objet[Q.CurObj].Face[n].Kr=9Then
   Q.Objet[Q.CurObj].Face[n].Kr:=0;
  Read(f,Q.Objet[Q.CurObj].face[n].nbPixs);
  For i:=0to Q.Objet[Q.CurObj].Face[n].nbPixs-1do Begin
   Read(F,Q.Objet[Q.CurObj].face[n].Pix[i]);
   Dec(Q.Objet[Q.CurObj].face[n].Pix[i]);
  End;
  Q.Objet[Q.CurObj].face[n].Pix[i+1]:=Q.Objet[Q.CurObj].face[n].Pix[0];
  ReadLn(f);
 End;
 System.Close(f);
 Inc(Q.CurObj);
End;

Function A3Run(Var Context):Word;
Const
 i:Integer=0;
 SensX=1;
 SensY=1;
 SensZ=1;
Var
 N,t:Integer;
 ZR,YR,XR:LongInt;
 K:Word;
 Box:Array[0..8191]of Byte;
 Q:Anim3D Absolute Context;
Begin
 If BitsPerPixel<8Then CopyBoxTxt(0,0,MaxXTxts,MaxYTxts,Box);
 Repeat
  If BitsPerPixel<8Then SetPg(1);
  ClrScrAnimal(Q,$90);
  For K:=0to Q.CurObj-1do {If Obj[K]Then} Begin
   If(I<359-Q.Speed)Then Inc(I,Q.Speed)else I:=0;
   For N:=0to Q.Objet[K].nbPixs-1do Begin
    t:=Q.Objet[K].y3d[N];
    YR:=((T*LongInt(Q.TCos[I]))-(SensX*Q.Objet[K].z3d[N]*Long(Q.TSin[I])))div Delta;
    ZR:=((SensX*T*LongInt(Q.TSin[I]))+(Q.Objet[K].z3d[N]*Long(Q.TCos[I])))div Delta;
    t:=Q.Objet[K].x3d[N];
    XR:=((T*LongInt(Q.TCos[I]))-(SensY*ZR*LongInt(Q.TSin[I])))div Delta;
    ZR:=((SensX*T*Long(Q.TSin[i]))+(ZR*Long(Q.TCos[I])))div Delta;
    t:=XR;
    XR:=((T*LongInt(Q.TCos[I]))-(SensZ*YR*Long(Q.TSin[i])))div Delta;
    YR:=((SensZ*T*Long(Q.TSin[i]))+(YR*Long(Q.TCos[i])))div Delta;
    x[n]:=(PROFONDEUR*XR)div(DISTANCE+ZR)+Q.XC;
    y[n]:=(PROFONDEUR*YR)div(DISTANCE+ZR)+Q.YC;
   End;
   If(Q.FilDeFer)Then
    For N:=0to(Q.Objet[K].nbfaces)do DrawPoly(Q,Q.Objet[K],n,Q.Objet[K].face[n].Kr)
   Else
    For N:=0to(Q.Objet[K].nbfaces)do FillPoly(Q,Q.Objet[K],n,Q.Objet[K].face[n].Kr);
  End;
  If(KeyPress)Then Begin
   K:=ReadKey;
   Case(K)of
    kbF1:Q.FilDeFer:=Not(Q.FilDeFer);
{    kbF2:Begin
     Mode:=(Mode+1)and 1;
     ClrScr(0);
     SetChrWidth(Mode)
    End;}
    kbF3:If Q.Speed<31Then Inc(Q.Speed);
    kbF4:If Q.Speed>1Then Dec(Q.Speed);
{    kbF5:ASM XOR Byte Ptr Obj[0],1;END;
    kbF6:ASM XOR Byte Ptr Obj[1],1;END;
    kbF7:ASM XOR Byte Ptr Obj[2],1;END;
    kbF8:ASM XOR Byte Ptr Obj[3],1;END;
    kbF9:ASM XOR Byte Ptr Obj[4],1;END;
    kbF10:ASM XOR Byte Ptr Obj[5],1;END;}
    Else Break;
   End;
  End;
  WaitRetrace;
  If BitsPerPixel<8Then SetPg(0);
  PCopy2ImgAnimal(Q,1,Q.X1,Q.Y1,Q.X2,Q.Y2);
 Until No;
 If BitsPerPixel<8Then Begin
  SetPg(0);
  PutBoxTxt(0,0,MaxXTxts,MaxYTxts,Box);
 End;
 A3Run:=K;
End;

Function A3Done(Var Context):Word;
Var
 Q:Anim3D Absolute Context;
Begin
 If BitsPerPixel>=8Then XFreeMem(Q.VirtualScreen);
 A3Done:=0;
End;

Procedure MakeMnu;Begin
 PMInit;
 PMSetWinBar(0,1,MaxXTxts);
 PMAddMnu('^F^ichier');
  PMAddItemKey('^N^ouveau',kbNoKey,amNew,'CrÇe un nouveau programme BASIC');
  PMAddItemKey('^O^uvre',kbF3,amOpen,'Ouvre un programme BASIC dÇjÖ existant ou en crÇe un s''il n''existe pas encore');
  PMAddItemKey('^S^auve',kbF2,amSave,'Sauvegarde le programme sous son nom courant');
  PMAddItemKey('Sauve sous',kbNoKey,amSaveAs,'Sauvegarde le programme sous un nom particulier');
  PMAddItemKey('^Q^uitter',kbAltX,amExit,'Quitter le programme');
 PMAddMnu('^C^ommande');
  PMAddItemKey('E^x^Çcution',kbCtrlF9,amRun,'ExÇcute le programme BASIC courant');
  PMAddItemKey('^S^ortie',kbAltF5,amOutput,'Voir la sortie Çcran...');
 PMAddMnu('F^e^nàtre');
  PMAddItemKey('^S^uivante',kbF6,amNextWn,'Passe Ö la fenàtre suivante');
  PMAddItemKey('^P^rÇcÇdente',kbShiftF6,amPreviousWn,'Passe Ö la fenàtre prÇcÇdente');
 PMAddMnu('^A^ide');
  PMAddItemKey('^A^ propos',kbNoKey,amAbout,'Indique les informations concernant ce programme...');
 PMPutMnuBar;
End;

Procedure About;Var W,W2:Window;I:Byte;K:Wd;Begin
 WEInitO(W,39,12);
 WEPushWn(W);
 WEPutWnKrDials(W,'A propos!');
 WELn(W);
 WEPutOTxt(W,'AniMal');
 WELn(W);
 WEPutOTxt(W,'Version 1.0');
 WELn(W);
 WEPutOTxt(W,'Tous droits rÇservÇs (c) par');
 WELn(W);
 WEPutOTxt(W,'Les Chevaliers de Malte');
 Repeat
  K:=WEGetkHorDn(W,'Correcte|DÇtails');
  Case(K)of
   0,kbAbort:Break;
   1:Begin
    WEInitO(W2,40,20);
    WEPushWn(W2);
    WEPutWnKrDials(W2,'A propos DÇtaillÇ');
    WELn(W2);
    WEPutTxtLn(W2,'FabriquÇ au:      QuÇbec Libre!!!');
    WEPutTxtLn(W2,'êcrit en:         Borland Pascal 7');
    WEPutTxtLn(W2,'Lignes de code:   20 000 Pascal');
    WEPutTxtLn(W2,'                  10 000 Assembleur');
    WEPutTxtLn(W2,'Taille du Source: 3 MegaOctets');
    WEPutTxtLn(W2,'Bibliothäques:    Malte Genesis IV');
    WEPutTxtLn(W2,'                  Alias Chantal');
    WEPutTxtLn(W2,'      & Extension Malte Genesis V');
    WEPutTxtLn(W2,'                  Alias Adäle');
    WEPutTxtLn(W2,'Date de frabric.: FÇvrier 1998');
    WEPutTxtLn(W2,'MÇthode de fabr.: La folie!');
    WELn(W2);
    WEPutTxtLn(W2,'Programmeur/Concepteur/Analyste:');
    WELn(W2);
    WEPutTxtLn(W2,' Sylvain Maltais');
    While WEOk(W2)do;
   End;
  End;
 Until No;
 WEDone(W);
End;

Const
 wnAnim=20;

 LstHWin:Array[0..0]of HWin=(
  (SerialNumber:wnAnim;
   Init:A3Init;
   Load:A3Open;
   Run:A3Run;
   Done:A3Done;
   Refresh:A3Refresh;
   Save:NIL;
   SaveAs:NIL;
   SizeOfQ:SizeOf(Anim3D))
  );

Var K:Wd;Windows:HWins;

BEGIN
 WriteLn('AniMal  Version 1.0  Tous droits rÇservÇs par les Chevaliers de Malte');
 WriteLn;
 WriteLn(' Prototype structurel:     Bibliothäque Malte Genesis IV: Isabel - Psychotic');
 WriteLn('                           Bibliothäque Malte Genesis V: Adäle - HardCode');
 {$IFDEF H}
  WriteLn(' MÇthode d''Environnement: ÆHØ - Cubique');
 {$ENDIF}
 InitSystems(suIsabel);
 If(CPU>=cpui386)Then WriteLn(' Gestion graphiques:       80386, 32-bits d''Adäle en mode rÇel');
 PathDskSwp:=FileExpand('ANIMAL.$$$');
 InitMemManagers;
 PushScr(Output);
 DefaultMode:=vmGrf640x350c16;
 SetVideoModeDeluxe({vmGrf640x480c256}vmGrf640x480c65536{640x350c16});
 SetChrWidth(Mode);
 Randomize;
 MakeMnu;
 AppInit('AniMal',$18,MtxBleuet);
 HInit(Windows);
 HAddNewModel(Windows,LstHWin[0]);
 __InitMouse;
{ LoaderObjet(0,'samples\cube.3d');
 LoaderObjet(1,'samples\pyra1.3d');
 LoaderObjet(2,'samples\torus1.3d');
 LoaderObjet(3,'samples\pyra2.3d');
 LoaderObjet(4,'samples\arai.3d');
 LoaderObjet(5,'samples\Carre.3d');}
 Repeat
  K:=HRun(Windows);
  Case(K)of
   kbAltF3,kbClose:HClose(Windows);
   kbPrgMnuBar:PMGetMnuBar(LastMsX,LastMsY);
   kbPrgClsIcon:K:=amExit;
   kbAltX:K:=amExit;
   kbF2:K:=amSave;
   kbF3:K:=amOpen;
   kbF6:K:=amNextWn;
   kbShiftF6:K:=amPreviousWn;
   kbCtrlF9:K:=amRun;
   kbAltF5:K:=amOutput;
   Else Begin
    PushKey(K);
    K:=PMWaitForMnuAction;
   End;
  End;
  Case(K)of
   amAbout:About;
   amNextWn:HNext(Windows);
   amPreviousWn:HPrevious(Windows);
   amOpen:HLoad(Windows,wnAnim,OpenWin('*.3D','Ouvre une animation'));
  End;
 Until K=amExit;
 DoneLuxeVideo;
 PopScr(Output);
 DoneMemManagers;
END.