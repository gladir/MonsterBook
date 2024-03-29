Program FLB;

Uses Adele,Systex,Systems;

{$I \Source\Chantal\Library\Files\Images\FLBEntry.Inc}

Var Path:String;
    K,I,J:Byte;X,Y,TY,Jmp,P,Length,LB,Height:Wd;
    Entry:FLBEntry;
    Buffer:Array[0..32767]of Byte;
    Handle,Target:Hdl;
    Year:Word;Month,Day,DayOfWeek:Byte;LP:Chr;

BEGIN
 WriteLn('FLB � RC - D�compilation de biblioth�que de polices Version 1.0');
 WriteLn('           Tous droits r�serv�s par les Chevaliers de Malte');
 WriteLn;
 InitSystems(suIsabel);
 Path:='\TEXTE\NEWS\NEWS.FLB';
 Handle:=FileOpen(Path,fmRead);LP:='A';
 If(Handle=errHdl)Then Begin
  WriteLn('Fichier introuvable!');
  Halt(1)
 End;
 Target:=FileCreateAndBackup(Path2NoExt(Path)+LP+'.RC');
 If(Target=errHdl)Then Begin
  WriteLn('Erreur de cr�ation de fichier');
  Halt(2)
 End;
 PutFileTxtLn(Target,'// Source: '+Path);
 PutFileTxtLn(Target,'// Destination: '+Path2NoExt(Path)+'.RC');
 GetDate(Year,Month,Day,DayOfWeek);
 PutFileTxtLn(Target,'// Date de cr�ation: '+_CStrDate(Year,Month,Day,DayOfWeek));
 PutFileLn(Target);
 PutFileTxtLn(Target,'NumberIndex=34');
 PutFileTxtLn(Target,'FontLibrary=Yes');
 For P:=0to 33do Begin
  If FileSize(Target)>131072Then Begin
   FileClose(Target);
   Inc(LP);
   Target:=FileCreateAndBackup(Path2NoExt(Path)+LP+'.RC');
   If(Target=errHdl)Then Begin
    WriteLn('Erreur de cr�ation de fichier');
    Halt(2)
   End;
  End;
  PutFileLn(Target);
  GetRec(Handle,P,SizeOf(Entry),Entry);
  WriteLn('Police #',P,' nomm� �',StrPas(@Entry.Name),'�');
  PutFileTxtLn(Target,'Name="'+StrPas(@Entry.Name)+'"');
  PutFileTxtLn(Target,'Height='+WordToStr(Entry.Height));
  PutFileTxtLn(Target,'ImageBin '+WordToStr(P));
  _GetAbsRec(Handle,Entry.PosAbs,SizeOf(Buffer),Buffer);
  Length:=Buffer[0]+(Buffer[1]shl 8);Height:=Buffer[2];
  PutFileTxtLn(Target,' Size: '+WordToStr(Length)+','+WordToStr(Height));
  Jmp:=4;
  For J:=0to Height-1do Begin
   For I:=0to((Length or 7)shr 3)-1do Begin
    If I=0Then PutFileTxt(Target,' Bin:');
    PutFileTxt(Target,BinByte2Str(Buffer[Jmp]));
    If I<((Length or 7)shr 3)-1Then PutFileTxt(Target,',');
    Inc(Jmp);
   End;
   PutFileLn(Target);
  End;
  PutFileTxtLn(Target,'End');
  PutFileLn(Target);
  _GetAbsRec(Handle,Entry.PosAbs+Entry.SizeImg,SizeOf(Buffer),Buffer);
  For K:=0to 127do Begin
   Jmp:=Buffer[K shl 1]+(Buffer[(K shl 1)+1]shl 8);
   If Jmp<>$FFFFThen Begin
    If K in[32..126]Then PutFileTxtLn(Target,'Matrix '+WordToStr(K)+' // '+Chr(K))
                    Else PutFileTxtLn(Target,'Matrix '+WordToStr(K));
    Length:=Buffer[256+Jmp+1];Height:=Buffer[256+Jmp+3];
    TY:=Entry.Height-Buffer[256+Jmp+2];
    PutFileTxtLn(Target,' Size: '+WordToStr(Length)+','+WordToStr(Height)+':'+WordToStr(TY));
    Inc(Jmp,256+4);
    For J:=0to Height-1do Begin
     LB:=Length;
     If LB<8Then LB:=0
      Else
     Begin
      If LB and 7<>7Then Inc(LB);
      LB:=LB shr 3;
     End;
     For I:=0to(LB)do Begin
      If I=0Then PutFileTxt(Target,' Bin:');
      PutFileTxt(Target,BinByte2Str(Buffer[Jmp]));
      If(I<LB)Then PutFileTxt(Target,',');
      Inc(Jmp);
     End;
     PutFileLn(Target);
    End;
    PutFileTxtLn(Target,'End');
    PutFileLn(Target);
   End;
  End;
 End;
 FileClose(Target);
 FileClose(Handle);
END.
