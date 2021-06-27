Uses Adele,Systex,Systems,Video;

Var Image:Array[0..16001]of Byte;
    Dest:Array[0..32007]of Byte;

Procedure Unpack;Var Index:Long;I,Z,Len:Word;Data:Byte;Begin
 FillClr(Dest,SizeOf(Dest));
 Index:=0;I:=2;
 While(Index<16000)do Begin
  Data:=Image[I];Inc(I);
  If Data and$C0=$C0Then Begin
   Len:=Data and$3F;Data:=Image[I];Inc(I);
   Z:=Len;
   FillChr(Dest[Index],Z,Data);Inc(Index,Len)
  End
   Else
  Begin;Dest[Index]:=Data;Inc(Index)End
 End;
End;

Var Chr:Char;

BEGIN
 InitSystems(suIsabel);
 SetVideoModeDeluxe(vmGrf320x200c4);
 GetFile('TETRIS.TTL',0,SizeOf(Dest),Dest);
 PutSmlImg(0,0,319,199,Dest[4]);
 ReadKey;
 GetFile('SLC.',0,SizeOf(Image),Image);
 PutSmlImg(0,0,319,199,Image[2]);
 ReadKey;
 GetFile('BKGR0.',0,SizeOf(Image),Image);
 PutSmlImg(0,0,319,199,Image[2]);
 ReadKey;
 For Chr:='1'to '9'do Begin
  GetFile('BKGR'+Chr+'.',0,SizeOf(Image),Image);
  Unpack;
  PutSmlImg(0,0,319,199,Dest);
  ReadKey;
 End;
END.
