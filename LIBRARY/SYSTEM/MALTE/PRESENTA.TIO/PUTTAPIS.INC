{PutTapis.Inc}

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
 �                 Malte Genesis/Biblioth둸ue individuel                 �
 �           릁ition Isabel & Chantal/III & IV - Version 1.1             �
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

{$IFNDEF __PutTapis}
 {$DEFINE __PutTapis}

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
 �                            Proc괺ure PutTapis                           �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�


 Description
 袴袴袴袴袴�

  Cette proc괺ure affiche une tapiserie de fond en mode texte pour permettre
 de ne pas voir directement le fond de l'괹ran.  Il s'adapte en fonction des
 polices de caract둹es supporter par les cartes vid굊 ou non.
}

Procedure PutTapis(Y1,Y2,Attr:Byte);
Var
 I,J,JD,ID,Y1M,Y2M:Byte;
 JDC,JDC1:Word;
 T:Array[0..1,0..1]of TextCube;
Begin
 If Not(IsGrf)and(IsVideoDirectAccess)Then Begin
  If(FontFound)and(IsLuxe)Then Begin
   If(IsMono)Then Attr:=$7F;
   FillChr(T,SizeOf(T),Attr);
   T[0][0].Chr:=#29;T[0][1].Chr:=#30;T[1][0].Chr:=#30;T[1][1].Chr:=#29;
   Y1M:=Y1 shr 1;Y2M:=Y2 shr 1;
   For J:=Y1M to(Y2M)do Begin
    JD:=J shl 1;JDC:=NmXTxts*(JD);JDC1:=JDC+NmXTxts;
    For I:=0to(MaxXTxts)shr 1do Begin
     ID:=I shl 1;
     MoveLeft(T[0],Mem[GetVideoSeg:(ID+JDC)shl 1],SizeOf(T[0]));
     If(J shl 1)+1<=Y2 Then MoveLeft(T[1],Mem[GetVideoSeg:(ID+JDC1)shl 1],SizeOf(T[1]))
    End
   End
  End
   Else
  ClrWn(0,Y1,MaxXTxts,Y2,$80)
 End
  Else
 If GetBitsPerPixel=1Then ClrWn(0,Y1,MaxXTxts,Y2,$10);
End;

{$ENDIF}