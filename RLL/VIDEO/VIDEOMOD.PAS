{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
 �                                                     �
 �   Malte Genesis/Cr괶teur de Module de Mode Vid굊    �
 �           Edition Isabel pour Mode R괻l             �
 �                III - Version 1.0                    �
 �                   1995/02/02                        �
 �                                                     �
 �  Tous droit r굎erv� par les Chevaliers de Malte (C) �
 �                                                     �
 읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�}

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