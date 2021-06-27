Program AVE;

Uses AntiVirus;

Var I:Word;

BEGIN
 WriteLn('Anti-Virus va (AV)  Version 1.1');
 WriteLn('Tous droits r‚serv‚s par les Chevaliers de Malte (C) 1995');
 WriteLn;
 WriteLn('Recherche de Virus en m‚moire en cours parmi une banque de ',MaxVirusBank,' Virus...');
 For I:=0 to MaxVirusBank do Begin
  If(AntiVirusBank[I].Func)Then Begin
   WriteLn('Virus d‚tect‚: ',AntiVirusBank[I].PChr);
   Halt;
  End;
 End;
 WriteLn('Aucun des virus qu''AV connaŒt n''est d‚tect‚!');
END.
