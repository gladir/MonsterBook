{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴콘
 �               Malte Genesis/Volume dans l'Ex괹utable               �
 �          릁ition Chantal pour Mode R괻l/IV - Version 1.1           �
 �                            1998/07/09                              �
 �                                                                    �
 �        Tous droits r굎erv굎 par les Chevaliers de Malte (C)        �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複蔔


  Nom du programmeur
  袴袴袴袴袴袴袴袴袴

   Sylvain Maltais


  Description
  袴袴袴袴袴�

   Cette unit� permet de g굍er les volumes  � l'int굍ieur  d'un fichier
  ex괹utable ou s'il ne se trouve pas dans l'ex괹utable, il les cherche
  dans le r굋ertoire courant.


  Remarque
  袴袴袴袴

   � Le volume de l'ex괹utable de l'ensemble Malte Genesis V: Ad둳e doit
     avoir le format suivant:
     旼컴컴컴컴컴컴컴컴컴쩡컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
     � Offset            � Description                                 �
     팠袴袴袴袴袴袴袴袴袴妄袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴�
     � FinDuFichier-40   � Item de d굋art; le nom est 췉륛UT�.         �
     � FinDuFichier-80   � L'item de fichier                           �
     �   ...             �                                             �
     � FinDuFichier-40*? � Dernier Item; le nom est 췋IN�.             �
     읕컴컴컴컴컴컴컴컴컴좔컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
  � Le format d'un item est le suivant:
     旼컴컴컴컴컴컴컴컴컴쩡컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
     � Offset            � Description                                 �
     팠袴袴袴袴袴袴袴袴袴妄袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴�
     � 0                 � Position dans l'ex괹utable.                 �
     � 4                 � Taille du fichier de fa뇇n interne.         �
     � 8                 � Cha똭e de caract둹es de format PASCAL ou    �
     �                   � BASIC avec un octet de longueur suivant du  �
     �                   � contenu lui m늤e d'une longueur maximal de  �
     �                   � 31 caract둹es.                              �
     읕컴컴컴컴컴컴컴컴컴좔컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
}

Unit Volume;

INTERFACE

Uses Systex;

{$I Library\System\Malte\Volume\ExecAdel.Inc}

Type ExecHandle=Record
 Presence:(ExecNone,ExecLocal,ExecExterne); { Fermer, dans l'ex괹utable, � l'ext굍ieur }
 FilePos:LongInt;                           { Position du fichier dans l'ex괹utable }
 Size:LongInt;                              { Taille du fichier dans l'ex괹utable }
 Ptr:LongInt;                               { Position du pointeur local courant }
 Handle:Hdl;                                { Handle si externe }
End;

Procedure InitExecVolume;
Function  ExecOpen(Const Name:String;Var Q:ExecHandle):Bool;
Procedure _ExecGetAbsRec(Var Q:ExecHandle;P:LongInt;Size:Word;Var Buffer);
Procedure _ExecGetRec(Var Q:ExecHandle;Size:Word;Var Buffer);
Procedure ExecSetFilePos(Var Q:ExecHandle;P:LongInt);
Procedure ExecClose(Var Q:ExecHandle);
Procedure ExecGetFile(Const Name:String;P:LongInt;Size:Word;Var Buffer);
Procedure DoneExecVolume;

IMPLEMENTATION

Uses Systems;

Const HandleExec:Hdl=errHdl;
Var SizeExec:LongInt;

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
 �                     Proc괺ure InitExecVolume                  �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�


 Description
 袴袴袴袴袴�

  Cette proc괺ure permet d'initialiser l'application  afin qu'elle
 reconnaisse la pr굎ence d'une volume de fichier dans l'ex괹utable
 lui-m늤e.
}

Procedure InitExecVolume;Begin
 HandleExec:=FileOpen(_PrgPath,fmRead);SizeExec:=FileSize(HandleExec);
End;

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴콘
 �                        Fonction ExecOpen                     �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複蔔


 Description
 袴袴袴袴袴�

  Cette fonction ouvre un fichier situ� dans le volume ex괹utable
 sous le m늤e principe qu'un fichier 췎andle� classique.
}

Function ExecOpen;Var X:FileItemAdele;L:LongInt;Begin
 ExecOpen:=False;L:=SizeExec-SizeOf(FileItemAdele);
 FillClr(Q,SizeOf(Q));
 _GetAbsRec(HandleExec,L,SizeOf(X),X);
 If X.Name='FIN'Then Begin
  While X.Name<>'D륛UT'do Begin
   Dec(L,SizeOf(FileItemAdele));
   _GetAbsRec(HandleExec,L,SizeOf(X),X);
   If(X.Name=Name)Then Begin
    Q.Presence:=ExecLocal;Q.FilePos:=X.AbsolutePosition;Q.Size:=X.Size;
    Break;
   End;
  End;
 End;
 If(Q.Presence=ExecNone)Then Begin
  Q.Handle:=FileOpen(Name,fmRead);
  If(Q.Handle=errHdl)Then Exit;
  Q.Presence:=ExecExterne;Q.Size:=FileSize(Q.Handle);
 End;
 ExecOpen:=True;
End;

Procedure _ExecGetAbsRec;Begin
 Case(Q.Presence)of
  ExecLocal:Q.Ptr:=Q.FilePos+P+_GetAbsRec(HandleExec,Q.FilePos+P,Size,Buffer);
  ExecExterne:Q.Ptr:=P+_GetAbsRec(Q.Handle,P,Size,Buffer);
 End;
End;

Procedure _ExecGetRec;Begin
 Case(Q.Presence)of
  ExecLocal:Q.Ptr:=Q.FilePos+_GetAbsRec(HandleExec,Q.FilePos+Q.Ptr,Size,Buffer);
  ExecExterne:Q.Ptr:=_GetAbsRec(HandleExec,Q.Ptr,Size,Buffer);
 End;
End;

Procedure ExecSetFilePos;Begin
 Q.Ptr:=P;
End;

Procedure ExecClose;Begin
 If(Q.Presence=ExecExterne)Then FileClose(Q.Handle);
 FillClr(Q,SizeOf(Q))
End;

Procedure ExecGetFile(Const Name:String;P:LongInt;Size:Word;Var Buffer);Var Q:ExecHandle;Begin
 ExecOpen(Name,Q);
 _ExecGetAbsRec(Q,P*Size,Size,Buffer);
 ExecClose(Q);
End;

{旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
 �                         Proc괺ure DoneExecVolume                    �
 잔複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�


 Description
 袴袴袴袴袴�

  Cette proc괺ure permet de mettre fin � l'utilisation par l'application
 de la pr굎ence d'une volume de fichier dans l'ex괹utable.
}

Procedure DoneExecVolume;Begin
 FileClose(HandleExec)
End;

END.