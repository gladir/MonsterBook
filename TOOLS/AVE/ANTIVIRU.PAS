{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³           Malte Genesis/Module AntiVirus            ³
 ³   Edition Isabel pour Mode R‚el/III - Version 1.0   ³
 ³                      1994/12/29                     ³
 ³                                                     ³
 ³ Tous droits r‚serv‚ par les Chevaliers de Malte (C) ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}

Unit AntiVirus;

INTERFACE

Uses Systex;

Function Agiplan:Bool;
Function Anarkia:Bool;
Function Armagedon:Bool;
Function BackTime:Bool;
Function BlackMonday:Bool;
Function Blinker:Bool;
Function Border:Bool;
Function Brothers:Bool;
Function Burghofer:Bool;
Function Carfield:Bool;
Function Carioca:Bool;
Function Cascade:Bool;
Function Cinderella:Bool;
Function CrazyImp:Bool;
Function Dashem1876:Bool;
Function Datalock:Bool;
Function dBASE:Bool;
Function DiamondA:Bool;
Function DiamondB:Bool;
Function Dir:Bool;
Function Durban:Bool;
Function Dutch555:Bool;
Function Eddie2:Bool;
Function Europe92:Bool;
Function FellowShip:Bool;
Function Flip:Bool;
Function FrereJacques:Bool;
Function FuManchu:Bool;
Function Gotcha:Bool;
Function GPI:Bool;
Function GrowingBlock:Bool;
Function G:Bool;
Function HeyYou:Bool;
Function Hitchcock:Bool;
Function Horse:Bool;
Function Horse2:Bool;
Function Invader:Bool;
Function Jabberwocky:Bool;
Function JD448:Bool;
Function Jerusalem:Bool;
Function JerusalemG:Bool;
Function Justice:Bool;
Function Klaeren:Bool;
Function Lozinsky:Bool;
Function Magnitogorsk:Bool;
Function ManyFingers:Bool;
Function Mendoza:Bool;
Function MG:Bool;
Function MH757:Bool;
Function Milous:Bool;
Function Mlti:Bool;
Function Murphy1:Bool;
Function Murphy2:Bool;
Function Nomenklatura:Bool;
Function Ontario:Bool;
Function Oropax:Bool;
Function PcVrsDs:Bool;
Function Plastique2576:Bool;
Function Plastique:Bool;
Function Plovdiv13:Bool;
Function Possessed:Bool;
Function Pregnant:Bool;
Function PSQR1720:Bool;
Function Rape747:Bool;
Function Revenge:Bool;
Function Shake:Bool;
Function Shirley:Bool;
Function Slow:Bool;
Function Socha:Bool;
Function Solano:Bool;
Function Sparse:Bool;
Function Spyer:Bool;
Function Squeaker:Bool;
Function Sunday:Bool;
Function SVC:Bool;
Function SVC5:Bool;
Function SVC6:Bool;
Function Sverdlov:Bool;
Function Terror:Bool;
Function Tremor:Bool;
Function Troi:Bool;
Function Twins:Bool;
Function USSR707:Bool;
Function Voronezh:Bool;
Function Vriest:Bool;
Function Westwood:Bool;
Function Witcode:Bool;
Function Yankee:Bool;
Function Year92:Bool;
Function Zherkov1882:Bool;
Function _483:Bool;
Function _516:Bool;
Function _600:Bool;
Function _699:Bool;
Function _789:Bool;
Function _8tunes:Bool;
Function _905:Bool;
Function _948:Bool;
Function _1028DarkAvenger:Bool;
Function _1049:Bool;
Function _1067:Bool;
Function _1063:Bool;
Function _1193Copyright:Bool;
Function _2468:Bool;

