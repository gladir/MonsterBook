Var
 I,CRD:Integer;
 PNPRes:Array[0..1023]of Byte;
 X:Byte;

BEGIN
 port[$279]:=2;
 port[$a79]:=2;
 asm
   mov dx,0279h
   mov al,0
   out dx,al
   out dx,al

   mov cx,32
   mov al,06ah

 @next:
   mov bh,al
   mov bl,al
   shr bl,1
   and bl,1
   and bh,1
   xor bh,bl
   {$IFOPT G+}
    shl bh,7
   {$ELSE}
    SHL BH,1
    SHL BH,1
    SHL BH,1
    SHL BH,1
    SHL BH,1
    SHL BH,1
    SHL BH,1
   {$ENDIF}
   out dx,al
   shr al,1
   or al,bh
   loop @next
 end;

 for crd:=1 to {pnpisa.csns}1 do begin
   port[$279]:=3; { wake command reg }
   port[$a79]:=crd; {CSN #... }

   For I:=$20to $2F do Begin
    Port[$279]:=I;
    X:=port[$20B];
    Write(X);
   End;

   for i:=0 to 1023 do
   begin
     port[$279]:=5;
     repeat until port[{pnpisa.isaport}$20B] and 1=1;
     port[$279]:=4;
     pnpres[i]:=port[{pnpisa.isaport}$20B];
   end;

  End;
END.