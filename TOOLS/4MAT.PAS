Program Format;

{$A-,F-,O-}

 (*Pr‚d‚finition:*)
{$I ..\Library\CPU\Intel\OpCode.Inc}
{$I ..\Library\Disk\Bios\Int13h.Inc}
{$I ..\Library\Disk\Bios\PhysData.Inc}
{$I ..\Library\Disk\Dos\LogData.Inc}
{$I ..\Library\System\Malte\Header.Inc}

 (*Fonctions et Proc‚dures:*)
{$I ..\Library\DskReset.Inc}
{$I ..\Library\FillClr.Inc}
{$I ..\Library\GetDrvType.Inc}
{$I ..\Library\GetIntVec.Inc}
{$I ..\Library\Intr.Inc}
{$I ..\Library\SetIntVec.Inc}

Const

  MaskBoot:Array[1..102]of Byte=
   ($EB,$35,                { 0000   JMP 0037        }
    ciNOP,                  { 0002   NOP             }
  {-- Donn‚es des BPB --------------------------------}
    $50,$43,$2D,$4D,$41,$4C,$54,$45,
    $00,$00,$00,$01,$00,$00,$00,$00,
    $00,$00,$00,$00,$00,$00,$00,$00,
    $00,$00,$00,$00,$00,$00,$00,$00,
    $00,$00,$00,$00,$00,$00,$00,$00,
    $00,$00,$00,$00,$00,$00,$00,$00,
    $00,$00,$00,$00,
  {-- Programme de chargement ----------------------}
    ciCLI,                 { 0037   CLI             }
    $B8,$30,$00,           { 0038   MOV     AX,0030 }
    $8E,$D0,               { 003B   MOV     SS,AX   }
    $BC,$FC,$00,           { 003D   MOV     SP,00FC }
    ciSTI,                 { 0040   STI             }
    ciPushCS,              { 0041   PUSH    CS      }
    ciPopDS,               { 0042   POP     DS      }
    $BE,$66,$7C,           { 0043   MOV     SI,7C66 }
    $B4,$0E,               { 0046   MOV     AH,0E   }
    ciCLD,                 { 0048   CLD             }
    ciLODSB,               { 0049   LODSB           }
    $0A,$C0,               { 004A   OR      AL,AL   }
    $74,$04,               { 004C   JZ      0052    }
    ciInt,$10,             { 004E   INT     10      }
    $EB,$F7,               { 0050   JMP     0049    }
    $B4,$01,               { 0052   MOV     AH,01   }
    ciInt,$16,             { 0054   INT     16      }
    $74,$06,               { 0056   JZ      005E    }
    $B4,$00,               { 0058   MOV     AH,00   }
    ciInt,$16,             { 005A   INT     16      }
    $EB,$F4,               { 005C   JMP     0052    }
    $B4,$00,               { 005E   MOV     AH,00   }
    ciInt,$16,             { 0060   INT     16      }
    $33,$D2,               { 0062   XOR     DX,DX   }
    ciInt,$19);            { 0064   INT     19      }

 BootMsg:String=#13#10'4MAT - (C) Les Chevaliers de Malte'#13#10+
       #13#10'Disquette non systŠme ou d‚fectueuse!'#13#10+
       'Veuillez changer de disquette et taper une touche'#13#10;

Var AktDrv:Byte;       { Num‚ro du lecteur … formater 0, 1 }
    AktDrvType:Byte;   { Type du lecteur de disquettes courant }
    PData:PhysDataType;{ Informations physiques de formatage }
    LData:LogDataType; { Informations logiques de formatage }
    AncDDPT:Pointer;   { Pointeur sur ancien DDPT }
    Ok:Bool;           { Drapeau pour ex‚cution du programme }
    EndCode:Word;      { Valeur retourn‚e au process appel‚ }
    Param:String;      { pour ‚valuation de la ligne de commande }

