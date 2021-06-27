{\Source\Chantal\Library\Video\RGBHeader.Inc}

{�������������������������������������������������������������������������
 �                                                                       �
 �                 Malte Genesis/Biblioth�que individuel                 �
 �                    �dition Chantal/IV - Version 1.1                   �
 �                                                                       �
 �     Tous droits r�serv�s par les Chevaliers de Malte XXIe si�cle      �
 �                                                                       �
 �������������������������������������������������������������������������


 Nom des programmeurs
 ��������������������

  Joseph Gabriel Sylvain Maltais


 Description
 �����������

  Cette inclusion vise  � permettre une universialisation des donn�es �
 compiler  ind�pendament  des conditions  sous  lequel  la fonction est
 tra�ter.  En centralisant toutes les proc�dures au m�me point central,
 on aboutira une technique de �Croiser�, celle-ci permet d'�liminer les
 bugs par le raisonnement suivant:Maintenant sa fonctionne parfaitement
 ou sa plante comme jamais avant...
}

{$IFNDEF __RGBHeader}
 {$DEFINE __RGBHeader}

Type
 (***************************************************************)
 (* D�finition de manipulation des composantes: Rouge/Vert/Bleu *)
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