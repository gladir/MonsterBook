{Library\Mouse\MPVer.Inc}

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

{$IFNDEF __MickeysPixelVertical}
 {$DEFINE __MickeysPixelVertical}

 {�����������������������������������������������������������������
  �                   Fonction MickeysPixelVertical               �
  �����������������������������������������������������������������


  Description
  �����������

    Cette fonction retourne le nombre de mickeys/pixel d�finit pour
   la souris sur l'axe vertical.
  }

Function MickeysPixelVertical:Word;
{$IFDEF Macro}
 InLine($B8/$1B/$00/ { MOV AX,001Bh }
        $CD/$33/     { INT 33h }
        $91);        { XCHG AX,CX }
{$ELSE}
 Assembler;ASM
  MOV AX,001Bh
  INT 33h
  XCHG AX,CX
 END;
{$ENDIF}

{$ENDIF}