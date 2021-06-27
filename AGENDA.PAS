{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                                                                      Û
 ³                      Malte Genesis/Agenda                            Û
 ³          dition Chantal pour Mode R‚el/IV - Version 1.1             Û
 ³                                                                      Û
 ³     Tous droits r‚serv‚s par les Chevaliers de Malte XXIe siŠcle     Û
 ³                                                                      Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Nom du programmeur
 ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ

  Sylvain Maltais


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette unit‚ est destin‚  … offrir tous  les  services  n‚cessaires pour
 obtenir un agenda primitif lequel permettra de contenir les informations
 sur quelqeus individus.
}

{$I DEF.INC}

Unit Agenda;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                                 INTERFACE
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Uses Isatex;

Function  APInit(Var Context;X1,Y1,X2,Y2:Byte):Boolean;
Procedure APRefresh(Var Context);
Function  APRun(Var Context):Word;
Function  APTitle(Var Context;Max:Byte):String;
Procedure APMove2(Var Context;X,Y:Byte);
Function  APDone(Var Context):Word;
Procedure APPrnAll(Var Q:AgendaApp);
Procedure APInfo(Var Q:AgendaApp;Const Person:String);
Function  APGetCurrEmail(Var Q:AgendaApp):String;
Procedure APSearchPerson(Var Q:AgendaApp);
Procedure SearchPerson;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                                IMPLEMENTATION
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Uses
 Adele,Systex,Memories,Systems,Mouse,Video,Dialex,Dials,DialPlus,ResTex,
 Pritex,ToolPrn,ResServI,ResLoadI,ResLoadD,ResServD,ResSaveD;

Type
 PersonRec=Record
  NoPersonne:Word;
  Alias:String[30];
  Initial:String[10];
  Prenom:String[30];
  Nom:String[30];
  Fonction:String[20];
  Societe:String[30];
  Adresse:String[40];
  Ville:String[20];
  Province:String[10];
  Pays:String[20];
  CodePostal:String[6];
  Courriel:String[50];
  Note:String;
  IconeAssociee:String;
 End;

 PersonData=Record
  Person:PersonRec;
  Number:MButton;
  Icon:MButton;
 End;

 PhoneData=Record
  NoPersonne:Word;
  Etiquette:String[10];
  IndicatifPays:String[3];
  CodeRegion:String[10];
  Numero:String[20];
 End;

{ Cette fonction retourne une chaŒne de caractŠres correspondant au
 num‚ro de t‚l‚phone contenu dans le paramŠtre.
}

Function PhoneNumber(Var Data:PhoneData):String;
Var
 Str:String;
Begin
 If Data.CodeRegion<>''Then Str:='('+Data.CodeRegion+') '+Data.Numero
                       Else Str:=Data.Numero;
 If Data.Etiquette<>''Then AddStr(Str,' ('+Data.Etiquette+')');
 PhoneNumber:=Str;
End;

{ Cette fonction permet d'ins‚rer un nouveau num‚ro de t‚l‚phone … un
 individu d‚ja existant.
}

Function InsertPhoneNumber(Var Context):String;
Var
 Q:AgendaApp Absolute Context;
 Data:PhoneData;
Begin
 InsertPhoneNumber:='';
 If Q.MP>=32Then ErrNoMsgOk(TooManyPhoneNumber)
  Else
 Begin
  FillClr(Data,SizeOf(Data));
  Data.NoPersonne:=Q.NoPersonne;
  If ExecuteAppDPU(98,Data.Etiquette)Then Begin
   DBEnd(Q.Phone);
   DBWriteRec(Q.Phone,Data);
   InsertPhoneNumber:=PhoneNumber(Data);
  End;
 End;
End;

{ Cette fonction permet de modifier un num‚ro de t‚l‚phone existant
}

Function ModifiedPhoneNumber(Var Context;P:Word):String;
Var
 Q:AgendaApp Absolute Context;
 Data:PhoneData;
Begin
 ModifiedPhoneNumber:='';
 DBMoveTo(Q.Phone,Q.TPhone[P]);
 DBReadRec(Q.Phone,Data);
 Data.NoPersonne:=Q.NoPersonne;
 If ExecuteAppDPU(98,Data.Etiquette)Then Begin
  DBMoveTo(Q.Phone,Q.TPhone[P]);
  DBWriteRec(Q.Phone,Data);
  ModifiedPhoneNumber:=PhoneNumber(Data);
 End;
