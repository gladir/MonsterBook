{_nfile.Inc}

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

{$IFNDEF ___nfile}
 {$DEFINE ___nfile}

 {������������������������������������������������������������������������
  �                            Fonction _nfile                           �
  ������������������������������������������������������������������������


  Description
  �����������

   Cette fonction retourne le nombre  de Handle utiliser par l'application
  en cours, c'est-�-dire celle-ci.


  Remarque
  ��������

   � Cette fonction vise un compatibilit� avec le langage de programmation
     C et C++.  Toutefois,  une contrainte existe,  en langage C et C++ il
     s'agit  d'une variable  et  ici  d'une  fonction,  donc impossible de
     changer sa valeur!
 }

 Function _nfile:Byte;
 {$IFDEF ___NmHandle}
  Begin;_nfile:=_NmHandle;End;
 {$ELSE}
  {$DEFINE NoVoid}
  {$I Library\System\Dos\_NmHandle.Inc}
  {$UNDEF NoVoid}
 {$ENDIF}

{$ENDIF}