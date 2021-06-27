{Unit Support;

INTERFACE}

Uses Systex,Systems;

Procedure ChkModeSupport(Info1,Info2:PIV;Var Buf1,Buf2:PaletteMode);

{IMPLEMENTATION

Procedure ChkModeSupport;}Var I,J:Byte;M:Word;VesaHeader:VesaHeaderInfo;PtrVesa:Pointer;Begin
 PtrVesa:=@VesaHeader;
 If Not(Info1.VGA)Then Begin
  Info1.VGA:=(Info1.Card=vnAhead)or
	     (Info1.Card=vnAheadB)or
	     (Info1.Card=vnAheadBWizard3270)or
	     (Info1.Card=vnAllstarPeacock)or
	     (Info1.Card=vnASTVGAPlus)or
	     (Info1.Card=vnATTVDC600)or
	     (Info1.Card=vnCardinal)or
	     (Info1.Card=vnCirrus)or
	     (Info1.Card=vnCompaqVGA)or
	     (Info1.Card=vnCTI82C451)or
	     (Info1.Card=vnCTI82C452)or
	     (Info1.Card=vnDellVGA)or
	     (Info1.Card=vnEverex)or
	     (Info1.Card=vnEverexViewPoint)or
	     (Info1.Card=vnEverexUG2)or
	     (Info1.Card=vnEverexVision)or
	     (Info1.Card=vnEverexEVGA)or
	     (Info1.Card=vnGenoa)or
	     (Info1.Card=vnGenoa5100)or
	     (Info1.Card=vnGenoa5300)or
	     (Info1.Card=vnGenoa6100)or
	     (Info1.Card=vnGenoa6200)or
	     (Info1.Card=vnGenoa6400)or
	     (Info1.Card=vnGU)or
	     (Info1.Card=vnGUPlus)or
	     (Info1.Card=vnGUPro)or
	     (Info1.Card=vnHeadLand)or
	     (Info1.Card=vnHPD1180A)or
	     (Info1.Card=vnIBM8514A)or
	     (Info1.Card=vnImtec)or
	     (Info1.Card=vnITVGA2)or
	     (Info1.Card=vnLogix)or
	     (Info1.Card=vnMaxxon)or
	     (Info1.Card=vnMorseVGA)or
	     (Info1.Card=vnOak)or
	     (Info1.Card=vnOrchid)or
	     (Info1.Card=vnOrchidProDesVGA)or
	     (Info1.Card=vnOrchidProDesIIVGA)or
	     (Info1.Card=vnParadise)or
	     (Info1.Card=vnParadisePVGA1A)or
	     (Info1.Card=vnParadiseWD90C00)or
	     (Info1.Card=vnParadiseWD90C10)or
	     (Info1.Card=vnParadiseWD90C11)or
	     (Info1.Card=vnPrismElite)or
	     (Info1.Card=vnQU)or
	     (Info1.Card=vnSEFCOTVGA)or
	     (Info1.Card=vnSigma)or
	     (Info1.Card=vnSTB)or
	     (Info1.Card=vnSTBVGAEM16Plus)or
	     (Info1.Card=vnTatungVGA)or
	     (Info1.Card=vnTecmarVGAAD)or
	     (Info1.Card=vnTIGA)or
	     (Info1.Card=vnTrident8800BR)or
	     (Info1.Card=vnTrident8800CS)or
	     (Info1.Card=vnTrident8900)or
	     (Info1.Card=vnT3000)or
	     (Info1.Card=vnT4000)or
	     (Info1.Card=vnT4000HiColor)or
	     (Info1.Card=vnT4000HiColorSC)or
	     (Info1.Card=vnVESA)or
	     (Info1.Card=vnVGA)or
	     (Info1.Card=vnVGAW)or
	     (Info1.Card=vnVGAW18800)or
	     (Info1.Card=vnVGAW18800_1)or
	     (Info1.Card=vnVGAW28800_2)or
	     (Info1.Card=vnVGAW28800_4)or
	     (Info1.Card=vnVGAW28800_5)or
	     (Info1.Card=vnV7)or
	     (Info1.Card=vnV7Vram)or
	     (Info1.Card=vnV7Vega)or
	     (Info1.Card=vnV7Ver5)or
	     (Info1.Card=vnV71024i)or
	     (Info1.Card=vnVIP)or
	     (Info1.Card=vnXGA)or
	     (Info1.Card=vnZymos)or
	     (Info1.Card=vnZymosPoach);
  If(Info1.VGA)Then Info1.VGA320x400:=Ya
 End;
 ASM
  CLD
  LES DI,Buf1
  MOV CX,80
  MOV AX,vmNone
  REP STOSW
 END;
 If(Info1.Card=vnMCGA)Then ASM
  LES DI,Buf1
  CLD
  MOV AX,vmTxtBW40
  STOSW
  MOV AX,vmTxtC40
  STOSW
  MOV AX,vmTxtC40x28
  STOSW
  MOV AX,vmTxtC40x43
  STOSW
  MOV AX,vmTxtC40x50
  STOSW
  MOV AX,vmTxtBW80
  STOSW
  MOV AX,vmTxtC80
  STOSW
  MOV AX,vmTxtC80x28
  STOSW
  MOV AX,vmTxtC80x43
  STOSW
  MOV AX,vmTxtC80x50
  STOSW
  MOV AX,vmGrf640x200c2
  STOSW
  MOV AX,vmGrf640x480c2
  STOSW
  MOV AX,vmGrf320x200c4
  STOSW
  MOV AX,vmGrf320x200c256
  STOSW
 END
  Else
 If(Info1.VGA)Then Begin
  ASM
   LES DI,Buf1
   CLD
   MOV AX,vmTxtBW40
   STOSW
   MOV AX,vmTxtC40
   STOSW
   MOV AX,vmTxtC40x28
   STOSW
   MOV AX,vmTxtC40x43
   STOSW
   MOV AX,vmTxtC40x50
   STOSW
   MOV AX,vmTxtBW80
   STOSW
   MOV AX,vmTxtC80
   STOSW
   MOV AX,vmTxtC80x28
   STOSW
   MOV AX,vmTxtC80x43
   STOSW
   MOV AX,vmTxtC80x50
   STOSW
   MOV AX,vmTxtMono
   STOSW
   MOV AX,vmTxtMono80x28
   STOSW
   MOV AX,vmTxtMono80x43
   STOSW
   MOV AX,vmTxtMono80x50
   STOSW
   MOV AX,vmGrf640x200c2
   STOSW
   MOV AX,vmGrf640x480c2
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
   MOV AX,vmGrf640x480c16
   STOSW
   MOV AX,vmGrf320x200c256
   STOSW
  END;
  If(Info1.VGA320x400)Then Begin
   Buf1[23]:=vmGrf320x400c256;
   Buf1[24]:=vmGrf360x480c256;
   Case(Info1.Card)of
    vnAheadB,vnAheadBWizard3270:ASM
     LES DI,Buf1
     CLD
     ADD DI,25*2
     MOV AX,vmTxtC132x28
     STOSW
     MOV AX,vmTxtC132x44
     STOSW
     MOV AX,vmGrf720x392c16
     STOSW
     MOV AX,vmGrf1024x768c2
     STOSW
     MOV AX,vmGrf1024x768c4
     STOSW
     MOV AX,vmGrf1024x768c16
     STOSW
     MOV AX,vmGrf640x400c256
     STOSW
     MOV AX,vmGrf640x480c256
     STOSW
     MOV AX,vmGrf800x600c256
     STOSW
     MOV AX,vmGrf1024x768c256
     STOSW
     CMP Info1.Card,vnAheadBWizard3270
     JNE @@NoAheadBWizard3270
     MOV AX,vmTxtC160x50
     STOSW
     MOV AX,vmTxtC80x34
     STOSW
     MOV AX,vmTxtC80x66
     STOSW
     CMP Info1.Vesa,Ya
     JE  @@NoAheadVesa
     MOV AX,vmGrf800x600c16
     STOSW
    @@NoAheadVesa:
     JMP @@End
    @@NoAheadBWizard3270:
     CMP Info1.Vesa,Ya
     JNE @@End
     MOV AX,vmGrf800x600c16
     STOSW
    @@End:
    END;
    vnAllStarPeacock:ASM
     LES DI,Buf1
     CLD
     ADD DI,25*2
     MOV AX,vmTxtC80x60
     STOSW
     MOV AX,vmTxtC100x40
     STOSW
     MOV AX,vmTxtC132
     STOSW
     MOV AX,vmTxtC132x28
     STOSW
     MOV AX,vmTxtC132x43
     STOSW
     MOV AX,vmGrf800x600c16
     STOSW
    END;
    vnASTVGAPlus:ASM
     LES DI,Buf1
     CLD
     ADD DI,25*2
     MOV AX,vmTxtC132
     STOSW
     MOV AX,vmTxtC132x43
     STOSW
     MOV AX,vmGrf640x400c256
     STOSW
     MOV AX,vmGrf640x480c256
     STOSW
    END;
    vnATTVDC600:ASM
     LES DI,Buf1
     CLD
     ADD DI,25*2
     MOV AX,vmTxtC132
     STOSW
     MOV AX,vmTxtC132x43
     STOSW
     MOV AX,vmGrf640x400c2
     STOSW
     MOV AX,vmGrf640x400c16
     STOSW
     MOV AX,vmGrf800x600c2
     STOSW
     MOV AX,vmGrf800x600c16
     STOSW
     MOV AX,vmGrf640x400c256
     STOSW
     MOV AX,vmGrf640x480c256
     STOSW
    END;
    vnCardinal:ASM
     LES DI,Buf1
     CLD
     ADD DI,25*2
     MOV AX,vmGrf640x400c256
     STOSW
     MOV AX,vmGrf640x480c256
     STOSW
     MOV AX,vmGrf720x540c256
     STOSW
     MOV AX,vmGrf800x600c16
     STOSW
     MOV AX,vmGrf800x600c256
     STOSW
     MOV AX,vmGrf960x720c16
     STOSW
     MOV AX,vmGrf1024x768c16
     STOSW
     MOV AX,vmGrf320x200c32768
     STOSW
     MOV AX,vmGrf640x350c32768
     STOSW
     MOV AX,vmGrf640x400c32768
     STOSW
     MOV AX,vmGrf640x480c32768
     STOSW
     MOV AX,vmGrf800x600c32768
     STOSW
    END;
    vnEverex,vnEverexViewPoint,vnEverexUG2,vnEverexVision,vnEverexEVGA:ASM
     LES DI,Buf1
     CLD
     ADD DI,25*2
     MOV AX,vmTxtMono132
     STOSW
     MOV AX,vmTxtMono132x44
     STOSW
     MOV AX,vmTxtC80x60
     STOSW
     MOV AX,vmTxtC132
     STOSW
     MOV AX,vmTxtC132x44
     STOSW
     MOV AX,vmGrf320x200c32768
     STOSW
     MOV AX,vmGrf640x350c32768
     STOSW
     MOV AX,vmGrf640x400c32768
     STOSW
     MOV AX,vmGrf640x480c32768
     STOSW
     MOV AX,vmGrf800x600c32768
     STOSW
    END;
    vnGenoa,vnGenoa5100,vnGenoa5300,vnGenoa6100,vnGenoa6200,vnGenoa6400:ASM
     LES DI,Buf1
     CLD
     ADD DI,25*2
     MOV AX,vmGrf720x512c16
     STOSW
     MOV AX,vmGrf800x600c16
     STOSW
     MOV AX,vmGrf720x512c256
     STOSW
     MOV AX,vmGrf800x600c256
     STOSW
     MOV AX,vmGrf1024x768c16
     STOSW
     MOV AX,vmGrf512x512c16
     STOSW
     MOV AX,vmGrf512x512c256
     STOSW
    END;
    vnHPD1180A:ASM
     LES DI,Buf1
     CLD
     ADD DI,25*2
     MOV AX,vmTxtC132
     STOSW
     MOV AX,vmTxtC132x44
     STOSW
     MOV AX,vmGrf800x600c2
     STOSW
     MOV AX,vmGrf800x600c16
     STOSW
     MOV AX,vmGrf640x480c256
     STOSW
    END;
    vnMorseVGA:ASM
     LES DI,Buf1
     CLD
     ADD DI,25*2
     MOV AX,vmTxtC80x60
     STOSW
     MOV AX,vmTxtC100x30
     STOSW
     MOV AX,vmTxtC100x50
     STOSW
     MOV AX,vmTxtC100x60
     STOSW
     MOV AX,vmTxtC100x75
     STOSW
     MOV AX,vmTxtC132x30
     STOSW
     MOV AX,vmTxtC132x50
     STOSW
     MOV AX,vmTxtC132x60
     STOSW
     MOV AX,vmGrf720x540c16
     STOSW
     MOV AX,vmGrf800x600c16
     STOSW
    END;
    vnOak:ASM
     LES DI,Buf1
     CLD
     ADD DI,25*2
     MOV AX,vmTxtC132
     STOSW
     MOV AX,vmTxtC132x43
     STOSW
     MOV AX,vmGrf800x600c16
     STOSW
    END;
    vnOrchid:ASM
     LES DI,Buf1
     CLD
     ADD DI,25*2
     MOV AX,vmGrf640x480c256
     STOSW
     MOV AX,vmGrf800x600c16
     STOSW
     MOV AX,vmGrf800x600c256
     STOSW
     MOV AX,vmGrf1024x768c16
     STOSW
    END;
    vnOrchidProDesVGA,vnOrchidProDesIIVGA:ASM
     LES DI,Buf1
     CLD
     ADD DI,25*2
     MOV AX,vmTxtC80x60
     STOSW
     MOV AX,vmTxtC100x40
     STOSW
     MOV AX,vmTxtC132
     STOSW
     MOV AX,vmTxtC132x28
     STOSW
     MOV AX,vmTxtC132x44
     STOSW
     CMP Info1.Card,vnOrchidProDesIIVGA
     JNE @Skip
     MOV AX,vmGrf320x200c32768
     STOSW
     MOV AX,vmGrf640x350c32768
     STOSW
     MOV AX,vmGrf640x400c32768
     STOSW
     MOV AX,vmGrf640x480c32768
     STOSW
     MOV AX,vmGrf800x600c32768
     STOSW
