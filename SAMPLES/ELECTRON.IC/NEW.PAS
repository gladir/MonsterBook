Program NouveauDessinElectronique;

Uses Adele,Dialex,Systex,Systems,Video,Mouse,Isatex,Dials,Apps,
     ResServD,TechDraw;

Const
 NumApp=0;
 LstHWin:Array[0..NumApp]of HWin=(
 (SerialNumber:1;
   Init:TDNewElectronic;
   Load:TDOpen;
   Run:NIL;
   Done:TDDone;
   Refresh:TDRefresh;
   Save:TDSave;
   SaveAs:TDSaveAs;
   SizeOfQ:SizeOf(TechDrawApp);
   Title:TDTitle;
   ReSize:NIL;
   NumXTexts:0;
   NumYTexts:0;
   OnDeactivate:NIL;
   Move2:NIL;
   OnWaiting:TDBackOperation;
   OnKeyPress:NIL;
   OnKeyDown:TDOnKeyDown;
   OnKeyUp:NIL;
   OnMouseDown:TDOnMouseDown;
   OnMouseUp:NIL;
   OnMouseMove:TDOnMouseMove;
   OnMouseControl:TDOnMouseControl));

Var
 I:Byte;
 Windows:HWins;
 Q:TechDrawApp;

BEGIN
 InitSystems(suIsabel);
 InitMemManagers;
 DBInitServer(ChantalServer,MaltePath+'DATA\CHANTAL.DAT');
 SetVideoModeDeluxe({vmGrf800x600c65536}vmGrf640x480c65536);
 _InitEnv(MtxOs2Win95);
 HInit(Windows);
 For I:=0to(NumApp)do HAddNewModel(Windows,LstHWin[I]);
 __InitMouse;
 HNew(Windows,1);
 HRun(Windows);
{ HDone(Windows);}
 SetVideoMode(vmTxtDef);
 DoneMemManagers;
END.