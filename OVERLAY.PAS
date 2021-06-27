
{*******************************************************}
{                                                       }
{       Turbo Pascal Runtime Library                    }
{       Overlay Interface Unit                          }
{                                                       }
{       Copyright (C) 1988,92 Borland International     }
{                                                       }
{*******************************************************}

unit Overlay;

{$I-,S-}

interface

const
  ovrOk = 0;
  ovrError = -1;
  ovrNotFound = -2;
  ovrNoMemory = -3;
  ovrIOError = -4;
  ovrNoEMSDriver = -5;
  ovrNoEMSMemory = -6;

const
  OvrResult: Integer = 0;
  OvrEmsPages: Word = 0;
  OvrTrapCount: Word = 0;
  OvrLoadCount: Word = 0;
  OvrFileMode: Byte = 0;

type
  OvrReadFunc = function(OvrSeg: Word): Integer;

var
  OvrReadBuf: OvrReadFunc;

procedure OvrInit(FileName: String);
procedure OvrInitEMS;
Procedure OvrInitXMS;
procedure OvrSetBuf(Size: LongInt);
function  OvrGetBuf: LongInt;
procedure OvrSetRetry(Size: LongInt);
function  OvrGetRetry: LongInt;
procedure OvrClearBuf;

implementation

{$L OVERLAY.OBJ}
{$L OVEREMS.OBJ}
{$L OVERXMS.OBJ }

const
  OvrRetrySize: Word = 0;
  OvrFileBase: Longint = 0;

procedure OvrInit(FileName: String); external;
procedure OvrInitEMS; external;
Procedure OvrInitXMS;External;
procedure OvrSetBuf(Size: LongInt); external;
function  OvrGetBuf: LongInt; external;
procedure OvrSetRetry(Size: LongInt); external;
function  OvrGetRetry: LongInt; external;
procedure OvrClearBuf; external;

procedure OverlayHalt;
begin
  RunError(209);
end;

end.
