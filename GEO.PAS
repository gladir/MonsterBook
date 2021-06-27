Unit Geo;

INTERFACE

Uses
 Isatex;

Function  FindCity:String;
Function  FindCountry:String;
Function  GOInit(Var Context;X1,Y1,X2,Y2:Byte):Boolean;
Procedure GORefresh(Var Context);
Function  GORun(Var Context):Word;
Function  GOShowCity(Var Q:GeoApp;Const City:String;Pays:Word;Categorie:CategorieGeographique;Children:Boolean):Boolean;
Function  GOTitle(Var Context;Max:Byte):String;

IMPLEMENTATION

Uses
 Adele,Systex,SysInter,Memories,Systems,Video,Restex,Dialex,Dials,DialPlus,
 ResServD,ResServI,ToolDB,Mouse;

Procedure WEBarHor(Var W:Window;Y:Byte);
Var
 X:Byte;
Begin
 X:=WEGetRX1(W);
 BarHorDials(X,WEGetRY1(W)+Y,X+W.MaxX,W.CurrColor);
End;

Function GOSearchRegion(Var Q:GeoApp;Country,Province:SmallInt):String;
Var
 Data:Record
  ID:Word;
  NameF:String;
  NameA:String;
  Child:Word;
 End;
Begin
 GOSearchRegion:='';
 Case(Country)of
    500:DBOpenServerName(ChantalServer,'CHANTAL:/Country/Allemagne.Dat');
  20000:DBOpenServerName(ChantalServer,'CHANTAL:/Country/Angleterre.Dat');
   3900:DBOpenServerName(ChantalServer,'CHANTAL:/Country/Canada.Dat');
   4200:DBOpenServerName(ChantalServer,'CHANTAL:/Country/Chine.Dat');
   6660:DBOpenServerName(ChantalServer,'CHANTAL:/Country/EtatsUnis.Dat');
  25000:DBOpenServerName(ChantalServer,'CHANTAL:/Country/URSS.Dat');
   Else Exit;
 End;
 If DBLocateAbs(ChantalServer,0,Province,[])Then Begin
  DBReadRec(ChantalServer,Data);
  GOSearchRegion:=Data.NameF;
 End;
End;

Function GOReadAndSelect(Var Q:GeoApp;Var Buffer;Pays:Word):Boolean;
Label Finish;
Var
 FirstPos:LongInt;
 Country:SmallInt;
 K:Word;
 L:LstMnu;
 PBuffer:Pointer;
 PString:^String Absolute PBuffer;
 PSmallInt:^SmallInt Absolute PBuffer;
 S:String;
 DataNext:Array[0..1023]of Byte;
 Next:Record
  ID:LongInt;
  City:String;
 End Absolute DataNext;
 Curr:Record
  ID:LongInt;
  City:String;
 End Absolute Buffer;
Begin
 GOReadAndSelect:=True;
 FirstPos:=Q.Geo.CurrLine;
 DBReadRec(Q.Geo,Buffer);
 DBReadRec(Q.Geo,DataNext);
 If(Curr.City=Next.City)Then Begin
  LMInitCenter(L,60,15,'Choisissez une ville',CurrKrs.Dialog.Env.List);
  Q.Geo.CurrLine:=FirstPos;
  DBReadRec(Q.Geo,DataNext);
  Repeat
   S:=Next.City;
   PBuffer:=@DataNext;
   DBGotoColumn(Q.Geo,'Pays',PBuffer);
   Country:=PSmallInt^;
   If(Pays=0)or(Country=-1)or(Pays=Country)Then Begin
    If Country<>-1Then Begin
     If DBLocateAbsIM(Q.Pays,0,Country,[])Then Begin
      Inc(PtrRec(Q.Pays.CurrRec.Ptr).Ofs,5);
      AddStr(S,', '+Q.Pays.CurrRec.Str^);
     End;
    End;
    PBuffer:=@DataNext;
    DBGotoColumn(Q.Geo,'Province',PBuffer);
    If PSmallInt^<>-1Then AddStr(S,', '+GOSearchRegion(Q,Country,PSmallInt^));
    PBuffer:=@DataNext;
    DBGotoColumn(Q.Geo,'Region',PBuffer);
    If PString^<>''Then AddStr(S,', '+PString^);
    If Not ALAddStrLong(L.List,S,FirstPos)Then Break;
   End;
   FirstPos:=Q.Geo.CurrLine;
   DBReadRec(Q.Geo,DataNext);
  Until Not CmpLeft(StrUp(Next.City),StrUp(Curr.City));
  K:=LMRun(L);
  If K=0Then Begin
   GOReadAndSelect:=False;
   Goto Finish;
  End;
  DBMoveTo(Q.Geo,LMGetVal(L));
  DBReadRec(Q.Geo,Buffer);
