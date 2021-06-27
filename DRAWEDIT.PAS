{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                     Malte Genesis/Programme de Dessin                 Û
 ³             dition Chantal pour Mode R‚el/IV - Version 1.2           Û
 ³                              1996/02/31                               Û
 ³                                                                       Û
 ³          Tous droits r‚serv‚s par les Chevaliers de Malte (C)         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Nom du programmeur
 ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ

  Sylvain Maltais


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette  unit‚  permet  de  dessiner   des  dessins   dans   une   fenˆtre
 d'application en mode graphique. Il r‚clame bien entendu que le graphique
 soit autoris‚ par la directive condition ®Graf¯.
}

Unit DrawEdit;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                                 INTERFACE
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

{$I DEF.INC}
{$IFDEF Graf}
Uses
 Systex,Isatex;

Function  DWInit(Var Q:DrawEditApp;Path:String;Inf:WIRec):Boolean;
Procedure DWBackOperation(Var Context);
Procedure DWOnMouseControl(Var Context;Control:Word);
Procedure DWOnMouseDown(Var Context;X,Y:Integer;TX,TY:Byte;Shift:Word);
Procedure DWOnMouseMove(Var Context;X,Y:Integer;TX,TY:Byte);
Procedure DWOnKeyDown(Var Context;Key:Word;Shift:ShiftState);
Procedure DWOnKeyPress(Var Context;Key:Char);
Procedure DWSelectFont(Var Q:DrawEditApp);
Procedure DWSelectSizeBrush(Var Q:DrawEditApp);
Procedure DWSetColor(Var Q:DrawEditApp);
Procedure DWCopyBox2Clipboard(Var Q:DrawEditApp;X1,Y1,X2,Y2:Word);
Procedure DWCopyImage2Clipboard(Var Q:DrawEditApp);
Procedure DWClearImage(Var Q:DrawEditApp);
Procedure DWFillBoxAbsolute(Var Q:DrawEditApp);
Procedure DWFillBoxRelative(Var Q:DrawEditApp);
Procedure DWLineAbsolute(Var Q:DrawEditApp);
Procedure DWLinePolaires(Var Q:DrawEditApp);
Procedure DWLineRelative(Var Q:DrawEditApp);
Procedure DWPointAbsolute(Var Q:DrawEditApp);
Function  DWPutFont(Var Q:DrawEditApp;X,Y:Word;Const S:String):Word;
Procedure DWPasteClipboard2Image(Var Q:DrawEditApp;X,Y:Word);
Procedure DWRectAbsolute(Var Q:DrawEditApp);
Procedure DWRectRelative(Var Q:DrawEditApp);
Procedure DWFullScrn(Var Q:DrawEditApp);
Function  DWNew(Var Q;X1,Y1,X2,Y2:Byte):Boolean;
Procedure DWOpen(Var Q;X1,Y1,X2,Y2:Byte;Const Path:String);
Procedure DWRefresh(Var Q);
Procedure DWSetMode(Var Q:DrawEditApp;M:Byte);
Function  DWGetMode(Var Q:DrawEditApp):Byte;
Function  DWSaveAs(Var Context;Const FileName:String):Boolean;
Function  DWSave(Var Q):Boolean;
Procedure DWScrollDn(Var Q:DrawEditApp);
Function  DWTitle(Var Q;Max:Byte):String;
Procedure DWMove2(Var Context;X,Y:Byte);
Procedure DWReSize(Var Context;X1,Y1,X2,Y2:Byte);
Procedure DWMagnify(Var Q:DrawEditApp;X:Boolean);
Procedure DWUpDateButton(Var Q:DrawEditApp);
Function  DWDone(Var Context):Word;
Procedure WIInit(Var Inf:MCanvas;WI:WIRec);
Procedure WISetWnTxt(Var Inf:MCanvas;X1,Y1,X2,Y2:Byte;InitAll:Boolean);
Function  WIIsInit(Var Inf:MCanvas):Boolean;
Function  WIXMoveWn(Var Inf:MCanvas):Word;
Function  WIYMoveWn(Var Inf:MCanvas):Word;
Procedure WIDraw(Var Inf:MCanvas;Const S:String);
Procedure WIMoveWnX(Var Inf:MCanvas;X:Integer);
Procedure WIMoveWnY(Var Inf:MCanvas;Y:Integer);
Procedure WIMoveWn(Var Inf:MCanvas;X,Y:Integer);
Procedure WICopyAllLn(Var Inf:MCanvas;Y:Wd;Var XBuf);
Procedure WICopyAllLnNoUpDate(Var Inf:MCanvas;Y:Word;Var XBuf);
Procedure WISetColor(Var Inf:MCanvas;Color:Word);
Procedure WIFloodFill(Var Q:MCanvas;X,Y:Integer);
Procedure WIPutFillBox(Var Inf:MCanvas;X1,Y1,X2,Y2:Word);
Procedure WIPutFillRoundRect(Var Q:MCanvas;x1,y1,x2,y2,b:Integer);
Procedure WIPutRect(Var Inf:MCanvas;X1,Y1,X2,Y2:Word);
Procedure WIPutRoundRect(Var Q:MCanvas;x1,y1,x2,y2,LineWidth,b:Integer);
Procedure WIPutTTextXY(Var Inf:MCanvas;X,Y:Word;Height:Byte;Const S:String);
Procedure WIPutLnHor(Var Inf:MCanvas;X1,Y,X2:Word);
Procedure WIPutPixel(Var Inf:MCanvas;X,Y:Word);
Procedure WISetPixel(Var Inf:MCanvas;X,Y:Word;Color:LongInt);
Procedure WIPutLine(Var Inf:MCanvas;X1,Y1,X2,Y2:Integer);
Procedure WIUpDateLn(Var Inf:MCanvas;Y:Word);
Function  WIGetPixel(Var Inf:MCanvas;X,Y:Word):Word;
Procedure WIDone(Var Inf:MCanvas);
{$ENDIF}

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                                 IMPLEMENTATION
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

{$IFDEF Graf}
Uses
 Adele,Memories,Apps,Systems,Video,Mouse,dialex,Dials,
 Restex,ResLoadI,ResSaveI,ResServI,DialPlus,Goldnaxe,Math,
 FontMana,Numerix,DrawKr,DrawInfo,DrawTxtu,DrawMacr,DrawMove;

Procedure DWPoint(Var Q:DrawEditApp;X,Y:Word);Near;Forward;
Procedure DWPush(Var Q:DrawEditApp);Near;Forward;
Procedure DWPutCur(Var Q:DrawEditApp;Kr:Byte);Near;Forward;
Procedure FillBool(Var X;Len:Word;Value:Boolean);Near;Forward;
Procedure FillBoolAt(Var X;At,Len:Word;Value:Boolean);Near;Forward;
Procedure FillQuartet(Var X;Len:Word;Value:Byte);Near;Forward;
Procedure WIPutLineHor(Var Q:MCanvas;X1,Y,X2:Word);Near;Forward;
Function  InputSize(Var Inf:WIRec):Boolean;Near;Forward;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Proc‚dure FillBool                          Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure fixe des bits  … la valeur de la variable de param‚trage
 ®Value¯ en m‚moire conventionnel (en mode r‚el) sous la longueur en bits:
 Len.
}

Procedure FillBool{Var X;Len:Word;Value:Boolean};
Var
 VX,EB:Byte;
 W:Word;
 XB:^TByte Absolute X;
Begin
 VX:=Byte(Value)*$FF;
 FillChr(X,Len shr 3,VX);
 EB:=Len and 7;
 If EB>0Then Begin
  W:=(Len shr 3)+1;
  If(Value)Then XB^[W]:=XB^[W]or($FFshr(8-EB))
           Else XB^[W]:=XB^[W]and Not($FFshr(8-EB))
 End
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Proc‚dure FillBoolAt                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure fixe des bits … la valeur de la variable de param‚trage
 ®Value¯ en m‚moire conventionnel (en mode r‚el)  … partir de la position
 en bits et de la longueur en bits: Len.
}

Procedure FillBoolAt{Var X;At,Len:Wd;Value:Boolean};
Var
 VX,EB:Byte;
 XB:^TByte Absolute X;
 AtHi:Word;
Begin
 If At=0Then FillBool(X,Len,Value)
  Else
 Begin
  AtHi:=At shr 3; At:=At and 7;
  If(Value)Then XB^[0]:=XB^[0]or($FFshl At)
           Else XB^[0]:=XB^[0]and Not($FFshr At);
  FillBool(XB^[1+AtHi],Len-At,Value)
 End
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Proc‚dure FillQuartet                      Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet d'initialiser les quartets (au nombre de deux
 par octet) avec la valeur sp‚cifi‚e.
}

Procedure FillQuartet(Var X;Len:Word;Value:Byte);Begin
 ASM
  MOV AL,Value
  {$IFOPT G+}
   SHL AL,4
  {$ELSE}
   MOV CL,4
   SHL AL,CL
  {$ENDIF}
  OR  Value,AL
 END;
 FillChr(X,Len shr 1,Value);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Fonction ScrnBytesPerLine                    Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Portabilit‚:  Local


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction retourne le nombre d'octets par ligne d'‚cran au niveau
 logique et non pas au niveau physique.
}

Function ScrnBytesPerLine(NumXPixels:Word):Word;Begin
 ScrnBytesPerLine:=LocalBytesPerLine(NumXPixels,BitsPerPixel);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                    Proc‚dure DWCopyImage2Clipboard               Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Portabilit‚:  Global
 Propri‚taire: DrawWins


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de copier l'image sur le presse-papier.
}

Procedure DWCopyImage2Clipboard(Var Q:DrawEditApp);Begin
 RICopy2Clipboard(Q.Canvas.Image);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Proc‚dure DWCopyBox2Clipboard                 Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Portabilit‚:  Global
 Propri‚taire: DrawWins


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de copie une boŒte sp‚cifier par les coordonn‚es
 (X1,Y1)-(X2,Y2) dans le presse-papier.
}

Procedure DWCopyBox2Clipboard(Var Q:DrawEditApp;X1,Y1,X2,Y2:Word);
Var
 Res:ImageHeaderRes;           { Entˆte de ressource destinataire }
 Buffer:Array[0..4095]of Byte; { Tampon de transfert de donn‚es }
 I:Word;                       { Variable de compteur de boucle }
 FS,FT:Long;                   { Position source et destination }
Begin
 If(X1>X2)Then SwapWord(X1,X2);
 If(Y1>Y2)Then SwapWord(Y1,Y2);
 Res:=Q.Canvas.Res;Res.Shadow:=False;
 Res.NumXPixels:=X2-X1+1;Res.NumYPixels:=Y2-Y1+1;
 FS:=LongInt(Y1)*LongInt(Q.Canvas.Res.BytesPerLine)+
     LongInt(LocalBytesPerLine(X1,Res.BitsPerPixel))+SizeOf(Res);
 FT:=SizeOf(Res);
 Res.BytesPerLine:=LocalBytesPerLine(Res.NumXPixels,Res.BitsPerPixel);
 MakeClipboard(SizeOf(Res)+Long(Res.BytesPerLine)*Long(Res.NumYPixels)+
               LongInt(Res.NumPal*3));
 SetAbsClipboard(0,SizeOf(Res),Res);
 For I:=Y1 to(Y2)do Begin
  XGetAbsRec(Q.Canvas.Image,FS,Res.BytesPerLine,Buffer);
  SetAbsClipboard(FT,Res.BytesPerLine,Buffer);
  Inc(FS,LongInt(Q.Canvas.Res.BytesPerLine));
  Inc(FT,LongInt(Res.BytesPerLine));
 End;
 If Res.NumPal>0Then Begin
  XGetAbsRec(Q.Canvas.Image,FS,Res.NumPal*3,Buffer);
  SetAbsClipboard(FT,Res.NumPal*3,Buffer);
 End;
End;

Function RGB2KrX(BitsPerPixel,R,G,B:Byte):Word;
Var
 Kr:Byte;
Begin
 Case(BitsPerPixel)of
  4:Begin
   If(R)and$80=$80Then Kr:=Kr or$04;
   If(R)and$40=$40Then Kr:=Kr or$20;
   If(G)and$80=$80Then Kr:=Kr or$02;
   If(G)and$40=$40Then Kr:=Kr or$10;
   If(B)and$80=$80Then Kr:=Kr or$01;
   If(B)and$40=$40Then Kr:=Kr or$08;
   RGB2KrX:=Kr and$F;
  End;
  8:RGB2KrX:=64+(B shr 6)+((G shr 5)shl 2)+((R and$C0)shr 1);
  15:RGB2KrX:=((B shr 2)+((((G and$F8)shl 3)+((R and$F8)shl 8))))shr 1;
  16:RGB2KrX:=(B shr 3)+((((G and$F8)shl 3)+((R and$F8)shl 8)))
 End;
End;

Procedure ConvPixel(SBitsPerPixel,TBitsPerPixel:Byte;NumXPixels:Word;Const Palette;Var Buf);
Var I:Word;SB,SB1,SB2:Byte;
    ByteBuf:TByte Absolute Buf;
    WordBuf:TWord Absolute Buf;
    PaletteRGB:Palette256RGB Absolute Palette;
Begin
 Case(SBitsPerPixel)of
  4:Case(TBitsPerPixel)of
   8:Begin
    For I:=(NumXPixels-1)shr 1downto 0do Begin
     SB:=ByteBuf[I];
     ByteBuf[I shl 1]:=SB shr 4;
     ByteBuf[(I shl 1)+1]:=SB and$F;
    End;
   End;
   9..16:Begin
    For I:=(NumXPixels-1)shr 1downto 0do Begin
     SB:=ByteBuf[I];SB1:=SB shr 4;SB2:=SB and$F;
     WordBuf[I shl 1]:=RGB2KrX(TBitsPerPixel,DefaultRGB[SB1].R,DefaultRGB[SB1].G,DefaultRGB[SB1].B);
     WordBuf[(I shl 1)+1]:=RGB2KrX(TBitsPerPixel,DefaultRGB[SB2].R,DefaultRGB[SB2].G,DefaultRGB[SB2].B);
    End;
   End;
  End;
  8:Case(TBitsPerPixel)of
   15,16:Begin
    For I:=NumXPixels-1downto 0do Begin
     SB:=ByteBuf[I];
     WordBuf[I]:=RGB2KrX(TBitsPerPixel,PaletteRGB[SB].R,PaletteRGB[SB].G,PaletteRGB[SB].B);
    End;
   End;
  End;
  24:Line2Doublon(Buf,Buf,Buf,BitsPerPixel,24,NumXPixels);
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                    Proc‚dure DWPasteClipboard2Image              Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Portabilit‚:  Global
 Propri‚taire: DrawWins


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de coller une image sur l'image actuellement
 en traŒtement.
}

Procedure DWPasteClipboard2Image(Var Q:DrawEditApp;X,Y:Word);
Var
 SRes:ImageHeaderRes;       { Entˆte de ressource source }
 Buf:Array[0..4095]of Byte; { Tampon de transfert de donn‚es }
 J:Word;                    { Variable de compteur de boucle }
 SP,TP,BL:LongInt;          { Position Source et Destination }
 BytesPerLine:Word;         { Octets par ligne de l'image en nouveau format de couleur }
 Palette:Palette256RGB;     { Palette de couleur … utiliser }
Begin
 GetAbsClipboard(0,SizeOf(SRes),SRes);
  {Presse-papier contient une image valide?}
 If(SRes.ID<>idResImage)or(Byte(SRes.Shadow)>1)Then Exit;
  {Ligne d'image trop grande?}
 If SRes.BytesPerLine>SizeOf(Buf)Then Begin
  ErrNoMsgOk(errImageLineTooBig);
  Exit;
 End;
 If(Y>Q.Canvas.Res.NumYPixels)Then Exit; { Copie en dehors de l'image? }
 SP:=SizeOf(SRes);
 BL:=SizeOf(Q.Canvas.Res)+LongInt(Q.Canvas.Res.BytesPerLine)*LongInt(Q.Canvas.YMove+Y);
 TP:=BL+Long(LocalBytesPerLine(Q.Canvas.XMove+X,Q.Canvas.Res.BitsPerPixel));
 BytesPerLine:=LocalBytesPerLine(SRes.NumXPixels,Q.Canvas.Res.BitsPerPixel);
 If BytesPerLine=0Then Begin
  ErrNoMsgOk(errCopyImageEmpty);
  Exit;
 End;
 If SRes.NumPal<>0Then Begin
   { S‚curit‚ pour donn‚es invraisemblable...}
  If SRes.NumPal>256Then SRes.NumPal:=256;
   { Chargement de la palette de couleur contenu dans le presse-papier }
  GetAbsClipboard(Long(SRes.BytesPerLine)*
                  Long(SRes.NumYPixels)+
                  Long(SizeOf(SRes)),SRes.NumPal*3,Palette);
 End
  Else
 Begin
  FillClr(Palette,SizeOf(Palette));
  MoveLeft(DefaultRGB,Palette,SizeOf(DefaultRGB));
 End;
 If(SRes.NumXPixels>Q.Canvas.Res.NumXPixels)Then Begin { Image trop grande pour le dessin? }
  If(WarningMsgYesNo('Image trop grande pour le dessin. '+
                     'Appliquer un ajustement scalaire?')=kbYes)Then Begin
   _RIPutScale(Clipboard,1,1,Q.Canvas.Res.NumXPixels,Q.Canvas.Res.NumYPixels,
               Q.Canvas.Res.BitsPerPixel,[wiCopy2Target],Q.Canvas.Image);
   XFreeMem(Q.Canvas.Miroir);
   RIMakeDoublon(Q.Canvas.Image,rmAllResSteady,False,Q.Canvas);
   DWRefresh(Q);
   Exit;
  End;
 End;
 For J:=0to SRes.NumYPixels-1do Begin
  GetAbsClipboard(SP,SRes.BytesPerLine,Buf);
  Inc(SP,LongInt(SRes.BytesPerLine));
  ConvPixel(SRes.BitsPerPixel,Q.Canvas.Res.BitsPerPixel,
            SRes.NumXPixels,Palette,Buf);
  XSetAbsRec(Q.Canvas.Image,TP,BytesPerLine,Buf);
  Inc(TP,LongInt(Q.Canvas.Res.BytesPerLine));
  XGetAbsRec(Q.Canvas.Image,BL,Q.Canvas.Res.BytesPerLine,Buf);
  Inc(BL,LongInt(Q.Canvas.Res.BytesPerLine));
  WICopyAllLn(Q.Canvas,Y,Buf);
  Inc(Y);
  If(Y>Q.Canvas.Res.NumYPixels)Then Break;
 End;
End;

Function DWScaleForm(Var Q:DrawEditApp;Var Width,Height:Word):Boolean;
Var
 FormScale:Record
  Width:Word;
  Height:Word;
 End;
Begin
 DWScaleForm:=False;
 FillClr(FormScale,SizeOf(FormScale));
 FormScale.Width:=Width;
 FormScale.Height:=Height;
 If ExecuteAppDPU(125,FormScale)Then Begin
  Width:=FormScale.Width;
  Height:=FormScale.Height;
  DWScaleForm:=True;
 End;
End;

Procedure DWScale(Var Q:DrawEditApp;X,Y:Word);
Var
 Width,Height:Word;
 ClipboardRes:ImageHeaderRes;
 Tmp:XInf;
 SRes:ImageHeaderRes;       { Entˆte de ressource source }
 SP,TP,BL:LongInt;          { Position Source et Destination }
 Palette:Palette256RGB;     { Palette de couleur … utiliser }

 Procedure CopyToImage;
 Var
  Buf:Array[0..4095]of Byte; { Tampon de transfert de donn‚es }
  J:Word;                    { Variable de compteur de boucle }
 Begin
  For J:=0to SRes.NumYPixels-1do Begin
   XGetAbsRec(Tmp,SP,SRes.BytesPerLine,Buf);
   Inc(SP,LongInt(SRes.BytesPerLine));
   XSetAbsRec(Q.Canvas.Image,TP,SRes.BytesPerLine,Buf);
   Inc(TP,LongInt(Q.Canvas.Res.BytesPerLine));
   XGetAbsRec(Q.Canvas.Image,BL,Q.Canvas.Res.BytesPerLine,Buf);
   Inc(BL,LongInt(Q.Canvas.Res.BytesPerLine));
   WICopyAllLn(Q.Canvas,Y,Buf);
   Inc(Y);
   If(Y>Q.Canvas.Res.NumYPixels)Then Break;
  End;
 End;

Begin
 GetAbsClipboard(0,SizeOf(ClipboardRes),ClipboardRes);
 Width:=ClipboardRes.NumXPixels;
 Height:=ClipboardRes.NumYPixels;
 If DWScaleForm(Q,Width,Height)Then Begin
  If(Width=ClipboardRes.NumXPixels)and(Height=ClipboardRes.NumYPixels)Then Begin
   DWPasteClipboard2Image(Q,X,Y);
  End
   Else
  Begin
   SP:=SizeOf(SRes);
   BL:=SizeOf(Q.Canvas.Res)+LongInt(Q.Canvas.Res.BytesPerLine)*LongInt(Q.Canvas.YMove+Y);
   TP:=BL+Long(LocalBytesPerLine(Q.Canvas.XMove+X,Q.Canvas.Res.BitsPerPixel));
   _RIPutScale(Clipboard,0,0,Width-1,Height-1,Q.Canvas.Res.BitsPerPixel,[wiCopy2Target],Tmp);
   XGetAbsRec(Tmp,0,SizeOf(SRes),SRes);
   CopyToImage;
   XFreeMem(Tmp);
   DWRefresh(Q);
  End;
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Proc‚dure DWSelectFont                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Portabilit‚:  Global
 Propri‚taire: DrawWins


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de s‚lectionner la police de caractŠres souhaiter
 pour le programme de dessin.
}

Procedure DWSelectFont(Var Q:DrawEditApp);
Var
 OldQQF:Pointer;
 OldQQFSize:Word;
 OldQQFHeight:Byte;
 OldPathFont:String;
Begin
 If SelectFont(Q.FontType)Then Begin
  OldQQF:=QQF;
  OldQQFSize:=QQFSize;
  OldQQFHeight:=QQFHeight;
  OldPathFont:=PathFont;
  QQF:=NIL;
  QQFSize:=0;
  QQFHeight:=0;
  PathFont:='';
  LoadQQF({Q.FontType.Path+'|'+}Q.FontType.Index.Name);
  Pointer(Q.QQF):=QQF;
  Q.QQFSize:=QQFSize;
  Q.QQFHeight:=QQFHeight;
  Q.PathFont:=PathFont;
  QQF:=OldQQF;
  QQFSize:=OldQQFSize;
  QQFHeight:=OldQQFHeight;
  PathFont:=OldPathFont;
  Q.Mode:=drwText;
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Proc‚dure DWLineAbsolue                      Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Portabilit‚:  Global
 Propri‚taire: DrawWins


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure offre … l'utilisateur la possibilit‚ d'‚crire une ligne
 avec des coordonn‚es absolue rentrer manuellement.
}

Procedure DWLineAbsolute(Var Q:DrawEditApp);
Var
 Data:Record
  X1,Y1,X2,Y2:Word;
 End;
Begin
 FillClr(Data,SizeOf(Data));
 If ExecuteAppDPU(8,Data)Then Begin
  WIPutLine(Q.Canvas,Data.X1,Data.Y1,Data.X2,Data.Y2);
  Q.Modified:=True;
  Q.Canvas.DrawX:=Data.X2;
  Q.Canvas.DrawY:=Data.Y2;
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Proc‚dure DWLineRelative                      Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Portabilit‚:  Global
 Propri‚taire: DrawWins


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure offre  … l'utilisateur la possibilit‚ d'‚crire une ligne
 avec un coordonn‚e absolue … partir de la position pr‚c‚dente devant ˆtre
 rentrer manuellement.
}

