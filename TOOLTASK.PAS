Unit ToolTask;

INTERFACE

Uses Isatex;

Procedure TaskDialog(Q:HWins);

IMPLEMENTATION

Uses Systex,Memories,Systems,Dialex,Dials,Apps,MBCortex;

Function RBGetGlobalSize(Q:ArrayList):LongInt;
Var
 I:Integer;
 Size:LongInt;
 TSize:Word;
Begin
 Size:=0;
 ALSetPtr(Q,0);
 For I:=0to Q.Count-1do Begin
  ALGetCurrBuf(Q,TSize);
  If TSize and 7>0Then TSize:=(TSize and$FFF8)+8;
  Inc(Size,LongInt(TSize));
  ALNext(Q);
 End;
 RBGetGlobalSize:=Size;
End;

Function GDGetSizeRessource(Var Q:GlobalDrawApp):LongInt;
Var
 Size:LongInt;
 I:Integer;
Begin
 Size:=0;
 For I:=0to BFNumFiles(Q.Files)-1do Begin
  If Q.Image^[I].Output<>$FFThen Inc(Size,Q.Image^[I].Size);
 End;
 GDGetSizeRessource:=Size;
End;

Procedure TaskDialog(Q:HWins);
Var
 L:LstMnu;
 I:Integer;
 J:Byte;
 Size:Word;
 AppDynamicSize:LongInt;
 ResSize:LongInt;
 LT:ListTitle;
 Ptr:^InternalModel;
 PM:^ProgramsManagerApp Absolute Ptr;
 Edit:^EditorApp Absolute Ptr;
 FM:^FileManagerApp Absolute Ptr;
 Draw:^DrawEditApp Absolute Ptr;
 GloDraw:^GlobalDrawApp Absolute Ptr;
 Title:String;
Begin
 LMInitCenter(L,70,20,'Gestionnaire de tƒches',CurrKrs.Dialog.Env.List);
 LTInitWithWins(LT,0,0,L.W.MaxX,'Application|M‚moire|M‚moire dynamique|Ressource',L.W);
 WESetHomeLine(L.W,1);
 LTSetColumnSize(LT,0,L.W.MaxX-45);
 LTSetColumnSize(LT,1,12);
 LTSetColumnSize(LT,2,14);
 LTSetColumnSize(LT,3,17);
 LTRefresh(LT);
 For I:=0to Q.Lst.Count-1do Begin
  Q.CurrModel:=ALGetBuf(Q.Lst,I,Size);
  Title:=HTitleInLst(Q,L.W.MaxX-45,I);
  Ptr:=HPtr(Q);
  ResSize:=0;
  AppDynamicSize:=0;
  If(Ptr<>NIL)Then Case HModel(Q)of
   wnProgMan:AppDynamicSize:=RBGetGlobalSize(PM^.ML)+RBGetGlobalSize(PM^.L);
   wnEdit:Begin
    AppDynamicSize:=RBGetGlobalSize(Edit^.List)+
                    RBGetGlobalSize(Edit^.Processus)+
                    Edit^.DBInstr.SizeIndex+
                    Edit^.DBFunc.SizeIndex+
                    Edit^.DBMainWord.SizeIndex;
   End;
   wnFileManager:Begin
    For J:=0to 1do Begin
     Inc(AppDynamicSize,FM^.Panel[J].BF.SizeB+
                        BFNumFiles(FM^.Panel[J].BF)+
                        FM^.Panel[J].Ext.AssSize+
                        FM^.Panel[J].BufTree.SizePtr);
     Inc(ResSize,FM^.Panel[J].Res.Size+
                 FM^.Panel[J].RM.Size);
    End;
   End;
   wnDraw:Begin
    Inc(ResSize,Draw^.Canvas.Image.Size+
                Draw^.Canvas.Miroir.Size);
   End;
   wnGlobalDraw:Begin
    Inc(AppDynamicSize,GloDraw^.ImageSize);
    Inc(ResSize,GDGetSizeRessource(GloDraw^));
   End;
  End;
  ALAddStr(L.List,StrUSpc(Left(Title,L.W.MaxX-45),L.W.MaxX-45)+' '+
                  StrUSpc(WordToStr(Size)+' octets',13)+
                  StrUSpc(IntToStr(AppDynamicSize)+' octets',15)+
                  IntToStr(ResSize shr 9)+' Ko');
 End;
 LMRun(L);
 LMDone(L);
End;

END.