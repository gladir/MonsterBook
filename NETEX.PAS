Unit Netex;

INTERFACE

Type
 TNBName=Array[0..15]of Byte;
 TMacAddress=Array[0..5] of byte;
 PNCB=^TNCB;

 TNCB=Record
  Command:Byte;
  RetCode:Byte;
  LSN:Byte;
  Num:Byte;
  Buf:^Byte;
  Length:Word;
  CallName:TNBName;
  Name:TNBName;
  RTO:Byte;
  STO:Byte;
  PostOffs:Word;
  PostSeg:Word;
  LanaNum:Byte;
  CmdCplt:Byte;
  Reserved:Array[0..13] of Byte;
 End;

 PNameInfo=^TNameInfo;
 TNameInfo=Record
  Name:TNBName;
  NameNum:Byte;
  NameSt:Byte;
 End;

 PAdpStat=^TAdpStat;
 TAdpStat=Record
  ID:TMacAddress;
  VMajor:Byte;
  Resvd0:Byte;
  AdpType:Byte;
  VMinor:Byte;
  RptTime:Word;
  RcvCRC:Word;
  RcvOth:Word;
  TxmCol:Word;
  TxmOth:Word;
  TxmOK:LongInt;
  RcvOK:LongInt;
  TxmRetr:Word;
  NoRcvBuf:Word;
  T1tmo:Word;
  Titmo:Word;
  Resvd1:LongInt;
  FreeNcbs:Word;
  CfgNcbs:Word;
  maxNcbs:Word;
  NoTxmBuf:Word;
  MaxDGSize:Word;
  PendSes:Word;
  CfgSes:Word;
  MaxSes:Word;
  MaxSPSz:Word;
  nNames:Word;
  Names:Array[0..15] of TNameInfo;
 End;

IMPLEMENTATION

END.