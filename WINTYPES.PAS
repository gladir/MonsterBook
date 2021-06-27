
{*******************************************************}
{                                                       }
{       Turbo Pascal Runtime Library                    }
{       Windows API Interface Unit                      }
{                                                       }
{       Copyright (c) 1991 Borland International        }
{                                                       }
{*******************************************************}

unit WinTypes;

interface

type
  Bool    = System.WordBool;

type
  PStr      = PChar;
  PBool     = ^WordBool;
  PInteger  = ^Integer;
  PByte     = ^Byte;
  PWord     = ^Word;
  PLongInt  = ^LongInt;

type
  PHandle       = ^THandle;
  LPHandle      = PHandle;
  THandle       = Word;
  TGlobalHandle = THandle;
  TLocalHandle  = THandle;

type
  TFarProc = Pointer;
  LPVoid  = Pointer;

type
  HWnd     = THandle;
  HStr     = THandle;
  HIcon    = THandle;
  HDC      = THandle;
  HMenu    = THandle;
  HPen     = THandle;
  HFont    = THandle;
  HBrush   = THandle;
  HBitmap  = THandle;
  HCursor  = THandle;
  HRGN     = THandle;
  HPalette = THandle;

type
  TColorRef = Longint;

type
  PRect = ^TRect;
  TRect = record
    left: Integer;
    top: Integer;
    right: Integer;
    bottom: Integer;
  end;

type
  PPoint = ^TPoint;
  TPoint = record
    x: Integer;
    y: Integer;
  end;
  MakePoint = TPoint;

{--------------------------------------------------------------------------}
{  KERNEL Section                                                          }
{--------------------------------------------------------------------------}

{ OpenFile structure }

type
  POFStruct = ^TOFStruct;
  TOFStruct = record
    cBytes: Byte;
    fFixedDisk: Byte;
    nErrCode: Word;
    reserved: array[0..3] of Byte;
    szPathName: array[0..127] of Char;
  end;

{ OpenFile flags }

const
  of_Read             = $0000;
  of_Write            = $0001;
  of_ReadWrite        = $0002;
  of_Share_Compat     = $0000;
  of_Share_Exclusive  = $0010;
  of_Share_Deny_Write = $0020;
  of_Share_Deny_Read  = $0030;
  of_Share_Deny_None  = $0040;
  of_Parse            = $0100;
  of_Delete           = $0200;
  of_Verify           = $0400;
  of_Cancel           = $0800;
  of_Create           = $1000;
  of_Prompt           = $2000;
  of_Exist            = $4000;
  of_Reopen           = $8000;

{ GetTempFileName flags }

const
  tf_ForceDrive = $80;

{ GetDriveType return values }

const
  drive_Removable = 2;
  drive_Fixed     = 3;
  drive_Remote    = 4;

{ Global Memory Flags }

const
  gmem_Fixed       = $0000;
  gmem_Moveable    = $0002;
  gmem_NoCompact   = $0010;
  gmem_NoDiscard   = $0020;
  gmem_ZeroInit    = $0040;
  gmem_Modify      = $0080;
  gmem_Discardable = $0100;
  gmem_Not_Banked  = $1000;
  gmem_Share       = $2000;
  gmem_DDEShare    = $2000;
  gmem_Notify      = $4000;
  gmem_Lower       = gmem_Not_Banked;

const
  GHnd = gmem_Moveable or gmem_ZeroInit;
  GPtr = gmem_Fixed or gmem_ZeroInit;

{ Flags returned by GlobalFlags (in addition to gmem_Discardable) }

const
  gmem_Discarded = $4000;
  gmem_LockCount = $00FF;

{ Local Memory Flags }

const
  lmem_Fixed       = $0000;
  lmem_Moveable    = $0002;
  lmem_NoCompact   = $0010;
  lmem_NoDiscard   = $0020;
  lmem_ZeroInit    = $0040;
  lmem_Modify      = $0080;
  lmem_Discardable = $0F00;

const
  LHnd = lmem_Moveable or lmem_ZeroInit;
  LPtr = lmem_Fixed or lmem_ZeroInit;

const
  NonZeroLHnd = lmem_Moveable;
  NonZeroLPtr = lmem_Fixed;

const
  LNotify_OutOfMem = 0;
  LNotify_Move     = 1;
  LNotify_Discard  = 2;


{ Flags returned by LocalFlags (in addition to LMEM_DISCARDABLE) }

const
  lmem_Discarded = $4000;
  lmem_LockCount = $00FF;


type
  MakeIntResource = PStr;

const
  Difference = 11;

{ Predefined Resource Types }

const
  rt_Cursor      = MakeIntResource(1);
  rt_Bitmap      = MakeIntResource(2);
  rt_Icon        = MakeIntResource(3);
  rt_Menu        = MakeIntResource(4);
  rt_Dialog      = MakeIntResource(5);
  rt_String      = MakeIntResource(6);
  rt_FontDir     = MakeIntResource(7);
  rt_Font        = MakeIntResource(8);
  rt_Accelerator = MakeIntResource(9);
  rt_RCData      = MakeIntResource(10);

{ NOTE: if any new resource types are introduced above this point, }
{ then the value of Difference must be changed. }
{ (rt_Group_Cursor - rt_Cursor) must always be equal to Difference }
{ (rt_Group_Icon - rt_Icon) must always be equal to Difference }

  rt_Group_Cursor = MakeIntResource(LongInt(rt_Cursor) + Difference);

{ The value 13 is intentionally unused }

  rt_Group_Icon = MakeIntResource(LongInt(rt_Icon) + Difference);

type
  TAtom = Word;

type
  MakeIntAtom = PStr;

{ Catch and Throw }

type
  PCatchBuf = ^TCatchBuf;
  TCatchBuf = array[0..8] of Integer;

const
  wf_PMode      = $0001;
  wf_CPU286     = $0002;
  wf_CPU386     = $0004;
  wf_CPU486     = $0008;
  wf_Standard   = $0010;
  wf_Win286     = $0010;
  wf_Enhanced   = $0020;
  wf_Win386     = $0020;
  wf_CPU086     = $0040;
  wf_CPU186     = $0080;
  wf_LargeFrame = $0100;
  wf_SmallFrame = $0200;
  wf_80x87      = $0400;

  wep_System_Exit  = 1;
  wep_Free_DLL     = 0;
{$IFDEF OEMRESOURCE}

{ OEM Resource Ordinal Numbers }

const
  obm_Close    = 32754;
  obm_UpArrow  = 32753;
  obm_DnArrow  = 32752;
  obm_RgArrow  = 32751;
  obm_LfArrow  = 32750;
  obm_Reduce   = 32749;
  obm_Zoom     = 32748;
  obm_Restore  = 32747;
  obm_Reduced  = 32746;
  obm_Zoomd    = 32745;
  obm_Restored = 32744;
  obm_UpArrowD = 32743;
  obm_DnArrowD = 32742;
  obm_RgArrowD = 32741;
  obm_LfArrowD = 32740;
  obm_MnArrow  = 32739;
  obm_Combo    = 32738;

const
  obm_Old_Close   = 32767;
  obm_Size        = 32766;
  obm_Old_UpArrow = 32765;
  obm_Old_DnArrow = 32764;
  obm_Old_RgArrow = 32763;
  obm_Old_LfArrow = 32762;
  obm_BTSize      = 32761;
  obm_Check       = 32760;
  obm_CheckBoxes  = 32759;
  obm_BTNCorners  = 32758;
  obm_Old_Reduce  = 32757;
  obm_Old_Zoom    = 32756;
  obm_Old_Restore = 32755;

const
  ocr_Normal   = 32512;
  ocr_IBeam    = 32513;
  ocr_Wait     = 32514;
  ocr_Cross    = 32515;
  ocr_Up       = 32516;
  ocr_Size     = 32640;
  ocr_Icon     = 32641;
  ocr_SizeNWSE = 32642;
  ocr_SizeNESW = 32643;
  ocr_SizeWE   = 32644;
  ocr_SizeNS   = 32645;
  ocr_SizeAll  = 32646;
  ocr_ICOCUR   = 32647;

const
  oic_Sample = 32512;
  oic_Hand   = 32513;
  oic_Ques   = 32514;
  oic_Bang   = 32515;
  oic_Note   = 32516;

{$ENDIF OEMRESOURCE}

{--------------------------------------------------------------------------}
{  GDI Section                                                             }
{--------------------------------------------------------------------------}

{ Binary raster ops }

const
  r2_Black       = 1;   { 0    }
  r2_NotMergePen = 2;   { DPon }
  r2_MaskNotPen  = 3;   { DPna }
  r2_NotCopyPen  = 4;   { PN   }
  r2_MaskPenNot  = 5;   { PDna }
  r2_Not         = 6;   { Dn   }
  r2_XORPen      = 7;   { DPx  }
  r2_NotMaskPen  = 8;   { DPan }
  r2_MaskPen     = 9;   { DPa  }
  r2_NotXORPen   = 10;  { DPxn }
  r2_NOP         = 11;  { D    }
  r2_MergeNotPen = 12;  { DPno }
  r2_CopyPen     = 13;  { P    }
  r2_MergePenNot = 14;  { PDno }
  r2_MergePen    = 15;  { DPo  }
  r2_White       = 16;  { 1    }

{ Ternary raster operations }

  SrcCopy     = $00CC0020;  { dest = source                   }
  SrcPaint    = $00EE0086;  { dest = source OR dest           }
  SrcAnd      = $008800C6;  { dest = source AND dest          }
  SrcInvert   = $00660046;  { dest = source XOR dest          }
  SrcErase    = $00440328;  { dest = source AND (NOT dest )   }
  NotSrcCopy  = $00330008;  { dest = (NOT source)             }
  NotSrcErase = $001100A6;  { dest = (NOT src) AND (NOT dest) }
  MergeCopy   = $00C000CA;  { dest = (source AND pattern)     }
  MergePaint  = $00BB0226;  { dest = (NOT source) OR dest     }
  PatCopy     = $00F00021;  { dest = Pattern                  }
  PatPaint    = $00FB0A09;  { dest = DPSnoo                   }
  PatInvert   = $005A0049;  { dest = pattern XOR dest         }
  DstInvert   = $00550009;  { dest = (NOT dest)               }
  Blackness   = $00000042;  { dest = BLACK                    }
  Whiteness   = $00FF0062;  { dest = WHITE                    }

{ StretchBlt modes }

const
  BlackOnWhite = 1;
  WhiteOnBlack = 2;
  ColorOnColor = 3;

{ PolyFill modes }

const
  Alternate = 1;
  Winding   = 2;

{ Text alignment options }

const
  ta_NoUpdateCP = 0;
  ta_UpdateCP   = 1;

const
  ta_Left   = 0;
  ta_Right  = 2;
  ta_Center = 6;

const
  ta_Top      = 0;
  ta_Bottom   = 8;
  ta_BaseLine = 24;

const
  eto_Grayed  = 1;
  eto_Opaque  = 2;
  eto_Clipped = 4;

const
  Aspect_Filtering = $0001;

{ Metafile functions }

const
  meta_SetBKColor           = $0201;
  meta_SetBKMode            = $0102;
  meta_SetMapMode           = $0103;
  meta_SetROP2              = $0104;
  meta_SetRelAbs            = $0105;
  meta_SetPolyFillMode      = $0106;
  meta_SetStretchBltMode    = $0107;
  meta_SetTextCharExtra     = $0108;
  meta_SetTextColor         = $0209;
  meta_SetTextJustification = $020A;
  meta_SetWindowOrg         = $020B;
  meta_SetWindowExt         = $020C;
  meta_SetViewportOrg       = $020D;
  meta_SetViewportExt       = $020E;
  meta_OffsetWindowOrg      = $020F;
  meta_ScaleWindowExt       = $0400;
  meta_OffsetViewportOrg    = $0211;
  meta_ScaleViewportExt     = $0412;
  meta_LineTo               = $0213;
  meta_MoveTo               = $0214;
  meta_ExcludeClipRect      = $0415;
  meta_IntersectClipRect    = $0416;
  meta_Arc                  = $0817;
  meta_Ellipse              = $0418;
  meta_FloodFill            = $0419;
  meta_Pie                  = $081A;
  meta_Rectangle            = $041B;
  meta_RoundRect            = $061C;
  meta_PatBlt               = $061D;
  meta_SaveDC               = $001E;
  meta_SetPixel             = $041F;
  meta_OffsetClipRgn        = $0220;
  meta_TextOut              = $0521;
  meta_BitBlt               = $0922;
  meta_StretchBlt           = $0B23;
  meta_Polygon              = $0324;
  meta_PolyLine             = $0325;
  meta_Escape               = $0626;
  meta_RestoreDC            = $0127;
  meta_FillRegion           = $0228;
  meta_FrameRegion          = $0429;
  meta_InvertRegion         = $012A;
  meta_PaintRegion          = $012B;
  meta_SelectClipRegion     = $012C;
  meta_SelectObject         = $012D;
  meta_SetTextAlign         = $012E;
  meta_DrawText             = $062F;

