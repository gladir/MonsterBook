{Library\System\Malte\Mex.Inc}

Procedure HeaderMex;Assembler;ASM
            (******* Interface Systäme ********)
 DD 0      { 0000h=CallDone:        Demande de fermeture de la plate-forme }
 DD 0      { 0001h=EndProgram:      Terminaison du programme }
            (******* Interface MÇmoire ********)
 DD 0      { 0001h=AppResSize:      Taille mÇmoire des ressources }
 DD 0      { 0002h=AppResFree:      MÇmoire libres des ressources }
 DD 0      { 0003h=MemAvail:        Taille de la mÇmoire disponible }
 DD 0      { 0004h=MaxAvail:        Taille de la mÇmoire disponible en continue }
 DD 0      { 0005h=AllocMem:        Allocation de mÇmoire }
 DD 0      { 0006h=MemNew:          Allocation de mÇmoire et initialisation du tampon }
 DD 0      { 0007h=NewBlock:        Allocation d'un bloc de mÇmoire }
 DD 0      { 0007h=FreeMem:         LibÇration de mÇmoire }
 DD 0      { 0008h=FillChar:        Efface une zone mÇmoire avec un caractäres }
 DD 0      { 0009h=FillClear:       Efface une zone mÇmoire avec des 0 }
 DD 0      { 000Ah=MoveLeft:        DÇplacement d'un bloc de mÇmoire Ö partir de la gauche }
 DD 0      { 000Bh=GetIntVec:       Demande l'adresse d'une interruption }
 DD 0      { 000Ch=SetIntVec:       Fixe l'adresse d'une interruption }
            (******* Interface des chaånes de caractäres *******)
 DD 0      { 000Dh=BackStr:         Enläve le dernier caractäre }
 DD 0      { 000Eh=ChgChr:          Change un caractäre dans une chaåne de caractäres }
 DD 0      { 000Fh=Copy:            Copie une partie d'une chaåne de caractäres }
 DD 0      { 0010h=DelStr:          Efface des caractäres dans la chaåne de caractäres }
 DD 0      { 0011h=InsStr:          Efface des caractäres dans la chaåne de caractäres }
 DD 0      { 0012h=Left:            Retourne les X premiers caractäres }
 DD 0      { 0013h=CStr:            Transforme un nombre Ö chaåne de caractäres en fonction du pays }
 DD 0      { 0014h=CStr2:           Transforme un nombre Ö chaåne de caractäres en fonction du pays }
 DD 0      { 0015h=HexByte2Str:     Transforme un octet Ö chaåne de caractäres hexadÇcimal }
 DD 0      { 0016h=HexWord2Str:     Transforme un mot Ö chaåne de caractäre hexadÇcimal }
 DD 0      { 0017h=HexLong2Str:     Transforme un double mot Ö chaåne de caractäre hexadÇcimal }
            (******* Interface d'Horloge ********)
 DD 0      { 0018h=GetRawTimerB:    Demande l'heure au 18,2 fois par seconde en partie octet. }
 DD 0      { 0019h=GetRawTimer:     Demande l'heure au 18,2 fois par seconde. }
 DD 0      { 001Ah=WaitRetrace:     Attente le rÇaffichage de l'Çcran. }
            (******* Interface clavier ********)
 DD 0      { 001Bh=ClrKbd:          êlimination des caractäres prÇsent dans le tampon clavier }
 DD 0      { 001Ch=KeyPress:        Touche clavier en attente? }
 DD 0      { 001Dh=ReadKey:         Lecture du clavier }
 DD 0      { 001Eh=PushKey:         Envoie du code clavier }
 DD 0      { 001Fh=AltPress:        Alt enfoncÇ? }
 DD 0      { 0020h=CtrlPress:       Ctrl enfoncÇ? }
 DD 0      { 0021h=ShiftPress:      Shift enfoncÇ? }
 DD 0      { 0022h=LeftShiftPress:  Shift de gauche enfoncÇ? }
 DD 0      { 0023h=RightShiftPress: Shift de droite enfoncÇ? }
 DD 0      { 0024h=GetCapsLck:      CapsLock activÇ? }
 DD 0      { 0025h=GetNumLck:       NumLock activÇ? }
 DD 0      { 0026h=GetScrollLck:    ScrollLock activÇ? }
 DD 0      { 0027h=GetModeIns:      Mode insert actif? }
 DD 0      { 0028h=Ascii2AltCode:   Code ASCII Ö code Alt+Caractäre }
 DD 0      { 0029h=CtrlCode2Ascii:  Code Ctrl+Caractäre Ö code ASCII }
END;