{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                                                                         Û
 ³                    Malte Genesis/Visualisateur d'Image                  Û
 ³                                                                         Û
 ³            dition Chantal pour Mode R‚el/IV - Version 1.1              Û
 ³                              1995/11/30                                 Û
 ³                                                                         Û
 ³          Tous droits r‚serv‚s par les Chevaliers de Malte (C)           Û
 ³                                                                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Nom du programmeur
 ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ

  Sylvain Maltais


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette unit‚ renferme les routines n‚cessaires … la visualisation de
 fichier d'image  et/ou de capture  de ces images dans le ®ClipBoard¯
 ainsi que  certain d'attribut de modification que l'utilisateur peut
 demander s'il le d‚sire ou que l'image est mal interpr‚ter.
}

Unit Show;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                                 INTERFACE
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

{$I DEF.INC}

Uses
 Systex;

Function  FLIPlay(Const S:String;Pause:Integer):Word;
Function  FullScreen(Const Name:String):Boolean;
Function  FullScreenAtPos(Const Name:String;FilePos:LongInt):Boolean;
Procedure FullBMP(Const Name:String;OnlyShow:Bool);
Function  PLInit(Var Q;X1,Y1,X2,Y2:Byte):Bool;
Procedure PLLoad(Var Q;X1,Y1,X2,Y2:Byte;Const Path:String);
Procedure PLRefresh(Var Q);
Procedure PLOnWaiting(Var Q);
Procedure PLOnKeyPress(Var Q;Key:Char);
Procedure PLOnMouseDown(Var Q;X,Y:Integer;TX,TY:Byte;Shift:Word);
Function  PLDone(Var Q):Word;
Procedure RunFLI(Const S:String);
Procedure ViewIcon(Const Name:String);
Procedure _FullScreen(Var Q:XInf;Reset:Boolean);

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                                IMPLEMENTATION
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Uses
 Adele,Math,Mouse,Memories,
 Arcade,Systems,Video,Dials,Dialex,DialPlus,
 ResLoadI,ResServI,ResServD,Restex,Isatex;

 {Structure d'un fichier FLI}
Type
 FLIHeader=Record
  Size:LongInt;
  HType:Word;
  FrameCount:Word;
  Width:Word;
  Height:Word;
  BitsPerPixel:Word;
  Flags:Integer;
  Speed:Integer;
  NextHead:LongInt;
  FramesIntable:LongInt;
  HFile:Integer;
  HFrame1Offset:LongInt;
  Strokes:LongInt;
  Session:LongInt;
  Reserved:Array[1..88]of Byte;
 End;
 FrameHeader=Record
  Size:LongInt;
  FType:Word;
  Chunks:Word;
  Expand:Array[1..8]of Byte;
 End;
 ChunkHeader=Record
  Size:LongInt;
  ID:Word;
 End;

{ ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
  ³                           Proc‚dure ViewIcon                         Û
  ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


  Description
  ÍÍÍÍÍÍÍÍÍÍÍ

   Cette proc‚dure permet de visualiser des Icons de l'interface graphique
  Windows ou du systŠme d'exploitation OS/2 ayant le nom ®.ICO¯ et ®.CUR¯.
}

Procedure ViewIcon(Const Name:String);Label 7,8,9;
Var
 S:ImgRec;
 OldDialTimer:Boolean;

{$I Library\System\Windows\Icon.Inc}
{$I Library\System\OS2\Icon.Inc}

Var
 Handle:Hdl;
 I,J,B,X1,Y1,XN,YN,Size,K,MX,MY,MB:Word;
 ExtHeaderOS2:ExtIconOS2DirEntry;
 Header:IconHeader Absolute ExtHeaderOS2;
 HeaderOS2:IconOS2DirEntry Absolute Header;
 Buffer:Array[0..4095]of Byte;
 BitMap:BitMapInfoHeader Absolute Buffer;
Begin
 OldDialTimer:=DialTimer;DialTimer:=False;
 PushScr(S);
 Handle:=FileOpen(Name,fmRead);
 If(Handle<>errHdl)Then Begin
  _GetAbsRec(Handle,0,SizeOf(ExtHeaderOS2),ExtHeaderOS2);
  If(Header.idReserved=0)and(Header.idType in[1,2])Then For I:=1to(Header.idCount)do Begin
   SetVideoModeDeluxe(vmGrf320x200c256);
   PutTxtCenter(0,__Justified__,TruncName(Name,MaxXTxts),$0B);
   Size:=Header.idEntries[I-1].dwBytesInRes;
   If Size>SizeOf(Buffer)Then Size:=SizeOf(Buffer);
   _GetAbsRec(Handle,Header.idEntries[I-1].dwImageOffset,Size,Buffer);
   X1:=((NmXPixels-Bitmap.biWidth)shr 1);Y1:=((NmYPixels-BitMap.biHeight)shr 1);
   B:=SizeOf(BitMapInfoHeader);
   If BitMap.biBitCount=4Then Inc(B,(Header.idEntries[I-1].bWidth*Header.idEntries[I-1].bHeight)shr 4);
   If BitMap.biClrUsed<>0Then Begin
    For J:=0to BitMap.biClrUsed-1do
     SetPaletteRGB(J,Buffer[B+(J shl 2)+2],Buffer[B+(J shl 2)+1],Buffer[B+(J shl 2)]);
    Inc(B,BitMap.biClrUsed shl 2);
   End;
   For J:=Header.idEntries[I-1].bHeight-1downto 0do Begin
    ClrLnHorImg(X1,Y1+J,BitMap.biWidth,BitMap.biBitCount,Buffer[B]);
    Case(BitMap.biBitCount)of
     8:Inc(B,BitMap.biWidth);
     4:Inc(B,BitMap.biWidth shr 1);
     1:Inc(B,Bitmap.biWidth shr 3);
    End
   End;
   Repeat
    GetMouseSwitch(MX,MY,MB);
    If MB>0Then Begin
     WaitMouseBut0;
     Goto 7;
    End;
   Until KeyPress;
   K:=ReadKey;
 7:If(K=kbEsc)Then Break;
  End
   Else
  If ExtHeaderOS2.Sign='BA'Then Begin
   I:=1;
   Repeat
    If ExtHeaderOS2.Data.BitsPerPixel=1Then SetVideoModeDeluxe(vmGrf640x200c2)
    Else SetVideoModeDeluxe(vmGrf320x200c256);
    PutTxtCenter(0,__Justified__,TruncName(Name,MaxXTxts),$0B);
    _GetAbsRec(Handle,ExtHeaderOS2.Data.PosAbs,SizeOf(Buffer),Buffer);
    B:=0;XN:=ExtHeaderOS2.Data.NumXPixels shl 1;YN:=ExtHeaderOS2.Data.NumYPixels shl 1;
    X1:=((NmXPixels-XN)shr 1);Y1:=((NmYPixels-YN)shr 1);
    For J:=YN-1downto 0do Begin
     ClrLnHorImg(X1,Y1+J,XN,ExtHeaderOS2.Data.BitsPerPixel,Buffer[B]);
     Inc(B,ExtHeaderOS2.Data.NumXPixels)
    End;
    GetRec(Handle,I,SizeOf(ExtHeaderOS2),ExtHeaderOS2);
    Inc(I);
    Repeat
     GetMouseSwitch(MX,MY,MB);
     If MB>0Then Begin
      WaitMouseBut0;
      Goto 8;
     End;
    Until KeyPress;
    ReadKey;
 8:Until ExtHeaderOS2.Sign<>'BA'
  End
   Else
  If HeaderOS2.Sign='CI'#26Then Begin
   I:=1;
   Repeat
    If HeaderOS2.BitsPerPixel=1Then SetVideoModeDeluxe(vmGrf640x200c2)
    Else SetVideoModeDeluxe(vmGrf320x200c256);
    PutTxtCenter(0,__Justified__,TruncName(Name,MaxXTxts),$0B);
    _GetAbsRec(Handle,HeaderOS2.PosAbs,SizeOf(Buffer),Buffer);
    B:=0;XN:=HeaderOS2.NumXPixels shl 1;YN:=HeaderOS2.NumYPixels shl 1;
    X1:=((NmXPixels-XN)shr 1);Y1:=((NmYPixels-YN)shr 1);
    For J:=YN-1downto 0do Begin
     ClrLnHorImg(X1,Y1+J,XN,HeaderOS2.BitsPerPixel,Buffer[B]);
     Inc(B,HeaderOS2.NumXPixels)
    End;
    GetRec(Handle,I,SizeOf(IconOS2DirEntry),HeaderOS2);
    Inc(I);
    Repeat
     GetMouseSwitch(MX,MY,MB);
     If MB>0Then Begin
      WaitMouseBut0;
      Goto 9;
     End;
    Until KeyPress;
    ReadKey;
 9:Until HeaderOS2.Sign<>'CI'#26
  End;
  FileClose(Handle);
 End;
 PopScr(S);
 DialTimer:=OldDialTimer;
End;

{ ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
  ³                             Proc‚dure FullBMP                          Û
  ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


  Description
  ÍÍÍÍÍÍÍÍÍÍÍ

   Cette  proc‚dure  permet  de  visualiser  un fichier  d'image  de  format
  BitMap de Windows.


  Remarques
  ÍÍÍÍÍÍÍÍÍ

   ş La touche de fonction ®F10¯ permet de commuter l'image avec un d‚calage
     dans le cas d'une image avec largeur impaire.  Ceci est trŠs utile dans
     le cas  d'une image per‡u  sous OS/2 versus  Windows et  peut r‚gler de
     fa‡on artificiel le problŠme en les deux...

   ş Les  combinaisons  de touches  ® Ctrl + Insert ¯  sont  support‚es pour
     effectuer une copie dans le "Clipboard" de l'image visualiser.
}

Procedure FullBMP{Const Name:String;OnlyShow:Boolean};
Var
 X,Y,I,J,K:Word;
 Kr:Byte;
 S:ImgRec;
 OldDialTimer:Boolean;
 Q:XInf;
 Res:ImageHeaderRes;
Begin
 If Not(OnlyShow)Then Begin
  OldDialTimer:=DialTimer;DialTimer:=False;
  PushScr(S);
 End;
 K:=RILoadImage(Name,diAutoDetect,0,$FFFF,rmAllRes,
     [fpViewImage,fpViewScr,fpLoadOnlyTooBig,fpUserInterrupt],Q);
 If K<>0Then ErrMsgRes(K)
  Else
 Begin
  XGetAbsRec(Q,0,SizeOf(Res),Res);
  XFreeMem(Q);
  CloseCur;
  If(OnlyShow)Then (*FadeIn(63,Palette)*)
   Else
  Repeat
   K:=ReadKey;
   Case(K)of
    kbCtrlIns:Begin { Clipboard: Sauve l'image dans le Clipboard}
     If(NmXPixels<=Res.NumXPixels)Then X:=0 Else X:=(NmXPixels-Res.NumXPixels)shr 1;
     If(NmYPixels<=Res.NumYPixels)Then Y:=0 Else Y:=(NmYPixels-Res.NumYPixels)shr 1;
     MakeClipBoard(Res.NumYPixels*(Res.BytesPerLine shl 2));
     For J:=0to Res.NumYPixels-1do Begin
      For I:=0to Res.NumXPixels-1do
       PutClipBoardTxt('$'+HexByte2Str(GetPixel(X+I,Y+J))+',');
      PutClipBoardTxt(CRLF);
     End;
    End;
    Else Break;
   End;
  Until False;
 End;
 If Not(OnlyShow)Then Begin
  PopScr(S);
  DialTimer:=OldDialTimer;
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Proc‚dure WaitForScreen                     Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet d'attendre deux rafraŒchissements d'‚cran avant
 de retourner le contr“le … l'application.
}

Procedure WaitForScreen;Assembler;ASM
 MOV DX,3DAh
@Wait1:
 IN AL,DX
 TEST AL,8
 JNZ @Wait1
@Wait2:
 IN AL,DX
 TEST AL,8
 JNZ @Wait2
END;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Proc‚dure Waiting                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure retourne permettant de fixer une vitesse d'animation
 pour les fichiers ®FLI¯.
}

