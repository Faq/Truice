unit Functions;

interface

uses Windows, Classes, StrUtils, SysUtils, ComCtrls, DBCFile, TntComCtrls, Registry, Messages, Controls, JvExComCtrls, JvListView, WideStrings;

type
   TParameter = (tpInteger, tpFloat, tpString, tpDate, tpTime, tpDateTime,
                  tpCurrency, tpBinaryData, tpBool);
  TRootKey = (CurrentUser, LocalMachine);

  TDateTimeRepresent = (ttTime, ttDate, ttDateTime);

procedure GetWhoAndKey(Text: string; var Who: string; var Key: string); forward;

procedure LoadListFromFile(List: TTntListView; Fname: string); forward; overload;
procedure LoadListFromFile(List: TTntListView; Fname: string; id1: string); forward; overload;

function LoadListFromDBCFile(List: TTntListView; Name: string ): boolean; forward; overload;
function LoadListFromDBCFile(List: TTntListView; FName: string ; idx_str: Cardinal ): boolean; forward; overload;

procedure SetList(List: TTntListView; Name: string; Sorted: boolean = false ); forward; overload;
procedure SetList(List: TTntListView; Name: string; id1: string ; Sorted: boolean = false); forward; overload;

procedure LoadSimpleIDListFromDBCFile(List: TWideStringList; Name: string); forward; export;
procedure LoadStringListFromFile(List: TStrings; csvname: string); forward; export;
procedure Sort(List: TTntListView; Column: integer); forward; export;

procedure WriteToRegistry(Root: TRootKey; Part, Param: string; TypeOfParam: TParameter; Value: OleVariant); forward; overload;
function ReadFromRegistry(Root: TRootKey; Part, Param: string; TypeOfParam: TParameter; const DefaultValue: OleVariant): OleVariant; forward; overload;
procedure WriteToRegistry(Root: TRootKey; Part, Param: string; var Buffer; BufSize: Integer); forward; overload;
procedure ReadFromRegistry(Root: TRootKey; Part, Param: string; var Buffer; BufSize: Integer); forward; overload;

function GetRaceAcronym(value: integer): string; forward;
function GetClassAcronym(value: integer): string; forward;

function CustomIDSortProc(Item1, Item2: TListItem; ParamSort: integer): integer; stdcall; forward;
function CustomNameSortProc(Item1, Item2: TListItem; ParamSort: integer): integer; stdcall; forward;

implementation

uses MainUnit, MyDataModule;

const
  I_CreatureFamily       =  10;
  I_ChrClasses           =  4;
  I_QuestInfo            =  1;
  I_Faction              =  20;
  I_SkillLine            =  3;
  I_ChrRaces             =  14;
  I_CreatureType         =  1;
  I_Languages            =  1;
  I_SpellItemEnchantment =  14;
  I_ItemClass            =  3;
  I_ItemSet              =  1;
  I_Map                  =  4;
  I_ItemPetFood          =  1;
  I_AreaTable            =  11;
  I_SpellName            =  136;
  I_SpellRank            =  153;

  MAX_ITEM_LENGTH        = 1000;

  I_AREA_TRIGGER         = 1001;
  I_AREA_TABLE           = 1002;
  I_FACTION_TEMPLATE     = 1003;
  I_GEM_PROPERTIES       = 1004;
  I_QUEST_SORT           = 1005;
  I_EMOTES               = 1006;
  I_SPELL                = 1007;
  I_PAGE_TEXT_MATERIAL   = 1008;
  I_CLASS                = 1009;

function CustomIDSortProc(Item1, Item2: TListItem; ParamSort: integer): integer; stdcall;
begin
  result := 0;
  if StrToIntDef(Item1.Caption,0) > StrToIntDef(Item2.Caption,0) then  Result := 1
  else if StrToIntDef(Item1.Caption,0) < StrToIntDef(Item2.Caption,0) then  Result := -1;
  if ParamSort < 0 then Result := -Result;
end;

function CustomNameSortProc(Item1, Item2: TListItem; ParamSort: integer): integer; stdcall;
begin
  Result := CompareStr(Item1.SubItems[0], Item2.SubItems[0]);
  if ParamSort < 0 then Result := -Result;  
