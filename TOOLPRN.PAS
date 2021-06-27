{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                 Malte Genesis/Gestionnaire d'Impression              Û
 ³            dition Chantal pour Mode R‚el/IV - Version 1.0           Û
 ³                               1996/10/10                             Û
 ³                                                                      Û
 ³         Tous droits r‚serv‚s par les Chevaliers de Malte (C)         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Nom des programmeurs
 ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ

  Sylvain Maltais ainsi que Dieu Tout-Puissant


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette unit‚ permet une gestion avanc‚ de l'imprimante. Elle s'occupe de
 presque tous les niveaux d'impression  par rapport aux objets en plus de
 s'occuper des boŒtes de dialogues et des avertissements utilisateurs.


 Remarque
 ÍÍÍÍÍÍÍÍ

  ş D‚pendament des proc‚dures,  cette unit‚  peut r‚clam‚ des polices de
    caractŠre vid‚o sur disque dans le r‚pertoire ®MALTE\FNT\¯.
}
Unit ToolPrn;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                                   INTERFACE
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

{$I DEF.INC}
Uses Systex,Isatex;

Procedure ClearPrinter;
Procedure PDRunPrnFiles(Var Q:Prompt);
Procedure PrnCharInverse(C:Char);
Procedure PrnDir(Const Path:String);
Procedure PrnGatEdt(Var Q:EditorApp);
Procedure PrnMultiChar(C:Char;Num:Byte);
Function  RunSetPrn(Param:String):String;
Function  SetupPrinters:Boolean;
Procedure TEPrn(Var Q:EditorApp);
Procedure UpDatePrinter;
Function  WinPrint(Var Data:InfoPrintRec):Boolean;
Function  WinPrnAscii(Var Start,_End:LongInt;
                      Var Merge:Word;
                      Var Compress:Boolean):Boolean;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                                 IMPLEMENTATION
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Uses
 Adele,pritex,Math,Memories,Systems,Video,Mouse,Dialex,Dials,Terminal,
 SysInter,SysPlus,DialPlus,Restex,ResServD;

Const
 COM:String[5]='COM?:';
 LPT:String[5]='LPT?:';

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ·}
{³                     Z o n e  P r i v ‚ s                    º}
{ÔÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼}

Function  ExtractExt(Const Ext:String;P:Byte;Var Bar:Bool):String;Near;Forward;
Function  GetGatLen(PC:PChr):Wd;Near;Forward;
Function  GetNameMtx(X:Byte):String;Near;Forward;
Function  InvByte(X:Byte):Byte;Near;Forward;
Function  MaxExtractExt(Const Ext:String):Byte;Near;Forward;
Procedure PODone(Var M:LstMnu);Near;Forward;
Function  POGetPrnOut(Var M:LstMnu):Wd;Near;Forward;
Procedure POInit(Var M:LstMnu;Default,X1,Y1,X2,Y2:Byte);Near;Forward;
Procedure POPutSmallShade(Var M:LstMnu);Near;Forward;
Function  PORun(Var M:LstMnu):Wd;Near;Forward;
Procedure SetPrnOutput;Near;Forward;
Function  StrCurrPrnPHeight:String;Near;Forward;
Function  StrCurrPrnPLen:String;Near;Forward;
Procedure XPInit(Var Q:SelectPrn;Default,X1,Y1,X2,Y2:Byte);Near;Forward;
Procedure XPPutSmallShade(Var Q:SelectPrn);Near;Forward;
Function  XPRun(Var Q:SelectPrn):Wd;Near;Forward;
Function  XPGetPrn(Var Q:SelectPrn):Wd;Near;Forward;
Procedure XPDone(Var Q:SelectPrn);Near;Forward;

{$I \Source\Chantal\_TESetMo.INC}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                             Fonction ExtractExt                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction extrait les paramŠtres d'une ligne de commande style DOS.
}

Function ExtractExt;
Var
 I,N,E:Byte;
 Str,Ex2:String;
Begin
 ExtractExt:='';
 If Ext=''Then Begin
  Bar:=False;
  Exit;
 End;
 N:=1;I:=2;
 Ex2:=LTrim(Ext);
 If Ex2=''Then Exit;
 If(Length(Ex2)=1)and(P=1)Then Begin
  ExtractExt:=Ex2;
  Exit;
 End;
 Bar:=False;
 While Not(Ex2[I]in['/','_','-',' '])and(I<Length(Ex2))do Inc(I);
 If(P=N)Then Begin
  Str:=Trim(Left(Ex2,I));
  If Length(Str)>0Then Begin
   If Str[1]in['/','-','_']Then Begin
    Bar:=True;
    If Length(Str)=1Then Str:=''Else Str:=Copy(Str,2,Length(Str)-1);
   End;
  End;
  ExtractExt:=Str;
  Exit;
 End
  Else
 Inc(N);
 While I<Byte(Ex2[0])do Begin
  Bar:=Ex2[I]in['/','-','_'];
  If(Ex2[I]=' ')or(Bar)Then Begin
   If Ex2[I+1]in['/','-','_']Then Begin
    Bar:=True;
    Ex2:=DelStr(Ex2,I+1,1)
   End;
   Inc(I); E:=I;
   While Not(Ex2[E]in[' ','/','-','_'])and(Length(Ex2)>E)do Inc(E);
   If(N=P)Then Begin
    ExtractExt:=RTrim(Copy(Ex2,I,E-I+1));
    Exit;
   End
    Else
   Inc(N);
   I:=E;
  End
   Else
  Inc(I);
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Fonction GetGatLen                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction retourne la longueur  d'une chaŒne de caractŠre ASCIIZ
 d'un format GAT. Il ne retourne donc pas la longueur r‚el de la chaŒne
 de caractŠre mais plut“t en tenant compte qu'un attribut ne compte pas
 mais qu'une double largeur compte pour 2,...
}

Function GetGatLen;
Var
 I,L:Word;
Begin
 I:=0; L:=0;
 While PC^[I]<>#0do Begin
  If PC^[I]in[' '..#254]Then Inc(L)else
  If(PC^[I]<' ')and(Byte(PC^[I])and cgDouble=cgDouble)Then Inc(L);
  Inc(I);
 End;
 GetGatLen:=L;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Fonction GetNameMtx                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction retourne le r‚pertoire complŠte  (avec son nom) de la
 police de caractŠre correspondant au num‚ro s‚lectionn‚ par WinPrint.
}

Function GetNameMtx;
Var
 Ptr:Pointer;
 PString:^String Absolute Ptr;
 SP,Path:String;
 DataDB:Record
  ID:Byte;
  HeightChr:Byte;
  Name:String;
  Font:String;
 End;
Begin
 Path:='';
 If X>1Then Begin
  DBOpenServerName(ChantalServer,'CHANTAL:/Polices/IndexFont.Dat');
  If DBLocateAbs(ChantalServer,0,X,[])Then Begin
   DBReadRec(ChantalServer,DataDB);
   PString:=@DataDB;
   DBGotoColumnAbs(ChantalServer,2,Ptr);
   Path:=PString^;
  End;
  AddStr(Path,'.FNT');
  If Not(FileExist(Path))Then Begin
   SP:=MaltePath+'FNT\'+Path;
   If FileExist(SP)Then Path:=SP Else Begin
    SP:=MaltePath+'FONT\'+Path;
    If FileExist(SP)Then Path:=SP Else Path:='\MALTE\FONT\'+Path;
   End;
  End;
 End;
 GetNameMtx:=Path;
End;

{$I Library\InvByte.Inc}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Fonction MaxExtractExt                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction retourne le nombre de paramŠtre d'une ligne de commande.
}

Function MaxExtractExt;
Var
 I,N,E:Byte;
 Ex2:String;
Begin
 Ex2:=Ext;
 If Ex2=''Then Begin MaxExtractExt:=0;Exit;End;
 N:=0; I:=2;
 While Not(Ex2[I]in['/','_','-',' '])and(I<Length(Ex2))do Inc(I);
 Inc(N);
 While I<Byte(Ex2[0])do Begin
  If Ex2[I]in[' ','/','-','_']Then Begin
   If Ex2[I+1]in['/','-','_']Then Ex2:=DelStr(Ex2,I+1,1);
   Inc(I); E:=I;
   While Not(Ex2[E]in[' ','/','-','_'])and(Length(Ex2)>E)do Inc(E);
   I:=E; Inc(N);
  End
   Else
  Inc(I);
 End;
 MaxExtractExt:=N;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Proc‚dure PODone                          Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure ‚limine la fenˆtre de sortie de l'imprimante ainsi que
 les donn‚es qu'elle contient.
}

Procedure PODone;Begin
 LMDone(M)
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Fonction POGetPrnOut                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de connaŒtre la sortie d'imprimante s‚lectionner
 par l'usager.
}

Function POGetPrnOut;Begin
 POGetPrnOut:=LMGetVal(M)
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Fonction POInit                           Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure initialise la fenˆtre et les donn‚es pour que l'usager
 puisse consulter une boŒte de dialogue permettant  de choisir la sortie
 d'imprimante.
}

Procedure POLoadList(Var L:LstMnu;Var Context);
Var
 Default:Byte Absolute {Context}PrnOutput;
 I:Byte;
