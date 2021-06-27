{PackTime.Inc}

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

{$IFNDEF __PackTime}
 {$DEFINE __PackTime}

{������������������������������������������������������������������������
 �                           Proc�dure PackTime                         �
 ������������������������������������������������������������������������


 Description
 �����������

  Cette proc�dure permet  de passer  de la forme longue de la date  et de
 l'heure directement lisible, � la forme courte utilis�, par exemple, par
 la proc�dure  �SetFTime�.  Le  param�tre  �T�  est  doit  �tre  de  type
 �DateTime� pr�d�fini par l'unit� �Dos� ou �Systex�.
}

Procedure PackTime(Var T:DateTime;Var P:LongInt);Assembler;ASM
 {$IFDEF FLAT386}
 {$ELSE}
  PUSH DS
   LDS SI,T
   CLD
   LODSW
   SUB AX,1980
   {$IFOPT G+}
    SHL AX,9
   {$ELSE}
    MOV CL,9
    SHL AX,CL
   {$ENDIF}
   XCHG AX,DX
   {$IFDEF DosUnit}
    LODSW
   {$ELSE}
    LODSB
    XOR AH,AH
   {$ENDIF}
   {$IFOPT G+}
    SHL AX,5
   {$ELSE}
    MOV CL,5
    SHL AX,CL
   {$ENDIF}
   ADD DX,AX
   {$IFDEF DosUnit}
    LODSW
   {$ELSE}
    LODSB
    XOR AH,AH
   {$ENDIF}
   ADD DX,AX
   {$IFDEF DosUnit}
    LODSW
   {$ELSE}
    LODSB
   {$ENDIF}
   {$IFOPT G+}
    SHL AX,11
   {$ELSE}
    MOV CL,11
    SHL AX,CL
   {$ENDIF}
   XCHG AX,BX
   {$IFDEF DosUnit}
    LODSW
   {$ELSE}
    LODSB
    XOR AH,AH
   {$ENDIF}
   {$IFOPT G+}
    SHL AX,5
   {$ELSE}
    MOV CL,5
    SHL AX,CL
   {$ENDIF}
   ADD BX,AX
   {$IFDEF DosUnit}
    LODSW
   {$ELSE}
    LODSB
   {$ENDIF}
   SHR AX,1
   ADD AX,BX
  POP DS
  LES DI,P
  STOSW
  XCHG AX,DX
  STOSW
 {$ENDIF}
END;

{$ENDIF}