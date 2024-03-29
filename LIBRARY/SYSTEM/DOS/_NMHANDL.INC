{_NmHandl.Inc}

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

{$IFNDEF ___NmHandle}
 {$DEFINE ___NmHandle}

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
 �                          Fonction _NmHandle                           �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�


 Description
 袴袴袴袴袴�

  Cette fonction retourne le nombre de Handle utiliser par l'application en
 cours, c'est-�-dire celle-ci.


 Remarque
 袴袴袴袴

  � Cette fonction r괹lame  un  syst둴e d'exploitation compatible  � un DOS
    version 2 ou post굍ieurs (datant de moins mars 1983)!
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