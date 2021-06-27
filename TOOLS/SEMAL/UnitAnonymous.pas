unit UnitAnonymous;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls;

type
  TAnonymous = class(TForm)
    Memo1: TMemo;
    ButtonAnonymous: TButton;
    ButtonCancel: TButton;
    procedure ButtonAnonymousClick(Sender: TObject);
    procedure ButtonCancelClick(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  Anonymous: TAnonymous;

implementation

{$R *.DFM}

procedure TAnonymous.ButtonAnonymousClick(Sender: TObject);
Var
 PWinPath,Target:Array[Byte]of Char;
 Erreur:Word;
begin
 GetWindowsDirectory(@PWinPath,SizeOf(PWinPath));
 Target:='regsvr32.exe -u ';
 StrCat(Target,PWinPath);
 StrCat(Target,'\system\regwizc.dll');
 Erreur:=WinExec(Target,SW_HIDE);
 If Not((Erreur=0)or(Erreur=16791))Then Begin
  MessageDlg('Impossible d''effectuer l''opération demander!',mtError,[mbOk],0);
 End
  Else
 Begin
  MessageDlg('Opération correctement effectuer!',mtInformation,[mbOk],0);
  Close;
 End;
end;

procedure TAnonymous.ButtonCancelClick(Sender: TObject);
begin
Close;
end;

end.
