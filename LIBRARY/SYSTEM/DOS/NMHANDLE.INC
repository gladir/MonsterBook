{NmHandle.Inc}

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

{$IFNDEF __NmHandle}
 {$DEFINE __NmHandle}

{�����������������������������������������������������������������������
 �                           Fonction NmHandle                         �
 �����������������������������������������������������������������������


 Description
 �����������

  Cette fonction retourne le nombre de Handle utiliser par l'application
 d�finit par son pr�fixe de segment de programme (PSP).
}

{$IFNDEF NoVoid}Function NmHandle(PSP:Word):Byte;{$ENDIF}Var J:Byte;Begin
 {$IFDEF Win32}
  NmHandle:=$FF;
 {$ELSE}
  ASM MOV @Result,0;END;
  If PSP<>8Then For J:=0to 19do If Not(Mem[PSP:$18+J]in[0..2,$FF])Then ASM INC @Result;END;
 {$ENDIF}
End;

{$ENDIF}