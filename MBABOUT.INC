{$I DEF.INC}

Procedure About;

{컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�}
                              IMPLEMENTATION
{컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�}

Uses
 Adele,Systex,Systems,Dials,
 ResServI,Dialex
 {$IFDEF FullVersion}
  ,MBCortex
 {$ENDIF}
 {$IFDEF BureauVersion}
  ,MBBCrtex
 {$ENDIF};

Type
 FormAbout=Record
  W:Window;
  {$IFNDEF Small}
   W2:Window;
  {$ENDIF}
  OldBackKbd:Procedure; { Autre processus � ex괹uter }
  GX1,GY1:Word;
  OldTime:Byte;
  Image:Array[0..255]of Byte;
 End;

Procedure Anim;Far;
Var
 Form:^FormAbout Absolute CurrForm;
 Time:Byte;
Begin
 Form^.OldBackKbd;
 Time:=(GetRawTimerB and$F)shr 1;
 If(Form^.OldTime<>Time)Then Begin
  Case(Time)of
   0:SetPixel(Form^.GX1+3,Form^.GY1+3,White);
   1:Begin
    PutLine(Form^.GX1+3,Form^.GY1+2,Form^.GX1+3,Form^.GY1+5,White);
    ClrLnHor(Form^.GX1+2,Form^.GY1+3,5,White);
   End;
   2:Begin
    PutLine(Form^.GX1+3,Form^.GY1,Form^.GX1+3,Form^.GY1+7,White);
    ClrLnHor(Form^.GX1,Form^.GY1+3,8,White);
    PutLine(Form^.GX1+3,Form^.GY1+2,Form^.GX1+3,Form^.GY1+5,Yellow);
    ClrLnHor(Form^.GX1+2,Form^.GY1+3,5,Yellow);
    SetPixel(Form^.GX1+3,Form^.GY1+3,Black);
   End;
   3:Begin
    PutSmlImg(Form^.GX1,Form^.GY1,Form^.GX1+7,Form^.GY1+7,Form^.Image);
    Form^.GX1:=((Form^.W.T.X2-4)shl 3);
    If BitsPerPixel>=8Then Inc(Form^.GX1,Random(16))
                      Else Inc(Form^.GX1,Random(2)*8);
    Form^.GY1:=GetRawY(Form^.W.T.Y1+2)+Random(16);
    GetSmlImg(Form^.GX1,Form^.GY1,Form^.GX1+7,Form^.GY1+7,Form^.Image);
   End;
  End;
  Form^.OldTime:=Time;
 End;
End;

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴콘
 �                        Proc괺ure About                             �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複蔔


 Description
 袴袴袴袴袴�

  Cette proc괺ure affiche une bo똳e  de dialogue pour que l'utilisateur
 puisse conna똳re les informations pertinente con놽rnant l'application.


 Remarques
 袴袴袴袴�

  � Il s'adapte aussi bien 췔onsterBook�  qu'au 췗ower Hacken� dit 췗H�
    pour d굎igner le taux d'acidit� de l'eau.
}

Procedure About;
Var
 Q:FormAbout;
 I,L:Byte;
 {$IFNDEF Small}
  K:Word;
 {$ENDIF}

 {$I \Source\Chantal\Library\Security\MonsterB.ook\Serial.Inc}

Begin
 Randomize;
 WEInitO(Q.W,39,14);
 WEPushWn(Q.W);
 WEPutWnKrDials(Q.W,MessageByLanguage('A propos!쿌bout'));
 WECloseIcon(Q.W);
 WELn(Q.W);
 WEBar(Q.W);
 {$IFDEF FullVersion}
  If(ModePH)Then WEPutOTxt(Q.W,'Power Hacken (PH)')
            Else WEPutOTxt(Q.W,NamePrg);
 {$ELSE}
  WEPutOTxt(Q.W,NamePrg);
 {$ENDIF}
 WELn(Q.W);
 WEPutOTxt(Q.W,'Version '+VerPrg);
 WELn(Q.W);
 WEPutOTxt(Q.W,'Tous droits r굎erv굎 (c) par');
 WELn(Q.W);
 WEPutOTxt(Q.W,'Les Chevaliers de Malte');
 WELn(Q.W);
 WESetKr(Q.W,$E0);
 WEBarSpcHor(Q.W,1,9,wnMax-1);
 WEPutTxtXY(Q.W,1,9,'Num굍o de s굍ie: '+GetSerialUser(StrPas(RegUserName)));
 If(IsGrf)Then Begin
  _RIViewImage(MaltePath+'MBW.ICO',0,Q.W,1,1,GetRawY(4),$FFFF,0);
  {$IFNDEF Small}
   If(FX)Then Begin
    Q.GX1:=(Q.W.T.X2-4)shl 3;
    Q.GY1:=GetRawY(Q.W.T.Y1+2);
    GetSmlImg(Q.GX1,Q.GY1,Q.GX1+7,Q.GY1+7,Q.Image);
    CurrForm:=@Q;
    Q.OldBackKbd:=_BackKbd;_BackKbd:=Anim;
   End;
  {$ENDIF}
 End;
 {$IFDEF Small}
  While WEOk(W)do;
 {$ELSE}
  Repeat
   K:=WEGetkHorDn(Q.W,'Correcte|D굏ails');
   Case(K)of
    0,kbAbort:Break;
    1:Begin
     If(IsGrf)and(NmXTxts>=80)Then L:=77 Else L:=40;
     WEInitO(Q.W2,L,24);
     WEPushWn(Q.W2);
     WEPutWnKrDials(Q.W2,'A propos D굏aill�');
     WELn(Q.W2);
     WEBar(Q.W2);
     If Not(ModePH)Then WEForeground(Q.W2,Red);
     WEPutTxtLn(Q.W2,'Fabriqu� au:      Qu괷ec Libre!!!');
     WEPutTxtLn(Q.W2,'릀rit en:         Borland Pascal 7');
     WEPutTxtLn(Q.W2,'Lignes de code:   170 000 Pascal');
     WEPutTxtLn(Q.W2,'                  250 000 Assembleur');
     WEPutTxtLn(Q.W2,'Taille du Source: 25 MegaOctets');
     WEPutTxtLn(Q.W2,'Biblioth둸ues:    Malte Genesis IV');
     WEPutTxtLn(Q.W2,'                  Alias Chantal');
     WEPutTxtLn(Q.W2,'      & Extension Malte Genesis V');
     WEPutTxtLn(Q.W2,'                  Alias Ad둳e');
     WEPutTxtLn(Q.W2,'Date de frabric.: 1993 � 2001');
     WEPutTxtLn(Q.W2,'M굏hode de fabr.: La patience voyont!');
     WELn(Q.W2);
     WEPutTxtLn(Q.W2,'Programmeur/Concepteur/Analyste:');
     WELn(Q.W2);
     WEPutTxtLn(Q.W2,' Sylvain Maltais');
     WELn(Q.W2);
     WEPutTxtLn(Q.W2,'Infographie:');
     WELn(Q.W2);
     WEPutTxtLn(Q.W2,' Daniel Maltais');
     If L<>40Then Begin
      If(CountryCode=verUS)Then
       RIViewImage('SYS:ENGLISH.GIF',Q.W2,1,0,GetRawY(19),0)
      Else
       RIViewImage('SYS:FRANCAIS.GIF',Q.W2,1,0,GetRawY(19),0);
     End;
     While WEOk(Q.W2)do;
    End;
   End;
  Until False;
  If(IsGrf)and(FX)Then _BackKbd:=Q.OldBackKbd;
  WEDone(Q.W);
 {$ENDIF}
End;
