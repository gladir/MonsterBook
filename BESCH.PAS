{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                                                                         Û
 ³                        Malte Genesis/Bescherelle                        Û
 ³                                                                         Û
 ³            dition Chantal pour Mode R‚el/IV - Version 1.1              Û
 ³                              1998/11/30                                 Û
 ³                                                                         Û
 ³          Tous droits r‚serv‚s par les Chevaliers de Malte (C)           Û
 ³                                                                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Nom du programmeur
 ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ

  Sylvain Maltais


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette unit‚ renferme toutes les routines n‚cessaire … l'utilisation du
 Bescherelle de verbe.
}

Unit Besch;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                                INTERFACE
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

{$I DEF.INC}

Procedure Bescherelle;
Procedure SearchVerb(Name:String);

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                               IMPLEMENTATION
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Uses Adele,Systex,Isatex,Memories,Systems,Video,Mouse,Dialex,Dials,DialPlus;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Fonction CmpRight                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de comparer … partir de la droite d'un mot une
 chaŒne de caractŠres.
}

Function CmpRight(Const S,Cmp:String):Boolean;Begin
 CmpRight:=Copy(S,1+Length(S)-Length(Cmp),Length(Cmp))=Cmp;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                             Proc‚dure PutVerbe                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure affiche … partir du nom d'un verbe toute les conjugaisons
 s'y rapportant … l'int‚rieur d'une boŒte de dialogue.
}

Procedure PutVerb(Const Verbe:String);
Var
 L:LstMnu;
 Auxiliere:(avoir,etre);
 ParticipePasse,T1,E:String;
 Temps:(PasseCompose,PlusQueParfait,PasseAnterieur,FuturAnterieur,
        SubPasse,SubPlusQueParfait,Imperatif,CondPasse);
Const
 PronomPer:Array[0..7]of String[5]=(
  'je',
  'tu',
  'il',
  'elle',
  'nous',
  'vous',
  'ils',
  'elles'
 );

  Procedure AddItem(X:Byte;Const Verbe:String);
  Var
   S,S2,ST:String;
  Begin
   If(Temps=Imperatif)Then S:=''
                      Else S:=PronomPer[X];
   Case(X)of
    0:Begin
	If Verbe[1]in['a','e','h','i','o','u','y']Then S:='j''';
	Case(Temps)of
PasseCompose:If(Auxiliere=avoir)Then S2:='ai'
                                Else S2:='suis';
PlusQueParfait:If(Auxiliere=avoir)Then S2:='avais'
                                  Else S2:='‚tais';
PasseAnterieur:If(Auxiliere=avoir)Then S2:='eus'
                                  Else S2:='fus';
FuturAnterieur:If(Auxiliere=avoir)Then S2:='aurai'
                                  Else S2:='serai';
SubPasse:If(Auxiliere=avoir)Then S2:='aie'
                            Else S2:='sois';
SubPlusQueParfait:If(Auxiliere=avoir)Then S2:='eusse'
                                     Else S2:='fusse';
Imperatif:S2:='';
CondPasse:If(Auxiliere=avoir)Then S2:='aurais'Else S2:='serais';
	End;
	If(Auxiliere=avoir)Then	ST:='j'''
                           Else ST:='je';
	If(Temps)in[SubPasse,SubPlusQueParfait]Then ST:='Que '+ST;
	S2:=StrUSpc(ST,10)+S2;
       End;
    1:Begin
	Case(Temps)of
PasseCompose:If(Auxiliere=avoir)Then S2:='as'
                                Else S2:='es';
PlusQueParfait:If(Auxiliere=avoir)Then S2:='avais'
                                  Else S2:='‚tais';
PasseAnterieur:If(Auxiliere=avoir)Then S2:='eus'
                                  Else S2:='fus';
FuturAnterieur:If(Auxiliere=avoir)Then S2:='auras'
                                  Else S2:='seras';
SubPasse:If(Auxiliere=avoir)Then S2:='aies'
                            Else S2:='sois';
SubPlusQueParfait:If(Auxiliere=avoir)Then S2:='eusses'
                                     Else S2:='fusse';
