Uses Dos;

{$I Library\Disk\IDE.Inc}

Var
 IdeDrives:Array[0..3]of IdeDriveInfo;
 OldIrq14,OldIrq15:Pointer;
 _InterruptOccured:Word;

Procedure NSleep(Millisecond:Word);Begin
End;

Procedure Irq14;Interrupt;Begin
 ASM
  OR _InterruptOccured,04000h;
 END;
 Port[$A0]:=$20;
 NSleep(1000);
 Port[$20]:=$20;
End;

Procedure Irq15;Interrupt;Begin
 ASM
  OR _InterruptOccured,08000h
 END;
 Port[$A0]:=$20;
 NSleep(1000);
 Port[$20]:=$20;
End;

(*Function ataPoll(driveinfo *Drive, u16 Timeout, u8 Mask, u8 Want):Integer;
Var
 Stat:Byte;
 Time:Word;
Begin
 Stat:=0;
 For Time:=Timeout downto 0do Begin
  Stat=Port[Drive->IOAdr + ATA_REG_STAT);

		if((Stat & Mask) == Want)

			break;

		delay(1); }

	DEBUG(printf("[waited for %3u ms]", Timeout - Time);)

	if(Time != 0)

		return(0);

	DEBUG(

	printf("bad status (0x%02X)\n", Stat);

	if(Stat & 1)

	{	printf("error code 0x%02X\n",

			in(Drive->IOAdr + ATA_REG_ERR)); }

	)

	return(-1); }*)

Procedure ataProbe;
Label NO_DRIVES;
Var
 WhichDrive,Byte1,Byte2:Byte;
 Drive:Byte;
Begin
 WriteLn('ataProbe');
  { Fixe les valeurs initial }
 IdeDrives[0].DrvSel:=$A0;
 IdeDrives[2].DrvSel:=$A0;
 IdeDrives[1].DrvSel:=$B0;
 IdeDrives[3].DrvSel:=$B0;
 IdeDrives[0].IOAdr:=$1F0;
 IdeDrives[1].IOAdr:=$1F0;
 IdeDrives[2].IOAdr:=$170;
 IdeDrives[3].IOAdr:=$170;
 For WhichDrive:=0to 1do Begin
  Drive:=WhichDrive shl 1;
   { poke interface }
  WriteLn('  poking interface ',IdeDrives[Drive].IOAdr);
  Port[IdeDrives[Drive].IOAdr+ideAtaRegCnt]:=$55;
  Port[IdeDrives[Drive].IOAdr+ideAtaRegSect]:=$AA;
  Byte1:=Port[IdeDrives[Drive].IOAdr+ideAtaRegCnt];
  Byte2:=Port[IdeDrives[Drive].IOAdr+ideAtaRegSect];
   { nothing there }
  If(Byte1<>$55)or(Byte2<>$AA)Then Begin
NO_DRIVES:
   IdeDrives[0].IOAdr:=0;
   IdeDrives[1].IOAdr:=0;
   Continue;
  End;
   { soft reset both drives on this I/F (selects master) }
   WriteLn('  found something on I/F ',IdeDrives[Drive].IOAdr,'doing soft reset...');
   Port[IdeDrives[Drive].IOAdr+ideAtaRegSLCT]:=$06;
   nsleep(400);
    { release soft reset AND enable interrupts from drive }
   Port[IdeDrives[Drive].IOAdr+ideAtaRegSLCT]:=$00;
   nsleep(400);
   { wait up to 2 seconds for drive status:
    BSY=0  DRDY=1  DF=? DSC=?  DRQ=?  CORR=?  IDX=?  ERR=0 }
(*   If(ataPoll(Drive, 2000, 0xC1, 0x40) <> 0)Then

		{	DEBUG(printf("  no master on I/F 0x%03X\n",

				Drive->IOAdr);)

			goto NO_DRIVES; }

/* identify master */

		printf("  hd%1u (0x%03X, master): ", WhichDrive,

			Drive->IOAdr);

		ataIdentify(Drive);

/* select slave */

		if(ataSelect(Drive + 1) != 0)

/* no slave; continue */

		{	DEBUG(printf(" no slave on I/F 0x%03X\n",

				Drive->IOAdr);)

			Drive[1].IOAdr=0;

			continue; }

/* identify slave */

		printf("  hd%1u (0x%03X,  slave): ", WhichDrive + 1,

			Drive->IOAdr);

		ataIdentify(Drive + 1); }}*)
End;
End;

BEGIN
 GetIntVec($76,OldIrq14);
 SetIntVec($76,@Irq14);
 GetIntVec($77,OldIrq15);
 SetIntVec($77,@Irq15);
  { Active l'IRQ14 et IRQ15 sur la deuxiäme puce PIC 8259 }
 Port[$A1]:=Port[$A1]and (Not $C0);
  {srand(time(NULL));}
 ataProbe;
END.