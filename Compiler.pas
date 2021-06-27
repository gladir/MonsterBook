{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                                                                     Û
 ³                    Malte Genesis/Compilateur                        Û
 ³                                                                     Û
 ³          dition Chantal pour Mode R‚el/IV - Version 1.1            Û
 ³                            1996/09/02                               Û
 ³                                                                     Û
 ³        Tous droits r‚serv‚s par les Chevaliers de Malte (C)         Û
 ³                                                                     Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Nom du programmeur
 ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ

  Sylvain Maltais


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette unit‚ contient les bases fondamentales du traŒtement de texte en
 syntaxe  de  langage  de  programmation  comme  pour  exemple  pour  un
 compilateur.
}

{$I DEF.INC}

Unit Compiler;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                                  INTERFACE
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Uses Systex;

Const NoUpper:Boolean=False;

Function AutoUp(Const Str:String):String;
Function IsDigit(Chr:Char):Boolean;
Function IsLangChrWord(Chr:Char):Boolean;
Function IsMaj(Chr:Char):Boolean;
Function IsMin(Chr:Char):Boolean;
Function IsReservedWordAsm(Const Word:String):Boolean;
Function IsReservedWordBasic(Const Word:String):Boolean;
Function IsReservedWordC(Const Word:String):Boolean;
Function IsReservedWordEuphoria(Const Word:String):Boolean;
Function IsReservedWordPascal(Const Word:String):Boolean;
Function KeyCode2MGPConst(Code:Word):String;
Function PXtrkCNm(Var I:Wd;Line:PChr):String;
Function StrRC2MGP(Const Str:String;Var K:Word):String;
Function XtrkCNm2Pas(Var I:Byte;Const L:String):String;
Function XtrkCStr(Var I:Byte;Const L:String;Var EM:Boolean):String;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                               IMPLEMENTATION
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Uses Systems;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                            Fonction AutoUp                           Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction retourne une chaŒne de caractŠres en majuscule seulement
 si la variable global ®NoUpper¯ est ‚gale … vrai.
}

Function AutoUp;Begin
 If(NoUpper)Then AutoUp:=Str Else AutoUp:=StrUp(Str);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Fonction IsDigit                          Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction retourne vrai si le caractŠre est un chiffre valide de
 format d‚cimal entre 0 et 9. Faux est retourner dans tous autres cas.
}

Function IsDigit;Begin
 IsDigit:=Chr in['0'..'9'];
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Fonction IsLangChrWord                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction retourne vrai s'il s'agit de caractŠre de commen‡ement de
 mot d'un langage de programmation standard.
}

Function IsLangChrWord;Begin
 IsLangChrWord:=Chr in['A'..'Z','a'..'z','_']
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Fonction IsMaj                               Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction retourne vrai  s'il  s'agit  bien de lettre de l'alphabet
 majuscule et faux dans tous les autres cas sans exception.


 Remarque
 ÍÍÍÍÍÍÍÍ

  ş Cette fonction ne tient pas compte des accents et retournera donc faux
    dans cette ‚vantualit‚.
}

Function IsMaj;Begin
 IsMaj:=Chr in['A'..'Z']
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Fonction IsMin                               Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction retourne vrai  s'il  s'agit  bien de lettre de l'alphabet
 minscule et faux dans tous les autres cas sans exception.


 Remarque
 ÍÍÍÍÍÍÍÍ

  ş Cette fonction ne tient pas compte des accents et retournera donc faux
    dans cette ‚vantualit‚.
}

Function IsMin;Begin
 IsMin:=Chr in['a'..'z']
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Fonction IsReservedWordAsm                      Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction  retourne vrai s'il  s'agit d'un mot  r‚serv‚ utilis‚ par le
 langage de programmation assembleur pour les micro-processeurs de la famille
 INTEL.Dans le cas contraire, donc il ne s'agirait manifestement pas d'un mot
 r‚serv‚, il retourne faux (False).


 Remarque
 ÍÍÍÍÍÍÍÍ

  ş Le mot … comparer doit au pr‚alable avoir ‚t‚ tranformer en majuscule car
    il ne considŠre que les mots en majuscule et non pas les minuscules.
}

Function IsReservedWordAsm;Begin
 IsReservedWordAsm:=
  (Word='ASSUME')or
  (Word='CODE')or
  (Word='DATA')or
  (Word='ELSE')or
  (Word='END')or
  (Word='ENDIF')or
  (Word='ENDM')or
  (Word='ENDP')or
  (Word='ENDS')or
  (Word='EXTRN')or
  (Word='FAR')or
  (Word='IFB')or
  (Word='INCLUDE')or
  (Word='MACRO')or
  (Word='NEAR')or
  (Word='OFFSET')or
  (Word='PAGE')or
  (Word='PRIVATE')or
  (Word='PROC')or
  (Word='PUBLIC')or
  (Word='SEGMENT')or
  (Word='STRUC')or
  (Word='TITLE');
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                       Fonction IsReservedWordBasic                     Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction  retourne vrai s'il s'agit d'un mot r‚serv‚ utilis‚ par le
 langage de programmation Basic, Basica, GWBasic, TurboBasic ou QuickBasic.
 Dans le cas  contraire,  donc il ne s'agirait  manifestement pas  d'un mot
 r‚serv‚, il retourne faux (False).


 Remarque
 ÍÍÍÍÍÍÍÍ

  ş Le mot … comparer doit au pr‚alable avoir ‚t‚ tranformer en majuscule car
    il ne considŠre que les mots en majuscule et non pas les minuscules.
}

