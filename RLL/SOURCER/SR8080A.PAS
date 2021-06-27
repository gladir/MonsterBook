Unit Sr8080A;

INTERFACE

{$DEFINE RLL}
{$DEFINE HEXH}

Uses Systex;

Procedure Sourcer8080(Var Buf;Var I:Wd;Var S:String);Far;
Procedure EndSourcer8080;

IMPLEMENTATION

Procedure AddStr(Var S:String;Const Add:String);Near;Forward;
Procedure BackStr(Var S:String);Near;Forward;
Function  HexByte2Str(X:Byte):String;Near;Forward;
Procedure IncStr(Var S:String;Chr:Char);Near;Forward;
Procedure MoveLeft(Var Source,Dest;Count:Word);Near;Forward;
Function  Reg8080(I:Byte):Char;Near;Forward;

Procedure DBStr;Near;Forward;

Procedure Sourcer8080;Label _Copy,_ACI,_ADC,_ADD,_ADI,_ANA,_ANI,_CALL,_CC,
_CM,_CMA,_CMC,_CMP,_CNC,_CNZ,_CP,_CPE,_CPI,_CPO,_CZ,_DAA,_DAD,_DCR,_DCX,
_DI,_EI,_HLT,_IN,_INR,_INX,_JC,_JM,_JMP,_JNC,_JNZ,_JP,_JPE,_JPO,_JZ,_LDAX,
_LHLD,_LXI,_MOV,_MVI,_NOP,_ORA,_ORI,_OUT,_PCHL,_POP,_RAL,_RAR,_RC,_RET,
_RM,_RLC,_RNC,_RNZ,_RP,_RPE,_RPO,_RRC,_RST,_RZ,_SBB,_SBI,_SHLD,_SPHL,
_STAX,_SUB,_SUI,_XCHG,_XRA,_XRI,_XTHL,_End,_00,_01,_02,_03,_04,_05,_06,_07,
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
Var CurrCode:Byte;T:TByte Absolute Buf;Begin
 CurrCode:=T[I];
 ASM
  LES DI,S
  MOV Word Ptr @S,DI
  MOV Word Ptr @S[2],ES
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
@S:
  DD 0
_Copy:
  PUSH CS
  PUSH SI
  PUSH Word Ptr @S[2]
  PUSH Word Ptr @S
  MOV CL,CS:[SI]
  XOR CH,CH
  INC CX
  PUSH CX
  CALL MoveLeft
  RETN
 _ACI:DB 3,'ACI'
 _ADC:DB 3,'ADC'
 _ADD:DB 3,'ADD'
 _ADI:DB 3,'ADI'
 _ANA:DB 3,'ANA'
 _ANI:DB 3,'ANI'
_CALL:DB 4,'CALL'
  _CC:DB 2,'CC'
  _CM:DB 2,'CM'
 _CMA:DB 3,'CMA'
 _CMC:DB 3,'CMC'
 _CMP:DB 3,'CMP'
 _CNC:DB 3,'CNC'
 _CNZ:DB 3,'CNZ'
  _CP:DB 2,'CP'
 _CPE:DB 3,'CPE'
 _CPI:DB 3,'CPI'
 _CPO:DB 3,'CPO'
  _CZ:DB 2,'CZ'
 _DAA:DB 3,'DAA'
 _DAD:DB 4,'DAD '
 _DCR:DB 4,'DCR '
 _DCX:DB 4,'DCX '
  _DI:DB 2,'DI'
  _EI:DB 2,'EI'
 _HLT:DB 3,'HLT'
  _IN:DB 2,'IN'
 _INR:DB 4,'INR '
 _INX:DB 4,'INX '
  _JC:DB 2,'JC'
  _JM:DB 2,'JM'
 _JMP:DB 3,'JMP'
 _JNC:DB 3,'JNC'
 _JNZ:DB 3,'JNZ'
  _JP:DB 2,'JP'
 _JPE:DB 3,'JPE'
 _JPO:DB 3,'JPO'
  _JZ:DB 2,'JZ'
