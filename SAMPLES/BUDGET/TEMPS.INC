(****************************************************************************)
(*                                                                          *)
(*                           Temps Version 2.00A                            *)
(*                                                                          *)
(*                         Copyright (C) 1990 par                           *)
(*                         Les Chevaliers de Malte                          *)
(*                                                                          *)
(****************************************************************************)

Type String6 = String[6];

Function Heures:String6;
Var Heur,Minute,Seconde : String[6];
Begin
 Registre.AH := $2C;
 Intr($21,Registre);
 Str(Registre.CH,Heur);
 If(Length(Heur)<2)Then Heur:=' '+Heur;
 Str(Registre.CL,Minute);
 If(Length(Minute)<2)Then Minute:='0'+Minute;
 Str(Registre.DH,Seconde);
 If(Length(Seconde)<2)Then Seconde:='0'+Seconde;
 Heures:=Heur+Minute+Seconde;
End;

