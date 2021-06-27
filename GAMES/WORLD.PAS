{Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette unit‚ affiche une animation de la terre … partir de 32 images.
}

Unit World;

INTERFACE

Uses Adele,Systex,Systems,Video;

Procedure WorldAnim;

IMPLEMENTATION

Uses Imagetex,Memories;

Procedure WorldAnim;
Const SizeOfHeaderBMP=14;
Type TBitmapInfoHeader=Record
 biSize,biWidth,biHeight:Long;
 biPlanes,biBitCount:Word;
 biCompression,biSizeImage:Long;
 biXPelsPerMeter,biYPelsPerMeter,biClrUsed,biClrImportant:Long;
End;
Var HBMP:HeaderBMP;BIH:TBitmapInfoHeader;
    Handle:Hdl;Size:Long;I,J,K:Word;X,XD:Int;Wait:Byte;
    Palette:Array[0..15]of Long;
    World:Array[0..31]of PTByte;
    WorldSize:Array[0..31]of Wd;
Begin
 FillClr(World,SizeOf(World));
 SetVideoMode(vmGrf320x200c256);
 For K:=0to 31do Begin
  Handle:=FileOpen('WORLD'+WordToStr(K)+'.BMP',fmRead);
  GetRec(Handle,0,SizeOf(HeaderBMP),HBMP);
  If HBMP.Sign<>'BM'Then Exit
   Else
  Begin
   _GetAbsRec(Handle,SizeOfHeaderBMP,SizeOf(BIH),BIH);
   Size:=HBMP.Size-SizeOfHeaderBMP;
   _GetAbsRec(Handle,SizeOfHeaderBMP+SizeOf(TBitmapInfoHeader),SizeOf(Palette),Palette);
   If Size>65520Then Break;
   WorldSize[K]:=Size;
   World[K]:=MemAlloc(Size);
   If(World[K]=NIL)Then Break;
   _GetAbsRec(Handle,HBMP.OffBits,Size,World[K]^);
  End;
  FileClose(Handle)
 End;
 For I:=0to 15do SetPaletteRGB(I,LongRec(Palette[I]).Hi,Hi(Palette[I]),Lo(Palette[I]));
 PutTxtXY(0,24,'Les Chevaliers de Malte pr‚sente',$0C);
 X:=0;XD:=1;Wait:=0;
 Repeat
  For K:=0to 31do Begin
   If X>150Then XD:=-1;
   If X<0Then XD:=1;
   Inc(X,XD);
   I:=0;
   For J:=159downto 0do Begin
    ClrLnHorImg(X,J,159,4,World[K]^[I]);
    Inc(I,80);
   End;
   WaitRetrace;WaitRetrace;WaitRetrace;WaitRetrace;
   If(KeyPress)Then Break
  End;
  Inc(Wait);
  If Wait>5Then Break;
 Until KeyPress;
 CloseCur;
 If(KeyPress)Then ReadKey;
 For I:=0to 31do FreeMem(World[I],WorldSize[I]);
End;

END.