Procedure DWLineRelative(Var Q:DrawEditApp);
Var
 Data:Record
  X2,Y2:Word;
 End;
Begin
 FillClr(Data,SizeOf(Data));
 If ExecuteAppDPU(9,Data)Then Begin
  WIPutLine(Q.Canvas,Q.Canvas.DrawX,Q.Canvas.DrawY,Data.X2,Data.Y2);
  Q.Canvas.DrawX:=Data.X2;Q.Canvas.DrawY:=Data.Y2;Q.Modified:=True;
 End;
End;

Procedure DWSelectSizeBrush(Var Q:DrawEditApp);
Var
 Data:Record
  Length,Height:Word;
 End;
Begin
 Data.Length:=Q.LengthBrush;
 Data.Height:=Q.HeightBrush;
 If ExecuteAppDPU(10,Data)Then Begin
  Q.LengthBrush:=Data.Length;Q.HeightBrush:=Data.Height;
 End;
End;

Procedure DWLinePolaires(Var Q:DrawEditApp);
Var
 Data:Record
  X,Y,Len,Degree,Minute,Second:Word;
  Angle:Real;
 End;
 AX2,AY2:Word;
Begin
 FillClr(Data,SizeOf(Data));
 If ExecuteAppDPU(11,Data)Then Begin
  Data.Angle:=(PI/180)*(360-(Data.Degree+(Data.Minute/60)+(Data.Second/360)));
  AX2:=Data.X+Trunc(Cos(Data.Angle)*Data.Len);AY2:=Data.Y+Trunc(Sin(Data.Angle)*Data.Len);
  WIPutLine(Q.Canvas,Data.X,Data.Y,AX2,AY2);
  Q.Canvas.DrawX:=AX2;Q.Canvas.DrawY:=AY2;Q.Modified:=True;
 End;
End;

Procedure DWRectAbsolute(Var Q:DrawEditApp);
Var
 Data:Record
  X1,Y1,X2,Y2:Word;
 End;
Begin
 FillClr(Data,SizeOf(Data));
 If ExecuteAppDPU(12,Data)Then Begin
  WIPutRect(Q.Canvas,Data.X1,Data.Y1,Data.X2,Data.Y2);
  Q.Canvas.DrawX:=Data.X2;Q.Canvas.DrawY:=Data.Y2;Q.Modified:=True;
 End;
End;

Procedure DWCircle3Point(Var Q:DrawEditApp);
Var
 Data:Record
  X1,Y1,X2,Y2,X3,Y3:Word;
 End;
 XC,YC,X0,Y0,X1,Y1,X2,Y2,X3,Y3,H2,H3,K2,K3,Rad:Integer;
Begin
 FillClr(Data,SizeOf(Data));
 If ExecuteAppDPU(122,Data)Then Begin
  H2:=((Y1+Y2)shr 1)+((Sqr(x2))-((Sqr(x1))div((Y2-Y1)shl 1)));
  H3:=((Y1+Y2)shr 1)+((Sqr(x3))-((Sqr(x1))div((Y2-Y1)shl 1)));
  If Y2-Y1=0Then K2:=0
            Else K2:=-((x2-x1)div(y2-y1));
  If Y3-Y1=0Then K3:=0
            Else k3:=-((x3-x1)div(y3-y1));
  If K2-K3=0Then Begin
   X0:=0;Y0:=0;
  End
   Else
  Begin
   X0:=(H3-H2)div(K2-K3);
   Y0:=((K3*H2)-(K2*H3))div(K3-K2);
  End;
  XC:=(h3-h2)div(k2-k3);
  YC:=((K3*H2)-(K2*H3))div(K3-K2);
  If(X1-X0=0)or(Y1-Y0=0)Then Rad:=0
  Else Rad:=Trunc(Sqrt(((Sqr(X1-X0))+(Sqr(Y1-Y0)))));
  WIPutRoundRect(Q.Canvas,XC-Rad,YC-Rad,XC+Rad,YC+Rad,1,Rad);
 End;
End;

Procedure DWRectRelative(Var Q:DrawEditApp);
Var
 Data:Record
  X2,Y2:Word;
 End;
Begin
 FillClr(Data,SizeOf(Data));
 If ExecuteAppDPU(13,Data)Then Begin
  WIPutRect(Q.Canvas,Q.Canvas.DrawX,Q.Canvas.DrawY,Data.X2,Data.Y2);
  Q.Canvas.DrawX:=Data.X2;
  Q.Canvas.DrawY:=Data.Y2;
  Q.Modified:=True;
 End;
End;

Procedure DWFillBoxAbsolute(Var Q:DrawEditApp);
Var
 Data:Record
  X1,Y1,X2,Y2:Word;
 End;
Begin
 FillClr(Data,SizeOf(Data));
 If ExecuteAppDPU(14,Data)Then Begin
  WIPutFillBox(Q.Canvas,Data.X1,Data.Y1,Data.X2,Data.Y2);
  Q.Canvas.DrawX:=Data.X2;
  Q.Canvas.DrawY:=Data.Y2;
  Q.Modified:=True;
 End;
End;

Procedure DWFillBoxRelative(Var Q:DrawEditApp);
Var
 Data:Record
  X2,Y2:Word;
 End;
Begin
 FillClr(Data,SizeOf(Data));
 If ExecuteAppDPU(15,Data)Then Begin
  WIPutFillBox(Q.Canvas,Q.Canvas.DrawX,Q.Canvas.DrawY,Data.X2,Data.Y2);
  Q.Canvas.DrawX:=Data.X2;
  Q.Canvas.DrawY:=Data.Y2;
  Q.Modified:=True;
 End;
End;

Procedure DWPointAbsolute(Var Q:DrawEditApp);
Var
 Data:Record
  X2,Y2:Word;
 End;
Begin
 FillClr(Data,SizeOf(Data));
 If ExecuteAppDPU(16,Data)Then Begin
  If(Data.X2>Q.Canvas.Res.NumXPixels)or
    (Data.Y2>Q.Canvas.Res.NumYPixels)Then ErrNoMsgOk(errPointOutOfLimit)
   Else
  Begin
   DWPoint(Q,Data.X2,Data.Y2);
   Q.Canvas.DrawX:=Data.X2;
   Q.Canvas.DrawY:=Data.Y2;
   Q.Modified:=True;
  End;
 End;
End;

Procedure DWUpDateButton{Var Q:DrawWins};
Var
 XB,YB:Byte;
 GX1,GY1:Word;
 Buffer:Array[0..4095]of Byte;
 I,N:Word;
 Show:Boolean;
Begin
 XB:=$FF;YB:=$FF;
 Case(Q.Mode)of
  drwGetPixel:Begin
   XB:=0;YB:=0;
  End;
  drwCopy:Begin
   XB:=1;YB:=0;
  End;
  drwTrace:Begin
   XB:=2;YB:=0;
  End;
  drwLine:Begin
   XB:=2;YB:=1;
  End;
  drwText:Begin
   XB:=0;YB:=2;
  End;
  drwBox:Begin
   YB:=3;
   XB:=Byte(Q.Fill);
  End;
  drwCadre:Begin
   YB:=4;
   XB:=Byte(Q.Fill);
  End;
  drwManyLine:Begin
   XB:=1;YB:=2;
  End;
  drwBrush:Begin
   XB:=1;YB:=1;
  End;
  drwPaint:Begin
   XB:=2;YB:=2;
  End;
 End;
 If(XB<>$FF)and(YB<>$FF)Then Begin
  GX1:=(Q.ButtonDraw.X shl 3)+XB shl 5;
  If HeightChr=16Then GY1:=YB shl 1
                 Else GY1:=YB shl 2;
  GY1:=GetRawY(GY1+Q.ButtonDraw.Y);
  N:=GetSizeSmlImg(0,0,31,31);
  If N>SizeOf(Buffer)Then N:=SizeOf(Buffer);
  Show:=IsShowMouse;
  If(Show)Then Begin
   __HideMousePtr;
   BMLoadAllVert(Q.ButtonDraw,'SYS:MBDRAW.ICN',WEGetRX1(Q.W),WEGetRY1(Q.W),3);
  End;
  GetSmlImg(GX1,GY1,GX1+31,GY1+31,Buffer);
  For I:=0to N-1do Buffer[I]:=Not Buffer[I];
  PutSmlImg(GX1,GY1,GX1+31,GY1+31,Buffer);
  If(Show)Then Begin
   __ShowMousePtr;
   WaitMouseBut0;
  End;
 End;
End;

Procedure RGBColor(Value:Word;Var Context);
Var
 Q:DrawEditApp Absolute Context;
 ColorRGB:RGB;
Begin
 ColorRGB.R:=Q.Canvas.PaletteRGB^[Value].R;
 ColorRGB.G:=Q.Canvas.PaletteRGB^[Value].G;
 ColorRGB.B:=Q.Canvas.PaletteRGB^[Value].B;
 If ChoiceRGBColor(ColorRGB)Then Begin
  Q.Canvas.PaletteRGB^[Value].R:=ColorRGB.R;
  Q.Canvas.PaletteRGB^[Value].G:=ColorRGB.G;
  Q.Canvas.PaletteRGB^[Value].B:=ColorRGB.B;
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Proc‚dure DWSetColor                      Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Portabilit‚:  Global
 Propri‚taire: DrawWins


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de s‚lectionner une couleur dans la palette de
 couleur du dessin.
}

Procedure DWSetColor(Var Q:DrawEditApp);

 Procedure HighColor;
 Var
  ColorRGB:RGB;
 Begin
  FillClr(ColorRGB,SizeOf(ColorRGB));
  Case(Q.Canvas.Res.BitsPerPixel)of
   15:Begin
    ColorRGB.B:=(Q.Canvas.CurrColor and$1F)shl 3;
    ColorRGB.G:=((Q.Canvas.CurrColor shr 5)and$1F)shl 3;
    ColorRGB.R:=((Q.Canvas.CurrColor shr 10)and$1F)shl 3;
   End;
   16,24:Begin
    ColorRGB.B:=(Q.Canvas.CurrColor and$3F)shl 2;
    ColorRGB.G:=((Q.Canvas.CurrColor shr 6)and$1F)shl 3;
    ColorRGB.R:=((Q.Canvas.CurrColor shr 11)and$1F)shl 3;
   End;
  End;
  If ChoiceRGBColor(ColorRGB)Then Begin
   Q.Canvas.CurrColor:=RGB2KrX(Q.Canvas.Res.BitsPerPixel,ColorRGB.R,
                               ColorRGB.G,ColorRGB.B);
  End;
 End;

 Procedure SetPaletteColor;
 Var
  Data:Record
   Color:Byte;
   OnMouseButton2:Procedure(Value:Word;Var Context);
   Context:Pointer;
   Palette:Pointer;
  End;
  PaletteMono:Array[0..1]of RGB;
 Begin
  FillClr(Data,SizeOf(Data));
  Data.Color:=Q.Canvas.CurrColor;
  If Q.Canvas.Struct.BitsPerPixel<4Then Begin
   Data.Color:=Data.Color and Pred(1 shl Q.Canvas.Struct.BitsPerPixel);
  End;
  If(Q.Canvas.PaletteRGB<>NIL)Then Begin
   Data.OnMouseButton2:=RGBColor;
   Data.Context:=@Q;
   Data.Palette:=Q.Canvas.PaletteRGB;
  End
   Else
  Begin
   If Q.Canvas.Res.BitsPerPixel=1Then Begin
    FillClr(PaletteMono,SizeOf(PaletteMono));
    PaletteMono[1].R:=$FF;
    PaletteMono[1].G:=$FF;
    PaletteMono[1].B:=$FF;
    Data.Palette:=@PaletteMono;
   End
    Else
   Data.Palette:=@DefaultRGB;
  End;
  If ExecuteAppDPU(48-1+Q.Canvas.Struct.BitsPerPixel,Data)Then Begin
   Q.Canvas.CurrColor:=Data.Color;
  End;
 End;

Begin
 If Q.Canvas.Res.BitsPerPixel>=15Then Begin
  If __GetMouseButton>0Then WaitMouseBut0;
  HighColor;
 End
  Else
 If Q.Canvas.Res.BitsPerPixel<=8Then SetPaletteColor;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Proc‚dure DWPutCadre                      Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Portabilit‚:  Local
 Propri‚taire: DrawWins


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure affiche la rŠgles et les ic“nes tout autour du dessin
 de l'objet ®DrawWins¯.
}

Procedure DWPutCadre(Var Q:DrawEditApp);Near;
Var
 J,I,H,YW,GX1,GY1,GX2,KrHigh:Word;
 MatrixLeft,MatrixRight:Array[0..3]of Word; { Bordure en 15 et 16 bits de couleurs }
Begin
 WESetEndBar(Q.W,CurrKrs.Desktop.DialStatus);
 If(IsGrf)Then Begin
  BarSpcHorRelief(Q.W.T.X1,Q.W.T.Y2,Q.W.T.X1+15,CurrKrs.Desktop.DialStatus);
  BarSpcHorReliefExt(Q.W.T.X1+1,Q.W.T.Y2,Q.W.T.X1+14,CurrKrs.Desktop.DialStatus);
  BarSpcHorRelief(Q.W.T.X1+16,Q.W.T.Y2,Q.W.T.X2,CurrKrs.Desktop.DialStatus);
  BarSpcHorReliefExt(Q.W.T.X1+17,Q.W.T.Y2,Q.W.T.X2-2,CurrKrs.Desktop.DialStatus);
  LuxeBox(Q.W.T.X2-1,Q.W.T.Y2);
 End
  Else
 WESetEndBarTxtX(Q.W,16,'³',CurrKrs.Desktop.DialStatus);
 WESetEndBarTxtX(Q.W,18,WordToStr(Q.Canvas.Res.NumXPixels)+
                 'x'+WordToStr(Q.Canvas.Res.NumYPixels)+'c'+
	         IntToStr(LongInt(1) shl Long(Q.Canvas.Struct.BitsPerPixel))+':'+
                 BasicStr(Long(Q.Canvas.Res.BytesPerLine)*
	         Long(Q.Canvas.Res.NumYPixels))+' octet(s)',
                 CurrKrs.Desktop.DialStatus);
 If(IsGraf)Then Begin
  BMLoadAllVert(Q.ButtonDraw,'SYS:MBDRAW.ICN',WEGetRX1(Q.W),WEGetRY1(Q.W),3);
  DWUpDateButton(Q);
  GY1:=GetRawY(WEGetRY1(Q.W)+BMUseYTexts(Q.ButtonDraw));
  GX1:=WEGetRX1(Q.W)shl 3;
  GX2:=(WEGetRX1(Q.W)+11)shl 3;
  Q.Canvas.MagnifyX:=GX1+8;
  Q.Canvas.MagnifyY:=GY1+8;
  Q.Canvas.MagnifyLength:=GX2-GX1-16;
  If BitsPerPixel>=15Then Begin
   For J:=0to 3do Begin
    KrHigh:=((3-J)shl 6)+63;
    MatrixLeft[J]:=RGB2Color(KrHigh,KrHigh,KrHigh+(J shl 6));
    MatrixRight[3-J]:=RGB2Color(0,0,J shl 6);
   End;
   For J:=GY1 to GetRawY(WEGetRY1(Q.W)+Q.W.MaxY+1)do Begin
    ClrLnHorImg(GX1,J,4,BitsPerPixel,MatrixLeft);
    PutLnHor(GX1+4,J,GX2+3,9);
    ClrLnHorImg(GX2+4,J,4,BitsPerPixel,MatrixRight)
   End;
  End
   Else
  For J:=GY1 to GetRawY(WEGetRY1(Q.W)+Q.W.MaxY+1)do Begin
   ClrLnHorImg(GX1,J,4,8,MatrixBorderLeft);
   PutLnHor(GX1+4,J,GX2+3,9);
   ClrLnHorImg(GX2+4,J,4,8,MatrixBorderRight)
  End;
  For J:=0to 3do Begin
   PutLnHor(GX1+J,GY1+J,GX2+7-J,48+(J shl 2));
   PutLnHor(GX1+J,GetRawY(WEGetRY1(Q.W)+Q.W.MaxY+1)-1-J,GX2+7-J,252+J)
  End;
   { Affiche la rŠgle }
  Q.W.CurrColor:=$7F;
  Adele.LeftIcon(Q.W.T.X1+12+Byte(Q.W.NotFullScrnX),Q.W.T.Y2-1,CurrKrs.Draw.Window.Icon);
  WEBarSpcHor(Q.W,14,wnMax,wnMax-2);
  WEBarSpcHorRelief(Q.W,14,wnMax,wnMax-2);
  Adele.RightIcon(Q.W.T.X2-3,Q.W.T.Y2-1,CurrKrs.Draw.Window.Icon);
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                            Fonction DWTitle                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Portabilit‚:  Global
 Propri‚taire: DrawWins


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de connaŒtre le nom attribu‚ … cette application
 pour l'int‚gration au routine de la m‚thode ®H¯.
}

