{\Source\Chantal\Malte\Volume\ExecAdel.Inc}

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
 �                 Malte Genesis/Biblioth둸ue individuel                 �
 �                      릁ition Ad둳e/IV - Version 1.1                   �
 �                             1998/07/08                                �
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

{$IFNDEF __ExecAdele}
 {$DEFINE __ExecAdele}

{ Cette enregistrement est le format Standard du Malte Genesis V: Ad둳e
 d'un item de fichier interne  se trouvant  dans l'ex괹utable lui-m늤e.
 Le d괷ut de l'entr괻 se nomme:  췉륛UT� et le dernier se nomme: 췋IN�.
 La table des mati둹es est � l'envers.
}

Type FileItemAdele=Record
 AbsolutePosition:LongInt; { Position absolue dans l'ex괹utable }
 Size:LongInt;             { Taille du fichier interne }
 Name:String[39];          { Nom du fichier interne }
End;

{$ENDIF}