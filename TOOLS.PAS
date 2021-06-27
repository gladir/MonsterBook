{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³            Malte Genesis/Module des Outils          ³
 ³             Edition Isabel pour Mode R‚el           ³
 ³                   III - Version 1.0                 ³
 ³                       1995/02/02                    ³
 ³                                                     ³
 ³ Tous droits r‚serv‚ par les Chevaliers de Malte (C) ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}

Unit Tools;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                                  INTERFACE
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

{$I DEF.INC}

{$IFDEF Overlay}
 {$O+,F+}
{$ENDIF}

Uses
 Systex,Isatex;

Const
 btNone=0;
 btBool=1;
 btByte=2;
 btShortInt=3;
 btWord=4;
 btInt=5;
 btLongWord=6;
 btLongInt=7;
 btReal=8;
 btSingle=9;
 btDouble=10;
 btExtended=11;
 btComp=12;
 btPChar=13;
 btDate=14;
 btTime=15;
 btZipCode=16;
 btPhone=17;
 btEnum=18;
 btPath=19;
 btPrice=20;
 btColor=21;
 btNumber=255;

Procedure ChkMasterPassWord;
Procedure Config6x86;
Function  GetXChgPg(Var PgA,PgB:RBP):Boolean;
Procedure InitTools;
Procedure DoneTools;
{$IFNDEF __Windows__}
 Procedure PrintScreen;
{$ENDIF}
Function  SelectBaseType(X1,Y1,X2,Y2:Byte;Const Title:String;Kr:MtxColors):Byte;
Function  SetFormatPage(Var Q:SheetFormatEditor):Boolean;
Function  WinFileSort(Old:FileSort):FileSort;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                                IMPLEMENTATION
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Uses
 Adele,Memories,Systems,Video,Dials,Terminal,
 Mouse,Pritex,Dialex,DialPlus,SysPlus,ResSaveI;

{$IFNDEF __Windows__}
 Var OldInt05h:Pointer;
{$ENDIF}

Procedure InitTools;Begin
 {$IFNDEF __Windows__}
  GetIntVec($05,OldInt05h);
  SetIntVec($05,@Int05h);
 {$ENDIF}
End;

Function GetXChgPg;
Var
 Data:Record
  A,B:Word;
 End;
Begin
 GetXChgPg:=False;
 Data.A:=PgA;
 Data.B:=PgB;
 If ExecuteAppDPU(31,Data)Then Begin
  PgA:=Data.A;PgB:=Data.B;
  GetXChgPg:=True;
 End;
End;

Function SetFormatPage;Begin
 SetFormatPage:=False;
 If ExecuteAppDPU(30,Q)Then SetFormatPage:=True;
End;

Function SelectBaseType;
Var
 M:LstMnu;
 C:Byte;
 Ok:Boolean;

 Function SelNm:Byte;
 Var
  M:LstMnu;
 Begin
  LMInit(M,X1+4,Y1,X2-4,Y2,'Nombre',Kr);
  ALAddStrByte(M.List,'Naturel (0 … 255)',btByte);
  ALAddStrByte(M.List,'Naturel (0 … 65535)',btWord);
  ALAddStrByte(M.List,'Naturel (0 … 4294967295)',btLongWord);
  ALAddStrByte(M.List,'Entier (-128 … 127)',btShortInt);
  ALAddStrByte(M.List,'Entier (-32768 … 32767)',btInt);
  ALAddStrByte(M.List,'Entier (-2147483648 … 2147483647)',btLongInt);
  ALAddStrByte(M.List,'Entier ((-9úEXP(63)10) … (9úEXP(63)10))',btComp);
  ALAddStrByte(M.List,'R‚el ((2,9úEXP(-39)10) … (1,7úEXP(38)10))',btReal);
  ALAddStrByte(M.List,'R‚el ((1,5úEXP(-45)10) … (3,4úEXP(38)10))',btSingle);
  ALAddStrByte(M.List,'R‚el ((5,0úEXP(-324)10) … (3,4úEXP(308)10))',btDouble);
  ALAddStrByte(M.List,'R‚el ((1,9úEXP(-4951)10) … (1,7úEXP(4932)10))',btExtended);
  SelNm:=LMRun(M);
  LMDone(M);
 End;

