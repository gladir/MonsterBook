{SetIntVe.Inc (SetInterruptVector)}

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

{$IFNDEF __SetIntVec}
 {$DEFINE __SetIntVec}

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
 �                          Proc괺ure SetIntVec                        �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�


 Description
 袴袴袴袴袴�

  Cette  proc괺ure  modifie  l'adresse  vers laquelle  pointe le vecteur
 d'une interruption  de num굍o  donn�.  En fait,  elle modifie pour  une
 interruption donn괻 la table des vecteurs d'interruption.


 Remarques
 袴袴袴袴�

  � La directive de compilation 췉os�  permet d'utiliser la technique du
    Dos pour fixer l'interruption.

  � Si le compilateur  n'est  pas adapt�  au code  d'un micro-processeur
    80386  ou  post굍ieur  mais  que  vous  souha똳ez  avoir  ces  codes
    sp괹ifique  � ce processeur,  vous pouvez  d괽inir  la directive  de
    compilation conditionnel �__386__� pour permettre cette adaptation.

  � Si le compilateur  n'est  pas adapt�  au code  d'un micro-processeur
    80286  ou  post굍ieur  mais  que  vous  souha똳ez  avoir  ces  codes
    sp괹ifique  � ce processeur,  vous pouvez  d괽inir  la directive  de
    compilation conditionnel �__286__� pour permettre cette adaptation.

  � La  directive  de  compilation  conditionnelle  췏nLineASM�   permet
    l'int괾ration directe d'assembleur ne terminant pas imm괺iatement ou
    que vous souha똳ez reb긲isser cette fonction sous un autre nom.

  � Est pr굒u pour fonctionner avec l'unit�  "Systex"  comme ent늯e pour
    la d괽inition des constantes du micro-processeur.
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