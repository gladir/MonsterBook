.8086

Code Segment Public
Assume CS:Code

Include SYSTEX.INC

Public WESetKrBorder,WESetKrHigh,WESetKrSel

WESetKrBorder Proc Pascal Far Q:DWord
 MOV BX,Offset Wins.XColrs.Border
@1:
 LES DI,Q
 MOV AL,ES:[DI+BX]
 MOV ES:[DI].Wins.Kr,AL
 RET
endp

WESetKrHigh Proc Pascal Far Q:DWord
 MOV BX,Offset Wins.XColrs.MCHigh
 JMP @1
endp

WESetKrSel Proc Pascal Far Q:DWord
 MOV BX,Offset Wins.XColrs.Sel
 JMP @1
endp

code ends
end