end;

function LoadListFromDBCFile(List: TTntListView; Name: string ): boolean;
var
  FileName : TFileName;
  str : integer;
  SL : TWideStringList;
begin
    SL := TWideStringList.Create;
  try
    // these values mean column number of string value in DBC file
    SL.Add(WideFormat('CreatureFamily=%d',[I_CreatureFamily]));
    SL.Add(WideFormat('ChrClasses=%d',[I_ChrClasses]));
    SL.Add(WideFormat('QuestInfo=%d',[I_QuestInfo]));
    SL.Add(WideFormat('Faction=%d',[I_Faction]));
    SL.Add(WideFormat('SkillLine=%d',[I_SkillLine]));
    SL.Add(WideFormat('ChrRaces=%d',[I_ChrRaces]));
    SL.Add(WideFormat('CreatureType=%d',[I_CreatureType]));
    SL.Add(WideFormat('Languages=%d',[I_Languages]));
    SL.Add(WideFormat('SpellItemEnchantment=%d',[I_SpellItemEnchantment]));
    SL.Add(WideFormat('ItemClass=%d',[I_ItemClass]));
    SL.Add(WideFormat('ItemSet=%d',[I_ItemSet]));
    SL.Add(WideFormat('Map=%d',[I_Map]));
    SL.Add(WideFormat('ItemPetFood=%d',[I_ItemPetFood]));

    // this values mean indexes of case
    SL.Add(WideFormat('AreaTrigger=%d',[I_AREA_TRIGGER]));
    SL.Add(WideFormat('AreaTable=%d',[I_AREA_TABLE]));
    SL.Add(WideFormat('FactionTemplate=%d',[I_FACTION_TEMPLATE]));
    SL.Add(WideFormat('GemProperties=%d',[I_GEM_PROPERTIES]));
    SL.Add(WideFormat('QuestSort=%d',[I_QUEST_SORT]));
    SL.Add(WideFormat('Emotes=%d',[I_EMOTES]));
    SL.Add(WideFormat('Spell=%d',[I_SPELL]));
    SL.Add(WideFormat('PageTextMaterial=%d',[I_PAGE_TEXT_MATERIAL]));
    SL.Add(WideFormat('Class=%d',[I_CLASS]));

    str := StrToIntDef(SL.Values[Name],0);
  finally
    SL.Free;
  end;

  if Name = 'Class' then Name := 'ChrClasses';
  FileName := WideFormat('%s\%s.dbc',[dmMain.DBCDir, Name]);
  if (str > 0) and FileExists(FileName) then
    Result := LoadListFromDBCFile(List, FileName, str)
  else
    Result := False;
end;


function LoadSListFromDBCFile(List: TWideStringList; Name: string; idx_str: Cardinal): boolean;
var
  i: integer;
  Dbc : TDBCFile;
  Fname : TFileName;
begin
  Result := false;
  Fname := WideFormat('%s\%s.dbc',[dmMain.DBCDir, Name]);
  if FileExists(Fname) then
  try
    dbc := TDBCFile.Create;
    try
      Dbc.Load(Fname);
      List.BeginUpdate;
      for i := 0 to Dbc.recordCount - 1 do
      begin
        Dbc.setRecord(i);
        List.Add(WideFormat('%d=%s',[Dbc.getUInt(0),Dbc.getString(idx_str)]));
      end;
    finally
      List.EndUpdate;
      Dbc.Free;
    end;
    Result := true;
  except
    Result := false;
  end;
end;

procedure LoadSimpleIDListFromDBCFile(List: TWideStringList; Name: string);
var
  i: integer;
  Dbc : TDBCFile;
  Fname : TFileName;
begin
  Fname := WideFormat('%s\%s.dbc',[dmMain.DBCDir, Name]);
  if FileExists(Fname) then
  begin
    dbc := TDBCFile.Create;
    try
      Dbc.Load(Fname);
      List.BeginUpdate;
      for i := 0 to Dbc.recordCount - 1 do
      begin
        Dbc.setRecord(i);
        List.Add(WideFormat('%d',[Dbc.getUInt(0)]));
      end;
    finally
      List.EndUpdate;
      Dbc.Free;
    end;
  end;
