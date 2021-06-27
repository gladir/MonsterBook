{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                                                                         Û
 ³           Malte Genesis/Ressource de service de Base de donn‚es         Û
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

  Cette unit‚ offre des services de gestion des bases de donn‚es inclue
 dans l'ensemble ®Malte Genesis V: Alias AdŠle¯.
}

{$I DEF.INC}

Unit ResServD;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                                   INTERFACE
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Uses Systex,ResTex;

Function  DBInit(Var Q:DataSet;Const FileName:String):Boolean;
Procedure DBInitServer(Var Q:DataSet;Const FileName:String);
Procedure DBLoadTableIndex(Var Q:DataSet);
Procedure DBLogin(Var Q:DataSet;Const UserName,PassWord:String);
Function  DBOpenServerName(Var Q:DataSet;Const ServerName:String):Boolean;
Procedure DBAddStrByte(Var Q:DataSet;Var R:ArrayList);
Function  DBCopyToMemory(Var Q:DataSet;Var Target:DataSetInMemory):Boolean;
Procedure DBDispose(Var Q:DataSetInMemory);
Procedure DBReadRec(Var Q:DataSet;Var Buffer);
Procedure DBGotoColumnAbs(Var Q:DataSet;Column:Word;Var Buffer:Pointer);
Procedure DBGotoColumn(Var Q:DataSet;Const Column:String;Var Buffer:Pointer);
Procedure DBWriteRec(Var Q:DataSet;Const Buffer);
Procedure DBDelRec(Var Q:DataSet);
Procedure DBFirst(Var Q:DataSet);
Procedure DBEnd(Var Q:DataSet);
Procedure DBPrev(Var Q:DataSet);
Function  DBNext(Var Q:DataSet):Boolean;
Procedure DBMoveBy(Var Q:DataSet;Line:LongInt);
Function  DBMoveTo(Var Q:DataSet;Line:LongInt):Boolean;
Function  DBNumRec(Var Q:DataSet):LongInt;
Procedure DBSetSizeRec(Var Q:DataSet);
Function  DBBOF(Var Q:DataSet):Boolean;
Function  DBEOF(Var Q:DataSet):Boolean;
Function  DBLocateAbs(Var Q:DataSet;Column:Word;Const Search;Option:SearchOption):Boolean;
Function  DBLocateAbsIM(Var Q:DataSetInMemory;Column:Word;Const Search;Option:SearchOption):Boolean;
Function  DBLocate(Var Q:DataSet;Column:PChar;Const Search):Boolean;
Procedure DBUnloadField(Var Q:FieldRecDef);
Procedure DBDone(Var Q:DataSet);
Procedure _DBGotoColumnAbs(Var Q:FieldRecDef;Column:Word;Var Buffer:Pointer);

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                                 IMPLEMENTATION
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Uses Memories,Systems,ResLoadD,ResSaveD;

Function DBGetReadHandle(Var Q:DataSet):Hdl;Near;Begin
 If(Q.HandleExtern<>errHdl)Then DBGetReadHandle:=Q.HandleExtern
                           Else DBGetReadHandle:=Q.Handle;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                   Fonction DBComputeSizeByBuffer               Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: DataSet
 Portabilit‚:  Local


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de calculer la taille d'un enregistrement …
 partir d'un tampon sp‚cifier.
}

