{TESetPtr.Inc}

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴콘
 �                        Proc괺ure TESetPtr                          �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複蔔


 Description
 袴袴袴袴袴�

  Cette proc괺ure met � jour la position interne du pointeur courant en
 fonction de la position courante du tra똳ement de texte.


 Remarques
 袴袴袴袴�

  � La variable 췘.Lst� est le listing  du tra똳ement de texte contenue
    en m굆oire RAM de l'ordinateur.

  � La variable 췘.P� indique le num굍o de ligne absolue (partant de 0)
    de la ligne en pleine 괺ition.
}

Procedure TESetPtr(Var Q:EditorApp);Begin
 ALSetPtr(Q.List,Q.P);
 Q.CurrPtr:=ALPushCurrPtr(Q.List)
End;