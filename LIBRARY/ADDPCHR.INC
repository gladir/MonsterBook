{AddPChr.Inc}

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

{$IFNDEF __AddPChr}
 {$DEFINE __AddPChr}
 {$I \Source\Chantal\Library\StrPas.Inc}

{�������������������������������������������������������������������������
 �                            Proc�dure AddPChr                          �
 �������������������������������������������������������������������������


 Description
 �����������

  Cette fonction concat�ne une cha�ne de caract�res ASCIIZ � une cha�ne de
 caract�res de style Pascal (String).
}

Procedure AddPChr(Var S:String;PChr:PChr);Begin
 AddStr(S,StrPas(PChr))
End;

{$ENDIF}