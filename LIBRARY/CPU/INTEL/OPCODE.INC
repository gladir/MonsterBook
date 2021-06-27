{OpCode.Inc}

{�������������������������������������������������������������������������
 �                 Malte Genesis/Biblioth�que individuel                 �
 �                    �dition Chantal/IV - Version 1.1                   �
 �                             1997/04/01                                �
 �                                                                       �
 �         Tous droits r�serv�s par les Chevaliers de Malte (C)          �
 �������������������������������������������������������������������������


 Nom des programmeurs
 ��������������������

  Sylvain Maltais


 Description
 �����������

  Cette inclusion vise  � permettre une universialisation des donn�es �
 compiler  ind�pendament  des conditions  sous  lequel  la fonction est
 tra�ter.  En centralisant toutes les proc�dures au m�me point central,
 on aboutira une technique de �Croiser�, celle-ci permet d'�liminer les
 bugs par le raisonnement suivant:Maintenant sa fonctionne parfaitement
 ou sa plante comme jamais avant...
}

{$IFNDEF __OpCode}
 {$DEFINE __OpCode}

Const
 {Adresse d'assembleur pour le micro-processeur Intel (Cpu Intel)}
 ciBXnSI=$00;{�[BX+SI]�,88+}
 ciBXnDI=$01;{�[BX+DI]�,88+}
 ciBPnSI=$02;{�[BP+SI]�,88+}
 ciBPnDI=$03;{�[BP+DI]�,88+}
 ciSI=$04;{�[SI]�,88+}
 ciDI=$05;{�[DI]�,88+}
 ciBP=$06;{�[BP]�,88+}
 ciBX=$07;{�[BX]�,88+}
 {Instruction d'assembleur pour le micro-processeur Intel (Cpu Intel)}
 ciAAA=$37;{�AAA�,88+}
 ciAAD_=$D5;{�AAD�,88+}
 ciAAM_=$D4;{�AAM�,88+}
 ciAAS=$3F;{�AAS�,88+}
 ciAdcAL_=$14;{�ADC AL,??h�,286+}
 ciAdcAX_=$15;{�ADC AX,????h�,286+}
 ciAddAL_=$04;{�ADD AL,??h�,286+}
 ciAddAX_=$05;{�ADD AX,????h�,286+}
 ciAndAL_=$24;{�AND AL,??h�,286+}
 ciAndAX_=$25;{�AND AX,????h�,286+}
 ciCallFarAbs=$9A;{�CALL FAR ????h:????h�,88+}
 ciCBW=$98;{�CBW�,88+}
 ciCC=$CC;{�INT 03h�(Code Sp�cial CCh),88+}
 ciCLC=$F8;{�CLC�,88+}
 ciCLD=$FC;{�CLD�,88+}
 ciCLI=$FA;{�CLI�,88+}
 ciCMC=$F5;{�CMC�,88+}
 ciCmpAL_=$3C;{�CMP AL,??h�,286+}
 ciCmpAX_=$3D;{�CMP AX,????h�,286+}
 ciCmpSB=$A6;{�CMPSB�,88+}
 ciCmpSW=$A7;{�CMPSW�,88+}
 ciCS=$2E;{�CS�,88+}
 ciCWD=$99;{�CWD�,88+}
 ciDAA=$27;{�DAA�,88+}
 ciDAS=$2F;{�DAS�,88+}
 ciDecAX=$48;{�DEC AX�,88+}
 ciDecBP=$4D;{�DEC BP�,88+}
 ciDecBX=$4B;{�DEC BX�,88+}
 ciDecCX=$49;{�DEC CX�,88+}
 ciDecDI=$4F;{�DEC DI�,88+}
 ciDecDX=$4A;{�DEC DX�,88+}
 ciDecSI=$4E;{�DEC SI�,88+}
 ciDecSP=$4C;{�DEC SP�,88+}
 ciDS=$3E;{�DS�,88+}
 ciES=$26;{�ES�,88+}
 ciFS=$64;{�FS�,386+}
 ciGS=$65;{�GS�,386+}
 ciHLT=$F4;{�HLT�,88+}
 ciIncAX=$40;{�INC AX�,88+}
 ciIncBP=$45;{�INC BP�,88+}
 ciIncBX=$43;{�INC BX�,88+}
 ciIncCX=$41;{�INC CX�,88+}
 ciIncDI=$47;{�INC DI�,88+}
 ciIncDX=$42;{�INC DX�,88+}
 ciIncSI=$46;{�INC SI�,88+}
 ciIncSP=$44;{�INC SP�,88+}
 ciInsB=$6C;{�INSB�,88+}
 ciInsW=$6D;{�INSW�,88+}
 ciInt=$CD;{�INT ??h�,88+}
 ciIntO=$CE;{�INTO�,88+}
 ciIRet=$CF;{�IRET�,88+}
 ciJBE=$76;{�JBE ?�,88+}
 ciJC=$72;{�JC ?�,88+}
 ciJG=$7E;{�JG ?�,88+}
 ciJL=$7C;{�JL ?�,88+}
 ciJMP_Word=$E9;{�JMP ????�,88+}
 ciJNBE=$77;{�JNBE ?�,88+}
 ciJNC=$73;{�JNC ?�,88+}
 ciJNG=$7F;{�JNG ?�,88+}
 ciJNL=$7D;{�JNL ?�,88+}
 ciJNO=$71;{�JNO ?�,88+}
 ciJNP=$7B;{�JNP ?�,88+}
 ciJNS=$79;{�JNS ?�,88+}
 ciJNZ=$75;{�JNZ ?�,88+}
 ciJO=$70;{�JO ?�,88+}
 ciJP=$7A;{�JP ?�,88+}
 ciJS=$78;{�JS ?�,88+}
 ciJZ=$74;{�JZ ?�,88+}
 ciLAHF=$9F;{�LAHF�,88+}
 ciLAR=$020F;{�LAR�,386+}
 ciLeave=$C9;{�LEAVE�,286+}
 ciLDS=$C5;{�LDS reg,mem�,88+}
 ciLES=$C4;{�LES reg,mem�,88+}
 ciLFS=$B40F;{�LFS reg,mem�,386+}
 ciLGS=$B50F;{�LGS reg,mem�,386+}
 ciLock=$F0;{�LOCK ?�,88+}
 ciLODSB=$AC;{�LODSB�,88+}
 ciLODSD=$AD66;{�LODSD�,386+}
 ciLODSW=$AD;{�LODSW�,88+}
 ciLSL=$030F;{�LSL ?�,386+}
 ciLSS=$B20F;{�LSS reg,mem�,386+}
 ciMovAL_=$A0;{�MOV AL,[addr]�,286+}
 ciMovAL_Byte=$B0;{�MOV AL,??�,88+}
 ciMovAX_=$A1;{�MOV AX,[addr]�,286+}
 ciMovAX_Word=$B8;{�MOV AX,????�, 88+}
 ciMovAH_AL=$E08A;{�MOV AH,AL�,88+}
 ciMovBP_SP=$EC8B;{�MOV BP,SP�,88+}
 ciMovBX_CX=$D98B;{�MOV BX,CX�,88+}
 ciMovCX_BX=$CB8B;{�MOV CX,BX�,88+}
 ciMovDX_Word=$BA;{�MOV DX,????�,88+}
 ciMovEAX_ES_DI=$058B6626;{�MOV EAX,ES:[DI]�,386+}
 ciMovES_DI_EAX=$05896626;{�MOV ES:[DI],EAX�,386+}
 ciMovSB=$A4;{�MOVSB�,88+}
 ciMovSD=$A566;{�MOVSD�,386+}
 ciMovSW=$A5;{�MOVSW�,88+}
 ciNOP=$90;{�NOP�,88+}
 ciOutDX_AL=$EE;{�OUT DX,AL�,88+}
 ciOutDX_AX=$EF;{�OUT DX,AX�,88+}
 ciOutSB=$6E;{�OUTSB�,286+}
 ciOutSD=$6F66;{�OUTSD�,386+}
 ciOutSW=$6F;{�OUTSW�,286+}
 ciPopAX=$58;{�POP AX�,88+}
 ciPopBP=$5D;{�POP BP�,88+}
 ciPopBX=$5B;{�POP BX�,88+}
 ciPopCX=$59;{�POP CX�,88+}
 ciPopDX=$5A;{�POP DX�,88+}
 ciPopDI=$5F;{�POP DI�,88+}
 ciPopDS=$1F;{�POP DS�,88+}
 ciPopEAX=$5866;{�POP EAX�,386+}
 ciPopEBX=$5B66;{�POP EBX�,386+}
 ciPopECX=$5966;{�POP ECX�,386+}
 ciPopEDI=$66+(ciPopDI shl 8);{�PUSH EDI�,386+}
 ciPopEDX=$5A66;{�POP EDX�,386+}
 ciPopFS=$A10F;{�PUSH FS�,386+}
 ciPopGS=$A90F;{�PUSH GS�,386+}
 ciPopES=$07;{�POP ES�,88+}
 ciPopSI=$5E;{�POP SI�,88+}
 ciPopSP=$5C;{�POP SP�,88+}
 ciPopSS=$17;{�POP SS�,88+}
 ciPopA=$61;{�POPA�,286+}
 ciPopF=$9D;{�POPF�,88+}
 ciPushA=$60;{�PUSHA�,286+}
 ciPushAX=$50;{�PUSH AX�,88+}
 ciPushBP=$55;{�PUSH BP�,88+}
 ciPushBX=$53;{�PUSH BX�,88+}
 ciPushCS=$0E;{�PUSH CS�,88+}
 ciPushCX=$51;{�PUSH CX�,88+}
 ciPushDI=$57;{�PUSH DI�,88+}
 ciPushDS=$1E;{�PUSH DS�,88+}
 ciPushDX=$52;{�PUSH DX�,88+}
 ciPushEAX=$5066;{�PUSH EAX�,386+}
 ciPushEBX=$5366;{�PUSH EBX�,386+}
 ciPushECX=$5166;{�PUSH ECX�,386+}
 ciPushEDX=$5266;{�PUSH EDX�,386+}
 ciPushEDI=$66+(ciPushDI shl 8);{�PUSH EDI�,386+}
 ciPushES=$06;{�PUSH ES�,88+}
 ciPushFS=$A00F;{�PUSH FS�,386+}
 ciPushGS=$A80F;{�PUSH GS�, 386+}
 ciPushMemB=$6A;{�PUSH ??�, 286+}
 ciPushSI=$56;{�PUSH SI�,88+}
 ciPushSP=$54;{�PUSH SP�,88+}
 ciPushSS=$16;{�PUSH SS�,88+}
 ciPushF=$9C;{�PUSHF�,88+}
 ciRepNZ=$F2;{�REPNZ ?�,88+}
 ciRep=$F3;{�REP ?�,88+}
 ciRetF=$CB;{�RETF�,88+}
 ciRetN=$C3;{�RETN�,88+}
 ciRet=ciRetN;{�RETN�ou�RETF�,88+}
 ciSAHF=$9E;{�SAHF�,88+}
 ciSbbAL_=$1C;{�SBB AL,??h�,286+}
 ciSbbAX_=$1D;{�SBB AX,????h�,286+}
 ciSCASB=$AE;{�SCASB�,88+}
 ciSCASD=$AF66;{�SCASS�,386+}
 ciSCASW=$AF;{�SCASW�,88+}
 ciSHR_AX_=$E8C1;{�SHR AX,?�,88+}
 ciSHR_CX_=$E9C1;{�SHR CX,?�,88+}
 ciSubAL_=$2C;{ �SUB AL,??h�,286+}
 ciSubAX_=$2D;{�SUB AX,????h�,286+}
 ciSS=$36;{�SS�,88+}
 ciSTC=$F9;{�STC�,88+}
 ciSTD=$FD;{�STD�,88+}
 ciSTI=$FB;{�STI�,88+}
 ciSTOSB=$AA;{�STOSB�,88+}
 ciSTOSD=$AB66;{�STOSD�,386+}
 ciSTOSW=$AB;{�STOSW�,88+}
 ciXchgAXnBP=$95;{�XCHG AX,BP�,88+}
 ciXchgAXnBX=$93;{�XCHG AX,BX�,88+}
 ciXchgAXnCX=$91;{�XCHG AX,CX�,88+}
 ciXchgAXnDI=$97;{�XCHG AX,DI�,88+}
 ciXchgAXnDX=$92;{�XCHG AX,DX�,88+}
 ciXchgAXnSI=$96;{�XCHG AX,SI�,88+}
 ciXchgAXnSP=$94;{�XCHG AX,SP�,88+}
 ciXchgEAX_DS_SI=$048B663E;{�XCHG EAX,DS:[SI]�,386+}
 ciXlat=$D7;{�XLAT�,88+}
 ciXOR_=$81;{�XOR ?,?�,88+}
 ciXOR_AL_=$34;{�XOR AL,??h�,286+}
 ciXOR_AX_=$35;{�XOR AX,????h�,286+}

{$ENDIF}