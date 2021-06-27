{���������������������������������������������������������������������������
 �                                                                         �
 �                    Malte Genesis/Module du Terminal                     �
 �                                                                         �
 �            �dition Chantal pour Mode R�el/IV - Version 1.1              �
 �                              1995/02/02                                 �
 �                                                                         �
 �          Tous droits r�serv�s par les Chevaliers de Malte (C)           �
 �                                                                         �
 ���������������������������������������������������������������������������


 Nom du programmeur
 ������������������

  Sylvain Maltais


 Description
 �����������

  Cette unit� s'occupe de la gestion de diff�rent format de terminal dont
 le format ANSI par exemple.
}


Unit Terminal;

{���������������������������������������������������������������������������}
                                INTERFACE
{���������������������������������������������������������������������������}

{$I DEF.INC}

Uses Systex;

Procedure WEAnsiInit(Var Q:Window;X1,Y1,X2,Y2,L,H:Byte);
Procedure WEPushCursor(Var Q:Window);
Procedure WEPopCursor(Var Q:Window);
Function WEPut(Var Q:Window;S:PChr):Boolean;
Function WEPutPas(Var Q:Window;Const S:String):Boolean;
Function WEPutPasLn(Var Q:Window;Const S:String):Boolean;
Function WEAnsiLn(Var Q:Window):Boolean;
Function WEPutLn(Var Q:Window;S:PChr):Boolean;
Function WETypeFile(Var Q:Window;Path:PathStr):Boolean;
Function WERead(Var Q:Window;S:PChr):String;
Procedure WESetPause(Var Q:Window;X:Boolean);
Function GetPrompt:String;

{���������������������������������������������������������������������������}
                               IMPLEMENTATION
{���������������������������������������������������������������������������}

Uses
 Adele,Dials,Systems,Video,Dialex,Time,CommBase;

Procedure WESetAttribut(Var Q:Window;S:String);Near;Forward;

{��������������������������������������������������������������������������
 �                          Proc�dure WEAnsiInit                          �
 ��������������������������������������������������������������������������


 Description
 �����������

  Cette proc�dure permet d'initialiser l'objet de bo�te de dialogue afin de
 support� un terminal de format ANSI.  La pause apr�s le passage d'une page
 est d�sactiv�.
}

Procedure WEAnsiInit;Begin
 WEInit(Q,X1,Y1,X2,Y2);
 Q.PauseLn:=False;
End;

{�����������������������������������������������������������������������
 �                        Proc�dure WESetPause                         �
 �����������������������������������������������������������������������


 Description
 �����������

  Cette proc�dure permet de fixer une pause lors de l'affichage du texte
 dans l'�mulation de terminal de la bo�te de dialogue.
}

Procedure WESetPause;Begin
 Q.PauseLn:=X;
 Q.Lines:=0;
End;

{������������������������������������������������������������������������
 �                         Proc�dure WESetAttribut                      �
 ������������������������������������������������������������������������


 Description
 �����������

  Cette proc�dure permet d'appliquer l'attribut de format ANSI � la bo�te
 de dialogue.
}

Procedure WESetAttribut;
Const
 V:Array[0..1]of Char='^'#0;
Var
 x:Integer;
Begin
 x:=StrToWord(S);
 If Hi(x)<>0Then Exit;
 Case Lo(x)of
  0:Q.CurrColor:=7;
  1:ASM
   {$IFDEF FLAT386}
    LEA EAX,Q
    OR  [EAX].Window.CurrColor,8
   {$ELSE}
    LES DI,Q
    OR ES:[DI].Window.CurrColor,8
   {$ENDIF}
  END;
  2:ASM
   {$IFDEF FLAT386}
    LEA EAX,Q
    AND [EAX].Window.CurrColor,0F7h
   {$ELSE}
    LES DI,Q
    AND ES:[DI].Window.CurrColor,0F7h
   {$ENDIF}
  END;
  5:ASM
   {$IFDEF FLAT386}
    LEA EAX,Q
    AND [EAX].Window.CurrColor,07Fh
    ADD [EAX].Window.CurrColor,8
   {$ELSE}
    LES DI,Q
    AND ES:[DI].Window.CurrColor,07Fh
    ADD ES:[DI].Window.CurrColor,8
   {$ENDIF}
  END;
  30..37:Begin
   Q.CurrColor:=Q.CurrColor and$F8;
   Dec(x,30);
   Case(x)of
    1:Inc(Q.CurrColor,Red);
    2:Inc(Q.CurrColor,Green);
    3:Inc(Q.CurrColor,Brown);
    4:Inc(Q.CurrColor,Blue);
    5:Inc(Q.CurrColor,Magenta);
    6:Inc(Q.CurrColor,Cyan);
    7:Inc(Q.CurrColor,LightGray);
   End;
  End;
  40..47:Begin
   Q.CurrColor:=Q.CurrColor and$8F;Dec(x,40);
   Case(x)of
    1:Inc(Q.CurrColor,Red shl 4);
    2:Inc(Q.CurrColor,Green shl 4);
    3:Inc(Q.CurrColor,Brown shl 4);
    4:Inc(Q.CurrColor,Blue shl 4);
    5:Inc(Q.CurrColor,Magenta shl 4);
    6:Inc(Q.CurrColor,Cyan shl 4);
    7:Inc(Q.CurrColor,LightGray shl 4);
   End;
  End;
  49:WEPut(Q,@V);
 End;
