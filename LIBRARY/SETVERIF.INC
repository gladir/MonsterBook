{\Source\Chantal\Library\SetVerif.Inc}

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

{$IFNDEF __SetVerify}
 {$DEFINE __SetVerify}

{������������������������������������������������������������������������
 �                           Proc�dure SetVerify                        �
 ������������������������������������������������������������������������


 Description
 �����������

  Cette proc�dure fixe l'�tat du drapeau de v�rification des lectures/
 �criture disque du syst�me d'exploitation.
}

 Procedure SetVerify(Verify:Boolean);Assembler;ASM
  MOV AL,Verify
  MOV AH,2Eh
  INT 21h
 END;

{$ENDIF}