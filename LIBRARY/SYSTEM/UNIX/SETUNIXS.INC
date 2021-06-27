{SetUnixS.Inc}

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

{$IFNDEF __SetUnixStyleDate}
 {$DEFINE __SetUnixStyleDate}

{$I Library\System\Unix\Month.Inc}
{$I Library\System\Unix\SetYear.Inc}

Procedure SetUnixStyleDate(Var Date:Long;Year,Month,Day,Hour,Min,Secs:Wd);
Var
 RDate,T:Long;
 LeapYear:Bool;
 I:Integer;
Begin
 Date:=GMTDifference*3600;
 For I:=1970to Pred(Year)do Begin
  If I and 3=0Then T:=31622400 Else T:=31536000;
  Inc(Date,T)
 End;
 SetYear(Year);
 For I:=1to Month-1do Inc(Date,Long(DaysPerMonth[I])*86400);
 Inc(Date,Long(Pred(Day))*86400+Long(Hour)*3600+Long(Min)*60+Secs)
End;

{$ENDIF}