Procedure Waiting(Speed:Word);Assembler;ASM
 MOV CX,Speed
 JCXZ @end
 DEC CX
@Wait:
 CALL WaitForScreen
 LOOP @Wait
@End:
END;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Proc‚dure FliPlay                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet d'afficher l'animation du fichier ®FLI¯.
}

Function FliPlay(Const S:String;Pause:Integer):Word;
Var
 W:Word;
 FName:String;
 Handle:Hdl;
 LineCount:Word;
 Buf:^TByte;
 Pal1:^Palette256RGB;
 H:FliHeader;
 FH:FrameHeader;
 CH:ChunkHeader;
 I,J,Speed:Word;
 FirstFrame:LongInt;
Begin
 FliPlay:=0;FName:=S;
 If Pos('.',FName)=0Then AddStr(FName,'.FLI');
 Handle:=FileOpen(FName,fmRead);
 If(Handle=errHdl)Then Begin
  FliPlay:=errCanOpenFile;
  Exit;
 End;
 _GetRec(Handle,SizeOf(H),H);
 If Not SetVideoMode(vmGrf320x200c256)Then Begin
  FliPlay:=errVideoModeNotSupport;
  Exit;
 End;
 Buf:=MemAlloc(65520);
 If(Buf=NIL)Then Begin
  FliPlay:=OutOfMemory;
  Exit;
 End;
 Pal1:=MemAlloc(SizeOf(Palette256RGB));
 If(Pal1=NIL)Then Begin
  FliPlay:=OutOfMemory;
  Exit;
 End;
 Speed:=H.Speed*Pause;FirstFrame:=SizeOf(H);
 Repeat
  For i:=1To(H.FrameCount)do Begin
   _GetRec(Handle,SizeOf(FH),FH);
   If FH.FType<>$F1FAThen Begin
    FileClose(Handle);
    FliPlay:=ErrStructFile;
    Exit;
   End;
   If fh.Chunks>0Then For J:=1To(FH.Chunks)do Begin
    _GetRec(Handle,SizeOf(Ch),Ch);
    _GetRec(Handle,Ch.Size-SizeOf(Ch),Buf^);
    For W:=0to(Pause)do WaitRetrace;
    Case(Ch.ID)of
     11:ASM{Color}
      LES AX,Pal1
      MOV BX,ES
      MOV DX,AX
      AND AX,15
      MOV DI,AX
      {$IFOPT G+}
       SHR DX,4
      {$ELSE}
       SHR DX,1
       SHR DX,1
       SHR DX,1
       SHR DX,1
      {$ENDIF}
      ADD BX,DX
      MOV AX,BX
      PUSH DS
       LDS AX,Buf
       MOV BX,DS
       MOV DX,AX
       AND AX,15
       MOV SI,AX
       {$IFOPT G+}
        SHR DX,4
       {$ELSE}
        SHR DX,1
        SHR DX,1
        SHR DX,1
        SHR DX,1
       {$ENDIF}
       ADD BX,DX
       MOV DS,BX
       CLD
       LODSW
       MOV BX,AX
       TEST BX,BX
       JMP @EndU
       @U:
       LODSB
       ADD DI,AX
       ADD DI,AX
       ADD DI,AX
       LODSB
       OR AL,AL
       JNZ @u2
       MOV AX,256
   @u2:MOV CX,AX
       ADD CX,AX
       ADD CX,AX
       REP MOVSB
       DEC BX
 @EndU:JNZ @U
       SUB DI,768
       MOV SI,DI
       PUSH ES
       POP DS
       MOV CX,256
       MOV BL,0
