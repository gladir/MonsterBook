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

Uses PCCortex;

Procedure PCStart(Var Q:PCApp);
Procedure InitCompiler;

{컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�}
                                IMPLEMENTATION
{컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�}

Uses Dialex,Restex,ResServD,Systex,Memories,Systems,PCBase;

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴콘
 �                    Proc괺ure InitCompiler                      �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複蔔


 Description
 袴袴袴袴袴�

  Cette proc괺ure permet d'initialiser les structures par d괽aut du
 compilateur de langage Pascal niveau B57.
}

Procedure InitCompiler;Begin
 ALInit(CurrPC.ResWordBk);
 ALInit(CurrPC.VarBk);               { Initialise la liste des variables }
 ALInit(CurrPC.ReDef);               { Initialise la liste des constantes }
 ALInit(CurrPC.ProcBk);              { Initialise la liste des proc괺ures }
 ALInit(CurrPC.UnitList);            { Initialise la liste des unit굎 }
 ALAddStr(CurrPC.UnitList,'SYSTEM'); { Indique l'unit� par d괽aut }
 ALInit(CurrPC.Include);             { Initialise la liste des inclusions }
 ALInit(CurrPC.Jump);                { Initialise la liste des sauts }
 ALInit(CurrPC.SuppData);            { Initialise la liste des donn괻s suppl굆entaires }
 ALInit(CurrPC.Macro);               { Initialise la liste des Macros }
 ALInit(CurrPC.ExternProc);          { Initialise la liste des routines externes }
 ALInit(CurrPC.ExternVar);           { Initialise la liste des variables externes }
 ALInit(CurrPC.TypeDef);             { Initialise la liste des types }
 If((ProgramFormat)in[fEXE])and(ProgramTarget=ftWin31)Then Begin
  CurrPC.Org:=0;
 End
  Else
 CurrPC.Org:=$100;                   { Fixe l'origine du programme � 100h }
 CurrPC.IP:=CurrPC.Org+3;
 CurrPC.DP:=0;
 LastNameVar:='';
 LastUnitNum:=0;
 CurrPC.ResWordDef:=No;
 CurrPC.NmResWord:=0;
 CurrPC.SizeResWord:=0;
 CurrPC.I:=1;
 CurrPC.Status:=0;
End;

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴콘
 �                           Proc괺ure InitBuffer                           �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複蔔


 Description
 袴袴袴袴袴�

  Cette proc괺ure permet d'initialiser les tampons de travails du compilateur
 Pascal niveau B57.
}

Procedure PCStart(Var Q:PCApp);Begin
 FillClr(Q,SizeOf(Q));
 DBOpenServerName(ChantalServer,'CHANTAL:/Compilateur/Pascal/MotsReserves.Dat');
 DBCopyToMemory(ChantalServer,Q.MainWord);
 DBOpenServerName(ChantalServer,'CHANTAL:/CPU/Intel/Instr.Dat');
 DBCopyToMemory(ChantalServer,Q.InstrAsm);
 DBOpenServerName(ChantalServer,'CHANTAL:/CPU/Intel/Registre.Dat');
 DBCopyToMemory(ChantalServer,Q.RegAsm);
 DBOpenServerName(ChantalServer,'CHANTAL:/CPU/Intel/ConditionSi.Dat');
 DBCopyToMemory(ChantalServer,Q.IfCondAsm);
 Q.CodePrg:=MemAlloc(65520);    { R굎erve un tampon de 64 Ko }
 {$IFDEF IDE}
  Body:=bPRELUDE;
 {$ENDIF}
End;

{컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�}
END.