Function IsReservedWordBasic;Begin
 IsReservedWordBasic:=
  (Word='AND')or
  (Word='BASE')or
  (Word='CALL')or
  (Word='CASE')or
  (Word='CHAIN')or
  (Word='COMMON')or
  (Word='DATA')or
  (Word='DIM')or
  (Word='DO')or
  (Word='DYNAMIC')or
  (Word='ELSE')or
  (Word='END')or
  (Word='ERASE')or
  (Word='FOR')or
  (Word='GOSUB')or
  (Word='GOTO')or
  (Word='IF')or
  (Word='INTERRUPT')or
  (Word='LOOP')or
  (Word='ON')or
  (Word='OPTION')or
  (Word='OR')or
  (Word='NEXT')or
  (Word='NOT')or
  (Word='REM')or
  (Word='RUN')or
  (Word='SELECT')or
  (Word='STEP')or
  (Word='STOP')or
  (Word='SUB')or
  (Word='THEN')or
  (Word='TO')or
  (Word='TROFF')or
  (Word='TRON')or
  (Word='WEND')or
  (Word='WHILE')or
  (Word='XOR');
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                       Fonction IsReservedWordC                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction  retourne vrai s'il s'agit d'un mot r‚serv‚ utilis‚ par le
 langage  de  programmation  C,  C++.  Dans  le cas  contraire,  donc il ne
 s'agirait manifestement pas d'un mot r‚serv‚, il retourne faux (False).
}

Function IsReservedWordC;Begin
 IsReservedWordC:=
  (Word='asm')or
  (Word='auto')or
  (Word='break')or
  (Word='case')or
  (Word='cdcel')or
  (Word='constant')or
  (Word='continue')or
  (Word='default')or
  (Word='do')or
  (Word='else')or
  (Word='enum')or
  (Word='extern')or
  (Word='far')or
  (Word='for')or
  (Word='goto')or
  (Word='huge')or
  (Word='if')or
  (Word='interrupt')or
  (Word='near')or
  (Word='pascal')or
  (Word='register')or
  (Word='return')or
  (Word='signed')or
  (Word='static')or
  (Word='struct')or
  (Word='switch')or
  (Word='typdef')or
  (Word='union')or
  (Word='unsigned')or
  (Word='void')or
  (Word='volatile')or
  (Word='while')or
  (Word='_cs')or
  (Word='_ds')or
  (Word='_es')or
  (Word='_ss')or
  (Word='_AH')or
  (Word='_AL')or
  (Word='_AX')or
  (Word='_BH')or
  (Word='_BL')or
  (Word='_BP')or
  (Word='_BX')or
  (Word='_CH')or
  (Word='_CL')or
  (Word='_CX')or
  (Word='_DH')or
  (Word='_DI')or
  (Word='_DL')or
  (Word='_DX')or
  (Word='_SI')or
  (Word='_SP');
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                       Fonction IsReservedWordEuphoria                    Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction  retourne vrai s'il  s'agit d'un mot  r‚serv‚ utilis‚ par le
 langage de  programmation  ®Euphoria¯.  Dans le cas  contraire,  donc  il ne
 s'agirait manifestement pas d'un mot r‚serv‚, il retourne faux (False).


 Remarque
 ÍÍÍÍÍÍÍÍ

  ş Le mot … comparer doit au pr‚alable avoir ‚t‚ tranformer en majuscule car
    il ne considŠre que les mots en majuscule et non pas les minuscules.
}

Function IsReservedWordEuphoria;Begin
 IsReservedWordEuphoria:=
  (Word='AND')or
  (Word='BY')or
  (Word='CONSTANT')or
  (Word='DO')or
  (Word='DOWNTO')or
  (Word='END')or
  (Word='ELSE')or
  (Word='ELSIF')or
  (Word='EXIT')or
  (Word='FOR')or
  (Word='FUNCTION')or
  (Word='GLOBAL')or
  (Word='IF')or
  (Word='INCLUDE')or
  (Word='OR')or
  (Word='PROCEDURE')or
  (Word='RETURN')or
  (Word='THEN')or
  (Word='TO')or
  (Word='TYPE')or
  (Word='WHILE')or
  (Word='WITHOUT')or
  (Word='XOR');
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                       Fonction IsReservedWordPascal                      Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction  retourne vrai s'il  s'agit d'un mot  r‚serv‚ utilis‚ par le
 langage de  programmation  ®Pascal¯.  Dans  le  cas  contraire,  donc  il ne
 s'agirait manifestement pas d'un mot r‚serv‚, il retourne faux (False).


 Remarque
 ÍÍÍÍÍÍÍÍ

  ş Le mot … comparer doit au pr‚alable avoir ‚t‚ tranformer en majuscule car
    il ne considŠre que les mots en majuscule et non pas les minuscules.
}