@setpal:
       MOV DX,3C8h
       MOV AL,BL
       OUT DX,AL
       INC DX
       LODSB
       OUT DX,AL
       LODSB
       OUT DX,AL
       LODSB
       OUT DX,AL
       INC BL
       LOOP @SetPal
      POP DS
     END;
     12:ASM {LC}
      CALL WaitForScreen
      MOV AX,0A000h
      MOV ES,AX
      XOR DI,DI
      PUSH DS
       LDS AX,Buf
       MOV BX,DS
       MOV DX,AX
       AND AX,15
       MOV SI,AX
       {$IFOPT G+}
        SHR DX,4
       {$ELSE}
        SHR DX,1
        SHR DX,1
        SHR DX,1
        SHR DX,1
       {$ENDIF}
       ADD BX,DX
       MOV DS,BX
       CLD
       LODSW
       MOV DX,320
       MUL DX
       ADD DI,AX
       LODSW
       MOV LineCount,AX
       MOV DX,DI
       XOR AH,AH
       @LineLp:
       MOV DI,DX
       LODSB
       MOV BL,AL
       TEST BL,BL
       JMP @EndUlcLoop
       @UlcLoop:
       LODSB
       ADD DI,AX
       LODSB
       TEST AL,AL
       JS @UlcRun
       MOV CX,AX
       REP MOVSB
       DEC BL
       JNZ @UlcLoop
       JMP @UlcOut
       @UlcRun:
       NEG AL
       MOV CX,AX
       LODSB
       REP STOSB
       DEC BL
       @EndUlcLoop:
       JNZ @UlcLoop
       @UlCout:
       ADD DX,320
       DEC LineCount
       JNZ @LineLp
      POP DS
      PUSH Speed
      CALL Waiting
     END;
     13:ASM{Black}
      MOV CX,32000
      MOV AX,0A000h
      MOV ES,AX
      XOR AX,AX
      MOV DI,AX
      REP STOSW
      PUSH Speed
      CALL Waiting
     END;
     15:ASM {Brun}
      CALL WaitForScreen
      MOV LineCount,200
      MOV AX,0A000h
      MOV ES,AX
      XOR DI,DI
      PUSH DS
       LDS AX,Buf
       MOV BX,DS
       MOV DX,AX
       AND AX,15
       MOV SI,AX
       {$IFOPT G+}
        SHR DX,4
       {$ELSE}
        SHR DX,1
        SHR DX,1
        SHR DX,1
        SHR DX,1
       {$ENDIF}
       ADD BX,DX
       MOV DS,BX
       CLD
       MOV DX,DI
       XOR AH,AH
       @LineLp:
       MOV DI,DX
       LODSB
       MOV BL,AL
       TEST BL,BL
       JMP @EndUlcLoop
       @UlcLoop:
       LODSB
       TEST AL,AL
       JS @ucopy
       MOV CX,AX
       LODSB
       REP STOSB
       DEC BL
       JNZ @ulcloop
       JMP @ulcout
       @UCopy:
       NEG AL
       MOV CX,AX
       REP MOVSB
       DEC BL
       @EndUlcLoop:
       JNZ @UlcLoop
       @UlCout:
       ADD DX,320
       DEC LineCount
       JNZ @LineLp
      POP DS
      PUSH Speed
      CALL Waiting
     END;
     16:ASM {Copy}
      CALL WaitForScreen
      MOV AX,0A000h
      MOV ES,AX
      XOR DI,DI
      PUSH DS
       LDS AX,Buf
       MOV BX,DS
       MOV DX,AX
       ADD AX,15
       MOV SI,AX
       {$IFOPT G+}
        SHR DX,4
       {$ELSE}
        SHR DX,1
        SHR DX,1
        SHR DX,1
        SHR DX,1
       {$ENDIF}
       ADD BX,DX
       MOV DS,BX
       MOV CX,32000
       REP MOVSW
      POP DS
      PUSH Speed
      CALL Waiting
     END;
    End;
   End
    Else
   Waiting(Speed);
   If(KeyPress)Then Begin
    FileClose(Handle);
    FreeMemory(Buf,65520);
    FreeMemory(Pal1,SizeOf(Palette256RGB));
    Exit;
   End;
  End;
  SetFilePos(Handle,FirstFrame);
 Until False;
