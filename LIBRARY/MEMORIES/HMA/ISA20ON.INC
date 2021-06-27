{\Source\Chantal\Library\Memories\HMA\IsA20On.Inc}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                 Malte Genesis/BibliothŠque individuel                 Û
 ³                    dition Chantal/IV - Version 1.1                   Û
 ³                             1998/01/14                                Û
 ³                                                                       Û
 ³         Tous droits r‚serv‚s par les Chevaliers de Malte (C)          Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Nom des programmeurs
 ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ

  Michael Tischer
  Sylvain Maltais


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette inclusion vise  … permettre une universialisation des donn‚es …
 compiler  ind‚pendament  des conditions  sous  lequel  la fonction est
 traŒter.  En centralisant toutes les proc‚dures au mˆme point central,
 on aboutira une technique de ®Croiser¯, celle-ci permet d'‚liminer les
 bugs par le raisonnement suivant:Maintenant sa fonctionne parfaitement
 ou sa plante comme jamais avant...
}

{$IFNDEF __IsA20On}
 {$DEFINE __IsA20On}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Fonction IsA20On                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction indique si le canal d'adresses A20 est lib‚r‚. Elle
 retourne ®TRUE¯ si le canal est libre, ®FALSE¯ sinon.


 Remarque
 ÍÍÍÍÍÍÍÍ

  ş Cette  proc‚dure  est  tir‚e  du  m‚thode de  programmation d'un
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
         $E3/$05/     { JCXZ a20off ÄÄÄÄÄÄ¿}
         $B8/$01/$00/ { MOV  AX,0001h     ³}
         $EB/$02/     { JMP  ende         ³}
         $33/$C0/     { XOR  AX,AX <ÄÄÄÄÄÄÙ}
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