(***************************************************************)
(*                                                             *)
(*                   Module Clavier/Input                      *)
(*                                                             *)
(***************************************************************)

Var Touche        : Word;
    ToucheSpecial : Byte;

Procedure SonErreurClavier;
Begin
 Sound(500);
 Delay(100);
 NoSound;
End;

Function LitClavier:Word;
Begin
 Registre.AH := $00;
 Intr($16,Registre);
 LitClavier := Registre.AX;
End;

Function LitClavierSpecial:Byte;
Begin
 Registre.AH := $02;
 Intr($16,Registre);
 LitClavierSpecial := Registre.AL;
End;

Function InPut(X,Y,Longeur:Byte;Depart:String):String;
Var MaxSize  : Byte;
    ActSize  : Byte;
    XPos     : Byte;
    YPos     : Byte;
    ActPos   : Byte;
    AncienA  : Byte;
    Compteur : Byte;
    Change   : Boolean;
    Chaine   : String;
    Ancien   : String;
Begin
 For Compteur := 0 to Longeur - 1 do
 Begin
  GotoXY(X+Compteur,Y);
  Write(' ');
 End;
 Change  := False;
 XPos    := X;
 YPos    := Y;
 Touche  := 0;
 FillChar(Chaine,SizeOf(Chaine),0);
 ActPos  := 1;
 MaxSize := Longeur;
 Ancien  := '';
 AncienA := 1;
 While(Lo(Touche)<>13)do
 Begin
  GotoXY(XPos,YPos);
  FillChar(Chaine,1,ActSize);
  Write(Chaine+' ');
  FillChar(Chaine,1,0);
  GotoXY(XPos+ActPos-1,YPos);
  Touche        := LitClavier;
  ToucheSpecial := LitClavierSpecial;
  If(Lo(Touche)=0)Then
  Begin
   Case Hi(Touche) of
{ Home      } 71 : ActPos := 1;
{ Up        } 72 : SonErreurClavier;
{ Page Up   } 73 : Begin
		    AncienA := ActPos;
		    Ancien  := Chaine;
		    Chaine  := Depart;
		    FillChar(Chaine,1,0);
		    ActSize := Length(Depart);
		    ActPos := ActSize + 1;
		    For Compteur := 0 to Longeur - 1 do
		    Begin
		     GotoXY(X+Compteur,Y);
		     Write(' ');
		    End;
		   End;
{ Left      } 75 : If(ActPos>1)Then Dec(ActPos)
			       Else SonErreurClavier;
{ Right     } 77 : If(ActPos<=ActSize)Then Inc(ActPos)
				      Else SonErreurClavier;
{ End       } 79 : ActPos := ActSize + 1;
{ Down      } 80 : SonErreurClavier;
{ Page Down } 81 : Begin
		    ActPos := AncienA;
		    Chaine := Ancien;
		    FillChar(Chaine,1,0);
		    ActSize := Length(Ancien);
		    For Compteur := 0 to Longeur - 1 do
		    Begin
		     GotoXY(X+Compteur,Y);
		     Write(' ');
		    End;
		   End;
{ Delete    } 83 : If((ActSize>0)and(ActPos<=ActSize))Then
		   Begin
		    Change := True;
		    Move(Chaine[ActPos+1],Chaine[ActPos],MaxSize-ActPos);
		    Chaine[ActSize] := #0;
		    Dec(ActSize);
		   End;
	      else Touche := 0;
   End;
  End
   else
  Case Lo(Touche) of
{ BackSpace }  8 : If((ActPos>1)and(ActSize>0)and((ToucheSpecial and $04)=0))Then
		   Begin
		    Change := True;
		    If(ActPos<=ActSize)Then
		    Begin
		     Move(Chaine[ActPos],Chaine[ActPos-1],MaxSize-ActPos+1)
		    End;
		    Chaine[ActSize] := #0;
		    Dec(ActPos);
		    Dec(ActSize);
		   End
		    else
		   SonErreurClavier;
{ Esc       } 27 : Begin
		    FillChar(Chaine,SizeOf(Chaine),0);
		    ActPos  := 1;
		    ActSize := 0;
		    InPut   := '';
		    Exit;
		   End;
	    else
	   Begin
	    If((ActSize>=MaxSize)and(Lo(Touche)<>13))Then SonErreurClavier
	     else
{ Enter }   If(Lo(Touche)=13)Then
	    Begin
	     Inc(ActSize);
	     Chaine[ActSize] := Chr(Lo(Touche));
	    End
	     else
	    Begin
	     If((ToucheSpecial and $80)<>0)Then { Insert Ouvert ? }
	     Begin
	      Move(Chaine[ActPos],Chaine[ActPos+1],MaxSize-ActPos);
	      Inc(ActSize);
	     End
	      else
	     If(ActPos>ActSize)Then Inc(ActSize);
	     Change := True;
	     Chaine[ActPos] := Chr(Lo(Touche));
	     Inc(ActPos);
	    End;
	   End;
  End;
 End;
 FillChar(Chaine,1,ActSize);
 InPut := Chaine; { Sortie de Input --> Chaine }
End;
