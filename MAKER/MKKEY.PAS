Program MakeKey;

Uses Systex,Systems,MBCortex;

Const
 ButtSwitch:Array[0..130]of ButtSwitchRec=(
  (KeyA:kbF1;   KeyB:kbNoKey;Option:cmdHelp),
  (KeyA:kbF2;   KeyB:kbNoKey;Option:cmdSave),
  (KeyA:kbF3;   KeyB:kbNoKey;Option:cmdOpenEdt),
  (KeyA:kbF4;   KeyB:kbNoKey;Option:cmdHexEdt),
  (KeyA:kbF5;   KeyB:kbNoKey;Option:cmdCpyFiles),
  (KeyA:kbF5;   KeyB:kbNoKey;Option:cmdZoom),
  (KeyA:kbF6;   KeyB:kbNoKey;Option:cmdNextWn),
  (KeyA:kbF7;   KeyB:kbNoKey;Option:cmdMkDir),
  (KeyA:kbF8;   KeyB:kbNoKey;Option:cmdDelFile),
  (KeyA:kbF9;   KeyB:kbNoKey;Option:cmdMoveFiles),
  (KeyA:kbF11;  KeyB:kbNoKey;Option:cmdCopyBlock),
  (KeyA:kbF12;  KeyB:kbNoKey;Option:cmdPasteOS2BlocFile),
  (KeyA:kbAltEqual;KeyB:kbNoKey;Option:cmdExec),
  (KeyA:kbAlt0; KeyB:kbNoKey;Option:cmdLstWn),
  (KeyA:kbAltP; KeyB:kbNoKey;Option:cmdPrint),
  (KeyA:kbAltX; KeyB:kbNoKey;Option:cmdExit),
  (KeyA:kbAltF1;KeyB:kbNoKey;Option:cmdChDsk),
  (KeyA:kbAltF2;KeyB:kbNoKey;Option:cmdChDsk2),
  (KeyA:kbAltF3;KeyB:kbNoKey;Option:cmdCloseWn),
  (KeyA:kbAltF4;KeyB:kbNoKey;Option:cmdTxtDblWord),
  (KeyA:kbAltF5;KeyB:kbNoKey;Option:cmdOutput),
  (KeyA:kbAltF7;KeyB:kbNoKey;Option:cmdOpenDrw),
  (KeyA:kbAltF8;KeyB:kbNoKey;Option:cmdTxtExposantWord),
  (KeyA:kbAltF9;KeyB:kbNoKey;Option:cmdCompile),
  (KeyA:kbAltF10;KeyB:kbNoKey;Option:cmdTxtInverseWord),
  (KeyA:kbCtrlA;KeyB:kbNoKey;Option:cmdLeft),
  (KeyA:kbCtrlB;KeyB:kbNoKey;Option:cmdTxtBoldWord),
  (KeyA:kbCtrlC;KeyB:kbCtrlA;Option:cmdCloseAllWn),
  (KeyA:kbCtrlC;KeyB:kbCtrlB;Option:cmdConv2Bas),
  (KeyA:kbCtrlC;KeyB:kbCtrlC;Option:cmdPgUp),
  (KeyA:kbCtrlC;KeyB:kbCtrlD;Option:cmdTxtDbl),
  (KeyA:kbCtrlC;KeyB:kbCtrlG;Option:cmdTxtBold),
  (KeyA:kbCtrlC;KeyB:kbCtrlI;Option:cmdTxtInverse),
  (KeyA:kbCtrlC;KeyB:kbCtrlK;Option:cmdConv2AC),
  (KeyA:kbCtrlC;KeyB:kbCtrlP;Option:cmdConv2Pas),
  (KeyA:kbCtrlC;KeyB:kbCtrlR;Option:cmdConv2RC),
  (KeyA:kbCtrlC;KeyB:kbCtrlS;Option:cmdCloseAllWnSaved),
  (KeyA:kbCtrlC;KeyB:kbCtrlT;Option:cmdTxtItalic),
  (KeyA:kbCtrlC;KeyB:kbCtrlU;Option:cmdTxtUnderln),
  (KeyA:kbCtrlD;KeyB:kbCtrlC;Option:cmdChDsk),
  (KeyA:kbCtrlD;KeyB:kbCtrlD;Option:cmdDskDoctor),
  (KeyA:kbCtrlD;KeyB:kbCtrlE;Option:cmdViewEdtDsk),
  (KeyA:kbCtrlD;KeyB:kbCtrlF;Option:cmdFormatDsk),
  (KeyA:kbCtrlD;KeyB:kbCtrlH;Option:cmdHexViewEdtDsk),
  (KeyA:kbCtrlD;KeyB:kbCtrlI;Option:cmdDskInfo),
  (KeyA:kbCtrlD;KeyB:kbCtrlO;Option:cmdDskOption),
  (KeyA:kbCtrlD;KeyB:kbCtrlS;Option:cmdDoctorSys),
  (KeyA:kbCtrlD;KeyB:kbCtrlV;Option:cmdDoctorVirus),
  (KeyA:kbCtrlD;KeyB:kbCtrlX;Option:cmdDelCurrCol),
  (KeyA:kbCtrlD;KeyB:kbCtrlY;Option:cmdDelCurrLn),
  (KeyA:kbCtrlD;KeyB:kbCtrlZ;Option:cmdDelCurrMatrix),
  (KeyA:kbCtrlE;KeyB:kbCtrlE;Option:cmd2Up),
  (KeyA:kbCtrlE;KeyB:kbCtrlH;Option:cmdHexEdt),
  (KeyA:kbCtrlE;KeyB:kbCtrlM;Option:cmdExecMacro),
  (KeyA:kbCtrlEnter;KeyB:kbNoKey;Option:cmdOpenFileAtCursor),
  (KeyA:kbCtrlEnter;KeyB:kbNoKey;Option:cmdFullScrn),
  (KeyA:kbCtrlF;KeyB:kbCtrlA;Option:cmdAssign),
  (KeyA:kbCtrlF;KeyB:kbCtrlB;Option:cmdAwk),
  (KeyA:kbCtrlF;KeyB:kbCtrlC;Option:cmdExec),
  (KeyA:kbCtrlF;KeyB:kbCtrlD;Option:cmdNewMDos),
  (KeyA:kbCtrlF;KeyB:kbCtrlE;Option:cmdDelFile),
  (KeyA:kbCtrlF;KeyB:kbCtrlF;Option:cmdNewFileManagers),
  (KeyA:kbCtrlF;KeyB:kbCtrlG;Option:cmdGrep),
  (KeyA:kbCtrlF;KeyB:kbCtrlL;Option:cmdCurrListFiles),
  (KeyA:kbCtrlF;KeyB:kbCtrlM;Option:cmdMkDir),
  (KeyA:kbCtrlF;KeyB:kbCtrlU;Option:cmdNewUnix),
  (KeyA:kbCtrlH;KeyB:kbCtrlM;Option:cmdHostMode),
  (KeyA:kbCtrlI;KeyB:kbCtrlC;Option:cmdCmosInfo),
  (KeyA:kbCtrlI;KeyB:kbCtrlI;Option:cmdInternalInfo),
  (KeyA:kbCtrlI;KeyB:kbCtrlM;Option:cmdInfoMCB),
  (KeyA:kbCtrlI;KeyB:kbCtrlS;Option:cmdSomaryInfo),
  (KeyA:kbCtrlK;KeyB:kbCtrlB;Option:cmdHomeBlock),
  (KeyA:kbCtrlK;KeyB:kbCtrlC;Option:cmdCopyBlock),
  (KeyA:kbCtrlK;KeyB:kbCtrlD;Option:cmdExit),
  (KeyA:kbCtrlK;KeyB:kbCtrlK;Option:cmdEndBlock),
  (KeyA:kbCtrlK;KeyB:kbCtrlS;Option:cmdSave),
  (KeyA:kbCtrlK;KeyB:kbCtrlV;Option:cmdMoveBlock),
  (KeyA:kbCtrlK;KeyB:kbCtrlW;Option:cmdWriteBlock),
  (KeyA:kbCtrlK;KeyB:kbCtrlZ;Option:cmdInsCurrCol),
  (KeyA:kbCtrlL;KeyB:kbNoKey;Option:cmdSearchAgain),
  (KeyA:kbCtrlL;KeyB:kbNoKey;Option:cmdOldOtherBoard),
  (KeyA:kbCtrlM;KeyB:kbCtrlH;Option:cmdHostMode),
  (KeyA:kbCtrlN;KeyB:kbCtrlG;Option:cmdNewGatt),
  (KeyA:kbCtrlO;KeyB:kbCtrlA;Option:cmdOpenAsm),
  (KeyA:kbCtrlO;KeyB:kbCtrlB;Option:cmdOpenButtEdt),
  (KeyA:kbCtrlO;KeyB:kbCtrlC;Option:cmdOpenSuperCalc),
  (KeyA:kbCtrlO;KeyB:kbCtrlD;Option:cmdOpenDrw),
  (KeyA:kbCtrlO;KeyB:kbCtrlE;Option:cmdOpenEuphoria),
  (KeyA:kbCtrlO;KeyB:kbCtrlF;Option:cmdOpenFortran),
  (KeyA:kbCtrlO;KeyB:kbCtrlG;Option:cmdOpenGatt),
  (KeyA:kbCtrlO;KeyB:kbCtrlK;Option:cmdOpenAC),
  (KeyA:kbCtrlO;KeyB:kbCtrlL;Option:cmdOpenCobol),
  (KeyA:kbCtrlO;KeyB:kbCtrlM;Option:cmdOpenMod),
  (KeyA:kbCtrlO;KeyB:kbCtrlN;Option:cmdOpenMacro),
  (KeyA:kbCtrlO;KeyB:kbCtrlP;Option:cmdOpenPas),
  (KeyA:kbCtrlO;KeyB:kbCtrlQ;Option:cmdOpenBas),
  (KeyA:kbCtrlO;KeyB:kbCtrlR;Option:cmdOpenRC),
  (KeyA:kbCtrlO;KeyB:kbCtrlW;Option:cmdOpenBasAppleII),
  (KeyA:kbCtrlO;KeyB:kbCtrlX;Option:cmdOpenBasCK64),
  (KeyA:kbCtrlO;KeyB:kbCtrlY;Option:cmdOpenBasCoco3),
  (KeyA:kbCtrlO;KeyB:kbCtrlZ;Option:cmdOpenC),
  (KeyA:kbCtrlP;KeyB:kbCtrlM;Option:cmdPlayMod),
  (KeyA:kbCtrlP;KeyB:kbCtrlS;Option:cmdStopPlayMod),
  (KeyA:kbCtrlQ;KeyB:kbCtrlC;Option:cmdEndTxt),
  (KeyA:kbCtrlQ;KeyB:kbCtrlS;Option:cmdHomeTxt),
  (KeyA:kbCtrlR;KeyB:kbNoKey;Option:cmdFMReRead),
  (KeyA:kbCtrlS;KeyB:kbNoKey;Option:cmdTxtDelSpc),
  (KeyA:kbCtrlT;KeyB:kbNoKey;Option:cmdTxtDelWord),
  (KeyA:kbCtrlU;KeyB:kbNoKey;Option:cmdTxtUnderlnWord),
  (KeyA:kbCtrlU;KeyB:kbNoKey;Option:cmdInverseBoard),
  (KeyA:kbCtrlV;KeyB:kbCtrlA;Option:cmdOpenView),
  (KeyA:kbCtrlX;KeyB:kbNoKey;Option:cmdCenterTxt),
  (KeyA:kbCtrlY;KeyB:kbNoKey;Option:cmdDelCurrLn),
  (KeyA:kbCtrlF1;KeyB:kbNoKey;Option:cmdModemDoctor),
  (KeyA:kbCtrlF2;KeyB:kbNoKey;Option:cmdEditMnu),
  (KeyA:kbCtrlF3;KeyB:kbNoKey;Option:cmdNewFileManagers),
  (KeyA:kbCtrlF6;KeyB:kbNoKey;Option:cmdTxtNormalWord),
  (KeyA:kbCtrlF7;KeyB:kbNoKey;Option:cmdSearch),
  (KeyA:kbCtrlF8;KeyB:kbNoKey;Option:cmdReplace),
  (KeyA:kbCtrlF9;KeyB:kbNoKey;Option:cmdRun),
  (KeyA:kbCtrlF10;KeyB:kbNoKey;Option:cmdOpenMacro),
  (KeyA:kbCtrlF10;KeyB:kbNoKey;Option:cmdCompress),
  (KeyA:kbShiftF2;KeyB:kbNoKey;Option:cmdLoader),
  (KeyA:kbShiftF3;KeyB:kbNoKey;Option:cmdOpenGatt),
  (KeyA:kbShiftF4;KeyB:kbNoKey;Option:cmdOpenView),
  (KeyA:kbShiftF5;KeyB:kbNoKey;Option:cmdCpySel),
  (KeyA:kbShiftF6;KeyB:kbNoKey;Option:cmdPreviousWn),
  (KeyA:kbShiftF7;KeyB:kbNoKey;Option:cmdTxtItalicWord),
  (KeyA:kbShiftF8;KeyB:kbNoKey;Option:cmdDelSel),
  (KeyA:kbShiftF9;KeyB:kbNoKey;Option:cmdDrawMode),
  (KeyA:kbShiftF10;KeyB:kbNoKey;Option:cmdExecMacro)
 );

BEGIN
 InitSystems(suIsabel);
 SetFile('ISABEL.KEY',0,SizeOf(ButtSwitch),ButtSwitch);
 DoneSystems;
END.