Uses Systems;

Type
LExtendedFreeSpace=Record
 SizeOfReturnedStructure:Word;
 StructureVersion:Word;
 NumberOfSectorsPerCluster:LongInt;
 NumberOfBytesPerSector:LongInt;
 NumberOfAvailableClusters:LongInt;
 TotalNumberOfClustersOnTheDrive:LongInt;
 NumberOfPhysicalSectorsAvailableOnTheDrive:LongInt;
 TotalNumberOfPhysicalSectorsOnTheDrive:LongInt;
 NumberOfAvailableAllocationUnits:LongInt;
 TotalAllocationUnits:LongInt;
 Reserved:Array[0..7]of Byte;
End;

Function LDiskFree(Drive:PChar):Real;
Label Error;
Var
 ExtendedFreeSpace:LExtendedFreeSpace;
Begin
 FillClr(ExtendedFreeSpace,SizeOf(ExtendedFreeSpace));
 ASM
  PUSH DS
   MOV AX,7303h
   LDS DX,Drive
   PUSH SS
   POP ES
   MOV DI,Offset ExtendedFreeSpace
   ADD DI,BP
   MOV CX,TYPE ExtendedFreeSpace
   INT 21h
  POP DS
  JC  Error
 END;
 LDiskFree:=1.0*ExtendedFreeSpace.NumberOfSectorsPerCluster*
            ExtendedFreeSpace.NumberOfBytesPerSector*
            ExtendedFreeSpace.NumberOfAvailableClusters;
 Exit;
Error:
 ASM
  MOV SysErr,AX
 END;
 LDiskFree:=-1;
End;


BEGIN
 WriteLn(LDiskFree('C:\'):16:0);
END.