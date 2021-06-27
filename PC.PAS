{ ÄÄ  ÄÄ  ÄÄ  ÄÄ  ÄÄ  ÄÄ  ÄÄ  ÄÄ  ÄÄ  ÄÄ  ÄÄ  ÄÄ  ÄÄ  ÄÄ  ÄÄ  ÄÄ  ÄÄ  ÄÄ

 ³                    Compilateur Pascal Niveau B57                     ³
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

  Cette programme est un compilateur  Pascal complet  (code  source …
 ex‚cutable sans interm‚diaire). Il convertit des informations ‚crite
 sous forme de source de langage Pascal de niveau B57 en code machine
 ex‚cutable par un systŠme d'exploitation DOS ou compatible.


 Remarques
 ÍÍÍÍÍÍÍÍÍ

  ş Il s'agit que du compilateur seulement et ®IDE¯ n'est  pas inclus
    dans  ce  programme,  si vous  d‚sirer  avoir un ®IDE¯ en plus du
    compilateur, alors utilis‚e l'OVP (OverCodePascal).

  ş La directive  de compilation  ®IDE¯  doit ˆtre  non d‚finit  dans
    toutes  les unit‚s pour permet  une ex‚cution normal du programme
    (*$UNDEF IDE*).
}

Program PascalCompiler;

Uses Adele,Systex,Systems,
     Dialex,Restex,ResServD,
     PCCortex,   { Coeur de la structure }
     PCInit,     { Initialise le compilateur }
     PCLine,     { TraŒtement des lignes }
     PCData,     { Donn‚e de base: information brute }
     PCBase,     { Gestion des bases de donn‚es }
     PCUnit,     { Gestion et fabrication des unit‚s }
     PCAsm,      { Gestion de l'assembleur en ligne directe }
     PCCompile,  { Compilation du code machine }
     PCPass,     { Passe les lignes de langages de programmation }
     PCLink,     { Fabrication des liens }
     PCMake;     { Construction de l'ex‚cutable }

Var TimeIn:Long; { Temps du d‚marrage du compilateur }

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Fonction GetStrTimeInPrg                      Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de retourne une chaŒne correspondant au nombre de
 temps depuis lequel le programme a ‚t‚ lanc‚e.
}

Function GetStrTimeInPrg:String;Var Hour,Min,Sec:Wd;Time:Long;Begin
 Time:=Long(Long(GetRawTimer-TimeIn)*901)shr 14;
 If Time<>0Then Begin
  Hour:=Time div 360;
  Min:=Wd(Time div 60)mod 60;
  Sec:=Time mod 60
 End
  Else
 Begin;Hour:=0;Min:=0;Sec:=0;End;
 GetStrTimeInPrg:=CStrTimeDos(Hour,Min,Sec)
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                     Proc‚dure ComputeParam                      Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de traŒter les paramŠtres du compilateur en
 fonction de la demande utilisateur et d'ajuster le compilateur pour
 les demander sp‚cifique de l'utilisateur.
}

Procedure ComputeParam;Var I:Byte;SX:String;Begin
 For I:=1to(ParamCount)do Begin
  SX:=StrUp(ParamStr(I));
  If SX='/?'Then Begin
   WriteLn('Syntaxe: PC [/BOOT|/COM|/EXE] [/CPU:0|1|2|3|4|5|6] fichier.PAS');
   WriteLn;
   WriteLn(' /BOOT        criture du code tel un code de d‚marrage');
   WriteLn(' /COM         criture du programme comme un ex‚cutable .COM');
   WriteLn(' /EXE         criture du programme comme un ex‚cutable classique');
   WriteLn(' /CPU:?       Microprocesseur: 0=8088/8086, 1=80188/80186, 2=80286, 3=80386,');
   WriteLn('                               4=80486, 5=80586 (Pentium), 6=80686.');
   WriteLn(' /B|/BUILTALL Reconstruition de toutes les unit‚s demand‚ par le programme');
   WriteLn(' /NM          Ne reconstruit pas les unit‚s modifi‚');
   WriteLn(' /NC          Pas de syntaxe du langage C autoris‚ (genre #define,...)');
   Halt;
  End;
  If Left(SX,5)='/CPU:'Then Begin
   SX:=DelStr(SX,1,5);
   If(SX='0')or(SX='8088')or(SX='8086')Then InstrFormat:=p88 Else
   If(SX='1')or(SX='80186')or(SX='80188')Then InstrFormat:=p186 Else
   If(SX='2')or(SX='286')or(SX='80286')Then InstrFormat:=p286 Else
   If(SX='3')or(SX='386')or(SX='80386')Then InstrFormat:=p386 Else
   If(SX='4')or(SX='486')or(SX='80486')Then InstrFormat:=p486 Else
   If(SX='5')or(SX='586')or(SX='80586')or(SX='PENTIUM')Then InstrFormat:=p586 Else
   If(SX='6')or(SX='686')or(SX='80686')Then InstrFormat:=p686
    Else
   Begin
    WriteLn('Type de microprocesseur inconnu!');
    Halt;
   End;
  End
   Else
  If SX='/EXE'Then ProgramFormat:=fEXE Else
  If SX='/COM'Then ProgramFormat:=fCOM Else
  If SX='/BOOT'Then Begin
   ProgramFormat:=fBOOT;
   CurrPC.IP:=0;
  End
   Else
  If(SX='/B')or(SX='/BUILDALL')Then BuildAll:=Ya Else
  If(SX='/NC')Then CSyntax:=No Else
  If(SX='/NM')Then MakeModifiedUnit:=No
  Else CurrPC.MainFile:=SX;
 End;
