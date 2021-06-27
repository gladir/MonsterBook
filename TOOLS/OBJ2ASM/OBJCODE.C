#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "O.H"

#define NOTHING 0
#define ASCII   1
#define SPECIAL 2

#define BUFFSIZE    0x1000+0x10

#define GRP_SI  0xFF /* Segment Index */
#define GRP_EI  0xFE /* External Index */
#define GRP_SCO 0xFD /* Segment/Class/Overlay Indices */
#define GRP_LTL 0xFB /* Load Time Locatable */
#define GRP_ABS 0xFA /* Absolute */

                    /*----- Comment Record Types ------*/
#define MSLANG  0   /* 00h - MS Language Name          */
#define MSDOSV  156 /* BCh - MS DOS Level Number (?)   */
#define MSMODL  157 /* BDh - MS Memory Model (+opts)   */
#define MSDSEG  158 /* BEh - MS Forced 'DOSSEG' switch */
#define MSILIB  159 /* A0h - MS INCLUDELIB directive   */
#define MSEXTN  161 /* A1h - MS Extensions Enabled     */
#define UNKNWN  162 /* A2h - (?)                       */
#define MSLNAM  163 /* A3h - MS Library Module Name    */
#define PATIME  221 /* DDh - Phoenix Time Stamp        */
#define PACMNT  255 /* FFh - Phoenix Comment           */
#define TCXSYMTYPIX 0xe0
#define TCPUBSYMTYP 0xe1
#define TCSTRUCT 0xe2
#define TCTYPDEF 0xe3
#define TCENUM   0xe4
#define TCBEGSCP 0xe5
#define TCLOCDEF 0xE6
#define TCENDSCP 0xe7
#define TCSOURCE 0xe8
#define TCDEPFIL 0xe9
#define TCXLATOR 0xea
#define TCMANGLE 0xf8

#define LINE_SIZE   80

INST_T instr[]={
 mod_reg,     0,"ADD",   /* ADD     mem/reg,reg (byte) [00] */
 mod_reg,     1,"ADD",   /* ADD     mem/reg,reg (word) [01] */
 mod_reg,     2,"ADD",   /* ADD     reg,mem/reg (byte) [02] */
 mod_reg,     3,"ADD",   /* ADD     reg,mem/reg (word) [03] */
 two_byte,   AL,"ADD",   /* ADD     AL,kk              [04] */
 three_byte, AX,"ADD",   /* ADD     AX,jjkk            [05] */
 one_byte,   ES,"PUSH",  /* PUSH    ES                 [06] */
 one_byte,   ES,"POP",   /* POP     ES                 [07] */
 mod_reg,     0,"OR",    /* OR      mem/reg,reg (byte) [08] */
 mod_reg,     1,"OR",    /* OR      mem/reg,reg (word) [09] */
 mod_reg,     2,"OR",    /* OR      reg,mem/reg (byte) [0A] */
 mod_reg,     3,"OR",    /* OR      reg,mem/reg (word) [0B] */
 two_byte,   AL,"OR",    /* OR      AL,kk              [0C] */
 three_byte, AX,"OR",    /* OR      AX,jjkk            [0D] */
 one_byte,   CS,"PUSH",  /* PUSH    CS                 [0E] */
 extra,       0,"",      /* not used                   [0F] */
 mod_reg,     0,"ADC",   /* ADC     mem/reg,reg (byte) [10] */
 mod_reg,     1,"ADC",   /* ADC     mem/reg,reg (word) [11] */
 mod_reg,     2,"ADC",   /* ADC     reg,mem/reg (byte) [12] */
 mod_reg,     3,"ADC",   /* ADC     reg,mem/reg (word) [13] */
 two_byte,   AL,"ADC",   /* ADC     AL,kk              [14] */
 three_byte, AX,"ADC",   /* ADC     AX,jjkk            [15] */
 one_byte,   SS,"PUSH",  /* PUSH    SS                 [16] */
 one_byte,   SS,"POP",   /* POP     SS                 [17] */
 mod_reg,     0,"SBB",   /* SBB     mem/reg,reg (byte) [18] */
 mod_reg,     1,"SBB",   /* SBB     mem/reg,reg (word) [19] */
 mod_reg,     2,"SBB",   /* SBB     reg,mem/reg (byte) [1A] */
 mod_reg,     3,"SBB",   /* SBB     reg,mem/reg (word) [1B] */
 two_byte,   AL,"SBB",   /* SBB     AL,kk              [1C] */
 three_byte, AX,"SBB",   /* SBB     AX,jjkk            [1D] */
 one_byte,   DS,"PUSH",  /* PUSH    DS                 [1E] */
 one_byte,   DS,"POP",   /* POP     DS                 [1F] */
 mod_reg,     0,"AND",   /* AND     mem/reg,reg (byte) [20] */
 mod_reg,     1,"AND",   /* AND     mem/reg,reg (word) [21] */
 mod_reg,     2,"AND",   /* AND     reg,mem/reg (byte) [22] */
 mod_reg,     3,"AND",   /* AND     reg,mem/reg (word) [23] */
 two_byte,   AL,"AND",   /* AND     AL,kk              [24] */
 three_byte, AX,"AND",   /* AND     AX,jjkk            [25] */
 seg_over,    0,"",      /* SEGMENT OVERIDE "ES"       [26] */
 one_byte, NREG,"DAA",   /* DAA                        [27] */
 mod_reg,     0,"SUB",   /* SUB     mem/reg,reg (byte) [28] */
 mod_reg,     1,"SUB",   /* SUB     mem/reg,reg (word) [29] */
 mod_reg,     2,"SUB",   /* SUB     reg,mem/reg (byte) [2A] */
 mod_reg,     3,"SUB",   /* SUB     reg,mem/reg (word) [2B] */
 two_byte,   AL,"SUB",   /* SUB     AL,kk              [2C] */
 three_byte, AX,"SUB",   /* SUB     AX,jjkk            [2D] */
 seg_over,    0,"",      /* SEGMENT OVERIDE "CS"       [2E] */
 one_byte, NREG,"DAS",   /* DAS                        [2F] */
 mod_reg,     0,"XOR",   /* XOR     mem/reg,reg (byte) [30] */
 mod_reg,     1,"XOR",   /* XOR     mem/reg,reg (word) [31] */
 mod_reg,     2,"XOR",   /* XOR     reg,mem/reg (byte) [32] */
 mod_reg,     3,"XOR",   /* XOR     reg,mem/reg (word) [33] */
 two_byte,   AL,"XOR",   /* XOR     AL,kk              [34] */
 three_byte, AX,"XOR",   /* XOR     AX,jjkk            [35] */
 seg_over,    0,"",      /* SEGMENT OVERIDE "SS"       [36] */
 one_byte, NREG,"AAA",   /* AAA                        [37] */
 mod_reg,     0,"CMP",   /* CMP     mem/reg,reg (byte) [38] */
 mod_reg,     1,"CMP",   /* CMP     mem/reg,reg (word) [39] */
 mod_reg,     2,"CMP",   /* CMP     reg,mem/reg (byte) [3A] */
 mod_reg,     3,"CMP",   /* CMP     reg,mem/reg (word) [3B] */
 two_byte,   AL,"CMP",   /* CMP     AL,kk              [3C] */
 three_byte, AX,"CMP",   /* CMP     AX,jjkk            [3D] */
 seg_over,    0,"",      /* SEGMENT OVERIDE "DS"       [3E] */
 one_byte, NREG,"AAS",   /* AAS                        [3F] */
 one_byte,   AX,"INC",   /* INC     AX                 [40] */
 one_byte,   CX,"INC",   /* INC     CX                 [41] */
 one_byte,   DX,"INC",   /* INC     DX                 [42] */
 one_byte,   BX,"INC",   /* INC     BX                 [43] */
 one_byte,   SP,"INC",   /* INC     SP                 [44] */
 one_byte,   BP,"INC",   /* INC     BP                 [45] */
 one_byte,   SI,"INC",   /* INC     SI                 [46] */
 one_byte,   DI,"INC",   /* INC     DI                 [47] */
 one_byte,   AX,"DEC",   /* DEC     AX                 [48] */
 one_byte,   CX,"DEC",   /* DEC     CX                 [49] */
 one_byte,   DX,"DEC",   /* DEC     DX                 [4A] */
 one_byte,   BX,"DEC",   /* DEC     BX                 [4B] */
 one_byte,   SP,"DEC",   /* DEC     SP                 [4C] */
 one_byte,   BP,"DEC",   /* DEC     BP                 [4D] */
 one_byte,   SI,"DEC",   /* DEC     SI                 [4E] */
 one_byte,   DI,"DEC",   /* DEC     DI                 [4F] */
 one_byte,   AX,"PUSH",  /* PUSH    AX                 [50] */
 one_byte,   CX,"PUSH",  /* PUSH    CX                 [51] */
 one_byte,   DX,"PUSH",  /* PUSH    DX                 [52] */
 one_byte,   BX,"PUSH",  /* PUSH    BX                 [53] */
 one_byte,   SP,"PUSH",  /* PUSH    SP                 [54] */
 one_byte,   BP,"PUSH",  /* PUSH    BP                 [55] */
 one_byte,   SI,"PUSH",  /* PUSH    SI                 [56] */
 one_byte,   DI,"PUSH",  /* PUSH    DI                 [57] */
 one_byte,   AX,"POP",   /* POP     AX                 [58] */
 one_byte,   CX,"POP",   /* POP     CX                 [59] */
 one_byte,   DX,"POP",   /* POP     DX                 [5A] */
 one_byte,   BX,"POP",   /* POP     BX                 [5B] */
 one_byte,   SP,"POP",   /* POP     SP                 [5C] */
 one_byte,   BP,"POP",   /* POP     BP                 [5D] */
 one_byte,   SI,"POP",   /* POP     SI                 [5E] */
 one_byte,   DI,"POP",   /* POP     DI                 [5F] */
 one_byte, NREG,"PUSHA", /* PUSHA (PUSHAD on 386)      [60] */
 one_byte, NREG,"POPA",  /* POPA (POPAD on 386)        [61] */
 mod_reg,    17,"BOUND", /* BOUND                      [62] */
 mod_reg,     1,"ARPL",  /* ARPL                       [63] */
 seg_over,    0,"",      /* SEGMENT OVERIDE "FS" on 386[64] */
 seg_over,    0,"",      /* SEGMENT OVERIDE "GS" on 386[65] */
 opsize_over, 0,"",      /* OPERAND SIZE OVERIDE on 386[66] */
 AdrSizeOver, 0,"",      /* ADDRESS SIZE OVERIDE on 386[67] */
 three_byte,NREG,"PUSH", /* PUSH (immediate word)      [68] */
 mod_reg,    24,"IMUL",  /* IMUL reg,mem/reg,imm. word [69] */
 two_ubyte,   0,"PUSH\t",/* PUSH (immed. signed byte)  [6A] */
 mod_reg,    25,"IMUL",  /* IMUL reg,mem/reg,imm. byte [6B] */
 one_byte, NREG,"INSB",  /* INS     BYTE               [6C] */
 one_byte, NREG,"INSW",  /* INS     WORD               [6D] */
 one_byte, NREG,"OUTSB", /* OUTS    BYTE               [6E] */
 one_byte, NREG,"OUTSW", /* OUTS    WORD               [6F] */
 disp8,       0,"JO",    /* JO      <Label>            [70] */
 disp8,       0,"JNO",   /* JNO     <Label>            [71] */
 disp8,       0,"JC",    /* JC      <Label>            [72] */
 disp8,       0,"JNC",   /* JNC     <Label>            [73] */
 disp8,       0,"JZ",    /* JZ      <Label>            [74] */
 disp8,       0,"JNZ",   /* JNZ     <Label>            [75] */
 disp8,       0,"JBE",   /* JBE     <Label>            [76] */
 disp8,       0,"JNBE",  /* JNBE    <Label>            [77] */
 disp8,       0,"JS",    /* JS      <Label>            [78] */
 disp8,       0,"JNS",   /* JNS     <Label>            [79] */
 disp8,       0,"JP",    /* JP      <Label>            [7A] */
 disp8,       0,"JNP",   /* JNP     <Label>            [7B] */
 disp8,       0,"JL",    /* JL      <Label>            [7C] */
 disp8,       0,"JNL",   /* JNL     <Label>            [7D] */
 disp8,       0,"JNG",   /* JG      <Label>            [7E] */
 disp8,       0,"JG",    /* JNG     <Label>            [7F] */
 mod_reg,     4,"",      /* Special mem/reg,kk         [80] */
 mod_reg,     5,"",      /* Special mem/reg,jjkk       [81] */
 stub,        0,"",      /* not used                   [82] */
 mod_reg,     6,"",      /* Special mem/reg,kk (word)  [83] */
 mod_reg,     2,"TEST",  /* TEST    mem/reg,reg (byte) [84] */
 mod_reg,     3,"TEST",  /* TEST    mem/reg,reg (word) [85] */
 mod_reg,     2,"XCHG",  /* XCHG    reg,mem/reg (byte) [86] */
 mod_reg,     3,"XCHG",  /* XCHG    reg,mem/reg (word) [87] */
 mod_reg,     0,"MOV",   /* MOV     mem/reg,reg (byte) [88] */
 mod_reg,     1,"MOV",   /* MOV     mem/reg,reg (word) [89] */
 mod_reg,     2,"MOV",   /* MOV     reg,mem/reg (byte) [8A] */
 mod_reg,     3,"MOV",   /* MOV     reg,mem/reg (word) [8B] */
 mod_reg,     7,"MOV",   /* MOV     mem/reg,segreg     [8C] */
 mod_reg,     9,"LEA",   /* LEA     reg,mem/reg        [8D] */
 mod_reg,     8,"MOV",   /* MOV     segreg,mem/reg     [8E] */
 mod_reg,    10,"",      /* POP     mem/reg (Special)  [8F] */
 one_byte, NREG,"NOP",   /* NOP                        [90] */
 one_a,      CX,"XCHG",  /* XCHG    AX,CX              [91] */
 one_a,      DX,"XCHG",  /* XCHG    AX,DX              [92] */
 one_a,      BX,"XCHG",  /* XCHG    AX,BX              [93] */
 one_a,      SP,"XCHG",  /* XCHG    AX,SP              [94] */
 one_a,      BP,"XCHG",  /* XCHG    AX,BP              [95] */
 one_a,      SI,"XCHG",  /* XCHG    AX,SI              [96] */
 one_a,      DI,"XCHG",  /* XCHG    AX,DI              [97] */
 one_byte, NREG,"CBW",   /* CBW                        [98] */
 one_byte, NREG,"CWD",   /* CWD                        [99] */
 five_byte,   0,"CALL",  /* CALL    <Label>            [9A] */
 wait,        0,"WAIT",  /* WAIT                       [9B] */
 one_byte, NREG,"PUSHF", /* PUSHF                      [9C] */
 one_byte, NREG,"POPF",  /* POPF                       [9D] */
 one_byte, NREG,"SAHF",  /* SAHF                       [9E] */
 one_byte, NREG,"LAHF",  /* LAHF                       [9F] */
 three_a,     0,"MOV",   /* MOV     AL,addr            [A0] */
 three_a,     0,"MOV",   /* MOV     AX,addr            [A1] */
 three_a,     0,"MOV",   /* MOV     addr,AL            [A2] */
 three_a,     0,"MOV",   /* MOV     addr,AX            [A3] */
 string_byte, 0,"MOVS",  /* MOVS    BYTE               [A4] */
 string_byte, 0,"MOVS",  /* MOVS    WORD               [A5] */
 string_byte, 0,"CMPS",  /* CMPS    BYTE               [A6] */
 string_byte, 0,"CMPS",  /* CMPS    WORD               [A7] */
 two_byte,   AL,"TEST",  /* TEST    AL,addr            [A8] */
 three_byte, AX,"TEST",  /* TEST    AX,addr            [A9] */
 string_byte, 0,"STOS",  /* STOS    BYTE               [AA] */
 string_byte, 0,"STOS",  /* STOS    WORD               [AB] */
 string_byte, 0,"LODS",  /* LODS    BYTE               [AC] */
 string_byte, 0,"LODS",  /* LODS    WORD               [AD] */
 string_byte, 0,"SCAS",  /* SCAS    BYTE               [AE] */
 string_byte, 0,"SCAS",  /* SCAS    WORD               [AF] */
 two_byte,   AL,"MOV",   /* MOV     AL,kk              [B0] */
 two_byte,   CL,"MOV",   /* MOV     CL,kk              [B1] */
 two_byte,   DL,"MOV",   /* MOV     DL,kk              [B2] */
 two_byte,   BL,"MOV",   /* MOV     BL,kk              [B3] */
 two_byte,   AH,"MOV",   /* MOV     AH,kk              [B4] */
 two_byte,   CH,"MOV",   /* MOV     CH,kk              [B5] */
 two_byte,   DH,"MOV",   /* MOV     DH,kk              [B6] */
 two_byte,   BH,"MOV",   /* MOV     BH,kk              [B7] */
 three_byte, AX,"MOV",   /* MOV     AX,kk              [B8] */
 three_byte, CX,"MOV",   /* MOV     CX,kk              [B9] */
 three_byte, DX,"MOV",   /* MOV     DX,kk              [BA] */
 three_byte, BX,"MOV",   /* MOV     BX,kk              [BB] */
 three_byte, SP,"MOV",   /* MOV     SP,kk              [BC] */
 three_byte, BP,"MOV",   /* MOV     BP,kk              [BD] */
 three_byte, SI,"MOV",   /* MOV     SI,kk              [BE] */
 three_byte, DI,"MOV",   /* MOV     DI,kk              [BF] */
 mod_reg,    11,"",      /* Special mem/reg,kk  (byte) [C0] */
 mod_reg,    12,"",      /* Special mem/reg,kk  (word) [C1] */
 three_byte,NREG,"RET",  /* RET     jjkk               [C2] */
 one_byte, NREG,"RET",   /* RET                        [C3] */
 mod_reg,    17,"LES",   /* LES     reg,mem            [C4] */
 mod_reg,    17,"LDS",   /* LDS     reg,mem            [C5] */
 mod_reg,    18,"",      /* MOV     mem,kk   (Special) [C6] */
 mod_reg,    19,"",      /* MOV     mem,jjkk (Special) [C7] */
 enter,       0,"ENTER", /* ENTER   im. word,im. byte  [C8] */
 one_byte, NREG,"LEAVE", /* LEAVE                      [C9] */
 three_byte,NREG,"RETF", /* RETF    jjkk               [CA] */
 one_byte, NREG,"RETF",  /* RETF                       [CB] */
 one_byte, NREG,"INT\t3",/* INT     3                  [CC] */
 two_byte, NREG,"INT",   /* INT     type               [CD] */
 one_byte, NREG,"INTO",  /* INTO                       [CE] */
 one_byte, NREG,"IRET",  /* IRET                       [CF] */
 mod_reg,    13,"",      /* Special mem/reg,1  (byte)  [D0] */
 mod_reg,    14,"",      /* Special mem/reg,1  (word)  [D1] */
 mod_reg,    15,"",      /* Special mem/reg,CL (byte)  [D2] */
 mod_reg,    16,"",      /* Special mem/reg,CL (word)  [D3] */
 two_bcd,     0,"AAM",   /* AAM                        [D4] */
 two_bcd,     0,"AAD",   /* AAD                        [D5] */
 stub,        0,"",      /* not used                   [D6] */
 one_byte, NREG,"XLAT",  /* XLAT                       [D7] */
 esc,         0,"ESC",   /* ESC  (Special)             [D8] */
 esc,         0,"ESC",   /* ESC  (Special)             [D9] */
 esc,         0,"ESC",   /* ESC  (Special)             [DA] */
 esc,         0,"ESC",   /* ESC  (Special)             [DB] */
 esc,         0,"ESC",   /* ESC  (Special)             [DC] */
 esc,         0,"ESC",   /* ESC  (Special)             [DD] */
 esc,         0,"ESC",   /* ESC  (Special)             [DE] */
 esc,         0,"ESC",   /* ESC  (Special)             [DF] */
 disp8,       0,"LOOPNZ",/* LOOPNZ                     [E0] */
 disp8,       0,"LOOPZ", /* LOOPZ                      [E1] */
 disp8,       0,"LOOP",  /* LOOP                       [E2] */
 disp8,       0,"JCXZ",  /* JCXZ                       [E3] */
 two_byte,   AL,"IN",    /* IN      AL,kk              [E4] */
 two_byte,   AX,"IN",    /* IN      AX,kk              [E5] */
 two_a,       0,"OUT",   /* OUT     kk,AL              [E6] */
 two_a,       0,"OUT",   /* OUT     kk,AX              [E7] */
 disp16,      0,"CALL",  /* CALL    <Label>            [E8] */
 disp16,      0,"JMP",   /* JMP     <Label>            [E9] */
 five_byte,   0,"JMP",   /* JMP     <Label>            [EA] */
 disp8,       0,"JMP",   /* JMP     SHORT <Label>      [EB] */
 in_out,     DX,"IN",    /* IN      AL,DX              [EC] */
 in_out,     DX,"IN",    /* IN      AX,DX              [ED] */
 in_out,     DX,"OUT",   /* OUT     DX,AL              [EE] */
 in_out,     DX,"OUT",   /* OUT     DX,AX              [EF] */
 prefix,      0,"LOCK",  /* LOCK                       [F0] */
 stub,        0,"",      /* not used                   [F1] */
 prefix,      0,"REPNZ", /* REPNZ                      [F2] */
 prefix,      0,"REPZ",  /* REPZ                       [F3] */
 one_byte,    0,"HLT",   /* HLT                        [F4] */
 one_byte,    0,"CMC",   /* CMC                        [F5] */
 mod_reg,    20,"",      /* Special (byte) (Group 3)   [F6] */
 mod_reg,    21,"",      /* Special (word) (Group 3)   [F7] */
 one_byte,    0,"CLC",   /* CLC                        [F8] */
 one_byte,    0,"STC",   /* STC                        [F9] */
 one_byte,    0,"CLI",   /* CLI                        [FA] */
 one_byte,    0,"STI",   /* STI                        [FB] */
 one_byte,    0,"CLD",   /* CLD                        [FC] */
 one_byte,    0,"STD",   /* STD                        [FD] */
 mod_reg,    22,"",      /* Special (Group 4)          [FE] */
 mod_reg,    23,""};     /* Special (Group 4)          [FF] */

