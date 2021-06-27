; Malte Genesis IV: Chantal
; Module du systŠme cortex de la pens‚ de Chantal
; Tous droits r‚serv‚s par les Chevaliers de Malte
; ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

 adrPhysVideo equ 256      ; Adresse physique du PIV
 adrDataVideo equ 286      ; Adresse physique du MIV

;ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
;³                           D‚finition des constantes                     Û
;ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ

Ya          equ 1
No          equ 0

; ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
;                               Ordres des dates
; ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

 mdy                 equ 0    ; MM/JJ/AA
 dmy                 equ 1    ; JJ/MM/AA
 ymd                 equ 2    ; AA/MM/JJ
 myd                 equ 3    ; MM/AA/JJ
 dym                 equ 4    ; JJ/AA/MM
 ydm                 equ 5    ; AA/JJ/MM

; ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
;                   Les diff‚rents modŠle de Micro-Processeur
; ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

 cpu8088             equ 0    ; INTEL 8088
 cpu8086             equ 1    ; INTEL 8086
 cpuV20              equ 2    ; NEC V20
 cpuV30              equ 3    ; NEC V30
 cpu80188            equ 4    ; INTEL 80188
 cpu80186            equ 5    ; INTEL 80186
 cpu80286            equ 6    ; INTEL 80286
 cpui386             equ 7    ; INTEL 80386
 cpui486             equ 8    ; INTEL 80486
 cpuCyrix5x86        equ 9    ; Cyrix 5x86
 cpuCyrix6x86        equ 10   ; Cyrix 6x86
 cpuPentium          equ 11   ; Pentium
 cpuPentiumMMX       equ 12   ; Pentium-MMX
 cpuPentiumII        equ 13   ; Pentium II

; ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
;                       Les diff‚rents possibles pour les CPU
; ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

 cvIntel             equ 0    ; Fabricant Intel par d‚faut
 cvCyrix             equ 1    ; Fabricant Cyrix
 cvIBM               equ 2    ; Fabricant IBM
 cvAMD               equ 3    ; Fabricant AMD

; ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
;               Les noms des diff‚rents ordinateur (Computer Name)
; ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

 cnIBM7561_2           equ 0002h ; IBM 7561/2
 cnPS2M90XP            equ 0003h ; PS/2 ModŠle 90XP
 cnPS2M95XP            equ 0004h ; PS/2 ModŠle 95XP
 cnAST                 equ 0010h ; AST
 cnTandy1000           equ 0021h ; Tandy 1000
 cnTandy3000NL         equ 0023h ; Tandy 3000NL
 cnCompaqPC            equ 002Dh ; Compaq PC/Compaq Deskpro
 cnSperryPC            equ 0030h ; Sperry PC
 cnOlivettiM15         equ 0046h ; Olivetti M15
 cnPS2M55_5551         equ 0055h ; PS/2 ModŠle 55-5551
 cnContermMax          equ 0056h ; ContermMax
 cnCompaqXT            equ 009Ah ; Compaq XT/Compaq Plus
 cnHewlettPackard110   equ 00B6h ; Hewlett-Packard 110
 cnPS2M55_5530         equ 00E1h ; PS/2 ModŠle 55-5530 Laptop
 cnPS2M80_16           equ 00F8h ; PS/2 ModŠle 80,16Mhz 386
 cnPCConv              equ 00F9h ; PC-Convertible
 cnPS2M30              equ 00FAh ; PS/2 ModŠle 30
 cnAT                  equ 00FCh ; Clone AT
 cnPCJunior            equ 00FDh ; PC Junior
 cnXT                  equ 00FEh ; PC XT
 cnPC                  equ 00FFh ; PC original
 cnPS2M80_20           equ 01F8h ; PS/2 ModŠle 80,20Mhz 386
 cnPS2M25              equ 01FAh ; PS/2 ModŠle 25/25L
 cnPCXT2               equ 01FBh ; PC-XT/2
 cnPS2M55_5571         equ 02F8h ; PS/2 ModŠle 55-5571
 cnPCXT286             equ 02FCh ; PC-XT/286
 cnPS2M70_16           equ 04F8h ; PS/2 ModŠle 70,16Mhz 386
 cnPS2M50              equ 04FCh ; PS/2 ModŠle 50,10Mhz 286
 cnPS2M50Z             equ 04FFh ; PS/2 ModŠle 50Z,10Mhz 286
 cnIBMPC7568           equ 05F8h ; IBM PC 7568
 cnPS2M60              equ 05FCh ; PS/2 ModŠle 60,10Mhz 286
 cnIBM7552Gearbox      equ 06FCh ; IBM 7552 Gearbox
 cnPS2M70_20           equ 09F8h ; PS/2 ModŠle 70,20Mhz 386
 cnPS2M25i286          equ 09FCh ; PS/2 ModŠle 25-286
 cnPS2M30i286          equ 09FEh ; PS/2 ModŠle 30-286
 cnPS2MP70             equ 0BF8h ; PS/2 ModŠle P70
 cnPS1M2011            equ 0BFCh ; PS/1 ModŠle 2011
 cnPS2M55SZ            equ 0CF8h ; PS/2 ModŠle 55SZ
 cnPS2M70i386_25       equ 0DF8h ; PS/2 ModŠle 70,25Mhz 386
 cnPS1i486SX           equ 0EF8h ; PS/1 486SX
 cnPS1i486DX           equ 0FF8h ; PS/1 486DX
 cnPS2M90_25           equ 11F8h ; PS/2 ModŠle 90,25Mhz 386
 cnPS2M90_33           equ 13F8h ; PS/2 ModŠle 90,33Mhz 386
 cnPS2M90AK9           equ 14F8h ; PS/2 ModŠle 90,AK9 25Mhz 486
 cnPS2M90AKD           equ 16F8h ; PS/2 ModŠle 90,AKD 33Mhz 486
 cnPS2M35              equ 18F8h ; PS/2 ModŠle 35/35LS/40 20Mhz 386SX
 cnPS2M70i486_25       equ 1BF8h ; PS/2 ModŠle 70,25Mhz 486
 cnPS2M65_121          equ 1CF8h ; P2/2 ModŠle 65-121,16Mhz 386SX
 cnPS2M55LS            equ 1EF8h ; PS/2 ModŠle 55LS,16Mhz
 cnCompaqProLinea      equ 20FCh ; Compaq Pro Linea
 cnPS2ML40             equ 23F8h ; PS/2 ModŠle L40,20Mhz 386SX
 cnPS2MM57             equ 25F8h ; PS/2 ModŠle M57,20Mhz 386SLC
 cnToshibaT5200_200    equ 2639h ; Toshiba T5200/200
 cnPS2M57              equ 26F8h ; PS/2 ModŠle 57,20Mhz 386SX
 cnPS2M95_50           equ 2AF8h ; PS/2 ModŠle 95,50Mhz 486
 cnPS2M90_50           equ 2BF8h ; PS/2 ModŠle 90,50Mhz 486
 cnPS2M95_20           equ 2CF8h ; PS/2 ModŠle 95,20Mhz 486SX
 cnPS2M95_SX87_20      equ 2EF8h ; PS/2 ModŠle 95,20Mhz 486SX+487SX
 cnPS2M90_SX87_20      equ 2FF8h ; PS/2 ModŠle 90,20Mhz 486SX+487SX
 cnPS1M2121            equ 30F8h ; PS/1 ModŠle 2121
 cnIBMRestaurantTerm   equ 30FAh ; IBM Restaurant Terminal
 cnEpson1              equ 30FCh ; Epson, modŠle inconnue
 cnEpson2              equ 31FCh ; Epson, modŠle inconnue
 cnEpson3              equ 33FCh ; Epson, modŠle inconnue
 cnPCAT319             equ 3538h ; PC-AT 319 ou 339,8Mhz
 cnTandy3000           equ 3738h ; Tandy 3000
 cnToshibaT5200_100    equ 3838h ; Toshiba T5200/100
 cnToshibaT1200XE      equ 3938h ; Toshiba T1200/XE
 cnToshibaT4500SX_C    equ 4139h ; Toshiba T4500SX-C
 cnPS2M77              equ 41F8h ; PS/2 ModŠle 77
 cnOlivettiM280        equ 42FCh ; Olivetti M280
 cnPS1                 equ 4320h ; PS/1
 cnOlivettiM240        equ 43FFh ; Olivetti M240
 cnToshiba4400C        equ 4539h ; Toshiba 4400C
 cnPS2M90XPPentium     equ 45F8h ; PS/2 ModŠle 90 XP Pentium
 cnOlivettiM380        equ 45FCh ; Olivetti M380 (XP1/XP3/XP5)
 cnPS2M95XPPentium     equ 46F8h ; PS/2 ModŠle 95 XP Pentium
 cnPCXT_               equ 46FFh ; PC XT d'IBM inconnue
 cnPS2M85              equ 48F8h ; PS/2 ModŠle 85
 cnOlivettiM290        equ 48FCh ; Olivetti M290
 cnPSVP325T            equ 49F8h ; PS/ValuePoint 325T
 cnPSVP425SX           equ 4AF8h ; PS/ValuePoint 425SX
 cnPSVP433DX           equ 4BF8h ; PS/ValuePoint 433DX
 cnOlivettiM200        equ 4CFBh ; Olivetti M200
 cnPS2M295             equ 4EF8h ; PS/2 ModŠle 295
 cnOlivettiM111        equ 4EFEh ; Olivetti M111
 cnOlivettiM250        equ 4FFCh ; Olivetti M250
 cnPS2MP70_16          equ 50F8h ; PS/2 ModŠle P70,16Mhz 386
 cnOlivettiM380XP7     equ 50FCh ; Olivetti M380 (XP7)
 cnOlivettiPCS286      equ 51FCh ; Olivetti PCS286
 cnPS2MP75_33          equ 52F8h ; PS/2 ModŠle P75, 33Mhz 386
 cnOlivettiM300        equ 52FCh ; Olivetti M300
 cnPS2MCL57SX          equ 56F8h ; PS/2 ModŠle CL57 SX
 cnPS2MN51SLC          equ 5DF8h ; PS/2 ModŠle N51 SLC
 cnIBMThinkPad700      equ 5EF8h ; IBM Think Pad 700
 cnOlivettiP500        equ 61F8h ; Olivetti P500
 cnOlivettiP800        equ 62F8h ; Olivetti P800
 cnToshiba1850SX       equ 6E39h ; Toshiba 1850SX
 cnToshiba1800SX       equ 6F39h ; Toshiba 1800SX
 cnPS2M80_25           equ 80F8h ; PS/2 ModŠle 80,25Mhz 386
 cnPS2M55_5502         equ 81F8h ; PS/2 ModŠle 55-5502
 cnPS2M55N33SX         equ 87F8h ; PS/2 ModŠle 55 N33SX
 cnPS2M55_5530T        equ 88F8h ; PS/2 ModŠle 55-5530T
 cnZenith386           equ 94FCh ; Zenith 386
 cnPS2M55N28SX         equ 97F8h ; PS/2 ModŠle 55 Note N28SX
 cnPS2MN51SX           equ 99F8h ; PS/2 ModŠle N51 SX
 cnDell200             equ A302h ; Dell 200
 cnDell300             equ A303h ; Dell 300
 cnDell220             equ A305h ; Dell 220
 cnDell310             equ A306h ; Dell 310
 cnDell325             equ A307h ; Dell 325
 cnDell310A            equ A309h ; Dell 310A
 cnDell316             equ A30Ah ; Dell 316
 cnDell220E            equ A30Bh ; Dell 220E
 cnDell210             equ A30Ch ; Dell 210
 cnDell316SX           equ A30Dh ; Dell 316SX
 cnDell316LT           equ A30Eh ; Dell 316LT
 cnDell320LX           equ A30Fh ; Dell 320LX
 cnDell425E            equ A311h ; Dell 425E
 cnQuadramQuad386      equ A6FEh ; Quadram Quad 386
 cnReplyModel32        equ F2F8h ; Reply ModŠle 32
 cnMemorexTelex        equ F6F8h ; Memorex Telex
 cnCompaq286           equ FA00h ; Compaq 286 ou clone
 cnCompaq386           equ FA01h ; Compaq 386 ou clone
 cnIBMProcessorComplex equ FDF8h ; Processeur IBM complexe
 cnIBMPCradio9075      equ FEFAh ; IBM PCradio 9075

; ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
;                    Les diff‚rents modŠles de bus systŠme
; ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

 busUnknown          equ 00h  ; Bus inconnu
 busISA8             equ 08h  ; Bus ISA, 8 bits
 busISA16            equ 16h  ; Bus ISA, 16 bits
 busISAPCI           equ 20h  ; Bus ISA/PCI
 busEISA             equ 30h  ; Bus EISA
 busMCA              equ 40h  ; Bus MCA (PS/2)

; ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
;                 Les diff‚rents types de contr“leur CMOS RTC
; ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

 ctrlCmosNo          equ 00h  ; Pas de contr“leur CMOS RTC
 ctrlCmosUnknown     equ 01h  ; Contr“leur CMOS RTC de modŠle inconnu
 ctrlCmosMM58167a    equ 02h  ; Contr“leur CMOS RTC MM58167 (2C0h … 2DFh)
 ctrlCmosMM58167b    equ 03h  ; Contr“leur CMOS RTC MM58167 (2C0h … 2C7h)
 ctrlCmosRTC58321    equ 04h  ; Contr“leur CMOS RTC-58321 (2C0h … 2C1h)
 ctrlCmosMC146818    equ 05h  ; Contr“leur CMOS RTC MC146818 de Motorola

; ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
;                Constantes de type de disque (Interruption 13h)
; ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

 dtNoDrive           equ 0    ; Lecteur inexitant/introuvable...
 dtDD525             equ 1    ; Lecteur: 5¬" Double densit‚
 dtHD525             equ 2    ; Lecteur: 5¬" Haute densit‚
 dtDD35              equ 3    ; Lecteur: 3«" Double densit‚
 dtHD35              equ 4    ; Lecteur: 3«" Haute densit‚
 dTryMax             equ 5    ; Nombre d'essait maximal

; ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
;               Constantes de types de contr“leur de Disque dur
; ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

 ctrlhdNo            equ 0000h ; Pas de contr“leur de disque dur
 ctrlhdUnknown       equ 0001h ; Contr“leur de disque dur inconnu
 ctrlhdMFM           equ 0002h ; Contr“leur MFM
 ctrlhdIDE           equ 0003h ; Contr“leur IDE
 ctrlhdScsiTMC1680   equ 0200h ; Contr“leur SCSI TMC-1680
 ctrlhdScsiTMC1650   equ 0203h ; Contr“leur SCSI TMC-1650/1660/1670/1680
 ctrlhdScsiTMC820    equ 040Ah ; Contr“leur SCSI TMC-820/830/860/870/875/880/885
 ctrlhdScsiTMC840    equ 050Dh ; Contr“leur SCSI TMC-840/880/881
 ctrlhfScsiTMC830    equ 0700h ; Contr“leur SCSI TMC-830/850/860/875/885

; ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
;                Constantes de types de contr“leur clavier
; ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

 ctrlkbNo            equ 0000h ; Pas de contr“leur clavier, je pr‚sume que cela arrivera dans le futur...
 ctrlkbUnknown       equ 0001h ; Contr“leur clavier inconnu
 ctrlkb8048          equ 0002h ; Contr“leur clavier des PC, XT, PC Junior (Puce 8048)
 ctrlkb8042          equ 0003h ; Contr“leur clavier des AT, PS/2 (Puce 8042)

; ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
;                        Constantes de styles de clavier
; ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

 kbPC                equ 00h   ; Clavier PC original
 kbXT                equ 01h   ; Clavier XT original
 kbAT                equ 02h   ; Clavier AT de 84 touches
 kbConterm           equ 40h   ; Clavier Conterm Max/int‚gr‚ aux boŒtiers de l'ordinateur
 kbMF                equ 80h   ; Clavier MF de 101/102 touches

; ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
;       Les diff‚rents mode de fontionnement de l'environnement Windows
; ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

 winNo               equ 000h   ; Pas de Windows actif
 win386X             equ 001h   ; Windows/386 Version 2.X
 winReal             equ 081h   ; Windows fonctionnant en mode r‚el
 winStandard         equ 082h   ; Windows fonctionne en mode standard
 winEnhanced         equ 083h   ; Windows fonctionne en mode ‚tendu
 winNT               equ 0C0h   ; Windows NT

; ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
;                       Les diff‚rents marque de Souris
; ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

 msNoMouse           equ 00h   ; Pas de souris
 msLogitech          equ 01h   ; Souris Logitech
 msMicrosoft         equ 02h   ; Souris Microsoft
 msSmooth            equ 03h   ; Souris Smooth de Andy Hakim
 msZNIX              equ 04h   ; Souris Z-NIX
 msGenius            equ 05h   ; Souris Genius
 msPS2               equ 06h   ; Souris PS/2
 msStandard          equ 80h   ; Souris Standard

; ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
;                 Les diff‚rents nom de modŠle de carte vid‚o
; ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

 vnUnknown           equ 0    ;D‚tection automatique
 vnAhead             equ 1    ;Ahead
 vnAheadB            equ 2    ;Ahead B (SVGA)
 vnAheadBWizard3270  equ 3    ;Ahead B-Wizard/3270 (SVGA)
 vnAheadEGA2001      equ 4    ;Ahead EGA2001 (Super EGA)
 vnAllstarPeacock    equ 5    ;Allstar Peacock (VGA)
 vnASTVGAPlus        equ 6    ;AST VGA Plus (SVGA)
 vnATT               equ 7    ;AT&T
 vnATT6300           equ 8    ;AT&T 6300 (Super EGA)
 vnATTVDC600         equ 9    ;AT&T VDC600 (SVGA)
 vnCardinal          equ 10   ;Cardinal (SVGA)
 vnCGA               equ 11   ;CGA
 vnCirrus            equ 12   ;Cirrus (SVGA)
 vnCompaqPortable    equ 13   ;Compaq Portable
 vnCompaqVGA         equ 14   ;Compaq VGA (SVGA)
 vnCTI82C451         equ 15   ;CTI 82C451 (SVGA)
 vnCTI82C452         equ 16   ;CTI 82C452 (SVGA)
 vnDellVGA           equ 17   ;Dell VGA (SVGA)
 vnEGA               equ 18   ;EGA
 vnEGAW800           equ 19   ;EGA Wonder 800+ (Super EGA)
 vnEGAW800N18800     equ 20   ;EGA Wonder 800+-18800 (Super EGA)
 vnEGAW800N18800_1   equ 21   ;EGA Wonder 800+-18800-1 (Super EGA)
 vnEGAW800N28800_2   equ 22   ;EGA Wonder 800+-28800-2 (Super EGA)
 vnEGAW800N28800_4   equ 23   ;EGA Wonder 800+-28800-4 (Super EGA)
 vnEGAW800N28800_5   equ 24   ;EGA Wonder 800+-28800-5 (Super EGA)
 vnEverex            equ 25   ;Everex
 vnEverexViewPoint   equ 26   ;Everex ViewPoint
 vnEverexUG2         equ 27   ;Everex UltraGraphics II
 vnEverexVision      equ 28   ;Everex Vision
 vnEverexEVGA        equ 29   ;Everex EVGA
 vnGenoa             equ 30   ;Genoa
 vnGenoa5100         equ 31   ;Genoa 5100
 vnGenoa5300         equ 32   ;Genoa 5300
 vnGenoa6100         equ 33   ;Genoa 6100
 vnGenoa6200         equ 34   ;Genoa 6200
 vnGenoa6400         equ 35   ;Genoa 6400 (SVGA)
 vnGS                equ 36   ;Graphics Solution d'ATI (Super CGA)
 vnGU                equ 37   ;Graphics Ultra d'ATI (SVGA)
 vnGUPlus            equ 38   ;Graphics Ultra d'ATI (SVGA)
 vnGUPro             equ 39   ;Graphics Ultra d'ATI (SVGA)
 vnHeadLand          equ 40   ;HeadLand (SVGA)
 vnHercule           equ 41   ;Hercule (HGC)
 vnHPD1180A          equ 42   ;Hewlett-Packard D1180A (SVGA)
 vnHP95LX            equ 43   ;HP 95LX
 vnIBM8514A          equ 44   ;IBM 8514/AI
 vnImtec             equ 45   ;Imtec (SVGA)
 vnITVGA2            equ 46   ;IT-VGA2 (SVGA)
 vnLavaChromeIIEGA   equ 47   ;Lava Chrome II EGA (Super EGA)
 vnLogix             equ 48   ;Logix (SVGA)
 vnMCGA              equ 49   ;MCGA
 vnMDA               equ 50   ;MDA
 vnMaxxon            equ 51   ;Maxxon
 vnMorseVGA          equ 52   ;Morse VGA (VGA)
 vnNSISmartEGA       equ 53   ;NSI Smart EGA+ (Super EGA)
 vnOak               equ 54   ;Oak Technologies (SVGA)
 vnOrchid            equ 55   ;Orchid
 vnOrchidProDesVGA   equ 56   ;Orchid Prodesigner VGA (SVGA)
 vnOrchidProDesIIVGA equ 57   ;Orichid Prodesigner II VGA (SVGA/32768 couleurs)
 vnParadise          equ 58   ;Paradise
 vnParadiseEGA480    equ 59   ;Paradise EGA-480,Super EGA
 vnParadisePVGA1A    equ 60   ;Paradise PVGA1A
 vnParadiseWD90C00   equ 61   ;Paradise WD90C00
 vnParadiseWD90C10   equ 62   ;Paradise WD90C10
 vnParadiseWD90C11   equ 63   ;Paradise WD90C11
 vnPC3270            equ 64   ;PC 3270
 vnPC3270G           equ 65   ;PC 3270G
 vnPC3270GX          equ 66   ;PC 3270GX
 vnPCJr              equ 67   ;PC Junior
 vnPGA               equ 68   ;PGA
 vnPrismElite        equ 69   ;Prism Elite d'ATI (SVGA)
 vnQU                equ 70   ;Quadram Ultra VGA (SVGA)
 vnSEFCOTVGA         equ 71   ;SEFCO TVGA (SVGA)
 vnSigma             equ 72   ;Sigma (SVGA)
 vnSTB               equ 73   ;STB (SVGA)
 vnSTBVGAEM16Plus    equ 74   ;STB VGA/EM-16 Plus (SVGA)
 vnTatungVGA         equ 75   ;Tatung VGA (SVGA)
 vnTaxan565EGA       equ 76   ;Taxan 565 EGA (Super EGA)
 vnTecmarVGAAD       equ 77   ;Tecmar VGA/AD (SVGA)
 vnTIGA              equ 78   ;TIGA de Texas Instrument
 vnTrident8800BR     equ 79   ;Trident 8800BR (SVGA)
 vnTrident8800CS     equ 80   ;Trident 8800CS (SVGA)
 vnTrident8900       equ 81   ;Trident 8900 (SVGA)
 vnT3000             equ 82   ;Tseng ET3000 (SVGA)
 vnT4000             equ 83   ;Tseng ET4000 (SVGA)
 vnT4000HiColor      equ 84   ;Tseng ET4000 HiColor (SVGA)
 vnT4000HiColorSC    equ 85   ;Tseng ET4000 HiColor SC (SVGA)
 vnUltraVisionEGA    equ 86   ;Ultra Vision EGA (Super EGA)
 vnVESA              equ 87   ;VESA
 vnVGA               equ 88   ;VGA
 vnVGAW              equ 89   ;VGA Wonder d'ATI (SVGA)
 vnVGAW18800         equ 90   ;VGA Wonder d'ATI 18800 (SVGA)
 vnVGAW18800_1       equ 91   ;VGA Wonder d'ATI 18800-1 (SVGA)
 vnVGAW28800_2       equ 92   ;VGA Wonder d'ATI 28800-2 (SVGA)
 vnVGAW28800_4       equ 93   ;VGA Wonder d'ATI 28800-4 (SVGA)
 vnVGAW28800_5       equ 94   ;VGA Wonder d'ATI 28800-5 (SVGA)
 vnV7                equ 95   ;Video 7 (SVGA)
 vnV7Vram            equ 96   ;Video 7 Vram (SVGA)
 vnV7Vega            equ 97   ;Video 7 Vega (SVGA)
 vnV7Ver5            equ 98   ;Video 7 Version 5 (SVGA)
 vnV71024i           equ 99   ;Video 7 1024i (SVGA)
 vnVIP               equ 100  ;ATI VIP (SVGA)
 vnXGA               equ 101  ;XGA (SVGA)
 vnZymos             equ 102  ;Zymos (SVGA)
 vnZymosPoach        equ 103  ;Zymos Poach (SVGA)
 vnMatrox            equ 104  ;Matrox
 vnMatroxMystique    equ 105  ;Matrox Mystique
 vnMatroxMillenium   equ 106  ;Matrox Millenium
 vnMatroxG200        equ 107  ;Matrox G200
 vnMax               equ 107  ;Num‚ro maximal de nom de carte vid‚o.

; ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
;                          Cat‚gorie de carte vid‚o
; ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
 cvnNone             equ 0    ;Aucune,inconnue
 cvnMDA              equ 1    ;MDA
 cvnHGC              equ 2    ;HGC,GS en mode mono,...
 cvnCGA              equ 3    ;GS,CGA,Super CGA,...
 cvnEGA              equ 4    ;EGA,Super EGA
 cvnVGA              equ 5    ;MCGA,VGA,...
 cvnSvga             equ 6    ;Super VGA
 cvnVESA             equ 7    ;Super VGA (VESA)

; ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
;                     Les diff‚rents modŠle de moniteur
; ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
 mnUnknown           equ 0    ;Inconnue
 mn3295              equ 1    ;3295
 mn5151              equ 2    ;5151
 mn5272              equ 3    ;5272
 mn5279              equ 4    ;5279
 mn5379C01           equ 5    ;5379C01
 mn5379M01           equ 6    ;5379M01
 mn8514              equ 7    ;8514
 mnAnalog            equ 8    ;Analogue
 mnAnalogKr          equ 9    ;Analogue Couleur
 mnAnalogMono        equ 10   ;Analogue Monochrome
 mnAnalogMultiSync   equ 11   ;Analogue MultiSync
 mnCGA               equ 12   ;CGA
 mnDigitalKr         equ 13   ;Digital Couleur
 mnDigitalMultiSync  equ 14   ;Digital MultiSync
 mnDigitalTTL        equ 15   ;Digital TTL
 mnEGA               equ 16   ;EGA
 mnFixedSync         equ 17   ;FixedSync
 mnMDA               equ 18   ;MDA
 mnMultiSync         equ 19   ;MultiSync
 mnMultiSync2A       equ 20   ;MultiSync 2A
 mnNEC3D             equ 21   ;NEC 3D
 mnNECMultiSync      equ 22   ;NEC MultiSync
 mnRGBkr             equ 23   ;RGB Couleur
 mnSeiko1430         equ 24   ;Seiko 1430
 mnSuperMultiSync    equ 25   ;Super MultiSync
 mnSuperVGA          equ 26   ;Super VGA
 mnTatungOmniScan    equ 27   ;Tatung OmniScan
 mnTTLDigital        equ 28   ;TTL Digital
 mnTTLMonochrome     equ 29   ;TTL Monochrome
 mnTVM2A             equ 30   ;TVM 2A
 mnTVM3A             equ 31   ;TVM 3A
 mnTVM3M             equ 32   ;TVM 3M
 mnVGA               equ 33   ;VGA

 vmTxtBW40            equ 0     ;Texte noir et blanc 40x25
 vmTxtC40             equ 1     ;Texte couleur 40x25
 vmTxtC40x28          equ 01257h;Texte couleur 40x28
 vmTxtC40x43          equ 01258h;Texte couleur 40x43
 vmTxtC40x50          equ 01259h;Texte couleur 40x50
 vmTxtBW80            equ 2     ;Texte noir et blanc 80x25
 vmTxtC80             equ 3     ;Texte couleur 80x25
 vmTxtC80x28          equ 01260h;Texte couleur 80x28
 vmTxtC80x30          equ 01261h;Texte couleur 80x30
 vmTxtC80x33          equ 01262h;Texte couleur 80x33
 vmTxtC80x34          equ 01263h;Texte couleur 80x34
 vmTxtC80x43          equ 01264h;Texte couleur 80x43
 vmTxtC80x50          equ 01265h;Texte couleur 80x50
 vmTxtC80x60          equ 01266h;Texte couleur 80x60
 vmTxtC80x66          equ 01267h;Texte couleur 80x66
 vmTxtC100x30         equ 01268h;Texte couleur 100x30
 vmTxtC100x37         equ 01269h;Texte couleur 100x37
 vmTxtC100x40         equ 0126Ah;Texte couleur 100x40
 vmTxtC100x50         equ 01270h;Texte couleur 100x50
 vmTxtC100x60         equ 01271h;Texte couleur 100x60
 vmTxtC100x75         equ 01272h;Texte couleur 100x75
 vmTxtC120x25         equ 01273h;Texte couleur 120x25
 vmTxtC120x43         equ 01274h;Texte couleur 120x43
 vmTxtC132            equ 01275h;Texte couleur 132x25
 vmTxtC132x28         equ 01276h;Texte couleur 132x28
 vmTxtC132x30         equ 01277h;Texte couleur 132x30
 vmTxtC132x43         equ 01278h;Texte couleur 132x43
 vmTxtC132x44         equ 01279h;Texte couleur 132x44
 vmTxtC132x50         equ 01280h;Texte couleur 132x50
 vmTxtC132x60         equ 01281h;Texte couleur 132x60
 vmTxtC132x100        equ 01282h;Texte couleur 132x100
 vmTxtC160x50         equ 01283h;Texte couleur 160x50
 vmTxtMono            equ 7     ;Texte monochrome 80x25
 vmTxtMono80x28       equ 01284h;Texte monochrome 80x28
 vmTxtMono80x30       equ 01285h;Texte monochrome 80x30
 vmTxtMono80x34       equ 01286h;Texte monochrome 80x34
 vmTxtMono80x43       equ 01287h;Texte monochrome 80x43
 vmTxtMono80x50       equ 01288h;Texte monochrome 80x50
 vmTxtMono80x60       equ 01289h;Texte monochrome 80x60
 vmTxtMono100x40      equ 0128Ah;Texte monochrome 100x40
 vmTxtMono100x60      equ 0128Bh;Texte monochrome 100x60
 vmTxtMono132         equ 0128Ch;Texte monochrome 132x25
 vmTxtMono132x28      equ 0128Dh;Texte monochrome 132x28
 vmTxtMono132x43      equ 0128Eh;Texte monochrome 132x43
 vmTxtMono132x44      equ 0128Fh;Texte monochrome 132x44
 vmHerc               equ 01321h;Hercule monochrome 720x348
 vmMinKrMode320x200   equ 01322h;Avec le nombre minimal de couleur en 320x200 pixels
 vmMaxKrMode320x200   equ 01323h;Avec le nombre maximal de couleur en 320x200 pixels
 vmGrf240x128c2       equ 01324h;Graphique 240x128 en 2 couleurs
 vmGrf320x200c4       equ 5     ;Graphique 320x200 en 4 couleurs
 vmGrf320x200c16      equ 13    ;Graphique 320x200 en 16 couleurs
 vmGrf320x200c256     equ 19    ;Graphique 320x200 en 256 couleurs
 vmGrf320x200C32768   equ 01325h;Graphique 320x200 en 32768 couleurs
 vmGrf320x200C65536   equ 01326h;Graphique 320x200 en 65536 couleurs
 vmGrf320x400c256     equ 01327h;Graphique 320x400 en 256 couleurs
 vmGrf360x480c256     equ 01328h;Graphique 360x480 en 256 couleurs
 vmGrf512x512c16      equ 01329h;Graphique 512x512 en 16 couleurs
 vmGrf512x512c256     equ 0132Ah;Graphique 512x512 en 256 couleurs
 vmMinKrMode640x200   equ 6     ;Mode avec le nombre minimal de couleur en 640x200 pixels
 vmMaxKrMode640x200   equ 0132Bh;Mode avec le nombre maximal de couleur en 640x200 pixels
 vmGrf640x200c2       equ 6     ;Graphique 640x200 en 2 couleurs
 vmGrf640x200c4       equ 10    ;Graphique 640x200 en 4 couleurs
 vmGrf640x200c16      equ 14    ;Graphique 640x200 en 16 couleurs
 vmMinKrMode640x350   equ 0132Ch;Mode avec le nombre minimal de couleur en 640x350 pixels
 vmMaxKrMode640x350   equ 0132Dh;Mode avec le nombre maximal de couleur en 640x350 pixels
 vmGrf640x350c2       equ 0132Eh;Graphique 640x350 en 2 couleurs
 vmGrf640x350c4       equ 0132Fh;Graphique 640x350 en 4 couleurs
 vmGrf640x350c16      equ 01330h;Graphique 640x350 en 16 couleurs
 vmGrf640x350c256     equ 01331h;Graphique 640x350 en 256 couleurs
 vmGrf640x350c32768   equ 01332h;Graphique 640x350 en 32768 couleurs
 vmMinKrMode640x400   equ 01333h;Mode avec le nombre minimal de couleur en 640x400 pixels
 vmMaxKrMode640x400   equ 01334h;Mode avec le nombre maximal de couleur en 640x400 pixels
 vmGrf640x400c2       equ 01335h;Graphique 640x400 en 2 couleurs
 vmGrf640x400c16      equ 01336h;Graphique 640x400 en 16 couleurs
 vmGrf640x400c256     equ 01337h;Graphique 640x400 en 256 couleurs
 vmGrf640x400c32768   equ 01338h;Graphique 640x400 en 32768 couleurs
 vmGrf640x462c16      equ 01339h;Graphique 640x462 en 16 couleurs
 vmMinKrMode640x480   equ 17    ;Mode avec le nombre minimal de couleur en 640x480 pixels
 vmMaxKrMode640x480   equ 0133Ah;Mode avec le nombre maximal de couleur en 640x480 pixels
 vmGrf640x480c2       equ 17    ;Graphique 640x480 en 2 couleurs
 vmGrf640x480c16      equ 0133Bh;Graphique 640x480 en 16 couleurs
 vmGrf640x480c256     equ 0133Ch;Graphique 640x480 en 256 couleurs
 vmGrf640x480c32768   equ 0133Dh;Graphique 640x480 en 32768 couleurs
 vmGrf640x480c65536   equ 0133Eh;Graphique 640x480 en 65536 couleurs
 vmGrf640x480c16M     equ 0133Fh;Graphique 640x480 en 16777216 de couleurs
 vmGrf720x350c2       equ 01340h;Graphique 720x350 en 2 couleurs
 vmGrf720x392c16      equ 01341h;Graphique 720x392 en 16 couleurs
 vmGrf720x512c16      equ 01342h;Graphique 720x512 en 16 couleurs
 vmGrf720x512c256     equ 01343h;Graphique 720x512 en 256 couleurs
 vmGrf720x540c16      equ 01344h;Graphique 720x540 en 16 couleurs
 vmGrf720x540c256     equ 01345h;Graphique 720x540 en 256 couleurs
 vmGrf752x410c16      equ 01346h;Graphique 752x410 en 16 couleurs
 vmGrf768x1024c16     equ 01347h;Graphique 768x1024 en 16 couleurs
 vmGrf800x560c16      equ 01348h;Graphique 800x560 en 16 couleurs
 vmMinKrMode800x600   equ 01349h;Mode avec le nombre minimal de couleur en 800x600 pixels
 vmMaxKrMode800x600   equ 0134Ah;Mode avec le nombre maximal de couleur en 800x600 pixels
 vmGrf800x600c2       equ 0134Bh;Graphique 800x600 en 2 couleurs
 vmGrf800x600c16      equ 0134Ch;Graphique 800x600 en 16 couleurs
 vmGrf800x600c256     equ 0134Dh;Graphique 800x600 en 256 couleurs
 vmGrf800x600c32768   equ 0134Eh;Graphique 800x600 en 32768 couleurs
 vmGrf800x600c65536   equ 0134Fh;Graphique 800x600 en 65536 couleurs
 vmGrf960x720c16      equ 01350h;Graphique 960x720 en 16 couleurs
 vmMinKrMode1024x768  equ 01351h;Mode avec le nombre minimal de couleur en 1024x768 pixels
 vmMaxKrMode1024x768  equ 01352h;Mode avec le nombre maximal de couleur en 1024x768 pixels
 vmGrf1024x768c2      equ 01353h;Graphique 1024x768 en 2 couleurs
 vmGrf1024x768c4      equ 01354h;Graphique 1024x768 en 4 couleurs
 vmGrf1024x768c16     equ 01355h;Graphique 1024x768 en 16 couleurs
 vmGrf1024x768c256    equ 01356h;Graphique 1024x768 en 256 couleurs
 vmGrf1024x768c32768  equ 01357h;Graphique 1024x768 en 32768 couleurs
 vmGrf1280x1024c16    equ 01358h;Graphique 1280x1024 en 16 couleurs
 vmGrf1280x1024c256   equ 01359h;Graphique 1280x1024 en 256 couleurs
 vmGrf1024x768c65536  equ 0135Ah;Graphique 1024x768 en 65536 couleurs
 vmGrf1280x1024c32768 equ 0135Bh;Graphique 1280x1024 en 32768 couleurs
 vmGrf1280x1024c65536 equ 0135Bh;Graphique 1280x1024 en 65536 couleurs
 vmTxtDef             equ 012F0h;Texte 80x25 en couleur ou monochrome
 vmTxtMaxRes80        equ 012F1h;Texte avec la r‚solution maximal en 80 colonnes
 vmTxtMaxRes          equ 012F2h;Texte avec la r‚solution maximal
 vmNone               equ 0FFFEh;Pas de mode vid‚o

; ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
;                        ModŠle de spooler d'imprimante
; ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

 drvNoSpooler        equ 00h  ;Pas de spooler d'imprimante.
 drvDiskSpoolII      equ 01h  ;Disk Spool II de Budget Software Company.
 drvPrintDos         equ 02h  ;Print du Dos (Spooler de fichier)
 drvPrintManager     equ 03h  ;PrintManager de Windows

; ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
;                          Code de Contr“le ASCII
; ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
caNUL  equ 000h ; Ctrl+@: Nulle (Null)
caSOH  equ 001h ; Ctrl+A
caSTX  equ 002h ; Ctrl+B
caETX  equ 003h ; Ctrl+C: Arrˆte le processus en cours (Break)
caEOT  equ 004h ; Ctrl+D
caENQ  equ 005h ; Ctrl+E
caACK  equ 006h ; Ctrl+F
caBELL equ 007h ; Ctrl+G: Bip sonore (Beep)
caBS   equ 008h ; Ctrl+H: Recule et efface le caractŠre (BackSpace)
caHT   equ 009h ; Ctrl+I: Tabulation horizontal (Horizontal Tabulation)
caLF   equ 00Ah ; Ctrl+J: D‚placement vers le bas (Line Feed)
caVT   equ 00Bh ; Ctrl+K: Tabulation vertical (Vertical Tabulation)
caFF   equ 00Ch ; Ctrl+L: Efface l'‚cran (Full Feed)
caCR   equ 00Dh ; Ctrl+M: Retour de chariot (Carriage Return)
caSO   equ 00Eh ; Ctrl+N: Echo off
caSI   equ 00Fh ; Ctrl+O
caDLE  equ 010h ; Ctrl+P: Echo on
caXON  equ 011h ; Ctrl+Q
caDC2  equ 012h ; Ctrl+R
caXOFF equ 013h ; Ctrl+S: Pause
caDC4  equ 014h ; Ctrl+T
caNAK  equ 015h ; Ctrl+U
caSYN  equ 016h ; Ctrl+V
caETB  equ 017h ; Ctrl+W
caCAN  equ 018h ; Ctrl+X: Efface la ligne courant
caEM   equ 019h ; Ctrl+Y
caSUB  equ 01Ah ; Ctrl+Z
caESC  equ 01Bh ; Ctrl+[: Echappatoire (Escape)
caFS   equ 01Ch ; Ctrl+\
caGS   equ 01Dh ; Ctrl+]
caRS   equ 01Eh ; Ctrl+^
caUS   equ 01Fh ; Ctrl+_
caSP   equ 020h ; ' ': Espace (Space)
caDEL  equ 07Fh ; '': Efface (Delete)
caFFh  equ 0FFh ; Ascii FFh

MaxComPorts equ 8

; ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
;                   Constante de l'Ensemble Isabel/Chantal
; ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

; ModŠle de d‚part
 suIsabel         equ 000h  ; Mode standard Isabel
 suNoInt          equ 0F0h  ; Pas d'installation d'interruption
