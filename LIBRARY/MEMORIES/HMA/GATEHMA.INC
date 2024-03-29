{\Source\Chantal\Library\Memories\HMA\GateHMA.Inc}

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

{$IFNDEF __GateA20}
 {$DEFINE __GateA20}

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
 �                         Fonction GateA20                          �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�


 Description
 袴袴袴袴袴�
  Cette fonction permet de bloquer ou lib둹er le canal d'adresses A20.
 췛RUE� s'il faut lib굍er le canal, sinon 췋ALSE� le bloque.췛RUE� est
 retourner si l'acc둺 au contr뱇eur de clavier r굑ssit, sinon FALSE.


 Remarques
 袴袴袴袴�

  � Apr둺 l'appel de cette fonction,  il est recommand� de s'assurer �
    l'aide de la fonction IsA20On  si le canal a r괻llement 굏� lib굍�
    car le proc괺� utilis� ici ne lib둹e le canal que sur les machines
    굌uip괻s du bus ISA.

  � Cette  proc괺ure  est  tir괻  du  m굏hode  de  programmation  d'un
    programme de Michael Tischer dans la Bible du PC.
}

Function GateA20(Libre:Boolean):Boolean;
{$IFDEF NoASM}
 Begin
  Inline($B4/$DD/          { MOV    AH,11011101b      }
         $83/$7E/$04/$00/  { CMP    Libre,0           }
         $74/$02/          { JE     g1 컴컴컴컴컴커   }
         $B4/$DF/          { MOV    AH,11011111b  �   }
         $33/$C9/          { XOR    CX,CX <컴컴컴켸   }
         $FA/              { CLI                      }
         $E4/$64/          { IN     AL,64 <컴컴컴커   }
         $A8/$02/          { TEST   AL,02         �   }
         $E0/$FA/          { LOOPNZ 컴컴컴컴컴컴컴�   }
         $75/$1D/          { JNE    gerr 컴컴컴컴컴>커}
         $B0/$D1/          { MOV    AL,WO_COMMAND    �}
         $E6/$64/          { OUT    KB_COMMAND,AL    �}
         $E4/$64/          { IN     AL,64 <컴컴컴커  �}
         $A8/$02/          { TEST   AL,02         �  �}
         $E0/$FA/          { LOOPNZ 컴컴컴컴컴컴컴�  �}
         $75/$11/          { JNE    gerr 컴컴컴컴컴>캑}
         $8A/$C4/          { MOV    AL,AH            �}
         $E6/$60/          { OUT    KB_DATA,AL       �}
         $E4/$64/          { IN     AL,64 <컴컴컴커  �}
         $A8/$02/          { TEST   AL,02         �  �}
         $E0/$FA/          { LOOPNZ 컴컴컴컴컴컴컴�  �}
         $75/$05/          { JNE    gerr 컴컴컴컴�>컴�}
         $B8/$01/$00/      { MOV    AX,0001h         �}
         $EB/$02/          { JMP    ende             �}
         $33/$C0/          { XOR    AX,AX <컴컴컴컴컴�}
         $FB/              { STI                      }
         $88/$46/$FF);     { MOV    [BP-1],AL         }
 End;
{$ELSE}
 Assembler;ASM
  MOV AH,11011101b
  CMP Libre,0
  JE  @1
  MOV AH,11011111b
@1:
  XOR CX,CX
  CLI
@2:
  IN AL,64h
  TEST AL,02h
  LOOPNZ @2
  JNE @Err
  MOV AL,0D1h
  OUT 064h,AL
@3:
  IN  AL,064h
  TEST AL,02
  LOOPNZ @3
  JNE @Err
  MOV AL,AH
  OUT 060h,AL
@4:
  IN AL,64h
  TEST AL,02
  LOOPNZ @4
  JNE @Err
  MOV AX,0001h
  JMP @End
@Err:
  XOR AX,AX
@End:
  STI
 END;
{$ENDIF}

{$ENDIF}