{DirExist.Inc}

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

{$IFNDEF __DirExist}
 {$DEFINE __DirExist}

{$I \Source\Chantal\Library\AddStr.Inc}
{$I \Source\Chantal\Library\IsWildCard.Inc}
{$I \Source\Chantal\Library\Path2Dir.Inc}

{�����������������������������������������������������������������������
 �                           Fonction DirExist                         �
 �����������������������������������������������������������������������


 Description
 �����������

  Cette  fonction  indique  si le r�pertoire sp�cifi� par la variable de
 param�trage existe. Si la cha�ne de caract�res est vide, elle consid�r�
 comme  un  r�pertoire  valide.  �galement,  s'il s'agit d'un  suite  de
 r�pertoire, seul la partie avant le premier point virgule est tester.
}

Function DirExist(Dir:String):Bool;Var Rec:SearchRec;Begin
 If Length(Dir)=0Then DirExist:=Ya
  Else
 Begin
  {$IFDEF Chantal}
   TruncAfterSemicolon(Dir);
  {$ENDIF}
  If Dir[Length(Dir)]='\'Then AddStr(Dir,'*.*')Else
  If IsWildCard(Dir)Then Dir:=Path2Dir(Dir)+'*.*';
  FindFirst(Dir,faDir,Rec);
  DirExist:=DosError=0
 End;
End;

{$ENDIF}