Function DWTitle(Var Q;Max:Byte):String;
Const
 Name='Editeur Dessin ';
Begin
 DWTitle:=Name+TruncName(DrawEditApp(Q).FileName,Max-Length(Name))
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                             Fonction DWInit                           Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Portabilit‚:  Global
 Propri‚taire: DrawWins


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure ouvre  un dessin existant  ou en cr‚e un  d‚pendament du
 contenu de la variable de param‚trage ®Path¯. Son contenu est se retrouve
 accessible par la variable objet de param‚trage ®Q¯.
}

Function DWInit;
Var
 Buf:^TByte;  { Tampon de transfert des lignes d'images }
 FS,FP,I:Long;{ Taille de la ressource, position dans la ressource, boucle }
 J:Wd;        { Variable compteur de boucle }

 Procedure Header;Begin
  WECloseIcon(Q.W);
  WEZoomIcon(Q.W);
  Inc(Inf.T.Y1);
  If(IsGraf)Then Begin
   Inc(Inf.T.X1,12);
   Inc(Inf.T.X1,Byte(Q.W.NotFullScrnX));
   Dec(Inf.T.X2);Dec(Inf.T.Y2,2);
  End;
  DWPutCadre(Q);
 End;

Begin
 FillClr(Q,SizeOf(Q));
 DWInit:=False;
 Q.OldHelpBarP:=-1;
 Q.Mode:=drwTrace;
 Q.LengthBrush:=16;              { Largeur par d‚faut de l'efface }
 Q.HeightBrush:=HeightChr shl 1; { Hauteur par d‚faut de l'efface }
 Q.XPtr:=$FFFF;Q.YPtr:=$FFFF;
 If Path=''Then Begin
  If Not InputSize(Inf)Then Exit;
 End
  Else
 If Path='NEWDRW:'Then Begin
  Path:='';
  Inf.BitsPerPixel:=BitsPerPixel;
  Inf.NumXPixels:=GetNumXPixels;
  Inf.NumYPixels:=GetNumYPixels;
 End;
 Q.FileName:=Path;
 WEInit(Q.W,Inf.T.X1,Inf.T.Y1,Inf.T.X2,Inf.T.Y2);
 Inf.T:=Q.W.T;
 If Path=''Then Begin
  WEPutWn(Q.W,'Pasnom',CurrKrs.Draw.Window);
  WEPutBarMsRight(Q.W);
  Q.Canvas.Res.ID:=idResImage;
  Q.Canvas.Res.Original:=diPCX;
  Q.Canvas.Res.BitsPerPixel:=Inf.BitsPerPixel;
  Q.Canvas.Res.NumXPixels:=Inf.NumXPixels;
  Q.Canvas.Res.NumYPixels:=Inf.NumYPixels;
  Q.Canvas.Res.BytesPerLine:=LocalBytesPerLine(Q.Canvas.Res.NumXPixels,Q.Canvas.Res.BitsPerPixel);
  Q.Canvas.Res.Format:=fdiBinary;
  Q.Canvas.Res.Index:=0;
  Q.Canvas.Res.NumPal:=0;
  Q.Canvas.Res.Shadow:=False;
  FillClr(Q.Canvas.Res.Descr,SizeOf(Q.Canvas.Res.Descr));
  If XAllocMem(rmAllResSteady,SizeOf(Q.Canvas.Res)+
  Long(Q.Canvas.Res.BytesPerLine)*Long(Q.Canvas.Res.NumYPixels),Q.Canvas.Image)Then Begin
    {Cr‚ation de la table des conversions des couleurs 24 bits … 7 bits}
   If Q.Canvas.Res.BitsPerPixel=8Then Begin
    Q.Canvas.PaletteRGB:=MemAlloc(SizeOf(Palette256RGB));
    If(Q.Canvas.PaletteRGB<>NIL)Then Begin
     GetPaletteRGB(Q.Canvas.PaletteRGB^,0,256);
     For I:=0to 255do Begin
      Q.Canvas.CT[I]:=64+(Q.Canvas.PaletteRGB^[I].B shr 6)+
                      ((Q.Canvas.PaletteRGB^[I].G shr 5)shl 2)+
                      ((Q.Canvas.PaletteRGB^[I].R and$C0)shr 1);
     End;
    End;
   End;
   If Inf.BitsPerPixel=8Then Inf.BaseColor:=$F
   Else Inf.BaseColor:=$FFFF and Not(1 shl Inf.BitsPerPixel);
   Q.Canvas.Struct:=Inf;
   Q.Canvas.Magnify:=Not(IsGraf);
   XSetAbsRec(Q.Canvas.Image,0,SizeOf(Q.Canvas.Res),Q.Canvas.Res);
   Header;
   WISetWnTxt(Q.Canvas,Inf.T.X1,Inf.T.Y1,Inf.T.X2-1,Inf.T.Y2,True);
   Q.Canvas.BitmapInit:=True;
   Buf:=MemAlloc(Q.Canvas.Res.BytesPerLine);
   If(Buf<>NIL)Then Begin
    Case(Q.Canvas.Res.BitsPerPixel)of
     1..3:FillChr(Buf^,Q.Canvas.Res.BytesPerLine,$FF);
     4:FillQuartet(Buf^,Q.Canvas.Res.NumXPixels,Inf.BaseColor);
     9..16:Begin
      FillWord(Buf^,Q.Canvas.Res.NumXPixels,Inf.BaseColor);
     End;
     24:FillChr(Buf^,Q.Canvas.Res.BytesPerLine,$FF);
     Else FillChr(Buf^,Q.Canvas.Res.NumXPixels,Inf.BaseColor);
    End;
    FP:=SizeOf(Q.Canvas.Res);
    For J:=0to Q.Canvas.Res.NumYPixels-1do Begin
     XSetAbsRec(Q.Canvas.Image,FP,Q.Canvas.Res.BytesPerLine,Buf^);
     Inc(FP,Long(Q.Canvas.Res.BytesPerLine));
    End;
    FreeMemory(Buf,Q.Canvas.Res.BytesPerLine);
   End
    Else
   Begin
    __OutOfMemory;
    Header;
   End;
  End
   Else
  Begin
   __OutOfMemory;
   Header;
  End;
 End
  Else
 Begin
  WEPutWn(Q.W,Path,CurrKrs.Draw.Window);
  WEPutBarMsRight(Q.W);
  ErrMsgRes(RILoadImage(Path,diAutoDetect,0,$FFFF,rmAllResSteady,[fpProgressBar,fpUserInterrupt],Q.Canvas.Image));
  XGetAbsRec(Q.Canvas.Image,0,SizeOf(Q.Canvas.Res),Q.Canvas.Res);
  Q.Canvas.Struct.BitsPerPixel:=Q.Canvas.Res.BitsPerPixel;
  Q.Canvas.Struct.NumXPixels:=Q.Canvas.Res.NumXPixels;
  Q.Canvas.Struct.NumYPixels:=Q.Canvas.Res.NumYPixels;
  Q.Canvas.Magnify:=Not(IsGraf);
  Header;
  WISetWnTxt(Q.Canvas,Inf.T.X1,Inf.T.Y1,Inf.T.X2-1,Inf.T.Y2,True);
  Q.Canvas.BitmapInit:=True;
   {Cr‚ation de la table des conversions des couleurs 24 bits … 7 bits}
  If Q.Canvas.Res.BitsPerPixel=8Then Begin
   Q.Canvas.PaletteRGB:=MemAlloc(SizeOf(Palette256RGB));
   If Q.Canvas.Res.NumPal=0Then Begin
    For I:=0to 15do Begin
     Q.Canvas.CT[I]:=I{64+(DefRGB[I].B shr 6)+
                       ((DefRGB[I].G shr 5)shl 2)+
                      ((DefRGB[I].R and$C0)shr 1)};
    End;
   End
    Else
   If(Q.Canvas.PaletteRGB<>NIL)Then Begin
    XGetAbsRec(Q.Canvas.Image,SizeOf(Q.Canvas.Res)+Long(Q.Canvas.Res.BytesPerLine)*Long(Q.Canvas.Res.NumYPixels),
               SizeOf(Palette256RGB),Q.Canvas.PaletteRGB^);
    For I:=0to 255do Begin
     Q.Canvas.CT[I]:=64+(Q.Canvas.PaletteRGB^[I].B shr 6)+
                     ((Q.Canvas.PaletteRGB^[I].G shr 5)shl 2)+
                     ((Q.Canvas.PaletteRGB^[I].R and$C0)shr 1);
    End;
   End;
  End;
 End;
 If(Q.Canvas.Res.BitsPerPixel>=8)or((Q.Canvas.Res.NumPal>0)and(Q.Canvas.Res.BitsPerPixel=4))Then Begin
  If Not(((Q.Canvas.Res.BitsPerPixel=15)and(BitsPerPixel=15))or
         ((Q.Canvas.Res.BitsPerPixel=16)and(BitsPerPixel=16)))Then Begin
   RIMakeDoublon(Q.Canvas.Image,rmAllResSteady,False,Q.Canvas);
  End
   Else
  Q.Canvas.Miroir.Output:=$FF;
 End;
 For I:=0to DrawEditApp(Q).W.MaxY*HeightChr-1do WIUpDateLn(Q.Canvas,I);
 Q.XC:=Inf.T.X2-Inf.T.X1+1;
 If(IsGraf)Then Begin
  Q.XC:=Q.XC shl 2;Q.YC:=((Inf.T.Y2-Inf.T.Y1+1)*GetHeightChr)shr 1;
 End
  Else
 Begin
  Q.XC:=Q.XC shr 1;Q.YC:=(Inf.T.Y2-Inf.T.Y1+1)shr 1;
 End;
 If(Q.XC>Q.Canvas.Res.NumXPixels)Then Q.XC:=Q.Canvas.Res.NumXPixels shr 1;
 If(Q.YC>Q.Canvas.Res.NumYPixels)Then Q.YC:=Q.Canvas.Res.NumYPixels shr 1;
 Q.BufCurSize:=GetSizeSmlImg(0,0,15,31);
 Q.BufCur:=MemAlloc(Q.BufCurSize);
 Q.MaxX:=Q.W.MaxX;Q.MaxY:=Q.W.MaxY;
 Q.BaseColor:={Inf.BaseColor}0;
 If Q.MaxX>=Q.Canvas.Res.NumXPixels-1Then Q.MaxX:=Q.Canvas.Res.NumXPixels-1;
 If Q.MaxY>=Q.Canvas.Res.NumYPixels-1Then Q.MaxY:=Q.Canvas.Res.NumYPixels-1;
 DWPush(DrawEditApp(Q));
 _InitKbd;
 DWInit:=True
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                       Proc‚dure DWNew                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: DrawWins


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de cr‚er un nouveau dessin.
}

Function DWNew;
Var
 SR:WIRec; { Structure de cr‚ation du nouveau dessin }
Begin
 DWNew:=No;
 SR.T.X1:=X1;
 SR.T.Y1:=Y1;
 SR.T.X2:=X2;
 SR.T.Y2:=Y2;
 SR.BitsPerPixel:=8;
 SR.NumXPixels:=640;
 SR.NumYPixels:=480;
 SR.BaseColor:=1;
 If Not DWInit(DrawEditApp(Q),'',SR)Then Begin
  If(GetSysErr=errGrfRequered)Then ErrNoMsgOk(errGraphicModeRequired);
 End
  Else
 DWNew:=True;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Proc‚dure DWOpen                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Propri‚taire: DrawWins


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet d'ouvrir un nouveau dessin ou un dessin d‚j…
 existant.
}

Procedure DWOpen;
Var
 SR:WIRec; { Structure de cr‚ation du nouveau dessin }
Begin
 SR.T.X1:=X1;
 SR.T.Y1:=Y1;
 SR.T.X2:=X2;
 SR.T.Y2:=Y2;
 SR.BitsPerPixel:=8;
 SR.NumXPixels:=640;
 SR.NumYPixels:=480;
 SR.BaseColor:=1;
 DWInit(DrawEditApp(Q),Path,SR)
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Proc‚dure DWFullScrn                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Portabilit‚:  Global
 Propri‚taire: DrawWins


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet d'afficher en pleine ‚cran le r‚sultat final du
 dessin contenu dans l'objet ®DrawWins¯.
}

Procedure DWFullScrn(Var Q:DrawEditApp);
Var
 S:ImgRec;             { Structure de sauvegarde de l'‚cran }
 J:Word;               { Variable compteur de boucle }
 XBuf:^TByte;          { Pointeur sur le tampon de transfert de donn‚es }
 FP:Long;              { Position courante dans la ressource }
 OldDialTimer:Bool;    { tat du drapeau d'affichage de l'horloge?}
 Pal256:Palette256RGB; { Palette de 256 couleurs temporaire }
Begin
 OldDialTimer:=DialTimer;DialTimer:=No;
 PushScr(S);
 ClrScrBlack;
 Case(Q.Canvas.Struct.BitsPerPixel)of
  1..24:Begin
   Case(Q.Canvas.Struct.BitsPerPixel)of
    4:Begin
     XGetAbsRec(Q.Canvas.Image,SizeOf(ImageHeaderRes)+Long(Q.Canvas.Res.BytesPerLine)*
                         Long(Q.Canvas.Struct.NumYPixels),SizeOf(Palette16RGB),Pal256);
     SetPalRGB(Pal256,0,16);
    End;
    8:RISetPalette(Q.Canvas.Image);
    24:For J:=0to 255do SetPaletteRGB(J,J and$E0,(J shr 2)shl 5,J shl 6);
   End;
   XBuf:=MemAlloc(Q.Canvas.Res.BytesPerLine);
   If(XBuf=NIL)Then __OutOfMemory
    Else
   Begin
    FP:=SizeOf(ImageHeaderRes);
    For J:=0to Q.Canvas.Struct.NumYPixels-1do Begin
     If(J>NmYPixels)Then Break;
     XGetAbsRec(Q.Canvas.Image,FP,Q.Canvas.Res.BytesPerLine,XBuf^);
     BestClrLnHorImg(J,Q.Canvas.Res,XBuf^);
     Inc(FP,Long(Q.Canvas.Res.BytesPerLine));
    End;
    FreeMemory(XBuf,Q.Canvas.Res.BytesPerLine);
   End;
   ReadKey;
  End;
 End;
 PopScr(S);
 DialTimer:=OldDialTimer;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Proc‚dure DWGetMode                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction retourne le mode d'‚dition actuellement en usage dans
 l'objet fenˆtre de programme de dessin.
}

Function DWGetMode;Assembler;ASM
 LES DI,Q
 MOV AL,ES:[DI].DrawEditApp.Mode.Byte
END;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                             Proc‚dure DWRefresh                          Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de r‚actualiser la fenˆtre de programme de dessin au
 niveau visuel. Les coordonn‚es tands qu'… elles,  seront mise … jour lors du
 prochain appelle … l'utilisateur par cette objet.
}

Procedure DWRefresh;
Var
 Path:String; { Variable contenant le nom du fichier du dessin }
 J:Word;      { Variable compteur de boucle }
Begin
 Path:=DrawEditApp(Q).FileName;
 If Path=''Then Path:='Pasnom';
 _WEPutWn(DrawEditApp(Q).W,Path);
 WEPutBarMsRight(DrawEditApp(Q).W);
 If Not InBoxHole(DrawEditApp(Q).W.T.X1,DrawEditApp(Q).W.T.Y1,
                  DrawEditApp(Q).W.T.X2,DrawEditApp(Q).W.T.Y2)Then Begin
  DWPutCadre(DrawEditApp(Q));
  If(DrawEditApp(Q).Canvas.Magnify)Then For J:=0to(DrawEditApp(Q).W.MaxY)do Begin
   WIUpdateLn(DrawEditApp(Q).Canvas,J);
  End
   Else
  For J:=0to DrawEditApp(Q).W.MaxY*HeightChr-1do WIUpdateLn(DrawEditApp(Q).Canvas,J);
 End;
 DrawEditApp(Q).XPtr:=$FFFF;
 DrawEditApp(Q).YPtr:=$FFFF;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Proc‚dure DWSave                          Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure sauvegarde le dessin de la fenˆtre objet sous son nom
 courant. S'il n'a pas de nom, il demande naturellement … l'utilisateur
 qu'elle est le nom sous lequel il doit ˆtre sauvegard‚.
}

Function DWSave;Begin
 DWSave:=DWSaveAs(DrawEditApp(Q),DrawEditApp(Q).FileName)
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Proc‚dure DWSaveAs                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure sauvegarde le dessin de la fenˆtre objet sous un nom
 particulier  devant ˆtre  sp‚cifi‚  par le  programme  … l'aide de la
 variable de param‚trage ®Path¯.
}

Function DWSaveAs;
Var
 Q:DrawEditApp Absolute Context;
 Path:String;
 UpDate:Boolean;
 R:FileListBox;
 H:History;
 K,Original,Format:Word;
