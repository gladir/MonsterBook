{\Source\Chantal\Library\Memories\HMA\HMAAvail.Inc}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                 Malte Genesis/BibliothŠque individuel                 Û
 ³                    dition Chantal/IV - Version 1.1                   Û
 ³                             1997/04/01                                Û
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

{$IFNDEF __HMAAvail}
 {$DEFINE __HMAAvail}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Fonction HMAAvail                          Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction indique si la d‚tecte la pr‚sence d'un processeur 80286
 ou  suivant et la pr‚sence d'au moins  64 Ko de m‚moire ‚tendue.  A  sa
 sortie TRUE est renvoy‚ si l'HMA est disponible, sinon FALSE.


 Remarques
 ÍÍÍÍÍÍÍÍÍ

  þ Cette fonction doit  ˆtre appel‚e avant l'appel de toutes les autres
    proc‚dures et fonctions de ce programme.

  þ Cette proc‚dure est tir‚e du m‚thode de programmation d'un programme
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
         $74/$0E/      { JE  pashma  >ÄÄÄÄÄ¿}
         $B4/$88/      { MOV AH,88h        ³}
         $CD/$15/      { INT 15h           ³}
         $3D/$40/$00/  { CMP AX,64         ³}
         $72/$05/      { JB  pashma  >ÄÄÄÄÄ´}
         $B8/$01/$00/  { MOV AX,0001h      ³}
         $EB/$02/      { JMP ende          ³}
         $33/$C0/      { XOR AX,AX <ÄÄÄÄÄÄÄÙ}
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