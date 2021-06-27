{���������������������������������������������������������������������������
 �                                                                         �
 �                               D A M A X                                 �
 �                                                                         �
 �            �dition Chantal pour Mode R�el/IV - Version 1.1              �
 �                              1999/01/01                                 �
 �                                                                         �
 �          Tous droits r�serv�s par les Chevaliers de Malte (C)           �
 �                                                                         �
 ���������������������������������������������������������������������������


 Nom du programmeur
 ������������������

  Sylvain Maltais


 Description
 �����������

  Ce programme s'occupe de la gestion de donn�es et de recherches de donn�es
 utilisateur  en fonction  d'un sujet  donn�es en fonction  des informations
 contenu dans l'�\ATLAS�.
}

Program DataMax;

Uses Adele,Systex,Systems,Video,Mouse,Dials,Isatex,Memories,Dialex;

Const
 dmExit=$F001;

{�������������������������������������������������������������
 �                       Proc�dure MakeMnu                   �
 �������������������������������������������������������������


 Description
 �����������

  Cette proc�dure permet de cr�er un menu d�roulant pour cette
 application.
}

Procedure MakeMnu;Begin
 PMInit;
 PMAddMnu('^D^onn�e');
  PMAddItemKey('^Q^uitter',kbAltX,dmExit,'Permet de quitter l''�Damax�!');
 PMSetWinBar(0,1,MaxXTxts);
End;

{�������������������������������������������������������������������������
 �                          Fonction GetBckFileTxtLn                     �
 �������������������������������������������������������������������������


 Description
 �����������

  Cette fonction permet de lire une ligne ASCII en arri�re (la pr�c�dante)
 plut�t que la prochaine afin de revenir en arri�re...
}

Function GetBckFileTxtLn(Handle,P:Wd;PL:Long):String;Near;Label Break;Var Str:String;I:Byte;Chr:Char;Buf:PChrAByte;Begin
 GetBckFileTxtLn:='';Str:='';
 _GetAbsRec(Handle,PL,P,Buf);
 For I:=P-3downto 1do Begin
  Chr:=Buf[I-1];
  If Chr=#10Then Begin
   Chr:=Buf[I-2];
   If Chr=#13Then Goto Break;
   Str:=#10+Chr+Str
  End
   Else
  Str:=Chr+Str
 End;
Break:GetBckFileTxtLn:=Str
End;

{�������������������������������������������������������������ķ}
{�                    O b j e t  V i e w A s c i i             �}
{�������������������������������������������������������������ͼ}

