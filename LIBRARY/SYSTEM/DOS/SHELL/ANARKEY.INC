{Library\System\Dos\Shell\Anarkey.Inc}

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

{$IFNDEF __AnarkeyShell}
 {$DEFINE __AnarkeyShell}

{�����������������������������������������������������������������������
 �                          Fonction AnarkeyShell                      �
 �����������������������������������������������������������������������


 Description
 �����������

  Cette fonction permet de savoir si le Shell d'Anarkey est pr�sentement
 en m�moire et s'il est actif ou inactif.  Pour ce faire il retourne une
 valeur selon le format suivant:
 ���������������������������������������������������������������������Ŀ
 � Valeur     � Description                                            �
 ���������������������������������������������������������������������͵
 �  00h       � Absent, n'est pas en m�moire s�r et certain!           �
 �  FEh       � Il est pr�sent mais n'est pas actif, en mode suspendu. �
 �  FFh       � Il est pr�sent et actif, en op�ration.                 �
 �  autrement � Erreur, inconnu,...?                                   �
 �����������������������������������������������������������������������
}

Function AnarkeyShell:Byte;
{$IFDEF Macro}
 InLine($B8/$00/$E3/ { MOV AX,0E300h }
        $CD/$2F);    { INT 2Fh }
{$ELSE}
 Assembler;ASM
  MOV AX,0E300h
  INT 2Fh
 END;
{$ENDIF}

{$ENDIF}