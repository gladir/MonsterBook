{DrDosChk.Inc}

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

{$IFNDEF __DrDosChk}
 {$DEFINE __DrDosChk}

 {�����������������������������������������������������������������������
  �                          Fonction DrDosChk                          �
  �����������������������������������������������������������������������


  Description
  �����������

   Cette fonction teste s'il s'agit d'un DR-DOS tournant actuellement sur
  la machine en renvoyant une valeur diff�rente � 0 si c'est le cas.
 }

Function DrDosChk:Word;
{$IFDEF Macro}
 InLine($B8/$52/$44/ { MOV AX,4452h }
        $CD/$21/     { INT 21h      }
        $73/$02/     { JNC @1       }
        $33/$C0);    { XOR AX,AX    }
                     {@1:           }
{$ELSE}
 Assembler;ASM
  MOV AX,4452h
  INT 21h
  JNC @1
  XOR AX,AX
 @1:
 END;
{$ENDIF}

{$ENDIF}