const
  meta_Chord          	    = $0830;
  meta_SetMapperFlags       = $0231;
  meta_ExtTextOut           = $0a32;
  meta_SetDIBToDev          = $0d33;
  meta_SelectPalette        = $0234;
  meta_RealizePalette       = $0035;
  meta_AnimatePalette       = $0436;
  meta_SetPalEntries        = $0037;
  meta_PolyPolygon          = $0538;
  meta_ResizePalette        = $0139;

const
  meta_DIBBitBlt             = $0940;
  meta_DIBStretchBlt         = $0b41;
  meta_DIBCreatePatternBrush = $0142;

const
  meta_DeleteObject = $01f0;

const
  meta_CreatePalette        = $00f7;
  meta_CreateBrush          = $00F8;
  meta_CreatePatternBrush   = $01F9;
  meta_CreatePenIndirect    = $02FA;
  meta_CreateFontIndirect   = $02FB;
  meta_CreateBrushIndirect  = $02FC;
  meta_CreateBitmapIndirect = $02FD;
  meta_CreateBitmap         = $06FE;
  meta_CreateRegion         = $06FF;

{ GDI Escapes }

const
  NewFrame               = 1;
  AbortDoc               = 2;
  NextBand               = 3;
  SetColorTable          = 4;
  GetColorTable          = 5;
  FlushOutput            = 6;
  DraftMode              = 7;
  QueryEscSupport        = 8;
  SetAbortProc           = 9;
  StartDoc               = 10;
  EndDoc                 = 11;
  GetPhysPageSize        = 12;
  GetPrintingOffset      = 13;
  GetScalingFactor       = 14;
  MFComment              = 15;
  GetPenWidth            = 16;
  SetCopyCount           = 17;
  SelectPaperSource      = 18;
  DeviceData             = 19;
  PassThrough            = 19;
  GetTechnolgy           = 20;
  GetTechnology          = 20;
  SetEndCap              = 21;
  SetLineJoin            = 22;
  SetMiterLimit          = 23;
  BandInfo               = 24;
  DrawPatternRect        = 25;
  GetVectorPenSize       = 26;
  GetVectorBrushSize     = 27;
  EnableDuplex           = 28;
  GetSetPaperBins        = 29;
  GetSetPrintOrient      = 30;
  EnumPaperBins          = 31;
  SetDIBScaling          = 32;
  EPSPrinting            = 33;
  EnumPaperMetrics       = 34;
  GetSetPaperMetrics     = 35;
  PostScript_Data        = 37;
  PostScript_Ignore      = 38;
  GetExtendedTextMetrics = 256;
  GetExtentTable         = 257;
  GetPairKernTable       = 258;
  GetTrackKernTable      = 259;
  GDIExtTextOut          = 512;    {! Renamed from EXTTEXTOUT !}
  EnableRelativeWidths   = 768;
  EnablePairKerning      = 769;
  SetKernTrack           = 770;
  SetAllJustValues       = 771;
  SetCharSet             = 772;

const
  GDIStretchBlt        = 2048;    {! renamed from STRETCHBLT !}
  Begin_Path           = 4096;
  Clip_To_Path         = 4097;
  End_Path             = 4098;
  Ext_Device_Caps      = 4099;
  Restore_CTM          = 4100;
  Save_Ctm             = 4101;
  Set_Arc_Direction    = 4102;
  Set_Background_Color = 4103;
  Set_Poly_Mode        = 4104;
  Set_Screen_Angle     = 4105;
  Set_Spread           = 4106;
  Transform_CTM        = 4107;
  Set_Clip_Box         = 4108;
  Set_Bounds           = 4109;

{ Spooler error codes }

const
  sp_NotReported = $4000;
  sp_Error       = (-1);
  sp_AppAbort    = (-2);
  sp_UserAbort   = (-3);
  sp_OutOfDisk   = (-4);
  sp_OutOfMemory = (-5);

const
  pr_JobStatus = $0000;

{ Object definitions for EnumObjects }

const
  obj_Pen   = 1;
  obj_Brush = 2;

{ Bitmap header definition }

type
  PBitmap = ^TBitmap;
  TBitmap = record
    bmType: Integer;
    bmWidth: Integer;
    bmHeight: Integer;
    bmWidthBytes: Integer;
    bmPlanes: Byte;
    bmBitsPixel: Byte;
    bmBits: Pointer;
  end;

type
  TRGBTriple = record
    rgbtBlue: Byte;
    rgbtGreen: Byte;
    rgbtRed: Byte;
  end;

type
  TRGBQuad = record
    rgbBlue: Byte;
    rgbGreen: Byte;
    rgbRed: Byte;
    rgbReserved: Byte;
  end;

{ Structures for defining DIBs }

type
  PBitmapCoreHeader = ^TBitmapCoreHeader;
  TBitmapCoreHeader = record
    bcSize: Longint;              { used to get to color table }
    bcWidth: Word;
    bcHeight: Word;
    bcPlanes: Word;
    bcBitCount: Word;
  end;

type
  PBitmapInfoHeader = ^TBitmapInfoHeader;
  TBitmapInfoHeader = record
    biSize: Longint;
    biWidth: Longint;
    biHeight: Longint;
    biPlanes: Word;
    biBitCount: Word;
    biCompression: Longint;
    biSizeImage: Longint;
    biXPelsPerMeter: Longint;
    biYPelsPerMeter: Longint;
    biClrUsed: Longint;
    biClrImportant: Longint;
  end;

{ Constants for the biCompression field }

const
  bi_RGB  = 0;
  bi_RLE8 = 1;
  bi_RLE4 = 2;

type
  PBitmapInfo = ^TBitmapInfo;
  TBitmapInfo = record
    bmiHeader: TBitmapInfoHeader;
    bmiColors: array[0..0] of TRGBQuad;
  end;

type
  PBitmapCoreInfo = ^TBitmapCoreInfo;
  TBitmapCoreInfo = record
    bmciHeader: TBitmapCoreHeader;
    bmciColors: array[0..0] of TRGBTriple;
  end;

type
  PBitmapFileHeader = ^TBitmapFileHeader;
  TBitmapFileHeader = record
    bfType: Word;
    bfSize: Longint;
    bfReserved1: Word;
    bfReserved2: Word;
    bfOffBits: Longint;
  end;


{ Clipboard Metafile Picture Structure }

type
  PHandleTable = ^THandleTable;
  THandleTable = record
    objectHandle: array[0..0] of THandle;
  end;

type
  PMetaRecord = ^TMetaRecord;
  TMetaRecord = record
    rdSize: Longint;
    rdFunction: Word;
    rdParm: array[0..0] of Word;
  end;

  PMetaHeader = ^TMetaHeader;
  TMetaHeader = record
    mtType : Word;
    mtHeaderSize : Word;
    mtVersion : Word;
    mtSize : Longint;
    mtNoObjects : Word;
    mtMaxRecord : Longint;
    mtNoParameters : Word;
  end;

type
  PMetaFilePict = ^TMetaFilePict;
  TMetaFilePict = record
    mm: Integer;
    xExt: Integer;
    yExt: Integer;
    hMF: THandle;
  end;

type
  PTextMetric = ^TTextMetric;
  TTextMetric = record
    tmHeight: Integer;
    tmAscent: Integer;
    tmDescent: Integer;
    tmInternalLeading: Integer;
    tmExternalLeading: Integer;
    tmAveCharWidth: Integer;
    tmMaxCharWidth: Integer;
    tmWeight: Integer;
    tmItalic: Byte;
    tmUnderlined: Byte;
    tmStruckOut: Byte;
    tmFirstChar: Byte;
    tmLastChar: Byte;
    tmDefaultChar: Byte;
    tmBreakChar: Byte;
    tmPitchAndFamily: Byte;
    tmCharSet: Byte;
    tmOverhang: Integer;
    tmDigitizedAspectX: Integer;
    tmDigitizedAspectY: Integer;
  end;

{ GDI Logical Objects }

{ Pel Array }

type
  PPelArray = ^TPelArray;
  TPelArray = record
    paXCount: Integer;
    paYCount: Integer;
    paXExt: Integer;
    paYExt: Integer;
    paRGBs: Byte;
  end;

{ Logical Brush (or Pattern) }

type
  PLogBrush = ^TLogBrush;
  TLogBrush = record
    lbStyle: Word;
    lbColor: Longint;
    lbHatch: Integer;
  end;

type
  PPattern = ^TPattern;
  TPattern = TLogBrush;

{ Logical Pen }

type
  PLogPen = ^TLogPen;
  TLogPen = record
    lopnStyle: Word;
    lopnWidth: TPoint;
    lopnColor: Longint;
  end;

type
  PPaletteEntry = ^TPaletteEntry;
  TPaletteEntry = record
    peRed: Byte;
    peGreen: Byte;
    peBlue: Byte;
    peFlags: Byte;
  end;

{ Logical Palette }

type
  PLogPalette = ^TLogPalette;
  TLogPalette = record
    palVersion: Word;
    palNumEntries: Word;
    palPalEntry: array[0..0] of TPaletteEntry;
  end;

{ Logical Font }

const
  lf_FaceSize = 32;

type
  PLogFont = ^TLogFont;
  TLogFont = record
    lfHeight: Integer;
    lfWidth: Integer;
    lfEscapement: Integer;
    lfOrientation: Integer;
    lfWeight: Integer;
    lfItalic: Byte;
    lfUnderline: Byte;
    lfStrikeOut: Byte;
    lfCharSet: Byte;
    lfOutPrecision: Byte;
    lfClipPrecision: Byte;
    lfQuality: Byte;
    lfPitchAndFamily: Byte;
    lfFaceName: array[0..lf_FaceSize - 1] of Char;
  end;

const
  out_Default_Precis   = 0;
  out_String_Precis    = 1;
  out_Character_Precis = 2;
  out_Stroke_Precis    = 3;

const
  clip_Default_Precis   = 0;
  clip_Character_Precis = 1;
  clip_Stroke_Precis    = 2;

const
  Default_Quality = 0;
  Draft_Quality   = 1;
  Proof_Quality   = 2;

const
  Default_Pitch  = 0;
  Fixed_Pitch    = 1;
  Variable_Pitch = 2;

const
  Ansi_CharSet     = 0;
  Symbol_CharSet   = 2;
  ShiftJIS_CharSet = 128;
  OEM_CharSet      = 255;

{ Font Families }

const
  ff_DontCare   = 0 shl 4;  { Don't care or don't know. }
  ff_Roman      = 1 shl 4;  { Variable stroke width, serifed. }
                            { Times Roman, Century Schoolbook, etc. }
  ff_Swiss      = 2 shl 4;  { Variable stroke width, sans-serifed. }
                            { Helvetica, Swiss, etc. }
  ff_Modern     = 3 shl 4;  { Constant stroke width, serifed or sans-serifed. }
                            { Pica, Elite, Courier, etc. }
  ff_Script     = 4 shl 4;  { Cursive, etc. }
  ff_Decorative = 5 shl 4;  { Old English, etc. }

{ Font Weights }

