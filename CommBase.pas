{$I DEF.INC}

Unit CommBase;

INTERFACE

Uses Systex;

{$IFNDEF __Windows__}
 Const
  ComBase:Array[1..MaxComPorts]of Word=($3F8,$2F8,$3E8,$2E8,$4220,$4228,$5220,$5228);
  ComIrq:Array[1..MaxComPorts]of Byte=(4,3,4,3,4,3,4,3);
  ComInt:Array[1..MaxComPorts]of Byte=($C,$B,$C,$B,$C,$B,$C,$B);
  ModemCmdDelay:Word=10;
  ModemInit:PChr=NIL;
  ModemDial:PChr=NIL;
  ModemDialEnd:PChr=NIL;
  ModemAnswer:PChr=NIL;
  DefModemHostSet:PChrDefModemHostSet=cmDefModemHostSet+#0;
  ModemHostSet:PChr=PChr(@DefModemHostSet);
  DefModemHostUnSet:PChrDefModemHostUnSet=cmDefModemHostUnSet+#0;
  ModemHostUnSet:PChr=PChr(@DefModemHostUnSet);
  ModemBusy:PChr=NIL;
  ModemConnect:PChr=NIL;
  ModemNoCarrier:PChr=NIL;
  PrefixStr:PChr=NIL;
  PostfixStr:PChr=NIL;
  FKCR:Char='|';
  FKDelay:Char='~';
  FKCtrlMark:Char='^';
  FKScriptCh:Char='@';
  FKDelayTime:Integer=10;
  DataBits:Byte=8;
  Parity:Char='N';
  StopBits:Byte=1;
  CommPort:Byte=1;
  BaudRate:Word=2400;
  CmdLnPort:Byte=4;
  DefModemEsc:Array[0..Length('+++')]of Char='+++'#0;
  ModemEsc:PChr=PChr(@DefModemEsc);
  ModemEscTime:Integer=1500;
  ModemHangUp:PChr=NIL;
  AsyncDoCTS:Boolean=False;
  AsyncDoDSR:Boolean=False;
  AsyncHardWiredOn:Boolean=False;
  AsyncBrkLen:Integer=500;
  AsyncDoXonXoff:Boolean=True;
  AsyncOVXonXoff:Boolean=True;
  AsyncBufLen:Integer=4096;
  AsyncOBufLen:Integer=1132;

 Var
  aBufPtr,aOBufPtr:AsyncPtr;
   { Ne pas changer l'ordre...}
  aOpenFlag,aBufOverflow,aOBufOverflow,aXOFFSent,aSenderOn,
  aSendXOFF_,aXOFFReceived,aXOFFRecDisp,aXONRecDisp:Boolean;
  aLnStatus,aMdmStatus,aLnErrFlags:Byte;
  aBufUsed,aMaxBufUsed,aBufHead,aBufTail,aOBufUsed,aMaxOBufUsed,
  aOBufHead,aOBufTail,aUartIER,aUartIIR,aUartMSR,aUartLSR,aUartMCR,
  aOutDelay, { A partir d'ici ‡a va...}
  aPort,aBase,aRS232,aBufNewTail,aBufSize,aOBufSize,a1MSDelay,
  aOBufNewTail,aBufLow,aBufHigh,aBufHigh2:Integer;
  aBaudRate:Word;           { Nombre de baud }
  aSaveIAddr:Pointer;       { Adresse de l'ancienne interruption }
  aIrq,aInt:Byte;           { Num‚ro de l'IRQ et de l'Interruption }
{$ENDIF}

{$IFNDEF __Windows__}
 Function  ACBufChk:Boolean;
 Function  ACCarrierDetect:Boolean;
 Function  ACCarrierDrop:Boolean;
 Procedure ACClose(DropDTR:Boolean);
 Procedure ACClrErrs;
 Procedure ACDrainOutBuf(MaxWaitTime:Integer);
 Procedure ACFlushOutBuf;
 Function  ACLnErr(Var ErrFlags:Byte):Boolean;
 Function  ACOpen(ComPort:Integer;BaudRate:Word;Parity:Char;WdSize,StopBits:Integer):Boolean;
 Function  ACPeek(Nchars:Integer):Char;
 Function  ACPortAddrGiven(ComPort:Integer):Boolean;
 Procedure ACPurgeBuf;
 Function  ACReceive(Var C:Char):Boolean;
 Procedure ACReceiveWithTimeout(Secs:Integer;Var C:Integer);
 Procedure ACReleaseBufs;
 Procedure ACResetPort(ComPort:Integer;BaudRate:Word;Parity:Char;WdSize,StopBits:Integer);
 Function  ACRingDetect:Boolean;
 Procedure ACSend(C:Char);
 Procedure ACSendACK;
 Procedure ACSendBrk;
 Procedure ACSendBS;
 Procedure ACSendCAN;
 Procedure ACSendCR;
 Procedure ACSendDLE;
 Procedure ACSendEOT;
 Procedure ACSendFFh;
 Procedure ACSendNAK;
 Procedure ACSendNow(C:Char);
 Procedure ACSendNowXOFF;
 Procedure ACSendNowXON;
 Procedure ACSendNUL;
 Procedure ACSendSOH;
 Procedure ACSendStr(Const S:String);
 Procedure ACSendStr2Com(Const S:String;Num:Byte);
 Procedure ACSendStrWithDelays(Const S:String;CharDelay,EOSDelay:Integer);
 Procedure ACSendSUB;
 Procedure ACSendSYN;
 Procedure ACSendXOFF;
 Procedure ACSendXON;
 Procedure ACSetupPort(ComPort,BaseAddr,IRQLine,IntNumb:Integer);
 Procedure ACStuff(Ch:Char);
 Procedure ACTermReady(X:Boolean);
 Function  ACWait4Quiet(MaxWait,WaitTime:LongInt):Boolean;
 Procedure BiosRS232Init(ComPort:Integer;ComParm:Word);
 Procedure ClrXoffReceived;
 Procedure InitAC(BufMax,OBufMax,HighLev1,HighLev2,LowLev:Integer);
 Procedure SendModemCmd(Const ModemText:String);
{$ENDIF}

IMPLEMENTATION

Uses Time,Memories,Systems;

{$IFNDEF __Windows__}
 Procedure ACIsr(Flags,CS,IP,AX,BX,CX,DX,SI,DI,DS,ES,BP:Word);Interrupt;Forward;
{$ENDIF}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Fonction ACBufChk                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de d‚terminer si le tampon d'arriŠre plan de la
 communication par modem (asynchrone)  contient encore de l'information
 (True) o— qu'elle est vide (False).


 Remarque
 ÍÍÍÍÍÍÍÍ

  ş Cette fonction doit ˆtre  appel‚ aprŠs le processus  d'Installation
    de la  communication  par  modem  (Asynchrone):  ®InitAC¯  sinon le
    r‚sultat probant risque d'ˆtre fauss‚.
}

{$IFNDEF __Windows__}
 Function ACBufChk:Boolean;Assembler;ASM
  MOV AL,0
  MOV BX,aBufHead
  MOV CX,aBufTail
  CMP BX,CX
  JE @End
  MOV AL,1
 @End:
 END;
{$ENDIF}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Fonction ACCarrierDetect                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de savoir si une communication par modem (asychrone)
 est d‚tect‚ (qu'il est en-ligne (®online¯)).  ®Ya¯ pour ®OnLine¯, ®No¯ pour
 OffLine.


 Remarque
 ÍÍÍÍÍÍÍÍ

  ş Cette fonction  ˆtre  appel‚  aprŠs  le processus  d'Installation  de la
    communication par modem (Asynchrone):  ®InitAC¯ sinon le r‚sultat risque
    d'ˆtre fauss‚ et dans les cas extrˆmes on pourra assister … un plantage.
}

{$IFNDEF __Windows__}
 Function ACCarrierDetect:Boolean;Assembler;ASM
  MOV DX,aBase
  ADD DX,uaMsr
  IN AL,DX
  ROL AL,1
  AND AL,1
  OR AL,AsyncHardWiredOn
 END;
{$ENDIF}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Fonction ACCarrierDrop                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de savoir si on a raccroch‚ le t‚l‚phone (OffLine).
 Elle est l'oppos‚ exacte de la fonction ®ACCarrierDetect¯.  Ainsi, dans de
 nombreux terminal,  lorsqu'on affiche  ®NO CARRIER¯  c'est par l'entremise
 d'une fonction similaire … celle-ci qu'on le d‚duit...


 Remarque
 ÍÍÍÍÍÍÍÍ

  ş Cette fonction  ˆtre  appel‚  aprŠs  le processus  d'Installation de la
    communication par modem (Asynchrone): ®InitAC¯ sinon le r‚sultat risque
    d'ˆtre fauss‚  et  dans  les  cas  extrˆmes  on  pourra  assister  … un
    plantage.
}

{$IFNDEF __Windows__}
 Function ACCarrierDrop:Boolean;Assembler;ASM
  PUSH CS
  CALL Near Ptr ACCarrierDetect
  XOR AL,1
 END;
{$ENDIF}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                             Fonction ACClose                           Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure ferme la p‚riph‚rique de communication par modem de style
 asychrone ayant ‚t‚ pr‚c‚d‚ment ouvert par la fonction ®ACOpen¯.
}