_LDAX:DB 4,'LDAX'
_LHLD:DB 4,'LHLD'
 _LXI:DB 4,'LXI '
 _MOV:DB 4,'MOV '
 _MVI:DB 4,'MVI '
 _NOP:DB 3,'NOP'
 _ORA:DB 3,'ORA'
 _ORI:DB 3,'ORI'
 _OUT:DB 3,'OUT'
_PCHL:DB 4,'PCHL'
 _POP:DB 4,'POP '
 _RAL:DB 3,'RAL'
 _RAR:DB 3,'RAR'
  _RC:DB 2,'RC'
 _RET:DB 3,'RET'
 _RLC:DB 3,'RLC'
  _RM:DB 2,'RM'
 _RNC:DB 3,'RNC'
 _RNZ:DB 3,'RNZ'
  _RP:DB 2,'RP'
 _RPE:DB 3,'RPE'
 _RPO:DB 3,'RPO'
 _RRC:DB 3,'RRC'
 _RST:DB 4,'RST '
  _RZ:DB 2,'RZ'
 _SBB:DB 3,'SBB'
 _SBI:DB 3,'SBI'
_SHLD:DB 4,'SHLD'
_SPHL:DB 4,'SPHL'
_STAX:DB 4,'STAX'
 _SUB:DB 3,'SUB'
 _SUI:DB 3,'SUI'
_XCHG:DB 4,'XCHG'
 _XRA:DB 3,'XRA'
 _XRI:DB 3,'XRI'