End;

{ Cette proc‚dure permet de cr‚er la base de donn‚es des personnes …
 l'aide d'un code source SQL.
}

Procedure DBMakePerson(Var Q:DataSet);Begin
 DBCreateWithAppIndex(Q,96);
End;

{ Cette proc‚dure permet de cr‚er la base de donn‚es des num‚ros de
 t‚l‚phone … l'aide d'un code source SQL.
}


Procedure DBMakePhone(Var Q:DataSet);Begin
 DBCreateWithAppIndex(Q,97);
End;

{ Cette proc‚dure permet de charger dans une ®Liste Box¯ les num‚ros de
 t‚l‚phone d'un individu en particulier.
}

Procedure LoadNumber(Var Q:AgendaApp;Var L:LstMnu);
Var
 I:Word;
 Data:PhoneData;
Begin
 DBFirst(Q.Phone);
 Q.MP:=0;I:=0;
 Repeat
  DBReadRec(Q.Phone,Data);
  If(Data.NoPersonne=Q.NoPersonne)Then Begin
   Q.TPhone[Q.MP]:=I;
   ALAddStr(L.List,PhoneNumber(Data));
   Inc(Q.MP);
  End;
  If Q.MP>=32Then Break;
  Inc(I);
 Until DBEOF(Q.Phone);
End;

Function OnClickButton2PhoneNumber(Var Context;P:Word;Var Insert:Boolean):String;
Label
 Ins;
Var
 Q:AgendaApp Absolute Context;
Begin
 OnClickButton2PhoneNumber:='';
 Case RunMenuApp(128)of
  $F001:If Q.MP=0Then Goto Ins
                 Else ModifiedPhoneNumber(Context,P);
  $F002:Ins:InsertPhoneNumber(Context);
 End;
End;

{ Cette proc‚dure est une routine d'appel lorsque le bouton num‚ro de
 t‚l‚phone est appeler. En somme, elle est utiliser pour afficher une
 liste des num‚ros actuellement associ‚ … la personne courante.
}

Procedure OnPressNumber(Var R:ResourceWindow;Var Context);
Var
 Q:AgendaApp Absolute Context;
 L:LstMnu;
Begin
 LMInitCenter(L,40,10,'Num‚ro de t‚l‚phone',CurrKrs.Dialog.Env.List);
 L.OnInsert:=InsertPhoneNumber;
 L.Context:=@Q;
 L.OnModified:=ModifiedPhoneNumber;
 L.OnClickButton2:=OnClickButton2PhoneNumber;
 LoadNumber(Q,L);
 LMRun(L);
 LMDone(L);
End;

{ Cette proc‚dure est appel‚e syst‚matiquement … chaque enfoncement du
 bouton ic“ne. Elle permet de s‚lectionner un ic“ne particulier pour
 un individu.
}

Procedure OnPressIcon(Var R:ResourceWindow;Var Context);
Var
 H:History;
 Data:PersonData Absolute Context;
 Str:String;
Begin
 HYInit(H,0);
 Str:=_OpenWinModel('*.*','Ouvre Ic“ne',H,omIcon);
 If Str<>''Then Data.Person.IconeAssociee:=Str;
 HYDone(H);
End;

{ Cette proc‚dure permet d'ins‚rer une nouvelle personne dans l'agenda
}

Procedure InsPerson(Var Q:AgendaApp);
Var
 Data:PersonData;
Begin
 FillClr(Data,SizeOf(Data));
 Data.Person.NoPersonne:=DBNumRec(Q.Person)+1;
 While DBLocateAbs(Q.Person,0,Data.Person.NoPersonne,[])do Begin
  Inc(Data.Person.NoPersonne);
  If Data.Person.NoPersonne=$FFFFThen Begin
   ErrNoMsgOk(TooManyPerson);
   Exit;
  End;
 End;
 Q.NoPersonne:=Data.Person.NoPersonne;
 Data.Number.OnPress:=OnPressNumber;
 Data.Number.Context:=@Q;
 Data.Icon.OnPress:=OnPressIcon;
 Data.Icon.Context:=@Data;
 If ExecuteAppDPU(63,Data.Person.Alias)Then Begin
  DBEnd(Q.Person);
  DBWriteRec(Q.Person,Data);
 End;