char *esc_inst[] = {
 "FADD",   /* FADD (DWord Ptr)   [00] */
 "FMUL",   /* FMUL (DWord Ptr)   [01] */
 "FCOM",   /* FCOM (DWord Ptr)   [02] */
 "FCOMP",  /* FCOMP (DWord Ptr)  [03] */
 "FSUB",   /* FSUB (DWord Ptr)   [04] */
 "FSUBR",  /* FSUBR (DWord Ptr)  [05] */
 "FDIV",   /* FDIV (DWord Ptr)   [06] */
 "FDIVR",  /* FDIVR (DWord Ptr)  [07] */
 "FLD",    /* FLD (DWord Ptr)    [08] */
 "",       /* ESC 09h            [09] */
 "FST",    /* FST (DWord Ptr)    [0A] */
 "FSTP",   /* FSTP (DWord Ptr)   [0B] */
 "FLDENV", /* FLDENV             [0C] */
 "FLDCW",  /* FLDCW              [0D] */
 "FNSTENV",/* FSTENV             [0E] */
 "FNSTCW", /* FSTCW              [0F] */
 "FIADD",  /* FIADD (DWord Ptr)  [10] */
 "FIMUL",  /* FIMUL (DWord Ptr)  [11] */
 "FICOM",  /* FICOM (DWord Ptr)  [12] */
 "FICOMP", /* FICOMP (DWord Ptr) [13] */
 "FISUB",  /* FISUB (DWord Ptr)  [14] */
 "FISUBR", /* FISUBR (DWord Ptr) [15] */
 "FIDIV",  /* FIDIV (DWord Ptr)  [16] */
 "FIDIVR", /* FIDIVR (DWord Ptr) [17] */
 "FILD",   /* FILD (DWord Ptr)   [18] */
 "",       /* ESC 19h            [19] */
 "FIST",   /* FIST (DWord Ptr)   [1A] */
 "FISTP",  /* FISTP (DWord Ptr)  [1B] */
 "",       /* ESC 1Ch            [1C] */
 "FLD",    /* FLD (TByte Ptr)    [1D] */
 "",       /* ESC 1Eh            [1E] */
 "FSTP",   /* FSTP (TByte Ptr)   [1F] */
 "FADD",   /* FADD (QWord Ptr)   [20] */
 "FMUL",   /* FMUL (QWord Ptr)   [21] */
 "FCOM",   /* FCOM (QWord Ptr)   [22] */
 "FCOMP",  /* FCOMP (QWord Ptr)  [23] */
 "FSUB",   /* FSUB (QWord Ptr)   [24] */
 "FSUBR",  /* FSUBR (QWord Ptr)  [25] */
 "FDIV",   /* FDIV (QWord Ptr)   [26] */
 "FDIVR",  /* FDIVR (QWord Ptr)  [27] */
 "FLD",    /* FLD (QWord Ptr)    [28] */
 "",       /* ESC 29h            [29] */
 "FST",    /* FST (QWord Ptr)    [2A] */
 "FSTP",   /* FSTP (QWord Ptr)   [2B] */
 "FRSTOR", /* FRSTOR             [2C] */
 "",       /* ESC 2Dh            [2D] */
 "FNSAVE", /* FSAVE              [2E] */
 "FNSTSW", /* FSTSW              [2F] */
 "FIADD",  /* FIADD (Word Ptr)   [30] */
 "FIMUL",  /* FIMUL (Word Ptr)   [31] */
 "FICOM",  /* FICOM (Word Ptr)   [32] */
 "FICOMP", /* FICOMP (Word Ptr)  [33] */
 "FISUB",  /* FISUB (Word Ptr)   [34] */
 "FISUBR", /* FISUBR (Word Ptr)  [35] */
 "FIDIV",  /* FIDIV (Word Ptr)   [36] */
 "FIDIVR", /* FIDIVR (Word Ptr)  [37] */
 "FILD",   /* FILD (Word Ptr)    [38] */
 "",       /* ESC 39h            [39] */
 "FIST",   /* FIST (Word Ptr)    [3A] */
 "FISTP",  /* FISTP (Word Ptr)   [3B] */
 "FBLD",   /* FBLD (TByte Ptr)   [3C] */
 "FILD",   /* FILD (QWord Ptr)   [3D] */
 "FBSTP",  /* FBSTP (QWord Ptr)  [3E] */
 "FISTP",};/* FISTP (QWord Ptr)  [3F] */

INST_T  ex_instr[]={
 mod_reg,    26,"",      /* Spec. (word) (grp 6)   [0F] [00] */
 mod_reg,    27,"",      /* Spec. (dword) (grp 7)  [0F] [01] */
 mod_reg,    28,"LAR",   /* LAR                    [0F] [02] */
 mod_reg,    28,"LSL",   /* LSL                    [0F] [03] */
 stub,        0,"",      /* not used               [0F] [04] */
 stub,        0,"",      /* not used               [0F] [05] */
 one_byte, NREG,"CLTS",  /* not used               [0F] [06] */
 stub,        0,"",      /* not used               [0F] [07] */
 one_byte, NREG,"",      /* INVD (486 only)        [0F] [08] */
 one_byte, NREG,"",      /* WBINVD (486 only)      [0F] [09] */
 stub,        0,"",      /* not used               [0F] [0A] */
 stub,        0,"",      /* not used               [0F] [0B] */
 stub,        0,"",      /* not used               [0F] [0C] */
 stub,        0,"",      /* not used               [0F] [0D] */
 stub,        0,"",      /* not used               [0F] [0E] */
 stub,        0,"",      /* not used               [0F] [0F] */
 stub,        0,"",      /* not used               [0F] [10] */
 stub,        0,"",      /* not used               [0F] [11] */
 stub,        0,"",      /* not used               [0F] [12] */
 stub,        0,"",      /* not used               [0F] [13] */
 stub,        0,"",      /* not used               [0F] [14] */
 stub,        0,"",      /* not used               [0F] [15] */
 stub,        0,"",      /* not used               [0F] [16] */
 stub,        0,"",      /* not used               [0F] [17] */
 stub,        0,"",      /* not used               [0F] [18] */
 stub,        0,"",      /* not used               [0F] [19] */
 stub,        0,"",      /* not used               [0F] [1A] */
 stub,        0,"",      /* not used               [0F] [1B] */
 stub,        0,"",      /* not used               [0F] [1C] */
 stub,        0,"",      /* not used               [0F] [1D] */
 stub,        0,"",      /* not used               [0F] [1E] */
 stub,        0,"",      /* not used               [0F] [1F] */
 mod_reg,    31,"MOV",   /* MOV      r32,CRx       [0F] [20] */
 mod_reg,    32,"MOV",   /* MOV      CRx,r32       [0F] [21] */
 mod_reg,    33,"MOV",   /* MOV      r32,DRx       [0F] [22] */
 mod_reg,    34,"MOV",   /* MOV      DRx,r32       [0F] [23] */
 mod_reg,    35,"MOV",   /* MOV      r32,TRx       [0F] [24] */
 stub,        0,"",      /* not used               [0F] [25] */
 mod_reg,    36,"MOV",   /* MOV      TRx,r32       [0F] [26] */
 stub,        0,"",      /* not used               [0F] [27] */
 stub,        0,"",      /* not used               [0F] [28] */
 stub,        0,"",      /* not used               [0F] [29] */
 stub,        0,"",      /* not used               [0F] [2A] */
 stub,        0,"",      /* not used               [0F] [2B] */
 stub,        0,"",      /* not used               [0F] [2C] */
 stub,        0,"",      /* not used               [0F] [2D] */
 stub,        0,"",      /* not used               [0F] [2E] */
 stub,        0,"",      /* not used               [0F] [2F] */
 stub,        0,"",      /* not used               [0F] [30] */
 stub,        0,"",      /* not used               [0F] [31] */
 stub,        0,"",      /* not used               [0F] [32] */
 stub,        0,"",      /* not used               [0F] [33] */
 stub,        0,"",      /* not used               [0F] [34] */
 stub,        0,"",      /* not used               [0F] [05] */
 stub,        0,"",      /* not used               [0F] [36] */
 stub,        0,"",      /* not used               [0F] [37] */
 stub,        0,"",      /* not used               [0F] [38] */
 stub,        0,"",      /* not used               [0F] [39] */
 stub,        0,"",      /* not used               [0F] [3A] */
 stub,        0,"",      /* not used               [0F] [3B] */
 stub,        0,"",      /* not used               [0F] [3C] */
 stub,        0,"",      /* not used               [0F] [3D] */
 stub,        0,"",      /* not used               [0F] [3E] */
 stub,        0,"",      /* not used               [0F] [3F] */
 stub,        0,"",      /* not used               [0F] [40] */
 stub,        0,"",      /* not used               [0F] [41] */
 stub,        0,"",      /* not used               [0F] [42] */
 stub,        0,"",      /* not used               [0F] [43] */
 stub,        0,"",      /* not used               [0F] [44] */
 stub,        0,"",      /* not used               [0F] [45] */
 stub,        0,"",      /* not used               [0F] [46] */
 stub,        0,"",      /* not used               [0F] [47] */
 stub,        0,"",      /* not used               [0F] [48] */
 stub,        0,"",      /* not used               [0F] [49] */
 stub,        0,"",      /* not used               [0F] [4A] */
 stub,        0,"",      /* not used               [0F] [4B] */
 stub,        0,"",      /* not used               [0F] [4C] */
 stub,        0,"",      /* not used               [0F] [4D] */
 stub,        0,"",      /* not used               [0F] [4E] */
 stub,        0,"",      /* not used               [0F] [4F] */
 stub,        0,"",      /* not used               [0F] [50] */
 stub,        0,"",      /* not used               [0F] [51] */
 stub,        0,"",      /* not used               [0F] [52] */
 stub,        0,"",      /* not used               [0F] [53] */
 stub,        0,"",      /* not used               [0F] [54] */
 stub,        0,"",      /* not used               [0F] [55] */
 stub,        0,"",      /* not used               [0F] [56] */
 stub,        0,"",      /* not used               [0F] [57] */
 stub,        0,"",      /* not used               [0F] [58] */
 stub,        0,"",      /* not used               [0F] [59] */
 stub,        0,"",      /* not used               [0F] [5A] */
 stub,        0,"",      /* not used               [0F] [5B] */
 stub,        0,"",      /* not used               [0F] [5C] */
 stub,        0,"",      /* not used               [0F] [5D] */
 stub,        0,"",      /* not used               [0F] [5E] */
 stub,        0,"",      /* not used               [0F] [5F] */
 stub,        0,"",      /* not used               [0F] [60] */
 stub,        0,"",      /* not used               [0F] [61] */
 stub,        0,"",      /* not used               [0F] [62] */
 stub,        0,"",      /* not used               [0F] [63] */
 stub,        0,"",      /* not used               [0F] [64] */
 stub,        0,"",      /* not used               [0F] [65] */
 stub,        0,"",      /* not used               [0F] [66] */
 stub,        0,"",      /* not used               [0F] [67] */
 stub,        0,"",      /* not used               [0F] [68] */
 stub,        0,"",      /* not used               [0F] [69] */
 stub,        0,"",      /* not used               [0F] [6A] */
 stub,        0,"",      /* not used               [0F] [6B] */
 stub,        0,"",      /* not used               [0F] [6C] */
 stub,        0,"",      /* not used               [0F] [6D] */
 stub,        0,"",      /* not used               [0F] [6E] */
 stub,        0,"",      /* not used               [0F] [6F] */
 stub,        0,"",      /* not used               [0F] [70] */
 stub,        0,"",      /* not used               [0F] [71] */
 stub,        0,"",      /* not used               [0F] [72] */
 stub,        0,"",      /* not used               [0F] [73] */
 stub,        0,"",      /* not used               [0F] [74] */
 stub,        0,"",      /* not used               [0F] [75] */
 stub,        0,"",      /* not used               [0F] [76] */
 stub,        0,"",      /* not used               [0F] [77] */
 stub,        0,"",      /* not used               [0F] [78] */
 stub,        0,"",      /* not used               [0F] [79] */
 stub,        0,"",      /* not used               [0F] [7A] */
 stub,        0,"",      /* not used               [0F] [7B] */
 stub,        0,"",      /* not used               [0F] [7C] */
 stub,        0,"",      /* not used               [0F] [7D] */
 stub,        0,"",      /* not used               [0F] [7E] */
 stub,        0,"",      /* not used               [0F] [7F] */
 disp16,      0,"JO",    /* JO       <Label>       [0F] [80] */
 disp16,      0,"JNO",   /* JNO      <Label>       [0F] [81] */
 disp16,      0,"JB",    /* JB       <Label>       [0F] [82] */
 disp16,      0,"JNB",   /* JNB      <Label>       [0F] [83] */
 disp16,      0,"JZ",    /* JO       <Label>       [0F] [84] */
 disp16,      0,"JNZ",   /* JNO      <Label>       [0F] [85] */
 disp16,      0,"JBE",   /* JBE      <Label>       [0F] [86] */
 disp16,      0,"JNBE",  /* JNBE     <Label>       [0F] [87] */
 disp16,      0,"JS",    /* JS       <Label>       [0F] [88] */
 disp16,      0,"JNS",   /* JNS      <Label>       [0F] [89] */
 disp16,      0,"JP",    /* JP       <Label>       [0F] [8A] */
 disp16,      0,"JNP",   /* JNP      <Label>       [0F] [8B] */
 disp16,      0,"JL",    /* JL       <Label>       [0F] [8C] */
 disp16,      0,"JNL",   /* JNL      <Label>       [0F] [8D] */
 disp16,      0,"JLE",   /* JLE      <Label>       [0F] [8E] */
 disp16,      0,"JNLE",  /* JNLE     <Label>       [0F] [8F] */
 mod_reg,    30,"SETO",  /* SETO     mem/reg       [0F] [90] */
 mod_reg,    30,"SETNO", /* SETNO    mem/reg       [0F] [91] */
 mod_reg,    30,"SETB",  /* SETB     mem/reg       [0F] [92] */
 mod_reg,    30,"SETNB", /* SETNB    mem/reg       [0F] [93] */
 mod_reg,    30,"SETZ",  /* SETZ     mem/reg       [0F] [94] */
 mod_reg,    30,"SETNZ", /* SETNZ    mem/reg       [0F] [95] */
 mod_reg,    30,"SETBE", /* SETNE    mem/reg       [0F] [96] */
 mod_reg,    30,"SETNBE",/* SETNBE   mem/reg       [0F] [97] */
 mod_reg,    30,"SETS",  /* SETS     mem/reg       [0F] [98] */
 mod_reg,    30,"SETNS", /* SETNS    mem/reg       [0F] [99] */
 mod_reg,    30,"SETP",  /* SETP     mem/reg       [0F] [9A] */
 mod_reg,    30,"SETNP", /* SETNP    mem/reg       [0F] [9B] */
 mod_reg,    30,"SETL",  /* SETL     mem/reg       [0F] [9C] */
 mod_reg,    30,"SETNL", /* SETNL    mem/reg       [0F] [9D] */
 mod_reg,    30,"SETLE", /* SETLE    mem/reg       [0F] [9E] */
 mod_reg,    30,"SETNLE",/* SETNLE   mem/reg       [0F] [9F] */
 one_byte,   FS,"PUSH",  /* PUSH FS                [0F] [A0] */
 one_byte,   FS,"POP",   /* POP FS                 [0F] [A1] */
 stub,        0,"",      /* not used               [0F] [A2] */
 mod_reg,     1,"BT",    /* BT       mem/reg,reg   [0F] [A3] */
 mod_reg,    39,"SHLD",  /* SHLD     mem,reg,immb  [0F] [A4] */
 mod_reg,    40,"SHLD",  /* SHLD     mem,reg,cl    [0F] [A5] */
 mod_reg,     0,"",      /* CMPXCHG                [0F] [A6] */
 mod_reg,     1,"",      /* CMPXCHG                [0F] [A7] */
 one_byte,   GS,"PUSH",  /* PUSH GS                [0F] [A8] */
 one_byte,   GS,"POP",   /* POP GS                 [0F] [A9] */
 stub,        0,"",      /* not used               [0F] [AA] */
 mod_reg,     1,"BTS",   /* BTS      mem/reg,reg   [0F] [AB] */
 mod_reg,    39,"SHRD",  /* SHRD     mem,reg,immb  [0F] [AC] */
 mod_reg,    40,"SHRD",  /* SHRD     mem,reg,cl    [0F] [AD] */
 stub,        0,"",      /* not used               [0F] [AE] */
 mod_reg,     3,"IMUL",  /* IMUL     reg,mem/reg   [0F] [AF] */
 stub,        0,"",      /* not used               [0F] [B0] */
 stub,        0,"",      /* not used               [0F] [B1] */
 mod_reg,    17,"LSS",   /* LSS      reg,mem       [0F] [B2] */
 mod_reg,     1,"BTR",   /* BTR      mem/reg,reg   [0F] [B3] */
 mod_reg,    17,"LFS",   /* LFS      reg,mem       [0F] [B4] */
 mod_reg,    17,"LGS",   /* LGS      reg,mem       [0F] [B5] */
 mod_reg,    37,"MOVZX", /* MOVZX    reg,mem (b)   [0F] [B6] */
 mod_reg,    38,"MOVZX", /* MOVZX    reg,mem (w)   [0F] [B7] */
 stub,        0,"",      /* not used               [0F] [B8] */
 stub,        0,"",      /* not used               [0F] [B9] */
 mod_reg,    29,"",      /* Spec. (byte) (Group 8) [0F] [BA] */
 mod_reg,     1,"BTC",   /* BTC      mem/reg,reg   [0F] [BB] */
 mod_reg,     3,"BSF",   /* BSF      reg,mem/reg   [0F] [BC] */
 mod_reg,     3,"BSR",   /* BSR      reg,mem/reg   [0F] [BD] */
 mod_reg,    37,"MOVSX", /* MOVSX    reg,mem (b)   [0F] [BE] */
 mod_reg,    38,"MOVSX", /* MOVSX    reg,mem (w)   [0F] [BF] */
 mod_reg,     0,"",      /* XADD (486 only)        [0F] [C0] */
 mod_reg,     1,"",      /* XADD (486 only)        [0F] [C1] */
 stub,        0,"",      /* not used               [0F] [C2] */
 stub,        0,"",      /* not used               [0F] [C3] */
 stub,        0,"",      /* not used               [0F] [C4] */
 stub,        0,"",      /* not used               [0F] [C5] */
 stub,        0,"",      /* not used               [0F] [C6] */
 stub,        0,"",      /* not used               [0F] [C7] */
 one_byte,   AX,"",      /* BSWAP AX (486 only)    [0F] [C8] */
 one_byte,   CX,"",      /* BSWAP CX (486 only)    [0F] [C9] */
 one_byte,   DX,"",      /* BSWAP DX (486 only)    [0F] [CA] */
 one_byte,   BX,"",      /* BSWAP BX (486 only)    [0F] [CB] */
 one_byte,   SP,"",      /* BSWAP SP (486 only)    [0F] [CC] */
 one_byte,   BP,"",      /* BSWAP BP (486 only)    [0F] [CD] */
 one_byte,   SI,"",      /* BSWAP SI (486 only)    [0F] [CE] */
 one_byte,   DI,"",      /* BSWAP DI (486 only)    [0F] [CF] */
 stub,        0,"",      /* not used               [0F] [D0] */
 stub,        0,"",      /* not used               [0F] [D1] */
 stub,        0,"",      /* not used               [0F] [D2] */
 stub,        0,"",      /* not used               [0F] [D3] */
 stub,        0,"",      /* not used               [0F] [D4] */
 stub,        0,"",      /* not used               [0F] [D5] */
 stub,        0,"",      /* not used               [0F] [D6] */
 stub,        0,"",      /* not used               [0F] [D7] */
 stub,        0,"",      /* not used               [0F] [D8] */
 stub,        0,"",      /* not used               [0F] [D9] */
 stub,        0,"",      /* not used               [0F] [DA] */
 stub,        0,"",      /* not used               [0F] [DB] */
 stub,        0,"",      /* not used               [0F] [DC] */
 stub,        0,"",      /* not used               [0F] [DD] */
 stub,        0,"",      /* not used               [0F] [DE] */
 stub,        0,"",      /* not used               [0F] [DF] */
 stub,        0,"",      /* not used               [0F] [E0] */
 stub,        0,"",      /* not used               [0F] [E1] */
 stub,        0,"",      /* not used               [0F] [E2] */
 stub,        0,"",      /* not used               [0F] [E3] */
 stub,        0,"",      /* not used               [0F] [E4] */
 stub,        0,"",      /* not used               [0F] [E5] */
 stub,        0,"",      /* not used               [0F] [E6] */
 stub,        0,"",      /* not used               [0F] [E7] */
 stub,        0,"",      /* not used               [0F] [E8] */
 stub,        0,"",      /* not used               [0F] [E9] */
 stub,        0,"",      /* not used               [0F] [EA] */
 stub,        0,"",      /* not used               [0F] [EB] */
 stub,        0,"",      /* not used               [0F] [EC] */
 stub,        0,"",      /* not used               [0F] [ED] */
 stub,        0,"",      /* not used               [0F] [EE] */
 stub,        0,"",      /* not used               [0F] [EF] */
 stub,        0,"",      /* not used               [0F] [F0] */
 stub,        0,"",      /* not used               [0F] [F1] */
 stub,        0,"",      /* not used               [0F] [F2] */
 stub,        0,"",      /* not used               [0F] [F3] */
 stub,        0,"",      /* not used               [0F] [F4] */
 stub,        0,"",      /* not used               [0F] [F5] */
 stub,        0,"",      /* not used               [0F] [F6] */
 stub,        0,"",      /* not used               [0F] [F7] */
 stub,        0,"",      /* not used               [0F] [F8] */
 stub,        0,"",      /* not used               [0F] [F9] */
 stub,        0,"",      /* not used               [0F] [FA] */
 stub,        0,"",      /* not used               [0F] [FB] */
 stub,        0,"",      /* not used               [0F] [FC] */
 stub,        0,"",      /* not used               [0F] [FD] */
 stub,        0,"",      /* not used               [0F] [FE] */
 stub,        0,"",      /* not used               [0F] [FF] */
};

FIXER_T fix_type[]={1,"DB","Low ",2,"DW","Offset ",2,"DW","Seg ",
                    4,"DD","Ptr ",1,"DB","High ",2,"DW","Offset "};
char *al_text[]={"?ALIGN","BYTE","WORD","PARA","PAGE","DWORD","?ALIGN","?ALIGN"};
char *cb_text[]={"","MEMORY","PUBLIC","?COMBINE","?COMBINE","STACK","COMMON","?COMBINE"};
char *use_text[]={"USE16","USE32"};
char *ext_type[]={"ABS","NEAR","FAR","BYTE","WORD","DWORD","FWORD","QWORD","TBYTE"};

static char *esc_0x0X[]={
 "FCHS"   ,"FABS"   ,""       ,"",      // [0C:0] - [0C:3]
 "FTST"   ,"FXAM"   ,""       ,"",      // [0C:4] - [0C:7]
 "FLD1"   ,"FLDL2T" ,"FLDL2E" ,"FLDPI", // [0D:0] - [0D:3]
 "FLDLG2" ,"FLDLN2" ,"FLDZ"   ,"",      // [0D:4] - [0D:7]
 "F2XM1"  ,"FYL2X"  ,"FPTAN"  ,"FPATAN",// [0E:0] - [0E:3]
 "FXTRACT","FPREM1" ,"FDECSTP","FINCSTP",//[0E:4] - [0E:7]
 "FPREM"  ,"FYL2XP1","FSQRT"  ,"FSINCOS",//[0F:0] - [0F:3]
 "FRNDINT","FSCALE" ,"FSIN"   ,"FCOS"}; // [0F:4] - [0F:7]

static char*esc_0x1C[]={"FNENI","FNDISI","FNCLEX","FNINIT","","","",""};

char*regs[4][8]={
 "AL","CL","DL","BL","AH","CH","DH","BH",
 "AX","CX","DX","BX","SP","BP","SI","DI",
 "EAX","ECX","EDX","EBX","ESP","EBP","ESI","EDI",
 "??","??","??","??","??","??","??","??"};

