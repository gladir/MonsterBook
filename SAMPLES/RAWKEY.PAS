{Projet:                D‚monstrateur d'accŠs directe clavier
 Date de r‚daction:     Mercredi le 28 novembre 2001
 Nom du programmeur:    Sylvain Maltais
 Groupe:                Les Chevaliers de Malte - D‚veloppeur Pascal
 Configuration requise: Souris avec port PS/2
 Courriel:              gladir@hotmail.com
 Site INTERNET:         http://gladir.multimania.com/


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Ce programme effectue une d‚monstration de l'enfoncement des touches
 ®Ctrl+Alt+Barre d'espacement¯ simultan‚ment en acc‚dant directement par
 le contr“leur clavier sans utiliser les interruptions ou les variables
 de BIOS.
}

Program RawKeyboard;

Uses DOS;

Const
  { Code brute du clavier }
 rqkEsc=1;             { Escape}
 rqkCtrl=$1D;          { Ctrl}
 rqkAlt=$38;           { Alt}
 rqkSpaceBar=$39;      { Barre d'espacement }

Var
  {Variable de traitement clavier }
 Key:Array[0..127]of Boolean; { Tampon repr‚senter chacune des touches possibles }
 AnyPressed:Boolean;          { Indique si au moins une touche est enfonc‚e }
  {Variable de sauvegarde}
 OldInt09:Pointer;            { Sauvegarde l'adresse de l'ancienne interruption 09h }

{ Nouvelle interruption clavier … utiliser }

Procedure NewInt09;Interrupt;Assembler;ASM
 STI
 XOR CH,CH
 MOV DX,060h
 IN  AL,DX
 MOV CL,AL
 AND CL,07Fh
 MOV BX,Offset Key
 ADD BX,CX
 MOV SI,BX
 {$IFOPT G+}
  SHR AL,7
 {$ELSE}
  ROL AL,1
  AND AL,1
 {$ENDIF}
 XOR AL,1
 MOV [SI],AL
 MOV AnyPressed,AL
 MOV DX,061h
 IN  AL,DX
 MOV CL,AL
 OR  AL,080h
 OUT DX,AL
 MOV AL,CL
 OUT DX,AL
 MOV AX,020h
 MOV DX,AX
 OUT DX,AX
 CLI
END;

 { Cette proc‚dure initialise notre interruption 09h }

Procedure InitInt09;Begin
 GetIntVec($09,OldInt09);
 SetIntVec($09,@NewInt09);
 FillChar(Key,SizeOf(Key),0);
End;

{ Cette proc‚dure remet l'ancienne interruption 09h }

Procedure RestoreInt09;Begin
 SetIntVec($09,OldInt09);
End;

 { Programme principal }

BEGIN
 InitInt09;
 WriteLn('Presse ESC pour quitter...');
 Repeat
  If Key[rqkCtrl]and Key[rqkAlt]and Key[rqkSpaceBar]Then WriteLn('Ctrl+Alt+Barre d''espacement enfonc‚');
 Until Key[rqkEsc];
 RestoreInt09;
END.