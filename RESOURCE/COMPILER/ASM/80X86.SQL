CREATE TABLE Instr80x86 (
   BaseSize   BYTE,
   AsmName    VARCHAR,
   PascalName VARCHAR,
   CName      VARCHAR,
   AsmName66h VARCHAR,
   AsmName0Fh VARCHAR
);

CREATE INDEX;

INSERT INTO Instr80x86 VALUES (0x02,'ADD',      '',             '',                         '',         '');        // [00h] ADD mem/reg,regbyte
INSERT INTO Instr80x86 VALUES (0x02,'ADD',      '',             '',                         '',         '');        // [01h] ADD
INSERT INTO Instr80x86 VALUES (0x02,'ADD',      '',             '',                         '',         '');        // [02h] ADD
INSERT INTO Instr80x86 VALUES (0x02,'ADD',      '',             '',                         '',         '');        // [03h] ADD
INSERT INTO Instr80x86 VALUES (0x02,'ADD',      '',             '',                         '',         '');        // [04h] ADD AL,kk
INSERT INTO Instr80x86 VALUES (0x03,'ADD',      '',             '',                         '',         '');        // [05h] ADD AX,jjkk
INSERT INTO Instr80x86 VALUES (0x01,'',         '',             '',                         '',         'CLTS');    // [06h] PUSH ES
INSERT INTO Instr80x86 VALUES (0x01,'',         '',             '',                         '',         'LOADALL'); // [07h] POP ES
INSERT INTO Instr80x86 VALUES (0x02,'OR',       '',             '',                         '',         'WBINVD');  // [08h] OR
INSERT INTO Instr80x86 VALUES (0x02,'OR',       '',             '',                         '',         'INVD');    // [09h] OR
INSERT INTO Instr80x86 VALUES (0x02,'OR',       '',             '',                         '',         '');        // [0Ah] OR
INSERT INTO Instr80x86 VALUES (0x02,'OR',       '',             '',                         '',         '');        // [0Bh] OR
INSERT INTO Instr80x86 VALUES (0x02,'OR',       '',             '',                         '',         '');        // [0Ch] OR AL,kk
INSERT INTO Instr80x86 VALUES (0x03,'OR',       '',             '',                         '',         '');        // [0Dh] OR AX,jjkk
INSERT INTO Instr80x86 VALUES (0x01,'',         '',             '',                         '',         '');        // [0Eh] PUSH CS
INSERT INTO Instr80x86 VALUES (0x01,'',         '',             '',                         '',         '');        // [0Fh] Inutilis‚
INSERT INTO Instr80x86 VALUES (0x02,'ADC',      '',             '',                         '',         '');        // [10h] ADC
INSERT INTO Instr80x86 VALUES (0x02,'ADC',      '',             '',                         '',         '');        // [11h] ADC
INSERT INTO Instr80x86 VALUES (0x02,'ADC',      '',             '',                         '',         '');        // [12h] ADC
INSERT INTO Instr80x86 VALUES (0x02,'ADC',      '',             '',                         '',         '');        // [13h] ADC
INSERT INTO Instr80x86 VALUES (0x02,'ADC',      '',             '',                         '',         '');        // [14h] ADC AL,kk
INSERT INTO Instr80x86 VALUES (0x03,'ADC',      '',             '',                         '',         '');        // [15h] ADC AX,jjkk
INSERT INTO Instr80x86 VALUES (0x01,'',         '',             '',                         '',         '');        // [16h] PUSH SS
INSERT INTO Instr80x86 VALUES (0x01,'',         '',             '',                         '',         '');        // [17h] POP SS
INSERT INTO Instr80x86 VALUES (0x02,'SBB',      '',             '',                         '',         '');        // [18h] SBB
INSERT INTO Instr80x86 VALUES (0x02,'SBB',      '',             '',                         '',         '');        // [19h] SBB
INSERT INTO Instr80x86 VALUES (0x02,'SBB',      '',             '',                         '',         '');        // [1Ah] SBB
INSERT INTO Instr80x86 VALUES (0x02,'SBB',      '',             '',                         '',         '');        // [1Bh] SBB
INSERT INTO Instr80x86 VALUES (0x02,'SBB',      '',             '',                         '',         '');        // [1Ch] SBB AL,kk
INSERT INTO Instr80x86 VALUES (0x03,'SBB',      '',             '',                         '',         '');        // [1Dh] SBB AX,jjkk
INSERT INTO Instr80x86 VALUES (0x01,'',         '',             '',                         '',         '');        // [1Eh] PUSH DS
INSERT INTO Instr80x86 VALUES (0x01,'',         '',             '',                         '',         '');        // [1Fh] POP DS
INSERT INTO Instr80x86 VALUES (0x02,'AND',      '',             '',                         '',         '');        // [20h] AND
INSERT INTO Instr80x86 VALUES (0x02,'AND',      '',             '',                         '',         '');        // [21h] AND
INSERT INTO Instr80x86 VALUES (0x02,'AND',      '',             '',                         '',         '');        // [22h] AND
INSERT INTO Instr80x86 VALUES (0x02,'AND',      '',             '',                         '',         '');        // [23h] AND
INSERT INTO Instr80x86 VALUES (0x02,'AND',      '',             '',                         '',         '');        // [24h] AND AL,kk
INSERT INTO Instr80x86 VALUES (0x03,'AND',      '',             '',                         '',         '');        // [25h] AND AX,jjkk
INSERT INTO Instr80x86 VALUES (0x01,'',         '',             '',                         '',         '');        // [26h] ES:
INSERT INTO Instr80x86 VALUES (0x01,'DAA',      '',             '',                         '',         '');        // [27h] DAA
INSERT INTO Instr80x86 VALUES (0x02,'SUB',      '',             '',                         '',         '');        // [28h] SUB
INSERT INTO Instr80x86 VALUES (0x02,'SUB',      '',             '',                         '',         '');        // [29h] SUB
INSERT INTO Instr80x86 VALUES (0x02,'SUB',      '',             '',                         '',         '');        // [2Ah] SUB
INSERT INTO Instr80x86 VALUES (0x02,'SUB',      '',             '',                         '',         '');        // [2Bh] SUB
INSERT INTO Instr80x86 VALUES (0x02,'SUB',      '',             '',                         '',         '');        // [2Ch] SUB AL,kk
INSERT INTO Instr80x86 VALUES (0x03,'SUB',      '',             '',                         '',         '');        // [2Dh] SUB AX,jjkk
INSERT INTO Instr80x86 VALUES (0x01,'',         '',             '',                         '',         '');        // [2Eh] CS:
INSERT INTO Instr80x86 VALUES (0x01,'DAS',      '',             '',                         '',         '');        // [2Fh] DAS
INSERT INTO Instr80x86 VALUES (0x02,'XOR',      '',             '',                         '',         'WRMSR');   // [30h] XOR
INSERT INTO Instr80x86 VALUES (0x02,'XOR',      '',             '',                         '',         'RDTSC');   // [31h] XOR
INSERT INTO Instr80x86 VALUES (0x02,'XOR',      '',             '',                         '',         'RDMSR');   // [32h] XOR
INSERT INTO Instr80x86 VALUES (0x02,'XOR',      '',             '',                         '',         'RDPMC');   // [33h] XOR
INSERT INTO Instr80x86 VALUES (0x02,'XOR',      '',             '',                         '',         '');        // [34h] XOR AL,kk
INSERT INTO Instr80x86 VALUES (0x03,'XOR',      '',             '',                         '',         '');        // [35h] XOR AX,jjkk
INSERT INTO Instr80x86 VALUES (0x01,'',         '',             '',                         '',         '');        // [36h] SS:
INSERT INTO Instr80x86 VALUES (0x01,'AAA',      '',             '',                         '',         '');        // [37h] AAA
INSERT INTO Instr80x86 VALUES (0x02,'CMP',      '',             '',                         '',         '');        // [38h] CMP
INSERT INTO Instr80x86 VALUES (0x02,'CMP',      '',             '',                         '',         '');        // [39h] CMP
INSERT INTO Instr80x86 VALUES (0x02,'CMP',      '',             '',                         '',         '');        // [3Ah] CMP
INSERT INTO Instr80x86 VALUES (0x02,'CMP',      '',             '',                         '',         '');        // [3Bh] CMP
INSERT INTO Instr80x86 VALUES (0x02,'CMP',      '',             '',                         '',         '');        // [3Ch] CMP AL,kk
INSERT INTO Instr80x86 VALUES (0x03,'CMP',      '',             '',                         '',         '');        // [3Dh] CMP AX,jjkk
INSERT INTO Instr80x86 VALUES (0x01,'',         '',             '',                         '',         '');        // [3Eh] DS:
INSERT INTO Instr80x86 VALUES (0x01,'AAS',      '',             '',                         '',         '');        // [3Fh] AAS
INSERT INTO Instr80x86 VALUES (0x01,'',         '',             '',                         '',         '');        // [40h] INC AX
INSERT INTO Instr80x86 VALUES (0x01,'',         '',             '',                         '',         '');        // [41h] INC CX
INSERT INTO Instr80x86 VALUES (0x01,'',         '',             '',                         '',         '');        // [42h] INC DX
INSERT INTO Instr80x86 VALUES (0x01,'',         '',             '',                         '',         '');        // [43h] INC BX
INSERT INTO Instr80x86 VALUES (0x01,'',         '',             '',                         '',         '');        // [44h] INC SP
INSERT INTO Instr80x86 VALUES (0x01,'',         '',             '',                         '',         '');        // [45h] INC BP
INSERT INTO Instr80x86 VALUES (0x01,'',         '',             '',                         '',         '');        // [46h] INC SI
INSERT INTO Instr80x86 VALUES (0x01,'',         '',             '',                         '',         '');        // [47h] INC DI
INSERT INTO Instr80x86 VALUES (0x01,'',         '',             '',                         '',         '');        // [48h] DEC AX
INSERT INTO Instr80x86 VALUES (0x01,'',         '',             '',                         '',         '');        // [49h] DEC CX
INSERT INTO Instr80x86 VALUES (0x01,'',         '',             '',                         '',         '');        // [4Ah] DEC DX
INSERT INTO Instr80x86 VALUES (0x01,'',         '',             '',                         '',         '');        // [4Bh] DEC BX
INSERT INTO Instr80x86 VALUES (0x01,'',         '',             '',                         '',         '');        // [4Ch] DEC SP
INSERT INTO Instr80x86 VALUES (0x01,'',         '',             '',                         '',         '');        // [4Dh] DEC BP
INSERT INTO Instr80x86 VALUES (0x01,'',         '',             '',                         '',         '');        // [4Eh] DEC SI
INSERT INTO Instr80x86 VALUES (0x01,'',         '',             '',                         '',         '');        // [4Fh] DEC DI
INSERT INTO Instr80x86 VALUES (0x01,'',         '',             '',                         '',         '');        // [50h] PUSH AX
INSERT INTO Instr80x86 VALUES (0x01,'',         '',             '',                         '',         '');        // [51h] PUSH CX
INSERT INTO Instr80x86 VALUES (0x01,'',         '',             '',                         '',         '');        // [52h] PUSH DX
INSERT INTO Instr80x86 VALUES (0x01,'',         '',             '',                         '',         '');        // [53h] PUSH BX
INSERT INTO Instr80x86 VALUES (0x01,'',         '',             '',                         '',         '');        // [54h] PUSH SP
INSERT INTO Instr80x86 VALUES (0x01,'',         '',             '',                         '',         '');        // [55h] PUSH BP
INSERT INTO Instr80x86 VALUES (0x01,'',         '',             '',                         '',         '');        // [56h] PUSH SI
INSERT INTO Instr80x86 VALUES (0x01,'',         '',             '',                         '',         '');        // [57h] PUSH DI
INSERT INTO Instr80x86 VALUES (0x01,'',         '',             '',                         '',         '');        // [58h] POP AX
INSERT INTO Instr80x86 VALUES (0x01,'',         '',             '',                         '',         '');        // [59h] POP CX
INSERT INTO Instr80x86 VALUES (0x01,'',         '',             '',                         '',         '');        // [5Ah] POP DX
INSERT INTO Instr80x86 VALUES (0x01,'',         '',             '',                         '',         '');        // [5Bh] POP BX
INSERT INTO Instr80x86 VALUES (0x01,'',         '',             '',                         '',         '');        // [5Ch] POP SP
INSERT INTO Instr80x86 VALUES (0x01,'',         '',             '',                         '',         '');        // [5Dh] POP BP
INSERT INTO Instr80x86 VALUES (0x01,'',         '',             '',                         '',         '');        // [5Eh] POP SI
INSERT INTO Instr80x86 VALUES (0x01,'',         '',             '',                         '',         '');        // [5Fh] POP DI
INSERT INTO Instr80x86 VALUES (0x01,'PUSHA',    '',             '',                         'PUSHAD',   '');        // [60h] PUSHA
INSERT INTO Instr80x86 VALUES (0x01,'POPA',     '',             '',                         'POPAD',    '');        // [61h] POPA
INSERT INTO Instr80x86 VALUES (0x01,'',         '',             '',                         '',         '');        // [62h] BOUND
INSERT INTO Instr80x86 VALUES (0x01,'',         '',             '',                         '',         '');        // [63h] ARPL
INSERT INTO Instr80x86 VALUES (0x01,'',         '',             '',                         '',         '');        // [64h] FS:
INSERT INTO Instr80x86 VALUES (0x01,'',         '',             '',                         '',         '');        // [65h] GS:
INSERT INTO Instr80x86 VALUES (0x01,'',         '',             '',                         '',         '');        // [66h] 386...
INSERT INTO Instr80x86 VALUES (0x01,'',         '',             '',                         '',         '');        // [67h] 386...
INSERT INTO Instr80x86 VALUES (0x03,'',         '',             '',                         '',         '');        // [68h] PUSH Immediat Word
INSERT INTO Instr80x86 VALUES (0x01,'',         '',             '',                         '',         '');        // [69h] IMUL
INSERT INTO Instr80x86 VALUES (0x02,'',         '',             '',                         '',         '');        // [6Ah] PUSH Immediat Byte
INSERT INTO Instr80x86 VALUES (0x01,'',         '',             '',                         '',         '');        // [6Bh] IMUL
INSERT INTO Instr80x86 VALUES (0x01,'INSB',     '',             '',                         '',         '');        // [6Ch] INSB
INSERT INTO Instr80x86 VALUES (0x01,'INSW',     '',             '',                         'INSD',     '');        // [6Dh] INSW
INSERT INTO Instr80x86 VALUES (0x01,'OUTSB',    '',             '',                         '',         '');        // [6Eh] OUTSB
INSERT INTO Instr80x86 VALUES (0x01,'OUTSW',    '',             '',                         'OUTSD',    '');        // [6Fh] OUTSW
INSERT INTO Instr80x86 VALUES (0x02,'',         '',             '',                         '',         '');        // [70h]
INSERT INTO Instr80x86 VALUES (0x02,'',         '',             '',                         '',         '');        // [71h]
INSERT INTO Instr80x86 VALUES (0x02,'',         '',             '',                         '',         '');        // [72h]
INSERT INTO Instr80x86 VALUES (0x02,'',         '',             '',                         '',         '');        // [73h]
INSERT INTO Instr80x86 VALUES (0x02,'',         '',             '',                         '',         '');        // [74h]
INSERT INTO Instr80x86 VALUES (0x02,'',         '',             '',                         '',         '');        // [75h]
INSERT INTO Instr80x86 VALUES (0x02,'',         '',             '',                         '',         '');        // [76h]
INSERT INTO Instr80x86 VALUES (0x02,'',         '',             '',                         '',         'EMMS');    // [77h]
INSERT INTO Instr80x86 VALUES (0x02,'',         '',             '',                         '',         '');        // [78h]
INSERT INTO Instr80x86 VALUES (0x02,'',         '',             '',                         '',         '');        // [79h]
INSERT INTO Instr80x86 VALUES (0x02,'',         '',             '',                         '',         '');        // [7Ah]
INSERT INTO Instr80x86 VALUES (0x02,'',         '',             '',                         '',         '');        // [7Bh]
INSERT INTO Instr80x86 VALUES (0x02,'',         '',             '',                         '',         '');        // [7Ch]
INSERT INTO Instr80x86 VALUES (0x02,'',         '',             '',                         '',         '');        // [7Dh]
INSERT INTO Instr80x86 VALUES (0x02,'',         '',             '',                         '',         '');        // [7Eh]
INSERT INTO Instr80x86 VALUES (0x02,'',         '',             '',                         '',         '');        // [7Fh]
INSERT INTO Instr80x86 VALUES (0x01,'',         '',             '',                         '',         '');        // [80h]
INSERT INTO Instr80x86 VALUES (0x01,'',         '',             '',                         '',         '');        // [81h]
INSERT INTO Instr80x86 VALUES (0x01,'',         '',             '',                         '',         '');        // [82h]
INSERT INTO Instr80x86 VALUES (0x01,'',         '',             '',                         '',         '');        // [83h]
INSERT INTO Instr80x86 VALUES (0x02,'',         '',             '',                         '',         '');        // [84h] TEST
INSERT INTO Instr80x86 VALUES (0x02,'',         '',             '',                         '',         '');        // [85h] TEST
INSERT INTO Instr80x86 VALUES (0x02,'',         '',             '',                         '',         '');        // [86h] XCHG
INSERT INTO Instr80x86 VALUES (0x02,'',         '',             '',                         '',         '');        // [87h] XCHG
INSERT INTO Instr80x86 VALUES (0x02,'MOV',      '',             '',                         '',         '');        // [88h] MOV
INSERT INTO Instr80x86 VALUES (0x02,'MOV',      '',             '',                         '',         '');        // [89h] MOV
INSERT INTO Instr80x86 VALUES (0x02,'MOV',      '',             '',                         '',         '');        // [8Ah] MOV
INSERT INTO Instr80x86 VALUES (0x02,'MOV',      '',             '',                         '',         '');        // [8Bh] MOV
INSERT INTO Instr80x86 VALUES (0x02,'',         '',             '',                         '',         '');        // [8Ch] MOV [],ES
INSERT INTO Instr80x86 VALUES (0x01,'',         '',             '',                         '',         '');        // [8Dh]
INSERT INTO Instr80x86 VALUES (0x02,'',         '',             '',                         '',         '');        // [8Eh]
INSERT INTO Instr80x86 VALUES (0x01,'',         '',             '',                         '',         '');        // [8Fh]
INSERT INTO Instr80x86 VALUES (0x01,'NOP',      '',             '',                         '',         '');        // [90h]
INSERT INTO Instr80x86 VALUES (0x01,'',         '',             '',                         '',         '');        // [91h]
INSERT INTO Instr80x86 VALUES (0x01,'',         '',             '',                         '',         '');        // [92h]
INSERT INTO Instr80x86 VALUES (0x01,'',         '',             '',                         '',         '');        // [93h]
INSERT INTO Instr80x86 VALUES (0x01,'',         '',             '',                         '',         '');        // [94h]
INSERT INTO Instr80x86 VALUES (0x01,'',         '',             '',                         '',         '');        // [95h]
INSERT INTO Instr80x86 VALUES (0x01,'',         '',             '',                         '',         '');        // [96h]
INSERT INTO Instr80x86 VALUES (0x01,'',         '',             '',                         '',         '');        // [97h]
INSERT INTO Instr80x86 VALUES (0x01,'CBW',      '',             '',                         'CDWE',     '');        // [98h]
INSERT INTO Instr80x86 VALUES (0x01,'CWD',      '',             '',                         'CDQ',      '');        // [99h]
INSERT INTO Instr80x86 VALUES (0x05,'',         '',             '',                         '',         '');        // [9Ah] CALL FAR iijj:kkll
INSERT INTO Instr80x86 VALUES (0x01,'WAIT',     '',             '',                         '',         '');        // [9Bh]
INSERT INTO Instr80x86 VALUES (0x01,'PUSHF',    '',             '',                         'PUSHFD',   '');        // [9Ch]
INSERT INTO Instr80x86 VALUES (0x01,'POPF',     '',             '',                         'POPFD',    '');        // [9Dh]
INSERT INTO Instr80x86 VALUES (0x01,'SAHF',     '',             '',                         '',         '');        // [9Eh]
INSERT INTO Instr80x86 VALUES (0x01,'LAHF',     'AH:=Flags',    '_AH=_Flags',               '',         '');        // [9Fh]
INSERT INTO Instr80x86 VALUES (0x03,'',         '',             '',                         '',         'PUSH FS'); // [A0h]
INSERT INTO Instr80x86 VALUES (0x03,'',         '',             '',                         '',         'POP FS');  // [A1h]
INSERT INTO Instr80x86 VALUES (0x03,'',         '',             '',                         '',         'CPUID');   // [A2h] MOV [iijj],AL
INSERT INTO Instr80x86 VALUES (0x03,'',         '',             '',                         '',         '');        // [A3h]
INSERT INTO Instr80x86 VALUES (0x01,'MOVSB',    '',             '',                         '',         '');        // [A4h] MOVSB
INSERT INTO Instr80x86 VALUES (0x01,'MOVSW',    '',             '',                         'MOVSD',    '');        // [A5h] MOVSW
INSERT INTO Instr80x86 VALUES (0x01,'CMPSB',    '',             '',                         '',         '');        // [A6h] CMPSB
INSERT INTO Instr80x86 VALUES (0x01,'CMPSD',    '',             '',                         'CMPSD',    '');        // [A7h] CMPSW
INSERT INTO Instr80x86 VALUES (0x02,'',         '',             '',                         '',         'PUSH GS'); // [A8h] TEST AL,ii
INSERT INTO Instr80x86 VALUES (0x03,'',         '',             '',                         '',         'POP GS');  // [A9h] TEST AX,iijj
INSERT INTO Instr80x86 VALUES (0x01,'STOSB',    '',             '',                         '',         'RSM');     // [AAh] STOSB
INSERT INTO Instr80x86 VALUES (0x01,'STOSW',    '',             '',                         'STOSD',    '');        // [ABh] STOSW
INSERT INTO Instr80x86 VALUES (0x01,'LODSB',    '',             '',                         '',         '');        // [ACh] LODSB
INSERT INTO Instr80x86 VALUES (0x01,'LODSW',    '',             '',                         'LODSD',    '');        // [ADh] LODSW
INSERT INTO Instr80x86 VALUES (0x01,'SCASB',    '',             '',                         '',         '');        // [AEh] SCASB
INSERT INTO Instr80x86 VALUES (0x01,'SCASW',    '',             '',                         'SCASD',    '');        // [AFh] SCASW
INSERT INTO Instr80x86 VALUES (0x02,'',         '',             '',                         '',         '');        // [B0h]
INSERT INTO Instr80x86 VALUES (0x02,'',         '',             '',                         '',         '');        // [B1h]
INSERT INTO Instr80x86 VALUES (0x02,'',         '',             '',                         '',         '');        // [B2h]
INSERT INTO Instr80x86 VALUES (0x02,'',         '',             '',                         '',         '');        // [B3h]
INSERT INTO Instr80x86 VALUES (0x02,'',         '',             '',                         '',         '');        // [B4h]
INSERT INTO Instr80x86 VALUES (0x02,'',         '',             '',                         '',         '');        // [B5h]
INSERT INTO Instr80x86 VALUES (0x02,'',         '',             '',                         '',         '');        // [B6h]
INSERT INTO Instr80x86 VALUES (0x02,'',         '',             '',                         '',         '');        // [B7h]
INSERT INTO Instr80x86 VALUES (0x03,'',         '',             '',                         '',         '');        // [B8h] MOV AX,jjkk
INSERT INTO Instr80x86 VALUES (0x03,'',         '',             '',                         '',         '');        // [B9h] MOV CX,jjkk
INSERT INTO Instr80x86 VALUES (0x03,'',         '',             '',                         '',         '');        // [BAh] MOV DX,jjkk
INSERT INTO Instr80x86 VALUES (0x03,'',         '',             '',                         '',         '');        // [BBh] MOV BX,jjkk
INSERT INTO Instr80x86 VALUES (0x03,'',         '',             '',                         '',         '');        // [BCh] MOV SP,jjkk
INSERT INTO Instr80x86 VALUES (0x03,'',         '',             '',                         '',         '');        // [BDh] MOV BP,jjkk
INSERT INTO Instr80x86 VALUES (0x03,'',         '',             '',                         '',         '');        // [BEh] MOV SI,jjkk
INSERT INTO Instr80x86 VALUES (0x03,'',         '',             '',                         '',         '');        // [BFh] MOV DI,jjkk
INSERT INTO Instr80x86 VALUES (0x01,'',         '',             '',                         '',         '');        // [C0h]
INSERT INTO Instr80x86 VALUES (0x01,'',         '',             '',                         '',         '');        // [C1h]
INSERT INTO Instr80x86 VALUES (0x03,'RETN ',    '',             '',                         '',         '');        // [C2h] RETN iijj
INSERT INTO Instr80x86 VALUES (0x01,'RETN',     '{ Near } Exit','/* near */ return',        '',         '');        // [C3h] RETN
INSERT INTO Instr80x86 VALUES (0x02,'',         '',             '',                         '',         '');        // [C4h] LES
INSERT INTO Instr80x86 VALUES (0x02,'',         '',             '',                         '',         '');        // [C5h] LDS
INSERT INTO Instr80x86 VALUES (0x01,'',         '',             '',                         '',         '');        // [C6h] MOV
INSERT INTO Instr80x86 VALUES (0x01,'',         '',             '',                         '',         '');        // [C7h] MOV
INSERT INTO Instr80x86 VALUES (0x04,'ENTER ',   '',             '',                         '',         '');        // [C8h] ENTER
INSERT INTO Instr80x86 VALUES (0x01,'LEAVE',    '',             '',                         '',         '');        // [C9h]
INSERT INTO Instr80x86 VALUES (0x03,'RETF ',    '',             '',                         '',         '');        // [CAh]
INSERT INTO Instr80x86 VALUES (0x01,'RETF',     '{ FAR } Exit', '/* far */ return',         '',         '');        // [CBh]
INSERT INTO Instr80x86 VALUES (0x01,'INT 03h',  'Intr($03)',    'geninterrupt(0x03)',       '',         '');        // [CCh]
INSERT INTO Instr80x86 VALUES (0x02,'INT ',     'Intr(',        'geninterrupt(',            '',         '');        // [CDh]
INSERT INTO Instr80x86 VALUES (0x01,'INTO',     '',             '',                         '',         '');        // [CEh]
INSERT INTO Instr80x86 VALUES (0x01,'IRET',     '',             '',                         'IRETD',    '');        // [CFh]
INSERT INTO Instr80x86 VALUES (0x01,'',         '',             '',                         '',         '');        // [D0h]
INSERT INTO Instr80x86 VALUES (0x01,'',         '',             '',                         '',         '');        // [D1h]
INSERT INTO Instr80x86 VALUES (0x01,'',         '',             '',                         '',         '');        // [D2h]
INSERT INTO Instr80x86 VALUES (0x01,'',         '',             '',                         '',         '');        // [D3h]
INSERT INTO Instr80x86 VALUES (0x02,'AAM',      '',             '',                         '',         '');        // [D4h]
INSERT INTO Instr80x86 VALUES (0x02,'AAD',      '',             '',                         '',         '');        // [D5h] AAD,...
INSERT INTO Instr80x86 VALUES (0x01,'SETALC',   'AL:=CF*255',   '_AL:=(_Flags&0x0001)*0xFF','',         '');        // [D6h]
INSERT INTO Instr80x86 VALUES (0x01,'XLAT',     '',             '',                         '',         '');        // [D7h]
INSERT INTO Instr80x86 VALUES (0x01,'',         '',             '',                         '',         '');        // [D8h]
INSERT INTO Instr80x86 VALUES (0x02,'',         '',             '',                         '',         '');        // [D9h] Float...
INSERT INTO Instr80x86 VALUES (0x01,'',         '',             '',                         '',         '');        // [DAh]
INSERT INTO Instr80x86 VALUES (0x02,'',         '',             '',                         '',         '');        // [DBh] Float...
INSERT INTO Instr80x86 VALUES (0x01,'',         '',             '',                         '',         '');        // [DCh]
INSERT INTO Instr80x86 VALUES (0x01,'',         '',             '',                         '',         '');        // [DDh]
INSERT INTO Instr80x86 VALUES (0x01,'',         '',             '',                         '',         '');        // [DEh]
INSERT INTO Instr80x86 VALUES (0x01,'',         '',             '',                         '',         '');        // [DFh]
INSERT INTO Instr80x86 VALUES (0x02,'LOOPNZ',   '',             '',                         '',         '');        // [E0h] LOOPNZ ii
INSERT INTO Instr80x86 VALUES (0x02,'LOOPZ',    '',             '',                         '',         '');        // [E1h] LOOPZ ii
INSERT INTO Instr80x86 VALUES (0x02,'LOOP',     '',             '',                         '',         '');        // [E2h] LOOP ii
INSERT INTO Instr80x86 VALUES (0x02,'JCXZ',     'If CX=0Then Goto','if(_CX==0) goto',       'JECXZ',    '');        // [E3h] JCXZ ii
INSERT INTO Instr80x86 VALUES (0x02,'IN',       '',             '',                         '',         '');        // [E4h] IN AL,ii
INSERT INTO Instr80x86 VALUES (0x02,'IN',       '',             '',                         '',         '');        // [E5h] IN AX,ii
INSERT INTO Instr80x86 VALUES (0x02,'OUT',      '',             '',                         '',         '');        // [E6h] OUT AL,ii
INSERT INTO Instr80x86 VALUES (0x02,'OUT',      '',             '',                         '',         '');        // [E7h] OUT AX,ii
INSERT INTO Instr80x86 VALUES (0x03,'CALL ',    '',             '',                         '',         '');        // [E8h] CALL $+jjkk
INSERT INTO Instr80x86 VALUES (0x03,'JMP',      'Goto',         'goto',                     '',         '');        // [E9h] JMP $+jjkk
INSERT INTO Instr80x86 VALUES (0x05,'JMP FAR',  'Goto',         'goto',                     '',         '');        // [EAh] JMP FAR iijj:kkll
INSERT INTO Instr80x86 VALUES (0x02,'JMP',      'Goto',         'goto',                     '',         '');        // [EBh] JMP ii
INSERT INTO Instr80x86 VALUES (0x01,'IN AL,DX', 'AL:=Port[DX]', '_AL=inportb(_DX)',         '',         '');        // [ECh]
INSERT INTO Instr80x86 VALUES (0x01,'IN AX,DX', 'AX:=Port[DX]', '_AX=inport(_DX)',          'IN EAX,DX','');        // [EDh]
INSERT INTO Instr80x86 VALUES (0x01,'OUT DX,AL','Port[DX]:=AL', 'outportb(_DX,_AL)',        '',         '');        // [EEh]
INSERT INTO Instr80x86 VALUES (0x01,'OUT DX,',  '',             '',                         '',         '');        // [EFh]
INSERT INTO Instr80x86 VALUES (0x01,'',         '',             '',                         '',         '');        // [F0h] LOCK ?
INSERT INTO Instr80x86 VALUES (0x01,'',         '',             '',                         '',         '');        // [F1h]
INSERT INTO Instr80x86 VALUES (0x01,'',         '',             '',                         '',         '');        // [F2h]
INSERT INTO Instr80x86 VALUES (0x01,'',         '',             '',                         '',         '');        // [F3h]
INSERT INTO Instr80x86 VALUES (0x01,'HLT'       '',             '',                         '',         '');        // [F4h]
INSERT INTO Instr80x86 VALUES (0x01,'CMC',      'CF:=Not CF',   '',                         '',         '');        // [F5h]
INSERT INTO Instr80x86 VALUES (0x01,'',         '',             '',                         '',         '');        // [F6h]
INSERT INTO Instr80x86 VALUES (0x01,'',         '',             '',                         '',         '');        // [F7h]
INSERT INTO Instr80x86 VALUES (0x01,'CLC',      'CF:=False',    '_Flags|=0xFFFE',           '',         '');        // [F8h] CLC
INSERT INTO Instr80x86 VALUES (0x01,'STC',      'CF:=True',     '_Flags|=0x0001',           '',         '');        // [F9h]
INSERT INTO Instr80x86 VALUES (0x01,'CLI',      'IF:=False',    '_Flags|=0xFDFF',           '',         '');        // [FAh]
INSERT INTO Instr80x86 VALUES (0x01,'STI',      'IF:=True',     '_Flags|=0x0200',           '',         '');        // [FBh]
INSERT INTO Instr80x86 VALUES (0x01,'CLD',      'DF:=False',    '_Flags|=0xFBFF',           '',         '');        // [FCh]
INSERT INTO Instr80x86 VALUES (0x01,'STD',      'DF:=True',     '_Flags|=0x0400',           '',         '');        // [FDh]
INSERT INTO Instr80x86 VALUES (0x01,'',         '',             '',                         '',         '');        // [FEh]
INSERT INTO Instr80x86 VALUES (0x01,'',         '',             '',                         '',         '');        // [FFh]
