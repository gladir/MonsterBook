unit variab;

interface

TYPE
  pt=record ofs,sgm:word;end;

  Effect_Type = record
     p : pointer;
     l : longint;
     sr : word;
   end;

  Param_Table = record
    mult  : word;
    Speed : word;
    bgr   : word;
    Ab    : integer;
   end;
TYPE vocheader = record
       ident      : array[0..19] of char;
       Sampoff    : word;
       Verslo     : Byte;
       Vershi     : Byte;
       ident_code : word;
     end;

     Voiceblock = record
       ident_code : byte;
       Long_lo   : word;
       Long_hi   : byte;
       SR         : byte;
       Pack       : byte;
     end;



CONST bloc_actif : byte = 1;
  Incfacts : array[1..99] of longint =
    ( $0021E7,$0023EB,$00260E,$002851,$002AB7,$002D41,$002FF2,$0032CC,
      $0035D1,$003904,$003C68,$004000,$0043CE,$0047D6,$004C1C,$0050A2,
      $00556E,$005A82,$005FE4,$006598,$006BA2,$007209,$0078D0,$007FFF,
      $00879C,$008FAC,$009837,$00A144,$00AADB,$00B504,$00BFC8,$00CB2F,
      $00D744,$00E411,$00F1A1,$00FFFF,$010F39,$011F5A,$013070,$01428A,
      $0155B8,$016A09,$017F91,$01965F,$01AE89,$01C823,$01E343,$01FFFF,
      $021E72,$023EB3,$0260DF,$028514,$02AB6F,$02D413,$02FF21,$032CC0,
      $035D14,$039047,$03C686,$03FFFF,$043CE4,$047D66,$04C1BF,$050A29,
      $0556E0,$05A827,$05FE43,$06597F,$06BA27,$07208F,$078D0D,$07FFFF,
      $0879C7,$08FACC,$09837E,$0A1451,$0AADC0,$0B504F,$0BFC87,$0CB2FF,
      $0D744F,$0E411F,$0F1A1C,$0FFFFF,$10F38F,$11F59A,$1306FE,$1428A3,
      $155B81,$16A09E,$17F910,$1965FE,$1AE89F,$1C823D,$1E3438,$1FFFFF,
      $21E71E, $23EB35,$260DFC
    );

  outfading : boolean = false;
  outvolume : byte = 63;
  msp : longint = 0;
  TailleFiMod : longint = 0;
  filtre_actif : boolean = false;
  balance : byte = 12;
  Mastervolume : byte = 7{29};
  Startport : word = $200;
  Endport   : word = $280;
  playspeed : byte = 6;

  DETECT = 55555;
  Samfreq : word = 22;
  force_mono : boolean = false;
  force_sb : boolean = false;
  force_irq : boolean = false;
  force_dma : boolean = false;
  force_base : boolean = false;
  PC    = 0;
  AMIGA = 1;
  m669 : boolean = false;
  interrupt_trouve : boolean = false;
  interrupt_check : boolean = false;
  Choose_lower_freq : boolean = false;
  timer_per_second  : word = 50;      { Nb d'appels du Timer par Sec. }
  Sampling_Frequence : word = 10000;  { Valeur de Sampling par d‚fault}
  in_retrace        : boolean = false;
  dsp_irq        : byte = $5;           { num‚ro d'interruption de SB}
  dma_ch            : byte = 1;         { Num‚ro du canal DMA utilis‚}
                                        { = 1, sinon modifier cette  }
                                        { variable                   }
  dsp_adr           : word = $220;      { adresse de base de la carte}
                                        { Sound-Blaster              }
  SbVersMin         : BYTE = 0;         { Num‚ro de Version secondaire }
  SbVersMaj         : BYTE = 0;         { Num‚ro de Version principal }
  STEREO            : BOOLEAN = false;
  SbRegDetected     : BOOLEAN = FALSE;  { D‚tection d'une carte SB ?    }
  IRQDetected       : BOOLEAN = FALSE;
  SbRegInited       : BOOLEAN = FALSE;
  SbProDetected     : BOOLEAN = FALSE;  { D‚tection d'une carte SB Pro  ? }
  SbProInited       : BOOLEAN = FALSE;
  Sb16Detected      : BOOLEAN = FALSE;  { D‚tection d'une carte SB 16 ASP  ? }
  Sb16Inited        : BOOLEAN = FALSE;
  MixerDetected     : BOOLEAN = FALSE;
  OldTimerInt                 = $71;

  voix              : integer = 4;      { Nombre de voix dans le     }
                                        { fichier MOD (4 ou 8)       }
  Modoctave : array[1..70] of word =
   (
    1712,1616,1525,1440,1359,1283,1211, { Ce tableau correspond aux sons }
    1143,1078,961,907,856,808,763,720,  { contenu dans le fichier MOD    }
    679,641,605,571,539,509,480,453,428,
    404,381,360,340,321,303,286,270,254,
    240,227,214,202,191,180,170,160,151,
    143,135, 127,120,113,107,101,95,90,
    85,80,76,71,67,64,60,57,
    54,51,48,45,43,40,38,36,34,32,30);

 AUTO = 9999;                           {  Auto detection }
 ON   = true;
 OFF  = false;
 playeffect : boolean = false;
 effectvolume : word = 7;
 converteff    : byte = 0;

 dma_page : array[0..3] of byte = ($87,$83,$81,$81);
 dma_adr  : array[0..3] of byte = (0,2,4,6);
 dma_wc   : array[0..3] of byte = (1,3,5,7);

 sb16_outputlong : word = 0;
 dern_sortie : boolean = false;

VAR
 Oldintcompteur : word;
 efi : file;
 outfile : file;
 Taillebloc          : word;
 dsp_rdy_sb16        : boolean;         { prend la valeur TRUE quand le transfert }
                                        { de donn‚es via DMA est fini   }
 SbVersStr           : string[5];
 Speed               : word;
 oldInt              : pointer;         { adresse d'interruption du timer }
 irqmsq              : byte;            { masque ou d‚masque l'interupt SB }
 mixer_proc          : pointer;         { pointeur sur proc‚dure }
 nmw_proc            : pointer;         { pointeur sur proc‚dure }
 proc_intra          : pointer;         { pointeur sur proc‚dure }
 Frappe_Notes        : array[1..8]      { permet le contr“le d'un equalizer }
                       of integer;
 Rm_Song             : Array[1..64,1..8,1..4] of Byte;
 rm                  : array[0..128]    { permet de g‚rer les patterns }
                       of pointer;
 Chanson             : array[1..128]    { Arrangement des chansons   }
                       of byte;
 blk                 : pointer;
 inst        : array[1..8] of pointer;
 Samp                : Array[1..64]     { Tableau de pointeurs sur les }
                       of pointer;      { diff‚rents samples         }
 Sam_l               : Array[1..64]     { longueur des samples       }
                       of word;
 loop_s              : array[1..64]     { position de d‚part des Looping }
                       of word;
 loop_l              : array[1..64]     { longueur des Looping       }
                       of word;
 i1,i2,i3,i4,
 i5,i6,i7,i8         : pt;
 inl           : array[1..8] of word;
 inp          : array[1..8] of word;
 i                   : word;
 mlj                 : word;
 mli                 : word;
 In_St       : array[1..8] of byte;
 nb_sam              : byte;            { Nombre de samples  }
 nb_patt             : byte;            { Nombre de patterns }
 m_played            : boolean;
 sound_boucle        : word;

 Sampling_Rate       : byte;

 mod_nom             : string;
 tpw                 : integer;
 loop_pos            : word;
 phase_1,
 phase_2             : boolean;
 Sampel1,Sampel2,                       { samples actifs             }
 Sampel3,Sampel4,
 Sampel5,Sampel6,
 Sampel7,Sampel8     : pointer;
 SaTail1,SaTail2,                       { Taille des samples actifs  }
 SaTail3,SaTail4,
 SaTail5,SaTail6,
 SaTail7,SaTail8         : word;
 mautodet            : boolean;

 modmultiply         : word;

 mloop               : boolean;

 periodic_arret      : pointer;         { Pointeur sur proc‚dure de stop }

 music_off           : boolean;         { quand TRUE arrete la musique }

 Notvol1,Notvol2,
 Notvol3,Notvol4,
 Notvol5,Notvol6,
 Notvol7,Notvol8     : byte;
 NotVol              : array[1..8] of byte;
 Old_TCompteur       : word;

 Dma_Compteur        : integer;

 dma_annul           : integer;         { Annulation du compteur DMA }
 mod_terminated      : boolean;
 ls    : array[1..8] of word;
 ll     : array[1..8] of word;
 Eff  : array[1..8] of byte;
 Nom_Chanson         : string[20];      { Nom des fichiers MOD       }
 Noms_Inst           : array[1..31]     { Nom des instruments        }
                       of string[22];
vol_inst             : array[1..31]
                       of byte;
 ChansonLongueur     : byte;
 SecCompteur         : word;
 secpass,minpass       : byte;            { Duree des chansons         }
 Taille_Patt         : integer;
 XMSMaxFree          : word;
 MinXms              : word;
 xmsHandles             : array[1..32]of word;

 soundeff : pointer;
 Taille_effet : word;
 effet_posi : word;
 Effvk      : word;
 Effnk      : byte;
 Effistvk   : word;
 Effistnk   : byte;
 Effet : pt;
 Effet_reduction : boolean;
 _ton_haut : byte;

 _cible : pt;
 _Modp  : pointer;                       { Pointeur sur Rm_Song        }
 note1,note2,
 note3,note4,
 note5,note6,
 note7,note8 :byte;

 Fadepos1,fadepos2,
 fadepos3,fadepos4,
 fadepos5,fadepos6,
 fadepos7,fadepos8 : word;

 intback : pointer;
 port21 : byte;

 vocf : file;
 t_f : longint;
 bloc1,bloc2 : pointer;
 voch : vocheader;
 vblock : voiceblock;
 intpointer : pointer;
 dsp_rdy_voc : boolean;
 T_bloc : word;
 PLAYING_MOD : boolean;
 PLAYING_VOC : boolean;
 dummarray : array[1..20] of byte;
 lastone : boolean;
 VOC_READY : boolean;
 inread : array[1..25] of byte;
 vocsstereo : boolean;
 Mod_Fin : boolean;

implementation

END.