Begin
 DWSaveAs:=False;
 Path:=FileName;
 UpDate:=Q.FileName='';
 If Path=''Then Begin
  HYInit(H,0);
  FLInitModel(R,Path,'Sauvegarde sous',H,No,No,True,omDraw);
  Case(Q.Canvas.Res.Original)of
   diIconWindows:Format:=cfoIconWindows;
   diIconOS2:Format:=cfoIconOS2;
   diIconGenesis:Format:=cfoIcn;
   diIconAdele:Format:=cfoIcon;
{   diIconGeoWorks:
   diIconGemDesktop:
   diPointerOS2:}
   diBitMapWindows:Format:=cfoBitmapWindows;
   diBitMapOS2:Format:=cfoBitMapOS2;
   diMacPaint:Format:=cfoMacPaint;
   diGemImg:Format:=cfoGemImg;
   diGFX:Format:=cfoGFX;
   diPPM:Format:=cfoPPM;
   diPCX:Format:=cfoPCX;
   diLBM:Format:=cfoLBM;
{   diTGA:Format:=cfoTGA;}
   diTIFF:Format:=cfoTIFF;
   diGIF:Format:=cfoGIF;
{   diJPEG:Format:=cfoJPEG }
{   diWPG:}
   diGPX:Format:=cfoGPX;
   diBGX:Format:=cfoBGX;
{   diHex:
   diGatElectric:}
   diResWindows:Format:=cfoRes;
   diCorelDraw:Format:=cfoCorelDraw;
   diXBM:Format:=cfoXBM;
{   diWordPerfectGraphics:}
{   diMBF:Format:=}
   diSCi:Format:=cfoSCi;
   Else Format:=cfoPCX;
  End;
  FLUpDateFormat(R,Format);
  Repeat
   K:=FLRun(R);
  Until(K=kbEsc)or(K=kbClose)or(K=kbEnter);
  Original:=FLFormat(R);
  FLDone(R);
  If(K=kbEnter)Then Begin
   Path:=R.Path;
   If Original<>0Then Begin
    Case(Original)of
     cfoIconWindows:Q.Canvas.Res.Original:=diIconWindows;
     cfoIconOS2:Q.Canvas.Res.Original:=diIconOS2;
     cfoIcn:Q.Canvas.Res.Original:=diIconGenesis;
     cfoIcon:Q.Canvas.Res.Original:=diIconAdele;
{   diIconGeoWorks:
   diIconGemDesktop:
   diPointerOS2:}
     cfoBitmapWindows:Q.Canvas.Res.Original:=diBitMapWindows;
     cfoBitMapOS2:Q.Canvas.Res.Original:=diBitMapOS2;
     cfoMacPaint:Q.Canvas.Res.Original:=diMacPaint;
     cfoGemImg:Q.Canvas.Res.Original:=diGemImg;
     cfoGFX:Q.Canvas.Res.Original:=diGFX;
     cfoPPM:Q.Canvas.Res.Original:=diPPM;
     cfoPCX:Q.Canvas.Res.Original:=diPCX;
     cfoLBM:Q.Canvas.Res.Original:=diLBM;
{   diTGA:Format:=cfoTGA;}
     cfoTIFF:Q.Canvas.Res.Original:=diTIFF;
     cfoGIF:Q.Canvas.Res.Original:=diGIF;
{   diJPEG:Format:=cfoJPEG }
{   diWPG:}
     cfoGPX:Q.Canvas.Res.Original:=diGPX;
     cfoBGX:Q.Canvas.Res.Original:=diBGX;
{   diHex:
   diGatElectric:}
     cfoRes:Q.Canvas.Res.Original:=diResWindows;
     cfoCorelDraw:Q.Canvas.Res.Original:=diCorelDraw;
     cfoXBM:Q.Canvas.Res.Original:=diXBM;
{   diWordPerfectGraphics:}
{   diMBF:Format:=}
     cfoSCi:Q.Canvas.Res.Original:=diSCi;
    End;
    XSetAbsRec(Q.Canvas.Image,0,SizeOf(Q.Canvas.Res),Q.Canvas.Res);
   End;
  End;
{  Path:=OpenWin(Path,'Sauvegarde sous');}
 End;
 If Path<>''Then Begin
  Path:=StrUp(FileExpand(Path));
  If(Q.FileName<>Path)Then Begin{ Existe toujours ? }
   UpDate:=True;
   If FileExist(Path)Then Begin
    If Not __InputOverwriteFile(Path)Then Exit;
   End;
   Q.FileName:=Path
  End;
  Q.Modified:=No;
  _RISaveImage(Path,0,Q.Canvas.Image);
  If(UpDate)or(Q.FileName<>Path)Then Begin
   Q.FileName:=Path;
   _WESetTitle(Q.W,Q.FileName);
  End;
  DWSaveAs:=True;
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                             Proc‚dure DWSetMode                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure fixe le mode d'‚dition de la fenˆtre objet du programme de
 dessin actuellement pointer par la variable de param‚trage ®Q¯.
}

Procedure DWSetMode;Begin
 Q.Mode:=M;Q.SM:=No;
 If(Q.Mode=drwText)and(Q.QQF=NIL)Then DWSelectFont(Q);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                             Proc‚dure DWPutCur                          Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure affiche une croix … la position courante du pointeur pixel
 de la fenˆtre objet de programme de dessin.
}

Procedure DWPutCur;
Var
 J,XH,YH,XM,YM,XE,YE:Integer;
 I:Byte;
Begin
 XH:=Q.Canvas.Screen.X1+Q.XC;
 YH:=Q.Canvas.Screen.Y1+Q.YC;
 XM:=XH-5;YM:=YH-5;
 XE:=XH+5;YE:=YH+5;
 If(XM<Q.Canvas.Screen.X1)Then XM:=Q.Canvas.Screen.X1;
 If(YM<Q.Canvas.Screen.Y1)Then YM:=Q.Canvas.Screen.Y1;
 If(XE>Q.Canvas.Screen.X2)Then XE:=Q.Canvas.Screen.X2;
 If(YE>Q.Canvas.Screen.Y2)Then YE:=Q.Canvas.Screen.Y2;
 _SetKr(Kr);
 If(Q.Mode=drwBrush)Then Begin
  _PutRect(XH,YH,XH+Q.LengthBrush-1,YH+Q.HeightBrush-1);
 End
  Else
 Begin
  Video._LnHor(XM,YH,XE);
  For J:=YM to(YE)do Video._SetPixel(XH,J);
 End;
End;

Function DWPutFont(Var Q:DrawEditApp;X,Y:Word;Const S:String):Word;
Var
 QQFW:^TWord;
 I,J,XN,YN,B,MX,N:Word;
 IS,K,Masque:Byte;
Begin
 N:=0;
 For IS:=1to Length(S)do Begin
  QQFW:=Pointer(Q.QQF);
  B:=QQFW^[Byte(S[IS])];
  If B=0Then MX:=Q.QQFHeight shr 1
   Else
  Begin
   MX:=Q.QQF^[B];
   If MX=0Then MX:=Q.QQFHeight shr 1
    Else
   Begin
    XN:=MX shr 3;
    If Q.QQF^[B]and 7<>0Then Begin
     MX:=(XN+1)shl 3;
     Inc(XN)
    End;
    Inc(B);YN:=Q.QQF^[B];Inc(B);
    If Q.QQF^[B]<>0Then Inc(Y,Q.QQF^[B]);
    Inc(B);
    For J:=0to YN-1do Begin
     For I:=0to XN-1do Begin
      Masque:=Q.QQF^[B];
      For K:=0to 7do Begin
       If Masque and$80<>0Then WIPutPixel(Q.Canvas,X+K,Y);
       Masque:=Masque shl 1;
      End;
      Inc(B);Inc(X,8)
     End;
     Dec(X,XN shl 3);
     Inc(Y)
    End;
   End;
  End;
  Inc(N,MX);
 End;
 DWPutFont:=N;
End;

Procedure DWPutPos(Var Q:DrawEditApp);
Var
 S:String;
Begin
 S:='('+WordToStr(Q.Canvas.XMove+Q.XPtr)+','+WordToStr(Q.Canvas.YMove+Q.YPtr)+')';
 WESetEndBarTxtX(Q.W,1,Spc(14-Length(S))+S,CurrKrs.Desktop.DialStatus);
End;

Procedure DWScrollDn(Var Q:DrawEditApp);Begin
 If(Q.Canvas.Magnify)Then Begin
  If(Q.Canvas.Struct.NumYPixels>Q.MaxY)Then Begin
   If WIYMoveWn(Q.Canvas)<Q.Canvas.Struct.NumYPixels-Q.MaxY-8Then
    WIMoveWnY(Q.Canvas,WIYMoveWn(Q.Canvas)+8)
  End;
 End
  Else
 Begin
  If(Q.Canvas.Struct.NumYPixels>Q.Canvas.SGYM)Then Begin
   If WIYMoveWn(Q.Canvas)<Q.Canvas.Struct.NumYPixels-Q.Canvas.SGYM-8Then
    WIMoveWnY(Q.Canvas,WIYMoveWn(Q.Canvas)+8)
  End;
 End;
 DWPutPos(Q);
End;

Procedure DWPush(Var Q:DrawEditApp);
Var
 XH,YH:Word;
Begin
 If Not((Q.BufCur=NIL)or(Q.Canvas.Magnify))Then Begin
  XH:=Q.Canvas.Screen.X1+Q.XC;YH:=Q.Canvas.Screen.Y1+Q.YC;
  Q.XM:=XH-6;Q.YM:=YH-6;
  Q.XE:=XH+6;Q.YE:=YH+6;
  If BitsPerPixel<8Then Begin
   Q.XM:=Q.XM and$FFF8;
   Q.XE:=Q.XE or 7;
  End;
  GetSmlImg(Q.XM,Q.YM,Q.XE,Q.YE,Q.BufCur^);
  If(Q.Mode=drwBrush)Then Begin
   XFreeMem(Q.ImgBufCur.X);
   SaveImage(XH and$FFF8,YH,(XH+Q.LengthBrush-1)or 7,YH+Q.HeightBrush-1,Q.ImgBufCur);
  End;
 End;
End;

Procedure DWPop(Var Q:DrawEditApp);
Var
 XH,YH:Word;
Begin
 If Not((Q.BufCur=NIL)or(Q.Canvas.Magnify))Then Begin
  XH:=Q.Canvas.Screen.X1+Q.XC;YH:=Q.Canvas.Screen.Y1+Q.YC;
  Q.XM:=XH-6;Q.YM:=YH-6;
  Q.XE:=XH+6;Q.YE:=YH+6;
  If BitsPerPixel<8Then Begin
   Q.XM:=Q.XM and$FFF8;
   Q.XE:=Q.XE or 7;
  End;
  If(Q.Mode=drwBrush)Then Begin
   If Q.ImgBufCur.X.Output<>$FFThen
    RestoreImage(XH and$FFF8,YH,(XH+Q.LengthBrush-1)or 7,YH+Q.HeightBrush-1,Q.ImgBufCur);
  End
   Else
  PutSmlImg(Q.XM,Q.YM,Q.XE,Q.YE,Q.BufCur^);
 End;
End;

Procedure DWScrollUp(Var Q:DrawEditApp);Begin
 If WIYMoveWn(Q.Canvas)>0Then WIMoveWnY(Q.Canvas,WIYMoveWn(Q.Canvas)-8);
 DWPutPos(Q);
End;

Procedure DWScrollLeft(Var Q:DrawEditApp);Begin
 If WIXMoveWn(Q.Canvas)>0Then WIMoveWnX(Q.Canvas,WIXMoveWn(Q.Canvas)-8);
 DWPutPos(Q);
End;

Procedure DWScrollRight(Var Q:DrawEditApp);Begin
 If(Q.BufCur=NIL)or(Q.Canvas.Magnify)Then Begin
  If(WIXMoveWn(Q.Canvas)<Q.Canvas.Struct.NumXPixels-Q.MaxX+4)Then
    WIMoveWnX(Q.Canvas,WIXMoveWn(Q.Canvas)+8)
 End
  Else
 Begin
  If(WIXMoveWn(Q.Canvas)<Q.Canvas.Struct.NumXPixels-Q.Canvas.SGXM-8)Then
    WIMoveWnX(Q.Canvas,WIXMoveWn(Q.Canvas)+8)
 End;
 DWPutPos(Q);
End;

Procedure DWPoint(Var Q:DrawEditApp;X,Y:Word);Begin
 Case(Q.PointType)of
  ptSimple:WIPutPixel(Q.Canvas,X,Y);
  ptCroix:Begin
   WIPutLineHor(Q.Canvas,X-7,Y,X+7);
   WIPutLine(Q.Canvas,X,Y-7,X,Y+7);
  End;
  ptX:Begin
   WIPutLine(Q.Canvas,X-7,Y-7,X+7,Y+7);
   WIPutLine(Q.Canvas,X-7,Y+7,X+7,Y-7);
  End;
  ptLineVert:WIPutLine(Q.Canvas,X,Y,X,Y-7);
  ptLineHori:WIPutLineHor(Q.Canvas,X-7,Y,X+7);
 End;
 If(Q.RectMode)Then WIPutRect(Q.Canvas,X-7,Y-7,X+7,Y+7);
 If(Q.CircleMode)Then Begin
  WIPutRoundRect(Q.Canvas,X-6,Y-6,X+6,Y+6,1,6);
 End;
End;

Procedure DWBackOperation(Var Context);
Var
 Q:DrawEditApp Absolute Context;
 {XA:Byte;}
Begin
 If Not((Q.BufCur=NIL)or(Q.Canvas.Magnify))Then Begin
  If Not(IsShowMouse)Then DWPutCur(Q,GetRawTimerB and$F);
 End
  Else
 Begin
{  If(IsGrf)Then XA:=12 Else XA:=0;
  If(Q.XC>Q.MaxX)Then Q.XC:=0;
  If(Q.YC>Q.MaxY)Then Q.YC:=0;
  WESetPos(Q.W,XA+Q.XC,Q.YC);
  WESetCurPos(Q.W,XA+Q.XC,Q.YC);}
  __ShowMousePtr;
 End;
End;

Const
 imColor=$F001;
 imPasteImage=$F002;
 imCopyBox=$F003;
 imLineAbs=$F004;
 imLineRelative=$F005;
 imLinePolaires=$F006;
 imRectAbs=$F007;
 imRectRelative=$F008;
 imFillBoxAbs=$F009;
 imFillBoxRelative=$F00A;
 imSimplePoint=$F00B;
 imNoPoint=$F00C;
 imCroix=$F00D;
 imX=$F00E;
 imHori=$F00F;
 imVert=$F010;
 imCircleMode=$F011;
 imRectMode=$F012;
 imPointAbs=$F013;
 imSizeBrush=$F014;
 imRefreshDraw=$F015;
 imClearScreen=$F016;
 imSmallErase=$F017;
 imStandardErase=$F018;
 imBrightnessContrast=$F019;
 imChannelMixer=$F01A;
 imLoadPalette=$F01B;
 imDrawInfo=$F01C;
 imDrawHistogram=$F01D;
 imCircle3Point=$F01E;
 imScale=$F01F;
 imPlasma=$F020;

Procedure PointMenuIcon(X,Y:Byte;Level:Word);Far;
Var
 GX,GY:Word;
Begin
 GX:=X shl 3;GY:=GetRawY(Y);
  { Simple Point }
 Plot(GX+8,GY+(HeightChr shr 1),Black);
  { Point invisible }
 Inc(GY,HeightChr);
  { Une Croix }
 Inc(GY,HeightChr);
 PutLineHori(GX,GY+(HeightChr shr 1),GX+15,Black);
 PutLine(GX+8,GY,GX+8,GY+HeightChr-1,Black);
  { Un ®X¯}
 Inc(GY,HeightChr);
 PutLine(GX,GY,GX+15,GY+HeightChr-1,Black);
 PutLine(GX,GY+HeightChr-1,GX+15,GY,Black);
  { Une ligne horizontal }
 Inc(GY,HeightChr);
 PutLineHori(GX,GY+(HeightChr shr 1),GX+15,Black);
  { Une ligne vertical }
 Inc(GY,HeightChr);
 PutLine(GX+8,GY,GX+8,GY+(HeightChr shr 1),Black);
  { - }
 Inc(GY,HeightChr);
  { Mode cercle }
 Inc(GY,HeightChr);
 Circle(GX+8,GY+(HeightChr shr 1),(HeightChr shr 1)-2,Black);
  { Mode rectangle }
 Inc(GY,HeightChr);
 PutRect(GX,GY,GX+15,GY+HeightChr-1,Black);
End;

Procedure DWClearImage(Var Q:DrawEditApp);
Var
 OldKr:Word;
Begin
 OldKr:=Q.Canvas.CurrColor;
 WISetColor(Q.Canvas,Q.BaseColor);
 WIPutFillBox(Q.Canvas,0,0,Q.Canvas.Res.NumXPixels-1,Q.Canvas.Res.NumYPixels-1);
 Q.Canvas.CurrColor:=OldKr;
End;

Type
 EditorStruct=Record
  Model:Byte;              { ModŠle, num‚ro de s‚rie...}
  O:TextBoxRec;            { Pour le Zoom...}
  InTaskBar:Boolean;       { Invisible sur la barre de tƒche }
  Editor:EditorApp;
 End;

Function RunMenuApp0:Word;Near;
Var
 CM:ContextMenu;
 TM:MainMnuPtr;
 I,P:SmallInt;
 Win:HWins;
 Ptr:^EditorStruct;
 PBuffer:Array[0..1023]of Char;
Begin
 WaitMouseBut0;
 __HideMousePtr;
 CMLoadApp(CM,0);
 FillClr(PBuffer,SizeOf(PBuffer));
 P:=0;
 Win:=Windows;
 ALSetPtr(Win.Lst,0);
 For I:=0to Win.Lst.Count-1do Begin
  Ptr:=_ALGetCurrBuf(Win.Lst);
  If(Ptr<>NIL)and(Ptr^.Model=wnEdit)and(Ptr^.Editor.Mode=vtBas)Then Begin
   StrPascalCopy(PBuffer[P],SizeOf(PBuffer)-P,Ptr^.Editor.EditName);
   SMAddFullItem(CM.SubMenu[CM.MaxSubMenu],@PBuffer[P],kbNoKey,$E000+I,NIL,NIL);
   Inc(P,Length(Ptr^.Editor.EditName)+1);
  End;
  ALNext(Win.Lst);
 End;
 ALSetPtr(MainMenu.Mnu,0);
 TM:=_ALGetCurrBuf(MainMenu.Mnu);
 RunMenuApp0:=PMExecMnu(LastMouseX,LastMouseY+1,TM^.Lst,TM^.P);
 CMDone(CM);
End;

Procedure DWRunAppMacro(Var Q:DrawEditApp;Num:Word);
Var
 Ptr:^EditorStruct;
 Win:HWins;
Begin
 Win:=Windows;
 Ptr:=_ALGetBuf(Win.Lst,Num);
 If(Ptr<>NIL)and(Ptr^.Model=wnEdit)Then Begin
  DWExecMacro(Q,Ptr^.Editor.List);
 End;
End;

Procedure DWOnMouseDown(Var Context;X,Y:Integer;TX,TY:Byte;Shift:Word);
Label Menu,NotSM;
Var
 Q:DrawEditApp Absolute Context;
 Img:ImgRec;
 OX1,OY1,OX2,OY2,X1,Y1,X2,Y2,TX1,TY1,TX2,TY2,MB,A,B,K,OldKr:Word;
 XA:Byte;
 PL:Array[0..1]of Pointer;
