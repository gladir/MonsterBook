/*============================================================*/
/* VIDEO.CPP CONTIENT DES FONCTIONS D'AFFICHAGE POUR LE MODE  */
/* GRAPHIQUE 320x200 (ET D'INITIALISATION)                    */
/* FAIT PAR: Pierre B‚langer                                  */
/* BRACONAGE: Sylvain Maltais                                 */
/*============================================================*/

#include <IOSTREAM.H>
#include <CONIO.H>
#include <stdlib.h>
#include <math.h>
#include <dos.h>
#include <stdio.h>

/* ----------------------- CONSTANTES ------------------------*/
const SC_INDEX = 0x3C4;
const SC_MAP_MASK = 2;
const SC_MEM_MODE = 4;
const GC_INDEX = 0x3CE;
const GC_READ_MAP = 4;
const GC_GRAPH_MODE = 5;
const GC_MISCELL = 6;
const CRTC_INDEX = 0x3D4;
const CC_MAX_SCAN = 9;
const CC_START_HI = 0x0C;
const CC_UNDERLINE = 0x14;
const CC_MODE_CTRL = 0x17;
const DAC_WRITE_ADR = 0x3C8;
const DAC_READ_ADR = 0x3C7;
const DAC_DATA = 0x3C9;
const VERT_RETRACE = 0x3DA;


const NB_PT_MAX_OBJET = 50;
const NB_FACE_MAX_OBJET = 50;
const NB_PT_MAX_FACE = 10;

const PROFONDEUR = 150;
const DISTANCE = 400;

const PAGE[4]={0,16000,32000,48000};//0x4000, 0x8000, 0xC000};
int AddrPg,AddPg;

const char Plane0[4] = {0,3,2,1};
const char Plane1[4] = {1,0,3,2};
const char Plane2[4] = {2,1,0,3};
const char Plane3[4] = {3,2,1,0};

/* --------------------- FIN CONSTANTES ----------------------*/

/* ------------------- VARIABLES & TYPES ---------------------*/
typedef struct TPolyface{int Pix[NB_PT_MAX_FACE],nbPixs,no_objet,Kr;};
typedef struct TPixs{int x[NB_PT_MAX_FACE],y[NB_PT_MAX_FACE];};

typedef struct TObjet{
 TPolyface face[NB_FACE_MAX_OBJET];
 float x3d[NB_PT_MAX_OBJET],y3d[NB_PT_MAX_OBJET],z3d[NB_PT_MAX_OBJET];
 int x[NB_PT_MAX_OBJET],y[NB_PT_MAX_OBJET],nbPixs,nbfaces;
};

//unsigned char far *video_buffer = (unsigned char far *)0xA0000000;
unsigned int y_list[200],hexa[256];
float TCos[360],TSin[360];
unsigned int vio_seg=0xA000;
unsigned int PixX = 80; // resolution horizontale / 4
unsigned int RealRawY[511];

TObjet objet[6]; //nombres d'objets max+1
/* ---------------------- FIN VARIABLES ----------------------*/

/* ------------------------ FONCTIONS ------------------------*/

/*--------------------=====================-------------------*/
void mode13h_4pages(void){
/*--------------------=====================-------------------*/
 asm{
  MOV AX,13h
  INT 10h
  MOV DX,GC_INDEX
  MOV AL,GC_GRAPH_MODE
  OUT DX,AL
  INC DX
  IN  AL,DX
  AND AL,11101111b
  OUT DX,AL
  DEC DX
  MOV AL,GC_MISCELL
  OUT DX,AL
  INC DX
  IN  AL,DX
  AND AL,11111101b
  OUT DX,AL
  MOV DX,SC_INDEX
  MOV AL,SC_MEM_MODE
  OUT DX,AL
  INC DX
  IN  AL,DX
  AND AL,11110111b
  OR  AL,4
  OUT DX,AL
  MOV AX,vio_seg //clear screen avec la couleur 00h
  MOV ES,AX
  XOR DI,DI
  MOV AX,DI
  MOV CX,8000h
  REP STOSW
  MOV DX,CRTC_INDEX
  MOV AL,CC_UNDERLINE
  OUT DX,AL
  INC DX
  IN  AL,DX
  AND AL,10111111b
  OUT DX,AL
  DEC DX
  MOV AL,CC_MODE_CTRL
  OUT DX,AL
  INC DX
  IN  AL,DX
  OR  AL,01000000b
  OUT DX,AL
 }
}
/*------------------------------------------------------------*/

