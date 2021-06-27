{CStr.Inc}

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

{$IFNDEF __CStr}
 {$DEFINE __CStr}
 {$I \Source\Chantal\Library\GetCountry.Inc}
 {$I \Source\Chantal\Library\Left.Inc}
 {$I \Source\Chantal\Library\Str.Inc}

Function CStr(I:Long):String;Var S:String;L:Byte Absolute S;Begin
 S:=Str(I);ASM AND I.Word[2],$7FFF;End;
 If I>=1000000000Then CStr:=Left(S,L-9)+ThSep[0]+Copy(S,L-8,3)+ThSep+Copy(S,L-5,3)+ThSep[0]+Copy(S,L-2,3)Else
 If I>=1000000Then CStr:=Left(S,L-6)+ThSep[0]+Copy(S,L-5,3)+ThSep[0]+Copy(S,L-2,3)Else
 If I>=1000Then CStr:=Left(S,L-3)+ThSep[0]+Copy(S,L-2,3)
 Else CStr:=S
End;

{$ENDIF}