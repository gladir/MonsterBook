#include "systex.h"

extern void SetChr(Byte X,Byte Y,Byte C);

void BarChrHor(Byte X1,Byte Y,Byte X2,Byte C){
 Byte I;
 for(I=X1;I<=X2;I++) SetChr(I,Y,C);
}

void BarChrVer(Byte X,Byte Y1,Byte Y2,Byte C){
 Byte J;
 for(J=Y1;J<=Y2;J++) SetChr(X,J,C);
}