{��������������������������������������������������Ŀ
 �       Convertiseur de fichier C � Pascal         �
 �    Malte Genesis/Edition Isabel pour Mode R�el   �
 �            III - Version 1.0/1995-11-02          �
 �                                                  �
 �  Tous droit r�serv� par les Chevaliers de Malte  �
 �                (C) 1993 � 1996                   �
 ����������������������������������������������������}

{ Objectif:
   � Ce programme doit convertir la structure du langage
     C/C++ sont la forme Pascal en plus d'�liminer les
     op�ration r�p�tive d'instruction courante.
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