Begin
 If(IsGrf)Then XA:=12
          Else XA:=0;
 If(TY=Q.W.MaxY)and(TX>=XA)Then Begin { Sur la barre horizontal? }
  If TX<=XA+1Then DWScrollLeft(Q)Else
  If TX>=Q.W.MaxX-1Then DWScrollRight(Q);
 End
  Else
 Case(Shift)of
  1:Begin
   Case BMGetBut(Q.ButtonDraw,WEGetRX1(Q.W)+TX,WEGetRY1(Q.W)+TY)of
    0:Begin
     Q.Mode:=drwGetPixel;
     DWUpDateButton(Q);
    End;
    1:Begin
     Q.Mode:=drwCopy;
     DWUpDateButton(Q);
    End;
    2:Begin
     Q.Mode:=drwTrace;
     DWUpDateButton(Q);
    End;
    3:DWSetColor(Q);
    4:Begin
     Q.Mode:=drwBrush;
     DWUpDateButton(Q);
    End;
    5:Begin
     Q.Mode:=drwLine;
     DWUpDateButton(Q);
    End;
    6:Begin
     DWSetMode(Q,drwText);
     DWUpDateButton(Q);
    End;
    7:Begin
     Q.Mode:=drwManyLine;
     DWUpDateButton(Q);
    End;
    8:Begin
     Q.Mode:=drwPaint;
     DWUpDateButton(Q);
    End;
    9:Begin
     Q.Mode:=drwBox;
     Q.Fill:=False;
     DWUpDateButton(Q);
    End;
    10:Begin
     Q.Mode:=drwBox;
     Q.Fill:=True;
     DWUpDateButton(Q);
    End;
    11:;
    12:Begin
     Q.Mode:=drwCadre;
     Q.Fill:=False;
     DWUpDateButton(Q);
    End;
    13:Begin
     Q.Mode:=drwCadre;
     Q.Fill:=True;
     DWUpDateButton(Q);
    End;
    Else If(Q.BufCur=NIL)or(Q.Canvas.Magnify)Then Begin
     If(TX>=XA)Then Begin
      Dec(TX,XA);Q.Modified:=True;
      __HideMousePtr;
      DWPop(Q);
      DWPoint(Q,TX,TY);
      DWPush(Q);
      __ShowMousePtr;
      WaitMouseBut0;
     End
      Else
     Goto Menu;
    End
     Else
    Begin
     DWPop(Q);
     FillClr(Img,SizeOf(Img));
     If Q.Mode>0Then Q.Modified:=True;
     Img.X.Output:=$FF;
     Case(Q.Mode)of
      drwGetPixel:Begin
       Q.Canvas.CurrColor:=WIGetPixel(Q.Canvas,X-(XA shl 3),Y);
      End;
      drwText:Begin
       If Shift=1Then Begin
        Q.XText:=X-(XA shl 3);
        Q.YText:=Y;
       End;
      End;
      drwTrace:If Shift=1Then Begin
       DWPush(Q);
       X2:=$FFFF;Y2:=$FFFF;
       Repeat
        DWBackOperation(Q);
        If(X2<>Q.XC+Q.Canvas.Screen.X1)or(Y2<>Q.YC+Q.Canvas.Screen.Y1)Then Begin
         DWPop(Q);
         If(X2<Q.Canvas.Screen.X1)Then X2:=Q.Canvas.Screen.X1;
         If(X2>Q.Canvas.Screen.X2)Then X2:=Q.Canvas.Screen.X2;
         If(Y2<Q.Canvas.Screen.Y1)Then Y2:=Q.Canvas.Screen.Y1;
         If(Y2>Q.Canvas.Screen.Y2)Then Y2:=Q.Canvas.Screen.Y2;
         Q.XC:=X2-Q.Canvas.Screen.X1;
         Q.YC:=Y2-Q.Canvas.Screen.Y1;
         DWPoint(Q,Q.XC,Q.YC);
         DWPush(Q);
        End;
        GetMouseSwitch(X2,Y2,MB);
       Until MB=0;
       DWPop(Q);
      End;
      drwPaint:If Shift=1Then WIFloodFill(Q.Canvas,X-(XA shl 3),Y);
      drwBrush:If Shift=1Then Begin
       DWPush(Q);
       X2:=$FFFF;Y2:=$FFFF;
       OldKr:=Q.Canvas.CurrColor;
       WISetColor(Q.Canvas,Q.Canvas.Struct.BaseColor);
       Repeat
        DWBackOperation(Q);
        If(X2<>Q.XC+Q.Canvas.Screen.X1)or(Y2<>Q.YC+Q.Canvas.Screen.Y1)Then Begin
         DWPop(Q);
         If(X2<Q.Canvas.Screen.X1)Then X2:=Q.Canvas.Screen.X1;
         If(X2>Q.Canvas.Screen.X2)Then X2:=Q.Canvas.Screen.X2;
         If(Y2<Q.Canvas.Screen.Y1)Then Y2:=Q.Canvas.Screen.Y1;
         If(Y2>Q.Canvas.Screen.Y2)Then Y2:=Q.Canvas.Screen.Y2;
         Q.XC:=X2-Q.Canvas.Screen.X1;
         Q.YC:=Y2-Q.Canvas.Screen.Y1;
         WIPutFillBox(Q.Canvas,Q.XC,Q.YC,Q.XC+Q.LengthBrush,Q.YC+Q.HeightBrush);
         DWPush(Q);
        End;
        GetMouseSwitch(X2,Y2,MB);
       Until MB=0;
       Q.Canvas.CurrColor:=OldKr;
       DWPop(Q);
      End;
      drwManyLine:If Shift=1Then Begin
       DWPush(Q);
       X1:=X-12*8;Y1:=Y;X2:=X1;Y2:=Y;Q.XC:=X1;Q.YC:=Y;
       Repeat
        DWBackOperation(Q);
        GetMouseSwitch(X2,Y2,MB);
        If(X2<>Q.XC+Q.Canvas.Screen.X1)or(Y2<>Q.YC+Q.Canvas.Screen.Y1)Then Begin
         DWPop(Q);
         If(X2<Q.Canvas.Screen.X1)Then X2:=Q.Canvas.Screen.X1;
         If(X2>Q.Canvas.Screen.X2)Then X2:=Q.Canvas.Screen.X2;
         If(Y2<Q.Canvas.Screen.Y1)Then Y2:=Q.Canvas.Screen.Y1;
         If(Y2>Q.Canvas.Screen.Y2)Then Y2:=Q.Canvas.Screen.Y2;
         Q.XC:=X2-Q.Canvas.Screen.X1;
         Q.YC:=Y2-Q.Canvas.Screen.Y1;
         WIPutLine(Q.Canvas,X1,Y1,Q.XC,Q.YC);
         DWPush(Q);
        End;
       Until MB=0;
       DWPop(Q);
      End;
      drwBox:Begin
       Q.XO:=Q.XC;Q.YO:=Q.YC;
       OX1:=$FFFF;OY1:=$FFFF;OX2:=$FFFF;OY2:=$FFFF;
       X1:=Q.Canvas.Screen.X1+Q.XO;
       Y1:=Q.Canvas.Screen.Y1+Q.YO;
       Repeat
        GetMouseSwitch(X2,Y2,MB);
        If(OX1<>X1)or(OY1<>Y1)or(OX2<>X2)or(OY2<>Y2)Then Begin
         RestoreImage(OX1,OY1,OX2,OY2,Img);
         SaveImage(X1,Y1,X2,Y2,Img);
         TX1:=X1;TY1:=Y1;TX2:=X2;TY2:=Y2;
         If(TX2<Q.Canvas.Screen.X1)Then TX2:=Q.Canvas.Screen.X1;
         If(TX2>Q.Canvas.Screen.X2)Then TX2:=Q.Canvas.Screen.X2;
         If(TY2<Q.Canvas.Screen.Y1)Then TY2:=Q.Canvas.Screen.Y1;
         If(TY2>Q.Canvas.Screen.Y2)Then TY2:=Q.Canvas.Screen.Y2;
         If(TX1>TX2)Then SwapWord(TX1,TX2);
         If(TY1>TY2)Then SwapWord(TY1,TY2);
         PutRect(TX1,TY1,TX2,TY2,Q.Canvas.CurrColor);
         OX1:=X1;OY1:=Y1;OX2:=X2;OY2:=Y2;
        End;
       Until MB=0;
       RestoreImage(OX1,OY1,OX2,OY2,Img);
       If(OX2<Q.Canvas.Screen.X1)Then OX2:=Q.Canvas.Screen.X1;
       If(OX2>Q.Canvas.Screen.X2)Then OX2:=Q.Canvas.Screen.X2;
       If(OY2<Q.Canvas.Screen.Y1)Then OY2:=Q.Canvas.Screen.Y1;
       If(OY2>Q.Canvas.Screen.Y2)Then OY2:=Q.Canvas.Screen.Y2;
       Q.XC:=OX2-Q.Canvas.Screen.X1;
       Q.YC:=OY2-Q.Canvas.Screen.Y1;
       If(Q.Fill)Then WIPutFillBox(Q.Canvas,Q.XC,Q.YC,Q.XO,Q.YO)
                 Else WIPutRect(Q.Canvas,Q.XC,Q.YC,Q.XO,Q.YO);
       Goto NotSM;
      End;
      drwCopy:Begin
       Q.XO:=Q.XC;Q.YO:=Q.YC;
       OX1:=$FFFF;OY1:=$FFFF;OX2:=$FFFF;OY2:=$FFFF;
       X1:=Q.Canvas.Screen.X1+Q.XO;
       Y1:=Q.Canvas.Screen.Y1+Q.YO;
       Repeat
        GetMouseSwitch(X2,Y2,MB);
        If(OX1<>X1)or(OY1<>Y1)or(OX2<>X2)or(OY2<>Y2)Then Begin
         RestoreImage(OX1,OY1,OX2,OY2,Img);
         SaveImage(X1,Y1,X2,Y2,Img);
         TX1:=X1;TY1:=Y1;TX2:=X2;TY2:=Y2;
         If(TX2<Q.Canvas.Screen.X1)Then TX2:=Q.Canvas.Screen.X1;
         If(TX2>Q.Canvas.Screen.X2)Then TX2:=Q.Canvas.Screen.X2;
         If(TY2<Q.Canvas.Screen.Y1)Then TY2:=Q.Canvas.Screen.Y1;
         If(TY2>Q.Canvas.Screen.Y2)Then TY2:=Q.Canvas.Screen.Y2;
         If(TX1>TX2)Then SwapWord(TX1,TX2);
         If(TY1>TY2)Then SwapWord(TY1,TY2);
         PutRect(TX1,TY1,TX2,TY2,Q.Canvas.CurrColor);
         OX1:=X1;OY1:=Y1;OX2:=X2;OY2:=Y2;
        End;
       Until MB=0;
       RestoreImage(OX1,OY1,OX2,OY2,Img);
       If(OX2<Q.Canvas.Screen.X1)Then OX2:=Q.Canvas.Screen.X1;
       If(OX2>Q.Canvas.Screen.X2)Then OX2:=Q.Canvas.Screen.X2;
       If(OY2<Q.Canvas.Screen.Y1)Then OY2:=Q.Canvas.Screen.Y1;
       If(OY2>Q.Canvas.Screen.Y2)Then OY2:=Q.Canvas.Screen.Y2;
       Q.XC:=OX2-Q.Canvas.Screen.X1;
       Q.YC:=OY2-Q.Canvas.Screen.Y1;
       DWCopyBox2Clipboard(Q,Q.XC,Q.YC,Q.XO,Q.YO);
       Goto NotSM;
      End;
      drwCadre:Begin
       Q.XO:=Q.XC;Q.YO:=Q.YC;OX1:=$FFFF;OY1:=$FFFF;OX2:=$FFFF;OY2:=$FFFF;
       X1:=Q.Canvas.Screen.X1+Q.XO;
       Y1:=Q.Canvas.Screen.Y1+Q.YO;
       Repeat
        GetMouseSwitch(X2,Y2,MB);
        If(OX1<>X1)or(OY1<>Y1)or(OX2<>X2)or(OY2<>Y2)Then Begin
         RestoreImage(OX1,OY1,OX2,OY2,Img);
         SaveImage(X1,Y1,X2,Y2,Img);
         TX1:=X1;TY1:=Y1;TX2:=X2;TY2:=Y2;
         If(TX2<Q.Canvas.Screen.X1)Then TX2:=Q.Canvas.Screen.X1;
         If(TX2>Q.Canvas.Screen.X2)Then TX2:=Q.Canvas.Screen.X2;
         If(TY2<Q.Canvas.Screen.Y1)Then TY2:=Q.Canvas.Screen.Y1;
         If(TY2>Q.Canvas.Screen.Y2)Then TY2:=Q.Canvas.Screen.Y2;
         If(TX1>TX2)Then SwapWord(TX1,TX2);
         If(TY1>TY2)Then SwapWord(TY1,TY2);
         Ellipse(TX1,TY1,TX2,TY2,1,Q.Canvas.CurrColor);
         OX1:=X1;OY1:=Y1;OX2:=X2;OY2:=Y2;
        End;
       Until MB=0;
       RestoreImage(OX1,OY1,OX2,OY2,Img);
       If(OX2<Q.Canvas.Screen.X1)Then OX2:=Q.Canvas.Screen.X1;
       If(OX2>Q.Canvas.Screen.X2)Then OX2:=Q.Canvas.Screen.X2;
       If(OY2<Q.Canvas.Screen.Y1)Then OY2:=Q.Canvas.Screen.Y1;
       If(OY2>Q.Canvas.Screen.Y2)Then OY2:=Q.Canvas.Screen.Y2;
       Q.XC:=OX2-Q.Canvas.Screen.X1;
       Q.YC:=OY2-Q.Canvas.Screen.Y1;
       B:=AbsInt(X2-X1)shr 1;A:=AbsInt(Y2-Y1)shr 1;
       If(A<B)Then B:=A;
       If(Q.Fill)Then WIPutFillRoundRect(Q.Canvas,Q.XC,Q.YC,Q.XO,Q.YO,B)
                 Else WIPutRoundRect(Q.Canvas,Q.XC,Q.YC,Q.XO,Q.YO,1,B);
       Goto NotSM;
      End;
      drwLine:Begin
       Q.XO:=Q.XC;Q.YO:=Q.YC;
       OX1:=$FFFF;OY1:=$FFFF;OX2:=$FFFF;OY2:=$FFFF;
       X1:=Q.Canvas.Screen.X1+Q.XO;
       Y1:=Q.Canvas.Screen.Y1+Q.YO;
       Repeat
        GetMouseSwitch(X2,Y2,MB);
        If(OX1<>X1)or(OY1<>Y1)or(OX2<>X2)or(OY2<>Y2)Then Begin
         RestoreImage(OX1,OY1,OX2,OY2,Img);
         SaveImage(X1,Y1,X2,Y2,Img);
         TX1:=X1;TY1:=Y1;TX2:=X2;TY2:=Y2;
         If(TX2<Q.Canvas.Screen.X1)Then TX2:=Q.Canvas.Screen.X1;
         If(TX2>Q.Canvas.Screen.X2)Then TX2:=Q.Canvas.Screen.X2;
         If(TY2<Q.Canvas.Screen.Y1)Then TY2:=Q.Canvas.Screen.Y1;
         If(TY2>Q.Canvas.Screen.Y2)Then TY2:=Q.Canvas.Screen.Y2;
         PutLine(TX1,TY1,TX2,TY2,Q.Canvas.CurrColor);
         OX1:=X1;OY1:=Y1;OX2:=X2;OY2:=Y2;
        End;
       Until MB=0;
       RestoreImage(OX1,OY1,OX2,OY2,Img);
       If(OX2<Q.Canvas.Screen.X1)Then OX2:=Q.Canvas.Screen.X1;
       If(OX2>Q.Canvas.Screen.X2)Then OX2:=Q.Canvas.Screen.X2;
       If(OY2<Q.Canvas.Screen.Y1)Then OY2:=Q.Canvas.Screen.Y1;
       If(OY2>Q.Canvas.Screen.Y2)Then OY2:=Q.Canvas.Screen.Y2;
       Q.XC:=OX2-Q.Canvas.Screen.X1;
       Q.YC:=OY2-Q.Canvas.Screen.Y1;
       WIPutLine(Q.Canvas,Q.XO,Q.YO,Q.XC,Q.YC);
 NotSM:Q.SM:=Not Q.SM;
      End;
     End;
     DWPush(Q);
    End;
   End;
  End;
  2:Case BMGetBut(Q.ButtonDraw,WEGetRX1(Q.W)+TX,WEGetRY1(Q.W)+TY)of
   2:Begin
    PL[0]:=@Q.CircleMode;
    PL[1]:=@Q.RectMode;
    K:=_RunMenuApp(1,PL);
    Case(K)of
     imSimplePoint:Q.PointType:=ptSimple;
     imNoPoint:Q.PointType:=ptNoPoint;
     imCroix:Q.PointType:=ptCroix;
     imX:Q.PointType:=ptX;
     imVert:Q.PointType:=ptLineVert;
     imHori:Q.PointType:=ptLineHori;
     imCircleMode:Q.CircleMode:=Not Q.CircleMode;
     imRectMode:Q.RectMode:=Not Q.RectMode;
     imPointAbs:DWPointAbsolute(Q);
     kbMouse:WaitMouseBut0;
    End;
    __ShowMousePtr;
   End;
   4:Begin
    Case RunMenuApp(2)of
     imSizeBrush:DWSelectSizeBrush(Q);
     imClearScreen:If(ErrMsg('Etes-vous vraiment certain de '+
                             'vouloir effacer le contenu du '+
                             'l''image avec la couleur de fond?',KeyYes+KeyNo)=kbYes)Then Begin
      DWClearImage(Q);
     End;
     imSmallErase:Begin
      Q.LengthBrush:=4;Q.HeightBrush:=4;
     End;
     imStandardErase:Begin
      Q.LengthBrush:=16;Q.HeightBrush:=HeightChr shl 1;
     End;
    End;
   End;
   5:Begin
    Case RunMenuApp(3)of
     imLineAbs:DWLineAbsolute(Q);
     imLineRelative:DWLineRelative(Q);
     imLinePolaires:DWLinePolaires(Q);
    End;
   End;
   6:Begin
    __HideMousePtr;
    DWSelectFont(Q);
    __ShowMousePtr;
   End;
   9:Begin
    Case RunMenuApp(4)of
     imRectAbs:DWRectAbsolute(Q);
     imRectRelative:DWRectRelative(Q);
    End;
   End;
   10:Begin
    Case RunMenuApp(5)of
     imFillBoxAbs:DWFillBoxAbsolute(Q);
     imFillBoxRelative:DWFillBoxRelative(Q);
    End;
   End;
   12:Begin
    Case RunMenuApp(121)of
     imCircle3Point:DWCircle3Point(Q);
    End;
   End;
   Else If(Q.BufCur=NIL)or(Q.Canvas.Magnify)Then Begin
    If(TX>=XA)Then Begin
     Dec(TX,XA);Q.Modified:=True;
     __HideMousePtr;
     DWPop(Q);
     OldKr:=Q.Canvas.CurrColor;
     WISetColor(Q.Canvas,Q.BaseColor);
     DWPoint(Q,TX,TY);
     Q.Canvas.CurrColor:=OldKr;
     DWPush(Q);
     __ShowMousePtr;
     WaitMouseBut0;
    End
     Else
    Goto Menu;
   End
    Else
   Goto Menu;
  End
   Else
  Begin
Menu:DWPop(Q);
   K:=RunMenuApp0;
   Case(K)of
   {Case RunMenuApp(0)of}
    $E000..$EF00:DWRunAppMacro(Q,K and $FFF);
    imRefreshDraw:WIMoveWn(Q.Canvas,Q.Canvas.XMove,Q.Canvas.YMove);
    imColor:DWSetColor(Q);
    imCopyBox:Q.Mode:=drwCopy;
    imPasteImage:DWPasteClipboard2Image(Q,Q.XC,Q.YC);
    imBrightnessContrast:DWBrightnessContrast(Q);
    imChannelMixer:DWChannelMixer(Q);
    imLoadPalette:DWLoadPalette(Q);
    imDrawInfo:DWInfo(Q);
    imDrawHistogram:DWHistogram(Q);
    imScale:DWScale(Q,Q.XC,Q.YC);
    imPlasma:DWPlasma(Q);
    $F021:DWChoiceMacro(Q);
    $F022:DWRotate90(Q);
    $F023:DWRotate180(Q);
    $F024:DWRotate270(Q);
   End;
   DWPush(Q);
  End;
 End;
End;

Procedure DWPutHelpBar(Var Q:DrawEditApp;P:Byte);Near;
Var
 S:String;
Begin
 If(Q.OldHelpBarP<>P)Then Begin
  Case(P)of
   0:S:='Pr‚lŠvement d''une couleur';
   1:S:='S‚lectionner et copier';
   2:S:='Crayon';
   3:S:='Fixe la couleur';
   4:S:='Brosse';
   5:S:='Dessine une ligne droite';
   6:S:='Texte';
   7:S:='Dessine des lignes multiples';
   8:S:='Remplissage';
   9:S:='Dessine une rectangle vide';
   10:S:='Dessine une rectangle plein';
   12:S:='Dessine un cercle vide';
   13:S:='Dessine un cercle plein';
   Else S:='';
  End;
  WEDone(Q.HelpBar);
  WEPushEndBar(Q.HelpBar);
  WEPutLastBar(S);
  Q.OldHelpBarP:=P;
 End;