Function IsReservedWordPascal;Begin
 IsReservedWordPascal:=
  (Word='AND')or
  (Word='ASSEMBLER')or
  (Word='ASM')or
  (Word='ARRAY')or
  (Word='BEGIN')or
  (Word='CASE')or
  (Word='CONST')or
  (Word='CONSTRUCTOR')or
  (Word='DESTRUCTOR')or
  (Word='DIV')or
  (Word='DO')or
  (Word='DOWNTO')or
  (Word='ELSE')or
  (Word='END')or
  (Word='EXPORTS')or
  (Word='FILE')or
  (Word='FOR')or
  (Word='FUNCTION')or
  (Word='GOTO')or
  (Word='IF')or
  (Word='IMPLEMENTATION')or
  (Word='IN')or
  (Word='INHERITED')or
  (Word='INLINE')or
  (Word='INTERFACE')or
  (Word='LABEL')or
  (Word='LIBRARY')or
  (Word='MOD')or
  (Word='NIL')or
  (Word='NOT')or
  (Word='OBJECT')or
  (Word='OF')or
  (Word='OR')or
  (Word='PACKED')or
  (Word='PROCEDURE')or
  (Word='PROGRAM')or
  (Word='RECORD')or
  (Word='REPEAT')or
  (Word='SET')or
  (Word='SHL')or
  (Word='SHR')or
  (Word='STRING')or
  (Word='THEN')or
  (Word='TO')or
  (Word='TYPE')or
  (Word='UNIT')or
  (Word='UNTIL')or
  (Word='USES')or
  (Word='VAR')or
  (Word='VIRTUEL')or
  (Word='WHILE')or
  (Word='WITH')or
  (Word='XOR');
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                      Fonction KeyCode2MGPConst                     Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction convertit une constante  de code clavier sous forme de
 constante de langage de programmation de l'ensemble Malte Genesis pour
 Pascal.
}

Function KeyCode2MGPConst;
Const
 StrFunc:Array[0..9]of String[3]=(
  'F1','F2','F3','F4','F5','F6','F7','F8','F9','F10'
 );
