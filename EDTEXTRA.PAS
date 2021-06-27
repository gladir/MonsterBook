{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³Malte Genesis/Module de Traitement de Texte suppl‚mentaire³
 ³       Edition Chantal pour Mode R‚el/IV-Version 1.0      ³
 ³                      1995/11/02                          ³
 ³                                                          ³
 ³    Tous droits r‚serv‚ par les Chevaliers de Malte (C)   ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ


 Nom du programmeur
 ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ

  Sylvain Maltais, Alias Malte


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette unit‚ contient toutes  les proc‚dures suppl‚mentaires
 d'‚ditions d'un texte de format standard DOS ASCII ou GAT de
 taille limit‚ … la m‚moire du systŠme, c'est-…-dire … 640 Ko
 en mode r‚el, 16 Mo en mode prot‚g‚,...
}

Unit EdtExtra;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                                  INTERFACE
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

{$I DEF.INC}
Uses
 Systex,Isatex;

{$IFNDEF __Windows__}
 Procedure TEAsmStrMacro(Var Q:EditorApp);
 Procedure TECMacro(Var Q:EditorApp);
{$ENDIF}
Function  TEChangeView(Var Q:EditorApp):Boolean;
Procedure TEEdtChrType(Var Q:EditorApp);
Procedure TEFiltre(Var Q:EditorApp);
Function  TEFindObject(Var Q:EditorApp;Var Position:Word):Pointer;
Procedure TEInfoDocument(Var Q:EditorApp);
Procedure TEInsLineHor(Var Q:EditorApp;Selection:Byte);
Procedure TELineHor(Var Q:EditorApp;New:Boolean);
Procedure TEMakeCadre(Var Q:EditorApp);
Procedure TEMove2(Var Q;X,Y:Byte);
{$IFNDEF __Windows__}
 Procedure TEPasMacro(Var Q:EditorApp);
{$ENDIF}
Procedure TESaut(Var Q:EditorApp);
Procedure TESetList4Bloc(Var Q:EditorApp);
Function  TETitle(Var Context;Max:Byte):String;
Procedure TETri(Var Q:EditorApp);
Procedure TEReSize(Var Q;X1,Y1,X2,Y2:Byte);
Function  TEActionMouse(Var Q:EditorApp):Word;
Procedure TEXChgPg(Var Q:EditorApp;PgA,PgB:LongInt);

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                               IMPLEMENTATION
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Uses
 Adele,Systems,Memories,Math,SysPlus,Mouse,Dials,Dialex,DialPlus,
 Editex,Editor,Video,Restex,ResServD,EdtLoad,EdtBlock,ToolDB;

{$I \Source\Chantal\POSX2GAT.Inc}
{$I \Source\Chantal\_TESetMo.Inc}
{$I \Source\Chantal\TESetPtr.Inc}
{$I \Source\Chantal\TEPopCur.Inc}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                     Proc‚dure RBLoadPckStrByte                   Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de transformer une banque de donn‚e continue
 de chaŒne de caractŠres et de les mettre dans une liste.
}

Procedure RBLoadPckStrByte(Var Q:ArrayList;X:Pointer);
Var
 J:Word;
 XB:^TByte Absolute X;
 S:String;
 L:Byte;
Begin
 J:=0;
 While XB^[J]<>0do Begin
  L:=XB^[J+1]+1;
  MoveLeft(XB^[J+1],S,L);
  ALAddStrByte(Q,S,XB^[J]);
  Inc(J,L+1);
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Proc‚dure TEChangeView                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: Edt


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction offre la possibilit‚ … l'utilisateur de changer le mode
 de visionnement du traŒtement de texte  pour qu'il puisse choisir entre
 des formats aussi divers que GAT, Assembleur, Pascal,...
}

Function TEChangeView;
Var
 K:Word; { Code clavier (scan et caractŠre) }
Begin
 TEChangeView:=False;
 If __GetMouseButton=0Then Begin
  LastMouseX:=23;
  LastMouseY:=Q.W.T.Y2;
 End
  Else
 WaitMouseBut0;
 If LastMouseY>21Then Dec(LastMouseY,22);
 K:=RunMenuApp(34);
 Case(K)and$F000of
  $3000:Begin
   Q.ModeSub:=K and$0FFF;
   Q.Mode:=0;
   TESetViewMode(Q,vtBas);
   TEUpdateScr(Q);
   TEChangeView:=True;
  End;
  $B000:Begin
   Q.ModeSub:=K and$0FFF;
   Q.Mode:=0;
   TESetViewMode(Q,vtPas);
   TEUpdateScr(Q);
   TEChangeView:=True;
  End;
  Else Begin
   If K>$1AThen Exit;
   If(K<>Q.Mode)or((K in[vtBas,vtPas])and(Q.ModeSub<>0))Then Begin
    If K in[vtBas,vtPas]Then Begin
     Q.Mode:=0;
     Q.ModeSub:=0;
    End;
    TESetViewMode(Q,K);
    TEChangeView:=True;
   End;
  End;
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Proc‚dure TETri                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: Edt


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure offre … l'utilisateur la possibilit‚ de tri en ordre
 croissant une partie du texte ou le texte au complet.
}

Procedure TETri;
Label BreakTri;
Var
 tE,tI,tJ,tK,tM,tX,M,Min:Integer; { Variables de ®Tri¯ }
 PtrI,PtrM:PChr;                  { Pointeur sur la ligne I, M }
 W:Window;                        { Objet de boŒte de dialogue }
Begin
 If Q.List.Count>2Then Begin
  If(WarningMsgYesNo('Cette op‚ration va remettre en ordre toutes les lignes de textes de la fenˆtre courante! '+
                     'Etes-vous vraiment certaine d''effectuer quand mˆme cette op‚ration?')=kbNo)Then Exit;
  Case _InputMsg('Balayage de Tri','D‚sirez-vous effectuer une Tri complŠte du '+
               'texte ou seulement la partie s‚lectionner par le bloque?',
               'ComplŠte|Bloque|Annuler',wfLosange+wiInfo,CurrKrs.RemWin)of
   0:Begin
    tE:=Q.List.Count-1;
    Min:=0;
   End;
   1:Begin
    tE:=Q.BY2-Q.BY1;
    Min:=Q.BY1;
   End;
   2,255:Exit;
  End;
  PtrI:=_ALGetBuf(Q.List,tE);
  WEPushEndBar(W);
  WEPutLastBar('Tri des lignes par ordre alphab‚tique en cours...');
  If IsPChrEmpty(PtrI)Then Dec(tE);
  If tE>=2Then Begin
   M:=tE;
   Repeat
    ASM SHR tE,1;END;
    tJ:=0;tK:=M-tE;
    Repeat
     tI:=tJ;
     Repeat
      tM:=tI+tE;
      PtrI:=_ALGetBuf(Q.List,tI+Min);
      PtrM:=_ALGetBuf(Q.List,tM+Min);
      If Not(StrComp(PtrI,PtrM)>0)Then Break;
      ALXchgBuf(Q.List,tI+Min,tM+Min);
      Dec(tI,tE);
      {$IFNDEF __Windows__}
       If(KeyPress)and(ReadKey=kbEsc)Then Begin
        If(InputMsg('Attention','D‚sirez-vous interrompre le processus de tri '+
                    '… l''endroit actuellement rendu dans le texte?',
                    KeyYes+KeyNo,wfOctogone+wiExit,CurrKrs.WarningWin)=kbYes)Then Goto BreakTri;
       End;
      {$ENDIF}
     Until tI<0;
     Inc(tJ);
    Until tJ>tK;
   Until tE=1;
