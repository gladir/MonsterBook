{\Source\Chantal\Malte\Volume\ExecAdel.Inc}

{�������������������������������������������������������������������������
 �                 Malte Genesis/Biblioth�que individuel                 �
 �                      �dition Ad�le/IV - Version 1.1                   �
 �                             1998/07/08                                �
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

{$IFNDEF __ExecAdele}
 {$DEFINE __ExecAdele}

{ Cette enregistrement est le format Standard du Malte Genesis V: Ad�le
 d'un item de fichier interne  se trouvant  dans l'ex�cutable lui-m�me.
 Le d�but de l'entr�e se nomme:  �D�BUT� et le dernier se nomme: �FIN�.
 La table des mati�res est � l'envers.
}

Type FileItemAdele=Record
 AbsolutePosition:LongInt; { Position absolue dans l'ex�cutable }
 Size:LongInt;             { Taille du fichier interne }
 Name:String[39];          { Nom du fichier interne }
End;

{$ENDIF}