Begin
 Case Code of
  kbShiftF1..kbShiftF10: KeyCode2MGPConst:='kbShift'+StrFunc[Hi(Code)-Hi(kbShiftF1)];
  kbCtrlF1..kbCtrlF10: KeyCode2MGPConst:='kbCtrl'+StrFunc[Hi(Code)-Hi(kbCtrlF1)];
  kbAltF1..kbAltF10: KeyCode2MGPConst:='kbAlt'+StrFunc[Hi(Code)-Hi(kbAltF1)];
  kbAlt1..kbAlt9: KeyCode2MGPConst:='kbAlt'+Char(Byte('1')+(Hi(Code) - Hi(kbAlt1)));
  kbAlt0: KeyCode2MGPConst:='kbAlt0';
  kbEsc: KeyCode2MGPConst:='kbEsc';
  kbAltSpc: KeyCode2MGPConst:='kbAltSpc';
  kbCtrlIns: KeyCode2MGPConst:='kbCtrlIns';
  kbShiftIns: KeyCode2MGPConst:='kbShiftIns';
  kbCtrlDel: KeyCode2MGPConst:='kbCtrlDel';
  kbShiftDel: KeyCode2MGPConst:='kbShiftDel';
  kbBS: KeyCode2MGPConst:='kbBS';
  kbAltBS: KeyCode2MGPConst:='kbAltBS';
  kbCtrlBS: KeyCode2MGPConst:='kbCtrlBS';
  kbShiftTab: KeyCode2MGPConst:='kbShiftTab';
  kbTab: KeyCode2MGPConst:='kbTab';
  kbCtrlEnter: KeyCode2MGPConst:='kbCtrlEnter';
  kbEnter: KeyCode2MGPConst:='kbEnter';
  kbF1..kbF10: KeyCode2MGPConst:='kb'+StrFunc[Hi(Code)-Hi(kbF1)];
  kbHome: KeyCode2MGPConst:='kbHome';
  kbUp: KeyCode2MGPConst:='kbUp';
  kbPgUp: KeyCode2MGPConst:='kbPgUp';
  kbLeft: KeyCode2MGPConst:='kbLeft';
  kbRight: KeyCode2MGPConst:='kbRight';
  kbEnd: KeyCode2MGPConst:='kbEnd';
  kbDn: KeyCode2MGPConst:='kbDn';
  kbPgDn: KeyCode2MGPConst:='kbPgDn';
  kbIns: KeyCode2MGPConst:='kbIns';
  kbDel: KeyCode2MGPConst:='kbDel';
  kbCtrlPrtSc: KeyCode2MGPConst:='kbCtrlPrtSc';
  kbCtrlLeft: KeyCode2MGPConst:='kbCtrlLeft';
  kbCtrlRight: KeyCode2MGPConst:='kbCtrlRight';
  kbCtrlEnd: KeyCode2MGPConst:='kbCtrlEnd';
  kbCtrlPgDn: KeyCode2MGPConst:='kbCtrlPgDn';
  kbCtrlHome: KeyCode2MGPConst:='kbCtrlHome';
  kbAltEqual: KeyCode2MGPConst:='kbAltEqual';
  kbCtrlPgUp: KeyCode2MGPConst:='kbCtrlPgUp';
  kbF11: KeyCode2MGPConst:='kbF11';
  kbF12: KeyCode2MGPConst:='kbF12';
  kbShiftF11: KeyCode2MGPConst:='kbShiftF11';
  kbShiftF12: KeyCode2MGPConst:='kbShiftF12';
  kbCtrlF11: KeyCode2MGPConst:='kbCtrlF11';
  kbCtrlF12: KeyCode2MGPConst:='kbCtrlF12';
  kbAltF11: KeyCode2MGPConst:='kbAltF11';
  kbAltF12: KeyCode2MGPConst:='kbAltF12';
  kbCtrlUp: KeyCode2MGPConst:='kbCtrlUp';
  kbCtrlDn: KeyCode2MGPConst:='kbCtrlDn';
  kbAltA: KeyCode2MGPConst:='kbAltA';
  kbAltB: KeyCode2MGPConst:='kbAltB';
  kbAltC: KeyCode2MGPConst:='kbAltC';
  kbAltD: KeyCode2MGPConst:='kbAltD';
  kbAltE: KeyCode2MGPConst:='kbAltE';
  kbAltF: KeyCode2MGPConst:='kbAltF';
  kbAltG: KeyCode2MGPConst:='kbAltG';
  kbAltH: KeyCode2MGPConst:='kbAltH';
  kbAltI: KeyCode2MGPConst:='kbAltI';
  kbAltJ: KeyCode2MGPConst:='kbAltJ';
  kbAltK: KeyCode2MGPConst:='kbAltK';
  kbAltL: KeyCode2MGPConst:='kbAltL';
  kbAltM: KeyCode2MGPConst:='kbAltM';
  kbAltN: KeyCode2MGPConst:='kbAltN';
  kbAltO: KeyCode2MGPConst:='kbAltO';
  kbAltP: KeyCode2MGPConst:='kbAltP';
  kbAltQ: KeyCode2MGPConst:='kbAltQ';
  kbAltR: KeyCode2MGPConst:='kbAltR';
  kbAltS: KeyCode2MGPConst:='kbAltS';
  kbAltT: KeyCode2MGPConst:='kbAltT';
  kbAltU: KeyCode2MGPConst:='kbAltU';
  kbAltV: KeyCode2MGPConst:='kbAltV';
  kbAltW: KeyCode2MGPConst:='kbAltW';
  kbAltX: KeyCode2MGPConst:='kbAltX';
  kbAltY: KeyCode2MGPConst:='kbAltY';
  kbAltZ: KeyCode2MGPConst:='kbAltZ';
  Else KeyCode2MGPConst:=IntToStr(Code);
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Fonction StrRC2MGP                     Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet  la  conversion  d'une  chaŒne de caractŠres
 repr‚sentant une combinaison clavier sous forme ASCII et Scan Code.
}

Function StrRC2MGP(Const Str:String;Var K:Word):String;
Var
 PStr,UStr:String;
 I:Byte;
 StrLen:Byte Absolute Str;

 Function UCmp(Msg:String):Boolean;
 Var
  MsgLen:Byte Absolute Msg;
 Begin
  UCmp:=False;
  If K<>$FFFFThen Exit;
  If Msg=Copy(UStr,I,MsgLen)Then Begin
   Inc(I,MsgLen);UCmp:=True;
  End;
 End;

