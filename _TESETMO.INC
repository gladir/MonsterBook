{_TESetModified.Inc}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Proc‚dure _TESetModified                      Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure fixe le drapeau de modification l'‚diteur de traŒtement
 pour lui indiquer que le texte n'est plus identique … celui sur disque.


 Remarque
 ÍÍÍÍÍÍÍÍ

  ş La variable ®Q.Modified¯ indique  si le texte  contenu en m‚moire est
    identique (False) ou non (True) … la copie sur unit‚ disque.
}

Procedure _TESetModified(Var Q:EditorApp);
Var
 Kr:Byte;   { Couleur d'affichage de l'indicateur de modification }
 X:Byte;    { Position o— afficher l'indicateur de modification }
Begin
 If Not(Q.Modified)Then Begin
  Q.Modified:=True;
  If(Q.Mode=vtPJ)Then Kr:=CurrKrs.PersonalJournal.Env.Insert
                 Else Kr:=CurrKrs.Editor.Env.Modified;
  If(IsGrf)Then X:=14 Else X:=15;
  WESetEndBarTxtX(Q.W,X,'*',Kr);
 End;
End;