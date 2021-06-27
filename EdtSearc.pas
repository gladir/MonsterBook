{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                                                                  Û
 ³          Malte Genesis/Module de Recherche pour l'diteur        Û
 ³                                                                  Û
 ³                            Adapter pour                          Û
 ³                                                                  Û
 ³          dition Chantal pour Mode R‚el IV - Version 1.0;        Û
 ³      dition Extension AdŠle pour Mode R‚el V - Version 1.0.     Û
 ³                                                                  Û
 ³                       1997/01/01 … 1998/03/23                    Û
 ³                                                                  Û
 ³         Tous droits r‚serv‚ par les Chevaliers de Malte (C)      Û
 ³                                                                  Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette unit‚ contient les proc‚dures et fonctions pour la recherche,
 remplacement  et les boŒtes de dialogues … cette effet pour un texte
 d'objet   ®Edt¯.   Les  recherches   et   remplacement   comprennent
 naturellement  les fonctions  concernant  la  correction  du  texte,
 c'est-…-dire le correcteur d'orthographe.
}

{$I DEF.INC}

Unit EdtSearc;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                               INTERFACE
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Uses
 Isatex,Systex,Editex;

Function  WinSearchData(Mode:SearchDataMode;Var XData:SearchDataRec):Boolean;
Procedure TECorrecteur(Var Q:EditorApp);
Function  TEGotoLns(Var Q:EditorApp;Lns:RBP):Boolean;
Function  TEGotoXY(Var Q:EditorApp;_X:Wd;_Y:RBP):Boolean;
Function  TESearchWord(Var Q:EditorApp):Boolean;
Procedure TESearchAgain(Var Q:EditorApp);
Procedure TESearchProc(Var Q:EditorApp;Const Name:String);

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                            IMPLEMENTATION
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Uses
 Adele,Memories,Systems,Video,Dialex,Dials,DialPlus,Editor,Registry,Restex;

{$I \Source\Chantal\TEPOPCUR.INC}
{$I \Source\Chantal\TESETPTR.INC}
{$I \Source\Chantal\POSX2GAT.INC}

Procedure LoadSearchInfo(Var Search:SearchInfo);Near;Begin
 FillClr(Search,SizeOf(Search));
 ReadMainKey(HKEY_CURRENT_USER,'Software\Text\Search','Find',Search);
End;

Procedure SaveSearchInfo(Var Search:SearchInfo);Near;Begin
 Search.Len:=SizeOf(Search)-2;
 CreateKeyFormat(HKEY_CURRENT_USER,'Software\Text\Search','Find',tdBlob,Search);
End;


{ ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
  ³                         Fonction WinSearchData                        Û
  ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


  Description
  ÍÍÍÍÍÍÍÍÍÍÍ

   Cette fonction est une boŒte  de dialogue demandant le type de recherche
  devant ˆtre effectuer selon l'utilisateur. On doit toutefois sp‚cifier le
  type de recherche … effectuer,  un recherche normal ou  un remplacement …
  partir de la variable de paramŠtrage ®Mode¯.
}

Function WinSearchData;
Var
 DataReplace:Record
  Find:String;
  New:String;
  CaseSensitive:Bool;
  WholeWdOnly:Bool;
  RegularExpression:Bool;
  Direction:Byte;
  Scope:Byte;
  Origin:Byte;
 End;
 DataFind:Record
  Find:String;
  CaseSensitive:Boolean;
  WholeWdOnly:Boolean;
  RegularExpression:Boolean;
  Direction:Byte;
  Scope:Byte;
  Origin:Byte;
 End Absolute DataReplace;
 Search:SearchInfo;
