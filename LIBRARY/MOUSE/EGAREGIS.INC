{Library\Mouse\EGARegis.Inc}

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

{$IFNDEF __EGARegister}
 {$DEFINE __EGARegister}

 {�����������������������������������������������������������������
  �                       Fonction EGARegister                    �
  �����������������������������������������������������������������


  Description
  �����������

    Cette fonction retourne un pointeur sur l'adresse de la version
   du  pilote  de  registre  EGA   (de  la  souris   implant�   sur
   l'interruption 10h).  Si l'offset de cette adresse est �gale � 0
   alors  le pilote  n'est pas  install� sinon  l'adresse  retourne
   pointe sur deux octets  se suivant  contenu la version du pilote
   en format BCD.
  }

Function EGARegister:Pointer;
{$IFDEF Macro}
 InLine($B4/$FA/ { MOV AH,0FAh }
        $33/$DB/ { XOR BX,BX }
        $CD/$10/ { INT 10h }
        $8C/$C2/ { MOV DX,ES }
        $93);    { XCHG AX,BX }
{$ELSE}
 Assembler;ASM
  MOV AH,0FAh
  XOR BX,BX
  INT 10h
  MOV DX,ES
  XCHG BX,AX
 END;
{$ENDIF}

{$ENDIF}