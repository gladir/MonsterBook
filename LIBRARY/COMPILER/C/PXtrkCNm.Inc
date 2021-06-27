{\Source\Chantal\Library\C\PXtrkCNm.Inc}

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

{$IFNDEF __PXtrkCNm}
 {$DEFINE __PXtrkCNm}

{$IFDEF Win32}
 {$H-}
{$ENDIF}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                             Fonction PXtrkCNm                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction extrait un nombre de format de langage C/C++ d'une chaŒne
 de caractŠres ASCIIZ … partir de la position du pointeur I.  La valeur de
 la variable de param‚trage  I est modifi‚ pour pointer … la fin du nombre
 venant d'ˆtre extrait.
}

Function PXtrkCNm(Var I:Word;Line:PChr):String;
Label 1;
Var
 S:String;
 J:Word;
Begin
 PXtrkCNm:='';J:=I;
 Case Line^[J]of
  #0:Exit;
  '0':Case Line^[J+1]of
   #0:Begin Inc(J);PXtrkCNm:='0'End;
   '0'..'7':Begin
    S:='';
    While Line^[J]in['0'..'7']do Begin
     IncStr(S,Line^[J]);
     Inc(J)
    End;
    Goto 1;
   End;
   'B','b':Begin
    S:='0'+Line^[J+1];Inc(J,2);
    While Line^[J]in['0','1']do Begin
     IncStr(S,Line^[J]);
     Inc(J)
    End;
    Goto 1;
   End;
   'X','x':Begin
    S:='0'+Line^[J+1];Inc(J,2);
    While Line^[J]in['0'..'9','A'..'F','a'..'f']do Begin
     IncStr(S,Line^[J]);
     Inc(J)
    End;
    Goto 1;
   End;
   'L','l':Begin
    PXtrkCNm:='0'+Line^[J+1];
    Inc(J,2)
   End;
   Else Begin
    PXtrkCNm:='0';
    Inc(J)
   End;
  End;
  '1'..'9':Begin
   S:='';
   While Line^[J]in['0'..'9']do Begin
    IncStr(S,Line^[J]);
    Inc(J)
   End;
 1:If Line^[J]in['l','L']Then Begin
    IncStr(S,Line^[J]);
    Inc(J)
   End;
   PXtrkCNm:=S;
  End;
  Else
  PXtrkCNm:='';
 End;
 I:=J;
End;

{$ENDIF}