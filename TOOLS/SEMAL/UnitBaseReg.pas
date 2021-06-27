unit UnitBaseReg;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, Tabnotbk, StdCtrls, Registry;

type
  TFormRegWindows = class(TForm)
    TabbedNotebook1: TTabbedNotebook;
    FastHTTP: TCheckBox;
    ShellIconCache: TEdit;
    Label1: TLabel;
    OkRegistry: TButton;
    CancelRegistry: TButton;
    Label2: TLabel;
    SetupDirectory: TEdit;
    Label3: TLabel;
    UserName: TEdit;
    Label4: TLabel;
    CompanyName: TEdit;
    Label5: TLabel;
    ProductId: TEdit;
    Label6: TLabel;
    ProductKey: TEdit;
    Label7: TLabel;
    ProductName: TEdit;
    Label8: TLabel;
    Version: TEdit;
    Label9: TLabel;
    VersionNumber: TEdit;
    Label10: TLabel;
    SubVersionNumber: TEdit;
    Label11: TLabel;
    ProgramFilesDir: TEdit;
    Label12: TLabel;
    WinDir: TEdit;
    Label13: TLabel;
    WallPaperDir: TEdit;
    IconIE: TCheckBox;
    Label14: TLabel;
    IETitle: TEdit;
    PlayCD: TCheckBox;
    RunCD: TCheckBox;
    Procedure FormCreate(Sender:TObject);
    Procedure FormDestroy(Sender:TObject);
    procedure FastHTTPClick(Sender: TObject);
    procedure ShellIconCacheChange(Sender: TObject);
    procedure OkRegistryClick(Sender: TObject);
    procedure CancelRegistryClick(Sender: TObject);
    procedure SetupDirectoryChange(Sender: TObject);
    procedure UserNameChange(Sender: TObject);
    procedure CompanyNameChange(Sender: TObject);
    procedure ProductIdChange(Sender: TObject);
    procedure ProductKeyChange(Sender: TObject);
    procedure ProductNameChange(Sender: TObject);
    procedure VersionChange(Sender: TObject);
    procedure VersionNumberChange(Sender: TObject);
    procedure WinDirChange(Sender: TObject);
    procedure SubVersionNumberChange(Sender: TObject);
    procedure ProgramFilesDirChange(Sender: TObject);
    procedure IETitleChange(Sender: TObject);
    procedure PlayCDClick(Sender: TObject);
    procedure RunCDClick(Sender: TObject);
  private
    ShellIconCacheModified:Boolean;
    FastHTTPModified:Boolean;
    SetupDirectoryModified:Boolean;
    UserNameModified:Boolean;
    CompanyNameModified:Boolean;
    ProductIdModified:Boolean;
    ProductKeyModified:Boolean;
    ProductNameModified:Boolean;
    VersionModified:Boolean;
    VersionNumberModified:Boolean;
    SubVersionNumberModified:Boolean;
    WinDirModified:Boolean;
    ProgramFilesDirModified:Boolean;
    WallPaperDirModified:Boolean;
    IETitleModified:Boolean;
    PlayCDModified:Boolean;
    RunCDModified:Boolean;
    Reg:TRegistry;
    Function GetInteger(Const Name:String):LongInt;
    Function GetString(Const Name:String):String;
    Function GetBinary(Const Name:String):String;
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  FormRegWindows: TFormRegWindows;

implementation

{$R *.DFM}

Function TFormRegWindows.GetInteger(Const Name:String):LongInt;Begin
 If Reg.ValueExists(Name)Then Begin
  GetInteger:=Reg.ReadInteger(Name);
 End
  Else
 GetInteger:=0;
End;

Function TFormRegWindows.GetString(Const Name:String):String;Begin
 If Reg.ValueExists(Name)Then Begin
  GetString:=Reg.ReadString(Name);
 End
  Else
 GetString:='';
End;

Function TFormRegWindows.GetBinary(Const Name:String):String;
Var
 X:String[255];
 L:LongInt;
