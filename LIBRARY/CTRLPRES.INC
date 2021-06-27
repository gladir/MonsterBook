{CtrlPress.Inc}

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

{$IFNDEF __CtrlPress}
 {$DEFINE __CtrlPress}

{������������������������������������������������������������������������
 �                          Fonction CtrlPress                          �
 ������������������������������������������������������������������������


 Description
 �����������

  Cette fonction retourne une valeur indiquant si une/deux touche(s) Ctrl
 est/sont enfonc�(s) (True) ou aucun (False).
}

{$IFNDEF NoVoid}
 Function CtrlPress:Boolean;Assembler;
{$ENDIF}
ASM
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
 AND AL,4
 JZ @@End
 MOV AL,True
@@End:
END;

{$ENDIF}