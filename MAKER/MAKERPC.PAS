Program MakerPascalCompilerData;

{$M 65520,0,128072}

Uses Adele,Systex,Systems;

Const MaxLn=500;

Var Data:Array[0..MaxLn]of String[80];
    NmLn:Word;

Procedure LoadFile(Const Path:String);Var Handle:Hdl;FP,FS:Long;Begin
 Handle:=Open(Path,fmRead);NmLn:=0;FP:=0;
 If(Handle<>errHdl)Then Begin
  FS:=FileSize(Handle);
  Repeat
   __GetAbsFileTxtLn(Handle,FP,Data[NmLn]);
   Inc(NmLn);
  Until FP>=FS;
  Close(Handle)
 End;
End;

Procedure MakeFile;Var Handle:Hdl;M,I,J,K:Word;S,CPU,TS,InLn:String;
ParamStr:String[10];Free:Array[0..MaxLn]of Boolean;Parameters:Bool;

 Procedure ComputeLn;Var JT,JX,KT:Byte;Begin
  Parameters:={StrUp(Copy(S,Length(S)-2,3))<>'NON'}Pos('NON',StrUp(S))=0;
  If(Parameters)Then ParamStr:='Ya'Else ParamStr:='No';
  For JT:=1to Length(S)do If S[JT]=' 'Then Begin
   CPU:='';
   For KT:=JT+1to Length(S)do If S[KT]<>' 'Then Break;
   While S[KT]<>' 'do Begin;IncStr(CPU,S[KT]);Inc(KT)End;
   InLn:='';
   If Not(S[Length(S)]in['i','n'])Then Begin
    For JX:=Length(S)downto 1do If S[JX]=' 'Then Break;
    Inc(JX);
    While JX<Length(S)do Begin
     AddStr(InLn,'#$');
     IncStr(InLn,S[JX]);
     Inc(JX);
     IncStr(InLn,S[JX]);
     Inc(JX);
    End;
   End;
   _Left(S,JT-1);
   Break;
  End;
  J:=JT;K:=KT
 End;

 Function GetLine(Min,Max:Word):String;Var X:Word;TS:String;Begin
  X:=((Max-Min)shr 1)+Min;
  If(Not(Free[X]))and(Min<=Max)and(X<NmLn)Then Begin
   S:=Data[X];Free[X]:=Ya;
   ComputeLn;
   GetLine:={'@ac'+S}'Ofs(ac'+S+')';
   If(Min=0)and(Max+1=NmLn)Then TS:=' AsmCode'Else TS:=' ac'+S;
   AddStr(TS,':NoeudAsmRec=('#13#10'  Nom:'''+S+''';'#13#10+
       '  Code:ca'+S+';'#13#10+
       '  CPU:');
   If CPU='8088+'Then AddStr(TS,'p8088Plus')Else
   If CPU='8088'Then AddStr(TS,'p8088')Else
   If CPU='8086+'Then AddStr(TS,'p8086Plus')Else
   If CPU='8086'Then AddStr(TS,'p8086')Else
   If CPU='80188+'Then AddStr(TS,'p80188Plus')Else
   If CPU='80188'Then AddStr(TS,'p80188')Else
   If CPU='80186+'Then AddStr(TS,'p80186Plus')Else
   If CPU='80286+'Then AddStr(TS,'p80286Plus')Else
   If CPU='80286'Then AddStr(TS,'p80286')Else
   If CPU='80386+'Then AddStr(TS,'p80386Plus')Else
   If CPU='80386'Then AddStr(TS,'p80386')Else
   If CPU='80486+'Then AddStr(TS,'p80486Plus')Else
   If CPU='80486'Then AddStr(TS,'p80486')Else
   If CPU='80586+'Then AddStr(TS,'p80586Plus')Else
   If CPU='80586'Then AddStr(TS,'p80586')Else
   If CPU='80686+'Then AddStr(TS,'p80686Plus')Else
   If CPU='80686'Then AddStr(TS,'p80686')Else
   If CPU='8087+'Then AddStr(TS,'p8087Plus')Else
   If CPU='8087'Then AddStr(TS,'p8087')Else
   If CPU='80287+'Then AddStr(TS,'p80287Plus')Else
   If CPU='80287'Then AddStr(TS,'p80287')Else
   If CPU='80387+'Then AddStr(TS,'p80387Plus')Else
   If CPU='80387'Then AddStr(TS,'p80387')Else
   If CPU='MMX'Then AddStr(TS,'pMMX');
   AddStr(TS,';'#13#10'  Parameters:'+ParamStr+';'#13#10'  OpCode:');
   If InLn=''Then AddStr(TS,'''''')Else AddStr(TS,InLn);
   AddStr(TS,';'#13#10'  Gauche:');
   PutFileTxtLn(Handle,TS+GetLine(Min,X-1)+';'#13#10'  Droite:'+GetLine(X+1,Max)+#13#10' );');
   PutFileLn(Handle);
  End
   Else
  GetLine:='0'{'NIL'};
 End;

Begin
 Handle:=NewNBak('\SOURCE\CHANTAL\TOOLS\PCCORTEX.INC');
 If(Handle<>errHdl)Then Begin
  PutFileTxtLn(Handle,'Const');
  For I:=0to NmLn-1do Begin
   S:=Data[I];
   ComputeLn;
   PutFileTxtLn(Handle,StrUSpc(' ca'+S+'='+StrW(I)+';',30)+
                       '{ '+S+', '+CPU+' }');
  End;
  PutFileLn(Handle);
  PutFileTxtLn(Handle,'  { Les constantes suivantes renferme l''arbre des }'#13#10+
                      '  { pour connaŒtre les instructions assembleur }'#13#10);
  FillClr(Free,MaxLn);
  GetLine(0,NmLn-1);
  Close(Handle)
 End;
End;

Procedure MakeFileIfCond;Var Handle:Hdl;M,I:Word;S,TS,InLn:String;
ParamStr:String[10];Free:Array[0..MaxLn]of Boolean;

 Procedure ComputeLn;Var JT,JX:Byte;Begin
  For JT:=1to Length(S)do If S[JT]=' 'Then Begin
   InLn:='';
   For JX:=Length(S)downto 1do If S[JX]=' 'Then Break;
   Inc(JX);
   While JX<Length(S)do Begin
    AddStr(InLn,'$');
    IncStr(InLn,S[JX]);
    Inc(JX);
    IncStr(InLn,S[JX]);
    Inc(JX);
   End;
   _Left(S,JT-1);
   Break;
  End;
 End;

 Function GetLine(Min,Max:Word):String;Var X:Word;TS:String;Begin
  X:=((Max-Min)shr 1)+Min;
  If(Not(Free[X]))and(Min<=Max)and(X<NmLn)Then Begin
   S:=Data[X];Free[X]:=Ya;
   ComputeLn;
   GetLine:='Ofs(aif'+S+')';
   If(Min=0)and(Max+1=NmLn)Then TS:=' AsmIfCond'Else TS:=' aif'+S;
   AddStr(TS,':NoeudIfCondAsmRec=('#13#10'  Nom:'''+S+''';'#13#10+
       '  Code:'+InLn+';'#13#10'  Gauche:');
   PutFileTxtLn(Handle,TS+GetLine(Min,X-1)+';'#13#10'  Droite:'+GetLine(X+1,Max)+#13#10' );');
   PutFileLn(Handle);
  End
   Else
  GetLine:='0';
 End;

Begin
 Handle:=Open('\SOURCE\CHANTAL\TOOLS\PCCORTEX.INC',fmDef);
 If(Handle<>errHdl)Then Begin
  PutFileTxtLn(Handle,'Const');
  PutFileLn(Handle);
  PutFileTxtLn(Handle,'  { Les constantes suivantes renferme l''arbre des }'#13#10+
                      '  { pour un IF conditionnel en assembleur }'#13#10);
  FillClr(Free,MaxLn);
  GetLine(0,NmLn-1);
  Close(Handle)
 End;
End;

Procedure MakeFileMainWord;Var Handle:Hdl;M,I:Word;S,TS,InLn:String;
ParamStr:String[10];Free:Array[0..MaxLn]of Boolean;

 Procedure ComputeLn;Var JT,JX:Byte;Begin
  For JT:=1to Length(S)do If S[JT]=' 'Then Begin
   InLn:='';
   For JX:=Length(S)downto 1do If S[JX]=' 'Then Break;
   Inc(JX);
   While StrI(JX,S)in['0'..'9']do Begin
    IncStr(InLn,S[JX]);
    Inc(JX);
   End;
   _Left(S,JT-1);
   Break;
  End;
 End;

 Function GetLine(Min,Max:Word):String;Var X:Word;TS:String;Begin
  X:=((Max-Min)shr 1)+Min;
  If(Not(Free[X]))and(Min<=Max)and(X<NmLn)Then Begin
   S:=Data[X];Free[X]:=Ya;
   ComputeLn;
   GetLine:='Ofs(mwp'+S+')';
   If(Min=0)and(Max+1=NmLn)Then TS:=' MainWordPas'Else TS:=' mwp'+S;
   AddStr(TS,':NoeudMainWordPasRec=('#13#10'  Nom:'''+S+''';'#13#10+
       '  Code:'+InLn+';'#13#10'  Gauche:');
   PutFileTxtLn(Handle,TS+GetLine(Min,X-1)+';'#13#10'  Droite:'+GetLine(X+1,Max)+#13#10' );');
   PutFileLn(Handle);
  End
   Else
  GetLine:='0';
 End;

Begin
 Handle:=Open('\SOURCE\CHANTAL\TOOLS\PCCORTEX.INC',fmDef);
 If(Handle<>errHdl)Then Begin
  PutFileTxtLn(Handle,'Const');
  PutFileLn(Handle);
  PutFileTxtLn(Handle,'  { Les constantes suivantes renferme l''arbre des }'#13#10+
                      '  { mots r‚serv‚s en Pascal … l''''entr‚e }'#13#10);
  FillClr(Free,MaxLn);
  GetLine(0,NmLn-1);
  Close(Handle)
 End;
End;

Procedure MakeFileInstrPas;Var Handle:Hdl;M,I:Word;S,TS,InLn,InLn2:String;
ParamStr:String[10];Free:Array[0..MaxLn]of Boolean;

 Procedure ComputeLn;Var JT,JX:Byte;Begin
  For JT:=1to Length(S)do If S[JT]=' 'Then Begin
   InLn:='';
   For JX:=1to Length(S)do If S[JX]=' 'Then Break;
   While S[JX]=' 'do Inc(JX);
   While StrI(JX,S)in['0'..'9']do Begin
    IncStr(InLn,S[JX]);
    Inc(JX);
   End;
   InLn2:='';
   For JX:=Length(S)downto 1do If S[JX]=' 'Then Break;
   Inc(JX);
   While StrI(JX,S)in['0'..'9']do Begin
    IncStr(InLn2,S[JX]);
    Inc(JX);
   End;
   _Left(S,JT-1);
   Break;
  End;
 End;

 Function GetLine(Min,Max:Word):String;Var X:Word;TS:String;Begin
  X:=((Max-Min)shr 1)+Min;
  If(Not(Free[X]))and(Min<=Max)and(X<NmLn)Then Begin
   S:=Data[X];Free[X]:=Ya;
   ComputeLn;
   GetLine:='Ofs(ip'+S+')';
   If(Min=0)and(Max+1=NmLn)Then TS:=' InstrPas'Else TS:=' ip'+S;
   AddStr(TS,':NoeudInstrPasRec=('#13#10'  Nom:'''+S+''';'#13#10+
       '  Code:cip'+S+';'#13#10+
       '  Extra:'+InLn2+';'#13#10+
       '  Gauche:');
   PutFileTxtLn(Handle,TS+GetLine(Min,X-1)+';'#13#10'  Droite:'+GetLine(X+1,Max)+#13#10' );');
   PutFileLn(Handle);
  End
   Else
  GetLine:='0';
 End;

Begin
 Handle:=Open('\SOURCE\CHANTAL\TOOLS\PCCORTEX.INC',fmDef);
 If(Handle<>errHdl)Then Begin
  PutFileTxtLn(Handle,'Const');
  For I:=0to NmLn-1do Begin
   S:=Data[I];
   ComputeLn;
   PutFileTxtLn(Handle,StrUSpc(' cip'+S+'='+InLn+';',30)+
                       '{ Instruction ®'+S+'¯ }');
  End;
  PutFileLn(Handle);
  PutFileTxtLn(Handle,'  { Les constantes suivantes renferme l''arbre des }'#13#10+
                      '  { instruction en Pascal B57 }'#13#10);
  FillClr(Free,MaxLn);
  GetLine(0,NmLn-1);
  Close(Handle)
 End;
End;

Procedure MakeFileRegister;Var Handle:Hdl;M,I:Word;S,TS,InLn,InLn2:String;
ParamStr:String[10];Free:Array[0..MaxLn]of Boolean;

 Procedure ComputeLn;Var JT,JX:Byte;Begin
  For JT:=1to Length(S)do If S[JT]=' 'Then Begin
   InLn:='';
   For JX:=1to Length(S)do If S[JX]=' 'Then Break;
   While S[JX]=' 'do Inc(JX);
   While StrI(JX,S)in['0'..'9']do Begin
    IncStr(InLn,S[JX]);
    Inc(JX);
   End;
   InLn2:='';
   For JX:=Length(S)downto 1do If S[JX]=' 'Then Break;
   Inc(JX);
   While StrI(JX,S)in['0'..'9']do Begin
    IncStr(InLn2,S[JX]);
    Inc(JX);
   End;
   _Left(S,JT-1);
   Break;
  End;
 End;

 Function GetLine(Min,Max:Word):String;Var X:Word;TS:String;Begin
  X:=((Max-Min)shr 1)+Min;
  If(Not(Free[X]))and(Min<=Max)and(X<NmLn)Then Begin
   S:=Data[X];Free[X]:=Ya;
   ComputeLn;
   GetLine:='Ofs(ra'+S+')';
   If(Min=0)and(Max+1=NmLn)Then TS:=' RegAsm'Else TS:=' ra'+S;
   AddStr(TS,':NoeudRegAsmRec=('#13#10'  Nom:'''+S+''';'#13#10+
       '  Code:cra'+S+';'#13#10+
       '  Extra:'+InLn2+';'#13#10+
       '  Gauche:');
   PutFileTxtLn(Handle,TS+GetLine(Min,X-1)+';'#13#10'  Droite:'+GetLine(X+1,Max)+#13#10' );');
   PutFileLn(Handle);
  End
   Else
  GetLine:='0';
 End;

Begin
 Handle:=Open('\SOURCE\CHANTAL\TOOLS\PCCORTEX.INC',fmDef);
 If(Handle<>errHdl)Then Begin
  PutFileTxtLn(Handle,'Const');
  For I:=0to NmLn-1do Begin
   S:=Data[I];
   ComputeLn;
   PutFileTxtLn(Handle,StrUSpc(' cra'+S+'='+InLn+';',30)+
                       '{ Registre ®'+S+'¯ }');
  End;
  PutFileLn(Handle);
  PutFileTxtLn(Handle,'  { Les constantes suivantes renferme l''arbre des }'#13#10+
                      '  { registres assembleurs }'#13#10);
  FillClr(Free,MaxLn);
  GetLine(0,NmLn-1);
  Close(Handle)
 End;
End;

Procedure MakeFileVariable;Var Handle:Hdl;M,I:Word;S,TS,InLn,InLn2:String;
ParamStr:String[10];Free:Array[0..MaxLn]of Boolean;

 Procedure ComputeLn;Var JT,JX:Byte;Begin
  For JT:=1to Length(S)do If S[JT]=' 'Then Begin
   InLn:='';
   For JX:=1to Length(S)do If S[JX]=' 'Then Break;
   While S[JX]=' 'do Inc(JX);
   While Not(StrI(JX,S)in[' ',#9,#0])do Begin
    IncStr(InLn,S[JX]);
    Inc(JX);
   End;
   InLn2:='';
   For JX:=Length(S)downto 1do If S[JX]=' 'Then Break;
   Inc(JX);
   While Not(StrI(JX,S)in[' ',#9,#0])do Begin
    IncStr(InLn2,S[JX]);
    Inc(JX);
   End;
   _Left(S,JT-1);
   Break;
  End;
 End;

 Function GetLine(Min,Max:Word):String;Var X:Word;TS:String;Begin
  X:=((Max-Min)shr 1)+Min;
  If(Not(Free[X]))and(Min<=Max)and(X<NmLn)Then Begin
   S:=Data[X];Free[X]:=Ya;
   ComputeLn;
   GetLine:='Ofs(vp'+S+')';
   If(Min=0)and(Max+1=NmLn)Then TS:=' VarPas'Else TS:=' vp'+S;
   AddStr(TS,':NoeudVarPasRec=('#13#10'  Nom:'''+S+''';'#13#10+
       '  TypeDef:'+InLn+';'#13#10+
       '  Size:'+InLn2+';'#13#10+
       '  Gauche:');
   PutFileTxtLn(Handle,TS+GetLine(Min,X-1)+';'#13#10'  Droite:'+GetLine(X+1,Max)+#13#10' );');
   PutFileLn(Handle);
  End
   Else
  GetLine:='0';
 End;

Begin
 Handle:=Open('\SOURCE\CHANTAL\TOOLS\PCCORTEX.INC',fmDef);
 If(Handle<>errHdl)Then Begin
  PutFileTxtLn(Handle,'Const');
  PutFileLn(Handle);
  PutFileTxtLn(Handle,'  { Les constantes suivantes renferme l''arbre des }'#13#10+
                      '  { variables Pascal }'#13#10);
  FillClr(Free,MaxLn);
  GetLine(0,NmLn-1);
  Close(Handle)
 End;
End;

BEGIN
 WriteLn('Fabricants de donn‚es du Compilateur Pascal B57');
 InitSystems(suIsabel);
 WriteLn('Travaille en cours...');
 LoadFile('\SOURCE\CHANTAL\RESOURCE\COMPILER\ASM\INSTNAME.LST');
 MakeFile;
 LoadFile('\SOURCE\CHANTAL\RESOURCE\COMPILER\ASM\IFCOND.LST');
 MakeFileIfCond;
 LoadFile('\SOURCE\CHANTAL\RESOURCE\COMPILER\PASCAL\MAINWORD.LST');
 MakeFileMainWord;
 LoadFile('\SOURCE\CHANTAL\RESOURCE\COMPILER\PASCAL\INSTR.LST');
 MakeFileInstrPas;
 LoadFile('\SOURCE\CHANTAL\RESOURCE\COMPILER\ASM\REGISTER.LST');
 MakeFileRegister;
 LoadFile('\SOURCE\CHANTAL\RESOURCE\COMPILER\PASCAL\VARIABLE.LST');
 MakeFileVariable;
 DoneSystems;
END.