Const
 MaxVirusBank=103;

 AntiVirusBank:Array[0..MaxVirusBank]of Record Func:Function:Bool;PChr:System.PChar;End=(
  (Func:_483;PChr:'483'),
  (Func:_516;PChr:'516/LeapFrog'),
  (Func:_600;PChr:'600/Veronezh'),
  (Func:_699;PChr:'699'),
  (Func:_789;PChr:'789/Filehider'),
  (Func:_8tunes;PChr:'8-tunes'),
  (Func:_905;PChr:'905/Backfont'),
  (Func:_948;PChr:'948/Screenplus1'),
  (Func:_1049;PChr:'USSR-1049'),
  (Func:_1063;PChr:'1063/Mono'),
  (Func:_1067;PChr:'1067/Headcrach'),
  (Func:_1193Copyright;PChr:'1193/Copyright'),
  (Func:_2468;PChr:'2468/Tequila'),
  (Func:Agiplan;PChr:'Agiplan/Month 4-6'),
  (Func:Anarkia;PChr:'Anarkia'),
  (Func:Armagedon;PChr:'Armagedon'),
  (Func:Backtime;PChr:'Backtime'),
  (Func:BlackMonday;PChr:'Black-Monday'),
  (Func:Blinker;PChr:'Blinker'),
  (Func:Border;PChr:'Border'),
  (Func:Brothers;PChr:'Brothers'),
  (Func:Burghofer;PChr:'Burghofer'),
  (Func:Carfield;PChr:'Carfield'),
  (Func:Carioca;PChr:'Carioca'),
  (Func:Cascade;PChr:'Cascade'),
  (Func:Cinderella;PChr:'Cinderella'),
  (Func:CrazyImp;PChr:'Crazy Imp'),
  (Func:_1028DarkAvenger;PChr:'Dark Avenger-1028'),
  (Func:Dashem1876;PChr:'Dash-em/1876'),
  (Func:Datalock;PChr:'DataLock'),
  (Func:dBASE;PChr:'dBASE'),
  (Func:DiamondA;PChr:'Diamond-A'),
  (Func:DiamondB;PChr:'Diamond-B'),
  (Func:Dir;PChr:'Dir'),
  (Func:Durban;PChr:'Durban'),
  (Func:Dutch555;PChr:'Dutch-555/Quit 92'),
  (Func:Eddie2;PChr:'Eddie 2'),
  (Func:Europe92;PChr:'Europe 92'),
  (Func:FellowShip;PChr:'FellowShip'),
  (Func:Flip;PChr:'Flip'),
  (Func:FrereJacques;PChr:'FrŠre-Jacques'),
  (Func:FuManchu;PChr:'Fu Manchu'),
  (Func:G;PChr:'G/Parfume'),
  (Func:Gotcha;PChr:'Gotcha'),
  (Func:GPI;PChr:'GP1'),
  (Func:GrowingBlock;PChr:'Growing Block'),
  (Func:HeyYou;PChr:'Hey You'),
  (Func:Hitchcock;PChr:'Hitchcock'),
  (Func:Horse;PChr:'Horse'),
  (Func:Horse2;PChr:'Horse-2'),
  (Func:Invader;PChr:'Invader'),
  (Func:Jabberwocky;PChr:'Jabberwocky'),
  (Func:JD448;PChr:'JD-448'),
  (Func:Jerusalem;PChr:'Jerusalem'),
  (Func:JerusalemG;PChr:'Jerusalem-G'),
  (Func:Justice;PChr:'Justice'),
  (Func:Klaeren;PChr:'Klaeren'),
  (Func:Lozinsky;PChr:'Lozinsky'),
  (Func:Magnitogorsk;PChr:'Magnitogorsk'),
  (Func:ManyFingers;PChr:'Many Fingers/08/15'),
  (Func:Mendoza;PChr:'Mendoza'),
  (Func:MG;PChr:'MG'),
  (Func:MH757;PChr:'MH-757'),
  (Func:Milous;PChr:'Milous'),
  (Func:Mlti;PChr:'Mlti'),
  (Func:Murphy1;PChr:'Murphy-1'),
  (Func:Murphy2;PChr:'Murphy-2'),
  (Func:Nomenklatura;PChr:'Nomenklatura'),
  (Func:Ontario;PChr:'Ontario'),
  (Func:Oropax;PChr:'Oropax'),
  (Func:PcVrsDs;PChr:'PcVrsDs'),
  (Func:Plastique2576;PChr:'Plastique 2576'),
  (Func:Plastique;PChr:'Plastique'),
  (Func:Plovdiv13;PChr:'Plovdiv 1.3'),
  (Func:Possessed;PChr:'Possessed'),
  (Func:Pregnant;PChr:'Pregnant'),
  (Func:PSQR1720;PChr:'PSQR/1720'),
  (Func:Rape747;PChr:'Rape-747'),
  (Func:Revenge;PChr:'Revenge'),
  (Func:Shake;PChr:'Shake'),
  (Func:Shirley;PChr:'Shirley'),
  (Func:Slow;PChr:'Slow/Zerotime'),
  (Func:Socha;PChr:'Socha'),
  (Func:Solano;PChr:'Solano'),
  (Func:Sparse;PChr:'Sparse'),
  (Func:Spyer;PChr:'Spyer/Kiev'),
  (Func:Squeaker;PChr:'Squeaker'),
  (Func:Sunday;PChr:'Sunday'),
  (Func:SVC;PChr:'SVC'),
  (Func:SVC5;PChr:'SVC 5'),
  (Func:SVC6;PChr:'SVC 6'),
  (Func:Sverdlov;PChr:'Sverdlov'),
  (Func:Terror;PChr:'Terror'),
  (Func:Tremor;PChr:'Tremor'),
  (Func:Troi;PChr:'Trio'),
  (Func:Twins;PChr:'Twins'),
  (Func:USSR707;PChr:'USSR-707'),
  (Func:Voronezh;PChr:'Voronezh'),
  (Func:Vriest;PChr:'Vriest'),
  (Func:Westwood;PChr:'Westwood'),
  (Func:Witcode;PChr:'Witcode'),
  (Func:Yankee;PChr:'Yankee/MLTI'),
  (Func:Year92;PChr:'Year 92/B1M92'),
  (Func:Zherkov1882;PChr:'Zherkov-1882'));

