unit Translate;

interface

uses Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, Buttons, Menus, JvToolEdit;

const
  LANG_NONE_FORM          = 0;
  LANG_CHECK_FORM         = 1;
  LANG_CREATUREORGO_FORM  = 2;
  LANG_ITEM_FORM          = 3;
  LANG_LIST_FORM          = 4;
  LANG_MAIN_FORM          = 5;
  LANG_CONNECT_FORM       = 6;
  LANG_SETTINGS_FORM      = 7;
  LANG_SPELLS_FORM        = 8;
  LANG_WHOQUEST_FORM      = 9;
  LANG_ITEMLOOT_FORM      = 10;
  LANG_CUSTOM             = 11;
  LANG_ITEMPAGE_FORM      = 12;
  LANG_GUID_FORM          = 13;
  LANG_UNITFLAGS_FORM     = 14;
  LANG_AREATABLE_FORM     = 15;

  LANG_COUNT = 16;

  LANG_MAX_STRINGS = 3000;

type
  TTranslate = class
  private
    {
    // 0 - internal language, 1 - external language
    }
    FLanguage: array [0..1, 0..LANG_COUNT, 0..LANG_MAX_STRINGS] of string;
    FPartNames: array [0..LANG_COUNT] of string;
{$IFNDEF DEBUG}
    function GetPartByName(Name: string): integer;
    function GetFirst(s: string): string;
    function GetSecond(s: string): string;
{$ENDIF}
    procedure Init;
  public
    constructor Create;
    procedure TranslateForm(Form: TForm);
    procedure LoadTranslations(FileName: string);
    procedure CreateDefaultTranslation(Form: TForm);
    procedure CreateCustomTranslation;
    function GetTranslation(s: string; Part: integer; olds: string): string;
    procedure TranslateCustomText;    
  end;

implementation

uses StrUtils, MainUnit, CheckUnit, AreaTableUnit,
  CreatureOrGOUnit, ItemUnit, ListUnit, SettingsUnit,
  SpellsUnit, WhoUnit, MyDataModule, ItemLootUnit,
  ItemPageUnit, GUIDUnit, UnitFlagsUnit, MeConnectForm;

{ TTranslate }

constructor TTranslate.Create;
begin
  Init;
end;

{$IFNDEF DEBUG}
function TTranslate.GetFirst(s: string): string;
begin
  if pos('=', s)<>0 then
    Result:=MidStr(s, 1, pos('=', s)-1)
  else
    Result:=s;
end;

function TTranslate.GetSecond(s: string): string;
begin
  if pos('=', s)<>0 then
    Result:=MidStr(s, pos('=', s)+1, 1000)
  else
    Result:='';
end;

function TTranslate.GetPartByName(Name: string): integer;
var
  i: integer;
begin
  Result:=0;
  for i:=0 to LANG_COUNT - 1 do
  begin
    if FPartNames[i] = UpperCase(Name) then
    begin
      Result := i;
      Exit;
    end;
  end;
end;
{$ENDIF}

procedure TTranslate.Init;
var
  i, j,k: integer;
begin
  FPartNames[LANG_NONE_FORM]        := '[NONE]';
  FPartNames[LANG_CHECK_FORM]       := '[CHECK]';
  FPartNames[LANG_CREATUREORGO_FORM]:= '[CREATUREORGO]';
  FPartNames[LANG_ITEM_FORM]        := '[ITEM]';
  FPartNames[LANG_LIST_FORM]        := '[LIST]';
  FPartNames[LANG_MAIN_FORM]        := '[MAIN]';
  FPartNames[LANG_CONNECT_FORM]     := '[CONNECT]';
  FPartNames[LANG_SETTINGS_FORM]    := '[SETTINGS]';
  FPartNames[LANG_SPELLS_FORM]      := '[SPELLS]';
  FPartNames[LANG_WHOQUEST_FORM]    := '[WHOQUEST]';
  FPartNames[LANG_ITEMLOOT_FORM]    := '[ITEMLOOT]';
  FPartNames[LANG_CUSTOM]           := '[CUSTOM]';
  FPartNames[LANG_ITEMPAGE_FORM]    := '[ITEMPAGE]';
  FPartNames[LANG_GUID_FORM]        := '[GETGUID]';
  FPartNames[LANG_UNITFLAGS_FORM]   := '[UNITFLAGS]';
  FPartNames[LANG_AREATABLE_FORM]   := '[AREATABLE]';  

  for i:=0 to 1 do
    for j:=0 to LANG_COUNT - 1 do
      for k:=0 to LANG_MAX_STRINGS do
        FLanguage[i, j, k]:='';
