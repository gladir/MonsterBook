{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴콘
 �                  Central-Point Typewriter To Gat                   �
 �                       Convertisseur de donn괻                      �
 �                             1998/05/16                             �
 �                                                                    �
 �        Tous droits r굎erv굎 par les Chevaliers de Malte (C)        �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複蔔


 Description
 袴袴袴袴袴�

  Ce programme permet de convertir des donn괻s de format de texte ASCII
 de Central-Point ou Norton en format de tra똳ement de texte GAT.
}

Program TextCPToGat;

Uses Systex,Systems,Isatex;

Var HS,HT:Hdl;FS,P:Long;S,T:String;I,SP:Byte;
    ModeBold,ModeUnderline:Bool;

BEGIN
 InitSystems(suIsabel);
 HS:=Open(ParamStr(1),fmRead);
 If(HS=errHdl)Then Begin;WriteLn('Impossible d''ouvrir le fichier');Halt(1)End;
 FS:=FileSize(HS);HT:=New(Path2NoExt(ParamStr(1))+'.GAT');
 If(HT=errHdl)Then Begin;WriteLn('Impossible de cr괻r le fichier');Halt(2)End;
 PutFileTxtLn(HT,': 10 6 90 60 L 0');
 ModeBold:=No;ModeUnderline:=No;
 Repeat
  __GetAbsFileTxtLn(HS,P,S);
  T:='';Sp:=0;
  If S<>''Then Begin
   T:=Spc(10);
   For I:=1to Length(S)do Begin
    If(S[I]='^')and(StrI(I+1,S)='B')Then Begin;ModeBold:=Not(ModeBold);Inc(I)End Else
    If(S[I]='^')and(StrI(I+1,S)='U')Then Begin;ModeUnderline:=Not(ModeUnderline);Inc(I)End
     Else
    Begin
     If(ModeBold)and(ModeUnderline)Then IncStr(T,Chr(cgBold+cgUnderline))Else
     If(ModeBold)Then IncStr(T,Chr(cgBold))Else
     If(ModeUnderline)Then IncStr(T,Chr(cgUnderline));
     IncStr(T,S[I]);
     If S[I]=' 'Then Inc(Sp);
    End;
   End;
   If(Length(S)>60)and(Sp>0)and(T[Length(T)]<>' ')Then Begin
    _GetAbsFileTxtLn(HS,P,S);
    If S<>''Then IncStr(T,' ');
   End;
  End;
  PutFileTxtLn(HT,T);
 Until FS<P;
 Close(HT);
 Close(HS);
END.