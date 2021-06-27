{\Source\Chantal\Library\System\Windows\RGB.Inc}

{$IFNDEF __RGBWindows}
 {$DEFINE __RGBWindows}

Type
 RGBQuad=Record
  rgbBlue:Byte;           { Intensit‚ de Bleu }
  rgbGreen:Byte;          { Intensit‚ de Vert }
  rgbRed:Byte;            { Intensit‚ de Rouge }
  rgbReserved:Byte;       { Inutilis‚... }
 End;

{$ENDIF}