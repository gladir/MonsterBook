{\Source\Chantal\Library\System\CPM\FCBRec.Inc}

Type
 {Structure du FCB}
 FCBRec=Record
  Num:Byte;
  Name:Array[0..7]of Char;
  Ext:Array[0..2]of Char;
  CurrBlock,SizeRec:Word;
  SizeFile,LastTime:LongInt;
  Reserved:Array[0..7]of Byte;
  CurrRec:Byte;
  SelectAcces:LongInt;
 End;