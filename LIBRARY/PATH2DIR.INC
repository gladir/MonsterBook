{Path2Dir.Inc}

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

{$IFNDEF __Path2Dir}
 {$DEFINE __Path2Dir}
 {$I \Source\Chantal\Library\AddStr.Inc}
 {$I \Source\Chantal\Library\IncStr.Inc}

{�����������������������������������������������������������������������
 �                          Fonction Path2Dir                          �
 �����������������������������������������������������������������������


 Description
 �����������

  Cette fonction retourne la partie r�pertoire du chemin contenu dans la
 variable de param�trage �Path�.
}

Function Path2Dir(Path:String):String;Var D:String;N:NameStr;E:ExtStr;
 Procedure AddBackSlash;Begin If D[Length(D)]<>'\'Then IncStr(D,'\')End;
Begin
 Path2Dir:='';
 If Path=''Then Exit;
 FSplit(Path,D,N,E);
 If E=''Then Begin AddBackSlash;AddStr(D,E)End;
 If D=''Then Path2Dir:=''else AddBackSlash;
 Path2Dir:=D;
End;

{$ENDIF}