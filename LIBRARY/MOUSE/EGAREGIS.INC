{Library\Mouse\EGARegis.Inc}

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
 �                 Malte Genesis/Biblioth둸ue individuel                 �
 �                    릁ition Chantal/IV - Version 1.1                   �
 �                             1997/04/01                                �
 �                                                                       �
 �         Tous droits r굎erv굎 par les Chevaliers de Malte (C)          �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�


 Nom des programmeurs
 袴袴袴袴袴袴袴袴袴袴

  Sylvain Maltais


 Description
 袴袴袴袴袴�

  Cette inclusion vise  � permettre une universialisation des donn괻s �
 compiler  ind굋endament  des conditions  sous  lequel  la fonction est
 tra똳er.  En centralisant toutes les proc괺ures au m늤e point central,
 on aboutira une technique de 췈roiser�, celle-ci permet d'굃iminer les
 bugs par le raisonnement suivant:Maintenant sa fonctionne parfaitement
 ou sa plante comme jamais avant...
}

{$IFNDEF __EGARegister}
 {$DEFINE __EGARegister}

 {旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
  �                       Fonction EGARegister                    �
  잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�


  Description
  袴袴袴袴袴�

    Cette fonction retourne un pointeur sur l'adresse de la version
   du  pilote  de  registre  EGA   (de  la  souris   implant�   sur
   l'interruption 10h).  Si l'offset de cette adresse est 괾ale � 0
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