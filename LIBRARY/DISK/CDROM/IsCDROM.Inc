{\Source\Chantal\Library\Disk\CDROM\IsCDROM.Inc}

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
 �                 Malte Genesis/Biblioth둸ue individuel                 �
 �                    릁ition Chantal/IV - Version 1.1                   �
 �                             1997/04/01                                �
 �                                                                       �
 �         Tous droits r굎erv굎 par les Chevaliers de Malte (C)          �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�


 Nom des programmeurs
 袴袴袴袴袴袴袴袴袴袴

  Li-Hsin Huang
  Sylvain Maltais


 Description
 袴袴袴袴袴�

  Cette inclusion vise  � permettre une universialisation des donn괻s �
 compiler  ind굋endament  des conditions  sous  lequel  la fonction est
 tra똳er.  En centralisant toutes les proc괺ures au m늤e point central,
 on aboutira une technique de 췈roiser�, celle-ci permet d'굃iminer les
 bugs par le raisonnement suivant:Maintenant sa fonctionne parfaitement
 ou sa plante comme jamais avant...
}

{$IFNDEF __IsCDROM}
 {$DEFINE __IsCDROM}

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴콘
 �                            Fonction IsCDROM                          �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複蔔


 Description
 袴袴袴袴袴�

  Cette fonction indique l'unit� sp괹ifi� (0=A:, 1=B:,...) est un lecteur
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
  MOV AX,150Bh { V굍ifie l'utilisation du pilote de CD }
  MOV CX,Word Ptr Drive
  INT 2Fh
  OR  AX,AX
  JZ  @End
  MOV AL,True
@End:
 END;
{$ENDIF}

{$ENDIF}
