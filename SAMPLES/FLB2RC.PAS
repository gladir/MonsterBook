Program FLB;

Uses DOS;

Const
  { Attribut de fichier Dos }
 fa=$FFE7;                   { Attribut de tous fichier, sauf r‚pertoire et volume. }
 faReadOnly=1;               { Lecture seulement }
 faHidden=2;                 { Cach‚ }
 faSysFile=4;                { SystŠme }
 faVolumeID=8;               { Volume }
 faDir=$10;                  { R‚pertoire }
 faArchive=$20;              { Archive }
 faAnyFile=$3F;              { N'importe qu'elle fichier }
 faAll=$FFF7;                { Tous les fichiers sans exception }

  { Mode fichier d'accŠs d'un fichier }
 fmRead=0;                   { Lecture seulement }
 fmWrite=1;                  { Ecriture seulement }
 fmDef=2;                    { Lecture et ‚criture }

 errHdl=$FF;

Type FLBEntry=Record
 Data1:Array[0..5]of Byte;    { Donn‚es r‚serv‚??? Possiblement 3 mots... }
 PosAbs:LongInt;              { Position absolue dans le fichier de l'image}
                              { suivit par la police (256+SizeImg). Dans la}
                              { partie de taille de 256 caractŠres, il }
                              { contient une table de 128 mots contenant}
                              { des adresses de chacun des 128 caractŠres}
                              { contenu dans cette police.}
 Name:Array[0..49]of Char;    { Nom de la police de caractŠre }
 SizeImg:Word;                { Taille de l'image }
 Data2:Array[62..75]of Byte;  { Donn‚es r‚serv‚??? }
 Height:Word;                 { Hauteur des caractŠres }
 Data3:Word;                  { Donn‚es r‚serv‚??? }
End;

Type
 Hdl=Byte;

Var
 SysErr:Word;
 Path:String;
 K,I,J:Byte;X,Y,TY,Jmp,P,LengthObject,LB,Height:Word;
 Entry:FLBEntry;
 Buffer:Array[0..32767]of Byte;
 Handle,Target:Hdl;
 Year:Word;Month,Day,DayOfWeek:Byte;LP:Char;

{Cette proc‚dure rajoute le caractŠre d‚finit par la variable de param‚trage
 ®Chr¯ … la chaŒne de caractŠres sp‚cifier par la variable de param‚trage ®S¯.
}

Procedure IncStr(Var S:String;Chr:Char);Assembler;ASM
 LES BX,S
 INC Byte Ptr ES:[BX]
 ADD BL,ES:[BX]
 ADC BH,0
 MOV AL,Chr
 MOV ES:[BX],AL
END;

{Cette fonction ouvre un fichier par la technique des fichiers Handle du
 systŠme d'exploitation DOS ou compatible  et retourne son code lui ‚tant
 attribu‚.
}

Function FileOpen(Name:String;Mode:Byte):Hdl;
Var
 SegName,OfsName,I:Word;
Begin
 IncStr(Name,#0);
 SegName:=Seg(Name[1]);
 OfsName:=Ofs(Name[1]);
 ASM
  MOV AX,3D40h
  OR  AL,Mode
  PUSH DS
   MOV DX,OfsName
   MOV DS,SegName
   INT 21h
  POP DS
  JC  @1
  XOR BX,BX
  JMP @2
@1:MOV BX,AX
  MOV AL,errHdl
@2:MOV SysErr,BX
  MOV @Result,AL
 END;
End;

Function FileCreate(Name:String;Attr:Word):Hdl;Assembler;ASM
 PUSH DS
  MOV CX,Attr
  LDS DI,Name
  MOV BL,DS:[DI]
  INC DI{Set Name[1]}
  MOV BH,0
  MOV DS:[DI+BX],BH{Name:=Name+#0}
  MOV DX,DI
  MOV AH,03Ch
  INT 021h
 POP DS
 JC  @1
 XOR BX,BX
 JMP @2
@1:MOV BX,AX
 MOV AX,errHdl
@2:MOV SysErr,BX
END;

{ Cette fonction retourne le r‚pertoire courant du systŠme d'exploitation
 DOS ou compatible.
}

Function GetCurrentDir:String;
Var
 Path:String;
Begin
 GetDir(0,Path);
 GetCurrentDir:=Path
End;

{ Cette fonction retourne un chemin  de r‚pertoire de fa‡on … ce qu'il est
 toujours une barre oblique pour permettre l'addition d'un nom de fichier.
}

Function SetPath4AddFile(Path:String):String;Begin
 If Path=''Then Path:=GetCurrentDir;
 If Path[Length(Path)]<>'\'Then IncStr(Path,'\');
 SetPath4AddFile:=Path;
End;

Function Path2NoExt(Const Path:String):String;
Var
 D:DirStr;
 N:NameStr;
 E:ExtStr;
Begin
 FSplit(Path,D,N,E);
 Path2NoExt:=SetPath4AddFile(D)+N
End;

BEGIN
 WriteLn('FLB … RC - D‚compilation de bibliothŠque de polices Version 1.0');
 WriteLn('           Tous droits r‚serv‚s par les Chevaliers de Malte');
 WriteLn;
 Path:='\NEWS\NEWS.FLB';
 Handle:=FileOpen(Path,fmRead);LP:='A';
 If(Handle=errHdl)Then Begin
  WriteLn('Fichier introuvable!');
  Halt(1)
 End;
 Target:=FileCreate(Path2NoExt(Path)+LP+'.RC',faArchive);
 If(Target=errHdl)Then Begin
  WriteLn('Erreur de cr‚ation de fichier');
  Halt(2)
 End;
 PutFileTxtLn(Target,'// Source: '+Path);
 PutFileTxtLn(Target,'// Destination: '+Path2NoExt(Path)+'.RC');
 GetDate(Year,Month,Day,DayOfWeek);
 PutFileTxtLn(Target,'// Date de cr‚ation: '+_CStrDate(Year,Month,Day,DayOfWeek));
 PutFileLn(Target);
 PutFileTxtLn(Target,'NumberIndex=34');
 PutFileTxtLn(Target,'FontLibrary=Yes');
 For P:=0to 33do Begin
  If FileSize(Target)>131072Then Begin
   FileClose(Target);
   Inc(LP);
   Target:=FileCreate(Path2NoExt(Path)+LP+'.RC',faArchive);
   If(Target=errHdl)Then Begin;WriteLn('Erreur de cr‚ation de fichier');Halt(2)End;
  End;
  PutFileLn(Target);
  GetRec(Handle,P,SizeOf(Entry),Entry);
  WriteLn('Police #',P,' nomm‚ ®',StrPas(@Entry.Name),'¯');
  PutFileTxtLn(Target,'Name="'+StrPas(@Entry.Name)+'"');
  PutFileTxtLn(Target,'Height='+WordToStr(Entry.Height));
  PutFileTxtLn(Target,'ImageBin '+WordToStr(P));
  _GetAbsRec(Handle,Entry.PosAbs,SizeOf(Buffer),Buffer);
  LengthObject:=Buffer[0]+(Buffer[1]shl 8);Height:=Buffer[2];
  PutFileTxtLn(Target,' Size: '+WordToStr(LengthObject)+','+WordToStr(Height));
  Jmp:=4;
  For J:=0to Height-1do Begin
   For I:=0to((LengthObject or 7)shr 3)-1do Begin
    If I=0Then PutFileTxt(Target,' Bin:');
    PutFileTxt(Target,BinByte2Str(Buffer[Jmp]));
    If I<((LengthObject or 7)shr 3)-1Then PutFileTxt(Target,',');
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
    LengthObject:=Buffer[256+Jmp+1];Height:=Buffer[256+Jmp+3];
    TY:=Entry.Height-Buffer[256+Jmp+2];
    PutFileTxtLn(Target,' Size: '+WordToStr(LengthObject)+','+WordToStr(Height)+':'+WordToStr(TY));
    Inc(Jmp,256+4);
    For J:=0to Height-1do Begin
     LB:=LengthObject;
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
