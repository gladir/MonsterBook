{DuplHand.Inc}

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

{$IFNDEF __DuplHandle}
 {$DEFINE __DuplHandle}

 {��������������������������������������������������������������������
  �                          Fonction DuplHandle                     �
  ��������������������������������������������������������������������


  Description
  �����������

   Cette focntion permet d'attribuer un autre Handle � un fichier d�j�
  ouvert par un handle.
 }

 Function DuplHandle(Handle:Hdl):Hdl;Assembler;ASM
  MOV BX,Handle
  CMP BX,errHdl
  JE  @2
  MOV AH,45h
  INT 21h
  JNC @2
  MOV SysErr,AX
  XOR AX,AX
 @2:
 END;

{$ENDIF}