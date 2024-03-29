{OSStr.Inc}

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

{$IFNDEF __OSStr}
 {$DEFINE __OSStr}

 {$IFNDEF __Windows__}
  {$DEFINE Macro}
 {$ENDIF}

 {$IFNDEF SkipCheckDRDOS}
  {$I \Source\Chantal\Library\System\DrDos\DrDosChk.Inc}
 {$ENDIF}
 {$I \Source\Chantal\Library\System\Dos16M\Dos16MCh.Inc}
 {$I \Source\Chantal\Library\System\Linux\Detect.Inc}

 {旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
  �                      Fonction OperatingSystemStr                      �
  잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�


  Description
  袴袴袴袴袴�

   Cette fonction permet de conna똳re sous forme d'une cha똭e de caract둹es
  la  version  du  syst둴e  d'exploitation  pr굎entement  en  fonction  sur
  l'ordinateur. Il retourne son nom aussi bien que sa version.


  Remarque
  袴袴袴袴

   � Bien  qu'il distingue ais굆ent l'췖S/2� et DR-DOS, il ne distingue pas
     les PC-DOS ou MS-DOS.
 }

Function OperatingSystemStr:String;
Var
 _AX,_CX,_SI,_DI,DosV:Word;
 I:Byte;
 Rtn,Ver:String;
Begin
 DosV:=Swap(GetDosVer);Rtn:='';
 If DrDosChk=0Then Begin
  If(OS2)Then Begin
   If(OS2LoVer=2)and(OS2HiVer=4)Then Rtn:='OS/2 Warp 4'Else
   If(OS2LoVer=2)and(OS2HiVer=3)Then Rtn:='OS/2 Warp 3'
   Else Rtn:='OS/2 '+WordToStr(OS2LoVer)+'.'+Str0(OS2HiVer,2);
  End
  Else Begin
   If(Win=winEnhanced)and(WinLoVer=4)and(WinHiVer=0)Then Rtn:='Windows 95'Else
   If(Win=winEnhanced)and(WinLoVer=4)and(WinHiVer=10)Then Rtn:='Windows 98'Else
   If(Win=winEnhanced)and(WinLoVer=4)and(WinHiVer=90)Then Rtn:='Windows Me'Else
   If(Win=winEnhanced)and(WinLoVer=5)Then Rtn:='Windows 2000'Else
   If(Win=winNT)Then Rtn:='Windows NT'
   Else Begin
    If(InLinuxEmuDos)Then Rtn:='Linux'
    Else Rtn:='Dos '+WordToStr(Hi(DosV))+'.'+Str0(Lo(DosV),2);
   End;
  End;
 End
  Else
 Begin
  Rtn:=SelectField('CHANTAL:/DOS/DRDOSVersion.Dat',DrDosChk,1);
  If Rtn=''Then Begin
   ASM MOV _AX,AX;END;
   Rtn:='DR-DOS ? ('+HexWord2Str(_AX)+'h)';
  End;
 End;
 If Dos16MCheck<>0Then Begin
  For I:=1to 4do Begin
   ASM
    MOV AX,0ED00h
    MOV BL,I
    INT 2Fh
    MOV _AX,AX
    MOV _CX,CX
    MOV _SI,SI
    MOV _DI,DI
   END;
   If(Lo(_AX)=$FF)and(_SI=$5048)and(_DI=$4152)Then Begin
    Ver:=WordToStr(Hi(_CX))+'.';
    AddWdDec(Ver,Lo(_CX));
    Case(I)of
     1:AddStr(Rtn,'; Phar Lap 286 Dos-Extender 1.3+ SDK '+Ver);
     2:AddStr(Rtn,'; Phar Lap 286 Dos-Extender 1.3+ RTK '+Ver);
     3:AddStr(Rtn,'; Phar Lap 386 Dos-Extender 4.0+ SDK '+Ver);
     4:AddStr(Rtn,'; Phar Lap 386 Dos-Extender 4.0+ RTK '+Ver);
  Else AddStr(Rtn,'; DOS/16M');
    End;
   End;
  End;
 End;
 OperatingSystemStr:=Rtn;
End;

{$ENDIF}