const
  fw_DontCare   = 0;
  fw_Thin       = 100;
  fw_ExtraLight = 200;
  fw_Light      = 300;
  fw_Normal     = 400;
  fw_Medium     = 500;
  fw_SemiBold   = 600;
  fw_Bold       = 700;
  fw_ExtraBold  = 800;
  fw_Heavy      = 900;

const
  fw_UltraLight = fw_ExtraLight;
  fw_Regular    = fw_Normal;
  fw_DemiBold   = fw_SemiBold;
  fw_UltraBold  = fw_ExtraBold;
  fw_Black      = fw_Heavy;

{ EnumFonts Masks }

const
  Raster_FontType = $0001;
  Device_FontType = $0002;


{ Background Modes }

const
  Transparent = 1;
  Opaque      = 2;

{ Mapping Modes }

const
  mm_Text        = 1;
  mm_LoMetric    = 2;
  mm_HiMetric    = 3;
  mm_LoEnglish   = 4;
  mm_HiEnglish   = 5;
  mm_TWIPS       = 6;
  mm_Isotropic   = 7;
  mm_Anisotropic = 8;

{ Coordinate Modes }

const
  Absolute = 1;
  Relative = 2;

{ Stock Logical Objects }

const
  White_Brush         = 0;
  LtGray_Brush        = 1;
  Gray_Brush          = 2;
  DkGray_Brush        = 3;
  Black_Brush         = 4;
  Null_Brush          = 5;
  Hollow_Brush        = Null_Brush;
  White_Pen           = 6;
  Black_Pen           = 7;
  Null_Pen            = 8;
  OEM_Fixed_Font      = 10;
  ANSI_Fixed_Font     = 11;
  ANSI_Var_Font       = 12;
  System_Font         = 13;
  Device_Default_Font = 14;
  Default_Palette     = 15;
  System_Fixed_Font   = 16;

{ Brush Styles }

const
  bs_Solid      = 0;
  bs_Null       = 1;
  bs_Hollow     = bs_NULL;
  bs_Hatched    = 2;
  bs_Pattern    = 3;
  bs_Indexed    = 4;
  bs_DIBPattern = 5;

{ Hatch Styles }

