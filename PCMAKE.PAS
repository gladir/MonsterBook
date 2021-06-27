Unit PCMake;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                                   INTERFACE
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Procedure MakeExec;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                                 IMPLEMENTATION
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

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
 Exe:HeaderExe Absolute Buffer;      { Entˆte de fichier EXE de format DOS }
 Mex:MexHeader Absolute Buffer;      { Entˆte d'ex‚cutable MEX }
 ExeNE:NeTypeHeader Absolute Buffer; { Entˆte de fichier EXE de format NE }
 Len:LongInt;       { Longueur du code machine }
 LenPhys:LongInt;   { Longueur physiquement stock‚e dans le fichier }
 FP:LongInt;        { Position actuel d'‚criture }
 PW:^Word;          { Pointeur de mots courant }
 SizeData:Word;     { Taille du segment de donn‚es }
 PhysSizeData:Word; { Taille des donn‚es physiquement stock‚e dans le fichier }
Begin
 CurrPC.PathOutput:=Path2NoExt(CurrPC.MainFile)+ExtFormat[ProgramFormat];
 Case(ProgramFormat)of
  fMEX:Begin { Format d'ex‚cutable d'ex‚cutable Malte EXecutable }
   Handle:=FileCreateAndBackup(CurrPC.PathOutput);
   If(Handle<>errHdl)Then Begin
    Len:=CurrPC.IP-CurrPC.Org;
    FillClr(Buffer,SizeOf(Buffer));
    MEX.Sign:='MEX'#26;
    _SetAbsRec(Handle,0,SizeOf(MEX),MEX);
    _SetAbsRec(Handle,SizeOf(MEX),Len,CurrPC.CodePrg^[CurrPC.Org]);
    FileClose(Handle);
   End;
  End;
  fEXE:Begin
   Handle:=FileCreateAndBackup(CurrPC.PathOutput);
   If(Handle<>errHdl)Then Begin
    FillClr(Buffer,SizeOf(Buffer));
    Len:=CurrPC.IP-CurrPC.Org;
    If(ProgramTarget=ftWin31)Then Begin
     LenPhys:=Len;
     If Len<$48Then Len:=$48;
     SizeData:=1;     { Taille minimum du segment de donn‚es }
     PhysSizeData:=0; { Taille minimum du segment de donn‚es physiquement stock‚e }
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
      { D‚finition du segment de codes }
     Buffer[$40]:=$11;
     Buffer[$42]:=LenPhys;
     Buffer[$44]:=$50;
     Buffer[$45]:=$1D;
     Buffer[$46]:=Len;
      { D‚finition du segment de donn‚es }
     Buffer[$48]:=$18;
     Buffer[$4A]:=PhysSizeData;
     Buffer[$4C]:=$51;
     Buffer[$4D]:=$0C;
     Buffer[$4E]:=SizeData;
     Name:=Path2Name(CurrPC.MainFile);
     MoveLeft(Name,Buffer[$50],Length(Name)+1);
     Buffer[$5B]:=$01;
     Buffer[$5D]:=$08;
     Name:='KERNEL';
     MoveLeft(Name,Buffer[$60],Length(Name)+1);
     Name:='USER';
     MoveLeft(Name,Buffer[$67],Length(Name)+1);
     Name:=Path2NoDir(CurrPC.PathOutput);
     MoveLeft(Name,Buffer[$6E],Length(Name)+1);
     _SetAbsRec(Handle,FP,128,Buffer);
     Inc(FP,128);
     _SetAbsRec(Handle,FP,LenPhys,CurrPC.CodePrg^[CurrPC.Org]);
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
      { criture des donn‚es }
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
     _SetAbsRec(Handle,256,Len,CurrPC.CodePrg^[CurrPC.Org]);
    End;
    FileClose(Handle);
   End;
  End;
  Else Begin
   If FileExist(CurrPC.PathOutput)Then Begin
    DeleteFile(Path2NoExt(CurrPC.PathOutput)+'.BAK');
    RenameFile(CurrPC.PathOutput,Path2NoExt(CurrPC.PathOutput)+'.BAK');
   End;
   SetFile(CurrPC.PathOutput,0,CurrPC.IP-CurrPC.Org,CurrPC.CodePrg^[CurrPC.Org]);
  End;
 End;
End;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
END.