{DirExist.Inc}

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

{$IFNDEF __DirExist}
 {$DEFINE __DirExist}

{$I \Source\Chantal\Library\AddStr.Inc}
{$I \Source\Chantal\Library\IsWildCard.Inc}
{$I \Source\Chantal\Library\Path2Dir.Inc}

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
 �                           Fonction DirExist                         �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�


 Description
 袴袴袴袴袴�

  Cette  fonction  indique  si le r굋ertoire sp괹ifi� par la variable de
 param굏rage existe. Si la cha똭e de caract둹es est vide, elle consid굍�
 comme  un  r굋ertoire  valide.  릆alement,  s'il s'agit d'un  suite  de
 r굋ertoire, seul la partie avant le premier point virgule est tester.
}

Function DirExist(Dir:String):Bool;Var Rec:SearchRec;Begin
 If Length(Dir)=0Then DirExist:=Ya
  Else
 Begin
  {$IFDEF Chantal}
   TruncAfterSemicolon(Dir);
  {$ENDIF}
  If Dir[Length(Dir)]='\'Then AddStr(Dir,'*.*')Else
  If IsWildCard(Dir)Then Dir:=Path2Dir(Dir)+'*.*';
  FindFirst(Dir,faDir,Rec);
  DirExist:=DosError=0
 End;
End;

{$ENDIF}