{$IFNDEF __Windows__}
 Procedure ACClose(DropDTR:Boolean);Begin
  If(aOpenFlag)Then Begin
   ASM
    CLI
    MOV DX,I8088IMR
    MOV BL,1
    MOV CL,aIrq
    SHL BL,CL
    IN  AL,DX
    OR  AL,BL
    OUT DX,AL
    MOV DX,aBase
    MOV BX,DX
    ADD DX,uaIER
    MOV AL,0
    OUT DX,AL
    MOV AL,DropDtr
    XOR AL,1
    MOV DX,BX
    ADD DX,uaMCR
    OUT DX,AL
    STI
    MOV CL,False
    MOV aOpenFlag,CL
    MOV aXOFFSent,CL
    MOV aSenderOn,CL
   END;
   SetIntVec(aInt,aSaveIaddr)
  End
 End;
{$ENDIF}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                             Fonction ACClrErrs                          Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure ‚limine les erreurs d'op‚rations ayant eu lieu et en cours
 de la communication par modem: asychrone.
}

{$IFNDEF __Windows__}
 Procedure ACClrErrs;Assembler;ASM
  CLI
  MOV BX,aBase
  MOV DX,BX
  ADD DX,uaLCR
  IN  AL,DX
  AND AL,$7F
  OUT DX,AL
  MOV DX,BX
  ADD DX,uaLSR
  IN  AL,DX
  MOV DX,BX
  ADD DX,uaRBR
  IN  AL,DX
  MOV DX,I8088IMR
  MOV CH,1
  MOV CL,aIrq
  SHL CH,CL
  XOR CH,0FFh
  IN  AL,DX
  AND AL,CH
  OUT DX,AL
  MOV DX,BX
  ADD DX,uaMCR
  IN  AL,DX
  OR  AL,0Bh
  OUT DX,AL
  MOV DX,BX
  ADD DX,uaIER
  MOV AL,0Fh
  OUT DX,AL
  MOV AL,020h
  OUT 020h,AL
  STI
 END;
{$ENDIF}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Fonction ACDrainOutBuf                     Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure reste en attente maximal  d‚finit par la variable de
 param‚trage ®MaxWaitTimeOut¯ pour l'envoie de caractŠres du tampon de
 l'asychrone pour lib‚rer celui-ci de son contenu...
}

