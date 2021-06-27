Program FLB;

Uses Adele,Systex,Systems,Video;

{$I \Source\Chantal\Library\Files\Images\FLBEntry.Inc}

Var Path:String;
    I,J:Byte;X,Y,TY,Jmp,P:Wd;
    Entry:FLBEntry;
    Buffer:Array[0..32767]of Byte;
    Handle:Hdl;

BEGIN
 InitSystems(suIsabel);
 AutoDetect;
 If(IsVGA)Then SetVideoModeDeluxe(vmGrf640x480c2)
          Else SetVideoModeDeluxe(vmGrf640x200c2);
 Path:='\TEXTE\NEWS\NEWS.FLB';P:=0;
 Handle:=Open(Path,fmRead);
 If(Handle=errHdl)Then Begin;WriteLn('Fichier introuvable!');Halt;End;
 Repeat
  ClrScrBlack;
  GetRec(Handle,P,SizeOf(Entry),Entry);
  _GetAbsRec(Handle,Entry.PosAbs,SizeOf(Buffer),Buffer);
  PutSmlImg(0,0,(Buffer[0]+(Buffer[1]shl 8))-1,Buffer[2]-1,Buffer[4]);
  _GetAbsRec(Handle,Entry.PosAbs+Entry.SizeImg,SizeOf(Buffer),Buffer);
  X:=0;Y:=80;
  For I:=0to 127do Begin
   Jmp:=Buffer[I shl 1]+(Buffer[(I shl 1)+1]shl 8);
   If Jmp<>$FFFFThen Begin
    TY:=Entry.Height-Buffer[256+Jmp+2];
    If(X+Buffer[256+Jmp+1]+3>=GetNumXPixels)Then Begin
     Inc(Y,Entry.Height);
     If(Y>=GetNumYPixels)Then Break;
     X:=0;
    End;
    PutSmlImg(X,Y+TY,X+Buffer[256+Jmp+1]-1,Y+TY+Buffer[256+Jmp+3]-1,Buffer[256+4+Jmp]);
    Inc(X,Buffer[256+Jmp+1]+3);
   End;
  End;
  Case(ReadKey)of
   kbEsc:Break;
   kbHome:P:=0;
   kbUp:If P>0Then Dec(P);
   kbDn:If P<33Then Inc(P);
   kbEnd:P:=33;
  End;
 Until No;
 Close(Handle);
 SetVideoMode(vmTxtDef);
END.