Begin
 PStr:='';K:=0;I:=1;
 While(I<=StrLen)do Begin
  If Str[I]=#7Then Begin
   If(I+1<=StrLen)Then Begin
    K:=$FFFF;Inc(I);
    UStr:=StrUp(Str);
    If UCmp('^A')Then K:=kbCtrlA;
    If UCmp('^B')Then K:=kbCtrlB;
    If UCmp('^C')Then K:=kbCtrlC;
    If UCmp('^D')Then K:=kbCtrlD;
    If UCmp('^E')Then K:=kbCtrlE;
    If UCmp('^F')Then K:=kbCtrlF;
    If UCmp('^G')Then K:=kbCtrlG;
    If UCmp('^H')Then K:=kbCtrlH;
    If UCmp('^I')Then K:=kbCtrlI;
    If UCmp('^J')Then K:=kbCtrlJ;
    If UCmp('^K')Then K:=kbCtrlK;
    If UCmp('^L')Then K:=kbCtrlL;
    If UCmp('^M')Then K:=kbCtrlM;
    If UCmp('^N')Then K:=kbCtrlN;
    If UCmp('^O')Then K:=kbCtrlO;
    If UCmp('^P')Then K:=kbCtrlP;
    If UCmp('^Q')Then K:=kbCtrlQ;
    If UCmp('^R')Then K:=kbCtrlR;
    If UCmp('^S')Then K:=kbCtrlS;
    If UCmp('^T')Then K:=kbCtrlT;
    If UCmp('^U')Then K:=kbCtrlU;
    If UCmp('^V')Then K:=kbCtrlV;
    If UCmp('^W')Then K:=kbCtrlW;
    If UCmp('^X')Then K:=kbCtrlX;
    If UCmp('^Y')Then K:=kbCtrlY;
    If UCmp('^Z')Then K:=kbCtrlZ;
    If UCmp('ALT+0')or UCmp('ALT-0')Then K:=kbAlt0;
    If UCmp('ALT+1')or UCmp('ALT-1')Then K:=kbAlt1;
    If UCmp('ALT+2')or UCmp('ALT-2')Then K:=kbAlt2;
    If UCmp('ALT+3')or UCmp('ALT-3')Then K:=kbAlt3;
    If UCmp('ALT+4')or UCmp('ALT-4')Then K:=kbAlt4;
    If UCmp('ALT+5')or UCmp('ALT-5')Then K:=kbAlt5;
    If UCmp('ALT+6')or UCmp('ALT-6')Then K:=kbAlt6;
    If UCmp('ALT+7')or UCmp('ALT-7')Then K:=kbAlt7;
    If UCmp('ALT+8')or UCmp('ALT-8')Then K:=kbAlt8;
    If UCmp('ALT+9')or UCmp('ALT-9')Then K:=kbAlt9;
    If UCmp('ALT+A')or UCmp('ALT-A')Then K:=kbAltA;
    If UCmp('ALT+BKSP')or UCmp('ALT-BKSP')Then K:=kbAltBS;
    If UCmp('ALT+B')or UCmp('ALT-B')Then K:=kbAltB;
    If UCmp('ALT+C')or UCmp('ALT-C')Then K:=kbAltC;
    If UCmp('ALT+D')or UCmp('ALT-D')Then K:=kbAltD;
    If UCmp('ALT+EQUAL')or UCmp('ALT-EQUAL')Then K:=kbAltEqual;
    If UCmp('ALT+E')or UCmp('ALT-E')Then K:=kbAltE;
    If UCmp('ALT+F1')or UCmp('ALT-F1')Then K:=kbAltF1;
    If UCmp('ALT+F2')or UCmp('ALT-F2')Then K:=kbAltF2;
    If UCmp('ALT+F3')or UCmp('ALT-F3')Then K:=kbAltF3;
    If UCmp('ALT+F4')or UCmp('ALT-F4')Then K:=kbAltF4;
    If UCmp('ALT+F5')or UCmp('ALT-F5')Then K:=kbAltF5;
    If UCmp('ALT+F6')or UCmp('ALT-F6')Then K:=kbAltF6;
    If UCmp('ALT+F7')or UCmp('ALT-F7')Then K:=kbAltF7;
    If UCmp('ALT+F8')or UCmp('ALT-F8')Then K:=kbAltF8;
    If UCmp('ALT+F9')or UCmp('ALT-F9')Then K:=kbAltF9;
    If UCmp('ALT+F10')or UCmp('ALT-F10')Then K:=kbAltF10;
    If UCmp('ALT+F11')or UCmp('ALT-F11')Then K:=kbAltF11;
    If UCmp('ALT+F12')or UCmp('ALT-F12')Then K:=kbAltF12;
    If UCmp('ALT+F')or UCmp('ALT-F')Then K:=kbAltF;
    If UCmp('ALT+G')or UCmp('ALT-G')Then K:=kbAltG;
    If UCmp('ALT+H')or UCmp('ALT-H')Then K:=kbAltH;
    If UCmp('ALT+I')or UCmp('ALT-I')Then K:=kbAltI;
    If UCmp('ALT+J')or UCmp('ALT-J')Then K:=kbAltJ;
    If UCmp('ALT+K')or UCmp('ALT-K')Then K:=kbAltK;
    If UCmp('ALT+L')or UCmp('ALT-L')Then K:=kbAltL;
    If UCmp('ALT+M')or UCmp('ALT-M')Then K:=kbAltM;
    If UCmp('ALT+N')or UCmp('ALT-N')Then K:=kbAltN;
    If UCmp('ALT+O')or UCmp('ALT-O')Then K:=kbAltO;
    If UCmp('ALT+P')or UCmp('ALT-P')Then K:=kbAltP;
    If UCmp('ALT+Q')or UCmp('ALT-Q')Then K:=kbAltQ;
    If UCmp('ALT+R')or UCmp('ALT-R')Then K:=kbAltR;
    If UCmp('ALT+SPACE')or UCmp('ALT-SPACE')or UCmp('ALT+SP')or UCmp('ALT-SP')Then K:=kbAltSpc;
    If UCmp('ALT+S')or UCmp('ALT-S')Then K:=kbAltS;
    If UCmp('ALT+T')or UCmp('ALT-T')Then K:=kbAltT;
    If UCmp('ALT+U')or UCmp('ALT-U')Then K:=kbAltU;
    If UCmp('ALT+V')or UCmp('ALT-V')Then K:=kbAltV;
    If UCmp('ALT+W')or UCmp('ALT-W')Then K:=kbAltW;
    If UCmp('ALT+X')or UCmp('ALT-X')Then K:=kbAltX;
    If UCmp('ALT+Y')or UCmp('ALT-Y')Then K:=kbAltY;
    If UCmp('ALT+Z')or UCmp('ALT-Z')Then K:=kbAltZ;
    If UCmp('BACKSPACE')or UCmp('BACK')or UCmp('BS')Then K:=kbBS;
    If UCmp('CTRL+A')or UCmp('CTRL-A')Then K:=kbCtrlA;
    If UCmp('CTRL+BACKSPACE')or UCmp('CTRL-BACKSPACE')or UCmp('CTRL+BACK')or
       UCmp('CTRL-BACK')or UCmp('CTRL+BS')or UCmp('CTRL-BS')Then K:=kbCtrlBS;
    If UCmp('CTRL+B')or UCmp('CTRL-B')Then K:=kbCtrlB;
    If UCmp('CTRL+C')or UCmp('CTRL-C')Then K:=kbCtrlC;
    If UCmp('CTRL+DELETE')or UCmp('CTRL-DELETE')or UCmp('CTRL+DEL')Then K:=kbCtrlDel;
    If UCmp('CTRL+DN')or UCmp('CTRL-DN')or UCmp('CTRL+DOWN')or UCmp('CTRL-DOWN')Then K:=kbCtrlDn;
    If UCmp('CTRL+D')or UCmp('CTRL-D')Then K:=kbCtrlD;
    If UCmp('CTRL+END')or UCmp('CTRL-END')Then K:=kbCtrlEnd;
    If UCmp('CTRL+ENTER')or UCmp('CTRL-ENTER')or UCmp('CTRL+ENT')or UCmp('CTRL-ENT')Then K:=kbCtrlEnter;
    If UCmp('CTRL+E')or UCmp('CTRL-E')Then K:=kbCtrlE;
    If UCmp('CTRL+F1')or UCmp('CTRL-F1')Then K:=kbCtrlF1;
    If UCmp('CTRL+F2')or UCmp('CTRL-F2')Then K:=kbCtrlF2;
    If UCmp('CTRL+F3')or UCmp('CTRL-F3')Then K:=kbCtrlF3;
    If UCmp('CTRL+F4')or UCmp('CTRL-F4')Then K:=kbCtrlF4;
    If UCmp('CTRL+F5')or UCmp('CTRL-F5')Then K:=kbCtrlF5;
    If UCmp('CTRL+F6')or UCmp('CTRL-F6')Then K:=kbCtrlF6;
    If UCmp('CTRL+F7')or UCmp('CTRL-F7')Then K:=kbCtrlF7;
    If UCmp('CTRL+F8')or UCmp('CTRL-F8')Then K:=kbCtrlF8;
    If UCmp('CTRL+F9')or UCmp('CTRL-F9')Then K:=kbCtrlF9;
    If UCmp('CTRL+F10')or UCmp('CTRL-F10')Then K:=kbCtrlF10;
    If UCmp('CTRL+F11')or UCmp('CTRL-F11')Then K:=kbCtrlF11;
    If UCmp('CTRL+F12')or UCmp('CTRL-F12')Then K:=kbCtrlF12;
    If UCmp('CTRL+F')or UCmp('CTRL-F')Then K:=kbCtrlF;
    If UCmp('CTRL+G')or UCmp('CTRL-G')Then K:=kbCtrlG;
    If UCmp('CTRL+HOME')or UCmp('CTRL-HOME')Then K:=kbCtrlH;
    If UCmp('CTRL+H')or UCmp('CTRL-H')Then K:=kbCtrlH;
    If UCmp('CTRL+INSERT')or UCmp('CTRL-INSERT')or UCmp('CTRL+INS')or UCmp('CTRL-INS')Then K:=kbCtrlIns;
    If UCmp('CTRL+I')or UCmp('CTRL-I')Then K:=kbCtrlI;
    If UCmp('CTRL+J')or UCmp('CTRL-J')Then K:=kbCtrlJ;
    If UCmp('CTRL+K')or UCmp('CTRL-K')Then K:=kbCtrlK;
    If UCmp('CTRL+LEFT')or UCmp('CTRL-LEFT')Then K:=kbCtrlLeft;
    If UCmp('CTRL+L')or UCmp('CTRL-L')Then K:=kbCtrlL;
    If UCmp('CTRL+M')or UCmp('CTRL-M')Then K:=kbCtrlM;
    If UCmp('CTRL+N')or UCmp('CTRL-N')Then K:=kbCtrlN;
    If UCmp('CTRL+O')or UCmp('CTRL-O')Then K:=kbCtrlO;
    If UCmp('CTRL+PAGE DOWN')or UCmp('CTRL-PAGE DOWN')Then K:=kbCtrlPgDn;
    If UCmp('CTRL+PAGE UP')or UCmp('CTRL-PAGE UP')Then K:=kbCtrlPgUp;
    If UCmp('CTRL+PAGEDOWN')or UCmp('CTRL-PAGEDOWN')Then K:=kbCtrlPgDn;
    If UCmp('CTRL+PAGEUP')or UCmp('CTRL-PAGEUP')Then K:=kbCtrlPgDn;
    If UCmp('CTRL+PGDN')or UCmp('CTRL-PGDN')Then K:=kbCtrlPgDn;
    If UCmp('CTRL+PGUP')or UCmp('CTRL-PGUP')Then K:=kbCtrlPgDn;
    If UCmp('CTRL+PRINTSCREEN')or UCmp('CTRL-PRINTSCREEN')or UCmp('CTRL+PRTSC')or UCmp('CTRL-PRTSC')Then K:=kbCtrlPrtSc;
    If UCmp('CTRL+P')or UCmp('CTRL-P')Then K:=kbCtrlP;
    If UCmp('CTRL+Q')or UCmp('CTRL-Q')Then K:=kbCtrlQ;
    If UCmp('CTRL+RIGHT')or UCmp('CTRL-RIGHT')Then K:=kbCtrlRight;
    If UCmp('CTRL+R')or UCmp('CTRL-R')Then K:=kbCtrlR;
    If UCmp('CTRL+S')or UCmp('CTRL-S')Then K:=kbCtrlS;
    If UCmp('CTRL+T')or UCmp('CTRL-T')Then K:=kbCtrlT;
    If UCmp('CTRL+UP')or UCmp('CTRL-UP')Then K:=kbCtrlUp;
    If UCmp('CTRL+U')or UCmp('CTRL-U')Then K:=kbCtrlU;
    If UCmp('CTRL+V')or UCmp('CTRL-V')Then K:=kbCtrlV;
    If UCmp('CTRL+W')or UCmp('CTRL-W')Then K:=kbCtrlW;
    If UCmp('CTRL+X')or UCmp('CTRL-X')Then K:=kbCtrlX;
    If UCmp('CTRL+Y')or UCmp('CTRL-Y')Then K:=kbCtrlY;
    If UCmp('CTRL+Z')or UCmp('CTRL-Z')Then K:=kbCtrlZ;
    If UCmp('DEL')Then K:=kbDel;
    If UCmp('DOWN')Then K:=kbDn;
    If UCmp('END')Then K:=kbEnd;
    If UCmp('ENTER')Then K:=kbEnter;
    If UCmp('ESCAPE')Then K:=kbEsc;
    If UCmp('ESC')Then K:=kbEsc;
    If UCmp('F1')Then K:=kbF1;
    If UCmp('F2')Then K:=kbF2;
    If UCmp('F3')Then K:=kbF3;
    If UCmp('F4')Then K:=kbF4;
    If UCmp('F5')Then K:=kbF5;
    If UCmp('F6')Then K:=kbF6;
    If UCmp('F7')Then K:=kbF7;
    If UCmp('F8')Then K:=kbF8;
    If UCmp('F9')Then K:=kbF9;
    If UCmp('F10')Then K:=kbF10;
    If UCmp('F11')Then K:=kbF11;
    If UCmp('F12')Then K:=kbF12;
    If UCmp('HOME')Then K:=kbHome;
    If UCmp('INSERT')Then K:=kbIns;
    If UCmp('INS')Then K:=kbIns;
    If UCmp('LEFT')Then K:=kbLeft;
    If UCmp('PAGE DOWN')Then K:=kbPgDn;
    If UCmp('PAGE UP')Then K:=kbPgUp;
    If UCmp('PAGEDOWN')Then K:=kbPgDn;
    If UCmp('PAGEUP')Then K:=kbPgUp;
    If UCmp('PGDN')Then K:=kbPgDn;
    If UCmp('PGUP')Then K:=kbPgUp;
    If UCmp('RIGHT')Then K:=kbRight;
    If UCmp('SHIFT+DELETE')or UCmp('SHIFT-DELETE')Then K:=kbShiftDel;
    If UCmp('SHIFT+DEL')or UCmp('SHIFT-DEL')Then K:=kbShiftDel;
    If UCmp('SHIFT+F1')or UCmp('SHIFT-F1')Then K:=kbF1;
    If UCmp('SHIFT+F2')or UCmp('SHIFT-F2')Then K:=kbF2;
    If UCmp('SHIFT+F3')or UCmp('SHIFT-F3')Then K:=kbF3;
    If UCmp('SHIFT+F4')or UCmp('SHIFT-F4')Then K:=kbF4;
    If UCmp('SHIFT+F5')or UCmp('SHIFT-F5')Then K:=kbF5;
    If UCmp('SHIFT+F6')or UCmp('SHIFT-F6')Then K:=kbF6;
    If UCmp('SHIFT+F7')or UCmp('SHIFT-F7')Then K:=kbF7;
    If UCmp('SHIFT+F8')or UCmp('SHIFT-F8')Then K:=kbF8;
    If UCmp('SHIFT+F9')or UCmp('SHIFT-F9')Then K:=kbF9;
    If UCmp('SHIFT+F10')or UCmp('SHIFT-F10')Then K:=kbF10;
    If UCmp('SHIFT+F11')or UCmp('SHIFT-F11')Then K:=kbF11;
    If UCmp('SHIFT+F12')or UCmp('SHIFT-F12')Then K:=kbF12;
    If UCmp('SHIFT+INS')Then K:=kbShiftIns;
    If UCmp('SHIFT+TAB')Then K:=kbShiftTab;
    If UCmp('TABULATION')or UCmp('TAB')Then K:=kbTab;
   End;
  End
   Else
  If Str[I]='&'Then Begin
   If(I+1<=StrLen)Then Begin
    Inc(I);
    AddStr(PStr,'^'+Str[I]+'^');
   End;
  End
   Else
  IncStr(PStr,Str[I]);
  Inc(I);
 End;
 StrRC2MGP:=PStr;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                             Fonction PXtrkCNm                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction extrait un nombre de format de langage C/C++ d'une chaŒne
 de caractŠres ASCIIZ … partir de la position du pointeur I.  La valeur de
 la variable de param‚trage  I est modifi‚ pour pointer … la fin du nombre
 venant d'ˆtre extrait.
}

