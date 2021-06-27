Program Clock;

{$G-}

Uses Crt;

{$I ..\Library\System\Malte\Header.Inc}
{$I ..\Library\CPU\Intel\OpCode.Inc}

{$DEFINE NoVoid}
Function GetRawTimerPerMem:Long;
{$I ..\Library\GetRawTi.Inc}

{$DEFINE __286__}
Function GetRawTimerPerMemi286:Long;
{$I ..\Library\GetRawTi.Inc}

{$DEFINE Cmos}
Function GetRawTimerPerCmos:Long;
{$I ..\Library\GetRawTi.Inc}
{$UNDEF Cmos}

{$DEFINE Bios}
Function GetRawTimerPerInt1Ah:Long;
{$I ..\Library\GetRawTi.Inc}

BEGIN
 ClrScr;
 WriteLn('DÇmonstration des heures du systäme...');
 WriteLn('Calculer en 1/18,2iäme de secondes depuis minute.');
 Repeat
  GotoXY(1,4);
  Write('CMOS:        ',GetRawTimerPerCmos);ClrEol;WriteLn;
  Write('INT 1Ah:     ',GetRawTimerPerInt1Ah);ClrEol;WriteLn;
  Write('MÇmoire 286: ',GetRawTimerPerMemi286);ClrEol;WriteLn;
  Write('MÇmoire:     ',GetRawTimerPerMem);ClrEol;
 Until Keypressed;
END.