/*--------------------=====================-------------------*/
void setpage(unsigned char page){
/*--------------------=====================-------------------*/
 asm{
  MOV BL,page
  AND BL,1
  XOR AX,AX
  OR  BL,BL
  JZ  _1
  MOV AX,16000
 }
_1:asm{
  MOV AddrPg,AX
/* MOV CL,page
  MOV AL,4
  MUL CL
  OR AL,0xA0
  MOV byte ptr vio_seg+1,AL*/
 }
}
/*------------------------------------------------------------*/

/*--------------------=====================-------------------*/
void showpage(unsigned char page){
/*--------------------=====================-------------------*/
 asm{
  MOV BL,page
  XOR AX,AX
  OR  BL,BL
  JZ  _1
  MOV AX,16000
 }
_1:asm{
  MOV BL,AL
  MOV DX,0x3D4
  MOV AL,12
  OUT DX,AL
  INC DX
  MOV AL,AH
  OUT DX,AL
  DEC DX
  MOV AL,13
  OUT DX,AL
  INC DX
  MOV AL,BL
  OUT DX,AL
/* MOV CL,page
  MOV AL,64
  MUL CL
  MOV AH,AL
  MOV DX,CRTC_INDEX
  MOV AL,CC_START_HI
  OUT DX,AX*/
  MOV DX,VERT_RETRACE
 }
 sp3:asm{
  IN  AL,DX
  TEST AL,8
  JNE sp3}
 sp4:asm{
  IN  AL,DX
  TEST AL,8
  JE  sp4}
}
/*------------------------------------------------------------*/

/*--------------------=====================-------------------*/
void putpixel(int x, int y, unsigned char couleur){
/*--------------------=====================-------------------*/
// if((y<0)||(y>199)) return;
 asm{
  MOV ES,vio_seg
  MOV CX,x
  AND CX,3
  MOV AX,1
  SHL AX,CL
  MOV AH,AL
  MOV DX,0x3C4
  MOV AL,2
  OUT DX,AX
  MOV DI,y
  SHL DI,1
  MOV DI,Word Ptr RealRawY[DI]
  ADD DI,AddPg
  MOV AX,x
  SHR AX,1
  SHR AX,1
  ADD DI,AX
// ADD DI,DataVideo.MIV.AddrPg
  MOV AL,Byte Ptr couleur
  STOSB
 }
/*asm{
  MOV AX,PixX
  MUL y
  MOV CX,x
  MOV BX,CX
  SHR BX,1
  SHR BX,1
  ADD AX,BX
  MOV DI,AX
  AND CL,3
  MOV AH,1
  SHL AH,CL
  MOV AL,SC_MAP_MASK
  MOV DX,SC_INDEX
  OUT DX,AX
  MOV ES,vio_seg
  MOV AL,couleur
  STOSB
 }*/
}
/*------------------------------------------------------------*/

