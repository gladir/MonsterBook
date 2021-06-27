{OpCode.Inc}

{⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ‹
 ≥                 Malte Genesis/Bibliothäque individuel                 €
 ≥                    êdition Chantal/IV - Version 1.1                   €
 ≥                             1997/04/01                                €
 ≥                                                                       €
 ≥         Tous droits rÇservÇs par les Chevaliers de Malte (C)          €
 ¿‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹€


 Nom des programmeurs
 ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕ

  Sylvain Maltais


 Description
 ÕÕÕÕÕÕÕÕÕÕÕ

  Cette inclusion vise  Ö permettre une universialisation des donnÇes Ö
 compiler  indÇpendament  des conditions  sous  lequel  la fonction est
 traåter.  En centralisant toutes les procÇdures au màme point central,
 on aboutira une technique de ÆCroiserØ, celle-ci permet d'Çliminer les
 bugs par le raisonnement suivant:Maintenant sa fonctionne parfaitement
 ou sa plante comme jamais avant...
}

{$IFNDEF __OpCode}
 {$DEFINE __OpCode}

Const
 {Adresse d'assembleur pour le micro-processeur Intel (Cpu Intel)}
 ciBXnSI=$00;{Æ[BX+SI]Ø,88+}
 ciBXnDI=$01;{Æ[BX+DI]Ø,88+}
 ciBPnSI=$02;{Æ[BP+SI]Ø,88+}
 ciBPnDI=$03;{Æ[BP+DI]Ø,88+}
 ciSI=$04;{Æ[SI]Ø,88+}
 ciDI=$05;{Æ[DI]Ø,88+}
 ciBP=$06;{Æ[BP]Ø,88+}
 ciBX=$07;{Æ[BX]Ø,88+}
 {Instruction d'assembleur pour le micro-processeur Intel (Cpu Intel)}
 ciAAA=$37;{ÆAAAØ,88+}
 ciAAD_=$D5;{ÆAADØ,88+}
 ciAAM_=$D4;{ÆAAMØ,88+}
 ciAAS=$3F;{ÆAASØ,88+}
 ciAdcAL_=$14;{ÆADC AL,??hØ,286+}
 ciAdcAX_=$15;{ÆADC AX,????hØ,286+}
 ciAddAL_=$04;{ÆADD AL,??hØ,286+}
 ciAddAX_=$05;{ÆADD AX,????hØ,286+}
 ciAndAL_=$24;{ÆAND AL,??hØ,286+}
 ciAndAX_=$25;{ÆAND AX,????hØ,286+}
 ciCallFarAbs=$9A;{ÆCALL FAR ????h:????hØ,88+}
 ciCBW=$98;{ÆCBWØ,88+}
 ciCC=$CC;{ÆINT 03hØ(Code SpÇcial CCh),88+}
 ciCLC=$F8;{ÆCLCØ,88+}
 ciCLD=$FC;{ÆCLDØ,88+}
 ciCLI=$FA;{ÆCLIØ,88+}
 ciCMC=$F5;{ÆCMCØ,88+}
 ciCmpAL_=$3C;{ÆCMP AL,??hØ,286+}
 ciCmpAX_=$3D;{ÆCMP AX,????hØ,286+}
 ciCmpSB=$A6;{ÆCMPSBØ,88+}
 ciCmpSW=$A7;{ÆCMPSWØ,88+}
 ciCS=$2E;{ÆCSØ,88+}
 ciCWD=$99;{ÆCWDØ,88+}
 ciDAA=$27;{ÆDAAØ,88+}
 ciDAS=$2F;{ÆDASØ,88+}
 ciDecAX=$48;{ÆDEC AXØ,88+}
 ciDecBP=$4D;{ÆDEC BPØ,88+}
 ciDecBX=$4B;{ÆDEC BXØ,88+}
 ciDecCX=$49;{ÆDEC CXØ,88+}
 ciDecDI=$4F;{ÆDEC DIØ,88+}
 ciDecDX=$4A;{ÆDEC DXØ,88+}
 ciDecSI=$4E;{ÆDEC SIØ,88+}
 ciDecSP=$4C;{ÆDEC SPØ,88+}
 ciDS=$3E;{ÆDSØ,88+}
 ciES=$26;{ÆESØ,88+}
 ciFS=$64;{ÆFSØ,386+}
 ciGS=$65;{ÆGSØ,386+}
 ciHLT=$F4;{ÆHLTØ,88+}
 ciIncAX=$40;{ÆINC AXØ,88+}
 ciIncBP=$45;{ÆINC BPØ,88+}
 ciIncBX=$43;{ÆINC BXØ,88+}
 ciIncCX=$41;{ÆINC CXØ,88+}
 ciIncDI=$47;{ÆINC DIØ,88+}
 ciIncDX=$42;{ÆINC DXØ,88+}
 ciIncSI=$46;{ÆINC SIØ,88+}
 ciIncSP=$44;{ÆINC SPØ,88+}
 ciInsB=$6C;{ÆINSBØ,88+}
 ciInsW=$6D;{ÆINSWØ,88+}
 ciInt=$CD;{ÆINT ??hØ,88+}
 ciIntO=$CE;{ÆINTOØ,88+}
 ciIRet=$CF;{ÆIRETØ,88+}
 ciJBE=$76;{ÆJBE ?Ø,88+}
 ciJC=$72;{ÆJC ?Ø,88+}
 ciJG=$7E;{ÆJG ?Ø,88+}
 ciJL=$7C;{ÆJL ?Ø,88+}
 ciJMP_Word=$E9;{ÆJMP ????Ø,88+}
 ciJNBE=$77;{ÆJNBE ?Ø,88+}
 ciJNC=$73;{ÆJNC ?Ø,88+}
 ciJNG=$7F;{ÆJNG ?Ø,88+}
 ciJNL=$7D;{ÆJNL ?Ø,88+}
 ciJNO=$71;{ÆJNO ?Ø,88+}
 ciJNP=$7B;{ÆJNP ?Ø,88+}
 ciJNS=$79;{ÆJNS ?Ø,88+}
 ciJNZ=$75;{ÆJNZ ?Ø,88+}
 ciJO=$70;{ÆJO ?Ø,88+}
 ciJP=$7A;{ÆJP ?Ø,88+}
 ciJS=$78;{ÆJS ?Ø,88+}
 ciJZ=$74;{ÆJZ ?Ø,88+}
 ciLAHF=$9F;{ÆLAHFØ,88+}
 ciLAR=$020F;{ÆLARØ,386+}
 ciLeave=$C9;{ÆLEAVEØ,286+}
 ciLDS=$C5;{ÆLDS reg,memØ,88+}
 ciLES=$C4;{ÆLES reg,memØ,88+}
 ciLFS=$B40F;{ÆLFS reg,memØ,386+}
 ciLGS=$B50F;{ÆLGS reg,memØ,386+}
 ciLock=$F0;{ÆLOCK ?Ø,88+}
 ciLODSB=$AC;{ÆLODSBØ,88+}
 ciLODSD=$AD66;{ÆLODSDØ,386+}
 ciLODSW=$AD;{ÆLODSWØ,88+}
 ciLSL=$030F;{ÆLSL ?Ø,386+}
 ciLSS=$B20F;{ÆLSS reg,memØ,386+}
 ciMovAL_=$A0;{ÆMOV AL,[addr]Ø,286+}
 ciMovAL_Byte=$B0;{ÆMOV AL,??Ø,88+}
 ciMovAX_=$A1;{ÆMOV AX,[addr]Ø,286+}
 ciMovAX_Word=$B8;{ÆMOV AX,????Ø, 88+}
 ciMovAH_AL=$E08A;{ÆMOV AH,ALØ,88+}
 ciMovBP_SP=$EC8B;{ÆMOV BP,SPØ,88+}
 ciMovBX_CX=$D98B;{ÆMOV BX,CXØ,88+}
 ciMovCX_BX=$CB8B;{ÆMOV CX,BXØ,88+}
 ciMovDX_Word=$BA;{ÆMOV DX,????Ø,88+}
 ciMovEAX_ES_DI=$058B6626;{ÆMOV EAX,ES:[DI]Ø,386+}
 ciMovES_DI_EAX=$05896626;{ÆMOV ES:[DI],EAXØ,386+}
 ciMovSB=$A4;{ÆMOVSBØ,88+}
 ciMovSD=$A566;{ÆMOVSDØ,386+}
 ciMovSW=$A5;{ÆMOVSWØ,88+}
 ciNOP=$90;{ÆNOPØ,88+}
 ciOutDX_AL=$EE;{ÆOUT DX,ALØ,88+}
 ciOutDX_AX=$EF;{ÆOUT DX,AXØ,88+}
 ciOutSB=$6E;{ÆOUTSBØ,286+}
 ciOutSD=$6F66;{ÆOUTSDØ,386+}
 ciOutSW=$6F;{ÆOUTSWØ,286+}
 ciPopAX=$58;{ÆPOP AXØ,88+}
 ciPopBP=$5D;{ÆPOP BPØ,88+}
 ciPopBX=$5B;{ÆPOP BXØ,88+}
 ciPopCX=$59;{ÆPOP CXØ,88+}
 ciPopDX=$5A;{ÆPOP DXØ,88+}
 ciPopDI=$5F;{ÆPOP DIØ,88+}
 ciPopDS=$1F;{ÆPOP DSØ,88+}
 ciPopEAX=$5866;{ÆPOP EAXØ,386+}
 ciPopEBX=$5B66;{ÆPOP EBXØ,386+}
 ciPopECX=$5966;{ÆPOP ECXØ,386+}
 ciPopEDI=$66+(ciPopDI shl 8);{ÆPUSH EDIØ,386+}
 ciPopEDX=$5A66;{ÆPOP EDXØ,386+}
 ciPopFS=$A10F;{ÆPUSH FSØ,386+}
 ciPopGS=$A90F;{ÆPUSH GSØ,386+}
 ciPopES=$07;{ÆPOP ESØ,88+}
 ciPopSI=$5E;{ÆPOP SIØ,88+}
 ciPopSP=$5C;{ÆPOP SPØ,88+}
 ciPopSS=$17;{ÆPOP SSØ,88+}
 ciPopA=$61;{ÆPOPAØ,286+}
 ciPopF=$9D;{ÆPOPFØ,88+}
 ciPushA=$60;{ÆPUSHAØ,286+}
 ciPushAX=$50;{ÆPUSH AXØ,88+}
 ciPushBP=$55;{ÆPUSH BPØ,88+}
 ciPushBX=$53;{ÆPUSH BXØ,88+}
 ciPushCS=$0E;{ÆPUSH CSØ,88+}
 ciPushCX=$51;{ÆPUSH CXØ,88+}
 ciPushDI=$57;{ÆPUSH DIØ,88+}
 ciPushDS=$1E;{ÆPUSH DSØ,88+}
 ciPushDX=$52;{ÆPUSH DXØ,88+}
 ciPushEAX=$5066;{ÆPUSH EAXØ,386+}
 ciPushEBX=$5366;{ÆPUSH EBXØ,386+}
 ciPushECX=$5166;{ÆPUSH ECXØ,386+}
 ciPushEDX=$5266;{ÆPUSH EDXØ,386+}
 ciPushEDI=$66+(ciPushDI shl 8);{ÆPUSH EDIØ,386+}
 ciPushES=$06;{ÆPUSH ESØ,88+}
 ciPushFS=$A00F;{ÆPUSH FSØ,386+}
 ciPushGS=$A80F;{ÆPUSH GSØ, 386+}
 ciPushMemB=$6A;{ÆPUSH ??Ø, 286+}
 ciPushSI=$56;{ÆPUSH SIØ,88+}
 ciPushSP=$54;{ÆPUSH SPØ,88+}
 ciPushSS=$16;{ÆPUSH SSØ,88+}
 ciPushF=$9C;{ÆPUSHFØ,88+}
 ciRepNZ=$F2;{ÆREPNZ ?Ø,88+}
 ciRep=$F3;{ÆREP ?Ø,88+}
 ciRetF=$CB;{ÆRETFØ,88+}
 ciRetN=$C3;{ÆRETNØ,88+}
 ciRet=ciRetN;{ÆRETNØouÆRETFØ,88+}
 ciSAHF=$9E;{ÆSAHFØ,88+}
 ciSbbAL_=$1C;{ÆSBB AL,??hØ,286+}
 ciSbbAX_=$1D;{ÆSBB AX,????hØ,286+}
 ciSCASB=$AE;{ÆSCASBØ,88+}
 ciSCASD=$AF66;{ÆSCASSØ,386+}
 ciSCASW=$AF;{ÆSCASWØ,88+}
 ciSHR_AX_=$E8C1;{ÆSHR AX,?Ø,88+}
 ciSHR_CX_=$E9C1;{ÆSHR CX,?Ø,88+}
 ciSubAL_=$2C;{ ÆSUB AL,??hØ,286+}
 ciSubAX_=$2D;{ÆSUB AX,????hØ,286+}
 ciSS=$36;{ÆSSØ,88+}
 ciSTC=$F9;{ÆSTCØ,88+}
 ciSTD=$FD;{ÆSTDØ,88+}
 ciSTI=$FB;{ÆSTIØ,88+}
 ciSTOSB=$AA;{ÆSTOSBØ,88+}
 ciSTOSD=$AB66;{ÆSTOSDØ,386+}
 ciSTOSW=$AB;{ÆSTOSWØ,88+}
 ciXchgAXnBP=$95;{ÆXCHG AX,BPØ,88+}
 ciXchgAXnBX=$93;{ÆXCHG AX,BXØ,88+}
 ciXchgAXnCX=$91;{ÆXCHG AX,CXØ,88+}
 ciXchgAXnDI=$97;{ÆXCHG AX,DIØ,88+}
 ciXchgAXnDX=$92;{ÆXCHG AX,DXØ,88+}
 ciXchgAXnSI=$96;{ÆXCHG AX,SIØ,88+}
 ciXchgAXnSP=$94;{ÆXCHG AX,SPØ,88+}
 ciXchgEAX_DS_SI=$048B663E;{ÆXCHG EAX,DS:[SI]Ø,386+}
 ciXlat=$D7;{ÆXLATØ,88+}
 ciXOR_=$81;{ÆXOR ?,?Ø,88+}
 ciXOR_AL_=$34;{ÆXOR AL,??hØ,286+}
 ciXOR_AX_=$35;{ÆXOR AX,????hØ,286+}

{$ENDIF}