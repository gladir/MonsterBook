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

Uses Adele,Video,Systex,Memories,Systems,Mouse,Editor,ToolTerm,
     InfoMemo,EdtSearc,Dialex,Apps,Math,
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
  CurrPC.WC.Y:=1;
  WEPutTxtLn(CurrPC.WC,'Programme principal            = '+CurrPC.CurrFile);
  WEPutTxtLn(CurrPC.WC,'Source courante                = '+CurrPC.CurrFile);
  WEPutTxtLn(CurrPC.WC,'Nom du programme de sortie     = '+Path2NoDir(CurrPC.PathOutput));
  WEPutTxtLn(CurrPC.WC,'Nombre de ligne(s) compilÇ     = '+CStr(CurrPC.NL));
  WEPutTxtLn(CurrPC.WC,'Nombre de macro(s)             = '+CStr(CurrPC.Macro.Count));
  WEPutTxtLn(CurrPC.WC,'Nombre de constante(s)         = '+CStr(CurrPC.ReDef.Count+CurrPC.GhostConst));
  WEPutTxtLn(CurrPC.WC,'Nombre de variable(s)          = '+CStr(CurrPC.VarBk.Count));
  WEPutTxtLn(CurrPC.WC,'Nombre de type(s)              = '+CStr(CurrPC.TypeDef.Count));
  WEPutTxtLn(CurrPC.WC,'Nombre de procÇdure(s)         = '+CStr(CurrPC.ProcBk.Count));
  WEPutTxtLn(CurrPC.WC,'Nombre de code machine         = '+CStr(CurrPC.GhostCode+CurrPC.IP-CurrPC.Org));
  WEPutTxtLn(CurrPC.WC,'MÇmoire disponible en octet(s) = '+CStr(MemAvail));
  WEPutTxtLn(CurrPC.WC,'Temps de compilation           = '+GetStrTimeInPrg);
 End;

 Procedure ErrMsg;
 Var
  Str:String;
  K:Word;
  Handle:Hdl;
  FP,FS:LongInt;
 Begin
  If CurrPC.Status=0Then Exit;
  WEPutLastBar(GetErrMsg(CurrPC.Status));
  PutInfo;
  K:=ReadKey;
 End;

Begin
 If Windows.Lst.Count=0Then Begin
  ErrMsgOk('Que voulez-vous que j''exÇcute? Il n''y a màme pas une fenàtre d''ouverte!');
  Exit;
 End;
 OldProgramFormat:=Byte(ProgramFormat);
 Mark(MarkStart);
 TimeIn:=GetRawTimer;
 PCStart(CurrPC);
 WEInitO(CurrPC.WC,60,15);
 WEPushWn(CurrPC.WC);
 WEPutWnKrDials(CurrPC.WC,'Compilation');
 WEPutTxtLn(CurrPC.WC,'êtat                           = Compilation');
 PutInfo;
 If(CurrPC.CodePrg=NIL)Then CurrPC.Status:=OutOfMemory
  Else
 Begin
  CurrPC.XEdt:=HPtr(Windows);
  CurrPC.MainFile:=CurrPC.XEdt^.EditName;
  If(ProgramFormat)in[fMEX]Then Begin
   CurrPC.Org:=0;
   CurrPC.IP:=0;
  End;
  If((ProgramFormat)in[fEXE])and(ProgramTarget=ftWin31)Then Begin
   CurrPC.Org:=0;
   CurrPC.IP:=0;
  End;
  CurrPC.CurrFile:=CurrPC.MainFile;
  CurrPC.Status:=CompileFile(CurrPC.MainFile,CurrPC.NL);
  ErrMsg;
  WEDone(CurrPC.WC);
 End;
 Case(CurrPC.Status)of
  0:If(ProgramFormat)in[fBOOT,fCOM,fEXE]Then Begin
   CurrPC.Ok:=((CurrPC.CodePrg^[CurrPC.PrevIP]=$9A)and
        (CurrPC.CodePrg^[CurrPC.PrevIP+1]=$00)and
        (CurrPC.CodePrg^[CurrPC.PrevIP+2]=$00)and
        (CurrPC.CodePrg^[CurrPC.PrevIP+3]=$FF)and
        (CurrPC.CodePrg^[CurrPC.PrevIP+4]=$FF))or
       ((CurrPC.CodePrg^[CurrPC.PrevIP]=$B8)and
        (CurrPC.CodePrg^[CurrPC.PrevIP+2]=$4C)and
        (CurrPC.CodePrg^[CurrPC.PrevIP+3]=$CD)and
        (CurrPC.CodePrg^[CurrPC.PrevIP+4]=$21))or
       ((CurrPC.CodePrg^[CurrPC.PrevIP]=$CD)and
        (CurrPC.CodePrg^[CurrPC.PrevIP+1]=$20));
   If Not(CurrPC.Ok)Then Begin
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
  Else TEGotoXY(CurrPC.XEdt^,CurrPC.I,CurrPC.NL-1);
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
 If CurrPC.CurrFile<>''Then WEPutTxtLn(W,CurrPC.CurrFile)
                Else WEPutTxtLn(W,'Non-dÇfini');
 WEPutTxt(W,'Nom du programme de sortie     = ');
 If CurrPC.PathOutput<>''Then WEPutTxtLn(W,Path2NoDir(CurrPC.PathOutput))
                  Else WEPutTxtLn(W,'Non-dÇfini');
 WEPutTxtLn(W,'Nombre de ligne(s) compilÇ     = '+CStr(CurrPC.NL));
 WEPutTxtLn(W,'Nombre de macro(s)             = '+CStr(CurrPC.Macro.Count));
 WEPutTxtLn(W,'Nombre de constante(s)         = '+CStr(CurrPC.ReDef.Count+CurrPC.GhostConst));
 WEPutTxtLn(W,'Nombre de variable(s)          = '+CStr(CurrPC.VarBk.Count));
 WEPutTxtLn(W,'Nombre de type(s)              = '+CStr(CurrPC.TypeDef.Count));
 WEPutTxtLn(W,'Nombre de procÇdure(s)         = '+CStr(CurrPC.ProcBk.Count));
 WEPutTxtLn(W,'Nombre de code machine         = '+CStr(CurrPC.GhostCode+CurrPC.IP-CurrPC.Org));
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
  If GetSysErr>0Then ErrMsgOk(WordToStr(I)+':'+GetErrMsg(GetSysErr))
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
 If CurrPC.PathOutput=''Then CompilePascal;
 If CurrPC.PathOutput<>''Then Begin
  ExecPrg(CurrPC.PathOutput,'');
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
 ALPopCurrPtr(Q.List,Q.CurrPtr);
 PC:=_ALGetCurrBuf(Q.List);L:=StrLen(PC);
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