char*sregs []={"ES","CS","SS","DS","FS","GS"};
char*sregsc[]={"ES:","CS:","SS:","DS:","FS:","GS:"};
char*cr_regs[]={"CR0","","CR2","CR3","","","",""};
char*dr_regs[]={"DR0","DR1","DR2","DR3","","","DR6","DR7"};
char*tr_regs[]={"","","","","","","TR6","TR7"};
char*addr_mode[]={"[BX+SI","[BX+DI","[BP+SI","[BP+DI","[SI","[DI","[BP","[BX"};
char*addr_386m[]={"[EAX","[ECX","[EDX","[EBX","[ESP","[EBP","[ESI","[EDI"};
char*sib_scale[]={"","*2","*4","*8"};

char*op_grp[10][8]={
 "ADD", "OR",  "ADC", "SBB", "AND", "SUB", "XOR", "CMP",
 "ROL", "ROR", "RCL", "RCR", "SHL", "SHR", "",    "SAR",
 "TEST","",    "NOT", "NEG", "MUL", "IMUL","DIV", "IDIV",
 "INC", "DEC", "",    "",    "",    "",    "",    "",
 "INC", "DEC", "CALL","CALL","JMP", "JMP", "PUSH","",
 "SLDT","STR", "LLDT","LTR", "VERR","VERW","",    "",
 "SGDT","SIDT","LGDT","LIDT","SMSW","",    "LMSW","",
 "",    "",    "",    "",    "BT",  "BTS", "BTR", "BTC",
 "POP", "",    "",    "",    "",    "",    "",    "",
 "MOV", "",    "",    "",    "",    "",    "",    ""};

char*sz_text[]={"Byte Ptr ","Word Ptr ","DWord Ptr ","QWord Ptr ","TByte Ptr "};
char*dir_fmt[]={"%s,%s","%s,%s","%s","%s,%s,%s","%s,%s,%s"};

static char*models[]={"tiny","small","medium","compact","large","huge"};
static char*months[]={"(nul)","Jan","F‚v","Mar","Avr","Mai","Jun","Jul","Ao–","Sep","Oct","Nov","D‚c"};

struct modrm_s{int dir,size,method,group,SizeNeeded,type;};
typedef struct modrm_s MODRM_CLASS;

MODRM_CLASS modrm_class[]={
 0,0, 1, 0,FALSE,UNKNOWN,    /*  0 Math instructions (byte) M,reg */
 0,1, 1, 0,FALSE,UNKNOWN,    /*  1 Math instructions (word) M,reg (and ARPL) */
 1,0, 1, 0,FALSE,UNKNOWN,    /*  2 Math instructions (byte) reg,M */
 1,1, 1, 0,FALSE,UNKNOWN,    /*  3 Math instructions (word) reg,M */
 0,0, 5, 1,TRUE, UNKNOWN,    /*  4 Group 1 (math) byte */
 0,1, 6, 1,TRUE, UNKNOWN,    /*  5 Group 1 (math) word */
 0,1, 7, 1,TRUE, UNKNOWN,    /*  6 Group 1 (math) signed byte */
 0,1, 2, 0,TRUE, UNKNOWN,    /*  7 Segment register unloading */
 1,1, 2, 0,TRUE, UNKNOWN,    /*  8 Segment register loading */
 1,1, 1, 0,FALSE,UNKNOWN,    /*  9 LEA instruction */
 2,1, 0, 9,FALSE,UNKNOWN,    /* 10 POP mod 0 r/m instruction */
 0,0, 5, 2,FALSE,UNKNOWN,    /* 11 Group 2 (rotates) byte */
 0,1, 5, 2,FALSE,UNKNOWN,    /* 12 Group 2 (rotates) word */
 0,0, 3, 2,TRUE, UNKNOWN,    /* 13 Group 2 (rotates) byte by 1 */
 0,1, 3, 2,TRUE, UNKNOWN,    /* 14 Group 2 (rotates) word by 1 */
 0,0, 4, 2,TRUE, UNKNOWN,    /* 15 Group 2 (rotates) byte by CL */
 0,1, 4, 2,TRUE, UNKNOWN,    /* 16 Group 2 (rotates) word by CL */
 1,2, 1, 0,FALSE,UNKNOWN,    /* 17 LES,LDS,BOUND,LSS,LFS,LGS */
 0,0, 5,10,TRUE, UNKNOWN,    /* 18 Move immediate (byte) */
 0,1, 6,10,TRUE, UNKNOWN,    /* 19 Move immediate (word) */
 2,0, 0, 3,FALSE,UNKNOWN,    /* 20 Group 3 (special) byte */
 2,1, 0, 3,FALSE,UNKNOWN,    /* 21 Group 3 (special) word */
 2,0, 0, 4,TRUE, UNKNOWN,    /* 22 Group 4 (inc/dec) byte */
 2,1, 0, 5,FALSE,UNKNOWN,    /* 23 Group 5 (special) word/dword */
 3,1, 8, 0,FALSE,UNKNOWN,    /* 24 IMUL (3 parms [reg,mem,immed word]) */
 3,1, 9, 0,FALSE,UNKNOWN,    /* 25 IMUL (3 parms [reg,mem,immed signed byte]) */
 2,1, 0, 6,FALSE,UNKNOWN,    /* 26 Group 6 (special 286/386 instructions) */
 2,3, 0, 7,TRUE, FWORD_PTR,  /* 27 Group 7 (special 286/386 instructions) */
 1,1, 1, 0,TRUE, UNKNOWN,    /* 28 LAR,LSL reg,M (word) */
 0,0, 5, 8,TRUE, BYTE_PTR,   /* 29 Group 8 (386-bit) byte */
 2,0, 0, 0,TRUE, BYTE_PTR,   /* 30 386 Set cc Instructions */
 0,2,10, 0,FALSE,UNKNOWN,    /* 31 386 Mov r32,crX */
 1,2,10, 0,FALSE,UNKNOWN,    /* 32 386 Mov crX,r32 */
 0,2,11, 0,FALSE,UNKNOWN,    /* 33 386 Mov r32,drX */
 1,2,11, 0,FALSE,UNKNOWN,    /* 34 386 Mov drX,r32 */
 0,2,12, 0,FALSE,UNKNOWN,    /* 35 386 Mov r32,trX */
 1,2,12, 0,FALSE,UNKNOWN,    /* 36 386 Mov trX,r32 */
 1,1, 1, 0,TRUE, BYTE_PTR,   /* 37 386 Movsx, Movzx */
 1,1, 1, 0,TRUE, WORD_PTR,   /* 38 386 Movsx, Movzx */
 4,1, 9, 0,TRUE, UNKNOWN,    /* 39 386 Shld,Shrd mem/reg,reg,imm byte */
 4,1,13, 0,TRUE, UNKNOWN,    /* 40 386 Shld,Shrd mem/reg,reg,cl */
};

struct hint_word_s {char*text;int type;};
struct hint_word_s hint_words[]={{"DB",BYTE_PTR},{"DW",WORD_PTR},
    {"DD",DWORD_PTR},{"DF",FWORD_PTR},{"DQ",QWORD_PTR},{"DT",TBYTE_PTR},};

typedef struct{Word seconds:5;Word minute:6;Word hour:5;}TIME;
typedef struct{Word day:5;Word month:4;Word year:7;}DATE;

extern THREAD_T threads[2][4];

int over_seg=-1;
static int OverOpSize=False,OverAdrSize=False;
static int SizeLarge=False,AddrLarge=False;
static int SizeBytes=2, AddrBytes=2;
static char fp_opcode[8]={0},fp_wait=False,hex_comment[COMSIZE]={0};
static char idb_buff[256],dup_buff[256],struc_buff[256],StrucForm[128];
static NODE_T*sex_node,*data_node;
static DAT_T*DataRec;
static int RecOverUsed=0,col_cnt=0;
int hint_nwords=sizeof(hint_words)/sizeof(char*),tab_at=0;
char*buff_beg,*buff_end,*buff_cur;
char buff[BUFFSIZE]={'\0'},grp_operands[100]={0};
int data_seg_idx;
DWord DataOfs;

static void AbortAssumes();
static void AdjustAssumes();
static void Assume(int,int,int);
static int  ByteImmed(char*,int,int);
static int  ChkForward(INST_T[],int);
static int  ChkGetC(DWord*);
static int  ChkGetL(DWord*);
static int  ChkGetV(DWord*,int);
static int  ChkGetW(DWord*);
static void DtaByte(int);
static int  DatCmp(DAT_T*,DAT_T*);
static int  DoSib(char*,Byte*);
static int  DoModRM(char*,Byte,Byte,int,int,int);
static void Enum(DAT_T*,DAT_T*,int);
static int  ExtCmp(EXT_T*,EXT_T*);
static SEG_T*FindSegByName(char*);
static void FixAdv(void);
static void FixIns(int,int,int,long,int,int,int,int,int);
static int  GetChkC(DWord*);
static char*GetNm(char*,DWord*);
static void GetSeg(char*,FIX_T*,int,void*,int);
static char*GetTxt(char*,char*);
static Word GetVal(DWord*);
static int  GrpCmp(GRP_T*,GRP_T*);
static void GrpIns(int);
static char*GrpName(int);
static char*IgnoreWhiteSpc(char*);
static void InstrOpCode(char*);
static void InstrOperand(char*);
static void Iterated(DAT_T*,DAT_T*);
static NODE_T*LstSEx(NODE_T*,int);
static void LonePub(void);
static int  Mod0(int,int,char*,char*,Byte,int,int*);
static int  Mod1(int,int,char*,char*,Byte);
static int  Mod2(int,int,char*,char*,Byte,int,int*);
static int  Mod3(int,char*,Byte,int,int*);
static int  NameCmp(NAME_T*,NAME_T*);
static void NameIns(char*);
static void OutComment(char*);
static void OutDirective(char*);
static void OutEndLn(void);
static void OutLabel(char*);
static void OutLn(char*,char*,char*,char*);
static void OutNewLn(void);
static void OutOpCode(char*);
static void OutOperand(char*);
static void PreDups(long,int);
static void ProcDRec(DAT_T*,DAT_T*,int);
static int  ProcFixUp(void);
static int  ProcIdb(int,DWord,int*,int,Word*,DWord*);
static int  ProcLabel(void);
static int  ProcNor(int);
static void ProcSeg(void);
static void PubAdvance(void);
static int  PubCmp(PUB_T*,PUB_T*);
static char*RegFormat(int,char*,char*,char*,char*);
static int  SegCmp(SEG_T*,SEG_T*);
static void SegIns(int,NAME_T*,int,int,int);
static char*SegName(int,Word*);
static int  SExCmp(SEX_T*,SEX_T*);
static void SPrnDate(char*string,char*datestr);
static int  StrucCmp(STRUC_T*,STRUC_T*);
static void Swp(NODE_T*,int,NODE_T*,int);
static void TabI(char*);
static void TabNext(void);
static void TabSeek(int);
static void UpStr(char*,char*);
static int  WordImm(char*,int);

void AbortAssumes(){
 int SegReg;
 for(SegReg=0;SegReg<MAX_SEG_REGS;SegReg++)
  seg_rec->new_mode[SegReg]=seg_rec->prv_mode[SegReg],
  seg_rec->new_index[SegReg]=seg_rec->prv_index[SegReg];
}

void AdjustAssumes(){
 int SegReg,NewMode,NewIndex;
 for(SegReg=0;SegReg<MAX_SEG_REGS;SegReg++){
  NewMode=seg_rec->new_mode[SegReg],NewIndex=seg_rec->new_index[SegReg];
  if(NewMode!=seg_rec->prv_mode[SegReg]||NewIndex!=seg_rec->prv_index[SegReg]){
   Assume(SegReg,NewMode,NewIndex);
   seg_rec->prv_mode[SegReg]=NewMode,seg_rec->prv_index[SegReg]=NewIndex;
  }
 }
}

int AdrSizeOver(Byte byte,char*text,int class){
 int valid,save_large,save_bytes;
 byte=byte,text=text,class=class;
 save_large=AddrLarge,save_bytes=AddrBytes;
 AddrLarge=!AddrLarge,AddrBytes=AddrBytes==2?4:2;
 OverAdrSize=TRUE,valid=ChkForward(instr,1);
 if(valid)return(valid+1);
  else
 {
  AddrLarge=save_large,AddrBytes=save_bytes;
  return 0;
 }
}

void Assume(int seg_reg,int data_mode,int data_index){
 char *SegName,operand[100]; extern char *sregsc[];
 SegName=mode_name(data_mode,data_index);
 if(SegName&&compatibility!=2&&pass==3){
  OutOpCode("Assume");
  sprintf(operand,"%s %s",sregsc[seg_reg],SegName);
  OutOperand(operand);
  OutEndLn();
 }
}

int BuffAdd(int length){
 if(length+(buff_end-buff_beg)>BUFFSIZE)fmt_error("Trop d'addition pour le tampon interne");
 length=fread(buff_end,sizeof(char),length,o_file),buff_end=buff_end+length;
 return length;
}

void BuffEmpty(){buff_beg=buff_cur;}

int BuffGetC(){
 if(buff_cur==buff_end)return EOF;
  else
 {
  Byte ch=*buff_cur++;
  return ch;
 }
}

int buff_init(int Len){
 if(Len>BUFFSIZE) fmt_error("Enregistrement trop large");
 buff_beg=&buff[0],buff_cur=buff_beg;
 Len=fread(buff_beg,sizeof(char),Len,o_file);
 buff_end=buff_beg+Len;
 return Len;
}

int buff_regetc(){
 if(buff_beg==buff_end)return EOF;
  else
 {
  int result=*buff_beg++;buff_cur=buff_beg;
  return result;
 }
}

void buff_reseek(){buff_cur=buff_beg;}

int ByteImmed(char*text,int Add,int sign){
 int DChk=data_check(Add+2); DWord Ofs;
 switch(DChk){
  case LABEL:return 1;
  case FIXUP:return 1;
  case BAD:
  case NORMAL:if(ChkGetC(&Ofs))return 1;
   if(sign){
    if(Ofs<=0x7F)sprintf(text,"+0%02lXh",Ofs);
            else sprintf(text,"-0%02lXh",0x0100L-Ofs);
   }
    else
   out_hexize(Ofs,text,1);
   break;
 }
 return 0;
}

int ChkForward(INST_T InstMtx[],int method){
 DWord byte;int data,X;
 char*buff_save=buff_cur;
 if(GetChkC(&byte))return 0;
 data=(Byte)byte,inst_offset+=1;
 if(method==0&&pass==3)
  pass=2,X=(*InstMtx[data].rtn)((Byte)data,InstMtx[data].text,InstMtx[data].special),pass=3;
 else
  X=(*InstMtx[data].rtn)((Byte)data,InstMtx[data].text,InstMtx[data].special);
 inst_offset-=1;
 if(method==0||X==0)buff_cur=buff_save;
 return X;
}

int ChkGetC(DWord*X){
 int ch=BuffGetC();
 if(ch==EOF)return TRUE;else {*X=(DWord)ch;return FALSE;}
}

int ChkGetL(DWord*X){
 int ch=BuffGetC();
 if(ch==EOF)return TRUE;
 *X=(DWord)((Byte)ch),ch=BuffGetC();
 if(ch==EOF)return TRUE;
 *X+=(DWord)((Byte)ch)<<8,ch=BuffGetC();
 if(ch==EOF)return TRUE;
 *X+=(DWord)((Byte)ch)<<16;
 ch=BuffGetC();
 if(ch==EOF)return TRUE;
 *X+=(DWord)((Byte)ch)<<24;
 return FALSE;
}

int ChkGetV(DWord*X,int flag){return flag?ChkGetL(X):ChkGetW(X);}

int ChkGetW(DWord*X){
 int ch=BuffGetC();
 if(ch==EOF)return TRUE;
 *X=ch,ch=BuffGetC();
 if(ch==EOF)return TRUE;
 *X+=ch<<8;
 return FALSE;
}

PUB_T*check_public(int Mode,int Index,long D,char LabelChr){
 PUB_T*NewPubRec; NODE_T*NewNode; DAT_T DatSearch,*DatRec;
 NODE_T*DatNode; FIX_T*FixRec; NODE_T*FixNode; int RefSeg,FixI;
 char LabelName[10]; DWord Disp;
 RefSeg=over_seg==-1?2:over_seg,Disp=D<0L?0L:D;
 if(Mode==2)Index=seg_rec->prv_index[RefSeg];
 pub_search.seg_idx=Index, pub_search.offset=Disp;
 NewPubRec=(PUB_T*)find((char*)&pub_search,public_tree,TC PubCmp,&NewNode);
 if(NewPubRec)return NewPubRec;
 if(NewNode!=public_tree){
  NewPubRec=(PUB_T*)NewNode->data;
  if(NewPubRec->seg_idx==Index){
   if(NewPubRec->offset+type_to_size(NewPubRec->type)>Disp)return NewPubRec;
  }
 }
 DatSearch.seg_idx=Index,DatSearch.offset=Disp;
 DatRec=(DAT_T*)find((char*)&DatSearch,data_tree,TC DatCmp,&DatNode);
 if(DatNode&&DatNode!=data_tree){
  DatRec=(DAT_T *)DatNode->data;
  if(DatRec->seg_idx==Index&&DatRec->offset+DatRec->length>Disp){
   fix_search.seg_idx=Index,fix_search.dat_offset=DatRec->offset;
   fix_search.offset=(int)(Disp-(DWord)DatRec->offset);
   FixRec=(FIX_T*)find((char*)&fix_search,fix_tree,TC fix_compare,&FixNode);
   if(!FixRec){
    if(FixNode!=fix_tree){
     FixRec=(FIX_T*)FixNode->data;
     if(FixRec->seg_idx==Index&&FixRec->dat_offset==DatRec->offset){
      FixI=fix_type[FixRec->form].num_bytes;
      if(FixRec->extended&&FixRec->form!=BASE)FixI+=2;
      if(fix_search.offset>FixRec->offset&&fix_search.offset<FixRec->offset+FixI)return NewPubRec;
     }
    }
   }
   if(DatRec->type==ITERATED){
    if(NewNode==public_tree)return NULL;
    if(NewPubRec->seg_idx!=Index)return NULL;
    if(NewPubRec->offset>=DatRec->offset)return NewPubRec;
    Disp=DatRec->offset;
   }
  }
 }
 label_count++;
 sprintf(LabelName,compatibility==2?"@%c%d":"$%c%d",LabelChr,label_count);
 NewNode=pub_insert(Index,Disp,LabelName,LOCAL,FALSE);
 NewPubRec=(PUB_T*)find((char*)&pub_search,public_tree,TC PubCmp,NULL);
 if((pub_node==public_tree||Index<pub_rec->seg_idx||
    (Index==pub_rec->seg_idx&&Disp<pub_rec->offset))&&
    (Index>segment||(Index==segment&&Disp>inst_offset)))
  pub_node=NewNode,pub_rec=NewPubRec;
 if(Index==segment&&Disp==inst_offset)last_pub_rec=NewPubRec;
 return NewPubRec;
}

void comdef(Word Len,int scope){
 char name[41];int typ_idx,var_type;DWord num_elements,element_size;
 --Len;
 while(Len){
  Len-=get_name(name),Len-=get_index(&typ_idx),--Len;
  var_type=GetByte();
  if(var_type==0x61)Len-=GetVal(&num_elements),Len-=GetVal(&element_size);
               else Len-=GetVal(&element_size),num_elements=1L;
  ext_insert(name,1,var_type,num_elements,(Word)element_size,scope);
 }
 GetByte();
}