{$IFNDEF __Windows__}
 Procedure ACDrainOutBuf(MaxWaitTime:Integer);
 Var
  T1:LongInt;
 Begin
  T1:=TimeOfDay;
  While(aOBufHead<>aOBufTail)and(TimeDiff(T1,TimeOfDay)<=MaxWaitTime)do
 End;
{$ENDIF}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Proc‚dure ACFlushOutBuf                      Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure vide complŠtement sans attente le contenu totalement du
 tampon r‚serv‚ … l'asychrone.
}

{$IFNDEF __Windows__}
 Procedure ACFlushOutBuf;Assembler;ASM
  XOR AX,AX
  MOV aOBufUsed,AX
  MOV AX,aOBufTail
  MOV aOBufHead,AX
 END;
{$ENDIF}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Fonction ACLnErr                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction indique si la ligne d'‚tat contient des erreurs...
}

{$IFNDEF __Windows__}
 Function ACLnErr(Var ErrFlags:Byte):Boolean;Assembler;ASM
  MOV BL,0
  MOV AL,aLnErrFlags
  LES DI,ErrFlags
  MOV ES:[DI],AL
  CMP AL,BL
  JNE @End
  MOV AL,True
 @End:
  MOV aLnErrFlags,BL
 END;
{$ENDIF}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                             Fonction ACOpen                          Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction d‚finit la communication avec un modem particulier, fixe
 c'est paramŠtre initaux pour acc‚der aux possibilit‚es  de ces fonctions
 parentes si vous suivez le sens de l'explication...
}

{$IFNDEF __Windows__}
 Function ACOpen(ComPort:Integer;BaudRate:Word;Parity:Char;
                 WdSize,StopBits:Integer):Boolean;
 Var
  _AL:Byte;
 Begin
  If(aOpenFlag)Then ACClose(False);
  If ComPort<1Then ComPort:=1 else
  If(ComPort>MaxComPorts)Then ComPort:=MaxComPorts;
  aPort:=ComPort;
  aBase:=ComBase[ComPort];
  aIrq:=ComIrq[ComPort];
  aInt:=ComInt[ComPort];
  ASM
   MOV DX,aBase
   MOV AX,DX
   ADD AX,uaIER
   MOV aUartIER,AX
   MOV AX,DX
   ADD AX,uaMCR
   MOV aUartMCR,AX
   MOV AX,DX
   ADD AX,uaMSR
   MOV aUartMSR,AX
   MOV AX,DX
   ADD AX,uaLSR
   MOV aUartLSR,AX
   ADD DX,uaIIR
   MOV aUartIIR,DX
   IN  AL,DX
   AND AL,$F8
   MOV _AL,AL
 @@1:
  END;
  If _AL<>0Then ACOpen:=False
   Else
  Begin
   GetIntVec(aInt,aSaveIaddr);
   SetIntVec(aInt,@ACIsr);
   ACResetPort(ComPort,BaudRate,Parity,WdSize,StopBits);
   ACOpen:=True;
   aOpenFlag:=True
  End;
 End;
{$ENDIF}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                              Fonction ACPeek                            Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet d'extraire le dernier caractŠre re‡u contenu dans le
 tampon et en cas d'inexistance, un code ASCII 0 est retourn‚.
}

{$IFNDEF __Windows__}
 Function ACPeek(Nchars:Integer):Char;
 Var
  I:Integer;
 Begin
  I:=(aBufTail+NChars)mod aBufSize;
  If(I>aBufHead)Then ACPeek:=#0
                Else ACPeek:=aBufPtr^[I]
 End;
{$ENDIF}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Fonction ACPortAddrGiven                   Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction indique si le port concern‚ existe ou non. Le port doit
 avoir un num‚ro comment par 1 pour COM1:, 2 pour COM2:, 3 pour COM3: et
 4 pour COM4:.
}

{$IFNDEF __Windows__}
 Function ACPortAddrGiven(ComPort:Integer):Boolean;Assembler;ASM
  XOR AX,AX
  MOV BX,ComPort
  CMP BX,AX
  JE  @End
  CMP BX,MaxComPorts
  JA  @End
  DEC BX
  SHL BX,1
  MOV CX,040h
  MOV ES,CX
  MOV CX,ES:[BX]
  CMP CX,AX
  JE  @End
  MOV AL,True
 @End:
 END;
{$ENDIF}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Fonction ACPurgeBuf                          Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure ‚limine tous les caractŠres contenu dans le tampon et en
 attente de r‚ception.
}

{$IFNDEF __Windows__}
 Procedure ACPurgeBuf;
 Var
  C:Char;
  L:Integer;
 Begin
  L:=10000div aBaudRate;
  If L<=0Then L:=3;
  Repeat
   _Delay(L)
  Until Not ACReceive(C)
 End;
{$ENDIF}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Fonction ACReceive                          Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction indique si un caractŠre est en attente d'ˆtre re‡u et si
 oui le met dans la variable de param‚trage.
}

{$IFNDEF __Windows__}
 Function ACReceive(Var C:Char):Boolean;Assembler;ASM
  MOV AX,aBufTail
  CMP AX,aBufHead
  JNE @1
  LES DI,C
  XOR AX,AX
  MOV ES:[DI],AL
  JMP @End
