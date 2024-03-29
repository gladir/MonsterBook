{TypeMati.Inc}

{$IFNDEF __SetTypm}
 {$DEFINE __SetTypm}

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴콘
 �                      Proc괺ure interne SendKB                    �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複蔔


 Description
 袴袴袴袴袴�

  Cette proc괺ure envoie un octet au contr뱇eur du clavier permettant
 굒antuellement de l'ajuster convenablement.

 Remarques
 袴袴袴袴�

  � A l'Entr괻: AH=octet � envoyer. Sortie: Indicateur de z굍o  (ZF):
    0 = Erreur,  1 = tout va bien.  Les Registres: AX le registre des
    indicateurs sont modifi굎.

  � Routine � usage  interne,  ne doit petre appel괻  qu'� partir  du
    pr굎ent module.
}

Procedure SendKB;Near;Assembler;ASM
 PUSH CX                                     {Empile tous les registres}
 PUSH BX                                       {modifi굎 par la routine}
 MOV  BL,3                               {Nombre de tentatives tol굍괻s}
  (*Attend que le contr뱇eur puisse recevoir des donn괻s*)
@1:
 XOR  CX,CX                                {65536 it굍ations au maximum}
@2:
 IN   AL,64h                             {Lit le contenu du port d'굏at}
 NOP
 NOP
 NOP
 NOP
 TEST AL,2                     {Reste-t-il un caract둹e dans le tampon?}
 LOOPNE @2                                                   {Oui--> @2}
  (*Envoie un caract둹e au contr뱇eur*)
 MOV  AL,AH                               {Transf둹e le caract둹e en AL}
 OUT  60h,AL                              {puis dans le port de donn괻s}
 NOP
 NOP
 NOP
 NOP
@3:
 IN   AL,64h                             {Lit le contenu du port d'굏at}
 NOP
 NOP
 NOP
 NOP
 TEST AL,1                           {R굋onse dans le tampon de sortie?}
 LOOPE @3                                                  {Non  --> @3}
  (*Lit et exploite la r굋onse du contr뱇eur*)
 IN   AL,60h                                    {Lit le port de donn괻s}
 NOP
 NOP
 NOP
 NOP
 CMP  AL,0FAh                                       {Caract둹e accept�?}
 JE   @End                                         {Oui -> tout va bien}
  (*Le caract둹e n'a pas 굏� accept�*)
 DEC  BL                              {D괹r굆ente le compteur d'erreurs}
 JNE  @2                               {Peut-on recommencer ? Oui--> @2}
 OR   BL,1 {Non, mettre � 0 l'indicateur de z굍o pour signaler l'erreur}
@End:
 POP  BX                {D굋ile les registres sauvegard굎}
 POP  CX
END;

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴콘
 �                            Fonction SendTypm                         �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複蔔


 Description
 袴袴袴袴袴�

  Cette proc괺ure transmet la vitesse Typematic au contr뱇eur du clavier.

 Remarques
 袴袴袴袴�

  � L'appel de cette fonction  comprend le param둻re de vitesse ainsi que
    le fr굌uence  de l'envoie  comme  le montre  cette formule  en pseudo
    Pascal: 췚etTypm((Delay shl 5)+Speed))�.

  � Voici une bref tableau  montrant les valeurs  accord괻 au param굏rage
    de cette fonction:
    旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
    �              D굃ai      Fr굌uence de r굋굏ition par seconde       �
    �         (Delay) �        � (Speed)                                �
    � �袴袴袴袴袴袴袴賈袴敲  �賈袴袴袴袴袴袴袴袴敲                      �
    � �  0 : 1/4 seconde  �  �  0 : 30,0 r굋./s  �                      �
    � �  1 : 1/2 seconde  �  �  1 : 26,7 r굋./s. �                      �
    � �  2 : 3/4 seconde  �  �  2 : 24,0 r굋./s. �                      �
    � �  3 : 1 seconde    �  �  3 : 21,8 r굋./s. �                      �
    � 픔컴컴컴컴컴컴컴컴컴�  �         .         �                      �
    � � Pr괹ision    �20% �  �         .         �                      �
    � 훤袴袴袴袴袴袴袴袴袴�  �         .         �                      �
    �                        � 28 :  2,5 r굋./s. �                      �
    �                        � 29 :  2,3 r굋./s. �                      �
    �                        � 30 :  2,1 r굋./s. �                      �
    �                        � 31 :  2,0 r굋./s. �                      �
    �                        훤袴袴袴袴袴袴袴袴袴�                      �
    읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
}

Function SetTypm(Rate:Byte):Boolean;Assembler;ASM
 XOR  DL,DL         {Transmission a priori d괽ectueuse}
 MOV  AH,0F3h   {Commande de fixation vitesse Typmatic}
 CLI                         {Inhibe les interruptions}
 CALL SendKB                       {Vers le contr뱇eur}
 JNE  @1                            {Erreur? Oui--> @1}
 MOV  AH,Rate                {Lit la vitesse Typematic}
 CALL SendKB                       {Vers le contr뱇eur}
 JNE  @1                            {Erreur? Oui -> @1}
 INC  DL                   {tout va bien, renvoie TRUE}
@1:
 STI                       {R굏ablit les interruptions}
 MOV  AL,DL       {Met la valeur de retour sur la pile}
END;

{$ENDIF}