; Drapeau conditionnel de v‚rification autoris‚
 flgProtectedMode equ 0001h ; Ex‚cution en mode prot‚g‚? Par d‚faut: Non
 ;Ce jumper doit ˆtre mis  … vrai  quand le StartUp est lanc‚ en
 ;m‚moire prot‚g‚;  cela aura  pour effet  qu'il n'utilisera pas
 ;d'accŠs m‚moire directe. Attention! Ne mettre cette variable …
 ;vrai  quand  cas  de n‚cessit‚  parceque ‡a ralentie dr“lement
 ;l'ex‚cution  en plus  d'ˆtre partiellement  moins fiable.  Par
 ;d‚faut,  mˆme un XT  … un contr“leur CMOS  pour lui,  et l'EMS
 ;n'existe pas car inutile en mode prot‚g‚.
 flgEquipPerBios  equ 0002h ;Utilise le Bios pour connaŒtre l'‚quipement? Par d‚faut: Non
 ;Par d‚faut le StartUp utilise l'accŠs en m‚moire pour connaŒtre
 ;l'‚quipement plut“t  que d'utiliser l'interruption  11h et 12h.
 ;Personnellement,  j'ai jamais utilis‚ le Bios pour connaŒtre se
 ;genre  d'information,  mais  dans les cas d‚sesp‚r‚s  de 0%  de
 ;compatibilit‚, j'imagine que sa peut servir...
 flgJoyPerBios    equ 0004h ;Manette de jeu acc‚der par le Bios ? Par d‚faut: Non
 ;Mettre  …  vrai  seulement  s'il  plante  en utilisant le port
 ;d'entr‚e/sortie 201h ou qu'une ‚mulation de manette de jeu est
 ;en cours par l'entremise de l'interruption 15h,Fonction 84h...
 flgNoExtBiosMemDetect equ 0008h ;Pas d‚tection de la m‚moire ‚tendue par
			         ;l'interruption 15h? Par d‚faut: Non
 ;Cette variable doit ˆtre mis … vrai lorsque la d‚tection de la
 ;m‚moire  ‚tendu   par  l'interruption 15h,  Fonction 88h  fait
 ;planter la machine  ou que  des conflits  d'adressage  m‚moire
 ;surviennent dans le systŠme.
 flgOnlyMem4ComputerName equ 0010h ;Utilise seulement la m‚moire pour connaŒtre
			           ;le nom de l'ordinateur? Par d‚faut: Non
 ;Cette variable utilise seulement l'adresse m‚moire FFFFxh pour
 ;connaŒtre  le  modŠle  d'ordinateur  utilis‚.  Mettre  …  vrai
 ;seulement si la d‚tection de votre ordinateur, r‚vŠle que vous
 ;poss‚dez une %&$%^&^%&,(ou si vous pr‚f‚rer: il "fuck"le chien.
 flgNoCountryDetect equ 0020h ;Pas de d‚tection de pays? Par d‚faut: Non
 ;Les variables  de pays ne seront pas touch‚  si cette variable
 ;est … vrai.  Interne au application,  permet,  par exemple, de
 ;charger  … partir d'une fichier la configuration d'un pays. On
 ;peut ‚galement fix‚ cette variable  … vrai pour le Dos 1.0, ou
 ;un Dos incompatible pour ‚viter d'avoir un retour de donn‚e en
 ;blanc.
 flgNoMouseDetect equ 0040h ;Pas de d‚tection de la souris? Par d‚faut: Non
 ;Ce jumper ne doit seulement ˆtre utilis‚ que lorsque la souris
 ;provoque des conflits dans le systŠme.  Alors  si l'ordinateur
 ;plante pendant  une d‚tection de souris priŠre de mettre cette
 ;variable  … Vrai.  On  peut  ‚galement  avoir  …  faire  … une
 ;interruption  de la 4iŠme  DIMENSION  ou  qui plus  est  …  un
 ;Virus  narcotique  modifiant  cette interruption  …  des  fins
 ;diablique!  Et dans cette situation, je vous suggŠre ‚galement
 ;de fixer cette variable … Vrai.
 flgNoSpoolerDetect equ 0080h ;Pas de d‚tection de Spooler d'imprimante? Par d‚faut: Non
 ;Ce jumper  doit ˆtre  … vrai  quand  la  d‚tection  du  spooler
 ;provoque un plantage pur et dur de la machine.
 flgNoCmosDetect equ 0100h ;Pas de d‚tection ou d'utilisation du CMOS? Par d‚faut: Non
 ;Cette variable interdit (vrai) ou autorise (faux) la d‚tection
 ;et la manipulation du contr“leur de CMOS. Dois-ˆtre mis … vrai
 ;dans le cas d'incompatibilit‚ de CMOS (en particuli‚ chez les XT.
 flgJoyFunc equ 0200h ;Allocation de fonction de manette de jeu ?
 ;Cette variable demande l'utilisation de routine clavier non-directe
 flgNotDirKey equ 0400h ; Pas d'utilisation directe du clavier ?

 flgSkipCPUTest equ 0800h ; Pas de d‚tection du microprocesseur
 flgNoNovell equ 1000h ; Pas de d‚tection de Novell

 ;Drapeau d'existance des Interruptions de la variable IntExistFlag
 flgInt10h equ 1     ; Drapeau indiquant l'existance de l'interruption 10h
 flgInt11h equ 2     ; Drapeau indiquant l'existance de l'interruption 11h
 flgInt12h equ 4     ; Drapeau indiquant l'existance de l'interruption 12h
 flgInt13h equ 8     ; Drapeau indiquant l'existance de l'interruption 13h
 flgInt14h equ 0010h ; Drapeau indiquant l'existance de l'interruption 14h
 flgInt15h equ 0020h ; Drapeau indiquant l'existance de l'interruption 15h
 flgInt16h equ 0040h ; Drapeau indiquant l'existance de l'interruption 16h
 flgInt1Ah equ 0080h ; Drapeau indiquant l'existance de l'interruption 1Ah
 flgInt21h equ 0100h ; Drapeau indiquant l'existance de l'interruption 21h
 flgInt2Ah equ 0200h ; Drapeau indiquant l'existance de l'interruption 2Ah
 flgInt2Fh equ 0400h ; Drapeau indiquant l'existance de l'interruption 2Fh
 flgInt33h equ 0800h ; Drapeau indiquant l'existance de l'interruption 33h
 flgInt67h equ 1000h ; Drapeau indiquant l'existance de l'interruption 67h
  ; R‚f‚rence d'index de la ressource "STARTUP.*"
IFDEF Adele
 suAltPress4Mem      equ 0d       ;>AltPressedPerMemory:Boolean  pour indiquer que la<
			          ; lecture  de l'‚tat  de la touche Alt  se fait par<
			          ; un m‚thode d'accŠs directe en m‚moire.
 suAltPress4Memi286  equ 15d      ;>GetAltPressedPerMemoryIntel80286:  Boolean   pour<
			          ; indiquer  que la lecture  de l'‚tat  de la touche<
			          ; Alt se fait  par un m‚thode  d'accŠs  directe  en<
		    	          ; m‚moire avec des instruction pour les CPU 80286.
 suAltPress4Bios equ 45d          ;>AltPressedPerBios:Boolean  pour  indiquer  que la<
			          ; lecture  de l'‚tat  de la touche Alt  se fait par<
			          ; l'intremise du Bios:  Interruption 16h,  Fonction<
			          ; 01h.
 suCtrlPress4Mem equ 01d          ;>CtrlPressedPerMemory:Boolean pour indiquer que la<
			          ; lecture de l'‚tat  de la touche  Ctrl se fait par<
			          ; un m‚thode d'accŠs directe en m‚moire.
 suCtrlPress4Memi286 equ 16d      ;>GetCtrlPressedPerMemoryIntel286:  Boolean    pour<
			          ; indiquer  que la lecture  de l'‚tat  de la touche<
			          ; Ctrl  se fait  par un m‚thode  d'accŠs directe en<
			          ; m‚moire avec des instructions pour le CPU 80286.
 suCtrlPress4Bios equ 46d         ;>CtrlPressedPerBios:Boolean pour  indiquer  que la<
			          ; lecture  de l'‚tat de la touche Ctrl  se fait par<
			          ; l'intremise du Bios:  Interruption 16h,  Fonction<
			          ; 01h.
 suFillChr4Def equ 02d            ;>FillCharPerDefault(Var Buffer;Length:Word; Value:<
			          ; Byte) pour les CPU 8088, 80188 et NEC V20.
 suFillChrPer86 equ 02d           ;>FillCharPer86(Var  Buffer;Length:Word;Value:Byte)<
			          ; pour les CPU 8086, 80186, 80286 et NEC V30.
 suFillChrPer32Bits equ 32d       ;>FillCharPer32Bits(Var Buffer; Length:Word; Value:<
			          ; Byte) pour les CPU 80386, 80486 ou post‚rieur.
 suGetIntVec4Mem equ 03d          ;>GetIntVecPerMemoryAccess(InterruptNumber:Byte;Var<
			          ; Vector:Pointer)  pour  les  m‚thodes  directe  en<
			          ; accŠs m‚moire extrˆmant rapide!
 suGetIntVec4Mem286 equ 18d       ;>GetIntVecPerMemoryAccess(InterruptNumber:Byte;Var<
			          ; Vector:Pointer)  pour  les  m‚thodes  directe  en<
			          ; accŠs m‚moire extrˆmant rapide! M‚thode utilisant<
			          ; des instructions pour CPU 80286.
 suGetIntVec4Mem386 equ 33d       ;>GetIntVecPerMemoryAccess(InterruptNumber:Byte;Var<
			          ; Vector:Pointer)  pour  les  m‚thodes  directe  en<
			          ; accŠs m‚moire extrˆmant rapide! M‚thode utilisant<
			          ; des instructions pour CPU 80386.
 suGetIntVec4Dos equ 48d          ;>GetIntVecPerDos(InterruptNumber:Byte;Var  Vector:<
			          ; Pointer)  pour les m‚thodes  compatible  en  Mode<
			          ; Prot‚g‚ et Windows.
 suGetRawTimer4Mem equ 04d        ;>GetRawTimerPerMemory:Long cette fonction retourne<
			          ; l'horloge brute incr‚ment‚ … tous les  18,2  fois<
			          ; par  seconde  en  utilisant  la  cellule  m‚moire<
			          ; affect‚ par l'IRQ0 (La meilleur m‚thode).
 suGetRawTimer4Memi286 equ 19d    ;>GetRawTimerPerM286:Long   cette fonction retourne<
			          ; l'horloge brute incr‚ment‚ … tous les  18,2  fois<
			          ; par  seconde  en  utilisant  la  cellule  m‚moire<
			          ; affect‚ par l'IRQ0 et des instructions CPU 80286.
 suGetRawTimer4Int1Ah equ 49d     ;>GetRawTimerPerInt1A:Long  cette fonction retourne<
			          ; l'horloge brute incr‚ment‚ … tous les  18,2  fois<
			          ; par seconde en utilisant l'interruption 1Ah
 suGetRawTimerB4Mem equ 05d       ;>GetRawTimerBytePerDefault:Byte   cette   fonction<
			          ; retourne le 1iŠre octet  de l'horloge  incr‚ment‚<
	    		          ; … tous les 18,2 fois  par  seconde  en  utilisant<
			          ; l'adressage m‚moire directe 0040h:006Ch.
 suGetRawTimerB4Memi286 equ 20d   ;>GetRawTimerBytePerDefault:Byte   cette   fonction<
			          ; retourne le 1iŠre octet  de l'horloge  incr‚ment‚<
			          ; … tous les 18,2 fois  par  seconde  en  utilisant<
			          ; l'adressage m‚moire directe 0040h:006Ch. Avec des<
			          ; instruction   de   CPU   80286  contrairement  au<
			          ; pr‚c‚dent.
 suGetRawTimerB4Int1Ah equ 50d    ;>GetRawTimerBytePerInter1Ah:Byte   cette  fonction<
			          ; retourne le 1iŠre octet  de  l'horloge incr‚ment‚<
			          ; … tous les 18,2 fois  par  seconde  en  utilisant<
			          ; l'interruption 1Ah.
 suGetRawTimer4Cmos equ 105
 suJoyPos4IO equ 06d              ;>JoystickPositionPerInputOuput(Axe:Byte):Word pour<
			          ; la m‚thode utilisant  les  ports  d'entr‚e/sortie<
			          ; 201h du contr“leur support‚ par  tous les anciens<
			          ; modŠle de PC.  Mais  y  eu un m‚chant scrach avec<
			          ; l'arriv‚e de Windows...
 suJoyPos4Bios equ 51d            ;>JoystickPositionPerBios(Axe:Byte):Word   pour  la<
			          ; m‚thode   de     compatibilit‚    du   d‚sespoir:<
			          ; Interruption 15h, Fonction 84h.
 suJoyPosRet equ 96d              ; JoystickPositionReturn(Axe:Byte):Word   n'est  en<
			          ; faite qu'un simple retour de fonction pour ‚viter<
			          ; qu'un  appel  accidentel est  lieu  lorsqu'aucune<
			          ; manette de jeu n'existe.
 suKeyPress4Mem equ 07d           ;>KeypressedPerMemory:Boolean  pour la m‚thode  par<
			          ; d‚faut utilisant les accŠs  au tampon m‚moire  en<
			          ; adresse 0040h:x.
 suKeyPress4Bios equ 52d          ;>KeypressedPerBios:Boolean   pour    la    m‚thode<
			          ; utilisant le Bios: Interruption 16h, Fonction 01h.
 suKeyPress4Dos equ 82d           ;>KeypressedPerDos:Boolean     pour   la    m‚thode<
			          ; utilisant le Dos: Interruption 21h, Fonction ??h.
 suLShiftPress4Mem equ 08d        ;>LShiftPressedPerMemory:Boolean  pour indiquer que la<
			          ; lecture  de l'‚tat  de la touche Alt  se fait par<
			          ; un m‚thode d'accŠs directe en m‚moire.
 suLShiftPress4Memi286 equ 23d    ;>GetLShiftPressedPerMemoryIntel80286:  Boolean   pour<
			          ; indiquer  que la lecture  de l'‚tat  de la touche<
			          ; Alt se fait  par un m‚thode  d'accŠs  directe  en<
			          ; m‚moire avec des instruction pour les CPU 80286.
 suLShiftPress4Bios equ 53d ;>GetLeftShiftPressedPerBios:Boolean     pour    la<
			    ; m‚thode utilisant  l'interruption  16h,  fonction<
			    ; 01h.
 suMove4Def equ 09d         ;>MoveLeftPerDefault(Var  Source, Dest; Count:Word)<
			    ; pour les 8088, 80188 et NEC V20.
 suMovePer86 equ 09d        ;>MoveLeftPer86(Var  Source, Dest;Count:Word)  pour<
			    ; les 8086, 80186, 80286 et NEC V30.
 suMovePer32Bits equ 39d    ;>MoveLeftPer32Bits(Var  Source, Dest;  Count:Word)<
			    ; pour les 80386, 80486,...
 suPushKey4Mem equ 10d      ;>PushKeyPerMemory(Key:Word)   pour   ins‚rer   une<
			    ; touche  de  clavier directe  dans la  m‚moire  du<
			    ; tampon.  A utiliser  par  d‚faut.  Sur  tout  les<
			    ; anciens  modŠles  d'ordinateur   100%  compatible<
			    ; c'est la seule fa‡on d'ins‚rer  des  touches  car<
			    ; l'Interruption 15h, Fonction 4Fh.
 suPushKey4Bios16h equ 55d  ;>PushKeyPerBios16h(Key:Word)   pour  ins‚rer   une<
			    ; touche de clavier  dans le tampon en passant  par<
			    ; le Bios: Interruption 16h, Fonction 05h.
 suReadKey4Mem equ 11d      ;>ReadKeyPerMemory:Word   pour   extraire  un  code<
			    ; clavier du tampon clavier en passant  directement<
			    ; par le tampon m‚moire 0040h:x.
 suReadKey4Bios00h equ 56d  ;>ReadKeyPerBiosFunction00h:Word  pour extraire  un<
			    ; code  clavier   du  tampon  clavier   en  passant<
			    ; par  la  fonction   00h  de  l'interruption  16h.<
			    ; Compatibilit‚ pour les anciens trŠs vieux modŠle.
 suReadKey4Bios10h equ 71d  ;>ReadKeyPerBiosFunction10h:Word  pour  extraire un<
			    ; code  clavier  du  tampon  clavier   en   passant<
			    ; par  la  fonction  10h   de  l'interruption  16h.<
			    ; Technique disponible  que  sur les  Bios  clavier<
			    ; ‚tendu.  Contrairement … la fonction  00h,  cette<
			    ; fonction lit ‚galement les F11, F12,...
 suReadKey4Dos equ 86d      ;>ReadKeyPerDos:Word  pour extraire un code clavier<
			    ; du  tampon  clavier   en  passant   par  le  Dos.<
			    ; Technique  critique  consernant la compatibilit‚.<
			    ; Ne doit ˆtre utilis‚ que dans les cas poussant au<
			    ; suicide ou … une alternative de celle-ci...!
 suRShiftPress4Mem equ 12d  ;>GetRightShiftPressedPerMemory:   Boolean     pour<
			    ; indiquer que la lecture  de l'‚tat  de la  touche<
			    ; Shift  de droite se fait  par un m‚thode  d'accŠs<
			    ; directe en m‚moire.
 suRShiftPress4Memi286 equ 27d
 suRShiftPress4Bios equ 57d ;>GetRightShiftPressedPerBios:Boolean pour indiquer<
			    ; que la lecture de l'‚tat  de la touche  Shift  de<
			    ; droite   se  fait  par   l'intremise   du   Bios:<
			    ; Interruption 16h, Fonction 01h.
 suSetIntVec4Mem equ 13d    ;>SetInterruptVectorPerMemory(InterruptNumber:Byte;
			    ; Vector:Pointer)
 suSetIntVec4Memi286 equ 28d
 suSetIntVec4Memi386 equ 43d
 suSetIntVec4Dos equ 58d    ;>SetInterruptVectorPerDos(InterruptNumber:Byte;
			    ; Vector:Pointer)
 suShiftPress4Mem equ 14d   ;>GetShiftPressedPerMemory:Boolean   pour  indiquer<
			    ; que la lecture de l'‚tat  de l'une/les  touche(s)<
			    ; Shift se fait/font par un m‚thode d'accŠs directe<
			    ; en m‚moire.
 suShiftPress4Memi286 equ 29d
 suShiftPress4Bios equ 59d  ;>GetShiftPressedPerBios:Boolean  pour indiquer que<
			    ; la lecture de l'‚tat de la touche Shift  se  fait<
			    ; par  l'intremise  du  Bios:   Interruption   16h,<
			    ; Fonction 01h.
ELSE
 suStartUpIsabel   equ 00h ; >StartUpIsabel(Var Jump:Jumper;Var StartUp:StartUpRec)
 suStartUpEconomic equ 01h
 suStartUpGolden   equ 02h
 suStartUpGame     equ 03h
 suStartUpNetwork  equ 04h
 suStartUpWindows  equ 05h
 suStartUpOpt1     equ 06h
 suStartUpOpt2     equ 07h
 suStartUpOpt3     equ 08h
 suStartUpOpt4     equ 09h
 suStartUpOpt5     equ 0Ah
 suStartUpOpt6     equ 0Bh
 suStartUpOpt7     equ 0Ch
 suStartUpOpt8     equ 0Dh
 suStartUpOpt9     equ 0Eh
 suStartUpOpt10    equ 0Fh
 suSetupMod        equ 10h ; >SetupMod ...
 suSetupPassword   equ 11h
 suUnSetupPassword equ 12h
 suSetupOpt1       equ 13h
 suSetupOpt2       equ 14h
 suSetupOpt3       equ 15h
 suSetupOpt4       equ 16h
 suSetupOpt5       equ 17h
 suSetupOpt6       equ 18h
 suSetupOpt7       equ 19h
 suSetupOpt8       equ 1Ah
 suSetupOpt9       equ 1Bh
 suSetupOpt10      equ 1Ch
 suSetupOpt11      equ 1Dh
 suSetupOpt12      equ 1Eh
 suSetupOpt13      equ 1Fh
  ; Technique pour le AltPressed: Nombre 6, option 3.
 suAltPress4Mem      equ 20h      ;>AltPressedPerMemory:Boolean  pour indiquer que la<
			          ; lecture  de l'‚tat  de la touche Alt  se fait par<
			          ; un m‚thode d'accŠs directe en m‚moire.
 suAltPress4Memi286  equ 21h      ;>GetAltPressedPerMemoryIntel80286:  Boolean   pour<
			          ; indiquer  que la lecture  de l'‚tat  de la touche<
			          ; Alt se fait  par un m‚thode  d'accŠs  directe  en<
		    	          ; m‚moire avec des instruction pour les CPU 80286.
 suAltPress4MemNoCLI equ 22h      ;>AltPressedPerMemoryNoCLI:Boolean   pour  indiquer<
			          ; que la lecture de l'‚tat de la touche Alt se fait<
			          ; par un m‚thode  d'accŠs  directe en m‚moire  sans<
			          ; tenir compte  des  interruptions  d'arriŠre  plan<
			          ; (IRQ).
 suAltPress4MemNoCLIi286 equ 23h  ;>AltPressedPerMemoryNoCLIi80286:Boolean   pour<
			          ; indiquer  que la lecture  de l'‚tat  de la touche<
			          ; Alt se fait  par un m‚thode  d'accŠs  directe  en<
			          ; m‚moire avec  des instruction  pour les CPU 80286<
			          ; sans  tenir  compte  des interruptions  d'arriŠre<
			          ; plan (IRQ).
 suAltPress4Bios equ 24h          ;>AltPressedPerBios:Boolean  pour  indiquer  que la<
			          ; lecture  de l'‚tat  de la touche Alt  se fait par<
			          ; l'intremise du Bios:  Interruption 16h,  Fonction<
			          ; 01h.
 suAltPressOpt1 equ 25h           ;>(Option1)  Cette entr‚e est bidon pour le moment,<
			          ; mais dans les futurs versions du StartUp, il sera<
			          ; utilis‚  fort  probablement  pour  une   nouvelle<
			          ; m‚thode de manipulation du clavier.
 suAltPressOpt2 equ 26h           ;>(Option2) Mˆme objectif que le suAltPressOpt1.
 suAltPressOpt3 equ 27h           ;>(Option3) Mˆme objectif que le suAltPressOpt1.
 suAltPressRet equ 28h            ;>AltPressedReturn:Boolean  n'est  en  faite  qu'un<
			          ; simple  retour  de  fonction  pour  ‚viter  qu'un<
			          ; appel  accidentel est lieu  lorsqu'aucun  clavier<
			          ; n'existe.
  ; Technique pour le CtrlPressed: Nombre 6, option 3.
 suCtrlPress4Mem equ 29h          ;>CtrlPressedPerMemory:Boolean pour indiquer que la<
			          ; lecture de l'‚tat  de la touche  Ctrl se fait par<
			          ; un m‚thode d'accŠs directe en m‚moire.
 suCtrlPress4Memi286 equ 2Ah      ;>GetCtrlPressedPerMemoryIntel286:  Boolean    pour<
			          ; indiquer  que la lecture  de l'‚tat  de la touche<
			          ; Ctrl  se fait  par un m‚thode  d'accŠs directe en<
			          ; m‚moire avec des instructions pour le CPU 80286.
 suCtrlPress4MemNoCLI equ 2Bh     ;>CtrlPressedPerMemoryNoCLI:Boolean  pour indiquer<
			          ; que la lecture  de l'‚tat  de la touche  Ctrl  se<
			          ; fait  par un m‚thode  d'accŠs  directe en m‚moire<
			          ; sans  tenir  compte  des interruptions  d'arriŠre<
			          ; plan (IRQ).
 suCtrlPress4MemNoCLIi286 equ 2Ch ;>CtrlPressedPerMemoryNoCLIi80286:Boolean pour<
			          ; indiquer  que la lecture  de l'‚tat  de la touche<
			          ; Ctrl se fait par un m‚thode  d'accŠs  directe  en<
			          ; m‚moire avec  des instruction  pour les CPU 80286<
			          ; sans  tenir  compte  des interruptions  d'arriŠre<
			          ; plan (IRQ).
 suCtrlPress4Bios equ 2Dh         ;>CtrlPressedPerBios:Boolean pour  indiquer  que la<
			          ; lecture  de l'‚tat de la touche Ctrl  se fait par<
			          ; l'intremise du Bios:  Interruption 16h,  Fonction<
			          ; 01h.
 suCtrlPressOpt1 equ 2Eh          ;>(Option1)  Cette entr‚e est bidon pour le moment,<
			          ; mais dans les futurs versions du StartUp, il sera<
			          ; utilis‚  fort  probablement   pour  une  nouvelle<
 			          ; m‚thode de manipulation du clavier.
 suCtrlPressOpt2 equ 2Fh          ;>(Option2) Mˆme objectif que le suCtrlPressOpt1.
 suCtrlPressOpt3 equ 30h          ;>(Option3) Mˆme objectif que le suCtrlPressOpt1.
 suCtrlPressRet equ 31h           ;>CtrlPressedReturn:Boolean  n'est  en faite  qu'un<
			          ; simple  retour  de  fonction  pour  ‚viter  qu'un<
			          ; appelle accidentel est lieu  lorsqu'aucun clavier<
			          ; n'existe.
  ; Technique pour FillCharacter: Nombre 4, option 2.
 suFillChr4Def equ 32h            ;>FillCharPerDefault(Var Buffer;Length:Word; Value:<
			          ; Byte) pour les CPU 8088, 80188 et NEC V20.
 suFillChrPer86 equ 33h           ;>FillCharPer86(Var  Buffer;Length:Word;Value:Byte)<
			          ; pour les CPU 8086, 80186, 80286 et NEC V30.
 suFillChrPer32Bits equ 34h       ;>FillCharPer32Bits(Var Buffer; Length:Word; Value:<
			          ; Byte) pour les CPU 80386, 80486 ou post‚rieur.
 suFillChrOpt1 equ 35h            ;>(Option1)  Cette entr‚e est bidon pour le moment,<
			          ; mais dans les futurs versions du StartUp, il sera<
			          ; utilis‚  fort  probablement   pour  une  nouvelle<
			          ; m‚thode de FillCharacter.
 suFillChrOpt2 equ 36h            ;>(Option2) Mˆme objectif que le suFillChrOpt1.
 suFillChrOpt3 equ 37h            ;>(Option3) Mˆme objectif que le suFillChrOpt1.
  ; Technique pour GetInterruptVector: Nombre 4, option 2.
 suGetIntVec4Mem equ 38h          ;>GetIntVecPerMemoryAccess(InterruptNumber:Byte;Var<
			          ; Vector:Pointer)  pour  les  m‚thodes  directe  en<
			          ; accŠs m‚moire extrˆmant rapide!
 suGetIntVec4Mem286 equ 39h       ;>GetIntVecPerMemoryAccess(InterruptNumber:Byte;Var<
			          ; Vector:Pointer)  pour  les  m‚thodes  directe  en<
			          ; accŠs m‚moire extrˆmant rapide! M‚thode utilisant<
			          ; des instructions pour CPU 80286.
 suGetIntVec4Mem386 equ 3Ah       ;>GetIntVecPerMemoryAccess(InterruptNumber:Byte;Var<
			          ; Vector:Pointer)  pour  les  m‚thodes  directe  en<
			          ; accŠs m‚moire extrˆmant rapide! M‚thode utilisant<
			          ; des instructions pour CPU 80386.
 suGetIntVec4Dos equ 3Bh          ;>GetIntVecPerDos(InterruptNumber:Byte;Var  Vector:<
			          ; Pointer)  pour les m‚thodes  compatible  en  Mode<
			          ; Prot‚g‚ et Windows.
 suGetIntVecOpt1 equ 3Ch          ;>(Option1)  Cette entr‚e est bidon pour le moment,<
			          ; mais dans les futurs version du StartUp,  il sera<
			          ; sans doute utilis‚  pour une nouvelle m‚thode  de<
			          ; modification de vecteur d'interruption.
 suGetIntVecOpt2 equ 3Dh          ;>(Option2) Mˆme objectif que le suGetIntVecOpt2.
  ; Technique de GetRawTimer: Nombre 4, option 0
 suGetRawTimer4Mem equ 3Eh        ;>GetRawTimerPerMemory:Long cette fonction retourne<
			          ; l'horloge brute incr‚ment‚ … tous les  18,2  fois<
			          ; par  seconde  en  utilisant  la  cellule  m‚moire<
			          ; affect‚ par l'IRQ0 (La meilleur m‚thode).
 suGetRawTimer4Memi286 equ 3Fh    ;>GetRawTimerPerM286:Long   cette fonction retourne<
			          ; l'horloge brute incr‚ment‚ … tous les  18,2  fois<
			          ; par  seconde  en  utilisant  la  cellule  m‚moire<
			          ; affect‚ par l'IRQ0 et des instructions CPU 80286.
 suGetRawTimer4Int1Ah equ 40h     ;>GetRawTimerPerInt1A:Long  cette fonction retourne<
			          ; l'horloge brute incr‚ment‚ … tous les  18,2  fois<
			          ; par seconde en utilisant l'interruption 1Ah
 suGetRawTimer4Cmos equ 41h       ;>GetRawTimerPerCmos:Long cette  fonction  retourne<
			          ; l'horloge brute incr‚ment‚ … tous les  18,2  fois<
			          ; par seconde en utilisant le RTC du CMOS.
 suGetRawTimerOpt1 equ 42h
 suGetRawTimerOpt2 equ 43h
  ; Technique de GetRawTimerByte: Nombre x, option 3
 suGetRawTimerB4Mem equ 44h       ;>GetRawTimerBytePerDefault:Byte   cette   fonction<
			          ; retourne le 1iŠre octet  de l'horloge  incr‚ment‚<
	    		          ; … tous les 18,2 fois  par  seconde  en  utilisant<
			          ; l'adressage m‚moire directe 0040h:006Ch.
 suGetRawTimerB4Memi286 equ 45h   ;>GetRawTimerBytePerDefault:Byte   cette   fonction<
			          ; retourne le 1iŠre octet  de l'horloge  incr‚ment‚<
			          ; … tous les 18,2 fois  par  seconde  en  utilisant<
			          ; l'adressage m‚moire directe 0040h:006Ch. Avec des<
			          ; instruction   de   CPU   80286  contrairement  au<
			          ; pr‚c‚dent.
 suGetRawTimerB4Int1Ah equ 46h    ;>GetRawTimerBytePerInter1Ah:Byte   cette  fonction<
			          ; retourne le 1iŠre octet  de  l'horloge incr‚ment‚<
			          ; … tous les 18,2 fois  par  seconde  en  utilisant<
			          ; l'interruption 1Ah.
 suGetRawTimerB4Dos equ 47h       ;>GetRawTimerBytePerDos:Byte     cette     fonction<
			          ; retourne le 1iŠre octet  de  l'horloge incr‚ment‚<
			          ; … tous les 18,2 fois  par  seconde  en  utilisant<
			          ; l'interruption 21h  (Dos).  A moins  que  le  CPU<
			          ; tourne dans les 100 Mhz,  ‚viter d'utiliser cette<
			          ; technique parcequ'un 33 en arrache alors imaginez<
			          ; un XT...69...(Fantasme)...69...tu marches dans le<
 			          ; mauvais sense ‚pais!  €a ne  se fait pas  avec un<
			          ; Ordi.
 suGetRawTimerBOpt1 equ 48h       ;>(Option1)  Cette entr‚e est bidon pour le moment,<
			          ; mais dans les futurs version du StartUp,  il sera<
			          ; … toute  fin pratique employ‚  pour  une  m‚thode<
 			          ; plus adapter au nouveau modŠle d'ordinateur.
 suGetRawTimerBOpt2 equ 49h       ;>(Option2) Mˆme objectif que le suGetRawTimerBOpt1.
 suGetRawTimerBOpt3 equ 4Ah       ;>(Option3) Mˆme objectif que le suGetRawTimerBOpt1.
  ; JoystickPosition
 suJoyPos4IO equ 4Bh              ;>JoystickPositionPerInputOuput(Axe:Byte):Word pour<
			          ; la m‚thode utilisant  les  ports  d'entr‚e/sortie<
			          ; 201h du contr“leur support‚ par  tous les anciens<
			          ; modŠle de PC.  Mais  y  eu un m‚chant scrach avec<
			          ; l'arriv‚e de Windows...
 suJoyPos4Bios equ 4Ch            ;>JoystickPositionPerBios(Axe:Byte):Word   pour  la<
			          ; m‚thode   de     compatibilit‚    du   d‚sespoir:<
			          ; Interruption 15h, Fonction 84h.
 suJoyPosOpt1 equ 4Dh             ;>(Option1)  Cette entr‚e est bidon pour le moment,<
			          ; mais dans les futurs version du StartUp,  il sera<
			          ; … toute  fin pratique employ‚  pour  une  m‚thode<
			          ; plus adapter au nouveau modŠle de manette de jeu.
 suJoyPosOpt2 equ 4Eh             ;>(Option2) Mˆme objectif que le suJoyPosOpt1.
 suJoyPosOpt3 equ 4Fh             ;>(Option3) Mˆme objectif que le suJoyPosOpt1.
 suJoyPosOpt4 equ 50h             ;>(Option4) Mˆme objectif que le suJoyPosOpt1.
 suJoyPosRet equ 51h              ; JoystickPositionReturn(Axe:Byte):Word   n'est  en<
			          ; faite qu'un simple retour de fonction pour ‚viter<
			          ; qu'un  appel  accidentel est  lieu  lorsqu'aucune<
			          ; manette de jeu n'existe.
  ; KeyPressed
 suKeyPress4IO equ 52h            ;>KeypressedPerInputOutput:Boolean  pour la m‚thode<
			          ; directe d'utilisation par le contr“leur d'entr‚e/<
			          ; sortie au port 0060h.
 suKeyPress4Mem equ 53h           ;>KeypressedPerMemory:Boolean  pour la m‚thode  par<
			          ; d‚faut utilisant les accŠs  au tampon m‚moire  en<
			          ; adresse 0040h:x.
 suKeyPress4MemNoCLI equ 54h      ;>KeypressedPerMemoryButNoClearedInterrupt: Boolean<
			          ; pour  la  m‚thode  utilisant  l'accŠs  au  tampon<
			          ; m‚moire en adresse 0040h:x sans protection contre<
			          ; les interruptions d'arriŠre plan,  id‚al pour les<
			          ; "playeur" de ".MOD".
 suKeyPress4Bios equ 55h          ;>KeypressedPerBios:Boolean   pour    la    m‚thode<
			          ; utilisant le Bios: Interruption 16h, Fonction 01h.
 suKeyPress4Dos equ 56h           ;>KeypressedPerDos:Boolean     pour   la    m‚thode<
			          ; utilisant le Dos: Interruption 21h, Fonction ??h.
 suKeyPressOpt1 equ 57h           ;>(Option1)  Cette entr‚e est bidon pour le moment,<
			          ; mais dans les futurs versions du StartUp, il sera<
			          ; utilis‚  fort  probablement   pour  une  nouvelle<
			          ; m‚thode de manipulation du clavier.
 suKeyPressOpt2 equ 58h           ;>(Option2) Mˆme objectif que le suKeyPressOpt1.
 suKeyPressOpt3 equ 59h           ;>(Option3) Mˆme objectif que le suKeyPressOpt1.
 suKeyPressRet equ 5Ah            ;>KeyPressedReturn:Boolean  n'est  en  faite  qu'un<
			          ; simple  retour  de  fonction  pour  ‚viter  qu'un<
			          ; appel  accidentel est lieu  lorsqu'aucun  clavier<
			          ; n'existe.
  ; LeftShiftPressd
 suLShiftPress4Mem equ 5Bh        ;>LShiftPressedPerMemory:Boolean  pour indiquer que la<
			          ; lecture  de l'‚tat  de la touche Alt  se fait par<
			          ; un m‚thode d'accŠs directe en m‚moire.
 suLShiftPress4Memi286 equ 5Ch    ;>GetLShiftPressedPerMemoryIntel80286:  Boolean   pour<
			          ; indiquer  que la lecture  de l'‚tat  de la touche<
			          ; Alt se fait  par un m‚thode  d'accŠs  directe  en<
			          ; m‚moire avec des instruction pour les CPU 80286.
 suLShiftPress4MemNoCLI equ 5Dh   ;>LShiftPressedPerMemoryNoCLI:Boolean pour indiquer<
			          ; que la lecture de l'‚tat de la touche Alt se fait<
			          ; par un m‚thode  d'accŠs  directe en m‚moire  sans<
			          ; tenir compte  des  interruptions  d'arriŠre  plan<
			          ; (IRQ).
 suLShiftPress4MemNoCLIi286 equ 5Eh;>LShiftPressedPerMemoryNoCLIi80286:Boolean   pour<
			           ; indiquer  que la lecture  de l'‚tat  de la touche<
			           ; Alt se fait  par un m‚thode  d'accŠs  directe  en<
			           ; m‚moire avec  des instruction  pour les CPU 80286<
			           ; sans  tenir  compte  des interruptions  d'arriŠre<
			           ; plan (IRQ).
 suLShiftPress4Bios equ 5Fh ;>GetLeftShiftPressedPerBios:Boolean     pour    la<
			    ; m‚thode utilisant  l'interruption  16h,  fonction<
			    ; 01h.
 suLShiftPressOpt1 equ 60h  ;>(Option1)  Cette entr‚e est bidon pour le moment,<
			    ; mais dans les futurs versions du StartUp, il sera<
			    ; utilis‚  fort  probablement   pour  une  nouvelle<
			    ; m‚thode de manipulation du clavier.
 suLShiftPressOpt2 equ 61h  ;>(Option2) Mˆme objectif que le suLShiftPressOpt1.
 suLShiftPressOpt3 equ 62h  ;>(Option3) Mˆme objectif que le suLShiftPressOpt1.
 suLShiftPressRet equ 63h   ;>GetLeftShiftPressedReturn:Boolean  n'est en faite<
			    ; qu'un simple retour de fonction pour ‚viter qu'un<
			    ; appelle accidentel est lieu lorsqu'aucun  clavier<
			    ; n'existe.
  ; MoveLeft
 suMove4Def equ 64h         ;>MoveLeftPerDefault(Var  Source, Dest; Count:Word)<
			    ; pour les 8088, 80188 et NEC V20.
 suMovePer86 equ 65h        ;>MoveLeftPer86(Var  Source, Dest;Count:Word)  pour<
			    ; les 8086, 80186, 80286 et NEC V30.
 suMovePer32Bits equ 66h    ;>MoveLeftPer32Bits(Var  Source, Dest;  Count:Word)<
			    ; pour les 80386, 80486,...
 suMoveOpt1 equ 67h         ;>(Option1)  Cette entr‚e est bidon pour le moment,<
			    ; mais dans les futurs versions du StartUp, il sera<
			    ; utilis‚  fort  probablement   pour  une  nouvelle<
			    ; m‚thode de MoveLeft.
 suMoveOpt2 equ 68h         ;>(Option2) Mˆme objectif que le suMoveOpt1.
 suMoveOpt3 equ 69h         ;>(Option3) Mˆme objectif que le suMoveOpt1.
  ; PushKey
 suPushKey4Mem equ 6Ah      ;>PushKeyPerMemory(Key:Word)   pour   ins‚rer   une<
			    ; touche  de  clavier directe  dans la  m‚moire  du<
			    ; tampon.  A utiliser  par  d‚faut.  Sur  tout  les<
			    ; anciens  modŠles  d'ordinateur   100%  compatible<
			    ; c'est la seule fa‡on d'ins‚rer  des  touches  car<
			    ; l'Interruption 15h, Fonction 4Fh.
 suPushKey4Bios15h equ 6Bh  ;>PushKeyPerBios15h(Key:Word)   pour  ins‚rer   une<
			    ; touche de clavier  dans le tampon en passant  par<
			    ; le Bios: Interruption 15h, Fonction 4Fh.
 suPushKey4Bios16h equ 6Ch  ;>PushKeyPerBios16h(Key:Word)   pour  ins‚rer   une<
			    ; touche de clavier  dans le tampon en passant  par<
			    ; le Bios: Interruption 16h, Fonction 05h.
 suPushKeyOpt1 equ 6Dh      ;>(Option1)  Cette entr‚e est bidon pour le moment,<
			    ; mais dans les futurs versions du StartUp, il sera<
			    ; utilis‚  fort  probablement   pour  une  nouvelle<
			    ; m‚thode de manipulation du clavier.
 suPushKeyOpt2 equ 6Eh      ;>(Option2) Mˆme objectif que le suPushKeyOpt1.
 suPushKeyOpt3 equ 6Fh      ;>(Option3) Mˆme objectif que le suPushKeyOpt1.
 suPushKeyRet equ 70h       ;>LeftShiftPressedReturn:Boolean   n'est  en  faite<
			    ; qu'un simple retour de fonction pour ‚viter qu'un<
			    ; appelle  accidentel est lieu lorsqu'aucun clavier<
			    ; n'existe.
  ; ReadKey
 suReadKey4IO equ 71h       ;>ReadKeyPerInputOutput:Word  pour extraire un code<
			    ; clavier  du  tampon clavier  en  passant  par  le<
			    ; contr“leur d'entr‚e/sortie … l'adresse 0060h.
 suReadKey4Mem equ 72h      ;>ReadKeyPerMemory:Word   pour   extraire  un  code<
			    ; clavier du tampon clavier en passant  directement<
			    ; par le tampon m‚moire 0040h:x.
 suReadKey4Bios00h equ 73h  ;>ReadKeyPerBiosFunction00h:Word  pour extraire  un<
			    ; code  clavier   du  tampon  clavier   en  passant<
			    ; par  la  fonction   00h  de  l'interruption  16h.<
			    ; Compatibilit‚ pour les anciens trŠs vieux modŠle.
 suReadKey4Bios10h equ 74h  ;>ReadKeyPerBiosFunction10h:Word  pour  extraire un<
			    ; code  clavier  du  tampon  clavier   en   passant<
			    ; par  la  fonction  10h   de  l'interruption  16h.<
			    ; Technique disponible  que  sur les  Bios  clavier<
			    ; ‚tendu.  Contrairement … la fonction  00h,  cette<
			    ; fonction lit ‚galement les F11, F12,...
 suReadKey4Dos equ 75h      ;>ReadKeyPerDos:Word  pour extraire un code clavier<
			    ; du  tampon  clavier   en  passant   par  le  Dos.<
			    ; Technique  critique  consernant la compatibilit‚.<
			    ; Ne doit ˆtre utilis‚ que dans les cas poussant au<
			    ; suicide ou … une alternative de celle-ci...!
 suReadKeyOpt1 equ 76h      ;>(Option1)  Cette entr‚e est bidon pour le moment,<
			    ; mais dans les futurs versions du StartUp, il sera<
			    ; utilis‚  fort  probablement   pour  une  nouvelle<
			    ; m‚thode de manipulation du clavier.
 suReadKeyOpt2 equ 77h      ;>(Option2) Mˆme objectif que le suReadKeyOpt1.
 suReadKeyProtect equ 78h   ;>(Option3) Version directe prot‚ger.
 suReadKeyRet equ 79h       ;>ReadKeyReturn:Word  n'est  en faite  qu'un simple<
			    ; retour  de  fonction   pour  ‚viter  qu'un  appel<
		            ; accidentel est lieu lorsqu'aucun clavier n'existe.
  ; RightShiftPress
 suRShiftPress4Mem equ 7Ah  ;>GetRightShiftPressedPerMemory:   Boolean     pour<
			    ; indiquer que la lecture  de l'‚tat  de la  touche<
			    ; Shift  de droite se fait  par un m‚thode  d'accŠs<
			    ; directe en m‚moire.
 suRShiftPress4Memi286 equ 7Bh
 suRShiftPress4MemNoCLI equ 7Ch
 suRShiftPress4MemNoCLIi286 equ 7Dh
 suRShiftPress4Bios equ 7Eh ;>GetRightShiftPressedPerBios:Boolean pour indiquer<
			    ; que la lecture de l'‚tat  de la touche  Shift  de<
			    ; droite   se  fait  par   l'intremise   du   Bios:<
			    ; Interruption 16h, Fonction 01h.
 suRShiftPressOpt1 equ 7Fh  ;>(Option1)  Cette entr‚e est bidon pour le moment,<
			    ; mais dans les futurs versions du StartUp, il sera<
			    ; utilis‚  fort  probablement   pour  une  nouvelle<
			    ; m‚thode de manipulation du clavier.
 suRShiftPressOpt2 equ 80h  ;>(Option2) Mˆme objectif que le suRShiftPressOpt1.
 suRShiftPressOpt3 equ 81h  ;>(Option3) Mˆme objectif que le suRShiftPressOpt1.
 suRShiftPressRet equ 82h   ;>RShiftPressReturn:Boolean n'est  en  faite  qu'un<
			    ; simple retour de fonction pour ‚viter qu'un appel<
			    ; accidentel est lieu lorsqu'aucun clavier n'existe.
  ; SetIntVec
 suSetIntVec4Mem equ 83h    ;>SetInterruptVectorPerMemory(InterruptNumber:Byte;
			    ; Vector:Pointer)
 suSetIntVec4Memi286 equ 84h
 suSetIntVec4Memi386 equ 85h
 suSetIntVec4Dos equ 86h    ;>SetInterruptVectorPerDos(InterruptNumber:Byte;
			    ; Vector:Pointer)
 suSetIntVecOpt1 equ 87h    ;>(Option1)  Cette entr‚e est bidon pour le moment,<
			    ; mais dans les futurs version du StartUp,  il sera<
			    ; sans doute utilis‚  pour une nouvelle m‚thode  de<
			    ; modification de vecteur d'interruption.
 suSetIntVecOpt2 equ 88h    ;>(Option2) Mˆme objectif que le suSetIntVecOpt1.
  ; ShiftPressed
 suShiftPress4Mem equ 89h   ;>GetShiftPressedPerMemory:Boolean   pour  indiquer<
			    ; que la lecture de l'‚tat  de l'une/les  touche(s)<
			    ; Shift se fait/font par un m‚thode d'accŠs directe<
			    ; en m‚moire.
 suShiftPress4Memi286 equ 8Ah
 suShiftPress4MemNoCLI equ 8Bh
 suShiftPress4MemNoCLIi286 equ 8Ch
 suShiftPress4Bios equ 8Dh  ;>GetShiftPressedPerBios:Boolean  pour indiquer que<
			    ; la lecture de l'‚tat de la touche Shift  se  fait<
			    ; par  l'intremise  du  Bios:   Interruption   16h,<
			    ; Fonction 01h.
 suShiftPressOpt1 equ 8Eh   ;>(Option1)  Cette entr‚e est bidon pour le moment,<
		            ; mais dans les futurs version du StartUp,  il sera<
			    ; sans doute utilis‚  pour une nouvelle m‚thode  de<
			    ; de d‚tection de l'enfoncement de la touche Shift.
 suShiftPressOpt2 equ 8Fh   ;>(Option2) Mˆme objectif que le suShiftPressOpt1.
 suShiftPressOpt3 equ 90h   ;>(Option3) Mˆme objectif que le suShiftPressOpt1.
 suShiftPressRet equ 91h    ;>ShiftPressReturn:Boolean  n'est  en  faite  qu'un<
			    ; simple retour de fonction pour ‚viter qu'un appel<
		 	    ; appel  accidentel  est lieu  lorsqu'aucun clavier<
			    ; n'existe.
ENDIF

;ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
;³                     D‚finition des types et structures                  Û
;ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ

NulDeviceRec STRUC
 ndNext DD ?        ; Pointer
 ndData DB 6 DUP(?) ; Array[4..9]of Byte
 ndName DB 8 DUP(?) ; Array[0..7]of Char
ENDS

Dos2 STRUC ; ExtDosBlock2Rec
 d2NmDrive             DB           ?
 d2MaxBytesBlockDevice DW           ?
 d2FirstDiskBuffer     DD           ? ; Pointer
 d2NulDevice           NulDeviceRec ?
ENDS

Dos3 STRUC ; ExtDosBlock3Rec
 d3NmBlockDevice              DB           ?
 d3MaxBytesBlockInBlockDevice DW           ?
 d3FirstDiskBuf               DD           ? ; Pointer
 d3CurrDir                    DD           ? ; PChar
 d3LastDrive                  DB           ?
 d3StringArea                 DD           ? ; Pointer
 d3FCB                        DD           ? ; ^FCBRec
 d3NmFCBS                     DW           ?
 d3NulDevice                  NulDeviceRec ?
ENDS

Dos31 STRUC ; ExtDosBlock31Rec
 d31MaxBytesPerSectorInBlockDevice DW           ?
 d31FirstDiskBuf                   DD           ? ; Pointer
 d31CurrDir                        DD           ? ; PChar
 d31FCB                            DD           ? ; ^FCBRec
 d31NmFCBS                         DW           ?
 d31NmBlockDevice                  DB           ?
 d31NmDrive                        DB           ?
 d31NulDevice                      NulDeviceRec ?
 d31NmJoinDrives                   DB           ?
ENDS

Dos4 STRUC ; ExtDosBlock4Rec
 d4MaxBytesPerSectorInBlockDevice DW           ?
 d4DiskBufInfo                    DD           ? ; Pointer
 d4CurrDir                        DD           ? ; PChar
 d4FCB                            DD           ? ; ^FCBRec
 d4NmFCBS                         DW           ?
 d4NmBlockDevice                  DB           ?
 d4LastDrive                      DB           ?
 d4NulDevice                      NulDeviceRec ?
 d4NmJoinDrives                   DB           ?
 d4ListPrgNameSeg                 DW           ?
 d4IFS                            DD           ? ; Procedure
 d4ChainIFS                       DD           ? ; ^ChainIFSRec;
 d4NmBufs                         DW           ?
 d4NumSubBufs                     DW           ?
 d4BootDisk                       DB           ?
 d4Is32BitsUpCode                 DB           ? ; Boolean: Supporte les instructions 32 bits?
 d4XmsSizeK                       DW           ? ; Quantit‚ de m‚moire XMS (en Ko)
ENDS

Dos5 STRUC  ; ExtDosBlock5Rec
 d5MaxBytesPerSectorInBlockDevice DW           ?
 d5DiskBufInfo                    DD           ? ; ^DiskBufInfoVer5Rec
 d5CurrDir                        DD           ? ; PChar
 d5FCB                            DD           ? ; ^FCBRec
 d5NmFCBS                         DW           ?
 d5NmBlockDevice                  DB           ?
 d5LastDrive                      DB           ?
 d5NulDevice                      NulDeviceRec ?
 d5NmJoinDrives                   DB           ?
 d5ListPrgNameSeg                 DW           ?
 d5SetVerListPrg                  DD           ? ; Pointer: Liste des versions pour le programme SETVER.EXE
 d5CsDosFunc                      DW           ?
 d5IsDosInHma                     DW           ?
 d5NmBufs                         DW           ?
 d5NmSubBufs                      DW           ?
 d5BootDisk                       DB           ?
 d5Is32BitsUpCode                 DB           ? ; Boolean: Supporte les instructions 32 bits?
 d5XmsSizeK                       DW           ? ; Word: Quantit‚ de m‚moire XMS (en Ko)
ENDS

DosBlockRec STRUC
 FirstMCB         DD ?   ; ^MCBRec
 FirstDriveParm   DD ?   ; ^DriveParamBlockRec
 SystemFileTables DD ?   ; ^SystemFileTablesRec
 Clock            DD ?   ; ^ClockRec: Device pilote d'horloge: $CLOCK
 Con              DD ?   ; ^FCBRec: Device pilote de console: $CON
 Ver              DB ?   ; Enregistrement multiple:
                         ;  Record Case Byte of
                         ;   0:(Dos2:ExtDosBlock2Rec);
                         ;   1:(Dos30:ExtDosBlock3Rec);
                         ;   2:(Dos31:ExtDosBlock31Rec);
                         ;   3:(Dos4:ExtDosBlock4Rec);
                         ;   4:(Dos5:ExtDosBlock5Rec);
                         ;  End;
ENDS

; ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
;                Structure de pays utilisable avec un DOS 3.0+
; ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

CountryRec STRUC
 cd3Date      DW ?           ; Format de la date mdy, dmy,...
 cd3Curr      DB 5 DUP (?)   ; Array[0..4]of Char: Symbole de la monnaie
 cd3ThSep     DW ?           ; Array[0..1]of Char: Code ASCII du s‚parateur de millier
 cd3DeSep     DW ?           ; Array[0..1]of Char: Code ASCII du symbole de d‚cimal
 cd3DtSep     DW ?           ; Array[0..1]of Char: Code ASCII du s‚parateur dans la date
 cd3TmSep     DW ?           ; Array[0..1]of Char: Code ASCII du s‚parateur de l'heure
 cd3CurrStyle DB ?           ; Format de la monnaie
 cd3Digits    DB ?           ; Format de la monnaie, pr‚cision d‚cimal
 cd3Time      DB ?           ; TimeType: Format de l'heure: AM/PM (12h), Militaire 24h
 cd3CaseUp    DD ?           ; Pointer: Adresse d'une routine de conversion en majuscule
 cd3DaSep     DW ?           ; Array[0..1]of Char: S‚parateur de liste de donn‚e
 cd3Fill      DB 11 DUP(?)   ; Array[0..10]of Byte: R‚serv‚s
ENDS

; ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
;                       Structure des "Jumpers" du StartUp
; ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

Jumper STRUC
 FlgMethod DW ?
ENDS

; ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
;                              Structure de StartUp
; ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

StartUpRec STRUC
 ; Info sur le Micro-Processeur et son bus systŠme
 CPU           DB ? ; ModŠle de CPU
 Up32Bits      DB ? ; Boolean: Support les instructions 32 bits?
 CPUIDSupport  DB ? ; Boolean: Support l'instruction CPUID?
 CPUVendor     DB ? ; Byte: Fabricant du CPU?
 Bus           DB ? ; Taille du Bus de donn‚e
 ; Info sur le modŠle d'Ordinateur
 ComputerName  DW ?
 PS2           DB ? ; Est-ce un PS/2 d'IBM?
 ; Info sur les Interruptions
 IntExistFlags DW ?
 ;Information sur le DOS
 GetDosVer     DW ?
 GetDosBlock   DD ? ; DosBlockPtr
 HandleExist   DB ? ; Boolean: Est-ce que les Handles existent?
 ;Information sur OS/2 et Windows
 OS2           DB ? ; Boolean
 OS2HiVer      DB ? ; Version OS/2
 OS2LoVer      DB ? ; Sous-version OS/2
 Win           DB ? ; Mode de fonctionnement de Windows
 WinLoVer      DB ? ; Sous-version Windows
 WinHiVer      DB ? ; Version Windows
 ;Information de pays
 CountryCode   DW ?
 CodePage      DW ?
 Date          DW ?        ; Format de la date
 Curr          DB 5 DUP(?) ; Array[0..4]of Chr
 ThSep         DW ?        ; Array[0..1]of Chr
 DeSep         DW ?        ; Array[0..1]of Chr
 DtSep         DW ?        ; Array[0..1]of Chr
 TmSep         DW ?        ; Array[0..1]of Chr
 CurrStyle     DB ?
 Digits        DB ?
 Time          DB ?        ; TimeType
 CaseUp        DD ?        ; Pointer
 DaSep         DW ?        ; Array[0..1]of Chr
 ;Information sur le(s) lecteur(s) de disquette
 FloppyDskExist DB ? ; Boolean
 NmFloppyDsk    DB ?
 ;Info sur le(s) disque(s) dur
 HardDskExist   DB ? ; Boolean
 NmHardDsk      DB ?
 HardDskCtrl    DW ? ; ModŠle de contr“leur de disque dur
  ; Information r‚seau
 IsNovell       DB ? ; Boolean: R‚seau Novell pr‚sent
 ; Spooler d'imprimante
 Spooler        DB ?
 ;Information sur la manette de jeu
 JoyExist         DB ?
 BiosJoy          DB ?
 JoyPort          DW ?
 JoyPotentioMeter DW ?
 ;Information sur le clavier
 KbdModel         DB ?
 KbdCtrl          DB ?
 KbdReadPort      DW ?
 BiosKbdEnh       DB ?
 ;Information sur le port parallŠle
 LPTExist         DB ? ; Boolean
 NmLPT            DB ?
 Get1LPT          DB ?
 ;Information sur le port s‚rie
 ComExist         DB ? ; Boolean
 NmCom            DB ?
 ;Information sur la m‚moire conventionnel
 MemTotalSize     DW ?
 ;Information sur l''Expanded Memory Manager (EMS)
 EmmExist         DB ? ; Boolean
 EmmSeg           DW ?
 EmmTotalSize     DW ?
 ;Information sur l''eXtended Memory Manager (XMS)
 XmmExist         DB ? ; Boolean
 XmmCtrl          DD ? ; Pointer
 XmsTotalSize     DW ?
 ;Information sur la m‚moire ‚tendu g‚r‚ par le Bios Int 15h
 ExtBiosExist     DB ? ; Boolean
 ExtBiosSizeK     DW ?
 ;Information sur le CMOS
 CtrlCmos         DB ?
 CmosPort         DW ?
 ;Information sur la souris
 Mouse            DB ?
 MouseVer         DW ?
 MsButton         DW ?
 ; Index de proc‚dures ou fonctions … r‚f‚rence ressource RLL
 indAltPress      DB ? ; AltPressed
 indCtrlPress     DB ? ; CtrlPressed
 indFillChr       DB ? ; FillByte/FillCharacter
 indGetIntVec     DB ? ; GetInterruptVector
 indGetRawTimer   DB ? ; GetRawTimer
 indGetRawTimerB  DB ? ; GetRawTimerInByte
 indJoyPos        DB ? ; JoystickPosition
 indKeyPress      DB ? ; KeyPressed
 indLShiftPress   DB ? ; LeftShiftPressed
 indMove          DB ? ; Move/MoveLeft
 indPushKey       DB ? ; PushKey
 indReadKey       DB ? ; ReadKey
 indRShiftPress   DB ? ; RightShiftPressed
 indSetIntVec     DB ? ; SetInterruptVector
 indShiftPress    DB ? ; ShiftPressed
ENDS

; ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
;                    Structure du ®Mode Information Video¯
; ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
MIV STRUC
 Mode          DW ? ;Mode vid‚o actuel (vm???)
 IbmLogic      DB ? ;Mode dans la logique IBM (pas hors cas texte … la SVGA...)
 BiosSupport   DB ? ;Mode support‚ par le Bios (Par exemple, la GS en 16 couleurs le Bios ne le connaŒt pas)
 Colr          DB ? ;Mode couleur? Sinon monochrome for‡‚ment...
 Graf          DB ? ;Mode graphique? Sinon texte
 Direct        DB ? ;M‚thode directe? Sinon Bios ou Dos
 Blink         DB ? ;Clignotement?
 Snow          DB ? ;Neige lors de l'envoie de donn‚e dans le tampon vid‚o?
 SegV          DW ? ;Segment vid‚o (A000h, B000h, B800h,...)
 _HeightChr    DB ? ;Hauteur de la police de caractŠre actuel
 _NmXPixels    DW ? ;Nombre de pixels horizontal qu'affiche l'‚cran
 _NmYPixels    DW ? ;Nombre de pixels vertical qu'affiche l'‚cran
 _NmXTxts      DB ? ;Nombre de caractŠre texte horizontal qu'affiche l'‚cran
 _NmYTxts      DB ? ;Nombre de caractŠre texte vertical qu'affiche l'‚cran
 NmVidPgs      DB ? ;Nombre de page vid‚o que supporte le mode actuel
 NmColrs       DD ? ;Nombre de couleurs affich‚
 _BitsPerPixel DB ? ;Nombre de Bit(s) utilis‚ pour l'affichage d'un pixel
 _BytesPerLn   DW ? ;Nombre d'octet par ligne affich‚ (trŠs relatif en VGA...)
 Pg            DB ? ;Num‚ro de la page vid‚o de travail
 AddrPg        DW ? ;En texte, adresse en m‚moire vid‚o de la page actuel
 ShowPg        DB ? ;Num‚ro de la page vid‚o actuellement affich‚
 TxtMtx        DD ? ;Pointeur sur la police de caractŠre courante
 ScrSize       DD ? ;Taille de l'‚cran
 SizeBnk       DW ? ;Taille d'un page de la banque (0 equ 64 Ko)
 SegBuf        DW ? ;Segment du tampon d'acc‚l‚ration
 _IsDblMtx     DB ? ;Y a-t-il une police de 512 caractŠres?
 XCurPos       DB ? ; Position du curseur horizontal
 YCurPos       DB ? ; Position du curseur vertical
 StartCur4mat  DB ? ; Position de d‚part du curseur
 StopCur4mat   DB ? ; Position de fin du curseur
ENDS

; ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
;             Structure d'information de la carte vid‚o PC 3270
; ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
PC3270Info STRUC
 AspectRatioX DB ?           ; L'aspect ratio horizontal
 AspectRatioY DB ?           ; L'aspect ratio vertical
 MonitorType  DB ?           ; Genre de moniteur branch‚ … la carte
 Reserved1    DB ?           ; Inutilis‚
 AdapterID    DB ?           ; Identificateur d'adapateur
 Reserved2    DB ?           ; Inutilis‚
 Flags1       DB ?           ; Drapeau de donn‚e primaire
 Flags2       DB ?           ; Drapeau de donn‚e secondaire
 SegCPLT      DW ?           ; Segment CPLT
 Reserved3    DB 10 DUP (?)  ; Inutilis‚
ENDS

; ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
;                 Structure du ®Physical Information Video¯
; ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
PIV STRUC
 Card             DB ? ; Nom de la carte vid‚o (vn????)
 Monitor          DB ? ; Nom du moniteur (mn????)
 CardCat          DB ? ; Cat‚gorie de la carte vid‚o(MDA,CGA,...)(cvn????)
 Memory           DD ? ; Nombre de m‚moire (en octet) dont dispose la carte vid‚o
 Font             DB ? ; Police programme support‚ par cette carte?
 Hercule          DB ? ; Mode Hercule support‚ par cette carte?
 Seg16C           DW ? ; Segment par d‚faut en 16 couleurs
 Palette          DB ? ; Palette de couleur programme support‚?
 Color            DB ? ; Carte de type couleur? autrement monochrome
 BBlink           DB ? ; Le Bios supporte le mode clignotement/intensit‚?
 EGA              DB ? ; La carte est post‚rieur ou ‚gale … l'EGA
 VGA              DB ? ; La carte est post‚rieur ou ‚gale … la VGA
 VGA320x400       DB ? ; Le mode VGA 320x400 est support‚ (pas toujours le cas chez les clones)
 VESA             DB ? ; Le standard VESA support‚?
 ROM              DW ? ; Adresse de la ROM Bios
 MousePort        DB ? ; Port souris inclue … la carte vid‚o?
 VideoBits        DB ? ; Nombre d'accŠs bits au entr‚e/sortie vid‚o
 ROMBits          DB ? ; Nombre d'accŠs bits … la ROM Bios
 DACBits          DB ? ; Nombre de bits utilis‚ pour modifi‚ un des 3 DAC RGB
 PVC              DB ? ; Horloge vid‚o programme?
 ProcSelBnkPg     DW ? ; Adresse d'index de la proc‚dure de changement de page de la banque
 ProcSetVideoMode DW ? ; Adresse d'index de la proc‚dure de changement de mode vid‚o
PIV ENDS

; ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
;              Structure d'information de la norme vid‚o VESA
; ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
VesaHeaderInfo STRUC
 Sign         DB 4 DUP (?)   ; Signature du pilote ®VESA¯
 VesaVer      DW ?           ; Version du pilote VESA
 OEMname      DD ?           ; Nom de l'OEM (exemple:"761295520"pour ATI)
 Capabilities DB 4 DUP (?)   ; Octet de compatibilit‚?
 Modes        DD ?           ; Pointeur de la table des modes vid‚o support‚.
 NmBnk64K     DW ?           ; Nombre de banque de m‚moire en 64 Ko
 Reserved     DB 236 DUP (?) ; R‚serv‚ pour un usage futur...
ENDS

; ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
;       Matrice standard pour les attributs des couleurs de la fenˆtre
; ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
MtxColors STRUC
 mcTitle DB ?
 Border  DB ?
 Icon    DB ?
 Sel     DB ?
 MCHigh  DB ?
 Key     DB ?
 kShade  DB ?
 kSel    DB ?
ENDS

; ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
;                           Structure d'une ressource
; ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

XInf STRUC
 Output DB ?          ; Sp‚cification de la ressource
 Handle DW ?          ; Handle dans la ressource
 XISize DD ?          ; Taille du tampon
ENDS

; ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
;                    Structure d'un tampon d'image graphique
; ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

ImgRec STRUC
 irX            XInf ?  ; Tampon de sauvegarde de l'image
; IFB Graf
 irBitsPerPixel DB ?    ; Nombre de bits par pixel dans l'image
; ENDIF
 irLength       DW ?    ; Largeur de l'image en pixel
 Height         DW ?    ; Hauteur de l'image en pixel
ENDS

; ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
;                  Structure du ®Fenˆtre de dialogue¯
; ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
Wins STRUC
 wX            DB ?           ; Position courante du pointeur texte horizontal
 wY            DB ?           ; Position courante du pointeur texte vertical
 Kr            DB ?           ; Couleur courante
 X1            DB ?           ; Coordonn‚e gauche de la fenˆtre
 Y1            DB ?           ; Coordonn‚e sup‚rieur de la fenˆtre
 X2            DB ?           ; Coordonn‚e droite de la fenˆtre
 Y2            DB ?           ; Coordonn‚e inf‚rieur de la fenˆtre
 MaxX          DB ?           ; Coordonn‚e maximal X
 MaxY          DB ?           ; Coordonn‚e maximal Y
 XColrs        MtxColors ?    ; Matrice d'attribut de couleur par d‚faut pour la fenˆtre
 weTitle       DB 100 DUP (?) ; Titre de la fenˆtre
 NotFullScrnX  DB ?           ; Image plaine ‚cran horizontal?
 NotFullScrnY  DB ?           ; Image plaine ‚cran vertical?
; IFB MaxGraf
;  Matrix      MatrixType ?   ; Type de police utilis‚
; ENDIF
 ClsIcon       DB ?           ; Icon de fermeture affich‚?
 BarMouseRight DB ?           ; Bar de d‚placement … droite affich‚?
 Shade         DB ?           ; Ombrage actif?
 Buf           DD ?           ; Tampon utilis‚ pour la sauvegarde de l'arriŠre de la fenˆtre
 SizeBuf       DW ?           ; Taille du tampon de l'arriŠre de la fenˆtre
 Img           ImgRec ?       ; Tampon utilis‚ pour la sauvegarder en graphique
 InpColr1      DB ?           ; Couleur par d‚faut du prompt de question
 InpColr2      DB ?           ; Couleur par d‚faut du prompt de question
 OX            DB ?           ; Ancienne position X, utilis‚ pour certain terminal dont ANSI
 OY            DB ?           ; Ancienne position Y, utilis‚ pour certain terminal dont ANSI
 PauseLn       DB ?           ; Mode pause aprŠs l'emplisage de la fenˆtre actif
 Lns           DB ?           ; Nombre de ligne de remplissage (compl‚ment de Pause)
ENDS
