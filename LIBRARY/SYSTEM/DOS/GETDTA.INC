{GetDTA.Inc}

(*�������������������������������������������������������������������������
  �                 Malte Genesis/Biblioth�que individuel                 �
  �                    �dition Chantal/IV - Version 1.1                   �
  �                             1997/10/12                                �
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
*)

{$IFNDEF __GetDTA}
 {$DEFINE __GetDTA}

(*���������������������������������������������������������������������
  �                         Fonction GetDTA                           �
  ���������������������������������������������������������������������


   Description
   �����������

    Cette fonction un pointeur sur la DTA du syst�me d'exploitation DOS.
*)

Function GetDTA:Pointer;Assembler;ASM
 MOV AH,02Fh
 INT 021h
 MOV DX,ES
 XCHG AX,BX
END;

{$ENDIF}