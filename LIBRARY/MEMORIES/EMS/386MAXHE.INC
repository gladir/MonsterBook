{Library\Memories\EMS\386MaxHe.Inc}

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

{$IFNDEF __V386MaxBufType}
 {$DEFINE __V386MaxBufType}

{����������������������������������������������������������������������
 �                         Type V386MaxBufType                        �
 ����������������������������������������������������������������������


 Description
 �����������

  Cette enregistrement contient le format de l'ent�te de d'installation
 du pilote "386MAX".

}

Type V386MaxBufType=Record
 Version:Byte;                            {Version du pilote}
 Signature:Array[1..6]of Char;            {Signature "386MAX"}
 VerStr:Array[1..4]of Char;               {Cha�ne de caract�res contenu la version en ASCII}
 LowSeg,Unkw1,Unkw2,Flags1:Word;          {Segment de base, Inconnu???*2,drapeaux de donn�es}
 Unk1:Array[1..16]of Byte;                {Inconnu???}
 Int15Port,Int67Port:Word;                {Port d'adresse de l'interruption 15h et 67h}
 Unkw3,Unkw4:Word;                        {Inconnu???}
 Unkd1,Unkd2:LongInt;                     {Inconnu???}
 SysConfig:Word;                          {Configuration syst�me}
 Unk2:Array[1..8]of Byte;                 {Inconnu???}
 Flags2,Flags3,Flags4,Unkw5,ExtFree:Word; {Inconnu???, M�moire �tendue libre}
 Unkd3:LongInt;Unkw6:Word;Unkd4:LongInt;  {Inconnu???}
 Flags5:Word;                             {Drapeaux de donn�es}
 OldInt21Ofs,OldInt21Seg:Word;            {Adresse de l'ancienne interruption 21h}
 EmsOfs,EmsSeg:Word;                      {Adresse o� se trouve le pilote EMS}
 Extra:Byte;                              {Octet extra}
End;

{$ENDIF}