Function DBComputeSizeByBuffer(Var Q:FieldRecDef;Const Buffer):Word;Near;
Var
 TL:^LongInt;
 TC:PChr Absolute TL;
 I:Integer;                    { Compteur de boucle pour les champs }
 Size:Word;                    { Taille de l'enregistrement }
 BufferByte:TByte Absolute Buffer;
 ResultValue:String;
Begin
 DBComputeSizeByBuffer:=0;
 Size:=0;
 For I:=0to Q.Num-1do Begin
  Case(Q.Buffer^[I].TypeDef)of
   tdBoolean,tdByte:Inc(Size,SizeOf(Byte));
   tdDirectChar,tdNumeric:Inc(Size,Q.Buffer^[I].Len);
   tdChar:If Q.Buffer^[I].Len=0Then Inc(Size)
          Else Inc(Size,Q.Buffer^[I].Len);
   tdVarChar:Inc(Size,BufferByte[Size]+1);
   tdBlob:Begin
    TL:=@BufferByte[Size];
    Inc(Size,TL^+SizeOf(LongInt));
   End;
   tdDate:Inc(Size,SizeOf(Comp));
   tdInteger:Inc(Size,SizeOf(LongInt));
   tdWord,tdSmallInt:Inc(Size,SizeOf(Word));
   tdFloat:Inc(Size,SizeOf(Real));
   tdVarCharRS:Begin
    TC:=@BufferByte[Size];
    ResultValue:=LoadStr(TC^,255);
    Inc(Size,Length(Left(ResultValue,Pos(#$1E,ResultValue)-1))+1);
   End;
   Else Break;
  End;
 End;
 DBComputeSizeByBuffer:=Size;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                       Fonction DBComputeSize                   Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: DataSet
 Portabilit‚:  Local


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de calculer la taille d'un enregistrement.
}

Function DBComputeSize(Var Q:DataSet):Word;Near;
Var
 Buffer:Array[0..4095]of Byte; { Tampon temporaire }
Begin
 If DBEOF(Q)Then DBComputeSize:=0
  Else
 Begin
  _GetAbsRec(DBGetReadHandle(Q),Q.CurrPos,SizeOf(Buffer),Buffer);
  DBComputeSize:=DBComputeSizeByBuffer(Q.FieldRec,Buffer);
 End
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                       Fonction DBSetSizeRec                    Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: DataSet
 Portabilit‚:  Local


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de mettre … jour la variable de taille
 d'enregistrement dans le cas d'un enregistrement de taille fixe.
}

Procedure DBSetSizeRec(Var Q:DataSet);
Var
 Buffer:Pointer;
Begin
 Buffer:=NIL;
 If Not((dsRelative)in(Q.Attribut))Then Begin
  Q.SizeRec:=DBComputeSizeByBuffer(Q.FieldRec,Buffer);
 End;
End;

Procedure _DBGotoColumnAbs(Var Q:FieldRecDef;Column:Word;Var Buffer:Pointer);
Var
 I:Integer;                    { Compteur de boucle pour les champs }
 Curr:PtrRec Absolute Buffer;  { Pointeur de tampon }
 BBuf:^TByte Absolute Buffer;
 LBuf:^TLong Absolute Buffer;
 Result:String;
Begin
 For I:=0to Column-1do Begin
  Case(Q.Buffer^[I].TypeDef)of
   tdBoolean,tdByte:Inc(Curr.Ofs,SizeOf(Byte));
   tdDirectChar,tdNumeric:Inc(Curr.Ofs,Q.Buffer^[I].Len);
   tdChar:If Q.Buffer^[I].Len=0Then Inc(Curr.Ofs)
          Else Inc(Curr.Ofs,Q.Buffer^[I].Len);
   tdVarChar:Inc(Curr.Ofs,BBuf^[0]+1);
   tdBlob:Inc(Curr.Ofs,LBuf^[0]+4);
   tdDate:Inc(Curr.Ofs,SizeOf(Comp));
   tdInteger:Inc(Curr.Ofs,SizeOf(LongInt));
   tdWord,tdSmallInt:Inc(Curr.Ofs,SizeOf(Word));
   tdFloat:Inc(Curr.Ofs,SizeOf(Real));
   tdVarCharRS:Begin
    Result:=LoadStr(BBuf^,255);
    Inc(Curr.Ofs,Length(Left(Result,Pos(#$1E,Result)-1))+1);
   End;
  End;
 End;
 If(Q.Buffer^[Column].TypeDef=tdBlob)and(LBuf^[0]=0)Then Buffer:=NIL;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                      Fonction DBGotoColumnAbs                  Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: DataSet
 Portabilit‚:  Global


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de positionner le pointeur sur la colonne
 d'enregistrement sp‚cifier.
}

Procedure DBGotoColumnAbs(Var Q:DataSet;Column:Word;Var Buffer:Pointer);Begin
 _DBGotoColumnAbs(Q.FieldRec,Column,Buffer);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Fonction DBInit                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: DataSet
 Portabilit‚:  Global


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet d'associ‚e … un fichier un table de base de
 donn‚es.
}

Function DBInit(Var Q:DataSet;Const FileName:String):Boolean;Begin
 FillClr(Q,SizeOf(DataSet));
 Q.Handle:=errHdl;
 Q.HandleExtern:=errHdl;
 Q.FileName:=FileName;
 DBLoad(Q);
 If(Q.Origin=0)and(Not((dsRelative)in(Q.Attribut)))Then Begin
  DBFirst(Q);
  Q.SizeRec:=DBComputeSize(Q);
 End;
 DBInit:=Q.Handle<>errHdl;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Fonction DBInitServer                 Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: DataSet
 Portabilit‚:  Global


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet d'initialiser et d'associ‚e … un fichier le
 serveur de base de donn‚es.
}

Procedure DBInitServer(Var Q:DataSet;Const FileName:String);Begin
 DBInit(Q,FileName);
 If(Q.Handle=errHdl)Then Begin
  Include(Q.Option,dsServer);
  DBCreateServer(Q);
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                            Fonction DBLogin                      Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: DataSet
 Portabilit‚:  Global


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de v‚rifier la validit‚ d'un mot de passe en
 fonction d'un usage pour le serveur de base de donn‚es.
}

Procedure DBLogin(Var Q:DataSet;Const UserName,PassWord:String);Begin
End;

Procedure DBLoadTableIndex(Var Q:DataSet);
Var
 Header:DataBaseServerHeader;
Begin
 _GetAbsRec(Q.Handle,0,SizeOf(Header),Header);
 Q.StartPos:=Header.PosFAT;
 Q.Attribut:=[dsRelative];
 DBLoad(Q);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                   Fonction DBOpenServerName               Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: DataSet
 Portabilit‚:  Global


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet d'ouvrir un serveur de base de donn‚es.
}

Function DBOpenServerName(Var Q:DataSet;Const ServerName:String):Boolean;
Var
{ Header:DataBaseServerHeader;}
 Data:DataBaseFileEntry;
Begin
 DBOpenServerName:=False;
 DBLoadTableIndex(Q);
{ _GetAbsRec(Q.Handle,0,SizeOf(Header),Header);
 Q.StartPos:=Header.PosFAT;
 Q.Attribut:=[dsRelative];
 DBLoad(Q);}
 If DBLocateAbs(Q,6,ServerName,[])Then Begin
  DBReadRec(Q,Data);
  Q.StartPos:=Data.StartPos;
  DBLoad(Q);
  DBOpenServerName:=True;
 End
  Else
 Begin
  DBCreateEntryOnServer(Q,ServerName);
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                      Fonction DBOpenServerName                 Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: DataSet
 Portabilit‚:  Global


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de lire un enregistrement dans la table de
 base de donn‚es.
}

Procedure DBReadRec(Var Q:DataSet;Var Buffer);
Label 1;
Var
 Size:LongInt;
 Handle:Hdl;
Begin
 If Not((dsRelative)in(Q.Attribut))Then Size:=Q.SizeRec
  Else
 Begin
  If(dsIndex)in(Q.Attribut)Then Begin
   If(Q.Index.Long=NIL)Then DBLoadIndex(Q);
   If(Q.Index.Long=NIL)Then Goto 1;
   If(dsBig)in(Q.Attribut)Then Begin
    Size:=Q.Index.Long^[Q.CurrLine+1]-Q.Index.Long^[Q.CurrLine];
    Q.CurrPos:=Q.Index.Long^[Q.CurrLine];
   End
    Else
   Begin
    Size:=LongInt(Q.Index.Word^[Q.CurrLine+1])-LongInt(Q.Index.Word^[Q.CurrLine]);
    Q.CurrPos:=LongInt(Q.Index.Word^[Q.CurrLine]);
   End;
  End
   Else
1:Size:=DBComputeSize(Q);
 End;
 If Size>0Then Begin
  If(Q.HandleExtern<>errHdl)Then Handle:=Q.HandleExtern
                            Else Handle:=Q.Handle;
  _GetAbsRec(Handle,Q.CurrPos,Size,Buffer);
 End;
 Inc(Q.CurrPos,LongInt(Size));
 Inc(Q.CurrLine);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Proc‚dure DBWriteRec                     Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: DataSet
 Portabilit‚:  Global


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet d'‚crire un enregistrement dans la table de
 base de donn‚es.
}

