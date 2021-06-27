Unit inssdir;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                                  INTERFACE
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Uses Systex,Isatex;

Var
    PathMalte:PChr;

Function SetupDir:Bool;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
                               IMPLEMENTATION
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Uses Video,Systems,Dials,DialPlus,Terminal,Mouse,MalBKRes, Editor, Protocol,Dialex;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                            Fonction SetupDir                             Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de s‚lectionner de fa‡on organis‚ un/des chemin(s) de
 r‚pertoires … travers un tableaux utilisateur.


 Retour
 ÍÍÍÍÍÍ

  True     Des modifications ont ‚t‚ apport‚es par l'utilisateur
  False    Aucune modification n'a ‚t‚ apport‚e par l'utilisateur
}

Function SetupDir;
Var P,PP:Byte;W:Window;L:LstMnu;K:Word;
    PathBuf:Array[Byte]of Char;PPathBuf:PChr;
    TPathMalte:PChr;
    TPathSystems:PChr;
    TPathGat:PChr;
    TPathMac:PChr;
    TPathCalc:PChr;
    TPathCatDisk:PChr;
    TPathDraw:PChr;
    TPathPCX:PChr;
    TPathMacDrw:PChr;
    TPathMod:PChr;
    TPathPhoneList:PChr;
    TPathUpLoad:PChr;
    TPathDownLoad:PChr;
    TPathBBS:PChr;
    TPathAda:PChr;
    TPathAsm:PChr;
    TPathBas:PChr;
    TPathC:PChr;
    TPathCobol:PChr;
    TPathEuphoria:PChr;
    TPathForth:PChr;
    TPathFortran:PChr;
    TPathPas:PChr;
    TPathObject:PChr;
    TPathResource:PChr;
    TPathOutput:PChr;
    TPathUnit:PChr;
    TPathOS2:PChr;
    TPathUnix:PChr;
    TPathWin:PChr;
    TPathCountry:PChr;

 Procedure UpDateDir;Begin
  Case LMGetVal(L)of
   1:Begin
    WESetKrBorder(W);
    WEPutTxtXY(W,0,7,'Principal');
    WEClrEol(W);
    WESetKr(W,$8F);
    WEBarSpcHorShade(W,0,8,wnMax-1);
    WEPutPTxtXY(W,0,8,TPathMalte);
    WESetKrBorder(W);
    WEPutTxtXY(W,0,10,'SystŠme (RLL)');
    WEClrEol(W);
    WESetKr(W,$8F);
    WEBarSpcHorShade(W,0,11,wnMax-1);
    WEPutPTxtXY(W,0,11,TPathSystems);
    WEClrWnBorder(W,0,13,wnMax,wnMax-2);
   End;
   2:Begin
    WESetKrBorder(W);
    WEPutTxtXY(W,0,7,'Genesis Ascii TypeWriter (GAT)');
    WEClrEol(W);
    WESetKr(W,$8F);
    WEBarSpcHorShade(W,0,8,wnMax-1);
    WEPutPTxtXY(W,0,8,TPathGat);
    WESetKrBorder(W);
    WEPutTxtXY(W,0,10,'Macro');
    WEClrEol(W);
    WESetKr(W,$8F);
    WEBarSpcHorShade(W,0,11,wnMax-1);
    WEPutPTxtXY(W,0,11,TPathMac);
    WEClrWnBorder(W,0,13,wnMax,wnMax-2);
   End;
   3:Begin
    WESetKrBorder(W);
    WEPutTxtXY(W,0,7,'Phoenix Calulator');
    WEClrEol(W);
    WESetKr(W,$8F);
    WEBarSpcHorShade(W,0,8,wnMax-1);
    WEPutPTxtXY(W,0,8,TPathCalc);
    WEClrWnBorder(W,0,10,wnMax,wnMax-2);
   End;
   4:Begin
    WESetKrBorder(W);
    WEPutTxtXY(W,0,7,'Catalogue disque');
    WEClrEol(W);
    WESetKr(W,$8F);
    WEBarSpcHorShade(W,0,8,wnMax-1);
    WEPutPTxtXY(W,0,8,TPathCatDisk);
    WEClrWnBorder(W,0,10,wnMax,wnMax-2);
   End;
   5:Begin
    WESetKrBorder(W);
    WEPutTxtXY(W,0,7,'Draw');
    WEClrEol(W);
    WESetKr(W,$8F);
    WEBarSpcHorShade(W,0,8,wnMax-1);
    WEPutPTxtXY(W,0,8,TPathDraw);
    WESetKrBorder(W);
    WEPutTxtXY(W,0,10,'PCX');
    WEClrEol(W);
    WESetKr(W,$8F);
    WEBarSpcHorShade(W,0,11,wnMax-1);
    WEPutPTxtXY(W,0,11,TPathPCX);
    WESetKrBorder(W);
    WEPutTxtXY(W,0,13,'Macro');
    WEClrEol(W);
    WESetKr(W,$8F);
    WEBarSpcHorShade(W,0,14,wnMax-1);
    WEPutPTxtXY(W,0,14,TPathMacDrw);
    WEClrWnBorder(W,0,16,wnMax,wnMax-2);
   End;
   6:Begin
    WESetKrBorder(W);
    WEPutTxtXY(W,0,7,'Mod');
    WEClrEol(W);
    WESetKr(W,$8F);
    WEBarSpcHorShade(W,0,8,wnMax-1);
    WEPutPTxtXY(W,0,8,TPathMod);
    WEClrWnBorder(W,0,10,wnMax,wnMax-2);
   End;
   7:Begin
    WEClrWnBorder(W,0,8,wnMax,wnMax-2);
    WESetKrBorder(W);
    WEPutTxtXY(W,0,7,'Liste de t‚l‚phone');
    WEClrEol(W);
    WESetKr(W,$8F);
    WEBarSpcHorShade(W,0,8,31);
    WEPutPTxtXY(W,0,8,TPathPhoneList);
    WESetKrBorder(W);
    WEPutTxtXY(W,34,7,'Envoie de fichier');
    WESetKr(W,$8F);
    WEBarSpcHorShade(W,34,8,wnMax-1);
    WEPutPTxtXY(W,34,8,TPathUpLoad);
    WESetKrBorder(W);
    WEPutTxtXY(W,0,10,'R‚ception de fichier');
    WEClrEol(W);
    WESetKr(W,$8F);
    WEBarSpcHorShade(W,0,11,31);
    WEPutPTxtXY(W,0,11,TPathDownLoad);
    WESetKrBorder(W);
    WEPutTxtXY(W,34,10,'B.B.S.');
    WESetKr(W,$8F);
    WEBarSpcHorShade(W,34,11,wnMax-1);
    WEPutPTxtXY(W,34,11,TPathBBS);
   End;
   8:Begin
    WEClrWnBorder(W,0,7,wnMax,wnMax-2);
    WESetKrBorder(W);
    WEPutTxtXY(W,0,7,'Ada');
    WESetKr(W,$8F);
    WEBarSpcHorShade(W,0,8,20);
    WEPutPTxtXY(W,0,8,TPathAda);
    WESetKrBorder(W);
    WEPutTxtXY(W,23,7,'Assembleur');
    WESetKr(W,$8F);
    WEBarSpcHorShade(W,23,8,43);
    WEPutPTxtXY(W,23,8,TPathAsm);
    WESetKrBorder(W);
    WEPutTxtXY(W,46,7,'Basic');
    WESetKr(W,$8F);
    WEBarSpcHorShade(W,46,8,wnMax-1);
    WEPutPTxtXY(W,46,8,TPathBas);
    WESetKrBorder(W);
    WEPutTxtXY(W,0,10,'C/C++');
    WESetKr(W,$8F);
    WEBarSpcHorShade(W,0,11,20);
    WEPutPTxtXY(W,0,11,TPathC);
    WESetKrBorder(W);
    WEPutTxtXY(W,23,10,'Cobol');
    WESetKr(W,$8F);
    WEBarSpcHorShade(W,23,11,43);
    WEPutPTxtXY(W,23,11,TPathCobol);
    WESetKrBorder(W);
    WEPutTxtXY(W,46,10,'Euphoria');
    WESetKr(W,$8F);
    WEBarSpcHorShade(W,46,11,wnMax-1);
    WEPutPTxtXY(W,46,11,TPathEuphoria);
    WESetKrBorder(W);
    WEPutTxtXY(W,0,13,'Forth');
    WESetKr(W,$8F);
    WEBarSpcHorShade(W,0,14,20);
    WEPutPTxtXY(W,0,14,TPathForth);
    WESetKrBorder(W);
    WEPutTxtXY(W,23,13,'Fortran');
    WESetKr(W,$8F);
    WEBarSpcHorShade(W,23,14,43);
    WEPutPTxtXY(W,23,14,TPathFortran);
    WESetKrBorder(W);
    WEPutTxtXY(W,46,13,'Pascal');
    WESetKr(W,$8F);
    WEBarSpcHorShade(W,46,14,wnMax-1);
    WEPutPTxtXY(W,46,14,TPathPas);
   End;
   9:Begin
    WEClrWnBorder(W,0,8,wnMax,wnMax-2);
    WESetKrBorder(W);
    WEPutTxtXY(W,0,7,'Objet');
    WEClrEol(W);
    WESetKr(W,$8F);
    WEBarSpcHorShade(W,0,8,31);
    WEPutPTxtXY(W,0,8,TPathObject);
    WESetKrBorder(W);
    WEPutTxtXY(W,34,7,'Resource');
    WESetKr(W,$8F);
    WEBarSpcHorShade(W,34,8,wnMax-1);
    WEPutPTxtXY(W,34,8,TPathResource);
    WESetKrBorder(W);
    WEPutTxtXY(W,0,10,'Sortie');
    WEClrEol(W);
    WESetKr(W,$8F);
    WEBarSpcHorShade(W,0,11,31);
    WEPutPTxtXY(W,0,11,TPathOutput);
    WESetKrBorder(W);
    WEPutTxtXY(W,34,10,'Unit‚');
    WESetKr(W,$8F);
    WEBarSpcHorShade(W,34,11,wnMax-1);
    WEPutPTxtXY(W,34,11,TPathUnit);
   End;
   10:Begin
    WESetKrBorder(W);
    WEPutTxtXY(W,0,7,'OS/2');
    WEClrEol(W);
    WESetKr(W,$8F);
    WEBarSpcHorShade(W,0,8,wnMax-1);
    WEPutPTxtXY(W,0,8,TPathOS2);
    WESetKrBorder(W);
    WEPutTxtXY(W,0,10,'Unix');
    WEClrEol(W);
    WESetKr(W,$8F);
    WEBarSpcHorShade(W,0,11,wnMax-1);
    WEPutPTxtXY(W,0,11,TPathUnix);
    WESetKrBorder(W);
    WEPutTxtXY(W,0,13,'Windows');
    WEClrEol(W);
    WESetKr(W,$8F);
    WEBarSpcHorShade(W,0,14,wnMax-1);
    WEPutPTxtXY(W,0,14,TPathWin);
    WEClrWnBorder(W,0,16,wnMax,wnMax-2);
   End;
   11:Begin
    WESetKrBorder(W);
    WEPutTxtXY(W,0,7,'Pays');
    WEClrEol(W);
    WESetKr(W,$8F);
    WEBarSpcHorShade(W,0,8,wnMax-1);
    WEPutPTxtXY(W,0,8,TPathCountry);
    WEClrWnBorder(W,0,10,wnMax,wnMax-2);
   End;
  End;
 End;

 Procedure MouseAction;Var OP,MX,MY:Byte;Begin
  MX:=LastMsX-WEGetRX1(W);MY:=LastMsY-WEGetRY1(W);OP:=P;
  Case(MY)of
   0..6:P:=0;
   7..15:Begin
    P:=1;
    Case LMGetVal(L)of
     1:Begin
      PP:=(MY-7)div 3;
      If PP>1Then PP:=1;
     End;
     2:Begin
      PP:=(MY-7)div 3;
      If PP>1Then PP:=1;
     End;
     3:;
     4:;
     5:Begin
      PP:=(MY-7)div 3;
      If PP>2Then PP:=2;
     End;
     6:;
     7:Begin
      PP:=(((MY-7)div 3)shl 1)+(MX shr 5);
      If PP>3Then PP:=3;
     End;
     8:Begin
      PP:=((MY-7)div 3)*3+(MX div 22);
      If PP>8Then PP:=8;
     End;
     9:Begin
      PP:=(((MY-7)div 3)shl 1)+(MX shr 5);
      If PP>3Then PP:=3;
     End;
     10:Begin
      PP:=(MY-7)div 3;
      If PP>2Then PP:=2;
     End;
     11:;
    End;
   End;
   16..18:P:=2;
  End;
  If(P<>OP)and(MY<16)Then WaitMsBut0;
 End;

