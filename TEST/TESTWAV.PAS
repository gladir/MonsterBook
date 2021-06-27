Uses Adele,Systex,Systems,Sound;

Const
  {Sound}
  MaxSounds        = 14;
  ExplodeSackSound = 1;
  FallenSack       = 2;
  FireSound        = 3;
  CheersSound      = 4;
  MonsterOutSound  = 5;
  GoldEatSound     = 6;
  MonsterDeadSound = 7;
  DiamondEaten     = 8;
  SoundFiles       : Array [1..MaxSounds] of String =
      ( '\BACKUP\DIGGER\Record.WAV',
        '\BACKUP\DIGGER\Record1.WAV',
        '\BACKUP\DIGGER\Record2.WAV',
        '\BACKUP\DIGGER\Record3.Wav',
        '\BACKUP\DIGGER\Record4.Wav',
        '\BACKUP\DIGGER\Record5.Wav',
        '\BACKUP\DIGGER\Record6.Wav',
        '\BACKUP\DIGGER\Record7.Wav',
        '\BACKUP\DIGGER\Ding.Wav',
        '\BACKUP\DIGGER\Applause.Wav',
        '\BACKUP\DIGGER\Bells.Wav',
        '\BACKUP\DIGGER\Start.Wav',
        '\BACKUP\DIGGER\Setup.Wav',
        '\BACKUP\DIGGER\Alarm.Wav');

BEGIN
 InitSystems(suIsabel);
 InitSound;
 _InitWave;
{ _LoadWave(SoundFiles[4]);}
 _LoadVoc('C:\BACKUP\PCINTER\SOUND\VOC\THIRTY.VOC');
 _PlayWave;
 ReadKey;
(* Repeat
  BackSound; { M‚canisme devant se r‚aliser … r‚guliŠrement
               afin que le son puisse avoir un c“t‚ un peu plus
               uniforme }
 Until KeyPress;*)
 _UnloadWave;
 SpeakerOff;
END.