Procedure DBWriteRec(Var Q:DataSet;Const Buffer);
Var
 Size:Word;
Begin
 Size:=Q.SizeRec;
 If Size=0Then Size:=DBComputeSizeByBuffer(Q.FieldRec,Buffer);
 _SetAbsRec(Q.Handle,Q.CurrPos,Size,Buffer);
 Inc(Q.CurrPos,LongInt(Size));
 Inc(Q.CurrLine);
 If(Q.CurrPos>=Q.FileSize)Then Inc(Q.FileSize,LongInt(Size));
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                             Proc‚dure DBDelRec                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: DataSet
 Portabilit‚:  Global


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet d'effacer un enregistrement devenu inutile.
}

Procedure DBDelRec(Var Q:DataSet);Begin
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                              Proc‚dure DBFirst                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: DataSet
 Portabilit‚:  Global


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de passer imm‚diatement au premier enregistrement
 de la table de la base de donn‚es.
}

Procedure DBFirst(Var Q:DataSet);
Var
 Header:DataBaseHeader; { Entˆte de la base de donn‚es }
 Size:LongInt;
Begin
 _GetAbsRec(Q.Handle,Q.StartPos,SizeOf(Header),Header);
 Size:=FileSize(Q.Handle);
 If(Size>Q.FileSize)Then Q.FileSize:=Size;
 If Q.Origin=0Then Begin
  If(Q.HandleExtern<>errHdl)Then Begin
   Q.StartRec:=Header.OffsetFilePosExtern;
  End
   Else
  Q.StartRec:=Q.StartPos+SizeOf(DataBaseHeader)+Header.SizeTotalField;
 End;
 Q.CurrPos:=Q.StartRec;
 Q.CurrLine:=0;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                             Proc‚dure DBEnd                           Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: DataSet
 Portabilit‚:  Global


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de passer imm‚diatement au dernier enregistrement
 de la table de la base de donn‚es.
}

