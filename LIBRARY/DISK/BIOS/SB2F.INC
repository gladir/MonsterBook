{Library\Disk\Bios\SB2F.Inc}

{�������������������������������������������������������������������������
 �                 Malte Genesis/Biblioth�que individuel                 �
 �                    �dition Chantal/IV - Version 1.1                   �
 �                             1997/04/01                                �
 �                                                                       �
 �         Tous droits r�serv�s par les Chevaliers de Malte (C)          �
 �������������������������������������������������������������������������


 Nom des programmeurs
 ��������������������

  Sylvain Maltais


 Description
 �����������

  Cette inclusion vise  � permettre une universialisation des donn�es �
 compiler  ind�pendament  des conditions  sous  lequel  la fonction est
 tra�ter.  En centralisant toutes les proc�dures au m�me point central,
 on aboutira une technique de �Croiser�, celle-ci permet d'�liminer les
 bugs par le raisonnement suivant:Maintenant sa fonctionne parfaitement
 ou sa plante comme jamais avant...
}

{$IFNDEF __CheckSB2F}
 {$DEFINE __CheckSB2F}

 {$I \Source\Chantal\Library\Memories\Rom\ReadROM.Inc}

{����������������������������������������������������������������������
 �                           Fonction CheckSB2F                       �
 ����������������������������������������������������������������������

  Descripton
  ����������

   Cette fonction teste la pr�sence du �Super Bios II Formatter�. Si le
  BIOS est d�tect� la valeur retourn� est TRUE sinon,  s'il est absent,
  il retourne FALSE.


  Remarques
  ���������

   � Cette fonction teste est destin�  au disque dur MFM ayant une BIOS
     suppl�mentaire contenant le �SuperBios II Formatter�.

   � L'adresse de la signature  se trouve � l'adresse  C800h:14F9h et �
     une longueur de  22 octets.  Sa date est  situ� � l'adresse C800h:
     153Eh et � une  longueur  de 3 octets,  sa version est  contenue �
     l'adresse  C800h:1516h  et � une longueur  de 2 octets,  enfin son
     mod�le  est situ�  � l'adresse  C800h:1528h  et � une  longueur de
     15 octets.
 }

 Function CheckSB2F:Boolean;Begin
  CheckSB2F:=ReadROM($C800,$14F9,22)='Super Bios II Formatter';
 End;

{$ENDIF}