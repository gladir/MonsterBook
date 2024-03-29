Unit MBJoysti;

{컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�}
                                  INTERFACE
{컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�}

{$I DEF.INC}

Procedure SetupJoystick;

{컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�}
                                 IMPLEMENTATION
{컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�}

Uses
 Adele,Systex,Systems,Mouse,Dials;

Function GetJoyButton:Byte;Assembler;ASM
 MOV DX,$201
 IN  AL,DX
 NOT AL
 MOV CL,4
 SHR AL,CL
END;

Procedure WaitJoyButtonOff;Begin
 Repeat Until GetJoyButton=0;
End;

{$I \Source\Chantal\Library\JoyPos.Inc}

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
 �                        Proc괺ure SetupJoystick                      �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�


 Description
 袴袴袴袴袴�

  Cette proc괺ure d'effectuer des ajustements du pointeurs de manette de
 jeux.
}

Procedure SetupJoystick;
Label NoJoy;
Var
 W:Window;
 ChrA,ChrB:Chr;
 XC,YC,XBrut,YBrut,X,Y,OldX,OldY:Word;
 BJ,CurrJoy:Byte;
 OldScrSaver:Boolean;
Begin
 CurrJoy:=0;OldScrSaver:=ActifScrSave;ActifScrSave:=No;
 WEInitO(W,40,17);
 WEPushWn(W);
 WEPutWnKrDials(W,'Ajustement de manette de jeux');
 WECloseIcon(W);
 WEPutTxtXY(W,0,14,MultChr('�',39));
 XBrut:=JoyPos(CurrJoy shl 1);YBrut:=JoyPos((CurrJoy shl 1)+1);
 XC:=(XBrut*16)div JoyPotentioMeter;
 YC:=(YBrut*7)div JoyPotentioMeter;
 OldX:=$FFFF;OldY:=$FFFF;
 __ShowMousePtr;
 Repeat
  XBrut:=JoyPos(CurrJoy shl 1);YBrut:=JoyPos((CurrJoy shl 1)+1);
  X:=(XBrut*16)div JoyPotentioMeter;
  Y:=(YBrut*7)div JoyPotentioMeter;
  WEPutTxtXY(W,0,wnMax,'('+WordToStr(XBrut)+','+WordToStr(YBrut)+')'+Spc(10));
  If X<=1Then ChrA:='-'Else
  If X>XC+1Then ChrA:='+'
           Else ChrA:='0';
  If Y<=1Then ChrB:='-'Else
  If(Y>YC)Then ChrB:='+'
          Else ChrB:='0';
  If(ChrA<>'0')and(ChrB='+')Then Begin
   If Y>YC+3Then ChrB:='+'
            Else ChrB:='0';
  End;
  BJ:=GetJoyButton shr(CurrJoy shl 1);
  WEPutTxtXY(W,20,wnMax,'A='+Chr((BJ and 1)+48)+
                        ' B='+Chr(((BJ shr 1)and 1)+48)+
                        ' X='+ChrA+' Y='+ChrB);
  If Y>13Then Y:=13;
  If X>38Then X:=38;
  If(X<>OldX)or(Y<>OldY)Then Begin
   __HideMousePtr;
   WESetChr(W,OldX,OldY,' ');
   WESetChr(W,X,Y,'X');
   OldX:=X;OldY:=Y;
   __ShowMousePtr;
  End;
  _BackKbd;
  If __GetMouseButton>0Then Break;
 Until KeyPress;
 __HideMousePtr;
 WEReadk(W);
NoJoy:
 WEDone(W);
 ActifScrSave:=OldScrSaver;
End;

{컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�}
END.