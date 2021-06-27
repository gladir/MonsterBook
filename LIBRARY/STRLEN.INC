{StrLen.Inc}

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

{$IFNDEF __StrLen}
 {$DEFINE __StrLen}

 {$IFNDEF __PChr}
  {$DEFINE __PChr}
  Type PChr=^Char;
 {$ENDIF}

{�����������������������������������������������������������������
 �                        Fonction StrLen                        �
 �����������������������������������������������������������������


 Description
 �����������

  Cette fonction retourne le nombre de caract�res que la cha�ne de
 caract�res ASCIIZ contient.  Si elle pointe sur NIL,  la longueur
 retourner est 0.
}

Function StrLen(Str:PChr):Word;Assembler;ASM
 {$IFDEF FLAT386}
  OR  EAX,EAX
  JZ  @End
  MOV EDX,EDI
  MOV EDI,EAX
  MOV ECX,0FFFFFFFFH
  XOR AL,AL
  REPNE SCASB
  MOV EAX,0FFFFFFFEH
  SUB EAX,ECX
  MOV EDI,EDX
@End:
 {$ELSE}
  XOR AX,AX
  LES DI,Str
  MOV CX,ES
  OR  CX,DI
  JCXZ @1
  CLD
  MOV CX,$FFFF
  REPNE SCASB
  MOV AX,$FFFE
  SUB AX,CX
@1:
 {$ENDIF}
END;

{$ENDIF}