Uses Adele,SysInterne,Systex,Systems,Volumex;

(*Procedure DiskRead(Sector:LongInt;NumSectors:Word;Dest:LongInt);Assembler;
Var
 CurrSector:LongInt;
 SectorsToRead:Word;
 CurrDest:LongInt;
ASM
 PUSH es
  LES AX,Sector
  MOV DX,ES
  mov Word Ptr CurrSector,ax
  MOV Word Ptr CurrSector[2],DX
  add eax,LBAstart
  mov DWord LOW DiskAddrPkt.Sector,eax
  mov ax,NumSectors
  mov SectorsToRead,ax
  mov DiskAddrPkt.Count,ax
  mov eax,Dest
  mov CurrDest,eax
  mov DiskAddrPkt.Buffer,eax
  cmp AccessMethod,Method_Ext
  jne @@ReadCHS
   { Lecture en utilisant la m‚thode d'adressage LBA }
  mov dl,PhysDrv
  mov si,Offset DiskAddrPkt
  mov ah,42h
  int 13h
  jc  @@Done
  jmp @@CopyToCache
   { Lecture en utilisant la m‚thode d'adressage CHS }
@@ReadCHS:
  mov ecx,CurrSector
  call LogToCHS
  mov al,Byte Ptr NumSectors
  cmp Multitrack,0
  jnz @@DoInt13
   { Op‚ration multi-piste non support‚e }
  push cx
   and cl,3Fh
   mov al,nSecs
   sub al,cl
   inc al		{ Secteurs gauche dans la piste }
   xor ah,ah
   cmp ax,SectorsToRead
   jbe @@3
   mov al,Byte Ptr SectorsToRead { Lecture ®SectorsToRead¯ secteurs }
@@3:
 pop cx
@@DoInt13:
 mov dl,PhysDrv
 mov ah,02h
 les bx,CurrDest
 push ax
  int 13h
 pop ax
 jc  @@Done
 and eax,0FFh
 les di,CurrDest        { Tampon }
 movzx cx,al		{ Nombre de secteurs }
 mov edx,CurrSector	{ Premier secteurs }
 add CurrSector,eax
 sub SectorsToRead,ax
 push dx
  mov dx,200h
  mul dx
 pop dx
 add Word Ptr CurrDest,ax
  { V‚rification de lecture des plusieurs secteurs }
@@SectorsLeft:
 cmp SectorsToRead,0
 jnz @@ReadCHS
  { Copie les secteurs dans un cache. }
@@CopyToCache:
 cmp CacheOn,0
 jz  @@Done
 cmp XMSError,0
 jnz @@Done
 mov edx,[@@Sector]
 les di,Dest
 mov cx,NumSectors
@@CacheLoop:
 call GetFreeCacheEntry	; Get free cache entry in BX.
 or  bx,bx
 sete XMSError
 jz  @@Done
 push cx
  mov ecx,edx
  call CacheInsert { InsŠre le secteur ECX dans ES:DI dans l'entr‚e BX. }
 pop cx
 add edx,1
 add di,200h
 loop @@CacheLoop
 clc
@@Done:
 pop es
END;*)

(*Const
 Method_CHS	=	0;	{ Adressage CHS }
 Method_CHSExt	=	1;	{ Adressage ‚tendue CHS }
 Method_Ext	=	2;	{ Extensions IBM/MS }

Procedure CheckHPFSPart(Method:Byte;PhysDrive,nHeads,nSecs,sCyl,sHead,sSec,sLBA:LongInt);Assembler;
Var Drive:Byte;
ASM
 push ds
  PUSH es
   cmp Method,Method_CHS
   je  @@ReadCHS
   cmp Method,Method_CHSExt
   je  @@ReadCHSExt
   jmp @@ReadExt
    { Lecture du secteur de d‚marrage en utilisant le CHS }
@@ReadCHS:
   mov ax,0201h
   mov bx,OFFSET Buf2
   mov ch,[BYTE LOW @@sCyl]
   mov cl,[BYTE HIGH @@sCyl]
   shl cl,6
   xor cl,[BYTE LOW @@sSec]
   mov dh,[BYTE LOW @@sHead]
   mov dl,[BYTE LOW @@PhysDrive]
   int 13h
   jc  @@errReadError
   jmp @@BootRead
    { Lecture du secteur de d‚marrage en utilisant CHS ‚tendue }
@@ReadCHSExt:
   PUSH Word Ptr sLBA[2]
   PUSH Word Ptr sLBA[0]
   PUSH Word Ptr PhysDrive[2]
   PUSH Word Ptr PhysDrive[0]
   PUSH Word Ptr nHeads[2]
   PUSH Word Ptr nHeads[0]
   PUSH Word Ptr nSecs[2]
   PUSH Word Ptr nSecs[0]
   PUSH es
   MOV AX,OFFSET Buf2
   PUSH AX
   call NEAR Ptr ReadSectorExtCHS
   jc	@@errReadError
   jmp	@@BootRead
    { Lecture de secteur de d‚marrage en utilisant les extensions IBM/MS }
@@ReadExt:
   mov DiskAddrPkt1.Count,1
   mov eax,sLBA
   mov DWORD LOW DiskAddrPkt1.Sector,eax
   mov WORD LOW DiskAddrPkt1.Buffer], OFFSET Buf2
   mov WORD HIGH DiskAddrPkt1.Buffer], SEG Buf2
   mov dl,BYTE LOW @@PhysDrive
   mov si,OFFSET DiskAddrPkt1
   mov ah,42h
   int 13h
   jc  @@errReadError
@@BootRead:
   { V‚rification de la signature HPFS }
   cmp [WORD Buf2+36h], 'PH'
   jne @@Done
   cmp [WORD Buf2+38h], 'SF'
   jne @@Done
    { Partition HPFS trouv‚. }
   inc PartCount
   movzx bx,PartCount
   mov dl,Partitions[bx]
   mov Drive,dl
   mov Partitions[bx],0FFh	{ Partition trouv‚ }
   cmp dl,0FFh
   je  @@Done			{ Ne pas installer cette partition }
    { V‚rifier que cette partition n'est pas d‚ja install‚ }
   call Near IsInstalledPart,bx
   or  ah,ah
   jnz @@errPartInstalled
   les bx,LstOfLst
   les si,es:[bx+16h]		{ Tableau CDS }
   cmp Drive,0FEh
   je  @@ScanCDS		{ Trouve la premier lettre disponible }
   mov ah,36h                   { Demande l'espace de libre }
   mov dl,Drive
   inc dl
   int 21h
   cmp ax,0FFFFh
   jne @@errDrvUsed
   mov al,Byte Ptr CDSSize
   mov cl,Drive
   mul cl
   mov si,ax                  { Pointes sur le CDS de notre unit‚ }
   cmp cl,LastDrive
   jb  @@FoundCDS
   jmp @@errInvDrv
    { Recherche un tableau CDS, regarde pour un CDS inutilis‚. }
    { ES:SI -> CDS. }
@@ScanCDS:
   mov Drive,0
@@ScanCDS1:
   cmp DrDos,0
   jz  @@ScanCDS2
   cmp WORD Ptr es:[si+43h],0	{ DR-DOS }
   jmp @@ScanCDS3
@@ScanCDS2:
   test WORD Ptr es:[si+43h], 0C000h  { Masque les bits 15 et 14 de l'attribut d'unit‚ }
@@ScanCDS3:
   jz  @@FoundCDS                { Si 0, alors c'est un invalide = libre }
   add si,CDSSize                { Point to next CDS }
   inc Drive
   mov cl,Drive
   cmp cl,LastDrive
   jb  @@ScanCDS1                { Aller au prochaine entr‚e CDS }
   jmp@@errOutOfDrv
@@FoundCDS:
    { Allou‚ de la m‚moire pour les donn‚es r‚sidente }
   mov bx,OFFSET EndResData
   shr bx,4
   inc bx
   mov ah,48h
	int	21h
	jc	@@errMallocErr
	movzx	bx, [@@Drive]
	shl	bx, 1
	mov	[DataSegs+bx], ax	; Save ResData segment
	mov	gs, ax
	ASSUME	gs:ResData
; Clear resident data.
	push	es
	mov	es, ax
	xor	al, al
	cld
	mov	cx, OFFSET EndResData
	xor	di, di
	rep stosb
	pop	es
; Set resident data
	mov	al, [BYTE LOW @@PhysDrive]
	mov	[PhysDrv], al
	mov	ax, [@@nHeads]
	mov	[nHeads], ax
	mov	al, [BYTE LOW @@nSecs]
	mov	[nSecs], al
	mov	al, [PartCount]
	mov	[PartitionNr], al
	mov	al, [BYTE LOW @@Method]
	mov	[AccessMethod], al
	mov	eax, [@@sLBA]
	mov	[LBAstart], eax
        call	InitResData
; Set CDS fields
	mov	cl, [@@Drive]
	add     cl, 'A'
	mov     [MsgDrvLetter], cl
	cmp	[DrDos], 0
	jz	@@SetCDS
	mov	[WORD es:si+43h], 8000h	; DR-DOS
	jmp	@@CDSSet
@@SetCDS:
	or      [WORD es:si+43h], 0C000h ; Flags+Physical bits on = Netwrk drive
@@CDSSet:
	mov     [es:si], cl
	mov     [WORD es:si+1], '\:'
	mov     [BYTE es:si+3], 0
	mov     [WORD es:si+4Fh], 2 ; Offset of backslash
	mov	[Installed], 1		; Drive successfully installed
; Partition installed - print message
	mov	dx, OFFSET MsgInstalled
	mov	ah, 9
	int	21h
	jmp	@@Done

@@errReadError:
	mov	dx, OFFSET MsgDiskError
	mov	ah, 9
	int	21h
	jmp	@@Done
@@errDrvUsed:
	mov	dl, [@@Drive]
	add	dl, 'A'
	mov	[MsgDrvUsedLetter], dl
	mov	dx, OFFSET MsgDrvUsed
	mov	ah, 9
	int	21h
	mov	[ErrSignaled], 1
	jmp	@@Done
@@errInvDrv:
	mov	dl, [@@Drive]
	add	dl, 'A'
	mov	[MsgInvDrvLetter], dl
	mov	dx, OFFSET MsgInvDrv
	mov	ah, 9
        int	21h
	mov	[ErrSignaled], 1
        jmp	@@Done
@@errPartInstalled:
	movzx	ax, [PartCount]
	mov	dl, 10
	div	dl
	or	al, al
	jz	@@errPartInstalled1	; Leave 00h if first digit 0.
	add	al, 30h
@@errPartInstalled1:
	add	ah, 30h
	mov	[WORD MsgPartInstalledNr], ax
	mov	dx, OFFSET MsgPartInstalled
	mov	ah, 9
	int	21h
	mov	[ErrSignaled], 1
        jmp	@@Done
@@errOutOfDrv:
	mov	dx, OFFSET MsgNoAvailDrvLetter
	mov	ah, 9
	int	21h
	mov	[ErrSignaled], 1
	jmp	@@Fail
@@errMallocErr:
	mov	dx, OFFSET MsgMallocErr
	mov	ah, 9
	int	21h
	mov	[ErrSignaled], 1
	jmp	@@Fail

@@Fail:	stc
	jmp	@@Exit
@@Done:
	clc
@@Exit:
  POP es
 POP ds
END;*)

{$I \Source\Chantal\Library\Disk\Bios\ReadPart.Inc}
{$I \Source\Chantal\Library\Disk\GIHD.Inc}

Const
  { Unit‚ physique correspondant … l'unit‚ logique.
    Comme par exemple l'unit‚ C: correspond … 80h}
 DrivPhysUnit:Array[0..25]of Byte=(
  $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,
  $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,
  $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,
  $FF,$FF
 );

  { Unit‚ logique … lequel correspond une partition
     Bit 0,1:   Primaire (0 … 3)
     Bit 2:     0=Primaire/1=Logique
     Bit 3 … 7: Num‚ro logique (0 … 31)
    Si ‚gal … 255 non-d‚finie }
 DrivePartUnit:Array[0..25]of Byte=(
  $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,
  $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,
  $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,
  $FF,$FF
 );

Function FindFirstDskUnused:Byte;Var I:Byte;Begin
 FindFirstDskUnused:=$FF;
 For I:=0to 25do If Not DskExist(I)Then Begin
  FindFirstDskUnused:=I;
  Break;
 End;
End;

Type
  { IBM/MS Extensions disk address packet }
 DiskAddrIBMMSExtensionRec=Record
  Length:Byte;     { Longueur du paquet, dans ce cas si 10h }
  Reserved:Byte;   { Toujours 0 }
  Count:Word;      { Nombre de bloc … transf‚rer }
  Buffer:Pointer;  { Adresse du tampon de r‚ception }
  LoSector:LongInt;{ Num‚ro de secteur absolue o— il d‚bute la lecture (partie basse)}
  HiSector:LongInt;{ Num‚ro de secteur absolue o— il d‚bute la lecture (partie haute)}
 End;

 HPFSSuperBlockRec=Record
  ResA:Array[0..$B]of Byte;
  RootDirFNode:Long;         { Secteur o— se trouve le r‚pertoire racine }
  TotalSector:Long;          { Nombre total de secteurs dans la partition }
  ResB:Long;
  BitmapTable:Long;
  ResC:Array[$1C..511]of Byte;
 End;

Procedure ReadDskIBMMSExtension(Dsk:Byte;Sector:Long;Var Buffer);Assembler;
Var Q:DiskAddrIBMMSExtensionRec;
ASM
 MOV Word Ptr Q.Length,10h
 MOV Word Ptr Q.Count,1
 LES DI,Buffer
 MOV Word Ptr Q.Buffer[2],ES
 MOV Word Ptr Q.Buffer[0],DI
 LES AX,Sector
 MOV Word Ptr Q.LoSector[0],AX
 MOV Word Ptr Q.LoSector[2],ES
 XOR AX,AX
 MOV Word Ptr Q.HiSector[0],AX
 MOV Word Ptr Q.HiSector[2],AX
 MOV AH,43h
 MOV DL,Dsk
 PUSH DS
  PUSH SS
  POP DS
  MOV SI,Offset Q
  ADD SI,BP
  INT 13h
 POP DS
END;

Procedure DetectHPFS;
Var
 PartPrimary:PartSecType;
 PartLogical:PartSecType;
 BootRec:Array[0..511]of Byte;
 HPFSBoot:HPFSBootRec Absolute BootRec;
 HPFSSuperBlock:HPFSSuperBlockRec;
 J,I,K:Byte;
 Dsk:Byte;

 Procedure ReadBoot(Head:Byte;SectTrack:Word);
 Var Root:Array[0..511]of Char;
     J,Track:Word;
     NmHead,Sector:Byte;
 Begin
  ReadPartSec(K,Head,SectTrack,BootRec);
  If HPFSBoot.Sign='HPFS'Then Begin
   GetInfoHardDisk(K,Track,NmHead,Sector);
   Dsk:=FindFirstDskUnused;
   DriveFormat[Dsk]:=dfiHPFS;
   DrivPhysUnit[Dsk]:=K;
   DrivePartUnit[Dsk]:=I or 4+(J shl 3);
   WriteLn('HPFS Trouv‚ attribu‚ … l''unit‚ ',Char(Dsk+64),':');
   ReadPartSec(K,Head,SectTrack+16,HPFSSuperBlock);
   WriteLn('Taille de l''unit‚ ',Char(Dsk+64),': ',HPFSSuperBlock.TotalSector*512,' octets');
{   ReadPartSec(K,Head,SectTrack+HPFSSuperBlock.RootDirFNode,Root);}
   ReadDskIBMMSExtension(K,(NmHead*SectTrack+Head)*Sector+
                           HPFSSuperBlock.RootDirFNode,Root);
   For J:=0to 511do Mem[$B800:J shl 1]:=Byte(Root[J]);
  End;
 End;

Begin
 For K:=$80to $80+NmHardDsk do Begin
  ReadPartSec(K,0,1,PartPrimary);
  For I:=1to 4do Begin
   If PartPrimary.PartTable[I].PartType=5Then Begin
    ReadPartSec(K,PartPrimary.PartTable[I].StartSec.Head,
                  PartPrimary.PartTable[I].StartSec.SectTrack,PartLogical);
    For J:=1to 4do Begin
     If(PartLogical.PartTable[J].PartType)in[7,$17]Then Begin
      ReadBoot(PartLogical.PartTable[J].StartSec.Head,
               PartLogical.PartTable[J].StartSec.SectTrack);
     End;
    End;
   End
    Else
   If(PartPrimary.PartTable[J].PartType)in[7,$17]Then Begin
    ReadBoot(PartPrimary.PartTable[J].StartSec.Head,
             PartPrimary.PartTable[J].StartSec.SectTrack);
   End;
  End;
 End;
End;

BEGIN
 InitSystems(suIsabel);
 DetectHPFS;
END.