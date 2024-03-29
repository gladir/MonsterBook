{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
 �                                                                     �
 �                      U n i t �  S Y S T E M                         �
 �                                                                     �
 �               Biblioth둸ue du compilateur Pascal B57                �
 �        Enemble Malte Genesis IV & V: Alias Chantal & Ad둳e          �
 �                                                                     �
 �   Tous droits r굎erv굎 par les Chevaliers de Malte (C) 1998, 1999   �
 �                                                                     �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�


 Nom du programmeur
 袴袴袴袴袴袴袴袴袴

  Sylvain Maltais


 Description
 袴袴袴袴袴�

  Cette unit�  est  charg� automatiquement  � chaque compilation � moins
 naturellement que ce soit elle 굏ant compiler. Elle renferme toutes les
 donn괻s  de  base   permettant  une  d괽init  standard  du  langage  de
 programmation Pascal.


 Remarque
 袴袴袴袴

  � Les directives de compilation 췔OT_CLEF� sont utilis괻s pour d괽inir
    le(s) mot(s)  � employer dans la syntaxe du langage Pascal.  S'il ne
    sont pas  d괽init  avant  l'instruction  췜nit궚  il n'y aura aucune
    instruction  d괽init  dans  le  langage  Pascal  et   il  sera  donc
    impossible d'괹rire du source Pascal.
}

Unit� System;

{컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�}
                                  INTERFACE
{컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�}