@Skip:
    END;
    vnParadisePVGA1A,vnParadiseWD90C00,vnParadiseWD90C10,vnParadiseWD90C11,vnParadise:ASM
     LES DI,Buf1
     CLD
     ADD DI,25*2
     MOV AX,vmTxtC132
     STOSW
     MOV AX,vmTxtC132x43
     STOSW
     MOV AX,vmGrf800x600c2
     STOSW
     MOV AX,vmGrf800x600c16
     STOSW
     MOV AX,vmGrf640x400c256
     STOSW
     MOV AX,vmGrf640x480c256
     STOSW
    END;
    vnSigma:ASM
     LES DI,Buf1
     CLD
     ADD DI,25*2
     MOV AX,vmGrf800x600c16
     STOSW
     MOV AX,vmGrf800x600c256
     STOSW
     MOV AX,vmGrf1024x768c16
     STOSW
    END;
    vnSTB:ASM
     LES DI,Buf1
     CLD
     ADD DI,25*2
     MOV AX,vmGrf640x480c256
     STOSW
     MOV AX,vmGrf800x600c16
     STOSW
     MOV AX,vmGrf800x600c256
     STOSW
     MOV AX,vmGrf960x720c16
     STOSW
     MOV AX,vmGrf1024x768c16
     STOSW
    END;
    vnSTBVGAEM16Plus: Buf1[24]:=vmGrf1024x768c256;
    vnTatungVGA:ASM
     LES DI,Buf1
     CLD
     ADD DI,25*2
     MOV AX,vmTxtC80x43
     STOSW
     MOV AX,vmTxtC80x60
     STOSW
     MOV AX,vmTxtC100x60
     STOSW
     MOV AX,vmTxtC132
     STOSW
     MOV AX,vmTxtC132x28
     STOSW
     MOV AX,vmTxtC132x43
     STOSW
     MOV AX,vmGrf752x410c16
     STOSW
     MOV AX,vmGrf800x600c16
     STOSW
     MOV AX,vmGrf640x400c256
     STOSW
    END;
    vnTecmarVGAAD:ASM
     LES DI,Buf1
     CLD
     ADD DI,25*2
     MOV AX,vmTxtC80x43
     STOSW
     MOV AX,vmTxtC132
     STOSW
     MOV AX,vmGrf640x350c256
     STOSW
     MOV AX,vmGrf640x400c256
     STOSW
     MOV AX,vmGrf640x480c256
     STOSW
     MOV AX,vmGrf800x600c256
     STOSW
    END;
    vnTrident8800BR,vnTrident8800CS,vnTrident8900:ASM
     LES DI,Buf1
     CLD
     ADD DI,25*2
     MOV AX,vmTxtC80x30
     STOSW
     MOV AX,vmTxtC80x60
     STOSW
     MOV AX,vmTxtC132
     STOSW
     MOV AX,vmTxtC132x30
     STOSW
     MOV AX,vmTxtC132x43
     STOSW
     MOV AX,vmTxtC132x60
     STOSW
     MOV AX,vmGrf800x600c16
     STOSW
     MOV AX,vmGrf640x400c256
     STOSW
     MOV AX,vmGrf640x480c256
     STOSW
     MOV AX,vmGrf1024x768c16
     STOSW
     MOV AX,vmGrf768x1024c16
     STOSW
     CMP Info1.Card,vnTrident8900
     JNE @Not8900
     MOV AX,vmGrf800x600c256
     STOSW
     MOV AX,vmGrf1024x768c4
     STOSW
     MOV AX,vmGrf1024x768c256
     STOSW
