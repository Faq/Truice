unit MeConnectForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, TypInfo, ZConnection;

type
  TMeConnectForm = class(TForm)
    btConnect: TButton;
    btCancel: TButton;
    btDetails: TButton;
    gbAdvanced: TGroupBox;
    btClear: TButton;
    gbConnect: TGroupBox;
    edUsername: TEdit;
    lbUsername: TLabel;
    lbPassword: TLabel;
    edPassword: TEdit;
    edServer: TComboBox;
    lbServer: TLabel;
    lbPort: TLabel;
    edPort: TEdit;
    edmDatabase: TComboBox;
    lbmDatabase: TLabel;
    cbSavePassword: TCheckBox;
    Image1: TImage;
    lbCharSet: TLabel;
    edCharSet: TEdit;
    cbUnicode: TCheckBox;
    edcDatabase: TComboBox;
    lbcDatabase: TLabel;
    edrDatabase: TComboBox;
    lbrDatabase: TLabel;
    procedure btConnectClick(Sender: TObject);
    procedure edServerDropDown(Sender: TObject);
    procedure GetDataBases(Sender: TObject);
    procedure edExit(Sender: TObject);
    procedure btDetailsClick(Sender: TObject);
    procedure btClearClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edServerChange(Sender: TObject);

  private
    FListGot : boolean;
    procedure SaveSettings;
    procedure LoadSettings;
    procedure SavePassword;
    procedure LoadPassword;
    procedure GetServerList(Items: TStrings);
  protected
    procedure DoInit;
    procedure DoConnect;
  end;

implementation

uses MainUnit, MyDataModule, Functions, Registry;

{$R *.dfm}

procedure TMeConnectForm.DoInit;
begin
  FListGot := false;
   if (edUsername.Text <> '') and (edPassword.Text = '') then
      ActiveControl := edPassword;
  LoadSettings;
  if cbSavePassword.Checked then begin
    LoadPassword;
  end;
end;

procedure TMeConnectForm.DoConnect;
begin
  edExit(nil);
  MainForm.CharDBName := edcDatabase.Text;
  MainForm.RealmDBName := edrDatabase.Text;
  try
    if MainForm.MyTrinityConnection.Connected then
      MainForm.MyTrinityConnection.Disconnect;
    MainForm.MyTrinityConnection.Connect;
    if Trim(edCharSet.Text) <> '' then
    begin
      MainForm.MyTempQuery.SQL.Text := Format('SET NAMES %s',[edCharSet.Text]);
      MainForm.MyTempQuery.ExecSQL;
    end;
    ModalResult := mrOk;
  except
    ModalResult := mrNone;
    raise;
  end;
end;

procedure TMeConnectForm.btConnectClick(Sender: TObject);
begin
  SaveSettings;
  DoConnect;
  if cbSavePassword.Checked then begin
    SavePassword;
  end;
end;

procedure TMeConnectForm.edServerDropDown(Sender: TObject);
var
  OldCursor: TCursor;
begin
  if FListGot then
    Exit;
  FListGot := True;
  OldCursor := Screen.Cursor;
  Screen.Cursor := crSQLWait;
  try
    GetServerList(edServer.Items);
  finally
    Screen.Cursor := OldCursor;
  end;
end;

