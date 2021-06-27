{InvByte.Inc}

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

{$IFNDEF __InvByte}
 {$DEFINE __InvByte}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                             Fonction InvByte                          Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction inverse les bits d'un octets. Le bits du haut se d‚placer
 vers le bas et vice-versa.
}

Function InvByte(X:Byte):Byte;Assembler;ASM
 MOV BH,0
 MOV BL,X     { ÚÄÄÂÄÄÂÄÄÂÄÄÂÄÄÂÄÄÂÄÄÂÄÄ¿}
 MOV CH,BH    { ³ 0³ 1³ 2³ 3³ 4³ 5³ 6³ 7³}
 MOV DX,8001h { ÀÄÄÁÄÄÁÄÄÁÄÄÁÄÄÁÄÄÁÄÄÁÄÄÙ}
 XOR AX,AX    {  ³^ ³^ ³^ ³^ ³^ ³^ ³^ ³^ }
 MOV CL,1     {  ³ÀÄ))Ä))Ä))Ä))Ä))Ä))ÄÙ³ }
@@Restart:    {  ÀÄÄ))Ä))Ä))Ä))Ä))Ä))ÄÄÙ }
 MOV AL,BL    {     ³ÀÄ))Ä))Ä))Ä))ÄÙ³    }
 ROR AL,CL    {     ÀÄÄ))Ä))Ä))Ä))ÄÄÙ    }
 AND AL,DH    {        ³ÀÄ))Ä))ÄÙ³       }
 OR  CH,AL    {        ÀÄÄ))Ä))ÄÄÙ       }
 MOV AL,BL    {           ³ÀÄÙ³          }
 ROL AL,CL    {           ÀÄÄÄÙ          }
 AND AL,DL
 OR  CH,AL
 ADD CL,2
 SHR DH,1
 SHL DL,1
 CMP CL,9
 JNE @@Restart
 MOV AL,CH
END;

{$ENDIF}