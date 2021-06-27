Procedure Presentation;
Var Compteur : Word;

 Procedure Ecrit(X,Y:Byte;Phrase:String255;Couleur:Byte);
 Var Compteur : Byte;
 Begin
  For Compteur := 1 to Length(Phrase) do
  Begin
   If(Phrase[Compteur] <> #32)Then
   Begin
    If(Phrase[Compteur] ='X')Then Phrase[Compteur]:=#32;
    EcritUnCaractere(X+Compteur-1,Y,Ord(Phrase[Compteur]),Couleur);
   End;
  End;
 End;

Begin
 InLine($B8/$03/$00/
	$CD/$10/

	$B4/$01/
	$B1/$20/
	$B5/$20/
	$CD/$10);
 BoiteCaractere(0,0,79,24,31);
 HauteCouleur(1);
 For Compteur := 0 to 500 do MemW[AdresseEcran:Random(2000)*2] := (16+Random(15)) * 256 + 250;
 Ecrit(4,3,'ษออออออออป   ษอป   ษอป  ษอออออออป   ษออออออออป  ษอออออออป  ษอออออออป',63);
 Ecrit(4,4,'บXษออออปXศป  บXบ   บXบ  บXษอออปXศป  บXษออออปXบ  บXษอออออผ  ศออปXษออผ',63);
 Ecrit(4,5,'บXบ    บXXบ  บXบ   บXบ  บXบ   ศปXบ  บXบ    ศอผ  บXบ           บXบ',63);
 Ecrit(4,6,'บXศออออผXษผ  บXบ   บXบ  บXบ    บXบ  บXบ         บXศอออป       บXบ',63);
 Ecrit(4,7,'บXษออออปXศป  บXบ   บXบ  บXบ    บXบ  บXบ  ษอออป  บXษอออผ       บXบ',63);
 Ecrit(4,8,'บXบ    บXXบ  บXบ   บXบ  บXบ   ษผXบ  บXบ  ศอปXบ  บXบ           บXบ',63);
 Ecrit(4,9,'บXศออออผXษผ  บXศอออผXบ  บXศอออผXษผ  บXศออออผXบ  บXศอออออป     บXบ',63);
 Ecrit(4,10,'ศออออออออผ   ศอออออออผ  ศอออออออผ   ศออออออออผ  ศอออออออผ     ศอผ',63);
 Ecrit(4,12,'ษออออออออป  ษอออออออออออป       ษอออออออป  ษอออออออป  ษอออออออป',63);
 Ecrit(4,13,'บXษออออออผ  บXษออปXษออปXบ       ศออปXษออผ  ศออปXษออผ  ศออปXษออผ',63);
 Ecrit(4,14,'บXบ         บXบ  บXบ  บXบ          บXบ        บXบ        บXบ   ',63);
 Ecrit(4,15,'บXศออออออป  บXบ  บXบ  บXบ          บXบ        บXบ        บXบ   ',63);
 Ecrit(4,16,'ศออออออปXบ  บXบ  บXบ  บXบ          บXบ        บXบ        บXบ   ',63);
 Ecrit(4,17,'       บXบ  บXบ  บXบ  บXบ          บXบ        บXบ        บXบ   ',63);
 Ecrit(4,18,'ษออออออผXบ  บXบ  บXบ  บXบ       ษออผXศออป  ษออผXศออป  ษออผXศออป',63);
 Ecrit(4,19,'ศออออออออผ  ศอผ  ศอผ  ศอผ       ศอออออออผ  ศอออออออผ  ศอออออออผ',63);
 {Delay(1500);}
 For Compteur:=0to 31do WaitRetrace;
End;
