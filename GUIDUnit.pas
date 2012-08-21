unit GUIDUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ExtCtrls, DB,
  Menus, Buttons, JvExComCtrls, JvListView,
  ZAbstractRODataset, ZAbstractDataset, ZDataset;

type
  TGUIDForm = class(TForm)
    PageControl1: TPageControl;
    tsSearch: TTabSheet;
    pnSearch: TPanel;
    edID: TLabeledEdit;
    edName: TLabeledEdit;
    btSearch: TButton;
    Panel1: TPanel;
    btOK: TButton;
    btCancel: TButton;
    MyQuery: TZQuery;
    lvGUID: TJvListView;
    lvCreatureOrGO: TJvListView;
    procedure lvGUIDChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure btSearchClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure lvGUIDSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
    procedure lvCreatureOrGOSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
    procedure FormShow(Sender: TObject);
    procedure lvGUIDDblClick(Sender: TObject);
  private
    Fotype : string;
    procedure Search();

  public
    GUID: string;
//    Entry: string;
//    Name: string;
    procedure Prepare(Text: string);
    constructor CreateEx(AOwner: TComponent; otype: string);
  end;


implementation

uses MainUnit, MyDataModule;

{$R *.dfm}

{ TGUIDForm }

procedure TGUIDForm.Prepare(Text: string);
var
  i: integer;
begin
  MyQuery.SQL.Text := Format('SELECT `id` FROM `%s` WHERE `guid`=%s',[Fotype, Text]);
  MyQuery.Open;
  if not MyQuery.Eof then
  begin
    edID.Text := MyQuery.Fields[0].AsString;
    Search;
    with lvCreatureOrGO do if Items.Count>0 then begin Selected:=Items[0]; end;
    for I := 0 to lvGUID.Items.Count - 1 do
    begin
      if lvGUID.Items[i].Caption = Text  then 
      begin
        lvGUID.Items[i].Selected := true;
        lvGUID.Items[i].MakeVisible(false);
        exit;
      end;
    end;
  end;
  MyQuery.Close;
end;

procedure TGUIDForm.Search;
var
  ID, Name, QueryStr, WhereStr, isminus: string;
begin
  ID:= edID.Text;

  Name:=edName.Text;
  Name:=StringReplace(Name, '''', '\''', [rfReplaceAll]);
  Name:=StringReplace(Name, ' ', '%', [rfReplaceAll]);
  Name:='%'+Name+'%';

  QueryStr:='';
  WhereStr:='';
  
  if ID<>'' then
    WhereStr:=Format('WHERE (`entry` = %s)',[ID]);

  if Name<>'' then
  begin
    if WhereStr<> '' then
      WhereStr:=Format('%s AND (`name` LIKE ''%s'')',[WhereStr, Name])
    else
      WhereStr:=Format('WHERE (`name` LIKE ''%s'')',[Name]);
  end;

  QueryStr:=Format('SELECT * FROM `%s_template` %s',[Fotype, WhereStr]);

  MyQuery.SQL.Text:=QueryStr;
  lvCreatureOrGO.Items.BeginUpdate;
  try
    MyQuery.Open;
    lvCreatureOrGO.Items.Clear;
    while not MyQuery.Eof do
    begin
      with lvCreatureOrGO.Items.Add do
      begin
        Caption:=isminus+MyQuery.FieldByName('entry').AsString;
        SubItems.Add(MyQuery.FieldByName('name').AsString);
        MyQuery.Next;
      end;
    end;
  finally
    lvCreatureOrGO.Items.EndUpdate;
    MyQuery.Close;
  end;
end;

procedure TGUIDForm.lvCreatureOrGOSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
var
  entry : string;
begin
  if Item.Selected then
  begin
    entry := Item.Caption;
    MyQuery.SQL.Text := Format('SELECT * FROM `%s` WHERE `id`=%s',[Fotype, entry]);
    lvGUID.Items.BeginUpdate;
    try
      lvGUID.Items.Clear;
      MyQuery.Open;
      while not MyQuery.Eof do
      begin
        with lvGUID.Items.Add do
        begin
          Caption := MyQuery.FieldByName('guid').AsString;
          SubItems.Add(MyQuery.FieldByName('map').AsString);
          SubItems.Add(MyQuery.FieldByName('position_x').AsString);
          SubItems.Add(MyQuery.FieldByName('position_y').AsString);
          SubItems.Add(MyQuery.FieldByName('position_z').AsString);
        end;
        MyQuery.Next;
      end;
    finally
      MyQuery.Close;
      lvGUID.Items.EndUpdate;
    end;
  end;
end;

procedure TGUIDForm.lvGUIDChange(Sender: TObject;
  Item: TListItem; Change: TItemChange);
begin
  btOK.Enabled:=Assigned(lvCreatureOrGO.Selected);
end;

procedure TGUIDForm.lvGUIDDblClick(Sender: TObject);
begin
  if Assigned(TJvListView(Sender).Selected) then ModalResult:=mrOk;
end;

procedure TGUIDForm.lvGUIDSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
begin
  if Assigned(lvGUID.Selected) then
    GUID := lvGUID.Selected.Caption;
end;

procedure TGUIDForm.btSearchClick(Sender: TObject);
begin
  Search();
  with lvCreatureOrGO do if Items.Count>0 then begin SetFocus; Selected:=Items[0]; end;
end;

constructor TGUIDForm.CreateEx(AOwner: TComponent; otype: string);
begin
  inherited Create(AOwner);
  Fotype := otype;
  caption := 'Get GUID for ' + otype;
end;

procedure TGUIDForm.FormCreate(Sender: TObject);
begin
  dmMain.Translate.CreateDefaultTranslation(TForm(Self));
  dmMain.Translate.TranslateForm(TForm(Self));
end;

procedure TGUIDForm.FormShow(Sender: TObject);
begin
  lvGUID.SetFocus;
end;

end.
