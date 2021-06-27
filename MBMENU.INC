Uses
 Systex,Dialex,Isatex;

Const
  { Commande }
 mpEnd=0;         { Code de fin }
 mpMenu=1;        { Menu }
 mpItem=2;        { Item de menu }
 mpItemSep=3;     { Item de sÇparation }
 mpItemSwitch=4;  { Item avec indicateur de boolÇen }
 mpItemKey=5;     { Item de menu avec une clÇ }
 mpGroupItem=6;   { Groupe d'item }
 mpEndGroup=7;    { Fin de groupe }
 mpIf=8;          { Si ... alors }
 mpElse=9;        { Sinon }
 mpEndIf=10;      { Fin Si }
 mpIfGreatOr=11;  { Si ( ? > ) ou ( ) alors }
 mpEndCase=12;    { Fin de Case }
 mpCaseName=13;   { Nom d'argument du cas }

  { Variable }
 mpDrawMode=1;    { Mode dessin }
 mpReadOnly=2;    { Mode lecture seulement }
 mpEditMode=3;    { Mode êdition }
 mpIsLine=4;      { Dessine une ligne }
 mpIsBox=5;       { Dessine une boåte }
 mpIsCircle=6;    { Dessine un cercle }
 mpIsPaint=7;     { Peinture une zone }
 mpIsTrace=8;     { Mode trace }
 mpIsText=9;      { Dessin du texte }
 mpIsFill=10;     { Mode plein }

  {Divers}
 mpEndTest=14;       { Fin du test ou ... }
 mpNoneApp=15;       { Aucune application }
 mpNumLine=16;       { NombreLigneAffichÇe }
 mpNumCol=17;        { NombreColonneAffichÇe }
 mpApp=18;           { Application }
 mpOS2=$F0;          { Si OS/2 Alors }
 mpWinClipBoard=$F1; { Presse-papier Windows }
 mpGat=$F2;          { Document }
 mpEditor=$F3;       { Si Editeur dans }
 mpCoder=$F4;        { Programmeur }
 mpApplication=$F5;  { Application }
 mpScrnText=$F6;     { êcran texte }
 mpScrnGraf=$F7;     { êcran graphique }
 mpOther=$F8;        { Les autres choix }
 mpFloppyDskExist=$F9;{UnitÇ de disquette existe }
 mpHardDskExist=$FA; { Disque dur existant }
 mpNotPH=$FB;        { Pas application PH }
 mpPH=$FC;           { Application PH }
 mpNotDebugPrg=$FD;  { Pas d'application debug }

Const
 SizeMnu:Word=0;
 MnuPtr:^TByte=NIL;
 MaxSubMenu:Integer=-1;

Var
 SubMenu:Array[0..13]of PullSubMnu;

Function  LoadMenu(Const Path:String):Boolean;
Procedure RunMenu(Mode:Byte;SubMode:Byte);
Procedure UnloadMenu;

{ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ}
                               IMPLEMENTATION
{ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ}

Uses
 Adele,Memories,Systems,SysPlus,Dials,
 {$IFDEF FullVersion}
  MBCortex,MBDebug,
 {$ENDIF}
 {$IFDEF BureauVersion}
  MBBCrtex,
 {$ENDIF}
 Apps;

Function LoadMenu(Const Path:String):Boolean;
Label Brk;
Type
 HeaderMenu=Record
  Sign:Array[0..11]of Char; { Signature: ÆMENUMONSTERØ#26 }
  FileInfo:SearchRec;       { Information fichier }
   { DonnÇe du menu compilÇe... }
 End;
Var
 Handle:Hdl;
 FS,FP:LongInt;
 S,SU,N1,N2,N3,N4:String;
 H:SearchRec;
 PTM,Key:Word;
 I:Byte;
 Cmd:Word;
 PtrFree:PtrRec;
 Equal,InCase:Boolean;
 M:HeaderMenu;

 Function XtrkStr:String;
 Var
  X:String;
 Begin
  SkipSpcInLn(I,S);
  If StrI(I,S)<>'"'Then XtrkStr:=''
   Else
  Begin
   X:='';Inc(I);
   Repeat
    IncStr(X,S[I]);
    Inc(I);
   Until StrI(I,S)in[#0,'"'];
   If I<255Then Inc(I);
   XtrkStr:=X;
  End;
 End;

 Function XtrkArg:String;
 Var
  X:String;
 Begin
  XtrkArg:='';
  SkipSpcInLn(I,S);
  If(I>Length(SU))or Not(SU[I]in['-','@','A'..'Z','a'..'z','_',#128..#255])Then Exit;
  X:='';
  While(I<=Length(S))do If(SU[I]in['-','+','/','@','A'..'Z','a'..'z','0'..'9','_',#128..#255])Then Begin
   Case SU[I]of
    'á','Ä':IncStr(X,'C');
    'Ç','ê':IncStr(X,'E');
    Else IncStr(X,ChrUp(SU[I]));
   End;
   Inc(I);
  End
   Else
  Break;
  XtrkArg:=X;
 End;

 Function GetApp:Byte;Begin
  N3:=XtrkArg;GetApp:=0;
  If N3='AUTREMENT'Then GetApp:=mpOther Else
  If(N3='CALCULATRICE')and(XtrkArg='PROGRAMMABLE')Then GetApp:=wnPC Else
  If N3='CALENDRIER'Then GetApp:=wnCalendar Else
  If(N3='CD')or(N3='DC')Then GetApp:=wnCDPlayer Else
  If(N3='DISQUE')and(XtrkArg='COMPACTE')Then GetApp:=wnCDPlayer Else
  If N3='DESSIN'Then GetApp:=wnDraw Else
  If N3='EDITEUR'Then GetApp:=wnEdit Else
  If N3='FONT'Then GetApp:=wnFont Else
  If(N3='GESTIONNAIRE')and(XtrkArg='DE')Then Begin
   N3:=XtrkArg;
   If N3='FICHIERS'Then GetApp:=wnFileManager
                   Else GetApp:=wnProgMan;
  End
   Else
  If N3='HEXVIEW'Then GetApp:=wnHexView Else
  If N3='ICONE'Then GetApp:=wnIcon Else
  If N3='MACRO'Then GetApp:=wnMacro Else
  If N3='PROMPT'Then GetApp:=wnPrmpt Else
  If N3='TABLEUR'Then GetApp:=wnSuperCalc Else
  If N3='TERMINAL'Then GetApp:=wnTerm Else
  If N3='TETRIS'Then GetApp:=wnTetris
   Else
  Begin
   GetApp:=0;
  End;
 End;

 Function GetEdit:Byte;Begin
  N3:=XtrkArg;GetEdit:=0;
  If N3='ADA'Then GetEdit:=vtAda Else
  If N3='ASSEMBLEUR'Then GetEdit:=vtAsm Else
  If N3='BASIC'Then GetEdit:=vtBas Else
  If N3='C/C++'Then GetEdit:=vtC Else
  If N3='COBOL'Then GetEdit:=vtCobol Else
  If N3='EUPHORIA'Then GetEdit:=vtEuphoria Else
  If N3='FORTH'Then GetEdit:=vtForth Else
  If N3='FORTRAN'Then GetEdit:=vtFortran Else
  If(N3='GAT')or(N3='DOCUMENT')Then GetEdit:=vtGat Else
  If N3='INI'Then GetEdit:=vtIni Else
  If N3='MACRO'Then GetEdit:=vtMacro Else
  If(N3='SOURIS')or(N3='MOUSE')Then GetEdit:=vtMsMnu Else
  If N3='PASCAL'Then GetEdit:=vtPas;
 End;

 Procedure PushByte(X:Byte);Begin
  If PTM<65520Then Begin
   MnuPtr^[PTM]:=X;
   Inc(PTM);
  End;
 End;

 Procedure PushWord(X:Word);Begin
  PushByte(Lo(X));
  PushByte(Hi(X));
 End;

 Procedure PushString(Const X:String);Begin
  If PTM+Length(X)<65520Then Begin
   MoveLeft(X[1],MnuPtr^[PTM],Length(X));
   Inc(PTM,Length(X));
   PushByte(0);
  End;
 End;

Begin
 LoadMenu:=False;
 Handle:=FileOpen(Path2NoExt(Path)+'.MNX',fmRead);
 If(Handle<>errHdl)Then Begin
  _GetAbsRec(Handle,0,SizeOf(M),M);
  FindFirst(Path,faArchive,H);
  If SysErr=0Then Begin
   If(H.Time=M.FileInfo.Time)and(M.Sign='MENUMONSTER'#26)Then Begin
    SizeMnu:=FileSize(Handle)-SizeOf(M);
    MnuPtr:=MemAlloc(SizeMnu);
    _GetAbsRec(Handle,SizeOf(M),SizeMnu,MnuPtr^);
    FileClose(Handle);
    LoadMenu:=Ya;
    Exit;
   End;
  End;
  FileClose(Handle);
 End;
 If MaxAvail<65520Then SizeMnu:=MaxAvail Else SizeMnu:=65520;
 MnuPtr:=MemNew(SizeMnu);
 If(MnuPtr<>NIL)Then Begin
  PTM:=0;
  Handle:=FileOpen(Path,fmRead);
  If(Handle<>errHdl)Then Begin
   FS:=FileSize(Handle);FP:=0;InCase:=False;
   Repeat
    __GetAbsFileTxtLn(Handle,FP,S);
    If S<>''Then Begin
     S:=Trim(S);
     If S<>''Then Begin
      SU:=StrUp(S);
      If CmpLeft(SU,'ITEM')Then Begin
       I:=5;
       N1:=XtrkArg;
       If(N1='-')or(N1='ƒ')or(N1='BARRE')Then PushByte(mpItemSep)
        Else
       Begin
        N1:=XtrkDecNm(I,SU);
        Cmd:=StrToWord(N1);
        If StrI(I,SU)<>','Then Goto Brk;
        Inc(I);
        N2:=XtrkArg;
        If N2='BOOLEEN'Then Begin
         N2:=XtrkArg;
         PushByte(mpItemSwitch);
         If Hi(Cmd)<>0Then Begin
          PushByte(0);
          PushWord(Cmd);
         End
          Else
         PushByte(Cmd);
         Cmd:=0;
         If N2='DRAWMODE'Then Cmd:=mpDrawMode Else
         If N2='EDITMODE'Then Cmd:=mpEditMode Else
         If N2='ISLINE'Then Cmd:=mpIsLine Else
         If N2='ISBOX'Then Cmd:=mpIsBox Else
         If N2='ISCIRCLE'Then Cmd:=mpIsCircle Else
         If N2='ISPAINT'Then Cmd:=mpIsPaint Else
         If N2='ISTRACE'Then Cmd:=mpIsTrace Else
         If N2='ISTEXT'Then Cmd:=mpIsText Else
         If N2='ISFILL'Then Cmd:=mpIsFill Else
         If N2='READONLY'Then Cmd:=mpReadOnly;
         PushByte(Cmd);
         If StrI(I,SU)=','Then Inc(I);
         N3:=XtrkStr;
         PushString(N3);
         If StrI(I,SU)=','Then Inc(I);
         N4:=XtrkStr;
         PushString(N4);
        End
         Else
        Begin
         N2:=XtrkStr;
         If StrI(I,SU)<>','Then Begin
          PushByte(mpItem);
          If Hi(Cmd)<>0Then Begin
           PushByte(0);
           PushWord(Cmd);
          End
           Else
          PushByte(Cmd);
          PushString(N2);
          N4:='';
          PushString(N4);
         End
          Else
         Begin
          Inc(I);
          SkipSpcInLn(I,SU);
          If StrI(I,SU)=''''Then Begin
           Inc(I);
           PushByte(mpItemKey);
           If Hi(Cmd)<>0Then Begin
            PushByte(0);
            PushWord(Cmd);
           End
            Else
           PushByte(Cmd);
           PushString(N2);
           Key:=Byte(StrI(I,SU));
           Inc(I,2);
           PushByte(Lo(Key));
           PushByte(Hi(Key));
           If StrI(I,SU)<>','Then Begin
            Inc(I);
            N4:=XtrkStr;
           End
            Else
           N4:='';
           PushString(N4);
          End
           Else
          Begin
           N3:=XtrkArg;
           If N3<>''Then Begin
            PushByte(mpItemKey);
            If Hi(Cmd)<>0Then Begin
             PushByte(0);
             PushWord(Cmd);
            End
             Else
            PushByte(Cmd);
            PushString(N2);
            Key:=0;
            If N3='ALT+BACKSPACE'Then Key:=kbAltBS Else
            If N3='BACKSPACE'Then Key:=kbBS Else
            If N3='CTRL+DELETE'Then Key:=kbCtrlDel Else
            If N3='CTRL+ENTER'Then Key:=kbCtrlEnter Else
            If N3='CTRL+F1'Then Key:=kbCtrlF1 Else
            If N3='CTRL+INSERT'Then Key:=kbCtrlIns Else
            If N3='DELETE'Then Key:=kbDel Else
            If N3='F1'Then Key:=kbF1 Else
            If N3='PAGEUP'Then Key:=kbPgUp Else
            If N3='PAGEDOWN'Then Key:=kbPgDn Else
            If N3='SHIFT+DELETE'Then Key:=kbShiftDel Else
            If N3='SHIFT+INSERT'Then Key:=kbShiftIns;
            PushByte(Lo(Key));
            PushByte(Hi(Key));
            If StrI(I,SU)<>','Then Begin
             Inc(I);
             N4:=XtrkStr;
            End
             Else
            N4:='';
            PushString(N4);
           End
            Else
           Begin
            PushByte(mpItem);
            If Hi(Cmd)<>0Then Begin
             PushByte(0);
             PushWord(Cmd);
            End
             Else
            PushByte(Cmd);
            PushString(N2);
            N4:=XtrkStr;
            PushString(N4);
           End;
          End;
         End;
        End;
       End;
      End
       Else
      If CmpLeft(SU,'MENU')Then Begin
       I:=5;N1:=XtrkStr;
       If N1=''Then Goto Brk;
       PushByte(mpMenu);
       PushString(N1);
      End
       Else
      If CmpLeft(SU,'SINON')or CmpLeft(SU,'ELSE')Then Begin
       PushByte(mpElse)
      End
       Else
      If CmpLeft(SU,'SI')or CmpLeft(SU,'IF')Then Begin
       I:=3;N1:=XtrkArg;
       If N1='APPLICATION'Then Begin
        SkipSpcInLn(I,S);
        If StrI(I,S)='='Then Begin
         Inc(I);Key:=GetApp;
         If Key<>0Then Begin
          XtrkArg;
          PushByte(mpIf);
          PushByte(Key);
         End;
        End
         Else
        If XtrkArg='DANS'Then Begin
         SkipSpcInLn(I,S);
         If StrI(I,S)='['Then Begin
          PushByte(mpIfGreatOr);
          Repeat
           Inc(I);
           Key:=GetApp;
           PushByte(mpApp);
           PushByte(Key);
           SkipSpcInLn(I,S);
          Until StrI(I,S)<>',';
          PushByte(mpEndTest);
         End;
        End
         Else
        Begin
         PushByte(mpIf);
         PushByte(mpApplication);
        End;
       End
        Else
       If N1='DISQUE'Then Begin
        If(XtrkArg='DUR')and(XtrkArg='EXISTE')Then Begin
         PushByte(mpIf);
         PushByte(mpHardDskExist);
        End;
       End
        Else
       If N1='DOCUMENT'Then Begin
        PushByte(mpIf);
        PushByte(mpGat);
       End
        Else
       If(N1='ECRAN')Then Begin
        PushByte(mpIf);
        If XtrkArg='TEXTE'Then PushByte(mpScrnText)
                          Else PushByte(mpScrnGraf);
       End
        Else
       If N1='EDITEUR'Then Begin
        SkipSpcInLn(I,S);
        If StrI(I,S)='='Then Begin
         Inc(I);Key:=GetEdit;
         If Key<>0Then Begin
          XtrkArg;
          PushByte(mpIf);
          PushByte(Key);
         End;
        End
         Else
        If XtrkArg='DANS'Then Begin
         SkipSpcInLn(I,S);
         If StrI(I,S)='['Then Begin
          PushByte(mpIfGreatOr);
          Repeat
           Inc(I);
           Key:=GetEdit;
           PushByte(mpEditor);
           PushByte(Key);
           SkipSpcInLn(I,S);
          Until StrI(I,S)<>',';
          PushByte(mpEndTest);
         End;
        End;
       End
        Else
       If N1='FONCTION'Then Begin
        If(XtrkArg='PRESSE-PAPIER')and(XtrkArg='DISPONIBLE')Then Begin
         PushByte(mpIf);
         PushByte(mpWinClipboard);
        End;
       End
        Else
       If N1='OS/2'Then Begin
        PushByte(mpIf);
        PushByte(mpOS2);
       End
        Else
       If N1='PAS'Then Begin
        N2:=XtrkArg;
        If N2='DEBUG'Then Begin
         PushByte(mpIf);
         PushByte(mpNotDebugPrg);
        End
         Else
        If N2='PH'Then Begin
         PushByte(mpIf);
         PushByte(mpNotPH);
        End;
       End
        Else
       If N1='PROGRAMMEUR'Then Begin
        PushByte(mpIf);
        PushByte(mpCoder);
       End
        Else
       If N1='UNITE'Then Begin
        If(XtrkArg='DISQUETTE')and(XtrkArg='EXISTE')Then Begin
         PushByte(mpIf);
         PushByte(mpFloppyDskExist);
        End;
       End
        Else
       If StrI(I,S)='('Then Begin
        Inc(I);
        N1:=XtrkArg;Cmd:=0;
        If N1='NOMBRELIGNEAFFICHEE'Then Cmd:=mpNumLine Else
        If N1='NOMBRECOLONNEAFFICHEE'Then Cmd:=mpNumCol;
        If Cmd<>0Then Begin
         SkipSpcInLn(I,S);
         If StrI(I,S)='>'Then Begin
          Inc(I);
          Equal:=StrI(I,S)='=';
          If(Equal)Then Inc(I);
          SkipSpcInLn(I,S);
          N2:=XtrkDecNm(I,SU);
          Key:=StrToWord(N2);
          If(Equal)Then Dec(Key);
          PushByte(mpIfGreatOr);
          PushByte(Cmd);
          PushByte(Key);
          SkipSpcInLn(I,S);
          If StrI(I,S)=')'Then Begin
           Inc(I);N1:=XtrkArg;
           If(N1='OR')or(N1='OU')Then Begin
            SkipSpcInLn(I,S);
            If StrI(I,S)='('Then Begin
             Inc(I);
             N1:=XtrkArg;
             If(N1='AUCUN')or(N1='AUCUNE')Then Begin
              N2:=XtrkArg;
              If N2='APPLICATION'Then PushByte(mpNoneApp);
             End;
            End;
           End;
          End;
          PushByte(mpEndTest);
         End;
        End;
       End;
      End
       Else
      If CmpLeft(SU,'FIN')or CmpLeft(SU,'END')Then Begin
       I:=4;
       N1:=XtrkArg;
       If(N1='SI')or(N1='IF')Then PushByte(mpEndIf)Else
       If(N1='GROUPE')or(N1='GROUP')Then PushByte(mpEndGroup)Else
       If N1='CAS'Then PushByte(mpEndCase)
                  Else PushByte(mpEnd);
      End
       Else
      If CmpLeft(SU,'GROUPE')Then Begin
       I:=7;
       If XtrkArg='ITEM'Then Begin
        N1:=XtrkStr;
        If N1=''Then Goto Brk;
        PushByte(mpGroupItem);
        PushString(N1);
        SkipSpcInLn(I,S);
        If StrI(I,S)=','Then Inc(I);
        N2:=XtrkStr;
        PushString(N2);
       End;
      End
       Else
      If CmpLeft(SU,'CAS')Then Begin
       I:=4;N1:=XtrkArg;
       If N1='APPLICATION'Then InCase:=Ya;
      End
       Else
      If(InCase)and(S[1]<>';')Then Begin
       I:=0;
       PushByte(mpCaseName);
       Repeat
        Inc(I);
        Cmd:=GetApp;
        PushByte(Cmd);
        SkipSpcInLn(I,S);
       Until StrI(I,S)<>',';
       If(Cmd<>mpOther)Then PushByte(mpEndTest);
      End;
     End;
    End;
   Until FP>=FS;
   PushByte(mpEnd);
   LoadMenu:=Ya;
Brk:
   If PTM=0Then _FreeMemory(Pointer(MnuPtr),SizeMnu)
    Else
   Begin
    Key:=Succ(PTM shr 4);
    Pointer(PtrFree):=Pointer(MnuPtr); Inc(PtrFree.Seg,Key);
    FreeMemory(Pointer(PtrFree),SizeMnu-(Key shl 4));
    SizeMnu:=Key shl 4;
   End;
   FileClose(Handle);
   DeleteFile(Path2NoExt(Path)+'.MNX');
   Handle:=FileCreate(Path2NoExt(Path)+'.MNX');
   If(Handle<>errHdl)Then Begin
    M.Sign:='MENUMONSTER'#26;
    FindFirst(Path,faArchive,M.FileInfo);
    _SetAbsRec(Handle,0,SizeOf(M),M);
    _SetAbsRec(Handle,SizeOf(M),SizeMnu,MnuPtr^);
    FileClose(Handle);
   End;
  End;
 End;
End;

Function ReadWordMnuPtr(I:Word):Word;Assembler;ASM
 LES DI,MnuPtr
 MOV BX,I
 MOV AX,ES:[DI+BX]
END;

Procedure RunMenu(Mode:Byte;SubMode:Byte);
Var
 I,Len,Key:Word;
 PS1,PS2,PS3,PS4,PSG1,PSG2:PChar;
 Cmd:Word;
 Group,InCase:Boolean;
 IfPos:Byte;
 IfCase:Array[0..255]of Boolean;
 CaseSel:Set of Byte;

 Function SearchKey(Command:Word):Word;
 Var
  I:Byte;
 Begin
  SearchKey:=0;
  For I:=0to(Application.MaxAccelerators)do If(Application.PAccelerators^[I].Option=Command)Then Begin
   If Application.PAccelerators^[I].KeyB=0Then Begin
    SearchKey:=Application.PAccelerators^[I].KeyA;
    Break;
   End;
  End;
 End;

Begin
 PMInit;
 If(MnuPtr<>NIL)Then Begin
  I:=0;IfPos:=0;IfCase[0]:=True;
  Group:=False;InCase:=True;
  CaseSel:=[];
  Repeat
   Case MnuPtr^[I]of
    mpMenu:Begin
     Inc(I);
     PS1:=@MnuPtr^[I];
     Len:=StrLen(PChr(PS1));
     If IfCase[IfPos]Then PMAddMnu(PS1);
     Inc(I,Len+1);
    End;
    mpItem:Begin
     Inc(I);
     Cmd:=MnuPtr^[I];Inc(I);
     If Cmd=0Then Begin
      Cmd:=ReadWordMnuPtr(I);
      Inc(I,2);
     End;
     PS1:=@MnuPtr^[I];
     Len:=StrLen(PChr(PS1));
     Inc(I,Len+1);
     PS2:=@MnuPtr^[I];
     Len:=StrLen(PChr(PS2));
     Inc(I,Len+1);
     If IfCase[IfPos]Then Begin
      If(InCase)Then Begin
       If(Group)Then SMAddFullItem(SubMenu[MaxSubMenu],PS1,SearchKey(Cmd),$F000+Cmd,NIL,PS2)
                Else PMAddItemKey(PS1,SearchKey(Cmd),$F000+Cmd,PS2)
      End;
     End;
    End;
    mpItemSep:Begin
     Inc(I);
     If IfCase[IfPos]Then Begin
      If(InCase)Then Begin
       If(Group)Then SMAddBarItem(SubMenu[MaxSubMenu])
                Else PMAddBarItem;
      End;
     End;
    End;
    mpItemSwitch:Begin
     Inc(I);
     Cmd:=MnuPtr^[I];Inc(I);
     If Cmd=0Then Begin
      Cmd:=ReadWordMnuPtr(I);
      Inc(I,2);
     End;
     Key:=MnuPtr^[I];Inc(I);
     PS1:=@MnuPtr^[I];
     Len:=StrLen(PChr(PS1));
     Inc(I,Len+1);
     PS2:=@MnuPtr^[I];
     Len:=StrLen(PChr(PS2));
     Inc(I,Len+1);
     If IfCase[IfPos]Then If(InCase)Then Case(Key)of
      mpDrawMode:PMAddItemSwitch(PS1,EditorApp(HPtr(Windows)^).DrawMode,Pointer(PS2),$F000+Cmd);
      mpReadOnly:PMAddItemSwitch(PS1,EditorApp(HPtr(Windows)^).ReadOnly,Pointer(PS2),$F000+Cmd);
      mpEditMode:PMAddItemSwitch(PS1,HexEditApp(HPtr(Windows)^).EditMode,Pointer(PS2),$F000+Cmd);
      mpIsLine:PMAddItemSwitch(PS1,IsLine,Pointer(PS2),$F000+Cmd);
      mpIsBox:PMAddItemSwitch(PS1,IsBox,Pointer(PS2),$F000+Cmd);
      mpIsCircle:PMAddItemSwitch(PS1,IsCircle,Pointer(PS2),$F000+Cmd);
      mpIsPaint:PMAddItemSwitch(PS1,IsPaint,Pointer(PS2),$F000+Cmd);
      mpIsTrace:PMAddItemSwitch(PS1,IsTrace,Pointer(PS2),$F000+Cmd);
      mpIsText:PMAddItemSwitch(PS1,IsText,Pointer(PS2),$F000+Cmd);
      mpIsFill:PMAddItemSwitch(PS1,Application.IsFill,Pointer(PS2),$F000+Cmd);
     End;
    End;
    mpItemKey:Begin
     Inc(I);
     Cmd:=MnuPtr^[I];Inc(I);
     If Cmd=0Then Begin
      Cmd:=ReadWordMnuPtr(I);
      Inc(I,2);
     End;
     PS1:=@MnuPtr^[I];
     Len:=StrLen(PChr(PS1));
     Inc(I,Len+1);
     Key:=MnuPtr^[I]+(MnuPtr^[I+1]shl 8);
     Inc(I,SizeOf(Word));
     PS2:=@MnuPtr^[I];
     Len:=StrLen(PChr(PS2));
     Inc(I,Len+1);
     If(IfCase[IfPos])and(InCase)Then PMAddItemKey(PS1,Key,$F000+Cmd,PS2)
    End;
    mpGroupItem:Begin
     Inc(I);
     PSG1:=@MnuPtr^[I];
     Len:=StrLen(PChr(PSG1));
     Inc(I,Len+1);
     PSG2:=@MnuPtr^[I];
     Len:=StrLen(PChr(PSG2));
     Inc(I,Len+1);
     If IfCase[IfPos]Then Begin
      Group:=True;
      Inc(MaxSubMenu);
      SMInit(SubMenu[MaxSubMenu]);
     End;
    End;
    mpEndGroup:Begin
     Inc(I);
     If(IfCase[IfPos])and(InCase)Then Begin
      PMAddFullItem(PSG1,kbNoKey,kbNoKey,SubMenu[MaxSubMenu].Ptr,PSG2);
      Group:=No;
     End;
    End;
    mpIf:Begin
     Inc(I);Inc(IfPos);
     Key:=MnuPtr^[I];Inc(I);
     Case(Key)of
      mpOS2:IfCase[IfPos]:=OS2;
      mpWinClipboard:IfCase[IfPos]:=ClipboardFunctionsAvailable;
      mpGat:IfCase[IfPos]:=(Mode=wnEdit)and(SubMode=vtGat);
      mpCoder:IfCase[IfPos]:=(Mode=wnEdit)and(SubMode in vtCoder);
      mpApplication:IfCase[IfPos]:=Mode<>0;
      mpScrnText:IfCase[IfPos]:=Not IsGrf;
      mpScrnGraf:IfCase[IfPos]:=IsGrf;
      mpFloppyDskExist:IfCase[IfPos]:=FloppyDskExist;
      mpHardDskExist:IfCase[IfPos]:=HardDskExist;
      mpNotPH:IfCase[IfPos]:=Not ModePH;
      {$IFDEF Developpeur}
       mpNotDebugPrg:IfCase[IfPos]:=(ModePH)and(Not DebugPrg);
      {$ENDIF}
      Else IfCase[IfPos]:=Mode=Key;
     End;
    End;
    mpIfGreatOr:Begin
     Inc(I);Inc(IfPos);
     IfCase[IfPos]:=No;
     Repeat
      Cmd:=MnuPtr^[I];Inc(I);
      Key:=MnuPtr^[I];
      Case(Cmd)of
       mpNumLine:Begin
        IfCase[IfPos]:=IfCase[IfPos]or(NmYTxts>Key);
        Inc(I);
       End;
       mpNumCol:Begin
        IfCase[IfPos]:=IfCase[IfPos]or(NmXTxts>Key);
        Inc(I);
       End;
       mpApp:Begin
        IfCase[IfPos]:=IfCase[IfPos]or(Mode=Key);
        Inc(I);
       End;
       mpEditor:Begin
        IfCase[IfPos]:=IfCase[IfPos]or(SubMode=Key);
        Inc(I);
       End;
       mpNoneApp:IfCase[IfPos]:=IfCase[IfPos]or(Mode=0);
       mpEndTest:Break;
      End;
     Until Cmd=mpEndTest;
    End;
    mpElse:Begin
     Inc(I);
     IfCase[IfPos]:=Not IfCase[IfPos];
    End;
    mpCaseName:Begin
     Inc(I);
     If(MnuPtr^[I]=mpOther)Then Begin
      InCase:=Not(Mode in CaseSel);
      Inc(I);
     End
      Else
     Begin
      InCase:=False;
      Repeat
       CaseSel:=CaseSel+[MnuPtr^[I]];
       InCase:=InCase or(MnuPtr^[I]=Mode);
       Inc(I);
      Until MnuPtr^[I]=mpEndTest;
      Inc(I);
     End;
    End;
    mpEndIf:Begin
     Inc(I);
     If IfPos>0Then Dec(IfPos);
    End;
    mpEndCase:Begin
     Inc(I);
     InCase:=True;
     CaseSel:=[];
    End;
    Else Break;
   End;
  Until MnuPtr^[I]=mpEnd;
 End;
End;

Procedure UnloadMenu;Begin
 _FreeMemory(Pointer(MnuPtr),SizeMnu);
End;
