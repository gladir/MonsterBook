{KeyPress.Inc}

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

{$IFNDEF __KeyPress}
 {$DEFINE __KeyPress}

{���������������������������������������������������������������������������
 �                              Fonction KeyPress                          �
 ���������������������������������������������������������������������������


 Description
 �����������

  Cette fonction retourne la valeur True si le tampon clavier � au moins une
 touche en r�serve et dans le cas contraire False.


 Remarque
 ��������

   � Voici son code en langage Pascal s'il s'agit du mode r�el:
    ����������������������������������������������������������������������Ŀ
    � Function Keypressed:Boolean;                                         �
    � Begin                                                                �
    �  Inline($FA); (* CLI *)                                              �
    �  Keypressed:=MemW[$0040:$1A]<>MemW[$0040:$1C];                       �
    �  Inline($FB); (* STI *)                                              �
    � End;                                                                 �
    ������������������������������������������������������������������������
}

Function KeyPress:Boolean;Assembler;ASM
 {$IFDEF Dos}
  MOV AH,0Bh
  INT 21h
  AND AL,1
 {$ELSE}
  {$IFDEF Bios}
   MOV AX,1
   INT $16
   MOV AL,No
   JZ  @@End
   MOV AL,Ya
  {$ELSE}
   {$IFDEF DPMI}
    XOR AX,AX
    MOV ES,Seg0040
    MOV DX,ES:[1Ah]
    MOV BX,ES:[1Ch]
   {$ELSE}
    XOR AX,AX
    MOV ES,AX
    {$IFNDEF NoCLI}
     CLI
    {$ENDIF}
    LES DX,ES:[41Ah]
    {$IFNDEF NoCLI}
     STI
    {$ENDIF}
    MOV BX,ES
   {$ENDIF}
   CMP BX,DX
   JE  @@End
   MOV AL,True
  {$ENDIF}
 {$ENDIF}
@@End:
END;

{$ENDIF}