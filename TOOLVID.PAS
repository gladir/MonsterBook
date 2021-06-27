{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                                                                         Û
 ³                      Malte Genesis/Outils Vid‚o                         Û
 ³                                                                         Û
 ³            dition Chantal pour Mode R‚el/IV - Version 1.1              Û
 ³                              1994/12/29                                 Û
 ³                                                                         Û
 ³          Tous droits r‚serv‚s par les Chevaliers de Malte (C)           Û
 ³                                                                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Nom du programmeur
 ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ

  Sylvain Maltais
}

Unit ToolVid;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                                INTERFACE
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

{$I DEF.INC}
{$IFDEF Overlay}
 {$O+,F+}
{$ENDIF}

Uses Systex;

Procedure VideoInfo(Nm:Byte);
Function  VideoSetup:Boolean;
Procedure DxDiag;

Function SelectVideoCard(X1,Y1,X2,Y2:Byte):Byte;
Function SelectVideoMode(X1,Y1,X2,Y2:Byte;ModeType:VideoModeType):Word;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                               IMPLEMENTATION
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Uses
 Adele,Terminal,Mouse,Memories,Systems,Isatex,Video,Dials,
 ResTex,ResLoadI,ResServI,ToolView,Dialex,DialPlus,
 ResServD,Registry,Time;

Function ALAddModeTextWord(Var Inf:ArrayList;X,Y:Byte;_Type:Char;Value:Word):Boolean;Near;
Var
 S:String;
Begin
 S:='Texte '+IntToStr(X)+'x'+IntToStr(Y)+', ';
 Case _Type of
  'C': Systems.AddStr(S,'16 couleurs');
  'M': Systems.AddStr(S,'Monochrome');
  Else Systems.AddStr(S,'noir & blanc');
 End;
 ALAddModeTextWord:=ALAddStrWord(Inf,S,Value);
End;

Function SelectVideoCard(X1,Y1,X2,Y2:Byte):Byte;
Var
 R:Byte;
 M:LstMnu;
 I:Byte;
 SizeOf_:Array[0..vnMax]of Word;
 PC:Array[0..vnMax]of PChr;
Begin
 LMInit(M,X1,Y1,X2,Y2,'S‚lecte Carte Vid‚o',CurrKrs.Dialog.Window);
 For I:=0to(vnMax)do Begin
  PC[I]:=AllocFunc(I,'SYS:FRANCAIS.*',SizeOf_[I]);
  ALAddPChrByte(M.List,PC[I],I);
 End;
 SelectVideoCard:=0;
 R:=LMRun(M);
 For I:=0to(vnMax)do FreeMemory(PC[I],SizeOf_[I]);
 If R>0Then Begin
  If(WarningMsgYesNo('Etˆs-vous certain de vouloir changer '+
		     'la configuration de carte vid‚o ?')=kbYes)Then
  SelectVideoCard:=R;
 End;
 LMDone(M);
End;

Procedure SMLoadList(Var List:LstMnu;Var Context);
Var
 I:Byte;
 Q:DataSet;
 Chr:Char;
 ModeType:VideoModeType Absolute Context;
 Data:Record
  Mode:Word;
  Graphic:Boolean;
  Monochrome:Boolean;
  TextWidth:Byte;
  TextHeight:Byte;
  NumXPixels:Word;
  NumYPixels:Word;
  BitsPerPixel:Byte;
 End;
Begin
 If(ModeType)in[vmtTxt,vmt2]Then Begin
  DBInit(Q,MaltePath+'DATA\MATERIEL\VIDEOMOD.DAT');
  For I:=0to NumModeSupport-1do Begin
   Case ModeSupport^[I]of
    vmNone: Break;
    vmTxtBW40: ALAddModeTextWord(List.List,40,25,'B',vmTxtBW40+$F000);
    vmHerc: ALAddStrWord(List.List,'Hercule (720x348)',vmHerc);
    Else Begin
     If DBLocateAbs(Q,0,ModeSupport^[I],[])Then Begin
      DBReadRec(Q,Data);
      If(Data.Graphic)Then Begin
       ALAddStrWord(List.List,'Graphiques '+CStr(Data.NumXPixels)+'x'+CStr(Data.NumYPixels)+', '+
                     CStr(1 shl Long(Data.BitsPerPixel))+' couleurs',ModeSupport^[I]);
      End
       Else
      Begin
       If(Data.Monochrome)Then Chr:='M'Else
       If Data.BitsPerPixel=1Then Chr:='B'
                             Else Chr:='C';
       ALAddModeTextWord(List.List,Data.TextWidth,Data.TextHeight,Chr,ModeSupport^[I]);
      End;
     End;
    End;
   End;
  End;
  DBDone(Q);
 End;
{ LMGotoPos(List,GetVideoMode);}
End;

Function SelectVideoMode;
Var
 Form:Record
  Mode:MListBox;
 End;
 List:LstMnu;
 I:Byte;
 K:Word;
 Ok:Boolean;
 Chr:Char;
 Q:DataSet;
 Data:Record
  Mode:Word;
  Graphic:Boolean;
  Monochrome:Boolean;
  TextWidth:Byte;
  TextHeight:Byte;
  NumXPixels:Word;
  NumYPixels:Word;
  BitsPerPixel:Byte;
 End;
Begin
 SelectVideoMode:=vmNone;
 FillClr(Form,SizeOf(Form));
 {Form.Mode.ItemIndex:=GetVideoMode;}
 Form.Mode.LoadList:=SMLoadList;
 Form.Mode.Context:=@ModeType;
 If ExecuteAppDPU(159,Form)Then Begin
  Case(Form.Mode.ItemIndex)of
   0:;
   vmTxtBW40+$F000:SelectVideoMode:=vmTxtBW40;
   Else SelectVideoMode:=Form.Mode.ItemIndex;
  End;
 End;
End;

Function GetStrVesaWindow(Attr:Byte;Seg:Word):String;
Var
 S:String;
