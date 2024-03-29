Program MakerDriver;

{$D-,L-,Y-}

Uses D2v400,D3v400,Drv400,D2v480,D3v480,Drv480,D2v19,D3v19,Drv19,
 D2vSVGA,DrvSVGA3,DrvSVGA,D2vVesa,D3vVesa,DrvVesa,V2A256,V3A256,
 VGA256,Drv65536,D2v65536,D3v65536,Memories,Systems,Systex;

Var I,PhysVideo,DataVideo:Word;

Const Max=20;
X:Array[0..Max]of Record Name:String[12];Drv:Pointer;Phys,Data,Size:Wd;End=(
 (Name:'DRV19.DRV';Drv:@_Driver19;Phys:Ofs(Drv19.PhysVideo);Data:Ofs(Drv19.DataVideo);Size:Ofs(EndDriver19)+1),
 (Name:'D2V19.DRV';Drv:@D2V19._Driver19;Phys:Ofs(D2v19.PhysVideo);Data:Ofs(Drv19.DataVideo);Size:Ofs(D2V19.EndDriver19)+1),
 (Name:'D3V19.DRV';Drv:@D3V19._Driver19;Phys:Ofs(D3v19.PhysVideo);Data:Ofs(Drv19.DataVideo);Size:Ofs(D3V19.EndDriver19)+1),
 (Name:'DRV400.DRV';Drv:@_Driver400;Phys:Ofs(Drv400.PhysVideo);Data:Ofs(Drv400.DataVideo);Size:Ofs(EndDriver400)+1),
 (Name:'D2V400.DRV';Drv:@D2V400._Driver400;Phys:Ofs(D2v400.PhysVideo);
                    Data:Ofs(D2v400.DataVideo);Size:Ofs(D2V400.EndDriver400)+1),
 (Name:'D3V400.DRV';Drv:@D3V400._Driver400;Phys:Ofs(D3v400.PhysVideo);
                    Data:Ofs(D3v400.DataVideo);Size:Ofs(D3V400.EndDriver400)+1),
 (Name:'DRV480.DRV';Drv:@_Driver480;Phys:Ofs(Drv480.PhysVideo);Data:Ofs(Drv480.DataVideo);Size:Ofs(EndDriver480)+1),
 (Name:'D2V480.DRV';Drv:@D2V480._Driver480;Phys:Ofs(D2v480.PhysVideo);
                    Data:Ofs(D2v480.DataVideo);Size:Ofs(D2V480.EndDriver480)+1),
 (Name:'D3V480.DRV';Drv:@D3V480._Driver480;Phys:Ofs(D3v480.PhysVideo);
                    Data:Ofs(D3v480.DataVideo);Size:Ofs(D3V480.EndDriver480)+1),
 (Name:'DRVSVGA.DRV';Drv:@_DriverSVGA;Phys:Ofs(DrvSVGA.PhysVideo);Data:Ofs(DrvSVGA.DataVideo);Size:Ofs(EndDriverSVGA)+1),
 (Name:'D2VSVGA.DRV';Drv:@D2VSVGA._DriverSVGA;Phys:Ofs(D2vSVGA.PhysVideo);
                     Data:Ofs(D2vSVGA.DataVideo);Size:Ofs(D2VSVGA.EndDriverSVGA)+1),
 (Name:'DRVSVGA3.DRV';Drv:@_DriverSVGA3;Phys:Ofs(DrvSVGA3.PhysVideo);Data:Ofs(DrvSVGA3.DataVideo);Size:Ofs(EndDriverSVGA3)+1),
 (Name:'DRVVESA.DRV';Drv:@_DriverVesa;Phys:Ofs(DrvVesa.PhysVideo);Data:Ofs(DrvVesa.DataVideo);Size:Ofs(EndDriverVesa)+1),
 (Name:'D2VVESA.DRV';Drv:@D2VVesa._DriverVesa;Phys:Ofs(D2vVesa.PhysVideo);
                     Data:Ofs(D2vVesa.DataVideo);Size:Ofs(D2VVesa.EndDriverVesa)+1),
 (Name:'D3VVESA.DRV';Drv:@D3VVesa._DriverVesa;Phys:Ofs(D3vVesa.PhysVideo);
                     Data:Ofs(D3vVesa.DataVideo);Size:Ofs(D3VVesa.EndDriverVesa)+1),
 (Name:'VGA256.DRV';Drv:@_DriverVGA256;Phys:Ofs(VGA256.PhysVideo);Data:Ofs(VGA256.DataVideo);Size:Ofs(EndDriverVGA256)+1),
 (Name:'V2A256.DRV';Drv:@V2A256._DriverVGA256;Phys:Ofs(VGA256.PhysVideo);
                    Data:Ofs(V2A256.DataVideo);Size:Ofs(V2A256.EndDriverVGA256)+1),
 (Name:'V3A256.DRV';Drv:@V3A256._DriverVGA256;Phys:Ofs(VGA256.PhysVideo);
                    Data:Ofs(V3A256.DataVideo);Size:Ofs(V3A256.EndDriverVGA256)+1),
 (Name:'DRV65536.DRV';Drv:@Drv65536._Driver65536;Phys:Ofs(Drv65536.PhysVideo);
                    Data:Ofs(Drv65536.DataVideo);Size:Ofs(Drv65536.EndDriver65536)+1),
 (Name:'D2V65536.DRV';Drv:@D2v65536._Driver65536;Phys:Ofs(D2v65536.PhysVideo);
                    Data:Ofs(D2v65536.DataVideo);Size:Ofs(D2v65536.EndDriver65536)+1),
 (Name:'D3V65536.DRV';Drv:@D3v65536._Driver65536;Phys:Ofs(D3v65536.PhysVideo);
                    Data:Ofs(D3v65536.DataVideo);Size:Ofs(D3v65536.EndDriver65536)+1)
);

BEGIN
 InitSystems(suIsabel);
 ASM
  MOV AX,4F02h
  MOV BX,108h
  INT 10h
 END;
 WriteLn('Maker de pilote vid�o du Malte Genesis V: Ad�le');
 WriteLn(MultChr('�',79));
 WriteLn;
 PhysVideo:=X[0].Phys;DataVideo:=X[0].Data;
 For I:=0to(Max)do Begin
  If PtrRec(X[I].Drv).Ofs<>0Then Begin
   WriteLn(X[I].Name:12,': ****** Erreur de position de d�marrage: ',PtrRec(X[I].Drv).Ofs);
   Halt;
  End;
  If(X[I].Phys<>PhysVideo)Then Begin
   WriteLn(X[I].Name:12,': ****** Erreur de position de �PhysVideo�: ',X[I].Phys);
   Halt;
  End;
  If(X[I].Data<>DataVideo)Then Begin
   WriteLn(X[I].Name:12,': ****** Erreur de position de �DataVideo�: ',X[I].Data);
   Halt;
  End;
  WriteLn(X[I].Name:12,': PhysVideo=',X[I].Phys,', DataVideo=',X[I].Data,', Taille du pilote: ',X[I].Size);
  DeleteFile(X[I].Name);
  SetFile(X[I].Name,0,X[I].Size,X[I].Drv^);
 End;
 FreeMaxHeap;
 Exec('\OUTPUT\CRLL.EXE','ADELE.RC');
 WriteLn('Presse une touche pour quitter...');
 ReadKey;
 DoneSystems;
END.