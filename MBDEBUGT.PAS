Unit MBDebugT;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                                 INTERFACE
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

{$I DEF.INC}

Uses
 Isatex;

Procedure DEPutData(Var Q:DebugRec);
Procedure DEPutWn(Var Q:DebugRec);
Function  DETitle(Var Q;Max:Byte):String;
Procedure DEMove2(Var QX;X,Y:Byte);

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                                 IMPLEMENTATION
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Uses
 Adele,Systex,Systems,Video,Dialex,Dials,Sourcer,MBDebug;

Procedure WEPutSHW(Var W:Window;Y:Byte;Const S:String;X:Word);Near;Begin
 WEPutTxtXY(W,W.MaxX-8,Y,S+HexWord2Str(X)+'h')
End;

Procedure DEPutFlags(Var Q:DebugRec;Y:Byte;X:Boolean);Near;Begin
 If(X)Then Begin
  {$IFDEF Adele}
   SelIcon(WEGetRX1(Q.W)+Q.W.MaxX-13,WEGetRY1(Q.W)+Y,Q.W.CurrColor and$F0+LightGreen);
  {$ELSE}
   WESetKr(Q.W,Q.W.Kr and$F0+LightGreen);
   WEPutTxtXY(Q.W,Q.W.MaxX-13,Y,SelIcon);
  {$ENDIF}
 End
  Else
 Begin
  {$IFDEF Adele}
   UnSelIcon(WEGetRX1(Q.W)+Q.W.MaxX-13,WEGetRY1(Q.W)+Y,Q.W.CurrColor and$F0+LightGreen);
  {$ELSE}
   WESetKr(Q.W,Q.W.Kr and$F0+LightRed);
   WEPutTxtXY(Q.W,Q.W.MaxX-13,Y,UnselIcon)
  {$ENDIF}
 End;
 WESetKrBorder(Q.W);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                      Proc‚dure DEPutData                      Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure effectue une mise … jour de toutes les donn‚es …
 afficher concernant le programme en d‚boguage.
}

Procedure DEPutData;
Var
 S:String;
 CurrCode:Byte;
 I,J:Byte;
 IPy,IPx:Word;
Begin
 IPx:=PtrRec(PrgInstr).Ofs;
 WESetPosHome(Q.W);
 For I:=0to(Q.W.MaxY)do Begin
  WEPutTxt(Q.W,'CS:'+HexWord2Str(IPx)+' ');
  CurrCode:=Mem[PtrRec(PrgInstr).Seg:IPx];
  IPy:=IPx;S:=Decode(Mem[PtrRec(PrgInstr).Seg:0],IPx);
  For J:=0to IPx-IPy-1do WEPutTxt(Q.W,HexByte2Str(Mem[PtrRec(PrgInstr).Seg:IPy+J]));
  WEPutTxt(Q.W,Spc(16-(J shl 1))+S);
  WEClrEol(Q.W);
  WELn(Q.W);
  WESetChr(Q.W,Q.W.MaxX-10,I,'³');
  WESetChr(Q.W,Q.W.MaxX-25,I,'³');
 End;
 WEPutSHW(Q.W,0,'CS=',PtrRec(PrgInstr).Seg);
 WEPutSHW(Q.W,1,'IP=',PtrRec(PrgInstr).Ofs);
 WEPutSHW(Q.W,2,'AX=',DebAX);
 WEPutSHW(Q.W,3,'BP=',DebBP);
 WEPutSHW(Q.W,4,'BX=',DebBX);
 WEPutSHW(Q.W,5,'CX=',DebCX);
 WEPutSHW(Q.W,6,'DX=',DebDX);
 WEPutSHW(Q.W,7,'DI=',DebDI);
 WEPutSHW(Q.W,8,'SI=',DebSI);
 WEPutSHW(Q.W,9,'SP=',DebSP);
 WEPutSHW(Q.W,10,'DS=',DebDS);
 WEPutSHW(Q.W,11,'ES=',DebES);
 WEPutSHW(Q.W,12,'SS=',DebSS);
 WEPutTxtXY(Q.W,Q.W.MaxX-23,0,'Drapeaux:');
 WEPutTxtXY(Q.W,Q.W.MaxX-23,2,'"Carry"');
 DEPutFlags(Q,2,Bool(DebFlags and 1));
 WEPutTxtXY(Q.W,Q.W.MaxX-23,3,'Parit‚');
 DEPutFlags(Q,3,Bool((DebFlags shr 2)and 1));
 WEPutTxtXY(Q.W,Q.W.MaxX-23,4,'Auxiliaire');
 DEPutFlags(Q,4,Bool((DebFlags shr 4)and 1));
 WEPutTxtXY(Q.W,Q.W.MaxX-23,5,'Z‚ro');
 DEPutFlags(Q,5,Bool((DebFlags shr 6)and 1));
 WEPutTxtXY(Q.W,Q.W.MaxX-23,6,'Signe');
 DEPutFlags(Q,6,Bool((DebFlags shr 7)and 1));
 WEPutTxtXY(Q.W,Q.W.MaxX-23,7,'Trap');
 DEPutFlags(Q,7,Bool((DebFlags shr 8)and 1));
 WEPutTxtXY(Q.W,Q.W.MaxX-23,8,'Interruption');
 DEPutFlags(Q,8,Bool((DebFlags shr 9)and 1));
 WEPutTxtXY(Q.W,Q.W.MaxX-23,9,'Direction');
 DEPutFlags(Q,9,Bool((DebFlags shr 10)and 1));
 WEPutTxtXY(Q.W,Q.W.MaxX-23,10,'"Overflow"');
 DEPutFlags(Q,10,Bool((DebFlags shr 11)and 1));
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Proc‚dure DEPutWn                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure effectue une dessinage de la fenˆtre du d‚bogueur.
}

Procedure DEPutWn;
Var
 S:String;
Begin
 WEPutWn(Q.W,'Traceur de d‚boguage',CurrKrs.MalteDos.Window);
 WESetEndBarCTitle(Q.W);
 Case(CPU)of
  cpuPentiumII:S:='Pentium II';
  cpuPentiumMMX:S:='Pentium-MMX';
  cpuPentium:S:='Pentium';
  cpuCyrix6x86:S:='Cyrix 6x86';
  cpuCyrix5x86:S:='Cyrix 5x86';
  cpui486:Begin
   S:='80486';
   If Test8087=0Then AddStr(S,'SX');
  End;
  cpui386:S:='80386';
  cpu80286:S:='80286';
  cpu80186:S:='80186';
  cpu80188:S:='80188';
  cpuV30:S:='V30';
  cpuV20:S:='V20';
  cpu8086:S:='8086';
  cpu8088:S:='8088';
  Else S:='';
 End;
 WESetEndBarTxtX(Q.W,1,S,Q.W.Palette.Title);
 WESetEndBarTxtX(Q.W,15,'³ '+Q.Name,Q.W.Palette.Title);
End;

Function DETitle;Begin
 DETitle:='Debug';
End;

Procedure DEMove2(Var QX;X,Y:Byte);
Var
 Q:DebugRec Absolute QX;
 MX,MY:Byte;
Begin
 MX:=Q.W.T.X2-Q.W.T.X1;
 MY:=Q.W.T.Y2-Q.W.T.Y1;
 Q.W.T.X1:=X;Q.W.T.X2:=X+MX;
 Q.W.T.Y1:=Y;Q.W.T.Y2:=Y+MY;
 RefreshDebug(Q);
End;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
END.