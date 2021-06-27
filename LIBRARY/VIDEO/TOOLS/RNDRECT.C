extern int LineWidth;

/*Description
  อออออออออออ
   Cette procdure affiche une bote avec les coins rond.
*/

void PutRoundRect(int x1,int y1,int x2,int y2,int b,int Kr){
 int a,xr,yr,x,i,j,y,xN,yN;long AO,BO,AO2,BO2,AO4,BO4,d;
 for(yr=b,xr=b,xN=x2-xr,yN=y2+yr,j=-LineWidth/2;j<=LineWidth/2;j++){
  for(i=x1+xr;i<=xN;i++){Plot(i,y1-j,Kr);Plot(i,y2-j,Kr);}
 }
 for(j=-LineWidth/2;j<=LineWidth/2;j++){
  for(i=y1-yr;i>=yN;i--){Plot(x1+j,i,Kr);Plot(x2+j,i,Kr);}
 }
 for(b-=LineWidth/2,a=b,i=0;i<LineWidth;i++){
  BO=b*b,AO=a*a,y=b,x=0,AO2=AO<<1,AO4=AO<<2,BO4=BO<<2,BO2=BO<<1;
  d=AO2*((y-1)*y)+AO+BO2*(1-AO);
  while(AO*y>BO*x){
   Plot(x+xN,yN-y,Kr);Plot(x+xN,y1-yr+y,Kr);
   Plot(x1+xr-x,yN-y,Kr);Plot(x1+xr-x,y1-yr+y,Kr);
   if(d>=0) y--,d-=AO4*y;
   d+=BO2*(3+(x<<1)),x++;
  }
  d=BO2*(x+1)*x+AO2*(y*(y-2)+1)+(1-AO2)*BO;
  while(y){
   Plot(x+xN,yN-y,Kr);Plot(x+xN,y1-yr+y,Kr);
   Plot(x1+xr-x,yN-y,Kr);Plot(x1+xr-x,y1-yr+y,Kr);
   if(d<=0) x++,d+=BO4*x;
   y--,d+=AO2*(3-(y<<1));
  }
  b++,a++;
 }
}