{\Source\Chantal\Library\Disk\CDROM\IsCDROM.Inc}

{�������������������������������������������������������������������������
 �                 Malte Genesis/Biblioth�que individuel                 �
 �                    �dition Chantal/IV - Version 1.1                   �
 �                             1997/04/01                                �
 �                                                                       �
 �         Tous droits r�serv�s par les Chevaliers de Malte (C)          �
 �������������������������������������������������������������������������


 Nom des programmeurs
 ��������������������

  Li-Hsin Huang
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

{$IFNDEF __IsCDROM}
 {$DEFINE __IsCDROM}

{������������������������������������������������������������������������
 �                            Fonction IsCDROM                          �
 ������������������������������������������������������������������������


 Description
 �����������

  Cette fonction indique l'unit� sp�cifi� (0=A:, 1=B:,...) est un lecteur
 de CD-ROM valide (True) ou non (False).
}

Function IsCDROM(Drive:Integer):Boolean;
{$IFDEF NotReal}
 Begin
  IsCDROM := False;
 End;
{$ELSE}
 Assembler;ASM
  MOV AX,1500h { Demande l'existance du pilote MSCDEX }
  XOR BX,BX
  INT 2Fh
  OR  BX,BX
  JZ  @End
  MOV AX,150Bh { V�rifie l'utilisation du pilote de CD }
  MOV CX,Word Ptr Drive
  INT 2Fh
  OR  AX,AX
  JZ  @End
  MOV AL,True
@End:
 END;
{$ENDIF}

{$ENDIF}