Begin
 If Reg.ValueExists(Name)Then Begin
  Case Reg.GetDataType(Name)of
   rdBinary:Begin
    FillChar(X,SizeOf(X),0);
    Reg.ReadBinaryData(Name,X[1],4);
    X[0]:=#4;
    GetBinary:=X;
   End;
   rdInteger:Begin
    FillChar(X,SizeOf(X),0);
    L:=Reg.ReadInteger(Name);
    Move(L,X[1],4);
    X[0]:=#4;
   End;
   Else GetBinary:='';
  End;
 End
  Else
 GetBinary:='';
End;

Procedure TFormRegWindows.FormCreate(Sender:TObject);Begin
 ShellIconCacheModified:=False;
 FastHTTPModified:=False;
 SetupDirectoryModified:=False;
 UserNameModified:=False;
 CompanyNameModified:=False;
 ProductIdModified:=False;
 ProductKeyModified:=False;
 ProductNameModified:=False;
 VersionModified:=False;
 VersionNumberModified:=False;
 SubVersionNumberModified:=False;
 WinDirModified:=False;
 ProgramFilesDirModified:=False;
 WallPaperDirModified:=False;
 IETitleModified:=False;
 PlayCDModified:=False;
 RunCDModified:=False;
 Reg:=TRegIniFile.Create('');
 Reg.RootKey:=HKEY_CURRENT_USER;
 Reg.OpenKey('\Software\Microsoft\Windows\Internet Settings',True);
 FastHTTP.Checked:=(GetInteger('MaxConnectionsPerServer')<>0)and
                    (GetInteger('MaxConnectionsPer1_0Server')<>0);
 Reg.RootKey:=HKEY_LOCAL_MACHINE;
 Reg.OpenKey('\Software\Microsoft\Windows\CurrentVersion\Explorer',False);
 ShellIconCache.Text:=GetString('Max Cached Icons');
 Reg.RootKey:=HKEY_LOCAL_MACHINE;
 Reg.OpenKey('\Software\Microsoft\Windows\CurrentVersion\Setup',False);
 SetupDirectory.Text:=GetString('SourcePath');
 Reg.RootKey:=HKEY_LOCAL_MACHINE;
 Reg.OpenKey('\Software\Microsoft\Windows\CurrentVersion',False);
 UserName.Text:=GetString('RegisteredOwner');
 CompanyName.Text:=GetString('RegisteredOrganization');
 ProductId.Text:=GetString('ProductId');
 ProductKey.Text:=GetString('ProductKey');
 ProductName.Text:=GetString('ProductName');
 Version.Text:=GetString('Version');
 VersionNumber.Text:=GetString('VersionNumber');
 SubVersionNumber.Text:=GetString('SubVersionNumber');
 WinDir.Text:=GetString('SystemRoot');
 ProgramFilesDir.Text:=GetString('ProgramFilesDir');
 If ProgramFilesDir.Text=''Then Begin
  ProgramFilesDir.Text:=GetString('ProgramFilesPath');
 End;
 WallPaperDir.Text:=GetString('WallPaperDir');
 Reg.RootKey:=HKEY_CURRENT_USER;
 Reg.OpenKey('\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer',False);
 IconIE.Checked:=GetInteger('NoInternetIcon')=0;
 Reg.RootKey:=HKEY_LOCAL_MACHINE;
 Reg.OpenKey('\Software\Microsoft\Internet Explorer\Main',False);
 IETitle.Text:=GetString('Window Title');
 If IETitle.Text=''Then IETitle.Text:='Microsoft Internet Explorer';
 Reg.RootKey:=HKEY_CLASSES_ROOT;
 Reg.OpenKey('\AudioCD\shell',False);
 PlayCD.Checked:=GetString('')='play';
 Reg.RootKey:=HKEY_CURRENT_USER;
 Reg.OpenKey('\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer',False);
 RunCd.Checked:=GetBinary('NoDriveTypeAutoRun')=#$95#$00#$00#$00;
End;

Procedure TFormRegWindows.FormDestroy(Sender:TObject);Begin
 Reg.Free;
End;

Procedure TFormRegWindows.FastHTTPClick(Sender:TObject);Begin
 FastHTTPModified:=True;
End;

Procedure TFormRegWindows.ShellIconCacheChange(Sender:TObject);Begin
 ShellIconCacheModified:=True;
End;

procedure TFormRegWindows.OkRegistryClick(Sender:TObject);
Var
 X:String[255];
