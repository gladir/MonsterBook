{$IFNDEF __MalteSVM}
 {$DEFINE __MalteSVM}

Const
 {Constante des fixages de mode vid‚o en arriŠre plan}
 indexProcSetVidModeMDAPrim=21;                 {Fixe le mode vid‚o MDA de la carte primaire}
 indexProcSetVidModeMDASec=22;                  {Fixe le mode vid‚o MDA de la carte secondaire}
 indexProcSetVidModeHerculePrim=23;             {Fixe le mode vid‚o Hercule de la carte primaire}
 indexProcSetVidModeHerculeSec=24;              {Fixe le mode vid‚o Hercule de la carte secondaire}
 indexProcSetVidModeHP95LXPrim=25;              {Fixe le mode vid‚o HP95LX de la carte primaire}
 indexProcSetVidModeCGAPrim=26;                 {Fixe le mode vid‚o CGA de la carte primaire}
 indexProcSetVidModeCGASec=27;                  {Fixe le mode vid‚o CGA de la carte secondaire}
 indexProcSetVidModeGSPrim=28;                  {Fixe le mode vid‚o Graphic Solutions de la carte primaire}
 indexProcSetVidModeGSSec=29;                   {Fixe le mode vid‚o Graphic Solutions de la carte secondaire}
 indexProcSetVidModeGSEmulPrim=30;              {Fixe le mode vid‚o ‚muler de la Graphic Solutions de la carte primaire}
 indexProcSetVidModeGSEmulSec=31;               {Fixe le mode vid‚o ‚muler de la Graphic Solutions de la carte secondaire}
 indexProcSetVidModePCJrPrim=32;                {Fixe le mode vid‚o PC Junior de la carte primaire}
 indexProcSetVidModeTandy1000Prim=33;           {Fixe le mode vid‚o Tandy 1000 de la carte primaire}
 indexProcSetVidModeEGAPrim=34;                 {Fixe le mode vid‚o EGA de la carte primaire}
 indexProcSetVidModeAheadEGA2001Prim=35;        {Fixe le mode vid‚o Ahead EGA2001 de la carte primaire}
 indexProcSetVidModeATT6300Prim=36;             {Fixe le mode vid‚o AT&T 6300 de la carte primaire}
 indexProcSetVidModeEGAWonderPrim=37;           {Fixe le mode vid‚o EGA Wonder de la carte primaire}
 indexProcSetVidModeLavaChromeIIEGAPrim=38;     {Fixe le mode vid‚o LavaChrome II EGA de la carte primaire}
 indexProcSetVidModeParadiseEGA480Prim=39;      {Fixe le mode vid‚o Paradise EGA-480 de la carte primaire}
 indexProcSetVidModeTaxan565EGAPrim=40;         {Fixe le mode vid‚o Taxan-565 EGA de la carte primaire}
 indexProcSetVidModeUltraVisionEGAPrim=41;      {Fixe le mode vid‚o UltraVision EGA de la carte primaire}
 indexProcSetVidModeVGAPrim=42;                 {Fixe le mode vid‚o VGA de la carte primaire}
 indexProcSetVidModeAheadBPrim=43;              {Fixe le mode vid‚o Ahead B de la carte primaire}
 indexProcSetVidModeAllStarPeacockPrim=44;      {Fixe le mode vid‚o AllStar Peacock de la carte primaire}
 indexProcSetVidModeASTVGAPlusPrim=45;          {Fixe le mode vid‚o AST VGA Plus de la carte primaire}
 indexProcSetVidModeATTVDC600Prim=46;           {Fixe le mode vid‚o AT&T VDC600 de la carte primaire}
 indexProcSetVidModeCardinalPrim=47;            {Fixe le mode vid‚o Cardinal de la carte primaire}
 indexProcSetVidModeCirrusPrim=48;              {Fixe le mode vid‚o Cirrus de la carte primaire}
 indexProcSetVidModeEverexPrim=49;              {Fixe le mode vid‚o Everex de la carte primaire}
 indexProcSetVidModeGenoaPrim=50;               {Fixe le mode vid‚o Genoa de la carte primaire}
 indexProcSetVidModeHewlettPackardD1180APrim=51;{Fixe le mode vid‚o Hewlett Packard D1180A de la carte primaire}
 indexProcSetVidModeMorseVGAPrim=52;            {Fixe le mode vid‚o Morse VGA de la carte primaire}
 indexProcSetVidModeOakPrim=53;                 {Fixe le mode vid‚o Oak de la carte primaire}
 indexProcSetVidModeOrchidPrim=54;              {Fixe le mode vid‚o Orchid de la carte primaire}
 indexProcSetVidModeOrchidProPrim=55;           {Fixe le mode vid‚o Orchid Pro de la carte primaire}
 indexProcSetVidModeParadisePrim=56;            {Fixe le mode vid‚o Paradise de la carte primaire}
 indexProcSetVidModeRealtekRTVGA=57;            {Fixe le mode vid‚o Realtek RT VGA de la carte primaire}
 indexProcSetVidModeSigmaPrim=58;               {Fixe le mode vid‚o Sigma de la carte primaire}
 indexProcSetVidModeSTBPrim=59;                 {Fixe le mode vid‚o STB de la carte primaire}
 indexProcSetVidModeTatungVGAPrim=60;           {Fixe le mode vid‚o Tatung VGA de la carte primaire}
 indexProcSetVidModeTecmarVGAADPrim=61;         {Fixe le mode vid‚o Tecmar VGA AD de la carte primaire}
 indexProcSetVidModeTridentPrim=62;             {Fixe le mode vid‚o Trident de la carte primaire}
 indexProcSetVidModeTsengET4000Prim=63;         {Fixe le mode vid‚o Tseng ET4000 de la carte primaire}
 indexProcSetVidModeTsengET4000HiColorPrim=64;  {Fixe le mode vid‚o Tseng ET4000 HiColor de la carte primaire}
 indexProcSetVidModeVGAWonderPrim=65;           {Fixe le mode vid‚o VGA Wonder de la carte primaire}
 indexProcSetVidModeVESAPrim=66;                {Fixe le mode vid‚o VESA de la carte primaire}
 indexProcSetVidModeVideo7Prim=67;              {Fixe le mode vid‚o Video 7 de la carte primaire}
 indexProcSetVidModeXGA=68;                     {Fixe le mode vid‚o XGA de la carte primaire}

 {$IFDEF DPMI}
  indSVMAheadEGA2001Prim=indexProcSetVidModeAheadEGA2001Prim;
  indSVMLavaChrome2EGAPrim=indexProcSetVidModeLavaChromeIIEGAPrim;
  indSVMParadiseEGA480Prim=indexProcSetVidModeParadiseEGA480Prim;
  indSVMTaxan565EGAPrim=indexProcSetVidModeTaxan565EGAPrim;
  indSVMUltraVisionEGAPrim=indexProcSetVidModeUltraVisionEGAPrim;
  indSVMAllStarPeacockPrim=indexProcSetVidModeAllStarPeacockPrim;
  indSVMASTVGAPlusPrim=indexProcSetVidModeASTVGAPlusPrim;
  indSVMHPD1180APrim=indexProcSetVidModeHewlettPackardD1180APrim;
  indSVMTecmarVGAADPrim=indexProcSetVidModeTecmarVGAADPrim;
  indSVMTsengET4000Prim=indexProcSetVidModeTsengET4000Prim;
  indSVMTsengET4000HiKrPrim=indexProcSetVidModeTsengET4000HiColorPrim;
  indSVMVGAWonderPrim=indexProcSetVidModeVGAWonderPrim;
 {$ENDIF}
{$ENDIF}