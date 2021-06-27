Program TestTelephone;

Uses Adele,Systex,Systems,Video,Mouse,Dials,DialPlus;

Type
 PersonneRec=Record
  NoPersonne:Word;
  Entete:String[3];
  Prenom:String[30];
  Nom:String[30];
  Fonction:String[20];
  Societe:String[30];
  Adresse:String[40];
  Ville:String[20];
  Province:String[10];
  Pays:String[20];
  CodePostal:String[6];
  Courriel:String[50];
  OnPressNumber:Procedure(Var Context);
  ContextNumber:Pointer;
  OnPressIcon:Procedure(Var Context);
  ContextIcon:Pointer;
  IconeAssociee:String;
 End;

Var TPersonne:PersonneRec;

Procedure OnPressNumber(Var Context);Begin

End;

Procedure OnPressIcon(Var Context);Begin
End;

BEGIN
 InitSystems(suIsabel);
 SetVideoModeDeluxe(vmGrf640x480c65536);
 __InitMouse;
 AppInit('abc',$4C,MtxOS2Win95);
 kType:=ktBubble;
 {InitEnv;}
 FillClr(TPersonne,SizeOf(TPersonne));
 TPersonne.OnPressNumber:=OnPressNumber;
 TPersonne.OnPressIcon:=OnPressIcon;
 ExecuteAppDPU(63,TPersonne.Entete);
 SetVideoMode(vmTxtDef);
END.