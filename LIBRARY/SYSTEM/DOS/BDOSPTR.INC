{BDosPtr.Inc}

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

{$IFNDEF __BDosPtr}
 {$DEFINE __BDosPtr}

(*����������������������������������������������������������������
  �                       Fonction BDosPtr                       �
  ����������������������������������������������������������������


 Description
 �����������

  Cette fonction appel une fonction du syst�me d'exploitation DOS
 avec comme param�trage un pointeur.
*)

Function BDosPtr(Cmd:Byte;Var Arg;DosAL:Byte):Integer;Assembler;ASM
 PUSH DS
  MOV AH,Byte Ptr Cmd
  MOV AL,Byte Ptr DosAL
  LDS DX,Arg
  CLC
  INT 21h
 POP DS
 JC  @End
 XOR AX,AX
 JMP @End
@End:
END;

{$ENDIF}