Begin
 If Attr and 1=1Then Begin
  S:='Existe, ';
  Case Attr and 6of
   0:AddStr(S,'AccŠs interdit');
   2:AddStr(S,'AccŠs lecture seulement');
   4:AddStr(S,'AccŠs ‚criture seulement');
   6:AddStr(S,'AccŠs lecture et ‚criture');
  End;
  If Attr and 6>0Then AddStr(S,' au segment '+HexWord2Str(Seg)+'h');
 End
  Else
 S:='Absente';
 GetStrVesaWindow:=S;
End;

Procedure VideoInfo;
Var
 Data:Record
  IsPrim:Boolean;
  CaptionCard:String[50];
  CaptionCatCard:String[20];
  CaptionMonitor:String[50];
  CaptionBiosCard:String[50];
  CaptionMemory:String[50];
  CaptionSizeDAC:String[40];
  CaptionAccessRAM:String[50];
  CaptionCurrMode:String[50];
  CaptionBiosSupport:String[3];
  CaptionNumPages:String[40];
  CaptionMatrix:String[40];
  CaptionCharSize:String[20];
  InfoVesa:Boolean;
  CaptionOptionInfo:String[3];
  CaptionVesaBIOSSupport:String[3];
  CaptionMode:String[25];
  CaptionGranulation:String[15];
  CaptionWindowSize:String[15];
  CaptionBytesPerScanLine:String[15];
  CaptionWindowA:String[50];
  CaptionWindowB:String[50];
  CaptionPointer:String[15];
  InfoOEM:Boolean;
  CaptionScreenSize:String[40];
  CaptionCharSizeOEM:String[10];
  CaptionMemPlanes:String[10];
  CaptionBitsPerPixel:String[10];
  CaptionMemoryModel:String[50];
  CaptionNumBank:String[10];
  CaptionSizeOfBank:String[10];
  Key:Byte;
 End;
 DBData:Record
  ID:Byte;
  Caption:String;
 End;
 Size:LongInt;
 _PVid:Array[0..1]of PIV;
 PVid:PIV Absolute _PVid;
 _IVid:Array[0..1]of MIV;
 IVid:MIV Absolute _IVid;
 Vesa:Systex.VesaInfo;
 VesaPtr:Pointer;
