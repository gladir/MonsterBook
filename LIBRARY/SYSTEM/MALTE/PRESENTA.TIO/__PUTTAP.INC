{__PutTap.Inc}

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
 �                 Malte Genesis/Biblioth둸ue individuel                 �
 �                    릁ition Chantal/IV - Version 1.1                   �
 �                             1994/01/01                                �
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


 Remarque
 袴袴袴袴

  � Ce fichier  d'inclusion est  un  compl굆ent  �  la  proc괺ure  d굁�
    existante  췗utTapis�,  il ne  s'agit donc  que  d'un  ajoute  pour
    faciliter la vie du programmeur.
}

{$IFNDEF ____PutTapis}
 {$DEFINE ____PutTapis}

 {$I \Source\Chantal\Library\System\Malte\Presenta.tio\PutTapis.Inc}

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
 �                           Proc괺ure __PutTapis                          �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�


 Description
 袴袴袴袴袴�

  Cette proc괺ure affiche une tapiserie de fond en mode texte pour permettre
 de ne pas voir directement le fond de l'괹ran.  Il s'adapte en fonction des
 police de caract둹es  supporter  par les cartes vid굊 ou non.  Il permet de
 chosir s굋ar굆ent  les   2 couleurs de fond  et de surface  de la tapiserie
 contrairement � sa procr괶trice.
}

Procedure __PutTapis(Y1,Y2,Background,Foreground:Byte);Begin
 PutTapis(Y1,Y2,(Background shl 4)+Foreground)
End;

{$ENDIF}