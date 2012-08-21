unit ListUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ExtCtrls, JvExComCtrls, JvListView, TntComCtrls;

type
  TListForm = class(TForm)
    Panel1: TPanel;
    btOK: TButton;
    btCancel: TButton;
    pnSearch: TPanel;
    edSearchMask: TLabeledEdit;
    lvList: TTntListView;
    procedure lvList2Change(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure edSearchMaskChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure lvList2DblClick(Sender: TObject);
    procedure lvListColumnClick(Sender: TObject; Column: TListColumn);
  private
    prmName, prmID: integer;
    procedure Search();
  public
    procedure Prepare(Text: string);
  end;

var
  ListForm: TListForm;

implementation

uses MyDataModule, Functions;

{$R *.dfm}

{ TListForm }

procedure TListForm.Prepare(Text: string);
var
  i: integer;
begin
  if Trim(Text)='' then Exit;
  for i:=0 to lvList.Items.Count - 1 do
  begin
    if lvList.Items[i].Caption = Text then
    begin
      lvList.Selected:=lvList.Items[i];
      lvList.Selected.MakeVisible(false);
      Exit;
    end;
  end;
end;

procedure TListForm.Search;
var
  i: integer;
begin
  for i:=0 to lvList.Items.Count - 1 do
  begin
    if Pos(LowerCase(edSearchMask.Text), LowerCase(lvList.Items[i].SubItems[0])) > 0  then
    begin
      lvList.Selected:=lvList.Items[i];
      lvList.Selected.MakeVisible(false);
      Exit;
    end;
  end;
end;

procedure TListForm.lvList2Change(Sender: TObject; Item: TListItem;
  Change: TItemChange);
begin
  btOK.Enabled:=Assigned(lvList.Selected);
end;

procedure TListForm.lvList2DblClick(Sender: TObject);
begin
  if Assigned(TJvListView(Sender).Selected) then ModalResult:=mrOk;
end;

procedure TListForm.lvListColumnClick(Sender: TObject; Column: TListColumn);
begin
  if column.Index = 0 then
  begin
    lvList.CustomSort(@CustomIDSortProc, prmID);
    prmID := -prmID;
  end
  else
  begin
    lvList.CustomSort(@CustomNameSortProc, prmName);
    prmName := -prmName;    
  end;
end;

procedure TListForm.edSearchMaskChange(Sender: TObject);
begin
  Search;
end;

procedure TListForm.FormCreate(Sender: TObject);
begin
  prmName := 1;
  prmID := 1;
  dmMain.Translate.CreateDefaultTranslation(TForm(Self));
  dmMain.Translate.TranslateForm(TForm(Self));
end;

procedure TListForm.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if key = vk_escape then Close;
end;


end.
