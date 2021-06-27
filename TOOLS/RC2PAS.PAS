Program RC2Pascal;

Uses Systex,Memories,Systems;

Const

  { Constante de Macro de texte }
 mtkbEsc=#1;               { "kbEsc" }
 mtkbUp=#2;                { "kbUp" }
 mtkbDn=#3;                { "kbDn" }
 mtkbTab=#4;               { "kbTab" }
 mtkbEnter=#5;             { "kbEnter" }
 mtkbClose=#6;             { "kbClose" }
 mtLN=#14;                 { Insertion d'espace }
 mtWMaxXTxts=#21;          { "W.MaxXTxts" }
 mtWMaxYTxts=#22;          { "W.MaxYTxts" }
 mtStrNew_=#23;            { "StrNew(" }
 mtStrDispose_=#24;        { "StrDispose(" }
 mtWPutPTxtXY_=#25;        { "W.PutPTxtXY(" }
 mtWPutTxtXY_=#26;         { "W.PutTxtXY(" }
 mtWClrEol_=#27;           { "W.ClrEol(" }
 mtWSetKr_=#28;            { "W.SetKr(" }
 mtWSetKrBorder_=#29;      { "W.SetKrBorder;" }
 mtWBarSpcHorShade_=#30;   { "W.BarSpcHorShade(" }
 mtBreak_=#31;             { "Break;" }

Var ErrI,ErrJ:Word;
    ErrCode:Int;

Procedure CompileRC(Source:PathStr); Forward;

Function AddStrPasType(S:String):String;Var Target:String;I:Byte;Begin
 Target:='';
 For I := 1 to Length(S) do
 Begin
  Case S[I] of
   '†' : Systems.AddStr(Target,'After');
   'Ô' : Systems.AddStr(Target,'And');
   'è' : Systems.AddStr(Target,'Array[Byte]of Char');
   'é' : Systems.AddStr(Target,'Array');
   'Æ' : Systems.AddStr(Target,'Begin');
   'á' : Systems.AddStr(Target,'Chr');
   'Ä' : Systems.AddStr(Target,'Char');
   'ˆ' : Systems.AddStr(Target,'div');
   '˜' : Systems.AddStr(Target,'Else');
   '' : Systems.AddStr(Target,'Equal');
   'Ø' : Systems.AddStr(Target,'End;');
   'ê' : Systems.AddStr(Target,'Extract');
   'Ù' : Systems.AddStr(Target,'False');
   'ü' : Systems.AddStr(Target,'Function');
   'Ó' : Systems.AddStr(Target,'In');
   '?' : Systems.AddStr(Target,'If');
   '®' : Systems.AddStr(Target,'Then');
   '!' : Systems.AddStr(Target,'Not');
   '¢' : Systems.AddStr(Target,'Open');
   '|' : Systems.AddStr(Target,'or');
   'ï' : Systems.AddStr(Target,'Close');
   'û' : Systems.AddStr(Target,'Procedure');
   'õ' : Systems.AddStr(Target,'Str');
   '$' : Systems.AddStr(Target,'String');
   'ù' : Systems.AddStr(Target,'True');
   'ö' : Systems.AddStr(Target,'Up');
   '˝' : Systems.AddStr(Target,'Word');
    Else IncStr(Target,S[I]);
  End;
 End;
 AddStrPasType:=Target;
End;

Function AddSpcUStrPasType(S:Byte;Str:String):String;Begin
 AddSpcUStrPasType:=AddStrPasType(Spc(S)+Str);
End;

Procedure ALAddSepBar(Var Lst:ArrayList);Begin
 ALAddStr(Lst,'{'+MultChr('ƒ',75)+'}');
End;

Procedure CompileRC;
Type FormatHeader=(fhFunc,fhProc);
Var Name,Func,_Type,NameType,S,a,b:String;
    Year,Month,Day,Week,InsProc,InsUses,_Begin,I,J,NumHeader:Wd;
    IPath,MaxPath,MaxHeader,FirstElement,IHeader,MaxBuf:Int;
    CurrFunc:(None,Variable,LoadIni,SetupPath);
    Target,Files:PathStr;
    Lst,BankName,BankSetupPath:ArrayList;
    FP,FS:Long;
    K:Byte;
    PC:Array[Byte]of Char;
    HdlSource,HdlTarget:Hdl;

 Procedure Return(Code:Int);Begin
  ErrCode:=Code;
  WriteLn('êchec de conversion!');
  FileClose(HdlSource);
  FileClose(HdlTarget);
  ALDone(BankName);
  ALDone(BankSetupPath);
 End;

 Procedure _InsStr(P:Long;Str:String);Begin
  ALInsStr(Lst,P,Str);
 End;

 Procedure _AddSpcUStrPas(Str:String);Begin
  ALAddStr(Lst,AddSpcUStrPasType(Byte(Str[1]),Copy(Str,2,255)));
 End;

 Procedure _AddSpcUStr(Spc:Byte;Str:String);Begin
  ALAddSpcUStr(Lst,Spc,Str);
 End;

 Procedure _AddStrPas(Const Str:String);Begin
  ALAddStr(Lst,AddStrPasType(Str));
 End;

 Procedure _AddLn;Begin
  ALAddLn(Lst);
 End;

 Function MaxHeaderPath:Int;Var I,N:Long;PC:PChr;Begin
  N:=0;
  ALSetPtr(BankSetupPath,0);
  For I:=0to ALMax(BankSetupPath)do Begin
   PC:=_ALGetCurrBuf(BankSetupPath);
   If(PC<>NIL)Then Begin
    Case PC^[0]of
     #1: Inc(N);
    End;
   End;
   ALNext(BankSetupPath);
  End;
  MaxHeaderPath:=N-1;
 End;

 Function GetMaxPathInSetup(P:Long;Var FirstElement:Int):Int;Var I,N,NP:Long;PC:PChr;Ok:Bool;Begin
  NP:=0; N:=0; Ok:=No; Inc(P);
  ALSetPtr(BankSetupPath,0);
  For I:=0to ALMax(BankSetupPath)do Begin
   PC:=_ALGetCurrBuf(BankSetupPath);
   If(PC<>NIL)Then Begin
    Case PC^[0]of
     #1 : Begin
	   If(Ok)Then Break;
	   Inc(N);
	   If(N=P)Then Begin Ok:=True;FirstElement:=I+1;End;
	  End;
     #2 : If(Ok)Then Inc(NP);
    End;
   End;
   ALNext(BankSetupPath);
  End;
  GetMaxPathInSetup:=NP-1;
 End;

 Procedure GetDataPath(I:Int;Var Str,Name:String);Var S:String;J:Byte;Begin
  S:=Copy(StrPas(_ALGetBuf(BankSetupPath,I)),2,255);
  For J:=1to Length(S)do If S[J]='"'Then Begin
   Inc(J);
   Break;
  End;
  Str:=Left(S,J-2);Name:=Copy(S,J,255);
 End;

 Procedure _AddSpcUStrX(S:Byte;Const b:String);Var S1:String;I:Byte;Begin
  S1:='';
  For I:=1 to Length(b)do Case b[I] of
	       mtkbEsc : AddStr(S1,'kbEsc');
		mtkbUp : AddStr(S1,'kbUp');
		mtkbDn : AddStr(S1,'kbDn');
	       mtkbTab : AddStr(S1,'kbTab');
	     mtkbEnter : AddStr(S1,'kbEnter');
             mtkbClose : AddStr(S1,'kbClose');
	   mtWMaxXTxts : AddStr(S1,'WEMaxXTxts(W)');
	   mtWMaxYTxts : AddStr(S1,'WEMaxYTXts(W)');
	     mtStrNew_ : AddStr(S1,'StrNew(');
	 mtStrDispose_ : AddStr(S1,'StrDispose(');
	 mtWPutPTxtXY_ : AddStr(S1,'WEPutPTxtXY(W,');
	  mtWPutTxtXY_ : AddStr(S1,'WEPutTxtXY(W,');
	    mtWClrEol_ : AddStr(S1,'WEClrEol(W);');
	     mtWSetKr_ : AddStr(S1,'WESetKr(W,');
       mtWSetKrBorder_ : AddStr(S1,'WESetKrBorder(W);');
    mtWBarSpcHorShade_ : AddStr(S1,'WEBarSpcHorShade(W,');
	      mtBreak_ : AddStr(S1,'Break;');
		  mtLN : Begin
			 _AddSpcUStr(S,S1);
			 S1:='';
			End;
		   Else IncStr(S1,b[I]);
  End;
  _AddSpcUStr(S,S1);
 End;

 Procedure SetupPathCopyPathBuf2(S:Byte;Const b:String);Begin
  _AddSpcUStrPas(Char(S)+'õCopy(@PathBuf,T'+b+');');
 End;

 Procedure SetupPathInput(S,Y:Byte;Const b:String);Begin
  SetupPathCopyPathBuf2(S,b);
  _AddSpcUStrX(S,'K:=_WEInput(W,0,'+IntToStr(Y)+',wnMax-1,80,PPathBuf);');
  _AddSpcUStrX(S,mtStrDispose_+'T'+b+');');
  _AddSpcUStrX(S,'T'+b+':='+mtStrNew_+'PPathBuf);');
  _AddSpcUStrX(S,mtWSetKr_+'$8F);');
  _AddSpcUStrX(S,'WEBarSelHor(W,0,'+IntToStr(Y)+',wnMax-1);');
 End;

 Procedure SetupPathInput_(S,X1,Y:Byte;Const X2,b:String);Begin
  SetupPathCopyPathBuf2(S,b);
  _AddSpcUStr(S,'K:=_WEInput(W,'+IntToStr(X1)+','+IntToStr(Y)+','+X2+',80,PPathBuf);');
  _AddSpcUStrX(S,mtStrDispose_+'T'+b+');');
  _AddSpcUStrX(S,'T'+b+':='+mtStrNew_+'PPathBuf);');
  _AddSpcUStrX(S,mtWSetKr_+'$8F);');
  _AddSpcUStrX(S,'WEBarSelHor(W,'+IntToStr(X1)+','+IntToStr(Y)+','+X2+');');
 End;

 Procedure SetupPathkbEnterEsc(S:Byte);Begin
  _AddSpcUStrX(S,mtkbEnter+':If DirExist(StrPas(T'+b+'))Then P:=2');
  _AddSpcUStrX(S+Length(b)+30,'Else __PathNotFound;');
  _AddSpcUStrX(S,mtkbEsc+','+mtkbClose+':'+mtBreak_);
  _AddSpcUStrX(S,'kbInWn:MouseAction;');
 End;

 Procedure SetupPathInput3A(S,Y:Byte;Const b:String);Begin
  SetupPathInput_(S,0,Y,'20',b);
 End;

 Procedure SetupPathInput3B(S,Y:Byte;Const b:String);Begin
  SetupPathInput_(S,23,Y,'43',b);
 End;

 Procedure SetupPathInput3C(S,Y:Byte;Const b:String);Begin
  SetupPathInput_(S,46,Y,'wnMax-1',b);
 End;

 Function ExtractNot(Chr:Char):String;Var Str:String;Begin
  Str:='';
  While PC[ErrI]<>Chr do Begin
   IncStr(Str,PC[ErrI]);
   Inc(ErrI);
  End;
  ExtractNot:=Str;
 End;

 Procedure SkipSpc;Begin
  While PC[ErrI]=' 'do Inc(ErrI);
 End;

 Procedure RBHeader(Format:FormatHeader;Const Name:String);Var H:String;XC:Byte;Begin
  Case(Format)of
   fhProc:H:='ProcÇdure ';
   Else H:='Fonction ';
  End;
  XC:=(74-Length(H+Name))shr 1;
  _AddStrPas('{⁄'+MultChr('ƒ',74)+'‹');
  _AddStrPas(' ≥'+Spc(XC)+H+Name+Spc(74-XC-Length(H+Name))+'€');
  _AddStrPas(' ¿'+MultChr('‹',74)+'€');
  _AddLn;
  _AddLn;
  _AddStrPas(' Description');
  _AddStrPas(' ÕÕÕÕÕÕÕÕÕÕÕ');
  _AddLn;
 End;

 Procedure Finish;Var I:Int;Begin
  _AddLn;
  ALAddSepBar(Lst);
  ALAddStr(Lst,'END.');
  DeleteFile(Target);
  HdlTarget:=FileCreate(Target);
  If(HdlTarget=errHdl)Then Return($7FFF);
  For I:=0to ALMax(Lst)do PutFileTxtLn(HdlTarget,_ALGetStr(Lst,I));
  FileClose(HdlTarget);
  ALDone(BankName);
  ALDone(BankSetupPath);
  WriteLn('Conversion rÇussit!');
 End;

