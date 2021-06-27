{ReadKey.Inc}

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

{$IFNDEF __ReadKey}
 {$DEFINE __ReadKey}

{�������������������������������������������������������������������������
 �                             Fonction ReadKey                          �
 �������������������������������������������������������������������������


 Description
 �����������

  Cette fonction permet d'extraire une touche du tampon clavier. Si aucune
 touche n'attend,  il attendra quand m�me que l'utilisateur en est frapper
 une et pendant le temps qu'il attend,  effectuera des processus d'arri�re
 plan.
}

Function ReadKey:Word;Assembler;ASM
 {$IFDEF Bios}
  {$IFOPT G+}
   MOV AX,$1000
  {$ELSE}
   XOR AX,AX
  {$ENDIF}
  INT $16
 {$ELSE}
  {$IFDEF DPMI}
   MOV ES,Seg0040
  {$ELSE}
   MOV AX,0040h
   MOV ES,AX
  {$ENDIF}
  {$IFNDEF NoCLI}
   CLI
  {$ENDIF}
  MOV BX,ES:[1Ah]
  MOV AX,ES:[BX]
  CMP AL,0E0h
  JE  @@NotOk
  CMP AL,0D0h
  JNE @@Ok
@@NotOk:
  CMP AH,0
  JE  @@Ok
  MOV AL,0
@@Ok:
  INC BX
  INC BX
  MOV ES:[1Ah],BX
  MOV CX,ES:[82h]
  CMP CX,BX
  JNE @End
  MOV CX,ES:[80h]
  MOV ES:[1Ah],CX
@End:
  {$IFNDEF NoCLI}
   STI
  {$ENDIF}
 {$ENDIF}
END;

{$ENDIF}