Procedure DBEnd(Var Q:DataSet);Begin
 If Q.FileSize=0Then Q.FileSize:=FileSize(Q.Handle);
 Q.CurrPos:=Q.FileSize;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                             Proc‚dure DBPrev                          Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: DataSet
 Portabilit‚:  Global


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de passer … l'enregistrement pr‚c‚dent de la
 table de la base de donn‚es.
}

Procedure DBPrev(Var Q:DataSet);Begin
 Dec(Q.CurrPos,LongInt(Q.SizeRec));
 Dec(Q.CurrLine);
 If(Q.CurrPos<Q.StartPos)Then Begin
  Q.CurrPos:=Q.StartPos;
  Q.CurrLine:=0;
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                             Proc‚dure DBNext                          Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: DataSet
 Portabilit‚:  Global


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de passer … l'enregistrement suivant de la table
 de la base de donn‚es.
}

Function DBNext(Var Q:DataSet):Boolean;
Var
 Size:Word;
Begin
 DBNext:=False;
 If((dsRelative)in(Q.Attribut))and(Not((dsIndex)in(Q.Attribut)))Then Begin
  Size:=DBComputeSize(Q);
  Inc(Q.CurrPos,LongInt(Size));
  If Size=0Then Exit;
 End
  Else
 Inc(Q.CurrPos,LongInt(Q.SizeRec));
 Inc(Q.CurrLine);
 DBNext:=True;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Proc‚dure DBMoveBy                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: DataSet
 Portabilit‚:  Global


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet d'effectuer un d‚placement relatif dans la table
 de la base de donn‚es.
}

Procedure DBMoveBy(Var Q:DataSet;Line:LongInt);Begin
 Inc(Q.CurrLine,LongInt(Line));
 If(dsIndex)in(Q.Attribut)Then Begin
  If(dsBig)in(Q.Attribut)Then Q.CurrPos:=Q.StartRec+Q.Index.Long^[Q.CurrLine]
                         Else Q.CurrPos:=Q.StartRec+Q.Index.Word^[Q.CurrLine];
 End
  Else
 Q.CurrPos:=Q.StartRec+LongInt(Q.SizeRec)*Q.CurrLine;
 Inc(Q.CurrPos,LongInt(SizeOf(DataBaseHeader)));
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                            Fonction DBMoveTo                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: DataSet
 Portabilit‚:  Global


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet d'effectuer un d‚placement absolue dans la table
 de la base de donn‚es.
}

Function DBMoveTo(Var Q:DataSet;Line:LongInt):Boolean;Begin
 If Q.StartRec=0Then DBFirst(Q);
 If Q.SizeRec=0Then DBSetSizeRec(Q);
 Q.CurrLine:=LongInt(Line);
 Q.CurrPos:=Q.StartRec;
 If(dsIndex)in(Q.Attribut)Then Begin
  If Q.CurrLine>=DBNumRec(Q)Then Begin
   Q.CurrPos:=Q.EndPos
  End
   Else
  Begin
   Q.CurrPos:=Q.StartPos;
   If(dsBig)in(Q.Attribut)Then Q.CurrPos:=Q.Index.Long^[Q.CurrLine]
                          Else Q.CurrPos:=Q.Index.Word^[Q.CurrLine];
  End;
 End
  Else
 Inc(Q.CurrPos,LongInt(Q.SizeRec)*Q.CurrLine);
 DBMoveTo:=Q.FileSize>Q.CurrPos;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Fonction DBBOF                           Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: DataSet
 Portabilit‚:  Global


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet d'indiquer si le pointeur est situ‚ au d‚but de
 la table de donn‚es.
}