IMPLEMENTATION

Function G;Assembler;ASM MOV AX,$B56;INT $21;CMP AX,$4952;MOV AL,No;JNE @1;MOV AL,Ya;@1:END;
Function CrazyImp;Assembler;ASM MOV AX,$D20;INT $21;CMP AX,$1971;MOV AL,No;JNE @1;MOV AL,Ya;@1:END;
Function Possessed;Assembler;ASM MOV AX,$3000;MOV DX,$ABCD;INT $21;CMP DX,$DCBA;MOV AL,No;JNE @1;MOV AL,Ya;@1:END;
Function Dutch555;Assembler;ASM MOV AX,$30F1;INT $21;CMP AL,0;MOV AL,No;JNE @1;MOV AL,Ya;@1:END;
Function Burghofer;Assembler;ASM MOV AX,$330F;INT $21;CMP AL,$0F;MOV AL,No;JNE @1;MOV AL,Ya;@1:END;
Function Oropax;Assembler;ASM MOV AX,$33E0;INT $21;CMP AL,$FF;MOV AL,No;JNE @1;CMP AH,$33;JE @1;MOV AL,Ya;@1:END;
Function Agiplan;Assembler;ASM MOV AX,$357F;XOR DX,DX;INT $21;CMP DX,-1;MOV AL,No;JNE @1;MOV AL,Ya;@1:END;
Function JD448;Assembler;ASM MOV AX,$3DFF;INT $21;CMP AX,$4A44;MOV AL,No;JNE @1;MOV AL,Ya;@1:END;
Function Shake;Assembler;ASM MOV AX,$4203;INT $21;CMP AX,$1234;MOV AL,No;JNE @1;MOV AL,Ya;@1:END;
Function Invader;Assembler;ASM MOV AX,$4243;INT $21;CMP AX,$5678;MOV AL,No;JNE @1;MOV AL,Ya;@1:END;

Function MG;Assembler;ASM
 MOV AX,$4B04;XOR BX,BX;XOR DX,DX;STC;PUSH DS;MOV ES,BX;MOV DS,BX;INT $21;POP DS;MOV AL,No;JC @1;MOV AL,Ya;@1:
END;

Function _699;Assembler;ASM
 MOV AX,$4B04;XOR BX,BX;XOR DX,DX;STC;PUSH DS;MOV ES,BX;MOV DS,BX;INT $21;POP DS;CMP AX,$044B;MOV AL,No;JNE @1;MOV AL,Ya;@1:
END;

Function _1063;Assembler;ASM
 MOV AX,$4B25;XOR BX,BX;XOR DX,DX;STC;PUSH DS;MOV ES,BX;MOV DS,BX;INT $21;POP DS;CMP AX,$1234;MOV AL,No;JNE @1;MOV AL,Ya;@1:
END;

