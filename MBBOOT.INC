Procedure InstallRebootManager;
Procedure UninstallRebootManager;

{컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�}
                                 IMPLEMENTATION
{컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�}

Uses
 Systex,Systems,Dials
 {$IFDEF FullVersion}
  ,MBExit
 {$ENDIF}
 {$IFDEF BureauVersion}
  ,MBBExit
 {$ENDIF};

Var
 OldInt19h:Pointer;

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
 �                          Interruption Int19h                          �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�


 Description
 袴袴袴袴袴�

  Cette interruption permet de remplacer le gestionnaire de red굆arrage
 de la machine.
}

Procedure Int19h;Interrupt;
Const
 InIntr:Byte=0;
Begin
 If InIntr>0Then ASM
  PUSHF
  CALL OldInt19h
 END;
 Inc(InIntr);
 STI;
 If(WarningMsgYesNo('Voulez-vous quittez ce programme?')=kbYes)Then Begin
  SmallXit(False);
 End;
 Dec(InIntr);
End;

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
 �                       Proc괺ure InstallRebootManager                  �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�


 Description
 袴袴袴袴袴�

  Cette proc괺ure installe le gestionnaire de red굆arrage de la machine.
}

Procedure InstallRebootManager;Begin
 GetIntVec($19,OldInt19h);
 SetIntVec($19,@Int19h);
End;

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
 �                       Proc괺ure UninstallRebootManager                �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�


 Description
 袴袴袴袴袴�

  Cette proc괺ure d굎installe le gestionnaire de red굆arrage de la machine.
}

Procedure UninstallRebootManager;Begin
 SetIntVec($19,OldInt19h);
End;