Function DBBOF(Var Q:DataSet):Boolean;Begin
 DBBof:=Q.StartPos=Q.CurrPos;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Fonction DBEOF                           Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: DataSet
 Portabilit‚:  Global


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet d'indiquer si le pointeur est situ‚ … la fin de
 la table de donn‚es.
}

Function DBEOF(Var Q:DataSet):Boolean;Begin
 If(dsIndex)in(Q.Attribut)Then DBEof:=Q.CurrPos>=Q.EndPos Else
 If(Q.HandleExtern<>errHdl)Then DBEof:=Q.CurrPos>=FileSize(Q.HandleExtern)
                           Else DBEof:=Q.CurrPos>=Q.FileSize;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Fonction DBCompData                      Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: DataSet


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de comparer des informations en fonction de leur
 type respectif.
}

Function DBCompData(TypeDef:Byte;Const Ptr,Search;Option:SearchOption):ShortInt;
Var
 SearchString:String Absolute Search;
 SearchInteger:Integer Absolute Search;
 SearchWord:Word Absolute Search;
 SearchLongInt:LongInt Absolute Search;
 SearchReal:Real Absolute Search;
 SearchByte:Byte Absolute Search;
 SearchBoolean:Boolean Absolute Search;
 SearchComp:Comp Absolute Search;
 PBoolean:^Boolean Absolute Ptr;
 PByte:^Byte Absolute Ptr;
 PInt:^Integer Absolute Ptr;
 PWord:^Word Absolute Ptr;
 PLongInt:^LongInt Absolute Ptr;
 PReal:^Real Absolute Ptr;
 PStr:^String Absolute Ptr;
 PComp:^Comp Absolute Ptr;
 UStr,SStr:String;
Begin
 DBCompData:=0;
 Case(TypeDef)of
  tdByte,tdBoolean:If(SearchByte=PByte^)Then Exit Else
  If(SearchByte>PByte^)Then DBCompData:=-1
                       Else DBCompData:=1;
  tdVarChar,tdChar,tdDirectChar,tdNumeric:Begin
   If((soCharCompare)in(Option))Then Begin
    If Compare(Search,PStr^[1],Length(PStr^))Then Exit
     Else
    If LoadStr(Search,255)>PStr^Then DBCompData:=-1
                                Else DBCompData:=1;
   End
    Else
   If((soNotStrict)in(Option))and(CmpLeft(PStr^,SearchString))Then Exit Else
   If(soNoCaseSensitive)in(Option)Then Begin
    UStr:=StrUp(PStr^);
    SStr:=StrUp(SearchString);
    If(SStr=UStr)Then Exit Else
    If(SStr>UStr)Then DBCompData:=-1
                 Else DBCompData:=1;
   End
    Else
   If(SearchString=PStr^)Then Exit Else
   If(SearchString>PStr^)Then DBCompData:=-1
                         Else DBCompData:=1;
  End;
  tdFloat:If(SearchReal=PReal^)Then Exit Else
  If(SearchReal>PReal^)Then DBCompData:=-1
                       Else DBCompData:=1;
{  tdDate:If(SearchComp=PComp^)Then Exit Else
   If(SearchComp>PComp)Then DBCompData:=-1
                       Else DBCompDate:=1;}
  tdInteger,tdDate:If(SearchLongInt=PLongInt^)Then Exit Else
  If(SearchLongInt>PLongInt^)Then DBCompData:=-1
                             Else DBCompData:=1;
  tdWord:If(SearchWord=PWord^)Then Exit Else
  If(SearchWord>PWord^)Then DBCompData:=-1
                       Else DBCompData:=1;
  tdSmallInt:If(SearchInteger=PInt^)Then Exit Else
  If(SearchInteger>PInt^)Then DBCompData:=-1
                         Else DBCompData:=1;
  Else DBCompData:=-2;
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Fonction DBNumRec                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: DataSet
 Portabilit‚:  Global


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de connaŒtre le nombre d'enregistrement dans la
 table de base de donn‚es de taille fixe.
}

