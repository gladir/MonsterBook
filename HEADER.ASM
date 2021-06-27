; Malte Genesis IV: AdŠle
; Module Chryo-g‚n‚tique de virtualisation de la persception
; Tous droits r‚serv‚s par les Chevaliers de Malte
; ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
;
; Description
; ÍÍÍÍÍÍÍÍÍÍÍ
;
;  Ce fichier renferme les routines n‚cessaires … l'utilisation des
; informations concernant les pilotes vid‚o.

; ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
;                              Sp‚cification
; ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
.8086
.MODEL TPASCAL

Jumps

Adele equ 1 ; D‚finit la bibliothŠque Malte Genesis V: AdŠle

Include Systex.Inc
Include Library\Compiler\Assemble.ur\Dialect.Inc

Extrn SetBnkPg

Public SetNumYTexts
Public GetBytesPerLn,BiosBlinkFound,ColorFound,GetBitsPerPixel
Public GetHeightChr,GetNmColors,GetNmVideoPages,GetNmXPixels
Public GetNmXTxts,GetNmYPixels,GetNmYTxts,GetVideoBitsDAC
Public GetVideoBitsIO,GetVideoBitsROM,GetVideoCard,GetVideoCardCat
Public GetVideoPg,GetVideoMem,GetVideoMode,GetVideoMonitor,GetVideoScrSize
Public GetVideoSeg,GetVideoSegROM,GetVideoShowPg,GetVideoSizeBnkPg
Public GetVideoTxtAddrPg,GetVideoTxtMtxPtr,IsColor,IsEGA,IsGrf,IsVESA,IsVGA
Public IsVideoBlink,IsVideoDirectAccess,IsVideoModeBios,IsVideoModeIBMLogic
Public IsVideoSnow,VGA320x400Found,VideoFontFound,VideoHerculeFound
Public VideoMousePortFound,VideoPaletteFound,GetVideoBnkPg
Public GetPhysInfoVideo,GetPhysicalInfoVideo,GetPIV,MaxXTxts,MaxYTxts
Public SetPhysInfoVideo,SetPhysicalInfoVideo,SetPIV,SetModeValue,SetTxtMtx
Public GetMaxXTxts,GetMaxYTxts,GetMaxXPixels,GetMaxYPixels,GetVideoSegBuf
Public IsMono,GetMaxPal,GetModeInfoVideo,GetMIV,IsDblMtx
Public SetVideoSeg
Public GetXCurPos,GetYCurPos,GetCur,Focused
; ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
;                Les duplications des fonctions et proc‚dures
; ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
Public BytesPerLn,BytesPerLine,GetBytesPerLine
Public GetMaxKr,GetMaxColor,GetMaxColors
Public GetNmKr,GetNumColors
Public GetNumXPixels,GetNumYPixels,GetMaxX,GetMaxY
Public GetVideoMemory,GetVidMem
Public HeightChr,GetHeightChar,GetHeightCharacter
Public IsKr,IsGraf,IsGraphics,IsGraphix,IsMonochrome
Public KrFound
Public NmXTxts,NmYTxts
Public NmXPixels,NmYPixels
Public FontFound,BitsPerPixel,GetSelPg,IsBlink
Public _GetActivePage
Public PrimCardCat

.CODE

; ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
;                        Fonction GetBytesPerLine:Word
; ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
;
; Description
; ÍÍÍÍÍÍÍÍÍÍÍ
;
;  Cette fonction retourne le nombre d'octets affich‚ par ligne. Les donn‚es
; varient consid‚rablement en fonction du mode actif.
;
; Remarque
; ÍÍÍÍÍÍÍÍ
;  ş Si le pilote sp‚cifique au mode vid‚o n'a pas ‚t‚ charg‚, il retournera
;    probablement 0.  Je dis bien 0 car certains novices utilisant se joujou
;    pouront s–rement le m‚langer avec leur acharnement du d‚sespoir.

BytesPerLn Proc Far
BytesPerLine Proc Far
GetBytesPerLine Proc Far
GetBytesPerLn Proc Far
 MOV AX,CS:[adrDataVideo].MIV._BytesPerLn
EndFunc
endp
endp
endp

; ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
;                      Fonction BiosBlinkFound:Boolean
; ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
;
; Description
; ÍÍÍÍÍÍÍÍÍÍÍ
;
;  Cette fonction indique  si  le  Bios  supporte  le mode  clignotement  ou
; intensit‚. Les donn‚es varient consid‚rablement en fonction de la carte.
;
; Remarque
; ÍÍÍÍÍÍÍÍ
;  ş Si le pilote sp‚cifique au mode vid‚o n'a pas ‚t‚ charg‚, il retournera
;    probablement 0.  Je dis bien 0 car certains novices utilisant se joujou
;    pouront s–rement le m‚langer avec leur rage "hard"-alternative.

BiosBlinkFound Proc Far
 MOV AL,CS:[adrPhysVideo].PIV.BBlink
EndFunc

; ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
;                         Fonction ColorFound:Boolean
; ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
;
; Description
; ÍÍÍÍÍÍÍÍÍÍÍ
;
;  Cette fonction indique s'il s'agit d'une carte couleur (1)  ou monochrome
; (0). Les donn‚es varient consid‚rablement en fonction de la/les carte(s).
;
; Remarque
; ÍÍÍÍÍÍÍÍ
;  ş Si le pilote sp‚cifique au mode vid‚o n'a pas ‚t‚ charg‚, il retournera
;    probablement 0.  Je dis bien 0 car certains novices utilisant se joujou
;    pouront s–rement le m‚langer avec leur rage "heavy metal".

KrFound Proc Far
ColorFound Proc Far
 MOV AL,CS:[adrPhysVideo].PIV.Color
EndFunc
endp

; ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
;                       Fonction GetBitsPerPixel:Byte
; ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
;
; Description
; ÍÍÍÍÍÍÍÍÍÍÍ
;  Cette fonction retourne le nombre  de bits utilis‚  par l'affichage  d'un
; pixel.  Les donn‚es varient  consid‚rablement  en fonction  du mode actif,
; ainsi,  en mode texte,  cette  fonction  retourne  0,  tandis  quand  mode
; graphiques il s'agit d'une valeur d'au moins 1 ou plus.
;
; Remarque
; ÍÍÍÍÍÍÍÍ
;  ş Si le pilote sp‚cifique au mode vid‚o n'a pas ‚t‚ charg‚, il retournera
;    probablement 0.  Je dis bien 0 car certains novices utilisant se joujou
;    pouront s–rement le m‚langer avec leur rage ‚nerv‚ mental.

BitsPerPixel Proc Far
GetBitsPerPixel Proc Far
 MOV AL,CS:[adrDataVideo].MIV._BitsPerPixel
EndFunc
endp

GetHeightChar Proc Far
GetHeightCharacter Proc Far
HeightChr Proc Far
GetHeightChr Proc Far
 MOV AL,CS:[adrDataVideo].MIV._HeightChr
EndFunc
endp
endp
endp

GetNumColors Proc Far
GetNmKr Proc Far
GetNmColors Proc Far
 LES AX,CS:[adrDataVideo].MIV.NmColrs
 MOV ES,DX
EndFunc
endp
endp

GetMaxColors Proc Far
GetMaxColor Proc Far
GetMaxKr Proc Far
GetMaxPal Proc Far
 PUSH CS
 CALL Near Ptr GetNmKr
 DEC AX
EndFunc
endp
endp
endp

GetNmVideoPages Proc Far
 MOV AL,CS:[adrDataVideo].MIV.NmVidPgs
EndFunc

GetNumXPixels Proc Far
NmXPixels Proc Far
GetNmXPixels Proc Far
 MOV AX,CS:[adrDataVideo].MIV._NmXPixels
EndFunc
endp
endp

GetMaxX Proc Far
GetMaxXPixels Proc Far
 PUSH CS
 CALL Near Ptr NmXPixels
 DEC AX
EndFunc
endp

NmXTxts Proc Far
GetNmXTxts Proc Far
 MOV AL,CS:[adrDataVideo].MIV._NmXTxts
EndFunc
endp

GetMaxXTxts Proc Far
MaxXTxts Proc Far
 PUSH CS
 CALL Near Ptr NmXTxts
 DEC AL
EndFunc
endp

GetNumYPixels Proc Far
NmYPixels Proc Far
GetNmYPixels Proc Far
 MOV AX,CS:[adrDataVideo].MIV._NmYPixels
EndFunc
endp
endp

GetMaxY Proc Far
GetMaxYPixels Proc Far
 PUSH CS
 CALL Near Ptr NmYPixels
 DEC AX