Function Plastique;Assembler;ASM MOV AX,$4B40;INT $21;CMP AX,$5678;MOV AL,No;JNE @1;MOV AL,Ya;@1:END;
Function Jabberwocky;Assembler;ASM MOV AX,$4B4A;INT $21;CMP AL,$57;MOV AL,No;JNE @1;MOV AL,Ya;@1:END;
Function Horse2;Assembler;ASM MOV AX,$4B4B;INT $21;MOV AL,No;JC @1;MOV AL,Ya;@1:END;
Function Murphy2;Assembler;ASM MOV AX,$4B4D;STC;INT $21;MOV AL,No;JC @1;MOV AL,Ya;@1:END;
Function Plastique2576;Assembler;ASM MOV AX,$4B50;INT $21;CMP AX,$1234;MOV AL,No;JNE @1;MOV AL,Ya;@1:END;
Function Horse;Assembler;ASM MOV AX,$4B53;INT $21;MOV AL,No;JC @1;MOV AL,Ya;@1:END;
Function Sparse;Assembler;ASM MOV AX,$4B55;INT $21;CMP AX,$1231;MOV AL,No;JNE @1;MOV AL,Ya;@1:END;
Function Murphy1;Assembler;ASM MOV AX,$4B59;STC;INT $21;MOV AL,No;JC @1;MOV AL,Ya;@1:END;
Function Brothers;Assembler;ASM MOV AX,$4B5E;STC;INT $21;MOV AL,No;JC @1;MOV AL,Ya;@1:END;
Function Shirley;Assembler;ASM MOV AX,$4B87;INT $21;CMP AX,$6663;MOV AL,No;JNE @1;MOV AL,Ya;@1:END;
Function Zherkov1882;Assembler;ASM MOV AX,$4B95;INT $21;CMP AX,$1973;MOV AL,No;JNE @1;MOV AL,Ya;@1:END;
Function Dashem1876;Assembler;ASM MOV AX,$4BA7;INT $21;CMP AX,$B459;MOV AL,No;JNE @1;MOV AL,Ya;@1:END;
Function Nomenklatura;Assembler;ASM MOV AX,$4BAA;STC;INT $21;MOV AL,No;JC @1;MOV AL,Ya;@1:END;
Function _948;Assembler;ASM MOV AX,$4BAF;INT $21;CMP AL,$FA;MOV AL,No;JNE @1;MOV AL,Ya;@1:END;
Function Magnitogorsk;Assembler;ASM MOV AX,$4BAF;INT $21;CMP AL,$AF;MOV AL,No;JNE @1;MOV AL,Ya;@1:END;
Function Lozinsky;Assembler;ASM MOV AX,$4BDD;INT $21;CMP AX,$4BDD;MOV AL,No;JNE @1;MOV AL,Ya;@1:END;
Function Hitchcock;Assembler;ASM MOV AX,$4BFE;INT $21;CMP AX,$1234;MOV AL,No;JNE @1;MOV AL,Ya;@1:END;
Function _1193Copyright;Assembler;ASM MOV AX,$4BFE;INT $21;CMP AX,$ABCD;MOV AL,No;JNE @1;MOV AL,Ya;@1:END;
Function _1028DarkAvenger;Assembler;ASM MOV AX,$4BFE;INT $21;MOV AL,No;CMP DI,$55BB;JNE @1;MOV AL,Ya;@1:END;
Function USSR707;Assembler;ASM MOV AX,$4BFF;MOV BL,0;INT $21;CMP BL,$FF;MOV AL,No;JNE @1;MOV AL,Ya;@1:END;
Function Justice;Assembler;ASM MOV AX,$4BFF;XOR DI,DI;INT $21;CMP DI,$55AA;MOV AL,No;JNE @1;MOV AL,Ya;@1:END;
Function Europe92;Assembler;ASM MOV AX,$4BFF;STC;INT $21;MOV AL,No;JC @1;MOV AL,Ya;@1:END;
Function Cascade;Assembler;ASM MOV AX,$4BFF;XOR SI,SI;XOR DI,DI;INT $21;CMP DI,$55AA;MOV AL,No;JNE @1;MOV AL,Ya;@1:END;
Function _516;Assembler;ASM MOV AX,$5252;XOR BX,BX;INT $21;CMP BX,$FFEE;MOV AL,No;JNE @1;MOV AL,Ya;@1:END;
Function _1067;Assembler;ASM MOV AX,$58CC;STC;INT $21;MOV AL,No;JC @1;MOV AL,Ya;@1:END;
Function Rape747;Assembler;ASM MOV AX,$6969;INT $21;CMP AX,$666;MOV AL,No;JNE @1;MOV AL,Ya;@1:END;
Function Klaeren;Assembler;ASM MOV AX,$7600;INT $21;CMP AL,$48;MOV AL,No;JNE @1;MOV AL,Ya;@1:END;
Function GrowingBlock;Assembler;ASM MOV AX,$7700;INT $21;CMP AX,$920;MOV AL,No;JNE @1;MOV AL,Ya;@1:END;
Function Squeaker;Assembler;ASM MOV AH,$7F;INT $21;CMP AH,$80;MOV AL,No;JNE @1;MOV AL,Ya;@1:END;
Function SVC;Assembler;ASM MOV AH,$83;XOR DX,DX;INT $21;CMP DX,$1990;MOV AL,No;JNE @1;MOV AL,Ya;@1:END;

