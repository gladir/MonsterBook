program Mbw;

uses
  Forms,
  WinProcs,
  Mbwunit in 'MBWUNIT.PAS' {MainForm},
  Systex in 'SYSTEX.PAS',
  Adele in 'ADELE.PAS',
  Video in 'VIDEO.PAS',
  Systems in 'SYSTEMS.PAS',
  Dials in 'DIALS.PAS',
  ToolTerm in 'TOOLTERM.PAS',
  Isatex in 'ISATEX.PAS',
  Mbwabout in 'MBWABOUT.PAS' {AboutBox},
  Mbwinfo in 'MBWINFO.PAS' {InfoSomary},
  Mbwedit in 'MBWEDIT.PAS' {EditorWin};

{$R *.RES}

{Var P:Prompt;{Attr:Byte;}

BEGIN
  InitSystems(suIsabel);
{  Application.Title := 'MonsterBook pour Windows';}
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TInfoSomary, InfoSomary);
  Application.CreateForm(TAboutBox, AboutBox);
(*  DC:={GetDC(Application.Handle)}{MainForm.Canvas.Handle}0;*)
(*  StrPCopy(@Adele.WindowTitle,'MonsterBook pour Windows');*)
{  Attr:=$CE;
  SetBkColor(DC,  WinProcs.RGB(DefRGB[Attr shr 4].R,DefRGB[Attr shr 4].G,DefRGB[Attr shr 4].B));
  SetTextColor(DC,WinProcs.RGB(DefRGB[Attr and$F].R,DefRGB[Attr and$F].G,DefRGB[Attr and$F].B));
  TextOut(DC,100,100,'Nouveau salaud',15);}
{  PutTxtXY(0,0,'Nouveau Salaud!',$CE);
  WriteLn('Roger?');}
{  MainForm.Canvas.MoveTo(0,0);
  MainForm.Canvas.Pen.Color:=0;
  MainForm.Canvas.TextOut(0,0,'Nouveau Salut!');}
  {Pixel[0,0]:=clRed;}
{  InitVideo;
  PutTxtXY(0,0,'Salut',$CF);
  PutTxtXY(1,1,HexWord2Str(Systems.ReadKey),$E0);
  InitEnv;
  ErrMsgOk('C''est une erreur!');
  DialogMsgOk('Ceci est un teste!');}
{  PDInit(P,0,0,MaxXTxts,MaxYTxts);
{  PDRun(P);
  PDDone(P);}
  Application.Run;
END.
