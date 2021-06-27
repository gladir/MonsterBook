{CmosXT.Inc}

{�������������������������������������������������������������������������
 �                 Malte Genesis/Biblioth�que individuel                 �
 �                    �dition Chantal/IV - Version 1.1                   �
 �                             1996/01/01                                �
 �                                                                       �
 �         Tous droits r�serv�s par les Chevaliers de Malte (C)          �
 �������������������������������������������������������������������������


 Nom des programmeurs
 ��������������������

  Sylvain Maltais


 Description
 �����������

  Cette inclusion vise  � permettre une universialisation des donn�es �
 compiler  ind�pendament  des conditions  sous  lequel  la fonction est
 tra�ter.  En centralisant toutes les proc�dures au m�me point central,
 on aboutira une technique de �Croiser�, celle-ci permet d'�liminer les
 bugs par le raisonnement suivant:Maintenant sa fonctionne parfaitement
 ou sa plante comme jamais avant...
}

{$IFNDEF __CmosXT}
 {$DEFINE __CmosXT}

 {$I \Source\Chantal\Library\Memories\Cmos\Model.Inc}

{�����������������������������������������������������������������������
 �                            Fonction CmosXT                          �
 �����������������������������������������������������������������������


 Description
 �����������

  Cette fonction permet de conna�tre le mod�le CMOS install� sur XT s'il
 y  en  a  effectivement  d'installer.  Les  constantes  utilis�es  sont
 compatibles avec l'unit� �Systex�.


 Remarque
 ��������

  � A la fin  des ann�es 1990,  cette proc�dure  n'est plus utilis�e par
    aucune application car les XT n'existe plus et son succ�seur AT en a
    toujours un.
}

Function CmosXT:Byte;Assembler;ASM
 MOV DX,2C0h
 IN  AL,DX
 TEST AL,0Fh
 JNZ @TooBad
 MOV DX,2CBh
 IN  AL,DX
 CMP AL,0DEh
 JE  @CmosB
 MOV AL,0DEh
 OUT DX,AL
 IN  AL,DX
 CMP AL,0DEh
 JE  @CmosB
@TooBad:
 XOR AL,AL
 OUT DX,AL
 INC DX
 IN  AL,DX
 DEC DX
 TEST AL,0Fh
 JNZ @TriBad
 MOV AL,0Bh
 OUT DX,AL
 INC DX
 IN  AL,DX
 CMP AL,0DEh
 JE  @CmosC
 MOV AL,0DEh
 OUT DX,AL
 IN  AL,DX
 CMP AL,0DEh
 JE  @CmosC
@TriBad:
 XOR AL,AL
 OUT DX,AL
 MOV AL,80h
 OUT DX,AL
 MOV BL,0Eh
 INC DX
 MOV AL,BL
 OUT DX,AL
 DEC DX
 MOV AL,88h
 OUT DX,AL
 MOV AL,98h
 OUT DX,AL
 MOV AL,88h
 OUT DX,AL
 MOV AL,80h
 OUT DX,AL
 MOV AL,0A0h
 OUT DX,AL
 INC DX
 MOV CX,100h
@LoopA:
 IN  AL,DX
 TEST AL,1
 LOOPZ @LoopA
 JZ  @NoCmos
 MOV CX,100h
@LoopB:
 IN  AL,DX
 TEST AL,1
 LOOPNZ @LoopB
 JZ @CmosA
@NoCmos:
 MOV DX,2C0h
 XOR AL,AL { CtrlNoCmos=0 }
 OUT DX,AL
 XOR DX,DX
 JMP @@EndCmosXT
@CmosA:
 MOV AL,ctrlCmosRTC58321(* RTC-58321, 2C0h-2C1h *)
 JMP @SetCmosXTPort
@CmosB:
 MOV AL,ctrlCmosMM58167a(* MM58167, 2C0h-2DFh *)
 JMP @SetCmosXTPort
@CmosC:
 MOV AL,ctrlCmosMM58167b(* MM58167, 2C0h-2C7h *)
@SetCmosXTPort:
 MOV DX,2C0h
@@EndCmosXT:
END;

{$ENDIF}