{$I Library\Compiler\C\PXtrkCNm.Inc}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                             Fonction XtrkCNmPas                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction transforme chaŒne de caractŠre de valeur num‚rique d‚finit
 en format Pascal.
}

Function XtrkCNm2Pas;Begin
 XtrkCNm2Pas:='';
 If I>Length(L)Then Exit;
 Case L[I]of
  '0':If I+1>Length(L)Then Begin Inc(I);XtrkCNm2Pas:='0';End Else
  Case L[I+1]of
   '0'..'7':Begin
    Inc(I);
    XtrkCNm2Pas:=IntToStr(OctStr2Nm(XtrkOctNm(I,L)))
   End;
   'B','b':Begin
    Inc(I,2);
    XtrkCNm2Pas:=IntToStr(BinStr2Nm(XtrkBinNm(I,L)))
   End;
   'X','x':Begin
    Inc(I,2);
    XtrkCNm2Pas:='$'+XtrkHexNm(I,L)
   End;
   'L','l':Begin
    Inc(I,2);
    XtrkCNm2Pas:='LongInt(0)'
   End;
   Else Begin
    XtrkCNm2Pas:='0';
    Inc(I)
   End;
  End;
  '1'..'9':
  If(I<=Length(L))and(L[I]='L')Then XtrkCNm2Pas:='LongInt('+XtrkDecNm(I,L)+')'
			       Else XtrkCNm2Pas:=XtrkDecNm(I,L);
  Else
  XtrkCNm2Pas:='';
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Fonction XtrkCStr                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet d'extraire  une chaŒne de caractŠres ‚crit en
 guillemet du langage C sous r‚sultat de sortie aprŠs interpr‚tation.
}

