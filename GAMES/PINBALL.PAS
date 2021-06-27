Uses Adele,Systex,Systems,Video;

Var Handle:Hdl;I:Wd;
    Buffer:Array[0..255]of RGB;
    Img:Pointer;

BEGIN
 InitSystems(suIsabel);
 SetVideoMode(vmGrf320x400c256);
 Img:=MemAlloc(64000);
 If(Img=NIL)Then Halt;
 GetFile('PINBALL.GFX',0,64000,Img^);
 PutSmlImg(0,0,319,199,Img^);
 GetFile('PINBALL.GFX',1,64000,Img^);
 PutSmlImg(0,200,319,399,Img^);
 GetFile('PINBALL.PAL',0,768,Buffer);
 SetPalRGB(Buffer,0,256);
 ReadKey;
END.