@1:
  LES DI,aBufPtr
  ADD DI,AX
  MOV BL,ES:[DI]
  LES DI,C
  MOV ES:[DI],BL
  INC AX
  CMP AX,aBufSize
  JLE @2
  XOR AX,AX
@2:
  MOV aBufTail,AX
  MOV AX,aBufUsed
  DEC AX
  MOV aBufUsed,AX
  TEST aSenderOn,1
  JNZ @6
  CMP AX,aBufLow
  JG  @6
  TEST aXOffSent,1
  JZ  @3
  PUSH CS
  CALL Near Ptr ACSendXON
  MOV aXOffSent,0
@3:
  TEST AsyncDoCts,1
  JZ  @4
  MOV DX,aUartMCR
  IN  AL,DX
  OR  AL,uaRTS
  OUT DX,AL
@4:
  TEST AsyncDoDsr,1
  JZ  @5
  MOV DX,aUartMCR
  IN  AL,DX
  OR  AL,uaDTR
  OUT DX,AL
@5:
  MOV aSenderOn,1
@6:
  MOV AX,1
@End:
  AND aLnStatus,0FDh
 END;
{$ENDIF}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                       Proc‚dure ACReceiveWithTimeOut                    Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure re‡oie un caractŠre avec une attente de r‚ception s'il n'y
 en a pas en attente.
}

{$IFNDEF __Windows__}
 Procedure ACReceiveWithTimeout(Secs:Integer;Var C:Integer);Assembler;ASM
  MOV AX,aBufTail
  CMP AX,aBufHead
  JNE @1
  MOV AX,Secs
  {$IFOPT G+}
   SHL AX,10
  {$ELSE}
   MOV CX,10
   SHL AX,CL
  {$ENDIF}
  MOV CX,AX
@D:
  PUSH CX
   MOV CX,a1MSDelay
@D1:
   LOOP @D1
  POP CX
  MOV AX,aBufTail
  CMP AX,aBufHead
  JNE @1
  LOOP @D
  MOV BX,TimeOut
  LES DI,C
  MOV ES:[DI],BX
  JMP @End
@1:
  LES DI,aBufPtr
  ADD DI,AX
  MOV BL,ES:[DI]
  XOR BH,BH
  LES DI,C
  MOV ES:[DI],BX
  INC AX
  CMP AX,aBufSize
  JLE @2
  XOR AX,AX
@2:
  MOV aBufTail,AX
  MOV AX,aBufUsed
  DEC AX
  MOV aBufUsed,AX
  TEST aSenderOn,1
  JNZ @End
  CMP AX,aBufLow
  JG  @End
  TEST aXOffSent,1
  JZ  @3
  PUSH CS
  CALL Near Ptr ACSendXON
  MOV aXOffSent,0
@3:
  TEST AsyncDoCts,1
  JZ  @4
  MOV DX,aUartMCR
  IN  AL,DX
  OR  AL,uaRTS
  OUT DX,AL
@4:
  TEST AsyncDoDsr,1
  JZ  @5
  MOV DX,aUartMCR
  IN  AL,DX
  OR  AL,uaDTR
  OUT DX,AL
@5:
  MOV aSenderOn,1
@End:
  AND aLnStatus,0FDh
 END;
{$ENDIF}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Proc‚dure ACReleaseBufs                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure libŠre la m‚moire utilis‚ par les tampon de communication
 par modem: Asychrone. Il ferme en plus la communication si elle est encore
 ouverte.
}

{$IFNDEF __Windows__}
 Procedure ACReleaseBufs;Begin
  If(aOpenFlag)Then ACClose(False);
  FreeMemory(aBufPtr,aBufSize+1);
  FreeMemory(aOBufPtr,aOBufSize+1)
 END;
{$ENDIF}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                    Proc‚dure ACResetPort                    Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure r‚initialise les paramŠtres de l'auxiliaire de
 communication par modem: Asychrone.
}

{$IFNDEF __Windows__}
 Procedure ACResetPort(ComPort:Integer;BaudRate:Word;Parity:Char;WdSize,StopBits:Integer);
 Const
  ACNumBauds=11;
  ACBdTable:Array[1..ACNumBauds]of Record
   Baud:Word;
   Bits:Byte;
  End=(
   (Baud:110;Bits:$00),
   (Baud:150;Bits:$20),
   (Baud:300;Bits:$40),
   (Baud:600;Bits:$60),
   (Baud:1200;Bits:$80),
   (Baud:2400;Bits:$A0),
   (Baud:4800;Bits:$C0),
   (Baud:9600;Bits:$E0),
   (Baud:19200;Bits:$E0),
   (Baud:38400;Bits:$E0),
   (Baud:57600;Bits:$E0)
  );
 Var
  I,M,ComParm:Integer;
 Begin
  If(BaudRate>ACBdTable[ACNumBauds].Baud)Then BaudRate:=ACBdTable[ACNumBauds].Baud else
  If(BaudRate<ACBdTable[1].Baud)Then BaudRate:=ACBdTable[1].Baud;
  aBaudRate:=BaudRate; I:=0;
  Repeat
   Inc(I)
  Until(I>=ACNumBauds)or(BaudRate=ACBdTable[I].Baud);
  ComParm:=ACBdTable[I].Bits;
  Parity:=UpCase(Parity);
  ASM
   OR ComParm,08h
  END;
  If Parity='E'Then ASM
   OR ComParm,010h
  END;
  ASM
   MOV BX,WdSize
   SUB BX,5
   CMP BX,1
   JE  @SetWdSize3
   CMP BX,2
   JNE @EndWdSize
@SetWdSize3:
   MOV BX,3
@EndWdSize:
   MOV WdSize,BX
   MOV AX,ComParm
   OR  AX,WdSize
   CMP StopBits,2
   JNE @Next2
   OR  AX,4
