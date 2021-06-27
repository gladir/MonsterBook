{LShiftPress.Inc}

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

{$IFNDEF __LShiftPress}
 {$DEFINE __LShiftPress}

{����������������������������������������������������������������������������
 �                             Fonction LShiftPress                         �
 ����������������������������������������������������������������������������


 Description
 �����������

  Cette fonction retourne une valeur indiquant si la touche �Shift� de gauche
 est enfonc� par True ou non par la False.
}

Function LShiftPress:Boolean;Assembler;ASM
 {$IFDEF Bios}
  MOV AH,02h
  INT 16h
 {$ELSE}
  {$IFDEF DPMI}
   PUSH Seg0040
   POP ES
   CLI
   MOV AL,ES:[17h]
   STI
  {$ELSE}
   XOR AX,AX
   MOV ES,AX
   {$IFNDEF NoCLI}
    CLI
   {$ENDIF}
   MOV AL,ES:[417h]
   {$IFNDEF NoCLI}
    STI
   {$ENDIF}
  {$ENDIF}
 {$ENDIF}
 AND AL,2
 JZ  @@End
 MOV AL,True
@@End:
END;

{$ENDIF}