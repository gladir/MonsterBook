{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                                                                     Û
 ³                      U n i t ‚  S Y S T E M                         Û
 ³                                                                     Û
 ³               BibliothŠque du compilateur Pascal B57                Û
 ³        Enemble Malte Genesis IV & V: Alias Chantal & AdŠle          Û
 ³                                                                     Û
 ³   Tous droits r‚serv‚s par les Chevaliers de Malte (C) 1998, 1999   Û
 ³                                                                     Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Nom du programmeur
 ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ

  Sylvain Maltais


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette unit‚  est  charg‚ automatiquement  … chaque compilation … moins
 naturellement que ce soit elle ‚tant compiler. Elle renferme toutes les
 donn‚es  de  base   permettant  une  d‚finit  standard  du  langage  de
 programmation Pascal.


 Remarque
 ÍÍÍÍÍÍÍÍ

  ş Les directives de compilation ®MOT_CLEF¯ sont utilis‚es pour d‚finir
    le(s) mot(s)  … employer dans la syntaxe du langage Pascal.  S'il ne
    sont pas  d‚finit  avant  l'instruction  ®Unit‚¯  il n'y aura aucune
    instruction  d‚finit  dans  le  langage  Pascal  et   il  sera  donc
    impossible d'‚crire du source Pascal.
}