@Not8900:
    END;
    vnT3000,vnITVGA2,vnT4000,vnT4000HiColor,vnT4000HiColorSC:ASM
     LES DI,Buf1
     CLD
     MOV AX,vmTxtBW40
     STOSW
     MOV AX,vmTxtC40
     STOSW
     MOV AX,vmTxtC40x28
     STOSW
     MOV AX,vmTxtC40x43
     STOSW
     MOV AX,vmTxtC40x50
     STOSW
     MOV AX,vmTxtBW80
     STOSW
     MOV AX,vmTxtC80
     STOSW
     MOV AX,vmTxtC80x28
     STOSW
     MOV AX,vmTxtC80x30
     STOSW
     MOV AX,vmTxtC80x34
     STOSW
     MOV AX,vmTxtC80x43
     STOSW
     MOV AX,vmTxtC80x50
     STOSW
     MOV AX,vmTxtC80x60
     STOSW
     MOV AX,vmTxtMono
     STOSW
     MOV AX,vmTxtMono80x28
     STOSW
     MOV AX,vmTxtMono80x43
     STOSW
     MOV AX,vmTxtMono80x50
     STOSW
     MOV AX,vmTxtC100x37
     STOSW
     MOV AX,vmTxtC100x40
     STOSW
     MOV AX,vmTxtC100x75
     STOSW
     MOV AX,vmTxtC132
     STOSW
     MOV AX,vmTxtC132x28
     STOSW
     MOV AX,vmTxtC132x44
     STOSW
     MOV AX,vmTxtC132x60
     STOSW
     MOV AX,vmTxtC132x100
     STOSW
     MOV AX,vmGrf640x200c2
     STOSW
     MOV AX,vmGrf640x480c2
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
     MOV AX,vmGrf640x480c16
     STOSW
     MOV AX,vmGrf320x200c256
     STOSW
     MOV AX,vmGrf320x400c256
     STOSW
     MOV AX,vmGrf360x480c256
     STOSW
     CMP Info1.Card,vnT3000
     JE  @NoHerc
     MOV AX,vmGrf800x600c16
     STOSW
     MOV AX,vmGrf1024x768c16
     STOSW
     MOV AX,vmGrf640x350c256
     STOSW
     MOV AX,vmGrf640x400c256
     STOSW
     MOV AX,vmGrf640x480c256
     STOSW
     MOV AX,vmGrf800x600c256
     STOSW
     MOV AX,vmGrf1024x768c256
     STOSW
     CMP Info1.Card,vnT4000HiColor
     JE  @HiColor
     CMP Info1.Card,vnT4000HiColorSC
     JE  @HiColor
     JMP @AnalogMono
