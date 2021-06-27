{\Source\Chantal\Library\Security\MonsterB.ook\Serial.Inc}

Function GetSerialUser(Const Name:String):String;
Var
 I:Byte;    { Compteur de boucle }
 ST:String; { Chaåne de caractäres temporaire }
Begin
 ST:='';
 For I:=1to 4do Begin
  If(Length(Name)<I)Then AddStr(ST,'00')
  Else AddStr(ST,HexByte2Str(Not(Byte(ChrUp(Name[I])))));
 End;
 For I:=1to 8do If ST[I]>='A'Then Dec(Byte(ST[I]),17);
 GetSerialUser:=ST;
End;