void line_hor(unsigned x1,unsigned x2,unsigned y,unsigned char Kr){
 #ifdef Samples
 for(int n=x1;n<=x2; n++)putpixel(n,y,couleur);
 #else
 unsigned Start,StartPlane,Len,L;unsigned long aY;
// if((y<0)||(y>199)) return;
 if(x2<x1){unsigned x=x2;x2=x1,x1=x;};
 asm{
 MOV AX,x2
 SUB AX,x1
 MOV L,AX
 INC AX
 SHR AX,1
 SHR AX,1
 MOV Len,AX
 MOV BX,y
 SHL BX,1
 MOV AX,Word Ptr RealRawY[BX]
 XOR DX,DX
 ADD AX,AddrPg
 ADC DX,DX
 SHL AX,1
 RCL DX,1
 SHL AX,1
 RCL DX,1
 ADD AX,x1
 ADC DX,0
 MOV Word Ptr aY,AX
 MOV Word Ptr aY[2],DX
 LES AX,aY
 MOV DX,ES
 MOV BX,AX
 AND BX,3
 MOV StartPlane,BX
 SHR DX,1
 RCR AX,1
 SHR DX,1
 RCR AX,1
 SUB AX,BX
 MOV Start,AX
 MOV AX,0xA000
 MOV ES,AX
// MOV ES,vio_seg
 CLD
 }
_Restart:asm{
  // Fixe la plage 0
 MOV DX,0x3C4
 MOV AX,2+(1 shl 8)
 OUT DX,AX
  // Calcule le point de d‚part dans le tampon... ®P==_AX¯
 MOV BX,StartPlane
 MOV AL,Byte Ptr Plane0[BX]
 XOR AH,AH
  // Calcul le suppl‚ment de P1 ®_DI:=Byte(StartPlane>0);¯
 XOR DI,DI
 OR  BL,BL
 JZ  _0
 INC DI
 }
_0:asm{
  // Calcul l'incr‚mentation de P1 ®_DI+:=Start+StartPlane;¯
 ADD DI,Start
 ADD DI,BX
  // Calcul le LenSub ®_CX:=(L ï 3 < 3) ï (L ï 3 >= P) ? 1 : 0;¯
 XOR CX,CX
 MOV DX,L
 AND DX,3
 CMP DX,3
 JNB _1
 CMP DX,AX
 JNAE _1
 INC CX
 }
_1:asm{//For J:=0to(Len)do Begin;Mem[_A000:P1]:=Kr;Inc(P1)End;
 ADD CX,Len
 MOV AL,Kr
 MOV AH,AL
 SHR CX,1
 REP STOSW
 ADC CX,CX
 REP STOSB
  // Fixe la plage 1
 MOV DX,0x3C4
 MOV AX,2+(2 shl 8)
 OUT DX,AX
  // Calcule le point de d‚part dans le tampon...
 MOV BX,StartPlane
 MOV AL,Byte Ptr Plane1[BX]
 XOR AH,AH
  // Calcul le suppl‚ment de P1 ®_DI:=Byte(StartPlane>1);¯
 XOR DI,DI
 CMP BL,1
 JNA _0b
 INC DI
 }
_0b:asm{
  // Calcul l'incr‚mentation de P1 ®_DI+:=Start+StartPlane;¯
 ADD DI,Start
 ADD DI,BX
  // Calcul le LenSub ®_CX:=(L ï 3 < 3) ï (L ï 3 >= P) ? 1 : 0;¯
 XOR CX,CX
 MOV DX,L
 AND DX,3
 CMP DX,3
 JNB _1b
 CMP DX,AX
 JNAE _1b
 INC CX
 }
_1b:asm{
  //For J:=0to(Len)do Begin;Mem[_A000:P1]:=Kr;Inc(P1)End;
 ADD CX,Len
 MOV AL,Kr
 MOV AH,AL
 SHR CX,1
 REP STOSW
 ADC CX,CX
 REP STOSB
  // Fixe la plage 2
 MOV DX,0x3C4
 MOV AX,2+(4 shl 8)
 OUT DX,AX
  // Calcule le point de d‚part dans le tampon...
 MOV BX,StartPlane
 MOV AL,Byte Ptr Plane2[BX]
 XOR AH,AH
  // Calcul le suppl‚ment de P1 ®_DI:=Byte(StartPlane>2);¯
 XOR DI,DI
 CMP BL,2
 JNA _0c
 INC DI
 }
_0c:asm{
  // Calcul l'incr‚mentation de P1 ®_DI+:=Start+StartPlane;¯
 ADD DI,Start
 ADD DI,BX
  // Calcul le LenSub ®_CX:=(L ï 3 < 3) ï (L ï 3 >= P) ? 1 : 0;¯
 XOR CX,CX
 MOV DX,L
 AND DX,3
 CMP DX,3
 JNB _1c
 CMP DX,AX
 JNAE _1c
 INC CX
 }
_1c:asm{
 ADD CX,Len
 MOV AL,Kr
 MOV AH,AL
 SHR CX,1
 REP STOSW
 ADC CX,CX
 REP STOSB
  // Fixe la plage 3
 MOV DX,0x3C4
 MOV AX,2+(8 shl 8)
 OUT DX,AX
  // Calcule le point de d‚part dans le tampon...
 MOV BX,StartPlane
 MOV AL,Byte Ptr Plane3[BX]
 XOR AH,AH
  // Calcul l'incr‚mentation de P1 ®_DI:=Start+StartPlane;¯
 MOV DI,Start
 ADD DI,BX
  // Calcul le LenSub ®_CX:=(L ï 3 < 3) ï (L ï 3 >= P) ? 1 : 0;¯
 XOR CX,CX
 MOV DX,L
 AND DX,3
 CMP DX,3
 JNB _1d
 CMP DX,AX
 JNAE _1d
 INC CX
 }
_1d:asm{
 ADD CX,Len
 MOV AL,Kr
 MOV AH,AL
 SHR CX,1
 REP STOSW
 ADC CX,CX
 REP STOSB
 }
 #endif
}

