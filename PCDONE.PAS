Unit PCDone;

INTERFACE

Procedure DoneBuffer;

IMPLEMENTATION

Uses ResServD,Memories,Systems,PCCortex;

Procedure DoneBuffer;Begin
 DBDispose(CurrPC.MainWord);
 DBDispose(CurrPC.InstrAsm);
 DBDispose(CurrPC.RegAsm);
 DBDispose(CurrPC.IfCondAsm);
 FreeMem(CurrPC.CodePrg,65520);
 ALDone(CurrPC.ResWordBk);  { Banque des mots r‚serv‚s … additionner dans l'unit‚ }
 ALDone(CurrPC.TypeDef);    { Banque de type et de d‚finition de structure }
 ALDone(CurrPC.ExternVar);  { Banque de variable externe }
 ALDone(CurrPC.ExternProc); { Banque de routine externe }
 ALDone(CurrPC.UnitList);   { Banque des unit‚s de r‚f‚rence }
 ALDone(CurrPC.Macro);      { Banque de Macro }
 ALDone(CurrPC.Include);    { Banque d'inclusion }
 ALDone(CurrPC.Jump);       { Banque des sauts }
 ALDone(CurrPC.SuppData);   { Banque de donn‚e suppl‚mentaire }
 ALDone(CurrPC.Redef);      { Banque de constante }
 ALDone(CurrPC.VarBk);      { Banque de variable global }
 ALDone(CurrPC.ProcBk);
End;

END.