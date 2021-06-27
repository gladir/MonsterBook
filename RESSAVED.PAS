{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                                                                         Û
 ³        Malte Genesis/Ressource de sauvegarde de base de donn‚es         Û
 ³                                                                         Û
 ³            dition Chantal pour Mode R‚el/IV - Version 1.1              Û
 ³                              1995/11/30                                 Û
 ³                                                                         Û
 ³          Tous droits r‚serv‚s par les Chevaliers de Malte (C)           Û
 ³                                                                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Nom du programmeur
 ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ

  Sylvain Maltais


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette unit‚ est utilis‚ pour sauvegarder la base de donn‚es ou la
 cr‚ation de celui-ci.
}

{$I DEF.INC}

Unit ResSaveD;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                                    INTERFACE
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Uses ResTex,Systex;

Procedure DBCreate(Var Q:DataSet);
Procedure DBCreateEntryOnServer(Var Q:DataSet;Const ServerName:String);
Procedure DBCreateServer(Var Q:DataSet);
Function  DBCreateWithSQL(Var Q:DataSet;Var L:ArrayList;Handle:Hdl):Boolean;
Function  DBCreateWithIndex(Var Q:DataSet;Const Name:String;Index:Word):Boolean;
Function  DBCreateWithAppIndex(Var Q:DataSet;Index:Word):Boolean;
Function  DBExportedOneFileDataBase(Var Q:DataSet;Const Name,Dest:String):Boolean;
Procedure DBSetExternFileNameDataBase(Var Q:DataSet;Const FileName:String);
Procedure DBSetExternOffsetDataBase(Var Q:DataSet;Offset:LongInt);
Procedure DBUpdateDirectory(Var Q:DataSet);

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                                IMPLEMENTATION
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Uses
 Memories,Systems,Numerix,ResServD,ResLoadD;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                     Proc‚dure DBUpdateAttribut                    Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: DataSet
 Portabilit‚:  Local


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de mettre … jour les attributs d'une table de
 base de donn‚es.
}

Procedure DBUpdateAttribut(Var Q:DataSet);
Var
 Header:DataBaseHeader; { Structure de l'entˆte d'un fichier de base de donn‚e}
Begin
 _GetAbsRec(Q.Handle,Q.StartPos,SizeOf(Header),Header);
 Header.Attribut:=Q.Attribut;
 _SetAbsRec(Q.Handle,Q.StartPos,SizeOf(Header),Header);
End;

Procedure DBSetExternOffsetDataBase(Var Q:DataSet;Offset:LongInt);
Var
 Header:DataBaseHeader; { Structure de l'entˆte d'un fichier de base de donn‚e}
Begin
 _GetAbsRec(Q.Handle,Q.StartPos,SizeOf(Header),Header);
 Header.OffsetFilePosExtern:=Offset;
 _SetAbsRec(Q.Handle,Q.StartPos,SizeOf(Header),Header);
End;

Procedure DBSetExternFileNameDataBase(Var Q:DataSet;Const FileName:String);
Var
 Header:DataBaseHeader; { Structure de l'entˆte d'un fichier de base de donn‚e}
Begin
 If(DBGetExternFileNameDataBase(Q)<>FileName)Then Begin
  _GetAbsRec(Q.Handle,Q.StartPos,SizeOf(Header),Header);
  If FileName=''Then Begin
   Header.PosFileNameDataBaseExtern:=0;
   Exclude(Q.Attribut,dsExternData);
  End
   Else
  Begin
   Header.PosFileNameDataBaseExtern:=FileSize(Q.Handle);
   Include(Q.Attribut,dsExternData);
  End;
  Header.Attribut:=Q.Attribut;
  _SetAbsRec(Q.Handle,Q.StartPos,SizeOf(Header),Header);
  _SetAbsRec(Q.Handle,Header.PosFileNameDataBaseExtern,Length(FileName)+1,FileName);
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                     Proc‚dure DBUpdateSizeCurrEntry               Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: DataSet
 Portabilit‚:  Local


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet d'effectuer la mise … jour de la taille de la
 base de donn‚es courante.
}

Procedure DBUpdateSizeCurrEntry(Var Q:DataSet;Size:LongInt);
Var
 Data:DataBaseFileEntry;
Begin
 If(Q.Directory<>NIL)Then Begin
  Q.Directory^.CurrPos:=Q.CurrPosEntryOnDir;
  DBReadRec(Q.Directory^,Data);
  Data.Size:=Size;
  Q.Directory^.CurrPos:=Q.CurrPosEntryOnDir;
  DBWriteRec(Q.Directory^,Data);
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Proc‚dure DBCreate                          Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: DataSet
 Portabilit‚:  Global


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de cr‚er une nouvelle table de base de donn‚es.
}

Procedure DBCreate(Var Q:DataSet);
Var
 Header:DataBaseHeader;       { Structure de l'entˆte d'un fichier de base de donn‚e}
 HeaderDBase:DBaseIIIFileHeaderRec Absolute Header;
 Buffer:Array[0..511]of Byte; { Tampon de champs }
 Field:Record
  Size:Word;                  { Taille du champ }
  PrimaryKey:Boolean;         { Cl‚ primaire?}
  Unique:Boolean;             { Unique? }
  NotNull:Boolean;            { Non-nulle? }
  TypeDef:Word;               { td???? }
  Len:Word;                   { Longueur du champ}
 End Absolute Buffer;
 FieldDBase:DBaseIIIFieldRec Absolute Buffer;
 Len:Word;                    { Longueur de la chaŒne de caractŠres + 1 }
 I:Integer;                   { Compteur de boucle }
 P:LongInt;                   { Position actuel dans le fichier }
