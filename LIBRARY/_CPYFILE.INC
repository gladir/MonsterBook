{_CpyFile.Inc}

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

{$IFNDEF ___CopyFile}
 {$DEFINE ___CopyFile}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                      Fonction _CopyFile                      Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction copie un fichier d'un unit‚ … une autre, ou d'un
 r‚pertoire  … un autre.  Il retourne vrai  si l'op‚ration  c'est
 correctement d‚roul‚ ou faux si des problŠmes ont eu lieu.


 Remarques
 ÍÍÍÍÍÍÍÍÍ

  ş Cette fonction r‚clame un systŠme d'exploitation compatible …
    un DOS version 2 ou post‚rieurs (datant de moins mars 1983)!

  ş A la diff‚rence de la fonction parallŠle ®CopyFile¯, celle-ci
    appelle  une proc‚dure virtuel  de progression  de la copie …
    mesure qu'elle s'effectue.
}

 Function _CopyFile(Const Source,Target:String;Proc:BackgroundCopy):Byte;
 {$DEFINE NoVoid}
 {$UNDEF __CopyFile}
 {$DEFINE Dialog}
 {$I Library\CopyFile.Inc}
 {$UNDEF Dialog}
 {$UNDEF NoVoid}

{$ENDIF}