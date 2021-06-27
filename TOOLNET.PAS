Unit ToolNet;

INTERFACE

Procedure ShowIPConfig;

IMPLEMENTATION

Uses Netex,Systems,Dials,DialPlus;

Function NetBIOSCmd(Var NCB:TNCB):Word;Assembler;ASM
 PUSH BP
 PUSH SS
 PUSH DS
  LES BX,NCB
  INT 5Ch
  XOR AH,AH
 POP DS
 POP SS
 POP BP
END;

Function GetMacAddr(LanaNum:Integer):String;
Var
 NCB:TNCB;
 AdpStat:TAdpStat;
Begin
 FillChar(NCB,SizeOf(NCB),0);
 FillChar(AdpStat,SizeOf(AdpStat),0);
 NCB.Command:=$33;
 NCB.Buf:=@AdpStat;
 NCB.Length:=SizeOf(AdpStat);
 FillChar(NCB.CallName,SizeOf(TNBName),$20);
 NCB.CallName[0]:=Byte('*');
 NCB.LanaNum:=LanaNum;
 If NetBiosCmd(NCB)=0Then Begin
  GetMacAddr:=HexByte2Str(AdpStat.ID[0])+':'+
              HexByte2Str(AdpStat.ID[1])+':'+
              HexByte2Str(AdpStat.ID[2])+':'+
              HexByte2Str(AdpStat.ID[3])+':'+
              HexByte2Str(AdpStat.ID[4])+':'+
              HexByte2Str(AdpStat.ID[5]);
 End
  Else
 GetMacAddr:='??:??:??:??:??:??';
End;

Function GetNetBIOSName(LanaNum:Integer):String;
Var
 NCB:TNCB;
 AdpStat:TAdpStat;
Begin
 FillChar(NCB,SizeOf(NCB),0);
 FillChar(AdpStat,SizeOf(AdpStat),0);
 NCB.Command:=$33;
 NCB.Buf:=@AdpStat;
 NCB.Length:=SizeOf(AdpStat);
 FillChar(NCB.CallName,SizeOf(TNBName),$20);
 NCB.CallName[0]:=Byte('*');
 NCB.LanaNum:=LanaNum;
 If NetBiosCmd(NCB)=0Then GetNetBIOSName:=StrPas(@AdpStat.Names[0].Name)
                     Else GetNetBIOSName:='';
End;

Procedure ShowIPConfig;
Var
 Int5Ch:Pointer;
 FormIPConfig:Record
  AdapterID:String[3];
  MacIPAddr:String[50];
  Name:String[16];
 End;
Begin
 GetIntVec($5C,Int5Ch);
 If(Int5Ch=NIL)Then ErrNoMsgOk($32)
  Else
 Begin
  FillClr(FormIPConfig,SizeOf(FormIPConfig));
  FormIPConfig.AdapterID:='0';
  FormIPConfig.MacIPAddr:=GetMacAddr(0);
  FormIPConfig.Name:=GetNetBIOSName(0);
  ExecuteAppDPU(154,FormIPConfig);
 End;
End;

END.