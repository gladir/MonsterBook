{\Source\Chantal\Library\Files\Images\IsBMPHea.Inc}

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

{�������������������������������������������������������������������������
 �                             Fonction IsBMP                            �
 �������������������������������������������������������������������������


 Description
 �����������

  Cette fonction permet de tester l'ent�te d'un fichier et d'indiquer s'il
 s'agit d'un fichier BitMap.
}

{$IFNDEF __IsBMP}
 {$DEFINE __IsBMP}

Function IsBMP(Info:HeaderBMP):Boolean;Assembler;ASM
 XOR AX,AX
 LES DI,Info
 CMP ES:[DI].HeaderBMP.Sign.Word,'MB' { BM <-> }
 JNE @1
 MOV AL,Ya
@1:
END;

{$ENDIF}