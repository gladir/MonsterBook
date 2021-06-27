{SpcTab.Inc}

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

{$IFNDEF __SpcTab}
 {$DEFINE __SpcTab}

{�������������������������������������������������������������������������
 �                            Fonction SpcTab                            �
 �������������������������������������������������������������������������


 Description
 �����������

  Cette fonction signifie �Space Tabulation�, elle retourne 8 espaces dans
 une cha�ne de caract�re tous simplement.
}

Function SpcTab:String;Assembler;ASM
 {$IFDEF FLAT386}
 {$ELSE}
  CLD
  LES DI,@Result
  MOV CX,8
  MOV ES:[DI],CL
  INC DI
  MOV AL,' '
  REP STOSB
 {$ENDIF}
END;

{$ENDIF}