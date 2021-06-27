{\Source\Chantal\Library\System\Dos\Shell\4Dos\SearchDe.Inc}

{�������������������������������������������������������������������������
 �                 Malte Genesis/Biblioth�que individuel                 �
 �                    �dition Chantal/IV - Version 1.1                   �
 �                             1998/11/01                                �
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

{$IFNDEF __SearchDescription}
 {$DEFINE __SearchDescription}

 {��������������������������������������������������������������������������
  �                      Fonction SearchDescription                        �
  ��������������������������������������������������������������������������


  Description
  �����������

   Cette fonction effectue une recherche dans le fichier  �DESCRIPT.ION�  du
  r�pertoire sp�cifi� par la variable de param�trage  �Path� et recherche le
  nom de fichier d�finit  dans cette m�me variable  et cherchant � savoir si
  une description existe.


  Remarque
  ��������

   � Le fichier de description est d�finit selon le standard du �4DOS� ou du
     �NDOS� en minuscule suivie d'un espace puis de la description et est en
     format ASCII du DOS.
 }

 Function SearchDescription(Const Path:String):String;
 Var
  FP,FS:LongInt;
  S,Name,N2:String;
  Handle:Hdl;
  J:Word;
 Begin
  SearchDescription:='';
  If(DescrInFile)Then Begin
   S:=Path2Dir(Path);N2:=Path2NoDir(Path);
   If N2='DESCRIPT.ION'Then Begin SearchDescription:='DESCRIPT.ION';Exit;End;
   Handle:=FileOpen(S+'DESCRIPT.ION',fmRead);FP:=0;
   If(Handle<>errHdl)Then Begin
    FS:=FileSize(Handle);
    Repeat
     __GetAbsFileTxtLn(Handle,FP,S);
     J:=Pos(' ',S);
     If J=0Then Continue;
     Name:=StrUp(Left(S,J-1));
     If(N2=Name)Then Begin
      SearchDescription:=Copy(S,J+1,255);
      Break;
     End;
    Until FP>=FS;
    FileClose(Handle);
   End;
  End;
 End;

{$ENDIF}