Begin
 WinSearchData:=False;
 FillClr(DataReplace,SizeOf(DataReplace));
 If(Mode=sdReplace)Then Begin
  DataReplace.CaseSensitive:=XData.CaseSensitive;
  DataReplace.WholeWdOnly:=XData.WholeWdOnly;
  DataReplace.RegularExpression:=XData.RegularExpression;
  DataReplace.Origin:=Byte(XData.Origin);
  If ExecuteAppDPU(33,DataReplace)Then Begin
   WinSearchData:=True;
   XData.CaseSensitive:=DataReplace.CaseSensitive;
   XData.WholeWdOnly:=DataReplace.WholeWdOnly;
   XData.RegularExpression:=DataReplace.RegularExpression;
   Byte(XData.Origin):=DataReplace.Origin;
   XData.Data:=DataReplace.Find;
   XData.NewData:=DataReplace.New;
   Search.Last:=XData;
   SaveSearchInfo(Search);
  End;
 End
  Else
 Begin
  DataFind.CaseSensitive:=XData.CaseSensitive;
  DataFind.WholeWdOnly:=XData.WholeWdOnly;
  DataFind.RegularExpression:=XData.RegularExpression;
  DataFind.Origin:=Byte(XData.Origin);
  If ExecuteAppDPU(32,DataFind)Then Begin
   WinSearchData:=True;
   XData.CaseSensitive:=DataFind.CaseSensitive;
   XData.WholeWdOnly:=DataFind.WholeWdOnly;
   XData.RegularExpression:=DataFind.RegularExpression;
   Byte(XData.Origin):=DataFind.Origin;
   XData.Data:=DataFind.Find;
   Search.Last:=XData;
   SaveSearchInfo(Search);
  End;
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                     Proc‚dure TESearchAgain                   Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


  Propri‚taire: Edt
  Portabilit‚:  Globale


  Description
  ÍÍÍÍÍÍÍÍÍÍÍ

   Cette proc‚dure de poursuivre un recherche la o— elle avait ‚t‚
  interrompu la derniŠre par l'utilisateur.
}

Procedure TESearchAgain;
Var
 Search:SearchInfo;
Begin
 If Not TESearchWord(Q)Then Begin
  LoadSearchInfo(Search);
  Search.Last.Origin:=sdEntireScope;
  SaveSearchInfo(Search);
 End;
End;

{ ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
  ³                           Proc‚dure StrUpX                            Û
  ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


  Portabilit‚: Local


  Description
  ÍÍÍÍÍÍÍÍÍÍÍ

   Cette proc‚dure permet de transformer une chaŒne de caractŠres source en
  majuscule dans sa destination pendant une longueur de L+1.
}

