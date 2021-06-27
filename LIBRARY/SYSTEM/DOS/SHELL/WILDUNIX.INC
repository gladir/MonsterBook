{Library\System\Dos\Shell\WildUnix.Inc}

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

{$IFNDEF __WildUnixShell}
 {$DEFINE __WildUnixShell}

{�����������������������������������������������������������������������
 �                        Fonction WildUnixShell                       �
 �����������������������������������������������������������������������


 Description
 �����������

  Cette fonction indique si l'extension de shell �WildUnix� est r�sident
 en m�moire.
}

Function WildUnixShell:Boolean;Assembler;ASM
 PUSH DS
  MOV AH,04Eh
  XOR DX,DX
  MOV DS,DX
  INT 21h
  XOR AL,AL
  CMP AH,099h
  JNE @1
  INC AX
@1:
 POP DS
END;

{$ENDIF}