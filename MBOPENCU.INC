{$I DEF.INC}

Type EnumAction=(acAutoDetect,acView,acLoad);

Procedure _OpenFileAtCursor(Action:EnumAction);
Procedure OpenFileAtCursor;
Function  GetNameAtCursor:String;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                                 IMPLEMENTATION
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Uses
 Adele,Systex,Isatex,Memories,Systems,Video,Mouse,Editex,
 {$IFDEF FullVersion}
  MBCortex,
  MalEnv,
  MalLibra,
 {$ENDIF}
 {$IFDEF BureauVersion}
  MBBCrtex,
  MalBEnv,
  MalBLibr,
 {$ENDIF}
 ToolTerm,Dials,FileMana,ProgMan,Apps;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Fonction GetStrMs                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction extraŒt une chemin de fichier … partir de la position
 courante du pointeur de la souris.
}

Function GetStrMs:String;
Var
 I:Byte;
 C:Chr;
 S:String;
Begin
 S:='';
 For I:=LastMouseX to(MaxXTxts)do Begin
  C:=GetChr(I,LastMouseY);
  If Not((C=':')and(I=LastMouseX+1))Then Begin
   If Not(C in['0'..'9','@'..'Z','a'..'z','\','-','.'])Then Break;
  End;
  IncStr(S,C);
 End;
 GetStrMs:=S
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                       Proc‚dure TEXtrkPath                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction extrait un nom  … la position courante du curseur dans
 l'objet de traŒtement de texte sp‚cifi‚ par la variable de param‚trage
 ®Q¯.
}

Function TEXtrkPath(Var Q:EditorApp):String;Near;
Var
 PC:PChr;
 L:Word;
 I:Word;
 S:String;
 Ok:Boolean;
Begin
 ALPopCurrPtr(Q.List,Q.CurrPtr);
 PC:=_ALGetCurrBuf(Q.List);
 L:=StrLen(PC);
 If(Q.Mode<>vtGat)Then Q.PXG:=Q.PX;
 If(L<Q.PXG)Then TEXtrkPath:=''
  Else
 Begin
  S:=StrPas(@PC^[Q.PXG]);
  For I:=1to Length(S)do If Not(S[I]in['0'..'9','@'..'Z','a'..'z','\','-','.'])Then Begin
   If Not((S[I]=':')and(I=2))Then Begin
    S[0]:=Chr(I-1);
    Break;
   End;
  End;
  If Path2Ext(S)=''Then Case(Q.Mode)of
   vtAsm:AddStr(S,'.INC');
   vtBas:AddStr(S,'.BAS');
   vtC:AddStr(S,'.H');
   vtPas:Begin
    Ok:=No;
    For I:=Q.PXG downto 0do Begin
     If(PC^[I]='L')and(PC^[I-1]='$')Then Begin
      Ok:=True;
      Break;
     End;
    End;
    If(Ok)Then AddStr(S,'.ASM')Else AddStr(S,'.PAS');
   End;
  End;
  If Path2Dir(S)=''Then S:=Path2Dir(Q.EditName)+S;
  TEXtrkPath:=S;
 End;
End;

Function GetNameAtCursor:String;Begin
 Case HModel(Windows)of
  wnEdit:GetNameAtCursor:=TEXtrkPath(EditorApp(HPtr(Windows)^));
  wnFileManager:GetNameAtCursor:=FMGetCurrName(FileManagerApp(HPtr(Windows)^));
  Else GetNameAtCursor:='';
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Proc‚dure _OpenFileAtCursor                      Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet d'extraire un nom de fichier … la position courante
 d'un  pointeur  et  de charger le fichier  en question  en m‚moire  en mode
 d'‚dition  ou regard rapide.  S'il s'agit  de fichier ex‚cutable,  elle les
 ex‚cute.


 Remarque
 ÍÍÍÍÍÍÍÍ

  ş Le but de  cette proc‚dure est  de produire le mˆme effet  que le r‚seau
    Internet mais au niveau  local  cette fois.  Ainsi,  des branchements en
    divers  fichier  peuvent  se faire  s'en trop  d'histoire  simplement en
    cliquant sur son nom.
}

Procedure _OpenFileAtCursor;
Var
 OldPath,Path,TPath:String;
 View:Boolean;
 B:Byte;
Begin
 B:=__GetMouseButton;
 Case(Action)of
  acView:View:=True;
  acLoad:View:=False;
  acAutoDetect:View:=B=1;
 End;
 If B>0Then Begin
  Path:=GetStrMs;
  WaitMouseBut0;
 End
  Else
 Path:=GetNameAtCursor;
 If Not FileExist(Path)Then Begin
  If Pos(Path2Ext(Path),'.DOC;.GAT')>0Then Begin
   If(StrI(2,Path)<>':')and(StrI(1,Path)<>'\')Then
    Path:=SetPath4AddFile(StrPas(PathGat))+Path
    Else
   If Not DirExist(Path2Dir(Path))Then
    Path:=SetPath4AddFile(StrPas(PathGat))+Path2NoDir(Path);
{   If DirExist(Path2Dir(TPath))Then Path:=TPath;}
   {If FileExist(TPath)Then} {Path:=TPath;}
  End;
 End;
 If Path<>''Then Begin
  If Pos(Path2Ext(Path),'.EXE;.COM')>0Then Begin
   OldPath:=GetCurrentDir;
   ChDir(Path2Dir(Path));
   ExecPrg(Path,'');
   ChDir(OldPath);
  End
   Else
  If(View)Then ViewAscii(Path)
          Else OpenSelection(Path,255);
{          OpenFile(Path);}
 End;
End;

Procedure OpenFileAtCursor;Begin
 Case HModel(Windows)of
  wnProgMan:If(ProgramsManagerApp(HPtr(Windows)^).Mode=mWin9X)Then SetupDesktop
            Else PMWPropriety(ProgramsManagerApp(HPtr(Windows)^));
  Else _OpenFileAtCursor(acAutoDetect);
 End;
End;
