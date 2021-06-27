{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                      Compilateur de Volume                      Û
 ³     Malte Genesis/Edition AdŠle pour Mode R‚el/V - Version 1.2  Û
 ³                          1998/07/08                             Û
 ³                                                                 Û
 ³       Tous droits r‚serv‚s par les Chevaliers de Malte (C)      Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Nom des programmeurs
 ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ

  Sylvain Maltais


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Ce programme permet de compiler un listing  de format ressource en
 un volume accrocher … un ex‚cutable.
}

Program ExecVolume;

Uses Dos,Systex,Systems;

{$I \Source\Chantal\Library\System\Malte\Volume\ExecAdel.Inc}

Var Volume:Array[0..48000div SizeOf(FileItemAdele)]of FileItemAdele;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Fonction XtrkPasStr                           Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction extrait une chaŒne de format Pascal  (entre les '') de la
 chaŒne de caractŠre sp‚cifi‚. Il retourne la partie entre crochet dans la
 chaŒne sp‚cifie sans ces crochets.  Si cette chaŒne contient des crochets
 fesant partie d'une phrase, genre ®C''est¯, il retournera ®C'est¯.


 Remarque
 ÍÍÍÍÍÍÍÍ

  ş Cette  fonction  a  ‚t‚  ‚labor‚  …  le  demande  de  compilateurs  et
    convertisseurs de langage de programmation.  Elle n'est pas utile pour
    le novice et un utilisateur normal.
}

Function XtrkPasStr(Var I:Byte;Const L:String;Var EM:Bool):String;Var T:String;Begin
 EM:=Ya;Inc(I);T:='';
 While(L[I]<>'''')or((L[I]='''')and(StrI(I+1,L)=''''))do Begin
  If I>Length(L)Then Break;
  If(L[I]='''')and(StrI(I+1,L)='''')Then Begin
   IncStr(T,'''');
   Inc(I,2)
  End
   Else
  Begin
   IncStr(T,L[I]);
   Inc(I)
  End;
(*  ASM
   LES DI,@Result
   PUSH ES
   PUSH DI
   LES DI,I
   {$IFDEF __386__}
    DB 26h,0Fh,0B6h,1Dh { MOVZX BX,ES:[DI] }
   {$ELSE}
    MOV BL,ES:[DI]
    XOR BH,BH
   {$ENDIF}
   XOR AX,AX
   SUB AX,BP
   MOV DI,Offset L
   SUB DI,AX
   PUSH Word Ptr SS:[DI+BX]
   PUSH CS
   CALL Near Ptr IncStr
   LES SI,I
   {$IFDEF __386__}
    DB 26h,0Fh,0B6h,1Ch { MOVZX BX,ES:[SI] }
   {$ELSE}
    MOV BL,ES:[SI]
    XOR BH,BH
   {$ENDIF}
   XOR AX,AX
   SUB AX,BP
   MOV DI,Offset L
   SUB DI,AX
   CMP SS:[DI],BL
   JE  @Skip
   CMP Word Ptr SS:[DI+BX],39+(39 shl 8)
   JNE @Skip
   INC Byte Ptr ES:[SI]
@Skip:
   INC Byte Ptr ES:[SI]
  END;*)
 End;
 EM:=No;XtrkPasStr:=T;
End;

Procedure MakeExecFile(Const Path,PathRC:String);Label BreakAll;Var Index2Set:Wd;Handle,HandleExec,HandleLoad:Hdl;
M,NM,ND,FP,FS,FSL,IL:Long;Str,StrU,Word,Msg:String;DB,I:Byte;EM,Ok:Bool;Target:PathStr;PE:Long;
Buf:Array[0..4095]of Byte;Begin
 If PathRC=''Then Begin
  WriteLn('Erreur: Fichier ressource non sp‚cifi‚!');
  Halt;
 End;
 Handle:=FileOpen(PathRC,fmRead);
 If(Handle=errHdl)Then Begin
  WriteLn('Erreur: Fichier ',PathRC,' introuvable!');
  Halt;
 End;
 Target:=Path;
 HandleExec:=FileOpen(Target,fmWrite);
 PE:=FileSize(HandleExec);
 SetFilePos(HandleExec,PE);
 FS:=FileSize(Handle);FP:=0;Index2Set:=0;
 Volume[Index2Set].Name:='DBUT';
 Volume[Index2Set].Size:=PE;
 Inc(Index2Set);
 Repeat
  _GetAbsFileTxtLn(Handle,FP,Str);
  If GetSysErr<>0Then Begin SetSysErr(errEdtRead);Break;End;
  I:=1;Inc(FP,Length(Str)+2);SkipSpcInLn(I,Str);
  StrU:=StrUp(Str);Word:=XtrkWord(I,StrU);
  If Word='FILE'Then Begin
   SkipSpcInLn(I,Str);
   Msg:=XtrkPasStr(I,Str,EM);
   HandleLoad:=FileOpen(Msg,fmRead);
   If(HandleLoad<>errHdl)Then Begin
    FSL:=FileSize(HandleLoad);
    Volume[Index2Set].AbsolutePosition:=PE;
    Volume[Index2Set].Size:=FSL;
    Volume[Index2Set].Name:=Msg;
    Inc(Index2Set);
    ND:=FSL div SizeOf(Buf);NM:=FSL mod SizeOf(Buf);M:=0;
    For IL:=0to ND-1do Begin
     _GetAbsRec(HandleLoad,M,SizeOf(Buf),Buf);
     _SetAbsRec(HandleExec,PE+M,SizeOf(Buf),Buf);
     Inc(M,Long(SizeOf(Buf)));
    End;
    If NM>0Then Begin
     _GetAbsRec(HandleLoad,M,NM,Buf);
     _SetAbsRec(HandleExec,PE+M,NM,Buf);
    End;
    FileClose(HandleLoad);
    Inc(PE,FSL);
   End;
  End
   Else
  Begin
   If Not((StrI(I,Str)='/')and(StrI(I+1,Str)='/'))Then Begin{ Ce n'est pas une remarque... }
    If Str<>''Then Begin
     WriteLn('Erreur: Erreur de syntaxe!');
     Break;
    End;
   End;
  End;
 Until FP>=FS;
BreakAll:
 Volume[Index2Set].Name:='FIN';
 Volume[Index2Set].AbsolutePosition:=PE;
 Volume[Index2Set].Size:=(SizeOf(FileItemAdele)+1)*Index2Set;
 Inc(Index2Set);
 _SetAbsRec(HandleExec,PE,SizeOf(FileItemAdele)*Index2Set,Volume);
 FileClose(HandleExec);
 FileClose(Handle);
End;

BEGIN
 FillClr(Volume,SizeOf(Volume));
 WriteLn('ExecVolume  Version 1.2  Tous droits r‚serv‚ par les Chevaliers de Malte');
 InitSystems(suIsabel);
 WriteLn;
 If ParamStr(1)='/?'Then Begin
  WriteLn('Syntaxe: EXECVOLU fichier.EXE fichier.RC');
  Halt;
 End;
 MakeExecFile(ParamStr(1),ParamStr(2));
 If GetSysErr=0Then WriteLn('Op‚ration r‚ussit!');
END.