End;

Function PLInit(Var Q;X1,Y1,X2,Y2:Byte):Bool;Var QX:MediaPlayerRec Absolute Q;Begin
 FillClr(Q,SizeOf(MediaPlayerRec));
 WEInit(QX.W,X1,Y1,X2,Y2);
End;

Procedure PLLoad(Var Q;X1,Y1,X2,Y2:Byte;Const Path:String);Begin
End;

Procedure PLRefresh(Var Q);Var QX:MediaPlayerRec Absolute Q;Begin
 WEPutWnKrDials(QX.W,'Joueur Multim‚dia');
End;

Procedure PLOnWaiting(Var Q);Begin
End;

Procedure PLOnKeyPress(Var Q;Key:Char);Begin
End;

Procedure PLOnMouseDown(Var Q;X,Y:Integer;TX,TY:Byte;Shift:Word);Begin
End;

Function PLDone(Var Q):Word;Begin
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Proc‚dure FliPlay                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure de faire jouer un fichier d'animation de format FLI
 d'®Autodesk Animator¯.
}

Procedure RunFLI(Const S:String);
Var
 X:ImgRec;
 E:Word;
Begin
 PushScr(X);
 E:=FLIPlay(S,1);
 PopScr(X);
 If E>0Then ErrNoMsgOk(E);