End;

{���������������������������������������������������������������������������
 �                          Proc�dure WEPushCursor                         �
 ���������������������������������������������������������������������������


 Description
 �����������

  Cette proc�dure permet de sauvegarder la coordonn�e actuel du curseur dans
 l'objet de bo�te de dialogue de format terminal.
}

Procedure WEPushCursor;Begin
 Q.OX:=Q.X;
 Q.OY:=Q.Y;
End;

{�����������������������������������������������������������������������
 �                       Proc�dure WEPopCursor                         �
 �����������������������������������������������������������������������


 Description
 �����������

  Cette proc�dure permet de restituer la coordonn�e du curseur par celle
 pr�c�damment  sauvegarder  dans l'objet de  bo�te de dialogue de format
 terminal.
}

Procedure WEPopCursor;Begin
 Q.X:=Q.OX;
 Q.Y:=Q.OY;
End;

{������������������������������������������������������������������������
 �                             Fonction WEPut                           �
 ������������������������������������������������������������������������


 Description
 �����������

  Cette fonction permet d'envoyer une cha�ne de caract�res de format ANSI
 sur la bo�te de dialogue de format terminal.
}

Function WEPut;Const SpcChr:Array[0..1]of Char=' '#0;
Var
 I,J,I2:Word;
 S2,SN:String;
 Header:Char;
 Value,Err:Integer;

 Function XLn:Boolean;
 Const Msg:Array[0..Length('Esc pour arr�ter, ou presse une autre touche pour continuer...')]of Char=
  'Esc pour arr�ter, ou presse une autre touche pour continuer...'#0;
 Begin
  XLn:=True;
  _WELn(Q);
  If(Q.PauseLn)Then Begin
   If(Q.Lines+1>=Q.MaxY)Then Begin
    Q.Lines:=0;
    If WEPut(Q,@Msg)Then;
    If kbEsc=WEReadk(Q)Then Begin
     _WELn(Q);
     PushKey(kbEsc);
     WEPut:=True;
     Exit;
    End;
    _WELn(Q);
   End
    Else
   Inc(Q.Lines);
  End;
  XLn:=False;
 End;

