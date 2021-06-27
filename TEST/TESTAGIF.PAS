Uses Adele,Systex,Systems,Video,Isatex,
     ResTex,ResLoadI,ResServI;

Var
 R:ImageObjectLoader;
 Q:XInf;
 I:Integer;
 X:Word;
 Y:Word;
 Inf:MCanvas;

Procedure RIPutSprite(Var Q:XInf;X1,Y1,X2,Y2:Word);
Var
 Buffer:Array[0..4095]of Byte;
 Res:ImageHeaderRes;
 J:Integer;
 P:LongInt;
Begin
 XGetAbsRec(Q,0,SizeOf(Res),Res);
 P:=SizeOf(Res);
 For J:=0to Res.NumYPixels-1do Begin
  XGetAbsRec(Q,P,Res.BytesPerLine,Buffer);
  {ClrLnHorImg(X1,J,Res.NumXPixels,BitsPerPixel,Buffer);}
  PutSprite(X1,J,X1+Res.NumXPixels,J,Buffer);
  Inc(P,LongInt(Res.BytesPerLine));
 End;
End;

BEGIN
 InitSystems(suIsabel);
 InitMemManagers;
 SetVideoModeDeluxe(vmGrf800x600c65536);
 RIInitLoader(R);
{ R.Handle:=Open('C:\DESSIN\NEC1.GIF',fmRead);}
{ R.Handle:=Open('RESOURCE\MEDIA\BLOP.GIF',fmRead);}
 R.Handle:=Open('RESOURCE\MEDIA\FINDFILE.GIF',fmRead);
{ R.Handle:=Open('A:\FINDFIL2.GIF',fmRead);}
 If(R.Handle<>errHdl)Then Begin
  R.Ressource:=rmAllRes;
  Include(R.Option,fpAllImage);
  RIReadGIF(R,Q);
  X:=200;Y:=0;
  For I:=0to R.NumAnim-1do Begin
   RIRes2WnImg(R.Anim^[I],Inf);
   RIMakeDoublon(R.Anim^[I],rmAllResSteady,True,Inf);
(*   _RIPutScale(R.Anim^[I],X,Y,199,99,{0}BitsPerPixel,[wiPut2Screen],Q);*)
   RIPutImage({R.Anim^[I]}Inf.Miroir,X,Y,X+199,Y+99);
   Inc(X,200);
   If X>=800Then Begin
    Inc(Y,100);
    X:=0;
   End;
   XFreeMem(Inf.Miroir);
   If(Y>=GetNumYPixels)Then Break;
  End;
  Close(R.Handle);
 End;
 Repeat
  I:=0;
  Repeat
   RIRes2WnImg(R.Anim^[I],Inf);
   RIMakeDoublon(R.Anim^[I],rmAllResSteady,True,Inf);
{   RIPutImage(Inf.Miroir,0,0,199,99);}
   RIPutImageJuxtap(Inf.Miroir,0,0,199,99,[]);
{   RIPutSprite(Inf.Miroir,0,0,199,99);}
   Inc(I);
   {WaitRetrace;}
   Delay(100);
   XFreeMem(Inf.Miroir);
   If(KeyPress)Then Break;
  Until R.NumAnim<=I;
 Until KeyPress;
 DoneMemManagers;
 ReadKey;
END.