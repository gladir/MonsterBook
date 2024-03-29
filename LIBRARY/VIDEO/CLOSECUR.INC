{CloseCursor.Inc}

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

{$IFNDEF __CloseCur}
 {$DEFINE __CloseCur}

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴콘
 �                         Proc괺ure CloseCur                         �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複蔔


 Description
 袴袴袴袴袴�

  Cette proc괺ure permet d'effacer le curseur de l'괹ran de style texte
 ou d'une fen늯re Windows (si compiler en mode Windows).


 Remarques
 袴袴袴袴�

  � La directive de compilation 췇ios� permet d'utiliser la technique du
    Bios pour efface le curseur.

  � La  directive  de  compilation  conditionnelle  췏nLineASM�   permet
    l'int괾ration directe d'assembleur ne terminant pas imm괺iatement ou
    que vous souha똳ez reb긲isser cette fonction sous un autre nom.

  � Est pr굒u pour fonctionner avec l'unit�  "Systex"  comme ent늯e pour
    la d괽inition des constantes du micro-processeur.

  � Elle  supporte  le  mode  R괻l,  DPMI (mode prot괾� dynamique...) et
    Windows (environnement multi-fen늯re multi-t긟he).
}

{$IFNDEF InLineASM}
 {$IFNDEF NotVoid}
  Procedure CloseCur;{$IFNDEF MACRO}Assembler;{$ENDIF}
 {$ENDIF}
 {$IFDEF MACRO}
  InLine($B4/$01/     { Mov Ah,01h }
         $B9/$20/$20/ { Mov CX,2020h }
	 $CD/$10);    { Int 10h }
 {$ELSE}
  ASM
  {$IFDEF Windows}
   {$IFOPT G+}
    PUSH False
   {$ELSE}
    MOV AX,False
    PUSH AX
   {$ENDIF}
   CALL ShowCursor { ShowCursor(False) }
  {$ELSE}
   {$IFDEF Bios}
    MOV CX,2020h
    MOV AH,01h
    INT 10h
   {$ELSE}
    {$IFDEF PortColor}
     MOV DX,3D4h
    {$ELSE}
     {$IFDEF PortMono}
      MOV DX,3B4h
     {$ELSE}
      {$IFDEF DPMI}
       MOV ES,Seg0040
       MOV DX,ES:[63h]
      {$ELSE}
       {$IFOPT G+}
        PUSH 0
        POP ES
       {$ELSE}
        XOR AX,AX
        MOV ES,AX
       {$ENDIF}
       MOV DX,ES:[463h]
      {$ENDIF}
     {$ENDIF}
    {$ENDIF}
    MOV AX,200Ah
    OUT DX,AX
    INC AL
    OUT DX,AX
    MOV AL,20h
    {$IFNDEF NoUpDateInRamBios}
     {$IFDEF DPMI}
      MOV ES:[60h],AX
     {$ELSE}
      MOV ES:[460h],AX
     {$ENDIF}
    {$ENDIF}
   {$ENDIF}
  {$ENDIF}
  {$IFNDEF InLineASM}
   END;
  {$ENDIF}
 {$ENDIF}
{$ENDIF}

{$ENDIF}