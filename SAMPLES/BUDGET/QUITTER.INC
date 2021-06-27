(****************************************************************************)
(*                                                                          *)
(*                           Quitter Version 1.00A                          *)
(*                                                                          *)
(*                           Copyright (C) 1990 par                         *)
(*                       Sylvain Maltais Internationnal                     *)
(*                                                                          *)
(****************************************************************************)

Procedure Quitter;
Begin
 InLine($B8/$02/$00/
        $CD/$33);
 InitialiseEcran(32,7);
 Ecrit('Au Revoir Budget Sylvain Maltais Version 2.00A'+Espace(39),31);
 InLine($B4/$01/
        $B1/$07/
        $B5/$06/
        $CD/$10);
 Halt;
End;