void coment(Word Len){
 char junk[3],*comment,text[80],temp[80]; int type,class,i,w;
 Byte*prt_char; char*p; LOCAL_VAR*local_var;
 static Word scope_type=VT_VAR; static NODE_T**ppScope_tree;
 static SCOPE_T*pScope,**ppScope,*arg_scope,*loc_scope;
 type=GetByte(),class=GetByte(),Len-=3;
 comment=Len?o_malloc(Len):junk;
 get_str(Len,comment);
 switch(class){
  case MSLANG:OutLn("","; Compilateur:",comment,"");break;
  case MSMODL:processor_type_comment_occurred=TRUE;
   switch(comment[0]){
    case '3':OutLn("",".386p","","");OutLn("",".387","","");processor_mode=386;break;
    case '2':OutLn("",".286p","","");OutLn("",".287","","");processor_mode=286;break;
    case '1':OutLn("",".186","","");OutLn("",".187","","");processor_mode=186;break;
    case '0':OutLn("",".8086","","");OutLn("",".8087","","");processor_mode=8086;break;
    default:fmt_error( "Unknown Processor Type" );break;
   }
   switch(comment[1]){
    case'c':OutLn("","; Compact Memory Model","","");break;
    case't':OutLn("","; Tiny Memory Model","","");break;
    case's':OutLn("","; Small Memory Model","","");break;
    case'm':OutLn("","; Medium Memory Model","","");break;
    case'l':OutLn("","; Large Memory Model","","");break;
    case'h':OutLn("","; Huge Memory Model","","");break;
    default:fmt_error("Unknown Model");break;
   }
   if(comment[2]=='O')OutLn("","; Optimizations Enabled","","");
   break;
  case MSDSEG:OutLn("","; Force DOSSEG linker option","","");break;
  case MSILIB:OutLn("","includelib",comment,"");break;
  case MSEXTN:if(Len){
    if(!strcmp(comment,"\001CV"))OutLn("","; CodeView Enabled","","");
                            else fmt_error( "Unknown CodeView Option" );
   }
   break;
  case UNKNWN:OutLn("","; Linker - Pass two marker","","");break;
  case PATIME:
   if(comment[0]!=16)fmt_error("Unknown Phoenix Time Stamp Prefix");
   OutLn("","; Time: ",&comment[1],"");
   break;
  case PACMNT:OutLn("",";",comment,"");break;
  case TCXSYMTYPIX:
   sprintf(text,"; External symbol type index %02X",*comment,comment[1]&1);
   OutLn(text,"","","");
   break;
  case TCPUBSYMTYP:
   sprintf(text,"; Public symbol type %02X, function return offset %02X",*comment,comment[1]&1);
   OutLn(text,"","","");
   break;
  case TCSTRUCT:
   OutLn("; typedef struct:","","","");
   i=1;
   while(i<Len){
    OutNewLn();
    sprintf(text,"; \"%.*s\"",comment[i],&comment[i+1]);
    i+=comment[i]+1;
    sprintf(temp,"type %02X",comment[i]);
    i+=2;
    OutLn(text,"","",temp);
   }
   break;
  case TCDEPFIL:
   if(Len<=3)OutLn("; Fin de la liste des d‚pendance","","","");
    else
   {
    sprintf(text,"%.*s",(int)comment[4],&comment[5]);
    OutLn("; D‚pendance du fichier: ",text,"","");
   }
   break;
  case TCENDSCP:
   pScope=o_malloc(sizeof(SCOPE_T));
   pScope->hex_offset=*(int*)comment;
   pScope=insert(pScope,end_scope_tree,TC scope_compare)->data;
   sprintf(text,"; Fin du scope … l'offset %04X",*(int*)comment);
   OutLn(text,"","","");
   break;
  case TCBEGSCP:
   scope_type=scope_type==VT_ARG?VT_VAR:VT_ARG;
   if(scope_type==VT_ARG)ppScope_tree=&arg_scope_tree,ppScope=&arg_scope;
                    else ppScope_tree=&loc_scope_tree,ppScope=&loc_scope;
   *ppScope=o_malloc(sizeof(SCOPE_T));
   (*ppScope)->hex_offset=*(int*)&comment[1];
   *ppScope=insert(*ppScope,*ppScope_tree,TC scope_compare)->data;
   sprintf(text,"; D‚but de segment scope %04X, offset %04X",(int)*comment,*(int*)&comment[1]);
   OutLn(text,"","","");
   break;
  case TCLOCDEF:
   OutLn("; D‚finitions local:","","","");
   i=0,local_var=(*ppScope)->head=o_malloc(sizeof(LOCAL_VAR));
   while(i+1<Len){
    if(i!=0)local_var=local_var->next=o_malloc(sizeof(LOCAL_VAR));
    OutNewLn();
    sprintf(text,"; \"%.*s\"",comment[i],&comment[i+1]);
    sprintf(local_var->vname,"%.*s",comment[i],&comment[i+1]);
    i+=comment[i]+1;
    sprintf(temp,", type %02X, classe %02X",comment[i],comment[i+1]&7);
    strcat(text,temp);
    *temp=0,i++,local_var->class=comment[i]&7;
    switch(comment[i]&7){
     case 7:
      sprintf(temp," (circonstance de variable typ‚e)");
      local_var->bInfo1=comment[i+1],i++;
      break;
     case 6:
      sprintf(temp," (typedef local)");
      local_var->bInfo1=comment[i+1],i++;
      break;
     case 4:
      i++;
      switch(comment[i]){
       case 0x06:p="SI";break;
       case 0x07:p="DI";break;
       default: p="[Inconnu]";break;
      }
      local_var->bInfo1=comment[i];
      sprintf(temp," variable dans le registre %s",p);
      i++,local_var->bInfo2=comment[i];
      break;
     case 2:
      local_var->bInfo1=comment[i];
      sprintf(temp," (var) %s stock‚e dans ",comment[i]&8?"argument":"local");
      strcat(text,temp);
      switch(comment[i++]&7){
       case 2:
        local_var->bInfo2=(comment[i-1]&7)==2;
        local_var->wInfo1=*(int*)&comment[i];
        w=*(int*)&comment[i++];
        if(w<0)sprintf(temp,"[BP-%04X]",-w);else sprintf(temp,"[BP+%04X]",w);
        break;
       default:strcpy(temp,"[Inconnu]");break;
      }
      i++;break;
     case 0:
      sprintf(temp," (Fonction static) index %04X, word %04X",*(int*)&comment[i+1],*(int*)&comment[i+3]);
      i+=5;
    }
    strcat(text,temp);
    OutLn(text,"","","");
   }
   break;
  case TCTYPDEF:
   sprintf(text,"; Type de d‚finition: index %02X ",*(int*)&comment[0]);
   i=1;
   if(comment[1]){
    sprintf(temp,"\"%.*s\", ",comment[1],&comment[2]);
    strcat(text,temp);
   }
   i+=comment[i]+1;
   sprintf(temp,"taille %04X, TID %02X",*(int*)&comment[i],comment[i+2]);
   strcat(text,temp);
   OutLn(text,"","","");
   break;
  case TCSOURCE:
   if(!*comment){
    i=1;
    sprintf(text,"; Fichier source %.*s",comment[1],&comment[2]);
    i+=comment[1]+1;
    SPrnDate(temp,&comment[i]);
    OutLn(text,temp,"","");
   }
    else
   OutLn("; Fichier source","","","");
   break;
  case TCXLATOR:
   strcpy(text,"; Compilateur: ");
   switch (*comment){
    case 0x01:strcat(text,"'C'");break;
    case 0x04:strcat(text,"Assembleur");break;
    default:strcat(text,"[Inconnu]");break;
   }
   sprintf(temp," utilise le modŠle %s avec soulignement %s",models[comment[1]&7],comment[1]&8?"ouvert":"fermer");
   strcat(text,temp);
   OutLn(text,"","","");
   break;
  case TCENUM:
   i=1;
   OutLn("; Membre d'une liste d'‚num‚ration","","","");
   while(i<Len){
    sprintf(text,"; %.*s",comment[i],&comment[i+1]);
    i+=comment[i]+1;
    sprintf(temp," = %04X",*(Word*)&comment[i]);
    i+=3;
    strcat(text,temp);
    OutLn(text,"","","");
    OutNewLn();
   }
   break;
  case TCMANGLE:
   sprintf(temp,"; Mangled name \"%.*s\"",*comment,&comment[1]);
   OutLn(temp,"","","");
   break;
  default:
   text[0]='\0',prt_char=comment;
   while(Len){
    sprintf(temp,isprint(*prt_char)?"%c":"[%02X]",*prt_char);
    strcat(text,temp);
    prt_char++,--Len;
   }
   sprintf(temp,"; Enregistrement de remarque inconnu (Classe %d): '%s'",class,text);
   OutLn("",temp,"","");
   break;
 }
 OutNewLn();
 GetByte();
 type=type;
 if(comment!=junk)free(comment);
}

void DtaByte(int size){
 char *opcode; int out_count,times;char operand[50],rev_buff[10],temp[4];
 if(last_pub_rec&&pass==3){
  if(last_pub_rec->type==FAR){
   OutDirective("=");
   OutOperand("$");
  }
  if(last_pub_rec->type==NEAR)OutEndLn();
 }
 opcode=size_to_opcode(size,&times);
 while(times){
  out_count=0;
  strcpy(operand,"0");
  while(out_count<size)rev_buff[out_count]=(Byte)buff_regetc(),out_count++;
  out_count=size;
  while(out_count){
   --out_count;
   sprintf(temp,"%02X",(Byte)rev_buff[out_count]);
   strcat(operand,temp);
  }
  strcat(operand,"h");
  if(pass==3){
   OutDirective(opcode);
   OutOperand(operand);
   OutEndLn();
  }
  --times;
 }
 last_pub_rec=NULL;
}

int data_check(Word offset){
 int direct=RIGHT;
 pub_search.seg_idx=segment,pub_search.offset=inst_offset+offset;
 while(pub_node!=public_tree&&(direct=PubCmp(&pub_search,pub_rec))==LEFT){
  LonePub();
  PubAdvance();
 }
 if(direct==EQUAL)return LABEL;
 fix_search.seg_idx=segment,fix_search.dat_offset=DataOfs;
 fix_search.offset=(int)(inst_offset-DataOfs)+offset;
 direct=RIGHT;
 while(fix_node!=fix_tree&&(direct=fix_compare(&fix_search,fix_rec))==LEFT)FixAdv();
 if(fix_rec->seg_idx==segment&&fix_rec->dat_offset+fix_rec->offset==inst_offset+offset)return FIXUP;
 if(pub_node!=public_tree&&pub_rec->seg_idx==pub_search.seg_idx&&pub_rec->offset==pub_search.offset+1)return BAD;
 if(fix_node!=fix_tree&&fix_rec->seg_idx==segment&&fix_rec->dat_offset+fix_rec->offset==inst_offset+offset+1)return BAD;
 return 0;
}

int DatCmp(DAT_T*rec_1,DAT_T*rec_2){
 if(rec_1->seg_idx>rec_2->seg_idx)return LEFT;
  else
 {
  if(rec_1->seg_idx<rec_2->seg_idx)return RIGHT; else
  return rec_1->offset>rec_2->offset?LEFT:rec_1->offset<rec_2->offset?RIGHT:EQUAL;
 }
}

void dat_insert(int seg_idx,DWord offset,long file_pos,int length,int extended,int type){
 DAT_T *DataRec;
 DataRec=(DAT_T*)o_malloc(sizeof(DAT_T));
 DataRec->seg_idx=seg_idx,DataRec->offset=offset,DataRec->type=type;
 DataRec->size=1,DataRec->file_pos=file_pos,DataRec->length=length;
 DataRec->extended=extended,DataRec->structure=NULL;
 insert((char *)DataRec,data_tree,TC DatCmp);
}

int decode_fixup(int relate,int size,int form,int offset,int extension){
 int length=1,fix=GetByte(),thread,AMode,AIndx,BMode,BIndx,fbit,tbit,pbit;
 DWord displacement;int extended=FALSE;
 fbit=(fix&0x80)>>7,AMode=(fix&0x70)>>4;
 if(fbit==1)thread=AMode&3,AIndx=threads[1][thread].index,AMode=threads[1][thread].mode;
       else {if(AMode<4)length+=get_index(&AIndx);}
 tbit=(fix&8)>>3,thread=fix&7,pbit=(thread&4)>>2,BMode=thread&3;
 if(tbit==1)BIndx=threads[0][BMode].index,BMode=threads[0][BMode].mode&3;
       else length+=get_index(&BIndx);
 if(size!=0&&extension)extended=TRUE;
 if(pbit==0){
  displacement=(DWord)get_int(),length+=2;
  if(extended)displacement+=(DWord)GetByte()<<16,displacement+=(DWord)GetByte()<<24,length+=2;
 }
  else
 displacement=0L;
 if(AMode==5)AMode=BMode,AIndx=BIndx;
 FixIns(offset,relate,form,displacement,AMode,AIndx,BMode,BIndx,extended);
 return length;
}

int disp8(Byte byte,char*text,int class){
 int dcheck;char line[60],*short_text;DWord offset,dest;PUB_T*pub_rec;
 if(over_seg!=-1)return 0;
 dcheck=data_check(1);
 if(dcheck!=NORMAL&&dcheck!=BAD)return 0;
 if(ChkGetC(&offset))return 0;
 if(offset==0xFFFFFFFFL)return 0;
 short_text="";
 if(compatibility!=2){
  if(byte==0xEB||segment_mode==386)short_text="short ";
 }
 dest=inst_offset+(signed char)offset+2;
 pub_rec=check_public(1,segment,dest,'L');
 if(pub_rec){
  pub_rec->type=NEAR,offset=dest-pub_rec->offset;
  if(offset>0)sprintf(line,"%s%s + 0%04lXh",short_text,pub_rec->name,offset);
         else sprintf(line,"%s%s",short_text,pub_rec->name);
 }
  else
 {
  if(compatibility==2)sprintf(text," %s.0%04lXh",short_text,offset);
                 else sprintf(text,"%s[%s:0%04lXh]",short_text,cseg_name,offset);
 }
 InstrOpCode(text);
 InstrOperand(line);
 byte=byte,class=class;
 return 2;
}

int disp16(Byte byte,char*text,int class){
 DWord offset,dest;int dummy;char line[60],*ShText;PUB_T*pub_rec;int data_size;
 byte=byte,class=class,data_size=AddrBytes;
 if(over_seg!=-1)return 0;
 switch(data_check(1)){
  case BAD:return 0;
  case LABEL:return 0;
  case FIXUP:
   if(fix_rec->word_sized&&fix_rec->extended==AddrLarge&&fix_rec->relate==0){
    get_fix(line,1,FALSE,SizeBytes,NEAR,TRUE,&dummy,CS);
    AdjustAssumes();
    InstrOpCode(text);
    InstrOperand(line);
    return 1+data_size;
   }
    else
   return 0;
  case NORMAL:
   if(ChkGetV(&offset,AddrLarge))return 0;
   ShText=offset<0x80||offset>= 0xFFFFFF7FL?"Near Ptr ":"";
   dest=inst_offset+offset+AddrBytes+1;
   pub_rec=check_public(1,segment,dest,'L');
   if(pub_rec)
   {
    offset=dest-pub_rec->offset;
    if(offset>0L)sprintf(line,AddrLarge?"%s%s + 0%08lXh":"%s%s + 0%04lXh",ShText,pub_rec->name,offset);
            else sprintf(line,"%s%s",ShText,pub_rec->name);
   }
    else
   {
    if(compatibility==2)sprintf(line,AddrLarge?"%s .0%08lXh":"%s .0%04lXh",ShText,offset);
                   else sprintf(line,AddrLarge?"%s[%s:0%08lXh]":"%s[%s:0%04lXh]",ShText,cseg_name,offset);
   }
   InstrOpCode(text);
   InstrOperand(line);
   return 1+data_size;
 }
 return 0;
}

int DoModRM(char*line,Byte mod,Byte r_m,int type,int SizeNeeded,int ref_mode){
 int size_known,sib_offset,result; char sib_text[50],temp2[50];
 size_known=FALSE;
 strcpy(sib_text,"");
 sib_offset=0;
 if(AddrLarge){
  if(r_m==4&&mod!=3){
   sib_offset=DoSib(sib_text,&r_m);
   if(sib_offset==-1)return-1;
  }
 }
 switch(mod){
  case 0:result=Mod0(ref_mode,sib_offset,sib_text,temp2,r_m,type,&size_known);break;
  case 1:result=Mod1(ref_mode,sib_offset,sib_text,temp2,r_m),size_known=TRUE;break;
  case 2:result=Mod2(ref_mode,sib_offset,sib_text,temp2,r_m,type,&size_known);break;
  case 3:result=Mod3(ref_mode,temp2,r_m,type,&size_known),SizeNeeded=FALSE;break;
 }
 if(result!=-1){
  if(compatibility==2){
   if(over_seg!=-1){strcat(line,sregsc[over_seg]);strcat(line," ");}
   if(!size_known||SizeNeeded)strcat(line,type_to_text(type));
  }
   else
  {
   if(!size_known||SizeNeeded)strcat(line,type_to_text(type));
   if(over_seg!=-1)strcat(line,sregsc[over_seg]);
  }
  strcat(line,temp2);
 }
 return result;
}

void empty_string(int length){
 int prev_mode=NOTHING,curr_mode,out_count,this_char,byte_len,pre_len;
 char out_buff[OPSIZE+1],byte_buff[5],*pre_text;
 out_buff[0]='\0'; out_count=0;
 buff_reseek();
 while(length){
  this_char=buff_regetc();
  if(this_char<' '||this_char>'~'){
   curr_mode=SPECIAL;
   sprintf(byte_buff,"0%02Xh",this_char);
   byte_len=4;
  }
   else
  {
   curr_mode=ASCII;
   if(this_char=='\''){
    strcpy(byte_buff,"''");
    byte_len=2;
   }
    else
   {
    sprintf(byte_buff,"%c",this_char);
    byte_len=1;
   }
  }
  pre_text="",pre_len=0;
  if(prev_mode==ASCII&&curr_mode==SPECIAL)pre_text="',",pre_len=2;
  if(prev_mode==SPECIAL&&curr_mode==ASCII)pre_text=",'",pre_len=2;
  if(prev_mode==SPECIAL&&curr_mode==SPECIAL)pre_text=",",pre_len=1;
  if(out_count+pre_len+byte_len>=OPSIZE){
   if(prev_mode==ASCII)strcat(out_buff,"'");
   if(pass==3){
    OutDirective("DB");
    OutOperand(out_buff);
    OutEndLn();
   }
   out_count=0,out_buff[0]='\0',prev_mode=NOTHING,pre_text="",pre_len=0;
  }
  if(prev_mode==NOTHING&&curr_mode==ASCII)pre_text="'",pre_len=1;
  strcat(out_buff,pre_text);
  strcat(out_buff,byte_buff);
  out_count+=pre_len+byte_len,prev_mode=curr_mode;
  if(this_char=='\0'||this_char=='$'){
   if(prev_mode==ASCII)strcat(out_buff,"'");
   if(pass==3){
    OutDirective("DB");
    OutOperand(out_buff);
    OutEndLn();
   }
   out_count=0,out_buff[0]='\0',prev_mode=NOTHING,pre_text="", pre_len=0;
  }
  --length;
 }
 if(prev_mode!=NOTHING){
  if(prev_mode==ASCII)strcat(out_buff,"'");
  if(pass==3){
   OutDirective("DB");
   OutOperand(out_buff);
   OutEndLn();
  }
 }
}

int enter(Byte byte,char*text,int class){
 DWord num_bytes,nest_level;char line[50];
 switch(data_check(1)){
  case BAD:
  case LABEL:
  case FIXUP:return 0;
  case NORMAL:
   if(ChkGetW(&num_bytes))return 0;
   if(ChkGetC(&nest_level))return 0;
   sprintf(line,"0%04lXh,0%02lXh",num_bytes,nest_level);
   break;
 }
 InstrOpCode(text);
 InstrOperand(line);
 byte=byte,class=class;
 return 4;
}

void Enum(DAT_T*DataRec,DAT_T*next_rec,int inst_proc){
 int length,result;DWord prev_offset;int addition,dcheck;
 length=DataRec->length;
 fseek(o_file,DataRec->file_pos+RecOverUsed,L_SET);
 length=buff_init(length-RecOverUsed),addition=0;
 if(next_rec){
  fseek(o_file,next_rec->file_pos,L_SET);
  addition=0x10;
  if(addition>next_rec->length)addition=next_rec->length;
  length+=BuffAdd(addition);
 }
 while(length>addition){
  if(length<0)fmt_error("D‚s-assemblage d''enregistrement surpasse les capacit‚s");
  prev_offset=inst_offset;
  dcheck=data_check(0);
  switch(dcheck){
   case BAD:result=ProcNor(inst_proc);break;
   case LABEL:result=ProcLabel();break;
   case FIXUP:result=ProcFixUp();break;
   case NORMAL:result=ProcNor(inst_proc);break;
  }
  length-=result;
  if((DWord)result!=inst_offset-prev_offset)fmt_error("Erreur de taille d'instruction dans le d‚s-assemblage");
  if(DataRec->offset+DataRec->length-length+addition!=inst_offset)fmt_error("Instruction mal-align‚e dans le d‚s-assemblage");
  if(buff_end-buff_cur!=length)fmt_error("D‚s-assemblage d'instruction en cours");
 }
 RecOverUsed=addition-length;
}

int esc(Byte byte,char*text,int class){
 int size,dir,type;DWord mod_reg;Byte mod,r_m,lll,ttt,EB,mf;
 int additional,SizeNeeded;char line[50],temp[50];int ref_mode;
 text=text,class=class,size=byte&1,dir=(byte&2)>>1,ref_mode=0;
 if(GetChkC(&mod_reg))return 0;
 mod=(Byte)(((int)mod_reg&0xC0)>>6);
 lll=(Byte)(((int)mod_reg&0x38)>>3);
 r_m=(Byte)(((int)mod_reg&7)>>0);
 ttt=(Byte)(byte&7),EB=(Byte)(ttt<<3)+lll;
 if(mod==3){esc_special(temp,line,EB,r_m);additional=0;}
  else
 {
  mf=(Byte)((EB&0x30)>>4),SizeNeeded=TRUE;
  switch(mf){
   case 0:type=DWORD_PTR;break;
   case 1:type=DWORD_PTR;break;
   case 2:type=QWORD_PTR;break;
   case 3:type=WORD_PTR;break;
  }
  if(EB==0x1D||EB==0x1F||EB==0x3C||EB==0x3E)type=TBYTE_PTR;
  if(EB==0x2F)type=WORD_PTR;
  if(EB==0x3D||EB==0x3F)type=DWORD_PTR;
  if((EB>=0x0C&&EB<=0x0F)||(EB>=0x2C&&EB<=0x2E))SizeNeeded=FALSE;
  sprintf(line,"");
  additional=DoModRM(line,mod,r_m,type,SizeNeeded,ref_mode);
  if(additional==-1)return 0;
  strcpy(temp,esc_inst[EB]);
 }
 if(strlen(temp)){
  if(temp[1]=='n'&&fp_wait){
   fp_opcode[0]=temp[0];
   strcpy(&fp_opcode[1],&temp[2]);
  }
   else
  strcpy(fp_opcode,temp);
  InstrOpCode(fp_opcode);
  InstrOperand(line);
 }
  else
 {
  sprintf(line,"0%02Xh,%s",EB,regs[1][r_m]);
  InstrOpCode("ESC");
  InstrOperand(line);
 }
 fp_wait=FALSE,dir=dir,size=size;
 return 2+additional;
}

void esc_special(char*opcode,char*operand,int EB,int reg){
 int E;
 strcpy(opcode,"");
 strcpy(operand,"");
 if(EB==0x0A){if(reg==0)strcpy(opcode,"FNOP");return;}
 if(EB==0x0B)return;
 if(EB>=0x0C&&EB<=0x0F)
 {
  E=(EB-0x0C)*8+reg;
  strcpy(opcode,esc_0x0X[E]);
  return;
 }
 if(EB>=0x10&&EB<=0x1F){
  if(EB==0x15&&reg==1)strcpy(opcode,"FUCOMPP");
  if(EB==0x1C) strcpy(opcode,esc_0x1C[reg]);
  return;
 }
 if(EB==0x22||EB==0x23||EB==0x29||(EB>=0x2C&&EB<=0x2F))return;
 if(EB==0x33){if(reg==1)strcpy(opcode,"FCOMPP");return;}
 if(EB==0x32)return;
 if(EB==0x38||EB==0x39||EB==0x3A||EB==0x3B)return;
 if(EB==0x3C){
  if(reg==0x00){
   strcpy(opcode,"FSTSW");
   strcpy(operand,"AX");
  }
  return;
 }
 if(EB==0x3D||EB==0x3E||EB==0x3F)return;
 E=EB&0x0F;
 sprintf(operand,E==2||E==3||E==8||E==9||E==0x0A||E==0x0B?"ST(%d)":EB>=0x10?"ST(%d),ST":"ST,ST(%d)",reg);
 if(EB==0x24||EB==0x34||EB==0x26||EB==0x36)E++;
 if(EB==0x25||EB==0x35||EB==0x27||EB==0x37)--E;
 strcpy(opcode,EB==0x09?"FXCH":esc_inst[E]);
 if(EB>=0x30)strcat(opcode,"p");
}

int extra(Byte byte,char*text,int class){
 int result=ChkForward(ex_instr,1);
 byte=byte,text=text,class=class;
 return result==0?0:result+1;
}

int ExtCmp(EXT_T*rec_1,EXT_T*rec_2){
 return rec_1->index>rec_2->index?LEFT:rec_1->index<rec_2->index?RIGHT:EQUAL;
}

void ext_insert(char*this_name,int com_ext,int var_type,DWord count,Word size,int scope){
 static extern_count; EXT_T*extern_rec;
 extern_count=0,extern_count++;
 extern_rec=(EXT_T*)o_malloc(sizeof(EXT_T));
 extern_rec->index=extern_count;
 extern_rec->type=size_to_type(size);
 extern_rec->pos_abs=TRUE;
 extern_rec->size=count;
 extern_rec->com_ext=com_ext;
 extern_rec->var_type=var_type;
 extern_rec->used=0;
 extern_rec->scope=scope;
 strcpy(extern_rec->name,this_name);
 insert((char*)extern_rec,extern_tree,TC ExtCmp);
}

void extdef(Word length,int scope){
 char name[41];int typ_idx;
 --length;
 while(length){
  length-=get_name(name),length-=get_index(&typ_idx);
  ext_insert(name,0,0,0L,0,scope);
 }
 GetByte();
}

void*find(void*data,NODE_T*root_node,int(*cmp_routine)(void*,void*),NODE_T**node_ptr){
 NODE_T*curr_node,*child_node;int curr_direct;
 child_node=root_node;
 do{
  curr_node=child_node,curr_direct=(*cmp_routine)(curr_node->data,data);
  if(node_ptr&&curr_direct==RIGHT)*node_ptr=curr_node;
  if(curr_direct==EQUAL){
   if(node_ptr)*node_ptr=curr_node;
   return curr_node->data;
  }
  child_node=curr_node->ptr[curr_direct];
 }
 while(!curr_node->thread[curr_direct]);
 return NULL;
}

