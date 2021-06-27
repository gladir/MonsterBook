{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                                                             Û
 ³                          M O O N                            Û
 ³                                                             Û
 ³                            pour                             Û
 ³                                                             Û
 ³     L'ensemble Malte Genesis III & IV: Isabel & Chantal     Û
 ³    Tous droits r‚serv‚ par les Chevaliers de Malte 1996     Û
 ³                                                             Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Programmeurs
 ÍÍÍÍÍÍÍÍÍÍÍÍ

  Allan Lee
  Andrew Lee
  Sylvain Maltais
}

{$I \Source\Chantal\DEF.INC}
Uses {$IFDEF Adele}Adele,{$ELSE}Chantal,{$ENDIF}
     Video,Systex,Systems,GoldNaxe,Numerix,Arcade;

Var Bac,Cur:Array[0..100]of Byte;

Procedure Paint(X,Y,Kr:Wd);Var I,J:Wd;Begin
 For I:=0to 319do For J:=189downto 0do If(GetPixel(I,J)<>Kr)Then SetPixel(I,J,15)Else Break;
End;

Procedure InitScr;Var I:Byte;Begin
 ClrScrBlack;
 GetSmlImg(0,0,8,8,Bac);
 For I:=1to 25do Plot(Random(319),Random(150),9);
 _SetKr(15);_Ln(3,7,0,8);_Ln(5,7,8,8);_Circle(4,4,4);PutRect(3,3,5,5,7);_SetKr(15);
 GetSmlImg(0,0,8,8,Cur);
 Draw('BM0,165M+10,+15R10M+10,-7R2F10E2M+10,+5R18M+5,+2E6M+5,-2M+5,-2F6M+5,'+
      '-2R15M+4,+3R3E1R5R1E3M+4,-3R35E3R6R15M+6,+2R6F3R20M+14,+3F3R14E3M+14,'+
      '-10R10E10M+10,-5M319,165');
 _Ln(0,190,319,190);Paint(188,188,15);
 BarSpcHor(0,24,39,$20);
 Draw('C0BM43,183F5BM98,184G6BM292,173F10R15');
 PutLn(155,170,155,178,14);PutLn(165,170,165,178,14);
 WriteXY(13,24,'Temps:',$20);
 WriteXY(25,24,'Carburant: 50',$20);
End;

Const KrExplos:Array[0..3]of Byte=(8,$C,$E,7);

Procedure Play;Var PX,PY,AX,AY,VX,VY,CX,CY,Gravity,Time,Tinc,A:Real;
AS,AW,Fuel,X,Y,D:Int;Q,W,PR,PS:Array[0..20]of Real;Begin
 FillClr(Q,SizeOf(Q));FillClr(W,SizeOf(W));
 FillClr(PR,SizeOf(PR));FillClr(PS,SizeOf(PS));
 VX:=0.0;VY:=0.0;Time:=0.0;CX:=4.0;CY:=4.0;AS:=0;AW:=0;AX:=0.0;AY:=0.0;
 Fuel:=50;Gravity:=0.2;Tinc:=0.3;
 ClrKbd;
 While(AS<15)and(AW<15)do Begin
  Time:=Time+Tinc;
  PX:=CX;PY:=CY;CX:=CX+VX;CY:=CY+VY;VX:=VX+AX;VY:=VY+AY+Gravity*Tinc;
  WriteXY(0,24,RealStr2(VY,2,2),$28);
  WriteXY(20,24,LTrim(RealStr2(Time,3,0)),$29);
  AX:=0.0;AY:=0.0;VX:=VX-VX*0.05*Tinc;
  If CX<4.0Then Begin CX:=4.0;VX:=-VX;End else If CX>315Then Begin CX:=315.0;VX:=-VX;End;
  If CY<4.0Then Begin CY:=4.0;VY:=-VY/2;End else If CY>185Then CY:=185.0;
  PutSmlImg(Trunc(PX)-4,Trunc(PY)-4,Trunc(PX)-4+8,Trunc(PY)-4+8,Bac);
  GetSmlImg(Trunc(CX)-4,Trunc(CY)-4,Trunc(CX)-4+8,Trunc(CY)-4+8,Bac);
  PutSmlImg(Trunc(CX)-4,Trunc(CY)-4,Trunc(CX)-4+8,Trunc(CY)-4+8,Cur);
  WaitRetrace;
  WaitRetrace;
  While(KeyPress)do Begin
   Fuel:=Trunc(Fuel-1.0*Tinc);
   WriteXY(36,24,Str2(Fuel,2),$21);
   If Fuel<=0Then Begin
    If(NxtKey=kbEsc)Then Begin ReadKey;Exit;End Else Break;
    {If Fuel<=0Then SOUND 150,3:RETURN}
   End;
{   If Fuel<5 Then SOUND 1100,1:SOUND 1400,2}
   Case ReadKey of
    kbUp:AY:=AY-1.0*Tinc;
    kbDn:AY:=AY+1.0*Tinc;
    kbLeft:AX:=AX-1.0*Tinc;
    kbRight:AX:=AX+1.0*Tinc;
    kbEsc:Exit;
   End;
  End;
  AS:=GetPixel(Trunc(CX)-4,Trunc(CY)+5);AW:=GetPixel(Trunc(CX)+4,Trunc(CY)+5);
 End;
 If(VY<=1.0)and(CX<=170.0)and(CX>=150.0)Then WriteXY(12,6,'Pointage: '+IntToStr(Trunc(500000/Time)),15)
  Else
 Begin
  If(CX>170.0)or(CX<150.0)Then WriteXY(16,6,'Manquer!!',$C);
  If VY>2Then WriteXY(16,8,'KAA BOOM!!!',$C)Else
  If VY>1Then WriteXY(16,8,'BOOM!!!',$C);
  PutSmlImg(Trunc(CX)-4,Trunc(CY)-4,Trunc(CX)-4+8,Trunc(CY)-4+8,Bac);
  For Y:=1to 20do Begin A:=Random(314)/100;D:=Random(4);Q[Y]:=Sin(A)*D;W[Y]:=Cos(A)*D;End;
  For X:=1to 10do For Y:=1 to 20do Begin
   PR[Y]:=PR[Y]+W[Y];PS[Y]:=PS[Y]+Q[Y];
   PutLn(Trunc(CX),Trunc(CY)+4,Trunc(CX+PR[Y]),Trunc(CY-PS[Y]),KrExplos[Y and 3]);
  End;
 End;
End;

Var K:Wd;

BEGIN
 Randomize;
 InitSystems(suIsabel);
 SetVideoModeDeluxe(vmGrf320x200c256);
 Repeat
  InitScr;
  Play;
  ClrKbd;
 Until Not YesNo('Une nouvelle partie?');
 FadeOut;
 DoneLuxeVideo;
 DoneSystems;
END.