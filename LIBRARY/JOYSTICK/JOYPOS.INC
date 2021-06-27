{JoyPos.Inc}

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

{$IFNDEF __JoyPos}
 {$DEFINE __JoyPos}

Function JoyPos(Axe:Byte):Word;Assembler;ASM
 {$IFDEF Bios}
  MOV AH,$84
  MOV DX,$1
  INT $15
  CMP Axe,0
  JE  @@End
  MOV BX,AX
  CMP Axe,1
  MOV CX,AX
  CMP Axe,2
  JE  @@End
  MOV DX,AX
@@End:
 {$ELSE}
  MOV CL,Axe
  MOV BX,1
  SHL BX,CL
  MOV CX,$FFFF
  XOR AX,AX
  XOR SI,SI
  MOV DX,$0201
  CLI
  OUT DX,AL
@@Next:
  IN   AL,DX
  TEST AL,BL
  JE   @@Done
  INC  SI
  LOOP @@Next
@@Done:
  STI
  MOV AX,SI
@@End:
 {$ENDIF}
END;

{$ENDIF}