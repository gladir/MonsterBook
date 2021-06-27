{⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ‹
 ≥                                                                     €
 ≥                  Malte Genesis/Editeur - Sauvegarde                 €
 ≥                                                                     €
 ≥          êdition Chantal pour Mode RÇel/IV - Version 1.1            €
 ≥                            2000/01/01                               €
 ≥                                                                     €
 ≥        Tous droits rÇservÇs par les Chevaliers de Malte (C)         €
 ≥                                                                     €
 ¿‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹€


 Nom du programmeur
 ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕ

  Sylvain Maltais


 Description
 ÕÕÕÕÕÕÕÕÕÕÕ

  Cette unitÇ permet de sauvegarder le contenu du texte du traåtement de
 texte dans le format dÇsirer et supportÇe.
}

{$I DEF.INC}

Unit EdtSave;

{ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ}
                                   INTERFACE
{ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ}

Function TESave(Var Context):Boolean;
Function TESaveAs(Var Context;Const _Path:String):Boolean;

{ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ}
                                 IMPLEMENTATION
{ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ}


Uses
 Systex,Memories,Systems,Isatex,Video,Dials,Editex,Editor,Dialex,
 ResServD,Restex,DialPlus,WordTex;

Procedure InvBuf(Var x0;Size:Wd);Near;Forward;
Function  PSetPath4AddFile(PC:PChr):String;Near;Forward;

{⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ‹
 ≥                          ProcÇdure FusionDirNName                      €
 ¿‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹€


 Description
 ÕÕÕÕÕÕÕÕÕÕÕ

  Cette procÇdure fusionne un rÇpertoire avec un nom de fichier et la place
 dans la variable de paramÇtrage ÆStrØ.
}

Procedure FusionDirNName(Var Str:String;Dir,Name:PChr);Near;Begin
 Str:=PSetPath4AddFile(Dir)+StrPas(Name)
End;

{⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ‹
 ≥                        Fonction PSetPath4AddFile                      €
 ¿‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹€


 Description
 ÕÕÕÕÕÕÕÕÕÕÕ

  Cette fonction retourne un chemin  de rÇpertoire de faáon Ö ce qu'il est
 toujours une barre oblique pour  permettre l'addition d'un nom de fichier
 en utilisant Ö la base un chemin contenu dans une chaåne de caractäres de
 format ASCIIZ.
}

Function PSetPath4AddFile(PC:PChr):String;Begin
 PSetPath4AddFile:=SetPath4AddFile(StrPas(PC))
End;

{$I \Source\Chantal\Library\System\Dos\Shell\4Dos\SearchDe.Inc}
{$I \Source\Chantal\Library\System\Dos\Shell\4Dos\SetDescr.Inc}

{⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ‹
 ≥                            ProcÇdure InvBuf                            €
 ¿‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹€


 Description
 ÕÕÕÕÕÕÕÕÕÕÕ

  Cette procÇdure inverse les quarters de chaque octets d'un tampon dÇfinit
 par la variable de paramÇtrage Æx0Ø pendant une longueur de ÆSizeØ.
}

Procedure InvBuf;
Var
 TBuf:TByte Absolute x0;
 I:Word;
Begin
 If Size=0Then Exit;
 For I:=0to Size-1do TBuf[I]:=(TBuf[I]shr 4)+(TBuf[I]shl 4)
End;

{⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ‹
 ≥                            ProcÇdure WaitMsg                            €
 ¿‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹€


 Description
 ÕÕÕÕÕÕÕÕÕÕÕ

  Cette procÇdure effectue une pause d'une demi-seconde afin de laisser voir
 un message par exemple.
}

Procedure WaitMsg;
Var
 I:Byte;
Begin
 For I:=0to 7do If(KeyPress)Then WaitRetrace;
End;

{⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ‹
 ≥                        Fonction TESave                      €
 ¿‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹€


 Description
 ÕÕÕÕÕÕÕÕÕÕÕ

  Cette fonction sauvegarde  le fichier  sous son noms rÇguliers
 (l'Çquivalent de F2 pour Turbo Pascal ou Borland Pascal). Cette
 fonction retourne Ya (True) si l'opÇration c'est dÇroulant sans
 probläme ou No  (False)  si un probläme utilisateur ou matÇriel
 est survenu.
}

Function TESave;
Var
 Q:EditorApp Absolute Context; { Objet Çditeur }
Begin
 TESave:=TESaveAs(Q,Q.EditName)
End;

{⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ‹
 ≥                          Fonction TESaveAs                        €
 ¿‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹€


 Description
 ÕÕÕÕÕÕÕÕÕÕÕ

  Cette fonction sauvegarde le texte sous un nom particulier selon les
 spÇcifications de l'utilisateur.
}

Function TESaveAs;
Label DefaultGat,NextGat;
Var
 Q:EditorApp Absolute Context; { Objet Çditeur }
 Handle:Hdl;                   { ÆHandleØ associÇ au fichier Ö Çcrire }
 L,LD:Word;
 J,JP:Word;                    { Compteur de ligne, compteur de position }
 I,M:LongInt;
 PC:PChr;                      { Pointeur sur la ligne courante }
 UpDate:Boolean;               { Demande de mise Ö jour? }
 Chr:Char;                     { Caractäre divers }
 Buffer:Array[0..2047]of Char; { MÇmoire tampon par dÇfaut }
 FirstChoice:FirstChoiceHeader Absolute Buffer; { Premier Choix }
 LW:Window;                    { Sauvegarde de la ligne d'aide }
 Path:String;                  { Description et chemin complet du fichier }
 E:ExtStr;                     { Extension du fichier }
 QX:EditorApp Absolute Q;            { Information de l'Çditeur }
 Format:Byte;                  { Format de sauvegarde de document }
 K:Word;                       { Code clavier de sortie }
 UnderlineMode:Boolean;        { Mode soulignÇ? }
 DoubleMode:Boolean;           { Mode double largeur? }
 BoldMode:Boolean;             { Mode gras? }
 ItalicMode:Boolean;           { Mode Italique?}
 Paragraph:Boolean;            { êcriture d'un paragraphe? }
 Line:Boolean;                 { Est-ce une ligne sÇparatrice? }
 Style:Char;                   { Style de ligne sÇparatrice}
 LastAttr:Byte;                { Attribue prÇcÇdent }
 PosLastAttr:Byte;             { Position de l'attribue prÇcÇdent }
 TmpRead:PChr;                 { Tampon temporaire de lecture (si }
                               { sauvegarde directe Ö partir d'un }
                               { autre fichier)}
 TmpReadSize:Word;             { Taille du tampon ÆTmpReadØ }
 FPR:LongInt;                  { Position du fichier actuel en lecture }
 PDrw:^DrawInEdt;              { DÇfinition d'objet d'image }
 PLineHor:^LineHorInEdt Absolute PDrw;{ DÇfinition d'objet de ligne horizontal }
 Font:DataSetInMemory;         { Pour la conversion de la police de caractäres }

 Procedure UpdateDescription;
 Var
  Descr:String;
 Begin
  If(DescrInFile)Then Begin
   Descr:=SearchDescription(Q.EditName);
   If Descr=''Then Begin
    If(_WinInp(45,'Description','Entrez la description dÇsirez (40 maximum):',False,Descr)=kbYes)Then
     SetDescription(Path,Descr);
   End;
  End;
 End;

 Procedure SaveGat;
 Var
  R:FileListBox; { Objet pour l'entrÇe d'un nom de document }
  H:History;     { Histoire retenu pour cette objet }
 Begin
  HYInit(H,0);
  FLInitModel(R,Path,'Sauvegarde sous',H,False,False,True,omDocument);
  Case(Q.ModeSub)of
   vtsPW:Format:=cfoProfessionnalWrite;
   vtsFirstChoice:Format:=cfoFirstChoice;
   vtsHTML:Format:=cfoHTML;
   vtsANSI:Format:=cfoANSI;
   vtsASCII:Format:=cfoASCII;
   vtsTextUnix:Format:=cfoTextUnix;
   vtsRTF:Format:=cfoRTF;
   Else Format:=cfoGAT;
  End;
  FLUpDateFormat(R,Format);
  Repeat
   K:=FLRun(R);
  Until(K=kbEsc)or(K=kbClose)or(K=kbEnter);
  If(K=kbEnter)Then Begin
   Case FLFormat(R)of
    cfoProfessionnalWrite:Q.ModeSub:=vtsPW;
    cfoFirstChoice:Q.ModeSub:=vtsFirstChoice;
    cfoHTML:Q.ModeSub:=vtsHTML;
    cfoANSI:Q.ModeSub:=vtsANSI;
    cfoASCII:Q.ModeSub:=vtsASCII;
    cfoTextUnix:Q.ModeSub:=vtsTextUnix;
    cfoRTF:Q.ModeSub:=vtsRTF;
    Else Q.ModeSub:=vtsGAT;
   End;
   Path:=R.Path;
  End;
  FLDone(R);
 End;

 Procedure PushChar(Chr:Char);Begin
  Buffer[LD]:=Chr;Inc(LD);
  If LD>=SizeOf(Buffer)Then Begin
   _SetRec(Handle,LD,Buffer[0]);
   LD:=0;
  End;
 End;

 Procedure PushString(Const S:String);
 Var
  I:Byte;
 Begin
  For I:=1to Length(S)do PushChar(S[I]);
 End;

 Procedure UnsetHTML;Begin
  If(LastAttr and cgUnderline=cgUnderline)Then PushString('</U>');
  If(LastAttr and cgBold=cgBold)Then PushString('</B>');
  If(LastAttr and cgItalic=cgItalic)Then PushString('</I>');
  LastAttr:=0;PosLastAttr:=0;
  UnderlineMode:=False;BoldMode:=False;ItalicMode:=False;
 End;

 Procedure UnsetRTF;Begin
  If(LastAttr and cgUnderline=cgUnderline)Then PushString('}');
  If(LastAttr and cgBold=cgBold)Then PushString('}');
  If(LastAttr and cgItalic=cgItalic)Then PushString('}');
  If(LastAttr and cgDouble=cgDouble)Then PushString('\fs24\cgrid0 ');
  LastAttr:=0;PosLastAttr:=0;
  UnderlineMode:=False;BoldMode:=False;
  ItalicMode:=False;DoubleMode:=False;
 End;

 Function GetCurrLine:Pointer;Begin
  If TmpReadSize<>0Then Begin
   __GetAbsFilePTxtLn(Q.Handle,FPR,TmpRead,TmpReadSize);
   GetCurrLine:=TmpRead;
  End
   Else
  GetCurrLine:=_ALGetCurrBuf(Q.List);
 End;

 Function FindObject(P:Word):Pointer;
 Var
  PDrw:^DrawInEdt; { DÇfinition d'objet d'image }
  I:Word;          { Compteur de boucle }
 Begin
  FindObject:=NIL;
  If Q.Processus.Count>0Then Begin
   ALSetPtr(Q.Processus,0);
   For I:=0to Q.Processus.Count-1do Begin
    PDrw:=_ALGetCurrBuf(Q.Processus);
    If(PDrw<>NIL)Then Begin
     If(PDrw^.Y1<=P)and(PDrw^.Y2>P)Then Begin
      FindObject:=PDrw;
      Break;
     End;
    End;
    ALNext(Q.Processus);
   End;
  End;
 End;

Begin
 Path:=_Path;SysErr:=0;TESaveAs:=False;
 TmpRead:=NIL;TmpReadSize:=0;FPR:=0;
  { Si lecture directe Ö partir d'un fichier, alors prÇparer de la mÇmoire }
 If(Q.Handle)in[2..$FE]Then Begin
  TmpReadSize:=4096;
  TmpRead:=MemAlloc(TmpReadSize);
  If(TmpRead=NIL)Then TmpReadSize:=0;
  GetCurrLine;
 End;
  { Si rÇpertoire sur unitÇ inconnu, effectuÇ une recherche... }
 If(Length(Path)>2)and(Path[1]in['*','?'])and(Path[2]=':')Then Begin
  For Chr:='C'to 'Z'do Begin
   Path[1]:=Chr;
   If DirExist(Path2Dir(Path))Then Break;
  End;
 End;
 If Path=''Then Begin                                     { RÇpertoire: }
  Case(Q.Mode)of                                          { ƒƒƒƒƒƒƒƒƒƒƒ }
vtRC:FusionDirNName(Path,PathResource,ExtRC);             { Ressource }
vtPas:FusionDirNName(Path,PathPas,ExtPas);                { Pascal }
vtFortran:FusionDirNName(Path,PathFortran,ExtFortran);    { Fortran }
vtForth:Path:=PSetPath4AddFile(PathForth)+'*.*';          { Forth }
vtEuphoria:FusionDirNName(Path,PathEuphoria,ExtEuphoria); { Euphoria }
vtCobol:Path:=PSetPath4AddFile(PathCobol)+'*.*';          { Cobol }
vtC:FusionDirNName(Path,PathC,ExtC);                      { C/C++ }
vtBas:FusionDirNName(Path,PathBas,ExtBas);                { Basic }
vtAsm:FusionDirNName(Path,PathAsm,ExtAsm);                { Assembleur }
vtAda:Path:=PSetPath4AddFile(PathAda)+'*.*';              { Ada }
vtGat:Case(Q.ModeSub)of
    vtsPW,vtsFirstChoice:Path:=PSetPath4AddFile(PathGat)+'*.DOC';
    vtsHTML:Path:=PSetPath4AddFile(PathGat)+'*.HTM';
    vtsANSI:Path:=PSetPath4AddFile(PathGat)+'*.ANS';
    vtsASCII,vtsTextUnix:Path:=PSetPath4AddFile(PathGat)+'*.TXT';
    vtsRTF:Path:=PSetPath4AddFile(PathGat)+'*.RTF';
    Else Path:=PSetPath4AddFile(PathGat)+'*.GAT';            { GAT }
   End;
   Else Path:='';
  End;
  If(Q.Mode=vtGat)Then Begin
   SaveGat;
   If(K<>kbEnter)Then Exit;
  End
   Else
  Path:=OpenWin(Path,'Sauvegarde sous');
 End;
 UpDate:=Q.EditName<>Path;
 If(UpDate)Then Begin{ Existe toujours ? }
  If FileExist(Path)Then If Not(__InputOverwriteFile(Path))Then Exit;
  Q.EditName:=StrUp(Path)
 End;
 WEPushEndBar(LW);
 WEPutLastBar('Sauvegarde en cours...');
 If(Q.Mode=vtGAT)and(Q.ModeSub=vtsGAT)Then Begin
  Path:=Path2NoExt(Path)+'.GAT';
  UpDate:=True;
 End;
 Handle:=FileCreateAndBackup(Path);
 If(Handle=errHdl)Then Begin
  ErrNoMsgOk(CannotCreateFile);
  WEDone(LW);
  Exit;
 End;
 ALSetPtr(Q.List,0);
 If(Q.Mode=vtGAT)and(Q.ModeSub<>vtsGAT)Then Begin
   { êcriture de l'entàte du document }
  Case(Q.ModeSub)of
   vtsFirstChoice:Begin
    FillClr(FirstChoice,SizeOf(FirstChoice));
    FirstChoice.X1:=Q.SheetFormat.X1;
    FirstChoice.X2:=Q.SheetFormat.X2;
    FirstChoice.NumLine:=Q.List.Count;
    FirstChoice.Sign:='GERBILDOC   ';
    FirstChoice.MargeUp:=Q.SheetFormat.Y1;
    If Q.SheetFormat.Y2>66Then FirstChoice.PageLen:=88
                          Else FirstChoice.PageLen:=66;
    FirstChoice.MargeDn:=FirstChoice.PageLen-Q.SheetFormat.Y2;
    FirstChoice.ResC[356]:=Byte('C');
    FirstChoice.ResC[357]:=Byte('C');
    FirstChoice.ResC[358]:=1;
    FirstChoice.ResC[359]:=Byte('N');
    FirstChoice.ResC[362]:=1;
    FirstChoice.ResC[363]:=Byte('N');
    FirstChoice.ResC[381]:=1;
    FirstChoice.ResC[391]:=1;
    FirstChoice.ResC[401]:=1;
    FirstChoice.ResC[411]:=1;
    FirstChoice.ResC[421]:=1;
    FirstChoice.ResC[431]:=1;
    FirstChoice.ResC[504]:=2;
    _SetAbsRec(Handle,0,SizeOf(FirstChoice),FirstChoice);
   End;
   vtsHTML:Begin
    PutFileTxtLn(Handle,'<HTML>');
    DBOpenServerName(ChantalServer,'CHANTAL:/Texte/Format/ASCII2HTML.Dat');
    If Not DBCopyToMemory(ChantalServer,Font)Then Begin
     __OutOfMemory;
     Exit;
    End;
   End;
   vtsRTF:Begin
    PutFileTxt(Handle,'{\rtf1\ansi\ansicpg1252\uc1 \deff0\deflang1033\deflangfe1036');
    PutFileTxt(Handle,'{\fonttbl{\f0\froman\fcharset0\fprq2');
    PutFileTxt(Handle,'{\*\panose 02020603050405020304}Times New Roman;}');
    PutFileTxt(Handle,'{\f17\froman\fcharset238\fprq2 Times New Roman CE;}');
    PutFileTxt(Handle,'{\f18\froman\fcharset204\fprq2 Times New Roman Cyr;}');
    PutFileTxt(Handle,'{\f20\froman\fcharset161\fprq2 Times New Roman Greek;}');
    PutFileTxt(Handle,'{\f21\froman\fcharset162\fprq2 Times New Roman Tur;}');
    PutFileTxt(Handle,'{\f22\froman\fcharset186\fprq2 Times New Roman Baltic;}}');
    PutFileTxt(Handle,'{\colortbl;\red0\green0\blue0;\red0\green0\blue255;');
    PutFileTxt(Handle,'\red0\green255\blue255;\red0\green255\blue0;');
    PutFileTxt(Handle,'\red255\green0\blue255;\red255\green0\blue0;');
    PutFileTxt(Handle,'\red255\green255\blue0;\red255\green255\blue255;');
    PutFileTxt(Handle,'\red0\green0\blue128;\red0\green128\blue128;');
    PutFileTxt(Handle,'\red0\green128\blue0;\red128\green0\blue128;');
    PutFileTxt(Handle,'\red128\green0\blue0;\red128\green128\blue0;');
    PutFileTxt(Handle,'\red128\green128\blue128;\red192\green192\blue192;}');
    PutFileTxt(Handle,'{\stylesheet{\nowidctlpar\widctlpar\adjustright ');
    PutFileTxt(Handle,'\fs20\lang3084\cgrid \snext0 Normal;}');
    PutFileTxt(Handle,'{\s1\keepn\nowidctlpar\widctlpar\outlinelevel0\adjustright ');
    PutFileTxt(Handle,'\fs20\ul\lang3084\cgrid \sbasedon0 \snext0 heading 1;}');
    PutFileTxt(Handle,'{\*\cs10 \additive Default Paragraph Font;}}');
    DBOpenServerName(ChantalServer,'CHANTAL:/Texte/Format/ASCII2RTF.Dat');
    If Not DBCopyToMemory(ChantalServer,Font)Then Begin
     __OutOfMemory;
     Exit;
    End;
   End;
   Else Goto DefaultGat;
  End;
   { êcriture du contenu du document }
  LD:=0;UnderlineMode:=False;BoldMode:=False;
  ItalicMode:=False;Paragraph:=False;
  LastAttr:=0;PosLastAttr:=0;DoubleMode:=False;
  For I:=0to Q.List.Count-1do Begin
   PC:=GetCurrLine;
   If Not IsPChrEmpty(PC)Then Begin
    L:=StrLen(PC);
    Case(Q.ModeSub)of
     vtsASCII,vtsTextUnix:For J:=0to L-1do Begin
      If PC^[J]>=' 'Then PushChar(PC^[J]);
     End;
     vtsHTML:Begin
      If(Q.SheetFormat.X1<L)Then Begin
       Style:=PC^[Q.SheetFormat.X1];
       Line:=True;
       For J:=Q.SheetFormat.X1+1to L-1do If(PC^[J]<>Style)Then Begin
        Line:=False;
        Break;
       End;
       If(Line)Then Begin
        PushString('<div style=''border:none;border-bottom:solid windowtext 1.5pt;padding:0cm 0cm 1.0pt 0cm''>');
        PushString('<p class=MsoNormal style=''border:none;mso-border-bottom-alt:solid windowtext 1.5pt;');
        PushString('padding:0cm;mso-padding-alt:0cm 0cm 1.0pt 0cm''><span lang=EN-US');
        PushString('style=''mso-ansi-language:EN-US''><![if !supportEmptyParas]>&nbsp;<![endif]><o:p></o:p></span></p>');
        PushString('</div>');
       End;
      End;
      If Not(Line)Then Begin
       If(L>Q.SheetFormat.X1)Then Begin
        If Not(Paragraph)Then Begin
         Paragraph:=True;
         If Not((PC^[L-1]=' ')or(L>=Q.SheetFormat.X2))Then Begin
          For JP:=0to L-1do If PC^[JP]<>' 'Then Break;
          If JP>=Q.SheetFormat.X2-(L-JP)-2Then PushString('<P ALIGN=RIGHT>')Else
          If(JP>=((Q.SheetFormat.X2-Q.SheetFormat.X1-(L-JP)-2)shr 1)+Q.SheetFormat.X1)Then
           PushString('<P ALIGN=CENTER>')
          Else
           PushString('<P ALIGN=JUSTIFY>');
         End
          Else
         PushString('<P ALIGN=LEFT>');
        End;
       End;
       For J:=0to L-1do Begin
        If DBLocateAbsIM(Font,0,PC^[J],[])Then Begin
         Inc(PtrRec(Font.CurrRec).Ofs);
         PushString(Font.CurrRec.Str^);
        End
         Else
        Case PC^[J]of
         ' '..'%',#39..#59,#61,#63..#127,
         #244..#245,#247,#250,#252,#254..#255:PushChar(PC^[J]);
         Else Begin
          PosLastAttr:=J;
          LastAttr:=Byte(PC^[J]);
          If(UnderlineMode)and(Byte(PC^[J])and cgUnderline=0)Then Begin
           PushString('</U>');
           UnderlineMode:=False;
          End
           Else
          If(Not(UnderlineMode))and(Byte(PC^[J])and cgUnderline=cgUnderline)Then Begin
           PushString('<U>');
           UnderlineMode:=True;
          End;
          If(BoldMode)and(Byte(PC^[J])and cgBold=0)Then Begin
           PushString('</B>');
           BoldMode:=False;
          End
           Else
          If(Not(BoldMode))and(Byte(PC^[J])and cgBold=cgBold)Then Begin
           PushString('<B>');
           BoldMode:=True;
          End;
          If(ItalicMode)and(Byte(PC^[J])and cgItalic=0)Then Begin
           PushString('</I>');
           ItalicMode:=False;
          End
           Else
          If(Not(ItalicMode))and(Byte(PC^[J])and cgItalic=cgItalic)Then Begin
           PushString('<I>');
           ItalicMode:=True;
          End;
         End;
        End;
        If J>PosLastAttr+1Then Begin
          { Attribut    ≥ Caractäre     ≥ Caractäre ? }
          { ƒƒƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒ}
          { PosLastAttr ≥ PosLastAttr+1 ≥ J }
         UnsetHTML;
        End;
       End;
       If(Paragraph)Then Begin
        If Not((PC^[L-1]=' ')or(L>=Q.SheetFormat.X2))Then Begin
         PushString('</P>');
         Paragraph:=False;
        End;
       End;
       If LastAttr>0Then UnsetHTML;
      End;
     End;
     vtsANSI:For J:=0to L-1do Begin
      If PC^[J]>=' 'Then PushChar(PC^[J]);
     End;
     vtsFirstChoice:For J:=0to L-1do Begin
      If(J>=Q.SheetFormat.X1)and(J<=Q.SheetFormat.X2)Then Begin
       PosLastAttr:=0;
       If PC^[J]>=#128Then PosLastAttr:=PosLastAttr or 8;
       If PC^[J]>=' 'Then Begin
        If LastAttr>0Then Begin
         PushChar(Char(Byte(PC^[J])or 128));
         If LastAttr and cgItalic>0Then PosLastAttr:=PosLastAttr or 4;
         If LastAttr and(cgBold+cgDouble)>0Then PosLastAttr:=PosLastAttr or 2;
         If LastAttr and cgUnderline>0Then PosLastAttr:=PosLastAttr or 1;
         If PosLastAttr>0Then PushChar(Char(PosLastAttr+128));
        End
         Else
        Begin
         PushChar(PC^[J]);
         If PC^[J]>=#128Then PushChar(#136);
        End;
        LastAttr:=0;
       End
        Else
       LastAttr:=Byte(PC^[J]);
      End;
     End;
     vtsRTF:Begin
      If(L>Q.SheetFormat.X1)Then Begin
       If Not(Paragraph)Then Begin
        Paragraph:=True;
        If Not((PC^[L-1]=' ')or(L>=Q.SheetFormat.X2))Then Begin
         For JP:=0to L-1do If PC^[JP]<>' 'Then Break;
         If JP>=Q.SheetFormat.X2-(L-JP)-2Then PushString('{\par ')Else
         If(JP>=((Q.SheetFormat.X2-Q.SheetFormat.X1-(L-JP)-2)shr 1)+Q.SheetFormat.X1)Then
          PushString('{\pard \qj\nowidctlpar\adjustcenter ')
         Else
          PushString('{\par ');
        End
         Else
        PushString('{\pard \qj\nowidctlpar\adjustright ');
       End;
      End;
      If L=0Then PushString('\par ');
      (*If(Q.XW1<L)Then Begin
       Style:=PC^[Q.XW1];
       Line:=True;
       For J:=Q.XW1+1to L-1do If(PC^[J]<>Style)Then Begin
        Line:=False;
        Break;
       End;
       If(Line)Then Begin
        PushString('\par }\pard \ql \li0\ri0\widctlpar\aspalpha\aspnum\faauto\adjustright\rin0\lin0\itap0 {');
       End;
      End;*)
      For J:=0to L-1do Begin
       If DBLocateAbsIM(Font,0,PC^[J],[])Then Begin
        Inc(PtrRec(Font.CurrRec).Ofs);
        PushString(Font.CurrRec.Str^);
       End
        Else
       Case PC^[J]of
        ' ':If(J>=Q.SheetFormat.X1)Then PushChar(' ');
        #33..'%',#40..#127,
        #158..#159,#166..#170,
        #187..#245,#247..#255:PushChar(PC^[J]);
        Else Begin
         PosLastAttr:=J;
         LastAttr:=Byte(PC^[J]);
         If(UnderlineMode)and(Byte(PC^[J])and cgUnderline=0)Then Begin
          PushString('}');
          UnderlineMode:=False;
         End
          Else
         If(Not(UnderlineMode))and(Byte(PC^[J])and cgUnderline=cgUnderline)Then Begin
          PushString('{\ul ');
          UnderlineMode:=True;
         End;
         If(BoldMode)and(Byte(PC^[J])and cgBold=0)Then Begin
          PushString('}');
          BoldMode:=False;
         End
          Else
         If(Not(BoldMode))and(Byte(PC^[J])and cgBold=cgBold)Then Begin
          PushString('{\b ');
          BoldMode:=True;
         End;
         If(ItalicMode)and(Byte(PC^[J])and cgItalic=0)Then Begin
          PushString('}');
          ItalicMode:=False;
         End
          Else
         If(Not(ItalicMode))and(Byte(PC^[J])and cgItalic=cgItalic)Then Begin
          PushString('{\i ');
          ItalicMode:=True;
         End;
         If(DoubleMode)and(Byte(PC^[J])and cgDouble=0)Then Begin
          PushString('\fs24\cgrid0 ');
          DoubleMode:=False;
         End
          Else
         If(Not(DoubleMode))and(Byte(PC^[J])and cgDouble=cgDouble)Then Begin
          PushString('\fs48\cgrid0 ');
          DoubleMode:=True;
         End;
        End;
       End;
       If(J>PosLastAttr)Then Begin
         { Attribut    ≥ Caractäre     ≥ Caractäre ? }
         { ƒƒƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒ}
         { PosLastAttr ≥ PosLastAttr+1 ≥ J }
        UnsetRTF;
       End;
      End;
      If(Paragraph)Then Begin
       If Not((PC^[L-1]=' ')or(L>=Q.SheetFormat.X2))Then Begin
        PushString('\par }');
        Paragraph:=False;
       End;
      End;
      If LastAttr>0Then UnsetRTF;
     End;
    End;
   End;
   Case(Q.ModeSub)of
    vtsASCII,vtsANSI,vtsHTML,vtsRTF:PushString(#13#10);
    vtsTextUnix:PushChar(#13);
    vtsFirstChoice:PushChar(#12);
   End;
   ALNext(Q.List);
   If(FPR>Q.FileSize)Then Break;
  End;
   {êcriture de fin}
  Case(Q.ModeSub)of
   vtsHTML:Begin
    PushString('</HTML>');
    DBDispose(Font);
   End;
   vtsRTF:Begin
    PushChar('}');
    DBDispose(Font);
   End;
  End;
  _SetRec(Handle,LD,Buffer[0]);
  If(Q.ModeSub=vtsFirstChoice)Then Begin
   _GetAbsRec(Handle,0,SizeOf(FirstChoice),FirstChoice);
   FirstChoice.NumLetters:=FileSize(Handle)-SizeOf(FirstChoice);
   _SetAbsRec(Handle,0,SizeOf(FirstChoice),FirstChoice);
  End;
 End
  Else
 Begin
   { Sauvegarde sans aucune filtration ou transformation }
  If(Q.Mode=vtGAT)Then Begin
DefaultGat:
   If Length(Q.PassWord)=0Then Chr:=':'Else Chr:=';';
   PutFileTxt(Handle,Chr+BasicStrW(Q.SheetFormat.X1)+
                         BasicStrW(Q.SheetFormat.Y1)+
                         BasicStrW(Q.SheetFormat.X2)+
                         BasicStrW(Q.SheetFormat.Y2)+' ');
   Case(Q.PageNumIn)of
    ptLeft:Chr:='L';        { NumÇro de page Ö gauche }
    ptRight:Chr:='R';       { NumÇro de page Ö droite }
    ptAltern:Chr:='A';      { NumÇro de page alternÇ gauche/droite }
    Else Chr:='N';          { Pas de numÇro de page }
   End;
   PutFileTxt(Handle,Chr);
   PutFileTxt(Handle,BasicStr(LongInt(Q.PageNumStart)));
   If(Q.InfoCompl)Then PutFileTxt(Handle,' I');
   PutFileLn(Handle);
  End;
  If Length(Q.PassWord)>0Then Begin
   MoveLeft(Q.Password,Buffer,SizeOf(QX.PassWord));
   InvBuf(Buffer,SizeOf(QX.PassWord));
   _SetRec(Handle,SizeOf(QX.PassWord),Buffer);
  End;
  M:=Q.List.Count-1;
  If Integer(M)<>-1Then For I:=0to(M)do Begin
   PDrw:=FindObject(I);
   If(PDrw<>NIL)Then Case(PDrw^.Model)of
    mtImage:;
    mtLineHor:Begin
     PutFileTxtLn(Handle,Spc(Q.SheetFormat.X1)+MultChr(PLineHor^.Bar,Q.SheetFormat.X2-Q.SheetFormat.X1));
     Goto NextGat;
    End;
   End;
   PC:=GetCurrLine;
   L:=StrLen(PC);
   If Length(Q.PassWord)>0Then Begin
    If L>=SizeOf(Buffer)Then L:=SizeOf(Buffer)-1;
    MoveLeft(PC^[0],Buffer,L+1);
    InvBuf(Buffer,L);
    _SetRec(Handle,L+1,Buffer);
   End
    Else
   Begin
    If L>0Then _SetRec(Handle,L,PC^[0]);
    If(I<M)Then _PutFileLn(Handle);
   End;
NextGat:
   If GetSysErr<>0Then Begin
    __DiskFull;
    FileClose(Handle);
    WEDone(LW);
    Exit;
   End;
   ALNext(Q.List);
   If(FPR>Q.FileSize)Then Break;
  End;
 End;
 FileClose(Handle);
 If TmpReadSize=0Then Begin
  Q.Modified:=False;
  Q.FileSize:=GetFileSize(Path);
  TEPutBar(Q);
  If(Q.EditName='')or(UpDate)Then Begin
   Q.EditName:=StrUp(Path);
   If Path2Ext(Q.EditName)<>Path2Ext(Path)Then Begin
    E:=Path2Ext(Q.EditName);                               { Extension: }
    Repeat                                                  { ƒƒƒƒƒƒƒƒƒƒ }
     If Pos(E,StrPas(ExtRC))>0Then L:=vtRC Else             { Ressource }
     If Pos(E,StrPas(ExtPas))>0Then L:=vtPas Else           { Pascal }
     If Pos(E,StrPas(ExtFortran))>0Then L:=vtFortran Else   { Fortran }
     If Pos(E,StrPas(ExtEuphoria))>0Then L:=vtEuphoria Else { Euphoria }
     If Pos(E,StrPas(ExtC))>0Then L:=vtC Else               { C/C++ }
     If Pos(E,StrPas(ExtBas))>0Then L:=vtBas Else           { Basic }
     If Pos(E,StrPas(ExtAsm))>0Then L:=vtAsm Else           { Assembleur }
     If Pos(E,StrPas(ExtAC))>0Then L:=vtAC Else             { AC }
     If Pos(E,'.GAT')>0Then L:=vtGat Else                   { GAT }
     If Pos(E,'.INI')>0Then L:=vtIni Else                   { Initie }
     If Pos(E,'.BAT;.BTM')>0Then L:=vtBatch                 { Batch }
                            Else Break;
     TESetViewMode(Q,L);
    Until True
   End;
   WESetTitle(Q.W,TruncName(Q.EditName,Q.W.MaxX),Q.W.Palette.Title);
  End;
  {Recherche de description}
  UpDateDescription;
  {Fin de description}
 End;
 FreeMemory(TmpRead,TmpReadSize);
 WaitMsg;
 WEDone(LW);
 TESaveAs:=True;
End;

{ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ}
END.