Begin
 If(FastHTTPModified)Then Begin
  Reg.Free;
  Reg:=TRegIniFile.Create('');
  Reg.RootKey:=HKEY_CURRENT_USER;
  Reg.OpenKey('\Software\Microsoft\Windows\Internet Settings',True);
  Reg.LazyWrite:=False;
  If(FastHTTP.State=cbUnchecked)Then Begin
   Reg.DeleteValue('MaxConnectionsPerServer');
   Reg.DeleteValue('MaxConnectionsPer1_0Server');
  End
   Else
  Begin
   Reg.WriteInteger('MaxConnectionsPerServer',4);
   Reg.WriteInteger('MaxConnectionsPer1_0Server',8);
  End;
 End;
 If(ShellIconCacheModified)Then Begin
  Reg.Free;
  Reg:=TRegIniFile.Create('');
  Reg.RootKey:=HKEY_LOCAL_MACHINE;
  Reg.OpenKey('\Software\Microsoft\Windows\CurrentVersion\Explorer',False);
  Reg.WriteString('Max Cached Icons',ShellIconCache.Text);
 End;
 If(SetupDirectoryModified)Then Begin
  Reg.Free;
  Reg:=TRegIniFile.Create('');
  Reg.RootKey:=HKEY_LOCAL_MACHINE;
  Reg.OpenKey('\Software\Microsoft\Windows\CurrentVersion\Setup',True);
  Reg.WriteString('SourcePath',SetupDirectory.Text);
 End;
 If(UserNameModified)Then Begin
  Reg.Free;
  Reg:=TRegIniFile.Create('');
  Reg.RootKey:=HKEY_LOCAL_MACHINE;
  Reg.OpenKey('\Software\Microsoft\Windows\CurrentVersion',True);
  Reg.WriteString('RegisteredOwner',UserName.Text);
 End;
 If(CompanyNameModified)Then Begin
  Reg.Free;
  Reg:=TRegIniFile.Create('');
  Reg.RootKey:=HKEY_LOCAL_MACHINE;
  Reg.OpenKey('\Software\Microsoft\Windows\CurrentVersion',True);
  Reg.WriteString('RegisteredOrganization',CompanyName.Text);
 End;
 If(ProductIdModified)Then Begin
  Reg.Free;
  Reg:=TRegIniFile.Create('');
  Reg.RootKey:=HKEY_LOCAL_MACHINE;
  Reg.OpenKey('\Software\Microsoft\Windows\CurrentVersion',True);
  Reg.WriteString('ProductId',ProductId.Text);
 End;
 If(ProductKeyModified)Then Begin
  Reg.Free;
  Reg:=TRegIniFile.Create('');
  Reg.RootKey:=HKEY_LOCAL_MACHINE;
  Reg.OpenKey('\Software\Microsoft\Windows\CurrentVersion',True);
  Reg.WriteString('ProductKey',ProductKey.Text);
 End;
 If(ProductNameModified)Then Begin
  Reg.Free;
  Reg:=TRegIniFile.Create('');
  Reg.RootKey:=HKEY_LOCAL_MACHINE;
  Reg.OpenKey('\Software\Microsoft\Windows\CurrentVersion',True);
  Reg.WriteString('ProductName',ProductName.Text);
 End;
 If(VersionModified)Then Begin
  Reg.Free;
  Reg:=TRegIniFile.Create('');
  Reg.RootKey:=HKEY_LOCAL_MACHINE;
  Reg.OpenKey('\Software\Microsoft\Windows\CurrentVersion',True);
  Reg.WriteString('Version',Version.Text);
 End;
 If(VersionNumberModified)Then Begin
  Reg.Free;
  Reg:=TRegIniFile.Create('');
  Reg.RootKey:=HKEY_LOCAL_MACHINE;
  Reg.OpenKey('\Software\Microsoft\Windows\CurrentVersion',True);
  Reg.WriteString('VersionNumber',VersionNumber.Text);
 End;
 If(SubVersionNumberModified)Then Begin
  Reg.Free;
  Reg:=TRegIniFile.Create('');
  Reg.RootKey:=HKEY_LOCAL_MACHINE;
  Reg.OpenKey('\Software\Microsoft\Windows\CurrentVersion',True);
  Reg.WriteString('SubVersionNumber',SubVersionNumber.Text);
 End;
 If(WinDirModified)Then Begin
  Reg.Free;
  Reg:=TRegIniFile.Create('');
  Reg.RootKey:=HKEY_LOCAL_MACHINE;
  Reg.OpenKey('\Software\Microsoft\Windows\CurrentVersion',True);
  Reg.WriteString('SystemRoot',WinDir.Text);
 End;
 If(ProgramFilesDirModified)Then Begin
  Reg.Free;
  Reg:=TRegIniFile.Create('');
  Reg.RootKey:=HKEY_LOCAL_MACHINE;
  Reg.OpenKey('\Software\Microsoft\Windows\CurrentVersion',True);
  Reg.WriteString('ProgramFilesDir',ProgramFilesDir.Text);
  Reg.WriteString('ProgramFilesPath',ProgramFilesDir.Text);
 End;
 If(WallPaperDirModified)Then Begin
  Reg.Free;
  Reg:=TRegIniFile.Create('');
  Reg.RootKey:=HKEY_LOCAL_MACHINE;
  Reg.OpenKey('\Software\Microsoft\Windows\CurrentVersion',True);
  Reg.WriteString('WallPaperDir',WallPaperDir.Text);
 End;
 If(IETitleModified)Then Begin
  Reg.Free;
  Reg:=TRegIniFile.Create('');
  Reg.RootKey:=HKEY_LOCAL_MACHINE;
  Reg.OpenKey('\Software\Microsoft\Internet Explorer\Main',True);
  Reg.WriteString('Window Title',IETitle.Text);
 End;
 If(PlayCDModified)Then Begin
  Reg.RootKey:=HKEY_CLASSES_ROOT;
  Reg.OpenKey('\AudioCD\shell',True);
  If(PlayCD.Checked)Then Reg.WriteString('','play')
                    Else Reg.WriteString('','');
 End;
 If(RunCDModified)Then Begin
  Reg.RootKey:=HKEY_CURRENT_USER;
  Reg.OpenKey('\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer',False);
  If(RunCd.Checked)Then X:=#$95#$00#$00#$00
                   Else X:=#$B5#$00#$00#$00;
  Reg.ReadBinaryData('NoDriveTypeAutoRun',X[1],4);
 End;
 Close;
