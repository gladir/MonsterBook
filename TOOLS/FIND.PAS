Program Find(Input,Ouput);

Var S,F:String;

BEGIN
 F:=ParamStr(1);
 If(ParamCount<>1)or(F[1]<>'"')or(F[Length(F)]<>'"')Then Begin
  WriteLn('FIND  Tous droits r‚serv‚s par les Chevaliers de Malte');
  WriteLn;
  WriteLn('Syntaxe: FIND "chaŒne … rechercher"');
  Halt;
 End;
 F:=Copy(F,2,Length(F)-2);
 Repeat
  ReadLn(S);
  If Pos(F,S)>0Then WriteLn(S);
 Until Eof(Input);
END.
