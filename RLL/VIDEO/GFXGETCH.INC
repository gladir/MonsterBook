{GraphixGetCharacter.Include}

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴콘
 �                        Proc괺ure MakeAddr                        �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複蔔


 Description
 袴袴袴袴袴�

  Cette proc괺ure calcule la longueur d'une coordonn괻 texte (X,Y) et
 retourne son adresse dans les registres du micro-processeur ES:SI.


 Remarque
 袴袴袴袴

  � La directive  de compilation conditionnel  췇ufferIsVideoSegment�
    permet de sp괹ifi�  l'utilisation du segment vid굊 pour le tampon
    d'acc굃굍ation  plut뱓  que le  juste nomm�,  le fabuleux  tampon
    d'acc굃굍ation.  Cette m굏hode  vise essentiellement  les pilotes
    utilisant le texte avec un acc둺 directe � la m굆oire vid굊.
}

Procedure MakeAddr;Near;Assembler;ASM
 {$IFDEF __386__}
  DB 36h,0Fh,0B6h,05Eh,06h { MOVZX BX,Byte Ptr SS:[BP+6] }
 {$ELSE}
  MOV BL,SS:[BP+6]
  XOR BH,BH
 {$ENDIF}
 SHL BX,1
 MOV SI,Word Ptr RawTxtY[BX]
 MOV BL,SS:[BP+8]
 ADD SI,BX
 SHL SI,1
 {$IFDEF BufferIsVideoSegment}
  MOV ES,DataVideo.MIV.SegVideo
 {$ELSE}
  MOV ES,DataVideo.MIV.SegBuffer
 {$ENDIF}
END;

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
 �                          Fonction GetAttr                         �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�


 Description
 袴袴袴袴袴�

  Cette fonction retourne l'attribut situ� � la coordonn괻 texte (X,Y)
 par rapport aux donn괻s contenu dans le tampon d'acc굃굍ation.
}

Function GetAttr(X,Y:Byte):Byte;Assembler;ASM
 CALL MakeAddr
 INC SI
 MOV AL,ES:[SI]
END;

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
 �                           Fonction GetChr                           �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�


 Description
 袴袴袴袴袴�

  Cette fonction retourne le caract둹e situ� � la coordonn괻 texte (X,Y)
 par rapport aux donn괻s contenu dans le tampon d'acc굃굍ation.
}

Function GetChr(X,Y:Byte):Char;Assembler;ASM
 CALL MakeAddr
 MOV AL,ES:[SI]
END;

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴콘
 �                        Fonction GetCube                      �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複蔔


 Description
 袴袴袴袴袴�

  Cette fonction retourne le caract둹e et son attribut situ� � la
 coordonn괻 texte  (X,Y)  par rapport aux donn괻s contenu dans le
 tampon d'acc굃굍ation.
}

Function GetCube(X,Y:Byte):Word;Assembler;ASM
 CALL MakeAddr
 MOV AX,ES:[SI]
END;