_XTHL:DB 4,'XTHL'
@Next:
 END;
 _00:ASM;MOV SI,Offset _Nop; CALL _Copy;END;              ASM JMP _End;END;
 _01:ASM;MOV SI,Offset _LXI; CALL _Copy;END;IncStr(S,'B');ASM JMP _End;END;
 _02:ASM;MOV SI,Offset _STAX;CALL _Copy;END;IncStr(S,'B');ASM JMP _End;END;
 _03:ASM;MOV SI,Offset _INX; CALL _Copy;END;IncStr(S,'B');ASM JMP _End;END;
 _04:ASM;MOV SI,Offset _INR; CALL _Copy;END;IncStr(S,'B');ASM JMP _End;END;
 _05:ASM;MOV SI,Offset _DCR; CALL _Copy;END;IncStr(S,'B');ASM JMP _End;END;
 _06:ASM;MOV SI,Offset _MVI; CALL _Copy;END;IncStr(S,'B');ASM JMP _End;END;
 _07:ASM;MOV SI,Offset _RLC; CALL _Copy;END;              ASM JMP _End;END;
 _09:ASM;MOV SI,Offset _DAD; CALL _Copy;END;IncStr(S,'B');ASM JMP _End;END;
 _0A:ASM;MOV SI,Offset _LDAX;CALL _Copy;END;IncStr(S,'B');ASM JMP _End;END;
 _0B:ASM;MOV SI,Offset _DCX; CALL _Copy;END;IncStr(S,'B');ASM JMP _End;END;
 _0C:ASM;MOV SI,Offset _INR; CALL _Copy;END;IncStr(S,'C');ASM JMP _End;END;
 _0D:ASM;MOV SI,Offset _DCR; CALL _Copy;END;IncStr(S,'C');ASM JMP _End;END;
 _0E:ASM;MOV SI,Offset _MVI; CALL _Copy;END;IncStr(S,'C');ASM JMP _End;END;
 _0F:ASM;MOV SI,Offset _RRC; CALL _Copy;END;              ASM JMP _End;END;
 _11:ASM;MOV SI,Offset _LXI; CALL _Copy;END;IncStr(S,'D');ASM JMP _End;END;
 _12:ASM;MOV SI,Offset _STAX;CALL _Copy;END;IncStr(S,'D');ASM JMP _End;END;
 _13:ASM;MOV SI,Offset _INX; CALL _Copy;END;IncStr(S,'D');ASM JMP _End;END;
 _14:ASM;MOV SI,Offset _INR; CALL _Copy;END;IncStr(S,'D');ASM JMP _End;END;
 _15:ASM;MOV SI,Offset _DCR; CALL _Copy;END;IncStr(S,'D');ASM JMP _End;END;
 _16:ASM;MOV SI,Offset _MVI; CALL _Copy;END;IncStr(S,'D');ASM JMP _End;END;
 _17:ASM;MOV SI,Offset _RAL; CALL _Copy;END;              ASM JMP _End;END;
 _19:ASM;MOV SI,Offset _DAD; CALL _Copy;END;IncStr(S,'D');ASM JMP _End;END;
 _1A:ASM;MOV SI,Offset _LDAX;CALL _Copy;END;IncStr(S,'D');ASM JMP _End;END;
 _1B:ASM;MOV SI,Offset _DCX; CALL _Copy;END;IncStr(S,'D');ASM JMP _End;END;
 _1C:ASM;MOV SI,Offset _INR; CALL _Copy;END;IncStr(S,'E');ASM JMP _End;END;
 _1D:ASM;MOV SI,Offset _DCR; CALL _Copy;END;IncStr(S,'E');ASM JMP _End;END;
 _1F:ASM;MOV SI,Offset _RAR; CALL _Copy;END;              ASM JMP _End;END;
 _21:ASM;MOV SI,Offset _LXI; CALL _Copy;END;IncStr(S,'H');ASM JMP _End;END;
 _22:ASM;MOV SI,Offset _SHLD;CALL _Copy;END;              ASM JMP _End;END;
 _23:ASM;MOV SI,Offset _INX; CALL _Copy;END;IncStr(S,'H');ASM JMP _End;END;
 _24:ASM;MOV SI,Offset _INR; CALL _Copy;END;IncStr(S,'H');ASM JMP _End;END;
 _25:ASM;MOV SI,Offset _DCR; CALL _Copy;END;IncStr(S,'H');ASM JMP _End;END;
 _27:ASM;MOV SI,Offset _DAA; CALL _Copy;END;              ASM JMP _End;END;
 _29:ASM;MOV SI,Offset _DAD; CALL _Copy;END;IncStr(S,'H');ASM JMP _End;END;
 _2A:ASM;MOV SI,Offset _LHLD;CALL _Copy;END;              ASM JMP _End;END;
 _2B:ASM;MOV SI,Offset _DCX; CALL _Copy;END;IncStr(S,'H');ASM JMP _End;END;
 _2C:ASM;MOV SI,Offset _INR; CALL _Copy;END;IncStr(S,'L');ASM JMP _End;END;
 _2D:ASM;MOV SI,Offset _DCR; CALL _Copy;END;IncStr(S,'L');ASM JMP _End;END;
 _2E:ASM;MOV SI,Offset _MVI; CALL _Copy;END;IncStr(S,'L');ASM JMP _End;END;
 _2F:ASM;MOV SI,Offset _CMA; CALL _Copy;END;              ASM JMP _End;END;
 _31:ASM;MOV SI,Offset _LXI; CALL _Copy;END;IncStr(S,'S');IncStr(S,'P');ASM JMP _End;END;
 _32:ASM;MOV SI,Offset _STAX;CALL _Copy;END;BackStr(S);   ASM JMP _End;END;
 _33:ASM;MOV SI,Offset _INX; CALL _Copy;END;IncStr(S,'S');IncStr(S,'P');ASM JMP _End;END;
 _34:ASM;MOV SI,Offset _INR; CALL _Copy;END;IncStr(S,'M');ASM JMP _End;END;
 _35:ASM;MOV SI,Offset _DCR; CALL _Copy;END;IncStr(S,'M');ASM JMP _End;END;
 _36:ASM;MOV SI,Offset _MVI; CALL _Copy;END;IncStr(S,'M');ASM JMP _End;END;
 _39:ASM;MOV SI,Offset _DAD; CALL _Copy;END;IncStr(S,'S');IncStr(S,'P');ASM JMP _End;END;
 _3A:ASM;MOV SI,Offset _LDAX;CALL _Copy;END;BackStr(S);   ASM JMP _End;END;
 _3B:ASM;MOV SI,Offset _DCX; CALL _Copy;END;IncStr(S,'S');IncStr(S,'P');ASM JMP _End;END;
 _3C:ASM;MOV SI,Offset _INR; CALL _Copy;END;IncStr(S,'A');ASM JMP _End;END;
 _3D:ASM;MOV SI,Offset _DCR; CALL _Copy;END;IncStr(S,'A');ASM JMP _End;END;
 _3E:ASM;MOV SI,Offset _MVI; CALL _Copy;END;IncStr(S,'A');ASM JMP _End;END;
 _3F:ASM;MOV SI,Offset _CMC; CALL _Copy;END;              ASM JMP _End;END;
 _76:ASM;MOV SI,Offset _HLT; CALL _Copy;END;              ASM JMP _End;END;
 _40:_41:_42:_43:_44:_45:_46:_47:_48:_49:_4A:_4B:_4C:_4D:_4E:_4F:
 _50:_51:_52:_53:_54:_55:_56:_57:_58:_59:_5A:_5B:_5C:_5D:_5E:_5F:
 _60:_61:_62:_63:_64:_65:_66:_67:_68:_69:_6A:_6B:_6C:_6D:_6E:_6F:
 _70:_71:_72:_73:_74:_75:    _77:_78:_79:_7A:_7B:_7C:_7D:_7E:_7F:
   ASM;MOV SI,Offset _MOV;CALL _Copy;END;
   IncStr(S,Reg8080((CurrCode-$40)shr 3));
   IncStr(S,',');IncStr(S,Reg8080(CurrCode and 7));
   ASM JMP _End;END;
 _80:_81:_82:_83:_84:_85:_86:_87:ASM;MOV SI,Offset _ADD; CALL _Copy;END;Goto _Reg;
 _88:_89:_8A:_8B:_8C:_8D:_8E:_8F:ASM;MOV SI,Offset _ADC; CALL _Copy;END;Goto _Reg;
 _90:_91:_92:_93:_94:_95:_96:_97:ASM;MOV SI,Offset _SUB; CALL _Copy;END;Goto _Reg;
 _98:_99:_9A:_9B:_9C:_9D:_9E:_9F:ASM;MOV SI,Offset _SBB; CALL _Copy;END;Goto _Reg;
 _A0:_A1:_A2:_A3:_A4:_A5:_A6:_A7:ASM;MOV SI,Offset _ANA; CALL _Copy;END;Goto _Reg;
 _A8:_A9:_AA:_AB:_AC:_AD:_AE:_AF:ASM;MOV SI,Offset _XRA; CALL _Copy;END;Goto _Reg;
 _B0:_B1:_B2:_B3:_B4:_B5:_B6:_B7:ASM;MOV SI,Offset _ORA; CALL _Copy;END;Goto _Reg;
 _B8:_B9:_BA:_BB:_BC:_BD:_BE:_BF:ASM;MOV SI,Offset _CMP; CALL _Copy;END;
