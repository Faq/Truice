unit ItemLootUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ExtCtrls, DB,
  JvExComCtrls, JvListView,
  ZAbstractRODataset, ZAbstractDataset, ZDataset;

type
  TItemLootForm = class(TForm)
    Panel1: TPanel;
    btClose: TButton;
    PageControl1: TPageControl;
    tsLoot: TTabSheet;
    lvItemLoot: TJvListView;
    MyQuery: TZQuery;
    procedure FormCreate(Sender: TObject);
  public
    procedure Prepare(key: string);
  end;

implementation

uses MainUnit, MyDataModule;

{$R *.dfm}

procedure TItemLootForm.Prepare(key: string);
begin
  // load creature loot
  MainForm.LoadLoot(lvItemLoot, key);
end;

procedure TItemLootForm.FormCreate(Sender: TObject);
begin
  dmMain.Translate.CreateDefaultTranslation(TForm(Self));
  dmMain.Translate.TranslateForm(TForm(Self));
end;

end.