EndFunc
endp

NmYTxts Proc Far
GetNmYTxts Proc Far
 MOV AL,CS:[adrDataVideo].MIV._NmYTxts
EndFunc
endp

GetMaxYTxts Proc Far
MaxYTxts Proc Far
 PUSH CS
 CALL Near Ptr NmYTxts
 DEC AL
EndFunc
endp

GetVideoBitsDAC Proc Far
 MOV AL,CS:[adrPhysVideo].PIV.DACBits
EndFunc

GetVideoBitsIO Proc Far
 MOV AL,CS:[adrPhysVideo].PIV.VideoBits
EndFunc

GetVideoBitsROM Proc Far
 MOV AL,CS:[adrPhysVideo].PIV.ROMBits
EndFunc

GetSelPg Proc Far
GetVideoBnkPg Proc Far
 MOV AL,0FFh
 PUSH AX
 PUSH CS
 CALL Near Ptr SetBnkPg
EndFunc
endp

GetVideoCard Proc Far
 MOV AL,CS:[adrPhysVideo].PIV.Card
EndFunc

PrimCardCat Proc Far
GetVideoCardCat Proc Far
 MOV AL,CS:[adrPhysVideo].PIV.CardCat
EndFunc
endp

_GetActivePage Proc Far
GetVideoPg Proc Far
 MOV AL,CS:[adrDataVideo].MIV.Pg
EndFunc
endp

GetVidMem Proc Far
GetVideoMemory Proc Far
GetVideoMem Proc Far
 LES AX,CS:[adrPhysVideo].PIV.Memory
 MOV DX,ES
EndFunc
endp
endp

GetVideoMode Proc Far
 MOV AX,CS:[adrDataVideo].MIV.Mode
EndFunc

GetVideoMonitor Proc Far
 MOV AL,CS:[adrPhysVideo].PIV.Monitor
EndFunc

GetVideoScrSize Proc Far
 LES AX,CS:[adrDataVideo].MIV.ScrSize
 MOV DX,ES
EndFunc

GetVideoSeg Proc Far
 MOV AX,CS:[adrDataVideo].MIV.SegV
 JMP @ChkSeg
; RET
endp

GetVideoSegBuf Proc Far
 MOV AX,CS:[adrDataVideo].MIV.SegBuf
@ChkSeg:
 CMP AX,0
 JNE @egvsb
 MOV ES,AX
 MOV AH,0B8h
 CMP Word Ptr ES:[463h],3D4h
 JE  @egvsb
 MOV AH,0B0h
@egvsb:
EndFunc

GetVideoSegROM Proc Far
 MOV AX,CS:[adrPhysVideo].PIV.ROM
EndFunc

GetVideoShowPg Proc Far
 MOV AL,CS:[adrDataVideo].MIV.ShowPg
EndFunc

GetVideoSizeBnkPg Proc Far
 MOV AX,CS:[adrDataVideo].MIV.SizeBnk
EndFunc

GetVideoTxtAddrPg Proc Far
 MOV AX,CS:[adrDataVideo].MIV.AddrPg
EndFunc

GetVideoTxtMtxPtr Proc Far
 LES AX,CS:[adrDataVideo].MIV.TxtMtx
 MOV DX,ES
EndFunc

IsKr Proc Far
IsColor Proc Far
 MOV AL,CS:[adrDataVideo].MIV.Colr
EndFunc
endp

IsMonochrome Proc Far
IsMono Proc Far
 PUSH CS
 CALL Near Ptr IsKr
 XOR AL,1
EndFunc
endp

IsEGA Proc Far
 MOV AL,CS:[adrPhysVideo].PIV.EGA
EndFunc

IsGraphics Proc Far
IsGraphix Proc Far
IsGraf Proc Far
IsGrf Proc Far
 MOV AL,CS:[adrDataVideo].MIV.Graf
EndFunc
endp
endp
endp

IsVESA Proc Far
 MOV AL,CS:[adrPhysVideo].PIV.VESA
EndFunc

IsVGA Proc Far
 MOV AL,CS:[adrPhysVideo].PIV.VGA
EndFunc

IsBlink Proc Far
IsVideoBlink Proc Far
 MOV AL,CS:[adrDataVideo].MIV.Blink
EndFunc
endp

