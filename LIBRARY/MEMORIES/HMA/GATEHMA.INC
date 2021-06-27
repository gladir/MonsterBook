{\Source\Chantal\Library\Memories\HMA\GateHMA.Inc}

{�������������������������������������������������������������������������
 �                 Malte Genesis/Biblioth�que individuel                 �
 �                    �dition Chantal/IV - Version 1.1                   �
 �                             1998/01/14                                �
 �                                                                       �
 �         Tous droits r�serv�s par les Chevaliers de Malte (C)          �
 �������������������������������������������������������������������������


 Nom des programmeurs
 ��������������������

  Michael Tischer
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

{$IFNDEF __GateA20}
 {$DEFINE __GateA20}

{���������������������������������������������������������������������
 �                         Fonction GateA20                          �
 ���������������������������������������������������������������������


 Description
 �����������
  Cette fonction permet de bloquer ou lib�rer le canal d'adresses A20.
 �TRUE� s'il faut lib�rer le canal, sinon �FALSE� le bloque.�TRUE� est
 retourner si l'acc�s au contr�leur de clavier r�ussit, sinon FALSE.


 Remarques
 ���������

  � Apr�s l'appel de cette fonction,  il est recommand� de s'assurer �
    l'aide de la fonction IsA20On  si le canal a r�ellement �t� lib�r�
    car le proc�d� utilis� ici ne lib�re le canal que sur les machines
    �quip�es du bus ISA.

  � Cette  proc�dure  est  tir�e  du  m�thode  de  programmation  d'un
    programme de Michael Tischer dans la Bible du PC.
}

Function GateA20(Libre:Boolean):Boolean;
{$IFDEF NoASM}
 Begin
  Inline($B4/$DD/          { MOV    AH,11011101b      }
         $83/$7E/$04/$00/  { CMP    Libre,0           }
         $74/$02/          { JE     g1 ����������Ŀ   }
         $B4/$DF/          { MOV    AH,11011111b  �   }
         $33/$C9/          { XOR    CX,CX <��������   }
         $FA/              { CLI                      }
         $E4/$64/          { IN     AL,64 <������Ŀ   }
         $A8/$02/          { TEST   AL,02         �   }
         $E0/$FA/          { LOOPNZ ���������������   }
         $75/$1D/          { JNE    gerr ����������>Ŀ}
         $B0/$D1/          { MOV    AL,WO_COMMAND    �}
         $E6/$64/          { OUT    KB_COMMAND,AL    �}
         $E4/$64/          { IN     AL,64 <������Ŀ  �}
         $A8/$02/          { TEST   AL,02         �  �}
         $E0/$FA/          { LOOPNZ ���������������  �}
         $75/$11/          { JNE    gerr ����������>Ĵ}
         $8A/$C4/          { MOV    AL,AH            �}
         $E6/$60/          { OUT    KB_DATA,AL       �}
         $E4/$64/          { IN     AL,64 <������Ŀ  �}
         $A8/$02/          { TEST   AL,02         �  �}
         $E0/$FA/          { LOOPNZ ���������������  �}
         $75/$05/          { JNE    gerr ���������>�Ĵ}
         $B8/$01/$00/      { MOV    AX,0001h         �}
         $EB/$02/          { JMP    ende             �}
         $33/$C0/          { XOR    AX,AX <�����������}
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