Const
 True=Boolean(1);         { Valeur vrai d'un nombre bool괶n }
 Vrai=Boolean(1);         { Traduction fran놹ise }
 False=Boolean(0);        { Valeur fausse d'un nombre bool괶n }
 Faux=Boolean(0);         { Traduction fran놹ise }
 ByteMin=0;               { Minimal d'une variable 췇yte� }
 ByteMax=$FF;             { Maximal d'une variable 췇yte� }
 ShortIntMin=-128;        { Minimal d'une variable 췚hortInt� }
 ShortIntMax=127;         { Maximal d'une variable 췚hortInt� }
 MinInt=-32768;           { Valeur minimal d'un 췏nteger� }
 MinEnt=MinInt;           { Valeur minimal d'un 췏nteger�, 췦ntier� en fran놹is }
 MaxInt=32767;            { Valeur maximal d'un 췏nteger� }
 MaxEnt=MaxInt;           { Valeur maximal d'un 췏nteger�, 췦ntier� en fran놹is }
 MinLongInt=-2147483648;  { Valeur minimal d'un 췓ongInt� }
 MaxLongInt=2147483647;   { Valeur maximal d'un 췓ongInt� }
 MinWord=0;               { Valeur minimal d'un 췞ord� }
 MinMot=MinWord;          { Valeur minimal d'un 췞ord�, 췱ot� en fran놹is }
 MaxWord=65535;           { Valeur maximal d'un 췞ord� }
 MaxMot=MaxWord;          { Valeur maximal d'un 췞ord�, 췱ot� en fran놹is }

  { * * * * * * * Compatibilit� avec Delphi * * * * * * * }
 { Code du type 췝ariant� }
 varEmpty=$0000;          { 췝ariant� de type vide }
 varNull=$0001;           { 췝ariant� de type n괶nt ou nulle }
 varSmallint=$0002;       { 췝ariant� de type 췚hortInt� }
 varInteger=$0003;        { 췝ariant� de type 췏nteger� }
 varSingle=$0004;         { 췝ariant� de type 췚ingle� }
 varDouble=$0005;         { 췝ariant� de type 췉ouble� }
 varCurrency=$0006;       { 췝ariant� de type courant }
 varDate=$0007;           { 췝ariant� de type date }
 varOleStr=$0008;         { 췝ariant� de type cha똭e de caract둹es OLE }
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

 {Valeur 췛VarRec.VType� }
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

 { Table des entr괻s de la m굏hode "Virtuel" }
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
Proc괺ure AddStr(Var Cha똭e1:String;Const Cha똭e2:String);
Fonction  Compare(Const Source,Dest;Len:Word):Boolean;
Proc괺ure Concat(Var Cha똭e1:String;Const Cha똭e2:String);Duplication AddStr;
Proc괺ure FillChar(Var Source;Len:Word;Value:Byte);
Proc괺ure FillChr(Var Source;Len:Word;Value:Byte);Duplication FillChar;
Proc괺ure FillClr(Var Source;Len:Word);
Proc괺ure FillClear(Var Source;Len:Word);Duplication FillClr;
Proc괺ure IncStr(Var Cha똭e:String;Caract둹e:Char);
Proc괺ure Move(Const Source;Var Dest;Len:Word);
Proc괺ure MoveLeft(Const Source;Var Dest;Len:Word);Duplication Move;
Proc괺ure MoveRight(Const Source;Var Dest;Len:Word);

{컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�}
                                IMPL륪ENTATION
{컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�}

{ Cette fonction permet de retourner la valeur absolue d'une entier.
}

Fonction AbsInt(I:Integer);Registre;Assembleur;ASM
 OR AX,AX
 JGE @1
 NEG AX
@1:
END;

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴콘
 �                             Fonction Compare                           �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複蔔


 Description
 袴袴袴袴袴�

  Cette fonction permet de comparer 2 tampons contenu en m굆oire et indique
 s'ils sont  identiques  (True)  et  qu'une/que  des diff굍ence(s)  existes
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

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴콘
 �                           Proc괺ure Concat                           �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複蔔


 Description
 袴袴袴袴袴�

  Cette proc괺ure permet d'additionner � la fin d'une cha똭e de caract둹e
 Pascal d굁� existante une autre cha똭e de caract둹e de style Pascal.
}

Proc괺ure AddStr(Var Cha똭e1:String;Const Cha똭e2:String);Assembleur;ASM
 PUSH DS
  LES DI,Cha똭e1
  LDS SI,Cha똭e2
  MOVZX DX,ES:[DI]
  MOVZX CX,DS:[SI]
  ADD ES:[DI],CL
  INC DI
  ADD DI,DX
  INC SI
  REP MOVSB
 POP DS
FIN;

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴콘
 �                        Proc괺ure FillChar                        �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複蔔


 Description
 袴袴袴袴袴�

  Cette proc괺ure d'effacer avec un caract둹e particulier une zone de
 tampon de m굆oire.
}

Proc괺ure FillChar(Var Source;Len:Word;Value:Byte);Assembleur;ASM
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

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴콘
 �                         Proc괺ure FillClr                          �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複蔔


 Description
 袴袴袴袴袴�

  Cette proc괺ure permet d'effacer un tampon avec leur valeur initiale.
}

Proc괺ure FillClr(Var Source;Len:Word);Assembleur;ASM
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

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴콘
 �                           Proc괺ure IncStr                           �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複蔔


 Description
 袴袴袴袴袴�

  Cette proc괺ure permet d'additionner � la fin d'une cha똭e de caract둹e
 Pascal d굁� existante un caract둹e.
}

Proc괺ure IncStr(Var Cha똭e:String;Caract둹e:Char);Assembleur;ASM
 LES DI,Cha똭e
 INC Byte Ptr ES:[DI]
 MOVZX BX,ES:[DI]
 ADD DI,BX
 MOV AL,Caract둹e
 STOSB
FIN;

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴콘
 �                           Proc괺ure Move                           �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複蔔


 Description
 袴袴袴袴袴�

  Cette proc괺ure d굋lacer une tampon de m굆oire vers une autre adresse
 avec une longueur d괽init en param둻rage.
}

Proc괺ure Move(Const Source;Var Dest;Len:Word);Assembleur;ASM
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

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴콘
 �                         Proc괺ure MoveRight                        �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複蔔


 Description
 袴袴袴袴袴�

  Cette proc괺ure d굋lacer une tampon de m굆oire vers une autre adresse
 avec une longueur d괽init en param둻rage.  Le  transfert  s'effectue �
 partir de la fin des deux tampons.
}

Proc괺ure MoveRight(Const Source;Var Dest;Len:Word);Assembleur;ASM
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

{컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�}
FIN.