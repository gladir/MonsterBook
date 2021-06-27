{ Description
  ÍÍÍÍÍÍÍÍÍÍÍ

   Ce programme permet de convertir une liste (de mot par exemple) en une
  suite de chaŒne de caractŠres de format Pascal contenu dans un fichier
  portant l'extension ®DTA¯.
}

Program List2Data;

Uses Systex,Systems;

Var HS,HT:Hdl;FP,FS:Long;S,SPour,Target:String;Chr:Char;
    Pour,Hour,Min,OldSec,Sec,Sec100:Byte;

{$DEFINE Bios}
{$I \Source\Chantal\Library\ReadKey.Inc}
{$I \Source\Chantal\Library\GetTime.Inc}

BEGIN
 WriteLn('Lst2Dta - Convertisseur de liste … chaŒne de caractŠres Pascal');
 WriteLn;
 If(ParamCount=0)or(ParamCount>2)or(ParamStr(1)='/?')Then Begin
  WriteLn('Syntaxe: LST2DTA source [destination]');
  WriteLn;
  WriteLn('    source          Nom de la source (.LST) de fichier devant ˆtre');
  WriteLn('                    convertie');
  WriteLn('    destination     Nom du fichier destinataire pourtant par d‚faut');
  WriteLn('                    l''extension ®.DTA¯');
  Halt;
 End;
 WriteLn('Source: ',ParamStr(1));
 HS:=Open(ParamStr(1),fmRead);
 If(HS=errHdl)Then Begin
  WriteLn('Fichier introuvable!');
  Halt(8);
 End;
 If ParamCount=2Then Target:=ParamStr(2)Else Target:=Path2NoExt(ParamStr(1));
 If Path2Ext(Target)=''Then AddStr(Target,'.DTA');
 WriteLn('Destination: ',Target);
 If FileExist(Target)Then Begin
  WriteLn('Fichier ®',Target,'¯ d‚ja existant sur le disque!');
  Write('Dois-je l''‚craser (O/N) ? ');
  Repeat Chr:=Char(ReadKey and Not($20))Until(Chr)in['O','N'];
  WriteLn;
  If Chr='N'Then Halt(3);
  DelFile(Target);
 End;
 HT:=New(Target);
 If(HT=errHdl)Then Begin
  WriteLn('Impossible de cr‚er le fichier de donn‚e!');
  Halt(7);
 End;
 FS:=FileSize(HS);FP:=0;OldSec:=$FF;
 WriteLn;
 Write('Progression (');
 Repeat
  __GetAbsFileTxtLn(HS,FP,S);
  _SetRec(HT,Length(S)+1,S);
  GetTime(Hour,Min,Sec,Sec100);
  If(OldSec<>Sec)Then Begin
   Pour:=Long(Long(FP)*100)div FS;SPour:=Str(Pour)+'%)';
   Write(SPour+MultChr(#8,Length(SPour)));
  End;
 Until FS<=FP;
 WriteLn;
 WriteLn;
 WriteLn('La taille du fichier est pass‚e de ',FS,' … ',FileSize(HT),'!');
 Close(HT);
 Close(HS);
 WriteLn;
 WriteLn('Op‚ration r‚ussit!');
END.