Type
 VAB=Record
  W:Window;             { Fen�tre de visualisation }
  Title:String;         { Nom de la fen�tre }
  FileName:String;      { Nom du fichier � visualiser }
  Min,FileSize:Long;    { Coordonn�e minimum et maximum (taille de fichier) }
  PBnk:^TLong;          { Banque de position de chaque d�but de ligne }
  SizeBnk:Wd;           { Taille de la banque de position }
  View:(ASCII,Hlp,GAT); { Visualisateur sous forme d'Aide, GAT ou Normal (ASCII) }
 End;

Function  VABInit(Var Q:VAB;X1,Y1,X2,Y2:Byte;Const FileName,Title:String):Bool;Forward;
Function  VABInit4RLL(Var Q:VAB;X1,Y1,X2,Y2:Byte;Const FileName,Title:String;Index,IndexEnd:Wd):Bool;Forward;
Procedure VABGotoFilePos(Var Q:VAB;P:Long);Forward;
Procedure VABDn(Var Q:VAB);Forward;
Procedure VABPgDn(Var Q:VAB);Forward;
Procedure VABPgUp(Var Q:VAB);Forward;
Procedure VABPutData(Var Q:VAB);Forward;
Procedure VABUp(Var Q:VAB);Forward;
Procedure VABRefresh(Var Q);Forward;
Procedure VABRefreshData(Var Q:VAB;ClrEol:Bool);Forward;
Function  VABRun(Var Q):Wd;Forward;
Procedure VABReSize(Var Q:VAB;X1,Y1,X2,Y2:Byte);Forward;
Procedure VABDone(Var Q:VAB);Forward;

{ �������������������������������������������������������������������������
  �                           Proc�dure VABPutTxt                         �
  �������������������������������������������������������������������������


  Propri�taire: VAB
  Portabilit�:  Local


  Description
  �����������

   Cette proc�dure permet d'afficher  le contenu d'une cha�ne de caract�res
  � la position courante du visualisateur de fichier ASCII en regard rapide
  en tenant compte du format de fichier de traitement de texte GAT.
}

Procedure VABPutTxt(Var Q:VAB;Str:String);Near;Var I,X,XM,Y,GAttr:Byte;Chr:Char;Begin
 _DelAllSpcRight(Str);
 If(Q.View=GAT)Then Begin
  I:=1;X:=WEGetRealX(Q.W);Y:=WEGetRealY(Q.W);
  While(Length(Str)>=I)do Begin
   If Str[I]<' 'Then Begin;GAttr:=Byte(Str[I]);Inc(I);Chr:=Str[I]End
                Else Begin;GAttr:=0;Chr:=Str[I]End;
   Inc(I);
   If(X>=XM)and(GAttr and $10=$10)Then Break;
   PutCharGAttr(X,Y,Chr,Q.W.CurrColor,GAttr);
   Inc(X);
   If GAttr and$10=$10Then Inc(X);
   If(X>XM)Then Break;
  End;
  Q.W.X:=X-WEGetRealX(Q.W)
 End
  Else
 WEPutTxt(Q.W,Str);
End;

{ ����������������������������������������������������������������������
  �                           Proc�dure VABDn                          �
  ����������������������������������������������������������������������


  Propri�taire: VAB
  Portabilit�:  Globale


  Description
  �����������

   Cette proc�dure permet de passer � la lecture d'une liste du texte de
  ASCII  suiVABnt  � l'�cran  de l'objet  de visualisation  de fichier en
  regard rapide.
}

Procedure VABDn;Var Handle:Hdl;Str:String;MY,L:Byte;P:Long;Begin
 MY:=Q.W.MaxY;
 If Q.FileSize<=Q.PBnk^[MY]Then Exit;
 Handle:=FileOpen(Q.FileName,fmRead);
 If(Handle<>errHdl)Then Begin
  MoveLeft(Q.PBnk^[1],Q.PBnk^,Q.SizeBnk-4);
  _WEScrollDn(Q.W);
  WESetPos(Q.W,0,MY);
{  L:=Length(GetAbsFileTxtLn(Handle,Q.PBnk^[MY-1]));
  If(L>Q.W.MaxX)Then L:=Q.W.MaxX+1 Else Inc(L,2);}
  P:=Q.PBnk^[MY-1];
  __GetAbsFileTxtLn(Handle,P,Str);
{  L:=Length(Str);
  If L>Q.W.MaxX+1Then L:=Q.W.MaxX+1 Else L:=P-Q.PBnk^[MY-1];}
  L:=Length(Str)+2;
  Q.PBnk^[MY]:=Q.PBnk^[MY-1]+L;P:=Q.PBnk^[MY];
  __GetAbsFileTxtLn(Handle,P,Str);
  VABPutTxt(Q,Str);
  WEClrEOL(Q.W);
  FileClose(Handle);
  VABPutData(Q)
 End
End;

{ �������������������������������������������������������������������
  �                        Destructeur VABDone                      �
  �������������������������������������������������������������������


  Propri�taire: VAB
  Portabilit�:  Globale


  Description
  �����������

   Ce destructeur met fin � l'objet de visualisation de fichier ASCII
  en regard rapide.
}

Procedure VABDone;Begin FreeMem(Q.PBnk,Q.SizeBnk);WEDone(Q.W)End;

{ ��������������������������������������������������������������������
  �                       Proc�dure VABInitFrame                     �
  ��������������������������������������������������������������������


  Propri�taire: VAB


  Description
  �����������

   Cette proc�dure permet d'initaliser la structure de base interne du
  visualisateur de fichier ASCII en regard rapide.
}

Procedure VABInitFrame(Var Q:VAB;Const FileName,Title:String;X1,Y1,X2,Y2:Byte);Var S:String;Begin
 FillClr(Q,SizeOf(Q));
 Q.Title:=Title;
 If Not FileExist(FileName)Then Exit;
 If Path2Ext(FileName)='.GAT'Then Begin
  Q.View:=GAT;S[0]:=#255;
  GetFile(FileName,0,SizeOf(S)-1,S[1]);
  S[0]:=Char(Pos(#13,S));Q.Min:=Length(S)+2;Q.PBnk^[0]:=Q.Min;
 End
  Else
 Q.Min:=0;
 Q.FileSize:=GetFileSize(FileName);
 WEInit(Q.W,X1,Y1,X2,Y2);
 Q.SizeBnk:=(Q.W.T.Y2-Q.W.T.Y1+2)shl 2;Q.PBnk:=MemNew(Q.SizeBnk);
 If(Q.PBnk=NIL)Then Exit;
 If(Q.View=GAT)Then Q.PBnk^[0]:=Q.Min;
 {$IFNDEF H}WEPushWn(Q.W);{$ENDIF}
 Q.FileName:=FileName;
End;

{ ����������������������������������������������������������������������
  �                        Proc�dure VABGotoFilePos                    �
  ����������������������������������������������������������������������


  Propri�taire: VAB
  Portabilit�:  Globale


  Description
  �����������

   Cette proc�dure permet d'envoyer le visualisateur de fichier ASCII en
  regarde rapide � une position absolue  � partir du d�but du fichier en
  octets.
}

Procedure VABGotoFilePos;Begin
 Q.PBnk^[0]:=P;
 VABRefreshData(Q,Ya)
End;

{ ������������������������������������������������������������������������
  �                          Constructeur VABInit                        �
  ������������������������������������������������������������������������


  Propri�taire: VAB
  Portabilit�:  Globale


  Description
  �����������

   Ce constructeur permet d'initialiser une visualisateur de fichier ASCII
  rapide sur justement un fichier existant quelque part sur une des unit�s
  logique disponible.
}

Function VABInit;Begin
 VABInit:=No;
 VABInitFrame(Q,FileName,Title,X1,Y1,X2,Y2);
 VABRefresh(Q);
 VABInit:=Ya
End;

{ ����������������������������������������������������������������������
  �                        Constructeur VABInit4RLL                    �
  ����������������������������������������������������������������������


  Propri�taire: VAB
  Portabilit�:  Globale


  Description
  �����������

   Ce constructeur permet d'afficher le contenu ASCII d'un index contenu
  dans un fichier biblioth�que de format �RLL� � partir du visualisateur
  rapide.
}

Function VABInit4RLL;
Var
 XP:Array[0..1]of LongInt;
 Handle:Hdl;
 I:Word;
Begin
 VABInit4RLL:=False;
 VABInitFrame(Q,FileName,Title,X1,Y1,X2,Y2);
 Handle:=FileOpen(FileName,fmRead);
 If(Handle<>errHdl)Then Begin
  If Index=$FFFFThen Begin
   GetRec(Handle,0,SizeOf(XP[0]),XP[0]);
   If XP[0]=$1A324C52Then Begin
    XP[0]:=4;I:=1;
    While Q.FileSize<>XP[0]do Begin
     GetRec(Handle,I,SizeOf(XP[0]),XP[0]);
     If GetSysErr<>0Then Break;
     Inc(I);
    End;
    Q.Min:=I shl 2;
   End;
  End
   Else
  Begin
   _GetAbsRec(Handle,(Index+1)shl 2,SizeOf(XP),XP);
   Q.Min:=XP[0];
   If(IndexEnd<>Index)Then _GetAbsRec(Handle,(IndexEnd+1)shl 2,SizeOf(XP),XP);
   Q.FileSize:=XP[1]-1;
  End;
  FileClose(Handle);
  Q.PBnk^[0]:=Q.Min;
 End;
 VABRefresh(Q);
 VABInit4RLL:=Ya
End;

{ �������������������������������������������������������������������������
  �                             Proc�dure VABPgDn                         �
  �������������������������������������������������������������������������


  Propri�taire: VAB
  Portabilit�:  Globale


  Description
  �����������


   Cette proc�dure permet de descendre � l'�cran plus haut du fichier ASCII
  actuellement en visualisation.
}

Procedure VABPgDn;Var MY:Byte;Begin
 MY:=Q.W.MaxY;
 If Q.FileSize<=Q.PBnk^[MY]Then Exit;
 Q.PBnk^[0]:=Q.PBnk^[MY];
 VABRefreshData(Q,Ya)
End;

{ ������������������������������������������������������������������������
  �                            Proc�dure VABPgUp                         �
  ������������������������������������������������������������������������


  Propri�taire: VAB
  Portabilit�:  Globale


  Description
  �����������


   Cette proc�dure permet de remonter � l'�cran plus haut du fichier ASCII
  actuellement en visualisation.
}

Procedure VABPgUp;Var Handle:Hdl;P:Wd;Str:String;PL:Long;J:Byte;Begin
 If(Q.PBnk^[0]<=Q.Min)Then Exit;
 Handle:=FileOpen(Q.FileName,fmRead);
 If(Handle<>errHdl)Then Begin
  Q.PBnk^[Q.W.MaxY+1]:=Q.PBnk^[1];
  For J:=Q.W.MaxY downto 0do Begin
   WESetPos(Q.W,0,J);
{   If(Q.PBnk^[J+1]<=Q.Min)Then Begin Q.PBnk^[0]:=Q.Min;VABRefresh(Q);Break;End
    Else
   Begin}
    P:=256;PL:=Q.PBnk^[J+1]-255;
    If PL<0Then Begin;P:=Q.PBnk^[J+1]+1;PL:=0;End;
    Str:=GetBckFileTxtLn(Handle,P,PL);
    VABPutTxt(Q,Str);
{   End;}
   WEClrEOL(Q.W);
   Q.PBnk^[J]:=Q.PBnk^[J+1]-Length(Str)-2;
   If(Q.PBnk^[J]<=Q.Min)Then Begin Q.PBnk^[0]:=Q.Min;VABRefresh(Q);Break;End
  End;
  FileClose(Handle);
  VABPutData(Q)
 End
End;

{ �����������������������������������������������������������������������
  �                           Proc�dure VABPutData                      �
  �����������������������������������������������������������������������


  Propri�taire: VAB


  Description
  �����������

   Cette proc�dure permet d'afficher l'indicateur de position actuel dans
  le regardeur  de fichiers ASCII  de l'objet d�finit  par la variable de
  param�trage �Q�.
}

Procedure VABPutData;Var S,S2:String;Begin
 S:=CStr(Q.PBnk^[0]);
 If(Q.PBnk^[Q.W.MaxY]>Q.FileSize)Then S2:='la Fin'Else S2:=CStr(Q.PBnk^[Q.W.MaxY]);
 S2:=StrUSpc(S2,13);
 WESetEndBarTxtX(Q.W,1,Spc(14-Length(S))+S+' a '+S2,Q.W.Palette.Title)
End;

{ ������������������������������������������������������������������������
  �                          Proc�dure VABRefresh                        �
  ������������������������������������������������������������������������


  Propri�taire: VAB
  Portabilit�:  Globale


  Description
  �����������

   Cette proc�dure permet de restituer compl�tement la fen�tre de dialogue
  de visualisation de fichier ASCII en regard rapide sans aucune ommission
  quelqu'elle soit.
}

Procedure VABRefresh;Begin
 WEPutWn(VAB(Q).W,VAB(Q).Title,CurrKrs.Help.Window);
 WEPutSmallBorder(VAB(Q).W);
 WESetEndBar(VAB(Q).W,VAB(Q).W.Palette.Title);
 WEPutBarMsRight(VAB(Q).W);
 VABRefreshData(VAB(Q),No);
 If Not(VAB(Q).View=Hlp)Then Begin
  If(IsGrf)Then Begin
   BarSpcHorRelief(VAB(Q).W.T.X1,VAB(Q).W.T.Y2,VAB(Q).W.T.X1+32,VAB(Q).W.Palette.Title);
   BarSpcHorRelief(VAB(Q).W.T.X1+33,VAB(Q).W.T.Y2,VAB(Q).W.T.X2,VAB(Q).W.Palette.Title);
  End
   Else
  WESetEndBarTxtX(VAB(Q).W,32,'�',VAB(Q).W.Palette.Title);
  WESetEndBarTxtX(VAB(Q).W,34,'Taille'+CStrBasic(VAB(Q).FileSize)+' octet(s)',VAB(Q).W.Palette.Title)
 End;
End;

{ �������������������������������������������������������������������������
  �                           Proc�dure VABRefreshData                    �
  �������������������������������������������������������������������������


  Propri�taire: VAB


  Description
  �����������

   Cette proc�dure permet de restaurer sp�cifiquement la partie des donn�es
  actuellement visible dans la fen�tre,  c'est-�-dire le contenu du fichier
  seulement sans tenir compte du reste de la fen�tre et des indicateurs.
}

Procedure VABRefreshData;
Var
 Handle:Hdl;
 L,J:Byte;
 Str:String;
 P:LongInt;
Begin
 WESetPosHome(Q.W);
 Handle:=FileOpen(Q.FileName,fmRead);
 If(Handle<>errHdl)Then Begin
  For J:=0to(Q.W.MaxY)do Begin
   P:=Q.PBnk^[J];
   __GetAbsFileTxtLn(Handle,P,Str);
(*   If Length(Str)>Q.W.MaxX+1Then L:=Q.W.MaxX+1 Else L:=P-Q.PBnk^[J]{Length(Str)+2};*)
   L:=Length(Str)+2;
   VABPutTxt(Q,Str);
   If(ClrEol)Then WEClrEol(Q.W);
   WELn(Q.W);
   Q.PBnk^[J+1]:=Q.PBnk^[J]+L
  End;
  FileClose(Handle);
  VABPutData(Q);
 End
End;

{ �������������������������������������������������������������������
  �                        Proc�dure VABReSize                      �
  �������������������������������������������������������������������


  Propri�taire: VAB
  Portabilit�:  Globale


  Description
  �����������

   Cette proc�dure permet de changer la taille d'une multi-fen�tre de
  visualisation de fichier ASCII en regard rapide.


  Remarque
  ��������

   � Elle  s'applique  seulement  � la m�thode �H�  de gestion multi-
     fen�tre et abolument pas  aux autres  ancienne m�thode demendant
     un  application  interne  pour  chaque objet  le restitution  de
     l'image...
}

Procedure VABReSize;Var Old:Long;N,T:String;Begin
 Old:=Q.PBnk^[0];N:=Q.FileName;T:=Q.Title;
 VABDone(Q);
 VABInitFrame(Q,N,T,X1,Y1,X2,Y2);
 Q.PBnk^[0]:=Old;
 VABRefresh(Q)
End;

{ �����������������������������������������������������������������������
  �                            Proc�dure VABRun                         �
  �����������������������������������������������������������������������


  Propri�taire: VAB
  Portabilit�:  Globale


  Description
  �����������

   Cette fonction attend une r�action de la part de l'utilisateur et agit
  en fonction de sa demande.  Si la demande ne concerne pas  l'objet,  la
  fonction retourne un code clavier correspondant  � la demande ayant �t�
  faite.
}

Function VABRun;Var K:Wd;Begin
 Repeat
  K:=WEReadk(VAB(Q).W);
  Case(K)of
   kbRBarMsUp:Begin;WaitRetrace;WaitRetrace;VABUp(VAB(Q))End;
   kbRBarMsDn:Begin;WaitRetrace;WaitRetrace;VABDn(VAB(Q))End;
   kbRBarMsPgUp:Begin;WaitRetrace;WaitRetrace;VABPgUp(VAB(Q))End;
   kbRBarMsPgDn:Begin;WaitRetrace;WaitRetrace;VABPgDn(VAB(Q))End;
   kbDn:VABDn(VAB(Q));
   kbPgDn:VABPgDn(VAB(Q));
   kbUp:VABUp(VAB(Q));
   kbPgUp:VABPgUp(VAB(Q))
   Else Begin VABRun:=K;Break;End
  End
 Until No
End;

{ ���������������������������������������������������������������������
  �                          Proc�dure VABUp                          �
  ���������������������������������������������������������������������


  Propri�taire: VAB


  Description
  �����������

   Cette proc�dure permet de retourner en arri�re dans la lecture d'une
  liste du texte ASCII.
}

Procedure VABUp;Var Handle:Hdl;L:Byte;P:Wd;Str:String;PL:Long;Begin
 If(Q.PBnk^[0]<=Q.Min)Then Exit;
 Handle:=FileOpen(Q.FileName,fmRead);
 If(Handle<>errHdl)Then Begin
  MoveRight(Q.PBnk^,Q.PBnk^[1],Q.SizeBnk-4);
  _WEScrollUp(Q.W);
  WESetPosHome(Q.W);
  P:=Q.W.MaxX+4;PL:=Q.PBnk^[1]-(P-1);
  If PL<0Then Begin;P:=Q.PBnk^[1]+1;PL:=0;End;
  Str:=GetBckFileTxtLn(Handle,P,PL);
{  If(Length(Str)>=Q.W.MaxX)Then L:=Q.W.MaxX+1+4 Else L:=Length(Str);}
  L:=Length(Str)+2;
  VABPutTxt(Q,Str);WEClrEOL(Q.W);
  Q.PBnk^[0]:=Q.PBnk^[1]-L-2;
  FileClose(Handle);
  If(Q.PBnk^[0]<Q.Min)Then Begin;Q.PBnk^[0]:=Q.Min;VABRefresh(Q)End Else VABPutData(Q)
 End;
End;

{���������������������������������������������������������������������������
 �                              Proc�dure Tableau                          �
 ���������������������������������������������������������������������������


 Description
 �����������

  Cette proc�dure permet � l'utilisateur de consulter les tableaux de format
 classique les plus en demande par les autres utilisateurs.
}

Procedure Tableau;
Const
 LenCategory=30;
 cPrixNobelChimie=$0001;
 cPrixNobelLitterature=$0002;
 cLait=$0003;
 cVitamine=$0004;
 cAmasStellaire=$0005;
 cComete=$0006;
 cStarLight=$0007;
 cStarDouble=$0008;
 cStarNear=$0009;
 cStarVariable=$000A;
 cGalaxies=$000B;
 cNebuleuses=$000C;
 cMonnaie=$000D;
 cChutes=$000E;
 cFleuves=$000F;
 cFosses=$0010;
 cLac=$0011;
 cMontagne=$0012;
 cOceanMer=$0013;
 cVaccin=$0014;
 cOlympiqueEte=$0015;
 cOlympiqueHiver=$0016;
 cAlpiniste=$0017;
 cExpositionUniversel=$0018;
 cGeantNature=$0019;
 cPrixFields=$001A;
 cPrixGoncours=$001B;
 cNobelEconomie=$001C;
 cNobelPaix=$001D;
 cNobelPhysique=$001E;
 cNobelPsychologie=$001F;
 cCroisade=$0020;
 cFetesReligieuses=$0021;
 cPapes=$0022;
 cPlastique=$0023;
 cMax=$23;
 CPath:Array[1..cMax]of PChar=(
  '\ATLAS\LISTES\PRIX\NOBEL\CHIMIE.LST',
  '\ATLAS\LISTES\PRIX\NOBEL\LITTERAT.LST',
  '\ATLAS\LISTES\ALIMENTA.IRE\LAIT.LST',
  '\ATLAS\LISTES\ALIMENTA.IRE\VITAMINE.LST',
  '\ATLAS\LISTES\ASTRONOM.IE\AMASTELL.LST',
  '\ATLAS\LISTES\ASTRONOM.IE\COMETE.LST',
  '\ATLAS\LISTES\ASTRONOM.IE\ETOIBRIL.LST',
  '\ATLAS\LISTES\ASTRONOM.IE\ETOIDOUB.LST',
  '\ATLAS\LISTES\ASTRONOM.IE\ETOIPROC.LST',
  '\ATLAS\LISTES\ASTRONOM.IE\ETOIVARI.LST',
  '\ATLAS\LISTES\ASTRONOM.IE\GALAXIES.LST',
  '\ATLAS\LISTES\ASTRONOM.IE\NEBULEUS.LST',
  '\ATLAS\LISTES\ECONOMIE\MONNAIE.LST',
  '\ATLAS\LISTES\GEOGRAPH.IE\CHUTES.LST',
  '\ATLAS\LISTES\GEOGRAPH.IE\FLEUVES.LST',
  '\ATLAS\LISTES\GEOGRAPH.IE\FOSSES.LST',
  '\ATLAS\LISTES\GEOGRAPH.IE\LAC.LST',
  '\ATLAS\LISTES\GEOGRAPH.IE\MONTAGNE.LST',
  '\ATLAS\LISTES\GEOGRAPH.IE\OCEANMER.LST',
  '\ATLAS\LISTES\MEDECINE\VACCIN.LST',
  '\ATLAS\LISTES\OLYMPIQU.E\ETE.LST',
  '\ATLAS\LISTES\OLYMPIQU.E\HIVER.LST',
  '\ATLAS\LISTES\LOISIR\ALPINIST.LST',
  '\ATLAS\LISTES\LOISIR\EXPOSITI.LST',
  '\ATLAS\LISTES\NATURE\GEANTNAT.LST',
  '\ATLAS\LISTES\PRIX\FIELDS.LST',
  '\ATLAS\LISTES\PRIX\GONCOURS.LST',
  '\ATLAS\LISTES\PRIX\NOBEL\ECONOMIE.LST',
  '\ATLAS\LISTES\PRIX\NOBEL\PAIX.LST',
  '\ATLAS\LISTES\PRIX\NOBEL\PHYSIQUE.LST',
  '\ATLAS\LISTES\PRIX\NOBEL\PSYCHOLO.LST',
  '\ATLAS\LISTES\RELIGION\CROISADE.LST',
  '\ATLAS\LISTES\RELIGION\FETES.LST',
  '\ATLAS\LISTES\RELIGION\PAPES.LST',
  '\ATLAS\LISTES\SCIENCE\PLASTIQU.LST'
 );
Var
 W:Window;
 L:LstMnu;
 P,K:Word;
 V:VAB;

 Procedure InitView;Begin
  VABInit(V,LenCategory+6,5,MaxXTxts-4,MaxYTxts-4,
          StrPas(PChr(CPath[LMGetVal(L)])),'');
 End;

Begin
 WEInit(W,2,3,MaxXTxts-2,MaxYTxts-2);
 WEPushWn(W);
 WEPutWnKrDials(W,'Tableaux & R�f�rences');
 SetShade(No);
 WESubList(W,0,1,LenCategory,wnMax-1,'Cat�gorie',L);
 LMPutSmallShade(L);
 ALAddStrWord(L.List,'Alpinismes',cAlpiniste);
 ALAddStrWord(L.List,'Amas stellaire (astronomie)',cAmasStellaire);
 ALAddStrWord(L.List,'Chute d''eau (g�ographie)',cChutes);
 ALAddStrWord(L.List,'Com�te (astronomie)',cComete);
 ALAddStrWord(L.List,'Croisade',cCroisade);
 ALAddStrWord(L.List,'�toile double (astronomie)',cStarDouble);
 ALAddStrWord(L.List,'�toile les plus brillante',cStarLight);
 ALAddStrWord(L.List,'�toile les plus proche',cStarNear);
 ALAddStrWord(L.List,'�toile variable (astronomie)',cStarVariable);
 ALAddStrWord(L.List,'Exposition Universel',cExpositionUniversel);
 ALAddStrWord(L.List,'F�tes religieuses',cFetesReligieuses);
 ALAddStrWord(L.List,'Fleuves (g�ographie)',cFleuves);
 ALAddStrWord(L.List,'Fosses oc�anique',cFosses);
 ALAddStrWord(L.List,'Galaxies (astronomie)',cGalaxies);
 ALAddStrWord(L.List,'G�ant de la nature',cGeantNature);
 ALAddStrWord(L.List,'Lac (g�ographie)',cLac);
 ALAddStrWord(L.List,'Lait',cLait);
 ALAddStrWord(L.List,'Monnaies',cMonnaie);
 ALAddStrWord(L.List,'Montagnes (g�ographie)',cMontagne);
 ALAddStrWord(L.List,'N�buleuses (astronomie)',cNebuleuses);
 ALAddStrWord(L.List,'Oc�an et mer (g�ographie)',cOceanMer);
 ALAddStrWord(L.List,'Olympique d''�t�',cOlympiqueEte);
 ALAddStrWord(L.List,'Olympique d''hiver',cOlympiqueHiver);
 ALAddStrWord(L.List,'Papes',cPapes);
 ALAddStrWord(L.List,'Plastique',cPlastique);
 ALAddStrWord(L.List,'Prix de Fields',cPrixFields);
 ALAddStrWord(L.List,'Prix de Goncours',cPrixGoncours);
 ALAddStrWord(L.List,'Prix Nobel Chimie',cPrixNobelChimie);
 ALAddStrWord(L.List,'Prix Nobel Litt�rature',cPrixNobelLitterature);
 ALAddStrWord(L.List,'Prix Nobel Paix',cNobelPaix);
 ALAddStrWord(L.List,'Prix Nobel Physique',cNobelPhysique);
 ALAddStrWord(L.List,'Prix Nobel Psychologie',cNobelPsychologie);
 ALAddStrWord(L.List,'Prix Nobel Syst�me �conomique',cNobelEconomie);
 ALAddStrWord(L.List,'Vaccin',cVaccin);
 ALAddStrWord(L.List,'Vitamine',cVitamine);
 LMRefresh(L);
 LMSelBar(L);
 P:=0;
 InitView;
 Repeat
  Case(P)of
   0:Begin
     K:=WEReadk(W);
     Case(K)of
     kbUp:If L.P>0Then Begin
      VABDone(V);
      LMkUp(L);
      InitView;
     End;
     kbDn:If(L.P<L.List.Count)Then Begin
      VABDone(V);
      LMkDn(L);
      InitView;
     End;
     kbPgDn,kbPgUp,kbHome,kbEnd:Begin
      VABDone(V);
      PushKey(K);
      PushKey(kbEsc);
      LMRun(L);
      InitView;
     End;
     kbTab,kbRight,kbLeft:Begin
      LMSelBarInactive(L);
      P:=1;
     End;
     kbEsc:Break;
    End;
   End;
   1:Case VABRun(V)of
    kbTab,kbCtrlLeft,kbCtrlRight,kbLeft,kbRight:Begin
     LMSelBar(L);
     P:=0;
    End;
    kbEsc:Break;
   End;
  End;
 Until No;
 VABDone(V);
 SetShade(Ya);
 WEDone(W);
End;

BEGIN
 InitSystems(suIsabel);
 InitMemManagers;
 CheckSVGA:=Ya;
 SetVideoModeDeluxe(vmTxtC132);
 __InitMouse;
 MakeMnu;
 AppInit('Damax',$19,MtxBleuet);
 Tableau;
 DoneLuxeVideo;
 DoneMemManagers;
END.