int find_member(char*text,STRUC_T*structure,long*offset){
 int type,mem_cnt;long dup_cnt,ThisSize;char*cp,ch;
 cp=structure->form; mem_cnt=0;
 while((ch=*cp)!='\0'){
  switch(ch){
   case'(':dup_cnt=atol(cp+1);break;
   case',':type=atoi(cp+1);break;
   case')':
    ThisSize=type_to_size(type)*dup_cnt;
    if(*offset<ThisSize){
     sprintf(text,".s%dm_%d",structure->index,mem_cnt);
     return type;
    }
    *offset-=ThisSize,mem_cnt++;
   default:break;
  }
  cp++;
 }
 strcpy(text,".past struct");
 return UNKNOWN;
}

SEG_T*FindSegByName(char*seg_text){
 SEG_T*seg_rec;NODE_T*seg_node;NAME_T search,*name;
 seg_node=start(segment_tree,RIGHT);
 while(seg_node!=segment_tree){
  seg_rec=(SEG_T*)seg_node->data,search.index=seg_rec->name;
  name=(NAME_T*)find((char*)&search,name_tree,TC NameCmp,NULL);
  if(name==NULL)fmt_error("Nom de segment ind‚fini");
  if(strcmp(name->name,seg_text)==0)return seg_rec;
  seg_node=traverse(seg_node,RIGHT);
 }
 return NULL;
}

int five_byte(Byte byte,char*text,int class){
 DWord offset,segment;int size_known;char line[50],temp[50];int data_size;
 if(over_seg!=-1)return 0;
 data_size=SizeBytes;
 switch(data_check(1)){
  case BAD:return 0;
  case LABEL:return 0;
  case FIXUP:
   if(fix_rec->form!=POINTER||fix_rec->extended!=SizeLarge)return 0;
   get_fix(temp,1,FALSE,SizeBytes,NEAR,TRUE,&size_known,CS);
   sprintf(line, "Far Ptr %s",temp);
   break;
  case NORMAL:
   if(ChkGetV(&offset,SizeLarge))return 0;
   if(data_check(3)!=NORMAL)return 0;
   if(ChkGetW(&segment))return 0;
   out_hexize(segment,temp,2);
   strcpy(line,temp);
   strcat(line,":");
   out_hexize(offset,temp,SizeBytes);
   strcat(line,temp);
   break;
 }
 AdjustAssumes();
 InstrOpCode(text);
 InstrOperand(line);
 byte=byte,class=class;
 return 3+data_size;
}

int fix_compare(FIX_T*rec_1,FIX_T*rec_2){
 if(rec_1->seg_idx>rec_2->seg_idx)return LEFT;
  else
 {
  if(rec_1->seg_idx<rec_2->seg_idx)return RIGHT;
   else
  {
   if(rec_1->dat_offset>rec_2->dat_offset)return LEFT;
    else
   {
    if(rec_1->dat_offset<rec_2->dat_offset)return RIGHT;
     else
    return rec_1->offset>rec_2->offset?LEFT:rec_1->offset<rec_2->offset?RIGHT:EQUAL;
   }
  }
 }
}

void FixIns(int offset,int relate,int form,long displacement,int a_mode,int a_index,int b_mode,int b_index,int extension){
 FIX_T*fixup_rec;
 fixup_rec=(FIX_T*)o_malloc(sizeof(FIX_T));
 fixup_rec->seg_idx=data_seg_idx;
 fixup_rec->dat_offset=DataOfs;
 fixup_rec->offset=offset;
 fixup_rec->relate=relate;
 fixup_rec->form=form;
 fixup_rec->displacement=displacement;
 fixup_rec->a_mode=a_mode;
 fixup_rec->a_index=a_index;
 fixup_rec->b_mode=b_mode;
 fixup_rec->b_index=b_index;
 fixup_rec->extended=extension;
 fixup_rec->word_sized=form==OFFSET||form==BASE||form==LOADOFF?TRUE:FALSE;
 insert((char*)fixup_rec,fix_tree,TC fix_compare);
}

void fixupp(Word length,int extension){
 Byte type; int kind,thread,locat,relate,size,form,offset,mode,index;
 --length;
 while(length){
  type=GetByte(),--length;
  if(type&0x80){
   --length,locat=((int)type<<8)+GetByte();
   relate=(locat&0x4000)>>14,size=(locat&0x2000)>>13;
   form=(locat&0x1C00)>>10,offset=locat&0x3FF;
   length-=decode_fixup(relate,size,form,offset,extension);
  }
   else
  {
   kind=(type&0x40)>>6,mode=(type&0x1C)>>2,thread=type&3;
   threads[kind][thread].mode=mode;
   if(mode==0||thread<4)length-=get_index(&index),threads[kind][thread].index=index;
  }
 }
}

void FixAdv(){
 fix_node=traverse(fix_node,RIGHT),fix_rec=(FIX_T*)fix_node->data;
}

void fmt_error(char*error_msg){
 fprintf(stderr,"Erreur de format Obj: %s",error_msg); exit(5);
}

Byte GetByte(){
 int ch=fgetc(o_file);
 if(ch==EOF){fprintf(stderr,"%s: Fin pr‚matur‚e de fichier\n"); exit(3);}
 return(Byte)ch;
}

int GetChkC(DWord*Ofs){
 int dcheck=data_check(1);
 if(dcheck!=NORMAL&&dcheck!=BAD)return TRUE;
 return ChkGetC(Ofs);
}

int get_fix(char*result,int mode,int pre_name,int _SizeBytes,int size,int assign,int*size_known,int seg_reg){
 DWord data,more; int fix_count;
 SizeBytes=_SizeBytes; fix_count=fix_type[fix_rec->form].num_bytes;
 if(fix_rec->extended&&fix_rec->form!=BASE) fix_count+=2;
 switch(fix_count){
  case 1:data=BuffGetC();break;
  case 2:data=BuffGetC(),data+=BuffGetC()<<8;break;
  case 4:data=BuffGetC(),data+=BuffGetC()<<8,data+=BuffGetC()<<16,data+=BuffGetC()<<24;break;
  case 6:
   data=BuffGetC(),data+=BuffGetC()<<8,data+=BuffGetC()<<16;
   data+=BuffGetC()<<24,more=BuffGetC(),more+=BuffGetC()<<8;
   break;
  default:fmt_error("Type de fixup invalide");break;
 }
 get_target(result,fix_rec,mode,data,pre_name,size,assign,size_known,seg_reg);
 FixAdv();
 return fix_count;
}

int get_index(int *data){
 Word ch=GetByte();
 if(ch>0x7F){ch=((ch&0x7F)<<8)+GetByte(),*data=ch;return 2;}
        else{*data=ch;return 1;}
}

int get_int(){return GetByte()+GetByte()<<8;}

DWord get_long(){
 return GetByte()+(GetByte()<<8)+(GetByte()<<16)+(GetByte()<<24);
}

int get_name(char*dest_string){
 int length=GetByte();
 get_str(length,dest_string);
 return length+1;
}

char*GetNm(char*start,DWord*value){
 char *pc,ch;DWord DF,HF;Bool IsHex,decable,CharOk;
 DF=0L,HF=0L,pc=start,IsHex=False,decable=True;
 while((ch=*pc)!='\0'){
  CharOk=FALSE;
  if(ch>='0'&&ch<='9')DF*=10,DF+=ch-'0',HF*=16,HF+=ch-'0',CharOk=True;
  if(ch>='a'&&ch<='f')decable=FALSE,HF*=10,HF+=ch-'a'+10,CharOk=True;
  if(ch>='A'&&ch<='F')decable=FALSE,HF*=10,HF+=ch-'A'+10,CharOk=True;
  if(ch=='h'||ch=='H'){IsHex=TRUE,pc++;break;}
  if(!CharOk)break;
  pc++;
 }
 *value=IsHex?HF:decable?DF:0L;
 return pc;
}

void GetSeg(char*result,FIX_T*fixup,int ref_mode,void*data,int seg_reg){
 char*this_name;int form=fixup->form,mode=fixup->a_mode,index=fixup->a_index,ref_seg;
 EXT_T*ext_rec;PUB_T*pub_rec;
 strcpy(result,"");
 if(mode==TARGET||mode==NONE)return;
 if(fixup->b_mode==EXTERNAL){
  ext_rec=data;
  if(mode==EXTERNAL){
   ext_rec->used=-1;
   return;
  }
  if(mode==SEGMENT){
   ext_rec->pos_abs=FALSE;
   if(ref_mode!=0){
    if(pass==1&&ext_rec->used==0){
     sex_insert(index,ext_rec);
     ext_rec->used=index;
    }
    if(ext_rec->used==index)return;
   }
  }
 }
  else
 {
  if(fixup->b_mode==SEGMENT){
   pub_rec=data;
   if(ref_mode==2&&(ref_mode==1&&form==POINTER)){
    if(pub_rec->seg_idx==index)return;
   }
  }
 }
 if(ref_mode==0||(ref_mode==1&&form!=POINTER)){
  ref_seg=seg_reg-ES,seg_rec->new_mode[ref_seg]=mode,seg_rec->new_index[ref_seg]=index;
  if(mode==SEGMENT)if(fixup->b_mode==EXTERNAL&&ext_rec->used==index)return;
  if(mode==SEGMENT||mode==GROUP){
   if(fixup->b_mode==SEGMENT||fixup->b_mode==EXTERNAL)return;
  }
 }
 if(form==BASE)if(fixup->b_mode==mode&&fixup->b_index==index)return;
 this_name=mode_name(mode,index);
 if(this_name)sprintf(result,"%s:",this_name);
}

void get_str(int length,char*dest_string){
 int count=length;
 while(count)*dest_string++=GetByte(),--count;
 *dest_string='\0';
}

void get_target(char*result,FIX_T*fixup,int mode,long data,int pre_name,int type,int assign,int*type_known,int seg_reg){
 int index;PUB_T*pub_rec;EXT_T ext_search,*ext_rec;STRUC_T*pub_struct;
 char*prefix,this_seg[NAMESIZE+1+1],this_member[NAMESIZE+1+1];Word seg_size;
 char*this_name,*ThisComment;int this_type;char sign;long disp=data;
 this_seg[0]='\0',this_member[0]='\0',ThisComment="";
 if(fixup->displacement!=0L){
  if(disp!=0L)ThisComment="[MULTIPLE FIXUP]";
  disp+=fixup->displacement;
 }
 prefix=pre_name?fix_type[fixup->form].prefix:"",index=fixup->b_index;
 switch(fixup->b_mode){
  case SEGMENT:
   if(fixup->form!=BASE){
    pub_rec=check_public(0,index,disp,'S');
    if(pub_rec){
     this_name=pub_rec->name,disp-=(long)pub_rec->offset;
     pub_struct=pub_rec->structure;
     if(pub_struct)this_type=find_member(this_member,pub_struct,&disp);
      else
     {
      if(assign&&((type<=FAR&&pub_rec->type>FAR)||pub_rec->type==UNKNOWN))pub_rec->type=type;
      this_type=pub_rec->type;
     }
     *type_known=this_type!=type?FALSE:TRUE;
     GetSeg(this_seg,fixup,mode,pub_rec,seg_reg);
     break;
    }
   }
   this_name=SegName(index,&seg_size);
   if(fixup->form==BASE&&fixup->displacement!=0)prefix="",disp-=seg_size;
   this_seg[0]='\0', *type_known=TRUE;
   break;
  case GROUP:
   this_name=GrpName(index),*type_known=TRUE;
   GetSeg(this_seg,fixup,mode,NULL,seg_reg);
   break;
  case EXTERNAL:
   ext_search.index=index,ext_rec=(EXT_T*)find((char*)&ext_search,extern_tree,TC ExtCmp,NULL);
   if(ext_rec==NULL)fmt_error("Externe ind‚fini");
   this_name=ext_rec->name;
   if(assign&&((type<=FAR&&ext_rec->type>FAR)||ext_rec->type==UNKNOWN))ext_rec->type=type;
   *type_known=ext_rec->type!=type?FALSE:TRUE;
   GetSeg(this_seg,fixup,mode,ext_rec,seg_reg);
   break;
  case FRAME:GetSeg(this_seg,fixup,mode,NULL,seg_reg);break;
 }
 if(disp==0)sprintf(result,"%s%s%s%s%s",prefix,this_seg,this_name,this_member,ThisComment);
  else
 {
  if(disp>0L)sign='+';else sign='-',disp=-disp;
  sprintf(result,disp>32767L||disp<-32768L?"%s%s%s%s %c 0%08lXh%s":"%s%s%s%s %c 0%04lXh%s",
          prefix,this_seg,this_name,this_member,sign,disp,ThisComment);
 }
}

char*GetTxt(char*destination,char*start){
 char*pc=start,ch;int len=0;
 while((ch=*pc)!=' '&&ch!='\t'&&ch!='='&&ch!='\0'&&ch!=':'&&ch!='\n'){
  *destination++=ch,pc++,len++;
  if(len==NAMESIZE)break;
 }
 *destination='\0';
 return pc;
}

Word GetVal(DWord*value){
 Word byte=GetByte();
 switch(byte){
  case 0x81:*value=(DWord)get_word();return 3;
  case 0x84:*value=(DWord)get_word()+((DWord)GetByte()<<8);return 4;
  case 0x88:*value=get_long();return 5;
  default:*value=(DWord)byte;return 1;
 }
}

Word get_word(){return GetByte()+(GetByte()<<8);}

int GrpCmp(GRP_T*rec_1,GRP_T*rec_2){
 return rec_1->index>rec_2->index?LEFT:rec_1->index<rec_2->index?RIGHT:EQUAL;
}

void grpdef(Word length){
 NAME_T name_search,*group,*segment;SEG_T seg_search,*seg;
 int gcd,name_idx;char*group_text,*group_name;
 length-=get_index(&name_search.index),name_idx=name_search.index;
 group=(NAME_T*)find((char*)&name_search,name_tree,TC NameCmp,NULL);
 if(group==NULL)fmt_error("Nom d'index ind‚fini");
 group_text="GROUP",group_name=group->name,grp_operands[0]='\0';
 --length;
 while(length) {
  --length,gcd=GetByte();
  switch(gcd){
   case GRP_SI:
    length-=get_index(&seg_search.index);
    seg=(SEG_T*)find((char*)&seg_search,segment_tree,TC SegCmp,NULL);
    if(seg==NULL)fmt_error("Segment ind‚fini");
    name_search.index=seg->name;
    segment=(NAME_T*)find((char*)&name_search,name_tree,TC NameCmp,NULL);
    if(strlen(grp_operands)+strlen(segment->name)>50)
    {
     strcat(grp_operands,"\\");
     if(strcmp(group_name,"FLAT")!=0)OutLn(group_name,group_text,grp_operands,"");
     group_name="",group_text="",grp_operands[0]='\0';
    }
    strcat(grp_operands,segment->name);
    if(length)strcat(grp_operands,", ");
    break;
   case GRP_EI:
    fprintf(stderr, "Group Component: GRP_EI (External Index)\n");
    fmt_error("Un-implemented GROUP operands");
    break;
   case GRP_SCO:
    fprintf(stderr, "Group Component: GRP_SCO (Seg/Class/Ovly Index)\n");
    fmt_error("Un-implemented GROUP operands");
    break;
   case GRP_LTL:
    fprintf(stderr,"Group Component: GRP_LTL (LTL data)\n");
    fmt_error("Un-implemented GROUP operands");
    break;
   case GRP_ABS:
    fprintf(stderr,"Group Component: GRP_ABS (Absolute)\n");
    fmt_error("Un-implemented GROUP operands");
    break;
   default:
    fprintf(stderr,"Group Component: %02X (?)\n",gcd);
    fmt_error("Un-implemented GROUP operands");
    break;
  }
 }
 if(strcmp(group_name,"FLAT")!=0){
  OutLn(group_name,group_text,grp_operands,"");
  OutNewLn();
 }
 GrpIns(name_idx);
}

void GrpIns(int name_idx){
 static group_count;
 GRP_T*group_rec; group_count=0;
 group_count++;
 group_rec=(GRP_T*)o_malloc(sizeof(GRP_T));
 group_rec->index=group_count;
 group_rec->name=name_idx;
 insert((char*)group_rec,group_tree,TC GrpCmp);
}

char*GrpName(int index){
 GRP_T*grp_rec; NAME_T*name_rec;
 grp_search.index=index;
 grp_rec=(GRP_T*)find((char*)&grp_search,group_tree,TC GrpCmp,NULL);
 if(grp_rec==NULL)fmt_error("Nom du groupe ind‚fini");
 name_search.index=grp_rec->name;
 name_rec=(NAME_T*)find((char*)&name_search,name_tree,TC NameCmp,NULL);
 if(name_rec==NULL)fmt_error("Nom du groupe ind‚fini");
 return name_rec->name;
}

void hint_advance(void){
 hint_node=traverse(hint_node,RIGHT),hint_rec=(HINT_T*)hint_node->data;
}

int hint_compare(HINT_T*rec_1,HINT_T*rec_2){
 if(rec_1->seg_idx>rec_2->seg_idx)return LEFT;
  else
 {
  if(rec_1->seg_idx<rec_2->seg_idx)return RIGHT; else
  return rec_1->offset>rec_2->offset?LEFT:rec_1->offset<rec_2->offset?RIGHT:EQUAL;
 }
}

void hint_insert(int seg_idx,DWord offset,int hint_type,DWord length){
 HINT_T*hint_rec;
 hint_rec=(HINT_T*)o_malloc(sizeof(HINT_T));
 hint_rec->seg_idx=seg_idx;
 hint_rec->offset=offset;
 hint_rec->hint_type=hint_type;
 hint_rec->length=length;
 insert((char*)hint_rec,hint_tree,TC hint_compare);
}

char*IgnoreWhiteSpc(char *start){
 char*pc=start,ch;
 while((ch=*pc)!='\0'){if(ch!=' '&&ch!='\t'&&ch!='\n')break; pc++;}
 return pc;
}

void init_trees(){
 NAME_T*name_root; SEG_T*segment_root; GRP_T*group_root;
 PUB_T*public_root; EXT_T*extern_root; SEX_T*sex_root;
 DAT_T*data_root; STRUC_T*struc_root; FIX_T*fix_root;
 HINT_T*hint_root; LINE_T*line_root;
 SCOPE_T*arg_scope_root,*loc_scope_root,*end_scope_root;
 line_root=o_malloc(sizeof(LINE_T));
 line_root->hex_offset=-1;
 line_tree=new_tree((char*)line_root,FALSE);
 loc_scope_root=o_malloc(sizeof(SCOPE_T));
 loc_scope_root->hex_offset=-1;
 loc_scope_root->head=NULL;
 loc_scope_tree=new_tree(loc_scope_root,FALSE);
 arg_scope_root=o_malloc(sizeof(SCOPE_T));
 arg_scope_root->hex_offset=-1;
 arg_scope_root->head=NULL;
 arg_scope_tree=new_tree(arg_scope_root,FALSE);
 end_scope_root=o_malloc(sizeof(SCOPE_T));
 end_scope_root->hex_offset=-1;
 end_scope_root->head=NULL;
 end_scope_tree=new_tree(end_scope_root,TRUE);
 name_root=(NAME_T*)o_malloc(sizeof(NAME_T));
 name_root->index=0;
 strcpy(name_root->name,"Noeud principal NAME");
 name_tree=new_tree((char *)name_root,FALSE);
 segment_root=(SEG_T*)o_malloc(sizeof(SEG_T));
 segment_root->index=-1;
 segment_root->name=0;
 segment_root->class=NULL;
 segment_root->length=0;
 segment_root->code=FALSE;
 segment_root->bit32=FALSE;
 segment_tree=new_tree((char*)segment_root,FALSE);
 group_root=(GRP_T*)o_malloc(sizeof(GRP_T));
 group_root->index=0;
 group_root->name=0;
 group_tree=new_tree((char*)group_root,FALSE);
 public_root=(PUB_T*)o_malloc(sizeof(PUB_T));
 public_root->seg_idx=-1;
 public_root->offset=0;
 public_root->domain=0;
 public_root->scope=FALSE;
 strcpy(public_root->name,"Noeud principal PUBLIC");
 public_tree=new_tree((char*)public_root,TRUE);
 extern_root=(EXT_T*)o_malloc(sizeof(EXT_T));
 extern_root->index=0;
 extern_root->type=0;
 extern_root->com_ext=0;
 extern_root->var_type=0;
 extern_root->size=0L;
 extern_root->used=0;
 extern_root->scope=0;
 strcpy(extern_root->name,"Noeud principal EXTERN");
 extern_tree=new_tree((char*)extern_root,FALSE);
 sex_root=(SEX_T*)o_malloc(sizeof(SEX_T));
 sex_root->seg_index=0;
 sex_tree=new_tree((char*)sex_root,FALSE);
 data_root=(DAT_T*)o_malloc(sizeof(DAT_T));
 data_root->seg_idx=-1;
 data_root->offset=0;
 data_root->file_pos=0L;
 data_root->length=0;
 data_tree=new_tree((char*)data_root,FALSE);
 struc_root=(STRUC_T*)o_malloc(sizeof(STRUC_T));
 struc_root->form="";
 struc_tree=new_tree((char*)struc_root,FALSE);
 fix_root=(FIX_T*)o_malloc(sizeof(FIX_T));
 fix_root->seg_idx=-1;
 fix_root->offset=0;
 fix_root->relate=0;
 fix_root->form=0;
 fix_root->a_mode=0;
 fix_root->a_index=0;
 fix_root->b_mode=0;
 fix_root->b_index=0;
 fix_root->displacement=0L;
 fix_root->extended=FALSE;
 fix_root->word_sized=FALSE;
 fix_tree=new_tree((char*)fix_root,FALSE);
 hint_root=(HINT_T*)o_malloc(sizeof(HINT_T));
 hint_root->seg_idx=0;
 hint_root->offset=0L;
 hint_root->hint_type=0;
 hint_root->length=0L;
 hint_tree=new_tree((char*)hint_root,FALSE);
}

NODE_T*insert(void*data,NODE_T*root_node,int(*cmp_routine)(void*,void*)){
 NODE_T*insert_node,*curr_node,*son_node,*grand_son,*path[32];
 int direct[32],level,curr_direct,con_direct;
 son_node=root_node,level=0;
 do{
  curr_node=son_node,curr_direct=(*cmp_routine)(curr_node->data,data);
  if(curr_direct==EQUAL){
   if(root_node->balance==LEFT)curr_direct=LEFT;else return curr_node;
  }
  path[level]=curr_node,direct[level]=curr_direct,level++;
  son_node=curr_node->ptr[curr_direct];
 }while(!curr_node->thread[curr_direct]);
 con_direct=1-curr_direct;
 insert_node=(NODE_T*)o_malloc(sizeof(NODE_T));
 insert_node->data=data;
 insert_node->balance=BALANCED;
 insert_node->thread[curr_direct]=TRUE;
 insert_node->thread[con_direct]=TRUE;
 insert_node->ptr[curr_direct]=curr_node->ptr[curr_direct];
 insert_node->ptr[con_direct]=curr_node;
 curr_node->thread[curr_direct]=FALSE;
 curr_node->ptr[curr_direct]=insert_node;
 do{
  son_node=curr_node,level--;
  if(level==0){
   root_node->ptr[LEFT]=(NODE_T*)(((int)root_node->ptr[LEFT])+1);
   break;
  }
  curr_node=path[level],curr_direct=direct[level];
  if(curr_node->balance==BALANCED)curr_node->balance=curr_direct;
   else
  {
   if(curr_node->balance!=curr_direct){curr_node->balance=BALANCED;break;}
    else
   {
    con_direct=1-curr_direct;
    if(son_node->balance==curr_direct){
     Swp(son_node,con_direct,curr_node,curr_direct);
     curr_node->balance=BALANCED;
    }
     else
    {
     grand_son=son_node->ptr[con_direct];
     Swp(grand_son,curr_direct,son_node,con_direct);
     Swp(grand_son,con_direct,curr_node,curr_direct);
     son_node->balance=grand_son->balance==con_direct?curr_direct:BALANCED;
     curr_node->balance=grand_son->balance==curr_direct?con_direct:BALANCED;
     son_node=grand_son;
    }
    son_node->balance=BALANCED,path[level-1]->ptr[direct[level-1]]=son_node;
    break;
   }
  }
 }while TRUE;
 return insert_node;
}

