{__PutTap.Inc}

{�������������������������������������������������������������������������
 �                 Malte Genesis/Biblioth�que individuel                 �
 �                    �dition Chantal/IV - Version 1.1                   �
 �                             1994/01/01                                �
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


 Remarque
 ��������

  � Ce fichier  d'inclusion est  un  compl�ment  �  la  proc�dure  d�j�
    existante  �PutTapis�,  il ne  s'agit donc  que  d'un  ajoute  pour
    faciliter la vie du programmeur.
}

{$IFNDEF ____PutTapis}
 {$DEFINE ____PutTapis}

 {$I \Source\Chantal\Library\System\Malte\Presenta.tio\PutTapis.Inc}

{���������������������������������������������������������������������������
 �                           Proc�dure __PutTapis                          �
 ���������������������������������������������������������������������������


 Description
 �����������

  Cette proc�dure affiche une tapiserie de fond en mode texte pour permettre
 de ne pas voir directement le fond de l'�cran.  Il s'adapte en fonction des
 police de caract�res  supporter  par les cartes vid�o ou non.  Il permet de
 chosir s�par�ment  les   2 couleurs de fond  et de surface  de la tapiserie
 contrairement � sa procr�atrice.
}

Procedure __PutTapis(Y1,Y2,Background,Foreground:Byte);Begin
 PutTapis(Y1,Y2,(Background shl 4)+Foreground)
End;

{$ENDIF}