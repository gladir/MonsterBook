{Library\System\Dos\Shell\KStack.Inc}

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

{$IFNDEF __KStack}
 {$DEFINE  __KStack}

{�������������������������������������������������������������������������
 �                              Fonction KStack                          �
 �������������������������������������������������������������������������


 Description
 �����������

  Cette fonction indique si le pilote �KStack� destin� au Shell du DOS est
 r�sident en m�moire.
}

Function KStack:Boolean;Assembler;ASM
 MOV AX,0D44Fh
 XOR BX,BX
 XOR CX,CX
 XOR DX,DX
 INT 2Fh
 XCHG AX,BX
 XOR AX,AX
 CMP BX,044DDh
 JNE @1
 INC AX
@1:
END;

{$ENDIF}