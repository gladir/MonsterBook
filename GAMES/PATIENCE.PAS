Program Patience;

Uses Adele,Systex,Systems,Video,Mouse;

Procedure Play;
Const HomeX=4; HomeY=5;
      CardImg:Array[0..52,0..4]of String[5]=(
      ('     ',
       '     ',
       '     ',
       '     ',
       '     '),
      ('A    ',
       '     ',
       '  '#3'  ',
       '     ',
       '    A'),
      ('2 '#3'  ',
       #3'    ',
       '     ',
       '    '#3,
       '  '#3' 2'),
      ('3 '#3'  ',
       #3'    ',
       '  '#3'  ',
       '    '#3,
       '  '#3' 3'),
      ('4    ',
       ' '#3' '#3' ',
       '     ',
       ' '#3' '#3' ',
       '    4'),
      ('5    ',
       ' '#3' '#3' ',
       '  '#3'  ',
       ' '#3' '#3' ',
       '    5'),
      ('6    ',
       ' '#3' '#3' ',
       ' '#3' '#3' ',
       ' '#3' '#3' ',
       '    6'),
      ('7    ',
       ' '#3' '#3' ',
       ' '#3#3#3' ',
       ' '#3' '#3' ',
       '    7'),
      ('8    ',
       ' '#3#3#3' ',
       ' '#3#3#3' ',
       ' '#3' '#3' ',
       '    8'),
      ('9    ',
       ' '#3#3#3' ',
       ' '#3#3#3' ',
       ' '#3#3#3' ',
       '    9'),
      ('10   ',
       #3#3#3#3#3,
       '     ',
       #3#3#3#3#3,
       '   10'),
      ('J    ',
       #3'ллл ',
       ' ллл ',
       ' ллл'#3,
       '    J'),
      ('Q    ',
       #3'ллл ',
       ' ллл ',
       ' ллл'#3,
       '    Q'),
      ('K    ',
       #3'ллл ',
       ' ллл ',
       ' ллл'#3,
       '    K'),
      ('A    ',
       '     ',
       '  '#6'  ',
       '     ',
       '    A'),
      ('2 '#6'  ',
       #6'    ',
       '     ',
       '    '#6,
       '  '#6' 2'),
      ('3 '#6'  ',
       #6'    ',
       '  '#6'  ',
       '    '#6,
       '  '#6' 3'),
      ('4    ',
       ' '#6' '#6' ',
       '     ',
       ' '#6' '#6' ',
       '    4'),
      ('5    ',
       ' '#6' '#6' ',
       '  '#6'  ',
       ' '#6' '#6' ',
       '    5'),
      ('6    ',
       ' '#6' '#6' ',
       ' '#6' '#6' ',
       ' '#6' '#6' ',
       '    6'),
      ('7    ',
       ' '#6' '#6' ',
       ' '#6#6#6' ',
       ' '#6' '#6' ',
       '    7'),
      ('8    ',
       ' '#6#6#6' ',
       ' '#6#6#6' ',
       ' '#6' '#6' ',
       '    8'),
      ('9    ',
       ' '#6#6#6' ',
       ' '#6#6#6' ',
       ' '#6#6#6' ',
       '    9'),
      ('10   ',
       #6#6#6#6#6,
       '     ',
       #6#6#6#6#6,
       '   10'),
      ('J    ',
       #6'ллл ',
       ' ллл ',
       ' ллл'#6,
       '    J'),
      ('Q    ',
       #6'ллл ',
       ' ллл ',
       ' ллл'#6,
       '    Q'),
      ('K    ',
       #6'ллл ',
       ' ллл ',
       ' ллл'#6,
       '    K'),
      ('A    ',
       '     ',
       '  '#4'  ',
       '     ',
       '    A'),
      ('2 '#4'  ',
       #4'    ',
       '     ',
       '    '#4,
       '  '#4' 2'),
      ('3 '#4'  ',
       #4'    ',
       '  '#4'  ',
       '    '#4,
       '  '#4' 3'),
      ('4    ',
       ' '#4' '#4' ',
       '     ',
       ' '#4' '#4' ',
       '    4'),
      ('5    ',
       ' '#4' '#4' ',
       '  '#4'  ',
       ' '#4' '#4' ',
       '    5'),
      ('6    ',
       ' '#4' '#4' ',
       ' '#4' '#4' ',
       ' '#4' '#4' ',
       '    6'),
      ('7    ',
       ' '#4' '#4' ',
       ' '#4#4#4' ',
       ' '#4' '#4' ',
       '    7'),
      ('8    ',
       ' '#4#4#4' ',
       ' '#4#4#4' ',
       ' '#4' '#4' ',
       '    8'),
      ('9    ',
       ' '#4#4#4' ',
       ' '#4#4#4' ',
       ' '#4#4#4' ',
       '    9'),
      ('10   ',
       #4#4#4#4#4,
       '     ',
       #4#4#4#4#4,
       '   10'),
      ('J    ',
       #4'ллл ',
       ' ллл ',
       ' ллл'#4,
       '    J'),
      ('Q    ',
       #4'ллл ',
       ' ллл ',
       ' ллл'#4,
       '    Q'),
      ('K    ',
       #4'ллл ',
       ' ллл ',
       ' ллл'#4,
       '    K'),
      ('A    ',
       '     ',
       '  '#5'  ',
       '     ',
       '    A'),
      ('2 '#5'  ',
       #5'    ',
       '     ',
       '    '#5,
       '  '#5' 2'),
      ('3 '#5'  ',
       #5'    ',
       '  '#5'  ',
       '    '#5,
       '  '#5' 3'),
      ('4    ',
       ' '#5' '#5' ',
       '     ',
       ' '#5' '#5' ',
       '    4'),
      ('5    ',
       ' '#5' '#5' ',
       '  '#5'  ',
       ' '#5' '#5' ',
       '    5'),
      ('6    ',
       ' '#5' '#5' ',
       ' '#5' '#5' ',
       ' '#5' '#5' ',
       '    6'),
      ('7    ',
       ' '#5' '#5' ',
       ' '#5#5#5' ',
       ' '#5' '#5' ',
       '    7'),
      ('8    ',
       ' '#5#5#5' ',
       ' '#5#5#5' ',
       ' '#5' '#5' ',
       '    8'),
      ('9    ',
       ' '#5#5#5' ',
       ' '#5#5#5' ',
       ' '#5#5#5' ',
       '    9'),
      ('10   ',
       #5#5#5#5#5,
       '     ',
       #5#5#5#5#5,
       '   10'),
      ('J    ',
       #5'ллл ',
       ' ллл ',
       ' ллл'#5,
       '    J'),
      ('Q    ',
       #5'ллл ',
       ' ллл ',
       ' ллл'#5,
       '    Q'),
      ('K    ',
       #5'ллл ',
       ' ллл ',
       ' ллл'#5,
       '    K'));
    BackKr=$2B;
Var Card:String[52]; H,I,J,Y,StackPos:Byte; Stack4:Array[0..3,0..2]of Byte;
Bank4:Array[0..3,0..13]of Byte;Stack:Array[0..39]of Byte;K:Wd;B:Wd;MX,MY:Byte;

 Function XtrkCard:Byte;Var R:Byte;Begin
  R:=Random(Length(Card))+1; XtrkCard:=Byte(Card[R]);DelChrAt(Card,R);
 End;

 Procedure PutCard(X,Y:Byte;Card:Byte);Var J,Kr:Byte;Begin
  If Card>52Then Begin Card:=0; Kr:=$10;End Else
  If Card=0Then Kr:=BackKr Else
  If Card in[1..13,27..39]Then Kr:=$FC Else Kr:=$F0;
  For J:=0to 4do PutTxtXY(HomeX+X,HomeY+Y+J,CardImg[Card,J],Kr);
 End;

 Function Sort(Card:Byte):Byte;Begin
  If Card=0Then Sort:=$FF Else Sort:=(Card-1)div 13;
 End;

 Function Num(Card:Byte):Byte;Begin
  If Card=0Then Num:=$FF Else Num:=(Card-1)mod 13;
 End;

 Procedure UpDateStack4;Begin
  Stack4[Y,I]:=0;
  If I>0Then Dec(I);
  PutCard(2,Y*6,Stack4[Y,I]);
 End;

 Procedure Stack42Bank4;Var H:Byte;Begin
  H:=0; While Bank4[J,H]<>0do Inc(H);
  Bank4[J,H]:=Stack4[Y,I];
  PutCard(10+H*4,J*6,Bank4[J,H]);
  UpdateStack4;
 End;

 Procedure UpdateStack;Var I,J:Byte;Begin
  If StackPos<3Then J:=0 Else J:=StackPos-3;
  For I:=0to 2do PutCard(27+I shl 2,25,Stack[J+I]);
  If I<2Then ClrWn(HomeX+28+(I+1)shl 2,HomeY+25,79,HomeY+30,BackKr);
 End;

 Procedure Stack2Bank4;Var H:Byte;Begin
  H:=0; While Bank4[J,H]<>0do Inc(H);
  Bank4[J,H]:=Stack[I];
  StrDel(@Stack,I,1);
  PutCard(10+H*4,J*6,Bank4[J,H]);
  If StackPos>0Then Dec(StackPos);
  UpdateStack;
 End;

Begin
 Card[0]:=#52; For I:=1to 52do Card[I]:=Char(I);
 For J:=0to 2do For I:=0to 3do Stack4[I,J]:=XtrkCard;
 FillClr(Bank4,SizeOf(Bank4)); Bank4[0,0]:=XtrkCard;
 StackPos:=0; For I:=0to 38do Stack[I]:=XtrkCard; Stack[39]:=0;
 PutTxtCenter(0,__Justified__,'Aux Cartes - La Patience',$F);
 ClrWn(0,2,MaxXTxts,MaxYTxts-7,BackKr);
 For I:=0to 3do Begin
  SetCube(HomeX,HomeY+2+I*6,Chr(I+49),BackKr);
  PutCard(2,I*6,Stack4[I,2]);
 End;
 PutCard(10,0,Bank4[0,0]);
 PutCard(20,25,$FF);
 For I:=0to 1do SetCube(HomeX+22+I*7,HomeY+32,Chr(I+53),BackKr);
 Repeat
  __ShowMousePtr;
  Repeat
   __GetMouseTextSwitch(MX,MY,B);
   If B>0Then Begin
    Repeat Until __GetMouseButton=0;
    If(HomeX+2<=MX)and(HomeX+6>=MX)Then Begin
     If(MY>=HomeY)and(MY<=HomeY+5)Then PushKey(Byte('1'));
     If(MY+6>=HomeY)and(MY<=HomeY+11)Then PushKey(Byte('2'));
     If(MY+12>=HomeY)and(MY<=HomeY+17)Then PushKey(Byte('3'));
     If(MY+18>=HomeY)and(MY<=HomeY+23)Then PushKey(Byte('4'));
    End
     Else
    If(HomeX+20<=MX)and(HomeX+24>=MX)and
      (HomeY+25<=MY)and(HomeY+29>=MY)Then PushKey(Byte('5'))
     Else
    If(HomeX+27<=MX)and(HomeX+31+8>=MX)and
      (HomeY+25<=MY)and(HomeY+29>=MY)Then PushKey(Byte('6'));
   End;
  Until KeyPress;
  __HideMousePtr;
  K:=ReadKey;
  Case Chr(K)of
   '1'..'4':Begin
    Y:=Byte(K)-49;
    For I:=2downto 0do If Stack4[Y,I]<>0Then Break;
    If Stack4[Y,I]<>0Then Begin
    If Num(Stack4[Y,I])=Num(Bank4[0,0])Then Begin
     For J:=0to 3do If Bank4[J,0]=0Then Begin
      Bank4[J,0]:=Stack4[Y,I];
      PutCard(10,J*6,Bank4[J,0]);
      UpdateStack4;
      Break;
     End;
    End
     Else
    Begin
     For J:=0to 3do If Sort(Bank4[J,0])=Sort(Stack4[Y,I])Then Begin
      If J=0Then Stack42Bank4 Else
      For H:=0to 12do If Num(Bank4[J-1,H])=Num(Stack4[Y,I])Then Begin
       Stack42Bank4;
       Break;
      End;
     End;
    End;
    End;
   End;
   '5':Begin
    If Stack[StackPos]=0Then StackPos:=0;
    For I:=0to 2do Begin
     If Stack[StackPos]=0Then Break;
     PutCard(27+I shl 2,25,Stack[StackPos]);
     Inc(StackPos);
    End;
    If I<2Then ClrWn(HomeX+28+(I+1)shl 2,HomeY+25,79,HomeY+30,7);
   End;
   '6':Begin
    I:=StackPos;
    If I>0Then Dec(I);
    If Stack[I]<>0Then Begin
    If Num(Stack[I])=Num(Bank4[0,0])Then Begin
     For J:=0to 3do If Bank4[J,0]=0Then Begin
      Bank4[J,0]:=Stack[I];
      StrDel(@Stack,I,1);
      PutCard(10,J*6,Bank4[J,0]);
      If StackPos>0Then Dec(StackPos);
      UpdateStack;
      Break;
     End;
    End
     Else
    Begin
     For J:=0to 3do If Sort(Bank4[J,0])=Sort(Stack[I])Then Begin
      If J=0Then Stack2Bank4 Else
      For H:=0to 12do If Num(Bank4[J-1,H])=Num(Stack[I])Then Begin
       Stack2Bank4;
       Break;
      End;
     End;
    End;
    End;
   End;
  End;
  If(Bank4[0,12]>0)and(Bank4[1,12]>0)and(Bank4[2,12]>0)and(Bank4[3,12]>0)Then Begin
   PutTxtCenter(24,__Justified__,'Vous avez gagnez!!!!!!!!',$E0);
   Break;
  End;
 Until K=kbEsc;
End;

BEGIN
 InitSystems(suIsabel);
 Randomize;
 SetVideoMode(vmTxtC80x50);
 SetBlink(No);
 __InitMouse;
 Play;
 DoneSystems;
END.