End;

{ Cette fonction retourne la position afficher d'une personne
}

Function APPos(Var Q:AgendaApp;P:LongInt):LongInt;Begin
 If(Q.Tried)and(Q.Tri<>NIL)Then APPos:=Q.Tri^[P]
                           Else APPos:=P;
End;

{ Cette fonction retourne la position physique d'une personne
}

Function AP2Pos(Var Q:AgendaApp;P:LongInt):LongInt;
Var
 I:Word;
Begin
 If(Q.Tried)and(Q.Tri<>NIL)Then Begin
  AP2Pos:=0;
  For I:=0to Q.NumTri-1do If P=Q.Tri^[I]Then Begin
   AP2Pos:=I;
   Break;
  End;
 End
  Else
 AP2Pos:=P;
End;

Function APReadPerson(Var Q:AgendaApp;P:LongInt;Var Person:PersonRec):Boolean;Begin
 APReadPerson:=DBMoveTo(Q.Person,APPos(Q,P));
 DBReadRec(Q.Person,Person);
End;

Function EditPerson(Var Q:AgendaApp):Boolean;
Var
 Data:PersonData;
Begin
 EditPerson:=False;
 FillClr(Data,SizeOf(Data));
 APReadPerson(Q,Q.P,Data.Person);
 If DBLocateAbs(Q.Person,0,Data.Person.NoPersonne,[])Then Begin
  If(APPos(Q,Q.P)<>Q.Person.CurrLine)Then Begin
   If(WarningMsgYesNo('Code de num‚ro de personne non correspondant!')=kbYes)Then Begin
    While DBLocateAbs(Q.Person,0,Data.Person.NoPersonne,[])do Begin
     Inc(Data.Person.NoPersonne);
     If Data.Person.NoPersonne=$FFFFThen Begin
      ErrNoMsgOk(TooManyPersonInDB);
      Exit;
     End;
    End;
   End;
  End;
 End;
 Q.NoPersonne:=Data.Person.NoPersonne;
 Data.Number.OnPress:=OnPressNumber;
 Data.Number.Context:=@Q;
 Data.Icon.OnPress:=OnPressIcon;
 Data.Icon.Context:=@Data;
 If ExecuteAppDPU(63,Data.Person.Alias)Then Begin
  DBMoveTo(Q.Person,APPos(Q,Q.P));
  DBWriteRec(Q.Person,Data);
  EditPerson:=True;
 End;
End;

