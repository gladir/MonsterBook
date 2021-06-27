Unit Sound;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                                 INTERFACE
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

{$I DEF.INC}

Uses Systex,Soundex;

Type
 WaveRecord=Record
  Frequency:Word;             { Fr‚quence d'enregistrement }
  DataSize:Word;              { Taille de la table Wave }
  Data:Pointer;               { Donn‚e de la table Wave }
  TickEnd:LongInt;            { Temps d'arrˆt o— on peut d‚charger }
  FP:LongInt;                 { Position du prochain chargement }
  FS:LongInt;                 { Taille du tampon … lire }
  Handle:Hdl;                 { Handle attribu‚ au WAVE si trop gros }
  LenData:Word;               { Longueur des donn‚es … jouer }
  Planes:Byte;                { Num‚ro de plage dans l'‚criture des donn‚es
                                dans le tampon}
 End;

Var
 CurrWave:WaveRecord;

Function  GetMicVolume:Byte;
Function  GetMasterVolume:Byte;
Function  GetFMVolume:Byte;
Function  GetCDVolume:Byte;
Function  GetLineVolume:Byte;
Procedure SetCDVolume(X:Byte);
Procedure SetFMVolume(X:Byte);
Procedure SetLineVolume(X:Byte);
Procedure SetMasterVolume(X:Byte);
Procedure SetMicVolume(X:Byte);
Procedure SpeakerOn;
Procedure SpeakerOff;
Procedure WriteDAC(Level:Byte);
Function  ReadDAC:Byte;
Procedure DMAStop;
Procedure DMAContinue;
Procedure PlayBack(Sound:Pointer;Size:Word;Frequency:Word;Read:Boolean);
Function  LoadVoc(Const Name:String;Var Wave:WaveRecord):Byte;
Function  LoadWave(Const Name:String;Var Wave:WaveRecord):Byte;
Procedure UnLoadWave(Var Wave:WaveRecord);
Procedure PlayWave(Var Wave:WaveRecord);
Procedure BackSound;
Procedure _InitWave;
Procedure _LoadSound(Const Name:String);
Procedure _LoadVoc(Const Name:String);
Procedure _LoadWave(Const Name:String);
Procedure _PlayWave;
Procedure _UnloadWave;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                                IMPLEMENTATION
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Uses Memories,Systems;

Const
 WaveInitialize:Boolean=False;
 LengthPort:Array[0..7]of Word=($01,$03,$05,$07,$C2,$C6,$CA,$CE);

Var
 DSPReset,DSPReadData,DSPWriteData,DSPWriteStatus,DSPDataAvail:Word;
 OldBackKbd:Procedure;

Function GetSoundVolume:Byte;Near;Assembler;ASM
 MOV DX,SoundPort
 ADD DX,4
 OUT DX,AL
 INC DX
 IN  AL,DX
END;

Procedure SetSoundVolume;Near;Assembler;ASM
 MOV DX,SoundPort
 ADD DX,4
 OUT DX,AX
END;

Function GetMicVolume:Byte;Assembler;ASM
 MOV AL,0Ah
 CALL GetSoundVolume
END;

Procedure SetMicVolume(X:Byte);Assembler;ASM
 MOV AL,0Ah
 MOV AH,X
 CALL SetSoundVolume
END;

Function GetMasterVolume:Byte;Assembler;ASM
 MOV AL,22h
 CALL GetSoundVolume
END;

Procedure SetMasterVolume(X:Byte);Assembler;ASM
 MOV AL,22h
 MOV AH,X
 CALL SetSoundVolume
END;

Function GetFMVolume:Byte;Assembler;ASM
 MOV AL,26h
 CALL GetSoundVolume
END;

Procedure SetFMVolume(X:Byte);Assembler;ASM
 MOV AL,26h
 MOV AH,X
 CALL SetSoundVolume
END;

{ Cette fonction permet de connaŒtre le volume actuel attribu‚ au lecteur
 de disque compacte.
}

Function GetCDVolume:Byte;Assembler;ASM
 MOV AL,28h
 CALL GetSoundVolume
END;

{ Cette proc‚dure permet de fixer le volume actuel attribu‚ au lecteur
 de disque compacte.
}

Procedure SetCDVolume(X:Byte);Assembler;ASM
 MOV AL,28h
 MOV AH,X
 CALL SetSoundVolume
END;

Function GetLineVolume:Byte;Assembler;ASM
 MOV AL,2Eh
 CALL GetSoundVolume
END;

Procedure SetLineVolume(X:Byte);Assembler;ASM
 MOV AL,2Eh
 MOV AH,X
 CALL SetSoundVolume
END;

{$IFNDEF __Windows__}
 Procedure MyDelay(n:Word);Near;Assembler;
 Var
  LastTick:Word absolute $40:$6C;
 ASM
  MOV ES,Seg0040
  MOV DX,ES:LastTick
 @AGAIN:
  MOV AX,ES:LastTick
  SUB AX,DX
  CMP AX,n
  JB  @AGAIN
 End;

 Function ResetDSP(Base:Word):Boolean;Near;
 Const
  DMAChannelDefault:Array[0..$F]of Byte=(
   1, { 200h: Bidon }
   1, { 210h: Bidon }
   1, { 220h: Canal 1 }
   0, { 230h: Canal 0 }
   3, { 240h: Canal 3 }
   3, { 250h: Canal 3 }
   7, { 260h: Canal 7 }
   7, { 270h: Canal 7 }
   7, { 280h: Canal 7 }
   7, { 290h: Canal 7 }
   1, { 2A0h: Bidon}
   1, { 2B0h: Bidon}
   1, { 2C0h: Bidon}
   1, { 2D0h: Bidon}
   1, { 2E0h: Bidon}
   1  { 2F0h: Bidon}
  );
 Begin
  DMAChannel:=DMAChannelDefault[(Base and$FF)shr 4];
  DSPReset:=Base+$06;
  DSPReadData:=Base+$0A;
  DSPWriteData:=Base+$0C;
  DSPWriteStatus:=Base+$0C;
  DSPDataAvail:=Base+$0E;
  Port[DSPReset]:=1;
  MyDelay(1);
  Port[DSPReset]:=0;
  MyDelay(1);
  ResetDSP:=(Port[DSPDataAvail]and$80=$80)and(Port[DSPReadData]=$AA);
 End;
{$ENDIF}

Procedure WriteDSP(Value:Byte);Near;Begin
 {$IFNDEF __Windows__}
  ASM
  { X:=0;
    While Port[DSPWriteStatus]and$80<>0do Begin
     Inc(X);
     If X=255Then Break;
    End;
    Port[DSPWriteData]:=Value;}
   MOV  DX,DSPWriteStatus
   MOV  CX,0FFh
@1:IN   AL,DX
   TEST AL,80h
   JZ   @Ok
   LOOP @1
   JMP  @End
@Ok:
   MOV DX,DSPWriteData
   MOV AL,Value
   OUT DX,AL
@End:
  END;
 {$ENDIF}
End;

Function ReadDSP:Byte;Near;Begin
 {$IFNDEF __Windows__}
  ASM
   {X:=0;
   While Port[DSPDataAvail]and$80=0do Begin
    Inc(X);
    If X=255Then Begin
     ReadDSP:=0;
     Exit;
    End;
   End;
   ReadDSP:=Port[DSPReadData];}
   MOV  DX,DSPDataAvail
   MOV  CX,0FFh
@1:IN   AL,DX
   TEST AL,80h
   JNZ  @Ok
   LOOP @1
   XOR  AX,AX
   JMP  @End
@Ok:
   MOV DX,DSPReadData
   IN  AL,DX
@End:
  END;
 {$ENDIF}
End;

Procedure WriteDAC(Level:Byte);Begin
 If Not(WaveInitialize)Then Exit;
 WriteDSP($10);
 WriteDSP(Level);
End;

Function ReadDAC:Byte;Begin
 If Not(WaveInitialize)Then Exit;
 WriteDSP($20);
 ReadDAC:=ReadDSP;
End;

Procedure SpeakerOn;Begin
 If Not(WaveInitialize)Then Exit;
 WriteDSP($D1);
End;

Procedure SpeakerOff;Begin
 If Not(WaveInitialize)Then Exit;
 WriteDSP($D3);
End;

Procedure DMAContinue;Begin
 If Not(WaveInitialize)Then Exit;
 WriteDSP($D4);
End;

Procedure DMAStop;Begin
 If Not(WaveInitialize)Then Exit;
 WriteDSP($D0);
End;

Procedure Playback(Sound:Pointer;Size:Word;Frequency:Word;Read:Boolean);
Const
 PagePort:Array[0..7]of Word=($87,$83,$81,$82,$8F,$8B,$89,$8A);
 AddrPort:Array[0..7]of Word=($00,$02,$04,$06,$C0,$C4,$C8,$CC);
Var
 TimeConstant,DMAMaskPort,DMAClearPort,DMAModePort:Word;
 AddrLong:LongInt;
 Offset:Word Absolute AddrLong;
Begin
 If Not(WaveInitialize)Then Exit;
 {$IFNDEF __Windows__}
  If ReadDAC<>0Then DMAStop;
  If(Read)Then SpeakerOff
          Else SpeakerOn;
  Dec(Size);
  AddrLong:=AddrExt2Conv(Sound);
  If DMAChannel and 4=4Then Begin
   DMAMaskPort:=$D4;
   DMAClearPort:=$D8;
   DMAModePort:=$D6;
  End
   Else
  Begin
   DMAMaskPort:=$0A;
   DMAClearPort:=$0C;
   DMAModePort:=$0B;
  End;
  Port[DMAMaskPort]:=4+(DMAChannel and 3);
  Port[DMAClearPort]:=0;
  Port[DMAModePort]:=$48-(Byte(Read)shl 2)+(DMAChannel and 3);
  Port[AddrPort[DMAChannel]]:=Lo(Offset);
  Port[AddrPort[DMAChannel]]:=Hi(Offset);
  Port[PagePort[DMAChannel]]:=LongRec(AddrLong).Hi; {Page}
  Port[LengthPort[DMAChannel]]:=Lo(Size);
  Port[LengthPort[DMAChannel]]:=Hi(Size);
  Port[DMAMaskPort]:=(DMAChannel and 3); { Lib‚rer le canal DMA }
  If Frequency=0Then Exit;
  TimeConstant:=256-1000000 div Frequency;
  WriteDSP($40);
  WriteDSP(TimeConstant);
  WriteDSP($14);
  WriteDSP(Lo(Size));
  WriteDSP(Hi(Size));
 {$ENDIF}
End;

Function LoadRiff(Const Name:String;Var Riff:RiffFile;Var Wave:WaveRecord):Byte;Near;Begin
 LoadRiff:=feNoError;
 Wave.Handle:=FileOpen(Name,fmRead);
 If(Wave.Handle=errHdl)Then Begin
  LoadRiff:=feFileNotFound;
  Exit;
 End;
 Wave.FS:=FileSize(Wave.Handle);
 _GetAbsRec(Wave.Handle,0,44,Riff);
 If(Riff.rID<>RiffSignature)Then Begin
  LoadRiff:=feNotARiff;
  Exit;
 End;
 If(Riff.wID<>WaveSignature)Then Begin
  LoadRiff:=feNotAWave;
  Exit;
 End;
 If(Riff.fID<>FmtSignature)Then Begin
  LoadRiff:=feNotAnFMT;
  Exit;
 End;
 If(Riff.dID<>DataSignature)Then Begin
  LoadRiff:=feErrorInData;
  Exit;
 End;
 If(Riff.dLen>Wave.FS)Then Begin
  Wave.DataSize:=Wave.FS;
  Riff.dData:=MemAlloc(Wave.FS);
  If(Riff.dData<>NIL)Then _GetRec(Wave.Handle,Wave.FS,Riff.dData^);
 End
  Else
 Begin
  If Riff.dLen>65520Then Begin
   Wave.DataSize:=65520;
   Wave.FP:=Wave.FS-65520-44;
  End
   Else
  Wave.DataSize:=Riff.dLen;
  Riff.dData:=MemAlloc(Wave.DataSize);
  If(Riff.dData<>NIL)Then _GetRec(Wave.Handle,Wave.DataSize,Riff.dData^);
 End;
 Wave.LenData:=Wave.DataSize;
 If Wave.FP=0Then FileClose(Wave.Handle);
End;

Function LoadWave(Const Name:String;Var Wave:WaveRecord):Byte;
Var
 Riff:RiffFile;
 Tmp:Byte;
Begin
 If Not(WaveInitialize)Then Exit;
 FillClr(Wave,SizeOf(Wave));
 Tmp:=LoadRiff(Name,Riff,Wave);
 If(Tmp=feNoError)Then Begin
  Wave.Frequency:=Riff.nSamplesPerSec;
  If Riff.nChannels=2Then Wave.Frequency:=Wave.Frequency shl 1;
  Wave.Data:=Riff.dData;
 End;
 LoadWave:=Tmp;
End;

Function LoadVoc(Const Name:String;Var Wave:WaveRecord):Byte;
Var
 X:Record
  H:VocHeader;
  D:VoiceBlock;
  Res:Byte;
  TimeConstant:Byte;
  ResB:Byte;
 End;
Begin
 If Not(WaveInitialize)Then Exit;
 FillClr(Wave,SizeOf(Wave));
 Wave.Handle:=FileOpen(Name,fmRead);
 If(Wave.Handle<>errHdl)Then Begin
  Wave.FS:=FileSize(Wave.Handle)-SizeOf(X);
  _GetAbsRec(Wave.Handle,0,SizeOf(X),X);
  If(X.H.Sign=VocSign)and(X.TimeConstant<>0)Then Begin
   Wave.Frequency:=Round(1000000/(256-X.TimeConstant));
   If Wave.FS>65520Then Begin
    Wave.DataSize:=65520;
    Wave.FP:=65520+SizeOf(X);
   End
    Else
   Wave.DataSize:=Wave.FS;
   Wave.Data:=MemAlloc(Wave.DataSize);
   If(Wave.Data<>NIL)Then _GetRec(Wave.Handle,Wave.DataSize,Wave.Data^);
   Wave.LenData:=Wave.DataSize;
   If Wave.FP=0Then FileClose(Wave.Handle);
  End
   Else
  LoadVoc:=feInvalidHeader;
 End
  Else
 LoadVoc:=feFileNotFound;
End;

Procedure UnLoadWave(Var Wave:WaveRecord);Begin
 If Not(WaveInitialize)Then Exit;
 If Wave.DataSize<>0Then With Wave do Begin
  FileClose(Wave.Handle);
  FreeMemory(Data,DataSize);
  DataSize:=0;
  Frequency:=0;
 End;
End;

Function LenPort:Word;Near;
Var
 P:Word;
Begin
 P:=LengthPort[DMAChannel];
 ASM
  MOV DX,P
  IN  AL,DX
  MOV AH,AL
  IN  AL,DX
  XCHG AH,AL
  MOV @Result,AX
 END;
End;

Procedure BackSound;
Var
 Handle:Hdl;
Begin
 OldBackKbd;
 If CurrWave.TickEnd<>$FFFFFFFFThen Begin
  If(CurrWave.TickEnd<GetRawTimer)Then Begin
   If LenPort=$FFFFThen Begin
    If(CurrWave.FP>0)Then Begin
     CurrWave.LenData:=_GetAbsRec(CurrWave.Handle,CurrWave.FP,
                                  CurrWave.DataSize,CurrWave.Data^);
     SysErr:=0;
     Inc(CurrWave.FP,Long(CurrWave.DataSize));
     If(CurrWave.FP>CurrWave.FS)Then Begin
      FileClose(CurrWave.Handle);
      SysErr:=0;CurrWave.FP:=0;
     End;
     _PlayWave;
    End
     Else
    Begin
     _UnloadWave;
     CurrWave.TickEnd:=$FFFFFFFF;
    End;
   End;
  End;
 End;
End;

Procedure PlayWave(Var Wave:WaveRecord);Begin
 If Not(WaveInitialize)Then Exit;
 If Wave.Frequency=0Then Wave.TickEnd:=0
  Else
 Begin
  Wave.TickEnd:=GetRawTimer+
  ((Wave.DataSize div(256-1000000 div Wave.Frequency))shr 4);
 End;
 Playback(Wave.Data,Wave.LenData,Wave.Frequency,False);
End;

Procedure _InitWave;Begin
 {$IFNDEF __Windows__}
  FillClr(CurrWave,SizeOf(CurrWave));
  CurrWave.TickEnd:=$FFFFFFFF;
  If(IsSoundBlaster)and(SoundPort<>0)Then Begin
   Repeat Until ResetDSP(SoundPort);
   SpeakerOn;
   WaveInitialize:=True;
   OldBackKbd:=_BackKbd;
   _BackKbd:=BackSound;
  End;
 {$ENDIF} 
End;

Procedure _LoadWave(Const Name:String);Begin
 If Not(WaveInitialize)Then Exit;
 If CurrWave.TickEnd<>$FFFFFFFFThen _UnloadWave;
 LoadWave(Name,CurrWave);
End;

Procedure _LoadVoc(Const Name:String);Begin
 If Not(WaveInitialize)Then Exit;
 If CurrWave.TickEnd<>$FFFFFFFFThen _UnloadWave;
 LoadVoc(Name,CurrWave);
End;

Procedure _LoadSound(Const Name:String);Begin
 If Path2Ext(Name)='.VOC'Then _LoadVoc(Name)
                         Else _LoadWave(Name);
End;

Procedure _PlayWave;Begin
 If Not(WaveInitialize)Then Exit;
 PlayWave(CurrWave);
End;

Procedure _UnLoadWave;Begin
 If Not(WaveInitialize)Then Exit;
 UnloadWave(CurrWave);
End;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
END.
