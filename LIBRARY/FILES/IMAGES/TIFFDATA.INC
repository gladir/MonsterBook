{\Source\Chantal\Library\Files\Images\TiffData.Inc}

{$IFNDEF __TiffData}
 {$DEFINE __TiffData}

 Const
   { Marques TIFF }
  tiffSubfileType=255;         { 00FFh }
  tiffImageWidth=256;          { 0100h }
  tiffImageLength=257;         { 0101h }
  tiffBitsPerSample=258;       { 0102h }
  tiffCompression=259;         { 0103h }
  tiffPhotometricInterp=262;   { 0106h }
  tiffThreshholding=263;       { 0107h }
  tiffCellWidth=264;           { 0108h }
  tiffCellLength=265;          { 0109h }
  tiffFillOrder=266;           { 010Ah }
  tiffDocumentName=269;        { 010Dh }
  tiffImageDescription=270;    { 010Eh }
  tiffMake=271;                { 010Fh }
  tiffModel=272;               { 0110h }
  tiffStripOffsets=273;        { 0111h }
  tiffOrientation=274;         { 0112h }
  tiffSamplesPerPixel=277;     { 0115h }
  tiffRowsPerStrip=278;        { 0116h }
  tiffStripByteCounts=279;     { 0117h }
  tiffMinSampleValue=280;      { 0118h }
  tiffMaxSampleValue=281;      { 0119h }
  tiffXResolution=282;         { 011Ah }
  tiffYResolution=283;         { 011Bh }
  tiffPlanarConfiguration=284; { 011Ch }
  tiffPageName=285;            { 011Dh }
  tiffXPosition=286;           { 011Eh }
  tiffYPosition=287;           { 011Fh }
  tiffFreeOffsets=288;         { 0120h }
  tiffFreeByteCounts=289;      { 0121h }
  tiffGrayResponseUnit=290;    { 0122h }
  tiffGrayResponseCurve=291;   { 0123h }
  tiffGroup3Options=292;       { 0124h }
  tiffGroup4Options=293;       { 0125h }
  tiffResolutionUnit=296;      { 0128h }
  tiffPageNumber=297;          { 0129h }
  tiffColorResponseUnit=300;   { 012Ch }
  tiffColorResponseCurves=301; { 012Dh }

   { Tailles TIFF }
  tiffByte=1;
  tiffAscii=2;
  tiffShort=3;
  tiffLong=4;
  tiffRational=5;

   { Types de compression TIFF }
  tiffCompNone=1;
  tiffCompHuff=2;
  tiffCompFax3=3;
  tiffCompFax4=4;
  tiffCompWord1=$8003;
  tiffCompMpnt=$8005;

{$ENDIF}