{\Source\Chantal\Library\Files\Data\DBase3He.Inc}

Type
 {Structure de fichier DBase III}
 DBaseIIIFileHeaderRec=Record
  HeadType,Year,Month,Day:Byte;
  RecordCount:LongInt;
  HeaderLength,RecordSize:Integer;
  Fill:Array[1..20]of Byte;
 End;

 DBaseIIIFieldRec=Record
  FieldName:Array[1..11]of Char;
  FieldType:Char;
  Spare1,Spare2:Integer;
  Width,Dec:Byte;
  WorkSpace:Array[1..14]of Byte;
 End;