Function DBNumRec(Var Q:DataSet):LongInt;
Var
 Size:Word; { Taille d'un enregistrement }
Begin
 If Q.SizeRec=0Then Begin
  If(dsRelative)in(Q.Attribut)Then Size:=4096
   Else
  Begin
   DBSetSizeRec(Q);
   Size:=Q.SizeRec;
  End;
 End
  Else
 Size:=Q.SizeRec;
 If(dsRelative)in(Q.Attribut)Then Begin
  If(dsIndex)in(Q.Attribut)Then Begin
   If(dsBig)in(Q.Attribut)Then DBNumRec:=Q.SizeIndex shr 2
                          Else DBNumRec:=Q.SizeIndex shr 1;
  End
   Else
  DBNumRec:=$FFFF
 End
  Else
 Begin
  If Size=0Then DBNumRec:=0
   Else
  Begin
   If(Q.HandleExtern<>errHdl)Then Begin
    DBNumRec:=(FileSize(Q.HandleExtern)-Q.StartRec)div Size;
   End
    Else
   DBNumRec:=(Q.FileSize-Q.StartPos)div Size;
  End;
 End
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Fonction DBLocateAbs                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: DataSet
 Portabilit‚:  Global


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de retrouver un information dans une table … partir
 de son num‚ro absolue de champs.
}

Function DBLocateAbs(Var Q:DataSet;Column:Word;Const Search;Option:SearchOption):Boolean;
Label Xit;
Var
 NumRec,I:LongInt;
 Inf,Sup,Mil:LongInt; { Limite Inf‚rieur, Sup‚rieur et Milieu }
 OldCurrPos:LongInt;
 J:Integer;
 TypeDef:Byte;
 SearchString:String Absolute Search;
 SearchInteger:Integer Absolute Search;
 SearchWord:Word Absolute Search;
 SearchLongInt:LongInt Absolute Search;
 SearchReal:Real Absolute Search;
 SearchByte:Byte Absolute Search;
 SearchBoolean:Boolean Absolute Search;
 Rec:Pointer;
 Ptr:PtrRec;
 PBoolean:^Boolean Absolute Ptr;
 PByte:^Byte Absolute Ptr;
 PInt:^Integer Absolute Ptr;
 PWord:^Word Absolute Ptr;
 PLongInt:^LongInt Absolute Ptr;
 PReal:^Real Absolute Ptr;
 PStr:^String Absolute Ptr;
 Size:Word;
Begin
 DBLocateAbs:=False;
 {$IFDEF __Windows__}
  If(Q.Handle=0)or(Q.Handle=errHdl)Then Exit; 
 {$ELSE}
  If(Q.Handle)in[0,errHdl]Then Exit;
 {$ENDIF}
 If Q.SizeRec=0Then Size:=4096
               Else Size:=Q.SizeRec;
 Rec:=MemAlloc(Size);
 If(Rec<>NIL)Then Begin
  DBFirst(Q);
  If(Q.StartRec>=Q.FileSize)Then Goto Xit;
  NumRec:=DBNumRec(Q);
  PInt:=Rec;
  DBGotoColumnAbs(Q,Column,Pointer(Ptr));
{  For J:=0to Column-1do Begin
   Inc(Ptr.Ofs,Q.FieldRec^[J].Len);
  End;}
  TypeDef:=Q.FieldRec.Buffer^[Column].TypeDef;
  If((dsSorted)in(Q.Attribut))and((dsAscending)in(Q.Attribut))Then Begin
   { Recherche dichotomique}
   Inf:=0;Sup:=NumRec-1;I:=0;
   While(Inf<=Sup)do Begin
    Mil:=(Inf+Sup)shr 1;
    DBMoveTo(Q,Mil);
    DBReadRec(Q,Rec^);
    Case DBCompData(TypeDef,Ptr,Search,Option)of
     0:Begin
      I:=Mil;
      DBLocateAbs:=True;
      Break;
     End;
     -1:Inf:=Mil+1;
     -2:Break;
     Else Sup:=Mil-1;
    End;
   End;
  End
   Else
  For I:=0to NumRec-1do Begin
   OldCurrPos:=Q.CurrPos;
   DBReadRec(Q,Rec^);
   If DBCompData(TypeDef,Ptr,Search,Option)=0Then Begin
    DBLocateAbs:=True;
    If Q.SizeRec=0Then Q.CurrPos:=OldCurrPos;
    Break;
   End;
   If((dsIndex)in(Q.Attribut))and DBEOF(Q)Then Break;
  End;
  Dec(Q.CurrLine);
  If Not((dsRelative)in(Q.Attribut))Then Begin
   Dec(Q.CurrPos,LongInt(Q.SizeRec));
  End;