_Reg:
  IncStr(S,' ');
  IncStr(S,Reg8080(CurrCode and 7));
  ASM JMP _End;END;
 _C0:ASM;MOV SI,Offset _RNZ; CALL _Copy;END;               ASM JMP _End;END;
 _C1:ASM;MOV SI,Offset _POP; CALL _Copy;END;IncStr(S,'B'); ASM JMP _End;END;
 _C2:ASM;MOV SI,Offset _JNZ; CALL _Copy;END;               ASM JMP _End;END;
 _C3:ASM;MOV SI,Offset _JMP; CALL _Copy;END;               ASM JMP _End;END;
 _C4:ASM;MOV SI,Offset _CNZ; CALL _Copy;END;               ASM JMP _End;END;
 _C6:ASM;MOV SI,Offset _ADI; CALL _Copy;END;               ASM JMP _End;END;
 _C7:ASM;MOV SI,Offset _RST; CALL _Copy;END;IncStr(S,'0'); ASM JMP _End;END;
 _C9:ASM;MOV SI,Offset _RET; CALL _Copy;END;               ASM JMP _End;END;
 _CA:ASM;MOV SI,Offset _JZ;  CALL _Copy;END;               ASM JMP _End;END;
 _CB:ASM;MOV SI,Offset _RZ;  CALL _Copy;END;               ASM JMP _End;END;
 __CC:ASM;MOV SI,Offset _CZ;  CALL _Copy;END;              ASM JMP _End;END;
 _CD:ASM;MOV SI,Offset _CALL;CALL _Copy;END;               ASM JMP _End;END;
 _CE:ASM;MOV SI,Offset _ACI; CALL _Copy;END;               ASM JMP _End;END;
 _CF:ASM;MOV SI,Offset _RST; CALL _Copy;END;IncStr(S,'1'); ASM JMP _End;END;
 _D0:ASM;MOV SI,Offset _RNC; CALL _Copy;END;               ASM JMP _End;END;
 _D1:ASM;MOV SI,Offset _POP; CALL _Copy;END;IncStr(S,'D'); ASM JMP _End;END;
 _D2:ASM;MOV SI,Offset _JNC; CALL _Copy;END;               ASM JMP _End;END;
 _D3:ASM;MOV SI,Offset _OUT; CALL _Copy;END;               ASM JMP _End;END;
 _D4:ASM;MOV SI,Offset _CNC; CALL _Copy;END;               ASM JMP _End;END;
 _D6:ASM;MOV SI,Offset _SUI; CALL _Copy;END;               ASM JMP _End;END;
 _D7:ASM;MOV SI,Offset _RST; CALL _Copy;END;IncStr(S,'2'); ASM JMP _End;END;
 _D8:ASM;MOV SI,Offset _RC;  CALL _Copy;END;               ASM JMP _End;END;
 _DA:ASM;MOV SI,Offset _JC;  CALL _Copy;END;               ASM JMP _End;END;
 _DB:ASM;MOV SI,Offset _IN;  CALL _Copy;END;               ASM JMP _End;END;
 _DC:ASM;MOV SI,Offset _CC;  CALL _Copy;END;               ASM JMP _End;END;
 _DE:ASM;MOV SI,Offset _SBI; CALL _Copy;END;               ASM JMP _End;END;
 _DF:ASM;MOV SI,Offset _RST; CALL _Copy;END;IncStr(S,'3'); ASM JMP _End;END;
 _E0:ASM;MOV SI,Offset _RPO; CALL _Copy;END;               ASM JMP _End;END;
 _E1:ASM;MOV SI,Offset _POP; CALL _Copy;END;IncStr(S,'H'); ASM JMP _End;END;
 _E2:ASM;MOV SI,Offset _JPO; CALL _Copy;END;               ASM JMP _End;END;
 _E3:ASM;MOV SI,Offset _XTHL;CALL _Copy;END;               ASM JMP _End;END;
 _E4:ASM;MOV SI,Offset _CPO; CALL _Copy;END;               ASM JMP _End;END;
 _E6:ASM;MOV SI,Offset _ANI; CALL _Copy;END;               ASM JMP _End;END;
 _E7:ASM;MOV SI,Offset _RST; CALL _Copy;END;IncStr(S,'4'); ASM JMP _End;END;
 _E8:ASM;MOV SI,Offset _RPE; CALL _Copy;END;               ASM JMP _End;END;
 _E9:ASM;MOV SI,Offset _PCHL;CALL _Copy;END;               ASM JMP _End;END;
 _EA:ASM;MOV SI,Offset _JPE; CALL _Copy;END;               ASM JMP _End;END;
 _EB:ASM;MOV SI,Offset _XCHG;CALL _Copy;END;               ASM JMP _End;END;
 _EC:ASM;MOV SI,Offset _CPE; CALL _Copy;END;               ASM JMP _End;END;
 _EE:ASM;MOV SI,Offset _XRI; CALL _Copy;END;               ASM JMP _End;END;
 _EF:ASM;MOV SI,Offset _RST; CALL _Copy;END;IncStr(S,'5'); ASM JMP _End;END;
 _F0:ASM;MOV SI,Offset _RP;  CALL _Copy;END;               ASM JMP _End;END;
 _F1:ASM;MOV SI,Offset _POP; CALL _Copy;END;IncStr(S,'P');IncStr(S,'S');IncStr(S,'W');ASM JMP _End;END;
 _F2:ASM;MOV SI,Offset _JP;  CALL _Copy;END;               ASM JMP _End;END;
 _F3:ASM;MOV SI,Offset _DI;  CALL _Copy;END;               ASM JMP _End;END;
 _F4:ASM;MOV SI,Offset _CP;  CALL _Copy;END;               ASM JMP _End;END;
 _F6:ASM;MOV SI,Offset _ORI; CALL _Copy;END;               ASM JMP _End;END;
 _F7:ASM;MOV SI,Offset _RST; CALL _Copy;END;IncStr(S,'6'); ASM JMP _End;END;
 _F8:ASM;MOV SI,Offset _RM;  CALL _Copy;END;               ASM JMP _End;END;
 _F9:ASM;MOV SI,Offset _SPHL;CALL _Copy;END;               ASM JMP _End;END;
 _FA:ASM;MOV SI,Offset _JM;  CALL _Copy;END;               ASM JMP _End;END;
 _FB:ASM;MOV SI,Offset _EI;  CALL _Copy;END;               ASM JMP _End;END;
 _FC:ASM;MOV SI,Offset _CM;  CALL _Copy;END;               ASM JMP _End;END;
 _FE:ASM;MOV SI,Offset _CPI; CALL _Copy;END;               ASM JMP _End;END;
 _FF:ASM;MOV SI,Offset _RST; CALL _Copy;END;IncStr(S,'7'); ASM JMP _End;END;
  {Option par d‚faut}
_08:_10:_18:_1E:_20:_26:_28:_30:_37:_38:_C5:_C8:_D5:_D9:_DD:_E5:_ED:_F5:_FD:
 ASM
  PUSH CS
  MOV SI,Offset DBStr
  PUSH SI
  LES DI,S
  PUSH ES
  PUSH DI
  MOV CL,CS:[SI]
  XOR CH,CH
  INC CX
  PUSH CX
  CALL MoveLeft
 END;
 If Chr(CurrCode)in[' ','A'..'z']Then Begin
  IncStr(S,'''');
  IncStr(S,Chr(CurrCode));
  IncStr(S,'''');
 End
  Else
 AddStr(S,HexByte2Str(CurrCode));
_End:
 Inc(I);
End;

{$I \Source\Chantal\Library\AddStr.Inc}
{$I \Source\Chantal\Library\HexByte.Inc}
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

Procedure DBStr;Assembler;ASM
 DB 3,'DB '
END;

Procedure _Reg8080;Assembler;ASM
 DB 'BCDEHLMA'
END;

Function Reg8080;Assembler;ASM
 MOV BL,I
 XOR BH,BH
 MOV AL,Byte Ptr _Reg8080[BX]
END;

Procedure EndSourcer8080;Assembler;ASM END;

END.