{SetIntVe.Inc (SetInterruptVector)}

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

{$IFNDEF __SetIntVec}
 {$DEFINE __SetIntVec}

{�����������������������������������������������������������������������
 �                          Proc�dure SetIntVec                        �
 �����������������������������������������������������������������������


 Description
 �����������

  Cette  proc�dure  modifie  l'adresse  vers laquelle  pointe le vecteur
 d'une interruption  de num�ro  donn�.  En fait,  elle modifie pour  une
 interruption donn�e la table des vecteurs d'interruption.


 Remarques
 ���������

  � La directive de compilation �Dos�  permet d'utiliser la technique du
    Dos pour fixer l'interruption.

  � Si le compilateur  n'est  pas adapt�  au code  d'un micro-processeur
    80386  ou  post�rieur  mais  que  vous  souha�tez  avoir  ces  codes
    sp�cifique  � ce processeur,  vous pouvez  d�finir  la directive  de
    compilation conditionnel �__386__� pour permettre cette adaptation.

  � Si le compilateur  n'est  pas adapt�  au code  d'un micro-processeur
    80286  ou  post�rieur  mais  que  vous  souha�tez  avoir  ces  codes
    sp�cifique  � ce processeur,  vous pouvez  d�finir  la directive  de
    compilation conditionnel �__286__� pour permettre cette adaptation.

  � La  directive  de  compilation  conditionnelle  �InLineASM�   permet
    l'int�gration directe d'assembleur ne terminant pas imm�diatement ou
    que vous souha�tez reb�tisser cette fonction sous un autre nom.

  � Est pr�vu pour fonctionner avec l'unit�  "Systex"  comme ent�te pour
    la d�finition des constantes du micro-processeur.
}

{$IFNDEF InLineASM}
 {$IFNDEF NoVoid}
  Procedure SetIntVec(IntNo:Byte;Vector:Pointer);Assembler;
 {$ENDIF}
 ASM
{$ENDIF}
 {$IFDEF FLAT386}
  AND EAX,0FFh
  SHL EAX,2
  MOV EAX,[EAX]
  MOV [EDX],EAX
 {$ELSE}
  {$IFDEF DPMI}
   PUSH DS
    LDS DX,Vector
    MOV AL,IntNo
    MOV AH,25h
    INT 21h
   POP DS
  {$ELSE}
   {$IFDEF Dos}
    PUSH DS
     LDS DX,Vector
     MOV AL,IntNo
     MOV AH,25h
     INT 21h
    POP DS
   {$ELSE}
    XOR BX,BX
    MOV ES,BX
    MOV BL,IntNo
    {$IFDEF __386__}
     {$IFOPT G+}
      SHL BX,2
     {$ELSE}
      DB 0C1h,0E3h,02h              { SHL BX,2 }
     {$ENDIF}
     DB 66h; MOV AX,Word Ptr Vector { MOV EAX,Vector }
     CLI
     DB 66h; MOV ES:[BX],AX         { MOV ES:[BX],EAX }
    {$ELSE}
     {$IFDEF __286__}
      DB  0C1h,0E3h,02h { SHL BX,2 }
     {$ELSE}
      {$IFOPT G+}
       SHL BX,2
      {$ELSE}
       SHL BX,1
       SHL BX,1
      {$ENDIF}
     {$ENDIF}
     MOV AX,Word Ptr Vector
     MOV DX,Word Ptr Vector[2]
     CLI
     MOV ES:[BX],AX   { Vector.Ofs := MemW[0:IntNo shl 2] }
     MOV ES:[BX+2],DX { Vector.Seg := MemW[0:(IntNo shl 2)+2] }
    {$ENDIF}
    STI
   {$ENDIF}
  {$ENDIF}
 {$ENDIF}
{$IFNDEF InLineASM}
 END;
{$ENDIF}

{$ENDIF}