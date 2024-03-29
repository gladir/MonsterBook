{ShiftPress.Inc}

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

{$IFNDEF __ShiftPress}
 {$DEFINE __ShiftPress}

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
 �                          Fonction ShiftPress                        �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�


 Description
 袴袴袴袴袴�

  Cette fonction permet  de conna똳re  l'굏ats  des touches  췚hift�, si
 elles sont enfonc굎 ou non.  Le fait que ce soit la touche de droite ou
 de gauche, elle ne fait aucun diff굍ence entre les 2 et ne retourne pas
 une valeur sup굍ieur � vrai si les 2 sont enfonc괻s en m늤e temps.


 Remarques
 袴袴袴袴�

  � La directive de compilation 췇ios� permet d'utiliser la technique du
    Bios pour conna똳re l'굏at d'une des 2 touches "Shift" du clavier.

  � Si le compilateur  n'est  pas adapt�  au code  d'un micro-processeur
    80286  ou  post굍ieur  mais  que  vous  souha똳ez  avoir  ces  codes
    sp괹ifique  � ce processeur,  vous pouvez  d괽inir  la directive  de
    compilation conditionnel �__286__� pour permettre cette adaptation.

  � La directive de compilation conditionnelle 췕oCLI�  permet d'omettre
    les  instructions  assembleur  "CLI"  et  "STI"  dans vos situations
    particuli둹e critique...

  � La  directive  de  compilation  conditionnelle  췏nLineASM�   permet
    l'int괾ration directe d'assembleur ne terminant pas imm괺iatement ou
    que vous souha똳ez reb긲isser cette fonction sous un autre nom.

  � Est pr굒u pour fonctionner avec l'unit�  "Systex"  comme ent늯e pour
    la d괽inition des constantes du micro-processeur.
}

{$IFNDEF InLineASM}
 {$IFNDEF NoVoid}
  {$IFDEF StartUp}                    {--- System ---}
   {$IFDEF Bios}                      {--- System ---}
    Function ShiftPress4Bios:Boolean; {--- System ---}
   {$ELSE}                            {--- System ---}
    Function ShiftPress:Boolean;      {--- System ---}
   {$ENDIF}                           {--- System ---}
  {$ELSE}                             {--- System ---}
   Function ShiftPress:Boolean;
  {$ENDIF}
  Assembler;
 {$ENDIF}
 ASM
{$ENDIF}
 {$IFDEF Bios}
  MOV AH,02h
  INT 16h
 {$ELSE}
  {$IFDEF DPMI}
   PUSH Seg0040
   POP ES
   {$IFNDEF NoCLI}
    CLI
   {$ENDIF}
   MOV AL,ES:[17h]
   {$IFNDEF NoCLI}
    STI
   {$ENDIF}
  {$ELSE}
   {$IFDEF __286__}
    DB ciPushMemB,00h { PUSH 0000h }
    DB ciPopES        { POP ES }
   {$ELSE}
    {$IFOPT G+}
     PUSH 00h
     POP ES
    {$ELSE}
     XOR AX,AX
     MOV ES,AX
    {$ENDIF}
   {$ENDIF}
   {$IFNDEF NoCLI}
    CLI
   {$ENDIF}
   MOV AL,ES:[0417h]
   {$IFNDEF NoCLI}
    STI
   {$ENDIF}
  {$ENDIF}
 {$ENDIF}
 AND AL,3
 JZ  @End
 MOV AL,True
@End:
{$IFNDEF InLineASM}
 END;
{$ENDIF}

{$ENDIF}