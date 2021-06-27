Unit Sr6502A;

INTERFACE

{$DEFINE RLL}
{$DEFINE HEXH}

Uses Systex;

Function Sourcer6502(Var Buf;Var I:Wd):String;
Procedure EndSourcer6502;

IMPLEMENTATION

Procedure AddStr(Var S:String;Const Add:String);Near;Forward;
Procedure BackStr(Var S:String);Near;Forward;
Function  DB(CurrCode:Byte):String;Near;Forward;
Function  HexByte2Str(X:Byte):String;Near;Forward;
Function  HexWord2Str(X:Word):String;Near;Forward;
Procedure IncStr(Var S:String;Chr:Char);Near;Forward;
Procedure MoveLeft(Var Source,Dest;Count:Word);Near;Forward;
Function  Reg6502(I:Byte):Char;Near;Forward;

Function Sourcer6502;Label _Copy,_BRK,_ORA,

_TypeAI,_TypeAIX,_TypeAIY,_TypeDIX,_TypeDIIX,_TypeDIY,
_TypeDIIY,_TypeDP,_TypeIMM,_TypeABS,_TypePCR,

_End,_00,_01,_02,_03,_04,_05,_06,_07,
_08,_09,_0A,_0B,_0C,_0D,_0E,_0F,_10,_11,_12,_13,_14,_15,_16,_17,_18,_19,
_1A,_1B,_1C,_1D,_1E,_1F,_20,_21,_22,_23,_24,_25,_26,_27,_28,_29,_2A,_2B,
_2C,_2D,_2E,_2F,_30,_31,_32,_33,_34,_35,_36,_37,_38,_39,_3A,_3B,_3C,_3D,
_3E,_3F,_40,_41,_42,_43,_44,_45,_46,_47,_48,_49,_4A,_4B,_4C,_4D,_4E,_4F,
_50,_51,_52,_53,_54,_55,_56,_57,_58,_59,_5A,_5B,_5C,_5D,_5E,_5F,_60,_61,
_62,_63,_64,_65,_66,_67,_68,_69,_6A,_6B,_6C,_6D,_6E,_6F,_70,_71,_72,_73,
_74,_75,_76,_77,_78,_79,_7A,_7B,_7C,_7D,_7E,_7F,_80,_81,_82,_83,_84,_85,
_86,_87,_88,_89,_8A,_8B,_8C,_8D,_8E,_8F,_90,_91,_92,_93,_94,_95,_96,_97,
_98,_99,_9A,_9B,_9C,_9D,_9E,_9F,_A0,_A1,_A2,_A3,_A4,_A5,_A6,_A7,_A8,_A9,
_AA,_AB,_AC,_AD,_AE,_AF,_B0,_B1,_B2,_B3,_B4,_B5,_B6,_B7,_B8,_B9,_BA,_BB,
_BC,_BD,_BE,_BF,_C0,_C1,_C2,_C3,_C4,_C5,_C6,_C7,_C8,_C9,_CA,_CB,__CC,_CD,
_CE,_CF,_D0,_D1,_D2,_D3,_D4,_D5,_D6,_D7,_D8,_D9,_DA,_DB,_DC,_DD,_DE,_DF,
_E0,_E1,_E2,_E3,_E4,_E5,_E6,_E7,_E8,_E9,_EA,_EB,_EC,_ED,_EE,_EF,_F0,_F1,
_F2,_F3,_F4,_F5,_F6,_F7,_F8,_F9,_FA,_FB,_FC,_FD,_FE,_FF,_Reg;
Var CurrCode:Byte;T:TByte Absolute Buf;S:String;Begin
 CurrCode:=T[I];
 ASM
  MOV BL,CurrCode
  XOR BH,BH
  SHL BX,1
  JMP @Label.Word[BX]
