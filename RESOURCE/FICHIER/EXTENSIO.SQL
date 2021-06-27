CREATE TABLE ExtensiorEnteteFichier (
   ID          WORD, /* cfo???? */
   SubType     WORD,
   Position    BYTE,
   Entete      VARCHAR
);

CREATE INDEX;

INSERT INTO ExtensiorEnteteFichier VALUES (0x0001,0x4000,0,#$00#$00#$01#$00);               /* Icone Windows */
INSERT INTO ExtensiorEnteteFichier VALUES (0x0035,0x0800,0,#$00#$00#$02#$00#06#04);         /* Lotus 1-2-3 */
INSERT INTO ExtensiorEnteteFichier VALUES (0x000B,0x4000,0,#$00#$01);                       /* Gem/Img Ventura */
INSERT INTO ExtensiorEnteteFichier VALUES (0x001E,0x4000,0,#$00#$09#$00#$09);               /* MonsterBookFont */
INSERT INTO ExtensiorEnteteFichier VALUES (0x003E,0x0100,0,#$03);                           /* DBase III */
INSERT INTO ExtensiorEnteteFichier VALUES (0xF001,0x4000,0,#$04#$03#$4B#$50);               /* ZIP */
INSERT INTO ExtensiorEnteteFichier VALUES (0x000E,0x0010,0,#$10);                           /* Dessin PCX */
INSERT INTO ExtensiorEnteteFichier VALUES (0x001C,0x001E,0,'#def');                         /* Dessin XBM */
INSERT INTO ExtensiorEnteteFichier VALUES (0x0045,0x0001,0,'(*');                           /* Code Source Pascal */
INSERT INTO ExtensiorEnteteFichier VALUES (0x003D,0x0008,0,': ');                           /* Document GAT */
INSERT INTO ExtensiorEnteteFichier VALUES (0x003D,0x0008,0,'; ');                           /* Document GAT encrypt‚ */
INSERT INTO ExtensiorEnteteFichier VALUES (0x002D,0x0008,0,'<HTML>');                       /* HTML */
INSERT INTO ExtensiorEnteteFichier VALUES (0x0016,0x0010,0,'BGX1');                         /* Bitmap Genesis */
INSERT INTO ExtensiorEnteteFichier VALUES (0x0002,0x0010,0,'CI');                           /* Icone OS/2 */
INSERT INTO ExtensiorEnteteFichier VALUES (0x0007,0x0010,0,'CP');                           /* Pointeur OS/2 */
INSERT INTO ExtensiorEnteteFichier VALUES (0xE001,0x0100,0,'Extensior - Base de donn‚e'#$1A);/* Extensior */
INSERT INTO ExtensiorEnteteFichier VALUES (0x000F,0x0010,0,'FORM');                         /* Dessin LBM/BBM */
INSERT INTO ExtensiorEnteteFichier VALUES (0x0045,0x0001,0,'FUNCTION');                     /* Pascal */
INSERT INTO ExtensiorEnteteFichier VALUES (0x0012,0x0010,0,'GIF');                          /* Dessin GIF */
INSERT INTO ExtensiorEnteteFichier VALUES (0x0015,0x0010,0,'GPX'#$1A);                      /* Dessin GPX */
INSERT INTO ExtensiorEnteteFichier VALUES (0x0004,0x0010,0,'ICONEADEL');                    /* Icone Adele */
INSERT INTO ExtensiorEnteteFichier VALUES (0x0011,0x2000,0,'II');                           /* TIFF */
INSERT INTO ExtensiorEnteteFichier VALUES (0x0021,0x2000,0,'IMI');                          /* Dessin technique */
INSERT INTO ExtensiorEnteteFichier VALUES (0x0032,0x0800,0,'MGC'#$1A);                      /* Tableur ®Malte Genesis Calc¯ */
INSERT INTO ExtensiorEnteteFichier VALUES (0x0011,0x2000,0,'MM');                           /* TIFF */
INSERT INTO ExtensiorEnteteFichier VALUES (0xF000,0x4000,0,'MSCF');                         /* Cab(inet Compress‚) */
INSERT INTO ExtensiorEnteteFichier VALUES (0xC000,0x8000,0,'MZ');                           /* Ex‚cutable */
INSERT INTO ExtensiorEnteteFichier VALUES (0x000D,0x0010,0,'P5');                           /* Dessin PPM/PGM */
INSERT INTO ExtensiorEnteteFichier VALUES (0x000D,0x0010,0,'P6');                           /* Dessin PPM/PGM */
INSERT INTO ExtensiorEnteteFichier VALUES (0x0045,0x0001,0,'PROCEDURE');                    /* Pascal */
INSERT INTO ExtensiorEnteteFichier VALUES (0x0045,0x0001,0,'PROGRAM');                      /* Pascal */
INSERT INTO ExtensiorEnteteFichier VALUES (0x0027,0x0080,0,'QQF');                          /* Police de caracteres QQF */
INSERT INTO ExtensiorEnteteFichier VALUES (0xF006,0x4000,0,#$52#$61#$72#$21#$1A#$07#$00);   /* Fichier compress‚ RAR */
INSERT INTO ExtensiorEnteteFichier VALUES (0x0045,0x0001,0,'UNIT');                         /* Pascal */
INSERT INTO ExtensiorEnteteFichier VALUES (0xE000,0x0008,0,'XOKYREG'#$1A);                  /* Base de registre ®Xoky¯ */
INSERT INTO ExtensiorEnteteFichier VALUES (0xF002,0x4000,0,'ZOO');                          /* Fichier compress‚ ZOO */
INSERT INTO ExtensiorEnteteFichier VALUES (0xF005,0x4000,0,'lh'#0);                         /* Fichier compress‚ LZH */
INSERT INTO ExtensiorEnteteFichier VALUES (0xF004,0x4001,0,'sw'#0);                         /* Fichier compress‚ Swag */
INSERT INTO ExtensiorEnteteFichier VALUES (0xF000,0x0008,0,'{\rtf');                        /* Document RTF */
INSERT INTO ExtensiorEnteteFichier VALUES (0xF003,0x4000,0,#$60#$EA);                       /* ARJ */
INSERT INTO ExtensiorEnteteFichier VALUES (0x0039,0x0008,0,#$BE#$31);                       /* Document Word */
INSERT INTO ExtensiorEnteteFichier VALUES (0x0039,0x0008,0,#$BE#$32);                       /* Document Word */
INSERT INTO ExtensiorEnteteFichier VALUES (0xBE00,0x0200,0,#$C7#$45#$CF#$53);               /* GeoWorks */
INSERT INTO ExtensiorEnteteFichier VALUES (0xBE00,0x0200,0,#$C7#$45#$C1#$53);               /* GeoWorks */
INSERT INTO ExtensiorEnteteFichier VALUES (0x0039,0x0008,0,#$CF#$D0);                       /* Document Word */
INSERT INTO ExtensiorEnteteFichier VALUES (0x001D,0x2000,0,#$FF'WPC'#$16);                  /* WordPerfect Graphics */
/*INSERT INTO ExtensiorEnteteFichier VALUES (0xF000,0x000E,6,'GERBILDOC   ');                 /* Document Premier Choix */