const
  hs_Horizontal = 0;       { ----- }
  hs_Vertical   = 1;       { ||||| }
  hs_FDiagonal  = 2;       { ///// }
  hs_BDiagonal  = 3;       { \\\\\ }
  hs_Cross      = 4;       { +++++ }
  hs_DiagCross  = 5;       { xxxxx }

const
  ps_Solid       = 0;
  ps_Dash        = 1;      { ------- }
  ps_Dot         = 2;      { ....... }
  ps_DashDot     = 3;      { _._._._ }
  ps_DashDotDot  = 4;      { _.._.._ }
  ps_Null        = 5;
  ps_InsideFrame = 6;

{ Device Parameters for GetDeviceCaps }

const
  DriverVersion = 0;    { Device driver version                    }
  Technology    = 2;    { Device classification                    }
  HorzSize      = 4;    { Horizontal size in millimeters           }
  VertSize      = 6;    { Vertical size in millimeters             }
  HorzRes       = 8;    { Horizontal width in pixels               }
  VertRes       = 10;   { Vertical width in pixels                 }
  BitsPixel     = 12;   { Number of bits per pixel                 }
  Planes        = 14;   { Number of planes                         }
  NumBrushes    = 16;   { Number of brushes the device has         }
  NumPens       = 18;   { Number of pens the device has            }
  NumMarkers    = 20;   { Number of markers the device has         }
  NumFonts      = 22;   { Number of fonts the device has           }
  NumColors     = 24;   { Number of colors the device supports     }
  PDeviceSize   = 26;   { Size required for device descriptor      }
  CurveCaps     = 28;   { Curve capabilities                       }
  LineCaps      = 30;   { Line capabilities                        }
  PolygonalCaps = 32;   { Polygonal capabilities                   }
  TextCaps      = 34;   { Text capabilities                        }
  ClipCaps      = 36;   { Clipping capabilities                    }
  RasterCaps    = 38;   { Bitblt capabilities                      }
  AspectX       = 40;   { Length of the X leg                      }
  AspectY       = 42;   { Length of the Y leg                      }
  AspectXY      = 44;   { Length of the hypotenuse                 }
  LogPixelsX    = 88;   { Logical pixels/inch in X                 }
  LogPixelsY    = 90;   { Logical pixels/inch in Y                 }
  SizePalette   = 104;  { Number of entries in physical palette    }
  NumReserved   = 106;  { Number of reserved entries in palette    }
  ColorRes      = 108;  { Actual color resolution                  }

{ Device Capability Masks }

{ Device Technologies }

const
  dt_Plotter    = 0;   { Vector plotter                   }
  dt_RasDisplay = 1;   { Raster display                   }
  dt_RasPrinter = 2;   { Raster printer                   }
  dt_RasCamera  = 3;   { Raster camera                    }
  dt_CharStream = 4;   { Character-stream, PLP            }
  dt_MetaFile   = 5;   { Metafile, VDM                    }
  dt_DispFile   = 6;   { Display-file                     }

{ Curve Capabilities }

const
  cc_None       = 0;   { Curves not supported             }
  cc_Circles    = 1;   { Can do circles                   }
  cc_Pie        = 2;   { Can do pie wedges                }
  cc_Chord      = 4;   { Can do chord arcs                }
  cc_Ellipses   = 8;   { Can do ellipese                  }
  cc_Wide       = 16;  { Can do wide lines                }
  cc_Styled     = 32;  { Can do styled lines              }
  cc_WideStyled = 64;  { Can do wide styled lines         }
  cc_Interiors  = 128; { Can do interiors                 }

{ Line Capabilities }

const
  lc_None       = 0;   { Lines not supported              }
  lc_PolyLine   = 2;   { Can do polylines                 }
  lc_Marker     = 4;   { Can do markers                   }
  lc_PolyMarker = 8;   { Can do polymarkers               }
  lc_Wide       = 16;  { Can do wide lines                }
  lc_Styled     = 32;  { Can do styled lines              }
  lc_WideStyled = 64;  { Can do wide styled lines         }
  lc_Interiors  = 128; { Can do interiors                 }

{ Polygonal Capabilities }

const
  pc_None       = 0;   { Polygonals not supported         }
  pc_Polygon    = 1;   { Can do polygons                  }
  pc_Rectangle  = 2;   { Can do rectangles                }
  pc_WindPolygon = 4;  { Can do winding polygons          }
  pc_Trapezoid  = 4;   { Can do trapezoids                }
  pc_ScanLine   = 8;   { Can do scanlines                 }
  pc_Wide       = 16;  { Can do wide borders              }
  pc_Styled     = 32;  { Can do styled borders            }
  pc_WideStyled = 64;  { Can do wide styled borders       }
  pc_Interiors  = 128; { Can do interiors                 }

{ Polygonal Capabilities }

const
  cp_None       = 0;   { No clipping of output            }
  cp_Rectangle  = 1;   { Output clipped to rects          }

{ Text Capabilities }

const
  tc_op_Character = $0001;  { Can do OutputPrecision   CHARACTER      }
  tc_op_Stroke    = $0002;  { Can do OutputPrecision   STROKE         }
  tc_cp_Stroke    = $0004;  { Can do ClipPrecision     STROKE         }
  tc_cr_90        = $0008;  { Can do CharRotAbility    90             }
  tc_cr_Any       = $0010;  { Can do CharRotAbility    ANY            }
  tc_sf_X_YIndep  = $0020;  { Can do ScaleFreedom      X_YINDEPENDENT }
  tc_sa_Double    = $0040;  { Can do ScaleAbility      DOUBLE         }
  tc_sa_Integer   = $0080;  { Can do ScaleAbility      INTEGER        }
  tc_sa_Contin    = $0100;  { Can do ScaleAbility      CONTINUOUS     }
  tc_ea_Double    = $0200;  { Can do EmboldenAbility   DOUBLE         }
  tc_ia_Able      = $0400;  { Can do ItalisizeAbility  ABLE           }
  tc_ua_Able      = $0800;  { Can do UnderlineAbility  ABLE           }
  tc_so_Able      = $1000;  { Can do StrikeOutAbility  ABLE           }
  tc_ra_Able      = $2000;  { Can do RasterFontAble    ABLE           }
  tc_va_Able      = $4000;  { Can do VectorFontAble    ABLE           }
  tc_Reserved     = $8000;

{ Raster Capabilities }

const
  rc_BitBlt       = $0001;      { Can do standard Blt.            }
  rc_Banding      = $0002;      { Device requires banding support }
  rc_Scaling      = $0004;      { Device requires scaling support }
  rc_Bitmap64     = $0008;      { Device can support >64K bitmap  }
  rc_GDI20_Output = $0010;      { has 2.0 output calls            }
  rc_Di_Bitmap    = $0080;      { supports DIB to memory          }
  rc_Palette      = $0100;      { supports a palette              }
  rc_DIBToDev     = $0200;      { supports DIBitsToDevice         }
  rc_BigFont      = $0400;      { supports >64K fonts             }
  rc_StretchBlt   = $0800;      { supports StretchBlt             }
  rc_FloodFill    = $1000;      { supports FloodFill              }
  rc_StretchDIB   = $2000;      { supports StretchDIBits          }
{ Palette entry flags }

const
  pc_Reserved = $01;    { palette index used for animation }
  pc_Explicit = $02;    { palette index is explicit to device }
  pc_NoCollapse = $04;   { do not match color to system palette }

{ DIB color table identifiers }

const
  DIB_RGB_Colors = 0;       { color table in RGBTriples }
  DIB_Pal_Colors = 1;       { color table in palette indices }

{ Constants for Get/SetSystemPaletteUse }

const
  syspal_Static   = 1;
  syspal_NoStatic = 2;

{ constants for CreateDIBitmap }

const
  cbm_Init  = $04;    { initialize bitmap }


{ Indices in FontMapperWeights array }

const
  PCharSet           = 0;
  POutPrecisMismatch = 1;
  PPitchFixed        = 2;
  PFaceName          = 3;
  PFamily            = 4;
  PFamilyUnknown     = 5;
  PHeightBigger      = 6;
  PPitchVariable     = 7;
  PFHeightSmaller    = 8;
  PFHeightBigger     = 9;
  PFWidth            = 10;
  PSizeSynth         = 11;
  PFUnevenSizeSynth  = 12;
  PFIntSizeSynth     = 13;
  PFAspect           = 14;
  PItalic            = 15;
  PFWeight           = 16;
  PUnderline         = 17;
  PStrikeOut         = 18;
  PDefaultPitchFixed = 19;
  PFVHeightSmaller   = 20;
  PFVHeightBigger    = 21;
  DeviceFavor        = 22;
  PFWeightNumer      = 23;
  PFWeightDenom      = 24;

{ DrawText Format Flags }

const
  dt_Top             = $0000;
  dt_Left            = $0000;
  dt_Center          = $0001;
  dt_Right           = $0002;
  dt_VCenter         = $0004;
  dt_Bottom          = $0008;
  dt_WordBreak       = $0010;
  dt_SingleLine      = $0020;
  dt_ExpandTabs      = $0040;
  dt_TabStop         = $0080;
  dt_NoClip          = $0100;
  dt_ExternalLeading = $0200;
  dt_CalcRect        = $0400;
  dt_NoPrefix        = $0800;
  dt_Internal        = $1000;

{ ExtFloodFill style flags }

const
  FloodFillBorder  = 0;
  FloodFillSurface = 1;

{--------------------------------------------------------------------------}
{      USER Section                                                        }
{--------------------------------------------------------------------------}

{ Scroll Bar Constants }

const
  sb_HORZ = 0;
  sb_VERT = 1;
  sb_CTL  = 2;
  sb_BOTH = 3;

{ Scroll Bar Commands }

const
  sb_LineUp        = 0;
  sb_LineDown      = 1;
  sb_PageUp        = 2;
  sb_PageDown      = 3;
  sb_ThumbPosition = 4;
  sb_ThumbTrack    = 5;
  sb_Top           = 6;
  sb_Bottom        = 7;
  sb_EndScroll     = 8;

{ ShowWindow Commands }

const
  sw_Hide            = 0;
  sw_ShowNormal      = 1;
  sw_Normal          = 1;
  sw_ShowMinimized   = 2;
  sw_ShowMaximized   = 3;
  sw_Maximize        = 3;
  sw_ShowNoActivate  = 4;
  sw_Show            = 5;
  sw_Minimize        = 6;
  sw_ShowMinNoActive = 7;
  sw_ShowNA          = 8;
  sw_Restore         = 9;

{ Old ShowWindow Commands }

const
  hide_Window         = 0;
  show_OpenWindow     = 1;
  show_IconWindow     = 2;
  show_FullScreen     = 3;
  show_OpenNoActivate = 4;

{ Identifiers for the wm_ShowWindow message }

const
  sw_ParentClosing = 1;
  sw_OtherZoom     = 2;
  sw_ParentOpening = 3;
  sw_OtherUnzoom   = 4;

{ Region Flags }

const
  Error         = 0;
  NullRegion    = 1;
  SimpleRegion  = 2;
  ComplexRegion = 3;

{ CombineRgn Styles }

const
  Rgn_And  = 1;
  Rgn_Or   = 2;
  Rgn_Xor  = 3;
  Rgn_Diff = 4;
  Rgn_Copy = 5;

{ Virtual Keys, Standard Set }

const
  vk_LButton   = $01;
  vk_RButton   = $02;
  vk_Cancel    = $03;
  vk_MButton   = $04;   { NOT contiguous with L & RBUTTON }
  vk_Back      = $08;
  vk_Tab       = $09;
  vk_Clear     = $0C;
  vk_Return    = $0D;
  vk_Shift     = $10;
  vk_Control   = $11;
  vk_Menu      = $12;
  vk_Pause     = $13;
  vk_Capital   = $14;
  vk_Escape    = $1B;
  vk_Space     = $20;
  vk_Prior     = $21;
  vk_Next      = $22;
  vk_End       = $23;
  vk_Home      = $24;
  vk_Left      = $25;
  vk_Up        = $26;
  vk_Right     = $27;
  vk_Down      = $28;
  vk_Select    = $29;
  vk_Print     = $2A;
  vk_Execute   = $2B;
  vk_SnapShot  = $2C;
{ vk_Copy      = $2C not used by keyboards }
  vk_Insert    = $2D;
  vk_Delete    = $2E;
  vk_Help      = $2F;
{ vk_A thru vk_Z are the same as their ASCII equivalents: 'A' thru 'Z' }
{ vk_0 thru vk_9 are the same as their ASCII equivalents: '0' thru '9' }
  vk_NumPad0   = $60;
  vk_NumPad1   = $61;
  vk_NumPad2   = $62;
  vk_NumPad3   = $63;
  vk_NumPad4   = $64;
  vk_NumPad5   = $65;
  vk_NumPad6   = $66;
  vk_NumPad7   = $67;
  vk_NumPad8   = $68;
  vk_NumPad9   = $69;
  vk_Multiply  = $6A;
  vk_Add       = $6B;
  vk_Separator = $6C;
  vk_Subtract  = $6D;
  vk_Decimal   = $6E;
  vk_Divide    = $6F;
  vk_F1        = $70;
  vk_F2        = $71;
  vk_F3        = $72;
  vk_F4        = $73;
  vk_F5        = $74;
  vk_F6        = $75;
  vk_F7        = $76;
  vk_F8        = $77;
  vk_F9        = $78;
  vk_F10       = $79;
  vk_F11       = $7A;
  vk_F12       = $7B;
  vk_F13       = $7C;
  vk_F14       = $7D;
  vk_F15       = $7E;
  vk_F16       = $7F;
  vk_NumLock   = $90;

{ SetWindowsHook codes }

const
  wh_MsgFilter       = (-1);
  wh_JournalRecord   = 0;
  wh_JournalPlayback = 1;
  wh_Keyboard        = 2;
  wh_GetMessage      = 3;
  wh_CallWndProc     = 4;
  wh_CBT             = 5;
  wh_SysMsgFilter    = 6;
  wh_WindowMgr       = 7;

{ Hook Codes }

const
  hc_LPLPFnNext  = (-2);
  hc_LPFnNext    = (-1);
  hc_Action      = 0;
  hc_GetNext     = 1;
  hc_Skip        = 2;
  hc_NoRem       = 3;
  hc_NoRemove    = 3;
  hc_SysModalOn  = 4;
  hc_SysModalOff = 5;

{ CBT Hook Codes }

const
  hcbt_MoveSize = 0;
  hcbt_MinMax   = 1;
  hcbt_QS       = 2;

{ wh_MSGFILTER Filter Proc Codes }

const
  msgf_DialogBox  = 0;
  msgf_MessageBox = 1;
  msgf_Menu       = 2;
  msgf_Move       = 3;
  msgf_Size       = 4;
  msgf_ScrollBar  = 5;
  msgf_NextWindow = 6;

{ Window Manager Hook Codes }

const
  wc_Init          = 1;
  wc_SWP           = 2;
  wc_DefWindowProc = 3;
  wc_MinMax        = 4;
  wc_Move          = 5;
  wc_Size          = 6;
  wc_DrawCaption   = 7;

{ Message Structure used in Journaling }

type
  PEventMsg = ^TEventMsg;
  TEventMsg = record
    message: Word;
    paramL: Word;
    paramH: Word;
    time: Longint;
  end;

type
  PWndClass = ^TWndClass;
  TWndClass = record
    style: Word;
    lpfnWndProc: TFarProc;
    cbClsExtra: Integer;
    cbWndExtra: Integer;
    hInstance: THandle;
    hIcon: HIcon;                       { Name clash }
    hCursor: HCursor;                   { Name clash }
    hbrBackground: HBrush;
    lpszMenuName: PChar;
    lpszClassName: PChar;
  end;

{ Message structure }

type
  PMsg = ^TMsg;
  TMsg = record
    hwnd: HWnd;
    message: Word;
    wParam: Word;
    lParam: LongInt;
    time: Longint;
    pt: TPoint;
  end;

{ Window field offsets for GetWindowLong and GetWindowWord }

const
  gwl_WndProc    = (-4);
  gww_HInstance  = (-6);
  gww_HWndParent = (-8);
  gww_ID         = (-12);
  gwl_Style      = (-16);
  gwl_EXStyle    = (-20);

{ Class field offsets for GetClassLong and GetClassWord }

const
  gcl_MenuName      = (-8);
  gcw_HBRBackGround = (-10);
  gcw_HCursor       = (-12);
  gcw_HIcon         = (-14);
  gcw_HModule       = (-16);
  gcw_CBWndExtra    = (-18);
  gcw_CBClsExtra    = (-20);
  gcl_WndProc       = (-24);
  gcw_Style         = (-26);

{ Window Messages }

const
  wm_Null             = $0000;
  wm_Create           = $0001;
  wm_Destroy          = $0002;
  wm_Move             = $0003;
  wm_Size             = $0005;
  wm_Activate         = $0006;
  wm_SetFocus         = $0007;
  wm_KillFocus        = $0008;
  wm_Enable           = $000A;
  wm_SetRedraw        = $000B;
  wm_SetText          = $000C;
  wm_GetText          = $000D;
  wm_GetTextLength    = $000E;
  wm_Paint            = $000F;
  wm_Close            = $0010;
  wm_QueryEndSession  = $0011;
  wm_Quit             = $0012;
  wm_QueryOpen        = $0013;
  wm_EraseBkGnd       = $0014;
  wm_SysColorChange   = $0015;
  wm_EndSession       = $0016;
  wm_ShowWindow       = $0018;
  wm_CtlColor         = $0019;
  wm_WinIniChange     = $001A;
  wm_DevModeChange    = $001B;
  wm_ActivateApp      = $001C;
  wm_FontChange       = $001D;
  wm_TimeChange       = $001E;
  wm_CancelMode       = $001F;
  wm_SetCursor        = $0020;
  wm_MouseActivate    = $0021;
  wm_ChildActivate    = $0022;
  wm_QueueSync        = $0023;
  wm_GetMinMaxInfo    = $0024;
  wm_PaintIcon        = $0026;
  wm_IconEraseBkGnd   = $0027;
  wm_NextDlgCtl       = $0028;
  wm_SpoolerStatus    = $002A;
  wm_DrawItem         = $002B;
  wm_MeasureItem      = $002C;
  wm_DeleteItem       = $002D;
  wm_VKeyToItem       = $002E;
  wm_CharToItem       = $002F;
  wm_SetFont          = $0030;
  wm_GetFont          = $0031;
  wm_QueryDragIcon    = $0037;
  wm_CompareItem      = $0039;
  wm_Compacting       = $0041;

  wm_NCCreate         = $0081;
  wm_NCDestroy        = $0082;
  wm_NCCalcSize       = $0083;
  wm_NCHitTest        = $0084;
  wm_NCPaint          = $0085;
  wm_NCActivate       = $0086;
  wm_GetDlgCode       = $0087;
  wm_NCMouseMove      = $00A0;
  wm_NCLButtonDown    = $00A1;
  wm_NCLButtonUp      = $00A2;
  wm_NCLButtonDblClk  = $00A3;
  wm_NCRButtonDown    = $00A4;
  wm_NCRButtonUp      = $00A5;
  wm_NCRButtonDblClk  = $00A6;
  wm_NCMButtonDown    = $00A7;
  wm_NCMButtonUp      = $00A8;
  wm_NCMButtonDblClk  = $00A9;

  wm_KeyFirst         = $0100;
  wm_KeyDown          = $0100;
  wm_KeyUp            = $0101;
  wm_Char             = $0102;
  wm_DeadChar         = $0103;
  wm_SysKeyDown       = $0104;
  wm_SysKeyUp         = $0105;
  wm_SysChar          = $0106;
  wm_SysDeadChar      = $0107;
  wm_KeyLast          = $0108;

  wm_InitDialog       = $0110;
  wm_Command          = $0111;
  wm_SysCommand       = $0112;
  wm_Timer            = $0113;
  wm_HScroll          = $0114;
  wm_VScroll          = $0115;
  wm_InitMenu         = $0116;
  wm_InitMenuPopup    = $0117;
  wm_MenuSelect       = $011F;
  wm_MenuChar         = $0120;
  wm_EnterIdle        = $0121;


  wm_MouseFirst       = $0200;
  wm_MouseMove        = $0200;
  wm_LButtonDown      = $0201;
  wm_LButtonUp        = $0202;
  wm_LButtonDblClk    = $0203;
  wm_RButtonDown      = $0204;
  wm_RButtonUp        = $0205;
  wm_RButtonDblClk    = $0206;
  wm_MButtonDown      = $0207;
  wm_MButtonUp        = $0208;
  wm_MButtonDblClk    = $0209;
  wm_MouseLast        = $0209;

  wm_ParentNotify     = $0210;
  wm_MDICreate        = $0220;
  wm_MDIDestroy       = $0221;
  wm_MDIActivate      = $0222;
  wm_MDIRestore       = $0223;
  wm_MDINext          = $0224;
  wm_MDIMaximize      = $0225;
  wm_MDITile          = $0226;
  wm_MDICascade       = $0227;
  wm_MDIIconArrange   = $0228;
  wm_MDIGetActive     = $0229;
  wm_MDISetMenu       = $0230;


  wm_Cut              = $0300;
  wm_Copy             = $0301;
  wm_Paste            = $0302;
  wm_Clear            = $0303;
  wm_Undo             = $0304;
  wm_RenderFormat     = $0305;
  wm_RenderAllFormats = $0306;
  wm_DestroyClipboard = $0307;
  wm_DrawClipboard    = $0308;
  wm_PaintClipboard   = $0309;
  wm_VScrollClipboard = $030A;
  wm_SizeClipboard    = $030B;
  wm_AskCBFormatName  = $030C;
  wm_ChangeCBChain    = $030D;
  wm_HScrollClipboard = $030E;
  wm_QueryNewPalette  = $030F;
  wm_PaletteIsChanging = $0310;
  wm_PaletteChanged   = $0311;

{ NOTE: All Message Numbers below 0x0400 are RESERVED }

{ Private Window Messages Start Here }

  wm_User             = $0400;

{ wm_SYNCTASK Commands }

const
  st_BeginSwp = 0;
  st_EndSwp   = 1;

{ WinWhere Area Codes }

const
  htError       = (-2);
  htTransparent = (-1);
  htNoWhere     = 0;
  htClient      = 1;
  htCaption     = 2;
  htSysMenu     = 3;
  htGrowBox     = 4;
  htSize        = htGrowBox;
  htMenu        = 5;
  htHScroll     = 6;
  htVScroll     = 7;
  htReduce      = 8;
  htZoom        = 9;
  htLeft        = 10;
  htRight       = 11;
  htTop         = 12;
  htTopLeft     = 13;
  htTopRight    = 14;
  htBottom      = 15;
  htBottomLeft  = 16;
  htBottomRight = 17;
  htSizeFirst   = htLeft;
  htSizeLast    = htBottomRight;

{ wm_MouseActivate Return Codes }

const
  ma_Activate       = 1;
  ma_ActivateAndEat = 2;
  ma_NoActivate     = 3;

{ Size Message Commands }

const
  sizeNormal     = 0;
  sizeIconic     = 1;
  sizeFullScreen = 2;
  sizeZoomShow   = 3;
  sizeZoomHide   = 4;

{ Key State Masks for Mouse Messages }

const
  mk_LButton = $0001;
  mk_RButton = $0002;
  mk_Shift   = $0004;
  mk_Control = $0008;
  mk_MButton = $0010;

{ Window Styles }

const
  ws_Overlapped   = $00000000;
  ws_Popup        = $80000000;
  ws_Child        = $40000000;
  ws_Minimize     = $20000000;
  ws_Visible      = $10000000;
  ws_Disabled     = $08000000;
  ws_ClipSiblings = $04000000;
  ws_ClipChildren = $02000000;
  ws_Maximize     = $01000000;
  ws_Caption      = $00C00000;    { ws_Border + ws_DlgFrame }
  ws_Border       = $00800000;
  ws_DlgFrame     = $00400000;
  ws_VScroll      = $00200000;
  ws_HScroll      = $00100000;
  ws_SysMenu      = $00080000;
  ws_ThickFrame   = $00040000;
  ws_Group        = $00020000;
  ws_TabStop      = $00010000;

const
  ws_MinimizeBox = $00020000;
  ws_MaximizeBox = $00010000;

const
  ws_Tiled   = ws_Overlapped;
  ws_Iconic  = ws_Minimize;
  ws_SizeBox = ws_ThickFrame;

{ Common Window Styles }

const
  ws_OverlappedWindow = ws_Overlapped + ws_Caption + ws_SysMenu +
                        ws_ThickFrame + ws_MinimizeBox + ws_MaximizeBox;
  ws_PopupWindow      = ws_Popup + ws_Border + ws_SysMenu;
  ws_ChildWindow      = ws_Child;
  ws_TiledWindow      = ws_OverlappedWindow;

{ Extended Window Styles }

const
  ws_ex_DlgModalFrame  = $00000001;
  ws_ex_NoParentNotify = $00000004;

{ Class styles }

const
  cs_VRedraw         = $0001;
  cs_HRedraw         = $0002;
  cs_KeyCvtWindow    = $0004;
  cs_DblClks         = $0008;
  cs_OwnDC           = $0020;
  cs_ClassDC         = $0040;
  cs_ParentDC        = $0080;
  cs_NoKeyCvt        = $0100;
  cs_NoClose         = $0200;
  cs_SaveBits        = $0800;
  cs_ByteAlignClient = $1000;
  cs_ByteAlignWindow = $2000;
  cs_GlobalClass     = $4000;   { Global window class }

{ Predefined Clipboard Formats }

const
  cf_Text         = 1;
  cf_Bitmap       = 2;
  cf_MetaFilePict = 3;
  cf_SYLK         = 4;
  cf_DIF          = 5;
  cf_TIFF         = 6;
  cf_OEMText      = 7;
  cf_DIB          = 8;
  cf_Palette      = 9;

const
  cf_OwnerDisplay    = $0080;
  cf_DSPText         = $0081;
  cf_DSPBitmap       = $0082;
  cf_DSPMetaFilePict = $0083;

{ "Private" formats don't get GlobalFree'd }

const
  cf_PrivateFirst = $0200;
  cf_PrivateLast  = $02FF;

{ "GDIOBJ" formats do get DeleteObject'd }

const
  cf_GDIObjFirst = $0300;
  cf_GDIObjLast  = $03FF;

type
  PPaintStruct = ^TPaintStruct;
  TPaintStruct = record
    hdc: HDC;
    fErase: Bool;
    rcPaint: TRect;
    fRestore: Bool;
    fIncUpdate: Bool;
    rgbReserved: array[0..15] of Byte;
  end;

type
  PCreateStruct = ^TCreateStruct;
  TCreateStruct = record
    lpCreateParams: PChar;
    hInstance: THandle;
    hMenu: THandle;
    hwndParent: HWnd;
    cy: Integer;
    cx: Integer;
    y: Integer;
    x: Integer;
    style: LongInt;
    lpszName: PChar;
    lpszClass: PChar;
    dwExStyle: Longint;
  end;

{ Owner draw control types }

const
  odt_Menu     = 1;
  odt_ListBox  = 2;
  odt_ComboBox = 3;
  odt_Button   = 4;

{ Owner draw actions }

const
  oda_DrawEntire = $0001;
  oda_Select     = $0002;
  oda_Focus      = $0004;

{ Owner draw state }

const
  ods_Selected = $0001;
  ods_Grayed   = $0002;
  ods_Disabled = $0004;
  ods_Checked  = $0008;
  ods_Focus    = $0010;

{ TMeasureItemStruct for ownerdraw }

type
  PMeasureItemStruct = ^TMeasureItemStruct;
  TMeasureItemStruct = record
    CtlType: Word;
    CtlID: Word;
    itemID: Word;
    itemWidth: Word;
    itemHeight: Word;
    itemData: Longint;
  end;

{ TDrawItemStruct for ownerdraw }

type
  PDrawItemStruct = ^TDrawItemStruct;
  TDrawItemStruct = record
    CtlType: Word;
    CtlID: Word;
    itemID: Word;
    itemAction: Word;
    itemState: Word;
    hwndItem: HWnd;
    hDC: HDC;
    rcItem: TRect;
    itemData: Longint;
  end;

{ TDeleteItemStruct for ownerdraw }
  
type
  PDeleteItemStruct = ^TDeleteItemStruct;
  TDeleteItemStruct = record
    CtlType: Word;
    CtlID: Word;
    itemID: Word;
    hwndItem: HWnd;
    itemData: Longint;
  end;

{ TCompareItemStruct for ownerdraw sorting }

type
  PCompareItemStruct = ^TCompareItemStruct;
  TCompareItemStruct = record
    CtlType: Word;
    CtlID: Word;
    hwndItem: HWnd;
    itemID1: Word;
    itemData1: Longint;
    itemID2: Word;
    itemData2: Longint;
  end;

{ PeekMessage Options }

const
  pm_NoRemove = $0000;
  pm_Remove   = $0001;
  pm_NoYield  = $0002;

const
  cw_UseDefault = Integer($8000);

{ SetWindowPos Flags }

const
  swp_NoSize       = $0001;
  swp_NoMove       = $0002;
  swp_NoZOrder     = $0004;
  swp_NoRedraw     = $0008;
  swp_NoActivate   = $0010;
  swp_DrawFrame    = $0020;
  swp_ShowWindow   = $0040;
  swp_HideWindow   = $0080;
  swp_NoCopyBits   = $0100;
  swp_NoReposition = $0200;

const
  DlgWindowExtra = 30;  { Window extra byted for private dialog classes }

{ GetSystemMetrics codes }

const
  sm_CXScreen      = 0;
  sm_CYScreen      = 1;
  sm_CXVScroll     = 2;
  sm_CYHScroll     = 3;
  sm_CYCaption     = 4;
  sm_CXBorder      = 5;
  sm_CYBorder      = 6;
  sm_CXDlgFrame    = 7;
  sm_CYDlgFrame    = 8;
  sm_CYVThumb      = 9;
  sm_CXHThumb      = 10;
  sm_CXIcon        = 11;
  sm_CYIcon        = 12;
  sm_CXCursor      = 13;
  sm_CYCursor      = 14;
  sm_CYMenu        = 15;
  sm_CXFullScreen  = 16;
  sm_CYFullScreen  = 17;
  sm_CYKanjiWindow = 18;
  sm_MousePresent  = 19;
  sm_CYVScroll     = 20;
  sm_CXHScroll     = 21;
  sm_Debug         = 22;
  sm_SwapButton    = 23;
  sm_Reserved1     = 24;
  sm_Reserved2     = 25;
  sm_Reserved3     = 26;
  sm_Reserved4     = 27;
  sm_CXMin         = 28;
  sm_CYMin         = 29;
  sm_CXSize        = 30;
  sm_CYSize        = 31;
  sm_CXFrame       = 32;
  sm_CYFrame       = 33;
  sm_CXMinTrack    = 34;
  sm_CYMinTrack    = 35;
  sm_CMetrics      = 36;

{ MessageBox Flags }

const
  mb_Ok               = $0000;
  mb_OkCancel         = $0001;
  mb_AbortRetryIgnore = $0002;
  mb_YesNoCancel      = $0003;
  mb_YesNo            = $0004;
  mb_RetryCancel      = $0005;

  mb_IconHand         = $0010;
  mb_IconQuestion     = $0020;
  mb_IconExclamation  = $0030;
  mb_IconAsterisk     = $0040;

  mb_IconInformation  = mb_IconAsterisk;
  mb_IconStop         = mb_IconHand;

  mb_DefButton1       = $0000;
  mb_DefButton2       = $0100;
  mb_DefButton3       = $0200;

  mb_ApplModal        = $0000;
  mb_SystemModal      = $1000;
  mb_TaskModal        = $2000;

  mb_NoFocus          = $8000;

  mb_TypeMask         = $000F;
  mb_IconMask         = $00F0;
  mb_DefMask          = $0F00;
  mb_ModeMask         = $3000;
  mb_MiscMask         = $C000;

{ Color Types }

const
  ctlcolor_MsgBox    = 0;
  ctlcolor_Edit      = 1;
  ctlcolor_ListBox   = 2;
  ctlcolor_Btn       = 3;
  ctlcolor_Dlg       = 4;
  ctlcolor_ScrollBar = 5;
  ctlcolor_Static    = 6;
  ctlcolor_Max       = 8;    { three bits max }

const
  color_ScrollBar       = 0;
  color_Background      = 1;
  color_ActiveCaption   = 2;
  color_InactiveCaption = 3;
  color_Menu            = 4;
  color_Window          = 5;
  color_WindowFrame     = 6;
  color_MenuText        = 7;
  color_WindowText      = 8;
  color_CaptionText     = 9;
  color_ActiveBorder    = 10;
  color_InactiveBorder  = 11;
  color_AppWorkSpace    = 12;
  color_Highlight       = 13;
  color_HighlightText   = 14;
  color_BtnFace         = 15;
  color_BtnShadow       = 16;
  color_GrayText        = 17;
  color_BtnText         = 18;
  color_EndColors       = color_BtnText;
{ GetWindow Constants }

const
  gw_HWndFirst = 0;
  gw_HWndLast  = 1;
  gw_HWndNext  = 2;
  gw_HWndPrev  = 3;
  gw_Owner     = 4;
  gw_Child     = 5;

{ Menu flags for Add/Check/EnableMenuItem }

const
  mf_Insert          = $0000;
  mf_Change          = $0080;
  mf_Append          = $0100;
  mf_Delete          = $0200;
  mf_Remove          = $1000;

  mf_ByCommand       = $0000;
  mf_ByPosition      = $0400;

  mf_Separator       = $0800;

  mf_Enabled         = $0000;
  mf_Grayed          = $0001;
  mf_Disabled        = $0002;

  mf_Unchecked       = $0000;
  mf_Checked         = $0008;
  mf_UseCheckBitmaps = $0200;

  mf_String          = $0000;
  mf_Bitmap          = $0004;
  mf_OwnerDraw       = $0100;

  mf_Popup           = $0010;
  mf_MenuBarBreak    = $0020;
  mf_MenuBreak       = $0040;

  mf_Unhilite        = $0000;
  mf_Hilite          = $0080;

  mf_SysMenu         = $2000;
  mf_Help            = $4000;
  mf_MouseSelect     = $8000;

type
  TMenuItemTemplateHeader = record
    versionNumber: Word;
    offset: Word;
  end;

  TMenuItemTemplate = record
    mtOption: Word;
    mtID: Word;
    mtString: array[0..0] of Char;
  end;

const
  mf_End = $0080;

{ System Menu Command Values }

const
  sc_Size       = $F000;
  sc_Move       = $F010;
  sc_Minimize   = $F020;
  sc_Maximize   = $F030;
  sc_NextWindow = $F040;
  sc_PrevWindow = $F050;
  sc_Close      = $F060;
  sc_VScroll    = $F070;
  sc_HScroll    = $F080;
  sc_MouseMenu  = $F090;
  sc_KeyMenu    = $F100;
  sc_Arrange    = $F110;
  sc_Restore    = $F120;
  sc_TaskList   = $F130;

  sc_Icon       = sc_Minimize;
  sc_Zoom       = sc_Maximize;

{ Standard Cursor IDs }

const
  idc_Arrow    = MakeIntResource(32512);
  idc_IBeam    = MakeIntResource(32513);
  idc_Wait     = MakeIntResource(32514);
  idc_Cross    = MakeIntResource(32515);
  idc_UPArrow  = MakeIntResource(32516);
  idc_Size     = MakeIntResource(32640);
  idc_Icon     = MakeIntResource(32641);
  idc_SizeNWSE = MakeIntResource(32642);
  idc_SizeNESW = MakeIntResource(32643);
  idc_SizeWE   = MakeIntResource(32644);
  idc_SizeNS   = MakeIntResource(32645);

const
  ord_LangDriver = 1;  { Ordinal number of entry point of language drivers }

{ Standard Icon IDs }

const
  idi_Application = MakeIntResource(32512);
  idi_Hand        = MakeIntResource(32513);
  idi_Question    = MakeIntResource(32514);
  idi_Exclamation = MakeIntResource(32515);
  idi_Asterisk    = MakeIntResource(32516);

const
  cp_HWnd   = 0;
  cp_Open   = 1;
  cp_Direct = 2;

{ VK from the keyboard driver }

const
  vk_Kana     = $15;
  vk_Romaji   = $16;
  vk_Zenkaku  = $17;
  vk_Hiragana = $18;
  vk_Kanji    = $19;

{ VK to send to Applications }

const
  vk_Convert    = $1C;
  vk_NonConvert = $1D;
  vk_Accept     = $1E;
  vk_ModeChange = $1F;

const
  knj_Start       = $01;
  knj_End         = $02;
  knj_Query       = $03;

  knj_Learn_Mode  = $10;
  knj_GetMode     = $11;
  knj_SetMode     = $12;

  knj_CodeConvert = $20;
  knj_Convert     = $21;
  knj_Next        = $22;
  knj_Previous    = $23;
  knj_Accept      = $24;

  knj_Learn       = $30;
  knj_Register    = $31;
  knj_Remove      = $32;
  knj_Change_UDIC = $33;

{ NOTE: Default        = 0 }
{       JIS1           = 1 }
{       JIS2           = 2 }
{       SJIS2          = 3 }
{       JIS1Katakana   = 4 }
{       SJIS2Hiragana  = 5 }
{       SJIS2Katakana  = 6 }
{       OEM            = F }

const
  knj_JIS1toJIS1Katakana  = $14;
  knj_JIS1toSJIS2         = $13;
  knj_JIS1toSJIS2Hiragana = $15;
  knj_JIS1toSJIS2Katakana = $16;
  knj_JIS1toDefault       = $10;
  knj_JIS1toSJIS2OEM      = $1F;
  knj_JIS2toSJIS2         = $23;
  knj_SJIS2toJIS2         = $32;

  knj_md_Alpha            = $01;
  knj_md_Hiragana         = $02;
  knj_md_HALF             = $04;
  knj_md_JIS              = $08;
  knj_md_SPECIAL          = $10;

  knj_cvt_Next            = $01;
  knj_cvt_Prev            = $02;
  knj_cvt_Katakana        = $03;
  knj_cvt_Hiragana        = $04;
  knj_cvt_JIS1            = $05;
  knj_cvt_SJIS2           = $06;
  knj_cvt_Default         = $07;
  knj_cvt_Typed           = $08;

type
  PKanjiStruct = ^TKanjiStruct;
  TKanjiStruct = record
    fnc: Integer;
    wParam: Integer;
    lpSource: PChar;
    lpDest: PChar;
    wCount: Integer;
    lpReserved1: Pointer;
    lpReserved2: Pointer;
  end;

{ Dialog Box Command IDs }

const
  idOk     = 1;
  idCancel = 2;
  idAbort  = 3;
  idRetry  = 4;
  idIgnore = 5;
  idYes    = 6;
  idNo     = 7;

const
  id_Ok     = 1;
  id_Cancel = 2;
  id_Abort  = 3;
  id_Retry  = 4;
  id_Ignore = 5;
  id_Yes    = 6;
  id_No     = 7;

{ Control Manager Structures and Definitions }

{ Edit Control Styles }

const
  es_Left        = $0000;
  es_Center      = $0001;
  es_Right       = $0002;
  es_MultiLine   = $0004;
  es_UpperCase   = $0008;
  es_LowerCase   = $0010;
  es_Password    = $0020;
  es_AutoVScroll = $0040;
  es_AutoHScroll = $0080;
  es_NoHideSel   = $0100;
  es_OEMConvert  = $0400;

{ Edit Control Notification Codes }

const
  en_SetFocus  = $0100;
  en_KillFocus = $0200;
  en_Change    = $0300;
  en_Update    = $0400;
  en_ErrSpace  = $0500;
  en_MaxText   = $0501;
  en_HScroll   = $0601;
  en_VScroll   = $0602;

{ Edit Control Messages }

const
  em_GetSel          = (wm_User+0);
  em_SetSel          = (wm_User+1);
  em_GetRect         = (wm_User+2);
  em_SetRect         = (wm_User+3);
  em_SetRectNP       = (wm_User+4);
  em_Scroll          = (wm_User+5);
  em_LineScroll      = (wm_User+6);
  em_GetModify       = (wm_User+8);
  em_SetModify       = (wm_User+9);
  em_GetLineCount    = (wm_User+10);
  em_LineIndex       = (wm_User+11);
  em_SetHandle       = (wm_User+12);
  em_GetHandle       = (wm_User+13);
  em_GetThumb        = (wm_User+14);
  em_LineLength      = (wm_User+17);
  em_ReplaceSel      = (wm_User+18);
  em_SetFont         = (wm_User+19);
  em_GetLine         = (wm_User+20);
  em_LimitText       = (wm_User+21);
  em_CanUndo         = (wm_User+22);
  em_Undo            = (wm_User+23);
  em_FmtLines        = (wm_User+24);
  em_LineFromChar    = (wm_User+25);
  em_SetWordBreak    = (wm_User+26);
  em_SetTabStops     = (wm_User+27);
  em_SetPasswordChar = (wm_User+28);
  em_EmptyUndoBuffer = (wm_User+29);
  em_MsgMax          = (wm_User+30);

{ Button Control Styles }

const
  bs_PushButton      = $00;
  bs_DefPushButton   = $01;
  bs_CheckBox        = $02;
  bs_AutoCheckBox    = $03;
  bs_RadioButton     = $04;
  bs_3State          = $05;
  bs_Auto3State      = $06;
  bs_GroupBox        = $07;
  bs_UserButton      = $08;
  bs_AutoRadioButton = $09;
  bs_PushBox         = $0A;
  bs_OwnerDraw       = $0B;
  bs_LeftText        = $20;

{ User Button Notification Codes }

const
  bn_Clicked       = 0;
  bn_Paint         = 1;
  bn_Hilite        = 2;
  bn_Unhilite      = 3;
  bn_Disable       = 4;
  bn_DoubleClicked = 5;

{ Button Control Messages }

const
  bm_GetCheck = (wm_User+0);
  bm_SetCheck = (wm_User+1);
  bm_GetState = (wm_User+2);
  bm_SetState = (wm_User+3);
  bm_SetStyle = (wm_User+4);

{ Static Control Constants }

const
  ss_Left           = $00;
  ss_Center         = $01;
  ss_Right          = $02;
  ss_Icon           = $03;
  ss_BlackRect      = $04;
  ss_GrayRect       = $05;
  ss_WhiteRect      = $06;
  ss_BlackFrame     = $07;
  ss_GrayFrame      = $08;
  ss_WhiteFrame     = $09;
  ss_UserItem       = $0A;
  ss_Simple         = $0B;
  ss_LeftNoWordWrap = $0C;
  ss_NoPrefix       = $80;   { Don't do "&" character translation }

{ Dialog Styles }

const
  ds_AbsAlign   = $01;
  ds_SysModal   = $02;
  ds_LocalEdit  = $20;   { Edit items get Local storage }
  ds_SetFont    = $40;   { User specified font for Dlg controls }
  ds_ModalFrame = $80;   { Can be combined with ws_Caption }
  ds_NoIdleMsg  = $100;  { wm_EnterIdle message will not be sent }

const
  dm_GetDefID = (wm_User+0);
  dm_SetDefID = (wm_User+1);
  dc_HasDefID = $534B;

{ Dialog Codes }

const
  dlgc_WantArrows      = $0001;    { Control wants arrow keys      }
  dlgc_WantTab         = $0002;    { Control wants tab keys        }
  dlgc_WantAllKeys     = $0004;    { Control wants all keys        }
  dlgc_WantMessage     = $0004;    { Pass message to control       }
  dlgc_HasSetSel       = $0008;    { Understands em_SetSel message }
  dlgc_DefPushButton   = $0010;    { Default pushbutton            }
  dlgc_UndefPushButton = $0020;    { Non-default pushbutton        }
  dlgc_RadioButton     = $0040;    { Radio button                  }
  dlgc_WantChars       = $0080;    { Want wm_Char messages         }
  dlgc_Static          = $0100;    { Static item: don't include    }
  dlgc_Button          = $2000;    { Button item: can be checked   }

const
  lb_CtlCode = 0;

{ Listbox Return Values }

const
  lb_Okay     = 0;
  lb_Err      = (-1);
  lb_ErrSpace = (-2);

{ The idStaticPath parameter to DlgDirList can have the following values }
{ ORed if the list box should show other details of the files along with }
{ the name of the files }


{ Listbox Notification Codes }

const
  lbn_ErrSpace  = (-2);
  lbn_SelChange = 1;
  lbn_DblClk    = 2;
  lbn_SelCancel = 3;
  lbn_SetFocus  = 4;
  lbn_KillFocus = 5;

{ Listbox messages }

const
  lb_AddString           = (wm_User+1);
  lb_InsertString        = (wm_User+2);
  lb_DeleteString        = (wm_User+3);
  lb_ResetContent        = (wm_User+5);
  lb_SetSel              = (wm_User+6);
  lb_SetCurSel           = (wm_User+7);
  lb_GetSel              = (wm_User+8);
  lb_GetCurSel           = (wm_User+9);
  lb_GetText             = (wm_User+10);
  lb_GetTextLen          = (wm_User+11);
  lb_GetCount            = (wm_User+12);
  lb_SelectString        = (wm_User+13);
  lb_Dir                 = (wm_User+14);
  lb_GetTopIndex         = (wm_User+15);
  lb_FindString          = (wm_User+16);
  lb_GetSelCount         = (wm_User+17);
  lb_GetSelItems         = (wm_User+18);
  lb_SetTabStops         = (wm_User+19);
  lb_GetHorizontalExtent = (wm_User+20);
  lb_SetHorizontalExtent = (wm_User+21);
  lb_SetColumnWidth      = (wm_User+22);
  lb_SetTopIndex         = (wm_User+24);
  lb_GetItemRect         = (wm_User+25);
  lb_GetItemData         = (wm_User+26);
  lb_SetItemData         = (wm_User+27);
  lb_SelItemRange        = (wm_User+28);
  lb_MsgMax              = (wm_User+33);

{ Listbox Styles }

const
  lbs_Notify            = $0001;
  lbs_Sort              = $0002;
  lbs_NoRedraw          = $0004;
  lbs_MultipleSel       = $0008;
  lbs_OwnerDrawFixed    = $0010;
  lbs_OwnerDrawVariable = $0020;
  lbs_HasStrings        = $0040;
  lbs_UseTabStops       = $0080;
  lbs_NoIntegralHeight  = $0100;
  lbs_MultiColumn       = $0200;
  lbs_WantKeyboardInput = $0400;
  lbs_ExtendedSel       = $0800;
  lbs_Standard          = lbs_Notify + lbs_Sort + ws_VScroll + ws_Border;

{ Combo Box return Values }

const
  cb_Okay     = 0;
  cb_Err      = (-1);
  cb_ErrSpace = (-2);

{ Combo Box Notification Codes }

const
  cbn_ErrSpace   = (-1);
  cbn_SelChange  = 1;
  cbn_DblClk     = 2;
  cbn_SetFocus   = 3;
  cbn_KillFocus  = 4;
  cbn_EditChange = 5;
  cbn_EditUpdate = 6;
  cbn_DropDown   = 7;

{ Combo Box styles }

const
  cbs_Simple            = $0001;
  cbs_DropDown          = $0002;
  cbs_DropDownList      = $0003;
  cbs_OwnerDrawFixed    = $0010;
  cbs_OwnerDrawVariable = $0020;
  cbs_AutoHScroll       = $0040;
  cbs_OEMConvert        = $0080;
  cbs_Sort              = $0100;
  cbs_HasStrings        = $0200;
  cbs_NoIntegralHeight  = $0400;

{ Combo Box messages }

const
  cb_GetEditSel            = (wm_User+0);
  cb_LimitText             = (wm_User+1);
  cb_SetEditSel            = (wm_User+2);
  cb_AddString             = (wm_User+3);
  cb_DeleteString          = (wm_User+4);
  cb_Dir                   = (wm_User+5);
  cb_GetCount              = (wm_User+6);
  cb_GetCurSel             = (wm_User+7);
  cb_GetLBText             = (wm_User+8);
  cb_GetLBTextLen          = (wm_User+9);
  cb_InsertString          = (wm_User+10);
  cb_ResetContent          = (wm_User+11);
  cb_FindString            = (wm_User+12);
  cb_SelectString          = (wm_User+13);
  cb_SetCurSel             = (wm_User+14);
  cb_ShowDropDown          = (wm_User+15);
  cb_GetItemData           = (wm_User+16);
  cb_SetItemData           = (wm_User+17);
  cb_GetDroppedControlRect = (wm_User+18);
  cb_MsgMax                = (wm_User+19);

{ Scroll Bar Styles }

const
  sbs_Horz                    = $0000;
  sbs_Vert                    = $0001;
  sbs_TopAlign                = $0002;
  sbs_LeftAlign               = $0002;
  sbs_BottomAlign             = $0004;
  sbs_RightAlign              = $0004;
  sbs_SizeBoxTopLeftAlign     = $0002;
  sbs_SizeBoxBottomRightAlign = $0004;
  sbs_SizeBox                 = $0008;

{ WaitSoundState Constants }

const
  s_QueueEmpty   = 0;
  s_Threshold    = 1;
  s_AllThreshold = 2;

{ Accent Modes }

const
  s_Normal   = 0;
  s_Legato   = 1;
  s_Staccato = 2;

{ SetSoundNoise Sources }

const
  s_Period512   = 0;   { Freq = N/512 high pitch, less coarse hiss  }
  s_Period1024  = 1;   { Freq = N/1024                              }
  s_Period2048  = 2;   { Freq = N/2048 low pitch, more coarse hiss  }
  s_PeriodVoice = 3;   { Source is frequency from voice channel (3) }
  s_White512    = 4;   { Freq = N/512 high pitch, less coarse hiss  }
  s_White1024   = 5;   { Freq = N/1024                              }
  s_White2048   = 6;   { Freq = N/2048 low pitch, more coarse hiss  }
  s_WhiteVoice  = 7;   { Source is frequency from voice channel (3) }

const
  s_SerDVNA = (-1);    { Device not available }
  s_SerOFM  = (-2);    { Out of memory        }
  s_SerMACT = (-3);    { Music active         }
  s_SerQFUL = (-4);    { Queue full           }
  s_SerBDNT = (-5);    { Invalid note         }
  s_SerDLN  = (-6);    { Invalid note length  }
  s_SerDCC  = (-7);    { Invalid note count   }
  s_SerDTP  = (-8);    { Invalid tempo        }
  s_SerDVL  = (-9);    { Invalid volume       }
  s_SerDMD  = (-10);   { Invalid mode         }
  s_SerDSH  = (-11);   { Invalid shape        }
  s_SerDPT  = (-12);   { Invalid pitch        }
  s_SerDFQ  = (-13);   { Invalid frequency    }
  s_SerDDR  = (-14);   { Invalid duration     }
  s_SerDSR  = (-15);   { Invalid source       }
  s_SerDST  = (-16);   { Invalid state        }

const
  NoParity     = 0;
  OddParity    = 1;
  EvenParity   = 2;
  MarkParity   = 3;
  SpaceParity  = 4;

  OneStopBit   = 0;
  One5StopBits = 1;
  TwoStopBits  = 2;

  Ignore       = 0;       { Ignore signal    }
  Infinite     = $FFFF;   { Infinite timeout }

{ Error Flags }

const
  ce_RXOver   = $0001;   { Receive Queue overflow       }
  ce_Overrun  = $0002;   { Receive Overrun Error        }
  ce_RXParity = $0004;   { Receive Parity Error         }
  ce_Frame    = $0008;   { Receive Framing error        }
  ce_Break    = $0010;   { Break Detected               }
  ce_CTSTO    = $0020;   { CTS Timeout                  }
  ce_DSRTO    = $0040;   { DSR Timeout                  }
  ce_RLSDTO   = $0080;   { RLSD Timeout                 }
  ce_TXFull   = $0100;   { TX Queue is full             }
  ce_PTO      = $0200;   { LPTx Timeout                 }
  ce_IOE      = $0400;   { LPTx I/O Error               }
  ce_DNS      = $0800;   { LPTx Device not selected     }
  ce_OOP      = $1000;   { LPTx Out-Of-Paper            }
  ce_Mode     = $8000;   { Requested mode unsupported   }

const
  ie_BadID    = (-1);    { Invalid or unsupported id    }
  ie_Open     = (-2);    { Device Already Open          }
  ie_NoPen    = (-3);    { Device Not Open              }
  ie_Memory   = (-4);    { Unable to allocate queues    }
  ie_Default  = (-5);    { Error in default parameters  }
  ie_Hardware = (-10);   { Hardware Not Present         }
  ie_ByteSize = (-11);   { Illegal Byte Size            }
  ie_BaudRate = (-12);   { Unsupported BaudRate         }

{ Events }

const
  ev_RXChar  = $0001;    { Any Character received       }
  ev_RXFlag  = $0002;    { Received certain character   }
  ev_TXEmpty = $0004;    { Transmitt Queue Empty        }
  ev_CTS     = $0008;    { CTS changed state            }
  ev_DSR     = $0010;    { DSR changed state            }
  ev_RLSD    = $0020;    { RLSD changed state           }
  ev_Break   = $0040;    { BREAK received               }
  ev_Err     = $0080;    { Line status error occurred   }
  ev_Ring    = $0100;    { Ring signal detected         }
  ev_PErr    = $0200;    { Printer error occured        }

{ Escape Functions }

const
  SetXOFF  = 1;          { Simulate XOFF received       }
  SetXON   = 2;          { Simulate XON received        }
  SetRTS   = 3;          { Set RTS high                 }
  ClrRTS   = 4;          { Set RTS low                  }
  SetDTR   = 5;          { Set DTR high                 }
  ClrDTR   = 6;          { Set DTR low                  }
  ResetDev = 7;          { Reset device if possible     }

const
  LPTx = $80;            { Set if ID is for LPT device  }

type
  PDCB = ^TDCB;
  TDCB = record
    Id: Byte;              { Internal Device ID             }
    BaudRate: Word;        { Baudrate at which runing       }
    ByteSize: Byte;        { Number of bits/byte, 4-8       }
    Parity: Byte;          { 0-4=None,Odd,Even,Mark,Space   }
    StopBits: Byte;        { 0,1,2 = 1, 1.5, 2              }
    RlsTimeout: Word;      { Timeout for RLSD to be set     }
    CtsTimeout: Word;      { Timeout for CTS to be set      }
    DsrTimeout: Word;      { Timeout for DSR to be set      }
    Flags: Word;
(*
    Byte fBinary: 1;       { Binary Mode (skip EOF check    }
    Byte fRtsDisable:1;    { Don't assert RTS at init time  }
    Byte fParity: 1;       { Enable parity checking         }
    Byte fOutxCtsFlow:1;   { CTS handshaking on output      }
    Byte fOutxDsrFlow:1;   { DSR handshaking on output      }
    Byte fDummy: 2;        { Reserved                       }
    Byte fDtrDisable:1;    { Don't assert DTR at init time  }

    Byte fOutX: 1;         { Enable output X-ON/X-OFF       }
    Byte fInX: 1;          { Enable input X-ON/X-OFF        }
    Byte fPeChar: 1;       { Enable Parity Err Replacement  }
    Byte fNull: 1;         { Enable Null stripping          }
    Byte fChEvt: 1;        { Enable Rx character event.     }
    Byte fDtrflow: 1;      { DTR handshake on input         }
    Byte fRtsflow: 1;      { RTS handshake on input         }
    Byte fDummy2: 1;
*)
    XonChar: char;         { Tx and Rx X-ON character       }
    XoffChar: char;        { Tx and Rx X-OFF character      }
    XonLim: Word;          { Transmit X-ON threshold        }
    XoffLim: Word;         { Transmit X-OFF threshold       }
    PeChar: char;          { Parity error replacement char  }
    EofChar: char;         { End of Input character         }
    EvtChar: char;         { Recieved Event character       }
    TxDelay: Word;         { Amount of time between chars   }
  end;

const
  dcb_Binary         = $0001;
  dcb_RtsDisable     = $0002;
  dcb_Parity         = $0004;
  dcb_OutxCtsFlow    = $0008;
  dcb_OutxDsrFlow    = $0010;
  dcb_DtrDisable     = $0080;

const
  dcb_OutX           = $0100;
  dcb_InX            = $0200;
  dcb_PeChar         = $0400;
  dcb_Null           = $0800;
  dcb_ChEvt          = $1000;
  dcb_Dtrflow        = $2000;
  dcb_Rtsflow        = $4000;

type
  PComStat = ^TComStat;
  TComStat = record
    Flags: Byte;
(*
    Byte fCtsHold: 1;    { Transmit is on CTS hold        }
    Byte fDsrHold: 1;    { Transmit is on DSR hold        }
    Byte fRlsdHold: 1;   { Transmit is on RLSD hold       }
    Byte fXoffHold: 1;   { Received handshake             }
    Byte fXoffSent: 1;   { Issued handshake               }
    Byte fEof: 1;        { End of file character found    }
    Byte fTxim: 1;       { Character being transmitted    }
*)
    cbInQue: Word;       { count of characters in Rx Queue}
    cbOutQue: Word;      { count of characters in Tx Queue}
  end;

const
  com_CtsHold    = $0001;
  com_DsrHold    = $0002;
  com_RlsdHold   = $0004;
  com_XoffHold   = $0008;
  com_XoffSent   = $0010;
  com_Eof        = $0020;
  com_Txim       = $0040;

type
  PMDICreateStruct = ^TMDICreateStruct;
  TMDICreateStruct = record
    szClass: PChar;
    szTitle: PChar;
    hOwner: THandle;
    x, y: Integer;
    cx, cy: Integer;
    style: LongInt;
    lParam: LongInt;        { app-defined stuff }
  end;

type
  PClientCreateStruct = ^TClientCreateStruct;
  TClientCreateStruct = record
    hWindowMenu: THandle;
    idFirstChild: Word;
  end;

{ Help engine section }

{ Commands to pass WinHelp }

const
  help_Context    = $0001;   { Display topic in ulTopic }
  help_Quit       = $0002;   { Terminate help }
  help_Index      = $0003;   { Display index }
  help_HelpOnHelp = $0004;   { Display help on using help }
  help_SetIndex   = $0005;   { Set the current Index for multi index help }
  help_Key        = $0101;   { Display topic for keyword in offabData }
  help_MultiKey   = $0201;

type
  TMultiKeyHelp = record
    mkSize: Word;
    mkKeyList: Byte;
    szKeyPhrase: array[0..0] of Byte;
  end;

{ -------------------- Types from CUSTCTRL.H ------------------------ }

{ general size definitions }

const
  ctlTypes = 12;		{ number of control types }
  ctlDescr = 22;		{ size of control menu name }
  ctlClass = 20;		{ max size of class name }
  ctlTitle = 94;		{ max size of control text }

{ CONTROL STYLE DATA STRUCTURE
  
  This data structure is used by the class style dialog function
  to set and/or reset various control attributes. }

type
  PCtlStyle = ^TCtlStyle;
  TCtlStyle = record
    wX: Word;			{ x origin of control }
    wY: Word;			{ y origin of control }
    wCx: Word;			{ width of control }
    wCy: Word;			{ height of control }
    wId: Word;			{ control child id }
    dwStyle: LongInt;		{ control style }
    szClass: array[0..ctlClass-1] of Char;
    				{ name of control class }
    szTitle: array[0..ctlTitle-1] of Char;
    				{ control text }
  end;

{  CONTROL DATA STRUCTURE

   This data structure is returned by the control options function
   when enquiring about the capabilities of a particular control.
   Each control may contain various types (with predefined style
   bits) under one general class.
  
   The width and height fields are used to provide the host
   application with a suggested size.  The values in these fields
   could be either in pixels or in rc coordinates.  If it is in pixel,
   the most sigificant bit(MSB) is on.  If the MSB is off, it is in rc
   coordinates.
  
   The cursor and bitmap handles reference objects which can be
   used by the dialog editor in the placement and definition of
   new, user-defined control classes.  However, dialog editor in win30
   does not use these fields. }
  
  TCtlType = record
    wType: Word;		{ type style }
    wWidth: Word;		{ suggested width }
    wHeight: Word;		{ suggested height }
    dwStyle: LongInt;		{ default style }
    szDescr: array[0..CtlDescr-1] of Char;		
				{ menu name }
  end;

  PCtlInfo = ^TCtlInfo;
  TCtlInfo = record
	wVersion: Word;		{ control version }
	wCtlTypes: Word;	{ control types }
	szClass: array[0..ctlClass-1] of Char;		
				{ control class name }
	szTitle: array[0..ctlTitle-1] of Char;		
				{ control title }
	szReserved: array[0..9] of Char; 
				{ reserved for future use }
	ctType: array[0..ctlTypes-1] of TCtlType;		
				{ control type list }
  end;

{ ---------------------- Types from DDE.H ------------------------- }

const
  wm_dde_First	    = $03E0;
  wm_dde_Initiate   = wm_dde_First;
  wm_dde_Terminate  = wm_dde_First+1;
  wm_dde_Advise	    = wm_dde_First+2;
  wm_dde_Unadvise   = wm_dde_First+3;
  wm_dde_Ack	    = wm_dde_First+4;
  wm_dde_Data	    = wm_dde_First+5;
  wm_dde_Request    = wm_dde_First+6;
  wm_dde_Poke	    = wm_dde_First+7;
  wm_dde_Execute    = wm_dde_First+8;
  wm_dde_Last	    = wm_dde_First+8;

{ Constants used for a wm_dde_Ack message sent in responce to a wm_dde_Data
  wm_dde_Request, wm_dde_Poke, wm_dde_Advise, or wm_dde_Unadvise message.
  For example
    if lParam and dde_Ack <> 0 then ...
}

const
  dde_AppReturnCode = $00FF;
  dde_Busy	    = $4000;
  dde_Ack	    = $8000;

{ Record for the  ww_dde_Advise Options parameter (LoWord(lParam)) }

type
  PDDEAdvise = ^TDDEAdvise;
  TDDEAdvise = record
(*
    unsigned reserved:14,
             fDeferUpd:1,
	     fAckReq:1;
*)
    Flags: Word;
    cfFormat: Integer;
  end;

const
  dde_DeferUpd     = $4000;
  dde_AckReq	   = $8000;

{ Record for the hData parameter of a wm_dde_Data message (LoWord(lParam)).
  The actual size of this record depends on the size of the Value
  array. }

type
  PDDEData = ^TDDEData;
  TDDEData = record
(*	unsigned unused:12,
                 fResponse:1,
                 fRelease:1,
                 reserved:1,
                 fAckReq:1;
*)
        Flags: Word;
	cfFormat: Integer;
	Value: array[0..0] of Char;
  end;

const
  dde_Response = $1000;
  dde_Release  = $2000;

{ Record for the hData parameter of the wm_dde_Poke record (LoWord(lParam)).
  The actual size of this record depends on the size of the Value array. }

type
  PDDEPoke = ^TDDEPoke;
  TDDEPoke = record
(*	unsigned unused:13,
		 fRelease:1,
		 fReserved:2;
*)
    Flags: Word;
    cfFormat: Byte;
    Value: array[0..0] of Byte;
  end;

type
  PDDEAck = ^TDDEAck;
  TDDEAck = record
    Flags: Word;
  end;

{ ------------------------ Types from DRIVINIT.H ---------------------- }
{ Header file for printer driver initialization using ExtDeviceMode()
  and DeviceCapabilities(). }

const

  { size of a device name string }
  cchDeviceName		= 32;

  { current version of specification }
  dm_SpecVersion	= $300;

  { field selection bits }
  dm_Orientation	= $0000001;
  dm_PaperSize		= $0000002;
  dm_PaperLength	= $0000004;
  dm_PaperWidth		= $0000008;
  dm_Scale		= $0000010;
  dm_Copies		= $0000100;
  dm_DefaultSource	= $0000200;
  dm_PrintQuality	= $0000400;
  dm_Color		= $0000800;
  dm_Duplex		= $0001000;

  { orientation selections }
  dmorient_Portrait	= 1;
  dmorient_Landscape	= 2;

  { paper selections }
  dmpaper_First		= 1;
  dmpaper_Letter	= 1;		{ Letter 8 1/2 x 11 in }
  dmpaper_LetterSmall	= 2;		{ Letter Small 8 1/2 x 11 in }
  dmpaper_Tabloid	= 3;		{ Tabloid 11 x 17 in }
  dmpaper_Ledger	= 4;		{ Ledger 17 x 11 in }
  dmpaper_Legal		= 5;		{ Legal 8 1/2 x 14 in }
  dmpaper_Statement	= 6;		{ Statement 5 1/2 x 8 1/2 in }
  dmpaper_Executive	= 7;		{ Executive"7 1/2 x 10 in }
  dmpaper_A3		= 8;		{ A3 297 x 420 mm }
  dmpaper_A4		= 9;		{ A4 210 x 297 mm }
  dmpaper_A4Small	= 10;		{ A4 Small 210 x 297 mm }
  dmpaper_A5		= 11;		{ A5 148 x 210 mm }
  dmpaper_B4		= 12;		{ B4 250 x 354 }
  dmpaper_B5		= 13;		{ B5 182 x 257 mm }
  dmpaper_Folio		= 14;		{ Folio 8 1/2 x 13 in }
  dmpaper_Quarto	= 15;		{ Quarto 215 x 275 mm }
  dmpaper_10X14		= 16;		{ 10x14 in }
  dmpaper_11X17		= 17;		{ 11x17 in }
  dmpaper_Note		= 18;		{ Note 8 1/2 x 11 in }
  dmpaper_Env_9		= 19;		{ Envelope #9 3 7/8 x 8 7/8 }
  dmpaper_Env_10	= 20;		{ Envelope #10 4 1/8 x 9 1/2 }
  dmpaper_Env_11	= 21;		{ Envelope #11 4 1/2 x 10 3/8 }
  dmpaper_Env_12	= 22;		{ Envelope #12 4 \276 x 11 }
  dmpaper_Env_14	= 23;		{ Envelope #14 5 x 11 1/2 }
  dmpaper_CSheet	= 24;		{ C size sheet }
  dmpaper_DSheet	= 25;		{ D size sheet }
  dmpaper_ESheet	= 26;		{ E size sheet }
  dmpaper_Last		= dmpaper_ESheet;

  dmpaper_User		= 256;

  { bin selections }
  dmbin_First		= 1;
  dmbin_Upper		= 1;
  dmbin_OnlyOne		= 1;
  dmbin_Lower		= 2;
  dmbin_Middle		= 3;
  dmbin_Manual		= 4;
  dmbin_Envelope	= 5;
  dmbin_EnvManual	= 6;
  dmbin_Auto		= 7;
  dmbin_Tractor		= 8;
  dmbin_SmallFmt	= 9;
  dmbin_LargeFmt	= 10;
  dmbin_LargeCapacity	= 11;
  dmbin_Cassette	= 14;
  dmbin_Last		= dmbin_Cassette;

  dmbin_User	= 256;    { device specific bins start here }

  { print qualities }
  dmres_Draft	= -1;
  dmres_Low	= -2;
  dmres_Medium	= -3;
  dmres_High	= -4;

  { color enable/disable for color printers }
  dmcolor_Monochrome	= 1;
  dmcolor_Color	= 2;

  { duplex enable }
  dmdup_Simplex	= 1;
  dmdup_Vertical	= 2;
  dmdup_Horizontal	= 3;

type
  PDevMode = ^TDevMode;
  TDevMode =  record
    dmDeviceName: array[0..cchDeviceName-1] of Char;
    dmSpecVersion: Word;
    dmDriverVersion: Word;
    dmSize: Word;
    dmDriverExtra: Word;
    dmFields: LongInt;
    dmOrientation: Integer;
    dmPaperSize: Integer;
    dmPaperLength: Integer;
    dmPaperWidth: Integer;
    dmScale: Integer;
    dmCopies: Integer;
    dmDefaultSource: Integer;
    dmPrintQuality: Integer;
    dmColor: Integer;
    dmDuplex: Integer;
  end;

const

  { mode selections for the device mode function }
  dm_Update	= 1;
  dm_Copy	= 2;
  dm_Prompt	= 4;
  dm_Modify	= 8;

  dm_In_Buffer		= dm_Modify;
  dm_In_Prompt		= dm_Prompt;
  dm_Out_Buffer		= dm_Copy;
  dm_Out_Default	= dm_Update;

  { device capabilities indices }
  dc_Fields	= 1;
  dc_Papers	= 2;
  dc_Papersize	= 3;
  dc_MinExtent	= 4;
  dc_MaxExtent	= 5;
  dc_Bins	= 6;
  dc_Duplex	= 7;
  dc_Size	= 8;
  dc_Extra	= 9;
  dc_Version	= 10;
  dc_Driver	= 11;

  { export ordinal definitions }
  proc_ExtDeviceMode 	  = MakeIntResource(90);
  proc_DeviceCapabilities = MakeIntResource(91);
  proc_OldDeviceMode 	  = MakeIntResource(13);

type
  TDeviceMode = procedure(Wnd: HWnd; Module: THandle;
    DeviceName, Output: PChar);
  TExtDeviceMode = function(Wnd: HWnd; Driver: THandle;
    var DevModeOutput: TDevMode; DeciveName, Port: PChar;
    var DevModeInput: TDevMode; Profile: PChar; Mode: Word): Integer;
  TDeviceCapabilities = function(DeviceName, Port: PChar;
    Index: Word; Output: PChar; var DevMode: TDevMode): Longint;

type
  PKeyboardState = ^TKeyboardState;
  TKeyboardState = array[0..255] of Char;

implementation

end.