/*--------------------=====================-------------------*/
unsigned char getpixel(int x,int y){
/*--------------------=====================-------------------*/
 asm{
  MOV AX,PixX
  MUL y
  MOV SI,x
  MOV CX,SI
  SHR SI,1
  SHR SI,1
  ADD SI,AX
  AND CL,3
  MOV AH,CL
  MOV AL,GC_READ_MAP
  MOV DX,GC_INDEX
  OUT DX,AX
  MOV AX,vio_seg
  MOV ES,AX
  MOV AL,ES:[SI]
 }
 return _AL;
}
/*------------------------------------------------------------*/

/*--------------------=====================-------------------*/
void clear_screen(int page){
/*--------------------=====================-------------------*/
// for(int i=0;i<199;i++) line_hor(0,i,319,0);
  asm{
   MOV AL,0x02
   MOV AH,0x0F
   MOV DX,0x3C4
   OUT DX,AX
   MOV AX,0xA000
   MOV ES,AX
// MOV ES,vio_seg
   MOV DI,page
   DB 0x66
   XOR AX,AX
   MOV CX,16000/4
   DB 0x66
   REP STOSW
  }
}
/*------------------------------------------------------------*/

/*--------------------=====================-------------------*/
void readln(FILE *fichier){
/*--------------------=====================-------------------*/
 char tampon[81];
 fgets(tampon,80,fichier);
}
/*------------------------------------------------------------*/

/*--------------------=====================-------------------*/
int read_number(FILE *f){
/*--------------------=====================-------------------*/
 int n,i,j,exposant,signe,nombre,c[10];char S[10];
 n=0;
 do S[n]=getc(f),n++;while(S[n-1]!=32&&S[n-1]!=10&&S[n-1]!=EOF);
 if(S[n-1]==10)fseek(f,ftell(f)-1,SEEK_SET);
 n=0,i=0,signe=1;
 while(S[n]!=32&&S[n]!=10&&S[n]!=EOF){ //10 est le line feed
  c[i]=S[n];
  if(c[i]==45)signe=-1;else c[i]-=48;
  i++,n++;
 }
 for(i--,n=signe==-1?1:0,nombre=0;n<=i;n++){
  exposant=1;
  for(j=1;j<=i-n;j++) exposant*=10;
  nombre+=c[n]*exposant;
 }
 return nombre*signe;
}

/*------------------------------------------------------------*/

/*--------------------=====================-------------------*/
void modevideo(int mode){
/*--------------------=====================-------------------*/
 asm{
  mov ax,mode
  int 0x10
 }
}
/*------------------------------------------------------------*/

/*--------------------=====================-------------------*/
void quicksort(int a[],int l,int r){
/*--------------------=====================-------------------*/
 int i=l,j=r,x=a[(l+r)/2],y;
 while(i<j){
  while(a[i]<x)i++;
  while(x<a[j])j--;
  if(i<=j)y=a[i],a[i]=a[j],a[j]=y,i++,j--;
 }
 if(l<j)quicksort(a,l,j);
 if(i<r)quicksort(a,i,r);
}
/*------------------------------------------------------------*/

/*--------------------=====================-------------------*/
void ini_y_list(void){
/*--------------------=====================-------------------*/
 for(int n=0;n<200;n++)y_list[n]=n*320;
}
/*------------------------------------------------------------*/

/*--------------------=====================-------------------*/
void ini_hexa(void){
/*--------------------=====================-------------------*/
 for(int n=0;n<256;n++)hexa[n]=n<<8;
}
/*------------------------------------------------------------*/

/*--------------------=====================-------------------*/
void line(int x1,int y1,int x2,int y2,unsigned char couleur){
/*--------------------=====================-------------------*/
 int temp,Dx,Dy,check,signe;
 if(x1>x2) temp=x1,x1=x2,x2=temp,temp=y1,y1=y2,y2=temp;
 Dx=x2-x1,Dy=y2-y1,Dy<0?Dy=-Dy,signe=-1:signe=1;
 if(x2!=x1){
  if(Dy<Dx){ //si pente < 1
   check=Dx-Dy;
   for(;x1<=x2;x1++){
    if(check<0)check+=Dx,y1+=signe;
    check-=Dy;
    putpixel(x1, y1, couleur);
   }
  }
   else
  {
   check=Dy-Dx;
   for(;y1!=y2;y1+=signe){
   if(check<0)check+=Dy,x1++;
   check-=Dx;
   putpixel(x1, y1, couleur);
  }
  if(check<0)check+=Dy,x1++;
  putpixel(x1,y1,couleur);
 }
 }
  else
 {
  for(;y1!=y2;y1+=signe)putpixel(x1,y1,couleur);
  putpixel(x1,y1,couleur);
 }
}
/*------------------------------------------------------------*/