End;

Procedure DWOnMouseMove(Var Context;X,Y:Integer;TX,TY:Byte);
Var
 Q:DrawEditApp Absolute Context;
 SGX1,SGY1,SGX2,SGY2:Word;
Begin
 If Not((Q.BufCur=NIL)or(Q.Canvas.Magnify))Then Begin
  SGX1:=Q.Canvas.Screen.X1-(WEGetRX1(Q.W)shl 3);
  SGY1:=Q.Canvas.Screen.Y1-GetRawY(WEGetRY1(Q.W));
  SGX2:=Q.Canvas.Screen.X2-(WEGetRX1(Q.W)shl 3);
  SGY2:=Q.Canvas.Screen.Y2-GetRawY(WEGetRY1(Q.W));
  If(X>=SGX1)and(X<=SGX2)and(Y>=SGY1)and(Y<=SGY2)Then Begin
   __HideMousePtr;
   If(X<>Q.XC+SGX1)or(Y<>Q.YC)Then Begin
    DWPop(Q);
    Q.XC:=X-SGX1;Q.YC:=Y;Q.XPtr:=Q.XC;Q.YPtr:=Q.YC;
    DWPutPos(Q);
    _InitKbd;
    DWPush(Q);
   End;
   WEDone(Q.HelpBar);
  End
   Else
  Begin
   If Not(IsShowMouse)Then Begin
    DWPop(Q);
    __ShowMousePtr;
   End;
   DWPutHelpBar(Q,BMGetBut(Q.ButtonDraw,WEGetRX1(Q.W)+TX,WEGetRY1(Q.W)+TY));
  End;
 End
  Else
 Begin
  Q.XC:=TX;Q.YC:=TY;
  If(IsGrf)and(Q.XC>=12)Then Dec(Q.XC,12);
  If(Q.XC<>Q.XPtr)or(Q.YC<>Q.YPtr)Then Begin
   Q.XPtr:=Q.XC;Q.YPtr:=Q.YC;
   DWPutPos(Q);
  End;
 End;
End;

Procedure DWOnMouseControl(Var Context;Control:Word);
Var
 Q:DrawEditApp Absolute Context;
Begin
 Case(Control)of
  kbRBarMsUp:Begin
   DWScrollUp(Q);
   DelayMousePress(100);
  End;
  kbRBarMsDn:Begin
   DWScrollDn(Q);
   DelayMousePress(100);
  End;
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                       Processus DWOnKeyPress                    Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Ce processus est appel‚ lorsqu'une touche clavier non combinatoire
 (lettre et chiffre) est enfonc‚e par l'utilisateur.
}

Procedure DWOnKeyPress(Var Context;Key:Char);
Var
 Length:Word;
 Q:DrawEditApp Absolute Context;
Begin
 If(Pointer(Q.QQF)<>NIL)Then Begin
  DWPop(Q);
  Length:=DWPutFont(Q,Q.XText,Q.YText,Key);
  Inc(Q.XText,Length);
  If(Q.XText>Q.Canvas.Struct.NumXPixels)Then Begin
   Q.XText:=0;
   Inc(Q.YText,Q.QQFHeight);
  End;
  DWPush(Q);
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                       Processus DWOnKeyDown                     Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Ce processus est appel‚ lorsque l'utilisateur frappe une touche de
 contr“le comme les flŠches par exemple sur le clavier.
}

Procedure DWOnKeyDown(Var Context;Key:Word;Shift:ShiftState);
Label NotSM;
Var
 Q:DrawEditApp Absolute Context;
Begin
 If(Key=kbCtrlF1)Then DWInfo(Q)Else
 If(Q.BufCur=NIL)or(Q.Canvas.Magnify)Then Case(Key)of
  kbUp:If(ssScrollLockOn)in(Shift)Then DWScrollUp(Q)
       Else If Q.YC>0Then Dec(Q.YC)Else Q.YC:=Q.MaxY;
  kbLeft:If(ssScrollLockOn)in(Shift)Then DWScrollLeft(Q)Else
         If Q.XC>0Then Dec(Q.XC)Else Q.XC:=Q.MaxX;
  kbRight:If(ssScrollLockOn)in(Shift)Then DWScrollRight(Q)Else
          If(Q.XC<Q.MaxX)Then Inc(Q.XC)Else Q.XC:=0;
  kbDn:If(ssScrollLockOn)in(Shift)Then DWScrollDn(Q)
       Else If(Q.YC<Q.MaxY)Then Inc(Q.YC)Else Q.YC:=0;
 End
  Else
 Case(Key)of
  kbUp:If(ssScrollLockOn)in(Shift)Then DWScrollUp(Q)Else
       If Q.YC>0Then Dec(Q.YC)Else Q.YC:=Q.Canvas.SGYM;
  kbDn:If(ssScrollLockOn)in(Shift)Then DWScrollDn(Q)Else
       If(Q.YC<Q.Canvas.SGYM)Then Inc(Q.YC)Else Q.YC:=0;
  kbRight:If(ssScrollLockOn)in(Shift)Then DWScrollRight(Q)Else
          If(Q.XC<Q.Canvas.SGXM)Then Inc(Q.XC)Else Q.XC:=0;
  kbLeft:If(ssScrollLockOn)in(Shift)Then DWScrollLeft(Q)Else
         If Q.XC>0Then Dec(Q.XC)Else Q.XC:=Q.Canvas.SGXM;
  kbEnter:Case(Q.Mode)of
   drwBox:Begin
    If Not(Q.SM)Then Begin
     Q.XO:=Q.XC;
     Q.YO:=Q.YC;
    End
     Else
    WIPutFillBox(Q.Canvas,Q.XC,Q.YC,Q.XO,Q.YO);
    Goto NotSM;
   End;
   drwLine:Begin
    If Not(Q.SM)Then Begin
     Q.XO:=Q.XC;
     Q.YO:=Q.YC;
    End
    Else WIPutLine(Q.Canvas,Q.XC,Q.YC,Q.XO,Q.YO);
NotSM:Q.SM:=Not Q.SM;
   End;
  End;
 End;
End;

Procedure DWReSize(Var Context;X1,Y1,X2,Y2:Byte);
Var
 MX,MY:Byte;
 Q:DrawEditApp Absolute Context;
Begin
 WEReInit(Q.W,X1,Y1,X2,Y2);
 WISetWnTxt(Q.Canvas,X1+BMUseYTexts(Q.ButtonDraw)+2,Y1+1,X2-2,Y2,False);
 DWRefresh(Q);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                             Proc‚dure DWMove2                          Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure est appel‚e … chaque fois qu'un d‚placement de la fenˆtre
 d'application de dessin est effectu‚e.
}

Procedure DWMove2{Var QX;X,Y:Byte};
Var
 MX,MY:Byte;
 MoveX,MoveY,MoveXP,MoveYP:Integer;
 Q:DrawEditApp Absolute Context;
Begin
 MoveX:=(X-Q.W.T.X1);MoveY:=(Y-Q.W.T.Y1);
 MoveXP:=MoveX*8;MoveYP:=MoveY*HeightChr;
 MX:=Q.W.T.X2-Q.W.T.X1;
 MY:=Q.W.T.Y2-Q.W.T.Y1;
 Q.W.T.X1:=X;Q.W.T.X2:=X+MX;
 Q.W.T.Y1:=Y;Q.W.T.Y2:=Y+MY;
 Inc(Q.Canvas.Struct.T.X1,MoveX);
 Inc(Q.Canvas.Struct.T.Y1,MoveY);
 Inc(Q.Canvas.Struct.T.X2,MoveX);
 Inc(Q.Canvas.Struct.T.Y2,MoveY);
 Inc(Q.Canvas.Screen.X1,MoveXP);
 Inc(Q.Canvas.Screen.Y1,MoveYP);
 Inc(Q.Canvas.Screen.X2,MoveXP);
 Inc(Q.Canvas.Screen.Y2,MoveYP);
 DWRefresh(Q);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Proc‚dure DWMagnify                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de faire passer en mode magnifique l'application
 de programme de dessin.
}

Procedure DWMagnify{Var Q:DrawWins;X:Bool};Begin
 Q.Canvas.Magnify:=X;
 DWRefresh(Q);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Proc‚dure DWDone                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de fermer une fenˆtre objet de dialogue de
 dessin pr‚c‚damment cr‚‚ par le constructeur ®DWInit¯ ou ®DWOpen¯.
}

Function DWDone;
Var
 Q:DrawEditApp Absolute Context;
Begin
 DWDone:=0;
 If(Q.Modified)Then Begin
  Case WarningMsgYesNo('Le fichier '+Q.FileName+' n''a pas ‚t‚ sauvegard‚! Dois-je le sauver ?')of
   kbYes:DWSave(Q);{L'utilisateur le supplie de sauvegarder...}
   kbAbort:Begin
    DWDone:=kbAbort; {Abandon utilisateur,il ne voulait}
    Exit;            {pas r‚ellement quitter...}
   End;
  End;
 End;
 WEDone(Q.HelpBar);
 FreeMemory(Q.QQF,Q.QQFSize);
 XFreeMem(Q.ImgBufCur.X);
 WIDone(Q.Canvas);
 {$IFNDEF H}
  WEDone(Q.W)
 {$ENDIF}
End;

Procedure WISetWnTxt;Begin
 Inf.Struct.T.X1:=X1;
 Inf.Struct.T.Y1:=Y1;
 Inf.Struct.T.X2:=X2;
 Inf.Struct.T.Y2:=Y2;
 Inf.XMove:=0;Inf.YMove:=0;
 If(InitAll)Then Inf.BitmapInit:=False;
 Inf.Screen.X1:=X1*8;
 Inf.Screen.Y1:=Y1*GetHeightChr;
 Inf.Screen.X2:=(X2+1)*8-1;
 Inf.Screen.Y2:=(Y2+1)*GetHeightChr-1;
 If(Inf.Struct.NumXPixels<Inf.Screen.X2-Inf.Screen.X1)Then Begin
  Inf.Screen.X2:=Inf.Screen.X1+Inf.Struct.NumXPixels;
 End;
 If(Inf.Struct.NumYPixels<Inf.Screen.Y2-Inf.Screen.Y1)Then Begin
  Inf.Screen.Y2:=Inf.Screen.Y1+Inf.Struct.NumXPixels;
 End;
 Inf.SGXM:=Inf.Screen.X2-Inf.Screen.X1;
 Inf.SGYM:=Inf.Screen.Y2-Inf.Screen.Y1;
 Inf.DrawX:=Inf.SGXM shr 1;
 Inf.DrawY:=Inf.SGYM shr 1;
 Inf.DrawSize:=4;
 Inf.CurrColor:=0{ $F};
End;

Procedure WIInit;
Var
 S,PS:LongInt;
Begin
 Inf.Magnify:=Not(IsGraf);
 WISetWnTxt(Inf,WI.T.X1,WI.T.Y1,WI.T.X2,WI.T.Y2,True);
 Inf.Struct:=WI;
 S:=LongInt(Inf.Struct.NumXPixels)*LongInt(Inf.Struct.NumYPixels);
 PS:=S; { Taille physique pour le miroir}
 Case(WI.BitsPerPixel)of
  1:Begin
   S:=S shr 3;
   Inf.Res.BytesPerLine:=Inf.Struct.NumXPixels shr 3;
  End;
  2..4:Begin
   S:=S shr 1;
   Inf.PaletteRGB:=MemAlloc(SizeOf(Palette256RGB));
   Inf.Res.BytesPerLine:=Inf.Struct.NumXPixels shr 1;
  End;
  8:Begin
   Inf.PaletteRGB:=MemAlloc(SizeOf(Palette256RGB));
   Inf.Res.BytesPerLine:=Inf.Struct.NumXPixels;
  End;
  9..16:Begin
   S:=S shl 1;
   Inf.Res.BytesPerLine:=Inf.Struct.NumXPixels shl 1;
  End;
 End;
 Inf.BitmapInit:=XAllocMem(rmAllRes,S,Inf.Image)and XAllocMem(rmAllRes,PS,Inf.Miroir);
 ClrWn(WI.T.X1,WI.T.Y1,WI.T.X2,WI.T.Y2-1,WI.BaseColor shl 4);
End;

Procedure WIPutTTextXY;
Var
 Mtx:^TByte;
 _BH,I,J,K,Masque:Byte;
 _ES,_BP:Word;
Begin
 If(Height=GetHeightChr)Then Mtx:=@GetVideoTxtMtxPtr^
  Else
 Begin
 Case Height of
   8..10: _BH:=$03;
  13..14: _BH:=$02;
  15..16: _BH:=$06;
 End;
 ASM
  MOV AX,$1130
  MOV BH,_BH
  PUSH BP
   INT $10
   MOV BX,BP
  POP BP
  MOV _BP,BX
  MOV _ES,ES;
 END;
 Mtx:=Ptr(_ES,_BP);
 End;
 For J:=0to Length(S)-1do For I:=0to Height-1do Begin
  Masque:=Mtx^[(Height*Byte(S[J+1]))+I];
  For K:=0to 7do Begin
   If Masque and$80<>0Then WIPutPixel(Inf,X+J*8+K,Y+I);
   Masque:=Masque shl 1;
  End
 End
End;

Procedure WIMoveWn;
Var
 J:Word;
Begin
 Inf.XMove:=X;Inf.YMove:=Y;
 If Inf.XMove<0Then Inf.XMove:=0;
 If Inf.YMove<0Then Inf.YMove:=0;
 If(Inf.Magnify)Then For J:=0to(Inf.Struct.T.Y2-Inf.Struct.T.Y1)do Begin
  WIUpdateLn(Inf,J);
 End
  Else
 For J:=0to(Inf.SGYM)do WIUpdateLn(Inf,J);
End;

Function WIXMoveWn;Begin
 WIXMoveWn:=Inf.XMove;
End;

Function WIYMoveWn;Begin
 WIYMoveWn:=Inf.YMove;
End;

Procedure WIMoveWnX;Begin
 WIMoveWn(Inf,X,Inf.YMove)
End;

Procedure WIMoveWnY;Begin
 WIMoveWn(Inf,Inf.XMove,Y)
End;

Function WIIsInit;Begin
 WIIsInit:=Inf.BitmapInit;
End;

Procedure WISetColor;Begin
 Inf.CurrColor:=Color;
End;

Procedure WIDraw;
Var
 I:Byte;
 N:String;
 Mode:(_None_,_NoTrace_,_UnMove_);
 a,b:Word;

 Function ExtractNm:Integer;
 Var
  N:String;
  a,b:Integer;
 Begin
  N:='';
  While(StrI(I,S)in ArabicDigit)do Begin
   IncStr(N,S[I]);
   Inc(I)
  End;
  If N=''Then a:=1
         Else Val(N,a,b);
  ExtractNm:=a;
 End;

 Function ExtractNumValue:Integer;Begin
  ExtractNumValue:=ExtractNm*(Inf.DrawSize shr 2);
 End;

 Procedure _Ln2(X,Y:Integer);Begin
  WIPutLine(Inf,Inf.DrawX,Inf.DrawY,X,Y);
 End;

 Procedure SetPos(X,Y:Integer);Begin
  If(Mode<>_UnMove_)Then Begin
   Inf.DrawX:=X;
   Inf.DrawY:=Y;
  End;
  Mode:=_None_
 End;

Begin
 I:=1; Mode:=_None_;
 While I<=Length(S)do Begin
  Inc(I);
  Case StrI(I-1,S)of
   'B': Mode:=_NoTrace_;
   'C': Inf.CurrColor:=ExtractNm;
   'D': Begin
	 a:=ExtractNumValue;
	 If(Mode<>_NoTrace_)Then _Ln2(Inf.DrawX,Inf.DrawY+a);
	 SetPos(Inf.DrawX,Inf.DrawY+a)
	End;
   'E': Begin
	 a:=ExtractNumValue;
	 If(Mode<>_NoTrace_)Then _Ln2(Inf.DrawX+a,Inf.DrawY-a);
	 SetPos(Inf.DrawX+a,Inf.DrawY-a)
	End;
   'F': Begin
	 a:=ExtractNumValue;
	 If(Mode<>_NoTrace_)Then _Ln2(Inf.DrawX+a,Inf.DrawY+a);
	 SetPos(Inf.DrawX+a,Inf.DrawY+a)
	End;
   'G': Begin
	 a:=ExtractNumValue;
	 If(Mode<>_NoTrace_)Then _Ln2(Inf.DrawX-a,Inf.DrawY+a);
	 SetPos(Inf.DrawX-a,Inf.DrawY+a)
	End;
   'H': Begin
	 a:=ExtractNumValue;
	 If(Mode<>_NoTrace_)Then _Ln2(Inf.DrawX-a,Inf.DrawY-a);
	 SetPos(Inf.DrawX-a,Inf.DrawY-a)
	End;
   'L': Begin
	 a:=ExtractNumValue;
	 If(Mode<>_NoTrace_)Then _Ln2(Inf.DrawX-a,Inf.DrawY);
	 SetPos(Inf.DrawX-a,Inf.DrawY)
	End;
   'M': Begin
	 a:=ExtractNm;
	 If StrI(I,S)=','Then Begin
          Inc(I);b:=ExtractNm;
         End
          Else
         b:=Inf.DrawY;
	 If(Mode<>_NoTrace_)Then _Ln2(a,b);
	 SetPos(a,b)
	End;
   'N': Mode:=_UnMove_;
   'R': Begin
	 a:=ExtractNumValue;
	 If(Mode<>_NoTrace_)Then _Ln2(Inf.DrawX+a,Inf.DrawY);
	 SetPos(Inf.DrawX+a,Inf.DrawY)
	End;
   'U': Begin
	 a:=ExtractNumValue;
	 If(Mode<>_NoTrace_)Then _Ln2(Inf.DrawX,Inf.DrawY-a);
	 SetPos(Inf.DrawX,Inf.DrawY-a)
	End;
' ',';':;
    Else Break;
  End
 End
End;

Procedure WIPutLineHor(Var Q:MCanvas;X1,Y,X2:Word);Begin
 If WIIsInit(Q)Then WIPutFillBox(Q,X1,Y,X2,Y);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                      Proc‚dure WIPutRect                  Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de dessiner un rectangle vide dans le
 canvas.
}

Procedure WIPutRect;
Var
 J:Word;
Begin
 If WIIsInit(Inf)Then Begin
  If(Y1>Y2)Then SwapWord(Y1,Y2);
  WIPutLineHor(Inf,X1,Y1,X2);
  For J:=Y1+1to Y2-1do Begin
   WIPutPixel(Inf,X1,J);
   WIPutPixel(Inf,X2,J);
  End;
  WIPutLineHor(Inf,X1,Y2,X2);
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                    Proc‚dure WIPutFillRoundRect                 Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de dessiner un rectangle plein en coin rond
 dans le canvas.
}

Procedure WIPutFillRoundRect(Var Q:MCanvas;x1,y1,x2,y2,b:Integer);
Var
 a,xr,yr,x,j,y,xN,yN:Integer;
 AO,BO,AO2,BO2,AO4,BO4,d:LongInt;
