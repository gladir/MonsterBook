{ Cette unit‚ est utilis‚e afin d'offrir les services du systŠme
 d'exploitation DOS ou compatible.
}

Unit DOS;

INTERFACE

Const
  {Attribut de fichier FAT }
 ReadOnly=$01;          { Lecture seulement }
 Hidden=$02;            { Cach‚ }
 SysFile=$04;           { SystŠme }
 VolumeID=$08;          { Volume }
 Directory=$10;         { R‚pertoire }
 Archive=$20;           { Archive }
 AnyFile=$3F;           { Toutes les sortes de fichiers }

  {Cette variable contient le code d'erreur que retourne le systŠme
  d'exploitation DOS}
 DosError:Word=0;

Type
 SearchRec=Record
  Fill:Array[1..21]of Byte;
  Attr:Byte;
  Time:Longint;
  Size:Longint;
  Name:Array[0..12]of Char;
 End;

Procedure FindFirst(Path:PChar;Attr:Word;Var F:SearchRec);
Procedure FindNext(Var F:SearchRec);
Procedure SetIntVec(IntNo:Byte;Vector:Pointer);

IMPLEMENTATION

{ Cette proc‚dure recherche la premiŠre occurence d'une liste de fichiers.
}

Procedure FindFirst(Path:PChar;Attr:Word;Var F:SearchRec);Assembler;ASM
 PUSH DS
  LDS DX,F
  MOV AH,1Ah
  INT 21h
  LDS DX,Path
  MOV AH,4Eh
  MOV CX,Attr
  INT 21h
 POP DS
 JC  @End
 XOR AX,AX
@End:
 MOV DosError,AX
END;

{ Cette proc‚dure recherche les occurences suivantes d'une liste de
 fichiers.
}

Procedure FindNext(Var F:SearchRec);Assembler;ASM
 PUSH DS
  LDS DX,F
  MOV AH,1Ah
  INT 21h
 POP DS
 MOV AH,4FH
 INT 21h
 JC  @End
 XOR AX,AX
@@1:
 MOV DosError,AX
END;

Procedure SetIntVec(IntNo:Byte;Vector:Pointer);Assembler;ASM
 PUSH DS
  LDS DX,Vector
  MOV AL,IntNo
  MOV AH,25H
  INT 21H
 POP DS
END;

END.