Begin
 SetupDir:=No;
 WEInitO(W,70,20);
 WEPushWn(W);
 WEPutWnKrDials(W,'R‚pertoire');
 WECloseIcon(W);
 WEBar(W);
 SetShade(No);
 WESubList(W,0,0,wnMax-1,5,'Cat‚gorie',L);
 LMPutSmallShade(L);
 LMPutBarMouseRight(L);
 RBAddStrByte(L.List,'MonsterBook',1);
 RBAddStrByte(L.List,'Traitement de texte',2);
 RBAddStrByte(L.List,'Chiffrier ‚lectronique',3);
 RBAddStrByte(L.List,'Catalogue',4);
 RBAddStrByte(L.List,'Imagerie/Dessin',5);
 RBAddStrByte(L.List,'Musique',6);
 RBAddStrByte(L.List,'T‚l‚matique',7);
 RBAddStrByte(L.List,'Programmation',8);
 RBAddStrByte(L.List,'Outils de programmation',9);
 RBAddStrByte(L.List,'SystŠme d''exploitation',10);
 RBAddStrByte(L.List,'Symbole',11);
 LMRefresh(L);
 LMSelBarInactive(L);
 WEPutkHorDn(W,'Correcte|Annule');
 P:=0;PP:=0;PPathBuf:=@PathBuf;
 TPathMalte:=StrNew(PathMalte);
 TPathSystems:=StrNew(PathSystems);
 TPathGat:=StrNew(PathGat);
 TPathMac:=StrNew(PathMac);
 TPathCalc:=StrNew(PathCalc);
 TPathCatDisk:=StrNew(PathCatDisk);
 TPathDraw:=StrNew(PathDraw);
 TPathPCX:=StrNew(PathPCX);
 TPathMacDrw:=StrNew(PathMacDrw);
 TPathMod:=StrNew(PathMod);
 TPathPhoneList:=StrNew(PathPhoneList);
 TPathUpLoad:=StrNew(PathUpLoad);
 TPathDownLoad:=StrNew(PathDownLoad);
 TPathBBS:=StrNew(PathBBS);
 TPathAda:=StrNew(PathAda);
 TPathAsm:=StrNew(PathAsm);
 TPathBas:=StrNew(PathBas);
 TPathC:=StrNew(PathC);
 TPathCobol:=StrNew(PathCobol);
 TPathEuphoria:=StrNew(PathEuphoria);
 TPathForth:=StrNew(PathForth);
 TPathFortran:=StrNew(PathFortran);
 TPathPas:=StrNew(PathPas);
 TPathObject:=StrNew(PathObject);
 TPathResource:=StrNew(PathResource);
 TPathOutput:=StrNew(PathOutput);
 TPathUnit:=StrNew(PathUnit);
 TPathOS2:=StrNew(PathOS2);
 TPathUnix:=StrNew(PathUnix);
 TPathWin:=StrNew(PathWin);
 TPathCountry:=StrNew(PathCountry);
 UpDateDir;
 WESetInpColors(W,$8F,W.Palette.Sel);
 Repeat
  Case(P)of
   0:Begin
    PP:=0;
    LMSelBar(L);
    K:=WEReadk(L.W);
    LMSelBarInactive(L);
    Case(K)of
     kbUp,kbRBarMsUp:Begin
      If(K=kbRBarMsUp)Then DelayMsPress(100);
      LMkUp(L);
      UpDateDir;
     End;
     kbDn,kbRBarMsDn:Begin
      If(K=kbRBarMsDn)Then DelayMsPress(100);
      LMkDn(L);
      UpDateDir;
     End;
     kbInWn:Begin
      If L.Y<>LastMsY-WEGetRY1(L.W)Then Begin
       __HideMousePtr;
       LMUnSelBar(L);
       Dec(L.P,L.Y);
       L.Y:=LastMsY-WEGetRY1(L.W);
       Inc(L.P,L.Y);
       LMSelBar(L);
       __ShowMousePtr
      End;
      WaitMsBut0;
      UpDateDir;
     End;
     kbMouse:Begin
      If WEInCloseIcon(W,LastMsX,LastMsY)Then Break Else
      If WEInWn(W,LastMsX,LastMsY)Then MouseAction;
     End;
     kbTab:P:=1;
     kbEsc,kbClose:Break;
    End;
   End;
   1:Case LMGetVal(L)of
    1:Begin
     Case(PP)of
      0:Begin
       StrCopy(@PathBuf,TPathMalte);
       K:=_WEInput(W,0,8,wnMax-1,80,PPathBuf);
       StrDispose(TPathMalte);
       TPathMalte:=StrNew(PPathBuf);
       WESetKr(W,$8F);
       WEBarSelHor(W,0,8,wnMax-1);
       Case(K)of
        kbUp:P:=0;
        kbDn,kbTab:PP:=1;
        kbEnter:If DirExist(StrPas(TPathMalte))Then P:=2
                                               Else __PathNotFound;
        kbEsc,kbClose:Break;
        kbInWn:MouseAction;
       End;
      End;
      1:Begin
       StrCopy(@PathBuf,TPathSystems);
       K:=_WEInput(W,0,11,wnMax-1,80,PPathBuf);
       StrDispose(TPathSystems);
       TPathSystems:=StrNew(PPathBuf);
       WESetKr(W,$8F);
       WEBarSelHor(W,0,11,wnMax-1);
       Case(K)of
        kbUp:PP:=0;
        kbDn,kbTab:P:=2;
        kbEnter:If DirExist(StrPas(TPathSystems))Then P:=2
                                                 Else __PathNotFound;
        kbEsc,kbClose:Break;
        kbInWn:MouseAction;
       End;
      End;
     End;
    End;
    2:Begin
     Case(PP)of
      0:Begin
       StrCopy(@PathBuf,TPathGat);
       K:=_WEInput(W,0,8,wnMax-1,80,PPathBuf);
       StrDispose(TPathGat);
       TPathGat:=StrNew(PPathBuf);
       WESetKr(W,$8F);
       WEBarSelHor(W,0,8,wnMax-1);
       Case(K)of
        kbUp:P:=0;
        kbDn,kbTab:PP:=1;
        kbEnter:If DirExist(StrPas(TPathGat))Then P:=2
                                             Else __PathNotFound;
        kbEsc,kbClose:Break;
        kbInWn:MouseAction;
       End;
      End;
      1:Begin
       StrCopy(@PathBuf,TPathMac);
       K:=_WEInput(W,0,11,wnMax-1,80,PPathBuf);
       StrDispose(TPathMac);
       TPathMac:=StrNew(PPathBuf);
       WESetKr(W,$8F);
       WEBarSelHor(W,0,11,wnMax-1);
       Case(K)of
        kbUp:PP:=0;
        kbDn,kbTab:P:=2;
        kbEnter:If DirExist(StrPas(TPathMac))Then P:=2
                                             Else __PathNotFound;
        kbEsc,kbClose:Break;
        kbInWn:MouseAction;
       End;
      End;
     End;
    End;
    3:Begin
     StrCopy(@PathBuf,TPathCalc);
     K:=_WEInput(W,0,8,wnMax-1,80,PPathBuf);
     StrDispose(TPathCalc);
     TPathCalc:=StrNew(PPathBuf);
     WESetKr(W,$8F);
     WEBarSelHor(W,0,8,wnMax-1);
     Case(K)of
      kbUp:P:=0;
      kbDn,kbTab:P:=2;
      kbEnter:If DirExist(StrPas(TPathCalc))Then P:=2
                                            Else __PathNotFound;
      kbEsc,kbClose:Break;
      kbInWn:MouseAction;
     End;
    End;
    4:Begin
     StrCopy(@PathBuf,TPathCatDisk);
     K:=_WEInput(W,0,8,wnMax-1,80,PPathBuf);
     StrDispose(TPathCatDisk);
     TPathCatDisk:=StrNew(PPathBuf);
     WESetKr(W,$8F);
     WEBarSelHor(W,0,8,wnMax-1);
     Case(K)of
      kbUp:P:=0;
      kbDn,kbTab:P:=2;
      kbEnter:If DirExist(StrPas(TPathCatDisk))Then P:=2
                                               Else __PathNotFound;
      kbEsc,kbClose:Break;
      kbInWn:MouseAction;
     End;
    End;
    5:Begin
     Case(PP)of
      0:Begin
       StrCopy(@PathBuf,TPathDraw);
       K:=_WEInput(W,0,8,wnMax-1,80,PPathBuf);
       StrDispose(TPathDraw);
       TPathDraw:=StrNew(PPathBuf);
       WESetKr(W,$8F);
       WEBarSelHor(W,0,8,wnMax-1);
       Case(K)of
        kbUp:P:=0;
        kbDn,kbTab:PP:=1;
        kbEnter:If DirExist(StrPas(TPathDraw))Then P:=2
                                              Else __PathNotFound;
        kbEsc,kbClose:Break;
        kbInWn:MouseAction;
       End;
      End;
      1:Begin
       StrCopy(@PathBuf,TPathPCX);
       K:=_WEInput(W,0,11,wnMax-1,80,PPathBuf);
       StrDispose(TPathPCX);
       TPathPCX:=StrNew(PPathBuf);
       WESetKr(W,$8F);
       WEBarSelHor(W,0,11,wnMax-1);
       Case(K)of
        kbUp:PP:=0;
        kbDn,kbTab:PP:=2;
        kbEnter:If DirExist(StrPas(TPathPCX))Then P:=2
                                             Else __PathNotFound;
        kbEsc,kbClose:Break;
        kbInWn:MouseAction;
       End;
      End;
      2:Begin
       StrCopy(@PathBuf,TPathMacDrw);
       K:=_WEInput(W,0,14,wnMax-1,80,PPathBuf);
       StrDispose(TPathMacDrw);
       TPathMacDrw:=StrNew(PPathBuf);
       WESetKr(W,$8F);
       WEBarSelHor(W,0,14,wnMax-1);
       Case(K)of
        kbUp:PP:=1;
        kbDn,kbTab:P:=2;
        kbEnter:If DirExist(StrPas(TPathMacDrw))Then P:=2
                                                Else __PathNotFound;
        kbEsc,kbClose:Break;
        kbInWn:MouseAction;
       End;
      End;
     End;
    End;
    6:Begin
     StrCopy(@PathBuf,TPathMod);
     K:=_WEInput(W,0,8,wnMax-1,80,PPathBuf);
     StrDispose(TPathMod);
     TPathMod:=StrNew(PPathBuf);
     WESetKr(W,$8F);
     WEBarSelHor(W,0,8,wnMax-1);
     Case(K)of
      kbUp:P:=0;
      kbDn,kbTab:P:=2;
      kbEnter:If DirExist(StrPas(TPathMod))Then P:=2
                                           Else __PathNotFound;
      kbEsc,kbClose:Break;
      kbInWn:MouseAction;
     End;
    End;
    7:Begin
     Case(PP)of
      0:Begin
       StrCopy(@PathBuf,TPathPhoneList);
       K:=_WEInput(W,0,8,31,80,PPathBuf);
       StrDispose(TPathPhoneList);
       TPathPhoneList:=StrNew(PPathBuf);
       WESetKr(W,$8F);
       WEBarSelHor(W,0,8,31);
       Case(K)of
        kbUp:P:=0;
        kbDn:PP:=2;
        kbTab:PP:=1;
        kbEnter:If DirExist(StrPas(TPathPhoneList))Then P:=2
                                                   Else __PathNotFound;
        kbEsc,kbClose:Break;
        kbInWn:MouseAction;
       End;
      End;
      1:Begin
       StrCopy(@PathBuf,TPathUpLoad);
       K:=_WEInput(W,34,8,wnMax-1,80,PPathBuf);
       StrDispose(TPathUpLoad);
       TPathUpLoad:=StrNew(PPathBuf);
       WESetKr(W,$8F);
       WEBarSelHor(W,34,8,wnMax-1);
       Case(K)of
        kbUp:P:=0;
        kbDn:PP:=3;
        kbTab:PP:=2;
        kbEnter:If DirExist(StrPas(TPathUpLoad))Then P:=2
                                                Else __PathNotFound;
        kbEsc,kbClose:Break;
        kbInWn:MouseAction;
       End;
      End;
      2:Begin
       StrCopy(@PathBuf,TPathDownLoad);
       K:=_WEInput(W,0,11,31,80,PPathBuf);
       StrDispose(TPathDownLoad);
       TPathDownLoad:=StrNew(PPathBuf);
       WESetKr(W,$8F);
       WEBarSelHor(W,0,11,31);
       Case(K)of
        kbUp:PP:=0;
        kbDn:P:=2;
        kbTab:PP:=3;
        kbEnter:If DirExist(StrPas(TPathDownLoad))Then P:=2
                                                  Else __PathNotFound;
        kbEsc,kbClose:Break;
        kbInWn:MouseAction;
       End;
      End;
      3:Begin
       StrCopy(@PathBuf,TPathBBS);
       K:=_WEInput(W,34,11,wnMax-1,80,PPathBuf);
       StrDispose(TPathBBS);
       TPathBBS:=StrNew(PPathBuf);
       WESetKr(W,$8F);
       WEBarSelHor(W,34,11,wnMax-1);
       Case(K)of
        kbUp:PP:=1;
        kbDn:P:=2;
        kbTab:P:=2;
        kbEnter:If DirExist(StrPas(TPathBBS))Then P:=2
                                             Else __PathNotFound;
        kbEsc,kbClose:Break;
        kbInWn:MouseAction;
       End;
      End;
     End;
    End;
    8:Begin
     Case(PP)of
      0:Begin
       StrCopy(@PathBuf,TPathAda);
       K:=_WEInput(W,0,8,20,80,PPathBuf);
       StrDispose(TPathAda);
       TPathAda:=StrNew(PPathBuf);
       WESetKr(W,$8F);
       WEBarSelHor(W,0,8,20);
       Case(K)of
        kbUp:P:=0;
        kbDn:PP:=3;
        kbTab:PP:=1;
        kbEnter:If DirExist(StrPas(TPathAda))Then P:=2
                                             Else __PathNotFound;
        kbEsc,kbClose:Break;
        kbInWn:MouseAction;
       End;
      End;
      1:Begin
       StrCopy(@PathBuf,TPathAsm);
       K:=_WEInput(W,23,8,43,80,PPathBuf);
       StrDispose(TPathAsm);
       TPathAsm:=StrNew(PPathBuf);
       WESetKr(W,$8F);
       WEBarSelHor(W,23,8,43);
       Case(K)of
        kbUp:P:=0;
        kbDn:PP:=4;
        kbTab:PP:=2;
        kbEnter:If DirExist(StrPas(TPathAsm))Then P:=2
                                             Else __PathNotFound;
        kbEsc,kbClose:Break;
        kbInWn:MouseAction;
       End;
      End;
      2:Begin
       StrCopy(@PathBuf,TPathBas);
       K:=_WEInput(W,46,8,wnMax-1,80,PPathBuf);
       StrDispose(TPathBas);
       TPathBas:=StrNew(PPathBuf);
       WESetKr(W,$8F);
       WEBarSelHor(W,46,8,wnMax-1);
       Case(K)of
        kbUp:P:=0;
        kbDn:PP:=5;
        kbTab:PP:=3;
        kbEnter:If DirExist(StrPas(TPathBas))Then P:=2
                                             Else __PathNotFound;
        kbEsc,kbClose:Break;
        kbInWn:MouseAction;
       End;
      End;
      3:Begin
       StrCopy(@PathBuf,TPathC);
       K:=_WEInput(W,0,11,20,80,PPathBuf);
       StrDispose(TPathC);
       TPathC:=StrNew(PPathBuf);
       WESetKr(W,$8F);
       WEBarSelHor(W,0,11,20);
       Case(K)of
        kbUp:PP:=0;
        kbDn:PP:=6;
        kbTab:PP:=4;
        kbEnter:If DirExist(StrPas(TPathC))Then P:=2
                                           Else __PathNotFound;
        kbEsc,kbClose:Break;
        kbInWn:MouseAction;
       End;
      End;
      4:Begin
       StrCopy(@PathBuf,TPathCobol);
       K:=_WEInput(W,23,11,43,80,PPathBuf);
       StrDispose(TPathCobol);
       TPathCobol:=StrNew(PPathBuf);
       WESetKr(W,$8F);
       WEBarSelHor(W,23,11,43);
       Case(K)of
        kbUp:PP:=1;
        kbDn:PP:=7;
        kbTab:PP:=5;
        kbEnter:If DirExist(StrPas(TPathCobol))Then P:=2
                                               Else __PathNotFound;
        kbEsc,kbClose:Break;
        kbInWn:MouseAction;
       End;
      End;
      5:Begin
       StrCopy(@PathBuf,TPathEuphoria);
       K:=_WEInput(W,46,11,wnMax-1,80,PPathBuf);
       StrDispose(TPathEuphoria);
       TPathEuphoria:=StrNew(PPathBuf);
       WESetKr(W,$8F);
       WEBarSelHor(W,46,11,wnMax-1);
       Case(K)of
        kbUp:PP:=2;
        kbDn:PP:=8;
        kbTab:PP:=6;
        kbEnter:If DirExist(StrPas(TPathEuphoria))Then P:=2
                                                  Else __PathNotFound;
        kbEsc,kbClose:Break;
        kbInWn:MouseAction;
       End;
      End;
      6:Begin
       StrCopy(@PathBuf,TPathForth);
       K:=_WEInput(W,0,14,20,80,PPathBuf);
       StrDispose(TPathForth);
       TPathForth:=StrNew(PPathBuf);
       WESetKr(W,$8F);
       WEBarSelHor(W,0,14,20);
       Case(K)of
        kbUp:PP:=3;
        kbDn:P:=2;
        kbTab:PP:=7;
        kbEnter:If DirExist(StrPas(TPathForth))Then P:=2
                                               Else __PathNotFound;
        kbEsc,kbClose:Break;
        kbInWn:MouseAction;
       End;
      End;
      7:Begin
       StrCopy(@PathBuf,TPathFortran);
       K:=_WEInput(W,23,14,43,80,PPathBuf);
       StrDispose(TPathFortran);
       TPathFortran:=StrNew(PPathBuf);
       WESetKr(W,$8F);
       WEBarSelHor(W,23,14,43);
       Case(K)of
        kbUp:PP:=4;
        kbDn:P:=2;
        kbTab:PP:=8;
        kbEnter:If DirExist(StrPas(TPathFortran))Then P:=2
                                                 Else __PathNotFound;
        kbEsc,kbClose:Break;
        kbInWn:MouseAction;
       End;
      End;
      8: Begin
       StrCopy(@PathBuf,TPathPas);
       K:=_WEInput(W,46,14,wnMax-1,80,PPathBuf);
       StrDispose(TPathPas);
       TPathPas:=StrNew(PPathBuf);
       WESetKr(W,$8F);
       WEBarSelHor(W,46,14,wnMax-1);
       Case(K)of
        kbUp:PP:=5;
        kbDn:P:=2;
        kbTab:P:=2;
        kbEnter:If DirExist(StrPas(TPathPas))Then P:=2
                                             Else __PathNotFound;
        kbEsc,kbClose:Break;
        kbInWn:MouseAction;
       End;
      End;
     End;
    End;
    9:Begin
     Case(PP)of
      0:Begin
       StrCopy(@PathBuf,TPathObject);
       K:=_WEInput(W,0,8,31,80,PPathBuf);
       StrDispose(TPathObject);
       TPathObject:=StrNew(PPathBuf);
       WESetKr(W,$8F);
       WEBarSelHor(W,0,8,31);
       Case(K)of
        kbUp:P:=0;
        kbDn:PP:=2;
        kbTab:PP:=1;
        kbEnter:If DirExist(StrPas(TPathObject))Then P:=2
                                                Else __PathNotFound;
        kbEsc,kbClose:Break;
        kbInWn:MouseAction;
       End;
      End;
      1:Begin
       StrCopy(@PathBuf,TPathResource);
       K:=_WEInput(W,34,8,wnMax-1,80,PPathBuf);
       StrDispose(TPathResource);
       TPathResource:=StrNew(PPathBuf);
       WESetKr(W,$8F);
       WEBarSelHor(W,34,8,wnMax-1);
       Case(K)of
        kbUp:P:=0;
        kbDn:PP:=3;
        kbTab:PP:=2;
        kbEnter:If DirExist(StrPas(TPathResource))Then P:=2
                                                  Else __PathNotFound;
        kbEsc,kbClose:Break;
        kbInWn:MouseAction;
       End;
      End;
      2:Begin
       StrCopy(@PathBuf,TPathOutput);
       K:=_WEInput(W,0,11,31,80,PPathBuf);
       StrDispose(TPathOutput);
       TPathOutput:=StrNew(PPathBuf);
       WESetKr(W,$8F);
       WEBarSelHor(W,0,11,31);
       Case(K)of
        kbUp:PP:=0;
        kbDn:P:=2;
        kbTab:PP:=3;
        kbEnter:If DirExist(StrPas(TPathOutput))Then P:=2
                                                Else __PathNotFound;
        kbEsc,kbClose:Break;
        kbInWn:MouseAction;
       End;
      End;
      3:Begin
       StrCopy(@PathBuf,TPathUnit);
       K:=_WEInput(W,34,11,wnMax-1,80,PPathBuf);
       StrDispose(TPathUnit);
       TPathUnit:=StrNew(PPathBuf);
       WESetKr(W,$8F);
       WEBarSelHor(W,34,11,wnMax-1);
       Case(K)of
        kbUp:PP:=1;
        kbDn:P:=2;
        kbTab:P:=2;
        kbEnter:If DirExist(StrPas(TPathUnit))Then P:=2
                                              Else __PathNotFound;
        kbEsc,kbClose:Break;
        kbInWn:MouseAction;
       End;
      End;
     End;
    End;
    10:Begin
     Case(PP)of
      0:Begin
       StrCopy(@PathBuf,TPathOS2);
       K:=_WEInput(W,0,8,wnMax-1,80,PPathBuf);
       StrDispose(TPathOS2);
       TPathOS2:=StrNew(PPathBuf);
       WESetKr(W,$8F);
       WEBarSelHor(W,0,8,wnMax-1);
       Case(K)of
        kbUp:P:=0;
        kbDn,kbTab:PP:=1;
        kbEnter:If DirExist(StrPas(TPathOS2))Then P:=2
                                             Else __PathNotFound;
        kbEsc,kbClose:Break;
        kbInWn:MouseAction;
       End;
      End;
      1:Begin
       StrCopy(@PathBuf,TPathUnix);
       K:=_WEInput(W,0,11,wnMax-1,80,PPathBuf);
       StrDispose(TPathUnix);
       TPathUnix:=StrNew(PPathBuf);
       WESetKr(W,$8F);
       WEBarSelHor(W,0,11,wnMax-1);
       Case(K)of
        kbUp:PP:=0;
        kbDn,kbTab:PP:=2;
        kbEnter:If DirExist(StrPas(TPathUnix))Then P:=2
                                              Else __PathNotFound;
        kbEsc,kbClose:Break;
        kbInWn:MouseAction;
       End;
      End;
      2:Begin
       StrCopy(@PathBuf,TPathWin);
       K:=_WEInput(W,0,14,wnMax-1,80,PPathBuf);
       StrDispose(TPathWin);
       TPathWin:=StrNew(PPathBuf);
       WESetKr(W,$8F);
       WEBarSelHor(W,0,14,wnMax-1);
       Case(K)of
        kbUp:PP:=1;
        kbDn,kbTab:P:=2;
        kbEnter:If DirExist(StrPas(TPathWin))Then P:=2
                                             Else __PathNotFound;
        kbEsc,kbClose:Break;
        kbInWn:MouseAction;
       End;
      End;
     End;
    End;
    11:Begin
     StrCopy(@PathBuf,TPathCountry);
     K:=_WEInput(W,0,8,wnMax-1,80,PPathBuf);
     StrDispose(TPathCountry);
     TPathCountry:=StrNew(PPathBuf);
     WESetKr(W,$8F);
     WEBarSelHor(W,0,8,wnMax-1);
     Case(K)of
      kbUp:P:=0;
      kbDn,kbTab:P:=2;
      kbEnter:If DirExist(StrPas(TPathCountry))Then P:=2
                                               Else __PathNotFound;
      kbEsc,kbClose:Break;
      kbInWn:MouseAction;
     End;
    End;
   End;
   2:Begin
    PP:=0;K:=WEGetkHorDn(W,'$Correcte|Annule');
    Case(K)of
     1,kbEsc,kbClose,kbAbort:Break;
     kbInWn:MouseAction;
     0,kbEnter:Begin
      SetupDir:=Ya;
      StrDispose(PathMalte);
      PathMalte:=StrNew(TPathMalte);
      StrDispose(PathSystems);
      PathSystems:=StrNew(TPathSystems);
      StrDispose(PathGat);
      PathGat:=StrNew(TPathGat);
      StrDispose(PathMac);
      PathMac:=StrNew(TPathMac);
      StrDispose(PathCalc);
      PathCalc:=StrNew(TPathCalc);
      StrDispose(PathCatDisk);
      PathCatDisk:=StrNew(TPathCatDisk);
      StrDispose(PathDraw);
      PathDraw:=StrNew(TPathDraw);
      StrDispose(PathPCX);
      PathPCX:=StrNew(TPathPCX);
      StrDispose(PathMacDrw);
      PathMacDrw:=StrNew(TPathMacDrw);
      StrDispose(PathMod);
      PathMod:=StrNew(TPathMod);
      StrDispose(PathPhoneList);
      PathPhoneList:=StrNew(TPathPhoneList);
      StrDispose(PathUpLoad);
      PathUpLoad:=StrNew(TPathUpLoad);
      StrDispose(PathDownLoad);
      PathDownLoad:=StrNew(TPathDownLoad);
      StrDispose(PathBBS);
      PathBBS:=StrNew(TPathBBS);
      StrDispose(PathAda);
      PathAda:=StrNew(TPathAda);
      StrDispose(PathAsm);
      PathAsm:=StrNew(TPathAsm);
      StrDispose(PathBas);
      PathBas:=StrNew(TPathBas);
      StrDispose(PathC);
      PathC:=StrNew(TPathC);
      StrDispose(PathCobol);
      PathCobol:=StrNew(TPathCobol);
      StrDispose(PathEuphoria);
      PathEuphoria:=StrNew(TPathEuphoria);
      StrDispose(PathForth);
      PathForth:=StrNew(TPathForth);
      StrDispose(PathFortran);
      PathFortran:=StrNew(TPathFortran);
      StrDispose(PathPas);
      PathPas:=StrNew(TPathPas);
      StrDispose(PathObject);
      PathObject:=StrNew(TPathObject);
      StrDispose(PathResource);
      PathResource:=StrNew(TPathResource);
      StrDispose(PathOutput);
      PathOutput:=StrNew(TPathOutput);
      StrDispose(PathUnit);
      PathUnit:=StrNew(TPathUnit);
      StrDispose(PathOS2);
      PathOS2:=StrNew(TPathOS2);
      StrDispose(PathUnix);
      PathUnix:=StrNew(TPathUnix);
      StrDispose(PathWin);
      PathWin:=StrNew(TPathWin);
      StrDispose(PathCountry);
      PathCountry:=StrNew(TPathCountry);
      Break;
     End;
     kbTab:P:=0;
    End;
   End;
  End;
 Until No;
 StrDispose(TPathMalte);
 StrDispose(TPathSystems);
 StrDispose(TPathGat);
 StrDispose(TPathMac);
 StrDispose(TPathCalc);
 StrDispose(TPathCatDisk);
 StrDispose(TPathDraw);
 StrDispose(TPathPCX);
 StrDispose(TPathMacDrw);
 StrDispose(TPathMod);
 StrDispose(TPathPhoneList);
 StrDispose(TPathUpLoad);
 StrDispose(TPathDownLoad);
 StrDispose(TPathBBS);
 StrDispose(TPathAda);
 StrDispose(TPathAsm);
 StrDispose(TPathBas);
 StrDispose(TPathC);
 StrDispose(TPathCobol);
 StrDispose(TPathEuphoria);
 StrDispose(TPathForth);
 StrDispose(TPathFortran);
 StrDispose(TPathPas);
 StrDispose(TPathObject);
 StrDispose(TPathResource);
 StrDispose(TPathOutput);
 StrDispose(TPathUnit);
 StrDispose(TPathOS2);
 StrDispose(TPathUnix);
 StrDispose(TPathWin);
 StrDispose(TPathCountry);
 SetShade(Ya);
 WEDone(W);
End;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
END.
