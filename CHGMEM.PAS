Program ChangeMemory;

Label NotMatch;

Var
 Seg,Ofs,J:Word;
 Origin,New:String;

BEGIN
 Origin:=ParamStr(1);
 New:=ParamStr(2);
 For Seg:=$40to$A000 do Begin
  For Ofs:=0to 32+Length(Origin)do Begin
   If Mem[Seg:Ofs]=Byte(Origin[1])Then Begin
    For J:=1to Length(Origin)do If Mem[Seg:Ofs+J-1]<>Byte(Origin[J])Then Goto NotMatch;
    For J:=1to Length(New)do Mem[Seg:Ofs+J-1]:=Byte(New[J]);
   End;
NotMatch:
  End;
 End;
END.