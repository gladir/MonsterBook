Program TestDithering;

Uses Adele,Systex,Systems,Video;

Const
 winsbackcolor = $00FF00;

Type TColor=LongInt;

Var
 R,G,B:Byte;
 I,J,K,Len:Integer;
 Kr:Byte;
 X:Word;
 ID:Real;
 Erreur:Word;
 LineBuffer:Array[0..15,0..799]of RGB;
 Buffer:Array[0..15,0..649]of Word Absolute LineBuffer;
 CA,CB,CC,CD:Byte;
 Spc:Word;
 N:Integer;

function  Mix(c1,c2:Tcolor;aspect:byte):Tcolor;
          var t : longint;     { longint  LLLL HHHH - bb gg rr 00 }
          begin
            asm
                     mov si,0
                     mov dl,aspect
                     mov dh,$FF
                     sub dh,dl
              @next: mov al,byte ptr [c1+si]
                     mul dh
                     mov cx,ax
                     mov al,byte ptr [c2+si]
                     mul dl
                     add ax,cx
                     mov byte ptr[t+si],ah
                     inc si
                     cmp si,3
                     jne @next
            end;
            mix:=t;
          end;

procedure ConvertColor(c:Tcolor;var Q:RGB);Begin
 Q.r:=(c shr 16) and $FF;
 Q.g:=(c shr  8) and $FF;
 Q.b:=(c shr  0) and $FF;
End;

Procedure SetColorLong(X:TColor);
Var
 Q:RGB;
Begin
 COnvertColor(X,Q);
 _SetKr(RGB2Color(Q.R,Q.G,Q.B));
End;

Const
{ Mask:Array[0..1]of Byte=($AA,$55);}
{Mask:Array[0..1]of Byte=($92,$24);}
 Mask:Array[0..1]of Long=($AA921000,$55240800);

Procedure Copy8Bin(X,Y:Word;Mask:Long;Fore,Back:Word);
Var
 I:Word;
Begin
 For I:=0to 31do Begin
  If Mask and 1=1Then Buffer[Y,X]:=Fore
                 Else Buffer[Y,X]:=Back;
  Mask:=Mask shr 1;
  Inc(X);
 End;
End;

Procedure MakeBanderolle;
Var
 I,J,K:Word;
 X,Y:Word;
Begin
 Y:=0;
 For J:=0to 7do For K:=0to 1do Begin
  X:=0;
  For I:=0to 39do Begin
   Copy8Bin(X,Y,Mask[K],RGB2Color(0,0,$40+(I shl 3)),RGB2Color(0,0,$48+(I shl 3)));
   Inc(X,32);
  End;
  ClrLnHorImg(0,Y,640,BitsPerPixel,Buffer[Y,0]);
  Inc(Y);
 End;
End;

BEGIN
 InitSystems(suIsabel);
 SetVideoModeDeluxe(vmGrf640x480c65536);
 Len:=GetNumXPixels;
 Kr:=$1;
 ID:=$80/Len;
 R:=DefaultRGB[Kr].R and$7F;
 G:=DefaultRGB[Kr].G and$7F;
 B:=DefaultRGB[Kr].B and$7F;
 For J:=0to 15do For I:=0to Len-1do Begin
{  n:=(integer(LineBuffer[J,i].g)*59+
     integer(LineBuffer[J,i].b)*11+
     integer(LineBuffer[J,i].r)*30)div 100;
  LineBuffer[J,i].r:=(n+2*( winsbackcolor shr 16)) div 3;
  LineBuffer[J,i].g:=(n+2*((winsbackcolor shr 8)and 255)) div 3;
  LineBuffer[J,i].b:=(n+2*( winsbackcolor and 255)) div 3;}
  X:=Trunc(I*ID);
  LineBuffer[J,I].R:=R+X;
  LineBuffer[J,I].G:=G+X;
  LineBuffer[J,I].B:=B+X;
 End;
(* for i:=0 to GetMaxXPixels do begin
  SetColorLong(mix({c1}$FFFF,{c2}$000000,round((i)/GetMaxXPixels*255)));
  _ln(i,0,i,100);
 End;*)
{ For J:=0to 15do For I:=0to(GetMaxXPixels)do Begin
  SetPixel(I,J,RGB2Color(LineBuffer[J,I].R,LineBuffer[J,I].G,LineBuffer[J,I].B));
 End;}
 MakeBanderolle;
 ReadKey;
(* Erreur:=8;
 CA:=(7*Erreur)shr 4;
 CB:=(3*Erreur)shr 4;
 CC:=(5*Erreur)shr 4;
 CD:=(1*Erreur)shr 4;
 Spc:=3;
 For K:=0to 7do Begin
  For J:=1to 14do For I:=10to GetMaxXPixels-10do Begin
   LineBuffer[J,I+1*Spc].B:=(LineBuffer[J,I+1*Spc].B+CA){and$7F};
   LineBuffer[J+1,I-1*Spc].B:=(LineBuffer[J+1,I-1*Spc].B+CB){and$7F};
   LineBuffer[J+1,I].B:=(LineBuffer[J+1,I].B+CC){and$7F};
   LineBuffer[J+1,I+1*Spc].B:=(LineBuffer[J+1,I+1*Spc].B+CD){and$7F};
  End;
  For J:=0to 15do For I:=0to(GetMaxXPixels)do Begin
   SetPixel(I,J,RGB2Color(LineBuffer[J,I].R,LineBuffer[J,I].G,LineBuffer[J,I].B));
  End;
  ReadKey;
 End;*)
END.