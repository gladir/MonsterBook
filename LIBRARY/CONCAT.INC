{Concat.Inc}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                 Malte Genesis/BibliothŠque individuel                 Û
 ³                    dition Chantal/IV - Version 1.1                   Û
 ³                             1997/04/01                                Û
 ³                                                                       Û
 ³         Tous droits r‚serv‚s par les Chevaliers de Malte (C)          Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Nom des programmeurs
 ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ

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

{$IFNDEF __Concat}
 {$DEFINE __Concat}

Procedure Concat(Var S1,S2:String);Assembler;ASM
 {$IFDEF __68000__}
  MOVE.W  4(SP),D0;   { Demande la longueur maximal de S1 }
  MOVEM.L 6(SP),A0-A1;{ Demande l'adresse de base des chaine}
                      { de caractŠre A0=S1, A1=S2 }
  CLR.B   D1;
  MOVEM.W D3-D4,-(SP);
  CLR.W   D2;
  CLR.W   D3;
  MOVE.B  (A1),D2; { Demande la longueur maximal de S1 }
  MOVE.B  (A0)+,D3;{ Demande la longueur maximal de S2 }
  BEQ.S   @@SETTRN;
  MOVE.W  D3,D4;
  ADD.W   D2,D4;
  CMP.W   D4,D0;
  BCC.S   @@DOCAT;
  NOT.B   D1;
  MOVE.W  D0,D4;
  SUB.W   D2,D0;
  BHI.S   @@RPLEN;
  CLR.W   D0;
@@RPLEN:
  MOVE.W  D0,D3;
@@DOCAT:
  TST.B   D3;
  BEQ.S   @@SETTRN;
  MOVE.B  D4,(A1)+;
  ADDA.W  D3,A1;
  SUBQ.W  #1,D3;
@@MVCHAR:
  MOVE.B  (A0)+,(A1)+;
  DBRA    D3,MVCHAR;
@@SETPRN:
  MOVEM.W (SP)+,D3-D4;
  LSR.B   #1,D1;
 {$ELSE}
  PUSH DS
   LES DI,S1
   LDS SI,S2
   MOV DL,ES:[DI]
   MOV CL,[SI]
@@ConcatOk:
   ADD ES:[DI],CL
   INC DI
   MOV DH,0
   ADD DI,DX
   INC SI
   MOV CH,0
   REP MOVSB
  POP DS
 {$ENDIF}
END;

{$ENDIF}