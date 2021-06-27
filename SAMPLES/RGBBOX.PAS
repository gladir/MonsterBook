{Projet:                Afficher une boŒte de couleur RVB en 3D
 Date de r‚daction:     Jeudi le 7 juin 2001
 Nom du programmeur:    Sylvain Maltais
 Configuration requise: VESA + mode 640x480x65536
 Courriel:              gladir@hotmail.com
 Site de distribution:  http://gladir.tripod.com/
                        http://gladir.multimania.com/


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Ce programme permet d'afficher un cube en 3 dimensions de couleur
 RVB (Rouge, Vert et Bleu). Chacun des axes correspond … ceci:

  X = Rouge
  Y = Vert
  Z = Bleu


 Remarque
 ÍÍÍÍÍÍÍÍ

  þ Ce d‚monstrateur fonctionne correctement seulement en mode vid‚o
    640 x 480 en 65536 couleurs de la plupart des cartes ®Super VGA¯
    supportant se mode et naturellement le standard ®VESA¯.
}

Program SampleRGBCube;

Const
 CenterHorizontal=640 shr 1;
 CenterVertical=480 shr 1;
 White=$FFFF;

{ Cette routine n'est pas trŠs efficace mais permet de changer les pages
 d'affichage correspondant au standard VESA.
}

Procedure SetBankPage(Page:Word);Assembler;ASM
 MOV AX,04F05h
 XOR BX,BX
 MOV DX,Page
 PUSH DX
  INT 010h
 POP DX
 MOV AX,04F05h
 MOV BX,1
 INT 010h
END;

{ Cette proc‚dure permet d'afficher un pixel au coordonn‚es (X,Y) avec
 la couleur ®Color¯.
}

Procedure SetPixel(X,Y,Color:Word);Assembler;ASM
 TEST X,8000h
 JNZ @End
 SHL X,1
 MOV AX,640 shl 1
 MUL Y
 XCHG AX,DI
 ADD DI,X
 PUSH DI
  ADC DX,0
  PUSH DX
  CALL SetBankPage
 POP DI
 MOV AX,0A000h
 MOV ES,AX
 MOV AX,Color
 STOSW
@End:
END;

{ Cette proc‚dure permet l'affichage d'un point selon une coordonn‚e
 en 3 dimensions partant du centre de l'‚cran.
}

Procedure SetPixel3D(X,Y,Z:Integer;Color:Word);Begin
 SetPixel(CenterHorizontal+X-(Z shr 1),CenterVertical-Y+(Z shr 1),Color);
End;

{ Cette fonction retourne la couleur encod‚ RVB d'un mode d'affichage
 en 65536 couleurs.
}

Function RGB2Color(R,G,B:Byte):Word;Assembler;ASM
 MOV AH,R
 AND AH,0F8h
 MOV AL,B
 {$IFOPT G+}
  SHR AL,3
 {$ELSE}
  SHR AL,1
  SHR AL,1
  SHR AL,1
 {$ENDIF}
 MOV BL,G
 AND BX,00F8h
 {$IFOPT G+}
  SHR BX,3
 {$ELSE}
  SHL BX,1
  SHL BX,1
  SHL BX,1
 {$ENDIF}
 ADD AX,BX
END;

Var I,J,K:Byte; { Compteur de boucle }

BEGIN
  { Permet de change de mode vid‚o }
 ASM
  MOV AX,04F02h
  MOV BX,00111h { Mode 640x480 en 65536 couleurs }
  INT 010h
 END;
  { Trace des lignes de bordures de couleur blanche }
 For I:=0to 149do Begin
  SetPixel3D(0,0,I,White);
  SetPixel3D(0,I,0,White);
  SetPixel3D(I,0,0,White);
 End;
{ Si vous souhaitez afficher tous les Pixels un par un:
   For K:=0to 99do For I:=0to 99do For J:=0to 99do Begin
    SetPixel3D(I,J,K,RGB2Color(I,J,K));
   End;
 }
  { Trace les 3 faces du cube de couleurs }
 For J:=99downto 0do For I:=0to 99do SetPixel3D(I,J,99,RGB2Color(I,J,99));
 For K:=0to 99    do For I:=0to 99do SetPixel3D(I,99,K,RGB2Color(I,99,K));
 For J:=99downto 0do For K:=0to 99do SetPixel3D(99,J,K,RGB2Color(99,J,K));
  { Attend que l'utilisateur enfonce une touche }
 ASM
  XOR AX,AX
  INT 16h
 END;
END.