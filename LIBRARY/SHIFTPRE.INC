{ShiftPress.Inc}

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

{$IFNDEF __ShiftPress}
 {$DEFINE __ShiftPress}

{�����������������������������������������������������������������������
 �                          Fonction ShiftPress                        �
 �����������������������������������������������������������������������


 Description
 �����������

  Cette fonction permet  de conna�tre  l'�tats  des touches  �Shift�, si
 elles sont enfonc�s ou non.  Le fait que ce soit la touche de droite ou
 de gauche, elle ne fait aucun diff�rence entre les 2 et ne retourne pas
 une valeur sup�rieur � vrai si les 2 sont enfonc�es en m�me temps.


 Remarques
 ���������

  � La directive de compilation �Bios� permet d'utiliser la technique du
    Bios pour conna�tre l'�tat d'une des 2 touches "Shift" du clavier.

  � Si le compilateur  n'est  pas adapt�  au code  d'un micro-processeur
    80286  ou  post�rieur  mais  que  vous  souha�tez  avoir  ces  codes
    sp�cifique  � ce processeur,  vous pouvez  d�finir  la directive  de
    compilation conditionnel �__286__� pour permettre cette adaptation.

  � La directive de compilation conditionnelle �NoCLI�  permet d'omettre
    les  instructions  assembleur  "CLI"  et  "STI"  dans vos situations
    particuli�re critique...

  � La  directive  de  compilation  conditionnelle  �InLineASM�   permet
    l'int�gration directe d'assembleur ne terminant pas imm�diatement ou
    que vous souha�tez reb�tisser cette fonction sous un autre nom.

  � Est pr�vu pour fonctionner avec l'unit�  "Systex"  comme ent�te pour
    la d�finition des constantes du micro-processeur.
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