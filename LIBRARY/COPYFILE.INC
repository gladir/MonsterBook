{CopyFile.Inc}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                 Malte Genesis/BibliothŠque individuel                 Û
 ³                    dition Chantal/IV - Version 1.1                   Û
 ³                             1997/04/01                                Û
 ³                                                                       Û
 ³         Tous droits r‚serv‚s par les Chevaliers de Malte (C)          Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Nom des programmeurs
 ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ

  Sylvain Maltais


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette inclusion vise  … permettre une universialisation des donn‚es …
 compiler  ind‚pendament  des conditions  sous  lequel  la fonction est
 traŒter.  En centralisant toutes les proc‚dures au mˆme point central,
 on aboutira une technique de ®Croiser¯, celle-ci permet d'‚liminer les
 bugs par le raisonnement suivant:Maintenant sa fonctionne parfaitement
 ou sa plante comme jamais avant...
}

{$IFNDEF __CopyFile}
 {$DEFINE __CopyFile}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                           Fonction CopyFile                       Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction permet de copier un fichier ®Source¯ … la destination
 contenu dans la variable de param‚trage ®Target¯.  La date du fichier
 original est  conserv‚e  sur le fichier destinataire,  il ne contient
 donc pas la date actuel du systŠme mais du fichier d'origine.


 Remarques
 ÍÍÍÍÍÍÍÍÍ

  ş Cette  fonction  r‚clame  un systŠme  d'exploitation  compatible …
    un DOS version 2 ou post‚rieurs (datant de moins mars 1983)!

  ş Si  vous  sp‚cifiez  la  directive   de  compilation  conditionnel
    ®Dialog¯ celle-ci appelle une proc‚dure virtuel de progression  de
    la copie … mesure qu'elle s'effectue.
}

{$IFNDEF NoVoid}
 Function CopyFile(Const Source,Target:String{$IFDEF Dialog};Proc:BackgroundCopy{$ENDIF}):Byte;
{$ENDIF}
Label ErrS;
Var
 HSource,HTarget:Hdl;
 NM,OldSysErr:Word;
 Size,I,ND,M:LongInt;
 Buf:Array[0..4095]of Byte;
 Q:SearchRec;
Begin
 ASM
  MOV @Result,0;
 END;
 FindFirst(Source,fa,Q);
 If SysErr<>0Then Begin
  GetSysErr:=errFileNotFound;
  Exit;
 End;
 HSource:=FileOpen(Source,fmRead);
 If(HSource=errHdl)Then Begin
  ASM MOV @Result,errFileNotFound;END;
  Exit;
 End;
 Size:=FileSize(HSource);
 HTarget:=New_(Target,Q.Attr.Value);
 If(HTarget=errHdl)Then Begin
  ASM
   MOV @Result,errMakeFile;
  END;
  Goto ErrS;
 End;
 ND:=Size div SizeOf(Buf);NM:=Size mod SizeOf(Buf);M:=0;
 For I:=0to ND-1do Begin
  _GetAbsRec(HSource,M,SizeOf(Buf),Buf);
  _SetAbsRec(HTarget,M,SizeOf(Buf),Buf);
  ASM
   MOV AX,SysErr
   MOV @Result,AL
  END;
  Inc(M,LongInt(SizeOf(Buf)));
  {$IFDEF Dialog}
   If Not Proc((LongInt(M)*100)div LongInt(Size),M,Size)Then Begin
    OldSysErr:=SysErr;
    FileClose(HTarget);
    FileClose(HSource);
    DeleteFile(Target);
    If SysErr=0Then SysErr:=OldSysErr;
    Exit;
   End;
  {$ENDIF}
 End;
 If NM>0Then Begin
  _GetAbsRec(HSource,M,NM,Buf);
  _SetAbsRec(HTarget,M,NM,Buf);
  ASM
   MOV AX,SysErr
   MOV @Result,AL
  END;
 End;
 {$IFNDEF __Windows__}
  SetFileTime(HTarget,fmWrite,LongRec(Q.Time).Lo,LongRec(Q.Time).Hi);
 {$ENDIF}
 FileClose(HTarget);
ErrS:
 FileClose(HSource);
End;

{$ENDIF}