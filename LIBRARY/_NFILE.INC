{_nfile.Inc}

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

{$IFNDEF ___nfile}
 {$DEFINE ___nfile}

 {旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴콘
  �                            Fonction _nfile                           �
  잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複蔔


  Description
  袴袴袴袴袴�

   Cette fonction retourne le nombre  de Handle utiliser par l'application
  en cours, c'est-�-dire celle-ci.


  Remarque
  袴袴袴袴

   � Cette fonction vise un compatibilit� avec le langage de programmation
     C et C++.  Toutefois,  une contrainte existe,  en langage C et C++ il
     s'agit  d'une variable  et  ici  d'une  fonction,  donc impossible de
     changer sa valeur!
 }

 Function _nfile:Byte;
 {$IFDEF ___NmHandle}
  Begin;_nfile:=_NmHandle;End;
 {$ELSE}
  {$DEFINE NoVoid}
  {$I Library\System\Dos\_NmHandle.Inc}
  {$UNDEF NoVoid}
 {$ENDIF}

{$ENDIF}