Begin
 FillClr(Data,SizeOf(Data));
 GetPIV(_PVid[0]);
 GetPIVSec(_PVid[1]);
 GetMIV(_IVid[0]);
 Data.IsPrim:=_PVid[1].Card=0;
 Data.InfoVesa:=_PVid[Nm].Vesa;
 If Nm=1Then Begin
  If _PVid[1].Card=0Then Begin
   ErrNoMsgOk(ErrSecVideoNotFound);
   Exit;
  End;
  PVid:=_PVid[1];
  IVid:=_IVid[1];
 End;
 DBOpenServerName(ChantalServer,'CHANTAL:/Materiel/IDVideo.Dat');
 If DBLocateAbs(ChantalServer,0,PVid.Card,[])Then Begin
  DBReadRec(ChantalServer,DBData);
  Data.CaptionCard:=DBData.Caption;
 End;
 Case(PVid.CardCat)of
  cvnVesa:Data.CaptionCatCard:='Super VGA (VESA)';
  cvnSvga:Data.CaptionCatCard:='Super VGA';
  cvnVGA:Data.CaptionCatCard:='VGA';
  cvnEGA:Data.CaptionCatCard:='EGA';
  cvnCGA:Data.CaptionCatCard:='CGA';
  cvnHGC:Data.CaptionCatCard:='Hercule';
  cvnMDA:Data.CaptionCatCard:='MDA';
 End;
 DBOpenServerName(ChantalServer,'CHANTAL:/Materiel/IDMoniteur.Dat');
 If DBLocateAbs(ChantalServer,0,PVid.Monitor,[])Then Begin
  DBReadRec(ChantalServer,DBData);
  Data.CaptionMonitor:=DBData.Caption;
 End;
 If PVid.ROM=0Then Data.CaptionBiosCard:='Inexistant'
  Else
 Begin
  Data.CaptionBiosCard:=HexWord2Str(PVid.ROM)+'h';
  If PVid.RomBits>0Then AddStr(Data.CaptionBiosCard,';'+BasicStr(PVid.RomBits)+'-bits');
 End;
 Data.CaptionMemory:=CStr(PVid.Memory shr 10)+' Ko ';
 If(_PVid[Nm].EGA)and(VSwpInit)Then Begin
  AddStr(Data.CaptionMemory,'(Libre:'+CStrBasic(AppResFree(rmVRAM)
         {$IFDEF HeapVram}+(VMemAvail shr 10){$ENDIF})+' Ko)');
 End;
 If PVid.DacBits=0Then AddStr(Data.CaptionSizeDAC,'Non-programmable sur cette carte')
 Else AddStr(Data.CaptionSizeDAC,IntToStr(GetVideoBitsDac*3)+'-bits ('+
             CStr(1shl Long(GetVideoBitsDac*3))+' variantes de couleurs)');
 Case(IVid.Graphics)of
  True:Case(IVid.BitsPerPixel)of
   4: Size:=(IVid.NumXPixels*IVid.NumYPixels) shr 11;
   8: Size:=LongInt(Long(IVid.NumXPixels)*Long(IVid.NumYPixels)) shr 10;
   Else Size:=GetVideoScrSize shr 10;
  End;
  Else
  Begin
   Size:=(IVid.NumXTexts*IVid.NumYTexts)*2;
   If Size and 1023>0Then Size:=(Size shr 10)+1
                     Else Size:=Size shr 10;
  End;
 End;
 If PVid.VideoBits=0Then Data.CaptionAccessRAM:='Probablement 8-bits...'
	            Else Data.CaptionAccessRAM:=WordToStr(PVid.VideoBits)+'-bits';
 AddStr(Data.CaptionAccessRAM,', Segment: '+HexWord2Str(IVid.SegVideo)+'h');
 Case(IVid.Graphics)of
  False:Begin
   Data.CaptionCurrMode:='Texte'+BasicStr(IVid.NumXTexts)+'x'+
                         IntToStr(IVid.NumYTexts);
   Case(IsMono)of
    True:AddStr(Data.CaptionCurrMode,', mono');
    Else AddStr(Data.CaptionCurrMode,', 16 couleurs');
   End;
  End;
  Else Begin
   Data.CaptionCurrMode:='Graphiques'+CStrBasic(NmXPixels)+'x'+CStr(NmYPixels)+','+
        		 BasicStr(Long(1 shl Long(BitsPerPixel)))+' couleurs';
  End;
 End;
 If(IsVideoModeBios)Then Data.CaptionBiosSupport:='Oui'
                    Else Data.CaptionBiosSupport:='Non';
 Data.CaptionNumPages:=IntToStr((PVid.Memory shr 10)div Size);
 AddStr(Data.CaptionNumPages,' (Taille:'+BasicStr(Size)+' Ko)');
 If(PVid.Font)Then Begin
  Data.CaptionMatrix:='Oui, Nom de la police: ';
  If(Length(CurrMtx)=0)or(CurrMtx='STD')Then AddStr(Data.CaptionMatrix,'Standard')Else
  If CurrMtx='APPLICAT'Then AddStr(Data.CaptionMatrix,'Application')
		       Else AddStr(Data.CaptionMatrix,CurrMtx);
 End
  Else
 Data.CaptionMatrix:='Non';
 Data.CaptionCharSize:='8x'+IntToStr(IVid.HeightChar);
 If(Data.InfoVesa)Then Begin
  VesaPtr:=@Vesa;
  ASM
   MOV AX,4F03h
   INT 10h
   MOV CX,BX
   MOV AX,4F01h
   LES DI,VesaPtr
   INT 10h
  END;
  If(viOEM)in(Vesa.Mode.X)Then Data.CaptionOptionInfo:='Oui'
                          Else Data.CaptionOptionInfo:='Non';
  If(viBIOS)in(Vesa.Mode.X)Then Data.CaptionVesaBIOSSupport:='Oui'
                           Else Data.CaptionVesaBIOSSupport:='Non';
  If(viColor)in(Vesa.Mode.X)Then Data.CaptionMode:='Couleur'
                            Else Data.CaptionMode:='Monochrome';
  AddStr(Data.CaptionMode,', ');
  If(viGraf)in(Vesa.Mode.X)Then AddStr(Data.CaptionMode,'Graphique')
                           Else AddStr(Data.CaptionMode,'Texte');
  Data.CaptionGranulation:=CStr(Vesa.Granularity)+' Ko';
  Data.CaptionWindowSize:=CStr(Vesa.WindowSize)+' Ko';
  Data.CaptionBytesPerScanLine:=CStr(Vesa.BytesPerScanLine);
  Data.CaptionWindowA:=GetStrVesaWindow(Vesa.WindowAAttr,Vesa.SegWinA);
  Data.CaptionWindowB:=GetStrVesaWindow(Vesa.WindowBAttr,Vesa.SegWinB);
  If(Vesa.WinPos=NIL)Then Data.CaptionPointer:='NIL'
   Else
  Begin
   Data.CaptionPointer:=HexWord2Str(PtrRec(Vesa.WinPos).Seg)+'h:'+
                        HexWord2Str(PtrRec(Vesa.WinPos).Ofs)+'h';
  End;
 End;
 Data.InfoOEM:=(viOEM)in(Vesa.Mode.X);
 If(Data.InfoOEM)Then Begin
  Data.CaptionScreenSize:=WordToStr(Vesa.L)+'x'+WordToStr(Vesa.H)+' ';
  If(viGraf)in(Vesa.Mode.X)Then AddStr(Data.CaptionScreenSize,'pixels')
                           Else AddStr(Data.CaptionScreenSize,'caractŠres');
  Data.CaptionCharSizeOEM:=WordToStr(Vesa.LC)+'x'+WordToStr(Vesa.HC);
  Data.CaptionMemPlanes:=WordToStr(Vesa.NumMemPlanes);
  Data.CaptionBitsPerPixel:=WordToStr(Vesa.BitsPerPixel);
  Case(Vesa.MemoryType)of
   0:Data.CaptionMemoryModel:='Texte';
   1:Data.CaptionMemoryModel:='Graphiques en CGA';
   2:Data.CaptionMemoryModel:='Graphiques en Hercule';
   3:Data.CaptionMemoryModel:='Graphiques en EGA en 16 couleurs';
   4:Data.CaptionMemoryModel:='Graphiques avec les pixels organis‚ en ordre';
   5:Data.CaptionMemoryModel:='Graphiques en s‚quence 256 couleurs (non-chain 4)';
   6:Data.CaptionMemoryModel:='Couleurs directe (HauteCouleur)';
   7:Data.CaptionMemoryModel:='YUV (YIQ)';
   $10..$FF:Data.CaptionMemoryModel:='OEM';
   Else Data.CaptionMemoryModel:='VESA inconnu??';
  End;
  Data.CaptionNumBank:=CStr(Vesa.NumBanks);
  Data.CaptionSizeOfBank:=CStr(Vesa.SizeOfBank)+' Ko';
 End;
 ExecuteAppDPU(68,Data);
End;

