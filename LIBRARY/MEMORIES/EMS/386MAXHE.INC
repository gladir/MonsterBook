{Library\Memories\EMS\386MaxHe.Inc}

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

{$IFNDEF __V386MaxBufType}
 {$DEFINE __V386MaxBufType}

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴콘
 �                         Type V386MaxBufType                        �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複蔔


 Description
 袴袴袴袴袴�

  Cette enregistrement contient le format de l'ent늯e de d'installation
 du pilote "386MAX".

}

Type V386MaxBufType=Record
 Version:Byte;                            {Version du pilote}
 Signature:Array[1..6]of Char;            {Signature "386MAX"}
 VerStr:Array[1..4]of Char;               {Cha똭e de caract둹es contenu la version en ASCII}
 LowSeg,Unkw1,Unkw2,Flags1:Word;          {Segment de base, Inconnu???*2,drapeaux de donn괻s}
 Unk1:Array[1..16]of Byte;                {Inconnu???}
 Int15Port,Int67Port:Word;                {Port d'adresse de l'interruption 15h et 67h}
 Unkw3,Unkw4:Word;                        {Inconnu???}
 Unkd1,Unkd2:LongInt;                     {Inconnu???}
 SysConfig:Word;                          {Configuration syst둴e}
 Unk2:Array[1..8]of Byte;                 {Inconnu???}
 Flags2,Flags3,Flags4,Unkw5,ExtFree:Word; {Inconnu???, M굆oire 굏endue libre}
 Unkd3:LongInt;Unkw6:Word;Unkd4:LongInt;  {Inconnu???}
 Flags5:Word;                             {Drapeaux de donn괻s}
 OldInt21Ofs,OldInt21Seg:Word;            {Adresse de l'ancienne interruption 21h}
 EmsOfs,EmsSeg:Word;                      {Adresse o� se trouve le pilote EMS}
 Extra:Byte;                              {Octet extra}
End;

{$ENDIF}