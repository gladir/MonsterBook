{OpCode.Inc}

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
 �                 Malte Genesis/Biblioth둸ue individuel                 �
 �                    릁ition Chantal/IV - Version 1.1                   �
 �                             1997/04/01                                �
 �                                                                       �
 �         Tous droits r굎erv굎 par les Chevaliers de Malte (C)          �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�


 Nom des programmeurs
 袴袴袴袴袴袴袴袴袴袴

  Sylvain Maltais


 Description
 袴袴袴袴袴�

  Cette inclusion vise  � permettre une universialisation des donn괻s �
 compiler  ind굋endament  des conditions  sous  lequel  la fonction est
 tra똳er.  En centralisant toutes les proc괺ures au m늤e point central,
 on aboutira une technique de 췈roiser�, celle-ci permet d'굃iminer les
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
 ciAAA=$37;{췆AA�,88+}
 ciAAD_=$D5;{췆AD�,88+}
 ciAAM_=$D4;{췆AM�,88+}
 ciAAS=$3F;{췆AS�,88+}
 ciAdcAL_=$14;{췆DC AL,??h�,286+}
 ciAdcAX_=$15;{췆DC AX,????h�,286+}
 ciAddAL_=$04;{췆DD AL,??h�,286+}
 ciAddAX_=$05;{췆DD AX,????h�,286+}
 ciAndAL_=$24;{췆ND AL,??h�,286+}
 ciAndAX_=$25;{췆ND AX,????h�,286+}
 ciCallFarAbs=$9A;{췈ALL FAR ????h:????h�,88+}
 ciCBW=$98;{췈BW�,88+}
 ciCC=$CC;{췏NT 03h�(Code Sp괹ial CCh),88+}
 ciCLC=$F8;{췈LC�,88+}
 ciCLD=$FC;{췈LD�,88+}
 ciCLI=$FA;{췈LI�,88+}
 ciCMC=$F5;{췈MC�,88+}
 ciCmpAL_=$3C;{췈MP AL,??h�,286+}
 ciCmpAX_=$3D;{췈MP AX,????h�,286+}
 ciCmpSB=$A6;{췈MPSB�,88+}
 ciCmpSW=$A7;{췈MPSW�,88+}
 ciCS=$2E;{췈S�,88+}
 ciCWD=$99;{췈WD�,88+}
 ciDAA=$27;{췉AA�,88+}
 ciDAS=$2F;{췉AS�,88+}
 ciDecAX=$48;{췉EC AX�,88+}
 ciDecBP=$4D;{췉EC BP�,88+}
 ciDecBX=$4B;{췉EC BX�,88+}
 ciDecCX=$49;{췉EC CX�,88+}
 ciDecDI=$4F;{췉EC DI�,88+}
 ciDecDX=$4A;{췉EC DX�,88+}
 ciDecSI=$4E;{췉EC SI�,88+}
 ciDecSP=$4C;{췉EC SP�,88+}
 ciDS=$3E;{췉S�,88+}
 ciES=$26;{췊S�,88+}
 ciFS=$64;{췋S�,386+}
 ciGS=$65;{췍S�,386+}
 ciHLT=$F4;{췎LT�,88+}
 ciIncAX=$40;{췏NC AX�,88+}
 ciIncBP=$45;{췏NC BP�,88+}
 ciIncBX=$43;{췏NC BX�,88+}
 ciIncCX=$41;{췏NC CX�,88+}
 ciIncDI=$47;{췏NC DI�,88+}
 ciIncDX=$42;{췏NC DX�,88+}
 ciIncSI=$46;{췏NC SI�,88+}
 ciIncSP=$44;{췏NC SP�,88+}
 ciInsB=$6C;{췏NSB�,88+}
 ciInsW=$6D;{췏NSW�,88+}
 ciInt=$CD;{췏NT ??h�,88+}
 ciIntO=$CE;{췏NTO�,88+}
 ciIRet=$CF;{췏RET�,88+}
 ciJBE=$76;{췑BE ?�,88+}
 ciJC=$72;{췑C ?�,88+}
 ciJG=$7E;{췑G ?�,88+}
 ciJL=$7C;{췑L ?�,88+}
 ciJMP_Word=$E9;{췑MP ????�,88+}
 ciJNBE=$77;{췑NBE ?�,88+}
 ciJNC=$73;{췑NC ?�,88+}
 ciJNG=$7F;{췑NG ?�,88+}
 ciJNL=$7D;{췑NL ?�,88+}
 ciJNO=$71;{췑NO ?�,88+}
 ciJNP=$7B;{췑NP ?�,88+}
 ciJNS=$79;{췑NS ?�,88+}
 ciJNZ=$75;{췑NZ ?�,88+}
 ciJO=$70;{췑O ?�,88+}
 ciJP=$7A;{췑P ?�,88+}
 ciJS=$78;{췑S ?�,88+}
 ciJZ=$74;{췑Z ?�,88+}
 ciLAHF=$9F;{췓AHF�,88+}
 ciLAR=$020F;{췓AR�,386+}
 ciLeave=$C9;{췓EAVE�,286+}
 ciLDS=$C5;{췓DS reg,mem�,88+}
 ciLES=$C4;{췓ES reg,mem�,88+}
 ciLFS=$B40F;{췓FS reg,mem�,386+}
 ciLGS=$B50F;{췓GS reg,mem�,386+}
 ciLock=$F0;{췓OCK ?�,88+}
 ciLODSB=$AC;{췓ODSB�,88+}
 ciLODSD=$AD66;{췓ODSD�,386+}
 ciLODSW=$AD;{췓ODSW�,88+}
 ciLSL=$030F;{췓SL ?�,386+}
 ciLSS=$B20F;{췓SS reg,mem�,386+}
 ciMovAL_=$A0;{췔OV AL,[addr]�,286+}
 ciMovAL_Byte=$B0;{췔OV AL,??�,88+}
 ciMovAX_=$A1;{췔OV AX,[addr]�,286+}
 ciMovAX_Word=$B8;{췔OV AX,????�, 88+}
 ciMovAH_AL=$E08A;{췔OV AH,AL�,88+}
 ciMovBP_SP=$EC8B;{췔OV BP,SP�,88+}
 ciMovBX_CX=$D98B;{췔OV BX,CX�,88+}
 ciMovCX_BX=$CB8B;{췔OV CX,BX�,88+}
 ciMovDX_Word=$BA;{췔OV DX,????�,88+}
 ciMovEAX_ES_DI=$058B6626;{췔OV EAX,ES:[DI]�,386+}
 ciMovES_DI_EAX=$05896626;{췔OV ES:[DI],EAX�,386+}
 ciMovSB=$A4;{췔OVSB�,88+}
 ciMovSD=$A566;{췔OVSD�,386+}
 ciMovSW=$A5;{췔OVSW�,88+}
 ciNOP=$90;{췕OP�,88+}
 ciOutDX_AL=$EE;{췖UT DX,AL�,88+}
 ciOutDX_AX=$EF;{췖UT DX,AX�,88+}
 ciOutSB=$6E;{췖UTSB�,286+}
 ciOutSD=$6F66;{췖UTSD�,386+}
 ciOutSW=$6F;{췖UTSW�,286+}
 ciPopAX=$58;{췗OP AX�,88+}
 ciPopBP=$5D;{췗OP BP�,88+}
 ciPopBX=$5B;{췗OP BX�,88+}
 ciPopCX=$59;{췗OP CX�,88+}
 ciPopDX=$5A;{췗OP DX�,88+}
 ciPopDI=$5F;{췗OP DI�,88+}
 ciPopDS=$1F;{췗OP DS�,88+}
 ciPopEAX=$5866;{췗OP EAX�,386+}
 ciPopEBX=$5B66;{췗OP EBX�,386+}
 ciPopECX=$5966;{췗OP ECX�,386+}
 ciPopEDI=$66+(ciPopDI shl 8);{췗USH EDI�,386+}
 ciPopEDX=$5A66;{췗OP EDX�,386+}
 ciPopFS=$A10F;{췗USH FS�,386+}
 ciPopGS=$A90F;{췗USH GS�,386+}
 ciPopES=$07;{췗OP ES�,88+}
 ciPopSI=$5E;{췗OP SI�,88+}
 ciPopSP=$5C;{췗OP SP�,88+}
 ciPopSS=$17;{췗OP SS�,88+}
 ciPopA=$61;{췗OPA�,286+}
 ciPopF=$9D;{췗OPF�,88+}
 ciPushA=$60;{췗USHA�,286+}
 ciPushAX=$50;{췗USH AX�,88+}
 ciPushBP=$55;{췗USH BP�,88+}
 ciPushBX=$53;{췗USH BX�,88+}
 ciPushCS=$0E;{췗USH CS�,88+}
 ciPushCX=$51;{췗USH CX�,88+}
 ciPushDI=$57;{췗USH DI�,88+}
 ciPushDS=$1E;{췗USH DS�,88+}
 ciPushDX=$52;{췗USH DX�,88+}
 ciPushEAX=$5066;{췗USH EAX�,386+}
 ciPushEBX=$5366;{췗USH EBX�,386+}
 ciPushECX=$5166;{췗USH ECX�,386+}
 ciPushEDX=$5266;{췗USH EDX�,386+}
 ciPushEDI=$66+(ciPushDI shl 8);{췗USH EDI�,386+}
 ciPushES=$06;{췗USH ES�,88+}
 ciPushFS=$A00F;{췗USH FS�,386+}
 ciPushGS=$A80F;{췗USH GS�, 386+}
 ciPushMemB=$6A;{췗USH ??�, 286+}
 ciPushSI=$56;{췗USH SI�,88+}
 ciPushSP=$54;{췗USH SP�,88+}
 ciPushSS=$16;{췗USH SS�,88+}
 ciPushF=$9C;{췗USHF�,88+}
 ciRepNZ=$F2;{췙EPNZ ?�,88+}
 ciRep=$F3;{췙EP ?�,88+}
 ciRetF=$CB;{췙ETF�,88+}
 ciRetN=$C3;{췙ETN�,88+}
 ciRet=ciRetN;{췙ETN칚u췙ETF�,88+}
 ciSAHF=$9E;{췚AHF�,88+}
 ciSbbAL_=$1C;{췚BB AL,??h�,286+}
 ciSbbAX_=$1D;{췚BB AX,????h�,286+}
 ciSCASB=$AE;{췚CASB�,88+}
 ciSCASD=$AF66;{췚CASS�,386+}
 ciSCASW=$AF;{췚CASW�,88+}
 ciSHR_AX_=$E8C1;{췚HR AX,?�,88+}
 ciSHR_CX_=$E9C1;{췚HR CX,?�,88+}
 ciSubAL_=$2C;{ 췚UB AL,??h�,286+}
 ciSubAX_=$2D;{췚UB AX,????h�,286+}
 ciSS=$36;{췚S�,88+}
 ciSTC=$F9;{췚TC�,88+}
 ciSTD=$FD;{췚TD�,88+}
 ciSTI=$FB;{췚TI�,88+}
 ciSTOSB=$AA;{췚TOSB�,88+}
 ciSTOSD=$AB66;{췚TOSD�,386+}
 ciSTOSW=$AB;{췚TOSW�,88+}
 ciXchgAXnBP=$95;{췟CHG AX,BP�,88+}
 ciXchgAXnBX=$93;{췟CHG AX,BX�,88+}
 ciXchgAXnCX=$91;{췟CHG AX,CX�,88+}
 ciXchgAXnDI=$97;{췟CHG AX,DI�,88+}
 ciXchgAXnDX=$92;{췟CHG AX,DX�,88+}
 ciXchgAXnSI=$96;{췟CHG AX,SI�,88+}
 ciXchgAXnSP=$94;{췟CHG AX,SP�,88+}
 ciXchgEAX_DS_SI=$048B663E;{췟CHG EAX,DS:[SI]�,386+}
 ciXlat=$D7;{췟LAT�,88+}
 ciXOR_=$81;{췟OR ?,?�,88+}
 ciXOR_AL_=$34;{췟OR AL,??h�,286+}
 ciXOR_AX_=$35;{췟OR AX,????h�,286+}

{$ENDIF}