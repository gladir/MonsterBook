{UnPackTi.Inc}

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

{$IFNDEF __UnPackTime}
 {$DEFINE __UnPackTime}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Proc‚dure UnPackTime                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure  permet  de passer  de la forme courte de la date  et de
 l'heure,  utilis‚ par exemple  par le Dos,  … la forme longue directement
 lisible.
}

Procedure UnPackTime(P:LongInt;Var T:DateTime);Assembler;ASM
 {$IFDEF FLAT386}
 {$ELSE}
  LES DI,T
  CLD
  MOV AX,Word Ptr P[2]
  {$IFOPT G+}
   SHR AX,9
  {$ELSE}
   MOV CL,9
   SHR AX,CL
  {$ENDIF}
  ADD AX,1980
  STOSW
  MOV AX,Word Ptr P[2]
  {$IFOPT G+}
   SHR AX,5
  {$ELSE}
   MOV CL,5
   SHR AX,CL
  {$ENDIF}
  AND AX,15
  {$IFDEF DosUnit}
   STOSW
  {$ELSE}
   STOSB
  {$ENDIF}
  MOV AX,Word Ptr P[2]
  AND AX,31
  {$IFDEF DosUnit}
   STOSW
  {$ELSE}
   STOSB
  {$ENDIF}
  MOV AX,Word Ptr P
  {$IFOPT G+}
   SHR AX,11
  {$ELSE}
   MOV CL,11
   SHR AX,CL
  {$ENDIF}
  {$IFDEF DosUnit}
   STOSW
  {$ELSE}
   STOSB
  {$ENDIF}
  MOV AX,Word Ptr P
  {$IFOPT G+}
   SHR AX,5
  {$ELSE}
   MOV CL,5
   SHR AX,CL
  {$ENDIF}
  AND AX,63
  {$IFDEF DosUnit}
   STOSW
  {$ELSE}
   STOSB
  {$ENDIF}
  MOV AX,Word Ptr P
  AND AX,31
  SHL AX,1
  {$IFDEF DosUnit}
   STOSW
  {$ELSE}
   STOSB
  {$ENDIF}
 {$ENDIF} 
END;

{$ENDIF}