void InstrOpCode(char*text){
 if(pass==3)OutOpCode(text);
 tab_offset=0;
 inst_init();
}

void InstrOperand(char*text){if(pass==3)OutOperand(text);}

void inst_init(){
 over_seg=-1,OverOpSize=FALSE,OverAdrSize=FALSE;
 if(segment_mode==386)SizeLarge=TRUE,AddrLarge=TRUE;else SizeLarge=FALSE,AddrLarge=FALSE;
 SizeBytes=segment_bytes,AddrBytes=segment_bytes;
}

int in_out(Byte byte,char*text,int class){
 int dir=(byte&2)>>1,size=byte&1;char temp[50];
 if(size==1&&SizeLarge)size=2;
 InstrOpCode(text);
 sprintf(temp,dir==0?"%s,DX":"DX,%s",regs[size][0]);
 InstrOperand(temp);
 class=class;
 return 1;
}

void Iterated(DAT_T*DataRec,DAT_T*next_rec){
 char temp[20];Word length,length_used;PUB_T*save_pub_rec;
 int dup_only,dummy;DWord repeat;STRUC_T*this_struc;
 length=DataRec->length;
 fseek(o_file,DataRec->file_pos,L_SET);
 length=buff_init(length);
 if(data_check(0)==LABEL)ProcLabel();
 save_pub_rec=last_pub_rec;
 if(last_pub_rec){
  if(pass==3){
   if(last_pub_rec->type==FAR){
    OutDirective("=");
    OutOperand("$");
   }
   if(last_pub_rec->type==NEAR)OutEndLn();
  }
 }
 strcpy(StrucForm,"");
 dup_only=DataRec->structure?FALSE:pass==1?FALSE:TRUE,dup_buff[0]='\0';
 strcpy(struc_buff,"<");
 while(length>0){
  length_used=0;
  DataRec->size=ProcIdb(1,1L,&dup_only,DataRec->extended,&length_used,&repeat);
  sprintf(temp,"(%ld,%1d)",repeat,size_to_type(DataRec->size));
  strcat(StrucForm,temp);
  length-=length_used;
  if(length){
   strcat(dup_buff,",");
   strcat(struc_buff,",");
  }
 }
 if(dup_only){
  if(save_pub_rec) save_pub_rec->type=size_to_type(DataRec->size);
  if(pass==3){
   OutDirective(size_to_opcode(DataRec->size,&dummy));
   OutOperand(dup_buff);
   OutEndLn();
  }
 }
  else
 {
  strcat(struc_buff,">");
  if(pass==1)DataRec->structure=struc_insert(StrucForm);
  this_struc=DataRec->structure;
  if(save_pub_rec) save_pub_rec->structure=this_struc;
  if(pass==3){
   sprintf(temp,"struct_%d",this_struc->index);
   OutDirective(temp);
   OutOperand(struc_buff);
   OutEndLn();
  }
 }
 next_rec=next_rec;
}

void ledata(Word length,int extension){
 SEG_T seg_search,*seg;DWord offset;long position=o_position+length;
 length-=get_index(&seg_search.index);
 seg=(SEG_T*)find((char*)&seg_search,segment_tree,TC SegCmp,NULL);
 if(seg==NULL)fmt_error("Segment ind‚fini");
 if(extension==REGULAR)offset=(DWord)get_word(),length-=2;
                  else offset=get_long(),length-=4;
 data_seg_idx=seg_search.index,DataOfs=offset,position-=length,--length;
 dat_insert(seg_search.index,offset,position,length,extension,ENUMERATED);
}

void lidata(Word length,int extension){
 SEG_T seg_search,*seg;DWord offset;long position=o_position+length;
 length-=get_index(&seg_search.index);
 seg=(SEG_T*)find((char*)&seg_search,segment_tree,TC SegCmp,NULL);
 if(seg==NULL)fmt_error("Segment ind‚fini");
 if(extension==REGULAR)offset=(DWord)get_word(),length-=2;
                  else offset=get_long(),length-=4;
 data_seg_idx=seg_search.index,DataOfs=offset,position-=length,--length;
 dat_insert(seg_search.index,offset,position,length,extension,ITERATED);
}

void linnum(Word length){
 char*record,text[80];int i;LINE_T*line;
 GetByte();GetByte();
 length-=3,record=o_malloc(length);
 get_str(length,record);
 i=0;
 while(length){
  line=(LINE_T*)o_malloc(sizeof(LINE_T));
  line->hex_offset=*(Word*)&record[i+2];
  line = insert(line,line_tree,TC linnum_compare)->data;
  line->line_number=*(Word*)&record[i];
  sprintf(text,"; %4d: %04X",line->line_number,line->hex_offset);
  OutLn(text,"","","");
  OutNewLn();
  i+=4,length-=4;
 }
 OutNewLn();
 GetByte();
}

int linnum_compare(LINE_T*btreeline,LINE_T*line){
 return btreeline->hex_offset>line->hex_offset?LEFT:btreeline->hex_offset<line->hex_offset?RIGHT:EQUAL;
}

void list_ext(){
 NODE_T*seg_node,*ext_node;EXT_T*ext_rec;int data_index;
 data_index=0,seg_node=start(segment_tree,RIGHT);
 while(seg_node!=segment_tree){
  seg_rec=(SEG_T*)seg_node->data;
  if(stricmp(seg_rec->class->name,"DATA")==0){data_index=seg_rec->index;break;}
  seg_node=traverse(seg_node,RIGHT);
 }
 OutNewLn();
 ext_node=start(extern_tree,LEFT);
 while(ext_node!=extern_tree){
  ext_rec=(EXT_T*)ext_node->data;
  if(ext_rec->used==0||ext_rec->used==-1){
   if(compatibility==2&&data_index!=0){
    if(ext_rec->type==2||ext_rec->type==3||ext_rec->type==4||ext_rec->type==5){
     if(ext_rec->used==0){
      sex_insert(data_index,ext_rec);
      ext_rec->used=data_index;
     }
    }
     else
    print_ext(ext_rec);
   }
    else
   print_ext(ext_rec);
  }
  ext_node=traverse(ext_node,LEFT);
 }
}

void list_fix(){
 NODE_T*fix_node;FIX_T*fix_rec;char comment[50];
 OutNewLn();
 fix_node=start(fix_tree,RIGHT);
 while(fix_node!=fix_tree){
  fix_rec=(FIX_T*)fix_node->data;
  sprintf(comment,"Fixup at 0%02Xh:0%04Xh:0%04Xh",fix_rec->seg_idx,fix_rec->dat_offset, fix_rec->offset);
  OutLn("",";",comment,"");
  fix_node=traverse(fix_node,RIGHT);
 }
}

void list_pub(){
 NODE_T*pub_node;PUB_T*pub_rec;char comment[50],*label;
 OutNewLn();
 pub_node=start(public_tree,RIGHT);
 while(pub_node!=public_tree){
  pub_rec=(PUB_T*)pub_node->data;
  label=pub_rec->scope?"":";Static";
  if(pub_rec->domain==PUBLIC){
   sprintf(comment,"Localis‚e au %d:%04lXh Type = %d",pub_rec->seg_idx,pub_rec->offset,pub_rec->type);
   OutLabel(label);
   OutOpCode("PUBLIC");
   TabSeek(3);
   OutOperand(pub_rec->name);
   OutComment(comment);
  }
  pub_node=traverse(pub_node,RIGHT);
 }
}

NODE_T*LstSEx(NODE_T*node,int seg_num){
 SEX_T*sex_rec;EXT_T*ext_rec;
 sex_rec=(SEX_T*)node->data;
 while(node!=sex_tree&&sex_rec->seg_index<seg_num)
  node=traverse(node,RIGHT),sex_rec=(SEX_T*)node->data;
 OutNewLn();
 while(node!=sex_tree&&sex_rec->seg_index==seg_num){
  ext_rec=sex_rec->ext_rec;
  if(ext_rec->used==seg_num)print_ext(sex_rec->ext_rec);
  node=traverse(node,RIGHT),sex_rec=(SEX_T*)node->data;
 }
 return node;
}

void list_struc(){
 NODE_T*struc_node;STRUC_T*struc_rec;char temp[50];int index;
 char*cp,ch;DWord dup_cnt;int type,mem_cnt,times;
 index=0;
 OutNewLn();
 struc_node=start(struc_tree,RIGHT);
 while(struc_node!=struc_tree){
  struc_rec=(STRUC_T*)struc_node->data,struc_rec->index=index,cp=struc_rec->form;
  sprintf(temp,"struct_%d",index);
  OutLn(temp,"struc", "","");
  mem_cnt=0;
  while((ch=*cp)!='\0'){
   switch(ch){
    case'(':dup_cnt=atol(cp+1);break;
    case',':type=atoi(cp+1);break;
    case')':
     sprintf(temp,"s%dm_%d",index,mem_cnt);
     OutLabel(temp);
     OutDirective(size_to_opcode(type_to_size(type),&times));
     if(dup_cnt==1L)strcpy(temp,"?");else sprintf(temp,"%ld DUP (?)",dup_cnt);
     OutOperand(temp);
     OutEndLn();
     mem_cnt++;
    default:
     break;
   }
   cp++;
  }
  sprintf(temp,"struct_%d",index);
  OutLn(temp,"EndS","","");
  OutNewLn();
  index++;
  struc_node=traverse(struc_node,RIGHT);
 }
}

void lnames(Word length){
 char mod_name[41];
 --length;
 while(length){
  length-=get_name(mod_name);
  NameIns(mod_name);
 }
 GetByte();
}

void load_extra(char*exename,char*filename){
 FILE*e_file;
 char temp_name[50],e_line[LINE_SIZE+1];
 char*pc,*semicolon,*equal,*colon,seg_text[NAMESIZE+1],lab_text[NAMESIZE+1];
 int SegType,count,line_num;DWord disp;
 strcpy(temp_name,filename);
 if(strchr(temp_name,'.')==NULL)strcat(temp_name,".ADD");
 e_file=fopen(temp_name,"r");
 if(e_file==NULL){
  fprintf(stderr,"%s: Impossible d'ouvrir %s\n",exename,temp_name);
  exit(6);
 }
 line_num=1;
 while (fgets(e_line,LINE_SIZE,e_file)!=NULL){
  semicolon=strchr(e_line,';');
  if(semicolon)*semicolon='\0';
  pc=IgnoreWhiteSpc(e_line);
  if(strnicmp(pc,"SEG ",4)==0){
   pc=IgnoreWhiteSpc(pc+4),pc=GetTxt(seg_text,pc);
   pc=IgnoreWhiteSpc(pc),SegType=0;
   if(strnicmp(pc,"CODE",4)==0)pc+=4,SegType=1;
   if(strnicmp(pc,"DATA",4)==0)pc+=4,SegType=2;
   if(SegType==0){
    fprintf(stderr,"%s: Erreur de systaxe dans la ligne %d de %s (doit ˆtre CODE/DATA).\n",exename,line_num,temp_name);
    exit(7);
   }
   seg_rec=FindSegByName(seg_text);
   if(!seg_rec){
    fprintf(stderr,"%s: Erreur de systaxe dans la ligne %d de %s (Le segment '%s' introuvable)\n",exename,line_num,temp_name,seg_text);
    exit(7);
   }
   seg_rec->code=SegType==1?TRUE:FALSE;
  }
  equal=strchr(pc,'=');
  if(equal){
   pc=GetTxt(lab_text,pc),pc=IgnoreWhiteSpc(pc);
   if(strnicmp(pc,"=",1)!=0){
    fprintf(stderr,"%s: Erreur de systaxe dans la ligne %d de %s ('=' attendu aprŠs l''‚tiquette)\n",exename,line_num,temp_name);
    exit(7);
   }
   pc=IgnoreWhiteSpc(pc+1),colon=strchr(pc,':');
   if(colon==NULL){
    fprintf(stderr,"%s: Erreur de systaxe dans la ligne %d de %s (':' attendu)\n",exename,line_num,temp_name);
    exit(7);
   }
   pc=GetTxt(seg_text,pc),pc=IgnoreWhiteSpc(colon+1);
   pc=GetNm(pc,&disp),seg_rec=FindSegByName(seg_text);
   if(!seg_rec){
    fprintf(stderr,"%s: Erreur de systaxe dans la ligne %d de %s (Le segment '%s' est introuvable)\n",exename,line_num,temp_name,seg_text);
    exit(7);
   }
   pub_insert(seg_rec->index,disp,lab_text,LOCAL,FALSE);
  }
  colon=strchr(pc,':');
  if(colon){
   pc=GetTxt(seg_text,pc),seg_rec=FindSegByName(seg_text);
   if(!seg_rec){
    fprintf(stderr,"%s: Erreur de systaxe dans la ligne %d de %s (Le segment '%s' est introuvable)\n",exename,line_num,temp_name,seg_text);
    exit(7);
   }
   pc=IgnoreWhiteSpc(pc);
   if(strnicmp(pc,":",1)!=0){
    fprintf(stderr,"%s: Erreur de systaxe dans la ligne %d de %s (attend le s‚parateur ':')\n",exename,line_num,temp_name);
    exit(7);
   }
   pc=GetNm(pc+1,&disp),pc=IgnoreWhiteSpc(pc);
   if(strnicmp(pc,":",1)!=0){
    fprintf(stderr,"%s: Erreur de systaxe dans la ligne %d de %s (attend le s‚parateur ':')\n",exename,line_num,temp_name);
    exit(7);
   }
   pc=IgnoreWhiteSpc(pc+1),pc=GetTxt(lab_text,pc),count=0;
   while(count<hint_nwords){
    if(stricmp(lab_text,hint_words[count].text)==0)break;
    count++;
   }
   if(count==hint_nwords){
    fprintf(stderr,"%s: Erreur de systaxe dans la ligne %d de %s (attend DB/DW/DD/DF/DQ/DT)\n",exename,line_num,temp_name);
    exit(7);
   }
   hint_insert(seg_rec->index,disp,hint_words[count].type,1);
  }
  pc=IgnoreWhiteSpc(pc);
  if(strlen(pc)!=0){
   fprintf(stderr,"%s: Erreur de systaxe dans la ligne %d de %s (trop de caractŠres dans la ligne '%s')\n",exename,line_num,temp_name,pc);
   exit(7);
  }
  line_num++;
 }
 fclose(e_file);
}

void LonePub(){
 char operand[80];
 if(pass==3){
  OutLabel(pub_rec->name);
  OutDirective("=");
  if(segment==0)sprintf(operand,"0%04Xh",pub_rec->offset);
   else
  {
   long relative=(long)pub_rec->offset-inst_offset;
   if(relative<0L)sprintf(operand,"$ - 0%04lXh",-relative);
             else sprintf(operand,"$ + 0%04lXh",relative);
  }
  OutOperand(operand);
  OutEndLn();
 }
}

int Mod0(int ref_mode,int sib_offset,char*sib_text,char*text,Byte r_m,int type,int*size_known){
 DWord offset; PUB_T*pub_rec; STRUC_T*pub_struct;
 int ref_seg; char this_member[NAMESIZE+1+1],temp[16];
 this_member[0]='\0';
 if((r_m==6&&!AddrLarge)||(r_m==5&&AddrLarge)){
  ref_seg=over_seg!=-1?17+over_seg:DS;
  switch(data_check(2+sib_offset)){
   case BAD:return-1;
   case LABEL:return-1;
   case FIXUP:
    if(fix_rec->word_sized&&fix_rec->extended==AddrLarge){
     get_fix(text,0,FALSE,SizeBytes,type,TRUE,size_known,ref_seg);
     if(strlen(sib_text)){
      strcat(text,"[");
      strcat(text,sib_text);
      strcat(text,"]");
     }
     return AddrBytes+sib_offset;
    }
     else
    return-1;
   case NORMAL:
    if(ChkGetV(&offset,SizeLarge))return-1;
    pub_rec=add_labels?check_public(0,0,offset,'S'):NULL;
    if(pub_rec){
     offset-=pub_rec->offset,pub_struct=pub_rec->structure;
     if(pub_struct)find_member(this_member,pub_struct,&offset);
     if(offset!=0){
      out_hexize(offset,temp,SizeBytes);
      sprintf(text,"%s%s + %s",pub_rec->name,this_member,temp);
     }
      else
     sprintf(text,"%s%s",pub_rec->name,this_member);
    }
     else
    {
     out_hexize(offset,temp,SizeBytes);
     if(compatibility==2)sprintf(text," .%s",temp);
      else
     {
      sprintf(text,over_seg==-1?"DS:[%s":"[%s",temp);
      if(strlen(sib_text)){
       strcat(text,"+");
       strcat(text,sib_text);
      }
      strcat(text,"]");
     }
    }
    *size_known=FALSE;
    return AddrBytes+sib_offset;
  }
 }
 strcpy(text,AddrLarge?addr_386m[r_m]:addr_mode[r_m]);
 if(strlen(sib_text)){
  strcat(text,"+");
  strcat(text,sib_text);
 }
 strcat(text,"]");
 *size_known=TRUE;
 return sib_offset;
}

int Mod1(int ref_mode,int sib_offset,char*sib_text,char*text,Byte r_m){
 char temp[50];DWord offset;Byte zero_rm;
 if(ChkGetC(&offset))return-1;
  else
 {
  if(AddrLarge){
   zero_rm=5;
   strcpy(text,addr_386m[r_m]);
  }
   else
  {
   zero_rm=6;
   strcpy(text,addr_mode[r_m]);
  }
  if(strlen(sib_text)){
   strcat(text,"+");
   strcat(text,sib_text);
  }
  if(offset>=0x80)sprintf(temp,"-0%02lXh",0x0100L-offset);
   else
  {
   if(offset==0L){
    if(r_m==zero_rm)temp[0]='\0';else return-1;
   }
    else
   sprintf(temp,"+0%02lXh",offset);
  }
  if(compatibility==2)
  {
   strcat(text,"]");
   strcat(text,temp);
  }
   else
  {
   strcat(text,temp);
   strcat(text,"]");
  }
  return 1+sib_offset;
 }
}

int Mod2(int ref_mode,int sib_offset,char*sib_text,char*text,Byte r_m,int type,int*size_known){
 DWord offset;int result;char temp[50],*sign;int ref_seg;
 ref_seg=r_m==2 ||r_m==3?SS:DS;
 if(over_seg!=-1)ref_seg=17+over_seg;
 switch(data_check(2+sib_offset)){
  case BAD:result=-1;break;
  case LABEL:result=-1;break;
  case FIXUP:
   if(fix_rec->word_sized&&fix_rec->extended==AddrLarge){
    get_fix(temp,0,FALSE,AddrBytes,type,TRUE,size_known,ref_seg);
    if(compatibility==2){
     strcpy(text,temp);
     strcat(text,addr_mode[r_m]);
    }
     else
    {
     strcpy(text,AddrLarge?addr_386m[r_m]:addr_mode[r_m]);
     if(strlen(sib_text)){
      strcat(text,"+");
      strcat(text,sib_text);
     }
     strcat(text,"+");
     strcat(text,temp);
    }
    strcat(text,"]");
    result=AddrBytes+sib_offset;
   }
    else
   result=-1;
   break;
  case NORMAL:
   if(ChkGetV(&offset,AddrLarge))result=-1;
    else
   {
    if(offset==0x00000000L)return-1;
    strcpy(text,AddrLarge?addr_386m[r_m]:addr_mode[r_m]);
    if(strlen(sib_text)){
     strcat(text,"+");
     strcat(text,sib_text);
    }
    if(offset>0x80000000L)offset=-offset,sign="-";else sign="+";
    out_hexize(offset,temp,AddrBytes);
    if(compatibility==2){
     strcat(text,"]");
     strcat(text,sign);
     strcat(text,temp);
    }
     else
    {
     strcat(text,sign);
     strcat(text,temp);
     strcat(text,"]");
    }
    result=AddrBytes+sib_offset,*size_known=TRUE;
   }
   break;
 }
 return result;
}

int Mod3(int ref_mode,char*text,Byte r_m,int type,int*type_known){
 switch(type){
  case BYTE_PTR:strcpy(text,regs[0][r_m]);break;
  case WORD_PTR:strcpy(text,regs[1][r_m]);break;
  case DWORD_PTR:strcpy(text,regs[2][r_m]);break;
  default:strcpy(text,regs[3][r_m]);break;
 }
 *type_known=TRUE;
 return 0;
}

int DoSib(char*text,Byte*base){
 DWord sib_byte;int ss,idx;
 switch(data_check(2)){
  case LABEL:return -1;
  case FIXUP:return -1;
  case BAD:
  case NORMAL:
   if(ChkGetC(&sib_byte))return-1;
   ss=(int)(sib_byte&0xC0L)>>6,idx=(int)(sib_byte&0x38L)>>3;
   *base=(Byte)(sib_byte&7L);
   if(idx==4){
    if(ss!=0)return-1;else strcpy(text,"");
   }
    else
   {
    strcat(text,regs[2][idx]);
    strcat(text,sib_scale[ss]);
   }
   return 1;
 }
}

void modend(Word length,int extension){
 int type=GetByte();
 if(type&0x40)data_seg_idx=0,DataOfs=0L,length-=decode_fixup(1,0,1,1,extension);
}

char *mode_name(int mode,int index){
 Word dummy;
 if(index==0)return"NOTHING";
 switch(mode){
  case SEGMENT:return SegName(index,&dummy);
  case GROUP:return GrpName(index);
  case LOCATION:return cseg_name;
  case EXTERNAL:
  case FRAME:
  case TARGET:
  case NONE:return NULL;
 }
 return NULL;
}