@HiColor:
     MOV AX,vmGrf320x200c32768
     STOSW
     MOV AX,vmGrf640x350c32768
     STOSW
     MOV AX,vmGrf640x400c32768
     STOSW
     MOV AX,vmGrf640x480c32768
     STOSW
     MOV AX,vmGrf800x600c32768
     STOSW
@AnalogMono:
     CMP Info1.Monitor,mnAnalogMono
     JNE @Herc
     MOV AX,vmTxtMono132
     STOSW
     MOV AX,vmTxtMono132x28
     STOSW
     MOV AX,vmTxtMono132x44
     STOSW
@Herc:
     CMP Info1.Hercule,Ya
     JNE @NoHerc
     MOV AX,vmHerc
     STOSW
@NoHerc:
    END;
    vnMatrox,vnMatroxMystique,vnMatroxMillenium,vnMatroxG200,
    vnVesa:Begin
     ASM
      MOV AX,4F00h
      LES DI,PtrVesa
      INT 10h
     END;
     I:=0; J:=25;
     While$FFFF<>VesaHeader.Modes^[I]do Begin
      M:=VesaHeader.Modes^[I];
      If M>$FFThen Begin
       Case M of
	$100:Buf1[J]:=vmGrf640x400c256;
	$101:Buf1[J]:=vmGrf640x480c256;
	$102:Buf1[J]:=vmGrf800x600c16;
	$103:Buf1[J]:=vmGrf800x600c256;
	$104:Buf1[J]:=vmGrf1024x768c16;
	$105:Buf1[J]:=vmGrf1024x768c256;
	$106:Buf1[J]:=vmGrf1280x1024c16;
	$107:Buf1[J]:=vmGrf1280x1024c256;
	$108:Begin
	      Buf1[J]:=vmTxtC80x30;Inc(J);
	      Buf1[J]:=vmTxtC80x34;Inc(J);
	      Buf1[J]:=vmTxtC80x60;
	     End;
	$109:Buf1[J]:=vmTxtC132;
	$10A:Buf1[J]:=vmTxtC132x43;
	$10B:Buf1[J]:=vmTxtC132x50;
	$10C:Buf1[J]:=vmTxtC132x60;
	$10D:Buf1[J]:=vmGrf320x200c32768;
	$10E:Buf1[J]:=vmGrf320x200c65536;
	$110:Buf1[J]:=vmGrf640x480c32768;
	$111:Buf1[J]:=vmGrf640x480c65536;
	$112:Buf1[J]:=vmGrf640x480c16M;
	$113:Buf1[J]:=vmGrf800x600c32768;
	$114:Buf1[J]:=vmGrf800x600c65536;
	$116:Buf1[J]:=vmGrf1024x768c32768;
	Else Buf1[J]:=M;
       End;
       Inc(J);
       If J>79Then Break;
      End;
      Inc(I);
      If I>1000Then Break;
     End;
    End;
    vnVIP,vnVGAW,vnVGAW18800,vnVGAW18800_1,vnVGAW28800_2,vnVGAW28800_4,vnVGAW28800_5:ASM
     LES DI,Buf1
     CLD
     ADD DI,25*2
     MOV AX,vmTxtMono132
     STOSW
     MOV AX,vmTxtMono132x44
     STOSW
     MOV AX,vmTxtC132
     STOSW
     MOV AX,vmTxtC132x44
     STOSW
    END;
    vnV7Vega:ASM
     LES DI,Buf1
     CLD
     ADD DI,25*2
     MOV AX,vmTxtC80x43
     STOSW
     MOV AX,vmTxtC80x60
     STOSW
     MOV AX,vmTxtC100x60
     STOSW
     MOV AX,vmTxtC120x25
     STOSW
     MOV AX,vmTxtC120x43
     STOSW
     MOV AX,vmTxtC132
     STOSW
     MOV AX,vmTxtC132x43
     STOSW
     MOV AX,vmTxtMono132
     STOSW
     MOV AX,vmTxtMono132x43
     STOSW
     MOV AX,vmGrf720x512c16
     STOSW
     MOV AX,vmGrf800x600c16
     STOSW
     MOV AX,vmGrf640x350c256
     STOSW
     MOV AX,vmGrf640x400c256
     STOSW
     MOV AX,vmGrf640x480c256
     STOSW
     MOV AX,vmGrf720x512c256
     STOSW
     MOV AX,vmGrf800x600c256
     STOSW
     MOV AX,vmGrf960x720c16
     STOSW
     MOV AX,vmGrf1024x768c16
     STOSW
    END;
    vnV7Vram:ASM
     LES DI,Buf1
     CLD
     ADD DI,25*2
     MOV AX,vmTxtC80x43
     STOSW
     MOV AX,vmTxtC80x60
     STOSW
     MOV AX,vmTxtC100x60
     STOSW
     MOV AX,vmTxtC132
     STOSW
     MOV AX,vmTxtC132x28
     STOSW
     MOV AX,vmTxtC132x43
     STOSW
     MOV AX,vmGrf752x410c16
     STOSW
     MOV AX,vmGrf720x540c16
     STOSW
     MOV AX,vmGrf800x600c16
     STOSW
     MOV AX,vmGrf1024x768c2
     STOSW
     MOV AX,vmGrf1024x768c4
     STOSW
     MOV AX,vmGrf1024x768c16
     STOSW
     MOV AX,vmGrf640x400c256
     STOSW
     MOV AX,vmGrf640x480c256
     STOSW
     MOV AX,vmGrf720x540c256
     STOSW
    END;
   End;
  End;
 End
  Else
 ASM
  MOV BL,Info1.Card
  LES DI,Buf1
  CLD
  CMP Info1.EGA,Ya
  JNE @@OldCard
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
  JE  @@End
  CMP BL,vnAheadEGA2001
  JE  @@SetModeAheadEGA2001
  CMP BL,vnATT6300
  JE  @@SetModeATT6300
  CMP BL,vnLavaChromeIIEGA
  JE  @@SetModeLavaChromeIIEGA
  CMP BL,vnParadiseEGA480
  JE  @@SetModeParadiseEGA480
  CMP BL,vnTaxan565EGA
  JE  @@SetModeTaxan565EGA
  CMP BL,vnUltraVisionEGA
  JE  @@SetModeUltraVisionEGA
 { vnEGAW800,vnEGAW800N18800, vnEGAW800N18800_1,
  vnEGAW800N28800_2,vnEGAW800N28800_4,vnEGAW800N28800_5: }
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
  JMP @@End
 @@SetModeAheadEGA2001:
  MOV AX,vmTxtMono132
  STOSW
  MOV AX,vmTxtMono132x44
  STOSW
  JMP @@End
 @@SetModeATT6300:
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
  JMP @@End;
 @@SetModeLavaChromeIIEGA:
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
  JMP @@End
 @@SetModeParadiseEGA480:
  MOV AX,vmTxtC80x30
  STOSW
  MOV AX,vmTxtC132
  STOSW
  MOV AX,vmTxtC132x43
  STOSW
  MOV AX,vmGrf640x480c16
  STOSW
  JMP @@End;
 @@SetModeTaxan565EGA:
  MOV AX,vmTxtC132
  STOSW
  MOV AX,vmTxtC132x43
  STOSW
  MOV AX,vmTxtMono132
  STOSW
  MOV AX,vmTxtMono132x43
  STOSW
  JMP @@End
 @@SetModeUltraVisionEGA:
  MOV AX,vmGrf640x480c16
  STOSW
  JMP @@End
 @@OldCard:
  CMP BL,vnMDA
  JNE @@SetModeMDA
  CMP BL,vnCGA
  JNE @@SetModeCGA
  CMP BL,vnCompaqPortable
  JNE @@SetModeCompaqPortable
  CMP BL,vnGS
  JNE @@SetModeGS
  CMP BL,vnHercule
  JNE @@SetModeHercule
  CMP BL,vnHP95LX
  JNE @@SetModeHP95LX
 @@PC3270: { vnPC3270,vnPC3270G,vnPC3270GX,vnPC3270GX }
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
  JMP @@End
 @@SetModeMDA:
  MOV AX,vmTxtMono
  STOSW
  JMP @@End
 @@SetModeCGA:
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
  JMP @@End
 @@SetModeCompaqPortable:
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
  JMP @@End
 @@SetModeGS:
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
  CMP Info2.Card,vnUnknown
  JE  @@GSNoHercule
  MOV AX,vmTxtMono
  STOSW
  MOV AX,vmHerc
  STOSW
 @@GSNoHercule:
  JMP @@End
 @@SetModeHercule:
  MOV AX,vmTxtMono
  STOSW
  MOV AX,vmHerc
  STOSW
  JMP @@End;
 @@SetModeHP95LX:
  MOV AX,vmGrf240x128c2
  STOSW
 @@End:
 END;
 ASM
  CLD
  LES DI,Buf2
  MOV CX,80
  MOV AX,vmNone
  REP STOSW
 END;
 If(Info2.Card=vnMCGA)Then ASM
  LES DI,Buf2
  CLD
  MOV AX,vmTxtBW40
  STOSW
  MOV AX,vmTxtC40
  STOSW
  MOV AX,vmTxtC40x28
  STOSW
  MOV AX,vmTxtC40x43
  STOSW
  MOV AX,vmTxtC40x50
  STOSW
  MOV AX,vmTxtBW80
  STOSW
  MOV AX,vmTxtC80
  STOSW
  MOV AX,vmTxtC80x28
  STOSW
  MOV AX,vmTxtC80x43
  STOSW
  MOV AX,vmTxtC80x50
  STOSW
  MOV AX,vmGrf640x200c2
  STOSW
  MOV AX,vmGrf640x480c2
  STOSW
  MOV AX,vmGrf320x200c4
  STOSW
  MOV AX,vmGrf320x200c256
  STOSW
 END
  Else
 If(Info2.VGA)Then Begin
  ASM
   LES DI,Buf2
   CLD
   MOV AX,vmTxtBW40
   STOSW
   MOV AX,vmTxtC40
   STOSW
   MOV AX,vmTxtC40x28
   STOSW
   MOV AX,vmTxtC40x43
   STOSW
   MOV AX,vmTxtC40x50
   STOSW
   MOV AX,vmTxtBW80
   STOSW
   MOV AX,vmTxtC80
   STOSW
   MOV AX,vmTxtC80x28
   STOSW
   MOV AX,vmTxtC80x43
   STOSW
   MOV AX,vmTxtC80x50
   STOSW
   MOV AX,vmTxtMono
   STOSW
   MOV AX,vmTxtMono80x28
   STOSW
   MOV AX,vmTxtMono80x43
   STOSW
   MOV AX,vmTxtMono80x50
   STOSW
   MOV AX,vmGrf640x200c2
   STOSW
   MOV AX,vmGrf640x480c2
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
   MOV AX,vmGrf640x480c16
   STOSW
   MOV AX,vmGrf320x200c256
   STOSW
  END;
  If(Info2.VGA320x400)Then Begin
   Buf2[23]:=vmGrf320x400c256;
   Buf2[24]:=vmGrf360x480c256;
   Case(Info2.Card)of
    vnAheadB,vnAheadBWizard3270:Begin
     Buf2[25]:=vmTxtC132x28;
     Buf2[26]:=vmTxtC132x44;
     Buf2[27]:=vmGrf720x392c16;
     Buf2[28]:=vmGrf1024x768c2;
     Buf2[29]:=vmGrf1024x768c4;
     Buf2[30]:=vmGrf1024x768c16;
     Buf2[31]:=vmGrf640x400c256;
     Buf2[32]:=vmGrf640x480c256;
     Buf2[33]:=vmGrf800x600c256;
     Buf2[34]:=vmGrf1024x768c256;
     If(Info2.Card=vnAheadBWizard3270)Then Begin
      Buf2[35]:=vmTxtC160x50;
      Buf2[36]:=vmTxtC80x34;
      Buf2[37]:=vmTxtC80x66;
      If(Info2.Vesa)Then Buf2[38]:=vmGrf800x600c16;
     End
      Else
     If(Info2.Vesa)Then Buf2[35]:=vmGrf800x600c16;
    End;
    vnAllStarPeacock:ASM
     LES DI,Buf2
     CLD
     ADD DI,25*2
     MOV AX,vmTxtC80x60
     STOSW
     MOV AX,vmTxtC100x40
     STOSW
     MOV AX,vmTxtC132
     STOSW
     MOV AX,vmTxtC132x28
     STOSW
     MOV AX,vmTxtC132x43
     STOSW
     MOV AX,vmGrf800x600c16
     STOSW
    END;
    vnASTVGAPlus:ASM
     LES DI,Buf2
     CLD
     ADD DI,25*2
     MOV AX,vmTxtC132
     STOSW
     MOV AX,vmTxtC132x43
     STOSW
     MOV AX,vmGrf640x400c256
     STOSW
     MOV AX,vmGrf640x480c256
     STOSW
    END;
    vnATTVDC600:ASM
     LES DI,Buf2
     CLD
     ADD DI,25*2
     MOV AX,vmTxtC132
     STOSW
     MOV AX,vmTxtC132x43
     STOSW
     MOV AX,vmGrf640x400c2
     STOSW
     MOV AX,vmGrf640x400c16
     STOSW
     MOV AX,vmGrf800x600c2
     STOSW
     MOV AX,vmGrf800x600c16
     STOSW
     MOV AX,vmGrf640x400c256
     STOSW
     MOV AX,vmGrf640x480c256
     STOSW
    END;
    vnCardinal:ASM
     LES DI,Buf2
     CLD
     ADD DI,25*2
     MOV AX,vmGrf640x400c256
     STOSW
     MOV AX,vmGrf640x480c256
     STOSW
     MOV AX,vmGrf720x540c256
     STOSW
     MOV AX,vmGrf800x600c16
     STOSW
     MOV AX,vmGrf800x600c256
     STOSW
     MOV AX,vmGrf960x720c16
     STOSW
     MOV AX,vmGrf1024x768c16
     STOSW
     MOV AX,vmGrf320x200c32768
     STOSW
     MOV AX,vmGrf640x350c32768
     STOSW
     MOV AX,vmGrf640x400c32768
     STOSW
     MOV AX,vmGrf640x480c32768
     STOSW
     MOV AX,vmGrf800x600c32768
     STOSW
    END;
    vnEverex,vnEverexViewPoint,vnEverexUG2,vnEverexVision,vnEverexEVGA:ASM
     LES DI,Buf2
     CLD
     ADD DI,25*2
     MOV AX,vmTxtMono132
     STOSW
     MOV AX,vmTxtMono132x44
     STOSW
     MOV AX,vmTxtC80x60
     STOSW
     MOV AX,vmTxtC132
     STOSW
     MOV AX,vmTxtC132x44
     STOSW
     MOV AX,vmGrf320x200c32768
     STOSW
     MOV AX,vmGrf640x350c32768
     STOSW
     MOV AX,vmGrf640x400c32768
     STOSW
     MOV AX,vmGrf640x480c32768
     STOSW
     MOV AX,vmGrf800x600c32768
     STOSW
    END;
    vnGenoa,vnGenoa5100,vnGenoa5300,vnGenoa6100,vnGenoa6200,vnGenoa6400:ASM
     LES DI,Buf2
     CLD
     ADD DI,25*2
     MOV AX,vmGrf720x512c16
     STOSW
     MOV AX,vmGrf800x600c16
     STOSW
     MOV AX,vmGrf720x512c256
     STOSW
     MOV AX,vmGrf800x600c256
     STOSW
     MOV AX,vmGrf1024x768c16
     STOSW
     MOV AX,vmGrf512x512c16
     STOSW
     MOV AX,vmGrf512x512c256
     STOSW
    END;
    vnHPD1180A:ASM
     LES DI,Buf2
     CLD
     ADD DI,25*2
     MOV AX,vmTxtC132
     STOSW
     MOV AX,vmTxtC132x44
     STOSW
     MOV AX,vmGrf800x600c2
     STOSW
     MOV AX,vmGrf800x600c16
     STOSW
     MOV AX,vmGrf640x480c256
     STOSW
    END;
    vnMorseVGA:ASM
     LES DI,Buf2
     CLD
     ADD DI,25*2
     MOV AX,vmTxtC80x60
     STOSW
     MOV AX,vmTxtC100x30
     STOSW
     MOV AX,vmTxtC100x50
     STOSW
     MOV AX,vmTxtC100x60
     STOSW
     MOV AX,vmTxtC100x75
     STOSW
     MOV AX,vmTxtC132x30
     STOSW
     MOV AX,vmTxtC132x50
     STOSW
     MOV AX,vmTxtC132x60
     STOSW
     MOV AX,vmGrf720x540c16
     STOSW
     MOV AX,vmGrf800x600c16
     STOSW
    End;
    vnOak:ASM
     LES DI,Buf2
     CLD
     ADD DI,25*2
     MOV AX,vmTxtC132
     STOSW
     MOV AX,vmTxtC132x43
     STOSW
     MOV AX,vmGrf800x600c16
     STOSW
    End;
    vnOrchid:ASM
     LES DI,Buf2
     CLD
     ADD DI,25*2
     MOV AX,vmGrf640x480c256
     STOSW
     MOV AX,vmGrf800x600c16
     STOSW
     MOV AX,vmGrf800x600c256
     STOSW
     MOV AX,vmGrf1024x768c16
     STOSW
    END;
    vnOrchidProDesVGA,vnOrchidProDesIIVGA:ASM
     LES DI,Buf2
     CLD
     ADD DI,25*2
     MOV AX,vmTxtC80x60
     STOSW
     MOV AX,vmTxtC100x40
     STOSW
     MOV AX,vmTxtC132
     STOSW
     MOV AX,vmTxtC132x28
     STOSW
     MOV AX,vmTxtC132x44
     STOSW
     CMP Info2.Card,vnOrchidProDesIIVGA
     JNE @SkipII
     MOV AX,vmGrf320x200c32768
     STOSW
     MOV AX,vmGrf640x350c32768
     STOSW
     MOV AX,vmGrf640x400c32768
     STOSW
     MOV AX,vmGrf640x480c32768
     STOSW
     MOV AX,vmGrf800x600c32768
     STOSW
