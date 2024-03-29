{GetIntVec.Inc}

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

{$IFNDEF __GetIntVec}
 {$DEFINE __GetIntVec}

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
 �                          Fonction GetIntVec                         �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�


 Description
 袴袴袴袴袴�

  Cette fonction  retourne  l'adresse  de l'interruption d괽init  par la
 variable de param굏rage 췏ntNo� dans le vecteur d괽init par la variable
 de param굏rage 췝ector�.

 Remarque
 袴袴袴袴

  � Voici sa forme en langage Pascal en mode r괻l:
    旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
    � Procedure GetIntVec(IntNo:Byte;Var Vector:Pointer);              �
    � Type TableIntRec=Array[0..255]of Pointer;                        �
    � Var TableInt:TableIntRec Absolute$0000:$0000;                    �
    � Begin                                                            �
    �  Inline($FA); (* CLI; *)                                         �
    �  Vector:=TableInt[IntNo];                                        �
    �  Inline($FB); (* STI; *)                                         �
    � End;                                                             �
    읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
}

Procedure GetIntVec(IntNo:Byte;Var Vector:Pointer);Assembler;ASM
 {$IFDEF FLAT386}
  AND EAX,0FFh
  SHL EAX,2
  MOV EAX,[EAX]
  MOV [EDX],EAX
 {$ELSE}
  {$IFDEF DPMI}
   MOV AL,IntNo
   MOV AH,$35
   INT $21
   MOV AX,ES
   LES DI,Vector
   CLD
   XCHG AX,BX
   STOSW
   XCHG AX,BX
   STOSW
  {$ELSE}
   XOR BX,BX
   MOV ES,BX
   MOV BL,IntNo
   {$IFDEF __286__}
    DB $C1,$E3,$02   { SHL BX,2 }
   {$ELSE}
    {$IFOPT G+}
     SHL BX,2
    {$ELSE}
     SHL BX,1
     SHL BX,1
    {$ENDIF}
   {$ENDIF}
   CLI
   {$IFDEF __386__}
    DB $26,$66,$8B,$07 { MOV EAX,ES:[BX] }
   {$ELSE}
    MOV AX,ES:[BX]   { Vector.Ofs := MemW[0:IntNo shl 2] }
    MOV DX,ES:[BX+2] { Vector.Seg := MemW[0:(IntNo shl 2)+2] }
   {$ENDIF}
   STI
   LES DI,Vector
   {$IFDEF __386__}
    {$IFDEF SlomoXtrk}
     DB $26,$66,$89,$05 { MOV ES:[DI],EAX }
    {$ELSE}
     CLD
     DW ciSTOSD
    {$ENDIF}
   {$ELSE}
    {$IFDEF SlomoXtrk}
     MOV ES:[DI],AX
     MOV ES:[DI+2],DX
    {$ELSE}
     CLD
     STOSW
     XCHG AX,DX
     STOSW
    {$ENDIF}
   {$ENDIF}
  {$ENDIF}
 {$ENDIF}
END;

{$ENDIF}