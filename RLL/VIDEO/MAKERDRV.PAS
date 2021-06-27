Program MakerDriver;

{$D-,L-,Y-}

Uses D2v2,D3v2,Drv2,D2v4,D3v4,Drv4,{D2v400,D3v400,Drv400,D2v480,D3v480,Drv480,}
 D2v16,D3v16,Drv16,{D2v19,D3v19,Drv19,}DrvBios,D2vGS640,D3vGS640,DrvGS640,
{ D2vSVGA,DrvSVGA3,DrvSVGA,}D2vTxt,D3vTxt,DrvTxt,{D2vVesa,D3vVesa,DrvVesa,}
{ V2A256,V3A256,VGA256,}Dos,Systems,Memories,Systex;

Var I,PhysVideo,DataVideo:Word;

Const Max=15;
X:Array[0..Max]of Record Name:String[12];Drv:Pointer;Phys,Data,Size:Wd;End=(
 (Name:'DRV16.DRV';Drv:@_Driver16;Phys:Ofs(Drv16.PhysVideo);Data:Ofs(Drv16.DataVideo);Size:Ofs(EndDriver16)+1),
 (Name:'D2V16.DRV';Drv:@D2V16._Driver16;Phys:Ofs(D2v16.PhysVideo);Data:Ofs(D2v16.DataVideo);Size:Ofs(D2v16.EndDriver16)+1),
 (Name:'D3V16.DRV';Drv:@D3V16._Driver16;Phys:Ofs(D3v16.PhysVideo);Data:Ofs(D3v16.DataVideo);Size:Ofs(D3v16.EndDriver16)+1),
{ (Name:'DRV19.DRV';Drv:@_Driver19;Phys:Ofs(Drv19.PhysVideo);Data:Ofs(Drv19.DataVideo);Size:Ofs(EndDriver19)+1),
 (Name:'D2V19.DRV';Drv:@D2V19._Driver19;Phys:Ofs(D2v19.PhysVideo);Data:Ofs(Drv19.DataVideo);Size:Ofs(D2V19.EndDriver19)+1),
 (Name:'D3V19.DRV';Drv:@D3V19._Driver19;Phys:Ofs(D3v19.PhysVideo);Data:Ofs(Drv19.DataVideo);Size:Ofs(D3V19.EndDriver19)+1),}
 (Name:'DRV2.DRV';Drv:@_Driver2;Phys:Ofs(Drv2.PhysVideo);Data:Ofs(Drv2.DataVideo);Size:Ofs(EndDriver2)+1),
 (Name:'D2V2.DRV';Drv:@D2V2._Driver2;Phys:Ofs(D2v2.PhysVideo);Data:Ofs(D2v2.DataVideo);Size:Ofs(D2v2.EndDriver2)+1),
 (Name:'D3V2.DRV';Drv:@D3V2._Driver2;Phys:Ofs(D3v2.PhysVideo);Data:Ofs(D3v2.DataVideo);Size:Ofs(D3v2.EndDriver2)+1),
 (Name:'DRV4.DRV';Drv:@_Driver4;Phys:Ofs(Drv4.PhysVideo);Data:Ofs(Drv4.DataVideo);Size:Ofs(EndDriver4)+1),
 (Name:'D2V4.DRV';Drv:@D2V4._Driver4;Phys:Ofs(D2v4.PhysVideo);Data:Ofs(D2v4.DataVideo);Size:Ofs(D2V4.EndDriver4)+1),
 (Name:'D3V4.DRV';Drv:@D3V4._Driver4;Phys:Ofs(D3v4.PhysVideo);Data:Ofs(D3v4.DataVideo);Size:Ofs(D3V4.EndDriver4)+1),
{ (Name:'DRV400.DRV';Drv:@_Driver400;Phys:Ofs(Drv400.PhysVideo);Data:Ofs(Drv400.DataVideo);Size:Ofs(EndDriver400)+1),
 (Name:'D2V400.DRV';Drv:@D2V400._Driver400;Phys:Ofs(D2v400.PhysVideo);
                    Data:Ofs(D2v400.DataVideo);Size:Ofs(D2V400.EndDriver400)+1),
 (Name:'D3V400.DRV';Drv:@D3V400._Driver400;Phys:Ofs(D3v400.PhysVideo);
                    Data:Ofs(D3v400.DataVideo);Size:Ofs(D3V400.EndDriver400)+1),
 (Name:'DRV480.DRV';Drv:@_Driver480;Phys:Ofs(Drv480.PhysVideo);Data:Ofs(Drv480.DataVideo);Size:Ofs(EndDriver480)+1),
 (Name:'D2V480.DRV';Drv:@D2V480._Driver480;Phys:Ofs(D2v480.PhysVideo);
                    Data:Ofs(D2v480.DataVideo);Size:Ofs(D2V480.EndDriver480)+1),
 (Name:'D3V480.DRV';Drv:@D3V480._Driver480;Phys:Ofs(D3v480.PhysVideo);
                    Data:Ofs(D3v480.DataVideo);Size:Ofs(D3V480.EndDriver480)+1),}
 (Name:'DRVBIOS.DRV';Drv:@_DriverBios;Phys:Ofs(DrvBios.PhysVideo);Data:Ofs(DrvBios.DataVideo);Size:Ofs(EndDriverBios)+1),
 (Name:'DRVGS640.DRV';Drv:@_DriverGS640;Phys:Ofs(DrvGS640.PhysVideo);Data:Ofs(DrvGS640.DataVideo);Size:Ofs(EndDriverGS640)+1),
 (Name:'D2VGS640.DRV';Drv:@D2VGS640._DriverGS640;Phys:Ofs(D2vGS640.PhysVideo);
                      Data:Ofs(D2vGS640.DataVideo);Size:Ofs(D2VGS640.EndDriverGS640)+1),
 (Name:'D3VGS640.DRV';Drv:@D3VGS640._DriverGS640;Phys:Ofs(D3vGS640.PhysVideo);
                      Data:Ofs(D3vGS640.DataVideo);Size:Ofs(D3VGS640.EndDriverGS640)+1),
{ (Name:'DRVSVGA.DRV';Drv:@_DriverSVGA;Phys:Ofs(DrvSVGA.PhysVideo);Data:Ofs(DrvSVGA.DataVideo);Size:Ofs(EndDriverSVGA)+1),
 (Name:'D2VSVGA.DRV';Drv:@D2VSVGA._DriverSVGA;Phys:Ofs(D2vSVGA.PhysVideo);
                     Data:Ofs(D2vSVGA.DataVideo);Size:Ofs(D2VSVGA.EndDriverSVGA)+1),
 (Name:'DRVSVGA3.DRV';Drv:@_DriverSVGA3;Phys:Ofs(DrvSVGA3.PhysVideo);Data:Ofs(DrvSVGA3.DataVideo);Size:Ofs(EndDriverSVGA3)+1),}
 (Name:'DRVTXT.DRV';Drv:@_DriverTxt;Phys:Ofs(DrvTxt.PhysVideo);Data:Ofs(DrvTxt.DataVideo);Size:Ofs(EndDriverTxt)+1),
 (Name:'D2VTXT.DRV';Drv:@D2VTxt._DriverTxt;Phys:Ofs(D2vTxt.PhysVideo);
                    Data:Ofs(D2vTxt.DataVideo);Size:Ofs(D2vTxt.EndDriverTxt)+1),
 (Name:'D3VTXT.DRV';Drv:@D3VTxt._DriverTxt;Phys:Ofs(D3vTxt.PhysVideo);
                    Data:Ofs(D3vTxt.DataVideo);Size:Ofs(D3vTxt.EndDriverTxt)+1){,
 (Name:'DRVVESA.DRV';Drv:@_DriverVesa;Phys:Ofs(DrvVesa.PhysVideo);Data:Ofs(DrvVesa.DataVideo);Size:Ofs(EndDriverVesa)+1),
 (Name:'D2VVESA.DRV';Drv:@D2VVesa._DriverVesa;Phys:Ofs(D2vVesa.PhysVideo);
                     Data:Ofs(D2vVesa.DataVideo);Size:Ofs(D2VVesa.EndDriverVesa)+1),
 (Name:'D3VVESA.DRV';Drv:@D3VVesa._DriverVesa;Phys:Ofs(D3vVesa.PhysVideo);
                     Data:Ofs(D3vVesa.DataVideo);Size:Ofs(D3VVesa.EndDriverVesa)+1),
 (Name:'VGA256.DRV';Drv:@_DriverVGA256;Phys:Ofs(VGA256.PhysVideo);Data:Ofs(VGA256.DataVideo);Size:Ofs(EndDriverVGA256)+1),
 (Name:'V2A256.DRV';Drv:@V2A256._DriverVGA256;Phys:Ofs(VGA256.PhysVideo);
                    Data:Ofs(V2A256.DataVideo);Size:Ofs(V2A256.EndDriverVGA256)+1),
 (Name:'V3A256.DRV';Drv:@V3A256._DriverVGA256;Phys:Ofs(VGA256.PhysVideo);
                    Data:Ofs(V3A256.DataVideo);Size:Ofs(V3A256.EndDriverVGA256)+1)}
);