@SkipII:
    END;
    vnParadisePVGA1A,vnParadiseWD90C00,vnParadiseWD90C10,vnParadiseWD90C11,vnParadise:ASM
     LES DI,Buf2
     CLD
     ADD DI,25*2
     MOV AX,vmTxtC132
     STOSW
     MOV AX,vmTxtC132x43
     STOSW
     MOV AX,vmGrf800x600c2
     STOSW
     MOV AX,vmGrf800x600c16
     STOSW
     MOV AX,vmGrf640x400c256
     STOSW
     MOV AX,vmGrf640x480c256
     STOSW
    END;
    vnSigma:ASM
     LES DI,Buf2
     CLD
     ADD DI,25*2
     MOV AX,vmGrf800x600c16
     STOSW
     MOV AX,vmGrf800x600c256
     STOSW
     MOV AX,vmGrf1024x768c16
     STOSW
    END;
    vnSTB:ASM
     LES DI,Buf2
     CLD
     ADD DI,25*2
     MOV AX,vmGrf640x480c256
     STOSW
     MOV AX,vmGrf800x600c16
     STOSW
     MOV AX,vmGrf800x600c256
     STOSW
     MOV AX,vmGrf960x720c16
     STOSW
     MOV AX,vmGrf1024x768c16
     STOSW
    END;
    vnSTBVGAEM16Plus:Buf1[23]:=vmGrf1024x768c256;
    vnTatungVGA:ASM
     LES DI,Buf2
     CLD
     ADD DI,25*2
     MOV AX,vmTxtC80x43
     STOSW
     MOV AX,vmTxtC80x60
     STOSW
     MOV AX,vmTxtC100x60
     STOSW
     MOV AX,vmTxtC132
     STOSW
     MOV AX,vmTxtC132x28
     STOSW
     MOV AX,vmTxtC132x43
     STOSW
     MOV AX,vmGrf752x410c16
     STOSW
     MOV AX,vmGrf800x600c16
     STOSW
     MOV AX,vmGrf640x400c256
     STOSW
    END;
    vnTecmarVGAAD:ASM
     LES DI,Buf2
     CLD
     ADD DI,25*2
     MOV AX,vmTxtC80x43
     STOSW
     MOV AX,vmTxtC132
     STOSW
     MOV AX,vmGrf640x350c256
     STOSW
     MOV AX,vmGrf640x400c256
     STOSW
     MOV AX,vmGrf640x480c256
     STOSW
     MOV AX,vmGrf800x600c256
     STOSW
    END;
    vnTrident8800BR,vnTrident8800CS,vnTrident8900:ASM
     LES DI,Buf2
     CLD
     ADD DI,25*2
     MOV AX,vmTxtC80x30
     STOSW
     MOV AX,vmTxtC80x60
     STOSW
     MOV AX,vmTxtC132
     STOSW
     MOV AX,vmTxtC132x30
     STOSW
     MOV AX,vmTxtC132x43
     STOSW
     MOV AX,vmTxtC132x60
     STOSW
     MOV AX,vmGrf800x600c16
     STOSW
     MOV AX,vmGrf640x400c256
     STOSW
     MOV AX,vmGrf640x480c256
     STOSW
     MOV AX,vmGrf1024x768c16
     STOSW
     MOV AX,vmGrf768x1024c16
     STOSW
     CMP Info2.Card,vnTrident8900
     JNE @Skip8900
     MOV AX,vmGrf800x600c256
     STOSW
     MOV AX,vmGrf1024x768c4
     STOSW
     MOV AX,vmGrf1024x768c256
     STOSW
