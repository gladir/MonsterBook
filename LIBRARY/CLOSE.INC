{Close.Inc}

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

{$IFNDEF __Close}
 {$DEFINE __Close}

{���������������������������������������������������������������������������
 �                             Proc�dure Close                             �
 ���������������������������������������������������������������������������


 Description
 �����������

  Cette proc�dure ferme un fichier de type Handle ouvert pr�c�demment par le
 syst�me d'exploitation compatible au DOS.
}

{$IFNDEF NoVoid}Procedure Close(Handle:Word);{$ENDIF}
{$IFDEF Windows}
 Begin
 _WClose(Handle);
 End;
{$ELSE}
 Assembler;ASM
  MOV AX,03E00h
  MOV BX,Handle
  INT $21
 END;
{$ENDIF}

{$ENDIF}