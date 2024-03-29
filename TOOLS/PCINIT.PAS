{ 컴  컴  컴  컴  컴  컴  컴  컴  컴  컴  컴  컴  컴  컴  컴  컴  컴  컴

 �             Compilateur Pascal Niveau B57/Initialisation             �
                     Malte Genesis IV: Alias Chantal
 �                                                                      �
            Tous droits r굎erv굎 par les Chevaliers de Malte
 �                                                                      �

 �                            1998 � 2000                               �

  컴  컴  컴  컴  컴  컴  컴  컴  컴  컴  컴  컴  컴  컴  컴  컴  컴  컴


 Nom du programmeur
 袴袴袴袴袴袴袴袴袴

  Sylvain Maltais


 Description
 袴袴袴袴袴�

  Cette unit� renferme les routines d'initialisations du compilateur de
 langage Pascal niveau B57.  Ce sont les  donn괻s  devant 늯re utilis괻
 par d괽aut  par  le  compilateur  advenant  qu'aucune d괽inition n'est
 sp괹ifier par l'utilisateur.
}

Unit PCInit;

{컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�}
                                  INTERFACE
{컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�}

Procedure InitBuffer;
Procedure InitCompiler;

{컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�}
                                IMPLEMENTATION
{컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�}

Uses Systex,PCCortex,Systems,PCBase;

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴콘
 �                    Proc괺ure InitCompiler                      �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複蔔


 Description
 袴袴袴袴袴�

  Cette proc괺ure permet d'initialiser les structures par d괽aut du
 compilateur de langage Pascal niveau B57.
}

Procedure InitCompiler;Begin
 RBInit(ResWordBk);
 RBInit(VarBk);               { Initialise la liste des variables }
 RBInit(ReDef);               { Initialise la liste des constantes }
 RBInit(ProcBk);              { Initialise la liste des proc괺ures }
 RBInit(UnitList);            { Initialise la liste des unit굎 }
 RBAddStr(UnitList,'SYSTEM'); { Indique l'unit� par d괽aut }
 RBInit(Include);             { Initialise la liste des inclusions }
 RBInit(Jump);                { Initialise la liste des sauts }
 RBInit(SuppData);            { Initialise la liste des donn괻s suppl굆entaires }
 RBInit(Macro);               { Initialise la liste des Macros }
 RBInit(ExternProc);          { Initialise la liste des routines externes }
 RBInit(ExternVar);           { Initialise la liste des variables externes }
 RBInit(TypeDef);             { Initialise la liste des types }
 If((ProgramFormat)in[fEXE])and(ProgramTarget=ftWin31)Then Begin
  Org:=0;
 End
  Else
 Org:=$100;                   { Fixe l'origine du programme � 100h }
 IP:=Org+3;DP:=0;
 LastNameVar:='';LastUnitNum:=0;
 ResWordDef:=No;
 NmResWord:=0;
 SizeResWord:=0;I:=1;
 Status:=0;
End;

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴콘
 �                           Proc괺ure InitBuffer                           �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複蔔


 Description
 袴袴袴袴袴�

  Cette proc괺ure permet d'initialiser les tampons de travails du compilateur
 Pascal niveau B57.
}

Procedure InitBuffer;Begin
 CodePrg:=MemAlloc(65520);    { R굎erve un tampon de 64 Ko }
 FillClr(ArrayCond,SizeOf(ArrayCond));
 CurrCond:=0;
 {$IFDEF IDE}
  InRem:=No;Body:=bPRELUDE;
 {$ENDIF}
 S:='';S2:='';S3:='';S4:='';S5:='';S6:='';
 CaseLevel:=0;IfLevel:=0;
End;

{컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�}
END.