Procedure StrUpX(Var InBuf,OutBuf;L:Wd);Near;Var I,J:Wd;IB:TChar Absolute InBuf;OB:TChar Absolute OutBuf;Begin
 I:=0;J:=0;
 For I:=0to L{-1}do If Not(IB[I]in[#1..#31])Then Begin OB[J]:=UpCase(IB[I]);Inc(J)End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                            Fonction PosX2Gat                           Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction compile les coordonn‚es logiques d'une ligne de caractŠres
 ASCIIZ en format physique en m‚moire.
}

Function PosX2Gat(PC:PChr;P:Wd;Var Len:Byte):Wd;Near;Var I,J,L:Wd;Begin
 J:=0;L:=0;
 For I:=0to P-1do If(PC^[J]<' ')and(Byte(PC^[J])and cgDouble=cgDouble)Then Inc(J,2)Else Inc(J);
 For I:=1to(Len)do If(PC^[J+L]<' ')and(Byte(PC^[J+L])and cgDouble=cgDouble)Then Inc(L,2)Else Inc(L);
 Len:=L;PosX2Gat:=J
End;

{ ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
  ³                          Proc‚dure TESearchWord                        Û
  ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


  Propri‚taire: Edt
  Portabilit‚:  Globale


  Description
  ÍÍÍÍÍÍÍÍÍÍÍ

   Cette fonction permet d'effectuer la recherche d'une chaŒne de caractŠres
  dans la listing du traŒtement de texte sans tenir compte des attributs.
}

Function TESearchWord;
Label SkipA,Fix,SkipB;
Var
 J,L,DLP,LP:RBP;
 PLn,PLn2,Pos:PChr;
 Len:Byte;
 b:Word;
 PSearch:Array[Byte]of Char;
 PLnBuf:Array[0..4095]of Char;
 a:RBP;
{ X:SearchDataRec Absolute LastSearch;}
 Search:SearchInfo;
Begin
 TESearchWord:=False;
 LoadSearchInfo(Search);
 If(Search.Last.Origin=sdFromCur)Then a:=Q.P
                                 Else a:=0;
 ALSetPtr(Q.List,a);
 If Not(Search.Last.CaseSensitive)Then Begin
  StrPCopy(@PSearch,StrRomanUp(Search.Last.Data));
  For J:=a to ALMax(Q.List)do Begin
   PLn:=_ALGetCurrBuf(Q.List);L:=StrLen(PLn);
   If L>4095Then L:=4095;
   Inc(L);
   If(Q.Mode=vtGat)Then StrUpX(PLn^,PLnBuf,L)
    Else
   Begin
    MoveLeft(PLn^,PLnBuf,L);
    StrUpper(@PLnBuf);
   End;
   PLn2:=@PLnBuf;
   If(Search.Last.Origin=sdFromCur)and(J=a)Then Begin { Passer par dessus le mot?}
    If(Q.Mode=vtGat)Then b:=Q.PXG Else b:=Q.PX;
    Inc(b,Length(Search.Last.Data));
    If(b>=L)Then Pos:=NIL
            Else Pos:=StrPos(@PLnBuf[b],@PSearch);
   End
    Else
   Pos:=StrPos(@PLnBuf,@PSearch);
   If(Pos<>NIL)Then Begin
    LP:=PtrRec(Pos).Ofs-PtrRec(PLn2).Ofs;
    DLP:=LP;Len:=Length(Search.Last.Data);
    If(Q.Mode=vtGat)Then LP:=PosX2Gat(PLn,LP,Len);
    {$IFNDEF __Windows__}
     If(Search.Last.WholeWdOnly)Then Begin
      If(IsRomanLetter(Chr(Mem[PtrRec(Pos).Seg:LP-1])))or
        (IsRomanLetter(Pos^[Len]))Then Goto SkipA;
     End;
    {$ENDIF}
    If Not(Q.Mode in[vtGat,vtHlp])Then Q.PXG:=Q.PX;
    If(Search.Last.Origin=sdFromCur)and(Q.PXG=LP)and(Q.P=J)Then Goto SkipA;
    Goto Fix;
SkipA:
   End;
   ALNext(Q.List);
  End;
 End
  Else
 Begin
  StrPCopy(@PSearch,Search.Last.Data);
  For J:=a to ALMax(Q.List)do Begin
   PLn:=_ALGetCurrBuf(Q.List);
   If(Search.Last.Origin=sdFromCur)and(J=a)Then Begin { Passer par dessus le mot?}
    If(Q.Mode=vtGat)Then b:=Q.PXG Else b:=Q.PX;
    Inc(b,Length(Search.Last.Data));
    If(b>=L)Then Pos:=NIL
            Else Pos:=StrPos(@PLnBuf[b],@PSearch);
   End
    Else
   Pos:=StrPos(PLn,@PSearch);
   If(Pos<>NIL)Then Begin
    LP:=PtrRec(Pos).Ofs-PtrRec(PLn).Ofs;DLP:=LP;
    {$IFNDEF __Windows__}
     If(Search.Last.WholeWdOnly)Then Begin
      If(IsRomanLetter(Chr(Mem[PtrRec(Pos).Seg:LP-1])))or
        (IsRomanLetter(Pos^[Length(Search.Last.Data)]))Then Goto SkipB;
     End;
    {$ENDIF}
    If Not(Q.Mode in[vtGat,vtHlp])Then Q.PXG:=Q.PX;
    If(Search.Last.Origin=sdFromCur)and(Q.PXG=LP)and(Q.P=J)Then Goto SkipB;
    Len:=Length(Search.Last.Data);
Fix:TEGotoXY(Q,LP,J);
    Q.W.CurrColor:=$B0;
    If(Q.Mode=vtGat)Then Begin
{     PLn:=TEPopCurr(Q);}
     WESetPos(Q.W,Q.X,Q.Y);
     For b:=1to Length(Search.Last.Data)do Begin
      If(PLn^[DLP]<' ')and(Byte(PLn^[DLP])and cgDouble=cgDouble)Then Begin
       WEPutChrGAttr(Q.W,PLn^[DLP+1],Byte(PLn^[DLP]));
       Inc(DLP,2);
      End
       Else
      Begin
       WEPutCube(Q.W,Search.Last.Data[b]);
       Inc(DLP);
      End;
     End;
    End
     Else
    WEBarSelHor(Q.W,Q.X,Q.Y,Q.X+Len-1);
    Search.Last.Origin:=sdFromCur;
    SaveSearchInfo(Search);
    TESearchWord:=True;
    Exit;
SkipB:
   End;
   ALNext(Q.List);
  End;
 End;
 SaveSearchInfo(Search);
 ErrNoMsgOk(ErrStringNotFound);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Proc‚dure TESearchProc                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


  Propri‚taire: Edt
  Portabilit‚:  Globale


  Description
  ÍÍÍÍÍÍÍÍÍÍÍ

   Cette proc‚dure permet  d'effectuer  une recherche  d'une proc‚dure avec
  un nom sp‚cifier  par la variable  de param‚trage  ®Name¯  d‚pendament du
  format Assembleur,  Basic,  C ou  Pascal dans le listing du traŒtement de
  texte d'objet ®Edt¯.

  Remarque
  ÍÍÍÍÍÍÍÍ

   ş Cette proc‚dure ne fait aucune distinction majuscule et minuscule.
}

