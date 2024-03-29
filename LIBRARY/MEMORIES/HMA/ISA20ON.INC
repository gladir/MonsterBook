{\Source\Chantal\Library\Memories\HMA\IsA20On.Inc}

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
 �                 Malte Genesis/Biblioth둸ue individuel                 �
 �                    릁ition Chantal/IV - Version 1.1                   �
 �                             1998/01/14                                �
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

{$IFNDEF __IsA20On}
 {$DEFINE __IsA20On}

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
 �                         Fonction IsA20On                        �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�


 Description
 袴袴袴袴袴�

  Cette fonction indique si le canal d'adresses A20 est lib굍�. Elle
 retourne 췛RUE� si le canal est libre, 췋ALSE� sinon.


 Remarque
 袴袴袴袴

  � Cette  proc괺ure  est  tir괻  du  m굏hode de  programmation d'un
    programme de Michael Tischer dans la Bible du PC.
}

Function IsA20On:Boolean;
{$IFNDEF NoAsm}
 Begin
  Inline($1E/         { PUSH DS            }
         $06/         { PUSH ES            }
         $33/$F6/     { XOR  SI,SI         }
         $8E/$DE/     { MOV  DS,SI         }
         $BF/$10/$00/ { MOV  DI,00010h     }
         $B8/$FF/$FF/ { MOV  AX,0FFFFh     }
         $8E/$C0/     { MOV  ES,AX         }
         $B9/$40/$00/ { MOV  CX,64h        }
         $FC/         { CLD                }
         $F3/$A7/     { REPE CMPSW         }
         $07/         { POP  ES            }
         $1F/         { POP  DS            }
         $E3/$05/     { JCXZ a20off 컴컴컴�}
         $B8/$01/$00/ { MOV  AX,0001h     �}
         $EB/$02/     { JMP  ende         �}
         $33/$C0/     { XOR  AX,AX <컴컴컴�}
         $88/$46/$FF);{ MOV  [BP-1],AL     }
 End;
{$ELSE}
 Assembler;ASM
  PUSH DS
   PUSH ES
    XOR SI,SI
    MOV DS,SI
    MOV DI,00010h
    MOV AX,0FFFFh
    MOV ES,AX
    MOV CX,64h
    CLD
    REPE CMPSW
   POP ES
  POP DS
  JCXZ @1
  MOV AX,0001h
  JMP @End
@1:
  XCHG AX,CX
@End:
 END;
{$ENDIF}

{$ENDIF}