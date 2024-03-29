{Split.Inc}

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
 �                         Proc괺ure SplitScreen                       �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�


 Description
 袴袴袴袴袴�

  Cette proc괺ure permet de fractionner l'괹ran en 2 zones ind굋endantes
 pour les animations de 췎ackers�...


 Remarque
 袴袴袴袴

  � Pour produire cette effet,il ne demande pas au micro-processeur,mais
    � carte vid굊 VGA ou post굍ieur par l'entremise des 3 registres:Line
    Compare (ou Split Screen)  (CRTC, index 18h),  Overflow  et  Maximum
    Row.


 R괽굍ence
 袴袴袴袴�

  � Livre PC Interdit,  Boris BERTELSONS et Mathias RASCH, 괺ition Micro
    Application, en page 155 � 163. C'est une proc괺ure nomm� 췚plit� en
    langage assembleur dans ce livre.
}

Procedure SplitScreen(Y:Word);Begin
 If GetBitsPerPixel<8Then Exit;
 If GetNmYPixels=200Then ASM SHL Y,1;END;
 ASM
  MOV BX,Y
  MOV CX,BX
  MOV DX,3D4h
  MOV AL,07h
  OUT DX,AL
  INC DX
  IN  AL,DX
  AND AL,11101111b
  {$IFOPT G+}
   SHR CX,4
  {$ELSE}
   SHR CX,1
   SHR CX,1
   SHR CX,1
   SHR CX,1
  {$ENDIF}
  AND CL,16
  OR  AL,CL
  OUT DX,AL
  DEC DX
  MOV AL,09h
  OUT DX,AL
  INC DX
  IN  AL,DX
  AND AL,10111111b
  {$IFOPT G+}
   SHR BL,3
  {$ELSE}
   SHR BL,1
   SHR BL,1
   SHR BL,1
  {$ENDIF}
  AND BL,64
  OR  AL,BL
  OUT DX,AL
  DEC DX
  MOV AL,18h
  MOV AH,Byte Ptr Y
  OUT DX,AX
 END;
End;