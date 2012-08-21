unit WhoUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, DB,
  Menus, Buttons, JvExComCtrls, JvListView, ZAbstractRODataset, ZAbstractDataset, ZDataset;

type
  TWhoQuestForm = class(TForm)
    PageControl1: TPageControl;
    tsSearch: TTabSheet;
    pnSearch: TPanel;
    edWhoID: TLabeledEdit;
    edWhoName: TLabeledEdit;
    btSearch: TButton;
    lvWho: TJvListView;
    rgTypeOfWho: TRadioGroup;
    MyQuery: TZQuery;
    Panel1: TPanel;
    btOK: TButton;
    btCancel: TButton;
    Panel2: TPanel;
    Label1: TLabel;
    btBrowseSite: TButton;
    btEdit: TButton;
    pmBrowseSite: TPopupMenu;
    pmwowhead: TMenuItem;
    pmthottbot: TMenuItem;
    pmallakhazam: TMenuItem;
    btBrowseQuesterPopup: TBitBtn;
    pmwowdb: TMenuItem;
    pmruwowhead: TMenuItem;
    procedure btSearchClick(Sender: TObject);
    procedure lvWhoChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure FormShow(Sender: TObject);
    procedure btBrowseSiteClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btEditClick(Sender: TObject);
    procedure pmSiteClick(Sender: TObject);
    procedure lvWhoDblClick(Sender: TObject);
    procedure btBrowseQuesterPopupClick(Sender: TObject);
  private
    procedure Search();
  public
    procedure Prepare(Text: string);
  end;

var
  WhoQuestForm: TWhoQuestForm;

implementation

uses MainUnit, Functions, MyDataModule;

{$R *.dfm}

procedure TWhoQuestForm.btSearchClick(Sender: TObject);
begin
  Search();
  with lvWho do if Items.Count>0 then begin SetFocus; Selected:=Items[0]; end;  
end;

procedure TWhoQuestForm.Search;
var
  ID, WName, {WSubName,} QueryStr, WhereStr, TableName: string;

  // key field name
  kfname: string;
  // name field name
  nfname: string;