@Next2:
   MOV ComParm,AX
   MOV DX,ComPort
   DEC DX
   INT 014h
  END;
  If BaudRate>=19200Then ASM
   MOV DX,aBase
   MOV BX,DX
   ADD DX,uaLCR
   PUSH DX
    IN  AL,DX
    OR  AL,080h
    OUT DX,AL
    MOV AX,115200 and $FFFF
    MOV DX,115200 shr 16
    DIV BaudRate
    MOV DX,BX
    ADD DX,uaTHR
    OUT DX,AL
    MOV DX,BX
    ADD DX,uaIER
    MOV AL,0
    OUT DX,AL
   POP DX
   IN  AL,DX
   AND AL,07Fh
   OUT DX,AL
  END;
  ASM
   MOV AL,Parity
   MOV CX,038h
   CMP AL,'S'
   JE  @Parity
   CMP AL,'M'
   JNE @End
   MOV CX,028h
 @Parity:
   MOV DX,aBase
   ADD DX,uaLCR
   IN  AL,DX
   MOV AL,080h
   OUT DX,AL
   MOV BX,StopBits
   DEC BX
   {$IFOPT G+}
    SHL BX,2
   {$ELSE}
    SHL BX,1
    SHL BX,1
   {$ENDIF}
   MOV AX,WdSize
   OR  AX,BX
   OR  AX,CX
   OUT DX,AX
 @End:
   MOV aSenderOn,True
   PUSH CS
   CALL Near Ptr ACClrErrs
  END
 End;
{$ENDIF}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Fonction ACRingDetect                    Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction indique  que le t‚l‚phone sonne actuellement.  Elle
 s'applique bien entendu sur la communication par modem actuellement
 en cours et non pas … tous les modems...
}

{$IFNDEF __Windows__}
 Function ACRingDetect:Boolean;Assembler;ASM
  MOV DX,aBase
  ADD DX,uaMSR
  IN  AL,DX
  {$IFOPT G+}
   SHR AL,6
  {$ELSE}
   MOV CL,6
   SHR AL,CL
  {$ENDIF}
  AND AL,1
 END;
{$ENDIF}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                            Proc‚dure ACSend                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure envoie le caractŠre de la variable de param‚trage dans
 l'asychrone courant.
}

{$IFNDEF __Windows__}
 Procedure ACSend(C:Char);Assembler;ASM
  MOV BX,aOBufHead
  LES DI,aOBufPtr
  ADD DI,BX
  MOV DX,BX
  INC BX
  CMP BX,aOBufSize
  JLE @1
  XOR BX,BX
 @1:CMP BX,aOBufTail
  JNE @4
  MOV CX,aOutDelay
 @2:PUSH CX
   MOV CX,a1MSDelay
 @3:LOOP @3
  POP CX;
  CMP BX,aOBufTail
  JNE @4
  LOOP @2
  MOV aOBufOverflow,1
  JMP @5
 @4:MOV aOBufHead,BX
  MOV AL,C
  MOV ES:[DI],AL
  MOV AX,aOBufUsed
  INC AX
  MOV aOBufUsed,AX
  CMP AX,aMaxOBufUsed
  JLE @5
  MOV aMaxOBufUsed,AX
 @5:MOV DX,aUartIER
  IN  AL,DX
  TEST AL,2
  JNZ @6
  OR  AL,2
  OUT DX,AL
 @6:
 END;
{$ENDIF}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Proc‚dure ACSendACK                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure envoie un caractŠre ®ACK¯ … la communication par modem:
 asynchrone.
}

{$IFNDEF __Windows__}
 Procedure ACSendACK;External;
 {$L ACSENDX.OBJ }
{$ENDIF}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Proc‚dure ACSendBrk                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure envoie une signal d'arrˆt … la communication par modem:
 asynchrone.
}

{$IFNDEF __Windows__}
 Procedure ACSendBrk;
 Var
  OldLcr:Byte;
 Begin
  ASM
   MOV DX,aBase
   ADD DX,uaLCR
   IN  AL,DX
   MOV OldLcr,AL
   AND AL,$7F
   OR  AL,$40
   OUT DX,AL
  END;
  Delay(AsyncBrkLen*10);
  ASM
   MOV DX,aBase
   ADD DX,uaLCR
   MOV AL,OldLcr
   OUT DX,AL
  END
 End;
{$ENDIF}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Proc‚dure ACSendBS                          Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure envoie un caractŠre ®BackSpace¯ … la communication par
 modem: asynchrone.
}

{$IFNDEF __Windows__}
 Procedure ACSendBS;External;
{$ENDIF}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                       Proc‚dure ACSendCAN                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure envoie un caractŠre ®CANCEL¯ … la communication par
 modem: asynchrone.
}

{$IFNDEF __Windows__}
 Procedure ACSendCAN;External;
{$ENDIF}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Proc‚dure ACSendCR                          Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure envoie un caractŠre ®CARRIAGE RETURN¯ … la communication
 par modem: asynchrone.
}

{$IFNDEF __Windows__}
 Procedure ACSendCR;External;
{$ENDIF}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Proc‚dure ACSendDLE                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure envoie un caractŠre ®DLE¯ … la communication par modem:
 asynchrone.
}

{$IFNDEF __Windows__}
 Procedure ACSendDLE;External;
{$ENDIF}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Proc‚dure ACSendEOT                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure envoie un caractŠre ®EOT¯ … la communication par modem:
 asynchrone.
}

{$IFNDEF __Windows__}
 Procedure ACSendEOT;External;
{$ENDIF}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                      Proc‚dure ACSendFFh                      Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure envoie un caractŠre de code ASCII FFh (255) … la
 communication par modem: asynchrone.
}

