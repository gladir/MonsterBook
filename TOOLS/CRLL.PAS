{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
 �                      Compilateur de RLL                         �
 �  Malte Genesis/Edition Chantal pour Mode R괻l/IV - Version 1.2  �
 �                          1995/01/01                             �
 �                                                                 �
 �       Tous droits r굎erv굎 par les Chevaliers de Malte (C)      �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�


 Nom du programmeur
 袴袴袴袴袴袴袴袴袴

  Sylvain Maltais


 Description
 袴袴袴袴袴�

  Ce programme permet de compiler un listing  de format ressource en
 biblioth둸ue �.RLL� compatible avec l'ensemble Malte Genesis III ou
 IV ou V des Chevaliers de Malte.
}

Program CompilerRLL;

Uses Dialex,Systex,Memories,Systems,Isatex,Dials,
     ResTex,ResServD;

{$DEFINE CONSOLE}
{$I \Source\Chantal\Tools\CRLL.Inc}

BEGIN
 WriteLn('Compilateur RLL  Version 1.6  Tous droits r굎erv� par les Chevaliers de Malte');
 WriteLn;
 DBInitServer(ChantalServer,MaltePath+'DATA\CHANTAL.DAT');
 If MakeRLLFile(ParamStr(1),NIL)=0Then WriteLn('Op굍ation r굑ssit!');
END.