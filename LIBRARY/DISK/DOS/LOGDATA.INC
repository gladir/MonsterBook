{LogData.Inc}

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

{$IFNDEF __LogData}
 {$DEFINE __LogData}

Type
 {Param�tres de formatage DOS}
 LogDataType=Record
  Media,Cluster,{Octet de support/Nombre Secteurs par Cluster}
  FAT,RootSize:Byte;{Nombre Secteurs pour la FAT/Entr�es dans le r�pertoire racine}
 End;

 {Structure d'un tampon d'une piste logique de format DOS}
 TrackBufType=Array[1..18,0..511]of Byte;{Tampon par piste}

{$ENDIF}