Function SVC5;Assembler;ASM
 MOV AH,$84;XOR DX,DX;INT $21;CMP DX,$1990;MOV AL,No;JNE @1;AND BH,$F0;CMP BH,$50;JNE @1;MOV AL,Ya;@1:
END;

Function SVC6;Assembler;ASM
 MOV AH,$84;XOR DX,DX;INT $21;CMP DX,$1990;MOV AL,No;JNE @1;AND BH,$F0;CMP BH,$60;JNE @1;MOV AL,Ya;@1:
END;

Function Vriest;Assembler;ASM MOV AH,$89;INT $21;CMP AX,$123;MOV AL,No;JNE @1;MOV AL,Ya;@1:END;

Function Carioca;Assembler;ASM
 MOV AH,90h
 INT 21h
 AND AH,1
 MOV AL,AH
END;

Function Blinker;Assembler;ASM MOV AX,$AA00;INT $21;CMP AX,$AA;MOV AL,No;JNE @1;MOV AL,Ya;@1:END;
Function Backtime;Assembler;ASM MOV AX,$AA03;INT $21;CMP AX,$3AA;MOV AL,No;JNE @1;MOV AL,Ya;@1:END;
Function _789;Assembler;ASM MOV AX,$A1D5;INT $21;CMP AX,$900D;MOV AL,No;JNE @1;MOV AL,Ya;@1:END;
Function Eddie2;Assembler;ASM MOV AX,$A55A;INT $21;CMP AX,$5AA5;MOV AL,No;JNE @1;MOV AL,Ya;@1:END;
Function _600;Assembler;ASM MOV AH,$AB;INT $21;CMP AX,$5555;MOV AL,No;JNE @1;MOV AL,Ya;@1:END;
Function HeyYou;Assembler;ASM MOV AX,$BBBB;INT $21;CMP AX,$6969;MOV AL,No;JNE @1;MOV AL,Ya;@1:END;
Function Voronezh;Begin Voronezh:=_600;End;
Function Datalock;Assembler;ASM MOV AH,$BE;INT $21;CMP AX,$1234;MOV AL,No;JNE @1;MOV AL,Ya;@1:END;
Function _1049;Assembler;ASM MOV AX,$BE00;STC;INT $21;MOV AL,No;JNC @1;MOV AL,Ya;@1:END;

Function Slow;Assembler;ASM
 MOV AH,$C0;XOR BX,BX;XOR CX,CX;XOR DX,DX;PUSH DS;MOV DS,BX;INT $21;POP DS;CMP AX,$300;MOV AL,No;JNE @1;MOV AL,Ya;@1:
END;

Function Solano;Assembler;ASM
 MOV AH,$C0;XOR BX,BX;XOR CX,CX;XOR DX,DX;PUSH DS;MOV DS,BX;INT $21;POP DS;CMP AX,$1234;MOV AL,No;JNE @1;MOV AL,Ya;@1:
END;