{ Cette proc‚dure initialise les donn‚es de l'objet agenda }

Procedure APInitData(Var Q:AgendaApp);Begin
 FillClr(Q,SizeOf(Q));
 Q.Tried:=True;
 Q.FileName:=MaltePath+'DATA\PERSONNE.DAT';
 Q.FileNamePhone:=MaltePath+'DATA\TELEPHON.DAT';
 If Not DBInit(Q.Person,Q.FileName)Then Begin
  DBMakePerson(Q.Person);
 End;
 If Not DBInit(Q.Phone,Q.FileNamePhone)Then Begin
  DBMakePhone(Q.Phone);
 End;
End;

{ Cette proc‚dure initialise l'objet agenda }

Function APInit(Var Context;X1,Y1,X2,Y2:Byte):Boolean;
Var
 Q:AgendaApp Absolute Context;
Begin
 APInit:=True;
 APInitData(Q);
 WEInit(Q.W,X1,Y1,X2,Y2);
 APRefresh(Context);
End;

Function NamePerson(Const Person:PersonRec):String;Begin
 If Person.Alias<>''Then NamePerson:=Person.Alias Else
 If(Person.Prenom<>'')and(Person.Nom<>'')Then NamePerson:=Person.Nom+', '+Person.Prenom Else
 If(Person.Prenom='')and(Person.Nom<>'')Then NamePerson:=Person.Nom Else
 If(Person.Prenom<>'')and(Person.Nom='')Then NamePerson:=Person.Prenom
                                        Else NamePerson:='';
End;

Function APLoadNumber(Var Q:AgendaApp):String;
Var
 Data:PhoneData;
Begin
 DBReadRec(Q.Phone,Data);
 APLoadNumber:=PhoneNumber(Data);
End;

Procedure APPutIcon(Var Q:AgendaApp;Const Person:PersonRec);
Var
 TX,TY:Byte;
 Icon:XInf;
Begin
 If Person.IconeAssociee<>''Then Begin
  TX:=WEGetRX1(Q.W);
  TY:=WEGetRY1(Q.W)+Q.Y+1;
  RILoadImage(Person.IconeAssociee,diAutoDetect,4,$FFFF,rmAllRes,[],Icon);
  RIPutImageScale(Icon,TX shl 3,GetRawY(TY),
                  16,HeightChr,Q.W.CurrColor shr 4);
  XFreeMem(Icon);
 End;
End;

Procedure _APPutIcon(Var Q:AgendaApp);
Var
 Person:PersonRec;
Begin
 If APReadPerson(Q,Q.P,Person)Then Begin
  APPutIcon(Q,Person);
 End;
End;

Procedure APPutLine(Var Q:AgendaApp;Y:Byte;P:LongInt);
Var
 Person:PersonRec;
 Str:String;
 Str2:String;
Begin
 If Not APReadPerson(Q,P,Person)Then Exit;
 Str:='';
 If DBLocateAbs(Q.Phone,0,Person.NoPersonne,[])Then Begin
  Str:=APLoadNumber(Q);
 End;
 Str2:=StrUSpc(NamePerson(Person),26)+StrUSpc(Person.Courriel,21);
 If(IsBanderolle)Then Begin
  WEBarSpcHorBanderolle(Q.W,1+Y,P);
  WEPutTxtXYT(Q.W,6,1+Y,Left(Str2,47));
  If Str<>''Then WEPutTxtXYT(Q.W,53,1+Y,Str);
 End
  Else
 Begin
  WEPutTxtXY(Q.W,6,1+Y,Str2);
  If Str<>''Then WEPutTxtXY(Q.W,53,1+Y,Str);
  WEClrEol(Q.W);
 End;
 APPutIcon(Q,Person);
End;

Procedure APSelectBar(Var Q:AgendaApp);Begin
 WESetKrSel(Q.W);
 WEBarSelHor(Q.W,0,1+Q.Y,wnMax);
 _APPutIcon(Q);
End;

Procedure APUnSelectBar(Var Q:AgendaApp);
Var
 S:String;
Begin
 If(IsBanderolle)Then Begin
  S:=WEGetStr(Q.W,6,1+Q.Y);
  WEBarSpcHorBanderolle(Q.W,1+Q.Y,Q.P);
  WEPutTxtXYT(Q.W,6,1+Q.Y,S);
 End
  Else
 Begin
  WESetKrBorder(Q.W);
  WEBarSelHor(Q.W,0,1+Q.Y,wnMax);
 End;
 _APPutIcon(Q);
End;

Procedure APTri(Var Q:AgendaApp);
Var
 I:Word;
 tE,tI,tJ,tK,tM,tX:Integer;
 StrI,StrM:String;
 Person:PersonRec;
Begin
 If Q.NumTri<>0Then Begin
  FreeMemory(Q.Tri,Q.NumTri shl 1);
 End;
 Q.NumTri:=DBNumRec(Q.Person);
 Q.Tri:=MemAlloc(Q.NumTri shl 1);
 If(Q.Tri<>NIL)Then Begin
  For I:=0to Q.NumTri-1do Q.Tri^[I]:=I;
  tE:=Q.NumTri-1;
  Q.Tried:=False;
  Repeat
   ASM SHR tE,1;END;
   tJ:=0;
   tK:=Q.NumTri-1-tE;
   Repeat
    tI:=tJ;
    Repeat
     tM:=tI+tE;
     APReadPerson(Q,Q.Tri^[tI],Person);
     StrI:=NamePerson(Person);
     APReadPerson(Q,Q.Tri^[tM],Person);
     StrM:=NamePerson(Person);
     If Not(StrI>StrM)Then Break;
     SwapWord(Q.Tri^[tI],Q.Tri^[tM]);
     Dec(tI,tE);
    Until tI<0;
    Inc(tJ);
   Until tJ>tK;
  Until tE=1;
  Q.Tried:=True;
 End;
End;

Procedure APUpdateLine(Var Q:AgendaApp);
Var
 I:Byte;
Begin
 If(Q.Tried)Then Begin
  If Q.NumTri<>DBNumRec(Q.Person)Then APTri(Q);
 End;
 WESetKrBorder(Q.W);
 For I:=0to Q.W.MaxY-1do APPutLine(Q,I,Q.P-Q.Y+I);
End;

Procedure APStatusBar(Var Q:AgendaApp);Begin
 WESetEndBar(Q.W,CurrKrs.Desktop.DialStatus);
 If(IsGrf)Then Begin
  BarSpcHorRelief(Q.W.T.X1,Q.W.T.Y2,Q.W.T.X2,CurrKrs.Desktop.DialStatus);
  BarSpcHorReliefExt(Q.W.T.X1+1,Q.W.T.Y2,Q.W.T.X2-2,CurrKrs.Desktop.DialStatus);
  LuxeBox(Q.W.T.X2-1,Q.W.T.Y2);
 End;
 WESetEndBarTxtX(Q.W,2,WordToStr(DBNumRec(Q.Person))+' personne(s)',CurrKrs.Desktop.DialStatus);
End;

Procedure APRefresh(Var Context);
Var
 Q:AgendaApp Absolute Context;
Begin
 WEPutWn(Q.W,APTitle(Q.FileName,Q.W.MaxX),CurrKrs.Dialog.Env.List);
 WECloseIcon(Q.W);
 WEZoomIcon(Q.W);
 WEPutBarMsRight(Q.W);
 LTInitWithWins(Q.LT,0,0,Q.W.MaxX,'Ic“ne|Nom|Courriel|T‚l‚phone',Q.W);
 LTSetColumnSize(Q.LT,1,25);
 LTSetColumnSize(Q.LT,2,20);
 LTRefresh(Q.LT);
 APStatusBar(Q);
 APUpdateLine(Q);
End;

Procedure APPrnPerson(Var Q:AgendaApp;Const Person:PersonRec);
Var
 J,MP:Word;
 L:ArrayList;
 Data:PhoneData;
 Name:String;
Begin
 Name:=NamePerson(Person);
 WriteLog('Impression de la personne '+Name);
 __SetPrnDouble;
 Prn(Name);
 __SetPrnSimple;
 PrnLn;
 If Person.Alias<>''Then Begin
  If Person.Initial<>''Then Prn(Person.Initial+' ');
  Prn(Person.Prenom+' '+Person.Nom);
  If Person.Fonction<>''Then Begin
   Prn(',');
   PrnLn;
   __SetPrnBold;
   Prn(Person.Fonction);
  __SetPrnUnBold;
  End;
  PrnLn;
 End;
 If Person.Societe<>''Then Begin
  __SetPrnBold;
  Prn(Person.Societe);
  __SetPrnUnBold;
  PrnLn;
 End;
 If Person.Adresse<>''Then Begin
  Prn(Person.Adresse);
  PrnLn;
 End;
 Prn(Person.Ville);
 If Person.Province<>''Then Begin
  If Person.Ville<>''Then Prn(', ');
  Prn(Person.Province);
 End;
 If Person.CodePostal<>''Then Prn(', '+Left(Person.CodePostal,3)+' '+Copy(Person.CodePostal,4,3));
 PrnLn;
 Prn(Person.Pays);
 PrnLn;
 PrnLn;
 DBFirst(Q.Phone);
 MP:=0;J:=0;
 Repeat
  DBReadRec(Q.Phone,Data);
  If(Data.NoPersonne=Person.NoPersonne)Then Begin
   Name:=PhoneNumber(Data);
   If Name<>''Then Begin
    Inc(MP);
    Prn('T‚l‚phone '+WordToStr(MP)+': '+Name);
    PrnLn;
   End;
  End;
  Inc(J);
 Until DBEOF(Q.Phone);
 If Person.Courriel<>''Then Begin
  Prn('Courriel: '+Person.Courriel);
  PrnLn;
 End;
 PrnLn;
 Prn(Person.Note);
 PrnLn;
 Prn(MultChr('Ä',78));
 PrnLn;
End;

Procedure APPrnCurrPerson(Var Q:AgendaApp);
Var
 Person:PersonRec;
Begin
 APReadPerson(Q,Q.P,Person);
 APPrnPerson(Q,Person);
End;

Procedure APKillIconPath(Var Q:AgendaApp);
Var
 Person:PersonRec;
Begin
 APReadPerson(Q,Q.P,Person);
 Person.IconeAssociee:='';
 DBMoveTo(Q.Person,APPos(Q,Q.P));
 DBWriteRec(Q.Person,Person);
 APUpdateLine(Q);
 APSelectBar(Q);
End;

Function APRun(Var Context):Word;
Label Edit;
Var
 Q:AgendaApp Absolute Context;
 K:Word;
 TY:Byte; { Coordonn‚e vertical temporaire }

 Procedure InsertPerson;Begin
  InsPerson(Q);
  APUnSelectBar(Q);
  APUpdateLine(Q);
  APSelectBar(Q);
  APStatusBar(Q);
 End;

 Procedure EditCurrPerson;Begin
  If EditPerson(Q)Then Begin
   APUnSelectBar(Q);
   APUpdateLine(Q);
   APSelectBar(Q);
  End;
 End;

 Procedure Up;Begin
  If Q.P>0Then Begin
   APUnSelectBar(Q);
   Dec(Q.P);
   If Q.Y>0Then Dec(Q.Y)
    Else
   Begin
    WEScrollUp(Q.W,0,1,wnMax,wnMax);
    APPutLine(Q,Q.Y,Q.P)
   End;
   APSelectBar(Q)
  End;
 End;

 Procedure Dn;Begin
  If Q.P<DBNumRec(Q.Person)-1Then Begin
   APUnSelectBar(Q);
   Inc(Q.P);
   If(Q.Y<Q.W.MaxY-1)Then Inc(Q.Y)
    Else
   Begin
    WEScrollDn(Q.W,0,1,wnMax,wnMax);
    APPutLine(Q,Q.Y,Q.P)
   End;
   APSelectBar(Q)
  End;
 End;

 Function MenuContext:Boolean;
 Var
  PL:Array[0..0]of Pointer;
 Begin
  MenuContext:=False;
  PL[0]:=@Q.Tried;
  Case _RunMenuApp(99,PL)of
   $F001:EditCurrPerson;
   $F002:InsertPerson;
   $F003:Begin
    APRefresh(Q);
    APSelectBar(Q);
   End;
   $F004:Begin
    Q.Tried:=Not(Q.Tried);
    APUnSelectBar(Q);
    APUpdateLine(Q);
    APSelectBar(Q);
   End;
   $F005:APPrnCurrPerson(Q);
   $F006:APPrnAll(Q);
   $F007:APSearchPerson(Q);
   $F008:APKillIconPath(Q);
   $F009:Begin
    MenuContext:=True;
    APRun:=kbSendMail;
   End;
  End;
 End;

Begin
 APSelectBar(Q);
 Repeat
  K:=WEReadk(Q.W);
  Case(K)of
   kbUp:Up;
   kbDn:Dn;
   kbRBarMsUp,kbRBarMsDn:Begin
    __HideMousePtr;
    Case(K)of
     kbRBarMsUp:Up;
     Else Dn;
    End;
    DelayMousePress(100);
    __ShowMousePtr;
   End;
   kbIns:InsertPerson;
   kbEnter:Edit:EditCurrPerson;
   kbInWn:If LastMouseB=2Then Begin
    WaitMouseBut0;
    If(MenuContext)Then Exit;
   End
    Else
   Begin
    TY:=LastMouseY-(WEGetRY1(Q.W)+1);
    If(Q.Y<>TY)Then Begin
     __HideMousePtr;
     APUnSelectBar(Q);
     Dec(Q.P,Q.Y);
     Q.Y:=TY;
     Inc(Q.P,Q.Y);
     APSelectBar(Q);
     __ShowMousePtr;
     WaitMouseBut0;
    End
     Else
    Begin
     WaitMouseBut0;
     Goto Edit;
    End;
   End;
   Else Begin
    APRun:=K;
    Break;
   End;
  End;
 Until False;
End;

Function APTitle(Var Context;Max:Byte):String;
Var
 Q:AgendaApp Absolute Context;
Begin
 APTitle:='Agenda';
End;

Procedure APMove2(Var Context;X,Y:Byte);
Var
 Q:AgendaApp Absolute Context;
 MX,MY:Byte;
Begin
 MX:=Q.W.T.X2-Q.W.T.X1;
 MY:=Q.W.T.Y2-Q.W.T.Y1;
 Q.W.T.X1:=X;
 Q.W.T.X2:=X+MX;
 Q.W.T.Y1:=Y;
 Q.W.T.Y2:=Y+MY;
 APRefresh(Q);
End;

Procedure APPrnAll(Var Q:AgendaApp);
Var
 Person:PersonRec;
 I,J:Word;
 OldLetter:Char;
 Str:String;
Begin
 __SetPrnInterLn1_8;
 OldLetter:=#0;
 For I:=0to DBNumRec(Q.Person)do Begin
  APReadPerson(Q,I,Person);
  Str:=NamePerson(Person);
  If(Str[1]<>OldLetter)Then Begin
   OldLetter:=Str[1];
   For J:=0to 37do PrnCharInverse(' ');
   PrnCharInverse(OldLetter);
   For J:=0to 37do PrnCharInverse(' ');
   PrnLn;
   PrnLn;
  End;
  APPrnPerson(Q,Person);
 End;
End;

Procedure LoadNumberListBox(Var L:LstMnu;Var Context);
Var
 Q:AgendaApp Absolute Context;
Begin
 LoadNumber(Q,L);
End;

Procedure APInfo(Var Q:AgendaApp;Const Person:String);
Var
 Data:Record
  Person:PersonRec;
  Number:Word;
  LoadNumberList:Procedure(Var L:LstMnu;Var Context);
  OnMoveNumber:Procedure(Var L:LstMnu;Var Context);
  ContextNumberList:Pointer;
 End;
 P:LongInt;
 I:Word;
Begin
 P:=-1;
 For I:=0to DBNumRec(Q.Person)do Begin
  APReadPerson(Q,I,Data.Person);
  If(StrUp(Person)=StrUp(NamePerson(Data.Person)))Then Begin
   P:=I;
   Break;
  End;
 End;
 If P=-1Then Begin
  If DBLocateAbs(Q.Person,3,Person,[soNoCaseSensitive])Then Begin
   P:=AP2Pos(Q,Q.Person.CurrLine);
  End
   Else
  If DBLocateAbs(Q.Person,4,Person,[soNoCaseSensitive])Then Begin
   P:=AP2Pos(Q,Q.Person.CurrLine);
  End
 End;
 If P=-1Then ErrNoMsgOk(PersonNotFound)
  Else
 Begin
  FillClr(Data,SizeOf(Data));
  APReadPerson(Q,P,Data.Person);
  Q.NoPersonne:=Data.Person.NoPersonne;
  Data.LoadNumberList:=LoadNumberListBox;
  Data.ContextNumberList:=@Q;
  PushKey(kbTab);
  ExecuteAppDPU(100,Data.Person.Alias);
 End;
End;

Function APGetCurrEmail(Var Q:AgendaApp):String;
Var
 Person:PersonRec;
Begin
 APReadPerson(Q,Q.P,Person);
 APGetCurrEmail:=Person.Courriel;
End;

Procedure APSearchPerson(Var Q:AgendaApp);
Var
 Name:String;
Begin
 Name:='';
 If(_WinInp(50,'Chercher une personne','Entrez le nom de la personne:',
    False,Name)=kbOk)Then APInfo(Q,Name);
End;

Procedure SearchPerson;
Var
 Q:AgendaApp;
Begin
 APInitData(Q);
 APSearchPerson(Q);
 APDone(Q);
End;

Function APDone(Var Context):Word;
Var
 Q:AgendaApp Absolute Context;
Begin
 If Q.NumTri<>0Then Begin
  FreeMemory(Q.Tri,Q.NumTri shl 1);
 End;
 DBDone(Q.Phone);
 DBDone(Q.Person);
 APDone:=0;
End;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
END.