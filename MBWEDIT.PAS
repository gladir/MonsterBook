unit Mbwedit;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls,Systex,Systems, Menus,Isatex;

type
  TEditorWin = class(TForm)
    TimerCurseur: TTimer;
    procedure Nouveautexte1Click(Sender: TObject);
    Procedure Fermer(Sender: TObject; var Action: TCloseAction);
    procedure FermerVraiment(Sender: TObject; var CanClose: Boolean);
    procedure Ferme1Click(Sender: TObject);
    procedure Curseur(Sender: TObject);
    procedure RunControl(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure InsertDonnee(Sender: TObject; var Key: Char);
  private
    H,W:Word;
    { DÈclarations private }
    Procedure SetCube(X,Y:Byte;Chr:Char;Attr:Byte);
    Procedure _SetCube(X,Y:Byte;Chr:Char);
    Procedure PutLn(Size,I1:Int;P:Wd;PC:PChr);
    Procedure PutPTxtXY2(X,Y:Byte;S:Wd;Msg:PChr);
    Procedure BarSelHor(X1,Y,X2:Byte);
    Procedure _Attr(Attr:Byte);
    Procedure ClrEol;
    Procedure Ln;
    Procedure UpdateLn;
  public
    { DÈclarations public }
    Q:EditorApp;
    Procedure NewText;
    Procedure kRight;
    Function Run:Word;
  end;

implementation

Uses Adele,Mbwunit,Video,Editex,Editor;

{$R *.DFM}

Function InHomeLst(Var Buffer;Size:Wd;Item:String):Bool;Var Buf:TByte Absolute Buffer;J:Wd;L:Byte;Begin
 J:=0; InHomeLst:=Ya;
 While(J<Size)do Begin
  L:=Buf[J];
  {If(Length(Item)>=L)Then If Compare(Buf[J+1],Item[1],L)Then Begin XCmp:=L;Exit;End;}
  Inc(J,L+1)
 End;
 InHomeLst:=No
End;

{$I \Source\Chantal\Library\Compiler\C\PXtrkCNm.Inc}

Procedure TEditorWin.NewText;Begin
 FillClr(Q,SizeOf(Q));
 RBAddLn(Q.List);
 RBSetPtr(EditorApp(Q).List,0);
 EditorApp(Q).CurrPtr:=RBPushCurrPtr(EditorApp(Q).List);
 Canvas.Font.Pitch:=fpFixed;
 Canvas.Font.Color:=$777777;
 H:=Canvas.Font.Size;W:=H;Inc(H,4);
End;

Function TEditorWin.Run:Word;Begin
End;

Procedure TEditorWin.Fermer(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TEditorWin.FermerVraiment(Sender: TObject; var CanClose: Boolean);
{var
  DialogValue: Integer;
  FName: string;}
begin
{  if(Modified)then
  begin
    FName := Caption;
    DialogValue := MessageDlg(Format(SWarningText, [FName]), mtConfirmation,
      [mbYes, mbNo, mbCancel], 0);
    case DialogValue of
      id_Yes: Save1Click(Self);
      id_Cancel: CanClose := False;
    end;
  end;}
end;

procedure TEditorWin.Nouveautexte1Click(Sender: TObject);
begin
   MainForm.Nouveautexte1Click(Sender);
end;

procedure TEditorWin.Ferme1Click(Sender: TObject);
begin
   Close;
end;

Procedure TEditorWin._Attr(Attr:Byte);Begin
 Canvas.Brush.Color:=WinProcs.RGB(DefaultRGB[Attr shr 4].R,
                                  DefaultRGB[Attr shr 4].G,
                                  DefaultRGB[Attr shr 4].B);
 Canvas.Font.Color:=WinProcs.RGB(DefaultRGB[Attr and$F].R,
                                 DefaultRGB[Attr and$F].G,
                                 DefaultRGB[Attr and$F].B);
End;

Procedure TEditorWin.SetCube(X,Y:Byte;Chr:Char;Attr:Byte);Begin
 _Attr(Attr);
 Canvas.TextOut(X*W,Y*H,Chr);
End;

Procedure TEditorWin._SetCube(X,Y:Byte;Chr:Char);Begin
 Canvas.TextOut(X*W,Y*H,Chr);
End;

Procedure TEditorWin.BarSelHor(X1,Y,X2:Byte);Begin
End;

Procedure TEditorWin.ClrEol;Begin
End;

Procedure TEditorWin.Ln;Begin
 Inc(Q.W.Y);
End;

Procedure TEditorWin.PutPTxtXY2(X,Y:Byte;S:Wd;Msg:PChr);Var I,L:Word;Begin
 L:=StrLen(Msg);
 If(L>S)Then Begin
  For I:=S to L-1do Begin
   Canvas.TextOut(X*W,Y*H,Msg^[I]);
   Inc(X);
  End;
 End;
End;

Procedure TEditorWin.PutLn(Size,I1:Integer;P:Wd;PC:PChr);
Label FR,PS;
Var
 Str,UStr:String;I,I3,J,K:Word;Ok:Boolean;
 PDrw:^DrawInEdt;Handle:Hdl;
 TGX1,GX1,GY1,Len,SizeBuf:Wd;TBuf,Buf:^TByte;

 Procedure PutChar(Chr:Char);Begin
  If(I>=I1)Then Begin
   If(Q.ScrollLock)Then Begin
    If((I<Q.SheetFormat.X1)or(I>Q.SheetFormat.X2))and(ViewOutZone)Then
     SetCube(I-I1,Q.W.Y,Chr,$90)
    Else
     _SetCube(I-I1,Q.W.Y,Chr);
   End
    else
   _SetCube(I-I1,Q.W.Y,Chr);
  End;
 End;

 Procedure PutText(Const Str:String);Var I2,I3:Wd;Begin
  If(I<I1)Then Exit;
  I2:=I-Word(Length(Str));
  For I3:=I2 to I-1do Begin
   If(Q.ScrollLock)and(ViewOutZone)and((I3<Q.SheetFormat.X1)or(I3>Q.SheetFormat.X2))Then
    SetCube(I3-I1,Q.W.Y,PC^[I3],$90)
   Else
    _SetCube(I3-I1,Q.W.Y,PC^[I3]);
  End;
 End;

 Procedure __Put;Begin;PutChar(PC^[I]);Inc(I)End;
 Procedure SetKrDef;Begin;Q.W.CurrColor:=$1D;End;
 Procedure SetKrRem;Begin;Q.W.CurrColor:=$1E;End;
 Procedure SetKrResWd;Begin;Q.W.CurrColor:=$1F;End;

 Procedure PutCString;Label Break;Begin
  J:=I;Q.W.CurrColor:=$1C;
  __Put;
  While PC^[I]<>'"'do Begin
   If PC^[I]='\'Then Begin PutChar('\');Inc(I)End;
   If PC^[I]=#0Then Goto Break;
   __Put;
  End;
Break:
  If PC^[I]<>#0Then __Put;
  SetKrDef;
 End;

 Procedure PutAsmCString;Label Break;Begin
  J:=I;Q.W.CurrColor:=$1C;
  __Put;
  While PC^[I]<>'"'do Begin
   If PC^[I]=#0Then Goto Break;
   __Put;
  End;
Break:
  If PC^[I]<>#0Then __Put;
  SetKrDef;
 End;

 Procedure PutBasicString;Label Break;Begin
  J:=I;Q.W.CurrColor:=$1C;
  __Put;
  While PC^[I]<>'"'do Begin
   If PC^[I]=#0Then Goto Break;
   If PC^[I]<' 'Then Begin
    Q.W.CurrColor:=($1C shr 4)+(($1C shl 4)and$F0);
    PutChar(Char(Byte(PC^[I])+64));
    Inc(I);Q.W.CurrColor:=$1C;
   End
    Else
   __Put;
  End;
Break:
  If PC^[I]<>#0Then __Put;
  SetKrDef;
 End;

 Procedure PutPascalString;Label Break;Begin
  J:=I;Q.W.CurrColor:=$1C;
  __Put;
  While PC^[I]<>''''do Begin
   If PC^[I]=''''Then Begin PutChar('''');Inc(I)End;
   If PC^[I]=#0Then Goto Break;
   __Put;
  End;
Break:
  If PC^[I]<>#0Then __Put;
  SetKrDef;
 End;

 Procedure PutCChar;Begin
  J:=I;Q.W.CurrColor:=$1C;
  __Put;
  While PC^[I]<>''''do Begin
   If PC^[I]=#0Then Break;
   If(PC^[I]='\')and(PC^[I+1]='''')Then Begin;__Put;__Put;End
   Else __Put;
  End;
  If PC^[I]<>#0Then __Put;
  SetKrDef;
 End;

 Procedure PutSymbol;Begin
  Q.W.CurrColor:=$1D;
  __Put;
  SetKrDef;
 End;

 Procedure PutZ;Begin
  Q.W.CurrColor:=$D1;
  PutChar('E');
  Inc(I);
  SetKrDef;
 End;

 Procedure ResWd;Begin
  Str:=PXtrkWord(I,PC);
  {If InLst(Q.ResWord^,Q.ResWordSize,StrUp(Str))Then SetKrResWd Else} SetKrDef;
  PutText(Str);
  SetKrDef;
 End;

Begin
 If(PC<>NIL)Then If(Size>I1)Then Case(Q.Mode)of
  vtGat:Begin
   If(PC<>NIL)Then If(Size>I1)Then Begin
    If(Q.Mode=vtHlp)Then _Attr($17)
    Else Q.W.CurrColor:=$17;
    If(Q.Processus.NB>0)Then Begin
     RBSetPtr(Q.Processus,0);
     For I:=0to Q.Processus.NB-1do Begin
      PDrw:=_RBGetCurrBuf(Q.Processus);
      If(PDrw<>NIL)Then Begin
       If(PDrw^.Y1<=P)and(PDrw^.Y2>=P)Then Begin
        Len:=(PDrw^.GPX.Len shr 3);SizeBuf:=Len shl 3;Buf:=MemAlloc(SizeBuf+2);
        If(Buf<>NIL)Then Begin
         Handle:=FileOpen(PDrw^.Path,fmRead);
         If(Handle<>errHdl)Then Begin
          ClrEol;
          GX1:=(((((Q.SheetFormat.X2-Q.SheetFormat.X1)shr 1)+Q.SheetFormat.X1))shl 3)-(PDrw^.GPX.Len shr 1);
          TGX1:=GX1;GY1:=Q.W.Y*Canvas.Font.Size;
          _GetAbsRec(Handle,PDrw^.Ofs+((P-PDrw^.Y1)shl 3)*Len,SizeBuf,Buf^[2]);
          TBuf:=Buf;
          For I3:=0to 7do Begin
           TBuf^[0]:=7;TBuf^[1]:=1;
           ClrLnHorImg(GX1,GY1,SizeBuf,0,TBuf^);
           ClrLnHorImg(GX1,GY1+1,SizeBuf,0,TBuf^);
           Inc(PtrRec(TBuf).Ofs,Len);
           GX1:=TGX1;Inc(GY1,2)
          End;
          FileClose(Handle);
         End;
         FreeMem(Buf,SizeBuf+2);
        End;
        Ln;
        Exit;
       End;
      End;
      RBNext(Q.Processus);
     End;
    End;
    I:=0;K:=0;
    While PC^[K]<>#0do Begin
     Case PC^[K]of
      #1..#31:Begin{ Attr ? }
       Inc(K);
       If PC^[K]<>#0Then Begin
        PutCharGAttr(Q.X,Q.Y,PC^[K],Byte(PC^[K-1]),$17);
        If(Byte(PC^[K-1])and cgDouble=cgDouble)Then Inc(I);
        Inc(K);Inc(I);
       End;
      End;
      #255:Begin
       Inc(K);
       SetExtCube(Q.W.T.X1+Byte(Q.W.NotFullScrnX)+Q.W.X,
                  Q.W.T.Y1+Byte(Q.W.NotFullScrnY)+Q.W.Y,Byte(PC^[K])or$100,Q.W.CurrColor);
       Inc(K);Inc(I);Inc(Q.W.X);
      End;
      Else Begin
       If(I>=I1)Then Begin
        If(Q.ScrollLock)Then Begin
         If(ViewOutZone)and((I<Q.SheetFormat.X1)or(I>Q.SheetFormat.X2))Then
          SetCube(I-I1,Q.W.Y,PC^[K],$90)
         Else
          _SetCube(I-I1,Q.W.Y,PC^[K]);
        End
         else
        _SetCube(I-I1,Q.W.Y,PC^[K]);
       End;
       Inc(I);Inc(K);
      End;
     End;
    End;
    If(MarkEnd)Then Begin
     If((K>0)and(PC^[K-1]=' '))or(I>=Q.SheetFormat.X2)Then Begin
      If(Q.W.MaxX>Q.W.X)Then Begin
       UnSelIcon(Q.W.X,Q.W.Y,(Q.W.CurrColor and $F0)+3);
       If(IsLuxe)Then Inc(Q.W.X,2)Else Inc(Q.W.X,3);
      End;
     End;
    End;
   End;
   ClrEol;
   If(Q.BY1<=P)and(Q.BY2>=P)Then Begin
    Q.W.CurrColor:=$6E;
    If(Q.BY1=Q.BY2)Then Begin
     If(Q.BX1<Q.BX2)Then Begin
      If I1>0Then BarSelHor(0,Q.W.Y,Q.BX2-I1-1)
             Else BarSelHor(Q.BX1,Q.W.Y,Q.BX2-I1-1);
     End;
    End
     Else
    Begin
     If(P=Q.BY1)Then BarSelHor(Q.BX1-I1,Q.W.Y,wnMax)Else
     If(P=Q.BY2)Then BarSelHor(0,Q.W.Y,Q.BX2-I1-1)
     Else BarSelHor(0,Q.W.Y,wnMax);
    End;
    Q.W.CurrColor:=$17;
   End;
  End;
  vtAsm:Begin
   I:=0;
   While PC^[I]<>#0do Begin
    Case PC^[I]of
     ';':Begin
      SetKrRem;
      While PC^[I]<>#0do __Put;
      SetKrDef;
     End;
     '@',':',',','.','(',')','[',']','=','$','+','-','#','!','?','&','*','%','/':PutSymbol;
     '"':PutAsmCString;
     '0'..'9':Begin
      Q.W.CurrColor:=$19;
      __Put;
      While(PC^[I]in ArabicXDigit)do __Put;
      If PC^[I]in['B','b','O','o','H','h']Then __Put;
      SetKrDef;
     End;
     '''':PutCChar;
     'A'..'Z','a'..'z','_':Begin
      Str:=PXtrkWord(I,PC);UStr:=StrUp(Str);
      {If InLst(Q.Instr^,Q.InstrSize,UStr)Then Q.W.CurrColor:=$1A Else
      If InLst(Q.Func^,Q.FuncSize,UStr)Then Q.W.CurrColor:=$12 Else
      If InLst(Q.ResWord^,Q.ResWordSize,UStr)Then SetKrResWd Else} SetKrDef;
      PutText(Str);
      SetKrDef;
     End;
     {ResWd;}
     ^Z:PutZ;
     Else
     __Put;
    End;
   End;
  End;
  vtBas:Begin
   I:=0;
   While PC^[I]<>#0do Begin
    Case PC^[I]of
     '.','0'..'9':Begin
     Q.W.CurrColor:=$19;
      __Put;
      While(PC^[I]in ArabicDigit)do __Put;
      SetKrDef;
     End;
     '&':Begin
      Q.W.CurrColor:=$19;
      __Put;
      Case PC^[I]of
       'H':Begin
        __Put;
	While(PC^[I]in ArabicXDigit)do __Put;
       End;
       'O':Begin
        __Put;
	While(PC^[I]in OctArabicDigit)do __Put;
       End;
       'B':Begin
        __Put;
	While(PC^[I]in BinArabicDigit)do __Put;
       End;
      End;
      SetKrDef;
     End;
     '''':Begin
      SetKrRem;
      While PC^[I]<>#0do __Put;
      SetKrDef;
     End;
     'A'..'Z','a'..'z':Begin
      J:=I;Str:='';{XCmp:=0;}
      While IsRomanLetter(PC^[I])do Begin
       IncStr(Str,PC^[I]);Inc(I);
       If PC^[I]='$'Then Begin IncStr(Str,PC^[I]);Inc(I);Break;End;
      End;
      UStr:=StrUp(Str); Ok:=No;
      If CmpLeft(UStr,'REM')Then Begin
       I:=J;
       SetKrRem;
       While PC^[I]<>#0do __Put;
      End
       Else
      Begin
       If CmpLeft(UStr,'ATTR')Then Begin SetKrDef;I:=J+4;Systems._Left(Str,4)End
	Else
       Begin
	Ok:={InHomeLst(Q.ResWord^,Q.ResWordSize,UStr)}False;
	If(Ok)Then Begin SetKrResWd;I:=J{+XCmp};{Systems._Left(Str,XCmp)}End
	 Else
	Begin
	 Ok:={InHomeLst(Q.Instr^,Q.InstrSize,UStr)}False;
	 {If XCmp=0Then }Ok:=No;
	 {If(Ok)Then Begin SetKrDef;I:=J+XCmp;Systems._Left(Str,XCmp)End Else}
	 If {InHomeLst(Q.Func^,Q.FuncSize,UStr)}False Then
	 {Begin Q.W.CurrColor:=$17;I:=J+XCmp;Systems._Left(Str,XCmp)End
	 Else Q.W.CurrColor:=$1A;}
	End;
       End;
       PutText(Str);
      End;
      SetKrDef;
      Continue;
     End;
     '%','$':Begin
      Q.W.CurrColor:=$1A;
      __Put;
      SetKrDef;
     End;
     '[',']','(',')',',',';','^','-','+','=',':','*','/','<','>','\' :PutSymbol;
     '"' :PutBasicString;
     ^Z :PutZ;
     Else __Put;
    End;
   End;
  End;
  vtIni:Begin
   I:=0;
   While PC^[I]<>#0do Begin
    Case PC^[I]of
     '=':Begin
      PutSymbol;
      SetKrResWd;
      While PC^[I]<>#0do Case PC^[I]of
       '{','}','(',')',',',';','^','-','+',':','*','/','<','>','\':Begin
	PutSymbol;SetKrResWd;
       End;
       '"': PutBasicString;
       '.','0'..'9':Begin
	Q.W.CurrColor:=$19;
	__Put;
	While(PC^[I]in ArabicDigit)do __Put;
	SetKrResWd;
       End;
       Else __Put;
      End;
      SetKrDef;
     End;
   ';':Begin
      SetKrRem;
      While PC^[I]<>#0do __Put;
      SetKrDef;
     End;
   '[':Begin
      Q.W.CurrColor:=$1A;
      While PC^[I]<>#0do __Put;
      SetKrDef;
     End;
   '"': PutBasicString;
   'A'..'Z','a'..'z','_':Begin Str:=PXtrkWord(I,PC);SetKrDef;PutText(Str)End;
    ^Z: PutZ;
   Else __Put;
    End;
   End;
  End;
  vtRC,vtC,vtMacro:Begin
   I:=0;
   While PC^[I]<>#0do Begin
    Case PC^[I]of
     '/':Begin
      SetKrRem;
      Case PC^[I+1]of
       '/':While PC^[I]<>#0do __Put;
       '*':Begin
        __Put;__Put;
	While PC^[I]<>#0do Begin
	 If(PC^[I]='*')and(PC^[I+1]='/')Then Begin
	  __Put;__Put;
	  Break;
	 End;
	 __Put;
        End;
       End;
       Else Begin
        Q.W.CurrColor:=$1B;
	__Put;
       End;
      End;
      SetKrDef;
     End;
     'A'..'Z','a'..'z','_':Begin
      Str:=PXtrkWord(I,PC);
      Repeat
       If(Q.Mode=vtC)and(Str='asm')Then Begin
	SetKrResWd;
	PutText(Str);
	Q.W.CurrColor:=$1A;
	While PC^[I]<>#0do __Put;
	Break;
       End;
        {Ne pas mettre de chaåne  de caractäres  en majuscule car le
         table de comparaison est en minuscule comme l'est le C/C++.}
       If {InLst(Q.ResWord^,Q.ResWordSize,Str)}False Then SetKrResWd Else SetKrDef;
       PutText(Str);
      Until Ya;
      SetKrDef;
     End;
     '0'..'9':Begin
      Q.W.CurrColor:=$19;
      PutText(PXtrkCNm(I,PC));
      SetKrDef;
     End;
     '{','}':Begin SetKrResWd;__Put;SetKrDef;End;
     '[',']','(',')',',','.',';','|','^','$','?','-','+','=',
     ':','*','%','!','~','&','<','>','\':PutSymbol;
     '#':Begin
      SetKrRem;
      J:=I;
      While Not(PC^[I]in[#0..' '])do __Put;
      SetKrDef;
     End;
     '"':PutCString;
     '''':PutCChar;
     ^Z:PutZ;
     Else __Put;
    End;
   End;
  End;
  vtEuphoria:Begin
   I:=0;
   While PC^[I]<>#0do Begin
    Case PC^[I]of
     '-':Begin
      If PC^[I+1]='-'Then Begin
       SetKrRem;
       While PC^[I]<>#0do __Put;
      End
       Else
      Begin;Q.W.CurrColor:=$1B;__Put;End;
      SetKrDef;
     End;
     '"':PutCString;
     '''':PutCChar;
     '@',':',',','.','(',')','[',']','<','>','=','+','#','!','&','*','%','/','{','}':
     PutSymbol;
     '0'..'9':Begin
      Q.W.CurrColor:=$19;
      __Put;
      While(PC^[I]in ArabicXDigit)do __Put;
      SetKrDef;
     End;
     'A'..'Z','a'..'z','_':Begin
      Str:=PXtrkWord(I,PC);UStr:=StrUp(Str);
      If UStr='INCLUDE'Then Begin
       SetKrResWd;
       PutText(Str);
       Q.W.CurrColor:=$1C;
       While PC^[I]<>#0do __Put;
      End
       Else
      Begin
       If {InLst(Q.ResWord^,Q.ResWordSize,StrUp(Str))}False Then SetKrResWd Else SetKrDef;
       PutText(Str);
      End;
      SetKrDef;
     End;
     ^Z: PutZ;
     Else __Put;
    End;
   End;
  End;
  vtFortran:Begin
   I:=0;
   While PC^[I]<>#0do Begin
    Case PC^[I]of
     'C':If I=0Then Goto FR Else ResWd;
     '*':Begin
      If I=0Then Begin
    FR:SetKrRem;
       While PC^[I]<>#0do __Put;
       SetKrDef;
      End
       Else
      PutSymbol;
     End;
     '''':PutPascalString;
     '[',']','\','/','-','<','>','+','^','&','(',')','.',',','?','=','%','@',':',';':
     PutSymbol;
     '0'..'9':Begin
      Q.W.CurrColor:=$19;
      __Put;
      SetKrDef;
     End;
     'A','B','D'..'Z','a'..'z','_':ResWd;
     ^Z:PutZ;
     Else __Put;
    End;
   End;
  End;
  vtPas:Begin
   I:=0;
   While PC^[I]<>#0do Begin
    Case PC^[I]of
     '{':Begin
      SetKrRem;
      While Not(PC^[I]in[#0,'}'])do __Put;
      If PC^[I]='}'Then __Put;
      SetKrDef;
     End;
     '(':Begin
      If PC^[I+1]='*'Then Begin
       SetKrRem;
       Inc(I,2);
       PutText('(*');
       While PC^[I]<>#0do Begin
	If(PC^[I]='*')and(PC^[I+1]=')')Then Begin
	 Inc(I,2);
	 PutText('*)');
	 Break;
	End;
	__Put;
       End;
      End
       Else
      PutSymbol;
     End;
     '[',']','\','/','-','<','>','*','+','^','&',')','.',',','?','=','%','@',':',';':
     PutSymbol;
     '#':Begin
      Q.W.CurrColor:=$1C;
      __Put;
      Case PC^[I]of
       '$': Goto PS;
       Else While(PC^[I]in ArabicDigit)do __Put;
      End;
      SetKrDef;
     End;
     '$':Begin
      Q.W.CurrColor:=$19;
   PS:__Put;
      While(PC^[I]in ArabicXDigit)do __Put;
      SetKrDef;
     End;
     '0'..'9':Begin
      Q.W.CurrColor:=$19;
      __Put;
      SetKrDef;
     End;
     '''':PutPascalString;
     'A'..'Z','a'..'z','_':ResWd;
     ^Z:PutZ;
     Else __Put;
    End;
   End;
  End;
  vtBatch:Begin
   I:=0;
   While PC^[I]<>#0do Begin
    Case PC^[I]of
     '[',']','\','/','-','<','>','*','+','^','&','(',')','.',',','?','=','%','@',':',';':
     PutSymbol;
     '0'..'9':Begin
      Q.W.CurrColor:=$19;
      __Put;
      SetKrDef;
     End;
     'A'..'Z','a'..'z','_':Begin
      J:=I;Str:=PXtrkWord(I,PC);UStr:=StrUp(Str);
      If UStr='ECHO'Then Begin
       SetKrResWd;
       PutText(Str);
       Q.W.CurrColor:=$1C;
       While PC^[I]<>#0do __Put;
      End
       Else
      If UStr='REM'Then Begin
       I:=J;
       SetKrRem;
       While PC^[I]<>#0do __Put;
      End
       Else
      Begin
       If {InLst(Q.ResWord^,Q.ResWordSize,UStr)}False Then SetKrResWd Else SetKrDef;
       PutText(Str);
      End;
      SetKrDef;
     End;
     ^Z:PutZ;
     Else __Put;
    End;
   End;
  End;
  Else Begin
   Q.W.CurrColor:=$17;
   If(Q.ScrollLock)Then Begin
    I:=0; {Str:='';}
    While PC^[I]<>#0do __Put;
    {Begin
     If Length(Str)<250Then IncStr(Str,PC^[I])
      Else
     Begin
      PutText(Str);
      Str:='';
     End;
     Inc(I);
    End;
    If I>0Then PutText(Str);}
   End
    Else
   PutPTxtXY2(0,Q.W.Y,I1,PC);
  End;
 End;
 If(MarkEnd)Then Begin
  If(Q.W.MaxX>Q.W.X)Then Begin
   {$IFDEF Adele}
    UnSelIcon(Q.X,Q.Y,(Q.W.Kr and $F0)+3);
    If(IsLuxe)Then Inc(Q.W.X,2)Else Inc(Q.W.X,3);
   {$ELSE}
{    Str:=UnSelIcon;
    If(Q.W.X+Length(Str)>Q.W.MaxX)Then Str[0]:=Chr(Q.W.MaxX-Q.W.X);
    PutTxtLuxe(WEGetRealX(Q.W),WEGetRealY(Q.W),Str,(Q.W.Kr and $F0)+3);
    Inc(Q.W.X,Length(UnSelIcon));}
   {$ENDIF}
  End;
 End;
 ClrEol;
 If(Q.BY1<=P)and(Q.BY2>=P)Then Begin
  Q.W.CurrColor:=$6E;
  If(Q.BY1=Q.BY2)Then Begin
   If(Q.BX1<Q.BX2)Then Begin
    If I1>0Then BarSelHor(0,Q.W.Y,Q.BX2-I1-1)
           Else BarSelHor(Q.BX1,Q.W.Y,Q.BX2-I1-1);
   End;
  End
   Else
  Begin
   If(P=Q.BY1)Then BarSelHor(Q.BX1-I1,Q.W.Y,wnMax)Else
   If(P=Q.BY2)Then BarSelHor(0,Q.W.Y,Q.BX2-I1-1)
   Else BarSelHor(0,Q.W.Y,wnMax);
  End;
  Q.W.CurrColor:=$17;
 End;
 Ln;
End;

procedure TEditorWin.Curseur(Sender: TObject);
Const CaseKr:Byte=0;Begin
 Case(CaseKr)of
  0:Canvas.Brush.Color:=$FF0000; { Bleu }
  1:Canvas.Brush.Color:=$24FFFF; { Jaune }
  2:Canvas.Brush.Color:=$0000FF; { Rouge }
 End;
 Canvas.TextOut(Q.X*W,Q.Y*H,' ');
 Canvas.Brush.Color:=$500000;
 Inc(CaseKr);
 If CaseKr=3Then CaseKr:=0;
End;

Procedure TEditorWin.kRight;Begin
 Inc(Q.PX);
 If(Q.X+2)*H<ClientWidth Then Begin
  Inc(Q.X);
  Canvas.Brush.Color:=$500000;
  Canvas.TextOut((Q.X-1)*W,Q.Y*H,TEGetLastChr(Q));
 End;
End;

procedure TEditorWin.RunControl(Sender: TObject; var Key: Word;
  Shift: TShiftState);
Begin
 If(Shift=[])Then Case(Key)of
  VK_DOWN:Begin
   Inc(Q.P);
   If(Q.Y+2)*H<ClientHeight Then Begin
    Inc(Q.Y);
    Canvas.Brush.Color:=$500000;
    Canvas.TextOut(Q.X*W,(Q.Y-1)*H,TEGetUpChr(Q));
   End;
  End;
  VK_UP:If Q.P>0Then Begin
   Dec(Q.P);
   If Q.Y>0Then Begin
    Dec(Q.Y);
    Canvas.Brush.Color:=$500000;
    Canvas.TextOut(Q.X*W,(Q.Y+1)*H,TEGetDnChr(Q));
   End;
  End;
  VK_RIGHT:kRight;
  VK_LEFT:If Q.PX>0Then Begin
   Dec(Q.PX);
   If Q.X>0Then Begin
    Dec(Q.X);
    Canvas.Brush.Color:=$500000;
    Canvas.TextOut((Q.X+1)*W,Q.Y*H,TEGetNextChr(Q));
   End;
  End;
 End;
End;

Procedure TEditorWin.UpDateLn;Var PC:PChr;Size:Wd;Begin
 RBPopCurrPtr(Q.List,Q.CurrPtr);
 PC:=RBGetCurrBuf(Q.List,Size);Q.W.X:=0;
 PutLn(Size,Q.PX-Q.X,Q.P,PC);
End;

procedure TEditorWin.InsertDonnee(Sender: TObject; var Key: Char);
begin
 TESetThisChr(Q,Key);
 kRight;
 Q.W.Y:=Q.Y;
 UpdateLn;
end;

END.
