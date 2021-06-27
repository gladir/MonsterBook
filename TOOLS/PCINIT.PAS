{ ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��

 �             Compilateur Pascal Niveau B57/Initialisation             �
                     Malte Genesis IV: Alias Chantal
 �                                                                      �
            Tous droits r�serv�s par les Chevaliers de Malte
 �                                                                      �

 �                            1998 � 2000                               �

  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��


 Nom du programmeur
 ������������������

  Sylvain Maltais


 Description
 �����������

  Cette unit� renferme les routines d'initialisations du compilateur de
 langage Pascal niveau B57.  Ce sont les  donn�es  devant �tre utilis�e
 par d�faut  par  le  compilateur  advenant  qu'aucune d�finition n'est
 sp�cifier par l'utilisateur.
}

Unit PCInit;

{���������������������������������������������������������������������������}
                                  INTERFACE
{���������������������������������������������������������������������������}

Procedure InitBuffer;
Procedure InitCompiler;

{���������������������������������������������������������������������������}
                                IMPLEMENTATION
{���������������������������������������������������������������������������}

Uses Systex,PCCortex,Systems,PCBase;

{������������������������������������������������������������������
 �                    Proc�dure InitCompiler                      �
 ������������������������������������������������������������������


 Description
 �����������

  Cette proc�dure permet d'initialiser les structures par d�faut du
 compilateur de langage Pascal niveau B57.
}

Procedure InitCompiler;Begin
 RBInit(ResWordBk);
 RBInit(VarBk);               { Initialise la liste des variables }
 RBInit(ReDef);               { Initialise la liste des constantes }
 RBInit(ProcBk);              { Initialise la liste des proc�dures }
 RBInit(UnitList);            { Initialise la liste des unit�s }
 RBAddStr(UnitList,'SYSTEM'); { Indique l'unit� par d�faut }
 RBInit(Include);             { Initialise la liste des inclusions }
 RBInit(Jump);                { Initialise la liste des sauts }
 RBInit(SuppData);            { Initialise la liste des donn�es suppl�mentaires }
 RBInit(Macro);               { Initialise la liste des Macros }
 RBInit(ExternProc);          { Initialise la liste des routines externes }
 RBInit(ExternVar);           { Initialise la liste des variables externes }
 RBInit(TypeDef);             { Initialise la liste des types }
 If((ProgramFormat)in[fEXE])and(ProgramTarget=ftWin31)Then Begin
  Org:=0;
 End
  Else
 Org:=$100;                   { Fixe l'origine du programme � 100h }
 IP:=Org+3;DP:=0;
 LastNameVar:='';LastUnitNum:=0;
 ResWordDef:=No;
 NmResWord:=0;
 SizeResWord:=0;I:=1;
 Status:=0;
End;

{����������������������������������������������������������������������������
 �                           Proc�dure InitBuffer                           �
 ����������������������������������������������������������������������������


 Description
 �����������

  Cette proc�dure permet d'initialiser les tampons de travails du compilateur
 Pascal niveau B57.
}

Procedure InitBuffer;Begin
 CodePrg:=MemAlloc(65520);    { R�serve un tampon de 64 Ko }
 FillClr(ArrayCond,SizeOf(ArrayCond));
 CurrCond:=0;
 {$IFDEF IDE}
  InRem:=No;Body:=bPRELUDE;
 {$ENDIF}
 S:='';S2:='';S3:='';S4:='';S5:='';S6:='';
 CaseLevel:=0;IfLevel:=0;
End;

{���������������������������������������������������������������������������}
END.