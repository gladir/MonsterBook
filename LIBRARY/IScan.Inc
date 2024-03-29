{IScan.Inc}

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

{$IFNDEF __IScan}
 {$DEFINE __IScan}

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
 �                           Fonction IScan                            �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�


 Description
 袴袴袴袴袴�

  Cette fonction recherche une cha똭e de caract둹es sans distinction des
 majuscules  et minuscules  dans  un tampon  d괽init  par la variable de
 param굏rage 췇lock�.  Elle  retourne  par la suite une position absolue
 par rapport au tampon.
}

Function IScan(Var Block;Size:Word;Const Str:String):Word;Assembler;Var S:String;ASM
 {$IFDEF FLAT386}
 {$ELSE}
  PUSH DS
   PUSH SS
   POP ES
   LEA DI,S
   LDS SI,Str
   XOR AH,AH
   LODSB
   STOSB
   MOV CX,AX
   MOV BX,AX
   JCXZ @@9
@@1:LODSB
   CMP AL,'a'
   JB @@2
   CMP AL,'z'
   JA @@2
   SUB AL,20H
@@2:STOSB
   LOOP @@1
   SUB DI,BX
   LDS SI,Block
   MOV CX,Size
   JCXZ @@8
   CLD
   SUB CX,BX
   JB @@8
   INC CX
@@4:MOV	AH,ES:[DI]
   AND AH,$DF
@@5:LODSB
 {  CMP AL,' '
   JB @HickGat
 @RtGat:}
   AND AL,$DF
   CMP AL,AH
   LOOPNE @@5
   JNE @@8
   DEC SI
   MOV DX,CX
   MOV CX,BX
@@6:REPE CMPSB
   JE @@10
 {  CMP AL,' '
   JB @HickGat
 @RtGat:}
   MOV AL,DS:[SI-1]
   CMP AL,'a'
   JB @@7
   CMP AL,'z'
   JA @@7
   SUB AL,20H
@@7:CMP	AL,ES:[DI-1]
   JE @@6
   SUB CX,BX
   ADD SI,CX
   ADD DI,CX
   INC SI
   MOV CX,DX
   JNE @@4
@@8:XOR	AX,AX
   JMP @@11
 {@HickGat:
   CMP Byte Ptr DS:[SI-1],' '
   JB  @RtGat
   INC SI
   JMP @RtGat}
@@9:MOV AX,1
   JMP @@11
@@10:SUB SI,BX
   MOV AX,SI
   SUB AX,Word Ptr Block
   INC AX
@@11:DEC AX
  POP DS
 {$ENDIF}
END;

{$ENDIF}