/*--------------------=====================-------------------*/
//void line_hor(int x1, int x2, int y, unsigned char couleur)
/*--------------------=====================-------------------*/
//   int n/*, couleur2*/;
/*   couleur2=hexa[couleur]+couleur;
   if ((x2-x1) & 1)
      for (n=x1; n<x2; n+=2) putpixel2(n, y, couleur2);
   else
   {*/
      /*for (n=x1; n<x2; n+=2) putpixel2(n, y, couleur2);
	putpixel(x2, y, couleur);*/
//      for (n=x1; n<=x2; n++) putpixel(n, y, couleur);
// if(y<=101) FillBnk(y*320+x1,x2-x1+1,couleur);
/* if(y<=101) asm{
 MOV BX,y
 SHL BX,1
 MOV AX,Word Ptr RealRawY[BX]
 XOR DX,DX
 SHL AX,1
 RCL DX,1
 SHL AX,1
 RCL DX,1
 ADD AX,x1
 ADC DX,0
 PUSH DX
 PUSH AX
 MOV AX,x2
 SUB AX,x1
 INC AX
 PUSH AX
 PUSH Word Ptr couleur
 PUSH CS
 CALL Near Ptr FillBnk
 }
//   }
}
/*------------------------------------------------------------*/

/*--------------------=====================-------------------*/
void drawpoly(TObjet x0,int no_face,unsigned char Kr){
/*--------------------=====================-------------------*/
 for(int i=0;i<x0.face[no_face].nbPixs;i++)
  line(x0.x[x0.face[no_face].Pix[i]],x0.y[x0.face[no_face].Pix[i]],
       x0.x[x0.face[no_face].Pix[i+1]],x0.y[x0.face[no_face].Pix[i+1]],Kr);
}
/*------------------------------------------------------------*/

