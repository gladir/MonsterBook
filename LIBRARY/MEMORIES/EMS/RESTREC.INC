{Library\Memories\EMS\RestRec.Inc}

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

{$IFNDEF __RestRecEMS}
 {$DEFINE __RestRecEMS}

{������������������������������������������������������������������
 �                       Proc�dure RestRec                        �
 ������������������������������������������������������������������


 Description
 �����������

  Cette fonction  r�tablit  la concordance  entre pages logiques et
 physiques  (Mapping)  d'EMS  ayant �t�  pr�c�demment sauvegard�e �
 l'aide de l'interruption 67h, fonction 47h (SaveRec).
}

Procedure RestRec(Handle:Word);Assembler;ASM
 MOV AH,48h
 MOV DX,Handle
 INT 67h
 {$IFDEF SaveError}
  MOV EmsErr,AH
 {$ENDIF}
END;

{$ENDIF}