Xit:
  FreeMemory(Rec,Size)
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Fonction DBGetColumnNumber                   Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: DataSet
 Portabilit‚:  Global


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction retourne le num‚ro absolue correspondant … au champs
 texte de la table de base de donn‚es.
}

Function DBGetColumnNumber(Var Q:DataSet;Column:PChar):Integer;
Var
 I:Integer;
Begin
 DBGetColumnNumber:=-1;
 If(StrPos(PChr(Column),PChr(PChar(';')))=NIL)Then For I:=0to Q.FieldRec.Num-1do Begin
  If StrComp(Q.FieldRec.Buffer^[I].Title,PChr(Column))=0Then Begin
   DBGetColumnNumber:=I;
   Break;
  End;
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Fonction DBLocate                            Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: DataSet
 Portabilit‚:  Global


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de chercher un ‚l‚ment d'une table … partir
 de son nom champs texte de la table de base de donn‚es.
}

Function DBLocate(Var Q:DataSet;Column:PChar;Const Search):Boolean;
Var
 I:Integer;
Begin
 I:=DBGetColumnNumber(Q,Column);
 If I<>-1Then DBLocate:=DBLocateAbs(Q,I,Search,[]);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Fonction DBGotoColumn                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: DataSet
 Portabilit‚:  Global


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet d'effectuer un d‚placement du pointeur sur
 l'‚l‚ment particulier d'un tableau … partir de son nom texte.
}

Procedure DBGotoColumn(Var Q:DataSet;Const Column:String;Var Buffer:Pointer);
Var
 I:Integer;
 CColumn:Array[Byte]of Char;
Begin
 StrPCopy(@CColumn,Column);
 I:=DBGetColumnNumber(Q,CColumn);
 If I<>-1Then DBGotoColumnAbs(Q,I,Buffer);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Fonction DBAddStrByte                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: DataSet
 Portabilit‚:  Global


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de charger la table d'une base de donn‚es de
 format ( Octet, ChaŒne  de caractŠres )  en  m‚moire  dans une liste
 sym‚trique.
}

Procedure DBAddStrByte(Var Q:DataSet;Var R:ArrayList);
Var
 Data:Record
  X:Byte;
  S:String;
 End;
Begin
 DBFirst(Q);
 Repeat
  DBReadRec(Q,Data);
  ALAddStrByte(R,Data.S,Data.X);
 Until DBEOF(Q);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Fonction DBUnloadField                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: DataSet
 Portabilit‚:  Global


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de lib‚rer l'espace m‚moire utilis‚ par la
 d‚finition des champs de la table courante.
}

Procedure DBUnloadField(Var Q:FieldRecDef);
Var
 I:Word; { Compteur de boucle pour lib‚rer le nom des titres }
Begin
 If Q.Num>0Then For I:=0to Q.Num-1do Begin
  StrDispose(Q.Buffer^[I].Title);
 End;
 FreeMemory(Q.Buffer,Q.Num*SizeOf(FieldDataBaseRec));
 FillClr(Q,SizeOf(Q));
End;

Procedure DBDispose(Var Q:DataSetInMemory);Begin
 DBUnloadField(Q.FieldRec);
 FreeMemory(Q.Index,Q.SizeIndex);
 FreeMemory(Q.Table,Q.SizeTable);
 FillClr(Q,SizeOf(Q));
End;

Function DBCopyToMemory(Var Q:DataSet;Var Target:DataSetInMemory):Boolean;
Var
 I:Word; { Compteur de boucle pour lib‚rer le nom des titres }