Imperatif:If(Auxiliere=avoir)Then S2:='aie'
                             Else S2:='sois';
CondPasse:If(Auxiliere=avoir)Then S2:='aurais'
                             Else S2:='serais';
	End;
       End;
    2:Begin
	Case(Temps)of
PasseCompose:If(Auxiliere=avoir)Then S2:='a'
                                Else S2:='est';
PlusQueParfait:If(Auxiliere=avoir)Then S2:='avait'
                                  Else S2:='‚tait';
PasseAnterieur:If(Auxiliere=avoir)Then S2:='eut'
                                  Else S2:='fut';
FuturAnterieur:If(Auxiliere=avoir)Then S2:='aura'
                                  Else S2:='sera';
SubPasse:If(Auxiliere=avoir)Then S2:='ait'
                            Else S2:='soit';
SubPlusQueParfait:If(Auxiliere=avoir)Then S2:='e–t'
                                     Else S2:='f–t';
Imperatif:S2:='';
CondPasse:If(Auxiliere=avoir)Then S2:='aurait'
                             Else S2:='serait';
	End;
       End;
    3:Begin
	Case(Temps)of
PasseCompose:If(Auxiliere=avoir)Then S2:='a'
                                Else S2:='est';
PlusQueParfait:If(Auxiliere=avoir)Then S2:='avait'
                                  Else S2:='‚tait';
PasseAnterieur:If(Auxiliere=avoir)Then S2:='eut'
                                  Else S2:='fut';
FuturAnterieur:If(Auxiliere=avoir)Then S2:='aura'
                                  Else S2:='sera';
SubPasse:If(Auxiliere=avoir)Then S2:='ait'
                            Else S2:='soit';
SubPlusQueParfait:If(Auxiliere=avoir)Then S2:='e–t'
                                     Else S2:='f–t';
Imperatif:S2:='';
CondPasse:If(Auxiliere=avoir)Then S2:='aurait'
                             Else S2:='serait';
	End;
       End;
    4:Begin
	Case(Temps)of
PasseCompose:If(Auxiliere=avoir)Then S2:='avons'
                                Else S2:='sommes';
PlusQueParfait:If(Auxiliere=avoir)Then S2:='avions'
                                  Else S2:='‚tions';
PasseAnterieur:If(Auxiliere=avoir)Then S2:='e–mes'
                                  Else S2:='f–mes';
FuturAnterieur:If(Auxiliere=avoir)Then S2:='aurons'
                                  Else S2:='serons';
SubPasse:If(Auxiliere=avoir)Then S2:='ayons'
                            Else S2:='soyons';
SubPlusQueParfait:If(Auxiliere=avoir)Then S2:='eussions'
                                     Else S2:='fussions';
Imperatif:If(Auxiliere=avoir)Then S2:='ayons'
                             Else S2:='soyons';
CondPasse:If(Auxiliere=avoir)Then S2:='aurions'
                             Else S2:='serions';
	End;
       End;
    5:Begin
	Case(Temps)of
PasseCompose:If(Auxiliere=avoir)Then S2:='avez'
                                Else S2:='ˆtes';
PlusQueParfait:If(Auxiliere=avoir)Then S2:='aviez'
                                  Else S2:='‚tiez';
PasseAnterieur:If(Auxiliere=avoir)Then S2:='e–tes'
                                  Else S2:='f–tes';
FuturAnterieur:If(Auxiliere=avoir)Then S2:='aurez'
                                  Else S2:='serez';
SubPasse:If(Auxiliere=avoir)Then S2:='ayez'
                            Else S2:='soyez';
SubPlusQueParfait:If(Auxiliere=avoir)Then S2:='eussiez'
                                     Else S2:='fussiez';
Imperatif:If(Auxiliere=avoir)Then S2:='ayons'
                             Else S2:='soyez';
CondPasse:If(Auxiliere=avoir)Then S2:='auriez'
                             Else S2:='seriez';
	End;
       End;
    6:Begin
	Case(Temps)of
PasseCompose:If(Auxiliere=avoir)Then S2:='ont'
                                Else S2:='sont';
