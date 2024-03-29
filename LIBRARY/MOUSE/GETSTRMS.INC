{GetStrMs.Inc}

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

{$IFNDEF __GetStrMouse}
 {$DEFINE __GetStrMouse}

 {$I \Source\Chantal\Library\Mouse\BusType.Inc}
 {$I \Source\Chantal\Library\Mouse\GetMsVer.Inc}

 {旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
  �                       Fonction GetStrMouse                      �
  잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�


  Description
  袴袴袴袴袴�

   Cette fonction retourne une cha똭e de caract둹es contenant le nom,
  la marque et  la version du pilote de souris si elle  existe  sinon
  elle retourne un message de 췚ouris non-install궚.
 }

Function GetStrMouse:String;Var S,Marque:String;Begin
 If {$IFDEF Adele}Adele{$ELSE}Chantal{$ENDIF}.Mouse>0Then Begin
  Case(BusType)of
   $01: S:='Bus';
   $02: S:={$IFDEF ENGLISH}'Serie'{$ELSE}'S굍ie'{$ENDIF};
   $03: S:='Inport';
   $04: S:='PS/2';
   $05: S:='HP';
   Else If(VideoMousePortFound)Then S:={$IFDEF ENGLISH}'Serie on video card'{$ELSE}'S굍ie sur carte vid굊'{$ENDIF}
                               Else S:={$IFDEF ENGLISH}'Serie'{$ELSE}'S굍ie'{$ENDIF};
  End;
  Case({$IFDEF Adele}Adele{$ELSE}Chantal{$ENDIF}.Mouse)of
   msLogitech:Marque:=' Logitech';
   msMicrosoft:Marque:=' Microsoft';
   msSmooth:Marque:={$IFDEF ENGLISH}' Smooth of Andy Hakim'{$ELSE}' Smooth d''Andy Hakim'{$ENDIF};
   msZNIX:Marque:=' Z-NIX';
   msGenius:Marque:=' Genius';
   Else Marque:='';
  End;
  GetStrMouse:={$IFDEF ENGLISH}'Mouse '{$ELSE}'Souris '{$ENDIF}+S+Marque+', Version '+GetMsVer;
 End
  Else
 GetStrMouse:={$IFDEF ENGLISH}'Mouse not found'{$ELSE}'Souris non-install�'{$ENDIF};
End;

{$ENDIF}