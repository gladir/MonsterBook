{$IFNDEF Int09h}
 {$DEFINE Int09h}
 {$I \Source\Chantal\Library\Keyboard\RawConst.Inc}
 {$I \Source\Chantal\Library\ConstKey.Inc}
 {$DEFINE ProtectedInterrupt}
 {$I \Source\Chantal\Library\PushKey.Inc}
Const InIRQ1:Boolean=False;Var OldInt09h:Pointer;
Procedure Int09h;Interrupt;
Const Qwerty1:Array[0..Length('QWERTYUIOP')]of Char='QWERTYUIOP';
      Qwerty2:Array[0..Length('ASDFGHJKL')]of Char='ASDFGHJKL';
      Qwerty3:Array[0..Length('ZXCVBNM')]of Char='ZXCVBNM';
Var Code,InPort,Attr,AttrFull:Byte;K,K2,K3:Word;Begin
 InIRQ1:=True;AttrFull:=Mem[$0040:$17];InPort:=Port[$60];
 Attr:=AttrFull and 15;K:=0;Code:=InPort and $7F;
 Case(Code)of
  rqkEsc:Case(Attr)of
   mAlt:K:=kbAltEsc;
   mCtrl:K:=kbCtrlEsc;
   mCtrl+mAlt:K:=kbCtrlAltEsc;
   mShift,mShiftLeft,mShiftRight:K:=kbShiftEsc;
  End;
  rqk2:If(Attr=mCtrl)Then K:=kbCtrl2;
  rqkBS:Case(Attr)of
   mAlt:K:=kbAltBS;
   mCtrl:K:=kbCtrlBS;
  End;
  rqkTab:If(Attr=mShift)Then K:=kbShiftTab;
  rqkEnter:If(Attr=mCtrl)Then K:=kbCtrlEnter;
  rqkSpaceBar:If(Attr=mAlt)Then K:=kbAltSpc;
  rqkUp:If(Attr=mCtrl)Then K:=kbCtrlUp;
  rqkKeypad5:K:=kbKeypad5;
  rqkDown:If(Attr=mCtrl)Then K:=kbCtrlDn;
{  iokbQ..iokbP:
  Begin
   K2:=Code-iokbQ;
   K3:=Byte(Not(((AttrFull and $40)=$40)xor((AttrFull and 3)>0)))*32;
   Case(Attr)of
    mAlt:K:=Byte(ShiftCode[Qwerty1[K2]])shl 8;
    mCtrl:K:=(Byte(ShiftCode[Qwerty1[K2]])shl 8)+Byte(Qwerty1[K2]);
    mNone:K:=Byte(Qwerty1[K2])+K3;
    Else K:=Byte(Qwerty1[K2])+K3;
   End;
  End;
  iokbF1..iokbF10:Begin
   K2:=(Code-iokbF1)shl 8;
   Case(Attr)of
    mAlt: K:=kbAltF1+K2;
    mCtrl: K:=kbCtrlF1+K2;
    mNone: K:=kbF1+K2;
    Else K:=kbShiftF1+K2;
   End;
  End;}
  rqkF11:Case(Attr)of
   mAlt:K:=kbAltF11;
   mCtrl:K:=kbCtrlF11;
   mNone:K:=kbF11;
   Else K:=kbShiftF11;
  End;
  rqkF12:Case(Attr)of
   mAlt:K:=kbAltF12;
   mCtrl:K:=kbCtrlF12;
   mNone:K:=kbF12;
   Else K:=kbShiftF12;
  End;
 End;
 If K<>0Then Begin
  If K<>$FFFFThen PushKey(K);
  ASM
   MOV AL,20h
   OUT 20h,AL
  END;
 End
  Else
 ASM
  PUSHF
  CALL OldInt09h
 END;
 InIRQ1:=False;
End;
{$ENDIF}