{_TESetModified.Inc}

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴콘
 �                        Proc괺ure _TESetModified                      �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複蔔


 Description
 袴袴袴袴袴�

  Cette proc괺ure fixe le drapeau de modification l'괺iteur de tra똳ement
 pour lui indiquer que le texte n'est plus identique � celui sur disque.


 Remarque
 袴袴袴袴

  � La variable 췘.Modified� indique  si le texte  contenu en m굆oire est
    identique (False) ou non (True) � la copie sur unit� disque.
}

Procedure _TESetModified(Var Q:EditorApp);
Var
 Kr:Byte;   { Couleur d'affichage de l'indicateur de modification }
 X:Byte;    { Position o� afficher l'indicateur de modification }
Begin
 If Not(Q.Modified)Then Begin
  Q.Modified:=True;
  If(Q.Mode=vtPJ)Then Kr:=CurrKrs.PersonalJournal.Env.Insert
                 Else Kr:=CurrKrs.Editor.Env.Modified;
  If(IsGrf)Then X:=14 Else X:=15;
  WESetEndBarTxtX(Q.W,X,'*',Kr);
 End;
End;