Begin
 If(X1>X2)Then SwapInt(X1,X2);
 If(Y1>Y2)Then SwapInt(Y1,Y2);
 y:=y1;y1:=y2;y2:=y;yr:=b;xr:=b;xN:=x1+xr;yN:=y1-yr;
 If Not(y2+b>=yN)Then WIPutFillBox(Q,x1,y2+b,x2,yN);
 a:=b;BO:=b*b;AO:=a*a;y:=b;x:=0;
 ASM
   {AO2:=AO shl 1}
  {$IFDEF __386__}
   DB 66h;MOV AX,Word Ptr AO
   DB 66h;SHL AX,1
   DB 66h;MOV Word Ptr AO2,AX
  {$ELSE}
   LES AX,AO
   MOV DX,ES
   SHL AX,1
   RCL DX,1
   MOV Word Ptr AO2,AX
   MOV Word Ptr AO2[2],DX
  {$ENDIF}
   {AO4:=AO shl 2;}
  {$IFDEF __386__}
   DB 66h;SHL AX,1
   DB 66h;MOV Word Ptr AO4,AX
  {$ELSE}
   SHL AX,1
   RCL DX,1
   MOV Word Ptr AO4,AX
   MOV Word Ptr AO4[2],DX
  {$ENDIF}
   {BO2:=BO shl 1;}
  {$IFDEF __386__}
   DB 66h;MOV AX,Word Ptr BO
   DB 66h;SHL AX,1
   DB 66h;MOV Word Ptr BO2,AX
  {$ELSE}
   LES AX,BO
   MOV DX,ES
   SHL AX,1
   RCL DX,1
   MOV Word Ptr BO2,AX
   MOV Word Ptr BO2[2],DX
  {$ENDIF}
   {BO4:=BO shl 2;}
  {$IFDEF __386__}
   DB 66h;SHL AX,1
   DB 66h;MOV Word Ptr BO4,AX
  {$ELSE}
   SHL AX,1
   RCL DX,1
   MOV Word Ptr BO4,AX
   MOV Word Ptr BO4[2],DX
  {$ENDIF}
 END;
 {$IFDEF __386__}
  ASM
   MOV AX,Y
   DEC AX
   MUL Y
   DB ciPushDX,ciPushAX
   DW ciPopEAX
   DB 66h;IMUL Word Ptr AO2
   DB 66h;MOV BX,AX
   DB 66h;XOR AX,AX;INC AX
   DB 66h;SUB AX,Word Ptr AO
   DB 66h;DEC AX
   DB 66h;IMUL Word Ptr BO2
   DB 66h;ADD AX,BX
   DB 66h;ADD AX,Word Ptr AO
   DB 66h;MOV Word Ptr d,AX
  END;
 {$ELSE}
  d:=AO2*((y-1)*y)+AO+BO2*(1-AO);
 {$ENDIF}
 While(AO*y>BO*x)do Begin
  WIPutLnHor(Q,xN-y,yN+x,x2-yr+y);
  WIPutLnHor(Q,xN-y,y2+xr-x,x2-yr+y);
  If d>=0Then Begin;Dec(y);Dec(d,AO4*y)End;
  {$IFDEF __386__}
   ASM
    DB 66h;XOR AX,AX
    DB 66h;XOR BX,BX
    MOV AL,3
    MOV BX,X
    DB 66h;SHL BX,1
    DB 66h;ADD AX,BX
    DB 66h;IMUL Word Ptr BO2
    DB 66h;ADD Word Ptr D,AX
   END;
  {$ELSE}
   Inc(d,BO2*(3+(x shl 1)));
  {$ENDIF}
  Inc(x);
 End;
 d:=BO2*((x+1)*x)+AO2*(y*(y-2)+1)+(1-AO2)*BO;
 While y<>0do Begin
  WIPutLnHor(Q,xN-y,x+yN,x2-yr+y);
  WIPutLnHor(Q,xN-y,y2+xr-x,x2-yr+y);
  if d<=0Then Begin;Inc(x);Inc(d,BO4*x)End;
  Dec(y);
  {$IFDEF __386__}
   ASM
    DB 66h;XOR AX,AX
    DB 66h;XOR BX,BX
    MOV AL,3
    MOV BX,Y
    DB 66h;SHL BX,1
    DB 66h;SUB AX,BX
    DB 66h;IMUL Word Ptr AO2
    DB 66h;ADD Word Ptr D,AX
   END;
  {$ELSE}
   Inc(d,AO2*(3-(y shl 1)));
  {$ENDIF}
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                      Proc‚dure WIPutRoundRect                  Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de dessiner un rectangle vide en coin rond
 dans le canvas.
}

Procedure WIPutRoundRect(Var Q:MCanvas;x1,y1,x2,y2,LineWidth,b:Integer);
Var
 a,xr,yr,x,i,j,y,xN,yN:Integer;
 AO,BO,AO2,BO2,AO4,BO4,d:LongInt;
Begin
 If(X1>X2)Then SwapInt(X1,X2);
 If(Y1>Y2)Then SwapInt(Y1,Y2);
 If LineWidth>0Then Dec(LineWidth);
 y:=y1;y1:=y2;y2:=y;yr:=b;xr:=b;xN:=x2-xr;yN:=y2+yr;
 For j:=-(LineWidth shr 1)to LineWidth shr 1+(LineWidth and 1)do Begin
  WIPutLineHor(Q,x1+xr,y1-j,xN);
  WIPutLineHor(Q,x1+xr,y2-j,xN);
 End;
 For j:=-(LineWidth shr 1)to LineWidth shr 1+(LineWidth and 1)do Begin
  For i:=y1-yr downto(yN)do Begin
   WIPutPixel(Q,x1+j,i);
   WIPutPixel(Q,x2+j,i)
  End;
 End;
 Dec(b,LineWidth shr 1);a:=b;
 For i:=0to(LineWidth)do Begin
  BO:=b*b;AO:=a*a;y:=b;x:=0;
  ASM
    {AO2:=AO shl 1}
   {$IFDEF __386__}
    DB 66h;MOV AX,Word Ptr AO
    DB 66h;SHL AX,1
    DB 66h;MOV Word Ptr AO2,AX
   {$ELSE}
    LES AX,AO
    MOV DX,ES
    SHL AX,1
    RCL DX,1
    MOV Word Ptr AO2,AX
    MOV Word Ptr AO2[2],DX
   {$ENDIF}
    {AO4:=AO shl 2;}
   {$IFDEF __386__}
    DB 66h;SHL AX,1
    DB 66h;MOV Word Ptr AO4,AX
   {$ELSE}
    SHL AX,1
    RCL DX,1
    MOV Word Ptr AO4,AX
    MOV Word Ptr AO4[2],DX
   {$ENDIF}
    {BO2:=BO shl 1;}
   {$IFDEF __386__}
    DB 66h;MOV AX,Word Ptr BO
    DB 66h;SHL AX,1
    DB 66h;MOV Word Ptr BO2,AX
   {$ELSE}
    LES AX,BO
    MOV DX,ES
    SHL AX,1
    RCL DX,1
    MOV Word Ptr BO2,AX
    MOV Word Ptr BO2[2],DX
   {$ENDIF}
    {BO4:=BO shl 2;}
   {$IFDEF __386__}
    DB 66h;SHL AX,1
    DB 66h;MOV Word Ptr BO4,AX
   {$ELSE}
    SHL AX,1
    RCL DX,1
    MOV Word Ptr BO4,AX
    MOV Word Ptr BO4[2],DX
   {$ENDIF}
  END;
  d:=Long(AO2)*Long((y-1)*y)+AO+Long(BO2)*Long(1-AO);
  While(Long(AO)*Long(y)>Long(BO)*Long(x))do Begin
   WIPutPixel(Q,x+xN,yN-y);
   WIPutPixel(Q,x+xN,y1-yr+y);
   WIPutPixel(Q,x1+xr-x,yN-y);
   WIPutPixel(Q,x1+xr-x,y1-yr+y);
   If d>=0Then Begin
    Dec(y);
    Dec(d,Long(AO4)*Long(y))
   End;
   Inc(d,Long(BO2)*Long(3+(x shl 1)));
   Inc(x);
  End;
  d:=Long(BO2)*Long((x+1)*x)+Long(AO2)*Long(y*(y-2)+1)+Long(1-AO2)*Long(BO);
  While y<>0do Begin
   WIPutPixel(Q,x+xN,yN-y);
   WIPutPixel(Q,x+xN,y1-yr+y);
   WIPutPixel(Q,x1+xr-x,yN-y);
   WIPutPixel(Q,x1+xr-x,y1-yr+y);
   if d<=0Then Begin
    Inc(x);
    Inc(d,Long(BO4)*Long(x))
   End;
   Dec(y);
   Inc(d,Long(AO2)*Long(3-(y shl 1)));
  End;
  Inc(b);Inc(a)
 End;
End;

Function WIGetPosImage(Var Q:MCanvas;X,Y:Integer):LongInt;Near;Begin
 WIGetPosImage:=Mul2Word(Q.YMove+Y,Q.Res.BytesPerLine)+
                Long(LocalBytesPerLine(Q.XMove+X,Q.Res.BitsPerPixel))+
                SizeOf(ImageHeaderRes);
End;

Function WIGetPosMiroir(Var Q:MCanvas;X,Y:Integer):LongInt;Near;Begin
 If BitsPerPixel=4Then Begin
  WIGetPosMiroir:=Mul2Word(Q.YMove+Y,Q.Res.NumXPixels)+LongInt(Q.XMove+X);
 End
  Else
 WIGetPosMiroir:=Mul2Word(Q.YMove+Y,LocalBytesPerLine(Q.Res.NumXPixels,BitsPerPixel))+
                 LongInt(LocalBytesPerLine(Q.XMove+X,BitsPerPixel));
End;

Function WIIsMiroir(Var Q:MCanvas):Boolean;Near;Begin
 WIIsMiroir:=Not((Q.Miroir.Handle=$FFFF)or(Q.Miroir.Output=$FF)or(Q.Miroir.Size=0));
End;

Function WIGetColorMiroir(Var Q:MCanvas;Color:Word):Word;Near;
Var
 RGBColor:RGB;
Begin
 If WIIsMiroir(Q)Then Begin
  _Color2RGB(Color,Q.Res.BitsPerPixel,RGBColor);
  WIGetColorMiroir:=RGB2Color(RGBColor.R,RGBColor.G,RGBColor.B);
 End
  Else
 Case(Q.Res.BitsPerPixel)of
  1:If BitsPerPixel>1Then Begin
   If Color=0Then WIGetColorMiroir:=0
             Else WIGetColorMiroir:=RGB2Color($FF,$FF,$FF);
  End
   Else
  WIGetColorMiroir:=Color;
  Else WIGetColorMiroir:=Color;
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                       Proc‚dure WIPutFillBox                    Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure trace une boŒte pleine dans le tampon objet o— est
 contenu l'image en plus de mettre  … jour l'image vid‚o en fonction
 de cette nouvelle boŒte.
}

Procedure WIPutFillBox;
Var
 P:^TByte;
 S,TS,I:Word;
 F:LongInt;
 C:Byte;
 RKr:Word;
 BytesPerLine:Word;
 ColorRGB:RGB;
Begin
 If WIIsInit(Inf)Then Begin
  If(X1>X2)Then SwapWord(X1,X2);
  If(Y1>Y2)Then SwapWord(Y1,Y2);
  RKr:=Inf.CurrColor;
  F:=WIGetPosImage(Inf,X1,Y1);
  If(Inf.BitmapInit)Then Case(Inf.Struct.BitsPerPixel)of
   1:Begin
    S:=Inf.Res.BytesPerLine;
    P:=MemAlloc(S);
    If(P=NIL)Then Exit;
    For I:=Y1 to(Y2)do Begin
     XGetAbsRec(Inf.Image,F,S,P^);
     FillBoolAt(P^,X1,(X2-X1)+1,Boolean(Inf.CurrColor));
     XSetAbsRec(Inf.Image,F,S,P^);
     Inc(F,Inf.Res.BytesPerLine)
    End;
    FreeMemory(P,S);
    RKr:=WIGetColorMiroir(Inf,RKr);
   End;
   2..4:Begin
    S:=(X2-X1+1)shr 1;
    P:=MemAlloc(S);
    If(P=NIL)Then Exit;
    FillQuartet(P^,S shl 1,Inf.CurrColor);
    For I:=Y1 to(Y2)do Begin
     If X2 and 1=0Then Begin
      XSetAbsRec(Inf.Image,F,S-1,P^);
      XGetAbsRec(Inf.Image,F+S-1,SizeOf(Byte),C);
      C:=(C and$F)+(Inf.CurrColor shl 4);
      XSetAbsRec(Inf.Image,F+S-1,SizeOf(Byte),C);
     End
      Else
     XSetAbsRec(Inf.Image,F,S,P^);
     Inc(F,Inf.Res.BytesPerLine)
    End;
    FreeMemory(P,S)
   End;
   5..8:Begin
    S:=X2-X1+1;TS:=S;
    If BitsPerPixel>8Then TS:=TS shl 1;
    P:=MemAlloc(TS);
    If(P=NIL)Then Exit;
     {Mise … jour de l'image}
    FillChr(P^,S,Inf.CurrColor);
    For I:=Y1 to(Y2)do Begin
     XSetAbsRec(Inf.Image,F,S,P^);
     Inc(F,Inf.Res.BytesPerLine)
    End;
     {Mise … jour du miroir}
    F:=WIGetPosMiroir(Inf,X1,Y1);
    If BitsPerPixel>8Then Begin
     If Inf.Res.NumPal=0Then
      RKr:=RGB2Color(DefaultRGB[Inf.CurrColor].R,
                     DefaultRGB[Inf.CurrColor].G,
                     DefaultRGB[Inf.CurrColor].B)
     Else
      RKr:=RGB2Color(Inf.PaletteRGB^[Inf.CurrColor].R,
                     Inf.PaletteRGB^[Inf.CurrColor].G,
                     Inf.PaletteRGB^[Inf.CurrColor].B);
     FillWord(P^,S,RKr);
     For I:=Y1 to(Y2)do Begin
      XSetAbsRec(Inf.Miroir,F shl 1,TS,P^);
      Inc(F,Inf.Res.BytesPerLine)
     End;
    End
     Else
    Begin
     FillChr(P^,S,Inf.CT[Inf.CurrColor]);
     For I:=Y1 to(Y2)do Begin
      XSetAbsRec(Inf.Miroir,F,S,P^);
      Inc(F,Inf.Res.BytesPerLine)
     End;
    End;
    FreeMemory(P,TS);
   End;
   9..16:Begin
     { Mise … jour de l'image }
    S:=(X2-X1+1)shl 1;
    P:=MemAlloc(S);
    If(P=NIL)Then Exit;
    FillWord(P^,S shr 1,Inf.CurrColor);
    For I:=Y1 to(Y2)do Begin
     XSetAbsRec(Inf.Image,F,S,P^);
     Inc(F,Inf.Res.BytesPerLine);
    End;
    FreeMemory(P,S);
     { Mise … jour du miroir }
    If WIIsMiroir(Inf)Then Begin
     _Color2RGB(Inf.CurrColor,Inf.Res.BitsPerPixel,ColorRGB);
     RKr:=RGB2Color(ColorRGB.R,ColorRGB.G,ColorRGB.B);
     S:=LocalBytesPerLine(X2-X1+1,BitsPerPixel);
     P:=MemAlloc(S);
     If(P=NIL)Then Exit;
     Case(BitsPerPixel)of
      8:FillChr(P^,S,RKr);
      15,16:FillWord(P^,X2-X1+1,RKr);
     End;
     F:=WIGetPosMiroir(Inf,X1,Y1);
     BytesPerLine:=LocalBytesPerLine(Inf.Res.NumXPixels,BitsPerPixel);
     For I:=Y1 to(Y2)do Begin
      XSetAbsRec(Inf.Miroir,F,S,P^);
      Inc(F,BytesPerLine);
     End;
     FreeMemory(P,S);
    End;
   End
  End;
  If(Y1<Inf.SGYM)and(X1<Inf.SGXM)Then Begin
   If(X2>Inf.SGXM)Then X2:=Inf.SGXM;
   If(Y2>Inf.SGYM)Then Y2:=Inf.SGYM;
   If Inf.Struct.BitsPerPixel=8Then Begin
    If BitsPerPixel<15Then RKr:=Inf.CT[RKr];
   End;
   PutFillBox(Inf.Screen.X1+X1,Inf.Screen.Y1+Y1,
              Inf.Screen.X1+X2,Inf.Screen.Y1+Y2,RKr);
  End
 End
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Proc‚dure WIPutLnHor                      Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure trace une ligne horinzontal dans le tampon objet o—
 est contenu  l'image  en plus  de mettre  … jour  l'image  vid‚o  en
 fonction de cette nouvelle ligne.
}

Procedure WIPutLnHor;Begin
 WIPutFillBox(Inf,X1,Y,X2,Y)
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Proc‚dure WIPutLine                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure trace une ligne dans le tampon objet o— est contenu
 l'image en plus de mettre … jour l'image vid‚o  en fonction de cette
 nouvelle ligne.
}

Procedure WIPutLine;
Var
 D,DX,DY,I,J,Ainc,Binc,Ic:Integer;
Begin
 If(Y2=Y1)Then Begin
  WIPutLnHor(Inf,X1,Y1,X2);
  Exit;
 End;
 If AbsInt(X2-X1)<AbsInt(Y2-Y1)Then Begin
  If(Y1>Y2)Then ASM
   MOV AX,X1
   XCHG AX,X2
   MOV X1,AX
   MOV AX,Y1
   XCHG AX,Y2
   MOV Y1,AX
  END;
  If(X2>X1)Then Ic:=1 Else Ic:=-1;
  DY:=Y2-Y1;
  DX:=AbsInt(X2-X1);
  D:=(DX shl 1)-DY;
  Ainc:=(DX-DY)shl 1;
  Binc:=DX shl 1;J:=X1;
  WIPutPixel(Inf,X1,Y1);
  I:=Y1+1;
  While(I<=Y2)do Begin
   If D>=0Then Begin
    Inc(J,Ic);
    Inc(D,Ainc)
   End
    Else
   Inc(D,Binc);
   WIPutPixel(Inf,J,I);
   Inc(I);
  End;
 End
  else
 Begin
  If(X1>X2)Then ASM
   MOV AX,X1
   XCHG AX,X2
   MOV X1,AX
   MOV AX,Y1
   XCHG AX,Y2
   MOV Y1,AX
  END;
  If(Y2>Y1)Then Ic:=1
           Else Ic:=-1;
  DX:=X2-X1;
  DY:=AbsInt(Y2-Y1);
  D:=(DY shl 1)-DX;
  AInc:=(DY-DX)shl 1;
  BInc:=DY shl 1;J:=Y1;
  WIPutPixel(Inf,X1,Y1);
  I:=X1+1;
  While(I<=X2)do Begin
   If D>=0Then Begin
    Inc(J,Ic);Inc(D,Ainc)
   End
    Else
   Inc(D,Binc);
   WIPutPixel(Inf,I,J);
   Inc(I);
  End;
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Proc‚dure WEPutPixel                      Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure trace une pixel dans le tampon objet o— est contenu
 l'image en plus de mettre … jour l'image vid‚o  en fonction de cette
 nouvelle pixel.
}

Procedure WIPutPixel;Begin
 WISetPixel(Inf,X,Y,Inf.CurrColor)
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Proc‚dure WISetPixel                      Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure trace une pixel dans le tampon objet o— est contenu
 l'image en plus de mettre … jour  l'image  vid‚o avec  la couleur de
 pixel sp‚cifi‚.
}

Procedure WISetPixel;
Label UpdateMiroir;
Var
 F:LongInt;
 C:Byte;
 RealColor,MKr:LongInt;
 CW,TX:Word;
 ColorRGB:RGB Absolute Color;
