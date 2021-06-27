{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³       Convertiseur de fichier C … Pascal         ³
 ³    Malte Genesis/Edition Isabel pour Mode R‚el   ³
 ³            III - Version 1.0/1995-11-02          ³
 ³                                                  ³
 ³  Tous droit r‚serv‚ par les Chevaliers de Malte  ³
 ³                (C) 1993 … 1996                   ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}

{ Objectif:
   ş Ce programme doit convertir la structure du langage
     C/C++ sont la forme Pascal en plus d'‚liminer les
     op‚ration r‚p‚tive d'instruction courante.
}

Program C2PAS;

{$M 16384,0,655360 }

Uses DOS,Systex,Systems,Compiler;

{$DEFINE CONSOLE}
{$I \Source\Chantal\Library\Compiler\C\C2Pas.Inc}

BEGIN { Main Program }
 InitSystems(suIsabel);
 Main;
 DoneSystems;
END.