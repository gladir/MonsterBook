{Library\Memories\ROM\ReadROM.Inc}

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

{$IFNDEF __ReadRom}
 {$DEFINE __ReadRom}

 {��������������������������������������������������������������������
  �                         Fonction ReadROM                         �
  ��������������������������������������������������������������������


  Description
  �����������

   Cette fonction permet de retourner une cha�ne de caract�res contenu
  dans la ROM d'un IBM.
 }

 Function ReadRom(SegRom,Ofs:Word;Len:Byte):String;Assembler;ASM
  {$IFDEF FLAT386}
  {$ELSE}
   CLD
   PUSH DS
    LES DI,@Result
    MOV CL,Len
    MOV ES:[DI],CL
    INC DI
    MOV CH,0
    MOV DS,SegRom
    MOV SI,Ofs
    REP MOVSB
   POP DS
  {$ENDIF} 
 END;

{$ENDIF}