/*--------------------=====================-------------------*/
void fillpoly(TObjet x0,int nf,unsigned char Kr){
/*--------------------=====================-------------------*/
 int n,i,j,yMin,yMax=-1,PixMin,PixMax,DPixs,xg[200],xd[200],k,Chk;
 int Dx[NB_PT_MAX_FACE],Dy[NB_PT_MAX_FACE],signe[NB_PT_MAX_FACE];TPixs NewCmd;
 for(yMin=x0.y[x0.face[nf].Pix[0]],PixMin=0,n=0;n<x0.face[nf].nbPixs;n++){
  if(x0.y[x0.face[nf].Pix[n]]<yMin)yMin=x0.y[x0.face[nf].Pix[n]],PixMin=n;
  else if(x0.y[x0.face[nf].Pix[n]]>yMax)yMax=x0.y[x0.face[nf].Pix[n]],PixMax=n;
 }
 for(n=PixMin,i=0;n<x0.face[nf].nbPixs;n++,i++)
  NewCmd.x[i]=x0.x[x0.face[nf].Pix[n]],NewCmd.y[i]=x0.y[x0.face[nf].Pix[n]];
 NewCmd.x[x0.face[nf].nbPixs]=x0.x[x0.face[nf].Pix[PixMin]],
 NewCmd.y[x0.face[nf].nbPixs]=x0.y[x0.face[nf].Pix[PixMin]];
 for(n=0;n<PixMin;n++,i++)
  NewCmd.x[i]=x0.x[x0.face[nf].Pix[n]],NewCmd.y[i]=x0.y[x0.face[nf].Pix[n]];
 DPixs=PixMax>PixMin?PixMax-PixMin:x0.face[nf].nbPixs-PixMin+PixMax;
 for(i=0;i<x0.face[nf].nbPixs;i++){
  Dx[i]=NewCmd.x[i+1]-NewCmd.x[i],Dy[i]=NewCmd.y[i+1]-NewCmd.y[i],
  signe[i]=Dx[i]<0?-1:1;
  if(Dy[i]<0)Dy[i]=-Dy[i];
  if(Dx[i]<0)Dx[i]=-Dx[i];
 }
 for(j=0,n=0;n<DPixs;n++)if(Dy[n]<Dx[n]){
  for(Chk=Dx[n]-Dy[n],i=NewCmd.y[n],k=NewCmd.x[n];i!=NewCmd.y[n+1];i++,j++){
   while(Chk>0)Chk-=Dy[n],k+=signe[n];
   Chk+=Dx[n],xd[j]=k;
  }
 }
  else
 {
  for(Chk=Dy[n]-Dx[n],i=NewCmd.y[n],k=NewCmd.x[n];i!=NewCmd.y[n+1];i++,j++){
   if(Chk<0)Chk+=Dy[n],k+=signe[n];
   Chk-=Dx[n],xd[j]=k;
  }
 }
 for(j=0,n=x0.face[nf].nbPixs;n>DPixs;n--)if(Dy[n-1]<Dx[n-1]){
  for(Chk=Dx[n-1]-Dy[n-1],i=NewCmd.y[n],k=NewCmd.x[n];i!=NewCmd.y[n-1];i++,j++){
   while(Chk>0)Chk-=Dy[n-1],k+=-signe[n-1];
   Chk+=Dx[n-1],xg[j]=k;
  }
 }
  else
 for(Chk=Dy[n-1]-Dx[n-1],i=NewCmd.y[n],k=NewCmd.x[n];i!=NewCmd.y[n-1];i++,j++){
  if(Chk<0)Chk+=Dy[n-1],k+=-signe[n-1];
  Chk-=Dx[n-1],xg[j]=k;
 }
 if(xg[5]<xd[5])for(n=yMin,i=0;n<yMax;n++,i++)line_hor(xg[i],xd[i],n,Kr);
/*   else //a changer pour ne pas montrer les faces cachees en 3D
      for(n=y_min,i=0;n<y_max;n++,i++)line_hor(xd[i],xg[i],n,couleur);*/
}
/*------------------------------------------------------------*/

/*--------------------=====================-------------------*/
void loader_objet(int no_objet,char nom_fichier[]){
/*--------------------=====================-------------------*/
 FILE*f=fopen(nom_fichier, "rt");int n,i;
 fseek(f,0,SEEK_SET); //seek au debut
 objet[no_objet].nbPixs=read_number(f);
 // cout<<objet[no_objet].nbPixs<<"\n";
 readln(f);
 objet[no_objet].nbfaces=read_number(f),objet[no_objet].nbfaces--;
 //  cout<<objet[no_objet].nbfaces<<"\n";
 readln(f);readln(f);
 for(n=0;n<objet[no_objet].nbPixs;n++){
  objet[no_objet].x3d[n]=read_number(f);//cout<<objet[no_objet].x3d[n]<< " ";
  objet[no_objet].y3d[n]=read_number(f);//cout<<objet[no_objet].y3d[n]<< " ";
  objet[no_objet].z3d[n]=read_number(f);//cout<<objet[no_objet].z3d[n]<< "\n";
  readln(f);
 }
 readln(f);
 for(n=0;n<=objet[no_objet].nbfaces;n++){
  objet[no_objet].face[n].Kr=random(230)+16;
  objet[no_objet].face[n].no_objet=no_objet;
  objet[no_objet].face[n].nbPixs=read_number(f);
  for(i=0;i<objet[no_objet].face[n].nbPixs;i++){
   objet[no_objet].face[n].Pix[i]=read_number(f)-1;
   //cout<<objet[no_objet].face[n].Pix[i]<<" ";
  }
  objet[no_objet].face[n].Pix[i]=objet[no_objet].face[n].Pix[0];
  //cout<<objet[no_objet].face[n].Pix[i]<<"\n";
  readln(f);
 }
 fclose(f);
}
/*------------------------------------------------------------*/

/*--------------------=====================-------------------*/
void ini_sincos(void){
/*--------------------=====================-------------------*/
 for(int n=0;n<=359;n++)TCos[n]=cos(n*3.141592654/180),TSin[n]=sin(n*3.141592654/180);
}
/*------------------------------------------------------------*/

