{\Source\Chantal\Library\System\Malte\ExecFile\MexHeader.Inc}

{$IFNDEF __ExecFileMexHeader}
 {$DEFINE __ExecFileMexHeader}

Type
 MexHeader=Record
  Sign:Array[0..3]of Char; { Signature: 'MEX'#26 }
  NumParag:Long;           { Nombre de paragraphe … adapter }
 End;

{$ENDIF}