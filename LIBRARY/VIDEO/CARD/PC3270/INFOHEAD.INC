{\Source\Chantal\Library\Video\Card\PC3270\InfoHead.Inc}

Type
 {Structure d'Information de la carte PC 3270}
 PC3270Info=Record
  AspectRatioX,AspectRatioY,MonitorType,Reserved1:Byte;
  AdapterID,Reserved2,Flags1,Flags2:Byte;
  SegCPLT:Word;
  Reserved3:Array[0..9]of Byte;
 End;