Function StrUp(S:String):String;Var I:Byte;SLen:Byte Absolute S;Begin
 For I:=1to(SLen)do S[I]:=UpCase(S[I]);
 StrUp:=S;
End;

Function Get4matParam(S:String;DrvType:Byte;Var PData:PhysDataType;Var LData:LogDataType):Bool;
Const DDPT360:DdptType=($DF,$02,$25,$02,$09,$2A,$FF,$50,$F6,$0F,$08);
      DDPT1200:DdptType=($DF,$02,$25,$02,$0F,$1B,$FF,$54,$F6,$0F,$08);
      DDPT720:DdptType=($DF,$02,$25,$02,$09,$2A,$FF,$50,$F6,$0F,$08);
      DDPT1440:DdptType=($DF,$02,$25,$02,$12,$1B,$FF,$6C,$F6,$0F,$08);
      LOG360:LogDataType=(Media:$FD;Cluster:2;FAT:2;RootSize:$70);
      LOG1200:LogDataType=(Media:$F9;Cluster:1;FAT:7;RootSize:$E0);
      LOG720:LogDataType=(Media:$F9;Cluster:2;FAT:3;RootSize:$70);
      LOG1440:LogDataType=(Media:$F0;Cluster:1;FAT:9;RootSize:$E0);
      PHYS360:PhysDataType=(Faces:2;Tracks:40;Sec:9;DDPT:@DDPT360);
      PHYS1200:PhysDataType=(Faces:2;Tracks:80;Sec:15; DDPT:@DDPT1200);
      PHYS1440:PhysDataType=(Faces:2;Tracks:80;Sec:18; DDPT:@DDPT1440);
      PHYS720:PhysDataType=(Faces:2;Tracks:80;Sec:9;DDPT:@DDPT720);
Begin
 Get4matParam:=Ya;
 If S='1200'Then
  If(DrvType=dtHD525)Then Begin PData:=PHYS1200;LData:=LOG1200;End
		     Else Get4matParam:=No
  Else
 If S='360'Then
  If(DrvType=dtHD525)or(DrvType=dtDD525)Then Begin PData:=PHYS360; LData:=LOG360; End
					Else Get4matParam:=No
  Else
 If S='1440'Then
  If(DrvType=dtHD35)Then Begin PData:=PHYS1440; LData:=LOG1440; End
		    Else Get4matParam:=No
  Else
 If S='720'Then
 Begin
  If StrUp(ParamStr(3))='/F'Then Begin PData:=PHYS720; LData:=LOG720; End Else
  If(DrvType=dtHD35)or(DrvType=dtDD35)Then Begin PData:=PHYS720; LData:=LOG720; End
				      Else Get4matParam:=No
 End
  Else
 Get4matParam:=No;
End;

Procedure InitDsk(Drive:Byte;PData:PhysDataType);Var _CH,_CL:Byte;Begin
 _CH:=PData.Tracks-1; _CL:=PData.Sec;
 ASM
  MOV AH,$18;
  MOV CL,_CL;
  MOV CH,_CH;
  MOV DL,Drive;
  INT $13;
 END;
End;

Function FormatTrack(Drv,Face,Track,Nm:Byte):Byte;
Type FormatTyp=Record DTrack,DFace,DI,DLen:Byte; End;
Var Regs:Registers; AreaData:Array[1..18]of FormatTyp; I,Try:Byte;
Begin
 For I:=1to(Nm)do With AreaData[I]do Begin;DTrack:=Track;DFace:=Face;DI:=I;DLen:=2;End;
 Try:=dTryMax;
 Repeat
  With Regs do Begin
   ah:=5;
   al:=Nm;
   es:=Seg(AreaData);
   bx:=Ofs(AreaData);
   dh:=Face;
   dl:=Drv;
   ch:=Track;
  End;
  Intr($13,Regs);
  If Regs.flags and fcarry=1Then DskReset;
  Dec(Try);
 Until(Regs.flags and fcarry=0)or(Try=0);
 Formattrack:=Regs.ah;
