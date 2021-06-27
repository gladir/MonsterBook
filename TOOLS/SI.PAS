Program SystemInformation;

Uses Chantal,Systex,Systems;

Var PC:PChar;SizeOf_:Wd;S:String;

{$I ..\Library\System\OSStr.Inc}
{$I ..\Library\Mouse\GetStrMs.Inc}

BEGIN
 WriteLn('SystŠme d''Information  Tous droits r‚serv‚s par les Chevaliers de Malte  1997');
 InitSystems(suFAST);
 WriteLn;
 Write('Nom de l''ordinateur:':27);
 Case(MachineID)of
  $FF:WriteLn('PC');
  $FE:WriteLn('PC/XT');
  $FD:WriteLn('PC Junior');
  $FC:WriteLn('PC/AT');
 Else WriteLn('PS/2');
 End;
 WriteLn('Date du BIOS:':27,StrUSpc(LoadStr(Mem[$FFFF:5],8),26),'Port s‚rielle:',NmSerial);
 Write('Processeur principal:':27);
 Case(CPU)of
  cpui486:If Test8087=0Then S:='80486SX (32 bits)'Else S:='80486 (32 bits)';
  cpui386:S:='80386';
  cpu80286:S:='80286 (16 bits)';
  cpu80186:S:='80186 (16 bits)';
  cpu80188:S:='80188 (8 bits)';
  cpuV30:S:='v30 (16 bits)';
  cpuV20:S:='v20 (8 bits)';
  cpu8086:S:='8086 (16 bits)';
  cpu8088:S:='8088 (8 bits)';
  Else S:='Inconnu';
 End;
 WriteLn(StrUSpc(S,25),'Port parallŠle:',NmLPT);
 Write('Coprocesseur math‚matique:':27);
 If Test8087<>0Then Case(CPU)of
  cpui486:S:='80487';
  cpui386:S:='80387';
  cpu80286:S:='80287';
  cpu80186,cpu80188:S:='80187';
  cpuV30,cpuV20,cpu8086,cpu8088:S:='8087';
 End
  Else
 S:='Absent';
 WriteLn(StrUSpc(S,24),'Unit‚ disquette:',NmFloppyDsk);
 WriteLn('SystŠme d''exploitation:':27,StrUSpc(OperatingSystemStr,23),'Unit‚ disque dur:',NmHardDsk);
 AutoDetect;
 Write('Adapteur vid‚o:':27);
 PC:=AllocLangFunc(GetVideoCard,SizeOf_);
 WriteLn(PC);
 WriteLn('Souris:':27,GetStrMouse);
 WriteLn('M‚moire:');
 WriteLn('Conventionnel au total:':27,MemTotalSize,' Ko');
 WriteLn('Conventionnel de libre:':27,MemAvail shr 10,' Ko');
 WriteLn('XMS au total:':27,XmsTotalSize,' Ko');
 WriteLn('EMS au total:':27,EmmTotalSize,' Ko');
 WriteLn('‚tendu par l''INT 15h:':27,ExtBiosSizeK,' Ko');
END.