{$IFNDEF __Windows__}
 Procedure ACSendFFh;External;
{$ENDIF}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Proc‚dure ACSendNAK                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure envoie un caractŠre ®NAK¯ … la communication par modem:
 asynchrone.
}

{$IFNDEF __Windows__}
 Procedure ACSendNAK;External;
{$ENDIF}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Proc‚dure ACSendNow                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure envoie le caractŠre de la variable de param‚trage dans
 l'asychrone courant sans attendre que l'asychrone soit prŠs.
}

{$IFNDEF __Windows__}
 Procedure ACSendNow(C:Char);Assembler;ASM
  XOR SI,SI
  MOV DI,aBase
  MOV DX,DI
  ADD DX,uaMCR
  MOV AL,$B
  OUT DX,AL
  CMP AsyncDoDSR,False
  JE  @Esc1
  MOV DX,DI
  ADD DX,uaMSR
  MOV AH,020h
  CALL @2
 @Esc1:
  CMP AsyncDoCTS,False
  JE  @Esc2
  MOV AH,010h
  CALL @2
 @Esc2:
  MOV DX,DI
  ADD DX,uaLSR
  MOV AH,$20
  CMP CX,SI
  JE  @SkipSet
  CALL @2
  JMP @Esc3
 @2:
  MOV CX,-1
 @1:
  IN  AL,DX
  CMP CX,SI
  JE  @EscSubFunc1
  DEC CX
  TEST AL,AH
  JZ @1
 @EscSubFunc1:
  RETN
 @SkipSet:
  CALL @1
 @Esc3:
  CLI
  MOV DX,DI
  ADD DX,uaTHR
  MOV AL,C
  OUT DX,AL
  STI
 END;
{$ENDIF}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Proc‚dure ACSendNowXOFF                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure envoie le caractŠre ®XOFF¯ dans l'asychrone courant sans
 attendre que l'asychrone soit prŠs.
}

{$IFNDEF __Windows__}
 Procedure ACSendNowXOFF;External;
{$ENDIF}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Proc‚dure ACSendNowXON                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure envoie le caractŠre ®XON¯ dans l'asychrone courant sans
 attendre que l'asychrone soit prŠs.
}

{$IFNDEF __Windows__}
 Procedure ACSendNowXON;External;
{$ENDIF}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Proc‚dure ACSendNUL                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure envoie un caractŠre ®NUL¯ … la communication par modem:
 asynchrone.
}

{$IFNDEF __Windows__}
 Procedure ACSendNUL;External;
{$ENDIF}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Proc‚dure ACSendSOH                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure envoie un caractŠre ®SOH¯ … la communication par modem:
 asynchrone.
}

{$IFNDEF __Windows__}
 Procedure ACSendSOH;External;
{$ENDIF}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Proc‚dure ACSendStr                     Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure envoie une chaŒne de caractŠres de la variable de
 param‚trage ®S¯ dans l'asynchrone courant.
}

{$IFNDEF __Windows__}
 Procedure ACSendStr(Const S:String);
 Var
  I:Byte;
 Begin
  For I:=1to Length(S)do ACSend(S[I])
 End;
{$ENDIF}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Proc‚dure ACSendStr2Com                 Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure envoie une chaŒne de caractŠres de la variable de
 param‚trage  ®S¯  dans  l'asynchrone  sp‚cifi‚  par la variable de
 param‚trage ®Num¯ (0=COM1, 1=COM2, 2=COM3, 3=COM4,...).
}

{$IFNDEF __Windows__}
 Procedure ACSendStr2Com(Const S:String;Num:Byte);
 Var
  OldPort:Word;
 Begin
  If(Num>=MaxComPorts)Then Exit;
  OldPort:=aBase;aBase:=ComBase[Num-1];
  ACSendStr(S);
  aBase:=OldPort
 End;
{$ENDIF}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Proc‚dure ACSendStrWithDelay            Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure envoie une chaŒne de caractŠres de la variable de
 param‚trage  ®S¯  dans l'asynchrone courant  avec un certain d‚lai
 sp‚cifi‚ par la variable de param‚trage ®CharDelay¯.
}

{$IFNDEF __Windows__}
 Procedure ACSendStrWithDelays(Const S:String;CharDelay,EOSDelay:Integer);
 Var
  I:Byte;
 Begin
  If CharDelay<=0Then ACSendStr(S)
   Else
  For I:=1to Length(S)do Begin
   ACSend(S[I]);
   Delay(CharDelay)
  End;
  If EOSDelay>0Then Delay(EOSDelay)
 End;
{$ENDIF}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Proc‚dure ACSendSUB                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure envoie un caractŠre ®SUB¯ … la communication par modem:
 asynchrone.
}

{$IFNDEF __Windows__}
 Procedure ACSendSUB;External;
{$ENDIF}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Proc‚dure ACSendSYN                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure envoie un caractŠre ®SYN¯ … la communication par modem:
 asynchrone.
}

{$IFNDEF __Windows__}
 Procedure ACSendSYN;External;
{$ENDIF}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Proc‚dure ACSendXOFF                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure envoie un caractŠre ®XOFF¯ … la communication par modem:
 asynchrone.
}

{$IFNDEF __Windows__}
 Procedure ACSendXOFF;External;
{$ENDIF}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Proc‚dure ACSendXON                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure envoie un caractŠre ®XON¯ … la communication par modem:
 asynchrone.
}

{$IFNDEF __Windows__}
 Procedure ACSendXON;External;
{$ENDIF}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                     Proc‚dure ACSetupPort                   Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure fixe le param‚trage du modem de communication:
 Asynchrone.
}

