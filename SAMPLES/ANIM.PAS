{Noms des programmeurs
 อออออออออออออออออออออ

  Pierre Blanger
  Sylvain Maltais
}

Uses Adele,Video,Systex,Systems;

Const
 NmPntMxObj=63;
 NmFaceMxObj=63;
 NmPntMxFace=10;
 PROFONDEUR=150;
 DISTANCE=400;
 Delta=10000;
 Speed:Word=1;
 FilDeFer:Bool=No;

Type TPolyface=Record
 Pix:Array[0..NmPntMxFace]of Int;
 nbPixs,Kr:Int;
End;

TObjet=Record
 face:Array[0..NmFaceMxObj]of TPolyface;
 x3d,y3d,z3d:Array[0..NmPntMxObj]of Int;
 nbPixs,nbfaces:Int;
End;

Var
 TCos,TSin:Array[0..360]of Int;
 objet:Array[0..6]of TObjet;
 x,y:Array[0..NmPntMxObj]of Int;

Procedure QuickSort(Var A:Array of Int;l,r:Int);Var i,j,x,y:Int;Begin
 i:=l;j:=r;x:=a[(l+r)shr 1];
 While(i<j)do Begin
  While(a[i]<x)do Inc(i);
  While x<a[j]do Inc(j);
  If(i<=j)Then Begin;y:=a[i];a[i]:=a[j];a[j]:=y;Inc(i);Dec(j)End;
 End;
 if(l<j)Then QuickSort(a,l,j);
 if(i<r)Then QuickSort(a,i,r);
End;

Procedure DrawPoly(Var x0:TObjet;N:Int;Kr:Byte);Var I:Int;Begin
 For i:=0to x0.face[N].nbPixs-1do
  PutLine(x[x0.face[N].Pix[i]],y[x0.face[N].Pix[i]],x[x0.face[N].Pix[i+1]],y[x0.face[N].Pix[i+1]],Kr);
End;

Procedure FillPoly(Var x0:TObjet;nf:Int;Kr:Byte);
Var n,i,j,yMin,yMax,PixMin,PixMax,DPixs,k,Chk:Int;xg,xd:Array[0..200]of Int;
Dx,Dy,signe,Nx,Ny:Array[0..NmPntMxFace]of Int;Begin
 yMax:=-1;yMin:=y[x0.face[nf].Pix[0]];PixMin:=0;
 For n:=0to x0.face[nf].nbPixs-1do Begin
  If(y[x0.face[nf].Pix[n]]<yMin)Then Begin;yMin:=y[x0.face[nf].Pix[n]];PixMin:=n;End else
  if(y[x0.face[nf].Pix[n]]>yMax)Then Begin;yMax:=y[x0.face[nf].Pix[n]];PixMax:=n;End;
 End;
 i:=0;
 for n:=PixMin to x0.face[nf].nbPixs-1do Begin
  Nx[i]:=x[x0.face[nf].Pix[n]];Ny[i]:=y[x0.face[nf].Pix[n]];Inc(i)
 ENd;
 Nx[x0.face[nf].nbPixs]:=x[x0.face[nf].Pix[PixMin]];
 Ny[x0.face[nf].nbPixs]:=y[x0.face[nf].Pix[PixMin]];
 For n:=0to PixMin-1do Begin
  Nx[i]:=x[x0.face[nf].Pix[n]];Ny[i]:=y[x0.face[nf].Pix[n]];Inc(i)
 End;
 If(PixMax>PixMin)Then DPixs:=PixMax-PixMin Else DPixs:=x0.face[nf].nbPixs-PixMin+PixMax;
 For i:=0to x0.face[nf].nbPixs-1do Begin
  Dx[i]:=Nx[i+1]-Nx[i];Dy[i]:=Ny[i+1]-Ny[i];
  if Dx[i]<0Then signe[i]:=-1 Else signe[i]:=1;
  if Dy[i]<0Then Dy[i]:=-Dy[i];
  if Dx[i]<0Then Dx[i]:=-Dx[i];
 End;
 j:=0;
 for n:=0to DPixs-1do if Dy[n]<Dx[n]Then Begin
  Chk:=Dx[n]-Dy[n];i:=Ny[n];k:=Nx[n];
  While i<>Ny[n+1]do Begin
   while Chk>0do Begin;Dec(Chk,Dy[n]);Inc(k,signe[n])End;
   Inc(Chk,Dx[n]);xd[j]:=k;Inc(i);Inc(j)
  End;
 End
  else
 Begin
  Chk:=Dy[n]-Dx[n];i:=Ny[n];k:=Nx[n];
  While i<>Ny[n+1]do Begin
   If Chk<0Then Begin;Inc(Chk,Dy[n]);Inc(k,signe[n])End;
   Dec(Chk,Dx[n]);xd[j]:=k;Inc(i);Inc(j)
  End;
 End;
 j:=0;
 For n:=x0.face[nf].nbPixs downto DPixs+1do if Dy[n-1]<Dx[n-1]Then Begin
  Chk:=Dx[n-1]-Dy[n-1];i:=Ny[n];k:=Nx[n];
  While i<>Ny[n-1]do Begin
   While Chk>0do Begin;Dec(Chk,Dy[n-1]);Dec(k,signe[n-1])End;
   Inc(Chk,Dx[n-1]);xg[j]:=k;Inc(i);Inc(j)
  End;
 End
  else
 Begin
  Chk:=Dy[n-1]-Dx[n-1];i:=Ny[n];k:=Nx[n];
  While i<>Ny[n-1]do Begin
   if Chk<0Then Begin;Inc(Chk,Dy[n-1]);Dec(k,signe[n-1])End;
   Dec(Chk,Dx[n-1]);xg[j]:=k;Inc(i);Inc(j)
  End;
 End;
 If xg[5]<xd[5]Then Begin
  I:=0;
  For N:=yMin to yMax-1do Begin
   PutLnHor(xg[I],N,xd[I],Kr);
   Inc(I)
  End;
 End;
