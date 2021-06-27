{\Source\Chantal\Library\Memories\Real\ResPara.Inc}

{�������������������������������������������������������������������������
 �                 Malte Genesis/Biblioth�que individuel                 �
 �                    �dition Chantal/IV - Version 1.1                   �
 �                             1998/01/14                                �
 �                                                                       �
 �         Tous droits r�serv�s par les Chevaliers de Malte (C)          �
 �������������������������������������������������������������������������


 Nom des programmeurs
 ��������������������

  Michael Tischer
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

{$IFNDEF __ResPara}
 {$DEFINE __ResPara}

{����������������������������������������������������������������������
 �                           Fonction ResPara                         �
 ����������������������������������������������������������������������


 Description
 �����������

  Cette fonction calcule et retourne le nombre de paragraphes � allouer
 au programme r�sident.


 Remarques
 ���������

  � Cette fonction ne s'applique quand mode r�el sous DOS et n'a pas de
    signification en soi en mode prot�g�, DPMI,...

  � Cette fonction est tir�e de m�thode  de programmation  de programme
    r�sident tra�t� par Michael Tischer dans la Bible du PC. Elle n'est
    en fait qu'un am�lioration plus ouvert d'esprit.
}

Function ResPara:Word;Begin
 {$IFNDEF DPMI}
  {$IFDEF VER50}{ Pour Turbo Pascal Version 5.0 }
   ResPara:=Seg(FreePtr^)+$1000-PrefixSeg;
  {$ENDIF}
  {$IFDEF VER55}{ Pour Turbo Pascal Version 5.5 }
   ResPara:=Seg(FreePtr^)+$1000-PrefixSeg;
  {$ENDIF}
  {$IFDEF VER60}{ Pour Turbo Pascal Version 6.0 }
   ResPara:=Seg(HeapEnd^)-PrefixSeg;
  {$ENDIF}
  {$IFDEF VER70}{ Pour Turbo Pascal Version 7.0 }
   ResPara:=Seg(HeapEnd^)-PrefixSeg;
  {$ENDIF}
 {$ENDIF}
End;

{$ENDIF}