Begin
 If(Q.Handle=errHdl)Then Begin
  Q.Handle:=FileCreate(Q.FileName);
  If(Q.Handle=errHdl)Then Exit;
 End;
 Case(Q.Origin)of
  0:Begin
   FillClr(Header,SizeOf(Header));
   Header.TypeASCII:='Base de donn‚es du Malte Genesis'#26;
   MoveLeft(Header.TypeASCII[1],Header.TypeASCII,SizeOf(Header.TypeASCII)-1);
   Header.Sign:='DataBaseMalte';
   If Q.RealName<>''Then Header.RealName:=Q.RealName
                    Else Header.RealName:=Path2NoDir(Q.FileName);
   Header.NumField:=Q.FieldRec.Num;
   Header.Attribut:=Q.Attribut;
   _SetAbsRec(Q.Handle,Q.StartPos,SizeOf(Header),Header);
   P:=SizeOf(Header)+Q.StartPos;
   For I:=0to Q.FieldRec.Num-1do Begin
    If(Q.FieldRec.Buffer^[I].TypeDef=tdVarChar)Then Begin
     Include(Header.Attribut,dsRelative);
     Include(Q.Attribut,dsRelative);
    End;
    FillClr(Field,SizeOf(Field));
    Len:=StrLen(Q.FieldRec.Buffer^[I].Title)+1;
    Field.Size:=9+Len;
    MoveLeft(Q.FieldRec.Buffer^[I],Buffer[2],7);
    MoveLeft(Q.FieldRec.Buffer^[I].Title^,Buffer[9],Len);
    _SetAbsRec(Q.Handle,P,Field.Size,Buffer);
    Inc(P,LongInt(Field.Size));
   End;
   Header.SizeTotalField:=P-(SizeOf(Header)+Q.StartPos);
   _SetAbsRec(Q.Handle,Q.StartPos,SizeOf(Header),Header);
   SetFilePos(Q.Handle,Q.StartPos+Header.SizeTotalField+SizeOf(Header));
   If(Q.Directory<>NIL)Then DBUpdateSizeCurrEntry(Q,P-Q.StartPos);
  End;
  Else Begin
   FillClr(HeaderDBase,SizeOf(HeaderDBase));
   HeaderDBase.HeadType:=Q.Origin;
   If Q.SizeRec=0Then DBSetSizeRec(Q);
   HeaderDBase.RecordSize:=Q.SizeRec;
   _SetAbsRec(Q.Handle,Q.StartPos,SizeOf(HeaderDBase),HeaderDBase);
   P:=SizeOf(HeaderDBase)+Q.StartPos;
   For I:=0to Q.FieldRec.Num-1do Begin
    FillClr(FieldDBase,SizeOf(FieldDBase));
    StrPascalCopy(FieldDBase.FieldName,SizeOf(FieldDBase.FieldName)-1,StrPas(Q.FieldRec.Buffer^[I].Title));
    Repeat
     Case(Q.FieldRec.Buffer^[I].TypeDef)of
      tdDirectChar:FieldDBase.FieldType:='C';
      tdNumeric:FieldDBase.FieldType:='N';
      tdSmallInt:FieldDBase.FieldType:='I';
      tdByte,tdBoolean:Begin
       FieldDBase.FieldType:='L';
       FieldDBase.Width:=1;
       Break;
      End;
      tdChar:If Q.FieldRec.Buffer^[I].Len=0Then Begin
       FieldDBase.FieldType:='C';
       FieldDBase.Width:=1;
       Break;
      End;
     End;
     FieldDBase.Width:=Q.FieldRec.Buffer^[I].Len;
    Until True;
    _SetAbsRec(Q.Handle,P,SizeOf(FieldDBase),FieldDBase);
    Inc(P,SizeOf(FieldDBase));
   End;
   PutFileTxt(Q.Handle,#13);
   HeaderDBase.HeaderLength:=P;
   _SetAbsRec(Q.Handle,Q.StartPos,SizeOf(HeaderDBase),HeaderDBase);
  End;
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                      Proc‚dure DBCreateIndex                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: DataSet
 Portabilit‚:  Global


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de cr‚er l'index d'acc‚l‚ration d'une table de
 base de donn‚es.
}

