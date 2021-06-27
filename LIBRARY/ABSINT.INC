{AbsInt.Inc}

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

{$IFNDEF __AbsInt}
 {$DEFINE __AbsInt}

{������������������������������������������������������������������������
 �                             Fonction AbsInt                          �
 ������������������������������������������������������������������������


 Description
 �����������

  Cette fonction retourne la valeur absolue de la valeur enti�re contenue
 dans la variable de param�trage �I�.


 Remarques
 ���������

  � Attention!  Cette fonction ne supporte en aucun cas les �LongInt�, et
    vous devrez  donc  utilise la fonction  �Abs�  d'origine dans l'unit�
    �SYSTEM� du compilateur pour avoir ce m�me effet.

  � Utilisez la directive de compilation conditionnel  �Compatible�  pour
    indiquer  �  la  proc�dure  qu'il  doit  utiliser  une  technique  de
    compatibilit� ind�pendament  de la taille d'une variable enti�re  (si
    vous pr�f�rez, ayant une taille pouvant �tre diff�rente de 2 octets).
}

Function AbsInt(I:Integer):Integer;Assembler;ASM
 {$IFDEF __386__}
  OR AX,AX
  JGE @1
  NEG AX
@1:
 {$ELSE}
  {$DEFINE Compatible}
   MOV AX,I
   {$IFDEF Compatible}
    OR  AX,AX { Ceci c'est la m�thode "Schtroumpf" international de }
    JGE @1    { compatibilit�...}
    NEG AX
 @1:
   {$ELSE}
    AND AX,$7FFF
  {$ENDIF}
 {$ENDIF}
END;

{$ENDIF}