Begin
 {$IFNDEF __Windows__}
  If(ComInInput)Then ACSendStr(StrPas(S));
 {$ENDIF}
 I:=0;WEPut:=False;
 While(True)do Case S^[I]of
  #0:Exit;
  #7:Begin
   Beep;
   Inc(I)
  End;
  #8:Begin
   Inc(I);
   _Left;
   SetChr(Q.X,Q.Y,' ')
  End;
  #9:Begin
   Inc(I);
   For I2:=0to 7do If WEPut(Q,@SpcChr)Then;
  End;
  #11:Begin
   Inc(I);
   For I2:=0to 7do If(XLn)Then Exit;
  End;
  #12:Begin
   Inc(I);
   WEClrScr(Q);
  End;
  #13:Begin
   Inc(I);
   If(XLn)Then Exit;
  End;
  #10:Inc(I);
  #27:Begin
   Inc(I);
   Case S^[I]of
    '[':Begin
     Inc(I);
     Case S^[I]of
      'A':_WEUp(Q);
      'B':_WEDn(Q);
      'C':_WERight(Q);
      'D':_WELeft(Q);
      'K':WEClrEol(Q);
      's':WEPushCursor(Q);
      'u':WEPopCursor(Q);
      '0'..'9':Begin
       S2:='';
       While S^[I]in ArabicDigit do Begin
        IncStr(S2,S^[I]);
        Inc(I)
       End;
       Value:=StrToWord(S2);
       Case S^[I]of
        ';':Begin
	 Header:=GetNxtChr(I,S);
	 If Header=#0Then Exit;
	 While S^[I]=';'do Begin
	  Inc(I);SN:='';
	  While S^[I]in ArabicDigit do Begin IncStr(SN,S^[I]);Inc(I)End;
	  If S^[I]='H'Then Begin
	   WESetPos(Q,StrToWord(SN)-1,StrToWord(S2)-1);
	   Break;
	  End;
	  WESetAttribut(Q,SN);
	 End;
        End;
        'm':WESetAttribut(Q,S2);
        'A':WEUp(Q,Value);
        'B':WEDn(Q,Value);
        'C':WERight(Q,Value);
        'D':WELeft(Q,Value);
        'J':If S2='2'Then WEClrScr(Q);
        Else Exit;
       End;
      End;
      Else Exit;
     End;
     Inc(I);
    End;
    Else Exit;
   End;
  End;
  Else Begin
   S2:='';
   While Not(S^[I]in[#0,#7..#13,#27])do Begin
    IncStr(S2,S^[I]);
    Inc(I);
    If(Q.X+Length(S2)>Q.MaxX)Then Break;
   End;
   WEPutTxt(Q,S2);
   If WEXIsOut(Q)Then If(XLn)Then Exit;
  End;
 End;
 Video.SetPos(Q.X,Q.Y);
End;

{������������������������������������������������������������������������
 �                            Fonction WEPutLn                          �
 ������������������������������������������������������������������������


 Description
 �����������

  Cette fonction permet d'envoyer une cha�ne de caract�res de format ANSI
 sur la  bo�te de  dialogue  de format terminal  et effectue un retour de
 ligne.
}

Function WEPutLn;
Var
 X:Boolean; { Variable temporaire de retour de processus }
Begin
 X:=WEPut(Q,S);
 If Not(X)Then X:=WEAnsiLn(Q);
 WEPutLn:=X;
End;

{�����������������������������������������������������������������������
 �                          Fonction WEAnsiLn                          �
 �����������������������������������������������������������������������


 Description
 �����������

  Cette fonction effectue une retour de ligne sur le terminal ANSI de la
 bo�te de dialogue.
}

Function WEAnsiLn;Begin
 WEAnsiLn:=WEPut(Q,@CRLF[1])
End;

{������������������������������������������������������������������������
 �                            Fonction WEPutPas                         �
 ������������������������������������������������������������������������


 Description
 �����������

  Cette fonction permet d'envoyer une cha�ne de caract�res de format ANSI
 de style Pascal sur la bo�te de dialogue de format terminal.
}

Function WEPutPas;Var PChr:PChrAByte;Begin
 StrPCopy(@PChr,S);
 WEPutPas:=WEPut(Q,@PChr)
End;

{������������������������������������������������������������������������
 �                          Fonction WEPutPasLn                         �
 ������������������������������������������������������������������������


 Description
 �����������

  Cette fonction permet d'envoyer une cha�ne de caract�res de format ANSI
 de style Pascal sur la bo�te de dialogue de format terminal  et effectue
 un retour de ligne.
}

Function WEPutPasLn;Begin
 WEPutPas(Q,S);
 WEAnsiLn(Q)
End;

{�����������������������������������������������������������������������
 �                         Fonction WETypeFile                         �
 �����������������������������������������������������������������������


 Description
 �����������

   Cette fonction permet de  typer sur le  terminal un fichier de format
  ANSI  et  ainsi  de voir  son r�sultat  � l'int�rieur  de la  bo�te de
  dialogue et non en plein �cran.


  Remarque
  ��������

   � Pour acc�der � un index d'un fichier RLL, vous devez sp�cifier � la
     fin du nom de fichier, un �:� suivie du num�ro d'index. Exemple:
     �C:\MALTE\HLP\DOS.HLP:0�.
}

Function WETypeFile;
Label Err;
Var
 Handle:Hdl;
 J:Word;
 I,Size:LongInt;
 Bank:Boolean;
 Buffer:Record
  PChr:Array[0..2047]of Char;
  _End:Char;
 End;
 Pos:Array[1..2]of LongInt;
Begin
 I:=0;
 For J:=1to Length(Path)do If Path[J]=':'Then Inc(I);
 Bank:=(I=2)or((I=1)and(Path[2]<>':'));WETypeFile:=False;Buffer._End:=#0;
 If(Bank)Then Begin
  For J:=Length(Path)downto 1do If Path[J]=':'Then Break;
  Handle:=FileOpen(Copy(Path,1,J-1),fmRead);
 End
  Else
 Handle:=FileOpen(Path,fmRead);
 If(Handle=errHdl)Then WEPutPasLn(Q,GetErrMsg(GetSysErr))
  Else
 Begin
  If(Bank)Then Begin
   J:=StrToWord(Copy(Path,J+1,255));
   _GetAbsRec(Handle,(J+1)shl 2,SizeOf(LongInt)shl 1,Pos);
   Size:=Pos[2]-Pos[1];
  End
   Else
  Begin;Size:=Systems.FileSize(Handle);Pos[1]:=0;End;
  If Size>0Then Begin
   For I:=0to(Size div SizeOf(Buffer.PChr))-1do Begin
    _GetAbsRec(Handle,Pos[1],SizeOf(Buffer.PChr),Buffer.PChr);
    If GetSysErr>0Then WEPutPasLn(Q,GetErrMsg(GetSysErr));
    If WEPut(Q,@Buffer.PChr)Then Goto Err;
    If Not(Q.PauseLn)Then If(KeyPress)Then Begin
     ClrKbd;
     WEAnsiLn(Q);
     WEPutTxtXY(Q,0,Q.Y,'Dois-je annuler l''op�ration (O/N) ?');
     If Char(ReadKey)in['o','O']Then Goto Err;
    End;
    Inc(Pos[1],SizeOf(Buffer.PChr));
   End;
   If Size mod SizeOf(Buffer.PChr)>0Then Begin
    FillClr(Buffer,SizeOf(Buffer));
    _GetAbsRec(Handle,Pos[1],Size mod SizeOf(Buffer.PChr),Buffer.PChr);
    WEPut(Q,@Buffer.PChr);
   End;
  End;
  WETypeFile:=True;
Err:FileClose(Handle);
 End;
End;

{���������������������������������������������������������������������
 �                           Fonction WERead                         �
 ���������������������������������������������������������������������


 Description
 �����������

  Cette fonction interroge le terminal ANSI de la bo�te de dialogue et
 retour des correspondants � sa demande.
}

Function WERead;Begin
End;

{���������������������������������������������������������������������������
 �                           Fonction GetPrompt                            �
 ���������������������������������������������������������������������������


 Description
 �����������

  Cette fonction retourne une cha�ne de caract�res interpr�teur en sa valeur
 r�el correspondant  au prompt  du syst�me d'exploitation  contenant dans la
 variable d'environnement.
}

Function GetPrompt;
Var
 SP,T:String;
 I:Byte;

 Function SymbolToStr(Chr:Char):String;
 Const Week:Array[0..6]of String[3]=('Dim','Lun','Mar','Mer','Jeu','Ven','Sam');
       Mon:Array[1..12]of String[3]=('Jan','F�v','Mar','Avr','Mai','Jui',
				     'Jul','Ao�','Sep','Oct','Nov','D�c');
 Var T:String;Year{$IFDEF DosUnit},{$ELSE}:Word;{$ENDIF}
     Month,Day,DayOfWeek,Hour,Min,Sec,Sec100:{$IFDEF DosUnit}Wd{$ELSE}Byte{$ENDIF};Begin
  Case Chr of
       'D': Begin
	     GetDate(Year,Month,Day,DayOfWeek);
	     T:=Week[DayOfWeek]+'  '+Mon[Month]+BasicStr(Day)+','+BasicStr(Year);
	    End;
       'T': Begin
	     GetTime(Hour,Min,Sec,Sec100);
	     T:=CStrTimeDos(Hour,Min,Sec);
	    End;
       'B' : T:='|';
   'e','E' : T:=#27;
   'g','G' : T:='>';
       'N' : T:=GetDrv;
   'p','P' : T:=GetCurrentDir;
   '-','S' : T:=' ';
       'V' : T:=IntToStr(Lo(GetDosVer))+'.'+IntToStr(Hi(GetDosVer));
   '_','Z' : T:=CRLF;
       'z' : T:='?';
	Else T:='';
  End;
  SymbolToStr:=T;
 End;

Begin
 SP:=GetEnv('PROMPT');T:='';
 {$IFNDEF FLAT386}
  For I:=1to Length(SP)do If SP[I]='$'Then Begin
   Inc(I);
   AddStr(T,SymbolToStr(SP[I]))
  End
   else
  IncStr(T,SP[I]);
 {$ENDIF}
 GetPrompt:=T;
End;

{���������������������������������������������������������������������������}
END.