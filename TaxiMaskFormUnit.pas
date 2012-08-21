unit TaxiMaskFormUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, CharacterDataUnit, Grids, ValEdit, StdCtrls, ExtCtrls;

type
  TTaxiMaskForm = class(TForm)
    Panel1: TPanel;
    btOK: TButton;
    btCancel: TButton;
    vleMain: TValueListEditor;
  private
    { Private declarations }
    function ReadData: string;
    procedure SetData(const Value: string);
    procedure SetKeys;
  public
    { Public declarations }
    property Data: string read ReadData write SetData;
  end;

implementation

{$R *.dfm}

{ TTaxiMaskForm }

function TTaxiMaskForm.ReadData: string;
var
  i : integer;
begin
  Result := '';
  for i := 1 to vleMain.RowCount - 1 do
    Result := Result + vleMain.Cells[1,i] + ' ';
end;

procedure TTaxiMaskForm.SetData(const Value: string);
begin
  ExtractStrings([' '], [], PWideChar(Value), vleMain.Strings);
  SetKeys;
end;

procedure TTaxiMaskForm.SetKeys;
begin
  SetCursor(LoadCursor(0,IDC_WAIT));
end;

end.