@Skip8900:
    END;
    vnT3000,vnITVGA2,vnT4000,vnT4000HiColor,vnT4000HiColorSC:ASM
     LES DI,Buf2
     CLD
     MOV AX,vmTxtBW40
     STOSW
     MOV AX,vmTxtC40
     STOSW
     MOV AX,vmTxtC40x28
     STOSW
     MOV AX,vmTxtC40x43
     STOSW
     MOV AX,vmTxtC40x50
     STOSW
     MOV AX,vmTxtBW80
     STOSW
     MOV AX,vmTxtC80
     STOSW
     MOV AX,vmTxtC80x28
     STOSW
     MOV AX,vmTxtC80x30
     STOSW
     MOV AX,vmTxtC80x34
     STOSW
     MOV AX,vmTxtC80x43
     STOSW
     MOV AX,vmTxtC80x50
     STOSW
     MOV AX,vmTxtC80x60
     STOSW
     MOV AX,vmTxtMono
     STOSW
     MOV AX,vmTxtMono80x28
     STOSW
     MOV AX,vmTxtMono80x43
     STOSW
     MOV AX,vmTxtMono80x50
     STOSW
     MOV AX,vmTxtC100x37
     STOSW
     MOV AX,vmTxtC100x40
     STOSW
     MOV AX,vmTxtC100x75
     STOSW
     MOV AX,vmTxtC132
     STOSW
     MOV AX,vmTxtC132x28
     STOSW
     MOV AX,vmTxtC132x44
     STOSW
     MOV AX,vmTxtC132x60
     STOSW
     MOV AX,vmTxtC132x100
     STOSW
     MOV AX,vmGrf640x200c2
     STOSW
     MOV AX,vmGrf640x480c2
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
     MOV AX,vmGrf640x480c16
     STOSW
     MOV AX,vmGrf320x200c256
     STOSW
     MOV AX,vmGrf320x400c256
     STOSW
     MOV AX,vmGrf360x480c256
     STOSW
     CMP Info1.Card,vnT3000
     JE  @NoHerc
     MOV AX,vmGrf800x600c16
     STOSW
     MOV AX,vmGrf1024x768c16
     STOSW
     MOV AX,vmGrf640x350c256
     STOSW
     MOV AX,vmGrf640x400c256
     STOSW
     MOV AX,vmGrf640x480c256
     STOSW
     MOV AX,vmGrf800x600c256
     STOSW
     MOV AX,vmGrf1024x768c256
     STOSW
     CMP Info1.Card,vnT4000HiColor
     JE  @HiColor
     CMP Info1.Card,vnT4000HiColorSC
     JE  @HiColor
     JMP @AnalogMono