BreakTri:
   Q.Modified:=True;
   TERefresh(Q);
  End
   Else
  ErrNoMsgOk(errEdtTooLowTri);
  WEDone(W);
 End;
End;

{$IFNDEF __Windows__}
Procedure TEAsmStrMacro;
Label _Start;
Var
 W:Window;
 Wait:Byte;
 K:Word;
Begin
 If Not(KeyPress)Then Begin
  For Wait:=0to 20do Begin
   If(KeyPress)Then Goto _Start;
   WaitRetrace;
  End;
  WEInit(W,MaxXTxts-20,1,MaxXTxts,MaxYTxts-1);
  WEPushWn(W);
  WEPutWn(W,'Macro de ChaŒne',CurrKrs.Help.Window);
  SetAllKr(W.Palette.High,W.Palette.Border);
  WEPutTypingLn(W,'^Ctrl+B^  LODS^B^|^Ctrl+D^  LODS^D^|^Ctrl+W^  LODS^W^|'+
                  '^Ctrl+Y^  STOSB|^Ctrl+Z^  STOSW|^Ctrl+G^  SCASB|'+
                  '^Ctrl+A^  SC^A^SD|^Ctrl+H^  SCASW|^Ctrl+I^  CMPSB|'+
                  '^Ctrl+J^  CMPSW|^Ctrl+M^  ^M^OVSB|^Ctrl+K^  MOVSD|'+
                  '^Ctrl+O^  ^O^UTSB');
  WEPutTypingLn(W,'^Ctrl+L^  MOVSW|^Ctrl+R^  ^R^EP|^Ctrl+X^  E^X^TRN|'+
                  '^Ctrl+P^  ^P^ROC|^Ctrl+N^  ^N^EAR|^Ctrl+F^  ^F^AR|'+
                  '^Ctrl+U^  P^U^BLIC|^Ctrl+E^  ^E^ND'{|^Ctrl+S^  S^S^EG'});
  K:=WEReadk(W);
  WEDone(W);
 End
  Else
_Start:K:=ReadKey;
 Case(K)of
  kbCtrlA:TEPushStr(Q,'SCASD');
  kbCtrlB:TEPushStr(Q,'LODSB');
  kbCtrlC:TEPushSTr(Q,'PUSH');
  kbCtrlD:TEPushStr(Q,'LODSD');
  kbCtrlE:TEPushStr(Q,'END');
  kbCtrlF:TEPushStr(Q,'FAR');
  kbCtrlG:TEPushStr(Q,'SCASB');
  kbCtrlH:TEPushStr(Q,'SCASW');
  kbCtrlI:TEPushStr(Q,'CMPSB');
  kbCtrlJ:TEPushStr(Q,'CMPSW');
  kbCtrlK:TEPushStr(Q,'MOVSD');
  kbCtrlL:TEPushStr(Q,'MOVSW');
  kbCtrlM:TEPushStr(Q,'MOVSB');
  kbCtrlN:TEPushStr(Q,'NEAR');
  kbCtrlO:TEPushStr(Q,'OUTSB');
  kbCtrlP:TEPushStr(Q,'PROC');
  kbCtrlR:TEPushStr(Q,'REP');
  kbCtrlS:TEPushStr(Q,'SSEG');
  kbCtrlT:TEPushStr(Q,'POP');
  kbCtrlU:TEPushStr(Q,'PUBLIC');
  kbCtrlW:TEPushStr(Q,'LODSW');
  kbCtrlX:TEPushStr(Q,'EXTRN');
  kbCtrlY:TEPushStr(Q,'STOSB');
  kbCtrlZ:TEPushStr(Q,'STOSW');
 End;
End;

Procedure TEPasMacro;
Label _Start;
Var
 W:Window;
 Wait:Byte;
 K:Word;
Begin
 If Not(KeyPress)Then Begin
  For Wait:=0to 20do Begin
   If(KeyPress)Then Goto _Start;
   WaitRetrace;
  End;
  WEInit(W,MaxXTxts-30,1,MaxXTxts,MaxYTxts-1);
  WEPushWn(W);
  WEPutWn(W,'Macro de Mots r‚serv‚',CurrKrs.Help.Window);
  SetAllKr(W.Palette.High,W.Palette.Border);
  WEPutTypingLn(W,'^Ctrl+A^  ^A^ssembler;|'+
                  '^Ctrl+B^  ^B^egin|'+
                  '^Ctrl+C^  ^C^onst|'+
                  '^Ctrl+D^  ^D^estructor|'+
                  '^Ctrl+E^  ^E^nd|'+
                  '^Ctrl+F^  ^F^unction|'+
                  '^Ctrl+G^  ^G^oto|'+
                  '^Ctrl+H^  IMPLEMENTATION|'+
                  '^Ctrl+I^  ^I^nterface|'+
                  '^Ctrl+J^  Repeat|'+
                  '^Ctrl+K^  ^K^eyPressed|'+
                  '^Ctrl+L^  ^L^abel|'+
                  '^Ctrl+M^  ^m^od');
  WEPutTypingLn(W,'^Ctrl+N^  ^N^ear|'+
                  '^Ctrl+O^  ^O^bject|'+
                  '^Ctrl+P^  ^P^rocedure|'+
                  '^Ctrl+Q^  Program|'+
                  '^Ctrl+R^  ^R^ecord|'+
                  '^Ctrl+S^  ^S^tring|'+
                  '^Ctrl+T^  ^T^hen|'+
                  '^Ctrl+U^  ^U^ntil');
  K:=WEReadk(W);
  WEDone(W);
 End
  Else
_Start:K:=ReadKey;
 Case(K)of
  kbCtrlA:TEPushStr(Q,'Assembler;');
  kbCtrlB:TEPushStr(Q,'Begin');
  kbCtrlC:TEPushStr(Q,'Const');
  kbCtrlD:TEPushStr(Q,'Destructor');
  kbCtrlE:TEPushStr(Q,'End');
  kbCtrlF:TEPushStr(Q,'Function');
  kbCtrlG:TEPushStr(Q,'Goto');
  kbCtrlH:TEPushStr(Q,'IMPLEMENTATION');
  kbCtrlI:TEPushStr(Q,'Interface');
  kbCtrlJ:TEPushStr(Q,'Repeat');
  kbCtrlK:TEPushStr(Q,'KeyPressed');
  kbCtrlL:TEPushStr(Q,'Label');
  kbCtrlM:TEPushStr(Q,'mod');
  kbCtrlN:TEPushStr(Q,'Near');
  kbCtrlO:TEPushStr(Q,'Object');
  kbCtrlP:TEPushStr(Q,'Procedure');
  kbCtrlQ:TEPushStr(Q,'Program');
  kbCtrlR:TEPushStr(Q,'Record');
  kbCtrlS:TEPushStr(Q,'String');
  kbCtrlT:TEPushStr(Q,'Then');
  kbCtrlU:TEPushStr(Q,'Until');
  kbCtrlV:TEPushStr(Q,'Virtual;');
  kbCtrlW:TEPushStr(Q,'While');
  kbCtrlX:TEPushStr(Q,'xor');
  kbCtrlY:TEPushStr(Q,'Type');
  kbCtrlZ:TEPushStr(Q,'Export');
 End;
End;

Procedure TECMacro;
Label _Start;
Var
 W:Window;
 Wait:Byte;
 K:Word;
Begin
 If Not(KeyPress)Then Begin
  For Wait:=0to 20do Begin
   If(KeyPress)Then Goto _Start;
   WaitRetrace;
  End;
  WEInit(W,MaxXTxts-30,1,MaxXTxts,MaxYTxts-1);
  WEPushWn(W);
  WEPutWn(W,'Macro de Mots r‚serv‚',CurrKrs.Help.Window);
  SetAllKr(W.Palette.High,W.Palette.Border);
  WEPutTypingLn(W,'^Ctrl+A^  ^a^sm|'+
                  '^Ctrl+B^  dou^b^le|'+
                  '^Ctrl+C^  ^c^ontinue;|'+
                  '^Ctrl+D^  ^d^efault|'+
                  '^Ctrl+E^  ^e^xtern|'+
                  '^Ctrl+F^  ^f^loat|'+
                  '^Ctrl+G^  ^g^oto|'+
                  '^Ctrl+H^  ^h^uge|'+
                  '^Ctrl+I^  ^i^nterrupt;|'+
                  '^Ctrl+J^  switch(|'+
                  '^Ctrl+K^  brea^k^;|'+
                  '^Ctrl+L^  ^l^ong|'+
                  '^Ctrl+M^  unsigned');
  WEPutTypingLn(W,'^Ctrl+N^  ^n^ear|'+
                  '^Ctrl+O^  size^o^f(|'+
                  '^Ctrl+P^  ^p^ascal|'+
                  '^Ctrl+Q^  signed|'+
                  '^Ctrl+R^  ^r^eturn|'+
                  '^Ctrl+S^  ^s^truct|'+
                  '^Ctrl+T^  ^t^ypedef|'+
                  '^Ctrl+U^  ^u^nion');
  K:=WEReadk(W);
  WEDone(W);
 End
  Else
_Start:K:=ReadKey;
 Case(K)of
  kbCtrlA:TEPushStr(Q,'asm');
  kbCtrlB:TEPushStr(Q,'double');
  kbCtrlC:TEPushStr(Q,'continue;');
  kbCtrlD:TEPushStr(Q,'default');
  kbCtrlE:TEPushStr(Q,'extern');
  kbCtrlF:TEPushStr(Q,'float');
  kbCtrlG:TEPushStr(Q,'goto');
  kbCtrlH:TEPushStr(Q,'huge');
  kbCtrlI:TEPushStr(Q,'interrupt;');
  kbCtrlJ:TEPushStr(Q,'switch(');
  kbCtrlK:TEPushStr(Q,'break;');
  kbCtrlL:TEPushStr(Q,'long');
  kbCtrlM:TEPushStr(Q,'unsigned');
  kbCtrlN:TEPushStr(Q,'near');
  kbCtrlO:TEPushStr(Q,'sizeof(');
  kbCtrlP:TEPushStr(Q,'pascal');
  kbCtrlQ:TEPushStr(Q,'signed');
  kbCtrlR:TEPushStr(Q,'return');
  kbCtrlS:TEPushStr(Q,'struct');
  kbCtrlT:TEPushStr(Q,'typedef');
  kbCtrlU:TEPushStr(Q,'union');
  kbCtrlV:TEPushStr(Q,'void');
  kbCtrlW:TEPushStr(Q,'while');
  kbCtrlX:TEPushStr(Q,'_EAX');
  kbCtrlY:TEPushStr(Q,'public');
  kbCtrlZ:TEPushStr(Q,'private');
 End;
End;
{$ENDIF}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Proc‚dure TEFiltre                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: Edt


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de filtrer les caractŠres d'un autre code de
 page en le format IBM dans la fenˆtre de traŒtement de texte.
}

Procedure TEFiltre;
Var
 J:RBP;
 PC:PChr;
 L,I,N,RL:Word;
 W:Window;
 S1,S2:RBP;
 Chr:Char;
 Font:DataSetInMemory;
Begin
 WEPushEndBar(W);
 WEPutLastBar('Un instant S.V.P., adaptation en cours...');
{ DBOpenServerName(ChantalServer,'CHANTAL:/Country/ASCII2Ansi.Dat');}
 DBOpenServerName(ChantalServer,'CHANTAL:/Country/Ansi2ASCII.Dat');
 If Not DBCopyToMemory(ChantalServer,Font)Then Begin
  __OutOfMemory;
  Exit;
 End;
 If(Q.BY1<Q.BY2)or((Q.BY1=Q.BY2)and(Q.BX1<Q.BX2))Then Begin
  S1:=Q.BY1;S2:=Q.BY2;
 End
  Else
 Begin
  S1:=0;
  S2:=Q.List.Count-1;
 End;
 ALSetPtr(Q.List,S1);
 For J:=S1 to(S2)do Begin
  PC:=_ALGetCurrBuf(Q.List);
  I:=0;
  While PC^[I]<>#0do Begin
   If PC^[I]>#32Then Begin
    If DBLocateAbsIM(Font,0,PC^[I],[])Then Begin
     Inc(PtrRec(Font.CurrRec).Ofs);
     PC^[I]:=Font.CurrRec.Str^[1];
    End;
   End;
   Inc(I)
  End;
  {$IFNDEF __Windows__}
   If(KeyPress)and(ReadKey=kbEsc)Then Begin
    If(InputMsg('Attention','D‚sirez-vous interrompre le processus de filtrage '+
                '… l''endroit actuellement rendu dans le texte?',
                KeyYes+KeyNo,wfOctogone+wiExit,CurrKrs.WarningWin)=kbYes)Then Break;
   End;
  {$ENDIF}
  ALNext(Q.List)
 End;
 DBDispose(Font);
 TESetPtr(Q);
 WEDone(W);
 _TESetModified(Q);
 TERefresh(Q);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Proc‚dure TEReSize                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: Edt


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

   Cette proc‚dure permet de change la taille de la fenˆtre de l'‚diteur
  de traŒtement de texte de l'objet ®Edt¯.
}

