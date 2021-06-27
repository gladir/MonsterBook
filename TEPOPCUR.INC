{TEPopCurr.Inc}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Proc‚dure TEPopCurr                          Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction retourne le pointeur de la ligne courante (en chaŒne de
 caractŠre ASCIIZ) de l'‚diteur de traŒtement de texte.
}

Function TEPopCurr(Var Q:EditorApp):PChr;Begin
 ALPopCurrPtr(Q.List,Q.CurrPtr);
 TEPopCurr:=_ALGetCurrBuf(Q.List)
End;