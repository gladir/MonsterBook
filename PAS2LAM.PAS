Unit Pas2LAM;

INTERFACE

Uses Systex;

Function Pascal2Lam(Const Path:String):Int;

IMPLEMENTATION

Uses Systems,Lamtex;

Const
 psAbsolute={$IFDEF FRENCHCODE}'ABSOLUE'{$ELSE}'ABSOLUTE'{$ENDIF};
 psAnd={$IFDEF FRENCHCODE}'ET'{$ELSE}'AND'{$ENDIF};
 psArray={$IFDEF FRENCHCODE}'RANGE'{$ELSE}'ARRAY'{$ENDIF};
 psASM={$IFDEF FRENCHCODE}'ASM'{$ELSE}'ASM'{$ENDIF};
 psAssembler={$IFDEF FRENCHCODE}'ASSEMBLEUR'{$ELSE}'ASSEMBLER'{$ENDIF};
 psBegin={$IFDEF FRENCHCODE}'DBUT'{$ELSE}'BEGIN'{$ENDIF};
 psBoolean={$IFDEF FRENCHCODE}'BOOLEN'{$ELSE}'BOOLEAN'{$ENDIF};
 psByte={$IFDEF FRENCHCODE}'OCTET'{$ELSE}'BYTE'{$ENDIF};
 psCase={$IFDEF FRENCHCODE}'CAS'{$ELSE}'CASE'{$ENDIF};
 psChar={$IFDEF FRENCHCODE}'CAR'{$ELSE}'CHAR'{$ENDIF};
 psConst={$IFDEF FRENCHCODE}'CONST'{$ELSE}'CONST'{$ENDIF};
 psConstructor={$IFDEF FRENCHCODE}'CONSTRUCTEUR'{$ELSE}'CONSTRUCTOR'{$ENDIF};
 psCString={$IFDEF FRENCHCODE}'CHAINEC'{$ELSE}'CSTRING'{$ENDIF};
 psDestructor={$IFDEF FRENCHCODE}'DESTRUCTEUR'{$ELSE}'DESTRUCTOR'{$ENDIF};
 psDiv={$IFDEF FRENCHCODE}'DIV'{$ELSE}'DIV'{$ENDIF};
 psDo={$IFDEF FRENCHCODE}'FAIT'{$ELSE}'DO'{$ENDIF};
 psDownTo={$IFDEF FRENCHCODE}'ABAISSERA'{$ELSE}'DOWNTO'{$ENDIF};
 psElse={$IFDEF FRENCHCODE}'SINON'{$ELSE}'ELSE'{$ENDIF};
 psEnd={$IFDEF FRENCHCODE}'FIN'{$ELSE}'END'{$ENDIF};
 psExit={$IFDEF FRENCHCODE}'SORTIR'{$ELSE}'EXIT'{$ENDIF};
 psExport={$IFDEF FRENCHCODE}'EXPORTE'{$ELSE}'EXPORT'{$ENDIF};
 psExports={$IFDEF FRENCHCODE}'EXPORTES'{$ELSE}'EXPORTS'{$ENDIF};
 psExternal={$IFDEF FRENCHCODE}'EXTERNE'{$ELSE}'EXTERNAL'{$ENDIF};
 psFalse={$IFDEF FRENCHCODE}'FAUX'{$ELSE}'FALSE'{$ENDIF};
 psFar={$IFDEF FRENCHCODE}'LOIN'{$ELSE}'FAR'{$ENDIF};
 psFile={$IFDEF FRENCHCODE}'FICHIER'{$ELSE}'FILE'{$ENDIF};
 psFor={$IFDEF FRENCHCODE}'POUR'{$ELSE}'FOR'{$ENDIF};
 psFunc={$IFDEF FRENCHCODE}'FONCTION'{$ELSE}'FUNCTION'{$ENDIF};
 psGoto={$IFDEF FRENCHCODE}'ALLERA'{$ELSE}'GOTO'{$ENDIF};
 psIf={$IFDEF FRENCHCODE}'SI'{$ELSE}'IF'{$ENDIF};
 psImplementation={$IFDEF FRENCHCODE}'IMPLMENTATION'{$ELSE}'IMPLEMENTATION'{$ENDIF};
 psIn={$IFDEF FRENCHCODE}'DANS'{$ELSE}'IN'{$ENDIF};
 psInherited={$IFDEF FRENCHCODE}'HRITIER'{$ELSE}'INHERITED'{$ENDIF};
 psInline={$IFDEF FRENCHCODE}'ENLIGNE'{$ELSE}'INLINE'{$ENDIF};
 psInput={$IFDEF FRENCHCODE}'ENTRE'{$ELSE}'INPUT'{$ENDIF};
 psInterface={$IFDEF FRENCHCODE}'INTERFACE'{$ELSE}'INTERFACE'{$ENDIF};
 psInteger={$IFDEF FRENCHCODE}'ENTIER'{$ELSE}'INTEGER'{$ENDIF};
 psLabel={$IFDEF FRENCHCODE}'TIQUETTE'{$ELSE}'LABEL'{$ENDIF};
 psLibrary={$IFDEF FRENCHCODE}'BIBLIOTHEQUE'{$ELSE}'LIBRARY'{$ENDIF};
 psLongInt={$IFDEF FRENCHCODE}'ENTLONG'{$ELSE}'LONGINT'{$ENDIF};
 psMem={$IFDEF FRENCHCODE}'MM'{$ELSE}'MEM'{$ENDIF};
 psMemW={$IFDEF FRENCHCODE}'MMM'{$ELSE}'MEMW'{$ENDIF};
 psMemL={$IFDEF FRENCHCODE}'MML'{$ELSE}'MEML'{$ENDIF};
 psMod={$IFDEF FRENCHCODE}'MOD'{$ELSE}'MOD'{$ENDIF};
 psNear={$IFDEF FRENCHCODE}'PROCHE'{$ELSE}'NEAR'{$ENDIF};
 psNil={$IFDEF FRENCHCODE}'NIL'{$ELSE}'NIL'{$ENDIF};
 psNot={$IFDEF FRENCHCODE}'NG'{$ELSE}'NOT'{$ENDIF};
 psObject={$IFDEF FRENCHCODE}'OBJET'{$ELSE}'OBJECT'{$ENDIF};
 psOf={$IFDEF FRENCHCODE}'DE'{$ELSE}'OF'{$ENDIF};
 psOr={$IFDEF FRENCHCODE}'OU'{$ELSE}'OR'{$ENDIF};
 psOutput={$IFDEF FRENCHCODE}'SORTIE'{$ELSE}'OUTPUT'{$ENDIF};
 psPacked={$IFDEF FRENCHCODE}'PAQUET'{$ELSE}'PACKED'{$ENDIF};
 psPointer={$IFDEF FRENCHCODE}'POINTER'{$ELSE}'POINTEUR'{$ENDIF};
 psPort={$IFDEF FRENCHCODE}'PORT'{$ELSE}'PORT'{$ENDIF};
 psPortW={$IFDEF FRENCHCODE}'PORTM'{$ELSE}'PORTW'{$ENDIF};
 psPrivate={$IFDEF FRENCHCODE}'PRIVE'{$ELSE}'PRIVATE'{$ENDIF};
 psProgram={$IFDEF FRENCHCODE}'PROGRAMME'{$ELSE}'PROGRAM'{$ENDIF};
 psProc={$IFDEF FRENCHCODE}'PROCDURE'{$ELSE}'PROCEDURE'{$ENDIF};
 psRandom={$IFDEF FRENCHCODE}'HASARD'{$ELSE}'RANDOM'{$ENDIF};
 psReal={$IFDEF FRENCHCODE}'REL'{$ELSE}'REAL'{$ENDIF};
 psRecord={$IFDEF FRENCHCODE}'ENREGISTREMENT'{$ELSE}'RECORD'{$ENDIF};
 psRepeat={$IFDEF FRENCHCODE}'FAIRE'{$ELSE}'REPEAT'{$ENDIF};
 psSet={$IFDEF FRENCHCODE}'ENSEMBLE'{$ELSE}'SET'{$ENDIF};
 psShl={$IFDEF FRENCHCODE}'DCALG'{$ELSE}'SHL'{$ENDIF};
 psShr={$IFDEF FRENCHCODE}'DCALD'{$ELSE}'SHR'{$ENDIF};
 psShortInt={$IFDEF FRENCHCODE}'ENTCOURT'{$ELSE}'SHORTINT'{$ENDIF};
 psString={$IFDEF FRENCHCODE}'CHAINE'{$ELSE}'STRING'{$ENDIF};
 psThen={$IFDEF FRENCHCODE}'ALORS'{$ELSE}'THEN'{$ENDIF};
 psTo={$IFDEF FRENCHCODE}'A'{$ELSE}'TO'{$ENDIF};
 psTrue={$IFDEF FRENCHCODE}'VRAI'{$ELSE}'TRUE'{$ENDIF};
 psType={$IFDEF FRENCHCODE}'TYPE'{$ELSE}'TYPE'{$ENDIF};
 psUnit={$IFDEF FRENCHCODE}'UNIT'{$ELSE}'UNIT'{$ENDIF};
 psUntil={$IFDEF FRENCHCODE}'TANTQUE'{$ELSE}'UNTIL'{$ENDIF};
 psUses={$IFDEF FRENCHCODE}'UTILISES'{$ELSE}'USES'{$ENDIF};
 psVar={$IFDEF FRENCHCODE}'VAR'{$ELSE}'VAR'{$ENDIF};
 psVirtual={$IFDEF FRENCHCODE}'VIRTUEL'{$ELSE}'VIRTUAL'{$ENDIF};
 psWhile={$IFDEF FRENCHCODE}'TANTQUE'{$ELSE}'WHILE'{$ENDIF};
 psWith={$IFDEF FRENCHCODE}'AVEC'{$ELSE}'WITH'{$ENDIF};
 psWord={$IFDEF FRENCHCODE}'MOT'{$ELSE}'WORD'{$ENDIF};
 psWrite={$IFDEF FRENCHCODE}'CRIRE'{$ELSE}'WRITE'{$ENDIF};
 psWriteLn={$IFDEF FRENCHCODE}'CRITLN'{$ELSE}'WRITELN'{$ENDIF};
 psXor={$IFDEF FRENCHCODE}'OUEX'{$ELSE}'XOR'{$ENDIF};
  {Indicateur de d‚but}
 lamEnd=$0;                   {Marqueur de fin}
 lamRem=$1;                   {Remarque(s) du compilateur (voir rem???)}
 lamDeb=$2;                   {Information de d‚boguage:            X:BYTE;Y:WORD}
 lamLongDeb=$3;               {Information de d‚boguage:            X:BYTE;Y:LONG}
 lamProc=$4;                  {Indicateur de Proc‚dure:             ASCIIZ}
 lamFuncBool=$5;              {Fonction ?:VRAI|FAUX                 ASCIIZ}
 lamFuncByte=$6;              {Fonction ?:0 … 255:                  ASCIIZ}
 lamFuncShortByte=$7;         {Fonction ?:-128 … 127:               ASCIIZ}
 lamFuncChar=$8;              {Fonction ?:CaractŠre                 ASCIIZ}
 lamFuncUntypedByte=$9;       {Fonction ?:CaractŠre|0 … 255:        ASCIIZ}
 lamFuncUntypedShortByte=$A;  {Fonction ?:CaractŠre|-128 … 127:     ASCIIZ}
 lamFuncInteger=$B;           {Fonction ?:-32768 … 32767:           ASCIIZ}
 lamFuncUntypedInt=$C;        {Fonction ?:CaractŠre|-32768 … 32767: ASCIIZ}
 lamFuncWord=$D;              {Fonction ?:0 … 65535:                ASCIIZ}
 lamFuncUntypedWord=$E;       {Fonction ?:CaractŠre|0 … 65535:      ASCIIZ}
 lamFuncPointerFar=$F;        {Fonction ?:PointerFar:               ASCIIZ}
 lamFuncLongInt=$10;          {Fonction ?:LongInt:                  ASCIIZ}
 lamFuncDWord=$11;            {Fonction ?:LongWord:                 ASCIIZ}
 lamFuncQWord=$12;            {Fonction ?:QuadrupleMot              ASCIIZ}
 lamFuncQInt=$13;             {Fonction ?:QuadrupleEntier           ASCIIZ}
 lamConstBool=$14;            {Constante VRAI|FAUX:                 BYTE;ASCIIZ}
 lamLetEqual=$15;             {Variable=                            ASCIIZ}
 lamAsm=$16;                  {Instruction Assembleur (voir asm???)}
  {Commence par ®lamRem¯ et suivit par un de ces codes:}
 remCompilerName=$0;          {Nom du compilateur:                  ASCIIZ}
 remCompilerVer=$1;           {Version du compilateur:              Ver:WORD;Sub:WORD}
 remCompilerCopyright=$2;     {Droits d'auteur du compilateur:      ASCIIZ}
 remProgram=$3;               {Nom du programme compiler:           ASCIIZ}
  {Commence par ®lamAsm¯ et suivit par un de ces codes:}
 asmAAA=$01;                  {Famille 86: AAA}
 asmAAD=$02;                  {Famille 86: AAD}
 asmABA=$03;                  {6800: ABA}
 asmAAM=$04;                  {Famille 86: AAM}
 asmAAS=$05;                  {Famille 86: AAS}
 asmACI=$06;                  {8080: ACI (Addition Immediate to A with carry)}
 asmADC=$07;                  {6502, 6800, 8080 & Famille 86: ADC (Addition & Carry)}
 asmADD=$08;                  {6800, 8080 & Famille 86: ADD (Addition)}
 asmADI=$09;                  {8080: ADI (Addition immediat with A)}
 asmANA=$0A;                  {8080: ANA (AND memory with A)}
 asmAND=$0B;                  {6502 & Famille 86: AND}
 asmANI=$0C;                  {8080: ANI}
 asmASL=$0D;                  {6502 & 6800: ASL (Shift Left One Bit Memory of Accumulator)}
 asmASR=$0E;                  {6800: ASR}
 asmBCC=$0F;                  {6502 & 6800: BCC (Branch on Carry Clear)}
 asmBCS=$10;                  {6502 & 6800: BCS (Branch on Carry Set)}
 asmBEQ=$11;                  {6502 & 6800: BEQ {Branch on Result Zero)}
 asmBHI=$12;                  {6800: BHI}
 asmBIT=$13;                  {6502 & 6800: BIT (Test Bits in Memory with Accumulator)}
 asmBLE=$14;                  {6800: BLE}
 asmBLS=$15;                  {6800: BLS}
 asmBMI=$16;                  {6502 & 6800: Branch on Result Minus)}
 asmBNE=$17;                  {6502 & 6800: Branch on Result Not Zero}
 asmBPL=$18;                  {6502 & 6800: Branch on Result Plus}
 asmBRA=$19;                  {6800: BRA}
 asmBRK=$1A;                  {6502: Force Break}
 asmBSF=$1B;                  {386+: BSF}
 asmBSR=$1C;                  {6800: BSR}
 asmBSWAP=$1D;                {486+: BSWAP}
 asmBT=$1E;                   {386+: BT}
 asmBTC=$1F;                  {386+: BTC}
 asmBTR=$20;                  {386+: BTR}
 asmBTS=$21;                  {386+: BTS}
 asmBVC=$22;                  {6502 & 6800: BVC (Branch On Overflow Clear)}
 asmBVS=$23;                  {6800: BVS}
 asmCALL=$24;                 {8080 & Famille 86: CALL}
 asmCBA=$25;                  {6800: CBA}
 asmCBW=$26;                  {Famille 86: CBW}
 asmCC=$27;                   {8080: CC (Call on carry)}
 asmCDQ=$28;                  {Famille 86: CDQ}
 asmCLC=$29;                  {6502, 6800 & Famille 86: CLC (Clear Carry)}
 asmCLD=$2A;                  {6502 & Famille 86: CLD (Clear Decimal Flag/Clear Direction Flag)}
 asmCLI=$2B;                  {6502, 6800 & Famille 86: CLI (Clear Interrupt Disable Bit)}
 asmCLR=$2C;                  {6800: CLR}
 asmCLV=$2D;                  {6502 & 6800: CLV (Clear Overflow Flag))}
 asmCM=$2E;                   {8080: CM (Call on minus)}
 asmCMA=$2F;                  {8080: CMA (Compliment A)}
 asmCMC=$30;                  {8080 & Famille 86: CMC (Compliment Carry)}
 asmCMP=$31;                  {6502, 6800, 8080 & Famille 86: CMP (Compare)}
 asmCMPS=$32;                 {Famille 86: CMPS}
 asmCMPSB=$33;                {Famille 86: CMPSB}
 asmCMPSD=$34;                {386+: CMPSD}
 asmCMPSW=$35;                {Famille 86: CMPSW}
 asmCMPXCHG=$36;              {486+: CMPXCHG}
 asmCNC=$37;                  {8080: CNC (Call on no carry)}
 asmCNZ=$38;                  {8080: CNZ (Call on no zero)}
 asmCOM=$39;                  {6800: COM}
 asmCP=$3A;                   {8080: CP (Call on positive)}
 asmCPE=$3B;                  {8080: CPE (Call on parity even)}
 asmCPI=$3C;                  {8080: CPI (Call immediate with A)}
 asmCPO=$3D;                  {8080: CPO (Call on parity odd)}
 asmCPX=$3E;                  {6502 & 6800: Compare Memory and Index X}
 asmCPY=$3F;                  {6502: Compare Memory and Index Y}
 asmCWD=$40;                  {Famille 86: CWD}
 asmCWDE=$41;                 {386+: CWDE}
 asmCZ=$42;                   {8080: CZ (Call on zero)}
 asmDAA=$43;                  {6800, 8080 & Famille 86: DAA (Decimal adjust A)}
 asmDAD=$44;                  {8080: DAD (Addition)}
 asmDAS=$45;                  {Famille 86: DAS}
 asmDCR=$46;                  {8080: DCR (Decrement)}
 asmDCX=$47;                  {8080: DCX (Decrement ?X)}
 asmDEC=$48;                  {6502, 6800 & Famille 86: DEC (Decrement)}
 asmDES=$49;                  {6800: DES}
 asmDEX=$4A;                  {6502, 6800: DEX (Decrement Index X by One)}
 asmDEY=$4B;                  {6502: DEY (Decrement Index Y by One)}
 asmDI=$4C;                   {8080: DI (Disable Interruption)}
 asmDIV=$4D;                  {Famille 86: DIV}
 asmEI=$4E;                   {8080: EI (Enable Interruption)}
 asmENTER=$4F;                {Famille 86: ENTER}
 asmEOR=$50;                  {6502 & 6800: "Exclusive-Or" Memory with accumulator}
 asmESC=$51;                  {Famille 86: ESC}
 asmF2XM=$52;                 {Famille MPU 87: F2XM}
 asmFABS=$53;                 {Famille MPU 87: FABS}
 asmFADD=$54;                 {Famille MPU 87: FADD}
 asmFADDC=$55;                {Famille MPU 87: FADDC}
 asmFBLD=$56;                 {Famille MPU 87: FBLD}
 asmFBSTP=$57;                {Famille MPU 87: FBSTP}
 asmFCHS=$58;                 {Famille MPU 87: FCHS}
 asmFCLEX=$59;                {Famille MPU 87: FCLEX}
 asmFCOM=$5A;                 {Famille MPU 87: FCOM}
 asmFCOMP=$5B;                {Famille MPU 87: FCOMP}
 asmFCOMPP=$5C;               {Famille MPU 87: FCOMPP}
 asmFCOS=$5D;                 {Famille MPU 87: FCOS}
 asmFDECSTP=$5E;              {Famille MPU 87: FDECSTP}
 asmFDISI=$5F;                {Famille MPU 87: FDISI}
 asmFDIV=$60;                 {Famille MPU 87: FDIV}
 asmFDIVP=$61;                {Famille MPU 87: FDIVP}
 asmFDIVR=$62;                {Famille MPU 87: FDIVR}
 asmFDIVRP=$63;               {Famille MPU 87: FDIVRP}
 asmFENI=$64;                 {Famille MPU 87: FENI}
 asmFFREE=$65;                {Famille MPU 87: FFREE}
 asmFIADD=$66;                {Famille MPU 87: FIADD}
 asmFICOM=$67;                {Famille MPU 87: FICOM}
 asmFICOMP=$68;               {Famille MPU 87: FICOMP}
 asmFIDIV=$69;                {Famille MPU 87: FIDIV}
 asmFIDIVR=$6A;               {Famille MPU 87: FIDIVR}
 asmFILD=$6B;                 {Famille MPU 87: FILD}
 asmFIMUL=$6C;                {Famille MPU 87: FIMUL}
 asmFINCSTP=$6D;              {Famille MPU 87: FINCSTP}
 asmFINIT=$6E;                {Famille MPU 87: FINIT}
 asmFISTP=$6F;                {Famille MPU 87: FISTP}
 asmFISUB=$70;                {Famille MPU 87: FISUB}
 asmFISUBR=$71;               {Famille MPU 87: FISUBR}
 asmFLD=$72;                  {Famille MPU 87: FLD}
 asmFLD1=$73;                 {Famille MPU 87: FLD1}
 asmFLDCW=$74;                {Famille MPU 87: FLDCW}
 asmFLDENV=$75;               {Famille MPU 87: FLDENV}
 asmFLDL2E=$76;               {Famille MPU 87: FLDL2E}
 asmFLDL2T=$77;               {Famille MPU 87: FLDL2T}
 asmFLDLG2=$78;               {Famille MPU 87: FLDLG2}
 asmFLDLN2=$79;               {Famille MPU 87: FLDLN2}
 asmFLDPI=$7A;                {Famille MPU 87: FLDPI}
 asmFLDZ=$7B;                 {Famille MPU 87: FLDZ}
 asmFMUL=$7C;                 {Famille MPU 87: FMUL}
 asmFMULP=$7D;                {Famille MPU 87: FMULP}
 asmFNCLEX=$7E;               {Famille MPU 87: FNCLEX}
 asmFNDISI=$7F;               {Famille MPU 87: FNDISI}
 asmFNENI=$80;                {Famille MPU 87: FNENI}
 asmFNINIT=$81;               {Famille MPU 87: FNINIT}
 asmFNOP=$82;                 {Famille MPU 87: FNOP}
 asmFNSAVE=$83;               {Famille MPU 87: FNSAVE}
 asmFNSTCW=$84;               {Famille MPU 87: FNSTCW}
 asmFPATAN=$85;               {Famille MPU 87: FPATAN}
 asmFPREM=$86;                {Famille MPU 87: FPREM}
 asmFPTAN=$87;                {Famille MPU 87: FPTAN}
 asmFRNDINT=$88;              {Famille MPU 87: FRNDINT}
 asmFRSTOR=$89;               {Famille MPU 87: FRSTOR}
 asmFSAVE=$8A;                {Famille MPU 87: FSAVE}
 asmFSCALE=$8B;               {Famille MPU 87: FSCALE}
 asmFSETPM=$8C;               {MPU 287+: FSETPM}
 asmFSIN=$8D;                 {Famille MPU 87: FSIN}
 asmFSINCOS=$8E;              {Famille MPU 87: FSINCOS}
 asmFSQRT=$8F;                {Famille MPU 87: FSQRT}
 asmFST=$90;                  {Famille MPU 87: FST}
 asmFSTCW=$91;                {Famille MPU 87: FSTCW}
 asmFSTENV=$92;               {Famille MPU 87: FSTENV}
 asmFSTP=$93;                 {Famille MPU 87: FSTP}
 asmFSTSW=$94;                {Famille MPU 87: FSTSW}
 asmFSUB=$95;                 {Famille MPU 87: FSUB}
 asmFSUBPP=$96;               {Famille MPU 87: FSUBPP}
 asmFSUBR=$97;                {Famille MPU 87: FSUBR}
 asmFSUBRP=$98;               {Famille MPU 87: FSUBRP}
 asmFTST=$99;                 {Famille MPU 87: FTST}
 asmFWAIT=$9A;                {Famille MPU 87: FWAIT}
 asmFXAM=$9B;                 {Famille MPU 87: FXAM}
 asmFXCH=$9C;                 {Famille MPU 87: FXCH}
 asmFXTRACT=$9D;              {Famille MPU 87: FXTRACT}
 asmFYL2X=$9E;                {Famille MPU 87: FYL2X}
 asmFYL2XP1=$9F;              {Famille MPU 87: FYl2XP1}
 asmHLT=$A0;                  {8080 & Famille 86: HLT (Halt)}
 asmIDIV=$A1;                 {Famille 86: IDIV}
 asmIMUL=$A2;                 {Famille 86: IMUL}
 asmIN=$A3;                   {8080 & Famille 86: IN (Input) }
 asmINC=$A4;                  {6502, 6800 & Famille 86: INC (Increment)}
 asmINR=$A5;                  {8080: INR (Increment)}
 asmINS=$A6;                  {6800 & Famille 86: INS}
 asmINSB=$A7;                 {Famille 86: INSB}
 asmINSD=$A8;                 {Famille 86: INSD}
 asmINSW=$A9;                 {Famille 86: INSW}
 asmINT=$AA;                  {Famille 86: INT}
 asmINTO=$AB;                 {Famille 86: INTO}
 asmINX=$AC;                  {6502, 6800 & 8080: INX (Increment/Increment Index X by One)}
 asmINY=$AD;                  {6502: INY (Incremnet Index Y by One)}
 asmIRET=$AE;                 {Famille 86: IRET}
 asmJA=$AF;                   {Famille 86: JA}
 asmJAE=$B0;                  {Famille 86: JAE}
 asmJB=$B1;                   {Famille 86: JB}
 asmJBE=$B2;                  {Famille 86: JBE}
 asmJC=asmJB;                 {8080 & Famille 86: JC (Jump on carry)}
 asmJE=$B3;                   {Famille 86: JE}
 asmJG=$B4;                   {Famille 86: JG}
 asmJGE=$B5;                  {Famille 86: JGE}
 asmJL=$B6;                   {Famille 86: JL}
 asmJLE=$B7;                  {Famille 86: JLE}
 asmJM=$B8;                   {8080: JM (Jump on minus)}
 asmJMP=$B9;                  {6502, 6800, 8080 & Famille 86: JMP (Jump unconditionnel)}
 asmJNA=asmJBE;               {Famille 86: JNA}
 asmJNAE=asmJB;               {Famille 86: JNAE}
 asmJNB=asmJAE;               {Famille 86: JNB}
 asmJNBE=asmJA;               {Famille 86: JNBE}
 asmJNC=asmJAE;               {8080 & Famille 86: JNC (Jump on no carry)}
 asmJNE=$BA;                  {Famille 86: JNE}
 asmJNG=asmJLE;               {Famille 86: JNG}
 asmJNGE=asmJL;               {Famille 86: JNGE}
 asmJNL=asmJGE;               {Famille 86: JNL}
 asmJNLE=asmJG;               {Famille 86: JNLE}
 asmJNO=$BB;                  {Famille 86: JNO}
 asmJNP=$BC;                  {Famille 86: JNP}
 asmJNS=$BD;                  {Famille 86: JNS}
 asmJNZ=asmJNE;               {8080 & Famille 86: JNZ (Jump on no zero)}
 asmJO=$BE;                   {Famille 86: JO}
 asmJP=$BF;                   {8080 & Famille 86: JP (Jump on parity)}
 asmJPE=$C0;                  {8080 & Famille 86: JPE (Jump on parity even)}
 asmJPO=$C1;                  {Famille 86: JPO}
 asmJS=$C2;                   {Famille 86: JS}
 asmJSR=$C3;                  {6502, 6800: JSR (Jump to New Location Saving Return Address)}
 asmJZ=asmJE;                 {8080 & Famille 86: JZ (Jump on zero)}
 asmLAHF=$C4;                 {Famille 86: LAHF}
 asmLAR=$C5;                  {Famille 86: LAR}
 asmLDA=$C6;                  {6502, 6800 & 8080: LDA (Load Accumulator with Memory/Load A direct)}
 asmLDAX=$C7;                 {8080: LDAX (Load A indirect) }
 asmLDS=$C8;                  {Famille 86: LDS}
 asmLDX=$C9;                  {6502 & 6800: LDX (Load Index X with Memory)}
 asmLDY=$CA;                  {6502: LDY (Load Index Y with Memory)}
 asmLEA=$CB;                  {Famille 86: LEA}
 asmLEAVE=$CC;                {Famille 86: LEAVE}
 asmLES=$CD;                  {Famille 86: LES}
 asmLFS=$CE;                  {386+: LFS}
 asmLGS=$CF;                  {386+: LGS}
 asmLHLD=$D0;                 {8080: LHLD (Load H & L direct)}
 asmLOCK=$D1;                 {Famille 86: LOCK}
 asmLODS=$D2;                 {Famille 86: LODS}
 asmLODSB=$D3;                {Famille 86: LODSB}
 asmLODSD=$D4;                {386+: LODSD}
 asmLODSW=$D5;                {Famille 86: LODSW}
 asmLOOP=$D6;                 {Famille 86: LOOP}
 asmLOOPE=$D7;                {Famille 86: LOOPE}
 asmLOOPNE=$D8;               {Famille 86: LOOPNE}
 asmLOOPNZ=asmLOOPNE;         {Famille 86: LOOPNZ}
 asmLOOPZ=asmLOOPE;           {Famille 86: LOOPZ}
 asmLSR=$D9;                  {6502 & 6800: LSR (Shift Right One bit Memory or Accumulator)}
 asmLXI=$DA;                  {8080: LXI (Load immediate register Pair)}
 asmMOV=$DB;                  {8080 & Famille 86: MOV (Move)}
 asmMOVS=$DC;                 {Famille 86: MOVS}
 asmMOVSB=$DD;                {Famille 86: MOVSB}
 asmMOVSD=$DE;                {386+: MOVSD}
 asmMOVSW=$DF;                {Famille 86: MOVSW}
 asmMUL=$E0;                  {Famille 86: MUL}
 asmMVI=$E1;                  {8080: MVI (Move immediate)}
 asmNEG=$E2;                  {6800 & Famille 86: NEG}
 asmNOP=$E3;                  {6502, 6800, 8080 & Famille 86: NOP (No Operation)}
 asmNOT=$E4;                  {Famille 86: NOT}
 asmOR=$E5;                   {Famille 86: OR}
 asmORA=$E6;                  {6502, 6800 & 8080: ORA (Or memory with A(ccumulator))}
 asmORI=$E7;                  {8080: ORI (Or register with A)}
 asmOUT=$E8;                  {8080 & Famille 86: OUT (Output)}
 asmOUTS=$E9;                 {Famille 86: OUTS}
 asmOUTSB=$EA;                {286+: OUTSB}
 asmOUTSD=$EB;                {386+: OUTSD}
 asmOUTSW=$EC;                {286+: OUTSW}
 asmPCHL=$ED;                 {8080: PCHL (H & L to program counter)}
 asmPHA=$EE;                  {6502: PHA (Push Accumalator on Stack)}
 asmPHP=$EF;                  {6502: PHP (Push Processor Status on Stack)}
  { F0h ??h: ÄÄÄ Code Double ÄÄÄ }
 asmPLA=$00;                  {6502: PLA (Pull Accumulator on Stack)}
 asmPLP=$01;                  {6502: PLP (Pull Processor on Stack)}
 asmPOP=$02;                  {8080 & Famille 86: POP}
 asmPOPA=$03;                 {286+: POPA}
 asmPOPAD=$04;                {386+: POPAD}
 asmPSH=$05;                  {6800: PSH}
 asmPUL=$06;                  {6800: PUL}
 asmPUSH=$07;                 {8080 & Famille 86: PUSH}
 asmPUSHA=$08;                {286+: PUSHA}
 asmPUSHAD=$09;               {386+: PUSHAD}
 asmPUSHF=$0A;                {Famille 86: PUSHF}
 asmRAL=$0B;                  {8080: RAL (Rotate A left troug carry)}
 asmRAR=$0C;                  {8080: RAR (Rotate A righe troug carry)}
 asmRC=$0D;                   {8080: RC (Return on carry)}
 asmRCL=$0E;                  {Famille 86: RCL}
 asmRCR=$0F;                  {Famille 86: RCR}
 asmREP=$10;                  {Famille 86: REP}
 asmREPE=$11;                 {Famille 86: REPE}
 asmREPNE=$12;                {Famille 86: REPNE}
 asmREPNZ=$13;                {Famille 86: REPNZ}
 asmRET=$14;                  {8080 & Famille 86: RET (Return)}
 asmRETF=$15;                 {Famille 86: RETF}
 asmRETN=$16;                 {Famille 86: RETN}
 asmRM=$17;                   {8080: RM (Return on minus)}
 asmRNC=$18;                  {8080: RNC (Return on no carry)}
 asmRNZ=$19;                  {8080: RNZ (Return on no zero)}
 asmROL=$1A;                  {6502, 6800 & Famille 86: ROL (Rotate 1 Bit Left)}
 asmROR=$1B;                  {6502, 6800 & Famille 86: ROR (Rotate 1 Bit Right)}
 asmRP=$1C;                   {8080: RP (Return on positive)}
 asmRPE=$1D;                  {8080: RPE (Return on parity even)}
 asmRPO=$1E;                  {8080: RPO (Return on parity odd)}
 asmRRC=$1F;                  {8080: RRC (Rotate A right)}
 asmRST=$20;                  {8080: RST (Restart)}
 asmRTI=$21;                  {6502 & 6800: RTI (Return from Interrupt)}
 asmRTS=$22;                  {6502 & 6800: RTS (Retour from subroutine)}
 asmRZ=$23;                   {8080: RZ (Return on zero)}
 asmSAHF=$24;                 {Famille 86: SAHF}
 asmSAL=$25;                  {Famille 86: SAL}
 asmSAR=$26;                  {Famille 86: SAR}
 asmSBA=$27;                  {6800: SBA}
 asmSBB=$28;                  {8080 & Famille 86: SBB (Subtract with borrow)}
 asmSBC=$29;                  {6502 & 6800: SBC (Subtract Memory from Accumulator with borrow)}
 asmSBI=$2A;                  {8080: SBI (Subtract immediate from A with borrow)}
 asmSCAS=$2B;                 {Famille 86: SCAS}
 asmSCASB=$2C;                {Famille 86: SCASB}
 asmSCASD=$2D;                {386+: SCASD}
 asmSCASW=$2E;                {Famille 86: SCASW}
 asmSEC=$2F;                  {6502 & 6800: SEC (Set Carry Flag)}
 asmSED=$30;                  {6502: SED (Set Decimal Mode)}
 asmSEI=$31;                  {6502 & 6800: SEI (Set Interrupt Enable Status)}
 asmSETA=$32;                 {386+: SETA}
 asmSETAE=$33;                {386+: SETAE}
 asmSETALC=$34;               {Famille 86 INTEL: SETALC (Set AL equal Carry)}
 asmSETB=$35;                 {386+: SETB}
 asmSETBE=$36;                {386+: SETBE}
 asmSETC=asmSETB;             {386+: SETC}
 asmSETE=$37;                 {386+: SETE}
 asmSETG=$38;                 {386+: SETG}
 asmSETGE=$39;                {386+: SETGE}
 asmSETL=$3A;                 {386+: SETL}
 asmSETLE=$3B;                {386+: SETLE}
 asmSETNA=asmSETBE;           {386+: SETNA}
 asmSETNAE=asmSETB;           {386+: SETNAE}
 asmSETNB=asmSETAE;           {386+: SETNB}
 asmSETNC=asmSETAE;           {386+: SETNC}
 asmSETNE=$3C;                {386+: SETNE}
 asmSETNG=asmSETLE;           {386+: SETNG}
 asmSETNGE=asmSETL;           {386+: SETNGE}
 asmSETNL=asmSETGE;           {386+: SETNL}
 asmSETNLE=asmSETG;           {386+: SETNLE}
 asmSETNO=$3D;                {386+: SETNO}
 asmSETNP=$3E;                {386+: SETNP}
 asmSETNS=$3F;                {386+: SETNS}
 asmSETNZ=asmSETNE;           {386+: SETNZ}
 asmSETO=$40;                 {386+: SETO}
 asmSETP=$41;                 {386+: SETP}
 asmSETPE=$42;                {386+: SETPE}
 asmSETPO=$43;                {386+: SETPO}
 asmSETS=$44;                 {386+: SETS}
 asmSETZ=asmSETE;             {386+: SETZ}
 asmSEV=$45;                  {6800: SEV}
 asmSHL=$46;                  {Famille 86: SHL}
 asmSHLD=$47;                 {8080 & 386+: SHLD (Store H & L direct/Shift Left Double)}
 asmSHR=$48;                  {Famille 86: SHR}
 asmSHRD=$49;                 {386+: SHRD}
 asmSPHL=$4A;                 {8080: SPHL (Store H & L to stack)}
 asmSTA=$4C;                  {6502, 6800 & 8080: STA (Store A direct/Store accumulator in Memory)}
 asmSTAX=$4D;                 {8080: STAX (Store A indirect)}
 asmSTC=$4E;                  {8080 & Famille 86: STC (Set Carry)}
 asmSTD=$4F;                  {Famille 86: STD}
 asmSTI=$50;                  {Famille 86: STI}
 asmSTOS=$51;                 {Famille 86: STOS}
 asmSTOSB=$52;                {Famille 86: STOSB}
 asmSTOSD=$53;                {386+: STOSD}
 asmSTOSW=$54;                {Famille 86: STOSW}
 asmSTS=$55;                  {6800: STS}
 asmSTX=$56;                  {6502 & 6800: STX (Store Index X in Memory)}
 asmSTY=$57;                  {6502: STY (Store Index Y in Memory)}
 asmSUB=$58;                  {6800, 8080 & Famille 86: SUB (Subtract)}
 asmSUI=$59;                  {8080: SUI (Subtract immediate)}
 asmSWI=$5A;                  {6800: SWI}
 asmTAB=$5B;                  {6800: TAB}
 asmTAP=$5C;                  {6800: TAP}
 asmTAX=$5D;                  {6502: TAX (Transfer Accumulator to Index X)}
 asmTAY=$5E;                  {6502: TAY (Transfer Accumulator to Index Y)}
 asmTBA=$5F;                  {6800: TBA}
 asmTEST=$60;                 {Famille 86: TEST}
 asmTPA=$61;                  {6800: TPA}
 asmTST=$62;                  {6800: TST}
 asmTSX=$63;                  {6502 & 6800: TSX (Transfer Stack Pointer to Index X)}
 asmTSY=$64;                  {6502: TSY (Transfer Stack Pointer to Index Y)}
 asmTXA=$65;                  {6502: TXA (Transfer Index X to Accumulator)}
 asmTXS=$66;                  {6502 & 6800: TXS (Transfer Index X to Stack Pointer)}
 asmTYA=$67;                  {6502: TYA (Transfer Index Y to Accumulator)}
 asmWAI=$68;                  {6800: WAI}
 asmWAIT=$69;                 {Famille 86: WAIT}
 asmXCHG=$6A;                 {8080 & Famille 86: XCHG (Exchange D & E, H & L, registers/Exchange x,y)}
 asmXLAT=$6B;                 {Famille 86: XLAT}
 asmXOR=$6C;                  {Famille 86: XOR}
 asmXRA=$6D;                  {8080: XRA (Exclusive Or memory with A)}
 asmXRI=$6E;                  {8080: XRI (Exclusive Or immediate with A)}
 asmXTHL=$6F;                 {8080: XTHL (Exchange top of stack, H & L)}

