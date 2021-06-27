{MoveLeft.Inc}

{�������������������������������������������������������������������������
 �                 Malte Genesis/Biblioth�que individuel                 �
 �                    �dition Chantal/IV - Version 1.1                   �
 �                             1997/04/01                                �
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

{$IFNDEF __MoveLeft}
 {$DEFINE __MoveLeft}

{����������������������������������������������������������������������������
 �                            Proc�dure MoveLeft                            �
 ����������������������������������������������������������������������������


 Description
 �����������

  Cette proc�dure copie un bloc de m�moire (Source) dans le bloc destinataire
 (Dest). La longueur de ce bloc est sp�cifi� par la variable �Count�.
}

Procedure MoveLeft(Const Source;Var Dest;Count:Word);Assembler;ASM
 {$IFDEF FLAT386}
  OR EDX,EDX
  JZ @@End
  OR EAX,EAX
  JZ @@End
  PUSH ESI
   PUSH EDI
    MOV ESI,EAX
    MOV EDI,EDX
    MOV EAX,ECX
    CMP EDI,ESI
    JG  @@down
    JE  @@exit
    SAR ECX,2
    JS  @@exit
    REP MOVSD
    MOV ECX,EAX
    AND ECX,03H
    REP MOVSB
    JMP @@exit
@@down:
    LEA ESI,[ESI+ECX-4]
    LEA EDI,[EDI+ECX-4]
    SAR ECX,2
    JS  @@exit
    STD
    REP MOVSD
    MOV ECX,EAX
    AND ECX,03H
    ADD ESI,4-1
    ADD EDI,4-1
    REP MOVSB
    CLD
@@exit:
   POP EDI
  POP ESI
@@End:
 {$ELSE}
  CLD
  PUSH DS
   LDS SI,Source
   LES DI,Dest
   MOV CX,Count
   {$IFDEF __386__}
    MOV BX,CX
    AND BX,3
    {$IFOPT G+}
     SHR CX,2
    {$ELSE}
     DB 0C1h,0E9h,02h { SHR CX,2 }
    {$ENDIF}
    DB  ciREP; DW ciMOVSD
    XCHG CX,BX
    REP MOVSB
   {$ELSE}
     { Transfert 16 bits...}
    SHR CX,1
    REP MOVSW
    ADC CX,CX
    REP MOVSB
   {$ENDIF}
  POP DS
 {$ENDIF}
END;

{$ENDIF}