Begin
 CurrFunc:=None;ErrCode:=0;_Begin:=0;InsProc:=8;InsUses:=13;
 ALInit(Lst);
 ALInit(BankName);
 ALInit(BankSetupPath);
 HdlSource:=FileOpen(Source,fmRead);
 If(HdlSource=errHdl)Then Begin
  Return(errFileNotFound);
  Exit;
 End;
 Target := Path2NoExt(Source)+'.PAS';
 WriteLn('Convertie: ',Source,' Ö ',Target);
 ALAddStr(Lst,'Unit '+Path2Name(Source)+';');
 ALAddLn(Lst);
 ALAddSepBar(Lst);
 ALAddStr(Lst,Spc((77-9)shr 1)+'INTERFACE');
 ALAddSepBar(Lst);
 ALAddLn(Lst);
 ALAddStr(Lst,'Uses Systex,Isatex;');
 ALAddLn(Lst);
 ALAddLn(Lst);
 ALAddSepBar(Lst);
 ALAddStr(Lst,Spc((77-14)shr 1)+'IMPLEMENTATION');
 ALAddSepBar(Lst);
 ALAddLn(Lst);
 ALAddStr(Lst,'Uses Video,Systems,Dials,DialPlus,Terminal;');
 ALAddLn(Lst);
 FP:=0;FS:=FileSize(HdlSource);
 Repeat
  SetFilePos(HdlSource,FP);
  S:=GetFileTxtLn(HdlSource);
  If GetSysErr<>0Then Begin SetSysErr(errEdtRead);Break;End;
  Inc(FP,Length(S)+2);
  StrPCopy(@PC,S);
  ErrI:=0;
  While PC[ErrI]<>#0do Begin
   Case PC[ErrI]of
    'A'..'Z','a'..'z','_':Case CurrFunc of
     None:Begin
      Name:=PXtrkWord(ErrI,@PC);
      If StrUp(Name)='USES'Then Begin
       ALDelBuf(Lst,InsUses);
       _InsStr(InsUses,'Uses Video,Systems,Dials,DialPlus,Terminal,Mouse,'#13#10+
		 Copy(StrPas(@PC),ErrI+2,255)+';');
       Break;
      End;
      If StrUp(Name)='VARIABLE'Then CurrFunc:=Variable
       Else
      Begin
       SkipSpc;
       Func:=StrUp(PXtrkWord(ErrI,@PC));
       If Func='SETUPPATH'Then CurrFunc:=SetupPath Else
       If Func='LOADINI'Then Begin
	NumHeader:=0;CurrFunc:=LoadIni;
	SkipSpc;
	If PC[ErrI]<>'"'Then Begin
	 Return(GuillExpected);
	 Exit;
	End;
	Inc(ErrI);
	Files:=ExtractNot('"');
	If PC[ErrI]<>'"'Then Begin
	 Return(GuillExpected);
	 Exit;
	End;
	Inc(ErrI);
       End;
      End;
     End;
     Variable:Begin
      If _Begin=1Then Begin
       _Type:=PXtrkWord(ErrI,@PC);
       If _Type='BEGIN'Then Begin Return(MisplacedBeginSymbol);Exit;End else
       If _Type='END'Then Begin CurrFunc:=None;Dec(_Begin);End
	Else
       Begin
	SkipSpc;
	Name:=PXtrkWord(ErrI,@PC);
	If Name=''Then Begin Return(VarNameExpected);Exit;End;
	If InsProc=8Then Begin
	 _InsStr(8,'Var');
	 _InsStr(9,'');
	 Inc(InsProc,2);
	 Inc(InsUses,2);
	End;
	_InsStr(9,Spc(4)+Name+':'+_Type+';');
	Inc(InsProc);
	Inc(InsUses);
       End;
      End
       Else
      Begin
       Func:=PXtrkWord(ErrI,@PC);
       If StrUp(Func)='BEGIN'Then Inc(_Begin)Else Begin Return(BeginExpected);Exit;End;
      End;
     End;
     SetupPath:Begin
      If _Begin=1Then Begin
       Func:=StrUp(PXtrkWord(ErrI,@PC));
       If Func='BEGIN'Then Begin Return(MisplacedBeginSymbol);Exit;End else
       If Func='END'Then Begin
	MaxHeader:=MaxHeaderPath;
	MaxBuf:=ALMax(BankSetupPath);
	_InsStr(InsProc,'Function '+Name+':Bool;');
        RBHeader(fhFunc,Name);
        ALAddStr(Lst,'  Cette fonction permet de sÇlectionner de faáon organisÇ un/des chemin(s) de');
        _AddStrPas(' rÇpertoires Ö travers un tableaux utilisateur.');
        _AddLn;
        _AddLn;
        _AddStrPas(' Retour');
        _AddStrPas(' ÕÕÕÕÕÕ');
        _AddLn;
        _AddStrPas('  True     Des modifications ont ÇtÇ apportÇes par l''utilisateur');
        _AddStrPas('  False    Aucune modification n''a ÇtÇ apportÇe par l''utilisateur');
        _AddStrPas('}');
        _AddLn;
	_AddStrPas('ü '+Name+';');
	ALAddStr(Lst,'Var P,PP:Byte;W:Window;L:LstMnu;K:Word;');
	_AddSpcUStr(4,'PathBuf:Array[Byte]of Char;PPathBuf:PChr;');
	For IPath:=0to(MaxBuf)do Begin
	 S:=StrPas(_ALGetBuf(BankSetupPath,IPath));
	 If StrI(1,S)=#2Then Begin
	  GetDataPath(IPath,a,b);
	  _AddSpcUStr(4,'T'+b+':PChr;');
	 End;
	End;
	_AddLn;
	_AddSpcUStrPas(#1'û UpDateDir;Æ');
	_AddSpcUStr(1,' Case LMGetVal(L)of');
	IHeader:=0;
	For IPath:=0to ALMax(BankSetupPath)do Begin
	 S:=StrPas(_ALGetBuf(BankSetupPath,IPath));
	 If StrI(1,S)=#1Then Begin
	  Inc(IHeader);
	  _AddSpcUStrPas(#3+IntToStr(IHeader)+':Æ');
	  MaxPath:=GetMaxPathInSetup(IHeader-1,FirstElement);
	  Inc(IPath);
	  Case(MaxPath)of
	   0:Begin
	    GetDataPath(IPath,a,b);
	    _AddSpcUStrX(4,mtWSetKrBorder_+mtLN+
	                 mtWPutTxtXY_+'0,7,'''+a+''');'+mtLN+
             	         mtWClrEol_+mtLN+
	                 mtWSetKr_+'$8F);'+mtLN+
	                 mtWBarSpcHorShade_+'0,8,wnMax-1);'+mtLN+
	                 mtWPutPTxtXY_+'0,8,T'+b+');'+mtLN+
	                 'WEClrWnBorder(W,0,10,wnMax,wnMax-2);');
	   End;
	   1:Begin
	    GetDataPath(IPath,a,b);
	    _AddSpcUStrX(4,mtWSetKrBorder_+mtLN+
	       mtWPutTxtXY_+'0,7,'''+a+''');'+mtLN+
	       mtWClrEol_+mtLN+
	       mtWSetKr_+'$8F);'+mtLN+
	       mtWBarSpcHorShade_+'0,8,wnMax-1);'+mtLN+
	       mtWPutPTxtXY_+'0,8,T'+b+');');
	    Inc(IPath);
	    GetDataPath(IPath,a,b);
	    _AddSpcUStrX(4,mtWSetKrBorder_+mtLN+
	       mtWPutTxtXY_+'0,10,'''+a+''');'+mtLN+
	       mtWClrEol_+mtLN+
	       mtWSetKr_+'$8F);'+mtLN+
	       mtWBarSpcHorShade_+'0,11,wnMax-1);'+mtLN+
	       mtWPutPTxtXY_+'0,11,T'+b+');'+mtLN+
	       'WEClrWnBorder(W,0,13,wnMax,wnMax-2);');
	     End;
	   2:Begin
	      GetDataPath(IPath,a,b);
	      _AddSpcUStrX(4,mtWSetKrBorder_+mtLN+
	       mtWPutTxtXY_+'0,7,'''+a+''');'+mtLN+
	       mtWClrEol_+mtLN+
	       mtWSetKr_+'$8F);'+mtLN+
	       mtWBarSpcHorShade_+'0,8,wnMax-1);'+mtLN+
	       mtWPutPTxtXY_+'0,8,T'+b+');');
	      Inc(IPath);
	      GetDataPath(IPath,a,b);
	      _AddSpcUStrX(4,mtWSetKrBorder_+mtLN+
	       mtWPutTxtXY_+'0,10,'''+a+''');'+mtLN+
	       mtWClrEol_+mtLN+
	       mtWSetKr_+'$8F);'+mtLN+
	       mtWBarSpcHorShade_+'0,11,wnMax-1);'+mtLN+
	       mtWPutPTxtXY_+'0,11,T'+b+');');
	      Inc(IPath);
	      GetDataPath(IPath,a,b);
	      _AddSpcUStrX(4,mtWSetKrBorder_+mtLN+
	       mtWPutTxtXY_+'0,13,'''+a+''');'+mtLN+
	       mtWClrEol_+mtLN+mtWSetKr_+'$8F);'+mtLN+
	       mtWBarSpcHorShade_+'0,14,wnMax-1);'+mtLN+
	       mtWPutPTxtXY_+'0,14,T'+b+');'+mtLN+
	       'WEClrWnBorder(W,0,16,wnMax,wnMax-2);');
	     End;
	   3:Begin
	      GetDataPath(IPath,a,b);
	      _AddSpcUStrX(4,'WEClrWnBorder(W,0,8,wnMax,wnMax-2);'+mtLN+
	       mtWSetKrBorder_+mtLN+mtWPutTxtXY_+'0,7,'''+a+''');'+mtLN+
	       mtWClrEol_+mtLN+
	       mtWSetKr_+'$8F);'+mtLN+
	       mtWBarSpcHorShade_+'0,8,31);'+mtLN+
	       mtWPutPTxtXY_+'0,8,T'+b+');');
	      Inc(IPath);
	      GetDataPath(IPath,a,b);
	      _AddSpcUStrX(4,mtWSetKrBorder_+mtLN+
	       mtWPutTxtXY_+'34,7,'''+a+''');'+mtLN+
	       mtWSetKr_+'$8F);'+mtLN+
	       mtWBarSpcHorShade_+'34,8,wnMax-1);'+mtLN+
	       mtWPutPTxtXY_+'34,8,T'+b+');');
	      Inc(IPath);
	      GetDataPath(IPath,a,b);
	      _AddSpcUStrX(4,mtWSetKrBorder_+mtLN+
	       mtWPutTxtXY_+'0,10,'''+a+''');'+mtLN+
	       mtWClrEol_+mtLN+
	       mtWSetKr_+'$8F);'+mtLN+
	       mtWBarSpcHorShade_+'0,11,31);'+mtLN+
	       mtWPutPTxtXY_+'0,11,T'+b+');');
	      Inc(IPath);
	      GetDataPath(IPath,a,b);
	      _AddSpcUStrX(4,mtWSetKrBorder_+mtLN+
	       mtWPutTxtXY_+'34,10,'''+a+''');'+mtLN+
	       mtWSetKr_+'$8F);'+mtLN+
	       mtWBarSpcHorShade_+'34,11,wnMax-1);'+mtLN+
	       mtWPutPTxtXY_+'34,11,T'+b+');');
	     End;
	 4,5:Begin
	      GetDataPath(IPath,a,b);
	      _AddSpcUStrX(4,'WEClrWnBorder(W,0,8,wnMax,wnMax-2);'+mtLN+
	       mtWSetKrBorder_+mtLN+
	       mtWPutTxtXY_+'0,7,'''+a+''');'+mtLN+
	       mtWSetKr_+'$8F);'+mtLN+
	       mtWBarSpcHorShade_+'0,8,31);'+mtLN+
	       mtWPutPTxtXY_+'0,8,T'+b+');');
	      Inc(IPath);
	      GetDataPath(IPath,a,b);
	      _AddSpcUStrX(4,mtWSetKrBorder_+mtLN+
	       mtWPutTxtXY_+'34,7,'''+a+''');'+mtLN+
	       mtWSetKr_+'$8F);'+mtLN+
	       mtWBarSpcHorShade_+'34,8,wnMax-1);'+mtLN+
	       mtWPutPTxtXY_+'34,8,T'+b+');');
	      Inc(IPath);
	      GetDataPath(IPath,a,b);
	      _AddSpcUStrX(4,mtWSetKrBorder_+mtLN+
	       mtWPutTxtXY_+'0,10,'''+a+''');'+mtLN+
	       mtWSetKr_+'$8F);'+mtLN+
	       mtWBarSpcHorShade_+'0,11,31);'+mtLN+
	       mtWPutPTxtXY_+'0,11,T'+b+');');
	      Inc(IPath);
	      GetDataPath(IPath,a,b);
	      _AddSpcUStrX(4,mtWSetKrBorder_+mtLN+
	       mtWPutTxtXY_+'34,10,'''+a+''');'+mtLN+
	       mtWSetKr_+'$8F);'+mtLN+
	       mtWBarSpcHorShade_+'34,11,wnMax-1);'+mtLN+
	       mtWPutPTxtXY_+'34,11,T'+b+');');
	      Inc(IPath);
	      GetDataPath(IPath,a,b);
	      _AddSpcUStrX(4,mtWSetKrBorder_+mtLN+
	       mtWPutTxtXY_+'0,13,'''+a+''');'+mtLN+
	       mtWSetKr_+'$8F);'+mtLN+
	       mtWBarSpcHorShade_+'0,14,31);'+mtLN+
	       mtWPutPTxtXY_+'0,14,T'+b+');');
	       If MaxPath=5Then
	       Begin
		Inc(IPath);
		GetDataPath(IPath,a,b);
		_AddSpcUStrX(4,mtWSetKrBorder_+mtLN+
		 mtWPutTxtXY_+'34,13,'''+a+''');'+mtLN+
		 mtWSetKr_+'$8F);'+mtLN+
		 mtWBarSpcHorShade_+'34,14,wnMax-1);'+mtLN+
		 mtWPutPTxtXY_+'34,14,T'+b+');');
	       End;
	      End;
	 6,7,8:Begin
	       GetDataPath(IPath,a,b);
	       _AddSpcUStrX(4,'WEClrWnBorder(W,0,7,wnMax,wnMax-2);'+mtLN+
		mtWSetKrBorder_+mtLN+
		mtWPutTxtXY_+'0,7,'''+a+''');'+mtLN+
		mtWSetKr_+'$8F);'+mtLN+
		mtWBarSpcHorShade_+'0,8,20);'+mtLN+
		mtWPutPTxtXY_+'0,8,T'+b+');');
	       Inc(IPath);
	       GetDataPath(IPath,a,b);
	       _AddSpcUStrX(4,mtWSetKrBorder_+mtLN+
		mtWPutTxtXY_+'23,7,'''+a+''');'+mtLN+
		mtWSetKr_+'$8F);'+mtLN+
		mtWBarSpcHorShade_+'23,8,43);'+mtLN+
		mtWPutPTxtXY_+'23,8,T'+b+');');
	       Inc(IPath);
	       GetDataPath(IPath,a,b);
	       _AddSpcUStrX(4,mtWSetKrBorder_+mtLN+
		mtWPutTxtXY_+'46,7,'''+a+''');'+mtLN+
		mtWSetKr_+'$8F);'+mtLN+
		mtWBarSpcHorShade_+'46,8,wnMax-1);'+mtLN+
		mtWPutPTxtXY_+'46,8,T'+b+');');
	       Inc(IPath);
	       GetDataPath(IPath,a,b);
	       _AddSpcUStrX(4,mtWSetKrBorder_);
	       _AddSpcUStrX(4,mtWPutTxtXY_+'0,10,'''+a+''');');
	       _AddSpcUStrX(4,mtWSetKr_+'$8F);');
	       _AddSpcUStrX(4,mtWBarSpcHorShade_+'0,11,20);');
	       _AddSpcUStrX(4,mtWPutPTxtXY_+'0,11,T'+b+');');
	       Inc(IPath);
	       GetDataPath(IPath,a,b);
	       _AddSpcUStrX(4,mtWSetKrBorder_);
	       _AddSpcUStrX(4,mtWPutTxtXY_+'23,10,'''+a+''');');
	       _AddSpcUStrX(4,mtWSetKr_+'$8F);');
	       _AddSpcUStrX(4,mtWBarSpcHorShade_+'23,11,43);');
	       _AddSpcUStrX(4,mtWPutPTxtXY_+'23,11,T'+b+');');
	       Inc(IPath);
	       GetDataPath(IPath,a,b);
	       _AddSpcUStrX(4,mtWSetKrBorder_);
	       _AddSpcUStrX(4,mtWPutTxtXY_+'46,10,'''+a+''');');
	       _AddSpcUStrX(4,mtWSetKr_+'$8F);');
	       _AddSpcUStrX(4,mtWBarSpcHorShade_+'46,11,wnMax-1);');
	       _AddSpcUStrX(4,mtWPutPTxtXY_+'46,11,T'+b+');');
	       Inc(IPath);
	       GetDataPath(IPath,a,b);
	       _AddSpcUStrX(4,mtWSetKrBorder_);
	       _AddSpcUStrX(4,mtWPutTxtXY_+'0,13,'''+a+''');');
	       _AddSpcUStrX(4,mtWSetKr_+'$8F);');
	       _AddSpcUStrX(4,mtWBarSpcHorShade_+'0,14,20);');
	       _AddSpcUStrX(4,mtWPutPTxtXY_+'0,14,T'+b+');');
	       If MaxPath>6Then Begin
		Inc(IPath);
		GetDataPath(IPath,a,b);
		_AddSpcUStrX(4,mtWSetKrBorder_);
		_AddSpcUStrX(4,mtWPutTxtXY_+'23,13,'''+a+''');');
		_AddSpcUStrX(4,mtWSetKr_+'$8F);');
		_AddSpcUStrX(4,mtWBarSpcHorShade_+'23,14,43);');
		_AddSpcUStrX(4,mtWPutPTxtXY_+'23,14,T'+b+');');
		If MaxPath>7Then Begin
		 Inc(IPath);
		 GetDataPath(IPath,a,b);
		 _AddSpcUStrX(4,mtWSetKrBorder_);
		 _AddSpcUStrX(4,mtWPutTxtXY_+'46,13,'''+a+''');');
		 _AddSpcUStrX(4,mtWSetKr_+'$8F);');
		 _AddSpcUStrX(4,mtWBarSpcHorShade_+'46,14,wnMax-1);');
		 _AddSpcUStrX(4,mtWPutPTxtXY_+'46,14,T'+b+');');
		End;
	       End;
	      End;
	 Else Begin
	  Return(TooManyPathInHeader);
	  Exit;
	 End;
	End;
	_AddSpcUStrPas(#3'Ø');
       End;
       If(IPath>MaxBuf)Then Break;
	End;
	_AddSpcUStrPas(#2'Ø');
	_AddSpcUStrPas(#1'Ø');
	_AddLn;
        _AddSpcUStrPas(#1'û MouseAction;Var OP,MX,MY:Byte;Æ');
        _AddSpcUStrPas(#2'MX:=LastMsX-WEGetRX1(W);MY:=LastMsY-WEGetRY1(W);OP:=P;');
        _AddSpcUStrPas(#2'Case(MY)of');
        _AddSpcUStrPas(#3'0..6:P:=0;');
        _AddSpcUStrPas(#3'7..15:Æ');
        _AddSpcUStrPas(#4'P:=1;');
        IHeader:=0;
        _AddSpcUStrPas(#4'Case LMGetVal(L)of');
        For IPath:=0to ALMax(BankSetupPath)do Begin
         S:=StrPas(_ALGetBuf(BankSetupPath,IPath));
         If StrI(1,S)=#1Then Begin
	  Inc(IHeader);
          MaxPath:=GetMaxPathInSetup(IHeader-1,FirstElement);
          Case(MaxPath)of
           0:_AddSpcUStrPas(#5+WordToStr(IHeader)+':;');
           1,2:Begin
            _AddSpcUStrPas(#5+WordToStr(IHeader)+':Æ');
            _AddSpcUStrPas(#6'PP:=(MY-7)div 3;');
            _AddSpcUStrPas(#6'If PP>'+WordToStr(MaxPath)+'Then PP:='+WordToStr(MaxPath)+';');
            _AddSpcUStrPas(#5'Ø');
           End;
           3:Begin
            _AddSpcUStrPas(#5+WordToStr(IHeader)+':Æ');
            _AddSpcUStrPas(#6'PP:=(((MY-7)div 3)shl 1)+(MX shr 5);');
            _AddSpcUStrPas(#6'If PP>'+WordToStr(MaxPath)+'Then PP:='+WordToStr(MaxPath)+';');
            _AddSpcUStrPas(#5'Ø');
           End;
           8:Begin
            _AddSpcUStrPas(#5+WordToStr(IHeader)+':Æ');
            _AddSpcUStrPas(#6'PP:=((MY-7)div 3)*3+(MX div 22);');
            _AddSpcUStrPas(#6'If PP>'+WordToStr(MaxPath)+'Then PP:='+WordToStr(MaxPath)+';');
            _AddSpcUStrPas(#5'Ø');
           End;
          End;
         End;
        End;
        _AddSpcUStrPas(#4'Ø');
        _AddSpcUStrPas(#3'Ø');
        _AddSpcUStrPas(#3'16..18:P:=2;');
        _AddSpcUStrPas(#2'Ø');
        _AddSpcUStrPas(#2'If(P<>OP)and(MY<16)Then WaitMsBut0;');
        _AddSpcUStrPas(#1'Ø');
        _AddLn;
	_AddStrPas('Æ');
	_AddSpcUStr(1,Name+':=No;');
	_AddSpcUStr(1,'WEInitO(W,70,20);');
	_AddSpcUStr(1,'WEPushWn(W);');
	_AddSpcUStr(1,'WEPutWnKrDials(W,''RÇpertoire'');');
        _AddSpcUStr(1,'WECloseIcon(W);');
        _AddSpcUStr(1,'WEBar(W);');
	_AddSpcUStr(1,'SetShade(No);');
	_AddSpcUStr(1,'WESubList(W,0,0,wnMax-1,5,''CatÇgorie'',L);');
	_AddSpcUStr(1,'LMPutSmallShade(L);');
        _AddSpcUStr(1,'LMPutBarMouseRight(L);');
	IHeader:=0;
	For IPath:=0to(MaxBuf)do Begin
	 S:=StrPas(_ALGetBuf(BankSetupPath,IPath));
	 If StrI(1,S)=#1Then Begin
	  Inc(IHeader);
	  _AddSpcUStrPas(#1'ALAddõByte(L.List,'''+Copy(S,2,255)+''','+IntToStr(IHeader)+');');
	 End;
	End;
	_AddSpcUStr(1,'LMRefresh(L);');
	_AddSpcUStr(1,'LMSelBarInactive(L);');
	_AddSpcUStr(1,'WEPutkHorDn(W,''Correcte|Annule'');');
	_AddSpcUStr(1,'P:=0;PP:=0;PPathBuf:=@PathBuf;');
	For IPath:=0to ALMax(BankSetupPath)do Begin
	 S:=StrPas(_ALGetBuf(BankSetupPath,IPath));
	 If StrI(1,S)=#2Then Begin
	  GetDataPath(IPath,a,b);
	  _AddSpcUStrPas(#1'T'+b+':=õNew('+b+');');
	 End;
	End;
	_AddSpcUStr(1,'UpDateDir;');
	_AddSpcUStr(1,'WESetInpColors(W,$8F,W.Palette.Sel);');
	_AddSpcUStr(1,'Repeat');
	_AddSpcUStr(2,'Case(P)of');
	_AddSpcUStrPas(#3'0:Æ');
	_AddSpcUStr(4,'PP:=0;');
	_AddSpcUStr(4,'LMSelBar(L);');
	_AddSpcUStr(4,'K:=WEReadk(L.W);');
	_AddSpcUStr(4,'LMSelBarInactive(L);');
	_AddSpcUStr(4,'Case(K)of');
	_AddSpcUStrPas(#5'kbUp,kbRBarMsUp:Æ');
        _AddSpcUStr(6,'If(K=kbRBarMsUp)Then DelayMsPress(100);');
	_AddSpcUStr(6,'LMkUp(L);');
	_AddSpcUStr(6,'UpDateDir;');
	_AddSpcUStrPas(#5'Ø');
	_AddSpcUStrPas(#5'kbDn,kbRBarMsDn:Æ');
        _AddSpcUStr(6,'If(K=kbRBarMsDn)Then DelayMsPress(100);');
	_AddSpcUStr(6,'LMkDn(L);');
	_AddSpcUStr(6,'UpDateDir;');
	_AddSpcUStrPas(#5'Ø');
        _AddSpcUStrPas(#5'kbInWn:Æ');
        _AddSpcUStrPas(#6'If L.Y<>LastMsY-WEGetRY1(L.W)Then Æ');
        _AddSpcUStrPas(#7'__HideMousePtr;');
        _AddSpcUStrPas(#7'LMUnSelBar(L);');
        _AddSpcUStrPas(#7'Dec(L.P,L.Y);');
        _AddSpcUStrPas(#7'L.Y:=LastMsY-WEGetRY1(L.W);');
        _AddSpcUStrPas(#7'Inc(L.P,L.Y);');
        _AddSpcUStrPas(#7'LMSelBar(L);');
        _AddSpcUStrPas(#7'__ShowMousePtr');
        _AddSpcUStrPas(#6'Ø');
        _AddSpcUStrPas(#6'WaitMsBut0;');
        _AddSpcUStrPas(#6'UpDateDir;');
        _AddSpcUStrPas(#5'Ø');
        _AddSpcUStrPas(#5'kbMouse:Æ');
        _AddSpcUStrPas(#6'If WEInCloseIcon(W,LastMsX,LastMsY)Then Break Else');
        _AddSpcUStrPas(#6'If WEInWindow(W,LastMsX,LastMsY)Then MouseAction;');
        _AddSpcUStrPas(#5'Ø');
	_AddSpcUStrX(5,mtkbTab+':P:=1;');
	_AddSpcUStrX(5,mtkbEsc+','+mtkbClose+':'+mtBreak_);
	_AddSpcUStrPas(#4'Ø');
	_AddSpcUStrPas(#3'Ø');
	_AddSpcUStrPas(#3'1:Case LMGetVal(L)of');
	IHeader:=0;
	For IPath:=0to ALMax(BankSetupPath)do Begin
	 S:=StrPas(_ALGetBuf(BankSetupPath,IPath));
	 If StrI(1,S)=#1Then Begin
	  Inc(IHeader);
	  _AddSpcUStrPas(#4+IntToStr(IHeader)+':Æ');
	  MaxPath:=GetMaxPathInSetup(IHeader-1,FirstElement);
	  Inc(IPath);
	  Case(MaxPath)of
	   0:Begin
	    GetDataPath(IPath,a,b);
	    SetupPathInput(5,8,b);
	    _AddSpcUStr(5,'Case(K)of');
	    _AddSpcUStrX(6,mtkbUp+':P:=0;');
	    _AddSpcUStrX(6,mtkbDn+','+mtkbTab+':P:=2;');
            SetupPathkbEnterEsc(6);
	    _AddSpcUStrPas(#5'Ø');
	   End;
	   1:Begin
	    GetDataPath(IPath,a,b);
	    _AddSpcUStr(5,'Case(PP)of');
	    _AddSpcUStrPas(#6'0:Æ');
	    SetupPathInput(7,8,b);
	    _AddSpcUStr(7,'Case(K)of');
	    _AddSpcUStrX(8,mtkbUp+':P:=0;');
	    _AddSpcUStrX(8,mtkbDn+','+mtkbTab+':PP:=1;');
            SetupPathkbEnterEsc(8);
	    _AddSpcUStrPas(#7'Ø');
	    _AddSpcUStrPas(#6'Ø');
	    Inc(IPath);
	    GetDataPath(IPath,a,b);
	    _AddSpcUStrPas(#6'1:Æ');
	    SetupPathInput(7,11,b);
	    _AddSpcUStr(7,'Case(K)of');
	    _AddSpcUStrX(8,mtkbUp+':PP:=0;');
	    _AddSpcUStrX(8,mtkbDn+','+mtkbTab+':P:=2;');
            SetupPathkbEnterEsc(8);
	    _AddSpcUStrPas(#7'Ø');
	    _AddSpcUStrPas(#6'Ø');
	    _AddSpcUStrPas(#5'Ø');
	   End;
	   2:Begin
	    GetDataPath(IPath,a,b);
	    _AddSpcUStr(5,'Case(PP)of');
	    _AddSpcUStrPas(#6'0:Æ');
	    SetupPathInput(7,8,b);
	    _AddSpcUStr(7,'Case(K)of');
	    _AddSpcUStrX(8,mtkbUp+':P:=0;');
	    _AddSpcUStrX(8,mtkbDn+','+mtkbTab+':PP:=1;');
            SetupPathkbEnterEsc(8);
	    _AddSpcUStrPas(#7'Ø');
	    _AddSpcUStrPas(#6'Ø');
	    Inc(IPath);
	    GetDataPath(IPath,a,b);
	    _AddSpcUStrPas(#6'1:Æ');
	    SetupPathInput(7,11,b);
	    _AddSpcUStr(7,'Case(K)of');
	    _AddSpcUStrX(8,mtkbUp+':PP:=0;');
	    _AddSpcUStrX(8,mtkbDn+','+mtkbTab+':PP:=2;');
            SetupPathkbEnterEsc(8);
	    _AddSpcUStrPas(#7'Ø');
	    _AddSpcUStrPas(#6'Ø');
	    Inc(IPath);
	    GetDataPath(IPath,a,b);
	    _AddSpcUStrPas(#6'2:Æ');
	    SetupPathInput(7,14,b);
	    _AddSpcUStr(7,'Case(K)of');
	    _AddSpcUStrX(8,mtkbUp+':PP:=1;');
	    _AddSpcUStrX(8,mtkbDn+','+mtkbTab+':P:=2;');
            SetupPathkbEnterEsc(8);
	    _AddSpcUStrPas(#7'Ø');
	    _AddSpcUStrPas(#6'Ø');
	    _AddSpcUStrPas(#5'Ø');
	   End;
	   3:Begin
	    GetDataPath(IPath,a,b);
	    _AddSpcUStr(5,'Case(PP)of');
	    _AddSpcUStrPas(#6'0:Æ');
	    _AddSpcUStr(7,'StrCopy(@PathBuf,T'+b+');');
	    _AddSpcUStr(7,'K:=_WEInput(W,0,8,31,80,PPathBuf);');
	    _AddSpcUStr(7,'StrDispose(T'+b+');');
	    _AddSpcUStrX(7,'T'+b+':='+mtStrNew_+'PPathBuf);');
	    _AddSpcUStrX(7,mtWSetKr_+'$8F);');
	    _AddSpcUStr(7,'WEBarSelHor(W,0,8,31);');
	    _AddSpcUStr(7,'Case(K)of');
	    _AddSpcUStrX(8,mtkbUp+':P:=0;');
	    _AddSpcUStrX(8,mtkbDn+':PP:=2;');
	    _AddSpcUStrX(8,mtkbTab+':PP:=1;');
            SetupPathkbEnterEsc(8);
	    _AddSpcUStrPas(#7'Ø');
	    _AddSpcUStrPas(#6'Ø');
	    Inc(IPath);
	    GetDataPath(IPath,a,b);
	    _AddSpcUStrPas(#6'1:Æ');
	    _AddSpcUStrPas(#7'StrCopy(@PathBuf,T'+b+');');
	    _AddSpcUStrX(7,'K:=_WEInput(W,34,8,wnMax-1,80,PPathBuf);');
	    _AddSpcUStrX(7,mtStrDispose_+'T'+b+');');
	    _AddSpcUStrX(7,'T'+b+':='+mtStrNew_+'PPathBuf);');
	    _AddSpcUStrX(7,mtWSetKr_+'$8F);');
	    _AddSpcUStrX(7,'WEBarSelHor(W,34,8,wnMax-1);');
	    _AddSpcUStr(7,'Case(K)of');
	    _AddSpcUStrX(8,mtkbUp+':P:=0;');
	    _AddSpcUStrX(8,mtkbDn+':PP:=3;');
	    _AddSpcUStrX(8,mtkbTab+':PP:=2;');
            SetupPathkbEnterEsc(8);
	    _AddSpcUStrPas(#7'Ø');
	    _AddSpcUStrPas(#6'Ø');
	    Inc(IPath);
	    GetDataPath(IPath,a,b);
	    _AddSpcUStrPas(#6'2:Æ');
	    _AddSpcUStrPas(#7'StrCopy(@PathBuf,T'+b+');');
	    _AddSpcUStr(7,'K:=_WEInput(W,0,11,31,80,PPathBuf);');
	    _AddSpcUStrX(7,mtStrDispose_+'T'+b+');');
	    _AddSpcUStr(7,'T'+b+':=StrNew(PPathBuf);');
	    _AddSpcUStrX(7,mtWSetKr_+'$8F);');
	    _AddSpcUStr(7,'WEBarSelHor(W,0,11,31);');
	    _AddSpcUStr(7,'Case(K)of');
	    _AddSpcUStrX(8,mtkbUp+':PP:=0;');
	    _AddSpcUStrX(8,mtkbDn+':P:=2;');
	    _AddSpcUStrX(8,mtkbTab+':PP:=3;');
            SetupPathkbEnterEsc(8);
	    _AddSpcUStrPas(#7'Ø');
	    _AddSpcUStrPas(#6'Ø');
	    Inc(IPath);
	    GetDataPath(IPath,a,b);
	    _AddSpcUStrPas(#6'3:Æ');
	    _AddSpcUStrPas(#7'StrCopy(@PathBuf,T'+b+');');
	    _AddSpcUStrX(7,'K:=_WEInput(W,34,11,wnMax-1,80,PPathBuf);');
	    _AddSpcUStrX(7,mtStrDispose_+'T'+b+');');
	    _AddSpcUStrX(7,'T'+b+':='+mtStrNew_+'PPathBuf);');
	    _AddSpcUStrX(7,mtWSetKr_+'$8F);');
	    _AddSpcUStrX(7,'WEBarSelHor(W,34,11,wnMax-1);');
	    _AddSpcUStr(7,'Case(K)of');
	    _AddSpcUStrX(8,mtkbUp+':PP:=1;');
	    _AddSpcUStrX(8,mtkbDn+':P:=2;');
	    _AddSpcUStrX(8,mtkbTab+':P:=2;');
            SetupPathkbEnterEsc(8);
	    _AddSpcUStrPas(#7'Ø');
	    _AddSpcUStrPas(#6'Ø');
	    _AddSpcUStrPas(#5'Ø');
	   End;
	   8:Begin
 	    _AddSpcUStr(5,'Case(PP)of');
	    GetDataPath(IPath,a,b);
	    _AddSpcUStrPas(#6'0:Æ');
	    SetupPathInput3A(7,8,b);
	    _AddSpcUStr(7,'Case(K)of');
	    _AddSpcUStrX(8,mtkbUp+':P:=0;');
	    _AddSpcUStrX(8,mtkbDn+':PP:=3;');
	    _AddSpcUStrX(8,mtkbTab+':PP:=1;');
            SetupPathkbEnterEsc(8);
	    _AddSpcUStrPas(#7'Ø');
	    _AddSpcUStrPas(#6'Ø');
	    Inc(IPath);
	    GetDataPath(IPath,a,b);
	    _AddSpcUStrPas(#6'1:Æ');
	    SetupPathInput3B(7,8,b);
	    _AddSpcUStr(7,'Case(K)of');
	    _AddSpcUStrX(8,mtkbUp+':P:=0;');
	    _AddSpcUStrX(8,mtkbDn+':PP:=4;');
	    _AddSpcUStrX(8,mtkbTab+':PP:=2;');
            SetupPathkbEnterEsc(8);
	    _AddSpcUStrPas(#7'Ø');
	    _AddSpcUStrPas(#6'Ø');
	    Inc(IPath);
	    GetDataPath(IPath,a,b);
	    _AddSpcUStrPas(#6'2:Æ');
	    SetupPathInput3C(7,8,b);
	    _AddSpcUStr(7,'Case(K)of');
	    _AddSpcUStrX(8,mtkbUp+':P:=0;');
	    _AddSpcUStrX(8,mtkbDn+':PP:=5;');
	    _AddSpcUStrX(8,mtkbTab+':PP:=3;');
            SetupPathkbEnterEsc(8);
	    _AddSpcUStrPas(#7'Ø');
	    _AddSpcUStrPas(#6'Ø');
	    Inc(IPath);
	    GetDataPath(IPath,a,b);
	    _AddSpcUStrPas(#6'3:Æ');
	    SetupPathInput3A(7,11,b);
	    _AddSpcUStr(7,'Case(K)of');
	    _AddSpcUStrX(8,mtkbUp+':PP:=0;');
	    _AddSpcUStrX(8,mtkbDn+':PP:=6;');
	    _AddSpcUStrX(8,mtkbTab+':PP:=4;');
            SetupPathkbEnterEsc(8);
	    _AddSpcUStrPas(#7'Ø');
	    _AddSpcUStrPas(#6'Ø');
	    Inc(IPath);
	    GetDataPath(IPath,a,b);
	    _AddSpcUStrPas(#6'4:Æ');
	    SetupPathInput3B(7,11,b);
	    _AddSpcUStr(7,'Case(K)of');
	    _AddSpcUStrX(8,mtkbUp+':PP:=1;');
	    _AddSpcUStrX(8,mtkbDn+':PP:=7;');
	    _AddSpcUStrX(8,mtkbTab+':PP:=5;');
            SetupPathkbEnterEsc(8);
	    _AddSpcUStrPas(#7'Ø');
	    _AddSpcUStrPas(#6'Ø');
	    Inc(IPath);
	    GetDataPath(IPath,a,b);
	    _AddSpcUStrPas(#6'5:Æ');
	    SetupPathInput3C(7,11,b);
	    _AddSpcUStr(7,'Case(K)of');
	    _AddSpcUStrX(8,mtkbUp+':PP:=2;');
	    _AddSpcUStrX(8,mtkbDn+':PP:=8;');
	    _AddSpcUStrX(8,mtkbTab+':PP:=6;');
            SetupPathkbEnterEsc(8);
	    _AddSpcUStrPas(#7'Ø');
	    _AddSpcUStrPas(#6'Ø');
	    Inc(IPath);
	    GetDataPath(IPath,a,b);
	    _AddSpcUStrPas(#6'6:Æ');
	    SetupPathInput3A(7,14,b);
	    _AddSpcUStr(7,'Case(K)of');
	    _AddSpcUStrX(8,mtkbUp+':PP:=3;');
	    _AddSpcUStrX(8,mtkbDn+':P:=2;');
	    _AddSpcUStrX(8,mtkbTab+':PP:=7;');
            SetupPathkbEnterEsc(8);
	    _AddSpcUStrPas(#7'Ø');
	    _AddSpcUStrPas(#6'Ø');
	    Inc(IPath);
	    GetDataPath(IPath,a,b);
	    _AddSpcUStrPas(#6'7:Æ');
	    SetupPathInput3B(7,14,b);
	    _AddSpcUStr(7,'Case(K)of');
	    _AddSpcUStrX(8,mtkbUp+':PP:=4;');
	    _AddSpcUStrX(8,mtkbDn+':P:=2;');
	    _AddSpcUStrX(8,mtkbTab+':PP:=8;');
            SetupPathkbEnterEsc(8);
	    _AddSpcUStrPas(#7'Ø');
	    _AddSpcUStrPas(#6'Ø');
	    Inc(IPath);
	    GetDataPath(IPath,a,b);
	    _AddSpcUStrPas(#6'8: Æ');
	    SetupPathInput3C(7,14,b);
	    _AddSpcUStr(7,'Case(K)of');
	    _AddSpcUStrX(8,mtkbUp+':PP:=5;');
	    _AddSpcUStrX(8,mtkbDn+':P:=2;');
	    _AddSpcUStrX(8,mtkbTab+':P:=2;');
            SetupPathkbEnterEsc(8);
	    _AddSpcUStrPas(#7'Ø');
	    _AddSpcUStrPas(#6'Ø');
	    _AddSpcUStrPas(#5'Ø');
	   End;
	   Else Begin
	    Return(TooManyPathInHeader);
	    Exit;
	   End;
	  End;
	  _AddSpcUStrPas(#4'Ø');
	 End;
	 If(IPath>MaxBuf)Then Break;
	End;
	_AddSpcUStrPas(#3'Ø');
	_AddSpcUStrPas(#3'2:Æ');
	_AddSpcUStr(4,'PP:=0;K:=WEGetkHorDn(W,''$Correcte|Annule'');');
	_AddSpcUStr(4,'Case(K)of');
	_AddSpcUStrX(5,'1,'+mtkbEsc+','+mtkbClose+',kbAbort:'+mtBreak_);
        _AddSpcUStrX(5,'kbInWn:MouseAction;');
	_AddSpcUStrPas(#5'0,kbEnter:Æ');
	_AddSpcUStr(6,Name+':=True;');
	For IPath:=0to(MaxBuf)do Begin
	 S:=StrPas(_ALGetBuf(BankSetupPath,IPath));
	 If StrI(1,S)=#2Then Begin
	  GetDataPath(IPath,a,b);
	  _AddSpcUStrX(6,mtStrDispose_+b+');');
          _AddSpcUStrX(6,b+':='+mtStrNew_+'T'+b+');');
	 End;
	End;
	_AddSpcUStrX(6,mtBreak_);
	_AddSpcUStrPas(#5'Ø');
	_AddSpcUStrX(5,mtkbTab+':P:=0;');
	_AddSpcUStrPas(#4'Ø');
	_AddSpcUStrPas(#3'Ø');
	_AddSpcUStrPas(#2'Ø');
	_AddSpcUStr(1,'Until No;');
	For IPath:=0to(MaxBuf)do Begin
	 S:=StrPas(_ALGetBuf(BankSetupPath,IPath));
	 If StrI(1,S)=#2Then Begin
	  GetDataPath(IPath,a,b);
	  _AddSpcUStrX(1,mtStrDispose_+'T'+b+');');
	 End;
	End;
	_AddSpcUStr(1,'SetShade(True);');
	_AddSpcUStr(1,'WEDone(W);');
	_AddStrPas('Ø');
       End
	Else
       If Func='HEADER'Then Begin
	SkipSpc;
	If PC[ErrI]<>'"'Then Begin Return(GuillExpected);Exit;End;
	Inc(ErrI); S:=ExtractNot('"');
	ALAddStr(BankSetupPath,#1+S);
	If PC[ErrI]<>'"'Then Begin Return(GuillExpected);Exit;End;
	Inc(ErrI);
       End
	Else
       If Func='PATH'Then Begin
	SkipSpc;
	If PC[ErrI]<>'"'Then Begin Return(GuillExpected);Exit;End;
	Inc(ErrI); S:=ExtractNot('"');
	If PC[ErrI]<>'"'Then Begin Return(GuillExpected);Exit;End;
	Inc(ErrI);
	SkipSpc;
	If PC[ErrI]<>','Then Begin Return(CommaExpected);Exit;End;
	Inc(ErrI,Length(','));
	SkipSpc;
	_Type:=PXtrkWord(ErrI,@PC);
	ALAddStr(BankSetupPath,#2+S+'"'+_Type);
       End
	Else
       Begin Return(SyntaxError);Exit;End;
      End
       Else
      Begin
       Func:=PXtrkWord(ErrI,@PC);
       If StrUp(Func)='BEGIN'Then Inc(_Begin)
	Else
       Begin
	Return(BeginExpected);
	Exit;
       End;
      End;
     End;
     LoadIni:Begin
      If _Begin=1Then Begin
       Func:=StrUp(PXtrkWord(ErrI,@PC));
       If Func='BEGIN'Then
       Begin
	Return(MisplacedBeginSymbol);
	Exit;
       End
	else
       If Func='END'Then Begin
	_InsStr(InsProc,'Procedure '+Name+';');
	_AddStrPas('û '+Name+';');
	ALAddStr(Lst,'Const MsgChoice=''Presse une touche pour continuer '+
		'sans le fichier '+Files+' ou <ESC> pour quitter.'';');
	_AddStrPas('Var Handle:Hdl; SI,õ,Ext,Header:$; Pá:è; FS,S:Long; Category:Byte;');
	_AddLn;
	_AddSpcUStrPas(#1'ü ê†I(õ:$):$;Var P:Byte;Æ');
        _AddSpcUStrPas(#2'_DelAllSpcRight(õ);');
	_AddSpcUStrPas(#2'P:=Pos(''='',õ);');
        _AddSpcUStrPas(#2'While(Str[P]<>''"'')do Inc(P);');
	_AddSpcUStrPas(#2'? P=0® ê†I:=''''˜ ê†I:=Copy(õ,P,255);');
	_AddSpcUStrPas(#1'Ø');
        _AddLn;
	_AddSpcUStrPas(#1'ü ê†(õ:$):$;Var P:Byte;Æ');
	_AddSpcUStrPas(#2'P:=Pos(''='',õ);');
	_AddSpcUStrPas(#2'? P=0® ê†:=''''˜ ê†:=Copy(õ,P+1,255);');
	_AddSpcUStrPas(#1'Ø');
	_AddLn;
	_AddStrPas(' ü Isù(õ:$):Bool;Æ');
	_AddSpcUStrPas(#2'Isù:=(õ=''YES'')|(õ=''TRUE'')|(õ=''ON'');');
	_AddSpcUStrPas(#1'Ø');
	_AddLn;
	_AddStrPas(' ü IsÙ(õ:$):Bool;Æ');
	_AddSpcUStrPas(#2'IsÙ:=(õ=''NO'')|(õ=''FALSE'')|(õ=''OFF'');');
	_AddSpcUStrPas(#1'Ø');
	_AddLn;
        _AddStrPas(' ü ICmpLeft(Const õ,Cmp:$):Bool;Æ');
        _AddSpcUStrPas(#2'? õ[Length(Cmp)+1]<''@''® ICmpLeft:=CmpLeft(õ,Cmp)');
        _AddSpcUStrPas(#29'˜ ICmpLeft:=No;');
	_AddSpcUStrPas(#1'Ø');
        _AddLn;
	_AddStrPas('Æ');
	_AddStrPas(' Category:=0;FS:=0;Handle:=File¢('''+Files+''',fmRead);');
        _AddStrPas(' ?(Handle=errHdl)® Æ');
	ALAddStr(Lst,'  Handle:=FileOpen(MaltePath+'''+Files+''',fmRead);');
	_AddSpcUStrPas(#1'Ø');
	_AddStrPas(' ?(Handle=errHdl)® Exit;');
	_AddStrPas(' S:=FileSize(Handle);');
	_AddStrPas(' __GetAbsFileTxtLn(Handle,FS,SI);');
	_AddSpcUStrPas(#1'While(FS<S)do Æ');
	_AddSpcUStrPas(#2'õ:=Delá(õö(SI),'' '');');
	_AddSpcUStrPas(#2'? !((õ='''')|(õ[1]=''/''))®');
	_AddSpcUStrPas(#2'Æ');
	_AddSpcUStrPas(#3'?(õ[1]=''['')® Æ');
	_AddSpcUStrPas(#4'? õ[Length(õ)]<>'']''® Æ');
	_AddSpcUStr(5,'WriteLn(''Erreur '+Files+': '''']'''' attendue.'');');
	_AddSpcUStrPas(#5'WriteLn(MsgChoice);');
	_AddSpcUStrPas(#5'?(ReadKey=kbEsc)® Halt;');
	_AddSpcUStrPas(#5'Exit;');
	_AddSpcUStrPas(#4'Ø');
	_AddSpcUStrPas(#4'Header:=Copy(õ,2,Length(õ)-2);');
	ALSetPtr(BankName,0);
	J:=1;
	For I:=0to ALMax(BankName)do	Begin
	 S:=StrPas(_ALGetCurrBuf(BankName));
	 If S[1]=#1Then Begin
	  If(J=NumHeader)Then Begin
	   _AddSpcUStrPas(#4'? Header='''+Copy(S,2,Length(S)-1)+'''® Category:='+IntToStr(J));
	   _AddSpcUStrPas(#5'˜');
	   _AddSpcUStrX(4,mtBreak_);
	   _AddSpcUStr(3,'End');
	   _AddSpcUStrPas(#4'˜');
	   _AddSpcUStr(3,'Case Category of');
	  End
	   Else
	  _AddSpcUStrPas(#4'? Header='''+Copy(S,2,Length(S)-1)+'''® Category:='+IntToStr(J)+' ˜');
	  Inc(J);
	 End;
	 ALNext(BankName);
	End;
	ALSetPtr(BankName,0);
	J:=1;
	For I:=0 to ALMax(BankName)do Begin
	 S:=StrPas(_ALGetCurrBuf(BankName));
	 If S[1]=#1Then Begin
	  If J>1Then _AddSpcUStrPas(#8'Ø');
	  _AddSpcUStrPas(#4+IntToStr(J)+' : Æ');
	  Inc(J);
	 End;
	 If S[1]=#2Then Begin
	  K:=2;Name:=XtrkWord(K,S);Inc(K);_Type:=StrUp(XtrkWord(K,S));
	  Inc(K);NameType:=Copy(S,K,255);
	  _AddSpcUStrPas(#9'? ICmpLeft(õ,'''+Name+''')® Æ');
          If _Type='PCHAR'Then _AddSpcUStrPas(#10'Ext:=ê†I(SI);')
	  Else _AddSpcUStrPas(#10'Ext:=ê†(õ);');
	  If(_Type='BYTE')or(_Type='WORD')Then _AddSpcUStrPas(#10+NameType+':=StrToWord(Ext);')Else
	  If _Type='BOOLEAN'Then Begin
	   _AddSpcUStrPas(#10'? Isù(Ext)® '+NameType+':=ù ˜');
	   _AddSpcUStrPas(#10'? IsÙ(Ext)® '+NameType+':=Ù');
	   _AddSpcUStrPas(#25'˜ Break;');
	  End
	   Else
	  If(_Type='PCHR')or(_Type='PCHAR')Then Begin
	   _AddSpcUStrPas(#10'?(Ext[1]=''"'')Ô(Ext[Length(Ext)]=''"'')® Æ');
	   _AddSpcUStrPas(#11+NameType+':=õ2PChr(Copy(Ext,2,Length(Ext)-2));');
	   _AddSpcUStrPas(#10'Ø');
	  End
	   Else
	  Begin Return(UnknownType);Exit;End;
	  _AddSpcUStrPas(#9'Ø');
	 End;
	 ALNext(BankName);
	End;
	If J>1Then _AddSpcUStrPas(#8'Ø')Else Break;
	_AddSpcUStrPas(#3'Ø');
	_AddSpcUStrPas(#2'Ø');
	_AddSpcUStrPas(#2'__GetAbsFileTxtLn(Handle,FS,SI);');
	_AddSpcUStrPas(#1'Ø');
	_AddSpcUStr(1,'FileClose(Handle);');
	_AddStrPas('Ø');
       End
	Else
       If Func='HEADER'Then Begin
	SkipSpc;
	If PC[ErrI]<>'"'Then Begin
	 Return(GuillExpected);
	 Exit;
	End;
	Inc(ErrI); S:=ExtractNot('"');
	ALAddStr(BankName,#1+S);
	If PC[ErrI]<>'"'Then Begin
	 Return(GuillExpected);
	 Exit;
	End;
	Inc(ErrI); Inc(NumHeader);
       End
	Else
       If Func='VARIABLE'Then Begin
	SkipSpc;
	If PC[ErrI]<>'"'Then Begin Return(GuillExpected);Exit;End;
	Inc(ErrI); S:=ExtractNot('"');
	If PC[ErrI]<>'"'Then Begin Return(GuillExpected);Exit;End;
	Inc(ErrI);
	SkipSpc;
	If PC[ErrI]<>','Then Begin Return(CommaExpected);Exit;End;
	Inc(ErrI,Length(','));
	SkipSpc;
	_Type:=PXtrkWord(ErrI,@PC);
	If PC[ErrI]<>','Then Begin Return(CommaExpected);Exit;End;
	Inc(ErrI,Length(','));
	SkipSpc;
	NameType:=PXtrkWord(ErrI,@PC);
	If PC[ErrI]='['Then Begin
	 IncStr(NameType,'[');Inc(ErrI,Length('['));
	 AddStr(NameType,PXtrkWord(ErrI,@PC));
	 If PC[ErrI]<>']'Then Begin Return(CloseArrayExpected);Exit;End;
	 Inc(ErrI,Length(']'));IncStr(NameType,']');
	End;
	If PC[ErrI]='.'Then Begin
	 IncStr(NameType,'.');Inc(ErrI,Length('.'));
	 AddStr(NameType,PXtrkWord(ErrI,@PC));
	End;
	ALAddStr(BankName,#2+S+' '+_Type+' '+NameType);
       End
	Else
       Begin Return(SyntaxError);Exit;End;
      End
       Else
      Begin
       Func:=PXtrkWord(ErrI,@PC);
       If StrUp(Func)='BEGIN'Then Inc(_Begin)Else Begin Return(BeginExpected);Exit;End;
      End;
     End;
     Else
     Begin
      Return(SyntaxError);
      Exit;
     End;
    End;
    ' ': Inc(ErrI);
    '/': Case PC[ErrI+1]of
	   '/': Break;
	   Else Begin
		 Return(SyntaxError);
		 Exit;
		End;
	  End;
    Else
    Begin
     Return(SyntaxError);
     Exit;
    End;
   End;
  End;
 Until FP>=FS;
 Finish;
End;

BEGIN
 WriteLn('RC Ö Pascal  Version 1.0  Tous droits rÇservÇ au Chevaliers de Malte (C)');
 WriteLn;
 InitSystems(suIsabel);
 CompileRC(ParamStr(1));
 DoneSystems;
END.