Function Pascal2Lam;Label Got,Xit;Var HS,HT:Hdl;CL,FS,PS:Long;
I:Byte;S,Name,Wd:String;Def:Bool;

 Procedure DebugInfo;Begin
  PutFileTxt(HT,Chr(lamDeb)+Chr(I)+Chr(Lo(CL))+Chr(Hi(CL)));
 End;

 Procedure SkipSpc;Begin
  SkipSpcInLn(I,S);
  If I>=Length(S)Then Begin
   I:=1;Inc(CL);
   __GetAbsFileTxtLn(HS,PS,S);
   SkipSpcInLn(I,S)
  End;
 End;

 Function Let:Bool;Begin
  Let:=No;Wd:=XtrkWord(I,S);
  SkipSpc;
  If StrI(I,S)<>'='Then Begin;Pascal2LAM:=EqualExpected;Exit;End;
  Inc(I);
  Let:=Ya;
 End;

 Function InlineAsm:Bool;Begin
  Repeat
   Wd:=StrUp(XtrkWord(I,S));
   If(Wd=asAAA)Then PutFileTxt(HT,Chr(lamAsm)+Chr(asmAAA))Else
   If(Wd=asAAD)Then PutFileTxt(HT,Chr(lamAsm)+Chr(asmAAD))Else
   If(Wd=asAAM)Then PutFileTxt(HT,Chr(lamAsm)+Chr(asmAAM))Else
   If(Wd=asAAS)Then PutFileTxt(HT,Chr(lamAsm)+Chr(asmAAS))
    Else
   If(Wd<>psEnd)Then Begin;Pascal2LAM:=SyntaxError;Exit;End;
  Until Wd=psEnd;
 End;

 Function Cortex:Bool;Begin
  Cortex:=No;
  Repeat
   SkipSpc;
   Wd:=StrUp(XtrkWord(I,S));
   If(Wd=psAsm)Then Begin
    If Not(InlineAsm)Then Break;
   End
    Else
   If(Wd=psBegin)Then Begin
    If Not(Cortex)Then Break;
   End
    Else
   If(Wd=psFor)Then Begin
    If Not(Let)Then Break;
   End
    Else
   If(Wd=psIf)Then Begin
    Wd:=StrUp(XtrkWord(I,S));
    If(Wd<>psThen)Then Begin;Pascal2LAM:=SyntaxError;Exit;End;
   End
    Else
   If(Wd=psWrite)Then Begin
   End
    Else
   If(Wd<>psEnd)Then Begin;Pascal2LAM:=SyntaxError;Exit;End;
  Until Wd=psEnd;
  Cortex:=Ya;
 End;