end;

function LoadListFromDBCFile(List: TTntListView; Fname: string; idx_str: Cardinal ): boolean;
var
  i: integer;
  Dbc : TDBCFile;
  s, s1, s2: WideString;
  SL, SL2: TWideStringList;
begin
  Sl := TWideStringList.Create;
  Sl2 := TWideStringList.Create;
  try
    case idx_str of
      I_AREA_TRIGGER: LoadSListFromDBCFile(SL, 'Map', I_Map);
      I_AREA_TABLE:
      begin
        LoadSListFromDBCFile(SL, 'Map', I_Map);
        LoadSListFromDBCFile(SL2, 'AreaTable', I_AreaTable);
      end;
      I_FACTION_TEMPLATE:
        LoadSListFromDBCFile(SL, 'Faction', I_Faction);
      I_GEM_PROPERTIES:
        LoadSListFromDBCFile(SL, 'SpellItemEnchantment', I_SpellItemEnchantment);
    end;

    try
      dbc := TDBCFile.Create;
      try
        Dbc.Load(Fname);
        List.Items.BeginUpdate;
        for i := 0 to Dbc.recordCount - 1 do
        begin
          Dbc.setRecord(i);
          case idx_str of
            I_AREA_TRIGGER:
            begin
              s := SL.Values[IntToStr(Dbc.getUInt(1))];
              if s = '' then s := WideFormat('< unknown map %d>',[Dbc.getUInt(1)]);
              s := WideFormat('%s (%.3f, %.3f, %.3f)',[s, Dbc.getFloat(2), Dbc.getFloat(3), Dbc.getFloat(4)]);
            end;
            I_AREA_TABLE:
            begin
              s1 := SL.Values[IntToStr(Dbc.getUInt(1))];
              if s1 <> '' then s1 := s1 + ' - ';
              s2 := SL2.Values[IntToStr(Dbc.getUInt(2))];
              if s2 <> '' then s2 := s2 + ' - ';
              s := WideFormat('%s%s%s',[s1, s2, Dbc.getString(11)]);
            end;
            I_FACTION_TEMPLATE:
            begin
              s := SL.Values[IntToStr(Dbc.getUInt(1))];
              if s = '' then s := WideFormat('< unknown faction %d>',[Dbc.getUInt(1)]);
            end;
            I_GEM_PROPERTIES:
            begin
              s := SL.Values[IntToStr(Dbc.getUInt(1))];
              if s = '' then s := WideFormat('< unknown SpellItemEnchantment %d>',[Dbc.getUInt(1)]);
            end;
            I_QUEST_SORT: s := Dbc.getString(1);
            I_CLASS: s := Dbc.getString(I_ChrClasses);
            I_SPELL:
            begin
              if MainForm.IsSpellInBase(dbc.getUInt(0)) then
                s := WideFormat('%s %s', [dbc.getString(I_SpellName), Dbc.getString(I_SpellRank)])
              else
                s := '';
            end;
            I_EMOTES, I_PAGE_TEXT_MATERIAL:
            begin
              dbc.IsLocalized := false;
              s := dbc.getString(1);
            end
            else
              s := Dbc.getString(idx_str);
          end;
          if s <> '' then
          begin
            with List.Items.Add do
            begin
              if (idx_str = I_QUEST_SORT) or (idx_str = I_CLASS) then
                Caption := IntToStr(-Dbc.getUInt(0))
              else
                Caption := IntToStr(Dbc.getUInt(0));
              SubItems.Add(s);
            end;
          end;
        end;
      finally
        List.Items.EndUpdate;
        Dbc.Free;
      end;
      Result := true;
    except
      Result := false;
    end;
  finally
    Sl.Free;
    Sl2.Free;
  end;
end;

procedure GetWhoAndKey(Text: string; var Who: string; var Key: string);
var
  i: integer;
  s1, s2: string;
begin
  i:=Pos(',',Text);
  s1:=MidStr(Text,1,i-1);
  s2:=MidStr(Text,i+1, Length(Text)-i);
  Who:=s1;
  Key:=s2;
end;

procedure SetList(List: TTntListView; Name: string; Sorted: boolean );
var
  FileName: TFileName;