Begin
 If Not(IsPlayMod)Then Begin
  If Not(GetModOutput in[soLPT1,soStereoLPT1N2,soMonoLPT1N2,soDisneySoundLPT1])Then Begin
   If(LPT1Exist)Then Begin
    LPT[4]:='1';
    ALAddStrByte(L.List,LPT,poLPT1);
    If(Default=poLPT1)Then L.P:=L.List.Count-1
   End;
  End;
  If Not(GetModOutput in[soLPT2,soStereoLPT1N2,soMonoLPT1N2,soDisneySoundLPT2])Then Begin
   If(LPT2Exist)Then Begin
    LPT[4]:='2';
    ALAddStrByte(L.List,LPT,poLPT2);
    If(Default=poLPT2)Then L.P:=L.List.Count-1
   End;
  End;
  If Not(GetModOutput in[soLPT3,soDisneySoundLPT3])Then Begin
   If(LPT3Exist)Then Begin
    LPT[4]:='3';
    ALAddStrByte(L.List,LPT,poLPT3);
    If(Default=poLPT3)Then L.P:=L.List.Count-1
   End
  End
 End;
 If(LPT4Exist)Then Begin
  LPT[4]:='4';
  ALAddStrByte(L.List,LPT,poLPT4);
  If(Default=poLPT4)Then L.P:=L.List.Count-1
 End;
 If Not(IsPlayMod)Then Begin
  If Not(GetModOutput in[soLPT1,soStereoLPT1N2,soMonoLPT1N2,soDisneySoundLPT1])Then Begin
   If(LPT1Exist)Then Begin
    ALAddStrByte(L.List,'LPT1: par le DOS',poLPT1Dos);
    If(Default=poLPT1Dos)Then L.P:=L.List.Count-1
   End;
  End;
  If Not(GetModOutput in[soLPT2,soStereoLPT1N2,soMonoLPT1N2,soDisneySoundLPT2])Then Begin
   If(LPT2Exist)Then Begin
    ALAddStrByte(L.List,'LPT2: par le DOS',poLPT2Dos);
    If(Default=poLPT2Dos)Then L.P:=L.List.Count-1
   End;
  End;
  If Not(GetModOutput in[soLPT3,soDisneySoundLPT3])Then Begin
   If(LPT3Exist)Then Begin
    ALAddStrByte(L.List,'LPT3: par le DOS',poLPT3Dos);
    If(Default=poLPT3Dos)Then L.P:=L.List.Count-1
   End
  End
 End;
 If(LPT4Exist)Then Begin
  ALAddStrByte(L.List,'LPT4: par le DOS',poLPT4Dos);
  If(Default=poLPT4Dos)Then L.P:=L.List.Count-1
 End;
 For I:=0to 3do If ComExist(I+1)Then Begin
  COM[4]:=Chr(49+I);
  ALAddStrByte(L.List,COM,poCom1+I);
  If(Default=poCOM1+I)Then L.P:=L.List.Count-1
 End;
 ALAddStrByte(L.List,'Fichier:',poFile);
End;

Procedure POInit;Begin
 _LMQInit(M,X1,Y1,X2,Y2,'Sortie Imprimante',CurrKrs.Dialog.Env.List);
 M.W.CloseIcon:=False;
 POLoadList(M,Default);
 LMRefresh(M);
 LMSelBarInactive(M)
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                       Proc‚dure POPutSmallShade                    Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet d'ajouter un ombrage … la fenˆtre de s‚lection
 de la sortie d'imprimante.
}

Procedure POPutSmallShade;Begin
 LMPutSmallShade(M)
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Fonction PORun                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction attend de la part de l'utilisateur soit au niveau
 clavier et retourne naturellement ce code clavier.
}

Function PORun;
Var
 K:Word;
Begin
 PORun:=0;
 LMPutDataHome(M);
 LMSelBar(M);
 K:=WEReadk(M.W);
 Case(K)of
  kbUp:Begin
   LMkUp(M);
   PORun:=$F000;
  End;
  kbDn:Begin
   LMkDn(M);
   PORun:=$F000;
  End;
  kbEnter: PORun:=LMGetVal(M);
  Else PORun:=K;
 End;
 LMSelBarInactive(M)
End;

Function PrnFileDialog:Boolean;
Var
 PathPrn:String;
Begin
 PrnFileDialog:=True;
 PathPrn:=OpenWin('','Impression dans un fichier');
 If PathPrn<>''Then Begin
  If Not AssignFile2Prn(PathPrn)Then Begin
   ErrNoMsgOk(ErrorPrnFile);
   PrnFileDialog:=False;
  End;
 End
  Else
 PrnFileDialog:=False;
End;

Procedure _PrnInv(C:Char;BitsPerChar:Byte;OriginalMtx:PTByte);
Var
 TS:String;
 I:Byte;

 Function GetCode8x8(I:Byte):Byte;
 Var
  J,Code:Byte;
  Base:Word;
 Begin
  Code:=0;Base:=Byte(C)shl 3;
  For J:=0to 7do Code:=Code or(((OriginalMtx^[Base+J]shr I)and 1)shl J);
  GetCode8x8:=Code;
 End;

Begin
 TS:='';
 For I:=(BitsPerChar)downto 1do IncStr(TS,Chr(Not(InvByte(GetCode8x8(I)))));
 If(PrnSetup[PrnOutput].CompMode)Then Prn(psPrn.GrafDbl)
                                 Else Prn(Chr(caEsc)+'K');
 Prn(TS[0]+#0+TS);
End;

Procedure PrnCharInverse(C:Char);Begin
 {$IFNDEF __Windows__}
  _PrnInv(C,6,@Mtx8x8High);
 {$ENDIF}
End;

Procedure _PrnGraph(C:Char;BitsPerChar,Num:Byte;OriginalMtx:PTByte);
Var
 TS:String;
 I:Byte;
 W:Word;
 WB:Record
  Lo,Hi:Char;
 End Absolute W;

 Function GetCode8x8(I:Byte):Byte;
 Var
  J,Code:Byte;
  Base:Word;
 Begin
  Code:=0;Base:=Byte(C)shl 3;
  If I=196Then Begin
   Code:=$10;
  End
   Else
  For J:=0to 7do Code:=Code or(((OriginalMtx^[Base+J]shr I)and 1)shl J);
  GetCode8x8:=Code;
 End;

Begin
 TS:='';
 For I:=(BitsPerChar)downto 1do IncStr(TS,Chr(InvByte(GetCode8x8(I))));
 If(PrnSetup[PrnOutput].CompMode)Then Prn(psPrn.GrafDbl)
                                 Else Prn(Chr(caEsc)+'K');
 W:=Length(TS)*Num;
 Prn(WB.Lo+WB.Hi);
 For I:=1to(Num)do Begin
  Prn(TS);
 End;
End;

Procedure PrnMultiChar(C:Char;Num:Byte);Begin
 {$IFNDEF __Windows__}
  _PrnGraph(C,6,Num,@Mtx8x8High);
 {$ENDIF}
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Proc‚dure PrnGatLn                          Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure interne  … l'unit‚ est utilis‚  pour imprimer une lignes
 sur l'imprimante via un format de fichier GAT. Le mode exposant (variable
 ®Expos¯)  indique  si l'imprimante  se trouve pr‚sentement  d‚j…  en mode
 exposant  et  ainsi  ne pas  faire appelle  … cette possibilit‚  dans une
 demande d'exposant dans une ligne d‚j… exposant...
}

Procedure PrnGatLn(Var Mtx:PTByte;OriginalMtx:PTByte;
                   Var Info:InfoPrintRec;PageLen:Byte;PC:PChr;
                   Var K,PL,XW1,XW2,_IS:Word;Var Expos:Boolean;
                   Var BitsPerChar:Byte);Near;