End;

Function VerifyTrack(Lecteur,Face,Piste,Secteurs:Byte):Byte;
Var Try:Byte; Regs:Registers; TamponPiste:TrackBufType;
Begin
 Try:=dTryMax;
 Repeat
  With Regs do Begin
   ah:=$04;              { Num‚ro de fonction pour appel interruption }
   al:=Secteurs;         { Nombre Secteurs par Piste }
   ch:=Piste;            { Num‚ro de Piste }
   cl:=1;                { Commencer par le secteur 1 }
   dl:=Lecteur;          { Num‚ro de lecteur }
   dh:=Face;             { Num‚ro de la face }
   es:=Seg(TamponPiste); { Adresse du tampon }
   bx:=Ofs(TamponPiste);
  End;
  Intr($13,Regs);
  If Regs.flags and fcarry=1Then DskReset;
  Dec(Try);
 Until(Regs.flags and fcarry=0)or(Try=0);
 VerifyTrack:=Regs.ah;
End;

Function WriteTrack(Lecteur,Face,Piste,Start,Nombre:Byte;Var Buffer):Byte;
Var Essais:Byte;Regs:Registers;Begin
 essais:=dTryMax;
 Repeat
  With Regs do Begin
   ah:=$03;        { Num‚ro de fonction pour appel interruption }
   al:=Nombre;     { Nombre Secteurs par Piste }
   ch:=Piste;      { Num‚ro de Piste }
   cl:=Start;      { Commencer par le secteur 1 }
   dl:=Lecteur;    { Num‚ro de lecteur }
   dh:=Face;       { Num‚ro de la face }
   es:=Seg(Buffer);{ Adresse pour tampon }
   bx:=Ofs(Buffer);
  End;
  Intr($13,Regs);
  If Regs.flags and fcarry=1Then DskReset;
  Dec(essais);
 Until(Regs.flags and fcarry=0)or(Essais=0);
 WriteTrack:=Regs.ah;
End;