Procedure TEReSize;Begin
 TEPutWn(EditorApp(Q),X1,Y1,X2,Y2);
 EditorApp(Q).W.RBPY:=$FF;
 If(Rules)Then Dec(EditorApp(Q).W.MaxY);
 If(EditorApp(Q).Mode=vtGat)and(IsGraf){and(HeightChr>=16)}Then Begin
{  Dec(Edt(Q).W.MaxY);}
  TEPutKeyTxt(EditorApp(Q));
 End;
 TEUpDateScr(EditorApp(Q));
 TEPutBar(EditorApp(Q));
 WESelRightBarPos(EditorApp(Q).W,EditorApp(Q).P,EditorApp(Q).List.Count-1);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                            Proc‚dure TEMove2                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: Edt
 Portabilit‚:  Global


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure d'actualiser la fenˆtre de traŒtement de texte de fa‡on
 … l'adapter au d‚placement sp‚cifier par le couple (X,Y).
}

Procedure TEMove2{Var Q;X,Y:Byte};Begin
 TEReSize(EditorApp(Q),X,Y,X+EditorApp(Q).W.T.X2-EditorApp(Q).W.T.X1,Y+EditorApp(Q).W.T.Y2-EditorApp(Q).W.T.Y1);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Proc‚dure TETitle                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: Edt
 Portabilit‚:  Global


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction retourne le nom de la fenˆtre d'‚diteur dans une limite
 de taille d‚finit par la variable de param‚trage ®Max¯.
}

