{GetMsVer.Inc}

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

{$IFNDEF __GetMsVer}
 {$DEFINE __GetMsVer}

 {旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴콘
  �                          Fonction GetMsVer                         �
  잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複蔔


  Description
  袴袴袴袴袴�

   Cette fonction retourne sous forme de cha똭e de caract둹es la version
  de la souris.
 }

Function GetMsVer:String;
Var
 _AX,_BX,_CX,a:Word;
Begin
 {$IFDEF ENGLISH}
  GetMsVer:='Unknown';
 {$ELSE}
  GetMsVer:='Inconnue';
 {$ENDIF}
 {$IFDEF FLAT386}
 {$ELSE}
  ASM
   MOV AX,0021h
   INT 33h
   MOV _AX,AX
  END;
  If _AX=$FFFFThen Begin
   ASM
    MOV AX,00070h
    MOV BX,0ABCDh
    INT 33h
    MOV _AX,AX
    MOV _BX,BX
    MOV _CX,CX
   END;
   If(_AX=$ABCD)and(MemW[_BX:_CX]=$ABCD)and(MemW[_BX:_CX+8]=$ABCD)Then Begin
    a:=MemW[MemW[_BX:_CX+4]:MemW[_BX:_CX+2]];
    GetMsVer:=WordToStr(Hi(a))+'.'+WordToStr(Lo(a));
    Exit;
   End;
   ASM
    MOV AX,266Ch
    XOR BX,BX
    XOR CX,CX
    INT 33h
    MOV _BX,BX
    MOV _CX,CX
   END;
   If _BX=$5353Then Begin
    GetMsVer:=WordToStr(Hi(_CX))+'.'+WordToStr(Lo(_CX));
    Exit;
   End;
  End;
  Begin
   ASM
    MOV AX,0024h
    INT 33h
    MOV _AX,AX
    MOV _BX,BX
   END;
   If _AX<$FFFFThen GetMsVer:=WordToStr(Hi(_BX))+'.'+WordToStr(Lo(_BX));
  End;
 {$ENDIF}
End;

{$ENDIF}