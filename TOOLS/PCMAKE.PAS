Unit PCMake;

{컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�}
                                   INTERFACE
{컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�}

Procedure MakeExec;

{컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�}
                                 IMPLEMENTATION
{컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�}

Uses Systex,PCCortex,WinTex,Systems;

{$I \Source\Chantal\Library\System\Malte\ExecFile\MexHeader.Inc}

Procedure MakeExec;
Const
 WindowsMsg='Ce programme fonctionne sous Windows.'#13#10+'$';
 AsmMsgNotWin:Array[0..$D]of Byte=(
  $BA,$10,$00,$0E,$1F,$B4,$09,$CD,$21,$B8,$01,$4C,$CD,$21
 );
Var
 Handle:Hdl;
 Name:String;
 Buffer:Array[0..255]of Byte;
 Exe:HeaderExe Absolute Buffer;      { Ent늯e de fichier EXE de format DOS }
 Mex:MexHeader Absolute Buffer;      { Ent늯e d'ex괹utable MEX }
 ExeNE:NeTypeHeader Absolute Buffer; { Ent늯e de fichier EXE de format NE }
 Len:LongInt;       { Longueur du code machine }
 LenPhys:LongInt;   { Longueur physiquement stock괻 dans le fichier }
 FP:LongInt;        { Position actuel d'괹riture }
 PW:^Word;          { Pointeur de mots courant }
 SizeData:Word;     { Taille du segment de donn괻s }
 PhysSizeData:Word; { Taille des donn괻s physiquement stock괻 dans le fichier }
Begin
 PathOutput:=Path2NoExt(MainFile)+ExtFormat[ProgramFormat];
 Case(ProgramFormat)of
  fMEX:Begin { Format d'ex괹utable d'ex괹utable Malte EXecutable }
   Handle:=NewNBak(PathOutput);
   If(Handle<>errHdl)Then Begin
    Len:=IP-Org;
    FillClr(Buffer,SizeOf(Buffer));
    MEX.Sign:='MEX'#26;
    _SetAbsRec(Handle,0,SizeOf(MEX),MEX);
    _SetAbsRec(Handle,SizeOf(MEX),Len,CodePrg^[Org]);
    FileClose(Handle);
   End;
  End;
  fEXE:Begin
   Handle:=NewNBak(PathOutput);
   If(Handle<>errHdl)Then Begin
    FillClr(Buffer,SizeOf(Buffer));
    Len:=IP-Org;
    If(ProgramTarget=ftWin31)Then Begin
     LenPhys:=Len;
     If Len<$48Then Len:=$48;
     SizeData:=1;     { Taille minimum du segment de donn괻s }
     PhysSizeData:=0; { Taille minimum du segment de donn괻s physiquement stock괻 }
     Exe.Sign:='MZ';
     Exe.LenN511:=$50;
     Exe.LenShr9:=2;
     Exe.SizeOfHeader:=4;
     Exe.MinParagraph:=15;
     Exe.MaxParagraph:=$FFFF;
     Exe.SizeOfStack:=$B8;
     Exe.AdrExeTable:=$40;
{     FP:=$50+Length(WindowsMsg);
     If FP<$90Then} FP:=$90;
     PW:=@Buffer[$3C];
     PW^:=FP;
     MoveLeft(AsmMsgNotWin,Buffer[$40],SizeOf(AsmMsgNotWin));
     StrPCopy(PChr(@Buffer[$50]),WindowsMsg);
     _SetAbsRec(Handle,0,FP,Buffer);
     FillClr(Buffer,SizeOf(Buffer));
     ExeNe.ID:='NE';
     ExeNe.LinkerMajorVersion:=5;
     ExeNe.LinkerMinorVersion:=$A;
     ExeNe.OffsetOfEntryTable:=$6C;
     ExeNe.LengthOfEntryTableInBytes:=$02;
     ExeNe.ProgramFlagsBitmapped:=$0A;
     ExeNe.AutoDataSegmentIndex:=$02;
     ExeNe.InitialLocalHeapSize:=$1000;
     ExeNe.InitialStackSize:=$1400;
     ExeNe.EntryPointIP:=$01;
     ExeNe.InitialStackPointerSP:=$02;
     ExeNe.SegmentCount:=$02;
     ExeNe.ModuleReferenceCount:=$02;
     ExeNe.SizeOfNonresidentNamesTableInBytes:=$0F;
     ExeNe.OffsetOfSegmentTable:=$40;
     ExeNe.OffsetOfResourceTable:=$50;
     ExeNe.OffsetOfResidentNamesTable:=$50;
     ExeNe.OffsetOfModuleReferenceTable:=$5B;
     ExeNe.OffsetOfImportedNamesTable:=$5F;
     ExeNe.OffsetFromStartOfFileToNonResidentNamesTable:=$FE;
     ExeNe.FileAlignmentSizeShiftCount:=4;
     ExeNe.TargetOperatingSystem:=2;
     ExeNe.WinVersion:=$0300; { 3.0 }
      (* Segment Table *)
      { D괽inition du segment de codes }
     Buffer[$40]:=$11;
     Buffer[$42]:=LenPhys;
     Buffer[$44]:=$50;
     Buffer[$45]:=$1D;
     Buffer[$46]:=Len;
      { D괽inition du segment de donn괻s }
     Buffer[$48]:=$18;
     Buffer[$4A]:=PhysSizeData;
     Buffer[$4C]:=$51;
     Buffer[$4D]:=$0C;
     Buffer[$4E]:=SizeData;
     Name:=Path2Name(MainFile);
     MoveLeft(Name,Buffer[$50],Length(Name)+1);
     Buffer[$5B]:=$01;
     Buffer[$5D]:=$08;
     Name:='KERNEL';
     MoveLeft(Name,Buffer[$60],Length(Name)+1);
     Name:='USER';
     MoveLeft(Name,Buffer[$67],Length(Name)+1);
     Name:=Path2NoDir(PathOutput);
     MoveLeft(Name,Buffer[$6E],Length(Name)+1);
     _SetAbsRec(Handle,FP,128,Buffer);
     Inc(FP,128);
     _SetAbsRec(Handle,FP,LenPhys,CodePrg^[Org]);
     Inc(FP,LenPhys);
     FillClr(Buffer,SizeOf(Buffer));
     Buffer[$00]:=1;
     Buffer[$02]:=3;
     Buffer[$03]:=1;
     Buffer[$04]:=1;
     Buffer[$06]:=1;
     Buffer[$08]:=$5B;
     _SetAbsRec(Handle,FP,10+$1E,Buffer);
     Inc(FP,10+$1E);
      { 릀riture des donn괻s }
     FillClr(Buffer,SizeOf(Buffer));
     _SetAbsRec(Handle,FP,PhysSizeData,Buffer);
    End
     Else
    Begin
     Exe.Sign:='MZ';
     Exe.LenN511:=Len and 511;Exe.LenShr9:=(Len shr 9)+1;
     Exe.MinParagraph:=MinParag;Exe.MaxParagraph:=MaxParag;
     Exe.OfsLoadStack:=StackSize;Exe.SizeOfStack:=StackSize;
     Exe.IP:=$100;
     _SetAbsRec(Handle,0,256,Exe);
     _SetAbsRec(Handle,256,Len,CodePrg^[Org]);
    End;
    FileClose(Handle);
   End;
  End;
  Else Begin
   If FileExist(PathOutput)Then Begin
    DeleteFile(Path2NoExt(PathOutput)+'.BAK');
    RenameFile(PathOutput,Path2NoExt(PathOutput)+'.BAK');
   End;
   SetFile(PathOutput,0,IP-Org,CodePrg^[Org]);
  End;
 End;
End;

{컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�}
END.