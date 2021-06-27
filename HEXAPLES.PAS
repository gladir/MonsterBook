Program Hexaples;
{$I DEF.INC}
Uses {$IFDEF Adele}Adele,{$ELSE}Chantal,{$ENDIF}
     Systex,Isatex,Systems,Video,Arcade,Dials,QHexView,DialPlus;

Label Break;

Const
 mbOpen=$F0E1;
 mbClose=$F0E2;
 mbExit=$F0E3;

 Mode:Byte=0;

Var
 Windows:HexEditApp;
 Name:PathStr;
 K:Word;

{$I Library\System\Malte\Presenta.tio\PutTapis.Inc}

BEGIN
 InitSystems(suIsabel);
 SetVideoModeDeluxe(vmTxtDef);
 InitEnv;
 PMInit;
 PMAddMnu('^F^ichier');
 PMAddItemKey('^O^uvre',kbF3,mbOpen,'Ouvre un fichier en hexad‚cimal');
 PMAddItemKey('^F^erme',kbAltF3,mbClose,'Ferme un fichier');
 PMAddBarItem;
 PMAddItemKey('^Q^uitter',kbAltX,mbExit,'Quitte l''Hexaples');
 PutTapis(0,MaxYTxts,$19);
 ConMacro('C'#0#$1F+ { BarSpcHor(0,0,MaxXTxts,$1F); }
	  'I'+ { PutCloseIcon(0,0,$F);}
	  'TO'#0#$1F'Hexaples$'+
	  'C'#$FE#$B0+   { BarSpcHor(0,MaxYTxts-1,MaxXTxts,$B0); }
	  'C'#$FF#$1F+   { BarSpcHor(0,MaxYTxts,MaxXTxts,$1F); }
	  'S'#11#$FE'³'+ { SetChr(11,MaxYTxts-1,'³'); }
	  'S'#22#$FE'³'+ { SetChr(22,MaxYTxts-1,'³'); }
	  'S'#33#$FE'³'+ { SetChr(33,MaxYTxts-1,'³'); }
	  'S'#44#$FE'³'+ { SetChr(44,MaxYTxts-1,'³'); }
	  'S'#55#$FE'³');{ SetChr(55,MaxYTxts-1,'³'); }
 PMSetWinBar(0,1,MaxXTxts);
 PMPutMnuBar;
 Repeat
  Case(Mode)of
   1: K:=HVRun(Windows);
   Else K:=ReadKey;
  End;
  PushKey(K);
  K:=PMWaitForMnuAction;
  Case K of
   kbF3,mbOpen:
   If Mode=0Then
   Begin
    Name:=OpenWin('*.*','Regarde Hex');
    If Name<>''Then
    Begin
     HVInit(Windows,3,2,Name);
     Mode:=1;
    End;
   End;
   kbAltF3,mbClose: If Mode=1Then Begin;HVDone(Windows);Mode:=0;End;
   kbAltX,mbExit: If __InputExit('Etes-vous certain de quitter ?')Then Goto Break;
  End;
 Until No;
Break:
 FadeOut;
 DoneLuxeVideo;
 DoneSystems;
END.