End;

Procedure LoaderObjet(No:Int;Name:String);Var f:Text;i,n:Int;Begin
 Assign(f,Name);
 Reset(f);
 ReadLn(f,Objet[No].NbPixs);
 ReadLn(f,Objet[No].NbFaces);
 Dec(Objet[No].NbFaces);
 ReadLn(f);
 For n:=0to objet[No].nbPixs-1do ReadLn(f,objet[No].x3d[n],objet[No].y3d[n],objet[No].z3d[n]);
 ReadLn(f);
 for N:=0to(Objet[No].NbFaces)do Begin
  Objet[No].Face[n].Kr:=Random(230)+16;
  Read(f,objet[No].face[n].nbPixs);
  For i:=0to objet[No].face[n].nbPixs-1do Begin
   Read(F,objet[No].face[n].Pix[i]);
   Dec(objet[No].face[n].Pix[i]);
  End;
  Objet[No].face[n].Pix[i+1]:=Objet[No].face[n].Pix[0];
  ReadLn(f);
 End;
 System.Close(f);
End;

Procedure InitSinCos;Var N:Int;Begin
 For N:=0to 359do Begin
  TCos[N]:=Trunc(cos(N*3.141592654/180)*Delta);
  TSin[N]:=Trunc(sin(N*3.141592654/180)*Delta);
 End;
End;

Procedure DrawObject(Var x0:TObjet);Const i:Int=0;SensX{:Integer}=1;
SensY{:Integer}=1;SensZ{:Integer}=1;Var N,t:Int;ZR,YR,XR:Long;Begin
 If(I<359-Speed)Then Inc(I,Speed)else I:=0;
 for N:=0to x0.nbPixs-1do Begin
  t:=x0.y3d[N];
  YR:=((T*Long(TCos[I]))-(SensX*x0.z3d[N]*Long(TSin[I])))div Delta;
  ZR:=((SensX*T*Long(TSin[I]))+(x0.z3d[N]*Long(TCos[I])))div Delta;
  t:=x0.x3d[N];
  XR:=((T*Long(TCos[i]))-(SensY*ZR*Long(TSin[I])))div Delta;
  ZR:=((SensX*T*Long(TSin[i]))+(ZR*Long(TCos[I])))div Delta;
  t:=XR;
  XR:=((T*Long(TCos[i]))-(SensZ*YR*Long(TSin[i])))div Delta;
  YR:=((SensZ*T*Long(TSin[i]))+(YR*Long(TCos[i])))div Delta;
  x[n]:=(PROFONDEUR*XR)div(DISTANCE+ZR)+(GetNmXPixels shr 1);
  y[n]:=(PROFONDEUR*YR)div(DISTANCE+ZR)+(GetNmYPixels shr 1);
 End;
 If(FilDeFer)Then For N:=0to(x0.nbfaces)do DrawPoly(x0,n,x0.face[n].Kr)
             Else For N:=0to(x0.nbfaces)do FillPoly(x0,n,x0.face[n].Kr);
End;

Const Pg:Byte=0;K:Wd=0;Mode:Byte=0;Obj:Array[0..5]of Bool=(Ya,Ya,Ya,Ya,Ya,Ya);

BEGIN
 InitSystems(suIsabel);
 SetVideoModeDeluxe(vmGrf320x400c256{vmGrf640x350c16});
 SetChrWidth(Mode);
 InitSinCos;
 Randomize;
 LoaderObjet(0,'cube.3d');
 LoaderObjet(1,'pyra1.3d');
 LoaderObjet(2,'torus1.3d');
 LoaderObjet(3,'pyra2.3d');
 LoaderObjet(4,'arai.3d');
 LoaderObjet(5,'Carre.3d');
 Repeat
  Pg:=(Pg+1)and 1;
  SetPage(Pg);
  ClrScr(0);
  For K:=0to 5do If Obj[K]Then DrawObject(Objet[K]);
  If(KeyPress)Then Begin
   K:=ReadKey;
   Case(K)of
    kbF1:FilDeFer:=Not(FilDeFer);
    kbF2:Begin;Mode:=(Mode+1)and 1;ClrScr(0);SetChrWidth(Mode)End;
    kbF3:If Speed<31Then Inc(Speed);
    kbF4:If Speed>1Then Dec(Speed);
    kbF5:ASM XOR Byte Ptr Obj[0],1;END;
    kbF6:ASM XOR Byte Ptr Obj[1],1;END;
    kbF7:ASM XOR Byte Ptr Obj[2],1;END;
    kbF8:ASM XOR Byte Ptr Obj[3],1;END;
    kbF9:ASM XOR Byte Ptr Obj[4],1;END;
    kbF10:ASM XOR Byte Ptr Obj[5],1;END;
   End;
  End;
  SetVisualPg(Pg);
  WaitRetrace;
 Until K=kbEsc;
 DoneLuxeVideo;
END.