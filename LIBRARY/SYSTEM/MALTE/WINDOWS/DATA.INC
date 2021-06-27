{Data.Inc}

{$IFNDEF __WindowsData}
 {$DEFINE __WindowsData}

Type
 RefreshProc=Procedure(Var Obj);
 RunProc=Function(Var Obj):Wd;

Var
 _Windows:ArrayList;           { Banque de fenˆtre d'application }
 CurrEdit:RBP;                 { Num‚ro de la fenˆtre courante }
 Ptr:Pointer;                  { Pointeur sur la fenˆtre courante }
 WinPtr:^WinRec Absolute Ptr;  { Pointeur sur la structure de la fenˆtre courante }
 YEditor:Byte;                 { D‚finit la position Y de la prochaŒne fenˆtre }

{$ENDIF}