{Model.Inc}

{�������������������������������������������������������������������������
 �                 Malte Genesis/Biblioth�que individuel                 �
 �                    �dition Chantal/IV - Version 1.1                   �
 �                             1997/01/01                                �
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

{$IFNDEF __CmosConstantes}
 {$DEFINE __CmosConstantes}

Const
 {Les types de contr�leur CMOS RTC}
 ctrlCmosNo=$00;{Pas de contr�leur CMOS RTC}
 ctrlCmosUnknown=$01;{Contr�leur CMOS RTC de mod�le inconnu}
 ctrlCmosMM58167a=$02;{Contr�leur CMOS RTC MM58167 (2C0h � 2DFh) }
 ctrlCmosMM58167b=$03;{Contr�leur CMOS RTC MM58167 (2C0h � 2C7h) }
 ctrlCmosRTC58321=$04;{Contr�leur RTC-58321 (2C0h � 2C1h) }
 ctrlCmosMC146818=$05;{Contr�leur CMOS RTC MC146818 de Motorola}

{$ENDIF}