Unit ToolCountry;

INTERFACE

Uses Dos,Systex;

Type

 CityRec=Record
  City:String[30];
  Region:String[30];
  Country:String[30];
  CodeTel:String[3];
  Coordonnee:String[15];
  Pop1976,Pop1980,Pop1995:Long;
 End;

Function ConvCityAscii2Rec(Source,Target:PathStr):Bool;

IMPLEMENTATION

Uses Systems;

Function ConvCityAscii2Rec;
Var HSrc,HTrg:Hdl; J,P,FS:LongInt; S,S2:String; R:CityRec; I:Int;
Begin
 ConvCityAscii2Rec := False;
 HSrc:=Open(Source,ReadOnly);
 If(HSrc=errHdl)Then Exit;
 HTrg := New(Target);
 If(HTrg=errHdl)Then Begin
  Close(HSrc);
  Exit;
 End;
 FS := FileSize(HSrc);
 P := 0; J := 0;
 Repeat
  S:=GetAbsFileTxtLn(HSrc,P);
  If GetSysErr<>0Then Break;
  Inc(P,Length(S)+2);
  If J<2Then Begin Inc(J);Continue;End;
  FillClr(R,SizeOf(R));
  I := 1; R.City := '';
  Repeat
   Case S[I] of
    '_': IncStr(R.City,' ');
    Else IncStr(R.City,S[I]);
   End;
   Inc(I);
   If(I > Length(S))Then Break;
  Until (S[I] = ' ');
  Repeat
   Inc(I);
   If(I > Length(S))Then Break;
  Until Not(S[I] = ' ');
  R.Region := '';
  Repeat
   Case S[I] of
    '_': IncStr(R.Region,' ');
    Else IncStr(R.Region,S[I]);
   End;
   Inc(I);
   If(I > Length(S))Then Break;
  Until (S[I] = ' ');
  Repeat
   Inc(I);
   If(I > Length(S))Then Break;
  Until Not(S[I] = ' ');
  S2 := '';
  Repeat
   IncStr(S2,S[I]);
   Inc(I);
   If(I > Length(S))Then Break;
  Until (S[I] = ' ');
  If(S2 = '?')Then R.Pop1976 := -1
	      Else R.Pop1976 := ValL(S2);
  Repeat
   Inc(I);
   If(I > Length(S))Then Break;
  Until Not(S[I] = ' ');
  S2 := '';
  Repeat
   IncStr(S2,S[I]);
   Inc(I);
   If(I > Length(S))Then Break;
  Until (S[I] = ' ');
  If(S2 = '?')Then R.Pop1980 := -1
	      Else R.Pop1980 := ValL(S2);
  R.Pop1995 := -1;
  Repeat
   Inc(I);
   If(I > Length(S))Then Break;
  Until Not(S[I] = ' ');
  R.CodeTel := '';
  Repeat
   IncStr(R.CodeTel,S[I]);
   Inc(I);
   If(I > Length(S))Then Break;
  Until (S[I] = ' ');
  Repeat
   Inc(I);
   If(I > Length(S))Then Break;
  Until Not(S[I] = ' ');
  R.Country := '';
  Repeat
   IncStr(R.Country,S[I]);
   Inc(I);
   If(I > Length(S))Then Break;
  Until (S[I] = ' ');
  Repeat
   Inc(I);
   If(I > Length(S))Then Break;
  Until Not(S[I] = ' ');
  R.Coordonnee := '';
  While (I <= Length(S)) do
  Begin
   IncStr(R.Coordonnee,S[I]);
   Inc(I);
  End;
  SetRec(HTrg,J-2,SizeOf(R),R);
  Inc(J);
 Until (P >= FS);
 Close(HTrg);
 Close(HSrc);
 ConvCityAscii2Rec := True;
End;

END.