End;

Procedure TFormRegWindows.CancelRegistryClick(Sender:TObject);Begin
 Close;
End;

Procedure TFormRegWindows.SetupDirectoryChange(Sender:TObject);Begin
 SetupDirectoryModified:=True;
End;

Procedure TFormRegWindows.UserNameChange(Sender:TObject);Begin
 UserNameModified:=True;
End;

Procedure TFormRegWindows.CompanyNameChange(Sender:TObject);Begin
 CompanyNameModified:=True;
End;

Procedure TFormRegWindows.ProductIdChange(Sender:TObject);Begin
 ProductIdModified:=True;
End;

Procedure TFormRegWindows.ProductKeyChange(Sender:TObject);Begin
 ProductKeyModified:=True;
End;

Procedure TFormRegWindows.ProductNameChange(Sender:TObject);Begin
 ProductNameModified:=True;
End;

Procedure TFormRegWindows.VersionChange(Sender:TObject);Begin
 VersionModified:=True;
End;

Procedure TFormRegWindows.VersionNumberChange(Sender:TObject);Begin
 VersionNumberModified:=True;
End;

Procedure TFormRegWindows.WinDirChange(Sender:TObject);Begin
 WinDirModified:=True;
End;

Procedure TFormRegWindows.SubVersionNumberChange(Sender:TObject);Begin
 SubVersionNumberModified:=True;
End;

Procedure TFormRegWindows.ProgramFilesDirChange(Sender:TObject);Begin
 ProgramFilesDirModified:=True;
End;

Procedure TFormRegWindows.IETitleChange(Sender:TObject);Begin
 IETitleModified:=True;
End;

Procedure TFormRegWindows.PlayCDClick(Sender:TObject);Begin
 PlayCDModified:=True;
End;

procedure TFormRegWindows.RunCDClick(Sender: TObject);
begin
 RunCDModified:=True;
end;

END.