begin
    if Name = 'FactionTemplate' then
        Name := 'Faction';

    FileName := WideFormat('%sCSV\%s.csv',[dmMain.ProgramDir, Name]);
    if FileExists(FileName) then
    begin
        List.Items.Clear;
        LoadListFromFile(List, FileName);
    end
    else
    begin
        if Name = 'Faction' then
            Name := 'FactionTemplate';
        LoadListFromDBCFile(List, Name);
    end;

    if Sorted then Sort(List, 1);
end;

procedure SetList(List: TTntListView; Name: string; id1: string; Sorted: boolean = false);
begin
  LoadListFromFile(List, WideFormat('%s\%s.dbc',[dmMain.DBCDir, Name]), id1);
  if Sorted then Sort(List, 1);
end;

procedure LoadListFromFile(List: TTntListView; Fname: string);
var
  L: TStringList;
  i: integer;
  n: integer;
  s: string;
begin
  L := TStringList.Create;
  try
    if FileExists(FName) then
      L.LoadFromFile(FName);
    List.Items.BeginUpdate;
    for i:=0 to L.Count - 1 do
    begin
      s:=L[i];
      with List.Items.Add do
      begin
        n:=Pos(';', s);
        Caption:=Copy(s, 1, n-1);
        SubItems.Add(Copy(s, n+1, MAX_ITEM_LENGTH));
      end;
    end;
  finally
    L.Free;
    List.Items.EndUpdate;
  end;
end;

procedure LoadListFromFile(List: TTntListView; Fname: string; id1: string);
var
  i: integer;
  Dbc : TDBCFile;
begin
  if FileExists(Fname) then
  begin
    dbc := TDBCFile.Create;
    try
      Dbc.Load(Fname);
      List.Items.BeginUpdate;
      for i:=0 to dbc.recordCount - 1 do
      begin
        Dbc.setRecord(i);
        if IntToStr(dbc.getUInt(0)) = id1 then
        begin
          with List.Items.Add do
          begin
            Caption := IntToStr(Dbc.getUInt(1));
            SubItems.Add(Dbc.getString(10));
          end;
        end;
      end;
    finally
      List.Items.EndUpdate;
      dbc.free;
    end;
  end;
end;

procedure LoadStringListFromFile(List: TStrings; csvname: string);
var
  i: integer;
  n: integer;
  F, s: string;
begin
  F := dmMain.ProgramDir+'CSV\'+csvname+'.csv';
  if FileExists(F) then
  begin
    List.LoadFromFile(F);
    List.BeginUpdate;
    try
      for i:=0 to List.Count - 1 do
      begin
        s := List[i];
        n := Pos(';', s);
        List[i] := midStr(s, n+1, MAX_ITEM_LENGTH);;
        List.Objects[i] := pointer( StrToInt(MidStr(s, 1, n-1)));
      end;
    finally
      List.EndUpdate;
    end;
  end;
end;

procedure Sort(List: TTntListView; Column: integer);
begin
  List.Items.BeginUpdate;
  try
    case Column of
      0: List.CustomSort(@CustomIDSortProc, 1);
      1: List.CustomSort(@CustomNameSortProc, 1);
    end;
  finally
    List.Items.EndUpdate;
  end;
end;

procedure WriteToRegistry(Root: TRootKey; Part, Param: string;
                         TypeOfParam: TParameter; Value: OleVariant);
var
  Section: string;
begin
  try
    if Part='' then
      Section:='Software\'+ Trim(ProgramName)
    else
      Section:='Software\'+ Trim(ProgramName) + '\' + Trim(Part);
    with TRegistry.Create do
    try
      case Root of
        CurrentUser: RootKey:=HKEY_CURRENT_USER;
        LocalMachine: RootKey:=HKEY_LOCAL_MACHINE;
      end;
      OpenKey(Section, true);
      case TypeOfParam of
        tpInteger     :   WriteInteger(Param, Value);
        tpFloat       :   WriteFloat(Param, Value);
        tpString      :   WriteString(Param, Value);
        tpDate        :   WriteDate(Param, Value);
        tpTime        :   WriteTime(Param, Value);
        tpDateTime    :   WriteDateTime(Param, Value);
        tpBool        :   WriteBool(Param, Value);
        tpCurrency    :   WriteCurrency(Param, Value);
        tpBinaryData  :   raise Exception.Create('use overloaded procedure');
      end;
    finally
      Free;
    end;
  except
  end;
