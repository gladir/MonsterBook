{\Source\Chantal\Library\System\Dos\Shell\4Dos\SetDescr.Inc}

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

{$IFNDEF __SetDescription}
 {$DEFINE __SetDescription}

 {旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
  �                     Proc괺ure SetDescription                      �
  잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�


  Description
  袴袴袴袴袴�

   Cette proc괺ure permet d'additionner une description � un fichier de
  description de format ASCII de 4DOS ou NDOS.
 }

 Procedure SetDescription(Path:String;Var Descr:String);
 Var
  S,N2:String;
  Handle:Hdl;
  Exst:Boolean;
 Begin
  _DelAllSpcRight(Descr);
  Descr:=LTrim(Descr);
  If Descr<>''Then Begin
   S:=Path2Dir(Path);
   N2:=Path2NoDir(Path);
   AddStr(S,'DESCRIPT.ION');
   Exst:=FileExist(S);
   If Not(Exst)Then Handle:=New_(S,faHidden+faArchive)
    Else
   Begin
    FileSetAttr(S,faArchive);
    Handle:=FileOpen(S,fmWrite);
   End;
   If(Handle<>errHdl)Then Begin
    PutFileTxtLn(Handle,StrDn(Path2NoDir(Path))+' '+Descr);
    FileClose(Handle);
    If(Exst)Then FileSetAttr(S,faHidden+faArchive);
   End;
  End;
 End;

{$ENDIF}