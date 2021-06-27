{SetBlock.Inc}

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

{$IFNDEF __SetBlock}
 {$DEFINE __SetBlock}

(*�������������������������������������������������������������������
  �                       Fonction SetBlock                         �
  �������������������������������������������������������������������

  Description
  �����������

   Cette fonction change la taille d'une allocation m�moire effectuer
  pr�c�demment par le syst�me d'exploitation DOS ou compatible.
*)

Function SetBlock(SegX,NewSize:Word):Integer;Assembler;ASM
 MOV AH,4Ah
 MOV BX,NewSize
 MOV ES,SegX
 INT 21h
 JC  @SetBlockFailed
 MOV AX,-1
 JMP @End
@SetBlockFailed:
 XCHG AX,BX
@End:
END;

{$ENDIF}