{BDos.Inc}

(*�������������������������������������������������������������������������
  �                 Malte Genesis/Biblioth�que individuel                 �
  �                    �dition Chantal/IV - Version 1.1                   �
  �                             1997/10/12                                �
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
*)

{$IFNDEF __BDos}
 {$DEFINE __BDos}

(*����������������������������������������������������������������
  �                        Fonction BDos                         �
  ����������������������������������������������������������������


 Description
 �����������

  Cette fonction appel une fonction du syst�me d'exploitation DOS.
*)

Function BDos(Fonction:Byte;DosDX:Word;DosAL:Byte):Integer;Assembler;ASM
 MOV AH,Fonction
 MOV AL,DosAL
 MOV DX,DosDX
 INT 21h
END;

{$ENDIF}