{$IFNDEF __Windows__}
 Procedure ACSetupPort(ComPort,BaseAddr,IRQLine,IntNumb:Integer);Begin
  If(ComPort>0)and(ComPort<=MaxComPorts)Then Begin
   If BaseAddr=-1Then BaseAddr:=ComBase[ComPort];
   If IRQLine=-1Then IRQLine:=ComIRQ[ComPort];
   If IntNumb=-1Then IntNumb:=ComInt[ComPort];
   ComBase[ComPort]:=BaseAddr;
   ComIrq[ComPort]:=IRQLine;
   ComInt[ComPort]:=IntNumb;
   If ComPort<=3Then BaseAddr:=ComPortAddr(ComPort-1);
  End
 End;
{$ENDIF}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Proc‚dure ACStuff                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure "bourre" avec le caractŠre de param‚trage le tampon de
 communication par modem: asynchrone.
}

{$IFNDEF __Windows__}
 Procedure ACStuff(Ch:Char);
 Var
  NewHead:Integer;
 Begin
  aBufPtr^[aBufHead]:=Ch;
  NewHead:=Succ(aBufHead)mod Succ(aBufSize);
  If(NewHead=aBufTail)Then aBufOverflow:=True
   else
  Begin
   aBufHead:=NewHead;
   Inc(aBufUsed);
   If(aBufUsed>aMaxBufUsed)Then aMaxBufUsed:=aBufUsed
  End
 End;
{$ENDIF}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Proc‚dure ACTermReady                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de fixer le terminal (communication par modem) en
 mode prˆt (True) ou non (False).
}

{$IFNDEF __Windows__}
 Procedure ACTermReady(X:Boolean);Assembler;ASM
  MOV DX,aBase
  ADD DX,uaMCR
  IN  AL,DX
  AND AL,0FEh
  CMP X,True
  JNE @1
  INC AL
@1:
  OUT DX,AL
  PUSH CS
  CALL Near Ptr ACClrErrs
 END;
{$ENDIF}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                       Fonction ACWait4Quiet                     Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction attent que le modem de communication soit r‚duit au
 silence et en retourne un r‚sultat.
}

{$IFNDEF __Windows__}
 Function ACWait4Quiet(MaxWait,WaitTime:LongInt):Boolean;
 Var
  T1,W1:LongInt;
  Head:Integer;
 Begin
  T1:=TimeOfDayH;
  Repeat
   W1:=WaitTime;
   Repeat Delay(10);Dec(W1)Until(W1=0)or(Head<>aBufHead);
  Until(TimeDiffH(T1,TimeOfDay)>MaxWait)or(Head=aBufHead);
  ACWait4Quiet:=Head=aBufHead
 End;
{$ENDIF}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Proc‚dure BiosRS232Init                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure initialise un port s‚rie par l'entremise des services du
 Bios par l'interruption 14h.
}

{$I \Source\Chantal\Library\COM\BiosRS23.Inc}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                      Proc‚dure ClrXoffReceived                 Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure ‚limine les r‚ceptions d'®XOFF¯ encore en attente
 sur le tampon de r‚ception du port de communication.
}

{$IFNDEF __Windows__}
 Procedure ClrXoffReceived;Assembler;ASM
  CMP aXOffReceived,False
  JE  @1
  MOV aXOffReceived,False
  MOV DX,aUartIer
  IN  AL,DX
  TEST AL,2
  JNZ @1
  OR  AL,2
  OUT DX,AL
 @1:
 END;
{$ENDIF}


{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Proc‚dure InitAC                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure initialise toutes les fonctionnalit‚s essentiel … la
 communication par modem, t‚l‚phone et port s‚rie.
}

{$IFNDEF __Windows__}
 Procedure InitAC(BufMax,OBufMax,HighLev1,HighLev2,LowLev:Integer);
 Var
  I:Integer;
 Begin
  {$IFDEF NOASM}
   FillWord(aOpenFlag,19,0);
   aOutDelay:=500;
  {$ELSE}
   ASM
    XOR AX,AX
    PUSH DS
    POP ES
    CLD
    {$IFDEF FLAT386}
     MOV EDI,Offset aOpenFlag
    {$ELSE}
     MOV DI,Offset aOpenFlag
    {$ENDIF}
    MOV CX,19
    REP STOSW
    MOV AX,500
    STOSW{aOutDelay=500}
   END;
  {$ENDIF}
  If BufMax>0Then aBufSize:=BufMax-1
             Else aBufSize:=4095;
  If OBufMax>0Then aOBufSize:=OBufMax-1
              Else aOBufSize:=1131;
  If LowLev>0Then aBufLow:=LowLev
             Else aBufLow:=aBufSize shr 2;
  If HighLev1>0Then aBufHigh:=HighLev1
               Else aBufHigh:=(aBufSize shr 2)*3;
  If HighLev2>0Then aBufHigh2:=HighLev2
               Else aBufHigh2:=(aBufSize div 10)*9;
  aBufPtr:=MemAlloc(aBufSize+1);
  aOBufPtr:=MemAlloc(aOBufSize+1)
 End;
{$ENDIF}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                      Proc‚dure SendModemCmd                    Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet d'envoyer une commande au modem courant de
 l'application.
}

