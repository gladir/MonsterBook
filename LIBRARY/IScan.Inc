{IScan.Inc}

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

{$IFNDEF __IScan}
 {$DEFINE __IScan}

{�����������������������������������������������������������������������
 �                           Fonction IScan                            �
 �����������������������������������������������������������������������


 Description
 �����������

  Cette fonction recherche une cha�ne de caract�res sans distinction des
 majuscules  et minuscules  dans  un tampon  d�finit  par la variable de
 param�trage �Block�.  Elle  retourne  par la suite une position absolue
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