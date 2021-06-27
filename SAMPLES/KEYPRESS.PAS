{$I Library\KeyPress.Inc}
{$I Library\ReadKey.Inc}
BEGIN
 Repeat Until KeyPress;
 WriteLn(ReadKey);
END.