Finish:
  LMDone(L);
 End;
End;

Procedure GOPutIcon(Var Q:GeoApp;X1,Y1:Byte);
Var
 X:XInf;
 GX1,GY1:Word;
Begin
 GX1:=(WEGetRX1(Q.W)+X1)shl 3;
 GY1:=GetRawY(WEGetRY1(Q.W)+Y1);
 FillClr(X,SizeOf(X));
 X.Output:=irmConvMem;
 X.Size:=621;
 RIPutImage(X,GX1,GY1,32,32);
End;

Procedure GOShowCurrLine(Var QX;Var Context);Far;
Var
 Q:GeoApp Absolute Context;
 PBuffer:Pointer;
 PString:^String Absolute PBuffer;
 Buffer:Array[0..1023]of Byte;
Begin
 DBMoveTo(Q.R.DB,Q.R.P);
 DBReadRec(Q.R.DB,Buffer);
 PBuffer:=@Buffer;
 DBGotoColumnAbs(Q.R.DB,1,PBuffer);
 GOShowCity(Q,PString^,0,Ville,True);
End;

Procedure GORefresh(Var Context);
Var
 Q:GeoApp Absolute Context;
Begin
 WEPutWnKrDials(Q.W,'Atlas');
 WEBar(Q.W);
 If(Q.Global)Then Begin
  WECloseIcon(Q.W);
  WEZoomIcon(Q.W);
  WEPutWn(Q.R.W,Q.R.W.Title,CurrKrs.Dialog.Env.List);
  WEPutBarMsRight(Q.R.W);
  DBLShowList(Q.R);
  GOShowCurrLine(Q.R,Q);
 End;
End;

Function GOSearchCity(Var Q:GeoApp;ID:LongInt):String;
Var
 City:Record
  ID:LongInt;
  Name:String;
  Buffer:Array[0..768]of Byte;
 End;
Begin
 If DBLocateAbs(Q.Geo,0,ID,[])Then Begin
  DBReadRec(Q.Geo,City);
  GOSearchCity:=City.Name;
 End
  Else
 GOSearchCity:='Inconnu';
End;

{⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ‹
 ≥                             Fonction ArcCos                          €
 ¿‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹€


 Description
 ÕÕÕÕÕÕÕÕÕÕÕ

  Cette fonction permet de retourne l'arc cosinusoãdale d'un nombre radian.


 Remarques
 ÕÕÕÕÕÕÕÕÕ

  ˛ Les nombres excÇdants les valeurs -1 et +1 cause un ÆRuntime ErrorØ.
  ˛ Retourne seulement les nombres principales (0 Ö pi en radians),
    (0¯ Ö 180¯).
}

Function ArcCos(InValue:Real):Real;Near;
Var
 Res:Real;
Begin
 If InValue=0.0Then ArcCos:=PI/2.0
  Else
 Begin
  If InValue=0.0Then Res:=0.0
                Else Res:=Arctan(Sqrt(1-InValue*InValue)/InValue);
  If InValue<0.0Then ArcCos:=Res+PI
                Else ArcCos:=Res;
 End;
End;

Type
 CoordStruct=Record
  Latitude:Byte;
  LatiDeg:Byte;
  LatiDirection:Char;
  Longitude:Byte;
  LongDeg:Byte;
  LongDirection:Char;
 End;

Function CoordToDeltaKm(Const Q1,Q2:CoordStruct):Real;Near;
Var
 a1,b1,a2,b2:Real;
