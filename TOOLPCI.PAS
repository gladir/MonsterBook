{$G+}

Unit ToolPCI;

INTERFACE

Procedure InfoPCI;

IMPLEMENTATION

Uses
 Systex,Adele,Memories,Systems,Video,Mouse,Isatex,
 Dialex,Dials,ResTex,ResServD,ResLoadD,ResSaveD;

Type
 PCIInfo=Record
  VID:Word;
  DID:Word;
  Command:Record Case Byte Of
   0:(Value:Word);
   1:(Flags:Set of (
    cmdIOAccess,cmdMemoryAccess,cmdBusMaster,cmdSpecialCycles,
    cmdMemWriteInvalidate,cmdVGAPaletteSnoop,cmdParityErrorResponse,cmdWaitCycles,
    cmdSystemErrors,cmdBackToBackTransactions));
  End;
  InfoTbl:Array[6..$FF]of Byte;
  Vendor:String;
  Identificator:String;
 End;

Function LookUpBios(DeviceId,Func,Bus:Byte;Index:Word):Byte;Near;Assembler;ASM
 MOV AX,0B108h
 MOV BL,DeviceId
 {$IFOPT G+}
  SHL BL,3
 {$ELSE}
  SHL BL,1
  SHL BL,1
  SHL BL,1
 {$ENDIF}
 ADD BL,Func
 MOV BH,Bus
 MOV DI,Index
 INT 01Ah
 JC @Exit
 XCHG AX,CX
@Exit:
 MOV Byte Ptr SysErr[1],AH
END;

Function LookUpHardware(DeviceId,Func,Bus:Byte;Index:Word):Byte;Near;Assembler;ASM
 MOV AX,$8000
 MOV AL,bus
 DB $66;SHL AX,16
 MOV AX,Index
 AND AX,00FCh
 MOV AH,DeviceID
 {$IFOPT G+}
  SHL AH,3
 {$ELSE}
  SHL AH,1
  SHL AH,1
  SHL AH,1
 {$ENDIF}
 ADD AH,Func
 MOV DX,0CF8h
 DB $66;OUT DX,AX
 MOV AX,Index
 AND AX,3
 MOV BL,8
 MUL BL
 MOV CX,AX
 MOV DX,0CFCh
 DB $66;IN AX,DX
 DB $66;SHR AX,CL
 XCHG AX,BX
 DB $66;XOR AX,AX
 MOV DX,0CF8h
 DB $66;OUT DX,AX
 XCHG AX,BX
END;

Procedure ALShowPCI(Var Q:ArrayList;P:Word);Near;
Var
 First:Boolean;
 PC:^PCIInfo;
 nn:Byte;
 pp:Byte;
 Addr:Word;
 W:Systex.Window;
 OldShade:Boolean;
 I:Integer;
 L:LstMnu;
 LT:ListTitle;
 S:String;
 Data:Record
  ID:Word;
  ClassName:String;
 End;
 DataClass:Record
  ID:Byte;
  Name:String;
 End Absolute Data;

 Procedure InsertCmd(Const AS:String);Begin
  If Not(First)Then IncStr(S,',');
  AddStr(S,AS);
  First:=No;
 End;

