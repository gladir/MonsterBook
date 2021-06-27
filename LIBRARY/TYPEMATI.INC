{TypeMati.Inc}

{$IFNDEF __SetTypm}
 {$DEFINE __SetTypm}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                      Proc‚dure interne SendKB                    Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure envoie un octet au contr“leur du clavier permettant
 ‚vantuellement de l'ajuster convenablement.

 Remarques
 ÍÍÍÍÍÍÍÍÍ

  þ A l'Entr‚e: AH=octet … envoyer. Sortie: Indicateur de z‚ro  (ZF):
    0 = Erreur,  1 = tout va bien.  Les Registres: AX le registre des
    indicateurs sont modifi‚s.

  þ Routine … usage  interne,  ne doit petre appel‚e  qu'… partir  du
    pr‚sent module.
}

Procedure SendKB;Near;Assembler;ASM
 PUSH CX                                     {Empile tous les registres}
 PUSH BX                                       {modifi‚s par la routine}
 MOV  BL,3                               {Nombre de tentatives tol‚r‚es}
  (*Attend que le contr“leur puisse recevoir des donn‚es*)
@1:
 XOR  CX,CX                                {65536 it‚rations au maximum}
@2:
 IN   AL,64h                             {Lit le contenu du port d'‚tat}
 NOP
 NOP
 NOP
 NOP
 TEST AL,2                     {Reste-t-il un caractŠre dans le tampon?}
 LOOPNE @2                                                   {Oui--> @2}
  (*Envoie un caractŠre au contr“leur*)
 MOV  AL,AH                               {TransfŠre le caractŠre en AL}
 OUT  60h,AL                              {puis dans le port de donn‚es}
 NOP
 NOP
 NOP
 NOP
@3:
 IN   AL,64h                             {Lit le contenu du port d'‚tat}
 NOP
 NOP
 NOP
 NOP
 TEST AL,1                           {R‚ponse dans le tampon de sortie?}
 LOOPE @3                                                  {Non  --> @3}
  (*Lit et exploite la r‚ponse du contr“leur*)
 IN   AL,60h                                    {Lit le port de donn‚es}
 NOP
 NOP
 NOP
 NOP
 CMP  AL,0FAh                                       {CaractŠre accept‚?}
 JE   @End                                         {Oui -> tout va bien}
  (*Le caractŠre n'a pas ‚t‚ accept‚*)
 DEC  BL                              {D‚cr‚mente le compteur d'erreurs}
 JNE  @2                               {Peut-on recommencer ? Oui--> @2}
 OR   BL,1 {Non, mettre … 0 l'indicateur de z‚ro pour signaler l'erreur}
@End:
 POP  BX                {D‚pile les registres sauvegard‚s}
 POP  CX
END;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                            Fonction SendTypm                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure transmet la vitesse Typematic au contr“leur du clavier.

 Remarques
 ÍÍÍÍÍÍÍÍÍ

  þ L'appel de cette fonction  comprend le paramŠtre de vitesse ainsi que
    le fr‚quence  de l'envoie  comme  le montre  cette formule  en pseudo
    Pascal: ®SetTypm((Delay shl 5)+Speed))¯.

  þ Voici une bref tableau  montrant les valeurs  accord‚e au param‚trage
    de cette fonction:
    ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
    ³              D‚lai      Fr‚quence de r‚p‚tition par seconde       ³
    ³         (Delay) ³        ³ (Speed)                                ³
    ³ ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍ»  ÉÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»                      ³
    ³ º  0 : 1/4 seconde  º  º  0 : 30,0 r‚p./s  º                      ³
    ³ º  1 : 1/2 seconde  º  º  1 : 26,7 r‚p./s. º                      ³
    ³ º  2 : 3/4 seconde  º  º  2 : 24,0 r‚p./s. º                      ³
    ³ º  3 : 1 seconde    º  º  3 : 21,8 r‚p./s. º                      ³
    ³ ÇÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¶  º         .         º                      ³
    ³ º Pr‚cision    ñ20% º  º         .         º                      ³
    ³ ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼  º         .         º                      ³
    ³                        º 28 :  2,5 r‚p./s. º                      ³
    ³                        º 29 :  2,3 r‚p./s. º                      ³
    ³                        º 30 :  2,1 r‚p./s. º                      ³
    ³                        º 31 :  2,0 r‚p./s. º                      ³
    ³                        ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼                      ³
    ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
}

Function SetTypm(Rate:Byte):Boolean;Assembler;ASM
 XOR  DL,DL         {Transmission a priori d‚fectueuse}
 MOV  AH,0F3h   {Commande de fixation vitesse Typmatic}
 CLI                         {Inhibe les interruptions}
 CALL SendKB                       {Vers le contr“leur}
 JNE  @1                            {Erreur? Oui--> @1}
 MOV  AH,Rate                {Lit la vitesse Typematic}
 CALL SendKB                       {Vers le contr“leur}
 JNE  @1                            {Erreur? Oui -> @1}
 INC  DL                   {tout va bien, renvoie TRUE}
@1:
 STI                       {R‚tablit les interruptions}
 MOV  AL,DL       {Met la valeur de retour sur la pile}
END;

{$ENDIF}