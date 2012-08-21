unit MyDataModule;

interface

uses
  Forms, SysUtils, Classes, ActnList, ExtActns, Translate, WideStrings,
  DB, ZAbstractRODataset, ZAbstractDataset, ZDataset, JvExComCtrls, JvListView;

const
  DefaultLanguage = 'Default';
  SoftwareCompany = 'Truice';
  ProgramName = 'Truice';

type
  TType = (ttNPC, ttItem, ttObject, ttQuest, ttChar);
  TSite = (sW, sRW, sA, sT, sD);

  TdmMain = class(TDataModule)
    ActionList: TActionList;
    BrowseURL: TBrowseURL;
    MyQuery: TZQuery;
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    FLanguage : string;
    FSite: TSite;
    procedure SetLanguage(const Value: string);
  public
    { Public declarations }
    ProgramDir: string;
    DBCDir: string;
    LanguageFile: string;

    Translate: TTranslate;
    Text: array [0..3000] of string;

    IsAutoUpdates: boolean;
    ProxyServer,
    ProxyPort,
    ProxyUser,
    ProxyPass: string;

    DBCLocale: Cardinal;
    Locales: Cardinal;

    property Language: string read FLanguage write SetLanguage;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Site: TSite read FSite write FSite;
    procedure BrowseSite(T: TType; id: integer);

    procedure wowhead(T: TType; id: integer);
    procedure ruwowhead(T: TType; id: integer);
    procedure thottbot(T: TType; id: integer);
    procedure allakhazam(T: TType; id: integer);
    procedure wowdb(T: TType; id: integer);

    procedure Init;

  end;

var
  dmMain: TdmMain;

implementation

uses MainUnit, Functions;
{$R *.dfm}

{ TdmMain }

constructor TdmMain.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FSite := sW;
  Init;
  ProgramDir := IncludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName));

  DBCDir := ReadFromRegistry(CurrentUser, '', 'DBCDir', tpString, ProgramDir + 'DBC');
  DBCLocale := ReadFromRegistry(CurrentUser, '', 'DBCLocale', tpInteger, 16);
  Language := ReadFromRegistry(CurrentUser, '', 'Language', tpString, DefaultLanguage);
  IsAutoUpdates := ReadFromRegistry(CurrentUser, '', 'IsAutoUpdates', tpBool, True);

  ProxyServer := ReadFromRegistry(CurrentUser, '', 'ProxyServer', tpString, '');
  ProxyPort   := ReadFromRegistry(CurrentUser, '', 'ProxyPort', tpString, '');
  ProxyUser   := ReadFromRegistry(CurrentUser, '', 'ProxyUser', tpString, '');
  ProxyPass   := ReadFromRegistry(CurrentUser, '', 'ProxyPass', tpString, '');

  Translate:=TTranslate.Create;
  Translate.CreateCustomTranslation;
  if not FileExists(LanguageFile) then Language := DefaultLanguage;
  Translate.LoadTranslations(LanguageFile);
  Translate.TranslateCustomText;
end;

procedure TdmMain.BrowseSite(T: TType; id: integer);
begin
  case FSite of
    sW: wowhead(T, id);
    sRW: ruwowhead(T, id);
    sA: allakhazam(T, id);
    sT: thottbot(T, id);
    sD: wowdb(T, id);
  end;
end;

procedure TdmMain.allakhazam(T: TType; id: integer);
var
  url: string;
begin
  id:=abs(id);
  case T of
    ttNPC:     url := Format('http://wow.allakhazam.com/db/mob.html?wmob=%d',[id]);
    ttItem:    url := Format('http://wow.allakhazam.com/db/item.html?witem=%d',[id]);
    ttObject:  url := Format('http://wow.allakhazam.com/db/object.html?wobject=%d',[id]);
    ttQuest:   url := Format('http://wow.allakhazam.com/db/quest.html?wquest=%d',[id]);
  end;
  BrowseURL.URL:=url;
  BrowseURL.Execute;
end;

procedure TdmMain.thottbot(T: TType; id: integer);
var
  url: string;
begin
  id:=abs(id);
  case T of
    ttNPC:     url := Format('http://thottbot.com/c%d',[id]);
    ttItem:    url := Format('http://thottbot.com/i%d',[id]);
    ttObject:  url := Format('http://thottbot.com/o%d',[id]);
    ttQuest:   url := Format('http://thottbot.com/q%d',[id]);
  end;
  BrowseURL.URL:=url;
  BrowseURL.Execute;