Label Break3;
Var
 Gras,Underline,Inverse,_Italic,Justify,OnlySpc:Boolean;
 NumSpc,L,I,JN,HP,HC:Word;
 BitsPerSpc,BitsPerSpcR:Byte;
 NmLn{,IL}:Byte;
 Patch:String;
 Balayage,MaxBalayage:Byte;

 Procedure EndPatch;Begin
  If Patch<>''Then Begin
   If((Not(Info.Compress))and(Info.Quality=NLQ))Then Prn(Char(caEsc)+'Z'+Patch[0])Else
   If(PrnSetup[PrnOutput].CompMode)Then Prn(psPrn.GrafDbl+Patch[0])
   Else Prn(Char(caESC)+'K'+Patch[0]);
   Prn(#0);
   Prn(Patch);
   Patch:='';
  End;
 End;

 Procedure Prn(Const S:String);Begin
  EndPatch;
  Pritex.Prn(S);
 End;

 Procedure PrnInv(C:Char);Begin
  _PrnInv(C,BitsPerChar,OriginalMtx);
 End;

 Procedure PrnInMtx8x8(C:Chr);
 Var
  TS:String;
  I:Byte;

  Function GetCode8x8(I:Byte):Byte;
  Var
   J,Code:Byte;
   Base:Word;
  Begin
   Code:=0;Base:=Byte(C)shl 3;
   For J:=0to 7do Code:=Code or(((OriginalMtx^[Base+J]shr I)and 1)shl J);
   GetCode8x8:=Code;
  End;

 Begin
  If C='_'Then Prn(psUnderlnChr)
   Else
  Begin
   TS:='';
   For I:=(BitsPerChar)downto 1do IncStr(TS,Chr(InvByte(GetCode8x8(I))));
   If(PrnSetup[PrnOutput].CompMode)Then Prn(psPrn.GrafDbl)
                                   Else Prn(Chr(caEsc)+'K');
   Prn(TS[0]+#0+TS);
   If(PageLen<=66)and(C in['Ø','Î','º','³'])Then Prn(Chr(caBS)+'³');
  End;
 End;

 Procedure PrnChr(C:Chr);
 Var
  I,J,K:Byte;
  Code:Integer;

  Function GetCode(I:Byte):Byte;
  Var
   J,Code:Byte;
   Base:Word;
  Begin
   Code:=0;Base:=(Byte(C)shl 4);
   For J:=0to 7do Code:=Code or(((Mtx^[Base+(J shl 1)]shr I)and 1)shl J)or
                               (((Mtx^[Base+(J shl 1)+1]shr I)and 1)shl J);
   GetCode:=Code;
  End;

  Function GetCodeIL(I:Byte;IL:Byte):Byte;
  Var
   J,Code:Byte;
   Base:Word;
  Begin
   Code:=0;Base:=(Byte(C)shl 4)+IL;
   If Balayage=1Then Inc(Base);
   For J:=0to 7do Code:=Code or(((Mtx^[Base+(J shl 1)]shr I)and 1)shl J);
   GetCodeIL:=Code;
  End;

 Begin
  If(PrnSetup[PrnOutput].BorderPixel)and(C in['_','³'..'Ú'])Then PrnInMtx8x8(C)
   Else
  If(NmLn=0)or(C in['_',#176..#223])Then Prn(C)
   Else
  Begin
   If(Not(Info.Compress))and(Info.Quality=NLQ)Then Begin
    K:=0;
    For I:=7downto 0do For J:=0to 2do Begin
     IncStr(Patch,Chr(InvByte(GetCodeIL(I,K))));
     K:=K xor 1;
    End;
    If Length(Patch)>156Then EndPatch;
   End
    Else
   For I:=(BitsPerChar)downto 1do Begin
    Code:=GetCode(I);
    If(I=6)and(BitsPerChar=6)Then Code:=Code or GetCode(7);
    If I=1Then Code:=Code or GetCode(0);
    Code:=InvByte(Code);
    IncStr(Patch,Chr(Code));
    If Length(Patch)>150Then EndPatch;
   End;
  End;
 End;

 Procedure PrnStepBit(Nm:Byte);
 Var
  I:Byte;
 Begin
  AddStr(Patch,MultChr(#0,Nm));
  If Length(Patch)>150Then EndPatch;
  If(Not(Info.Compress))and(Info.Quality=NLQ)Then AddStr(Patch,MultChr(#0,Nm*3));
  If Length(Patch)>150Then EndPatch;
 End;

Begin
 Patch:='';
 HP:=0;OnlySpc:=True;
 NmLn:=Byte(Mtx<>NIL);
 MaxBalayage:=Byte((Info.Quality=NLQ)and(Mtx<>NIL));
 For Balayage:=0to(MaxBalayage)do If(PC<>NIL)Then Begin
  While PC^[HP]<>#0do Begin
   If PC^[HP]<>' 'Then Begin
    OnlySpc:=False;
    Break;
   End;
   Inc(HP);
  End;
  HC:=HP;
  If Not(OnlySpc)Then Begin
   Prn(Spc(HP));
   K:=HP;L:=StrLen(PC);PL:=GetGatLen(PC);
   Justify:=(PC^[L-1]=' ')and(PrnSetup[PrnOutput].Code<>pnNone);
   If(Justify)Then Begin
    While Not(PC^[HC]in[#0,' '])do Inc(HC);
    If PC^[HC]=#0Then HC:=HP
     Else
    Begin
     If(PC^[HC+1]=' ')Then While PC^[HC]=' 'do Inc(HC)
                      Else HC:=HP;
    End;
    Dec(PL);Dec(L);
    If(XW2<=PL)Then Justify:=False
     Else
    Begin
     NumSpc:=0;
     For I:={HP}HC to L-1do If PC^[I]=' 'Then Inc(NumSpc);
     JN:=XW2-XW1-(PL-XW1);
     If NumSpc<>0Then Begin
      BitsPerSpc:=(JN*BitsPerChar)div NumSpc;
      BitsPerSpcR:=(JN*BitsPerChar)mod NumSpc;
     End
      Else
     Begin
      BitsPerSpc:=0;BitsPerSpcR:=0;
     End;
    End;
   End;
   _IS:=0;
   While PC^[K]<>#0do Begin
    Case PC^[K]of
     #1..#31:Begin{ Attr ? }
      Inc(K);
      If PC^[K]=#0Then Goto Break3;
      Gras:=Byte(PC^[K-1])and cgBold=cgBold;
      Underline:=Byte(PC^[K-1])and cgUnderline=cgUnderline;
      _Italic:=Byte(PC^[K-1])and cgItalic=cgItalic;
      Inverse:=Byte(PC^[K-1])and cgInverse=cgInverse;
      If(Inverse)and(Gras)and Not(Expos)Then __SetPrnExposant
       Else
      Begin
       If(Not Info.Compress)and(Gras)Then __SetPrnBold;
       If(_Italic)Then __SetPrnItalic;
      End;
      If(Byte(PC^[K-1])and cgDouble=cgDouble)Then Begin
       __SetPrnDouble;
       Prn(PC^[K]);
       If(Info.Compress)and(Gras)Then Prn(Char(caBS)+PC^[K]);
       If(Underline)Then Begin
        Prn(Char(caBS));
        PrnChr('_')
       End;
       __SetPrnSimple;
      End
       Else
      If(Inverse)and Not(Gras)Then PrnInv(PC^[K])
       Else
      Begin
       If(Inverse)and(Gras)and Not(Expos)Then Prn(PC^[K])Else PrnChr(PC^[K]);
       If(Info.Compress)and(Gras)Then Prn(Char(caBS)+PC^[K]);
       If(Underline)Then Begin
        Prn(Char(caBS));
        PrnChr('_')
       End;
      End;
      If(_Italic)Then __SetPrnUnItalic;
      If(Not Info.Compress)and(Gras)Then __SetPrnUnBold;
      If(Inverse)and(Gras)and Not(Expos)Then __SetPrnUnExposant;
     End;
     ' ':If(Justify)Then Begin
      If(K>=HC)Then Begin
       Inc(_IS);
       PrnStepBit(BitsPerSpc);
       If BitsPerSpcR>0Then Begin
        PrnStepBit(1);
        Dec(BitsPerSpcR)
       End;
       If(_IS=NumSpc)Then PrnStepBit(BitsPerSpcR);
      End;
      PrnChr(' ');
     End
      Else
     Begin
      If(PC^[K-2]<' ')and(PC^[K+1]<' ')and
        (Byte(PC^[K-2])and cgUnderline=cgUnderline)and
	(Byte(PC^[K+1])and cgUnderline=cgUnderline)Then PrnChr('_')
                                                   Else PrnChr(' ');
     End;
     Else If(PageLen in[89..158])and(PC^[K]in['³'..'Ú'])Then Begin
      Prn(Char(caEsc)+'T');
      Prn(PC^[K]);
      __SetPrnExposant;
     End
      Else
     PrnChr(PC^[K]);
    End;
    Inc(K);
   End;
Break3:
  End;
  If(MaxBalayage=1)and(Balayage=0)Then Prn(#13);
 End;
 EndPatch;
 PrnLn;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Proc‚dure SetPrnOutput                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de s‚lectionner la sortie standard de l'imprimante.
 Il supporte aussi bien les ports parallŠles que les RS-232 (serials ports)
 ou les fichiers.
}

Procedure SetPrnOutput;
Var
 M:LstMnu;
 I:Byte;
Begin
 PrnOutput:=poNUL;
 LMInitKrDials(M,16,8,MaxXTxts-16,wnMax-8,'Sortie Imprimante');
 If Not(IsPlayMod)Then Begin
  If Not(GetModOutput in[soLPT1,soStereoLPT1N2,soMonoLPT1N2,soDisneySoundLPT1])Then Begin
   LPT[4]:='1';
   If(LPT1Exist)Then ALAddStrByte(M.List,LPT,poLPT1)
  End;
  If Not(GetModOutput in[soLPT2,soStereoLPT1N2,soMonoLPT1N2,soDisneySoundLPT2])Then Begin
   LPT[4]:='2';
   If(LPT2Exist)Then ALAddStrByte(M.List,LPT,poLPT2);
  End;
  If Not(GetModOutput in[soLPT3,soDisneySoundLPT3])Then Begin
   LPT[4]:='3';
   If(LPT3Exist)Then ALAddStrByte(M.List,LPT,poLPT3)
  End;
 End;
 If(LPT4Exist)Then Begin
  LPT[4]:='4';
  ALAddStrByte(M.List,LPT,poLPT4)
 End;
 For I:=0to 3do If ComExist(I+1)Then Begin
  COM[4]:=Chr(49+I);
  ALAddStrByte(M.List,COM,poCom1+I)
 End;
 If ALIsEmpty(M.List)Then Begin
  ALDone(M.List);
  Exit;
 End;
 PrnOutput:=LMRun(M);
 LMDone(M)
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                      Fonction StrCurrPrnPHeight                   Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction retourne la largeur du papier sous forme de chaŒne de
 caractŠres R‚el en format am‚ricain.
}

Function StrCurrPrnPHeight;
Var
 PHeight:Word;
Begin
 PHeight:=PrnSetup[PrnOutput].PHeight;
 StrCurrPrnPHeight:=WordToStr(PHeight div 10)+DeSep[0]+WordToStr(PHeight mod 10)
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                       Fonction StrCurrPrnPLen                      Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction retourne la longueur du papier sous forme de chaŒne de
 caractŠres R‚el en format am‚ricain.
}

Function StrCurrPrnPLen;
Var
 PL:Word;
Begin
 PL:=PrnSetup[PrnOutput].PLen;
 StrCurrPrnPLen:=WordToStr(PL div 10)+DeSep[0]+WordToStr(PL mod 10)
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Proc‚dure XPInit                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure pr‚pare une boŒte de dialogue pour s‚lectionner une
 imprimante sp‚cifique.
}

Procedure XPLoadList(Var L:LstMnu;Var Context);
Var
 Q:SelectPrn Absolute Context;
 DataDB:Record
  ID:Word;
  Mode:Byte;
  Name:String;
 End;
 I:Integer;
Begin
 DBOpenServerName(ChantalServer,'CHANTAL:/Materiel/Imprimante.Dat');
 DBFirst(ChantalServer);
 For I:=0to(pnMax)do Begin
  DBReadRec(ChantalServer,DataDB);
  ALAddStrWord(L.List,DataDB.Name,DataDB.ID);
 End;
End;

Procedure XPInit;Begin
 _LMQInit(Q.Lst,X1,Y1,X2,Y2,'ModŠle Imprimante',CurrKrs.Dialog.Env.List);
 Q.Lst.W.CloseIcon:=False;
 XPLoadList(Q.Lst,Q);
 Q.Lst.P:=Default;
 LMRefresh(Q.Lst);
 LMSelBarInactive(Q.Lst);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                       Proc‚dure XPPutSmallShade                   Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure affiche rajoute un ombrage … la boŒte de dialogue de
 s‚lection d'imprimante.
}

Procedure XPPutSmallShade;Begin
 LMPutSmallShade(Q.Lst);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                            Fonction XPRun                             Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de s‚lectionner l'imprimante ou si un code clavier
 est entr‚e  que la boŒte  de dialogue ne sait pas quoi faire avec,  il le
 retourne.
}

Function XPRun;Begin
 XPRun:=LMRunKbd(Q.Lst);
 LMSelBarInactive(Q.Lst);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Fonction XPGetPrn                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction retourne le code d'imprimante sur lequel la barre de
 s‚lection pointe.
}

Function XPGetPrn;Begin
 XPGetPrn:=LMGetVal(Q.Lst)
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                            Proc‚dure XPDone                            Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure ‚limine la boŒte de dialogue de s‚lection d'imprimante et
 libŠre la m‚moire ayant ‚t‚ r‚serv‚ par celle-ci.
}

Procedure XPDone;
Var
 I:Word;
Begin
 LMDone(Q.Lst);
 For I:=0to(pnMax)do FreeMemory(Q.PtrPChr^[I],Q.PtrSize^[I]);
 FreeMemory(Q.PtrSize,(pnMax+1)*SizeOf(Wd));
 FreeMemory(Q.PtrPChr,(pnMax+1)*SizeOf(PChar));
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ·}
{³                   Z o n e  P u b l i q u e                  º}
{ÔÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Proc‚dure ClearPrinter                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet d'‚liminer toutes les donn‚es devant ˆtre envoie
 … l'imprimante lorsqu'elle sera disponible.  Ainsi, vous pourrez annuler
 une longue impression.  Il demande tout de mˆme … l'utilisateur s'il est
 belle et bien certain de vouloir en finir...
}

Procedure ClearPrinter;Begin
 {$IFNDEF NoSpooler}
  If FSSpool<0Then DialogMsgOk('Vider quoi? Votre tampon d''impression est d‚j… vider...')
   Else
  If(WarningMsgYesNo('Etes-vous vraiment certain de vouloir terminer toutes'+
                     'les impressions devant ˆtre faŒte?')=kbYes)Then Begin
   FSSpool:=0;PSpool:=0;
  End;
 {$ENDIF}
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Proc‚dure PDRunPrnFiles                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet d'imprimer un fichier sous prompt-DOS mult-fenˆtre.
}

Procedure PDRunPrnFiles;
Var
 I:Byte;
 Bar:Boolean;
 TStr:String;

 Procedure CmdPrnFile(Path:PathStr);
 Var
  Rec:SearchRec;
  TPath:PathStr;

  Procedure PrnFile;
  Var
   Handle:Hdl;
   J,K:Word;
   Buffer:Array[0..511]of Char;
   I,Size:LongInt;
  Begin
   TPath:=FileExpand(TPath);
   WEPutPasLn(Q.Ansi,'Imprime le fichier ASCII: '+TPath);
   Handle:=FileOpen(TPath,fmRead);
   If(Handle=errHdl)Then WEPutPasLn(Q.Ansi,'Erreur: Fichier introuvable!')
    Else
   Begin
    Size:=Systems.FileSize(Handle);
    If Size>0Then Begin
     For I:=0to(Size div SizeOf(Buffer))-1do Begin
      WEPutTxtXY(Q.Ansi,0,Q.Ansi.Y,IntToStr(I*SizeOf(Buffer))+'/'+IntToStr(Size)+' octets');
      Systems.GetRec(Handle,I,SizeOf(Buffer),Buffer);
      If GetSysErr>0Then WEPutPasLn(Q.Ansi,GetErrMsg(GetSysErr));
      For J:=0to SizeOf(Buffer)-1do Pritex.Prn(Buffer[J]);
      If(KeyPress)Then Begin
       ClrKbd;
       WEAnsiLn(Q.Ansi);
       WEPutTxtXY(Q.Ansi,0,Q.Ansi.Y,'Dois-je annuler l''op‚ration (O/N) ?');
       K:=ReadKey;
       If Char(K)in['o','O']Then Begin
        FileClose(Handle);
        Exit;
       End;
      End;
     End;
     If Size mod SizeOf(Buffer)>0Then Begin
      Systems.SetFilePos(Handle,(Size div SizeOf(Buffer))*SizeOf(Buffer));
      Systems._GetRec(Handle,Size mod SizeOf(Buffer),Buffer);
      For J:=0to(Size mod SizeOf(Buffer))-1do Pritex.Prn(Buffer[J]);
     End;
     Q.Ansi.X:=0;
     WEPutPasLn(Q.Ansi,'Impression termin‚.');
    End;
    FileClose(Handle);
   End;
  End;

 Begin
  Path:=SelAllIfNoExt(Path);
  If IsWildCard(Path)Then Begin
   FindFirst(Path,fa,Rec);
   While SysErr=0do Begin
    TPath:=Path2Dir(Path)+Rec.Name;
    PrnFile;
    FindNext(Rec);
   End;
  End
   Else
  Begin
   TPath:=Path;
   PrnFile;
  End;
 End;

Begin
 If MaxExtractExt(Q.Ext)>0Then Begin
  For I:=1to MaxExtractExt(Q.Ext)do Begin
   TStr:=ExtractExt(Q.Ext,I,Bar);
   If Not(Bar)Then CmdPrnFile(TStr)Else WEPutPasLn(Q.Ansi,'Erreur: ParamŠtre invalide!');
  End;
 End
  Else
 Begin
  WEPutPasLn(Q.Ansi,'Erreur: ParamŠtre requis pour imprimer des fichiers!');
  WEAnsiLn(Q.Ansi);
  WEPutPasLn(Q.Ansi,'PRNFILE fichier(s) [fichier(s)] [...]');
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Proc‚dure PrnDir                           Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure imprime le contenu des r‚pertoires sp‚cifier. Il inclue
 ‚galement  des descriptions  si le fichier  ®DESCRIPT.ION¯  dans le mˆme
 r‚pertoire  en  contient.   La  1iŠre  ligne  sortie  contient  la  date
 d'impression du "listing". Voici un  petit  exemple  du genre  de sortie
 effectu‚ sur l'imprimante:
 ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³ Dimanche, Le 25 Janvier 1996                                         ³
 ³                                                                      ³
 ³ Le volume de l'unit‚ D est MALTE                                     ³
 ³ Le num‚ro de S‚rie du Volume est F0F0-F0F0                           ³
 ³ R‚pertoire de D:\SOURCE\CHANTAL                                      ³
 ³                                                                      ³
 ³ ABCDEFGH.IJK <R‚per.> 97-01-24 23:01:01 Ceci est une r‚pertoire...   ³
 ³ DEF     .XYZ 18000000 97-01-25 11:10:10 Ceci est un fichier          ³
 ³ DFGFGH  .123        0 96-01-23 12:00:00                              ³
 ³  ...     ...      ... ........ ........ ...                          ³
 ³ ABC     .ZC1       12 80-01-01 00:00:00 C'est ®ABC¯                  ³
 ³  Les 1 203 fichiers 18934000 octet(s)                                ³
 ³  100 000 000 octet(s) de libre                                       ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
}