End;

Procedure _FullScreen(Var Q:XInf;Reset:Boolean);
Label 1,ReRead,Refresh;
Var
 X,Y,J,YDecal,XDecal:Word;
 OldDialTimer:Bool;
 Res:ImageHeaderRes;
 I:LongInt;
 Buffer:^TByte;
 Ok:Boolean;
 S:ImgRec;

 Procedure Info;
 Var
  Data:Record
   CaptionSizeImage:String[20];
   CaptionNumColors:String[20];
   CaptionBitsPerPixel:String[10];
   CaptionSize:String[20];
   CaptionFormat:String[20];
  End;
  Size:LongInt;
  Buffer:Array[0..257]of Byte;
  PStr:^String;
 Begin
  FillClr(Data,SizeOf(Data));
  Data.CaptionSizeImage:=CStr(Res.NumXPixels)+'x'+CStr(Res.NumYPixels);
  Data.CaptionNumColors:=CStr(Long(Long(1)shl Long(Res.BitsPerPixel)));
  Data.CaptionBitsPerPixel:=WordToStr(Res.BitsPerPixel);
  If Q.Size<=SizeOf(Res)Then Size:=Mul2Word(Res.BytesPerLine,Res.NumYPixels)
                        Else Size:=Q.Size-SizeOf(Res);
  Data.CaptionSize:=CStr(Size)+' octets';
  DBOpenServerName(ChantalServer,'CHANTAL:/Fichier/Images/Format.Dat');
  If DBLocateAbs(ChantalServer,0,Res.Original,[])Then Begin
   DBReadRec(ChantalServer,Buffer);
   PStr:=@Buffer;
   DBGotoColumnAbs(ChantalServer,1,Pointer(PStr));
   Data.CaptionFormat:=PStr^;
  End
   Else
  Data.CaptionFormat:='Inconnu';
  ExecuteAppDPU(70,Data);
 End;

 Procedure LocalMenu;Begin
  __InitMouse;
  Case RunMenuApp(6)of
   $F001:PushKey(kbRight);
   $F002:PushKey(kbLeft);
   $F003:PushKey(kbUp);
   $F004:PushKey(kbDn);
   $F005:Info;
  End;
 End;

