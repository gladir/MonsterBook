{_CpyFile.Inc}

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

{$IFNDEF ___CopyFile}
 {$DEFINE ___CopyFile}

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴콘
 �                      Fonction _CopyFile                      �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複蔔


 Description
 袴袴袴袴袴�

  Cette fonction copie un fichier d'un unit� � une autre, ou d'un
 r굋ertoire  � un autre.  Il retourne vrai  si l'op굍ation  c'est
 correctement d굍oul� ou faux si des probl둴es ont eu lieu.


 Remarques
 袴袴袴袴�

  � Cette fonction r괹lame un syst둴e d'exploitation compatible �
    un DOS version 2 ou post굍ieurs (datant de moins mars 1983)!

  � A la diff굍ence de la fonction parall둳e 췈opyFile�, celle-ci
    appelle  une proc괺ure virtuel  de progression  de la copie �
    mesure qu'elle s'effectue.
}

 Function _CopyFile(Const Source,Target:String;Proc:BackgroundCopy):Byte;
 {$DEFINE NoVoid}
 {$UNDEF __CopyFile}
 {$DEFINE Dialog}
 {$I Library\CopyFile.Inc}
 {$UNDEF Dialog}
 {$UNDEF NoVoid}

{$ENDIF}