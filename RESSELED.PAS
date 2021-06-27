Unit ResSeleD{ataBase};

INTERFACE

Uses Restex;

Function DBExecSelect(Var Q:DataSet;Const Command:String):Boolean;

IMPLEMENTATION

Uses Systems;

Function DBExecSelect(Var Q:DataSet;Const Command:String):Boolean;
Var
 I:Byte;
 Word:String;
Begin
 DBExecSelect:=False;
 I:=1;
 SkipSpcInLn(I,Command);
 Word:=XtrkWord(I,Command);
 If Word<>'SELECT'Then Exit;
 SkipSpcInLn(I,Command);
 If StrI(I,Command)<>'*'Then Exit;
 Inc(I);

 DBExecSelect:=True;
End;

END.

