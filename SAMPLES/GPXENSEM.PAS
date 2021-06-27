Program GPXEnsembles;

Uses Adele,Systex,Systems,Video,GPXServices;

Const WGX:Word=0;WGY:Word=0;

Procedure WGPutLine(X1,Y1,X2,Y2,Kr:Wd);Begin
 PutLine(WGX+X1,WGY+Y1,WGX+X2,WGY+Y2,Kr)
End;

Procedure WGPutChr(X,Y:Byte;Chr:Char);Begin
 X:=X shl 1;
 PutFillCircle(WGX+(X shl 3)+3,WGY+(Y*HeightChr)+6,8,0);
 PutSmlTxtXY((WGX shr 3)+X,(WGY div HeightChr)+Y,Chr,White);
 Circle(WGX+(X shl 3)+3,WGY+(Y*HeightChr)+6,8,White);
End;

BEGIN
 InitSystems(suIsabel);
 CheckSVGA:=Ya;
 SetVideoModeDeluxe(vmGrf1024x768c256);
 WGPutLine(16,16,111,111,White);
 WGPutChr(1,1,'1');WGPutChr(3,3,'4');
 WGPutChr(5,5,'8');WGPutChr(7,7,'9');
 WGX:=112;
 WGPutLine(16,16,87,87,White);
 WGPutLine(88,88,88-32,88+32,White);
 WGPutChr(1,1,'1');WGPutChr(3,3,'4');
 WGPutChr(5,5,'9');WGPutChr(3,7,'8');
 WGX:=208;
 WGPutLine(16,16,87,87,White);
 WGPutLine(52,52,52-32,52+32,White);
 WGPutChr(1,1,'1');WGPutChr(3,3,'8');
 WGPutChr(5,5,'9');WGPutChr(1,5,'4');
 WGX:=0;WGY:=128;
 WGPutLine(16,16,51,51,White);
 WGPutLine(52,52,52-32,52+32,White);
 WGPutLine(16,84,51,84+35,White);
 WGPutChr(1,1,'1');WGPutChr(3,3,'9');
 WGPutChr(1,5,'4');WGPutChr(3,7,'8');
 WGX:=96;
 WGPutLine(48,16,83,51,White);
 WGPutLine(84,52,84-64,52+64,White);
 WGPutChr(3,1,'1');WGPutChr(5,3,'9');
 WGPutChr(3,5,'8');WGPutChr(1,7,'4');
 WGX:=192;
 WGPutLine(48,16,13,51,White);
 WGPutLine(84-64,52,84,52+64,White);
 WGPutChr(3,1,'9');WGPutChr(1,3,'1');
 WGPutChr(3,5,'4');WGPutChr(5,7,'8');
 PutRect(0,0,311,271,15);
 GPXServices.SaveImage(0,0,311,271,1,'\ATLAS\ECOLE\PROGRAMA.TIO\420-301\DOCUMENT\ARBRES1.GPX');
 ClrScrBlack;
 WGX:=0;WGY:=0;
 WGPutLine(16,16,51,51,White);
 WGPutLine(52,52,52-32,52+32,White);
 WGPutLine(16,84,51,84+35,White);
 WGPutChr(1,1,'9');WGPutChr(3,3,'1');
 WGPutChr(1,5,'8');WGPutChr(3,7,'4');
 WGX:=96;
 WGPutLine(87,16,16,87,White);
 WGPutLine(52,52,52+32,52+32,White);
 WGPutChr(5,1,'9');WGPutChr(3,3,'4');
 WGPutChr(5,5,'1');WGPutChr(1,5,'8');
 WGX:=192;
 WGPutLine(87,16,16,87,White);
 WGPutLine(16,88,16+32,88+32,White);
 WGPutChr(5,1,'9');WGPutChr(3,3,'8');
 WGPutChr(1,5,'1');WGPutChr(3,7,'4');
 WGX:=0;WGY:=128;
 WGPutLine(115,20,20,115,White);
 WGPutChr(7,1,'1');WGPutChr(5,3,'4');
 WGPutChr(3,5,'8');WGPutChr(1,7,'9');
 PutRect(0,0,311,271,15);
 GPXServices.SaveImage(0,0,311,271,1,'\ATLAS\ECOLE\PROGRAMA.TIO\420-301\DOCUMENT\ARBRES2.GPX');
 ClrScrBlack;
 WGX:=0;WGY:=0;
 WGPutLine(55,16,16,55,White);
 WGPutLine(52,16,52+64,16+64,White);
 WGPutChr(3,1,'4');WGPutChr(5,3,'8');
 WGPutChr(1,3,'1');WGPutChr(7,5,'9');
 WGX:=112;
 WGPutLine(55,16,16,55,White);
 WGPutLine(52,16,52+32,16+32,White);
 WGPutLine(84,48,84-32,48+32,White);
 WGPutChr(3,1,'4');WGPutChr(5,3,'9');
 WGPutChr(1,3,'1');WGPutChr(3,5,'8');
 WGX:=200;
 WGPutLine(55,16,16,55,White);
 WGPutLine(52,16,52+32,16+32,White);
 WGPutLine(16,48,48,48+32,White);
 WGPutChr(3,1,'8');WGPutChr(5,3,'9');
 WGPutChr(1,3,'1');WGPutChr(3,5,'4');
 WGX:=296;
 WGPutLine(80,16,16,16+64,White);
 WGPutLine(80,16,55+64,55,White);
 WGPutChr(1,5,'1');WGPutChr(5,1,'8');
 WGPutChr(3,3,'4');WGPutChr(7,3,'9');
 PutRect(0,0,431,127,15);
 GPXServices.SaveImage(0,0,431,127,1,'\ATLAS\ECOLE\PROGRAMA.TIO\420-301\DOCUMENT\ARBRES3.GPX');
 ASM
  XOR AX,AX
  INT 16h
 END;
END.