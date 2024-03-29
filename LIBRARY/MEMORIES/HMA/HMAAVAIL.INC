{\Source\Chantal\Library\Memories\HMA\HMAAvail.Inc}

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
 �                 Malte Genesis/Biblioth둸ue individuel                 �
 �                    릁ition Chantal/IV - Version 1.1                   �
 �                             1997/04/01                                �
 �                                                                       �
 �         Tous droits r굎erv굎 par les Chevaliers de Malte (C)          �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�


 Nom des programmeurs
 袴袴袴袴袴袴袴袴袴袴

  Michael Tischer
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

{$IFNDEF __HMAAvail}
 {$DEFINE __HMAAvail}

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
 �                          Fonction HMAAvail                          �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�


 Description
 袴袴袴袴袴�

  Cette fonction indique si la d굏ecte la pr굎ence d'un processeur 80286
 ou  suivant et la pr굎ence d'au moins  64 Ko de m굆oire 굏endue.  A  sa
 sortie TRUE est renvoy� si l'HMA est disponible, sinon FALSE.


 Remarques
 袴袴袴袴�

  � Cette fonction doit  늯re appel괻 avant l'appel de toutes les autres
    proc괺ures et fonctions de ce programme.

  � Cette proc괺ure est tir괻 du m굏hode de programmation d'un programme
    de Michael Tischer dans la Bible du PC.
}

Function HMAAvail:Boolean;
{$IFDEF NOASM}
 Begin
  Inline($33/$C0/      { XOR AX,AX          }
         $50/          { PUSH AX            }
         $9D/          { POPF               }
         $9C/          { PUSHF              }
         $58/          { POP AX             }
         $25/$00/$F0/  { AND AX,0F000h      }
         $3D/$00/$F0/  { CMP AX,0F000h      }
         $74/$0E/      { JE  pashma  >컴컴커}
         $B4/$88/      { MOV AH,88h        �}
         $CD/$15/      { INT 15h           �}
         $3D/$40/$00/  { CMP AX,64         �}
         $72/$05/      { JB  pashma  >컴컴캑}
         $B8/$01/$00/  { MOV AX,0001h      �}
         $EB/$02/      { JMP ende          �}
         $33/$C0/      { XOR AX,AX <컴컴컴켸}
         $88/$46/$FF); { MOV [BP-1],AL      }
 End;
{$ELSE}
 Assembler;ASM
  XOR AX,AX
  PUSH AX
  POPF
  PUSHF
  POP AX
  AND AX,0F000h
  CMP AX,0F000h
  JE  @1
  MOV AH,88h
  INT 15h
  CMP AX,64
  JB  @1
  MOV AX,0001h
  JMP @End
@1:
  XOR AX,AX
@End:
 END;
{$ENDIF}

{$ENDIF}