(*Procedure VideoSetup;
Var W:Wins;LC,MC,CA,SC,SC2,FC:LstMnu;I,P:Byte;Chr:Char;SizeOf_,K:Wd;PC:PChr;
    ChkModeSupport:Procedure(Info1,Info2:PIV;Var Buf1,Buf2:PaletteMode);
    Ptr:Pointer Absolute ChkModeSupport;
    Mode,Mode2:PaletteMode; PBuffer:Array[Byte]of Char;
    PVid1T,PVid2T:PIV; Color,OldColor:Byte;

 Procedure UpDateColor;Begin
  WESetChr(W,21+(OldColor and$F)*3,12,' ');
  WESetChr(W,21+(Color and$F)*3,12,#254);
  WESetChr(W,21+(OldColor shr 4)*3,13,' ');
  WESetChr(W,21+(Color shr 4)*3,13,#254);
  WEBarSelHor(W,20,14,67);
 End;

 Procedure PushColor;Begin
  Case LMGetVal(CA)of
   1: Case LMGetVal(SC)of
       1: Color:=CurrKrs.Menu.Normal;
       2: Color:=CurrKrs.Menu.High;
       3: Color:=CurrKrs.Menu.Select;
      End;
   2: Case LMGetVal(SC)of
       1: Color:=CurrKrs.Dialog.Wins.Title;
       2: Color:=CurrKrs.Dialog.Wins.Border;
       3: Color:=CurrKrs.Dialog.Wins.Icon;
       4: Color:=CurrKrs.Dialog.Wins.Sel;
       5: Color:=CurrKrs.Dialog.Wins.High;
       6: Color:=CurrKrs.Dialog.Wins.Key;
       7: Color:=CurrKrs.Dialog.Wins.kShade;
       8: Color:=CurrKrs.Dialog.Wins.kSel;
       9: Color:=CurrKrs.Dialog.Env.BarSelInactive;
       10: Color:=CurrKrs.Dialog.Env.BarSelect;
      End;
   3: Case LMGetVal(SC)of
       1: Color:=CurrKrs.ErrorWin.Wins.Title;
       2: Color:=CurrKrs.ErrorWin.Wins.Border;
       3: Color:=CurrKrs.ErrorWin.Wins.Msg;
       4: Color:=CurrKrs.ErrorWin.Wins.KeyActif;
       5: Color:=CurrKrs.ErrorWin.Wins.KeyUnactif;
       6: Color:=CurrKrs.ErrorWin.Wins.KeyShade;
       7: Color:=CurrKrs.ErrorWin.Env.Input;
      End;
   4: Case LMGetVal(SC)of
       1: Color:=CurrKrs.WarningWin.Title;
       2: Color:=CurrKrs.WarningWin.Border;
       3: Color:=CurrKrs.WarningWin.Msg;
       4: Color:=CurrKrs.WarningWin.KeyActif;
       5: Color:=CurrKrs.WarningWin.KeyUnactif;
       6: Color:=CurrKrs.WarningWin.KeyShade;
      End;
   5: Case LMGetVal(SC)of
       1: Color:=CurrKrs.RemWin.Title;
       2: Color:=CurrKrs.RemWin.Border;
       3: Color:=CurrKrs.RemWin.Msg;
       4: Color:=CurrKrs.RemWin.KeyActif;
       5: Color:=CurrKrs.RemWin.KeyUnactif;
       6: Color:=CurrKrs.RemWin.KeyShade;
      End;
   6: Case LMGetVal(SC)of
       1: Color:=CurrKrs.OpenWin.Wins.Title;
       2: Color:=CurrKrs.OpenWin.Wins.Border;
       3: Color:=CurrKrs.OpenWin.Wins.Icon;
       4: Color:=CurrKrs.OpenWin.Wins.Sel;
       5: Color:=CurrKrs.OpenWin.Wins.High;
       6: Color:=CurrKrs.OpenWin.Wins.Key;
       7: Color:=CurrKrs.OpenWin.Wins.kShade;
       8: Color:=CurrKrs.OpenWin.Wins.kSel;
       9: Color:=CurrKrs.OpenWin.Env.Input;
       10: Color:=CurrKrs.OpenWin.Env.Dir;
      End;
   7: Case LMGetVal(SC)of
       1: Color:=CurrKrs.MalteDos.Wins.Title;
       2: Color:=CurrKrs.MalteDos.Wins.Border;
       3: Color:=CurrKrs.MalteDos.Wins.Icon;
       4: Color:=CurrKrs.MalteDos.Wins.Sel;
       5: Color:=CurrKrs.MalteDos.Wins.High;
       6: Color:=CurrKrs.MalteDos.Wins.Key;
       7: Color:=CurrKrs.MalteDos.Wins.kShade;
       8: Color:=CurrKrs.MalteDos.Wins.kSel;
       9: Color:=CurrKrs.MalteDos.Env.Default;
       10: Color:=CurrKrs.MalteDos.Env.Prompt;
      End;
   8: Case LMGetVal(SC)of
       1: Color:=CurrKrs.Editor.Wins.Title;
       2: Color:=CurrKrs.Editor.Wins.Border;
       3: Color:=CurrKrs.Editor.Wins.Icon;
       4: Color:=CurrKrs.Editor.Wins.Sel;
       5: Color:=CurrKrs.Editor.Wins.High;
       6: Color:=CurrKrs.Editor.Wins.Key;
       7: Color:=CurrKrs.Editor.Wins.kShade;
       8: Color:=CurrKrs.Editor.Wins.kSel;
       9: Color:=CurrKrs.Editor.Env.BarInfo;
      10: Color:=CurrKrs.Editor.Env.Default;
      11: Color:=CurrKrs.Editor.Env.Rem;
      12: Color:=CurrKrs.Editor.Env.ResWord;
      13: Color:=CurrKrs.Editor.Env.Chars;
      14: Color:=CurrKrs.Editor.Env.Symbol;
      15: Color:=CurrKrs.Editor.Env.AsmInst;
      16: Color:=CurrKrs.Editor.Env.Number;
      17: Color:=CurrKrs.Editor.Env.Z;
      18: Color:=CurrKrs.Editor.Env.Normal;
      19: Color:=CurrKrs.Editor.Env.Pos;
      20: Color:=CurrKrs.Editor.Env.Insert;
      21: Color:=CurrKrs.Editor.Env.Modified;
      End;
   9: Case LMGetVal(SC)of
       1: Color:=CurrKrs.PersonalJournal.Wins.Title;
       2: Color:=CurrKrs.PersonalJournal.Wins.Border;
       3: Color:=CurrKrs.PersonalJournal.Wins.Icon;
       4: Color:=CurrKrs.PersonalJournal.Wins.Sel;
       5: Color:=CurrKrs.PersonalJournal.Wins.High;
       6: Color:=CurrKrs.PersonalJournal.Wins.Key;
       7: Color:=CurrKrs.PersonalJournal.Wins.kShade;
       8: Color:=CurrKrs.PersonalJournal.Wins.kSel;
       9: Color:=CurrKrs.PersonalJournal.Env.BarInfo;
      10: Color:=CurrKrs.PersonalJournal.Env.Default;
      11: Color:=CurrKrs.PersonalJournal.Env.Pos;
      12: Color:=CurrKrs.PersonalJournal.Env.Insert;
      End;
  End;
 End;

 Procedure UpDateSC;Begin
  LMDone(SC);
  WESubList(W,45,6,67,11,'Sous-Cat‚gorie',SC);
  Case LMGetVal(CA)of
   1:Begin{Menu}
    RBAddStrByte(SC.X,'Normal',1);
    RBAddStrByte(SC.X,'Haute',2);
    RBAddStrByte(SC.X,'Selecte',3);
   End;
   2:Begin{Dialog}
    RBAddStrByte(SC.X,'Titre',1);
    RBAddStrByte(SC.X,'Bordure',2);
    RBAddStrByte(SC.X,'Icon',3);
    RBAddStrByte(SC.X,'Bar de s‚lection',4);
    RBAddStrByte(SC.X,'Texte important',5);
    RBAddStrByte(SC.X,'Bouton',6);
    RBAddStrByte(SC.X,'Ombre de bouton',7);
    RBAddStrByte(SC.X,'Bouton s‚lectionn‚',8);
    RBAddStrByte(SC.X,'S‚lection inactive',9);
    RBAddStrByte(SC.X,'S‚lection',10);
   End;
   3:Begin{Error}
    RBAddStrByte(SC.X,'Titre',1);
    RBAddStrByte(SC.X,'Bordure',2);
    RBAddStrByte(SC.X,'Message',3);
    RBAddStrByte(SC.X,'Bouton actif',4);
    RBAddStrByte(SC.X,'Bouton inactif',5);
    RBAddStrByte(SC.X,'Ombre de Bouton',6);
    RBAddStrByte(SC.X,'Question',7);
   End;
   4,5:Begin{Warning/Rem}
    RBAddStrByte(SC.X,'Titre',1);
    RBAddStrByte(SC.X,'Bordure',2);
    RBAddStrByte(SC.X,'Message',3);
    RBAddStrByte(SC.X,'Bouton actif',4);
    RBAddStrByte(SC.X,'Bouton inactif',5);
    RBAddStrByte(SC.X,'Ombre de Bouton',6);
   End;
   6:Begin{OpenWin}
    RBAddStrByte(SC.X,'Titre',1);
    RBAddStrByte(SC.X,'Bordure',2);
    RBAddStrByte(SC.X,'Icon',3);
    RBAddStrByte(SC.X,'Bar de s‚lection',4);
    RBAddStrByte(SC.X,'Texte important',5);
    RBAddStrByte(SC.X,'Bouton',6);
    RBAddStrByte(SC.X,'Ombre de bouton',7);
    RBAddStrByte(SC.X,'Bouton s‚lectionn‚',8);
    RBAddStrByte(SC.X,'Question',9);
    RBAddStrByte(SC.X,'Fichier',10);
   End;
   7:Begin{Dos}
    RBAddStrByte(SC.X,'Titre',1);
    RBAddStrByte(SC.X,'Bordure',2);
    RBAddStrByte(SC.X,'Icon',3);
    RBAddStrByte(SC.X,'Bar de s‚lection',4);
    RBAddStrByte(SC.X,'Texte important',5);
    RBAddStrByte(SC.X,'Bouton',6);
    RBAddStrByte(SC.X,'Ombre de bouton',7);
    RBAddStrByte(SC.X,'Bouton s‚lectionn‚',8);
    RBAddStrByte(SC.X,'D‚faut',9);
    RBAddStrByte(SC.X,'Prompt',10);
   End;
   8:Begin{Editor}
    RBAddStrByte(SC.X,'Titre',1);
    RBAddStrByte(SC.X,'Bordure',2);
    RBAddStrByte(SC.X,'Icon',3);
    RBAddStrByte(SC.X,'Bar de s‚lection',4);
    RBAddStrByte(SC.X,'Texte important',5);
    RBAddStrByte(SC.X,'Bouton',6);
    RBAddStrByte(SC.X,'Ombre de bouton',7);
    RBAddStrByte(SC.X,'Bouton s‚lectionn‚',8);
    RBAddStrByte(SC.X,'Bar Information',9);
    RBAddStrByte(SC.X,'Ecriture par D‚faut',10);
    RBAddStrByte(SC.X,'Remarques',11);
    RBAddStrByte(SC.X,'Mots r‚serv‚s',12);
    RBAddStrByte(SC.X,'CaractŠre(s)',13);
    RBAddStrByte(SC.X,'Symbole',14);
    RBAddStrByte(SC.X,'Assembleur',15);
    RBAddStrByte(SC.X,'Nombre',16);
    RBAddStrByte(SC.X,'CaractŠre sp‚ciaux',17);
    RBAddStrByte(SC.X,'Normal',18);
    RBAddStrByte(SC.X,'Position',19);
    RBAddStrByte(SC.X,'Insertion',20);
    RBAddStrByte(SC.X,'Modifi‚',21);
   End;
   9:Begin{PJ}
    RBAddStrByte(SC.X,'Titre',1);
    RBAddStrByte(SC.X,'Bordure',2);
    RBAddStrByte(SC.X,'Icon',3);
    RBAddStrByte(SC.X,'Bar de s‚lection',4);
    RBAddStrByte(SC.X,'Texte important',5);
    RBAddStrByte(SC.X,'Bouton',6);
    RBAddStrByte(SC.X,'Ombre de bouton',7);
    RBAddStrByte(SC.X,'Bouton s‚lectionn‚',8);
    RBAddStrByte(SC.X,'Bar information',9);
    RBAddStrByte(SC.X,'Ecriture par d‚faut',10);
    RBAddStrByte(SC.X,'Position',11);
    RBAddStrByte(SC.X,'Insertion',12);
   End;
   10:Begin{ViewAscii}
    RBAddStrByte(SC.X,'Titre',1);
    RBAddStrByte(SC.X,'Bordure',2);
    RBAddStrByte(SC.X,'Icon',3);
    RBAddStrByte(SC.X,'Bar de s‚lection',4);
    RBAddStrByte(SC.X,'Texte important',5);
    RBAddStrByte(SC.X,'Bouton',6);
    RBAddStrByte(SC.X,'Ombre de bouton',7);
    RBAddStrByte(SC.X,'Bouton s‚lectionn‚',8);
    RBAddStrByte(SC.X,'Bar Information',9);
    RBAddStrByte(SC.X,'Ecriture par D‚faut',10);
    RBAddStrByte(SC.X,'Remarques',11);
    RBAddStrByte(SC.X,'Mots r‚serv‚s',12);
    RBAddStrByte(SC.X,'CaractŠre(s)',13);
    RBAddStrByte(SC.X,'Symbole',14);
    RBAddStrByte(SC.X,'Assembleur',15);
    RBAddStrByte(SC.X,'Nombre',16);
    RBAddStrByte(SC.X,'CaractŠre sp‚ciaux',17);
    RBAddStrByte(SC.X,'Normal',18);
    RBAddStrByte(SC.X,'Position',19);
    RBAddStrByte(SC.X,'Insertion',20);
    RBAddStrByte(SC.X,'Modifi‚',21);
   End;
   11:Begin{HexView}
    RBAddStrByte(SC.X,'Titre',1);
    RBAddStrByte(SC.X,'Bordure',2);
    RBAddStrByte(SC.X,'Icon',3);
    RBAddStrByte(SC.X,'Bar de s‚lection',4);
    RBAddStrByte(SC.X,'Texte important',5);
    RBAddStrByte(SC.X,'Bouton',6);
    RBAddStrByte(SC.X,'Ombre de bouton',7);
    RBAddStrByte(SC.X,'Bouton s‚lectionn‚',8);
    RBAddStrByte(SC.X,'Question',9);
   End;
   12:Begin{EditButt}
    RBAddStrByte(SC.X,'Titre',1);
    RBAddStrByte(SC.X,'Bordure',2);
    RBAddStrByte(SC.X,'Icon',3);
    RBAddStrByte(SC.X,'Bar de s‚lection',4);
    RBAddStrByte(SC.X,'Texte important',5);
    RBAddStrByte(SC.X,'Bouton',6);
    RBAddStrByte(SC.X,'Ombre de bouton',7);
    RBAddStrByte(SC.X,'Bouton s‚lectionn‚',8);
   End;
   13:Begin{Dial}
    RBAddStrByte(SC.X,'Titre',1);
    RBAddStrByte(SC.X,'Bordure',2);
    RBAddStrByte(SC.X,'Icon',3);
    RBAddStrByte(SC.X,'Bar de s‚lection',4);
    RBAddStrByte(SC.X,'Texte important',5);
    RBAddStrByte(SC.X,'Bouton',6);
    RBAddStrByte(SC.X,'Ombre de bouton',7);
    RBAddStrByte(SC.X,'Bouton s‚lectionn‚',8);
    RBAddStrByte(SC.X,'S‚lection',9);
    RBAddStrByte(SC.X,'S‚lection inactive',10);
    RBAddStrByte(SC.X,'Num‚ro',11);
   End;
   14:Begin{Draw}
    RBAddStrByte(SC.X,'Titre',1);
    RBAddStrByte(SC.X,'Bordure',2);
    RBAddStrByte(SC.X,'Icon',3);
    RBAddStrByte(SC.X,'Bar de s‚lection',4);
    RBAddStrByte(SC.X,'Texte important',5);
    RBAddStrByte(SC.X,'Bouton',6);
    RBAddStrByte(SC.X,'Ombre de bouton',7);
    RBAddStrByte(SC.X,'Bouton s‚lectionn‚',8);
   End;
   15:Begin{Help}
    RBAddStrByte(SC.X,'Titre',1);
    RBAddStrByte(SC.X,'Bordure',2);
    RBAddStrByte(SC.X,'Icon',3);
    RBAddStrByte(SC.X,'Bar de s‚lection',4);
    RBAddStrByte(SC.X,'Texte important',5);
    RBAddStrByte(SC.X,'Bouton',6);
    RBAddStrByte(SC.X,'Ombre de bouton',7);
    RBAddStrByte(SC.X,'Bouton s‚lectionn‚',8);
   End;
  End;
  PushColor;
  UpDateColor;
  LMRefresh(SC);
  LMSelBarInactive(SC);
 End;

Begin
(* OldColor:=0;PVid1T:=_PVid1;PVid2T:=_PVid2;
 WEInitO(W,70,19);
 WEPushWn(W);
 WEPutWnKrDials(W,'Configuration Vid‚o Primaire');
 SetShade(No);
 WESubList(W,0,0,33,4,'Carte Vid‚o',LC);
 For I:=0to vnMax do Begin
  PC:=AllocLangFunc(I,SizeOf_);
  RBAddPChrByte(LC.X,PC,I);
 End;
 LC.P:=_PVid1.Card;
 LMPutSmallShade(LC);
 LMRefresh(LC);
 LMSelBarInactive(LC);
 If(CheckSvga)Then Chr:='x'Else Chr:=' ';
 WEPutTxtXY(W,35,1,'D‚tection Super VGA ['+Chr+']');
 WEPutTxtXY(W,35,3,'M‚moire vid‚o');
 WESetKr(W,$8F);
 WEBarSpcHorShade(W,49,3,wnMax-1);
 WEPutTxtXY(W,49,3,Str(_PVid1.Memory shr 10));
 WESubList(W,0,6,19,10,'Matrice Couleur',MC);
 RBAddStrByte(MC.X,'Monochrome',1);
 RBAddStrByte(MC.X,'Noir & Blanc',2);
 RBAddStrByte(MC.X,'Bleuet',3);
 RBAddStrByte(MC.X,'Diablo',4);
 RBAddStrByte(MC.X,'Optionnel 1',5);
 RBAddStrByte(MC.X,'Optionnel 2',6);
 LMPutSmallShade(MC);
 LMRefresh(MC);
 LMSelBarInactive(MC);
 WESubList(W,20,6,wnMax-1,14,'Couleur',SC2);
 LMPutSmallShade(SC2);
 LMDone(SC2);
 WESubList(W,20,6,44,11,'Cat‚gorie',CA);
 RBAddStrByte(CA.X,'Menu',1);
 RBAddStrByte(CA.X,'BoŒte de dialogue',2);
 RBAddStrByte(CA.X,'BoŒte d''erreur',3);
 RBAddStrByte(CA.X,'BoŒte d''attention',4);
 RBAddStrByte(CA.X,'BoŒte de remarque(s)',5);
 RBAddStrByte(CA.X,'BoŒte de fichier',6);
 RBAddStrByte(CA.X,'Fenˆtre Dos',7);
 RBAddStrByte(CA.X,'Editeur texte',8);
 RBAddStrByte(CA.X,'Fenˆtre d''Agenda',9);
 RBAddStrByte(CA.X,'Fenˆtre de regarde',10);
 RBAddStrByte(CA.X,'Editeur hexad‚cimal',11);
 RBAddStrByte(CA.X,'Editeur de bouton',12);
 RBAddStrByte(CA.X,'Liste de t‚l‚phone',13);
 RBAddStrByte(CA.X,'Editeur de dessin',14);
 RBAddStrByte(CA.X,'Service d''aide',15);
 LMPutSmallShade(CA);
 LMRefresh(CA);
 LMSelBarInactive(CA);
 WESubList(W,45,6,67,11,'',SC);
 UpDateSC;
 For I:=0to 15do Begin
  WESetKr(W,I shl 4);
  WEBarSpcHor(W,20+I*3,12,20+I*3+2);
  WEBarSpcHor(W,20+I*3,13,20+I*3+2);
 End;
 WEBarSpcHor(W,20,14,67);
 WEPutTxtXYU(W,40,14,'Couleur');
 WESubList(W,0,12,18,16,'Format de cadre',FC);
 RBAddStrByte(FC.X,'Ombrage',1);
 RBAddStrByte(FC.X,'Robotique',2);
 RBAddStrByte(FC.X,'Simple',3);
 LMPutSmallShade(FC);
 LMRefresh(FC);
 LMSelBarInactive(FC);
 WEPutkHorDn(W,'Correcte|Annule');
 P:=0;
 Repeat
 Case P of
  0:Case LMRunKbd(LC)of
   kbTab:Begin P:=2;LMSelBarInactive(LC);Continue;End;
   kbEnter:Begin LMSelBarInactive(LC);P:=9;End;
   kbEsc:Break;
  End;
  2:Begin
   SimpleCur;
   WESetCurPos(W,35+21,1);
   K:=WEReadk(W);
   CloseCur;
   Case K of
    kbUp:P:=0;
    kbLeft:P:=0;
    kbRight,kbTab:P:=3;
    kbDn:P:=3;
    kbEnter:P:=9;
    kbEsc:Break;
    Else Begin
     If Char(K)=' 'Then Begin
      CheckSvga:=Not(CheckSvga);
      Case CheckSvga of
       Ya: WESetChr(W,35+21,1,'X');
      Else WESetChr(W,35+21,1,' ');
      End;
     End;
    End;
   End;
  End;
  3:Begin
   StrPCopy(@PBuffer,Str(PVid1T.Memory shr 10));
   WESetInpColrs(W,$8F,W.XColrs.Sel);
   PC:=@PBuffer;K:=_WEInput(W,49,3,wnMax-1,12,PC);
   WESetKr(W,$8F);
   WEBarSelHor(W,49,3,wnMax-1);
   PVid1T.Memory:=Long(ValW(StrPas(PC)))shl 10;
   Case K of
    kbEsc:Break;
    kbUp:P:=2;
    kbLeft:P:=0;
    kbRight,kbTab:P:=4;
    kbDn:P:=9;
    kbEnter:P:=9;
   End;
  End;
  4:Case LMRunKbd(MC)of
   kbTab:Begin LMSelBarInactive(MC);P:=5;End;
   kbEnter:Begin LMSelBarInactive(MC);P:=9;End;
   kbEsc:Break;
  End;
  5:Case LMRunKbd(CA)of
   kbTab:Begin LMSelBarInactive(CA);UpDateSC;P:=6;End;
   kbEnter:Begin LMSelBarInactive(CA);P:=9;End;
   kbEsc:Break;
  End;
  6:Case LMRunKbd(SC)of
   kbTab:Begin LMSelBarInactive(SC);P:=7;End;
   kbEnter:Begin LMSelBarInactive(SC);P:=9;End;
   kbEsc:Break;
  End;
  7:Case LMRunKbd(FC)of
   kbTab:Begin LMSelBarInactive(FC);P:=8;End;
   kbEnter:Begin LMSelBarInactive(FC);P:=9;End;
   kbEsc:Break;
  End;
  8:Case WEReadk(W)of
   kbTab:P:=9;
 kbEnter:P:=9;
   kbEsc:Break;
  End;
  9:Case WEGetkHorDn(W,'Correcte|Annule')of
    0:Begin _PVid1.Card:=LMGetVal(LC);Break;End;
    1:Break;
    kbEsc:Break;
    kbTab:P:=0;
  End;
 End;
 Until No;
 SetShade(Ya);
 LMDone(LC);
 LMDone(MC);
 LMDone(CA);
 LMDone(SC);
 LMDone(SC2);
 LMDone(FC);
 WEDone(W);
End;*)

Procedure OnMoveStyleButton(Var Context);
Var
 Q:ResourceWindow Absolute Context;
 PE:^ElementWins;
Begin
 ALSetPtr(Q.R,Q.P);
 PE:=_ALGetCurrBuf(Q.R);
 kType:=PE^.Data.rbDial.P;
 WEClrWnBorder(Q.W,0,14,wnMax,wnMax);
 WEPutkHorDn(Q.W,'Correcte|Annuler');
End;

Function VideoSetup;
Var
 FormSetupVideo:Record
  MediaSupport:MCheckBox;
  UseExtensior:MCheckBox;
  Cadril:MCheckBox;
  Banderolle:MCheckBox;
  FX:MCheckBox;
  CheckSVGA:MCheckBox;
  VesaBiosBank:MCheckBox;
  WinType:MRadioButton;
  Input:MRadioButton;
  kType:MRadioButtonExtended;
  StyleBarMnu:MRadioButton;
  StyleBackgroundMenu:MRadioButton;
 End;
 OldkType:Byte;
 ChangesMenu:Boolean;
Begin
 VideoSetup:=False;
 OldkType:=kType;
 FillClr(FormSetupVideo,SizeOf(FormSetupVideo));
 FormSetupVideo.CheckSVGA.Checked:=CheckSVGA;
 FormSetupVideo.VesaBiosBank.Checked:=VesaBiosBank;
 FormSetupVideo.MediaSupport.Checked:=MediaSupport;
 FormSetupVideo.UseExtensior.Checked:=UseExtensior;
 FormSetupVideo.Cadril.Checked:=Cadril;
 FormSetupVideo.Banderolle.Checked:=Banderolle;
 FormSetupVideo.FX.Checked:=FX;
 FormSetupVideo.kType.Alignment:=kType;
 FormSetupVideo.WinType.Alignment:=Byte(WinType);
 FormSetupVideo.Input.Alignment:=InputType;
 FormSetupVideo.kType.OnMove:=OnMoveStyleButton;
 FormSetupVideo.StyleBarMnu.Alignment:=StyleBarMnu;
 FormSetupVideo.StyleBackgroundMenu.Alignment:=StyleBackgroundMenu;
 If ExecuteAppDPU(64,FormSetupVideo)Then Begin
  VideoSetup:=True;
  CheckSVGA:=FormSetupVideo.CheckSVGA.Checked;
  VesaBiosBank:=FormSetupVideo.VesaBiosBank.Checked;
  MediaSupport:=FormSetupVideo.MediaSupport.Checked;
  UseExtensior:=FormSetupVideo.UseExtensior.Checked;
  Byte(WinType):=FormSetupVideo.WinType.Alignment;
  InputType:=FormSetupVideo.Input.Alignment;
  Cadril:=FormSetupVideo.Cadril.Checked;
  If(Banderolle<>FormSetupVideo.Banderolle.Checked)Then Begin
   Banderolle:=FormSetupVideo.Banderolle.Checked;
   CreateKeyFormat(HKEY_CURRENT_USER,'Window','Banderolle',tdBoolean,Banderolle);
  End;
  FX:=FormSetupVideo.FX.Checked;
  ChangesMenu:=(StyleBackgroundMenu<>FormSetupVideo.StyleBackgroundMenu.Alignment)or
               (StyleBarMnu<>FormSetupVideo.StyleBarMnu.Alignment);
  StyleBarMnu:=FormSetupVideo.StyleBarMnu.Alignment;
  StyleBackgroundMenu:=FormSetupVideo.StyleBackgroundMenu.Alignment;
  If(ChangesMenu)Then Begin
   PMPutMnuBar;
   CreateKeyFormat(HKEY_CURRENT_USER,'Menu','BackgroundType',tdByte,StyleBackgroundMenu);
   CreateKeyFormat(HKEY_CURRENT_USER,'Menu','BarType',tdByte,StyleBarMnu);
  End;
 End;
 ASM
  CMP @Result,True
  JE  @End
  MOV AL,OldkType
  MOV kType,AL
@End:
 END;
End;

Procedure DxDiag;
Var
 FormDirectX:Record
  Date:String[40];
  Version:String[15];
 End;
 DayOfWeek,Sec100:Byte;
 L:LongInt;
 X:DateTime;
Begin
 FillClr(FormDirectX,SizeOf(FormDirectX));
 GetDate(X.Year,X.Month,X.Day,DayOfWeek);
 GetTime(X.Hour,X.Min,X.Sec,Sec100);
 PackTime(X,L);
 Case(DayOfWeek)of
  0:FormDirectX.Date:='Dimanche';
  1:FormDirectX.Date:='Lundi';
  2:FormDirectX.Date:='Mardi';
  3:FormDirectX.Date:='Mercredi';
  4:FormDirectX.Date:='Jeudi';
  5:FormDirectX.Date:='Vendredi';
  6:FormDirectX.Date:='Samedi';
 End;
 IncStr(FormDirectX.Date,' ');
 AddStr(FormDirectX.Date,WordToStr(X.Day));
 IncStr(FormDirectX.Date,' ');
 Case(X.Month)of
  0:AddStr(FormDirectX.Date,'janvier');
  1:AddStr(FormDirectX.Date,'f‚vrier');
  2:AddStr(FormDirectX.Date,'mars');
  3:AddStr(FormDirectX.Date,'avril');
  4:AddStr(FormDirectX.Date,'mai');
  5:AddStr(FormDirectX.Date,'juin');
  6:AddStr(FormDirectX.Date,'juillet');
  7:AddStr(FormDirectX.Date,'ao–t');
  8:AddStr(FormDirectX.Date,'septembre');
  9:AddStr(FormDirectX.Date,'octobre');
  10:AddStr(FormDirectX.Date,'novembre');
  11:AddStr(FormDirectX.Date,'d‚cembre');
 End;
 IncStr(FormDirectX.Date,' ');
 AddStr(FormDirectX.Date,WordToStr(X.Year)+', '+CStrTime(L));
 FormDirectX.Version:='1.0.0';
 If ExecuteAppDPU(167,FormDirectX)Then Begin
 End;
End;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
END.