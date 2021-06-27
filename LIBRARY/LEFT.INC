{Left.Inc}

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

{$IFNDEF __Left}
 {$DEFINE __Left}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                             Fonction Left                          Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction retourne les ®Num¯ premiers caractŠres de la chaŒne de
 caractŠres sp‚cifi‚ par la variable de param‚trage ®Str¯.
}

Function Left(Str:String;Num:Byte):String;Assembler;ASM
 CLD
 LES DI,@Result
 PUSH DS
  LDS SI,Str
  MOV CL,DS:[SI]
  MOV CH,0
  INC CX
  PUSH DI;REP MOVSB;POP DI
  MOV AL,Num
  CMP ES:[DI],AL
  JB  @1
  MOV ES:[DI],AL
@1:
 POP DS
END;

{$ENDIF}