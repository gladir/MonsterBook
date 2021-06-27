{$I DEF.INC}
Uses {$IFDEF Adele}Adele,{$ELSE}Chantal,{$ENDIF}
     Systex,Isatex,Systems,Video,Arcade,Dials,MCatDsk;

Const
 mcNewCat=$F0F1;
 mcViewGlobal=$F0F2;
 mcExit=$F0F3;

Var K:Word;

{$I Library\System\Malte\Presenta.tio\PutTapis.Inc}

BEGIN
 PathCatDisk:='\MALTE\CATALOG';
 InitSystems(suIsabel);
 InitVideoDeluxe;
 InitEnv;
 PMInit;
 PMAddMnu('^C^atalogue');
 PMAddItem('^N^ouvelle disquette',mcNewCat,'Insäre une nouvelle disquette pour pouvoir la cataloguer');
 PMAddItem('Vue ^G^lobal',mcViewGlobal,'Permet d''obtenir une vue globale des disquettes connues');
 PMAddBarItem;
 PMAddItemKey('^Q^uitter',kbAltX,mcExit,'Permet de quitter cette application');
 PutTapis(0,MaxYTxts,$19);
 ConMacro('C'#0#$1F+ { BarSpcHor(0,0,MaxXTxts,$1F); }
	  'I'+ { PutCloseIcon(0,0,$F);}
	  'TO'#0#$1F'Catalogueur de disquette$'+
	  'C'#$FE#$B0+   { BarSpcHor(0,MaxYTxts-1,MaxXTxts,$B0); }
	  'C'#$FF#$1F+   { BarSpcHor(0,MaxYTxts,MaxXTxts,$1F); }
	  'S'#11#$FE'≥'+ { SetChr(11,MaxYTxts-1,'≥'); }
	  'S'#22#$FE'≥'+ { SetChr(22,MaxYTxts-1,'≥'); }
	  'S'#33#$FE'≥'+ { SetChr(33,MaxYTxts-1,'≥'); }
	  'S'#44#$FE'≥'+ { SetChr(44,MaxYTxts-1,'≥'); }
	  'S'#55#$FE'≥');{ SetChr(55,MaxYTxts-1,'≥'); }
 PMSetWinBar(0,1,MaxXTxts);
 PMPutMnuBar;
 Repeat
  K:=PMWaitForMnuAction;
  Case(K)of
   mcNewCat:GetDiskInfo(SelectRemoveDisk(0));
   mcViewGlobal:GlobalCatalog;
   kbAltX,mcExit:If __InputExit('Etes-vous certain de quitter ?')Then Break;
  End;
 Until No;
 FadeOut;
 DoneLuxeVideo;
 DoneSystems;
END.