{\Source\Chantal\Library\Memories\HMA\HMAAvail.Inc}

{�������������������������������������������������������������������������
 �                 Malte Genesis/Biblioth�que individuel                 �
 �                    �dition Chantal/IV - Version 1.1                   �
 �                             1997/04/01                                �
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

{$IFNDEF __HMAAvail}
 {$DEFINE __HMAAvail}

{�����������������������������������������������������������������������
 �                          Fonction HMAAvail                          �
 �����������������������������������������������������������������������


 Description
 �����������

  Cette fonction indique si la d�tecte la pr�sence d'un processeur 80286
 ou  suivant et la pr�sence d'au moins  64 Ko de m�moire �tendue.  A  sa
 sortie TRUE est renvoy� si l'HMA est disponible, sinon FALSE.


 Remarques
 ���������

  � Cette fonction doit  �tre appel�e avant l'appel de toutes les autres
    proc�dures et fonctions de ce programme.

  � Cette proc�dure est tir�e du m�thode de programmation d'un programme
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
         $74/$0E/      { JE  pashma  >����Ŀ}
         $B4/$88/      { MOV AH,88h        �}
         $CD/$15/      { INT 15h           �}
         $3D/$40/$00/  { CMP AX,64         �}
         $72/$05/      { JB  pashma  >����Ĵ}
         $B8/$01/$00/  { MOV AX,0001h      �}
         $EB/$02/      { JMP ende          �}
         $33/$C0/      { XOR AX,AX <��������}
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