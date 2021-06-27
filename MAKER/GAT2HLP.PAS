Program Gat2Help;

Uses Systex,Systems;

Var HS,HT:Hdl; FP,FS:Long; SH,Str,ST:String; I,Mg:Byte; Dbl:Bool;

BEGIN
 If ParamStr(1)=''Then Halt;
 InitSystems(suIsabel+suNoInt);
 HS:=Open(ParamStr(1),fmRead);
 If(HS=errHdl)Then Begin
  WriteLn('Fichier introuvable: ',ParamStr(1));
  Halt;
 End;
 HT:=Open(Path2NoExt(ParamStr(1))+'.HLP',fmWrite);Dbl:=ParamStr(2)='/D';
 If(HT=errHdl)Then HT:=New(Path2NoExt(ParamStr(1))+'.HLP');
 FS:=FileSize(HS);
 SetFilePos(HS,0); SH:=GetFileTxtLn(HS);FP:=Length(SH)+2;I:=2;
 SkipSpcInLn(I,SH);
 Mg:=ValW(XtrkDecNm(I,SH));
 Repeat
  SetFilePos(HS,FP);
  Str:=GetFileTxtLn(HS);
  Inc(FP,Length(Str)+2);
  ST:='';
  If Str=''Then Begin
   Repeat
   SetFilePos(HS,FP);
   Str:=GetFileTxtLn(HS);Inc(FP,Length(Str)+2);
   Until(FP>=FS)or(Str<>'');
   PutFileLn(HT);
  End;
  If Str<>''Then
  Begin
   Str:=Copy(Str,Mg+1,255);
   If(Dbl)Then Begin
    For I:=1to Length(Str)do Begin
     If(Str[I]<' ')and(Byte(Str[I])and $10=$10)Then Begin
      Inc(I);
      IncStr(ST,Str[I]);
      IncStr(ST,' ');
      If(Length(Str)<=I)Then Break;
     End
      Else
     If Str[I]>=' 'Then IncStr(ST,Str[I]);
    End;
   End
    Else
   For I:=1to Length(Str)do If Str[I]>=' 'Then IncStr(ST,Str[I]);
  End;
  PutFileTxtLn(HT,ST);
 Until FP>=FS;
 Close(HT);
 Close(HS);
 DoneSystems;
END.