{\Source\Chantal\Library\SetAttr.Inc}

{$IFNDEF __SetAttr}
 {$DEFINE __SetAttr}

 {旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴콘
  �                       Fonction SetFileAttr                       �
  잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複蔔


  Description
  袴袴袴袴袴�

   Cette fonction permet de changer l'attribut du fichier sp괹ifier en
  param둻re par la variable 췗ath� avec l'attribut 괾alement envoy� en
  param둻re 췆ttr�. Si l'op굍ation  c'est bien pass�, il retourne vrai
  sinon, s'il y a la moindre erreur il retourne faux.
 }

 Function SetFileAttr(Const Path:String;Attr:Word):Boolean;
 Var
  PC:Array[Byte]of Char;
  S,O:Word;
 Begin
  {$IFDEF Win32}
  {$ELSE}
   StrPCopy(@PC,Path);
   S:=Seg(PC);O:=Ofs(PC);
   ASM
    PUSH DS
     MOV DS,S
     MOV DX,O
     MOV CX,Attr
     MOV AX,4301h
     INT 21h
     LAHF
     NOT AH
     AND AH,1
     MOV @Result,AH
    POP DS
   END;
  {$ENDIF}
 End;

{$ENDIF}