{GetStrMs.Inc}

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

{$IFNDEF __GetStrMouse}
 {$DEFINE __GetStrMouse}

 {$I \Source\Chantal\Library\Mouse\BusType.Inc}
 {$I \Source\Chantal\Library\Mouse\GetMsVer.Inc}

 {ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
  ³                       Fonction GetStrMouse                      Û
  ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


  Description
  ÍÍÍÍÍÍÍÍÍÍÍ

   Cette fonction retourne une chaŒne de caractŠres contenant le nom,
  la marque et  la version du pilote de souris si elle  existe  sinon
  elle retourne un message de ®Souris non-install‚¯.
 }

Function GetStrMouse:String;Var S,Marque:String;Begin
 If {$IFDEF Adele}Adele{$ELSE}Chantal{$ENDIF}.Mouse>0Then Begin
  Case(BusType)of
   $01: S:='Bus';
   $02: S:={$IFDEF ENGLISH}'Serie'{$ELSE}'S‚rie'{$ENDIF};
   $03: S:='Inport';
   $04: S:='PS/2';
   $05: S:='HP';
   Else If(VideoMousePortFound)Then S:={$IFDEF ENGLISH}'Serie on video card'{$ELSE}'S‚rie sur carte vid‚o'{$ENDIF}
                               Else S:={$IFDEF ENGLISH}'Serie'{$ELSE}'S‚rie'{$ENDIF};
  End;
  Case({$IFDEF Adele}Adele{$ELSE}Chantal{$ENDIF}.Mouse)of
   msLogitech:Marque:=' Logitech';
   msMicrosoft:Marque:=' Microsoft';
   msSmooth:Marque:={$IFDEF ENGLISH}' Smooth of Andy Hakim'{$ELSE}' Smooth d''Andy Hakim'{$ENDIF};
   msZNIX:Marque:=' Z-NIX';
   msGenius:Marque:=' Genius';
   Else Marque:='';
  End;
  GetStrMouse:={$IFDEF ENGLISH}'Mouse '{$ELSE}'Souris '{$ENDIF}+S+Marque+', Version '+GetMsVer;
 End
  Else
 GetStrMouse:={$IFDEF ENGLISH}'Mouse not found'{$ELSE}'Souris non-install‚'{$ENDIF};
End;

{$ENDIF}