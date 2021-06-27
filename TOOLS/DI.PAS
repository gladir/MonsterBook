Program DI; { Liste le r‚pertoire }

{$M 16384,0,0}

Uses Dos,Dostex,Systex;

{$I ..\Library\AddStr.Inc}
{$I ..\Library\CStr.Inc}
{$I ..\Library\CStr2.Inc}
{$I ..\Library\DirExist.Inc}
{$I ..\Library\DskFree.Inc}
{$I ..\Library\DskSize.Inc}
{$I ..\Library\GetCountry.Inc}
{$I ..\Library\KeyPress.Inc}
{$I ..\Library\Path2Drv.Inc}
{$I ..\Library\Path2Dsk.Inc}
{$I ..\Library\ReadKey.Inc}
{$I ..\Library\SetFullName.Inc}
{$I ..\Library\Str.Inc}
{$I ..\Library\Str2.Inc}
{$I ..\Library\StrUSpc.Inc}

{$I ..\Library\AddPChr.Inc}
{$I ..\Library\AddStr.Inc}
{$I ..\Library\UnpackTime.Inc}
{$I ..\Library\Str0.Inc}
{$I ..\Library\Str2.Inc}

Function _CStrDate(Year,Month,Day,DayOfWeek:Wd):String;Var Target:String;Begin
 Case(Date)of
  0:Begin
   Target:=Str2(Month,2);AddPChr(Target,@DtSep);AddStr(Target,Str0(Day,2))
  End;
  1:Begin
   Target:=Str2(Day,2);AddPChr(Target,@DtSep);AddStr(Target,Str0(Month,2))
  End;
  Else Begin
   Target:=Str2(Year,4);AddPChr(Target,@DtSep);
   AddStr(Target,Str0(Month,2));AddPChr(Target,@DtSep);
   AddStr(Target,Str0(Day,2))
  End;
 End;
 If Date<2Then Begin AddPChr(Target,@DtSep);AddStr(Target,Str0(Year,4))End;
 _CStrDate:=Target
End;

Function CStrDate(Time:Long):String;Var DT:DateTime;Begin
 UnpackTime(Time,DT); { Bits de 31 … 16 de la date ‚tant important!}
 CStrDate:=_CStrDate(DT.Year,DT.Month,DT.Day,$FFFF);
End;

Function CStrTimeDos(Hour,Min,Sec:Byte):String;Var S:String;Begin
 S:=Str0(Hour,2);AddPChr(S,@TmSep);AddStr(S,Str0(Min,2));
 AddPChr(S,@TmSep);AddStr(S,Str0(Sec,2));CStrTimeDos:=S
End;

Function CStrTime(Time:Long):String;Var DT:DateTime;Begin
 UnpackTime(Time,DT);
 CStrTime:=CStrTimeDos(DT.Hour,DT.Min,DT.Sec)
End;

Function StrTime(Time:Long):String;Begin
 StrTime:=CStrDate(Time)+' '+CStrTime(Time)
End;

Var Descr:SearchRec;Path:PathStr;Dsk,Y,I:Byte;Size,Free:Long;
    Cur:Word Absolute 0:$450;
BEGIN
 GetCountry;
 If ParamStr(1)='/?'Then Begin
  WriteLn('DI  Version 1.2  Tous droits r‚serv‚ par les Chevaliers de Malte (C) 1996');
  WriteLn;
  WriteLn('DI [/?] [[unit‚:][chemin][fichier]]');
  WriteLn;
  WriteLn('[lecteur:][chemin]  Pr‚cisent le lecteur et le r‚pertoire dont vous voulez');
  WriteLn('                    afficher le contenu.');
  WriteLn('         [fichier]  Pr‚cise un fichier ou un groupe de fichiers … lister.');
  Halt;
 End;
 Y:=1; Cur:=$0; Path:=ParamStr(1);
 If Path=''Then Path:='*.*'Else
 If Path[Length(Path)]='\'Then AddStr(Path,'*.*')Else
 If DirExist(Path)Then AddStr(Path,'\*.*');
 Dsk:=Path2Dsk(Path)+1;
 ASM MOV AX,$600;MOV BH,7;XOR CX,CX;MOV ES,CX;MOV DL,ES:[$44A];DEC DL;MOV DH,ES:[$484];INT $10;END;
 Size:=DskSize(Dsk);Free:=DskFree(Dsk);
 Write('Disque ',Path2Drv(Path),':  Total: ',CStr(Size),'  Utilis‚: ',
	 CStr(Size-Free),'  Libre: ',CStr(Free));
 Write(' ':CurrNmXTxts-XCur);
 If Mem[_B800:0]=Byte('D')Then For I:=0to CurrNmXTxts-1do Mem[_B800:(I shl 1)+1]:=$1B;
 FindFirst(Path,faAll,Descr);
 While DosError=0do Begin
  If(Descr.Attr and faDir<>faDir)Then Descr.Name:=SetFullName(Descr.Name);
  Descr.Name:=StrUSpc(Descr.Name,12);
  Write(Descr.Name);
  If(Descr.Attr and faDir=faDir)Then Begin
   If Descr.Name[1]='.'Then Write(' <R‚p-Parent> ')Else Write(' <Sous-R‚per> ');
  End
   Else
  Write(CStr2(Descr.Size,14));
  Write('  ',StrTime(Descr.Time));
  If(Descr.Attr and faDir=faDir)Then
   If Mem[_B800:0]=Byte('D')Then For I:=0to CurrNmXTxts-1do Mem[_B800:((CurrNmXTxts*YCur+I)shl 1)+1]:=$0F;
  WriteLn;
  FindNext(Descr);
  Inc(Y);
  If(Y=CurrMaxYTxts)Then Begin
   Y:=1;
   Write('Presse <ESC> pour quitter ou une autre touche pour continuer...');
   If Mem[_B800:0]=Byte('D')Then For I:=0to CurrNmXTxts-1do Mem[_B800:((CurrNmXTxts*CurrMaxYTxts+I)shl 1)+1]:=$1B;
   Repeat Until KeyPress;
   If(ReadKey=kbEsc)Then Break;
   Cur:=$100;
  End;
 End;
 ASM
  MOV AX,$600;MOV BH,7;XOR CX,CX;MOV ES,CX;MOV CH,ES:[$451]
  MOV DL,ES:[$44A];DEC DL;MOV DH,ES:[$484];INT $10
 END;
END.