Program ChevalierDeMalteDos;

{$Orgine 0}
{$3+}

Procedure ReadInStat;Far;Begin { Fonction 0Bh: Lire l'‚tat d'entr‚e }
 _ES:=0;
{ LES DX,ES:[041Ah]
 MOV BX,ES
 CMP BX,DX
 JE  @Xit
 MOV AL,0FFh
@Xit:}
End;

Procedure SetIntVec;Far;Begin { Fonction 25h }
 _BX:=_AL;_BX<<:=2;_ES:=0;_IF:=False;
 MemW[_ES:_BX]:=_DX;
 MemW[_ES:_BX+2]:=_DS;
 _IF:=True;
End;

BEGIN
 SetIntVec;
 _AH:=$09;
 _AL:=8;
 _BX:=7;
 _CX:=80;
 Intr($10);
END.