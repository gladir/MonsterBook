Uses Adele,Systex,Systems,Sound;

Var
 Buffer:Array[0..19999]of Byte;

BEGIN
 InitSystems(suIsabel);
 FillClr(Buffer,SizeOf(Buffer));
 InitSound;
 _InitWave;
 SetLineVolume(31);
 CurrWave.TickEnd:=GetRawTimer+
  ((SizeOf(Buffer)div(256-1000000 div 22050))shr 4);
 PlayBack(@Buffer,SizeOf(Buffer),22050,True);
 Repeat
 Until Not(CurrWave.TickEnd<GetRawTimer);
{ PlayBack(@Buffer,SizeOf(Buffer),22050,False);}
END.