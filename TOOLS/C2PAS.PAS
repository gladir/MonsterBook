{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
 �       Convertiseur de fichier C � Pascal         �
 �    Malte Genesis/Edition Isabel pour Mode R괻l   �
 �            III - Version 1.0/1995-11-02          �
 �                                                  �
 �  Tous droit r굎erv� par les Chevaliers de Malte  �
 �                (C) 1993 � 1996                   �
 읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸}

{ Objectif:
   � Ce programme doit convertir la structure du langage
     C/C++ sont la forme Pascal en plus d'굃iminer les
     op굍ation r굋굏ive d'instruction courante.
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