end;

procedure TdmMain.wowdb(T: TType; id: integer);
var
  url: string;
begin
  id:=abs(id);
  case T of
    ttNPC:     url := Format('http://www.wowdb.com/npc.aspx?id=%d',[id]);
    ttItem:    url := Format('http://www.wowdb.com/item.aspx?id=%d',[id]);
    ttObject:  url := Format('http://www.wowdb.com/object.aspx?id=%d',[id]);
    ttQuest:   url := Format('http://www.wowdb.com/quest.aspx?id=%d',[id]);
  end;
  BrowseURL.URL:=url;
  BrowseURL.Execute;
end;

procedure TdmMain.wowhead(T: TType; id: integer);
var
  url: string;
begin
  id:=abs(id);
  case T of
    ttNPC:     url := Format('http://www.wowhead.com/?npc=%d',[id]);
    ttItem:    url := Format('http://www.wowhead.com/?item=%d',[id]);
    ttObject:  url := Format('http://www.wowhead.com/?object=%d',[id]);
    ttQuest:   url := Format('http://www.wowhead.com/?quest=%d',[id]);
  end;
  BrowseURL.URL:=url;
  BrowseURL.Execute;
end;

procedure TdmMain.ruwowhead(T: TType; id: integer);
var
  url: string;
begin
  id:=abs(id);
  case T of
    ttNPC:     url := Format('http://ru.wowhead.com/?npc=%d',[id]);
    ttItem:    url := Format('http://ru.wowhead.com/?item=%d',[id]);
    ttObject:  url := Format('http://ru.wowhead.com/?object=%d',[id]);
    ttQuest:   url := Format('http://ru.wowhead.com/?quest=%d',[id]);
  end;
  BrowseURL.URL:=url;
  BrowseURL.Execute;
end;

procedure TdmMain.DataModuleDestroy(Sender: TObject);
begin
  WriteToRegistry(CurrentUser, '', 'IsAutoUpdates', tpBool, IsAutoUpdates);
  WriteToRegistry(CurrentUser, '', 'ProxyServer', tpString, ProxyServer);
  WriteToRegistry(CurrentUser, '', 'ProxyPort', tpString, ProxyPort);
  WriteToRegistry(CurrentUser, '', 'ProxyUser', tpString, ProxyUser);
  WriteToRegistry(CurrentUser, '', 'ProxyPass', tpString, ProxyPass);
end;

destructor TdmMain.Destroy;
begin
  Translate.Free;
  inherited;
end;

procedure TdmMain.Init;
var
  i:integer;
