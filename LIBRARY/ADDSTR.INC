{AddStr.Inc}

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

{$IFNDEF __AddStr}
 {$DEFINE __AddStr}

{������������������������������������������������������������������������
 �                           Proc�dure AddStr                           �
 ������������������������������������������������������������������������


 Description
 �����������

  Cette fonction concat�ne une cha�ne de caract�res �Add� � une cha�ne de
 caract�res source �S�.Cette proc�dure �quivaut � l'op�ration �S:=S+Add�.
}

Procedure AddStr(Var S:String;Const Add:String);
{$IFDEF __386__}
 Begin
  S:=S+Add;
 End;
{$ELSE}
 {$IFDEF NoAsm}
  Begin S:=S+Add;End;
 {$ELSE}
  Assembler;ASM
   PUSH DS
    LES DI,S
    LDS SI,Add
    MOV BL,ES:[DI]
    XOR BH,BH
    MOV CL,DS:[SI]
    XOR CH,CH
    MOV DX,BX
    ADD DX,CX
    OR  DH,DH
    JE  @NoTrunc
    MOV CX,255
    MOV DX,CX
    SUB CX,BX
 @NoTrunc:
    MOV ES:[DI],DL
    ADD DI,BX
    INC DI
    INC SI
    CLD
    SHR CX,1
    REP MOVSW
    ADC CX,CX
    REP MOVSB
   POP DS
  END;
 {$ENDIF}
{$ENDIF}

{$ENDIF}