@Label:
  DW Offset _00, Offset _01, Offset _02, Offset _03
  DW Offset _04, Offset _05, Offset _06, Offset _07
  DW Offset _08, Offset _09, Offset _0A, Offset _0B
  DW Offset _0C, Offset _0D, Offset _0E, Offset _0F

  DW Offset _10, Offset _11, Offset _12, Offset _13
  DW Offset _14, Offset _15, Offset _16, Offset _17
  DW Offset _18, Offset _19, Offset _1A, Offset _1B
  DW Offset _1C, Offset _1D, Offset _1E, Offset _1F

  DW Offset _20, Offset _21, Offset _22, Offset _23
  DW Offset _24, Offset _25, Offset _26, Offset _27
  DW Offset _28, Offset _29, Offset _2A, Offset _2B
  DW Offset _2C, Offset _2D, Offset _2E, Offset _2F

  DW Offset _30, Offset _31, Offset _32, Offset _33
  DW Offset _34, Offset _35, Offset _36, Offset _37
  DW Offset _38, Offset _39, Offset _3A, Offset _3B
  DW Offset _3C, Offset _3D, Offset _3E, Offset _3F

  DW Offset _40, Offset _41, Offset _42, Offset _43
  DW Offset _44, Offset _45, Offset _46, Offset _47
  DW Offset _48, Offset _49, Offset _4A, Offset _4B
  DW Offset _4C, Offset _4D, Offset _4E, Offset _4F

  DW Offset _50, Offset _51, Offset _52, Offset _53
  DW Offset _54, Offset _55, Offset _56, Offset _57
  DW Offset _58, Offset _59, Offset _5A, Offset _5B
  DW Offset _5C, Offset _5D, Offset _5E, Offset _5F

  DW Offset _60, Offset _61, Offset _62, Offset _63
  DW Offset _64, Offset _65, Offset _66, Offset _67
  DW Offset _68, Offset _69, Offset _6A, Offset _6B
  DW Offset _6C, Offset _6D, Offset _6E, Offset _6F

  DW Offset _70, Offset _71, Offset _72, Offset _73
  DW Offset _74, Offset _75, Offset _76, Offset _77
  DW Offset _78, Offset _79, Offset _7A, Offset _7B
  DW Offset _7C, Offset _7D, Offset _7E, Offset _7F

  DW Offset _80, Offset _81, Offset _82, Offset _83
  DW Offset _84, Offset _85, Offset _86, Offset _87
  DW Offset _88, Offset _89, Offset _8A, Offset _8B
  DW Offset _8C, Offset _8D, Offset _8E, Offset _8F

  DW Offset _90, Offset _91, Offset _92, Offset _93
  DW Offset _94, Offset _95, Offset _96, Offset _97
  DW Offset _98, Offset _99, Offset _9A, Offset _9B
  DW Offset _9C, Offset _9D, Offset _9E, Offset _9F

  DW Offset _A0, Offset _A1, Offset _A2, Offset _A3
  DW Offset _A4, Offset _A5, Offset _A6, Offset _A7
  DW Offset _A8, Offset _A9, Offset _AA, Offset _AB
  DW Offset _AC, Offset _AD, Offset _AE, Offset _AF

  DW Offset _B0, Offset _B1, Offset _B2, Offset _B3
  DW Offset _B4, Offset _B5, Offset _B6, Offset _B7
  DW Offset _B8, Offset _B9, Offset _BA, Offset _BB
  DW Offset _BC, Offset _BD, Offset _BE, Offset _BF

  DW Offset _C0, Offset _C1, Offset _C2, Offset _C3
  DW Offset _C4, Offset _C5, Offset _C6, Offset _C7
  DW Offset _C8, Offset _C9, Offset _CA, Offset _CB
  DW Offset __CC,Offset _CD, Offset _CE, Offset _CF

  DW Offset _D0, Offset _D1, Offset _D2, Offset _D3
  DW Offset _D4, Offset _D5, Offset _D6, Offset _D7
  DW Offset _D8, Offset _D9, Offset _DA, Offset _DB
  DW Offset _DC, Offset _DD, Offset _DE, Offset _DF

  DW Offset _E0, Offset _E1, Offset _E2, Offset _E3
  DW Offset _E4, Offset _E5, Offset _E6, Offset _E7
  DW Offset _E8, Offset _E9, Offset _EA, Offset _EB
  DW Offset _EC, Offset _ED, Offset _EE, Offset _EF

  DW Offset _F0, Offset _F1, Offset _F2, Offset _F3
  DW Offset _F4, Offset _F5, Offset _F6, Offset _F7
  DW Offset _F8, Offset _F9, Offset _FA, Offset _FB
  DW Offset _FC, Offset _FD, Offset _FE, Offset _FF
_Copy:
  PUSH CS
  PUSH SI
  PUSH SS
  XOR AX,AX
  SUB AX,BP
  MOV DI,Offset S
  SUB DI,AX
  PUSH DI
  MOV CL,ES:[DI]
  XOR CH,CH
  INC CX
  PUSH CX
  CALL MoveLeft
  RETN
 _BRK:DB 3,'BRK'
 _ORA:DB 3,'ORA'
