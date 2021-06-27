{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³               Malte Genesis/Volume dans l'Ex‚cutable               Û
 ³          dition Chantal pour Mode R‚el/IV - Version 1.1           Û
 ³                            1998/07/09                              Û
 ³                                                                    Û
 ³        Tous droits r‚serv‚s par les Chevaliers de Malte (C)        Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


  Nom du programmeur
  ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ

   Sylvain Maltais


  Description
  ÍÍÍÍÍÍÍÍÍÍÍ

   Cette unit‚ permet de g‚rer les volumes  … l'int‚rieur  d'un fichier
  ex‚cutable ou s'il ne se trouve pas dans l'ex‚cutable, il les cherche
  dans le r‚pertoire courant.


  Remarque
  ÍÍÍÍÍÍÍÍ

   ş Le volume de l'ex‚cutable de l'ensemble Malte Genesis V: AdŠle doit
     avoir le format suivant:
     ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
     ³ Offset            ³ Description                                 ³
     ÆÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍµ
     ³ FinDuFichier-40   ³ Item de d‚part; le nom est ®DBUT¯.         ³
     ³ FinDuFichier-80   ³ L'item de fichier                           ³
     ³   ...             ³                                             ³
     ³ FinDuFichier-40*? ³ Dernier Item; le nom est ®FIN¯.             ³
     ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
  ş Le format d'un item est le suivant:
     ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
     ³ Offset            ³ Description                                 ³
     ÆÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍµ
     ³ 0                 ³ Position dans l'ex‚cutable.                 ³
     ³ 4                 ³ Taille du fichier de fa‡on interne.         ³
     ³ 8                 ³ ChaŒne de caractŠres de format PASCAL ou    ³
     ³                   ³ BASIC avec un octet de longueur suivant du  ³
     ³                   ³ contenu lui mˆme d'une longueur maximal de  ³
     ³                   ³ 31 caractŠres.                              ³
     ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
}

Unit Volume;

INTERFACE

Uses Systex;

{$I Library\System\Malte\Volume\ExecAdel.Inc}

Type ExecHandle=Record
 Presence:(ExecNone,ExecLocal,ExecExterne); { Fermer, dans l'ex‚cutable, … l'ext‚rieur }
 FilePos:LongInt;                           { Position du fichier dans l'ex‚cutable }
 Size:LongInt;                              { Taille du fichier dans l'ex‚cutable }
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

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                     Proc‚dure InitExecVolume                  Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet d'initialiser l'application  afin qu'elle
 reconnaisse la pr‚sence d'une volume de fichier dans l'ex‚cutable
 lui-mˆme.
}

Procedure InitExecVolume;Begin
 HandleExec:=FileOpen(_PrgPath,fmRead);SizeExec:=FileSize(HandleExec);
End;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                        Fonction ExecOpen                     Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette fonction ouvre un fichier situ‚ dans le volume ex‚cutable
 sous le mˆme principe qu'un fichier ®Handle¯ classique.
}

Function ExecOpen;Var X:FileItemAdele;L:LongInt;Begin
 ExecOpen:=False;L:=SizeExec-SizeOf(FileItemAdele);
 FillClr(Q,SizeOf(Q));
 _GetAbsRec(HandleExec,L,SizeOf(X),X);
 If X.Name='FIN'Then Begin
  While X.Name<>'DBUT'do Begin
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

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜ
 ³                         Proc‚dure DoneExecVolume                    Û
 ÀÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÛ


 Description
 ÍÍÍÍÍÍÍÍÍÍÍ

  Cette proc‚dure permet de mettre fin … l'utilisation par l'application
 de la pr‚sence d'une volume de fichier dans l'ex‚cutable.
}

Procedure DoneExecVolume;Begin
 FileClose(HandleExec)
End;

END.