Begin
 Buffer:=MemAlloc(4096);
 If(Buffer<>NIL)Then Begin
  XGetAbsRec(Q,0,SizeOf(Res),Res);
  If(Reset)Then Begin
   PushScr(S);
   Ok:=BestMode(Res);
  End
   Else
  Ok:=True;
  If(Ok)Then Begin
   OldDialTimer:=DialTimer;
   DialTimer:=False;
   XDecal:=0;YDecal:=0;
   If(Reset)Then Begin
Refresh:
    RISetPalette(Q);
    I:=SizeOf(Res)+Mul2Word(YDecal,Res.BytesPerLine)+
       LongInt(LocalBytesPerLine(XDecal,Res.BitsPerPixel));
    For J:=0to Res.NumYPixels-1do Begin
     If(J>=NmYPixels)Then Break;
     XGetAbsRec(Q,I,Res.BytesPerLine,Buffer^);
     BestClrLnHorImg(J,Res,Buffer^);
     Inc(I,Long(Res.BytesPerLine));
    End;
   End;
ReRead:
   Repeat
    GetMouseSwitch(X,Y,J);
    If J=2Then Begin
     WaitMouseBut0;
     LocalMenu;
    End
     Else
    If J>0Then Begin
     WaitMouseBut0;
     Goto 1;
    End;
   Until KeyPress;
   Case(ReadKey)of
    kbCtrlF1:Begin
     LocalMenu;
     Goto ReRead;
    End;
    kbDn:Begin
     If(Res.NumYPixels>NmYPixels)Then Begin
      If(YDecal+8<=Res.NumYPixels-NmYPixels)Then Inc(YDecal,8);
      Goto Refresh;
     End;
     Goto ReRead;
    End;
    kbUp:Begin
     If YDecal>0Then Begin
      If YDecal<8Then YDecal:=0
                 Else Dec(YDecal,8);
      Goto Refresh;
     End;
     Goto ReRead;
    End;
    kbLeft:Begin
     If XDecal>0Then Begin
      If XDecal<8Then XDecal:=0
                 Else Dec(XDecal,8);
      Goto Refresh;
     End;
     Goto ReRead;
    End;
    kbRight:Begin
     If(Res.NumXPixels>NmXPixels)Then Begin
      If(XDecal+8<=Res.NumXPixels-NmXPixels)Then Inc(XDecal,8);
      Goto Refresh;
     End;
     Goto ReRead;
    End;
   End;
 1:If(Reset)Then PopScr(S);
   DialTimer:=OldDialTimer;
  End
   Else
  ErrNoMsgOk(errNoVideoModeFit);
  FreeMemory(Buffer,4096);
 End;
