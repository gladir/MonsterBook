{GraphixGetCharacter.Include}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Proc‚dure MakeAddr                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure calcule la longueur d'une coordonn‚e texte (X,Y) et
 retourne son adresse dans les registres du micro-processeur ES:SI.


 Remarque
 ÍÍÍÍÍÍÍÍ

  ş La directive  de compilation conditionnel  ®BufferIsVideoSegment¯
    permet de sp‚cifi‚  l'utilisation du segment vid‚o pour le tampon
    d'acc‚l‚ration  plut“t  que le  juste nomm‚,  le fabuleux  tampon
    d'acc‚l‚ration.  Cette m‚thode  vise essentiellement  les pilotes
    utilisant le texte avec un accŠs directe … la m‚moire vid‚o.
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

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Fonction GetAttr                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction retourne l'attribut situ‚ … la coordonn‚e texte (X,Y)
 par rapport aux donn‚es contenu dans le tampon d'acc‚l‚ration.
}

Function GetAttr(X,Y:Byte):Byte;Assembler;ASM
 CALL MakeAddr
 INC SI
 MOV AL,ES:[SI]
END;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Fonction GetChr                           Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction retourne le caractŠre situ‚ … la coordonn‚e texte (X,Y)
 par rapport aux donn‚es contenu dans le tampon d'acc‚l‚ration.
}

Function GetChr(X,Y:Byte):Char;Assembler;ASM
 CALL MakeAddr
 MOV AL,ES:[SI]
END;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Fonction GetCube                      Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction retourne le caractŠre et son attribut situ‚ … la
 coordonn‚e texte  (X,Y)  par rapport aux donn‚es contenu dans le
 tampon d'acc‚l‚ration.
}

Function GetCube(X,Y:Byte):Word;Assembler;ASM
 CALL MakeAddr
 MOV AX,ES:[SI]
END;