PlusQueParfait:If(Auxiliere=avoir)Then S2:='avaient'
                                  Else S2:='‚taient';
PasseAnterieur:If(Auxiliere=avoir)Then S2:='eurent'
                                  Else S2:='furent';
FuturAnterieur:If(Auxiliere=avoir)Then S2:='auront'
                                  Else S2:='seront';
SubPasse:If(Auxiliere=avoir)Then S2:='aient'
                            Else S2:='soient';
SubPlusQueParfait:If(Auxiliere=avoir)Then S2:='eussent'
                                     Else S2:='fussent';
Imperatif:S2:='';
CondPasse:If(Auxiliere=avoir)Then S2:='auraient'
                             Else S2:='seraient';
	End;
       End;
    7:Begin
	Case(Temps)of
PasseCompose:If(Auxiliere=avoir)Then S2:='ont'
                                Else S2:='sont';
PlusQueParfait:If(Auxiliere=avoir)Then S2:='avaient'
                                  Else S2:='‚taient';
PasseAnterieur:If(Auxiliere=avoir)Then S2:='eurent'
                                  Else S2:='furent';
FuturAnterieur:If(Auxiliere=avoir)Then S2:='auront'
                                  Else S2:='seront';
SubPasse:If(Auxiliere=avoir)Then S2:='aient'
                            Else S2:='soient';
SubPlusQueParfait:If(Auxiliere=avoir)Then S2:='eussent'
                                     Else S2:='fussent';
Imperatif:S2:='';
CondPasse:If(Auxiliere=avoir)Then S2:='auraient'Else S2:='seraient';
	End;
       End;
   End;
   If(Temps)in[SubPasse,SubPlusQueParfait]Then Case(X)of
    0,1,4,5:InsStr(S,1,'Que ');
    Else InsStr(S,1,'Qu''');
   End;
   If X>0Then Begin
    If(Temps=Imperatif)Then ST:=''
                       Else ST:=StrUSpc(S,10);
    AddStr(ST,S2);
    S2:=ST;
   End;
   If(Auxiliere=etre)Then Case(X)of
    3:AddStr(S2,'e');
    4,5,6:AddStr(S2,'s');
    7:AddStr(S2,'es');
   End;
   If(Temps=Imperatif)Then ST:=StrUSpc(Verbe,30)+StrUSpc(S2,10)+ParticipePasse
   Else ST:=StrUSpc(S,10)+StrUSpc(Verbe,20)+StrUSpc(S2,20)+ParticipePasse;
   ALAddStr(L.List,ST);
  End;

  Procedure Ln;Begin
   ALAddLn(L.List)
  End;

  Procedure SetPasseCompose;Begin
   ALAddStr(L.List,'INDICATIF');
   Ln;
   Ln;
   ALAddStr(L.List,'Pr‚sent'+Spc(23)+'Pass‚ compos‚');Ln;
   Temps:=PasseCompose;
  End;