Function TETitle;
Var
 S:String;
 Q:EditorApp Absolute Context;
Begin
 Case(Q.Mode)of
  vtPJ,vtGat:S:='Document';
  vtAda:S:='Ada';
  vtAsm:S:='Assembleur';
  vtBas:Begin
   Case(Q.ModeSub)of
    bmCK64:S:='BASIC de ®Commodore 64¯';
    bmApple:S:='BASIC de l''®Apple ][¯';
    bmCOCO3:S:='BASIC COULEUR du COCO 3';
    bmGWBASIC:S:='BASICA/GWBASIC';
    bmTurboBasic:S:='TurboBasic';
    bmGFABasic:S:='GFABasic';
    bmQBasic:S:='QBasic/QuickBasic';
    bmVisualBasic:S:='Visual Basic';
    bmAPSI:S:='BASIC APSI';
    bmBasicPro:S:='BasicPro';
    bmVAX:S:='BASIC VAX/Alpha';
    Else S:='Basic';
   End;
  End;
  vtC:S:='C/C++';
  vtCobol:S:='Cobol';
  vtEuphoria:S:='Euphoria';
  vtForth:S:='Forth';
  vtFortran:S:='Fortran';
  vtIni:S:='Initialisation';
  vtMsMnu:S:='Menu souris';
  vtPas:S:='Pascal';
  vtRC:S:='Ressource';
  vtAC:S:='AC';
  vtSQL:S:='SQL';
  Else S:='Texte';
 End;
 IncStr(S,' ');
 TETitle:=S+TruncName(Q.EditName,Max-Length(S))
End;

Procedure TEInfoDocument(Var Q:EditorApp);
Var
 L:Window;            { Sauvegarde de la ligne d'aide }
 J:Wd;                { Num‚ro de ligne courante }
 I:RBP;               { Num‚ro de colonne courante }
 Word:Long;           { Nombre de mot(s) }
 PC:PChr;             { Pointeur sur la ligne texte courante }
 F:(Off,Spc,Let,Sym); { tat de recherche }
 Data:Record
  CaptionName:String[12];
  CaptionSize:String[20];
  CaptionNumWord:String[10];
  CaptionAddPage:String[10];
  CaptionPage:String[10];
  CaptionX1:String[20];
  CaptionX2:String[20];
  CaptionY1:String[20];
  CaptionY2:String[20];
  NumObject:String[10];
 End;
Begin
 FillClr(Data,SizeOf(Data));
 WEPushEndBar(L);
 WEPutLastBar('Un instant S.V.P. compilation des donn‚es en cours...');
 Data.CaptionName:=Path2NoDir(Q.EditName);
 Data.CaptionSize:=CStr(Q.FileSize)+' octets';
 ALSetPtr(Q.List,0);
 Word:=0;
 For I:=0to Q.List.Count-1do Begin
  PC:=_ALGetCurrBuf(Q.List);
  If(PC<>NIL)Then Begin
   J:=0;F:=Off;
   While PC^[J]<>#0do Begin
    Case PC^[J]of
     #0..#31:;
     ' ':F:=Spc;
     'A'..'Z','a'..'z','€'..'¥':If(F<>Let)Then Begin
      F:=Let;
      Inc(Word)
     End;
     Else F:=Sym;
    End;
    Inc(J);
   End;
  End;
  ALNext(Q.List);
 End;
 WEDone(L);
 Data.CaptionNumWord:=CStr(Word);
 Data.CaptionAddPage:=CStr(Q.PageNumStart);
 Data.CaptionPage:=IntToStr(DivLong(Q.List.Count-1,Q.SheetFormat.Y2-Q.SheetFormat.Y1)+1);
 Data.CaptionX1:=WordToStr(Q.SheetFormat.X1)+'iŠme colonne';
 Data.CaptionX2:=WordToStr(Q.SheetFormat.X2)+'iŠme colonne';
 Data.CaptionY1:=IntToStr(Q.SheetFormat.Y1)+'iŠme ligne';
 Data.CaptionY2:=IntToStr(Q.SheetFormat.Y2)+'iŠme ligne';
 Data.NumObject:=CStr(Q.Processus.Count);
 ExecuteAppDPU(72,Data);
End;

Type
 MFormEdtChrType=Record
  Bold:MCheckBoxExtern;
  UnderLn:MCheckBoxExtern;
  Italic:MCheckBoxExtern;
  Inv:MCheckBoxExtern;
  Dbl:MCheckBoxExtern;
  Exp:MCheckBoxExtern;
  Extern:MExtern;
 End;

Procedure PutEdtChrType(Var R:ResourceWindow;Var Context);
Var
 GX1,GY1:Word;
Begin
 GX1:=(WEGetRX1(R.W)+16)shl 3;
 GY1:=GetRawY(WEGetRY1(R.W)+2);
 BoldIcon(GX1,GY1,R.W.CurrColor);
 UnderlineIcon(GX1,GY1+HeightChr,R.W.CurrColor);
 ItalicIcon(GX1,GY1+(HeightChr shl 1),R.W.CurrColor);
 SetGCube(GX1,GY1+HeightChr*3,'I',(R.W.CurrColor shr 4)+(R.W.CurrColor shl 4));
 DoubleIcon(GX1,GY1+(HeightChr shl 2),R.W.CurrColor);
 OutSmlTxtXY(GX1,GY1+HeightChr*5,'e',R.W.CurrColor);
End;

Function BoldOnPress(Var R:ResourceWindow;Var Context):Boolean;
Var
 FormEdtChrType:MFormEdtChrType Absolute Context;
Begin
 FormEdtChrType.Exp.Checked:=False;
 BoldOnPress:=True;
End;

Function ExpOnPress(Var R:ResourceWindow;Var Context):Boolean;
Var
 FormEdtChrType:MFormEdtChrType Absolute Context;
Begin
 FormEdtChrType.Bold.Checked:=False;
 FormEdtChrType.Underln.Checked:=False;
 FormEdtChrType.Italic.Checked:=False;
 FormEdtChrType.Inv.Checked:=False;
 FormEdtChrType.Dbl.Checked:=False;
 ExpOnPress:=True;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Proc‚dure EdtChrType                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure offre … l'utilisateur une possibilit‚ manuel de modifier
 le format de caractŠres du traŒtement de texte.
}

Procedure TEEdtChrType(Var Q:EditorApp);
Var
 Attr:Byte;
 FormEdtChrType:MFormEdtChrType;
