Uses Dos,Adele,Systex,Systems,Video;

Var I,J,P:Byte;
    Buffer:Array[0..4095]of Byte;
    TBuf:TByte Absolute Buffer;
    X:SearchRec;

BEGIN
 InitSystems(suIsabel);
 SetVideoMode(vmTxtC80);
 SetChrWidth(8);
 FindFirst('C:\BACKUP\*.FNT',faArchive,X);
 While DosError=0do Begin
  PutTxtXY(0,17,X.Name,$1F);
  LoadMtx('C:\BACKUP\'+X.Name);
  For J:=0to 15do For I:=0to 15do SetChr(I,J,Chr((J shl 4)+I));
  ReadKey;
  FindNext(X);
 End;
{ P:=0;
 Repeat
  GetFile('HRF12.FNT',P,SizeOf(Buffer),Buffer);
  SetMatrix(0,16,256,0,TBuf);
  For J:=0to 15do For I:=0to 15do SetChr(I,J,Chr((J shl 4)+I));
  Case(ReadKey)of
   kbUp:If P>0Then Dec(P);
   kbDn:If P<11Then Inc(P);
   kbEsc:Break;
  End;
 Until No;}
 SetVideoMode(vmTxtDef);
 DoneSystems;
END.