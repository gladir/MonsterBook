{SetFullN.Inc}

{�������������������������������������������������������������������������
 �                 Malte Genesis/Biblioth�que individuel                 �
 �                    �dition Chantal/IV - Version 1.1                   �
 �                             1997/04/01                                �
 �                                                                       �
 �         Tous droits r�serv�s par les Chevaliers de Malte (C)          �
 �������������������������������������������������������������������������


 Nom des programmeurs
 ��������������������

  Sylvain Maltais


 Description
 �����������

  Cette inclusion vise  � permettre une universialisation des donn�es �
 compiler  ind�pendament  des conditions  sous  lequel  la fonction est
 tra�ter.  En centralisant toutes les proc�dures au m�me point central,
 on aboutira une technique de �Croiser�, celle-ci permet d'�liminer les
 bugs par le raisonnement suivant:Maintenant sa fonctionne parfaitement
 ou sa plante comme jamais avant...
}

{$IFNDEF __SetFullName}
 {$DEFINE __SetFullName}
 {$I \Source\Chantal\Library\StrUSpc.Inc}

{���������������������������������������������������������������������������
 �                            Fonction SetFullName                         �
 ���������������������������������������������������������������������������


 Description
 �����������

  Cette fonction �tire un nom de fichier comme il est contenu dans une table
 de fichier de format CP/M:  8 caract�res pour le nom border par des espaces
 pour les  caract�res  manquant,  un point situ�  � le neuvi�me  position et
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