int mod_reg(Byte byte,char*text,int class){
 char*opcode;int dir,size,reg_size,SizeNeeded,type,method,group;
 DWord mod_reg;Byte mod,r_m,reg;int additional;
 char mem_text[50],reg_text[50],third_text[50],operands[80];int ref_mode;
 if(GetChkC(&mod_reg))return 0;
 mod=(Byte)(((int)mod_reg&0xC0)>>6),reg=(Byte)(((int)mod_reg&0x38)>>3);
 r_m=(Byte)((int)mod_reg&7),dir=modrm_class[class].dir;
 size=modrm_class[class].size,method=modrm_class[class].method;
 group=modrm_class[class].group,SizeNeeded=modrm_class[class].SizeNeeded;
 type=modrm_class[class].type,ref_mode=0;
 if(group==6){
  if(mod==3)if(reg==0||reg==1||reg==2||reg==3)AddrLarge=FALSE,SizeLarge=FALSE;
  type=WORD_PTR,SizeNeeded=TRUE;
 }
 reg_size=size;
 if(reg_size==1&&SizeLarge)reg_size=2;
 if(type==UNKNOWN)type=reg_size_to_type(reg_size);
 opcode=group==0?text:op_grp[group-1][reg];
 if(strlen(opcode)==0)return 0;
 if(class==26)reg_size=1;
 if(byte==0x62||byte==0x63){
  if(byte==0x63)type=WORD_PTR;
  SizeNeeded=TRUE;
 }
 if(byte==0xC4||byte==0xC5||byte==0xB2||byte==0xB4||byte==0xB5)SizeNeeded=TRUE;
 if(group==3){
  if(reg==0)method=5+size,dir=0,SizeNeeded=TRUE;
       else method=0,SizeNeeded=reg==2||reg==3?FALSE:TRUE;
 }
 if(group==5){
  if(reg==3||reg==5)type=SizeLarge?FWORD_PTR:DWORD_PTR,SizeNeeded=TRUE;
               else if(reg==0||reg==1)SizeNeeded=TRUE;
 }
 if(group==7){if(reg==4||reg==6)type=WORD_PTR;}
 if(dir==0&&mod==3&&(class==0||class==1))return 0;
 mem_text[0]='\0';
 additional=DoModRM(mem_text,mod,r_m,type,SizeNeeded,ref_mode);
 if(additional==-1)return 0;
 switch(method){
  case 0:break;
  case 1:
   if(byte==0xC4||byte==0xC5||byte==0x62||byte==0x63||byte==0xB2||byte==0xB4||byte==0xB5)reg_size=1;
   strcpy(reg_text,regs[reg_size][reg]);
   break;
  case 2:
   if(reg>5)return 0;
   strcpy(reg_text,sregs[reg]);
   break;
  case 3:strcpy(reg_text,"1");break;
  case 4:strcpy(reg_text,"CL");break;
  case 5:
   if(ByteImmed(reg_text,additional,FALSE))return 0;
   additional++;
   break;
  case 6:
   if(WordImm(reg_text,additional))return 0;
   additional+=SizeLarge?4:2;
   break;
  case 7:
   if(ByteImmed(reg_text,additional,TRUE))return 0;
   additional++;
   break;
  case 8:
   strcpy(reg_text,regs[reg_size][reg]);
   if(WordImm(third_text,additional))return(0);
   additional+=2;
   break;
  case 9:
   strcpy(reg_text,regs[reg_size][reg]);
   if(ByteImmed(third_text,additional,TRUE))return 0;
   additional+=1;
   break;
  case 10:strcpy(reg_text,cr_regs[reg]);break;
  case 11:strcpy(reg_text,dr_regs[reg]);break;
  case 12:strcpy(reg_text,tr_regs[reg]);break;
  case 13:strcpy(reg_text,regs[reg_size][reg]);strcpy(third_text,"CL");break;
 }
 if(dir&1)sprintf(operands,dir_fmt[dir],reg_text,mem_text,third_text);
     else sprintf(operands,dir_fmt[dir],mem_text,reg_text,third_text);
 AdjustAssumes();
 InstrOpCode(opcode);
 InstrOperand(operands);
 return 2+additional;
}

int NameCmp(NAME_T*rec_1,NAME_T*rec_2){
 return rec_1->index>rec_2->index?LEFT:rec_1->index<rec_2->index?RIGHT:EQUAL;
}

void NameIns(char*this_name){
 static name_count=0; NAME_T*name_rec;
 name_count++,name_rec=(NAME_T*)o_malloc(sizeof(NAME_T));
 name_rec->index=name_count;
 strcpy(name_rec->name,this_name);
 insert((char*)name_rec,name_tree,TC NameCmp);
}

NODE_T*new_tree(void*data_ptr,int dup_allowed){
 NODE_T*tree;
 tree=(NODE_T*)o_malloc(sizeof(NODE_T)),tree->data=data_ptr;
 tree->balance=dup_allowed?LEFT:RIGHT;
 tree->ptr[LEFT]=0,tree->ptr[RIGHT]=(NODE_T*)tree;
 tree->thread[LEFT]=TRUE,tree->thread[RIGHT]=TRUE;
 return tree;
}

int one_a(Byte byte,char*text,int class){
 char line[50];
 if(SizeLarge)RegFormat(class,line,text,"%s\tEAX","%s\tEAX,%s");
         else RegFormat(class,line,text,"%s\tAX","%s\tAX,%s");
 InstrOpCode(line);
 byte=byte;
 return 1;
}

int one_byte(Byte byte,char *text,int class){
 char line[50];
 if(strlen(text)==0)return 0;
 RegFormat(class,line,text,"%s","%s\t%s");
 InstrOpCode(line);
 byte=byte;
 return 1;
}

void OutComment(char*comment){
 if(strcmp(comment,""))
 {
  TabSeek(7);
  printf("; %s",comment);
  col_cnt+=2;
  TabI(comment);
 }
}

void OutDirective(char*direct){
 TabNext();
 if(tab_at<2)TabNext();
 printf("%s",direct);
 TabI(direct);
}

void OutEndLn(){
 putc('\n',stdout);
 tab_offset=0,tab_at=0,col_cnt=0;
}

char*out_hexize(DWord offset,char*text,int bytes){
 char temp[15];
 switch(bytes){
  case 1:sprintf(temp,"%02Xh",(Byte)offset);break;
  case 2:sprintf(temp,"%04Xh",(Word)offset);break;
  case 4:sprintf(temp,"%08lXh",offset);break;
  default:fmt_error("Erreur interne appellant out_hexize()");break;
 }
 if(temp[0]>='0'&&temp[0]<='9')strcpy(text,temp);else sprintf(text,"0%s",temp);
 return text;
}

void OutLabel(char*label){
 TabSeek(1);
 printf("%s",label);
 TabI(label);
}

void OutLn(char*label,char*opcode,char*operand,char*comment){
 OutLabel(label);
 OutDirective(opcode);
 OutOperand(operand);
 OutComment(comment);
}

void OutNewLn(){OutEndLn();}

void OutOpCode(char*opcode){
 TabSeek(2+tab_offset);
 printf("%s",opcode);
 TabI(opcode);
}

void OutOperand(char*operand){
 if(strcmp(operand,"")){
  TabNext();
  printf("%s",operand);
  TabI(operand);
 }
}

int opsize_over(Byte byte,char*text,int class){
 int valid,save_large,save_bytes;
 byte=byte,text=text,class=class;
 save_large=SizeLarge,save_bytes=SizeBytes;
 SizeLarge=!SizeLarge,SizeBytes=SizeBytes==2?4:2;
 OverOpSize=TRUE, valid=ChkForward(instr,1);
 if(valid)return valid+1;
  else
 {
  SizeLarge=save_large,SizeBytes=save_bytes;
  return 0;
 }
}

static void out_var(LOCAL_VAR*pVar){
 char *p,temp[50],text[80];
 sprintf(text,"\"%s\"",pVar->vname);
 switch (pVar->class){
  case 7:OutLn("; (circonstance d'un type de variable)",text,"","");return;
  case 6:OutLn("; (typedef local)",text,"","");return;
  case 4:
   switch(pVar->bInfo1){
    case 6:p="SI";break;
    case 7:p="DI";break;
    default:p="[Inconnu]";break;
   }
   sprintf(temp,": variable dans registre %s",p);
   strcat(text,temp);
   OutLn(";",text,"","");
   break;
  case 2:
   p=pVar->bInfo1&8==8?"argument":"local";
   sprintf(temp,": (var) %s stocker dans ",p);
   strcat(text,temp);
   switch(pVar->bInfo2){
    case 1:
     if((int)pVar->wInfo1<0)sprintf(temp,"[BP-%04X]",-pVar->wInfo1);
                       else sprintf(temp,"[BP+%04X]",pVar->wInfo1);
     break;
    default:strcpy(temp,"[Inconnu]");break;
   }
   strcat(text,temp);
   OutLn(";",text,"","");
   return;
  case 0:OutLn(";",temp," (fonction static) ","");
 }
}

void*o_malloc(Word size){
 char*result; result=(char *)calloc(1,size);
 if(result==NULL){
  fprintf(stderr,"Manque de m‚moire! [Crrraassshhhhh....]\n");
  exit(4);
 }
 return result;
}

int prefix(Byte byte,char*text,int class){
 int valid=ChkForward(instr,0);
 byte=byte,class=class;
 if(valid){
  InstrOpCode(text);
  tab_offset=1, hex_finish=FALSE;
  return 1;
 }
  else
 return 0;
}

void PreDups(long count,int orgable){
 char *opcode,*operand,temp[80];int times;
 if(last_pub_rec&&pass==3){
  if(last_pub_rec->type==FAR){
   OutDirective("=");
   OutOperand("$");
  }
  if(last_pub_rec->type==NEAR)OutEndLn();
 }
 if(count!=0L){
  if((orgable&&inst_offset==0&&count>0L)||count<0L){
   opcode="ORG";
   sprintf(temp,"0%04Xh",inst_offset+count);
   operand=temp;
  }
   else
  {
   if(compatibility==2){
    operand="1";
    switch((int)count){
     case 1:opcode="rb";break;
     case 2:opcode="rw";break;
     case 4:opcode="rd";break;
     default:
      opcode="rs";
      sprintf(temp,"0%04Xh",count);
      operand=temp;
      break;
    }
   }
    else
   {
    operand="1 DUP (?)",opcode=size_to_opcode((int)count,&times);
    sprintf(temp,"%d DUP(?)",times);
    operand=temp;
   }
  }
  if(pass==3&&count!=0L){
   OutDirective(opcode);
   OutOperand(operand);
   OutEndLn();
  }
  inst_offset+=count,last_pub_rec=NULL;
 }
}

void print_ext(EXT_T*ext_rec){
 char operand[80],*var_type,*label;int type;NODE_T*pub_node;PUB_T*pub_rec;
 pub_node=start(public_tree,RIGHT);
 while(pub_node!=public_tree){
  pub_rec=(PUB_T*)pub_node->data;
  if(strcmp(pub_rec->name,ext_rec->name)==0)return;
  pub_node=traverse(pub_node,RIGHT);
 }
 label=ext_rec->scope?"":";Static";
 if(ext_rec->com_ext==0){
  if(ext_rec->type==UNKNOWN&&ext_rec->pos_abs==FALSE)ext_rec->type=NEAR;
  sprintf(operand,"%s:%s",ext_rec->name,ext_type[ext_rec->type]);
  OutLabel(label);
  OutOpCode("EXTRN");
  TabSeek(3);
  OutOperand(operand);
 }
  else
 {
  switch(ext_rec->var_type){
   case 0x61:var_type="COMM FAR";break;
   case 0x62:var_type="COMM";break;
   default:fmt_error("Type de variable commune inconnu");break;
  }
  type=ext_rec->type;
  sprintf(operand,"%s:%s:%ld",ext_rec->name,ext_type[type],ext_rec->size);
  OutLabel(label);
  if(ext_rec->var_type==0x62)TabSeek(3);
  OutOpCode(var_type);
  OutOperand(operand);
 }
}

void process(){
 NODE_T*seg_node;char text[80];int dummy;
 pub_node=start(public_tree,RIGHT),pub_rec=(PUB_T*)pub_node->data;
 fix_node=start(fix_tree,RIGHT),fix_rec=(FIX_T*)fix_node->data;
 data_node=start(data_tree,RIGHT),DataRec=(DAT_T*)data_node->data;
 hint_node=start(hint_tree,RIGHT),hint_rec=(HINT_T*)hint_node->data;
 sex_node=start(sex_tree,RIGHT);
 if(pass==3&&!processor_type_comment_occurred){
  OutLn("",".286p","","");
  OutLn("",".287","","");
  processor_mode=286;
 }
 segment=0;
 if(pass==3&&pub_rec->seg_idx==segment)OutNewLn();
 while(pub_rec->seg_idx==segment){
  LonePub();
  PubAdvance();
 }
 segment_mode=processor_mode,seg_node=start(segment_tree,RIGHT);
 while(seg_node!=segment_tree){
  seg_rec=(SEG_T*)seg_node->data;
  ProcSeg();
  seg_node=traverse(seg_node,RIGHT);
 }
 fix_search.seg_idx=0,fix_search.dat_offset=0,fix_search.offset=1;
 fix_rec=(FIX_T*)find((char*)&fix_search,fix_tree,TC fix_compare,NULL);
 if(fix_rec==NULL){
  if(pass==3){
   OutNewLn();
   OutOpCode("END");
   OutNewLn();
  }
 }
  else
 {
  get_target(text,fix_rec,0,0L,FALSE,0,FALSE,&dummy,CS);
  if(pass==3){
   OutNewLn();
   OutLn("","END",text,"Adresse de d‚part du Module");
  }
 }
}

void ProcSeg(void){
 NAME_T*name_rec;DAT_T*next_rec;int inst_proc,SegReg;
 segment=seg_rec->index;
 if(seg_rec->length==0&&(sex_node==sex_tree||((SEX_T*)sex_node->data)->seg_index>segment)&&
   (pub_node==public_tree||((PUB_T*)pub_node->data)->seg_idx>segment))return;
 for(SegReg=0;SegReg<MAX_SEG_REGS;SegReg++)
  seg_rec->new_mode[SegReg]=0,seg_rec->new_index[SegReg]=0,
  seg_rec->prv_mode[SegReg]=0,seg_rec->prv_index[SegReg]=0;
 while(hint_node!=hint_tree&&hint_rec->seg_idx<segment)hint_node=traverse(hint_node,RIGHT);
 name_search.index=seg_rec->name;
 name_rec=find(&name_search,name_tree,TC NameCmp,NULL);
 if(name_rec==NULL)fmt_error("Perte du nom du Segment de Code (Oops!)");
 cseg_name=name_rec->name;
 segment_mode=seg_rec->bit32?386:286,segment_bytes=segment_mode==386?4:2;
 if(pass==3){
  OutNewLn();
  if(seg_rec->code){
   if(compatibility==2)OutLn(cseg_name,"CSEG","","");
    else
   {
    OutLn(cseg_name,"SEGMENT","","");
    seg_rec->new_mode[1]=SEGMENT,seg_rec->new_index[1]=segment;
    AdjustAssumes();
   }
  }
   else
  {
   if(compatibility==2){
    if(stricmp(seg_rec->class->name,"CODE")==0)OutLn(cseg_name,"CSEG","",""); else
    if(stricmp(seg_rec->class->name,"DATA")==0)OutLn(cseg_name,"DSEG","",""); else
    if(stricmp(seg_rec->class->name,"STACK")==0)OutLn(cseg_name,"SSEG","",""); else
    if(stricmp(seg_rec->class->name,"EXTRA")==0)OutLn(cseg_name,"ESEG","","");
                                           else OutLn(cseg_name,seg_rec->class->name,"","");
   }
    else
   OutLn(cseg_name,"SEGMENT","","");
  }
  sex_node=LstSEx(sex_node,segment);
 }
 inst_proc=seg_rec->code,last_pub_rec=NULL, inst_offset=0;
 inst_init();
 if(data_node!=data_tree){
  while(DataRec->seg_idx==segment){
   data_node=traverse(data_node,RIGHT),next_rec=(DAT_T*)data_node->data;
   if(data_node!=data_tree&&DataRec->type==ENUMERATED&&next_rec->type==ENUMERATED&&next_rec->seg_idx==segment&&
    DataRec->offset+DataRec->length==next_rec->offset)ProcDRec(DataRec,next_rec,inst_proc);
   else
    ProcDRec(DataRec,NULL,inst_proc);
   DataRec=next_rec;
  }
 }
 if(pass==3&&pub_rec->seg_idx==segment)OutNewLn();
 while(pub_rec->seg_idx==segment){
  PreDups(pub_rec->offset-inst_offset,FALSE);
  ProcLabel();
 }
 PreDups(seg_rec->length-inst_offset,FALSE);
 if(pass==3){
  OutNewLn();
  if(compatibility!=2)OutLn(cseg_name,"ENDS","","");
 }
}

void ProcDRec(DAT_T*DataRec,DAT_T*NextRec,int InstProc){
 int orgable;
 if(pass==3)OutNewLn();
 if(inst_offset!=DataRec->offset+RecOverUsed){
  pub_search.seg_idx=segment;
  pub_search.offset=DataRec->offset+RecOverUsed;
  orgable=TRUE;
  while(pub_node!=public_tree&&PubCmp(&pub_search,pub_rec)==LEFT){
   PreDups(pub_rec->offset-inst_offset,orgable);
   ProcLabel();
   orgable=FALSE;
  }
  PreDups(DataRec->offset+RecOverUsed-inst_offset,orgable);
 }
 DataOfs=DataRec->offset;
 switch(DataRec->type){
  case ENUMERATED:Enum(DataRec,NextRec,InstProc);break;
  case ITERATED:Iterated(DataRec,NextRec);break;
 }
}

int ProcFixUp(){
 int fix_size,fix_form,fix_extended;char operand[100];int dummy;
 fix_form=fix_rec->form; fix_extended=fix_rec->extended;
 fix_size=get_fix(operand,2,FALSE,segment_bytes,fix_form==POINTER?FAR:NEAR,FALSE,&dummy,DS);
 if(pass==3){
  if(fix_form==OFFSET&&fix_extended)OutDirective("dd"); else
  if(fix_form==POINTER&&fix_extended)OutDirective("df");
                                else OutDirective(fix_type[fix_form].form);
 }
 inst_offset+=fix_size;
 if(pass==3){
  OutOperand(operand);
  OutEndLn();
 }
 BuffEmpty();
 if(last_pub_rec)last_pub_rec->type=size_to_type(fix_size),last_pub_rec=NULL;
 return fix_size;
}

int ProcIdb(int depth,DWord mult,int*dup_only,int extended,Word*length_used,DWord*repeat_cnt){
 DWord repeat;Word num_blocks,blocks,length;int data;Word data_size,result=512;
 int fix_size;char operand[80];Byte rev_buff[10];Word out_count;int dcheck,dummy;
 repeat=(DWord)buff_regetc(),repeat+=(DWord)buff_regetc()<<8,*length_used+=2;
 if(extended)repeat+=(DWord)buff_regetc()<<16,repeat+=(DWord)buff_regetc()<<24,*length_used+=2;
 num_blocks=buff_regetc(),num_blocks+=buff_regetc()<<8,*length_used+=2;
 if(repeat_cnt)*repeat_cnt=repeat;
 if(repeat!=1||num_blocks!=0){
  sprintf(idb_buff,"%ld DUP(",repeat);
  strcat(dup_buff,idb_buff);
 }
 mult*=repeat;
 if(num_blocks){
  blocks=num_blocks;
  while(blocks){
   if(depth==2)*dup_only=TRUE;
   data_size=ProcIdb(depth+1,mult,dup_only,extended,length_used,NULL);
   if(data_size<result)result=data_size;
   --blocks;
   if(blocks!=0){
    strcat(dup_buff,",");
    strcat(struc_buff,",");
   }
  }
 }
  else
 {
  length=buff_regetc(),result=length,*length_used+=length+1,data_size=0;
  while(length){
   do{
    data=BuffGetC();
    if(data==EOF)break;
    if(data<' '||data>'~')break;
    data_size++,inst_offset+=mult,dcheck=data_check(0);
   }
   while(*dup_only&&(dcheck==NORMAL||dcheck==BAD));
   if(*dup_only&&data_size>=data_string){
    buff_reseek();
    length-=data_size,idb_buff[0]='\'',out_count=1;
    while(data_size)data=buff_regetc(),idb_buff[out_count++]=(char)data,--data_size;
    idb_buff[out_count++]='\'',idb_buff[out_count]='\0';
    if(depth!=1)*dup_only=TRUE;
    strcat(dup_buff,idb_buff);
    strcat(struc_buff,idb_buff);
   }
    else
   {
    inst_offset-=data_size*mult;
    buff_reseek();
    if(data_check(0)==FIXUP){
     if(depth!=1)*dup_only=TRUE;
     fix_size=get_fix(operand,2,FALSE,segment_bytes,fix_rec->form==POINTER?FAR:NEAR,FALSE,&dummy,DS);
     inst_offset+=fix_size*mult,length-=fix_size;
     if(pass==3){
      strcat(dup_buff,operand);
      strcat(struc_buff,operand);
     }
     BuffEmpty();
    }
     else
    {
     data_size=length;
     if(data_size!=2&&data_size!=4&&data_size!=6&&data_size!=8&&data_size!=10)data_size=1;
     strcat(dup_buff,"0");
     if(depth==1)strcat(struc_buff,"0");
     out_count=0;
     while(out_count<data_size)rev_buff[out_count]=(Byte)buff_regetc(),out_count++;
     out_count=data_size;
     while(out_count){
      --out_count;
      if(depth!=1)if(rev_buff[out_count]!=0)*dup_only=TRUE;
      sprintf(idb_buff,"%02X",rev_buff[out_count]);
      strcat(dup_buff,idb_buff);
      if(depth==1)strcat(struc_buff,idb_buff);
     }
     strcat(dup_buff,"h");
     if(depth==1)strcat(struc_buff,"h");
     length-=data_size,inst_offset+=mult*data_size;
    }
   }
   if(length)strcat(dup_buff,",");
  }
 }
 if(repeat!=1||num_blocks!=0)strcat(dup_buff,")");
 return result;
}

int ProcLabel(){
 char text[50];DWord past_seg;char *size_text;
 size_text=pub_rec->type==FAR?"THIS FAR":"THIS NEAR";
 if(pass==3){
  if(pub_rec->offset>=seg_rec->length){
   past_seg=pub_rec->offset-seg_rec->length;
   if(past_seg==0)strcpy(text,"$");
             else sprintf(text,"$ + 0%04Xh",size_text,past_seg);
   OutLn(pub_rec->name,"=",text,"");
  }
   else
  {
   if(pub_rec->type==FAR)OutLn(pub_rec->name,"Equ","THIS FAR","");
    else
   {
    if(pub_rec->type==NEAR){
     sprintf(text,"%s:",pub_rec->name);
     OutLabel(text);
    }
     else
    OutLabel(pub_rec->name);
   }
  }
 }
 last_pub_rec=pub_rec;
 PubAdvance();
 if(pub_rec->seg_idx==last_pub_rec->seg_idx&&pub_rec->offset==last_pub_rec->offset){
  if(pass==3){
   if(last_pub_rec->type!=NEAR){
    OutDirective("Equ");
    sprintf(text,"%s",size_text);
    OutOperand(text);
   }
   OutEndLn();
  }
  ProcLabel();
 }
 return 0;
}

