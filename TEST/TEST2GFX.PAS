Uses Adele,Systex,Systems,Video,Mouse;

Const HeaderGPX:Record
 Sign:Array[0..3]of Char;
 Len,Height,Ln:Word;
 BitsPerPixel:Byte;
End
 =
(Sign:'GPX'#26;
 Len:32;
 Height:24;
 Ln:4;
 BitsPerPixel:1
 );

Var S:String;I,J:Byte;
    Buffer:Array[0..32*4-1]of Byte;
    Handle:Hdl;

BEGIN
 InitSystems(suIsabel);
 CheckSVGA:=Ya;
 SetVideoModeDeluxe(vmGrf1024x768c256);
 __InitMouse;
 If Not LoadQQF('glyphs 24')Then Halt(1);
 WriteLn('Ok');
 S[I]:=Char(103-64);
 For I:=64to 103do S[I-63]:=Chr(I);
 OutTextXY(0,0,S {#100},$F);
 ReadKey;
{ FillClr(Buffer,SizeOf(Buffer));
 For I:=0to 31do For J:=0to 7do Begin
  Buffer[I]:=Buffer[I]or (Byte(GetPixel(I,7-J)=$F)shl J);
  Buffer[I+32]:=Buffer[I+32]or (Byte(GetPixel(I,8+7-J)=$F)shl J);
  Buffer[I+64]:=Buffer[I+64]or (Byte(GetPixel(I,16+7-J)=$F)shl J);
  Buffer[I+96]:=Buffer[I+96]or (Byte(GetPixel(I,24+7-J)=$F)shl J);
 End;
 DelFile('DEAD.GPX');
 Handle:=New('DEAD.GPX');
 _SetAbsRec(Handle,0,SizeOf(HeaderGPX),HeaderGPX);
 _SetAbsRec(Handle,SizeOf(HeaderGPX),SizeOf(Buffer),Buffer);
 FillClr(Buffer,SizeOf(Buffer));
 For I:=0to 31do For J:=0to 7do Begin
  Buffer[I*4]:=Buffer[I*4]or (Byte(GetPixel(7-J,I)=$F)shl J);
  Buffer[I*4+1]:=Buffer[I*4+1]or (Byte(GetPixel(8+7-J,I)=$F)shl J);
  Buffer[I*4+2]:=Buffer[I*4+2]or (Byte(GetPixel(16+7-J,I)=$F)shl J);
  Buffer[I*4+3]:=Buffer[I*4+3]or (Byte(GetPixel(24+7-J,I)=$F)shl J);
 End;
 _SetAbsRec(Handle,SizeOf(HeaderGPX)+SizeOf(Buffer),SizeOf(Buffer),Buffer);
 Close(Handle);}
END.