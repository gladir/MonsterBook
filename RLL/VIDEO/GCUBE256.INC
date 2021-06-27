{GCube256.Inc}

Procedure SetGCube;
Var
 I,M,F,B:Byte;
 PB:^Byte;
Begin
 ASM
  MOV AL,DataVideo.MIV.HeightChar
  DEC AL
  MOV M,AL
 END;
 F:=Attr and$F;B:=Attr shr 4;
 If(Chr in[#0,' ',#255])or(F=B)Then PutFillBox(X,Y,X+7,Y+M,B)
  Else
 Begin
  ASM
   LES DI,DataVideo.MIV.TxtMtx
   MOV Word Ptr PB[2],ES
   {$IFDEF __386__}
    DB 36h,0Fh,0B6h,05Eh,08h { MOVZX BX,Byte Ptr SS:[BP+08h] }
   {$ELSE}
    MOV BL,Chr
    XOR BH,BH
   {$ENDIF}
   SHL BX,1
   ADD DI,Word Ptr RawY[BX]
   MOV Word Ptr PB,DI
  END;
  For I:=0to(M)do Begin
   Copy8Bin(X,Y,PB^,B,F);
   Inc(Y);Inc(Word(PB))
  End;
 End;
End;