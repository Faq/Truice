program Truice;

uses
  Forms,
  MainUnit in 'MainUnit.pas' {MainForm},
  WhoUnit in 'WhoUnit.pas' {WhoQuestForm},
  ItemUnit in 'ItemUnit.pas' {ItemForm},
  CreatureOrGOUnit in 'CreatureOrGOUnit.pas' {CreatureOrGOForm},
  ListUnit in 'ListUnit.pas' {ListForm},
  About in 'About.pas' {AboutBox},
  CheckUnit in 'CheckUnit.pas' {CheckForm},
  SpellsUnit in 'SpellsUnit.pas' {SpellsForm},
  SettingsUnit in 'SettingsUnit.pas' {SettingsForm},
  MyDataModule in 'MyDataModule.pas' {dmMain: TDataModule},
  CheckQuestThreadUnit in 'CheckQuestThreadUnit.pas',
  Translate in 'Translate.pas',
  ItemLootUnit in 'ItemLootUnit.pas' {ItemLootForm},
  ItemPageUnit in 'ItemPageUnit.pas' {ItemPageForm},
  GUIDUnit in 'GUIDUnit.pas' {GUIDForm},
  TextFieldEditorUnit in 'TextFieldEditorUnit.pas' {TextFieldEditorForm},
  CharacterDataUnit in 'CharacterDataUnit.pas' {CharacterDataForm},
  TaxiMaskFormUnit in 'TaxiMaskFormUnit.pas' {TaxiMaskForm},
  UnitFlagsUnit in 'UnitFlagsUnit.pas' {UnitFlagsForm},
  MeConnectForm in 'MeConnectForm.pas' {MeConnectForm},
  DBCfile in 'DBCfile.pas',
  AreaTableUnit in 'AreaTableUnit.pas' {AreaTableForm},
  Functions in 'Functions.pas';

{$R *.res}
begin
  Application.Initialize;
  Application.Title := 'Truice';
  Application.ShowMainForm:=false;
  Application.CreateForm(TdmMain, dmMain);
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TSpellsForm, SpellsForm);
  Application.CreateForm(TCheckForm, CheckForm);
  Application.CreateForm(TAreaTableForm, AreaTableForm);
  Application.Run;
end.
