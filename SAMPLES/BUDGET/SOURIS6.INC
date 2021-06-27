Procedure InitialiseSouris(Var Operationnel,NombreBouton:Word);
Begin
 Registre.Ax := $0000;
 Intr($33,Registre);
 Registre.AX := Operationnel;
 Registre.BX := NombreBouton;
End;

Procedure AffichePointeur;     InLine($B8/$01/$00/$CD/$33);

Procedure EffacePointeur;      InLine($B8/$02/$00/$CD/$33);

Procedure OuvrePointeurSouris; InLine($B8/$01/$00/$CD/$33);

Procedure FermePointeurSouris; InLine($B8/$02/$00/$CD/$33);

Procedure PositionEtatSouris(Var X,Y,Etat:Word);
Begin
 Registre.AX := $0003;
 Intr($33,Registre);
 Etat := Registre.BX;
 X    := Registre.CX;
 Y    := Registre.DX;
End;

Procedure PositionnePointeurSouris(X,Y:Word);
Begin
 Registre.AX := $0004;
 Registre.CX := X;
 Registre.DX := Y;
 Intr($33,Registre);
End;

Procedure EnfoncePointeurSouris(Var Bouton,Compteur,X,Y:Word);
Begin
 Registre.AX := $0005;
 Registre.BX := Bouton;
 Intr($33,Registre);
 Bouton   := Registre.AX;
 Compteur := Registre.BX;
 X        := Registre.CX;
 Y        := Registre.DX;
End;

Procedure RelachePointeurSouris(Var Bouton,Compteur,X,Y:Word);
Begin
 Registre.AX := $0006;
 Registre.BX := Bouton;
 Intr($33,Registre);
 Bouton   := Registre.AX;
 Compteur := Registre.BX;
 X        := Registre.CX;
 Y        := Registre.DX;
End;

Procedure LimiteHorizontal(Minimum,Maximum:Word);
Begin
 Registre.AX := $0007;
 Registre.CX := Minimum;
 Registre.DX := Maximum;
 Intr($33,Registre);
End;

Procedure LimiteVertical(Minimum,Maximum:Word);
Begin
 Registre.AX := $0008;
 Registre.CX := Minimum;
 Registre.DX := Maximum;
 Intr($33,Registre);
End;

Procedure DefinitionPointeurGraphique(X,Y:Word;Var Pointeur);
Begin
 Registre.AX := $0009;
 Registre.BX := X;
 Registre.CX := Y;
 Registre.DX := Ofs(Pointeur);
 Registre.ES := Seg(Pointeur);
 Intr($33,Registre);
End;

Procedure DefinitionPointeurTexte(DType,DAND,DXOR:Word);
Begin
 Registre.AX := $000A;
 Registre.BX := DType;
 Registre.CX := DAND;
 Registre.DX := DXOR;
 Intr($33,Registre);
End;

Procedure CompteurDeplacementSouris(X,Y:Integer);
Begin
 Registre.AX := $000B;
 Registre.CX := X;
 Registre.DX := Y;
 Intr($33,Registre);
End;

Procedure ActivationLightPen;
Begin
 InLine($B8/$0D/$00/            { Mov Ax,000D }
	$CD/$33);               { Int 33      }
End;

Procedure SuspensionLightPen;
Begin
 InLine($B8/$0E/$00/            { Mov Ax,000E }
	$CD/$33);               { Int 33      }
End;

Procedure NombrePixelMickey(X,Y:Word);
Begin
 Registre.AX := $000F;
 Registre.CX := X;
 Registre.DX := Y;
 Intr($33,Registre);
End;

Procedure ExclusionPointeurSouris(X1,Y1,X2,Y2:Word);
Begin
 Registre.AX := $0010;
 Registre.CX := X1;
 Registre.DX := Y1;
 Registre.SI := X2;
 Registre.DI := Y2;
 Intr($33,Registre);
End;

Procedure VitessePointeurSouris(Vitesse:Word);
Begin
 Registre.AX := $0013;
 Registre.DX := Vitesse;
 Intr($33,Registre);
End;
