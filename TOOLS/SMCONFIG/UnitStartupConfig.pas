unit UnitStartupConfig;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, Registry, ComCtrls, Tabnotbk;

type
  TForm1 = class(TForm)
    TabbedNotebook1: TTabbedNotebook;
    StringGrid1: TStringGrid;
    StringGrid2: TStringGrid;

    procedure StringGrid1Enter(Sender: TObject);
    procedure StringGrid1DrawCell(Sender: TObject; Col, Row: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure StringGrid2StartDrag(Sender: TObject;
      var DragObject: TDragObject);
  private
    { Déclarations privées }
    FirstTime:Boolean;
    Reg:TRegistry;
    Function ReadKeyString(Const Name:String):String;
    Function ReadKeyInteger(Const Name:String):Integer;
    Procedure Refresh(Sender:TObject);
  public
    { Déclarations publiques }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

Function TForm1.ReadKeyString(Const Name:String):String;Begin
 If Reg.ValueExists(Name)Then Begin
  Case Reg.GetDataType(Name)of
   rdString:ReadKeyString:=Reg.ReadString(Name);
   rdExpandString:;
   rdInteger:;
   rdBinary:;
   End;
 End
  Else
 ReadKeyString:='';
End;

Function TForm1.ReadKeyInteger(Const Name:String):Integer;Begin
 ReadKeyInteger:=-1;
 If Reg.ValueExists(Name)Then Begin
  Case Reg.GetDataType(Name)of
   rdString:;
   rdExpandString:;
   rdInteger:ReadKeyInteger:=Reg.ReadInteger(Name);
   rdBinary:;
   End;
 End;
End;

Procedure TForm1.Refresh(Sender:TObject);
Var
 TStr:TStringList;
 I:Integer;
begin
 If(FirstTime)Then Begin
   (* Lancement automatique de programme *)
  TStr:=TStringList.Create;
  StringGrid1.Cells[0,0]:='Item de démarrage';
  StringGrid1.Cells[1,0]:='Commande';
  StringGrid1.Cells[2,0]:='Emplacement';
  Reg:=TRegistry.Create;
   { Utilisateur courant }
  Reg.RootKey:=HKEY_CURRENT_USER;
  Reg.OpenKey('Software\Microsoft\Windows\CurrentVersion\Run',True);
  Reg.GetValueNames(TStr);
  If TStr.Count>0Then Begin
   For I:=0to TStr.Count-1do Begin
    StringGrid1.Cells[0,I+1]:=TStr.Strings[I];
    StringGrid1.Cells[1,I+1]:=Reg.ReadString(TStr.Strings[I]);
    StringGrid1.Cells[2,I+1]:='HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run';
   End;
   StringGrid1.RowCount:=TStr.Count+1;
  End;
   { Machine local }
  Reg.RootKey:=HKEY_LOCAL_MACHINE;
  Reg.OpenKey('Software\Microsoft\Windows\CurrentVersion\Run',True);
  Reg.GetValueNames(TStr);
  If TStr.Count>0Then Begin
   For I:=0to TStr.Count-1do Begin
    StringGrid1.Cells[0,StringGrid1.RowCount+I]:=TStr.Strings[I];
    StringGrid1.Cells[1,StringGrid1.RowCount+I]:=Reg.ReadString(TStr.Strings[I]);
    StringGrid1.Cells[2,StringGrid1.RowCount+I]:='HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Run';
   End;
   StringGrid1.RowCount:=StringGrid1.RowCount+TStr.Count;
  End;
   (* Lancement automatique de services *)
  StringGrid2.Cells[0,0]:='Services (MID)';
  StringGrid2.Cells[1,0]:='Nom';
  StringGrid2.Cells[2,0]:='Essentiel';
  StringGrid2.Cells[3,0]:='Manufacturier';
  StringGrid2.Cells[4,0]:='État';
  Reg.RootKey:=HKEY_LOCAL_MACHINE;
  Reg.OpenKey('\SYSTEM\CurrentControlSet\Services',True);
  Reg.GetKeyNames(TStr);
  If TStr.Count>0Then Begin
   For I:=0to TStr.Count-1do Begin
    StringGrid2.Cells[0,I+1]:=TStr.Strings[I];
   End;
   StringGrid2.RowCount:=TStr.Count+1;
  End;
  For I:=0to TStr.Count-1do Begin
   Reg.RootKey:=HKEY_LOCAL_MACHINE;
   Reg.OpenKey('\SYSTEM\CurrentControlSet\Services\'+
                StringGrid2.Cells[0,I+1],False);
   StringGrid2.Cells[1,I+1]:=ReadKeyString('DisplayName');
   If StringGrid2.Cells[1,I+1]=''Then StringGrid2.Cells[1,I+1]:=ReadKeyString('Group');
   Case ReadKeyInteger('Start')of
    0:StringGrid2.Cells[4,I+1]:='Démarrage';
    1:StringGrid2.Cells[4,I+1]:='Système';
    2:StringGrid2.Cells[4,I+1]:='Automatique';
    3:StringGrid2.Cells[4,I+1]:='Manuel';
    4:StringGrid2.Cells[4,I+1]:='Désactivé';
   End;
  End;
  Reg.Free;
  TStr.Free;
  FirstTime:=False;
 End;
end;

procedure TForm1.StringGrid1Enter(Sender: TObject);
begin
 Refresh(Sender);
end;

procedure TForm1.StringGrid1DrawCell(Sender: TObject; Col, Row: Integer;
  Rect: TRect; State: TGridDrawState);
begin
 Refresh(Sender);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
 FirstTime := true;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
{ FirstTime := true; }
end;

procedure TForm1.StringGrid2StartDrag(Sender: TObject;
  var DragObject: TDragObject);
begin
 Refresh(Sender);
end;

end.