int ProcNor(int inst_proc){
 int data_size,data,inst_length,zeros,string_limit,dcheck;
 char temp[3];int this_size,data_type,direct;
 LINE_T Line,*pLine;SCOPE_T Scope,*pEndScope,*pArgScope,*pLocScope,*pScope;
 NODE_T*pNode; LOCAL_VAR*pVar;
 data_type=UNKNOWN;
 hint_search.seg_idx=segment,hint_search.offset=inst_offset,direct=RIGHT;
 while(hint_node!=hint_tree&&(direct=hint_compare(&hint_search,hint_rec))==LEFT){
  hint_advance();
  direct=RIGHT;
 }
 if(direct==EQUAL)data_type=hint_rec->hint_type;
 if(data_type==UNKNOWN){
  data_size=0,zeros=TRUE;
  do{
   data=BuffGetC();
   if(data==EOF)break;
   if(data!=0&&data!=0x0A&&data!=0x0D&&data!=0x1B&&(data<' '||data>'~'))break;
   if(data!=0)zeros=FALSE;
   data_size++,inst_offset++,dcheck=data_check(0);
  }while(dcheck==NORMAL||dcheck==BAD);
  string_limit=(inst_proc?code_string:data_string);
  if(data_size>=string_limit||(zeros&&data_size>1)){
   if(last_pub_rec&&last_pub_rec->type>FAR){
    this_size=type_to_size(last_pub_rec->type);
    if(data_size<this_size)last_pub_rec->type=BYTE_PTR;
    DtaByte(this_size);
    buff_reseek();
    inst_offset-=data_size,inst_offset+=this_size,last_pub_rec=NULL;
    return this_size;
   }
    else
   {
    if(last_pub_rec&&pass==3){
     if(last_pub_rec->type==FAR){
      OutDirective("=");
      OutOperand("$");
     }
     if(last_pub_rec->type==NEAR)OutEndLn();
    }
    empty_string(data_size);
    buff_reseek();
    last_pub_rec=NULL;
    return data_size;
   }
  }
  buff_reseek();
  inst_offset-=data_size;
 }
 if(data_type==NEAR||(inst_proc&&data_type==UNKNOWN)){
  data=(Byte)BuffGetC(),hex_finish=TRUE;
  inst_length=(*instr[data].rtn)((Byte)data,instr[data].text,instr[data].special);
  if(inst_length==0)data_type=UNKNOWN;
 }
  else
 inst_length=0;
 if(inst_length){
  if(buff_cur-buff_beg!=inst_length)fmt_error("D‚s-assemblage Interne d'Instruction en cours");
  if(!*hex_comment){
   Line.hex_offset=inst_offset;
   pLine=find(&Line,line_tree,TC linnum_compare,NULL);
   Scope.hex_offset=inst_offset+inst_length;
   if(pass==3){
    pScope=pEndScope=find(&Scope,end_scope_tree,TC scope_compare,&pNode);
    pArgScope=find(&Scope,arg_scope_tree,TC scope_compare,NULL);
    pLocScope=find(&Scope,loc_scope_tree,TC scope_compare,NULL);
    while(pScope&&pEndScope->hex_offset==pScope->hex_offset){
     OutComment("Fin du scope");
     pScope=pNode->ptr[LEFT]->data,pNode=pNode->ptr[LEFT];
    }
    if(pLocScope){
     OutLn("; D‚but du scope (locals)","","","");
     pVar=pLocScope->head;
     while(pVar){out_var(pVar);pVar=pVar->next;}
    }
    if(pArgScope){
     OutLn("; D‚but du scope (arguments)","","","");
     pVar=pArgScope->head;
     while(pVar){out_var(pVar);pVar=pVar->next;}
    }
   }
   if(pLine)sprintf(hex_comment,"[%05d] %04X: ",pLine->line_number,inst_offset);
       else sprintf(hex_comment,"        %04X: ",inst_offset);
  }
  this_size=inst_length;
  while(this_size--){
   sprintf(temp,"%02X",(Byte)buff_regetc());
   strcat(hex_comment,temp);
  }
  if(hex_finish){
   if(pass==3){
    if(hex_output)OutComment(hex_comment);
    OutEndLn();
   }
   *hex_comment=0;
  }
  inst_offset+=inst_length;
  if(last_pub_rec){
   if(last_pub_rec->type!=FAR)last_pub_rec->type=NEAR;
   last_pub_rec=NULL;
  }
  return inst_length;
 }
 AbortAssumes();
 buff_reseek();
 if(last_pub_rec&&last_pub_rec->type>FAR){
  if(last_pub_rec->type==UNKNOWN)last_pub_rec->type=BYTE_PTR;
  if(data_type==UNKNOWN)data_type=last_pub_rec->type;
  last_pub_rec->type=data_type;
 }
  else
 if(data_type==UNKNOWN)data_type=BYTE_PTR;
 data_size=type_to_size(data_type);
 DtaByte(data_size);
 last_pub_rec=NULL,inst_offset+=data_size;
 return data_size;
}

void PubAdvance(){
 pub_node=traverse(pub_node,RIGHT),pub_rec=(PUB_T*)pub_node->data;
}

int PubCmp(PUB_T*rec_1,PUB_T*rec_2){
 if(rec_1->seg_idx>rec_2->seg_idx)return LEFT;
 else{
  if(rec_1->seg_idx<rec_2->seg_idx)return RIGHT;
  else{
   if(rec_1->offset>rec_2->offset)return LEFT;
   else return rec_1->offset<rec_2->offset?RIGHT:EQUAL;
  }
 }
}

void pubdef(Word length,int scope){
 int grp_idx,seg_idx,frame,typ_idx;DWord offset;char pub_name[41];
 length-=get_index(&grp_idx),length-=get_index(&seg_idx);
 if(seg_idx==0)frame=get_word(),length-=2;
 --length;
 while(length){
  length-=get_name(pub_name),offset=(DWord)get_word();
  pub_insert(seg_idx,offset,pub_name,PUBLIC,scope);
  length-=2,length-=get_index(&typ_idx);
 }
 frame=frame;
}

NODE_T*pub_insert(int seg_idx,DWord offset,char*this_name,int domain,int scope){
 PUB_T*public_rec;
 public_rec=(PUB_T*)o_malloc(sizeof(PUB_T)),public_rec->seg_idx=seg_idx;
 public_rec->offset=offset,public_rec->type=UNKNOWN,public_rec->domain=domain;
 public_rec->scope=scope,public_rec->structure=NULL;
 strcpy(public_rec->name,this_name);
 return insert((char*)public_rec,public_tree,TC PubCmp);
}

char*RegFormat(int reg,char*output_string,char*base_text,char*base_fmt,char*extra_fmt){
 if(reg==NREG)sprintf(output_string,base_fmt,base_text);
  else
 {
  if(reg<9)sprintf(output_string,extra_fmt,base_text,regs[0][reg-1]);else{
   if(reg<17){
    if(SizeLarge)sprintf(output_string,extra_fmt,base_text,regs[2][reg-9]);
            else sprintf(output_string,extra_fmt,base_text,regs[1][reg-9]);}
   else sprintf(output_string,extra_fmt,base_text,sregs[reg-17]);
  }
 }
 return output_string;
}

int reg_size_to_type(int RegSize){
 switch(RegSize){
  case 0:return BYTE_PTR;
  case 1:return WORD_PTR;
  case 2:return DWORD_PTR;
  case 3:return FWORD_PTR;
  default:return UNKNOWN;
 }
}

int scope_compare(SCOPE_T*BTS,SCOPE_T*S){
 return BTS->hex_offset>S->hex_offset?LEFT:((BTS->hex_offset<S->hex_offset)?RIGHT:EQUAL);
}

int SegCmp(SEG_T*R1,SEG_T*R2){
 return R1->index>R2->index?LEFT:(R1->index<R2->index?RIGHT:EQUAL);
}

void segdef(){
 NAME_T search,*segment,*class,*overlay;char operands[80];
 Byte acbp=GetByte(),offset; Word length;
 int align=(acbp&0xE0)>>5,combine=(acbp&0x1C)>>2,big=(acbp&2)>>1,page=acbp&1,
     frame,ltl,max_len,grp_off,name_idx,code;
 if(align==0)frame=get_word(),offset=GetByte();
 if(align==6)ltl=GetByte(),max_len=get_word(),grp_off=get_word();
 length=get_word(),operands[0]='\0';
 get_index(&search.index);
 segment=(NAME_T*)find((char*)&search,name_tree,TC NameCmp,NULL);
 if(segment==NULL)fmt_error("Nom de segment ind‚fini");
 name_idx=search.index;
 get_index(&search.index);
 class=(NAME_T*)find((char*)&search,name_tree,TC NameCmp,NULL);
 if(class==NULL)fmt_error("Nom de la classe ind‚fini");
 get_index(&search.index);
 overlay=(NAME_T*)find((char*)&search,name_tree,TC NameCmp,NULL);
 if(overlay==NULL)fmt_error("Nom de recouvrement ind‚fini");
 if(compatibility==0){
  if(!processor_type_comment_occurred){
   OutLn("",".386p","","Active l'usage USE32/USE16");
   OutLn("",".387","","Active l'usage des virgules flottantes");
   OutNewLn();
   processor_type_comment_occurred=TRUE,processor_mode=386;
  }
  if(strlen(class->name)){
   if(processor_mode==386)
    sprintf(operands,"%s %s %s '%s'",al_text[align],cb_text[combine],use_text[page],class->name);
   else
    sprintf(operands,"%s %s '%s'",al_text[align],cb_text[combine],class->name);
  }
   else
  {
   if(processor_mode==386)
    sprintf(operands,"%s %s %s",al_text[align],cb_text[combine],use_text[page]);
   else
    sprintf(operands,"%s %s",al_text[align],cb_text[combine]);
  }
 }
  else
 {
  if(strlen(class->name))
   sprintf(operands,"%s %s '%s'",al_text[align],cb_text[combine],class->name);
  else
   sprintf(operands,"%s %s",al_text[align],cb_text[combine]);
 }
 if(compatibility!=2){
  OutLn(segment->name,"SEGMENT",operands,"");
  OutLn(segment->name,"ENDS","","");
  OutNewLn();
 }
 code=FALSE;
 UpStr(operands,segment->name);
 if(strstr(operands,"CODE"))code=TRUE;
 if(strstr(operands,"DRIVER"))code=TRUE;
 UpStr(operands,class->name);
 if(strstr(operands,"CODE"))code=TRUE;
 if(strstr(operands,"TEXT"))code=TRUE;
 SegIns(name_idx,class,length,page,code);
 big=big,frame=frame,offset=offset,ltl=ltl,max_len=max_len,grp_off=grp_off;
}

void SegIns(int name_idx,NAME_T*class,int length,int bit32,int code){
 static segment_count=0; SEG_T*SegRec;
 segment_count++,SegRec=(SEG_T*)o_malloc(sizeof(SEG_T));
 SegRec->index=segment_count,SegRec->name=name_idx;
 SegRec->class=class,SegRec->length=length,SegRec->code=code,SegRec->bit32=bit32;
 insert((char*)SegRec,segment_tree,TC SegCmp);
}

char*SegName(int index,Word*size){
 SEG_T*SegRec; NAME_T*name_rec;
 seg_search.index=index;
 SegRec=(SEG_T*)find((char*)&seg_search,segment_tree,TC SegCmp,NULL);
 if(SegRec==NULL)fmt_error("Segment ind‚fini");
 *size=SegRec->length;
 name_search.index=SegRec->name;
 name_rec=(NAME_T*)find((char*)&name_search,name_tree,TC NameCmp,NULL);
 if(name_rec==NULL)fmt_error("Nom de segment ind‚fini");
 return(name_rec->name);
}

int seg_over(Byte byte,char*text,int class){
 int valid,save_seg;text=text,class=class,save_seg=over_seg;
 over_seg=(byte>=0x64?4+byte-0x64:(byte&0x18)>>3);
 valid=ChkForward(instr,1);
 if(valid)return(valid+1);
  else
 {
  over_seg=save_seg;
  return 0;
 }
}

int SExCmp(SEX_T*rec_1,SEX_T*rec_2){
 int result;
 if(rec_1->seg_index>rec_2->seg_index)return LEFT;
  else
 {
  if(rec_1->seg_index<rec_2->seg_index)return RIGHT;
   else
  {
   result=strcmp(rec_1->ext_rec->name,rec_2->ext_rec->name);
   return result<0?LEFT:result>0?RIGHT:EQUAL;
  }
 }
}

void sex_insert(int seg_index,EXT_T*ext_rec){
 SEX_T*sex_rec;
 sex_rec=(SEX_T*)o_malloc(sizeof(SEX_T));
 sex_rec->seg_index=seg_index,sex_rec->ext_rec=ext_rec;
 insert((char*)sex_rec,sex_tree,TC SExCmp);
}

char*size_to_opcode(int size,int*times){
 *times=1;
 switch(size){
  case 0:*times=0;return"*ERREUR*";
  case 1:return"DB";
  case 2:return"DW";
  case 4:return"DD";
  case 6:return"DF";
  case 8:return"DQ";
  case 10:return"DT";
  default:*times=size;return"DB";
 }
}

int size_to_type(int size){
 switch(size){
  case 1:return BYTE_PTR;
  case 2:return WORD_PTR;
  case 4:return DWORD_PTR;
  case 6:return FWORD_PTR;
  case 8:return QWORD_PTR;
  case 10:return TBYTE_PTR;
  default:return UNKNOWN;
 }
}

static void SPrnDate(char*string,char*datestr){
 TIME time=*(TIME*)datestr; DATE date=*(DATE*)&datestr[2];
 sprintf(string,"%02d:%02d:%02d du %.3s %d, %04d",time.hour,time.minute,time.seconds,months[date.month],date.day,date.year+1980);
}

NODE_T*start(NODE_T*root_node,int direct){
 NODE_T*curr_node;int con_direct;
 curr_node=root_node->ptr[RIGHT],con_direct=1-direct;
 while(!curr_node->thread[1-direct])curr_node=curr_node->ptr[con_direct];
 return curr_node;
}

int string_byte(Byte byte,char*text,int class){
 char opcode[10],operand[50],*format; int size=byte&1,mode; class=class;
 if(size==1&&SizeLarge)size=2;
 switch(byte){
  case 0xA4:
  case 0xA5:format="%sES:[DI],%s%s[SI]",mode=0;break;
  case 0xA6:
  case 0xA7:format="%sES:[DI],%s%s[SI]",mode=0;break;
  case 0xAA:
  case 0xAB:mode=2;break;
  case 0xAC:
  case 0xAD:format="%s%s[SI]",mode=1;break;
  case 0xAE:
  case 0xAF:
   mode=2;
   break;
 }
 strcpy(opcode,text);
 if(over_seg==-1){
  switch(size){
   case 0:strcat(opcode,"b");break;
   case 1:strcat(opcode,"w");break;
   case 2:strcat(opcode,"d");break;
  }
  InstrOpCode(opcode);
  return 1;
 }else{
  switch(mode){
   case 0:sprintf(operand,format,sz_text[size],sz_text[size],sregsc[over_seg]);break;
   case 1:sprintf(operand,format,sz_text[size],sregsc[over_seg]);break;
   case 2:return 0;
  }
  InstrOpCode(opcode);
  InstrOperand(operand);
  return 1;
 }
}

int StrucCmp(STRUC_T*rec_1,STRUC_T*rec_2){
 int result=strcmp(rec_1->form,rec_2->form);
 if(result==1)result=LEFT;else return (result==0?EQUAL:RIGHT);
 return LEFT;
}

STRUC_T*struc_insert(char*form){
 STRUC_T*struc_rec;NODE_T*struc_node;char*form_copy;int length;
 struc_rec=(STRUC_T*)o_malloc(sizeof(STRUC_T));
 length=strlen(form)+1,form_copy=(char*)o_malloc(length);
 strcpy(form_copy,form);
 struc_rec->form=form_copy,struc_rec->index=0;
 struc_node=insert((char*)struc_rec,struc_tree,TC StrucCmp);
 return(STRUC_T*)struc_node->data;
}

int stub(Byte byte,char*text,int class){byte=byte,text=text,class=class;return 0;}

void Swp(NODE_T*node_A,int direct_A,NODE_T*node_B,int direct_B){
 if(node_A->thread[direct_A])node_B->ptr[direct_B]=node_A,node_B->thread[direct_B]=TRUE,node_A->thread[direct_A]=FALSE;
                        else node_B->ptr[direct_B]=node_A->ptr[direct_A],node_A->ptr[direct_A]=node_B;
}

void TabI(char*text){
 int count=strlen(text);
 while (count){
  if(*text=='\t')col_cnt=(col_cnt|7)+1;else col_cnt++;
  text++,--count;
 }
 tab_at=(col_cnt>>3)+1;
}

void TabNext(){TabSeek(tab_at+1);}

void TabSeek(int TabI){
 if(TabI<=tab_at){
  putc('\n',stdout);
  TabI-=tab_offset,tab_offset=0,tab_at=0,col_cnt=0;
 }
 if(tab_at==0)tab_at=1;
 while(tab_at<TabI){
  putc('\t',stdout);
  tab_at++,col_cnt=(tab_at-1)<<3;
 }
}

void theadr(){
 int length;char mod_name[41],mod_temp[43];
 length=get_name(mod_name),length=length;
 if(compatibility==2){
  sprintf(mod_temp,"'%s'",mod_name);
  OutLn("","TITLE",mod_temp,"");
 }
  else
 OutLn("","TITLE",mod_name,"");
 OutNewLn();
}

int three_a(Byte byte,char*Txt,int class){
 int Dir,RegSize,DataSize,Type,SizeKnown;DWord Ofs;
 char Ln[50],SegTxt[10],Tmp[50],Tmp2[15];int RefSeg;
 DataSize=AddrBytes,Dir=(byte&2)>>1,RegSize=byte&1;
 if(RegSize==1&&SizeLarge)RegSize=2;
 Type=reg_size_to_type(RegSize);
 if(over_seg!=-1){
  RefSeg=17+over_seg;
  strcpy(SegTxt,sregsc[over_seg]);
 }
  else
 RefSeg=DS,SegTxt[0]='\0';
 switch(data_check(1)){
  case BAD:return 0;
  case LABEL:return 0;
  case FIXUP:
   if(fix_rec->word_sized&&fix_rec->extended==AddrLarge)
    get_fix(Tmp,0,FALSE,SizeBytes,Type,TRUE,&SizeKnown,RefSeg);
   else
    return 0;
   strcpy(Ln,"");
   if(compatibility==2){
    strcat(Ln,SegTxt);
    strcat(Ln," ");
    if(!SizeKnown)strcat(Ln,type_to_text(Type));
   }
    else
   {
    if(!SizeKnown)strcat(Ln,type_to_text(Type));
    strcat(Ln,SegTxt);
   }
   strcat(Ln,Tmp);
   break;
  case NORMAL:
   if(ChkGetV(&Ofs,AddrLarge))return 0;
   out_hexize(Ofs,Tmp2,AddrBytes);
   if(compatibility==2)sprintf(Ln,"%s .%s",SegTxt,Tmp2);
    else
   {
    if(over_seg==-1)sprintf(Ln,"DS:[%s]",Tmp2);
               else sprintf(Ln,"%s[%s]",SegTxt,Tmp2);
   }
   break;
 }
 if(Dir==0)sprintf(Tmp,"%s,%s",regs[RegSize][0],Ln);
      else sprintf(Tmp,"%s,%s",Ln,regs[RegSize][0]);
 AdjustAssumes();
 InstrOpCode(Txt);
 InstrOperand(Tmp);
 class=class;
 return 1+DataSize;
}

int three_byte(Byte byte,char*text,int class){
 DWord offset;int dummy,data_size,size_tmp;char line[50],temp[50];
 if(over_seg!=-1)return 0;
 RegFormat(class,line,text,"%s\t","%s\t%s,");
 size_tmp=SizeLarge;
  // <RET jjkk>/<RETF jjkk>
 if(byte==0xC2||byte==0xCA)size_tmp=FALSE,SizeBytes=2;
 data_size=SizeBytes;
 switch(data_check(1)){
  case BAD:return 0;
  case LABEL:return 0;
  case FIXUP:
   if(fix_rec->word_sized&&fix_rec->extended==size_tmp){
    get_fix(temp,2,TRUE,SizeBytes,NEAR,FALSE,&dummy,DS);
    strcat(line,temp);
    AdjustAssumes();
    InstrOpCode(line);
    return(data_size+1);
   }
    else
   return 0;
  case NORMAL:
   if(ChkGetV(&offset,size_tmp))return(0);
   out_hexize(offset,temp,SizeBytes);
   strcat(line,temp);
   InstrOpCode(line);
   return data_size+1;
 }
 return 0;
}

NODE_T*traverse(NODE_T*CurrNode,int Dir){
 int ConDir;
 if(CurrNode->thread[Dir])return CurrNode->ptr[Dir];
  else
 {
  CurrNode=CurrNode->ptr[Dir],ConDir=1-Dir;
  while(!CurrNode->thread[1-Dir])CurrNode=CurrNode->ptr[ConDir];
  return CurrNode;
 }
}

int two_a(Byte byte,char*Txt,int class){
 int Size=byte&0x01;DWord Ofs;char Ln[50];
 if(ChkGetC(&Ofs))return 0;
 sprintf(Ln,Size==0?"0%02lXh,AL":"0%02lXh,AX",Ofs);
 InstrOpCode(Txt);
 InstrOperand(Ln);
 byte=byte,class=class;
 return 2;
}

int two_bcd(Byte byte,char*Txt,int class){
 DWord Ofs; byte=byte,class=class;
 if(ChkGetC(&Ofs))return 0;
 if(Ofs==0x0AL){InstrOpCode(Txt);return 2;}else return 0;
}

int two_byte(Byte byte,char*Txt,int class){
 DWord Ofs;char Ln[50],Tmp[50];
 if(GetChkC(&Ofs))return 0;
 RegFormat(class,Ln,Txt,"%s\t","%s\t%s,");
 out_hexize(Ofs,Tmp,1);
 strcat(Ln,Tmp);
 InstrOpCode(Ln);
 byte=byte;
 return 2;
}

int two_ubyte(Byte byte,char*Txt,int class){
 DWord Ofs; char line[50];
 if(GetChkC(&Ofs))return 0;
 if(Ofs<=127L)sprintf(line,"%s+0%02lXh",Txt,Ofs);
         else sprintf(line,"%s-0%02lXh",Txt,0x0100L-Ofs);
 InstrOpCode(line);
 byte=byte,class=class;
 return(2);
}

int type_to_size(int Type){
 switch(Type){
  case BYTE_PTR:return 1;
  case WORD_PTR:return 2;
  case DWORD_PTR:return 4;
  case FWORD_PTR:return 6;
  case QWORD_PTR:return 8;
  case TBYTE_PTR:return 10;
  default:return 0;
 }
}

char *type_to_text(int Type){
 switch(Type){
  case BYTE_PTR:return"Byte Ptr ";
  case WORD_PTR:return"Word Ptr ";
  case DWORD_PTR:return"DWord Ptr ";
  case FWORD_PTR:return"FWord Ptr ";
  case QWORD_PTR:return"QWord Ptr ";
  case TBYTE_PTR:return"TByte Ptr ";
  default:return"";
 }
}

void UpStr(char *Dest,char *Source){
 char ch;
 while((ch=*Source)!='\0')*Dest++=(char)toupper(ch),Source++;
 *Dest='\0';
}

int wait(Byte byte,char *Txt,int class){
 byte=byte,class=class,fp_opcode[0]='\0';
 if(!ChkForward(instr,0))InstrOpCode(Txt);else
 if(strlen(fp_opcode)==0)InstrOpCode(Txt);else fp_wait=TRUE, hex_finish=FALSE;
 return 1;
}

int WordImm(char *Txt,int Add){
 int DChk=data_check(Add+2),dummy; DWord Ofs;
 switch(DChk){
  case LABEL:return 1;
  case FIXUP:
   if(fix_rec->word_sized&&fix_rec->extended==AddrLarge)
    get_fix(Txt,2,TRUE,SizeBytes,NEAR,FALSE,&dummy,DS);
   else
    return 1;
   break;
  case BAD:return 1;
  case NORMAL:
   if(ChkGetV(&Ofs,SizeLarge))return 1;
   out_hexize(Ofs,Txt,SizeLarge?4:2);
   break;
 }
 return 0;
}