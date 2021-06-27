{\Source\Chantal\Library\System\AppleII\DefsEmul.Inc}

{Nom des programmeurs
 ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ

  Randy W. Spurlock (30 janvier 1988)
  Sylvain Maltais


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fichier contient les constantes utilis‚s par l'APPLE ][ avec micro-
 processeur 65C02 pour la d‚finition de ‚mulateur potentiel pour celui-ci.
}

Const
 CgaSegment=$B800; { Segment de la RAM vid‚o de la CGA}
 EgaSegment=$A000; { Segment de la RAM vid‚o de l'EGA}
 Bios=$0040;	   { Segment de donn‚e du BIOS}

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
{	       D‚finition des ‚quations n‚cessaire au BIOS                  }
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
 Video=$10;	   { Num‚ro de l'interruption BIOS video interrupt number}
 SetMode=$00;	   { Code de fonction du changement de mode Vid‚o}
 CursorType=$01;   { Code de fonction fixant le type curseur vid‚o}
 WriteCursor=$02;  { Code de fonction fixant la position du curseur vid‚o}
 ReadCursor=$03;   { Code de fonction demandant la d‚finition du curseur vid‚o}
 SetPalette=$10;   { Code de fonction fixant la palette vid‚o}
 SetAll=$02;	   { Sous-fonction de tout routine}
 ProgramBlink=$03; { Sous-fonction de la routine de clignotement}
 Intensity=$00;    { Valeur d‚sactivant le clignotement (Intensit‚)}
 Blink=$01;	   { Valeur activant le clignotement (Clignotement)}
 AltSelect=$12;	   { Code de fonction des s‚lections alternative}
 EgaInfo=$10;	   { Sous-fonction retourne les information EGA}
 Keyboard=$16;	   { Num‚ro de l'interruption BIOS clavier}
 CheckKey=$01;	   { Code de fonction v‚rifiant l'‚tat des touches claviers}
 ShiftStatus=$02;  { Sous-fonction demandant l'‚tat du ®Shift¯}

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
{	D‚finition de le DOS … de besoin                                    }
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
 Dos=$21;	    { Num‚ro de l'interruption DOS }
 SetDta=$1A;	    { Code de fonction fixant la DTA }
 SetVector=$25;	    { Code de fonction fixant un vecteur d'interruption}
 GetVector=$35;	    { Code de fonction demandant un vecteur d'interruption}
 OpenFile=$3D;	    { Code de fonction ouvrant un fichier}
 ReadOnly=$00;	    { Code d'accŠs de lecture seulement}
 WriteOnly=$01;	    { Code d'accŠs d'‚criture seulement}
 ReadWrite=$02;	    { Code d'accŠs de lecture/‚criture}
 CloseFile=$3E;	    { Code de fonction fermant un fichier}
 ReadFile=$3F;	    { Code de fonction lisant dans un fichier}
 WriteFile=$40;	    { Code de fonction ‚crivant dans un fichier}
 SeekFile=$42;	    { Code de fonction positionnant le pointeur de fichier}
 Absolute=$00;	    { Code de positionnement absolue}
 Relative=$01;	    { Code de positionnement relatif}
 AllocateMemory=$48;{ Code de fonction d'allocation de m‚moire}
 FreeMemory=$49;    { Code de fonction lib‚rant de la m‚moire}
 Terminate=$4C;	    { Code de fonction terminant un programme}
 FindFirst=$4E;	    { Code de fonction trouvant le premier fichier d'un r‚pertoire}
 FindNext=$4F;	    { Code de fonction trouvant le fichier suivant d'un r‚pertoire}

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
{	D‚finition des fichiers Handle standard du DOS                      }
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
 StdInput=$00;     { Handle d'entr‚e standard}
 StdOutput=$01;	   { Handle de sortie standard}
 StdError=$02;	   { Handle d'erreur standard}
 StdAux=$03;	   { Handle d'auxiliaire standard}
 StdPrint=$04;	   { Handle d'impression standard}