@Next:
 END;
 _00:ASM;MOV SI,Offset _BRK; CALL _Copy;END;Goto _End;
 _01:ASM;MOV SI,Offset _ORA; CALL _Copy;END;Goto _End;
 _02:
 _03:
 _04:
 _05:
 _06:
 _07:
 _09:
 _0A:
 _0B:
 _0C:
 _0D:
 _0E:
 _0F:
 _11:
 _12:
 _13:
 _14:
 _15:
 _16:
 _17:
 _19:
 _1A:
 _1B:
 _1C:
 _1D:
 _1F:
 _21:
 _22:
 _23:
 _24:
 _25:
 _27:
 _29:
 _2A:
 _2B:
 _2C:
 _2D:
 _2E:
 _2F:
 _31:
 _32:
 _33:
 _34:
 _35:
 _36:
 _39:
 _3A:
 _3B:
 _3C:
 _3D:
 _3E:
 _3F:
 _76:
 _40:_41:_42:_43:_44:_45:_46:_47:_48:_49:_4A:_4B:_4C:_4D:_4E:_4F:
 _50:_51:_52:_53:_54:_55:_56:_57:_58:_59:_5A:_5B:_5C:_5D:_5E:_5F:
 _60:_61:_62:_63:_64:_65:_66:_67:_68:_69:_6A:_6B:_6C:_6D:_6E:_6F:
 _70:_71:_72:_73:_74:_75:    _77:_78:_79:_7A:_7B:_7C:_7D:_7E:_7F:
 _80:_81:_82:_83:_84:_85:_86:_87:
 _88:_89:_8A:_8B:_8C:_8D:_8E:_8F:
 _90:_91:_92:_93:_94:_95:_96:_97:
 _98:_99:_9A:_9B:_9C:_9D:_9E:_9F:
 _A0:_A1:_A2:_A3:_A4:_A5:_A6:_A7:
 _A8:_A9:_AA:_AB:_AC:_AD:_AE:_AF:
 _B0:_B1:_B2:_B3:_B4:_B5:_B6:_B7:
 _B8:_B9:_BA:_BB:_BC:_BD:_BE:_BF:
 _C0:
 _C1:
 _C2:
 _C3:
 _C4:
 _C6:
 _C7:
 _C9:
 _CA:
 _CB:
 __CC:
 _CD:
 _CE:
 _CF:
 _D0:
 _D1:
 _D2:
 _D3:
 _D4:
 _D6:
 _D7:
 _D8:
 _DA:
 _DB:
 _DC:
 _DE:
 _DF:
 _E0:
 _E1:
 _E2:
 _E3:
 _E4:
 _E6:
 _E7:
 _E8:
 _E9:
 _EA:
 _EB:
 _EC:
 _EE:
 _EF:
 _F0:
 _F1:
 _F2:
 _F3:
 _F4:
 _F6:
 _F7:
 _F8:
 _F9:
 _FA:
 _FB:
 _FC:
 _FE:
 _FF:
_TypeAI:IncStr(S,' ');IncStr(S,'(');AddStr(S,HexWord2Str(CurrCode));IncStr(S,')');Goto _End;
_TypeAIX:;Goto _End;
_TypeAIY:;Goto _End;
_TypeDIX:;Goto _End;
_TypeDIIX:;Goto _End;
_TypeDIY:;Goto _End;
_TypeDIIY:;Goto _End;
_TypeDP:;Goto _End;
_TypeIMM:;Goto _End;
_TypeABS:;Goto _End;
_TypePCR:;Goto _End;
  {Option par d‚faut}
_08:_10:_18:_1E:_20:_26:_28:_30:_37:_38:_C5:_C8:_D5:_D9:_DD:_E5:_ED:_F5:_FD:
  S:=DB(CurrCode);
_End:
 Inc(I);
 Sourcer6502:=S;
End;

{$I \Source\Chantal\Library\AddStr.Inc}
{$I \Source\Chantal\Library\HexByte.Inc}
{$I \Source\Chantal\Library\HexWord.Inc}
{$I \Source\Chantal\Library\IncStr.Inc}
{$I \Source\Chantal\Library\MoveLeft.Inc}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                            Proc‚dure BackStr                         Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure enlŠve le dernier caractŠre d'un chaŒne de caractŠre de
 type Pascal.  Si la chaŒne de caractŠre est d‚j… vide,  elle n'y a aucun
 changement defectu‚ sur celle-ci.
}

Procedure BackStr;Var SLen:Byte Absolute S;Begin
 If SLen>0Then Dec(SLen)
End;

Function DB;Var S:String;Begin
 S:='DB';IncStr(S,' ');
 If Chr(CurrCode)in[' ','A'..'z']Then Begin
  IncStr(S,'''');
  AddStr(S,Chr(CurrCode));
  IncStr(S,'''');
 End
  Else
 AddStr(S,HexByte2Str(CurrCode));
 DB:=S;
End;

Procedure _Reg6502;Assembler;ASM
 DB 'BCDEHLMA'
END;

Function Reg6502;Assembler;ASM
 MOV BL,I
 XOR BH,BH
 MOV AL,Byte Ptr _Reg6502[BX]
END;

Procedure EndSourcer6502;Assembler;ASM END;

END.