
{*******************************************************}
{                                                       }
{       Delphi Runtime Library                          }
{       Windows Simplified Printer Interface Unit       }
{                                                       }
{       Copyright (c) 1991,94 Borland International     }
{                                                       }
{*******************************************************}

unit WinPrn;

{$S-}

interface

uses WinTypes;

{ AbortPrn will cause all unprinted portions of the writes to the  }
{ file to be thrown away. Note: the file still must be closed.     }

procedure AbortPrn(var F: Text);

{ AssignPrn assigns a file to a printer.  The Device, Driver, and  }
{ Port can be retrieved from the WIN.INI file's [device] section   }
{ or from the [windows] sections 'device' string. If Device is nil }
{ the default printer is used.                                     }

procedure AssignPrn(var F: Text; Device, Driver, Port: PChar);

{ AssignDefPrn calls AssignPrn with Device equal to nil.           }

procedure AssignDefPrn(var F: Text);

{ SetPrnFont will cause the file to begin printing using the given }
{ font.  The old font is returned.                                 }

function SetPrnFont(var F: Text; Font: HFont): HFont;

{ TitlePrn will give a title to the file being printed which is    }
{ displayed by Window's Print Manager.  For this routine to have   }
{ effect it needs to be called before ReWrite.                     }

procedure TitlePrn(var F: Text; Title: PChar);

{ ProcessPrnMessage is called whenever a message is received by    }
{ WinPrn's abort procedure.  If the function returns false, the    }
{ message is translated and dispatched, otherwise it is ignored.   }
{ Use this variable if you wish modeless dialogs to continue to    }
{ operate while printing.  (Note: Since ObjectWindow automatically }
{ initializes this variable for KBHandler's, no special action is  }
{ necessary when using ObjectWindows).                             }

var
  ProcessPrnMessage: function (var Msg: TMsg): Boolean;

implementation

uses
  WinProcs, WinDos, SysUtils;

{ ---------------------------------------------------------------- }
{ Internal helper routines --------------------------------------- }
{ ---------------------------------------------------------------- }

const
  wpInvalidDevice  = 230;
  wpTooManyAborted = 231;
  wpPrintingError  = 232;

{ Printer abort manager ------------------------------------------ }

var
  AbortList: array[1..8] of HDC; { List of aborted printings }
const
  AbortListLen: Byte = 0;

{ Abort ---------------------------------------------------------- }
{  Add the given DC to the abort list                              }

procedure Abort(DC: HDC);
begin
  if AbortListLen < SizeOf(AbortList) then
  begin
    Inc(AbortListLen);
    AbortList[AbortListLen] := DC;
  end
  else
    InOutRes := wpTooManyAborted;
end;

{ UnAbort -------------------------------------------------------- }
{  Remove a DC value from the abort list. If not in the list       }
{  ignore it.                                                      }

procedure UnAbort(DC: HDC);
var
  I: Byte;
begin
  for I := 1 to AbortListLen do
    if DC = AbortList[I] then
    begin
      if AbortListLen <> I then
        Move(AbortList[I], AbortList[I + 1], AbortListLen - I - 1);
      Dec(AbortListLen);
      Exit;
    end;
end;

{ IsAbort -------------------------------------------------------- }
{  Is the given DC in the abort list?                              }                               

function IsAborted(DC: HDC): Bool;
var
  I: Byte;
begin
  for I := 1 to AbortListLen do
    if DC = AbortList[I] then
    begin
      IsAborted := True;
      Exit;
    end;
  IsAborted := False;
end;

{ PrnRec --------------------------------------------------------- }
{  Printer data record                                             }

type
  PrnRec = record
    DC: HDC;                    { Printer device context }
    case Integer of
      0: (
        Title: PChar);          { Title of the printout }
      1: (
        Cur: TPoint;            { Next position to write text }
        Finish: TPoint;         { End of the pritable area }
        Height: Word;           { Height of the current line }
        Status: Word);          { Error status of the printer }
      2: (
        Tmp: array[1..14] of Char);
  end;

{ NewPage -------------------------------------------------------- }
{  Start a new page.                                               }

procedure NewPage(var Prn: PrnRec);
begin
  with Prn do
  begin
    LongInt(Cur) := 0;
    if not IsAborted(DC) and
        (Escape(DC, WinTypes.NewFrame, 0, nil, nil) <= 0) then
      Status := wpPrintingError;
  end;
end;

{ NewLine -------------------------------------------------------- }
{  Start a new line on the current page, if no more lines left     }
{  start a new page.                                               }

procedure NewLine(var Prn: PrnRec);

  function CharHeight: Word;
  var
    Metrics: TTextMetric;
  begin
    GetTextMetrics(Prn.DC, Metrics);
    CharHeight := Metrics.tmHeight;
  end;

begin
  with Prn do
  begin
    Cur.X := 0;

    if Height = 0 then
      { two new lines in a row, use the current character height }
      Inc(Cur.Y, CharHeight)
    else
      { Advance the height of the tallest font }
      Inc(Cur.Y, Height);
    if Cur.Y > (Finish.Y - (Height * 2)) then NewPage(Prn);
    Height := 0;
  end;
end;

{ PrnOutStr ------------------------------------------------------ }
{  Print a string to the printer without regard to special         }
{  characters.  These should handled by the caller.                }

procedure PrnOutStr(var Prn: PrnRec; Text: PChar; Len: Integer);
var
  Extent: TPoint;               { Size of the current text }
  L: Integer;                   { Temporary used for printing }
begin
  with Prn do
  begin
    while Len > 0 do
    begin
      L := Len;
      LongInt(Extent) := GetTextExtent(DC, Text, L);

      { Wrap the text to the line }
      while (L > 0) and (Extent.X + Cur.X > Finish.X) do
      begin
        Dec(L);
        LongInt(Extent) := GetTextExtent(DC, Text, L);
      end;

      { Adjust the current line height }
      if Extent.Y > Height then Height := Extent.Y;

      if not IsAborted(DC) then
        TextOut(DC, Cur.X, Cur.Y, Text, L);

      Dec(Len, L);
      Inc(Text, L);
      if Len > 0 then NewLine(Prn)
      else Cur.X := Extent.X;
    end;
  end;
end;

{ PrnString ------------------------------------------------------ }
{  Print a string to the printer handling special characters.      }

procedure PrnString(var Prn: PrnRec; Text: PChar; Len: Integer);
var
  L: Integer;                   { Temporary used for printing }
  TabWidth: Word;               { Width (in pixels) of a tab }

  { Flush to the printer the non-specal characters found so far }
  procedure Flush;
  begin
    if L <> 0 then
      PrnOutStr(Prn, Text, L);
    Inc(Text, L + 1);
    Dec(Len, L + 1);
    L := 0;
  end;

  { Calculate the average character width }
  function AvgCharWidth: Word;
  var
    Metrics: TTextMetric;
  begin
    GetTextMetrics(Prn.DC, Metrics);
    AvgCharWidth := Metrics.tmAveCharWidth;
  end;

begin
  L := 0;
  with Prn do
  begin
    while L < Len do
    begin
      case Text[L] of
        #9:
          begin
            Flush;
            TabWidth := AvgCharWidth * 8;
            Inc(Cur.X, TabWidth - ((Cur.X + TabWidth + 1)
              mod TabWidth) + 1);
            if Cur.X > Finish.X then NewLine(Prn);
          end;
        #13: Flush;
        #10:
          begin
            Flush;
            NewLine(Prn);
          end;
        ^L:
          begin
            Flush;
            NewPage(Prn);
          end;
      else
        Inc(L);
      end;
    end;
  end;
  Flush;
end;

{ PrnInput ------------------------------------------------------- }
{  Called when a Read or Readln is applied to a printer file.      }
{  Since reading is illegal this routine tells the I/O system that }
{  no characters where read, which generates a runtime error.      }

function PrnInput(var F: TTextRec): Integer; far;
begin
  with F do
  begin
    BufPos := 0;
    BufEnd := 0;
  end;
  PrnInput := 0;
end;

{ PrnOutput ------------------------------------------------------ }
{  Called when a Write or Writeln is applied to a printer file.    }
{  The calls PrnString to write the text in the buffer to the      }
{  printer.                                                        }

function PrnOutput(var F: TTextRec): Integer; far;
begin
  with F do
  begin
    PrnString(PrnRec(UserData), PChar(BufPtr), BufPos);
    BufPos := 0;
    PrnOutput := PrnRec(UserData).Status;
  end;
end;

{ PrnIgnore ------------------------------------------------------ }
{  Will ignore certain requests by the I/O system such as flush    }
{  while doing an input.                                           }

function PrnIgnore(var F: TTextRec): Integer; far;
begin
  PrnIgnore := 0;
end;

{ AbortProc ------------------------------------------------------ }
{   Abort procedure used for printing.                             }

var
  AbortProcInst: TFarProc;      { Instance of the abort proc }

function AbortProc(Prn: HDC; Code: Integer): Bool; export;
var
  Msg: TMsg;
  UserAbort: Boolean;
begin
  UserAbort := IsAborted(Prn);
  while not UserAbort and PeekMessage(Msg, 0, 0, 0, pm_Remove) do
    if not ProcessPrnMessage(Msg) then
    begin
      TranslateMessage(Msg);
      DispatchMessage(Msg);
    end;
  AbortProc := not UserAbort;
end;

{ PrnClose ------------------------------------------------------- }
{  Deallocates the resources allocated to the printer file.        }

function PrnClose(var F: TTextRec): Integer; far;
begin
  with PrnRec(F.UserData) do
  begin
    if DC <> 0 then
    begin
      if not IsAborted(DC) then
      begin
        NewPage(PrnRec(F.UserData));
        if Escape(DC, WinTypes.EndDoc, 0, nil, nil) <= 0 then
          Status := wpPrintingError;
      end;
      DeleteDC(DC);
      UnAbort(DC);
    end;
    PrnClose := Status;
  end;
end;

{ PrnOpen -------------------------------------------------------- }
{  Called to open I/O on a printer file.  Sets up the TTextFile to }
{  point to printer I/O functions.                                 }

function PrnOpen(var F: TTextRec): Integer; far;
const
  Blank: array[0..0] of Char = '';
begin
  with F, PrnRec(UserData) do
  begin
    if Mode = fmInput then
    begin
      InOutFunc := @PrnInput;
      FlushFunc := @PrnIgnore;
      CloseFunc := @PrnIgnore;
    end
    else
    begin
      Mode := fmOutput;
      InOutFunc := @PrnOutput;
      FlushFunc := @PrnOutput;
      CloseFunc := @PrnClose;

      { Setup the DC for printing }
      Status := Escape(DC, WinTypes.SetAbortProc, 0, PChar(AbortProcInst), nil);
      if Status > 0 then
        if Title <> nil then
        begin
          Status := Escape(DC, WinTypes.StartDoc, StrLen(Title), Title, nil);
          StrDispose(Title);
        end
        else
          Status := Escape(DC, WinTypes.StartDoc, 0, @Blank, nil);

      if Status <= 0 then
        Status := wpPrintingError
      else
        Status := 0;

      { Initialize the printer record }
      LongInt(Cur) := 0;
      Finish.X := GetDeviceCaps(DC, HorzRes);
      Finish.Y := GetDeviceCaps(DC, VertRes);
      Height := 0;
    end;
    PrnOpen := Status;
  end;
end;

{ FetchStr ------------------------------------------------------- }
{   Returns a pointer to the first comma delimited field pointed   }
{   to by Str. It replaces the comma with a #0 and moves the Str   }
{   to the beginning of the next string (skipping white space).    }
{   Str will point to a #0 character if no more strings are left.  }
{   This routine is used to fetch strings out of text retrieved    }
{   from WIN.INI.                                                  }

function FetchStr(var Str: PChar): PChar;
begin
  FetchStr := Str;
  if Str = nil then Exit;
  while (Str^ <> #0) and (Str^ <> ',') do
    Str := AnsiNext(Str);
  if Str^ = #0 then Exit;
  Str^ := #0;
  Inc(Str);
  while Str^ = ' ' do
    Str := AnsiNext(Str);
end;

{ ---------------------------------------------------------------- }
{ External interface routines ------------------------------------ }
{ ---------------------------------------------------------------- }

{ AbortPrn ------------------------------------------------------- }

procedure AbortPrn(var F: Text);
begin
  Abort(PrnRec(TTextRec(F).UserData).DC);
end;

{ AssignPrn ------------------------------------------------------ }

procedure AssignPrn(var F: Text; Device, Driver, Port: PChar);
var
  DeviceStr: array[0..80] of Char;
  P: PChar;
begin
  if Device = nil then
  begin
    { Get the default printer device }
    GetProfileString('windows', 'device', '', DeviceStr,
      SizeOf(DeviceStr) - 1);
    P := DeviceStr;
    Device := FetchStr(P);
    Driver := FetchStr(P);
    Port := FetchStr(P);
  end;
  with TTextRec(F), PrnRec(UserData) do
  begin
    Mode := fmClosed;
    BufSize := SizeOf(Buffer);
    BufPtr := @Buffer;
    OpenFunc := @PrnOpen;
    Name[0] := #0;
    DC := CreateDC(Driver, Device, Port, nil);
    if DC = 0 then
    begin
      InOutRes := wpInvalidDevice;
      Exit;
    end;
    Title := nil;
  end;
end;

{ AssignDefPrn --------------------------------------------------- }

procedure AssignDefPrn(var F: Text);
begin
  AssignPrn(F, nil, nil, nil);
end;

{ SetPrnFont ----------------------------------------------------- }

function SetPrnFont(var F: Text; Font: HFont): HFont;
begin
  SetPrnFont := SelectObject(PrnRec(TTextRec(F).UserData).DC, Font);
end;

{ TitlePrn ------------------------------------------------------- }

procedure TitlePrn(var F: Text; Title: PChar);
var
  S: array[0..31] of Char;
begin
  { Limit title size to 31 characters plus 0 }
  StrLCopy(S, Title, SizeOf(S));
  PrnRec(TTextRec(F).UserData).Title := StrNew(S);
end;

{ ---------------------------------------------------------------- }

function DummyMsg(var Msg: TMsg): Boolean; far;
begin
  DummyMsg := False;
end;

var
  SaveExit: Pointer;                    { Saves the old ExitProc }

procedure ExitWinPrn; far;
begin
  FreeProcInstance(AbortProcInst);
  ExitProc := SaveExit;
end;

begin
  ProcessPrnMessage := DummyMsg;

  AbortProcInst := MakeProcInstance(@AbortProc, hInstance);

  SaveExit := ExitProc;
  ExitProc := @ExitWinPrn;
end.
