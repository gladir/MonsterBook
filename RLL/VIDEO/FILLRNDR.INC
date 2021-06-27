{FillRndR.Inc}

{Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet d'effectuer un carr‚ plein avec les coins
 en rond.
}

{$F-}
{$I \Source\Chantal\Library\MulL.Inc}
{$F+}

Procedure PutFillRoundRect(x1,y1,x2,y2,b,Kr:Int);Var a,xr,yr,x,j,y,xN,yN:Int;AO,BO,AO2,BO2,AO4,BO4,d:Long;Begin
 y:=y1;y1:=y2;y2:=y;yr:=b;xr:=b;xN:=x1+xr;yN:=y1-yr;
 If Not(y2+b>=yN)Then PutFillBox(x1,y2+b,x2,yN,Kr);
 a:=b;BO:=b*b;AO:=a*a;y:=b;x:=0;
 ASM
   {AO2:=AO shl 1}
  {$IFDEF __386__}
   DB 66h;MOV AX,Word Ptr AO
   DB 66h;SHL AX,1
   DB 66h;MOV Word Ptr AO2,AX
  {$ELSE}
   LES AX,AO
   MOV DX,ES
   SHL AX,1
   RCL DX,1
   MOV Word Ptr AO2,AX
   MOV Word Ptr AO2[2],DX
  {$ENDIF}
   {AO4:=AO shl 2;}
  {$IFDEF __386__}
   DB 66h;SHL AX,1
   DB 66h;MOV Word Ptr AO4,AX
  {$ELSE}
   SHL AX,1
   RCL DX,1
   MOV Word Ptr AO4,AX
   MOV Word Ptr AO4[2],DX
  {$ENDIF}
   {BO2:=BO shl 1;}
  {$IFDEF __386__}
   DB 66h;MOV AX,Word Ptr BO
   DB 66h;SHL AX,1
   DB 66h;MOV Word Ptr BO2,AX
  {$ELSE}
   LES AX,BO
   MOV DX,ES
   SHL AX,1
   RCL DX,1
   MOV Word Ptr BO2,AX
   MOV Word Ptr BO2[2],DX
  {$ENDIF}
   {BO4:=BO shl 2;}
  {$IFDEF __386__}
   DB 66h;SHL AX,1
   DB 66h;MOV Word Ptr BO4,AX
  {$ELSE}
   SHL AX,1
   RCL DX,1
   MOV Word Ptr BO4,AX
   MOV Word Ptr BO4[2],DX
  {$ENDIF}
 END;
 {$IFDEF __386__}
  ASM
   MOV AX,Y
   DEC AX
   MUL Y
   DB ciPushDX,ciPushAX
   DW ciPopEAX
   DB 66h;IMUL Word Ptr AO2
   DB 66h;MOV BX,AX
   DB 66h;XOR AX,AX;INC AX
   DB 66h;SUB AX,Word Ptr AO
   DB 66h;DEC AX
   DB 66h;IMUL Word Ptr BO2
   DB 66h;ADD AX,BX
   DB 66h;ADD AX,Word Ptr AO
   DB 66h;MOV Word Ptr d,AX
  END;
 {$ELSE}
  d:=MulL(AO2,(y-1)*y)+AO+MulL(BO2,1-AO);
 {$ENDIF}
 While(MulL(AO,y)>MulL(BO,x))do Begin
  PutLnHor(xN-y,yN+x,x2-yr+y,Kr);
  PutLnHor(xN-y,y2+xr-x,x2-yr+y,Kr);
  If d>=0Then Begin;Dec(y);Dec(d,MulL(AO4,y))End;
  {$IFDEF __386__}
   ASM
    DB 66h;XOR AX,AX
    DB 66h;XOR BX,BX
    MOV AL,3
    MOV BX,X
    DB 66h;SHL BX,1
    DB 66h;ADD AX,BX
    DB 66h;IMUL Word Ptr BO2
    DB 66h;ADD Word Ptr D,AX
   END;
  {$ELSE}
   Inc(d,MulL(BO2,3+(x shl 1)));
  {$ENDIF}
  Inc(x);
 End;
 d:=MulL(BO2,(x+1)*x)+MulL(AO2,y*(y-2)+1)+MulL(1-AO2,BO);
 While y<>0do Begin
  PutLnHor(xN-y,x+yN,x2-yr+y,Kr);
  PutLnHor(xN-y,y2+xr-x,x2-yr+y,Kr);
  if d<=0Then Begin;Inc(x);Inc(d,MulL(BO4,x))End;
  Dec(y);
  {$IFDEF __386__}
   ASM
    DB 66h;XOR AX,AX
    DB 66h;XOR BX,BX
    MOV AL,3
    MOV BX,Y
    DB 66h;SHL BX,1
    DB 66h;SUB AX,BX
    DB 66h;IMUL Word Ptr AO2
    DB 66h;ADD Word Ptr D,AX
   END;
  {$ELSE}
   Inc(d,MulL(AO2,3-(y shl 1)));
  {$ENDIF}
 End;
End;