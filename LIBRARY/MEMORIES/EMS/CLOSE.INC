{Library\Memories\EMS\Close.Inc}

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

{$IFNDEF __CloseEMS}
 {$DEFINE __CloseEMS}

{��������������������������������������������������������������������������
 �                             Proc�dure Close                            �
 ��������������������������������������������������������������������������


 Description
 �����������

  Cette fonction permet de restituer � l'EMS et de rendre ainsi accessibles
 �  d'autres  programmes  les  pages  pr�c�demment  allou�es  �  l'aide  de
 l'interruption 67h, fonction 43h (soit la fonction �New�).
}

Procedure Close(Handle:Word);Assembler;ASM
 MOV AH,45h
 MOV DX,Handle
 INT 67h
 {$IFDEF SaveError}
  MOV EmsErr,AH
 {$ENDIF}
END;

{$ENDIF}