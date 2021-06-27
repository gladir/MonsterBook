Program GetBannerNetware;

Function GetBanner(Var Name:String):Boolean;Assembler;ASM
 MOV AX,0B808h
 LES BX,Name
 INT 21h
 OR  AL,AL
 JZ  @End
 MOV AL,True
@End:
 XOR AL,1
END;

Var Name:String;

BEGIN
 WriteLn('Op‚ration B808h support‚: ',GetBanner(Name));
 WriteLn(Name);
END.