IsVideoDirectAccess Proc Far
 MOV AL,CS:[adrDataVideo].MIV.Direct
EndFunc

IsVideoModeBios Proc Far
 MOV AL,CS:[adrDataVideo].MIV.BiosSupport
EndFunc

IsVideoModeIBMLogic Proc Far
 MOV AL,CS:[adrDataVideo].MIV.IBMLogic
EndFunc

IsVideoSnow Proc Far
 MOV AL,CS:[adrDataVideo].MIV.Snow
EndFunc

VGA320x400Found Proc Far
 MOV AL,CS:[adrPhysVideo].PIV.VGA320x400
EndFunc

FontFound Proc Far
VideoFontFound Proc Far
 MOV AL,CS:[adrPhysVideo].PIV.Font
EndFunc
endp

VideoHerculeFound Proc Far
; MOV BX,Offset PIV.Hercule+adrPhysVideo
; JMP @LoadByte
 MOV AL,CS:[adrPhysVideo].PIV.Hercule
EndFunc

VideoMousePortFound Proc Far
; MOV BX,Offset PIV.MousePort+adrPhysVideo
; JMP @LoadByte
 MOV AL,CS:[adrPhysVideo].PIV.MousePort
EndFunc

VideoPaletteFound Proc Far
; MOV BX,Offset PIV.Palette+adrPhysVideo
;@LoadByte:
; MOV AL,CS:[BX]
 MOV AL,CS:[adrPhysVideo].PIV.Palette
EndFunc

GetModeInfoVideo Proc Far
GetMIV Proc Pascal Far addr:dword
; CLD
 PUSH DS
  MOV CX,TYPE MIV
  PUSH CS
  POP DS
  MOV SI,adrDataVideo
  JMP @PIV
;  LES DI,addr
;  REP MOVSB
; POP DS
; RET
endp
endp

GetPhysicalInfoVideo Proc Far
GetPIV Proc Far
GetPhysInfoVideo Proc Pascal Far addr:dword
 MOV SI,adrPhysVideo
@GetPIV:
 PUSH DS
  MOV CX,TYPE PIV
  PUSH CS
  POP DS
@PIV:
  CLD
  LES DI,addr
  REP MOVSB
 POP DS
EndProc
endp
endp

SetPhysicalInfoVideo Proc Far
SetPIV Proc Far
SetPhysInfoVideo Proc Pascal Far addr:dword
 CLD
 PUSH DS
  MOV CX,TYPE PIV
  LDS SI,addr
  PUSH CS
  POP ES
  MOV DI,adrPhysVideo
  REP MOVSB
 POP DS
EndProc
endp
endp

;SetModeValue Proc Far
;; Il faudrait que je "POPs" de SS:[SP+4]... ou inverser ces 2 instructions
;; sans que le retour se fasse avant la 2iŠme instruction.
; POP Word Ptr CS:[adrDataVideo]
; RET
;endp

SetModeValue Proc Pascal Far M:Word
 MOV AX,M
 MOV CS:[adrDataVideo],AX
EndProc

SetTxtMtx Proc Pascal Far Addr:DWord
 LES AX,Addr
 MOV Word Ptr CS:[adrDataVideo].MIV.TxtMtx,AX
 MOV Word Ptr CS:[adrDataVideo+2].MIV.TxtMtx,ES
EndProc

SetVideoSeg Proc Pascal Far S:Word
 MOV AX,S
 MOV CS:[adrDataVideo].MIV.SegV,AX
EndProc

IsDblMtx Proc Pascal Far
 MOV AL,CS:[adrDataVideo].MIV._IsDblMtx
EndProc

SetNumYTexts Proc Pascal Far Y:Byte
 MOV AL,Y
 MOV CS:[adrDataVideo].MIV._NmYTxts,AL
EndProc

GetXCurPos Proc Far
 MOV AL,CS:[adrDataVideo].MIV.XCurPos
EndProc

GetYCurPos Proc Far
 MOV AL,CS:[adrDataVideo].MIV.YCurPos
EndProc

GetCur Proc Far
 MOV AX,Word Ptr CS:[adrDataVideo].MIV.StartCur4mat
EndProc

Focused Proc Far
 MOV AL,0
 CMP Byte Ptr CS:[adrDataVideo].MIV.StopCur4mat,20h
 JE  @EndFocused
 MOV AL,1
@EndFocused:
EndProc

code ends
end