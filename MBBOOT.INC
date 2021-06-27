Procedure InstallRebootManager;
Procedure UninstallRebootManager;

{���������������������������������������������������������������������������}
                                 IMPLEMENTATION
{���������������������������������������������������������������������������}

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

{�������������������������������������������������������������������������
 �                          Interruption Int19h                          �
 �������������������������������������������������������������������������


 Description
 �����������

  Cette interruption permet de remplacer le gestionnaire de red�marrage
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

{�������������������������������������������������������������������������
 �                       Proc�dure InstallRebootManager                  �
 �������������������������������������������������������������������������


 Description
 �����������

  Cette proc�dure installe le gestionnaire de red�marrage de la machine.
}

Procedure InstallRebootManager;Begin
 GetIntVec($19,OldInt19h);
 SetIntVec($19,@Int19h);
End;

{�������������������������������������������������������������������������
 �                       Proc�dure UninstallRebootManager                �
 �������������������������������������������������������������������������


 Description
 �����������

  Cette proc�dure d�sinstalle le gestionnaire de red�marrage de la machine.
}

Procedure UninstallRebootManager;Begin
 SetIntVec($19,OldInt19h);
End;