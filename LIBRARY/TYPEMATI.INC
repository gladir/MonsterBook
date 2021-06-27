{TypeMati.Inc}

{$IFNDEF __SetTypm}
 {$DEFINE __SetTypm}

{��������������������������������������������������������������������
 �                      Proc�dure interne SendKB                    �
 ��������������������������������������������������������������������


 Description
 �����������

  Cette proc�dure envoie un octet au contr�leur du clavier permettant
 �vantuellement de l'ajuster convenablement.

 Remarques
 ���������

  � A l'Entr�e: AH=octet � envoyer. Sortie: Indicateur de z�ro  (ZF):
    0 = Erreur,  1 = tout va bien.  Les Registres: AX le registre des
    indicateurs sont modifi�s.

  � Routine � usage  interne,  ne doit petre appel�e  qu'� partir  du
    pr�sent module.
}

Procedure SendKB;Near;Assembler;ASM
 PUSH CX                                     {Empile tous les registres}
 PUSH BX                                       {modifi�s par la routine}
 MOV  BL,3                               {Nombre de tentatives tol�r�es}
  (*Attend que le contr�leur puisse recevoir des donn�es*)
@1:
 XOR  CX,CX                                {65536 it�rations au maximum}
@2:
 IN   AL,64h                             {Lit le contenu du port d'�tat}
 NOP
 NOP
 NOP
 NOP
 TEST AL,2                     {Reste-t-il un caract�re dans le tampon?}
 LOOPNE @2                                                   {Oui--> @2}
  (*Envoie un caract�re au contr�leur*)
 MOV  AL,AH                               {Transf�re le caract�re en AL}
 OUT  60h,AL                              {puis dans le port de donn�es}
 NOP
 NOP
 NOP
 NOP
@3:
 IN   AL,64h                             {Lit le contenu du port d'�tat}
 NOP
 NOP
 NOP
 NOP
 TEST AL,1                           {R�ponse dans le tampon de sortie?}
 LOOPE @3                                                  {Non  --> @3}
  (*Lit et exploite la r�ponse du contr�leur*)
 IN   AL,60h                                    {Lit le port de donn�es}
 NOP
 NOP
 NOP
 NOP
 CMP  AL,0FAh                                       {Caract�re accept�?}
 JE   @End                                         {Oui -> tout va bien}
  (*Le caract�re n'a pas �t� accept�*)
 DEC  BL                              {D�cr�mente le compteur d'erreurs}
 JNE  @2                               {Peut-on recommencer ? Oui--> @2}
 OR   BL,1 {Non, mettre � 0 l'indicateur de z�ro pour signaler l'erreur}
@End:
 POP  BX                {D�pile les registres sauvegard�s}
 POP  CX
END;

{������������������������������������������������������������������������
 �                            Fonction SendTypm                         �
 ������������������������������������������������������������������������


 Description
 �����������

  Cette proc�dure transmet la vitesse Typematic au contr�leur du clavier.

 Remarques
 ���������

  � L'appel de cette fonction  comprend le param�tre de vitesse ainsi que
    le fr�quence  de l'envoie  comme  le montre  cette formule  en pseudo
    Pascal: �SetTypm((Delay shl 5)+Speed))�.

  � Voici une bref tableau  montrant les valeurs  accord�e au param�trage
    de cette fonction:
    �������������������������������������������������������������������Ŀ
    �              D�lai      Fr�quence de r�p�tition par seconde       �
    �         (Delay) �        � (Speed)                                �
    � �������������������ͻ  �������������������ͻ                      �
    � �  0 : 1/4 seconde  �  �  0 : 30,0 r�p./s  �                      �
    � �  1 : 1/2 seconde  �  �  1 : 26,7 r�p./s. �                      �
    � �  2 : 3/4 seconde  �  �  2 : 24,0 r�p./s. �                      �
    � �  3 : 1 seconde    �  �  3 : 21,8 r�p./s. �                      �
    � �������������������Ķ  �         .         �                      �
    � � Pr�cision    �20% �  �         .         �                      �
    � �������������������ͼ  �         .         �                      �
    �                        � 28 :  2,5 r�p./s. �                      �
    �                        � 29 :  2,3 r�p./s. �                      �
    �                        � 30 :  2,1 r�p./s. �                      �
    �                        � 31 :  2,0 r�p./s. �                      �
    �                        �������������������ͼ                      �
    ���������������������������������������������������������������������
}

Function SetTypm(Rate:Byte):Boolean;Assembler;ASM
 XOR  DL,DL         {Transmission a priori d�fectueuse}
 MOV  AH,0F3h   {Commande de fixation vitesse Typmatic}
 CLI                         {Inhibe les interruptions}
 CALL SendKB                       {Vers le contr�leur}
 JNE  @1                            {Erreur? Oui--> @1}
 MOV  AH,Rate                {Lit la vitesse Typematic}
 CALL SendKB                       {Vers le contr�leur}
 JNE  @1                            {Erreur? Oui -> @1}
 INC  DL                   {tout va bien, renvoie TRUE}
@1:
 STI                       {R�tablit les interruptions}
 MOV  AL,DL       {Met la valeur de retour sur la pile}
END;

{$ENDIF}