{�������������������������������������������������������������������
 �                      Compilateur de RLL                         �
 �  Malte Genesis/Edition Chantal pour Mode R�el/IV - Version 1.2  �
 �                          1995/01/01                             �
 �                                                                 �
 �       Tous droits r�serv�s par les Chevaliers de Malte (C)      �
 �������������������������������������������������������������������


 Nom du programmeur
 ������������������

  Sylvain Maltais


 Description
 �����������

  Ce programme permet de compiler un listing  de format ressource en
 biblioth�que �.RLL� compatible avec l'ensemble Malte Genesis III ou
 IV ou V des Chevaliers de Malte.
}

Program CompilerRLL;

Uses Dialex,Systex,Memories,Systems,Isatex,Dials,
     ResTex,ResServD;

{$DEFINE CONSOLE}
{$I \Source\Chantal\Tools\CRLL.Inc}

BEGIN
 WriteLn('Compilateur RLL  Version 1.6  Tous droits r�serv� par les Chevaliers de Malte');
 WriteLn;
 DBInitServer(ChantalServer,MaltePath+'DATA\CHANTAL.DAT');
 If MakeRLLFile(ParamStr(1),NIL)=0Then WriteLn('Op�ration r�ussit!');
END.