{\Source\Chantal\WEPutChG.Inc}

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴콘
 �                         Proc괺ure WEPutChrGattr                        �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複蔔


 Description
 袴袴袴袴袴�

  Cette proc괺ure 괹rit un caract둹e en format d'Attribut GAT � l'int굍ieur
 d'une fen늯re de dialogue 췞E�.
}

Procedure WEPutChrGAttr(Var Q:Window;Chr:Char;GAttr:Byte);
{$IFDEF FLAT386}
 Begin
  If(Q.X>Q.MaxX-1)or(Q.Y>Q.MaxY)Then Exit;
  PutCharGAttr(WEGetRealX(Q),WEGetRealY(Q),Chr,Q.CurrColor,GAttr);
  Inc(Q.X);
  If GAttr and$10=$10Then Inc(Q.X)
 End;
{$ELSE}
 Assembler;ASM
   {If(Q.X>Q.MaxX-1)or(Q.Y>Q.MaxY)Then Exit;}
   {PutCharGAttr(WEGetRealX(Q),WEGetRealY(Q),Chr,Q.CurrColor,GAttr);}
   {Inc(Q.X);}
   {If GAttr and$10=$10Then Inc(Q.X)}
  LES DI,Q
  MOV AX,Word Ptr ES:[DI].Window.X
  MOV BX,Word Ptr ES:[DI].Window.MaxX
  DEC BX
  CMP AL,BL
  JA  @End
  CMP AH,BH
  JA  @End
  CALL AsmWEGetReal
  INC ES:[DI].Window.X
  TEST GAttr,10h
  JZ  @1
  INC ES:[DI].Window.X
 @1:
  CMP HoleMode,True
  JNE @Run
  PUSH AX
   XCHG CX,AX
   CALL NmXTxts
   MUL CH
   XOR CH,CH
   ADD AX,CX
   LES DI,Hole
   ADD DI,AX
   MOV AL,0
   SCASB
  POP AX
  JNE @End
  LES DI,Q
 @Run:
  PUSH AX
  MOV AL,AH
  PUSH AX
 { INC ES:[DI].Wins.X
  TEST GAttr,10h
  JZ  @1
  INC ES:[DI].Wins.X
 @1:}
  PUSH Word Ptr Chr
  PUSH Word Ptr ES:[DI].Window.CurrColor
  PUSH Word Ptr GAttr
  CALL PutCharGAttr
 @End:
 END;
{$ENDIF}