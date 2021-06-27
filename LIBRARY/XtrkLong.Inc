{XtrkLong.Inc}

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

{$IFNDEF XtrkLongInStr}
 {$DEFINE XtrkLongInStr}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                       Function XtrkLongInStr                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction cherche dans une chaŒne de caractŠre de format Pascal un
 nombre d‚terminer par ®Nm¯  de variable de style entiŠre  (double Mot ou
 "Double Word").  Ceci  ‚vitant une  duplication de  3  ou  4  proc‚dures
 identique  de processus  en s‚rie.  Il retourne la position  … laquel il
 rendant  la chaŒne  par la  poursuite  par  un  autre  d'une  extraction
 d'information.
}

Function XtrkLongInStr(Const S:String;Nm:Word;Var Buffer:Array of PLong):Byte;Near;
Var
 I,LI:Byte;
 J,X:Word;
 {$IFDEF __Windows__}
  PWord:^Word;
 {$ENDIF}
Begin
 I:=1;
 If StrI(1,S)in[':',';']Then Inc(I);
 For J:=0to Nm-1do Begin
  SkipSpcInLn(I,S);LI:=I;
  X:=StrToInt(XtrkDecNm(I,S));
  If(LI=I)Then Begin
   For J:=I to Nm-1do Begin
    If Odd(J)Then Buffer[J]^:=0
     Else
    Begin
     {$IFDEF __Windows__}
      PWord:=@Buffer[J]^;
      PWord^:=0;
     {$ELSE}
      Word(Buffer[J]^):=0;
     {$ENDIF}
    End;
   End;
   XtrkLongInStr:=0;
   Break;
  End
   Else
  Buffer[J]^:=X;
  SkipSpcInLn(I,S);
  If StrI(I,S)=','Then Inc(I);
 End;
 XtrkLongInStr:=I;
End;

{$ENDIF}