Uses Systex,Systems,Video,D3vTxt;

Procedure _WaitRetrace;Assembler;ASM
 MOV DX,$3DA
@1:IN AL,DX;TEST AL,8;JNZ @1
END;

Procedure _WaitDisplay;Assembler;ASM
 MOV DX,$3DA
@2:IN AL,DX;TEST AL,8;JZ @2
END;

Procedure VPan(Y:Byte);Assembler;ASM
 MOV DX,$3D4
 MOV AL,8
 MOV AH,Y
 OUT DX,AX
END;

Procedure WaitRetrace;Assembler;ASM
 MOV DX,$3DA
@1:IN AL,DX;TEST AL,8;JNZ @1
@2:IN AL,DX;TEST AL,8;JZ @2
END;

Const PtrDrv:^TByte=@_DriverTxt;
Var J,I,H:Word;MIVPtr:^MIV;

BEGIN
 InitSystems(suIsabel);
 ASM
  LES DI,PtrDrv
  MOV ES:[DI+256].PIV.CardCat,cvnVGA
  MOV ES:[DI+256].PIV.Font,Ya
{  MOV AX,1h
  INT 10h}
 END;
 MIVPtr:=@PtrDrv^[286];
 SetVideoMode(vmTxtC80x60);
 Init;
 SetLuxe(Ya);
 CloseIconTxt(0,0,$F);
 ASM
  XOR AX,AX
  INT 16h
 END;
{ SetChrWidth(8);}
{ SetUnderlineTxt(Ya);}
 SetDblMtx(Ya);
 PutTxtXYDblMtx(1,1,'Salut toi',$E0);
 PutTxtXYUnKrDblMtx(2,2,'Au merde');
 SetChrTxt(0,0,'A');
 SetAttrDblMtx(2,0,$C0);
 SetCubeDblMtx(1,0,'B',$1F);
 BarSpcVerDblMtx(3,1,MIVPtr^.NmYTxts-1,$40);
 BarSpcHorDblMtx(5,6,23,$40);

(* For I:=$6to$F do SetPaletteRGB(I,$FF,$FF,$FF);*)
(* SetVisualPg(1);
 For J:=399downto 0do Begin
{  If J and 15=15Then SetVerticalScale(J and $FFF0);
  _WaitDisplay;}
  SetVerticalScale(J {shl 1});
{ _WaitRetrace;}
 End;
{  For J:=24 downto 0do Begin
   SetVerticalScale(J shl 4);
   For H:=15downto 0do Begin
    _WaitDisplay;
    SetVerticalScale((J shl 4)+H);
    _WaitRetrace;
   End;
  End;}*)
 ASM
  XOR AX,AX
  INT $16
 END;
 SetUnderlineTxt(No);
END.