Function XtrkCStr;
Var
 M,NS:String;
 J:Byte;
 W:Word;

 Function EndStr:Boolean;Begin
  EndStr:=I>Length(L);
 End;

Begin
 XtrkCStr:='';EM:=True;M:='';Inc(I);
 While L[I]<>'"'do Begin
  If I>Length(L)Then Exit;
  If L[I]='\'Then Begin
   Inc(I);
   If Not(EndStr)Then Begin
    Case L[I]of
     '?':IncStr(M,'?');
     '\':IncStr(M,'\');
     '"':IncStr(M,'"');
     '''':IncStr(M,'''');
     '0':Begin
      J:=0;NS:='';
      While L[I]in['0'..'7']do Begin
       IncStr(NS,L[I]);Inc(I);
       If(EndStr)Then Exit;
       Inc(J);
       If J>3Then Break;
      End;
      IncStr(M,Char(OctStr2Nm(NS)));Dec(I);
     End;
     'a':IncStr(M,#7);
     'b':IncStr(M,#8);
     'f':IncStr(M,#$C);
     'n':IncStr(M,#$A);
     'r':IncStr(M,#$D);
     't':IncStr(M,#$B);
     'x':Begin
      J:=0;NS:='';
      While L[I]in['0'..'9','A'..'F','a'..'f']do Begin
       IncStr(NS,L[I]);Inc(I);
       If(EndStr)Then Exit;
       Inc(J);
       If J>3Then Break;
      End;
      W:=HexStrToInt(NS);
      If Hi(W)=0Then IncStr(M,Char(W))
                Else AddStr(M,Char(W)+Char(Hi(W)));
     End;
     Else
     IncStr(M,L[I]);
    End;
    Inc(I);
   End
    Else
   Exit;
  End
   Else
  Begin
   IncStr(M,L[I]);
   Inc(I);
  End;
 End;
 XtrkCStr:=M;EM:=False;
End;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
END.