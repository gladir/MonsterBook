{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³                                                     ³
 ³   Malte Genesis/Cr‚ateur de Module de Mode Vid‚o    ³
 ³           Edition Isabel pour Mode R‚el             ³
 ³                III - Version 1.0                    ³
 ³                   1995/02/02                        ³
 ³                                                     ³
 ³  Tous droit r‚serv‚ par les Chevaliers de Malte (C) ³
 ³                                                     ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}

Unit VideoMode;

INTERFACE

{$IFDEF VER70}{$Q-}{$ENDIF}{$A-,B-,E+,F+,G-,I-,N+,O-,P-,R-,S-,T-,V-,X+}

Uses Systex;

Procedure _VideoMode;
Function SetVideoModePrim(Mode:Wd;Var P:PIV;Var Q:MIV):Byte;
Function SetVideoSizePrim(Grf,Length,Height:Wd;Var P:PIV;Var Q:MIV):Byte;
Procedure EndList;

IMPLEMENTATION

{$I \Source\Chantal\RLL\Video\VideoMod.Inc}

END.