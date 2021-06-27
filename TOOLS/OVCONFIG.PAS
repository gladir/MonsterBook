Unit OVConfig;

INTERFACE

Procedure SetupCPUTarget;
Procedure SetupSyntax;
Procedure SetupTarget;
Function  ExecuteOverCodeDPU(Index:Word;Var Output):Boolean;

IMPLEMENTATION

Uses Systex,Systems,Video,Isatex,Mouse,Dials,Dialex,DialPlus,PCCortex;

Function ExecuteOverCodeDPU(Index:Word;Var Output):Boolean;Begin
 ExecuteOverCodeDPU:=ExecuteDPU('OVERCODE.*',Index,Output);
End;

Procedure WEPutItem(Var W:Window;S:String;B:Boolean);Near;Begin
 AddStr(S,' [');
 IncStr(S,Chr(32+56*Byte(B)));
 IncStr(S,']');
 WEPutTxtLn(W,S)
End;

Function WEInpOkCancel(Var W:Window):Word;Near;Begin
 WEInpOkCancel:=WEGetkHorDn(W,'$Correcte|Annule')
End;

Procedure WEOkCancel(Var W:Window);Near;Begin
 WEPutkHorDn(W,'$Correcte|Annule')
End;

Procedure SetupCPUTarget;Begin
 ExecuteAppDPU(91,Byte(InstrFormat));
End;

Procedure SetupSyntax;
Const
 NmItem=1;
 XPos=28;
Var
 W:Window;
 K:Word;
 P:Byte;
 NewT:Array[0..1]of Boolean;

 Procedure MouseAction;Var OP,MX,MY,TP0:Byte;Begin
  MX:=LastMsX-WEGetRX1(W);MY:=LastMsY-WEGetRY1(W);OP:=P;
  Case(MY)of
   1..NmItem:Case(MX)of
    XPos..XPos+2:P:=MY-1;
   End;
   1+NmItem..5+NmItem:P:=NmItem;
  End;
  If(P<>OP)and(MY<2+NmItem)Then WaitMsBut0;
 End;

Begin
 WEInitO(W,45,5+NmItem);
 WEPushWn(W);
 WEPutWnKrDials(W,'Compr‚hension syntaxique');
 WECloseIcon(W);
 WELn(W);
 WEPutItem(W,'Support syntaxe pour C/C++',CSyntax);
{ WEPutItem(W,'xxxxxxxxxxxxxxxxxxxxx',xxxxxx);}
 P:=0;NewT[0]:=CSyntax;{NewT[1]:=xxxxxx;}
 WEOkCancel(W);
 Repeat
  K:=WERunItem(W,XPos,1,P,0,NmItem,NewT);
  Case(K)of
   kbInWn:MouseAction;
   kbClose,kbEsc:Break;
  End;
  If(P=NmItem)Then Case WEInpOkCancel(W)of
   kbInWn:MouseAction;
   kbClose,kbAbort,1:Break;
   kbTab:P:=0;
   0:Begin
    CSyntax:=NewT[0];{xxxxxx:=NewT[1];}
{    SaveIni;}
    Break;
   End;
  End;
 Until No;
 WEDone(W);
End;

Procedure SetupTarget;
Var
 Data:Record
  ProgramTarget:Byte;
  ProgramFormat:Byte;
 End;
Begin
 Data.ProgramTarget:=Byte(ProgramTarget);
 Data.ProgramFormat:=Byte(ProgramFormat);
 If ExecuteOverCodeDPU(0,Data)Then Begin
  Byte(ProgramTarget):=Data.ProgramTarget;
  Byte(ProgramFormat):=Data.ProgramFormat;
 End;
End;

END.