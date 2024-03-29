{\Source\Chantal\Library\Files\Images\FlbEntry.Inc}

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
 �                 Malte Genesis/Biblioth둸ue individuel                 �
 �                    릁ition Chantal/IV - Version 1.1                   �
 �                             1998/03/15                                �
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

{$IFNDEF __FLBEntry}
 {$DEFINE __FLBEntry}

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
 �                       Enregistrement FLBEntry                       �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�


 Description
 袴袴袴袴袴�

  Cette enregistrement est le format  d'une entr괻 d'un fichier  "*.FLB"
 (Font LiBrary) du NewsMaster (un tra똳ement de texte dat괻 de 1986 avec
 multi-dimension polices de caract둹es)  version 1.0 d'Unison World, une
 division de  Kyocera Unison.  Cette  enregistrement  � une taille de 80
 octets  et  commence  imm괺iatement  au  d괷ut  du  fichier sans ent늯e
 d'identification sinon son extension "FLB".


 Remarques
 袴袴袴袴�

  � Les polices de cette biblioth둸ue sont monochromes ou en 2 couleurs,
    il ne supporte pas directement d'autres 괹ran que ceux-ci.

  � Dans le fichier  d'origine o�  l'exp굍imentation  de d괹ompilation a
    굏�,  il n'y avait que 34 enregistrements  d'ent늯e et le fichier se
    nommait 췕EWS.FLB�.
}

Type FLBEntry=Record
 Data1:Array[0..5]of Byte;    { Donn괻s r굎erv�??? Possiblement 3 mots... }
 PosAbs:LongInt;              { Position absolue dans le fichier de l'image}
                              { suivit par la police (256+SizeImg). Dans la}
                              { partie de taille de 256 caract둹es, il }
                              { contient une table de 128 mots contenant}
                              { des adresses de chacun des 128 caract둹es}
                              { contenu dans cette police.}
 Name:Array[0..49]of Char;    { Nom de la police de caract둹e }
 SizeImg:Word;                { Taille de l'image }
 Data2:Array[62..75]of Byte;  { Donn괻s r굎erv�??? }
 Height:Word;                 { Hauteur des caract둹es }
 Data3:Word;                  { Donn괻s r굎erv�??? }
End;

{$ENDIF}