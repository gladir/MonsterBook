{ ÄÄ  ÄÄ  ÄÄ  ÄÄ  ÄÄ  ÄÄ  ÄÄ  ÄÄ  ÄÄ  ÄÄ  ÄÄ  ÄÄ  ÄÄ  ÄÄ  ÄÄ  ÄÄ  ÄÄ  ÄÄ

 ³             Compilateur Pascal Niveau B57/Initialisation             ³
                     Malte Genesis IV: Alias Chantal
 ³                                                                      ³
            Tous droits r‚serv‚s par les Chevaliers de Malte
 ³                                                                      ³

 ³                            1998 … 2000                               ³

  ÄÄ  ÄÄ  ÄÄ  ÄÄ  ÄÄ  ÄÄ  ÄÄ  ÄÄ  ÄÄ  ÄÄ  ÄÄ  ÄÄ  ÄÄ  ÄÄ  ÄÄ  ÄÄ  ÄÄ  ÄÄ


 Nom du programmeur
 ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ

  Sylvain Maltais


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette unit‚ renferme les routines d'initialisations du compilateur de
 langage Pascal niveau B57.  Ce sont les  donn‚es  devant ˆtre utilis‚e
 par d‚faut  par  le  compilateur  advenant  qu'aucune d‚finition n'est
 sp‚cifier par l'utilisateur.
}

Unit PCInit;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                                  INTERFACE
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Uses PCCortex;

Procedure PCStart(Var Q:PCApp);
Procedure InitCompiler;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                                IMPLEMENTATION
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Uses Dialex,Restex,ResServD,Systex,Memories,Systems,PCBase;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                    Proc‚dure InitCompiler                      Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet d'initialiser les structures par d‚faut du
 compilateur de langage Pascal niveau B57.
}

Procedure InitCompiler;Begin
 ALInit(CurrPC.ResWordBk);
 ALInit(CurrPC.VarBk);               { Initialise la liste des variables }
 ALInit(CurrPC.ReDef);               { Initialise la liste des constantes }
 ALInit(CurrPC.ProcBk);              { Initialise la liste des proc‚dures }
 ALInit(CurrPC.UnitList);            { Initialise la liste des unit‚s }
 ALAddStr(CurrPC.UnitList,'SYSTEM'); { Indique l'unit‚ par d‚faut }
 ALInit(CurrPC.Include);             { Initialise la liste des inclusions }
 ALInit(CurrPC.Jump);                { Initialise la liste des sauts }
 ALInit(CurrPC.SuppData);            { Initialise la liste des donn‚es suppl‚mentaires }
 ALInit(CurrPC.Macro);               { Initialise la liste des Macros }
 ALInit(CurrPC.ExternProc);          { Initialise la liste des routines externes }
 ALInit(CurrPC.ExternVar);           { Initialise la liste des variables externes }
 ALInit(CurrPC.TypeDef);             { Initialise la liste des types }
 If((ProgramFormat)in[fEXE])and(ProgramTarget=ftWin31)Then Begin
  CurrPC.Org:=0;
 End
  Else
 CurrPC.Org:=$100;                   { Fixe l'origine du programme … 100h }
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

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Proc‚dure InitBuffer                           Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet d'initialiser les tampons de travails du compilateur
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
 Q.CodePrg:=MemAlloc(65520);    { R‚serve un tampon de 64 Ko }
 {$IFDEF IDE}
  Body:=bPRELUDE;
 {$ENDIF}
End;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
END.