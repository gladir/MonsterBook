{$M 4000,0,40000}                     { Not more heap than needed }

Uses GoldPlay,DOS,Crt;

Var I:Word;

Begin;
LoadOvl('GoldPlay.ovl');              { Load the moduleplayer }
AskInit;			      { Ask user about sounddevice }
Initialize;                           { Initialize the player }
LoadModule('Digital.mod');            { Load the module }
If Error<>0 then
   begin;
   writeln('Module Not Found');
   Halt;
   End;
System.Writeln;			      { Do a LineFeed }
System.Write('Playing. . .');         { Write a message }
StartPlaying;                         { Start Playing }
repeat until port[$60]<$80;           { Wait until someone presses space }
For I:=64 downto 0 do
    begin;
    MasterVolume(I);                  { Fade down .... }
    Delay(50);
    End;
StopPlaying;                          { Stop the module }
DeAlloc;                              { Remove the module }
RemoveOvl;	                      { Remove the moduleplayer }
end.