Begin
 FillClr(FormEdtChrType,SizeOf(FormEdtChrType));
 FormEdtChrType.Extern.Call:=PutEdtChrType;
 Attr:=Q.ChrAttr;
 FormEdtChrType.Bold.Checked:=Boolean(Attr and cgBold);
 FormEdtChrType.Bold.OnPress:=BoldOnPress;
 FormEdtChrType.Bold.Context:=@FormEdtChrType;
 FormEdtChrType.UnderLn.Checked:=Boolean((Attr and cgUnderline)shr 1);
 FormEdtChrType.Underln.OnPress:=BoldOnPress;
 FormEdtChrType.Underln.Context:=@FormEdtChrType;
 FormEdtChrType.Italic.Checked:=Attr and cgItalic=cgItalic;
 FormEdtChrType.Italic.OnPress:=BoldOnPress;
 FormEdtChrType.Italic.Context:=@FormEdtChrType;
 FormEdtChrType.Inv.Checked:=Attr and cgInverse=cgInverse;
 FormEdtChrType.Inv.OnPress:=BoldOnPress;
 FormEdtChrType.Inv.Context:=@FormEdtChrType;
 FormEdtChrType.Dbl.Checked:=Attr and cgDouble=cgDouble;
 FormEdtChrType.Dbl.OnPress:=BoldOnPress;
 FormEdtChrType.Dbl.Context:=@FormEdtChrType;
 FormEdtChrType.Exp.Checked:=FormEdtChrType.Inv.Checked and FormEdtChrType.Bold.Checked;
 FormEdtChrType.Exp.OnPress:=ExpOnPress;
 FormEdtChrType.Exp.Context:=@FormEdtChrType;
 If(FormEdtChrType.Exp.Checked)Then Begin
  FormEdtChrType.Bold.Checked:=False;
  FormEdtChrType.UnderLn.Checked:=False;
  FormEdtChrType.Italic.Checked:=False;
  FormEdtChrType.Inv.Checked:=False;
  FormEdtChrType.Dbl.Checked:=False;
 End;
 If ExecuteAppDPU(102,FormEdtChrType)Then Begin
  If(FormEdtChrType.Exp.Checked)Then Attr:=cgExposant
   Else
  Attr:=Byte(FormEdtChrType.Bold.Checked)+
        (Byte(FormEdtChrType.UnderLn.Checked)shl 1)+
        (Byte(FormEdtChrType.Italic.Checked)shl 2)+
        (Byte(FormEdtChrType.Inv.Checked)shl 3)+
         (Byte(FormEdtChrType.Dbl.Checked)shl 4);
  TESetChrType(Q,Attr);
 End;
End;

Procedure TEPageSetup(Var Q:EditorApp);
Var
 FormPageSetup:Record
  NameAuthor:String;
  Description:String;
  X1,Y1,X2,Y2:Word;
  PageNumIn:PgNmType;
  PageNumStart:LongInt;
  InfoCompl:MCheckBox;
  Key:Byte;
 End;
 OldDescr:String;
Begin
 FillClr(FormPageSetup,SizeOf(FormPageSetup));
 FormPageSetup.NameAuthor:=StrPas(RegUserName);
 OldDescr:=SearchDescription(Q.EditName);
 FormPageSetup.Description:=OldDescr;
 FormPageSetup.X1:=Q.SheetFormat.X1;
 FormPageSetup.Y1:=Q.SheetFormat.Y1;
 FormPageSetup.X2:=Q.SheetFormat.X2;
 FormPageSetup.Y2:=Q.SheetFormat.Y2;
 FormPageSetup.PageNumStart:=Q.PageNumStart;
 FormPageSetup.PageNumIn:=Q.PageNumIn;
 FormPageSetup.InfoCompl.Checked:=Q.InfoCompl;
 If ExecuteAppDPU(103,FormPageSetup)Then Begin
  Q.SheetFormat.X1:=FormPageSetup.X1;
  Q.SheetFormat.Y1:=FormPageSetup.Y1;
  Q.SheetFormat.X2:=FormPageSetup.X2;
  Q.SheetFormat.Y2:=FormPageSetup.Y2;
  Q.PageNumStart:=FormPageSetup.PageNumStart;
  Q.PageNumIn:=FormPageSetup.PageNumIn;
  Q.InfoCompl:=FormPageSetup.InfoCompl.Checked;
  If(OldDescr<>FormPageSetup.Description)and(Q.EditName<>'')Then Begin
   SetDescription(Q.EditName,FormPageSetup.Description);
  End;
  _TESetModified(Q);
  TERefresh(Q);
 End;
End;

Procedure TESetupImage(Var Q:EditorApp);
Var
 FormPageSetup:Record
  FileName:String;
  Justified:MRadioButton;
 End;
 PImage:^DrawInEdt;
Begin
 PImage:=_ALGetCurrBuf(Q.Processus);
 FillClr(FormPageSetup,SizeOf(FormPageSetup));
 FormPageSetup.FileName:=PImage^.Path;
 FormPageSetup.Justified.Alignment:=Byte(PImage^.Pos);
 If ExecuteAppDPU(111,FormPageSetup)Then Begin
  PImage^.Path:=FormPageSetup.FileName;
  Byte(PImage^.Pos):=FormPageSetup.Justified.Alignment;
  _TESetModified(Q);
  TERefresh(Q);
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Fonction TEActionMouse                      Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: Edt


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet  d'effectuer l'op‚ration appropri‚e concernant la
 souris lorsqu'un ou des boutons de la souris sont enfonc‚s … l'int‚rieur
 de la fenˆtre de dialogue du traŒtement de texte.
}

