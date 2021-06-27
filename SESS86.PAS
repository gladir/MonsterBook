{Description
 ÕÕÕÕÕÕÕÕÕÕÕ

  Cette unitÇ est destinÇe Ö offrir  des services permettant l'Çmulation de
 micro-processeur de la famille Intel et du code machine en deux dimensions
 sur n'importe quel machine PC ou compatible.
}

Unit Sess86;

INTERFACE

Uses Systex;

Const
  {Requete de la session}
 sprqNone=0;       { Aucune requàte }
 sprqReadKeyDos=1; { Requàte de lecture de clavier DOS AL=caractäre lu }

  {Code de retour de session}
 sfNone=0;         { Aucune faute }
 sfInvalidCode=1;  { Code machine invalide }
 sfHLT=2;          { Instruction machine HLT }
 sfHotBoot=3;      { DÇmarrage Ö chaud }
 sfColdBoot=4;     { DÇmarrage Ö froid }
 sfInvalidIntr=5;  { Interruption invalide }
 sfEndProgram=6;   { Fin de programme de l'interruption 20h }
 sfBreakPoint=7;   { Point d'arràt }

Type
  { Fenàtre d'application de vÇrification de donnÇes }
 WatchWindow=Record
  W:Window;                   { Fenàtre de positionnement de dÇboguage }
  List:RBuf;                  { Liste des objets Ö vÇrifier }
  I:Byte;                     { Position de traitement }
  Y:Byte;                     { Position vertical }
  P:Word;                     { Position dans la liste }
 End;

 Session8086=Record
  W:Window;                   { Fenàtre de la session }
  AppW:Window;                { Fenàtre de l'application }
  FullScreen:Boolean;         { Mode plein Çcran? }
  Option:Set of (soMath,      { Coprocesseur mathÇmatique activÇ? }
                 soOpCode2D,  { Supporte le code machine en 2 dimensions? }
                 soLibMalte,  { Instruction de biblothäque supportÇ }
                 soWaitState, { DÇlai entre les instructions? }
                 soMMX,       { Instruction MMX supportÇ? }
                 soCPUID,     { Instruction ÆCPUIDØ supportÇ? }
                 soSETALC);   { Instruction ÆSETALCØ supportÇ? }
   { Fonction Çmuler }
  Func:Set of (soPS2,         { PS/2 - Interruption 15h }
               soROMBasic,    { BASIC en ROM - Interruption 18h }
               soClockInt1Ah, { Horloge par l'interruption 1Ah }
               soMouseDriver, { Souris - Interruption 33h }
               soNovell,      { RÇseau Novell }
               soEGADriver,   { Carte EGA - Interruption 10h }
               soVGADriver,   { Carte VGA - Interruption 10h }
               soVESA,        { BIOS VESA }
               soEMM,         { EMM/EMS - Interruption 67h }
               soXMS,         { Pilote XMS - Interruption 2Fh/Fonction 4310h }
               soDPMI,        { Pilote DPMI/DPMS }
               soDOS,         { DOS }
               soMultiplexe,  { Interruption Mulitplexe - Interruption 2Fh }
               soTaskMgr,     { Gestionnaire de tÉche DR-DOS TaskMgr }
               soDRDOS,       { DR-DOS }
               soMSDOS,       { MS-DOS }
               DoubleDOS,     { DoubleDOS }
               TopView,       { TopView }
               DesqView,      { DesqView }
               soOS2,         { OS/2 }
               soWin31,       { Windows 3.1 }
               soWin95);      { Windows 95 }
  PortES:Set Of(soPCSpeaker,   { PC Speaker }
                soSoundBlaster,{ SoundBlaster }
                soSerialPort,  { Port sÇrial }
                soParallelPort,{ Port paralläle }
                soDiskette,    { Lecteur de disquette }
                soHardDisk,    { Disque dur }
                soCDROM,       { CD-ROM }
                soEGA,         { Carte EGA Çlectronique }
                soVGA,         { Carte VGA Çlectronique }
                soWaitRetrace, { DÇlai de signal vidÇo }
                soMouse,       { Souris }
                soJoystick,    { Manette de jeux }
                soKeyboard);   { Clavier }
  CPU:Byte;       { Modäle de Micro-Processeur }
  CPUVendor:Byte; { Fabricant du Micro-Processeur }
  UnitBoot:Byte;  { UnitÇ de dÇmarrage }
  Memory:XInf;    { MÇmoire attribuÇ Ö la session }
  M:ImgRec;       { MÇmoire temporaire de sauvegarde de l'Çcran }
  Seg:Record Case Byte of
   0:(ES,CS,SS,DS:Word);
   1:(Abs:Array[0..3]of Word);
  End;
  FS,GS,IP:Word;
  Reg:Record Case Byte of
   0:(EAX,ECX,EDX,EBX,ESP,EBP,ESI,EDI:LongInt);
   1:(AX,EAH,CX,ECH,DX,EDH,BX,EBH,SP,SPH,BP,BPH,SI,SIH,DI,DIH:Word);
   2:(AL,AH,HAL,HAH,CL,CH,HCL,HCH,DL,DH,HDL,HDH,BL,BH,HBL,HBH:Byte);
   3:(Abs:Array[0..7]of LongInt);
   4:(Chr:Array[0..15]of Char);
  End;
  Flags:Record Case Byte of
   0:(s:Set of(CF,bit1,PF,bit3,AF,bit5,ZF,SF,TF,_IF,DF,_OF));
   2:(Base:Word);
   3:(Abs:LongInt);
   4:(DataByte:Byte);
  End;
  Control:Record Case Byte Of
   0:(CR0,CR1,CR2,CR3,CR4,CR5,CR6,CR7:LongInt);
   1:(s:Set of(PE,MP,EM,TS,ET,NE,CR0b6,CR0b7,CR0b8,
               CR0b9,CR0b10,CR0b11,CR0b12,CR0b13,CR0b14,CR0b15,
               WP,CR0b17,AM,CR0b19,CR0b20,CR0b21,CR0b22,CR0b23,
               CR0b24,CR0b25,CR0b26,CR0b27,CR0b28,NW,CD,PG,
               CR1b0,CR1b1,CR1b2,CR1b3,CR1b4,CR1b5,CR1b6,CR1b7,
               CR1b8,CR1b9,CR1b10,CR1b11,CR1b12,CR1b13,CR1b14,CR1b15,
               CR1b16,CR1b17,CR1b18,CR1b19,CR1b20,CR1b21,CR1b22,CR1b23,
               CR1b24,CR1b25,CR1b26,CR1b27,CR1b28,CR1b29,CR1b30,CR1b31,
               CR2b0,CR2b1,CR2b2,CR2b3,CR2b4,CR2b5,CR2b6,CR2b7,
               CR2b8,CR2b9,CR2b10,CR2b11,CR2b12,CR2b13,CR2b14,CR2b15,
               CR2b16,CR2b17,CR2b18,CR2b19,CR2b20,CR2b21,CR2b22,CR2b23,
               CR2b24,CR2b25,CR2b26,CR2b27,CR2b28,CR2b29,CR2b30,CR2b31,
               CR3b0,CR3b1,CR3b2,CR3b3,CR3b4,CR3b5,CR3b6,CR3b7,
               CR3b8,CR3b9,CR3b10,CR3b11,CR3b12,CR3b13,CR3b14,CR3b15,
               CR3b16,CR3b17,CR3b18,CR3b19,CR3b20,CR3b21,CR3b22,CR3b23,
               CR3b24,CR3b25,CR3b26,CR3b27,CR3b28,CR3b29,CR3b30,CR3b31,
               VME,PVI,TSD,DE,PSE,CR4b5,MCE,CR4b7,
               CR4b8,CR4b9,CR4b10,CR4b11,CR4b12,CR4b13,CR4b14,CR4b15,
               CR4b16,CR4b17,CR4b18,CR4b19,CR4b20,CR4b21,CR4b22,CR4b23,
               CR4b24,CR4b25,CR4b26,CR4b27,CR4b28,CR4b29,CR4b30,CR4b31));
  End;
  DR0,DR1,DR2,DR3,DR4,DR5,DR6,DR7:LongInt;
  MM0,MM1,MM2,MM3,MM4,MM5,MM6,MM7:LongInt;
  TR3,TR4,TR5,TR6,TR7:LongInt;
  Fault:Word;     { Erreur de code machine }
  SubProcess:Byte;{ Demande de sous-processus }
  srStep:Word;    { Saut entre les codes si code en 2 dimensions }
  OldCSeg:Word;   { Ancien segment de code }
   { DonnÇes de service de dÇboguage }
  Sourcer:Boolean;     { Sourcer actif? }
  Log:Hdl;             { Fichier du journal d'instruction }
  NumInstr:LongInt;    { Nombre d'instruction exÇcutÇ }
  InstrBrk:String[10]; { Instruction assembleur d'arràt }
  CodeBrk:Integer;     { Code machine de point d'arràt }
  AlreadBreak:Boolean; { DÇjÖ sur le point d'arràt? }
  Watches:WatchWindow; { Fenàtre de vÇrification de donnÇes }
   { DonnÇes d'Çmulation d'un DOS }
  DOSVersion:Word;{ Version du DOS }
  OEMVersion:Byte;{ Version OEM du DOS }
  PSP:Word;       { PSP de l'application }
  Buffer:Array[0..255]of Byte;
 End;

Procedure S86InitBootFloppy(Var Context;X1,Y1,X2,Y2:Byte);
Procedure S86OpenWatches(Var Q:Session8086);
Function  S86RunWatches(Var Q:Session8086):Word;
Procedure S86CloseWatches(Var Q:Session8086);
Procedure S86Refresh(Var Context);
Procedure S86LoadCom(Var Context;X1,Y1,X2,Y2:Byte;Const FileName:String);
Procedure S86BackOperation(Var Context);
Procedure S86Done(Var Context);

IMPLEMENTATION

Uses Adele,Systems,Sourcer,Dialex,Math,Numerix,Video,Mouse,Dials,
     Restex,ResServD,Memories;

Const
 opMov=0;
 opAdc=1;
 opAdd=2;
 opAnd=3;
 opCmp=4;
 opOr=5;
 opSub=6;
 opSbb=7;
 opXor=8;
 opInc=9;
 opDec=10;
 opMul=11;
 opDiv=12;
 opXChg=$86;

Type
 SetOfChar=Set Of Char;

Function S86Num(Var Q:Session8086;Const S:String;Stop:SetOfChar;Var N:Variant):Boolean;Forward;

Function S86GetAbsoluteByte(Var Q:Session8086;Seg:Word;Ofs:LongInt):Byte;
Var
 Value:Byte;
Begin
 XGetAbsRec(Q.Memory,AddrExt2Conv(Ptr(Seg,Ofs)),SizeOf(Value),Value);
 S86GetAbsoluteByte:=Value;
End;

Function S86GetAbsoluteWord(Var Q:Session8086;Seg:Word;Ofs:LongInt):Word;
Var
 Value:Word;
Begin
 XGetAbsRec(Q.Memory,AddrExt2Conv(Ptr(Seg,Ofs)),SizeOf(Value),Value);
 S86GetAbsoluteWord:=Value;
End;

Function S86GetAbsoluteLong(Var Q:Session8086;Seg:Word;Ofs:LongInt):LongInt;
Var
 Value:LongInt;
Begin
 XGetAbsRec(Q.Memory,AddrExt2Conv(Ptr(Seg,Ofs)),SizeOf(Value),Value);
 S86GetAbsoluteLong:=Value;
End;

Function S86FormulaOnWord(Var Obj;Const ThisWord:String;Var Context):Boolean;
Var
 F:FormulaObject Absolute Obj;
 Q:Session8086 Absolute Context;
 A,L:LongInt;
 PBuffer:Pointer;
 Result:Variant;
 PWord:^Word Absolute PBuffer;
 UWord:String;
 Buffer:Array[0..511]of Byte;
Begin
 S86FormulaOnWord:=False;
 UWord:=StrUp(ThisWord);
 DBOpenServerName(ChantalServer,'CHANTAL:/CPU/Intel/Registre.Dat');
 If DBLocateAbs(ChantalServer,2,ThisWord,[soNoCaseSensitive])Then Begin
  DBReadRec(ChantalServer,Buffer);
  PWord:=@Buffer;
  DBGotoColumnAbs(ChantalServer,3,PBuffer);
  Case PWord^of
   1:L:=Q.Reg.AH;
   2:L:=Q.Reg.AL;
   3:L:=Q.Reg.AX;
   4:L:=Q.Reg.BH;
   5:L:=Q.Reg.BL;
   6:L:=Q.Reg.BP;
   7:L:=Q.Reg.BX;
   8:L:=Q.Reg.CH;
   9:L:=Q.Reg.CL;
   10:L:=Q.Control.CR0;
   11:L:=Q.Control.CR2;
   12:L:=Q.Control.CR3;
   13:L:=Q.Control.CR4;
   14:L:=Q.Seg.CS;
   15:L:=Q.Reg.CX;
   16:L:=Q.Reg.DH;
   17:L:=Q.Reg.DI;
   18:L:=Q.Reg.DL;
   19:L:=Q.DR0;
   20:L:=Q.DR1;
   21:L:=Q.DR2;
   22:L:=Q.DR3;
   23:L:=Q.DR6;
   24:L:=Q.DR7;
   25:L:=Q.Seg.DS;
   26:L:=Q.Reg.DX;
   27:L:=Q.Reg.EAX;
   28:L:=Q.Reg.EBP;
   29:L:=Q.Reg.EBX;
   30:L:=Q.Reg.ECX;
   31:L:=Q.Reg.EDI;
   32:L:=Q.Reg.EDX;
   33:L:=Q.Seg.ES;
   34:L:=Q.Reg.ESI;
   35:L:=Q.Reg.ESP;
   36:L:=Q.FS;
   37:L:=Q.GS;
   38:L:=Q.MM0;
   39:L:=Q.MM1;
   40:L:=Q.MM2;
   41:L:=Q.MM3;
   42:L:=Q.MM4;
   43:L:=Q.MM5;
   44:L:=Q.MM6;
   45:L:=Q.MM7;
   46:L:=Q.Reg.SI;
   47:L:=Q.Reg.SP;
   48:L:=Q.Seg.SS;
   {49:L:=Q.ST;
   50:L:=Q.ST0;
   51:L:=Q.ST1;
   52:L:=Q.ST2;
   53:L:=Q.ST3;
   54:L:=Q.ST4;
   55:L:=Q.ST5;
   56:L:=Q.ST6;
   57:L:=Q.ST7;}
   58:L:=Q.TR3;
   59:L:=Q.TR4;
   60:L:=Q.TR5;
   61:L:=Q.TR6;
   62:L:=Q.TR7;
   Else L:=0;
  End;
  FOPushNumberLong(F,L)
 End
  Else
 If UWord='AF'Then FOPushNumberLong(F,Byte((AF)in(Q.Flags.s)))Else
 If UWord='CF'Then FOPushNumberLong(F,Byte((CF)in(Q.Flags.s)))Else
 If UWord='DF'Then FOPushNumberLong(F,Byte((DF)in(Q.Flags.s)))Else
 If UWord='CPU'Then FOPushNumberLong(F,Q.CPU)Else
 If UWord='DOSVERSION'Then FOPushNumberLong(F,Q.DosVersion)Else
 If UWord='IF'Then FOPushNumberLong(F,Byte((_IF)in(Q.Flags.s)))Else
 If UWord='IP'Then FOPushNumberLong(F,Q.IP)Else
 If UWord='FLAGS'Then FOPushNumberLong(F,Q.Flags.Abs)Else
 If UWord='HI'Then Begin
  If StrI(F.I,F.Formula)<>'('Then Exit;
  Inc(F.I);
  Q.Watches.I:=F.I;
  If Not S86Num(Q,F.Formula,[],Result)Then Exit;
  F.I:=Q.Watches.I;
  If StrI(F.I,F.Formula)<>')'Then Exit;
  Inc(F.I);
  Q.Watches.I:=F.I;
  FOPushNumberLong(F,Hi(Result.X.DataLong));
 End
  Else
 If UWord='LO'Then Begin
  If StrI(F.I,F.Formula)<>'('Then Exit;
  Inc(F.I);
  Q.Watches.I:=F.I;
  If Not S86Num(Q,F.Formula,[],Result)Then Exit;
  F.I:=Q.Watches.I;
  If StrI(F.I,F.Formula)<>')'Then Exit;
  Inc(F.I);
  Q.Watches.I:=F.I;
  FOPushNumberLong(F,Lo(Result.X.DataLong));
 End
  Else
 If(UWord='MEM')or(UWord='MEML')or(UWord='MEMW')Then Begin
  If StrI(F.I,F.Formula)<>'['Then Exit;
  Inc(F.I);
  Q.Watches.I:=F.I;
  If Not S86Num(Q,F.Formula,[':'],Result)Then Exit;
  F.I:=Q.Watches.I;
  A:=Result.X.DataLong;
  If StrI(F.I,F.Formula)<>':'Then Exit;
  Inc(F.I);
  Q.Watches.I:=F.I;
  If Not S86Num(Q,F.Formula,[']'],Result)Then Exit;
  F.I:=Q.Watches.I;
  If StrI(F.I,F.Formula)<>']'Then Exit;
  L:=Result.X.DataLong;
  Inc(F.I);
  Q.Watches.I:=F.I;
  If(UWord='MEM')Then FOPushNumberLong(F,S86GetAbsoluteByte(Q,A,L))Else
  If(UWord='MEML')Then FOPushNumberLong(F,S86GetAbsoluteLong(Q,A,L))
                  Else FOPushNumberLong(F,S86GetAbsoluteWord(Q,A,L))
 End
  Else
 If UWord='OF'Then FOPushNumberLong(F,Byte((_OF)in(Q.Flags.s)))Else
 If UWord='PF'Then FOPushNumberLong(F,Byte((PF)in(Q.Flags.s)))Else
 If UWord='SF'Then FOPushNumberLong(F,Byte((SF)in(Q.Flags.s)))Else
 If UWord='TF'Then FOPushNumberLong(F,Byte((TF)in(Q.Flags.s)))Else
 If UWord='ZF'Then FOPushNumberLong(F,Byte((ZF)in(Q.Flags.s)))
  Else
 Exit;
 S86FormulaOnWord:=True;
End;

Function S86Num(Var Q:Session8086;Const S:String;Stop:SetOfChar;Var N:Variant):Boolean;
Var
 Formula:FormulaObject;
Begin
 FOInit(Formula);
 Formula.StopChar:=Stop;
 Formula.Option:=[foHexPascal,foNumberC,foNumberBasic,
                  foExpBasic,foStringPascal,foStringC,
                  foPourcent,foIntDiv];
 Formula.OnWord:=S86FormulaOnWord;
 Formula.Context:=@Q;
 Formula.I:=Q.Watches.I;
 S86Num:=FOCompute(Formula,S);
 Q.Watches.I:=Formula.I;
 N:=Formula.Result;
End;

Function S86GetFormatStream(Var Q:Session8086;S:String;Var Format:Byte):Boolean;Begin
 S86GetFormatStream:=False;
 Format:=0;
 S:=StrUp(S);
 If CmpLeft(S,'BYTESTREAM(')Then Begin
  Q.Watches.I:=Length('BYTESTREAM(')+1;
  Format:=1;
 End
  Else
 If CmpLeft(S,'LONGSTREAM(')Then Begin
  Q.Watches.I:=Length('LONGSTREAM(')+1;
  Format:=4;
 End
  Else
 If CmpLeft(S,'WORDSTREAM(')Then Begin
  Q.Watches.I:=Length('WORDSTREAM(')+1;
  Format:=2;
 End
  Else
 Exit;
 S86GetFormatStream:=True;
End;

Procedure S86PutLineWatches(Var Q:Session8086;Y:Byte;P:Integer);
Var
 I,Format:Byte;
 Result,ResultB:Variant;
 S,T:String;
Begin
 If(P<Q.Watches.List.NB)Then Begin
  S:=_RBGetStr(Q.Watches.List,P);
  Q.Watches.I:=1;
  If S86GetFormatStream(Q,S,Format)Then Begin
   If Not S86Num(Q,S,[','],Result)Then T:='Segment attendu'
    Else
   Begin
    If StrI(Q.Watches.I,S)<>','Then Exit;
    Inc(Q.Watches.I);
    If Not S86Num(Q,S,[],ResultB)Then T:='Offset attendu'
     Else
    Begin
     T:='(';
     For I:=0to 127do Begin
      Case(Format)of
       2:Begin
        AddStr(T,WordToStr(S86GetAbsoluteWord(Q,Result.X.DataLong,ResultB.X.DataLong)));
        Inc(ResultB.X.DataLong,2);
       End;
       4:Begin
        AddStr(T,WordToStr(S86GetAbsoluteLong(Q,Result.X.DataLong,ResultB.X.DataLong)));
        Inc(ResultB.X.DataLong,4);
       End;
       Else Begin
        AddStr(T,WordToStr(S86GetAbsoluteByte(Q,Result.X.DataLong,ResultB.X.DataLong)));
        Inc(ResultB.X.DataLong);
       End;
      End;
      IncStr(T,',');
     End;
    End;
   End;
  End
   Else
  If S86Num(Q,S,[],Result)Then Begin
   Case(Result.TypeDef)of
    dtReal:T:=RealStr(Result.X.DataReal);
    dtLong:T:=IntToStr(Result.X.DataLong);
    dtInt:T:=IntToStr(Result.X.DataInt);
    dtBool:If(Result.X.DataBool)Then T:='Vrai'
                                Else T:='Faux';
    Else T:='Type incompatible';
   End;
  End
   Else
  T:='Erreur';
  AddStr(S,': ');
  AddStr(S,T);
 End
  Else
 S:='';
 WEPutTxtXY(Q.Watches.W,0,Y,S);
 WEClrEol(Q.Watches.W);
End;

Procedure S86RefreshWatches(Var Q:Session8086);
Var
 I:Byte;
 P:Word;
Begin
 P:=Q.Watches.P-Q.Watches.Y;
 For I:=0to(Q.Watches.W.MaxY)do Begin
  S86PutLineWatches(Q,I,P);
  Inc(P);
 End;
End;

Procedure S86OpenWatches(Var Q:Session8086);
Begin
 WEPushWn(Q.Watches.W);
 WEPutWnKrDials(Q.Watches.W,'Examiner');
 S86RefreshWatches(Q);
End;

Procedure S86UnselWatches(Var Q:Session8086);Begin
 WESetKrBorder(Q.Watches.W);
 WEBarSelHor(Q.Watches.W,0,Q.Watches.Y,wnMax);
End;

Procedure S86SelWatches(Var Q:Session8086);Begin
 WESetKrSel(Q.Watches.W);
 WEBarSelHor(Q.Watches.W,0,Q.Watches.Y,wnMax);
End;

Procedure S86UpWatches(Var Q:Session8086);Begin
 If Q.Watches.P>0Then Begin
  S86UnSelWatches(Q);
  Dec(Q.Watches.P);
  If Q.Watches.Y>0Then Dec(Q.Watches.Y)
   Else
  Begin
   WEScrollUp(Q.Watches.W,0,1,wnMax,wnMax);
   S86PutLineWatches(Q,Q.Watches.Y,Q.Watches.P);
  End;
  S86SelWatches(Q);
 End;
End;

Procedure S86DnWatches(Var Q:Session8086);Begin
 If(Q.Watches.P<Q.Watches.List.NB)Then Begin
  S86UnSelWatches(Q);
  Inc(Q.Watches.P);
  If(Q.Watches.Y<Q.Watches.W.MaxY)Then Inc(Q.Watches.Y)
   Else
  Begin
   WEScrollDn(Q.Watches.W,0,1,wnMax,wnMax);
   S86PutLineWatches(Q,Q.Watches.Y,Q.Watches.P);
  End;
  S86SelWatches(Q);
 End;
End;

Function S86RunWatches(Var Q:Session8086):Word;
Var
 K:Word;
 S:String;
Begin
 S86SelWatches(Q);
 Repeat
  K:=WEReadk(Q.Watches.W);
  Case(K)of
   kbUp:S86UpWatches(Q);
   kbDn:S86DnWatches(Q);
   kbDel:Begin
    RBDelBuf(Q.Watches.List,Q.Watches.P);
    S86UnSelWatches(Q);
    S86RefreshWatches(Q);
    S86SelWatches(Q);
   End;
   kbIns:Begin
    S:='';
    If(_WinInp(40,'Ajouter un ÇlÇment','Expression Ö examiner',False,S)=kbYes)Then Begin
     RBAddStr(Q.Watches.List,S);
     S86PutLineWatches(Q,Q.Watches.Y,Q.Watches.List.NB-1);
     S86DnWatches(Q);
    End;
   End;
   Else Break;
  End;
 Until False;
 S86RunWatches:=K;
End;

Procedure S86CloseWatches(Var Q:Session8086);Begin
 WEPopWn(Q.Watches.W);
End;

{$I \Source\Chantal\Library\Intr.Inc}

Procedure MakeIntrAddr(Var Q:Session8086);
Var
 I:Byte;
 Tbl:Array[0..255]of LongInt;
Begin
 For I:=0to 255do Begin
  {If Not(I in[$20..$3F])Then} Tbl[I]:=I+1;
 End;
 XSetAbsRec(Q.Memory,0,SizeOf(Tbl),Tbl);
End;

Procedure S86Refresh(Var Context);
Var
 Q:Session8086 Absolute Context;
Begin
 WEPutWnKrDials(Q.W,'Session 80x86');
 Q.W.Y:=Q.W.MaxY-5;
 WEClrScr(Q.AppW);
End;

Procedure S86InitBootFloppy(Var Context;X1,Y1,X2,Y2:Byte);
Var
 Q:Session8086 Absolute Context;
 X,Y,MX:Byte;
 J:Word;
 ClrBuffer:Array[0..1023]of Byte;
 Buffer:BootRec Absolute ClrBuffer;
Begin
 FillClr(Q,SizeOf(Q));
 Q.Log:=errHdl;
 Q.CodeBrk:=-1;
 WEInit(Q.W,X1,Y1,X2,Y2);
 WEInit(Q.Watches.W,0,{MaxYTxts-6}1,MaxXTxts,{MaxYTxts-1}7);
 X:=WEGetRX1(Q.W);
 MX:=Q.W.MaxX;
 If X>0Then Begin
  Dec(X);
  Inc(MX,2);
 End;
 Y:=WEGetRY1(Q.W);
 WEInit(Q.AppW,X,Y,X+MX,Y+Q.W.MaxY-6);
 XAllocMem(rmAllResSteady,1048576,Q.Memory);
 FillClr(ClrBuffer,SizeOf(ClrBuffer));
 For J:=0to 1023do Begin
  XSetAbsRec(Q.Memory,LongInt(J) shl 10,SizeOf(ClrBuffer),ClrBuffer);
 End;
 MakeIntrAddr(Q);
 Q.IP:=$7C00;
 Q.Seg.SS:=$9000;
 Q.Reg.SP:=$FFFE;
 ReadDsk(Q.UnitBoot{ $80},0,1,Buffer);
 XSetAbsRec(Q.Memory,Q.IP,SizeOf(BootRec),Buffer);
End;

Procedure ReadBlock(Var Q:Session8086;Seg,Ofs:Word;Var Buffer;SizeOf:Word);
Var
 Addr:LongInt;
Begin
 Addr:=AddrExt2Conv(Ptr(Seg,Ofs));
 XGetAbsRec(Q.Memory,Addr,SizeOf,Buffer);
End;

Function ReadWord(Var Q:Session8086;Seg,Ofs:Word):Word;Var X:Word;Begin
 ReadBlock(Q,Seg,Ofs,X,SizeOf(X));
 ReadWord:=X;
End;

Procedure WriteBlock(Var Q:Session8086;Seg,Ofs:Word;Var Buffer;SizeOf:Word);
Var
 Addr:LongInt;
 PBuffer:^TByte Absolute Buffer;
Begin
 Addr:=AddrExt2Conv(Ptr(Seg,Ofs));
 If((Addr shr 4)and$FFFFF800=GetVideoSeg)Then Begin
  MoveLeft(Buffer,Mem[Seg:Ofs],SizeOf);
 End;
{ If SizeOf>$8000Then Begin
  XSetAbsRec(Q.Memory,AddrExt2Conv(Ptr(Seg,Ofs+$8000)),SizeOf-$8000,PBuffer^[$8000]);
 End;}
 XSetAbsRec(Q.Memory,Addr,SizeOf,Buffer);

End;

Procedure S86LoadCom(Var Context;X1,Y1,X2,Y2:Byte;Const FileName:String);
Var
 Q:Session8086 Absolute Context;
 Buffer:Pointer;
 Handle:Hdl;
 Size:LongInt;
 X,Y,MX:Byte;
 J:Word;
 PSP:Record Case Byte of
  0:(Buffer:Array[Byte]of Byte);
  1:(Int20h:Word;
     EndSegPrg:Word;
     ReservedA:Byte;
     CallDOS:Array[0..4]of Byte;
     Int22h:Pointer;
     Int23h:Pointer;
     Int24h:Pointer;
     ParentSeg:Word;
     Handle:Array[0..19]of Byte;
     EnvSeg:Word;
     ReservedB:LongInt;
     LenHandle:Word;
     HandlePtr:Pointer;
     ReservedC:Array[0..22]of Byte;
     Int21h:Word;
     RetF:Byte
     );
 End;
 ClrBuffer:Array[0..1023]of Byte;
Begin
 FillClr(Q,SizeOf(Q));
 Q.Log:=errHdl;
 Q.CodeBrk:=-1;
 WEInit(Q.W,X1,Y1,X2,Y2);
 WEInit(Q.Watches.W,0,{MaxYTxts-6}1,MaxXTxts,{MaxYTxts-1}7);
 X:=WEGetRX1(Q.W);
 MX:=Q.W.MaxX;
 If X>0Then Begin
  Dec(X);
  Inc(MX,2);
 End;
 Y:=WEGetRY1(Q.W);
 WEInit(Q.AppW,X,Y,X+MX,Y+Q.W.MaxY-6);
 XAllocMem(rmAllResSteady,10048576,Q.Memory);
 FillClr(ClrBuffer,SizeOf(ClrBuffer));
 For J:=0to 1023do Begin
  XSetAbsRec(Q.Memory,LongInt(J) shl 10,SizeOf(ClrBuffer),ClrBuffer);
 End;
 MakeIntrAddr(Q);
 Handle:=FileOpen(FileName,fmRead);
 If(Handle<>errHdl)Then Begin
  {Q.DOSVersion:=$C864; { $0005; { Version 5.0 }
  Q.DOSVersion:=$0005;
  Q.Seg.CS:=$0060;
  Q.Seg.DS:=Q.Seg.CS;
  Q.Seg.ES:=Q.Seg.CS;
  Q.Seg.SS:=Q.Seg.CS;
  Q.Reg.SP:=$FFFE;
  Q.IP:=$100;
   { êcriture des donnÇes du PSP }
  FillClr(PSP,SizeOf(PSP));
  PSP.Int20h:=$20CD;
  PSP.EndSegPrg:=$9FFF;
  PSP.ParentSeg:=$52;
  PSP.EnvSeg:=$51;
  PSP.LenHandle:=20;
  PSP.HandlePtr:=Ptr(Q.Seg.CS,$18);
  PSP.Int21h:=$21CD;
  PSP.RETF:=$CB;
  WriteBlock(Q,Q.Seg.CS,0,PSP.Buffer,$100);
  Size:=FileSize(Handle);
  Buffer:=MemAlloc(Size);
  If(Buffer<>NIL)Then Begin
   _GetAbsRec(Handle,0,Size,Buffer^);
   WriteBlock(Q,Q.Seg.CS,Q.IP,Buffer^,Size);
  End;
  FreeMem(Buffer,Size);
  FileClose(Handle);
 End;
End;

Procedure S86MoveLeft(Var Q:Session8086;DS,SI,ES,DI,CX:Word);
Var
 Ptr:Pointer;
Begin
 Ptr:=MemAlloc(CX);
 If(Ptr<>NIL)Then Begin
  If(DF)in(Q.Flags.s)Then Begin { Sens inverse? }
   ReadBlock(Q,DS,SI-CX,Ptr^,CX);
   WriteBlock(Q,ES,DI-CX,Ptr^,CX);
  End
   Else
  Begin
   ReadBlock(Q,DS,SI,Ptr^,CX);
   WriteBlock(Q,ES,DI,Ptr^,CX);
  End;
  FreeMem(Ptr,CX);
 End;
End;

Procedure S86FillChar(Var Q:Session8086;ES,DI,CX:Word;AL:Byte);
Var
 Ptr:Pointer;
Begin
 Ptr:=MemAlloc(CX);
 If(Ptr<>NIL)Then Begin
  FillChr(Ptr^,CX,AL);
  If(DF)in(Q.Flags.s)Then Begin { Sens inverse? }
   WriteBlock(Q,ES,DI-CX,Ptr^,CX);
  End
   Else
  Begin
   WriteBlock(Q,ES,DI,Ptr^,CX);
  End;
  FreeMem(Ptr,CX);
 End;
End;

Procedure S86FillWord(Var Q:Session8086;ES,DI,CX,AX:Word);
Var
 Ptr:Pointer;
Begin
 Ptr:=MemAlloc(CX);
 If(Ptr<>NIL)Then Begin
  FillWord(Ptr^,CX shr 1,AX);
  If(DF)in(Q.Flags.s)Then Begin { Sens inverse? }
   WriteBlock(Q,ES,DI-CX,Ptr^,CX);
  End
   Else
  Begin
   WriteBlock(Q,ES,DI,Ptr^,CX);
  End;
  FreeMem(Ptr,CX);
 End;
End;

Function LibMalte(Var Q:Session8086;Code:Word):Word;
Var
 S:String;   { Chaåne de caractäre de travail }
 Ptr:Pointer;{ Pointeur sur de la mÇmoire dynamique }
 L:Word;     { Longueur }
 TL:LongInt; { Longueur long }
Begin
 LibMalte:=2;
 Case Lo(Code)of
  $10:Case Hi(Code)of { Bibliothäque vidÇo }
   0:Begin
    Q.Reg.AL:=GetVideoCard; { Sorte de la carte vidÇo primaire }
    Q.Reg.AH:=0;            { Sorte de la carte vidÇo secondaire }
   End;
   1:Begin
    Q.Reg.AL:=Byte(IsGrf);
    Q.Reg.AH:=Byte(IsKr);
    Q.Reg.BX:=GetBitsPerPixel;
    Q.Reg.CX:=GetNumXPixels;
    Q.Reg.DX:=GetNumYPixels;
   End;
   2:Q.Reg.AX:=BytesPerLine;
   3:Q.Reg.AX:=GetMaxXPixels;
   4:Q.Reg.AX:=GetMaxYPixels;
   5:Q.Reg.AL:=GetNmVideoPages;
   6:Q.Reg.EAX:=GetNmColors;
   7:Begin
    TL:=GetNmColors;
    Q.Reg.AX:=TL;
    Q.Reg.DX:=LongRec(TL).Hi;
   End;
   $10:SetVideoMode(Q.Reg.AX);
   $11:SetVideoModeDeluxe(Q.Reg.AX);
   $12:PushScr(Q.M);
   $13:PopScr(Q.M);
   $20:Q.Reg.AL:=PrimCardCat;
   $21:Q.Reg.AL:=Byte(BiosBlinkFound);
   $22:Q.Reg.AL:=Byte(ColorFound);
   $23:Q.Reg.AL:=Byte(FontFound);
   $30:ClrScr(Q.Reg.AH);
   $31:ClrWn(Q.Reg.CL,Q.Reg.CH,Q.Reg.DL,Q.Reg.DH,Q.Reg.AH);
   $32:FillBox(Q.Reg.CL,Q.Reg.CH,Q.Reg.DL,Q.Reg.DH,Chr(Q.Reg.AL),Q.Reg.AH);
   $33:SetBackgroundColor(Q.Reg.AH);
   $34:MoveText(Q.Reg.CL,Q.Reg.CH,Q.Reg.DL,Q.Reg.DH,Q.Reg.BL,Q.Reg.BH);
   $35:Q.Reg.AX:=GetCube(Q.Reg.CL,Q.Reg.CH);
   $36:Q.Reg.AL:=Byte(GetChr(Q.Reg.CL,Q.Reg.CH));
   $37:Q.Reg.AH:=GetAttr(Q.Reg.CL,Q.Reg.CH);
   $38:CloseCur;
   $39:SimpleCur;
   $3A:SetCurPos(Q.Reg.CL,Q.Reg.CH);
   $3B:SetCursor(Q.Reg.AL,Q.Reg.AH);
   $40:BarChrHor(Q.Reg.CL,Q.Reg.CH,Q.Reg.DL,Chr(Q.Reg.AL));
   $41:BarChrVer(Q.Reg.CL,Q.Reg.CH,Q.Reg.DH,Chr(Q.Reg.AL));
   $42:BarSpcHor(Q.Reg.CL,Q.Reg.CH,Q.Reg.DL,Q.Reg.AH);
   $43:BarSpcVer(Q.Reg.CL,Q.Reg.CH,Q.Reg.DH,Q.Reg.AH);
   $44:BarTxtHor(Q.Reg.CL,Q.Reg.CH,Q.Reg.DL,Chr(Q.Reg.AL),Q.Reg.AH);
   $50:Begin
    ReadBlock(Q,Q.Seg.ES,Q.Reg.DI,S,SizeOf(S));
    PutTextXY(Q.Reg.CL,Q.Reg.CH,S,Q.Reg.AH);
   End;
   $51:Begin
    ReadBlock(Q,Q.Seg.ES,Q.Reg.DI,S,SizeOf(S));
    PutTxtXYUnKr(Q.Reg.CL,Q.Reg.CH,S);
   End;
   $58:Begin
    ReadBlock(Q,Q.Seg.ES,Q.Reg.DI,S,SizeOf(S));
    PutSmlTxtXY(Q.Reg.CL,Q.Reg.CH,S,Q.Reg.AH);
   End;
   $60:SetChr(Q.Reg.CL,Q.Reg.CH,Chr(Q.Reg.AL));
   $61:SetAttr(Q.Reg.CL,Q.Reg.CH,Q.Reg.AH);
   $62:SetCube(Q.Reg.CL,Q.Reg.CH,Chr(Q.Reg.AL),Q.Reg.AH);
   $63:SetGCube(Q.Reg.CX,Q.Reg.DX,Chr(Q.Reg.AL),Q.Reg.AH);
   $64:SetGCubeT(Q.Reg.CX,Q.Reg.DX,Chr(Q.Reg.AL),Q.Reg.AH);
   $70:CopT8Bin(Q.Reg.CX,Q.Reg.DX,Q.Reg.AL,Q.Reg.SI);
   $71:Copy8Bin(Q.Reg.CX,Q.Reg.Dx,Q.Reg.AL,Q.Reg.SI,Q.Reg.DI);
   $80:Circle(Q.Reg.CX,Q.Reg.DX,Q.Reg.BX,Q.Reg.AX);
   $81:PutFillCircle(Q.Reg.CX,Q.Reg.DX,Q.Reg.BX,Q.Reg.AX);
   $82:PutLn(Q.Reg.AX,Q.Reg.BX,Q.Reg.CX,Q.Reg.DX,Q.Reg.SI);
   $83:PutLnHor(Q.Reg.CX,Q.Reg.DX,Q.Reg.BX,Q.Reg.AX);
   $83:ClrLnHor(Q.Reg.CX,Q.Reg.DX,Q.Reg.BX,Q.Reg.AX);
   $84:Begin
    L:=LocalBytesPerLine(BytesPerLine,Q.Reg.BL);
    Ptr:=MemAlloc(L);
    If(Ptr<>NIL)Then Begin
     ReadBlock(Q,Q.Seg.ES,Q.Reg.DI,Ptr^,L);
     ClrLnHorImg(Q.Reg.CX,Q.Reg.DX,Q.Reg.AX,Q.Reg.BL,Ptr^);
     FreeMem(Ptr,L);
    End;
   End;
   $85:PutRect(Q.Reg.AX,Q.Reg.BX,Q.Reg.CX,Q.Reg.DX,Q.Reg.SI);
   $86:PutFillBox(Q.Reg.AX,Q.Reg.BX,Q.Reg.CX,Q.Reg.DX,Q.Reg.SI);
   $87:PutRoundRect(Q.Reg.AX,Q.Reg.BX,Q.Reg.CX,Q.Reg.DX,Q.Reg.BP,Q.Reg.DI,Q.Reg.SI);
   $90:Q.Reg.AX:=GetPixel(Q.Reg.CX,Q.Reg.DX);
   $91:SetPixel(Q.Reg.CX,Q.Reg.DX,Q.Reg.AX);
   $B0:Q.Reg.AX:=RGB2Color(Q.Reg.BL,Q.Reg.BH,Q.Reg.CL);
   $C0:SetUnderline(Boolean(Q.Reg.AL));
   $C1:SetBlink(Boolean(Q.Reg.AL));
   $CD:_WaitDisplay;
   $CE:_WaitRetrace;
   $CF:WaitRetrace;
   $D0:SetPage(Q.Reg.AL);
   $D1:SetVisualPage(Q.Reg.AL);
   $D2:PCopy(Q.Reg.AL,Q.Reg.AH);
   $D3:PCopy2Img(Q.Reg.AL,Q.Reg.CX,Q.Reg.DX,Q.Reg.SI,Q.Reg.DI);
   $D4:Q.Reg.AL:=_GetActivePage;
   $E0:Q.Reg.AX:=GetSizeSmlImg(Q.Reg.AX,Q.Reg.BX,Q.Reg.CX,Q.Reg.DX);
   $E1:Begin
    L:=GetSizeSmlImg(Q.Reg.AX,Q.Reg.BX,Q.Reg.CX,Q.Reg.DX);
    Ptr:=MemAlloc(L);
    If(Ptr<>NIL)Then Begin
     GetSmlImg(Q.Reg.AX,Q.Reg.BX,Q.Reg.CX,Q.Reg.DX,Ptr^);
     WriteBlock(Q,Q.Seg.ES,Q.Reg.DI,Ptr^,L);
     FreeMem(Ptr,L);
    End;
   End;
   $E2:Begin
    L:=GetSizeSmlImg(Q.Reg.AX,Q.Reg.BX,Q.Reg.CX,Q.Reg.DX);
    Ptr:=MemAlloc(L);
    If(Ptr<>NIL)Then Begin
     ReadBlock(Q,Q.Seg.ES,Q.Reg.DI,Ptr^,L);
     PutSmlImg(Q.Reg.AX,Q.Reg.BX,Q.Reg.CX,Q.Reg.DX,Ptr^);
     FreeMem(Ptr,L);
    End;
   End;
   $E3:Begin
    L:=GetSizeSmlImg(Q.Reg.AX,Q.Reg.BX,Q.Reg.CX,Q.Reg.DX);
    Ptr:=MemAlloc(L);
    If(Ptr<>NIL)Then Begin
     ReadBlock(Q,Q.Seg.ES,Q.Reg.DI,Ptr^,L);
     PutSprite(Q.Reg.AX,Q.Reg.BX,Q.Reg.CX,Q.Reg.DX,Ptr^);
     FreeMem(Ptr,L);
    End;
   End;
   $F0:Begin
    LongRec(TL).Lo:=Q.Reg.CX;
    LongRec(TL).Hi:=Q.Reg.DX;
    FillBnk(TL,Q.Reg.BX,Q.Reg.AX);
   End;
   $F1:FillBnk(Q.Reg.ECX,Q.Reg.BX,Q.Reg.AX);
  End;
  $11:Case Hi(Code)of { Bibliothäque de la fenàtre d'application }
   0:Begin
    ReadBlock(Q,Q.Seg.ES,Q.Reg.DI,S,SizeOf(S));
    WEPutWnKrDials(Q.AppW,S);
   End;
   1:ASM
    LES DI,Q
    MOV AX,Word Ptr ES:[DI].Session8086.AppW.MaxX
    MOV ES:[DI].Session8086.Reg.&AX,AX
   END;
   $10:WESetPos(Q.AppW,Q.Reg.AL,Q.Reg.AH);
   $11:WESetCurPos(Q.AppW,Q.Reg.AL,Q.Reg.AH);
   $50:Begin
    ReadBlock(Q,Q.Seg.ES,Q.Reg.DI,S,SizeOf(S));
    WEPutTxtXY(Q.AppW,Q.Reg.CL,Q.Reg.CH,S);
   End;
   $51:Begin
    ReadBlock(Q,Q.Seg.ES,Q.Reg.DI,S,SizeOf(S));
    WEPutTxtXYU(Q.AppW,Q.Reg.CL,Q.Reg.CH,S);
   End;
   $58:Begin
    ReadBlock(Q,Q.Seg.ES,Q.Reg.DI,S,SizeOf(S));
    WEPutSmlTxtXY(Q.AppW,Q.Reg.CL,Q.Reg.CH,S);
   End;
  End;
 End;
End;

Procedure asmUpdateFlags;Near;Assembler;ASM
 PUSHF
 POP BX
{ AND BX,008FFh}
 AND ES:[DI].Session8086.Flags.Base,Not 008FFh
 OR  ES:[DI].Session8086.Flags.Base,BX
  { Restaure les drapeaux }
 PUSH SI
 POPF
END;

Procedure asmRestoreFlags;Near;Assembler;ASM
  { PrÇserve les drapeaux }
 PUSHF
 POP SI
  { Applique le drapeau de l'Çmulateur }
 PUSH ES:[DI].Session8086.Flags.Base
 POPF
END;

Procedure S86AAA(Var Q:Session8086);Assembler;ASM
 LES DI,Q
 CALL asmRestoreFlags
 MOV AX,ES:[DI].Session8086.Reg.&AX
 AAA
 MOV ES:[DI].Session8086.Reg.&AX,AX
 CALL asmUpdateFlags
END;

Procedure S86AAD(Var Q:Session8086);Assembler;ASM
 LES DI,Q
 CALL asmRestoreFlags
 MOV AX,ES:[DI].Session8086.Reg.&AX
 AAD
 MOV ES:[DI].Session8086.Reg.&AX,AX
 CALL asmUpdateFlags
END;

Procedure S86AAM(Var Q:Session8086);Assembler;ASM
 LES DI,Q
 CALL asmRestoreFlags
 MOV AX,ES:[DI].Session8086.Reg.&AX
 AAM
 MOV ES:[DI].Session8086.Reg.&AX,AX
 CALL asmUpdateFlags
END;

Procedure S86AAS(Var Q:Session8086);Assembler;ASM
 LES DI,Q
 CALL asmRestoreFlags
 MOV AX,ES:[DI].Session8086.Reg.&AX
 AAS
 MOV ES:[DI].Session8086.Reg.&AX,AX
 CALL asmUpdateFlags
END;

Procedure S86CBW(Var Q:Session8086);Assembler;ASM
 LES DI,Q
 CALL asmRestoreFlags
 MOV AX,ES:[DI].Session8086.Reg.&AX
 CBW
 MOV ES:[DI].Session8086.Reg.&AX,AX
 CALL asmUpdateFlags
END;

Procedure S86CWD(Var Q:Session8086);Assembler;ASM
 LES DI,Q
 CALL asmRestoreFlags
 MOV AX,ES:[DI].Session8086.Reg.&AX
 MOV DX,ES:[DI].Session8086.Reg.&DX
 CWD
 MOV ES:[DI].Session8086.Reg.&AX,AX
 MOV ES:[DI].Session8086.Reg.&DX,DX
 CALL asmUpdateFlags
END;

Procedure S86DAA(Var Q:Session8086);Assembler;ASM
 LES DI,Q
 CALL asmRestoreFlags
 MOV AX,ES:[DI].Session8086.Reg.&AX
 DAA
 MOV ES:[DI].Session8086.Reg.&AX,AX
 CALL asmUpdateFlags
END;

Procedure S86DAS(Var Q:Session8086);Assembler;ASM
 LES DI,Q
 CALL asmRestoreFlags
 MOV AX,ES:[DI].Session8086.Reg.&AX
 MOV DX,ES:[DI].Session8086.Reg.&DX
 DAS
 MOV ES:[DI].Session8086.Reg.&AX,AX
 MOV ES:[DI].Session8086.Reg.&DX,DX
 CALL asmUpdateFlags
END;

Function S86OrWordF(Var Q:Session8086;Source,Dest:Word):Word;Near;Assembler;ASM
 LES DI,Q
 CALL asmRestoreFlags
 MOV AX,Source
 OR  AX,Dest
 CALL asmUpdateFlags
END;

Function S86OrByteF(Var Q:Session8086;Source,Dest:Byte):Byte;Near;Assembler;ASM
 LES DI,Q
 CALL asmRestoreFlags
 MOV AL,Source
 OR  AL,Dest
 CALL asmUpdateFlags
END;

Procedure S86OrWord(Var Q:Session8086;Var Source:Word;Dest:Word);Near;Assembler;ASM
 LES DI,Q
 CALL asmRestoreFlags
 MOV AX,Dest
 LES DI,Source
 OR  ES:[DI],AX
 LES DI,Q
 CALL asmUpdateFlags
END;

Procedure S86OrByte(Var Q:Session8086;Var Source:Byte;Dest:Byte);Near;Assembler;ASM
 LES DI,Q
 CALL asmRestoreFlags
 MOV AL,Dest
 LES DI,Source
 OR  ES:[DI],AL
 LES DI,Q
 CALL asmUpdateFlags
END;

Function S86AndWordF(Var Q:Session8086;Source,Dest:Word):Word;Near;Assembler;ASM
 LES DI,Q
 CALL asmRestoreFlags
 MOV AX,Source
 AND AX,Dest
 CALL asmUpdateFlags
END;

Function S86AndByteF(Var Q:Session8086;Source,Dest:Byte):Byte;Near;Assembler;ASM
 LES DI,Q
 CALL asmRestoreFlags
 MOV AL,Source
 AND AL,Dest
 CALL asmUpdateFlags
END;

Procedure S86AndWord(Var Q:Session8086;Var Source:Word;Dest:Word);Near;Assembler;ASM
 LES DI,Q
 CALL asmRestoreFlags
 MOV AX,Dest
 LES DI,Source
 AND ES:[DI],AX
 LES DI,Q
 CALL asmUpdateFlags
END;

Procedure S86AndByte(Var Q:Session8086;Var Source:Byte;Dest:Byte);Near;Assembler;ASM
 LES DI,Q
 CALL asmRestoreFlags
 MOV AL,Dest
 LES DI,Source
 AND ES:[DI],AL
 LES DI,Q
 CALL asmUpdateFlags
END;

Function S86XorWordF(Var Q:Session8086;Source,Dest:Word):Word;Near;Assembler;ASM
 LES DI,Q
 CALL asmRestoreFlags
 MOV AX,Source
 XOR AX,Dest
 CALL asmUpdateFlags
END;

Function S86XorByteF(Var Q:Session8086;Source,Dest:Byte):Byte;Near;Assembler;ASM
 LES DI,Q
 CALL asmRestoreFlags
 MOV AL,Source
 XOR AL,Dest
 CALL asmUpdateFlags
END;

Procedure S86XorWord(Var Q:Session8086;Var Source:Word;Dest:Word);Near;Assembler;ASM
 LES DI,Q
 CALL asmRestoreFlags
 MOV AX,Dest
 LES DI,Source
 XOR ES:[DI],AX
 LES DI,Q
 CALL asmUpdateFlags
END;

Procedure S86XorByte(Var Q:Session8086;Var Source:Byte;Dest:Byte);Near;Assembler;ASM
 LES DI,Q
 CALL asmRestoreFlags
 MOV AL,Dest
 LES DI,Source
 XOR ES:[DI],AL
 LES DI,Q
 CALL asmUpdateFlags
END;

Function S86AddWordF(Var Q:Session8086;Source,Dest:Word):Word;Near;Assembler;ASM
 LES DI,Q
 CALL asmRestoreFlags
 MOV AX,Source
 ADD AX,Dest
 CALL asmUpdateFlags
END;

Function S86AddByteF(Var Q:Session8086;Source,Dest:Byte):Byte;Near;Assembler;ASM
 LES DI,Q
 CALL asmRestoreFlags
 MOV AL,Source
 ADD AL,Dest
 CALL asmUpdateFlags
END;

Procedure S86AddWord(Var Q:Session8086;Var Source:Word;Dest:Word);Near;Assembler;ASM
 LES DI,Q
 CALL asmRestoreFlags
 MOV AX,Dest
 LES DI,Source
 ADD ES:[DI],AX
 LES DI,Q
 CALL asmUpdateFlags
END;

Procedure S86AddByte(Var Q:Session8086;Var Source:Byte;Dest:Byte);Near;Assembler;ASM
 LES DI,Q
 CALL asmRestoreFlags
 MOV AL,Dest
 LES DI,Source
 ADD ES:[DI],AL
 LES DI,Q
 CALL asmUpdateFlags
END;

Function S86CmpWordF(Var Q:Session8086;Source,Dest:Word):Word;Near;Assembler;ASM
 LES DI,Q
 CALL asmRestoreFlags
 MOV AX,Source
 CMP AX,Dest
 LES DI,Q
 CALL asmUpdateFlags
END;

Function S86CmpByteF(Var Q:Session8086;Source,Dest:Byte):Byte;Near;Assembler;ASM
 LES DI,Q
 CALL asmRestoreFlags
 MOV AL,Source
 CMP AL,Dest
 CALL asmUpdateFlags
END;

Procedure S86CmpWord(Var Q:Session8086;Var Source:Word;Dest:Word);Near;Assembler;ASM
 LES DI,Q
 CALL asmRestoreFlags
 MOV AX,Dest
 LES DI,Source
 CMP ES:[DI],AX
 LES DI,Q
 CALL asmUpdateFlags
END;

Procedure S86CmpByte(Var Q:Session8086;Var Source:Byte;Dest:Byte);Near;Assembler;ASM
 LES DI,Q
 CALL asmRestoreFlags
 MOV AL,Dest
 LES DI,Source
 CMP ES:[DI],AL
 LES DI,Q
 CALL asmUpdateFlags
END;

Procedure S86SubWord(Var Q:Session8086;Var Source:Word;Dest:Word);Near;Assembler;ASM
 LES DI,Q
 CALL asmRestoreFlags
 MOV AX,Dest
 LES DI,Source
 SUB ES:[DI],AX
 LES DI,Q
 CALL asmUpdateFlags
END;

Procedure S86SubByte(Var Q:Session8086;Var Source:Byte;Dest:Byte);Near;Assembler;ASM
 LES DI,Q
 CALL asmRestoreFlags
 MOV AL,Dest
 LES DI,Source
 SUB ES:[DI],AL
 LES DI,Q
 CALL asmUpdateFlags
END;

Function S86SubWordF(Var Q:Session8086;Source,Dest:Word):Word;Near;Assembler;ASM
 LES DI,Q
 CALL asmRestoreFlags
 MOV AX,Source
 SUB AX,Dest
 CALL asmUpdateFlags
END;

Function S86SubByteF(Var Q:Session8086;Source,Dest:Byte):Byte;Near;Assembler;ASM
 LES DI,Q
 CALL asmRestoreFlags
 MOV AL,Source
 SUB AL,Dest
 CALL asmUpdateFlags
END;

Function S86SbbWordF(Var Q:Session8086;Source,Dest:Word):Word;Near;Assembler;ASM
 LES DI,Q
 CALL asmRestoreFlags
 MOV AX,Source
 SBB AX,Dest
 LES DI,Q
 CALL asmUpdateFlags
END;

Function S86SbbByteF(Var Q:Session8086;Source,Dest:Byte):Byte;Near;Assembler;ASM
 LES DI,Q
 CALL asmRestoreFlags
 MOV AL,Source
 SBB AL,Dest
 LES DI,Q
 CALL asmUpdateFlags
END;

Function S86AdcWordF(Var Q:Session8086;Source,Dest:Word):Word;Near;Assembler;ASM
 LES DI,Q
 CALL asmRestoreFlags
 MOV AX,Source
 ADC AX,Dest
 LES DI,Q
 CALL asmUpdateFlags
END;

Function S86AdcByteF(Var Q:Session8086;Source,Dest:Byte):Byte;Near;Assembler;ASM
 LES DI,Q
 CALL asmRestoreFlags
 MOV AL,Source
 ADC AL,Dest
 LES DI,Q
 CALL asmUpdateFlags
END;

Procedure S86SbbWord(Var Q:Session8086;Var Source:Word;Dest:Word);Near;Assembler;ASM
 LES DI,Q
 CALL asmRestoreFlags
 MOV BX,Dest
 LES DI,Source
 SBB ES:[DI],BX
 LES DI,Q
 CALL asmUpdateFlags
END;

Procedure S86SbbByte(Var Q:Session8086;Var Source:Byte;Dest:Byte);Near;Assembler;ASM
 LES DI,Q
 CALL asmRestoreFlags
 MOV AL,Dest
 LES DI,Source
 SBB ES:[DI],AL
 LES DI,Q
 CALL asmUpdateFlags
END;

Procedure S86AdcWord(Var Q:Session8086;Var Source:Word;Dest:Word);Near;Assembler;ASM
 LES DI,Q
 CALL asmRestoreFlags
 MOV BX,Dest
 LES DI,Source
 ADC ES:[DI],BX
 LES DI,Q
 CALL asmUpdateFlags
END;

Procedure S86AdcByte(Var Q:Session8086;Var Source:Byte;Dest:Byte);Near;Assembler;ASM
 LES DI,Q
 CALL asmRestoreFlags
 MOV AL,Dest
 LES DI,Source
 ADC ES:[DI],AL
 LES DI,Q
 CALL asmUpdateFlags
END;

Procedure S86DivWord(Var Q:Session8086;Source:Word);Near;Assembler;ASM
 LES DI,Q
 CALL asmRestoreFlags
 MOV AX,ES:[DI].Session8086.Reg.&AX
 MOV DX,ES:[DI].Session8086.Reg.&DX
 DIV Source
 MOV ES:[DI].Session8086.Reg.&AX,AX
 MOV ES:[DI].Session8086.Reg.&DX,DX
 CALL asmUpdateFlags
END;

Procedure S86DivByte(Var Q:Session8086;Source:Byte);Near;Assembler;ASM
 LES DI,Q
 CALL asmRestoreFlags
 MOV AX,ES:[DI].Session8086.Reg.&AX
 DIV Source
 MOV ES:[DI].Session8086.Reg.&AX,AX
 CALL asmUpdateFlags
END;

Procedure S86MulWord(Var Q:Session8086;Source:Word);Near;Assembler;ASM
 LES DI,Q
 CALL asmRestoreFlags
 MOV AX,ES:[DI].Session8086.Reg.&AX
 MOV DX,ES:[DI].Session8086.Reg.&DX
 MUL Source
 MOV ES:[DI].Session8086.Reg.&AX,AX
 MOV ES:[DI].Session8086.Reg.&DX,DX
 CALL asmUpdateFlags
END;

Procedure S86MulByte(Var Q:Session8086;Source:Byte);Near;Assembler;ASM
 LES DI,Q
 CALL asmRestoreFlags
 MOV AX,ES:[DI].Session8086.Reg.&AX
 MUL Source
 MOV ES:[DI].Session8086.Reg.&AX,AX
 CALL asmUpdateFlags
END;

Procedure S86IDivWord(Var Q:Session8086;Source:Word);Near;Assembler;ASM
 LES DI,Q
 CALL asmRestoreFlags
 MOV AX,ES:[DI].Session8086.Reg.&AX
 MOV DX,ES:[DI].Session8086.Reg.&DX
 IDIV Source
 MOV ES:[DI].Session8086.Reg.&AX,AX
 MOV ES:[DI].Session8086.Reg.&DX,DX
 CALL asmUpdateFlags
END;

Procedure S86IDivByte(Var Q:Session8086;Source:Byte);Near;Assembler;ASM
 LES DI,Q
 CALL asmRestoreFlags
 MOV AX,ES:[DI].Session8086.Reg.&AX
 IDIV Source
 MOV ES:[DI].Session8086.Reg.&AX,AX
 CALL asmUpdateFlags
END;

Procedure S86IMulWord(Var Q:Session8086;Source:Word);Near;Assembler;ASM
 LES DI,Q
 CALL asmRestoreFlags
 MOV AX,ES:[DI].Session8086.Reg.&AX
 MOV DX,ES:[DI].Session8086.Reg.&DX
 IMUL Source
 MOV ES:[DI].Session8086.Reg.&AX,AX
 MOV ES:[DI].Session8086.Reg.&DX,DX
 CALL asmUpdateFlags
END;

Procedure S86IMulByte(Var Q:Session8086;Source:Byte);Near;Assembler;ASM
 LES DI,Q
 CALL asmRestoreFlags
 MOV AX,ES:[DI].Session8086.Reg.&AX
 IMUL Source
 MOV ES:[DI].Session8086.Reg.&AX,AX
 CALL asmUpdateFlags
END;

Function S86DecWordF(Var Q:Session8086;Source:Word):Word;Near;Assembler;ASM
 LES DI,Q
 CALL asmRestoreFlags
 MOV AX,Source
 DEC AX
 CALL asmUpdateFlags
END;

Function S86DecByteF(Var Q:Session8086;Source:Byte):Byte;Near;Assembler;ASM
 LES DI,Q
 CALL asmRestoreFlags
 MOV AL,Source
 DEC AL
 CALL asmUpdateFlags
END;

Procedure S86DecWord(Var Q:Session8086;Var Source:Word);Near;Assembler;ASM
 LES DI,Q
 CALL asmRestoreFlags
 LES DI,Source
 DEC Word Ptr ES:[DI]
 LES DI,Q
 CALL asmUpdateFlags
END;

Procedure S86DecByte(Var Q:Session8086;Var Source:Byte);Near;Assembler;ASM
 LES DI,Q
 CALL asmRestoreFlags
 LES DI,Source
 DEC Byte Ptr ES:[DI]
 LES DI,Q
 CALL asmUpdateFlags
END;

Function S86IncWordF(Var Q:Session8086;Source:Word):Word;Near;Assembler;ASM
 LES DI,Q
 CALL asmRestoreFlags
 MOV AX,Source
 INC AX
 LES DI,Q
 CALL asmUpdateFlags
END;

Function S86IncByteF(Var Q:Session8086;Source:Byte):Byte;Near;Assembler;ASM
 LES DI,Q
 CALL asmRestoreFlags
 MOV AL,Source
 INC AL
 LES DI,Q
 CALL asmUpdateFlags
END;

Procedure S86IncWord(Var Q:Session8086;Var Source:Word);Near;Assembler;ASM
 LES DI,Q
 CALL asmRestoreFlags
 LES DI,Source
 INC Word Ptr ES:[DI]
 LES DI,Q
 CALL asmUpdateFlags
END;

Procedure S86IncByte(Var Q:Session8086;Var Source:Byte);Near;Assembler;ASM
 LES DI,Q
 CALL asmRestoreFlags
 LES DI,Source
 INC Byte Ptr ES:[DI]
 LES DI,Q
 CALL asmUpdateFlags
END;

Procedure S86NotWord(Var Q:Session8086;Var Source:Word);Near;Assembler;ASM
 LES DI,Q
 CALL asmRestoreFlags
 LES DI,Source
 NOT Word Ptr ES:[DI]
 LES DI,Q
 CALL asmUpdateFlags
END;

Procedure S86NotByte(Var Q:Session8086;Var Source:Byte);Near;Assembler;ASM
 LES DI,Q
 CALL asmRestoreFlags
 LES DI,Source
 NOT Byte Ptr ES:[DI]
 LES DI,Q
 CALL asmUpdateFlags
END;

Procedure S86ShlByte(Var Q:Session8086;Var Source:Byte);Near;Assembler;ASM
 LES DI,Q
 CALL asmRestoreFlags
 LES DI,Source
 SHL Byte Ptr ES:[DI],1
 LES DI,Q
 CALL asmUpdateFlags
END;

Procedure S86ShrByte(Var Q:Session8086;Var Source:Byte);Near;Assembler;ASM
 LES DI,Q
 CALL asmRestoreFlags
 LES DI,Source
 SHR Byte Ptr ES:[DI],1
 LES DI,Q
 CALL asmUpdateFlags
END;

Procedure S86ShlWord(Var Q:Session8086;Var Source:Word);Near;Assembler;ASM
 LES DI,Q
 CALL asmRestoreFlags
 LES DI,Source
 SHL Word Ptr ES:[DI],1
 LES DI,Q
 CALL asmUpdateFlags
END;

Procedure S86ShrWord(Var Q:Session8086;Var Source:Word);Near;Assembler;ASM
 LES DI,Q
 CALL asmRestoreFlags
 LES DI,Source
 SHR Word Ptr ES:[DI],1
 LES DI,Q
 CALL asmUpdateFlags
END;

Procedure S86RolByte(Var Q:Session8086;Var Source:Byte);Near;Assembler;ASM
 LES DI,Q
 CALL asmRestoreFlags
 LES DI,Source
 ROL Byte Ptr ES:[DI],1
 LES DI,Q
 CALL asmUpdateFlags
END;

Procedure S86RorByte(Var Q:Session8086;Var Source:Byte);Near;Assembler;ASM
 LES DI,Q
 CALL asmRestoreFlags
 LES DI,Source
 ROR Byte Ptr ES:[DI],1
 LES DI,Q
 CALL asmUpdateFlags
END;

Procedure S86RolWord(Var Q:Session8086;Var Source:Word);Near;Assembler;ASM
 LES DI,Q
 CALL asmRestoreFlags
 LES DI,Source
 ROL Word Ptr ES:[DI],1
 LES DI,Q
 CALL asmUpdateFlags
END;

Procedure S86RorWord(Var Q:Session8086;Var Source:Word);Near;Assembler;ASM
 LES DI,Q
 CALL asmRestoreFlags
 LES DI,Source
 SHR Word Ptr ES:[DI],1
 LES DI,Q
 CALL asmUpdateFlags
END;

Procedure S86SalByte(Var Q:Session8086;Var Source:Byte);Near;Assembler;ASM
 LES DI,Q
 CALL asmRestoreFlags
 LES DI,Source
 SAL Byte Ptr ES:[DI],1
 LES DI,Q
 CALL asmUpdateFlags
END;

Procedure S86SarByte(Var Q:Session8086;Var Source:Byte);Near;Assembler;ASM
 LES DI,Q
 CALL asmRestoreFlags
 LES DI,Source
 SAR Byte Ptr ES:[DI],1
 LES DI,Q
 CALL asmUpdateFlags
END;

Procedure S86SalWord(Var Q:Session8086;Var Source:Word);Near;Assembler;ASM
 LES DI,Q
 CALL asmRestoreFlags
 LES DI,Source
 SAL Word Ptr ES:[DI],1
 LES DI,Q
 CALL asmUpdateFlags
END;

Procedure S86SarWord(Var Q:Session8086;Var Source:Word);Near;Assembler;ASM
 LES DI,Q
 CALL asmRestoreFlags
 LES DI,Source
 SAR Word Ptr ES:[DI],1
 LES DI,Q
 CALL asmUpdateFlags
END;

Procedure S86ShlByteCL(Var Q:Session8086;Var Source:Byte);Near;Assembler;ASM
 LES DI,Q
 CALL asmRestoreFlags
 MOV CL,ES:[DI].Session8086.Reg.&CL
 LES DI,Source
 SHL Byte Ptr ES:[DI],CL
 LES DI,Q
 CALL asmUpdateFlags
END;

Procedure S86ShrByteCL(Var Q:Session8086;Var Source:Byte);Near;Assembler;ASM
 LES DI,Q
 CALL asmRestoreFlags
 MOV CL,ES:[DI].Session8086.Reg.&CL
 LES DI,Source
 SHR Byte Ptr ES:[DI],CL
 LES DI,Q
 CALL asmUpdateFlags
END;

Procedure S86ShlWordCL(Var Q:Session8086;Var Source:Word);Near;Assembler;ASM
 LES DI,Q
 CALL asmRestoreFlags
 MOV CL,ES:[DI].Session8086.Reg.&CL
 LES DI,Source
 SHL Word Ptr ES:[DI],CL
 LES DI,Q
 CALL asmUpdateFlags
END;

Procedure S86ShrWordCL(Var Q:Session8086;Var Source:Word);Near;Assembler;ASM
 LES DI,Q
 CALL asmRestoreFlags
 MOV CL,ES:[DI].Session8086.Reg.&CL
 LES DI,Source
 SHR Word Ptr ES:[DI],CL
 LES DI,Q
 CALL asmUpdateFlags
END;

Procedure S86RolByteCL(Var Q:Session8086;Var Source:Byte);Near;Assembler;ASM
 LES DI,Q
 CALL asmRestoreFlags
 MOV CL,ES:[DI].Session8086.Reg.&CL
 LES DI,Source
 ROL Byte Ptr ES:[DI],CL
 LES DI,Q
 CALL asmUpdateFlags
END;

Procedure S86RorByteCL(Var Q:Session8086;Var Source:Byte);Near;Assembler;ASM
 LES DI,Q
 CALL asmRestoreFlags
 MOV CL,ES:[DI].Session8086.Reg.&CL
 LES DI,Source
 ROR Byte Ptr ES:[DI],CL
 LES DI,Q
 CALL asmUpdateFlags
END;

Procedure S86RorByteDirect(Var Q:Session8086;Var Source:Byte;Rotation:Byte);Near;Assembler;ASM
 LES DI,Q
 CALL asmRestoreFlags
 MOV CL,Rotation
 LES DI,Source
 ROR Byte Ptr ES:[DI],CL
 LES DI,Q
 CALL asmUpdateFlags
END;

Procedure S86RolByteDirect(Var Q:Session8086;Var Source:Byte;Rotation:Byte);Near;Assembler;ASM
 LES DI,Q
 CALL asmRestoreFlags
 MOV CL,Rotation
 LES DI,Source
 ROL Byte Ptr ES:[DI],CL
 LES DI,Q
 CALL asmUpdateFlags
END;

Procedure S86RolWordCL(Var Q:Session8086;Var Source:Word);Near;Assembler;ASM
 LES DI,Q
 CALL asmRestoreFlags
 MOV CL,ES:[DI].Session8086.Reg.&CL
 LES DI,Source
 ROL Word Ptr ES:[DI],CL
 LES DI,Q
 CALL asmUpdateFlags
END;

Procedure S86RorWordCL(Var Q:Session8086;Var Source:Word);Near;Assembler;ASM
 LES DI,Q
 CALL asmRestoreFlags
 MOV CL,ES:[DI].Session8086.Reg.&CL
 LES DI,Source
 SHR Word Ptr ES:[DI],CL
 LES DI,Q
 CALL asmUpdateFlags
END;

Procedure S86SalByteCL(Var Q:Session8086;Var Source:Byte);Near;Assembler;ASM
 LES DI,Q
 CALL asmRestoreFlags
 MOV CL,ES:[DI].Session8086.Reg.&CL
 LES DI,Source
 SAL Byte Ptr ES:[DI],CL
 LES DI,Q
 CALL asmUpdateFlags
END;

Procedure S86SarByteCL(Var Q:Session8086;Var Source:Byte);Near;Assembler;ASM
 LES DI,Q
 CALL asmRestoreFlags
 MOV CL,ES:[DI].Session8086.Reg.&CL
 LES DI,Source
 SAR Byte Ptr ES:[DI],CL
 LES DI,Q
 CALL asmUpdateFlags
END;

Procedure S86SalWordCL(Var Q:Session8086;Var Source:Word);Near;Assembler;ASM
 LES DI,Q
 CALL asmRestoreFlags
 MOV CL,ES:[DI].Session8086.Reg.&CL
 LES DI,Source
 SAL Word Ptr ES:[DI],CL
 LES DI,Q
 CALL asmUpdateFlags
END;

Procedure S86SarWordCL(Var Q:Session8086;Var Source:Word);Near;Assembler;ASM
 LES DI,Q
 CALL asmRestoreFlags
 MOV CL,ES:[DI].Session8086.Reg.&CL
 LES DI,Source
 SAR Word Ptr ES:[DI],CL
 LES DI,Q
 CALL asmUpdateFlags
END;

Procedure S86NegWord(Var Q:Session8086;Var Source:Word);Near;Assembler;ASM
 LES DI,Q
 CALL asmRestoreFlags
 LES DI,Source
 NEG Word Ptr ES:[DI]
 LES DI,Q
 CALL asmUpdateFlags
END;

Procedure S86NegByte(Var Q:Session8086;Var Source:Byte);Near;Assembler;ASM
 LES DI,Q
 CALL asmRestoreFlags
 LES DI,Source
 NEG Byte Ptr ES:[DI]
 LES DI,Q
 CALL asmUpdateFlags
END;

Procedure S86TestWord(Var Q:Session8086;Source,Dest:Word);Near;Assembler;ASM
 LES DI,Q
 CALL asmRestoreFlags
 MOV AX,Dest
 TEST Source,AX
 LES DI,Q
 CALL asmUpdateFlags
END;

Procedure S86TestByte(Var Q:Session8086;Source,Dest:Byte);Near;Assembler;ASM
 LES DI,Q
 CALL asmRestoreFlags
 MOV AL,Dest
 TEST Source,AL
 LES DI,Q
 CALL asmUpdateFlags
END;

Procedure BSWAP(Var Source:LongInt);Near;Assembler;ASM
 LES DI,Source
 MOV AX,ES:[DI+2]
 XCHG AL,AH
 XCHG ES:[DI],AX
 XCHG AL,AH
 MOV ES:[DI+2],AX
END;

Procedure S86CompareByte(Var Q:Session8086;DS,SI,ES,DI,CX:Word);
Var
 PtrSource,PtrDest:Pointer;
Begin
 PtrSource:=MemAlloc(CX);
 If(PtrSource<>NIL)Then Begin
  PtrDest:=MemAlloc(CX);
  If(PtrDest<>NIL)Then Begin
   If(DF)in(Q.Flags.s)Then Begin { Sens inverse? }
    ReadBlock(Q,DS,SI-CX,PtrSource^,CX);
    ReadBlock(Q,ES,DI-CX,PtrDest^,CX);
   End
    Else
   Begin
    ReadBlock(Q,DS,SI,PtrSource^,CX);
    ReadBlock(Q,ES,DI,PtrDest^,CX);
   End;
   ASM
    PUSH DS
     LES DI,Q
     CALL asmRestoreFlags
     LDS SI,PtrSource
     LES DI,PtrDest
     REP CMPSB
     LES DI,Q
     CALL asmUpdateFlags
    POP DS
   END;
   FreeMem(PtrDest,CX);
  End;
  FreeMem(PtrSource,CX);
 End;
End;

Procedure PushWordStack(Var Q:Session8086;Value:Word);Near;Begin
 Dec(Q.Reg.SP,SizeOf(Value));
 XSetAbsRec(Q.Memory,AddrExt2Conv(Ptr(Q.Seg.SS,Q.Reg.SP)),SizeOf(Value),Value);
End;

Procedure PushDWordStack(Var Q:Session8086;Value:LongInt);Near;Begin
 Dec(Q.Reg.SP,SizeOf(Value));
 XSetAbsRec(Q.Memory,AddrExt2Conv(Ptr(Q.Seg.SS,Q.Reg.SP)),SizeOf(Value),Value);
End;

Procedure S86IncCountString(Var Q:Session8086;Source,Dest:Bool);Near;Begin
 If(DF)in(Q.Flags.s)Then Begin
  If(Source)Then S86DecWord(Q,Q.Reg.SI);
  If(Dest)Then S86DecWord(Q,Q.Reg.DI);
 End
  Else
 Begin
  If(Source)Then S86IncWord(Q,Q.Reg.SI);
  If(Dest)Then S86IncWord(Q,Q.Reg.DI);
 End;
End;

Procedure S86AddCountString(Var Q:Session8086;Step:Byte;Source,Dest:Bool);Near;Begin
 If(DF)in(Q.Flags.s)Then Begin
  If(Source)Then S86SubWord(Q,Q.Reg.SI,Step);
  If(Dest)Then S86SubWord(Q,Q.Reg.DI,Step);
 End
  Else
 Begin
  If(Source)Then S86AddWord(Q,Q.Reg.SI,Step);
  If(Dest)Then S86AddWord(Q,Q.Reg.DI,Step);
 End;
End;

Procedure S86CallInt(Var Q:Session8086;Num:Byte);Near;
Label DefaultIntr;
Var
 Regs:Registers;
 L:LongInt;
 Tampon:Array[0..511]of Byte;
 TamponChr:Array[0..511]of Char Absolute Tampon;
 Ptr:Pointer;
 I:Word;
Begin
 XGetAbsRec(Q.Memory,Num shl 2,SizeOf(L),L);
 If(L=Num+1)Then Begin
  Case(Num)of
   $10:Begin { Emulation de l'interruption vidÇo }
    Case(Q.Reg.AH)of
     $02:Begin
      WESetPos(Q.AppW,Q.Reg.DL,Q.Reg.DH);
      WESetCurPos(Q.AppW,Q.Reg.DL,Q.Reg.DH);
     End;
     $03:ASM
       {Q.Reg.DL:=Q.W.X;Q.Reg.DH:=Q.W.Y;}
      LES DI,Q
      MOV AX,Word Ptr ES:[DI].Session8086.AppW.X
      MOV ES:[DI].Session8086.Reg.&DX,AX
     END;
     $06:Begin
      WEScrollDn(Q.AppW,Q.Reg.CL,Q.Reg.CH,Q.Reg.DL,Q.Reg.DH);
      WESetKr(Q.AppW,Q.Reg.BH);
      WEBarSpcHor(Q.AppW,Q.Reg.CL,Q.Reg.CH,Q.Reg.DL);
     End;
     $07:Begin
      WEScrollUp(Q.AppW,Q.Reg.CL,Q.Reg.CH,Q.Reg.DL,Q.Reg.DH);
      WESetKr(Q.AppW,Q.Reg.BH);
      WEBarSpcHor(Q.AppW,Q.Reg.CH,Q.Reg.CH,Q.Reg.DL);
     End;
     $08:Begin
      Q.Reg.AX:=GetCube(WEGetRX1(Q.AppW)+Q.AppW.X,WEGetRY1(Q.AppW)+Q.AppW.Y);
     End;
     $09:Begin
      WESetKr(Q.AppW,Q.Reg.BL);
      WEBarTxtHor(Q.AppW,Q.AppW.X,Q.AppW.Y,Q.AppW.X+Q.Reg.CX,Chr(Q.Reg.AL));
     End;
     $0A:Begin
      BarChrHor(WEGetRX1(Q.AppW)+Q.AppW.X,WEGetRY1(Q.AppW)+Q.AppW.Y,
                WEGetRX1(Q.AppW)+Q.AppW.X+Q.Reg.CX,Chr(Q.Reg.AL));
     End;
     $0C:Begin
      SetPixel((WEGetRX1(Q.AppW)shl 3)+Q.Reg.CX,
               GetRawY(WEGetRX1(Q.AppW))+Q.Reg.DX,Q.Reg.AL);
     End;
     $0D:Begin
      Q.Reg.AL:=GetPixel((WEGetRX1(Q.AppW)shl 3)+Q.Reg.CX,
                         GetRawY(WEGetRX1(Q.AppW))+Q.Reg.DX);
     End;
     $0E:Begin
      Case(Q.Reg.AL)of
       $0D:WELn(Q.AppW);
       $0A:;
       Else Begin
        WESetKr(Q.AppW,Q.Reg.BL);
        WEPutCube(Q.AppW,Chr(Q.Reg.AL));
       End;
      End;
     End;
     $0F:Begin
      Q.Reg.AL:=3;             { NumÇro de mode vidÇo }
      Q.Reg.AH:=Q.AppW.MaxX+1; { Nombre de colonne }
      Q.Reg.BH:=0;             { NumÇro de page courant }
     End;
     $1A:If Q.Reg.AL=0Then Begin
      Case(GetVideoCardCat)of
       cvnMDA,cvnHGC:Q.Reg.BL:=1;
       cvnCGA:Q.Reg.BL:=2;
       cvnEGA:If(ColorFound)Then Q.Reg.BL:=4
                            Else Q.Reg.BL:=5;
       cvnVGA,cvnSvga,cvnVESA:If(ColorFound)Then Q.Reg.BL:=8 Else Q.Reg.BL:=7;
      End;
      Q.Reg.BH:=0;
      Q.Reg.AL:=$1A;
     End;
    End;
   End;
   $13:Case(Q.Reg.AH)of { Emulation de l'interruption vidÇo }
    $02..$05,$07,$0A..$0B:Begin
     Regs.AH:=Q.Reg.AH;
     If(Q.Reg.AH)in[3,5,7,$B]Then ReadBlock(Q,Q.Seg.ES,Q.Reg.BX,Tampon,512);
     ASM
      LES DI,Q
      MOV AX,ES:[DI].Session8086.Reg.&AX
      MOV DX,ES:[DI].Session8086.Reg.&DX
      MOV CX,ES:[DI].Session8086.Reg.&CX
      PUSH SS
      POP ES
      MOV BX,Offset Tampon
      ADD BX,BP
      INT 13h
      LES DI,Q
      MOV ES:[DI].Session8086.Reg.&AH,AH
      CALL asmUpdateFlags
     END;
     If(Regs.AH)in[2,4,$A]Then WriteBlock(Q,Q.Seg.ES,Q.Reg.BX,Tampon,512);
    End;
    Else Goto DefaultIntr;
   End;
   $19:Q.Fault:=sfHotBoot;
   $18,$1B,$1C:;
   $1D..$1F:Q.Fault:=sfInvalidIntr;
   $20:Q.Fault:=sfEndProgram;
   $21:Case(Q.Reg.AH)of
    0:;
    1:Q.SubProcess:=sprqReadKeyDos;
    2:WEPutCube(Q.AppW,Chr(Q.Reg.DL));
    9:Begin
     ReadBlock(Q,Q.Seg.DS,Q.Reg.DX,Tampon,512);
     For I:=0to 511do Begin
      Case TamponChr[I]of
       '$':Break;
       #13:WELn(Q.AppW);
       #10:;
       Else WEPutCube(Q.AppW,TamponChr[I]);
      End;
     End;
    End;
    $25:Begin
     LongRec(L).Hi:=Q.Seg.DS;
     LongRec(L).Lo:=Q.Reg.DX;
     ReadBlock(Q,0,Q.Reg.AL shl 2,L,4);
    End;
    $30:Begin { Demande la version DOS }
     Q.Reg.AX:=Q.DOSVersion;
     Q.Reg.BH:=Q.OEMVersion;
    End;
    $33:Case(Q.Reg.AL)of
     5:Q.Reg.DX:=Q.UnitBoot;
     Else Goto DefaultIntr;
    End;
    $35:Begin
     ReadBlock(Q,0,Q.Reg.AL shl 2,L,4);
     Q.Seg.ES:=LongRec(L).Hi;
     Q.Reg.DI:=LongRec(L).Lo;
    End;
    $4C:Begin
     Q.Fault:=sfEndProgram;
    End;
    $50:Begin { DÇfinir PSP actif }
     Q.PSP:=Q.Reg.BX;
     Q.Reg.AX:=0;
     Exclude(Q.Flags.s,CF);
    End;
    Else Goto DefaultIntr;
   End;
   $33:Case(Q.Reg.AX)of
    1:__ShowMousePtr;
    2:__HideMousePtr;
    Else Goto DefaultIntr;
   End;
   Else Begin
DefaultIntr:
    GetIntVec(Num,Ptr);
    If(Ptr=NIL)Then Q.Fault:=sfInvalidIntr
     Else
    Begin
     Regs.AX:=Q.Reg.AX;
     Regs.BX:=Q.Reg.BX;
     Regs.CX:=Q.Reg.CX;
     Regs.DX:=Q.Reg.DX;
     Regs.BP:=Q.Reg.BP;
     Regs.SI:=Q.Reg.SI;
     Regs.DI:=Q.Reg.DI;
     Regs.ES:=Q.Seg.ES;
     Regs.DS:=Q.Seg.DS;
     Regs.Flags:=Q.Flags.Abs;
     Intr(Num,Regs);
     Q.Reg.AX:=Regs.AX;
     Q.Reg.BX:=Regs.BX;
     Q.Reg.CX:=Regs.CX;
     Q.Reg.DX:=Regs.DX;
     Q.Reg.BP:=Regs.BP;
     Q.Reg.SI:=Regs.SI;
     Q.Reg.DI:=Regs.DI;
     Q.Seg.ES:=Regs.ES;
     Q.Seg.DS:=Regs.DS;
     Q.Flags.Abs:=Regs.Flags;
    End;
   End;
  End;
 End
  Else
 Begin
  Include(Q.Flags.s,_IF);
  PushWordStack(Q,Q.Seg.CS);
  PushWordStack(Q,Q.IP);
  Q.Seg.CS:=LongRec(L).Hi;
  Q.IP:=LongRec(L).Lo;
 End;
End;

Function S86GetCode(Var Q:Session8086;Pos:Byte):Byte;Begin
 If((soOpCode2D)in(Q.Option))and(Q.srStep>1)Then
  S86GetCode:=Q.Buffer[(Q.IP and$F)+Pos*Q.srStep]
 Else
  S86GetCode:=Q.Buffer[(Q.IP and$F)+Pos];
End;

Procedure S86PutSourceLine(Var Q:Session8086);
Var
 O:Word;
 I:Integer;
 ByteHex,TStr:String;
 Address:String;
 Buffer:Array[Byte]of Byte;
Begin
 Inc(Q.NumInstr);
 XGetAbsRec(Q.Memory,AddrExt2Conv(Ptr(Q.Seg.CS,Q.IP)),SizeOf(Buffer),Buffer);
 O:=0;
 ByteHex:='';
 TStr:=Decode(Buffer,O);
 For I:=0to O-1do Begin
  AddStr(ByteHex,HexByte2Str(Buffer[I]));
  IncStr(ByteHex,' ');
 End;
 Address:=HexWord2Str(Q.Seg.CS)+'h:'+HexWord2Str(Q.IP)+'h';
 ByteHex:=StrUSpc(ByteHex,30);
 WEPutTxt(Q.W,Address+' '+ByteHex+TStr);
 WELn(Q.W);
 If((TStr<>'')and(Q.InstrBrk<>'')and(CmpLeft(TStr,Q.InstrBrk)))or
    ((Q.CodeBrk<>-1)and(Q.CodeBrk=Buffer[0]))Then Begin
  If(Q.AlreadBreak)Then Begin
   Q.AlreadBreak:=False;
   Q.Fault:=0;
  End
   Else
  Begin
   Q.AlreadBreak:=True;
   Q.Fault:=sfBreakPoint;
  End;
 End;
 PutFileTxtLn(Q.Log,Str2(Q.NumInstr,10)+' - '+Address+' '+ByteHex+TStr);
 If WEYIsOut(Q.W)Then Begin
  _WELL(Q.W);
  WEScrollDn(Q.W,0,Q.W.MaxY-5,wnMax,wnMax);
  WEClrEol(Q.W)
 End;
End;

Procedure S86BackOperation(Var Context);
Label Restart,InvalidOpCode;
Var
 Q:Session8086 Absolute Context;
 NC:Byte;
 TW:Word;        { Traitement temporaire 16 bits }
 TL:Long;        { Traåtement temporaire 32 bits }
 CurrSeg:Byte;   { Segment courant (CS: DS:,..)}

 Procedure IncCode(Num:Integer);Begin
  If((soOpCode2D)in(Q.Option))and(Q.srStep>1)Then
   Inc(Q.IP,Num*Q.srStep)
  Else
   Inc(Q.IP,Num);
 End;

 Function CurrCode:Byte;
 Var
  Addr,Seg:LongInt;
 Begin
  Addr:=AddrExt2Conv(Ptr(Q.Seg.CS,Q.IP));
  Seg:=Addr shr 4;
  If(Q.OldCSeg<>Seg)Then Begin
   XGetAbsRec(Q.Memory,Addr and$FFFFFFF0,SizeOf(Q.Buffer),Q.Buffer);
   Q.OldCSeg:=Seg;
  End;
  CurrCode:=Q.Buffer[Q.IP and$F];
 End;

 Procedure SetReg8bits(Num,Value:Byte);Begin
  Case(Num)and$7of
   0:Q.Reg.AL:=Value;
   1:Q.Reg.CL:=Value;
   2:Q.Reg.DL:=Value;
   3:Q.Reg.BL:=Value;
   4:Q.Reg.AH:=Value;
   5:Q.Reg.CH:=Value;
   6:Q.Reg.DH:=Value;
   7:Q.Reg.BH:=Value;
  End;
 End;

 Function GetReg8Bits(Num:Byte):Byte;Begin
  Case(Num)and$7of
   0:GetReg8Bits:=Q.Reg.AL;
   1:GetReg8Bits:=Q.Reg.CL;
   2:GetReg8Bits:=Q.Reg.DL;
   3:GetReg8Bits:=Q.Reg.BL;
   4:GetReg8Bits:=Q.Reg.AH;
   5:GetReg8Bits:=Q.Reg.CH;
   6:GetReg8Bits:=Q.Reg.DH;
   7:GetReg8Bits:=Q.Reg.BH;
  End;
 End;

 Function GetReg8BitsPtr(Num:Byte):Pointer;Begin
  Num:=Num and 7;
  GetReg8BitsPtr:=Ptr(Seg(Q.Reg),Ofs(Q.Reg)+((Num and 3)shl 2)+(Num shr 2));
{  GetReg8BitsPtr:=Ptr(Seg(Q.Reg),Ofs(Q.Reg)+((Num shr 1)shl 2)+(Num and 1));}
 End;

 Function GetCodeWord(Pos:Byte):Word;Begin
  GetCodeWord:=S86GetCode(Q,Pos)+(S86GetCode(Q,Pos+1)shl 8);
 End;

 Function GetCodeLong(Pos:Byte):LongInt;Begin
  GetCodeLong:=GetCodeWord(Pos)+(GetCodeWord(Pos+2)shl 16);
 End;

 Procedure CallNear(Ofs,Step:Word);Begin
  PushWordStack(Q,Q.IP+Step);
  Q.IP:=Ofs;
 End;

 Procedure CallFar(Ofs,Seg,Step:Word);Begin
  PushWordStack(Q,Q.Seg.CS);
  PushWordStack(Q,Q.IP+Step);
  Q.IP:=Ofs;Q.Seg.CS:=Seg;
 End;

 Function PopWordStack:Word;
 Var
  Value:Word;
 Begin
  XGetAbsRec(Q.Memory,AddrExt2Conv(Ptr(Q.Seg.SS,Q.Reg.SP)),SizeOf(Value),Value);
  Inc(Q.Reg.SP,SizeOf(Value));
  PopWordStack:=Value;
 End;

 Procedure PopWordFlags;Begin
  Word(Q.Flags.Abs):=PopWordStack;
   {Effacer les bits appropriÇ...}
 End;

 Procedure PushLongStack(Value:LongInt);Begin
  Dec(Q.Reg.SP,SizeOf(Value));
  XSetAbsRec(Q.Memory,AddrExt2Conv(Ptr(Q.Seg.SS,Q.Reg.SP)),SizeOf(Value),Value);
 End;

 Function PopLongStack:LongInt;
 Var
  Value:LongInt;
 Begin
  XGetAbsRec(Q.Memory,AddrExt2Conv(Ptr(Q.Seg.SS,Q.Reg.SP)),SizeOf(Value),Value);
  Inc(Q.Reg.SP,SizeOf(Value));
  PopLongStack:=Value;
 End;

 Function ReadWordOfs(Ofs:Word):LongInt;
 Var
  Seg:Word;
  Value,AbsAddr:Long;
 Begin
  Case(CurrSeg)of
   0..3:Seg:=Q.Seg.Abs[CurrSeg];
   4:Seg:=Q.FS;
   5:Seg:=Q.GS;
   Else Seg:=Q.Seg.DS;
  End;
  AbsAddr:=AddrExt2Conv(Ptr(Seg,Ofs));
  If(Q.FullScreen)and(AbsAddr shr 4=GetVideoSeg)Then ReadWordOfs:=Mem[Seg:Ofs]
   Else
  Begin
   XGetAbsRec(Q.Memory,AbsAddr,SizeOf(Value),Value);
   ReadWordOfs:=Value;
  End;
 End;

 Procedure WriteByteOfs(Value:Byte;Ofs:Word);
 Var
  Seg:Word;
  AbsAddr:LongInt;
 Begin
  Case(CurrSeg)of
   0..3:Seg:=Q.Seg.Abs[CurrSeg];
   4:Seg:=Q.FS;
   5:Seg:=Q.GS;
  End;
  AbsAddr:=AddrExt2Conv(Ptr(Seg,Ofs));
  If(Q.FullScreen)and(AbsAddr shr 4=GetVideoSeg)Then Mem[Seg:Ofs]:=Value
  Else XSetAbsRec(Q.Memory,AbsAddr,SizeOf(Value),Value);
 End;

 Procedure WriteWordOfs(Value:Word;Ofs:Word);
 Var
  Seg:Word;
 Begin
  Case(CurrSeg)of
   0..3:Seg:=Q.Seg.Abs[CurrSeg];
   4:Seg:=Q.FS;
   5:Seg:=Q.GS;
  End;
  XSetAbsRec(Q.Memory,AddrExt2Conv(Ptr(Q.Seg.SS,Ofs)),SizeOf(Value),Value);
 End;

 Procedure OutPortByte(Addr:Word;Value:Byte);Begin
  Port[Addr]:=Value;
 End;

 Procedure OutPortWord(Addr:Word;Value:Word);Begin
  OutPortByte(Addr,Lo(Value));
  OutPortByte(Addr+1,Hi(Value));
 End;

 Function InPortByte(Addr:Word):Byte;Begin
  If((soOpCode2D)in(Q.Option))and(Addr=$3D6)Then Begin
   InPortByte:=Byte((Q.AppW.MaxX+1=NmXTxts)and(Q.AppW.MaxY+1=NmYTxts))xor 1;
  End
   Else
  InPortByte:=Port[Addr];
 End;

 Function InPortWord(Addr:Word):Word;Begin
  InPortWord:=InPortByte(Addr)+(InPortByte(Addr+1)shl 8);
 End;

 { IsWord=2 = Double mot
          1 = mot
          0 = octet
 }

 Function ReadValue(HeadLen:Byte;IsWord:Byte):LongInt;
 Var
  Int:Integer;
  NextCode:Byte;
 Begin
  NextCode:=S86GetCode(Q,HeadLen);
  Case(NextCode)of
   $06,$0E,$16,$1E,$26,$2E,$36,$3E:Begin
    ReadValue:=ReadWordOfs(GetCodeWord(1+HeadLen));
    IncCode(3+HeadLen);
   End;
   $40..$7F:Begin
    Case(NextCode)and 7of
     0:Int:=Q.Reg.BX+Q.Reg.SI;
     1:Int:=Q.Reg.BX+Q.Reg.DI;
     2:Int:=Q.Reg.BP+Q.Reg.SI;
     3:Int:=Q.Reg.BP+Q.Reg.DI;
     4:Int:=Q.Reg.SI;
     5:Int:=Q.Reg.DI;
     6:Int:=Q.Reg.BP;
     7:Int:=Q.Reg.BX;
    End;
    ReadValue:=ReadWordOfs(Int+ShortInt(GetCodeWord(1+HeadLen)));
    IncCode(2+HeadLen);
   End;
   $80..$BF:Begin
    Case(NextCode)and 7of
     0:Int:=Q.Reg.BX+Q.Reg.SI;
     1:Int:=Q.Reg.BX+Q.Reg.DI;
     2:Int:=Q.Reg.BP+Q.Reg.SI;
     3:Int:=Q.Reg.BP+Q.Reg.DI;
     4:Int:=Q.Reg.SI;
     5:Int:=Q.Reg.DI;
     6:Int:=Q.Reg.BP;
     7:Int:=Q.Reg.BX;
    End;
    ReadValue:=ReadWordOfs(Int+Integer(GetCodeWord(1+HeadLen)));
    IncCode(3+HeadLen);
   End;
   $C0..$FF:Begin
    Case(IsWord)of
     2,1:ReadValue:=Q.Reg.Abs[NextCode and 7];
     Else ReadValue:=GetReg8Bits(NextCode);
    End;
    IncCode(1+HeadLen);
   End;
   Else Begin
    Case(NextCode)and 7of
     0:ReadValue:=ReadWordOfs(Q.Reg.BX+Q.Reg.SI);
     1:ReadValue:=ReadWordOfs(Q.Reg.BX+Q.Reg.DI);
     2:ReadValue:=ReadWordOfs(Q.Reg.BP+Q.Reg.SI);
     3:ReadValue:=ReadWordOfs(Q.Reg.BP+Q.Reg.DI);
     4:ReadValue:=ReadWordOfs(Q.Reg.SI);
     5:ReadValue:=ReadWordOfs(Q.Reg.DI);
     7:ReadValue:=ReadWordOfs(Q.Reg.BX);
    End;
    IncCode(1+HeadLen);
   End;
  End;
 End;

 Function ReadDWordValue(HeadLen:Byte):LongInt;Begin
  ReadDWordValue:=ReadValue(HeadLen,2);
 End;

 Function ReadWordValue(HeadLen:Byte):Word;Begin
  ReadWordValue:=ReadValue(HeadLen,1);
 End;

 Function ReadByteValue(HeadLen:Byte):Byte;Begin
  ReadByteValue:=ReadValue(HeadLen,0);
 End;

 Function EstimateSizeOpCodeAddr(HeadLen:Byte):Byte;Begin
  Case S86GetCode(Q,HeadLen)of
   $06,$0E,$16,$1E,$26,$2E,$36,$3E,$80..$BF:EstimateSizeOpCodeAddr:=3+HeadLen;
   $40..$7F:EstimateSizeOpCodeAddr:=2+HeadLen;
   Else EstimateSizeOpCodeAddr:=1+HeadLen
  End;
 End;

 Procedure WriteValue(Value:Word;HeadLen:Byte;IsWord:Boolean;Operand:Byte);
 Var
  Int:Integer;
  NextCode:Byte;
  Ofs:Word;
  IC:Byte;
  OldNextCode:Byte;
  OldValue:Word; { Anciennes valeurs pour les Çchanges }
 Begin
  NextCode:=S86GetCode(Q,HeadLen);
  OldNextCode:=NextCode;
  IC:=0;
  Case(NextCode)of
   $06,$0E,$16,$1E,$26,$2E,$36,$3E:Begin
    Ofs:=GetCodeWord(1+HeadLen);
    IC:=3+HeadLen;
   End;
   $40..$7F:Begin
    Case(NextCode)and 7of
     0:Int:=Q.Reg.BX+Q.Reg.SI;
     1:Int:=Q.Reg.BX+Q.Reg.DI;
     2:Int:=Q.Reg.BP+Q.Reg.SI;
     3:Int:=Q.Reg.BP+Q.Reg.DI;
     4:Int:=Q.Reg.SI;
     5:Int:=Q.Reg.DI;
     6:Int:=Q.Reg.BP;
     7:Int:=Q.Reg.BX;
    End;
    Ofs:=Int+ShortInt(GetCodeWord(1+HeadLen));
    IC:=2+HeadLen;
   End;
   $80..$BF:Begin
    Case(NextCode)and 7of
     0:Int:=Q.Reg.BX+Q.Reg.SI;
     1:Int:=Q.Reg.BX+Q.Reg.DI;
     2:Int:=Q.Reg.BP+Q.Reg.SI;
     3:Int:=Q.Reg.BP+Q.Reg.DI;
     4:Int:=Q.Reg.SI;
     5:Int:=Q.Reg.DI;
     6:Int:=Q.Reg.BP;
     7:Int:=Q.Reg.BX;
    End;
    Ofs:=Int+Integer(GetCodeWord(1+HeadLen));
    IC:=3+HeadLen;
   End;
   $C0..$FF:Begin
    OldNextCode:=(NextCode-$C0)shr 3;
    NextCode:=NextCode and 7;
    Case(Operand)of
     opAdc:If(IsWord)Then S86AdcWord(Q,Word(Q.Reg.Abs[NextCode]),Value)
                     Else S86AdcByte(Q,Byte(GetReg8BitsPtr(NextCode)^),Value);
     opAdd:If(IsWord)Then S86AddWord(Q,Word(Q.Reg.Abs[NextCode]),Value)
                     Else S86AddByte(Q,Byte(GetReg8BitsPtr(NextCode)^),Value);
     opAnd:If(IsWord)Then S86AndWord(Q,Word(Q.Reg.Abs[NextCode]),Value)
                     Else S86AndByte(Q,Byte(GetReg8BitsPtr(NextCode)^),Value);
     opCmp:If(IsWord)Then S86CmpWord(Q,Word(Q.Reg.Abs[NextCode]),Value)
                     Else S86CmpByte(Q,Byte(GetReg8BitsPtr(NextCode)^),Value);
     opDec:If(IsWord)Then S86DecWord(Q,Word(Q.Reg.Abs[NextCode]))
                     Else S86DecByte(Q,Byte(GetReg8BitsPtr(NextCode)^));
     opDiv:If(IsWord)Then S86DivWord(Q,Word(Q.Reg.Abs[NextCode]))
                     Else S86DivByte(Q,Byte(GetReg8BitsPtr(NextCode)^));
     opInc:If(IsWord)Then S86IncWord(Q,Word(Q.Reg.Abs[NextCode]))
                     Else S86IncByte(Q,Byte(GetReg8BitsPtr(NextCode)^));
     opMul:If(IsWord)Then S86MulWord(Q,Word(Q.Reg.Abs[NextCode]))
                     Else S86MulByte(Q,Byte(GetReg8BitsPtr(NextCode)^));
     opOr: If(IsWord)Then S86OrWord(Q,Word(Q.Reg.Abs[NextCode]),Value)
                     Else S86OrByte(Q,Byte(GetReg8BitsPtr(NextCode)^),Value);
     opSub:If(IsWord)Then S86SubWord(Q,Word(Q.Reg.Abs[NextCode]),Value)
                     Else S86SubByte(Q,Byte(GetReg8BitsPtr(NextCode)^),Value);
     opSbb:If(IsWord)Then S86SbbWord(Q,Word(Q.Reg.Abs[NextCode]),Value)
                     Else S86SbbByte(Q,Byte(GetReg8BitsPtr(NextCode)^),Value);
     opXor:If(IsWord)Then S86XorWord(Q,Word(Q.Reg.Abs[NextCode]),Value)
                     Else S86XorByte(Q,Byte(GetReg8BitsPtr(NextCode)^),Value);
     opXChg:Begin
      If(IsWord)Then Word(Q.Reg.Abs[NextCode]):=Value
       Else
      Begin
       OldValue:=GetReg8Bits(NextCode);
       SetReg8Bits(NextCode,GetReg8Bits(OldNextCode));
       SetReg8Bits(OldNextCode,OldValue);
      End;
     End;
     Else If(IsWord)Then Word(Q.Reg.Abs[NextCode]):=Value
                    Else SetReg8Bits(NextCode,Value);
    End;
    IncCode(1+HeadLen);
    Exit;
   End;
   Else Begin
    Case(NextCode)and 7of
     0:Int:=Q.Reg.BX+Q.Reg.SI;
     1:Int:=Q.Reg.BX+Q.Reg.DI;
     2:Int:=Q.Reg.BP+Q.Reg.SI;
     3:Int:=Q.Reg.BP+Q.Reg.DI;
     4:Int:=Q.Reg.SI;
     5:Int:=Q.Reg.DI;
     7:Int:=Q.Reg.BX;
    End;
    Ofs:=Int;
    IC:=1+HeadLen;
   End;
  End;
  Case(Operand)of
   opAdc:If(IsWord)Then Value:=S86AdcWordF(Q,ReadWordOfs(Ofs),Value)
                   Else Value:=S86AdcByteF(Q,ReadWordOfs(Ofs),Value);
   opAdd:If(IsWord)Then Value:=S86AddWordF(Q,ReadWordOfs(Ofs),Value)
                   Else Value:=S86AddByteF(Q,ReadWordOfs(Ofs),Value);
   opAnd:If(IsWord)Then Value:=S86AndWordF(Q,ReadWordOfs(Ofs),Value)
                   Else Value:=S86AndByteF(Q,ReadWordOfs(Ofs),Value);
   opCmp:If(IsWord)Then Value:=S86CmpWordF(Q,ReadWordOfs(Ofs),Value)
                   Else Value:=S86CmpByteF(Q,ReadWordOfs(Ofs),Value);
   opDec:If(IsWord)Then Value:=S86DecWordF(Q,ReadWordOfs(Ofs))
                   Else Value:=S86DecByteF(Q,ReadWordOfs(Ofs));
   opDiv:If(IsWord)Then S86DivWord(Q,ReadWordOfs(Ofs))
                   Else S86DivByte(Q,ReadWordOfs(Ofs));
   opInc:If(IsWord)Then Value:=S86IncWordF(Q,ReadWordOfs(Ofs))
                   Else Value:=S86IncByteF(Q,ReadWordOfs(Ofs));
   opMul:If(IsWord)Then S86MulWord(Q,ReadWordOfs(Ofs))
                   Else S86MulByte(Q,ReadWordOfs(Ofs));
   opOr: If(IsWord)Then Value:=S86OrWordF(Q,ReadWordOfs(Ofs),Value)
                   Else Value:=S86OrByteF(Q,ReadWordOfs(Ofs),Value);
   opSub:If(IsWord)Then Value:=S86SubWordF(Q,ReadWordOfs(Ofs),Value)
                   Else Value:=S86SubByteF(Q,ReadWordOfs(Ofs),Value);
   opSbb:If(IsWord)Then Value:=S86SbbWordF(Q,ReadWordOfs(Ofs),Value)
                   Else Value:=S86SbbByteF(Q,ReadWordOfs(Ofs),Value);
   opXor:If(IsWord)Then Value:=S86XorWordF(Q,ReadWordOfs(Ofs),Value)
                   Else Value:=S86XorByteF(Q,ReadWordOfs(Ofs),Value);
   opXChg:Begin
   End;
  End;
  If Not(Operand In[opDiv,opMul])Then Begin
   If(IsWord)Then WriteWordOfs(Value,Ofs)
             Else WriteByteOfs(Value,Ofs);
  End;
  IncCode(IC);
 End;

 Procedure WriteWordValue(Value:Word;HeadLen:Byte);Begin
  WriteValue(Value,HeadLen,True,opMov);
 End;

 Procedure WriteByteValue(Value:Byte;HeadLen:Byte);Begin
  WriteValue(Value,HeadLen,False,opMov);
 End;

 Procedure NearJmp(Jmp:Boolean;Size:Byte);Begin
  If(Jmp)Then Begin
{   Q.IP:=$FFFD-Q.IP+GetCodeWord(Size-2)}
   Q.IP:=Q.IP+GetCodeWord(Size-2)+Size;
  End
   Else
  IncCode(Size);
 End;

 Procedure ShortJmp(Jmp:Boolean;Size:Byte);Begin
  If(Jmp)Then Begin
   IncCode(Size+ShortInt(S86GetCode(Q,1)))
  End
   Else
  IncCode(Size);
 End;

 Function LoadAddr(Size:Byte):Word;Begin
  NC:=(S86GetCode(Q,Size)and$3F)shr 3;
  TL:=ReadDWordValue(Size);
  Word(Q.Reg.Abs[NC]):=Word(TL);
  LoadAddr:=LongRec(TL).Hi;
 End;

Begin
 CurrSeg:=$FF;
 If(Q.Sourcer)Then Begin
  S86PutSourceLine(Q);
  If(Q.Fault=sfBreakPoint)Then Exit;
 End;
Restart:
 Case(CurrCode)of
  $00:Begin { ADD registre 8 bits,registre 8 bits}
   WriteValue(GetReg8Bits((S86GetCode(Q,1)and$3F)shr 3),1,False,opAdd);
  End;
  $01:Begin { ADD registre 16 bits,registre 16 bits}
   WriteValue(Q.Reg.Abs[(S86GetCode(Q,1)and$3F)shr 3],1,True,opAdd);
  End;
  $02:Begin { ADD registre 8 bits,registre 8 bits}
   NC:=(S86GetCode(Q,1)and$3F)shr 3;
   S86AddByte(Q,Byte(GetReg8BitsPtr(NC)^),ReadByteValue(1));
  End;
  $03:Begin { ADD registre 16 bits,registre 16 bits}
   NC:=(S86GetCode(Q,1)and$3F)shr 3;
   S86AddWord(Q,Word(Q.Reg.Abs[NC]),ReadWordValue(1));
  End;
  $04:If(Q.CPU>=cpu80286)Then Begin { ADD AL,xxh }
   S86AddByte(Q,Q.Reg.AL,S86GetCode(Q,1));
   IncCode(2);
  End
   Else
  Goto InvalidOpCode;
  $05:If(Q.CPU>=cpu80286)Then Begin { ADD AX,xxyyh }
   S86AddWord(Q,Q.Reg.AX,GetCodeWord(1));
   IncCode(3);
  End
   Else
  Goto InvalidOpCode;
  $06:Begin { PUSH ES }
   PushWordStack(Q,Q.Seg.ES);
   IncCode(1);
  End;
  $07:Begin { POP ES }
   Q.Seg.ES:=PopWordStack;
   IncCode(1);
  End;
  $08:Begin { OR registre 8 bits,registre 8 bits}
   WriteValue(GetReg8Bits((S86GetCode(Q,1)and$3F)shr 3),1,No,opOr);
  End;
  $09:Begin { OR registre 16 bits,registre 16 bits}
   WriteValue(Q.Reg.Abs[(S86GetCode(Q,1)and$3F)shr 3],1,Ya,opOr);
  End;
  $0A:Begin { OR registre 8 bits,registre 8 bits}
   NC:=(S86GetCode(Q,1)and$3F)shr 3;
   S86OrByte(Q,Byte(GetReg8BitsPtr(NC)^),ReadByteValue(1));
  End;
  $0B:Begin { OR registre 16 bits,registre 16 bits}
   NC:=(S86GetCode(Q,1)and$3F)shr 3;
   S86OrWord(Q,Word(Q.Reg.Abs[NC]),ReadWordValue(1));
  End;
  $0C:If(Q.CPU>=cpu80286)Then Begin { OR AL,xxh }
   S86OrByte(Q,Q.Reg.AL,S86GetCode(Q,1));
   IncCode(2);
  End
   Else
  Goto InvalidOpCode;
  $0D:If(Q.CPU>=cpu80286)Then Begin { OR AX,xxyyh }
   S86OrWord(Q,Q.Reg.AX,GetCodeWord(1));
   IncCode(3);
  End
   Else
  Goto InvalidOpCode;
  $0E:Begin { PUSH CS }
   PushWordStack(Q,Q.Seg.CS);
   IncCode(1);
  End;
  $0F:Case S86GetCode(Q,1)of
   $06:If(Q.CPU>=cpu80286)Then Begin { CLTS }
    Exclude(Q.Control.s,TS);
    IncCode(2);
   End
    Else
   Goto InvalidOpCode;
   $80:If(Q.CPU>=cpui386)Then NearJmp((_OF)in(Q.Flags.s),4) { JO near }
                         Else Goto InvalidOpCode;
   $81:If(Q.CPU>=cpui386)Then NearJmp(Not((_OF)in(Q.Flags.s)),4) { JNO near }
                         Else Goto InvalidOpCode;
   $82:If(Q.CPU>=cpui386)Then NearJmp((CF)in(Q.Flags.s),4) { JC near }
                         Else Goto InvalidOpCode;
   $83:If(Q.CPU>=cpui386)Then NearJmp(Not((CF)in(Q.Flags.s)),4) { JNC near }
                         Else Goto InvalidOpCode;
   $84:If(Q.CPU>=cpui386)Then NearJmp((ZF)in(Q.Flags.s),4) { JZ near }
                         Else Goto InvalidOpCode;
   $85:If(Q.CPU>=cpui386)Then NearJmp(Not((ZF)in(Q.Flags.s)),4) { JNZ near }
                         Else Goto InvalidOpCode;
   $86:If(Q.CPU>=cpui386)Then NearJmp(Not((AF)in(Q.Flags.s)),4) { JNA near }
                         Else Goto InvalidOpCode;
   $87:If(Q.CPU>=cpui386)Then NearJmp((AF)in(Q.Flags.s),4) { JA near }
                         Else Goto InvalidOpCode;
   $88:If(Q.CPU>=cpui386)Then NearJmp((SF)in(Q.Flags.s),4) { JS near }
                         Else Goto InvalidOpCode;
   $89:If(Q.CPU>=cpui386)Then NearJmp(Not((SF)in(Q.Flags.s)),4) { JNS near }
                         Else Goto InvalidOpCode;
   $8A:If(Q.CPU>=cpui386)Then NearJmp((PF)in(Q.Flags.s),4) { JP near }
                         Else Goto InvalidOpCode;
   $8B:If(Q.CPU>=cpui386)Then NearJmp(Not((PF)in(Q.Flags.s)),4) { JNP near }
                         Else Goto InvalidOpCode;
   $8C:If(Q.CPU>=cpui386)Then NearJmp(((SF)in(Q.Flags.s))<>((_OF)in(Q.Flags.s)),4) { JL near }
                         Else Goto InvalidOpCode;
   $8D:If(Q.CPU>=cpui386)Then NearJmp(((SF)in(Q.Flags.s))=((_OF)in(Q.Flags.s)),4) { JNL near }
                         Else Goto InvalidOpCode;
   $8E:If(Q.CPU>=cpui386)Then NearJmp((((SF)in(Q.Flags.s))<>((_OF)in(Q.Flags.s)))or((ZF)in(Q.Flags.s)),4) { JLE near }
                         Else Goto InvalidOpCode;
   $8F:If(Q.CPU>=cpui386)Then NearJmp((((SF)in(Q.Flags.s))=((_OF)in(Q.Flags.s)))or(Not((ZF)in(Q.Flags.s))),4) { JNLE near }
                         Else Goto InvalidOpCode;
   $A0:If(Q.CPU>=cpui386)Then Begin { PUSH FS }
    PushWordStack(Q,Q.FS);
    IncCode(2);
   End
    Else
   Goto InvalidOpCode;
   $A1:If(Q.CPU>=cpui386)Then Begin { POP FS }
    Q.FS:=PopWordStack;
    IncCode(2);
   End
    Else
   Goto InvalidOpCode;
   $A2:If(soCPUID)in(Q.Option)Then Begin { CPUID }
    Case(Q.Reg.EAX)of
     0:Case(Q.CPUVendor)of
      cvCyrix:Begin{EAX ECX EDX EBX}
       Q.Reg.Chr:='????teadxInsCyri';
      End;
      cvAmd:Begin {EAX ECX EDX EBX }
       Q.Reg.Chr:='????cAMDentiAuth';
      End;
      Else Begin  {EAX ECX EDX EBX }
       Q.Reg.Chr:='????ntelineIGenu';
      End;
     End;
     1:Begin
      Q.Reg.EAX:=0; { DonnÇe divers Ö complÇter...}
      Q.Reg.EBX:=0;
      Q.Reg.ECX:=0;
     End;
    End;
    IncCode(2);
   End
    Else
   Goto InvalidOpCode;
   $A8:If(Q.CPU>=cpui386)Then Begin { PUSH GS }
    PushWordStack(Q,Q.GS);
    IncCode(2);
   End
    Else
   Goto InvalidOpCode;
   $A9:If(Q.CPU>=cpui386)Then Begin { POP GS }
    Q.GS:=PopWordStack;
    IncCode(2);
   End
    Else
   Goto InvalidOpCode;
   $B2:If(Q.CPU>=cpui386)Then Q.Seg.SS:=LoadAddr(2) { LSS }
                         Else Goto InvalidOpCode;
   $B4:If(Q.CPU>=cpui386)Then Q.FS:=LoadAddr(2) { LFS }
                         Else Goto InvalidOpCode;
   $B5:If(Q.CPU>=cpui386)Then Q.GS:=LoadAddr(2) { LGS }
                         Else Goto InvalidOpCode;
   $C8..$CF:If(Q.CPU>=cpui486)Then Begin { BSWAP }
    BSwap(Q.Reg.Abs[S86GetCode(Q,1)and 7]);
    IncCode(2);
   End
    Else
   Goto InvalidOpCode;
   Else Goto InvalidOpCode;
  End;
  $10:Begin { ADC registre 8 bits,registre 8 bits}
   WriteValue(GetReg8Bits((S86GetCode(Q,1)and$3F)shr 3),1,No,opADC);
  End;
  $11:Begin { ADC registre 16 bits,registre 16 bits}
   WriteValue(Q.Reg.Abs[(S86GetCode(Q,1)and$3F)shr 3],1,Ya,opADC);
  End;
  $12:Begin { ADC registre 8 bits,registre 8 bits}
   NC:=(S86GetCode(Q,1)and$3F)shr 3;
   S86AdcByte(Q,Byte(GetReg8BitsPtr(NC)^),ReadByteValue(1));
  End;
  $13:Begin { ADC registre 16 bits,registre 16 bits}
   NC:=(S86GetCode(Q,1)and$3F)shr 3;
   S86AdcWord(Q,Word(Q.Reg.Abs[NC]),ReadWordValue(1));
  End;
  $14:If(Q.CPU>=cpu80286)Then Begin { ADC AL,xxh }
   S86AdcByte(Q,Q.Reg.AL,S86GetCode(Q,1));
   IncCode(2);
  End
   Else
  Goto InvalidOpCode;
  $15:If(Q.CPU>=cpu80286)Then Begin { ADC AX,xxyyh }
   S86AdcWord(Q,Q.Reg.AX,GetCodeWord(1));
   IncCode(3);
  End
   Else
  Goto InvalidOpCode;
  $16:Begin { PUSH SS }
   PushWordStack(Q,Q.Seg.SS);
   IncCode(1);
  End;
  $17:Begin { POP SS }
   Q.Seg.SS:=PopWordStack;
   IncCode(1);
  End;
  $18:Begin { SBB registre 8 bits,registre 8 bits}
   WriteValue(GetReg8Bits((S86GetCode(Q,1)and$3F)shr 3),1,No,opSBB);
  End;
  $19:Begin { SBB registre 16 bits,registre 16 bits}
   WriteValue(Q.Reg.Abs[(S86GetCode(Q,1)and$3F)shr 3],1,Ya,opSBB);
  End;
  $1A:Begin { SBB registre 8 bits,registre 8 bits}
   NC:=(S86GetCode(Q,1)and$3F)shr 3;
   S86SbbByte(Q,Byte(GetReg8BitsPtr(NC)^),ReadByteValue(1));
  End;
  $1B:Begin { SBB registre 16 bits,registre 16 bits}
   NC:=(S86GetCode(Q,1)and$3F)shr 3;
   S86SbbWord(Q,Word(Q.Reg.Abs[NC]),ReadWordValue(1));
  End;
  $1C:If(Q.CPU>=cpu80286)Then Begin { SBB AL,xxh }
   S86SbbByte(Q,Q.Reg.AL,S86GetCode(Q,1));
   IncCode(2);
  End
   Else
  Goto InvalidOpCode;
  $1D:If(Q.CPU>=cpu80286)Then Begin { SBB AX,xxyyh }
   S86SbbWord(Q,Q.Reg.AX,GetCodeWord(1));
   IncCode(3);
  End
   Else
  Goto InvalidOpCode;
  $1E:Begin { PUSH DS }
   PushWordStack(Q,Q.Seg.DS);
   IncCode(1);
  End;
  $1F:Begin { POP DS }
   Q.Seg.DS:=PopWordStack;
   IncCode(1);
  End;
  $20:Begin { AND registre 8 bits,registre 8 bits}
   WriteValue(GetReg8Bits((S86GetCode(Q,1)and$3F)shr 3),1,No,opAnd);
  End;
  $21:Begin { AND registre 16 bits,registre 16 bits}
   WriteValue(Q.Reg.Abs[(S86GetCode(Q,1)and$3F)shr 3],1,Ya,opAnd);
  End;
  $22:Begin { AND registre 8 bits,registre 8 bits}
   NC:=(S86GetCode(Q,1)and$3F)shr 3;
   S86AndByte(Q,Byte(GetReg8BitsPtr(NC)^),ReadByteValue(1));
  End;
  $23:Begin { AND registre 16 bits,registre 16 bits}
   NC:=(S86GetCode(Q,1)and$3F)shr 3;
   S86AndWord(Q,Word(Q.Reg.Abs[NC]),ReadWordValue(1));
  End;
  $24:If(Q.CPU>=cpu80286)Then Begin { AND AL,xxh }
   S86AndByte(Q,Q.Reg.AL,S86GetCode(Q,1));
   IncCode(2);
  End
   Else
  Goto InvalidOpCode;
  $25:If(Q.CPU>=cpu80286)Then Begin { AND AX,xxyyh }
   S86AndWord(Q,Q.Reg.AX,GetCodeWord(1));
   IncCode(3);
  End
   Else
  Goto InvalidOpCode;
  $26:Begin { ES: }
   If CurrSeg<>$FFThen Exit;
   CurrSeg:=0;
   IncCode(1);
   Goto Restart;
  End;
  $27:Begin { DAA }
   S86DAA(Q);
   IncCode(1);
  End;
  $28:Begin { SUB registre 8 bits,registre 8 bits}
   WriteValue(GetReg8Bits((S86GetCode(Q,1)and$3F)shr 3),1,No,opSub);
  End;
  $29:Begin { SUB registre 16 bits,registre 16 bits}
   WriteValue(Q.Reg.Abs[(S86GetCode(Q,1)and$3F)shr 3],1,Ya,opSub);
  End;
  $2A:Begin { SUB registre 8 bits,registre 8 bits}
   NC:=(S86GetCode(Q,1)and$3F)shr 3;
   S86SubByte(Q,Byte(GetReg8BitsPtr(NC)^),ReadByteValue(1));
  End;
  $2B:Begin { SUB registre 16 bits,registre 16 bits}
   NC:=(S86GetCode(Q,1)and$3F)shr 3;
   S86SubWord(Q,Word(Q.Reg.Abs[NC]),ReadWordValue(1));
  End;
  $2C:If(Q.CPU>=cpu80286)Then Begin { SUB AL,xxh }
   S86SubByte(Q,Q.Reg.AL,S86GetCode(Q,1));
   IncCode(2);
  End
   Else
  Goto InvalidOpCode;
  $2D:If(Q.CPU>=cpu80286)Then Begin { SUB AX,xxyyh }
   S86SubWord(Q,Q.Reg.AX,GetCodeWord(1));
   IncCode(3);
  End
   Else
  Goto InvalidOpCode;
  $2E:Begin { CS: }
   If CurrSeg<>$FFThen Exit;
   CurrSeg:=1;
   IncCode(1);
   Goto Restart;
  End;
  $2F:Begin { DAS }
   S86DAS(Q);
   IncCode(1);
  End;
  $30:Begin { XOR registre 8 bits, registre 8 bits }
   WriteValue(GetReg8Bits((S86GetCode(Q,1)and$3F)shr 3),1,No,opXor);
  End;
  $31:Begin { XOR registre 16 bits,registre 16 bits}
   WriteValue(Q.Reg.Abs[(S86GetCode(Q,1)and$3F)shr 3],1,Ya,opXor);
  End;
  $32:Begin { XOR registre 8 bits,registre 8 bits}
   NC:=(S86GetCode(Q,1)and$3F)shr 3;
   S86XorByte(Q,Byte(GetReg8BitsPtr(NC)^),ReadByteValue(1));
  End;
  $33:Begin { XOR registre 16 bits,registre 16 bits}
   NC:=(S86GetCode(Q,1)and$3F)shr 3;
   S86XorWord(Q,Word(Q.Reg.Abs[NC]),ReadWordValue(1));
  End;
  $34:If(Q.CPU>=cpu80286)Then Begin { XOR AL,xxh }
   S86XorByte(Q,Q.Reg.AL,S86GetCode(Q,1));
   IncCode(2);
  End
   Else
  Goto InvalidOpCode;
  $35:If(Q.CPU>=cpu80286)Then Begin { XOR AX,xxyyh }
   S86XorWord(Q,Q.Reg.AX,GetCodeWord(1));
   IncCode(3);
  End
   Else
  Goto InvalidOpCode;
  $36:Begin { SS: }
   If CurrSeg<>$FFThen Exit;
   CurrSeg:=2;
   IncCode(1);
   Goto Restart;
  End;
  $37:Begin { AAA }
   S86AAA(Q);
   IncCode(1);
  End;
  $38:Begin { CMP registre 8 bits, registre 8 bits }
   WriteValue(GetReg8Bits((S86GetCode(Q,1)and$3F)shr 3),1,False,opCmp);
  End;
  $39:Begin { CMP registre 16 bits,registre 16 bits}
   WriteValue(Q.Reg.Abs[(S86GetCode(Q,1)and$3F)shr 3],1,Ya,opCmp);
  End;
  $3A:Begin { CMP registre 8 bits,registre 8 bits}
   NC:=(S86GetCode(Q,1)and$3F)shr 3;
   S86CmpByte(Q,Byte(GetReg8BitsPtr(NC)^),ReadByteValue(1));
  End;
  $3B:Begin { CMP registre 16 bits,registre 16 bits}
   NC:=(S86GetCode(Q,1)and$3F)shr 3;
   S86CmpWord(Q,Word(Q.Reg.Abs[NC]),ReadWordValue(1));
  End;
  $3C:If(Q.CPU>=cpu80286)Then Begin { CMP AL,xxh }
   S86CmpByte(Q,Q.Reg.AL,S86GetCode(Q,1));
   IncCode(2);
  End
   Else
  Goto InvalidOpCode;
  $3D:If(Q.CPU>=cpu80286)Then Begin { CMP AX,xxyyh }
   S86CmpWord(Q,Q.Reg.AX,GetCodeWord(1));
   IncCode(3);
  End
   Else
  Goto InvalidOpCode;
  $3E:Begin { DS: }
   If CurrSeg<>$FFThen Exit;
   CurrSeg:=3;
   IncCode(1);
   Goto Restart;
  End;
  $3F:Begin { AAS }
   S86AAS(Q);
   IncCode(1);
  End;
  $40..$47:Begin { INC registre 16 bits }
   S86IncWord(Q,Word(Q.Reg.Abs[CurrCode and 7]));
   IncCode(1);
  End;
  $48..$4F:Begin { DEC registre 16 bits }
   S86DecWord(Q,Word(Q.Reg.Abs[CurrCode and 7]));
   IncCode(1);
  End;
  $50..$57:Begin { PUSH registre 16 bits }
   PushWordStack(Q,Q.Reg.Abs[CurrCode and 7]);
   IncCode(1);
  End;
  $58..$5F:Begin { POP registre 16 bits }
   Word(Q.Reg.Abs[CurrCode and 7]):=PopWordStack;
   IncCode(1);
  End;
  $60:If(Q.CPU>=cpu80286)Then Begin { PUSHA }
   TW:=Q.Reg.SP;
   PushWordStack(Q,Q.Reg.DI);
   PushWordStack(Q,Q.Reg.SI);
   PushWordStack(Q,Q.Reg.BP);
   PushWordStack(Q,TW);
   PushWordStack(Q,Q.Reg.BX);
   PushWordStack(Q,Q.Reg.DX);
   PushWordStack(Q,Q.Reg.CX);
   PushWordStack(Q,Q.Reg.AX);
   IncCode(1);
  End
   Else
  Goto InvalidOpCode;
  $61:If(Q.CPU>=cpu80286)Then Begin { POPA }
   Q.Reg.AX:=PopWordStack;
   Q.Reg.CX:=PopWordStack;
   Q.Reg.DX:=PopWordStack;
   Q.Reg.BX:=PopWordStack;
   {Q.Reg.SP}TW:=PopWordStack;
   Q.Reg.BP:=PopWordStack;
   Q.Reg.SI:=PopWordStack;
   Q.Reg.DI:=PopWordStack;
   IncCode(1);
  End
   Else
  Goto InvalidOpCode;
  $64:If(Q.CPU>=cpui386)Then Begin { FS: }
   If CurrSeg<>$FFThen Exit;
   CurrSeg:=4;
   IncCode(1);
   Goto Restart;
  End
   Else
  Goto InvalidOpCode;
  $65:If(Q.CPU>=cpui386)Then Begin { GS: }
   If CurrSeg<>$FFThen Exit;
   CurrSeg:=5;
   IncCode(1);
   Goto Restart;
  End
   Else
  Goto InvalidOpCode;
  $66:If(Q.CPU>=cpui386)Then Case S86GetCode(Q,1)of
   $50..$57:Begin { PUSH registre 32 bits }
    PushLongStack(Q.Reg.Abs[CurrCode and 7]);
    IncCode(2);
   End;
   $58..$5F:Begin { POP registre 32 bits }
    Q.Reg.Abs[CurrCode and 7]:=PopLongStack;
    IncCode(2);
   End;
   $6A:Begin { PUSH DWord (Byte) }
    NC:=S86GetCode(Q,2);
    If NC>=$80Then TL:=$FFFFFF00
              Else TL:=0;
    ASM
     MOV AL,NC
     MOV Byte Ptr TL,AL
    END;
    PushLongStack(TL);
    IncCode(3);
   End;
   $9C:Begin { PUSHFD }
    PushLongStack(Q.Flags.Abs);
    IncCode(3);
   End;
   $A5:Begin { MOVSD }
    S86MoveLeft(Q,Q.Seg.DS,Q.Reg.SI,Q.Seg.ES,Q.Reg.DI,4);
    S86AddCountString(Q,4,Ya,Ya);
   End;
   $AB:Begin { STOSD }
    WriteBlock(Q,Q.Seg.ES,Q.Reg.DI,Q.Reg.AX,SizeOf(Long));
    S86AddCountString(Q,4,No,Ya);
    IncCode(2);
   End;
   $B8..$BF:Begin { MOV registre 32 bits,xxxxyyyyh }
    Q.Reg.Abs[CurrCode and 7]:=GetCodeLong(2);
    IncCode(6);
   End;
   $E3:Begin { JECXZ }
    If Q.Reg.ECX=0Then IncCode(3+ShortInt(S86GetCode(Q,1)))
                  Else IncCode(3);
   End;
   Else Goto InvalidOpcode;
  End
   Else
  Goto InvalidOpCode;
  $67:If(soLibMalte)in(Q.Option)Then IncCode(1+LibMalte(Q,GetCodeWord(1)))
                                Else Goto InvalidOpCode;
  $68:If(Q.CPU>=cpu80286)Then Begin { PUSH nombre immÇdiat 16 bits }
   PushWordStack(Q,GetCodeWord(1));
   IncCode(3);
  End
   Else
  Goto InvalidOpCode;
  $6A:If(Q.CPU>=cpu80286)Then Begin { PUSH nombre immÇdiat 8 bits en 16 bits}
   NC:=S86GetCode(Q,1);
   If NC>=$80Then PushWordStack(Q,$FF00+NC)
             Else PushWordStack(Q,NC);
   IncCode(2);
  End
   Else
  Goto InvalidOpCode;
  $70:ShortJmp((_OF)in(Q.Flags.s),2); { JO short }
  $71:ShortJmp(Not((_OF)in(Q.Flags.s)),2); { JNO short }
  $72:ShortJmp((CF)in(Q.Flags.s),2); { JC short }
  $73:ShortJmp(Not((CF)in(Q.Flags.s)),2); { JNC short }
  $74:ShortJmp((ZF)in(Q.Flags.s),2); { JZ short }
  $75:ShortJmp(Not((ZF)in(Q.Flags.s)),2); { JNZ short }
  $76:ShortJmp((AF)in(Q.Flags.s),2); { JA short }
  $77:ShortJmp(Not((AF)in(Q.Flags.s)),2); { JNA short }
  $78:ShortJmp((SF)in(Q.Flags.s),2); { JS short }
  $79:ShortJmp(Not((SF)in(Q.Flags.s)),2); { JNS short }
  $7A:ShortJmp((PF)in(Q.Flags.s),2); { JP short }
  $7B:ShortJmp(Not((PF)in(Q.Flags.s)),2); { JNP short }
  $7C:ShortJmp(((SF)in(Q.Flags.s))<>((_OF)in(Q.Flags.s)),2); { JL short }
  $7D:ShortJmp(((SF)in(Q.Flags.s))=((_OF)in(Q.Flags.s)),2); { JNL short }
  $7E:ShortJmp((((SF)in(Q.Flags.s))<>((_OF)in(Q.Flags.s)))or((ZF)in(Q.Flags.s)),2); { JLE short }
  $7F:ShortJmp((((SF)in(Q.Flags.s))=((_OF)in(Q.Flags.s)))or(Not((ZF)in(Q.Flags.s))),2); { JNLE short }
  $80:Begin
   NC:=S86GetCode(Q,1);
   Case NC shr 3of
    7,15:Begin{ 80h 38h Ö 80h 3Fh, 80h 78h Ö 80h 7Fh }
     WriteValue(S86GetCode(Q,EstimateSizeOpCodeAddr(1)),1,False,opCmp);
     IncCode(1);
    End;
    Else Goto InvalidOpCode;
   End;
  End;
  $81:Begin
   NC:=S86GetCode(Q,1);
   Case NC shr 3of
    $1D:Begin
     S86SubWord(Q,Word(Q.Reg.Abs[NC and$07]),GetCodeWord(2));
     IncCode(4);
    End;
    $1F:Begin
     S86CmpWord(Q,Word(Q.Reg.Abs[NC and$07]),GetCodeWord(2));
     IncCode(4);
    End;
    Else Goto InvalidOpCode;
   End;
  End;
  $82:If(soOpCode2D)in(Q.Option)Then Begin { CALL Near xxxxh,yyh }
   PushWordStack(Q,Q.IP+4);
   NC:=S86GetCode(Q,3);
   Q.IP:=GetCodeWord(1);
   Q.srStep:=NC;
  End
   Else
  Goto InvalidOpCode;
  $83:Begin
   NC:=S86GetCode(Q,1);
   Case NC shr 3of
    $02:Begin
      {???Pas certain...}
     {WriteValue(S86GetCode(Q,EstimateSizeOpCodeAddr(1)),1,True,opADC);}
     WriteValue(GetCodeWord(EstimateSizeOpCodeAddr(1)),1,True,opADC);
     {S86AdcWord(Q,ReadValue(EstimateSizeOpCodeAddr(1),1),GetCodeWord(2));}
    End;
  (*  $0F:Begin
      {???Pas certain...}
     WriteValue(S86GetCode(Q,EstimateSizeOpCodeAddr(2)),2,True,opCmp);
    End;*)
    $18:Begin
     S86AddWord(Q,Word(Q.Reg.Abs[NC and$07]),S86GetCode(Q,2));
     IncCode(3);
    End;
    $1A:Begin { ADC registre 16 bits,valeur}
     S86AdcWord(Q,Word(Q.Reg.Abs[NC and$07]),S86GetCode(Q,2));
     IncCode(3);
    End;
    Else Goto InvalidOpCode;
   End;
  End;
  $86:Begin { XCHG registre 8 bits,registre 8 bits}
   NC:=(S86GetCode(Q,1) and $3F)shr 3;
   WriteValue(GetReg8Bits(NC),1,False,opXChg);
  End;
  $87:Begin { XCHG registre 16 bits,registre 16 bits}
   NC:=(S86GetCode(Q,1) and $3F)shr 3;
   WriteValue(Word(Q.Reg.Abs[NC and$07]),1,True,opXChg);
  End;
  $88:Begin { MOV registre 8 bits,registre 8 bits}
   NC:=(S86GetCode(Q,1) and $3F)shr 3;
   WriteByteValue(GetReg8Bits(NC),1);
  End;
  $89:Begin { MOV }
   NC:=(S86GetCode(Q,1)and $3F)shr 3;
   WriteWordValue(Q.Reg.Abs[NC],1);
  End;
  $8A:Begin { MOV }
   NC:=(S86GetCode(Q,1)and$3F)shr 3;
   SetReg8bits(NC,ReadByteValue(1));
  End;
  $8B:Begin { MOV }
   NC:=(S86GetCode(Q,1)and$3F)shr 3;
   Word(Q.Reg.Abs[NC]):=ReadWordValue(1);
  End;
  $8C:Begin { MOV }
   NC:=(S86GetCode(Q,1)and$3F)shr 3;
   WriteWordValue(Q.Seg.Abs[NC],1);
  End;
  $8E:Begin { MOV Seg,registre 16 bits}
   NC:=((S86GetCode(Q,1)and$3F)shr 3)and 3;
   Word(Q.Seg.Abs[NC]):=ReadWordValue(1);
  End;
  $90:IncCode(1); { NOP }
  $91..$97:Begin { XCHG AX,? }
   SwapWord(Q.Reg.AX,Word(Q.Reg.Abs[CurrCode and 7]));
   IncCode(1);
  End;
  $98:Begin { CBW }
   S86CBW(Q);
   IncCode(1);
  End;
  $99:Begin { CWD }
   S86CWD(Q);
   IncCode(1);
  End;
  $9A:Begin { CALL FAR xxyyh:xxyyh }
   CallFar(GetCodeWord(1),GetCodeWord(3),5);
  End;
  $9B:Begin { WAIT }
   If((MP)in(Q.Control.s))and
     ((TS)in(Q.Control.s))Then S86CallInt(Q,7);
   IncCode(1);
  End;
  $9C:Begin { PUSHF }
   PushWordStack(Q,Q.Flags.Abs);
   IncCode(1);
  End;
  $9D:PopWordFlags; { POPF }
  $9E:Begin { SAHF }
   Q.Flags.DataByte:=Q.Reg.AH;
   IncCode(1);
  End;
  $9F:Begin { LAHF }
   Q.Reg.AH:=Q.Flags.Abs;
   IncCode(1);
  End;
  $A0:If(Q.CPU>=cpu80286)Then Begin { MOV AL,? }
   Q.Reg.AL:=ReadWordOfs(GetCodeWord(1));
   IncCode(3);
  End
   Else
  Goto InvalidOpCode;
  $A1:If(Q.CPU>=cpu80286)Then Begin { MOV AX,? }
   Q.Reg.AX:=ReadWordOfs(GetCodeWord(1));
   IncCode(3);
  End
   Else
  Goto InvalidOpCode;
  $A2:If(Q.CPU>=cpu80286)Then Begin { MOV ?,AL }
   WriteByteOfs(Q.Reg.AL,GetCodeWord(1));
   IncCode(3);
  End
   Else
  Goto InvalidOpCode;
  $A3:If(Q.CPU>=cpu80286)Then Begin { MOV ?,AX }
   WriteWordOfs(Q.Reg.AX,GetCodeWord(1));
   IncCode(3);
  End
   Else
  Goto InvalidOpCode;
  $A4:Begin { MOVSB }
   S86MoveLeft(Q,Q.Seg.DS,Q.Reg.SI,Q.Seg.ES,Q.Reg.DI,1);
   S86IncCountString(Q,True,True);
   IncCode(1);
  End;
  $A5:Begin { MOVSW }
   S86MoveLeft(Q,Q.Seg.DS,Q.Reg.SI,Q.Seg.ES,Q.Reg.DI,2);
   S86AddCountString(Q,2,True,True);
   IncCode(1);
  End;
  $A8:If(Q.CPU>=cpu80286)Then Begin { TEST AL,xxh }
   S86TestByte(Q,Q.Reg.AL,S86GetCode(Q,1));
   IncCode(2);
  End
   Else
  Goto InvalidOpCode;
  $A9:If(Q.CPU>=cpu80286)Then Begin { TEST AX,xxyyh }
   S86TestByte(Q,Q.Reg.AX,GetCodeWord(1));
   IncCode(3);
  End
   Else
  Goto InvalidOpCode;
  $AA:Begin { STOSB }
   WriteBlock(Q,Q.Seg.ES,Q.Reg.DI,Q.Reg.AL,SizeOf(Byte));
   S86IncCountString(Q,False,True);
   IncCode(1);
  End;
  $AB:Begin { STOSW }
   WriteBlock(Q,Q.Seg.ES,Q.Reg.DI,Q.Reg.AX,SizeOf(Word));
   S86AddCountString(Q,2,False,True);
   IncCode(1);
  End;
  $AC:Begin { LODSB }
   Q.Reg.AL:=ReadWord(Q,Q.Seg.DS,Q.Reg.SI);
   S86IncCountString(Q,Ya,No);
   IncCode(1);
  End;
  $AD:Begin { LODSW }
   Q.Reg.AX:=ReadWord(Q,Q.Seg.DS,Q.Reg.SI);
   S86AddCountString(Q,2,Ya,No);
   IncCode(1);
  End;
  $B0..$B7:Begin { MOV registre 8 bits,xxh }
   SetReg8Bits(CurrCode,S86GetCode(Q,1));
   IncCode(2);
  End;
  $B8..$BF:Begin { MOV registre 16 bits,xxxxh }
   Word(Q.Reg.Abs[CurrCode and 7]):=GetCodeWord(1);
   IncCode(3);
  End;
  $C0:If(Q.CPU>=cpu80286)Then Begin
   Case S86GetCode(Q,1)of
    $C0..$C7:Begin { ROL registre 8 bits,xxh }
     S86RolByteDirect(Q,Byte(GetReg8BitsPtr(S86GetCode(Q,1))^),S86GetCode(Q,2));
     IncCode(3);
    End;
    $C8..$CF:Begin { ROR registre 8 bits,xxh }
     S86RorByteDirect(Q,Byte(GetReg8BitsPtr(S86GetCode(Q,1))^),S86GetCode(Q,2));
     IncCode(3);
    End;
   End;
  End
   Else
  Goto InvalidOpCode;
  $C2,$C3:Begin { RETN ???? }
   NC:=CurrCode;
   Q.IP:=PopWordStack;
   If NC=$C2Then Begin
    Inc(Q.Reg.SP,GetCodeWord(1));
   End;
  End;
  $C4:Q.Seg.ES:=LoadAddr(1); { LES }
  $C5:Q.Seg.DS:=LoadAddr(1); { LDS }
  $C6:Begin
   WriteValue(S86GetCode(Q,EstimateSizeOpCodeAddr(1)),1,False,opMov);
   IncCode(1); { Saute les donnÇes immÇdiate }
  End;
  $C7:Begin { MOV adresse,immÇdiat16 }
   WriteValue(S86GetCode(Q,EstimateSizeOpCodeAddr(1)),1,True,opMov);
   IncCode(2); { Saute les donnÇes immÇdiate }
  End;
  $C9:If(Q.CPU>=cpu80286)Then Begin { LEAVE }
   Q.Reg.SP:=Q.Reg.BP;
   Q.Reg.BP:=PopWordStack;
   IncCode(1); { Saute les donnÇes immÇdiate }
  End
   Else
  Goto InvalidOpcode;
  $CA,$CB:Begin { RETF ???? }
   If CurrCode=$CAThen Inc(Q.Reg.SP,GetCodeWord(1));
   Q.IP:=PopWordStack;
   Q.Seg.CS:=PopWordStack;
  End;
  $CC:Begin { INT/3}
   S86CallInt(Q,3);
   IncCode(1);
  End;
  $CD:Begin { INT }
   S86CallInt(Q,S86GetCode(Q,1));
   IncCode(2);
  End;
  $CE:Begin { INTO }
   S86CallInt(Q,4);
   IncCode(1);
  End;
  $D0:Begin
   Case S86GetCode(Q,1)shr 3of
{C0}$18:S86RolByte(Q,Byte(GetReg8BitsPtr(S86GetCode(Q,1))^));  {ROL reg8,1}
{C8}$19:S86RorByte(Q,Byte(GetReg8BitsPtr(S86GetCode(Q,1))^));  {ROR reg8,1}
{E0}$1C:S86ShlByte(Q,Byte(GetReg8BitsPtr(S86GetCode(Q,1))^));  {SHL reg8,1}
{E8}$1D:S86ShrByte(Q,Byte(GetReg8BitsPtr(S86GetCode(Q,1))^));  {SHR reg8,1}
{F0}$1E:S86SalByte(Q,Byte(GetReg8BitsPtr(S86GetCode(Q,1))^));  {SAL reg8,1}
{F8}$1F:S86SarByte(Q,Byte(GetReg8BitsPtr(S86GetCode(Q,1))^));  {SAR reg8,1}
    Else Goto InvalidOpcode;
   End;
   IncCode(2);
  End;
  $D1:Begin
   Case S86GetCode(Q,1)shr 3of
{C0}$18:S86RolWord(Q,Word(Q.Reg.Abs[S86GetCode(Q,1)and 7]));   {ROL reg16,1}
{C8}$19:S86RorWord(Q,Word(Q.Reg.Abs[S86GetCode(Q,1)and 7]));   {ROR reg16,1}
{E0}$1C:S86ShlWord(Q,Word(Q.Reg.Abs[S86GetCode(Q,1)and 7]));   {SHL reg16,1}
{E8}$1D:S86ShrWord(Q,Word(Q.Reg.Abs[S86GetCode(Q,1)and 7]));   {SHR reg16,1}
{F0}$1E:S86SalWord(Q,Word(Q.Reg.Abs[S86GetCode(Q,1)and 7]));   {SAL reg16,1}
{F8}$1F:S86SarWord(Q,Word(Q.Reg.Abs[S86GetCode(Q,1)and 7]));   {SAR reg16,1}
    Else Goto InvalidOpcode;
   End;
   IncCode(2);
  End;
  $D2:Begin
   Case S86GetCode(Q,1)shr 3of
{C0}$18:S86RolByteCL(Q,Byte(GetReg8BitsPtr(S86GetCode(Q,1))^));{ROL reg8,CL}
{C8}$19:S86RorByteCL(Q,Byte(GetReg8BitsPtr(S86GetCode(Q,1))^));{ROR reg8,CL}
{E0}$1C:S86ShlByteCL(Q,Byte(GetReg8BitsPtr(S86GetCode(Q,1))^));{SHL reg8,CL}
{E8}$1D:S86ShrByteCL(Q,Byte(GetReg8BitsPtr(S86GetCode(Q,1))^));{SHR reg8,CL}
{F0}$1E:S86SalByteCL(Q,Byte(GetReg8BitsPtr(S86GetCode(Q,1))^));{SAL reg8,CL}
{F8}$1F:S86SarByteCL(Q,Byte(GetReg8BitsPtr(S86GetCode(Q,1))^));{SAR reg8,CL}
    Else Goto InvalidOpcode;
   End;
   IncCode(2);
  End;
  $D3:Begin
   Case S86GetCode(Q,1)shr 3of
{C0}$18:S86RolWordCL(Q,Word(Q.Reg.Abs[S86GetCode(Q,1)and 7])); {ROL reg16,CL}
{C8}$19:S86RorWordCL(Q,Word(Q.Reg.Abs[S86GetCode(Q,1)and 7])); {ROR reg16,CL}
{E0}$1C:S86ShlWordCL(Q,Word(Q.Reg.Abs[S86GetCode(Q,1)and 7])); {SHL reg16,CL}
{E8}$1D:S86ShrWordCL(Q,Word(Q.Reg.Abs[S86GetCode(Q,1)and 7])); {SHR reg16,CL}
{F0}$1E:S86SalWordCL(Q,Word(Q.Reg.Abs[S86GetCode(Q,1)and 7])); {SAL reg16,CL}
{F8}$1F:S86SarWordCL(Q,Word(Q.Reg.Abs[S86GetCode(Q,1)and 7])); {SAR reg16,CL}
    Else Goto InvalidOpcode;
   End;
   IncCode(2);
  End;
  $D4:If S86GetCode(Q,1)=$0AThen Begin { AAM }
   S86AAM(Q);
   IncCode(1);
  End
   Else
  Goto InvalidOpCode;
  $D5:If S86GetCode(Q,1)=$0AThen Begin { AAD }
   S86AAD(Q);
   IncCode(1);
  End
   Else
  Goto InvalidOpCode;
  $D6:If(soSETALC)in(Q.Option)Then Begin { SETALC }
   Q.Reg.AL:=Byte((CF)in(Q.Flags.s));
   IncCode(1);
  End
   Else
  Goto InvalidOpCode;
  $D7:Begin { XLAT }
   CurrSeg:=3;
   Q.Reg.AL:=ReadWordOfs(Q.Reg.BX+Q.Reg.AL);
   IncCode(1);
  End;
  $E0:Begin { LOOPNE/LOOPNZ }
   Dec(Q.Reg.CX);
   If(Q.Reg.CX<>0)and(Not((ZF)in(Q.Flags.s)))Then
    IncCode(2+ShortInt(S86GetCode(Q,1)))
   Else
    IncCode(2);
  End;
  $E1:Begin { LOOPE/LOOPZ }
   Dec(Q.Reg.CX);
   If(Q.Reg.CX<>0)and((ZF)in(Q.Flags.s))Then
    IncCode(2+ShortInt(S86GetCode(Q,1)))
   Else
    IncCode(2);
  End;
  $E2:Begin { LOOP }
   Dec(Q.Reg.CX);
   If Q.Reg.CX=0Then IncCode(2)
                Else IncCode(2+ShortInt(S86GetCode(Q,1)));
  End;
  $E3:Begin { JCXZ }
   If Q.Reg.CX=0Then IncCode(2+ShortInt(S86GetCode(Q,1)))
                Else IncCode(2);
  End;
  $E4:Begin { IN AL,? }
   Q.Reg.AL:=InPortByte(S86GetCode(Q,1));
   IncCode(2);
  End;
  $E5:Begin { IN AX,? }
   Q.Reg.AX:=InPortWord(S86GetCode(Q,1));
   IncCode(2);
  End;
  $E6:Begin { OUT ?,AL }
   OutPortByte(S86GetCode(Q,1),Q.Reg.AL);
   IncCode(2);
  End;
  $E7:Begin { OUT ?,AX }
   OutPortWord(S86GetCode(Q,1),Q.Reg.AX);
   IncCode(2);
  End;
  $E8:Begin { CALL Near }
   CallNear(Q.IP+GetCodeWord(1)+3{ $FFFD-Q.IP+GetCodeWord(1)},3);
  End;
  $E9:Begin { JMP Near ????h }
   NearJmp(True,3);
  End;
  $EA:Begin { JMP Far ????h:????h }
   Q.IP:=GetCodeWord(1);
   Q.Seg.CS:=GetCodeWord(3);
  End;
  $EB:Begin { JMP short }
   IncCode(2+ShortInt(S86GetCode(Q,1)));
  End;
  $EC:Begin { IN AL,DX }
   Q.Reg.AL:=InPortByte(Q.Reg.DX);
   IncCode(1);
  End;
  $ED:Begin { IN AX,DX }
   Q.Reg.AX:=InPortWord(Q.Reg.DX);
   IncCode(1);
  End;
  $EE:Begin { OUT DX,AL }
   OutPortByte(Q.Reg.DX,Q.Reg.AL);
   IncCode(1);
  End;
  $EF:Begin { OUT DX,AX }
   OutPortWord(Q.Reg.DX,Q.Reg.AX);
   IncCode(1);
  End;
  $F3:Case S86GetCode(Q,1)of
   $66:Case S86GetCode(Q,2)of
    $A5:Begin { REP MOVSD }
     S86MoveLeft(Q,Q.Seg.DS,Q.Reg.SI,Q.Seg.ES,Q.Reg.DI,Q.Reg.CX shl 2);
     S86AddCountString(Q,Q.Reg.CX shl 2,True,True);
     Q.Reg.CX:=0;
     IncCode(3);
    End;
    Else IncCode(2);
   End;
   $A4:Begin { REP MOVSB }
    S86MoveLeft(Q,Q.Seg.DS,Q.Reg.SI,Q.Seg.ES,Q.Reg.DI,Q.Reg.CX);
    S86AddCountString(Q,Q.Reg.CX,True,True);
    Q.Reg.CX:=0;
    IncCode(2);
   End;
   $A5:Begin { REP MOVSW }
    S86MoveLeft(Q,Q.Seg.DS,Q.Reg.SI,Q.Seg.ES,Q.Reg.DI,Q.Reg.CX shl 1);
    S86AddCountString(Q,Q.Reg.CX shl 1,True,True);
    Q.Reg.CX:=0;
    IncCode(2);
   End;
   $A6:Begin { REP CMPSB }
    S86CompareByte(Q,Q.Seg.DS,Q.Reg.SI,Q.Seg.ES,Q.Reg.DI,Q.Reg.CX);
    S86AddCountString(Q,Q.Reg.CX,False,True);
    Q.Reg.CX:=0;
    IncCode(2);
   End;
   $AA:Begin { REP STOSB }
    S86FillChar(Q,Q.Seg.ES,Q.Reg.DI,Q.Reg.CX,Q.Reg.AL);
    S86AddCountString(Q,Q.Reg.CX,False,True);
    Q.Reg.CX:=0;
    IncCode(2);
   End;
   $AB:Begin { REP STOSW }
    S86FillWord(Q,Q.Seg.ES,Q.Reg.DI,Q.Reg.CX shl 1,Q.Reg.AX);
    S86AddCountString(Q,Q.Reg.CX shl 1,False,True);
    Q.Reg.CX:=0;
    IncCode(2);
   End;
   Else IncCode(1);
  End;
  $F4:Begin { HLT }
   Q.Fault:=sfHLT;
   IncCode(1);
  End;
  $F5:Begin { CMC }
   If(CF)in(Q.Flags.s)Then Exclude(Q.Flags.s,CF)
                      Else Include(Q.Flags.s,CF);
   IncCode(1);
  End;
  $F6:Begin
   NC:=S86GetCode(Q,1);
   Case(NC)of
    $C0..$C7:Begin { TEST registre 8 bits,immÇdiat }
     S86TestByte(Q,Byte(GetReg8BitsPtr(S86GetCode(Q,1))^),GetCodeWord(2));
     IncCode(4);
    End;
    $D0..$D7:Begin
     SetReg8Bits(NC,Not GetReg8Bits(NC));
     IncCode(2);
    End;
    $D8..$DF:Begin
     SetReg8Bits(NC,-GetReg8Bits(NC));
     IncCode(2);
    End;
    $E0..$E7:Begin
     S86MulByte(Q,GetReg8Bits(NC));
     IncCode(2);
    End;
    $E8..$EF:Begin
     S86IMulByte(Q,GetReg8Bits(NC));
     IncCode(2);
    End;
    $F0..$F7:Begin
     S86DivByte(Q,GetReg8Bits(NC));
     IncCode(2);
    End;
    $F8..$FF:Begin
     S86IDivByte(Q,GetReg8Bits(NC));
     IncCode(2);
    End;
    Else Goto InvalidOpcode;
   End;
  End;
  $F7:Begin
   NC:=S86GetCode(Q,1);
   Case(NC)of
    $20..$27:Begin
     WriteValue(S86GetCode(Q,EstimateSizeOpCodeAddr(1)),1,True,opMul);
    End;
    $30..$37:Begin
     S86DivWord(Q,ReadValue(1,1));
     Dec(Q.IP,2);
    End;
    $60..$67:Begin
     S86MulWord(Q,ReadValue(1,1));
    End;
    $68..$6F:Begin
     S86IMulWord(Q,ReadValue(1,1));
    End;
    $70..$77:Begin
     S86DivWord(Q,ReadValue(1,1));
    End;
    $78..$7F:Begin
     S86IDivWord(Q,ReadValue(1,1));
    End;
    $C0..$C7:Begin
     S86TestWord(Q,Word(Q.Reg.Abs[NC and 7]),GetCodeWord(2));
     IncCode(4);
    End;
    $D0..$D7:Begin
     S86NotWord(Q,Word(Q.Reg.Abs[NC and 7]));
     IncCode(2);
    End;
    $D8..$DF:Begin
     S86NegWord(Q,Word(Q.Reg.Abs[NC and 7]));
     IncCode(2);
    End;
    $E0..$E7:Begin
     S86MulWord(Q,Q.Reg.Abs[NC and 7]);
     IncCode(2);
    End;
    $E8..$EF:Begin
     S86IMulWord(Q,Q.Reg.Abs[NC and 7]);
     IncCode(2);
    End;
    $F0..$F7:Begin
     S86DivWord(Q,Q.Reg.Abs[NC and 7]);
     IncCode(2);
    End;
    $F8..$FF:Begin
     S86IDivWord(Q,Q.Reg.Abs[NC and 7]);
     IncCode(2);
    End;
    Else Goto InvalidOpcode;
   End;
  End;
  $F8:Begin { CLC }
   Exclude(Q.Flags.s,CF);
   IncCode(1);
  End;
  $F9:Begin { STC }
   Include(Q.Flags.s,CF);
   IncCode(1);
  End;
  $FA:Begin { CLI }
   Exclude(Q.Flags.s,_IF);
   IncCode(1);
  End;
  $FB:Begin { STI }
   Include(Q.Flags.s,_IF);
   IncCode(1);
  End;
  $FC:Begin { CLD }
   Exclude(Q.Flags.s,DF);
   IncCode(1);
  End;
  $FD:Begin { STD }
   Include(Q.Flags.s,DF);
   IncCode(1);
  End;
  $FE:Begin
   NC:=S86GetCode(Q,1);
   Case(NC)of
    $00..$07:Begin { INC registre 8 bits }
     WriteValue(0{InutilisÇ},1,True,opInc);
    End;
    $08..$0F:Begin { DEC registre 8 bits }
     WriteValue(0{InutilisÇ},1,True,opDec);
    End;
    $C0..$C7:Begin { INC }
     S86IncByte(Q,Byte(GetReg8BitsPtr(NC)^));
     IncCode(2);
    End;
    $C8..$CF:Begin { DEC }
     S86DecByte(Q,Byte(GetReg8BitsPtr(NC)^));
     IncCode(2);
    End;
    Else Goto InvalidOpcode;
   End;
  End;
  $FF:Begin
   NC:=S86GetCode(Q,1);
   Case(NC)of
    $1E:Begin { CALL Far Ptr [yyxxh] }
     Case(CurrSeg)of
      0..3:TW:=Q.Seg.Abs[CurrSeg];
      4:TW:=Q.FS;
      5:TW:=Q.GS;
      Else TW:=Q.Seg.DS;
     End;
     CallFar(ReadWordOfs(GetCodeWord(2)),TW,4);
     {CallFar(ReadWordOfs(GetCodeWord(2)),ReadWordOfs(GetCodeWord(2)+2),4);}
    End;
    $D0..$D7:Begin { CALL registre 16 bits }
     CallNear(Word(Q.Reg.Abs[NC and 7]),2);
    End;
    Else Goto InvalidOpcode;
   End;
  End;
  Else Begin
   InvalidOpCode:ErrMsgOk('Code machine invalide! CS:IP='+
                          HexWord2Str(Q.Seg.CS)+'h:'+
                          HexWord2Str(Q.IP)+'h Code Data '+
                          HexByte2Str(CurrCode)+' '+
                          HexByte2Str(S86GetCode(Q,1))+' '+
                          HexByte2Str(S86GetCode(Q,2)));
   Q.Fault:=sfInvalidCode;
  End;
 End;
End;

Procedure S86Done(Var Context);
Var
 Q:Session8086 Absolute Context;
Begin
 FileClose(Q.Log);
 XFreeMem(Q.Memory);
End;

END.