Begin
 Pascal2Lam:=0;PS:=0;CL:=0;Def:=No;HS:=FileOpen(Path,fmRead);
 If(HS=errHdl)Then Begin;Pascal2Lam:=FileNotFound;Exit;End;
 FS:=FileSize(HS);HT:=FileCreate(Path2NoExt(Path)+'.LAM');
 If(HS=errHdl)Then Pascal2Lam:=FileNotFound
  Else
 Begin
  PutFileTxt(HT,Chr(lamRem)+Chr(remCompilerName)+'OverCode'#0);
  PutFileTxt(HT,Chr(lamRem)+Chr(remCompilerVer)+#1#0#1#0);
  PutFileTxt(HT,Chr(lamRem)+Chr(remCompilerCopyright)+
                'Tous droits r‚serv‚s par les Chevaliers de Malte'#13#10+
                'Concepteur/Programmeur/Analyste: Gabriel Sylvain Maltais'#0);
  I:=1;Inc(CL);
  __GetAbsFileTxtLn(HS,PS,S);
  Repeat
   SkipSpcInLn(I,S);
   Wd:=StrUp(XtrkWord(I,S));
   If(Wd=psBegin)Then Begin
    If Not(Cortex)Then Break;
   End
    Else
   If(Wd=psProgram)Then Begin
    If(Def)Then Begin;Pascal2LAM:=MisplacedProgram;Break;End;
    PutFileTxt(HT,Chr(lamRem)+Chr(remProgram)+Wd+#0);
   End
    Else
   If(Wd=psProc)Then Begin
    SkipSpc;
    Name:=StrUp(XtrkWord(I,S));
    If Name=''Then Pascal2LAM:=NameExpected;
    PutFileTxt(HT,Chr(lamProc)+Name+#0);
    Goto Got;
   End
    Else
   If(Wd=psFunc)Then Begin
    SkipSpc;
    Name:=StrUp(XtrkWord(I,S));
    If Name=''Then Begin;Pascal2LAM:=NameExpected;Break;End;
    SkipSpc;
    If StrI(I,S)<>':'Then Begin;Pascal2LAM:=ColonExpected;Break;End;
    Inc(I);Wd:=StrUp(XtrkWord(I,S));
    If Wd=''Then Begin;Pascal2LAM:=NameExpected;Break;End;
    If(Wd=psBoolean)Then PutFileTxt(HT,Chr(lamFuncBool)+Name+#0)Else
    If(Wd=psByte)Then PutFileTxt(HT,Chr(lamFuncByte)+Name+#0)Else
    If(Wd=psChar)Then PutFileTxt(HT,Chr(lamFuncChar)+Name+#0)Else
    If(Wd=psShortInt)Then PutFileTxt(HT,Chr(lamFuncShortByte)+Name+#0)Else
    If(Wd=psInteger)Then PutFileTxt(HT,Chr(lamFuncInteger)+Name+#0)Else
    If(Wd=psWord)Then PutFileTxt(HT,Chr(lamFuncWord)+Name+#0)Else
    If(Wd=psLongInt)Then PutFileTxt(HT,Chr(lamFuncLongInt)+Name+#0)Else
    If(Wd=psPointer)or
      (Wd='PTR')Then PutFileTxt(HT,Chr(lamFuncPointerFar)+Name+#0)
    Else Begin;Pascal2LAM:=SyntaxError;Break;End;
Got:Def:=Ya;
    SkipSpc;
    If StrI(I,S)<>';'Then Begin;Pascal2LAM:=PointCommaExpected;Break;End;
    Inc(I);Wd:=StrUp(XtrkWord(I,S));
    If(Wd=psBegin)Then Begin
     If Not(Cortex)Then Break
    End
    Else Begin;Pascal2LAM:=SyntaxError;Break;End;
   End;
  Until PS>=FS;
Xit:
  FileClose(HT);
 End;
 FileClose(HS);
End;

END.