begin
  ID:= edWhoID.Text;

  case rgTypeOfWho.ItemIndex of
    0: begin
        TableName := 'creature_template';
        kfname := 'entry';
        nfname := 'name';
       end;
    1: begin
        TableName := 'gameobject_template';
        kfname := 'entry';
        nfname := 'name';
       end;
    2: begin
        TableName := 'item_template';
        kfname := 'entry';
        nfname := 'name';
       end;
  end;


  WName:=edWhoName.Text;
  WName:=StringReplace(WName, '''', '\''', [rfReplaceAll]);
  WName:=StringReplace(WName, ' ', '%', [rfReplaceAll]);
  WName:='%'+WName+'%';

  QueryStr:='';
  WhereStr:='';
  if ID<>'' then
    WhereStr:=Format('WHERE (`%s` = %s)',[kfname,ID]);

  if WName<>'' then
  begin
    if WhereStr<> '' then
      WhereStr:=Format('%s AND (`%s` LIKE ''%s'')',[WhereStr, nfname, WName])
    else
      WhereStr:=Format('WHERE (`%s` LIKE ''%s'')',[nfname, WName]);
  end;

  QueryStr:=Format('SELECT * FROM `%s` %s',[TableName, WhereStr]);

  MyQuery.SQL.Text:=QueryStr;
  lvWho.Items.BeginUpdate;
  try
    MyQuery.Open;
    lvWho.Clear;
    while not MyQuery.Eof do
    begin
      with lvWho.Items.Add do
      begin
        Caption:=MyQuery.FieldByName(kfname).AsString;
        SubItems.Add(MyQuery.FieldByName(nfname).AsString);
        MyQuery.Next;
      end;
    end;
  finally
    lvWho.Items.EndUpdate;
    MyQuery.Close;
  end;
end;

procedure TWhoQuestForm.lvWhoChange(Sender: TObject; Item: TListItem;
  Change: TItemChange);
begin
  btOK.Enabled:=Assigned(lvWho.Selected);
  btBrowseSite.Enabled:=Assigned(lvWho.Selected);
  btBrowseQuesterPopup.Enabled:=Assigned(lvWho.Selected);
  btEdit.Enabled:=Assigned(lvWho.Selected);
end;

procedure TWhoQuestForm.lvWhoDblClick(Sender: TObject);
begin
  if Assigned(TJvListView(Sender).Selected) then ModalResult:=mrOk;
end;

procedure TWhoQuestForm.Prepare(Text: string);
var
  who, key: string;
begin
  GetWhoAndKey(Text, who, key);
  if who='creature' then rgTypeOfWho.ItemIndex:=0;
  if who='gameobject' then rgTypeOfWho.ItemIndex:=1;
  if who='item' then rgTypeOfWho.ItemIndex:=2;
  edWhoID.Text:=key;
  Search;
end;

procedure TWhoQuestForm.FormShow(Sender: TObject);
begin
  with lvWho do if Items.Count>0 then begin SetFocus; Selected:=Items[0]; end
  else edWhoID.SetFocus;
end;

procedure TWhoQuestForm.btBrowseQuesterPopupClick(Sender: TObject);
var
  pt: TPoint;
begin
  pt.X := TButton(Sender).Width;
  pt.Y := 0;
  pt := TButton(Sender).ClientToScreen(pt);
  TButton(Sender).PopupMenu.PopupComponent := TButton(Sender);
  TButton(Sender).PopupMenu.Popup(pt.X, pt.Y);
end;

procedure TWhoQuestForm.btBrowseSiteClick(Sender: TObject);
begin
  if assigned(lvWho.Selected) then
  begin
    case rgTypeOfWho.ItemIndex of
      0: dmMain.BrowseSite(ttNPC, StrToInt(lvWho.Selected.Caption));
      1: dmMain.BrowseSite(ttObject, StrToInt(lvWho.Selected.Caption));
      2: dmMain.BrowseSite(ttItem, StrToInt(lvWho.Selected.Caption));
    end;
  end;
end;

procedure TWhoQuestForm.FormCreate(Sender: TObject);
begin
  dmMain.Translate.CreateDefaultTranslation(TForm(Self));
  dmMain.Translate.TranslateForm(TForm(Self));  
end;

procedure TWhoQuestForm.btEditClick(Sender: TObject);
begin
  if (rgTypeOfWho.ItemIndex=0) and Assigned(lvWho.Selected) then
  begin
    ModalResult:=mrCancel;
    MainForm.PageControl1.ActivePageIndex:=1;
    MainForm.PageControl3.ActivePageIndex:=1;
    MainForm.edctEntry.Text:=lvWho.Selected.Caption;
    MainForm.edctEntry.Button.Click;
  end;
  if (rgTypeOfWho.ItemIndex=1) and Assigned(lvWho.Selected) then
  begin
    ModalResult:=mrCancel;
    MainForm.PageControl1.ActivePageIndex:=2;
    MainForm.PageControl4.ActivePageIndex:=1;
    MainForm.edgtentry.Text:=IntToStr(abs(StrToInt(lvWho.Selected.Caption)));
    MainForm.edgtentry.Button.Click;
  end;
end;

procedure TWhoQuestForm.pmSiteClick(Sender: TObject);
var
  par : TType;
begin
  par:=ttNPC;
  case rgTypeOfWho.ItemIndex of
    0: par:=ttNPC;
    1: par:=ttObject;
    2: par:=ttItem;
  end;
  if Assigned(lvWho.Selected) then
  begin
    if TMenuItem(Sender).Name='pmwowhead' then
        dmMain.wowhead(par, StrToInt(lvWho.Selected.Caption));
    if TMenuItem(Sender).Name='pmruwowhead' then
        dmMain.ruwowhead(par, StrToInt(lvWho.Selected.Caption));
    if TMenuItem(Sender).Name='pmallakhazam' then
        dmMain.allakhazam(par, StrToInt(lvWho.Selected.Caption));
    if TMenuItem(Sender).Name='pmthottbot' then
        dmMain.thottbot(par, StrToInt(lvWho.Selected.Caption));
    if TMenuItem(Sender).Name='pmwowdb' then
        dmMain.wowdb(par, StrToInt(lvWho.Selected.Caption));
  end;
end;

end.