Begin
 a1:=(Q1.Latitude+(Q1.LatiDeg/60))*PI/180;
 If Q1.LatiDirection='N'Then a1:=-a1;
 b1:=(Q1.Longitude+(Q1.LongDeg/60))*PI/180;
 If Q1.LongDirection='S'Then b1:=-b1;
 a2:=(Q2.Latitude+(Q2.LatiDeg/60))*PI/180;
 If Q2.LatiDirection='N'Then a2:=-a2;
 b2:=(Q2.Longitude+(Q2.LongDeg/60))*PI/180;
 If Q2.LongDirection='S'Then b2:=-b2;
 CoordToDeltaKm:=ArcCos(Cos(a1)*Cos(b1)*Cos(a2)*Cos(b2)+Cos(a1)*Sin(b1)*Cos(a2)*Sin(b2)+Sin(a1)*Sin(a2))*6378.0;
End;

Function GOInitRaw(Var Context;X1,Y1,X2,Y2:Byte):Boolean;
Var
 Q:GeoApp Absolute Context;
Begin
 GOInitRaw:=True;
 FillClr(Q,SizeOf(Q));
 WEInit(Q.W,X1,Y1,X2,Y2);
End;

Function GOInit(Var Context;X1,Y1,X2,Y2:Byte):Boolean;
Var
 Q:GeoApp Absolute Context;
Begin
 GOInit:=GOInitRaw(Context,X1,Y1,X2,Y2);
 GORefresh(Q);
 WECloseIcon(Q.W);
 WEZoomIcon(Q.W);
 DBLOpen(Q.R,X1+1,Y1+2,X1+25,Y2-2,'Ville',MaltePath+'DATA\GEO.DAT','',1);
 DBLHome(Q.R);
 GOShowCurrLine(Q.R,Q);
 Q.Global:=True;
End;

Function GORun(Var Context):Word;
Var
 Q:GeoApp Absolute Context;
 K:Word;
Begin
 Q.R.ShowCurrLine:=GOShowCurrLine;
 Q.R.Context:=@Q;
 K:=DBLRun(Q.R);
 Case(K)of
  kbMouse:K:=WEBackReadk(Q.W);
 End;
 GORun:=K;
End;

Function GOShowCity(Var Q:GeoApp;Const City:String;Pays:Word;Categorie:CategorieGeographique;Children:Boolean):Boolean;
Var
 PBuffer,PBufferT:Pointer;
 PString:^String Absolute PBuffer;
 PInteger:^LongInt Absolute PBuffer;
 PSmallInt:^SmallInt Absolute PBuffer;
 PCoord:^CoordStruct Absolute PBuffer;
 PCoordT:^CoordStruct Absolute PBufferT;
 ConvL:LongInt Absolute ConvP;
 S:String;
 DataTarget:Array[0..2047]of Byte;
 Data:Array[0..2047]of Byte;
  {
   ID             INTEGER,
   Ville          VARCHAR,
   Province       VARCHAR,
   Region         VARCHAR,
   Popul76        INTEGER,
   Popul80        INTEGER,
   CodeTelReg     SMALLINT,
   Pays           SMALLINT,
   Latitude       BYTE,
   LatiDeg        BYTE,
   LatiDirection  CHAR,
   Longitude      BYTE,
   LongDeg        BYTE,
   LongDirection  CHAR,
  }

 Function FindDelta(Const S:String):String;Begin
  FindDelta:='';
  If DBLocateAbs(Q.Geo,1,S,[soNoCaseSensitive])Then Begin
   If Not GOReadAndSelect(Q,DataTarget,0)Then Exit;
   PBufferT:=@DataTarget;
   DBGotoColumn(Q.Geo,'Latitude',PBufferT);
   FindDelta:=IntToStr(Trunc(CoordToDeltaKm(PCoord^,PCoordT^)))+'Km';
  End;
 End;

