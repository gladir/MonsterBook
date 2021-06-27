{GetMsVer.Inc}

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

{$IFNDEF __GetMsVer}
 {$DEFINE __GetMsVer}

 {ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
  ³                          Fonction GetMsVer                         Û
  ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


  Description
  ÍÍÍÍÍÍÍÍÍÍÍ

   Cette fonction retourne sous forme de chaŒne de caractŠres la version
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