Begin
 PC:=_ALGetBuf(Q,P);
 If(PC<>NIL)Then Begin
  WEInitO(W,76,22);
  WEPushWn(W);
  WEPutWnKrDials(W,'Device PCI');
  WEBar(W);
  WEPutTxtXY(W,0,1,'Vendeur: '+PC^.Vendor+' ('+HexWord2Str(PC^.VID)+'h)');
  WEPutTxtXY(W,0,2,'Device: '+PC^.Identificator+' ('+HexWord2Str(PC^.DID)+'h)');
  S:='Commande: '+HexWord2Str(PC^.Command.Value)+'h';
  If PC^.Command.Value>0Then Begin
   AddStr(S,' (');
   First:=True;
   If(cmdIOAccess)in(PC^.Command.Flags)Then InsertCmd('Accäs E/S');
   If(cmdMemoryAccess)in(PC^.Command.Flags)Then InsertCmd('Accäs MÇmoire');
   If(cmdBusMaster)in(PC^.Command.Flags)Then InsertCmd('BusMaster');
   If(cmdSpecialCycles)in(PC^.Command.Flags)Then InsertCmd('Cycles spÇcial');
   If(cmdMemWriteInvalidate)in(PC^.Command.Flags)Then InsertCmd('MemWrite+Invalidate');
   If(cmdVGAPaletteSnoop)in(PC^.Command.Flags)Then InsertCmd('VGA Palette Snoop');
   If(cmdParityErrorResponse)in(PC^.Command.Flags)Then InsertCmd('RÇponse d''erreur de Parity');
   If(cmdWaitCycles)in(PC^.Command.Flags)Then InsertCmd('Cycles d''attente');
   If(cmdSystemErrors)in(PC^.Command.Flags)Then InsertCmd('Erreurs systäme');
   If(cmdBackToBackTransactions)in(PC^.Command.Flags)Then InsertCmd('Transactions Back-To-Back');
   IncStr(S,')');
  End;
  WEPutTxtXY(W,0,3,S);
  S:='êtat: '+HexWord2Str(PC^.InfoTbl[7]shl 8+PC^.InfoTbl[6])+'h';
  If(PC^.InfoTbl[6]<>0)or(PC^.InfoTbl[7]<>0)Then Begin
   First:=True;
   AddStr(S,' (');
   If PC^.InfoTbl[6]and 16=16Then InsertCmd('Has Capabilities List');
   If PC^.InfoTbl[6]and 32=32Then InsertCmd('66MHz supportÇs');
   If PC^.InfoTbl[6]and 64=64Then InsertCmd('UDF');
   If PC^.InfoTbl[6]and 128=128Then InsertCmd('Supports Back-To-Back Trans.');
   If PC^.InfoTbl[7]and 1=1Then InsertCmd('Erreur de donnÇe de paritÇ');
   If PC^.InfoTbl[7]and 8=8Then InsertCmd('Signal de destination annuler');
   If PC^.InfoTbl[7]and 16=16Then InsertCmd('RÇception de destination annuler');
   If PC^.InfoTbl[7]and 32=32Then InsertCmd('RÇception principal annuler');
   If PC^.InfoTbl[7]and 64=64Then InsertCmd('Signal d''erreur systäme');
   If PC^.InfoTbl[7]and 128=128Then InsertCmd('DÇtection d''erreur de paritÇ');
   Case((PC^.InfoTbl[7]and 6)shr 1)of
    0:InsertCmd('Fast Timing');
    1:InsertCmd('Medium Timing');
    2:InsertCmd('Slow Timing');
    3:InsertCmd('Unknown Timing');
   End;
   AddStr(S,')');
  End;
  WEPutTxtXY(W,0,4,S);
  S:='RÇvision: '+HexByte2Str(PC^.InfoTbl[8])+'h';
  AddStr(S,', Type d''entàte '+HexByte2Str(PC^.InfoTbl[$E])+'h');
  AddStr(S,', Bus Latency '+HexByte2Str(PC^.InfoTbl[$D])+'h');
  WEPutTxtXY(W,0,5,S);
  S:='Teste de vÇrification: '+HexByte2Str(PC^.InfoTbl[$F])+'h (Teste de vÇrification ';
  If PC^.InfoTbl[$F]and$80=0Then AddStr(S,'non ');
  AddStr(S,'supportÇ');
  If PC^.InfoTbl[$F]and$80=$80Then Begin
   AddStr(S,': Code "Completion" '+HexByte2Str(PC^.InfoTbl[$F]and$F)+'h - ');
   If PC^.InfoTbl[$F]and$F=0Then Begin
    AddStr(S,'Correcte');
   End
    Else
   AddStr(S,'Çchec!!');
  End;
  AddStr(S,')');
  WEPutTxtXY(W,0,6,S);
  If PC^.InfoTbl[$C]<>0Then WEPutTxtXY(W,0,7,'Taille de ligne de cache: '+IntToStr(PC^.InfoTbl[$C]*4)+
                            ' octets ('+WordToStr(PC^.InfoTbl[$C])+' Double mots)');
  S:='Classe PCI ';
  DBOpenServerName(ChantalServer,'CHANTAL:/Materiel/PCI/Classe.Dat');
  If DBLocateAbs(ChantalServer,0,PC^.InfoTbl[$B],[])Then Begin
   DBReadRec(ChantalServer,DataClass);
   AddStr(S,DataClass.Name);
  End;
  AddStr(S,' Sous-classe ');
  DBOpenServerName(ChantalServer,'CHANTAL:/Materiel/PCI/SousClasse.Dat');
  If DBLocateAbs(ChantalServer,0,PC^.InfoTbl[$A],[])Then Begin
   DBReadRec(ChantalServer,Data);
   AddStr(S,Data.ClassName);
  End;
  AddStr(S,' Interface ');
  AddStr(S,HexWord2Str(PC^.InfoTbl[9])+'h');
  WEPutTxtXY(W,0,8,S);
  OldShade:=GetShade;
  SetShade(False);
  WESubList(W,0,11,wnMax,17,'',L);
  If(PC^.InfoTbl[$B]=01)and(PC^.InfoTbl[$A]=01)Then Begin
   S:='Fourniture du contrìleur PCI EIDE: BusMaster EIDE ';
   If PC^.InfoTbl[$9]and$80=0Then AddStr(S,'n''est ')
                             Else AddStr(S,'est ');
   AddStr(S,'supportÇ');
   WEPutTxtXY(W,0,9,S);
   If PC^.InfoTbl[$9]and 1=0Then Begin
    ALAddStr(L.List,StrUSpc('Primaire',12)+StrUSpc('Port d''EntrÇe/Sortie',23)+'01F0h');
    ALAddStr(L.List,StrUSpc('Primaire',12)+StrUSpc('Requàte d''Interruption',23)+'IRQ 14');
   End;
   If PC^.InfoTbl[$9]and 4=0Then Begin
    ALAddStr(L.List,StrUSpc('Secondaire',12)+StrUSpc('Port d''EntrÇe/Sortie',23)+'0170h');
    ALAddStr(L.List,StrUSpc('Secondaire',12)+StrUSpc('Requàte d''Interruption',23)+'IRQ 15');
   End;
  End;
 End;
 Begin
  Case(PC^.InfoTbl[$E]and$7F)of
   0:PP:=5;
   1:PP:=1;
   Else PP:=0;
  End;
  If PP>0Then For NN:=0to(PP)do Begin
   If PC^.InfoTbl[$10+(NN*4)]+PC^.InfoTbl[$11+(NN*4)]+
      PC^.InfoTbl[$12+(NN*4)]+PC^.InfoTbl[$13+(NN*4)]<>0Then Begin
    S:=StrUSpc(WordToStr(NN),12);
    If PC^.InfoTbl[$10+(NN*4)]and 1=1Then Begin
     AddStr(S,StrUSpc('Port EntrÇe/Sortie',23));
     Addr:=PC^.InfoTbl[$11+(NN*4)]shl 8+(PC^.InfoTbl[$10+(NN*4)]and$FC);
     AddStr(S,HexWord2Str(Addr)+'h');
    End
     Else
    Begin
     AddStr(S,StrUSpc('Plage mÇmoire',23));
     Addr:=PC^.InfoTbl[$13+(NN*4)]shl 8+PC^.InfoTbl[$12+(NN*4)];
     AddStr(S,HexWord2Str(Addr));
     Addr:=PC^.InfoTbl[$11+(NN*4)]shl 8+(PC^.InfoTbl[$10+(NN*4)]and$F0);
     AddStr(S,HexWord2Str(Addr)+'h');
     If PC^.InfoTbl[$10+(NN*4)]and 6=0Then AddStr(S,' (sous 4 Go');
     If PC^.InfoTbl[$10+(NN*4)]and 6=2Then AddStr(S,' (sous 1 Mo');
     If PC^.InfoTbl[$10+(NN*4)]and 6=4Then AddStr(S,' (sous 64-bits d''espace');
     If PC^.InfoTbl[$10+(NN*4)]and 6=6Then AddStr(S,' (rÇservÇ');
     If PC^.InfoTbl[$10+(NN*4)]and 8=8Then AddStr(S,', Prefetchable)')
                                  Else IncStr(S,')');
    End;
    ALAddStr(L.List,S);
   End;
  End;
  If PC^.InfoTbl[$3C]in[1..15]Then Begin
   S:=Spc(12)+StrUSpc('Requàte d''interruption',23)+'IRQ '+WordToStr(PC^.InfoTbl[$3C])+', INT ';
   If PC^.InfoTbl[$3D]=0Then IncStr(S,'-')
    Else
   Begin
    IncStr(S,'0');
    IncStr(S,Chr(PC^.InfoTbl[$3D]+64));
    IncStr(S,'h');
   End;
   ALAddStr(L.List,S);
  End;
  LMRefresh(L);
  SetShade(OldShade);
  LTInitWithWins(LT,0,11,W.MaxX,'Adresse|Type de ressource|Accäs',W);
  LTSetColumnSize(LT,0,12);
  LTSetColumnSize(LT,1,22);
  LTRefresh(LT);
  While WEOk(W)do;
 End;
