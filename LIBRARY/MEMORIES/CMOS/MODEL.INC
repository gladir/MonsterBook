{Model.Inc}

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
 �                 Malte Genesis/Biblioth둸ue individuel                 �
 �                    릁ition Chantal/IV - Version 1.1                   �
 �                             1997/01/01                                �
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

{$IFNDEF __CmosConstantes}
 {$DEFINE __CmosConstantes}

Const
 {Les types de contr뱇eur CMOS RTC}
 ctrlCmosNo=$00;{Pas de contr뱇eur CMOS RTC}
 ctrlCmosUnknown=$01;{Contr뱇eur CMOS RTC de mod둳e inconnu}
 ctrlCmosMM58167a=$02;{Contr뱇eur CMOS RTC MM58167 (2C0h � 2DFh) }
 ctrlCmosMM58167b=$03;{Contr뱇eur CMOS RTC MM58167 (2C0h � 2C7h) }
 ctrlCmosRTC58321=$04;{Contr뱇eur RTC-58321 (2C0h � 2C1h) }
 ctrlCmosMC146818=$05;{Contr뱇eur CMOS RTC MC146818 de Motorola}

{$ENDIF}