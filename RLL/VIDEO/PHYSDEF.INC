{PhysDef.Inc}

Procedure PhysVideo;Assembler;ASM
 DB 0,0 {Card,Monitor:Nom de la carte vid‚o (vn????),Nom du moniteur (mn????)}
 DB 0 {CardCat:Cat‚gorie de la carte vid‚o(MDA,CGA,...)(cvn????)}
 DD 0 {Memory:Nombre de m‚moire (en octet) dont dispose la carte vid‚o}
 DB 0 {Font:Police programme support‚ par cette carte?}
 DB 0 {Hercule:Mode Hercule support‚ par cette carte?}
 DW 0 {Seg16C:Segment par d‚faut en 16 couleurs}
 DB 0 {Palette:Palette de couleur programme support‚?}
 DB 0 {Color:Carte de type couleur? autrement monochrome}
 DB 0 {BBlink:Le Bios supporte le mode clignotement/intensit‚?}
 DB 0 {EGA:La carte est post‚rieur ou ‚gale … l'EGA}
 DB 0 {VGA:La carte est post‚rieur ou ‚gale … la VGA}
 DB 0 {VGA320x400:Le mode VGA 320x400 est support‚ (pas toujours le cas chez les clones)}
 DB 0 {VESA:Le standard VESA support‚? }
 DW 0 {ROM:Adresse de la ROM Bios}
 DB 0 {MousePort:Port souris inclue … la carte vid‚o?}
 DB 0 {VideoBits:Nombre d'accŠs bits au entr‚e/sortie vid‚o}
 DB 0 {ROMBits:Nombre d'accŠs bits … la ROM Bios}
 DB 0 {DACBits:Nombre de bits utilis‚ pour modifi‚ un des 3 DAC RGB}
 DB 0 {PVC:Horloge vid‚o programme?}
 DW 0 {ProcSelBnkPg:Adresse d'index de la proc‚dure de changement de page de la banque}
 DW 0 {ProcSetVideoMode:Adresse d'index de la proc‚dure de changement de mode vid‚o}
END;