end;

procedure WriteToRegistry(Root: TRootKey; Part, Param: string;
                         var Buffer; BufSize: Integer);
var
  Section: string;
begin
  try
  {  if (Trim(ProgramName)='') then
      raise Exception.Create('ProgramName can not be empty');}
    if Part='' then
      Section:='Software\'+ Trim(ProgramName)
    else
      Section:='Software\'+ Trim(ProgramName) + '\' + Trim(Part);
    with TRegistry.Create do
    try
      case Root of
        CurrentUser: RootKey:=HKEY_CURRENT_USER;
        LocalMachine: RootKey:=HKEY_LOCAL_MACHINE;
      end;
      OpenKey(Section, true);
      WriteBinaryData(Param, Buffer, BufSize);
    finally
      Free;
    end;
  except
  end;
end;


function ReadFromRegistry(Root: TRootKey; Part, Param: string;
                         TypeOfParam: TParameter; const DefaultValue: OleVariant): OleVariant;
var
  Section: string;
  Value: OleVariant;
begin
  Value := DefaultValue;
  Section:='Software\' + Trim(ProgramName) + '\' + Trim(Part);
  with TRegistry.Create do
  try
    case Root of
      CurrentUser:    RootKey:=HKEY_CURRENT_USER;
      LocalMachine:   RootKey:=HKEY_LOCAL_MACHINE;
    end;

    if KeyExists(Section) then
    begin
      OpenKeyReadOnly(Section);
      if ValueExists(Param) then
      begin
        case TypeOfParam of
          tpInteger     :   Value:=ReadInteger(Param);
          tpFloat       :   Value:=ReadFloat(Param);
          tpString      :   Value:=ReadString(Param);
          tpDate        :   Value:=ReadDate(Param);
          tpTime        :   Value:=ReadTime(Param);
          tpDateTime    :   Value:=ReadDateTime(Param);
          tpBool        :   Value:=ReadBool(Param);
          tpCurrency    :   Value:=ReadCurrency(Param);
          tpBinaryData  :   raise Exception.Create('use overloaded procedure');
        end;
      end;
    end;
  finally
    Free;
  end;
  result:=Value;
end;

procedure ReadFromRegistry(Root: TRootKey; Part, Param: string;
                         var Buffer; BufSize: Integer);
var
  Section: string;
begin
{  if (Trim(ProgramName)='') then
    raise Exception.Create('ProgramName can not be empty');}
  if Part='' then
    Section:='Software\'+ Trim(ProgramName)
  else
    Section:='Software\'+ Trim(ProgramName) + '\' + Trim(Part);
  with TRegistry.Create do
  try
    case Root of
      CurrentUser: RootKey:=HKEY_CURRENT_USER;
      LocalMachine: RootKey:=HKEY_LOCAL_MACHINE;
    end;
    if OpenKey(Section, false) then
    begin
      ReadBinaryData(Param, Buffer, BufSize);
    end;
  finally
    Free;
  end;
end;

function GetRaceAcronym(value: integer): string;
begin
  case value of
    1: Result := 'Human';
    2: Result := 'Orc';
    3: Result := 'Dwarf';
    4: Result := 'NightElf';
    5: Result := 'Undead';
    6: Result := 'Tauren';
    7: Result := 'Gnome';
    8: Result := 'Troll';
    10:	Result := 'BloodElf';
    11:	Result := 'Draenei';
    690: Result := 'Horde';
    1101: Result := 'Alliance';
    0,-1: Result := 'Both';
  else
    Result:= '';
  end;
end;

function GetClassAcronym(value: integer): string;
begin
  case value of
    1	: Result := 'Warrior';
    2	: Result := 'Paladin';
    3	: Result := 'Hunter';
    4	: Result := 'Rogue';
    5	: Result := 'Priest';
    7	: Result := 'Shaman';
    8	: Result := 'Mage';
    9	: Result := 'Warlock';
    11: Result := 'Druid';
  else
    Result:= '';
  end;
end;


end.
