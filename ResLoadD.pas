{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                                                                         Û
 ³        Malte Genesis/Ressource de chargement de Base de donn‚es         Û
 ³                                                                         Û
 ³                 dition AdŠle pour Mode R‚el/IV - Version 1.1           Û
 ³                              2001/01/01                                 Û
 ³                                                                         Û
 ³          Tous droits r‚serv‚s par les Chevaliers de Malte (C)           Û
 ³                                                                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Nom du programmeur
 ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ

  Sylvain Maltais


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette unit‚ offre des chargement des bases de donn‚es inclue dans
 l'ensemble ®Malte Genesis V: Alias AdŠle¯.
}


{$I DEF.INC}

Unit ResLoadD;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                                  INTERFACE
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Uses ResTex;

Procedure DBLoad(Var Q:DataSet);
Procedure DBLoadIndex(Var Q:DataSet);
Function  DBGetExternFileNameDataBase(Var Q:DataSet):String;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                               IMPLEMENTATION
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Uses
 SysTex,Memories,Systems,ResServD;

Function DBGetExternFileNameDataBase(Var Q:DataSet):String;
Var
 ResultValue:String;
 Header:DataBaseHeader; { Structure de l'entˆte d'un fichier de base de donn‚e}
Begin
 _GetAbsRec(Q.Handle,Q.StartPos,SizeOf(Header),Header);
 If Header.PosFileNameDataBaseExtern=0Then DBGetExternFileNameDataBase:=''
  Else
 Begin
  _GetAbsRec(Q.Handle,Header.PosFileNameDataBaseExtern,SizeOf(ResultValue),ResultValue);
  DBGetExternFileNameDataBase:=ResultValue;
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                      Proc‚dure DBLoadIndex                     Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: DataSet
 Portabilit‚:  Local


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de charger l'index d'une table en m‚moire.
}

Procedure DBLoadIndex(Var Q:DataSet);
Var
 Header:DataBaseHeader; { Structure de l'entˆte d'un fichier de base de donn‚e}
Begin
 _GetAbsRec(Q.Handle,Q.StartPos,SizeOf(Header),Header);
 If(dsIndex)in(Header.Attribut)Then Begin
  Q.EndPos:=Header.PosIndex;
  FreeMemory(Q.Index.Long,Q.SizeIndex);
  If Header.SizeIndex=0Then Q.SizeIndex:=Q.FileSize-Header.PosIndex
                       Else Q.SizeIndex:=Header.SizeIndex;
  Q.Index.Long:=MemAlloc(Q.SizeIndex);
  If(Q.Index.Long<>NIL)Then Begin
   _GetAbsRec(Q.Handle,Header.PosIndex,Q.SizeIndex,Q.Index.Long^);
  End;
 End
  Else
 Q.EndPos:=Q.FileSize;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Proc‚dure DBLoad                          Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: DataSet
 Portabilit‚:  Local


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de charger les entˆtes d'une table en m‚moire.
}

