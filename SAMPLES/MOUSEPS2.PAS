{Projet:                D‚monstrateur de souris PS/2
 Date de r‚daction:     Lundi le 11 juin 2001
 Nom du programmeur:    Sylvain Maltais
 Groupe:                Les Chevaliers de Malte - D‚veloppeur Pascal
 Configuration requise: Souris avec port PS/2
 Courriel:              gladir@hotmail.com
 Site de distribution:  http://gladir.multimania.com/


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette programme est un d‚monstrateur de l'utilisation d'une souris
 utilisant le port PS/2 sans utilis‚ de pilote d'INTERRUPTION 33h. Ce
 programme d‚place le pointeur de souris tant et aussi longtemps que
 l'utilisateur n'a pas enfonc‚ un bouton de la souris.


 Remarque
 ÍÍÍÍÍÍÍÍ

  þ On doit toujours lanc‚e se programme dans un ‚cran de texte!
}

Program MousePS2;

Const
  { Les masques d'‚venements de la souris }
 meMsMove=1;                 { D‚placement de la souris }
 meLeftButPressed=2;         { Le bouton de gauche enfonc‚ }
 meLeftButReleased=4;        { Le bouton de gauche relƒch‚ }
 meRightButPressed=8;        { Le bouton de droite enfonc‚ }
 meRightButReleased=16;      { Le bouton de droite relƒch‚ }
 meMiddleButPressed=32;      { Le bouton du centre enfonc‚ }
 meMiddleButReleased=64;     { Le bouton du centre enfonc‚ }
 meAll=$7F;                  { Tous changements de la part de la souris (D‚placement, Bouton,...) }

Var
 MouseTextX,MouseTextY:Byte; { Coordonn‚e actuel du pointeur de souris }
 Button:Word;                { Position des boutons de souris }

{ Cette routine permet d'installer la routine devant s'ex‚cuter …
 chaque d‚placement de la souris.
}

Function InstallPS2(Routine:Pointer):Boolean;Assembler;ASM
 MOV CX,2
@Try2:
 LES BX,Routine
 MOV AX,0C207h
 INT 15h
 JNC @PSokyet
 CMP AH,4
 JNE @noPS2det
 LOOP @Try2
 JMP @noPS2det
@PSokyet:
 MOV BH,3
 MOV AX,0C203h
 INT 15h
 JC  @NoPS2det        { Fixe la r‚solution Souris BH}
 MOV BH,1
 MOV AX,0C200h
 INT 15h
 JC  @NoPS2det        { Active la souris}
 XOR DL,DL
 XOR BH,BH
 MOV AX,0C206h
 INT 15h
 MOV AL,True
 JMP @End
@NoPS2det:
 MOV AL,False
@End:
END;

{ Cette routine est lanc‚e par notre ®Handler¯ ‚crit en assembleur
 ®PS2Hand¯, ormis la directive ®NEAR¯, vous pouvez modifier sans
 danger le contenu de celui-ci. Mˆme vous pourriez afficher directement
 un pointeur de souris … partir de cette routine comme le font les pilotes
 souris toutefois si vous pouvez l'‚vitez, comme dans cette exemple, je
 vous le d‚conseil parce que la machine doit n‚cessairement est plus
 rapide pour une programmation de se style.
}

Procedure MouEventHandler(EvFlags,ButState,X,Y:Integer);Near;Begin
 If X<0Then X:=0;
 If Y<0Then Y:=0;
 If(EvFlags and meMsMove=meMsMove)Then Begin
  ASM
    {X:=X shr 3;}
    {Y:=Y shr 4;}
   MOV CL,3
   SHR X,CL
   INC CX
   SHR Y,CL
  END;
  MouseTextX:=X;
  MouseTextY:=Y;
 End;
 Button:=ButState;                   { DerniŠre ‚tat des boutons de la souris }
End;

{Variable sur le Code Segment:}
Procedure Actif;Assembler;ASM
 DB 0 { Indique si un appel est actuellement en cours d'ex‚cution}
END;

{ Etat des boutons souris }

Procedure ButtonFlags;Assembler;ASM
 DW 0
END;

{ Position horizontal actuel de la souris en pixel }

Procedure XMov;Assembler;ASM
 DW 0
END;

{ Position vertical actuel de la souris en pixel }

Procedure YMov;Assembler;ASM
 DW 0
END;

{ Variable dans le segment de code contenant l'adresse du segment de donn‚e }

Procedure AdresseData;Assembler;ASM
 DD MouseTextX {Indique l'adresse du Segment de donn‚e }
END;

{ Cette routine est ex‚cut‚e … chaque d‚placement de la souris, on
 comprendra qu'il est indispensable de pr‚serv‚ chacun des registres
 et cela en utilisant le code segment pour ‚viter des conflits.
}

Procedure PS2Hand;Far;Assembler;ASM
 CLD
 CMP Byte Ptr Actif,0  { Appel non encore termin‚ ? }
 JNE @Fin              { Non --> ne pas permettre l'appel }
 MOV Byte Ptr Actif,1  { Ne plus autoriser d'appels }
 PUSH BP
  MOV BP,SP
  PUSH AX
   PUSH BX
    PUSH CX
     PUSH DX
      PUSH DS
       PUSH ES
        PUSH DI
         PUSH SI
          PUSH CS
           PUSH CS
           POP DS
          POP ES
          MOV AX,[BP+0Ch]
          TEST AH,AH
          JNZ @InvPS2Data
          AND AL,3
          MOV Byte Ptr ButtonFlags,AL
          MOV AX,[BP+0Ch]
          MOV BX,[BP+0Ah]
          MOV CX,[BP+8]
          TEST AL,10h
          JZ  @PSxNeg
          MOV BH,0FFh
@PSxNeg:  TEST CX,CX
          JZ  @NoYMov
          NEG CL
          TEST AL,20h
          JNZ @NoYMov
          MOV CH,0FFh
@NoYMov:  ADD Word Ptr YMov,CX
          ADD Word Ptr XMov,BX
          MOV AX,meMsMove
          PUSH AX
          PUSH Word Ptr ButtonFlags
          PUSH Word Ptr XMov
          PUSH Word Ptr YMov
          MOV DS,Word Ptr AdresseData[2]
          CALL MouEventHandler
@InvPS2Data:
         POP SI
        POP DI
       POP ES
      POP DS
     POP DX
    POP CX
   POP BX
  POP AX
 POP BP
 MOV Byte Ptr Actif,0 { Appel … nouveau autoris‚ }
@Fin:
END;

{ Cette proc‚dure trŠs rudimentaire permet de changer un attribut de
 couleur … un endroit pr‚cis de l'‚cran.
}

Procedure SetAttr(X,Y,Attr:Byte);Var Segment:Word;Begin
 If MemW[Seg0040:$63]=$3D4Then Segment:=$B800
                          Else Segment:=$B000;
 Mem[Segment:((X+(Y*MemW[Seg0040:$4A]))shl 1)+1]:=Attr;
End;

{ Cette fonction trŠs rudimentaire permet de connaŒtre un attribut de
 couleur … un endroit pr‚cis de l'‚cran.
}

Function GetAttr(X,Y:Byte):Byte;Var Segment:Word;Begin
 If MemW[Seg0040:$63]=$3D4Then Segment:=$B800
                          Else Segment:=$B000;
 GetAttr:=Mem[Segment:((X+(Y*MemW[Seg0040:$4A]))shl 1)+1];
End;

Var
 OldAttr:Byte;     { Couleur de l'ancienne attribut }
 OldX,OldY:Byte;   { Ancienne position du pointeur de souris }
 CurrX,CurrY:Byte; { Position actuel du pointeur souris }

BEGIN
 If Not InstallPS2(@PS2Hand)Then Begin
  WriteLn('Une souris avec port PS/2 est requise pour ce programme!');
 End
  Else
 Begin
  WriteLn('Presse un bouton de la souris pour quitter!');
  OldX:=$FF;OldY:=$FF;
  Repeat
   CurrX:=MouseTextX;CurrY:=MouseTextY; { Copie la position actuel du pointeur souris }
   If(OldX<>CurrX)or(OldY<>CurrY)Then Begin
     { Restauration d'affichage du pointeur de souris }
    SetAttr(OldX,OldY,OldAttr);
     { Pr‚servation de l'emplacement affect‚ }
    OldAttr:=GetAttr(MouseTextX,MouseTextY);
     { Affiche le pointeur souris }
    SetAttr(CurrX,CurrY,Not OldAttr);
     { Pr‚serve les coordonn‚es o— a ‚t‚ afficher le pointeur souris }
    OldX:=CurrX;OldY:=CurrY;
   End;
  Until Button<>0;
   { Restauration d'affichage du pointeur de souris }
  SetAttr(OldX,OldY,OldAttr);
   { Attendre que l'utilisateur lache le bouton de souris }
  Repeat Until Button=0;
  InstallPS2(NIL);
 End;
END.