Begin
 GOShowCity:=False;
 Q.Mode:=Categorie;
 DBOpenServerName(ChantalServer,'CHANTAL:/Country/Pays.Dat');
 DBCopyToMemory(ChantalServer,Q.Pays);
 DBInit(Q.Geo,MaltePath+'DATA\GEO.DAT');
 If(Categorie=Ville)Then Begin
  If Not(Children)Then Begin
   If DBLocateAbs(Q.Geo,1,City,[soNoCaseSensitive])Then Begin
    If Not GOReadAndSelect(Q,Data,Pays)Then Exit;
   End
    Else
   Begin
    ErrMsgOk('Ville non trouvÇ.');
    Exit;
   End;
   WEInitO(Q.W,60,21);
   WEPushWn(Q.W);
   GORefresh(Q);
  End
   Else
  Begin
   DBMoveTo(Q.Geo,Q.R.P);
   DBReadRec(Q.Geo,Data);
   {WEClrWnBorder(Q.W,28,1,wnMax,wnMax);}
   Inc(Q.W.T.X1,28);
   Dec(Q.W.MaxX,28);
  End;
  GOShowCity:=True;
  PBuffer:=@Data;
  DBGotoColumn(Q.Geo,'Ville',PBuffer);
  WEPutTxtXY(Q.W,0,1,'Ville: '+PString^);
  If(Children)Then WEClrEol(Q.W);
  WEBarHor(Q.W,2);
  PBuffer:=@Data;
  DBGotoColumn(Q.Geo,'Pays',PBuffer);
  Q.Country:=PSmallInt^;
  If DBLocateAbsIM(Q.Pays,0,Q.Country,[])Then Begin
   Inc(PtrRec(Q.Pays.CurrRec.Ptr).Ofs,5);
   S:=Q.Pays.CurrRec.Str^;
   Inc(PtrRec(Q.Pays.CurrRec.Ptr).Ofs,Length(S)+1);
   Q.IDCountry:=Q.Pays.CurrRec.SmallInt^;
  End
   Else
  S:='';
  WEPutTxtXY(Q.W,0,3,'Pays: '+S);
  If(Children)Then WEClrEol(Q.W);
  PBuffer:=@Data;
  DBGotoColumn(Q.Geo,'Province',PBuffer);
  If Q.Country=6660Then S:='êtat: '
                   Else S:='Province: ';
  WEPutTxtXY(Q.W,0,4,S+GOSearchRegion(Q,Q.Country,PSmallInt^));
  If(Children)Then WEClrEol(Q.W);
  PBuffer:=@Data;
  DBGotoColumn(Q.Geo,'Region',PBuffer);
  WEPutTxtXY(Q.W,0,5,'RÇgion: '+PString^);
  If(Children)Then WEClrEol(Q.W);
  WEBarHor(Q.W,6);
  PBuffer:=@Data;
  DBGotoColumn(Q.Geo,'CodeTelReg',PBuffer);
  If PSmallInt^<0Then S:='Inconnu'
                 Else S:=IntToStr(PSmallInt^);
  WEPutTxtXY(Q.W,0,7,'Indicatif de tÇlÇphone rÇgional: '+S);
  If(Children)Then WEClrEol(Q.W);
  WEBarHor(Q.W,8);
  PBuffer:=@Data;
  DBGotoColumn(Q.Geo,'Popul76',PBuffer);
  If PInteger^<0Then S:='Inconnu'
                Else S:=CStr(PInteger^);
  WEPutTxtXY(Q.W,0,9,'Population recensÇ en 1976: '+S+' habitant(s)');
  If(Children)Then WEClrEol(Q.W);
  PBuffer:=@Data;
  DBGotoColumn(Q.Geo,'Popul80',PBuffer);
  If PInteger^<0Then S:='Inconnu'
                Else S:=CStr(PInteger^);
  WEPutTxtXY(Q.W,0,10,'Population recensÇ en 1980: '+S+' habitant(s)');
  If(Children)Then WEClrEol(Q.W);
  WEBarHor(Q.W,11);
  PBuffer:=@Data;
  DBGotoColumn(Q.Geo,'Latitude',PBuffer);
  If PCoord^.Longitude or PCoord^.Latitude<>0Then Begin
   S:=WordToStr(PCoord^.Latitude)+' '+WordToStr(PCoord^.LatiDeg)+PCoord^.LatiDirection+' '+
      WordToStr(PCoord^.Longitude)+' '+WordToStr(PCoord^.LongDeg)+PCoord^.LongDirection;
   WEPutTxtXY(Q.W,0,12,'CoordonnÇe: '+S);
   If(Children)Then WEClrEol(Q.W);
   WEPutTxtXY(Q.W,0,13,'Distance avec Paris, France: '+FindDelta('Paris'));
   If(Children)Then WEClrEol(Q.W);
   WEPutTxtXY(Q.W,0,14,'Distance avec New York, êtats-Unis: '+FindDelta('New York'));
   If(Children)Then WEClrEol(Q.W);
   WEPutTxtXY(Q.W,0,15,'Distance avec Hong Kong, Chine: '+FindDelta('Hong Kong'));
   If(Children)Then WEClrEol(Q.W);
  End;
  If Q.IDCountry<>-1Then Begin
   DBOpenServerName(ChantalServer,'CHANTAL:/Country/Country.Dat');
   If DBLocateAbs(ChantalServer,0,Q.IDCountry,[])Then Begin
    DBReadRec(ChantalServer,Data);
    ConvP:=@Data;
    DBGotoColumnAbs(ChantalServer,5,Pointer(ConvP));
    If ConvL<>0Then Begin
     ASM
      ADD Word Ptr ConvP,4+11
     END;
     GOPutIcon(Q,Q.W.MaxX-4,3);
    End;
   End;
  End;
  If Not(Children)Then Begin
   WEGetkHorDn(Q.W,'Correcte');
   WEDone(Q.W);
  End
   Else
  Begin
   Dec(Q.W.T.X1,28);
   Inc(Q.W.MaxX,28);
  End;
 End
  Else
 Begin
  WEInitO(Q.W,60,12);
  WEPushWn(Q.W);
  GORefresh(Q);
  If DBLocateAbsIM(Q.Pays,2,City,[soNoCaseSensitive])Then Begin
   GOShowCity:=True;
   DBMoveTo(ChantalServer,Q.Pays.Pos);
   DBReadRec(ChantalServer,Data);
   PBuffer:=@Data;
   DBGotoColumnAbs(ChantalServer,2,PBuffer);
   WEPutTxtXY(Q.W,0,1,'Pays: '+PString^);
   WEBarHor(Q.W,2);
   PBuffer:=@Data;
   DBGotoColumn(ChantalServer,'Superficie',PBuffer);
   WEPutTxtXY(Q.W,0,3,'Superficie: '+CStr(PInteger^)+' km˝');
   PBuffer:=@Data;
   DBGotoColumn(ChantalServer,'Capitale',PBuffer);
   WEPutTxtXY(Q.W,0,4,'Capitale: '+GOSearchCity(Q,PInteger^));
   WEBarHor(Q.W,5);
   PBuffer:=@Data;
   DBGotoColumn(ChantalServer,'Pop79',PBuffer);
   WEPutTxtXY(Q.W,0,6,'Population en 1979: '+CStr(PInteger^)+' habitant(s)');
  End;
  WEGetkHorDn(Q.W,'Correcte');
  WEDone(Q.W);
 End;
 DBDone(Q.Geo);
 DBDispose(Q.Pays);
End;

Function FindCity:String;
Var
 FormFindCity:Record
  Name:String;
  IDCountry:Word;
 End;
 Name:String;
 Q:GeoApp;
Begin
 FillClr(FormFindCity,SizeOf(FormFindCity));
 If ExecuteAppDPU(137,FormFindCity)Then Begin
  GOInitRaw(Q,0,0,GetMaxXTxts,GetMaxYTxts);
  GOShowCity(Q,FormFindCity.Name,FormFindCity.IDCountry,Ville,False);
 End;
 FindCity:=Name;
End;

Function FindCountry:String;
Var
 Name:String;
 Q:GeoApp;
Begin
 Name:='';
 If(_WinInp(50,'Recherche un pays','Effectue une recherche dans l''atlas gÇographique',False,Name)=kbYes)Then Begin
  GOInitRaw(Q,0,0,GetMaxXTxts,GetMaxYTxts);
  GOShowCity(Q,Name,0,Pays,False);
 End;
 FindCountry:=Name;
End;

Function GOTitle(Var Context;Max:Byte):String;Begin
 GOTitle:='Atlas';
End;

END.