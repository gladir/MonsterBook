{Scan.Inc}

{$IFNDEF __Scan}
 {$DEFINE __Scan}

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
 �                             Fonction Scan                             �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�


 Description
 袴袴袴袴袴�

  Cette fonction permet de rechercher dans un tampon de taille d괽init par
 la variable de param굏rage  췚ize�,  une cha똭e  de caract둹es  de format
 Pascal (String).  Si l'op굍ation c'est arriver fructeuse,  il retourne le
 d굋lacement � effectuer dans le tampon pour pouvoir l'obtenir.
}

Function Scan(Var Block;Size:Word;Str:String):Word;Assembler;ASM
 {$IFDEF FLAT386}
 {$ELSE}
  PUSH DS
   LES DI,Block
   LDS SI,Str
   MOV CX,Size
   JCXZ @3
   CLD
   LODSB
   CMP AL,1
   JB @5
   JA @1
   LODSB
   REPNE SCASB
   JNE @3
   JMP @5
@1:XOR AH,AH
   MOV BX,AX
   DEC BX
   MOV DX,CX
   SUB DX,AX
   JB  @3
   LODSB
   INC DX
   INC DX
@2:DEC DX
   MOV CX,DX
   REPNE SCASB
   JNE @3
   MOV DX,CX
   MOV CX,BX
   REP CMPSB
   JE  @4
   SUB CX,BX
   ADD SI,CX
   ADD DI,CX
   INC DI
   OR  DX,DX
   JNE @2
@3:XOR AX,AX
   JMP @6
@4:SUB DI,BX
@5:MOV AX,DI
   SUB AX,Word Ptr Block
@6:DEC AX
  POP DS
 {$ENDIF}
END;

{$ENDIF}