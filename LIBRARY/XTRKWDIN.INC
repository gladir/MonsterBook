{XtrkWdIn.Inc}

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

{$IFNDEF XtrkWdInStr}
 {$DEFINE XtrkWdInStr}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Function XtrkWdInStr                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction cherche dans une chaŒne de caractŠre de format Pascal un
 nombre d‚terminer par ®Nm¯ de variable de style entiŠre (Mot ou "Word").
 Ceci ‚vitant une duplication de 3 ou 4 proc‚dures identique de processus
 en s‚rie.  Il retourne la position  … laquel il rendant la chaŒne par la
 poursuite par un autre d'une extraction d'information.
}

Function XtrkWdInStr(Const S:String;Nm:Wd;Var Buffer:Array of PWord):Byte;Near;Var I,LI:Byte;J,X:Wd;Begin
 I:=1;
 If StrI(1,S)in[':',';']Then Inc(I);
 For J:=0to Nm-1do Begin
  SkipSpcInLn(I,S);LI:=I;X:=StrToWord(XtrkDecNm(I,S));
  If(LI=I)Then Begin
   For J:=I to Nm-1do Buffer[J]^:=0;
   XtrkWdInStr:=0;
   Break;
  End
   Else
  Buffer[J]^:=X;
  SkipSpcInLn(I,S);
  If StrI(I,S)=','Then Inc(I);
 End;
 XtrkWdInStr:=I;
End;

{$ENDIF}