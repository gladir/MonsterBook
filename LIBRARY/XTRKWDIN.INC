{XtrkWdIn.Inc}

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
 �                 Malte Genesis/Biblioth둸ue individuel                 �
 �                    릁ition Chantal/IV - Version 1.1                   �
 �                             1997/04/01                                �
 �                                                                       �
 �         Tous droits r굎erv굎 par les Chevaliers de Malte (C)          �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�


 Nom des programmeurs
 袴袴袴袴袴袴袴袴袴袴

  Sylvain Maltais


 Description
 袴袴袴袴袴�

  Cette inclusion vise  � permettre une universialisation des donn괻s �
 compiler  ind굋endament  des conditions  sous  lequel  la fonction est
 tra똳er.  En centralisant toutes les proc괺ures au m늤e point central,
 on aboutira une technique de 췈roiser�, celle-ci permet d'굃iminer les
 bugs par le raisonnement suivant:Maintenant sa fonctionne parfaitement
 ou sa plante comme jamais avant...
}

{$IFNDEF XtrkWdInStr}
 {$DEFINE XtrkWdInStr}

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴콘
 �                         Function XtrkWdInStr                         �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複蔔


 Description
 袴袴袴袴袴�

  Cette fonction cherche dans une cha똭e de caract둹e de format Pascal un
 nombre d굏erminer par 췕m� de variable de style enti둹e (Mot ou "Word").
 Ceci 굒itant une duplication de 3 ou 4 proc괺ures identique de processus
 en s굍ie.  Il retourne la position  � laquel il rendant la cha똭e par la
 poursuite par un autre d'une extraction d'information.
}

Function XtrkWdInStr(Const S:String;Nm:Wd;Var Buffer:Array of PWord):Byte;Near;Var I,LI:Byte;J,X:Wd;Begin
 I:=1;
 If StrI(1,S)in[':',';']Then Inc(I);
 For J:=0to Nm-1do Begin
  SkipSpcInLn(I,S);LI:=I;X:=StrToWord(XtrkDecNm(I,S));
  If(LI=I)Then Begin
   For J:=I to Nm-1do Buffer[J]^:=0;
   XtrkWdInStr:=0;
   Break;
  End
   Else
  Buffer[J]^:=X;
  SkipSpcInLn(I,S);
  If StrI(I,S)=','Then Inc(I);
 End;
 XtrkWdInStr:=I;
End;

{$ENDIF}