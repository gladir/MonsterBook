{HexWord.Inc}

{$IFNDEF __HexWord2Str}
 {$DEFINE __HexWord2Str}

 {$IFNDEF HexData}
  {$DEFINE HexData}
   Const
    {Constante permettant la conversion de valeur en hexad‚cimal}
    HexData:Array[0..15]of Char='0123456789ABCDEF';
 {$ENDIF}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                       Fonction HexWord2Str                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction retourne une chaine hexad‚cimal de la valeur sp‚cifi‚
 par la variable de param‚trage en format de 4 caractŠres.


 R‚f‚rence
 ÍÍÍÍÍÍÍÍÍ

  ş Fonction HexString de la proc‚dure ®error¯,  Turbo Graphix version
    1.05A, Graphics system kernel, Turbo Pascal 3.01A de Borland.
}

Function HexWord2Str(X:Word):String;Assembler;ASM
 LES DI,@Result
 MOV SI,Offset HexData
 MOV DX,X
 MOV BL,DL;AND BX,$F;MOV AL,DS:[SI+BX];
 {$IFOPT G-}MOV CL,4{$ENDIF}
 STD;ADD DI,4;STOSB
 MOV BL,DL
 {$IFOPT G+}SHR BL,4{$ELSE}SHR BL,CL{$ENDIF}
 MOV AL,DS:[SI+BX];STOSB
 MOV BL,DH;AND BL,0Fh
 MOV AL,DS:[SI+BX];STOSB
 MOV BL,DH
 {$IFOPT G+}SHR BL,4{$ELSE}SHR BL,CL{$ENDIF}
 MOV AL,DS:[SI+BX];STOSB
 MOV AL,CL;STOSB
END;

{$ENDIF}