{PutRndRe.Inc}

{Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet d'effectuer un carr‚ vide avec les coins
 en rond.
}

{$F-}
{$I \Source\Chantal\Library\MulL.Inc}
{$F+}

Procedure PutRoundRect(x1,y1,x2,y2,LineWidth,b,Kr:Int);Var a,xr,yr,x,i,j,y,xN,yN:Int;AO,BO,AO2,BO2,AO4,BO4,d:LongInt;Begin
 If LineWidth>0Then Dec(LineWidth);
 y:=y1;y1:=y2;y2:=y;yr:=b;xr:=b;xN:=x2-xr;yN:=y2+yr;
 For j:=-(LineWidth shr 1)to LineWidth shr 1+(LineWidth and 1)do Begin
  PutLnHor(x1+xr,y1-j,xN,Kr);
  PutLnHor(x1+xr,y2-j,xN,Kr);
 End;
 For j:=-(LineWidth shr 1)to LineWidth shr 1+(LineWidth and 1)do Begin
  For i:=y1-yr downto(yN)do Begin;SetPixel(x1+j,i,Kr);SetPixel(x2+j,i,Kr)End;
 End;
 Dec(b,LineWidth shr 1);a:=b;
 For i:=0to(LineWidth)do Begin
  BO:=b*b;AO:=a*a;y:=b;x:=0;
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
   SetPixel(x+xN,yN-y,Kr);SetPixel(x+xN,y1-yr+y,Kr);
   SetPixel(x1+xr-x,yN-y,Kr);SetPixel(x1+xr-x,y1-yr+y,Kr);
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
   SetPixel(x+xN,yN-y,Kr);SetPixel(x+xN,y1-yr+y,Kr);
   SetPixel(x1+xr-x,yN-y,Kr);SetPixel(x1+xr-x,y1-yr+y,Kr);
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
  Inc(b);Inc(a)
 End;
End;