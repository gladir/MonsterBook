{Library\Memories\EMS\NumbPage.Inc}

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

{$IFNDEF __GetNumberPage}
 {$DEFINE __GetNumberPage}

{���������������������������������������������������������������������
 �                         Fonction GetNumberPage                    �
 ���������������������������������������������������������������������


 Description
 �����������

  Cette fonction indique au programme d'appel combien de pages EMS (de
 16 Ko chacune) sont install�es.
}

Function GetNumberPage:Word;Assembler;ASM
 MOV AH,42h
 INT 67h
 {$IFDEF SaveError}
  MOV EmsErr,AH
 {$ENDIF}
 XCHG AX,DX
END;

{$ENDIF}