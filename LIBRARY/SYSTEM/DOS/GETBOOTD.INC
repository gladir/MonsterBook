{\Source\Chantal\Library\System\Dos\GetBootDisk.Inc}

{$IFNDEF __GetBootDisk}
 {$DEFINE __GetBootDisk}

 {旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
  �                         Fonction GetBootDisk                        �
  잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�


  Description
  袴袴袴袴袴�

   Cette fonction permet de conna똳re l'unit� de d굆arrage sous lequel le
  syst둴e d'exploitation  a 굏� lanc괻.  Si la fonction  ne r굑ssit pas �
  d굏erminer de quel unit� a 굏� lanc괻 le syst둴e,  elle renvoie l'unit�
  0 (A:). La fonction renvoie des unit굎 correspondant � ceci: 0=A:, 1=B:,
  2=C:, 3=D:, 4=E:, 5=F:,...
 }

 Function GetBootDisk:Byte;Assembler;ASM
  MOV AX,3305h
  INT 21h
  MOV AL,DL
  OR  AL,AL
  JNZ @End
  INC AX
 @End:
  DEC AX
 END;

{$ENDIF}