{_NmHandl.Inc}

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

{$IFNDEF ___NmHandle}
 {$DEFINE ___NmHandle}

{�������������������������������������������������������������������������
 �                          Fonction _NmHandle                           �
 �������������������������������������������������������������������������


 Description
 �����������

  Cette fonction retourne le nombre de Handle utiliser par l'application en
 cours, c'est-�-dire celle-ci.


 Remarque
 ��������

  � Cette fonction r�clame  un  syst�me d'exploitation compatible  � un DOS
    version 2 ou post�rieurs (datant de moins mars 1983)!
}

 {$IFNDEF NoVoid}Function _NmHandle:Hdl;{$ENDIF}
 {$IFDEF __NmHandle}
  Begin
   {$IFDEF Win32}
    _NmHandle:=0;
   {$ELSE}
    _NmHandle:=NmHandle(PrefixSeg)
   {$ENDIF}
  End;
 {$ELSE}
  Var J:Byte;Begin
   ASM MOV @Result,0;END;
   If PrefixSeg<>8Then For J:=0to 19do If Not(Mem[PrefixSeg:$18+J]in[0..2,$FF])Then ASM INC @Result;END;
  End;
 {$ENDIF}

{$ENDIF}