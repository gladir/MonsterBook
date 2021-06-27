{HexByte.Inc}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                       Fonction HexByte2Str                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction retourne une chaine hexad‚cimal de la valeur sp‚cifi‚
 par la variable de param‚trage en format de 2 caractŠres.


 R‚f‚rence
 ÍÍÍÍÍÍÍÍÍ

  ş Fonction HexString de la proc‚dure ®error¯,  Turbo Graphix version
    1.05A, Graphics system kernel, Turbo Pascal 3.01A de Borland.
}

{$IFNDEF __HexByte2Str}
 {$DEFINE __HexByte2Str}

 {$IFNDEF HexData}
  {$DEFINE HexData}
   {$IFDEF RLL}
    Procedure HexData;Assembler;ASM
     DB '0123456789ABCDEF'
    END;
   {$ELSE}
    Const
     {Constante permettant la conversion de valeur en hexad‚cimal}
     HexData:Array[0..15]of Char='0123456789ABCDEF';
   {$ENDIF}
 {$ENDIF}

Function HexByte2Str(X:Byte):String;Assembler;ASM
 {$IFDEF FLAT386}
 {$ELSE}
  LES DI,@Result
  MOV SI,Offset HexData
  STD
  INC DI
  INC DI
  {$IFDEF HEXH}
   INC DI
   MOV AL,'h'
   STOSB
  {$ENDIF}
  MOV DL,X
  MOV BL,DL
  AND BX,0Fh
  {$IFDEF RLL}
   MOV AL,CS:[SI+BX]
  {$ELSE}
   MOV AL,DS:[SI+BX]
  {$ENDIF}
  STOSB
  MOV BL,DL
  {$IFOPT G+}
   SHR BL,4
  {$ELSE}
   MOV CL,4
   SHR BL,CL
  {$ENDIF}
  {$IFDEF RLL}
   MOV AL,CS:[SI+BX]
  {$ELSE}
   MOV AL,DS:[SI+BX]
  {$ENDIF}
  STOSB
  {$IFDEF HEXH}
   MOV AL,3
  {$ELSE}
   MOV AL,2
  {$ENDIF}
  STOSB
 {$ENDIF}
END;

{$ENDIF}