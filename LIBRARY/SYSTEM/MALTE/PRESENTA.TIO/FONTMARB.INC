{FontMarb.Inc}

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
 �                 Malte Genesis/Biblioth둸ue individuel                 �
 �                    릁ition Chantal/IV - Version 1.1                   �
 �                             1994/01/01                                �
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

{$IFNDEF __FontMarble}
 {$DEFINE __FontMarble}

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
 �                        Proc괺ure FontMarble                         �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�


 Description
 袴袴袴袴袴�

  Cette proc괺ure affiche une toile de fond en marble bleu-blanc. Elle a
 besoin du fichier 췔ARBLE.MBF� pour pouvoir produire cette effet.


 Remarque
 袴袴袴袴

  � Cette proc괺ure ne s'applique correctement quand mode graphique.
}

Procedure FontMarble;Label 1;Var Handle:Hdl;I,J,J2,IM,JM,BJ2,BI,Size,Base:Wd;Buf:Array[0..245]of Byte;Ptr:^TByte;Begin
 Handle:=Open('SYS:MARBLE.MBF',fmRead);
 If(Handle=errHdl)Then Exit;
 Size:=FileSize(Handle);
 IM:=GetMaxXPixels div 246+Byte((GetMaxXPixels mod 246)>0);
 JM:=GetMaxYPixels div 246+Byte((GetMaxYPixels mod 246)>0);
 If(MaxAvail>Size)Then Begin
  Ptr:=MemAlloc(Size);Base:=0;
  If(Ptr=NIL)Then Goto 1;
  _GetAbsRec(Handle,0,Size,Ptr^);
  For J:=0to 221do Begin
   BJ2:=J;
   For J2:=0to(JM)do Begin
    BI:=0;
    For I:=0to(IM)do Begin
     If(BJ2<NmYPixels)Then ClrLnHorImg(BI,BJ2,246,8,Ptr^[Base]);
     Inc(BI,246);
    End;
    Inc(BJ2,222);
   End;
   Inc(Base,246);
  End;
  FreeMem(Ptr,Size);
 End
  Else
 Begin
1:For J:=0to 221do Begin
   GetRec(Handle,J,246,Buf);
   BJ2:=J;
   For J2:=0to(JM)do Begin
    BI:=0;
    For I:=0to(IM)do Begin
     If(BJ2<NmYPixels)Then ClrLnHorImg(BI,BJ2,246,8,Buf);
     Inc(BI,246);
    End;
    Inc(BJ2,222);
   End;
  End;
 End;
 Close(Handle)
End;

{$ENDIF}