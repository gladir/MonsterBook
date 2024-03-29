{Library\System\Malte\Mex.Inc}

Procedure HeaderMex;Assembler;ASM
            (******* Interface Syst�me ********)
 DD 0      { 0000h=CallDone:        Demande de fermeture de la plate-forme }
 DD 0      { 0001h=EndProgram:      Terminaison du programme }
            (******* Interface M�moire ********)
 DD 0      { 0001h=AppResSize:      Taille m�moire des ressources }
 DD 0      { 0002h=AppResFree:      M�moire libres des ressources }
 DD 0      { 0003h=MemAvail:        Taille de la m�moire disponible }
 DD 0      { 0004h=MaxAvail:        Taille de la m�moire disponible en continue }
 DD 0      { 0005h=AllocMem:        Allocation de m�moire }
 DD 0      { 0006h=MemNew:          Allocation de m�moire et initialisation du tampon }
 DD 0      { 0007h=NewBlock:        Allocation d'un bloc de m�moire }
 DD 0      { 0007h=FreeMem:         Lib�ration de m�moire }
 DD 0      { 0008h=FillChar:        Efface une zone m�moire avec un caract�res }
 DD 0      { 0009h=FillClear:       Efface une zone m�moire avec des 0 }
 DD 0      { 000Ah=MoveLeft:        D�placement d'un bloc de m�moire � partir de la gauche }
 DD 0      { 000Bh=GetIntVec:       Demande l'adresse d'une interruption }
 DD 0      { 000Ch=SetIntVec:       Fixe l'adresse d'une interruption }
            (******* Interface des cha�nes de caract�res *******)
 DD 0      { 000Dh=BackStr:         Enl�ve le dernier caract�re }
 DD 0      { 000Eh=ChgChr:          Change un caract�re dans une cha�ne de caract�res }
 DD 0      { 000Fh=Copy:            Copie une partie d'une cha�ne de caract�res }
 DD 0      { 0010h=DelStr:          Efface des caract�res dans la cha�ne de caract�res }
 DD 0      { 0011h=InsStr:          Efface des caract�res dans la cha�ne de caract�res }
 DD 0      { 0012h=Left:            Retourne les X premiers caract�res }
 DD 0      { 0013h=CStr:            Transforme un nombre � cha�ne de caract�res en fonction du pays }
 DD 0      { 0014h=CStr2:           Transforme un nombre � cha�ne de caract�res en fonction du pays }
 DD 0      { 0015h=HexByte2Str:     Transforme un octet � cha�ne de caract�res hexad�cimal }
 DD 0      { 0016h=HexWord2Str:     Transforme un mot � cha�ne de caract�re hexad�cimal }
 DD 0      { 0017h=HexLong2Str:     Transforme un double mot � cha�ne de caract�re hexad�cimal }
            (******* Interface d'Horloge ********)
 DD 0      { 0018h=GetRawTimerB:    Demande l'heure au 18,2 fois par seconde en partie octet. }
 DD 0      { 0019h=GetRawTimer:     Demande l'heure au 18,2 fois par seconde. }
 DD 0      { 001Ah=WaitRetrace:     Attente le r�affichage de l'�cran. }
            (******* Interface clavier ********)
 DD 0      { 001Bh=ClrKbd:          �limination des caract�res pr�sent dans le tampon clavier }
 DD 0      { 001Ch=KeyPress:        Touche clavier en attente? }
 DD 0      { 001Dh=ReadKey:         Lecture du clavier }
 DD 0      { 001Eh=PushKey:         Envoie du code clavier }
 DD 0      { 001Fh=AltPress:        Alt enfonc�? }
 DD 0      { 0020h=CtrlPress:       Ctrl enfonc�? }
 DD 0      { 0021h=ShiftPress:      Shift enfonc�? }
 DD 0      { 0022h=LeftShiftPress:  Shift de gauche enfonc�? }
 DD 0      { 0023h=RightShiftPress: Shift de droite enfonc�? }
 DD 0      { 0024h=GetCapsLck:      CapsLock activ�? }
 DD 0      { 0025h=GetNumLck:       NumLock activ�? }
 DD 0      { 0026h=GetScrollLck:    ScrollLock activ�? }
 DD 0      { 0027h=GetModeIns:      Mode insert actif? }
 DD 0      { 0028h=Ascii2AltCode:   Code ASCII � code Alt+Caract�re }
 DD 0      { 0029h=CtrlCode2Ascii:  Code Ctrl+Caract�re � code ASCII }
END;