procedure TMeConnectForm.GetServerList(Items: TStrings);
begin
  with TRegistry.Create do
  try
    RootKey:= HKEY_CURRENT_USER;
    if OpenKey('Software\' + Trim(ProgramName) + '\servers', false) then
      GetKeyNames(Items);
  finally
    Free;
  end;
end;

procedure TMeConnectForm.GetDataBases(Sender: TObject);
var
  OldCursor: TCursor;
  WasConnected: Boolean;
begin
  edmDatabase.Items.Clear;
  edcDatabase.Items.Clear;
  edrDatabase.Items.Clear;
  OldCursor := Screen.Cursor;
  Screen.Cursor := crSQLWait;
  try
    WasConnected := MainForm.MyTrinityConnection.Connected;
    if not WasConnected then    
      MainForm.MyTrinityConnection.Connect;
    MainForm.MyTrinityConnection.GetCatalogNames(edmDatabase.Items);
    edcDatabase.Items.AddStrings(edmDatabase.Items);
    edrDatabase.Items.AddStrings(edmDatabase.Items);
    if not WasConnected then
      MainForm.MyTrinityConnection.Disconnect;
  finally
    Screen.Cursor := OldCursor;
  end;
end;

procedure TMeConnectForm.edExit(Sender: TObject);
begin
  try
    MainForm.MyTrinityConnection.Password := edPassword.Text;
    MainForm.MyTrinityConnection.HostName := edServer.Text;
    MainForm.MyTrinityConnection.User := edUsername.Text;
    MainForm.MyTrinityConnection.Database := edmDatabase.Text;
    MainForm.MyTrinityConnection.Port := StrToIntDef(edPort.Text, 3306);
  except
    ActiveControl := Sender as TWinControl;
    raise;
  end;
end;

procedure TMeConnectForm.LoadPassword;
begin
  edPassword.Text:=ReadFromRegistry(CurrentUser, '', 'Password', tpString, '');
end;

procedure TMeConnectForm.SavePassword;
begin
  WriteToRegistry(CurrentUser, '', 'Password', tpString, edPassword.Text);
  WriteToRegistry(CurrentUser, 'servers\' + edServer.Text, 'Password', tpString, edPassword.Text);
end;

procedure TMeConnectForm.LoadSettings;
begin
  cbSavePassword.Checked:=ReadFromRegistry(CurrentUser, '', 'SavePass', tpBool, false);
  edServer.Text:=ReadFromRegistry(CurrentUser, '', 'Server', tpString, '');
  edUsername.Text:=ReadFromRegistry(CurrentUser, '', 'Username', tpString, '');
  edPort.Text:=ReadFromRegistry(CurrentUser, '', 'Port', tpString, '');
  edCharSet.Text:=ReadFromRegistry(CurrentUser, '', 'Charset', tpString, '');
  cbUnicode.Checked:=ReadFromRegistry(CurrentUser, '', 'Unicode', tpBool, false);
end;

procedure TMeConnectForm.SaveSettings;
begin
  WriteToRegistry(CurrentUser, '', 'SavePass',  tpBool,   cbSavePassword.Checked);
  WriteToRegistry(CurrentUser, '', 'Server',    tpString, edServer.Text);
  WriteToRegistry(CurrentUser, '', 'Username',  tpString, edUsername.Text);
  WriteToRegistry(CurrentUser, '', 'cDatabase', tpString, edcDatabase.Text);
  WriteToRegistry(CurrentUser, '', 'mDatabase', tpString, edmDatabase.Text);
  WriteToRegistry(CurrentUser, '', 'rDatabase', tpString, edrDatabase.Text);
  WriteToRegistry(CurrentUser, '', 'Port',      tpString, edPort.Text);
  WriteToRegistry(CurrentUser, '', 'Charset',   tpString, edCharSet.Text);
  WriteToRegistry(CurrentUser, '', 'Unicode',   tpBool,   cbUnicode.Checked);

  WriteToRegistry(CurrentUser, 'servers\' + edServer.Text, 'SavePass',  tpBool,   cbSavePassword.Checked);
  WriteToRegistry(CurrentUser, 'servers\' + edServer.Text, 'Username',  tpString, edUsername.Text);
  WriteToRegistry(CurrentUser, 'servers\' + edServer.Text, 'mDatabase', tpString, edmDatabase.Text);
  WriteToRegistry(CurrentUser, 'servers\' + edServer.Text, 'cDatabase', tpString, edcDatabase.Text);
  WriteToRegistry(CurrentUser, 'servers\' + edServer.Text, 'rDatabase', tpString, edrDatabase.Text);
  WriteToRegistry(CurrentUser, 'servers\' + edServer.Text, 'Port',      tpString, edPort.Text);
  WriteToRegistry(CurrentUser, 'servers\' + edServer.Text, 'Charset',   tpString, edCharSet.Text);
  WriteToRegistry(CurrentUser, 'servers\' + edServer.Text, 'Unicode',   tpBool,   cbUnicode.Checked);
end;

procedure TMeConnectForm.btDetailsClick(Sender: TObject);
const
  mH = 80;
begin
  if pos('>>', btDetails.Caption)>0 then
  begin
    ClientHeight:=ClientHeight+gbAdvanced.Height+10;
    btDetails.Caption:=dmMain.Text[77]; //'<< Details';
    gbAdvanced.Visible:=true;
  end
  else
  begin
    ClientHeight:=ClientHeight-gbAdvanced.Height-10;
    btDetails.Caption:=dmMain.Text[78]; //'Details >>';
    gbAdvanced.Visible:=false;    
  end;
end;

procedure TMeConnectForm.btClearClick(Sender: TObject);
begin
  edUsername.Clear;
  edPassword.Clear;
  edServer.Clear;
  edPort.Clear;
  edmDatabase.Clear;
  edcDatabase.Clear;
  edrDatabase.Clear;
  edCharSet.Clear;
  cbUnicode.Checked:=false;
end;

procedure TMeConnectForm.FormCreate(Sender: TObject);
begin
  ClientHeight:=292;
  DoInit;  
  Caption := Format('Truice %s',[VERSION_EXE]);
  dmMain.Translate.CreateDefaultTranslation(TForm(Self));
end;

procedure TMeConnectForm.FormShow(Sender: TObject);
var
  mDBname, cDBname, rDBname, sDBname: string;
  AC: TWinControl;
begin
  dmMain.Translate.TranslateForm(TForm(Self));
  Caption := Format('Truice %s',[VERSION_EXE]);
  mDBname:=ReadFromRegistry(CurrentUser, '', 'mDatabase',  tpString, '');
  cDBname:=ReadFromRegistry(CurrentUser, '', 'cDatabase',  tpString, '');
  rDBname:=ReadFromRegistry(CurrentUser, '', 'rDatabase',  tpString, '');
  sDBname:=ReadFromRegistry(CurrentUser, '', 'sDatabase',  tpString, '');

  edExit(Sender);

  try
    GetDataBases(Sender);
    if mDBname<>'' then
      edmDatabase.ItemIndex:=edmDatabase.Items.IndexOf(mDBName);
    if cDBname<>'' then
      edcDatabase.ItemIndex:=edcDatabase.Items.IndexOf(cDBName);
    if rDBname<>'' then
      edrDatabase.ItemIndex:=edrDatabase.Items.IndexOf(rDBName);
  except
    if edmDatabase.Text='' then
      edmDatabase.Text:=mDBName;
    if edcDatabase.Text='' then
      edcDatabase.Text:=cDBName;
    if edrDatabase.Text='' then
      edrDatabase.Text:=rDBName;
  end;

  AC := edServer;
  if edServer.Text <> '' then AC := edPort;
  if edPort.Text <> '' then AC := edUsername;
  if edUsername.Text <> '' then AC := edPassword;
  if edPassword.Text <> '' then AC := btConnect;
  FocusControl(AC);
end;

procedure TMeConnectForm.edServerChange(Sender: TObject);
begin
  cbSavePassword.Checked:=ReadFromRegistry(CurrentUser, 'servers\' + edServer.Text, 'SavePass', tpBool, false);

  if cbSavePassword.Checked then
    edPassword.Text:=ReadFromRegistry(CurrentUser, 'servers\' + edServer.Text, 'Password', tpString, '');

  edUsername.Text:=ReadFromRegistry(CurrentUser, 'servers\' + edServer.Text, 'Username',  tpString, '');
  edmDatabase.Text:=ReadFromRegistry(CurrentUser, 'servers\' + edServer.Text, 'mDatabase',  tpString, '');
  edcDatabase.Text:=ReadFromRegistry(CurrentUser, 'servers\' + edServer.Text, 'cDatabase',  tpString, '');
  edrDatabase.Text:=ReadFromRegistry(CurrentUser, 'servers\' + edServer.Text, 'rDatabase',  tpString, '');
  edPort.Text:=ReadFromRegistry(CurrentUser, 'servers\' + edServer.Text, 'Port',      tpString, '');
  edCharSet.Text:=ReadFromRegistry(CurrentUser,'servers\' + edServer.Text, 'Charset', tpString, '');
  cbUnicode.Checked:=ReadFromRegistry(CurrentUser, 'servers\' + edServer.Text, 'Unicode', tpBool, false);
end;

end.

