{AllocMem.Inc}

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

{$IFNDEF __AllocMem}
 {$DEFINE __AllocMem}

(*���������������������������������������������������������������������
  �                         Fonction AllocMem                         �
  ���������������������������������������������������������������������


 Description
 �����������

  Cette fonction alloue un segment de m�moire du syst�me d'exploitation
 DOS et le rend utilisable par le programme.
*)

Function AllocMem(Size:Word;Var SegP:Word):Integer;Assembler;ASM
 MOV AH,48h
 MOV BX,Size
 INT 21h
 JC  @AllocMemFailed
 LES DI,SegP
 {$IFDEF __386__}
  MOV ES:[DI],AX
 {$ELSE}
  STOSW
 {$ENDIF}
 MOV AX,-1
 JMP @End
@AllocMemFailed:
 XCHG AX,BX
@End:
END;

{$ENDIF}