@HiColor:
     MOV AX,vmGrf320x200c32768
     STOSW
     MOV AX,vmGrf640x350c32768
     STOSW
     MOV AX,vmGrf640x400c32768
     STOSW
     MOV AX,vmGrf640x480c32768
     STOSW
     MOV AX,vmGrf800x600c32768
     STOSW
@AnalogMono:
     CMP Info1.Monitor,mnAnalogMono
     JNE @Herc
     MOV AX,vmTxtMono132
     STOSW
     MOV AX,vmTxtMono132x28
     STOSW
     MOV AX,vmTxtMono132x44
     STOSW
@Herc:
     CMP Info1.Hercule,Ya
     JNE @NoHerc
     MOV AX,vmHerc
     STOSW
@NoHerc:
    END;
    vnVesa:ASM
     LES DI,Buf2
     CLD
     ADD DI,25*2
     MOV AX,vmTxtC80x60
     STOSW
     MOV AX,vmTxtC132
     STOSW
     MOV AX,vmTxtC132x43
     STOSW
     MOV AX,vmTxtC132x50
     STOSW
     MOV AX,vmTxtC132x60
     STOSW
    END;
    vnVIP,vnVGAW,vnVGAW18800,vnVGAW18800_1,vnVGAW28800_2,vnVGAW28800_4,vnVGAW28800_5:ASM
     LES DI,Buf2
     CLD
     ADD DI,25*2
     MOV AX,vmTxtMono132
     STOSW
     MOV AX,vmTxtMono132x44
     STOSW
     MOV AX,vmTxtC132
     STOSW
     MOV AX,vmTxtC132x44
     STOSW
    END;
    vnV7Vega:ASM
     LES DI,Buf2
     CLD
     ADD DI,25*2
     MOV AX,vmTxtC80x43
     STOSW
     MOV AX,vmTxtC80x60
     STOSW
     MOV AX,vmTxtC100x60
     STOSW
     MOV AX,vmTxtC120x25
     STOSW
     MOV AX,vmTxtC120x43
     STOSW
     MOV AX,vmTxtC132
     STOSW
     MOV AX,vmTxtC132x43
     STOSW
     MOV AX,vmTxtMono132
     STOSW
     MOV AX,vmTxtMono132x43
     STOSW
     MOV AX,vmGrf720x512c16
     STOSW
     MOV AX,vmGrf800x600c16
     STOSW
     MOV AX,vmGrf640x350c256
     STOSW
     MOV AX,vmGrf640x400c256
     STOSW
     MOV AX,vmGrf640x480c256
     STOSW
     MOV AX,vmGrf720x512c256
     STOSW
     MOV AX,vmGrf800x600c256
     STOSW
     MOV AX,vmGrf960x720c16
     STOSW
     MOV AX,vmGrf1024x768c16
     STOSW
    END;
    vnV7Vram:ASM
     LES DI,Buf2
     CLD
     ADD DI,25*2
     MOV AX,vmTxtC80x43
     STOSW
     MOV AX,vmTxtC80x60
     STOSW
     MOV AX,vmTxtC100x60
     STOSW
     MOV AX,vmTxtC132
     STOSW
     MOV AX,vmTxtC132x28
     STOSW
     MOV AX,vmTxtC132x43
     STOSW
     MOV AX,vmGrf752x410c16
     STOSW
     MOV AX,vmGrf720x540c16
     STOSW
     MOV AX,vmGrf800x600c16
     STOSW
     MOV AX,vmGrf1024x768c2
     STOSW
     MOV AX,vmGrf1024x768c4
     STOSW
     MOV AX,vmGrf1024x768c16
     STOSW
     MOV AX,vmGrf640x400c256
     STOSW
     MOV AX,vmGrf640x480c256
     STOSW
     MOV AX,vmGrf720x540c256
     STOSW
    END;
   End;
  End;
 End
  Else
 ASM
  MOV BL,Info2.Card
  LES DI,Buf2
  CLD
  CMP Info2.EGA,Ya
  JNE @@OldCard
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
  JE  @@End
  CMP BL,vnAheadEGA2001
  JE  @@SetModeAheadEGA2001
  CMP BL,vnATT6300
  JE  @@SetModeATT6300
  CMP BL,vnLavaChromeIIEGA
  JE  @@SetModeLavaChromeIIEGA
  CMP BL,vnParadiseEGA480
  JE  @@SetModeParadiseEGA480
  CMP BL,vnTaxan565EGA
  JE  @@SetModeTaxan565EGA
  CMP BL,vnUltraVisionEGA
  JE  @@SetModeUltraVisionEGA
 { vnEGAW800,vnEGAW800N18800, vnEGAW800N18800_1,
  vnEGAW800N28800_2,vnEGAW800N28800_4,vnEGAW800N28800_5: }
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
  JMP @@End
 @@SetModeAheadEGA2001:
  MOV AX,vmTxtMono132
  STOSW
  MOV AX,vmTxtMono132x44
  STOSW
  JMP @@End
 @@SetModeATT6300:
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
  JMP @@End;
 @@SetModeLavaChromeIIEGA:
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
  JMP @@End
 @@SetModeParadiseEGA480:
  MOV AX,vmTxtC80x30
  STOSW
  MOV AX,vmTxtC132
  STOSW
  MOV AX,vmTxtC132x43
  STOSW
  MOV AX,vmGrf640x480c16
  STOSW
  JMP @@End;
 @@SetModeTaxan565EGA:
  MOV AX,vmTxtC132
  STOSW
  MOV AX,vmTxtC132x43
  STOSW
  MOV AX,vmTxtMono132
  STOSW
  MOV AX,vmTxtMono132x43
  STOSW
  JMP @@End
 @@SetModeUltraVisionEGA:
  MOV AX,vmGrf640x480c16
  STOSW
  JMP @@End
 @@OldCard:
  CMP BL,vnMDA
  JNE @@SetModeMDA
  CMP BL,vnCGA
  JNE @@SetModeCGA
  CMP BL,vnCompaqPortable
  JNE @@SetModeCompaqPortable
  CMP BL,vnGS
  JNE @@SetModeGS
  CMP BL,vnHercule
  JNE @@SetModeHercule
  CMP BL,vnHP95LX
  JNE @@SetModeHP95LX
  CMP BL,vnUnknown
  JE  @@End
 @@PC3270: { vnPC3270,vnPC3270G,vnPC3270GX,vnPC3270GX }
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
  JMP @@End
 @@SetModeMDA:
  MOV AX,vmTxtMono
  STOSW
  JMP @@End
 @@SetModeCGA:
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
  JMP @@End
 @@SetModeCompaqPortable:
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
  JMP @@End
 @@SetModeGS:
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
  CMP Info2.Card,vnUnknown
  JE  @@GSNoHercule
  MOV AX,vmTxtMono
  STOSW
  MOV AX,vmHerc
  STOSW
 @@GSNoHercule:
  JMP @@End
 @@SetModeHercule:
  MOV AX,vmTxtMono
  STOSW
  MOV AX,vmHerc
  STOSW
  JMP @@End;
 @@SetModeHP95LX:
  MOV AX,vmGrf240x128c2
  STOSW
 @@End:
 END;
