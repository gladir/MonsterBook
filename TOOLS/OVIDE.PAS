Unit OvIde;

INTERFACE

Uses Isatex,Dials;

Const
 snEdt=$01;

Var Windows:HWins;

Function  GetStrTimeInPrg:String;
Procedure CompilePascal;
Procedure CompileInfo;
Procedure LookOutput;
Procedure OpenAtCursor;
Procedure RunProgram;
Procedure PutLastBar;

IMPLEMENTATION

Uses Adele,Video,Systex,Systems,Mouse,Editor,ToolTerm,
     InfoMemory,EdtSearch,Dialex,Apps,Math,
     PCCortex,   { Coeur de la structure }
     PCInit,     { Initialise le compilateur }
     PCLine,     { Traåtement des lignes }
     PCData,     { DonnÇe de base: information brute }
     PCBase,     { Gestion des bases de donnÇes }
     PCUnit,     { Gestion et fabrication des unitÇs }
     PCAsm,      { Gestion de l'assembleur en ligne directe }
     PCCompile,  { Compilation du code machine }
     PCPass,     { Passe les lignes de langages de programmation }
     PCLink,     { Fabrication des liens }
     PCMake,     { Construction de l'exÇcutable }
     PCDone;     { LibÇration de la mÇmoire utilisÇ pour la compilation }

Var TimeIn:Long;

Function GetStrTimeInPrg:String;
Var
 Hour,Min,Sec:Word;
 Time:LongInt;
Begin
 Time:=Long(Long(GetRawTimer-TimeIn)*901)shr 14;
 If Time<>0Then Begin
  Hour:=Time div 360;
  Min:=Wd(Time div 60)mod 60;
  Sec:=Time mod 60
 End
  Else
 Begin;Hour:=0;Min:=0;Sec:=0;End;
 GetStrTimeInPrg:=CStrTimeDos(Hour,Min,Sec)
End;

Procedure CompilePascal;
Var
 OldProgramFormat:Byte;
 MarkStart:Pointer;

 Procedure PutInfo;Begin
  WC.Y:=1;
  WEPutTxtLn(WC,'Programme principal            = '+CurrFile);
  WEPutTxtLn(WC,'Source courante                = '+CurrFile);
  WEPutTxtLn(WC,'Nom du programme de sortie     = '+Path2NoDir(PathOutput));
  WEPutTxtLn(WC,'Nombre de ligne(s) compilÇ     = '+CStr(NL));
  WEPutTxtLn(WC,'Nombre de macro(s)             = '+CStr(Macro.NB));
  WEPutTxtLn(WC,'Nombre de constante(s)         = '+CStr(ReDef.NB+GhostConst));
  WEPutTxtLn(WC,'Nombre de variable(s)          = '+CStr(VarBk.NB));
  WEPutTxtLn(WC,'Nombre de type(s)              = '+CStr(TypeDef.NB));
  WEPutTxtLn(WC,'Nombre de procÇdure(s)         = '+CStr(ProcBk.NB));
  WEPutTxtLn(WC,'Nombre de code machine         = '+CStr(GhostCode+IP-Org));
  WEPutTxtLn(WC,'MÇmoire disponible en octet(s) = '+CStr(MemAvail));
  WEPutTxtLn(WC,'Temps de compilation           = '+GetStrTimeInPrg);
 End;

 Procedure ErrMsg;
 Var
  Str:String;
  K:Word;
  Handle:Hdl;
  FP,FS:LongInt;
 Begin
  Case(Status)of
   0:Exit;
   FileNotFound:Str:='Fichier introuvable!';
   Else Begin
    Str:='Erreur inconnu!';
    Handle:=FileOpen('ERROR.LST',fmRead);
    If(Handle<>errHdl)Then Begin
     FP:=0;FS:=FileSize(Handle);
     Repeat
      __GetAbsFileTxtLn(Handle,FP,Str);
      If Str0(AbsInt(Status),5)=Left(Str,5)Then Break;
     Until FP>=FS;
     FileClose(Handle);
    End;
   End;
  End;
  WEPutLastBar(Str);
  PutInfo;
  K:=ReadKey;
 End;

Begin
 If Windows.Lst.NB=0Then Begin
  ErrMsgOk('Que voulez-vous que j''exÇcute? Il n''y a màme pas une fenàtre d''ouverte!');
  Exit;
 End;
 OldProgramFormat:=Byte(ProgramFormat);
 Mark(MarkStart);
 WEInitO(WC,60,15);
 WEPushWn(WC);
 WEPutWnKrDials(WC,'Compilation');
 WEPutTxtLn(WC,'êtat                           = Compilation');
 PutInfo;
 TimeIn:=GetRawTimer;
 InitBuffer;
 If(CodePrg=NIL)Then Status:=OutOfMemory
  Else
 Begin
  XEdt:=HPtr(Windows);
  MainFile:=XEdt^.EditName;
  If(ProgramFormat)in[fMEX]Then Begin
   Org:=0;
   IP:=0;
  End;
  If((ProgramFormat)in[fEXE])and(ProgramTarget=ftWin31)Then Begin
   Org:=0;
   IP:=0;
  End;
  CurrFile:=MainFile;
  Status:=CompileFile(MainFile,NL);
  ErrMsg;
  WEDone(WC);
 End;
 Case(Status)of
  0:If(ProgramFormat)in[fBOOT,fCOM,fEXE]Then Begin
   Ok:=((CodePrg^[PrevIP]=$9A)and(CodePrg^[PrevIP+1]=$00)and(CodePrg^[PrevIP+2]=$00)and
       (CodePrg^[PrevIP+3]=$FF)and(CodePrg^[PrevIP+4]=$FF))or
       ((CodePrg^[PrevIP]=$B8)and(CodePrg^[PrevIP+2]=$4C)and
       (CodePrg^[PrevIP+3]=$CD)and(CodePrg^[PrevIP+4]=$21))or
       ((CodePrg^[PrevIP]=$CD)and(CodePrg^[PrevIP+1]=$20));
   If Not(Ok)Then Begin
      { Met fin au programme }
    Case(ProgramFormat)of
     fEXE:PushInstr(#$B8#$00#$4C+ { MOV AX,4C00h + l1 }
                    #$CD#$21);    { INT 21h }
     fCOM:Push2Byte(ciInt,$20);
    End;
   End;
   DumpSuppData;
   MakeExec;
  End;
  FileNotFound:;
  Else TEGotoXY(XEdt^,I,NL-1);
 End;
 DoneBuffer;
 Byte(ProgramFormat):=OldProgramFormat;
 Release(MarkStart);
End;

{$I \Source\Chantal\Library\System\OSStr.Inc}

Procedure CompileInfo;Var W:Window;Begin
 WEInitO(W,70,17);
 WEPushWn(W);
 WEPutWnKrDials(W,'Compilation');
 WELn(W);
 WEPutTxt(W,'Programme principal            = ');
 If CurrFile<>''Then WEPutTxtLn(W,CurrFile)
                Else WEPutTxtLn(W,'Non-dÇfini');
 WEPutTxt(W,'Nom du programme de sortie     = ');
 If PathOutput<>''Then WEPutTxtLn(W,Path2NoDir(PathOutput))
                  Else WEPutTxtLn(W,'Non-dÇfini');
 WEPutTxtLn(W,'Nombre de ligne(s) compilÇ     = '+CStr(NL));
 WEPutTxtLn(W,'Nombre de macro(s)             = '+CStr(Macro.NB));
 WEPutTxtLn(W,'Nombre de constante(s)         = '+CStr(ReDef.NB+GhostConst));
 WEPutTxtLn(W,'Nombre de variable(s)          = '+CStr(VarBk.NB));
 WEPutTxtLn(W,'Nombre de type(s)              = '+CStr(TypeDef.NB));
 WEPutTxtLn(W,'Nombre de procÇdure(s)         = '+CStr(ProcBk.NB));
 WEPutTxtLn(W,'Nombre de code machine         = '+CStr(GhostCode+IP-Org));
 WELn(W);
 WEPutTxtLn(W,'MÇmoire disponible en octet(s) = '+CStr(MemAvail));
 WEPutTxtLn(W,'Systäme d''exploitation         : '+OperatingSystemStr);
 While WEOk(W)do;
End;

{⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ‹
 ≥                           ProcÇdure LockOutput                        €
 ¿‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹€


 Description
 ÕÕÕÕÕÕÕÕÕÕÕ

  Cette procÇdure permet de voir l'Çcran de sortie de l'application. C'est
 l'Çcran DOS d'oó le programme arrive... (Output)!
}

Procedure LookOutput;
Var
 MS:ImgRec;
 I:Word;
 {$IFDEF HeapVram}
  OldHeapVram:Bool;
 {$ENDIF}

 Procedure PutErr;Begin
  If GetSysErr>0Then ErrMsgOk(WordToStr(I)+':'+GetDosErrMsg(GetSysErr))
 End;

Begin
 DialTimer:=No;{$IFDEF HeapVram}OldHeapVram:=HeapVram;{$ENDIF}
 __HideMousePtr;
 PushScr(MS);I:=1;PutErr;
 {$IFDEF HeapVram}HeapVram:=No;{$ENDIF}
 PopScr(Output);I:=2;PutErr;
 SimpleCur;
 __ShowMousePtr;
 Repeat{While ReadKey=7do CarteBios;}
  Case(ReadKey)of
   7:CarteBios;
   Else Break;
  End;
 Until No;
 __HideMousePtr;
 PushScr(Output);I:=3;PutErr;
 {$IFDEF HeapVram}HeapVram:=OldHeapVram;{$ENDIF}
 PopScr(MS);I:=4;PutErr;
 __ShowMousePtr;
 DialTimer:=Ya;
End;

Procedure RunProgram;Begin
 If PathOutput=''Then CompilePascal;
 If PathOutput<>''Then Begin
  ExecPrg(PathOutput,'');
 End;
End;

{⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ‹
 ≥                       ProcÇdure TEXtrkPath                         €
 ¿‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹€


 Description
 ÕÕÕÕÕÕÕÕÕÕÕ

  Cette fonction extrait un nom  Ö la position courante du curseur dans
 l'objet de traåtement de texte spÇcifiÇ par la variable de paramÇtrage
 ÆQØ.
}

Function TEXtrkPath(Var Q:EditorApp):String;Near;
Var
 PC:PChr;
 L:Word;
 I:Word;
 S:String;
 Ok:Boolean;
Begin
 RBPopCurrPtr(Q.List,Q.CurrPtr);
 PC:=_RBGetCurrBuf(Q.List);L:=StrLen(PC);
 If(Q.Mode<>vtGat)Then Q.PXG:=Q.PX;
 If(L<Q.PXG)Then TEXtrkPath:=''
  Else
 Begin
  S:=StrPas(@PC^[Q.PXG]);
  For I:=1to Length(S)do If Not(S[I]in['0'..'9','@'..'Z','a'..'z','\','-','.'])Then Begin
   If Not((S[I]=':')and(I=2))Then Begin S[0]:=Chr(I-1);Break;End;
  End;
  If Path2Ext(S)=''Then Case(Q.Mode)of
   vtAsm:AddStr(S,'.INC');
   vtBas:AddStr(S,'.BAS');
   vtC:AddStr(S,'.H');
   vtPas:Begin
    Ok:=No;
    For I:=Q.PXG downto 0do Begin
     If(PC^[I]='L')and(PC^[I-1]='$')Then Begin;Ok:=Ya;Break;End;
    End;
    If(Ok)Then AddStr(S,'.ASM')Else AddStr(S,'.PAS');
   End;
  End;
  If Path2Dir(S)=''Then S:=Path2Dir(Q.EditName)+S;
  TEXtrkPath:=S;
 End;
End;

Procedure OpenAtCursor;Var Path:String;Begin
 If(HModel(Windows)=snEdt)Then Begin
  Path:=TEXtrkPath(EditorApp(HPtr(Windows)^));
  HLoad(Windows,snEdt,Path);
  PutLastBar;
 End;
End;

Procedure PutLastBar;Begin
 Case HModel(Windows)of
  snEdt:WEPutLastBar('^F3^ Ouvre  ^F2^ Sauvegarde  ^Alt+F9^ Compile');
  Else WEPutLastBar('^F3^ Ouvre  ^Alt+X^ Quitter');
 End;
End;

END.