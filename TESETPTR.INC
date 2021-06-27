{TESetPtr.Inc}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Proc‚dure TESetPtr                          Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure met … jour la position interne du pointeur courant en
 fonction de la position courante du traŒtement de texte.


 Remarques
 ÍÍÍÍÍÍÍÍÍ

  ş La variable ®Q.Lst¯ est le listing  du traŒtement de texte contenue
    en m‚moire RAM de l'ordinateur.

  ş La variable ®Q.P¯ indique le num‚ro de ligne absolue (partant de 0)
    de la ligne en pleine ‚dition.
}

Procedure TESetPtr(Var Q:EditorApp);Begin
 ALSetPtr(Q.List,Q.P);
 Q.CurrPtr:=ALPushCurrPtr(Q.List)
End;