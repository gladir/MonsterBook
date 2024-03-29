{KeyPress.Inc}

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
 �                 Malte Genesis/Biblioth둸ue individuel                 �
 �                    릁ition Chantal/IV - Version 1.1                   �
 �                             1997/04/01                                �
 �                                                                       �
 �         Tous droits r굎erv굎 par les Chevaliers de Malte (C)          �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�


 Nom des programmeurs
 袴袴袴袴袴袴袴袴袴袴

  Sylvain Maltais


 Description
 袴袴袴袴袴�

  Cette inclusion vise  � permettre une universialisation des donn괻s �
 compiler  ind굋endament  des conditions  sous  lequel  la fonction est
 tra똳er.  En centralisant toutes les proc괺ures au m늤e point central,
 on aboutira une technique de 췈roiser�, celle-ci permet d'굃iminer les
 bugs par le raisonnement suivant:Maintenant sa fonctionne parfaitement
 ou sa plante comme jamais avant...
}

{$IFNDEF __KeyPress}
 {$DEFINE __KeyPress}

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
 �                              Fonction KeyPress                          �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�


 Description
 袴袴袴袴袴�

  Cette fonction retourne la valeur True si le tampon clavier � au moins une
 touche en r굎erve et dans le cas contraire False.


 Remarque
 袴袴袴袴

   � Voici son code en langage Pascal s'il s'agit du mode r괻l:
    旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
    � Function Keypressed:Boolean;                                         �
    � Begin                                                                �
    �  Inline($FA); (* CLI *)                                              �
    �  Keypressed:=MemW[$0040:$1A]<>MemW[$0040:$1C];                       �
    �  Inline($FB); (* STI *)                                              �
    � End;                                                                 �
    읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
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