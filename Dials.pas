{�����������������������������������������������������������������������Ŀ
 �                                                                       ���
 �                  Malte Genesis/Module des Dialogues                   ���
 �                                                                       ���
 �       �dition Chantal & Ad�le pour Mode R�el/IV - Version 1.0         ���
 �                      1995/02/02 � 2001/04/19                          ���
 �                                                                       ���
 �        Tous droits r�serv�s par les Chevaliers de Malte (C)           ���
 �                                                                       ���
 ������������������������������������������������������������������������ٲ�
  ��������������������������������������������������������������������������


 Nom du programmeur
 ������������������

  Sylvain Maltais

 Description
 �����������

  Cette unit� contient tous les m�canismes de base pour la construction d'un
 environnement de style �Elvis�.  Il permet ainsi des possibilit�s de multi-
 fen�trage, dialogue, journal de bord,  historique,  visualisation rapide de
 fichier ASCII,  presse-papier  (clipboard), gestion  des  menus  d�roulant,
 s�lection de liste, gestion des Icons  et des boutons dans un environnement
 aussi bien texte que graphique avec une souris utilisable.


 Remarques
 ���������

  � Il support les descriptions de 4DOS/NDOS si la variable �DescrInFile�est
    positionn� (est � True).

  � Si  vous souha�tez  avoir plusieurs  menu principal s�par�,  vous  devez
    d�finir la directive de compilation  �$DEFINE  MultiMenu�.  Vous  devrez
    donc d�finir votre propre variable � chaque fois tel un objet.
}

Unit Dials;

{��������������������������������������������������������������������������}
                                INTERFACE
{��������������������������������������������������������������������������}

{$I DEF.INC}

Uses Adele,
     {$IFDEF __Windows__}
      Graphics,
     {$ENDIF}
     Dostex,Systex,Dialex,Isatex;

Procedure AppInit(Const Title:String;Color,Mtx:Byte);
Procedure BMIcon(Var Q:BlockButton);
Procedure BMLoadAll(Var Q:ButtonMnu;Name:String;X,Y:Byte);
Procedure BMLoadAllVert(Var Q:ButtonMnu;Name:String;X,Y,PerLine:Byte);
Function  BMUseXTexts(Var Q:ButtonMnu):Byte;
Function  BMUseYTexts(Var Q:ButtonMnu):Byte;
Function  BMGetBut(Var Q:ButtonMnu;X,Y:Byte):Word;
Procedure BPInit(Var Q:BarProgress;X,Y:Byte;Var W:Window);
Procedure BPProgress(Var Q:BarProgress;Pour:Byte);
Procedure ConMacro(Const S:String);
Procedure DialogMsgOk(Const Msg:String);
Function  ErrMsg(Const Msg:String;Key:Word):Word;
Procedure ErrMsgOk(Const Msg:String);
Procedure ErrNoMsgOk(Error:Word);
Function  GetAbsClipBoard(P:LongInt;Size:Word;Var X):Word;
Function  GetClipBoardTxt:String;
Function  GetErrMsg(X:Word):String;
Function  GetStrTimeInPrg:String;
Function  HYChoice(Var Q:History;X,Y:Byte):String;
Function  HYClear(Var Q:History):String;
Procedure HYClearQueue(Var Q:History);
Procedure HYDone(Var Q:History);
Function  HYGetSizeBuffer(Var Q:History):Word;
Procedure HYInit(Var Q:History;Size:Word);
Procedure HYInitTo(Var Q:History;Size:Word;Buffer:Pointer);
Function  HYNext(Var Q:History):String;
Function  HYPrev(Var Q:History):String;
Procedure HYQueue(Var Q:History;Const S:String);
Procedure HYSetSizeBuffer(Var Q:History;Size:Word);
Function  InBarHole(X,Y,L:Byte):Boolean;
Function  InBoxHole(X,Y,L,H:Byte):Boolean;
Procedure InitDials;
Procedure InitEnv;
Function  Input(X1,Y,X2:Byte;MaxLen:Word;PassWord:Boolean;Var Str:PChr):Word;
Function  InputMsg(Const Title,Msg:String;Key:Word;Flags:Byte;Const Palette:MtxInputColors):Word;
{$IFNDEF __Windows__}
 Procedure Int05h(Flags,CS,IP,AX,BX,CX,DX,SI,DI,DS,ES,BP:Word);Interrupt;
{$ENDIF}
Function  IsBanderolle:Boolean;
{$IFDEF Joystick}
 Function JoyX(Joy:Byte):ShortInt;
 Function JoyY(Joy:Byte):ShortInt;
{$ENDIF}
Function  KeyCode2Str(Code:Word):String;
Procedure LMInit(Var Q:LstMnu;X1,Y1,X2,Y2:Byte;Const Title:String;Const Palette:MtxColors);
Procedure LMInitKrDials(Var Q:LstMnu;X1,Y1,X2,Y2:Byte;Const Title:String);
Procedure _LMQInit(Var Q:LstMnu;X1,Y1,X2,Y2:Byte;Title:String;Const Palette:MtxColors);
Procedure LMInitCenter(Var Q:LstMnu;L,H:Byte;Title:String;Const Palette:MtxColors);
Procedure LMQInit(Var Q:LstMnu;X1,Y1,X2,Y2:Byte);
Procedure LMGotoPos(Var Q:LstMnu;Code:Word);
Procedure LMSetEndBar(Var Q:LstMnu;Attr:Byte);
Procedure LMPutEndBar(Var Q:LstMnu;X:Byte;Const Msg:String;Attr:Byte);
Procedure LMPutSmallShade(Var Q:LstMnu);
Procedure LMPutBarMouseRight(Var Q:LstMnu);
Procedure LMRefresh(Var Q:LstMnu);
Procedure LMSelBar(Var Q:LstMnu);
Procedure LMSelBarInactive(Var Q:LstMnu);
Procedure LMUnSelBar(Var Q:LstMnu);
Procedure LMPutDataHome(Var Q:LstMnu);
Procedure LMkUp(Var Q:LstMnu);
Procedure LMkDn(Var Q:LstMnu);
Function  LMGetVal(Var Q:LstMnu):LongInt;
Function  LMRun(Var Q:LstMnu):Word;
Function  LMRunKbd(Var Q:LstMnu):Word;
Procedure LMDone(Var Q:LstMnu);
Procedure LoadWallPaper(Refresh:Boolean);
Procedure LTInit(Var Q:ListTitle;X1,Y,X2:Byte;Const Title:String);
Procedure LTInitWithWins(Var Q:ListTitle;X1,Y,X2:Byte;Const Title:String;Var W:Window);
Procedure LTSetColumnSize(Var Q:ListTitle;Pos,NewSize:Byte);
Procedure LTRefresh(Var Q:ListTitle);
Procedure MakeClipBoard(Size:LongInt);
Function  MessageByLanguage(Const Raw:String):String;
Procedure PMInit{$IFDEF MultiMenu}(Var MainMenu:PullMnu){$ENDIF};
Procedure PMAddBarItem{$IFDEF MultiMenu}(Var MainMenu:PullMnu){$ENDIF};
Procedure PMAddFullItem({$IFDEF MultiMenu}Var MainMenu:PullMnu;{$ENDIF}Option:PChar;
          KeyFunc,RtnCode:Word;SubMenu:Pointer{$IFDEF LuxeExtra};PChr:PChar{$ENDIF});
Procedure PMAddItem({$IFDEF MultiMenu}Var MainMenu:PullMnu;{$ENDIF}Option:PChar;
          RtnCode:Word{$IFDEF LuxeExtra};PChr:PChar{$ENDIF});
Procedure PMAddItemKey({$IFDEF MultiMenu}Var MainMenu:PullMnu;{$ENDIF}Option:PChar;
          KeyFunc,RtnCode:Word{$IFDEF LuxeExtra};PChr:PChar{$ENDIF});
Procedure PMAddItemSwitch({$IFDEF MultiMenu}Var MainMenu:PullMnu;{$ENDIF}
          Option:PChar;Var Value;Switch:PullSwitchPtr;RtnCode:Word);
Procedure PMAddMnu({$IFDEF MultiMenu}Var MainMenu:PullMnu;{$ENDIF}Mnu:PChar);
Function  PMExecMnu({$IFDEF MultiMenu}Var MainMenu:PullMnu;{$ENDIF}
          X,Y:Byte;List:PullMnuPtr;Var P:Byte):Word;
Procedure PMGetMnuBar({$IFDEF MultiMenu}Var MainMenu:PullMnu;{$ENDIF}X,Y:Byte);
Function  PMMnuPtr({$IFDEF MultiMenu}Var MainMenu:PullMnu;{$ENDIF}Mnu:PChr):PullMnuPtr;
Procedure PMPutMnuBar{$IFDEF MultiMenu}(Var MainMenu:PullMnu){$ENDIF};
Procedure PMSetWinBar({$IFDEF MultiMenu}Var MainMenu:PullMnu;{$ENDIF}X1,Y,X2:Byte);
Function  PMWaitForMnuAction{$IFDEF MultiMenu}(Var MainMenu:PullMnu){$ENDIF}:Word;
Procedure PMDone{$IFDEF MultiMenu}(Var MainMenu:PullMnu){$ENDIF};
Procedure PopScr(Var M:ImgRec);
{Procedure PopWins(Var Q:Wins);}
Procedure PushClipboardTxt(Const S:String);
Procedure PushScr(Var M:ImgRec);
{Procedure PushWins(Var Q:Wins);}
Procedure PutClipBoardTxt(Const S:String);
Procedure PutGrfIcon(Const Path:String;X,Y:Byte;P:Word);
Procedure PutLastBar(X:Byte;Const Msg:String);
Function  PutImage(X1,Y1,X2,Y2:Integer;Var Q:ImgRec):Boolean;
Function  RestoreImage(X1,Y1,X2,Y2:Integer;Var Q:ImgRec):Boolean;
Function  ReadKeyTypeWriter:Word;
Function  SaveImage(X1,Y1,X2,Y2:Integer;Var Q:ImgRec):Boolean;
Procedure SEInit(Var Q:SectionRec;L:Byte;Const Title:String);
Procedure SEAssociateImageRes(Var Q:SectionRec;Const Name:String;Start:Word;ImageLen:Byte);
Procedure SEAdd(Var Q:SectionRec;Const k:String);
Procedure SEPutWn(Var Q:SectionRec);
Procedure SEBar(Var Q:SectionRec);
Function  SERun(Var Q:SectionRec):Word;
Procedure SEDone(Var Q:SectionRec);
Function  SelectField(Const Table:String;Value:Word;Field:Byte):String;
Function  SelectStrictField(Const Table:String;Value:Word;Field:Byte):String;
Procedure SetAbsClipBoard(P:LongInt;Size:Word;Const X);
Procedure SetPosDate(X,Y:Byte);
Procedure SetPosTime(X,Y:Byte);
Procedure SetPosTimeAfterEndOfDay(X,Y:Byte);
Procedure SetPosTimeInPrg(X,Y:Byte);
Procedure SetPosTimeMod(X,Y:Byte);
Procedure SetPosTimeOnLine(X,Y:Byte);
Procedure SetTimerMod;
Procedure SetTimerModOff;
Procedure SetTimerOnLine;
Procedure SetTimerOnLineOff;
Procedure SMInit(Var Q:PullSubMnu);
Procedure SMAddFullItem(Var Q:PullSubMnu;Option:PChar;KeyFunc,RtnCode:Word;SubMenu:Pointer
                        {$IFDEF LuxeExtra};PC:PChar{$ENDIF});
Procedure SMAddItemSwitch(Var Q:PullSubMnu;Option:PChar;Var Value;Switch:PullSwitchPtr;RtnCode:Word);
Procedure SMAddBarItem(Var Q:PullSubMnu);
Procedure SMDone(Var Q:PullSubMnu);
Function  TimeToStr(Time:LongInt):String;
Function  WarningMsg(Const Msg:String;Key:Byte):Word;
Procedure WarningMsgOk(Const Msg:String);
Function  WarningMsgYesNo(Const Msg:String):Word;
Procedure WEAniCur(Var Q:Window);
Procedure WEBackground(Var Q:Window;Attr:Byte);
Function  WEBackReadk(Var Q:Window):Word;
Procedure WEBar(Var Q:Window);
Procedure WEBarSelHor(Var Q:Window;X1,Y,X2:Byte);
Procedure WEBarSpcHor(Var Q:Window;X1,Y,X2:Byte);
Procedure WEBarSpcHorBanderolle(Var Q:Window;Y:Byte;P:Word);
Procedure WEBarSpcHorShade(Var Q:Window;X1,Y,X2:Byte);
Procedure WEBarSpcHorRelief(Var Q:Window;X1,Y,X2:Byte);
Procedure WEBarTxtHor(Var Q:Window;X1,Y,X2:Byte;Chr:Char);
Procedure WECloseCur(Var Q:Window);
Procedure WECloseIcon(Var Q:Window);
Procedure WEClrScr(Var Q:Window);
Procedure WEClrEol(Var Q:Window);
Procedure WEClrLnHor(Var Q:Window;X,Y:Integer;Len,Color:Word);
Procedure WEClrWn(Var Q:Window;X1,Y1,X2,Y2,Attr:Byte);
Procedure WEClrWnBorder(Var Q:Window;X1,Y1,X2,Y2:Byte);
Procedure WEConMacro(Var Q:Window;Const S:String);
Procedure WEDone(Var Q:Window);
Procedure WEDn(Var Q:Window;N:Byte);
Procedure WEForeground(Var Q:Window;Attr:Byte);
Function  WEFreeAll(Var Q:Window):Boolean;
Function  WEGetCompatPosition(Var Q:Window;NumElement:LongInt):LongInt;
Function  WEGetkHor(Var Q:Window;X,Y,JK:Byte;Const kStr:String):Byte;
Function  WEGetkHorDn(Var Q:Window;Const k:String):Word;
Function  WEGetkHorO(Var Q:Window;Y:Byte;Const k:String):Word;
Function  WEGetRealY(Var Q:Window):Byte;
Function  WEGetRealX(Var Q:Window):Byte;
Function  WEGetRX1(Var Q:Window):Byte;
Function  WEGetRY1(Var Q:Window):Byte;
Function  WEGetStr(Var Q:Window;X,Y:Byte):String;
Function  WEInCloseIcon(Var Q:Window;X,Y:Byte):Boolean;
Function  WEInZoomIcon(Var Q:Window;X,Y:Byte):Boolean;
Procedure WEInitO(Var Q:Window;L,H:Byte);
Procedure WEInit(Var Q:Window;X1,Y1,X2,Y2:Byte);
{$IFDEF __Windows__}
 Procedure WEInitWindows(Var Q:Window;Const Canvas:TCanvas);
{$ENDIF}
Function  WEInp(Var Q:Window;Var Str:PChr;MaxLen:Word;PassWord:Boolean):Word;
Function  WEInRightBarMs(Var Q:Window;X,Y:Byte):Word;
Function  WEInTitle(Var Q:Window;X,Y:Byte):Boolean;
Function  WEInWindow(Var Q:Window;X,Y:Byte):Boolean;
Function  WEInZonePtrMouse(Var Q:Window;X,Y,L,H:Byte):Boolean;
Procedure WELeft(Var Q:Window;N:Byte);
Procedure WELn(Var Q:Window);
Function  WEMouseInZone(Var Q:Window;X,Y,L,H:Byte):Boolean;
Function  WEOk(Var Q:Window):Boolean;
Function  WEOnWindow(Var Q:Window;X,Y:Byte):Boolean;
Procedure WEPopCur(Var Q:Window);
Function  WEPopWn(Var Q:Window):Boolean;
Procedure WEPushCur(Var Q:Window);
Procedure WEPushEndBar(Var Q:Window);
Function  WEPushWn(Var Q:Window):Boolean;
Procedure WEPutBarMsRight(Var Q:Window);
Procedure WEPutChrGAttr(Var Q:Window;Chr:Char;GAttr:Byte);
Procedure WEPutCube(Var Q:Window;Chr:Char);
Procedure WEPutFillBox(Var Q:Window;X1,Y1,X2,Y2,Color:Word);
Procedure WEPutkHor(Var Q:Window;X,Y,JK:Byte;Const kStr:String);
Procedure WEPutkHorDn(Var Q:Window;Const Key:String);
Procedure WEPutkHorO(Var Q:Window;Y:Byte;Const k:String);
Procedure WEPutLastBar(Const k:String);
Procedure WEPutLine(Var Q:Window;X1,Y1,X2,Y2,Color:Word);
Procedure WEPutLnHor(Var Q:Window;X1,Y,X2,Color:Word);
Procedure WEPutMsg(Var Q:Window;Const Msg:String);
Procedure WEPutOTxt(Var Q:Window;Const Msg:String);
Procedure WEPutOTxtU(Var Q:Window;Const Msg:String);
Procedure WEPutPTxt(Var Q:Window;Msg:PChr);
Procedure WEPutPTxtLn(Var Q:Window;Msg:PChr);
Procedure WEPutPTxtXY(Var Q:Window;X,Y:Byte;Msg:PChr);
Procedure WEPutPTxtXY2(Var Q:Window;X,Y:Byte;S:Word;Msg:PChr);
Procedure WEPutPTxtXYAtChr(Var Q:Window;X,Y:Byte;Chr:Char;Msg:PChr);
Procedure WEPutRect(Var Q:Window;X1,Y1,X2,Y2,Color:Word);
Procedure WEPutSmallBorder(Var Q:Window);
Procedure WEPutSmlTxtLn(Var Q:Window;Const Msg:String);
Procedure WEPutSmlTxtXY(Var Q:Window;X,Y:Byte;Msg:String);
Procedure WEPutTxt(Var Q:Window;Msg:String);
Procedure WEPutTxtT(Var Q:Window;Msg:String);
Procedure WEPutTxtTLn(Var Q:Window;Const Msg:String);
Procedure WEPutTxtLn(Var Q:Window;Const Msg:String);
Procedure WEPutTxtXY(Var Q:Window;X,Y:Byte;Msg:String);
Procedure WEPutTxtXYT(Var Q:Window;X,Y:Byte;Msg:String);
Procedure WEPutTxtXYU(Var Q:Window;X,Y:Byte;Msg:String);
Procedure WEPutTyping(Var Q:Window;Const Msg:String);
Procedure WEPutTypingLn(Var Q:Window;Const Msg:String);
Procedure WEPutWn(Var Q:Window;Const Title:String;Const Palette:MtxColors);
Procedure WEPutWnKrDials(Var Q:Window;Const Title:String);
Function  WEReadk(Var Q:Window):Word;
Procedure WEReInit(Var Q:Window;X1,Y1,X2,Y2:Byte);
Procedure WERight(Var Q:Window;N:Byte);
Function  WERunItem(Var W:Window;X,Y:Byte;Var P:Byte;Min,Nm:Byte;Var TB:Array of Boolean):Word;
Procedure WEScrollLeft(Var Q:Window;X1,Y1,X2,Y2,N:Byte);
Procedure WEScrollRight(Var Q:Window;X1,Y1,X2,Y2,N:Byte);
Procedure WEScrollDn(Var Q:Window;X1,Y1,X2,Y2:Byte);
Procedure WEScrollUp(Var Q:Window;X1,Y1,X2,Y2:Byte);
Procedure WESelRightBarPos(Var Q:Window;P,Max:Word);
Procedure WESetAttr(Var Q:Window;X,Y,Attr:Byte);
Procedure WESetChr(Var Q:Window;X,Y:Byte;Chr:Char);
Procedure WESetCube(Var Q:Window;X,Y:Byte;Chr:Char);
Procedure WESetCurPos(Var Q:Window;X,Y:Byte);
Procedure WESetEndBar(Var Q:Window;Attr:Byte);
Procedure WESetEndBarCTitle(Var Q:Window);
Procedure WESetEndBarTxtX(Var Q:Window;X:Byte;Str:String;Attr:Byte);
Procedure WESetHomeLine(Var Q:Window;Y:Byte);
Procedure WESetKr(Var Q:Window;Color:Byte);
Procedure WESetKrBorder(Var Q:Window);
Procedure WESetKrBorderF(Var Q:Window;F:Byte);
Procedure WESetKrHigh(Var Q:Window);
Procedure WESetKrSel(Var Q:Window);
Procedure WESetKrSelF(Var Q:Window;F:Byte);
Procedure WESetInpColors(Var Q:Window;Normal,Select:Byte);
Procedure WESetPos(Var Q:Window;X,Y:Byte);
Procedure WESetPosHome(Var Q:Window);
Procedure WESetSubWn(Var Q:Window;Const Title:String;Var W:Window);
Procedure WESetTitle(Var Q:Window;Title:String;Color:Byte);
Procedure WESetXBool(Var W:Window;X,Y:Byte;B:Boolean);
Procedure WESetY(Var Q:Window;Y:Byte);
Procedure WESimpleCur(Var Q:Window);
Procedure WESubList(Var Q:Window;X1,Y1,X2,Y2:Byte;Const Title:String;Var L:LstMnu);
Procedure WESubWins(Var Q:Window;X1,Y1,X2,Y2:Byte;Var W:Window);
Procedure WEUp(Var Q:Window;N:Byte);
Function  WEXIsOut(Var Q:Window):Boolean;
Function  WEYIsOut(Var Q:Window):Boolean;
Procedure WEZoomIcon(Var Q:Window);
Function  WinInp(L:Byte;Const Title,Msg:String;Const Palette:MtxColors;PassWord:Boolean;Var Output:String):Word;
Function  WinInpH(L:Byte;Const Title,Msg:String;Const Palette:MtxColors;
                  PassWord:Boolean;Var Output:String;Var Q:History;
                  PrevNext:Boolean):Word;
Procedure WriteLog(Const S:String);
Procedure _InitAbsEnv(Palette:Byte);
Procedure _InitEnv(Default:Byte);
Function  _InputMsg(Const Title,Msg,Key:String;Flags:Byte;Const Kr:MtxInputColors):Word;
Function  _PMWaitForMnuAction({$IFDEF MultiMenu}Var MainMenu:PullMnu;{$ENDIF}K:Word):Word;
Procedure _SetRecClipBoard(Size:Word;Const X);
Procedure _WEDn(Var Q:Window);
Procedure _WEHL(Var Q:Window); { SetHomeLine }
Function  _WEInput(Var Q:Window;X1,Y,X2:Byte;Len:Word;Var PChr:PChr):Word;
Procedure _WELeft(Var Q:Window);
Procedure _WELL(Var Q:Window); { SetLastLine }
Procedure _WELn(Var Q:Window);
Procedure _WEPutWn(Var Q:Window;Const Title:String);
Procedure _WERight(Var Q:Window);
Procedure _WESetCube(Var Q:Window;X,Y:Byte;Chr:Char;Attr:Byte);
Procedure _WESetCubeCSel(Var Q:Window;X,Y:Byte;Chr:Char);
Procedure _WESetCubeCSelF(Var Q:Window;X,Y:Byte;Chr:Char;F:Byte);
Procedure _WESetTitle(Var Q:Window;Const Title:String);
Procedure _WESetTitleF(Var Q:Window;Const Title:String;F:Byte);
Procedure _WEScrollDn(Var Q:Window);
Procedure _WEScrollUp(Var Q:Window);
Procedure _WEUp(Var Q:Window);
Function  _WinInp(L:Byte;Const Title,Msg:String;PassWord:Boolean;Var Output:String):Word;

{��������������������������������������������������������������������������}
                              IMPLEMENTATION
{��������������������������������������������������������������������������}

Uses Memories,Time,Systems,pritex,Mouse,Arcade,Video,Volume,DialPlus,
     {$IFDEF __Windows__}
      Controls,Dialogs,
     {$ENDIF}
     ResServI,ResLoadI,ResTex,ResServD,
     Tools,Sound,CommBase,Math;

Procedure AsmWEGetR;Near;Forward;
Procedure AsmWEGetReal;Near;Forward;
Procedure BackTimer;Far;Forward;
Procedure InitKbd;Forward;
Function  Key2Str(Key:Word;Var Str:String):Byte;Near;Forward;
Procedure LIInit(Var Q:LineImage);Near;Forward;
Function  LIPush(Var Q:LineImage;X1,Y,X2:Byte):Boolean;Near;Forward;
Procedure LIReSave(Var Q:LineImage;X1,Y,X2:Byte);Near;Forward;
Procedure LIBarSel(Var Q:LineImage);Near;Forward;
Procedure LIPop(Var Q:LineImage);Near;Forward;
Procedure LICopy(Var Q:LineImage);Near;Forward;
Procedure LIPut(Var Q:LineImage);Near;Forward;
Procedure PMAlloc({$IFDEF MultiMenu}Var Q:PullMnu;{$ENDIF}BPull:PullMnuItem);Forward;
Function  _SaveImage(X1,Y1,X2,Y2:Integer;Var Q:ImgRec;Resource:Byte):Bool;Near;Forward;
Procedure SMAlloc(Var Q:PullSubMnu;BPull:PullMnuItem);Forward;
Procedure WEAlignEnd(Var Inf:Window;Var X,Y:Byte);Near;Forward;
Function  WEAlignEndX(Var Inf:Window;X:Byte):Byte;Near;Forward;
Function  WEAlignEndY(Var Inf:Window;Y:Byte):Byte;Near;Forward;
Function  WEGetR(Var Q:Window;Var Y:Byte):Byte;Near;Forward;
Function  WEMaxXTxts(Var Q:Window):Byte;Near;Forward;
Function  WEMaxYTxts(Var Q:Window):Byte;Near;Forward;
Function __WEPutkHor(Var Inf:Window;X,Y,JK:Byte;Const kStr:String;Var XTab:XTabType;High:Bool):Byte;Near;Forward;

{ R o u t i n e  a u t o n o m e ...}

Function MessageByLanguage(Const Raw:String):String;
Var
 P:Byte;
 S:String;
Begin
 P:=Pos('�',Raw);
 If P=0Then MessageByLanguage:=Raw
  Else
 Begin
  If DefaultLanguage=0Then MessageByLanguage:=Left(Raw,P-1)
  Else Begin
   S:=Copy(Raw,P+1,255);
   P:=Pos('�',S);
   If P=0Then MessageByLanguage:=S
    Else
   Begin
    If DefaultLanguage=2Then MessageByLanguage:=Copy(S,P+1,255)
                        Else MessageByLanguage:=Left(S,P-1);
   End;
  End;
 End;
End;

Function SelectField(Const Table:String;Value:Word;Field:Byte):String;
Var
 S:String;
Begin
 S:=SelectStrictField(Table,Value,Field);
 If S=''Then S:={$IFDEF ENGLISH}'Unknown'{$ELSE}'Inconnu(e)'{$ENDIF};
 SelectField:=S;
End;

Function SelectStrictField(Const Table:String;Value:Word;Field:Byte):String;
Var
 PBuffer:Pointer;
 PString:^String Absolute PBuffer;
 Buffer:Array[0..1023]of Byte;
Begin
 DBOpenServerName(ChantalServer,Table);
 If DBLocateAbs(ChantalServer,0,Value,[])Then Begin
  DBReadRec(ChantalServer,Buffer);
  PBuffer:=@Buffer;
  DBGotoColumnAbs(ChantalServer,Field,PBuffer);
  SelectStrictField:=PString^;
 End
  Else
 SelectStrictField:='';
End;

{�������������������������������������������������������������ķ}
{�                     Z o n e  P r i v �                      �}
{�������������������������������������������������������������ͼ}

{$IFNDEF GraphicOS}
Procedure BarSpcHorHole(X1,Y,X2,Attr:Byte);Near;
Var
 I:Byte;
 B:Word;
Begin
 If(HoleMode)and(Hole<>NIL)Then Begin
  B:=X1+Y*NmXTxts;
  For I:=X1 to(X2)do Begin
   If Not Hole^[B]Then SetCube(I,Y,' ',Attr);
   Inc(B);
  End;
 End
  Else
 BarSpcHor(X1,Y,X2,Attr);
End;

Procedure ClrWnHole(X1,Y1,X2,Y2,Attr:Byte);Near;
Var
 J:Byte;
Begin
 If(HoleMode)and(Hole<>NIL)Then Begin
  For J:=Y1 to(Y2)do BarSpcHorHole(X1,J,X2,Attr)
 End
  Else
 ClrWn(X1,Y1,X2,Y2,Attr);
End;

Procedure PutTxtXYHole(X,Y:Byte;Const S:String;Attr:Byte);Near;
Var
 I:Byte;
 B:Word;
Begin
 If(HoleMode)and(Hole<>NIL)Then Begin
  B:=X+Y*NmXTxts;
  For I:=1to Length(S)do Begin
   If Not Hole^[B]Then SetCube(X,Y,S[I],Attr);
   Inc(B);Inc(X);
  End;
 End
  Else
 PutTxtXY(X,Y,S,Attr);
End;

Procedure PutTxtXYTHole(X,Y:Byte;Const S:String;Attr:Byte);Near;
Var
 I:Byte;
 B,X1:Word;
Begin
 If(HoleMode)and(Hole<>NIL)Then Begin
  B:=X+Y*NmXTxts;X1:=X shl 3;
  For I:=1to Length(S)do Begin
   If Not Hole^[B]Then SetGCubeT(X1,GetRawY(Y),S[I],Attr);
   Inc(B);Inc(X1,8);
  End;
 End
  Else
 PutTxtXYT(X,Y,S,Attr);
End;

Procedure _LnHorHole(X1,Y,X2:Word);Near;Begin
 If Not(HoleMode)Then _LnHor(X1,Y,X2)Else
 If Not InBarHole(X1 shr 3,Y div HeightChr,((X2 shr 3)-(X1 shr 3))+2)Then _LnHor(X1,Y,X2);
End;
{$ENDIF}

{�����������������������������������������������������������������������
 �                        Fonction GetStrTimeInPrg                     �
 �����������������������������������������������������������������������


 Portabilit�: Local


 Description
 �����������

  Cette fonction permet d'afficher une cha�ne de caract�res repr�sentant
 le temps depuis lequel l'application en marche.
}

Function GetStrTimeInPrg:String;
Var
 Hour,Min,Sec:Word;
 Time:LongInt;
Begin
 Time:=GetRawTimer-TimeIn;
 If Time<>0Then Begin
  Hour:=Time div 360;
  Min:=Word(Time div 60)mod 60;
  Sec:=Time mod 60;
 End
  Else
 Begin
  Hour:=0;
  Min:=0;
  Sec:=0;
 End;
 GetStrTimeInPrg:=CStrTimeDos(Hour,Min,Sec)
End;

{�����������������������������������������������������������������������
 �                          Proc�dure PutIcn                           �
 �����������������������������������������������������������������������


 Portabilit�: Local


 Description
 �����������

  Cette proc�dure permet d'afficher un Icon de format Malte Genesis III/
 Isabel � l'�cran.
}

Procedure PutIcn(X,Y:Word;Var Buf);Near;
Var
 J:Word;
Begin
 For J:=0to 31do Begin
  ClrLnHorImg(X,Y+J,32,8,Buf);
  ASM ADD Word Ptr Buf,32;END;
 End;
End;

Function WEMouseInZone(Var Q:Window;X,Y,L,H:Byte):Boolean;
Var
 R:TextCharRec;
Begin
 ASM
  LES DI,Q
  CALL AsmWEGetR
  MOV BL,X
  MOV BH,Y
  ADD AX,BX
  MOV R,AX
 END;
 WEMouseInZone:=(LastMouseY>=R.Y)and(LastMouseY<R.Y+H)and(LastMouseX>=R.X)and(LastMouseX<R.X+L);
End;

{Function WEInZonePtrMouse(Var Q:Wins;X,Y,L,H:Byte):Bool;Near;Var XT,YT,RX1,RY1:Byte;BT:Word;Begin
 If(IsShowMouse)Then Begin
  __GetMouseTextSwitch(XT,YT,BT);
  RX1:=WEGetRX1(Q)+X;RY1:=WEGetRY1(Q)+Y;
  WEInZonePtrMouse:=(YT>=RY1-1)and(YT<=RY1+H-1)and
                    (XT+1>=RX1)and(XT<=RX1+L);
 End
  Else
 WEInZonePtrMouse:=No;
End;}

Function WEInZonePtrMouse(Var Q:Window;X,Y,L,H:Byte):Boolean;
Var
 T,R:TextCharRec;
 BT:Word;
Begin
 If(IsShowMouse)Then Begin
  __GetMouseTextSwitchZ(T,BT);
  ASM
   LES DI,Q
   CALL AsmWEGetR
   MOV BL,X
   MOV BH,Y
   ADD AX,BX
   MOV R,AX
  END;
  WEInZonePtrMouse:=(T.Y>=R.Y-1)and(T.Y<=R.Y+H-1)and(T.X+1>=R.X)and(T.X<=R.X+L);
 End
  Else
 WEInZonePtrMouse:=False;
End;

{���������������������������������������������������������������������������
 �                            Proc�dure PutTapis                           �
 ���������������������������������������������������������������������������


 Portabilit�: Local


 Description
 �����������

  Cette proc�dure affiche une tapiserie de fond en mode texte pour permettre
 de ne pas voir directement le fond de l'�cran.  Il s'adapte en fonction des
 polices de caract�res supporter par les cartes vid�o ou non.
}

{$IFNDEF __Windows__}
 {$I \Source\Chantal\Library\System\Malte\Presenta.tio\PutTapis.Inc}
{$ENDIF}

{�������������������������������������������������������������ķ}
{�                    Z o n e  P u b l i q u e                 �}
{�������������������������������������������������������������ͼ}

{���������������������������������������������������������������������������
 �                              Proc�dure AppInit                          �
 ���������������������������������������������������������������������������


 Portabilit�: Global


 Description
 �����������

  Cette proc�dure affiche l'interface de d�veloppement utilisateur classique
 d'une application de traitement de donn�e tel le �MonsterBook� ou le �Basic
 Pro�.
}

Procedure AppInit{Const Title:String;Kr,Mtx:Byte};Begin
 _InitEnv(Mtx);
 InitDials;
 CurrKrs.Desktop.Tapiserie:=Color;
 {$IFNDEF __Windows__}
  If(IsGrf)Then LoadWallPaper(True)
           Else PutTapis(0,MaxYTxts,Color);
  BarSpcHor(0,0,MaxXTxts,CurrKrs.LastBar.Normal);
  PutCloseIcon(0,0,$F);
  ConMacro('TO'#0+Chr(CurrKrs.LastBar.Normal)+Title+'$');
  BarSpcHor(0,MaxYTxts,MaxXTxts,CurrKrs.Menu.Normal);
 {$ENDIF}
 PMPutMnuBar;
End;

Procedure BPInit(Var Q:BarProgress;X,Y:Byte;Var W:Window);Begin
 FillClr(Q,SizeOf(Q));
 Q.W:=@W;
 Q.X:=X;Q.Y:=Y;
 W.CurrColor:=$1F;
 WEBarSpcHorShade(W,X,Y,wnMax);
 WESetKrBorder(W);
End;

Procedure BPProgress(Var Q:BarProgress;Pour:Byte);Begin
 WESetPos(Q.W^,Q.X,Q.Y);
 Q.W^.CurrColor:=$F0;
 WEBarSelHor(Q.W^,Q.X,Q.Y,(Pour*(Q.W^.MaxX-1))div 100);
 WEPutOTxtU(Q.W^,WordToStr(Pour)+'%');
 WESetKrBorder(Q.W^);
End;

{������������������������������������������������������������������������
 �                          Proc�dure ConMacro                          �
 ������������������������������������������������������������������������


 Portabilit�: Global


 Description
 �����������

  Cette proc�dure permet d'afficher des donn�es en utilisant le protocole
 de la console de format �Malte�.
}

Procedure ConMacro{Const S:String};
Var
 W:Window;
Begin
 WEInit(W,0,0,wnMax,wnMax);{ Initialise pour l'utilisation de l'�cran au complet...}
 WEConMacro(W,S)           { Utilise celle existant d�ja pour les fen�tres de dialogues!}
End;

{����������������������������������������������������������������������������
 �                            Fonction DialogMsgOk                          �
 ����������������������������������������������������������������������������


 Portabilit�: Global


 Description
 �����������

  Cette fonction affiche le message sp�cifi� avec une fen�tre d'environnement
 ordinaire et retourne la d�cision  de l'utilisateur  en fonction des touches
 sp�cifi�es ou de la souris.


 Voir �galement
 ��������������

 ��������������������������������������������������������������������������Ŀ
 � Fonction        � Courte description                                     �
 ��������������������������������������������������������������������������͵
 � ErrMsg          � Bo�te de dialogue d'erreur                             �
 � ErrMsgOk        � Bo�te de dialogue d'erreur avec bouton �Correcte�      �
 � WarningMsg      � Bo�te de dailogue d'attention                          �
 � WarningMsgOk    � Bo�te de dialogue d'attention avec bouton �Correcte�   �
 � WarningMsgYesNo � Bo�te de dailogue d'attention avec bouton �Oui� & �Non��
 ����������������������������������������������������������������������������
}

Procedure DialogMsgOk{Const Msg:String};Begin
 _LoadSound(StrPas(SoundPlay[sndInfo]));
 _PlayWave;
 InputMsg('Remarque',Msg,KeyOk,0,CurrKrs.RemWin)
End;

{����������������������������������������������������������������������������
 �                            Fonction ErrMsg                               �
 ����������������������������������������������������������������������������


 Portabilit�: Global


 Description
 �����������

  Cette fonction affiche le message sp�cifi� avec une fen�tre d'environnement
 d'erreur  et retourne la d�cision  de l'utilisateur  en fonction des touches
 sp�cifi�es ou de la souris.


 Voir �galement
 ��������������

 ��������������������������������������������������������������������������Ŀ
 � Fonction        � Courte description                                     �
 ��������������������������������������������������������������������������͵
 � DialogMsgOk     � Bo�te de dialogue ordinaire avec bouton �Correcte�     �
 � ErrMsgOk        � Bo�te de dialogue d'erreur avec bouton �Correcte�      �
 � WarningMsg      � Bo�te de dailogue d'attention                          �
 � WarningMsgOk    � Bo�te de dialogue d'attention avec bouton �Correcte�   �
 � WarningMsgYesNo � Bo�te de dailogue d'attention avec bouton �Oui� & �Non��
 ����������������������������������������������������������������������������
}

Function ErrMsg{Const Msg:String;Key:Word):Word};Begin
 _LoadWave(StrPas(SoundPlay[sndError]));
 _PlayWave;
 ErrMsg:=InputMsg('Erreur',Msg,Key,wfSquare+wiDead,CurrKrs.ErrorWin.Window)
End;

{����������������������������������������������������������������������������
 �                            Proc�dure ErrMsgOk                            �
 ����������������������������������������������������������������������������


 Portabilit�: Global


 Description
 �����������

 Cette proc�dure affiche le message sp�cifi� avec une fen�tre d'environnement
 d'erreur avec une touche 'Correcte' en bas de la fen�tre.
}

Procedure ErrMsgOk{Const Msg:String};Begin
 ErrMsg(Msg,KeyOk)
End;

{ Cette proc�dure retourne le message d'erreur correspondant au code
 de la base de donn�es dans une bo�te de dialogue avec un bouton
 'Correcte'.
}

Procedure ErrNoMsgOk{Error:Word};Begin
 ErrMsgOk(GetErrMsg(Error));
End;

{�����������������������������������������������������������������������
 �                          Fonction GetDosErrMsg                      �
 �����������������������������������������������������������������������


 Portabilit�: Global


 Description
 �����������

  Cette fonction retourne une cha�ne de caract�res correspondant au code
 d'erreur envoyer en param�tre.
}

Function GetErrMsg{X:Word):String};Begin
 GetErrMsg:=SelectField('CHANTAL:/Systeme/Erreur.Dat',X,1);
End;

{��������������������������������������������������������������������������
 �                            Proc�dure InitDials                         �
 ��������������������������������������������������������������������������


 Portabilit�: Global


 Description
 �����������

  Cette proc�dure initialise  les services  d'horlogerie  et  d'application
 externe (si autoris� par le directive condition �Int8Dh�).


 Remarque
 ��������

  � L'interruption 8Dh est interruption de service s'occupant de la gestion
    des autres applications � celle-ci en cours...
}

Procedure InitDials;Begin
 _InitKbd:=InitKbd;
 TimeIn:=DivLong(GetRawTimer*10,182);
 Old:=GetRawTimerB;
 OldBackKbd:=_BackKbd;
 _BackKbd:=BackTimer;
End;

{�����������������������������������������������������������������������
 �                         Proc�dure InitEnv                           �
 �����������������������������������������������������������������������


 Portabilit�: Global


 Description
 �����������

  Cette proc�dure permet de charger une palette de couleur d'application
 de style �Bleuet�.
}

Procedure InitEnv;Begin
 _InitEnv(MtxBleuet)
End;

{�������������������������������������������������������������������
 �                      Proc�dure PutGrfIcon                       �
 �������������������������������������������������������������������


 Portabilit�: Global


 Description
 �����������

  Cette proc�dure permet l'affichage d'un Icon � partir d'un fichier
 d�j� existant sur le disque.
}

Procedure PutGrfIcon{Const Path:String;X,Y:Byte;P:Word};
Var
 Q:BlockButton;
Begin
 If(IsGraf)Then Begin
  GetFile(Path,P,SizeOf(Q),Q);
  PutIcn(X shl 3,GetRawY(Y),Q.Data)
 End
End;

{���������������������������������������������������������������������������
 �                            Proc�dure SetPosDate                         �
 ���������������������������������������������������������������������������


 Portabilit�: Global


 Description
 �����������

  Cette proc�dure fixe la position d'affichage en texte (X,Y) du pointeur de
 date � l'�cran. Elle est profite pour initialiser les donn�es la con�ernant
 pour �viter d'�crire 15 proc�dures frisant la redondance...
}

Procedure SetPosDate{X,Y:Byte};Assembler;ASM
 MOV AL,X
 MOV AH,Y
 MOV DateX.Word,AX
 XOR AX,AX
 MOV OldYear,AX
 {$IFDEF DosUnit}
  MOV OldMonth,AX
  MOV OldDay,AX
  MOV OldDayOfWeek,AX
 {$ELSE}
  MOV OldMonth,AL
  MOV OldDay,AL
  MOV OldDayOfWeek,AL
 {$ENDIF}
END;

{����������������������������������������������������������������������������
 �                            Proc�dure SetPosTime                          �
 ����������������������������������������������������������������������������


 Portabilit�: Global


 Description
 �����������

  Cette  proc�dure  fixe  la position du pointeur  de l'heure  sous le format
 texte (X,Y).  Il ne provoque pas son affichage imm�diat,  c'est la proc�dure
 d'arri�re plan enclanch� par �InitDials� s'occupant de cela.
}

Procedure SetPosTime{X,Y:Byte};Assembler;ASM
 MOV AL,X
 MOV AH,Y
 MOV Word Ptr TimeX,AX
END;

{����������������������������������������������������������������������
 �                   Proc�dure SetPosTimeAfterEndOfDay                �
 ����������������������������������������������������������������������


 Portabilit�: Global


 Description
 �����������

  Cette proc�dure fixe la position du pointeur de l'heure restant avant
 minuit sous le format texte (X,Y).  Il ne  provoque  pas son affichage
 imm�diat,  c'est la proc�dure d'arri�re plan enclanch� par �InitDials�
 s'occupant de cela.
}

Procedure SetPosTimeAfterEndOfDay{X,Y:Byte};Assembler;ASM
 MOV AL,X
 MOV AH,Y
 MOV Word Ptr TimeXA,AX
END;

{�����������������������������������������������������������������������
 �                      Proc�dure SetPosTimeInPrg                      �
 �����������������������������������������������������������������������


 Portabilit�: Global


 Description
 �����������

  Cette proc�dure fixe la position du pointeur  de l'heure depuis laquel
 l'application tourne sous le format texte  (X,Y).  Il ne  provoque  pas
 son affichage imm�diat, c'est la proc�dure d'arri�re plan enclanch� par
 �InitDials� s'occupant de cela.
}

Procedure SetPosTimeInPrg{X,Y:Byte};Assembler;ASM
 MOV AL,X
 MOV AH,Y
 MOV Word Ptr TimeXIn,AX
END;

{�����������������������������������������������������������������������
 �                       Proc�dure SetPosTimeMod                       �
 �����������������������������������������������������������������������


 Portabilit�: Global


 Description
 �����������

  Cette proc�dure fixe la position du pointeur  de l'heure depuis lequel
 le fichier  de musique  (soit n�cessairement  un  ".MOD")  joue!  Il ne
 provoque pas son affichage imm�diat,  c'est la proc�dure d'arri�re plan
 enclanch� par �InitDials� s'occupant de cela.
}

Procedure SetPosTimeMod{X,Y:Byte};Assembler;ASM
 MOV AL,X
 MOV AH,Y
 MOV Word Ptr TimeXMod,AX
END;

{�����������������������������������������������������������������������
 �                       Proc�dure SetPosTimeOnLine                    �
 �����������������������������������������������������������������������


 Portabilit�: Global


 Description
 �����������

  Cette proc�dure fixe la position du pointeur  de l'heure depuis lequel
 le modem est en ligne. Il ne provoque pas son affichage imm�diat, c'est
 la proc�dure  d'arri�re plan  enclanch� par  �InitDials�  s'occupant de
 cela.
}

Procedure SetPosTimeOnLine{X,Y:Byte};Assembler;ASM
 MOV AL,X
 MOV AH,Y
 MOV Word Ptr TimeXOnLine,AX
END;

{���������������������������������������������������������������������������
 �                          Proc�dure SetTimerMod                          �
 ���������������������������������������������������������������������������


 Portabilit�: Global


 Description
 �����������

  Cette proc�dure fixe l'heure de d�marrage d'une session m�lodique � partir
 du moment  exacte  o� cette pro�dure est appel�e. Il ne  provoque  pas  son
 affichage  imm�diat,  c'est  la proc�dure   d'arri�re  plan  enclanch�  par
 �InitDials� s'occupant de cela.
}

Procedure SetTimerMod;Begin
 TimeMod:=DivLong(GetRawTimer*10,182)
End;

{���������������������������������������������������������������������������
 �                         Proc�dure SetTimerModOff                        �
 ���������������������������������������������������������������������������


 Portabilit�: Global


 Description
 �����������

  Cette proc�dure rend inactif l'heure de d�marrage d'une session m�lodique.
}

Procedure SetTimerModOff;Assembler;ASM
 XOR AX,AX
 MOV Word Ptr TimeMod,AX
 MOV Word Ptr TimeMod[2],AX
END;

{��������������������������������������������������������������������������
 �                         Proc�dure SetTimerOnLine                       �
 ��������������������������������������������������������������������������


 Portabilit�: Global


 Description
 �����������

  Cette proc�dure fixe l'heure de d�marrage d'une session en ligne � partir
 du moment  exacte  o� le  programme est lanc�e.  Il ne  provoque  pas  son
 affichage  imm�diat,  c'est  la proc�dure  d'arri�re  plan  enclanch�  par
 �InitDials� s'occupant de cela.
}

Procedure SetTimerOnLine;Begin
 TimeOnLine:=DivLong(GetRawTimer*10,182)
End;

{��������������������������������������������������������������������������
 �                         Proc�dure SetTimerOnLineOff                    �
 ��������������������������������������������������������������������������


 Portabilit�: Global


 Description
 �����������

  Cette proc�dure rend inactif l'heure de d�marrage d'une session en ligne.
}

Procedure SetTimerOnLineOff;Assembler;ASM
 XOR AX,AX
 MOV Word Ptr TimeOnLine,AX
 MOV Word Ptr TimeOnLine[2],AX
END;

{�������������������������������������������������������������������
 �                       Fonction TimeToStr                        �
 �������������������������������������������������������������������


 Portabilit�: Global


 Description
 �����������

  Cette fonction retourne la date et l'heure sous forme de cha�ne de
 caract�res contenu dans une variable de format 32 bits.
}

Function TimeToStr{Time:LongInt):String};Begin
 TimeToStr:=CStrDate(Time)+' '+CStrTime(Time)
End;

{�����������������������������������������������������������������������
 �                         Proc�dure _InitAbsEnv                       �
 �����������������������������������������������������������������������


 Portabilit�: Global


 Description
 �����������

  Cette proc�dure permet de charger une palette de couleur d'application
 sp�cifique et non pas choisie par d�faut par le syst�me.
}

Procedure _InitAbsEnv{Palette:Byte};
Var
 Path:String;
Begin
 CurrPalette:=Palette;
 If FileExist('ISABEL.COL')Then Path:=''
                           Else Path:=MaltePath;
 GetFile(Path+'ISABEL.COL',Palette,SizeOf(CurrKrs),CurrKrs)
End;

{�����������������������������������������������������������������������
 �                          Proc�dure _InitEnv                         �
 �����������������������������������������������������������������������


 Portabilit�: Global


 Description
 �����������

  Cette proc�dure permet de charger une palette de couleur d'application
 choisie par d�faut par le syst�me.
}

Procedure _InitEnv{Default:Byte};
Var
 P:Byte;
Begin
 If(IsMono)Then P:=MtxMonochrome
  Else
 Begin
  If(IsGrf)Then Begin
   If BitsPerPixel=1Then P:=MtxBlackWhite Else
   If(Default=MtxOS2Win95)Then P:=Default
                          Else P:=MtxGraphix
  End
   Else
  If(CurrVideoMode)in[vmTxtBW40,vmTxtBW80]Then P:=MtxBlackWhite Else
  If(IsBlink)Then P:=MtxMagenta
             Else P:=Default
 End;
 _InitAbsEnv(P);
End;

{�������������������������������������������������������������ķ}
{�               O b j e t  B i t M a p   I c o n              �}
{�������������������������������������������������������������ͼ}

{��������������������������������������������������������������������
 �                         Proc�dure BMIcon                         �
 ��������������������������������������������������������������������


 Propri�taire: ButtonMnu
 Portabilit�:  Global


 Description
 �����������

  Cette proc�dure affiche les adaptations si n�cessaire � appliquer �
 l'ic�ne de l'objet �BitMap Ic�ne�.
}

Procedure BMIcon{Var Q:BlockButton};
Var
 L,J:Word;
Begin
 L:=32;
 If Not(BitsPerPixel in[15,16])Then Begin
  If(DegradSupport)and(Q.Data[1,0]=9)Then Begin
   For J:=0to 31do Begin
    MoveLeft(MatrixBorderLeft,Q.Data[J],4);
    MoveLeft(MatrixBorderRight,Q.Data[J,28],4)
   End;
   For J:=0to 3do Begin
    FillChr(Q.Data[J,J],L,48+(J shl 2));
    FillChr(Q.Data[31-J,J],L,252+J);
    Dec(L,2)
   End;
  End;
 End;
End;

Procedure BMIconXtra(Var Q:ButtonMnu;Var Buf:BlockButton;XR,YR:Word);Near;
Var
 J,ColorHigh:Byte;
 GX2,GY2:Word;
Begin
 If(BitsPerPixel>=15)and(DegradSupport)and(Buf.Data[1,0]=9)Then Begin
  GX2:=XR+31;GY2:=YR+31;
  For J:=0to 3do Begin
   ColorHigh:=((3-J)shl 6)+63;
   PutRect(XR,YR,GX2,GY2,RGB2Color(ColorHigh,ColorHigh,ColorHigh+(J shl 6)));
   ColorHigh:=RGB2Color(0,0,J shl 6);
   PutLnHor(XR,GY2,GX2,ColorHigh);
   PutLn(GX2,YR,GX2,GY2,ColorHigh);
   Inc(XR);
   Inc(YR);
   Dec(GX2);
   Dec(GY2);
  End;
 End;
End;

{�������������������������������������������������������������������
 �                        Proc�dure BMLoadAll                      �
 �������������������������������������������������������������������


 Propri�taire: ButtonMnu
 Portabilit�:  Global


 Description
 �����������

  Cette proc�dure affiche tous les icons contenus dans un fichier en
 les  affichant  sur  l'axe  horizontal  et  initialise  par la m�me
 occasion les  donn�es concernant  les icons pour une gestion future
 par la souris.
}

Procedure BMLoadAll{Var Q:ButtonMnu;Name:String;X,Y:Byte};
Var
 I:Integer;
 Buf:BlockButton;
 Handle:Hdl;
 XR2:Word;
 R:GraphPointRec;
Begin
 {$IFNDEF GraphicOS}If(IsGraf)and Not(HoleMode)Then {$ENDIF}Begin
  Q.X:=X;Q.Y:=Y;Q.Dir:=Hori;
  Q.FileName:=Name;
  Handle:=FileOpen(Name,fmRead);
  If(Handle=errHdl)Then Exit;
  Q.NB:=Systems.FileSize(Handle)div SizeOf(Buf);
  For I:=0to Q.NB-1do Begin
   Systems.GetRec(Handle,I,SizeOf(Buf),Buf);
   R.X:=X+(I shl 2);R.Y:=Y;
   If(R.X>NmXTxts)Then Begin
    XR2:=R.X div NmXTxts;
    If GetHeightChr=16Then Inc(R.Y,XR2 shl 1)
                      Else Inc(R.Y,XR2 shl 2);
    R.X:=R.X mod NmXTxts
   End;
   BMIcon(Buf);
   WordTxt2Graph(R);
   PutIcn(R.X,R.Y,Buf.Data);
   BMIconXtra(Q,Buf,R.X,R.Y);
  End;
  FileClose(Handle)
 End
End;

{�������������������������������������������������������������������
 �                      Proc�dure BMLoadAllVert                    �
 �������������������������������������������������������������������


 Propri�taire: ButtonMnu
 Portabilit�:  Global


 Description
 �����������

  Cette proc�dure affiche tous les icons contenus dans un fichier en
 les  affichant  sur  l'axe  vertical  et  initialise  par  la  m�me
 occasion les  donn�es concernant  les icons pour une gestion future
 par la souris.
}

Procedure BMLoadAllVert{Var Q:ButtonMnu;Name:String;X,Y,PerLine:Byte};
Var
 I:Integer;
 Buf:BlockButton;
 Handle:Hdl;
 XR2:Word;
 R:GraphPointRec;
Begin
 {$IFNDEF GraphicOS}If(IsGraf)and Not(HoleMode)Then{$ENDIF} Begin
  Q.X:=X;Q.Y:=Y;
  Q.Dir:=Vert;
  Q.FileName:=Name;
  Q.NB:=0;
  Q.PerLn:=PerLine;
  Handle:=FileOpen(Name,fmRead);
  If(Handle=errHdl)Then Exit;
  Q.NB:=Systems.FileSize(Handle)div SizeOf(Buf);
  For I:=0to Q.NB-1do Begin
   Systems.GetRec(Handle,I,SizeOf(Buf),Buf);
   R.X:=X+((I mod PerLine)shl 2);
   R.Y:=Y+((I div PerLine)shl 1);
   If GetHeightChr<>16Then ASM
    SHR R.Y,1
   END;
   If(R.X>NmXTxts)Then Begin
    XR2:=R.X div NmXTxts;
    If GetHeightChr=16Then Inc(R.Y,XR2 shl 1)
                      Else Inc(R.Y,XR2 shl 2);
    R.X:=R.X mod NmXTxts
   End;
   BMIcon(Buf);
   WordTxt2Graph(R);
   PutIcn(R.X,R.Y,Buf.Data);
   BMIconXtra(Q,Buf,R.X,R.Y);
  End;
  FileClose(Handle)
 End
End;

{������������������������������������������������������������������
 �                       Fonction BMUseXTexts                     �
 ������������������������������������������������������������������


 Propri�taire: ButtonMnu
 Portabilit�:  Global


 Description
 �����������

  Cette fonction permet de conna�tre la largeur en texte des ic�nes
 afficher et g�rer par cette objet �BitMap Ic�ne�.
}

Function BMUseXTexts{Var Q:ButtonMnu):Byte};
Var
 X:Byte;
Begin
 If(IsGraf)Then Begin
  If(Q.Dir=Hori)Then X:=Q.NB
                Else X:=Q.PerLn;
  BMUseXTexts:=(X shl 2)mod NmXTxts
 End
  Else
 BMUseXTexts:=0
End;

{������������������������������������������������������������������
 �                       Fonction BMUseYTexts                     �
 ������������������������������������������������������������������


 Propri�taire: ButtonMnu
 Portabilit�:  Global


 Description
 �����������

  Cette fonction permet de conna�tre la hauteur en texte des ic�nes
 afficher et g�rer par cette objet �BitMap Ic�ne�.
}

Function BMUseYTexts{Var Q:ButtonMnu):Byte};
Var
 Y:Byte;
Begin
 If(IsGraf)Then Begin
  Y:=Byte(Q.NB>0)shl 1;
  If GetHeightChr<>16Then ASM
   SHL Y,1
  END;
  If(Q.Dir=Vert)Then Y:=Y*(Q.NB div Q.PerLn);
  BMUseYTexts:=Y
 End
  else
 BMUseYTexts:=0
End;

{�������������������������������������������������������������
 �                      Fonction BMGetBut                    �
 �������������������������������������������������������������


 Propri�taire: ButtonMnu
 Portabilit�:  Global


 Description
 �����������

  Cette fonction retourne la position attribuer � un bouton en
 fonction d'un couple de coordonn�e texte.
}

Function BMGetBut{Var Q:ButtonMnu;X,Y:Byte):Word};
Var
 _Y:Byte;
 Ok:Boolean;
Begin
 BMGetBut:=$FFFF;
 If Not(IsGraf)Then Exit;
 Ok:=(Y>=Q.Y)and(Y<=Q.Y+BMUseYTexts(Q))and(X>=Q.X)and(X<Q.X+BMUseXTexts(Q));
 If(Q.Dir=Hori)Then Begin
  If(Ok)Then BMGetBut:=(X-Q.X)shr 2;
 End
  Else
 If(Ok)Then Begin
  _Y:=Byte(Q.NB>0)shl 1;
  If GetHeightChr<>16Then ASM SHL _Y,1;END;
  BMGetBut:=((X-Q.X)shr 2)+Q.PerLn*((Y-Q.Y)div _Y)
 End;
End;

{�������������������������������������������������������������ķ}
{�         O b j e t  L i g n e  I n d � p e n d a n t e       �}
{�������������������������������������������������������������ͼ}

{�������������������������������������������������������������
 �                     Constructeur LIInit                   �
 �������������������������������������������������������������


 Propri�taire: LineImage
 Portabilit�:  Local


 Description
 �����������

  Cette proc�dure  initialise  les donn�es  de l'objet  �Ligne
 Ind�pendante� utilis� par le menu d�roulant pour la s�lection
 d'un item.
}

Procedure LIInit{Var Q:LineImage};Begin
 FillClr(Q,SizeOf(Q))
End;

{�������������������������������������������������������������
 �                         Fonction LIPush                   �
 �������������������������������������������������������������


 Propri�taire: LineImage
 Portabilit�:  Local


 Description
 �����������

  Cette fonction permet d'effectuer une sauvegarde d'une ligne
 de coordonn�es texte accessible via l'objet.
}

Function LIPush{Var Q:LineImage;X1,Y,X2:Byte):Boolean};
{$IFDEF NoAsm}
 Begin
  LIPush:=False;
  Q.Size:=(X2-X1+1)shl 1;
  Q.X1:=X1;Q.Y:=Y;Q.X2:=X2;
  Q.Buf:=MemAlloc(Q.Size);
  If(Q.Buf=NIL)Then Exit;
  LICopy(Q);
  LIPush:=True;
 End;
{$ELSE}
 Assembler;ASM
  {$IFDEF FLAT386}
   PUSH EDI
    LEA EDI,DWord Ptr Q
     { Q.Size:=(X2-X1+1)shl 1;}
    MOVZX AX,X2
    SUB AL,X1
    INC AX
    SHL AX,1
    STOSW  {MOV [EDI].LineImage.Size,AX;ADD DI,2}
     { Q.X1:=X1;Q.Y:=Y;Q.X2:=X2; }
    ADD EDI,LineImage.X1-TYPE LineImage.Size
    MOV AL,X1
    MOV AH,Y
    STOSW
    MOV AL,X2
    STOSB
   POP EDI
    {Q.Buf:=MemAlloc(Q.Size);}
   LEA EDX,DWord Ptr Q
   MOV AX,[EDX].LineImage.Size
   CALL MemAlloc
   PUSH EDI
    LEA EDI,DWord Ptr Q
    SCASW
    CLD
    STOSW
    XCHG AX,DX
    STOSW
   POP EDI
    {If(Q.Buf=NIL)Then Exit;}
   OR AX,DX
   JZ @End
    {LICopy(Q);}
   LEA EAX,DWord Ptr Q
   CALL LICopy
    {LIPush:=Ya}
   MOV AL,True
@End:
  {$ELSE}
   CLD
   LES DI,Q
    { Q.Size:=(X2-X1+1)shl 1;}
   MOV AL,X2
   SUB AL,X1
   XOR AH,AH
   INC AX
   SHL AX,1
   STOSW  {MOV ES:[DI].LineImage.Size,AX;ADD DI,2}
    { Q.X1:=X1;Q.Y:=Y;Q.X2:=X2; }
   ADD DI,LineImage.X1-TYPE LineImage.Size
   MOV AL,X1
   MOV AH,Y
   STOSW
   MOV AL,X2
   STOSB
    {Q.Buf:=MemAlloc(Q.Size);}
   LES DI,Q
   PUSH ES:[DI].LineImage.Size
   CALL MemAlloc
   LES DI,Q
   {$IFDEF FuckedRecord}
    ADD DI,LineImage.Buf
   {$ELSE}
    SCASW
   {$ENDIF}
   CLD
   STOSW
   XCHG AX,DX
   STOSW
    {If(Q.Buf=NIL)Then Exit;}
   OR AX,DX
   JZ @End
    {LICopy(Q);}
   LES DI,Q
   PUSH ES
   PUSH DI
   CALL LICopy
    {LIPush:=Ya}
   MOV AL,True
@End:
  {$ENDIF}
 END;
{$ENDIF}

{����������������������������������������������������������������������
 �                             Proc�dure LICopy                       �
 ����������������������������������������������������������������������


 Propri�taire: LineImage
 Portabilit�:  Local


 Description
 �����������

  Cette fonction permet d'effectuer la copie de l'�cran vers la m�moire
 d'une ligne de coordonn�es texte accessible via l'objet.
}

Procedure LICopy{Var Q:LineImage};Begin
 If(IsGrf)Then MoveLeft(GetVideoBufPtr(Q.X1,Q.Y)^,Q.Buf^,(Q.X2-Q.X1+1)shl 1)
          Else CopyBoxTxt(Q.X1,Q.Y,Q.X2,Q.Y,Q.Buf^)
End;

{�����������������������������������������������������������������
 �                         Proc�dure LIPut                       �
 �����������������������������������������������������������������


 Propri�taire: LineImage
 Portabilit�:  Local


 Description
 �����������

  Cette proc�dure permet d'afficher la ligne courante pr�c�damment
 enregistrer par la proc�dure �LICopy�.
}

Procedure LIPut{Var Q:LineImage};
Var
 I:Byte;
 G:GraphBoxRec;
 Element:TextCube;
Begin
 If(IsGraf)Then Begin
  If(Q.CharacterTransparent)Then Begin
   G.X1:=Q.X1 shl 3;
   G.Y1:=GetRawY(Q.Y);
   G.X2:=((Q.X2+1) shl 3)-1;
   _LineBox2Line(Q.X1,Q.Y,Q.X2);
  End;
  For I:=Q.X1 to(Q.X2)do Begin
   Element:=TTextCube(Q.Buf^)[I-Q.X1];
   If(Q.CharacterTransparent)Then Begin
    SetGCubeT(G.X1,G.Y1,Element.Chr,Element.Attr);
    Inc(G.X1,8);
   End
    Else
   SetCube(I,Q.Y,Element.Chr,Element.Attr)
  End;
 End
  Else
 PutBoxTxt(Q.X1,Q.Y,Q.X2,Q.Y,Q.Buf^)
End;

{����������������������������������������������������������������������
 �                            Proc�dure LIReSave                      �
 ����������������������������������������������������������������������


 Propri�taire: LineImage
 Portabilit�:  Local


 Description
 �����������

  Cette fonction permet d'effectuer une nouvelle sauvegarde d'une ligne
 de coordonn�es texte accessible via l'objet.
}

Procedure LIReSave{Var Q:LineImage;X1,Y,X2:Byte};Begin
 If(Q.Buf<>NIL)Then Begin
  If(Q.X2-Q.X1<>X2-X1)Then Begin
   LIPop(Q);
   LIPush(Q,X1,Y,X2)
  End
   Else
  Begin
   LIPut(Q);
   ASM
     { Q.X1:=X1;Q.Y:=Y;Q.X2:=X2; }
    LES DI,Q
    CLD
    ADD DI,LineImage.X1
    MOV AL,X1
    MOV AH,Y
    STOSW
    MOV AL,X2
    STOSB
   END;
   LICopy(Q)
  End;
 End
  Else
 LIPush(Q,X1,Y,X2)
End;

{����������������������������������������������������������������������
 �                           Proc�dure LIBarSel                       �
 ����������������������������������������������������������������������


 Propri�taire: LineImage
 Portabilit�:  Local


 Description
 �����������

  Cette proc�dure affiche une barre s�lectionnement � la position d'une
 ligne de coordonn�es texte accessible via l'objet.
}

Procedure LIBarSel{Var Q:LineImage};
Var
 H,I:Byte;
 J,Y:Word;
 Color:Byte;
 Palette:Array[0..15]of Word;
Begin
 If(IsGrf)and(BitsPerPixel>=8)and(StyleBarMnu=sbmBadSeal)Then Begin
  If(StyleBackgroundMenu=sbmMacOsX)Then Begin
   _LineBox2LineStyle(Q.X1,Q.Y,Q.X2,RGB2Color($4F,$4F,$6F),LightBlue);
  End
   Else
  Begin
   Color:=(CurrKrs.Menu.Select shr 4);
   If Color=9Then Color:=LightRed;
   H:=GetHeightChar;
   MakePaletteColorToWhite(Color,8,Palette);
   If BitsPerPixel=8Then J:=4
                    Else J:=8;
   MakePaletteWhiteToColor(Color,8,Palette[J]);
   Y:=GetRawY(Q.Y);
   For J:=0to H-1do Begin
    ClrLnHor(Q.X1 shl 3,J+Y,(Q.X2-Q.X1+1)shl 3,GetPalette(Palette,J));
   End;
  End;
  For I:=Q.X1 to(Q.X2)do PutTxtFade(I,Q.Y,GetChr(I,Q.Y),
                                    CurrKrs.Menu.Select and$F,
                                    False);
 End
  Else
 Begin
  BarSelHor(Q.X1,Q.Y,Q.X2,CurrKrs.Menu.Select);
  BarSpcHorRelief(Q.X1,Q.Y,Q.X2,CurrKrs.Menu.Select)
 End;
End;

{������������������������������������������������������������������
 �                           Proc�dure LIPop                      �
 ������������������������������������������������������������������


 Propri�taire: LineImage
 Portabilit�:  Local


 Description
 �����������

  Cette fonction  permet  d'effectuer  une restitution  d'une ligne
 de coordonn�es texte accessible via l'objet pr�c�demmant effectuer
 �  l'aide  de  la fonction  �LIPush�  effectuant  la sauvegarde de
 celle-ci.
}

Procedure LIPop{Var Q:LineImage};Begin
 If(Q.Buf<>NIL)Then Begin
  LIPut(Q);
  FreeMemory(Q.Buf,Q.Size)
 End;
 ASM
  { Q.Buf:=NIL;Q.Size:=0 }
  XOR AX,AX
  LES DI,Q
  {$IFDEF Standard}
   MOV ES:[DI].LineImage.Size,AX
   MOV Word Ptr ES:[DI].LineImage.Buf,AX
   MOV Word Ptr ES:[DI].LineImage.Buf[2],AX
  {$ELSE}
   CLD
   STOSW
   STOSW
   STOSW
  {$ENDIF}
 END;
End;

{�������������������������������������������������������������ķ}
{�                 O b j e t  L i s t e  M e n u               �}
{�������������������������������������������������������������ͼ}

{ �������������������������������������������������������������������������
  �                             Constructeur LMInit                       �
  �������������������������������������������������������������������������


  Propri�taire: LstMnu
  Portabilit�:  Globale


  Description
  �����������

   Cette proc�dure permet d'effectuer l'initialisation d'une liste contenue
  dans une bo�te de dialogue avec une palette de couleur que vous d�sirez.
}

Procedure LMInit{Var Q:LstMnu;X1,Y1,X2,Y2:Byte;Const Title:String;Const Palette:MtxColors};Begin
 LMQInit(Q,X1,Y1,X2,Y2);
 WEPushWn(Q.W);
 WEPutWn(Q.W,Title,Palette);
 If Q.W.MaxY>=3Then WEPutBarMsRight(Q.W);
 WECloseIcon(Q.W)
End;

{ �������������������������������������������������������������������������
  �                          Constructeur LMInitKrDials                   �
  �������������������������������������������������������������������������


  Propri�taire: LstMnu
  Portabilit�:  Globale


  Description
  �����������

   Cette proc�dure permet d'effectuer l'initialisation d'une liste contenue
  dans une bo�te de dialogue avec la palette de couleur standard.
}

Procedure LMInitKrDials{Var Q:LstMnu;X1,Y1,X2,Y2:Byte;Const Title:String};Begin
 LMInit(Q,X1,Y1,X2,Y2,Title,CurrKrs.Dialog.Env.List)
End;

{ �������������������������������������������������������������������������
  �                           Constructeur _LMQInit                       �
  �������������������������������������������������������������������������


  Propri�taire: LstMnu


  Description
  �����������

   Cette proc�dure permet d'effectuer l'initialisation d'une liste contenue
  dans une bo�te de dialogue avec la palette de couleur sp�cifier en tenant
  compte d'�tre d�j� � l'int�rieur d'une bo�te de dialogue.
}

Procedure _LMQInit{Var Q:LstMnu;X1,Y1,X2,Y2:Byte;Title:String;Const Palette:MtxColors};Begin
 LMQInit(Q,X1,Y1,X2,Y2);
 WEPutWn(Q.W,Title,Palette);
 If Q.W.MaxY>=3Then WEPutBarMsRight(Q.W);
End;

{ �������������������������������������������������������������������������
  �                         Constructeur LMInitCenter                     �
  �������������������������������������������������������������������������


  Propri�taire: LstMnu
  Portabilit�:  Globale


  Description
  �����������

   Cette proc�dure permet d'effectuer l'initialisation d'une liste contenue
  dans une bo�te de dialogue d'une taille sp�cifier par les param�tres L et
  H situ�e  au  milieu  de l'�cran  avec  une palette  de couleur  que vous
  d�sirez.
}

Procedure LMInitCenter{Var Q:LstMnu;L,H:Byte;Title:String;Const Palette:MtxColors};
Var
 T:TextBoxRec;
Begin
 __GetCenterTxt(L,H,T);
 LMInit(Q,T.X1,T.Y1,T.X2,T.Y2,Title,Palette)
End;

{ �����������������������������������������������������������������������
  �                          Constructeur LMQInit                       �
  �����������������������������������������������������������������������


  Propri�taire: LstMnu
  Portabilit�:  Globale


  Description
  �����������

   Cette proc�dure permet d'effectuer l'initialisation d'une liste contenue
  dans une bo�te de dialogue sans toutefois afficher maintenant la bo�te de
  dialogue �LstMnu�.
}

Procedure LMQInit{Var Q:LstMnu;X1,Y1,X2,Y2:Byte};Begin
 FillClr(Q,SizeOf(Q));
 WEInit(Q.W,X1,Y1,X2,Y2)
End;

{ �������������������������������������������������������������������������
  �                          Proc�dure LMPutSmallShade                    �
  �������������������������������������������������������������������������


  Propri�taire: LstMnu
  Portabilit�:  Globale


  Description
  �����������

   Cette proc�dure permet d'afficher une ombrage de taille r�duite utiliser
  seulement � l'int�rieur d'une bo�te de dialogue existante (r�entrante).
}

Procedure LMPutSmallShade{Var Q:LstMnu};Begin
 Q.W.CloseIcon:=False;
 WEPutSmallBorder(Q.W)
End;

{ ��������������������������������������������������������������������
  �                        Proc�dure LMSetEndBar                     �
  ��������������������������������������������������������������������


  Propri�taire: LstMnu
  Portabilit�:  Globale


  Description
  �����������

   Cette proc�dure permet de d�finir la couleur d'attribut de la barre
  d'�tat  (situ� en bas  de la bo�te)  de l'objet de bo�te de dialogue
  �LstMnu�.
}

Procedure LMSetEndBar{Var Q:LstMnu;Attr:Byte};Begin
 WESetEndBar(Q.W,Attr)
End;

{ ��������������������������������������������������������������������
  �                        Proc�dure LMPutEndBar                     �
  ��������������������������������������������������������������������


  Propri�taire: LstMnu
  Portabilit�:  Globale


  Description
  �����������

   Cette proc�dure permet de d'afficher un message sur la barre d'�tat
 (situ� en bas de la bo�te) de l'objet de bo�te de dialogue �LstMnu�.
}

Procedure LMPutEndBar{Var Q:LstMnu;X:Byte;Const Msg:String;Attr:Byte};Begin
 WESetEndBarTxtX(Q.W,X,Msg,Attr)
End;

{ �������������������������������������������������������������������
  �                      Proc�dure LMPutBarMouseRight               �
  �������������������������������������������������������������������


  Propri�taire: LstMnu
  Portabilit�:  Globale


  Description
  �����������

   Cette proc�dure autorise la pr�sence d'une barre de d�placement de
  liste � la droite de la bo�te de dialogue �LstMnu�.
}

Procedure LMPutBarMouseRight{Var Q:LstMnu};Begin
 WEPutBarMsRight(Q.W)
End;

Procedure WEBarSpcHorBanderolle(Var Q:Window;Y:Byte;P:Word);
Var
 Color:RGB;
Begin
 WESetKrBorder(Q);
 If Odd(P)Then Begin
  If Q.CurrColor and$F0=$F0Then Begin
   Color.R:=224;
   Color.G:=224;
   Color.B:=255;
  End
   Else
  Begin
   Color:=DefaultRGB[Q.CurrColor shr 4];
   If Color.R<16Then Color.R:=0
                Else Dec(Color.R,16);
   If Color.G<16Then Color.G:=0
                Else Dec(Color.G,16);
   If Color.B<16Then Color.B:=0
                Else Dec(Color.B,16);
  End;
  WEPutFillBox(Q,0,GetRawY(Y),((Q.MaxX+1)shl 3)-1,
               GetRawY(Y+1)-1,RGB2Color(Color.R,Color.G,Color.B));
 End
  Else
 Begin
  WEBarSpcHor(Q,0,Y,wnMax);
 End;
End;

{ �����������������������������������������������������������������������
  �                            Proc�dure LMPutLn                        �
  �����������������������������������������������������������������������


  Propri�taire: LstMnu
  Portabilit�:  Local


  Description
  �����������

   Cette proc�dure affiche une ligne sp�cifique de la fen�tre de dialogue
  �LstMnu� d�finit par la variable de param�trage �J�.
}

Function LMPutLn(Var Q:LstMnu;J:Word):Boolean;Near;
Var
 Size:Word;
 PChrByte:^PCharByteRec;
 PC:PChr Absolute PChrByte;
Begin
 LMPutLn:=False;
 PChrByte:=ALGetBuf(Q.List,J,Size);
 If(PChrByte=NIL)Then Exit;
 Inc(Q.W.X,Q.Space4Icon);
 If(IsBanderolle)Then Begin
  WEBarSpcHorBanderolle(Q.W,Q.W.Y,J);
  Case(Size)of
   SizeOf(StrWordRec),SizeOf(StrByteRec),SizeOf(PCharWordRec),
   SizeOf(PCharByteRec),SizeOf(StrLongRec):WEPutTxtT(Q.W,StrPas(PChrByte^.PChr));
   Else WEPutTxtT(Q.W,StrPas(PC));
  End;
  If(Pointer(@Q.IconRoutine)<>NIL)Then Q.IconRoutine(WEGetRX1(Q.W),WEGetRealY(Q.W),J,Q.Context^);
 End
  Else
 Begin
  If(Pointer(@Q.IconRoutine)<>NIL)Then Q.IconRoutine(WEGetRX1(Q.W),WEGetRealY(Q.W),J,Q.Context^);
  Case(Size)of
   SizeOf(StrWordRec),SizeOf(StrByteRec),SizeOf(PCharWordRec),
   SizeOf(PCharByteRec),SizeOf(StrLongRec):WEPutPTxt(Q.W,PChrByte^.PChr);
   Else WEPutPTxt(Q.W,PC);
  End;
 End;
 LMPutLn:=True
End;

{ ������������������������������������������������������������������������
  �                          Proc�dure LMPutBarNSetKr                    �
  ������������������������������������������������������������������������


  Propri�taire: LstMnu
  Portabilit�:  Local


  Description
  �����������

   Cette proc�dure affiche la barre de d�placement de la liste de dialogue
  situ� � la droite de la bo�te ainsi  que la couleur courante de la bo�te
  de dialogue pour celle des bordures.
}

Procedure LMPutBarNSetKr(Var Q:LstMnu);Near;Begin
 If(Q.W.BarMouseRight)Then WEPutBarMsRight(Q.W);
 WESetKrBorder(Q.W)
End;

{ �������������������������������������������������������������������������
  �                           Proc�dure LMRefresh                         �
  �������������������������������������������������������������������������


  Propri�taire: LstMnu
  Portabilit�:  Globale


  Description
  �����������

   Cette proc�dure permet la r�actualisation (mise � jour) de l'image de la
  bo�te de dialogue �LstMnu�.
}

Procedure LMRefresh{Var Q:LstMnu};
Var
 J:Word;
Begin
 WEPutWn(Q.W,Q.W.Title,Q.W.Palette);
 LMPutBarNSetKr(Q);
 WESetPosHome(Q.W);
 For J:=Q.P-Q.Y to(Q.P-Q.Y+Q.W.MaxY)do Begin
  If LMPutLn(Q,J)Then WELn(Q.W)
                 Else Break;
 End;
 WESetPosHome(Q.W);
 If(@Q.OnRefresh<>NIL)Then Q.OnRefresh(Q,Q.Context^);
End;

{ ������������������������������������������������������������������
  �                      Proc�dure LMPutDataHome                   �
  ������������������������������������������������������������������


  Propri�taire: LstMnu
  Portabilit�:  Globale


  Description
  �����������

   Cette proc�dure se positionne au d�but de la liste de la bo�te de
  dialogue �LstMnu�.
}

Procedure LMPutDataHome{Var Q:LstMnu};
Var
 J:Byte;
Begin
 LMPutBarNSetKr(Q);
 WESetPosHome(Q.W);
 For J:=0to(Q.W.MaxY)do Begin
  If LMPutLn(Q,Q.P-Q.Y+J)Then WELn(Q.W)
                         Else Break;
 End;
End;

{ ��������������������������������������������������������������������
  �                         Proc�dure LMSelHor                       �
  ��������������������������������������������������������������������


  Propri�taire: LstMnu
  Portabilit�:  Local


  Description
  �����������

   Cette proc�dure affiche une barre de s�lectionnement de la bo�te de
  dialogue �LstMnu� � l'aide de la couleur d'attribut courante.


  Entr�e
  ������

   ES:DI ou EDX  = Adresse de l'enregistrement �LstMnu�.


  Remarque
  ��������

   � Voici le pseudo-code en langage Pascal pure de cette proc�dure:�
     ��������������������������������������������������������������������Ŀ
     � Procedure LMSelHor(Var Q:LstMnu);Near;Begin                        �
     �  WEBarSelHor(Q.W,Q.Space4Icon,Q.Y+Byte(Q.Descr)+Byte(Q.Sep),wnMax) �
     � End;                                                               �
     ����������������������������������������������������������������������
}

Procedure asmLMSelHor;Near;Assembler;ASM
 {$IFDEF FLAT386}
  MOV AL,[EDX].LstMnu.Y
  XCHG EAX,ECX
  MOV EAX,EDX
  ADD EAX,Offset LstMnu.W
  MOVZX EDX,Word Ptr [EDX-Offset LstMnu.W].LstMnu.Space4Icon
  PUSH wnMax
  CALL WEBarSelHor
 {$ELSE}
  MOV AL,ES:[DI].LstMnu.Y
  PUSH ES
  ADD DI,Offset LstMnu.W
  PUSH DI
  PUSH Word Ptr ES:[DI-Offset LstMnu.W].LstMnu.Space4Icon
  PUSH AX
  MOV BL,wnMax
  PUSH BX
  PUSH CS
  CALL Near Ptr WEBarSelHor
 {$ENDIF}
END;

{ �������������������������������������������������������������������
  �                        Proc�dure LMSelBar                       �
  �������������������������������������������������������������������


  Propri�taire: LstMnu
  Portabilit�:  Globale


  Description
  �����������

   Cette proc�dure affiche la barre de s�lectionnement de la bo�te de
  dialogue �LstMnu�.
}

Procedure LMSelBar{Var Q:LstMnu};Begin
 ASM
  {$IFDEF FLAT386}
   LEA EDX,DWord Ptr Q
   MOV AL,[EDX].LstMnu.W.Palette.Sel
   MOV [EDX].LstMnu.W.CurrColor,AL
   CALL asmLMSelHor
  {$ELSE}
   LES DI,Q
   MOV AL,ES:[DI].LstMnu.W.Palette.Sel
   MOV ES:[DI].LstMnu.W.CurrColor,AL
   CALL asmLMSelHor
  {$ENDIF}
 END;
 WESelRightBarPos(Q.W,Q.P,Q.List.Count-1);
 If(Pointer(@Q.OnMove)<>NIL)Then Q.OnMove(Q.Context^);
End;

{ �������������������������������������������������������������������
  �                     Proc�dure LMSelBarInactive                  �
  �������������������������������������������������������������������


  Propri�taire: LstMnu
  Portabilit�:  Globale


  Description
  �����������

   Cette proc�dure affiche la barre de s�lectionnement de la bo�te de
  dialogue �LstMnu� avec une couleur d'inactivit� ou non actif.
}

Procedure LMSelBarInactive{Var Q:LstMnu};Assembler;ASM
 {$IFDEF FLAT386}
  LEA EDX,DWord Ptr Q
  MOV [EDX].LstMnu.W.CurrColor,08Fh
  CALL asmLMSelHor
 {$ELSE}
  LES DI,Q
  MOV ES:[DI].LstMnu.W.CurrColor,08Fh
  CALL asmLMSelHor
 {$ENDIF}
END;

{ ������������������������������������������������������������������
  �                         Proc�dure LMUnSelBar                   �
  ������������������������������������������������������������������


  Propri�taire: LstMnu
  Portabilit�:  Globale


  Description
  �����������

   Cette proc�dure efface la barre de s�lectionnement de la bo�te de
  dialogue �LstMnu�.
}

Procedure LMUnSelBar{Var Q:LstMnu};Begin
 If(IsBanderolle)Then Begin
  WESetPos(Q.W,0,Q.Y);
  LMPutLn(Q,Q.P)
 End
  Else
 ASM
  {$IFDEF FLAT386}
   LEA EDX,DWord Ptr Q
   MOV AL,[EDX].LstMnu.W.Palette.Border
   MOV [EDX].LstMnu.W.CurrColor,AL
   CALL asmLMSelHor
  {$ELSE}
   LES DI,Q
   MOV AL,ES:[DI].LstMnu.W.Palette.Border
   MOV ES:[DI].LstMnu.W.CurrColor,AL
   CALL asmLMSelHor
  {$ENDIF}
 END;
End;

{ ������������������������������������������������������������������
  �                         Proc�dure LMPutEolLn                   �
  ������������������������������������������������������������������


  Propri�taire: LstMnu
  Portabilit�:  Local


  Description
  �����������

   Cette proc�dure affiche un item et efface le reste de la ligne o�
  il est afficher � l'int�rieur de la bo�te de dialogue �LstMnu�.
}

Procedure LMPutEolLn(Var Q:LstMnu);Near;Begin
 LMPutLn(Q,Q.P);
 WEClrEol(Q.W);
 WELn(Q.W)
End;

{ ��������������������������������������������������������������������
  �                          Proc�dure LMkUp                         �
  ��������������������������������������������������������������������


  Propri�taire: LstMnu
  Portabilit�:  Global


  Description
  �����������

   Cette proc�dure permet  d'imiter  le comportement  dans la bo�te de
  dialogue �LstMnu� de la touche clavier mont� (ou la fl�che indiquant
  le haut).
}

Procedure LMkUp{Var Q:LstMnu};Begin
 If Q.P>0Then Begin
  LMUnSelBar(Q);
  Dec(Q.P);
  If Q.Y>0Then Dec(Q.Y)
   Else
  Begin
   WESetPosHome(Q.W);
   WEScrollUp(Q.W,0,0,wnMax,wnMax);
   LMPutEolLn(Q)
  End;
  LMSelBar(Q)
 End;
End;

{ ������������������������������������������������������������������������
  �                              Proc�dure LMkDn                         �
  ������������������������������������������������������������������������


  Propri�taire: LstMnu
  Portabilit�:  Global


  Description
  �����������

   Cette  proc�dure  permet  d'imiter  le comportement  dans  la bo�te  de
  dialogue �LstMnu� de la touche clavier descendre (ou la fl�che indiquant
  le bas).
}

Procedure LMkDn{Var Q:LstMnu};Begin
 If Q.P<Q.List.Count-1Then Begin
  LMUnSelBar(Q);
  Inc(Q.P);
  If(Q.Y<Q.W.MaxY)Then Inc(Q.Y)
   Else
  Begin
   WEScrollDn(Q.W,0,0,wnMax,wnMax);
   Q.W.Y:=Q.W.MaxY;Q.W.X:=0;
   LMPutEolLn(Q)
  End;
  LMSelBar(Q)
 End
End;

{ ��������������������������������������������������������������������
  �                         Fonction LMGetVal                        �
  ��������������������������������������������������������������������


  Propri�taire: LstMnu
  Portabilit�:  Global


  Description
  �����������

   Cette fonction permet de conna�tre la valeur attribu� � la position
  courante dans la bo�te de dialogue liste de menu �LstMnu�.
}

Function LMGetVal{Var Q:LstMnu):LongInt};
Var
 Size:Word;
 Ptr:^LMPtrRec;
Begin
 LMGetVal:=0;
 If(Q.P>=Q.List.Count)Then Exit;
 Ptr:=ALGetBuf(Q.List,Q.P,Size);
 If(Ptr=NIL)Then Exit;
 Case(Size)of
  SizeOf(StrByteRec):LMGetVal:=Ptr^.StrByte.Nm;
  SizeOf(StrWordRec):LMGetVal:=Ptr^.StrWd.Nm;
  SizeOf(StrLongRec):LMGetVal:=Ptr^.StrLong.Nm;
  SizeOf(PCharByteRec):LMGetVal:=Ptr^.PChrByte.Nm;
  SizeOf(PCharWordRec):LMGetVal:=Ptr^.PChrWd.Nm;
  Else LMGetVal:=Q.P;
 End
End;

{ ���������������������������������������������������������������������
  �                         Proc�dure LMGotoPos                       �
  ���������������������������������������������������������������������


  Propri�taire: LstMnu
  Portabilit�:  Global


  Description
  �����������

   Cette proc�dure permet de changer la position courante dans la liste
  � celle envoyer comme variable de param�trage.
}

Procedure LMGotoPos{Var Q:LstMnu;Code:Word};
Label 1;
Var
 Size,PT:Word;
 Ptr:^LMPtrRec;
Begin
 ALSetPtr(Q.List,0);
 PT:=0;
 Repeat
  Ptr:=ALGetCurrBuf(Q.List,Size);
  Case(Size)of
   SizeOf(StrByteRec):If(Ptr^.StrByte.Nm=Code)Then Goto 1;
   SizeOf(StrWordRec):If(Ptr^.StrWd.Nm=Code)Then Goto 1;
   SizeOf(PCharByteRec):If(Ptr^.PChrByte.Nm=Code)Then Goto 1;
   SizeOf(PCharWordRec):If(Ptr^.PChrWd.Nm=Code)Then Goto 1;
   Else If(Code=PT)Then Goto 1;
  End;
  Inc(PT);
  If(PT>=Q.List.Count)Then Exit;
  ALNext(Q.List);
 Until Ptr=NIL;
 Exit;
1:
 Q.P:=PT;
 If(Q.P<Q.W.MaxY)Then Q.Y:=PT
                 Else Q.Y:=Q.W.MaxY-3;
End;

Procedure LMGotoSearch(Var Q:LstMnu);
Label 1;
Var
 Size,PT:Word;
 Ptr:^LMPtrRec;
Begin
 ALSetPtr(Q.List,0);
 PT:=0;
 Repeat
  Ptr:=ALGetCurrBuf(Q.List,Size);
  If CmpLeft(StrUp(StrPas(Ptr^.StrByte.PChr)),Q.SearchString)Then Goto 1;
  Inc(PT);
  If(PT>=Q.List.Count)Then Exit;
  ALNext(Q.List);
 Until Ptr=NIL;
 Exit;
1:
 Q.P:=PT;
 If(Q.P<Q.W.MaxY)Then Q.Y:=PT
                 Else Q.Y:=Q.W.MaxY-3;
End;

{ �������������������������������������������������������������������������
  �                             Fonction _LMRun                           �
  �������������������������������������������������������������������������


  Propri�taire: LstMnu
  Portabilit�:  Local


  Description
  �����������

   Cette fonction interpr�te le comportement de l'utilisateur et l'applique
  s'il  y a  lieu  � la bo�te  de dialogue.  Si le param�tre est actif,  il
  quittera la fonction quand il ne sera pas quoi faire et s'il est inactif,
  alors  continuera  et attendra  un comportement  appropri�  de la part de
  l'usager.
}

Function _LMRun(Var Q:LstMnu;F:Boolean):Word;Near;
Label
 Restart,Break,Fin,PgUp,PgDn,OtherKey;
Var
 K,TP:Word;
 S:String;
 Insert:Boolean;

 Procedure UpDate;Begin
  WEClrWnBorder(Q.W,0,0,wnMax,wnMax);
  LMPutDataHome(Q);
  LMSelBar(Q)
 End;

Begin
 _LMRun:=0;
 LMPutDataHome(Q);
 LMSelBar(Q);
 Repeat
Restart:K:=WEReadk(Q.W);
  Case(K)of
   kbInWn:Begin
    If Q.Y<>LastMouseY-WEGetRY1(Q.W)Then Begin
     __HideMousePtr;
     LMUnSelBar(Q);
     ASM
      {$IFDEF FLAT386}
        {Dec(Q.P,Q.Y);
         Q.Y:=LastMsY-WEGetRY1(Q.W);}
       LEA EDX,Q
       MOVZX AX,[EDX].LstMnu.Y
       SUB [EDX].LstMnu.P,AX
       XOR BX,BX
       ADD EDX,Offset LstMnu.W
       CALL asmWEGetR
       ADD AH,BL
       MOV AL,LastMouseY
       SUB AL,AH
       ADD EDX,Offset LstMnu.Y-Offset LstMnu.W
       MOV [EDX],AL
      {$ELSE}
        {Dec(Q.P,Q.Y);
         Q.Y:=LastMsY-WEGetRY1(Q.W);}
       LES DI,Q
       MOV AL,ES:[DI].LstMnu.Y
       XOR AH,AH
       SUB ES:[DI].LstMnu.P,AX
       XOR BX,BX
       ADD DI,Offset LstMnu.W
       CALL asmWEGetR
       ADD AH,BL
       MOV AL,LastMouseY
       SUB AL,AH
       ADD DI,Offset LstMnu.Y-Offset LstMnu.W
       STOSB
      {$ENDIF}
     END;
     Inc(Q.P,Q.Y);
     If(Q.P>=Q.List.Count)Then Begin
      Q.P:=Q.List.Count-1;
      Q.Y:=Q.P;
     End;
     LMSelBar(Q);
     __ShowMousePtr;
     If(Q.EnterOnDoubleClick)Then Begin
      WaitMouseBut0;
      Goto Restart;
     End;
    End;
    WaitMouseBut0;
    If(Pointer(@Q.OnClickButton)<>NIL)and(LastMouseB=1)Then Begin
     Q.OnClickButton(Q.Context^,Q.P);
    End
     Else
    If(Pointer(@Q.OnClickButton2)<>NIL)and(LastMouseB=2)Then Begin
     S:=Q.OnClickButton2(Q.Context^,Q.P,Insert);
     If S<>''Then Begin
      If(Insert)Then ALAddStr(Q.List,S)
       Else
      Begin
       ALDelBuf(Q.List,Q.P);
       ALInsStr(Q.List,Q.P,S);
      End;
      UpDate;
     End;
    End
     Else
    PushKey(kbEnter)
   End;
   kbCompat:Begin
    TP:=WEGetCompatPosition(Q.W,Q.List.Count);
    If(Q.P<>TP)Then Begin
     Q.P:=TP;
     If(Q.P<Q.W.MaxY)Then Q.Y:=Q.P
                     Else Q.Y:=Q.W.MaxY;
     __HideMousePtr;
     UpDate;
     __ShowMousePtr;
     Q.SearchString:='';
    End;
   End;
   kbRBarMsUp,kbRBarMsDn:Begin
    __HideMousePtr;
    Case(K)of
     kbRBarMsUp:LMkUp(Q);
     Else LMkDn(Q);
    End;
    DelayMousePress(100);
    __ShowMousePtr;
    Q.SearchString:='';
   End;
   kbUp:Begin
    LMkUp(Q);
    Q.SearchString:='';
   End;
   kbDn:Begin
    LMkDn(Q);
    Q.SearchString:='';
   End;
   kbRBarMsPgDn:Begin
    DelayMousePress(100);
    Goto PgDn;
   End;
   kbRBarMsPgUp:Begin
    DelayMousePress(100);
    Goto PgUp;
   End;
   kbPgUp:Begin
PgUp:If(Q.P<Q.W.MaxY)Then PushKey(kbHome)
     Else
    Begin
     Dec(Q.P,Q.W.MaxY);
     If(Q.P<Q.Y)Then Q.Y:=Q.P;
     UpDate;
    End;
    Q.SearchString:='';
   End;
   kbHome:If Q.P>0Then Begin
    Q.P:=0;Q.Y:=0;Q.SearchString:='';
    UpDate;
   End;
   kbIns:Begin
    If(Pointer(@Q.OnInsert)<>NIL)Then Begin
     S:=Q.OnInsert(Q.Context^);
     If S<>''Then Begin
      ALAddStr(Q.List,S);
      UpDate;
     End;
    End
     Else
    Goto OtherKey;
   End;
   kbPgDn:Begin
PgDn:If Q.P+(Q.W.MaxY shl 1)<Q.List.Count-1Then Begin
     Inc(Q.P,Q.W.MaxY);
     UpDate;
    End
     Else
    Goto Fin;
   End;
   kbEnd:Fin:If Q.P<Q.List.Count-1Then Begin
    Q.SearchString:='';
    Q.P:=Q.List.Count-1;
    Q.Y:=Q.W.MaxY;
    If(Q.P<=Q.W.MaxY)Then Q.Y:=Q.P;
    UpDate;
   End;
   kbCloseWin,kbEsc:Begin
    If(F)Then _LMRun:=kbEsc;
    Goto Break;
   End;
   kbEnter:Begin
    _LMRun:=LMGetVal(Q);
    Goto Break;
   End;
   kbBS:BackStr(Q.SearchString);
   Else Begin
    If Chr(K)=' 'Then Begin
     If(Pointer(@Q.OnModified)<>NIL)Then Begin
      S:=Q.OnModified(Q.Context^,Q.P);
      If S<>''Then Begin
       ALDelBuf(Q.List,Q.P);
       ALInsStr(Q.List,Q.P,S);
       UpDate;
      End;
     End
      Else
     Goto OtherKey;
    End
     Else
    OtherKey:If(F)Then Begin
     _LMRun:=K;
     Goto Break;
    End
     Else
    Begin
     IncStr(Q.SearchString,ChrUp(Chr(K)));
     LMGotoSearch(Q);
     Update;
    End;
   End;
  End
 Until False;
Break:
End;

{ �������������������������������������������������������������������������
  �                             Fonction LMRun                            �
  �������������������������������������������������������������������������


  Propri�taire: LstMnu
  Portabilit�:  Global


  Description
  �����������

   Cette fonction interpr�te le comportement de l'utilisateur et l'applique
  s'il  y a  lieu  � la  bo�te  de  dialogue.  Il ne quitte pas la fonction
  quand il ne sait  pas quoi faire  et continue  � attendre un comportement
  appropri� de la part de l'usager.


  Remarque
  ��������

   � Voici le pseudo-code en langage Pascal pure de la fonction:
     ��������������������������������������������������������������������Ŀ
     � Function LMRun(Var Q:LstMnu):Word;Begin                            �
     �  LMRun:=_LMRun(Q,False)                                            �
     � End;                                                               �
     ����������������������������������������������������������������������
}

Function LMRun{Var Q:LstMnu):Word};Assembler;ASM
 {$IFDEF FLAT386}
  MOV DL,False
  CALL _LMRun
 {$ELSE}
  LES DI,Q
  PUSH ES
  PUSH DI
  {$IFOPT G+}
   PUSH False
  {$ELSE}
   MOV AL,False
   PUSH AX
  {$ENDIF}
  CALL _LMRun
 {$ENDIF}
END;

{ �������������������������������������������������������������������������
  �                            Fonction LMRunKbd                          �
  �������������������������������������������������������������������������


  Propri�taire: LstMnu
  Portabilit�:  Global


  Description
  �����������

   Cette fonction interpr�te le comportement de l'utilisateur et l'applique
  s'il  y a  lieu  � la bo�te  de dialogue. Elle quittera la fonction quand
  elle ne sera pas quoi faire.


  Remarque
  ��������

   � Voici le pseudo-code en langage Pascal pure de la fonction:
     ��������������������������������������������������������������������Ŀ
     � Function LMRunKbd(Var Q:LstMnu):Word;Begin                         �
     �  LMRunKbd:=_LMRun(Q,True)                                          �
     � End;                                                               �
     ����������������������������������������������������������������������
}

Function LMRunKbd{Var Q:LstMnu):Word};Assembler;ASM
 {$IFDEF FLAT386}
  XOR EDX,EDX
  CALL _LMRun
 {$ELSE}
  LES DI,Q
  PUSH ES
  PUSH DI
  {$IFOPT G+}
   PUSH True
  {$ELSE}
   MOV AL,True
   PUSH AX
  {$ENDIF}
  CALL _LMRun
 {$ENDIF}
END;

{ �������������������������������������������������������������������������
  �                           Destructeur LMDone                          �
  �������������������������������������������������������������������������


  Propri�taire: LstMnu
  Portabilit�:  Global


  Description
  �����������

   Ce destructeur restitue l'image et la m�moire employ� par cette objet.
}

Procedure LMDone{Var Q:LstMnu};Begin
 WEDone(Q.W);
 ALDone(Q.List)
End;

{�������������������������������������������������������������������������
 �                            Fonction Input                             �
 �������������������������������������������������������������������������


 Portabilit�: Global


 Description
 �����������

  Cette fonction permet de demander � l'utilisateur d'entrer une cha�ne de
 caract�res de format ASCIIZ (PChar) avec les divers options standard pour
 l'�dition de sa cha�ne, autrement dit utilis� les fl�ches, BackSpace,...
}

Function Input{X1,Y,X2:Byte;MaxLen:Word;PassWord:Boolean;Var Str:PChr):Word};
Label Break,ClsCur;
Const
 Extra=256;
Var
 P:PChr;
 LenPhr,K,WL,B:Word;
 XPos:Integer;
 Ok:Boolean;
 M:TextCharRec;
 {$IFNDEF __Windows__}
  Chr:Char;
 {$ENDIF}
 J:Integer;        { Compteur de boucle de presse-papier }
 SC:String;        { Cha�ne de caract�res associ� au presse-papier }

 Procedure PutPCharAtXY(X,Y:Byte;Str:PChr;Start,Len:Word);
 Var
  I:Word;
  Chr:Char;
 Begin
  For I:=Start to(Start+Len)do Begin
   Chr:=Str^[I];
   If(Chr=#0)or(X+I-Start>X2)Then Exit;
   If(PassWord)Then Chr:='�';
   SetCube(X+I-Start,Y,Chr,GetKr)
  End
 End;

 Procedure MoveRight;
 Var
  I:Byte;
 Begin
  For I:=X2 downto X1+1do SetChr(I,Y,GetChr(I-1,Y))
 End;

 Procedure MoveLeft;
 Var
  I:Byte;
 Begin
  For I:=X1 to X2-1do SetChr(I,Y,GetChr(I+1,Y))
 End;

 Procedure ClrBoard;Begin
  BarSpcHor(X1,Y,X2,GetKr)
 End;

 Procedure ErrBoard;Begin
  BarSelHor(X1,Y,X2,CurrKrs.ErrorWin.Env.Input)
 End;

 Procedure NormalBoard;Begin
  _BarSelectHori(X1,Y,X2)
 End;

 Procedure AutoInsert;Begin
  If(GetModeIns)Then SetCur(GetHeightChr shr 1,GetHeightChr-1)
                Else SimpleCur
 End;

 Procedure SetTxtHm;Begin
  XPos:=WL;
  PutPCharAtXY(X1,Y,P,0,X2-X1)
 End;

 Procedure EndKey;Begin
  If LenPhr<>0Then Begin
   WL:=LenPhr;
   If(X2-X1<LenPhr)Then Begin
    XPos:=X2-X1;
    PutPCharAtXY(X1,Y,P,WL-XPos,XPos);
    SetCube(X2,Y,' ',GetKr);
   End
    Else
   SetTxtHm
  End
 End;

 Procedure PutBoard;Begin
  PutPCharAtXY(X1,Y,P,WL-XPos,X2-X1+1);
  If(LenPhr<WL-XPos+X2-X1)Then BarSpcHor(X2-((WL-XPos+X2-X1)-LenPhr),Y,X2,GetKr)
 End;

 Procedure Error;Begin
  ErrBoard;
  Beep;
  NormalBoard;
 End;

 Procedure HomeKey;Begin
  WL:=0;
  SetTxtHm;
  If(LenPhr<X2-X1)Then BarSpcHor(X1+LenPhr,Y,X2,GetKr)
 End;

 Function Init:Boolean;Begin
  Init:=False;
  ClrBoard;
  WL:=0;XPos:=0;
{  P:=MemNew(MaxLen+Extra);}
  P:=MemAlloc(MaxLen+Extra);
  If(P=NIL)Then Exit;
  If Not IsPChrEmpty(Str)Then StrCopy(P,Str)
                         Else P^[0]:=#0;
  LenPhr:=StrLen(P);
  If LenPhr<>0Then EndKey
              Else WL:=0;
  Init:=True
 End;

 Function Ctrl2(Var I:Integer):Boolean;Begin
  Ctrl2:=True;
  If P^[I]in[#1..#41,'[',']']Then Begin
   WL:=I;
   If(WL<X2-X1)Then XPos:=WL;
   PutBoard;
   Exit;
  End;
  If(I>LenPhr)Then EndKey
              Else Ctrl2:=False
 End;

 Procedure CtrlLeftKey;
 Label Break;
 Var
  I:Integer;
 Begin
  I:=WL;
  Repeat
   Dec(I);
   If I<1Then Begin
    HomeKey;
    Goto Break;
   End;
   If Ctrl2(I)Then Goto Break
  Until False;
Break:
 End;

 Procedure CtrlRightKey;
 Label Break;
 Var
  I:Integer;
 Begin
  If(WL>LenPhr)Then EndKey;
  I:=WL;
  If I<0Then HomeKey
   Else
  Repeat
   Inc(I);
   If Ctrl2(I)Then Goto Break
  Until False;
Break:
  If(WL>LenPhr)Then WL:=LenPhr
 End;

 Procedure DeleteEOLKey;Begin
  P^[WL]:=#0;LenPhr:=WL;
  BarSpcHor(X1+XPos,Y,X2,GetKr)
 End;

 Procedure DeleteWordKey;
 Label Break;
 Var
  OldLen:Word;

  Procedure Delete1;Begin
   StrDel(P,WL+1,1);
   Dec(LenPhr)
  End;

 Begin
  If LenPhr<WL+1Then Begin
   OldLen:=LenPhr;
   Repeat
    If(P^[WL+1]in[' ','A'..'Z','a'..'z'])and(WL+1<LenPhr)Then Delete1
                                                         Else Goto Break;
    If(WL>=LenPhr)Then Goto Break
   Until False;
Break:
   If(OldLen=LenPhr)Then Delete1
  End;
  ClrBoard;
  _PutPCharXY(X1,Y,P)
 End;

 Procedure LeftKey;
 Var
  Chr:Char;
 Begin
  If WL>0Then Begin
   Dec(WL);
   If XPos=0Then Begin
    MoveRight;
    If(PassWord)Then Chr:='�'
                Else Chr:=P^[WL];
    SetChr(X1,Y,Chr)
   End
    Else
   Dec(XPos)
  End
   else
  Error
 End;

 Procedure RightKey;
 Var
  Chr:Char;
 Begin
  If(WL<LenPhr)Then Begin
   Inc(WL);
   If(XPos=X2-X1)Then Begin
    MoveLeft;
    If(PassWord)Then Chr:='�'
                Else Chr:=P^[WL];
    SetChr(X1+XPos,Y,Chr)
   End
    Else
   Inc(XPos)
  End
   else
  Error
 End;

 Procedure InsertChar;
 Var
  Chr:Char;
 Begin
  If(MaxLen>LenPhr)Then Begin
   If(GetModeIns)Then Begin
    StrInsChr(P,WL,Char(K));
    If(WL<LenPhr)Then Begin
     Inc(LenPhr);Inc(WL);
     If(XPos<X2-X1)Then Inc(XPos);
     PutBoard
    End
     else
    Begin
     If(PassWord)Then Chr:='�'
                 Else Chr:=Char(K);
     If(XPos=X2-X1)Then Begin
      MoveLeft;
      SetChr(X1+XPos-1,Y,Chr)
     End
      Else
     Begin
      SetChr(X1+XPos,Y,Chr);
      Inc(XPos)
     End;
     Inc(WL);Inc(LenPhr)
    End
   End
    else
   Begin
    If LenPhr=0Then Begin
     P^[0]:=Char(K);P^[1]:=#0;
     XPos:=1;WL:=1;LenPhr:=1;
     If(PassWord)Then Chr:='�'
                 Else Chr:=P^[0];
     SetChr(X1,Y,Chr)
    End
     else
    Begin
     P^[WL]:=Char(K);
     If(WL>=LenPhr)Then Begin
      P^[WL+1]:=#0;
      Inc(LenPhr)
     End;
     Inc(WL);
     If(XPos<X2-X1)Then Inc(XPos);
     PutBoard
    End;
   End;
  End;
 End;

 Procedure Del;Begin
  If LenPhr>0Then Begin
   If(LenPhr>=WL)Then Begin
    StrDel(P,WL,1);
    Dec(LenPhr);
    PutBoard;
   End;
  End
   Else
  Error
 End;

Begin
 Input:=$FFFF;
 If Not(Init)Then Begin
  GetSysErr:=errOOM;
  Exit;
 End;
 AutoInsert;
 Repeat
  Ok:=False;
  {$IFNDEF __Windows__}
   If(ComInInput)and(ACReceive(Chr))Then Begin
    Case Byte(Chr)of
     caBS: K:=kbBS;
     caCR: K:=kbEnter;
     caESC: K:=kbEsc;
     Else K:=Byte(Chr);
    End;
    Ok:=True;
    Goto Break
   End;
  {$ENDIF}
  SetCurPos(X1+XPos,Y);
  Video.SetPos(X1+XPos,Y);
  If(IsGraf)Then Begin
   AutoInsert;
   PushCur;
  End;
  __ShowMousePtr;
  InitKbd;
  Repeat
   _BackKbd;
   __GetMouseTextSwitchZ(M,B);
   If B>0Then Begin
    If(M.Y=Y)and(M.X>=X1)and(M.X<=X2)Then Begin
     If(LenPhr<M.X-X1)Then Begin
      __HideMousePtr;
      ErrBoard;
      Beep;
      WaitMouseBut0;
      NormalBoard;
      __ShowMousePtr;
     End
      Else
     Begin
      XPos:=M.X-X1;
      SetCurPos(X1+XPos,Y)
     End
    End
     Else
    Begin
     __HideMousePtr;
     If(IsGraf)Then PopCur;
     Input:=kbMouse;
     StrCopy(Str,P);
     FreeMemory(P,MaxLen+Extra);
     Goto ClsCur;
    End
   End
  Until KeyPress;
  __HideMousePtr;
  If(IsGraf)Then Begin
   PopCur;
   CloseCur;
  End;
  If Not(Ok)Then K:=ReadKeyTypeWriter;
  Ok:=False;
  Case(K)of
   kbHome:HomeKey;
   kbLeft:LeftKey;
   kbRight:RightKey;
   kbEnd:EndKey;
   kbIns:AutoInsert;
   kbDel:Del;
   kbCtrlIns:PushClipboardTxt(StrPas(P));
   kbCtrlLeft:CtrlLeftKey;
   kbCtrlRight:CtrlRightKey;
   kbShiftIns:Begin
    SC:=GetClipboardTxt;
    For J:=1to Length(SC)do Begin
     K:=Byte(SC[J]);
     InsertChar;
    End;
   End;
   kbBS:Begin
    LeftKey;
    Del;
   End;
   kbCtrlY:Begin
    ClrBoard;
    P^[0]:=#0;LenPhr:=0;XPos:=0;WL:=0;
   End;
   Else If Char(K)in[#32..#255]Then InsertChar
    Else
   Begin
    StrCopy(Str,P);
    FreeMemory(P,MaxLen+Extra);
    Ok:=True;
   End;
  End
 Until Ok;
Break:Input:=K;
ClsCur:CloseCur;
End;

{������������������������������������������������������������������
 �                      Fonction _InputMsg                        �
 ������������������������������������������������������������������


 Portabilit�: Global


 Description
 �����������

  Cette fonction permet de demander � l'utilisateur de se faire une
 question  et de r�pondre  par la s�lection  d'une touche �cran. Il
 supporte les pectogrammes en mode graphiques  si vous souhaitez en
 avoir et peut tronquer une phrase en plusieurs lignes si le besoin
 s'en fait sentir.
}

Function _InputMsg{Const Title,Msg,Key:String;Flags:Byte;Const Kr:MtxInputColors):Word};
Const
 LenImage=6;
Var
 W:Window;
 I,L,H:Byte;
 MKrs:MtxColors;
 CurrColor,BorderColor:Word;
 G:GraphBoxRec;
 T:TextBoxRec;
Begin
 L:=0;
 For I:=1to Length(Key)do If Key[I]='|'Then Inc(L);
 L:=L*12+4;
 If(L<40)and(Length(Msg)>40)Then L:=40 else
 If(L<20)and(Length(Msg)>20)Then L:=20;
 If MaxXTxts>40Then Begin
  If Length(Msg)>40Then L:=50 Else
  If Length(Msg)<40Then Begin
   If L<Length(Msg)+4Then L:=Length(Msg)+4
  End
 End;
 If Not(IsGrf)Then Flags:=0;
 If Flags>0Then H:=GetNmLnMsg(0,L-LenImage,Msg)+5
           Else H:=GetNmLnMsg(0,L,Msg)+5;
 WEInitO(W,L,H);
 SetBorderSimpleLuxe;
 WEPushWn(W);
 MKrs.Title:=Kr.Title;
 MKrs.Border:=Kr.Border;
 MKrs.Key:=Kr.KeyUnactif;
 MKrs.kShade:=Kr.KeyShade;
 MKrs.kSel:=Kr.KeyActif;
 WEPutWn(W,Title,MKrs);
 WELn(W);
 WEBar(W);
 W.CurrColor:=Kr.Msg;
 If Flags>0Then Dec(W.MaxX,LenImage);
 WEPutMsg(W,Msg);
 If Flags>0Then Begin
  Inc(W.MaxX,LenImage);
  ASM
   {G.X1:=WEGetRX1(W)+W.MaxX-1-(LenImage shr 1);
    G.Y1:=WEGetRY1(W)+(W.MaxY shr 1);}
   PUSH SS
   POP ES
   MOV DI,Offset W
   ADD DI,BP
   MOV BX,Word Ptr W.MaxX
   SHR BH,1
   SUB BL,(LenImage SHR 1)+1
   CALL asmWEGetR
   ADD AX,BX
   MOV Word Ptr T.X1,AX
    {G.Y2:=G.Y1+HeightChr;}
   MOV Word Ptr T.X2,AX
  END;
  CoordTxt2Graph(T,G);
  Inc(G.Y2);
  CurrColor:=White;
  BorderColor:=Black;
  Case Flags and 7of
   wfLosange:Begin
    If BitsPerPixel>1Then BorderColor:=Green;
    FillLosange(G.X1,G.Y1,32,BorderColor);
   End;
   wfOctogone:Begin
    If BitsPerPixel>1Then BorderColor:=Red;
    FillOctogone(G.X1,G.Y2+4,24,BorderColor);
    Octogone(G.X1,G.Y2+3,22,White);
   End;
   wfSquare:Begin
    If BitsPerPixel>1Then BorderColor:=Yellow
                     Else BorderColor:=White;
    PutFillBox(G.X1-20,G.Y1-26,G.X1+28,G.Y1+20,BorderColor);
    PutRect(G.X1-18,G.Y1-24,G.X1+26,G.Y1+18,Black);
    CurrColor:=Black;
   End;
   wfCircle:Begin
    If BitsPerPixel>1Then BorderColor:=Blue;
    PutFillCircle(G.X1,G.Y1,22,BorderColor);
    Circle(G.X1,G.Y1,20,White);
   End;
  End;
  Case Flags and$F8of
   wiInfo:If(LoadGlyphs24)Then _OutTextXY(G.X1-4,G.Y1-16,#127,White);
   wiSTOP:Begin
    W.CurrColor:=White;
    ASM
      {W.X:=W.MaxX-6;W.Y:=W.MaxY shr 1;}
     MOV AX,Word Ptr W.MaxX
     SUB AL,6
     SHR AH,1
     MOV Word Ptr W.X,AX
    END;
    WEPutTxtT(W,'STOP');
   End;
   wiDead:If(LoadGlyphs24)Then _OutTextXY(G.X1-12,G.Y1-20,#100,Black);
   wiExit:If(LoadGlyphs24)Then Begin
    If(Flags and 7=wfOctogone)Then Inc(G.Y1,HeightChr shr 1);
    _OutTextXY(G.X1-12,G.Y1-12,#126,CurrColor);
   End;
  End;
 End;
 ClrKbd;
 _InputMsg:=WEGetkHorDn(W,Key);
 WEDone(W)
End;

{�������������������������������������������������������������������
 �                         Fonction InputMsg                       �
 �������������������������������������������������������������������


 Portabilit�: Global


 Description
 �����������

  Cette fonction permet  de demander � l'utilisateur de se faire une
 question  d�finit  par la cha�ne  de caract�re envoyer en param�tre
 par un variable num�rique et correspondant � un code de bouton bien
 pr�cis et de r�pondre  par la  s�lection  d'une  touche  �cran.  Il
 supporte les pectogrammes en mode graphiques  si vous  souhaitez en
 avoir et peut tronquer une phrase  en plusieurs lignes si le besoin
 s'en fait sentir.
}

Function InputMsg{Const Title,Msg:String;Key:Word;Flags:Byte;
                  Const Palette:MtxInputColors):Word};
{$IFDEF Windows}
 Var
  MtxKey:TMsgDlgButtons;
  Titre:TMsgDlgType;
{$ELSE}
 Var
  N,I:Byte;
  K:Word;
  StrKey:String;
  Buffer:Array[0..9]of Byte;
{$ENDIF}
Begin
 {$IFDEF Windows}
  MtxKey:=[];
  If(Key and KeyOk=KeyOk)Then MtxKey:=MtxKey+[mbOk];
  If(Key and KeyCancel=KeyCancel)Then MtxKey:=MtxKey+[mbCancel];
  If(Key and KeyYes=KeyYes)Then MtxKey:=MtxKey+[mbYes];
  If(Key and KeyNo=KeyNo)Then MtxKey:=MtxKey+[mbNo];
  Titre:=mtInformation{mtConfirmation};
  If(Flags and$F8=wiInfo)Then Titre:=mtInformation;
  If(Flags and$F8=wiSTOP)Then Titre:=mtWarning;
  If(Flags and$F8=wiDead)Then Titre:=mtError;
  Case MessageDlg(Msg,Titre,MtxKey,0)of
   mrOk:InputMsg:=kbOk;
   mrCancel:InputMsg:=kbCancel;
   mrAbort:InputMsg:=kbAbort;
   mrRetry:InputMsg:=kbRetry;
   mrIgnore:InputMsg:=kbIgnore;
   mrYes:InputMsg:=kbYes;
   mrNo:InputMsg:=kbNo;
   mrAll:InputMsg:=kbHelp;
   Else InputMsg:=kbClose;
  End;
 {$ELSE}
  Key2Str(Key,StrKey);N:=0;
  For I:=0to 9do If(Key shr I)and 1=1Then Begin
   Buffer[I]:=N;
   Inc(N)
  End
   Else
  Buffer[I]:=16;
  K:=_InputMsg(Title,Msg,StrKey,Flags,Palette);
  If K<10Then Begin
   I:=0;
   While K<>Buffer[I]do Inc(I);
   K:=KeyStrc[I]
  End;
  Case(K)of
   kbTitle:InputMsg:=kbF1;
   kbClose:InputMsg:=kbEsc;
   else InputMsg:=K;
  End
 {$ENDIF}
End;

Function IsBanderolle:Boolean;Begin
 IsBanderolle:=(IsGrf)and(Banderolle)and(BitsPerPixel>=8);
End;

{����������������������������������������������������������������������
 �                              Fonction JoyX                         �
 ����������������������������������������������������������������������


  Portabilit�: Global


  Description
  �����������

   Cette fonction indique la position horizontal du pointeur de manette
  de jeux.
}

{$IFDEF Joystick}
Function JoyX(Joy:Byte):ShortInt;
Var
 X:ShortInt;
Begin
 X:=(JoyPos(Joy shl 1)*3)div JoyPotentioMeter;
 If X<=0Then JoyX:=-1 Else
 If X>1Then JoyX:=1
       Else JoyX:=0;
End;

{�����������������������������������������������������������������������
 �                              Fonction JoyY                          �
 �����������������������������������������������������������������������


  Portabilit�: Global


  Description
  �����������

   Cette fonction indique la position vertical du pointeur de manette de
  jeux.
}

Function JoyY(Joy:Byte):ShortInt;
Var
 Y,Y2:Integer;
Begin
 Y:=(JoyPos((Joy shl 1)+1)*25{3})div JoyPotentioMeter;
 Y2:=(JoyPos((Joy shl 1)+1)*{3}25)div JoyPotentioMeter;
 If(Y2<>Y)Then JoyY:=0 Else
 If Y<{=0}4Then JoyY:=-1 Else
 If Y>{1}14Then JoyY:=1
 Else JoyY:=0;
End;
{$ENDIF}

{��������������������������������������������������������������������
 �                        Proc�dure PutLastBar                      �
 ��������������������������������������������������������������������


 Portabilit�: Global


 Description
 �����������

  Cette proc�dure permet d'afficher un message d'aide sur la derni�re
 ligne r�server � l'application.
}

Procedure PutLastBar{X:Byte;Const Msg:String};Begin
 If(HelpBar)Then Begin
  If X>0Then BarSpcHor(0,MaxYTxts,X-1,GetKr);
  PutTypingXY(X,MaxYTxts,Msg);
  BarSpcHor(GetXTxtsPos,GetYTxtsPos,MaxXTxts,GetKr)
 End;
End;

{������������������������������������������������������������������������
 �                           Fonction WarningMsg                        �
 ������������������������������������������������������������������������


 Portabilit�: Global


 Description
 �����������

  Cette fonction  affiche  une bo�te  de dialogue  de message d'attention
 avec une panquart Arr�t/STOP en mode graphique et attend un comportement
 utilisateur conforme un combinaison num�rique de touche �cran d�finit.
}

Function WarningMsg{Const Msg:String;Key:Byte):Word};Begin
 _LoadWave(StrPas(SoundPlay[sndWarning]));
 _PlayWave;
 WarningMsg:=InputMsg('Attention',Msg,Key,wfOctogone+wiSTOP,CurrKrs.WarningWin)
End;

{������������������������������������������������������������������������
 �                         Fonction WarningMsgYesNo                     �
 ������������������������������������������������������������������������


 Portabilit�: Global


 Description
 �����������

  Cette fonction  affiche  une bo�te  de dialogue  de message d'attention
 avec une panquart Arr�t/STOP en mode graphique et attend un comportement
 utilisateur entre un �Oui� ou un �Non�.
}

Function WarningMsgYesNo{Const Msg:String):Word};Begin
 WarningMsgYesNo:=WarningMsg(Msg,KeyYes+KeyNo)
End;

{������������������������������������������������������������������������
 �                          Proc�dure WarningMsgOk                      �
 ������������������������������������������������������������������������


 Portabilit�: Global


 Description
 �����������

  Cette fonction  affiche  une bo�te  de dialogue  de message d'attention
 avec une panquart Arr�t/STOP en mode graphique et attend un comportement
 utilisateur confirmant qu'il a belle et bien lu le message.
}

Procedure WarningMsgOk{Const Msg:String};Begin
 WarningMsg(Msg,KeyOk)
End;

{����������������������������������������������������������������������
 �                          Fonction WinInpH                          �
 ����������������������������������������������������������������������


 Portabilit�: Global


 Description
 �����������

  Cette fonction pose une question � l'utilisateur pouvant �tre censur�
 � l'int�rieur  d'une bo�te de  dialogue  avec  en prime  un historique
 dans lequel il peut consulter  et choisir  s'il correspond � besoin de
 l'utilisateur.
}

Function WinInpH{L:Byte;Const Title,Msg:String;Const Palette:MtxColors;
                 PassWord:Boolean;Var Output:String;Var Q:History;
                 PrevNext:Boolean):Word};
Label Beginning,Break;
Const
 Ok=0;                { Touche �Correcte� }
 Cancel=1;            { Touche �Annuler� }
 MaxBuffer=255;
Var
 W:Window;
 B:Array[0..MaxBuffer]of Char;
 S:String;
 K:Word;
 BP:PChr;
Begin
 {$IFDEF Windows}
  If InputQuery(Title,Msg,Output)Then WinInpH:=kbEnter
                                 Else WinInpH:=kbEsc;
 {$ELSE}
  If(PrevNext)Then S:='Suivant|Pr�c�dent|Annuler'
              Else Key2Str(KeyOk+KeyCancel,S);
  WEInitO(W,L,7);
  WEPushWn(W);
  WEPutWn(W,Title,Palette);
  WEPutkHorDn(W,S);
  WELn(W);
  WEBar(W);
  WEPutTxtLn(W,Msg);
  FillClr(B,SizeOf(B));
  StrPCopy(@B,Output);
  BP:=@B;
  If Q.SizeCmd>0Then ASM
    {PutUpIcon(WEGetRX1(W)+L-UpIconLen-2,WEGetRY1(W)+2,CurrKrs.OpenWin.Wins.Icon);}
   PUSH SS
   POP ES
   MOV DI,Offset W
   ADD DI,BP
   CALL asmWEGetR
   ADD AL,L
   SUB AL,UpIconLen
   SUB AL,2
   PUSH AX
   ADD AH,2
   MOV AL,AH
   PUSH AX
   PUSH Word Ptr CurrKrs.OpenWin.Window.Icon
   CALL Adele.UpIcon
  END;
  Repeat
   If Q.SizeCmd>0Then Begin
Beginning:
    WESetInpColors(W,CurrKrs.OpenWin.Env.Input,CurrKrs.OpenWin.Env.Input);
    K:=_WEInput(W,0,2,L-UpIconLen-3,MaxBuffer,BP);
    Case(K)of
     kbUp:Begin
      HYQueue(Q,StrPas(BP));
      StrPCopy(BP,HYChoice(Q,WEGetRX1(W)+W.MaxX-1,WEGetRY1(W)+1));
      Goto Beginning;
     End;
     kbEsc:;
     Else HYQueue(Q,StrPas(BP));
    End;
   End
    Else
   K:=WEInp(W,BP,MaxBuffer,PassWord);
   If(K=kbEsc)Then Goto Break;
   K:=WEGetkHorDn(W,S);
   If(PrevNext)Then Begin
    Case(K)of
     0,1:Begin
      K:=K xor 1;
      Output:=StrPas(BP);
      Goto Break;
     End;
     2:Begin
      K:=kbAbort;
      Goto Break;
     End;
    End;
   End
    Else
   Begin
    If(K=Cancel)Then Goto Break;
    If(K=Ok)Then K:=kbEnter;
    If(K=kbEnter)Then Begin
     Output:=StrPas(BP);
     Goto Break;
    End
   End;
  Until False;
 Break:
  WinInpH:=K;
  WEDone(W)
 {$ENDIF}
End;

{����������������������������������������������������������������������
 �                         Fonction WinInp                            �
 ����������������������������������������������������������������������


 Portabilit�: Global


 Description
 �����������

  Cette fonction pose une question � l'utilisateur pouvant �tre censur�
 � l'int�rieur d'une bo�te de dialogue sans historique disponible.
}

Function WinInp{L:Byte;Const Title,Msg:String;Const Palette:MtxColors;
                PassWord:Boolean;Var Output:String):Word};
Var
 Q:History;
Begin
 HYInit(Q,0);
 WinInp:=WinInpH(L,Title,Msg,Palette,PassWord,Output,Q,False);
 HYDone(Q);
End;

{������������������������������������������������������������������������
 �                             Fonction _WinInp                         �
 ������������������������������������������������������������������������


 Portabilit�: Global


 Description
 �����������

  Cette fonction pose une question � l'utilisateur pouvant �tre censur� �
 l'int�rieur d'une bo�te de dialogue sans historique disponible mais avec
 la couleur de dialogue par d�faut.
}

Function _WinInp{L:Byte;Const Title,Msg:String;PassWord:Boolean;Var Output:String):Word};Begin
 _WinInp:=WinInp(L,Title,Msg,CurrKrs.Dialog.Window,PassWord,Output);
End;

{�����������������������������������������������������������������
 �                        Fonction Key2Str                       �
 �����������������������������������������������������������������


 Portabilit�: Local


 Description
 �����������

  Cette fonction retourne une cha�ne de caract�res correspondant �
 l'attribut donn� comme cl� en param�tre.  La cha�ne de caract�res
 devra par la suite  �tre utilis�  par des boutons afin de pouvoir
 afficher convenablement la connaissance transmise.
}

Function Key2Str{Key:Word;Var Str:String):Byte};
Var
 I,N:Byte;
Begin
 N:=0;Str:='';
 For I:=0to 9do If(Key shr I)and 1=1Then Begin
  Inc(N);
  If Str<>''Then IncStr(Str,'|');
  AddPChr(Str,StrKey[I])
 End;
 Key2Str:=N
End;

{�������������������������������������������������������������ķ}
{�          O b j e t   S e l e c t e  E x t e n d e d         �}
{�������������������������������������������������������������ͼ}

{ ������������������������������������������������������������������������
  �                           Constructeur SEInit                        �
  ������������������������������������������������������������������������


  Propri�taire: SectionRec
  Portabilit�:  Global


  Description
  �����������

   Ce constructeur permet d'initialiser l'objet de s�lecteur de bouton
  dans une fen�tre de dialogue.
}

Procedure SEInit{Var Q:SectionRec;L:Byte;Const Title:String};Begin
 FillClr(Q,SizeOf(Q));
 Q.L:=L;
 Q.W.Title:=Title;
End;

{ ������������������������������������������������������������������
  �                        Proc�dure SEAdd                         �
  ������������������������������������������������������������������


  Propri�taire: SectionRec
  Portabilit�:  Global


  Description
  �����������

   Cette proc�dure permet d'ajouter une nouvelle s�lection de bouton
  dans une fen�tre de dialogue.
}

Procedure SEAdd{Var Q:SectionRec;Const k:String};Begin
 ALAddStr(Q.X,k)
End;

Procedure SEAssociateImageRes{Var Q:SectionRec;Const Name:String;Start:Word;ImageLen:Byte};Begin
 If(IsGrf)and(MediaSupport)and(FileExist(Name))Then Begin
  Q.ImageAssistant:=True;
  Q.FileName:=Name;
  Q.StartIndex:=Start;
  Q.IL:=ImageLen;
 End;
End;

{ ������������������������������������������������������������������������
  �                           Proc�dure SEPutWn                          �
  ������������������������������������������������������������������������


  Propri�taire: SectionRec
  Portabilit�:  Global


  Description
  �����������

   Cette proc�dure permet d'initialiser la bo�te de dialogue de l'objet de
  s�lection de bouton dans une fen�tre de dialogue.
}

Procedure SEPutWn{Var Q:SectionRec};
Var
 Title:String;
 I,X,Y:Byte;
 Double:Boolean;
Begin
 Title:=Q.W.Title;
 Double:=Q.X.Count>=12;
 Q.LY:=Q.X.Count shr Byte(Double)+(Q.X.Count and 1);
 WEInitO(Q.W,Q.L*(Byte(Double)+1)+Q.IL,(Q.LY shl 1)+2);
 WEPushWn(Q.W);
 WEPutWnKrDials(Q.W,Title);
 WECloseIcon(Q.W);
 WEBar(Q.W);
 For I:=0to Q.X.Count-1do Begin
  If(Double)and(Q.X.Count shr 1<=I)Then Begin
   X:=Q.L;Y:=1+(I-Q.LY)shl 1;
  End
   Else
  Begin
   X:=2;Y:=1+(I shl 1);
  End;
  WEPutkHor(Q.W,X,Y,Q.L-5,_ALGetStr(Q.X,I));
 End;
End;

{���������������������������������������������������������������������������
 �                              Proc�dure SEBar                            �
 ���������������������������������������������������������������������������


 Propri�taire: SectionRec
 Portabilit�:  Global


 Description
 �����������

  Cette proc�dure affiche une barre � la s�lection courante avec la courante
 dans l'objet de bouton dans une fen�tre de dialogue.
}

Procedure SEBar{Var Q:SectionRec};
Var
 X,Y:Byte;
 Dbl,Sel:Boolean;
 XTab:XTabType;
Begin
 Dbl:=Q.X.Count>=12;
 If(Dbl)and(Q.X.Count shr 1<=Q.P)Then Begin
  X:=Q.L;
  Y:=(Q.P-Q.LY)shl 1;
 End
  Else
 Begin
  X:=2;
  Y:=Q.P shl 1;
 End;
 Sel:=Q.W.CurrColor and$F=$C;
 If(Sel)and(Q.ImageAssistant)Then _RIViewImage(Q.FileName,Q.StartIndex+Q.P,Q.W,1,1,200,$FFFF,0);
 __WEPutkHor(Q.W,X,1+Y,Q.L-5,_ALGetStr(Q.X,Q.P),XTab,Sel);
End;

{�������������������������������������������������������������������������
 �                             Fonction SERun                            �
 �������������������������������������������������������������������������


 Propri�taire: SectionRec
 Portabilit�:  Global


 Description
 �����������

  Cette fonction permet � l'utilisateur de choisir un des items de l'objet
 de bouton dans une fen�tre de dialogue.
}

Function SERun{Var Q:SectionRec):Word};
Label MJBar;
Var
 K:Word;
 T:Byte;

 Procedure UnBar;Begin
  Q.W.CurrColor:=GetKeyKr;
  SEBar(Q);
 End;

Begin
MJBar:
 Q.W.CurrColor:=GetKeySelKr;
 SEBar(Q);
 Repeat
  K:=WEReadk(Q.W);
  Case(K)of
   kbUp,kbDn:Begin
    UnBar;
    Case(K)of
     kbUp:If Q.P>0Then Dec(Q.P)
                  Else Q.P:=Q.X.Count-1;
     Else If Q.P<Q.X.Count-1Then Inc(Q.P)
                         Else Q.P:=0;
    End;
    Goto MJBar;
   End;
   kbInWn:Begin
    WaitMouseBut0;
    T:=(LastMouseY-WEGetRY1(Q.W))shr 1;
    If(Q.P<>T)Then Begin
     UnBar;
     Q.P:=T;
     Goto MJBar;
    End
     Else
    Begin
     K:=kbEnter;
     Break;
    End;
   End;
   kbClose:Begin
    K:=kbEsc;
    Break;
    End;
   kbEnter,kbEsc:Break;
  End;
 Until False;
 SERun:=K;
End;

{�������������������������������������������������������������������
 �                         Destructeur SEDone                      �
 �������������������������������������������������������������������


 Propri�taire: SectionRec
 Portabilit�:  Global


 Description
 �����������

  Ce destructeur lib�re la m�moire et efface la bo�te de dialogue se
 rapportant � l'objet de bouton dans une fen�tre de dialogue.
}

Procedure SEDone{Var Q:SectionRec};Begin
 WEDone(Q.W);
 ALDone(Q.X)
End;

{�������������������������������������������������������������ķ}
{�             O b j e t  W i n d o w  E n h a n c e d         �}
{�������������������������������������������������������������ͼ}

{��������������������������������������������������������������������������}
{����������������������������� Classe Priv�e ������������������������������}
{��������������������������������������������������������������������������}

{���������������������������������������������������������������������������
 �                            Proc�dure AsmWEAlign                         �
 ���������������������������������������������������������������������������


 Propri�taire: Wins
 Portabilit�:  Local


 Description
 �����������

  Cette proc�dure permet d'adapter si n�cessaire calcul� provisoirement s'il
 s'agit d'un  coordonn�e maximal  ou non et  de l'adapter  en fonction de se
 maximum.  Les  param�tres de position est dans le registre AL et le maximum
 dans le registre AH du micro-processeur.


 Entr�e
 ������

  AH          = Valeur maximum � y mettre si code sup�rieur � 240
  AL          = Valeur � adapter


 Sortie
 ������

  AL          = Valeur adapter
}

Procedure AsmWEAlign;Near;Assembler;ASM
 CMP AL,0F0h              { Valeur sup�rieur � 240? }
 JB  @1
 NOT AL                   { Non, bien d�caler � partir du maximum }
 AND AL,0Fh
 SUB AH,AL
 JMP @2
@1:CMP AL,AH
 JB @3
@2:MOV AL,AH
@3:
END;

{���������������������������������������������������������������������������
 �                          Proc�dure AsmWEAlignEnd                        �
 ���������������������������������������������������������������������������


 Propri�taire: Wins
 Portabilit�:  Local


 Description
 �����������

  Cette proc�dure permet d'adapter si n�cessaire calcul� provisoirement s'il
 s'agit d'un  coordonn�e maximal  ou non et  de l'adapter  en fonction de se
 maximum. Les param�tres de position est dans les registres (AL,AH).


 Entr�e
 ������

  ES:DI       = Adresse de l'enregistrement �Wins�.
  AL          = Valeur X � adapter
  AH          = Valeur Y � adapter

 Sortie
 ������

  AL          = Valeur adapter de X
  AH          = Valeur adapter de Y
}

Procedure AsmWEAlignEnd;Near;Assembler;ASM
 {$IFDEF FLAT386}
  PUSH EBX
   MOV BL,AH
   MOV AH,[EDX].Window.MaxX
   CALL AsmWEAlign
   XCHG AX,BX
   MOV AH,[EDX].Window.MaxY
   CALL AsmWEAlign
   XCHG AX,BX
   MOV AH,BL
  POP EBX
 {$ELSE}
  MOV BL,AH
  MOV AH,ES:[DI].Window.MaxX
  CALL AsmWEAlign
  XCHG AX,BX
  MOV AH,ES:[DI].Window.MaxY
  CALL AsmWEAlign
  XCHG AX,BX
  MOV AH,BL
 {$ENDIF}
END;

{����������������������������������������������������������������������������
 �                           Fonction WEAlignEndX                           �
 ����������������������������������������������������������������������������


 Propri�taire: Wins
 Portabilit�:  Local


 Description
 �����������

  Cette fonction retourne la coordonn�e X convertie s'il y a lieu en fonction
 du maximum fictif commen�ant � 240.
}

Function WEAlignEndX{Var Inf:Wins;X:Byte):Byte};Assembler;ASM
 {$IFDEF FLAT386}
  XCHG EDX,EAX
  MOV AH,[EDX].Window.MaxX
  MOV AL,X
  CALL AsmWEAlign
 {$ELSE}
  LES DI,Inf
  MOV AH,ES:[DI].Window.MaxX
  MOV AL,X
  CALL AsmWEAlign
 {$ENDIF}
END;

{����������������������������������������������������������������������������
 �                           Fonction WEAlignEndY                           �
 ����������������������������������������������������������������������������


 Propri�taire: Wins
 Portabilit�:  Local


 Description
 �����������

  Cette fonction retourne la coordonn�e X convertie s'il y a lieu en fonction
 du maximum fictif commen�ant � 240.
}

Function WEAlignEndY{Var Inf:Wins;Y:Byte):Byte};Assembler;ASM
 {$IFDEF FLAT386}
  XCHG EAX,EDX
  MOV AH,[EDX].Window.MaxY
  MOV AL,Y
  CALL AsmWEAlign
 {$ELSE}
  LES DI,Inf
  MOV AH,ES:[DI].Window.MaxY
  MOV AL,Y
  CALL AsmWEAlign
 {$ENDIF}
END;

{��������������������������������������������������������������������������
 �                         Proc�dure WEAlignEnd                           �
 ��������������������������������������������������������������������������


 Propri�taire: Wins
 Portabilit�:  Local


 Description
 �����������

  Cette fonction r�adapte les coordonn�es X et Y convertie s'il y a lieu en
 fonction du maximum fictif commen�ant � 240.
}

Procedure WEAlignEnd{Var Inf:Wins;Var X,Y:Byte};Assembler;ASM
 {$IFDEF FLAT386}
  PUSH ECX
   MOV ECX,EDX
   XCHG EDX,EAX
   MOV AH,[EDX].Window.MaxX
   MOV AL,[ECX]
   CALL AsmWEAlign
   MOV [ECX],AL
   MOV AH,[EDX].Window.MaxY
  POP ECX
  MOV AL,[ECX]
  CALL AsmWEAlign
  MOV [ECX],AL
 {$ELSE}
  CLD
  PUSH DS
   LES DI,Inf
   MOV AH,ES:[DI].Window.MaxX
   LDS SI,X
   LODSB
   CALL AsmWEAlign
   DEC SI
   MOV DS:[SI],AL
   MOV AH,ES:[DI].Window.MaxY
   LDS SI,Y
   LODSB
   CALL AsmWEAlign
   DEC SI
   MOV DS:[SI],AL
  POP DS
 {$ENDIF}
END;

{���������������������������������������������������������������������������
 �                             Proc�dure WEGetR                            �
 ���������������������������������������������������������������������������


  Propri�taire: Wins
  Portabilit�:  Local


  Description
  �����������

   Cette fonction permet de conna�tre la position courante du pointeur �cran
  de la fen�tre  sous  l'axe  horizontal  (valeur  retourner)  et sur  l'axe
  vertical (par l'entremise d'une variable de param�trage suppos� �Y�).


  Remarque
  ��������

   � Voici maintenant cette fonction sous l'aspect de langage de Pascal:
     ���������������������������������������������������������������������Ŀ
     � Function WEGetR;Begin                                               �
     �  WEGetR:=WEGetRX1(Q);Y:=WEGetRY1(Q)                                 �
     � End;                                                                �
     �����������������������������������������������������������������������
}

Function WEGetR{Var Q:Wins;Var Y:Byte):Byte};Assembler;ASM
 {$IFDEF FLAT386}
  XCHG EAX,EDX
  CALL AsmWEGetR
  LEA EDX,DWord Ptr Y
  MOV [EDX],AH
 {$ELSE}
  LES DI,Q
  CALL AsmWEGetR
  LES DI,Y
  XCHG AL,AH
  STOSB
  MOV AL,AH
 {$ENDIF}
END;

{$IFDEF __Windows__}
 Procedure WEAttr(Var Q:Window;Attr:Byte);Begin
  Q.Canvas.Brush.Color:=RGB2Color(DefaultRGB[Attr shr 4].R,
                                  DefaultRGB[Attr shr 4].G,
                                  DefaultRGB[Attr shr 4].B);
  Q.Canvas.Font.Color:=RGB2Color(DefaultRGB[Attr and$F].R,
                                 DefaultRGB[Attr and$F].G,
                                 DefaultRGB[Attr and$F].B);
 End;
{$ENDIF}

{��������������������������������������������������������������������������}
{����������������������������� Classe Public ������������������������������}
{��������������������������������������������������������������������������}

{��������������������������������������������������������������������������
 �                          Proc�dure WEPushEndBar                        �
 ��������������������������������������������������������������������������


  Propri�taire: Wins
  Portabilit�:  Global


  Description
  �����������

   Ce constructeur permet de sauvegarder la derni�re barre d'affichage afin
  que l'ancien message utilisateur ne soit pas perdue.
}

Procedure WEPushEndBar{Var Q:Wins};Begin
 WEInit(Q,0,MaxYTxts,wnMax,wnMax);
 If(HelpBar)Then WEPushWn(Q)
End;

{��������������������������������������������������������������������
 �                       Proc�dure WEPushEndBar                     �
 ��������������������������������������������������������������������


  Propri�taire: Wins
  Portabilit�:  Global


  Description
  �����������

   Cette proc�dure permet d'afficher un message sur la derni�re barre
  d'affichage de texte afin de renseigner l'utilisateur.


  Remarque
  ��������

   � Voici le pseudo-code en langage Pascal pure de la routine:
     ��������������������������������������������������������������Ŀ
     � Procedure WEPutLastBar(Const k:String);Begin                 �
     �  SetAllKr(CurrKrs.LastBar.High,CurrKrs.LastBar.Normal);      �
     �  PutLastBar(2,k)                                             �
     � End;                                                         �
     ����������������������������������������������������������������
}

Procedure WEPutLastBar{Const k:String};Begin
 ASM
  MOV AX,Word Ptr CurrKrs.LastBar.Higher
  MOV Word Ptr LastColor,AX
 END;
 PutLastBar(2,k)
End;

{�����������������������������������������������������������������������
 �                         Constructeur WEInitO                        �
 �����������������������������������������������������������������������


  Propri�taire: Wins
  Portabilit�:  Global


  Description
  �����������

   Ce constructeur permet d'initialiser une bo�te de dialogue de l'objet
  devant se situ� au milieu de l'�cran.
}

Procedure WEInitO{Var Q:Wins;L,H:Byte};
Var
 T:TextBoxRec;
Begin
 __GetCenterTxt(L,H,T);
 If(L>=MaxXTxts)Then Begin
  T.X1:=0;
  T.X2:=wnMax;
 End;
 WEInit(Q,T.X1,T.Y1,T.X2,T.Y2)
End;

{ Ce constructeur permet d'initialiser une boite de dialogue
 en fonction d'un "Canvas" de Delphi par exemple.
}

{$IFDEF __Windows__}
 Procedure WEInitWindows(Var Q:Window;Const Canvas:TCanvas);Begin
  FillClr(Q,SizeOf(Q));
  WEInit(Q,0,0,79,24);
  Q.Canvas:=Canvas;
  Q.Canvas.Font.Pitch:=fpFixed;
  Q.Canvas.Font.Color:=$777777;
  Q.Height:=Q.Canvas.Font.Size;
  Q.Width:=Q.Height;
  Inc(Q.Height,4);
 End;
{$ENDIF}


{�����������������������������������������������������������������������
 �                          Constructeur WEInit                        �
 �����������������������������������������������������������������������


  Propri�taire: Wins
  Portabilit�:  Global


  Description
  �����������

   Ce constructeur permet d'initialiser une bo�te de dialogue de l'objet
  devant se situ� � l'endroit demander.
}

Procedure WEInit{Var Q:Wins;L,H:Byte};
Var
 XM,YM:Byte;
Begin
 FillClr(Q,SizeOf(Q));
 Q.Shade:=GetShade;
 ASM
  {$IFDEF FLAT386}
   PUSH EDI
    PUSH EBX
     MOV AL,X1
     CMP AL,X2
     JNA @1
     XCHG AL,X2
     MOV X1,AL
 @1: CALL GetNmXTxts
     DEC AX
     MOV AH,AL
     CALL GetNmYTxts
     DEC AX
     MOV BH,AL
     MOV YM,BH
     MOV XM,AH
     MOV AL,X2
     CMP AL,0F0h
     JB  @2
     NOT AL
     AND AL,0Fh
     SUB AH,AL
     JMP @3
  @2:CMP AL,AH
     JB  @4
  @3:MOV X2,AH
  @4:MOV BL,Y2
     CMP BL,0F0h
     JB  @5
     NOT BL
     AND BL,0Fh
     SUB BH,BL
     JMP @6
  @5:CMP BL,BH
     JB  @7
  @6:MOV Y2,BH
  @7:LEA EDI,DWord Ptr Q
     MOV CX,7
     MOV AL,X1
     MOV AH,Y1
     MOV Word Ptr [EDI].Window.T.X1,AX
     MOV BL,X2
     MOV BH,Y2
     MOV Word Ptr [EDI].Window.T.X2,BX
     MOV [EDI].Window.CurrColor,CL
     CMP AL,CH
     JE  @8
     SUB BL,X1
     INC BL
     MOV AH,XM
     CMP BL,AH
     JNAE @8
     MOV [EDI].Window.T.X1,CH
     MOV [EDI].Window.T.X2,AH
  @8:CMP [EDI].Window.T.Y1,CH
     JE  @B
     MOV AL,YM
     MOV BH,Y2
     MOV DL,BH
     SUB DL,Y1
     INC DL
     CMP DL,AL
     JAE @9
     CMP BH,AL
     JNA @B
  @9:MOV [EDI].Window.T.Y1,CH
     INC DL
     CMP BH,AL
     JNA @A
     MOV DL,AL
  @A:MOV [EDI].Window.T.Y2,DL
 @B:POP EBX
   POP EDI
  {$ELSE}
   MOV AL,X1
   CMP AL,X2
   JNA @1
   XCHG AL,X2
   MOV X1,AL
@1:CALL GetNmXTxts
   DEC AX
   MOV AH,AL
   CALL GetNmYTxts
   DEC AX
   MOV BH,AL
   MOV YM,BH
   MOV XM,AH
   MOV AL,X2
   CMP AL,0F0h
   JB  @2
   NOT AL
   AND AL,0Fh
   SUB AH,AL
   JMP @3
@2:CMP AL,AH
   JB  @4
@3:MOV X2,AH
@4:MOV BL,Y2
   CMP BL,0F0h
   JB  @5
   NOT BL
   AND BL,0Fh
   SUB BH,BL
   JMP @6
@5:CMP BL,BH
   JB  @7
@6:MOV Y2,BH
@7:LES DI,Q
   MOV CX,7
   MOV AL,X1
   MOV AH,Y1
   MOV Word Ptr ES:[DI].Window.T.X1,AX
   MOV BL,X2
   MOV BH,Y2
   MOV Word Ptr ES:[DI].Window.T.X2,BX
   MOV ES:[DI].Window.CurrColor,CL
   CMP AL,CH
   JE  @8
   SUB BL,X1
   INC BL
   MOV AH,XM
   CMP BL,AH
   JNAE @8
   MOV ES:[DI].Window.T.X1,CH
   MOV ES:[DI].Window.T.X2,AH
@8:CMP ES:[DI].Window.T.Y1,CH
   JE  @B
   MOV AL,YM
   MOV BH,Y2
   MOV DL,BH
   SUB DL,Y1
   INC DL
   CMP DL,AL
   JAE @9
   CMP BH,AL
   JNA @B
@9:MOV ES:[DI].Window.T.Y1,CH
   INC DL
   CMP BH,AL
   JNA @A
   MOV DL,AL
@A:MOV ES:[DI].Window.T.Y2,DL
@B:
  {$ENDIF}
 END;
 Q.NotFullScrnX:=Not(Q.T.X2-Q.T.X1>=XM);
 If(Q.T.Y1=Q.T.Y2)Then Begin
  Q.NotFullScrnY:=False;
  Q.Shade:=False;
 End
  Else
 Q.NotFullScrnY:=Not(Q.T.Y2-Q.T.Y1+1>=YM);
 Q.MaxX:=WEMaxXTxts(Q);
 Q.MaxY:=WEMaxYTxts(Q);
 Q.HeightBar:=Q.MaxY
End;

{����������������������������������������������������������������������
 �                          Proc�dure WESubList                       �
 ����������������������������������������������������������������������


  Propri�taire: Wins
  Portabilit�:  Global


  Description
  �����������

   Cette proc�dure permet d'associer une liste � la fen�tre de dialogue
  de l'objet �Wins�.


  Remarque
  ��������

   � Voici l'algorithme de cette proc�dure sous forme Pascal pure:
     ����������������������������������������������������������������Ŀ
     � Procedure WESubList;Begin                                      �
     �  WEAlignEnd(Q,X2,Y2);                                          �
     �  _LMQInit(L,WEGetRX1(Q)+X1,WEGetRY1(Q)+Y1,                     �
     �             WEGetRX1(Q)+X2,WEGetRY1(Q)+Y2,                     �
     �             Title,CurrKrs.Dialog.Env.List)                     �
     � End;                                                           �
     ������������������������������������������������������������������
}

Procedure WESubList{Var Q:Wins;X1,Y1,X2,Y2:Byte;
                    Const Title:String;Var L:LstMnu};
{$IFDEF FLAT386}
 Begin
  _LMQInit(L,WEGetRX1(Q)+X1,WEGetRY1(Q)+Y1,WEGetRX1(Q)+X2,WEGetRY1(Q)+Y2,Title,CurrKrs.Dialog.Env.List)
 End;
{$ELSE}
 Assembler;ASM
   { _LMQInit(L,WEGetRX1(Q)+X1,WEGetRY1(Q)+Y1,WEGetRX1(Q)+X2,WEGetRY1(Q)+Y2,Title,CurrKrs.Dialog.Env.List)}
  LES DI,L
  PUSH ES
  PUSH DI
   LES DI,Q
   MOV AL,X2
   MOV AH,Y2
   CALL AsmWEAlignEnd { WEAlignEnd(Q,X2,Y2);}
   XCHG AX,CX
   CALL AsmWEGetR
  MOV BL,X1
  ADD BL,AL
  PUSH BX
  MOV BL,Y1
  ADD BL,AH
  PUSH BX
  ADD AL,CL
  PUSH AX
  MOV BL,CH
  ADD BL,AH
  PUSH BX
  PUSH Word Ptr Title[2]
  PUSH Word Ptr Title
  PUSH DS
  MOV DI,Offset CurrKrs.Dialog.Env.List
  PUSH DI
  CALL _LMQInit
 END;
{$ENDIF}

{��������������������������������������������������������������������������
 �                               Fonction WEOk                            �
 ��������������������������������������������������������������������������


  Propri�taire: Wins
  Portabilit�:  Global


  Description
  �����������

   Cette fonction permet d'afficher un bouton de message �CORRECTE� ou �OK�
  et d'attendre que l'utilisateur le clique et sort de cette routine que si
  l'utilisateur  demande  de  l'aide.  Si la routine  sort sans demander de
  l'aide, il y a �galement restitution de l'objet de bo�te de dialogue.
}

Function WEOk{Var Q:Wins):Bool};
Var
 K:Word;
Begin
 WECloseIcon(Q);
 K:=WEGetkHorDn(Q,StrOk);
 WEOk:=K=kbF1;
 If(K<>kbF1)Then WEDone(Q)
End;

{����������������������������������������������������������������������
 �                           Proc�dure WEConMacro                     �
 ����������������������������������������������������������������������


  Propri�taire: Wins
  Portabilit�:  Global


  Description
  �����������

   Cette proc�dure permet d'envoyer des informations � la console de la
  bo�te de dialogue de l'objet �Wins�.
}

Procedure WEConMacro{Var Q:Wins;Const S:String};
Label Break;
Var
 I,J,X,Y,Color:Byte;
 Msg:String;

 Procedure XtrkMsg;Label Break;Begin
  J:=I;
  While Not(S[I]in[#0,'$'])do Begin
   If I>Length(S)Then Goto Break;
   Inc(I)
  End;
Break:
 End;

Begin
 I:=1;
 While I<=Length(S)do Begin
  Case S[I]of
   '@':WEPutSmallBorder(Q);
   'C':Begin { ClearLine ? }
    Inc(I);Y:=Byte(S[I]);Inc(I);
    If Y>=250Then Y:=MaxYTxts-(255-Y);
    BarSpcHor(0,Y,MaxXTxts,Byte(S[I]))
   End;
   'I':PutCloseIcon(0,0,$F);
   'S':Begin
    Inc(I);X:=Byte(S[I]);Inc(I);Y:=Byte(S[I]);Inc(I);
    If Y>=250Then Y:=MaxYTxts-(255-Y);
    SetChr(X,Y,S[I])
   End;
   'T':Begin
    Inc(I);
    Case S[I]of
     'O':Begin{TO: PutTextCenter(Y,__Justified__,%,%)?}
      Inc(I);Y:=Byte(S[I]);Inc(I);Color:=Byte(S[I]);Inc(I);J:=I;
      While Not(S[I]in[#0,'$'])do Begin
       If I>Length(S)Then Goto Break;
       Inc(I)
      End;
Break:Msg:=Copy(S,J,I-J);
      If Color and$F>8Then Begin
       X:=GetHoriCenter(Length(Msg));
       For J:=0to Length(Msg)-1do PutCharGAttr(X+J,Y,Msg[J+1],Color,1)
      End
       Else
      PutTxtCenter(Y,__Justified__,Msg,Color)
     End;
    End;
   End;
   'b':WESetKrBorder(Q);
   'h':WESetKrHigh(Q);
   'k':Begin
    Inc(I);X:=Byte(S[I]);
    Case Char(X)of
     'd':Begin
      Inc(I);
      XtrkMsg;
      WEPutkHorDn(Q,Copy(S,J,I-J))
     End;
     'o':While WEOk(Q)do;
     'y':WEPutkHorDn(Q,'Oui|Non');
     Else Begin
      Inc(I);Y:=Byte(S[I]);Inc(I);Color:=Byte(S[I]);Inc(I);
      XtrkMsg;
      WEPutkHor(Q,X,Y,Color,Copy(S,J,I-J))
     End;
    End;
   End;
   'l':_WELn(Q);
   'p':Begin
    Inc(I);
    XtrkMsg;
    WEPutTxt(Q,Copy(S,J,I-J))
   End;
   '�':Begin
    Inc(I);X:=Byte(S[I]);Inc(I);
    XtrkMsg;
    WEPutTxt(Q,StrUSpc(Copy(S,J,I-J),X))
   End;
  End;
  Inc(I)
 End
End;

{�����������������������������������������������������������������������
 �                        Proc�dure WEBarSpcHorRelief                  �
 �����������������������������������������������������������������������


  Propri�taire: Wins
  Portabilit�:  Global


  Description
  �����������

   Cette proc�dure permet de tracer un relief � une barre d�j� existante
  dans la bo�te de dialogue. Les coordonn�es sont fix�es en format texte.


  Remarque
  ��������

   � Voici maintenant cette fonction sous l'aspect de langage de Pascal:
     �����������������������������������������������������������������Ŀ
     � Procedure WEBarSpcHorRelief;Begin                               �
     �  WEAlignEnd(Q,X2,Y);                                            �
     �  BarSpcHorRelief(WEGetRealX(Q)+X1,WEGetRealY(Q)+Y,              �
     �                  WEGetRealX(Q)+X2,Q.CurrColor)                  �
     � End;                                                            �
     �������������������������������������������������������������������
}

Procedure WEBarSpcHorRelief{Var Q:Wins;X1,Y,X2:Byte};
{$IFDEF FLAT386}
 Begin
  WEAlignEnd(Q,X2,Y);
  BarSpcHorRelief(WEGetRealX(Q)+X1,WEGetRealY(Q)+Y,WEGetRealX(Q)+X2,Q.CurrColor)
 End;
{$ELSE}
 Assembler;ASM
  CMP HoleMode,True
  JE  @End
  LES DI,Q
  MOV AL,X2
  MOV AH,Y
  CALL AsmWEAlignEnd
  XCHG AX,CX
  CALL AsmWEGetR
  MOV BL,X1
  ADD BL,AL
  PUSH BX
  MOV BL,CH
  ADD BL,AH
  PUSH BX
  ADD AL,CL
  PUSH AX
  PUSH Word Ptr ES:[DI].Window.CurrColor
  CALL BarSpcHorRelief
 @End:
 END;
{$ENDIF}

{���������������������������������������������������������������������������
 �                           Proc�dure WEPushCur                           �
 ���������������������������������������������������������������������������


  Propri�taire: Wins
  Portabilit�:  Global


  Description
  �����������

   Cette proc�dure sauvegarde l'�tat du curseur se trouvant dans la bo�te de
  dialogue de l'objet �Wins�.
}

Procedure WEPushCur{Var Q:Wins};
Var
 G:GraphBoxRec;
 Show:Boolean;
Begin
 G.X1:=GetXCurPos shl 3;
 G.Y1:=GetRawY(GetYCurPos);
 If(IsGraf)Then Begin
  Show:=(IsShowMouse)and(GetXCurPos=LastMouseX)and(GetYCurPos=LastMouseY);
  If(Show)Then __HideMousePtr;
  G.X2:=G.X1+7;
  G.Y2:=G.Y1+HeightChr-1;
  __GetSmlImg(G,CurBuf^);
  If(Show)Then __ShowMousePtr;
 End
  Else
 ASM
   {CurrCube:=GetCube(WEGetRealX(Q),WEGetRealY(Q))}
  LES DI,Q
  CALL AsmWEGetReal
  PUSH AX
  MOV AL,AH
  PUSH AX
  CALL GetCube
  MOV CurrCube,AX
 END;
End;

{�������������������������������������������������������������������������
 �                          Proc�dure WEAniCur                           �
 �������������������������������������������������������������������������


  Propri�taire: Wins
  Portabilit�:  Global


  Description
  �����������

   Cette proc�dure r�actualise le bloc du curseur devant actuellement �tre
  afficher dans la bo�te de dialogue lorsque celui-ci est ouvert!
}

Procedure WEAniCur{Var Q:Wins};Begin
 WESetAttr(Q,Q.X,Q.Y,curCoco3Attr[(GetRawTimerB and$F)shr 2])
End;

{��������������������������������������������������������������������������
 �                           Proc�dure WEPopCur                           �
 ��������������������������������������������������������������������������


  Propri�taire: Wins
  Portabilit�:  Global


  Description
  �����������

  Cette proc�dure permet de restituer l'�tat du curseur se trouvant dans la
 bo�te de dialogue de l'objet �Wins�.
}

Procedure WEPopCur{Var Q:Wins):Boolean};
Var
 _CCube:TextCube Absolute CurrCube;
 Show:Boolean;
Begin
 If(IsGraf)Then Begin
  PutSmlImg(GetXCurPos shl 3,GetRawY(GetYCurPos),
            (GetXCurPos shl 3)+7,GetRawY(GetYCurPos+1)-1,CurBuf^)
 End
  Else
 Begin
  Show:=WEInZonePtrMouse(Q,Q.X,Q.Y,1,1);
  If(Show)Then __HideMousePtr;
  ASM
    {SetCube(WEGetRealX(Q),WEGetRealY(Q),_CCube.Chr,_CCube.Attr);}
   LES DI,Q
   CALL AsmWEGetReal
   PUSH AX
   MOV AL,AH
   PUSH AX
   PUSH Word Ptr _CCube.Chr
   PUSH Word Ptr _CCube.Attr
   CALL SetCube
  END;
  If(Show)Then __ShowMousePtr;
 End;
End;

{�������������������������������������������������������������������������
 �                           Proc�dure WEReInit                          �
 �������������������������������������������������������������������������


  Propri�taire: Wins
  Portabilit�:  Global


  Description
  �����������

  Cette proc�dure permet de changer la taille de la fen�tre de dialogue de
 l'objet �Wins�.
}

Procedure WEReInit{Var Q:Wins;X1,Y1,X2,Y2:Byte};
Var
 Palette:MtxColors;
 CloseIcon,ZoomIcon,BarMouseRight:Boolean;
Begin
 Palette:=Q.Palette;
 CloseIcon:=Q.CloseIcon;
 ZoomIcon:=Q.ZoomIcon;
 BarMouseRight:=Q.BarMouseRight;
 WEPopWn(Q);
 WEInit(Q,X1,Y1,X2,Y2);
 Q.Palette:=Palette;
 Q.CloseIcon:=CloseIcon;
 Q.ZoomIcon:=ZoomIcon;
 Q.BarMouseRight:=BarMouseRight;
End;

{������������������������������������������������������������������������
 �                            Proc�dure WESubWins                       �
 ������������������������������������������������������������������������


  Propri�taire: Wins
  Portabilit�:  Global


  Description
  �����������

  Cette proc�dure permet de cr�er une fen�tre � l'int�rieur d'une fen�tre
 de dialogue d�j� existante.


  Remarque
  ��������

   � Voici maintenant cette fonction sous l'aspect de langage de Pascal:
     ������������������������������������������������������������������Ŀ
     � Procedure WESubWins(Var Q:Wins;X1,Y1,X2,Y2:Byte;Var W:Wins);     �
     � Var XH,YH:Byte;Begin                                             �
     �  WEAlignEnd(Q,X2,Y2);                                            �
     �  XH:=WEGetR(Q,YH);                                               �
     �  WEInit(W,XH+X1,YH+Y1,XH+X2,YH+Y2)                               �
     � End;                                                             �
     ��������������������������������������������������������������������
}

Procedure WESubWins{Var Q:Wins;X1,Y1,X2,Y2:Byte;Var W:Wins};
{$IFDEF FLAT386}
 Var
  XH,YH:Byte;
 Begin
  WEAlignEnd(Q,X2,Y2);
  XH:=WEGetR(Q,YH);
  WEInit(W,XH+X1,YH+Y1,XH+X2,YH+Y2)
 End;
{$ELSE}
 Assembler;ASM
  LES DI,Q
  MOV AL,X2
  MOV AH,Y2
  CALL AsmWEAlignEnd
  XCHG CX,AX
  CALL AsmWEGetR
  LES DI,W
  PUSH ES
  PUSH DI
  MOV BL,X1
  ADD BL,AL
  PUSH BX
  MOV BL,Y1
  ADD BL,AH
  PUSH BX
  ADD AL,CL
  PUSH AX
  MOV BL,CH
  ADD BL,AH
  PUSH BX
  PUSH CS
  CALL Near Ptr WEInit
 END;
{$ENDIF}

{��������������������������������������������������������������������������
 �                             Fonction WEGetRX1                          �
 ��������������������������������������������������������������������������


  Propri�taire: Wins
  Portabilit�:  Global


  Description
  �����������

  Cette fonction demande la position horizontal physique en texte � l'�cran
 ou commencent l'affichage de la bo�te de dialogue de l'objet �Wins�.
}

Function WEGetRX1{Var Q:Wins):Byte};Assembler;ASM
 {$IFDEF FLAT386}
  MOV BL,[EAX].Window.T.X1
  ADD BL,[EAX].Window.NotFullScrnX
  XCHG AX,BX
 {$ELSE}
  LES DI,Q
  MOV AL,ES:[DI].Window.T.X1
  ADD AL,ES:[DI].Window.NotFullScrnX
 {$ENDIF}
END;

{������������������������������������������������������������������������
 �                           Fonction WEGetRY1                          �
 ������������������������������������������������������������������������


  Propri�taire: Wins
  Portabilit�:  Global


  Description
  �����������

  Cette fonction demande la position vertical physique en texte � l'�cran
 ou commencent l'affichage de la bo�te de dialogue de l'objet �Wins�.
}

Function WEGetRY1{Var Q:Wins):Byte};Assembler;ASM
 {$IFDEF FLAT386}
  MOV BL,[EAX].Window.T.Y1
  ADD BL,[EAX].Window.NotFullScrnY
  ADD AL,[EAX].Window.LineHome
  XCHG AX,BX
 {$ELSE}
  LES DI,Q
  MOV AL,ES:[DI].Window.T.Y1
  ADD AL,ES:[DI].Window.NotFullScrnY
  ADD AL,ES:[DI].Window.LineHome
 {$ENDIF}
END;

{����������������������������������������������������������������������
 �                        Proc�dure AsmWEGetR                         �
 ����������������������������������������������������������������������


  Propri�taire: Wins
  Portabilit�:  Local


  Description
  �����������

   Cette proc�dure demande les positions physique en texte � l'�cran ou
  commencent l'affichage de la bo�te de dialogue de l'objet �Wins�.


  Entr�e
  ������

   ES:DI       = Adresse de l'objet �Wins�


  Sortie
  ������

   AL          = Coordonn�es physique horizontal
   AH          = Coordonn�es physique vertical
}

Procedure AsmWEGetR;Assembler;ASM
 {$IFDEF FLAT386}
  MOV AX,Word Ptr [EDX].Window.T.X1
  ADD AX,Word Ptr [EDX].Window.NotFullScrnX
  ADD AH,[EDX].Window.LineHome
 {$ELSE}
  MOV AX,Word Ptr ES:[DI].Window.T.X1
  ADD AX,Word Ptr ES:[DI].Window.NotFullScrnX
  ADD AH,ES:[DI].Window.LineHome
 {$ENDIF}
END;

{����������������������������������������������������������������������
 �                        Proc�dure AsmWEGetReal                      �
 ����������������������������������������������������������������������


  Propri�taire: Wins
  Portabilit�:  Local


  Description
  �����������

   Cette proc�dure demande les positions physique en texte � l'�cran o�
  se situe  le pointeur  d'affichage  texte de la bo�te  de dialogue de
  l'objet �Wins�.


  Entr�e
  ������

   ES:DI       = Adresse de l'objet �Wins�


  Sortie
  ������

   AL          = Coordonn�es physique horizontal du pointeur texte
   AH          = Coordonn�es physique vertical du pointeur texte
}

Procedure AsmWEGetReal;Assembler;ASM
 {$IFDEF FLAT386}
  MOV AX,Word Ptr [EDX].Window.T.X1
  ADD AX,Word Ptr [EDX].Window.NotFullScrnX
  ADD AX,Word Ptr [EDX].Window.X
  ADD AH,[EDX].Window.LineHome
 {$ELSE}
  MOV AX,Word Ptr ES:[DI].Window.T.X1
  ADD AX,Word Ptr ES:[DI].Window.NotFullScrnX
  ADD AX,Word Ptr ES:[DI].Window.X
  ADD AH,ES:[DI].Window.LineHome
 {$ENDIF}
END;

{���������������������������������������������������������������������������
 �                          Proc�dure WESelRightBarPos                     �
 ���������������������������������������������������������������������������


  Propri�taire: Wins
  Portabilit�:  Global


  Description
  �����������

   Cette proc�dure permet l'affichage d'une barre vertical � la droite de la
  bo�te de dialogue de l'objet �Wins�.
}

Procedure WESelRightBarPos{Var Q:Wins;P,Max:Word};
Var
 G:GraphBoxRec;
 TY:Word;
 I:Integer;
 Show:Boolean;
Begin
 Show:=IsShowMouse;
 If(Show)Then __HideMousePtr;
 If(Q.BarMouseRight){$IFNDEF GraphicOS}and(Not(HoleMode)){$ENDIF}Then Begin
  If Max=0Then TY:=0 Else TY:=(LongInt(Mul2Word(Q.HeightBar-2,P))div Max);
  If(Q.RBPY<>TY)Then Begin
    {Efface l'ancien pointeur}
   If Q.RBPY<>$FFThen Begin
    G.X1:=Q.T.X2-UpIconLen+1;
    G.Y1:=WEGetRY1(Q)-Q.LineHome+1+Q.RBPY;
    G.X2:=Q.T.X2;
    If(IsGrf)Then Begin
     WordTxt2Graph(G);{G.X1:=G.X1 shl 3;G.Y1:=GetRawY(G.Y1);}
     G.X2:=(G.X2 shl 3)+7;G.Y2:=G.Y1+HeightChr-1;
     PutFillBox(G.X1+1,G.Y1+1,G.X2-1,G.Y2-1,7)
    End
     Else
    BarSelHor(G.X1,G.Y1,G.X2,(Q.Palette.Icon shr 4)+(Q.Palette.Icon shl 4))
   End;
    {Affiche le nouveau pointeur}
   G.X1:=Q.T.X2-UpIconLen+1;
   G.Y1:=WEGetRY1(Q)-Q.LineHome+1+TY;
   G.X2:=Q.T.X2;
   If(IsGrf)Then Begin
    WordTxt2Graph(G);{G.X1:=G.X1 shl 3;G.Y1:=GetRawY(G.Y1);}
    G.X2:=(G.X2 shl 3)+7;G.Y2:=G.Y1+HeightChr-1;
    PutFillBox(G.X1+2,G.Y1+2,G.X2-2,G.Y2-2,LightGray);
    PutLnHor(G.X1+1,G.Y1+1,G.X2-1,White);
    PutLine(G.X1+1,G.Y1+2,G.X1+1,G.Y2-1,White);
    PutLine(G.X2-1,G.Y1+2,G.X2-1,G.Y2-1,DarkGray);
    PutLnHor(G.X1+2,G.Y2-1,G.X2-1,DarkGray);
    If(BitsPerPixel>=4)and(HeightChr>8)Then Begin
     Inc(G.X1,3);Dec(G.X2,3);Inc(G.Y1,3);
     For I:=0to((HeightChr-3)shr 1)-2do Begin
      __PutLnHor(G,White);
      Inc(G.Y1);
      __PutLnHor(G,Black);
      Inc(G.Y1);
     End;
    End;
   End
    Else
   BarSelHor(G.X1,G.Y1,G.X2,Q.Palette.Icon);
   Q.RBPY:=TY
  End;
 End;
 If(Show)Then __ShowMousePtr;
End;

{������������������������������������������������������������������������
 �                        Proc�dure WEInRightBarMs                      �
 ������������������������������������������������������������������������


  Propri�taire: Wins
  Portabilit�:  Global


  Description
  �����������

  Cette fonction indique si le pointeur de coordonn�es physique touche la
 barre vertical de d�filement situ�  � la droite  de la bo�te de dialogue
 de l'objet �Wins�.
}

Function WEInRightBarMs{Var Q:Wins;X,Y:Byte):Word};
Var
 YH,YM:Byte;
Begin
 WEInRightBarMs:=0;
 If(Q.BarMouseRight)Then Begin
  If(X>=Q.T.X2-CloseIconLen+1)and(X<=Q.T.X2)Then Begin
   YH:=WEGetRY1(Q)-Q.LineHome;
   If(Y=YH)Then Begin
    WEInRightBarMs:=kbRBarMsUp;
    Exit;
   End;
   YM:=WEMaxYTxts(Q)+Q.LineHome;
   If(Not(Q.NotFullScrnX or Q.NotFullScrnY)=True)Then Begin
    Dec(YM,2);
   End;
   If(Y=YH+YM)Then Begin
    WEInRightBarMs:=kbRBarMsDn;
    Exit;
   End;
   If Q.RBPY<>$FFThen Begin
    If(Y>=YH)and(Y<=YH+YM)Then Begin
     If(Y<=YH+1+Q.RBPY)Then WEInRightBarMs:=kbRBarMsPgUp
                       Else WEInRightBarMs:=kbRBarMsPgDn;
     Exit
    End
   End
    Else
   If(Y>=YH)and(Y<=YH+YM)Then Begin
    If Y-YH>YM shr 1Then WEInRightBarMs:=kbRBarMsPgDn
                    Else WEInRightBarMs:=kbRBarMsPgUp;
    Exit
   End
  End
 End;
End;

{��������������������������������������������������������������������
 �                         Fonction WEInTitle                       �
 ��������������������������������������������������������������������


 Propri�taire: Wins
 Portabilit�:  Global


 Description
 �����������

  Cette fonction permet de savoir si le pointeur de coordonn�es texte
 physique est situ� � l'int�rieur de la barre de titre de la bo�te de
 dialogue de l'objet �Wins�.
}

Function WEInTitle{Var Q:Wins;X,Y:Byte):Boolean};Begin
 WEInTitle:=(Y=Q.T.Y1)and(X>=Q.T.X1+CloseIconLen)and(X<=Q.T.X2)
End;

{���������������������������������������������������������������������������
 �                             Fonction WEBackReadk                        �
 ���������������������������������������������������������������������������


 Propri�taire: Wins
 Portabilit�:  Global


 Description
 �����������

  Cette fonction permet de conna�tre l'action utilisateur ayant �t� effectue
 dans la bo�te de dialogue � cette instant pr�cis.
}

Function WEBackReadk{Var Q:Wins):Word};
Label Restart;
Var
 B,V1:Word;
 M,M1:TextCharRec;
Begin
 WEBackReadk:=0;
Restart:
 If(Pointer(@Q.BackWait)<>NIL)Then Begin
  If(Q.Context<>NIL)Then Q.BackWait(Q.Context^)
                    Else Q.BackWait(Q);
 End;
 __GetMouseTextSwitchZ(M,B);
 If B>0Then Begin
  If(M.X>=Q.T.X2-1)and(M.X<=Q.T.X2)and(M.Y=Q.T.Y2)Then Begin
   WEBackReadk:=kbReSize;
   Exit;
  End;
  V1:=WEInRightBarMs(Q,M.X,M.Y);
  If(V1>0)Then Begin
{    If(V1=kbCompat)Then}
   If((V1=kbRBarMsPgDn)or(V1=kbRBarMsPgUp))and
      (M.Y=WEGetRY1(Q)-Q.LineHome+1+Q.RBPY)Then Begin { Sur le compat? }
    Q.OnCompat:=True;
    Repeat
     _BackKbd;
     __GetMouseTextSwitchZ(M1,B);
     If(M1.Y<>M.Y)Then Begin
      V1:=WEInRightBarMs(Q,M1.X,M1.Y);
      If(V1=kbRBarMsPgDn)or(V1=kbRBarMsPgUp)Then Begin
       WEBackReadk:=kbCompat;
       Exit;
      End;
     End;
    Until B=0;
    {Goto Restart;}
    Exit;
   End
    Else
   Begin
    If Not(Q.OnCompat)Then WEBackReadk:=V1
     Else
    Begin
     If(M.Y<>WEGetRY1(Q)-Q.LineHome+1+Q.RBPY)Then WEBackReadk:=kbCompat;
    End;
    Exit;
   End;
  End;
  If(Q.OnCompat)Then Exit;
  If WEInCloseIcon(Q,M.X,M.Y)Then Begin
   WEBackReadk:=kbCloseWin;
   Exit;
  End;
  If WEInZoomIcon(Q,M.X,M.Y)Then Begin
   WEBackReadk:=kbZoom;
   Exit;
  End;
  If WEInWindow(Q,M.X,M.Y)Then Begin
   WEBackReadk:=kbInWn;
   Exit;
  End;
  If WEInTitle(Q,M.X,M.Y)Then Begin
   If(Q.ZoomIcon)and(M.X<=Q.T.X2-2)and(M.X>=Q.T.X2-3)Then Begin
    WEBackReadk:=kbTaskBar;
    Exit;
   End
    Else
   If Q.SizeBuffer<>0Then WEMoveWn(Q)
    Else
   Begin
    WEBackReadk:=kbTitle;
    Exit;
   End;
  End;
  If M.Y=0Then Begin
   If(M.X>=CloseIconLen)Then WEBackReadk:=kbPrgTitle
                        Else WEBackReadk:=kbPrgClsIcon;
   Exit
  End;
  If(M.Y=LnsMnu)Then Begin
   WEBackReadk:=kbPrgMnuBar;
   Exit;
  End;
  If(M.Y=Q.T.Y2)and(M.X>=Q.T.X1+CloseIconLen)and(M.X<=Q.T.X2)Then Begin
   WEBackReadk:=kbDataBar;
   Exit;
  End;
{  If WEOnWn(Q,M.X,M.Y)Then Begin
   WEBackReadk:=kbOnWn;
   Exit;
  End;}
  WEBackReadk:=kbMouse;
 End
  Else
 Q.OnCompat:=False;
End;

{�������������������������������������������������������������������������
 �                           Fonction WEReadk                            �
 �������������������������������������������������������������������������


 Propri�taire: Wins
 Portabilit�:  Global


 Description
 �����������

  Cette fonction retourne l'action utilisateur ayant �t� effectuer dans la
 bo�te de dialogue de l'objet �Wins�.
}

Function WEReadk{Var Q:Wins):Word};
Label Quit;
Var
 K:Word;
Begin
 InitKbd;
 __ShowMousePtr;
 Repeat
  K:=WEBackReadk(Q);
  If K>0Then Begin
   If(K=kbClose)Then WaitMouseBut0;
   WEReadk:=K;
   Goto Quit;
  End;
  _BackKbd
 Until KeyPress;
 WEReadk:=Systems.ReadKey;
Quit:
 __HideMousePtr;
End;

{���������������������������������������������������������������������
 �                   Proc�dure WEPutBarMsRight                       �
 ���������������������������������������������������������������������


 Propri�taire: Wins
 Portabilit�:  Global


 Description
 �����������

  Cette proc�dure permet d'afficher une barre de d�filement vertical �
 droite de la bo�te de dialogue de l'objet �Wins�.
}

Procedure WEPutBarMsRight{Var Q:Wins};
Var
 CI:Byte;
 G:GraphBoxRec;
 T:TextBoxRec;
Begin
 {$IFNDEF GraphicOS}
  If(HoleMode)Then Exit;
 {$ENDIF}
 If Adele.Mouse>0Then Begin
  If Q.MaxY<3Then Exit;
  ASM
   {$IFDEF FLAT386}
    LEA EDX,Q
    MOV AX,Word Ptr [EDX].Window.T.X2
    SUB AH,[EDX].Window.NotFullScrnY
    DEC AH
    MOV Word Ptr T.X2,AX
    MOV AH,[EDX].Window.T.Y1
    ADD AH,[EDX].Window.NotFullScrnY
    DEC AL
    MOV Word Ptr T.X1,AX
   {$ELSE}
    LES DI,Q
    MOV BX,Word Ptr ES:[DI].Window.NotFullScrnX
    MOV AX,Word Ptr ES:[DI].Window.T.X2
    SUB AH,BH
    DEC AH
    OR  BX,BX
    JNZ @1
    SUB AH,2
 @1:
    MOV Word Ptr T.X2,AX
    MOV AH,ES:[DI].Window.T.Y1
    ADD AH,BH
    DEC AL
    MOV Word Ptr T.X1,AX
   {$ENDIF}
  END;
  Adele.UpIcon(Q.T.X2+1-UpIconLen,T.Y1,Q.Palette.Icon);
  Inc(T.Y1);
  Q.RBPY:=$FF;
  If UpIconLen=1Then BarTxtVer(Q.T.X2,T.Y1,T.Y2,'�',Q.Palette.Icon)
   Else
  Begin
   ASM
    {$IFDEF FLAT386}
      {CI:=Q.XColrs.Icon shr 4+Q.XColrs.Icon shl 4;}
     LEA EDX,DWord Ptr Q
     MOV AL,[EDX].Window.Palette.Icon
     MOV AH,AL
     SHR AL,4
     SHL AH,4
     OR  AL,AH
     MOV CI,AL
    {$ELSE}
      {CI:=Q.XColrs.Icon shr 4+Q.XColrs.Icon shl 4;}
     LES DI,Q
     MOV AL,ES:[DI].Window.Palette.Icon
     MOV AH,AL
     {$IFOPT G+}
      SHR AL,4
      SHL AH,4
     {$ELSE}
      MOV CL,4
      SHR AL,CL
      SHL AH,CL
     {$ENDIF}
     OR AL,AH
     MOV CI,AL
    {$ENDIF}
   END;
   If(IsGraf)Then Begin
    ClrWn(T.X1,T.Y1,T.X2,T.Y2,$70);
    CoordTxt2Graph(T,G);
    __PutRect(G,0);
    __PutLnHor(G,8);
    PutLine(G.X1,G.Y1,G.X1,G.Y2,8);
   End
    Else
   Begin
    BarTxtVer(T.X1,T.Y1,T.Y2,#1,CI);
    BarTxtVer(Q.T.X2,T.Y1,T.Y2,#2,CI)
   End;
  End;
  PutDownIcon(Q.T.X2+1-UpIconLen,T.Y2+1,Q.Palette.Icon);
  Q.BarMouseRight:=True;Q.MaxX:=WEMaxXTxts(Q)
 End
End;

{����������������������������������������������������������������
 �                   Proc�dure WESetSubWn                       �
 ����������������������������������������������������������������


 Propri�taire: Wins
 Portabilit�:  Global


 Description
 �����������

  Cette proc�dure permet d'inclure une bo�te de dialogue �Wins� �
 l'int�rieur de la bo�te de dialogue d�j� existe �Wins�.
}

Procedure WESetSubWn{Var Q:Wins;Const Title:String;Var W:Wins};Begin
 WEPutWn(W,Title,Q.Palette)
End;

{�����������������������������������������������������������������������
 �                          Proc�dure WESetInpColrs                    �
 �����������������������������������������������������������������������


 Propri�taire: Wins
 Portabilit�:  Global


 Description
 �����������

  Cette proc�dure permet de fixer les deux couleurs associ�es � contr�le
 d'interrogation  �  l'int�rieur  de  la  bo�te de  dialogue  de l'objet
 �Wins�.
}

Procedure WESetInpColors{Var Q:Wins;Normal,Select:Byte};Assembler;ASM
 {$IFDEF FLAT386}
  MOV DH,CL
  MOV Word Ptr [EAX].Window.InpColor1,DX
 {$ELSE}
  LES DI,Q
  MOV AL,Normal
  MOV AH,Select
  MOV Word Ptr ES:[DI].Window.InpColor1,AX
 {$ENDIF}
END;

Procedure WESetHomeLine(Var Q:Window;Y:Byte);Begin
 Inc(Q.MaxY,Q.LineHome);
 Q.LineHome:=Y;
 Dec(Q.MaxY,Y);
End;

{���������������������������������������������������������������������������
 �                            Proc�dure WESetKrBorder                      �
 ���������������������������������������������������������������������������


 Propri�taire: Wins
 Portabilit�:  Global


 Description
 �����������

  Cette proc�dure permet de fixer la couleur courante de l'�criture du texte
 de la bo�te de dialogue de l'objet �Wins�  indique � celle de la couleur de
 bordure.
}

{$IFDEF FLAT386}
 Procedure WESetKrBorder{Var Q:Wins};Assembler;ASM
  MOV CL,[EAX].Window.Palette.Border
  MOV [EAX].Window.CurrColor,CL
 END;
{$ELSE}
 {$L WESETKR.OBJ}
 Procedure WESetKrBorder{Var Q:Wins};External;
{$ENDIF}

{���������������������������������������������������������������������������
 �                            Proc�dure WESetKrHigh                        �
 ���������������������������������������������������������������������������


 Propri�taire: Wins
 Portabilit�:  Global


 Description
 �����������

  Cette proc�dure permet de fixer la couleur courante de l'�criture du texte
 de la bo�te  de dialogue  de  l'objet  �Wins�  sp�cialiser pour  les hautes
 intensit�e.
}

{$IFDEF FLAT386}
 Procedure WESetKrHigh{Var Q:Wins};Assembler;ASM
  MOV CL,[EAX].Window.Palette.&High
  MOV [EAX].Window.CurrColor,CL
 END;
{$ELSE}
 Procedure WESetKrHigh{Var Q:Wins};External;
{$ENDIF}

{���������������������������������������������������������������������������
 �                            Proc�dure WESetKrSel                         �
 ���������������������������������������������������������������������������


 Propri�taire: Wins
 Portabilit�:  Global


 Description
 �����������

  Cette proc�dure permet de fixer la couleur courante de l'�criture du texte
 de la bo�te de dialogue de l'objet �Wins� sp�cialiser pour les s�lections.
}

{$IFDEF FLAT386}
 Procedure WESetKrSel{Var Q:Wins};Assembler;ASM
  MOV CL,[EAX].Window.Palette.Sel
  MOV [EAX].Window.CurrColor,CL
 END;
{$ELSE}
 Procedure WESetKrSel{Var Q:Wins};External;
{$ENDIF}

{�����������������������������������������������������������������������
 �                        Proc�dure WESetEndBarCTitle                  �
 �����������������������������������������������������������������������


 Propri�taire: Wins
 Portabilit�:  Global


 Description
 �����������

  Cette proc�dure permet de fixer la couleur de la barre inf�rieur de la
 bo�te de dialogue de l'objet �Wins�.
}

Procedure WESetEndBarCTitle{Var Q:Wins};Begin
 WESetEndBar(Q,Q.Palette.Title)
End;

{������������������������������������������������������������������������
 �                        Proc�dure _WESetCubeCSel                      �
 ������������������������������������������������������������������������


 Propri�taire: Wins
 Portabilit�:  Global


 Description
 �����������

  Cette proc�dure permet l'affiche d'un caract�re � une coordonn�es texte
 logique pr�cise dans  la fen�tre  de dialogue de  l'objet �Wins� avec la
 couleur de s�lection comme couleur d'�criture et de fond.


 Remarque
 ��������

  � Voici l'apparence de cette proc�dure en langage Pascal pure:
    ����������������������������������������������������������������������Ŀ
    � Procedure _WESetCubeCSel;Begin                                       �
    �  _WESetCube(Q,X,Y,Chr,Q.XColrs.Sel)                                  �
    � End;                                                                 �
    ������������������������������������������������������������������������
}

Procedure _WESetCubeCSel{Var Q:Wins;X,Y:Byte;Chr:Char};Assembler;ASM
 {$IFDEF FLAT386}
  PUSH DWord Ptr Chr
  PUSH DWord Ptr [EAX].Window.Palette.Sel
  CALL _WESetCube
 {$ELSE}
  LES DI,Q
  PUSH ES
  PUSH DI
  PUSH Word Ptr X
  PUSH Word Ptr Y
  PUSH Word Ptr Chr
  PUSH Word Ptr ES:[DI].Window.Palette.Sel
  PUSH CS
  CALL Near Ptr _WESetCube
 {$ENDIF}
END;

{������������������������������������������������������������������������
 �                       Proc�dure _WESetCubeCSelF                      �
 ������������������������������������������������������������������������


 Propri�taire: Wins
 Portabilit�:  Global


 Description
 �����������

  Cette proc�dure permet l'affiche d'un caract�re � une coordonn�es texte
 logique pr�cise dans  la fen�tre  de dialogue de  l'objet �Wins� avec la
 couleur de s�lection comme couleur de fond mais avec une couleur d�finit
 par le programmeur.
}

Procedure _WESetCubeCSelF{Var Q:Wins;X,Y:Byte;Chr:Char;F:Byte};
{$IFDEF NoAsm}
 Begin
  _WESetCube(Q,X,Y,Chr,(Q.Palette.Sel and$F0)+F)
 End;
{$ELSE}
 {$IFDEF FLAT386}
  Begin
   _WESetCube(Q,X,Y,Chr,(Q.Palette.Sel and$F0)+F)
  End;
 {$ELSE}
  Assembler;ASM
   LES DI,Q
   PUSH ES
   PUSH DI
   PUSH Word Ptr X
   PUSH Word Ptr Y
   PUSH Word Ptr Chr
   MOV AL,ES:[DI].Window.Palette.Sel
   AND AL,0F0h
   ADD AL,F
   PUSH AX
   PUSH CS
   CALL Near Ptr _WESetCube
  END;
 {$ENDIF}
{$ENDIF}

{�������������������������������������������������������������������������
 �                         Proc�dure _WESetTitle                         �
 �������������������������������������������������������������������������


 Propri�taire: Wins
 Portabilit�:  Global


 Description
 �����������

  Cette proc�dure permet de r�afficher le titre de la bo�te de dialogue de
 l'objet �Wins� avec sa couleur courante.
}

Procedure _WESetTitle{Var Q:Wins;Const Title:String};Begin
 WESetTitle(Q,Title,Q.Palette.Title)
End;

{�������������������������������������������������������������������������
 �                        Proc�dure _WESetTitleF                         �
 �������������������������������������������������������������������������


 Propri�taire: Wins
 Portabilit�:  Global


 Description
 �����������

  Cette proc�dure permet de r�afficher le titre de la bo�te de dialogue de
 l'objet  �Wins�  avec sa  couleur  de  fond  courante  mais  une  couleur
 d'�criture sp�cifique.
}

Procedure _WESetTitleF{Var Q:Wins;Const Title:String};Begin
 WESetTitle(Q,Title,(Q.Palette.Title and$F0)+F)
End;

{������������������������������������������������������������������������
 �                        Proc�dure WEPutSmallBorder                    �
 ������������������������������������������������������������������������


 Propri�taire: Wins
 Portabilit�:  Global


 Description
 �����������

  Cette proc�dure permet d'afficher une ombrage r�duit sous la fen�tre de
 bo�te de dialogue de l'objet �Wins�.


 Remarque
 ��������

  � Voici l'apparence de cette proc�dure en langage Pascal pure:
    �������������������������������������������������������������������Ŀ
    �Procedure WEPutSmallBorder(Var Q:Wins);Var X3:Byte;Begin           �
    � X3:=MaxXTxts;                                                     �
    � If(Q.X2+1<=X3)Then Begin                                          �
    �  SetCube(Q.X2+1,Q.Y1,'�',GetAttr(Q.X2+1,Q.Y1)and$F0);             �
    �  BarSpcVer(Q.X2+1,Q.Y1+1,Q.Y2,0);                                 �
    �  X3:=Q.X2+1;                                                      �
    � End;                                                              �
    � BarTxtHor(Q.X1+1,Q.Y2+1,X3,'�',GetAttr(Q.X1+1,Q.Y2+1)and$F0)      �
    �End;                                                               �
    ���������������������������������������������������������������������
}

Procedure WEPutSmallBorder{Var Q:Wins};
Var
 X3:Byte;
Begin
 X3:=MaxXTxts;
 If(Q.T.X2+1<=X3)Then Begin
  {$IFDEF FLAT386}
   SetCube(Q.T.X2+1,Q.T.Y1,'�',GetAttr(Q.T.X2+1,Q.T.Y1)and$F0);
   BarSpcVer(Q.T.X2+1,Q.T.Y1+1,Q.T.Y2,0);
   X3:=Q.T.X2+1;
  {$ELSE}
   ASM
      {SetCube(Q.X2+1,Q.Y1,'�',GetAttr(Q.X2+1,Q.Y1)and$F0);}
    LES DI,Q
    MOV AX,Word Ptr ES:[DI].Window.T.Y1
    XCHG AL,AH
    INC AX
    MOV BL,AH
    PUSH AX
    PUSH BX
    MOV CL,'�'
    PUSH CX
     PUSH AX
     PUSH BX
     CALL GetAttr
    AND AL,0F0h
    PUSH AX
    CALL SetCube
     {BarSpcVer(Q.X2+1,Q.Y1+1,Q.Y2,0);
      X3:=Q.X2+1;}
    LES DI,Q
    LES AX,DWord Ptr ES:[DI].Window.T.Y1
    XCHG AL,AH
    ADD AX,0101h
    MOV X3,AL
    PUSH AX
    MOV AL,AH
    PUSH AX
    PUSH ES
    {$IFOPT G+}
     PUSH 0
    {$ELSE}
     MOV AL,0
     PUSH AX
    {$ENDIF}
    CALL BarSpcVer
   END;
  {$ENDIF}
 End;
 {$IFDEF FLAT386}
  BarTxtHor(Q.T.X1+1,Q.T.Y2+1,X3,'�',GetAttr(Q.T.X1+1,Q.T.Y2+1)and$F0);
 {$ELSE}
  ASM
    {BarTxtHor(Q.X1+1,Q.Y2+1,X3,'�',GetAttr(Q.X1+1,Q.Y2+1)and$F0)}
   LES DI,Q
   LES AX,DWord Ptr ES:[DI].Window.T.X1
   MOV BX,ES
   INC AX
   MOV BL,BH
   INC BX
   PUSH AX
   PUSH BX
   PUSH Word Ptr X3
   {$IFOPT G+}
    PUSH 223
   {$ELSE}
    MOV CL,'�'
    PUSH CX
   {$ENDIF}
    PUSH AX
    PUSH BX
    CALL GetAttr
   AND AL,0F0h
   PUSH AX
   CALL BarTxtHor
  END;
 {$ENDIF}
End;

{�����������������������������������������������������������������������
 �                        Fonction _WEInput                            �
 �����������������������������������������������������������������������


 Propri�taire: Wins


 Description
 �����������

  Cette fonction demande un contr�le  de question � la position courante
 dans la bo�te de dialogue de l'objet �Wins� avec �galement les couleurs
 courante par d�faut par cette interrogation.


 Remarque
 ��������

  � Voici l'apparence de cette fonction en langage Pascal pure:
    ����������������������������������������������������������������������Ŀ
    � Function _WEInput;Var K:Word;RX1:Byte;Begin                          �
    �  WEAlignEnd(Q,X2,Y);                                                 �
    �  SetAllKr(Q.InpColor1,Q.InpColor2);                                  �
    �  RX1:=WEGetRX1(Q);K:=Input(RX1+X1,WEGetRY1(Q)+Y,RX1+X2,Len,No,PChr); �
    �  Case(K)of                                                           �
    �   kbMouse:If WEInCloseIcon(Q,LastMsX,LastMsY)Then K:=kbCloseWin Else �
    �           If WEInWn(Q,LastMsX,LastMsY)Then K:=kbInWn;                �
    �  End;                                                                �
    �  _WEInput:=K                                                         �
    � End;                                                                 �
    ������������������������������������������������������������������������
}

Function _WEInput{Var Q:Wins;X1,Y,X2:Byte;Len:Word;Var PChr:PChr):Word};
Label Restart;
Var
 K:Word;
 {$IFDEF FLAT386}
  RX1:Byte;
 {$ENDIF}
Begin
Restart:
 {$IFDEF FLAT386}
  SetAllKr(Q.InpColor1,Q.InpColor2);
  WEAlignEnd(Q,X2,Y);
  RX1:=WEGetRX1(Q);
  K:=Input(RX1+X1,WEGetRY1(Q)+Y,RX1+X2,Len,No,PChr);
 {$ELSE}
  ASM
   LES DI,Q
    {SetAllKr(Q.InpColr1,Q.InpColor2);}
   MOV AX,Word Ptr ES:[DI].Window.InpColor1
   PUSH AX
   MOV AL,AH
   PUSH AX
   CALL SetAllKr
    {WEAlignEnd(Q,X2,Y);
     RX1:=WEGetRX1(Q);
     K:=Input(RX1+X1,WEGetRY1(Q)+Y,RX1+X2,Len,No,PChr);}
   MOV AL,X2
   MOV AH,Y
   CALL AsmWEAlignEnd
   XCHG AX,CX
   CALL AsmWEGetR
   MOV BL,X1
   ADD BL,AL
   PUSH BX
   MOV BL,CH
   ADD BL,AH
   PUSH BX
   ADD AL,CL
   PUSH AX
   PUSH Len
   {$IFOPT G+}
    PUSH 0
   {$ELSE}
    XOR AX,AX
    PUSH AX
   {$ENDIF}
   LES DI,PChr
   PUSH ES
   PUSH DI
   PUSH CS
   CALL Near Ptr Input
   MOV K,AX
  END;
 {$ENDIF}
 Case(K)of
  kbMouse:If WEInCloseIcon(Q,LastMouseX,LastMouseY)Then Begin
           WaitMouseBut0;
           K:=kbCloseWin;
          End
           Else
	  If WEInWindow(Q,LastMouseX,LastMouseY)Then K:=kbInWn Else
          If WEInTitle(Q,LastMouseX,LastMouseY)Then Begin
           If Q.SizeBuffer<>0Then Begin
            WEMoveWn(Q);
            Goto Restart;
           End
            Else
           K:=kbTitle;
          End;
 End;
 _WEInput:=K
End;

{���������������������������������������������������������������������������
 �                            Fonction WEPushWn                            �
 ���������������������������������������������������������������������������


 Propri�taire: Wins


 Description
 �����������

  Cette fonction permet de sauvegarder l'arri�re plan de la fen�tre de bo�te
 de dialogue de l'objet �Wins�.


 Remarque
 ��������

  � Voici l'apparence de cette fonction en langage Pascal pure:
    ����������������������������������������������������������������������Ŀ
    �  If(Q.Buf<>NIL)Then WEPopWn(Q);                                      �
    �  WEPushWn:=No;                                                       �
    �   If(IsGraf)Then SaveImage(Q.X1 shl 3,GetRawY(Q.Y1),                 �
    �                  (Q.X2 shl 3)+7,GetRawY(Q.Y2+1)-1,Q.Img);            �
    �  X2:=Q.X2+2;                                                         �
    �  If(X2>MaxXTxts)Then X2:=MaxXTxts;                                   �
    �  Q.SizeBuf:=SizeBoxTxt(Q.X1,Q.Y1,X2,Q.Y2+Byte(Q.Shade));             �
    �  (*$IFDEF HeapVram*)Q.Buf:=VAllocMem(Q.SizeBuf);                     �
    �  If(Q.Buf=NIL)Then(*$ENDIF*)Q.Buf:=MemAlloc(Q.SizeBuf);              �
    �  If(Q.Buf=NIL)Then Begin                                             �
    �   Q.SizeBuf:=0;GetSysErr:=errWinsPushText;                           �
    �   Exit;                                                              �
    �  End;                                                                �
    �  CopyBoxTxt(Q.X1,Q.Y1,X2,Q.Y2+Byte(Q.Shade),Q.Buf^);                 �
    �  WEPushWn:=Ya                                                        �
    � End;                                                                 �
    ������������������������������������������������������������������������
}

Function WEPushWn{Var Q:Wins):Boolean};
Var
 X2:Byte;
 G:GraphBoxRec;
Begin
 If(Q.Buffer<>NIL)Then WEPopWn(Q);
 WEPushWn:=False;
 If(IsGraf)Then Begin
  CoordTxt2Graph(Q.T.X1,G);
  SaveImage(G.X1,G.Y1,G.X2,G.Y2,Q.Image);
 End;
 X2:=Q.T.X2+2;
 If(X2>MaxXTxts)Then X2:=MaxXTxts;
 ASM
  {Q.SizeBuf:=SizeBoxTxt(Q.X1,Q.Y1,X2,Q.Y2+Byte(Q.Shade));}
(*  {$IFDEF DPMI}*)
   {$IFDEF FLAT386}
    LEA EDX,DWord Ptr Q
    MOV CL,[EDX].Window.Shade
    ADD CL,[EDX].Window.T.Y2
    PUSH ECX
    MOV AX,Word Ptr [EDX].Window.T.X1
    MOV DL,AH
    MOV CL,X2
    CALL SizeBoxTxt
    LEA EDX,DWord Ptr Q
    MOV [EDX].Window.SizeBuffer,AX
   {$ELSE}
    LES DI,Q
    MOV CL,ES:[DI].Window.Shade
    MOV AX,Word Ptr ES:[DI].Window.T.X1
    PUSH AX
    MOV AL,AH
    PUSH AX
    PUSH Word Ptr X2
    MOV AL,ES:[DI].Window.T.Y2
    ADD AL,CL
    PUSH AX
    CALL SizeBoxTxt
    MOV ES:[DI].Window.SizeBuffer,AX
   {$ENDIF}
(*  {$ELSE}
    { Cette proc�dure n'est malheureusement utilisable quand mode r�el
      car en mode prot�g� le registre de segment de donn�es doit toujours
      avoir sa valeur d'origine lorsqu'il appel une autre proc�dure...}
   CLD
   PUSH DS
    LDS SI,Q
    MOV DI,SI
    ADD SI,Offset Wins.X1
    LODSB
    PUSH AX               { X1 }
    LODSB
    PUSH AX               { Y1 }
    LODSB
    PUSH Word Ptr X2      { X2 }
    LODSB
    ADD AL,DS:[DI].Wins.Shade
    PUSH AX               { Y2 }
    CALL SizeBoxTxt
    MOV DS:[DI].Wins.SizeBuffer,AX
   POP DS
  {$ENDIF}*)
 END;
 {$IFDEF HeapVram}Q.Buffer:=VAllocMem(Q.SizeBuf);
 If(Q.Buffer=NIL)Then{$ENDIF}Q.Buffer:=MemAlloc(Q.SizeBuffer);
 If(Q.Buffer=NIL)Then Begin
  Q.SizeBuffer:=0;
  GetSysErr:=errWinPushText;
  Exit;
 End;
 ASM
   {CopyBoxTxt(Q.X1,Q.Y1,X2,Q.Y2+Byte(Q.Shade),Q.Buf^);}
(*  {$IFDEF DPMI}*)
   {$IFDEF FLAT386}
    LEA EDX,DWord Ptr Q
    MOV CL,[EDX].Window.Shade
    ADD CL,[EDX].Window.T.Y2
    PUSH ECX
    LEA ECX,[EDX].Window.Buffer
    PUSH ECX
    MOV AX,Word Ptr [EDX].Window.T.X1
    MOV DL,AH
    MOV CL,X2
    CALL CopyBoxTxt
   {$ELSE}
    LES DI,Q
    MOV CL,ES:[DI].Window.Shade
    MOV AX,Word Ptr ES:[DI].Window.T.X1
    PUSH AX
    MOV AL,AH
    PUSH AX
    PUSH Word Ptr X2
    MOV AL,ES:[DI].Window.T.Y2
    ADD AL,CL
    PUSH AX
    LES DI,ES:[DI].Window.Buffer
    PUSH ES
    PUSH DI
    CALL CopyBoxTxt
   {$ENDIF}
(*  {$ELSE}
   { Cette proc�dure n'est malheureusement utilisable quand mode r�el
     car en mode prot�g� le registre de segment de donn�es doit toujours
     sa valeur d'origine lorsqu'il appel une autre proc�dure...}
   CLD
   MOV BX,DS
   LDS SI,Q
   MOV DI,SI
   ADD SI,Offset Wins.X1
   LODSB
   PUSH AX               { X1 }
   LODSB
   PUSH AX               { Y1 }
   LODSB
   PUSH Word Ptr X2      { X2 }
   LODSB
   ADD AL,DS:[DI].Wins.Shade
   PUSH AX               { Y2 }
   ADD SI,Offset Wins.Buf-Offset Wins.X1-4
   LODSW
   PUSH AX
   LODSW
   PUSH AX
   MOV DS,BX
   CALL CopyBoxTxt
  {$ENDIF}*)
 END;
 WEPushWn:=True
End;

{�������������������������������������������������������������������������
 �                           Fonction WEPopWn                            �
 �������������������������������������������������������������������������


 Propri�taire: Wins


 Description
 �����������

  Cette fonction permet de restaurer l'arri�re plan de la fen�tre de bo�te
 de dialogue de l'objet �Wins�.
}

Function WEPopWn{Var Q:Wins):Boolean};
Var
 X2:Byte;
 G:GraphBoxRec;
Begin
 WEPopWn:=False;
 If(Q.Buffer<>NIL)Then Begin
  If(IsGraf)Then Begin
   CoordTxt2Graph(Q.T.X1,G);
   PutImage(G.X1,G.Y1,G.X2,G.Y2,Q.Image);
  End;
  If Q.SizeBuffer<>0Then Begin
   X2:=Q.T.X2+2;
   If(X2>MaxXTxts)Then X2:=MaxXTxts;
   ASM
     {PutBoxTxt(Q.X1,Q.Y1,X2,Q.Y2+Byte(Q.Shade),Q.Buf^);}
    {$IFDEF FLAT386}
     LEA EDX,DWord Ptr Q
     MOV CL,[EDX].Window.Shade
     ADD CL,[EDX].Window.T.Y2
     PUSH ECX
     LEA ECX,[EDX].Window.Buffer
     PUSH ECX
     MOV AX,Word Ptr [EDX].Window.T.X1
     MOV DL,AH
     MOV CL,X2
     CALL PutBoxTxt
    {$ELSE}
     LES DI,Q
     MOV CL,ES:[DI].Window.Shade
     MOV AX,Word Ptr ES:[DI].Window.T.X1
     PUSH AX
     MOV AL,AH
     PUSH AX
     PUSH Word Ptr X2
     MOV AL,ES:[DI].Window.T.Y2
     ADD AL,CL
     PUSH AX
     LES DI,ES:[DI].Window.Buffer
     PUSH ES
     PUSH DI
     CALL PutBoxTxt
    {$ENDIF}
   END;
  End;
  WEFreeAll(Q)
 End;
 WEPopWn:=True
End;

{������������������������������������������������������������������������
 �                          Fonction WEFreeAll                          �
 ������������������������������������������������������������������������


 Propri�taire: Wins


 Description
 �����������

  Cette fonction lib�re toutes les ressources utilis�es par la fen�tre de
 bo�te de dialogue de l'objet �Wins�.
}

Function WEFreeAll{Var Q:Wins):Boolean};Begin
 WEFreeAll:=False;
 If(Q.Buffer<>NIL)Then Begin
  If(IsGraf)Then XFreeMem(Q.Image.X);
  If Q.SizeBuffer<>0Then Begin
   {$IFDEF HeapVram}
    If(PtrRec(Q.Buf).Seg>=IVid.SegV)Then VFreeMem(Q.Buf,Q.SizeBuf)
     Else
   {$ENDIF}
   FreeMemory(Q.Buffer,Q.SizeBuffer)
  End
 End;
 ASM{Q.SizeBuffer:=0;Q.Buffer:=NIL;WEFreeAll:=Ya}
  LES DI,Q
  XOR AX,AX
  {$IFDEF FuckedRecord}
   MOV Word Ptr ES:[DI].Window.Buffer,AX
   MOV Word Ptr ES:[DI].Window.Buffer[2],AX
   MOV ES:[DI].Window.SizeBuffer,AX
  {$ELSE}
   CLD
   ADD DI,Window.Buffer
   STOSW
   STOSW
   STOSW
  {$ENDIF}
  MOV @Result,True
 END;
End;

{���������������������������������������������������������������������
 �                        Proc�dure _WEPutWn                         �
 ���������������������������������������������������������������������


 Propri�taire: Wins


 Description
 �����������

  Cette proc�dure permet d'afficher la fen�tre de bo�te de dialogue de
 l'objet �Wins� avec la palette de couleur par d�faut.
}

Procedure _WEPutWn{Var Q:Wins;Const Title:String};Begin
 WEPutWn(Q,Title,Q.Palette)
End;

{���������������������������������������������������������������������
 �                        Proc�dure WEPutWnKrDials                   �
 ���������������������������������������������������������������������


 Propri�taire: Wins


 Description
 �����������

  Cette proc�dure permet d'afficher la fen�tre de bo�te de dialogue de
 l'objet �Wins� avec la palette de couleur courante pour le dialogue.
}

Procedure WEPutWnKrDials{Var Q:Wins;Const Title:String};Begin
 WEPutWn(Q,Title,CurrKrs.Dialog.Window)
End;

Procedure BiClrLnHorImg(GX1,GX2,GY1,Len:Word;BitsPerPixel:Byte;Var Buffer1,Buffer2);Near;Begin
 ClrLnHorImg(GX1,GY1,Len,BitsPerPixel,Buffer1);
 ClrLnHorImg(GX2,GY1,Len,BitsPerPixel,Buffer2);
End;

{���������������������������������������������������������������������
 �                        Proc�dure WEPutWn                          �
 ���������������������������������������������������������������������


 Propri�taire: Wins


 Description
 �����������

  Cette proc�dure permet d'afficher la fen�tre de bo�te de dialogue de
 l'objet �Wins� avec la palette sp�cifi�e.
}

Procedure WEPutWn{Var Q:Wins;Const Title:String;Const Palette:MtxColors};
Label Trunc;
Const
 MatrixBorder:Border8BitsColorType=(
  (32,34,36,38,40,42,44,46),
  (46,44,42,40,38,36,34,32)
 );
 MatrixRobotic:Array[0..7]of Byte=(
  36,37,38,39,40,39,38,37
 );
 MatrixRobotic16:Array[0..7]of Byte=(
  0,8,7,15,15,7,8,0
 );
 BordKr:Array[0..$F]of Byte=(
  0,16,0,0,0,0,0,0,0,48,0,0,0,0,0,32
 );
Var
 SkipTitle,Left,Right:Byte;
 GSkipTitle:Word;
 J,I,Color,B1,B2,GX3,GX4:Word;
 G:GraphBoxRec;
 LenTitle:Byte Absolute Title;
 HI,BP,Jx,X,BorderColor:Byte;
 Border:Array[0..1,0..7]of Byte;
 YTab:Array[0..2]of Word;
 BorderTrueColor:BorderTrueColorType;
Begin
 ASM
  {$IFDEF FLAT386}
   MOV X,1
  {$ELSE}
   MOV CX,TYPE Window
   LES DI,Q
   XOR AL,AL
 @1:
   OR  AL,ES:[DI]
   INC DI
   LOOP @1
   MOV X,AL
  {$ENDIF}
 END;
 If X=0Then Exit;
 If(Q.T.Y1>Q.T.Y2)Then Exit;
 Q.Palette:=Palette;
 SkipTitle:=Byte(Length(Title)>0);
 Left:=Byte(DegradSupport and(WinType=Robotic)and (Q.NotFullScrnX));
 Right:=Byte(DegradSupport and(WinType=Robotic)and (Q.NotFullScrnX));
 If CurBorder[0]='�'Then Begin
  {$IFNDEF GraphicOS}If Not(HoleMode)Then {$ENDIF}ASM
    {PutFillBorder(Q.X1,Q.Y1,Q.X2,Q.Y2,Colrs.Border); }
   PUSH DS
    LDS SI,Q
    ADD SI,Window.T.X1
    CLD
    LODSB;PUSH AX
    LODSB;PUSH AX
    LODSB;PUSH AX
    LODSB;PUSH AX
    ADD SI,MtxColors.Border+2
    LODSB;PUSH AX
    CALL PutFillBorder
   POP DS
  END;
  {$IFDEF GraphicOS}
   PutTxtXY((Q.T.X2-(Q.T.X1+1+LenTitle))shr 1,Q.T.Y1,' '+Title+' ',Palette.Border)
  {$ELSE}
   PutTxtXYHole((Q.T.X2-(Q.T.X1+1+LenTitle))shr 1,Q.T.Y1,' '+Title+' ',Palette.Border)
  {$ENDIF}
 End
  Else
 Repeat
  If Not((winNotClearBackground)in(Q.Attribut))Then Begin
   {$IFDEF DPMI}
    ClrWn(Q.T.X1+Left,Q.T.Y1+SkipTitle,Q.T.X2-Right,Q.T.Y2,Palette.Border);
   {$ELSE}
    If(IsGrf)and(WinType=MacOsX)Then Begin
     ClrBoxTxt(Q.T.X1+Left,Q.T.Y1+SkipTitle,Q.T.X2-Right,Q.T.Y2);
    End
     Else
    ASM
       { ClrWnHole(Q.T.X1,Q.T.Y1+SkipTitle,Q.T.X2-Right,Q.T.Y2,Colrs.Border);}
     MOV DX,DS
     LDS SI,Q
     ADD SI,Window.T.X1
     CLD
     LODSB
     ADD AL,Left
     PUSH AX
     LODSB
     ADD AL,SkipTitle
     PUSH AX
     LODSB
     SUB AL,Right
     PUSH AX
     LODSB;PUSH AX
     ADD SI,MtxColors.Border+2
     LODSB;PUSH AX
     MOV DS,DX
     {$IFDEF GraphicOS}
      CALL ClrWn
     {$ELSE}
      CALL ClrWnHole
     {$ENDIF}
    END;
   {$ENDIF}
  End;
 If(IsGraf)Then Begin
  If(WinType=ClearWindow)Then Goto Trunc;
  BorderColor:=Palette.Border shr 4;
  {Ces instructions sont �quivalente � ceci:
    G.X1:=Q.X1 shl 3;
    G.Y1:=GetRawY(Q.Y1);
    G.X2:=Q.X2 shl 3;
    G.Y2:=GetRawY(Q.Y2+1)-1;}
  CoordTxt2Graph(Q.T.X1,G);
  GSkipTitle:=GetRawY(SkipTitle);
  If(WinType=MacOsX)Then __PutFillBox2Line(G);
  Dec(G.X2,7);
  If(DegradSupport)or((BitsPerPixel=4){and(WinType=Robotic)})Then Begin
   If(WinType=Robotic)Then Begin
    MakePaletteColorToWhite(7,4,BorderTrueColor[0,0]);
    MakePaletteWhiteToColor(7,4,BorderTrueColor[0,4]);
    If(Q.NotFullScrnX)Then Begin
     HI:=0;
     B1:=Q.T.Y1*NmXTxts;
     B2:=B1+Q.T.X2;
     Inc(B1,Q.T.X1);
     Case(BitsPerPixel)of
      4:{$IFNDEF GraphicOS}
       If(HoleMode)and(Hole<>NIL)Then For J:=G.Y1+GSkipTitle to(G.Y2)do Begin
        If Not Hole^[B1]Then ClrLnHorImg(G.X1,J,8,8,MatrixRobotic16);
        If Not((winNotBorderRight)in(Q.Attribut))Then Begin
         If Not Hole^[B2]Then ClrLnHorImg(G.X2,J,8,8,MatrixRobotic16);
        End;
        Inc(HI);
        If(HI=HeightChr)Then Begin
         Inc(B1,NmXTxts);
         Inc(B2,NmXTxts);
         HI:=0;
        End;
       End
        Else
      {$ENDIF}
      For J:=G.Y1+GSkipTitle to(G.Y2)do BiClrLnHorImg(G.X1,G.X2,J,8,8,MatrixRobotic16,MatrixRobotic16);
      8:{$IFNDEF GraphicOS}
       If(HoleMode)and(Hole<>NIL)Then For J:=G.Y1 to(G.Y2)do Begin
        If Not Hole^[B1]Then ClrLnHorImg(G.X1,J,8,8,MatrixRobotic);
        If Not((winNotBorderRight)in(Q.Attribut))Then Begin
         If Not Hole^[B2]Then ClrLnHorImg(G.X2,J,8,8,MatrixRobotic);
        End;
        Inc(HI);
        If(HI=HeightChr)Then Begin
         Inc(B1,NmXTxts);
         Inc(B2,NmXTxts);
         HI:=0;
        End;
       End
        Else
      {$ENDIF}
      For J:=G.Y1+GSkipTitle to(G.Y2)do BiClrLnHorImg(G.X1,G.X2,J,8,8,MatrixRobotic,MatrixRobotic);
      15,16:{$IFNDEF GraphicOS}
       If(HoleMode)and(Hole<>NIL)Then For J:=G.Y1 to(G.Y2)do Begin
        If Not Hole^[B1]Then ClrLnHorImg(G.X1,J,8,16,BorderTrueColor[0]);
        If Not((winNotBorderRight)in(Q.Attribut))Then Begin
         If Not Hole^[B2]Then ClrLnHorImg(G.X2,J,8,16,BorderTrueColor[0]);
        End;
        Inc(HI);
        If(HI=HeightChr)Then Begin
         Inc(B1,NmXTxts);
         Inc(B2,NmXTxts);
         HI:=0;
        End;
       End
        Else
      {$ENDIF}
      Begin
       If(winNotBorderRight)in(Q.Attribut)Then Begin
        For J:=G.Y1+GSkipTitle to(G.Y2)do ClrLnHorImg(G.X1,J,8,16,BorderTrueColor[0]);
       End
        Else
       For J:=G.Y1+GSkipTitle to(G.Y2)do BiClrLnHorImg(G.X1,G.X2,J,8,16,BorderTrueColor[0],BorderTrueColor[0]);
      End;
     End;
     _SetKr(0);
     YTab[0]:=G.Y1+24;
     YTab[1]:=G.Y1+((G.Y2-G.Y1)shr 1);
     YTab[2]:=G.Y2-24;
     For I:=0to 2do Begin
      {$IFDEF GraphicOS}
       _LnHor(G.X1,YTab[I],G.X1+7);
       _LnHor(G.X2,YTab[I],G.X2+7)
      {$ELSE}
       _LnHorHole(G.X1,YTab[I],G.X1+7);
       _LnHorHole(G.X2,YTab[I],G.X2+7)
      {$ENDIF}
     End;
    End;
    If(Q.NotFullScrnY)Then Begin
     For J:=0to 7do Begin
      Case(BitsPerPixel)of
       4:Color:=MatrixRobotic16[J];
       15,16:Color:=BorderTrueColor[0,J];
       Else Begin
        If J<4Then Color:=J+36
              Else Color:=40-(J and 3);
       End;
      End;
      GX3:=G.X1;GX4:=G.X2+7;
      If(Q.NotFullScrnX)Then ASM
        {GX3+:=J,GX4-:=J;}
       MOV AX,J
       ADD GX3,AX
       SUB GX4,AX
      END;
      _SetKr(Color);
      {$IFDEF GraphicOS}
       If Title=''Then _LnHor(GX3,G.Y1+J,GX4);
       If Not((winNotBorderDown)in(Q.Attribut))Then _LnHor(GX3,G.Y2-J,GX4)
      {$ELSE}
       If Title=''Then _LnHorHole(GX3,G.Y1+J,GX4);
       If Not((winNotBorderDown)in(Q.Attribut))Then _LnHorHole(GX3,G.Y2-J,GX4)
      {$ENDIF}
     End;
     {$IFNDEF GraphicOS}
      If(HoleMode)Then Goto Trunc;
     {$ENDIF}
     _SetKr(0);
     YTab[0]:=G.X1+24;
     Dec(YTab[1],G.Y1);
     Inc(YTab[1],G.X1);
     YTab[2]:=G.X2-24;
     For I:=0to 2do _Ln(YTab[I],G.Y2-7,YTab[I],G.Y2)
    End;
   End
    Else
   If(BorderColor<=7)or(StyleBackgroundMenu=sbmMacOsX)Then BoxRelief(Q.T.X1,Q.T.Y1,Q.T.X2,Q.T.Y2,BorderColor shl 4)
    Else
   Begin
    BP:=BordKr[BorderColor];
    If(BP>0)or(BitsPerPixel>=15)Then Begin
     If(Q.NotFullScrnX)Then Begin
      If BitsPerPixel=8Then Begin
       MoveLeft(MatrixBorder,Border,SizeOf(Border));
       If BP<>32Then For J:=0to 1do For I:=0to 7do Dec(Border[J,I],32-BP);
       For J:=G.Y1 to(G.Y2)do BiClrLnHorImg(G.X1,G.X2,J,8,8,Border[0],Border[1]);
      End
       Else
      Begin { TrueColor-16 bits}
       MakePaletteColorToWhite(BorderColor,8,BorderTrueColor[0,0]);
       MakePaletteWhiteToColor(BorderColor,8,BorderTrueColor[1,0]);
       For J:=G.Y1 to(G.Y2)do BiClrLnHorImg(G.X1,G.X2,J,8,16,BorderTrueColor[0],BorderTrueColor[1]);
      End;
     End;
     If(Q.NotFullScrnY)Then For J:=0to HeightChr-1do Begin
      Jx:=J;
      If HeightChr=8Then ASM SHL Jx,1;END;
      GX3:=G.X1;GX4:=G.X2+7;
      If(Q.NotFullScrnX)Then ASM
       MOV AL,Jx
       XOR AH,AH
       SHR AX,1
       ADD GX3,AX
       SUB GX4,AX
      END;
      If BitsPerPixel in[15,16]Then Begin
       I:=J shl 4;
       _SetKr(RGB2Color(I and DefaultRGB[BorderColor].R,
                        I and DefaultRGB[BorderColor].G,
                        I and DefaultRGB[BorderColor].B));
      End
       Else
      _SetKr(Jx+BP);
      If Title=''Then _LnHor(GX3,G.Y1+J,GX4);
      _LnHor(GX3,G.Y2-J,GX4)
     End;
    End;
   End;
  End
   Else
  Begin
   PutRect(G.X1,G.Y1,G.X2+7,G.Y2,Palette.Border and$F);
  End;
 End
  Else
 Begin
  {$IFDEF NotReal}
   If Byte(Q.NotFullScrnX)and Byte(Q.NotFullScrnY)<>0Then Begin
    If(FontFound)Then __PutBorderUnKr(Q.T.X1)
                 Else BarChrHor(Q.T.X1,Q.T.Y2,Q.T.X2,'_');
   End;
   If(Q.Shade)Then PutBoxOnlyShade(Q.T.X1,Q.T.Y1,Q.T.X2,Q.T.Y2);
  {$ELSE}
   ASM
    PUSH DS
     MOV BX,DS
     LDS SI,Q
     CLD
     MOV AL,DS:[SI].Window.NotFullScrnX
     AND AL,DS:[SI].Window.NotFullScrnY
     JZ  @2
     ADD SI,Window.T.X1
     LODSB;PUSH AX
     LODSB;PUSH AX
     LODSB;PUSH AX
     CALL FontFound
     CMP  AL,0
     JE   @1
     LODSB;PUSH AX
     MOV DS,BX
     CALL PutBorderUnKr
     JMP @2
  @1:MOV AL,'_'
    PUSH AX
    CALL BarChrHor
  @2:LDS SI,Q
    CMP DS:[SI].Window.Shade,False
    JE  @9
    ADD SI,Window.T.X1
    LODSB;PUSH AX
    LODSB;PUSH AX
    LODSB;PUSH AX
    LODSB;PUSH AX
    CALL PutBoxOnlyShade
  @9:POP DS
   END;
  {$ENDIF}
 End;
Trunc:
 If Title<>''Then WESetTitle(Q,Title,Palette.Title)
 Until True;
 ASM{Q.Kr:=Colrs.Border}
  {$IFDEF FLAT386}
   LEA EDX,Q
   MOV AL,[EDX].Window.Palette.Border
   MOV [EDX].Window.CurrColor,AL
  {$ELSE}
   LES DI,Q
   MOV AL,ES:[DI].Window.Palette.Border
   MOV ES:[DI].Window.CurrColor,AL
  {$ENDIF}
 END;
End;

{����Ensemble de gestion des Boutons����}

{���������������������������������������������������������������������
 �                          Fonction SrchK                           �
 ���������������������������������������������������������������������


 Portabilit�: Local


 Description
 �����������

  Cette fonction effectue la recherche d'une bouton dans une cha�ne de
 caract�res de format Pascal s�par�e par des pipes-lines (|) et retour
 le nom de la cha�ne correspondant au num�ro.
}

Function SearchKey(P,NK:Byte;Const KeyStr:String):String;Near;
Var
 I,Start,Len,NC:Byte;
Begin
 If NK=0Then Begin
  If KeyStr[1]='$'Then SearchKey:=Copy(KeyStr,2,255)
                  Else SearchKey:=KeyStr;
 End
  else
 Begin
  I:=0;NC:=0;
  While(NC<P)do Begin
   Inc(I);
   If KeyStr[I]='|'Then Inc(NC)
  End;
  If P>0Then Inc(I);
  Start:=I;
  While KeyStr[I]<>'|'do Inc(I);
  If(P=NK)Then Len:=255 else
  If P<>0Then Len:=I-Start
   Else
  Begin
   Inc(Start);Len:=I-Start;
   If KeyStr[1]='$'Then Begin
    Inc(Start);
    Dec(Len)
   End;
  End;
  SearchKey:=Copy(KeyStr,Start,Len)
 End;
End;

{�������������������������������������������������������������������������
 �                            Fonction WESetPosk                         �
 �������������������������������������������������������������������������


 Portabilit�:  Local
 Propri�taire: Window


 Description
 �����������

  Cette fonction retourne le nombre de bouton ainsi que la largeur sugg�r�
 pour ces m�mes  boutons  lors  de  l'affichage  de la fen�tre de bo�te de
 dialogue de l'objet �Window�.
}

Function WESetPosk(Const k:String;Var NK:Byte):Byte;Near;
Var
 ML,I,L:Byte;
 kLen:Byte Absolute k;
Begin
 ML:=0;L:=0;NK:=0;
 For I:=1to(kLen)do Begin
  If k[I]='|'Then Begin
   If(L>ML)Then ML:=L;
   Inc(NK);
   L:=0;
  End
   else
  If Not(k[I]in['^','~'])Then Inc(L)
 End;
 If(L>ML)Then ML:=L;
 Inc(ML,4);
 If ML<8Then ML:=8;
 WESetPosk:=ML
End;

Function __WEPutkHor(Var Inf:Window;X,Y,JK:Byte;Const kStr:String;Var XTab:XTabType;High:Boolean):Byte;
Var
 I,LK,NK,Color:Byte;
 kStrLen:Byte Absolute kStr;
 R:TextCharRec;
Begin
 LK:=JK-3;NK:=0;
 ASM
  LES DI,Inf
  CALL asmWEGetR
  MOV BL,X
  MOV BH,Y
  ADD AX,BX
  MOV R,AX
 END;
 For I:=1to(kStrLen)do If kStr[I]='|'Then Inc(NK);
 If NK=0Then LK:=JK-1;
 For I:=0to(NK)do Begin
  XTab[I]:=R.X;
  If(High)Then Color:=GetKeySelKr
          Else Color:=Inf.Palette.Key;
  PutKeyHori(R.X,R.Y,R.X+LK,SearchKey(I,NK,kStr),Color,Inf.Palette.kShade);
  Inc(R.X,JK);
 End;
 __WEPutkHor:=NK;
End;

{�������������������������������������������������������������������������
 �                          Fonction _WEPutkHor                          �
 �������������������������������������������������������������������������


 Portabilit�:  Local
 Propri�taire: Window


 Description
 �����������

  Cette fonction permet d'afficher une liste de bouton horizontal dans une
 fen�tre de bo�te  de dialogue  de l'objet �Window� � une position logique
 avec une largeur sp�cifi� et  de programmeur les positions sugg�r�es pour
 chacun du/des bouton(s).
}

Function _WEPutkHor(Var Inf:Window;X,Y,JK:Byte;Const kStr:String;Var XTab:XTabType):Byte;Near;Begin
 _WEPutkHor:=__WEPutkHor(Inf,X,Y,JK,kStr,XTab,False);
End;

Function WEGetCompatPosition(Var Q:Window;NumElement:LongInt):LongInt;
Var
 TP:Word; { Position du compat }
Begin
 TP:=Trunc((LastMouseY-WEGetRY1(Q)-Q.LineHome)*((NumElement)/(Q.HeightBar-2)));
 If(TP>=NumElement)Then TP:=NumElement-1;
 WEGetCompatPosition:=TP;
End;

{��������������������������������������������������������������������
 �                        Fonction WEGetkHor                        �
 ��������������������������������������������������������������������


 Portabilit�:  Global
 Propri�taire: Window


 Description
 �����������

  Cette fonction affiche et demande � l'utilisateur de choisir un des
 boutons  sp�cifi�e  dans la fen�tre  de bo�te de dialogue de l'objet
 �Window�.
}

Function WEGetkHor{Var Q:Window;X,Y,JK:Byte;Const kStr:String):Byte};
Const
 RotateColor:Array[0..3]of Byte=(
  Black,Yellow,LightBlue,LightGreen
 );
Var
 I,LK,NK,RY1,_AL:Byte;
 K:Word;
 kStrLen:Byte Absolute kStr;
 XTab:XTabType;

 Procedure PutBar(Color:Byte);
 Label 3,9,Break;
 Var
  M:TextCharRec;
  _X1,Ya,I1:Byte;
  B:Word;
  A:TextBoxRec;

  Procedure BarColor;Begin
   BarSelHor(_X1+1,RY1+Y,_X1+LK-1,Color);
  End;

  Procedure Key;Begin
   Video.PutKeyHori(_X1,RY1+Y,_X1+LK,SearchKey(I,NK,kStr),
                    Q.Palette.Key,Q.Palette.kShade);
  End;

 Begin
  _X1:=XTab[I];I1:=GetKeySelKr;
  If(kType=ktOS2Win)Then ASM
   AND Color,7Fh
   AND I1,7Fh
  END;
  If Color and$F0<>I1 and$F0Then Begin
   If(IsGrf)Then __HideMousePtr;
   Key;
   If(IsGrf)Then __ShowMousePtr;
  End
   Else
  Begin
    A.X1:=_X1+1;A.X2:=_X1+LK-1;
    Ya:=RY1+Y;A.Y1:=Ya;A.Y2:=Ya;
    __GetMouseTextSwitchZ(M,B);
    If(M.Y>=A.Y1)and(M.Y<=A.Y2)Then Begin
     If(M.X>=A.X1)and(M.X<=A.X2)Then Begin
      If(GetMousePtrType=mpTxtGrf)Then BarColor Else
      If(IsGraf)Then Begin
       __HideMousePtr;
       BarSelHor(A.X1,Ya,A.X2,Color);
       __ShowMousePtr
      End
       Else
      Begin
       If(M.X=A.X1)Then Goto 3
        Else
       Begin
        BarSelHor(A.X1,Ya,M.X-Byte(Q.NotFullScrnX),Color);
        If(M.X<>A.X2)Then 3:BarSelHor(M.X+1,Ya,A.X2,Color);
       End;
       SetAttr(M.X,Ya,Not(Color));
      End;
      If B=1Then Begin
       If WaitMouseBut0OrOutZone(A)Then Exit;
       PushKey(kbEnter)
      End;
     End
      Else
     If B=1Then Begin
      For I1:=0to(NK)do Begin
       If(M.X>=XTab[I1])and(M.X<=XTab[I1]+LK)Then Begin
	_X1:=XTab[I];
        Key;
	I:=I1;
        If WaitMouseBut0OrOutZone(A)Then Exit;
	PushKey(kbEnter);
	BarSelHor(_X1+1,RY1+Y,_X1+LK-1,Q.Palette.kSel);
	Goto Break
       End
      End;
Break:End
     Else
    Goto 9;
   End
    Else
 9:BarColor
  End
 End;

 Procedure Key(Sel:Boolean);
 Var
  Color:Byte;
 Begin
  If(Sel)Then Color:=GetKeySelKr
         Else Color:=Q.Palette.Key;
  Video.PutKeyHori(XTab[I],RY1+Y,XTab[I]+LK,SearchKey(I,NK,kStr),
                   Color,Q.Palette.kShade);
 End;

Begin
 LK:=JK-3;
 RY1:=WEGetRY1(Q);
 NK:=_WEPutkHor(Q,X,Y,JK,kStr,XTab);
 I:=0;
 If NK=0Then LK:=JK-1;
 Repeat
  InitKbd;
  Key(True);
  __ShowMousePtr;
  Repeat
   _BackKbd;
   If GetBitsPerPixel=1Then Case GetRawTimerB and$Fof
    0:PutBar(GetKeyKr);
    8:PutBar($F);
   End
    Else
   Begin
    ASM
     {$IFDEF FLAT386}
      CALL GetRawTimerB
      XCHG AX,CX
      AND ECX,0Fh
      SHR ECX,2
      LEA EDX,Q
      MOV AH,[EDX].Window.Palette.kSel
      CMP kType,ktElvis
      JAE @1
      MOV AH,[EDX].Window.Palette.Border
   @1:AND AH,0F0h
      ADD AH,Byte Ptr RotateColor[ECX]
      MOV _AL,AH
     {$ELSE}
      CALL GetRawTimerB
      XCHG AX,BX
      AND BX,0Fh
      {$IFOPT G+}
       SHR BL,2
      {$ELSE}
       SHR BL,1
       SHR BL,1
      {$ENDIF}
      LES DI,Q
      MOV AH,ES:[DI].Window.Palette.kSel
      CMP kType,ktElvis
      JAE @1
      MOV AH,ES:[DI].Window.Palette.Border
   @1:AND AH,0F0h
      ADD AH,Byte Ptr RotateColor[BX]
      MOV _AL,AH
     {$ENDIF}
    END;
{    WaitRetrace;}
    PutBar(_AL);
   End;
   {$IFNDEF NoSpooler}
    If(ExitIfSpoolerIsEmpty)and(IsSpoolerEmpty)Then Begin
     WEGetkHor:=252;
     Exit;
    End;
   {$ENDIF}
   If(BrkOn)Then Begin
    BrkOn:=False;
    ClrKbd;
    PushKey(kbEsc)
   End;
  Until(KeyPress)or(WEBackReadk(Q)=kbClose)or((kStr[1]='$')and(WEBackReadk(Q)=kbInWn));
   __HideMousePtr;
  Key(False);
  PutBar(Q.Palette.kSel);
  K:=WEReadk(Q);
  Case(K)of
   kbInWn:If kStr[1]='$'Then Begin
    WEGetkHor:=252;
    Exit;
   End;
   kbF1:Begin
    WEGetkHor:=253;
    Exit;
   End;
   kbShiftTab:Begin
    WEGetkHor:=251;
    Exit;
   End;
   kbEsc,kbClose:Begin
    WEGetkHor:=255;
    Exit;
   End;
   kbTab,kbLeft,kbRight:If NK>0Then Begin
    PutBar(Q.Palette.Key);
    Case(K)of
     kbLeft:If I>0Then Dec(I)
                  Else I:=NK;
     Else Begin
      If(I<NK)Then Inc(I)Else
      If(K=kbTab)Then Begin
       WEGetkHor:=254;
       Exit;
      End
       Else
      I:=0;
     End;
    End;
    PutBar(Q.Palette.kSel)
   End;
  End
 Until K=kbEnter;
 WEGetkHor:=I
End;

{��������������������������������������������������������������
 �                     Proc�dure WEPutkHorO                   �
 ��������������������������������������������������������������


 Portabilit�:  Global
 Propri�taire: Window


 Description
 �����������

  Cette proc�dure permet d'afficher une liste de bouton centr�e
 horizontalement  en bas  de la fen�tre de bo�te de dialogue de
 l'objet �Window�.
}

Procedure WEPutkHorO{Var Q:Window;Y:Byte;Const k:String};
Var
 ML,NK:Byte;
Begin
 ML:=WESetPosk(k,NK);
 WEPutkHor(Q,(Q.T.X2-Q.T.X1-(NK+1)*ML+2)shr 1,WEAlignEndY(Q,Y),ML,k)
End;

{��������������������������������������������������������������
 �                     Proc�dure WEGetkHorO                   �
 ��������������������������������������������������������������


 Portabilit�:  Global
 Propri�taire: Window


 Description
 �����������

  Cette fonction  permet d'afficher une liste de bouton centr�e
 horizontalement  en bas  de la fen�tre de bo�te de dialogue de
 l'objet �Window�.Ensuite il demande � l'utilisateur de choisir
 un  de  ces  boutons  et  retourne  la position  dans la liste
 correspondant � ce bouton.
}

Function WEGetkHorO{Var Q:Window;Y:Byte;Const k:String):Word};
Var
 ML,Key,NK:Byte;
Begin
 ML:=WESetPosk(k,NK);
 Key:=WEGetkHor(Q,(Q.T.X2-Q.T.X1-(NK+1)*ML+2)shr 1,WEAlignEndY(Q,Y),ML,k);
 Case(Key)of
  251: WEGetkHorO:=kbShiftTab;
  252: WEGetkHorO:=kbInWn;
  253: WEGetkHorO:=kbF1;
  254: WEGetkHorO:=kbTab;
  255: WEGetkHorO:=kbAbort;
  Else WEGetkHorO:=Key;
 End
End;

{������������������������������������������������������������������������
 �                            Proc�dure WEPutkHor                       �
 ������������������������������������������������������������������������


 Portabilit�:  Global
 Propri�taire: Window


 Description
 �����������

  Cette proc�dure affiche une liste de bouton � la position logique texte
 courante dans la fen�tre de la bo�te de dialogue de l'objet �Wins�.
}

Procedure WEPutkHor{Var Q:Window;X,Y,JK:Byte;Const kStr:String};
Var
 XTab:XTabType;
Begin
 _WEPutkHor(Q,X,Y,JK,kStr,XTab)
End;

{����������������������������������������������������������������������
 �                         Proc�dure WEPutkHorDn                      �
 ����������������������������������������������������������������������


 Portabilit�:  Global
 Propri�taire: Window


 Description
 �����������

  Cette proc�dure affiche une liste  de bouton � la position horizontal
 logique texte courante en bas de la fen�tre de la bo�te de dialogue de
 l'objet �Wins�.
}

Procedure WEPutkHorDn{Var Q:Window;Const Key:String};Begin
 WEPutkHorO(Q,wnMax-1,Key)
End;

{����������������������������������������������������������������������
 �                         Proc�dure WEGetkHorDn                      �
 ����������������������������������������������������������������������


 Portabilit�:  Global
 Propri�taire: Window


 Description
 �����������

  Cette proc�dure affiche une liste  de bouton � la position horizontal
 logique texte courante en bas de la fen�tre de la bo�te de dialogue de
 l'objet  �Wins�.  Ensuite  � l'utilisateur  de choisir  un des boutons
 parmi eux et retourne sa position dans la liste.


 Remarque
 ��������

  � Voici le pseudo-code en langage Pascal pure de la fonction:
    �����������������������������������������������������������������Ŀ
    � Function WEGetkHorDn(Var Q:Window;Const k:String):Word;Begin    �
    �  WEGetkHorDn:=WEGetkHorO(Q,wnMax-1,k)                           �
    � End;                                                            �
    �������������������������������������������������������������������
}

Function WEGetkHorDn{Var Q:Window;Const k:String):Word};Assembler;ASM
 {$IFDEF FLAT386}
  MOV ECX,EDX
  MOV EDX,wnMax-1
  CALL WEGetkHorO
 {$ELSE}
  LES DI,Q
  PUSH ES
  PUSH DI
  {$IFOPT G+}
   PUSH wnMax-1
  {$ELSE}
   MOV AL,wnMax-1
   PUSH AX
  {$ENDIF}
  LES DI,k
  PUSH ES
  PUSH DI
  PUSH CS
  CALL Near Ptr WEGetkHorO
 {$ENDIF}
END;

{����Ensemble de gestion des d�placements de fen�tre����}

{������������������������������������������������������������������������
 �                         Proc�dure WEScrollLeft                       �
 ������������������������������������������������������������������������


 Portabilit�:  Global
 Propri�taire: Window


 Description
 �����������

  Cette proc�dure permet d'effectuer une d�placement vers la gauche de la
 zone sp�cifi� de la fen�tre de bo�te de dialogue de l'objet �Wins�.
}

Procedure WEScrollLeft{Var Q:Wins;X1,Y1,X2,Y2,N:Byte};
Var
 xX1:Byte;
Begin
 WEAlignEnd(Q,X2,Y2);
 xX1:=WEGetRX1(Q)+X1;
 MoveText(xX1+N,WEGetRY1(Q)+Y1,WEGetRX1(Q)+X2,WEGetRY1(Q)+Y2,xX1,WEGetRY1(Q)+Y1)
End;

{������������������������������������������������������������������������
 �                         Proc�dure WEScrollRight                      �
 ������������������������������������������������������������������������


 Portabilit�:  Global
 Propri�taire: Window


 Description
 �����������

  Cette proc�dure permet d'effectuer une d�placement vers la droite de la
 zone sp�cifi� de la fen�tre de bo�te de dialogue de l'objet �Wins�.
}

Procedure WEScrollRight{Var Q:Wins;X1,Y1,X2,Y2,N:Byte};
Var
 yY1:Byte;
Begin
 WEAlignEnd(Q,X2,Y2);
 yY1:=WEGetRY1(Q)+Y1;
 MoveText(WEGetRX1(Q)+X1,yY1,WEGetRX1(Q)+X2-N,
          WEGetRY1(Q)+Y2,WEGetRX1(Q)+X1+N,yY1)
End;

{��������������������������������������������������������������������������
 �                             Fonction WEInWindow                        �
 ��������������������������������������������������������������������������


 Portabilit�:  Global
 Propri�taire: Window


 Description
 �����������

  Cette fonction indique si le pointeur texte physique est � l'int�rieur de
 la fen�tre de bo�te de dialogue de l'objet �Window�.


 Remarque
 ��������

  � Voici le source de la fonction en langage Pascal pure:
    ���������������������������������������������������������������������Ŀ
    � Function WEInWindow(Var Q:Window;X,Y:Byte):Boolean;Begin            �
    �  WEInWn:=(X>=RX1)and(X<=RX1+Q.MaxX)and(Y>=RY1)and(Y<=RY1+Q.MaxY)    �
    � End;                                                                �
    �����������������������������������������������������������������������
}

Function WEInWindow(Var Q:Window;X,Y:Byte):Boolean;Assembler;ASM
 {$IFDEF FLAT386}
  LEA EDX,DWord Ptr Q
  CALL AsmWEGetR
  MOV CL,X
  MOV CH,Y
  MOV BX,Word Ptr [EDX].Window.MaxX
  XOR DX,DX
  CMP CL,AL
  JNAE @Extern
  ADD AL,BL
  CMP CL,AL
  JNBE @Extern
  CMP CH,AH
  JNAE @Extern
  ADD AH,BH
  CMP CH,AH
  JNBE @Extern
  MOV DL,1
@Extern:
  XCHG AX,DX
 {$ELSE}
  LES DI,Q
  CALL AsmWEGetR
  XOR DX,DX
  MOV CL,X
  MOV CH,Y
  MOV BX,Word Ptr ES:[DI].Window.MaxX
  CMP CL,AL
  JNAE @Extern
  ADD AL,BL
  CMP CL,AL
  JNBE @Extern
  CMP CH,AH
  JNAE @Extern
  ADD AH,BH
  CMP CH,AH
  JNBE @Extern
  MOV DL,1
@Extern:
  XCHG AX,DX
 {$ENDIF}
END;

Function WEOnWindow{Var Q:Window;X,Y:Byte):Boolean};Assembler;ASM
 {$IFNDEF FLAT386}
  LES DI,Q
  MOV AX,Word Ptr ES:[DI].Window.T.X1
  XOR DX,DX
  MOV CL,X
  MOV CH,Y
  MOV BX,Word Ptr ES:[DI].Window.T.X2
  CMP CL,AL
  JNAE @Extern
  ADD AL,BL
  CMP CL,AL
  JNBE @Extern
  CMP CH,AH
  JNAE @Extern
  ADD AH,BH
  CMP CH,AH
  JNBE @Extern
  MOV DL,1
@Extern:
  XCHG AX,DX
 {$ENDIF}
END;

{��������������������������������������������������������������������������
 �                           Fonction WEInCloseIcon                       �
 ��������������������������������������������������������������������������


 Portabilit�:  Global
 Propri�taire: Window


 Description
 �����������

  Cette fonction indique si le pointeur texte physique est � l'int�rieur de
 l'ic�ne de fermeture de la fen�tre de bo�te de dialogue de l'objet�Window�.
}

Function WEInCloseIcon{Var Q:Window};Assembler;ASM
 {$IFDEF FLAT386}
  LEA EDX,DWord Ptr Q
  XOR AX,AX
  CMP [EDX].Window.CloseIcon,AL
  JE  @Extern
  MOV BX,Word Ptr [EDX].Window.T.X1
  MOV CL,X
  MOV CH,Y
  CMP CH,BH
  JNE @Extern
  CMP CL,BL
  JNAE @Extern
  ADD BL,CloseIconLen
  CMP CL,BL
  JNB @Extern
  MOV AL,1
@Extern:
 {$ELSE}
  LES DI,Q
  XOR AX,AX
  CMP ES:[DI].Window.CloseIcon,AL
  JE  @Extern
  MOV BX,Word Ptr ES:[DI].Window.T.X1
  MOV CL,X
  MOV CH,Y
  CMP CH,BH
  JNE @Extern
  CMP CL,BL
  JNAE @Extern
  ADD BL,CloseIconLen
  CMP CL,BL
  JNB @Extern
  MOV AL,1
@Extern:
 {$ENDIF}
END;

{��������������������������������������������������������������������������
 �                           Fonction WEInZoomIcon                        �
 ��������������������������������������������������������������������������


 Portabilit�:  Global
 Propri�taire: Window


 Description
 �����������

  Cette fonction indique si le pointeur texte physique est � l'int�rieur de
 l'ic�ne d'agrandissement  de la fen�tre  de bo�te  de dialogue  de l'objet
 �Window�.
}

Function WEInZoomIcon{Var Q:Window;X,Y:Byte):Boolean};Assembler;ASM
 {$IFDEF FLAT386}
  LEA EDX,DWord Ptr Q
  XOR AX,AX
  CMP [EDX].Window.ZoomIcon,AL
  JE  @Extern
  MOV BX,Word Ptr [EDX].Window.T.Y1
  MOV CL,X
  MOV CH,Y
  CMP CH,BL
  JNE @Extern
  CMP CL,BH
  JNBE @Extern
  SUB BH,CloseIconLen
  CMP CL,BH
  JNA @Extern
  MOV AL,1
@Extern:
 {$ELSE}
  LES DI,Q
  XOR AX,AX
  CMP ES:[DI].Window.ZoomIcon,AL
  JE  @Extern
  MOV BX,Word Ptr ES:[DI].Window.T.Y1
  MOV CL,X
  MOV CH,Y
  CMP CH,BL
  JNE @Extern
  CMP CL,BH
  JNBE @Extern
  SUB BH,CloseIconLen
  CMP CL,BH
  JNA @Extern
  MOV AL,1
@Extern:
 {$ENDIF}
END;

{������������������������������������������������������������������������
 �                         Proc�dure WESetTitle                         �
 ������������������������������������������������������������������������


 Portabilit�:  Global
 Propri�taire: Window


 Description
 �����������

  Cette proc�dure permet de r�afficher le titre de la fen�tre de bo�te de
 dialogue de l'objet �Window�.
}

Procedure WESetTitle{Var Q:Window;Title:String;Color:Byte};
Label PutTxt,OldBar;
Var
 Len,LenZ,_X:Byte;
 G:GraphBoxRec;
 J:Word;
 LenTitle:Byte Absolute Title;
 Border:Boolean;
Begin
 If(Q.NotFullScrnY)Then Begin
  If(Q.CloseIcon)Then Len:=CloseIconLen
                 Else Len:=0;
  If(Q.ZoomIcon)Then Begin
   LenZ:=ZoomIconLen;
   If(IsGrf)Then ASM SHL LenZ,1;END;
  End
   Else
  LenZ:=0;
  Q.Title:=Title;
  Border:=FontTitle.Output<>$FF;
  If(IsGrf)and(Border)Then Begin
   CoordTxt2Graph(Q.T.X1,G);
   G.X2:=(Q.T.X2-Q.T.X1+1)shl 3;
   {$IFNDEF GraphicOS}
    If(HoleMode)Then Begin
     RIPutImageJuxtap(FontInActifTitle,G.X1,G.Y1,G.X2,HeightChr,[wpJuxtap]);
    End
     Else
   {$ENDIF}
   Begin
    If Not RIIsImage(FontTitle)Then Goto OldBar;
    RIPutImageJuxtap(FontTitle,G.X1,G.Y1,G.X2,HeightChr,[wpJuxtap]);
   End;
  End
   Else
  Begin
  {If BitsPerPixel>=15Then BarSpcHorDegrad(Q.X1,Q.Y1,Q.X2,Color)
    Else}
   ASM
 OldBar:
     {BarSpcHor(Q.X1,Q.Y1,Q.X2,Color);}
    {$IFDEF FLAT386}
     LEA EDX,Q
     MOV AX,Word Ptr [EDX].Window.T.X1
     MOV CX,Word Ptr [EDX].Window.T.X2
     MOV DL,AH
     PUSH DWord Ptr Color
     {$IFDEF GraphicOS}
      CALL BarSpcHor
     {$ELSE}
      CALL BarSpcHorHole
     {$ENDIF}
    {$ELSE}
     LES DI,Q
     LES AX,DWord Ptr ES:[DI].Window.T.X1
     PUSH AX
     MOV AL,AH
     PUSH AX
     PUSH ES
     PUSH Word Ptr Color
     CALL BarSpcHorHole
    {$ENDIF}
   END;
   If(StyleBarTitle=sttMacintosh)Then Begin
    CoordTxt2Graph(Q.T.X1,G);
    For J:=1to(HeightChr-4)shr 1do Begin
     Inc(G.Y1,2);
     ClrLnHor(G.X1+4,G.Y1,(Q.T.X2-Q.T.X1)shl 3,Black);
    End;
    If Q.Title[1]<>' 'Then Q.Title:=' '+Q.Title+' ';
   End
  End;
   { D�finit la position du titre }
  _X:=GetCenterBox(Q.T.X1+(Byte(Q.CloseIcon)shl 1),
                   Q.T.X2-(Byte(Q.ZoomIcon)shl 2),TitleCenter,Title);
  If(StyleBarTitle=sttMacintosh)Then Goto PutTxt;
  If(IsGraf)Then Begin
   {$IFNDEF GraphicOS}If Not(HoleMode)Then {$ENDIF}ASM
     {BarSpcHorRelief(Q.X1+Len,Q.Y1,Q.X2-LenZ,Color);}
    {$IFDEF FLAT386}
     LEA EDX,Q
     MOV AX,Word Ptr [EDX].Window.T.X1
     ADD AL,Len
     MOV CL,[EDX].Window.T.X2
     SUB CL,LenZ
     MOV DL,AH
     PUSH DWord Ptr Color
     CALL BarSpcHorRelief
    {$ELSE}
     LES DI,Q
     LES AX,DWord Ptr ES:[DI].Window.T.X1
     ADD AL,Len
     PUSH AX
     MOV AL,AH
     PUSH AX
     MOV AX,ES
     SUB AL,LenZ
     PUSH AX
     PUSH Word Ptr Color
     CALL BarSpcHorRelief
    {$ENDIF}
   END;
   If Not(InBarHole(Q.T.X1,Q.T.Y1,Q.T.X2-Q.T.X1+1))Then
    BarSpcHorRelief(Q.T.X1,Q.T.Y1,Q.T.X2,Color);
    If(BitsPerPixel>=8){$IFNDEF GraphicOS}and Not(HoleMode){$ENDIF}Then
     PutTxtFade(_X,Q.T.Y1,Q.Title,Color,Border)
    {$IFNDEF GraphicOS}
     Else
      PutTxtXYTHole(_X,Q.T.Y1,Q.Title,Color and$F);
    {$ENDIF}
  End
   Else
PutTxt:
  {$IFDEF GraphicOS}
   PutTxtXY(_X,Q.T.Y1,Left(Q.Title,Q.T.X2-Q.T.X1+1),Color);
  {$ELSE}
   PutTxtXYHole(_X,Q.T.Y1,Left(Q.Title,Q.T.X2-Q.T.X1+1),Color);
  {$ENDIF}
  If(Q.CloseIcon)Then WECloseIcon(Q);
  If(Q.ZoomIcon)Then WEZoomIcon(Q)
 End;
End;

{�����������������������������������������������������������������������
 �                       Proc�dure WESetEndBarTxtX                     �
 �����������������������������������������������������������������������


 Portabilit�:  Global
 Propri�taire: Window


 Description
 �����������

  Cette proc�dure permet d'afficher un message sur la barre du bas de la
 fen�tre de bo�te de dialogue de l'objet �Window�.
}

Procedure WESetEndBarTxtX{Var Q:Wins;X:Byte;Str:String;Attr:Byte};Begin
 Inc(X,Q.T.X1);
 If(X>Q.T.X2){$IFNDEF GraphicOS}or(HoleMode){$ENDIF}Then Exit;
 If(X+Length(Str)>Q.T.X2)Then Str[0]:=Char(Q.T.X2-X+1);
 PutSmlTxtXY(X,Q.T.Y2,Str,Attr)
End;

{�����������������������������������������������������������������������
 �                       Proc�dure WEPutSmlTxtXY                       �
 �����������������������������������������������������������������������


 Portabilit�:  Global
 Propri�taire: Window


 Description
 �����������

  Cette proc�dure permet d'afficher un message de taille r�duite dans la
 de la fen�tre  de bo�te  de dialogue de l'objet �Window� � une position
 logique texte.
}

Procedure WEPutSmlTxtXY{Var Q:Wins;X,Y:Byte;Const Msg:String};Begin
 If(X+Length(Msg)>Q.MaxX)Then Msg[0]:=Char(Q.MaxX-X+1);
 {$IFDEF FLAT386}
  If InBarHole(WEGetRX1(Q)+X,WEGetRY1(Q)+Y,Length(Msg))Then Exit;
  PutSmlTxtXY(WEGetRX1(Q)+X,WEGetRY1(Q)+Y,Msg,Q.CurrColor);
 {$ELSE}
  ASM
   LES DI,Q
   MOV AL,X
   MOV AH,Y
   CALL AsmWEAlignEnd
   XCHG AX,CX
   CALL AsmWEGetR
   ADD AX,CX
    {If InBarHole(WEGetRX1(Q)+X,WEGetRY1(Q)+Y,Length(Msg))Then Exit;}
   PUSH AX
    PUSH AX
    MOV AL,AH
    PUSH AX
    PUSH Word Ptr Msg
    CALL InBarHole
   POP BX
   OR  AL,AL
   JNZ @End
    {PutSmlTxtXY(WEGetRX1(Q)+X,WEGetRY1(Q)+Y,Msg,Q.CurrColor);}
   PUSH BX
   MOV BL,BH
   PUSH BX
   PUSH SS
   MOV SI,Offset Msg
   ADD SI,BP
   PUSH SI
   LES DI,Q
   PUSH Word Ptr ES:[DI].Window.CurrColor
   CALL PutSmlTxtXY
@End:
 END;
 {$ENDIF}
End;

{��������������������������������������������������������������������������
 �                             Fonction WEInp                             �
 ��������������������������������������������������������������������������


 Portabilit�:  Global
 Propri�taire: Window


 Description
 �����������

  Cette fonction permet d'effectuer une contr�le de saisie utilisateur dans
 une fen�tre  de bo�te de dialogue  de l'objet �Window� � la position texte
 logique courante.


 Remarque
 ��������

  � Voici le source de la fonction en langage Pascal pure:
    ���������������������������������������������������������������������Ŀ
    � Function WEInp;Begin                                                �
    �  SetKr(Q.XColrs.Sel);                                               �
    �  WEInp:=Input(WEGetRealX(Q),WEGetRealY(Q),                          �
    �               WEGetRX1(Q)+Q.MaxX,MaxLen,PassWord,Str)               �
    � End;                                                                �
    �����������������������������������������������������������������������
}

Function WEInp{Var Q:Window;Var Str:PChr;MaxLen:Word;PassWord:Boolean):Word};
Label ReStart;
Var
 K:Word;
Begin
ReStart:
 {$IFDEF FLAT386}
  SetKr(Q.Palette.Sel);
  K:=Input(WEGetRealX(Q),WEGetRealY(Q),WEGetRX1(Q)+Q.MaxX,MaxLen,PassWord,Str);
 {$ELSE}
  ASM
    {SetKr(Q.XColrs.Sel);}
   LES DI,Q
   PUSH Word Ptr ES:[DI].Window.Palette.Sel
   CALL SetKr
    {WEInp:=Input(WEGetRealX(Q),WEGetRealY(Q),WEGetRX1(Q)+Q.MaxX,MaxLen,PassWord,Str)}
   CALL AsmWEGetReal
   PUSH AX
   MOV AL,AH
   PUSH AX
   CALL AsmWEGetR
   ADD AL,ES:[DI].Window.MaxX
   PUSH AX
   PUSH MaxLen
   PUSH Word Ptr PassWord
   LES DI,Str
   PUSH ES
   PUSH DI
   CALL Input
   MOV K,AX
  END;
 {$ENDIF}
 Case(K)of
  kbMouse:If(LastMouseY=LnsMnu)Then K:=kbPrgMnuBar Else
          If LastMouseY=0Then Begin
           If(LastMouseX>=CloseIconLen)Then K:=kbPrgTitle
                                    Else K:=kbPrgClsIcon;
          End
           Else
          If WEInCloseIcon(Q,LastMouseX,LastMouseY)Then Begin
           K:=kbCloseWin;
           WaitMouseBut0;
          End
           Else
          If(Q.ZoomIcon)and(LastMouseX<=Q.T.X2-2)and(LastMouseX>=Q.T.X2-3)Then Begin
           K:=kbTaskBar;
          End
           Else
          If WEInZoomIcon(Q,LastMouseX,LastMouseY)Then Begin
           K:=kbZoom;
           WaitMouseBut0;
          End
           Else
	  If WEInWindow(Q,LastMouseX,LastMouseY)Then K:=kbInWn Else
          If WEInTitle(Q,LastMouseX,LastMouseY)Then Begin
           If Q.SizeBuffer<>0Then Begin
            WEMoveWn(Q);
            Goto Restart;
           End
            Else
           K:=kbTitle;
          End
           Else
          K:=kbMouse;
 End;
 WEInp:=K;
End;

{�������������������������������������������������������������������������
 �                            Proc�dure WESetY                           �
 �������������������������������������������������������������������������


 Portabilit�:  Global
 Propri�taire: Window


 Description
 �����������

  Cette proc�dure permet de modifier la position vertical courante dans la
 fen�tre de bo�te de dialogue de l'objet �Window�.
}

Procedure WESetY{Var Q:Window;Y:Byte};Begin
 If(Y>Q.MaxY)Then Q.Y:=Q.MaxY
             Else Q.Y:=Y;
End;

{�������������������������������������������������������������������������
 �                            Proc�dure WESetPos                         �
 �������������������������������������������������������������������������


 Portabilit�:  Global
 Propri�taire: Window


 Description
 �����������

  Cette proc�dure permet de d�finir la position  du pointeur texte logique
 horizontal et vertical dans la fen�tre de la bo�te de dialogue de l'objet
 �Window�.
}

Procedure WESetPos;Assembler;ASM
 {$IFDEF FLAT386}
  MOV DL,X
  MOV DH,Y
  MOV Word Ptr [EAX].Window.X,DX
 {$ELSE}
  LES DI,Q
  MOV AL,X
  MOV AH,Y
  MOV Word Ptr ES:[DI].Window.X,AX
 {$ENDIF}
END;

{�������������������������������������������������������������������������
 �                           Proc�dure WESetPosHome                      �
 �������������������������������������������������������������������������


 Portabilit�:  Global
 Propri�taire: Window


 Description
 �����������

  Cette proc�dure permet de d�finir la position  du pointeur texte logique
 horizontal et vertical dans la fen�tre de la bo�te de dialogue de l'objet
 �Window�.
}

Procedure WESetPosHome;Assembler;ASM
 {$IFDEF FLAT386}
  MOV Word Ptr [EAX].Window.X,0
 {$ELSE}
   { Q.X:=Q.Y:=0;}
  LES DI,Q
  MOV Word Ptr ES:[DI].Window.X,0
 {$ENDIF}
END;

{��������������������������������������������������������������������������
 �                            Proc�dure WEClrScr                          �
 ��������������������������������������������������������������������������


 Portabilit�:  Global
 Propri�taire: Window


 Description
 �����������

  Cette proc�dure permet d'effacer  toutes les informations situ�es dans la
 fen�tre de bo�te de dialogue de l'objet�Window�et r�initialise la position
 du pointeur texte logique dans la coin sup�rieur gauche de la fen�tre avec
 une couleur de remplissage courant.
}

Procedure WEClrScr;Assembler;ASM
  { WEClrWn(Q,0,0,wnMax,wnMax,Q.CurrColor); }
 {$IFDEF FLAT386}
  XOR  EDX,EDX
  MOV  CX,DX
  PUSH wnMax
  PUSH wnMax
  PUSH DWord Ptr [EAX].Window.CurrColor
  CALL WEClrWn
 {$ELSE}
  LES  DI,Q
  PUSH ES
  PUSH DI
  XOR  AX,AX
  PUSH AX
  PUSH AX
  DEC  AX
  PUSH AX
  PUSH AX
  PUSH Word Ptr ES:[DI].Window.CurrColor
  PUSH CS
  CALL Near Ptr WEClrWn
 {$ENDIF}
 {$IFDEF Real}
  JMP Near Ptr WESetPosHome[3]
 {$ELSE}
   { Q.X:=Q.Y:=0;}
  {$IFDEF FLAT386}
   LEA EAX,DWord Ptr Q
   MOV Word Ptr [EAX].Window.X,0
  {$ELSE}
   LES DI,Q
   MOV Word Ptr ES:[DI].Window.X,0
  {$ENDIF}
 {$ENDIF}
END;

{������������������������������������������������������������������������
 �                           Proc�dure WEClrEol                         �
 ������������������������������������������������������������������������


 Portabilit�:  Global
 Propri�taire: Window


 Description
 �����������

  Cette proc�dure permet d'effacer le reste de la ligne o� se trouvent le
 pointeur texte logique  jusqu'au rebord  droit de la fen�tre de la bo�te
 de dialogue de l'objet �Window�.


 Remarque
 ��������

  � Voici le source de la proc�dure en langage Pascal pure:
    �������������������������������������������������������������������Ŀ
    � Procedure WEClrEol;Begin                                          �
    �  If(Q.X<=Q.MaxX)Then WEBarSpcHor(Q,Q.X,Q.Y,wnMax)                 �
    � End;                                                              �
    ���������������������������������������������������������������������
}

Procedure WEClrEol;
{$IFDEF FLAT386}
 Begin
  If(Q.X<=Q.MaxX)Then WEBarSpcHor(Q,Q.X,Q.Y,wnMax)
 End;
{$ELSE}
 Assembler;ASM
  LES DI,Q
  MOV AX,Word Ptr ES:[DI].Window.X
  CMP AL,ES:[DI].Window.MaxX
  JNBE @1
  PUSH ES
  PUSH DI
  PUSH AX
  MOV AL,AH
  PUSH AX
  MOV AL,wnMax
  PUSH AX
  CALL WEBarSpcHor
 @1:
 END;
{$ENDIF}

Procedure WEClrLnHor{Var Q:Window;X,Y:Integer;Len,Color:Word};Begin
 {$IFDEF __Windows__}
  Q.Canvas.MoveTo(X,Y);
  Q.Canvas.LineTo(X+Len-1,Y);
 {$ELSE}
  Inc(X,WEGetRX1(Q)shl 3);
  Inc(Y,GetRawY(WEGetRY1(Q)));
  ClrLnHor(X,Y,Len,Color);
 {$ENDIF}
End;

Procedure WEPutLnHor{Var Q:Window;X1,Y,X2,Color:Word};Begin
 If(X2 shr 3>=Q.T.X2)Then X2:=Pred(Succ(Q.MaxX)shl 3);
 WEClrLnHor(Q,X1,Y,X2-X1+1,Color);
End;

Procedure WEPutFillBox{Var Q:Window;X1,Y1,X2,Y2,Color:Word};
{$IFNDEF __Windows__}
 Var
  X,Y:Word;
{$ENDIF}
Begin
 {$IFDEF __Windows__}
 {$ELSE}
  X:=WEGetRX1(Q)shl 3;
  Y:=GetRawY(WEGetRY1(Q));
  If(Y1>Y2)Then SwapWord(Y1,Y2);
  PutFillBox(X1+X,Y1+Y,X2+X,Y2+Y,Color);
 {$ENDIF}
End;

Procedure WEPutRect{Var Q:Window;X1,Y1,X2,Y2,Color:Word};
{$IFNDEF __Windows__}
 Var
  X,Y:Word;
{$ENDIF}
Begin
 {$IFDEF __Windows__}
  Q.Canvas.Rectangle(X1,Y1,X2,Y2);
 {$ELSE}
  X:=WEGetRX1(Q)shl 3;
  Y:=GetRawY(WEGetRY1(Q));
  If(Y1>Y2)Then SwapWord(Y1,Y2);
  PutRect(X1+X,Y1+Y,X2+X,Y2+Y,Color);
 {$ENDIF}
End;

Procedure WEPutLine{Var Q:Window;X1,Y1,X2,Y2,Color:Word};
{$IFNDEF __Windows__}
 Var
  X,Y:Word;
{$ENDIF}
Begin
 {$IFDEF __Windows__}
  Q.Canvas.MoveTo(X1,Y1);
  Q.Canvas.LineTo(X2,Y2);
 {$ELSE}
  X:=WEGetRX1(Q)shl 3;
  Y:=GetRawY(WEGetRY1(Q));
  PutLine(X1+X,Y1+Y,X2+X,Y2+Y,Color);
 {$ENDIF}
End;

{������������������������������������������������������������������������
 �                             Proc�dure WELn                           �
 ������������������������������������������������������������������������


 Portabilit�:  Global
 Propri�taire: Window


 Description
 �����������

  Cette proc�dure permet de passer � la ligne suivante de la fen�tre sans
 effectuant  de  d�filement  si le  pointeur texte  logique se situe � la
 derni�re ligne la fen�tre de la bo�te de dialogue de l'objet �Window�.
}

Procedure WELn;Assembler;ASM
 {$IFDEF FLAT386}
  MOV [EAX].Window.X,0
  INC [EAX].Window.Y
 {$ELSE}
  LES DI,Q
  MOV ES:[DI].Window.X,0
  INC ES:[DI].Window.Y
 {$ENDIF}
END;

{��������������������������������������������������������������������
 �                         Proc�dure _WERight                       �
 ��������������������������������������������������������������������


 Portabilit�:  Global
 Propri�taire: Window


 Description
 �����������

  Cette proc�dure permet de d�placer vers la droite la pointeur texte
 logique de la fen�tre de bo�te de dialogue de l'objet �Window�.Si le
 pointeur se situe � la limite de droite de la fen�tre, il passe � la
 ligne suivante et retourne au d�but de cette nouvelle ligne.
}

Procedure _WERight;Begin
 If(Q.X<Q.MaxX)Then Inc(Q.X)
  Else
 Begin
  Q.X:=0;
  _WEDn(Q)
 End;
End;

{��������������������������������������������������������������������
 �                        Proc�dure WEBackground                    �
 ��������������������������������������������������������������������


 Portabilit�:  Global
 Propri�taire: Window


 Description
 �����������

  Cette proc�dure permet  de modifier  la couleur  courante de fond de
 l'�criture de message dans la fen�tre de bo�te de dialogue de l'objet
 �Window�.
}

Procedure WEBackground;Assembler;ASM
 {$IFDEF FLAT386}
  AND [EAX].Window.CurrColor,0Fh
  SHL DL,4
  ADD [EAX].Window.CurrColor,DL
 {$ELSE}
  LES DI,Q
  AND ES:[DI].Window.CurrColor,0Fh
  MOV AL,Attr
  {$IFOPT G+}
   SHL AL,4
  {$ELSE}
   MOV CL,4
   SHL AL,CL
  {$ENDIF}
  ADD ES:[DI].Window.CurrColor,AL
 {$ENDIF}
END;

{�����������������������������������������������������������������������
 �                            Proc�dure _WELn                          �
 �����������������������������������������������������������������������


 Portabilit�:  Global
 Propri�taire: Window


 Description
 �����������

  Cette proc�dure permet de passer � la  ligne suivante de la fen�tre et
 peut effectuer un d�filement  vers le haut si le pointeur texte logique
 se situe �  la derni�re ligne de la fen�tre de la bo�te  de dialogue de
 l'objet �Window�.
}

Procedure _WELn;Begin
 WELn(Q);
 If WEYIsOut(Q)Then Begin
  _WELL(Q);
  _WEScrollDn(Q);
  WEClrEol(Q)
 End;
End;

{�����������������������������������������������������������������������
 �                          Proc�dure WECloseIcon                      �
 �����������������������������������������������������������������������


 Portabilit�:  Global
 Propri�taire: Window


 Description
 �����������

  Cette proc�dure permet d'ajouter un ic�ne de fermeture � la fen�tre de
 bo�te de dialogue de l'objet �Window�.
}

Procedure WECloseIcon;
Var
 Len,LenZ:Byte;
Begin
 {$IFNDEF GraphicOS}If(Q.NotFullScrnY)and Not(HoleMode)Then {$ENDIF}Begin
  PutCloseIcon(Q.T.X1,Q.T.Y1,Q.Palette.Icon);
  If Not(Q.CloseIcon)Then Begin
   Len:=CloseIconLen;
   If(Q.ZoomIcon)Then LenZ:=ZoomIconLen
                 Else LenZ:=0;
   Q.CloseIcon:=True;
   If(IsGraf)Then Begin
    If(TitleCenter=__Left__)Then
     _WESetTitle(Q,Q.Title)
    Else
     BarSpcHorRelief(Q.T.X1+Len,Q.T.Y1,Q.T.X2-LenZ,Q.Palette.Title);
   End;
  End;
 End
End;

{������������������������������������������������������������������������
 �                          Proc�dure WEZoomIcon                        �
 ������������������������������������������������������������������������


 Portabilit�:  Global
 Propri�taire: Window


 Description
 �����������

  Cette proc�dure permet d'ajouter un ic�ne d'agrandissement � la fen�tre
 de bo�te de dialogue de l'objet �Window�.
}

Procedure WEZoomIcon;
Var
 Len,LenZ:Byte;
Begin
 {$IFNDEF GraphicOS}If(Q.NotFullScrnY)and Not(HoleMode)Then {$ENDIF}Begin
  ZoomIcon(Q.T.X2-ZoomIconLen+1,Q.T.Y1,Q.Palette.Icon);
  PutTaskBarIcon(Q.T.X2-3,Q.T.Y1,$F);
  If Not(Q.ZoomIcon)Then Begin
   Q.ZoomIcon:=True;
   If(Q.CloseIcon)Then Len:=CloseIconLen
                  Else Len:=0;
   LenZ:=ZoomIconLen;
   If(IsGraf)Then Begin
    If(TitleCenter=__Right__)Then
     _WESetTitle(Q,Q.Title)
    Else
     BarSpcHorRelief(Q.T.X1+Len,Q.T.Y1,Q.T.X2-(LenZ shl 1),Q.Palette.Title)
   End;
  End;
 End;
End;

{���������������������������������������������������������������������
 �                         Proc�dure WEPutMsg                        �
 ���������������������������������������������������������������������


 Portabilit�:  Global
 Propri�taire: Window


 Description
 �����������

  Cette proc�dure permet d'afficher un message devant rentrer dans une
 marge particuli�re de la fen�tre bo�te de dialogue de l'objet�Window�
 � la position courante texte logique.


 Remarque
 ��������

  � Voici maintenant le source en Pascal pure de cette proc�dure:
    ����������������������������������������������������������������Ŀ
    � Procedure WEPutMsg;Begin                                       �
    �  PutMsg(WEGetRealX(Q),WEGetRealY(Q),Q.X1+Q.MaxX,Msg,Q.Kr);     �
    �  Inc(Q.Y,Video.GetNmLnMsg(WEGetRealX(Q),                       �
    �                           Q.X1+Q.MaxX,Msg)+                    �
    �                           Byte(Q.NotFullScrnY))                �
    � End;                                                           �
    ������������������������������������������������������������������
}

Procedure WEPutMsg;Begin
 {$IFDEF FLAT386}
  PutMsg(WEGetRealX(Q),WEGetRealY(Q),Q.T.X1+Q.MaxX,Msg,Q.CurrColor);
 {$ELSE}
  ASM
    {PutMsg(WEGetRealX(Q),WEGetRealY(Q),Q.X1+Q.MaxX,Msg,Q.CurrColor);}
   LES DI,Q
   CALL AsmWEGetReal
   PUSH AX
   MOV AL,AH
   PUSH AX
   MOV AL,ES:[DI].Window.T.X1
   ADD AL,ES:[DI].Window.MaxX
   PUSH AX
   PUSH Word Ptr Msg[2]
   PUSH Word Ptr Msg
   PUSH Word Ptr ES:[DI].Window.CurrColor
   CALL PutMsg
  END;
 {$ENDIF}
 Inc(Q.Y,Video.GetNmLnMsg(WEGetRealX(Q),Q.T.X1+Q.MaxX,Msg)+
                          Byte(Q.NotFullScrnY))
End;

{��������������������������������������������������������������������������
 �                         Proc�dure WEClrScrBorder                       �
 ��������������������������������������������������������������������������


 Portabilit�:  Global
 Propri�taire: Window


 Description
 �����������

  Cette proc�dure permet d'effacer  toutes les informations situ�es dans la
 fen�tre de bo�te de dialogue de l'objet�Window�et r�initialise la position
 du pointeur texte logique dans la coin sup�rieur gauche de la fen�tre avec
 une couleur de remplissage de la bordure.
}

Procedure WEClrWnBorder;Begin
 WEClrWn(Q,X1,Y1,X2,Y2,Q.Palette.Border)
End;

{�����������������������������������������������������������������������
 �                            Proc�dure WEDn                           �
 �����������������������������������������������������������������������


 Portabilit�:  Global
 Propri�taire: Window


 Description
 �����������

  Cette proc�dure permet de faire descendre vers le bas de la fen�tre le
 pointeur texte logique  de la fen�tre  de bo�te  de dialogue de l'objet
 �Window�.
}

Procedure WEDn;
Var
 I:Byte;
Begin
 For I:=1to(N)do _WEDn(Q)
End;

{��������������������������������������������������������������������
 �                        Proc�dure WEForeground                    �
 ��������������������������������������������������������������������


 Portabilit�:  Global
 Propri�taire: Window


 Description
 �����������

  Cette proc�dure permet de changer la couleur d'�criture de prochain
 message � afficher  dans la fen�tre  de bo�te de dialogue de l'objet
 �Window�.
}

Procedure WEForeground;Assembler;ASM
 {$IFDEF FLAT386}
  MOV CL,[EAX].Window.CurrColor
  AND CL,0F8h
  ADD CL,DL
  MOV [EAX].Window.CurrColor,CL
 {$ELSE}
  LES DI,Q
  MOV AL,ES:[DI].Window.CurrColor
  AND AL,0F8h
  ADD AL,Attr
  MOV ES:[DI].Window.CurrColor,AL
 {$ENDIF}
END;

{������������������������������������������������������������������������
 �                            Fonction WEGetRealY                       �
 ������������������������������������������������������������������������


 Portabilit�:  Global
 Propri�taire: Window


 Description
 �����������

  Cette fonction retourne la position texte physique vertical du pointeur
 de la fen�tre de la bo�te de dialogue de l'objet �Window�.


 Remarque
 ��������

  � Voici le source en langage Pascal pure de cette fonction:
    �������������������������������������������������������������������Ŀ
    � Function WEGetRealY;Begin                                         �
    �  WEGetRealY:=WEGetRY1(Q)+Q.Y;                                     �
    � End;                                                              �
    ���������������������������������������������������������������������
}

Function WEGetRealY;Assembler;ASM
 {$IFDEF FLAT386}
  XCHG EAX,EDX
  CALL asmWEGetReal
  MOV AL,aH
 {$ELSE}
  LES DI,Q
  CALL AsmWEGetReal
  MOV AL,AH
 {$ENDIF}
END;

{�����������������������������������������������������������������
 �                       Fonction WEGetRealX                     �
 �����������������������������������������������������������������


 Portabilit�:  Global
 Propri�taire: Window


 Description
 �����������

  Cette fonction retourne la position texte physique horizontal du
 pointeur de la fen�tre de la bo�te de dialogue de l'objet�Window�.


 Remarque
 ��������

  � Voici le source en langage Pascal pure de cette fonction:
    ������������������������������������������������������������Ŀ
    � Function WEGetRealX;Begin                                  �
    �  WEGetRealX:=WEGetRX1(Q)+Q.X;                              �
    � End;                                                       �
    ��������������������������������������������������������������
}

Function WEGetRealX;Assembler;ASM
 {$IFDEF FLAT386}
  XCHG EAX,EDX
  CALL asmWEGetReal
 {$ELSE}
  LES DI,Q
  CALL asmWEGetReal
 {$ENDIF}
END;

{�����������������������������������������������������������������������
 �                             Proc�dure WELeft                        �
 �����������������������������������������������������������������������


 Portabilit�:  Global
 Propri�taire: Window


 Description
 �����������

  Cette proc�dure permet de d�place le pointeur texte logique horizontal
 vers la gauche de la fen�tre de la bo�te de dialogue de l'objet�Window�.
}

Procedure WELeft{Var Q:Window;N:Byte};
Var
 I:Byte;
Begin
 For I:=1to(N)do _WELeft(Q)
End;

{����������������������������������������������������������������������
 �                          Proc�dure WEPutCube                       �
 ����������������������������������������������������������������������


 Portabilit�:  Global
 Propri�taire: Window


 Description
 �����������

  Cette proc�dure permet d'afficher un caract�re � la position courante
 texte de la fen�tre  de bo�te  de dialogue de l'objet �Window� avec la
 couleur de fond et d'�criture courante de la fen�tre.
}

Procedure WEPutCube{Var Q:Window;Chr:Char};Begin
 WESetCube(Q,Q.X,Q.Y,Chr)
End;

{����������������������������������������������������������������������
 �                         Proc�dure WEPutPTxt                        �
 ����������������������������������������������������������������������


 Portabilit�:  Global
 Propri�taire: Window


 Description
 �����������

  Cette proc�dure permet d'afficher  une cha�ne de caract�res de format
 ASCIIZ � la position courante texte de la fen�tre de bo�te de dialogue
 de l'objet�Window�avec la couleur de fond et d'�criture courante de la
 fen�tre.
}

Procedure WEPutPTxt{Var Q:Window;Msg:PChr};Begin
 WEPutPTxtXY(Q,Q.X,Q.Y,Msg)
End;

{����������������������������������������������������������������������
 �                         Proc�dure WEPutPTxtLn                      �
 ����������������������������������������������������������������������


 Portabilit�:  Global
 Propri�taire: Window


 Description
 �����������

  Cette proc�dure permet d'afficher  une cha�ne de caract�res de format
 ASCIIZ � la position courante texte de la fen�tre de bo�te de dialogue
 de l'objet�Window�avec la couleur de fond et d'�criture courante de la
 fen�tre.  Ensuite  il passe  � la  ligne  suivante  de  la  fen�tre en
 attendant l'affiche d'information potentiel.
}

Procedure WEPutPTxtLn{Var Q:Window;Msg:PChr};Begin
 WEPutPTxt(Q,Msg);
 WELn(Q)
End;

{�����������������������������������������������������������������������
 �                          Proc�dure WEPutPTxtXY                      �
 �����������������������������������������������������������������������


 Portabilit�:  Global
 Propri�taire: Window


 Description
 �����������

  Cette proc�dure  permet d'afficher  une cha�ne de caract�res de format
 ASCIIZ � la position texte sp�cifier de la fen�tre de bo�te de dialogue
 de l'objet�Window�avec la couleur de fond  et d'�criture courante de la
 fen�tre.
}

Procedure WEPutPTxtXY{Var Q:Window;X,Y:Byte;Msg:PChr};Begin
 WEPutPTxtXY2(Q,X,Y,0,Msg)
End;

{���������������������������������������������������������������������
 �                        Proc�dure WEPutTxt                         �
 ���������������������������������������������������������������������


 Portabilit�:  Global
 Propri�taire: Window


 Description
 �����������

  Cette proc�dure permet d'afficher une cha�ne de caract�res de format
 Pascal � la position logique texte courante de la fen�tre de la bo�te
 de dialogue de l'objet �Window� avec la couleur courante.
}

Procedure WEPutTxt{Var Q:Window;Msg:String};Begin
 ChgChr(Msg,#0,' ');
 WEPutTxtXY(Q,Q.X,Q.Y,Msg)
End;

{���������������������������������������������������������������������
 �                        Proc�dure WEPutTxtT                        �
 ���������������������������������������������������������������������


 Portabilit�:  Global
 Propri�taire: Window


 Description
 �����������

  Cette proc�dure permet d'afficher une cha�ne de caract�res de format
 Pascal � la position logique texte courante de la fen�tre de la bo�te
 de dialogue de l'objet�Window�avec la couleur courante sans toutefois
 changer la couleur de fond o� est afficher les caract�res.
}

Procedure WEPutTxtT{Var Q:Window;Msg:String};Begin
 ChgChr(Msg,#0,' ');
 WEPutTxtXYT(Q,Q.X,Q.Y,Msg)
End;

{���������������������������������������������������������������������
 �                        Proc�dure WEPutTxtLn                       �
 ���������������������������������������������������������������������


 Portabilit�:  Global
 Propri�taire: Window


 Description
 �����������

  Cette proc�dure permet d'afficher une cha�ne de caract�res de format
 Pascal � la position logique texte courante de la fen�tre de la bo�te
 de dialogue de l'objet �Window�avec la couleur courante.Et passe � la
 ligne suivante de la fen�tre lorsque le message est affich�.
}

Procedure WEPutTxtLn{Var Q:Window;Const Msg:String};Begin
 WEPutTxtXY(Q,Q.X,Q.Y,Msg);
 WELn(Q)
End;

{���������������������������������������������������������������������
 �                        Proc�dure WEPutSmlTxtLn                    �
 ���������������������������������������������������������������������


 Portabilit�:  Global
 Propri�taire: Window


 Description
 �����������

  Cette proc�dure permet d'afficher une cha�ne de caract�res de format
 Pascal � la position logique texte courante de la fen�tre de la bo�te
 de dialogue de l'objet �Window�avec la couleur courante.Et passe � la
 ligne suivante  de  la fen�tre  lorsque  le message est affich�.  Les
 caract�res sont naturellement de format r�duit.
}

Procedure WEPutSmlTxtLn{Var Q:Window;Const Msg:String};Begin
 WEPutSmlTxtXY(Q,Q.X,Q.Y,Msg);
 WELn(Q)
End;

{���������������������������������������������������������������������
 �                        Proc�dure WEPutTxtTLn                      �
 ���������������������������������������������������������������������


 Portabilit�:  Global
 Propri�taire: Window


 Description
 �����������

  Cette proc�dure permet d'afficher une cha�ne de caract�res de format
 Pascal � la position logique texte courante de la fen�tre de la bo�te
 de dialogue de l'objet�Window�avec la couleur courante sans toutefois
 changer la couleur de fond o� est afficher les caract�res. Et passe �
 la ligne suivante de la fen�tre lorsque le message est affich�.
}

Procedure WEPutTxtTLn{Var Q:Window;Const Msg:String};Begin
 WEPutTxtXYT(Q,Q.X,Q.Y,Msg);
 WELn(Q)
End;

{����������������������������������������������������������������������
 �                       Proc�dure WEPutTypingLn                      �
 ����������������������������������������������������������������������


 Portabilit�:  Global
 Propri�taire: Window


 Description
 �����������

  Cette proc�dure permet d'afficher  une cha�ne de caract�res de format
 Pascal en style typ�e � la position logique texte courante de la bo�te
 de dialogue de la fen�tre de l'objet �Window� avec la couleur courante.
 Ensuite passe � la ligne suivante.
}

Procedure WEPutTypingLn{Var Q:Window;Const Msg:String};Begin
 WEPutTyping(Q,Msg);
 WELn(Q)
End;

{����������������������������������������������������������������������
 �                           Proc�dure WERight                        �
 ����������������������������������������������������������������������


 Portabilit�:  Global
 Propri�taire: Window


 Description
 �����������

  Cette proc�dure d�place le pointeur texte logique de la fen�tre de la
 bo�te de dialogue de l'objet �Window� vers la droite.
}

Procedure WERight{Var Q:Window;N:Byte};
Var
 I:Byte;
Begin
 For I:=1to(N)do _WERight(Q)
End;

{���������������������������������������������������������������������
 �                           Fonction WERunItem                      �
 ���������������������������������������������������������������������


 Portabilit�:  Global
 Propri�taire: Window


 Description
 �����������

  Cette proc�dure permet de faire s�lectionn� un item avec un �X� dans
 la bo�te de dialogue situ� � la position logique texte courante de la
 fen�tre de l'objet �Window�.
}

Function WERunItem{Var W:Window;X,Y:Byte;Var P:Byte;Min,Nm:Byte;Var TB:Array of Boolean):Word};
Label WnXt;
Var
 K:Word;
Begin
 Repeat
{  If(IsGrf)Then WEPushCur(W);}
  WESetPos(W,X,Y+P);
  WESetCurPos(W,X,Y+P);
  WESimpleCur(W);
  K:=WEReadk(W);
  WECloseCur(W);
{  If(IsGrf)Then WEPopCur(W);}
  Case(K)of
   kbEsc,kbClose:Break;
   kbInWn:Begin
    ASM
      {Dec(LastMsX,WEGetRX1(W));Dec(LastMsY,WEGetRY1(W));}
     LES DI,W
     CALL AsmWEGetR
     SUB Word Ptr LastMouseX,AX
    END;
    If(LastMouseX=X)Then Repeat
     If(LastMouseY=Y+P)Then Begin
      TB[P-Min]:=Not TB[P-Min];
      WESetXBool(W,X,Y+P,TB[P-Min])
     End
      Else
     If(LastMouseY>=Y)and(LastMouseY<Y+Nm)Then P:=LastMouseY-Y
      Else
     Goto WnXt;
     WaitMouseBut0;
    Until True
     Else
    Begin
WnXt:ASM
       {Inc(LastMsX,WEGetRX1(W));Inc(LastMsY,WEGetRY1(W));}
      LES DI,W
      CALL AsmWEGetR
      ADD Word Ptr LastMouseX,AX
     END;
     WERunItem:=kbInWn;
     Exit;
    End;
   End;
   kbPgUp,kbPgDn:Begin
    WERunItem:=K;
    Exit;
   End;
   kbShiftTab,kbLeft,kbUp:If P=0Then P:=Nm
    Else
   Begin
    Dec(P);
    If(P<Min)Then Break;
   End;
   kbDn,kbRight,kbTab:If(P>=Nm)Then Break
                               Else Inc(P);
   kbEnter:P:=Nm;
   Else If Chr(K)=' 'Then Begin
    TB[P-Min]:=Not TB[P-Min];
    WESetXBool(W,X,Y+P,TB[P-Min])
   End;
  End;
  If(P>=Nm)Then Break;
 Until False;
 WERunItem:=K;
End;

{�����������������������������������������������������������������������
 �                         Proc�dure WESetCurPos                       �
 �����������������������������������������������������������������������


 Portabilit�:  Global
 Propri�taire: Window


 Description
 �����������

  Cette proc�dure permet de fixer le curseur par rapport � la fen�tre de
 dialogue.


 Remarque
 ��������

  � Voici la proc�dure sous forme Pascal brute:
    ������������������������������������������������������������������Ŀ
    � Procedure WESetCurPos;Begin                                      �
    �  SetCurPos(WEGetRX1(Q)+X,WEGetRY1(Q)+Y)                          �
    � End;                                                             �
    ��������������������������������������������������������������������
}

Procedure WESetCurPos{Var Q:Window;X,Y:Byte};Assembler;ASM
 {$IFDEF FLAT386}
  MOV EAX,EDX
  CALL asmWEGetR
  ADD AL,X
  ADD AH,Y
  MOV DL,AH
  CALL SetCurPos
 {$ELSE}
  LES DI,Q
  CALL AsmWEGetR
  ADD AL,X
  ADD AH,Y
  PUSH AX
  MOV AL,AH
  PUSH AX
  CALL SetCurPos
 {$ENDIF}
END;

{���������������������������������������������������������������������
 �                       Proc�dure WESetEndBar                       �
 ���������������������������������������������������������������������


 Portabilit�:  Global
 Propri�taire: Window


 Description
 �����������

  Cette proc�dure permet d'effacer la barre du bas de la fen�tre de la
 bo�te de dialogue de l'objet �Window� avec la couleur sp�cifi�e.
}

Procedure WESetEndBar{Var Q:Window;Attr:Byte};Begin
 {$IFNDEF GraphicOS}If Not(HoleMode)Then {$ENDIF}Begin
  BarSpcHor(Q.T.X1,Q.T.Y2,Q.T.X2,Attr)
 End;
End;

{������������������������������������������������������������������������
 �                           Proc�dure WESetKr                          �
 ������������������������������������������������������������������������


 Portabilit�:  Global
 Propri�taire: Window


 Description
 �����������

  Cette proc�dure permet de fixer la couleur courante de la fen�tre de la
 bo�te de dialogue de l'objet �Window�.
}

Procedure WESetKr{Var Q:Wins;Color:Byte};Begin
 Q.CurrColor:=Color;
End;

{������������������������������������������������������������������������
 �                         Proc�dure WESetKrSelF                        �
 ������������������������������������������������������������������������


 Portabilit�:  Global
 Propri�taire: Window


 Description
 �����������

  Cette proc�dure permet de fixer la couleur courante de la fen�tre de la
 bo�te de dialogue de  l'objet �Window� avec la m�me couleur  de fond des
 caract�res  que celle  utilis�e  pour les  s�lections  et de d�finir une
 nouvelle couleur pour l'�criture des caract�res.
}

Procedure WESetKrSelF{Var Q:Wins;F:Byte};Assembler;ASM
 {$IFDEF FLAT386}
  MOV CL,[EAX].Window.Palette.Sel
  AND CL,0F0h
  ADD CL,F
  MOV [EAX].Window.CurrColor,CL
 {$ELSE}
  LES DI,Q
  MOV AL,ES:[DI].Window.Palette.Sel
  AND AL,0F0h
  ADD AL,F
  MOV ES:[DI].Window.CurrColor,AL
 {$ENDIF}
END;

{������������������������������������������������������������������������
 �                        Proc�dure WESetKrBorderF                      �
 ������������������������������������������������������������������������


 Portabilit�:  Global
 Propri�taire: Window


 Description
 �����������

  Cette proc�dure permet de fixer la couleur courante de la fen�tre de la
 bo�te de dialogue de  l'objet �Window� avec la m�me couleur  de fond des
 caract�res  que celle  utilis�e  pour les  bordures  de la fen�tre et de
 d�finir une nouvelle couleur pour l'�criture des caract�res.
}

Procedure WESetKrBorderF{Var Q:Wins;F:Byte};Assembler;ASM
 {$IFDEF FLAT386}
  MOV CL,[EAX].Window.Palette.Border
  AND CL,0F0h
  ADD CL,F
  MOV [EAX].Window.CurrColor,CL
 {$ELSE}
  LES DI,Q
  MOV AL,ES:[DI].Window.Palette.Border
  AND AL,0F0h
  ADD AL,F
  MOV ES:[DI].Window.CurrColor,AL
 {$ENDIF}
END;

{������������������������������������������������������������������������
 �                          Proc�dure WESetXBool                        �
 ������������������������������������������������������������������������


 Portabilit�:  Global
 Propri�taire: Window


 Description
 �����������

  Cette proc�dure permet d'afficher l'�tat d'un bloc de s�lection dans la
 fen�tre de bo�te de dialogue de l'objet �Window�. Il n'y a naturellement
 que deux cas possibles, s�lectionn� ou non.
}

Procedure WESetXBool{Var W:Window;X,Y:Byte;B:Boolean};Begin
 WESetChr(W,X,Y,Chr(32+56*Byte(B)))
End;

{������������������������������������������������������������������������
 �                             Proc�dure WEUp                           �
 ������������������������������������������������������������������������


 Portabilit�:  Global
 Propri�taire: Window


 Description
 �����������

  Cette proc�dure permet le d�placement  du pointeur  texte logique de la
 fen�tre de la bo�te de dialogue de l'objet�Window�vers le haut de celle-
 ci d'un nombre sp�cifi�.
}

Procedure WEUp{Var Q:Window;N:Byte};
Var
 I:Byte;
Begin
 For I:=1to(N)do _WEUp(Q)
End;

{���������������������������������������������������������������������
 �                           Fonction WEXIsOut                       �
 ���������������������������������������������������������������������


 Portabilit�:  Global
 Propri�taire: Wins


 Description
 �����������

  Cette fonction indique  si la coordonn�es  du pointeur texte logique
 horizontal se situe actuellement � l'ext�rieur de la portion afficher
 de la fen�tre de la bo�te de dialogue de l'objet �Window�.
}

Function WEXIsOut{Var Q:Window):Boolean};Begin
 WEXIsOut:=Q.X>Q.MaxX;
End;

{�������������������������������������������������������������������
 �                          Fonction WEYIsOut                      �
 �������������������������������������������������������������������


 Portabilit�:  Global
 Propri�taire: Window


 Description
 �����������

  Cette fonction indique si la coordonn�es du pointeur texte logique
 vertical se situe actuellement � l'ext�rieur de la portion afficher
 de la fen�tre de la bo�te de dialogue de l'objet �Window�.
}

Function WEYIsOut{Var Q:Window):Boolean};Begin
 WEYIsOut:=Q.Y>Q.MaxY;
End;

{�������������������������������������������������������������������
 �                          Proc�dure _WEDn                        �
 �������������������������������������������������������������������


 Portabilit�:  Global
 Propri�taire: Wins


 Description
 �����������

  Cette proc�dure permet de d�placer le pointeur texte logique de la
 fen�tre  de la bo�te de dialogue de l'objet �Window� d'une position
 texte vers  le bas � condition  qu'il ne soit pas d�j� rendu sur la
 derni�re.
}

Procedure _WEDn{Var Q:Window};Begin
 If(Q.Y<Q.MaxY)Then Inc(Q.Y)
End;

{�������������������������������������������������������������������
 �                          Proc�dure _WEHL                        �
 �������������������������������������������������������������������


 Portabilit�:  Global
 Propri�taire: Window


 Description
 �����������

  Cette proc�dure permet de d�placer le pointeur texte logique de la
 fen�tre de la bo�te  de dialogue de l'objet �Window� au d�but de la
 ligne actuel.
}

Procedure _WEHL{Var Q:Window};Begin
 Q.X:=0;
End;

{��������������������������������������������������������������������
 �                           Proc�dure _WELeft                      �
 ��������������������������������������������������������������������


 Portabilit�:  Global
 Propri�taire: Window


 Description
 �����������

  Cette proc�dure permet de d�placer  le pointeur texte logique de la
 fen�tre  de la bo�te  de dialogue de l'objet �Window� d'une position
 texte vers la gauche � condition qu'il ne soit par rendu � la limite
 de d�placement possible vers cette direction.
}

Procedure _WELeft{Var Q:Window};Begin
 If Q.X>0Then Dec(Q.X)
End;

{�������������������������������������������������������������������
 �                          Proc�dure _WELL                        �
 �������������������������������������������������������������������


 Portabilit�:  Global
 Propri�taire: Wins


 Description
 �����������

  Cette proc�dure permet de d�placer le pointeur texte logique de la
 fen�tre  de la bo�te de  dialogue de l'objet �Window� � la position
 vertical maximal permit  pour l'affichage du texte � l'int�rieur de
 celle-ci.
}

Procedure _WELL{Var Q:Window};Assembler;ASM
 {$IFDEF FLAT386}
  MOV CL,[EAX].Window.MaxY
  MOV [EAX].Window.Y,CL
 {$ELSE}
  { Q.Y:=Q.MaxY;}
  LES DI,Q
  MOV AL,ES:[DI].Window.MaxY
  MOV ES:[DI].Window.Y,AL
 {$ENDIF}
END;

{�������������������������������������������������������������������
 �                          Proc�dure _WEUp                        �
 �������������������������������������������������������������������


 Portabilit�:  Global
 Propri�taire: Window


 Description
 �����������

  Cette proc�dure permet de d�placer le pointeur texte logique de la
 fen�tre  de la bo�te de dialogue de l'objet �Window� d'une position
 texte vers le haut � condition  qu'il ne soit pas d�j� rendu sur la
 premi�re ligne.
}

Procedure _WEUp{Var Q:Wins};Begin
 If Q.Y>0Then Dec(Q.Y)
End;

{������������������������������������������������������������������
 �                        Proc�dure WEPutTyping                   �
 ������������������������������������������������������������������


 Portabilit�:  Global
 Propri�taire: Window


 Description
 �����������

  Cette proc�dure permet d'afficher une message de format typ� � la
 position courante  du  pointeur logique texte  de la fen�tre de la
 bo�te de dialogue de l'objet �Window�.


 Remarque
 ��������

  � Voici le source en langage Pascal pure de cette proc�dure:
    �������������������������������������������������������������Ŀ
    � Procedure WEPutTyping;Begin                                 �
    �  PutTypingXY(WEGetRealX(Q),WEGetRealY(Q),Msg);              �
    �  Q.X:=VidBnkSwitch.XP-WEGetRX1(Q);                          �
    �  Q.Y:=VidBnkSwitch.YP-WEGetRY1(Q)                           �
    � End;                                                        �
    ���������������������������������������������������������������
}

Procedure WEPutTyping{Var Q:Window;Const Msg:String};Assembler;ASM
 {$IFDEF FLAT386}
   {PutTypingXY(WEGetRealX(Q),WEGetRealY(Q),Msg);}
  XCHG EAX,EDX
  CALL asmWEGetReal
  MOV DL,AH
  MOV ECX,Msg
  CALL PutTypingXY
   {Q.X:=VidBnkSwitch.XP-WEGetRX1(Q);
    Q.Y:=VidBnkSwitch.YP-WEGetRY1(Q)}
  LEA EDX,DWord Ptr Q
  CALL asmWEGetR
  MOV CX,Word Ptr VidBnkSwitch.XP
  SUB CX,AX
  MOV Word Ptr [EDX].Window.X,CX
 {$ELSE}
   {PutTypingXY(WEGetRealX(Q),WEGetRealY(Q),Msg);}
  LES DI,Q
  CALL AsmWEGetReal
  PUSH AX
  MOV AL,AH
  PUSH AX
  LES DI,Msg
  PUSH ES
  PUSH DI
  CALL PutTypingXY
   {Q.X:=VidBnkSwitch.XP-WEGetRX1(Q);
    Q.Y:=VidBnkSwitch.YP-WEGetRY1(Q)}
  LES DI,Q
  CALL AsmWEGetR
  MOV BX,Word Ptr VidBnkSwitch.XP
  SUB BX,AX
  MOV Word Ptr ES:[DI].Window.X,BX
 {$ENDIF}
END;

{���������������������������������������������������������������������
 �                           Proc�dure WEPutTxtXY                    �
 ���������������������������������������������������������������������


 Portabilit�:  Global
 Propri�taire: Window


 Description
 �����������

  Cette proc�dure permet l'affichage d'un message texte � une position
 texte logique sp�cifi�e  avec la couleur d'affichage courante pour la
 fen�tre de la bo�te de dialogue de l'objet �Window�. Il modifie aussi
 bien le fond que l'�criture.


 Remarque
 ��������

  � Voici le source en langage Pascal pure de cette proc�dure:
    �����������������������������������������������������������������Ŀ
    �Procedure WEPutTxtXY;Var MaxX:Byte;MsgLen:Byte Absolute Msg;Begin�
    � MaxX:=Q.MaxX;                                                   �
    � If(X>MaxX)and(X<$F0)Then Exit;                                  �
    � WEAlignEnd(Q,X,Y);                                              �
    � If(X>MaxX)or(Y>Q.MaxY)Then Exit;                                �
    � If X+MsgLen>MaxX+1Then MsgLen:=MaxX-X+1;                        �
    � PutTxtXY(WEGetRX1(Q)+X,WEGetRY1(Q)+Y,Msg,Q.CurrColor);          �
    � Q.X:=X+MsgLen;Q.Y:=Y                                            �
    �End;                                                             �
    �������������������������������������������������������������������
}

Procedure WEPutTxtXY{Var Q:Wins;X,Y:Byte;Msg:String};
Label _Exit;
Var
 {$IFDEF FLAT386}
  MaxX:Byte;
 {$ENDIF}
 MsgLen:Byte Absolute Msg;
Begin
 {$IFDEF FLAT386}
  MaxX:=Q.MaxX;
  If(X>MaxX)and(X<$F0)Then Exit;
  WEAlignEnd(Q,X,Y);
  If(X>MaxX)or(Y>Q.MaxY)Then Exit;
  If X+MsgLen>MaxX+1Then MsgLen:=MaxX-X+1;
  {$IFDEF __Windows__}
   WEAttr(Q,Q.CurrColor);
   Q.Canvas.TextOut(X*Q.Width,Y*Q.Height,Msg);
  {$ELSE}
   PutTxtXY(WEGetRX1(Q)+X,WEGetRY1(Q)+Y,Msg,Q.CurrColor);
  {$ENDIF}
  Q.X:=X+MsgLen;Q.Y:=Y
 {$ELSE}
  ASM
   LES DI,Q
   MOV BX,Word Ptr ES:[DI].Window.MaxX
   MOV AL,X
   CMP AL,0F0h
   JAE @Ok
   CMP AL,BL
   JA  _Exit
   MOV AH,Y
   CMP AH,0F0h
   JAE @Ok
   CMP AH,BH
   JA  _Exit
 @Ok:
   MOV CX,BX
   CALL AsmWEAlignEnd
   MOV BL,MsgLen
   MOV BH,0
   ADD BL,AL
   ADC BH,BH
   MOV CH,0
   INC CX
   CMP BX,CX
   JNA @1
   SUB CL,AL
   MOV MsgLen,CL
 @1:
   MOV CX,AX
   ADD AL,MsgLen
   MOV Word Ptr ES:[DI].Window.X,AX
    {PutTxtXY(WEGetRX1(Q)+X,WEGetRY1(Q)+Y,Msg,Q.Kr);}
   CALL AsmWEGetR
   ADD AX,CX
   PUSH AX
   MOV AL,AH
   PUSH AX
   PUSH SS
   MOV SI,Offset Msg
   ADD SI,BP
   PUSH SI
   PUSH Word Ptr ES:[DI].Window.CurrColor
   CALL PutTxtXYHole
  END;
_Exit:
 {$ENDIF}
End;

{���������������������������������������������������������������������
 �                          Proc�dure WEPutTxtXYT                    �
 ���������������������������������������������������������������������


 Portabilit�:  Global
 Propri�taire: Window


 Description
 �����������

  Cette proc�dure permet l'affichage d'un message texte � une position
 texte logique sp�cifi�e  avec la  couleur  texte d'affichage courante
 pour la fen�tre de la bo�te de dialogue de l'objet�Window�.Il modifie
 seulement  l'�criture  mais jamais  le fond et s'il y a d�j� un autre
 texte d'afficher il ne sera pas effac�.


 Remarque
 ��������

  � Voici le source en langage Pascal pure de cette proc�dure:
    ����������������������������������������������������������������Ŀ
    � Procedure WEPutTxtXYT;                                         �
    � Var MaxX:Byte;MsgLen:Byte Absolute Msg;                        �
    � Begin                                                          �
    �  MaxX:=Q.MaxX;                                                 �
    �  If(X>MaxX)or(Y>Q.MaxY)Then Exit;                              �
    �  If X+MsgLen>MaxX+1Then MsgLen:=MaxX-X+1;                      �
    �  If(IsGrf)Then                                                 �
    �   PutTxtXYT(WEGetRX1(Q)+X,WEGetRY1(Q)+Y,Msg,Q.CurrColor and$F) �
    �  Else                                                          �
    �   WEPutTxtXY(Q,X,Y,Msg);                                       �
    �  Q.X:=X+MsgLen;Q.Y:=Y;                                         �
    � End;                                                           �
    ������������������������������������������������������������������
}

Procedure WEPutTxtXYT{Var Q:Window;X,Y:Byte;Msg:String};
Var
 {$IFDEF FLAT386}
  MaxX:Byte;
 {$ENDIF}
 MsgLen:Byte Absolute Msg;
Begin
 {$IFDEF FLAT386}
  MaxX:=Q.MaxX;
  If(X>MaxX)or(Y>Q.MaxY)Then Exit;
  If X+MsgLen>MaxX+1Then MsgLen:=MaxX-X+1;
  If(IsGrf)Then PutTxtXYT(WEGetRX1(Q)+X,WEGetRY1(Q)+Y,Msg,Q.CurrColor and$F)
           Else WEPutTxtXY(Q,X,Y,Msg);
  Q.X:=X+MsgLen;Q.Y:=Y;
 {$ELSE}
  ASM
   {_XM:=Q.MaxX;
    If(X>_XM)or(Y>Q.MaxY)Then Exit;
    If X+MsgLen>_XM+1Then MsgLen:=_XM-X+1;}
   LES DI,Q
   MOV BX,Word Ptr ES:[DI].Window.MaxX
   MOV DL,X
   MOV DH,Y
   CMP DL,BL
   JA  @End
   CMP DH,BH
   JA  @End
   MOV CL,AL
   ADD CL,MsgLen
   INC BX
   CMP CL,BL
   JNA @1
   SUB BL,AL
   MOV MsgLen,BL
  @1:
   MOV SI,Offset Msg
   ADD SI,BP
   CALL IsGrf
   OR AL,AL
   JZ @Text
    {PutTxtXYT(WEGetRX1(Q)+X,WEGetRY1(Q)+Y,Msg,Q.Kr and$F)}
   CALL AsmWEGetR
   ADD AX,DX
   PUSH AX
   MOV AL,AH
   PUSH AX
   PUSH SS
   PUSH SI
   MOV AL,ES:[DI].Window.CurrColor
   AND AL,0Fh
   PUSH AX
   CALL PutTxtXYT
   JMP @UpDate
  @Text:
   PUSH ES
   PUSH DI
   PUSH DX
   MOV DL,DH
   PUSH DX
   PUSH SS
   PUSH SI
   CALL WEPutTxtXY
  @UpDate:
    {Q.X:=X+MsgLen;Q.Y:=Y;}
   LES DI,Q
   MOV AL,X
   ADD AL,MsgLen
   MOV AH,Y
   MOV Word Ptr ES:[DI].Window.X,AX
  @End:
  END;
 {$ENDIF}
End;

{���������������������������������������������������������������������
 �                         Proc�dure WEPutTxtXYU                     �
 ���������������������������������������������������������������������


 Portabilit�:  Global
 Propri�taire: Window


 Description
 �����������

  Cette proc�dure permet l'affichage d'un message texte � une position
 texte logique  sp�cifi�e en utilisant  les attributs  actuellement en
 usage � la position du message de la  fen�tre de la bo�te de dialogue
 de l'objet �Window�. Il ne modifie pas le fond et la couleur �criture
 d'�criture.


 Remarque
 ��������

  � Si le pointeur de souris est actif et  qu'il se  situe � l'endroit
    o� il y a  pr�sentement  la demande  d'affichage,  le pointeur est
    effacer puis r�afficher apr�s l'affichage du message.
}

Procedure WEPutTxtXYU{Var Q:Window;X,Y:Byte;Msg:String};
Var
 MaxX:Byte;
 MsgLen:Byte Absolute Msg;
 ZonePtr:Boolean;
Begin
 {$IFNDEF GraphicOS}
  If(HoleMode)Then Exit;
 {$ENDIF}
 ZonePtr:=WEInZonePtrMouse(Q,X,Y,Length(Msg),1);
 MaxX:=Q.MaxX;
 If(X>MaxX)or(Y>Q.MaxY)Then Exit;
 If X+MsgLen>MaxX+1Then MsgLen:=MaxX-X+1;
 If(ZonePtr)Then __HideMousePtr;
 {$IFDEF FLAT386}
  PutTxtXYUnCol(WEGetRX1(Q)+X,WEGetRY1(Q)+Y,Msg);
  Q.X:=X+MsgLen;
  Q.Y:=Y;
 {$ELSE}
  ASM
   {PutTxtXYUnCol(WEGetRX1(Q)+X,WEGetRY1(Q)+Y,Msg);}
   {Q.X:=X+MsgLen;Q.Y:=Y;}
   LES DI,Q
   CALL AsmWEGetR
   MOV BL,X
   MOV BH,Y
   ADD AX,BX
   ADD BL,MsgLen
   MOV Word Ptr ES:[DI].Window.X,BX
   PUSH AX
   PUSH SS
   MOV SI,Offset Msg
   ADD SI,BP
   PUSH SI
   CALL PutTxtZUnKr
  END;
 {$ENDIF}
 If(ZonePtr)Then __ShowMousePtr;
End;

{����������������������������������������������������������������������
 �                         Proc�dure WEPutPTxtXY2                     �
 ����������������������������������������������������������������������


 Portabilit�:  Global
 Propri�taire: Window


 Description
 �����������

  Cette proc�dure permet l'affiche d'une cha�ne de caract�res de format
 ASCIIZ  � partir  d'une position  pr�cis dans celle-ci  � une position
 logique  texte  sp�cifi�e  et la couleur courante  de la fen�tre de la
 bo�te de dialogue de l'objet �Window�.
}

Procedure WEPutPTxtXY2{Var Q:Window;X,Y:Byte;S:Word;Msg:PChr};
Label Xit;
Var
 R:TextCharRec;
 MaxX:Byte;
 I:Word;
Begin
 {$IFNDEF GraphicOS}
  If(Msg=NIL)or(HoleMode)Then Exit;
 {$ENDIF}
 ASM
  {$IFDEF FLAT386}
    {_X:=WEGetR(Q,_Y);Inc(R.X,X);Inc(R.Y,Y);}
   LEA EDX,Q
   MOV DX,Word Ptr [EDX].Window.MaxX
   MOV BL,X
   MOV BH,Y
   CMP BL,DL
   JA  Xit
   CMP BH,DH
   JA  Xit
   CALL AsmWEGetR
   ADD AX,BX
   MOV R,AX
   SUB DL,BL
   MOV MaxX,DL
    {For I:=0to(S)do If Msg^[I]=#0Then Begin;Q.X:=X;Exit;End;}
   MOVZX ECX,S
   XOR AX,AX
   PUSH EDI
    LEA EDI,Msg
    REPNE SCASB
   POP EDI
   JCXZ @Ok
   LEA EDX,DWord Ptr Q
   MOV AL,BL
   MOV [EDX].Window.X,AL
   JMP Xit
@Ok:
   MOV Word Ptr Msg,DI
  {$ELSE}
{_X:=WEGetR(Q,_Y);Inc(R.X,X);Inc(R.Y,Y);}
   LES DI,Q
   MOV DX,Word Ptr ES:[DI].Window.MaxX
   MOV BL,X
   MOV BH,Y
   CMP BL,DL
   JA  Xit
   CMP BH,DH
   JA  Xit
   CALL AsmWEGetR
   ADD AX,BX
   MOV R,AX
   SUB DL,BL
   MOV MaxX,DL
    {For I:=0to(S)do If Msg^[I]=#0Then Begin
      Q.X:=X;
      Exit;
     End;}
   MOV CX,S
   CLD
   LES DI,Msg
   XOR AX,AX
   REPNE SCASB
   JCXZ @Ok
   LES DI,Q
   MOV AL,BL
   MOV ES:[DI].Window.X,AL
   JMP Xit
@Ok:
   MOV Word Ptr Msg,DI
  {$ENDIF}
 END;
 For I:=0to(MaxX)do Begin
  If Msg^[0]=#0Then Begin
   Q.X:=X;
   Exit;
  End;
  SetCube(R.X,R.Y,Msg^[0],Q.CurrColor);
  Inc(R.X);Inc(X);
  ASM
   INC Word Ptr Msg
  END;
 End;
 Q.X:=X+1;
Xit:
End;

{��������������������������������������������������������������������������
 �                         Proc�dure WEPutPTxtXYAtChr                     �
 ��������������������������������������������������������������������������


 Portabilit�:  Global
 Propri�taire: Window


 Description
 �����������

   Cette proc�dure  permet l'affiche  d'une cha�ne  de caract�res de format
  ASCIIZ jusqu'au caract�re sp�cifi� � une position logique texte sp�cifi�e
  et la couleur courante  de la fen�tre  de la bo�te de dialogue de l'objet
  �Window�.
}

Procedure WEPutPTxtXYAtChr{Var Q:Window;X,Y:Byte;Chr:Char;Msg:PChr};
Label Quit,Xit;
Var
 R:TextCharRec;
 MaxX:Byte;
 I:Word;
Begin
 ASM
  {$IFDEF FLAT386}
   LEA ECX,DWord Ptr Msg
   OR  ECX,ECX
   JZ  Xit
    { Q.X:=X;Q.Y:=Y; }
   MOV BL,X
   MOV BH,Y
   MOV Word Ptr [ECX].Window.X,BX
   MOV CX,Word Ptr [ECX].Window.MaxX
   CMP BL,CL
   JA  Xit
   CMP BH,CH
   JA  Xit
   SUB CL,BL
   MOV MaxX,CL
    {_X:=WEGetR(Q,_Y);Inc(_X,X);Inc(_Y,Y);}
   CALL AsmWEGetR
   ADD AX,BX
   MOV R,AX
  {$ELSE}
   LES DI,Msg
   MOV CX,ES
   OR  CX,DI
   JZ  Xit
    { Q.X:=X;Q.Y:=Y; }
   LES DI,Q
   MOV BL,X
   MOV BH,Y
   MOV Word Ptr ES:[DI].Window.X,BX
   MOV CX,Word Ptr ES:[DI].Window.MaxX
   CMP BL,CL
   JA  Xit
   CMP BH,CH
   JA  Xit
   SUB CL,BL
   MOV MaxX,CL
    {_X:=WEGetR(Q,_Y);Inc(_X,X);Inc(_Y,Y);}
   CALL AsmWEGetR
   ADD AX,BX
   MOV R,AX
  {$ENDIF}
 END;
 For I:=0to(MaxX)do Begin
  If(Msg^[I]=#0)or(Msg^[I]=Chr)Then Goto Quit;
  SetCube(R.X+I,R.Y,Msg^[I],Q.CurrColor);
 End;
Quit:
 Q.X:=X+I;
Xit:
End;

{�������������������������������������������������������������������
 �                        Proc�dure WEPutOTxt                      �
 �������������������������������������������������������������������


 Portabilit�:  Global
 Propri�taire: Window


 Description
 �����������

   Cette proc�dure permet d'afficher un message centr�e sur la ligne
  courante dans la  fen�tre la bo�te de dialogue de l'objet �Window�
  avec la couleur courante.
}

Procedure WEPutOTxt{Var Q:Window;Const Msg:String};
Var
 MsgLen:Byte Absolute Msg;
Begin
 WEPutTxtXY(Q,(Q.T.X2-Q.T.X1-MsgLen)shr 1,Q.Y,Msg);
 WELn(Q)
End;

{�������������������������������������������������������������������
 �                        Proc�dure WEPutOTxtU                     �
 �������������������������������������������������������������������


 Portabilit�:  Global
 Propri�taire: Window


 Description
 �����������

   Cette proc�dure permet d'afficher un message centr�e sur la ligne
  courante dans la  fen�tre la bo�te de dialogue de l'objet �Window�
  sans affecte les attributs d'affichage o� le message est afficher.


 Remarque
 ��������

  � Voici le source en langage Pascal pure de cette proc�dure:
    ��������������������������������������������������������������Ŀ
    � Procedure WEPutOTxtU;Var MsgLen:Byte Absolute Msg;Begin      �
    �  PutTxtXYUnCol(WEGetRX1(Q)+(Q.X2-Q.X1-MsgLen)shr 1,          �
    �                WEGetRY1(Q)+Q.Y,Msg);                         �
    �  WELn(Q)                                                     �
    � End;                                                         �
    ����������������������������������������������������������������
}

Procedure WEPutOTxtU{Var Q:Window;Const Msg:String};Begin
 ASM
  {$IFDEF FLAT386}
    {PutTxtXYUnCol(WEGetRX1(Q)+(Q.X2-Q.X1-MsgLen)shr 1,WEGetRY1(Q)+Q.Y,Msg);}
   XCHG EAX,EDX
   CALL AsmWEGetR
   MOV CL,[EDX].Window.T.X2
   SUB CL,[EDX].Window.T.X1
   MOV CH,[EDX].Window.Y
   LEA EDX,DWord Ptr Msg
   SUB CL,[EDX]
   SHR CL,1
   ADD AX,CX
   CALL PutTxtZUnKr
  {$ELSE}
    {PutTxtXYUnCol(WEGetRX1(Q)+(Q.X2-Q.X1-MsgLen)shr 1,WEGetRY1(Q)+Q.Y,Msg);}
   LES SI,Msg
   MOV DX,ES
   MOV CL,ES:[SI]
   LES DI,Q
   CALL AsmWEGetR
   MOV BL,ES:[DI].Window.T.X2
   SUB BL,ES:[DI].Window.T.X1
   SUB BL,CL
   SHR BL,1
   MOV BH,ES:[DI].Window.Y
   ADD AX,BX
   PUSH AX
   PUSH DX
   PUSH SI
   CALL PutTxtZUnKr
  {$ENDIF}
 END;
 WELn(Q)
End;

{������������������������������������������������������������������������
 �                           Proc�dure WESetAttr                        �
 ������������������������������������������������������������������������


 Propri�taire: Window
 Portabilit�:  Global


 Description
 �����������

  Cette proc�dure permet de modifier la couleur d'attribut d'un caract�re
 situ� � la position texte logique sp�cifi�e de la fen�tre de la bo�te de
 de dialogue de l'objet �Window�.
}

Procedure WESetAttr{Var Q:Window;X,Y,Attr:Byte};Assembler;ASM
 {$IFDEF FLAT386}
   {SetAttr(WEGetRX1(Q)+X,WEGetRY1(Q)+Y,Attr);}
  LEA EDX,DWord Ptr Q
  CALL AsmWEGetR
  ADD AL,X
  ADD AH,Y
  MOV DL,AH
  MOV CL,Attr
  CALL SetAttr
 {$ELSE}
   {SetAttr(WEGetRX1(Q)+X,WEGetRY1(Q)+Y,Attr);}
  LES DI,Q
  {MOV AL,Y
  CMP AL,ES:[DI].Window.MaxY
  JAE @End}
  CALL AsmWEGetR
  ADD AL,X
  ADD AH,Y
  PUSH AX
  MOV AL,AH
  PUSH AX
  PUSH Word Ptr Attr
  CALL SetAttr
@End:
 {$ENDIF}
END;

{���������������������������������������������������������������������
 �                         Proc�dure WESetChr                        �
 ���������������������������������������������������������������������


 Portabilit�:  Global
 Propri�taire: Window


 Description
 �����������

   Cette proc�dure permet de changer un caract�res sans son attribut �
  une position texte logique sp�cifi�e  dans la fen�tre de la bo�te de
  dialogue  de l'objet �Window�. Il  utilise  l'attribut  de  l'ancien
  caract�re.


 Remarque
 ��������

  � Voici le source en langage Pascal pure de cette proc�dure:
    ����������������������������������������������������������������Ŀ
    � Procedure WESetChr;Begin                                       �
    �  If Not Hole^[Y*NmXTxts+X]Then Begin                           �
    �   WEAlignEnd(Q,X,Y);                                           �
    �   SetChr(WEGetRX1(Q)+X,WEGetRY1(Q)+Y,Chr);                     �
    �  End;                                                          �
    � End;                                                           �
    ������������������������������������������������������������������
}

Procedure WESetChr{Var Q:Window;X,Y:Byte;Chr:Char};
{$IFDEF __Windows__}
 Begin
  WEAttr(Q,Q.CurrColor);
  Q.Canvas.TextOut(X*Q.Width,Y*Q.Height,Chr);
 End;
{$ELSE}
 Assembler;ASM
  {$IFDEF FLAT386}
    {SetChr(WEGetRX1(Q)+X,WEGetRY1(Q)+Y,Chr);}
   LEA EDX,DWord Ptr Q
   MOV AL,X
   MOV AH,Y
   CALL asmWEAlignEnd
   XCHG AX,CX
   CALL AsmWEGetR
   ADD AX,CX
   {$IFNDEF GraphicOS}
    CMP HoleMode,True
    JNE @Run
    PUSH AX
     XCHG CX,AX
     CALL NmXTxts
     MUL CH
     AND CX,0FFh
     ADD AX,CX
     AND AX,0FFFFh
     LEA EDX,Hole
     ADD EDX,EAX
     CMP Byte Ptr [EDX],0
    POP AX
    JNE @End
    LEA EDX,DWord Ptr Q
 @Run:
   {$ENDIF}
   MOV DL,AH
   MOV CL,Chr
   CALL SetChr
 @End:
  {$ELSE}
    {SetChr(WEGetRX1(Q)+X,WEGetRY1(Q)+Y,Chr);}
   LES DI,Q
   MOV AL,X
   MOV AH,Y
   CALL AsmWEAlignEnd
   XCHG AX,CX
   CALL AsmWEGetR
   ADD AX,CX
   CMP HoleMode,True
   JNE @Run
   PUSH AX
    XCHG CX,AX
    CALL NmXTxts
    MUL CH
    XOR CH,CH
    ADD AX,CX
    LES DI,Hole
    ADD DI,AX
    MOV AL,0
    SCASB
   POP AX
   JNE @End
   LES DI,Q
  @Run:
   PUSH AX
   MOV AL,AH
   PUSH AX
   PUSH Word Ptr Chr
   CALL SetChr
 @End:
  {$ENDIF}
 END;
{$ENDIF}

{�������������������������������������������������������������������������
 �                            Proc�dure WESetCube                        �
 �������������������������������������������������������������������������


 Propri�taire: Window
 Portabilit�:  Global


 Description
 �����������

  Cette proc�dure permet de changer un caract�res avec la couleur courante
 de la fen�tre  de la bo�te  de dialogue de l'objet �Window� � la position
 texte logique sp�cifi�e de celle-ci.


 Remarque
 ��������

  � Voici le source en langage Pascal pure de cette proc�dure:
    ��������������������������������������������������������������������Ŀ
    � Procedure WESetCube;Begin                                          �
    �  If(X<=Q.MaxX)Then (*$IFDEF MaxGraf*)Case(Q.Matrix)of              �
    �   _6x6: WEPutTxt6x6(Q,X,Y,Chr,Q.Kr);                               �
    �   Else(*$ENDIF*)SetCube(WEGetRX1(Q)+X,WEGetRY1(Q)+Y,Chr,Q.Kr);     �
    �  (*$IFDEF MaxGraf*)End(*$ENDIF*)                                   �
    �  Q.X:=X+1;Q.Y:=Y                                                   �
    � End;                                                               �
    ����������������������������������������������������������������������
}

Procedure WESetCube{Var Q:Wins;X,Y:Byte;Chr:Char};
{$IFDEF __Windows__}
 Begin
  WEAttr(Q,Q.CurrColor);
  If(Q.Canvas<>NIL)Then Q.Canvas.TextOut(X*Q.Width,Y*Q.Height,Chr);
 End;
{$ELSE}
 Assembler;ASM
  {$IFDEF FLAT386}
    {If(X<=Q.MaxX)Then SetCube(WEGetRX1(Q)+X,WEGetRY1(Q)+Y,Chr,Q.Kr);}
   LEA EDX,DWord Ptr Q
   MOV BL,X
   MOV AX,Word Ptr [EDX].Wins.MaxX
   CMP BL,AL
   JA  @Skip
   MOV BH,Y
   CMP BH,AH
   JA  @Skip
   CALL AsmWEGetR
   ADD AX,BX
   CMP HoleMode,True
   JNE @Run
   PUSH AX
    XCHG CX,AX
    CALL NmXTxts
    MUL CH
    AND ECX,0FFh
    ADD EAX,ECX
    LEA EDI,Hole
    ADD EDI,EAX
    CMP Byte Ptr [EDI],0
   POP AX
   JNE @Skip
   LEA EDI,DWord Ptr Q
 @Run:
   MOV DL,AH
   MOV CL,Chr
   PUSH DWord Ptr [EDI].Wins.CurrColor
   CALL SetCube
 @Skip:
    { Q.X:=X+1;Q.Y:=Y}
   LEA EDX,DWord Ptr Q
   MOV AL,X
   MOV AH,Y
   INC AX
   MOV Word Ptr [EDX].Wins.X,AX
  {$ELSE}
    {If(X<=Q.MaxX)Then SetCube(WEGetRX1(Q)+X,WEGetRY1(Q)+Y,Chr,Q.Kr);}
   LES DI,Q
   MOV BL,X
   MOV AX,Word Ptr ES:[DI].Window.MaxX
   CMP BL,AL
   JA  @Skip
   MOV BH,Y
   CMP BH,AH
   JA  @Skip
   CALL AsmWEGetR
   ADD AX,BX
   CMP HoleMode,True
   JNE @Run
   PUSH AX
    XCHG CX,AX
    CALL NmXTxts
    MUL CH
    XOR CH,CH
    ADD AX,CX
    LES DI,Hole
    ADD DI,AX
    MOV AL,0
    SCASB
   POP AX
   JNE @Skip
   LES DI,Q
  @Run:
   PUSH AX
   MOV AL,AH
   PUSH AX
   PUSH Word Ptr Chr
   PUSH Word Ptr ES:[DI].Window.CurrColor
   CALL SetCube
  @Skip:
    { Q.X:=X+1;Q.Y:=Y}
   LES DI,Q
   MOV AL,X
   MOV AH,Y
   INC AX
   MOV Word Ptr ES:[DI].Window.X,AX
  {$ENDIF}
 END;
{$ENDIF}

{������������������������������������������������������������������������
 �                          Proc�dure WEScrollUp                        �
 ������������������������������������������������������������������������


 Propri�taire: Window
 Portabilit�:  Global


 Description
 �����������

  Cette proc�dure permet d'effectuer une d�filement vers le haut dans une
 zone sp�cifier  texte logique  de la fen�tre  de la bo�te de dialogue de
 l'objet �Window�.


 Remarque
 ��������

  � Voici le source en langage Pascal pure de cette proc�dure:
    ������������������������������������������������������������������Ŀ
    � Procedure WEScrollUp;Var XM,YM,RX1,RY1:Byte;Begin                �
    �  XM:=Q.MaxX;YM:=Q.MaxY;                                          �
    �  If(X2>XM)Then X2:=XM;                                           �
    �  If(Y2>YM)Then Y2:=YM;                                           �
    �  RX1:=WEGetR(Q,RY1);                                             �
    �  MoveText(RX1+X1,RY1+Y1,RX1+X2,RY1+Y2-1,RX1+X1,RY1+Y1+1)         �
    � End;                                                             �
    ��������������������������������������������������������������������
}

Procedure WEScrollUp{Var Q:Window;X1,Y1,X2,Y2:Byte};
{$IFDEF FLAT386}
 Var
  XM,YM,RX1,RY1:Byte;
 Begin
  XM:=Q.MaxX;YM:=Q.MaxY;
  If(X2>XM)Then X2:=XM;
  If(Y2>YM)Then Y2:=YM;
  RX1:=WEGetR(Q,RY1);
  MoveText(RX1+X1,RY1+Y1,RX1+X2,RY1+Y2-1,RX1+X1,RY1+Y1+1)
 End;
{$ELSE}
 Assembler;ASM
  LES DI,Q
  MOV AX,Word Ptr ES:[DI].Window.MaxX
  MOV DL,X2
  MOV DH,Y2
  CMP AL,DL
  JAE @1
  MOV DL,AL
 @1:
  CMP AH,DH
  JAE @2
  MOV DH,AH
 @2:
  CALL AsmWEGetR
   {MoveText(RX1+X1,RY1+Y1,RX1+X2,RY1+Y2-1,RX1+X1,RY1+Y1+1)}
  MOV BL,X1
  MOV BH,Y1
  ADD BX,AX
  MOV CX,BX
  PUSH BX
  MOV BL,BH
  PUSH BX
  ADD DX,AX
  PUSH DX
  MOV BL,DH
  DEC BX
  PUSH BX
  PUSH CX
  MOV BL,CH
  INC BX
  PUSH BX
  CALL MoveText
 End;
{$ENDIF}

{�����������������������������������������������������������������������
 �                         Proc�dure WEScrollDn                        �
 �����������������������������������������������������������������������


 Propri�taire: Window
 Portabilit�:  Global


 Description
 �����������

  Cette proc�dure permet d'effectuer une d�filement vers le bas dans une
 zone sp�cifier texte logique  de la fen�tre  de la bo�te de dialogue de
 l'objet �Window�.


 Remarque
 ��������

  � Voici le source en langage Pascal pure de cette proc�dure:
    ������������������������������������������������������������������Ŀ
    � Procedure WEScrollDn;Var XM,YM,RX1,RY1:Byte;Begin                �
    �  XM:=Q.MaxX;YM:=Q.MaxY;                                          �
    �  If(X2>XM)Then X2:=XM;                                           �
    �  If(Y2>YM)Then Y2:=YM;                                           �
    �  RX1:=WEGetR(Q,RY1);                                             �
    �  MoveText(RX1+X1,RY1+Y1+1,RX1+X2,RY1+Y2,RX1+X1,RY1+Y1)           �
    � End;                                                             �
    ��������������������������������������������������������������������
}

Procedure WEScrollDn{Var Q:Window;X1,Y1,X2,Y2:Byte};
{$IFDEF FLAT386}
 Var
  XM,YM,RX1,RY1:Byte;
 Begin
  XM:=Q.MaxX;YM:=Q.MaxY;
  If(X2>XM)Then X2:=XM;
  If(Y2>YM)Then Y2:=YM;
  RX1:=WEGetR(Q,RY1);
  MoveText(RX1+X1,RY1+Y1+1,RX1+X2,RY1+Y2,RX1+X1,RY1+Y1)
 End;
{$ELSE}
 Assembler;ASM
  LES DI,Q
  MOV AX,Word Ptr ES:[DI].Window.MaxX
  MOV DL,X2
  MOV DH,Y2
  CMP AL,DL
  JAE @1
  MOV DL,AL
 @1:
  CMP AH,DH
  JAE @2
  MOV DH,AH
 @2:
  CALL AsmWEGetR
   { MoveText(RX1+X1,RY1+Y1+1,RX1+X2,RY1+Y2,RX1+X1,RY1+Y1)}
  MOV BL,X1
  MOV BH,Y1
  ADD BX,AX
  MOV CX,BX
  PUSH BX
  MOV BL,BH
  INC BX
  PUSH BX
  ADD DX,AX
  PUSH DX
  MOV BL,DH
  PUSH BX
  PUSH CX
  MOV CL,CH
  PUSH CX
  CALL MoveText
 END;
{$ENDIF}

{ ������������������������������������������������������������������������
  �                            Fonction WEMaxXTxts                       �
  ������������������������������������������������������������������������


  Propri�taire: Window
  Portabilit�:  Local


  Description
  �����������

   Cette fonction retourne le coordonn�e maximal affichage dans la fen�tre
  de dialogue sur l'axe des X (horizontal).
}

Function WEMaxXTxts;Assembler;ASM
 {$IFDEF FLAT386}
  XCHG EAX,EDX
  MOV AL,UpIconLen
  MOV CL,[EDX].Window.NotFullScrnX
  SUB AL,CL
  MUL Byte Ptr [EDX].Window.BarMouseRight
  MOV CH,AL
  SHL CL,1
  ADD CL,[EDX].Window.T.X1
  MOV AL,[EDX].Window.T.X2
  SUB AL,CL
  SUB AL,CH
 {$ELSE}
  MOV AL,UpIconLen
  LES DI,Q
  MOV BL,ES:[DI].Window.NotFullScrnX
  SUB AL,BL
  MUL Byte Ptr ES:[DI].Window.BarMouseRight
  MOV BH,AL
  SHL BL,1
  ADD BL,ES:[DI].Window.T.X1
  MOV AL,ES:[DI].Window.T.X2
  SUB AL,BL
  SUB AL,BH
 {$ENDIF}
END;

{ ������������������������������������������������������������������������
  �                            Fonction WEMaxYTxts                       �
  ������������������������������������������������������������������������


  Propri�taire: Window
  Portabilit�:  Local


  Description
  �����������

   Cette fonction retourne le coordonn�e maximal affichage dans la fen�tre
  de dialogue sur l'axe des Y (vertical).
}

Function WEMaxYTxts;Assembler;ASM
 {$IFDEF FLAT386}
  XCHG EDX,EAX
  MOV AH,[EDX].Window.NotFullScrnY
  SHL AH,1
  MOV AL,[EDX].Window.T.Y2
  SUB AL,[EDX].Window.T.Y1
  SUB AL,AH
 {$ELSE}
  LES DI,Q
  MOV AH,ES:[DI].Window.NotFullScrnY
  SHL AH,1
  MOV AL,ES:[DI].Window.T.Y2
  SUB AL,ES:[DI].Window.T.Y1
  SUB AL,AH
 {$ENDIF}
END;

{����������������������������������������������������������������������
 �                        Proc�dure _WEScrollDn                       �
 ����������������������������������������������������������������������


 Propri�taire: Window
 Portabilit�:  Global


 Description
 �����������

  Cette proc�dure permet d'effectuer une d�filement vers le bas dans la
 fen�tre de la bo�te de dialogue de l'objet �Window�.
}

Procedure _WEScrollDn{Var Q:Window};
{$IFDEF FLAT386}
 Begin
  WEScrollDn(Q,0,0,wnMax,wnMax);
  Q.Y:=Q.MaxY;Q.X:=0;
 End;
{$ELSE}
 Assembler;ASM
   { WEScrollDn(Q,0,0,wnMax,wnMax); }
  LES  DI,Q
  PUSH ES
  PUSH DI
  XOR  AX,AX
  PUSH AX
  PUSH AX
  DEC  AX
  PUSH AX
  PUSH AX
  PUSH CS
  CALL Near Ptr WEScrollDn
   { Q.Y:=Q.MaxY;Q.X:=0 }
  LES DI,Q
  MOV AH,ES:[DI].Window.MaxY
  XOR AL,AL
  MOV Word Ptr ES:[DI].Window.X,AX
 END;
{$ENDIF}

{�����������������������������������������������������������������������
 �                        Proc�dure _WEScrollUp                        �
 �����������������������������������������������������������������������


 Propri�taire: Window
 Portabilit�:  Global


 Description
 �����������

  Cette proc�dure permet d'effectuer une d�filement vers le haut dans la
 fen�tre de la bo�te de dialogue de l'objet �Window�.
}

Procedure _WEScrollUp{Var Q:Wins};
{$IFDEF FLAT386}
 Begin
  WEScrollUp(Q,0,0,wnMax,wnMax);
  Q.Y:=0;Q.X:=0;
 End;
{$ELSE}
 Assembler;ASM
   { WEScrollUp(Q,0,0,wnMax,wnMax); }
  LES  DI,Q
  PUSH ES
  PUSH DI
  XOR  AX,AX
  PUSH AX
  PUSH AX
  DEC  AX
  PUSH AX
  PUSH AX
  PUSH CS
  CALL Near Ptr WEScrollUp
   { Q.Y:=0;Q.X:=0 }
  LES DI,Q
  XOR AX,AX
  MOV Word Ptr ES:[DI].Window.X,AX
 END;
{$ENDIF}

{�����������������������������������������������������������������������
 �                        Proc�dure WEBarSpcHor                        �
 �����������������������������������������������������������������������


 Propri�taire: Window
 Portabilit�:  Global


 Description
 �����������

  Cette proc�dure permet de changer la couleur  d'attribut dans la bande
 sp�cifi� par les coordonn�es texte logique de la fen�tre de la bo�te de
 dialogue de l'objet �Window� avec des espaces.


 Remarque
 ��������

  � Voici le source en langage Pascal pure de cette proc�dure:
    ���������������������������������������������������������������������Ŀ
    � Procedure WEBarSpcHor;Begin                                         �
    �  WEAlignEnd(Q,X2,Y);                                                �
    �  BarSpcHor(WEGetRX1(Q)+X1,WEGetRY1(Q)+Y,WEGetRX1(Q)+X2,Q.CurrColor);�
    � End;                                                                �
    �����������������������������������������������������������������������
}

Procedure WEBarSpcHor{Var Q:Window;X1,Y,X2:Byte};Assembler;ASM
 {$IFDEF FLAT386}
  {$IFNDEF GraphicOS}
   CMP HoleMode,True
   JE  @End
  {$ENDIF}
  XCHG EAX,EDX
  MOV AL,X2
  MOV AH,CL
  CALL AsmWEAlignEnd
  XCHG AX,CX
  CALL AsmWEGetR
  ADD CL,AL
  ADD AL,X1
  PUSH DWord Ptr [EDX].Window.CurrColor
  MOV DL,CH
  ADD DL,AH
  {$IFNDEF GraphicOS}
   CALL BarSpcHorHole
  {$ELSE}
   CALL BarSpcHor
  {$ENDIF}
@End:
 {$ELSE}
  CMP HoleMode,True
  JE  @End
  LES DI,Q
  MOV AL,X2
  MOV AH,Y
  CALL AsmWEAlignEnd
  XCHG AX,CX
  CALL AsmWEGetR
  MOV BL,X1
  ADD BL,AL
  PUSH BX
  MOV BL,CH
  ADD BL,AH
  PUSH BX
  ADD AL,CL
  PUSH AX
  PUSH Word Ptr ES:[DI].Window.CurrColor
  CALL BarSpcHorHole
@End:
 {$ENDIF}
END;

{�������������������������������������������������������������������������
 �                          Proc�dure WEBarTxtHor                        �
 �������������������������������������������������������������������������


 Propri�taire: Window
 Portabilit�:  Global


 Description
 �����������

  Cette proc�dure permet de changer le caract�re  et la couleur d'attribut
 dans la bande sp�cifi� par les coordonn�es texte logique de la fen�tre de
 la bo�te de dialogue de l'objet �Wins�.


 Remarque
 ��������

  � Voici le source en langage Pascal pure de cette proc�dure:
    ��������������������������������������������������������������������Ŀ
    � Procedure WEBarTxtHor;Begin                                        �
    �  WEAlignEnd(Q,X2,Y);                                               �
    �  BarTxtHor(WEGetRX1(Q)+X1,WEGetRY1(Q)+Y,WEGetRX1(Q)+X2,Chr,Q.Kr)   �
    � End;                                                               �
    ����������������������������������������������������������������������
}

Procedure WEBarTxtHor{Var Q:Window;X1,Y,X2:Byte;Chr:Char};
{$IFDEF FLAT386}
 Begin
  WEAlignEnd(Q,X2,Y);
  BarTxtHor(WEGetRX1(Q)+X1,WEGetRY1(Q)+Y,WEGetRX1(Q)+X2,Chr,Q.CurrColor)
 End;
{$ELSE}
 Assembler;ASM
  CMP HoleMode,True
  JE  @End
  LES DI,Q
  MOV AL,X2
  MOV AH,Y
  CALL AsmWEAlignEnd
  XCHG AX,CX
  CALL AsmWEGetR
  MOV BL,X1
  ADD BL,AL
  PUSH BX
  MOV BL,CH
  ADD BL,AH
  PUSH BX
  ADD AL,CL
  PUSH AX
  PUSH Word Ptr Chr
  PUSH Word Ptr ES:[DI].Window.CurrColor
  CALL BarTxtHor
@End:
 END;
{$ENDIF}

{ ������������������������������������������������������������������������
  �                        Proc�duer WEBarSpcHorShade                    �
  ������������������������������������������������������������������������


  Propri�taire: Window
  Portabilit�:  Global


  Description
  �����������

   Cette proc�dure affiche l'ombrage d'une barre de texte dans une fen�tre
  de dialogue.


 Remarque
 ��������

  � Voici l'aspect de cette proc�dure sous forme Pascal classique:
    �������������������������������������������������������������������Ŀ
    � Procedure WEBarSpcHorShade;Var RX1,RY1:Byte;Begin                 �
    �  If X2<250Then Inc(X2);                                           �
    �  WEAlignEnd(Q,X2,Y);                                              �
    �  Dec(X2);RX1:=WEGetR(Q,RY1);                                      �
    �  BarSpcHorShade(RX1+X1,RY1+Y,RX1+X2,Q.CurrColor,Q.Palette.kShade) �
    � End;                                                              �
    ���������������������������������������������������������������������
}

Procedure WEBarSpcHorShade{Var Q:Wins;X1,Y,X2:Byte};
{$IFDEF FLAT386}
 Var
  RX1,RY1:Byte;
 Begin
  If X2<250Then Inc(X2);
  WEAlignEnd(Q,X2,Y);
  Dec(X2);RX1:=WEGetR(Q,RY1);
  BarSpcHorShade(RX1+X1,RY1+Y,RX1+X2,Q.CurrColor,Q.Palette.kShade)
 End;
{$ELSE}
 Assembler;ASM
  LES DI,Q
  MOV AL,X2
  CMP AL,250
  JNB @1
  INC AX
 @1:
  MOV AH,Y
  CALL AsmWEAlignEnd
  XCHG AX,CX
  CALL AsmWEGetR
  MOV BL,X1
  ADD BL,AL
  PUSH BX
  MOV BL,CH
  ADD BL,AH
  PUSH BX
  ADD AL,CL
  DEC AX
  PUSH AX
  PUSH Word Ptr ES:[DI].Window.CurrColor
  PUSH Word Ptr ES:[DI].Window.Palette.kShade
  CALL BarSpcHorShade
 END;
{$ENDIF}

{�����������������������������������������������������������������������
 �                           Proc�dure WEBarSelHor                     �
 �����������������������������������������������������������������������


 Propri�taire: Window
 Portabilit�:  Global


 Description
 �����������

  Cette proc�dure permet de changer  la couleur d'attribut dans la bande
 sp�cifi� par les coordonn�es texte logique de la fen�tre de la bo�te de
 dialogue de l'objet �Window�.


 Remarque
 ��������

  � Voici le source en langage Pascal pure de cette proc�dure:
    ������������������������������������������������������������������Ŀ
    � Procedure WEBarSelHor;Var XM,RX1,RY1:Byte;Begin                  �
    �  If(Y>Q.MaxY)Then Exit;                                          �
    �  X2:=WEAlignEndX(Q,X2);RX1:=WEGetR(Q,RY1);                       �
    �  BarSelHor(RX1+X1,RY1+Y,RX1+X2,Q.Kr)                             �
    � End;                                                             �
    ��������������������������������������������������������������������
}

Procedure WEBarSelHor{Var Q:Wins;X1,Y,X2:Byte};Assembler;ASM
 {$IFDEF FLAT386}
  CMP HoleMode,True
  JE  @End
  XCHG EAX,EDX
  MOV AL,X2
  MOV AH,CL
  CMP AH,[EDX].Window.MaxY
  JA  @End
  CALL AsmWEAlignEnd
  XCHG AX,CX
  CALL AsmWEGetR
  ADD CL,AL
  ADD AL,X1
  PUSH Word Ptr [EDX].Window.CurrColor
  MOV DL,CH
  ADD DL,AH
  CALL BarSelHor
@End:
 {$ELSE}
  CMP HoleMode,True
  JE  @End
  LES DI,Q
  MOV AL,X2
  MOV AH,Y
  CMP AH,ES:[DI].Window.MaxY
  JA  @End
  CALL AsmWEAlignEnd
  XCHG AX,CX
  CALL AsmWEGetR
  MOV BL,X1
  ADD BL,AL
  PUSH BX
  MOV BL,CH
  ADD BL,AH
  PUSH BX
  ADD AL,CL
  PUSH AX
  PUSH Word Ptr ES:[DI].Window.CurrColor
  CALL BarSelHor
@End:
 {$ENDIF}
END;

{�����������������������������������������������������������������������
 �                          Proc�dure _WESetCube                       �
 �����������������������������������������������������������������������


 Propri�taire: Window
 Portabilit�:  Global


 Description
 �����������

  Cette proc�dure permet d'afficher un caract�re avec sont attribut � la
 position texte logique  de la fen�tre  de  bo�te de dialogue de l'objet
 �Window�.


 Remarque
 ��������

  � Voici le code source de cette proc�dure en langage Pascal standard:
    ������������������������������������������������������������������Ŀ
    � Procedure _WESetCube;Begin                                       �
    �  If(Y>Q.MaxY)Then Exit;                                          �
    �  If(X<=Q.MaxX)Then Begin                                         �
    �  (*$IFDEF MaxGraf*)Case(Q.Matrix)of                              �
    �   _6x6: WEPutTxt6x6(Q,X,Y,Chr,Attr);                             �
    �   Else(*$ENDIF*)SetCube(WEGetRX1(Q)+X,WEGetRY1(Q)+Y,Chr,Attr);   �
    �   (*$IFDEF MaxGraf*)End;(*$ENDIF*)                               �
    �  End;                                                            �
    �  Q.X:=X+1;Q.Y:=Y;                                                �
    � End;                                                             �
    ��������������������������������������������������������������������
}

Procedure _WESetCube{Var Q:Wins;X,Y:Byte;Chr:Char;Attr:Byte};Assembler;ASM
 {$IFDEF FLAT386}
  LEA EDX,DWord Ptr Q
  MOV AL,X
  MOV AH,Y
  MOV BX,Word Ptr [EDX].Window.MaxX
  CMP AH,BH
  JA  @Update
  CMP AL,BL
  JA  @Update
   {SetCube(WEGetRX1(Q)+X,WEGetRY1(Q)+Y,Chr,Attr);}
  XCHG AX,CX
  CALL AsmWEGetR
  ADD AX,CX
  CMP HoleMode,True
  JNE @Run
  PUSH AX
   XCHG CX,AX
   CALL NmXTxts
   MUL CH
   AND EAX,0FFFFh
   AND ECX,0FFh
   ADD EAX,ECX
   LEA EDX,Hole
   ADD EDX,EAX
   CMP Byte Ptr [EDX],0
  POP AX
  JNE @UpDate
@Run:
  MOV DL,AH
  MOV CL,Chr
  PUSH DWord Ptr Attr
  CALL SetCube
@Update:
  LEA EDX,DWord Ptr Q
  MOV AL,X
  MOV AH,Y
  INC AX
  MOV Word Ptr [EDX].Window.X,AX
@Exit:
 {$ELSE}
  LES DI,Q
  MOV AL,X
  MOV AH,Y
  MOV BX,Word Ptr ES:[DI].Window.MaxX
  CMP AH,BH
  JA  @Update
  CMP AL,BL
  JA  @Update
   {SetCube(WEGetRX1(Q)+X,WEGetRY1(Q)+Y,Chr,Attr);}
  XCHG AX,CX
  CALL AsmWEGetR
  ADD AX,CX
  CMP HoleMode,True
  JNE @Run
  PUSH AX
   XCHG CX,AX
   CALL NmXTxts
   MUL CH
   XOR CH,CH
   ADD AX,CX
   LES DI,Hole
   ADD DI,AX
   MOV AL,0
   SCASB
  POP AX
  JNE @UpDate
  LES DI,Q
@Run:
  PUSH AX
  MOV AL,AH
  PUSH AX
  PUSH Word Ptr Chr
  PUSH Word Ptr Attr
  CALL SetCube
@Update:
  LES DI,Q
  MOV AL,X
  MOV AH,Y
  INC AX
  MOV Word Ptr ES:[DI].Window.X,AX
@Exit:
 {$ENDIF}
END;

{��������������������������������������������������������������������
 �                          Proc�dure WEClrWn                       �
 ��������������������������������������������������������������������


 Propri�taire: Window
 Portabilit�:  Global


 Description
 �����������

  Cette proc�dure permet d'effacer une zone de la fen�tre de bo�te de
 dialogue de l'objet �Window�.


 Remarque
 ��������

  � Voici le source en langage Pascal pure de cette proc�dure:
    ���������������������������������������������������������������Ŀ
    � Procedure WEClrWn;Var XH,YH:Byte;Begin                        �
    �  If(Y1>Q.MaxY)Then Exit;                                      �
    �  WEAlignEnd(Q,X2,Y2);                                         �
    �  XH:=WEGetR(Q,YH);                                            �
    �  ClrWn(XH+X1,YH+Y1,XH+X2,YH+Y2,Attr)                          �
    � End;                                                          �
    �����������������������������������������������������������������
}

Procedure WEClrWn{Var Q:Wins;X1,Y1,X2,Y2,Attr:Byte};
{$IFDEF FLAT386}
 Var
  XH,YH:Byte;
 Begin
  If(Y1>Q.MaxY)Then Exit;
  WEAlignEnd(Q,X2,Y2);
  XH:=WEGetR(Q,YH);
  ClrWn(XH+X1,YH+Y1,XH+X2,YH+Y2,Attr)
 End;
{$ELSE}
 Assembler;ASM
  LES DI,Q
  MOV DL,Y1
  CMP DL,ES:[DI].Window.MaxY
  JA  @End
  MOV AL,X2
  MOV AH,Y2
  CALL AsmWEAlignEnd
  XCHG AX,CX
  CALL AsmWEGetR
  MOV BL,X1
  ADD BL,AL
  PUSH BX
  MOV BL,DL
  ADD BL,AH
  PUSH BX
  ADD AL,CL
  PUSH AX
  MOV BL,CH
  ADD BL,AH
  PUSH BX
  PUSH Word Ptr Attr
  CALL ClrWnHole
 @End:
 END;
{$ENDIF}

{����������������������������������������������������������������������
 �                            Proc�dure WEGetStr                      �
 ����������������������������������������������������������������������


 Propri�taire: Window
 Portabilit�:  Global


 Description
 �����������

  Cette fonction permet d'extraire un message �crit � l'�cran et retour
 cette cha�ne de caract�res.


 Remarque
 ��������

  � Voici le source en langage Pascal pure de cette fonction:
    �����������������������������������������������������������������Ŀ
    � Function WEGetStr;Label Break;Var S:String;I:Byte;C:Char;Begin  �
    �  S:='';                                                         �
    �  For I:=0to(Q.MaxX)do Begin                                     �
    �   C:=GetChr(WEGetRX1(Q)+X+I,WEGetRY1(Q)+Y);                     �
    �   If C=#0Then Goto Break;                                       �
    �   IncStr(S,C)                                                   �
    �  End;                                                           �
    � Break:                                                          �
    �  WEGetStr:=S                                                    �
    � End;                                                            �
    �������������������������������������������������������������������
}

Function WEGetStr{Var Q:Window;X,Y:Byte):String};
Label Break;
Var
 S:String;
 I:Byte;
 C:Char;
Begin
 S:='';
 For I:=0to(Q.MaxX)do Begin
  ASM
    {C:=GetChr(WEGetRX1(Q)+X+I,WEGetRY1(Q)+Y);}
   LES DI,Q
   CALL AsmWEGetR
   ADD AL,X
   ADD AL,I
   PUSH AX
   MOV BL,Y
   ADD BL,AH
   PUSH BX
   CALL GetChr
   MOV C,AL
  END;
  If C=#0Then Goto Break;
  IncStr(S,C)
 End;
Break:
 WEGetStr:=S
End;

{ �������������������������������������������������������������������
  �                        Proc�dure WECloseCur                     �
  �������������������������������������������������������������������


  Propri�taire: Window


  Description
  �����������

   Cette proc�dure permet de d�sactiver le curseur et de restituer le
  contenue o�  se  trouve  le curseur  en mode graphique pr�c�damment
  sauvegarder par �WESimpleCur�.
}

Procedure WECloseCur{Var Q:Wins};Begin
 CloseCur;
 If(IsGrf)Then WEPopCur(Q)
End;

{ ����������������������������������������������������������������������
  �                         Proc�dure WESimpleCur                      �
  ����������������������������������������������������������������������


  Propri�taire: Window


  Description
  �����������

   Cette proc�dure permet  de r�activer le curseur  et de sauvegarder le
  contenue o� se trouve le curseur en mode graphique pour ne pas laisser
  de trace.
}

Procedure WESimpleCur{Var Q:Wins};Begin
 SimpleCur;
 If(IsGrf)Then WEPushCur(Q)
End;

{$I WEPutChG.Inc}

Procedure WEBar{Var Q:Window};
Const
 MatrixRobotic:Array[0..4]of Byte=(36,38,40,38,37);
 MatrixRobotic16:Array[0..4]of Byte=(0,7,15,7,0);
Var
 J:Word;
 MatrixTmp:Array[0..4]of Word;
 G:GraphBoxRec;
Begin
 If(IsGrf)and(WinType=Robotic)and Not(HoleMode)Then Begin
  G.Y1:=GetRawY(WEGetRY1(Q));
  G.X2:=(Q.T.X2+(Byte(Q.NotFullScrnX)xor 1))shl 3;
  If(Q.BarMouseRight)Then Dec(G.X2,9);
  G.X1:=((Q.T.X1+Byte(Q.NotFullScrnX))shl 3)-1;
  Case(BitsPerPixel)of
   8:For J:=0to 4do Begin
    __PutLnHor(G,MatrixRobotic[J]);
    Inc(G.Y1);
   End;
   4:For J:=0to 4do Begin
    __PutLnHor(G,MatrixRobotic16[J]);
    Inc(G.Y1);
   End;
   15..24:Begin
    MatrixTmp[0]:=RGB2Color(64,64,64);
    MatrixTmp[1]:=RGB2Color(96,96,96);
    MatrixTmp[2]:=RGB2Color(160,160,160);
    MatrixTmp[3]:=MatrixTmp[1];
    MatrixTmp[4]:=MatrixTmp[0];
    For J:=0to 4do Begin
     __PutLnHor(G,MatrixTmp[J]);
     Inc(G.Y1);
    End;
   End;
  End;
 End;
End;

{������������������������������������������������������������������������
 �                             Proc�dure WEDone                         �
 ������������������������������������������������������������������������


 Propri�taire: Wins


 Description
 �����������

  Cette proc�dure termine la fen�tre de dialogue et restitue le fond s'il
 avait �t�  sauvegard�.  Il n'est plus possible  d'utiliser la fen�tre de
 dialogue apr�s cette appel.
}

Procedure WEDone{Var Q:Wins};
{$IFDEF Real}
 Assembler;ASM
  JMP Near Ptr WEPopWn[3]
 END;
{$ELSE}
 Begin
  WEPopWn(Q)
 End;
{$ENDIF}

{����������������������������������������������������������������������
 �                            Fonction PutImage                       �
 ����������������������������������������������������������������������


 Description
 �����������

  Cette fonction permet de restaurer une image de grande dimension dans
 n'importe quel ressource  de masse  de l'application.
}

Function PutImage{X1,Y1,X2,Y2:Integer;Var Q:ImgRec):Boolean};
{$IFNDEF __Windows__}
 Label BreakAll;
 Var
  B,Step,Plus,I,TB3:Word;
  GBuf:^TByte;
  Work:Record
   J:Word;              { Compteur de boucle }
   TB1,TB2:Word;        { Base 1 et 2 }
   Ofs:Word;            { D�placement sur un segment }
   OfsT:LongInt;        { D�placement absolue }
   h:LongInt;
  End;
  Buf:Array[0..2047]of Byte;
{$ENDIF}
Begin
 {$IFDEF __Windows__}
  PutImage:=True;
 {$ELSE}
  PutImage:=False;
  If Q.Length=0Then Exit;
  FillClr(Work,SizeOf(Work));
  If(X1>X2)Then SwapInt(X1,X2);
  If(Y1>Y2)Then SwapInt(Y1,Y2);
  If(Q.X.Handle<>$FFFF)Then Begin
   If(Q.AllScreen)Then Begin
    Plus:=Q.SizeText+SizeOf(Palette256RGB);
    XGetAbsRec(Q.X,Q.X.Size-Plus+SizeOf(Palette256RGB),Plus-SizeOf(Palette256RGB),Mem[GetVideoSegBuf:0]);
    XGetAbsRec(Q.X,Q.X.Size-Plus,SizeOf(Palette256RGB),Buf);
    SetPalRGB(Buf,0,256);
   End;
   Case(BitsPerPixel)of
    1:Begin
     B:=Q.X.Size;GBuf:=MemAlloc(B);
     If(GBuf<>NIL)Then Begin
      XGetAbsRec(Q.X,0,B,GBuf^);
      PutSmlImg(X1,Y1,X2,Y2,GBuf^);
      FreeMemory(GBuf,B);
      PutImage:=True;
      Exit;
     End;
     Step:=Q.Length shr 3;
     B:=X1 shr 3;
     ASM
      CALL GetVideoSeg
      MOV GBuf.Word[2],AX
     END;
     For Work.J:=0to Q.Height-1do Begin
      Word(GBuf):=GetRealRawYWord(Work.J+Y1)+B;
      XGetAbsRec(Q.X,Work.Ofs,Step,GBuf^);
      Inc(Work.Ofs,Step);
     End;
    End;
    4:Begin
     If LongRec(Q.X.Size).Hi=0Then Begin
      B:=Q.X.Size;
      If B and 1=1Then Inc(B);
      GBuf:=MemAlloc(B);
      If(GBuf<>NIL)Then Begin
       XGetAbsRec(Q.X,0,B,GBuf^);
       PutSmlImg(X1,Y1,X2,Y2,GBuf^);
       FreeMemory(GBuf,B);
       PutImage:=True;
       Exit;
      End;
     End;
     Step:=(Q.Length shr 1)+1;
     If Step and 1=1Then Inc(Step);
     For Work.J:=Y1 to(Y2)do Begin
      XGetAbsRec(Q.X,Work.OfsT,Step,Buf);
      PutSmlImg(X1,Work.J,X2,Work.J,Buf);
      Inc(Work.OfsT,Step);
     End;
    End;
    Else Begin
     If(Q.Length=320)and(Q.Height=200)Then XGetAbsRec(Q.X,0,64000,Mem[GetVideoSeg:0])
      Else
     Begin
      If BitsPerPixel in[15,16]Then Begin
       X1:=X1 and$FFF8;
       X2:=X2 or 7;
      End;
      While Work.TB2+Q.BytesPerLine<=SizeOf(Buf)do Begin
       Inc(Work.TB2,Q.BytesPerLine);
       Inc(Work.TB1);
      End;
      Repeat
       XGetAbsRec(Q.X,Work.h,Work.TB2,Buf);
       Inc(Work.h,LongInt(Work.TB2));
       TB3:=0;
       For I:=0to Work.TB1-1do Begin
        ClrLnHorImg(X1,Y1+Work.J,Q.Length,BitsPerPixel,Buf[TB3]);
        Inc(TB3,Q.BytesPerLine);
        Inc(Work.J);
        If(Work.J>=Q.Height)Then Goto BreakAll;
       End;
      Until False;
BreakAll:
     End;
    End;
   End;
   PutImage:=True
  End;
 {$ENDIF}
End;

{����������������������������������������������������������������������
 �                        Fonction RestoreImage                       �
 ����������������������������������������������������������������������


 Description
 �����������

  Cette fonction permet de restaurer une image de grande dimension dans
 n'importe quel ressource  de masse  de l'application  et lib�rer cette
 m�me ressource par d'autre sauvegarde.
}

Function RestoreImage{X1,Y1,X2,Y2:Integer;Var Q:ImgRec):Boolean};Begin
 RestoreImage:=False;
 If Not PutImage(X1,Y1,X2,Y2,Q)Then Exit;
 RestoreImage:=XFreeMem(Q.X)
End;

{������������������������������������������������������������������������
 �                           Fonction _SaveImage                        �
 ������������������������������������������������������������������������


 Description
 �����������

  Cette fonction permet de sauvegarder une image de grande dimension dans
 une ressource de masse particuli�re de l'application.
}

Function _SaveImage;
{$IFNDEF __Windows__}
 Label Over;
 Var
  B,Step,I,TB3:Word;
  GBuf:^TByte;
  P,XJ:LongInt;
  Work:Record
   Plus:Word;           { Taille de donn�e suppl�mentaire }
   J:Word;              { Compteur de boucle }
   TB1,TB2:Word;        { Base 1 et 2 }
   Ofs:Word;            { D�placement sur un segment }
   OfsT:LongInt;        { D�placement absolue }
  End;
  Buf:Array[0..2047]of Byte;
{$ENDIF}
Begin
 {$IFDEF __Windows__}
  _SaveImage:=True;
 {$ELSE}
  _SaveImage:=False;
  If(X1>X2)Then SwapInt(X1,X2);
  If(Y1>Y2)Then SwapInt(Y1,Y2);
  FillClr(Work,SizeOf(Work));
  Q.BitsPerPixel:=GetBitsPerPixel;
  Q.Length:=X2-X1+1;
  Q.Height:=Y2-Y1+1;
  Q.AllScreen:=(Q.Length=NmXPixels)and(Q.Height=NmYPixels)and(Resource=rmAllResSteady);
  If(Q.AllScreen)Then Begin
   Q.SizeText:=(NmXTxts*NmYTxts)shl 1;
   Work.Plus:=Q.SizeText+SizeOf(Palette256RGB);
  End;
  Case(GetBitsPerPixel)of
   1:Begin
    Step:=Q.Length shr 3;
    P:=Mul2Word(Step,Q.Height);
    If XAllocMem(Resource,P+Work.Plus,Q.X)Then Begin
     GBuf:=MemAlloc(P);
     If(GBuf<>NIL)Then Begin
      GetSmlImg(X1,Y1,X2,Y2,GBuf^);
      XSetAbsRec(Q.X,0,P,GBuf^);
      FreeMemory(GBuf,P);
      _SaveImage:=True;
      Exit;
     End;
     B:=X1 shr 3;
     ASM
      CALL GetVideoSeg
      MOV GBuf.Word[2],AX
     END;
     For Work.J:=0to Q.Height-1do Begin
      Word(GBuf):=GetRealRawYWord(Work.J+Y1)+B;
      XSetAbsRec(Q.X,Work.Ofs,Step,GBuf^);
      Inc(Work.Ofs,Step);
     End;
     _SaveImage:=True
    End;
   End;
   4:Begin
    P:=Mul2Word((Q.Length shr 1)+4,Q.Height);
    If P and 1=1Then Inc(P,LongInt(1));
    If XAllocMem(Resource,P+Work.Plus,Q.X)Then Begin
     If LongRec(P).Hi=0Then Begin
      GBuf:=MemAlloc(P);
      If(GBuf<>NIL)Then Begin
       GetSmlImg(X1,Y1,X2,Y2,GBuf^);
       XSetAbsRec(Q.X,0,P,GBuf^);
       FreeMemory(GBuf,P);
       _SaveImage:=True;
       Goto Over;
      End;
     End;
     Step:=(Q.Length shr 1)+1;
     If Step and 1=1Then Inc(Step);
     For Work.J:=Y1 to(Y2)do Begin
      GetSmlImg(X1,Work.J,X2,Work.J,Buf);
      XSetAbsRec(Q.X,Work.OfsT,Step,Buf);
      Inc(Work.OfsT,Step);
     End;
     _SaveImage:=True
    End;
   End;
   Else Begin
    Q.BytesPerLine:=Q.Length;
    If BitsPerPixel in[15,16]Then Begin
     X1:=X1 and$FFF8;
     X2:=X2 or 7;
     Q.Length:=X2-X1+1;
     Q.BytesPerLine:=Q.Length shl 1;
    End;
    XJ:=Mul2Word(Q.BytesPerLine,Q.Height);
    If XAllocMem(Resource,XJ+Work.Plus,Q.X)Then Begin
     If(CurrVideoMode=$13)and(XJ=64000)Then XSetAbsRec(Q.X,0,XJ,Mem[GetVideoSeg:0])
      Else
     Begin
      While Work.TB2+Q.BytesPerLine<=SizeOf(Buf)do Begin
       Inc(Work.TB2,Q.BytesPerLine);
       Inc(Work.TB1);
      End;
      XJ:=0;
      Repeat
       TB3:=0;
       For I:=0to Work.TB1-1do Begin
        GetLnHorImg(X1,Y1+Work.J,X2,Buf[TB3]);
        Inc(TB3,Q.BytesPerLine);
        Inc(Work.J);
        If(Work.J>=Q.Height)Then Break;
       End;
       XSetAbsRec(Q.X,XJ,TB3,Buf);
       If(Work.J>=Q.Height)Then Break;
       Inc(XJ,Long(TB3));
      Until False;
     End;
     _SaveImage:=True
    End
   End
  End;
 Over:
  If Work.Plus>0Then Begin
   XSetAbsRec(Q.X,Q.X.Size-Work.Plus+SizeOf(Palette256RGB),Work.Plus-SizeOf(Palette256RGB),Mem[GetVideoSegBuf:0]);
   GetPaletteRGB(Buf,0,256);
   XSetAbsRec(Q.X,Q.X.Size-Work.Plus,SizeOf(Palette256RGB),Buf);
  End;
 {$ENDIF}
End;

{������������������������������������������������������������������������
 �                            Fonction SaveImage                        �
 ������������������������������������������������������������������������


 Description
 �����������

  Cette fonction permet de sauvegarder une image de grande dimension dans
 n'importe quel ressource de masse de l'application.
}

Function SaveImage{X1,Y1,X2,Y2:Integer;Var Q:ImgRec):Boolean};Begin
 SaveImage:=_SaveImage(X1,Y1,X2,Y2,Q,rmAllRes)
End;

{�����������������������������������������������������������������������
 �                            Proc�dure PopScr                         �
 �����������������������������������������������������������������������


 Description
 �����������

  Cette proc�dure restitue le contenu d'un �cran � partir d'une variable
 objet graphiques adapt� aussi bien aux �crans texte que graphique.
}

Procedure PopScr{Var M:ImgRec};
{$IFNDEF __Windows__}
 Label 1,2,_XFreeMem;
 Var
  Base,J:Word;
  x0:Record
   X,Y:Byte;
  End;
{$ENDIF}
Begin
 {$IFNDEF __Windows__}
  If(IsGraf)Then Begin
   If M.BitsPerPixel in[0,255]Then Begin
    SetVideoSize(0,M.Length,M.Height);
    Goto 2
   End;
   If(PrimCardCat=cvnCGA)Then Begin
    If M.X.Handle<>$FFFFThen Begin
     XGetRec(M.X,0,M.Length,Mem[GetVideoSeg:0]);
     Goto _XFreeMem;
    End
   End
    Else
   Begin
    If(M.BitsPerPixel<>BitsPerPixel)or
      (M.Length<>NmXPixels)or(M.Height<>NmYPixels)Then
       SetVideoSize(M.BitsPerPixel,M.Length,M.Height);
  1:SetLuxe;
    RestoreImage(0,0,GetMaxXPixels,GetMaxYPixels,M);
    __InitMouse
   End;
  End
   Else
  Begin
   If M.X.Handle<>$FFFFThen Begin
    If Not(IsGrf)and(M.BitsPerPixel in[1..254])Then Begin
     SetVideoSize(M.BitsPerPixel,M.Length,M.Height);
     CloseCur;
     Goto 1;
    End;
    If(M.Length>NmXTxts)Then SetVideoSize(0,M.Length,M.Height);
  2:If M.BitsPerPixel=255Then SetLuxe;
    If(NmXTxts<>M.Length)Then Begin
     {$IFDEF HeapVram}
      HeapVram:=False;
     {$ENDIF}
     ClrScrBlack;
     If M.Length<>0Then For J:=0to DivLong(M.SizeText shr 1,M.Length)do Begin
      XGetRec(M.X,J,M.Length shl 1,Mem[GetVideoSeg:BytesPerLn*J]);
     End;
     { Restitution des donn�es la r�gion BIOS concernant le vid�o...}
     {$IFNDEF Windows}
      XGetAbsRec(M.X,M.SizeText+2,SizeOfVideoBios-2,
                 {$IFDEF Real}
                  Mem[0:$44A+2]
                 {$ELSE}
                  Mem[_0040:$4A+2]
                 {$ENDIF});
     {$ENDIF}
    End
     Else
    Begin
     XGetRec(M.X,0,M.SizeText,Mem[GetVideoSeg:0]);
     Base:=(NmXTxts*NmYTxts)shl 1;
     If Not(IsGrf)Then Begin
      If(Base>M.SizeText)Then Begin
       FillWord(Mem[GetVideoSeg:M.SizeText],Base-M.SizeText,$720);
      End;
     End;
     { Restitution des donn�es la r�gion BIOS concernant le vid�o...}
     {$IFNDEF Windows}
      XGetAbsRec(M.X,M.X.Size-SizeOfVideoBios,SizeOfVideoBios,
                 {$IFDEF NotReal}
                  Mem[_0040:$4A]
                 {$ELSE}
                  CurrNmXTxts
                 {$ENDIF});
     {$ENDIF}
    End;
     {Actualise le curseur...}
    {$IFNDEF Windows}
     ASM
       { x0.X:=Mem[_0040:$50];x0.Y:=Mem[_0040:$51]; }
      {$IFOPT G+}
       {$IFDEF DPMI}
        MOV ES,_0040
       {$ELSE}
        PUSH _0040
        POP ES
       {$ENDIF}
       MOV AX,ES:[50h]
      {$ELSE}
       XOR AX,AX
       MOV ES,AX
       MOV AX,ES:[450h]
      {$ENDIF}
      MOV Word Ptr x0,AX
     END;
     SetCur(Mem[_0040:$61],Mem[_0040:$60]);
     SetCurPos(x0.X,x0.Y);
    {$ENDIF}
 _XFreeMem:
    XFreeMem(M.X);
    Exit
   End
    Else
   GetSysErr:=errHandleNotFound;
  End;
 {$ENDIF}
End;

{������������������������������������������������������������������
 �                        Proc�dure PushScr                       �
 ������������������������������������������������������������������


 Description
 �����������

  Cette proc�dure permet de sauvegarder l'�cran ainsi que tous les
 informations n�cessaire � la restauration du mode. On parle aussi
 bien de son contenu de l'�tat �cran ici.
}

Procedure PushScr{Var M:ImgRec};
{$IFNDEF __Windows__}
 Var
  Size:Word;
{$ENDIF}
Begin
 GetSysErr:=0;
 {$IFNDEF __Windows__}
  If(IsGraf)Then Begin
   If(PrimCardCat=cvnCGA)Then Begin
    M.BitsPerPixel:=BitsPerPixel;
    M.Height:=1;
    Case(GetVideoMode)of
     vmGrf320x200c16:M.Length:=32768;
     vmGrf640x200c16:M.Length:=65520;
     Else M.Length:=16384;
    End;
    If XAllocMem(rmAllResSteady,M.Length,M.X)Then Begin
     XSetRec(M.X,0,M.Length,Mem[GetVideoSeg:0]);
     Exit
    End
   End
    Else
   _SaveImage(0,0,GetMaxXPixels,GetMaxYPixels,M,rmAllResSteady)
  End
   Else
  Begin
   If(IsLuxe)Then M.BitsPerPixel:=255
             Else M.BitsPerPixel:=0;
   M.Length:=NmXTxts;M.Height:=NmYTxts;
   If M.Length=0Then Begin
    M.Length:=CurrNmXTxts;
    M.Height:=CurrMaxYTxts+1;
   End;
   {$IFDEF HeapVram}
    If(HeapVram)Then Size:=32768+SizeOfVideoBios Else
   {$ENDIF}
   M.SizeText:=(M.Length*M.Height)shl 1;
   Size:=M.SizeText+SizeOfVideoBios;
   If XAllocMem(rmAllResSteady,Size,M.X)Then Begin
    XSetRec(M.X,0,M.SizeText,Mem[GetVideoSeg:0]);
    XSetPos(M.X,Size-SizeOfVideoBios);
    {$IFNDEF Windows}
     _XSetRec(M.X,SizeOfVideoBios,{$IFDEF NotReal}
                                   Mem[_0040:$4A]
                                  {$ELSE}
                                   CurrNmXTxts
                                  {$ENDIF});
    {$ENDIF}
   End
    Else
   ErrNoMsgOk(GetSysErr)
  End
 {$ENDIF}
End;

{������������������������������������������������������������������������
 �                          Fonction KeyCode2Str                        �
 ������������������������������������������������������������������������


 Description
 �����������

  Cette fonction retourne le code de la touche sp�cifi� avec Scan Code et
 code ASCII en une cha�ne de caract�res.
}

Function KeyCode2Str{Code:Word):String};Begin
 {$IFDEF __Windows__}
  KeyCode2Str:=''
 {$ELSE}
  If Not(LoadKeyboardBiosTable)Then Begin
   DBOpenServerName(ChantalServer,'CHANTAL:/Materiel/Clavier/TableBIOS.Dat');
   DBCopyToMemory(ChantalServer,KeyboardBiosTable);
   LoadKeyboardBiosTable:=True;
  End;
  If DBLocateAbsIM(KeyboardBiosTable,0,Code,[])Then Begin
   Inc(PtrRec(KeyboardBiosTable.CurrRec).Ofs,SizeOf(Word));
   KeyCode2Str:=KeyboardBiosTable.CurrRec.Str^;
  End
   Else
  Begin
   If IsAltCode(Code)Then KeyCode2Str:='Alt+'+AltCode2Ascii(Code)Else
   If Byte(Code)<32Then KeyCode2Str:='Ctrl+'+CtrlCode2Ascii(Code)
                   Else KeyCode2Str:=Chr(Code)
  End;
 {$ENDIF}
End;

{�������������������������������������������������������������ķ}
{�                   O b j e t  P u l l M e n u                �}
{�������������������������������������������������������������ͼ}

{����������������������������������������������������������������������������
 �                             Proc�dure PMAddBarItem                       �
 ����������������������������������������������������������������������������


 Propri�taire: PullMnu


 Description
 �����������

  Cette proc�dure permet d'additionner une barre s�paratrice dans la position
 courante de la construction du menu principal.


 Remarques
 ���������

  � Lorsque la directive de compilation �LuxeExtra� est d�fini, c'est que cet
    proc�dure doit support� l'option de descriptions dans le bas de l'�cran.

  � Dans le cas de la directive de compilation conditionnel �MultiMenu�, elle
    indique � la proc�dure d'utiliser un objet global et non autonome pour la
    construction du menu principal.
}

Procedure PMAddBarItem{(*$IFDEF MultiMenu*)(Var MainMenu:PullMnu)(*$ENDIF*)};
{$IFDEF FLAT386}
 Begin
  PMAddFullItem({$IFDEF MultiMenu}MainMenu,{$ENDIF}
                NIL,0,0,NIL{$IFDEF LuxeExtra},NIL{$ENDIF});
 End;
{$ELSE}
 Assembler;ASM
  XOR AX,AX
  {$IFDEF MultiMenu}
   PUSH Word Ptr MainMenu[2]
   PUSH Word Ptr MainMenu
  {$ENDIF}
  PUSH AX
  PUSH AX
  PUSH AX
  PUSH AX
  PUSH AX
  PUSH AX
  {$IFDEF LuxeExtra}
   PUSH AX
   PUSH AX
  {$ENDIF}
  PUSH CS
  CALL Near Ptr PMAddFullItem
 END;
{$ENDIF}

{����������������������������������������������������������������������������
 �                            Proc�dure PMAddFullItem                       �
 ����������������������������������������������������������������������������


 Propri�taire: PullMnu


 Description
 �����������

  Cette proc�dure permet d'additionner un item avec tous ces d�tailles intime
 dans la position courante de la construction du menu principal.


 Remarques
 ���������

  � Lorsque la directive de compilation �LuxeExtra� est d�fini, c'est que cet
    proc�dure doit support� l'option de descriptions dans le bas de l'�cran.

  � Dans le cas de la directive de compilation conditionnel �MultiMenu�, elle
    indique � la proc�dure d'utiliser un objet global et non autonome pour la
    construction du menu principal.
}

Procedure PMAddFullItem{(*$IFDEF MultiMenu*)Var MainMenu:PullMnu;(*$ENDIF*)Option:PChar;
          KeyFunc,RtnCode:Word;SubMenu:Pointer(*$IFDEF LuxeExtra*);PChr:PChar(*$ENDIF*)};
Var
 Chr:Char;
 TStr:String;
 BPull:PullMnuItem;
Begin
 TStr:=StrUp(SearchHigh(Systex.PChr(Option)));
 If TStr<>''Then Chr:=TStr[1]
            Else Chr:=#0;
 FillClr(BPull,SizeOf(BPull));
 BPull.Option:=Systex.PChr(Option);
 BPull.KeyFunc:=KeyFunc;
 BPull.RtnCode:=RtnCode;
 BPull.HighChar:=Chr;
 BPull.SubMenu:=SubMenu;
 {$IFDEF LuxeExtra}
  PChar(BPull.PSwitch):=PChr;
 {$ENDIF}
 PMAlloc({$IFDEF MultiMenu}MainMenu,{$ENDIF}BPull)
End;

{��������������������������������������������������������������������������
 �                          Proc�dure PMAddItem                           �
 ��������������������������������������������������������������������������


 Propri�taire: PullMnu


 Description
 �����������

  Cette proc�dure permet d'ins�rer un item avec  que son nom,  son code, et
 son message d'aide comme param�tre d'information dans la position courante
 de la construction du menu principal.


 Remarques
 ���������

  � Lorsque la directive de compilation  �LuxeExtra� est d�fini,  c'est que
    cet proc�dure  doit support�  l'option  de descriptions  dans le bas de
    l'�cran.

  � Dans le cas  de la directive  de compilation conditionnel  �MultiMenu�,
    elle indique � la proc�dure d'utiliser  un objet global et non autonome
    pour la construction du menu principal.
}

Procedure PMAddItem{(*$IFDEF MultiMenu*)Var MainMenu:PullMnu;(*$ENDIF*)
          Option:PChar;RtnCode:Word(*$IFDEF LuxeExtra*);PChr:PChar(*$ENDIF*)};Begin
 PMAddFullItem({$IFDEF MultiMenu}MainMenu,{$ENDIF}Option,kbNoKey,
               RtnCode,NIL{$IFDEF LuxeExtra},PChr{$ENDIF})
End;

{��������������������������������������������������������������������������
 �                         Proc�dure PMAddItemKey                         �
 ��������������������������������������������������������������������������


 Propri�taire: PullMnu


 Description
 �����������

  Cette proc�dure permet d'ins�rer un item avec que son nom,  son code,  sa
 combinaison  clavier  ainsi   que  son  message   d'aide  comme  param�tre
 d'information  dans la  position  courante  de  la  construction  du  menu
 principal.


 Remarques
 ���������

  � Lorsque la directive de compilation  �LuxeExtra� est d�fini,  c'est que
    cet proc�dure  doit support�  l'option  de descriptions  dans le bas de
    l'�cran.

  � Dans le cas  de la directive  de compilation conditionnel  �MultiMenu�,
    elle indique � la proc�dure d'utiliser  un objet global et non autonome
    pour la construction du menu principal.
}

Procedure PMAddItemKey{(*$IFDEF MultiMenu*)Var MainMenu:PullMnu;(*$ENDIF*)Option:PChar;
          KeyFunc,RtnCode:Word(*$IFDEF LuxeExtra*);PChr:PChar(*$ENDIF*)};Begin
 PMAddFullItem({$IFDEF MultiMenu}MainMenu,{$ENDIF}Option,KeyFunc,
               RtnCode,NIL{$IFDEF LuxeExtra},PChr{$ENDIF})
End;

{��������������������������������������������������������������������������
 �                        Proc�dure PMAddItemSwitch                       �
 ��������������������������������������������������������������������������


 Propri�taire: PullMnu


 Description
 �����������

  Cette proc�dure  permet  d'ins�rer  un item avec  que son nom,  son code,
 validation d'item  (on/off) ainsi que son message d'aide  comme  param�tre
 d'information  dans la  position  courante  de  la  construction  du  menu
 principal.


 Remarques
 ���������

  � Lorsque la directive de compilation  �LuxeExtra� est d�fini,  c'est que
    cet proc�dure  doit support�  l'option  de descriptions  dans le bas de
    l'�cran.

  � Dans le cas  de la directive  de compilation conditionnel  �MultiMenu�,
    elle indique � la proc�dure d'utiliser  un objet global et non autonome
    pour la construction du menu principal.
}

Procedure PMAddItemSwitch{(*$IFDEF MultiMenu*)Var MainMenu:PullMnu;(*$ENDIF*)
          Option:PChar;Var Value;Switch:PullSwitchPtr;RtnCode:Word};
Var
 Chr:Char;
 TStr:String;
 BPull:PullMnuItem;
Begin
 TStr:=StrUp(SearchHigh(PChr(Option)));
 If TStr<>''Then Chr:=TStr[1]
            Else Chr:=#0;
 FillClr(BPull,SizeOf(BPull));
 BPull.Option:=PChr(Option);
 BPull.RtnCode:=RtnCode;
 BPull.HighChar:=Chr;
 BPull.Switch:=@Value;
 {$IFDEF LuxeExtra}
  BPull.PSwitch:=Switch;
 {$ENDIF}
 PMAlloc({$IFDEF MultiMenu}MainMenu,{$ENDIF}BPull)
End;

{����������������������������������������������������������������������
 �                        Proc�dure PMAddMnu                          �
 ����������������������������������������������������������������������


 Propri�taire: PullMnu


 Description
 �����������

  Cette proc�dure permet l'ajoute d'un menu � l'ensemble d�j� existant.
}

Procedure PMAddMnu{(*$IFDEF MultiMenu*)Var MainMenu:PullMnu;(*$ENDIF*)Mnu:PChar};
Var
 Work:Record
  Code:Word;
  BMenu:MainMnuRec;
 End;
 Ptr:Pointer;
 TStr:String;
Begin
 FillClr(Work,SizeOf(Work));
 TStr:=StrUp(SearchHigh(PChr(Mnu)));
 If TStr<>''Then Work.Code:=Ascii2AltCode(TStr[1]);
 Work.BMenu.Title:=PChr(Mnu);
 Work.BMenu.KeyCode:=Work.Code;
 Ptr:=ALAdd(MainMenu.Mnu,SizeOf(MainMnuRec));
 If(Ptr=NIL)Then Exit;
 MoveLeft(Work.BMenu,Ptr^,SizeOf(MainMnuRec))
End;

{�����������������������������������������������������������������������
 �                          Proc�dure PMAlloc                          �
 �����������������������������������������������������������������������


 Propri�taire: PullMnu


 Description
 �����������

  Cette proc�dure permet d'allouer un nouvel item dans le menu d�roulant
 � la position courante.
}

Procedure PMAlloc;
Var
 {$IFDEF MultiMenu}
  TMenu:MainMnuPtr;
 {$ENDIF}
 TPull:^PullSubMnu;
Begin
 If ALIsEmpty({$IFDEF MultiMenu}Q{$ELSE}MainMenu{$ENDIF}.Mnu)Then Exit;
 {$IFDEF MultiMenu}
  TMenu:=_RBGetBuf(Q.Mnu,rbMax);TPull:=@TMenu^.Lst;
 {$ELSE}
  TPull:=@MainMnuPtr(MainMenu.Mnu.EndLsPtr^.Buf)^.Lst;
 {$ENDIF}
 SMAlloc(TPull^,BPull)
End;

{���������������������������������������������������������������������������
 �                            Destruteur PMDone                            �
 ���������������������������������������������������������������������������


 Portabilit�:  Global
 Propri�taire: PullMnu


 Description
 �����������

  Ce destructeur lib�rer toute la m�moire ayant �t� utilis� par l'allocation
 de chacun des items du menu d�roulant principal.
}

Procedure PMDone{(*$IFDEF MultiMenu*)(Var MainMenu:PullMnu)(*$ENDIF*)};
{$IFNDEF Windows}
 Var
  TPull:PullMnuPtr;
  TMenu:MainMnuPtr;
  I:Integer;
{$ENDIF}
Begin
 {$IFNDEF Windows}
  For I:=0to MainMenu.Mnu.Count-1do Begin
   TMenu:=_ALGetBuf(MainMenu.Mnu,I);TPull:=TMenu^.Lst;
   While(TPull<>NIL)do Begin
    FreeMemory(TPull,SizeOf(TPull^));
    TPull:=TPull^.Next;
   End
  End;
  ALDone(MainMenu.Mnu);
  ALInit(MainMenu.Mnu);
 {$ENDIF}
End;

{���������������������������������������������������������������������������
 �                           Proc�dure SetAllKrMnu                         �
 ���������������������������������������������������������������������������


 Portabilit�: Local


 Description
 �����������

  Cette proc�dure permet de fixer les couleurs utilis�es pour l'affichage du
 menu d�roulant principal.
}

Procedure SetAllKrMnu;Near;Begin
 SetAllKr(CurrKrs.Menu.High,CurrKrs.Menu.Normal)
End;

{������������������������������������������������������������������������
 �                          Fonction PMExecMnu                          �
 ������������������������������������������������������������������������


 Propri�taire: PullMnu


 Description
 �����������

   Cette fonction permet � l'utilisateur de choisir un item � partir d'un
  menu d�roulant.
}

Function PMExecMnu{(*$IFDEF MultiMenu*)Var MainMenu:PullMnu;(*$ENDIF*)
                   X,Y:Byte;List:PullMnuPtr;Var P:Byte):Word};
{$IFNDEF __Windows__}
 Label 2,3,4,MsXit,Xit;
 Const
  Stage:Integer=-1;
 Var
  Line:LineImage;
  Image,LW:Window;
  Actif:^TBool;
  K,IW,TL,J,Z,BM:Word;
  Ok:Boolean;
  TM,TM2:MainMnuPtr;
  X1,Y1,IX2,X2,Y2,XM,YM,L,I,OMX,OMY,MX,MY,P1,Level:Byte;
  Chr:Char Absolute K;
  TList:PullMnuPtr;
  TStr:String;
  Kr:MtxColors;
  OldWinType:WinModelType;
  G:GraphBoxRec;

  Procedure BarSel;
  Var
   I:Byte;
  Begin
   LIBarSel(Line);
   {$IFDEF LuxeExtra}
    TList:=List;
    For I:=1to(P)do TList:=TList^.Next;
    If(TList^.PSwitch<>NIL)Then WEPutLastBar(StrPas(PChr(TList^.PSwitch)))
                           Else WEPutLastBar('');
   {$ENDIF}
  End;

  Procedure PutBar;Begin
   LIReSave(Line,X1+1+MainMenu.Space4Icon,Y1+1+P,X2-1);
   BarSel;
  End;
{$ENDIF}

Begin
 PMExecMnu:=$FFFF;
 {$IFNDEF __Windows__}
  If(List=NIL)Then Exit;
  LIInit(Line);
  Line.CharacterTransparent:=(IsGrf)and(StyleBackgroundMenu=sbmMacOsX);
  Inc(Stage);
  X1:=X;Y1:=Y;
  TM:=_ALGetCurrBuf(MainMenu.Mnu);
  If(TM=NIL)Then IX2:=$FF
            Else IX2:=X+LenTyping(TM^.Title)+2;
  If(X1>MaxXTxts)Then Begin
   ASM
    CALL NmXTxts
    MOV BL,AL
    MOV AL,X1
    XOR AH,AH
    DIV BL
    ADD Y,AL
    MOV X,AH
    MOV X1,AH
   END;
   Y1:=Y;
  End;
  L:=0;TList:=List;
  While(TList<>NIL)do Begin
   Inc(L);TList:=TList^.Next;
  End;
  Actif:=MemNew(L);
  If(Actif=NIL)Then Goto Xit;
  TList:=List;L:=0;XM:=0;
  While(TList<>NIL)do Begin
   If Not IsPChrEmpty(TList^.Option)Then Begin
    Actif^[L]:=True;TL:=LenTyping(TList^.Option);
    If(TList^.KeyFunc<>kbNoKey)Then Inc(TL,1+Length(KeyCode2Str(TList^.KeyFunc)));
    ASM
     LES DI,TList
     MOV CX,ES:[DI].PullMnuItem.SubMenu.Word
     OR  CX,ES:[DI].PullMnuItem.SubMenu.Word[2]
     JCXZ @1
     INC TL
 @1: LES DI,ES:[DI].PullMnuItem.Switch
     MOV CX,ES
     OR  CX,DI
     JCXZ @2
     MOV AL,1
     SCASB
     JNE @2
     INC TL
 @2:END;
    If(XM<TL)Then XM:=TL
   End;
   Inc(L);
   TList:=TList^.Next;
  End;
  Inc(XM,3+MainMenu.Space4Icon);
  YM:=1+L;X2:=X+XM;Y2:=Y+YM;
  If(X1=__Center__)Then Begin
   X1:=GetHoriCenter(XM);X2:=X1+XM;
  End;
  If(Y1=__Center__)Then Begin
   Y1:=GetVertCenter(YM);Y2:=Y1+YM;
  End;
  If(Y2>MaxYTxts)Then Begin
   Ok:=False;
   For I:=X to(MaxXTxts)do If GetChr(I,Y-1)='>'Then Begin
    Ok:=True;
    Break;
   End;
   If(Ok)Then X:=I+1;
   If MaxYTxts>YM+1Then Y:=MaxYTxts-(YM+1)
                   Else Y:=0;
   X1:=X;Y1:=Y;X2:=X+XM;Y2:=Y+YM
  End;
  If(HelpBar)and(Y2=MaxYTxts)Then Begin
   Dec(Y1);Dec(Y2);
  End;
  If(X2>MaxXTxts)Then Begin
   X1:=MaxXTxts-XM;X2:=MaxXTxts;
  End;
  If Stage<=0Then Begin
   If(P>=L)or Not(Actif^[P])Then P:=0;
  End;
  WEPushEndBar(LW);
  WEInit(Image,X1,Y1,X2,Y2);
  If WEPushWn(Image)Then Begin
   Kr.Border:=CurrKrs.Menu.Normal;
   OldWinType:=WinType;
   Case(StyleBackgroundMenu)of
    sbmMacOsX:WinType:=MacOsX;
    sbmDESQview:WinType:=ClearWindow;
    Else WinType:=Normal;
   End;
   WEPutWn(Image,'',Kr);
   WinType:=OldWinType;TList:=List;IW:=1;
   SetAllKrMnu;
   While(TList<>NIL)do Begin
    If IsPChrEmpty(TList^.Option)Then BarHorDials(X1,Y1+IW,X2,GetKr)
     Else
    Begin
     TStr:=StrPas(TList^.Option);
     If(Line.CharacterTransparent)Then TStr:=^Q+TStr;
     PutTypingXY(X1+2+MainMenu.Space4Icon,Y1+IW,TStr);
     If(TList^.KeyFunc<>kbNoKey)Then Begin
      TStr:=KeyCode2Str(TList^.KeyFunc);
      If(Line.CharacterTransparent)Then Begin
       PutTxtXYT(X2-Length(TStr),Y1+IW,TStr,CurrKrs.Menu.High and$F);
      End
       Else
      PutTxtXY(X2-Length(TStr),Y1+IW,TStr,CurrKrs.Menu.High);
     End;
     Repeat
      If(TList^.Switch<>NIL)and(TList^.Switch^=1)Then Chr:='�'Else
      If(TList^.SubMenu<>NIL)Then Begin
       If(IsGrf)Then Chr:=#16
                Else Chr:='>'
      End
       Else
      Goto 2;
      If(Line.CharacterTransparent)Then Begin
       PutTxtXYT(X2-1,Y1+IW,Chr,GetKr)
      End
       Else
      SetChr(X2-1,Y1+IW,Chr)
     Until True;
  2:End;
    Inc(IW);TList:=TList^.Next
   End;
   If MainMenu.Space4Icon>0Then Begin
    Level:=0;
    If MainMenu.Mnu.Count>0Then For Level:=0to MainMenu.Mnu.Count-1do Begin
     TM2:=_ALGetBuf(MainMenu.Mnu,Level);
     If(TM2^.Title=TM^.Title)Then Break;
    End;
    MainMenu.IconRoutine(X1+1,Y1+1,Level+(P shl 5)+(Stage shl 8));
   End;
   If Stage>0Then P:=0;
   OMX:=$FF;OMY:=$FF;
   If LIPush(Line,X1+1+MainMenu.Space4Icon,Y1+1+P,X2-1)Then Begin
    BarSel;
    InitKbd;
    Repeat
     __ShowMousePtr;
     Repeat
      _BackKbd;
      __GetMouseTextSwitch(MX,MY,BM);
       { Changer de menu principal }
      If(MY=LnsMnu)and(Not IsPChrEmpty(TM^.Title))and(MX>2)and((MX<X)or(MX>IX2))Then Goto MsXit
       Else
       { D�placement � l'int�rieur du menu ou s�lection d'une option }
      If(OMX<>MX)or(OMY<>MY)or(BM>0)Then Begin
       If(MX>X1)and(MX<X2)and(MY>Y1)and(MY<Y2)Then Begin
        P1:=MY-Y1-1;
        OMX:=MX;OMY:=MY;
        If Actif^[P1]Then Begin
         If(P<>P1)Then Begin
          __HideMousePtr;
          P:=P1;
          PutBar;
          __ShowMousePtr;
         End;
         If BM>0Then Begin
          WaitMouseBut0;
          __HideMousePtr;
          If(BM=2)and(Pointer(@MainMenu.OnContext)<>NIL)Then Begin
           TList:=List;I:=0;
           For I:=1to(P)do TList:=TList^.Next;
           If MainMenu.OnContext(TList^.RtnCode)Then Begin
            PMExecMnu:=kbNoKey;
            __HideMousePtr;
            Goto 4;
           End;
          End;
          PushKey(kbEnter)
         End
        End
       End
        Else
       If BM>0Then Begin
  MsXit:PMExecMnu:=kbMouse;
        __HideMousePtr;
        Goto 4;
       End;
      End;
     Until KeyPress;
     __HideMousePtr;
     K:=ReadKey;
     P1:=P;
     Case(K)of
      kbUp:If P>0Then Begin
       Dec(P);
       If Not Actif^[P]Then Dec(P)
      End
       Else
      P:=L-1;
      kbDn:If P<L-1Then Begin
       Inc(P);
       If Not Actif^[P]Then Inc(P)
      End
       Else
      P:=0;
      kbHome:If P>0Then P:=0;
      kbEnd:If P<L-1Then P:=L-1;
      kbEnter:Begin
       TList:=List;I:=0;
       For I:=1to(P)do TList:=TList^.Next;
       If(TList^.SubMenu<>NIL)Then Begin
        K:=PMExecMnu({$IFDEF MultiMenu}MainMenu,{$ENDIF}
                     {X1+1}X2+1,Y1{+2}+P,TList^.SubMenu,I);
        If(K=kbMouse)and WEInWindow(Image,LastMouseX,LastMouseY)Then Begin
        End
         Else
        If(K<>kbEsc)Then Goto 3
       End
        Else
       Begin
        K:=TList^.RtnCode;
        Goto 3;
       End;
      End;
      kbEsc:Goto 3;
      Else Begin
       If Chr<>#0Then Begin
        Chr:=ChrUp(Chr);TList:=List;
        While(TList<>NIL)do Begin
         If(Chr=TList^.HighChar)Then Begin
          P:=I;K:=TList^.RtnCode;
          Break;
         End;
         TList:=TList^.Next
        End;
       End;
       Goto 3
      End;
     End;
     If(P<>P1)Then PutBar
    Until False;
 3:End;
   PMExecMnu:=K;
 4:LIPop(Line);
  End;
  WEDone(Image);WEDone(LW);
  FreeMemory(Actif,L);
Xit:
  Dec(Stage);
 {$ENDIF}
End;

{�������������������������������������������������������������������������
 �                          Proc�dure PMGetMnuBar                        �
 �������������������������������������������������������������������������


 Propri�taire: PullMnu


 Description
 �����������

  Cette proc�dure permet d'effectuer une action en fonction d'une position
 texte  et  s'il correspond  au menu envoie  une caract�res dans le tampon
 clavier afin de lancer la partie menu concerner.
}

Procedure PMGetMnuBar{(*$IFDEF MultiMenu*)Var MainMenu:PullMnu;(*$ENDIF*)X,Y:Byte};
{$IFNDEF __Windows__}
 Var
  TM:MainMnuPtr;
  XP,L:Byte;
  I:Word;
{$ENDIF}
Begin
 {$IFNDEF __Windows__}
  If(Y<>MainMenu.Y)Then Exit;
  XP:=3;
  For I:=0to MainMenu.Mnu.Count-1do Begin
   TM:=_ALGetBuf(MainMenu.Mnu,I);
   L:=LenTyping(TM^.Title);
   If(X>=MainMenu.X1+XP)and(X<=MainMenu.X1+XP+L)Then Begin
    WaitMouseBut0;
    PushKey(TM^.KeyCode);
    Exit;
   End;
   Inc(XP,L+SpcMnu)
  End
 {$ENDIF}
End;

{�������������������������������������������������������������������������
 �                          Constructeur PMInit                          �
 �������������������������������������������������������������������������


 Propri�taire: PullMnu


 Description
 �����������

  Cette constructeur permet d'initialiser les routines affect�es � l'objet
 de menu.
}

Procedure PMInit{(*$IFDEF MultiMenu*)Var MainMenu:PullMnu;(*$ENDIF*)Mnu:PChr):PullMnuPtr};Begin
 {$IFNDEF __Windows__}
  FillClr(MainMenu,SizeOf(MainMenu));
  MainMenu.X2:=MaxXTxts;
 {$ENDIF}
End;

{��������������������������������������������������������������������
 �                          Fonction PMMnuPtr                       �
 ��������������������������������������������������������������������


 Propri�taire: PullMnu


 Description
 �����������

  Cette fonction retourne un pointeur o� se situe dans la m�moire les
 informations correspondant � celui-ci dans le menu d�roulant.
}

Function PMMnuPtr{(*$IFDEF MultiMenu*)Var MainMenu:PullMnu;(*$ENDIF*)Mnu:PChr):PullMnuPtr};
{$IFNDEF __Windows__}
 Var
  TM:MainMnuPtr;          { Pointeur temporaire sur le menu principal }
  I:Word;                 { Compteur de l'�l�ment de menu }
{$ENDIF}
Begin
 {$IFNDEF __Windows__}
  PMMnuPtr:=NIL;
  If ALIsEmpty(MainMenu.Mnu)Then Exit;
  I:=0;
  Repeat
   TM:=_ALGetBuf(MainMenu.Mnu,I);
   If(TM^.Title=Mnu)Then Begin
    PMMnuPtr:=TM^.Lst;
    Exit;
   End;
   Inc(I)
  Until TM=NIL
 {$ENDIF}
End;

{������������������������������������������������������������������������
 �                          Proc�dure PMPutRelief                       �
 ������������������������������������������������������������������������


 Propri�taire: PullMnu
 Portabilit�:  Local


 Description
 �����������

  Cette proc�dure permet d'afficher un cadre en relief autour de la barre
 de menu principal.
}

Procedure PMPutRelief;Near;
Var
 GX,GY:Word; { Position graphique }
Begin
 If(IsGrf)and(BitsPerPixel>=4)and(HeightChr>8)Then Begin
  BarSpcHorRelief(MainMenu.X1,MainMenu.Y,MainMenu.X2,CurrKrs.Menu.Normal);
  GX:=MainMenu.X1 shl 3;
  GY:=GetRawY(MainMenu.Y);
  If(StyleBackgroundMenu<>sbmMacOsX)Then
   GraphBoxRelief(GX+2,GY+3,GX+4,GY+HeightChr-4,$70);
 End;
End;

{����������������������������������������������������������������������
 �                          Proc�dure PMPutMnuBar                     �
 ����������������������������������������������������������������������


 Propri�taire: PullMnu


 Description
 �����������

  Cette proc�dure permet d'afficher et de r�actualiser la barre de menu
 de l'objet menu d�roulant.
}

Procedure PMPutMnuBar{(*$IFDEF MultiMenu*)(Var MainMenu:PullMnu)(*$ENDIF*)};
{$IFNDEF __Windows__}
 Var
  TM:MainMnuPtr;             { Pointeur temporaire sur le menu principal }
  XP,L:Byte;                 { Position horizontal texte, longueur logique }
  T:Word;                    { Position horizontal texte temporaire }
  I:Integer;                 { Compteur de l'�l�ment de menu }
  S:String;                  { Cha�ne de caract�res temporaire }
  Trans:Boolean;             { Transparent?}
  Nxt:Array[Byte]of Boolean; { Indicateur de ligne suivante }
{$ENDIF}
Begin
 {$IFNDEF __Windows__}
  If MainMenu.Mnu.Count=0Then Exit;
  SetAllKrMnu;
  Trans:=(IsGrf)and(StyleBackgroundMenu=sbmMacOsX);
  If(Trans)Then Begin
   _LineBox2Line(MainMenu.X1,MainMenu.Y,MainMenu.X2);
  End
   Else
  _BarSpcHor(MainMenu.X1,MainMenu.Y,MainMenu.X2);
  XP:=3;
  FillClr(Nxt,SizeOf(Nxt));
  For I:=0to MainMenu.Mnu.Count-1do Begin
   TM:=_ALGetBuf(MainMenu.Mnu,I);
   L:=LenTyping(TM^.Title);
   T:=MainMenu.X1+XP+L;
   If(T>MaxXTxts)Then Begin
    T:=T div NmXTxts;
    If Not Nxt[T]Then Begin
     If(Trans)Then Begin
      _LineBox2Line(MainMenu.X1,MainMenu.Y,MainMenu.X2);
     End
      Else
     _BarSpcHor(MainMenu.X1,MainMenu.Y+T,MainMenu.X2);
     Nxt[T]:=True;Inc(LnsMnu)
    End
   End;
   S:=StrPas(TM^.Title);
   If(Trans)Then S:=^Q+S;
   PutTypingXY(MainMenu.X1+XP,MainMenu.Y,S);
   Inc(XP,L+SpcMnu)
  End;
  PMPutRelief;
 {$ENDIF}
End;

{������������������������������������������������������������������
 �                       Proc�dure PMSetWinBar                    �
 ������������������������������������������������������������������


 Propri�taire: PullMnu


 Description
 �����������

  Cette proc�dure permet d'afficher la barre de menu sans toutefois
 afficher les options si rattachant.
}

Procedure PMSetWinBar{(*$IFDEF MultiMenu*)Var MainMenu:PullMnu;(*$ENDIF*)X1,Y,X2:Byte};Begin
 {$IFNDEF __Windows__}
  ASM
   {MainMenu.X1:=X1;MainMenu.Y:=Y;MainMenu.X2:=X2;}
   MOV AL,X1
   MOV AH,Y
   MOV Word Ptr MainMenu.X1,AX
   MOV AL,X2
   MOV Byte Ptr MainMenu.X2,AL
  END;
  If MainMenu.Mnu.Count=0Then Exit;
  BarSpcHor(X1,Y,X2,CurrKrs.Menu.Normal)
 {$ENDIF}
End;

{��������������������������������������������������������������������
 �                       Fonction PMWaitForMnuAction                �
 ��������������������������������������������������������������������


 Propri�taire: PullSubMnu


 Description
 �����������

   Cette fonction permet de conna�tre d'effectuer le bon comportement
  utilisateur dans les menus en attendant un agissement de celui-ci.
}

Function PMWaitForMnuAction{(*$IFDEF MultiMenu*)(Var MainMenu:PullMnu)(*$ENDIF*):Word};Begin
 {$IFNDEF __Windows__}
  PMWaitForMnuAction:=_PMWaitForMnuAction({$IFDEF MultiMenu}MainMenu,{$ENDIF}ReadKey)
 {$ENDIF}
End;

{��������������������������������������������������������������������
 �                      Fonction _PMWaitForMnuAction                �
 ��������������������������������������������������������������������


 Propri�taire: PullSubMnu


 Description
 �����������

   Cette fonction permet de conna�tre d'effectuer le bon comportement
  utilisateur dans les menus en fonction d'un code clavier.
}

Function _PMWaitForMnuAction{(*$IFDEF MultiMenu*)Var MainMenu:PullMnu;(*$ENDIF*)K:Word):Word};
{$IFNDEF __Windows__}
 Label Brk,LastBrk,Restart,Right,Quit;
 Var
  I:Word;
  TM:MainMnuPtr;
  L,XP,J:Byte;
  O2,Ok:Boolean;
  Ln:LineImage;

  {Cette proc�dure pr�pare la barre du menu principal}
  Procedure PutBarHeader;Begin
   LIReSave(Ln,MainMenu.X1+XP-1,MainMenu.Y,MainMenu.X1+XP+L);
   LIBarSel(Ln)
  End;
{$ENDIF}

Begin
 {$IFNDEF __Windows__}
  XP:=3;I:=0;
  LIInit(Ln);
  Ln.CharacterTransparent:=(IsGrf)and(StyleBackgroundMenu=sbmMacOsX);
  ALSetPtr(MainMenu.Mnu,0);
  While(I<MainMenu.Mnu.Count)do Begin
   TM:=_ALGetCurrBuf(MainMenu.Mnu);
   L:=LenTyping(TM^.Title);
   If(K=TM^.KeyCode)Then Begin
    PutBarHeader;
    Ok:=False;
    Repeat
Restart:
     K:=PMExecMnu({$IFDEF MultiMenu}MainMenu,{$ENDIF}MainMenu.X1-1+XP,MainMenu.Y+1,TM^.Lst,TM^.P);
     Case(K)of
      kbMouse:If(LastMouseY=MainMenu.Y)Then Begin
       Ok:=True;XP:=3;
       ALSetPtr(MainMenu.Mnu,0);
       For I:=0to MainMenu.Mnu.Count-1do Begin
        TM:=_ALGetCurrBuf(MainMenu.Mnu{,I});
        L:=LenTyping(TM^.Title);
        If(LastMouseX>=XP-2)and(LastMouseX<=XP+L+1)Then Begin
         PutBarHeader;
         WaitMouseBut0;
         Ok:=False;K:=TM^.KeyCode;
         Goto ReStart
        End;
        Inc(XP,L+SpcMnu);
        ALNext(MainMenu.Mnu);
       End;
       If(Ok)Then Begin
        _PMWaitForMnuAction:=kbNoKey;
        Goto Quit;
       End
      End
       Else
      Begin
       _PMWaitForMnuAction:=kbMouse;
       Goto Quit;
      End;
      kbLeft:Begin
       If I>0Then Begin
        ALPrevious(MainMenu.Mnu);
        Dec(I);O2:=True;
       End
        Else
       Begin
        I:=MainMenu.Mnu.Count-1;
        XP:=3;O2:=False;
        For J:=0to I-1do Begin
         TM:=_ALGetBuf(MainMenu.Mnu,J);
         Inc(XP,LenTyping(TM^.Title)+SpcMnu)
        End;
        ALSetPtr(MainMenu.Mnu,I)
       End;
       TM:=_ALGetCurrBuf(MainMenu.Mnu);
       If(O2)Then Dec(XP,LenTyping(TM^.Title)+SpcMnu);
       Goto Right;
      End;
      kbRight:Begin
       Inc(I);
       If(I>=MainMenu.Mnu.Count)Then Begin
        I:=0;XP:=3;
        ALSetPtr(MainMenu.Mnu,0)
       End
       Else Begin
        Inc(XP,L+SpcMnu);
        ALNext(MainMenu.Mnu)
       End;
       TM:=_ALGetCurrBuf(MainMenu.Mnu);
 Right:L:=LenTyping(TM^.Title);
       PutBarHeader
      End;
      Else Ok:=True
     End
    Until Ok;
 Brk:LIReSave(Ln,MainMenu.X1+XP-1,MainMenu.Y,MainMenu.X1+XP+L);
    Goto LastBrk
   End;
   Inc(XP,L+SpcMnu);
   ALNext(MainMenu.Mnu);
   Inc(I)
  End;
LastBrk:_PMWaitForMnuAction:=K;
Quit:LIPop(Ln);
  PMPutRelief;
 {$ENDIF}
End;

{�������������������������������������������������������������ķ}
{�                    O b j e t  S u b M e n u                 �}
{�������������������������������������������������������������ͼ}

{�����������������������������������������������������������������
 �                     Proc�dure SMAddBarItem                    �
 �����������������������������������������������������������������


 Propri�taire: PullSubMnu


 Description
 �����������

  Cette proc�dure permet d'allouer une barre s�paratrice d'item de
 sous-menu ayant pour ma�tre la variable de param�trage �Q�.
}

Procedure SMAddBarItem{Var Q:PullSubMnu};
{$IFNDEF __Windows__}
 Var
  B:PullMnuItem;
{$ENDIF}
Begin
 {$IFNDEF __Windows__}
  FillClr(B,SizeOf(B));
  SMAlloc(Q,B)
 {$ENDIF}
End;

{������������������������������������������������������������������
 �                      Proc�dure SMAddFullItem                   �
 ������������������������������������������������������������������


 Propri�taire: PullSubMnu


 Description
 �����������

  Cette proc�dure permet d'allouer  un item de sous-menu ayant pour
 ma�tre la variable de param�trage �Q� avec toutes les informations
 message, raccourci clavier,...
}

Procedure SMAddFullItem{Var Q:PullSubMnu;Option:PChar;KeyFunc,RtnCode:Word;
                        SubMenu:Pointer(*$IFDEF LuxeExtra*);PC:PChar(*$ENDIF*)};
{$IFNDEF __Windows__}
 Var
  T:String;
  BPull:PullMnuItem;
{$ENDIF}
Begin
 {$IFNDEF __Windows__}
  T:=StrUp(SearchHigh(PChr(Option)));
  FillClr(BPull,SizeOf(BPull));
  BPull.Option:=PChr(Option);
  BPull.KeyFunc:=KeyFunc;
  BPull.RtnCode:=RtnCode;
  BPull.SubMenu:=SubMenu;
  {$IFDEF LuxeExtra}
   PChar(BPull.PSwitch):=PC;
  {$ENDIF}
  If T<>''Then BPull.HighChar:=T[1];
  SMAlloc(Q,BPull)
 {$ENDIF}
End;

{�����������������������������������������������������������������
 �                      Proc�dure SMAddItemSwitch                �
 �����������������������������������������������������������������


 Propri�taire: PullSubMnu


 Description
 �����������

  Cette proc�dure permet d'allouer un item de sous-menu ayant pour
 ma�tre la variable de param�trage �Q�  avec un pointeur indiquant
 une  variable  bool�en permettant  ainsi  d'activer  ou d�sactiv�
 l'item venant d'�tre ins�rer.
}

Procedure SMAddItemSwitch{Var Q:PullSubMnu;Option:PChar;
              Var Value;Switch:PullSwitchPtr;RtnCode:Word};
{$IFNDEF __Windows__}
 Var
  T:String;
  BPull:PullMnuItem;
{$ENDIF}
Begin
 {$IFNDEF __Windows__}
  T:=StrUp(SearchHigh(PChr(Option)));
  FillClr(BPull,SizeOf(BPull));
  BPull.Option:=PChr(Option);
  BPull.RtnCode:=RtnCode;
  BPull.Switch:=@Value;
  {$IFDEF LuxeExtra}
   BPull.PSwitch:=Switch;
  {$ENDIF}
  If T<>''Then BPull.HighChar:=T[1];
  SMAlloc(Q,BPull)
 {$ENDIF}
End;

{�����������������������������������������������������������������
 �                        Proc�dure SMAlloc                      �
 �����������������������������������������������������������������


 Propri�taire: PullSubMnu


 Description
 �����������

  Cette proc�dure permet d'allouer un item de sous-menu ayant pour
 ma�tre la variable de param�trage �Q�.
}

Procedure SMAlloc;
{$IFNDEF __Windows__}
 Var
  TPull:PullMnuPtr;
{$ENDIF}
Begin
 {$IFNDEF __Windows__}
  If Q.NmLst=0Then Q.Ptr:=NewBlock(BPull,SizeOf(Q.Ptr^))
   Else
  Begin
   TPull:=Q.Ptr;
   While(TPull^.Next<>NIL)do TPull:=TPull^.Next;
   TPull^.Next:=NewBlock(BPull,SizeOf(Q.Ptr^));
  End;
  Inc(Q.NmLst)
 {$ENDIF}
End;

{�������������������������������������������������������������������������
 �                             Proc�dure SMDone                          �
 �������������������������������������������������������������������������


 Propri�taire: PullSubMnu
 Portabilit�:  Globale


 Description
 �����������

  Cette proc�dure d�charge de la m�moire le contenu que r�serve l'objet de
 sous-menu sur le tas.
}

Procedure SMDone{Var Q:PullSubMnu};
{$IFNDEF __Windows__}
 Var
  TPull:PullMnuPtr;
{$ENDIF}
Begin
 {$IFNDEF __Windows__}
  TPull:=Q.Ptr;
  While(TPull<>NIL)do Begin
   FreeMemory(TPull,SizeOf(PullMnuItem));
   TPull:=TPull^.Next;
  End;
 {$ENDIF}
End;

{�����������������������������������������������������������������������
 �                           Proc�dure SMInit                          �
 �����������������������������������������������������������������������


 Propri�taire: PullSubMnu


 Description
 �����������

  Cette proc�dure initialise l'objet de sous-menu destin� � �tre utilis�
 � travers le menu principal.
}

Procedure SMInit{Var Q:PullSubMnu};Begin
 FillClr(Q,SizeOf(Q)) { Initialisation et mise � z�ro de les donn�es de
                        l'objet y compris des pointeurs. }
End;

{������������������������������������������������������������������������
 �                          Proc�dure WriteLog                          �
 ������������������������������������������������������������������������


 Description
 �����������

  Cette proc�dure permet d'enregistrer un message dans le journal de bord
 ASCII pour  qu'un utilisateur  puisse conna�tre  les derniers op�rations
 effectuer par l'application.
}

Procedure WriteLog{Const S:String};
Var
 Handle:Hdl;
 DayOfWeek,Sec100:Byte;
 Path:String;
 L:LongInt;
 X:DateTime;
Begin
 If(Log)Then Begin
  Path:=Path2Dir(_PrgPath)+'MALTE.LOG';
  Handle:=FileOpen(Path,fmWrite);
  If(Handle=errHdl)Then Handle:=FileCreate(Path);
  If(Handle<>errHdl)Then Begin
   GetDate(X.Year,X.Month,X.Day,DayOfWeek);
   GetTime(X.Hour,X.Min,X.Sec,Sec100);
   PackTime(X,L);
   PutFileTxt(Handle,TimeToStr(L)+'  ');
   PutFileTxtLn(Handle,S);
   FileClose(Handle)
  End;
 End;
End;

{�������������������������������������������������������������������������
 �                           Proc�dure PopWins                           �
 �������������������������������������������������������������������������


 Description
 �����������

  Cette proc�dure devrait th�oriquement d�sempiler la fen�tre objet �Wins�
  de la pile  ou une pile � la suite d'une demande  ayant �t� faite par la
  proc�dure �PushWins�.
}

{Procedure PopWins;Begin;End;}

{��������������������������������������������������������������������������
 �                            Proc�dure PushWins                          �
 ��������������������������������������������������������������������������


 Description
 �����������

  Cette proc�dure devrait th�oriquement empiler la fen�tre objet �Wins� sur
 la pile ou une pile.  Les donn�es pourront �tre r�cup�r�  par la proc�dure
 antipode �PopWins�.
}

{Procedure PushWins;Begin
End;}

{ �������������������������������������������������������������������������
  �                        Fonction ReadKeyTypeWriter                     �
  �������������������������������������������������������������������������


   Cette fonction retourne la touche courante enfoncer au clavier en tenant
  compte des adaptations  � faire  pour un tra�tement  dans le cas de codes
  accentu�s.
}

Function ReadKeyTypeWriter{:Word};
{$IFNDEF __Windows__}
 Const
  MinNmLck:Array['-'..'9']of Chr=('�','�','�','�','�','�','�','�','�','�','�','�','�');
  MajNmLck:Array['-'..'9']of Chr=('�','�','U','O','�','I','I','E','E','�','A','�','�');
  ShiftCtrl:Array[1..$1A]of Chr=(
   '�','�','�','','�','�','�','�','�','�','�','�','�',
   '�','�','�','Q','�','S','�','�','�','W','X','�','Z'
  );
  ShiftAlt:Array[$11..$32]of Chr=(
   '�','�','�','�','�','�','�','�','�',#0,#0,#0,#0,
   '�','�','�','�','�','�','�','K','�',#0,#0,#0,#0,#0,
   '�','X','�','�','�','�','�'
  );
 Var
  K:Word;
  Chr:Char Absolute K;
  Shift:Boolean;
{$ENDIF}
Begin
 {$IFDEF __Windows__}
  ReadKeyTypeWriter:=ReadKey;
 {$ELSE}
  K:=ReadKey;
  Shift:=ShiftPress;
  Case Lo(K)of
   0:Case Hi(K)of
    Hi(kbAltMinus):K:=Byte('�');
    Hi(kbCtrl2):K:=Byte('�');
    Hi(kbAltGraySlash):K:=Byte('�');
    Hi(kbAltMult):If(GetCapsLck)Then K:=Byte('O')Else K:=Byte('�');
    Hi(kbAltLess):K:=Byte('�');
    Hi(kbAltGreat):K:=Byte('�');
    Else If(Shift)Then Case Hi(K)of
     Hi(kbAltW)..Hi(kbAltP),
     Hi(kbAltA)..Hi(kbAltL),
     Hi(kbAltZ)..Hi(kbAltM):K:=Byte(ShiftAlt[Hi(K)]);
     Hi(kbAltQ):If(GetCapsLck)Then K:=Byte('�')Else K:=Byte('�');
    End;
   End;
   $F0:Case Hi(K)of
    Hi(kbAltOpenBox):K:=Byte('�');
    Hi(kbAltCloseBox):K:=Byte('�');
    Hi(kbAltLess):K:=Byte('�');
    Hi(kbAltGreat):K:=Byte('�');
    Hi(kbAltQuestion):If Not(Shift)Then K:=Byte('�');
    Hi(kbAltGrayMinus):K:=Byte('�');
    Hi(kbAltGrayPlus):K:=Byte('�');
    Hi(kbAltEnviron):K:=Byte('�');
    Hi(kbKeypad5):K:=Byte('�');
    Hi(kbAltBkSl):K:=Byte('�');
   End;
   1..$1A:If(Shift)Then K:=Byte(ShiftCtrl[Lo(K)]);
   Else Case(K)of
    kbCtrlOpenBox:K:=Byte('�');
    kbCtrlCloseBox:K:=Byte('�');
    Else If(Shift)Then Begin
     If(Chr)in['0'..'9','.','/','*','-','+']Then Begin
      {********:Ne tiens toutefois pas compte des codes de pages
       **NOTE** du syst�me d'exploitation changeant la police de
       ******** tous c�t�s  et  toutes lettres  en haut  du code
       ******** ASCII 127.}
      Case(Chr)of
       '-'..'9':If(GetCapsLck)Then Chr:=MajNmLck[Chr]
                              Else Chr:=MinNmLck[Chr];
       '*':If Hi(K)<>$9Then Begin
            If(GetCapsLck)Then Chr:='U'Else Chr:='�';
           End;
       '+':If Hi(K)<>$DThen Begin
            If(GetCapsLck)Then Chr:='�'Else Chr:='�';
           End;
      End;
     End;
    End;
   End;
  End;
  ReadKeyTypeWriter:=K
 {$ENDIF}
End;

Procedure LTInit{Var Q:ListTitle;X1,Y,X2:Byte;Const Title:String};
Var
 I,J,Len:Byte;
Begin
 FillClr(Q,SizeOf(Q));
 Q.Y:=Y;Q.XP[0]:=X1;Q.MaxX:=X2;
 Q.Title:=Title;
 Q.NB:=Succ(GetNmChr(Title,'|'));
 J:=1;
 For I:=1to(Q.NB)do Begin
  Len:=0;
  While(Title[J]<>'|')and(J<Length(Title))do Begin
   Inc(J);
   Inc(Len);
  End;
  Inc(J);
  Q.XP[I]:=Q.XP[I-1]+Len+1;
 End;
 Q.XP[Q.NB]:=Q.MaxX;
End;

Procedure LTInitWithWins{Var Q:ListTitle;X1,Y,X2:Byte;Const Title:String;Var W:Window};Begin
 ASM
  LES DI,W
  CALL asmWEGetR
  ADD X1,AL
  ADD Y,AH
  ADD X2,AL
 END;
 LTInit(Q,X1,Y,X2,Title);
End;

Procedure LTSetColumnSize{Var Q:ListTitle;Pos,NewSize:Byte};
Var
 I:Byte;
 Intervalle:Integer;
Begin
 Intervalle:=NewSize+1-(Q.XP[Pos+1]-Q.XP[Pos]);
 For I:=Pos+1to(Q.NB)do Inc(Q.XP[I],Intervalle);
End;

Procedure LTRefresh{Var Q:ListTitle};
Var
 S,I,J,Len,X2:Byte;
Begin
 If Not(InBarHole(Q.XP[0],Q.Y,Succ(Q.MaxX)))Then Begin
  BarSpcHor(Q.XP[0],Q.Y,Q.MaxX,$70);
  J:=1;
  For I:=0to Q.NB-1do Begin
   Len:=0;S:=J;
   While(Q.Title[J]<>'|')and(J<=Length(Q.Title))do Begin
    Inc(J);
    Inc(Len);
   End;
   Inc(J);
   PutSmlTxtXY(Q.XP[I],Q.Y,Copy(Q.Title,S,Len),$70);
   X2:=Pred(Q.XP[I+1]);
   If(X2>Q.MaxX)Then X2:=Q.MaxX;
   BarSpcHorRelief(Q.XP[I],Q.Y,X2,$70);
  End;
 End;
End;

{�������������������������������������������������������������ķ}
{�          O b j e t  D i r e c t  C l i p B o a r d          �}
{�                ( P r e s s e - P a p i e r )                �}
{�������������������������������������������������������������ͼ}

{���������������������������������������������������������������������
 �                      Proc�dure MakeClipBoard                      �
 ���������������������������������������������������������������������


 Description
 �����������

  Cette proc�dure cr�e ou recr�e la un tampon (Clipboard) de la taille
 sp�cifi� et  ne pouvant pas �tre  d�pass� par l'une  des commandes de
 transfert  dans ce  tampon.  S'il existe d�j�,  elle est  effac� puis
 recr��...


 Remarque
 ��������

  � Il est h�las  impossible pour  l'instant d'envoyer  les donn�es du
    presse-papier (clipboard) dans  une zone m�moire XMS  parce que le
    transfert  s'effectue  seulement  sous forme  de mot  et  qu'il ne
    supporte pas les transfert en mode octets par octets.
}

Procedure MakeClipBoard{Size:LongInt};Begin
 If(FirstTimeCB)Then FillClr(ClipBoard,SizeOf(ClipBoard))
                Else XFreeMem(ClipBoard);
 XAllocMem(rmAllResSteady,Size,ClipBoard);
 FirstTimeCB:=False;
 ClipPos:=0;
 SizeOfClipBoard:=0;
End;

{ �����������������������������������������������������������������������
  �                        Fonction GetAbsClipboard                     �
  �����������������������������������������������������������������������


  Description
  �����������

   Cette proc�dure permet de conna�tre des donn�es sur le presse-papier �
  une position absolue en octets dans ce tampon.
}

Function GetAbsClipBoard{P:Long;Size:Word;Var X):Word};
Label
 ClearAll;
Var
 TC:TChar Absolute X;
 ExtraLen:Word;
Begin
 GetAbsClipBoard:=0;
 If Not(FirstTimeCB)Then Begin
  If(P>SizeOfClipboard)Then Goto ClearAll;
  XGetAbsRec(ClipBoard,P,Size,X);
  If(P+Size>SizeOfClipboard)Then Begin
   ExtraLen:=P+Size-SizeOfClipboard;
   FillClr(TC[Size-ExtraLen],ExtraLen);
   ClipPos:=SizeOfClipboard;
   GetAbsClipboard:=Size-ExtraLen;
  End
   Else
  Begin
   ClipPos:=P+Size;
   GetAbsClipBoard:=Size;
  End;
 End
  Else
 ClearAll:FillClr(X,Size);
End;

{�������������������������������������������������������������������������
 �                         Proc�dure SetAbsClipboard                     �
 �������������������������������������������������������������������������


 Description
 �����������

   Cette proc�dure permet d'ajouter des donn�es sur le presse-papier � une
  position abolue en octets dans ce tampon.
}

Procedure SetAbsClipBoard{P:LongInt;Size:Word;Const X};Begin
 If Not(FirstTimeCB)Then Begin
  XSetAbsRec(ClipBoard,P,Size,X);
  ClipPos:=P+Size;SizeOfClipBoard:=Omega(ClipPos,SizeOfClipBoard);
 End;
End;

{�������������������������������������������������������������������������
 �                         Proc�dure _SetRecClipboard                    �
 �������������������������������������������������������������������������


 Description
 �����������

  Cette proc�dure �crit un enregistrement dans le tampon (ClipBoard)  � sa
 position actuel  sens �craser  le contenu d�j� contenu � l'int�rieur.  Le
 tampon naturellement  position � la fin  de cette ligne pour  ne pas �tre
 �cras� par la suite.
}

Procedure _SetRecClipBoard{Size:Word;Const X};Begin
 SetAbsClipBoard(ClipPos,Size,X);
End;

{�������������������������������������������������������������������������
 �                         Proc�dure PutClipboardTxt                     �
 �������������������������������������������������������������������������


 Description
 �����������

  Cette proc�dure �crit une ligne de texte dans le tampon (ClipBoard) � sa
 position actuel  sens �craser  le contenu d�j� contenu � l'int�rieur.  Le
 tampon naturellement  position � la fin  de cette ligne pour  ne pas �tre
 �cras� par la suite.
}

Procedure PutClipBoardTxt{Const S:String};Begin
 If Not(FirstTimeCB)Then Begin
  XSetAbsRec(ClipBoard,ClipPos,Length(S),S[1]);
  Inc(ClipPos,Length(S));
  SizeOfClipBoard:=Omega(ClipPos,SizeOfClipBoard);
 End;
End;

{ Cette proc�dure d'envoie un message texte unique dans le presse-papier
 sans se soucier de la cr�ation d'un presse-papier assez gros.
}

Procedure PushClipboardTxt(Const S:String);Begin
 MakeClipboard(Length(S));
 PutClipboardTxt(S);
End;

{ Cette fonction retourne le message contenu dans le presse-papier.
}

Function GetClipBoardTxt:String;
Var
 S:String;
Begin
 GetAbsClipboard(0,SizeOf(S)-1,S[1]);
 If SizeOfClipboard>255Then S[0]:=#255
                       Else S[0]:=Chr(SizeOfClipboard);
 GetClipboardTxt:=S;
End;

{�������������������������������������������������������������ķ}
{�                   O b j e t  H i s t o r Y                  �}
{�                   ( H i s t o r i q u e )                   �}
{�������������������������������������������������������������ͼ}

{ �������������������������������������������������������������������
  �                        Proc�dure HYInit                         �
  �������������������������������������������������������������������


  Propri�taire: History


  Description
  �����������

   Cette proc�dure permet  d'initialiser une histoire d'une taille de
  �Size� octets �liminant les plus vieilles commandes si le manque de
  m�moire se fait sentir.
}

Procedure HYInit{Var Q:History;Size:Word};Begin
 Q.Cmd:=MemNew(Size);
 If(Q.Cmd=NIL)Then Q.SizeCmd:=0
              Else Q.SizeCmd:=Size;
 Pointer(Q.Tail):=Pointer(Q.Cmd);Q.Ptr:=Q.Tail
End;

Procedure HYInitTo{Var Q:History;Size:Word;Buffer:Pointer};Begin
 Q.Fixed:=True;
 Q.Cmd:=Buffer;
 Q.SizeCmd:=Size;
 Pointer(Q.Tail):=Pointer(Q.Cmd);Q.Ptr:=Q.Tail
End;

{ �����������������������������������������������������������������������
  �                          Fonction HYChoice                          �
  �����������������������������������������������������������������������


  Propri�taire: History


  Description
  �����������

   Cette fonction permet de s�lectionner un item pr�c�demmant enregistrer
  dans l'histoire des items rentr�e.
}

Function HYChoice{Var Q:History;X,Y:Byte):String};
Label MAJB,Scrll;
Var
 W:Window;
 NB,I,P,L:Word;
Begin
 HYChoice:='';
 If Q.SizeCmd=0Then Exit;
 If Pointer(Q.Tail)<>Pointer(Q.Cmd)Then Begin
  NB:=0;Q.Ptr:=Q.Tail;L:=0;
  While Pointer(Q.Ptr)<>Pointer(Q.Cmd)do Begin
   Dec(PtrRec(Q.Ptr).Ofs);
   Dec(PtrRec(Q.Ptr).Ofs,Length(Q.Ptr^)+1);
   If(Length(Q.Ptr^)>L)Then L:=Length(Q.Ptr^);
   Inc(NB);
  End;
  Inc(L,2);
  If L<=11Then L:=12;
  If(L>=X)Then L:=X;
  If(Y+NB+1>=MaxYTxts)Then WEInit(W,X-L,Y,X,MaxYTxts-2)
                      Else WEInit(W,X-L,Y,X,Y+NB+1);
  WEPushWn(W);
  WEPutWnKrDials(W,'Histoire');
  WECloseIcon(W);
  Q.Ptr:=Q.Tail;
  For I:=1to(NB)do Begin
   Dec(PtrRec(Q.Ptr).Ofs);
   Dec(PtrRec(Q.Ptr).Ofs,Length(Q.Ptr^)+1);
   WEPutTxtLn(W,Q.Ptr^);
  End;
  Q.Ptr:=Q.Tail;Y:=0;P:=0;
  Dec(PtrRec(Q.Ptr).Ofs);
  Dec(PtrRec(Q.Ptr).Ofs,Length(Q.Ptr^)+1);
  WESetKrSel(W);
  WEBarSelHor(W,0,Y,wnMax);
  Repeat
   Case WEReadk(W)of
    kbInWn:Begin
     WESetKrBorder(W);
     WEBarSelHor(W,0,Y,wnMax);
     Dec(P,Y);
     Y:=LastMouseY-WEGetRY1(W);
     Inc(P,Y);
     WESetKrSel(W);
     WEBarSelHor(W,0,Y,wnMax);
     WaitMouseBut0;
    End;
    kbDn:If P<NB-1Then Begin
     WESetKrBorder(W);
     WEBarSelHor(W,0,Y,wnMax);
     Inc(P);
     Dec(PtrRec(Q.Ptr).Ofs);
     Dec(PtrRec(Q.Ptr).Ofs,Length(Q.Ptr^)+1);
     If(Y<W.MaxY)Then Inc(Y)
      Else
     Begin
      WEScrollDn(W,0,0,wnMax,wnMax);
      W.Y:=W.MaxY;W.X:=0;
      Goto Scrll;
     End;
     Goto MAJB;
    End;
    kbUp:If P>0Then Begin
     WESetKrBorder(W);
     WEBarSelHor(W,0,Y,wnMax);
     Dec(P);
     Inc(PtrRec(Q.Ptr).Ofs,Length(Q.Ptr^)+2);
     If Y>0Then Dec(Y)
      Else
     Begin
      WEScrollUp(W,0,0,wnMax,wnMax);
      W.Y:=0;W.X:=0;
Scrll:WEPutTxt(W,Q.Ptr^);
      WEClrEol(W)
     End;
MAJB:WESetKrSel(W);
     WEBarSelHor(W,0,Y,wnMax);
    End;
    kbEnter:Begin
     HYChoice:=Q.Ptr^;
     Break;
    End;
    kbClose,kbEsc:Break;
   End;
  Until False;
  WEDone(W);
 End;
End;

{ �������������������������������������������������������������������
  �                        Proc�dure HYClear                        �
  �������������������������������������������������������������������


  Propri�taire: History


  Description
  �����������

   Cette fonction permet d'effacer la commande courante dans la liste
  historique.
}

Function HYClear{Var Q:History):String};Begin
 If(Pointer(Q.Tail)=Pointer(Q.Cmd))or(Q.Ptr=Q.Tail)Then Exit;
 Q.TPtr:=Q.Ptr;
 Inc(PtrRec(Q.TPtr).Ofs,Length(Q.Ptr^)+2);
 MoveLeft(Q.TPtr^,Q.Ptr^,PtrRec(Q.Cmd).Ofs+Q.SizeCmd-PtrRec(Q.TPtr).Ofs);
 Dec(PtrRec(Q.Tail).Ofs,PtrRec(Q.TPtr).Ofs-PtrRec(Q.Ptr).Ofs);
 Q.Tail^[0]:=#0;
 If(Q.Ptr=Q.Tail)Then Pointer(Q.Ptr):=Pointer(Q.Cmd);
 HYClear:=Q.Ptr^
End;

{ ������������������������������������������������������������������������
  �                       Proc�dure HYClearQueue                         �
  ������������������������������������������������������������������������


  Propri�taire: History


  Description
  �����������

   Cette proc�dure permet d'effacer tous les items (commandes) de la liste
  historique.
}

Procedure HYClearQueue{Var Q:History};Begin
 Pointer(Q.Tail):=Pointer(Q.Cmd);
 Q.Ptr:=Q.Tail;
 Q.Cmd^[0]:=0
End;

{ ���������������������������������������������������������������������
  �                        Proc�dure HYNext                           �
  ���������������������������������������������������������������������


  Propri�taire: History


  Description
  �����������

   Cette fonction permet de passer � la commande suivante dans la liste
  historique.
}

Function HYNext{Var Q:History):String};Begin
 If Pointer(Q.Tail)=Pointer(Q.Cmd)Then Exit;
 If(Q.Ptr=Q.Tail)Then Pointer(Q.Ptr):=Pointer(Q.Cmd)
                 Else Inc(PtrRec(Q.Ptr).Ofs,Length(Q.Ptr^)+2);
 If(Q.Ptr=Q.Tail)Then Pointer(Q.Ptr):=Pointer(Q.Cmd);
 HYNext:=Q.Ptr^
End;

{ �����������������������������������������������������������������������
  �                          Proc�dure HYPrev                           �
  �����������������������������������������������������������������������


  Propri�taire: History


  Description
  �����������

   Cette fonction permet de passer � la commande pr�c�dante dans la liste
  historique.
}

Function HYPrev{Var Q:History):String};Begin
 HYPrev:='';
 If Pointer(Q.Tail)=Pointer(Q.Cmd)Then Exit;
 If(Q.Ptr=Q.Tail)Then Begin
  If Pointer(Q.Ptr)=Pointer(Q.Cmd)Then Q.Ptr:=Q.Tail;
  Dec(PtrRec(Q.Ptr).Ofs);
  Dec(PtrRec(Q.Ptr).Ofs,Length(Q.Ptr^)+1);
  HYPrev:=Q.Ptr^
 End
  Else
 HYPrev:=HYNext(Q)
End;

{ ��������������������������������������������������������������������
  �                        Proc�dure HYQueue                         �
  ��������������������������������������������������������������������


  Propri�taire: History


  Description
  �����������

   Cette proc�dure permet d'additionner un nouvel item (commande) dans
  la liste historique.
}

Procedure HYQueue{Var Q:History;Const S:String};Begin
 If Q.SizeCmd=0Then Exit;
 Q.Ptr:=Q.Tail;
 While Pointer(Q.Ptr)<>Pointer(Q.Cmd)do Begin
  If(PtrRec(Q.Ptr).Ofs<PtrRec(Q.Cmd).Ofs)Then Exit;
  Dec(PtrRec(Q.Ptr).Ofs);Dec(PtrRec(Q.Ptr).Ofs,Length(Q.Ptr^)+1);
  If(Q.Ptr^=S)Then Begin
   Q.Ptr:=Q.Tail;
   Exit;
  End;
 End;
 Pointer(Q.TPtr):=Pointer(Q.Cmd);
 While(Length(S)+2+PtrRec(Q.Tail).Ofs-PtrRec(Q.TPtr).Ofs>Q.SizeCmd)do Begin
  Inc(PtrRec(Q.TPtr).Ofs,Length(Q.TPtr^)+2);
 End;
 If(PtrRec(Q.TPtr).Ofs<>PtrRec(Q.Cmd).Ofs)Then Begin
  MoveLeft(Q.TPtr^,Q.Cmd^,PtrRec(Q.Cmd).Ofs+Q.SizeCmd-PtrRec(Q.TPtr).Ofs);
 End;
 Dec(PtrRec(Q.Tail).Ofs,PtrRec(Q.TPtr).Ofs-PtrRec(Q.Cmd).Ofs);
 Q.Tail^:=S;Inc(PtrRec(Q.Tail).Ofs,Length(S)+1);Q.Tail^[0]:=Char(Length(S));
 Inc(PtrRec(Q.Tail).Ofs);Q.Ptr:=Q.Tail;
End;

Function HYGetSizeBuffer(Var Q:History):Word;Begin
 HYGetSizeBuffer:=PtrRec(Q.Tail).Ofs-PtrRec(Q.Cmd).Ofs;
End;

Procedure HYSetSizeBuffer(Var Q:History;Size:Word);Begin
 Inc(PtrRec(Q.Tail).Ofs,Size);
 Inc(PtrRec(Q.Ptr).Ofs,Size);
 Pointer(Q.TPtr):=Pointer(Q.Cmd);
End;

{ ��������������������������������������������������������������������
  �                          Fonction HYDone                         �
  ��������������������������������������������������������������������


  Propri�taire: History


  Description
  �����������

   Cette proc�dure permet de restituer la m�moire pr�c�damment allouer
  par l'objet d'histoire.
}

Procedure HYDone{Var Q:History};Begin
 If Not(Q.Fixed)Then FreeMemory(Q.Cmd,Q.SizeCmd)
End;

{�������������������������������������������������������������ķ}
{�                     Z o n e  P r i v �                      �}
{�������������������������������������������������������������ͼ}

{ ����������������������������������������������������������������������
  �                       Proc�dure InitKbd                            �
  ����������������������������������������������������������������������


  Description
  �����������

   Cette proc�dure permet d'initialis� les t�ches d'attente pour lorsque
  l'utilisateur doit frapper  une touche au clavier.  Cette routine doit
  �tre appel�e  � chaque fois  car  elle est  utilis�  entre  autre pour
  conna�tre le d�lai pour l'�conomiseur d'�cran...
}

Procedure InitKbd;Begin
 TSS:=SecSS*18;
 NSS:=0;
 OldSS:=GetRawTimerB;
End;

Function FuncPrtScr:Boolean;Begin
 {$IFDEF FLAT386}
  FuncPrtScr:=False;
 {$ELSE}
  CLI;
  FuncPrtScr:=PrtScr;
  STI;
 {$ENDIF}
End;

{������������������������������������������������������������������������
 �                         Proc�dure BackTimer                          �
 ������������������������������������������������������������������������


  Description
  �����������

   Cette proc�dure doit �tre appel� � temps perdu lors de l'attente d'une
  touche au clavier par exemple,  car elle permet de r�gulariser le temps
  d'impression  ainsi  que  l'�conomiseur  d'�cran.  Elle  a surtout  une
  implication interne � l'int�rieur de cette unit� et ne devrait pas �tre
  appel� � l'ext�rieur de cette unit� en th�orie.
}

Procedure BackTimer;
Const
 LenTime=7;
Var
 Curr,Hour,Min,Sec,XM,YM,I:Byte;
 Time,Timeb:LongInt;
 BM:Word;

 Function IsZone:Boolean;Begin
  IsZone:=(YM=TmPs[I].Y)and(XM>=TmPs[I].X)and(XM<=TmPs[I].X+LenTime)
 End;

Begin
 OldBackKbd;
 Curr:=GetRawTimerB;
 If(OldSS<>Curr)Then Begin
  OldSS:=Curr;Inc(NSS);
  If(SecSS<>0)and(NSS>=TSS)Then Begin
   If(ActifScrSave)Then RunScrnSaver;
   InitKbd
  End;
 End;
 {$IFNDEF __Windows__}
  If(FuncPrtScr)Then PrintScreen;
 {$ENDIF}
 If(DialTimer)Then Begin
  Curr:=Curr and$F0;
  If(Old<>Curr)Then Begin
   Old:=Curr;Time:=GetRawTimer;
   If Time<>0Then Begin
    Time:=(Time*901)shr 14; {C'est plus rapide  que d'utiliser la longue
                             formule �(Time*10)/182� prenant des si�cles
                             au processeur � s'ex�cuter.  Car vous savez
                             s�rement comme moi qu'effectue une division
                             sur un micro-processeur de la famille INTEL
                             prend tellement  de cycle  d'horloge  qu'un
                             humain compte plus vite que lui � la main.}
    Hour:=DivLong(Time,60*60);
    Min:=Word(DivLong(Time,60))mod 60;{Il y a 1440 minutes par jours au maximum,
                                    mettont  1500,  malgr�  tous,  la  valeur
                                    reste suffisament petite  pour rester sur
                                    2 octets et  donc le tronquage  en un mot
                                    de 2  octets  par �Wd�  est  parfaitement
                                    possible ici.}
    Sec:=Time mod 60; { Ce cas si est diff�rent du calcul des minutes,
                        ainsi, la partie � diviser pour en extraire la
                        partie restante  doit �tre  un entier long  (4
                        octets)  et non pas un mot  de 2 octets  comme
                        dans le  cas  de  �Min�...  Si vous  tentez la
                        division  restante  avec  2 octets,  vous vous
                        retrouverez  avec un d�calage  d'une vingtaine
                        de seconde  avec les minutes...  Donc  laisser
                        cette ligne tranquille!!!!}
    If Not((TimeX=$FE)or(TimeXA=$FE)or(TimeXIn=$FE)or(DateX=$FE))Then __GetMouseTextSwitch(XM,YM,BM);
    For I:=0to 5do If TmPs[I].X<>$FEThen Begin
     If I=5Then Begin
      If(OldYear=0)or(Time<100)Then GetDate(OldYear,OldMonth,OldDay,OldDayOfWeek)
     End
      Else
     Begin
      Case(I)of
       1:Begin
        Hour:=23-Hour;
        Min:=59-Min;
        Sec:=59-Sec;
       End;
       2:Begin
        Dec(Time,TimeIn);
        If Time=0Then Continue
                 Else Timeb:=Time;
       End;
       3:If TimeMod=0Then Continue
                     Else Timeb:=Long(Long(Time)-Long(TimeMod));
       4:If TimeOnLine=0Then Continue
                        Else Timeb:=Time-TimeOnLine;
      End;
      If(I>1)and(Timeb<>0)Then Begin
        { Ne surtout pas oublier que la division par 0 doit donn� dans cette
         routine en accord avec les m�canismes de l'unit� �Systems�.}
       Hour:=DivLong(Timeb,60*60);
       Min:=Word(DivLong(Timeb,60))mod 60;
       Sec:=Timeb mod 60
      End;
     End;
     If(IsZone)Then __HideMousePtr;
     If I=5Then PutTxtZUnKr(Word(TmPs[5]),_CStrDate(OldYear,OldMonth,OldDay,OldDayOfWeek))
           Else PutTxtZUnKr(Word(TmPs[I]),CStrTimeDos(Hour,Min,Sec));
     If(IsZone)Then __ShowMousePtr
    End
   End;
  End
 End
End;

Procedure LoadWallPaper{Refresh:Boolean};
Var
 Inf:MCanvas;
Begin
 If(IsGrf)and(BitsPerPixel>=4)Then Begin
  XFreeMem(FontApp);
  If(RILoadImage(StrPas(FontAppPath),diAutoDetect,0,$FFFF,rmAllResSteady,[],FontApp)=eriNone)Then Begin
   RIRes2WnImg(FontApp,Inf);
   RIMakeDoublon(FontApp,rmAllResSteady,True,Inf);
   XFreeMem(FontApp);
   FontApp:=Inf.Miroir;
  End;
  If(Refresh)Then
   RIPutImageJuxtap(FontApp,0,GetRawY(2),NmXPixels,NmYPixels-16-1-GetRawY(1),WallPaperCfg);
 End;
End;

Procedure Int05h;Begin
 PrtScr:=True;
End;

(*Function InBarHole{X,Y,L:Byte):Boolean};Var Ok:Boolean;Base:Word;Begin
 If(Not HoleMode)or(Hole=NIL)Then InBarHole:=False
  Else
 Begin
  Base:=X+Y*NmXTxts;
  Ok:=False;
  While L>0do Begin
   Dec(L);
   If Hole^[Base]Then Begin
    Ok:=True;
    Break;
   End;
   Inc(Base);
  End;
  InBarHole:=Ok;
 End;
End;*)

Function InBarHole{X,Y,L:Byte):Boolean};Assembler;ASM
 CLD
 MOV AL,0
 CMP HoleMode,AL
 JE  @End
 LES DI,Hole
 MOV CX,ES
 OR  CX,DI
 JZ  @End
 CALL NmXTxts
 MUL Y
 MOV CH,0
 MOV CL,L
 ADD AL,X
 ADC AH,CH
 ADD DI,AX
 XOR AX,AX
@1:
 SCASB
 JNE  @2
 LOOP @1
 JMP @End
@2:
 MOV AL,True
@End:
END;

{�����������������������������������������������������������������������
 �                         Fonction InBoxHole                          �
 �����������������������������������������������������������������������


  Description
  �����������

  Cette fonction indique si la r�gion texte sp�cifier est occup� par une
 trace d'une autre fen�tre.
}

Function InBoxHole;
Var
 Ok:Boolean;
 J:Byte;
Begin
 Ok:=False;
 For J:=0to Pred(H)do If InBarHole(X,Y+J,L)Then Begin
  Ok:=True;
  Break;
 End;
 InBoxHole:=Ok;
End;

{��������������������������������������������������������������������������}
BEGIN
 FontApp.Output:=$FF;         { Fond non attribu�}
 FontTitle.Output:=$FF;       { Barre de titre non attribu�e }
 FontInActifTitle.Output:=$FF;{ Barre de titre inactif non attribu�e }
END.