/*--------------------=====================-------------------*/
void draw_object(TObjet x0){
/*--------------------=====================-------------------*/
 int n,t;static int i=0,SensX=1,SensY=1,SensZ=1;
 for(i=i<359?i+1:0,n=0;n<x0.nbPixs;n++) //ROT X
  t=x0.y3d[n],x0.y3d[n]=x0.y3d[n]*TCos[i]-SensX*x0.z3d[n]*TSin[i],
  x0.z3d[n]=SensX*t*TSin[i]+x0.z3d[n]*TCos[i];
 for(n=0;n<x0.nbPixs;n++) //ROT Y
  t=x0.x3d[n],x0.x3d[n]=x0.x3d[n]*TCos[i]-SensY*x0.z3d[n]*TSin[i],
  x0.z3d[n]=SensX*t*TSin[i]+x0.z3d[n]*TCos[i];
 for(n=0;n<x0.nbPixs;n++) //ROT Z
  t=x0.x3d[n],x0.x3d[n]=x0.x3d[n]*TCos[i]-SensZ*x0.y3d[n]*TSin[i],
  x0.y3d[n]=SensZ*t*TSin[i]+x0.y3d[n]*TCos[i];
 for(n=0;n<x0.nbPixs;n++)
  x0.x[n]=(PROFONDEUR*x0.x3d[n])/(DISTANCE+x0.z3d[n])+150,
  x0.y[n]=(PROFONDEUR*x0.y3d[n])/(DISTANCE+x0.z3d[n])+100;
//for(n=0;n<=x0.nbfaces;n++) drawpoly(x0,n,x0.face[n].Kr);
 for(n=0;n<=x0.nbfaces;n++) fillpoly(x0,n,x0.face[n].Kr);
}

/*------------------------------------------------------------*/
/* ------------------------ FIN FONCTIONS --------------------*/

/*============================================================*/
/*============================= MAIN =========================*/
void main (void){
 for(int I=0,l=0;I<=511;I++){RealRawY[I]=l,l+=80;if(l>80*199)l=0;}//Compute ligne
 clrscr();
 mode13h_4pages();
 ini_y_list();
 ini_hexa();
 ini_sincos();
 randomize();
 objet[1].x[0]=130,objet[1].y[0]=70,objet[1].x[1]=150,objet[1].y[1]=90;
 objet[1].x[2]=100,objet[1].y[2]=150,objet[1].nbfaces=0;
   objet[1].face[0].no_objet=1; //contient le # de l'objet
   objet[1].face[0].nbPixs = 3; //nombre de points dans la face
   objet[1].face[0].Pix[0] = 0; //numero du pt correspondant au pt 0 de la face
   objet[1].face[0].Pix[1] = 1;
   objet[1].face[0].Pix[2] = 2;
   objet[1].face[0].Pix[3] = 0;

   loader_objet(0, "arai.3d");
   loader_objet(1, "pyra1.3d");
   loader_objet(2, "torus1.3d");
   loader_objet(3, "pyra2.3d");
   loader_objet(4, "cube.3d");
   //cout << "Appuyez sur une touche..." << "\n";
//   getch();

int change=0;unsigned int n;char touche;
while(touche!=27){
      if (change==0) change=1,AddrPg=64000,AddPg=16000;
      else change=0,AddrPg=0,AddPg=0;
      setpage(change);
      clear_screen(PAGE[change]);
	 draw_object(objet[0]);
	 draw_object(objet[4]);
	 draw_object(objet[1]);
	 draw_object(objet[3]);
	 draw_object(objet[2]);
      if (kbhit()) touche=getch();
      showpage(change);
   }

//   for(n=0;n<=99;n++) line_hor(0,319,n,n);
   /*clear_screen(0, 0);
   draw_object(objet[0]);*/


  // fillpoly(objet[0], 0, 15);
//   drawpoly(objet[1], 0, 13);
//   unsigned int count=0;

   //while (!kbhit())
  /* while (count!=10000)
   {
     //line(random(320), random(200), random(320), random(200), random(255)+1);
    //putpixel(random(320), random(200), random(255)+1);
    objet[1].x[0] = random(320);
    objet[1].y[0] = random(200);
    objet[1].x[1] = random(320);
    objet[1].y[1] = random(200);
    objet[1].x[2] = random(320);
    objet[1].y[2] = random(200);
    fillpoly(objet[1], 0, random(255)+1);
    count++;
   }*/
   //cout<<"fini";
//   getch();
   modevideo(0x3);
   cout<<"Fin..";
   getch();
}
/*======================== FIN PROGRAMME =====================*/
/*============================================================*/