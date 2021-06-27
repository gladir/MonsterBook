{CloseCursor.Inc}

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

{$IFNDEF __CloseCur}
 {$DEFINE __CloseCur}

{����������������������������������������������������������������������
 �                         Proc�dure CloseCur                         �
 ����������������������������������������������������������������������


 Description
 �����������

  Cette proc�dure permet d'effacer le curseur de l'�cran de style texte
 ou d'une fen�tre Windows (si compiler en mode Windows).


 Remarques
 ���������

  � La directive de compilation �Bios� permet d'utiliser la technique du
    Bios pour efface le curseur.

  � La  directive  de  compilation  conditionnelle  �InLineASM�   permet
    l'int�gration directe d'assembleur ne terminant pas imm�diatement ou
    que vous souha�tez reb�tisser cette fonction sous un autre nom.

  � Est pr�vu pour fonctionner avec l'unit�  "Systex"  comme ent�te pour
    la d�finition des constantes du micro-processeur.

  � Elle  supporte  le  mode  R�el,  DPMI (mode prot�g� dynamique...) et
    Windows (environnement multi-fen�tre multi-t�che).
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