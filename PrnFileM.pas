{$I DEF.INC}

Unit PrnFileM;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                                  INTERFACE
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Uses
 Isatex;

Procedure FMPrnDir(Var Q:FileManagerApp);
Procedure FMPrnFile(Var Q:FileManagerApp);

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                              IMPLEMENTATION
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Uses
 Systex,Pritex,Systems,Dials,ToolPrn,AppDB,FileMana;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Proc‚dure FMPrnDir                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: FileManager


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet d'imprimer la liste du r‚pertoire courant du
 tableau courant de la fenˆtre de dialogue de Gestionnaire de fichier
 ®FM¯.
}

Procedure FMPrnDir;Begin
 PrnDir(Q.Panel[Q.Plane].Path)
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                            Proc‚dure FMPrnFile                          Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: FileManager


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet d'imprimer l'arbre des r‚pertoires s'il s'agit d'un
 tableau d'arbre des r‚pertoires,  d'imprimer le r‚pertoire s'il s'agit d'un
 item d'un tableau de fichier et que  le nom est un r‚pertoire ou d'imprimer
 un fichier s'il point sur un fichier.  Si le pointeur  d'item pointe sur le
 symbole ®..¯ il imprimera  alors le r‚pertoire courant  et non pas le sous-
 r‚pertoire parent.
}

Procedure FMPrnFile;
Var
 Path:String;
 X:SearchRec;
 I,OldP:Word;
 W:Window;
 QE:EditorApp;

 Function ReadDescr(Path:String):String;
 Var
  FP,FS:LongInt;
  S,Name,N2:String;
  Handle:Hdl;
  J:Word;
 Begin
  ReadDescr:='';
  If(DescrInFile)Then Begin
   S:=Path2Dir(Path);
   N2:=S;
   AddStr(S,'..');
   S:=FileExpand(S);
   If Length(N2)>3Then BackStr(N2);
   N2:=Path2NoDir(N2);S:=SetPath4AddFile(S);
   Handle:=FileOpen(S+'DESCRIPT.ION',fmRead);FP:=0;
   If(Handle<>errHdl)Then Begin
    FS:=FileSize(Handle);
    Repeat
     _GetAbsFileTxtLn(Handle,FP,S);
     Inc(FP,Length(S)+2);
     J:=Pos(' ',S);
     If J=0Then Continue;
     Name:=StrUp(Left(S,J-1));
     If(N2=Name)Then Begin
      ReadDescr:=Copy(S,J+1,255);
      System.Break;
     End;
    Until FP>=FS;
    FileClose(Handle);
   End;
  End;
 End;

Begin
 If(Q.Panel[Q.Plane].Board=BoardTree)Then Begin
  WriteLog('Impression de l''arbre des r‚pertoires de l''unit‚ '+Q.Panel[Q.Plane].Path[1]+':');
  WEPushEndBar(W);
  WEPutLastBar('Impression de l''arbre des r‚pertoires en cours...');
  If(PrnSetup[PrnOutput].PHeight*6)div 10<Q.Panel[Q.Plane].BufTree.NB+1Then Prn(psPrn.InterLn1_8);
  OldP:=Q.Panel[Q.Plane].P;
  For I:=0to Q.Panel[Q.Plane].BufTree.NB-1do Begin
   Q.Panel[Q.Plane].P:=I;
   Prn(StrUSpc(FMGetBarTree(Q,Q.Plane,I),35));
   Prn(ReadDescr(FMGetCurrPathTree(Q,Q.Plane)));
   PrnLn;
  End;
  PrnLn;
  Prn(' Cette unit‚ contient'+CStrBasic(Q.Panel[Q.Plane].BufTree.NB)+' r‚pertoire(s)');
  PrnLn;
  Q.Panel[Q.Plane].P:=OldP;
  WEDone(W);
 End
  Else
 Begin
  FMGetCurrFile(Q,X);
  If CmpLeft(X.Name,'..')Then PrnDir(Q.Panel[Q.Plane].Path)
   Else
  Begin
   Path:=FMGetCurrName(Q);
   If(sfaDir)in(X.Attr.Flags)Then PrnDir(SetPath4AddFile(Path2Dir(Q.Panel[Q.Plane].Path)+X.Name)+'*.*')
    Else
   If Path2Ext(Path)='.DBF'Then PrnDBase(Path)Else
   If Path2Ext(Path)='.GAT'Then Begin
    FillClr(QE,SizeOf(QE));
    QE.EditName:=Path;
    PrnGatEdt(QE);
   End;
  End;
 End;
End;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
END.