Procedure DBLoad(Var Q:DataSet);
Var
 Header:DataBaseHeader;                       { Structure de l'entˆte d'un fichier de base de donn‚es}
 HDBase:DBaseIIIFileHeaderRec Absolute Header;{ Structure de l'entˆte d'un fichier DBase }
 FieldDBase:DBaseIIIFieldRec;                 { Structure d'un champ de DBase }
 PBuf:^TByte;                                 { Tampon associ‚e }
 PWord:^Word;                                 { Pointeur de mot }
 I,P:Word;                                    { Variable compteur de champ, position }
 FP:LongInt;                                  { Position dans le fichier }
Begin
 If(Q.Handle=errHdl)Then Begin
  Q.Handle:=FileOpen(Q.FileName,fmDef);
  If(Q.Handle=errHdl)Then Begin
   If FileExist(Q.FileName)Then { Peut-ˆtre une restriction en lecture seulement... }
    Q.Handle:=FileOpen(Q.FileName,fmRead)
   Else
    Q.Handle:=OpenSearchPathNDos(MaltePath,Path2NoDir(Q.FileName),fmDef);
  End;
 End;
 If(Q.Handle<>errHdl)Then Begin
  Q.FileSize:=FileSize(Q.Handle);
  _GetAbsRec(Q.Handle,Q.StartPos,SizeOf(Header),Header);
  Q.Origin:=0;
  If(Header.Sign='ServerDbMalte')Then Begin
   { Fichier serveur de base de donn‚es? }
   Include(Q.Option,dsServer);
  End
   Else
  If(Header.Sign='DataBaseMalte')and(Header.NumField>0)and
    (Header.SizeTotalField<65520)Then Begin
   If(dsIndex)in(Header.Attribut)Then Q.EndPos:=Header.PosIndex
                                 Else Q.EndPos:=Q.FileSize;
   Q.RealName:=Header.RealName;
   If(Q.FieldRec.Buffer<>NIL)Then DBUnloadField(Q.FieldRec);
   Q.FieldRec.Num:=Header.NumField;
   Q.FieldRec.Buffer:=MemNew(Q.FieldRec.Num*SizeOf(FieldDataBaseRec));
   Q.Attribut:=Header.Attribut;
   If(dsExternData)in(Q.Attribut)Then Begin
    Q.HandleExtern:=FileOpen(DBGetExternFileNameDataBase(Q),fmRead);
    Q.StartRec:=Header.OffsetFilePosExtern;
   End;
   If(Q.FieldRec.Buffer<>NIL)Then Begin
    PBuf:=MemAlloc(Header.SizeTotalField);
    If(PBuf<>NIL)Then Begin
     _GetAbsRec(Q.Handle,Q.StartPos+SizeOf(Header),Header.SizeTotalField,PBuf^);
     P:=0;
     For I:=0to Header.NumField-1do Begin
      PWord:=@PBuf^[P];
      If PWord^=0Then Break;
      MoveLeft(PBuf^[P+2],Q.FieldRec.Buffer^[I],7);
      Q.FieldRec.Buffer^[I].Title:=StrNew(@PBuf^[P+9]);
      Inc(P,PWord^);
     End;
     FreeMemory(PBuf,Header.SizeTotalField);
    End;
   End;
   DBLoadIndex(Q);
  End
   Else
  If HDBase.HeadType=$3Then Begin { Fichier DBase III+ ? }
   If(Q.FieldRec.Buffer<>NIL)Then DBUnloadField(Q.FieldRec);
   Q.Origin:=HDBase.HeadType;
   Q.SizeRec:=HDBase.RecordSize;
   FP:=Q.StartPos+SizeOf(DBaseIIIFileHeaderRec);
   Q.FieldRec.Num:=0;
   {Q.NumRec:=FieldDBase.RecordCount;}
   Repeat
    _GetAbsRec(Q.Handle,FP,SizeOf(FieldDBase),FieldDBase);
    Inc(FP,SizeOf(FieldDBase));
    Inc(Q.FieldRec.Num);
    If(FP>Q.FileSize)Then Break;
   Until FieldDBase.FieldName[1]=#13;
   Dec(Q.FieldRec.Num);
   If HDBase.HeaderLength=0Then Q.StartRec:=FP-SizeOf(FieldDBase)+2
                           Else Q.StartRec:=HDBase.HeaderLength+1;
   FP:=Q.StartPos+SizeOf(DBaseIIIFileHeaderRec);
   Q.FieldRec.Buffer:=MemNew(Q.FieldRec.Num*SizeOf(FieldDataBaseRec));
   For I:=0to Q.FieldRec.Num-1do Begin
    _GetAbsRec(Q.Handle,FP,SizeOf(FieldDBase),FieldDBase);
    Repeat
     Case(FieldDBase.FieldType)of
      'C':P:=tdDirectChar;
      'N':Begin
       P:=tdNumeric;
       Q.FieldRec.Buffer^[I].Decimal:=FieldDBase.Dec;
       Break;
      End;
      'I':P:=tdSmallInt;
      'L':P:=tdByte;
     End;
     Q.FieldRec.Buffer^[I].NotNull:=FieldDBase.Dec and$02=0;
    Until True;
    Q.FieldRec.Buffer^[I].Len:=FieldDBase.Width;
    Q.FieldRec.Buffer^[I].TypeDef:=P;
    Q.FieldRec.Buffer^[I].Title:=StrNew(@FieldDBase.FieldName);
    Inc(FP,SizeOf(FieldDBase));
   End;
  End
   Else
  FileClose(Q.Handle);
 End;
End;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
END.