End;

Function ALAddPCIInfo(Var InfoTbl:Array of Byte;Var Q:ArrayList;Var LM:LstMnu):Boolean;Near;
Var
 PCI:PCIInfo;
 DataDID:Record
  VID:Word;
  DID:Word;
  Name:String;
 End;
 DataVID:Record
  VID:Word;
  Name:String;
 End Absolute DataDID;
 VID:Word Absolute InfoTbl;
 ID:Record
  V:Word;
  D:Word;
 End Absolute InfoTbl;
Begin
 MoveLeft(InfoTbl,PCI,SizeOf(PCIInfo));
 DBOpenServerName(ChantalServer,'CHANTAL:/Materiel/PCI/VDI.Dat');
 ALAddPCIInfo:=Not DBLocateAbs(ChantalServer,0,VID,[]);
 DBReadRec(ChantalServer,DataVID);
 PCI.Vendor:=DataVID.Name;
 DBOpenServerName(ChantalServer,'CHANTAL:/Materiel/PCI/DID.Dat');
 DBFirst(ChantalServer);
 Repeat
  DBReadRec(ChantalServer,DataDID);
  If(DataDID.VID=VID)and(DataDID.DID=ID.D)Then Begin
   PCI.Identificator:=DataDID.Name;
   ALAddStr(LM.List,DataDID.Name);
   ALAddPCIInfo:=False;
   Break;
  End;
 Until DBEOF(ChantalServer);
 ALAddBlock(Q,SizeOf(PCIInfo),PCI);
