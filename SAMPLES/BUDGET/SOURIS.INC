(****************************************************************************)
(*                                                                          *)
(*                           Souris Version 2.00A                           *)
(*                                                                          *)
(*                          Copyright (C) 1990 par                          *)
(*                          Les Chevaliers de Malte                         *)
(*                                                                          *)
(****************************************************************************)

Procedure PositionEtBouton(Var X,Y,Bouton:Integer);
Begin
 Registre.AX := $0003;
 Intr($33,Registre);
 X      := Registre.CX;
 Y      := Registre.DX;
 Bouton := Registre.BX;
End;

Procedure LimiteX(Minimum,Maximum:Integer);
Begin
 Registre.AX := $0007;
 Registre.CX := Minimum;
 Registre.DX := Maximum;
 Intr($33,Registre);
End;

Procedure LimiteY(Minimum,Maximum:Integer);
Begin
 Registre.AX := $08;
 Registre.CX := Minimum;
 Registre.DX := Maximum;
 Intr($33,Registre);
End;

