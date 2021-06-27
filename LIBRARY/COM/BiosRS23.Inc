{BiosRS23.Inc}

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

{$IFNDEF __BiosRS232Init}
 {$DEFINE __BiosRS232Init}

{�������������������������������������������������������������������������
 �                         Proc�dure BiosRS232Init                       �
 �������������������������������������������������������������������������


 Description
 �����������

  Cette proc�dure initialise un port s�rie par l'entremise des services du
 Bios par l'interruption 14h.
}

Procedure BiosRS232Init(ComPort:Integer;ComParm:Word);Assembler;ASM
 {$IFDEF __386__}
  MOVZX AX,Byte Ptr ComParm
 {$ELSE}
  MOV AL,Byte Ptr ComParm
  MOV AH,0
 {$ENDIF}
 MOV DX,Word Ptr ComPort
 INT 14h
END;

{$ENDIF}