Function Phys4mat(Drv:Byte;PData:PhysDataType;Verify:Bool):Bool;Var Try,T,F,Status:Byte;Begin
 For T:=0to PData.Tracks-1do For F:=0to PData.Faces-1do Begin
  Write(#13'Piste: ',T:2,'  Face: ',F:2);
  Try:=dTryMax;
  Repeat
   Status:=FormatTrack(Drv,F,T,PData.Sec);
   If Status=3Then Begin
    Phys4mat:=No;
    WriteLn;
    WriteLn('Disquette prot‚g‚e contre l''‚criture');
    Exit;
   End;
   If(Status=0)and Verify Then
   Status:=VerifyTrack(Drv,F,T,PData.Sec);
   Dec(Try);
   If Status>0Then DskReset;
  Until(Status=0)or(Try=0);
  If Status>0Then Begin
   Phys4mat:=No;
   WriteLn;
   WriteLn('Erreur de Piste?');
   Exit;
  End;
 End;
 Phys4mat:=Ya;
End;

Function Logical4mat(Drive:Byte;PData:PhysDataType;LData:LogDataType):Bool;
Var Status:Byte;NmSec:Wd;I,AktSec,AktSide,AktTrack:Byte;Nm:Int;TrackBuf:TrackBufType;Begin
 FillClr(TrackBuf,Word(PData.Sec)*512);{Vide tampon}
  { Secteur de boot: Partie fixe }
 System.Move(Maskboot,TrackBuf,102);
 System.Move(BootMsg[1],TrackBuf[1,103],Byte(BootMsg[0]));
 TrackBuf[1,511]:=$55;
 TrackBuf[1,512]:=$AA;
  { Secteur de boot: Partie variable }
 NmSec:=PData.Tracks*PData.Sec*Pdata.Faces;
 TrackBuf[1,12]:=Lo(512);
 TrackBuf[1,13]:=Hi(512);
 TrackBuf[1,14]:=LData.Cluster;  { Longueur Cluster }
 TrackBuf[1,18]:=LData.RootSize; { Nombre Entr‚es ds r‚p.rac. }
 TrackBuf[1,20]:=lo(NmSec);      { Nombre total de secteur }
 TrackBuf[1,21]:=hi(NmSec);      { sur la disquette }
 TrackBuf[1,22]:=LData.Media;    { descripteur support }
 TrackBuf[1,23]:=LData.FAT;      { Longueur des FAT }
 TrackBuf[1,25]:=PData.Sec;      { Secteurs par piste }
 TrackBuf[1,27]:=PData.Faces;    { Nombre de faces }
  { Cr‚er FAT et sa copie (contient 00) }
 TrackBuf[2,1]:=LData.Media;
 TrackBuf[2,2]:=$FF;
 TrackBuf[2,3]:=$FF;
 TrackBuf[LData.FAT+2,1]:=LData.Media;
 TrackBuf[LData.FAT+2,2]:=$FF;
 TrackBuf[LData.FAT+2,3]:=$FF;
 Status:=WriteTrack(Drive,0,0,1,PData.Sec,TrackBuf);
 If Status<>0Then Logical4mat:=No
  else
 Begin
  FillClr(TrackBuf,512);
  AktSec:=PData.Sec; AktTrack:=0; AktSide:=0;
  Nm:=LData.FAT*2+(LData.Rootsize*32div 512)+1-PData.Sec; I:=1;
  Repeat
   Inc(AktSec);
   If(AktSec>PData.Sec)Then Begin
    AktSec:=1; Inc(AktSide);
    If(AktSide=PData.Faces)Then Begin AktSide:=0; Inc(AktTrack); End;
   End;
   Status:=WriteTrack(Drive,AktSide,AktTrack,AktSec,1,TrackBuf);
   Inc(i);
  Until(i>Nm)or(Status<>0);
  Logical4mat:=Status=0;
 End;
End;

BEGIN
 WriteLn('4MAT Version 1.0  Tous droits r‚serv‚s aux Chevaliers de Malte');
 WriteLn;
 If ParamCount>1Then Begin
  Param:=ParamStr(1); AktDrv:=Byte(UpCase(Param[1]))-65;
  AktDrvType:=GetDrvType(AktDrv);
  If AktDrvType>0Then Begin
   If Get4matParam(ParamStr(2),AktDrvType,PData,LData)Then Begin
    InitDsk(AktDrv,PData);
    GetIntVec($1E,AncDDPT);
    SetIntVec($1E,PData.DDPT);
    Param:=ParamStr(3); Ok:=Phys4mat(AktDrv,PData,UpCase(Param[1])<>'N');
    If(Ok)Then Begin
     WriteLn;
     Writeln('Ecriture du secteur de boot et des FAT ');
     Ok:=Logical4mat(AktDrv,PData,LData)
    End;
    If(Ok)Then Begin
     WriteLn;
     WriteLn('Formatage S.V.P.');
     EndCode:=0;
    End
     else
    Begin
     WriteLn;
     WriteLn('Une erreur a interrompu le formatage');
     EndCode:=1;
    End;
    SetIntVec($1E,AncDDPT);
   End
    else
   Begin
    WriteLn('Le format demand‚ ne peut ˆtre utilis‚ sur ce lecteur!');
    EndCode:=2;
   End
  End
   else
  Begin
   WriteLn('Le lecteur de disquettes demand‚ n''existe pas');
   EndCode:=3;
  End
 End
  else
 Begin
  Writeln('Syntaxe: 4MAT [A:|B:] [360|720|1200|1440] [NV] [/F]');
  WriteLn;
  Writeln('         NV  Pas de v‚rification');
  Writeln('         /F  Force … utiliser ce format');
  EndCode:=4;
 End;
 Halt(EndCode);
END.