Procedure TESearchProc(Var Q:EditorApp;Const Name:String);
Var
 J,I,L:RBP;
 PC:PChr;
 Proc:String;
Begin
 If Name=''Then Exit;
 ALSetPtr(Q.List,0);
 Case(Q.Mode)of
  vtAsm:Proc:='PROC';
  vtBas:Proc:='SUB';
  vtC:Proc:='VOID';
  vtPas:Proc:='PROCEDURE';
  Else Exit;
 End;
 If(Q.Mode=vtAsm)Then For J:=0to Q.List.Count-1do Begin
  PC:=_ALGetCurrBuf(Q.List);I:=0;
  While PC^[I]<>#0do Begin
   If Byte(PC^[I])and$DF=Byte(Name[1])and$DFThen Begin
    For L:=1to Length(Name)do Begin
     If Byte(PC^[I])and$DF<>Byte(Name[L])and$DFThen Break;
     Inc(I);
    End;
    If L>=Length(Name)Then Begin
     While PC^[I]in[' ',#8]do Inc(I);
     For L:=1to Length(Proc)do Begin
      If Byte(PC^[I])and$DF<>Byte(Proc[L])Then Break;
      Inc(I);
     End;
     If L>=Length(Proc)Then Begin
      TEGotoXY(Q,I-Length(Name)-Length(Proc)-1,J);
      Exit;
     End;
    End;
   End;
   Inc(I);
  End;
  ALNext(Q.List);
 End
  Else
 For J:=0to Q.List.Count-1do Begin
  PC:=_ALGetCurrBuf(Q.List);I:=0;
  While PC^[I]<>#0do Begin
   If Byte(PC^[I])and$DF=Byte(Proc[1])Then Begin
    For L:=1to Length(Proc)do Begin
     If Byte(PC^[I])and$DF<>Byte(Proc[L])Then Break;
     Inc(I);
    End;
    If L>=Length(Proc)Then Begin
     While PC^[I]in[' ',#8]do Inc(I);
     For L:=1to Length(Name)do Begin
      If Byte(PC^[I])and$DF<>Byte(Name[L])and$DFThen Break;
      Inc(I);
     End;
     If L>=Length(Name)Then Begin
      TEGotoXY(Q,I-Length(Name),J);
      Exit;
     End;
    End;
   End;
   Inc(I);
  End;
  ALNext(Q.List);
 End;
 ErrNoMsgOk(ErrProcedureNotFound);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                             Fonction Compare                           Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Portabilit‚: Local


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de comparer 2 tampons contenu en m‚moire et indique
 s'ils sont  identiques  (True)  et  qu'une/que  des diff‚rence(s)  existes
 (False). Si la lettre de la destination est en majuscule, il est retourn‚e
 comme vrai malgr‚ les accents.
}

Function Compare(Var Source,Dest;Len:Word):Boolean;Near;Assembler;ASM
 {$IFDEF FLAT386}
  MOVZX ECX,Len
  JCXZ @0
  LEA ESI,DWord Ptr Source
  LEA EDI,DWord Ptr Dest
  CLD
@99:
  CMPSB
  JNZ @98                   { C'est pas pareil, faudrait voir s'il n'y aurait }
  LOOP @99                  { pas malgr‚ quelques point en commune... ÄÄÄÄÄ¿}
  JMP @100                  {                                              ³}
@98:                        { <ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}
  DEC ESI
  LODSB
  MOV AH,[EDI-1]
  OR  AX,2020h
  CMP AH,'a'
  JB  @97
  CMP AH,'z'
  JA  @97
  CMP AL,AH
  JNE @97
  LOOP @99
@100:
  JZ  @0
@97:
  MOV CL,1
@0:
  XCHG AX,CX
  XOR AL,1
 {$ELSE}
  MOV CX,Len
  JCXZ @0
  PUSH DS
   LDS SI,Source
   LES DI,Dest
   CLD
 @99:
   CMPSB
   JNZ @98                  { C'est pas pareil, faudrait voir s'il n'y aurait }
   LOOP @99                 { pas malgr‚ quelques point en commune... ÄÄÄÄÄ¿}
   JMP @100                 {                                              ³}
 @98:                       { <ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}
   DEC SI
   LODSB
   MOV AH,ES:[DI-1]
   OR  AX,2020h
   CMP AH,'a'
   JB  @97
   CMP AH,'z'
   JA  @97
   CMP AL,AH
   JNE @97
   LOOP @99
 @100:
   JZ  @0
 @97:
   MOV CL,1
 @0:
  POP DS
  XCHG AX,CX
  XOR AL,1
 {$ENDIF}
END;

Function SettingDown(S:String):String;
Var
 I:Byte;
Begin
 For I:=1to Length(S)do Case S[I]of
  'A'..'Z':S[I]:=ChrDn(S[I]);
  #128:S[I]:='c';
  #129:S[I]:='u';
  #130:S[I]:='e';
  #131..#134:S[I]:='a';
  #135:S[I]:='c';
  #136..#138:S[I]:='e';
  #139..#141:S[I]:='i';
  #142,#143:S[I]:='a';
  #144:S[I]:='e';
  #147..#149:S[I]:='o';
  #150,#151:S[I]:='u';
  #152:S[I]:='y';
  #153:S[I]:='o';
  #154:S[I]:='u';
  #160:S[I]:='a';
  #161:S[I]:='i';
  #162:S[I]:='o';
  #163:S[I]:='u';
  #164,#165:S[I]:='n';
 End;
 S:=DelChr(S,'.');
 SettingDown:=DelChr(S,'''');
End;

Type
 WordProcessor=Record
  Handle:Hdl;
  TableWord:Array[0..255]of LongInt;
 End;

Procedure WPInit(Var Q:WordProcessor);Begin
 Q.Handle:=OpenSearchPath(MaltePath+'SPELL;'+MaltePath,'SPELL.DAT',fmRead);
 If(Q.Handle<>errHdl)Then Begin
  _GetAbsRec(Q.Handle,19,SizeOf(Q.TableWord),Q.TableWord);
 End;
End;

Procedure WPDone(Var Q:WordProcessor);Begin
 FileClose(Q.Handle);
End;

Function WPFound(Var Q:WordProcessor;Const Word:String):Boolean;
Var
 StartPos,NumWord,SizeTable:Long;
 TablePtr:^TLong;
 S:String;
 Mil,Inf,Sup:Integer;
Begin
 WPFound:=False;
 If Word=''Then Begin
  WPFound:=True;
  Exit;
 End;
 If(Q.Handle<>errHdl)Then Begin
  StartPos:=Q.TableWord[Byte(Word[1])];
  If StartPos<>0Then Begin
   _GetAbsRec(Q.Handle,StartPos,SizeOf(Long),NumWord);
   SizeTable:=NumWord shl 2;
   TablePtr:=MemAlloc(SizeTable);
   If(TablePtr<>NIL)Then Begin
    _GetAbsRec(Q.Handle,StartPos+4,SizeTable,TablePtr^);
     {Recherche dichotomique}
    Inf:=1;Sup:=NumWord;
    While(Inf<=Sup)do Begin
     Mil:=(Inf+Sup)shr 1;
     _GetAbsRec(Q.Handle,TablePtr^[Mil],SizeOf(S),S);
     If(Word=S)Then Begin
      WPFound:=True;
      Break;
     End
      Else
     If(SettingDown(Word)>SettingDown(S))Then Inf:=Mil+1
                                         Else Sup:=Mil-1;
    End;
    FreeMemory(TablePtr,SizeTable);
   End;
  End;
 End;
End;

Procedure WPMakeListCorrection(Var Q:WordProcessor;Const Word:String;Var L:ArrayList);Begin
 ALInit(L);
End;

{ ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
  ³                        Proc‚dure TECorrecteur                     Û
  ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


  Propri‚taire: Edt
  Portabilit‚:  Globale


  Description
  ÍÍÍÍÍÍÍÍÍÍÍ

   Cette proc‚dure permet la correction … partir d'une liste de fichier
  contenu dans le r‚pertoire ®SPELL¯ du r‚pertoire moteur. Elle cherche
  dans une liste tous les mots du texte et si elle ne trouve pas le mot
  dans sa liste alors est en fait mension … l'utilisateur.
}

Procedure TECorrecteur;
Label UserSol,Reset;
Var
 Chr:Char;
 I,J,I2,I3,IX,K,IX2,OIX,OI:Word;
 PC:PChr;
 S:String;
 Xit:Boolean;
 W,LW1,LW2:Window;
 Len,GAttr:Byte;
 WP:WordProcessor;
Begin
 WEPushEndBar(LW1);
 WEPutLastBar('Un instant S.V.P. recherche en cours...');
 WPInit(WP);
 Xit:=False;
 ALSetPtr(Q.List,Q.P);
 For J:=Q.P to Q.List.Count-1do Begin
  PC:=_ALGetBuf(Q.List,J);I:=0;IX:=0;
  While PC^[I]<>#0do Begin
   I2:=0;
Reset:
   S:='';Len:=0;OIX:=IX;OI:=I;
{   While PC^[I]=' 'do Begin
    Inc(I);
    Inc(IX);
   End;}
   While PC^[I]in[#1..#31,'-','''','A'..'Z','a'..'z',#128..#165]do Begin
    If PC^[I]>#31Then Begin
     If PC^[I]in['A'..'Z']Then IncStr(S,ChrDn(PC^[I]))
                          Else IncStr(S,PC^[I]);
     Inc(Len);
     Inc(IX)
    End Else
    If(Byte(PC^[I])and cgDouble=cgDouble)Then Begin
     Inc(Len);
     Inc(IX)
    End;
    If(PC^[I]='''')and(Length(S)<=3)Then Begin;
     Inc(I);
     Break;
    End;
    Inc(I);
   End;
   If S=''Then Begin
    Inc(I);
    Inc(IX);
   End
    Else
   If(S='…')or((Length(S)=2)and(S[2]='''')and
     (ChrDn(S[1])in['c','d','j','l','m','n','s','t']))Then Begin
    { …, c', d', j', l', m', n', s', t' }
   End
    Else
   If WPFound(WP,S)Then Begin
    { Mot ou adjectif sans accord }
   End
    Else
   If(ChrUp(S[Length(S)])='S')and
     (Copy(StrUp(S),Length(S)-2,2)<>'ER')and { Pas verbe en -er? }
     (Copy(StrUp(S),Length(S)-2,2)<>'IR')and { Pas verbe en -ir? }
     (WPFound(WP,Left(S,Length(S)-1)))Then Begin
    { Mot ou adjectif au pluriel }
   End
    Else
   If(Copy(StrUp(S),Length(S)-2,3)='ANT')and { Verbe en -er? }
     (WPFound(WP,Left(S,Length(S)-3)+'er'))Then
   Begin
    { Participe pr‚sent }
   End
    Else
   Begin
    If OIX>0Then Begin
     If(PC^[OIX-1]<' ')and(Byte(PC^[OIX-1])and cgDouble=cgDouble)Then Dec(OIX);
    End;
    TEGotoXY(Q,OIX,J);
    Q.W.CurrColor:=$B0;Q.W.X:=Q.X;Q.W.Y:=Q.Y;IX2:=OI;
    If IX2>0Then Begin
     If PC^[IX2-1]<' 'Then Dec(IX2);
    End;
    For I3:=1to Length(S)do Begin
     If PC^[IX2]<' 'Then Begin
      GAttr:=Byte(PC^[IX2]);
      Inc(IX2)
     End
      Else
     GAttr:=0;
     WEPutChrGAttr(Q.W,S[I3],GAttr);
     Inc(IX2);
    End;
    WESetKrBorder(Q.W);
    WEPushEndBar(LW2);
    WEPutLastBar('S‚lectionner l''un des chiffres sugg‚r‚e S.V.P. ou ^ESC^ pour annuler');
    I3:=WEGetRY1(Q.W)+Q.Y+1;
    If(I3+7+1>=MaxYTxts)Then WEInit(W,10,I3-9,70,I3-2)
                        Else WEInit(W,10,I3,70,I3+7);
    WEPushWn(W);
    WEPutWnKrDials(W,'Correcteur');
    WELn(W);
    WEPutTxtLn(W,'Faute d''orthographe possible! Que dois-je faire?');
    WELn(W);
    WEPutTxtLn(W,'1 - Passer au mot suivant');
    WEPutTxtLn(W,'2 - Arrˆter la correction');
    Repeat
     K:=WEReadk(W);Chr:=Char(K);
     If(K=kbEsc)Then Chr:='2';
    Until(Chr)in['1','2'];
    WEDone(W);
    WEDone(LW2);
    If Chr='2'Then Xit:=True;
   End;
   If(Xit)Then Break;
  End;
  If(Xit)Then Break;
 End;
 WPDone(WP);
 WEDone(LW1);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Fonction TEGotoLns                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction d‚place le pointeur du texte … la ligne absolue d‚finit
 par la variable ®Lns¯. Une mise … jour est naturellement faŒte pour que
 corresponde le contenu de l'‚cran et les donn‚es internes...


 Remarque
 ÍÍÍÍÍÍÍÍ

  ş Cette fonction est un genre de substitue de la proc‚dure TEGotoXY.
}

Function TEGotoLns;
Var
 J:Byte;
 Size:Word;
 PC:PChr;
Begin
 TEGotoLns:=False;
 If Lns=0Then Exit;
 Dec(Lns);
 If Lns>Q.List.Count-1Then
  ErrMsgOk('Valeur en dehors des limites permisses. Les limites sont entre 1 et '+IntToStr(Q.List.Count)+'.')
  Else
 Begin
  Q.Y:=0;Q.P:=Lns;Q.PX:=0;Q.PXG:=0;Q.X:=0;
  TEPutPos(Q);
  TEUpDateScr(Q);
  TESetPtr(Q);
  TEUpDateInfo(Q);
  TEGotoLns:=True;
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Fonction TEGotoXY                            Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction envoie le pointeur de texte … la position d‚finit par les
 variable de param‚trage  ®X¯ et  ®Y¯ de fa‡on absolue.  Il met … jour les
 donn‚es interne et visuel.
}

Function TEGotoXY;
Var
 PC:PChr;
Begin
 TEGotoXY:=False;
 WESetPos(Q.W,0,0);
 If(Q.List.Count-1<Q.W.MaxY)Then Q.Y:=0;
 If(Q.Mode=vtGat)and(Q.ScrollLock)and(_X>Q.SheetFormat.X2)Then _X:=Q.SheetFormat.X2;
 If(_X<Q.W.MaxX)Then Q.X:=_X
                Else Q.X:=0;
 Q.P:=_Y;Q.PX:=_X;
  { Le teste suivant existe afin de corriger le bug de d‚but de la page 1,
    il semble y avoir une valeur inf‚rieur de 1 … la ligne par rapport …
    l'‚cran et pour r‚gler le problŠme les deux sont align‚es... }
 If(Q.P<Q.Y)Then Q.P:=Q.Y;
 TESetPtr(Q);
 PC:=_ALGetCurrBuf(Q.List);
 Q.PXG:=PosX2Gat1{xx}(PC,_X);
 TEUpdateScr(Q);
 TEUpdateInfo(Q);
 TEGotoXY:=True;
End;

END.