Begin
 LMInit(M,X1,Y1,X2,Y2,Title,Kr);
 ALAddStrByte(M.List,'Logique (Vrai,Faux)',btBool);
 ALAddStrByte(M.List,'Nombre (Naturel, Entier, R‚el)',btNumber);
 ALAddStrByte(M.List,'Texte (0 … 65534 caractŠre(s))',btPChar);
 ALAddStrByte(M.List,'Date',btDate);
 ALAddStrByte(M.List,'Temps (date et l''heure)',btTime);
 ALAddStrByte(M.List,'Code postal (ex : H2B-2R3)',btZipCode);
 ALAddStrByte(M.List,'T‚l‚phone (ex: (514) 657-8934)',btPhone);
 ALAddStrByte(M.List,'Couleur (noir, bleu, vert,...)',btColor);
 ALAddStrByte(M.List,'Prix (ex: $100,00; $199,94;...)',btPrice);
 ALAddStrByte(M.List,'R‚pertoire (ex: C:\;C:\DOS,...)',btPath);
 ALAddStrByte(M.List,'Enum‚ration (ex: voiture, camion, sept, ...)',btEnum);
 Repeat
  Ok:=True;
  C:=LMRun(M);
  Case(C)of
   btNumber:Begin
    C:=SelNm;
    If C=0Then Ok:=False;
   End;
  End;
 Until Ok;
 SelectBaseType:=C;
 LMDone(M);
End;

{Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure est en faŒte une interruption de remplacement de
 l'interruption 05h,  utilis‚ pour l'impression de l'‚cran dŠs les
 plus lointaine origine du PC d'IBM.
}

{$IFNDEF __Windows__}
 Procedure PrintScreenText;
 Var
  I,J:Byte;
  Chr:Char;
  NmYTxts:Byte;
 Begin
  If CurrNmXTxts>80Then __SetPrnCompress;
  NmYTxts:=CurrMaxYTxts;
  If NmYTxts=0Then NmYTxts:=24 Else Inc(NmYTxts);
  If NmYTxts>88Then Prn(psPrn.InterLn7_72)Else
  If NmYTxts>66Then Prn(psPrn.InterLn1_8);
  For J:=0to NmYTxts-1do Begin
   For I:=0to(CurrNmXTxts)do Begin
    Chr:=GetChr(I,J);
    If Chr<' 'Then PushStrSpooler(' ')
              Else PushStrSpooler(Chr);
   End;
   If CurrNmXTxts=132Then PrnLn;
  End;
 End;

 Function ChoicePrintScreen:Byte;Near;Begin
  If Not(IsGrf)Then ChoicePrintScreen:=0
   Else
  Case _InputMsg('Impression de l''‚cran',
       'O— voulez-vous imprimer l''image de l''‚cran?',
       'Imprimante|Fichier',wfLosange+wiInfo,CurrKrs.RemWin)of
   0:ChoicePrintScreen:=0;
   1:ChoicePrintScreen:=1;
   Else ChoicePrintScreen:=$FF;
  End;
 End;

 Procedure PrintScreenFile;
 Var
  Q:History;
  Name:String;
 Begin
  FillClr(Q,SizeOf(Q));
  Name:=_OpenWinModel('*.*','Sauve l''‚cran',Q,omDraw);
  If(IsGrf)Then RIPrintScreen(Name);
 End;

 Procedure PrintScreen;Begin
  PrtScr:=False;
  Case(ChoicePrintScreen)of
   0:PrintScreenText;
   1:PrintScreenFile;
  End;
 End;
{$ENDIF}

Procedure DoneTools;Begin
 {$IFNDEF __Windows__}
  SetIntVec($05,OldInt05h)
 {$ENDIF}
End;

Function WinFileSort;
Var
 Data:Record
  Sort:FileSort;
 End;
Begin
 WinFileSort:=Old;Data.Sort:=Old;
 If ExecuteAppDPU(37,Data)Then WinFileSort:=Data.Sort;
End;

Procedure ChkMasterPassWord;
Var
 S:String;
Begin
 If Not IsPChrEmpty(MasterPassWord)Then Begin
  S:='';ClrKbd;
  Repeat
   WinInp(40,'Protection centrale','Entrez le mot de passe',CurrKrs.Draw.Window,True,S);
  Until StrUp(S)=StrPas(MasterPassWord);
 End;
End;

Procedure Config6x86;
Var
 Data:Record
  Routine:MRadioButton;
  Cyrix:Boolean;
  ParamCyrix:Record
   FastFrameBuffer:Boolean;
   WriteBackCache:Boolean;
   WriteAllocate:Boolean;
   CPUID:Boolean;
   SuspendonHALT:Boolean;
   CachedDirectoryTableEntry:Boolean;
   NegateLock:Boolean;
   DataForwarding:Boolean;
   FastLoop:Boolean;
  End;
 End;
Begin
 FillClr(Data,SizeOf(Data));
 Data.Cyrix:=CPUVendor=cvCyrix;
 If(Data.Cyrix)Then GetCyrix6x86Config(Cyrix6x86Config(Data.ParamCyrix));
 If ExecuteAppDPU(77,Data)Then Begin
  If(Data.Cyrix)Then SetCyrix6x86Config(Cyrix6x86Config(Data.ParamCyrix));
 End;
End;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
END.