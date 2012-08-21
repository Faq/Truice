unit TextFieldEditorUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls;

type
  TTextFieldEditorForm = class(TForm)
    PageControl: TPageControl;
    TabSheet: TTabSheet;
    Panel: TPanel;
    Memo: TMemo;
    btOK: TButton;
    btCancel: TButton;
    procedure MemoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  TextFieldEditorForm: TTextFieldEditorForm;

implementation

{$R *.dfm}

procedure TTextFieldEditorForm.MemoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if key = VK_ESCAPE then ModalResult := mrCancel;
  
end;

end.
