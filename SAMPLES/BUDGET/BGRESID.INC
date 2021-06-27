Procedure ChangeVecteur(Numero:Byte;Var Adresse);
Begin
 Registre.AH := $25;
 Registre.AL := Numero;
 Registre.DS := Seg(Adresse);
 Registre.DX := Ofs(Adresse);
 MsDos(Registre);
End;

Procedure LectureVecteur(Numero:Byte;Var Segment,OffSet:Word);
Begin
 Registre.AH := $35;
 Registre.Al := Numero;
 MsDos(Registre);
 Segment := Registre.ES;
 OffSet  := Registre.BX;
End;

Const Interruption1C : Byte = $CF;

Var Compteur1C : Word;

Procedure ApplicationHeure;
Begin
 InLine($FA);
 ChangeVecteur($1B,Interruption1C);
 ChangeVecteur($1C,Interruption1C);
 ChangeVecteur($23,Interruption1C);
 InLine($FB);
End;
