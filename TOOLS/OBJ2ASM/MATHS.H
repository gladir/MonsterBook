//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³                                                     ³
//³    Malte Genesis/Entˆte de base des Math‚matiques   ³
//³              Edition Isabel pour Mode R‚el          ³
//³                    III - Version 1.0                ³
//³                       1995/02/02                    ³
//³                                                     ³
//³     Copyright (C) par les Chevaliers de Malte       ³
//³                                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

#ifndef __IsabelMaths
 #define __IsabelMaths

#define _i486   8
#define _80486  _i486
#define _i386   7
#define _80386  _i386
#define _80286  6
#define _80186  5
#define _80188  4
#define _v30    3
#define _v20    2
#define _8086   1
#define _8088   0

#define True    1
#define False   0

#define NULL    0L

typedef unsigned char Boolean;
typedef Boolean Bool;
typedef unsigned char Byte;
typedef signed char ShortInt;
typedef unsigned char Byte;
typedef unsigned char Char;
typedef unsigned char *PChar;
typedef signed int Integer;
typedef signed int Int;
typedef unsigned int Word;
typedef signed long LongInt;
typedef signed long LInt;
typedef unsigned long LongWord;
typedef unsigned long DWord;
typedef float Real;
typedef Char String[255];

typedef struct { Word Ofs,Seg; } PtrRec;
typedef struct { Word Base; Byte LoSeg; } RPtr;

#define Seg(fp) ((unsigned)(void _seg *)(void far *)(fp))
#define Ofs(fp) ((unsigned)(fp))
void InLine(unsigned char __byte, ...);

extern Byte Processor;
extern Bool Up32Bits;

int  AbsInt(int);
long AddrExt2Conv(void far*);
void far*AddrRPtr2Ext(RPtr X);
#define CLI() InLine((char)(0xFA))
Bool Compare(void far*Source,void far*Dest,Word Len);
Word DivW(Word a,Word b);
long DivL(long a,long b);
void FillBool(void far *X,Word Len,Bool Value);
void FillBoolAt(void far *X,Word At,Word Len,Bool Value);
void FillChar(void far *X,Word Len,Byte Value);
void FillWord(void far *X,Word Len,Word Value);
Byte GetProcessor(void);
Byte MinByte(Byte N,Byte Max);
Byte MaxByte(Byte N,Byte Max);
Word ModW(Word a,Word b);
void Move(void far *Source,void far *Dest,Word Count);
void MoveBack(void far*Source,void far *Dest,Word Count);
#define STI() InLine((char)(0xFB))
void SwapByte(Byte *a,Byte *b);
void SwapInt(int *a,int *b);
void SwapWord(Word *a,Word *b);
long WhoMax(long a,long b);
long WhoMin(long a,long b);

#endif