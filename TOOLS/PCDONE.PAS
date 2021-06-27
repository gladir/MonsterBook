Unit PCDone;

INTERFACE

Procedure DoneBuffer;

IMPLEMENTATION

Uses Systems,PCCortex;

Procedure DoneBuffer;Begin
 FreeMem(CodePrg,65520);
 RBDone(ResWordBk);  { Banque des mots r‚serv‚s … additionner dans l'unit‚ }
 RBDone(TypeDef);    { Banque de type et de d‚finition de structure }
 RBDone(ExternVar);  { Banque de variable externe }
 RBDone(ExternProc); { Banque de routine externe }
 RBDone(UnitList);   { Banque des unit‚s de r‚f‚rence }
 RBDone(Macro);      { Banque de Macro }
 RBDone(Include);    { Banque d'inclusion }
 RBDone(Jump);       { Banque des sauts }
 RBDone(SuppData);   { Banque de donn‚e suppl‚mentaire }
 RBDone(Redef);      { Banque de constante }
 RBDone(VarBk);      { Banque de variable global }
 RBDone(ProcBk);
End;

END.