Program FormuleMathematique;
{$I DEF.INC}
Uses {$IFDEF Adele}Adele,{$ELSE}Chantal,{$ENDIF}
     Systex,Isatex,Systems,Video,Mouse,Dials,Numerix;

Const mF2C=1;
      mComputeASCII=2;
      mComputeRoman=3;

Var K:Wd;L:LstMnu;W:Wins;

Procedure ComputeRoman;Var W:Wins;K,I:Wd;Sm:Long;PC:PChr;PBuf:Array[Byte]of Char;S:String;Begin
 WEInitO(W,60,11);
 WEPushWn(W);
 WEPutWnKrDials(W,'Sommation Romaine');
 PC:=@PBuf;FillClr(PBuf,SizeOf(PBuf));
 WEPutTxtLn(W,'Entrez la chaåne de caractäres Ö analyser:');
 WEBarSpcHorShade(W,0,2,wnMax);
 WESetInpColrs(W,$8F,W.XColrs.Sel);
 K:=_WEInput(W,0,2,wnMax-1,200,PC);
 If(K=kbEsc)Then Begin;WEDone(W);Exit;End;
 WESetKr(W,$8F);
 WEBarSelHor(W,0,2,wnMax-1);
 WESetKrHigh(W);
 S:=StrUp(StrPas(PC));Sm:=0;W.Y:=5;
 For I:=1to Length(S)do If IsRomanLetter(S[I])Then Inc(Sm,Byte(UpCase(S[I]))-64);
 S:=Str(Sm);Sm:=0;
 For I:=1to Length(S)do Inc(Sm,Byte(S[I])-48);
 WEPutTxtLn(W,'La somme est '+S);
 WEPutTxt(W,'DÇcomposition de la somme est ');
 For I:=1to Length(S)do Begin
  WEPutCube(W,S[I]);
  If I<>Length(S)Then WEPutCube(W,'+');
 End;
 WEPutCube(W,'=');
 WEPutTxt(W,Str(Sm));
 While WEOk(W)do;
End;

Procedure ComputeASCII;Var W:Wins;K,I:Wd;Sm:Long;PC:PChr;PBuf:Array[Byte]of Char;S:String;Begin
 WEInitO(W,60,11);
 WEPushWn(W);
 WEPutWnKrDials(W,'Sommation ASCII');
 PC:=@PBuf;FillClr(PBuf,SizeOf(PBuf));
 WEPutTxtLn(W,'Entrez la chaåne de caractäres Ö analyser:');
 WEBarSpcHorShade(W,0,2,wnMax);
 WESetInpColrs(W,$8F,W.XColrs.Sel);
 K:=_WEInput(W,0,2,wnMax-1,200,PC);
 If(K=kbEsc)Then Begin;WEDone(W);Exit;End;
 WESetKr(W,$8F);
 WEBarSelHor(W,0,2,wnMax-1);
 WESetKrHigh(W);
 S:=StrPas(PC);Sm:=0;W.Y:=5;
 For I:=1to Length(S)do Inc(Sm,Byte(S[I]));
 S:=Str(Sm);Sm:=0;
 For I:=1to Length(S)do Inc(Sm,Byte(S[I])-48);
 WEPutTxtLn(W,'La somme est '+S);
 WEPutTxt(W,'DÇcomposition de la somme est ');
 For I:=1to Length(S)do Begin
  WEPutCube(W,S[I]);
  If I<>Length(S)Then WEPutCube(W,'+');
 End;
 WEPutCube(W,'=');
 WEPutTxt(W,Str(Sm));
 While WEOk(W)do;
End;

Procedure F2C;Var W:Wins;R:Real;K,I:Wd;PC:PChr;PBuf:Array[Byte]of Char;S:String;Begin
 WEInitO(W,60,11);
 WEPushWn(W);
 WEPutWnKrDials(W,'Conversion Fahrenheit Ö Celcius');
 PC:=@PBuf;FillClr(PBuf,SizeOf(PBuf));
 WEPutTxtLn(W,'Entrez la tempÇrature en Fahrenheit:');
 WEBarSpcHorShade(W,0,2,wnMax);
 WESetInpColrs(W,$8F,W.XColrs.Sel);
 K:=_WEInput(W,0,2,wnMax-1,200,PC);
 If(K=kbEsc)Then Begin;WEDone(W);Exit;End;
 WESetKr(W,$8F);
 WEBarSelHor(W,0,2,wnMax-1);
 WESetKrHigh(W);
 S:=StrPas(PC);W.Y:=5;Val(S,R,K);
 WEPutTxtLn(W,'La tempÇrature en Fahrenheit '+RealStr2(R,4,1));
 WEPutTxtLn(W,'La tempÇrature en Celcius '+RealStr2(((R-32.0)*5.0)/9.0,4,1));
 While WEOk(W)do;
End;

BEGIN
 InitSystems(suIsabel);
{ SetVideoModeDeluxe(vmTxtDef);}
 InitVideoDeluxe;
 InitEnv;
 __InitMouse;
 WEInit(W,20,1,MaxXTxts-20,MaxYTxts-1);
 WEPushWn(W);
 LMInitKrDials(L,20,1,MaxXTxts-20,MaxYTxts-1,'Traåtement de Formule MathÇmatique');
 RBAddStrByte(L.X,'Conversion Fahrenheit Ö Celcius',mF2C);
 RBAddStrByte(L.X,'Sommation ASCII',mComputeASCII);
 RBAddStrByte(L.X,'Sommation Romaine',mComputeRoman);
 Repeat
  K:=LMRun(L);
  Case(K)of
   mF2C:F2C;
   mComputeASCII:ComputeASCII;
   mComputeRoman:ComputeRoman;
   0:K:=kbEsc;
  End;
 Until K=kbEsc;
 WEDone(W);
 UnLuxe;
{ DoneLuxeVideo;}
 DoneSystems;
END.