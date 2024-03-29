{\Source\Chantal\Library\Memories\Real\ResPara.Inc}

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
 �                 Malte Genesis/Biblioth둸ue individuel                 �
 �                    릁ition Chantal/IV - Version 1.1                   �
 �                             1998/01/14                                �
 �                                                                       �
 �         Tous droits r굎erv굎 par les Chevaliers de Malte (C)          �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�


 Nom des programmeurs
 袴袴袴袴袴袴袴袴袴袴

  Michael Tischer
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

{$IFNDEF __ResPara}
 {$DEFINE __ResPara}

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴콘
 �                           Fonction ResPara                         �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複蔔


 Description
 袴袴袴袴袴�

  Cette fonction calcule et retourne le nombre de paragraphes � allouer
 au programme r굎ident.


 Remarques
 袴袴袴袴�

  � Cette fonction ne s'applique quand mode r괻l sous DOS et n'a pas de
    signification en soi en mode prot괾�, DPMI,...

  � Cette fonction est tir괻 de m굏hode  de programmation  de programme
    r굎ident tra똳� par Michael Tischer dans la Bible du PC. Elle n'est
    en fait qu'un am굃ioration plus ouvert d'esprit.
}

Function ResPara:Word;Begin
 {$IFNDEF DPMI}
  {$IFDEF VER50}{ Pour Turbo Pascal Version 5.0 }
   ResPara:=Seg(FreePtr^)+$1000-PrefixSeg;
  {$ENDIF}
  {$IFDEF VER55}{ Pour Turbo Pascal Version 5.5 }
   ResPara:=Seg(FreePtr^)+$1000-PrefixSeg;
  {$ENDIF}
  {$IFDEF VER60}{ Pour Turbo Pascal Version 6.0 }
   ResPara:=Seg(HeapEnd^)-PrefixSeg;
  {$ENDIF}
  {$IFDEF VER70}{ Pour Turbo Pascal Version 7.0 }
   ResPara:=Seg(HeapEnd^)-PrefixSeg;
  {$ENDIF}
 {$ENDIF}
End;

{$ENDIF}