Begin
 DBCopyToMemory:=False;
 FillClr(Target,SizeOf(Target));
 If Q.FieldRec.Num>0Then Begin
  Target.FieldRec.Num:=Q.FieldRec.Num;
  Target.FieldRec.Buffer:=MemAlloc(Q.FieldRec.Num*SizeOf(FieldDataBaseRec));
  If(Target.FieldRec.Buffer<>NIL)Then Begin
   For I:=0to Q.FieldRec.Num-1do Begin
    Target.FieldRec.Buffer^[I]:=Q.FieldRec.Buffer^[I];
    Target.FieldRec.Buffer^[I].Title:=StrNew(Q.FieldRec.Buffer^[I].Title);
   End;
  End;
 End
  Else
 Exit;
 Target.SizeTable:=Q.EndPos-Q.StartPos;
 Target.Table:=MemAlloc(Target.SizeTable);
 If(Target.Table<>NIL)Then Begin
  DBFirst(Q);
  _GetAbsRec(Q.Handle,Q.CurrPos,Target.SizeTable,Target.Table^);
  Target.SizeIndex:=Q.SizeIndex;
  If(dsBig)in(Q.Attribut)Then Target.SizeIndex:=Target.SizeIndex shr 1;
  Target.NumRec:=(Target.SizeIndex shr 1)-1;
  Target.Index:=MemAlloc(Target.SizeIndex);
  If(Target.Index<>NIL)Then Begin
   If(dsBig)in(Q.Attribut)Then Begin
    For I:=0to Target.NumRec-1do Begin
     Target.Index^[I]:=Q.Index.Long^[I]-Q.CurrPos;
    End;
   End
    Else
   Begin
    MoveLeft(Q.Index.Word^,Target.Index^,Target.SizeIndex);
    For I:=0to(Target.SizeIndex shr 1)-1do Begin
     Dec(Target.Index^[I],Q.CurrPos);
    End;
   End;
   DBCopyToMemory:=True;
  End
   Else
  DBDispose(Target);
 End
  Else
 DBDispose(Target);
End;

Function DBLocateAbsIM(Var Q:DataSetInMemory;Column:Word;Const Search;Option:SearchOption):Boolean;
Label Strict;
Var
 Inf,Sup,Mil:Integer; { Limite Inf‚rieur, Sup‚rieur et Milieu }
 I:Integer;           { Compteur de boucle }
 Size:Word;           { Taille du d‚placement }
 TypeDef:Byte;
 PtrRec:Pointer;
Begin
 DBLocateAbsIM:=False;
 TypeDef:=Q.FieldRec.Buffer^[Column].TypeDef;
 Inf:=0;Sup:=Q.NumRec-1;I:=0;
 PtrRec:=Q.Table;
 _DBGotoColumnAbs(Q.FieldRec,Column,PtrRec);
 {$IFDEF Flat386}
  Size:=LongInt(PtrRec)-LongInt(Q.Table);
 {$ELSE}
  ASM
   LES DI,Q
   MOV AX,Word Ptr PtrRec
   SUB AX,Word Ptr ES:[DI].DataSetInMemory.Table
   MOV Size,AX
  END;
 {$ENDIF}
 While(Inf<=Sup)do Begin
  Mil:=(Inf+Sup)shr 1;
  PtrRec:=@Q.Table^[Q.Index^[Mil]+Size];
  Case DBCompData(TypeDef,PtrRec,Search,Option)of
   0:Begin
    Q.Pos:=Mil;
    Q.CurrRec.Byte:=@Q.Table^[Q.Index^[Mil]];
    If(soNotStrict)in(Option)Then Begin
     PtrRec:=@Q.Table^[Q.Index^[Mil-1]+Size];
     If DBCompData(TypeDef,PtrRec,Search,Option)=0Then Goto Strict;
     PtrRec:=@Q.Table^[Q.Index^[Mil+1]+Size];
     If DBCompData(TypeDef,PtrRec,Search,Option)=0Then Begin
Strict:DBLocateAbsIM:=DBLocateAbsIM(Q,Column,Search,[]);
      Exit;
     End;
    End;
    DBLocateAbsIM:=True;
    Break;
   End;
   -1:Inf:=Mil+1;
   Else Sup:=Mil-1;
  End;
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Destructeur DBDone                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: DataSet
 Portabilit‚:  Global


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Ce destructeur permet de lib‚rer toutes les ressources du programme
 actuellement utilis‚ par la base de donn‚es sp‚cifi‚e.
}

Procedure DBDone(Var Q:DataSet);Begin
 If(Q.Directory<>NIL)Then DBUpdateDirectory(Q);
 DBUnloadField(Q.FieldRec);
 If(Q.Index.Word<>NIL)Then Begin
  FreeMemory(Q.Index.Word,Q.SizeIndex);
 End;
 If Q.Handle<>0Then FileClose(Q.Handle);
 If Q.HandleExtern<>0Then FileClose(Q.HandleExtern);
End;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
END.