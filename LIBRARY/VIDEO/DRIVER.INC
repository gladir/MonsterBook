{Driver.Inc}

{$IFNDEF __Driver}
 {$DEFINE __Driver}

Const
  { Constante des num‚ros de pilote de la bibliothŠque Chantal }
 dvSetMode             = 0;       {Pilote permet de changer de mode vid‚o}
 dvModeSupport         = 1;       {Proc‚dure retournant les modes vid‚o supporter}
 drvBios               = 2;       {Pilote utilisant le Bios}
 drvTxt                = 3;       {Pilote sp‚cialis‚ pour les ‚crans de texte}
 drv2                  = 6;       {Pilote sp‚cialis‚ pour les ‚crans graphiques en 2 couleurs: CGA, EGA, VGA,...}
 drvGS640              = 9;       {Pilote sp‚cialis‚ pour l'‚cran 640x200 en 16 couleurs de la Super CGA d'ATI }
 drv16                 = 12;      {Pilote sp‚cialis‚ pour les ‚crans 16 couleurs des (S)EGA, (S)VGA }
 drv19                 = 15;      {Pilote sp‚cialis‚ exlusivement pour le mode 320x200 en 256 couleurs (S)VGA }
 drvSVGA               = 18;      {Pilote sp‚cialis‚ pour les modes 256 couleurs des Super VGA }
 drv320x400c256        = 21;      {Pilote sp‚cialis‚ exclusivement pour le mode 320x400 en 256 couleurs (S)VGA }
 drvVESA               = 24;      {Pilote VESA pour les modes 256 couleurs}
 drv360x480c256        = 27;      {Pilote sp‚cialis‚ exclusivement pour le mode 360x480 en 256 couleurs (S)VGA }
 drv320x200c4          = 30;      {Pilote sp‚cialis‚ exclusivement pour le mode 320x200 en 4 couleurs CGA,...}
 drvVGA256             = 33;      {Mode Super VGA avec m‚thode VGA}
 drvSVGA65536          = 36;      {Pilote de mode Super VGA en 65 536 couleurs }
 NmDrv                 = 39;      {Nombre de pilote Video}
 drvHerc               = drvBios;
 drvSVGAWord           = drvBios;

{$ENDIF}