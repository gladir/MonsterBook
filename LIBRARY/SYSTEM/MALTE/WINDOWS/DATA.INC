{Data.Inc}

{$IFNDEF __WindowsData}
 {$DEFINE __WindowsData}

Type
 RefreshProc=Procedure(Var Obj);
 RunProc=Function(Var Obj):Wd;

Var
 _Windows:ArrayList;           { Banque de fen�tre d'application }
 CurrEdit:RBP;                 { Num�ro de la fen�tre courante }
 Ptr:Pointer;                  { Pointeur sur la fen�tre courante }
 WinPtr:^WinRec Absolute Ptr;  { Pointeur sur la structure de la fen�tre courante }
 YEditor:Byte;                 { D�finit la position Y de la procha�ne fen�tre }

{$ENDIF}