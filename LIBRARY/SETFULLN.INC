{SetFullN.Inc}

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
 �                 Malte Genesis/Biblioth둸ue individuel                 �
 �                    릁ition Chantal/IV - Version 1.1                   �
 �                             1997/04/01                                �
 �                                                                       �
 �         Tous droits r굎erv굎 par les Chevaliers de Malte (C)          �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�


 Nom des programmeurs
 袴袴袴袴袴袴袴袴袴袴

  Sylvain Maltais


 Description
 袴袴袴袴袴�

  Cette inclusion vise  � permettre une universialisation des donn괻s �
 compiler  ind굋endament  des conditions  sous  lequel  la fonction est
 tra똳er.  En centralisant toutes les proc괺ures au m늤e point central,
 on aboutira une technique de 췈roiser�, celle-ci permet d'굃iminer les
 bugs par le raisonnement suivant:Maintenant sa fonctionne parfaitement
 ou sa plante comme jamais avant...
}

{$IFNDEF __SetFullName}
 {$DEFINE __SetFullName}
 {$I \Source\Chantal\Library\StrUSpc.Inc}

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
 �                            Fonction SetFullName                         �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�


 Description
 袴袴袴袴袴�

  Cette fonction 굏ire un nom de fichier comme il est contenu dans une table
 de fichier de format CP/M:  8 caract둹es pour le nom border par des espaces
 pour les  caract둹es  manquant,  un point situ�  � le neuvi둴e  position et
 3 lettres d'extension border  d'espace dans le cas  o� il n'y en aurait pas
 vraiment 3.
}

Function SetFullName(Name:String):String;Var Dir:DirStr;N:NameStr;Ext:ExtStr;Begin
 If Name<>'..'Then Begin {Name:=StrUSpc(Path2Name(Name),8)+Path2Ext(Name);}
  FSplit(Name,Dir,N,Ext);
  Name:=StrUSpc(N,8)+Ext;
 End;
 SetFullName:=StrUSpc(Name,12);
End;

{$ENDIF}