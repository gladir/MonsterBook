{Library\Memories\EMS\Open.Inc}

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

{$IFNDEF __OpenEMS}
 {$DEFINE __OpenEMS}

{��������������������������������������������������������������������
 �                          Fonction Open                           �
 ��������������������������������������������������������������������


 Description
 �����������

  Cette fonction permet � un programme de se faire allouer un certain
 nombre de pages (de 16 Ko) d'EMS pour ses op�rations.
}

Function Open(Number:Word):Word;Assembler;ASM
 MOV AH,43h
 MOV BX,Number
 INT 67h
 {$IFDEF SaveError}
  MOV EmsErr,AH
 {$ENDIF}
 XCHG AX,DX
END;

{$ENDIF}