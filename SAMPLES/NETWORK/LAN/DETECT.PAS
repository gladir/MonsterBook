Program DetectLanNetwork;

Function DetectLan:Boolean;Assembler;ASM
 MOV AH,00h
 INT 2Ah
 MOV AL,True
 OR  AH,AH
 JNZ @End
 MOV AL,False
@End:
END;

Function GetUserName(Var Name:String):Boolean;Assembler;ASM
 MOV AX,7802h
 LES DI,Name
 INT 2Ah
 MOV AL,True
 OR  AH,AH
 JNZ @End
 MOV AL,False
@End:
END;

Var Name:String;

BEGIN
 FillChar(Name,SizeOf(Name),0);
 WriteLn(DetectLan);
 WriteLn(GetUserName(Name));
 WriteLn(Name);
END.