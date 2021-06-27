{\Source\Chantal\Library\InLst.Inc}

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

{$IFNDEF __InLst}
 {$DEFINE __InLst}

 {ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
  ³                            Fonction InLst                         Û
  ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


  Description
  ÍÍÍÍÍÍÍÍÍÍÍ

   Cette fonction effectue la recherche de chaŒne de caractŠres dans un
  tampon d‚finit par la variable de param‚trage  ®Buffer¯.  Si elle est
  d‚tect‚, alors il retourne vrai, sinon faux.


  Remarque
  ÍÍÍÍÍÍÍÍ

   ş Le tampon doit contenir des suites de chaŒnes de caractŠres Pascal
     et le dernier doit avoir  une  longueur de  0 ou si vous pr‚f‚rer,
     aprŠs avoir mis tous  les chaŒnes de caractŠres Pascal  … la suite
     des autres il doit y avoir un code ASCII 0.
 }

 Function InLst(Var Buffer;Size:Word;Item:String):Bool;Var Buf:TByte Absolute Buffer;J:Wd;L:Byte;Begin
  J:=0;InLst:=True;
  While(J<Size)do Begin
   L:=Buf[J]+1;
   If Compare(Buf[J],Item,L)Then Exit;
   Inc(J,L)
  End;
  InLst:=False
 End;

{$ENDIF}