Function _905;Assembler;ASM MOV AX,$C301;MOV DX,$F1F1;INT $21;CMP DX,$E0E;MOV AL,No;JNE @1;MOV AL,Ya;@1:END;
Function Sverdlov;Assembler;ASM MOV AX,$C500;INT $21;CMP AX,$6731;MOV AL,No;JNE @1;MOV AL,Ya;@1:END;
Function Socha;Assembler;ASM MOV AX,$C600;INT $21;CMP AL,$55;MOV AL,No;JNE @1;MOV AL,Ya;@1:END;
Function Yankee;Assembler;ASM MOV AX,$C603;STC;INT $21;MOV AL,No;JNC @1;MOV AL,Ya;@1:END;
Function MH757;Assembler;ASM MOV AX,$C700;INT $21;CMP AL,7;MOV AL,No;JNE @1;MOV AL,Ya;@1:END;
Function Mlti;Begin Mlti:=Yankee;End;
Function Milous;Assembler;ASM MOV AX,$CB00;INT $21;CMP AL,7;MOV AL,No;JNE @1;MOV AL,Ya;@1:END;
Function Witcode;Assembler;ASM MOV AX,$CB02;INT $21;CMP AX,$2CB;MOV AL,No;JNE @1;MOV AL,Ya;@1:END;

Function Westwood;Assembler;ASM
 MOV AH,$CC;XOR DX,DX;PUSH DS;MOV DS,DX;INT $21;POP DS;CMP AX,$700;MOV AL,No;JNE @1;MOV AL,Ya;@1:
END;

Function FellowShip;Assembler;ASM
 MOV AX,$D000;XOR BX,BX;XOR DX,DX;PUSH DS;MOV DS,DX;INT $21;POP DS;CMP BX,$1234;MOV AL,No;JNE @1;MOV AL,Ya;@1:
END;

Function DiamondA;Assembler;ASM MOV AX,$D5AA;INT $21;CMP AX,$2A55;MOV AL,No;JNE @1;MOV AL,Ya;@1:END;
Function DiamondB;Assembler;ASM MOV AX,$D5AA;INT $21;CMP AX,$2A03;MOV AL,No;JNE @1;MOV AL,Ya;@1:END;

Function Dir;Assembler;ASM
 MOV AX,$D5AA;XOR SI,SI;PUSH BP;MOV BP,$DEAA;INT $21;POP BP;CMP SI,$4321;MOV AL,No;JNE @1;MOV AL,Ya;@1:
END;

Function Gotcha;Assembler;ASM MOV AX,$DADA;INT $21;CMP AH,$A5;MOV AL,No;JNE @1;MOV AL,Ya;@1:END;
Function Plovdiv13;Assembler;ASM MOV AX,$DAFE;INT $21;CMP AX,$1234;MOV AL,No;JNE @1;MOV AL,Ya;@1:END;
Function Durban;Assembler;ASM MOV AX,$DEFF;INT $21;CMP AH,$DF;MOV AL,No;JNE @1;MOV AL,Ya;@1:END;

Function Jerusalem;Assembler;ASM
 MOV AX,$E000;XOR SI,SI;XOR DI,DI;MOV ES,SI;PUSH DS;MOV DS,SI;INT $21;POP DS;CMP AX,$300;MOV AL,No;JNE @1;MOV AL,Ya;@1:
END;

Function Armagedon;Assembler;ASM
 MOV AX,$E000;XOR SI,SI;XOR DI,DI;MOV ES,SI;PUSH DS;MOV DS,SI;INT $21;POP DS;CMP AX,$DADA;MOV AL,No;JNE @1;MOV AL,Ya;@1:
END;

Function _8tunes;Assembler;ASM MOV AX,$E00F;INT $21;CMP AX,$4C31;MOV AL,No;JNE @1;MOV AL,Ya;@1:END;

Function Mendoza;Assembler;ASM
 MOV AH,$E1;XOR SI,SI;XOR DI,DI;MOV ES,SI;PUSH DS;MOV DS,SI;INT $21;POP DS;CMP AX,$300;MOV AL,No;JNE @1;MOV AL,Ya;@1:
END;

Function FuManchu;Assembler;ASM
 MOV AH,$E1;XOR SI,SI;XOR DI,DI;MOV ES,SI;PUSH DS;MOV DS,SI;INT $21;POP DS;CMP AX,$400;MOV AL,No;JNE @1;MOV AL,Ya;@1:
END;

Function Anarkia;Assembler;ASM
 MOV AH,$E4;XOR DX,DX;PUSH DS;MOV DS,DX;INT $21;POP DS;CMP AH,$04;MOV AL,No;JNE @1;MOV AL,Ya;@1:
