; Malte Genesis IV: AdŠle
; Module Chryo-g‚n‚tique de virtualisation de la persception
; Tous droits r‚serv‚s par les Chevaliers de Malte
; ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
;
; Description
; ÍÍÍÍÍÍÍÍÍÍÍ
;     Ce module se charge du lancement de la d‚tection du pilote vid‚o ainsi
; que le tampon d'ouverture pour la gestion vid‚o de Chantal. Pour en savoir
; plus,  il suffit  de consulter  les  documents  ®\MALTE\TEXT\PROJETMA.LTE\
; CHANTAL\*.*¯.
;
;
; Remarques
; ÍÍÍÍÍÍÍÍÍ
;  þ Il est con‡u pour fonctionner sur un processeur 8088 ou post‚rieur, et
;    tous changements de cette sp‚cification entraŒne n‚cessairement un
;    ®scrache¯!
;  þ Tous les m‚canismes suppose  que le module commence  … n'importe  quel
;    segment, MAIS avec l'offset 0!
;
; ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
;                              Sp‚cification
; ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
.8086
.MODEL TPASCAL

Jumps

Adele equ 1 ; D‚finit la bibliothŠque Malte Genesis V: AdŠle

Include Systex.Inc
Include Library\Compiler\Assemble.ur\Dialect.Inc
Include Library\Disk\Bios\ChkSCSI.Mac
Include Library\Video\Card\ChkTride.Mac
Include Library\Video\Card\ChkXGA.Mac
Include Library\Video\Card\V7VRam.Mac
Include Library\Sound\AdLib\AdLibChk.Mac

.DATA
extrn Jump
extrn StartUp

; ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
;                             Pr‚requis externe
; ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
Extrn CheckSVGA,VesaBiosBank,PrefixSeg,IsAdLib,IsSoundBlaster,IsGravis
Extrn IsRoland,IsTandyDigital,SoundMem,SoundPort,ModeSupport,MemAlloc
Extrn NumModeSupport,DefMousePort,TypeMouse,COMLCR,ComBase,ComInt,ComIRQ
Extrn DefMouseCom,IRQIntNumMouse,PicStateMouse
; ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
;                           Les entˆtes des pilotes
; ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
Public Init,BarSpcHor,CloseCur,ClrLnHor,ClrLnHorImg,ClrWn,ClrScr,CopT8Bin
Public Copy8Bin,FillBox,GetAttr,GetChr,GetCube,GetLnHorImg,GetPixel
Public GetSizeSmlImg,GetSmlImg,MoveText,PCopy,PutFillBox,PutLn,PutLnHor
Public PutSmlImg,PutSprite,PutTxtXY,PutTxtXYUnKr,SetAttr,SetBackgroundColor
Public SetBlink,SetBorderColor,SetBytesPerLn,SetChr,SetChrWidth,PCopy2Img
Public SetCube,SetCur,SetCurPos,SetGCube,SetGCubeT,BarSpcVer,BarTxtHor
Public SetHorizontalScale,SetMatrix,SetModeMtx,BarChrHor,BarChrVer
Public SetModeScr,SetPalBlk,SetPaletteRGB,SetPalRGB,FillBnk,SetWriteMode
Public SetPg,SetPixel,SetVerticalScale,SetVisualPg,SetUnderline
Public SplitScreen,SetBnkPg,ReadBnk,WriteBnk,Done,Circle,PutFillCircle
Public _GetVideoCard,viInitVideo,PutFillRoundRect,PutRoundRect,PutRect
Public CloseIcon,DownIcon, IsLuxe,   LeftIcon,SelIcon
Public SetLuxe,  RightIcon,UnSelIcon,UpIcon,  ZoomIcon
Public DossierDocumentIcon,DossierProgramIcon
; ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
;                Fonctions et Proc‚dures inclue dans ce module
; ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
Public StartUpChantal
Public AutoDetect,InitSound
Public viSetVideoModePrim,viSetVideoSizePrim
Public SetHeightChr,GetRealRawY,GetRawY,SetDblMtx,SetExtChr,SetExtCube
; ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
;                Les duplications des fonctions et proc‚dures
; ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
Public BarSpaceHorizontal,BarSpaceHori,BarSpaceHor
Public ClearLineHori,ClearLineHor
Public Cls,ClearScr,ClearScreen,FillScreen
Public ClsCur,CloseCursor
Public GetChar,GetCharacter
Public GetPIVSec
Public GetRealRawYWord
Public GotoXY,Locate,SetCursorPos,SetCursorPosition
Public _ImageSize
Public Plot,Point,PSet
Public PutCharGAttr
Public PutTxtXYUnCol,WriteXYUnKr
Public SetChar,SetCharacter
Public SelBnkPg,ClearWindow,PageCopy,SetPage
Public PutLine,PutLineHori,SetVisualPage,SetCursor
Public SetModeMatrix,SetModeScreen,PutTextXY
Public WriteXY,Stat,_GetPixel
Public _SetActivePage,Bar
Public PutCloseIcon,PutDownIcon
; ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
;                      Fonction par d‚faut du StartUp
; ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
Public directAltPress,directCtrlPress,directFillChar,directGetIntVec
Public directGetRawTimer,directGetRawTimerB,directJoyPos,directKeyPress
Public directLShiftPress,directMove,directPushKey,directRawReadKey
Public directRShiftPress,directSetIntVec,directShiftPress
Public MtxStartUp,directFillChar386,directMove386

; ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
;                        Constante interne du module
; ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

 indexProcSelBnkPgVGA             equ 1
 indexProcSelBnkPgAhead           equ 2
 indexProcSelBnkPgATI             equ 3
 indexProcSelBnkPgCirrus          equ 4
 indexProcSelBnkPgCTI             equ 5
 indexProcSelBnkPgEverex          equ 6
 indexProcSelBnkPgGenoa           equ 7
 indexProcSelBnkPgHeadLand        equ 8
 indexProcSelBnkPgOak             equ 9
 indexProcSelBnkPgParadise        equ 10
 indexProcSelBnkPgSTB             equ 11
 indexProcSelBnkPgTrident         equ 12
 indexProcSelBnkPgTsengET3000     equ 13
 indexProcSelBnkPgTsengET4000     equ 14
 indexProcSelBnkPgVesa            equ 15
 indexProcSelBnkPgVideo7          equ 16
 indexProcSelBnkPgXGA             equ 17
 indexProcSelBnkPgZymos           equ 18
 indexProcSelBnkPgAheadA          equ 19
 indexProcSelBnkPgAheadB          equ 20
 indexProcSelBnkPgATI_GNU         equ 21 ; ATI selon la m‚thode GNU...
 indexProcSelBnkPgChips           equ 22
 indexProcSelBnkPgTrident89       equ 23
 indexProcSelBnkPgVesaBios        equ 24
 indexProcSelBnkPgATIGUPro        equ 25 ; ATI GU Pro/Ultra
 indexProcSelBnkPgATI16MD         equ 26 ; ATI 16 MD
 indexProcSelBnkPgAcumos          equ 27 ; Acumos
 indexProcSelBnkPgCirrus54        equ 28 ; Cirrus 54
 indexProcSelBnkPgCL5426          equ 29 ; CL5426
 indexProcSelBnkPgSS24X           equ 30 ; SS24X/WD90C3x
 indexProcSelBnkPgRealTek         equ 31 ; RealTek
 indexProcSelBnkPgS3805_1M        equ 32 ; S3805 - 1M / S3864 - 2M
 indexProcSelBnkPgSParadise       equ 33 ; SParadise
 indexProcSelBnkPgVESAS3          equ 34 ; VESA S3
 indexProcSelBnkPgViper           equ 35 ; Viper
 indexProcSelBnkPgWDVanila        equ 36 ; WD Vanila / WD90C31
 indexProcSelBnkPgMatrox          equ 37 ; Matrox

 indexProcSetVidModeMDAPrim       equ 21
 indexProcSetVidModeMDASec        equ 22
 indexProcSetVidModeHerculePrim   equ 23
 indexProcSetVidModeHerculeSec    equ 24
 indexProcSetVidModeHP95LXPrim    equ 25
 indexProcSetVidModeCGAPrim       equ 26
 indexProcSetVidModeCGASec        equ 27
 indexProcSetVidModeGSPrim        equ 28
 indexProcSetVidModeGSSec         equ 29
 indexProcSetVidModeGSEmulPrim    equ 30
 indexProcSetVidModeGSEmulSec     equ 31
 indexProcSetVidModePCJrPrim      equ 32
 indexProcSetVidModeTandy1000Prim equ 33
 indexProcSetVidModeEGAPrim       equ 34
 indSVMAheadEGA2001Prim           equ 35
 indexProcSetVidModeATT6300Prim   equ 36
 indexProcSetVidModeEGAWonderPrim equ 37
 indSVMLavaChrome2EGAPrim         equ 38
 indSVMParadiseEGA480Prim         equ 39
 indSVMTaxan565EGAPrim            equ 40
 indSVMUltraVisionEGAPrim         equ 41
 indexProcSetVidModeVGAPrim       equ 42
 indexProcSetVidModeAheadBPrim    equ 43
 indSVMAllStarPeacockPrim         equ 44
 indSVMASTVGAPlusPrim             equ 45
 indexProcSetVidModeATTVDC600Prim equ 46
 indexProcSetVidModeCardinalPrim  equ 47
 indexProcSetVidModeCirrusPrim    equ 48
 indexProcSetVidModeEverexPrim    equ 49
 indexProcSetVidModeGenoaPrim     equ 50
 indSVMHPD1180APrim               equ 51
 indexProcSetVidModeMorseVGAPrim  equ 52
 indexProcSetVidModeOakPrim       equ 53
 indexProcSetVidModeOrchidPrim    equ 54
 indexProcSetVidModeOrchidProPrim equ 55
 indexProcSetVidModeParadisePrim  equ 56
 indexProcSetVidModeRealtekRTVGA  equ 57
 indexProcSetVidModeSigmaPrim     equ 58
 indexProcSetVidModeSTBPrim       equ 59
 indexProcSetVidModeTatungVGAPrim equ 60
 indSVMTecmarVGAADPrim            equ 61
 indexProcSetVidModeTridentPrim   equ 62
 indSVMTsengET4000Prim            equ 63
 indSVMTsengET4000HiKrPrim        equ 64
 indexProcSetVidModeVGAWonderPrim equ 65
 indexProcSetVidModeVESAPrim      equ 66
 indexProcSetVidModeVideo7Prim    equ 67
 indexProcSetVidModeXGA           equ 68
 indexProcSelBnkPgRet             equ 143

.CODE

; ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
;                      Fonctions et proc‚dures virtuel
; ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
Init Proc Far
viSetVideoModePrim Proc Far
 NOP
 NOP
 NOP
endp
endp
viSetVideoSizePrim Proc Far
BarChrHor Proc Far
 NOP
 NOP
 NOP
endp
endp
BarChrVer Proc Far
 NOP
 NOP
 NOP
endp
BarSpaceHorizontal Proc Far
BarSpaceHori Proc Far
BarSpaceHor Proc Far
BarSpcHor Proc Far
 NOP
 NOP
 NOP
endp
endp
endp
endp
BarSpcVer Proc Far
 NOP
 NOP
 NOP
endp
BarTxtHor Proc Far
 NOP
 NOP
 NOP
endp
Circle Proc Far
 NOP
 NOP
 NOP
endp
CloseCursor Proc Far
ClsCur Proc Far
CloseCur Proc Far
 NOP
 NOP
 NOP
endp
endp
endp
ClearLineHori Proc Far
ClearLineHor Proc Far
ClrLnHor Proc Far
 NOP
 NOP
 NOP
endp
endp
endp
ClrLnHorImg Proc Far
 NOP
 NOP
 NOP
endp
ClearWindow Proc Far
ClrWn Proc Far
 NOP
 NOP
 NOP
endp
endp
FillScreen Proc Far
Cls Proc Far
ClearScreen Proc Far
ClearScr Proc Far
ClrScr Proc Far
 NOP
 NOP
 NOP
endp
endp
endp
endp
endp
CopT8Bin Proc Far
 NOP
 NOP
 NOP
endp
Copy8Bin Proc Far
 NOP
 NOP
 NOP
endp
FillBox Proc Far
 NOP
 NOP
 NOP
endp
GetAttr Proc Far
 NOP
 NOP
 NOP
endp
GetCharacter Proc Far
GetChar Proc Far
GetChr Proc Far
 NOP
 NOP
 NOP
endp
endp
endp
Stat Proc Far
GetCube Proc Far
 NOP
 NOP
 NOP
endp
endp
GetLnHorImg Proc Far
 NOP
 NOP
 NOP
endp
_GetPixel Proc Far
GetPixel Proc Far
 NOP
 NOP
 NOP
endp
endp
_ImageSize Proc Far
GetSizeSmlImg Proc Far
 NOP
 NOP
 NOP
endp
endp
GetSmlImg Proc Far
 NOP
 NOP
 NOP
endp
MoveText Proc Far
 NOP
 NOP
 NOP
endp
PageCopy Proc Far
PCopy Proc Far
 NOP
 NOP
 NOP
endp
endp
PCopy2Img Proc Far
 NOP
 NOP
 NOP
endp
PutCharGAttr Proc Far
 NOP
 NOP
 NOP
endp
Bar Proc Far
PutFillBox Proc Far
 NOP
 NOP
 NOP
endp
endp
PutFillCircle Proc Far
 NOP
 NOP
 NOP
endp
PutFillRoundRect Proc Far
 NOP
 NOP
 NOP
endp
PutLine Proc Far
PutLn Proc Far
 NOP
 NOP
 NOP
endp
endp
PutLineHori Proc Far
PutLnHor Proc Far
 NOP
 NOP
 NOP
endp
endp
PutRect Proc Far
 NOP
 NOP
 NOP
endp
PutRoundRect Proc Far
 NOP
 NOP
 NOP
endp
PutSmlImg Proc Far
 NOP
 NOP
 NOP
endp
PutSprite Proc Far
 NOP
 NOP
 NOP
endp
WriteXY Proc Far
PutTextXY Proc Far
PutTxtXY Proc Far
 NOP
 NOP
 NOP
endp
endp
endp
WriteXYUnKr Proc Far
PutTxtXYUnCol Proc Far
PutTxtXYUnKr Proc Far
 NOP
 NOP
 NOP
endp
endp
endp
SetAttr Proc Far
 NOP
 NOP
 NOP
endp
SetBackgroundColor Proc Far
 NOP
 NOP
 NOP
endp
SetBlink Proc Far
 NOP
 NOP
 NOP
endp
SetBorderColor Proc Far
 NOP
 NOP
 NOP
endp
SetBytesPerLn Proc Far
 NOP
 NOP
 NOP
endp
SetChar Proc Far
SetCharacter Proc Far
SetChr Proc Far
 NOP
 NOP
 NOP
endp
endp
endp
SetChrWidth Proc Far
 NOP
 NOP
 NOP
endp
SetCube Proc Far
 NOP
 NOP
 NOP
endp
SetCursor Proc Far
SetCur Proc Far
 NOP
 NOP
 NOP
endp
endp
GotoXY Proc Far
Locate Proc Far
SetCursorPosition Proc Far
SetCursorPos Proc Far
SetCurPos Proc Far
 NOP
 NOP
 NOP
endp
endp
endp
endp
endp
SetDblMtx Proc Far
 NOP
 NOP
 NOP
endp
SetExtChr Proc Far
 NOP
 NOP
 NOP
endp
SetExtCube Proc Far
 NOP
 NOP
 NOP
endp
SetGCube Proc Far
 NOP
 NOP
 NOP
endp
SetGCubeT Proc Far
 NOP
 NOP
 NOP
endp
SetHorizontalScale Proc Far
 NOP
 NOP
 NOP
endp
SetMatrix Proc Far
 NOP
 NOP
 NOP
endp
SetModeMatrix Proc Far
SetModeMtx Proc Far
 NOP
 NOP
 NOP
endp
endp
SetModeScreen Proc Far
SetModeScr Proc Far
 NOP
 NOP
 NOP
endp
endp
SetPalBlk Proc Far
 NOP
 NOP
 NOP
endp
SetPaletteRGB Proc Far
 NOP
 NOP
 NOP
endp
SetPalRGB Proc Far
 NOP
 NOP
 NOP
endp
_SetActivePage Proc Far
SetPage Proc Far
SetPg Proc Far
 NOP
 NOP
 NOP
endp
endp
endp
Plot Proc Far
Point Proc Far
PSet Proc Far
SetPixel Proc Far
 NOP
 NOP
 NOP
endp
endp
endp
endp
SetUnderline Proc Far
 NOP
 NOP
 NOP
endp
SetVerticalScale Proc Far
 NOP
 NOP
 NOP
endp
SetVisualPage Proc Far
SetVisualPg Proc Far
 NOP
 NOP
 NOP
endp
endp
SetWriteMode Proc Far
 NOP
 NOP
 NOP
endp
SplitScreen Proc Far
 NOP
 NOP
 NOP
endp
SelBnkPg Proc Far
SetBnkPg Proc Far
 NOP
 NOP
 NOP
endp
endp
ReadBnk Proc Far
 NOP
 NOP
 NOP
endp
WriteBnk Proc Far
 NOP
 NOP
 NOP
endp
FillBnk Proc Far
 NOP
 NOP
 NOP
endp
Done Proc Far
 NOP
 NOP
 NOP
endp
SetLuxe Proc Far
 NOP
 NOP
 NOP
endp
IsLuxe Proc Far
 RETF
; NOP
 NOP
 NOP
endp
PutCloseIcon Proc Far
CloseIcon Proc Far
 NOP
 NOP
 NOP
endp
endp
PutDownIcon Proc Far
DownIcon Proc Far
 NOP
 NOP
 NOP
endp
endp
LeftIcon Proc Far
 NOP
 NOP
 NOP
endp
RightIcon Proc Far
 NOP
 NOP
 NOP
endp
SelIcon Proc Far
 NOP
 NOP
 NOP
endp
UnSelIcon Proc Far
 NOP
 NOP
 NOP
endp
UpIcon Proc Far
 NOP
 NOP
 NOP
endp
ZoomIcon Proc Far
 NOP
 NOP
 NOP
endp
DossierDocumentIcon Proc Far
 NOP
 NOP
 NOP
endp
DossierProgramIcon Proc Far
 NOP
 NOP
 NOP
endp
RayTxtY:
 DW 0
RawY:
 DW 0
RealRawY:
 DW 0
 RET
@viData: ; Donn‚e temporaire pour les VGA, SVGA ou ordinateur PS/2
 DW 0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0
 DB 108 DUP (0)
; DB 13,10
; DB "L'Ensemble Malte Genesis V: AdŠle.    Tous droits r‚serv‚s aux ",13,10
; DB "Chevaliers de Malte (C) 1997. Originaire du Qu‚bec: Sept-Iles, ",13,10
; DB "Alma et Laval. Gestionnaire principal du systŠme vid‚o d'un PC ",13,10
; DB "compatible IBM.",13,10,13,10
@Maitre:
 DB ('A'+128),('d'+128),('Š'-128),('l'+128),('e'+128),(' '+128),('d'+128),('e'+128),('m'+128),('a'+128)
 DB ('n'+128),('d'+128),('e'+128),(' '+128),('…'-128),(' '+128),('F'+128),('a'+128),('n'+128),('t'+128)
 DB ('o'+128),('m'+128),('a'+128),('s'+128),(' '+128),('d'+128),('e'+128),(' '+128),('t'+128),('e'+128)
 DB (' '+128),('r'+128),('‚'-128),('v'+128),('‚'-128),('l'+128),('e'+128),('r'+128),(' '+128),('l'+128)
 DB ('a'+128),(' '+128),('d'+128),('e'+128),('s'+128),('c'+128),('e'+128),('n'+128),('d'+128),('e'+128)
 DB ('n'+128),('c'+128),('e'+128),(' '+128),('d'+128),('u'+128),(' '+128),('M'+128),('a'+128),('Œ'-128)
 DB ('t'+128),('r'+128),('e'+128),(':'+128),( 13+128),( 10+128),( 13+128),( 10+128)
 DB ('C'+128),('o'+128),('d'+128),('e'+128),('r'+128),(' '+128),('p'+128),('a'+128),('r'+128),(' '+128)
 DB ('S'+128),('y'+128),('l'+128),('v'+128),('a'+128),('i'+128),('n'+128),(' '+128),('M'+128),('a'+128)
 DB ('l'+128),('t'+128),('a'+128),('i'+128),('s'+128),(','+128),(' '+128),('F'+128),('i'+128),('l'+128)
 DB ('s'+128),(' '+128),('d'+128),('e'+128),(' '+128),('L'+128),('a'+128),('u'+128),('r'+128),('e'+128)
 DB ('n'+128),('t'+128),(' '+128),('M'+128),('a'+128),('l'+128),('t'+128),('a'+128),('i'+128),('s'+128)
 DB (','+128),(' '+128),('F'+128),('i'+128),('l'+128),('s'+128),(' '+128),('d'+128),('e'+128),(' '+128)
 DB ('C'+128),('h'+128),('a'+128),('r'+128),('l'+128),('e'+128),('u'+128),('g'+128),('e'+128),('n'+128)
 DB (' '+128),('M'+128),('a'+128),('l'+128),('t'+128),('a'+128),('i'+128),('s'+128),(','+128),(' '+128)
 DB ('F'+128),('i'+128),('l'+128),('s'+128),(' '+128),('d'+128),('e'+128),(' '+128),('L'+128),('o'+128)
 DB ('u'+128),('i'+128),('s'+128),(' '+128),('M'+128),('a'+128),('l'+128),('t'+128),('a'+128),('i'+128)
 DB ('s'+128),(','+128),(' '+128)
 DB ('F'+128),('i'+128),('l'+128),('s'+128),(' '+128),('d'+128),("'"+128),('A'+128),('n'+128),('i'+128)
 DB ('c'+128),('e'+128),('t'+128),(' '+128),('M'+128),('a'+128),('l'+128),('t'+128),('a'+128),('i'+128)
 DB ('s'+128),(','+128),(' '+128),('F'+128),('i'+128),('l'+128),('s'+128),(' '+128),('d'+128),('e'+128)
 DB (' '+128),('R'+128),('o'+128),('m'+128),('u'+128),('a'+128),('l'+128),('d'+128),(' '+128),('M'+128)
 DB ('a'+128),('l'+128),('t'+128),('a'+128),('i'+128),('s'+128),( 13+128),( 10+128),( 13+128),( 10+128)
 DB ('S'+128),('o'+128),('u'+128),('v'+128),('i'+128),('e'+128),('n'+128),('s'+128),('-'+128),('t'+128)
 DB ('o'+128),('i'+128),(' '+128),('d'+128),('e'+128),(' '+128),('c'+128),('e'+128),(' '+128),('q'+128)
 DB ('u'+128),('e'+128),(' '+128),('t'+128),('u'+128),(' '+128),('a'+128),('s'+128),(' '+128),('a'+128)
 DB ('c'+128),('c'+128),('o'+128),('m'+128),('p'+128),('l'+128),('i'+128),(':'+128),( 13+128),( 10+128)
 DB ('J'+128),('e'+128),('u'+128),('x'+128),(':'+128),(' '+128),(' '+128),(' '+128),(' '+128),(' '+128)
 DB (' '+128),('®'-128),('M'+128),('i'+128),('s'+128),('s'+128),('i'+128),('l'+128),('e'+128),(' '+128)
 DB ('C'+128),('o'+128),('m'+128),('m'+128),('a'+128),('n'+128),('d'+128),('¯'-128),(','+128),('®'-128)
 DB ('T'+128),('e'+128),('t'+128),('r'+128),('i'+128),('s'+128),('¯'-128),('*'+128),('3'+128),(','+128)
 DB ('M'+128),('a'+128),('Œ'-128),('t'+128),('r'+128),('e'+128),(' '+128),('d'+128),('e'+128),(' '+128)
 DB ('l'+128),('a'+128),(' '+128),('L'+128),('o'+128),('g'+128),('i'+128),('q'+128),('u'+128),('e'+128)
 DB (','+128),('L'+128),('2'+128),('5'+128),(','+128),('L'+128),('A'+128),('B'+128),('Y'+128),('S'+128)
 DB (','+128),('L'+128),('I'+128),('M'+128),(','+128),(13+128),(10+128)
 DB (  9+128),(' '+128),(' '+128)
 DB (' '+128),('®'-128),('M'+128),('o'+128),('o'+128),('n'+128),('¯'-128),(','+128),('®'-128),('B'+128)
 DB ('r'+128),('e'+128),('a'+128),('k'+128),('o'+128),('u'+128),('t'+128),('¯'-128),(','+128),('®'-128)
 DB ('N'+128),('i'+128),('b'+128),('b'+128),('l'+128),('e'+128),('s'+128),('¯'-128),(','+128),('®'-128)
 DB ('S'+128),('o'+128),('k'+128),('o'+128),('-'+128),('B'+128),('a'+128),('n'+128),('¯'-128),(','+128)
 DB ('®'-128),('P'+128),('e'+128),('g'+128),('-'+128),('L'+128),('e'+128),('a'+128),('p'+128),('¯'-128)
 DB (','+128),('®'-128),('P'+128),('a'+128),('c'+128),('-'+128),('M'+128),('a'+128),('n'+128),('¯'-128)
 DB ( 13+128),( 10+128)
 DB ('C'+128),('o'+128),('d'+128),('e'+128),('r'+128),(':'+128),(' '+128),(' '+128),(' '+128),(' '+128)
 DB (' '+128),('B'+128),('a'+128),('s'+128),('i'+128),('c'+128),(' '+128),('P'+128),('r'+128),('o'+128)
 DB (','+128),('C'+128),('o'+128),('m'+128),('p'+128),('i'+128),('l'+128),('a'+128),('t'+128),('e'+128)
 DB ('u'+128),('r'+128),(' '+128),('P'+128),('a'+128),('s'+128),('c'+128),('a'+128),('l'+128),(' '+128)
 DB ('B'+128),('5'+128),('7'+128),(','+128),('D'+128),('e'+128),('b'+128),('u'+128),('g'+128),(','+128)
 DB ('L'+128),('S'+128),('M'+128),('B'+128),(','+128),('L'+128),('a'+128),('n'+128),('g'+128),('a'+128)
 DB ('g'+128),('e'+128),(' '+128),('A'+128),('C'+128),(','+128),('C'+128),('2'+128),('P'+128),('A'+128)
 DB ('S'+128),(','+128),( 13+128),( 10+128)
 DB (  9+128),(' '+128),(' '+128)
 DB (' '+128),('R'+128),('C'+128),('2'+128),('P'+128),('A'+128),('S'+128),(','+128),('C'+128),('o'+128)
 DB ('m'+128),('p'+128),('i'+128),('l'+128),('e'+128),('r'+128),(' '+128),('R'+128),('L'+128),('L'+128)
 DB (','+128),('®'-128),('O'+128),('v'+128),('e'+128),('r'+128),('C'+128),('o'+128),('d'+128),('e'+128)
 DB ('¯'-128),( 13+128),( 10+128)
 DB ('G'+128),('e'+128),('s'+128),('t'+128),('i'+128),('o'+128),('n'+128),(':'+128),(' '+128),(' '+128)
 DB (' '+128),('B'+128),('u'+128),('d'+128),('g'+128),('e'+128),('t'+128),('*'+128),('4'+128),(','+128)
 DB ('I'+128),('n'+128),('v'+128),('e'+128),('n'+128),('t'+128),('a'+128),('i'+128),('r'+128),('e'+128)
 DB (','+128),('M'+128),('a'+128),('l'+128),('t'+128),('e'+128),(' '+128),('B'+128),('a'+128),('s'+128)
 DB ('e'+128),(','+128),('C'+128),('a'+128),('t'+128),('a'+128),('l'+128),('o'+128),('g'+128),('u'+128)
 DB ('e'+128),('u'+128),('r'+128),(' '+128),('d'+128),('e'+128),(' '+128),('d'+128),('i'+128),('s'+128)
 DB ('q'+128),('u'+128),('e'+128),('t'+128),('t'+128),('e'+128),( 13+128),( 10+128)
 DB ('D'+128),('e'+128),('s'+128),('s'+128),('i'+128),('n'+128),(':'+128),(' '+128),(' '+128),(' '+128)
 DB (' '+128),('D'+128),('E'+128),('S'+128),('S'+128),('M'+128),(','+128),('C'+128),('M'+128),('-'+128)
 DB ('D'+128),('-'+128),('T'+128),('E'+128),('C'+128),('H'+128),(','+128),('E'+128),('l'+128),('e'+128)
 DB ('c'+128),('t'+128),('r'+128),('o'+128),('n'+128),('i'+128),('c'+128),( 13+128),( 10+128)
 DB ('O'+128),('u'+128),('t'+128),('i'+128),('l'+128),('s'+128),(':'+128),(' '+128),(' '+128),(' '+128)
 DB (' '+128),('M'+128),('a'+128),('l'+128),('T'+128),('o'+128),('o'+128),('l'+128),('s'+128),(','+128)
 DB ('C'+128),('o'+128),('m'+128),('m'+128),('a'+128),('n'+128),('d'+128),('e'+128),('r'+128),(' '+128)
 DB ('M'+128),('a'+128),('l'+128),('t'+128),('a'+128),('i'+128),('s'+128),('*'+128),('2'+128),(','+128)
 DB ('M'+128),('o'+128),('n'+128),('s'+128),('t'+128),('e'+128),('r'+128),('B'+128),('o'+128),('o'+128)
 DB ('k'+128),(','+128),('P'+128),('H'+128),(','+128),('M'+128),('a'+128),('l'+128),('t'+128),('e'+128)
 DB (' '+128),('O'+128),('p'+128),('‚'-128),('r'+128),('a'+128),('t'+128),('e'+128),('u'+128),('r'+128)
 DB ( 13+128),( 10+128)
 DB ('U'+128),('t'+128),('i'+128),('l'+128),('i'+128),('t'+128),('a'+128),('i'+128),('r'+128),('e'+128)
 DB (':'+128),('A'+128),('V'+128),(''-128),(','+128),('D'+128),('I'+128),(','+128),('S'+128),('I'+128)
 DB (','+128),('F'+128),('M'+128),(','+128),('D'+128),('o'+128),('s'+128),('K'+128),('e'+128),('y'+128)
 DB (','+128),('H'+128),('e'+128),('x'+128),('a'+128),('p'+128),('l'+128),('e'+128),('s'+128),(','+128)
 DB ('S'+128),('y'+128),('s'+128),('t'+128),('Š'-128),('m'+128),('e'+128),(' '+128),('I'+128),('n'+128)
 DB ('f'+128),('o'+128),('r'+128),('m'+128),('a'+128),('t'+128),('i'+128),('o'+128),('n'+128),('*'+128)
 DB ('3'+128),( 13+128),( 10+128)
 DB ('E'+128),('n'+128),('s'+128),('e'+128),('m'+128),('b'+128),('l'+128),('e'+128),('/'+128),('B'+128)
 DB ('i'+128),('b'+128),('l'+128),('i'+128),('o'+128),('t'+128),('h'+128),('Š'-128),('q'+128),('u'+128)
 DB ('e'+128),(':'+128),('M'+128),('a'+128),('l'+128),('t'+128),('e'+128),(' '+128),('S'+128),('y'+128)
 DB ('s'+128),('t'+128),('e'+128),('m'+128),(' '+128),('I'+128),('-'+128),('I'+128),('I'+128),(','+128)
 DB ('M'+128),('a'+128),('l'+128),('t'+128),('e'+128),(' '+128),('G'+128),('e'+128),('n'+128),('e'+128)
 DB ('s'+128),('i'+128),('s'+128),(' '+128),('I'+128),( 13+128),( 10+128)
 DB (  9+128),(  9+128),(' '+128),(' '+128),(' '+128),(' '+128),(' '+128),(' '+128),('M'+128),('a'+128)
 DB ('l'+128),('t'+128),('e'+128),(' '+128),('G'+128),('e'+128),('n'+128),('e'+128),('s'+128),('i'+128)
 DB ('s'+128),(' '+128),('I'+128),('I'+128),(':'+128),(' '+128),('P'+128),('h'+128),('o'+128),('e'+128)
 DB ('n'+128),('i'+128),('x'+128),( 13+128),( 10+128)
 DB (  9+128),(  9+128),(' '+128),(' '+128),(' '+128),(' '+128),(' '+128),(' '+128),('M'+128),('a'+128)
 DB ('l'+128),('t'+128),('e'+128),(' '+128),('G'+128),('e'+128),('n'+128),('e'+128),('s'+128),('i'+128)
 DB ('s'+128),(' '+128),('I'+128),('I'+128),('I'+128),(':'+128),(' '+128),('I'+128),('s'+128),('a'+128)
 DB ('b'+128),('e'+128),('l'+128),( 13+128),( 10+128)
 DB (  9+128),(  9+128),(' '+128),(' '+128),(' '+128),(' '+128),(' '+128),(' '+128),('M'+128),('a'+128)
 DB ('l'+128),('t'+128),('e'+128),(' '+128),('G'+128),('e'+128),('n'+128),('e'+128),('s'+128),('i'+128)
 DB ('s'+128),(' '+128),('I'+128),('V'+128),(':'+128),(' '+128),('C'+128),('h'+128),('a'+128),('n'+128)
 DB ('t'+128),('a'+128),('l'+128),( 13+128),( 10+128)
 DB (  9+128),(  9+128),(' '+128),(' '+128),(' '+128),(' '+128),(' '+128),(' '+128),('M'+128),('a'+128)
 DB ('l'+128),('t'+128),('e'+128),(' '+128),('G'+128),('e'+128),('n'+128),('e'+128),('s'+128),('i'+128)
 DB ('s'+128),(' '+128),('V'+128),(';'+128),(' '+128),('A'+128),('d'+128),('Š'-128),('l'+128),('e'+128)
 DB ( 13+128),( 10+128)
 DB (0  +128) ; Fin du message

