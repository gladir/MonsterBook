{\Source\Chantal\Library\SetAttr.Inc}

{$IFNDEF __SetAttr}
 {$DEFINE __SetAttr}

 {ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
  ³                       Fonction SetFileAttr                       Û
  ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


  Description
  ÍÍÍÍÍÍÍÍÍÍÍ

   Cette fonction permet de changer l'attribut du fichier sp‚cifier en
  paramŠtre par la variable ®Path¯ avec l'attribut ‚galement envoy‚ en
  paramŠtre ®Attr¯. Si l'op‚ration  c'est bien pass‚, il retourne vrai
  sinon, s'il y a la moindre erreur il retourne faux.
 }

 Function SetFileAttr(Const Path:String;Attr:Word):Boolean;
 Var
  PC:Array[Byte]of Char;
  S,O:Word;
 Begin
  {$IFDEF Win32}
  {$ELSE}
   StrPCopy(@PC,Path);
   S:=Seg(PC);O:=Ofs(PC);
   ASM
    PUSH DS
     MOV DS,S
     MOV DX,O
     MOV CX,Attr
     MOV AX,4301h
     INT 21h
     LAHF
     NOT AH
     AND AH,1
     MOV @Result,AH
    POP DS
   END;
  {$ENDIF}
 End;

{$ENDIF}