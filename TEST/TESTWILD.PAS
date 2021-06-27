Uses Systex,Systems;

BEGIN
 WrIteLn;
 WriteLn(WildCardMatch('TEST.GAT','*.GAT'));
 WriteLn(WildCardMatch('TEST.GAT','*.GAK'));
 WriteLn(WildCardMatch('TEST.GAT','*.GAT;'));
 WriteLn(WildCardMatch('TEST.GAT','*.GAK;'));
 WriteLn(WildCardMatch('TEST.GAT','*.GAT;SCROMPT'));
 WriteLn(WildCardMatch('TEST.GAT','*.GAK;SCROMPT'));
 WriteLn(WildCardMatch('TEST.GAT','FUCK;*.GAT'));
 WriteLn(WildCardMatch('TEST.GAT','FUCK;*.GAT;fgdfgdfg'));
 WriteLn(WildCardMatch('TEST.GAT','FUCK;*.GAK;fgdfgdfg'));
 WriteLn(WildCardMatch('TEST.GAT','FUCK;*.GAK;*.GAT;*.INC'));
 WriteLn(WildCardMatch('TEST.GAT','FUCK;*.GAK;*.GAH;*.INC'));
 WriteLn(WildCardMatch('TEST.GAT','*.G;*.H;*.I'));
END.