Procedure PrnDir;
Var
 Year{$IFDEF DosUnit},{$ELSE}:Word;{$ENDIF}
 Month,Day,DayOfWeek,Hour,Min,Sec,Sec100{$IFDEF DosUnit},{$ELSE}:Byte;{$ENDIF}
 I:Word;
 L:BF;
 X:SearchRec;
 PC:PChr;
 Serial,Size:LongInt;
 S:String;
 W:Window;
Begin
 WriteLog('Impression du r‚pertoire '+Path);
 WEPushEndBar(W);
 WEPutLastBar('Analyse du r‚pertoire pour impression en cours...');
 BFInit(L);
 BFSelPathExt(L,Path,faAll);
 WEPutLastBar('Impression du r‚pertoire en cours...');
 If(PrnSetup[PrnOutput].PHeight*6)div 10<BFMaxFiles(L)+9Then __SetPrnInterLn1_8;
 GetDate(Year,Month,Day,DayOfWeek);
 Case DayOfWeek of
  0:Prn('Dimanche');
  1:Prn('Lundi');
  2:Prn('Mardi');
  3:Prn('Mercredi');
  4:Prn('Jeudi');
  5:Prn('Vendredi');
  6:Prn('Samedi');
 End;
 Prn(', Le ');
 If Day<=1Then Prn('1ier')Else Prn(WordToStr(Day));
 Prn(' ');
 Case Month of
  1:Prn('Janvier');
  2:Prn('F‚vrier');
  3:Prn('Mars');
  4:Prn('Avril');
  5:Prn('Mai');
  6:Prn('Juin');
  7:Prn('Juillet');
  8:Prn('Ao–t');
  9:Prn('Septembre');
 10:Prn('Octobre');
 11:Prn('Novembre');
 12:Prn('D‚cembre');
 End;
 Prn(BasicStrW(Year));PrnLn;PrnLn;
 S:=GetDskLabel(Byte(Path[1])-64);If S=''Then S:='inexistant';
 Prn('Le volume de l''unit‚ '+Path[1]+' est '+S);
 PrnLn;
 Serial:=GetSerialNm(Path2Dsk(Path));
 If Serial<>0Then Prn('Le num‚ro de S‚rie du Volume est '+_GetSerialNmStr(Serial));
 PrnLn;
 Prn('R‚pertoire de '+Path);PrnLn;PrnLn;
 Size:=0;
 For I:=0to BFMaxFiles(L)do Begin
  BFGetFile(L,I,X);
  Prn(SetFullName(X.Name));
  If(X.Attr.Value=faDir)Then Prn(' <R‚per.>')Else Prn(Str2(X.Size,9));
  Prn(' '+Copy(TimeToStr(X.Time),3,255)+' ');
  MoveLeft(X.Fill[18],PC,SizeOf(Pointer));
  If X.Name='DESCRIPT.ION'Then Prn('Liste des descriptions')Else Prn(StrPas(PC));
  Inc(Size,X.Size);
  PrnLn;
 End;
 Prn(' Les'+CStrBasic(BFMaxFiles(L)+1)+' fichier(s) utilisent'+CStrBasic(Size)+' octet(s)');PrnLn;
 Prn(Str2(DiskFree(Byte(Path[1])-64),10)+' octet(s) de libre');PrnLn;
 BFDone(L);
 WEDone(W);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Proc‚dure PrnGatEdt                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure imprime un texte de format GAT … partir d'une liste de
 format ®RBuf¯.
}

