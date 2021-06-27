{Library\Memories\EMS\FrameSeg.Inc}

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

{$IFNDEF __GetFrameSeg}
 {$DEFINE __GetFrameSeg}

{�������������������������������������������������������������������������
 �                          Fonction GetFrameSeg                         �
 �������������������������������������������������������������������������


 Description
 �����������

  Cette fonction d�termine l'adresse de segment du Page Frame utilis� pour
 acc�der la m�moire EMS.
}

Function GetFrameSeg:Word;Assembler;ASM
 MOV AH,41h
 INT 67h
 {$IFDEF SaveError}
  MOV EmsErr,AH
 {$ENDIF}
 XCHG AX,BX
END;

{$ENDIF}