begin
  for i:=0 to 3000 do
    Text[i]:='';
  Text[0]:='NONE';
  Text[1]:='Item cannot be a quest taker';
  Text[2]:='Error: Quest (%d) not found';
  Text[3]:='The error has accured while loading the Quest:';
  Text[4]:='Error: QuestGiver is not set';
  Text[5]:='Error: QuestGiver is not set correctly';
  Text[6]:='Error: QuestTaker is not set';
  Text[7]:='Error: QuestTaker is not set correctly';
  Text[8]:='Warning: There is no one component assigned to field `%s`. It will assigned to default value if it has one.';
  Text[9]:='Are you sure to execute this script?';
  Text[10]:='Script executed successfully.';
  Text[11]:='QuestSort';
  Text[12]:='Zone';
  Text[13]:='Type';
  Text[14]:='Faction';
  Text[15]:='FactionTemplate';
  Text[16]:='Skill';
  Text[17]:='Creature location';
  Text[18]:='Gameobject location';
  Text[19]:='Item Loot';
  Text[20]:='Nothing to check.';
  Text[21]:='List of found quests is empty. Nothing to check.';
  Text[22]:='Terminating check. Please wait.';
  Text[23]:='Terminated';
  Text[24]:='quest = %d';
  Text[25]:='Fatal Error: Wrong quest id (%d)';
  Text[26]:='Fatal Error: Quest with entry = %d not found';
  Text[27]:='Warning: There more than one quest giver:';
  Text[28]:='Error: quest giver is creature with entry = %d, but (`npcflag` & 2) <> 2';
  Text[29]:='Warning: There more than one location for quest giver (id=%d) in table `creature`';
  Text[30]:='Error: Location for quest giver (id=%d) not found in table `creature`';
  Text[31]:='Error: quest giver is creature with entry = %d, but there is no one record in `creature_template` with entry = %0:d';
  Text[32]:='Warning: There more than one location for quest giver (id=%d) in table `gameobject`';
  Text[33]:='Error: Location for quest giver (id=%d) not found in table `gameobject`';
  Text[34]:='Warning: quest giver is item (id=%d), but there is no one loot in tables *_loot_template and npc_vendor. May be it is not error, just item need to be rewarded or gived from other quest.';
  Text[35]:='Warning: There more than one quest taker:';
  Text[36]:='Error: quest taker is creature with entry = %d, but (`npcflag` & 2) <> 2';
  Text[37]:='Warning: There more than one location for quest taker (id=%d) in table `creature`';
  Text[38]:='Error: Location for quest taker (id=%d) not found in table `creature`';
  Text[39]:='Error: quest taker is creature with entry = %d, but there is no one record in `creature_template` with entry = %0:d';
  Text[40]:='Warning: There more than one location for quest taker (id=%d) in table `gameobject`';
  Text[41]:='Error: Location for quest taker (id=%d) not found in table `gameobject`';
  Text[42]:='Error: quest taker is gameobject with entry = %d, but there is no one record in `gameobject_template` with entry = %0:d';
  Text[43]:='Error: quest giver not found';
  Text[44]:='Error: quest taker not found';
  Text[45]:='Warning: There is more than one different type quest giver (quest giver count=%d)';
  Text[46]:='Warning: There is more than one different type quest taker (quest taker count=%d)';
  Text[47]:='Error: PrevQuestId=%d, but quest with this id is not exists';
  Text[48]:='Error: NextQuestId=%d, but quest with this id is not exists';
  Text[49]:='Error: Type = %d, but Type with this id is not exists';
  Text[50]:='Error: %s = %d, but Faction with this id is not exists';
  Text[51]:='Error: ZoneOrSort = %d, but ZoneId with this id is not exists';
  Text[52]:='Error: ZoneOrSort = %d, but QuestSort with this id is not exists';
  Text[53]:='Error: MinLevel (%d) > QuestLevel (%d)';
  Text[54]:='Warning: QuestFlags is set to EXPLORATION but there is no one record in table `areatrigger_involvedrelation` for quest';
  Text[55]:='Warning: QuestFlags is set to SPEAK_TO but NextQuestId = 0';
  Text[56]:='Error: QuestFlags is set to DELIVER but ReqItemId1.-4. = 0';
  Text[57]:='Error: QuestFlags is set to KILL_OR_CAST but ReqCreatureOrGOId1.-4. = 0';
  Text[58]:='Warning: LimitTime = %d seconds, but QuestFlags is not set to TIMED';
  Text[59]:='Warning: ReqItemId <> 0, but QuestFlags is not set to DELIVER';
  Text[60]:='Warning: ReqCreatureOrGOId <> 0, but QuestFlags is not set to KILL_OR_CAST';
  Text[61]:='Warning: NextQuestId <> 0, but QuestFlags is not set to SPEAK_TO';
  Text[62]:='Error: %s = %d, but item with this id is not exists';
  Text[63]:='Warning: %s = %d, but there is no one loot in tables *_loot_template and npc_vendor. May be it is not error, just item need to be created or rewarded from other quest.';
  Text[64]:='Error: %s = %d. Loot for this item is gameobject_loot_template.entry = %d, but gameobject with this id not found in `gameobject` table';
  Text[65]:='Error: %s = %d. Loot for this item is creature_loot_template.entry = %d, but creature with this id not found in `creature` table';
  Text[66]:='Error: ReqSourceRef%d > 4';
  Text[67]:='Error: ReqSourceId%d=0, but ReqSourceRef%0:d=%1:d';
  Text[68]:='Error: ReqItemId%1:d=0, but ReqSourceRef%0:d=%1:d';
  Text[69]:='Error: ReqCreatureOrGOId%d = %d, but creature with this id is not exists';
  Text[70]:='Error: ReqCreatureOrGOId%d = %d, Location for creature not exists';
  Text[71]:='Error: ReqCreatureOrGOId%d = %d, but gameobject with this id is not exists';
  Text[72]:='Error: ReqCreatureOrGOId%d = %d, Location for gameobject not exists';
  Text[73]:='Check complete: %d errors, %d warnings';
  Text[74]:='Check quest (%d) : %d%%';
  Text[75]:='Check quest colmpete';
  Text[76]:='Error: quest giver is gameobject with entry = %d, but there is no one record in `gameobject_template` with entry = %0:d';
  Text[77]:='<< Details';
  Text[78]:='Details >>';
  Text[79]:='Quests found: %d';
  Text[80]:='Creatures found: %d';
  Text[81]:='Error: Creature (entry = %d) not found';
  Text[82]:='The error has accured while loading the Creature_Template:';
  Text[83]:='Rank';
  Text[84]:='Family';
  Text[85]:='Creature Type';
  Text[86]:='The error has accured while loading Creature:';
  Text[87]:='GameObjects found: %d';
  Text[88]:='Error: Gameobject (entry = %d) not found';
  Text[89]:='The error has accured while loading the Gameobject_Template:';
  Text[90]:='The error has accured while loading GameObject:';
  Text[91]:='The error has accured while loading creature_loot_template:';
  Text[92]:='The error has accured while loading gameobject_loot_template:';
  Text[93]:='GameObject Type';
  Text[94]:='Always = 0 or Unknown';
  Text[95]:='State';
  Text[96]:='LockID ( ID from Lock.dbc )';
  Text[97]:='flags';
  Text[98]:='ID gameobject ( Spawned GO type 6 )';
  Text[99]:='State Battleground';
  Text[100]:='QuestLoot ID';
  Text[101]:='LootID';
  Text[102]:='Time';
  Text[103]:='MinLoot';
  Text[104]:='MaxLoot';
  Text[105]:='QuestID ( Quest complete )';
  Text[106]:='Distance';
  Text[107]:='Spell ID';
  Text[108]:='Time/Distance';
  Text[109]:='Chain Effect';
  Text[110]:='Time/Distance for Chain Effect';
  Text[111]:='areatrigger_template.id';
  Text[112]:='Distance/ State';
  Text[113]:='ID SpellFocusObject.dbc';
  Text[114]:='Page ID';
  Text[115]:='ID from PageTextMaterial.dbc';
  Text[116]:='Items found: %d';
  Text[117]:='Error: Item (entry = %d) not found';
  Text[118]:='The error has accured while loading the Item_Template:';
  Text[119]:='Quality';
  Text[120]:='InventoryType';
  Text[121]:='RequiredReputationRank';
  Text[122]:='StatType';
  Text[123]:='DmgType';
  Text[124]:='Bonding';
  Text[125]:='Language';
  Text[126]:='PageMaterial';
  Text[127]:='Material';
  Text[128]:='Sheath';
  Text[129]:='BagFamily';
  Text[130]:='Class';
  Text[131]:='SubClass';
  Text[132]:='ItemSet';
  Text[133]:='Map';
  Text[134]:='Search filter is empty. This task returns all entries from table.$B$BAre you sure to continue?';
  Text[135]:='Script Command';
  Text[136]:='Characters found: %d';
  Text[137]:='New version of Truice (%s) is available. You want to download it?';
  Text[138]:='You have got the latest version.';  
  Text[139]:='The error has accured while loading Creature Addon:';
  Text[140]:='Are you sure to uninstall Truice?';
  Text[141]:='Trainer Type';
  Text[142]:='Race';
  Text[143]:='Class';
  Text[144]:='The error has accured while loading NPC gossip:';
  Text[145]:='The error has accured while loading NPC Text:';
  Text[146]:='~OBSOLETE';
  Text[147]:='Emote';
  Text[148]:='ItemPetFood';
  Text[149]:='The error has accured while loading Creature Template Addon:';
  Text[150]:='GemProperties';
  Text[151]:='SpellItemEnchantment';
  Text[152]:='ItemExtendedCost';
  Text[153]:='Error: Character (guid = %d) not found';
  Text[154]:='The error has accured while loading the Character:';
  Text[155]:='AreaTrigger';
  Text[156]:='LootMode';
  Text[157]:='The error has accured while loading Creature EventAI:';
  Text[158]:='Please specify a source type!';
end;

procedure TdmMain.SetLanguage(const Value: string);
begin
  FLanguage := Value;
  LanguageFile := Format('%sLANG\%s.lng',[ProgramDir, Value]);
end;

end.