End;

BEGIN
 WriteLn('Compilateur Pascal  Version 1.0');
 WriteLn('Tous droits r‚serv‚s par les Chevaliers de Malte');
 WriteLn('¯¯ Langage de programmation Pascal Niveau B57 ®®');
 WriteLn;
 Jump.FlagsMethod:=stupJumperSecure;
 InitSystems(suIsabel);
 DBInitServer(ChantalServer,MaltePath+'DATA\CHANTAL.DAT');
 TimeIn:=GetRawTimer;
 PCStart(CurrPC);
 If(CurrPC.CodePrg=NIL)Then CurrPC.Status:=OutOfMemory
  Else
 Begin
  ComputeParam;
  If(ProgramFormat)in[fMEX]Then Begin
   CurrPC.Org:=0;
   CurrPC.IP:=0;
  End;
  If Path2Ext(CurrPC.MainFile)=''Then AddStr(CurrPC.MainFile,'.PAS');
  CurrPC.CurrFile:=CurrPC.MainFile;
  CurrPC.Status:=CompileFile(CurrPC.MainFile,CurrPC.NL);
 End;
 Case(CurrPC.Status)of
  0:If(ProgramFormat)in[fBOOT,fCOM,fEXE,fMEX]Then Begin
   CurrPC.Ok:=((CurrPC.CodePrg^[CurrPC.PrevIP]=$9A)and
               (CurrPC.CodePrg^[CurrPC.PrevIP+1]=$00)and
               (CurrPC.CodePrg^[CurrPC.PrevIP+2]=$00)and
               (CurrPC.CodePrg^[CurrPC.PrevIP+3]=$FF)and
               (CurrPC.CodePrg^[CurrPC.PrevIP+4]=$FF))or
               ((CurrPC.CodePrg^[CurrPC.PrevIP]=$B8)and
               (CurrPC.CodePrg^[CurrPC.PrevIP+2]=$4C)and
               (CurrPC.CodePrg^[CurrPC.PrevIP+3]=$CD)and
               (CurrPC.CodePrg^[CurrPC.PrevIP+4]=$21))or
               ((CurrPC.CodePrg^[CurrPC.PrevIP]=$CD)and
               (CurrPC.CodePrg^[CurrPC.PrevIP+1]=$20));
   If Not(CurrPC.Ok)Then Begin
      { Met fin au programme }
    Case(ProgramFormat)of
     fEXE:PushInstr(#$B8#$00#$4C+ { MOV AX,4C00h + l1 }
                    #$CD#$21);    { INT 21h }
     fMEX:PushByte(ciRet);
     fCOM:Push2Byte(ciInt,$20);
    End;
   End;
   DumpSuppData;
   MakeExec;
   WriteLn('Compilation r‚ussit');
   WriteLn('ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ');
   WriteLn('Nom du programme de sortie     = ',Path2NoDir(CurrPC.PathOutput));
   WriteLn('Nombre de ligne(s) compil‚     = ',CurrPC.NL);
   WriteLn('Nombre de macro(s)             = ',CurrPC.Macro.Count);
   WriteLn('Nombre de constante(s)         = ',CurrPC.ReDef.Count+CurrPC.GhostConst);
   WriteLn('Nombre de variable(s)          = ',CurrPC.VarBk.Count);
   WriteLn('Nombre de type(s)              = ',CurrPC.TypeDef.Count);
   WriteLn('Nombre de proc‚dure(s)         = ',CurrPC.ProcBk.Count);
   WriteLn('Nombre de code machine         = ',CurrPC.IP-CurrPC.Org);
  End
   Else
  Begin
   WriteLn('Compilation r‚ussit');
   WriteLn('ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ');
   WriteLn('Nombre de ligne(s) compil‚     = ',CurrPC.NL);
   WriteLn('Nombre de macro(s)             = ',CurrPC.Macro.Count);
   WriteLn('Nombre de constante(s)         = ',CurrPC.ReDef.Count+CurrPC.GhostConst);
   WriteLn('Nombre de variable(s)          = ',CurrPC.VarBk.Count);
   WriteLn('Nombre de type(s)              = ',CurrPC.TypeDef.Count);
   WriteLn('Nombre de proc‚dure(s)         = ',CurrPC.ProcBk.Count);
   WriteLn('Nombre de code machine         = ',CurrPC.GhostCode+CurrPC.IP-CurrPC.Org);
  End;
  FileNotFound:WriteLn('Fichier introuvable!');
  Else WriteLn('Erreur #',CurrPC.Status,' … la ligne ',CurrPC.NL-1,' caractŠre ',CurrPC.I);
 End;
 WriteLn('M‚moire disponible en octet(s) = ',MemAvail);
 WriteLn('Temps de compilation           = ',GetStrTimeInPrg);
 DoneSystems;
END.