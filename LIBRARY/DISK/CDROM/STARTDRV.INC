{Library\Disk\CDROM\StartDrv.Inc}

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

{$IFNDEF __StartDrvCDROM}
 {$DEFINE __StartDrvCDROM}

 {�����������������������������������������������������������������������
  �                          Fonction StartDrvCDROM                     �
  �����������������������������������������������������������������������


  Description
  �����������

   Cette fonction retourne le num�ro du premi�re unit� CD-ROM disponible.
 }

Function StartDrvCDROM:Byte;Assembler;ASM
 MOV AX,1500h
 XOR BX,BX
 INT 2Fh
 XCHG AX,CX
END;

{$ENDIF}