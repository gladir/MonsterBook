{\Source\Chantal\Library\TWord.Inc}

{$IFNDEF __TWord}
 {$DEFINE __TWord}
 Type TWord=Array[0..65520div SizeOf(Word)]of Word;

{$ENDIF}