End;

Procedure EndList;Begin End;

{END.}

{$IFOPT G+}
 Const HeaderRLL:String = 'BibliothŠque en Mode R‚el pour 80286'+#26;
{$ELSE}
 Const HeaderRLL:String = 'BibliothŠque en Mode R‚el'+#26;
{$ENDIF}

Const

      NumIndex=1;

      NameIndex:Array[0..NumIndex]of System.PChar=(
      'RL2'#26,
      'Support');

Var SD:Wd;HandleData,HandleMap:Hdl; PF,NmIndex:Long;

Procedure AddIndex;Begin
 SetRec(HandleData,NmIndex+1,SizeOf(PF),PF);
 If(SD<>0)Then
  PutFileTxtLn(HandleMap,'Index '+Str(NmIndex)+' : '+StrPas(@NameIndex[NmIndex+1])+
	       ', Taille '+Str(SD)+' octets');
 Inc(NmIndex);
 SetFilePos(HandleData,PF);
End;

BEGIN
 InitSystems(suIsabel);
 SetFile('SUPPORT.DRV',0,Ofs(EndList)-Ofs(ChkModeSupport)+1,Mem[Seg(ChkModeSupport):Ofs(ChkModeSupport)]);
 DoneSystems;
(*
 NmIndex:=0;
 HandleData:=New('MODESUPP.RLL');
 If(HandleData=errHdl)Then Begin
  WriteLn('Impossible de cr‚er le fichier MODESUPP.RLL');
  Halt;
 End;
 HandleMap := New('MODESUPP.MAP');
 If(HandleMap=errHdl)Then
 Begin
  WriteLn('Impossible de cr‚er le fichier MODESUPP.MAP');
  Halt;
 End;
 SetFilePos(HandleData,0);
 PutFileTxt(HandleData,'RL2'+#26);
 PF:=(NumIndex+2)*SizeOf(Long);
  { Header }
 SetFilePos(HandleData,PF);
 _SetRec(HandleData,Length(HeaderRLL),HeaderRLL[1]);
 Inc(PF,Length(HeaderRLL));
  { -- Index 0 -- : ChkModeSupport }
 SD:=Ofs(EndList)-Ofs(ChkModeSupport)+1;
 AddIndex;
 _SetRec(HandleData,SD,Mem[Seg(ChkModeSupport):Ofs(ChkModeSupport)]);
 Inc(PF,SD);
  { -- Index End -- }
 SD:=0;
 AddIndex;
 Close(HandleMap);
 Close(HandleData);*)
END.