Unit‚ System;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                                  INTERFACE
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Const
 True=Boolean(1);         { Valeur vrai d'un nombre bool‚an }
 Vrai=Boolean(1);         { Traduction fran‡aise }
 False=Boolean(0);        { Valeur fausse d'un nombre bool‚an }
 Faux=Boolean(0);         { Traduction fran‡aise }
 ByteMin=0;               { Minimal d'une variable ®Byte¯ }
 ByteMax=$FF;             { Maximal d'une variable ®Byte¯ }
 ShortIntMin=-128;        { Minimal d'une variable ®ShortInt¯ }
 ShortIntMax=127;         { Maximal d'une variable ®ShortInt¯ }
 MinInt=-32768;           { Valeur minimal d'un ®Integer¯ }
 MinEnt=MinInt;           { Valeur minimal d'un ®Integer¯, ®entier¯ en fran‡ais }
 MaxInt=32767;            { Valeur maximal d'un ®Integer¯ }
 MaxEnt=MaxInt;           { Valeur maximal d'un ®Integer¯, ®entier¯ en fran‡ais }
 MinLongInt=-2147483648;  { Valeur minimal d'un ®LongInt¯ }
 MaxLongInt=2147483647;   { Valeur maximal d'un ®LongInt¯ }
 MinWord=0;               { Valeur minimal d'un ®Word¯ }
 MinMot=MinWord;          { Valeur minimal d'un ®Word¯, ®mot¯ en fran‡ais }
 MaxWord=65535;           { Valeur maximal d'un ®Word¯ }
 MaxMot=MaxWord;          { Valeur maximal d'un ®Word¯, ®mot¯ en fran‡ais }

  { * * * * * * * Compatibilit‚ avec Delphi * * * * * * * }
 { Code du type ®Variant¯ }
 varEmpty=$0000;          { ®Variant¯ de type vide }
 varNull=$0001;           { ®Variant¯ de type n‚ant ou nulle }
 varSmallint=$0002;       { ®Variant¯ de type ®ShortInt¯ }
 varInteger=$0003;        { ®Variant¯ de type ®Integer¯ }
 varSingle=$0004;         { ®Variant¯ de type ®Single¯ }
 varDouble=$0005;         { ®Variant¯ de type ®Double¯ }
 varCurrency=$0006;       { ®Variant¯ de type courant }
 varDate=$0007;           { ®Variant¯ de type date }
 varOleStr=$0008;         { ®Variant¯ de type chaŒne de caractŠres OLE }
 varDispatch=$0009;
 varError=$000A;
 varBoolean=$000B;
 varVariant=$000C;
 varUnknown=$000D;
 varByte=$0011;
 varString=$0100;
 varTypeMask=$0FFF;
 varArray=$2000;
 varByRef=$4000;

 {Valeur ®TVarRec.VType¯ }
 vtInteger=0;
 vtBoolean=1;
 vtChar=2;
 vtExtended=3;
 vtString=4;
 vtPointer=5;
 vtPChar=6;
 vtObject=7;
 vtClass=8;
 vtWideChar=9;
 vtPWideChar=10;
 vtAnsiString=11;
 vtCurrency=12;
 vtVariant=13;
 vtInterface=14;
 vtWideString=15;

 { Table des entr‚es de la m‚thode "Virtuel" }
 vmtSelfPtr=-64;
 vmtIntfTable=-60;
 vmtAutoTable=-56;
 vmtInitTable=-52;
 vmtTypeInfo=-48;
 vmtFieldTable=-44;
 vmtMethodTable=-40;
 vmtDynamicTable=-36;
 vmtClassName=-32;
 vmtInstanceSize=-28;
 vmtParent=-24;
 vmtSafeCallException=-20;
 vmtDefaultHandler=-16;
 vmtNewInstance=-12;
 vmtFreeInstance=-8;
 vmtDestroy=-4;

 vmtQueryInterface=0;
 vmtAddRef=4;
 vmtRelease=8;
 vmtCreateObject=12;

Type
 Mot=Word;
 PChar=^Char;
 File=Record
  Handle:Word;
 End;

Fonction  AbsInt(I:Integer);Registre;
Proc‚dure AddStr(Var ChaŒne1:String;Const ChaŒne2:String);
Fonction  Compare(Const Source,Dest;Len:Word):Boolean;
Proc‚dure Concat(Var ChaŒne1:String;Const ChaŒne2:String);Duplication AddStr;
Proc‚dure FillChar(Var Source;Len:Word;Value:Byte);
Proc‚dure FillChr(Var Source;Len:Word;Value:Byte);Duplication FillChar;
Proc‚dure FillClr(Var Source;Len:Word);
Proc‚dure FillClear(Var Source;Len:Word);Duplication FillClr;
Proc‚dure IncStr(Var ChaŒne:String;CaractŠre:Char);
Proc‚dure Move(Const Source;Var Dest;Len:Word);
Proc‚dure MoveLeft(Const Source;Var Dest;Len:Word);Duplication Move;
Proc‚dure MoveRight(Const Source;Var Dest;Len:Word);

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                                IMPLMENTATION
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

{ Cette fonction permet de retourner la valeur absolue d'une entier.
}

Fonction AbsInt(I:Integer);Registre;Assembleur;ASM
 OR AX,AX
 JGE @1
 NEG AX
@1:
END;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                             Fonction Compare                           Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de comparer 2 tampons contenu en m‚moire et indique
 s'ils sont  identiques  (True)  et  qu'une/que  des diff‚rence(s)  existes
 (False).
}

Fonction Compare(Const Source,Dest;Len:Word):Boolean;Assembleur;ASM
 MOV CX,Len
 JCXZ @0
 PUSH DS
  LDS SI,Source
  LES DI,Dest
  CLD
  REPZ CMPSB
 POP DS
 JZ  @0
 MOV CL,1
@0:
 XCHG AX,CX
 XOR AL,1
FIN;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Proc‚dure Concat                           Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet d'additionner … la fin d'une chaŒne de caractŠre
 Pascal d‚j… existante une autre chaŒne de caractŠre de style Pascal.
}

Proc‚dure AddStr(Var ChaŒne1:String;Const ChaŒne2:String);Assembleur;ASM
 PUSH DS
  LES DI,ChaŒne1
  LDS SI,ChaŒne2
  MOVZX DX,ES:[DI]
  MOVZX CX,DS:[SI]
  ADD ES:[DI],CL
  INC DI
  ADD DI,DX
  INC SI
  REP MOVSB
 POP DS
FIN;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Proc‚dure FillChar                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure d'effacer avec un caractŠre particulier une zone de
 tampon de m‚moire.
}

Proc‚dure FillChar(Var Source;Len:Word;Value:Byte);Assembleur;ASM
 CLD
 LES DI,Source
 MOV CX,Len
 MOV AL,Value
 MOV AH,AL
 {$IFOPT 3+}
  PUSH AX
  PUSH AX
  POP EAX
  MOV BX,CX
  AND BX,3
  SHR CX,2
  REP STOSD
  MOV CX,BX
  REP STOSB
 {$ELSE}
  SHR CX,1
  REP STOSW
  ADC CX,CX
  REP STOSB
 {$ENDIF}
FIN;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Proc‚dure FillClr                          Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet d'effacer un tampon avec leur valeur initiale.
}

Proc‚dure FillClr(Var Source;Len:Word);Assembleur;ASM
 CLD
 LES DI,Source
 MOV CX,Len
 {$IFOPT 3+}
  XOR EAX,EAX
  MOV BX,CX
  AND BX,3
  SHR CX,2
  REP STOSD
  MOV CX,BX
 {$ELSE}
  MOV AL,0
 {$ENDIF}
 REP STOSB
FIN;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Proc‚dure IncStr                           Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet d'additionner … la fin d'une chaŒne de caractŠre
 Pascal d‚j… existante un caractŠre.
}

Proc‚dure IncStr(Var ChaŒne:String;CaractŠre:Char);Assembleur;ASM
 LES DI,ChaŒne
 INC Byte Ptr ES:[DI]
 MOVZX BX,ES:[DI]
 ADD DI,BX
 MOV AL,CaractŠre
 STOSB
FIN;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Proc‚dure Move                           Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure d‚placer une tampon de m‚moire vers une autre adresse
 avec une longueur d‚finit en paramŠtrage.
}

Proc‚dure Move(Const Source;Var Dest;Len:Word);Assembleur;ASM
 CLD
 PUSH DS
  LDS SI,Source
  LES DI,Dest
  MOV CX,Len
  {$IFOPT 3+}
   MOV AX,CX
   AND AX,3
   SHR CX,2
   REP MOVSD
   XCHG AX,CX
   REP MOVSB
  {$ELSE}
    { Transfert en 16 bits...}
   SHR CX,1
   REP MOVSW
   ADC CX,CX
   REP MOVSB
  {$ENDIF}
 POP DS
FIN;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Proc‚dure MoveRight                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure d‚placer une tampon de m‚moire vers une autre adresse
 avec une longueur d‚finit en paramŠtrage.  Le  transfert  s'effectue …
 partir de la fin des deux tampons.
}

Proc‚dure MoveRight(Const Source;Var Dest;Len:Word);Assembleur;ASM
 STD
 PUSH DS
  LDS SI,Source
  LES DI,Dest
  MOV CX,Len
  ADD SI,CX
  DEC SI
  ADD DI,CX
  DEC DI
  REP MOVSB
 POP DS
FIN;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
FIN.