{Path2Dsk.Inc}

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

{$IFNDEF __Path2Dsk}
 {$DEFINE __Path2Dsk}
 {$I \Source\Chantal\Library\ChrUp.Inc}
 {$I \Source\Chantal\Library\GetDsk.Inc}
 {$I \Source\Chantal\Library\IsRomanLetter.Inc}

{�����������������������������������������������������������������������
 �                          Fonction Path2Dsk                          �
 �����������������������������������������������������������������������


 Description
 �����������

  Cette fonction retourne le num�ro du disque inclue dans la variable de
 param�trage �Path� contenant lui-m�me un chemin.
}

Function Path2Dsk(Path:String):Byte;Begin
 If(Path='')or Not(IsRomanLetter(Path[1]))Then Path2Dsk:=GetDsk Else Path2Dsk:=Byte(ChrUp(Path[1]))-65;
End;

{$ENDIF}