BEGIN
 InitSystems(suIsabel);
 WriteLn('Maker de pilote vid‚o du Malte Genesis V: AdŠle');
 WriteLn(MultChr('Ä',79));
 WriteLn;
 PhysVideo:=X[0].Phys;DataVideo:=X[0].Data;
 For I:=0to(Max)do Begin
  If PtrRec(X[I].Drv).Ofs<>0Then Begin
   WriteLn(X[I].Name:12,': ****** Erreur de position de d‚marrage: ',PtrRec(X[I].Drv).Ofs);
   Halt;
  End;
  If(X[I].Phys<>PhysVideo)Then Begin
   WriteLn(X[I].Name:12,': ****** Erreur de position de ®PhysVideo¯: ',X[I].Phys);
   Halt;
  End;
  If(X[I].Data<>DataVideo)Then Begin
   WriteLn(X[I].Name:12,': ****** Erreur de position de ®DataVideo¯: ',X[I].Data);
   Halt;
  End;
  WriteLn(X[I].Name:12,': PhysVideo=',X[I].Phys,', DataVideo=',X[I].Data,', Taille du pilote: ',X[I].Size);
  If Pos('TXT',X[I].Name)>0Then Begin
   WriteLn(' ':14,'Standard=',Ofs(_DriverTxtStandard),', DoubleMatrix=',Ofs(_DriverTxtDouble));
  End;
  DeleteFile(X[I].Name);
  SetFile(X[I].Name,0,X[I].Size,X[I].Drv^);
 End;
 FreeMaxHeap;
 Exec('\OUTPUT\CRLL.EXE','ADELE.RC');
 DoneSystems;
END.