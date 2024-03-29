{CopyFile.Inc}

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
 �                 Malte Genesis/Biblioth둸ue individuel                 �
 �                    릁ition Chantal/IV - Version 1.1                   �
 �                             1997/04/01                                �
 �                                                                       �
 �         Tous droits r굎erv굎 par les Chevaliers de Malte (C)          �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�


 Nom des programmeurs
 袴袴袴袴袴袴袴袴袴袴

  Sylvain Maltais


 Description
 袴袴袴袴袴�

  Cette inclusion vise  � permettre une universialisation des donn괻s �
 compiler  ind굋endament  des conditions  sous  lequel  la fonction est
 tra똳er.  En centralisant toutes les proc괺ures au m늤e point central,
 on aboutira une technique de 췈roiser�, celle-ci permet d'굃iminer les
 bugs par le raisonnement suivant:Maintenant sa fonctionne parfaitement
 ou sa plante comme jamais avant...
}

{$IFNDEF __CopyFile}
 {$DEFINE __CopyFile}

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
 �                           Fonction CopyFile                       �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�


 Description
 袴袴袴袴袴�

  Cette fonction permet de copier un fichier 췚ource� � la destination
 contenu dans la variable de param굏rage 췛arget�.  La date du fichier
 original est  conserv괻  sur le fichier destinataire,  il ne contient
 donc pas la date actuel du syst둴e mais du fichier d'origine.


 Remarques
 袴袴袴袴�

  � Cette  fonction  r괹lame  un syst둴e  d'exploitation  compatible �
    un DOS version 2 ou post굍ieurs (datant de moins mars 1983)!

  � Si  vous  sp괹ifiez  la  directive   de  compilation  conditionnel
    췉ialog� celle-ci appelle une proc괺ure virtuel de progression  de
    la copie � mesure qu'elle s'effectue.
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