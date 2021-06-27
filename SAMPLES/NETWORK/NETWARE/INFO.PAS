Type
 FileServerInformation=Record
  ServerName:String[48];
  NetwareVersion:Byte;
  NetwareSubVersion:Byte;
  ConnectionsMax:Word;
  ConnectionsInUse:Word;
  MaxConnVol:Word;
  OSRevision:Byte;
  SFTLevel:Byte;
  TTSLevel:Byte;
  PeakConnUsed:Word;
  AccountingVersion:Byte;
  VapVersion:Byte;
  QueuingVersion:Byte;
  PrintServerVersion:Byte;
  VirtualConsoleVersion:Byte;
  SecurityRestrictionsLevel:Byte;
  InternetworkBridgeVersion:Byte;
  Undefined:Array[1..60]of Byte;
 End;

Function GetFileServerInformation(Var Q:FileServerInformation):Boolean;
Type
 TReq=Record
  Len:Word;
  SubF:Byte;
 End;
Var
 Request:TReq;
Begin
 ASM
  PUSH DS
   MOV AX,0F217h
   MOV CX,TYPE TReq
   MOV DX,TYPE FileServerInformation-1
   LES DI,Q
   MOV Request.Len,001h
   MOV Request.SubF,011h
   MOV SI,Offset Request
   ADD SI,BP
   PUSH SS
   POP DS
   INT 21h
  POP DS
  MOV @Result,AL
 END;
End;

Var
 Q:FileServerInformation;

BEGIN
 WriteLn(GetFileServerInformation(Q));
END.