Procedure PrnGatEdt;
Label Continue,FreeMtx,Restart,ClsExit,DoneProcess,NextLine;
Var
 Mtx:PTByte;
 SizeMtx:Word;
 OldPg,J,EndJ,BeginJ,NC:RBP;
 Pg:LongInt;
 H,I,K,L,PL,_IS,HP,YWM,YPrn:Word;
 Len88,Len113,BitsPerChar,AttrChr,PageLen:Byte;
 Justify,OnlySpc:Boolean;
 PC:PChr;
 PageWidth:Byte;
 LL:Window;
 Buffer:^TByte;
 Info:InfoPrintRec;
 Expos:Boolean;
 OriginalMtx:Pointer;
 SizeOfOriginalMtx:Word;
 PassWord,InFile:Boolean;
 Handle:Hdl;
 FP,FS:LongInt;
 TPC:Array[Byte]of Chr;
 S,S2:String;
 I9:Byte;
 TW:Array[0..3]of {$IFDEF Real}PWord{$ELSE}PLong{$ENDIF};

 Procedure PrnPageNm;
 Var
  _P:LongInt;
  DS,SP:String;
  LenSpc:Integer;
  Year:Word;
  Month,Day,DOW:Byte;
 Begin
  _P:=1+Info.AddPage+DivLong(J,YWM);
  SP:=IntToStr(_P);
  If(Info.Page=ptLeft)or((Info.Page=ptAltern)and(_P and 1=1))Then Begin
   If(Q.SheetFormat.X2+Length(SP)*2+3>PageWidth)Then Begin
    LenSpc:=PageWidth-Length(SP)*2-6;
    Prn(Spc(LenSpc));
   End
    Else
   Begin
    LenSpc:=Q.SheetFormat.X2+3;
    If(Info.Info)and(Q.SheetFormat.X1<LenSpc)Then Begin { Information compl‚mentaire? }
     __SetPrnExposant;
     Prn(Spc(Q.SheetFormat.X1));
     Dec(LenSpc,Q.SheetFormat.X1);
     GetDate(Year,Month,Day,DOW);
     DS:=WordToStr(Day)+' ';
     Prn(DS);
     Dec(LenSpc,Length(DS));
     Case(Month)of
      1:DS:='JANVIER ';
      2:DS:='FVRIER';
      3:DS:='MARS';
      4:DS:='AVRIL';
      5:DS:='MAI';
      6:DS:='JUIN';
      7:DS:='JUILLET';
      8:DS:='AOUT';
      9:DS:='SEPTEMBRE';
      10:DS:='OCTOBRE';
      11:DS:='NOVEMBRE';
      12:DS:='DCEMBRE';
      Else DS:='INCONNU';
     End;
     IncStr(DS,' ');
     Prn(DS);
     Dec(LenSpc,Length(DS));
     DS:=WordToStr(Year);
     Prn(DS);
     Dec(LenSpc,Length(DS));
     If Q.EditName<>''Then Begin
      Prn(' - ');
      Dec(LenSpc,Length(' - '));
      If LenSpc>0Then Begin
       DS:=TruncName(Q.EditName,LenSpc-2);
       Prn(DS);
       Dec(LenSpc,Length(DS));
      End;
     End;
     __SetPrnUnExposant;
    End;
    Prn(Spc(LenSpc));
   End;
  End
   Else
  Prn(Spc(3));
  __SetPrnDouble;
  Prn(SP);
  __SetPrnSimple;
 End;

 Procedure P2PMsg;Begin
  If(PrnSetup[PrnOutput].P2P)Then Begin
   WEPutLastBar('SystŠme en attente d''un signal de l''utilisateur...');
   DialogMsgOk('Impression feuille … feuille! Enfoncez le bouton quand vous '+
	       'ˆtes prˆt … ce que je fasse imprimer la page'+BasicStr(Pg+1)+'.');
  End;
 End;

 Procedure PutLastMsg;Begin
  Pg:=DivLong(J,YWM);
  If(Pg<>OldPg)Then Begin
   OldPg:=Pg;
   If Info.NumCopy>1Then WEPutLastBar('Impression de la copie #'+IntToStr(NC)+' de la page '+IntToStr(Pg+1)+' en cours...')
		    Else WEPutLastBar('Impression de la page'+BasicStr(Pg+1)+' en cours...');
  End;
 End;

 Procedure PrnBanner;
 Label Break2;
 Var
  Handle:Hdl;
  J,J2,I,I2,K,P:Word;
  x0:Record
   Height,Len:Byte;
   Mtx:Array[0..125]of Byte;
  End;
  JN,NumSpc:Word;
  BitsPerSpc,BitsPerSpcR:Byte;

  Procedure _PrnLn;Begin
   PrnLn;
   PrnLn;
   PrnLn;
   PrnLn;
  End;

 Begin
  Handle:=FileOpen('BROADWAY.POL',fmRead);
  If(Handle=errHdl)Then Begin
   ErrMsgOk('Police de caractŠre BroadWay requis pour cette impression!');
   Exit;
  End;
  Prn(psPrn.InterLn7_72);
  PageLen:=Len113 div 4;
  ALSetPtr(Q.List,BeginJ);
  OldPg:={$IFDEF DPMI}$FFFFFFFF{$ELSE}$FFFF{$ENDIF};
  Pg:=DivLong(BeginJ,YWM);
  P2PMsg;
  Pg:=$FFFF;
  For K:=1to(Q.SheetFormat.Y1)do _PrnLn;
  For J:=BeginJ to(EndJ)do Begin
   PutLastMsg;
   OnlySpc:=True;HP:=0;
   PC:=_ALGetCurrBuf(Q.List);
   If(PC=NIL)Then Begin
    PrnLn;
    PrnLn;
    PrnLn;
    End
    Else
   Begin
    While PC^[HP]<>#0do Begin
     If PC^[HP]<>' 'Then Begin
      OnlySpc:=False;
      Goto Break2;
     End;
     Inc(HP);
    End;
