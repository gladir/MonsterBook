{AllocMem.Inc}

(*ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
  ³                 Malte Genesis/BibliothŠque individuel                 Û
  ³                    dition Chantal/IV - Version 1.1                   Û
  ³                             1997/10/12                                Û
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
*)

{$IFNDEF __AllocMem}
 {$DEFINE __AllocMem}

(*ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
  ³                         Fonction AllocMem                         Û
  ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction alloue un segment de m‚moire du systŠme d'exploitation
 DOS et le rend utilisable par le programme.
*)

Function AllocMem(Size:Word;Var SegP:Word):Integer;Assembler;ASM
 MOV AH,48h
 MOV BX,Size
 INT 21h
 JC  @AllocMemFailed
 LES DI,SegP
 {$IFDEF __386__}
  MOV ES:[DI],AX
 {$ELSE}
  STOSW
 {$ENDIF}
 MOV AX,-1
 JMP @End
@AllocMemFailed:
 XCHG AX,BX
@End:
END;

{$ENDIF}