{Library\LongCall.Inc}

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

{$IFNDEF __LongCall}
 {$DEFINE __LongCall}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                       Proc‚dure LongCall                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet d'effectuer un appel … un adresse pr‚cis en
 pr‚servant les registres comme s'il s'agissait d'une interruption.
}

Procedure LongCall(Addr:LongInt;Var RegAddr:Registers);Assembler;ASM
 PUSH DS
  LES AX,Addr
  MOV Word Ptr @Address,AX
  MOV Word Ptr @Address[2],ES
  LDS SI,RegAddr
  MOV Word Ptr @DSsave,DS
  MOV Word Ptr @SIsave,SI
  CLD
  LODSW
  PUSH AX
   LODSW
   XCHG BX,AX
   LODSW
   XCHG CX,AX
   LODSW
   XCHG DX,AX
   LODSW
   XCHG BP,AX
   LODSW
   PUSH AX
    LODSW
    XCHG DI,AX
    LODSW
    PUSH AX
     LODSW
     MOV ES,AX
     LODSW
     AND AX,008D5h
     PUSH BX
      MOV BX,AX
      PUSHF
      POP AX
      AND AX,0F72Ah
      OR  AX,BX
      PUSH AX
      POPF
     POP BX
    POP DS
   POP SI
  POP AX
  CALL DWord Ptr @Address
  PUSHF
   PUSH ES
    PUSH DI
     MOV ES,Word Ptr @DSsave
     MOV DI,Word Ptr @SIsave
     CLD
     STOSW
     XCHG AX,BX
     STOSW
     XCHG AX,CX
     STOSW
     XCHG AX,DX
     STOSW
     XCHG AX,BP
     STOSW
     XCHG AX,SI
     STOSW
    POP AX
    STOSW
    MOV AX,DS
    STOSW
   POP AX
   STOSW
  POP AX
  STOSW
 POP DS
 JMP @End
@address:DD 0
@DSsave:DW 0
@SIsave:DW 0
@End:
END;

{$ENDIF}