Procedure DBCreateIndex(Var Q:DataSet);
Var
 Header:DataBaseHeader;       { Structure de l'entˆte d'un fichier de base de donn‚e}
 Index:^TLong;                { Table contenant la position des Index }
 SizeIndex:Word;              { Taille de la table d'index }
 SubSize:LongInt;             { Index inutile}
 P:LongInt;                   { Position actuel dans le fichier }
 I:Integer;                   { Compteur de boucle }
 NumRec:LongInt;              { Nombre d'enregistrement }
 Attribut:DataBaseAttribut;
Begin
 NumRec:=Q.CurrLine;
 SubSize:=-4;
 FillClr(Header,SizeOf(Header));
 _GetAbsRec(Q.Handle,Q.StartPos,SizeOf(Header),Header);
 If Not((dsRelative)in(Header.Attribut))Then Exit;
 Header.PosIndex:=FileSize(Q.Handle);
 P:=Header.PosIndex;
 If(dsIndex)in(Q.Attribut)Then Begin
  Include(Header.Attribut,dsIndex);
  SizeIndex:=NumRec shl 2;
  Index:=MemAlloc(SizeIndex);
 End
  Else
 Begin
  SizeIndex:=0;
  Index:=NIL;
 End;
 If(Index<>NIL)Then Begin
  Attribut:=Q.Attribut;
  Q.Attribut:=[dsRelative];
  DBFirst(Q);
  For I:=0to NumRec-1do Begin
   Index^[I]:=Q.CurrPos;
   DBNext(Q);
{   If DBEOF(Q)Then Begin
    NumRec:=I+1;
    Break;
   End;}
  End;
  Q.Attribut:=Attribut;
 End
  Else
 Exclude(Header.Attribut,dsIndex);
 If(Index<>NIL)Then Begin
  If Index^[NumRec-1]>$FFFFThen Begin
   Include(Header.Attribut,dsBig);
   _SetAbsRec(Q.Handle,P,SizeIndex,Index^);
   _SetAbsRec(Q.Handle,P+SizeIndex,SizeOf(LongInt),Header.PosIndex);
  End
   Else
  Begin
   For I:=0to NumRec-1do Begin
    _SetAbsRec(Q.Handle,P+LongInt(I shl 1),SizeOf(Word),Index^[I]);
   End;
   _SetAbsRec(Q.Handle,P+LongInt(NumRec shl 1),SizeOf(Word),Header.PosIndex);
   Inc(SubSize,NumRec shl 1);
  End;
  Header.SizeIndex:=SizeIndex-SubSize;
  _SetAbsRec(Q.Handle,Q.StartPos,SizeOf(Header),Header);
 End;
 FreeMemory(Index,SizeIndex);
 If(Q.Directory<>NIL)Then DBUpdateSizeCurrEntry(Q,P-Q.StartPos+SizeIndex-SubSize);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                       Fonction PXtrkPasStr                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: DataSet
 Portabilit‚:  Local


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet d'extraire une chaŒne de caractŠres de format
 Pascal … la position courante d'une pointeur de chaŒne de caractŠres
 ASCIIZ.
}

Function PXtrkPasStr(Var I:Word;L:PChr;Var EM:Boolean):String;
Var
 T:String;       { ChaŒne de caractŠres contenant le r‚sultat }
 W:String;       { ChaŒne de caractŠres de traŒtement des hexad‚cimal }
 Extern:Boolean; { Symbole externe … la chaŒne de caractŠres }
 Plus:Boolean;   { Signe plus rencontr‚? }
Begin
 EM:=True;
 Extern:=L^[I]='#';
 T:='';
 Plus:=False;
 Repeat
  If L^[I]=#0Then Break;
  If(Extern)Then Begin
   Case L^[I]of
    '#':Begin
     W:='';Plus:=False;
     If L^[I+1]='$'Then Begin
      Inc(I,2);
      While L^[I]in['0'..'9','A'..'F','a'..'f']do Begin
       IncStr(W,L^[I]);
       Inc(I);
      End;
      If W<>''Then IncStr(T,Chr(HexStrToInt(W)));
     End
      Else
     If L^[I+1]='!'Then Begin
      Inc(I,2);
      While L^[I]in['0'..'1']do Begin
       IncStr(W,L^[I]);
       Inc(I);
      End;
      If W<>''Then IncStr(T,Chr(BinStr2Nm(W)));
     End
      Else
     If L^[I+1]in['0'..'9']Then Begin
      Inc(I,2);
      While L^[I]in['0'..'9']do Begin
       IncStr(W,L^[I]);
       Inc(I);
      End;
      If W<>''Then IncStr(T,Chr(StrToWord(W)));
     End;
    End;
    '''':Begin
     Plus:=False;
     Extern:=False
    End;
    '+':If(Plus)Then Break
     Else
    Begin
     Inc(I);
     Plus:=True;
    End;
    Else Break;
   End;
  End
   Else
  Begin
   Inc(I);
   While(L^[I]<>'''')or((L^[I]='''')and(L^[I+1]=''''))do Begin
    If L^[I]=#0Then Break;
    If(L^[I]='''')and(L^[I+1]='''')Then Begin
     IncStr(T,'''');
     Inc(I,2)
    End
     Else
    Begin
     IncStr(T,L^[I]);
     Inc(I)
    End;
   End;
   If L^[I]=''''Then Begin
    Inc(I);
    Extern:=True;
   End;
  End;
 Until False;
 EM:=False;
 PXtrkPasStr:=T;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Fonction InsFile                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: DataSet
 Portabilit‚:  Local


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet d'ins‚rer … un fichier un autre fichier … la
 position courante de celui-ci.
}

Function InsFile(HTarget:Hdl;Const FileName:String):Byte;
Label ErrS;
Var
 HSource:Hdl;
 Buf:Array[0..4095]of Byte;
 Size,I,ND,M:LongInt;
 NM:Word;
Begin
 HSource:=FileOpen(FileName,fmRead);
 If(HSource=errHdl)Then Begin
  ASM
   MOV @Result,errFileNotFound
  END;
  Exit;
 End;
 Size:=FileSize(HSource);
 If(HTarget=errHdl)Then Begin
  ASM MOV @Result,errMakeFile;END;
  Goto ErrS;
 End;
 ND:=Size div SizeOf(Buf);
 NM:=Size mod SizeOf(Buf);M:=0;
 For I:=0to ND-1do Begin
  _GetAbsRec(HSource,M,SizeOf(Buf),Buf);
  _SetRec(HTarget,SizeOf(Buf),Buf);
  ASM
   MOV AX,SysErr
   MOV @Result,AL
  END;
  Inc(M,Long(SizeOf(Buf)));
 End;
 If NM>0Then Begin
  _GetAbsRec(HSource,M,NM,Buf);
  _SetRec(HTarget,NM,Buf);
  ASM
   MOV AX,SysErr
   MOV @Result,AL
  END;
 End;
ErrS:FileClose(HSource);
End;

Function DBReadLine(Var Q:DataSet):Boolean;Begin
 DBReadLine:=False;
 {$IFDEF __Windows__}
  If(Q.ReadHandle=0)or(Q.ReadHandle=errHdl)Then
 {$ELSE}
  If(Q.ReadHandle)in[0,errHdl]Then
 {$ENDIF}
 Begin
  Q.PC:=_ALGetCurrBuf(Q.List^);
  ALNext(Q.List^);
 End
  Else
 Begin
  If(Q.ReadPos>=Q.ReadFileSize)Then Exit;
  SetFilePos(Q.ReadHandle,Q.ReadPos);
  Inc(Q.ReadPos,LongInt(_GetFilePTxtLn(Q.ReadHandle,Q.PC,4096))+2);
 End;
 Inc(Q.ReadY);
 DBReadLine:=True;
End;

Procedure DBPushErr(Var Q:DataSet;Code:Word);Begin
 Q.ErrCode:=Code;
 If(@Q.OnStatusCompiler<>NIL)Then Begin
  Q.OnStatusCompiler(Q,Q.OnStatusCompilerContext^,Q.ReadY);
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Fonction DBCreateWithSQL                     Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: DataSet
 Portabilit‚:  Global


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de cr‚er les tables … partir de commandes ®SQL¯.
}

Function DBCreateWithSQL(Var Q:DataSet;Var L:ArrayList;Handle:Hdl):Boolean;
Label BreakAll;
Var
 I:Word;                     { Compteur de ligne }
 BT:Word;                    { Type temporaire }
 LT:LongInt;                 { Type long temporaire }
 Size:Word;                  { Taille }
 OpenC:Word;                 { Nombre d'ouverture d'accolade }
 Pos:(pNone,pCreate,pTable,pCreateIndex,pInsert,pInsertInto,pInsertValue); { Dans l'instruction Create Table? }
 PosLine:(lNone,lName,lType,lNot,lPrimary); { Dans une ligne de champ? }
 R:Real;                     { Nombre r‚el temporaire }
 S:String;                   { Chaine de travail }
 FieldRec:^TFieldRec;        { Pointeur d'item }
 SizeFieldRec:Word;          { Taille du pointeur d'item }
 NumFieldRec:Word;           { Nombre de champs d'enregistrement }
 EM:Boolean;                 { Fermeture guillemet? }
 CurrPos:LongInt;            { Position courante }
 InRem:Boolean;              { Dans une remarque? }
 Max:LongInt;                { Maximum }
 Created:Boolean;            { Cr‚ation? }
Begin
 DBCreateWithSQL:=True;
 Created:=False;
 If(L.Count>0)or(Handle<>errHdl)Then Begin
  Q.ReadY:=0;InRem:=False;Q.ErrCode:=0;
  SizeFieldRec:=65520;NumFieldRec:=0;
  {$IFDEF Real}
   If MaxAvail<65520Then SizeFieldRec:=MaxAvail;
  {$ENDIF}
  FieldRec:=MemNew(SizeFieldRec);
  If(Handle<>errHdl)Then Begin
   Q.ReadHandle:=Handle;
   Q.List:=NIL;
   Q.PC:=MemAlloc(4096);
   If(Q.PC=NIL)Then Exit;
   Q.ReadPos:=0;
   Q.ReadFileSize:=FileSize(Q.ReadHandle);
   Max:=$FFFF
  End
   Else
  Begin
   Q.ReadHandle:=errHdl;
   Q.List:=@L;
   Max:=L.Count-1;
   ALSetPtr(L,0);
  End;
  Pos:=pNone;PosLine:=lNone;OpenC:=0;
  For I:=0to(Max)do Begin
   If Not DBReadLine(Q)Then Break;
   If(Q.PC<>NIL)Then Begin
    Q.ReadX:=0;
    While Q.PC^[Q.ReadX]<>#0do Begin
     If(InRem)Then Begin
      If(Q.PC^[Q.ReadX]='*')and(Q.PC^[Q.ReadX+1]='/')Then Begin
       InRem:=False;
       Inc(Q.ReadX,2);
      End
       Else
      Inc(Q.ReadX);
     End
      Else
     Case Q.PC^[Q.ReadX]of
      '/':Case Q.PC^[Q.ReadX+1]of
       '/':Break;       { Remarque // }
       '*':Begin
        InRem:=True; { Remarque /* ... */}
        Inc(Q.ReadX,2);
       End;
       Else Break;
      End;
      '(':Begin
       Inc(OpenC);
       Inc(Q.ReadX);
      End;
      ')':Begin
       If OpenC>0Then Begin
        Dec(OpenC);
        If(OpenC=0)and((Pos)in[pCreate,pTable])Then Inc(NumFieldRec);
       End;
       Inc(Q.ReadX);
      End;
      ';':Begin
       Case(Pos)of
        pCreate,pTable:Begin
         Q.FieldRec.Num:=NumFieldRec;
         If(Q.FieldRec.Buffer=NIL)Then
          Q.FieldRec.Buffer:=MemNew(Q.FieldRec.Num*SizeOf(FieldDataBaseRec));
         If(Q.FieldRec.Buffer<>NIL)Then Begin
          MoveLeft(FieldRec^,Q.FieldRec.Buffer^,Q.FieldRec.Num*SizeOf(FieldDataBaseRec));
         End;
         DBCreate(Q);
        End;
        pInsertValue:Begin
         Inc(Q.CurrLine);
        End;
       End;
       CurrPos:=0;
       Pos:=pNone;
       Inc(Q.ReadX);
      End;
      '''','#':If(Pos=pInsertValue)Then Begin
       FillClr(S,SizeOf(S));
       EM:=False;
       S:='';
       Repeat
        If S<>''Then Begin
         If Not DBReadLine(Q)Then Goto BreakAll;
         Q.ReadX:=0;
         While Q.PC^[Q.ReadX]=' 'do Inc(Q.ReadX);
        End;
        AddStr(S,PXtrkPasStr(Q.ReadX,Q.PC,EM));
       Until Not(((Q.ReadX>0))and(Q.PC^[Q.ReadX-1]='+')and(Q.PC^[Q.ReadX]=#0));
       Case(FieldRec^[CurrPos].TypeDef)of
        tdBlob:Begin
         If S=''Then LT:=0 Else LT:=GetFileSize(S);
         _SetRec(Q.Handle,SizeOf(LT),LT);
         If S<>''Then InsFile(Q.Handle,S);
        End;
        tdChar:Begin
         If FieldRec^[CurrPos].Len=0Then
          _SetRec(Q.Handle,SizeOf(Char),S[1])
         Else
          _SetRec(Q.Handle,FieldRec^[CurrPos].Len,S)
        End;
        tdVarChar:_SetRec(Q.Handle,Length(S)+1,S);
       End;
      End
       Else
      If Q.PC^[Q.ReadX]='#'Then Break { Remarque d'Oracle commence par '#' }
                           Else Inc(Q.ReadX);
      ',':If(Pos=pInsertValue)Then Begin
       Inc(CurrPos);
       Inc(Q.ReadX);
      End
       Else
      Begin
       Inc(NumFieldRec);
       PosLine:=lNone;
       Inc(Q.ReadX);
      End;
      '-','0'..'9':Begin
       S:='';
       If(FieldRec^[CurrPos].TypeDef)in[tdFloat,tdNumeric]Then Begin
        While Q.PC^[Q.ReadX]in['0'..'9','.']do Begin
         IncStr(S,Q.PC^[Q.ReadX]);
         Inc(Q.ReadX);
        End;
       End
        Else
       If(Q.PC^[Q.ReadX]='0')and(Q.PC^[Q.ReadX+1]in['x','X'])Then Begin
        Inc(Q.ReadX,2);
        While Q.PC^[Q.ReadX]in['0'..'9','A'..'Z','a'..'z']do Begin
         IncStr(S,Q.PC^[Q.ReadX]);
         Inc(Q.ReadX);
        End;
        BT:=HexStrToInt(S);
       End
        Else
       Begin
        If Q.PC^[Q.ReadX]='-'Then Begin
         IncStr(S,Q.PC^[Q.ReadX]);
         Inc(Q.ReadX);
        End;
        While Q.PC^[Q.ReadX]in['0'..'9']do Begin
         IncStr(S,Q.PC^[Q.ReadX]);
         Inc(Q.ReadX);
        End;
        LT:=StrToInt(S);
        BT:=LT;
       End;
       If(Pos=pInsertValue)Then Begin
        Case(FieldRec^[CurrPos].TypeDef)of
         tdBoolean,tdByte:_SetRec(Q.Handle,SizeOf(Byte),BT);
         tdSmallInt,tdWord:_SetRec(Q.Handle,SizeOf(Word),BT);
         tdInteger:Begin
          _SetRec(Q.Handle,SizeOf(LongInt),LT);
         End;
         tdFloat:Begin
          R:=StrToReal(S);
          _SetRec(Q.Handle,SizeOf(Real),R);
         End;
         tdNumeric:Begin
          S:=Spc(FieldRec^[CurrPos].Len-Length(S))+S;
          _Left(S,FieldRec^[CurrPos].Len);
          _SetRec(Q.Handle,Length(S),S[1]);
         End;
        End;
       End
        Else
       If OpenC=2Then Begin
        Case(FieldRec^[NumFieldRec].TypeDef)of
         tdChar,tdVarChar:FieldRec^[NumFieldRec].Len:=BT+1;
        End;
       End;
      End;
      'A'..'Z','a'..'z':Begin
       S:=PXtrkWord(Q.ReadX,Q.PC);
       {If S='DEBUG'Then Begin
        S:=S;
       End;}
       Case(Pos)of
        pTable:Begin
         If OpenC=0Then Q.RealName:=S
          Else
         Begin
          Case(PosLine)of
           lNone:Begin
            FieldRec^[NumFieldRec].Title:=Str2PChr(S);
            PosLine:=lName;
           End;
           lName:Begin
            Size:=0;BT:=tdNone;
            Repeat
             S:=StrUp(S);
             If S='BLOB'Then BT:=tdBlob
              Else
             If S='BOOLEAN'Then Begin
              BT:=tdBoolean;
              Size:=SizeOf(Boolean);
             End
              Else
             If S='BYTE'Then Begin
              BT:=tdByte;
              Size:=SizeOf(Byte);
             End
              Else
             If S='CHAR'Then Begin
              BT:=tdChar;
              Size:=SizeOf(Char);
             End
              Else
             If S='DATE'Then Begin
              BT:=tdDate;
              Size:=SizeOf(Comp);
             End
              Else
             If S='FLOAT'Then Begin
              BT:=tdFloat;
              Size:=SizeOf(Real);
             End
              Else
             If S='DOUBLE'Then BT:=tdDouble Else
             If S='NUMERIC'Then Begin
              BT:=tdNumeric;
              If Q.PC^[Q.ReadX]='('Then Begin
               Inc(Q.ReadX);
               S:='';
               While Q.PC^[Q.ReadX]in['0'..'9']do Begin
                IncStr(S,Q.PC^[Q.ReadX]);
                Inc(Q.ReadX);
               End;
               If S<>''Then FieldRec^[NumFieldRec].Len:=StrToInt(S);
               If Q.PC^[Q.ReadX]=','Then Begin
                Inc(Q.ReadX);
                S:='';
                While Q.PC^[Q.ReadX]in['0'..'9']do Begin
                 IncStr(S,Q.PC^[Q.ReadX]);
                 Inc(Q.ReadX);
                End;
                If S<>''Then FieldRec^[NumFieldRec].Decimal:=StrToInt(S);
               End;
               If Q.PC^[Q.ReadX]<>')'Then DBPushErr(Q,CloseParExpected)
                                     Else Inc(Q.ReadX);
               Size:=FieldRec^[NumFieldRec].Len;
              End;
             End
              Else
             If S='INTEGER'Then Begin
              BT:=tdInteger;
              Size:=SizeOf(LongInt);
             End
              Else
             If S='SMALLINT'Then Begin
              BT:=tdSmallInt;
              Size:=SizeOf(Integer);
             End
              Else
             If S='VARCHAR'Then Begin
              BT:=tdVarChar;
              Size:=128;
             End
              Else
             If S='WORD'Then Begin
              BT:=tdWord;
              Size:=SizeOf(Word);
              FieldRec^[NumFieldRec].Len:=Size;
             End
              Else
             Break;
             FieldRec^[NumFieldRec].TypeDef:=BT;
            Until True;
            PosLine:=lType;
           End;
           lType:Begin
            S:=StrUp(S);
            If S='UNIQUE'Then FieldRec^[NumFieldRec].Unique:=True Else
            If S='PRIMARY'Then Begin
             FieldRec^[NumFieldRec].PrimaryKey:=True;
             PosLine:=lPrimary;
            End
             Else
            If S='NOT'Then Begin
             FieldRec^[NumFieldRec].NotNull:=True;
             PosLine:=lNot;
            End;
           End;
           lPrimary:Begin
            PosLine:=lType;
           End;
           lNot:Begin
            PosLine:=lType;
           End;
          End;
         End;
        End;
        pInsertValue:Begin
         S:=StrUp(S);
         If(S='TRUE')or(S='YES')or(S='YA')Then Begin
          BT:=1;
          _SetRec(Q.Handle,SizeOf(Byte),BT);
         End
          Else
         If(S='FALSE')or(S='NO')Then Begin
          BT:=0;
          _SetRec(Q.Handle,SizeOf(Byte),BT);
         End
          Else
         If(S='NIL')or(S='NULL')Then Begin
          BT:=$FF;
          _SetRec(Q.Handle,SizeOf(Byte),BT);
         End;
        End;
        Else Begin
         S:=StrUp(S);
         If S='CREATE'Then Begin
          Created:=True;
          Pos:=pCreate;
         End
          Else
         If S='TABLE'Then Begin
          If(Pos=pCreate)Then Begin
           Q.Attribut:=[];
           Pos:=pTable;
           Q.CurrLine:=0;
          End;
         End
          Else
         If S='ASCENDING'Then Begin
          Q.Attribut:=Q.Attribut+[dsSorted,dsAscending]
         End
          Else
         If S='DESCENDING'Then Include(Q.Attribut,dsSorted)Else
         If S='INDEX'Then Begin
          If(Pos=pCreate)Then Begin
           Pos:=pCreateIndex;
            { Cr‚er seulement une table d'index lorsque la taille des
              enregistrements est variable }
           If(dsRelative)in(Q.Attribut)Then
            Q.Attribut:=Q.Attribut+[dsIndex,dsEnd];
          End
           Else
          Begin
           DBPushErr(Q,SyntaxError);
           DBCreateWithSQL:=False;
          End;
         End
          Else
         If S='INSERT'Then Begin
          Pos:=pInsert;
         End
          Else
         If S='INTO'Then Pos:=pInsertInto Else
         If S='VALUES'Then Begin
          Pos:=pInsertValue;
          CurrPos:=0;
         End
          Else
         If(@Q.OnExternCommand<>NIL)Then Begin
          Q.OnExternCommand(Q,Q.OnExternCommandContext^,S);
         End;
        End;
       End
      End;
      Else If Q.PC^[Q.ReadX]=#0Then Break
       Else
      Begin
       If Not(Q.PC^[Q.ReadX]in[#9,' '])Then Begin
        DBPushErr(Q,SyntaxError);
        DBCreateWithSQL:=False;
       End;
       Inc(Q.ReadX);
      End;
     End;
    End;
   End;
   DBPushErr(Q,0);
  End;
BreakAll:
  If NumFieldRec>0Then Begin
   Q.FieldRec.Num:=NumFieldRec;
   If(Q.FieldRec.Buffer=NIL)Then Begin
    Q.FieldRec.Buffer:=MemNew(Q.FieldRec.Num*SizeOf(FieldDataBaseRec));
    If(Q.FieldRec.Buffer<>NIL)Then Begin
     MoveLeft(FieldRec^,Q.FieldRec.Buffer^,Q.FieldRec.Num*SizeOf(FieldDataBaseRec));
    End;
   End;
  End;
  If(Handle<>errHdl)Then Begin
   FreeMemory(Q.PC,4096);
  End;
  FreeMemory(FieldRec,SizeFieldRec);
  If(Created)Then Begin
   If(Pos)in[pCreate,pTable]Then DBCreate(Q);
   If Q.Attribut<>[]Then DBUpdateAttribut(Q);
   If(dsIndex)in(Q.Attribut)Then DBCreateIndex(Q)Else
   If(dsServer)in(Q.Option)Then Begin
    If(Q.Directory<>NIL)Then Begin
     LT:=DBNumRec(Q);
     If Q.SizeRec<>0Then Begin
      LT:=LongInt(Q.CurrLine)*LongInt(Q.SizeRec);
      Q.SizeRec:=0;
      Inc(LT,LongInt(SizeOf(DataBaseHeader))+
             LongInt(Q.FieldRec.Num)*SizeOf(FieldDataBaseRec));
      DBUpdateSizeCurrEntry(Q,LT);
     End;
    End;
   End;
  End;
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                      Fonction DBCreateWithIndex                    Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: DataSet
 Portabilit‚:  Global


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de cr‚er une table de base de donn‚es … l'aide
 de l'index d'un ressource de la bibliothŠque sp‚cifi‚ par ®Name¯.
}

Function DBCreateWithIndex(Var Q:DataSet;Const Name:String;Index:Word):Boolean;
Var
 Size:Word;
 Ptr:^TChar;
 Str:String;
 I:Word;
 L:ArrayList;
Begin
 Ptr:=AllocFunc(Index,Name,Size);
 If(Ptr=NIL)Then DBCreateWithIndex:=False
  Else
 Begin
  ALInit(L);
  Str:='';
  For I:=0to Size-1do Begin
   If Ptr^[I]=#0Then Begin
    ALAddStr(L,Str);
    Str:='';
   End
    Else
   IncStr(Str,Ptr^[I]);
  End;
  FreeMemory(Ptr,Size);
  DBCreateWithSQL(Q,L,errHdl);
  DBFirst(Q);
  ALDone(L);
  DBCreateWithIndex:=True;
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                    Fonction DBCreateWithAppIndex                   Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: DataSet
 Portabilit‚:  Global


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de cr‚er une table de base de donn‚es … l'aide
 de l'index d'un ressource de la bibliothŠque ®APP7ILES¯.
}

Function DBCreateWithAppIndex(Var Q:DataSet;Index:Word):Boolean;Begin
 DBCreateWithAppIndex:=DBCreateWithIndex(Q,'APP7ILES.*',Index);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                      Proc‚dure DBCreateServer                     Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: DataSet
 Portabilit‚:  Global


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de cr‚er un nouvelle base de donn‚es serveur.
}

Procedure DBCreateServer(Var Q:DataSet);
Label CreateTable;
Var
 Header:DataBaseServerHeader;
 L:ArrayList;
Begin
 If(Q.Handle<>errHdl)Then Goto CreateTable;
 FillClr(Header,SizeOf(Header));
 Header.TypeASCII:='Server de base de donn‚es MG'#26;
 MoveLeft(Header.TypeASCII[1],Header.TypeASCII,SizeOf(Header.TypeASCII)-1);
 Header.Sign:='ServerDbMalte';
 Header.RealName:=Path2Name(Q.FileName);
 Header.Attribut:=[dsIntel,dsFatDB];
 Header.PosUserTable:=0;
 Header.PosFAT:=SizeOf(Header);
 Q.Handle:=FileCreateAndBackup(Q.FileName);
 If(Q.Handle<>errHdl)Then Begin
  _SetAbsRec(Q.Handle,0,SizeOf(Header),Header);
  Q.StartPos:=SizeOf(Header);
CreateTable:
  ALInit(L);
  ALAddStr(L,'CREATE TABLE Repertoire (');
  ALAddStr(L, 'PosDebut     INTEGER,');
  ALAddStr(L, 'Taille       INTEGER,');
  ALAddStr(L, 'Priorite     BYTE,');
  ALAddStr(L, 'Attribut     WORD,');
  ALAddStr(L, 'Creation     DATE,');
  ALAddStr(L, 'Modification DATE,');
  ALAddStr(L, 'NomServeur   VARCHAR');
  ALAddStr(L,');');
  DBCreateWithSQL(Q,L,errHdl);
  DBFirst(Q);
  ALDone(L);
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                    Fonction DBExportedOneFileDataBase                Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: DataSet
 Portabilit‚:  Global


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de sauvegarder en fichier une table d'une base de
 donn‚es serveurs.
}

Function DBExportedOneFileDataBase(Var Q:DataSet;Const Name,Dest:String):Boolean;
Var
 Handle:Hdl;
 Header:DataBaseServerHeader;
 StartPos:LongInt; { Position de d‚part au commence la base de donn‚es interne }
 Length:LongInt;   { Taille de la base de donn‚es interne }
 Buffer:Array[0..2047]of Byte; { Tampon de transfert de donn‚es }
 Data:DataBaseFileEntry Absolute Buffer;
 NM:Word;
 I,ND,M:LongInt;
Begin
 DBExportedOneFileDataBase:=False;
 Handle:=FileCreateAndBackup(Dest);
 If(Handle<>errHdl)Then Begin
  _GetAbsRec(Q.Handle,0,SizeOf(Header),Header);
  StartPos:=Header.PosFAT;
  If Name='Repertoire'Then Length:=FileSize(Q.Handle)-StartPos
   Else
  Begin
   DBLoad(Q);
   If DBLocateAbs(Q,6,Name,[])Then Begin
    StartPos:=Data.StartPos;
    Length:=Data.Size;
   End
    Else
   Begin
    StartPos:=0;
    Length:=0;
   End;
  End;
  If Length>0Then Begin
   ND:=Length div SizeOf(Buffer);NM:=Length mod SizeOf(Buffer);M:=0;
   For I:=0to ND-1do Begin
    _GetAbsRec(Q.Handle,StartPos,SizeOf(Buffer),Buffer);
    _SetAbsRec(Handle,M,SizeOf(Buffer),Buffer);
    Inc(M,LongInt(SizeOf(Buffer)));
    Inc(StartPos,LongInt(SizeOf(Buffer)));
   End;
   If NM>0Then Begin
    _GetAbsRec(Q.Handle,StartPos,NM,Buffer);
    _SetAbsRec(Handle,M,NM,Buffer);
   End;
  End;
  FileClose(Handle);
  DBExportedOneFileDataBase:=True;
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                     Fonction DBFindMaxTable                      Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: DataSet
 Portabilit‚:  Global


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction retourne la position maximal utiliser par la base de
 donn‚es global et donc o— devrait normalement pouvoir ˆtre stock‚ la
 prochaine Base de donn‚es ou R‚pertoire.
}

Function DBFindMaxTable(Var Q:DataSet):LongInt;
Var
 Data:DataBaseFileEntry;
 Pos:LongInt;
 CurrPos:LongInt;
Begin
 Pos:=0;
 If(Q.Directory<>NIL)Then Begin
  CurrPos:=Q.Directory^.CurrPos;
  DBFirst(Q.Directory^);
  While Not DBEOF(Q.Directory^)do Begin
   DBReadRec(Q.Directory^,Data);
   If Q.Directory^.CurrPos=0Then Break;
   If(Data.StartPos+Data.Size>Pos)Then Pos:=Data.StartPos+Data.Size;
  End;
  Q.Directory^.CurrPos:=CurrPos;
 End;
 DBFindMaxTable:=Pos;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                       Fonction DBWriteEntry                            Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: DataSet
 Portabilit‚:  Local


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet d'‚crire une entr‚e d'une base de donn‚es serveur.
}

Procedure DBWriteEntry(Var Q:DataSet;Const ServerName:String);Near;
Var
 Data:DataBaseFileEntry;
 Header:DataBaseServerHeader;
Begin
 If(Q.Directory<>NIL)Then Begin
  _GetAbsRec(Q.Handle,0,SizeOf(Header),Header);
  FillClr(Data,SizeOf(Data));
  Data.StartPos:=DBFindMaxTable(Q);
  If Data.StartPos=0Then Data.StartPos:=Header.PosFAT;
  Data.Attribut:=faArchive;
  Data.FileName:=ServerName;
  DBWriteRec(Q.Directory^,Data);
  Q.StartPos:=Data.StartPos;
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                  Fonction DBCreateEntryOnServer                Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: DataSet
 Portabilit‚:  Global


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de cr‚er les entr‚es d'une base de donn‚es
 serveur.
}

Procedure DBCreateEntryOnServer(Var Q:DataSet;Const ServerName:String);
Var
 DirectoryName:String; { Nom du fichier temporaire de r‚pertoire }
Begin
{ If(Q.Directory<>NIL)Then DBUpdateDirectory(Q);}
 DirectoryName:=Path2NoExt(Q.FileName)+'.$$$';
 DBExportedOneFileDataBase(Q,'Repertoire',DirectoryName);
 DBUnloadField(Q.FieldRec);
 If(Q.Directory=NIL)Then Begin
  Q.Directory:=MemAlloc(SizeOf(DataSet));
  If(Q.Directory<>NIL)Then Begin
   DBInit(Q.Directory^,DirectoryName);
   DBEnd(Q.Directory^);
  End;
 End;
 If(Q.Directory<>NIL)Then Begin
  Q.CurrPosEntryOnDir:=Q.Directory^.CurrPos;
  DBWriteEntry(Q,ServerName);
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                     Fonction DBUpdateDirectory                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: DataSet
 Portabilit‚:  Global


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette routine permet d'‚crire la base de donn‚es de r‚pertoire … la fin
 du fichier global de base de donn‚es.
}

Procedure DBUpdateDirectory(Var Q:DataSet);
Var
 Header:DataBaseServerHeader;
 Data:DataBaseFileEntry;
Begin
 If(Q.Directory<>NIL)Then Begin
  DBUnloadField(Q.FieldRec);
  _GetAbsRec(Q.Handle,0,SizeOf(Header),Header);
  Header.PosFAT:=DBFindMaxTable(Q);
  _SetAbsRec(Q.Handle,0,SizeOf(Header),Header);
  Q.StartPos:=Header.PosFAT;
  DBCreateServer(Q);
  DBFirst(Q.Directory^);
  Repeat
   DBReadRec(Q.Directory^,Data);
   DBWriteRec(Q,Data);
  Until DBEOF(Q.Directory^);
  DBDone(Q.Directory^);
  DeleteFile(Q.Directory^.FileName);
  FreeMemory(Q.Directory,SizeOf(DataSet));
  Q.Directory:=NIL;
 End;
End;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
END.