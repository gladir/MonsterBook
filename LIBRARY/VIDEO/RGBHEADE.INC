{\Source\Chantal\Library\Video\RGBHeader.Inc}

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
 �                                                                       �
 �                 Malte Genesis/Biblioth둸ue individuel                 �
 �                    릁ition Chantal/IV - Version 1.1                   �
 �                                                                       �
 �     Tous droits r굎erv굎 par les Chevaliers de Malte XXIe si둩le      �
 �                                                                       �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�


 Nom des programmeurs
 袴袴袴袴袴袴袴袴袴袴

  Joseph Gabriel Sylvain Maltais


 Description
 袴袴袴袴袴�

  Cette inclusion vise  � permettre une universialisation des donn괻s �
 compiler  ind굋endament  des conditions  sous  lequel  la fonction est
 tra똳er.  En centralisant toutes les proc괺ures au m늤e point central,
 on aboutira une technique de 췈roiser�, celle-ci permet d'굃iminer les
 bugs par le raisonnement suivant:Maintenant sa fonctionne parfaitement
 ou sa plante comme jamais avant...
}

{$IFNDEF __RGBHeader}
 {$DEFINE __RGBHeader}

Type
 (***************************************************************)
 (* D괽inition de manipulation des composantes: Rouge/Vert/Bleu *)
 (***************************************************************)

 {Palette RVB (RGB) }
 RGB=Record
  R:Byte;                       { (R)ouge ((R)ed) }
  G:Byte;                       { (V)ert  ((G)reen) }
  B:Byte;                       { (B)leu  ((B)lue) }
 End;

  { Palette de 16 couleurs RVB (RGB) pour EGA, MCGA, VGA et Super VGA }
 Palette16RGB=Array[0..15]of RGB;

  { Palette de 256 couleurs RVB (RGB) pour MCGA, VGA et Super VGA }
 Palette256RGB=Array[Byte]of RGB;

  { Tableau de palette de couleurs RVB (RGB) }
 TRGB=Array[0..65520div SizeOf(RGB)]of RGB;
{$ENDIF}