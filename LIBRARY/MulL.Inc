{\Source\Chantal\Library\MulL.Inc}

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

{$IFNDEF __MulL}
 {$DEFINE __MulL}

{���������������������������������������������������������������������
 �                           Fonction MulL                           �
 ���������������������������������������������������������������������

 Description
 �����������

  Cette fonction permet d'effectuer une multiplication de deux nombres
 32 bits sans assistance d'un micro-processeur sp�cifique.
}

Function MulL(a,b:LongInt):LongInt;Assembler;ASM
 {$IFDEF FLAT386}
  IMUL EDX
 {$ELSE}
  LES AX,a
  MOV DX,ES
  LES CX,b
  MOV BX,ES
  {$IFDEF __386__}
   DB 66h,0C1h,0E0h,010h     { SHL  EAX,10h     }
   DB 66h,00Fh,0ACh,0D0h,10h { SHRD EAX,EDX,10h }
   DB 66h,0C1h,0E1h,010h     { SHL  ECX,10h     }
   DB 66h,00Fh,0ACh,0D9h,10h { SHRD ECX,EBX,10h }
   DB 66h,0F7h,0E9h          { IMUL ECX         }
   DB 66h,00Fh,0A4h,0C2h,10h { SHLD EDX,EAX,10h }
  {$ELSE}
   MOV SI,AX
   MOV DI,DX
   MUL CX
   PUSH AX
    PUSH DX
     MOV AX,SI
     MUL BX
     MOV BX,AX
     MOV AX,DI
     MUL CX
     MOV CX,AX
    POP DX
   POP AX
   ADD DX,BX
   ADD DX,CX
  {$ENDIF}
 {$ENDIF}
END;

{$ENDIF}