Begin
 Auxiliere:=avoir;
 LMInitCenter(L,MaxXTxts-10,MaxYTxts-6,'Verbe '+Verbe,CurrKrs.Help.Window);
 If Verbe='avoir'Then Begin
  ParticipePasse:='eu';
  SetPasseCompose;
  AddItem(0,'ai');
  AddItem(1,'as');
  AddItem(2,'a');
  AddItem(3,'a');
  AddItem(4,'avons');
  AddItem(5,'avez');
  AddItem(6,'ont');
  AddItem(7,'ont');
  Ln;
  Ln;
  ALAddStr(L.List,'Imparfait'+Spc(21)+'Plus-que-parfait');
  Ln;
  Temps:=PlusQueParfait;
  AddItem(0,'avais');
  AddItem(1,'avais');
  AddItem(2,'avait');
  AddItem(3,'avait');
  AddItem(4,'avions');
  AddItem(5,'aviez');
  AddItem(6,'avaient');
  AddItem(7,'avaient');
  Ln;
  Ln;
  ALAddStr(L.List,'Pass‚ simple'+Spc(18)+'Pass‚ ant‚rieur');
  Ln;
  Temps:=PasseAnterieur;
  AddItem(0,'eus');
  AddItem(1,'eus');
  AddItem(2,'eut');
  AddItem(3,'eut');
  AddItem(4,'e–mes');
  AddItem(5,'e–tes');
  AddItem(6,'eurent');
  AddItem(7,'eurent');
  Ln;
  Ln;
  ALAddStr(L.List,'Futur simple'+Spc(18)+'Futur ant‚rieur');
  Ln;
  Temps:=FuturAnterieur;
  AddItem(0,'aurai');
  AddItem(1,'auras');
  AddItem(2,'aura');
  AddItem(3,'aura');
  AddItem(4,'aurons');
  AddItem(5,'aurez');
  AddItem(6,'auront');
  AddItem(7,'auront');
  Ln;
  Ln;
  Ln;
  ALAddStr(L.List,'SUBJONCTIF');
  Ln;Ln;
  ALAddStr(L.List,'Pr‚sent'+Spc(23)+'Pass‚');
  Ln;
  Temps:=SubPasse;
  AddItem(0,'aie');
  AddItem(1,'aies');
  AddItem(2,'ait');
  AddItem(3,'ait');
  AddItem(4,'ayons');
  AddItem(5,'ayez');
  AddItem(6,'aient');
  AddItem(7,'aient');
  Ln;Ln;
  ALAddStr(L.List,'Imparfait'+Spc(21)+'Plus-que-parfait');
  Ln;
  Temps:=SubPlusQueParfait;
  AddItem(0,'eusse');
  AddItem(1,'eusses');
  AddItem(2,'e–t');
  AddItem(3,'e–t');
  AddItem(4,'eussions');
  AddItem(5,'eussiez');
  AddItem(6,'eussent');
  AddItem(7,'eussent');
  Ln;
  Ln;
  Ln;
  ALAddStr(L.List,'IMPRATIF');
  Ln;Ln;
  ALAddStr(L.List,'Pr‚sent'+Spc(23)+'Pass‚');
  Ln;
  Temps:=Imperatif;
  AddItem(1,'aie');
  AddItem(4,'ayons');
  AddItem(5,'ayez');
  Ln;Ln;Ln;
  ALAddStr(L.List,'CONDITIONNEL');
  Ln;Ln;
  ALAddStr(L.List,'Pr‚sent'+Spc(23)+'Pass‚');
  Ln;
  Temps:=SubPasse;
  AddItem(0,'aurais');
  AddItem(1,'aurais');
  AddItem(2,'aurait');
  AddItem(3,'aurait');
  AddItem(4,'aurions');
  AddItem(5,'auriez');
  AddItem(6,'auraient');
  AddItem(7,'auraient');
 End
  Else
 If CmpRight(Verbe,'er')Then Begin
  T1:=Left(Verbe,Length(Verbe)-2);
  ParticipePasse:=T1+'‚';
  E:=T1;
  Case T1[Length(T1)]of
   'c':E[Length(E)]:='‡';
   'g':IncStr(E,'e');
  End;
  SetPasseCompose;
  AddItem(0,T1+'e');
  AddItem(1,T1+'es');
  AddItem(2,T1+'e');
  AddItem(3,T1+'e');
  AddItem(4,E+'ons');
  AddItem(5,T1+'ez');
  AddItem(6,T1+'ent');
  AddItem(7,T1+'ent');
  Ln;
  Ln;
  ALAddStr(L.List,'Imparfait'+Spc(21)+'Plus-que-parfait');
  Ln;
  Temps:=PlusQueParfait;
  AddItem(0,E+'ais');
  AddItem(1,E+'ais');
  AddItem(2,E+'ait');
  AddItem(3,E+'ait');
  AddItem(4,T1+'ions');
  AddItem(5,T1+'iez');
  AddItem(6,E+'aient');
  AddItem(7,E+'aient');
  Ln;
  Ln;
  ALAddStr(L.List,'Pass‚ simple'+Spc(18)+'Pass‚ ant‚rieur');
  Ln;
  Temps:=PasseAnterieur;
  AddItem(0,E+'ai');
  AddItem(1,E+'as');
  AddItem(2,E+'a');
  AddItem(3,E+'a');
  AddItem(4,E+'ƒmes');
  AddItem(5,E+'ƒtes');
  AddItem(6,T1+'Šrent');
  AddItem(7,T1+'Šrent');
  Ln;
  Ln;
  ALAddStr(L.List,'Futur simple'+Spc(18)+'Futur ant‚rieur');
  Ln;
  Temps:=FuturAnterieur;
  AddItem(0,Verbe+'ai');
  AddItem(1,Verbe+'as');
  AddItem(2,Verbe+'a');
  AddItem(3,Verbe+'a');
  AddItem(4,Verbe+'ons');
  AddItem(5,Verbe+'ez');
  AddItem(6,Verbe+'ont');
  AddItem(7,Verbe+'ont');
  Ln;Ln;Ln;
  ALAddStr(L.List,'SUBJONCTIF');
  Ln;Ln;
  ALAddStr(L.List,'Pr‚sent'+Spc(23)+'Pass‚');
  Ln;
  Temps:=SubPasse;
  AddItem(0,T1+'e');
  AddItem(1,T1+'es');
  AddItem(2,T1+'e');
  AddItem(3,T1+'e');
  AddItem(4,T1+'ions');
  AddItem(5,T1+'iez');
  AddItem(6,T1+'ent');
  AddItem(7,T1+'ent');
  Ln;Ln;
  ALAddStr(L.List,'Imparfait'+Spc(21)+'Plus-que-parfait');
  Ln;
  Temps:=SubPlusQueParfait;
  AddItem(0,E+'asse');
  AddItem(1,E+'asses');
  AddItem(2,E+'ƒt');
  AddItem(3,E+'ƒt');
  AddItem(4,E+'assions');
  AddItem(5,E+'assiez');
  AddItem(6,E+'assent');
  AddItem(7,E+'assent');
  Ln;Ln;Ln;
  ALAddStr(L.List,'IMPRATIF');
  Ln;Ln;
  ALAddStr(L.List,'Pr‚sent'+Spc(23)+'Pass‚');
  Ln;
  Temps:=Imperatif;
  AddItem(1,T1+'e');
  AddItem(4,E+'ons');
  AddItem(5,T1+'ez');
  Ln;Ln;Ln;
  ALAddStr(L.List,'CONDITIONNEL');
  Ln;Ln;
  ALAddStr(L.List,'Pr‚sent'+Spc(23)+'Pass‚');
  Ln;
  Temps:=SubPasse;
  AddItem(0,Verbe+'ais');
  AddItem(1,Verbe+'ais');
  AddItem(2,Verbe+'ait');
  AddItem(3,Verbe+'ait');
  AddItem(4,Verbe+'ions');
  AddItem(5,Verbe+'iez');
  AddItem(6,Verbe+'aient');
  AddItem(7,Verbe+'aient');
 End
  Else
 Begin
  ErrMsgOk('Je suis sincŠrement d‚sol‚, j''ignore comment le conjuguer!');
  LMDone(L);
  Exit;
 End;
 LMRun(L);
 LMDone(L);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Proc‚dure Bescherelle                      Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure affiche une fenˆtre de dialogue permettant de voir la
 liste des verbes contenu dans le Bescherelle.
}