Function TEActionMouse(Var Q:EditorApp):Word;
Const
 imView=$F001;             { Demande de regarde un fichier }
 imLoad=$F002;             { Demande de chargement en m‚moire d'un fichier }
 imCopy=$F003;             { Copie le bloque }
 imPaste=$F004;            { Coller le bloque }
 imWriteFile=$F005;        { crire dans un fichier le bloc }
 imBold=$F006;             { Mettre en gras le bloc }
 imDouble=$F007;           { Mettre en double largeur le bloc }
 imUnderline=$F008;        { Mettre en soulignement le bloc }
 imInverse=$F009;          { Mettre en mode inverse le bloc }
 imItalic=$F00A;           { Mettre en italique le bloc }
 imExposant=$F00B;         { Mettre en exposant le bloc }
 imWriteFileHTML=$F00C;    { Sauvegarde le bloc en HTML }
 imCharacter=$F00D;        { Modifier le caractŠre }
 imPageSetup=$F00E;        { Propri‚t‚ de la page }
 imLineHor=$F00F;          { Propri‚t‚ de la ligne horizontal }
 imKillLineHor=$F010;      { Supprimer la ligne horizontal }
 imImage=$F011;            { Propri‚t‚ de l'image}
 imKillImage=$F012;        { Supprimer l'image }
 imEditImage=$F013;        { dition de l'image }
 imInsertFunc=$F014;       { Insertion d'une fonction }
 imInsertFuncAlpha=$F015;  { Insertion d'une fonction alphanum‚rique }
 imInsertInstruction=$F016;{ Insertion d'une instruction }

Var
 B:Word;                   { tat des boutons souris }
 RX,RY:Integer;
 PC:PChr;                  { Pointeur sur la ligne courante texte }
 TM:MainMnuPtr;            { Pointeur sur le menu contextuel }
 K:Word;                   { Code clavier (scan et caractŠre) }
 Block:Boolean;            { Op‚ration de traŒtement de bloc disponible?}
 LMX,LMY,NX,NY,OX,OY:Byte; { Position souris, nouvelle et ancienne}
 FirstTime:Boolean;        { PremiŠre fois qu'elle est affich‚e?}
 PL:Array[0..9]of Boolean; { Liste des drapeaux du menu contextuel }
 PDrw:^DrawInEdt;          { D‚finition d'objet d'image }
 PLineHor:^LineHorInEdt Absolute PDrw;{ D‚finition d'objet de ligne horizontal }
 Model:Byte;               { Le modŠle reconnue }
 PO:Word;                  { Position de l'objet }

 Procedure EndBlock;Begin
  Q.BX1:=Q.BX2;Q.BY1:=Q.BY2;
  TEEndBlk(Q);
  TESetPtr(Q);
  PC:=_ALGetCurrBuf(Q.List);
  Q.PXG:=PosX2Gat1(PC,Q.PX);
 End;

 Procedure OpenCur;Begin
  If(IsGraf)Then WEPushCur(Q.W);
  If(Q.InsMode)Then SimpleCur
               Else FullCur;
 End;

 Procedure ClsCur;Begin
  CloseCur;
  If(IsGraf)Then WEPopCur(Q.W);
 End;

Begin
 TEActionMouse:=0;
 B:=GetMouseButton;
 LMX:=LastMouseX;
 LMY:=LastMouseY;
 OX:=$FF;OY:=$FF;
 FirstTime:=True;
 If B=1Then Begin { Positionne le curseur }
{  CloseCur;}
(*  __HideMousePtr;
  ClsCur;
  RX:=LastMsX-WEGetRX1(Q.W);RY:=LastMsY-WEGetRY1(Q.W);
   { Fixe la position Y }
  Q.P:=(Q.P-Q.Y)+RY;Q.Y:=RY;
  While(Q.P>=Q.Lst.NB)do RBAddLn(Q.Lst);
   { Fixe la position X }
  TESetPtr(Q);
  Q.PX:=(Q.PX-Q.X)+RX;Q.X:=RX;
  PC:=_RBGetCurrBuf(Q.Lst);
  If(Q.Mode=vtGat)Then Q.PXG:=PosX2Gat1(PC,Q.PX);
  TESetCur(Q);
  OpenCur;
  __ShowMousePtr;*)
  Repeat
   __GetMouseTextSwitch(NX,NY,B);
   If WEInWindow(Q.W,NX,NY)Then Begin
    If(NX<>LMX)or(NY<>LMY)Then Begin
     If(FirstTime)Then Begin
      __HideMousePtr;
      ClsCur;
      RX:=LMX-WEGetRX1(Q.W);RY:=LMY-WEGetRY1(Q.W);
       { Fixe la position Y }
      Q.P:=(Q.P-Q.Y)+RY;Q.Y:=RY;
       { Fixe la position X }
      TESetPtr(Q);
      Q.PX:=(Q.PX-Q.X)+RX;Q.X:=RX;
      PC:=_ALGetCurrBuf(Q.List);
      If(Q.Mode=vtGat)Then Q.PXG:=PosX2Gat1(PC,Q.PX);
      TESetCur(Q);
      TEHomeBlk(Q);
      FirstTime:=False;
      OpenCur;
      __ShowMousePtr;
     End;
     If(OX<>NX)or(OY<>NY)Then Begin
      __HideMousePtr;
      ClsCur;
      RX:=NX-WEGetRX1(Q.W);RY:=NY-WEGetRY1(Q.W);
       { Fixe la position Y }
      Q.P:=(Q.P-Q.Y)+RY;Q.Y:=RY;
       { Fixe la positino X }
      TESetPtr(Q);
      Q.PX:=(Q.PX-Q.X)+RX;Q.X:=RX;
      PC:=_ALGetCurrBuf(Q.List);
      If(Q.Mode=vtGat)Then Q.PXG:=PosX2Gat1(PC,Q.PX);
      TESetCur(Q);
      TEEndBlk(Q);
      OX:=NX;OY:=NY;
      OpenCur;
      __ShowMousePtr;
     End;
    End
     Else
    Begin
     __HideMousePtr;
     ClsCur;
     RX:=LastMouseX-WEGetRX1(Q.W);
     RY:=LastMouseY-WEGetRY1(Q.W);
      { Fixe la position Y }
     Q.P:=(Q.P-Q.Y)+RY;Q.Y:=RY;
     While(Q.P>=Q.List.Count)do ALAddLn(Q.List);
      { Fixe la position X }
     TESetPtr(Q);
     Q.PX:=(Q.PX-Q.X)+RX;Q.X:=RX;
     PC:=_ALGetCurrBuf(Q.List);
     If(Q.Mode=vtGat)Then Q.PXG:=PosX2Gat1(PC,Q.PX);
     TESetCur(Q);
     __ShowMousePtr;
     OpenCur;
    End;
   End;
  Until B=0;
{  OpenCur;}
 End
  Else
 Begin
  WaitMouseBut0;
  __HideMousePtr;
  CloseCur;
  If(IsGraf)Then WEPopCur(Q.W);
  Block:=True;
  If(Q.BY1>Q.BY2)Then Block:=False;
  If(Q.BY1=Q.BY2)and(Q.BX1>=Q.BX2)Then Block:=False;
   { Recherche des positions d'objet correspondante... }
  Model:=0;
  If Q.Processus.Count>0Then Begin
   PDrw:=TEFindObject(Q,PO);
   If(PDrw<>NIL)Then Model:=PDrw^.Model;
  End;
  PL[0]:=(SizeOfClipboard>0)or(Block);
  PL[1]:=Block;
  PL[2]:=PL[0];
  PL[3]:=Block;
  PL[4]:=(Block)and(Q.Mode in[vtAsm,vtPas]);
  PL[5]:=(Block)and(Q.Mode=vtGat);
  PL[6]:=Q.Mode=vtGat;
  PL[7]:=Model=mtLineHor;
  PL[8]:=Model=mtImage;
  PL[9]:=Q.Mode=vtBas;
  K:=_RunMenuApp(28,PL);
  Case(K)of
   imView:TEActionMouse:=kbView;
   imLoad:TEActionMouse:=kbLoad;
   imBold:Begin
    TEInvAttrBlk(Q,cgBold);
    EndBlock;
   End;
   imDouble:Begin
    TEInvAttrBlk(Q,cgDouble);
    EndBlock;
   End;
   imUnderline:Begin
    TEInvAttrBlk(Q,cgUnderline);
    EndBlock;
   End;
   imInverse:Begin
    TEInvAttrBlk(Q,cgInverse);
    EndBlock;
   End;
   imItalic:Begin
    TEInvAttrBlk(Q,cgItalic);
    EndBlock;
   End;
   imExposant:Begin
    TEInvAttrBlk(Q,cgExposant);
    EndBlock;
   End;
   imCopy:TECpyClipboard(Q);
   imPaste:TEPasteClipboard(Q);
   imWriteFile:TEWriteBlk(Q);
   imWriteFileHTML:TEWriteBlkHTML(Q);
   imCharacter:TEEdtChrType(Q);
   imPageSetup:TEPageSetup(Q);
   imLineHor:TELineHor(Q,False);
   imImage:TESetupImage(Q);
   imKillLineHor,imKillImage:Begin
    If(K=imKillLineHor)Then ALDelBuf(Q.List,Q.P);
    ALDelBuf(Q.Processus,PO);
    _TESetModified(Q);
    TESetPtr(Q);
    TEUpDateScr(Q)
   End;
   imEditImage:TEActionMouse:=kbEditImage;
   imInsertFunc:Begin
    TEPushStr(Q,DBChoice(LastMouseX,LastMouseY,LastMouseX-20,wnMax,
                'Fonction','CHANTAL:/Compilateur/Basic/Fonction.Dat',2));
   End;
   imInsertFuncAlpha:Begin
    TEPushStr(Q,DBChoice(LastMouseX,LastMouseY,LastMouseX-20,wnMax,
                'Fonction Alpha','CHANTAL:/Compilateur/Basic/FonctionString.Dat',1));
   End;
   imInsertInstruction:Begin
    TEPushStr(Q,DBChoice(LastMouseX,LastMouseY,LastMouseX-20,wnMax,
                'Instruction','CHANTAL:/Compilateur/Basic/Instruction.Dat',2));
   End;
  End;
  OpenCur;
  __ShowMousePtr;
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Proc‚dure TEXChgPg                          Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: Edt


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure ‚change 2 pages d'un document de traŒtement de texte de
 l'objet d'‚dition. Il ne s'applique donc qu'en mode GAT.  Il suppose que
 les pages commence … 1 et non pas … 0.
}

Procedure TEXChgPg;
Var
 PgAY1,PgBY1:RBP; { Num‚ro de ligne de la premiŠre et deuxiŠme page }
 J:RBP;           { Variable compteur de boucle }
Begin
 If(Q.Mode=vtGat)Then Begin
  If(PgA=0)or(PgB=0)Then ErrNoMsgOk(errPageNumInvalid)
   Else
  Begin
   Dec(PgA);Dec(PgB);
   PgAY1:=PgA*(Q.SheetFormat.Y2-Q.SheetFormat.Y1);
   PgBY1:=PgB*(Q.SheetFormat.Y2-Q.SheetFormat.Y1);
   If(PgAY1>Q.List.Count-1)or(PgBY1>Q.List.Count-1)Then ErrNoMsgOk(errPageNumNotFound)
    Else
   Begin
    For J:=0to Q.SheetFormat.Y2-Q.SheetFormat.Y1-1do If Not(ALXChgBuf(Q.List,PgAY1+J,PgBY1+J))Then
     ErrNoMsgOk(errSwapData);
    _TESetModified(Q);
    TESetPtr(Q);
    TEUpDateScr(Q)
   End
  End
 End
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                      Proc‚dure TEMakeCadre                     Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: Edt


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure est utilis‚e afin de permettre l'utilisation d'un
 cadre dans le traŒtement de texte.
}

Procedure TEMakeCadre(Var Q:EditorApp);
Label Restart;
Var
 Str,Str2,Str3,PS:String;
 Ok:Boolean;
 Err:Integer;
 Target,K,I:Word;
 P:Byte;
 W:Window;
 PC:Array[0..9]of PChr;
 Moy,Res:Byte;
 LB:Integer;
 PBuffer:Array[0..9]of Array[0..63]of Char;
 Make:Boolean;
 XPos:Array[0..9]of Byte;
Begin
 Target:=0;Ok:=False;Str:='';
 FillClr(PBuffer,SizeOf(PBuffer));
Restart:
 Repeat
  K:=_WinInp(40,'Cr‚ation d''un Cadre','Entrer le nombre de colonne:',False,Str);
  If(K=kbEsc)Then Exit;
  Val(Str,Target,Err);
  Ok:=Err=0;
  If Not(Ok)Then ErrNoMsgOk(NumberArabicExpected);
 Until Ok;
 If Target<>0Then Begin
  WEInitO(W,40,4+(Target shl 1));
  WEPushWn(W);
  WEPutWnKrDials(W,'Entr‚e les titres des colonnes');
  WECloseIcon(W);
  WEBar(W);
  WESetKr(W,$8F);
  For I:=1to(Target)do Begin
   PC[I-1]:=@PBuffer[I-1];
   WEBarSpcHorShade(W,1,1+((I-1)shl 1),wnMax);
  End;
  WEPutkHorDn(W,'$Correcte|Annule|Pr‚c‚dent');
  P:=0;Make:=False;
  Repeat
   Case(P)of
    0..9:Begin
     WESetInpColors(W,$8F,W.Palette.Sel);
     K:=_WEInput(W,1,1+(P shl 1),wnMax-1,64,PC[P]);
     WESetKr(W,$8F);
     WEBarSpcHorShade(W,1,1+(P shl 1),wnMax);
     WEPutTxtXY(W,1,1+(P shl 1),StrPas(PC[P]));
     Case(K)of
      kbClose,kbEsc:Break;
      kbDn,kbRight,kbTab:Begin
       Inc(P);
       If(P>=Target)Then P:=10;
      End;
      kbUp,kbLeft,kbShiftTab:If P=0Then P:=10
                                   Else Dec(P);
      kbEnter:P:=10;
     End;
    End;
    10:Case WEGetkHorDn(W,'$Correcte|Annule|Pr‚c‚dent')of
     0:Begin
      Make:=True;
      Break;
     End;
     2:Begin
      WEDone(W);
      Goto Restart;
     End;
     kbAbort,kbEsc,1:Break;
     kbShiftTab:P:=9;
     kbTab:P:=0;
    End;
   End;
  Until False;
  WEDone(W);
  If(Make)Then Begin
    { Cr‚ation de l'entˆte des cellules }
   LB:=(Q.SheetFormat.X2-Q.SheetFormat.X1-2);
   If LB<=0Then Begin
    ErrNoMsgOk(errHorizontalLimit);
    Exit;
   End;
   TEkEnterIns(Q);
   FillClr(XPos,SizeOf(XPos));
   Moy:=LB div Target;
   Res:=LB mod Target;
   For I:=0to Target-1do XPos[I]:=Moy*I+3;
   Str:='Ú'+MultChr('Ä',LB)+'¿';
   Str2:='³'+Spc(LB)+'³';
   Str3:='Æ'+MultChr('Í',LB)+'µ';
   If Target>1Then Begin
    For I:=1to Target-1do Begin
     Inc(XPos[I],Res);
     Str[XPos[I]]:='Â';
     Str2[XPos[I]]:='³';
     Str3[XPos[I]]:='Ø';
     Inc(XPos[I],2);
    End;
    For I:=0to Target-1do Begin
     PS:=StrPas(PC[I]);
     MoveLeft(PS[1],Str2[XPos[I]],Length(PS));
    End;
   End
    Else
   Begin
    PS:=StrPas(PC[0]);
    XPos[0]:=(LB-Length(PS))shr 1;
    MoveLeft(PS[1],Str2[XPos[I]],Length(PS));
   End;
   TEPushStr(Q,Str);
   TEkEnterIns(Q);
   TEPushStr(Q,Str2);
   TEkEnterIns(Q);
   TEPushStr(Q,Str3);
   TEkEnterIns(Q);
  End;
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Proc‚dure TESetList4Bloc                    Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: Edt


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet d'effectuer une mise … jour de l'identificateur
 de liste.  Ainsi  s'il n'y a pas  d'identificateur de liste,  il en est
 rajout‚ un.  Cependant s'il y en d‚j…  un et que le mode est d‚sactiv‚,
 il est enlev‚.
}

Procedure TESetList4Bloc(Var Q:EditorApp);
Var
 PC:PChr;          { Pointeur sur la ligne de traŒtement de texte courant }
 OtherChr:Boolean; { Autre caractŠre que de liste pr‚sent? }
 I:Word;           { Compteur de boucle }
Begin
 PC:=TEPopCurr(Q);
 Case(Q.ModeList)of
  mlBloc,mlRoman,mlArabic,mlAlphabetic:Begin
   TEkEnter(Q);
   TEkEnd(Q);
  End;
  mlNone:Begin
    {Recherche de la pr‚sence d'un identificateur de liste}
   I:=0;OtherChr:=False;
   While PC^[I]<>#0do Begin
    If Not(PC^[I]in[' ','ş'])Then Begin
     OtherChr:=True;
     Break;
    End;
    Inc(I);
   End;
    {Destruction si trouv‚e un identificateur}
   If Not(OtherChr)Then TEDelCurrLn(Q);
  End;
 End;
End;

Function LineHorToBar(Selection:Byte):Char;Near;Begin
 LineHorToBar:=#0;
 Case(Selection)of
  1:LineHorToBar:='ú';
  2:LineHorToBar:='*';
  3:LineHorToBar:='~';
  4:LineHorToBar:='-';
  5:LineHorToBar:='Ä';
  6:LineHorToBar:='_';
  7:LineHorToBar:='=';
  8:LineHorToBar:='Í';
  9:LineHorToBar:='ß';
  10:LineHorToBar:='Ü';
  11:LineHorToBar:='ş';
  12:LineHorToBar:='Û';
  13:LineHorToBar:='°';
  14:LineHorToBar:='±';
  15:LineHorToBar:='²';
 End;
End;

Procedure TEInsLineHor(Var Q:EditorApp;Selection:Byte);
Var
 LineHor:LineHorInEdt;
Begin
 ALInsStr(Q.List,Q.P,'');
 FillClr(LineHor,SizeOf(LineHor));
 LineHor.Model:=mtLineHor;
 LineHor.X1:=0;
 LineHor.Y1:=Q.P;
 LineHor.X2:=Q.SheetFormat.X2;
 LineHor.Y2:=LineHor.Y1+1;
 LineHor.Bar:=LineHorToBar(Selection);
 ALAddBlock(Q.Processus,SizeOf(LineHor),LineHor);
 TEUpDateScr(Q);
 TESetPtr(Q);
 _TESetModified(Q);
End;

{ Cette fonction retourne un pointeur sur l'object actuellement cliqu‚
 par la souris.
}

Function TEFindObject(Var Q:EditorApp;Var Position:Word):Pointer;
Var
 PDrw:^DrawInEdt; { D‚finition d'objet d'image }
 P:Word;          { Position de l'objet }
 I:Word;          { Compteur de boucle }
Begin
 TEFindObject:=NIL;
 If Q.Processus.Count>0Then Begin
  P:=(Q.P-Q.Y)+LastMouseY-WEGetRY1(Q.W);
  ALSetPtr(Q.Processus,0);
  For I:=0to Q.Processus.Count-1do Begin
   PDrw:=_ALGetCurrBuf(Q.Processus);
   If(PDrw<>NIL)Then Begin
    If(PDrw^.Y1<=P)and(PDrw^.Y2>=P)Then Begin
     TEFindObject:=PDrw;
     Position:=I;
     Break;
    End;
   End;
   ALNext(Q.Processus);
  End;
 End;
End;

Procedure LineHorLoadList(Var L:LstMnu;Var Context);Begin
 ALAddStrByte(L.List,MultChr('ú',32),1);
 ALAddStrByte(L.List,MultChr('*',32),2);
 ALAddStrByte(L.List,MultChr('~',32),3);
 ALAddStrByte(L.List,MultChr('-',32),4);
 ALAddStrByte(L.List,MultChr('Ä',32),5);
 ALAddStrByte(L.List,MultChr('_',32),6);
 ALAddStrByte(L.List,MultChr('=',32),7);
 ALAddStrByte(L.List,MultChr('Í',32),8);
 ALAddStrByte(L.List,MultChr('ß',32),9);
 ALAddStrByte(L.List,MultChr('Ü',32),10);
 ALAddStrByte(L.List,MultChr('ş',32),11);
 ALAddStrByte(L.List,MultChr('Û',32),12);
 ALAddStrByte(L.List,MultChr('°',32),13);
 ALAddStrByte(L.List,MultChr('±',32),14);
 ALAddStrByte(L.List,MultChr('²',32),15);
End;

Procedure TELineHor(Var Q:EditorApp;New:Boolean);
Var
 PLineHor:^LineHorInEdt; { D‚finition d'objet de ligne horizontal }
 FormLineHor:Record
  Selection:MListBox;
 End;
Begin
 FillClr(FormLineHor,SizeOf(FormLineHor));
 If Not(New)Then Begin
  PLineHor:=_ALGetCurrBuf(Q.Processus);
  If(PLineHor<>NIL)Then Begin
    { Trouve la bonne position...}
   Case(PLineHor^.Bar)of
    'ú':FormLineHor.Selection.ItemIndex:=0;
    '*':FormLineHor.Selection.ItemIndex:=1;
    '~':FormLineHor.Selection.ItemIndex:=2;
    '-':FormLineHor.Selection.ItemIndex:=3;
    'Ä':FormLineHor.Selection.ItemIndex:=4;
    '_':FormLineHor.Selection.ItemIndex:=5;
    '=':FormLineHor.Selection.ItemIndex:=6;
    'Í':FormLineHor.Selection.ItemIndex:=7;
    'ß':FormLineHor.Selection.ItemIndex:=8;
    'Ü':FormLineHor.Selection.ItemIndex:=9;
    'ş':FormLineHor.Selection.ItemIndex:=10;
    'Û':FormLineHor.Selection.ItemIndex:=11;
    '°':FormLineHor.Selection.ItemIndex:=12;
    '±':FormLineHor.Selection.ItemIndex:=13;
    '²':FormLineHor.Selection.ItemIndex:=14;
   End;
  End;
 End
  Else
 PLineHor:=NIL;
 FormLineHor.Selection.LoadList:=LineHorLoadList;
 If ExecuteAppDPU(107,FormLineHor)Then Begin
  If(PLineHor<>NIL)Then Begin
   PLineHor^.Bar:=LineHorToBar(FormLineHor.Selection.ItemIndex);
   TEUpDateScr(Q);
   TESetPtr(Q);
   _TESetModified(Q);
  End
   Else
  TEInsLineHor(Q,FormLineHor.Selection.ItemIndex);
 End;
End;

Procedure TESaut(Var Q:EditorApp);
Var
 FormSaut:Record
  TypeSaut:Byte;
 End;
Begin
 FillClr(FormSaut,SizeOf(FormSaut));
 If ExecuteAppDPU(117,FormSaut)Then Begin
  Case(FormSaut.TypeSaut)of
   0:While Q.P mod(Q.SheetFormat.Y2-Q.SheetFormat.Y1)<>0do Begin
    TEkEnterIns(Q);
   End;
   1:TEkEnterIns(Q);
  End;
 End;
End;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
END.