End;

Function FullScreen{Const Name:String):Boolean};
Var
 Q:XInf;
 X:ImgRec;
Begin
 FullScreen:=False;
 PushScr(X);
 If RILoadImage(Name,diAutoDetect,0,$FFFF,rmAllResSteady,
                [fpUserInterrupt,fpViewScr,fpViewImage,
                fpLoadOnlyTooBig,fpPreserveHeader],Q)=0Then Begin
  _FullScreen(Q,True);
  FullScreen:=True;
 End;
 PopScr(X);
End;

Function FullScreenAtPos{Const Name:String;FilePos:LongInt):Boolean};
Var
 Q:XInf;
 X:ImgRec;
 Handle:Hdl;
Begin
 FullScreenAtPos:=False;
 Handle:=FileOpen(Name,fmRead);
 If(Handle<>errHdl)Then Begin
  PushScr(X);
  If RIReadImage(Handle,diAutoDetect,FilePos,0,$FFFF,rmAllResSteady,
                 [fpUserInterrupt,fpViewScr,fpViewImage,
                  fpLoadOnlyTooBig,fpPreserveHeader],Q)=0Then Begin
   _FullScreen(Q,False);
   FullScreenAtPos:=True;
  End;
  PopScr(X);
  FileClose(Handle);
 End;
End;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
END.