End;

Procedure InfoPCI;
Var
 K:Word;
 Bus:Byte;
 DeviceId:Byte;
 Func:Byte;
 PCIHiBus:Byte;
 PCIVersion:Word;
 PCIChar:Byte;
 Info:Byte;
 Index:Word;
 Failed:Boolean;
 UseBios:Boolean;
 LR:ArrayList;
 LM:LstMnu;
 InfoTbl:Array[0..$FF]of Byte;
 VID:Word Absolute InfoTbl;
Begin
 ALInit(LR);
 UseBios:=Win>0;
 Failed:=True;
 If Not(Up32Bits)Then ErrMsgOk('Processeur 80386 minimum requis!')
  Else
 Begin
  ASM
   MOV AX,0B101h
   INT 01Ah
   JC @exit
   CMP DX,04350h
   JNE @exit
   MOV PCIChar,AL
   MOV PCIHiBus,CL
   MOV PCIVersion,BX
   MOV Failed,False
  @exit:
  END;
  If(Failed)Then ErrMsgOk('PCI non dÇtectÇ par le BIOS')
   Else
  Begin
   LMInitCenter(LM,60,15,'Device PCI',CurrKrs.Dialog.Env.List);
   For Bus:=0to(PciHiBus)do Begin
    For DeviceId:=0to$1F do Begin
     For Func:=0to 7do Begin
      Index:=0;
      Repeat
       If(UseBios)Then Info:=LookUpBios(DeviceId,Func,Bus,Index)
                  Else Info:=LookUpHardware(DeviceId,Func,Bus,Index);
       InfoTbl[Index]:=Info;
       Inc(Index);
       If Index=2Then If VID=$FFFFThen Index:=$100;
      Until Index=$100;
      If VID<>$FFFFThen Begin
       Failed:=ALAddPCIInfo(InfoTbl,LR,LM);
       If InfoTbl[$E]and$7F=0Then
        If(Func=0)and(InfoTbl[$E]and$80=0)Then Func:=7;
      End;
     End;
    End;
   End;
   LMRefresh(LM);
   Repeat
    K:=LMRunKbd(LM);
    If(K=kbEsc)Then Break;
    ALShowPCI(LR,K);
   Until False;
   LMDone(LM);
  End;
 End;
 ALDone(LR);
End;

END.