END;

Function Spyer;Assembler;ASM MOV AH,$E7;INT $21;CMP AH,$78;MOV AL,No;JNE @1;MOV AL,Ya;@1:END;
Function Terror;Assembler;ASM MOV AX,$EC59;PUSH BP;INT $21;CMP BP,$EC59;POP BP;MOV AL,No;JNE @1;MOV AL,Ya;@1:END;
Function JerusalemG;Assembler;ASM MOV AH,$EE;INT $21;CMP AX,$300;MOV AL,No;JNE @1;MOV AL,Ya;@1:END;
Function Pregnant;Assembler;ASM MOV AH,$EE;INT $21;CMP AL,5;MOV AL,No;JNE @1;MOV AL,Ya;@1:END;
Function FrereJacques;Assembler;ASM MOV AX,$F0FF;INT $21;CMP AX,$300;MOV AL,No;JNE @1;MOV AL,Ya;@1:END;
Function Tremor;Assembler;ASM MOV AX,$F1E9;INT $21;CMP AX,$CADE;MOV AL,No;JNE @1;MOV AL,Ya;@1:END;
Function PcVrsDs;Assembler;ASM MOV AX,$F2AA;INT $21;CMP AH,$AA;MOV AL,No;JNE @1;MOV AL,Ya;@1:END;
Function Carfield;Assembler;ASM MOV AH,$F3;INT $21;CMP AX,$400;MOV AL,No;JNE @1;MOV AL,Ya;@1:END;
Function GPI;Assembler;ASM MOV AH,$F7;INT $21;CMP AX,$300;MOV AL,No;JNE @1;MOV AL,Ya;@1:END;
Function Cinderella;Assembler;ASM MOV AX,$FB00;INT $21;CMP AH,0;MOV AL,No;JNE @1;MOV AL,Ya;@1:END;
Function dBASE;Assembler;ASM MOV AX,$FB0A;INT $21;CMP AX,$AFB;MOV AL,No;JNE @1;MOV AL,Ya;@1:END;
Function Troi;Assembler;ASM MOV AH,$FC;INT $21;CMP AL,$A5;MOV AL,No;JNE @1;MOV AL,Ya;@1:END;
Function Border;Assembler;ASM MOV AH,$FD;INT $21;CMP AH,$13;MOV AL,No;JNE @1;MOV AL,Ya;@1:END;
Function _483;Assembler;ASM MOV AX,$FE00;INT $21;CMP AH,0;MOV AL,No;JNE @1;MOV AL,Ya;@1:END;
Function Flip;Assembler;ASM MOV AX,$FE01;INT $21;CMP AX,$1FE;MOV AL,No;JNE @1;MOV AL,Ya;@1:END;
Function _2468;Assembler;ASM MOV AX,$FE02;INT $21;CMP AX,$01FD;MOV AL,No;JNE @1;MOV AL,Ya;@1:END;
Function BlackMonday;Assembler;ASM MOV AX,$FEDC;INT $21;CMP AL,$DC;MOV AL,No;JNE @1;MOV AL,Ya;@1:END;
Function Sunday;Assembler;ASM MOV AX,$FF00;INT $21;CMP AX,$400;MOV AL,No;JNE @1;MOV AL,Ya;@1:END;
Function PSQR1720;Assembler;ASM MOV AX,$FF0F;INT $21;CMP AX,$101;MOV AL,No;JNE @1;MOV AL,Ya;@1:END;
Function Twins;Assembler;ASM MOV AX,$FF10;INT $21;CMP AL,7;MOV AL,No;JNE @1;MOV AL,Ya;@1:END;
Function ManyFingers;Assembler;ASM MOV AX,-2;INT $21;CMP AX,$815;MOV AL,No;JNE @1;MOV AL,Ya;@1:END;
Function Ontario;Assembler;ASM MOV AX,-1;INT $21;CMP AX,0;MOV AL,No;JNE @1;MOV AL,Ya;@1:END;
Function Year92;Assembler;ASM MOV AX,-1;INT $21;CMP AX,$1992;MOV AL,No;JNE @1;MOV AL,Ya;@1:END;
Function Revenge;Assembler;ASM MOV AX,-1;XOR CX,CX;INT $21;CMP CX,6;MOV AL,No;JNE @1;MOV AL,Ya;@1:END;

END.