{$IFNDEF __Windows__}
 Procedure SendModemCmd{Const ModemText:String};
 Var
  I:Byte;
  Ch,MoChar:Char;
  Done:Boolean;
  L:Byte Absolute ModemText;
 Begin
  I:=1;Done:=False;
  While(I<=L)and(Not Done)do Begin
   MoChar:=ModemText[I];
   If(MoChar=FKCR)Then ACSendNow(Char(caCR))else
   IF(MoChar=FKDelay)Then Delay(1000)else
   If(MOChar=FKCtrlMark)Then Begin
    If(I+2<=L)Then If ModemText[I+1]=''''Then Inc(I,2);
    ACSendNow(ModemText[I]);
   End
    Else
   Begin
    ACSendNow(ModemText[I]);
    If ModemCmdDelay>0Then Delay(ModemCmdDelay);
   End;
   Inc(I);
  End;
 End;
{$ENDIF}


{ ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
  ³                         Interruption ACIsr                          Û
  ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


  Description
  ÍÍÍÍÍÍÍÍÍÍÍ

   Cette interruption est install‚ afin de permet de recevoir les donn‚es
  re‡u … n'importe  quel moment  par le modem.  Cette interruption est en
  principe appeler quand un caractŠre est en attente au modem.
}

{$IFNDEF __Windows__}
Procedure ACIsr(Flags,CS,IP,AX,BX,CX,DX,SI,DI,DS,ES,BP:Word);Assembler;ASM
  STI
@0:
  MOV DX,aUartIIR
  IN  AL,DX
  TEST AL,1
  JZ  @1
  JMP @9
@1:
  AND AL,6
  CMP AL,4
  JE  @2
  JMP @5
@2:
  PUSH AX
  CALL @y
  POP AX
@3:
  CMP AL,4
  JE  @a
  JMP @5
@a:
  MOV DX,aBase
  IN  AL,DX
  TEST AsyncDoXonXoff,1
  JZ  @d
  CMP AL,caXON
  JE  @b
  CMP AL,caXOFF
  JNE @d
  MOV aXOFFReceived,1
  MOV aXOFFRecDisp,1
  JMP @0
@b:
  MOV aXOFFReceived,0
  MOV aXONRecDisp,1
  CALL @y
  JMP @z
@d:
  TEST aLnStatus,2
  JZ  @e
  JMP @z
@e:
  MOV BX,aBufHead
  LES DI,aBufPtr
  ADD DI,BX
  MOV ES:[DI],AL
  INC aBufUsed
  MOV AX,aBufUsed
  CMP AX,aMaxBufUsed
  JLE @f
  MOV aMaxBufUsed,AX
@f:
  INC BX
  CMP BX,aBufSize
  JLE @h
  XOR BX,BX
@h:
  CMP aBufTail,BX
  JE  @s
  MOV aBufHead,BX
  CMP AX,aBufHigh
  JL  @z
  MOV DL,aSenderOn
  TEST AsyncOVXonXoff,1
  JZ  @k
  TEST aXOFFSent,1
  JZ  @j
  CMP AX,aBufHigh2
  JNE @k
@j:
  MOV aSendXOFF_,1
  CALL @y
  MOV aSenderOn,0
 @k:
  TEST DL,1
  JZ  @z
  XOR AH,AH
  TEST AsyncDoCTS,1
  JZ  @l
  MOV AH,uaRTS
@l:
  TEST AsyncDoDSR,1
  JZ  @m
  OR  AH,uaDTR
@m:
  OR  AH,AH
  JZ  @z
  MOV DX,aUartMCR
  IN  AL,DX
  NOT AH
  AND AL,AH
  OUT DX,AL
  MOV aSenderOn,0
  JMP @z
@s:
  OR  aLnStatus,2
@z:
  JMP @0
@5:
  CMP AL,2
  JE  @6
  JMP @v
@6:
  TEST aSendXoff_,1
  JZ @o
  TEST AsyncDoDSR,1
  JZ @7
  MOV DX,aUartMSR
  IN  AL,DX
  TEST AL,uaDSR
  JZ @p
@7:
  TEST AsyncDoCTS,1
  JZ @n
  MOV DX,aUartMSR
  IN  AL,DX
  TEST AL,uaCTS
  JZ @p
@n:
  MOV AL,caXOFF
  MOV DX,aBase
  OUT DX,AL
  MOV aSendXOFF_,0
  MOV aXOFFSent,1
  JMP @0
@o:
  MOV BX,aOBufTail
  CMP BX,aOBufHead
  JNE @q
@p:
  MOV DX,aUartIER
  IN  AL,DX
  AND AL,0FDh
  OUT DX,AL
  JMP @0
@q:
  TEST aXOFFReceived,1
  JNZ @p
  MOV DX,aUartMSR
  IN  AL,DX
  MOV aMdmStatus,AL
  TEST AsyncDoDSR,1
  JZ @r
  TEST AL,uaDSR
  JZ @p
@r:
  TEST AsyncDoCTS,1
  JZ @t
  TEST AL,uaCTS
  JZ @p
@t:
  LES DI,aOBufPtr
  ADD DI,BX
  MOV AL,ES:[DI]
  MOV DX,aBase
  OUT DX,AL
  DEC aOBufUsed
  INC BX
  CMP BX,aOBufSize
  JLE @u
  XOR BX,BX
@u:
  MOV aOBufTail,BX
  JMP @0
@v:
  CMP AL,6
  JNE @w
  MOV DX,aUartLSR
  IN AL,DX
  AND AL,01Eh
  MOV aLnStatus,AL
  OR aLnErrFlags,AL
  JMP @0
@w:
  OR AL,AL
  JE @x
  JMP @0
@x:
  MOV DX,aUartMSR
  IN AL,DX
  MOV aMdmStatus,AL
  CALL @y
  JMP @0
@y:
  MOV DX,aUartIER
  IN AL,DX
  TEST AL,2
  JNZ @8
  OR AL,2
  OUT DX,AL
@8:
  RET
@9:
  MOV AL,020h
  OUT 020h,AL
 END;
{$ENDIF}

END.