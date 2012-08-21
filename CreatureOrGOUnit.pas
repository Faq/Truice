unit CreatureOrGOUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ExtCtrls, DB,
  Menus, Buttons, JvExComCtrls, JvListView,
  ZAbstractRODataset, ZAbstractDataset, ZDataset;

type
  TCreatureOrGOForm = class(TForm)
    PageControl1: TPageControl;
    tsSearch: TTabSheet;
    pnSearch: TPanel;
    edID: TLabeledEdit;
    edName: TLabeledEdit;
    btSearch: TButton;
    rgCreatureOrGO: TRadioGroup;
    Panel1: TPanel;
    btOK: TButton;
    btCancel: TButton;
    MyQuery: TZQuery;
    lvCreatureOrGO: TJvListView;
    btBrowseSite: TButton;
    btEditCreatureOrGO: TButton;
    pmBrowseSite: TPopupMenu;
    pmwowhead: TMenuItem;
    pmthottbot: TMenuItem;
    pmallakhazam: TMenuItem;
    btBrowseCreatureOrGOPopup: TBitBtn;
    pmwowdb: TMenuItem;
    pmruwowhead: TMenuItem;
    procedure lvCreatureOrGOChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure FormShow(Sender: TObject);
    procedure btSearchClick(Sender: TObject);
    procedure btBrowseSiteClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btEditCreatureOrGOClick(Sender: TObject);
    procedure pmSiteClick(Sender: TObject);
    procedure lvCreatureOrGODblClick(Sender: TObject);
    procedure btBrowseCreatureOrGOPopupClick(Sender: TObject);
  private
    procedure Search();
  public
    procedure Prepare(Text: string);
  end;

var
  CreatureOrGOForm: TCreatureOrGOForm;

implementation

uses MainUnit, MyDataModule;

{$R *.dfm}

{ TCreatureOrGOForm }

procedure TCreatureOrGOForm.Prepare(Text: string);
var
  id: integer;
begin
  id:=StrToIntDef(Text,0);
  if id>0 then rgCreatureOrGO.ItemIndex:=0 else
  if id<0 then rgCreatureOrGO.ItemIndex:=1 else Exit;
  edID.Text:=IntToStr(ABS(id));
  Search;
end;

procedure TCreatureOrGOForm.Search;
var
  ID, Name, QueryStr, WhereStr, TableName,isminus: string;
begin
  ID:= edID.Text;

  case rgCreatureOrGO.ItemIndex of
    0:
      begin
        TableName := 'creature_template';
        isminus:='';
      end;
    1:
      begin
        isminus:='-';
        TableName := 'gameobject_template';
      end;
  end;

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

  QueryStr:=Format('SELECT * FROM `%s` %s',[TableName, WhereStr]);

  MyQuery.SQL.Text:=QueryStr;
  lvCreatureOrGO.Items.BeginUpdate;
  try
    MyQuery.Open;
    lvCreatureOrGO.Clear;
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

procedure TCreatureOrGOForm.lvCreatureOrGOChange(Sender: TObject;
  Item: TListItem; Change: TItemChange);
begin
  btOK.Enabled:=Assigned(lvCreatureOrGO.Selected);
  btBrowseSite.Enabled:=Assigned(lvCreatureOrGO.Selected);
  btBrowseCreatureOrGOPopup.Enabled:=Assigned(lvCreatureOrGO.Selected);
  btEditCreatureOrGO.Enabled:=Assigned(lvCreatureOrGO.Selected);
end;

procedure TCreatureOrGOForm.lvCreatureOrGODblClick(Sender: TObject);
begin
  if Assigned(TJvListView(Sender).Selected) then ModalResult:=mrOk;
end;

procedure TCreatureOrGOForm.FormShow(Sender: TObject);
begin
  with lvCreatureOrGO do if Items.Count>0 then begin SetFocus; Selected:=Items[0]; end;
end;

procedure TCreatureOrGOForm.btSearchClick(Sender: TObject);
begin
  Search();
  with lvCreatureOrGO do if Items.Count>0 then begin SetFocus; Selected:=Items[0]; end;
end;

procedure TCreatureOrGOForm.btBrowseCreatureOrGOPopupClick(Sender: TObject);
var
  pt: TPoint;
begin
  pt.X := TButton(Sender).Width;
  pt.Y := 0;
  pt := TButton(Sender).ClientToScreen(pt);
  TButton(Sender).PopupMenu.PopupComponent := TButton(Sender);
  TButton(Sender).PopupMenu.Popup(pt.X, pt.Y);
end;

procedure TCreatureOrGOForm.btBrowseSiteClick(Sender: TObject);
begin
  if assigned(lvCreatureOrGO.Selected) then
  begin
    case rgCreatureOrGO.ItemIndex of
      0: dmMain.BrowseSite(ttNPC, StrToInt(lvCreatureOrGO.Selected.Caption));
      1: dmMain.BrowseSite(ttObject, StrToInt(lvCreatureOrGO.Selected.Caption));
    end;
  end;
end;

procedure TCreatureOrGOForm.FormCreate(Sender: TObject);
begin
  dmMain.Translate.CreateDefaultTranslation(TForm(Self));
  dmMain.Translate.TranslateForm(TForm(Self));
end;

procedure TCreatureOrGOForm.btEditCreatureOrGOClick(Sender: TObject);
begin
  if (rgCreatureOrGO.ItemIndex=0) and Assigned(lvCreatureOrGO.Selected) then
  begin
    ModalResult:=mrCancel;
    MainForm.PageControl1.ActivePageIndex:=1;
    MainForm.PageControl3.ActivePageIndex:=1;
    MainForm.edctEntry.Text:=lvCreatureOrGO.Selected.Caption;
    MainForm.edctEntry.Button.Click;
  end;
  if (rgCreatureOrGO.ItemIndex=1) and Assigned(lvCreatureOrGO.Selected) then
  begin
    ModalResult:=mrCancel;
    MainForm.PageControl1.ActivePageIndex:=2;
    MainForm.PageControl4.ActivePageIndex:=1;
    MainForm.edgtentry.Text:=IntToStr(abs(StrToInt(lvCreatureOrGO.Selected.Caption)));
    MainForm.edgtentry.Button.Click;
  end;
end;

procedure TCreatureOrGOForm.pmSiteClick(Sender: TObject);
var
  par : TType;
begin
  if rgCreatureOrGO.ItemIndex=0 then par:=ttNPC else par:=ttObject;
  if Assigned(lvCreatureOrGO.Selected) then
  begin
    if TMenuItem(Sender).Name='pmwowhead' then
        dmMain.wowhead(par, StrToInt(lvCreatureOrGO.Selected.Caption));
    if TMenuItem(Sender).Name='pmruwowhead' then
        dmMain.ruwowhead(par, StrToInt(lvCreatureOrGO.Selected.Caption));
    if TMenuItem(Sender).Name='pmallakhazam' then
        dmMain.allakhazam(par, StrToInt(lvCreatureOrGO.Selected.Caption));
    if TMenuItem(Sender).Name='pmthottbot' then
        dmMain.thottbot(par, StrToInt(lvCreatureOrGO.Selected.Caption));
    if TMenuItem(Sender).Name='pmwowdb' then
        dmMain.wowdb(par, StrToInt(lvCreatureOrGO.Selected.Caption));
  end;
end;


end.
