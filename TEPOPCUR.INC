{TEPopCurr.Inc}

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
 �                        Proc괺ure TEPopCurr                          �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�


 Description
 袴袴袴袴袴�

  Cette fonction retourne le pointeur de la ligne courante (en cha똭e de
 caract둹e ASCIIZ) de l'괺iteur de tra똳ement de texte.
}

Function TEPopCurr(Var Q:EditorApp):PChr;Begin
 ALPopCurrPtr(Q.List,Q.CurrPtr);
 TEPopCurr:=_ALGetCurrBuf(Q.List)
End;