Procedure Bescherelle;
Var
 I:Byte;
 Handle:Hdl;
 W:Window;
 K:Word;
 FS,FP,AP:LongInt;
 Verbe:String;
Begin
 WEInitO(W,35,MaxYTxts-4);
 WEPushWn(W);
 WEPutWn(W,'Bescherelle de Conjugaison',CurrKrs.Help.Window);
 Handle:=FileOpen(MaltePath+'SPELL\VERBES.DTA',fmRead);
 WEPutBarMsRight(W);
 WECloseIcon(W);
 If(Handle=errHdl)Then Begin
  Handle:=FileOpen('VERBES.DTA',fmRead);
  If(Handle=errHdl)Then Begin
   __FileNotFound('VERBES.DTA');
   ErrMsgOk('D‚sol‚ j''ai besoin d''un minimum de quincaillerie pour pouvoir '+
	    'faire fonctionner un Bescherelle digne du nom!');
   Exit;
  End;
 End;
 FP:=0;AP:=0;FS:=FileSize(Handle);
 WESetPosHome(W);
 Repeat
  SetFilePos(Handle,FP+AP);
  _GetRec(Handle,SizeOf(Verbe),Verbe);
  WEPutTxtLn(W,Verbe);
  Inc(AP,Length(Verbe)+1)
 Until W.Y>W.MaxY;
 WESetPosHome(W);
 WESetKrSel(W);
 WEBarSelHor(W,0,0,wnMax);
 WESetKrBorder(W);
 Repeat
  K:=WEReadk(W);
  Case(K)of
   kbEnter:Begin
    _GetAbsRec(Handle,FP,SizeOf(Verbe),Verbe);
    PutVerb(Verbe);
   End;
   kbUp,kbRBarMsUp:Begin
    If(K=kbRBarMsUp)Then Begin WaitRetrace;WaitRetrace;End;
    If FP=0Then Beep
     Else
    Begin
     AP:=65;
     If(FP<AP)Then AP:=FP;
     _GetAbsRec(Handle,FP-AP,SizeOf(Verbe),Verbe);
     For I:=AP-1downto 0do If Verbe[I]<'&'Then Break;
     Dec(FP,AP-I);
     WESetKrBorder(W);
     WEBarSelHor(W,0,W.Y,wnMax);
     _GetAbsRec(Handle,FP,SizeOf(Verbe),Verbe);
     If W.Y>0Then Dec(W.Y)
      Else
     Begin
      _WEScrollUp(W);W.X:=0;
      WEPutTxt(W,Verbe);
      WEClrEol(W);
     End;
     WESetKrSel(W);
     WEBarSelHor(W,0,W.Y,wnMax);
    End;
   End;
   kbDn,kbRBarMsDn:Begin
    If(K=kbRBarMsDn)Then Begin WaitRetrace;WaitRetrace;End;
    _GetAbsRec(Handle,FP,SizeOf(Verbe),Verbe);
    If(FP+Length(Verbe)+1>=FS)Then Beep
     Else
    Begin
     Inc(FP,Length(Verbe)+1);
     WESetKrBorder(W);
     WEBarSelHor(W,0,W.Y,wnMax);
     _GetAbsRec(Handle,FP,SizeOf(Verbe),Verbe);
     If(W.Y<W.MaxY)Then Inc(W.Y)
      Else
     Begin
      _WEScrollDn(W);W.X:=0;
      WEPutTxt(W,Verbe);
      WEClrEol(W);
     End;
     WESetKrSel(W);
     WEBarSelHor(W,0,W.Y,wnMax);
    End;
   End;
   kbEsc,kbClose:Break;
  End;
 Until No;
 FileClose(Handle);
 WEDone(W);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Proc‚dure SearchVerb                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

   Cette proc‚dure recherche un verbe sp‚cifique dans le Bescherelle et
  s'il est trouv‚, il est affich‚!
}

Procedure SearchVerb(Name:String);
Var
 L:Window;
 Handle:Hdl;
 S:String;
 FP,FS:LongInt;
 Found:Boolean;
Begin
 WEPushEndBar(L);
 WEPutLastBar('Un instant S.V.P. recherche du verbe en cours...');
 Handle:=FileOpen(MaltePath+'SPELL\VERBES.DTA',fmRead);
 FP:=0;
 If(Handle<>errHdl)Then Begin
  FS:=FileSize(Handle);Found:=No;Name:=StrDn(Name);
  Repeat
   _GetAbsRec(Handle,FP,SizeOf(String),S);
   If(Name=S)Then Begin
    Found:=True;
    Break;
   End;
   If Length(S)=0Then Break;
   Inc(FP,Length(S)+1);
  Until FP>=FS;
  FileClose(Handle);
  WEDone(L);
  If(Found)Then PutVerb(Name)
           Else ErrMsgOk('Verbe inconnu!');
 End
  Else
 ErrMsgOk('Bescherelle introuvable!');
End;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
END.