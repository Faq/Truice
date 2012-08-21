unit UnitFlagsUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, CheckLst, ExtCtrls;

type
  TUnitFlagsForm = class(TForm)
    Bevel: TBevel;
    btCancel: TButton;
    btOK: TButton;
    clbMain: TCheckListBox;
    procedure FormCreate(Sender: TObject);
    procedure btOKClick(Sender: TObject);
  private
    FFlags: int64;
    { Private declarations }
  public
    { Public declarations }
    property Flags: int64 read FFlags;
    procedure Prepare(Text: string);
    procedure Load(What: string);
  end;

implementation

uses MyDataModule, Functions;

{$R *.dfm}

{ TUnitFlagsForm }

procedure TUnitFlagsForm.btOKClick(Sender: TObject);
var
  i: integer;
  skip: boolean;
begin
  skip := false;
  FFlags := 0;
  for i := 0 to clbMain.Items.Count - 1 do
    if clbMain.Checked[i] then FFlags := FFlags or (1 shl i) else skip := true;
  if not skip then fflags := -1;  
end;

procedure TUnitFlagsForm.FormCreate(Sender: TObject);
begin
  dmMain.Translate.CreateDefaultTranslation(TForm(Self));
  dmMain.Translate.TranslateForm(TForm(Self));
end;

procedure TUnitFlagsForm.Load(What: string);
begin
  Caption := What;
  LoadStringListFromFile(clbMain.Items, What);
  if clbMain.Items.Count <= 16  then clbMain.Columns := 1;
end;

procedure TUnitFlagsForm.Prepare(Text: string);
var
  i: integer;
begin
  FFlags := StrToInt64Def(Text,0);
  for i := 0 to clbMain.Items.Count - 1 do
  begin
    if FFlags and (1 shl i) <> 0 then
      clbMain.Checked[i] := true;
  end;
end;

end.
