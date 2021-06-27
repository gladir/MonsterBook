{_CpyFile.Inc}

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

{$IFNDEF ___CopyFile}
 {$DEFINE ___CopyFile}

{����������������������������������������������������������������
 �                      Fonction _CopyFile                      �
 ����������������������������������������������������������������


 Description
 �����������

  Cette fonction copie un fichier d'un unit� � une autre, ou d'un
 r�pertoire  � un autre.  Il retourne vrai  si l'op�ration  c'est
 correctement d�roul� ou faux si des probl�mes ont eu lieu.


 Remarques
 ���������

  � Cette fonction r�clame un syst�me d'exploitation compatible �
    un DOS version 2 ou post�rieurs (datant de moins mars 1983)!

  � A la diff�rence de la fonction parall�le �CopyFile�, celle-ci
    appelle  une proc�dure virtuel  de progression  de la copie �
    mesure qu'elle s'effectue.
}

 Function _CopyFile(Const Source,Target:String;Proc:BackgroundCopy):Byte;
 {$DEFINE NoVoid}
 {$UNDEF __CopyFile}
 {$DEFINE Dialog}
 {$I Library\CopyFile.Inc}
 {$UNDEF Dialog}
 {$UNDEF NoVoid}

{$ENDIF}