end;

procedure TTranslate.LoadTranslations(FileName: string);
{$IFNDEF DEBUG}
var
  LangFile: TStringList;
  i, j: integer;
  s: string;
  Part: integer;
{$ENDIF}
begin
  {$IFNDEF DEBUG}
  if not FileExists(FileName) then Exit;
  LangFile:=TStringList.Create;
  try
    LangFile.LoadFromFile(FileName);
    Part:=0;
    j:=0;
    for i:=0 to LangFile.Count - 1 do
    begin
      s:=Trim(LangFile[i]);
      if s='' then continue;
      if pos('[', s)=1 then
      begin
        Part:=GetPartByName(s);
        j:=0;
      end
      else
      begin
        FLanguage[0,Part,J]:=GetFirst(s);
        FLanguage[1,Part,J]:=GetSecond(s);
        inc(j);
      end;
    end;
  finally
    LangFile.Free;
  end;
  {$ENDIF}
end;

procedure TTranslate.TranslateForm(Form: TForm);
var
  Part: integer;
  i: integer;
begin
  Part := LANG_NONE_FORM;
  if Form is TMainForm then         Part := LANG_MAIN_FORM;
  if Form is TMeConnectForm then    Part := LANG_CONNECT_FORM;
  if Form is TCheckForm then        Part := LANG_CHECK_FORM;
  if Form is TCreatureOrGOForm then Part := LANG_CREATUREORGO_FORM;
  if Form is TItemForm then         Part := LANG_ITEM_FORM;
  if Form is TListForm then         Part := LANG_LIST_FORM;
  if Form is TSettingsForm then     Part := LANG_SETTINGS_FORM;
  if Form is TSpellsForm then       Part := LANG_SPELLS_FORM;
  if Form is TWhoQuestForm then     Part := LANG_WHOQUEST_FORM;
  if Form is TItemLootForm then     Part := LANG_ITEMLOOT_FORM;
  if Form is TItemPageForm then     Part := LANG_ITEMPAGE_FORM;
  if Form is TGUIDForm then         Part := LANG_GUID_FORM;
  if Form is TUnitFlagsForm then    Part := LANG_UNITFLAGS_FORM;
  if Form is TAreaTableForm then    Part := LANG_AREATABLE_FORM;

  if Part = LANG_NONE_FORM then Exit;

  Form.Caption := GetTranslation('Caption', Part, Form.Caption);
  for i:=0 to Form.ComponentCount - 1 do
  begin
    if Form.Components[i] is TLabel then
      TLabel(Form.Components[i]).Caption:=
        GetTranslation(Form.Components[i].Name, Part, TLabel(Form.Components[i]).Caption);

    if (Form.Components[i] is MainUnit.TLabeledEdit) or (Form.Components[i] is ExtCtrls.TLabeledEdit) then
    begin
      TLabeledEdit(Form.Components[i]).EditLabel.Caption:=
        GetTranslation(Form.Components[i].Name, Part, TLabeledEdit(Form.Components[i]).EditLabel.Caption);

      TLabeledEdit(Form.Components[i]).Hint:= StringReplace(
        GetTranslation('^'+Form.Components[i].Name, Part, TLabeledEdit(Form.Components[i]).Hint),
        '$B$B',#13#10,[rfReplaceAll]);
      TLabeledEdit(Form.Components[i]).ShowHint := true;
    end;

    if Form.Components[i] is TJvComboEdit then
    begin
      TJvComboEdit(Form.Components[i]).Hint:= StringReplace(
        GetTranslation('^'+Form.Components[i].Name, Part, TJvComboEdit(Form.Components[i]).Hint),
        '$B$B',#13#10,[rfReplaceAll]);
      TJvComboEdit(Form.Components[i]).ShowHint := true;
    end;

    if Form.Components[i] is TMemo then
    begin
      TMemo(Form.Components[i]).Hint:= StringReplace(
        GetTranslation('^'+Form.Components[i].Name, Part, TMemo(Form.Components[i]).Hint),
        '$B$B',#13#10,[rfReplaceAll]);
      TMemo(Form.Components[i]).ShowHint := true;
    end;
        
    if Form.Components[i] is TButton then
      TButton(Form.Components[i]).Caption:=
        GetTranslation(Form.Components[i].Name, Part, TButton(Form.Components[i]).Caption);
    if Form.Components[i] is TGroupBox then
      TGroupBox(Form.Components[i]).Caption:=
        GetTranslation(Form.Components[i].Name, Part, TGroupBox(Form.Components[i]).Caption);
    if Form.Components[i] is TTabSheet then
      TTabSheet(Form.Components[i]).Caption:=
        GetTranslation(Form.Components[i].Name, Part, TTabSheet(Form.Components[i]).Caption);
    if Form.Components[i] is TCheckBox then
      TCheckBox(Form.Components[i]).Caption:=
        GetTranslation(Form.Components[i].Name, Part, TCheckBox(Form.Components[i]).Caption);
    if Form.Components[i] is TRadioButton then
      TRadioButton(Form.Components[i]).Caption:=
        GetTranslation(Form.Components[i].Name, Part, TRadioButton(Form.Components[i]).Caption);
    if Form.Components[i] is TRadioGroup then
      TRadioButton(Form.Components[i]).Caption:=
        GetTranslation(Form.Components[i].Name, Part, TRadioGroup(Form.Components[i]).Caption);
    if Form.Components[i] is TMenuItem then
      TMenuItem(Form.Components[i]).Caption:=
        GetTranslation(Form.Components[i].Name, Part, TMenuItem(Form.Components[i]).Caption);
  end;
end;

function TTranslate.GetTranslation(s: string; Part: integer; olds: string): string;
var
  i: integer;
begin
  Result:=olds;
  for i:=0 to LANG_MAX_STRINGS do
  begin
    if FLanguage[0,Part,i]=s then
    begin
      Result:=FLanguage[1,Part,i];
      Exit;
    end;
    if FLanguage[0,Part,i]='' then Exit;
  end;
end;

procedure TTranslate.CreateDefaultTranslation(Form: TForm);
{$IFDEF C}
var
  i: integer;
  s, s1, s2: string;
  list: TStringList;
{$ENDIF}
begin
{$IFDEF C}
  list:=TStringList.Create;
  try
    s:='';
    if Form is TMainForm then         s:=FPartNames[LANG_MAIN_FORM];
    if Form is TMeConnectForm then    s:=FPartNames[LANG_CONNECT_FORM];
    if Form is TCheckForm then        s:=FPartNames[LANG_CHECK_FORM];
    if Form is TCreatureOrGOForm then s:=FPartNames[LANG_CREATUREORGO_FORM];
    if Form is TItemForm then         s:=FPartNames[LANG_ITEM_FORM];
    if Form is TListForm then         s:=FPartNames[LANG_LIST_FORM];
    if Form is TSettingsForm then     s:=FPartNames[LANG_SETTINGS_FORM];
    if Form is TSpellsForm then       s:=FPartNames[LANG_SPELLS_FORM];
    if Form is TWhoQuestForm then     s:=FPartNames[LANG_WHOQUEST_FORM];
    if Form is TItemLootForm then     s:=FPartNames[LANG_ITEMLOOT_FORM];
    if Form is TItemPageForm then     s:=FPartNames[LANG_ITEMPAGE_FORM];
    if Form is TGUIDForm then         s:=FPartNames[LANG_GUID_FORM];
    if Form is TUnitFlagsForm then    s:=FPartNames[LANG_UNITFLAGS_FORM];
    if Form is TAreaTableForm then    s:=FPartNames[LANG_AREATABLE_FORM];    

    if s='' then exit;
    list.Add(s);

    if not (Form is TMeConnectForm) then
      list.Add(Format('Caption=%s',[Form.Caption]));

    for i:=0 to Form.ComponentCount - 1 do
    begin
      s1:=Form.Components[i].Name;
      s2:='';
      if Form.Components[i] is TLabel then
      begin
        s2:=TLabel(Form.Components[i]).Caption;
        if pos('----', s2)>0 then s2:='';
      end;
      if (Form.Components[i] is MainUnit.TLabeledEdit) or (Form.Components[i] is ExtCtrls.TLabeledEdit) then
      begin
        s2:=TLabeledEdit(Form.Components[i]).EditLabel.Caption;
        list.Add(Format('%s=%s',[s1,s2]));
        s2:=TLabeledEdit(Form.Components[i]).Hint;
        if s2<>'' then
          list.Add(Format('^%s=%s', [s1, StringReplace(s2,#13#10,'$B$B', [rfReplaceAll])]));
        s2:='';
      end;
      if Form.Components[i] is TJvComboEdit then
      begin
        s2:=TJvComboEdit(Form.Components[i]).Hint;
        if s2<>'' then
          list.Add(Format('^%s=%s', [s1, StringReplace(s2,#13#10,'$B$B', [rfReplaceAll])]));
        s2:='';
      end;
      if Form.Components[i] is TMemo then
      begin
        s2:=TMemo(Form.Components[i]).Hint;
        if s2<>'' then
          list.Add(Format('^%s=%s', [s1, StringReplace(s2,#13#10,'$B$B', [rfReplaceAll])]));
        s2:='';
      end;
      if Form.Components[i] is TButton then
        s2:=TButton(Form.Components[i]).Caption;
      if Form.Components[i] is TGroupBox then
        s2:=TGroupBox(Form.Components[i]).Caption;
      if Form.Components[i] is TTabSheet then
        s2:=TTabSheet(Form.Components[i]).Caption;
      if Form.Components[i] is TCheckBox then
        s2:=TCheckBox(Form.Components[i]).Caption;
      if Form.Components[i] is TRadioButton then
        s2:=TRadioButton(Form.Components[i]).Caption;
      if Form.Components[i] is TRadioGroup then
        s2:=TRadioGroup(Form.Components[i]).Caption;
      if Form.Components[i] is TMenuItem then
      begin
       s2 := TMenuItem(Form.Components[i]).Caption;
       if s2='-' then s2:='';
      end;
      if s2<>'' then
        list.Add(Format('%s=%s',[s1,s2]));
    end;
    list.Add('');
    if Form.Name = 'MainForm' then
      list.SaveToFile(Format('%sCREATELANG\zzz%s.lng',[dmMain.ProgramDir, Form.Name]))
    else
      list.SaveToFile(Format('%sCREATELANG\%s.lng',[dmMain.ProgramDir, Form.Name]));
  finally
    List.free;
  end;
{$ENDIF}
end;

procedure TTranslate.TranslateCustomText;
var
  i: integer;
begin
  for i:=0 to LANG_MAX_STRINGS do
  begin
    if dmMain.Text[i]='' then Exit;
    dmMain.Text[i]:=StringReplace(GetTranslation(Format('TEXT%d',[i]),15,dmMain.Text[i]), '$B', #13#10, [rfReplaceAll]);
  end;
end;

procedure TTranslate.CreateCustomTranslation;
{$IFDEF C}
var
  i: integer;
  list : TStringList;
{$ENDIF}
begin
{$IFDEF C}
  ForceDirectories(dmMain.ProgramDir+'CREATELANG');
  list := TStringList.Create;
  try
    list.Add(FPartNames[LANG_CUSTOM]);
    for i:=1 to LANG_MAX_STRINGS do
    begin
      if dmMain.Text[i] <> '' then
        list.Add(Format('TEXT%d=%s',[i, dmMain.Text[i]]));
    end;
    list.Add('');
    list.SaveToFile(Format('%sCREATELANG\zzaCustom.lng',[dmMain.ProgramDir]));
  finally
    list.Free;
  end;
{$ENDIF}
end;

end.
