{Dos16MCh.Inc}

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

{$IFNDEF __Dos16MCheck}
 {$DEFINE __Dos16MCheck}

 {��������������������������������������������������������������
  �                    Fonction Dos16MCheck                    �
  ��������������������������������������������������������������


  Description
  �����������

   Cette fonction v�rifie si la pr�sence du DOS/16M (un genre de
  DOS-Extender/DPMI,... en plus "chip") est d�tect� en m�moire.
 }

 Function Dos16MCheck:Word;
 {$IFDEF Macro}
  InLine($B8/$02/$BF/ { MOV AX,$BF02 }
         $33/$D2/     { XOR DX,DX }
         $CD/$15/     { INT 15h }
         $92);        { XCHG AX,DX}
 {$ELSE}
  Assembler;ASM
   MOV AX,0BF02h
   XOR DX,DX
   INT 15h
   XCHG AX,DX
  END;
 {$ENDIF}

{$ENDIF}