; Description
; ÍÍÍÍÍÍÍÍÍÍÍ
;
;  Cette proc‚dure copie dans le drapeau du micro-processeur ZF dans le
; registre AL.  Il n'y a que la valeur 0 ou 1 pouvant se retrouver dans
; le registre processeur AL.

@ZF2AL Proc Near
 PUSHF
 POP AX
 SHL AL,1
 MOV CL,7
 SHR AL,CL
 RET
endp

; ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
;                          Fonction viInitVideo:Byte
; ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
;
; Description
; ÍÍÍÍÍÍÍÍÍÍÍ
;
;  Cette fonction d‚tecte  le genre d'environnement vid‚o actuellement actif
; sur le systŠme vid‚o primaire.
;
;
; Remarques
; ÍÍÍÍÍÍÍÍÍ
;
;  þ Cette  fonction  doit normalement ˆtre d‚truit automatiquement aprŠs un
;    chargement  de  pilote vid‚o  par  l'interm‚daire  de l'unit‚ justement
;    Vid‚o. Un scratch peu donc ˆtre provoqu‚ par une mauvaise manipulation.
;  þ Cette fonction fait  des ajustements directement  dans la zone ®PIV¯ en
;    consid‚rant cette objet comme d‚marrant au d‚but d'un segment.
;  þ Cette  fonction  une  am‚lioration  de  la  proc‚dure  InitVideo  de la
;    BibliothŠque RLL ®Magician¯.

viInitVideo Proc Far
  XOR AX,AX
  MOV ES,AX
  MOV AL,ES:[449h]
  CMP AL,13h
  JE  vi0b
  CMP AL,7
  JE  vi0
  CMP AL,6
  JE  vi0c
  CMP AL,4
  JNB vi1
vi0:
  MOV BL,No
  JMP vi2
vi0b:
  MOV AL,5
  JMP viN9
vi0c:
  MOV AL,2
  JMP viN9
   ; C'est un mode Graphiques ?
vi1:
  MOV AH,0Dh
  XOR BH,BH
  XOR CX,CX
  XOR DX,DX
  INT 10h
  PUSH AX
   MOV AX,0C01h
   INT 10h
   MOV AH,0Dh
   INT 10h
   MOV BL,AL
   MOV AH,0Ch
  POP AX
  INT 10h
vi2:
  MOV CS:[adrDataVideo].MIV.Graf,BL ; Init
  CMP BL,Ya
  JE  vi7
  XOR AX,AX
  MOV ES,AX
  MOV AH,0B0h
  CMP Word Ptr ES:[463h],3D4h
  JNE vi3
  MOV AH,0B8h
vi3:
  MOV ES,AX
  PUSH ES
   MOV AH,3
   MOV BH,0
   INT 10h
   PUSH DX
    MOV AH,2
    XOR DX,DX
    INT 10h
   POP  DX
   MOV AH,8
   INT 10h
  POP ES
  CMP AX,ES:[0]
  MOV AH,2
  JNE vi5
  INT 10h
  MOV AL,Ya
  JMP vi6
vi5:
  INT 10h
  MOV AL,No
vi6:
  MOV CS:[adrDataVideo].MIV.Direct,AL
  JMP viN9
vi7:
  MOV AH,1Bh
  XOR BX,BX
  PUSH CS
  POP ES
  MOV DI,Offset @viData
  INT 10h
  CMP AL,1Bh
  JNE viBios
  MOV AX,Word Ptr CS:[Offset @viData+27h]
  CMP AX,2
  JE  viN9
  MOV BX,AX
  MOV AL,4
  CMP BX,16
  JE  viN9
  MOV AL,6
  JE  viN9
viBios:
  XOR AX,AX
viN9:
  INC AX
  INC AX
 RET
viInitVideo ENDP

; ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
;        Table de comparaison des "SetVideoModes" du vid‚o primaire
; ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
@BaseCard:
 DB indexProcSetVidModeMDAPrim       ;vnUnknown: D‚tectection automatique
 DB indexProcSetVidModeEGAPrim       ;vnAhead: Ahead
 DB indexProcSetVidModeAheadBPrim    ;vnAheadB: Ahead B (SVGA)
 DB indexProcSetVidModeAheadBPrim    ;vnAheadBWizard3270: Ahead B-Wizard/3270 (SVGA)
 DB indSVMAheadEGA2001Prim           ;vnAheadEGA2001: Ahead EGA2001 (Super EGA)
 DB indSVMAllStarPeacockPrim         ;vnAllstarPeacock: Allstar Peacock (VGA)
 DB indSVMASTVGAPlusPrim             ;vnASTVGAPlus: AST VGA Plus (SVGA)
 DB indexProcSetVidModeCGAPrim       ;vnATT: AT&T
 DB indexProcSetVidModeATT6300Prim   ;vnATT6300: AT&T 6300 (Super EGA)
 DB indexProcSetVidModeATTVDC600Prim ;vnATTVDC600: AT&T VDC600 (SVGA)
 DB indexProcSetVidModeCardinalPrim  ;vnCardinal: Cardinal (SVGA)
 DB indexProcSetVidModeCGAPrim       ;vnCGA: CGA
 DB indexProcSetVidModeVGAPrim       ;vnCirrus: Cirrus (SVGA)
 DB indexProcSetVidModeCGAPrim       ;vnCompaqPortable: Compaq Portable
 DB indexProcSetVidModeVGAPrim       ;vnCompaqVGA: Compaq VGA (SVGA)
 DB indexProcSetVidModeVGAPrim       ;vnCTI82C451: CTI 82C451 (SVGA)
 DB indexProcSetVidModeVGAPrim       ;vnCTI82C452: CTI 82C452 (SVGA)
 DB indexProcSetVidModeVGAPrim       ;vnDellVGA: Dell VGA (SVGA)
 DB indexProcSetVidModeEGAPrim       ;vnEGA: EGA
 DB indexProcSetVidModeEGAWonderPrim ;vnEGAW800: EGA Wonder 800+ (Super EGA)
 DB indexProcSetVidModeEGAWonderPrim ;vnEGAW800N18800: EGA Wonder 800+-18800 (Super EGA)
 DB indexProcSetVidModeEGAWonderPrim ;vnEGAW800N18800_1: EGA Wonder 800+-18800-1 (Super EGA)
 DB indexProcSetVidModeEGAWonderPrim ;vnEGAW800N28800_2: EGA Wonder 800+-28800-2 (Super EGA)
 DB indexProcSetVidModeEGAWonderPrim ;vnEGAW800N28800_4: EGA Wonder 800+-28800-4 (Super EGA)
 DB indexProcSetVidModeEGAWonderPrim ;vnEGAW800N28800_5: EGA Wonder 800+-28800-5 (Super EGA)
 DB indexProcSetVidModeEverexPrim    ;vnEverex: Everex
 DB indexProcSetVidModeEverexPrim    ;vnEverexViewPoint: Everex ViewPoint
 DB indexProcSetVidModeEverexPrim    ;vnEverexUG2: Everex UltraGraphics II
 DB indexProcSetVidModeEverexPrim    ;vnEverexVision: Everex Vision
 DB indexProcSetVidModeEverexPrim    ;vnEverexEVGA: Everex EVGA
 DB indexProcSetVidModeGenoaPrim     ;vnGenoa: Genoa
 DB indexProcSetVidModeGenoaPrim     ;vnGenoa5100: Genoa 5100
 DB indexProcSetVidModeGenoaPrim     ;vnGenoa5300: Genoa 5300
 DB indexProcSetVidModeGenoaPrim     ;vnGenoa6100: Genoa 6100
 DB indexProcSetVidModeGenoaPrim     ;vnGenoa6200: Genoa 6200
 DB indexProcSetVidModeGenoaPrim     ;vnGenoa6400: Genoa 6400 (SVGA)
 DB indexProcSetVidModeGSPrim        ;vnGS: Graphics Solution d'ATI (Super CGA)
 DB indexProcSetVidModeVGAWonderPrim ;vnGU: Graphics Ultra d'ATI (SVGA)
 DB indexProcSetVidModeVGAWonderPrim ;vnGUPlus: Graphics Ultra d'ATI (SVGA)
 DB indexProcSetVidModeVGAWonderPrim ;vnGUPro: Graphics Ultra d'ATI (SVGA)
 DB indexProcSetVidModeVGAPrim       ;vnHeadLand: HeadLand (SVGA)
 DB indexProcSetVidModeHerculePrim   ;vnHercule: Hercule (HGC)
 DB indSVMHPD1180APrim               ;vnHPD1180A: Hewlett-Packard D1180A (SVGA)
 DB indexProcSetVidModeHP95LXPrim    ;vnHP95LX: HP 95LX
 DB indexProcSetVidModeVGAPrim       ;vnIBM8514A: IBM 8514/AI
 DB indexProcSetVidModeVGAPrim       ;vnImtec: Imtec (SVGA)
 DB indSVMTsengET4000Prim            ;vnITVGA2: IT-VGA2 (SVGA)
 DB indSVMLavaChrome2EGAPrim         ;vnLavaChromeIIEGA: Lava Chrome II EGA (Super EGA)
 DB indexProcSetVidModeVGAPrim       ;vnLogix: Logix (SVGA)
 DB indexProcSetVidModeVGAPrim       ;vnMCGA: MCGA
 DB indexProcSetVidModeMDAPrim       ;vnMDA: MDA
 DB indexProcSetVidModeVGAPrim       ;vnMaxxon: Maxxon
 DB indexProcSetVidModeMorseVGAPrim  ;vnMorseVGA: Morse VGA (VGA)
 DB indexProcSetVidModeEGAPrim       ;vnNSISmartEGA: NSI Smart EGA+ (Super EGA)
 DB indexProcSetVidModeOakPrim       ;vnOak: Oak Technologies (SVGA)
 DB indexProcSetVidModeOrchidPrim    ;vnOrchid: Orchid
 DB indexProcSetVidModeOrchidProPrim ;vnOrchidProDesVGA: Orchid Prodesigner VGA (SVGA)
 DB indexProcSetVidModeOrchidProPrim ;vnOrchidProDesIIVGA: Orichid Prodesigner II VGA (SVGA/32768 couleurs)
 DB indexProcSetVidModeParadisePrim  ;vnParadise: Paradise
 DB indSVMParadiseEGA480Prim         ;vnParadiseEGA480: Paradise EGA-480, Super EGA
 DB indexProcSetVidModeParadisePrim  ;vnParadisePVGA1A: Paradise PVGA1A
 DB indexProcSetVidModeParadisePrim  ;vnParadiseWD90C00: Paradise WD90C00
 DB indexProcSetVidModeParadisePrim  ;vnParadiseWD90C10: Paradise WD90C10
 DB indexProcSetVidModeParadisePrim  ;vnParadiseWD90C11: Paradise WD90C11
 DB indexProcSetVidModeMDAPrim       ;vnPC3270: PC 3270
 DB indexProcSetVidModeMDAPrim       ;vnPC3270G: PC 3270G
 DB indexProcSetVidModeMDAPrim       ;vnPC3270GX: PC 3270GX
 DB indexProcSetVidModeCGAPrim       ;vnPCJr: PC Junior
 DB indexProcSetVidModeVGAPrim       ;vnPGA: PGA
 DB indexProcSetVidModeVGAWonderPrim ;vnPrismElite: Prism Elite d'ATI (SVGA)
 DB indexProcSetVidModeVGAPrim       ;vnQU: Quadram Ultra VGA (SVGA)
 DB indexProcSetVidModeVGAPrim       ;vnSEFCOTVGA: SEFCO TVGA (SVGA)
 DB indexProcSetVidModeSigmaPrim     ;vnSigma: Sigma (SVGA)
 DB indexProcSetVidModeSTBPrim       ;vnSTB: STB (SVGA)
 DB indexProcSetVidModeSTBPrim       ;vnSTBVGAEM16Plus: STB VGA/EM-16 Plus (SVGA)
 DB indexProcSetVidModeTatungVGAPrim ;vnTatungVGA: Tatung VGA (SVGA)
 DB indSVMTaxan565EGAPrim            ;vnTaxan565EGA: Taxan 565 EGA (Super EGA)
 DB indSVMTecmarVGAADPrim            ;vnTecmarVGAAD: Tecmar VGA/AD (SVGA)
 DB indexProcSetVidModeVGAPrim       ;vnTIGA: TIGA de Texas Instrument
 DB indexProcSetVidModeTridentPrim   ;vnTrident8800BR: Trident 8800BR (SVGA)
 DB indexProcSetVidModeTridentPrim   ;vnTrident8800CS: Trident 8800CS (SVGA)
 DB indexProcSetVidModeTridentPrim   ;vnTrident8900: Trident 8900 (SVGA)
 DB indSVMTsengET4000Prim            ;vnT3000: Tseng ET3000 (SVGA)
 DB indSVMTsengET4000Prim            ;vnT4000: Tseng ET4000 (SVGA)
 DB indSVMTsengET4000HiKrPrim        ;vnT4000HiColor: Tseng ET4000 HiColor (SVGA)
 DB indSVMTsengET4000HiKrPrim        ;vnT4000HiColorSC: Tseng ET4000 HiColor SC (SVGA)
 DB indSVMUltraVisionEGAPrim         ;vnUltraVisionEGA: Ultra Vision EGA (Super EGA)
 DB indexProcSetVidModeVESAPrim      ;vnVESA: VESA
 DB indexProcSetVidModeVGAPrim       ;vnVGA: VGA
 DB indexProcSetVidModeVGAWonderPrim ;vnVGAW: VGA Wonder d'ATI (SVGA)
 DB indexProcSetVidModeVGAWonderPrim ;vnVGAW18800: VGA Wonder d'ATI 18800 (SVGA)
 DB indexProcSetVidModeVGAWonderPrim ;vnVGAW18800_1: VGA Wonder d'ATI 18800-1 (SVGA)
 DB indexProcSetVidModeVGAWonderPrim ;vnVGAW28800_2: VGA Wonder d'ATI 28800-2 (SVGA)
 DB indexProcSetVidModeVGAWonderPrim ;vnVGAW28800_4: VGA Wonder d'ATI 28800-4 (SVGA)
 DB indexProcSetVidModeVGAWonderPrim ;vnVGAW28800_5: VGA Wonder d'ATI 28800-5 (SVGA)
 DB indexProcSetVidModeVideo7Prim    ;vnV7: Video 7 (SVGA)
 DB indexProcSetVidModeVideo7Prim    ;vnV7Vram: Video 7 Vram (SVGA)
 DB indexProcSetVidModeVideo7Prim    ;vnV7Vega: Video 7 Vega (SVGA)
 DB indexProcSetVidModeVideo7Prim    ;vnV7Ver5: Video 7 Version 5 (SVGA)
 DB indexProcSetVidModeVideo7Prim    ;vnV71024i: Video 7 1024i (SVGA)
 DB indexProcSetVidModeVGAWonderPrim ;vnVIP: ATI VIP (SVGA)
 DB indexProcSetVidModeXGA           ;vnXGA: XGA (SVGA)
 DB indexProcSetVidModeVGAPrim       ;vnZymos: Zymos (SVGA)
 DB indexProcSetVidModeVGAPrim       ;vnZymosPoach: Zymos Poach (SVGA)
 DB indexProcSetVidModeVESAPrim      ;vnMatrox
 DB indexProcSetVidModeVESAPrim      ;vnMatroxMystique
 DB indexProcSetVidModeVESAPrim      ;vnMatroxMillenium
 DB indexProcSetVidModeVESAPrim      ;vnMatroxG200

; ParamŠtre
; ÍÍÍÍÍÍÍÍÍ
;
;  AL = Num‚ro d'interruption

IntExist Proc Near
 XOR CX,CX
 TEST Jump.Jumper.FlgMethod,flgProtectedMode
 JZ  xInt
 MOV AH,035h
 INT 021h
 JMP TstInt
xInt:
 XCHG AX,BX
 MOV BH,0
 SHL BX,1
 SHL BX,1
 XOR AX,AX
 MOV ES,AX
 LES BX,ES:[BX]
TstInt:
 MOV AX,ES
 OR  AX,BX
 JZ  NoInt
 CMP Byte Ptr ES:[BX],0CFh ; Pour les hypocrites d'interruption miroir, quand
 JE  NoInt                 ; elles sont bidon, elles pointent sur un IRET!
 MOV CL,1
NoInt:
 XCHG AX,CX
 OR  AL,AL
EndProc

; ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
;          Donn‚e temporaire pour la d‚tection des cartes vid‚o
; ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
_PS2       DW 0
CardID     DW 0
CurrPort   DW 0
Pass       DW 0
Slot       DB 0
A          DB 0
AheadSignature      DB 'AHEAD'
ATISignature        DB '76129552'
EMMSignature        DB 'EMMXXXX'
ITVGA2Signature     DB 'IT - VGA2'
LogitechSignature   DB 'LOGITECH'
MatroxSignature     DB 'MATROX'
MatroxMystiqueSign  DB 'MYSTIQUE '
MatroxMilleniumSign DB 'MILLENIUM'
MatroxG200Sign      DB 'G200     '
MicrosoftSignature  DB 'Microsoft'
ParadiseSignature   DB 'VGA='
QEMMSignature       DB 'QEMM'
ZNixSignature       DB 'Z-NIX'

; ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
;                         Proc‚dure _GetVideoCard
; ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
;
; Description
; ÍÍÍÍÍÍÍÍÍÍÍ
;
;  Cette proc‚dure  permet  de connaŒtre  l'existante  de(s)  carte(s) vid‚o
; install‚  sur  cette  machine.  Elle  retourne  ensuite  le  fruit  de ses
; connaissances dans les tampons ®Info1¯ (vid‚o primaire)  et ®Info2¯ (vid‚o
; secondaire).  Il supporte ‚galement  un  paramŠtre  ®ChkSVGA¯  devant  lui
; permettre d'adapter cette proc‚dure  aux cartes vid‚o Super VGA totalement
; incompatible ou si vous pr‚f‚rez enfant … problŠme. Voici sa construction:
; ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
; ³ 7 6 5 4 3 2 1 0      ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿                                 ³
; ³ÚÄÂÄÂÄÂÄÂÄÂÄÂÄÂÄ¿     ³ C h k S V G A ³                                 ³
; ³³ ³ ³ ³ ³ ³ ³ ³ ³     ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ                                 ³
; ³ÀÂÁÂÁÂÁÂÁÂÁÂÁÂÁÂÙ                                                       ³
; ³ ³ ³ ³ ³ ³ ³ ³ À> 1=D‚tecte les cartes Super VGA (Tseng, Trident, Ahead,³
; ³ ³ ³ ³ ³ ³ ³ ³      ATI, Genoa, Oak, Paradise,...).                     ³
; ³ ³ ³ ³ ³ ³ ³ ³    0=Ne d‚tecte pas ces cartes!                          ³
; ³ ³ ÀÄÁÄÁÄÁÄÁÄÁÄÄ> R‚serv‚s (mettre les valeurs que vous trouvez les plus³
; ³ ³                jolies!!!)                                            ³
; ³ ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄ> 0=D‚tecte la norme VESA (il s'agit bien de 0).        ³
; ³                  1=Ne d‚tecte pas la norme VESA.                       ³
; ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
;
; Remarques
; ÍÍÍÍÍÍÍÍÍ
;  þ Cette  fonction  doit normalement ˆtre d‚truit automatiquement aprŠs un
;    chargement  de  pilote vid‚o  par  l'interm‚daire  de l'unit‚ justement
;    Vid‚o. Un scratch peu donc ˆtre provoqu‚ par une mauvaise manipulation.
;  þ Cette fonction doit obligatoirement fonctionner  en mode r‚el!  Il  est
;    totalement impensable de la faire fonctionner en mode prot‚g‚ ormi peut
;    ˆtre en mode Flat avec quelque menu ajustement...
;  þ Cette  fonction  une am‚lioration  de la proc‚dure ®GetVideoCard¯ de la
;    BibliothŠque RLL ®Magician¯.

;VesaHeader DB 256 DUP (?)
D          DW ?

_GetVideoCard Proc Pascal Far
 CLD
; LES DI,Info1
 PUSH CS
 POP ES
 MOV DI,adrPhysVideo

 MOV CX,TYPE PIV
 MOV AL,0
 PUSH DI
  PUSH CX
   REP STOSB
  POP CX
 POP DI
 MOV ES:[DI].PIV.ProcSelBnkPg,indexProcSelBnkPgRet
  ; BiosGetVideoCard
 PUSH ES
  PUSH DI
;    LES DI,Info2
   PUSH CS
   POP ES
   MOV DI,Offset CardSec


   PUSH DI
    REP STOSB
   POP DI
   MOV ES:[DI].PIV.ProcSelBnkPg,indexProcSelBnkPgRet
   MOV AH,1Ah
   INT 10h
  POP DI
  XOR DX,DX
  MOV ES,DX
  MOV CX,ES:[463h]
  MOV CurrPort,CX
 POP ES
 MOV Pass,DX
 MOV _PS2,BX
 CMP AL,1Ah
 JNE @@Default
@@RePass:
 AND BX,000Fh
 SHL BX,1
 JMP Word Ptr CS:[Offset @PS2Jmp+BX]
@PS2Jmp:
 DW Offset @@NoEGAExist       ; 0h
 DW Offset @@Default          ; 1h
 DW Offset @@Default          ; 2h
 DW Offset @@Default          ; 3h
 DW Offset @@EgaDefault       ; 4h
 DW Offset @@EgaDefault       ; 5h
 DW Offset @@PGA              ; 6h
 DW Offset @@VGAPS2           ; 7h
 DW Offset @@VGAPS2           ; 8h
 DW Offset @@Default          ; 9h
 DW Offset @@MCGADigitalColor ; Ah
 DW Offset @@MCGAAnalogMono   ; Bh
 DW Offset @@MCGAPS2          ; Ch
 DW Offset @@Default          ; Dh
 DW Offset @@Default          ; Eh
 DW Offset @@Default          ; Fh
  ; Option par d‚faut
@@Default:
 PUSH ES
  MOV AX,0FFFFh
  MOV ES,AX
  MOV CL,ES:[0Eh]
 POP ES
 CMP CL,253
 JNE @@NoPCJunior
 MOV BL,vnPCJr
 JMP @@SetCardNExit
@@NoPCJunior:
 CMP BH,3
 JA  @@NoEGAExist
@@EgaDefault:
 MOV AH,12h
 MOV BL,10h
 PUSH ES
  PUSH DI
   INT 10h
  POP DI
 POP ES
 CMP BL,10h
 JE  @@NoEGAExist
 INC BL
 MOV Byte Ptr ES:[DI].PIV.Memory[2],BL
 MOV CL,Ya
 MOV Byte Ptr ES:[DI].PIV.Seg16C[1],0A0h
 MOV ES:[DI].PIV.CardCat,cvnEGA
 MOV ES:[DI].PIV.EGA,CL
 MOV ES:[DI].PIV.Font,CL
 MOV ES:[DI].PIV.Palette,CL
 MOV ES:[DI].PIV.BBlink,CL
 MOV ES:[DI].PIV.DacBits,2
 MOV AX,CurrPort
 CMP AX,3D4h
 JNE @@EgaNotModifiedColor
 MOV CL,No
@@EgaNotModifiedColor:
 MOV ES:[DI].PIV.Color,CL
 MOV DX,0C000h
 PUSH ES
  MOV ES,DX
  MOV BX,ES:[0]
 POP ES
 CMP BX,0AA55h
 JE  @@EGABios3
 XOR DX,DX
@@EGABios3:
 MOV ES:[DI].PIV.Rom,DX
 PUSH ES
  MOV CH,vnEGA
  MOV ES,DX
  CMP Word Ptr ES:[31h],'7'+('6'shl 8)
  JNE @@EGANoATISign2
  CMP Word Ptr ES:[33h],'1'+('2'shl 8)
  JNE @@EGANoATISign2
  CMP Word Ptr ES:[35h],'9'+('5'shl 8)
  JNE @@EGANoATISign2
  CMP Word Ptr ES:[37h],'5'+('2'shl 8)
  JNE @@EGANoATISign2
  MOV CH,vnEGAW800
  MOV CL,ES:[43h]
@@EGANoATISign2:
 POP ES
 CMP CH,vnEGAW800
 JNE @@SkipEGAWonder800Plus2
 MOV ES:[DI].PIV.ProcSelBnkPg,indexProcSelBnkPgATI
 CMP CL,'1'
 JE  @@EGAWonder800Plus2
 CMP CL,'2'
 JE  @@EGAWonder800Plus2
 CMP CL,'3'
 JE  @@EGAWonder800Plus2
 CMP CL,'4'
 JE  @@EGAWonder800Plus2
 CMP CL,'5'
 JNE @@SkipEGAWonder800Plus2
@@EGAWonder800Plus2:
 SUB CL,Byte('1')-1
 ADD CH,CL
@@SkipEGAWonder800Plus2:
 MOV BL,CH
 JMP @@SetCardNExit
@@NoEGAExist:
 MOV AX,3000h
 XOR CX,CX
 XOR DX,DX
 PUSH ES
  PUSH DI
   INT 10h
  POP DI
 POP ES
 OR  CX,DX
 JCXZ @@ColorAdaptor
  ;?????????????????????????????????????????????????????????????????????????
  ;??                            P C 3 2 7 0                              ??
  ;?????????????????????????????????????????????????????????????????????????
 MOV ES:[DI].PIV.CardCat,cvnHGC
 MOV Byte Ptr ES:[DI].PIV.Memory[2],1 ;64 Ko
 MOV AX,3000h
 XOR CX,CX
 XOR DX,DX
 PUSH ES
  PUSH DI
   INT 10h
  POP DI
  MOV ES,CX
  MOV BX,DX
  MOV CL,ES:[BX].PC3270Info.MonitorType
  MOV CH,ES:[BX].PC3270Info.Flags1
 POP ES
 MOV BX,vnPC3270+(mnMDA shl 8)
 CMP CL,1
 JE  @@Set1
 CMP CL,3
 JE  @@Set3
 CMP CL,4
 JE  @@Set4
 CMP CL,5
 JNE @@EndSet
@@Set4: ; Set4 et Set5...
 MOV BX,vnPC3270GX+(mn5379C01 shl 8)
 JMP @@EndSet
@@Set1:
 MOV BH,mn3295
 JMP @@EndSet
@@Set3:
 MOV BX,vnPC3270G+(mn5279 shl 8);
@@EndSet:
 MOV ES:[DI].PIV.Monitor,BH
 TEST CH,2
 JZ  @@No128K
 MOV Byte Ptr ES:[DI].PIV.Memory[2],2
@@No128K:
 JMP @@SetCardNExit
@@ColorAdaptor:
 MOV DX,3B4h
 MOV AX,CurrPort
 CMP AX,DX
 JNE @@CheckColor
 MOV AL,0Ah
 OUT DX,AL
 INC DX
 IN  AL,DX
 MOV AH,AL
 MOV AL,4Fh
 OUT DX,AL
 MOV CX,100h
@@Wait:
 LOOP @@Wait
 IN  AL,DX
 XCHG AL,AH
 OUT DX,AL
 CMP AH,4Fh
 JNE @@EndPS2
 MOV BL,vnMDA
 MOV CX,8000h
 MOV DL,0BAh
 IN  AL,DX
 AND AL,80h
 MOV AH,AL
@@CheckHGC:
 IN  AL,DX
 AND AL,80h
 CMP AL,AH
 JNE @@HGCExist
 LOOP @@CheckHGC
 MOV Byte Ptr ES:[DI].PIV.Memory[1],10h ;4 Ko
 JMP @@NoHGC
@@HGCExist:
 MOV BL,vnHercule
 MOV ES:[DI].PIV.CardCat,cvnHGC
 MOV ES:[DI].PIV.Monitor,mnMDA
 MOV Byte Ptr ES:[DI].PIV.Memory[2],1;64 Ko
 MOV ES:[DI].PIV.VideoBits,8
@@NoHGC:
 JMP @@SetCardNExit
@@CheckColor:
 MOV DL,0D4h
 CMP AX,DX
 JNE @@EndPS2
 MOV ES:[DI].PIV.CardCat,cvnCGA
 MOV ES:[DI].PIV.Monitor,mnCGA
 MOV ES:[DI].PIV.Color,Ya
 MOV ES:[DI].PIV.VideoBits,8
 PUSH ES
  XOR AX,AX
  MOV ES,AX
  MOV AX,ES:[46Ch]
@@NotAlreadyHot:
  MOV SI,ES:[46Ch]
  CMP SI,AX
  JE  @@NotAlreadyHot
  MOV DX,3DAh
;  MOV DX,ES:[463h]
;  ADD DX,6
  XOR CX,CX
@@OtherWhile:
@@RepeatEqual:
  CMP SI,ES:[46Ch]
  JE  @r1
  IN  AL,DX
  TEST AL,8
  JZ  @@RepeatEqual
@@RepeatNotEqual:
  CMP SI,ES:[46Ch]
  JNE  @r1
  IN  AL,DX
  TEST AL,8
  JNZ @@RepeatNotEqual
  INC CX
@r1:
  MOV AX,ES:[46Ch]
  SUB AX,SI
  CMP AX,18
  JBE @@OtherWhile
 POP ES
 MOV DX,CX
 SUB CX,50
 JBE @@ModeMono
 MOV CX,DX
 SUB CX,60
 JNBE @@16Ko
 MOV BX,mnCGA+(Ya shl 8)
 JMP @@SetGS
@@16Ko:
 MOV Byte Ptr ES:[DI].PIV.Memory[1],40h
 MOV BL,vnCGA
 JMP @@SetCardNExit
@@ModeMono:
 MOV BX,mnMDA+(No shl 8)
@@SetGS:
 MOV ES:[DI].PIV.Monitor,BL
 MOV BX,vnGS+(Ya shl 8)
 MOV Byte Ptr ES:[DI].PIV.Memory[2],BH
 MOV Byte Ptr ES:[DI].PIV.Seg16C[1],0B0h
 MOV ES:[DI].PIV.VideoBits,8
 JMP @@SetColorCardNExit
  ;?????????????????????????????????????????????????????????????????????????
  ;??                        M C G A  du  P S / 2                         ??
  ;?????????????????????????????????????????????????????????????????????????
@@MCGADigitalColor:
 MOV CL,mnDigitalKr
 JMP @@MCGASetMonitor
@@MCGAPS2:
 MOV CL,mnAnalogKr
 JMP @@MCGASetMonitor
@@MCGAAnalogMono:
 MOV CL,mnAnalogMono
 JMP @@MCGASetMonitor
@@MCGASetMonitor:
 MOV ES:[DI].PIV.Monitor,CL
 MOV AH,12h
 MOV BL,10h
 PUSH ES
  PUSH DI
   INT 10h
  POP DI
 POP ES
 CMP BL,10h
 JE  @@NoMemIndication
 INC BL
 MOV Byte Ptr ES:[DI].PIV.Memory[2],BL
@@NoMemIndication:
 MOV BX,vnMCGA+(Ya shl 8)
 MOV Byte Ptr ES:[DI].PIV.Seg16C[1],0A0h
 MOV Byte Ptr ES:[DI].PIV.Rom[1],0C0h
 MOV ES:[DI].PIV.DacBits,6
 MOV ES:[DI].PIV.CardCat,cvnVGA
 JMP @@SetDefaultCardWithBios
  ;?????????????????????????????????????????????????????????????????????????
  ;??                               P G A                                 ??
  ;?????????????????????????????????????????????????????????????????????????
PGA Label Near
@@PGA:
 MOV ES:[DI].PIV.CardCat,cvnVGA
 MOV BX,vnPGA+(Ya shl 8);
@@SetDefaultCardWithBios:
 MOV ES:[DI].PIV.ProcSelBnkPg,indexProcSelBnkPgVGA
 MOV ES:[DI].PIV.EGA,BH     ; Ya
 MOV ES:[DI].PIV.Font,BH    ; Ya
 MOV ES:[DI].PIV.Palette,BH ; Ya
 MOV ES:[DI].PIV.BBlink,BH  ; Ya
@@SetColorCardNExit:
 MOV ES:[DI].PIV.Color,BH   ; Ya
 JMP @@SetCardNExit
  ;?????????????????????????????????????????????????????????????????????????
  ;??                               V G A                                 ??
  ;?????????????????????????????????????????????????????????????????????????
@@VGAPS2:
 MOV CX,(mnAnalogMono shl 8)+Ya
 CMP BL,7
 JE  @@AnalogMono
 MOV CH,mnAnalogKr
@@AnalogMono:
 CLD
 PUSH DI
  MOV AL,vnVGA    ; C'est pour l'instant une carte VGA...
  MOV AH,CH       ; Code du Moniteur se trouve dans CH … l'origine
  STOSW           ; Card & Monitor
  MOV AL,cvnVGA
  STOSB           ; CardCat
  INC DI          ; Memory[0]
  INC DI          ; Memory[1]
  MOV AL,4        ; 256 Ko
  STOSB           ; Memory[2]
  INC DI          ; Memory[3]
  MOV AL,CL       ; Ya
  STOSB           ; Font
  INC DI          ; Hercule
  MOV AX,0A000h
  STOSW           ; Seg16C
  MOV AL,CL       ; Ya
  STOSB           ; Palette
  STOSB           ; Color
  STOSB           ; BBlink
  STOSB           ; EGA
  STOSB           ; VGA
  STOSB           ; VGA320x400
 POP DI
 MOV Byte Ptr ES:[DI].PIV.Rom[1],0C0h
 MOV ES:[DI].PIV.DacBits,6
 MOV ES:[DI].PIV.ProcSelBnkPg,indexProcSelBnkPgVGA
 TEST DS:CheckSVGA,80h
 JNZ @@EndPS2
 TEST DS:CheckSVGA,1
 JZ  @@Vesa
  ;?????????????????????????????????????????????????????????????????????????
  ;??                                A T I                                ??
  ;?????????????????????????????????????????????????????????????????????????
 MOV AL,vnVGA
 MOV CX,8
 MOV BX,31h
 MOV SI,Offset ATISignature
 CALL @CompareROM
 JNZ @@NoATISign
 MOV AL,vnVGAW
@@NoATISign:
 MOV CH,AL
 CMP CH,vnVGA
 JE  @@CheckXGA
 JMP @Next1
  ; Compare ROM Video:SI avec Signature de pilote Video:BX, longueur CX
@CompareROM Proc Near
 PUSH ES
  MOV ES,ES:[DI].PIV.Rom
  CMP Word Ptr ES:[0],0AA55h
  JNE @NoRom4Video
  PUSH DI
   PUSH DS
    PUSH CS
    POP DS
    MOV DI,BX
    CLD
    REPZ CMPSB
   POP DS
  POP DI
@NoROM4Video:
 POP ES
 RETN
endp
@Next1:
 PUSH ES
  MOV ES,ES:[DI].PIV.Rom
  CMP Word Ptr ES:[40h],('3')+('1'shl 8)
  JNE @@SkipWPlus
  MOV CL,ES:[43h]
  JNE @@SkipWPlus
  CMP CL,'1'
  JE  @@WPlus
  CMP CL,'2'
  JE  @@WPlus
  CMP CL,'3'
  JE  @@WPlus
  CMP CL,'4'
  JE  @@WPlus
  CMP CL,'5'
  JNE @@WPlus
@@WPlus:
  SUB CL,Byte('1')-1
  ADD CH,CL
@@SkipWPlus:
 POP ES
 MOV ES:[DI].PIV.Card,CH
 MOV SI,ES:[DI].PIV.Rom
 PUSH ES
  MOV ES,SI
  MOV CH,ES:[42h]
  MOV DX,ES:[10h]
 POP ES
 MOV AL,0BBh
 CLI
 OUT DX,AL
 INC DX
 IN  AL,DX
 STI
 AND AL,0Fh
 MOV A,AL
 MOV CL,No
 TEST CH,10h
 JZ @@ATINoPVC
 MOV CL,Ya
@@ATINoPVC:
 MOV ES:[DI].PIV.PVC,CL
 MOV CL,No
 TEST CH,2
 JZ @@ATIMousePort
 MOV CL,Ya
@@ATIMousePort:
 MOV ES:[DI].PIV.MousePort,CL
 MOV BL,A
 AND BX,0Fh
 MOV BL,Byte Ptr CS:[Offset @MonitorATI+BX]
 MOV ES:[DI].PIV.Monitor,BL
 PUSH ES
  MOV ES,SI
  MOV CL,ES:[43h]
  MOV DX,ES:[10h]
 POP ES
 CMP CL,'1'
 JE  @@AtiMem2
 CMP CL,'2'
 JE  @@AtiMem2
  ; AtiMem1
 MOV AL,0B0h
 CLI
 OUT DX,AL
 INC DX
 IN  AL,DX
 STI
 TEST AL,20h
 JZ  @@X2NoATI512Kb
 MOV Byte Ptr ES:[DI].PIV.Memory[2],8 ; 512 Ko
 MOV ES:[DI].PIV.CardCat,cvnSVGA
@@X2NoATI512Kb:
 PUSH ES
  MOV ES,SI
  MOV CL,ES:[43h]
 POP ES
 CMP CL,'3'
 JE  @@DontHave1Mb
 TEST A,8
 JZ  @@DontHave1Mb
 MOV Byte Ptr ES:[DI].PIV.Memory[2],16 ; 1 Mo
 MOV ES:[DI].PIV.CardCat,cvnSVGA
@@DontHave1Mb:
 MOV SI,indexProcSelBnkPgATI
 JMP @@SetBnkPgOnly
@MonitorATI:
 DB mnEGA                   ; 0
 DB mnAnalogMono            ; 1
 DB mnTTLMonochrome         ; 2
 DB mnAnalogKr              ; 3
 DB mnRGBKr                 ; 4
 DB mnMultiSync             ; 5
 DB mnUnknown               ; 6
 DB mn8514                  ; 7
 DB mnSeiko1430             ; 8
 DB mnMultiSync2A           ; 9
 DB mnTatungOmniScan        ; 10
 DB mnNEC3D                 ; 11
 DB mnTVM3M                 ; 12
 DB mnNECMultiSync          ; 13
 DB mnTVM2A                 ; 14
 DB mnTVM3A                 ; 15
  ; AtiMem1
@@AtiMem2:
 MOV AL,0BBh
 CLI
 OUT DX,AL
 INC DX
 IN  AL,DX
 STI
 TEST AL,20h
 JZ  @@EndAtiMem
 MOV Byte Ptr ES:[DI].PIV.Memory[2],8 ; 512 Ko
 MOV ES:[DI].PIV.CardCat,cvnSVGA
@@EndAtiMem:
 JMP @@Vesa
  ;?????????????????????????????????????????????????????????????????????????
  ;??                                X G A                                ??
  ;?????????????????????????????????????????????????????????????????????????
@@CheckXGA:
 PUSH ES
  PUSH DI
   ChkXGA       ; Appel la macro ChkXGA
  POP DI
 POP ES
 JC  @Next2
 JMP @@EndXGA
@Next2:
 XOR BX,BX
 MOV DX,Word Ptr D
@@RepeatXGA:
 CLI
 CMP BL,0
 JNE @@WNext
 MOV AL,0DFh
 OUT 94h,AL
 JMP @@WEnd
@@WNext:
 MOV AX,0C401h
 PUSH ES
  PUSH DI
   PUSH BX
    INT 15h
   POP BX
  POP DI
 POP ES
 MOV DX,Word Ptr D
 IN  AX,DX
 MOV CardID,AX
 INC DX
 INC DX
 IN  AL,DX
 INC DX
 IN  AL,DX
 INC DX
 IN  AL,DX
 INC DX
 IN  AL,DX
@@WEnd:
 CMP BL,0
 JNE @@XNext
 MOV AL,0FFh
 OUT 94h,AL
 JMP @@XEnd
@@XNext:
 MOV AX,0C402h
 PUSH ES
  PUSH DI
   PUSH BX
    INT 15h
   POP BX
  POP DI
 POP ES
@@XEnd:
 STI
 MOV AX,CardID
 CMP AX,8FD8h
 JB  @@IncSlot
 CMP AX,8FDBh
 JA  @@IncSlot
 AND DL,0Eh
 SHL DL,1
 SHL DL,1
 SHL DL,1
 MOV DH,21h
 MOV Word Ptr D,DX
 ADD DX,0Ah
 MOV AL,52h
 OUT DX,AL
 INC DX
 IN  AL,DX
 AND AL,0Fh
 JZ  @@IncSlot
 CMP AL,0Fh
 JNE @@XGAFound
@@IncSlot:
 INC BX
 CMP BL,9
 JA  @@EndXGA
 JMP @@RepeatXGA
@@XGAFound:
 TEST DX,1
 JZ @@EndXGA
 MOV BL,vnXGA
 MOV ES:[DI].PIV.CardCat,cvnSvga
 MOV Byte Ptr ES:[DI].PIV.Memory[2],16
 JMP @@SetCardNExit
@@EndXGA:
  ;?????????????????????????????????????????????????????????????????????????
  ;??                            V i d e o  7                             ??
  ;?????????????????????????????????????????????????????????????????????????
 MOV DX,CurrPort
 MOV AL,0Ch
 OUT DX,AL ; 3?4h
 INC DX
 IN  AL,DX ; 3?5h
 MOV CL,AL
 MOV AL,55h
 OUT DX,AL ; 3?5h
 IN  AL,DX ; 3?5h
 DEC DX
 MOV AL,1Fh
 OUT DX,AL ; 3?4h
 INC DX
 IN  AL,DX ; 3?5h
 MOV CH,AL
 DEC DX
 MOV AL,0Ch
 OUT DX,AL ; 3?4h
 INC DX
 MOV AL,CL
 OUT DX,AL ; 3?5h
 CMP CH,(55h xor 0EAh)
 JNE @@CheckAhead
 MOV BL,vnV7
 MOV DL,0C4h
 MOV AL,8Eh
 OUT DX,AL ; 3C4h
 INC DX
 IN  AL,DX ; 3C5h
 TEST AL,80h
 JNZ @@V7Vega
 TEST AL,20h
 JNZ @@V7Vram
 TEST AL,10h
 JNZ @@V7Ver5
 TEST AL,40h
 JZ  @@NormalV7
 MOV BL,vnV71024i
 JMP @@NormalV7
@@V7Ver5:
 MOV BL,vnV7Ver5
 JMP @@NormalV7
@@V7Vram:
 PUSH ES
  PUSH DI
   V7VRam ; Appel la macro V7VRam
  POP DI
 POP ES
 JNC @@NormalV7
 MOV BL,vnV7Vram
 JMP @@NormalV7
@@V7Vega:
 MOV BL,vnV7Vega
@@NormalV7:
 MOV ES:[DI].PIV.Card,BL
 MOV DX,3C4h
 MOV AL,8Eh
 OUT DX,AX
 INC DX
 IN  AL,DX
 DEC DX
 MOV AL,0FFh
 OUT DX,AL
 INC DX
 IN  AL,DX
 MOV AX,6F07h
 PUSH ES
  PUSH DI
   INT 10h
  POP DI
 POP ES
 CMP AL,6Fh
 JE  @@SetMemV7
 SHL AH,1
 SHL AH,1
 MOV Byte Ptr ES:[DI].PIV.Memory[2],AH
@@SetMemV7:
 MOV SI,indexProcSelBnkPgVideo7
 JMP @@SetBnkPgOnly
  ;?????????????????????????????????????????????????????????????????????????
  ;??                             A h e a d                               ??
  ;?????????????????????????????????????????????????????????????????????????
@@CheckAhead:
 MOV BH,vnVGA
 PUSH BX
  MOV BX,25h
  MOV SI,Offset AheadSignature
  MOV CX,5
  CALL @CompareROM
 POP BX
 JNZ @@EndTestAhead
 MOV BH,vnAhead
@@EndTestAhead:
 CMP BH,vnVGA
 JE  @@CheckGenoa
 MOV SI,indexProcSelBnkPgAhead
 JMP @@SetCardNBnkPg
  ;?????????????????????????????????????????????????????????????????????????
  ;??                               G e n o a                             ??
  ;?????????????????????????????????????????????????????????????????????????
@@CheckGenoa:
 MOV BL,vnVGA
 PUSH ES
  CMP Word Ptr ES:[0],0AA55h
  JNE @@EndGenoaCheck
  CMP Byte Ptr ES:[37h],77h
  JNE @@EndGenoaCheck
  CMP Word Ptr ES:[39h],6699h
  JNE @@EndGenoaCheck
  MOV BL,vnGenoa
@@EndGenoaCheck:
 POP ES
 CMP BH,vnVGA
 JE  @@CheckTseng ; @@CheckCirrus
 PUSH ES
  MOV ES,ES:[DI].PIV.Rom
  MOV SI,ES:[38h]
  MOV CL,ES:[SI]
 POP ES
 MOV CH,0
 JCXZ @@SetGenoa6200
 CMP CL,11h
 JE  @@SetGenoa6400
 CMP CL,22h
 JE  @@SetGenoa6100
 CMP CL,33h
 JE  @@SetGenoa5100
 MOV BH,vnGenoa5300
 JMP @@EndTstGenoa
@@SetGenoa5100:
 MOV BH,vnGenoa5100
 JMP @@EndTstGenoa
@@SetGenoa6100:
 MOV BH,vnGenoa6100
 JMP @@EndTstGenoa
@@SetGenoa6400:
 MOV BH,vnGenoa6400
 JMP @@EndTstGenoa
@@SetGenoa6200:
 MOV BH,vnGenoa6200
@@EndTstGenoa:
 MOV DX,3C4h
 MOV AL,7
 OUT DX,AL
 INC DX
 IN  AL,DX
 TEST AL,20h
 JZ  @@Analog
 MOV BL,mnDigitalTTL
 JMP @@EndGenoaMonitor
@@Analog:
 MOV BL,mnAnalog
@@EndGenoaMonitor:
 MOV ES:[DI].PIV.Monitor,BL
 MOV SI,indexProcSelBnkPgGenoa
 JMP @@SetCardNBnkPg
  ;?????????????????????????????????????????????????????????????????????????
  ;??                        T s e n g  L a b s                           ??
  ;?????????????????????????????????????????????????????????????????????????
@@CheckTseng:
 MOV DX,3CDh
 IN  AL,DX ; 3CDh
 MOV AH,AL
 AND AL,0C0h
 OR  AL,55h
 OUT DX,AL ; 3CDh
 IN  AL,DX ; 3CDh
 CMP AL,55h
 JNE @@CheckZyMos
 MOV AL,0AAh
 OUT DX,AL ; 3CDh
 IN  AL,DX ; 3CDh
 CMP AL,0AAh
 JNE @@CheckZyMos
  ; C'est une carte Tseng Labs
 MOV AL,AH
 OUT DX,AL ; 3CDh
 MOV ES:[DI].PIV.Card,vnT3000 ; Tseng ET3000
 MOV DX,CurrPort
 MOV AL,33h
 OUT DX,AL ; 3?4h
 INC DX
 IN  AL,DX ; 3?5h
 PUSH AX
  XOR AL,0Fh
  MOV BH,AL
  OUT DX,AL ; 3?5h
  IN  AL,DX ; 3?5h
  MOV BL,AL
 POP AX
 OUT DX,AL
 MOV SI,indexProcSelBnkPgTsengET3000
 CMP BL,BH
 JNE @@SkipTsengET4000
 MOV ES:[DI].PIV.Card,vnT4000 ; Tseng ET4000
 XOR AX,AX
 MOV DX,3D4h
 CMP Byte Ptr _PS2[1],AL
 JE  @@1CardTseng
 CMP CurrPort,DX
 JE  @@Color
 MOV DL,0BFh
 MOV AL,3
 JMP @@SetOutTseng
@@Color:
 MOV DL,0D8h
 MOV AL,0A0h
 JMP @@SetOutTseng
@@1CardTseng:
 MOV DL,0BFh
 MOV AL,3
 OUT DX,AL ; 3BFh
 MOV DL,0D8h ; 3D8h
 MOV AL,0A0h
@@SetOutTseng:
 OUT DX,AL
@@End1CardTseng:
 MOV AX,10F1h
 MOV BL,0
 PUSH ES
  PUSH DI
   INT 10h
  POP DI
 POP ES
 CMP AL,10h
 JE  @@FuncNotSupport
 CMP BL,0
 JE  @@FuncNotSupport
 CMP BL,0FFh
 MOV BH,vnT4000HiColorSC
 CMP BL,1
 JE  @@SetHiColor
 MOV BH,vnT4000HiColor
@@SetHiColor:
 MOV ES:[DI].PIV.Card,BH
@@FuncNotSupport:
 XOR AX,AX
 CMP CurrPort,3B4h
 JNE @@SkipMDA
 MOV DX,3BFh
 MOV AL,1
 OUT DX,AL
@@SkipMDA:
 MOV DX,CurrPort
 MOV AL,37h
 OUT DX,AL ; 3?4h
 INC DX;
 IN  AL,DX ; 3?5h
 MOV A,AL
 TEST AL,8
 JZ  @@NoMem
 AND AL,3
 CMP AL,2
 JB  @@NoMem
 TEST AL,2
 JZ @@Tseng512K
 MOV AL,16
 JMP @@TsengSetMem
@@Tseng512K:
 MOV AL,8
@@TsengSetMem:
 MOV Byte Ptr ES:[DI].PIV.Memory[2],AL
 MOV ES:[DI].PIV.CardCat,cvnSvga
 ;??????????????????????????????????????????????????????????????????????????
 ;??                            I T - V G A 2                             ??
 ;??????????????????????????????????????????????????????????????????????????
@@NoMem:
 MOV BL,ES:[DI].PIV.Card
 PUSH BX
  MOV BX,181h
  MOV CX,9
  MOV SI,Offset ITVGA2Signature
  CALL @CompareROM
 POP BX
 JNZ @@NoITVGA2
 MOV BL,vnITVGA2
@@NoITVGA2:
 MOV ES:[DI].PIV.Card,BL
  ; RomBits
 MOV BL,8
 TEST A,10h
 JZ  @@Rom8Bits
 MOV BL,16
@@Rom8Bits:
 MOV ES:[DI].PIV.RomBits,BL
  ; Reset Port
 DEC DX
 MOV AL,36h
 OUT DX,AL ; 3?4h
  ; VideoBits
 MOV BL,8
 INC DX ; 3?5h
 IN  AL,DX
 TEST AL,40h
 JZ  @@Video8Bits
 MOV BL,16
@@Video8Bits:
 MOV ES:[DI].PIV.VideoBits,BL
  ; Reset Port
 MOV DL,0C4h ; 3C4h
 MOV AL,7
 OUT DX,AL
 INC DX
 IN  AL,DX ; 3C5h
 MOV SI,indexProcSelBnkPgTsengET4000
@@SkipTsengET4000:
 JMP @@SetBnkPgOnly
  ;?????????????????????????????????????????????????????????????????????????
  ;??                             C i r r u s                             ??
  ;?????????????????????????????????????????????????????????????????????????
@@CheckCirrus:
 MOV DX,CurrPort
 MOV AL,0Ch
 OUT DX,AL ; 3?4h
 INC DX
 MOV AH,AL
 IN  AL,DX ; 3?5h
 XCHG AH,AL
 PUSH AX
  PUSH DX
   XOR AL,AL
   OUT DX,AL ; 3?5h
   DEC DX
   MOV AL,1Fh
   OUT DX,AL ; 3?4h
   INC DX
   IN  AL,DX ; 3?5h
   MOV AH,AL
   MOV BH,AL
   MOV CH,CL
   MOV CL,4
   MOV DL,0C4h
   MOV BL,6
   ROR BH,CL
   MOV AX,BX
   OUT DX,AL ; 3C4h
   INC DX
   IN  AL,DX ; 3C5h
   OR  AL,AL
   JNZ @@ExitCirrus
   MOV BH,AL
   DEC DX
   MOV AL,6
   OUT DX,AL ; 3C4h
   INC DX
   MOV AL,AH
   IN  AL,DX ; 3C5h
   CMP AL,1
   JNE @@ExitCirrus
   ROR BH,CL
   DEC DX
   MOV AX,BX
   OUT DX,AX ; 3C4h
   INC DX
   IN  AL,DX ; 3C5h
   CMP AL,1
   JNE @@ExitCirrus
  POP DX
  DEC DX
 POP AX
 OUT DX,AX ; 3?4h
 MOV CL,0
 JCXZ @@CheckCTI
 MOV AH,12h
 MOV BL,85h
 PUSH ES
  PUSH DI
   INT 10h
  POP DI
 POP ES
 MOV Byte Ptr ES:[DI].PIV.Memory[2],AL
 MOV SI,indexProcSelBnkPgCirrus
 MOV BH,vnCirrus
 JMP @@SetCardNBnkPg
@@ExitCirrus:
  POP DX
  DEC DX
 POP AX
 OUT DX,AX ; 3?4h
  ;?????????????????????????????????????????????????????????????????????????
  ;??                                C T I                                ??
  ;?????????????????????????????????????????????????????????????????????????
@@CheckCTI:
 MOV DX,46E8h
 PUSH DX
  IN  AL,DX ; 46E8h
  OR  AL,10h
  OUT DX,AL ; 46E8h
  MOV DX,103h
  IN  AL,DX ; 103h
  OR  AL,80h
  OUT DX,AL ; 103h
  INC DX
  IN  AL,DX ; 104h
  MOV AH,AL
 POP DX
 IN  AL,DX ; 46E8h
 AND AL,3Fh
 OUT DX,AL ; 46E8h
 MOV DX,3D6h
 MOV AL,0
 OUT DX,AL ; 3D6h
 INC DX
 IN  AL,DX ; 3D7h
 CMP AH,5Ah
 JNE @@CheckTrident
 AND AL,0F0h
 SHR AL,1
 SHR AL,1
 SHR AL,1
 SHR AL,1
 CMP AL,2
 JE  @@CheckTrident
 CMP AL,4
 JGE @@CheckTrident
 CMP AL,3
 JE  @@CheckTrident
 MOV AX,5F00h
 PUSH ES
  PUSH DI
   INT 10h
  POP DI
 POP ES
 INC BH
 SHL BH,1
 SHL BH,1
 MOV Byte Ptr ES:[DI].PIV.Memory[2],BH
 AND CL,1
 SHL CL,1
 MOV ES:[DI].PIV.DacBits,CL
 MOV DX,46E8h
 MOV AL,1Eh
 OUT DX,AL ; 46E8h
 PUSH DX
  PUSH DX
   MOV DX,103h
   MOV AL,80h
   OUT DX,AL ; 103h
  POP DX
  MOV AL,0Eh
  OUT DX,AL ; 46E8h
  MOV DX,3D6h
  MOV AL,0
  OUT DX,AL ; 3D6h
  INC DX
  IN  AL,DX ; 3D7h
  AND AL,0F0h
  CMP AL,10h
  JNE @@SkipCTI82
  DEC DX
  MOV AL,3Ah
  OUT DX,AL ; 3D6h
  INC DX
  IN  AL,DX ; 3D7h
  PUSH AX
   MOV AL,0AAh
   OUT DX,AL ; 3D7h
   IN  AL,DX ; 3D7h
   MOV BH,vnCTI82C452
   CMP AL,0AAh
   JE  @@IsCTI82C452
   MOV BH,vnCTI82C451
@@IsCTI82C452:
  POP AX
  OUT DX,AL ; 3D7h
@@SkipCTI82:
 POP DX
 MOV AL,1Eh
 OUT DX,AL ; 46E8h
 PUSH DX
  MOV DX,103h
  MOV AL,80h
  OUT DX,AL ; 103h
 POP DX
 MOV AL,0Eh
 OUT DX,AL ; 46E8h
 MOV DX,3D6h
 MOV AL,0
 OUT DX,AL ; 3D6h
 MOV SI,indexProcSelBnkPgCTI
 JMP @@SetCardNBnkPg
  ;?????????????????????????????????????????????????????????????????????????
  ;??                             T r i d e n t                           ??
  ;?????????????????????????????????????????????????????????????????????????
@@CheckTrident:
 ChkTrident ; Appel le macro ChkTrident
 OR  AL,AL
 JE  @@CheckEverex
 CMP AL,6
 JA  @@CheckEverex
 MOV BH,vnTrident8800BR
 CMP AL,1
 JE  @@SetTridentCard
 MOV BH,vnTrident8800CS
 CMP AL,2
 JE  @@SetTridentCard
 MOV AL,1Fh
 OUT DX,AL
 INC DX
 IN  AL,DX
 AND AL,3
 DEC DX
 CMP AL,0
 JE  @@SkipSetMemTrident
 MOV BL,8
 CMP AL,1
 JE  @@SetNowMemTrident
 MOV BL,16
@@SetNowMemTrident:
 MOV Byte Ptr ES:[DI].PIV.Memory[2],BL
@@SkipSetMemTrident:
 MOV BH,vnTrident8900
@@SetTridentCard:
 MOV AL,0Fh
 OUT DX,AL
 INC DX
 IN  AL,DX
 MOV BL,8
 TEST AL,80h
 JZ  @@TridentRom8Bits
 MOV BL,16
@@TridentRom8Bits:
 MOV ES:[DI].PIV.RomBits,BL
 MOV ES:[DI].PIV.CardCat,cvnSvga
 MOV SI,indexProcSelBnkPgTrident
 JMP @@SetCardNBnkPg
  ;?????????????????????????????????????????????????????????????????????????
  ;??                              E v e r e x                            ??
  ;?????????????????????????????????????????????????????????????????????????
@MonitorEverex:
 DB mnMDA              ; 0
 DB mnCGA              ; 1
 DB mnEGA              ; 2
 DB mnDigitalMultiSync ; 3
 DB mnVGA              ; 4
 DB mn8514             ; 5
 DB mnSuperVGA         ; 6
 DB mnAnalogMultiSync  ; 7
 DB mnSuperMultiSync   ; 8
 DB mnAnalogMultiSync  ; 9  ~ Code sp‚culatif … partir de ce niveau...
 DB mnAnalogMultiSync  ; 10
 DB mnAnalogMultiSync  ; 11
 DB mnAnalogMultiSync  ; 12
 DB mnAnalogMultiSync  ; 13
 DB mnAnalogMultiSync  ; 14
 DB mnAnalogMultiSync  ; 15
@@CheckEverex:
 MOV AX,7000h
 XOR BX,BX
 PUSH ES
  PUSH DI
   INT 10h
  POP DI
 POP ES
 CMP AL,70h
 JNE @@CheckZyMos
 MOV BX,CX
 ADD BX,000Fh
 MOV BL,Byte Ptr CS:[Offset @MonitorEverex+BX]
 MOV ES:[DI].PIV.Monitor,BL
 AND DX,0FFF0h
 MOV BH,vnEverex
 CMP DX,6780h
 JE  @@EverexViewPoint
 CMP DX,6730h
 JE  @@EverexEVGA
 CMP DX,6200h
 JE  @@EverexVision
 CMP DX,2460h
 JNE @@EverexSimple
 MOV BH,vnEverexUG2 ; Everex Ultra Graphics II
 JMP @@EverexSimple
@@EverexViewPoint:
 MOV BH,vnEverexViewPoint
 JMP @@EverexSimple
@@EverexVision:
 MOV BH,vnEverexVision
 JMP @@EverexSimple
@@EverexEVGA:
 MOV BH,vnEverexEVGA
@@EverexSimple:
 ROL CH,1
 ROL CH,1
 AND CH,3
 INC CH
 SHL CH,1
 SHL CH,1
 MOV Byte Ptr ES:[DI].PIV.Memory[2],CH
 MOV ES:[DI].PIV.CardCat,cvnSvga
 MOV SI,indexProcSelBnkPgEverex
 JMP @@SetCardNBnkPg
  ;?????????????????????????????????????????????????????????????????????????
  ;??                              Z y M o s                              ??
  ;?????????????????????????????????????????????????????????????????????????
@@CheckZyMos:
 MOV DX,3D4h
 MOV AL,0Bh
 OUT DX,AL ; 3D4h
 INC DX
 IN  AL,DX ; 3D5h
 AND AL,0Fh
 CMP AL,2
 JNE @@OakCheck
 MOV BH,vnZyMos
 MOV SI,indexProcSelBnkPgZyMos
 JMP @@SetCardNBnkPg
  ;?????????????????????????????????????????????????????????????????????????
  ;??                                 O a k                               ??
  ;?????????????????????????????????????????????????????????????????????????
@@OakCheck:
 MOV DL,0DEh
 MOV AX,0FF11h
 MOV BX,AX
 OUT DX,AL ; 3DEh
 MOV AH,AL
 INC DX
 IN  AL,DX ; 3DFh
 DEC DX
 XCHG AL,AH
 PUSH AX
  MOV AX,BX
  OUT DX,AX ; 3DEh
  OUT DX,AL ; 3DEh
  MOV AH,AL
  INC DX
  IN  AL,DX ; 3DFh
  DEC DX
  AND AL,BH
  CMP AL,BH
  JNE @@NotOak
  MOV AL,AH
  MOV AH,0
  OUT DX,AX ; 3DEh
  OUT DX,AL ; 3DEh
  MOV AH,AL
  INC DX
  IN  AL,DX ; 3DFh
  DEC DX
  AND AL,BH
  CMP AL,0
 POP AX
 JNE @@NotOak
 OUT DX,AX ; 3DEh
 MOV DX,3DEh
 MOV AL,0Dh
 OUT DX,AL ; 3DEh
 JMP @@NextInstr
@@NextInstr:
 INC DX
 IN  AL,DX ; 3DFh
 TEST AL,80h
 JZ  @@NoOakMem
 MOV Byte Ptr ES:[DI].PIV.Memory[2],8
@@NoOakMem:
 MOV SI,indexProcSelBnkPgOak
 MOV BH,vnOak
 JMP @@SetCardNBnkPg
@@NotOak:
 OUT DX,AX ; 3DEh
  ;?????????????????????????????????????????????????????????????????????????
  ;??                            P a r a d i s e                          ??
  ;?????????????????????????????????????????????????????????????????????????
 MOV CX,4
 MOV SI,7Dh
 MOV BX,Offset ParadiseSignature
 CALL @CompareROM
 JNZ  @@Vesa
 MOV DL,0CEh
 MOV AL,0Fh
 OUT DX,AL ; 3CEh
 INC DX
 IN  AL,DX ; 3CFh
 PUSH AX
  MOV AL,05h
  OUT DX,AL ; 3CFh
  MOV DL,0C4h
  MOV AL,07h
  OUT DX,AL  ; 3CFh
  MOV DL,0CCh
  IN  AL,DX ; 3CCh
  AND AL,1
  MOV CL,5
  SHL AL,CL
  MOV AH,03h
  ADD AL,0B4h
  MOV DX,AX ; 3?4h
  MOV SI,AX
  MOV AL,29h
  OUT DX,AL ; 3?4h
  INC DX
  IN  AL,DX ; 3?5h
  PUSH AX
   MOV AL,85h
   OUT DX,AL ; 3?5h
   PUSH DX
    MOV DL,0C4h
    MOV AX,4806h
    OUT DX,AX
   POP DX
   DEC DX ; 3?4h
   MOV AL,2Bh
   OUT DX,AL ; 3?4h
   INC DX
   IN  AL,DX ; 3?5h
   PUSH AX
    MOV AL,0AAh
    OUT DX,AL ; 3?5h
    IN  AL,DX ; 3?5h
    MOV BL,AL
   POP AX
   OUT DX,AL ; 3?5h
   CMP BL,0AAh
   JNE @@Mickeleti
   MOV BH,vnParadisePVGA1A
   JMP @@EndPickotta
@@Mickeleti:
   MOV DL,0C4h ; 3C4h
   MOV AL,12h
   OUT DX,AL ; 3C4h
   INC DX
   IN  AL,DX ; 3C5h
   MOV A,AL
   AND AL,0BFh
   OUT DX,AL ; 3C5h
   IN  AL,DX ; 3C5h
   AND AL,40h
   MOV CL,AL
   MOV CH,0
   MOV AL,A
   JCXZ @@Mika
   OUT DX,AL ; 3C5h
   MOV BH,vnParadiseWD90C00
   JMP @@EndPickotta
@@Mika:
   OR  AL,40h
   OUT DX,AL ; 3C5h
   IN  AL,DX ; 3C5h
   AND AL,40h
   MOV CL,AL
   MOV AL,A
   OUT DX,AL ; 3C5h
   JCXZ @@Pickotta2
   MOV BH,vnParadiseWD90C11
   DEC DX
   MOV AL,10h
   OUT DX,AL ; 3C4h
   INC DX
   IN  AL,DX ; 3C5h
   PUSH AX
    PUSH AX
     AND AL,0FBh
     OUT DX,AL ; 3C5h
     IN  AL,DX ; 3C5h
     AND AL,4
     JZ  @@SkipA2
     MOV BH,vnParadiseWD90C10
@@SkipA2:
    POP AX
    OR  AL,4
    OUT DX,AL ; 3C5h
    IN  AL,DX ; 3C5h
    TEST AL,4
    JNZ @@SkipA3
    MOV BH,vnParadiseWD90C10
@@SkipA3:
   POP AX
   OUT DX,AL ; 3C5h
   JMP @@EndPickotta
@@Pickotta2:
   MOV BH,vnParadiseWD90C00
@@EndPickotta:
   MOV DL,0CEh ; 3CEh
   MOV AL,0Bh
   OUT DX,AL ; 3CEh
   NOP
   NOP
   INC DX
   IN  AL,DX ; 3CFh
   MOV AH,AL
   MOV CL,4
   SHR AL,CL
   MOV Byte Ptr ES:[DI].PIV.Memory[2],AL
   MOV AL,8
   TEST AH,04h
   JZ  @@ParadiseVideo8Bits
   MOV AL,16
@@ParadiseVideo8Bits:
   MOV ES:[DI].PIV.VideoBits,AL
   MOV AL,8
   TEST AH,02h
   JZ  @@ParadiseRom8Bits
   MOV AL,16
@@ParadiseRom8Bits:
   MOV ES:[DI].PIV.RomBits,AL
   DEC DX
   MOV AL,0Fh
   OUT DX,AL ; 3CEh
   INC DX
   IN  AL,DX ; 3CFh
   MOV CL,mnMultiSync
   TEST AL,80h
   JNZ @@NoFixedSync
   MOV CL,mnFixedSync
@@NoFixedSync:
   MOV ES:[DI].PIV.Monitor,CL
   MOV DX,SI ; 3?4h
   MOV AL,29h
   OUT DX,AL ; 3?4h
   INC DX
  POP AX
  OUT DX,AL ; 3?5h
  MOV DX,3CEh
  MOV AL,0Fh
  OUT DX,AL ; 3CEh
  INC DX
 POP AX
 OUT DX,AL
 MOV SI,indexProcSelBnkPgParadise
@@SetCardNBnkPg:
 MOV ES:[DI].PIV.Card,BH
@@SetBnkPgOnly:
 MOV ES:[DI].PIV.ProcSelBnkPg,SI
@@Vesa:
  ;?????????????????????????????????????????????????????????????????????????
  ;??                        D ‚ t e c t i o n  V e s a                   ??
  ;?????????????????????????????????????????????????????????????????????????
 MOV AX,4F00h
 PUSH ES
  PUSH DI
   PUSH CS
   POP ES
   MOV DI,Offset VesaHeader
   MOV SI,DI
   INT 10h
  POP DI
 POP ES
 CMP AX,004Fh
 JNE @@EndPS2
 CMP Word Ptr CS:[SI].VesaHeaderInfo.Sign[0],('V')+('E' shl 8)
 JNE @@EndPS2
 CMP Word Ptr CS:[SI].VesaHeaderInfo.Sign[2],('S')+('A' shl 8)
 JNE @@EndPS2
 MOV ES:[DI].PIV.Vesa,Ya
 CMP ES:[DI].PIV.ProcSelBnkPg,indexProcSelBnkPgVGA
 JNE @@SkipSelBnkPg
 MOV AX,CS:[SI].VesaHeaderInfo.NmBnk64K
 MOV Word Ptr ES:[DI].PIV.Memory[2],AX
 MOV ES:[DI].PIV.ProcSelBnkPg,indexProcSelBnkPgVesa
 MOV ES:[DI].PIV.CardCat,cvnVesa
@@SkipSelBnkPg:
 CMP ES:[DI].PIV.Card,vnVGA
 JNE @@SkipVesaCard
 MOV BL,vnVesa
@@SetCardNExit:
 MOV ES:[DI].PIV.Card,BL
  ;??????????????????????????????????????????????????????????????????????
  ;??                               MATROX                             ??
  ;??????????????????????????????????????????????????????????????????????
 PUSH CX
  PUSH BX
   PUSH SI
    MOV CX,6
    MOV BX,2Dh
    MOV SI,Offset MatroxSignature
    CALL @CompareROM
   POP SI
  POP BX
 POP CX
 JNZ NotMatrox
; MOV ES:[DI].PIV.ProcSelBnkPg,indexProcSelBnkPgMatrox
 PUSH CX
  PUSH BX
   PUSH SI
    MOV CX,9
    MOV BX,34h
    MOV SI,Offset MatroxMystiqueSign
    CALL @CompareROM
   POP SI
  POP BX
 POP CX
 JNZ NotMxMystique
 MOV ES:[DI].PIV.Card,vnMatroxMystique
 JMP NotMatrox
NotMxMystique:
 PUSH CX
  PUSH BX
   PUSH SI
    MOV CX,9
    MOV BX,34h
    MOV SI,Offset MatroxMilleniumSign
    CALL @CompareROM
   POP SI
  POP BX
 POP CX
 JNZ NotMx1000
 MOV ES:[DI].PIV.Card,vnMatroxMillenium
 JMP NotMatrox
NotMx1000:       ; Matrox Millenium
 PUSH CX
  PUSH BX
   PUSH SI
    MOV CX,9
    MOV BX,34h
    MOV SI,Offset MatroxG200Sign
    CALL @CompareROM
   POP SI
  POP BX
 POP CX
 JNZ NotMxG200
 MOV ES:[DI].PIV.Card,vnMatroxG200
 JMP NotMatrox
NotMxG200:
 MOV ES:[DI].PIV.Card,vnMatrox
NotMatrox:

@@SkipVesaCard:
@@EndPS2:
 MOV AX,3B4h
 CMP CurrPort,3D4h
 JE  @@NoChgCurrPort
 MOV AL,0D4h
@@NoChgCurrPort:
 MOV CurrPort,AX
 MOV BL,Byte Ptr _PS2[1]
;  LES DI,Info2
 PUSH CS
 POP ES
 MOV DI,Offset CardSec

 INC Pass
 CMP Pass,1
 JNE @@RePass
  ; V‚rification de la pr‚sence de l'Hercule pour un systŠme … une carte vid‚o...
 MOV BL,ES:[DI].PIV.Card
 CMP BL,vnUnknown
 JNE NoHGCIn1Card
; LES DI,Info1
 PUSH CS
 POP ES
 MOV Di,adrPhysVideo

 MOV BL,ES:[DI].PIV.Card
 CMP BL,vnITVGA2
 JE  HGCIn1Card
 CMP BL,vnT3000
 JE  HGCIn1Card
 CMP BL,vnT4000
 JE  HGCIn1Card
 CMP BL,vnT4000HiColor
 JE  HGCIn1Card
 CMP BL,vnT4000HiColorSC
 JE  HGCIn1Card
 JMP NoHGCIn1Card
HGCIn1Card:
 MOV ES:[DI].PIV.Hercule,Ya
NoHGCIn1Card:
  ; Adaptation des SetVideoMode primaire
; LES DI,Info1
 PUSH CS
 POP ES
 MOV DI,adrPhysVideo

 MOV BL,ES:[DI].PIV.Card
 XOR BH,BH
 MOV AL,Byte Ptr CS:[Offset @BaseCard+BX]
 XOR AH,AH
 MOV ES:[DI].PIV.ProcSetVideoMode,AX
 RET
endp

DisableCOMint Proc Near
 PUSHF
  CLI
  IN  AL,21h                        ; 21h Demande le masque PIC
  OR  AL,Byte Ptr PICstateMouse     ; D‚sactive les interruptions s‚rie
  OUT 21h,AL
  MOV DX,DefMousePort
  ADD DX,3
  MOV AL,0
  OUT DX,AL                ;3FBh Fixe DLAB ferm‚
  INC DX
  IN  AL,DX                ; 3FCh Contr“le modem
  AND AL,0F3h
  OUT DX,AL                ; 3FCh OUT2 ferm‚
  SUB DX,3
  MOV AL,0
  OUT DX,AL                ; 3F9h Toutes les interruptions ferm‚
 POPF
EndProc

COMMouseExist Proc Near
 CLI
 MOV CX,DefMousePort
 STC
 JCXZ @@ComExRet
 PUSH CX
  CALL DisableComInt
 POP DX
 ADD DX,3
 MOV AL,0
 OUT DX,AL                        ; 3FBh R‚initialise les paramŠtres
 INC DX
 IN  AL,DX                        ; 3FCh Registre de contr“le Modem
 AND AL,0E0h                      ; Demande les bits reserv‚
 MOV AH,AL
 SUB DX,3
 IN  AL,DX                        ;3F9h Registre d'interruption activ‚
 AND AL,0F0h                      ; Demande les bits r‚serv‚
 OR  AL,AH
 NEG AL
@@ComExRet:
 STI
EndProc

ReadCOMByte Proc Near
 MOV AH,2              ; Longueur du "Ticks" d'horloge de silence
 MOV DX,SI
 ADD DX,5
tlm:
 MOV DI,ES:[46Ch]
wlm:
 IN  AL,DX             ; Registre d'‚tat de ligne 3FDh
 TEST AL,1
 JNZ rrm               ; Saute si les donn‚es sont prˆt
 CMP DI,ES:[46Ch]
 JE  wlm               ; Saute si mˆme "Ticks" d'horloge
 DEC AH
 JNZ tlm              ; Attend le prochain "Tick" d'horloge en silence
 STC
 RET
rrm:
 MOV DX,SI
 IN  AL,DX             ; 3F8h R‚ception de donn‚e
 ;CLC
EndProc

DetectMouse Proc Near
 MOV SI,DefMousePort
  ; R‚initialise la souris mat‚riel
 MOV DX,SI
 ADD DX,3
 MOV AL,80h
 OUT DX,AL           ; 3FBh Met le DLAB ouvert
 MOV DX,SI
 MOV AX,96
 OUT DX,AX           ; 3F8h,3F9h 1200 baud
 ADD DX,3
 MOV AL,Byte Ptr COMLCR
 OUT DX,AL           ; 3FBh DLAB ferm‚, pas de parit‚, stop=1, longueur=7/8
  ;Signale RTS pulse (drop et raise)
 XOR AX,AX
 MOV ES,AX
 INC DX
 MOV DI,ES:[46Ch]
w1m:
 CMP DI,ES:[46Ch]
 JE  w1m             ; Attend l'horloge pour d‚marrer
 OUT DX,AL           ; 3FCh DTR/RTS/OUT2 ferm‚
 MOV AL,3
 MOV DI,ES:[46Ch]
w2m:
 CMP DI,ES:[46Ch]
 JE  w2m           ; Attend la fin du "Tick" d'horloge
 OUT DX,AL         ; 3FCh DTR/RTS on, OUT2 off
  ; ---------- D‚tecte si une souris Microsoft ou Logitech est pr‚sente
 MOV BX,101h       ; bl=no MS, bh=mousetype
 MOV CX,4          ; Recherche les 4 premiers octets
dlm:
 CALL ReadCOMbyte
 JC  ddm
 CMP AL,'M'
 JNE ChkLG
 MOV BL,0          ; Souris Microsoft trouv‚...
ChkLG:
 CMP AL,'3'
 JNE dnm
 MOV BH,2          ; ...Souris Logitech trouv‚
dnm:
 LOOP dlm
sdm:
 CALL ReadCOMByte
 JNC sdm
ddm:
 MOV Byte Ptr TypeMouse,BH  ; Sauve 1=MS ou 2=Logitech
 NEG BL                     ; Faire non-z‚ro pour drapeau de retenu
EndProc

SetComPortMouse Proc Near
 PUSH AX
   ; Calcul l'adresse
  MOV BL,Byte Ptr DefMouseCom
  XOR BH,BH
  DEC BX
  PUSH BX
   SHL BX,1
   MOV DX,Word Ptr ComBase[BX]
   MOV DefMousePort,DX
   ; Calcul l'IRQ
  POP BX
  MOV AL,Byte Ptr ComInt[BX]
  MOV Byte Ptr IRQIntNumMouse,AL
   ; Calcul le masque
  MOV CL,Byte Ptr ComIRQ[BX]
  MOV AL,1
  SHL AL,CL
  MOV Byte Ptr PICStateMouse,AL
 POP AX
EndProc

; ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
;    Proc‚dure StartUpChantal(Var Jump:Jumper;Var StartUp:StartUpIsabel)
; ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

OldByte DB ?
StartUpChantal Proc Pascal Far
VesaHeader:
 CLD
 MOV ES,PrefixSeg
 MOV DI,0081h
 MOV AL,' '
 MOV CX,80h
 REPZ SCASB
 DEC DI
 MOV AX,'M'+('A'shl 8)
 SCASW
 JNE NoMaitre
 MOV AX,'I'+('T'shl 8)
 SCASW
 JNE NoMaitre
 CMP Word Ptr ES:[DI],'R'+('E'shl 8)
 JNE NoMaitre
 PUSH CS
 POP DS
 MOV SI,Offset @Maitre
Maitre1:
 LODSB
 CLD
 XOR AL,128
 OR  AL,AL
 JZ  Maitre2
 MOV AH,02h
 MOV DL,AL
 PUSH DS
  PUSH SI
   INT 21h
  POP SI
 POP DS
 JMP Maitre1
Maitre2:
 MOV AX,4CFEh
 INT 21h
NoMaitre:
 TEST Jump.Jumper.FlgMethod,flgSkipCPUTest
 JNZ  noCPU
 PUSHF
 XOR AX,AX
 PUSH AX
 POPF
 PUSHF
 POP AX
 AND AX,0F000h
 CMP AX,0F000h
 JE  inf286           ; Inf‚rieur au 286?
 MOV  DL,cpu80286
 MOV  AX,07000h
 PUSH AX
 POPF
 PUSHF
 POP AX
 AND AX,07000h
 JE  pfin
 INC DL
 CLI
 DB 066h,08Bh,0DCh         ; MOV    EBX,ESP
 DB 066h,083h,0E4h,0FCh    ; AND    ESP,0FFFCh
 DB 066h,09Ch              ; PUSHFD
 DB 066h,058h              ; POP    EAX
 DB 066h,08Bh,0C8h         ; MOV    ECX,EAX
 DB 066h,035h,000h,0h,4h,0h; XOR    EAX,1 shl 18
 DB 066h,050h              ; PUSH   EAX
 DB 066h,09Dh              ; POPFD
 DB 066h,09Ch              ; PUSHFD
 DB 066h,058h              ; POP    EAX
 DB 066h,051h              ; PUSH   ECX
 DB 066h,09Dh              ; POPFD
 DB 066h,033h,0C1h         ; XOR    EAX,ECX
 DB 066h,0C1h,0E8h,012h    ; SHR    EAX,18
 DB 066h,083h,0E0h,001h    ; AND    EAX,1h
 DB 066h,08Bh,0E3h         ; MOV    ESP,EBX
 STI
 ADD DL,AL
 JMP pfin
Inf286:                    ; Inf‚rieur au 286
 MOV DL,cpu80188
 MOV AL,0FFh
 MOV CL,021h
 SHR AL,CL
 JNE t88_86
 MOV DL,cpuV20
 STI
 MOV SI,0
 MOV CX,0FFFFh
 DB  0F3h,026h,0ACh
 OR  CX,CX
 JE  t88_86
 MOV DL,cpu8088
t88_86:
 PUSH CX
 POP  ES
 STD
 MOV DI,Offset q2End
 MOV AL,0FBh
 MOV CX,3
 CLI
 REP STOSB
 CLD
 NOP
 NOP
 NOP
 INC DX
 NOP
q2End:
 STI
pfin:
 POPF
 XOR DH,DH
 MOV AX,DX
 CMP AL,cpui486
 JB  nTstCyrix
.386
 PUSHFD
 POP ECX
 MOV EBX,ECX
 XOR EBX,00200000h
 PUSH EBX
 POPFD
 PUSHFD
 POP EBX
 XOR EBX,ECX
.8086
 JE  Cyrix5x86
@CPUID:
  ; Tester la pr‚sence de l'instruction CPUID pour ˆtre certain que
  ; l'instruction ne provoque pas un plantage dans un systŠme
  ; d'exploitation … cause que le micro-processeur est mal configur‚e...
 PUSH ES
  PUSH DI
   PUSH DS
    MOV AX,3506h
    INT 21h
    PUSH ES
     PUSH BX
      PUSH CS
      POP DS
      MOV DX,Offset @@Int06h
      MOV AX,2506h
      INT 21h
.586
      XOR EAX,EAX
      CPUID
.8086
      STC
      JMP @@RestoreInt06h
@@Int06h:
      ADD SP,4
      POPF
      CLC
@@RestoreInt06h:
     POP DX
    POP DS
    PUSHF
     MOV AX,2506h
     INT 21h
    POPF
   POP DS
   MOV BL,0
   ADC BL,0
  POP DI
 POP ES
 MOV StartUp.StartUpRec.CPUIDSupport,BL
 MOV AL,cpuPentium
 OR  BL,BL            ; CPUID non-support?
 JZ  nTstCyrix     ; Ne pas poursuivre les testes...
 PUSH ES
  PUSH DI
.586
   XOR EAX,EAX
   CPUID
.8086
  POP DI
 POP ES
  ; V‚rification du Fabricant Cyrix
.386
 CMP EBX,'iryC'
.8086
 JNE NCVCPU ; NotCyrixVendorCPU
.386
 CMP EDX,'snIx'
.8086
 JNE NCVCPU ; NotCyrixVendorCPU
.386
 CMP ECX,'daet'
.8086
 JE  Cyrix
NCVCPU: ; NotCyrixVendorCPU
  ; V‚rification du Fabricant AMD
.386
 CMP EBX,'htuA'
.8086
 JNE NAVCPU ; NotAMDVendorCPU
.386
 CMP ECX,'DMAc'
.8086
 JNE NAVCPU
.386
 CMP EDX,'itne'
.8086
 JNE NAVCPU
 MOV StartUp.StartUpRec.CPUVendor,cvAMD
 MOV AL,cpuPentium
 JMP nVendorCPU
NAVCPU: ; NotAMDVendorAMD
 MOV AL,cpuPentium
nVendorCPU:
 JMP nTstCyrix
  ;???????????????????????????????????????????????????????????????????????
  ;??                              Cyrix 5x86                           ??
  ;???????????????????????????????????????????????????????????????????????
Cyrix5x86:
 PUSH AX
  MOV AX,5555h
  XOR DX,DX
  MOV CX,0002h
  CLC
  DIV CX
 POP AX
 JC  nTstCyrix
Cyrix:
 MOV StartUp.StartUpRec.CPUVendor,cvCyrix
 MOV AL,0FEh
 OUT 22h,AL
 IN  AL,23h
 MOV BL,AL
 MOV AL,cpuCyrix5x86
 CMP BL,30h
 JB  nTstCyrix
 MOV AL,cpuCyrix6x86
nTstCyrix:
noCPU:
;Fin de d‚tection du processeur
 MOV StartUp.StartUpRec.CPU,AL ; Fixe le CPU
 CMP AL,cpu80286
 JA  @@32Bits
 MOV AL,No
 JMP n32Bits
@@32Bits:
 MOV AL,Ya
n32Bits:
 MOV StartUp.StartUpRec.Up32Bits,AL
  ; Teste les interruptions existante...
 MOV StartUp.StartUpRec.IntExistFlags,0; Fixe  …   0   le   drapeau   des
                                       ; interruptions pour pouvoir faire
                                       ; un OR plus tard...
  ; Int 10h
 MOV AL,10h
 CALL IntExist
 JZ  NoInt10
 OR  StartUp.StartUpRec.IntExistFlags,flgInt10h
NoInt10:
  ; Int 11h
 MOV AL,11h
 CALL IntExist
 JZ  NoInt11
 OR  StartUp.StartUpRec.IntExistFlags,flgInt11h
NoInt11:
  ; Int 12h
 MOV AL,12h
 CALL IntExist
 JZ  NoInt12
 OR  StartUp.StartUpRec.IntExistFlags,flgInt12h
NoInt12:
  ; Int 13h
 MOV AL,13h
 CALL IntExist
 JZ  NoInt13
 OR  StartUp.StartUpRec.IntExistFlags,flgInt13h
NoInt13:
  ; Int 15h
 MOV AL,15h
 CALL IntExist
 JZ  NoInt15
 OR  StartUp.StartUpRec.IntExistFlags,flgInt15h
NoInt15:
  ; Int 16h
 MOV AL,16h
 CALL IntExist
 JZ  NoInt16
 OR  StartUp.StartUpRec.IntExistFlags,flgInt16h
NoInt16:
  ; Int 1Ah
 MOV AL,1Ah
 CALL IntExist
 JZ  NoInt1Ah
 OR  StartUp.StartUpRec.IntExistFlags,flgInt1Ah
NoInt1Ah:
  ; Int 21h
 TEST Jump.Jumper.FlgMethod,flgProtectedMode
 JNZ YesInt21h
 XOR AX,AX
 MOV ES,AX
 LES BX,ES:[84h]
 MOV AX,ES
 OR  AX,BX
 JZ  NoInt21h
 CMP Byte Ptr ES:[BX],0CFh ; Pour les hypocrites d'interruption miroir, quand
 JE  NoInt21h              ; elles sont bidon, elles pointent sur un IRET!
YesInt21h:
 OR  StartUp.StartUpRec.IntExistFlags,flgInt21h
NoInt21h:
  ; Int 2Fh
 TEST Jump.Jumper.FlgMethod,flgProtectedMode
 JZ  xInt2F
 MOV AX,0352Fh
 INT 021h
 JMP TstInt2F
xInt2F:
 XOR AX,AX
 MOV ES,AX
 LES BX,ES:[0BCh]
TstInt2F:
 MOV AX,ES
 OR  AX,BX
 JZ  NoInt2F
 CMP Byte Ptr ES:[BX],0CFh ; Pour les hypocrites d'interruption miroir, quand
 JE  NoInt2F               ; elles sont bidon, elles pointent sur un IRET!
 OR  StartUp.StartUpRec.IntExistFlags,flgInt2Fh
NoInt2F:
  ; Int 33h
 TEST Jump.Jumper.FlgMethod,flgProtectedMode
 JZ  xInt33
 MOV AX,03533h
 INT 021h
 JMP TstInt33
xInt33:
 XOR AX,AX
 MOV ES,AX
 LES BX,ES:[0CCh]
TstInt33:
 MOV AX,ES
 OR  AX,BX
 JZ  NoInt33
 CMP Byte Ptr ES:[BX],0CFh ; Pour les hypocrites d'interruption miroir, quand
 JE  NoInt33               ; elles sont bidon, elles pointent sur un IRET!
 OR  StartUp.StartUpRec.IntExistFlags,flgInt33h
NoInt33:
  ; Int 67h
 TEST Jump.Jumper.FlgMethod,flgProtectedMode
 JZ  xInt67
 MOV AX,03567h
 INT 021h
 JMP TstInt67
xInt67:
 XOR AX,AX
 MOV ES,AX
 LES BX,ES:[019Ch]
TstInt67:
 MOV AX,ES
 OR  AX,BX
 JZ  @@NoInt67h
 CMP Byte Ptr ES:[BX],0CFh ; Pour les hypocrites d'interruption miroir, quand
 JE  @@NoInt67h            ; elles sont bidon, elles pointent sur un IRET!
 OR  StartUp.StartUpRec.IntExistFlags,flgInt67h
@@NoInt67h:
  ; GetDosVersion/HandleExist
 TEST StartUp.StartUpRec.IntExistFlags,flgInt21h
 JZ  @@NoDos
 MOV StartUp.StartUpRec.HandleExist,Ya
 XOR BX,BX
 MOV AX,03306h
 INT 021h
;  CMP AL,006h
 OR  BX,BX
 JE  OldGetDosVer
; JNE @@OldGetDosVer
 CMP BH,100
 JA  OldGetDosVer
 CMP BL,5
 JB  OldGetDosVer
 MOV StartUp.StartUpRec.GetDosVer,BX
  ; OS/2 ?
 MOV AX,4452h
 INT 21h
 JNC nGetDosVer
 MOV AL,Byte Ptr StartUp.StartUpRec.GetDosVer
 CMP AL,10
 JB  nGetDosVer
 MOV StartUp.StartUpRec.OS2,Ya
 MOV AL,Byte Ptr StartUp.StartUpRec.GetDosVer
 MOV AH,0
 MOV BL,10
 OR  AL,AL
 JE  @SkipDiv0a
 DIV BL
@SkipDiv0a:
 MOV StartUp.StartUpRec.OS2LoVer,AL
 MOV AL,Byte Ptr StartUp.StartUpRec.GetDosVer[1]
 OR  AL,AL
 JE  @SkipDiv0b
 DIV BL
@SkipDiv0b:
 MOV StartUp.StartUpRec.OS2HiVer,AL
  ; Pas de Jump? pour d‚tecter le Version DOS ‚mul‚! TrŠfle!
OldGetDosVer:
 MOV AH,30h
 INT 021h
 MOV StartUp.StartUpRec.GetDosVer,AX
 OR  AL,AL ; Dos 1.0 ?
 JNE nGetDosVer
@@NoDos:
 MOV StartUp.StartUpRec.GetDosVer,100h ; Yache! Dos 1.0
 MOV StartUp.StartUpRec.HandleExist,No
nGetDosVer:
  ; Demande le code de pays
 MOV BX,0FFFFh
 MOV CX,BX
 TEST Jump.Jumper.FlgMethod,flgNoCountryDetect
 JNZ nCountry
 TEST StartUp.StartUpRec.IntExistFlags,flgInt21h
 JZ  @@CodeCountryOff
 CMP Byte Ptr StartUp.StartUpRec.GetDosVer,3
 JB  @@CodeCountryOff
 JNE @@OkCodeCountry
 CMP Byte Ptr StartUp.StartUpRec.GetDosVer[1],3
 JB  @@CodeCountryOff ; C'est un DOS 3, mais inf‚rieur au .3...
@@OkCodeCountry:
 PUSH DS
 POP ES
 MOV DI,Offset StartUp.StartUpRec.Date
 MOV CX,7
 MOV BX,0FFFFh
 MOV DX,BX
 MOV AX,6501h
 INT 21h
 MOV BX,ES:[DI+3]
 MOV CX,ES:[DI+5]
@@CodeCountryOff:
 MOV StartUp.StartUpRec.CountryCode,BX
 MOV StartUp.StartUpRec.CodePage,CX
  ; GetCountry
 CLD
 PUSH DI
  ADD DI,Offset StartUpRec.Date
  MOV CX,TYPE CountryRec
  MOV AL,0
  REP STOSB
 POP DI
 TEST StartUp.StartUpRec.IntExistFlags,flgInt21h
 JZ  nCountry
 PUSH DS
  MOV AX,03800h
  MOV DX,Offset StartUp.StartUpRec.Date
  INT 021h
 POP DS
 CMP Byte Ptr StartUp.StartUpRec.GetDosVer,2
 JNE nCountry
  ; Dos 2.xx, c'‚tait cod‚ de fa‡on batarde...
 MOV AX,Word Ptr StartUp.StartUpRec.Curr[4]
 MOV Word Ptr StartUp.StartUpRec.DeSep,AX
 MOV AX,Word Ptr StartUp.StartUpRec.Curr[2]
 MOV Word Ptr StartUp.StartUpRec.ThSep,AX
nCountry:
  ; IsNovell
 MOV AL,0
 TEST Jump.Jumper.FlgMethod,flgNoNovell
 JNZ  nNovell
 MOV AX,0DC00h
 TEST StartUp.StartUpRec.IntExistFlags,flgInt21h
 JZ  nNovell
 XOR CX,CX
 INT 21h
 CMP AL,0
 JE  nNovell
 MOV AL,Ya
nNovell:
 MOV StartUp.StartUpRec.IsNovell,AL
  ; GetDosBlock/Mode R‚el seulement
 XOR BX,BX
 XOR DX,DX
 TEST Jump.Jumper.FlgMethod,flgProtectedMode
 JNZ  @@NoDosBlock
 TEST StartUp.StartUpRec.IntExistFlags,flgInt21h
 JZ  @@NoDosBlock
 MOV AH,052h ; Garantie … 200% que si cet appel … lieu en
 INT 021h    ; mode prot‚g‚ que sa plante!
 ADD BX,12
 MOV DX,ES
 DEC DX
@@NoDosBlock:
 MOV Word Ptr StartUp.StartUpRec.GetDosBlock,BX
 MOV Word Ptr StartUp.StartUpRec.GetDosBlock[2],DX
  ; D‚tection de Windows
 MOV Word Ptr StartUp.StartUpRec.WinLoVer,0
 TEST StartUp.StartUpRec.IntExistFlags,flgInt2Fh
 JZ  @@NoWin
 MOV AX,01600h
 INT 02Fh
 CMP AL,01h
 JE  W386X
 CMP AL,0FFh
 JE  W386X
 CMP AL,000h
 JE  @@WinFucked
 CMP AL,080h
 JE  @@WinFucked
 MOV Word Ptr StartUp.StartUpRec.WinLoVer,AX
 MOV StartUp.StartUpRec.Win,winEnhanced
 JMP nWin
W386X:
 MOV Word Ptr StartUp.StartUpRec.WinLoVer,0200h
 MOV StartUp.StartUpRec.Win,win386X
 JMP nWin
@@WinFucked:
 MOV AX,4680h
 INT 2Fh
 CMP AL,80h
 JNE @@Win
@@NoWin:
 CMP Word Ptr StartUp.StartUpRec.GetDosVer,5 + (50 shl 8)
 JNE @@NoNT
 MOV StartUp.StartUpRec.Win,winNT
 JMP nWin
@@NoNT:
 MOV StartUp.StartUpRec.Win,winNo
 JMP nWin
@@Win:
 MOV AX,1605h
 XOR BX,BX
 XOR SI,SI
 XOR CX,CX
 MOV ES,CX
 PUSH DS
  MOV DS,CX
  MOV DX,0001h
  INT 2Fh
 POP DS
 CMP CX,0
 JNE ws
 MOV AX,1606h
 INT 2Fh
 MOV StartUp.StartUpRec.Win,winReal
 JMP nWin
ws:
 MOV StartUp.StartUpRec.Win,winStandard
nWin:
  ; Contr“leur de manette de jeu existe ?
 TEST Jump.Jumper.FlgMethod,flgJoyPerBios
 JNZ  Joy4Bios
 MOV DX,0201h
 MOV AL,1
 OUT DX,AL
 IN  AL,DX
 TEST AL,0Fh
 JNZ  CtrlJoyEx
@@NoJoy:
 MOV AL,No
@@SetJoyPort0:
 XOR DX,DX
 JMP nJoy
Joy4Bios:
 TEST StartUp.StartUpRec.IntExistFlags,flgInt15h
 JZ  @@NoJoy
 MOV AX,0084h
 XOR DX,DX
 INT 015h
 MOV AL,0
 CMC
 ADC AL,0
 JMP @@SetJoyPort0
CtrlJoyEx:
 MOV AL,Ya
nJoy:
 MOV StartUp.StartUpRec.JoyExist,AL
 MOV StartUp.StartUpRec.JoyPort,DX
  ; BiosJostickSupport/Contr“leur clavier ?
 PUSH ES
;  IFB .286
;   PUSH 0FFFFh
;   POP ES
;  ELSE
   MOV AX,0FFFFh
   MOV ES,AX
;  ENDIF
  CMP Byte Ptr ES:[0Eh],0FCh
  JE  bsj
  MOV BL,ctrlkb8048
  MOV AL,No
  JMP nBiosJoy
bsj:
  MOV AL,Ya
  MOV BL,ctrlkb8042
nBiosJoy:
 POP ES
 MOV StartUp.StartUpRec.BiosJoy,AL
 MOV StartUp.StartUpRec.KbdCtrl,BL
  ; Potentio MŠtre de la manette de jeu
 XOR BX,BX
 CMP StartUp.StartUpRec.JoyExist,Ya
 JNE @@NoJoyPot
 MOV BX,416
 TEST Jump.Jumper.FlgMethod,flgJoyPerBios
 JNZ @@JoyPotPerBios
 MOV BX,270
@@JoyPotPerBios:
@@NoJoyPot:
 MOV StartUp.StartUpRec.JoyPotentioMeter,BX
  ; Get1LPT/LPTExist/NumLPT
 XOR AX,AX
 MOV BX,AX
 TEST Jump.Jumper.FlgMethod,flgProtectedMode
 JNZ  @@BiosLPT
 TEST Jump.Jumper.FlgMethod,flgEquipPerBios
 JNZ  @@BiosLPT
 PUSH ES
  MOV ES,AX
  MOV AL,0FFh
  CMP Word Ptr ES:[40Eh],BX
  JZ  @@LPT2
  MOV AX,3 + (Ya shl 8)
  INC BX
@@LPT2:
  CMP Word Ptr ES:[40Ch],0
  JZ  @@LPT3
  MOV AX,2 + (Ya shl 8)
  INC BX
@@LPT3:
  CMP Word Ptr ES:[40Ah],0
  JZ  @@LPT4
  MOV AX,1 + (Ya shl 8)
  INC BX
@@LPT4:
  CMP Word Ptr ES:[408h],0
  JZ  nGet1LPT
  MOV AX,0 + (Ya shl 8)
  INC BX
nGet1LPT:
 POP ES
 JMP nLPT
@@BiosLPT:
 TEST StartUp.StartUpRec.IntExistFlags,flgInt11h
 JZ  nLPT
 INT 011h
 MOV CL,6
 SHR AH,CL
 MOV BL,AH
 MOV AX,00FFh
 CMP BL,0
 JE  nLPT
 MOV AX,0100h
nLPT:
 MOV StartUp.StartUpRec.Get1LPT,AL
 MOV StartUp.StartUpRec.LPTExist,AH
 MOV StartUp.StartUpRec.NmLPT,BL
  ; BiosEnhKbd
 TEST StartUp.StartUpRec.IntExistFlags,flgInt16h
 JZ  @@NoBiosEnhKbd
 MOV AH,002h
 INT 016h
 MOV Byte Ptr CS:[Offset OldByte],AL
 XOR AL,0FFh
 MOV AH,012h
 INT 016h
 CMP Byte Ptr CS:[Offset OldByte],AL
@@NoBiosEnhKbd:
 CALL @ZF2AL
 MOV StartUp.StartUpRec.BiosKbdEnh,AL
  ; KbdModel/KbdReadPort
; IFB .80286
;  PUSH 0040h
;  POP ES
;  MOV AL,ES:[96h]
; ELSE
  XOR AX,AX
  MOV ES,AX
  MOV AL,ES:[496h]
; ENDIF
 AND AL,10h
 JZ @@NoExtKbd
 MOV AL,kbMF
 JMP nIsExtKbd
@@NoExtKbd:
 MOV AX,0FFFFh
 MOV ES,AX
 MOV AL,kbAT
 MOV AH,Byte Ptr ES:[0Eh]
 CMP AH,0FCh
 JE  nIsExtKbd
 MOV AL,kbXT
 CMP AH,0FEh
 JE  nIsExtKbd
 MOV AL,kbConterm
 CMP AH,056h
 JE  nIsExtKbd
 MOV AL,kbPC
nIsExtKbd:
 MOV StartUp.StartUpRec.KbdModel,AL
 MOV StartUp.StartUpRec.KbdReadPort,0060h
  ;????????????????????????????????????????????????????????????????????????
  ;??                           M‚moire Conventionnel                    ??
  ;??                              (MemTotalSize)                        ??
  ;????????????????????????????????????????????????????????????????????????
 XOR AX,AX
 TEST Jump.Jumper.FlgMethod,flgEquipPerBios
 JZ  xMemTotalSize
 TEST StartUp.StartUpRec.IntExistFlags,flgInt12h
 JZ  @@SetMemTotalSize
 INT 12h
 JMP @@SetMemTotalSize
xMemTotalSize:
 MOV ES,AX
 MOV AX,ES:[413h]
@@SetMemTotalSize:
 MOV StartUp.StartUpRec.MemTotalSize,AX
  ;????????????????????????????????????????????????????????????????????????
  ;??                   D‚tection du pilote de m‚moire EMS               ??
  ;??                         (EmmExist,EmmTotalSize)                    ??
  ;????????????????????????????????????????????????????????????????????????
 XOR AX,AX
 XOR BX,BX
 MOV StartUp.StartUpRec.EmmTotalSize,AX
 TEST StartUp.StartUpRec.IntExistFlags,flgInt67h
 JZ  @@NoEmm
 TEST Jump.Jumper.FlgMethod,flgProtectedMode
 JNZ @@NoEmm                           ; Le mode prot‚g‚ ne permet  pas
                                       ; de tester la pr‚sence de l'EMM
 MOV ES,AX                             ; par  la m‚thode  tradionnelle,
 LES BX,ES:[019Ch]                     ; cela prouve  donc  que le mode
 PUSH DI                               ; prot‚g‚ est une poubelle con‡u
  MOV CX,7                             ; par       des     Intel-Jellos
  MOV SI,Offset EMMSignature           ; "unintelligente"...
  MOV DI,10
  CALL @CompareCS
 POP DI
 JZ  @@EmmExist
 PUSH DI
  MOV CX,4
  MOV SI,Offset QEMMSignature
  CALL @CompareCS
 POP DI
 JNZ @@NoEmm
@@EmmExist:
 MOV AH,42h
 INT 67h
; IFB .80286
;  SHL DX,4
; ELSE
 MOV CL,4
 SHL DX,CL
; ENDIF
 MOV StartUp.StartUpRec.EmmTotalSize,DX
 MOV AH,041h
 INT 067h
 MOV AL,Ya
 JMP nEmmExist
@@NoEmm:
 MOV AL,No
nEmmExist:
 MOV StartUp.StartUpRec.EmmExist,AL
 MOV StartUp.StartUpRec.EmmSeg,BX
  ;????????????????????????????????????????????????????????????????????????
  ;??                       D‚tection de la m‚moire XMS                  ??
  ;??                       (XmsExist,XmmCtrl,XmsSizeK)                  ??
  ;????????????????????????????????????????????????????????????????????????
  TEST StartUp.StartUpRec.IntExistFlags,flgInt2Fh
  JZ  @@NoXmm
  MOV AX,4300h
  INT 02Fh
@@NoXmm:
  MOV CL,No
  CMP AL,080h
  JNE nXms
  MOV AX,4310h
  INT 2Fh
  MOV DX,ES
  MOV Word Ptr StartUp.StartUpRec.XmmCtrl,BX
  MOV Word Ptr StartUp.StartUpRec.XmmCtrl[2],DX
  CMP Byte Ptr StartUp.StartUpRec.GetDosVer,5
  JE  @@XmsDos5
  CMP Byte Ptr StartUp.StartUpRec.GetDosVer,4
  JNE @@CmosMethod
@@XmsDos4:
  LES DI,StartUp.StartUpRec.GetDosBlock
  MOV BX,ES:[DI].DosBlockRec.Ver.Dos4.d4XmsSizeK
  JMP @@SetXmsSize
@@XmsDos5:
  LES DI,StartUp.StartUpRec.GetDosBlock
  MOV BX,ES:[DI].DosBlockRec.Ver.Dos5.d5XmsSizeK
  JMP @@SetXmsSize
@@CmosMethod:
  XOR BX,BX
  TEST Jump.Jumper.FlgMethod,flgNoCmosDetect
  JNZ @@SetXmsSize
  MOV AL,17h
  OUT 70h,AL
  NOP
  NOP
  NOP
  NOP
  IN  AL,071h
  NOP
  NOP
  NOP
  NOP
  MOV BL,AL
  MOV AL,18h
  OUT 70h,AL
  NOP
  NOP
  NOP
  NOP
  IN  AL,071h
  NOP
  NOP
  NOP
  NOP
  MOV BH,AL
@@SetXmsSize:
;  LES DI,StartUp
  MOV StartUp.StartUpRec.XmsTotalSize,BX
  MOV CL,Ya
nXms:
  MOV StartUp.StartUpRec.XmmExist,CL
   ;????????????????????????????????????????????????????????????????????????
   ;??                           D‚tection du CMOS                        ??
   ;??                  (GetCmosPort/CtrlCmos/ExtBiosExist)               ??
   ;????????????????????????????????????????????????????????????????????????
  MOV StartUp.StartUpRec.ExtBiosExist,No
  MOV StartUp.StartUpRec.ExtBiosSizeK,0
  TEST Jump.Jumper.FlgMethod,flgProtectedMode
  JNZ nXTCmosTst
  TEST StartUp.StartUpRec.IntExistFlags,flgInt15h ;Ä¿
  MOV AX,0FFFFh                                   ; ³
  MOV ES,AX         ;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ³
  JZ  @@SetCmosPort ; <ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
  CMP Byte Ptr ES:[0Eh],253
  JA  @@SetCmosPort
nXTCmosTst:
  XOR AX,AX
  TEST Jump.Jumper.FlgMethod,flgNoExtBiosMemDetect
  JNZ nExtInt15
  MOV AH,88h
  INT 15h
nExtInt15:
;  CMP AX,0
  OR  AX,AX
  MOV CX,70h
  MOV BL,ctrlCmosMC146818
  JE  @@SetCmosPort ; Pas de Ext Bios Int 15h
;  LES DI,StartUp
  MOV StartUp.StartUpRec.ExtBiosExist,Ya
  MOV StartUp.StartUpRec.ExtBiosSizeK,AX
  JMP @@DetectCmos
@@SetCmosPort:
  MOV AX,0FFFFh
  MOV ES,AX
  CMP Byte Ptr ES:[0Eh],252
  JE  @@DetectCmos
  TEST Jump.Jumper.FlgMethod,flgNoCmosDetect
  JZ @@NoCmos
  CMP Byte Ptr ES:[0Eh],255 ; PC ?
  JE  @@NoCmos
  CMP Byte Ptr ES:[0Eh],253 ; PC Junior ?
  JE  @@NoCmos
  MOV DX,02C0h
  IN  AL,DX
  TEST AL,0Fh
  JNZ @TooBad
  MOV DX,2CBh
  IN  AL,DX
  CMP AL,0DEh
  JE  @CmosB
  MOV AL,0DEh
  OUT DX,AL
  IN  AL,DX
  CMP AL,0DEh
  JE  @CmosB
@TooBad:
  XOR AL,AL
  OUT DX,AL
  INC DX
  IN  AL,DX
  DEC DX
  TEST AL,0Fh
  JNZ @TriBad
  MOV AL,0Bh
  OUT DX,AL
  INC DX
  IN  AL,DX
  CMP AL,0DEh
  JE  @CmosC
  MOV AL,0DEh
  OUT DX,AL
  IN  AL,DX
  CMP AL,0DEh
  JE  @CmosC
@TriBad:
  XOR AL,AL
  OUT DX,AL
  MOV AL,80h
  OUT DX,AL
  MOV BL,0Eh
  INC DX
  MOV AL,BL
  OUT DX,AL
  DEC DX
  MOV AL,88h
  OUT DX,AL
  MOV AL,98h
  OUT DX,AL
  MOV AL,88h
  OUT DX,AL
  MOV AL,80h
  OUT DX,AL
  MOV AL,0A0h
  OUT DX,AL
  INC DX
  MOV CX,100h
@LoopA:
  IN  AL,DX
  TEST AL,1
  LOOPZ @LoopA
  JZ  @NoCmosXT
  MOV CX,100h
@LoopB:
  IN  AL,DX
  TEST AL,1
  LOOPNZ @LoopB
  JZ @CmosA
@NoCmosXT:
  MOV DX,2C0h
  XOR AL,AL
  OUT DX,AL
  ; XT, difficile … dire si un CMOS existe... Wyse, Commodore,...
  ; mais si oui: le Port est E0h pour les ordinateurs Wyses XT
  MOV CX,0E0h
  MOV BL,ctrlCmosUnknown
  JMP nCmosXT
@CmosA:
  MOV BL,ctrlCmosRTC58321 ; RTC-58321, 2C0h-2C1h
  JMP @SetCmosXTPort
@CmosB:
  MOV BL,ctrlCmosMM58167a ; MM58167, 2C0h-2DFh
  JMP @SetCmosXTPort
@CmosC:
  MOV BL,ctrlCmosMM58167b ; MM58167, 2C0h-2C7h
@SetCmosXTPort:
  MOV CX,02C0h
nCmosXT:
  JMP @@DetectCmos
@@NoCmos:
  XOR CX,CX ; Je fixe le port … 0, mais il faudrait
            ; surtout pas essayez pour voir...
  MOV BL,ctrlCmosNo
@@DetectCmos:
;  LES DI,StartUp
  MOV StartUp.StartUpRec.CmosPort,CX
  MOV StartUp.StartUpRec.CtrlCmos,BL
   ;????????????????????????????????????????????????????????????????????????
   ;??                          D‚tection de la Souris                    ??
   ;??               (MouseDriverExist/Version/Nombre de bouton)          ??
   ;????????????????????????????????????????????????????????????????????????
  XOR AX,AX
;  LES DI,StartUp
  MOV StartUp.StartUpRec.MouseVer,AX
  MOV StartUp.StartUpRec.MsButton,AX
  TEST StartUp.StartUpRec.IntExistFlags,flgInt33h
  JZ  @@NoMouse
 TEST Jump.Jumper.FlgMethod,flgNoMouseDetect
 JNZ @@NoMouse
 MOV ES,AX
 MOV BX,ES:[0CEh]
 MOV ES,BX
 CMP Byte Ptr ES:[0],0CFh ; Pour les hypocrites d'interruption souris, quand
 JE  @@NoMouse            ; elles sont bidon, elles pointent sur un IRET!
 ; Teste le copyright … la "snobinare" de "LOGITECH"
 PUSH CX
  MOV CX,8
  MOV SI,Offset LogitechSignature
  MOV DI,3
  CALL @CompareCS
 POP CX
 JNZ @@NoLogitech
 XCHG CL,CH
 MOV StartUp.StartUpRec.MouseVer,CX
 MOV AL,msLogitech
 JMP nMouse
  ; Compare un chaŒne de caractŠres de longueur ®CX¯ sur la source CS:SI
  ; avec ES:DI. Les paramŠtres d'entr‚es sont donc CX, SI, ES:DI.
@CompareCS Proc Near
 CLD
 PUSH DS
  PUSH CS
  POP DS
  REPZ CMPSB
 POP DS
 RETN
endp
@@NoLogitech:
 XOR AX,AX
 INT 033h
 AND AL,msStandard
 CMP AL,msStandard
 JNE nMouse
 MOV AX,004Dh
 INT 33h
 CMP Word Ptr ES:[DI],'YK' ; KYE
 JNE @@NoGenius
 CMP Byte Ptr ES:[DI+2],'E'
 JNE @@NoGenius
 MOV AX,0011h
 INT 33h
 CMP AX,0FFFFh
 JE  @@PatateGenius
 MOV StartUp.StartUpRec.MsButton,BX
@@PatateGenius:
 MOV AL,msGenius
 JMP nMouse
@@NoGenius:
 MOV CX,9 ; Teste le copyright … la "snobinare" de "LOGITECH"
 MOV SI,Offset MicrosoftSignature
 ADD DI,27
 CALL @CompareCS
 JNZ @@NoMicro ; Ah! Fuckanadationamacrostofumerdusapiloteproute!
 MOV AX,006Ch
 INT 033h
 MOV BX,ES:[DI]
 MOV StartUp.StartUpRec.MouseVer,BX
 MOV AL,msMicrosoft
 JMP nMouse
@@NoMicro:
 MOV AX,004Bh
 INT 33h
 MOV CX,5
 MOV SI,Offset ZNixSignature
 CALL @CompareCS
 JNZ @@NoZNIX
 MOV AL,msZNIX
 JMP nMouse
@@NoZNIX:
 MOV AX,3000h
 INT 33h
 CMP AX,0FFFFh
 JE  @@Smooth
 MOV AL,Ya
 JMP nMouse
@@Smooth:
 XCHG BL,BH
 MOV StartUp.StartUpRec.MouseVer,BX
 MOV AL,msSmooth
 JMP nMouse
@@NoMouse:
 MOV AL,msNoMouse
nMouse:
  ;***********************************************
  ;*          D‚tection d'une souris PS/2        *
  ;***********************************************
 OR AL,AL
 JNZ @NMPS2
 CLI
 XOR CX,CX
 MOV BH,3
 MOV AX,0C205h
 INT 15h
 JC  @NMPS2F
 OR  AH,AH
 JNE @NMPS2F
 MOV AX,0C201h
 INT 15h
 JC  @NMPS2F
 OR  AH,AH
 JNE @NMPS2F
; Souris PS/2
 MOV CL,msPS2
@NMPS2F:
 XCHG AX,CX
 STI
@NMPS2:
 MOV StartUp.StartUpRec.Mouse,AL
 CALL SetComPortMouse
 OR AL,AL
 JNZ MsF
  ;******************************************
  ;*        Recherche de la souris s‚rie    *
  ;******************************************
 MOV DefMousePort,1
ACM:
 CALL SetComPortMouse
 CALL ComMouseExist
 JC NMD
 CALL DetectMouse
 CMP TypeMouse,0
 JNZ MsF
NMD:
 INC DefMousePort
 CMP DefMousePort,4
 JB  ACM
MsF:
  ;????????????????????????????????????????????????????????????????????????
  ;??                            Nom de l'ordinateur                     ??
  ;??                             (ComputerName,PS2)                     ??
  ;????????????????????????????????????????????????????????????????????????
  ;
  ;Remarque
  ;ÍÍÍÍÍÍÍÍ
  ;
  ; þ La variable PS2 n'est pas  de la d‚magogie,  car  dans les prochaines
  ;   instructions, ces variables permettra, sans faire 1 000 000 de teste,
  ;   de d‚tecter un bus MCA  des PS/2.  Voyez  que c'est utile les psychos
  ;   compacteur … la Hacker!
 MOV StartUp.StartUpRec.PS2,No
 TEST Jump.Jumper.FlgMethod,flgProtectedMode
 JNZ Int15TstCN
 MOV AX,0F000h
 MOV ES,AX
 CMP Word Ptr ES:[0E076h],'ED' ; DE
 JE  TstDell
ContinueCN:
 MOV AL,ES:[0FFFEh]
 CMP AL,0FDh
 JB  @@NotSupportComputerName
Int15TstCN:
 TEST StartUp.StartUpRec.IntExistFlags,flgInt15h
 JZ  @@NoInt15hComputerName
 TEST Jump.Jumper.FlgMethod,flgOnlyMem4ComputerName
 JNZ  @@NoInt15hComputerName
 MOV AH,0C0h
 XOR BX,BX
 MOV ES,BX
 INT 015h
 MOV AX,ES
 OR  AX,BX
 JZ  @@NotSupportComputerName
 MOV AX,ES:[BX+2]
 CMP AX,01FCh ; Les races de clones AT ?
 JE  @@CloneAT
 CMP AX,04FCh ; PS/2 ModŠle 50/50Z ?
 JE  @@PS2_50x
 CMP AX,09FCh ; PS/2 ModŠle 25 ou 30 avec 286 ?
 JE  @@PS2_25_30
 CMP AX,00E1h ; PS/2 ModŠle 55-5530 Laptop ?
 JE  @@PS2
 CMP AL,0F8h
 JE  @@PS2Fucked ; Gros chance de PS/2...
 CMP AL,0F9h ; PC-Convertible ?
 JE  @@PCConvertible
 CMP AX,05FCh ; PS/2 ModŠle 60 ?
 JE  @@PS2
 CMP AX,00FAh ; PS/2 ModŠle 30 ?
 JE  @@PS2
 CMP AX,01FAh ; PS/2 ModŠle 25/25L ?
 JE  @@PS2
   ; Les cas suivants n'ont pas de sous-sp‚cification:
  ; 01FBh, PC-XT/2 passe sans teste!
  ; 02FCh, PC-XT/286 passe sans teste!
  ; 06FCh, 7552 Gearbox passe sans teste!
  ; 0BFCh, PS/1 ModŠle 2011 passe sans teste!
  ; 42FCh, Olivetti M280 passe sans teste!
  ; 45FCh, Olivetti M380 (XP1/XP3/XP5) passe sans teste! Quoi que...
  ; 48FCh, Olivetti M290 passe sans teste!
  ; 4CFBh, Olivetti M200 passe sans teste!
  ; 4EFEh, Olivetti M111 passe sans teste!
  ; 4FFCh, Olivetti M250 passe sans teste!
  ; 50FCh, Olivetti M380 (XP7) passe sans teste!
  ; 51FCh, Olivetti PCS286 passe sans teste!
  ; 52FCh, Olivetti M300 passe sans teste!
 JMP @@SetComputerName
@@PCConvertible:
 MOV AH,0
 JMP @@SetComputerName
@@CloneAT:
 MOV CL,ES:[BX+4]
 CMP CL,30h
 JE  @@NotTandy3000NL
 MOV AX,cnTandy3000NL
 JMP @@SetComputerName
@@NotTandy3000NL:
 CMP CL,20h
 JE  @@NotAST
 MOV AX,cnAST
 JMP @@SetComputerName
@@NotAST:
 CMP CL,0
 JE  DateCloneAT
 MOV AL,StartUp.StartUpRec.Up32Bits ; Compaq 286/386
 MOV AH,0FAh
 JMP @@SetComputerName
DateCloneAT:
 MOV AX,0FFFFh
 MOV AX,ES:[0Bh]
 CMP AL,'9'
 JNE NotModel90
 MOV AX,ES:[0Ah]
  ; 2639h, Toshiba T5200/200
  ; 4139h, Toshiba T4500SX-C
  ; 6F39h, Toshiba 1800SX
  ; 6E39h, Toshiba 1850SX
  ; 4539h, Toshiba 4400C
NotModel90:
  ; 3538h, PC-AT 319 ou 339, 8Mhz, passe sans teste...
  ; 3838h, Toshiba T5200/100, passe sans teste...
  ; 3938h, Toshiba T1200/XE, passe sans teste...
  ; 3738h, Tandy 3000, passe sans teste...
 JMP @@SetComputerName
TstDell:
 CMP Word Ptr ES:[0E078h],'LL'
 JNE ContinueCN
 MOV AL,ES:[0E845h]
 MOV AH,0A3h
 JMP @@SetComputerName
@@SetIBM7561_2:
 MOV AX,cnIBM7561_2
 JMP @@SetComputerName
@@SetPS2Model55_5551:
 MOV AX,cnPS2M55_5551
 JMP @@PS2
  ; PS/2 ModŠle 90XP et 95XP, race de complex‚ … n'en plus finir...
@@SetPS2Model90XP:
 MOV AX,cnPS2M90XP
 JMP @@PS2
@@SetPS2Model95XP:
 MOV AX,cnPS2M95XP
 JMP @@PS2
@@PS2Fucked:
 MOV BL,ES:[BX+4]
 MOV BH,AH
 CMP BX,0700h ; IBM PC 7561/2 ?
 JE  @@SetIBM7561_2
 CMP BX,0702h ; IBM PC 7561/2 ?
 JE  @@SetIBM7561_2
 CMP AH,0F2h ; Reply Model 32 ?
 JE  @@SetComputerName
 CMP AH,0F6h ; Memorex Telex ?
 JE  @@SetComputerName
 CMP AH,0FDh ; Processeur IBM Complexe (avec VPD) ?
 JE  @@SetComputerName
 CMP AH,62h
 JA  @@PS2
 MOV DI,AX
 AND DI,000FFh
 SHL DI,1
 JMP Word Ptr CS:[Offset @JmpPS+DI]
@@PS2_25_30:
 CMP CL,2
 JNE @@PS2 ; PS/2 ModŠle 25-286
 JMP @@AddSubPS2 ; PS/2 ModŠle 30-286
@@PS2_50x:
 CMP CL,3
 JNE @@PS2 ; PS/2 Model 50
@@AddSubPS2:
 MOV CL,ES:[BX+4]
 MOV CH,0
 ADD AX,CX ; PS/2 Model 50Z
@@PS2:
 MOV StartUp.StartUpRec.PS2,Ya
 JMP @@SetComputerName
@@NoInt15hComputerName:
 MOV AX,0F000h
 MOV ES,AX
@@NotSupportComputerName:
 MOV BX,ES:[0FFFDh]
 CMP BX,43FEh ; Olivetti M240 ?
 JE  @@OlivettiM240
 CMP BX,46FFh
 JNE @@NoOlivettiM15
 MOV AL,46h ; Olivetti M15
 JMP @@SetUpComputerName
@@OlivettiM240:
 MOV AX,BX
 JMP @@SetComputerName
@@NoOlivettiM15:
 CMP Byte Ptr ES:[0C000h],021h
 JNE @@NoTandy1000
 MOV AL,021h ; Tandy 1000
@@NoTandy1000:
@@SetUpComputerName:
 MOV AH,0
@@SetComputerName:
 MOV StartUp.StartUpRec.ComputerName,AX
  ;????????????????????????????????????????????????????????????????????????
  ;??                             ModŠle de Bus                          ??
  ;????????????????????????????????????????????????????????????????????????
 MOV AL,busMCA
 CMP StartUp.StartUpRec.PS2,Ya
 JE  @@MCA
 PUSH ES
  MOV CX,0FFFDh
  MOV ES,CX
  CMP Byte Ptr ES:[0009h],'I'
  JNE @NotEISA
  CMP Byte Ptr ES:[000Ah],'E'
  JNE @NotEISA
  CMP Byte Ptr ES:[000Bh],'A'
  JNE @NotEISA
  CMP Byte Ptr ES:[000Ch],'S'
  JNE @NotEISA
@EISA:
  MOV AL,busEISA
  JMP nTestBus
@NotEISA:
  MOV AH,0C0h
  INT 15h
  OR  AH,AH
  JZ  @NotMCA
  MOV AL,busMCA
  JMP nTestBus
@NotMCA:
  MOV AX,0B101h
  INT 01Ah
  OR  AH,AH
  JNZ @NotPCI
  MOV AL,busISAPCI
  JMP nTestBus
@NotPCI:
  MOV BL,StartUp.StartUpRec.CPU
  XOR BH,BH
  MOV AL,Byte Ptr CS:[Offset @BusSize+BX]
nTestBus:
 POP ES
@@MCA:
 MOV StartUp.StartUpRec.Bus,AL
  ;????????????????????????????????????????????????????????????????????????
  ;??                           Port S‚rie/Modem                         ??
  ;??                           (ComExist/NmCom)                         ??
  ;????????????????????????????????????????????????????????????????????????
 PUSH ES
  XOR AX,AX
  TEST Jump.Jumper.FlgMethod,flgEquipPerBios
  JNZ  ComInt11h
  TEST Jump.Jumper.FlgMethod,flgProtectedMode
  JNZ  ComInt11h
@@NotComInt11h:
  MOV ES,AX
  MOV AL,ES:[0411h]
  JMP nComDetect
ComInt11h:
  TEST StartUp.StartUpRec.IntExistFlags,flgInt11h
  JZ  nComDetect
  INT 011h
  MOV AL,AH
nComDetect:
 POP ES
 SHR AL,1
 AND AL,7
 MOV StartUp.StartUpRec.NmCom,AL
;  CALL @ZF2AL
 CMP AL,0
 JE  NoCom
 MOV AL,Ya
NoCom:
 MOV StartUp.StartUpRec.ComExist,AL
  ;????????????????????????????????????????????????????????????????????????
  ;??                           Unit‚ de disquette                       ??
  ;??                    (FloppyDskExist, NmFloppyDsk)                   ??
  ;????????????????????????????????????????????????????????????????????????
 XOR AX,AX
 PUSH ES
  TEST Jump.Jumper.FlgMethod,flgEquipPerBios
  JNZ FlopInt11
  TEST Jump.Jumper.FlgMethod,flgProtectedMode
  JNZ FlopInt11
  MOV ES,AX
  MOV AL,ES:[0410h]
  JMP nFlopDetect
FlopInt11:
  TEST StartUp.StartUpRec.IntExistFlags,flgInt11h
  JZ  nFlopDetect
  INT 11h
nFlopDetect:
 POP ES
 MOV BL,AL
 AND BL,1
 MOV StartUp.StartUpRec.FloppyDskExist,BL
 OR  BL,BL
 JZ  NoFloppyDskExist
 MOV CL,6
 SHR AL,CL
 INC AL
 MOV AH,AL
NoFloppyDskExist:
 MOV StartUp.StartUpRec.NmFloppyDsk,AH
  ;????????????????????????????????????????????????????????????????????????
  ;??                          SystŠme de Disque Dur                     ??
  ;??                  (HardDskExist, NmHardDsk, HardDskCtrl)            ??
  ;????????????????????????????????????????????????????????????????????????
 TEST Jump.Jumper.FlgMethod,flgProtectedMode
 JNZ BiosNmHD
 TEST Jump.Jumper.FlgMethod,flgEquipPerBios
 JZ  xNmHD
BiosNmHD:
 PUSH ES
  PUSH DI
   MOV AH,08h
   MOV DL,80h
   INT 13h
  POP DI
 POP ES
 MOV AL,DL
 JMP @@SetNmHD
xNmHD:
 PUSH ES
  XOR AX,AX
  MOV ES,AX
  MOV AL,ES:[475h]
 POP ES
@@SetNmHD:
 MOV StartUp.StartUpRec.NmHardDsk,AL
 CMP AL,0
 JNE @@NoHardDsk
 MOV AL,Ya
@@NoHardDsk:
 MOV StartUp.StartUpRec.HardDskExist,AL
 MOV AL,ctrlhdNo
 CMP StartUp.StartUpRec.HardDskExist,No
 JE  @@SetHardDskCtrl
 TEST StartUp.StartUpRec.IntExistFlags,flgInt13h
 JZ  @@NoSCSI
 ChkSCSI ; Appel la Macro ChkSCSI
 CMP AX,4321h
 JE  @@SCSI
  ; Teste le MFM
@@NoSCSI:
 TEST Jump.Jumper.FlgMethod,flgProtectedMode
 JNZ @@SkipTest                       ; Logiquement le mode prot‚g‚ veut
 PUSH ES                              ; aussi dire que le processeur est
  MOV AX,0FFFFh                       ; second‚ par un contr“leur  CMOS:
  MOV ES,AX                           ; Non?
  MOV AL,ES:[0Eh]
 POP ES
 CMP AL,0FCh
 JA  @@MFM
@@SkipTest:
 MOV AL,19h
 OUT 70h,AL
 IN  AL,71h
 CMP AL,0
 JE  @@MFM ; Pas de disque dur, en CMOS, un stool! Disque dur MFM...
 MOV AX,ctrlhdIDE
 JMP @@SetHardDskCtrl
@@SCSI:
 MOV AX,CX
 JMP @@SetHardDskCtrl
@@MFM:
 MOV AX,ctrlhdMFM
@@SetHardDskCtrl:
 MOV StartUp.StartUpRec.HardDskCtrl,AX
  ;????????????????????????????????????????????????????????????????????????
  ;??                    D‚tection de spooler d'imprimante               ??
  ;????????????????????????????????????????????????????????????????????????
 TEST StartUp.StartUpRec.IntExistFlags,flgInt1Ah
 JZ  @@NoSpooler
 TEST Jump.Jumper.FlgMethod,flgNoSpoolerDetect
 JNZ @@NoSpooler
 MOV AH,0ABh
 INT 1Ah
 CMP AH,0BAh
 JE  DskSpoolII
 MOV AH,0A0h
 INT 1Ah
 CMP AH,0B0h
 JNE @@NoSpooler
DskSpoolII:
 MOV AL,drvDiskSpoolII
 JMP nSpooler
@@NoSpooler:
 CMP StartUp.StartUpRec.Win,winNo
 JNE SpoolerPrnMan
 TEST StartUp.StartUpRec.IntExistFlags,flgInt2Fh
 JZ  @@ReallyNoSpooler
 MOV AX,0100h
 INT 02Fh
 CMP AL,0FFh
 JE  @@DosPrint
@@ReallyNoSpooler:
 MOV AL,drvNoSpooler
 JMP nSpooler
@@DosPrint:
 MOV AL,drvPrintDos
 JMP nSpooler
SpoolerPrnMan:
 MOV AL,drvPrintManager
nSpooler:
 MOV StartUp.StartUpRec.Spooler,AL
  ; *********** Ajustement des fonctions les plus ad‚quoites ***********
  ; AltPress/CtrlPress/LeftShiftPress/RightShiftPress/ShiftPress
 TEST Jump.Jumper.FlgMethod,flgProtectedMode
 JNZ @@BiosAltPress
 TEST Jump.Jumper.FlgMethod,flgEquipPerBios
 JNZ @@BiosAltPress
 CMP StartUp.StartUpRec.CPU,cpu80286
 JB  @@AltPress4Mem
 MOV AX,suAltPress4Memi286+(suCtrlPress4Memi286 shl 8)
 MOV BX,suLShiftPress4Memi286+(suRShiftPress4Memi286 shl 8)
 MOV CL,suShiftPress4Memi286
 JMP nAltPress
@@AltPress4Mem:
 MOV AX,suAltPress4Mem+(suCtrlPress4Mem shl 8)
 MOV BX,suLShiftPress4Mem+(suRShiftPress4Mem shl 8)
 MOV CL,suShiftPress4Mem
 JMP nAltPress
@@BiosAltPress:
 MOV AX,suAltPress4Bios+(suCtrlPress4Bios shl 8)
 MOV BX,suLShiftPress4Bios+(suLShiftPress4Bios shl 8)
 MOV CL,suShiftPress4Bios
nAltPress:
 MOV StartUp.StartUpRec.indAltPress,AL
 MOV StartUp.StartUpRec.indCtrlPress,AH
 MOV StartUp.StartUpRec.indLShiftPress,BL
 MOV StartUp.StartUpRec.indRShiftPress,BH
 MOV StartUp.StartUpRec.indShiftPress,CL
  ; FillChar/MoveLeft
 MOV BL,StartUp.StartUpRec.CPU
 CMP BL,15
 JBE @NoBadCPUCode
 MOV BL,0
@NoBadCPUCode:
 XOR BH,BH
 SHL BX,1
 MOV AX,Word Ptr CS:[Offset @CPUBlockTransfert+BX]
 MOV StartUp.StartUpRec.indFillChr,AL
 MOV StartUp.StartUpRec.indMove,AH
  ; GetIntVec/SetIntVec
 MOV AX,suGetIntVec4Dos+(suSetIntVec4Dos shl 8)
 TEST Jump.Jumper.FlgMethod,flgProtectedMode
 JNZ @@DosGetIntVec
 CMP StartUp.StartUpRec.Win,0
 JNE @@DosGetIntVec
 MOV AX,Word Ptr CS:[Offset @IntVec+BX]
@@DosGetIntVec:
 MOV StartUp.StartUpRec.indGetIntVec,AL
 MOV StartUp.StartUpRec.indSetIntVec,AH
  ; GetRawTimer
 TEST Jump.Jumper.FlgMethod,flgProtectedMode
 JNZ @@GetRawTimerInt1Ah
 CMP StartUp.StartUpRec.CPU,cpu80286
 JB  @@GetRawTimer4Mem
 MOV AX,suGetRawTimer4Memi286+(suGetRawTimerB4Memi286 shl 8)
 JMP nGetRawTimer
@@GetRawTimer4Mem:
 MOV AX,suGetRawTimer4Mem+(suGetRawTimerB4Mem shl 8)
 JMP nGetRawTimer
@@GetRawTimerInt1Ah:
 MOV AX,suGetRawTimer4Int1Ah+(suGetRawTimerB4Int1Ah shl 8)
nGetRawTimer:
 MOV Word Ptr StartUp.StartUpRec.indGetRawTimer,AX ; GetRawTimer/GetRawTimerB
  ; JoystickPosition
 TEST Jump.Jumper.FlgMethod,flgJoyFunc
 JZ  @@NoJoyFunc
 CMP StartUp.StartUpRec.JoyExist,Ya
 JE  @@JoyPosExist
@@NoJoyFunc:
 MOV AL,suJoyPosRet
 JMP @@EndJoyPos
@@JoyBios:
 MOV AL,suJoyPos4Bios
 JMP @@EndJoyPos
@@JoyPosExist:
 CMP StartUp.StartUpRec.JoyPort,0
 JE  @@JoyBios
 MOV AL,suJoyPos4IO
@@EndJoyPos:
 MOV StartUp.StartUpRec.indJoyPos,AL
  ; KeyPressed
 TEST Jump.Jumper.FlgMethod,flgProtectedMode
 JNZ @@KeyPressBios
; CMP StartUp.StartUpRec.Win,0
; JNE @@KeyPressDos
 MOV AL,suKeypress4Mem
 JMP nKeyPress
@@KeyPressDos:
 MOV AL,suKeypress4Dos
 JMP nKeyPress
@@KeyPressBios:
 MOV AL,suKeyPress4Bios
nKeyPress:
 MOV StartUp.StartUpRec.indKeyPress,AL
  ; PushKey
 TEST Jump.Jumper.FlgMethod,flgProtectedMode
 JNZ @@PushKeyBios
 MOV AL,suPushKey4Mem
 JMP nPushKey
@@PushKeyBios:
 MOV AL,suPushKey4Bios16h
nPushKey:
 MOV StartUp.StartUpRec.indPushKey,AL
  ; ReadKey
 TEST Jump.Jumper.FlgMethod,flgProtectedMode
 JNZ @@ReadKeyBios
 MOV AL,suReadKey4Mem
 JMP nReadKey
@@ReadKeyBios:
 MOV AL,suReadKey4Bios00h
 CMP StartUp.StartUpRec.BiosKbdEnh,No
 JE  nReadKey
 MOV AL,suReadKey4Bios10h
nReadKey:
 MOV StartUp.StartUpRec.indReadKey,AL
 CMP StartUp.StartUpRec.Win,winNT
 JE  @WinOS2
 TEST Jump.Jumper.FlgMethod,flgNotDirKey
 JNZ @WinOS2
 JMP @OS2
@WinOS2:
 MOV StartUp.StartUpRec.indReadKey,suReadKey4Bios10h
 MOV StartUp.StartUpRec.indShiftPress,suShiftPress4Bios
 MOV StartUp.StartUpRec.indCtrlPress,suCtrlPress4Bios
 MOV StartUp.StartUpRec.indAltPress,suAltPress4Bios
 MOV StartUp.StartUpRec.indLShiftPress,suLShiftPress4Bios
 MOV StartUp.StartUpRec.indRShiftPress,suRShiftPress4Bios
 CMP StartUp.StartUpRec.Win,0
 JE  @OS2
  ; ParticuliŠrement sous Windows 95 et 98, l'horloge … tendance … geler...
; MOV Word Ptr StartUp.StartUpRec.indGetRawTimer,suGetRawTimer4Cmos+(suGetRawTimer4Cmos shl 8)
@OS2:
 RET
endp

@CPUBlockTransfert:
 DW suFillChr4Def      + (suMove4Def      shl 8) ; 0=8088
 DW suFillChrPer86     + (suMovePer86     shl 8) ; 1=8086
 DW suFillChr4Def      + (suMove4Def      shl 8) ; 2=V20
 DW suFillChrPer86     + (suMovePer86     shl 8) ; 3=V30
 DW suFillChr4Def      + (suMove4Def      shl 8) ; 4=80188
 DW suFillChrPer86     + (suMovePer86     shl 8) ; 5=80186
 DW suFillChrPer86     + (suMovePer86     shl 8) ; 6=80286
 DW suFillChrPer32Bits + (suMovePer32Bits shl 8) ; 7=80386
 DW suFillChrPer32Bits + (suMovePer32Bits shl 8) ; 8=80486
 DW suFillChrPer32Bits + (suMovePer32Bits shl 8) ; 9=Cyrix 5x86
 DW suFillChrPer32Bits + (suMovePer32Bits shl 8) ; 10=Cyrix 6x86
 DW suFillChrPer32Bits + (suMovePer32Bits shl 8) ; 11=Pentium
 DW suFillChrPer32Bits + (suMovePer32Bits shl 8) ; 12=Pentium-MMX
 DW suFillChrPer32Bits + (suMovePer32Bits shl 8) ; 13=Pentium II
 DW suFillChrPer32Bits + (suMovePer32Bits shl 8) ; 14=...
 DW suFillChrPer32Bits + (suMovePer32Bits shl 8) ; 15=...

@IntVec:
 DW suGetIntVec4Mem    + (suSetIntVec4Mem     shl 8) ; 0=8088
 DW suGetIntVec4Mem    + (suSetIntVec4Mem     shl 8) ; 1=8086
 DW suGetIntVec4Mem    + (suSetIntVec4Mem     shl 8) ; 2=V20
 DW suGetIntVec4Mem    + (suSetIntVec4Mem     shl 8) ; 3=V30
 DW suGetIntVec4Mem    + (suSetIntVec4Mem     shl 8) ; 4=80188
 DW suGetIntVec4Mem    + (suSetIntVec4Mem     shl 8) ; 5=80186
 DW suGetIntVec4Mem286 + (suSetIntVec4Memi286 shl 8) ; 6=80286
 DW suGetIntVec4Mem386 + (suSetIntVec4Memi386 shl 8) ; 7=80386
 DW suGetIntVec4Mem386 + (suSetIntVec4Memi386 shl 8) ; 8=80486
 DW suGetIntVec4Mem386 + (suSetIntVec4Memi386 shl 8) ; 9=Cyrix 5x86
 DW suGetIntVec4Mem386 + (suSetIntVec4Memi386 shl 8) ; 10=Cyrix 6x86
 DW suGetIntVec4Mem386 + (suSetIntVec4Memi386 shl 8) ; 11=Pentium
 DW suGetIntVec4Mem386 + (suSetIntVec4Memi386 shl 8) ; 12=Pentium-MMX
 DW suGetIntVec4Mem386 + (suSetIntVec4Memi386 shl 8) ; 13=Pentium II
 DW suGetIntVec4Mem386 + (suSetIntVec4Memi386 shl 8) ; 14=...
 DW suGetIntVec4Mem386 + (suSetIntVec4Memi386 shl 8) ; 15=...

@BusSize:
 DB BusISA8                     ; 0=8088
 DB BusISA8                     ; 1=8086
 DB BusISA8                     ; 2=V20
 DB BusISA8                     ; 3=V30
 DB BusISA8                     ; 4=80188
 DB BusISA8                     ; 5=80186
 DB BusISA16                    ; 6=80286
 DB BusISA16                    ; 7=80386
 DB BusEISA                     ; 8=80486
 DB BusEISA                     ; 9=Cyrix 5x86
 DB BusEISA                     ; 10=Cyrix 6x86
 DB BusEISA                     ; 11=Pentium
 DB BusEISA                     ; 12=Pentium-MMX
 DB BusEISA                     ; 13=Pentium II
 DB BusEISA                     ; 14=...
 DB BusEISA                     ; 15=...

@JmpPS:
 DW Offset @@PS2                ; 00h=PS/2
 DW Offset @@PS2                ; 01h=PS/2
 DW Offset @@PS2                ; 02h=PS/2
 DW Offset @@PS2                ; 03h=PS/2
 DW Offset @@PS2                ; 04h=PS/2
 DW Offset @@SetComputerName    ; 05h=IBM PC 7566
 DW Offset @@PS2                ; 06h=PS/2
 DW Offset @@SetPS2Model55_5551 ; 07h=PS/2 ModŠle 55-5551
 DW Offset @@PS2                ; 08h=PS/2
 DW Offset @@PS2                ; 09h=PS/2
 DW Offset @@PS2                ; 0Ah=PS/2
 DW Offset @@PS2                ; 0Bh=PS/2
 DW Offset @@PS2                ; 0Ch=PS/2
 DW Offset @@PS2                ; 0Dh=PS/2
 DW Offset @@SetComputerName    ; 0Eh=PS/1 486SX
 DW Offset @@SetComputerName    ; 0Fh=PS/1 486DX
 DW Offset @@SetPS2Model55_5551 ; 10h=PS/2 ModŠle 55-5551
 DW Offset @@PS2                ; 11h=PS/2
 DW Offset @@SetPS2Model95XP    ; 12h=PS/2 ModŠle 95 XP
 DW Offset @@PS2                ; 13h=PS/2
 DW Offset @@PS2                ; 14h=PS/2
 DW Offset @@SetPS2Model90XP    ; 15h=PS/2 ModŠle 90 XP
 DW Offset @@PS2                ; 16h=PS/2
 DW Offset @@PS2                ; 17h=PS/2
 DW Offset @@PS2                ; 18h=PS/2
 DW Offset @@PS2                ; 19h=PS/2
 DW Offset @@PS2                ; 1Ah=PS/2
 DW Offset @@PS2                ; 1Bh=PS/2
 DW Offset @@PS2                ; 1Ch=PS/2
 DW Offset @@PS2                ; 1Dh=PS/2
 DW Offset @@PS2                ; 1Eh=PS/2
 DW Offset @@PS2                ; 1Fh=PS/2
 DW Offset @@PS2                ; 20h=PS/2
 DW Offset @@PS2                ; 21h=PS/2
 DW Offset @@PS2                ; 22h=PS/2
 DW Offset @@PS2                ; 23h=PS/2
 DW Offset @@PS2                ; 24h=PS/2
 DW Offset @@PS2                ; 25h=PS/2
 DW Offset @@PS2                ; 26h=PS/2
 DW Offset @@PS2                ; 27h=PS/2
 DW Offset @@PS2                ; 28h=PS/2
 DW Offset @@PS2                ; 29h=PS/2
 DW Offset @@PS2                ; 2Ah=PS/2
 DW Offset @@PS2                ; 2Bh=PS/2
 DW Offset @@PS2                ; 2Ch=PS/2
 DW Offset @@PS2                ; 2Dh=PS/2
 DW Offset @@PS2                ; 2Eh=PS/2
 DW Offset @@PS2                ; 2Fh=PS/2
 DW Offset @@SetComputerName    ; 30h=PS/1 ModŠle 2121
 DW Offset @@PS2                ; 31h=PS/2
 DW Offset @@PS2                ; 32h=PS/2
 DW Offset @@PS2                ; 33h=PS/2
 DW Offset @@PS2                ; 34h=PS/2
 DW Offset @@PS2                ; 35h=PS/2
 DW Offset @@PS2                ; 36h=PS/2
 DW Offset @@PS2                ; 37h=PS/2
 DW Offset @@PS2                ; 38h=PS/2
 DW Offset @@SetPS2Model95XP    ; 39h=PS/2 ModŠle 95 XP
 DW Offset @@PS2                ; 3Ah=PS/2
 DW Offset @@PS2                ; 3Bh=PS/2
 DW Offset @@PS2                ; 3Ch=PS/2
 DW Offset @@PS2                ; 3Dh=PS/2
 DW Offset @@PS2                ; 3Eh=PS/2
 DW Offset @@SetPS2Model90XP    ; 3Fh=PS/2 ModŠle 90 XP
 DW Offset @@SetPS2Model95XP    ; 40h=PS/2 ModŠle 95 XP
 DW Offset @@PS2                ; 41h=PS/2
 DW Offset @@PS2                ; 42h=PS/2
 DW Offset @@PS2                ; 43h=PS/2
 DW Offset @@PS2                ; 44h=PS/2
 DW Offset @@PS2                ; 45h=PS/2
 DW Offset @@PS2                ; 46h=PS/2
 DW Offset @@PS2                ; 47h=PS/2
 DW Offset @@PS2                ; 48h=PS/2
 DW Offset @@SetComputerName    ; 49h=PS/ValuePoint 325T
 DW Offset @@SetComputerName    ; 4Ah=PS/ValuePoint 425SX
 DW Offset @@SetComputerName    ; 4Bh=PS/ValuePoint 433DX
 DW Offset @@PS2                ; 4Ch=PS/2
 DW Offset @@PS2                ; 4Dh=PS/2
 DW Offset @@PS2                ; 4Eh=PS/2
 DW Offset @@PS2                ; 4Fh=PS/2
 DW Offset @@PS2                ; 50h=PS/2
 DW Offset @@PS2                ; 51h=PS/2
 DW Offset @@PS2                ; 52h=PS/2
 DW Offset @@PS2                ; 53h=PS/2
 DW Offset @@PS2                ; 54h=PS/2
 DW Offset @@PS2                ; 55h=PS/2
 DW Offset @@PS2                ; 56h=PS/2
 DW Offset @@SetPS2Model90XP    ; 57h=PS/2 ModŠle 90 XP
 DW Offset @@SetPS2Model95XP    ; 58h=PS/2 ModŠle 95 XP
 DW Offset @@SetPS2Model90XP    ; 59h=PS/2 ModŠle 90 XP
 DW Offset @@SetPS2Model95XP    ; 5Ah=PS/2 ModŠle 95 XP
 DW Offset @@SetPS2Model90XP    ; 5Bh=PS/2 ModŠle 90 XP
 DW Offset @@SetPS2Model95XP    ; 5Ch=PS/2 ModŠle 95 XP
 DW Offset @@PS2                ; 5Dh=PS/2
 DW Offset @@SetComputerName    ; 5Eh=IBM ThinkPad 700
 DW Offset @@PS2                ; 5Fh=PS/2
 DW Offset @@PS2                ; 60h=PS/2
 DW Offset @@SetComputerName    ; 61h=Olivetti P500
 DW Offset @@SetComputerName    ; 62h=Olivetti P800

;DB 13,10
;DB "ÛÛÛÛÛÛÛÛÛÛÛÛÛ   ÛÛÛÛÛÛÛÛÛÛÛÛÛ",13,10
;DB "ÛÛÛÛÛÛ ÛÛÛÛÛÛ   ÛÛÛÛÛÛ ÛÛÛÛÛÛ",13,10
;DB "ÛÛ ÛÛ   ÛÛ ÛÛ   ÛÛ ÛÛ   ÛÛ ÛÛ",13,10
;DB "Û Û Û   Û Û Û   Û Û Û   Û Û Û",13,10
;DB "ÛÛÛ ÛÛ ÛÛ ÛÛÛ   ÛÛÛ ÛÛ ÛÛ ÛÛÛ",13,10
;DB "ÛÛ         ÛÛ   ÛÛ         ÛÛ",13,10
;DB "ÛÛÛÛÛÛ ÛÛÛÛÛÛ   ÛÛÛÛÛÛ ÛÛÛÛÛÛ",13,10
;DB "ÛÛÛÛÛ   ÛÛÛÛÛ   ÛÛÛÛÛ   ÛÛÛÛÛ",13,10
;DB "ÛÛÛÛÛÛ ÛÛÛÛÛÛ   ÛÛÛÛÛÛ ÛÛÛÛÛÛ",13,10
;DB "ÛÛÛÛÛÛÛÛÛÛÛÛÛ   ÛÛÛÛÛÛÛÛÛÛÛÛÛ",13,10
;DB "                             ",13,10
;DB "ÛÛÛÛÛÛÛÛÛÛÛÛÛ   ÛÛÛÛÛÛÛÛÛÛÛÛÛ",13,10
;DB "ÛÛÛÛÛÛ ÛÛÛÛÛÛ   ÛÛÛÛÛÛ ÛÛÛÛÛÛ",13,10
;DB "ÛÛ ÛÛ   ÛÛ ÛÛ   ÛÛ ÛÛ   ÛÛ ÛÛ",13,10
;DB "Û Û Û   Û Û Û   Û Û Û   Û Û Û",13,10
;DB "ÛÛÛ ÛÛ ÛÛ ÛÛÛ   ÛÛÛ ÛÛ ÛÛ ÛÛÛ",13,10
;DB "ÛÛ         ÛÛ   ÛÛ         ÛÛ",13,10
;DB "ÛÛÛÛÛÛ ÛÛÛÛÛÛ   ÛÛÛÛÛÛ ÛÛÛÛÛÛ",13,10
;DB "ÛÛÛÛÛ   ÛÛÛÛÛ   ÛÛÛÛÛ   ÛÛÛÛÛ",13,10
;DB "ÛÛÛÛÛÛ ÛÛÛÛÛÛ   ÛÛÛÛÛÛ ÛÛÛÛÛÛ",13,10
;DB "ÛÛÛÛÛÛÛÛÛÛÛÛÛ   ÛÛÛÛÛÛÛÛÛÛÛÛÛ",13,10
;DB "VIVE LUCIEN BOUCHARD!",13,10
;DB "VIVE JACQUES PARIZEAU!",13,10
;DB "VIVE REN LVESQUES!",13,10
;DB "VIVE RICHARD TERRIEN!",13,10
;DB "VIVE ERROL BOUCHETTE!",13,10
;DB "VIVE LOUIS RIEL!",13,10
;DB "VIVE LVIS!",13,10
;DB "VIVE CARILLON!",13,10
;DB "VIVE LOUIS DE CALLIERE!",13,10
;DB "VIVE FRONTENAC!",13,10
;DB "VIVE JEAN NICOLET!",13,10
;DB "VIVE SAMUEL DE CHAMPLAIN!",13,10
;DB "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ",13,10
;DB "MORT A LA GRC$",13,10
;DB "MORT AU FDRAL$",13,10
;DB "MORT AU CANADA$",13,10
;DB "MORT AU ANGLAIS DU CANADA$",13,10
;DB "MORT AU CAPITALISTE CORROMPU$",13,10
;DB "MORT A LEUR MDIOCRIT$",13,10
;DB "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ",13,10
;DB "VIVE LE QUBEC LIBRES!!!!!!!!",13,10

MtxStartUp Proc Far
   ;Adresse                     Longueur                                                       Index
   ;ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ ÍÍÍÍÍÍÍÍÍÍÍÍ
;8088
DW Offset xAltPress,            Offset nxAltPress-xAltPress+1                                  ; 0
DW Offset xCtrlPress,           Offset nxCtrlPress-Offset xCtrlPress+1                         ; 1
DW Offset xFillChar,            Offset nxFillChar-Offset xFillChar+1                           ; 2
DW Offset xGetIntVec,           Offset nxGetIntVec-Offset xGetIntVec+1                         ; 3
DW Offset xGetRawTimer,         Offset nxGetRawTimer-Offset xGetRawTimer+1                     ; 4
DW Offset xGetRawTimerB,        Offset nxGetRawTimerB-Offset xGetRawTimerB+1                   ; 5
DW Offset xJoyPos,              Offset nxJoyPos-Offset xJoyPos+1                               ; 6
DW Offset xKeyPress,            Offset nxKeyPress-Offset xKeyPress+1                           ; 7
DW Offset xLShiftPress,         Offset nxLShiftPress-Offset xLShiftPress+1                     ; 8
DW Offset xMove,                Offset nxMove-Offset xMove+1                                   ; 9
DW Offset xPushKey,             Offset nxPushKey-Offset xPushKey+1               ; 10
DW Offset xRawReadKey,          Offset nxRawReadKey-Offset xRawReadKey+1         ; 11
DW Offset xRShiftPress,         Offset nxRShiftPress-Offset xRShiftPress+1             ; 12
DW Offset xSetIntVec,           Offset nxSetIntVec-Offset xSetIntVec+1                 ; 13
DW Offset xShiftPress,          Offset nxShiftPress-Offset xShiftPress+1               ; 14
;80286
DW Offset xAltPress286,         Offset nxAltPress286-Offset xAltPress286+1       ; 15
DW Offset xCtrlPress286,        Offset nxCtrlPress286-Offset xCtrlPress286+1     ; 16
DW Offset xFillChar,            Offset nxFillChar-Offset xFillChar+1             ; 17
DW Offset xGetIntVec286,        Offset nxGetIntVec286-Offset xGetIntVec286+1     ; 18
DW Offset xGetRawTimer286,      Offset nxGetRawTimer286-Offset xGetRawTimer286+1 ; 19
DW Offset xGetRawTimerB,        Offset nxGetRawTimerB-Offset xGetRawTimerB+1     ; 20
DW Offset xJoyPos,              Offset nxJoyPos-Offset xJoyPos+1                 ; 21
DW Offset xKeyPress,            Offset nxKeyPress-Offset xKeyPress+1             ; 22
DW Offset xLShiftPress,         Offset nxLShiftPress-Offset xLShiftPress+1       ; 23
DW Offset xMove,                Offset nxMove-Offset xMove+1                     ; 24
DW Offset xPushKey,             Offset nxPushKey-Offset xPushKey+1               ; 25
DW Offset xRawReadKey,          Offset nxRawReadKey-Offset xRawReadKey+1         ; 26
DW Offset xRShiftPress,         Offset nxRShiftPress-Offset xRShiftPress+1             ; 27
DW Offset xSetIntVec286,        Offset nxSetIntVec286-Offset xSetIntVec286+1           ; 28
DW Offset xShiftPress,          Offset nxShiftPress-Offset xShiftPress+1               ; 29
;80386
DW Offset xAltPress286,         Offset nxAltPress286-Offset xAltPress286+1       ; 30
DW Offset xCtrlPress286,        Offset nxCtrlPress286-Offset xCtrlPress286+1     ; 31
DW Offset xFillChar386,         Offset nxFillChar386-Offset xFillChar386+1       ; 32
DW Offset xGetIntVec386,        Offset nxGetIntVec386-Offset xGetIntVec386+1     ; 33
DW Offset xGetRawTimer286,      Offset nxGetRawTimer286-Offset xGetRawTimer286+1 ; 34
DW Offset xGetRawTimerB,        Offset nxGetRawTimerB-Offset xGetRawTimerB+1     ; 35
DW Offset xJoyPos,              Offset nxJoyPos-Offset xJoyPos+1                 ; 36
DW Offset xKeyPress,            Offset nxKeyPress-Offset xKeyPress+1             ; 37
DW Offset xLShiftPress,         Offset nxLShiftPress-Offset xLShiftPress+1       ; 38
DW Offset xMove386,             Offset nxMove386-Offset xMove386+1                         ; 39
DW Offset xPushKey,             Offset nxPushKey-Offset xPushKey+1               ; 40
DW Offset xRawReadKey,          Offset nxRawReadKey-Offset xRawReadKey+1         ; 41
DW Offset xRShiftPress,         Offset nxRShiftPress-Offset xRShiftPress+1             ; 42
DW Offset xSetIntVec386,        Offset nxSetIntVec386-Offset xSetIntVec386+1           ; 43
DW Offset xShiftPress,          Offset nxShiftPress-Offset xShiftPress+1               ; 44
;BIOS/DOS
DW Offset @biosAltPress,        Offset @EndBiosAltPress-Offset @biosAltPress+1                 ; 45
DW Offset @biosCtrlPress,       Offset @EndBiosCtrlPress-Offset @biosCtrlPress+1               ; 46
DW Offset xFillChar88,          Offset nxFillChar88-Offset xFillChar88+1         ; 47
DW Offset @dosGetIntVec,        Offset @EndDosGetIntVec-Offset @dosGetIntVec+1                 ; 48
DW Offset @biosGetRawTimer,     Offset @EndBiosGetRawTimer-Offset @biosGetRawTimer+1           ; 49
DW Offset @biosGetRawTimerB,    Offset @EndBiosGetRawTimerB-Offset @biosGetRawTimerB+1         ; 50
DW Offset @biosJoyPos,          Offset @EndBiosJoyPos-Offset @biosJoyPos+1                     ; 51
DW Offset @biosKeyPress,        Offset @EndBiosKeyPress-Offset @biosKeyPress+1                 ; 52
DW Offset @biosLShiftPress,     Offset @EndBiosLShiftPress-Offset @biosLShiftPress+1           ; 53
DW Offset xMove88,              Offset nxMove88-Offset xMove88+1                 ; 54
DW Offset @biosPushKey,         Offset @EndBiosPushKey-Offset @biosPushKey+1                   ; 55
DW Offset @bios00hRawReadKey,   Offset @EndBios00hRawReadKey-Offset @bios00hRawReadKey+1       ; 56
DW Offset @biosRShiftPress,     Offset @EndBiosRShiftPress-Offset @biosRShiftPress+1           ; 57
DW Offset @dosSetIntVec,        Offset @EndDosSetIntVec-Offset @dosSetIntVec+1                 ; 58
DW Offset @biosShiftPress,      Offset @EndBiosShiftPress-Offset @biosShiftPress+1             ; 59
;BIOS/DOS AT
DW Offset @biosAltPress,        Offset @EndBiosAltPress-Offset @biosAltPress+1                 ; 60
DW Offset @biosCtrlPress,       Offset @EndBiosCtrlPress-Offset @biosCtrlPress+1               ; 61
DW Offset xFillChar,            Offset nxFillChar-Offset xFillChar+1             ; 62
DW Offset @dosGetIntVec,        Offset @EndDosGetIntVec-Offset @dosGetIntVec+1                 ; 63
DW Offset @biosGetRawTimer,     Offset @EndBiosGetRawTimer-Offset @biosGetRawTimer+1           ; 64
DW Offset @biosGetRawTimerB,    Offset @EndBiosGetRawTimerB-Offset @biosGetRawTimerB+1         ; 65
DW Offset @biosJoyPos,          Offset @EndBiosJoyPos-Offset @biosJoyPos+1                     ; 66
DW Offset @biosKeyPress,        Offset @EndBiosKeyPress-Offset @biosKeyPress+1                 ; 67
DW Offset @biosLShiftPress,     Offset @EndBiosLShiftPress-Offset @biosLShiftPress+1           ; 68
DW Offset xMove,                Offset nxMove-Offset xMove+1                                   ; 69
DW Offset @biosPushKey,         Offset @EndBiosPushKey-Offset @biosPushKey+1                   ; 70
DW Offset @bios10hRawReadKey,   Offset @EndBios10hRawReadKey-Offset @bios10hRawReadKey+1       ; 71
DW Offset @biosRShiftPress,     Offset @EndBiosRShiftPress-Offset @biosRShiftPress+1           ; 72
DW Offset @dosSetIntVec,        Offset @EndDosSetIntVec-Offset @dosSetIntVec+1                 ; 73
DW Offset @biosShiftPress,      Offset @EndBiosShiftPress-Offset @biosShiftPress+1             ; 74
;DOS
DW Offset @biosAltPress,        Offset @EndBiosAltPress-Offset @biosAltPress+1                 ; 75
DW Offset @biosCtrlPress,       Offset @EndBiosCtrlPress-Offset @biosCtrlPress+1               ; 76
DW Offset xFillChar,            Offset nxFillChar-Offset xFillChar+1             ; 77
DW Offset @dosGetIntVec,        Offset @EndDosGetIntVec-Offset @dosGetIntVec+1                 ; 78
DW Offset @biosGetRawTimer,     Offset @EndBiosGetRawTimer-Offset @biosGetRawTimer+1           ; 79
DW Offset @biosGetRawTimerB,    Offset @EndBiosGetRawTimerB-Offset @biosGetRawTimerB+1         ; 80
DW Offset @biosJoyPos,          Offset @EndBiosJoyPos-Offset @biosJoyPos+1                     ; 81
DW Offset @dosKeyPress,         Offset @EndDosKeyPress-Offset @dosKeyPress+1                   ; 82
DW Offset @biosLShiftPress,     Offset @EndBiosLShiftPress-Offset @biosLShiftPress+1           ; 83
DW Offset xMove,                Offset nxMove-Offset xMove+1                     ; 84
DW Offset @biosPushKey,         Offset @EndBiosPushKey-Offset @biosPushKey+1                   ; 85
DW Offset @dosRawReadKey,       Offset @EndDosRawReadKey-Offset @DosRawReadKey+1                  ; 86
DW Offset @biosRShiftPress,     Offset @EndBiosRShiftPress-Offset @biosRShiftPress+1           ; 87
DW Offset @dosSetIntVec,        Offset @EndDosSetIntVec-Offset @dosSetIntVec+1                 ; 88
DW Offset @biosShiftPress,      Offset @EndBiosShiftPress-Offset @biosShiftPress+1             ; 89
;Vide
DW Offset @biosAltPress,        Offset @EndBiosAltPress-Offset @biosAltPress+1                 ; 90
DW Offset @biosCtrlPress,       Offset @EndBiosCtrlPress-Offset @biosCtrlPress+1               ; 91
DW Offset xFillChar,            Offset nxFillChar-Offset xFillChar+1                           ; 92
DW Offset @dosGetIntVec,        Offset @EndDosGetIntVec-Offset @dosGetIntVec+1                 ; 93
DW Offset @biosGetRawTimer,     Offset @EndBiosGetRawTimer-Offset @biosGetRawTimer+1           ; 94
DW Offset @biosGetRawTimerB,    Offset @EndBiosGetRawTimerB-Offset @biosGetRawTimerB+1         ; 95
DW Offset @retJoyPos,           Offset @EndRetJoyPos-Offset @retJoyPos+1                       ; 96
DW Offset @biosKeyPress,        Offset @EndBiosKeyPress-Offset @biosKeyPress+1                 ; 97
DW Offset @biosLShiftPress,     Offset @EndBiosLShiftPress-Offset @biosLShiftPress+1           ; 98
DW Offset xMove,                Offset nxMove-Offset xMove+1                     ; 99
DW Offset @biosPushKey,         Offset @EndBiosPushKey-Offset @biosPushKey+1                   ; 100
DW Offset @bios10hRawReadKey,   Offset @EndBios10hRawReadKey-Offset @bios10hRawReadKey+1       ; 101
DW Offset @biosRShiftPress,     Offset @EndBiosRShiftPress-Offset @biosRShiftPress+1           ; 102
DW Offset @dosSetIntVec,        Offset @EndDosSetIntVec-Offset @dosSetIntVec+1                 ; 103
DW Offset @biosShiftPress,      Offset @EndBiosShiftPress-Offset @biosShiftPress+1             ; 104

DW Offset @cmosGetRawTimer,     Offset @EndcmosGetRawTimer-Offset @cmosGetRawTimer+1           ; 105
endp

;DB "Clavier.AltEnfonc‚(direct)"
xAltPress:
directAltPress Proc Pascal Far
 XOR AX,AX
 MOV ES,AX
 PUSHF
  CLI
  MOV AL,ES:[0417h]
 POPF
 AND AL,8
 JZ @dAP
 MOV AL,Ya
@dAP:
 RET
endp
nxAltPress:

;DB "Clavier.AltEnfonc‚(direct:80286)"
xAltPress286:
directAltPress286 Proc Pascal Far
.286
 PUSH 0000h
 POP ES
 PUSHF
  CLI
  MOV AL,ES:[0417h]
 POPF
 AND AL,8
 JZ @dAP2
 MOV AL,Ya
@dAP2:
 RET
.8086
endp
nxAltPress286:

;DB "Clavier.AltEnfonc‚(BIOS)"
@biosAltPress:
biosAltPress Proc Far
 MOV AH,02h
 INT 16h
 AND AL,8
 JZ  @bAP
 MOV AL,Ya
@bAP:
 RET
endp
@EndBiosAltPress:

;DB "Clavier.CtrlEnfonc‚(direct)"
xCtrlPress:
directCtrlPress Proc Pascal Far
 XOR AX,AX
 MOV ES,AX
 PUSHF
  CLI
  MOV AL,ES:[0417h]
 POPF
 AND AL,4
 JZ @dCP
 MOV AL,Ya
@dCP:
 RET
endp
nxCtrlPress:

;DB "Clavier.CtrlEnfonc‚(direct:80286)"
xCtrlPress286:
directCtrlPress286 Proc Pascal Far
.286
 PUSH 0000h
 POP ES
 PUSHF
  CLI
  MOV AL,ES:[0417h]
 POPF
 AND AL,4
 JZ @dCP2
 MOV AL,Ya
@dCP2:
 RET
.8086
endp
nxCtrlPress286:

;DB "Clavier.CtrlEnfonc‚(BIOS)"
@biosCtrlPress:
biosCtrlPress Proc Pascal Far
 MOV AH,02h
 INT 16h
 AND AL,4
 JZ  @bCP
 MOV AL,Ya
@bCP:
 RET
endp
@EndBiosCtrlPress:

;DB "M‚moire.ClaireAvecDesCaractŠres(direct:8088)"
xFillChar88:
directFillChar88 Proc Pascal Far X:DWord,Len:Word,Value:Byte
 CLD
 LES DI,X
 MOV CX,Len
 MOV AL,Value
 REP STOSB
EndProc
nxFillChar88:

;DB "M‚moire.ClaireAvecDesCaractŠres(direct:8086)"
xFillChar:
directFillChar Proc Pascal Far X:DWord,Len:Word,Value:Byte
 CLD
 LES DI,X
 MOV CX,Len
 MOV AL,Value
 MOV AH,AL
 SHR CX,1
 REP STOSW
 ADC CX,CX
 REP STOSB
EndProc
nxFillChar:

;DB "M‚moire.ClaireAvecDesCaractŠres(direct:80386)"
xFillChar386:
directFillChar386 Proc Pascal Far X:DWord,Len:Word,Value:Byte
.286
 CLD
 LES DI,X
 MOV CX,Len
 MOV AL,Value
 MOV AH,AL
 PUSH AX
 PUSH AX
.386
 POP EAX
.286
 MOV BX,CX
 AND BX,3
 SHR CX,2
.386
 REP STOSD
.286
 MOV CX,BX
 REP STOSB
.8086
EndProc
nxFillChar386:

;DB "M‚moire.LitVecteurInterruption(direct)"
xGetIntVec:
directGetIntVec Proc Pascal Far IntNo:Byte,Vector:DWord
 XOR BX,BX
 MOV ES,BX
 MOV BL,IntNo
 SHL BX,1
 SHL BX,1
 CLI
 MOV AX,ES:[BX]   ; Vector.Ofs := MemW[0:IntNo shl 2]
 MOV DX,ES:[BX+2] ; Vector.Seg := MemW[0:(IntNo shl 2)+2]
 STI
 LES DI,Vector
 MOV ES:[DI],AX
 MOV ES:[DI+2],DX
EndProc
nxGetIntVec:

;DB "M‚moire.LitVecteurInterruption(direct:80286)"
xGetIntVec286:
directGetIntVec286 Proc Pascal Far IntNo:Byte,Vector:DWord
.286
 XOR BX,BX
 MOV ES,BX
 MOV BL,IntNo
 SHL BX,2
 CLI
 MOV AX,ES:[BX]   ; Vector.Ofs := MemW[0:IntNo shl 2]
 MOV DX,ES:[BX+2] ; Vector.Seg := MemW[0:(IntNo shl 2)+2]
 STI
 LES DI,Vector
 MOV ES:[DI],AX
 MOV ES:[DI+2],DX
.8086
EndProc
nxGetIntVec286:

;DB "M‚moire.LitVecteurInterruption(direct:80386)"
xGetIntVec386:
directGetIntVec386 Proc Pascal Far IntNo:Byte,Vector:DWord
.286
 XOR BX,BX
 MOV ES,BX
 MOV BL,IntNo
 SHL BX,2
 CLI
.386
 MOV EAX,ES:[BX]
.286
 STI
 LES DI,Vector
.386
 MOV ES:[DI],EAX
.286
.8086
EndProc
nxGetIntVec386:

;DB "M‚moire.LitVecteurInterruption(DOS)"
@dosGetIntVec:
dosGetIntVec Proc Pascal Far IntNo:Byte,Vector:DWord
 MOV AL,IntNo
 MOV AH,035h
 INT 021h
 MOV AX,ES
 LES DI,Vector
 CLD
 XCHG AX,BX
 STOSW
 XCHG AX,BX
 STOSW
EndProc
@EndDosGetIntVec:

;DB "Horloge.LitHeureBrute(direct)"
xGetRawTimer:
directGetRawTimer Proc Pascal Far
 XOR AX,AX
 MOV ES,AX
 PUSHF
  CLI
  LES AX,ES:[046Ch]
 POPF
 MOV DX,ES
EndFunc
nxGetRawTimer:

;DB "Horloge.LitHeureBrute(direct:80286)"
xGetRawTimer286:
directGetRawTimer286 Proc Pascal Far
.286
 PUSH 0000h
 POP ES
 PUSHF
  CLI
  LES AX,ES:[046Ch]
 POPF
 MOV DX,ES
.8086
EndFunc
nxGetRawTimer286:

;DB "Horloge.LitHeureBrute(CMOS)"
@cmosGetRawTimer:
cmosGetRawTimer Proc Pascal Far
 XOR AX,AX
 XOR DX,DX
 OUT 70h,AL
 IN  AL,71h
 MOV BL,AL
 MOV BH,AL
 AND BL,0Fh
 MOV CL,4
 SHR BH,CL
 MOV AL,10
 MUL BH
 ADD BL,AL
 MOV AL,18
 MUL BL
 MOV SI,AX
 MOV AL,2
 OUT 70h,AL
 IN  AL,71h
 MOV BL,AL
 MOV BH,AL
 AND BL,0Fh
 MOV CL,4
 SHR BH,CL
 MOV AL,10
 MUL BH
 ADD BL,AL
 MOV AL,182
 MUL BL
 MOV BX,6
 MUL BX
 ADD AX,SI
 ADC DX,0
 MOV SI,AX
 MOV DI,DX
 MOV AL,4
 OUT 070h,AL
 IN  AL,071h
 MOV BL,AL
 MOV BH,AL
 AND BL,0Fh
 MOV CL,4
 SHR BH,CL
 MOV AL,10
 MUL BH
 ADD BL,AL
 MOV AL,182
 MUL BL
 MOV BX,60*6
 MUL BX
 ADD AX,SI
 ADC DX,DI
EndFunc
@EndCmosGetRawTimer:

;DB "Horloge.LitHeureBrute(Bios)"
@biosGetRawTimer:
biosGetRawTimer Proc Pascal Far
 XOR AX,AX
 INT 1Ah
 XCHG AX,DX
 MOV DX,CX
EndFunc
@EndBiosGetRawTimer:

;DB "Horloge.LitHeureBruteOctet(direct)"
xGetRawTimerB:
directGetRawTimerB Proc Pascal Far
 XOR AX,AX
 MOV ES,AX
 PUSHF
  CLI
  MOV AL,ES:[046Ch]
 POPF
EndFunc
nxGetRawTimerB:

;DB "Horloge.LitHeureBruteOctet(Bios)"
@biosGetRawTimerB:
biosGetRawTimerB Proc Pascal Far
 XOR AX,AX
 INT 1Ah
 XCHG AX,DX
EndFunc
@EndBiosGetRawTimerB:

;DB "ManetteDeJeux.LitPosition(direct)"
xJoyPos:
directJoyPos Proc Pascal Far Axe:Byte
 MOV CL,Axe
 MOV BX,1
 SHL BX,CL
 MOV CX,0FFFFh
 XOR AX,AX
 XOR SI,SI
 MOV DX,0201h
 CLI
 OUT DX,AL
@@Next:
 IN   AL,DX
 TEST AL,BL
 JE   @@Done
 INC  SI
 LOOP @@Next
@@Done:
 STI
 MOV AX,SI
@@End:
EndFunc
nxJoyPos:

;DB "ManetteDeJeux.LitPosition(Bios)"
@biosJoyPos:
biosJoyPos Proc Pascal Far Axe:Byte
 MOV AH,84h
 MOV DX,01h
 INT 015h
 CMP Axe,0
 JE  @EbJP
 MOV BX,AX
 CMP Axe,1
 MOV CX,AX
 CMP Axe,2
 JE  @EbJP
 MOV DX,AX
@EbJP:
EndFunc
@EndBiosJoyPos:

@retJoyPos:
retJoyPos Proc Pascal Far Axe:Byte
EndFunc
@EndRetJoyPos:

;DB "Clavier.ToucheEnfonc‚(direct)"
xKeyPress:
directKeyPress Proc Pascal Far
 XOR AX,AX
 MOV ES,AX
 PUSHF
  CLI
  LES DX,ES:[041Ah]
 POPF
 MOV BX,ES
 CMP BX,DX
 JE  @eKP
 MOV AL,Ya
@eKP:
EndFunc
nxKeyPress:

;DB "Clavier.ToucheEnfonc‚(bios)"
@biosKeyPress:
biosKeyPress Proc Pascal Far
 MOV AX,1
 INT 16h
 MOV AL,No
 JZ  @ebKP
 MOV AL,Ya
@ebKP:
EndFunc
@EndBiosKeyPress:

;DB "Clavier.ToucheEnfonc‚(Dos)"
@dosKeyPress:
dosKeyPress Proc Pascal Far
 MOV AH,0Bh
 INT 21h
 AND AL,1
EndFunc
@EndDosKeyPress:

;DB "Clavier.ShiftGaucheEnfonc‚(direct)"
xLShiftPress:
directLShiftPress Proc Pascal Far
 XOR AX,AX
 MOV ES,AX
 PUSHF
  CLI
  MOV AL,ES:[0417h]
 POPF
 AND AL,2
 JZ @eLSP
 MOV AL,Ya
@eLSP:
EndFunc
nxLShiftPress:

;DB "Clavier.ShiftGaucheEnfonc‚(bios)"
@biosLShiftPress:
biosLShiftPress Proc Pascal Far
 MOV AH,02h
 INT 16h
 AND AL,2
 JZ  @ebLSP
 MOV AL,Ya
@ebLSP:
EndFunc
@EndBiosLShiftPress:

;DB "M‚moire.D‚place(direct:8088)"
xMove88:
directMove88 Proc Pascal Far Source:DWord,Dest:DWord,Count:Word
 CLD
 PUSH DS
  LDS SI,Source
  LES DI,Dest
  MOV CX,ES
  OR  CX,DI
  JZ  @NoMove88
  MOV CX,Count
  REP MOVSB
@NoMove88:
 POP DS
EndProc
nxMove88:

;DB "M‚moire.D‚place(direct:8086)"
xMove:
directMove Proc Pascal Far Source:DWord,Dest:DWord,Count:Word
 CLD
 PUSH DS
  LDS SI,Source
  LES DI,Dest
  MOV CX,ES
  OR  CX,DI
  JZ  @NoMove86
  MOV CX,Count
  SHR CX,1
  REP MOVSW
  ADC CX,CX
  REP MOVSB
@NoMove86:
 POP DS
EndProc
nxMove:

;DB "M‚moire.D‚place(direct:80386)"
xMove386:
directMove386 Proc Pascal Far Source:DWord,Dest:DWord,Count:Word
.286
 CLD
 PUSH DS
  LDS SI,Source
  LES DI,Dest
  MOV CX,ES
  OR  CX,DI
  JZ  NoMove386
  MOV CX,Count
  MOV BX,CX
  AND BX,3
  SHR CX,2
.386
  REP MOVSD
.286
  MOV CX,BX
  REP MOVSB
NoMove386:
 POP  DS
.8086
EndProc
nxMove386:

;DB "Clavier.InjecteUneTouche(direct)"
xPushKey:
directPushKey Proc Pascal Far K:Word
 MOV AX,0040h
 MOV ES,AX
 MOV AX,K
 PUSHF
 CLI
 MOV BX,ES:[1Ch]
 MOV ES:[BX],AX
 INC BX
 INC BX
 MOV ES:[1Ch],BX
 MOV AX,ES:[82h]
 CMP AX,BX
 JNE @ePK
 MOV AX,ES:[80h]
 MOV ES:[1Ch],AX
; CMP AX,BX
; JNE @ePKNor
; MOV AX,ES:[80h]
; MOV ES:[1Ch],AX
; POPF
; JMP @ePK
;@ePKNor:
; MOV ES:[1Ch],BX
; MOV AX,ES:[82h]
; POPF
@ePK:
; STI
 POPF
EndProc
nxPushKey:

;DB "Clavier.InjecteUneTouche(Bios)"
@biosPushKey:
biosPushKey Proc Pascal Far K:Word
 MOV AX,0005h
 MOV CX,K
 INT 16h
EndProc
@EndBiosPushKey:

;DB "Clavier.LitTouche(direct)"
xRawReadKey:
directRawReadKey Proc Pascal Far
 MOV AX,0040h
 MOV ES,AX
 PUSHF
 CLI
 MOV BX,ES:[1Ah]
 MOV AX,ES:[BX]
 INC BX
 INC BX
 MOV CX,ES:[082h]
 CMP CX,BX
 JNE @@IncBufKey
 MOV CX,ES:[080h]
 MOV ES:[01Ah],CX
 POPF
 JMP @@EndRRK
@@IncBufKey:
 MOV ES:[01Ah],BX
 POPF
@@EndRRK:
 CMP AL,0E0h
 JE  @NotOkRRK
 CMP AL,0D0h
 JNE @@OkRRK
@NotOkRRK:
 OR  AH,AH
 JE  @@OkRRK
 MOV AL,0
@@OkRRK:
EndFunc
nxRawReadKey:

;DB "Clavier.LitTouche(Bios00h)"
@bios00hRawReadKey:
bios00hRawReadKey Proc Pascal Far
 XOR AX,AX
 INT 16h
EndFunc
@EndBios00hRawReadKey:

;DB "Clavier.LitTouche(Bios10h)"
@bios10hRawReadKey:
bios10hRawReadKey Proc Pascal Far
 MOV AX,1000h
 INT 16h
 CMP AL,0E0h
 JE  @10NotOkRRK
 CMP AL,0D0h
 JNE @@10OkRRK
@10NotOkRRK:
 OR  AH,AH
 JE  @@10OkRRK
 MOV AL,0
@@10OkRRK:
 CMP AX,1A00h
 JE  @10RRKAltSet
 CMP AX,1B00h
 JE  @10RRKAltSet
 CMP AX,2800h
 JE  @10RRKAltSet
 CMP AX,2900h
 JE  @10RRKAltSet
 CMP AX,2B00h
 JE  @10RRKAltSet
 CMP AX,4A00h
 JE  @10RRKAltSet
 CMP AX,4C00h
 JNE @10RRKAltB
@10RRKAltSet:
 MOV AL,0F0h
@10RRKAltB:
EndFunc
@EndBios10hRawReadKey:

;DB "Clavier.LitTouche(Dos)"
@DosRawReadKey:
DosRawReadKey Proc Pascal Far
 MOV AX,08h
 INT 21h
 XOR AH,AH
 OR  AL,AL
 JNE DRRKF
 MOV AX,08h
 INT 21h
 MOV AH,AL
 XOR AL,AL
DRRKF:
EndFunc
@EndDosRawReadKey:

;DB "Clavier.ShiftDroitEnfonc‚(direct)"
xRShiftPress:
directRShiftPress Proc Pascal Far
 XOR AX,AX
 MOV ES,AX
 PUSHF
  CLI
  MOV AL,ES:[0417h]
 POPF
 AND AL,1
EndFunc
nxRShiftPress:

;DB "Clavier.ShiftDroitEnfonc‚(Bios)"
@biosRShiftPress:
biosRShiftPress Proc Pascal Far
 MOV AH,02h
 INT 16h
 AND AL,1
EndFunc
@EndBiosRShiftPress:

;DB "M‚moire.FixeVecteurInterruption(direct:8088)"
xSetIntVec:
directSetIntVec Proc Pascal Far IntNo:Byte,Vector:DWord
 XOR BX,BX
 MOV ES,BX
 MOV BL,IntNo
 SHL BX,1
 SHL BX,1
 MOV AX,Word Ptr Vector[0]
 MOV DX,Word Ptr Vector[2]
 CLI
 MOV ES:[BX],AX   ; Vector.Ofs := MemW[0:IntNo shl 2]
 MOV ES:[BX+2],DX ; Vector.Seg := MemW[0:(IntNo shl 2)+2]
 STI
EndProc
nxSetIntVec:

;DB "M‚moire.FixeVecteurInterruption(direct:80286)"
xSetIntVec286:
directSetIntVec286 Proc Pascal Far IntNo:Byte,Vector:DWord
.286
 XOR BX,BX
 MOV ES,BX
 MOV BL,IntNo
 SHL BX,2
 MOV AX,Word Ptr Vector
 MOV DX,Word Ptr Vector[2]
 CLI
 MOV ES:[BX],AX   ; Vector.Ofs := MemW[0:IntNo shl 2]
 MOV ES:[BX+2],DX ; Vector.Seg := MemW[0:(IntNo shl 2)+2]
 STI
.8086
EndProc
nxSetIntVec286:

;DB "M‚moire.FixeVecteurInterruption(direct:80386)"
xSetIntVec386:
directSetIntVec386 Proc Pascal Far IntNo:Byte,Vector:DWord
.286
 XOR BX,BX
 MOV ES,BX
 MOV BL,IntNo
.386
 SHL BX,2
 MOV EAX,Vector
 CLI
 MOV ES:[BX],EAX
 STI
.286
.8086
EndProc
nxSetIntVec386:

;DB "M‚moire.FixeVecteurInterruption(Dos)"
@dosSetIntVec:
dosSetIntVec Proc Pascal Far IntNo:Byte,Vector:DWord
 PUSH DS
  LDS DX,Vector
  MOV AL,IntNo
  MOV AH,25h
  INT 21h
 POP DS
EndProc
@EndDosSetIntVec:

;DB "Clavier.ShiftEnfonc‚(direct)"
xShiftPress:
directShiftPress Proc Pascal Far
 XOR AX,AX
 MOV ES,AX
 PUSHF
  CLI
  MOV AL,ES:[0417h]
 POPF
 AND AL,3
 JZ @eSP
 MOV AL,Ya
@eSP:
EndFunc
nxShiftPress:

;DB "Clavier.ShiftEnfonc‚(Bios)"
@biosShiftPress:
biosShiftPress Proc Pascal Far
 MOV AH,02h
 INT 16h
 AND AL,3
 JZ  nSP
 MOV AL,Ya
nSP:
EndFunc
@EndBiosShiftPress:

PortSB:
 DW 0200h,0210h,0220h,0230h,0240h,0250h,0260h,0270h,0280h

OtherSoundCard Proc Near
 Local A1:Byte,A2:Byte,A3:Byte,A4:Byte,A5:Byte,A6:Byte,A7:Byte,W:Word,W1:Word
 MOV A1,1
@SBWSW:
 CMP A1,7
 JAE @SBWS
 MOV BL,A1
 XOR BH,BH
 SHL BX,1
 MOV DX,Word Ptr PortSB[BX]
 MOV W,DX
 MOV W1,0
 CMP W1,0201h
 JAE @SBWSO
 MOV DX,W
 ADD DX,0Ch
 IN  AL,DX
 TEST AL,80h
 JNZ @SBWSN
 INC W1
 MOV DX,W
 PUSH DX
  ADD DX,0000Ch
  IN  AL,DX
  MOV A3,AL
  MOV AL,0D3h
  OUT DX,AL
  MOV CX,01000h
LoopSB:
  LOOP LoopSB
 POP DX
 ADD DX,6
 IN  AL,DX
 MOV A4,AL
 MOV AL,1
 OUT DX,AL
 IN  AL,DX
 IN  AL,DX
 IN  AL,DX
 IN  AL,DX
 MOV A1,AL
 XOR AL,AL
 OUT DX,AL
 MOV A2,0
@SBWS1:
 MOV DX,W
 XOR CX,CX
@SBWS0:
 CMP CX,0201h
 JAE @SBWS2
 ADD DX,0Eh
 IN  AL,DX
 TEST AL,80h
 JZ  @SBWS3
 INC CX
 SUB DX,0Eh-0Ah
 IN  AL,DX
 AND DL,0F0h
 CMP AL,0AAh
 JNE @SBWS2
 MOV Byte Ptr IsSoundBlaster,Ya
 MOV Word Ptr SoundPort,DX
 JMP @SBWS
@SBWS3:
 INC CX
 JMP @SBWS0
@SBWS2:
 MOV W1,CX
 INC A2
 CMP A2,10h
 JNE @SBWS1
 MOV DX,W
 ADD DX,0Ch
 MOV AL,A3
 OUT DX,AL
 SUB DX,0Ch-06h
 MOV AL,A4
 OUT DX,AL
 JMP @SBWS
@SBWSN:
 INC W1
@SBWSO:
 INC A1
 JMP @SBWSW
@SBWS:
  ;----Roland MPU-401----
 MOV Byte Ptr IsRoland,No
 MOV A1,0
MIDI6:
 MOV DX,0331h
 IN  AL,DX
 TEST AL,040h
 JNZ MIDI5
 CLI
 IN  AL,DX
 MOV AL,A2
 MOV AL,0FFh
 OUT DX,AL
 MOV CX,0FFh
MIDI4:
 MOV DX,0331h
 IN  AL,DX
 TEST AL,80h
 JNZ MIDI3
 MOV DL,030h
 IN  AL,DX
 CMP AL,0FEh
 JNE MIDI2
 MOV Byte Ptr IsRoland,Ya
 STI
 JMP MIDI1
MIDI3:
 LOOP MIDI4
 MOV DX,0330h
 IN  AL,DX
 MOV A1,AL
MIDI2:
 STI
 MOV DX,0331h
 MOV AL,A2
 OUT DX,AL
 JMP MIDI1
MIDI5:
 INC A1
 CMP A1,0FFh
 JB  MIDI6
MIDI1:
  ;----TandyDigital----
 MOV AX,08100h
 INT 01Ah
 CMP AL,81h
 JBE NoTD
 MOV Byte Ptr IsTandyDigital,Ya
NoTD:
  ;----Gravis UltraSound----
 MOV Byte Ptr IsGravis,No
 MOV A1,1
GUS1:
 CMP A1,7
 JAE GUSn
 MOV DL,A1
 MOV DH,0
 MOV CL,4
 SHL DX,CL
 ADD DX,0303h
 MOV W,DX
 PUSH DX
  IN  AL,DX
  MOV A3,AL
  INC DX
  IN  AL,DX
  MOV A4,AL
  INC DX
  IN  AL,DX
  MOV A5,AL
  INC DX
  IN  AL,DX
  MOV A6,AL
  INC DX
  IN  AL,DX
  MOV A7,AL
 POP DX
 MOV AL,04Ch
 OUT DX,AL
 PUSH DX
  INC DX
  INC DX
  XOR AL,AL
  OUT DX,AL
  MOV DX,0300h
  MOV CX,14
LoopGUS:
  IN  AL,DX
  LOOP LoopGUS
 POP DX
 MOV AL,04Ch
 OUT DX,AL
 INC DX
 INC DX
 MOV AL,1
 OUT DX,AL
 DEC DX
 DEC DX
 MOV AL,043h
 OUT DX,AL ; 103h
 PUSH DX
  INC DX
  XOR AL,AL
  OUT DX,AL ; 104h
  DEC DX
  MOV AL,044h
  OUT DX,AL ; 103h
  INC DX
  INC DX
  XOR AL,AL
  OUT DX,AL ; 105h
  INC DX
  INC DX
  MOV AL,0AAh
  OUT DX,AL ; 107h
 POP DX
 MOV AL,043h
 OUT DX,AL ; 103h
 INC DX
 XOR AL,AL
 OUT DX,AL ; 104h
 DEC DX
 MOV AL,044h
 OUT DX,AL ; 103h
 PUSH DX
  INC DX
  INC DX
  MOV AL,1
  OUT DX,AL ; 105h
  INC DX
  INC DX
  MOV AL,055h
  OUT DX,AL ; 107h
 POP DX
 MOV AL,043h
 OUT DX,AL ; 103h
 INC DX
 XOR AL,AL
 OUT DX,AL ; 104h
 DEC DX
 MOV AL,044h
 OUT DX,AL ; 103h
 PUSH DX
  INC DX
  INC DX
  XOR AL,AL
  OUT DX,AL ; 105h
  INC DX
  INC DX
  IN  AL,DX ; 107h
  MOV A2,AL
 POP DX
 MOV AL,043h
 OUT DX,AL ; 103h
 XOR AX,AX
 INC DX
 OUT DX,AX ; 104h
 DEC DX
 MOV AL,044h
 OUT DX,AL ; 103h
 PUSH DX
  INC DX
  INC DX
  XOR AL,AL
  OUT DX,AL ; 105h
  INC DX
  INC DX
  OUT DX,AL ; 107h
 POP DX
 MOV AL,4Ch
 OUT DX,AL ; 103h
 INC DX
 INC DX
 XOR AL,AL
 OUT DX,AL ; 105h
 CMP A2,0AAh
 JNE GUS3
 MOV Byte Ptr IsGravis,Ya
 MOV A3,0
 MOV DX,W
 MOV Word Ptr SoundPort,DX
GUS2:
 CMP A3,4
 JNBE GUS1
 MOV DX,W
 MOV AL,043h
 OUT DX,AL ; 103h
 INC DX
 CMP A3,4
 JE  GUSb
 XOR AL,AL
 OUT DX,AL ; 104h
 DEC DX
 MOV AL,044h
 OUT DX,AL ; 103h
 PUSH DX
  INC DX
  INC DX
  MOV AL,A3
  SHL AL,1
  SHL AL,1
  OUT DX,AL ; 105h
  INC DX
  INC DX
  MOV AL,0AAh
  OUT DX,AL ; 107h
 POP DX
 MOV AL,043h
 OUT DX,AL ; 103h
 INC DX
 XOR AL,AL
 OUT DX,AL ; 104h
 DEC DX
 MOV AL,044h
 OUT DX,AL ; 103h
 INC DX
 INC DX
 MOV AL,A3
 SHL AL,1
 SHL AL,1
 OUT DX,AL ; 105h
 INC DX
 INC DX
 IN  AL,DX ; 107h
 MOV A2,AL
 JMP nGusChk
GUSb:
 MOV AX,0FFFFh
 OUT DX,AX ; 104h
 DEC DX
 MOV AL,044h
 OUT DX,AL ; 103h
 PUSH DX
  INC DX
  INC DX
  MOV AL,0Fh
  OUT DX,AL ; 105h
  INC DX
  INC DX
  MOV AL,0AAh
  OUT DX,AL ; 107h
 POP DX
 MOV AL,043h
 OUT DX,AL ; 103h
 INC DX
 MOV AX,0FFFFh
 OUT DX,AX ; 104h
 DEC DX
 MOV AL,044h
 OUT DX,AL ; 103h
 INC DX
 INC DX
 MOV AL,0Fh
 OUT DX,AL ; 105h
 INC DX
 INC DX
 OUT DX,AL ; 107h
 MOV A2,AL
nGUSChk: ; EndGUSCheck, Fin de v‚rification Gravis Ultra Sound
 CMP A2,0AAh
 JE  GUS2
 MOV AH,A3
 MOV AL,0
 MOV Word Ptr SoundMem,AX
 JMP GUSn
GUS3:
 MOV DX,W
 MOV AL,A3
 OUT DX,AL ; 103h
 INC DX
 MOV AL,A4
 OUT DX,AL ; 104h
 INC DX
 MOV AL,A5
 OUT DX,AL ; 105h
 INC DX
 MOV AL,A6
 OUT DX,AL ; 106h
 INC DX
 MOV AL,A7
 OUT DX,AL ; 107h
 INC A1
 JMP GUS1
GUSn:
EndProc

AutoSoundDetectTmp:
 AdLibChk
 MOV Byte Ptr IsAdLib,AL
 CALL OtherSoundCard
 MOV InitSoundDetect,Ya
 JMP ADS

;@VGAClass:
; DB vnAhead,          vnAheadB,           vnAheadBWizard3270
; DB vnAllstarPeacock, vnASTVGAPlus,       vnATTVDC600
; DB vnCardinal,       vnCirrus,           vnCompaqVGA
; DB vnCTI82C451,      vnCTI82C452,        vnDellVGA
; DB vnEverex,         vnEverexViewPoint,  vnEverexUG2
; DB vnEverexVision,   vnEverexEVGA,       vnGenoa
; DB vnGenoa5100,      vnGenoa5300,        vnGenoa6100
; DB vnGenoa6200,      vnGenoa6400,        vnGU
; DB vnGUPlus,         vnGUPro,            vnHeadLand
; DB vnHPD1180A,       vnIBM8514A,         vnImtec
; DB vnITVGA2,         vnLogix,            vnMaxxon
; DB vnMorseVGA,       vnOak,              vnOrchid
; DB vnOrchidProDesVGA,vnOrchidProDesIIVGA,vnParadise
; DB vnParadisePVGA1A, vnParadiseWD90C00,  vnParadiseWD90C10
; DB vnParadiseWD90C11,vnPrismElite,       vnQU
; DB vnSEFCOTVGA,      vnSigma,            vnSTB
; DB vnSTBVGAEM16Plus, vnTatungVGA,        vnTecmarVGAAD
; DB vnTIGA,           vnTrident8800BR,    vnTrident8800CS
; DB vnTrident8900,    vnT3000,            vnT4000
; DB vnT4000HiColor,   vnT4000HiColorSC,   vnVESA
; DB vnVGA,            vnVGAW,             vnVGAW18800
; DB vnVGAW18800_1,    vnVGAW28800_2,      vnVGAW28800_4
; DB vnVGAW28800_5,    vnV7,               vnV7Vram
; DB vnV7Vega,         vnV7Ver5,           vnV71024i
; DB vnVIP,            vnXGA,              vnZymos
; DB vnZymosPoach

@MCGAModeTable:
 DW vmTxtBW40,vmTxtC40,vmTxtC40x28,vmTxtC40x43,vmTxtC40x50
 DW vmTxtBW80,vmTxtC80,vmTxtC80x28,vmTxtC80x43,vmTxtC80x50
 DW vmGrf640x200c2,vmGrf640x480c2,vmGrf320x200c4,vmGrf320x200c256

@VGAModeTable:
 DW vmTxtBW40,vmTxtC40,vmTxtC40x28,vmTxtC40x43,vmTxtC40x50
 DW vmTxtBW80,vmTxtC80,vmTxtC80x28,vmTxtC80x43,vmTxtC80x50
 DW vmTxtMono,vmTxtMono80x28,vmTxtMono80x43,vmTxtMono80x50
 DW vmGrf640x200c2,vmGrf640x480c2,vmGrf320x200c4,vmGrf640x350c4
 DW vmGrf320x200c16,vmGrf640x200c16,vmGrf640x350c16
 DW vmGrf640x480c16,vmGrf320x200c256

@NoneModeTable:
 DB 0

@AheadModeTable:
 DB 10
 DW vmTxtC132x28,vmTxtC132x44,vmGrf720x392c16,vmGrf1024x768c2
 DW vmGrf1024x768c4,vmGrf1024x768c16,vmGrf640x400c256
 DW vmGrf640x480c256,vmGrf800x600c256,vmGrf1024x768c256

@AheadBWizardModeTable:
 DB 13
 DW vmTxtC132x28,vmTxtC132x44,vmGrf720x392c16,vmGrf1024x768c2
 DW vmGrf1024x768c4,vmGrf1024x768c16,vmGrf640x400c256
 DW vmGrf640x480c256,vmGrf800x600c256,vmGrf1024x768c256
 DW vmTxtC160x50,vmTxtC80x34,vmTxtC80x66

@AllStarPeacockModeTable:
 DB 6
 DW vmTxtC80x60,vmTxtC100x40,vmTxtC132
 DW vmTxtC132x28,vmTxtC132x43,vmGrf800x600c16

@ASTVGAPlusModeTable:
 DB 4
 DW vmTxtC132,vmTxtC132x43,vmGrf640x400c256,vmGrf640x480c256

@ATTVDC600ModeTable:
 DB 8
 DW vmTxtC132,vmTxtC132x43,vmGrf640x400c2,vmGrf640x400c16
 DW vmGrf800x600c2,vmGrf800x600c16,vmGrf640x400c256,vmGrf640x480c256

@CardinalModeTable:
 DB 12
 DW vmGrf640x400c256,  vmGrf640x480c256,  vmGrf720x540c256
 DW vmGrf800x600c16,   vmGrf800x600c256,  vmGrf960x720c16
 DW vmGrf1024x768c16,  vmGrf320x200c32768,vmGrf640x350c32768
 DW vmGrf640x400c32768,vmGrf640x480c32768,vmGrf800x600c32768

@EverexModeTable:
 DB 10
 DW vmTxtMono132,vmTxtMono132x44,vmTxtC80x60,vmTxtC132,vmTxtC132x44
 DW vmGrf320x200c32768,vmGrf640x350c32768,vmGrf640x400c32768
 DW vmGrf640x480c32768,vmGrf800x600c32768

@GenoaModeTable:
 DB 7
 DW vmGrf720x512c16,vmGrf800x600c16,vmGrf720x512c256,vmGrf800x600c256
 Dw vmGrf1024x768c16,vmGrf512x512c16,vmGrf512x512c256

@HPD1180AModeTable:
 DB 5
 DW vmTxtC132,vmTxtC132x44,vmGrf800x600c2
 DW vmGrf800x600c16,vmGrf640x480c256

@MorseVGAModeTable:
 DB 10
 DW vmTxtC80x60,vmTxtC100x30,vmTxtC100x50,vmTxtC100x60
 DW vmTxtC100x75,vmTxtC132x30,vmTxtC132x50,vmTxtC132x60
 DW vmGrf720x540c16,vmGrf800x600c16

@OakModeTable:
 DB 3
 DW vmTxtC132,vmTxtC132x43,vmGrf800x600c16

@OrchidModeTable:
 DB 4
 DW vmGrf640x480c256,vmGrf800x600c16,vmGrf800x600c256,vmGrf1024x768c16

@OrchidProDesVGAModeTable:
 DB 5
 DW vmTxtC80x60,vmTxtC100x40,vmTxtC132,vmTxtC132x28,vmTxtC132x44

@OrchidProDesIIVGAModeTable:
 DB 10
 DW vmTxtC80x60,vmTxtC100x40,vmTxtC132,vmTxtC132x28,vmTxtC132x44
 DW vmGrf320x200c32768,vmGrf640x350c32768,vmGrf640x400c32768
 DW vmGrf640x480c32768,vmGrf800x600c32768

@ParadiseModeTable:
 DB 6
 DW vmTxtC132,vmTxtC132x43,vmGrf800x600c2
 DW vmGrf800x600c16,vmGrf640x400c256,vmGrf640x480c256

@SigmaModeTable:
 DB 3
 DW vmGrf800x600c16,vmGrf800x600c256,vmGrf1024x768c16

@STBModeTable:
 DB 5
 DW vmGrf640x480c256,vmGrf800x600c16,vmGrf800x600c256
 DW vmGrf960x720c16,vmGrf1024x768c16

@STBVGAEM16PlusModeTable:
 DB 1
 DW vmGrf1024x768c256

@TatungVGAModeTable:
 DB 9
 DW vmTxtC80x43,vmTxtC80x60,vmTxtC100x60,vmTxtC132,vmTxtC132x28
 DW vmTxtC132x43,vmGrf752x410c16,vmGrf800x600c16,vmGrf640x400c256

@TecmarVGAADModeTable:
 DB 6
 DW vmTxtC80x43,vmTxtC132,vmGrf640x350c256
 DW vmGrf640x400c256,vmGrf640x480c256,vmGrf800x600c256

@TridentModeTable:
 DB 11
 DW vmTxtC80x30,vmTxtC80x60,vmTxtC132,vmTxtC132x30,vmTxtC132x43
 DW vmTxtC132x60,vmGrf800x600c16,vmGrf640x400c256,vmGrf640x480c256
 DW vmGrf1024x768c16,vmGrf768x1024c16

@Trident8900ModeTable:
 DB 14
 DW vmTxtC80x30,vmTxtC80x60,vmTxtC132,vmTxtC132x30,vmTxtC132x43
 DW vmTxtC132x60,vmGrf800x600c16,vmGrf640x400c256,vmGrf640x480c256
 DW vmGrf1024x768c16,vmGrf768x1024c16,vmGrf800x600c256
 DW vmGrf1024x768c4,vmGrf1024x768c256

@TsengET3000ModeTable:
 DB 13
 DW vmTxtC80x30,vmTxtC80x34,vmTxtC80x60,vmTxtC100x37,vmTxtC100x40
 DW vmTxtC100x75,vmTxtC132,vmTxtC132x28,vmTxtC132x44,vmTxtC132x60
 DW vmTxtC132x100,vmGrf320x400c256,vmGrf360x480c256

@TsengET4000ModeTable:
 DB 20
 DW vmTxtC80x30,vmTxtC80x34,vmTxtC80x60,vmTxtC100x37,vmTxtC100x40
 DW vmTxtC100x75,vmTxtC132,vmTxtC132x28,vmTxtC132x44,vmTxtC132x60
 DW vmTxtC132x100,vmGrf320x400c256,vmGrf360x480c256
 DW vmGrf800x600c16,vmGrf1024x768c16,vmGrf640x350c256,vmGrf640x400c256
 DW vmGrf640x480c256,vmGrf800x600c256,vmGrf1024x768c256

@TsengET4000HiColorModeTable:
 DB 25
 DW vmTxtC80x30,vmTxtC80x34,vmTxtC80x60,vmTxtC100x37,vmTxtC100x40
 DW vmTxtC100x75,vmTxtC132,vmTxtC132x28,vmTxtC132x44,vmTxtC132x60
 DW vmTxtC132x100,vmGrf320x400c256,vmGrf360x480c256
 DW vmGrf800x600c16,vmGrf1024x768c16,vmGrf640x350c256,vmGrf640x400c256
 DW vmGrf640x480c256,vmGrf800x600c256,vmGrf1024x768c256
 DW vmGrf320x200c32768,vmGrf640x350c32768,vmGrf640x400c32768
 DW vmGrf640x480c32768,vmGrf800x600c32768

@VGAWonderModeTable:
 DB 4
 DW vmTxtMono132,vmTxtMono132x44,vmTxtC132,vmTxtC132x44

@Video7VegaModeTable:
 DB 18
 DW vmTxtC80x43,vmTxtC80x60,vmTxtC100x60,vmTxtC120x25
 DW vmTxtC120x43,vmTxtC132,vmTxtC132x43,vmTxtMono132
 DW vmTxtMono132x43,vmGrf720x512c16,vmGrf800x600c16,vmGrf640x350c256
 DW vmGrf640x400c256,vmGrf640x480c256,vmGrf720x512c256,vmGrf800x600c256
 DW vmGrf960x720c16,vmGrf1024x768c16

@Video7VramModeTable:
 DB 15
 DW vmTxtC80x43,vmTxtC80x60,vmTxtC100x60,vmTxtC132
 DW vmTxtC132x28,vmTxtC132x43,vmGrf752x410c16,vmGrf720x540c16
 DW vmGrf800x600c16,vmGrf1024x768c2,vmGrf1024x768c4,vmGrf1024x768c16
 DW vmGrf640x400c256,vmGrf640x480c256,vmGrf720x540c256

@SuperVGAModeTable:
 DW Offset @NoneModeTable           ; 0
 DW Offset @AheadModeTable          ; 1 (Ahead)
 DW Offset @NoneModeTable           ; 2 (Ahead B)
 DW Offset @AheadBWizardModeTable   ; 3 (Ahead B-Wizard/3270 (Super VGA))
 DW Offset @NoneModeTable           ; 4 (Ahead EGA2001)
 DW Offset @AllStarPeacockModeTable ; 5 (AllStar Peacock (VGA))
 DW Offset @ASTVGAPlusModeTable     ; 6 (AST VGA Plus (SVGA))
 DW Offset @NoneModeTable           ; 7 (AT&T)
 DW Offset @NoneModeTable           ; 8 (AT&T 6300 (Super EGA))
 DW Offset @ATTVDC600ModeTable      ; 9 (AT&T VDC600 (SVGA))
 DW Offset @CardinalModeTable       ; 10 (Cardinal (SVGA))
 DW Offset @NoneModeTable           ; 11 (CGA)
 DW Offset @NoneModeTable           ; 12 (Cirrus (SVGA))
 DW Offset @NoneModeTable           ; 13 (Compaq Portable)
 DW Offset @NoneModeTable           ; 14 (Compaq VGA (SVGA))
 DW Offset @NoneModeTable           ; 15 (CTI 82C451 (SVGA))
 DW Offset @NoneModeTable           ; 16 (CTI 82C452 (SVGA))
 DW Offset @NoneModeTable           ; 17 (Dell VGA (SVGA))
 DW Offset @NoneModeTable           ; 18 (EGA)
 DW Offset @NoneModeTable           ; 19 (EGA Wonder 800+ (Super EGA))
 DW Offset @NoneModeTable           ; 20 (EGA Wonder 800+-18800 (Super EGA))
 DW Offset @NoneModeTable           ; 21 (EGA Wonder 800+-18800-1 (Super EGA))
 DW Offset @NoneModeTable           ; 22 (EGA Wonder 800+-28800-2 (Super EGA))
 DW Offset @NoneModeTable           ; 23 (EGA Wonder 800+-28800-4 (Super EGA))
 DW Offset @NoneModeTable           ; 24 (EGA Wonder 800+-28800-5 (Super EGA))
 DW Offset @EverexModeTable         ; 25 (Everex)
 DW Offset @EverexModeTable         ; 26 (Everex ViewPoint)
 DW Offset @EverexModeTable         ; 27 (Everex UltraGraphics II)
 DW Offset @EverexModeTable         ; 28 (Everex Vision)
 DW Offset @EverexModeTable         ; 29 (Everex EVGA)
 DW Offset @GenoaModeTable          ; 30 (Genoa)
 DW Offset @GenoaModeTable          ; 31 (Genoa 5100)
 DW Offset @GenoaModeTable          ; 32 (Genoa 5300)
 DW Offset @GenoaModeTable          ; 33 (Genoa 6100)
 DW Offset @GenoaModeTable          ; 34 (Genoa 6200)
 DW Offset @GenoaModeTable          ; 35 (Genoa 6400 (SVGA))
 DW Offset @NoneModeTable           ; 36 (Graphics Solution d'ATI (Super CGA))
 DW Offset @NoneModeTable           ; 37 (Graphics Ultra d'ATI (SVGA))
 DW Offset @NoneModeTable           ; 38 (Graphics Ultra d'ATI (SVGA))
 DW Offset @NoneModeTable           ; 39 (Graphics Ultra d'ATI (SVGA))
 DW Offset @NoneModeTable           ; 40 (HeadLand (SVGA))
 DW Offset @NoneModeTable           ; 41 (Hercule (HGC))
 DW Offset @HPD1180AModeTable       ; 42 (Hewlett-Packard D1180A (SVGA))
 DW Offset @NoneModeTable           ; 43 (HP 95LX)
 DW Offset @NoneModeTable           ; 44 (IBM 8514/AI)
 DW Offset @NoneModeTable           ; 45 (Imtec (SVGA))
 DW Offset @TsengET4000ModeTable    ; 46 (IT-VGA2 (SVGA))
 DW Offset @NoneModeTable           ; 47 (Lava Chrome II EGA (Super EGA))
 DW Offset @NoneModeTable           ; 48 (Logix (SVGA))
 DW Offset @NoneModeTable           ; 49 (MCGA)
 DW Offset @NoneModeTable           ; 50 (MDA)
 DW Offset @NoneModeTable           ; 51 (Maxxon)
 DW Offset @MorseVGAModeTable       ; 52 (Morse VGA (VGA))
 DW Offset @NoneModeTable           ; 53 (NSI Smart EGA+ (Super EGA))
 DW Offset @OakModeTable            ; 54 (Oak Technologies (SVGA))
 DW Offset @OrchidModeTable         ; 55 (Orchid)
 DW Offset @OrchidProDesVGAModeTable; 56 (Orchid Prodesigner VGA (SVGA))
 DW Offset @OrchidProDesIIVGAModeTable; 57 (Orichid Prodesigner II VGA (SVGA/32768 couleurs))
 DW Offset @ParadiseModeTable       ; 58 (Paradise)
 DW Offset @NoneModeTable           ; 59 (Paradise EGA-480,Super EGA)
 DW Offset @ParadiseModeTable       ; 60 (Paradise PVGA1A)
 DW Offset @ParadiseModeTable       ; 61 (Paradise WD90C00)
 DW Offset @ParadiseModeTable       ; 62 (Paradise WD90C10)
 DW Offset @ParadiseModeTable       ; 63 (Paradise WD90C11)
 DW Offset @NoneModeTable           ; 64 (PC 3270)
 DW Offset @NoneModeTable           ; 65 (PC 3270G)
 DW Offset @NoneModeTable           ; 66 (PC 3270GX)
 DW Offset @NoneModeTable           ; 67 (PC Junior)
 DW Offset @NoneModeTable           ; 68 (PGA)
 DW Offset @NoneModeTable           ; 69 (Prism Elite d'ATI (SVGA))
 DW Offset @NoneModeTable           ; 70 (Quadram Ultra VGA (SVGA))
 DW Offset @NoneModeTable           ; 71 (SEFCO TVGA (SVGA))
 DW Offset @SigmaModeTable          ; 72 (Sigma (SVGA))
 DW Offset @STBModeTable            ; 73 (STB (SVGA))
 DW Offset @STBVGAEM16PlusModeTable ; 74 (STB VGA/EM-16 Plus (SVGA))
 DW Offset @TatungVGAModeTable      ; 75 (Tatung VGA (SVGA))
 DW Offset @NoneModeTable           ; 76 (Taxan 565 EGA (Super EGA))
 DW Offset @TecmarVGAADModeTable    ; 77 (Tecmar VGA/AD (SVGA))
 DW Offset @NoneModeTable           ; 78 (TIGA de Texas Instrument)
 DW Offset @TridentModeTable        ; 79 (Trident 8800BR (SVGA))
 DW Offset @TridentModeTable        ; 80 (Trident 8800CS (SVGA))
 DW Offset @Trident8900ModeTable    ; 81 (Trident 8900 (SVGA))
 DW Offset @TsengET3000ModeTable    ; 82 (Tseng ET3000 (SVGA))
 DW Offset @TsengET4000ModeTable    ; 83 (Tseng ET4000 (SVGA))
 DW Offset @TsengET4000HiColorModeTable ; 84 (Tseng ET4000 HiColor (SVGA))
 DW Offset @TsengET4000HiColorModeTable ; 85 (Tseng ET4000 HiColor SC (SVGA))
 DW Offset @NoneModeTable           ; 86 (Ultra Vision EGA (Super EGA))
 DW Offset @NoneModeTable           ; 87 (VESA)
 DW Offset @NoneModeTable           ; 88 (VGA)
 DW Offset @VGAWonderModeTable      ; 89 (VGA Wonder d'ATI (SVGA))
 DW Offset @VGAWonderModeTable      ; 90 (VGA Wonder d'ATI 18800 (SVGA))
 DW Offset @VGAWonderModeTable      ; 91 (VGA Wonder d'ATI 18800-1 (SVGA))
 DW Offset @VGAWonderModeTable      ; 92 (VGA Wonder d'ATI 28800-2 (SVGA))
 DW Offset @VGAWonderModeTable      ; 93 (VGA Wonder d'ATI 28800-4 (SVGA))
 DW Offset @VGAWonderModeTable      ; 94 (VGA Wonder d'ATI 28800-5 (SVGA))
 DW Offset @NoneModeTable           ; 95 (Video 7 (SVGA))
 DW Offset @Video7VramModeTable     ; 96 (Video 7 Vram (SVGA))
 DW Offset @Video7VegaModeTable     ; 97 (Video 7 Vega (SVGA))
 DW Offset @NoneModeTable           ; 98 (Video 7 Version 5 (SVGA))
 DW Offset @NoneModeTable           ; 99 (Video 7 1024i (SVGA))
 DW Offset @VGAWonderModeTable      ; 100 (ATI VIP (SVGA))
 DW Offset @NoneModeTable           ; 101 (XGA (SVGA))
 DW Offset @NoneModeTable           ; 102 (Zymos (SVGA))
 DW Offset @NoneModeTable           ; 103 (Zymos Poach (SVGA))
 DW Offset @NoneModeTable           ; 104 (Matrox)
 DW Offset @NoneModeTable           ; 105 (Matrox Mystique)
 DW Offset @NoneModeTable           ; 106 (Matrox Millenium)
 DW Offset @NoneModeTable           ; 107 (Matrox G200)

@PtrVesa:
 DD 0,0,0,0,0,0,0,0
 DD 0,0,0,0,0,0,0,0
 DD 0,0,0,0,0,0,0,0
 DD 0,0,0,0,0,0,0,0
 DD 0,0,0,0,0,0,0,0
 DD 0,0,0,0,0,0,0,0
 DD 0,0,0,0,0,0,0,0
 DD 0,0,0,0,0,0,0,0

AddVesaMode Proc Far
 PUSH CX
  PUSH ES
   PUSH DI
    MOV AX,4F00h
    MOV DI,Offset @PtrVesa
    PUSH CS
    POP ES
    INT 10h
   POP DI
  POP ES
 POP CX
 PUSH DS
  LDS SI,DWord Ptr @PtrVesa.VesaHeaderInfo.Modes
  CLD
@Restart:
  LODSW
  CMP AX,0FFFFh
  JE  @Finish
  CMP CX,80
  JA  @Finish
  MOV BX,vmGrf640x400c256
  CMP AX,0100h
  JE  @SetMode
  MOV BX,vmGrf640x480c256
  CMP AX,0101h
  JE  @SetMode
  MOV BX,vmGrf800x600c16
  CMP AX,0102h
  JE  @SetMode
  MOV BX,vmGrf800x600c256
  CMP AX,0103h
  JE  @SetMode
  MOV BX,vmGrf1024x768c16
  CMP AX,0104h
  JE  @SetMode
  MOV BX,vmGrf1024x768c256
  CMP AX,0105h
  JE  @SetMode
  MOV BX,vmGrf1280x1024c16
  CMP AX,0106h
  JE  @SetMode
  MOV BX,vmGrf1280x1024c256
  CMP AX,0107h
  JE  @SetMode
  MOV BX,vmTxtC132
  CMP AX,0109h
  JE  @SetMode
  MOV BX,vmTxtC132x43
  CMP AX,010Ah
  JE  @SetMode
  MOV BX,vmTxtC132x50
  CMP AX,010Bh
  JE  @SetMode
  MOV BX,vmTxtC132x60
  CMP AX,010Ch
  JE  @SetMode
  MOV BX,vmGrf320x200c32768
  CMP AX,010Dh
  JE  @SetMode
  MOV BX,vmGrf320x200c65536
  CMP AX,010Eh
  JE  @SetMode
  MOV BX,vmGrf640x480c32768
  CMP AX,0110h
  JE  @SetMode
  MOV BX,vmGrf640x480c65536
  CMP AX,0111h
  JE  @SetMode
  MOV BX,vmGrf640x480c16M
  CMP AX,0112h
  JE  @SetMode
  MOV BX,vmGrf800x600c32768
  CMP AX,0113h
  JE  @SetMode
  MOV BX,vmGrf800x600c65536
  CMP AX,0114h
  JE  @SetMode
  MOV BX,vmGrf1024x768c32768
  CMP AX,0116h
  JE  @SetMode
  CMP AX,0108h
  JNE @Restart
  MOV AX,vmTxtC80x30
  STOSW
  INC CX
  MOV AX,vmTxtC80x34
  STOSW
  INC CX
  MOV AX,vmTxtC80x60
  STOSW
  INC CX
  JMP @ReStart
@SetMode:
  XCHG AX,BX
  STOSW
  INC CX
  JMP @Restart
@Finish:
 POP DS
EndProc

AutoDetectVideoModeSupport Proc Pascal Far
 CLD
 SUB SP,100h
 MOV DI,SP
 PUSH SS
 POP ES
 MOV CX,100h shr 1
 MOV AX,vmNone
 REP STOSW
 MOV DI,SP
 CMP CS:[adrPhysVideo].PIV.Card,vnMCGA
 JE  xMCGA
 CMP CS:[adrPhysVideo].PIV.VGA,Ya
 JE  ModeVGA
 CMP CS:[adrPhysVideo].PIV.EGA,Ya
 JNE OldCard
 MOV AX,vmTxtBW40
 STOSW
 MOV AX,vmTxtC40
 STOSW
 MOV AX,vmTxtC40x43
 STOSW
 MOV AX,vmTxtBW80
 STOSW
 MOV AX,vmTxtC80
 STOSW
 MOV AX,vmTxtC80x43
 STOSW
 MOV AX,vmTxtMono
 STOSW
 MOV AX,vmTxtMono80x43
 STOSW
 MOV AX,vmGrf640x200c2
 STOSW
 MOV AX,vmGrf320x200c4
 STOSW
 MOV AX,vmGrf640x350c4
 STOSW
 MOV AX,vmGrf320x200c16
 STOSW
 MOV AX,vmGrf640x200c16
 STOSW
 MOV AX,vmGrf640x350c16
 STOSW
 CMP BL,vnEGA
 JE  UpDateMode
 CMP BL,vnAheadEGA2001
 JE  xAheadEGA2001
 CMP BL,vnATT6300
 JE  xATT6300
 CMP BL,vnLavaChromeIIEGA
 JE  xLavaChromeIIEGA
 CMP BL,vnParadiseEGA480
 JE  xParadiseEGA480
 CMP BL,vnTaxan565EGA
 JE  xTaxan565EGA
 CMP BL,vnUltraVisionEGA
 JE  xUltraVisionEGA
  ; vnEGAW800,vnEGAW800N18800, vnEGAW800N18800_1,
  ; vnEGAW800N28800_2,vnEGAW800N28800_4,vnEGAW800N28800_5:
 MOV AX,vmTxtMono132
 STOSW
 MOV AX,vmTxtMono132x44
 STOSW
 MOV AX,vmTxtC132
 STOSW
 MOV AX,vmTxtC132x44
 STOSW
 MOV AX,vmGrf640x480c16
 STOSW
 MOV AX,vmGrf752x410c16
 STOSW
 MOV AX,vmGrf800x560c16
 STOSW
 MOV AX,vmGrf800x600c16
 STOSW
 JMP UpDateMode
xAheadEGA2001:
 MOV AX,vmTxtMono132
 STOSW
 MOV AX,vmTxtMono132x44
 STOSW
 JMP UpDateMode
xATT6300:
 MOV AX,vmTxtC80x33
 STOSW
 MOV AX,vmGrf640x400c2
 STOSW
 MOV AX,vmGrf640x400c16
 STOSW
 MOV AX,vmGrf640x462c16
 STOSW
 MOV AX,vmGrf800x600c2
 STOSW
 JMP UpDateMode
xLavaChromeIIEGA:
 MOV AX,vmTxtC80x30
 STOSW
 MOV AX,vmTxtC80x34
 STOSW
 MOV AX,vmTxtC80x60
 STOSW
 MOV AX,vmTxtC132
 STOSW
 MOV AX,vmTxtC132x43
 STOSW
 MOV AX,vmGrf640x480c16
 STOSW
 MOV AX,vmGrf752x410c16
 STOSW
 JMP UpDateMode
xParadiseEGA480:
 MOV AX,vmTxtC80x30
 STOSW
 MOV AX,vmTxtC132
 STOSW
 MOV AX,vmTxtC132x43
 STOSW
 MOV AX,vmGrf640x480c16
 STOSW
 JMP UpdateMode
xTaxan565EGA:
 MOV AX,vmTxtC132
 STOSW
 MOV AX,vmTxtC132x43
 STOSW
 MOV AX,vmTxtMono132
 STOSW
 MOV AX,vmTxtMono132x43
 STOSW
 JMP UpDateMode
xUltraVisionEGA:
 MOV AX,vmGrf640x480c16
 STOSW
 JMP UpDateMode
OldCard:
 CMP BL,vnMDA
 JNE xMDA
 CMP BL,vnCGA
 JNE xCGA
 CMP BL,vnCompaqPortable
 JNE xCompaqPortable
 CMP BL,vnGS
 JNE xGS
 CMP BL,vnHercule
 JNE xHercule
 CMP BL,vnHP95LX
 JNE xHP95LX
PC3270: ; vnPC3270,vnPC3270G,vnPC3270GX,vnPC3270GX
 MOV AX,vmTxtBW40
 STOSW
 MOV AX,vmTxtC40
 STOSW
 MOV AX,vmTxtBW80
 STOSW
 MOV AX,vmTxtC80
 STOSW
 MOV AX,vmTxtMono
 STOSW
 MOV AX,vmGrf640x200c2
 STOSW
 MOV AX,vmGrf320x200c4
 STOSW
 MOV AX,vmGrf720x350c2
 STOSW
 JMP UpDateMode
xMDA:
 MOV AX,vmTxtMono
 STOSW
 JMP UpDateMode
xCGA:
 MOV AX,vmTxtBW40
 STOSW
 MOV AX,vmTxtC40
 STOSW
 MOV AX,vmTxtBW80
 STOSW
 MOV AX,vmTxtC80
 STOSW
 MOV AX,vmGrf640x200c2
 STOSW
 MOV AX,vmGrf320x200c4
 STOSW
 JMP UpDateMode
xCompaqPortable:
 MOV AX,vmTxtBW40
 STOSW
 MOV AX,vmTxtC40
 STOSW
 MOV AX,vmTxtBW80
 STOSW
 MOV AX,vmTxtC80
 STOSW
 MOV AX,vmTxtMono
 STOSW
 MOV AX,vmGrf640x200c2
 STOSW
 MOV AX,vmGrf640x400c2
 STOSW
 MOV AX,vmGrf320x200c4
 STOSW
 JMP UpDateMode
xGS:
 MOV AX,vmTxtBW40
 STOSW
 MOV AX,vmTxtC40
 STOSW
 MOV AX,vmTxtBW80
 STOSW
 MOV AX,vmTxtC80
 STOSW
 MOV AX,vmTxtC132
 STOSW
 MOV AX,vmTxtC132x28
 STOSW
 MOV AX,vmGrf640x200c2
 STOSW
 MOV AX,vmGrf320x200c4
 STOSW
 MOV AX,vmGrf640x200c4
 STOSW
 MOV AX,vmGrf320x200c16
 STOSW
 MOV AX,vmGrf640x200c16
 STOSW
 CMP Byte Ptr CS:[Offset CardSec].PIV.Card,vnUnknown
 JE  GSNoHercule
 MOV AX,vmTxtMono
 STOSW
 MOV AX,vmHerc
 STOSW
GSNoHercule:
 JMP UpDateMode
xHercule:
 MOV AX,vmTxtMono
 STOSW
 MOV AX,vmHerc
 STOSW
 JMP UpDateMode
xHP95LX:
 MOV AX,vmGrf240x128c2
 STOSW
 JMP UpDateMode
xMCGA:
 CLD
 PUSH DS
  PUSH CS
  POP DS
  MOV SI,Offset @MCGAModeTable
  MOV CX,14
  REP MOVSW
 POP DS
 JMP UpDateMode
ModeVGA:
 CLD
 PUSH DS
  PUSH CS
  POP DS
  MOV SI,Offset @VGAModeTable
  MOV CX,25
  REP MOVSW
  MOV BL,CS:[adrPhysVideo].PIV.Card
  XOR BH,BH
  SHL BX,1
  MOV SI,Word Ptr @SuperVGAModeTable[BX]
  LODSB
  XCHG AX,CX
  XOR CH,CH
  REP MOVSW
  MOV AL,CS:[adrPhysVideo].PIV.Card
  CMP AL,vnMatrox
  JE  VESAModeTable
  CMP AL,vnMatroxMystique
  JE  VESAModeTable
  CMP AL,vnMatroxMillenium
  JE  VESAModeTable
  CMP AL,vnMatroxG200
  JE  VESAModeTable
  CMP AL,vnVesa
  JNE NoVESAModeTable
VESAModeTable:
  CALL AddVesaMode
NoVESAModeTable:
UpDateMode:
 POP DS
 MOV CX,DI
 SUB CX,SP
 PUSH CX
  PUSH CX
  CALL Far Ptr MemAlloc
 POP CX
 CLD
 SHR CX,1
 MOV Word Ptr ModeSupport,AX
 MOV Word Ptr ModeSupport[2],DX
 MOV Word Ptr NumModeSupport,CX
 MOV SI,SP
 PUSH DS
  PUSH SS
  POP DS
  XCHG AX,DI
  MOV ES,DX
  REP MOVSW
 POP DS
 ADD SP,100h
EndProc

AutoDetectTmp:
 PUSH CS
 CALL Near Ptr _GetVideoCard
 CALL AutoDetectVideoModeSupport
  ; ##############################################################
  ; # Mise … jour des "Switchs" vid‚o demand‚e par l'utilisateur #
  ; ##############################################################
 CMP Byte Ptr VesaBiosBank,Ya
 JNE NotVesaBiosBank
 CMP CS:[adrPhysVideo].PIV.ProcSelBnkPg,indexProcSelBnkPgVesa
 JNE NotVesaBiosBank
 MOV CS:[adrPhysVideo].PIV.ProcSelBnkPg,indexProcSelBnkPgVesaBios
  ; ##############################################################
NotVesaBiosBank:
 MOV InitDetect,Ya
 JMP AD

;!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
;!! ATTENTION! Ce point doit correspondre … l'offset 15000 sinon les codes !!
;!!            machines seront ‚cras‚s!                                    !!
;!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

DB 490 DUP (?)

CardSec         PIV ?
InitSoundDetect DB  0

InitSound Proc Pascal Far
 CMP InitSoundDetect,Ya
 JE  ADS
 JMP AutoSoundDetectTmp
ADS:
EndProc

InitDetect DB 0

AutoDetect Proc Pascal Far
 CMP InitDetect,Ya
 JE  AD
 JMP AutoDetectTmp
AD:
EndProc

GetPIVSec Proc Pascal Far addr:dword
 MOV SI,Offset CardSec
 PUSH DS
  MOV CX,TYPE PIV
  PUSH CS
  POP DS
  CLD
  LES DI,addr
  REP MOVSB
 POP DS
EndProc

SetHeightChr Proc Pascal Far H:Byte
 MOV DL,H
 XOR DH,DH
 MOV CS:[adrDataVideo].MIV._HeightChr,DL
 XOR AX,AX
 MOV DI,Word Ptr RawY
 CMP DI,AX
 JE  SkipHeightChr
 MOV CX,256
L2:
 MOV Word Ptr CS:[DI],AX
 INC DI
 INC DI
 ADD AX,DX
 LOOP L2
SkipHeightChr:
EndProc

GetRealRawYWord Proc Far
GetRealRawY Proc Pascal Far Y:Word
 MOV SI,Word Ptr RealRawY
 MOV BX,Y
 SHL BX,1
 XOR DX,DX
 MOV AX,CS:[SI+BX]
EndProc
endp

GetRawY Proc Pascal Far Y:Byte
 MOV BL,Y
 XOR BH,BH
 SHL BX,1
 ADD BX,Word Ptr RawY
 MOV AX,Word Ptr CS:[BX]
EndProc

code ends
end