Begin
 If(Inf.BitmapInit)Then Begin
  RealColor:=Color;
  MKr:=Color;
  TX:=X+Inf.XMove;
  F:=WIGetPosImage(Inf,X,Y);
  Case(Inf.Struct.BitsPerPixel)of
   1:Begin
    XGetAbsRec(Inf.Image,F,SizeOf(Byte),C);
    Color:=C and Not($80 shr(TX and 7))+(Color shr(TX and 7));
    XSetAbsRec(Inf.Image,F,SizeOf(Byte),Color);
    RealColor:=WIGetColorMiroir(Inf,RealColor);
   End;
   2..4:Begin
    XGetAbsRec(Inf.Image,F,SizeOf(Byte),C);
    If TX and 1=1Then Color:=(C and$F0)+Color
                 Else Color:=(C and$F)+(Color shl 4);
    XSetAbsRec(Inf.Image,F,SizeOf(Byte),Color)
   End;
   5..8:Begin
     { Mise … jour de l'image}
    XSetAbsRec(Inf.Image,F,SizeOf(Byte),Color);
     { Mise … jour du miroir}
    Dec(F,Long(SizeOf(ImageHeaderRes)));
    If BitsPerPixel>=15Then Begin
     If Inf.Res.NumPal=0Then
      CW:=RGB2Color(DefaultRGB[Color and$F].R,DefaultRGB[Color and$F].G,DefaultRGB[Color and$F].B)
      Else
     If(Inf.PaletteRGB<>NIL)Then Begin
      CW:=RGB2Color(Inf.PaletteRGB^[Color].R,Inf.PaletteRGB^[Color].G,Inf.PaletteRGB^[Color].B);
      RealColor:=CW;
     End
      Else
     CW:=Color;
     XSetAbsRec(Inf.Miroir,F shl 1,SizeOf(Word),CW);
    End
     Else
    Begin
     If(Inf.PaletteRGB<>NIL)Then
      XSetAbsRec(Inf.Miroir,F,SizeOf(Byte),Inf.CT[Color])
     Else
      XSetAbsRec(Inf.Miroir,F,SizeOf(Byte),Color);
    End;
   End;
   9..16:Begin
    XSetAbsRec(Inf.Image,F,SizeOf(Word),Color);
    RealColor:=WIGetColorMiroir(Inf,Color);
    Goto UpdateMiroir;
   End;
   24:Begin
    XSetAbsRec(Inf.Image,F,SizeOf(RGB),Color);
    RealColor:=RGB2Color(ColorRGB.R,ColorRGB.G,ColorRGB.B);
UpdateMiroir:
    If WIIsMiroir(Inf)Then Begin
     Case(BitsPerPixel)of
      4,8:XSetAbsRec(Inf.Miroir,WIGetPosMiroir(Inf,X,Y),SizeOf(Byte),RealColor);
      15..16:XSetAbsRec(Inf.Miroir,WIGetPosMiroir(Inf,X,Y),SizeOf(Word),RealColor);
     End;
    End;
   End;
  End;
 End;
 If(X<Inf.SGXM)and(Y<Inf.SGYM)Then Begin
  If Inf.Struct.BitsPerPixel=8Then Begin
   If(Inf.Res.NumPal<>0)and(Inf.PaletteRGB<>NIL)Then RealColor:=Inf.CT[RealColor];
  End;
  If(Inf.Magnify)Then Begin
   SetCube(Inf.Struct.T.X1+X,Inf.Struct.T.Y1+Y,'ş',MKr);
   If(IsGrf)Then Plot(Inf.MagnifyX+X,Inf.MagnifyY+Y,RealColor);
  End
   Else
  Plot(Inf.Screen.X1+X,Inf.Screen.Y1+Y,RealColor)
 End;
End;

Procedure WIFloodFill(Var Q:MCanvas;X,Y:Integer);
Var
 C2:Word;
 BreakAll:Boolean;

 Procedure PredLine(L,R,Y:Integer;UpDown:Byte);Near;
 Var
  X,X2:Integer;
 Begin
  If(BreakAll)Then Exit;
  If(WIGetPixel(Q,L,Y)=C2)Then Begin
   While(L>0)and(WIGetPixel(Q,L-1,Y)=C2)do Dec(L);
  End;
  X:=L;
  If(WIGetPixel(Q,R,Y)=C2)Then Begin
   While(R<Q.Struct.NumXPixels)and(WIGetPixel(Q,R+1,Y)=C2)do Inc(R);
  End;
  While(X<=R)do Begin
   If(BreakAll)Then Exit;
   If(KeyPress)and(ReadKey=kbEsc)Then Begin
    BreakAll:=True;
    Exit;
   End;
   X2:=X;
   If(WIGetPixel(Q,X,Y)=C2)Then Begin
    While(WIGetPixel(Q,X+1,Y)=C2)and(X<Q.Struct.NumXPixels)do Inc(X);
    WIPutLnHor(Q,X2,Y,X);
    If UpDown=2Then Begin
     If Y>0Then PredLine(X2,X,Y-1,2);
     If(Y<Q.Struct.NumYPixels)Then If(L>X2)and(R<X)Then Begin
      PredLine(X2,L-1,Y+1,1);
      PredLine(R+1,X,Y+1,1);
     End
      Else
     If(L<=X2)and(R<X)Then PredLine(R+1,X,Y+1,1)Else
     If(L>X2)and(R>=X)Then PredLine(X2,L-1,Y+1,1);
    End;
    If UpDown=1Then Begin
     If(Y<Q.Struct.NumYPixels)Then PredLine(X2,X,Y+1,1);
     If Y>0Then If(L>X2)and(R<X)Then Begin
      PredLine(X2,L-1,Y-1,2);
      PredLine(R+1,X,Y-1,2);
     End
      Else
     If(L<=X2)and(R<X)Then PredLine(R+1,X,Y-1,2)Else
     If(L>X2)and(R>=X)Then PredLine(X2,L-1,Y-1,2);
    End;
   End;
   Inc(X);
  End;
 End;

Begin
 BreakAll:=False;
 C2:=WIGetPixel(Q,X,Y);
 If Y<>0Then Dec(Y);
 PredLine(X,X,Y,2);
 PredLine(X,X,Y+1,1);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Fonction WIUpDateLn                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de mettre … jour une ligne affich‚e … l'‚cran du
 dessin contenue dans l'enregistrement ®MCanvas¯.
}

Procedure WIUpDateLn;
Label IfMagnify,DefaultMagnify;
Var
 XBuf:^TByte;
 XBufW:^TWord Absolute XBuf;
 I:Word;             { Compteur de boucle }
 B,TX2,GX,GY:Word;
 TX1,TY,TL:Byte;
 LBytesPerLine:Word;
 Color:Word;
Begin
 If(Y>=Inf.Struct.NumYPixels)Then Exit;
 If(Inf.BitmapInit)Then Begin
  LBytesPerLine:=Inf.Res.BytesPerLine;
  B:=Inf.Res.BytesPerLine;
  If(B<Inf.Struct.NumXPixels)Then B:=Inf.Struct.NumXPixels;
  If BitsPerPixel>8Then Begin
   If Inf.Res.BitsPerPixel>=15Then B:=Inf.Struct.NumXPixels;
   B:=ScrnBytesPerLine(B);
  End;
  If(LBytesPerLine>B)Then LBytesPerLine:=B;
  XBuf:=MemAlloc(B);
  If(XBuf=NIL)Then Exit;
  XGetAbsRec(Inf.Image,WIGetPosImage(Inf,0,Y),LBytesPerLine,XBuf^);
  If(Inf.Magnify)Then Begin
   TX1:=Inf.Struct.T.X1;
   TY:=Inf.Struct.T.Y1+Y;
   TX2:=Inf.Struct.T.X2;
   TL:=(TX2-TX1);
   If(TL>=Inf.Struct.NumXPixels-1)Then TL:=Inf.Struct.NumXPixels-1;
   Case(Inf.Struct.BitsPerPixel)of
    1:Begin
     For I:=0to(TL)do Begin
      If (XBuf^[(Inf.XMove+I)shr 3]shr (7-(I and 7)))and 1=0Then
       SetCube(TX1+I,TY,'ş',White)
      Else
       SetCube(TX1+I,TY,'ş',Black);
     End;
    End;
    4:Begin
     For I:=0to(TL)do Begin
      If I and 1=0Then SetCube(TX1+I,TY,'ş',XBuf^[(Inf.XMove+I)shr 1]shr 4)
                  Else SetCube(TX1+I,TY,'ş',XBuf^[(Inf.XMove+I)shr 1]and$F);
     End;
    End;
    15,16:If BitsPerPixel>=15Then Begin
     For I:=0to(TL)do Begin
      GX:=(TX1+I)shl 3;
      GY:=GetRawY(TY);
      Color:=WIGetColorMiroir(Inf,XBufW^[Inf.XMove+I]);
      PutFillBox(GX+1,GY+1,GX+7,GY+HeightChr-1,Color);
     End;
    End
     Else
    Goto DefaultMagnify;
    Else DefaultMagnify:Begin
     For I:=0to(TL)do SetCube(TX1+I,TY,'ş',XBuf^[Inf.XMove+I]);
    End;
   End;
   GX:=Inf.MagnifyX;GY:=Inf.MagnifyY+Y;I:=Inf.MagnifyLength;
   If(IsGrf)Then Goto IfMagnify;
  End
   Else
  Begin
   I:=Inf.Screen.X2-Inf.Screen.X1+1;
   GX:=Inf.Screen.X1;GY:=Inf.Screen.Y1+Y;
IfMagnify:
   If(BitsPerPixel>8)and((Inf.Res.BitsPerPixel>4)or(Inf.Res.NumPal>0))Then Begin
    If Inf.Miroir.Output<>$FFThen XGetRec(Inf.Miroir,Inf.YMove+Y,B,XBuf^);
    If(I>Inf.Struct.NumXPixels)Then I:=Inf.Struct.NumXPixels;
    TX2:=LocalBytesPerLine(Inf.XMove,BitsPerPixel);
    ClrLnHorImg(GX,GY,I,BitsPerPixel,XBuf^[TX2])
   End
    Else
   If Inf.Struct.BitsPerPixel=24Then Begin
    XGetRec(Inf.Miroir,Inf.YMove+Y,Inf.Struct.NumXPixels,XBuf^);
    If(I>Inf.Struct.NumXPixels)Then I:=Inf.Struct.NumXPixels;
    TX2:=Inf.XMove;
    ClrLnHorImg(GX,GY,I,8,XBuf^[TX2])
   End
    Else
   Begin
    If WIIsMiroir(Inf)and Not(Inf.Res.BitsPerPixel<=4)Then Begin
     XGetAbsRec(Inf.Miroir,WIGetPosMiroir(Inf,0,Y),Inf.Res.BytesPerLine,XBuf^);
     If(I>Inf.Struct.NumXPixels)Then I:=Inf.Struct.NumXPixels;
     ClrLnHorImg(GX,GY,I,BitsPerPixel,XBuf^)
    End
     Else
    Begin
     XGetAbsRec(Inf.Image,WIGetPosImage(Inf,0,Y),Inf.Res.BytesPerLine,XBuf^);
     If(I>Inf.Struct.NumXPixels)Then I:=Inf.Struct.NumXPixels;
     TX2:=Inf.XMove;
     If Inf.Struct.BitsPerPixel=4Then TX2:=TX2 shr 1;
     ClrLnHorImg(GX,GY,I,Inf.Struct.BitsPerPixel,XBuf^[TX2]);
    End;
   End;
  End;
  FreeMemory(XBuf,B)
 End;
End;

Procedure WICopyAllLn;
Var
 PBuffer:TByte Absolute XBuf;
 TBuf:^TByte;
 X2M,I,BPL:Word;
 TX1,TY,TX2:Byte;

 Procedure LineTrueColor;
 Var
  Target:Array[0..255]of Word;
 Begin
  MakePaletteDoublon(Inf.PaletteRGB^,Target,256);
  Line2Doublon(PBuffer,TBuf^,Target,BitsPerPixel,Inf.Res.BitsPerPixel,Inf.Res.NumXPixels);
 End;

Begin
 If(Inf.BitmapInit)Then Begin
  XSetAbsRec(Inf.Image,(Long(Inf.YMove+Y)*Long(Inf.Res.BytesPerLine))+SizeOf(ImageHeaderRes),
                   Inf.Res.BytesPerLine,XBuf);
 End;
 Case(Inf.Struct.BitsPerPixel)of
  4:Begin
   If Not(Inf.Screen.Y1+Y>Inf.Screen.Y2)Then Begin
    I:=Inf.Screen.X2-Inf.Screen.X1+1;
    If(I>Inf.Struct.NumXPixels)Then I:=Inf.Struct.NumXPixels;
    ClrLnHorImg(Inf.Screen.X1,Inf.Screen.Y1+Y,I,Inf.Struct.BitsPerPixel,PBuffer[Inf.XMove shr 1]);
   End;
  End;
  5..8:Begin
   BPL:=LocalBytesPerLine(Inf.Res.NumXPixels,BitsPerPixel);
   If Not(Inf.Screen.Y1+Y>Inf.Screen.Y2)Then Begin
    If(Inf.Screen.X1+Inf.Struct.NumXPixels<Inf.Screen.X2)Then Begin
     X2M:=Inf.Screen.X1+Inf.Struct.NumXPixels-1
    End
     Else
    Begin
     X2M:=Inf.Screen.X2;
    End;
    If(Inf.Magnify)Then Begin
     If(Y>=Inf.Struct.T.Y2-Inf.Struct.T.Y1)Then Exit;
     TX1:=Inf.Struct.T.X1;
     TY:=Inf.Struct.T.Y1+Y;
     TX2:=Inf.Struct.T.X2;
     For I:=0to(TX2-TX1)do SetCube(TX1+I,TY,'ş',PBuffer[I+Inf.XMove]);
    End
     Else
    Begin
     TBuf:=MemAlloc(BPL);
     If(TBuf=NIL)Then Exit;
     If BitsPerPixel>8Then LineTrueColor
      Else
     Line2Doublon(PBuffer,TBuf^,Inf.CT,BitsPerPixel,Inf.Res.BitsPerPixel,Inf.Res.NumXPixels);
     XSetRec(Inf.Miroir,Inf.YMove+Y,BPL,TBuf^);
     I:=Inf.Screen.X2-Inf.Screen.X1+1;
     If(I>Inf.Struct.NumXPixels)Then I:=Inf.Struct.NumXPixels;
     ClrLnHorImg(Inf.Screen.X1,Inf.Screen.Y1+Y,I,BitsPerPixel,
                 TBuf^[LocalBytesPerLine(Inf.XMove,BitsPerPixel)]);
     FreeMemory(TBuf,BPL)
    End;
   End
    Else
   Begin
    TBuf:=MemAlloc(BPL);
    If(TBuf=NIL)Then Exit;
    Line2Doublon(PBuffer,TBuf^,Inf.CT,BitsPerPixel,Inf.Res.BitsPerPixel,Inf.Res.NumXPixels);
    XSetRec(Inf.Miroir,Inf.YMove+Y,BPL,TBuf^);
    FreeMemory(TBuf,BPL)
   End;
  End;
  15,16:Begin
   If Not(Inf.Screen.Y1+Y>Inf.Screen.Y2)Then Begin
    I:=Inf.Screen.X2-Inf.Screen.X1+1;
    If(I>Inf.Struct.NumXPixels)Then I:=Inf.Struct.NumXPixels;
    ClrLnHorImg(Inf.Screen.X1,Inf.Screen.Y1+Y,I,Inf.Struct.BitsPerPixel,PBuffer[Inf.XMove shl 1]);
   End;
  End;
 End;
End;

Procedure WICopyAllLnNoUpDate;
Var
 PBuffer:TByte Absolute XBuf;
 TBuf:^TByte;
Begin
 Case(Inf.Struct.BitsPerPixel)of
  5..8:Begin
   XSetAbsRec(Inf.Image,Y*Inf.Struct.NumXPixels+SizeOf(ImageHeaderRes),Inf.Struct.NumXPixels,XBuf);
   TBuf:=MemAlloc(Inf.Struct.NumXPixels);
   If(TBuf=NIL)Then Exit;
   Line2Doublon(PBuffer,TBuf^,Inf.CT,BitsPerPixel,Inf.Res.BitsPerPixel,Inf.Res.NumXPixels);
   XSetRec(Inf.Miroir,Y,Inf.Struct.NumXPixels,TBuf^);
   FreeMemory(TBuf,Inf.Struct.NumXPixels)
  End;
 End
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Fonction WIGetPixel                      Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de connaŒtre le contenu de l'image Canvas … la
 position sp‚cifier.
}

Function WIGetPixel;
Var
 L:LongInt;
 W:Word Absolute L;
 Z:Byte Absolute L;
 F:LongInt;
Begin
 If(Inf.BitmapInit)Then Begin
  F:=WIGetPosImage(Inf,X,Y);
  XGetAbsRec(Inf.Image,F,SizeOf(LongInt),L);
  Case(Inf.Res.BitsPerPixel)of
   1:Begin
    {WIGetPixel:=Z and($80 shr(F and 7));}
    ASM
     MOV AL,Z
     MOV CH,Byte Ptr F
     AND CH,7
     MOV CL,7
     SUB CL,CH
     SHR AL,CL
     AND AX,1
     MOV @Result,AX
    END;
   End;
   2..4:Begin
    If F and 1=1Then WIGetPixel:=Z shr 4
                Else WIGetPixel:=Z and$F;
   End;
   5..8:WIGetPixel:=Z;
   9..16:WIGetPixel:=W;
   24:WIGetPixel:=L;
  End
 End
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Destructeur WIDone                        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette destructeur permet de d‚sallouer toutes la m‚moire utiliser par
 l'image contenu dans l'objet de param‚trage ®Inf¯.
}

Procedure WIDone;Begin
 FreeMemory(Inf.PaletteRGB,SizeOf(Inf.PaletteRGB));
 XFreeMem(Inf.Image);
 XFreeMem(Inf.Miroir);
End;

Type
 CollectiveSoulInputSize=Record
  NumXPixels,NumYPixels:Word;
  BitsPerPixel:Byte;
  NumColors:LongInt;
 End;

Function OnInputSize(Var Q;P:Word):Boolean;
Var
 Inf:CollectiveSoulInputSize Absolute Q;
Begin
 OnInputSize:=True;
 Case(P)of
  2:Inf.NumColors:=Long(1)shl Long(Inf.BitsPerPixel);
  3:Case Word(Inf.NumColors)of
   0..2:Inf.BitsPerPixel:=1;
   3..4:Inf.BitsPerPixel:=2;
   5..8:Inf.BitsPerPixel:=3;
   9..16:Inf.BitsPerPixel:=4;
   17..32:Inf.BitsPerPixel:=5;
   33..64:Inf.BitsPerPixel:=6;
   65..128:Inf.BitsPerPixel:=7;
   129..256:Inf.BitsPerPixel:=8;
   257..512:Inf.BitsPerPixel:=9;
   513..1024:Inf.BitsPerPixel:=10;
   1025..2048:Inf.BitsPerPixel:=11;
   2049..4096:Inf.BitsPerPixel:=12;
   4097..8192:Inf.BitsPerPixel:=13;
   8193..16384:Inf.BitsPerPixel:=14;
   16385..32768:Inf.BitsPerPixel:=15;
   Else Inf.BitsPerPixel:=16;
  End;
  Else OnInputSize:=False;
 End;
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                          Procedure InputSize                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette permet proc‚dure demande … l'utilisateur quel est la taille que
 l'image doit avoir.
}

Function InputSize;
Var
 D:CollectiveSoulInputSize;
 R:ResourceWindow;
Begin
 InputSize:=False;
 WERInit(R);
 R.CollectiveSoul:=@D;R.OnInput:=OnInputSize;
 D.NumXPixels:=NmXPixels;
 D.NumYPixels:=NmYPixels;
 D.BitsPerPixel:=BitsPerPixel;
 D.NumColors:=Long(1)shl Long(BitsPerPixel);
 WERLoadApp(R,17,D);
 InputSize:=WERRun(R);
 WERDone(R);
 Inf.NumXPixels:=D.NumXPixels;
 Inf.NumYPixels:=D.NumYPixels;
 Inf.BitsPerPixel:=D.BitsPerPixel;
End;

{$ENDIF}

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
END.