Break2:
    For I2:=0to 2do If Not(OnlySpc)Then Begin
     Prn(Spc(HP));
     K:=HP;L:=StrLen(PC);
     PL:=GetGatLen(PC);
     Justify:=PC^[L-1]=' ';
     If(Justify)Then Begin
      Dec(PL);
      Dec(L);
      If(Q.SheetFormat.X2<=PL)Then Justify:=False
       Else
      Begin
       NumSpc:=0;
       For I:=HP to L-1do If PC^[I]=' 'Then Inc(NumSpc);
       JN:=Q.SheetFormat.X2-Q.SheetFormat.X1-(PL-Q.SheetFormat.X1);
       If NumSpc<>0Then Begin
	BitsPerSpc:=(JN*BitsPerChar)div NumSpc;
	BitsPerSpcR:=(JN*BitsPerChar)mod NumSpc;
       End
	Else
       Begin
        BitsPerSpc:=0;
        BitsPerSpcR:=0;
       End;
      End;
     End;
     While PC^[K]<>#0do Begin
      If PC^[K]=' 'Then Prn(' ')
       Else
      Begin
       GetRec(Handle,Byte(PC^[K]),SizeOf(P),P);
       If P=0Then GetRec(Handle,Byte(ChrDn(PC^[K])),SizeOf(P),P);
       If P=0Then Prn(' ')
	Else
       Begin
        _GetAbsRec(Handle,P,SizeOf(x0),x0);
	Prn(psPrn.GrafDbl+Chr(x0.Len)+#0);
	For J2:=0to x0.Len-1do Prn(Chr(x0.Mtx[I2*x0.Len+J2]));
       End;
      End;
      Inc(K);
     End;
     PrnLn;
    End;
   End;
   PrnLn;
   If J mod YWM=YWM-1Then Begin
    H:=PageLen-Q.SheetFormat.Y2+Q.SheetFormat.Y1;
    _PrnLn;
    If(Info.Page<>ptNone)Then Begin
     PrnPageNm;
     If(J=EndJ)Then H:=H shr 1;
    End;
    If(J=EndJ)Then For K:=2to H do _PrnLn
     Else
    Begin
     If(PrnSetup[PrnOutput].P2P)Then Begin
      For K:=2to H shr 1do _PrnLn;
      Inc(Pg);
      P2PMsg;
      Dec(Pg);
      For K:=2to H shr 1do _PrnLn;
     End
      Else
     For K:=2to(H)do _PrnLn;
    End;
   End;
   ALNext(Q.List);
  End;
  If J mod YWM<YWM-1Then Begin
   For I:=J mod YWM to YWM-1do _PrnLn;
   If(Info.Page<>ptNone)Then Begin
    PrnPageNm;
    PrnLn;
   End;
   For I:=Q.SheetFormat.Y2+2to PageLen-1do _PrnLn;
  End;
  FileClose(Handle);
 End;

{$IFDEF Real}
 {$I Library\XtrkWdIn.Inc}
{$ELSE}
 {$I Library\XtrkLong.Inc}
{$ENDIF}

 Procedure DrawCenter(Dbl:Boolean);
 Var
  Header:GPXHeader;
  Buffer:Array[0..719]of Byte;
  Handle:Hdl;
  II,I,J2,Half,NmLn:Word;
  P:Long;
 Begin
  Handle:=FileOpen(Copy(StrPas(PC),5,255),fmRead);
  If(Handle<>errHdl)Then Begin
   _GetAbsRec(Handle,0,SizeOf(Header),Header);
   P:=SizeOf(Header);NmLn:=0;
   If(Dbl)Then Half:=(960-(Header.Len shl 1))shr 1
          Else Half:=(960-Header.Len)shr 1;
   Prn(psPrn.InterLn7_72);
   For J2:=0to Header.Ln-1do Begin
    _GetAbsRec(Handle,P,Header.Len,Buffer);
    Inc(P,Header.Len);
    For II:=0to Byte(Info.Quality)do Begin
     Prn(psPrn.GrafDbl+Chr(Half)+Chr(Hi(Half)));
     For I:=0to Half-1do Prn(#0);
     If(Dbl)Then Begin
      Header.Len:=Header.Len shl 1;
      Prn(psPrn.GrafDbl+Chr(Header.Len)+Chr(Hi(Header.Len)));
      Header.Len:=Header.Len shr 1;
      For I:=0to Header.Len-1do Prn(Chr(Buffer[I])+Chr(Buffer[I]))
     End
      Else
     Begin
      Prn(psPrn.GrafDbl+Chr(Header.Len)+Chr(Hi(Header.Len)));
      For I:=0to Header.Len-1do Prn(Chr(Buffer[I]));
     End;
     If(II=0)and(Info.Quality=NLQ)Then Prn(#13);
    End;
    PrnLn;
     { Saute la ligne, incr‚mente le compteur }
    Inc(J);Inc(NmLn);
    If(InFile)Then Begin
     __GetAbsFileTxtLn(Handle,FP,S);
     PC:=@TPC;StrPCopy(PC,S);
    End
     Else
    Begin
     ALNext(Q.List);
     PC:=_ALGetCurrBuf(Q.List);
    End;
   End;
   If(PageLen=Len88)Then
    Prn(Char(caEsc)+'A'+Chr(2*NmLn)+Char(caEsc)+'2')
   Else
    Prn(Char(caEsc)+'A'+Chr(5*NmLn)+Char(caEsc)+'2');
   PrnLn;
   Prn(Char(caEsc)+'A'#12+Char(caEsc)+'2');
   FileClose(Handle);
  End
   Else
  ErrMsgOk('D‚sol‚! Votre image '+Copy(StrPas(PC),5,255)+' est introuvable');
 End;

Begin
 FillClr(Info,SizeOf(Info));
 InFile:=Q.List.Count=0;
 If(InFile)Then Begin { Impression d'un fichier de format GAT
                        non contenu en m‚moire? }
  Handle:=FileOpen(Q.EditName,fmRead);
  If(Handle=errHdl)Then Begin
   __FileNotFound(Q.EditName);
   Exit;
  End;
  FP:=0;FS:=FileSize(Handle);
  __GetAbsFileTxtLn(Handle,FP,S);
  If GetSysErr<>0Then Goto ClsExit;
  If StrI(1,S)in[':',';']Then Begin
   PassWord:=S[1]=';';
   TW[0]:=@Q.SheetFormat.X1;
   TW[1]:=@Q.SheetFormat.Y1;
   TW[2]:=@Q.SheetFormat.X2;
   TW[3]:=@Q.SheetFormat.Y2;
   I9:={$IFDEF Real}XtrkWdInStr{$ELSE}XtrkLongInStr{$ENDIF}(S,4,TW);
   If I9=0Then Begin
    If(WarningMsgYesNo('Entˆte de fichier GAT endomag‚! Dois-je utiliser le format par d‚faut?')=kbYes)Then Begin
     Q.SheetFormat.X1:=10;
     Q.SheetFormat.X2:=70;
     Q.SheetFormat.Y1:=6;
     Q.SheetFormat.Y2:=60;
    End;
   End;
  End;
  S2:=XtrkWord(I9,S);
  If(S2='L')or(S2='LEFT')Then Q.PageNumIn:=ptLeft Else
  If(S2='R')or(S2='RIGHT')Then Q.PageNumIn:=ptRight Else
  If(S2='A')or(S2='ALTERNATE')Then Q.PageNumIn:=ptAltern
                              Else Q.PageNumIn:=ptNone;
  SkipSpcInLn(I9,S);
  S2:=XtrkDecNm(I9,S);
  If S2<>''Then Q.PageNumStart:=StrToInt(S2);
  Info.EndPage:=65535;
  YWM:=Q.SheetFormat.Y2-Q.SheetFormat.Y1;
 End
  Else
 Begin { Document GAT contenu en m‚moire? }
  YWM:=Q.SheetFormat.Y2-Q.SheetFormat.Y1;
  Info.EndPage:=DivLong(Q.List.Count-1,YWM)+1;
 End;
 Mtx:=NIL;
 Info.Font.ItemIndex:=1;
 PageLen:=66;
 Info.NumCopy:=1;
 Info.StartPage:=1;
 Info.Compress:=Q.SheetFormat.X2>80;
 Info.Paysage:=False;
 Info.Justify:=True;
 Info.Quality:=NLQ;
 Info.AddPage:=Q.PageNumStart;
 Info.Page:=Q.PageNumIn;
 Expos:=False;
 Info.Info:=Q.InfoCompl;
 For I:=0to 12do Info.PrnType[I]:=PrnSetup[I].Code;
 Info.PrnOutput.ItemIndex:=PrnOutput;
 If Not WinPrint(Info)Then Goto ClsExit;
 If Info.Font.ItemIndex>1Then Begin
  Mtx:=MemAlloc(4096);
  If(Mtx=NIL)Then Begin
   __OutOfMemory;
   Exit;
  End;
  GetFile(GetNameMtx(Info.Font.ItemIndex),0,4096,Mtx^);
  If SysErr<>0Then Begin
   ErrNoMsgOk(FontNotFound);
   Goto FreeMtx;
  End;
 End;
 OriginalMtx:=AllocFont(4,SizeOfOriginalMtx);
 If(OriginalMtx=NIL)Then Begin
  __OutOfMemory;
  Exit;
 End;
 PageLen:=(PrnSetup[Info.PrnOutput.ItemIndex].PHeight*6)div 10;
 If(Info.Compress)Then PageWidth:=137 Else PageWidth:=80;
 InitPrn;
 If(Info.Quality=NLQ)Then __SetPrnNLQQuality;
 If(Q.PageNumStart<>Info.AddPage)or
   (Q.PageNumIn<>Info.Page)or
   (Q.InfoCompl<>Info.Info)Then _TESetModified(Q);
 Q.PageNumStart:=Info.AddPage;
 Q.PageNumIn:=Info.Page;
 Q.InfoCompl:=Info.Info;
 Dec(Info.StartPage);
 Dec(Info.EndPage);
 If(Info.Paysage)Then Begin
  Prn(psPrn.InterLn7_72);
  Buffer:=MemAlloc(113*120);
  If(Buffer=NIL)Then Begin
   __OutOfMemory;
   Exit;
  End;
  Mtx:=AllocFont(6,SizeMtx);
  FillSpc(Buffer^,113*120);
  BeginJ:=Info.StartPage*YWM;
  EndJ:=(Info.EndPage+1)*YWM-1;
  If EndJ>Q.List.Count-1Then EndJ:=Q.List.Count-1;
  WEPushEndBar(LL);
  For NC:=1to(Info.NumCopy)do Begin
   ALSetPtr(Q.List,BeginJ);
   OldPg:={$IFDEF DPMI}$FFFFFFFF{$ELSE}$FFFF{$ENDIF};
   YPrn:=Q.SheetFormat.Y1;
   For J:=BeginJ to(EndJ)do Begin
Continue:
    PutLastMsg;
    OnlySpc:=True;HP:=0;
    PC:=_ALGetCurrBuf(Q.List);
    If(PC=NIL)Then Goto Continue;
    While PC^[HP]<>#0do Begin
     If PC^[HP]<>' 'Then Begin
      OnlySpc:=False;
      Break;
     End;
     Inc(HP);
    End;
    If Not(OnlySpc)Then Begin
     K:=HP;
     L:=StrLen(PC);
     PL:=GetGatLen(PC);
     While PC^[K]<>#0do Begin
      Buffer^[YPrn*113+K]:=Byte(PC^[K]);
      Inc(K)
     End;
    End;
    Inc(YPrn);
    ALNext(Q.List);
   End;
  End;
  For K:=112downto 0do Begin
   Prn(psPrn.GrafDbl+#128#7);
   For J:=0to 119do Begin
    AttrChr:=Buffer^[J*113+K];
    If AttrChr<32Then Begin
     For I:=0to 15do Begin
      L:=Byte(Mtx^[(Buffer^[J*113+K+1]*16)+I]);
      L:=((L and$10)shl 3)+((L and$10)shl 2)+((L and$20)shr 0)+
	 ((L and$20)shr 1)+((L and$40)shr 3)+((L and$40)shr 4)+
	 ((L and$80)shr 6)+((L and$80)shr 7);
      Prn(Char(L));
     End;
    End
     Else
    If Buffer^[J*113+K-1]<32Then For I:=0to 15do Begin
     L:=Byte(Mtx^[AttrChr*16+I]);
     L:=((L and 1)shl 7)+((L and 1)shl 6)+((L and 2)shl 4)+
	((L and 2)shl 3)+((L and 4)shl 1)+((L and 4)shl 0)+
	((L and 8)shr 2)+((L and 8)shr 3);
     Prn(Char(L));
    End
     Else
    For I:=0to 15do Prn(Char(InvByte(Byte(Mtx^[AttrChr*16+I]))));
   End;
   PrnLn;
  End;
  FreeMemory(Mtx,SizeMtx);
  FreeMemory(Buffer,113*120);
 End
  Else
 Begin
  If(Info.Compress)Then Begin
   __SetPrnCompress;
   BitsPerChar:=7;
  End
   Else
  BitsPerChar:=6;
  If(Q.SheetFormat.Y2>PageLen)Then Begin
   Len88:=(8*PrnSetup[Info.PrnOutput.ItemIndex].PHeight)div 10;
   Len113:=(72*PrnSetup[Info.PrnOutput.ItemIndex].PHeight)div 70;
   If Q.SheetFormat.Y2>158Then Begin
    Prn(Chr(caEsc)+'A'#4+Char(caEsc)+'2');
    __SetPrnExposant;
    PageLen:=198;Expos:=True;
   End
    Else
   If(Q.SheetFormat.Y2>Len113)Then Begin
    Prn(Char(caEsc)+'A'#5+Char(caEsc)+'2');
    __SetPrnExposant;
    PageLen:=158;Expos:=True;
   End
    Else
   If(Q.SheetFormat.Y2>Len88)Then Begin
    Prn(psPrn.InterLn7_72);
    __SetPrnExposant;
    PageLen:=Len113;Expos:=True;
   End
    Else
   Begin
    __SetPrnInterLn1_8;
    PageLen:=Len88;
   End;
  End;
  BeginJ:=Info.StartPage*YWM;
  EndJ:=(Info.EndPage+1)*YWM-1;
  If Not(InFile)Then Begin
   If EndJ>Q.List.Count-1Then EndJ:=Q.List.Count-1;
  End;
  WEPushEndBar(LL);
  If Info.NumCopy=0Then ErrNoMsgOk(NumCopyPrinterInvalid)Else
  If YWM<=30Then PrnBanner Else
  For NC:=1to(Info.NumCopy)do Begin
   ALSetPtr(Q.List,BeginJ);
   OldPg:={$IFDEF DPMI}$FFFFFFFF{$ELSE}$FFFF{$ENDIF};
   Pg:=DivLong(BeginJ,YWM);
   P2PMsg;
   Pg:=$FFFF;
   For K:=1to(Q.SheetFormat.Y1)do PrnLn;
   For J:=BeginJ to(EndJ)do Begin
    PutLastMsg;
Restart:
    If(InFile)Then Begin
     __GetAbsFileTxtLn(Handle,FP,S);
     PC:=@TPC;
     StrPCopy(PC,S);
    End
     Else
    PC:=_ALGetCurrBuf(Q.List);
    If(PC<>NIL)and(PC^[0]='[')and { Option Sp‚cial? }
      (PC^[1]='D')and(PC^[2]='C')and(PC^[3]=':')Then Begin { Dessin Centr‚? }
     DrawCenter(False);
     If(J>EndJ)Then Break;
    End;
    If(PC<>NIL)and(PC^[0]='[')and { Option Sp‚cial? }
      (PC^[1]='D')and(PC^[2]='D')and(PC^[3]=':')Then Begin { Dessin Double Centr‚? }
     DrawCenter(True);
     If(J>EndJ)Then Break;
    End;
    Begin
     PrnGatLn(Mtx,OriginalMtx,Info,PageLen,PC,K,PL,Q.SheetFormat.X1,Q.SheetFormat.X2,_IS,Expos,BitsPerChar);
     If J mod YWM=YWM-1Then Begin
      H:=PageLen-Q.SheetFormat.Y2+Q.SheetFormat.Y1;
      PrnLn;
      If(Info.Page<>ptNone)Then Begin
       PrnPageNm;
       If(J=EndJ)Then H:=H shr 1;
      End;
      If(J=EndJ)Then For K:=2to H do PrnLn
       Else
      Begin
       If(PrnSetup[PrnOutput].P2P)Then Begin
        For K:=2to H shr 1do PrnLn;
        Inc(Pg);
        P2PMsg;
        Dec(Pg);
        For K:=2to H shr 1do PrnLn;
       End
        Else
       For K:=2to(H)do PrnLn;
      End;
     End;
     If(InFile)Then Begin
      If(FP<FS)Then Begin
       {$IFDEF __Windows__}
        Goto NextLine;
       {$ELSE}
        Inc(J);
        Goto Restart
       {$ENDIF}
      End
       Else
      Break;
     End
      Else
     ALNext(Q.List);
     If(KeyPress)and(ReadKey=kbEsc)Then Begin
      If(InputMsg('Attention','D‚sirez-vous interrompre le processus '+
                  'd''impression … l''endroit actuellement rendu dans le texte?',
                   KeyYes+KeyNo,wfOctogone+wiExit,CurrKrs.WarningWin)=kbYes)Then Goto DoneProcess;
     End;
    End;
NextLine:
   End;
   If J mod YWM<YWM-1Then Begin
    For I:=J mod(YWM)to YWM-1do PrnLn;
    If(Info.Page<>ptNone)Then Begin
     PrnPageNm;
     PrnLn;
    End;
    For I:=Q.SheetFormat.Y2+1to PageLen-1do PrnLn;
   End;
  End;
 End;
DoneProcess:
 WEDone(LL);
FreeMtx:
 FreeMemory(Mtx,4096);
 FreeMemory(OriginalMtx,SizeOfOriginalMtx);
ClsExit:
 If(InFile)Then FileClose(Handle);
 DonePrn;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                      Fonction RunSetPrn                      Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de choisir une param‚trage particulier de
 l'imprimante en fonction d'une ligne de param‚trage.
}

Function RunSetPrn;
Label Break;
Var
 I,M:Byte;
 O,TStr:String;
 Bar:Boolean;
Begin
 O:='';Param:=LTrim(Param);
 M:=MaxExtractExt(Param);
 If M>0Then Begin
  For I:=1to(M)do Begin
   TStr:=StrUp(ExtractExt(Param,I,Bar));
   If TStr='ESC'Then Prn(Chr(caEsc))Else
   If(Bar)Then Begin
    If(TStr='113LNS')or(TStr='113LINES')or(TStr='ESC1')Then Begin
     Prn(#27'1');
     AddStr(O,'Imprimante ajust‚ pour des pages standard de 113 lignes.'#13#10);
    End
     Else
    If(TStr='88LNS')or(TStr='88LINES')or(TStr='ESC0')Then Begin
     If(__SetPrnInterLn1_8)Then
      AddStr(O,'Imprimante ajust‚ pour des pages standard de 88 lignes.'#13#10);
    End
     Else
    If TStr='BOLD'Then Begin
     If(__SetPrnBold)Then AddStr(O,'Activation de l''impression en caractŠre gras.'#13#10);
    End
     Else
    If(TStr='COMP')or(TStr='COMPRESS')or(TStr='132COLNS')Then Begin
     If(__SetPrnCompress)Then AddStr(O,'Activation de 132 colonnes par lignes.'#13#10);
    End
     Else
    If(TStr='DBL')or(TStr='DOUBLE')Then Begin
     If(__SetPrnDouble)Then AddStr(O,'Activation de l''impression … chassis ‚largie.'#13#10);
    End
     Else
    If TStr='ITALIC'Then Begin
     If(__SetPrnItalic)Then AddStr(O,'Activation de l''italique.'#13#10);
    End
     Else
    If TStr='UNBOLD'Then Begin
     If(__SetPrnUnBold)Then AddStr(O,'D‚sactivation de l''impression en caractŠre gras.'#13#10);
    End
     Else
    If(TStr='UNDBL')or(TStr='UNDOUBLE')or(TStr='SIMPLE')Then Begin
     If(__SetPrnSimple)Then AddStr(O,'D‚sactivation de l''impression … chassis ‚largie.'#13#10);
    End
     Else
    If TStr='UNITALIC'Then Begin
     If(__SetPrnUnItalic)Then AddStr(O,'D‚sactivation de l''italique.'+psPrn.Ln);
    End
     Else
    Begin
     SysErr:=errUnknownParameter;
     Goto Break;
    End;
   End;
  End;
Break:
 End
  Else
 AddStr(O,'Erreur: ParamŠtre requis pour ajuster l''imprimante courante!'#13#10+
	   #13#10+
	   'SETPRN  [/88LINES][/BOLD][/DOUBLE][/ITALIC]'#13#10+
	   #9'[/SIMPLE][/UNDOUBLE][/UNITALIC]'#13#10+
	   #9'[/COMPRESS]');
 RunSetPrn:=O;
End;

Type
 DataSetupPrinters=Record
  XP:SelectPrn;
  PrnOutput:MListBox;
  Model:MListBox;
  StrCurrPrnPLen:String[20];
  StrCurrPrnPHeight:String[20];
  Mem:String[20];
  ModeWM:MCheckBox;
  P2P:MCheckBox;
  PrnMarge:MCheckBox;
  BorderPixel:MCheckBox;
  PrnMethode:Byte;
  PrnListPrn:MListBox;
  PrnType:Array[0..12]of Byte;{ Format d'impression }
 End;

Procedure SXPOnMove(Var L:LstMnu;Var Context);
Var
 Data:DataSetupPrinters Absolute Context;
 PE1,PE2:^ElementWins;
 R:^ResourceWindow Absolute CurrResWins;
Begin
 PE1:=_ALGetCurrBuf(R^.R);
 PE2:=_ALGetBuf(R^.R,R^.P);
 If(PE1<>PE2)Then Begin { Changement de sortie d'imprimante? }
  If(L.P<>PrnSetup[Data.PrnOutput.ItemIndex].Code)Then Begin
   L.P:=PrnSetup[Data.PrnOutput.ItemIndex].Code;
   LMRefresh(L);
   LMSelBarInactive(L);
  End;
 End
  Else
 Begin
   { Changement d'imprimante: }
  PrnSetup[Data.PrnOutput.ItemIndex].Code:=L.P;
 End;
End;

Function SetupPrinters:Boolean;
Var
 Data:DataSetupPrinters;
 R:Real;
 Err:Integer;
Begin
 SetupPrinters:=False;
 FillClr(Data,SizeOf(Data));
 Data.PrnOutput.LoadList:=POLoadList;
 Data.PrnOutput.Context:=@Data.PrnOutput;
 Data.StrCurrPrnPLen:=StrCurrPrnPLen+'"';
 Data.StrCurrPrnPHeight:=StrCurrPrnPHeight+'"';
 Data.Mem:=IntToStr(PrnSetup[PrnOutput].Mem)+'K';
 Data.ModeWM.Checked:=PrnSetup[PrnOutput].ModeWM;
 Data.P2P.Checked:=PrnSetup[PrnOutput].P2P;
 Data.PrnMarge.Checked:=PrnSetup[PrnOutput].PrnMarge;
 Data.BorderPixel.Checked:=PrnSetup[PrnOutput].BorderPixel;
 Data.Model.ItemIndex:=Data.PrnType[Data.PrnOutput.ItemIndex];
 Data.Model.LoadList:=XPLoadList;
 Data.Model.OnMove:=SXPOnMove;
 Data.Model.Context:=@Data;
{ Data.PrnMethode:=0;}
 If ExecuteAppDPU(81,Data.PrnOutput)Then Begin
  SetupPrinters:=True;
  PrnOutput:=Data.PrnOutput.ItemIndex;
  PrnSetup[PrnOutput].ModeWM:=Data.ModeWM.Checked;
  PrnSetup[PrnOutput].P2P:=Data.P2P.Checked;
  PrnSetup[PrnOutput].PrnMarge:=Data.PrnMarge.Checked;
  PrnSetup[PrnOutput].BorderPixel:=Data.BorderPixel.Checked;
  If Not(Data.StrCurrPrnPLen[Length(Data.StrCurrPrnPLen)]in ArabicDigit)Then
   BackStr(Data.StrCurrPrnPLen);
  ChgChr(Data.StrCurrPrnPLen,DeSep[0],'.');
  Val(Data.StrCurrPrnPLen,R,Err);
  PrnSetup[PrnOutput].PLen:=Trunc(R*10);
  If Not(Data.StrCurrPrnPHeight[Length(Data.StrCurrPrnPHeight)]in ArabicDigit)Then
   BackStr(Data.StrCurrPrnPHeight);
  ChgChr(Data.StrCurrPrnPHeight,DeSep[0],'.');
  Val(Data.StrCurrPrnPHeight,R,Err);
  PrnSetup[PrnOutput].PHeight:=Trunc(R*10);
  If Not(Data.Mem[Length(Data.Mem)]in ArabicDigit)Then BackStr(Data.Mem);
  PrnSetup[PrnOutput].Mem:=StrToWord(Data.Mem);
  UpDatePrinter;
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Procedure TEPrn                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure imprime le fichier (peut importer le format ASCII,
 Gat,...)  contenant  dans une variable  de format  ®RBuf¯.  Il  est
 construit sur l'objet ®Editeur¯.
}

Procedure TEPrn;
Label PS;
Var
 I:Word;
 J,EndJ,BeginJ:LongInt;
 Str:String;
 UStr:String;
 Info:InfoPrintRec;
 PC:PChr;
 NumSpc:Word;
 Rem:(rNone,rSmall,rLarge);
 OldPrnOutput:Byte;
Begin
{ If(InitPrn)Then} Begin
  OldPrnOutput:=PrnOutput;
  If(Q.Mode)in[vtHlp,vtGAT]Then PrnGatEdt(Q)
   Else
  Begin
   BeginJ:=0;EndJ:=Q.List.Count-1;NumSpc:=0;Info.Compress:=Q.StrMX>80;
   If WinPrnAscii(BeginJ,EndJ,NumSpc,Info.Compress)Then Begin
    InitPrn;
    If(Info.Compress)Then __SetPrnCompress;
    If((PrnSetup[PrnOutput].PHeight*6)div 10<EndJ)Then __SetPrnInterLn1_8;
    ALSetPtr(Q.List,BeginJ);
    If(Q.Mode=vtPas)Then Begin
     Rem:=rNone;
     For J:=BeginJ to(EndJ)do Begin
      PC:=_ALGetCurrBuf(Q.List);
      If Not IsPChrEmpty(PC)Then Begin
       Pritex.Prn(Spc(NumSpc));
       I:=0;
       While PC^[I]<>#0do Begin
        If(Rem=rSmall)Then Begin
         Prn(PC^[I]);
         If PC^[I]='}'Then Begin
          Rem:=rNone;
          __SetPrnUnItalic;
         End;
         Inc(I);
        End
         Else
        If(Rem=rLarge)Then Begin
         Prn(PC^[I]);
         Inc(I);
         If(PC^[I-1]='*')and(PC^[I]=')')Then Begin
          Prn(PC^[I]);
          Inc(I);
          Rem:=rNone;
          __SetPrnUnItalic;
         End;
        End
         Else
        Case PC^[I]of
         '{':Begin
          Rem:=rSmall;
          __SetPrnItalic;
          While Not(PC^[I]in[#0,'}'])do Begin;Prn(PC^[I]);Inc(I)End;
          If PC^[I]='}'Then Begin
           Prn(PC^[I]);Inc(I);
           Rem:=rNone;
           __SetPrnUnItalic;
          End;
         End;
         '(':Begin
          If PC^[I+1]='*'Then Begin
           __SetPrnItalic;
           Rem:=rLarge;
           Inc(I,2);
           Prn('(*');
           While PC^[I]<>#0do Begin
     	    If(PC^[I]='*')and(PC^[I+1]=')')Then Begin
      	     Inc(I,2);
	     Prn('*)');
             Rem:=rNone;
             __SetPrnUnItalic;
  	     Break;
	    End;
  	    Prn(PC^[I]);Inc(I);
           End;
          End
           Else
          Begin;Prn(PC^[I]);Inc(I)End;
         End;
         '[',']','\','/','-','<','>','*','+','^','&',')','.',',','?','=','%','@',':',';':
         Begin;Prn(PC^[I]);Inc(I)End;
          '#':Begin
          Prn(PC^[I]);Inc(I);
          Case PC^[I]of
           '$': Goto PS;
           Else While(PC^[I]in ArabicDigit)do Begin;Prn(PC^[I]);Inc(I)End;
          End;
         End;
         '$':Begin
       PS:Prn(PC^[I]);Inc(I);
          While(PC^[I]in ArabicXDigit)do Begin;Prn(PC^[I]);Inc(I)End;
         End;
         '0'..'9':Begin;Prn(PC^[I]);Inc(I)End;
         '''':Begin
          Prn(PC^[I]);Inc(I);
          While PC^[I]<>''''do Begin
           If PC^[I]=''''Then Begin
            Prn('''');Inc(I)
           End;
           If PC^[I]=#0Then Break;
           Prn(PC^[I]);Inc(I);
          End;
          If PC^[I]<>#0Then Begin;Prn(PC^[I]);Inc(I)End;
         End;
         'A'..'Z','a'..'z','_':Begin
          Str:=PXtrkWord(I,PC);
          UStr:=StrUp(Str);
          If(UStr='IMPLEMENTATION')or { Tous ces mots sont en double}
            (UStr='INTERFACE')or      { largeur de caractŠres.}
            (UStr='UNIT')or
            (UStr='PROGRAM')Then Begin
           __SetPrnDouble;
           Prn(Str);
           __SetPrnSimple;
          End
           Else
          If DBLocateAbsIM(Q.DBMainWord,2,UStr,[])Then Begin
           Prn(Str);
           Prn(MultChr(Char(caBS),Length(Str)));
           Prn(Str);
          End
           Else
          Begin
           Prn(Str);
           Prn(MultChr(Char(caBS),Length(Str)));
           Prn(MultChr('_',Length(Str)));
          End;
         End;
         Else Begin
          Prn(PC^[I]);
          Inc(I)
         End;
        End;
       End;
      End;
      PrnLn;
      ALNext(Q.List);
     End;
    End
     Else
    For J:=BeginJ to(EndJ)do Begin
     PC:=_ALGetCurrBuf(Q.List);
     If Not IsPChrEmpty(PC)Then Begin
      Pritex.Prn(Spc(NumSpc));
      Pritex.Prn(StrPas(PC))
     End;
     PrnLn;
     ALNext(Q.List);
    End;
    DonePrn;
   End;
  End;
  If(PrnOutput=poFile)Then PrnOutput:=OldPrnOutput;
  WriteLog('Impression de '+Q.EditName);
 End;
End;

Procedure UpDatePrinter;
Var
 Printers:DataSetInMemory;
 I:Byte;
Begin
 DBOpenServerName(ChantalServer,'CHANTAL:/Materiel/Imprimante.Dat');
 DBCopyToMemory(ChantalServer,Printers);
 For I:=0to 12do Begin
  Byte(PrnSetup[I].Mode):=Printers.Table^[Printers.Index^[PrnSetup[I].Code]+2];
 End;
 DBDispose(Printers);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                            Fonction WinPrint                          Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure affiche une boŒte de dialogue permettant … l'utilisateur
 de choisir  les paramŠtrages  …  donners  au  document  de format ®GAT¯ …
 imprimer (de la page … la page, num‚ro de page,...).
}

Procedure LoadFontListBox(Var L:LstMnu;Var Context);
Var
 DataDB:Record
  ID:Byte;
  HeightChar:Byte;
  Name:String;
 End;
 I:Integer;
Begin
 DBOpenServerName(ChantalServer,'CHANTAL:/Polices/IndexFont.Dat');
 DBFirst(ChantalServer);
 For I:=1to 36do Begin
  DBReadRec(ChantalServer,DataDB);
  ALAddStrWord(L.List,DataDB.Name,DataDB.ID);
 End;
End;

Procedure XPOnMove(Var L:LstMnu;Var Context);
Var
 Data:InfoPrintRec Absolute Context;
 PE1,PE2:^ElementWins;
 R:^ResourceWindow Absolute CurrResWins;
Begin
 PE1:=_ALGetCurrBuf(R^.R);
 PE2:=_ALGetBuf(R^.R,R^.P);
 If(PE1<>PE2)Then Begin
  If(L.P<>PrnSetup[Data.PrnOutput.ItemIndex].Code)Then Begin
   L.P:=PrnSetup[Data.PrnOutput.ItemIndex].Code;
   LMRefresh(L);
   LMSelBarInactive(L);
  End;
 End
  Else
 PrnSetup[Data.PrnOutput.ItemIndex].Code:=L.P;
End;

Function WinPrint;
Var
 L:Window;
Begin
 WinPrint:=False;
 FillClr(Data.XP,SizeOf(Data.XP));
 Data.Font.ItemIndex:=0;
 Data.Font.LoadList:=LoadFontListBox;
 Data.Font.OnMove:=NIL;
 Data.Font.Context:=NIL;
 Data.PrnOutput.ItemIndex:=$FFFF;
 Data.PrnOutput.LoadList:=POLoadList;
 Data.PrnOutput.OnMove:=NIL;
 Data.PrnOutput.Context:=@Data.PrnOutput;
 Data.Model.ItemIndex:=Data.PrnType[Data.PrnOutput.ItemIndex];
 Data.Model.LoadList:=XPLoadList;
 Data.Model.OnMove:=XPOnMove;
 Data.Model.Context:=@Data;
 WEPushEndBar(L);
 WEPutLastBar('^Tab^  Changer d''entr‚e  ^Enter^ Autorise l''impression  ^Esc^ Abandonner');
 If ExecuteAppDPU(60,Data.NumCopy)Then Begin
  WinPrint:=True;
  If Data.PrnOutput.ItemIndex<>$FFFFThen
   PrnOutput:=Data.PrnOutput.ItemIndex;
  If(Data.PrnOutput.ItemIndex=poFile)Then WinPrint:=PrnFileDialog;
 End;
 WEDone(L);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                            Fonction WinPrnAscii                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure affiche une boŒte de dialogue permettant … l'utilisateur
 de choisir les paramŠtrages … donner au texte … imprimer.
}

Function WinPrnAscii;
Var
 Data:Record
  Start,_End:LongInt;
  Merge:Word;
  Compress:MCheckBox;
 End;
Begin
 WinPrnAscii:=False;
 FillClr(Data,SizeOf(Data));
 Data.Start:=Start;
 Data._End:=_End;
 Data.Merge:=Merge;
 Data.Compress.Checked:=Compress;
 If ExecuteAppDPU(27,Data)Then Begin
  WinPrnAscii:=True;
  Start:=Data.Start;
  _End:=Data._End;
  Merge:=Data.Merge;
  Compress:=Data.Compress.Checked;
  If(prnOutput=poFile)Then WinPrnAscii:=PrnFileDialog;
 End;
End;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
END.