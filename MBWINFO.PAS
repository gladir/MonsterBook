unit Mbwinfo;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls;

type
  TInfoSomary = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Disque: TListBox;
    Label7: TLabel;
    Divers: TListBox;
    Label8: TLabel;
    NameComputer: TLabel;
    CorrecteSommaire: TButton;
    ConstructorBIOS: TLabel;
    CPUName: TLabel;
    MPUName: TLabel;
    VideoName: TLabel;
    MouseName: TLabel;
    procedure CorrecteSommaireClick(Sender: TObject);
  private
    { Déclarations private }
  public
    { Déclarations public }
    Procedure Run;
  end;

var
  InfoSomary: TInfoSomary;

implementation

Uses Adele,Systex,Systems;

{$R *.DFM}

{$H-}

Procedure TInfoSomary.Run;Var S,SM:String;Begin
 NameComputer.Caption:='Inconnu';
 ConstructorBIOS.Caption:='Inconnu';
 Case(CPU)of
  cpuV20:CPUName.Caption:='NEC V20';
  cpuV30:CPUName.Caption:='NEC V30';
  cpu8088:CPUName.Caption:='8088';
  cpu8086:CPUName.Caption:='8086';
  cpu80188:CPUName.Caption:='80188';
  cpu80186:CPUName.Caption:='80186';
  cpu80286:CPUName.Caption:='80286';
  cpui386:CPUName.Caption:='80386';
  cpui486:CPUName.Caption:='80486';
  cpuCyrix5x86:CPUName.Caption:='Cyrix 5x86';
  cpuCyrix6x86:CPUName.Caption:='Cyrix 6x86';
  cpuPentium:CPUName.Caption:='Pentium';
  cpuPentiumMMX:CPUName.Caption:='Pentium-MMX';
  cpuPentiumII:CPUNAme.Caption:='Pentium II';
  Else CPUName.Caption:='Inconnu';
 End;
 MPUName.Caption:='Inconnu';
 VideoName.Caption:='Inconnu';
 MouseName.Caption:='Inconnu';
 Case(KbdModel)of
  kbPC:S:='PC original';
  kbXT:S:='XT original';
  kbAT:S:='AT de 84 touches';
  kbConterm:S:='Conterm Max';
  kbMF:S:='MF de 101 à 105 touches';
 End;
 Divers.Items.Add('Type de clavier: '+S);
 S:='Windows ';SM:='';
 If(WinLoVer=3)and(WinHiVer=95)Then AddStr(S,'95/98')Else
 If(WinLoVer=4)and(WinHiVer=0)Then AddStr(S,'95')Else
 If(WinLoVer=4)and(WinHiVer=10)Then AddStr(S,'98')
  Else
 Begin
  AddStr(S,IntToStr(WinLoVer)+'.'+IntToStr(WinHiVer));
  Case(Win)of
   winReal:AddStr(SM,'Mode de fonctionnement: Réel');
   winStandard:AddStr(SM,'Mode de fonctionnement: Standard');
   winEnhanced:AddStr(SM,'Mode de fonctionnement: Étendue 386');
  End;
 End;
 Divers.Items.Add('Système d''exploitation: '+S);
 If SM<>''Then Divers.Items.Add(SM);
 ShowModal;
End;

procedure TInfoSomary.CorrecteSommaireClick(Sender: TObject);
begin
  Close;
end;

end.
