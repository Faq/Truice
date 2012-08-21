unit MainUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, DB, DBCFile,  MyDataModule,
  Menus, Registry, ShellAPI, TnTComCtrls,
  CheckQuestThreadUnit, Buttons, About, xpman, ActnList, ExtActns, Mask, Grids, TextFieldEditorUnit,
  JvExComCtrls, JvListView, JvExMask, JvToolEdit, DBGrids, JvExDBGrids, JvDBGrid, JvComponentBase,
  JvUrlListGrabber, JvUrlGrabbers, JvExControls, JvLinkLabel, ZAbstractRODataset, ZAbstractDataset,
  ZDataset, ZConnection, ZSqlProcessor, sSkinManager, sHintManager, sGroupBox,
  ZAbstractConnection;

const
  REV = '015e4596165fa435bb966bbc9ad55157508bb265';
  VERSION_1   = '1'; //*10000
  VERSION_2   = '2'; //*100
  VERSION_3   = '54';
  VERSION_EXE = VERSION_1 + '.' + VERSION_2 + '.' + VERSION_3;

  SCRIPT_TAB_NO_QUEST       =   8;
  SCRIPT_TAB_NO_CREATURE    =  17;
  SCRIPT_TAB_NO_GAMEOBJECT  =   7;
  SCRIPT_TAB_NO_ITEM        =  10;
  SCRIPT_TAB_NO_SMARTAI			=   1;
  SCRIPT_TAB_NO_OTHER       =   3;
  SCRIPT_TAB_NO_CHARACTER   =   3;

  WM_FREEQL = WM_USER + 1;

  PFX_QUEST_TEMPLATE              = 'qt';
  PFX_CREATURE_TEMPLATE           = 'ct';
  PFX_CREATURE_ONKILL_REPUTATION  = 'ck';
  PFX_CREATURE                    = 'cl';
  PFX_CREATURE_ADDON              = 'ca';
  PFX_CREATURE_TEMPLATE_ADDON     = 'cd';
  PFX_CREATURE_EQUIP_TEMPLATE     = 'ce';
  PFX_CREATURE_MODEL_INFO         = 'ci';
  PFX_CREATURE_MOVEMENT           = 'cm';
  PFX_CREATURE_LOOT_TEMPLATE      = 'co';
  PFX_CREATURE_EVENTAI            = 'cn';
  PFX_CREATURE_SMARTAI            = 'cy';
  PFX_PICKPOCKETING_LOOT_TEMPLATE = 'cp';
  PFX_SKINNING_LOOT_TEMPLATE      = 'cs';
  PFX_NPC_VENDOR                  = 'cv';
  PFX_NPC_TRAINER                 = 'cr';
  PFX_GAMEOBJECT_TEMPLATE         = 'gt';
  PFX_GAME_EVENT                  = 'ge';
  PFX_GAMEOBJECT                  = 'gl';
  PFX_GAMEOBJECT_LOOT_TEMPLATE    = 'go';
  PFX_ITEM_TEMPLATE               = 'it';
  PFX_ITEM_LOOT_TEMPLATE          = 'il';
  PFX_ITEM_ENCHANTMENT_TEMPLATE   = 'ie';
  PFX_DISENCHANT_LOOT_TEMPLATE    = 'id';
  PFX_PROSPECTING_LOOT_TEMPLATE   = 'ip';
  PFX_MILLING_LOOT_TEMPLATE       = 'im';
  PFX_REFERENCE_LOOT_TEMPLATE     = 'ir';
  PFX_PAGE_TEXT                   = 'pt';
  PFX_FISHING_LOOT_TEMPLATE       = 'ot';
  PFX_CHARACTER                   = 'ht';
  PFX_CHARACTER_INVENTORY         = 'hi';
  mob_eventai = 'EventAI';
  mob_smartai = 'SmartAI';
  PFX_LOCALES_QUEST               = 'lq';
  PFX_LOCALES_NPC_TEXT            = 'lx';

type
  TSyntaxStyle = (ssInsertDelete, ssReplace, ssUpdate);
  TParameter = (tpInteger, tpFloat, tpString, tpDate, tpTime, tpDateTime,
                  tpCurrency, tpBinaryData, tpBool);
  TRootKey = (CurrentUser, LocalMachine);

  TDateTimeRepresent = (ttTime, ttDate, ttDateTime);

  TLabeledEdit = class(ExtCtrls.TLabeledEdit)
  published
    property OnMouseWheel;
    property OnMouseWheelDown;
    property OnMouseWheelUp;
  end;

  TMainForm = class(TForm)
    MainMenu: TMainMenu;
    MyTrinityConnection: TZConnection;
    MyLootQuery: TZQuery;
    MyQuery: TZQuery;
    MyQueryAll: TZQuery;
    MyTempQuery: TZQuery;
    nLine1: TMenuItem;
    nLine2: TMenuItem;
    nLine4: TMenuItem;
    nLine5: TMenuItem;
    nLine6: TMenuItem;
    nLine7: TMenuItem;
    nHelp: TMenuItem;
    nAbout: TMenuItem;
    nBrowseCreature: TMenuItem;
    nBrowseGO: TMenuItem;
    nBrowseSite: TMenuItem;
    nCheckQuest: TMenuItem;
    nColumns: TMenuItem;
    nDeleteCreature: TMenuItem;
    nDeleteGo: TMenuItem;
    nDeleteQuest: TMenuItem;
    nEditCreature: TMenuItem;
    nEditGO: TMenuItem;
    nExit: TMenuItem;
    nFile: TMenuItem;
    nLanguage: TMenuItem;
    nEditQuest: TMenuItem;
    nSettings: TMenuItem;
    nSite: TMenuItem;
    pmCreature: TPopupMenu;
    pmGO: TPopupMenu;
    pmQuest: TPopupMenu;
    pmBrowseSite: TPopupMenu;
    pmwowhead: TMenuItem;
    pmthottbot: TMenuItem;
    pmallakhazam: TMenuItem;
    pmItem: TPopupMenu;
    nEditItem: TMenuItem;
    N1: TMenuItem;
    nDeleteItem: TMenuItem;
    N2: TMenuItem;
    nBrowseItem: TMenuItem;
    nTools: TMenuItem;
    nRebuildSpellList: TMenuItem;
    DataSource: TDataSource;
    MySQLQuery: TZQuery;
    PageControl1: TPageControl;
    tsQuest: TTabSheet;
    pnQuestTop: TPanel;
    PageControl2: TPageControl;
    tsSearch: TTabSheet;
    pnSearch: TPanel;
    lbQuestGiverSearch: TLabel;
    lbQuestTakerSearch: TLabel;
    edQuestID: TLabeledEdit;
    edQuestTitle: TLabeledEdit;
    edQuestGiverSearch: TJvComboEdit;
    edQuestTakerSearch: TJvComboEdit;
    btSearch: TBitBtn;
    btClear: TBitBtn;
    gbSpecialFlags: TGroupBox;
    edQuestFlagsSearch: TJvComboEdit;
    rbExact: TRadioButton;
    rbContain: TRadioButton;
    gbZoneOrSortSearch: TGroupBox;
    edZoneOrSortSearch: TJvComboEdit;
    rbZoneSearch: TRadioButton;
    rbQuestSortSearch: TRadioButton;
    lvQuest: TJvListView;
    Panel2: TPanel;
    btEditQuest: TBitBtn;
    btNewQuest: TBitBtn;
    btDeleteQuest: TBitBtn;
    btBrowseSite: TBitBtn;
    btCheckQuest: TBitBtn;
    btCheckAll: TBitBtn;
    StatusBar: TStatusBar;
    tsQuestPart1: TTabSheet;
    gbqtKeys: TGroupBox;
    lbId: TLabel;
    lbPrevQuestId: TLabel;
    lbNextQuestId: TLabel;
    lbNextQuestIdChain: TLabel;
    edqtId: TJvComboEdit;
    edqtPrevQuestId: TJvComboEdit;
    edqtNextQuestId: TJvComboEdit;
    edqtExclusiveGroup: TLabeledEdit;
    edqtNextQuestIdChain: TJvComboEdit;
    gbQuestSorting: TGroupBox;
    gbFlags: TGroupBox;
    lbType: TLabel;
    lbQuestFlags: TLabel;
    edqtLimitTime: TLabeledEdit;
    edqtType: TJvComboEdit;
    edqtFlags: TJvComboEdit;
    gbRequirementsBegin: TGroupBox;
    lbRequiredRaces: TLabel;
    lbRequiredMinRepFaction: TLabel;
    edqtRequiredMinRepValue: TLabeledEdit;
    edqtRequiredMinRepFaction: TJvComboEdit;
    edqtRequiredRaces: TJvComboEdit;
    gbSource: TGroupBox;
    lbSourceItemId: TLabel;
    lbSourceSpellId: TLabel;
    edqtSourceItemCount: TLabeledEdit;
    edqtSourceItemId: TJvComboEdit;
    edqtSourceSpellId: TJvComboEdit;
    gbDescription: TGroupBox;
    lDetails: TLabel;
    lObjectives: TLabel;
    lOfferRewardText: TLabel;
    lRequestItemsText: TLabel;
    lEndText: TLabel;
    edqtTitle: TLabeledEdit;
    edqtDetails: TMemo;
    edqtObjectives: TMemo;
    edqtOfferRewardText: TMemo;
    edqtRequestItemsText: TMemo;
    edqtEndText: TMemo;
    edqtObjectiveText1: TLabeledEdit;
    edqtObjectiveText2: TLabeledEdit;
    edqtObjectiveText3: TLabeledEdit;
    edqtObjectiveText4: TLabeledEdit;
    tsQuestPart2: TTabSheet;
    gbRequirementsEnd: TGroupBox;
    lbReqItemId1: TLabel;
    lbRequiredSourceItemId1: TLabel;
    lbRequiredNpcOrGo4: TLabel;
    lbRequiredNpcOrGo3: TLabel;
    lbRequiredNpcOrGo2: TLabel;
    lbRequiredNpcOrGo1: TLabel;
    lbRequiredSpellCast1: TLabel;
    lbRequiredSpellCast2: TLabel;
    lbRequiredSpellCast3: TLabel;
    lbRequiredSpellCast4: TLabel;
    edqtRequiredItemCount1: TLabeledEdit;
    edqtRequiredItemCount2: TLabeledEdit;
    edqtRequiredItemCount3: TLabeledEdit;
    edqtRequiredItemCount4: TLabeledEdit;
    edqtRequiredNpcOrGoCount4: TLabeledEdit;
    edqtRequiredNpcOrGoCount3: TLabeledEdit;
    edqtRequiredNpcOrGoCount2: TLabeledEdit;
    edqtRequiredNpcOrGoCount1: TLabeledEdit;
    edqtRequiredSourceItemCount1: TLabeledEdit;
    edqtRequiredSourceItemCount2: TLabeledEdit;
    edqtRequiredSourceItemCount3: TLabeledEdit;
    edqtRequiredSourceItemCount4: TLabeledEdit;
    edqtRequiredItemId1: TJvComboEdit;
    edqtRequiredItemId2: TJvComboEdit;
    edqtRequiredItemId3: TJvComboEdit;
    edqtRequiredItemId4: TJvComboEdit;
    edqtRequiredSourceItemId1: TJvComboEdit;
    edqtRequiredSourceItemId2: TJvComboEdit;
    edqtRequiredSourceItemId3: TJvComboEdit;
    edqtRequiredSourceItemId4: TJvComboEdit;
    edqtRequiredNpcOrGo4: TJvComboEdit;
    edqtRequiredNpcOrGo3: TJvComboEdit;
    edqtRequiredNpcOrGo2: TJvComboEdit;
    edqtRequiredNpcOrGo1: TJvComboEdit;
    edqtRequiredSpellCast1: TJvComboEdit;
    edqtRequiredSpellCast2: TJvComboEdit;
    edqtRequiredSpellCast3: TJvComboEdit;
    edqtRequiredSpellCast4: TJvComboEdit;
    gbRewards: TGroupBox;
    lbRewardChoiceItemId1: TLabel;
    lbRewChoiceItemId2: TLabel;
    lbRewChoiceItemId3: TLabel;
    lbRewChoiceItemId4: TLabel;
    lbRewChoiceItemId5: TLabel;
    lbRewChoiceItemId6: TLabel;
    lbRewardItemId1: TLabel;
    lbRewardItemId2: TLabel;
    lbRewardItemId3: TLabel;
    lbRewardItemId4: TLabel;
    lbRewardFactionId1: TLabel;
    lbRewardFactionId2: TLabel;
    lbRewardFactionId3: TLabel;
    lbRewardFactionId4: TLabel;
    lbRewardFactionId5: TLabel;
    lbRewardSpell: TLabel;
    edqtRewardChoiceItemCount1: TLabeledEdit;
    edqtRewardChoiceItemCount2: TLabeledEdit;
    edqtRewardChoiceItemCount3: TLabeledEdit;
    edqtRewardChoiceItemCount4: TLabeledEdit;
    edqtRewardChoiceItemCount5: TLabeledEdit;
    edqtRewardChoiceItemCount6: TLabeledEdit;
    edqtRewardItemCount1: TLabeledEdit;
    edqtRewardItemCount2: TLabeledEdit;
    edqtRewardItemCount3: TLabeledEdit;
    edqtRewardItemCount4: TLabeledEdit;
    edqtRewardFactionValueId1: TLabeledEdit;
    edqtRewardFactionValueId2: TLabeledEdit;
    edqtRewardOrRequiredMoney: TLabeledEdit;
    edqtRewardMoneyMaxLevel: TLabeledEdit;
    edqtRewardFactionValueId3: TLabeledEdit;
    edqtRewardFactionValueId4: TLabeledEdit;
    edqtRewardFactionValueId5: TLabeledEdit;
    edqtRewardChoiceItemId1: TJvComboEdit;
    edqtRewardItemId1: TJvComboEdit;
    edqtRewardFactionId1: TJvComboEdit;
    edqtRewardSpell: TJvComboEdit;
    edqtRewardChoiceItemId2: TJvComboEdit;
    edqtRewardChoiceItemId3: TJvComboEdit;
    edqtRewardChoiceItemId4: TJvComboEdit;
    edqtRewardChoiceItemId5: TJvComboEdit;
    edqtRewardChoiceItemId6: TJvComboEdit;
    edqtRewardItemId2: TJvComboEdit;
    edqtRewardItemId3: TJvComboEdit;
    edqtRewardItemId4: TJvComboEdit;
    edqtRewardFactionId2: TJvComboEdit;
    edqtRewardFactionId3: TJvComboEdit;
    edqtRewardFactionId4: TJvComboEdit;
    edqtRewardFactionId5: TJvComboEdit;
    gbOther: TGroupBox;
    edqtPointX: TLabeledEdit;
    edqtPointY: TLabeledEdit;
    edqtPointOption: TLabeledEdit;
    edqtEmoteOnIncomplete: TJvComboEdit;
    edqtEmoteOnComplete: TJvComboEdit;
    edqtCompleteScript: TLabeledEdit;
    edqtDetailsEmote1: TJvComboEdit;
    edqtDetailsEmote2: TJvComboEdit;
    edqtDetailsEmote3: TJvComboEdit;
    edqtDetailsEmote4: TJvComboEdit;
    edqtOfferRewardEmote1: TJvComboEdit;
    edqtOfferRewardEmote2: TJvComboEdit;
    edqtOfferRewardEmote3: TJvComboEdit;
    edqtOfferRewardEmote4: TJvComboEdit;
    gbAreatrigger: TGroupBox;
    lbAreatrigger: TLabel;
    edqtAreatrigger: TJvComboEdit;
    tsQuestGiver: TTabSheet;
    lbQuestGiverInfo: TLabel;
    lbLocationOrLoot: TLabel;
    lvqtGiverTemplate: TJvListView;
    lvqtGiverLocation: TJvListView;
    tsQuestTaker: TTabSheet;
    lbQuestTakerInfo: TLabel;
    lbQuestTakerLocation: TLabel;
    lvqtTakerTemplate: TJvListView;
    lvqtTakerLocation: TJvListView;
    tsScriptTab: TTabSheet;
    btCopyToClipboard: TButton;
    btExecuteScript: TButton;
    meqtLog: TMemo;
    meqtScript: TMemo;
    tsCreature: TTabSheet;
    PageControl3: TPageControl;
    tsSearchCreature: TTabSheet;
    Panel4: TPanel;
    edSearchCreatureEntry: TLabeledEdit;
    edSearchCreatureName: TLabeledEdit;
    btSearchCreature: TBitBtn;
    btClearSearchCreature: TBitBtn;
    edSearchCreatureSubName: TLabeledEdit;
    gbnpcflag: TGroupBox;
    edSearchCreaturenpcflag: TJvComboEdit;
    rbExactnpcflag: TRadioButton;
    rbContainnpcflag: TRadioButton;
    lvSearchCreature: TJvListView;
    Panel5: TPanel;
    btEditCreature: TBitBtn;
    btNewCreature: TBitBtn;
    btDeleteCreature: TBitBtn;
    btBrowseCreature: TBitBtn;
    StatusBarCreature: TStatusBar;
    tsEditCreature: TTabSheet;
    gbCreature: TGroupBox;
    lbctEntry: TLabel;
    edctEntry: TJvComboEdit;
    edctmodelid1: TLabeledEdit;
    edctmodelid2: TLabeledEdit;
    edctname: TLabeledEdit;
    edctsubname: TLabeledEdit;
    edctminlevel: TLabeledEdit;
    edctmaxlevel: TLabeledEdit;
    edctHealth_mod: TLabeledEdit;
    edctMana_mod: TLabeledEdit;
    edctmingold: TLabeledEdit;
    edctmaxgold: TLabeledEdit;
    gbCreature2: TGroupBox;
    lbctfaction_A: TLabel;
    lbctnpcflag: TLabel;
    lbctrank: TLabel;
    lbctfamily: TLabel;
    lbcttype: TLabel;
    edctattackpower: TLabeledEdit;
    edctbaseattacktime: TLabeledEdit;
    edctrangeattacktime: TLabeledEdit;
    edctrangedattackpower: TLabeledEdit;
    edctfaction_A: TJvComboEdit;
    edctnpcflag: TJvComboEdit;
    edctrank: TJvComboEdit;
    edctfamily: TJvComboEdit;
    edcttype: TJvComboEdit;
    edctmindmg: TLabeledEdit;
    edctmaxdmg: TLabeledEdit;
    edctminrangedmg: TLabeledEdit;
    edctmaxrangedmg: TLabeledEdit;
    gbLoot: TGroupBox;
    edctlootid: TLabeledEdit;
    edctpickpocketloot: TLabeledEdit;
    edctskinloot: TLabeledEdit;
    gbResistance: TGroupBox;
    edctresistance1: TLabeledEdit;
    edctresistance2: TLabeledEdit;
    edctresistance3: TLabeledEdit;
    edctresistance4: TLabeledEdit;
    edctresistance5: TLabeledEdit;
    edctresistance6: TLabeledEdit;
    gbSpells: TGroupBox;
    lbctspell1: TLabel;
    lbctspell2: TLabel;
    lbctspell3: TLabel;
    lbctspell4: TLabel;
    edctspell1: TJvComboEdit;
    edctspell2: TJvComboEdit;
    edctspell4: TJvComboEdit;
    edctspell3: TJvComboEdit;
    gbctbehaviour: TGroupBox;
    edctAIName: TLabeledEdit;
    edctScriptName: TLabeledEdit;
    gbTrainer: TGroupBox;
    lbcttrainer_type: TLabel;
    lbcttrainer_spell: TLabel;
    lbctclass: TLabel;
    lbctrace: TLabel;
    edcttrainer_type: TJvComboEdit;
    edcttrainer_spell: TJvComboEdit;
    edcttrainer_class: TJvComboEdit;
    edcttrainer_race: TJvComboEdit;
    gbArmorSpeed: TGroupBox;
    edctArmor_mod: TLabeledEdit;
    edctspeed_walk: TLabeledEdit;
    btScriptCreatureTemplate: TButton;
    tsCreatureLocation: TTabSheet;
    lvclCreatureLocation: TJvListView;
    edclguid: TLabeledEdit;
    edclid: TLabeledEdit;
    edclposition_x: TLabeledEdit;
    edclposition_y: TLabeledEdit;
    edclposition_z: TLabeledEdit;
    edclorientation: TLabeledEdit;
    edclspawntimesecs: TLabeledEdit;
    edclspawndist: TLabeledEdit;
    edclcurrentwaypoint: TLabeledEdit;
    edclspawn_position_x: TLabeledEdit;
    edclspawn_position_y: TLabeledEdit;
    edclspawn_position_z: TLabeledEdit;
    edclcurhealth: TLabeledEdit;
    edclcurmana: TLabeledEdit;
    edclMovementType: TLabeledEdit;
    btScriptCreatureLocation: TButton;
    btScriptCreatureLocationCustomToAll: TButton;
    tsCreatureLoot: TTabSheet;
    lbcoitem: TLabel;
    btCreatureLootAdd: TSpeedButton;
    btCreatureLootUpd: TSpeedButton;
    btCreatureLootDel: TSpeedButton;
    lvcoCreatureLoot: TJvListView;
    edcoentry: TLabeledEdit;
    edcoChanceOrQuestChance: TLabeledEdit;
    edcogroupid: TLabeledEdit;
    edcomincountOrRef: TLabeledEdit;
    edcomaxcount: TLabeledEdit;
    edcoitem: TJvComboEdit;
    btScriptCreatureLoot: TButton;
    btFullScriptCreatureLoot: TButton;
    tsPickpocketLoot: TTabSheet;
    lbcpitem: TLabel;
    btPickpocketLootAdd: TSpeedButton;
    btPickpocketLootUpd: TSpeedButton;
    btPickpocketLootDel: TSpeedButton;
    lvcoPickpocketLoot: TJvListView;
    edcpentry: TLabeledEdit;
    edcpChanceOrQuestChance: TLabeledEdit;
    edcpgroupid: TLabeledEdit;
    edcpmincountOrRef: TLabeledEdit;
    edcpmaxcount: TLabeledEdit;
    edcpitem: TJvComboEdit;
    btScriptPickpocketLoot: TButton;
    btFullScriptPickpocketLoot: TButton;
    tsSkinLoot: TTabSheet;
    lbcsitem: TLabel;
    btSkinLootAdd: TSpeedButton;
    btSkinLootUpd: TSpeedButton;
    btSkinLootDel: TSpeedButton;
    lvcoSkinLoot: TJvListView;
    edcsentry: TLabeledEdit;
    edcsChanceOrQuestChance: TLabeledEdit;
    edcsgroupid: TLabeledEdit;
    edcsmincountOrRef: TLabeledEdit;
    edcsmaxcount: TLabeledEdit;
    edcsitem: TJvComboEdit;
    btScriptSkinLoot: TButton;
    btFullScriptSkinLoot: TButton;
    tsNPCVendor: TTabSheet;
    lbcvitem: TLabel;
    btVendorAdd: TSpeedButton;
    btVendorUpd: TSpeedButton;
    btVendorDel: TSpeedButton;
    lvcvNPCVendor: TJvListView;
    edcventry: TLabeledEdit;
    edcvitem: TJvComboEdit;
    edcvmaxcount: TLabeledEdit;
    edcvincrtime: TLabeledEdit;
    btScriptNPCVendor: TButton;
    btFullScriptVendor: TButton;
    tsNPCTrainer: TTabSheet;
    spell: TLabel;
    btTrainerAdd: TSpeedButton;
    btTrainerUpd: TSpeedButton;
    btTrainerDel: TSpeedButton;
    lbcrreqskill: TLabel;
    lvcrNPCTrainer: TJvListView;
    edcrentry: TLabeledEdit;
    edcrspell: TJvComboEdit;
    edcrspellcost: TLabeledEdit;
    btScriptNPCTrainer: TButton;
    edcrreqskillvalue: TLabeledEdit;
    edcrreqlevel: TLabeledEdit;
    btFullScriptTrainer: TButton;
    edcrreqskill: TJvComboEdit;
    tsCreatureScript: TTabSheet;
    mectScript: TMemo;
    mectLog: TMemo;
    btCopyToClipboardCreature: TButton;
    btExecuteCreatureScript: TButton;
    Panel3: TPanel;
    tsGameObject: TTabSheet;
    PageControl4: TPageControl;
    tsSearchGO: TTabSheet;
    Panel6: TPanel;
    lbSearchGOtype: TLabel;
    lbSearchGOfaction: TLabel;
    edSearchGOEntry: TLabeledEdit;
    edSearchGOName: TLabeledEdit;
    btSearchGO: TBitBtn;
    btClearSearchGO: TBitBtn;
    edSearchGOtype: TJvComboEdit;
    edSearchGOfaction: TJvComboEdit;
    lvSearchGO: TJvListView;
    Panel7: TPanel;
    btEditGO: TBitBtn;
    btNewGO: TBitBtn;
    btDeleteGO: TBitBtn;
    btBrowseGO: TBitBtn;
    StatusBarGO: TStatusBar;
    tsEditGO: TTabSheet;
    gbGO1: TGroupBox;
    lbgtentry: TLabel;
    lbgtfaction: TLabel;
    lbgttype: TLabel;
    edgtentry: TJvComboEdit;
    edgtname: TLabeledEdit;
    edgtdisplayId: TLabeledEdit;
    edgtsize: TLabeledEdit;
    edgtScriptName: TLabeledEdit;
    edgtfaction: TJvComboEdit;
    edgttype: TJvComboEdit;
    btScriptGOTemplate: TButton;
    gbGOsounds: TGroupBox;
    edgtdata0: TLabeledEdit;
    edgtdata1: TLabeledEdit;
    edgtdata2: TLabeledEdit;
    edgtdata3: TLabeledEdit;
    edgtdata4: TLabeledEdit;
    edgtdata5: TLabeledEdit;
    edgtdata6: TLabeledEdit;
    edgtdata7: TLabeledEdit;
    edgtdata8: TLabeledEdit;
    edgtdata9: TLabeledEdit;
    edgtdata10: TLabeledEdit;
    edgtdata12: TLabeledEdit;
    edgtdata13: TLabeledEdit;
    edgtdata14: TLabeledEdit;
    edgtdata15: TLabeledEdit;
    edgtdata16: TLabeledEdit;
    edgtdata17: TLabeledEdit;
    edgtdata18: TLabeledEdit;
    edgtdata19: TLabeledEdit;
    edgtdata11: TLabeledEdit;
    edgtdata20: TLabeledEdit;
    edgtdata21: TLabeledEdit;
    edgtdata22: TLabeledEdit;
    edgtdata23: TLabeledEdit;
    tsGOLoot: TTabSheet;
    lbgoitem: TLabel;
    btGOLootAdd: TSpeedButton;
    btGOLootUpd: TSpeedButton;
    btGOLootDel: TSpeedButton;
    lvgoGOLoot: TJvListView;
    edgoentry: TLabeledEdit;
    edgoChanceOrQuestChance: TLabeledEdit;
    edgogroupid: TLabeledEdit;
    edgomincountOrRef: TLabeledEdit;
    edgomaxcount: TLabeledEdit;
    edgoitem: TJvComboEdit;
    btScriptGOLoot: TButton;
    btFullScriptGOLoot: TButton;
    tsGOScript: TTabSheet;
    megoScript: TMemo;
    megoLog: TMemo;
    btCopyToClipboardGO: TButton;
    btExecuteGOScript: TButton;
    Panel8: TPanel;
    tsItem: TTabSheet;
    Panel9: TPanel;
    tsSearchItem: TTabSheet;
    Panel10: TPanel;
    lbSearchItemSubClass: TLabel;
    lbSearchItemClass: TLabel;
    lbSearchItemItemset: TLabel;
    lbSearchItemInventoryType: TLabel;
    lbSearchItemQuality: TLabel;
    edSearchItemEntry: TLabeledEdit;
    edSearchItemName: TLabeledEdit;
    btSearchItem: TBitBtn;
    btClearSearchItem: TBitBtn;
    edSearchItemClass: TJvComboEdit;
    edSearchItemSubclass: TJvComboEdit;
    edSearchItemItemset: TJvComboEdit;
    edSearchItemInventoryType: TJvComboEdit;
    edSearchItemQuality: TJvComboEdit;
    lvSearchItem: TJvListView;
    Panel11: TPanel;
    btEditItem: TBitBtn;
    btNewItem: TBitBtn;
    btDeleteItem: TBitBtn;
    btBrowseItem: TBitBtn;
    StatusBarItem: TStatusBar;
    tsItemTemplate: TTabSheet;
    lbitentry: TLabel;
    lbitQuality: TLabel;
    lbitInventoryType: TLabel;
    lbitclass: TLabel;
    lbitsubclass: TLabel;
    lbitFlags: TLabel;
    btScriptItem: TButton;
    editentry: TJvComboEdit;
    editname: TLabeledEdit;
    editdisplayid: TLabeledEdit;
    editBuyCount: TLabeledEdit;
    editBuyPrice: TLabeledEdit;
    editSellPrice: TLabeledEdit;
    editmaxcount: TLabeledEdit;
    editstackable: TLabeledEdit;
    editContainerSlots: TLabeledEdit;
    editdescription: TLabeledEdit;
    gbitspell: TGroupBox;
    lbitspellid: TLabel;
    editspellcharges_1: TLabeledEdit;
    editspellcooldown_1: TLabeledEdit;
    editspellcategory_1: TLabeledEdit;
    editspellcategorycooldown_1: TLabeledEdit;
    editspellcharges_2: TLabeledEdit;
    editspellcooldown_2: TLabeledEdit;
    editspellcategory_2: TLabeledEdit;
    editspellcategorycooldown_2: TLabeledEdit;
    editspellcharges_3: TLabeledEdit;
    editspellcooldown_3: TLabeledEdit;
    editspellcategory_3: TLabeledEdit;
    editspellcharges_4: TLabeledEdit;
    editspellcooldown_4: TLabeledEdit;
    editspellcategory_4: TLabeledEdit;
    editspellcategorycooldown_4: TLabeledEdit;
    editspellcharges_5: TLabeledEdit;
    editspellcooldown_5: TLabeledEdit;
    editspellcategory_5: TLabeledEdit;
    editspellcategorycooldown_5: TLabeledEdit;
    editspellcategorycooldown_3: TLabeledEdit;
    editspellid_1: TJvComboEdit;
    editspellid_2: TJvComboEdit;
    editspellid_3: TJvComboEdit;
    editspellid_4: TJvComboEdit;
    editspellid_5: TJvComboEdit;
    gbitDamage: TGroupBox;
    lbitdmg_type: TLabel;
    editdmg_min1: TLabeledEdit;
    editdmg_max1: TLabeledEdit;
    editdmg_min2: TLabeledEdit;
    editdmg_max2: TLabeledEdit;
    editdmg_type1: TJvComboEdit;
    editdmg_type2: TJvComboEdit;
    gbitstats: TGroupBox;
    lbitstat_type: TLabel;
    editstat_value1: TLabeledEdit;
    editstat_value2: TLabeledEdit;
    editstat_value3: TLabeledEdit;
    editstat_value4: TLabeledEdit;
    editstat_value5: TLabeledEdit;
    editstat_value6: TLabeledEdit;
    editstat_value7: TLabeledEdit;
    editstat_value8: TLabeledEdit;
    editstat_value9: TLabeledEdit;
    editstat_value10: TLabeledEdit;
    editstat_type1: TJvComboEdit;
    editstat_type2: TJvComboEdit;
    editstat_type3: TJvComboEdit;
    editstat_type4: TJvComboEdit;
    editstat_type5: TJvComboEdit;
    editstat_type6: TJvComboEdit;
    editstat_type7: TJvComboEdit;
    editstat_type8: TJvComboEdit;
    editstat_type9: TJvComboEdit;
    editstat_type10: TJvComboEdit;
    gbitResistance: TGroupBox;
    editholy_res: TLabeledEdit;
    editfire_res: TLabeledEdit;
    editnature_res: TLabeledEdit;
    editfrost_res: TLabeledEdit;
    editshadow_res: TLabeledEdit;
    editarcane_res: TLabeledEdit;
    gbitsocket: TGroupBox;
    editsocketColor_1: TLabeledEdit;
    editsocketContent_1: TLabeledEdit;
    editsocketColor_2: TLabeledEdit;
    editsocketContent_2: TLabeledEdit;
    editsocketColor_3: TLabeledEdit;
    editsocketContent_3: TLabeledEdit;
    gbitRequirements: TGroupBox;
    lbitAllowableClass: TLabel;
    lbitAllowableRace: TLabel;
    lbitRequiredReputationFaction: TLabel;
    lbitRequiredReputationRank: TLabel;
    lbitrequiredspell: TLabel;
    lbitRequiredSkill: TLabel;
    editItemLevel: TLabeledEdit;
    editRequiredLevel: TLabeledEdit;
    editRequiredSkillRank: TLabeledEdit;
    editrequiredhonorrank: TLabeledEdit;
    editRequiredCityRank: TLabeledEdit;
    editRequiredDisenchantSkill: TLabeledEdit;
    editAllowableRace: TJvComboEdit;
    editAllowableClass: TJvComboEdit;
    editRequiredReputationFaction: TJvComboEdit;
    editRequiredReputationRank: TJvComboEdit;
    editrequiredspell: TJvComboEdit;
    editRequiredSkill: TJvComboEdit;
    gbitAmmo: TGroupBox;
    lbitbonding: TLabel;
    lbititemset: TLabel;
    editarmor: TLabeledEdit;
    editdelay: TLabeledEdit;
    editammo_type: TLabeledEdit;
    editRangedModRange: TLabeledEdit;
    editblock: TLabeledEdit;
    editMaxDurability: TLabeledEdit;
    editbonding: TJvComboEdit;
    edititemset: TJvComboEdit;
    gbitOther: TGroupBox;
    lbitLanguageID: TLabel;
    lbitPageMaterial: TLabel;
    lbitMaterial: TLabel;
    lbitBagFamily: TLabel;
    lbitsheath: TLabel;
    lbitPageText: TLabel;
    lbitMap: TLabel;
    editDisenchantID: TLabeledEdit;
    editstartquest: TLabeledEdit;
    editlockid: TLabeledEdit;
    editRandomSuffix: TLabeledEdit;
    editRandomProperty: TLabeledEdit;
    editTotemCategory: TLabeledEdit;
    editScriptName: TLabeledEdit;
    editLanguageID: TJvComboEdit;
    editPageMaterial: TJvComboEdit;
    editMaterial: TJvComboEdit;
    editsheath: TJvComboEdit;
    editBagFamily: TJvComboEdit;
    editunk0: TLabeledEdit;
    editPageText: TJvComboEdit;
    editMap: TJvComboEdit;
    editQuality: TJvComboEdit;
    editInventoryType: TJvComboEdit;
    editclass: TJvComboEdit;
    editsubclass: TJvComboEdit;
    editFlags: TJvComboEdit;
    tsItemLoot: TTabSheet;
    lbilitem: TLabel;
    btItemLootAdd: TSpeedButton;
    btItemLootUpd: TSpeedButton;
    btItemLootDel: TSpeedButton;
    lvitItemLoot: TJvListView;
    edilentry: TLabeledEdit;
    edilChanceOrQuestChance: TLabeledEdit;
    edilgroupid: TLabeledEdit;
    edilmincountOrRef: TLabeledEdit;
    edilmaxcount: TLabeledEdit;
    edilitem: TJvComboEdit;
    btScriptItemLoot: TButton;
    btFullScriptItemLoot: TButton;
    tsDisenchantLoot: TTabSheet;
    lbiditem: TLabel;
    btDisLootAdd: TSpeedButton;
    btDisLootUpd: TSpeedButton;
    btDisLootDel: TSpeedButton;
    lvitDisLoot: TJvListView;
    edidentry: TLabeledEdit;
    edidChanceOrQuestChance: TLabeledEdit;
    edidgroupid: TLabeledEdit;
    edidmincountOrRef: TLabeledEdit;
    edidmaxcount: TLabeledEdit;
    ediditem: TJvComboEdit;
    btScriptDisLoot: TButton;
    btFullScriptDisLoot: TButton;
    tsItemScript: TTabSheet;
    meitScript: TMemo;
    meitLog: TMemo;
    btCopyToClipboardItem: TButton;
    btExecuteItemScript: TButton;
    tsOther: TTabSheet;
    Panel12: TPanel;
    PageControl6: TPageControl;
    tsFishingLoot: TTabSheet;
    lbotitem: TLabel;
    btFishingLootAdd: TSpeedButton;
    btFishingLootUpd: TSpeedButton;
    btFishingLootDel: TSpeedButton;
    lbotentry: TLabel;
    lbotChoose: TLabel;
    lvotFishingLoot: TJvListView;
    edotChanceOrQuestChance: TLabeledEdit;
    edotgroupid: TLabeledEdit;
    edotmincountOrRef: TLabeledEdit;
    edotmaxcount: TLabeledEdit;
    edotitem: TJvComboEdit;
    btScriptFishingLoot: TButton;
    btFullScriptFishLoot: TButton;
    edotentry: TJvComboEdit;
    edotZone: TJvComboEdit;
    btGetLootForZone: TButton;
    tsPageText: TTabSheet;
    lvSearchPageText: TJvListView;
    GroupBox1: TGroupBox;
    btClearSearchPageText: TBitBtn;
    btSearchPageText: TBitBtn;
    edSearchPageTextNextPage: TLabeledEdit;
    edSearchPageTextText: TLabeledEdit;
    edSearchPageTextEntry: TLabeledEdit;
    Panel13: TPanel;
    lbptentry: TLabel;
    lbpttext: TLabel;
    lbptnext_page: TLabel;
    edptentry: TJvComboEdit;
    edptnext_page: TJvComboEdit;
    edpttext: TMemo;
    btScriptPageText: TButton;
    tsOtherScript: TTabSheet;
    meotScript: TMemo;
    meotLog: TMemo;
    btCopyToClipboardOther: TButton;
    btExecuteOtherScript: TButton;
    tsSQL: TTabSheet;
    Panel14: TPanel;
    PageControl7: TPageControl;
    tsSQL1: TTabSheet;
    Panel15: TPanel;
    btSQLOpen: TBitBtn;
    SQLEdit: TMemo;
    tsProspectingLoot: TTabSheet;
    lbipitem: TLabel;
    btProsLootAdd: TSpeedButton;
    btProsLootUpd: TSpeedButton;
    btProsLootDel: TSpeedButton;
    lvitProsLoot: TJvListView;
    edipentry: TLabeledEdit;
    edipChanceOrQuestChance: TLabeledEdit;
    edipgroupid: TLabeledEdit;
    edipmincountOrRef: TLabeledEdit;
    edipmaxcount: TLabeledEdit;
    edipitem: TJvComboEdit;
    btScriptProsLoot: TButton;
    btFullScriptProsLoot: TButton;
    edqtStartScript: TLabeledEdit;
    tsStartScript: TTabSheet;
    tsCompleteScript: TTabSheet;
    lvqtStartScript: TJvListView;
    edsscommand: TJvComboEdit;
    edssid: TLabeledEdit;
    btssAdd: TSpeedButton;
    btssUpd: TSpeedButton;
    btssDel: TSpeedButton;
    edssdelay: TLabeledEdit;
    lbsscommand: TLabel;
    edssdatalong: TLabeledEdit;
    edssdatalong2: TLabeledEdit;
    edssdataint: TLabeledEdit;
    edssx: TLabeledEdit;
    edssy: TLabeledEdit;
    edssz: TLabeledEdit;
    edsso: TLabeledEdit;
    lvqtEndScript: TJvListView;
    edescommand: TJvComboEdit;
    edesid: TLabeledEdit;
    btesAdd: TSpeedButton;
    btesUpd: TSpeedButton;
    btesDel: TSpeedButton;
    edesdelay: TLabeledEdit;
    lbescommand: TLabel;
    edesdatalong: TLabeledEdit;
    edesdatalong2: TLabeledEdit;
    edesdataint: TLabeledEdit;
    edesx: TLabeledEdit;
    edesy: TLabeledEdit;
    edesz: TLabeledEdit;
    edeso: TLabeledEdit;
    tsEnchantment: TTabSheet;
    lvitEnchantment: TJvListView;
    edieentry: TLabeledEdit;
    ediechance: TLabeledEdit;
    btieShowScript: TButton;
    btieShowFullScript: TButton;
    btieEnchAdd: TSpeedButton;
    btieEnchUpd: TSpeedButton;
    btieEnchDel: TSpeedButton;
    edieench: TLabeledEdit;
    lbqtStartScriptHint: TLabel;
    lbqtCompleteScriptHint: TLabel;
    lbclCreatureLocationHint: TLabel;
    lbcoCreatureLootHint: TLabel;
    lbcoPickpocketLootHint: TLabel;
    lbcoSkinLootHint: TLabel;
    lbcvNPCVendorHint: TLabel;
    lbcvNPCTrainerHint: TLabel;
    tsGOLocation: TTabSheet;
    lvglGOLocation: TJvListView;
    edglguid: TLabeledEdit;
    edglid: TLabeledEdit;
    edglposition_x: TLabeledEdit;
    edglposition_y: TLabeledEdit;
    edglposition_z: TLabeledEdit;
    edglorientation: TLabeledEdit;
    btScriptGOLocation: TButton;
    edglrotation0: TLabeledEdit;
    edglrotation1: TLabeledEdit;
    edglrotation2: TLabeledEdit;
    edglrotation3: TLabeledEdit;
    edglspawntimesecs: TLabeledEdit;
    edglanimprogress: TLabeledEdit;
    edglstate: TLabeledEdit;
    lbglGOLocationHint: TLabel;
    lbitItemLootHint: TLabel;
    lbitDisLootHint: TLabel;
    lbitProsLootHint: TLabel;
    lbitItemEnchHint: TLabel;
    tsChars: TTabSheet;
    Panel1: TPanel;
    PageControl8: TPageControl;
    tsCharSearch: TTabSheet;
    Panel16: TPanel;
    edCharGuid: TLabeledEdit;
    edCharName: TLabeledEdit;
    btCharSearch: TBitBtn;
    btCharClear: TBitBtn;
    lvSearchChar: TJvListView;
    StatusBarChar: TStatusBar;
    edCharAccount: TLabeledEdit;
    CheckforUpdates1: TMenuItem;
    ActionList1: TActionList;
    BrowseURL1: TBrowseURL;
    nInternet: TMenuItem;
    rea: TTabSheet;
    edcaguid: TLabeledEdit;
    edcamount : TLabeledEdit;
    edcabytes1: TLabeledEdit;
    edcabytes2: TLabeledEdit;
    edcaemote : TJvComboEdit;
    edcaauras: TLabeledEdit;
    lbcaCreatureAddonHint: TLabel;
    btScriptCreatureAddon: TButton;
    editArmorDamageModifier: TLabeledEdit;
    tsItemLootedFrom: TTabSheet;
    lvitItemLootedFrom: TJvListView;
    nUninstall: TMenuItem;
    nPreferences: TMenuItem;
    tsGameEvents: TTabSheet;
    GroupBox2: TGroupBox;
    btClearSearchGameEvent: TBitBtn;
    btSearchGameEvent: TBitBtn;
    edSearchGameEventDesc: TLabeledEdit;
    edSearchGameEventEntry: TLabeledEdit;
    pnSelectedEventInfo: TPanel;
    edGameEventGOHint: TLabel;
    edGameEventCreatureHint: TLabel;
    lvGameEventCreature: TJvListView;
    lvGameEventGO: TJvListView;
    btgeCreatureGuidDel: TSpeedButton;
    btgeCreatureGuidAdd: TSpeedButton;
    edgeCreatureGuid: TJvComboEdit;
    btgeGOguidDel: TSpeedButton;
    btgeGOGuidAdd: TSpeedButton;
    edgeGOguid: TJvComboEdit;
    btScriptGameEvent: TButton;
    btgeCreatureGuidInv: TSpeedButton;
    btgeGOGuidInv: TSpeedButton;
    Panel17: TPanel;
    lvSearchGameEvent: TJvListView;
    Panel18: TPanel;
    btGameEventDel: TSpeedButton;
    btGameEventUpd: TSpeedButton;
    btGameEventAdd: TSpeedButton;
    edgedescription: TLabeledEdit;
    edgelength: TLabeledEdit;
    edgeoccurence: TLabeledEdit;
    edgeend_time: TLabeledEdit;
    edgestart_time: TLabeledEdit;
    edgeeventEntry: TLabeledEdit;
    btFullScriptCreatureLocation: TButton;
    btFullScriptGOLocation: TButton;
    btAddQuestGiver: TSpeedButton;
    btDelQuestGiver: TSpeedButton;
    btAddQuestTaker: TSpeedButton;
    btDelQuestTaker: TSpeedButton;
    edqtRequiredMaxRepFaction: TJvComboEdit;
    edqtRequiredMaxRepValue: TLabeledEdit;
    lbRequiredMaxRepFaction: TLabel;
    UpDown2: TUpDown;
    UpDown1: TUpDown;
    edqtLevel: TLabeledEdit;
    edqtMinLevel: TLabeledEdit;
    edqtRequiredSkillPoints: TLabeledEdit;
    cbctRacialLeader: TCheckBox;
    edctdmgschool: TLabeledEdit;
    nReconnect: TMenuItem;
    N3: TMenuItem;
    editspellppmRate_5: TLabeledEdit;
    editspellppmRate_4: TLabeledEdit;
    editspellppmRate_3: TLabeledEdit;
    editspellppmRate_2: TLabeledEdit;
    editspellppmRate_1: TLabeledEdit;
    tsCreatureUsed: TTabSheet;
    pcCreatureInfo: TPageControl;
    tsCreatureStarts: TTabSheet;
    tsCreatureEnds: TTabSheet;
    tsCreatureObjectiveOf: TTabSheet;
    lvCreatureStarts: TJvListView;
    lvCreatureEnds: TJvListView;
    lvCreatureObjectiveOf: TJvListView;
    Panel20: TPanel;
    tsGOInvolvedIn: TTabSheet;
    pcGameObjectInfo: TPageControl;
    tsGOStarts: TTabSheet;
    lvGameObjectStarts: TJvListView;
    tsGOEnds: TTabSheet;
    lvGameObjectEnds: TJvListView;
    tsGOObjectiveOf: TTabSheet;
    lvGameObjectObjectiveOf: TJvListView;
    Panel21: TPanel;
    tsItemInvolvedIn: TTabSheet;
    Panel22: TPanel;
    pcItemInfo: TPageControl;
    tsItemStarts: TTabSheet;
    lvItemStarts: TJvListView;
    tsItemObjectiveOf: TTabSheet;
    lvItemObjectiveOf: TJvListView;
    tsItemSourceFor: TTabSheet;
    lvItemSourceFor: TJvListView;
    tsItemProvidedFor: TTabSheet;
    tsItemRewardFrom: TTabSheet;
    lvItemProvidedFor: TJvListView;
    lvItemRewardFrom: TJvListView;
    tsCreatureMovement: TTabSheet;
    lvcmMovement: TJvListView;
    lbHintCreatureMovement: TLabel;
    btShowCreatureMovementScript: TButton;
    btFullCreatureMovementScript: TButton;
    btCreatureMvmntAdd: TSpeedButton;
    btCreatureMvmntUpd: TSpeedButton;
    btCreatureMvmntDel: TSpeedButton;
    edcmid: TLabeledEdit;
    edcmpoint: TLabeledEdit;
    edcmposition_x: TLabeledEdit;
    edcmposition_y: TLabeledEdit;
    edcmposition_z: TLabeledEdit;
    edcmwaittime: TLabeledEdit;
    edcmtextid1: TLabeledEdit;
    edcmtextid2: TLabeledEdit;
    edcmtextid3: TLabeledEdit;
    edcmtextid4: TLabeledEdit;
    edcmtextid5: TLabeledEdit;
    edcmemote: TJvComboEdit;
    edcmspell: TLabeledEdit;
    edcmwpguid: TLabeledEdit;
    edcmmodel1: TLabeledEdit;
    edcmorientation: TLabeledEdit;
    edcmmodel2: TLabeledEdit;
    lbqtDetailsEmote1: TLabel;
    lbqtDetailsEmote2: TLabel;
    lbqtDetailsEmote3: TLabel;
    lbqtDetailsEmote4: TLabel;
    lbqtIncompleteEmote: TLabel;
    lbqtEmoteOnComplete: TLabel;
    lbqtOfferRewardEmote1: TLabel;
    lbqtOfferRewardEmote2: TLabel;
    lbqtOfferRewardEmote3: TLabel;
    lbqtOfferRewardEmote4: TLabel;
    lbcaemote: TLabel;
    lbcmemote: TLabel;
    edclequipment_id: TLabeledEdit;
    edclmodelid: TLabeledEdit;
    edctfaction_H: TJvComboEdit;
    lbctfaction_H: TLabel;
    edctRegenHealth: TLabeledEdit;
    edctequipment_id: TLabeledEdit;
    tsCreatureModelInfo: TTabSheet;
    tsCreatureEquipTemplate: TTabSheet;
    Panel23: TPanel;
    edceentry: TLabeledEdit;
    btShowCreatureEquipmentScript: TButton;
    lvCreatureModelSearch: TJvListView;
    Panel24: TPanel;
    btCreatureModelSearch: TBitBtn;
    edCreatureModelSearch: TLabeledEdit;
    btShowCreatureModelInfoScript: TButton;
    edcimodelid: TLabeledEdit;
    edcibounding_radius: TLabeledEdit;
    edcicombat_reach: TLabeledEdit;
    edcigender: TLabeledEdit;
    edcimodelid_other_gender: TLabeledEdit;
    tsCreatureOnKillReputation: TTabSheet;
    edckRewOnKillRepValue1: TLabeledEdit;
    edckRewOnKillRepFaction1: TJvComboEdit;
    edckRewOnKillRepFaction2: TJvComboEdit;
    lbckRewOnKillRepFaction1: TLabel;
    lbckRewOnKillRepFaction2: TLabel;
    edckRewOnKillRepValue2: TLabeledEdit;
    edckMaxStanding1: TLabeledEdit;
    edckMaxStanding2: TLabeledEdit;
    cbckIsTeamAward1: TCheckBox;
    cbckIsTeamAward2: TCheckBox;
    cbckTeamDependent: TCheckBox;
    btScriptCreatureOnKillReputation: TButton;
    edckcreature_id: TLabeledEdit;
    editFoodType: TJvComboEdit;
    lbitFoodType: TLabel;
    tsCreatureTemplateAddon: TTabSheet;
    edcdentry: TLabeledEdit;
    btScriptCreatureTemplateAddon: TButton;
    edcdauras: TLabeledEdit;
    edcdbytes1: TLabeledEdit;
    edcdmount: TLabeledEdit;
    lbcdCreatureTemplateAddonHint: TLabel;
    edcdbytes2: TLabeledEdit;
    edcdemote: TJvComboEdit;
    lbcdemote: TLabel;
    editGemProperties: TJvComboEdit;
    lbitGemProperties: TLabel;
    editsocketBonus: TJvComboEdit;
    lbitsocketBonus: TLabel;
    tsButtonScript: TTabSheet;
    lvgbButtonScript: TJvListView;
    edgbo: TLabeledEdit;
    edgbz: TLabeledEdit;
    edgby: TLabeledEdit;
    edgbx: TLabeledEdit;
    edgbdataint: TLabeledEdit;
    edgbdatalong2: TLabeledEdit;
    edgbdatalong: TLabeledEdit;
    edgbdelay: TLabeledEdit;
    edgbid: TLabeledEdit;
    edgbcommand: TJvComboEdit;
    lbhintGOButtonScript: TLabel;
    lbgbcommand: TLabel;
    btgbDel: TSpeedButton;
    btgbUpd: TSpeedButton;
    btgbAdd: TSpeedButton;
    btgbShowButtonScriptScript: TButton;
    btBrowseQuestPopup: TBitBtn;
    btBrowseCreaturePopup: TBitBtn;
    btBrowseGOPopup: TBitBtn;
    btBrowseItemPopup: TBitBtn;
    editmaxMoneyLoot: TLabeledEdit;
    editminMoneyLoot: TLabeledEdit;
    edctmodelid4: TLabeledEdit;
    edctmodelid3: TLabeledEdit;
    edglmap: TJvComboEdit;
    lbglmap: TLabel;
    edclmap: TJvComboEdit;
    lbclmap: TLabel;
    lbqtPointMapId: TLabel;
    edqtPointMapId: TJvComboEdit;
    tsCharacter: TTabSheet;
    edhtaccount: TLabeledEdit;
    edhtname: TLabeledEdit;
    edhtposition_x: TLabeledEdit;
    edhtposition_y: TLabeledEdit;
    edhtposition_z: TLabeledEdit;
    edhtorientation: TLabeledEdit;
    edhttotaltime: TLabeledEdit;
    edhtleveltime: TLabeledEdit;
    edhtlogout_time: TLabeledEdit;
    edhtrest_bonus: TLabeledEdit;
    edhtresettalents_cost: TLabeledEdit;
    edhtresettalents_time: TLabeledEdit;
    edhttrans_x: TLabeledEdit;
    edhttrans_y: TLabeledEdit;
    edhttrans_z: TLabeledEdit;
    edhttrans_o: TLabeledEdit;
    edhttransguid: TLabeledEdit;
    edhtstable_slots: TLabeledEdit;
    edhtat_login: TLabeledEdit;
    cbhtonline: TCheckBox;
    cbhtcinematic: TCheckBox;
    edhtrace: TJvComboEdit;
    lbhtrace: TLabel;
    edhtclass: TJvComboEdit;
    lbhtclass: TLabel;
    edhtmap: TJvComboEdit;
    lbhtmap: TLabel;
    edhtzone: TJvComboEdit;
    lbhtzone: TLabel;
    tsCharacterScript: TTabSheet;
    mehtScript: TMemo;
    mehtLog: TMemo;
    btCopyToClipboardChar: TButton;
    btExecuteScriptChar: TButton;
    btShowCharacterScript: TButton;
    lbhtguid: TLabel;
    edhtguid: TJvComboEdit;
    tsCharacterInventory: TTabSheet;
    btShowCharacterInventoryScript: TButton;
    btShowFULLCharacterInventoryScript: TButton;
    btCharInvDel: TSpeedButton;
    btCharInvUpd: TSpeedButton;
    btCharInvAdd: TSpeedButton;
    lvCharacterInventory: TJvListView;
    edhiguid: TLabeledEdit;
    edhibag: TLabeledEdit;
    edhislot: TLabeledEdit;
    edhiitem: TLabeledEdit;
    edcolootmode: TJvComboEdit;
    lbcolootmode: TLabel;
    lbcplootmode: TLabel;
    edcplootmode: TJvComboEdit;
    edcslootmode: TJvComboEdit;
    lbcslootmode: TLabel;
    edgolootmode: TJvComboEdit;
    lbgolootmode: TLabel;
    edillootmode: TJvComboEdit;
    lbillootmode: TLabel;
    edidlootmode: TJvComboEdit;
    lbidlootmode: TLabel;
    ediplootmode: TJvComboEdit;
    lbiplootmode: TLabel;
    edqtSpecialFlags: TJvComboEdit;
    lbqtSpecialFlags: TLabel;
    edqtRequiredFactionValue1: TLabeledEdit;
    lbqtRequiredFactionId1: TLabel;
    edqtRequiredFactionId1: TJvComboEdit;
    editarea: TJvComboEdit;
    lbitarea: TLabel;
    JvDBGrid1: TJvDBGrid;
    JvHttpUrlGrabber: TJvHttpUrlGrabber;
    pmwowdb: TMenuItem;
    editspelltrigger_5: TJvComboEdit;
    editspelltrigger_4: TJvComboEdit;
    editspelltrigger_3: TJvComboEdit;
    editspelltrigger_2: TJvComboEdit;
    lbitspelltrigger: TLabel;
    editspelltrigger_1: TJvComboEdit;
    edctunit_flags: TJvComboEdit;
    lbctunit_flags: TLabel;
    edcttype_flags: TJvComboEdit;
    lbcttype_flags: TLabel;
    edctdynamicflags: TJvComboEdit;
    lbctdynamicflags: TLabel;
    edgtflags: TJvComboEdit;
    lbgtflags: TLabel;
    lbctMovementType: TLabel;
    edctMovementType: TJvComboEdit;
    edctInhabitType: TJvComboEdit;
    lbctInhabitType: TLabel;
    tsCreatureEventAI: TTabSheet;
    Button1: TButton;
    Button2: TButton;
    lvcnEventAI: TJvListView;
    edcnid: TLabeledEdit;
    edcncreature_id: TLabeledEdit;
    edcnevent_type: TJvComboEdit;
    lbcnevent_type: TLabel;
    edcnevent_inverse_phase_mask: TJvComboEdit;
    lbcnevent_inverse_phase_mask: TLabel;
    edcnevent_param1: TJvComboEdit;
    lbcnevent_param1: TLabel;
    edcnevent_param2: TJvComboEdit;
    lbcnevent_param2: TLabel;
    edcnevent_param3: TJvComboEdit;
    lbcnevent_param3: TLabel;
    edcnaction1_param3: TJvComboEdit;
    lbcnaction1_param3: TLabel;
    lbcnaction1_param2: TLabel;
    edcnaction1_param2: TJvComboEdit;
    lbcnaction1_param1: TLabel;
    edcnaction1_param1: TJvComboEdit;
    lbcnaction1_type: TLabel;
    edcnaction1_type: TJvComboEdit;
    edcnaction2_param3: TJvComboEdit;
    lbcnaction2_param3: TLabel;
    edcnaction2_param2: TJvComboEdit;
    lbcnaction2_param2: TLabel;
    lbcnaction2_param1: TLabel;
    edcnaction2_param1: TJvComboEdit;
    edcnaction2_type: TJvComboEdit;
    lbcnaction2_type: TLabel;
    edcnaction3_param3: TJvComboEdit;
    lbcnaction3_param3: TLabel;
    edcnaction3_param2: TJvComboEdit;
    lbcnaction3_param2: TLabel;
    lbcnaction3_param1: TLabel;
    edcnaction3_param1: TJvComboEdit;
    edcnaction3_type: TJvComboEdit;
    lbcnaction3_type: TLabel;
    edcncomment: TLabeledEdit;
    linkEventAIInfo: TLabel;
    edctmechanic_immune_mask: TJvComboEdit;
    lbctmechanic_immune_mask: TLabel;
    ZSQLProcessor: TZSQLProcessor;
    edotlootmode: TJvComboEdit;
    lbotlootmode: TLabel;
    nDBCDir: TMenuItem;
    edctscale: TLabeledEdit;
    Timer1: TTimer;
    edcnevent_chance: TLabeledEdit;
    edctIconName: TLabeledEdit;
    edgtcastBarCaption: TLabeledEdit;
    edSearchItemFlags: TJvComboEdit;
    lbSearchItemFlags: TLabel;
    edcvExtendedCost: TJvComboEdit;
    lbcvExtendedCost: TLabel;
    editDuration: TLabeledEdit;
    lbRewardSpellCast: TLabel;
    edqtRewardSpellCast: TJvComboEdit;
    edqtRewardTitleId: TLabeledEdit;
    edcdmoveflags: TLabeledEdit;
    edcamoveflags: TLabeledEdit;
    edqtSuggestedPlayers: TLabeledEdit;
    edqtRequiredSkillId: TJvComboEdit;
    edqtZoneOrSort: TJvComboEdit;
    rbqtQuestSort: TRadioButton;
    rbqtZoneID: TRadioButton;
    edctPetSpellDataId: TLabeledEdit;
    edqtRewardMailTemplateId: TLabeledEdit;
    edqtRewardMailDelay: TLabeledEdit;
    edctflags_extra: TLabeledEdit;
    edctdifficulty_entry_1: TJvComboEdit;
    lbctdifficulty_entry_1: TLabel;
    lbcnevent_param4: TLabel;
    edcnevent_param4: TJvComboEdit;
    edcnevent_flags: TLabeledEdit;
    edqtRewardHonor: TLabeledEdit;
    edqtMethod: TLabeledEdit;
    pmruwowhead: TMenuItem;
    sHintManager1: TsHintManager;
    nEditCreatureAI: TMenuItem;
    N4: TMenuItem;
    btEventAIAdd: TSpeedButton;
    btEventAIUpd: TSpeedButton;
    btEventAIDel: TSpeedButton;
    tsLocalesQuest: TTabSheet;
    gbLocalesQuest: TsGroupBox;
    edlqTitle: TLabeledEdit;
    edlqDetail: TMemo;
    l2Detail: TLabel;
    edlqObjectives: TMemo;
    l2Objectives: TLabel;
    l2EndText: TLabel;
    edlqEndText: TMemo;
    edlqOfferRewardText: TMemo;
    edlqRequestItemText: TMemo;
    l2RequestItemsText: TLabel;
    l2OfferRewardText: TLabel;
    edlqObjectiveText1: TLabeledEdit;
    edlqObjectiveText2: TLabeledEdit;
    edlqObjectiveText3: TLabeledEdit;
    edlqObjectiveText4: TLabeledEdit;
    btlqShowFullLocalesScript: TButton;
    editScalingStatDistribution: TLabeledEdit;
    editScalingStatValue: TLabeledEdit;
    editItemLimitCategory: TLabeledEdit;
    editStatsCount: TLabeledEdit;
    edqtRequiredPlayerKills: TLabeledEdit;
    edqtRewardTalents: TLabeledEdit;
    tsMillingLoot: TTabSheet;
    lvitMillingLoot: TJvListView;
    edimitem: TJvComboEdit;
    edimentry: TLabeledEdit;
    Label2: TLabel;
    edimChanceOrQuestChance: TLabeledEdit;
    edimgroupid: TLabeledEdit;
    edimmincountOrRef: TLabeledEdit;
    edimmaxcount: TLabeledEdit;
    edimlootmode: TJvComboEdit;
    Label3: TLabel;
    btMillingLootAdd: TSpeedButton;
    btMillingLootUpd: TSpeedButton;
    btMillingLootDel: TSpeedButton;
    btFullScriptMillingLoot: TButton;
    btScriptMillingLoot: TButton;
    edceitemEntry1: TJvComboEdit;
    edceitemEntry2: TJvComboEdit;
    edceitemEntry3: TJvComboEdit;
    lbceitemEntry1: TLabel;
    lbceitemEntry2: TLabel;
    lbceitemEntry3: TLabel;
    edclphaseMask: TLabeledEdit;
    edglphaseMask: TLabeledEdit;
    edgeholiday: TLabeledEdit;
    edgtIconName: TLabeledEdit;
    edctdmg_multiplier: TLabeledEdit;
    edctunit_class: TLabeledEdit;
    edqtDetailsEmoteDelay1: TLabeledEdit;
    edqtDetailsEmoteDelay2: TLabeledEdit;
    edqtDetailsEmoteDelay3: TLabeledEdit;
    edqtDetailsEmoteDelay4: TLabeledEdit;
    edqtOfferRewardEmoteDelay1: TLabeledEdit;
    edqtOfferRewardEmoteDelay2: TLabeledEdit;
    edqtOfferRewardEmoteDelay3: TLabeledEdit;
    edqtOfferRewardEmoteDelay4: TLabeledEdit;
    edctKillCredit1: TLabeledEdit;
    edctKillCredit2: TLabeledEdit;
    GroupBox3: TGroupBox;
    edctquestItem1: TLabeledEdit;
    edctquestItem2: TLabeledEdit;
    edctquestItem3: TLabeledEdit;
    edctquestItem4: TLabeledEdit;
    edctmovementId: TLabeledEdit;
    editHolidayId: TLabeledEdit;
    edgtunk1: TLabeledEdit;
    edctquestItem5: TLabeledEdit;
    edctquestItem6: TLabeledEdit;
    gbGOQuestItems: TGroupBox;
    edgtquestItem1: TLabeledEdit;
    edgtquestItem2: TLabeledEdit;
    edgtquestItem3: TLabeledEdit;
    edgtquestItem4: TLabeledEdit;
    edgtquestItem5: TLabeledEdit;
    edgtquestItem6: TLabeledEdit;
    editFlagsExtra: TLabeledEdit;
    edqtRequiredItemId5: TJvComboEdit;
    edqtRequiredItemCount5: TLabeledEdit;
    edqtRequiredItemCount6: TLabeledEdit;
    edqtRequiredItemId6: TJvComboEdit;
    edSearchItemItemLevel: TLabeledEdit;
    edSearchGOdata0: TLabeledEdit;
    edSearchGOdata1: TLabeledEdit;
    tsReferenceLoot: TTabSheet;
    PageControl5: TPageControl;
    lvitReferenceLoot: TJvListView;
    ediritem: TJvComboEdit;
    Label1: TLabel;
    btReferenceLootAdd: TSpeedButton;
    btReferenceLootUpd: TSpeedButton;
    btReferenceLootDel: TSpeedButton;
    edirChanceOrQuestChance: TLabeledEdit;
    edirgroupid: TLabeledEdit;
    edirmincountOrRef: TLabeledEdit;
    edirmaxcount: TLabeledEdit;
    edirlootmode: TJvComboEdit;
    Label4: TLabel;
    btScriptReferenceLoot: TButton;
    btFullScriptReferenceLoot: TButton;
    edirentry: TJvComboEdit;
    lbirentry: TLabel;
    edPrevQuestIdSearch: TLabeledEdit;
    edNextQuestIdSearch: TLabeledEdit;
    edSearchKillCredit1: TLabeledEdit;
    edSearchKillCredit2: TLabeledEdit;
    edSearchGOdata2: TLabeledEdit;
    edctdifficulty_entry_2: TJvComboEdit;
    edctdifficulty_entry_3: TJvComboEdit;
    lbctdifficulty_entry_2: TLabel;
    lbctdifficulty_entry_3: TLabel;
    edclspawnMask: TJvComboEdit;
    lbclspawnMask: TLabel;
    edglspawnMask: TJvComboEdit;
    lbglspawnMask: TLabel;
    edctgossip_menu_id: TJvComboEdit;
    lbctgossip_menu_id: TLabel;
    edqtCompletedText: TLabeledEdit;
    edlqCompletedText: TLabeledEdit;
    edqtRewardXPId: TLabeledEdit;
    edqtRewardHonorMultiplier: TLabeledEdit;
    edqtRewardFactionValueIdOverride1: TLabeledEdit;
    edqtRewardFactionValueIdOverride2: TLabeledEdit;
    edqtRewardFactionValueIdOverride3: TLabeledEdit;
    edqtRewardFactionValueIdOverride4: TLabeledEdit;
    edqtRewardFactionValueIdOverride5: TLabeledEdit;
    editWDBVerified: TLabeledEdit;
    edctspeed_run: TLabeledEdit;
    edctVehicleId: TLabeledEdit;
    edctspell5: TJvComboEdit;
    Label5: TLabel;
    edctspell8: TJvComboEdit;
    Label6: TLabel;
    edctspell7: TJvComboEdit;
    Label7: TLabel;
    edctspell6: TJvComboEdit;
    Label8: TLabel;
    edctexp: TLabeledEdit;
    edctWDBVerified: TLabeledEdit;
    edcapath_id: TLabeledEdit;
    edcdpath_id: TLabeledEdit;
    UpDown3: TUpDown;
    edqtMaxLevel: TLabeledEdit;
    edqtRequiredFactionValue2: TLabeledEdit;
    edqtRequiredFactionId2: TJvComboEdit;
    lbqtRepObjectiveFaction2: TLabel;
    edqtWDBVerified: TLabeledEdit;
    edqtRewardArenaPoints: TLabeledEdit;
    edqtUnknown0: TLabeledEdit;
    edgtWDBVerified: TLabeledEdit;
    edcvslot: TLabeledEdit;
    tsSmartAI: TTabSheet;
    lvcySmartAI: TJvListView;
    btcyFullScript: TButton;
    edcysource_type: TJvComboEdit;
    edcyid: TJvComboEdit;
    edcylink: TJvComboEdit;
    edcyevent_type: TJvComboEdit;
    edcyevent_phase_mask: TJvComboEdit;
    edcyevent_chance: TJvComboEdit;
    edcyevent_flags: TJvComboEdit;
    edcyevent_param1: TJvComboEdit;
    edcyevent_param2: TJvComboEdit;
    edcyevent_param3: TJvComboEdit;
    edcyevent_param4: TJvComboEdit;
    edcyaction_type: TJvComboEdit;
    edcyaction_param1: TJvComboEdit;
    edcyaction_param2: TJvComboEdit;
    edcyaction_param3: TJvComboEdit;
    edcyaction_param4: TJvComboEdit;
    edcyaction_param5: TJvComboEdit;
    edcyaction_param6: TJvComboEdit;
    edcytarget_type: TJvComboEdit;
    edcytarget_param1: TJvComboEdit;
    edcytarget_param2: TJvComboEdit;
    edcytarget_param3: TJvComboEdit;
    edcytarget_x: TJvComboEdit;
    edcytarget_z: TJvComboEdit;
    edcytarget_o: TJvComboEdit;
    edcycomment: TJvComboEdit;
    btSmartAIAdd: TSpeedButton;
    btSmartAIDel: TSpeedButton;
    btSmartAIUpd: TSpeedButton;
    edcyentryorguid: TJvComboEdit;
    lbcysource_type: TLabel;
    lbcyid: TLabel;
    lbcylink: TLabel;
    lbcyevent_phase_mask: TLabel;
    lbcyevent_chance: TLabel;
    lbcyevent_flags: TLabel;
    lbcyevent_type: TLabel;
    lbcyevent_param1: TLabel;
    lbcyevent_param2: TLabel;
    lbcyevent_param3: TLabel;
    lbcyevent_param4: TLabel;
    lbcyaction_type: TLabel;
    lbcyaction_param1: TLabel;
    lbcyaction_param2: TLabel;
    lbcyaction_param3: TLabel;
    lbcyaction_param4: TLabel;
    lbcyaction_param5: TLabel;
    lbcyaction_param6: TLabel;
    lbcytarget_type: TLabel;
    lbcytarget_param1: TLabel;
    lbcytarget_param2: TLabel;
    lbcytarget_param3: TLabel;
    lbcytarget_x: TLabel;
    lbcytarget_y: TLabel;
    lbcytarget_z: TLabel;
    lbcytarget_o: TLabel;
    lbcycomment: TLabel;
    SmartAI: TTabSheet;
    PageControl9: TPageControl;
    Panel25: TPanel;
    tsCreatureSmartAI: TTabSheet;
    lbcyentryorguid: TLabel;
    tsSmartAIScript: TTabSheet;
    btCopyToClipboardSmartAI: TButton;
    btExecuteSmartAIScript: TButton;
    mecyScript: TMemo;
    mecyLog: TMemo;
    btcyLoad: TButton;
    edcytarget_y: TJvComboEdit;
    Shape1: TShape;
    Label9: TLabel;
    btctGoToSmartAI: TButton;
    lbctGoToSmartAI: TLabel;
    tsGOSmartAI: TTabSheet;
    lbgtGotoSmartAI: TLabel;
    btgtGotoSmartAI: TButton;
    edgtAIName: TLabeledEdit;
    edclnpcflag: TJvComboEdit;
    edclunit_flags: TJvComboEdit;
    edcldynamicflags: TJvComboEdit;
    lbclnpcflag: TLabel;
    lbclunit_flags: TLabel;
    lbcldynamicflags: TLabel;
    edptWDBVerified: TLabeledEdit;
    edgeworld_event: TLabeledEdit;
    Timer2: TTimer;
    edhtgender: TLabeledEdit;
    edhtlevel: TLabeledEdit;
    edhtxp: TLabeledEdit;
    edhtmoney: TLabeledEdit;
    edhtplayerBytes: TLabeledEdit;
    edhtplayerBytes2: TLabeledEdit;
    edhtplayerFlags: TLabeledEdit;
    edhtinstance_id: TLabeledEdit;
    edhtinstance_mode_mask: TLabeledEdit;
    edhtextra_flags: TLabeledEdit;
    edhtdeath_expire_time: TLabeledEdit;
    edhttaxi_path: TLabeledEdit;
    edhtarenaPoints: TLabeledEdit;
    edhttotalHonorPoints: TLabeledEdit;
    edhttodayHonorPoints: TLabeledEdit;
    edhtyesterdayHonorPoints: TLabeledEdit;
    edhttotalKills: TLabeledEdit;
    edhttodayKills: TLabeledEdit;
    edhtyesterdayKills: TLabeledEdit;
    edhtchosenTitle: TLabeledEdit;
    edhtknownCurrencies: TLabeledEdit;
    edhtwatchedFaction: TLabeledEdit;
    edhtdrunk: TLabeledEdit;
    edhthealth: TLabeledEdit;
    edhtpower1: TLabeledEdit;
    edhtpower2: TLabeledEdit;
    edhtpower3: TLabeledEdit;
    edhtpower4: TLabeledEdit;
    edhtpower5: TLabeledEdit;
    edhtpower6: TLabeledEdit;
    edhtpower7: TLabeledEdit;
    edhtlatency: TLabeledEdit;
    edhtspeccount: TLabeledEdit;
    edhtactivespec: TLabeledEdit;
    edhtexploredZones: TLabeledEdit;
    edhtequipmentCache: TLabeledEdit;
    edhtammoId: TLabeledEdit;
    edhtknownTitles: TLabeledEdit;
    edhtactionBars: TLabeledEdit;
    edhtdeleteInfos_Account: TLabeledEdit;
    edhtdeleteInfos_Name: TLabeledEdit;
    edhtdeleteDate: TLabeledEdit;
    edhttaximask: TLabeledEdit;
    cbhtis_logout_resting: TCheckBox;
    edhtgrantableLevels: TLabeledEdit;
    lbRequiredSkillId: TLabel;
    edqtRequiredClasses: TJvComboEdit;
    lbRequiredClasses: TLabel;
    lbcyOutdated: TLinkLabel;
    edgbGUID: TEdit;
    procedure FormActivate(Sender: TObject);
    procedure btSearchClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btAddQuestTakerClick(Sender: TObject);
    procedure lvQuestDblClick(Sender: TObject);
    procedure tsScriptTabShow(Sender: TObject);
    procedure btExecuteScriptClick(Sender: TObject);
    procedure btCopyToClipboardClick(Sender: TObject);
    procedure btTypeClick(Sender: TObject);
    procedure GetQuestFlags(Sender: TObject);
    procedure GetRaces(Sender: TObject);
    procedure GetSkill(Sender: TObject);
    procedure GetClasses(Sender: TObject);
    procedure btAreatriggerClick(Sender: TObject);
    procedure lvQuestChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure nExitClick(Sender: TObject);
    procedure nAboutClick(Sender: TObject);
    procedure btNewQuestClick(Sender: TObject);
    procedure btEditQuestClick(Sender: TObject);
    procedure btCheckQuestClick(Sender: TObject);
    procedure btCheckAllClick(Sender: TObject);
    procedure btQuestGiverSearchClick(Sender: TObject);
    procedure btQuestTakerSearchClick(Sender: TObject);
    procedure nSettingsClick(Sender: TObject);
    procedure btBrowseSiteClick(Sender: TObject);
    procedure btDeleteQuestClick(Sender: TObject);
    procedure edSearchChange(Sender: TObject);
    procedure btClearClick(Sender: TObject);
    procedure btClearSearchCreatureClick(Sender: TObject);
    procedure btSearchCreatureClick(Sender: TObject);
    procedure edSearchCreatureChange(Sender: TObject);
    procedure lvSearchCreatureDblClick(Sender: TObject);
    procedure lvSearchCreatureChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure btEditCreatureClick(Sender: TObject);
    procedure btDeleteCreatureClick(Sender: TObject);
    procedure btBrowseCreatureClick(Sender: TObject);
    procedure edctEntryButtonClick(Sender: TObject);
    procedure btExecuteEventAIScriptClick(Sender: TObject);
    procedure btExecuteSmartAIScriptClick(Sender: TObject);
    procedure btCopyToClipboardCreatureClick(Sender: TObject);
    procedure btCopyToClipboardSmartAIClick(Sender: TObject);
    procedure tsCreatureScriptShow(Sender: TObject);
    procedure edctnpcflagButtonClick(Sender: TObject);
    procedure edctrankButtonClick(Sender: TObject);
    procedure edctfamilyButtonClick(Sender: TObject);
    procedure btNewCreatureClick(Sender: TObject);
    procedure edcttrainer_typeButtonClick(Sender: TObject);
    procedure GetRace(Sender: TObject);
    procedure GetClass(Sender: TObject);
    procedure edcttypeButtonClick(Sender: TObject);
    procedure btScriptCreatureClick(Sender: TObject);
    procedure edgtentryButtonClick(Sender: TObject);
    procedure btBrowseGOClick(Sender: TObject);
    procedure btClearSearchGOClick(Sender: TObject);
    procedure btCopyToClipboardGOClick(Sender: TObject);
    procedure btDeleteGOClick(Sender: TObject);
    procedure btEditGOClick(Sender: TObject);
    procedure btExecuteGOScriptClick(Sender: TObject);
    procedure btNewGOClick(Sender: TObject);
    procedure btScriptGOClick(Sender: TObject);
    procedure btSearchGOClick(Sender: TObject);
    procedure edSearchGOChange(Sender: TObject);
    procedure lvSearchGOChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure lvSearchGODblClick(Sender: TObject);
    procedure tsGOScriptShow(Sender: TObject);
    procedure tsGOShow(Sender: TObject);
    procedure edgttypeButtonClick(Sender: TObject);
    procedure edgttypeChange(Sender: TObject);

    procedure GetItem(Sender: TObject);
    procedure GetCreatureOrGO(Sender: TObject);
    procedure GetFaction(Sender: TObject);
    procedure GetEmote(Sender: TObject);
    procedure GetFactionTemplate(Sender: TObject);
    procedure GetSpell(Sender: TObject);
    procedure btLoadQuest(Sender: TObject);
    procedure lvgoGOLootSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure lvglGOLocationSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure lvcoPickpocketLootSelectItem(Sender: TObject;
      Item: TListItem; Selected: Boolean);
    procedure lvcoSkinLootSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
      
    procedure lvcoCreatureLootSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure lvclCreatureLocationSelectItem(Sender: TObject;
      Item: TListItem; Selected: Boolean);
    procedure pmSiteClick(Sender: TObject);
    procedure lvcvNPCVendorSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure lvcrNPCTrainerSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure MyTrinityConnectionBeforeConnect(Sender: TObject);
    procedure btCreatureLootAddClick(Sender: TObject);
    procedure btCreatureLootUpdClick(Sender: TObject);
    procedure btCreatureLootDelClick(Sender: TObject);
    procedure btFullScriptCreatureLootClick(Sender: TObject);
    procedure btPickpocketLootAddClick(Sender: TObject);
    procedure btPickpocketLootUpdClick(Sender: TObject);
    procedure btPickpocketLootDelClick(Sender: TObject);
    procedure btFullScriptPickpocketLootClick(Sender: TObject);
    procedure btSkinLootAddClick(Sender: TObject);
    procedure btSkinLootUpdClick(Sender: TObject);
    procedure btSkinLootDelClick(Sender: TObject);
    procedure btFullScriptSkinLootClick(Sender: TObject);
    procedure btGOLootAddClick(Sender: TObject);
    procedure btGOLootUpdClick(Sender: TObject);
    procedure btGOLootDelClick(Sender: TObject);
    procedure btFullScriptGOLootClick(Sender: TObject);
    procedure btVendorAddClick(Sender: TObject);
    procedure btVendorUpdClick(Sender: TObject);
    procedure btVendorDelClick(Sender: TObject);
    procedure btFullScriptVendorClick(Sender: TObject);
    procedure lvcvNPCVendorChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure lvcoSkinLootChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure lvcoPickpocketLootChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure lvcoCreatureLootChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure lvgoGOLootChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure btTrainerAddClick(Sender: TObject);
    procedure btTrainerUpdClick(Sender: TObject);
    procedure btTrainerDelClick(Sender: TObject);
    procedure btFullScriptTrainerClick(Sender: TObject);
    procedure lvcrNPCTrainerChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure edSearchItemChange(Sender: TObject);
    procedure btClearSearchItemClick(Sender: TObject);
    procedure lvSearchItemChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure btNewItemClick(Sender: TObject);
    procedure btEditItemClick(Sender: TObject);
    procedure btDeleteItemClick(Sender: TObject);
    procedure btBrowseItemClick(Sender: TObject);
    procedure lvSearchItemDblClick(Sender: TObject);
    procedure btSearchItemClick(Sender: TObject);
    procedure btCopyToClipboardItemClick(Sender: TObject);
    procedure btExecuteItemScriptClick(Sender: TObject);
    procedure btScriptItemClick(Sender: TObject);
    procedure lvitItemLootChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure lvitItemLootSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure btScriptItemLootClick(Sender: TObject);
    procedure btItemLootAddClick(Sender: TObject);
    procedure btItemLootUpdClick(Sender: TObject);
    procedure btItemLootDelClick(Sender: TObject);
    procedure btFullScriptItemLootClick(Sender: TObject);
    procedure editentryButtonClick(Sender: TObject);
    procedure lvitDisLootChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure lvitDisLootSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure btDisLootAddClick(Sender: TObject);
    procedure btDisLootUpdClick(Sender: TObject);
    procedure btDisLootDelClick(Sender: TObject);
    procedure btFullScriptDisLootClick(Sender: TObject);
    procedure tsItemScriptShow(Sender: TObject);
    procedure editQualityButtonClick(Sender: TObject);
    procedure editInventoryTypeButtonClick(Sender: TObject);
    procedure editRequiredReputationRankButtonClick(Sender: TObject);
    procedure GetStatType(Sender: TObject);
    procedure GetDmgType(Sender: TObject);
    procedure editbondingButtonClick(Sender: TObject);
    procedure LangButtonClick(Sender: TObject);
    procedure editPageMaterialButtonClick(Sender: TObject);
    procedure editMaterialButtonClick(Sender: TObject);
    procedure editsheathButtonClick(Sender: TObject);
    procedure editBagFamilyButtonClick(Sender: TObject);
    procedure editclassButtonClick(Sender: TObject);
    procedure editsubclassButtonClick(Sender: TObject);
    procedure edititemsetButtonClick(Sender: TObject);
    procedure GetPage(Sender: TObject);
    procedure GetMap(Sender: TObject);
    procedure GetItemFlags(Sender: TObject);
    procedure nRebuildSpellListClick(Sender: TObject);
    procedure edotentryButtonClick(Sender: TObject);
    procedure btScriptFishingLootClick(Sender: TObject);
    procedure btFullScriptFishLootClick(Sender: TObject);
    procedure tsOtherScriptShow(Sender: TObject);
    procedure btCopyToClipboardOtherClick(Sender: TObject);
    procedure btExecuteOtherScriptClick(Sender: TObject);
    procedure lvotFishingLootSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure lvotFishingLootChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure btGetLootForZoneClick(Sender: TObject);
    procedure btFishingLootAddClick(Sender: TObject);
    procedure btFishingLootUpdClick(Sender: TObject);
    procedure btFishingLootDelClick(Sender: TObject);
    procedure edSearchItemSubclassButtonClick(Sender: TObject);
    procedure edqtZoneOrSortButtonClick(Sender: TObject);
    procedure edqtZoneOrSortChange(Sender: TObject);
    procedure edZoneOrSortSearchButtonClick(Sender: TObject);
    procedure btSearchPageTextClick(Sender: TObject);
    procedure lvSearchPageTextSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure btScriptPageTextClick(Sender: TObject);
    procedure LoadPageText(Sender: TObject);
    procedure btSQLOpenClick(Sender: TObject);
    procedure btScriptCreatureLocationCustomToAllClick(Sender: TObject);
    procedure btFullScriptProsLootClick(Sender: TObject);
    procedure btProsLootAddClick(Sender: TObject);
    procedure btProsLootUpdClick(Sender: TObject);
    procedure btProsLootDelClick(Sender: TObject);
    procedure lvitProsLootChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure lvitProsLootSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure lvqtStartScriptChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure lvqtEndScriptChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure lvqtStartScriptSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure lvqtEndScriptSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure btssAddClick(Sender: TObject);
    procedure btssUpdClick(Sender: TObject);
    procedure btssDelClick(Sender: TObject);
    procedure btesAddClick(Sender: TObject);
    procedure btesUpdClick(Sender: TObject);
    procedure btesDelClick(Sender: TObject);
    procedure GetCommand(Sender: TObject);
    procedure edsscommandChange(Sender: TObject);
    procedure edescommandChange(Sender: TObject);
    procedure lvitEnchantmentChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure lvitEnchantmentSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure btieEnchAddClick(Sender: TObject);
    procedure btieEnchUpdClick(Sender: TObject);
    procedure btieEnchDelClick(Sender: TObject);
    procedure btieShowFullScriptClick(Sender: TObject);
    procedure btCharSearchClick(Sender: TObject);
    procedure btCharClearClick(Sender: TObject);
    procedure CheckforUpdates1Click(Sender: TObject);
    procedure SpeedButtonClick(Sender: TObject);
    procedure tsItemLootedFromShow(Sender: TObject);
    procedure lvitItemLootedFromDblClick(Sender: TObject);
    procedure nUninstallClick(Sender: TObject);
    procedure lvQuickListMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure lvQuickListMouseLeave(Sender: TObject);
    procedure lvQuickListClick(Sender: TObject);
    procedure lvQuickListKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btSearchGameEventClick(Sender: TObject);
    procedure lvSearchGameEventSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
    procedure btGameEventAddClick(Sender: TObject);
    procedure btGameEventUpdClick(Sender: TObject);
    procedure btGameEventDelClick(Sender: TObject);
    procedure lvSearchGameEventChange(Sender: TObject; Item: TListItem; Change: TItemChange);
    procedure lvGameEventCreatureChange(Sender: TObject; Item: TListItem; Change: TItemChange);
    procedure lvGameEventGOChange(Sender: TObject; Item: TListItem; Change: TItemChange);
    procedure btgeCreatureGuidAddClick(Sender: TObject);
    procedure btgeCreatureGuidDelClick(Sender: TObject);
    procedure lvGameEventCreatureSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
    procedure lvGameEventGOSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
    procedure btgeCreatureGuidInvClick(Sender: TObject);
    procedure btgeGOGuidInvClick(Sender: TObject);
    procedure lvGameEventCreatureDblClick(Sender: TObject);
    procedure lvGameEventGODblClick(Sender: TObject);
    procedure edgeCreatureGuidButtonClick(Sender: TObject);
    procedure edgeGOguidButtonClick(Sender: TObject);
    procedure btgeGOGuidAddClick(Sender: TObject);
    procedure btgeGOguidDelClick(Sender: TObject);
    procedure btFullScriptCreatureLocationClick(Sender: TObject);
    procedure btFullScriptGOLocationClick(Sender: TObject);
    procedure lvqtGiverTemplateDblClick(Sender: TObject);
    procedure lvqtGiverTemplateSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
    procedure lvqtTakerTemplateSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
    procedure lvqtTakerTemplateDblClick(Sender: TObject);
    procedure btAddQuestGiverClick(Sender: TObject);
    procedure lvqtGiverTemplateChange(Sender: TObject; Item: TListItem; Change: TItemChange);
    procedure lvqtTakerTemplateChange(Sender: TObject; Item: TListItem; Change: TItemChange);
    procedure btDelQuestGiverClick(Sender: TObject);
    procedure btDelQuestTakerClick(Sender: TObject);
    procedure nReconnectClick(Sender: TObject);
    procedure tsCreatureUsedShow(Sender: TObject);
    procedure lvCreatureStartsEndsDblClick(Sender: TObject);
    procedure tsGOInvolvedInShow(Sender: TObject);
    procedure tsItemInvolvedInShow(Sender: TObject);
    procedure lvcoCreatureLootDblClick(Sender: TObject);
    procedure lvcmMovementChange(Sender: TObject; Item: TListItem; Change: TItemChange);
    procedure btCreatureMvmntAddClick(Sender: TObject);
    procedure btCreatureMvmntUpdClick(Sender: TObject);
    procedure btCreatureMvmntDelClick(Sender: TObject);
    procedure lvcmMovementSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
    procedure btFullCreatureMovementScriptClick(Sender: TObject);
    procedure tsCreatureEquipTemplateShow(Sender: TObject);
    procedure tsCreatureModelInfoShow(Sender: TObject);
    procedure btCreatureModelSearchClick(Sender: TObject);
    procedure lvCreatureModelSearchSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
    procedure tsCreatureOnKillReputationShow(Sender: TObject);
    procedure reaShow(Sender: TObject);
    procedure tsGOLootShow(Sender: TObject);
    procedure tsItemLootShow(Sender: TObject);
    procedure tsDisenchantLootShow(Sender: TObject);
    procedure tsProspectingLootShow(Sender: TObject);
    procedure tsEnchantmentShow(Sender: TObject);
    procedure editFoodTypeButtonClick(Sender: TObject);
    procedure tsCreatureTemplateAddonShow(Sender: TObject);
    procedure editGemPropertiesButtonClick(Sender: TObject);
    procedure editsocketBonusButtonClick(Sender: TObject);
    procedure lvgbButtonScriptChange(Sender: TObject; Item: TListItem; Change: TItemChange);
    procedure lvgbButtonScriptSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
    procedure btgbAddClick(Sender: TObject);
    procedure btgbUpdClick(Sender: TObject);
    procedure btgbDelClick(Sender: TObject);
    procedure tsButtonScriptShow(Sender: TObject);
    procedure btBrowsePopupClick(Sender: TObject);
    procedure edcvExtendedCostButtonClick(Sender: TObject);
    procedure lvSearchCharDblClick(Sender: TObject);
    procedure btShowCharacterScriptClick(Sender: TObject);
    procedure tsCharacterScriptShow(Sender: TObject);
    procedure edhtguidButtonClick(Sender: TObject);
    procedure btCopyToClipboardCharClick(Sender: TObject);
    procedure btExecuteScriptCharClick(Sender: TObject);
    procedure edhtdataButtonClick(Sender: TObject);
    procedure edhttaximaskButtonClick(Sender: TObject);
    procedure btShowFULLCharacterInventoryScriptClick(Sender: TObject);
    procedure lvCharacterInventoryChange(Sender: TObject; Item: TListItem; Change: TItemChange);
    procedure lvCharacterInventorySelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
    procedure btCharInvAddClick(Sender: TObject);
    procedure btCharInvUpdClick(Sender: TObject);
    procedure btCharInvDelClick(Sender: TObject);
    procedure GetLootCondition(Sender: TObject);
    procedure GetSpecialFlags(Sender: TObject);
    procedure GetArea(Sender: TObject);
    procedure JvHttpUrlGrabberError(Sender: TObject; ErrorMsg: string);
    procedure JvHttpUrlGrabberDoneStream(Sender: TObject; Stream: TStream; StreamSize: Integer;
      Url: string);
    procedure GetSpellTrigger(Sender: TObject);
    procedure GetUnitFlags(Sender: TObject);
    procedure GetCreatureFlag1(Sender: TObject);
    procedure GetCreatureDynamicFlags(Sender: TObject);
    procedure GetGOFlags(Sender: TObject);
    procedure GetMovementType(Sender: TObject);
    procedure GetInhabitType(Sender: TObject);
    procedure lvcnEventAISelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
    procedure lvcySmartAISelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
    procedure Button1Click(Sender: TObject);
    procedure GetEventType(Sender: TObject);
    procedure GetActionType(Sender: TObject);
    procedure GetSAIEventType(Sender: TObject);
    procedure GetSAIActionType(Sender: TObject);
    procedure GetSAISummonType(Sender: TObject);
    procedure GetSAIReactState(Sender: TObject);
    procedure GetSAISourceType(Sender: TObject);
    procedure GetSAITargetType(Sender: TObject);
    procedure GetSAIEventFlags(Sender: TObject);
    procedure GetSAICastFlags(Sender: TObject);
    procedure edcyevent_typeChange(Sender: TObject);
    procedure edcyaction_typeChange(Sender: TObject);
    procedure edcytarget_typeChange(Sender: TObject);
    procedure linkEventAIInfoClick(Sender: TObject);
    procedure GetMechanicImmuneMask(Sender: TObject);
    procedure lvSearchItemCustomDrawSubItem(Sender: TCustomListView; Item: TListItem;
      SubItem: Integer; State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure edqtRequiredSkillIdChange(Sender: TObject);
    procedure edqtRequiredSkillIdButtonClick(Sender: TObject);
    procedure edcnevent_typeChange(Sender: TObject);
    procedure edcnaction1_typeChange(Sender: TObject);
    procedure edcnaction2_typeChange(Sender: TObject);
    procedure edcnaction3_typeChange(Sender: TObject);
    procedure nEditCreatureAIClick(Sender: TObject);
    procedure btEventAIAddClick(Sender: TObject);
    procedure btEventAIUpdClick(Sender: TObject);
    procedure btSmartAIAddClick(Sender: TObject);
    procedure btSmartAIUpdClick(Sender: TObject);
    procedure lvcnEventAIChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure lvcySmartAIChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure btEventAIDelClick(Sender: TObject);
    procedure btSmartAIDelClick(Sender: TObject);
    procedure btlqShowFullLocalesScriptClick(Sender: TObject);
    procedure lvitMillingLootSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure lvitMillingLootChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure btMillingLootAddClick(Sender: TObject);
    procedure btMillingLootUpdClick(Sender: TObject);
    procedure btMillingLootDelClick(Sender: TObject);
    procedure tsMillingLootShow(Sender: TObject);
    procedure btFullScriptMillingLootClick(Sender: TObject);
    procedure edctequipment_idDblClick(Sender: TObject);
    procedure edflagsChange(Sender: TObject);
    procedure btReferenceLootAddClick(Sender: TObject);
    procedure btReferenceLootUpdClick(Sender: TObject);
    procedure btReferenceLootDelClick(Sender: TObject);
    procedure lvitReferenceLootChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure lvitReferenceLootSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure btFullScriptReferenceLootClick(Sender: TObject);
    procedure edirentryButtonClick(Sender: TObject);
    procedure GetSpawnMask(Sender: TObject);
    procedure btcyFullScriptClick(Sender: TObject);
    procedure btcyLoadClick(Sender: TObject);
    procedure btctGoToSmartAIClick(Sender: TObject);
    procedure btgtGotoSmartAIClick(Sender: TObject);
    procedure edcyevent_typeKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edcyaction_typeKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edcytarget_typeKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);

  private
    { Private declarations }
    Spells: TList;
    GlobalFlag : boolean;
    IsFirst : boolean;
    Thread: TCheckQuestThread;
    ItemColors: array [0..7] of integer;
    edit : TJvComboEdit;
    lvQuickList : TTntListView;

    procedure GetValueFromSimpleList(Sender: TObject; TextId: integer;
      Name: String; Sort: boolean);
    procedure GetValueFromSimpleList2(Sender: TObject; TextId: integer;
      Name: String; Sort: boolean; id1: string);

    procedure SearchQuest();
    procedure LoadQuest(QuestID: integer);
    procedure ChangeNamesOfComponents;
    procedure CompleteScript;
    procedure CompleteLocalesQuest;
    procedure ExecuteScript(script: string; memo: TMemo); overload;
    procedure LoadQuestGivers(QuestID: integer);
    procedure LoadQuestTakers(QuestID: integer);
    procedure LoadQuestLocales(QuestID: integer);
    procedure LoadQuestGiverInfo(objtype: string; entry: string);
    procedure LoadQuestTakerInfo(objtype: string; entry: string);
    procedure LoadQuestStartScript(id: integer);
    procedure LoadQuestCompleteScript(id: integer);
    procedure SetScriptEditFields(pfx: string; lvList: TJvListView);
    procedure ClearFields(Where: TType);
    procedure SetDefaultFields(Where: TType);
    procedure ShowSettings(n: integer);
    procedure SaveToReg;
    procedure LoadFromReg;
    procedure SetDBSpellList;

    {creatures}
    procedure SearchCreature;
   // procedure SearchCreatureEquipTemplate;
    procedure SearchCreatureModelInfo;

    procedure LoadCreature(Entry: integer);
    procedure LoadCreatureTemplateAddon(entry: integer);
    procedure LoadCreatureAddon(GUID: integer);
    procedure LoadCreatureEquip(ENTRY: integer);
    procedure LoadCreatureMovement(GUID: integer);
    procedure LoadCreatureOnKillReputation(id: string);
    procedure LoadCreatureLocation(GUID: integer);

    procedure SetCreatureModelEditFields(pfx: string; lvList: TJvListView);

    procedure CompleteCreatureScript;
    procedure CompleteCreatureLocationScript;
    procedure CompleteCreatureLootScript;
    procedure CompleteCreatureEquipTemplateScript;
    procedure CompleteCreatureModelInfoScript;
    procedure CompletePickpocketLootScript;
    procedure CompleteSkinLootScript;
    procedure CompleteNPCTrainerScript;
    procedure CompleteNPCVendorScript;
    procedure CompleteCreatureTemplateAddonScript;
    procedure CompleteCreatureEventAIScript;
    procedure CompleteCreatureAddonScript;
    procedure CompleteCreatureMovementScript;
    procedure CompleteCreatureOnKillReputationScript;

   {gameobjects}
    procedure SearchGO;
    procedure LoadGO(Entry: integer);
    procedure LoadGOLocation(GUID: integer);
    procedure LoadButtonScript(GUID: integer);
    procedure CompleteGOLocationScript;
    procedure CompleteGOLootScript;
    procedure CompleteGOScript;
    procedure CompleteButtonScriptScript;

    {items}
    procedure SearchItem;
    procedure LoadItem(Entry: integer);
    procedure CompleteItemLootScript;
    procedure CompleteDisLootScript;
    procedure CompleteProsLootScript;
    procedure CompleteMillingLootScript;
    procedure CompleteReferenceLootScript;
    procedure CompleteItemScript;
    procedure CompleteItemEnchScript;

    {chars}
    procedure LoadCharacter(GUID: integer);
    procedure LoadCharacterInventory(GUID: integer);
    procedure CompleteCharacterScript;
    procedure CompleteCharacterInventoryScript;

    {loot}
    procedure LootAdd(pfx: string; lvList: TJvListView);
    procedure LootUpd(pfx: string; lvList: TJvListView);
    procedure LootDel(lvList: TJvListView);
    procedure SetLootEditFields(pfx: string; lvList: TJvListView);
    procedure ShowFullLootScript(TableName: string; lvList: TJvListView; Memo: TMemo; entry: string);

    {movement}
    procedure MvmntAdd(pfx: string; lvList: TJvListView);
    procedure MvmntUpd(pfx: string; lvList: TJvListView);
    procedure MvmntDel(lvList: TJvListView);
    procedure SetMvmntEditFields(pfx: string; lvList: TJvListView);

    procedure ScriptAdd(pfx: string; lvList: TJvListView);
    procedure ScriptDel(lvList: TJvListView);
    procedure ScriptUpd(pfx: string; lvList: TJvListView);

    procedure EnchAdd(pfx: string; lvList: TJvListView);
    procedure EnchDel(lvList: TJvListView);
    procedure EnchUpd(pfx: string; lvList: TJvListView);

    procedure SetEnchEditFields(pfx: string; lvList: TJvListView);
    procedure ShowFullEnchScript(TableName: string;
      lvList: TJvListView; Memo: TMemo; entry: string);

    {Event AI}
    procedure SetEventAIEditFields(pfx: string; lvList: TJvListView);
    procedure EventAIAdd(pfx: string; lvList: TJvListView);
    procedure EventAIUpd(pfx: string; lvList: TJvListView);
    procedure EventAiDel(lvList: TJvListView);
    procedure ShowFullEventAiScript(TableName: string; lvList: TJvListView; Memo: TMemo; entry: string);

    {Smart AI}
    procedure ShowFullSmartAIScript(TableName: string; lvList: TJvListView; Memo: TMemo; entry: string; sourcetype: string);
    procedure SetSmartAIEditFields(pfx: string; lvList: TJvListView);
    procedure SmartAIAdd(pfx: string; lvList: TJvListView);
    procedure SmartAIUpd(pfx: string; lvList: TJvListView);
    procedure SmartAIDel(lvList: TJvListView);
    procedure LoadSmartAI(entryorguid: integer; sourcetype: integer);
    procedure ClearSmartAIFields();
    procedure SetSAIEvent(t: integer);
    procedure SetSAIAction(t: integer);
    procedure SetSAITarget(t: integer);

    {other}
    function MakeUpdate(tn: string; pfx: string; KeyName: string; KeyValue: string): string;
    function MakeUpdateLocales(tn: string; pfx: string; KeyName: string; KeyValue: string): string;
    procedure CompleteFishingLootScript;
    procedure SearchPageText;
    procedure SearchGameEvent;
    procedure CompletePageTextScript;
    procedure CompleteGameEventScript;

    procedure EditThis(objtype: string; entry: string);

    procedure SetGOdataHints(t: integer);
    procedure SetGOdataNames(t: integer);

    procedure LoadMyQueryToListView(Query: TZQuery; strQuery: string; ListView: TJvListView);
    procedure LoadQueryToListView(strQuery: string;
      ListView: TJvListView);
    procedure LoadCharQueryToListView(strQuery: string;
      ListView: TJvListView);


    procedure SetFieldsAndValues(Query: TZQuery; var Fields: string; var Values: string;
      TableName: string; pfx: string; Log: TMemo); overload;

    procedure SetFieldsAndValues(var Fields: string; var Values: string;
      TableName: string; pfx: string; Log: TMemo); overload;

    procedure FillFields(Query: TZQuery; pfx: string);


    procedure RebuildSpellList;
    procedure ChangeScriptCommand(command: integer; pfx: string);
    procedure SearchChar;

    procedure GetGuid(Sender: TObject; otype: string);

    procedure LoadCreaturesAndGOForGameEvent(entry: string);
    function FullScript(TableName, KeyName, KeyValue: string): string;
    procedure LoadCreatureInvolvedIn(Entry: string);
    procedure LoadGOInvolvedIn(Entry: string);
    procedure LoadItemInvolvedIn(Entry: string);
    function GetValueFromDBC(Name: string; id: Cardinal; idx_str: integer = 1): WideString;
    function GetZoneOrSortAcronym(ZoneOrSort: integer): string;
    function ScriptSQLScript(lvList: TJvListView; tn, id: string): string;
    procedure GetSomeFlags(Sender: TObject; What: string);
    function GetActionParamHint(ActionType, ParamNo: integer): string;

  public
    SplashForm: TAboutBox;
    SyntaxStyle : TSyntaxStyle;

    CharDBName: string;
    RealmDBName: string;

    function Connect: boolean;

    function IsNumber(S: string): boolean;
    function IsSpellInBase(id: integer): boolean;
    procedure StopThread;
    procedure LoadLoot(var lvList: TJvListView; key: string);
    function DollToSym(Text: string): string;
    function SymToDoll(Text: string): string;
    procedure EraseBackground(var Message: TWMEraseBkgnd);
       message WM_ERASEBKGND;
    procedure CheckForUpdates(flag: boolean);
    function CurVer(): integer;
    function CreateVer(Ver: integer): string;
    procedure WMFreeQL(var Message: TMessage); message WM_FREEQL;

    procedure UpdateCaption;

    function GetDBVersion: string;

    procedure QLPrepare;

    procedure EditMouseWheelUp(Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
    procedure EditMouseWheelDown(Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);

end;
   {Funcktionlib.dll}
   function LoadLocales():string; external 'Functionlib.dll';
   procedure ShowHourGlassCursor; external 'Functionlib.dll';


var
  MainForm: TMainForm;
  SAI_Event, SAI_Action, SAI_Target: Integer;

implementation

uses StrUtils, Functions, WhoUnit, ItemUnit, CreatureOrGOUnit, ListUnit, CheckUnit, SpellsUnit, SettingsUnit,
     ItemPageUnit, GUIDUnit, CharacterDataUnit, TaxiMaskFormUnit, MeConnectForm, AreaTableUnit,
     UnitFlagsUnit;

{$R *.dfm}
{$SETPEFLAGS 1}

procedure TMainForm.FormActivate(Sender: TObject);
begin
  if not MyTrinityConnection.Connected then
    Application.Terminate
  else
  begin
    if Assigned(CheckForm) and  CheckForm.Visible then
    begin
      CheckForm.Show;
      Exit;
    end;
    if (PageControl1.ActivePageIndex=0) and (PageControl2.ActivePageIndex=0) then
      edQuestID.SetFocus;
  end;
end;

procedure TMainForm.btSearchClick(Sender: TObject);
begin
  SearchQuest();
  with lvQuest do
    if Items.Count>0 then
    begin
      SetFocus;
      Selected := Items[0];
      btEditQuest.Default := true;
      btSearch.Default := false;
    end;
  StatusBar.Panels[0].Text := Format(dmMain.Text[79], [lvQuest.Items.Count]);
end;

procedure TMainForm.SearchQuest;
var
  i, PrevQuestId_, NextQuestId_: integer;
  loc, ID, QTilte, QueryStr, WhereStr, qgq, qtq, who, key, t, zoneorsort,
  QuestFlags: string;
  Field: TField;
begin
  loc:= LoadLocales();
  ShowHourGlassCursor;
  qgq := '';
  qtq := '';
  zoneorsort := '';
  if edQuestGiverSearch.Text<>'' then
  begin
    GetWhoAndKey(edQuestGiverSearch.Text, who, key);
    if who = 'creature' then
      MyTempQuery.SQL.Text := Format('SELECT `quest` FROM `creature_questrelation` WHERE (`id`=%s)',[key])
    else
    if who = 'gameobject' then
      MyTempQuery.SQL.Text := Format('SELECT `quest` FROM `gameobject_questrelation` WHERE (`id`=%s)',[key])
    else
    if who = 'item' then
      MyTempQuery.SQL.Text := Format('SELECT `startquest` FROM `item_template` WHERE (`entry`=%s)',[key]);

    if MyTempQuery.SQL.Text<>'' then
    begin
      MyTempQuery.Open;
      if MyTempQuery.Eof then Exit;
      while not MyTempQuery.Eof do
      begin
        if qgq='' then
          qgq := Format('%d',[MyTempQuery.Fields[0].AsInteger])
        else
          qgq := Format('%s,%d',[qgq, MyTempQuery.Fields[0].AsInteger]);
        MyTempQuery.Next;
      end;
      MyTempQuery.Close;
    end;
  end;

  if edQuestTakerSearch.Text<>'' then
  begin
    GetWhoAndKey(edQuestTakerSearch.Text, who, key);
    if who = 'creature' then
      MyTempQuery.SQL.Text := Format('SELECT `quest` FROM `creature_involvedrelation` WHERE (`id`=%s)',[key])
    else
    if who = 'gameobject' then
      MyTempQuery.SQL.Text := Format('SELECT `quest` FROM `gameobject_involvedrelation` WHERE (`id`=%s)',[key]);
    if MyTempQuery.SQL.Text<>'' then
    begin
      MyTempQuery.Open;
      if MyTempQuery.Eof then Exit;
      while not MyTempQuery.Eof do
      begin
        if qtq='' then
          qtq := Format('%d',[MyTempQuery.Fields[0].AsInteger])
        else
          qtq := Format('%s,%d',[qtq, MyTempQuery.Fields[0].AsInteger]);
        MyTempQuery.Next;
      end;
      MyTempQuery.Close;
    end;
  end;

  ID :=  edQuestID.Text;
  QTilte := edQuestTitle.Text;
  QTilte := StringReplace(QTilte, '''', '\''', [rfReplaceAll]);
  QTilte := StringReplace(QTilte, ' ', '%', [rfReplaceAll]);
  QTilte := '%'+QTilte+'%';
  QueryStr := '';
  WhereStr := '';
  if ID<>'' then
  begin
    if pos('-', ID)=0 then
      WhereStr := Format('WHERE (qt.`Id` in (%s))',[ID])
    else
      WhereStr := Format('WHERE (qt.`Id` >= %s) AND (qt.`Id` <= %s)',[MidStr(ID,1,pos('-',id)-1), MidStr(ID,pos('-',id)+1,length(id))]);
  end;

  if QTilte<>'%%' then
  begin
    if WhereStr<> '' then
      WhereStr := Format('%s AND ((qt.`title` LIKE ''%s'') OR (lq.title'+loc+' LIKE ''%1:s''))',[WhereStr, QTilte])
    else
      WhereStr := Format('WHERE ((qt.`title` LIKE ''%s'')OR (lq.title'+loc+' LIKE ''%0:s''))',[QTilte]);
  end;

  if qgq<>'' then
  begin
    if WhereStr<> '' then
      WhereStr := Format('%s AND (qt.`Id` IN (%s))',[WhereStr, qgq])
    else
      WhereStr := Format('WHERE (qt.`Id` IN (%s))',[qgq]);
  end;

  if qtq<>'' then
  begin
    if WhereStr<> '' then
      WhereStr := Format('%s AND (qt.`Id` IN (%s))',[WhereStr, qtq])
    else
      WhereStr := Format('WHERE (qt.`Id` IN (%s))',[qtq]);
  end;

  zoneorsort := edZoneOrSortSearch.Text;
  QuestFlags := edQuestFlagsSearch.Text;

  if zoneorsort<>'' then
  begin
    if WhereStr<> '' then
      WhereStr := Format('%s AND (qt.`zoneorsort`=%s)',[WhereStr, zoneorsort])
    else
      WhereStr := Format('WHERE (qt.`zoneorsort`=%s)',[zoneorsort]);
  end;

  if QuestFlags<>'' then
  begin
    if rbExact.Checked then
    begin
      if WhereStr<> '' then
        WhereStr := Format('%s AND (qt.`Flags`=%s)',[WhereStr, QuestFlags])
      else
        WhereStr := Format('WHERE (qt.`Flags`=%s)',[QuestFlags]);
    end
    else
    begin
      if WhereStr<> '' then
        WhereStr := Format('%s AND (qt.`Flags` & %1:s = %1:s)',[WhereStr, QuestFlags])
      else
        WhereStr := Format('WHERE (qt.`Flags` & %0:s = %0:s)',[QuestFlags]);
    end;
  end;

  PrevQuestId_ := StrToIntDef(edPrevQuestIdSearch.Text,-1);
  if PrevQuestId_<>-1 then
  begin
    if WhereStr<> '' then
      WhereStr := Format('%s AND (qt.`PrevQuestId`=%d)',[WhereStr, PrevQuestId_])
    else
      WhereStr := Format('WHERE (qt.`PrevQuestId`=%d)',[PrevQuestId_]);
  end;

  NextQuestId_ := StrToIntDef(edNextQuestIdSearch.Text,-1);
  if NextQuestId_<>-1 then
  begin
    if WhereStr<> '' then
      WhereStr := Format('%s AND (qt.`NextQuestId`=%d)',[WhereStr, NextQuestId_])
    else
      WhereStr := Format('WHERE (qt.`NextQuestId`=%d)',[NextQuestId_]);
  end;


  if Trim(WhereStr)='' then
    if MessageDlg(dmMain.Text[134], mtConfirmation, mbYesNoCancel, -1)<>mrYes then Exit;

  QueryStr := Format('SELECT * FROM quest_template qt LEFT OUTER JOIN locales_quest lq ON qt.Id=lq.entry %s',[WhereStr]);

  MyQuery.SQL.Text := QueryStr;
  lvQuest.Items.BeginUpdate;
  try
    MyQuery.Open;
    lvQuest.Clear;
    while not MyQuery.Eof do
    begin
      with lvQuest.Items.Add do
      begin
        for i := 0 to lvQuest.Columns.Count - 1 do
        begin
         Field := MyQuery.FindField(lvQuest.Columns[i].Caption);
          t := '';
          if Assigned(Field) then
          begin
            t := Field.AsString;
            if i=0 then Caption := t;
          end;
          if i<>0 then SubItems.Add(t);
        end;
        MyQuery.Next;
      end;
    end;
  finally
    lvQuest.Items.EndUpdate;
    MyQuery.Close;
  end;
end;

procedure TMainForm.FormCreate(Sender: TObject);
  procedure ApplyDBuf(form:TForm;bl:boolean);
  var
    f:integer;
  begin
    form.DoubleBuffered := bl;
    for f := 0 to form.ComponentCount-1 do
    begin
      if form.Components[f] is TWinControl then
        TWinControl(form.Components[f]).DoubleBuffered := bl
    end
  end;
var
  i: integer;
begin
  FormatSettings.DecimalSeparator := '.';
  {$IFDEF DEBUG}
    ReportMemoryLeaksOnShutdown := TRUE;
  {$ENDIF}

  if not Connect then Exit;

  IsFirst := false;

  try
    if dmMain.IsAutoUpdates then
       CheckForUpdates(false);
  except
  end;                                   

  Application.ProcessMessages;
  SetCursor(LoadCursor(0, IDC_WAIT));
  ChangeNamesOfComponents;
  LoadFromReg;
  Spells :=  TList.Create;
  SetDBSpellList;
  PageControl1.ActivePageIndex := 0;
  PageControl2.ActivePageIndex := 0;
  Application.HintPause := 300;
  Application.HintHidePause := 50000;

  tsNPCVendor.TabVisible := false;
  tsNPCTrainer.TabVisible := false;
  tsCreatureMovement.TabVisible := false; //deactivate creature_movement tab
  //tsCreatureEventAI.TabVisible := false;

  ItemColors[0] := $9D9D9D;
  ItemColors[1] := $000000;
  ItemColors[2] := $00FF1E;
  ItemColors[3] := $DD7000;
  ItemColors[4] := $EE35A3;
  ItemColors[5] := $0080ff;
  ItemColors[6] := $80CCE5;
  ItemColors[7] := $80CCE5; //heirloom color according to wowhead CSS
  {translation stuff}
  dmMain.Translate.CreateDefaultTranslation(TForm(Self));
  dmMain.Translate.TranslateForm(TForm(Self));
  UpdateCaption;
  for I := 0 to ComponentCount - 1 do
  begin
    if Components[I] is TPageControl  then
      TPageControl(Components[i]).ActivePageIndex := 0;
    if (Components[i] is TLabeledEdit) and (Pos('Count', TLabeledEdit(Components[i]).Name)>0) then
    begin
      TLabeledEdit(Components[i]).OnMouseWheelDown := EditMouseWheelDown;
      TLabeledEdit(Components[i]).OnMouseWheelUp := EditMouseWheelUp;
    end;
  end;
end;

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Spells.Free;
  MyTrinityConnection.Disconnect;
  SaveToReg;
end;

procedure TMainForm.btAddQuestGiverClick(Sender: TObject);
var
  F: TWhoQuestForm;
begin
  F := TWhoQuestForm.Create(self);
  try
    if Assigned(lvqtGiverTemplate.Selected) then F.Prepare(lvqtGiverTemplate.Selected.Caption + ',' + lvqtGiverTemplate.Selected.SubItems[0]);
    if F.ShowModal=mrOk then
    begin
      with lvqtGiverTemplate.Items.Add do
      begin
        Caption := F.rgTypeOfWho.items[F.rgTypeOfWho.itemindex];
        SubItems.Add(F.lvWho.Selected.Caption);
      end;
    end;
  finally
    F.Free;
  end;
end;

procedure TMainForm.btAddQuestTakerClick(Sender: TObject);
var
  F: TWhoQuestForm;
begin
  F := TWhoQuestForm.Create(self);
  try
    if Assigned(lvqtTakerTemplate.Selected) then F.Prepare(lvqtTakerTemplate.Selected.Caption + ',' + lvqtTakerTemplate.Selected.SubItems[0]);
    if F.ShowModal=mrOk then
    begin
      if F.rgTypeOfWho.ItemIndex=2 then // item cannot be a quest taker now
        ShowMessage(dmMain.Text[1]) else
      with lvqtTakerTemplate.Items.Add do
      begin
        Caption := F.rgTypeOfWho.items[F.rgTypeOfWho.itemindex];
        SubItems.Add(F.lvWho.Selected.Caption);
      end;
    end;
  finally
    F.Free;
  end;
end;

procedure TMainForm.LoadQuest(QuestID: integer);
begin
  ShowHourGlassCursor;
  ClearFields(ttQuest);
  // show tsQuest
  if QuestID<1 then exit;

  // load full description for quest
  MyQuery.SQL.Text := Format('SELECT * FROM `quest_template` WHERE `Id`=%d',[
    QuestID]);
  MyQuery.Open;
  try
    if MyQuery.Eof then
      raise Exception.Create(Format(dmMain.Text[2], [QuestID]));  //'Error: Quest (%d) not found'
    edqtId.Text := IntToStr(QuestID);
    FillFields(MyQuery, PFX_QUEST_TEMPLATE);
    MyQuery.Close;

    if edqtStartScript.Text<>'0' then
      LoadQuestStartScript(StrToIntDef(edqtStartScript.Text,0));
    if edqtCompleteScript.Text<>'0' then
      LoadQuestCompleteScript(StrToIntDef(edqtCompleteScript.Text,0));
    
    MyQuery.SQL.Text := Format('SELECT * FROM `areatrigger_involvedrelation` WHERE `quest`=%d', [QuestID]);
    MyQuery.Open;
    if not MyQuery.Eof then edqtAreatrigger.Text := MyQuery.FieldByName('id').AsString else
    edqtAreatrigger.Clear;
    MyQuery.Close;

    LoadQuestGivers(QuestID);
    LoadQuestTakers(QuestID);
    LoadQuestLocales(QuestID);
  except
    on E: Exception do
      raise Exception.Create(dmMain.Text[3]+#10#13+E.Message);
  end;
end;

procedure TMainForm.lvQuestDblClick(Sender: TObject);
begin
  if Assigned(lvQuest.Selected) then
  begin
    PageControl2.ActivePageIndex := 1;
    LoadQuest(StrToInt(lvQuest.Selected.Caption));
    
  end;
end;

procedure TMainForm.ChangeNamesOfComponents;
var
  i: integer;
begin
  for i := 0 to ComponentCount - 1 do
  begin
    if (Components[i] is TLabeledEdit) then
    begin
      if Pos('edco',TLabeledEdit(Components[i]).EditLabel.Caption)=1 then
        TLabeledEdit(Components[i]).EditLabel.Caption :=
          MidStr(Components[i].Name, 5, Length(Components[i].Name)-4);
      if Pos('edce',TLabeledEdit(Components[i]).EditLabel.Caption)=1 then
        TLabeledEdit(Components[i]).EditLabel.Caption := 
          MidStr(Components[i].Name, 5, Length(Components[i].Name)-4);
      if Pos('edci',TLabeledEdit(Components[i]).EditLabel.Caption)=1 then
        TLabeledEdit(Components[i]).EditLabel.Caption := 
          MidStr(Components[i].Name, 5, Length(Components[i].Name)-4);
      if Pos('edcm',TLabeledEdit(Components[i]).EditLabel.Caption)=1 then
        TLabeledEdit(Components[i]).EditLabel.Caption := 
          MidStr(Components[i].Name, 5, Length(Components[i].Name)-4);
      if Pos('edit',TLabeledEdit(Components[i]).EditLabel.Caption)=1 then
        TLabeledEdit(Components[i]).EditLabel.Caption := 
          MidStr(Components[i].Name, 5, Length(Components[i].Name)-4);
      if Pos('edid',TLabeledEdit(Components[i]).EditLabel.Caption)=1 then
        TLabeledEdit(Components[i]).EditLabel.Caption := 
          MidStr(Components[i].Name, 5, Length(Components[i].Name)-4);
      if Pos('edip',TLabeledEdit(Components[i]).EditLabel.Caption)=1 then
        TLabeledEdit(Components[i]).EditLabel.Caption := 
          MidStr(Components[i].Name, 5, Length(Components[i].Name)-4);
      if Pos('edie',TLabeledEdit(Components[i]).EditLabel.Caption)=1 then
        TLabeledEdit(Components[i]).EditLabel.Caption := 
          MidStr(Components[i].Name, 5, Length(Components[i].Name)-4);
      if Pos('edil',TLabeledEdit(Components[i]).EditLabel.Caption)=1 then
        TLabeledEdit(Components[i]).EditLabel.Caption := 
          MidStr(Components[i].Name, 5, Length(Components[i].Name)-4);
      if Pos('edcp',TLabeledEdit(Components[i]).EditLabel.Caption)=1 then
        TLabeledEdit(Components[i]).EditLabel.Caption := 
          MidStr(Components[i].Name, 5, Length(Components[i].Name)-4);
      if Pos('edcs',TLabeledEdit(Components[i]).EditLabel.Caption)=1 then
        TLabeledEdit(Components[i]).EditLabel.Caption := 
          MidStr(Components[i].Name, 5, Length(Components[i].Name)-4);
      if Pos('edct',TLabeledEdit(Components[i]).EditLabel.Caption)=1 then
        TLabeledEdit(Components[i]).EditLabel.Caption :=
          MidStr(Components[i].Name, 5, Length(Components[i].Name)-4);
      if Pos('edcl',TLabeledEdit(Components[i]).EditLabel.Caption)=1 then
        TLabeledEdit(Components[i]).EditLabel.Caption := 
          MidStr(Components[i].Name, 5, Length(Components[i].Name)-4);
      if Pos('edgo',TLabeledEdit(Components[i]).EditLabel.Caption)=1 then
        TLabeledEdit(Components[i]).EditLabel.Caption := 
          MidStr(Components[i].Name, 5, Length(Components[i].Name)-4);
      if Pos('edgt',TLabeledEdit(Components[i]).EditLabel.Caption)=1 then
        TLabeledEdit(Components[i]).EditLabel.Caption := 
          MidStr(Components[i].Name, 5, Length(Components[i].Name)-4);
      if Pos('edgl',TLabeledEdit(Components[i]).EditLabel.Caption)=1 then
        TLabeledEdit(Components[i]).EditLabel.Caption :=
          MidStr(Components[i].Name, 5, Length(Components[i].Name)-4);
      if Pos('edqt',TLabeledEdit(Components[i]).EditLabel.Caption)=1 then
        TLabeledEdit(Components[i]).EditLabel.Caption := 
          MidStr(Components[i].Name, 5, Length(Components[i].Name)-4);
      if Pos('edht',TLabeledEdit(Components[i]).EditLabel.Caption)=1 then
        TLabeledEdit(Components[i]).EditLabel.Caption := 
          MidStr(Components[i].Name, 5, Length(Components[i].Name)-4);
    end;
  end;
end;

function TMainForm.IsNumber(S: string): boolean;
var
  f: double;
begin
  Result := TryStrToFloat(s, f);
end;

procedure TMainForm.tsScriptTabShow(Sender: TObject);
begin
  CompleteScript;
end;

procedure TMainForm.UpdateCaption;
begin
  Caption := Format('Truice - Connection: %s:%d / %s', [MyTrinityConnection.HostName, MyTrinityConnection.Port, GetDBVersion]);
  Application.Title := Caption;
end;

procedure TMainForm.WMFreeQL(var Message: TMessage);
begin
  if Assigned(lvQuickList) then
  begin
    lvQuickList.OnKeyDown := nil;
    lvQuickList.OnMouseMove := nil;
    lvQuickList.OnMouseLeave := nil;
    lvQuickList.OnClick := nil;
    lvQuickList.Free;
    lvQuickList := nil;
  end;
end;

function TMainForm.ScriptSQLScript(lvList: TJvListView; tn: string; id: string ): string;
var
  i: integer;
begin
  Result := '';
  if lvList.Items.Count>0 then
  begin
    for i := 0 to lvList.Items.Count - 2 do
    begin
      Result := Result + Format('(%s, %s, %s, %s, %s, %s, %s, %s, %s, %s),'#13#10,[
        lvList.Items[i].Caption,
        lvList.Items[i].SubItems[0],
        lvList.Items[i].SubItems[1],
        lvList.Items[i].SubItems[2],
        lvList.Items[i].SubItems[3],
        QuotedStr(lvList.Items[i].SubItems[4]),
        lvList.Items[i].SubItems[5],
        lvList.Items[i].SubItems[6],
        lvList.Items[i].SubItems[7],
        lvList.Items[i].SubItems[8]
      ]);
    end;
    i := lvList.Items.Count - 1;
    Result := Result + Format('(%s, %s, %s, %s, %s, %s, %s, %s, %s, %s);',[
      lvList.Items[i].Caption,
      lvList.Items[i].SubItems[0],
      lvList.Items[i].SubItems[1],
      lvList.Items[i].SubItems[2],
      lvList.Items[i].SubItems[3],
      QuotedStr(lvList.Items[i].SubItems[4]),
      lvList.Items[i].SubItems[5],
      lvList.Items[i].SubItems[6],
      lvList.Items[i].SubItems[7],
      lvList.Items[i].SubItems[8]
    ]);
    Result := Format('DELETE FROM `%0:s` WHERE `id`=%1:s;'#13#10+
      'INSERT INTO `%0:s` (`id`, `delay`, `command`, `datalong`, `datalong2`, '+
        '`dataint`, `x`, `y`, `z`, `o`) VALUES '#13#10'%2:s'#13#10,
      [tn, id, Result]);
  end;
end;

procedure TMainForm.CompleteScript;
var
  s1, s2, s3, s4, s5, s6, Script, quest,
  Fields, Values: string;
  who, id: string;
  i: integer;
begin
  s4 := '';
  quest := edqtId.Text;
  if quest='' then exit;
  meqtLog.Clear;

  s1 := Format('DELETE FROM `creature_questrelation` WHERE `quest` = %0:s;'#13#10+
             'DELETE FROM `gameobject_questrelation` WHERE `quest` = %0:s;'#13#10+
             'UPDATE `item_template` SET `StartQuest`=0 WHERE `StartQuest` = %0:s;'#13#10,
              [quest]);
  s2 := Format('DELETE FROM `creature_involvedrelation` WHERE `quest` = %0:s;'#13#10+
             'DELETE FROM `gameobject_involvedrelation` WHERE `quest` = %0:s;'#13#10,
              [quest]);

  if lvqtGiverTemplate.Items.Count=0 then meqtLog.Lines.Add(dmMain.Text[4])   //'Error: QuestGiver is not set'
  else
    for I := 0 to lvqtGiverTemplate.Items.Count - 1 do
    begin
      who := lvqtGiverTemplate.Items[i].Caption;
      id := lvqtGiverTemplate.Items[i].SubItems[0];

      if who = 'creature' then
        s1 := Format('%0:sINSERT INTO `creature_questrelation` (`id`, `quest`) VALUES (%1:s, %2:s);'#13#10+
          'UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` = %1:s;'#13#10,
          [s1, id, quest])
      else
      if who = 'gameobject' then
        s1 := Format('%0:sINSERT INTO `gameobject_questrelation` (`id`, `quest`) VALUES (%1:s, %2:s);'#13#10,
          [s1, id, quest])
      else
      if who='item' then
        s1 := Format('%sUPDATE `item_template` SET `startquest`=%s WHERE `entry` = %s;'#13#10,
          [s1, quest, id])
    end;

  if lvqtTakerTemplate.Items.Count = 0 then
    meqtLog.Lines.Add(dmMain.Text[6]) //'Error: QuestTaker is not set'
  else
    for I := 0 to lvqtTakerTemplate.Items.Count - 1 do
    begin
      who := lvqtTakerTemplate.Items[i].Caption;
      id := lvqtTakerTemplate.Items[i].SubItems[0];

      if who = 'creature' then
        s2 := Format('%0:sINSERT INTO `creature_involvedrelation` (`id`, `quest`) VALUES (%1:s, %2:s);'#13#10+
          'UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry`=%1:s;'#13#10,
          [s2, id, quest])
      else
      if who = 'gameobject' then
        s2 := Format('%0:sINSERT INTO `gameobject_involvedrelation` (`id`, `quest`) VALUES (%1:s, %2:s);'#13#10,
          [s2, id, quest])
    end;


  s5 := ScriptSQLScript(lvqtStartScript, 'quest_start_scripts', edqtStartScript.Text);
  s6 := ScriptSQLScript(lvqtEndScript,   'quest_end_scripts',   edqtCompleteScript.Text);

  SetFieldsAndValues(Fields, Values, 'quest_template', PFX_QUEST_TEMPLATE, meqtLog);

  case SyntaxStyle of
    ssInsertDelete: s3 := Format('DELETE FROM `quest_template` WHERE `Id` = %s;'#13#10+
                      'INSERT INTO `quest_template` (%s) VALUES (%s);'#13#10,[quest, Fields, Values]);
    ssReplace: s3 := Format('REPLACE INTO `quest_template` (%s) VALUES (%s);'#13#10,[Fields, Values]);
    ssUpdate: s3 := MakeUpdate('quest_template', PFX_QUEST_TEMPLATE, 'Id', quest);
  end;

  if edqtAreatrigger.Text<>'' then
    s4 := Format('DELETE FROM `areatrigger_involvedrelation` WHERE `quest` = %1:s;'#13#10+
      'INSERT INTO `areatrigger_involvedrelation` (`id`, `quest`) VALUES (%0:s, %1:s);'#13#10,
      [edqtAreatrigger.Text, quest]);
  Script := s1+s2+s5+s6+s3+s4;
  meqtScript.Text := Script;
end;

procedure TMainForm.btExecuteScriptCharClick(Sender: TObject);
begin
  if MessageDlg(dmMain.Text[9], mtConfirmation, mbYesNoCancel, -1)=mrYes then
    ExecuteScript(mehtScript.Text, mehtLog);
end;

procedure TMainForm.btExecuteScriptClick(Sender: TObject);
begin
//  'Are you sure to execute this script?'
  if MessageDlg(dmMain.Text[9], mtConfirmation, mbYesNoCancel, -1)=mrYes then
    ExecuteScript(meqtScript.Text, meqtLog);
end;

procedure TMainForm.btCopyToClipboardCharClick(Sender: TObject);
begin
  mehtScript.SelectAll;
  mehtScript.CopyToClipboard;
  mehtScript.SelStart := 0;
  mehtScript.SelLength := 0;
end;

procedure TMainForm.btCopyToClipboardClick(Sender: TObject);
begin
  meqtScript.SelectAll;
  meqtScript.CopyToClipboard;
  meqtScript.SelStart := 0;
  meqtScript.SelLength := 0;
end;

procedure TMainForm.btLoadQuest(Sender: TObject);
var
  KeyboardState: TKeyboardState;
  qid: integer;
begin
  qid := abs(StrToIntDef(TJvComboEdit(Sender).Text,0));
  if qid = 0 then Exit;
  GetKeyboardState(KeyboardState);
  if ssShift in KeyboardStateToShiftState(KeyboardState) then
    dmMain.BrowseSite(ttQuest, qid)
  else
    LoadQuest(qid);
end;

procedure TMainForm.btlqShowFullLocalesScriptClick(Sender: TObject);
begin
PageControl2.ActivePageIndex := SCRIPT_TAB_NO_QUEST;
meqtScript.Clear;
//SetFieldsAndValues(MyQuery,Fields, Values, 'locales_quest', PFX_LOCALES_QUEST, meqtLog);
//meqtScript.Lines.Add(MakeUpdate('locales_quest', PFX_LOCALES_QUEST, 'entry', edqtEntry.Text));
CompleteLocalesQuest;
end;

procedure TMainForm.btMillingLootAddClick(Sender: TObject);
begin
LootAdd('edim', lvitMillingLoot);
end;

procedure TMainForm.btMillingLootDelClick(Sender: TObject);
begin
LootDel(lvitMillingLoot);
end;

procedure TMainForm.btMillingLootUpdClick(Sender: TObject);
begin
LootUpd('edim', lvitMillingLoot);
end;

procedure TMainForm.GetItem(Sender: TObject);
var
  edEdit: TJvComboEdit;
  F: TItemForm;
begin
  if Sender is TJvComboEdit then
  begin
    edEdit := TJvComboEdit(Sender);
    F := TItemForm.Create(Self);
    try
      if (edEdit.Text<>'') and (edEdit.Text<>'0') then F.Prepare(edEdit.Text);
      if F.ShowModal=mrOk then edEdit.Text := F.lvItem.Selected.Caption;
    finally
      F.Free;
    end;
  end;
end;

procedure TMainForm.GetCreatureOrGO(Sender: TObject);
var
  edEdit: TJvComboEdit;
  F: TCreatureOrGOForm;
begin
  if Sender is TJvComboEdit then
  begin
    edEdit := TJvComboEdit(Sender);
    F := TCreatureOrGOForm.Create(Self);
    try
      if (edEdit.Text<>'') and (edEdit.Text<>'0') then F.Prepare(edEdit.Text);
      if F.ShowModal=mrOk then edEdit.Text := F.lvCreatureOrGO.Selected.Caption;
    finally
      F.Free;
    end;
  end;
end;

procedure TMainForm.GetSpecialFlags(Sender: TObject);
begin
  GetSomeFlags(Sender, 'SpecialFlags');
end;

procedure TMainForm.edqtRequiredSkillIdButtonClick(Sender: TObject);
begin
  {if rbqtSkill.Checked then
    GetSkill(Sender)
  else
    GetValueFromSimpleList(Sender, 143, 'ChrClasses', false);
  }
end;

procedure TMainForm.edqtRequiredSkillIdChange(Sender: TObject);
begin
  {
  if StrToIntDef(edqtSkillOrClassMask.Text,0)>=0 then rbqtSkill.Checked := true else
  rbqtClass.Checked := true;
  }
end;

procedure TMainForm.edqtZoneOrSortButtonClick(Sender: TObject);
begin
  if rbqtZoneID.Checked then
    GetArea(Sender)
  else
    GetValueFromSimpleList(Sender, 11, 'QuestSort', false);
end;

procedure TMainForm.btTypeClick(Sender: TObject);
begin
  GetValueFromSimpleList(Sender, 13, 'QuestInfo', false);
end;

procedure TMainForm.GetFaction(Sender: TObject);
begin
  GetValueFromSimpleList(Sender, 14, 'Faction', true);
end;

procedure TMainForm.GetEmote(Sender: TObject);
begin
  GetValueFromSimpleList(Sender, 147, 'Emotes', false);
end;

procedure TMainForm.GetFactionTemplate(Sender: TObject);
begin
  GetValueFromSimpleList(Sender, 15, 'FactionTemplate', true);
end;

procedure TMainForm.GetGuid(Sender: TObject; otype: string);
var
  edEdit: TJvComboEdit;
  F: TGUIDForm;
begin
  if Sender is TJvComboEdit then
  begin
    edEdit := TJvComboEdit(Sender);
    F := TGUIDForm.CreateEx(Self, otype);
    try
      if (edEdit.Text<>'') and (edEdit.Text<>'0') then F.Prepare(edEdit.Text);
      if F.ShowModal=mrOk then edEdit.Text := F.GUID;
    finally
      F.Free;
    end;
  end;
end;

procedure TMainForm.GetSkill(Sender: TObject);
begin
  GetValueFromSimpleList(Sender, 16, 'SkillLine', true);
end;

procedure TMainForm.GetSpell(Sender: TObject);
begin
  if not (Sender is TJvComboEdit) then Exit;
  SpellsForm.Prepare(TJvComboEdit(Sender).Text);
  if SpellsForm.ShowModal=mrOk then
    TJvComboEdit(Sender).Text := SpellsForm.lvList.Selected.Caption;
end;

procedure TMainForm.GetRaces(Sender: TObject);
begin
  GetSomeFlags(Sender, 'Races');
end;

procedure TMainForm.GetClasses(Sender: TObject);
begin
  GetSomeFlags(Sender, 'Classes');
end;

procedure TMainForm.GetQuestFlags(Sender: TObject);
begin
  GetSomeFlags(Sender, 'QuestFlags');
end;

procedure TMainForm.LoadQuestGiverInfo(objtype: string; entry: string);
var
  SQLText: string;
begin
  if objtype = 'creature' then
  begin
    SQLText := Format('SELECT `guid`, `id`, `map`, `position_x`,`position_y`,`position_z`,`orientation`,''creature'' as `table` FROM `creature` WHERE (`id`=%s)',[entry]);
    lbLocationOrLoot.Caption := dmMain.Text[17]; //'Creature location'
  end
  else
  if objtype = 'gameobject' then
  begin
    SQLText := Format('SELECT `guid`, `id`, `map`, `position_x`,`position_y`,`position_z`,`orientation`,''gameobject'' as `table` FROM `gameobject` WHERE (`id`=%s)',[entry]);
    lbLocationOrLoot.Caption := dmMain.Text[18]; //'Gameobject location'
  end
  else
  if objtype = 'item' then
  begin
    SQLText := '';
    lbLocationOrLoot.Caption := dmMain.Text[19]; //'Item Loot'
  end
  else
  begin
    lvqtGiverLocation.Clear;
    Exit;
  end;

  lvqtGiverLocation.Items.Clear();
  if SQLText='' then
    LoadLoot(lvqtGiverLocation, entry)
  else
    LoadQueryToListView(SQLText, lvqtGiverLocation);
end;

procedure TMainForm.LoadQuestLocales(QuestID: integer);
var
loc: string;
begin
  loc:= LoadLocales();
  MyQuery.SQL.Text := Format('SELECT Title'+loc+', Details'+loc+', Objectives'+loc+', OfferRewardText'+loc+', RequestItemsText'+loc+', EndText'+loc+', CompletedText'+loc+', ObjectiveText1'+loc+', ObjectiveText2'+loc+', ObjectiveText3'+loc+', ObjectiveText4'+loc+' FROM locales_quest WHERE entry=%d', [QuestID]);
  MyQuery.Open;
  edlqTitle.EditLabel.Caption:= 'Title'+loc;
  l2Detail.Caption:= 'Detail'+loc;
  l2Objectives.Caption:= 'Objectives'+loc;
  l2EndText.Caption:= 'EndText'+loc;
  edlqCompletedText.EditLabel.Caption:= 'CompletedText'+loc;
  l2OfferRewardText.Caption:= 'OfferRewardText'+loc;
  l2RequestItemsText.Caption:= 'RequestItemsText'+loc;
  edlqObjectiveText1.EditLabel.Caption:= 'ObjectiveText1'+loc;
  edlqObjectiveText2.EditLabel.Caption:= 'ObjectiveText2'+loc;
  edlqObjectiveText3.EditLabel.Caption:= 'ObjectiveText3'+loc;
  edlqObjectiveText4.EditLabel.Caption:= 'ObjectiveText4'+loc;


  while not MyQuery.Eof do
  begin
    edlqTitle.Text:=MyQuery.Fields[0].AsString;
    edlqDetail.Text:=MyQuery.Fields[1].AsString;
    edlqObjectives.Text:=MyQuery.Fields[2].AsString;
    edlqOfferRewardText.Text:=MyQuery.Fields[3].AsString;
    edlqRequestItemText.Text:=MyQuery.Fields[4].AsString;
    edlqEndText.Text:=MyQuery.Fields[5].AsString;
    edlqCompletedText.Text:=MyQuery.Fields[6].AsString;
    edlqObjectiveText1.Text:=MyQuery.Fields[7].AsString;
    edlqObjectiveText2.Text:=MyQuery.Fields[8].AsString;
    edlqObjectiveText3.Text:=MyQuery.Fields[9].AsString;
    edlqObjectiveText4.Text:=MyQuery.Fields[10].AsString;
    MyQuery.Next;
  end;
  MyQuery.Close;
end;

procedure TMainForm.LoadQuestGivers(QuestID: integer);
begin
  // search for quest starter
   MyQuery.SQL.Text := Format('SELECT t.entry, t.name, t.npcflag FROM `creature_questrelation` q ' +
                           'INNER JOIN `creature_template` t ON t.entry = q.id '+
                           'WHERE q.quest = %d', [QuestID]);
  MyQuery.Open;
  while not MyQuery.Eof do
  begin
    with lvqtGiverTemplate.Items.Add do
    begin
      Caption := 'creature';
      lvqtGiverTemplate.Columns[1].Caption := 'entry';
      SubItems.Add(MyQuery.Fields[0].AsString);
      lvqtGiverTemplate.Columns[2].Caption := 'name';
      SubItems.Add(MyQuery.Fields[1].AsString);
      lvqtGiverTemplate.Columns[3].Caption := 'npcflag';
      SubItems.Add(MyQuery.Fields[2].AsString);
    end;
    MyQuery.Next;
  end;
  MyQuery.Close;

  MyQuery.SQL.Text := Format('SELECT t.entry, t.name, t.`type` FROM `gameobject_questrelation` q ' +
                           'INNER JOIN `gameobject_template` t ON t.entry = q.id '+
                           'WHERE q.quest = %d', [QuestID]);
  MyQuery.Open;
  while not MyQuery.Eof do
  begin
    with lvqtGiverTemplate.Items.Add do
    begin
      Caption := 'gameobject';
      lvqtGiverTemplate.Columns[1].Caption := 'entry';
      SubItems.Add(MyQuery.Fields[0].AsString);
      lvqtGiverTemplate.Columns[2].Caption := 'name';
      SubItems.Add(MyQuery.Fields[1].AsString);
      lvqtGiverTemplate.Columns[3].Caption := 'GO type';
      SubItems.Add(MyQuery.Fields[2].AsString);
    end;
    MyQuery.Next;
  end;
  MyQuery.Close;

  MyQuery.SQL.Text := Format('SELECT entry, name, description FROM `item_template` ' +
                           'WHERE startquest = %d', [QuestID]);
  MyQuery.Open;
  while not MyQuery.Eof do
  begin
    with lvqtGiverTemplate.Items.Add do
    begin
      Caption := 'item';
      lvqtGiverTemplate.Columns[1].Caption := 'entry';
      SubItems.Add(MyQuery.Fields[0].AsString);
      lvqtGiverTemplate.Columns[2].Caption := 'name';
      SubItems.Add(MyQuery.Fields[1].AsString);
      lvqtGiverTemplate.Columns[3].Caption := 'description';
      SubItems.Add(MyQuery.Fields[2].AsString);
    end;
    MyQuery.Next;
  end;
  MyQuery.Close;

end;

procedure TMainForm.LoadQuestTakerInfo(objtype: string; entry: string);
var
  SQLText: string;
begin
  if objtype = 'creature' then
    SQLText := Format('SELECT `guid`, `id`, `map`, `position_x`,`position_y`,`position_z`,`orientation`,''creature'' as `table` FROM `creature` WHERE (`id`=%s)',[entry])
  else
  if objtype = 'gameobject' then
    SQLText := Format('SELECT `guid`, `id`, `map`, `position_x`,`position_y`,`position_z`,`orientation`,''gameobject'' as `table` FROM `gameobject` WHERE (`id`=%s)',[entry])
  else
  begin
    lvqtTakerLocation.Clear;
    Exit;
  end;
  LoadQueryToListView(SQLText, lvqtTakerLocation);
end;

procedure TMainForm.LoadQuestTakers(QuestID: integer);
begin
  // search for quest starter
  MyQuery.SQL.Text := Format('SELECT t.entry, t.name, t.npcflag FROM `creature_involvedrelation` q ' +
                           'INNER JOIN `creature_template` t ON t.entry = q.id '+
                           'WHERE q.quest = %d', [QuestID]);
  MyQuery.Open;
  while not MyQuery.Eof do
  begin
    with lvqtTakerTemplate.Items.Add do
    begin
      Caption := 'creature';
      lvqtTakerTemplate.Columns[1].Caption := 'entry';
      SubItems.Add(MyQuery.Fields[0].AsString);
      lvqtTakerTemplate.Columns[2].Caption := 'name';
      SubItems.Add(MyQuery.Fields[1].AsString);
      lvqtTakerTemplate.Columns[3].Caption := 'npcflag';
      SubItems.Add(MyQuery.Fields[2].AsString);
    end;
    MyQuery.Next;
  end;
  MyQuery.Close;

  MyQuery.SQL.Text := Format('SELECT t.entry, t.name, t.`type` FROM `gameobject_involvedrelation` q ' +
                           'INNER JOIN `gameobject_template` t ON t.entry = q.id '+
                           'WHERE q.quest = %d', [QuestID]);
  MyQuery.Open;
  while not MyQuery.Eof do
  begin
    with lvqtTakerTemplate.Items.Add do
    begin
      Caption := 'gameobject';
      lvqtTakerTemplate.Columns[1].Caption := 'entry';
      SubItems.Add(MyQuery.Fields[0].AsString);
      lvqtTakerTemplate.Columns[2].Caption := 'name';
      SubItems.Add(MyQuery.Fields[1].AsString);
      lvqtTakerTemplate.Columns[3].Caption := 'GO type';
      SubItems.Add(MyQuery.Fields[2].AsString);
    end;
    MyQuery.Next;
  end;
  MyQuery.Close;
end;

procedure TMainForm.btAreatriggerClick(Sender: TObject);
begin
  GetValueFromSimpleList(sender, 155, 'AreaTrigger', false);
end;

procedure TMainForm.lvQuestChange(Sender: TObject; Item: TListItem;
  Change: TItemChange);
var
  flag: boolean;
begin
  flag := Assigned(lvQuest.Selected);
  if flag then
    lvQuest.PopupMenu := pmQuest
  else
    lvQuest.PopupMenu := nil;
  btEditQuest.Enabled := flag;
  btDeleteQuest.Enabled := flag;
  btCheckQuest.Enabled := flag;
  btBrowseSite.Enabled := flag;
  btBrowseQuestPopup.Enabled := flag;
  btCheckAll.Enabled := flag;
end;

procedure TMainForm.nEditCreatureAIClick(Sender: TObject);
begin
  PageControl3.ActivePageIndex := 1;
  if Assigned(lvSearchCreature.Selected) then
    LoadCreature(StrToInt(lvSearchCreature.Selected.Caption));
end;

procedure TMainForm.nExitClick(Sender: TObject);
begin
  Close;
end;

procedure TMainForm.nAboutClick(Sender: TObject);
var
  F: TAboutBox;
begin
  F := TAboutBox.MyCreate(Self);
  try
    F.dbversion := GetDBVersion;
    F.ShowModal;
  finally
    F.Free;
  end;
end;

procedure TMainForm.btNewQuestClick(Sender: TObject);
begin
  lvQuest.Selected := nil;
  ClearFields(ttQuest);
  SetDefaultFields(ttQuest);
  PageControl2.ActivePageIndex := 1;
end;

procedure TMainForm.btEditQuestClick(Sender: TObject);
begin
  PageControl2.ActivePageIndex := 1;
  if Assigned(lvQuest.Selected) then
    LoadQuest(StrToInt(lvQuest.Selected.Caption));
end;

procedure TMainForm.btCheckQuestClick(Sender: TObject);
var
  id: integer;
  qList: TList;
begin
  CheckForm.Memo.Clear;
  CheckForm.btStop.Visible := true;
  if not Assigned(lvQuest.Selected) then
  begin
    ShowMessage(dmMain.Text[20]); //'Nothing to check.'
    Exit;
  end;
  qList  := TList.Create;
  id := StrToIntDef(lvQuest.Selected.Caption,0);
  qList.Add(pointer(id));
  CheckForm.Show;
  CheckForm.pbCheckQuest.Position := 0;
  CheckForm.btStop.SetFocus;
  Thread := TCheckQuestThread.Create(MyTrinityConnection, qList, false);
end;

procedure TMainForm.btCheckAllClick(Sender: TObject);
var
  i: integer;
  qList: TList;
begin
  CheckForm.Memo.Clear;
  CheckForm.btStop.Visible := true;
  if lvQuest.Items.Count=0 then
  begin
    ShowMessage(dmMain.Text[21]); //'List of found quests is empty. Nothing to check.'
    Exit;
  end;
  qList  := TList.Create;
  for i := 0 to lvQuest.Items.Count - 1 do
    qList.Add(pointer(StrToInt(lvQuest.Items[i].Caption)));

  CheckForm.Show;
  CheckForm.pbCheckQuest.Position := 0;  
  CheckForm.btStop.SetFocus;

  Thread := TCheckQuestThread.Create(MyTrinityConnection, qList, false);
end;

procedure TMainForm.ClearFields(Where: TType);
var
  i: integer;
  s: string;
begin
  s := '';
  case Where of
    ttQuest:    s := 'q';
    ttNPC:      s := 'c';
    ttObject:   s := 'g';
    ttItem:     s := 'i';
    ttChar:     s := 'h';
  end;
  for i := 0 to ComponentCount - 1 do
  begin
    if s<>'' then
    begin
        if ((Components[i] is TLabeledEdit) or (Components[i] is TJvComboEdit) or (Components[i] is TMemo)) and
           ((Pos('ed'+s+'t',Components[i].Name)=1) or (Pos('ed'+s+'l',Components[i].Name)=1) or (Pos('ed'+s+'o',Components[i].Name)=1) or
            (Pos('me'+s+'t',Components[i].Name)=1) or (Pos('me'+s+'l',Components[i].Name)=1) or (Pos('me'+s+'o',Components[i].Name)=1)) then
           TCustomEdit(Components[i]).Clear;
        if (Components[i] is TJvListView) and ((Pos('lv'+s+'o',Components[i].Name)=1) or (Pos('lv'+s+'l',Components[i].Name)=1) or (Pos('lv'+s+'t',Components[i].Name)=1)) then
          TCustomListView(Components[i]).Clear;
    end;
    // additionaly crear npcvendor and npctrainer fields
    if s='c' then
    begin
        if ((Components[i] is TLabeledEdit) or (Components[i] is TJvComboEdit) or (Components[i] is TMemo)) and
           ((Pos('ed'+s+'v',Components[i].Name)=1) or (Pos('ed'+s+'p',Components[i].Name)=1) or (Pos('ed'+s+'a',Components[i].Name)=1)  or
           (Pos('ed'+s+'g',Components[i].Name)=1)  or (Pos('ed'+s+'x',Components[i].Name)=1)  or (Pos('ed'+s+'m',Components[i].Name)=1)  or
           (Pos('ed'+s+'s',Components[i].Name)=1) or (Pos('ed'+s+'r',Components[i].Name)=1) or (Pos('ed'+s+'i',Components[i].Name)=1) or
           (Pos('ed'+s+'e',Components[i].Name)=1) or (Pos('ed'+s+'n',Components[i].Name)=1)) then
             TCustomEdit(Components[i]).Clear;
        if (Components[i] is TJvListView) and ((Pos('lv'+s+'v',Components[i].Name)=1) or (Pos('lv'+s+'r',Components[i].Name)=1) or (Pos('lv'+s+'n',Components[i].Name)=1) or (Pos('lv'+s+'m',Components[i].Name)=1)) then
          TCustomListView(Components[i]).Clear;
    end;
    if s='i' then
    begin
        if ((Components[i] is TLabeledEdit) or (Components[i] is TJvComboEdit) or (Components[i] is TMemo)) and
           ((Pos('ed'+s+'l',Components[i].Name)=1) or (Pos('ed'+s+'d',Components[i].Name)=1)
             or (Pos('ed'+s+'p',Components[i].Name)=1)) or (Pos('ed'+s+'e',Components[i].Name)=1) then
             TCustomEdit(Components[i]).Clear;
        if (Components[i] is TJvListView) and ((Pos('lv'+s+'o',Components[i].Name)=1) or (Pos('lv'+s+'l',Components[i].Name)=1) or (Pos('lv'+s+'t',Components[i].Name)=1)) then
          TCustomListView(Components[i]).Clear;
    end;
    if s='h' then
    begin
        if ((Components[i] is TLabeledEdit) or (Components[i] is TJvComboEdit) or (Components[i] is TMemo)) and
           ((Pos('ed'+s+'t',Components[i].Name)=1) or (Pos('ed'+s+'d',Components[i].Name)=1)
             or (Pos('ed'+s+'p',Components[i].Name)=1)) or (Pos('ed'+s+'e',Components[i].Name)=1) then
             TCustomEdit(Components[i]).Clear;
        if (Components[i] is TJvListView) and ((Pos('lv'+s+'o',Components[i].Name)=1) or (Pos('lv'+s+'l',Components[i].Name)=1) or (Pos('lv'+s+'t',Components[i].Name)=1)) then
          TCustomListView(Components[i]).Clear;
    end;
  end;
end;

procedure TMainForm.ClearSmartAIFields();
var
  i: integer;
  s: string;
begin
  s := 'cy';
  for i := 0 to ComponentCount - 1 do
  begin
    if s<>'' then
    begin
        if (((Components[i] is TLabeledEdit) or (Components[i] is TJvComboEdit) or (Components[i] is TMemo)) and
           ((Pos('ed'+s,Components[i].Name)=1) or (Pos('me'+s,Components[i].Name)=1))) and (Pos('ed'+s+'entryorguid',Components[i].Name)<>1) and (Pos('ed'+s+'source_type',Components[i].Name)<>1) then
           TCustomEdit(Components[i]).Clear;
        if (Components[i] is TJvListView) and ((Pos('lv'+s,Components[i].Name)=1)) then
          TCustomListView(Components[i]).Clear;
    end;
  end;
end;

procedure TMainForm.SetDefaultFields(Where: TType);
var
  i: integer;
  s, tn: string;
  Ctrl : TComponent;
begin
  s := '';
  tn := '';
  case Where of
    ttQuest:
    begin
      s := 'edqt';
      tn := 'quest_template';
    end;

    ttNPC:
    begin
      s := 'edct';
      tn := 'creature_template';
    end;

    ttObject:
    begin
      s := 'edgt';
      tn := 'gameobject_template';
    end;

    ttItem:
    begin
      s := 'edit';
      tn := 'item_template';
    end;
  end;
  if tn<>'' then
  begin
    MyQuery.SQL.Text := 'replace into '+tn+' (entry) values (987654)';
    MyQuery.ExecSQL;
    try
      MyQuery.SQL.Text := 'select * from '+tn+' where entry = 987654';
      MyQuery.Open;
      for I := 0 to MyQuery.FieldCount - 1 do
      begin
        Ctrl := FindComponent(s+MyQuery.Fields[i].FieldName);
        if Assigned(Ctrl) and (Ctrl is TCustomEdit) then
            TCustomEdit(Ctrl).Text := MyQuery.Fields[i].AsString;
      end;
      MyQuery.Close;
    finally
      MyQuery.SQL.Text := 'delete from '+tn+' where entry = 987654';
      MyQuery.ExecSQL;
    end;
  end;
end;

procedure TMainForm.btQuestGiverSearchClick(Sender: TObject);
var
  F: TWhoQuestForm;
begin
  F := TWhoQuestForm.Create(self);
  try
    if edQuestGiverSearch.Text<>'' then F.Prepare(edQuestGiverSearch.Text);
    if F.ShowModal=mrOk then
      edQuestGiverSearch.Text := Format('%s,%s',[F.rgTypeOfWho.items[F.rgTypeOfWho.itemindex],F.lvWho.Selected.Caption]);
  finally
    F.Free;
  end;
end;

procedure TMainForm.btQuestTakerSearchClick(Sender: TObject);
var
  F: TWhoQuestForm;
begin
  F := TWhoQuestForm.Create(self);
  try
    if edQuestTakerSearch.Text<>'' then F.Prepare(edQuestTakerSearch.Text);
    if F.ShowModal=mrOk then
    begin
      if F.rgTypeOfWho.ItemIndex=2 then // item cannot be a quest taker now
        ShowMessage(dmMain.Text[1]) else
      edQuestTakerSearch.Text := Format('%s,%s',[F.rgTypeOfWho.items[F.rgTypeOfWho.itemindex],F.lvWho.Selected.Caption]);
    end;
  finally
    F.Free;
  end;
end;

procedure TMainForm.btReferenceLootAddClick(Sender: TObject);
begin
LootAdd('edir', lvitReferenceLoot);
end;

procedure TMainForm.btReferenceLootDelClick(Sender: TObject);
begin
LootDel(lvitReferenceLoot);
end;

procedure TMainForm.btReferenceLootUpdClick(Sender: TObject);
begin
LootUpd('edir', lvitReferenceLoot);
end;

procedure TMainForm.nSettingsClick(Sender: TObject);
begin
  ShowSettings(TMenuItem(Sender).Tag - 1);
  UpdateCaption;
end;

procedure TMainForm.ShowSettings(n: integer);
var
  F: TSettingsForm;
  i: integer;
begin
  F := TSettingsForm.Create(Self);
  try
    F.pcSettings.ActivePageIndex := n;
    if F.ShowModal=mrOK then
    begin
      lvQuest.Columns.Clear;
      for i := 0 to F.lvColumns.Items.Count - 1 do
      begin
        with lvQuest.Columns.Add do
        begin
          Caption := F.lvColumns.Items[i].Caption;
          Width := StrToInt(F.lvColumns.Items[i].Subitems[0]);
        end;
      end;
      lvQuest.Clear;
      SaveToReg;
      dmMain.Translate.LoadTranslations(dmMain.LanguageFile);
      dmMain.Translate.TranslateForm(TForm(Self));
    end;
  finally
    F.Free;
  end;
end;

procedure TMainForm.SpeedButtonClick(Sender: TObject);
var
  p: tPoint;
begin
  p := TSpeedButton(Sender).ClientToScreen(Point(TSpeedButton(Sender).Width, 0));
  TSpeedButton(Sender).PopupMenu.Popup(p.x, p.y);
end;

procedure TMainForm.SaveToReg;
var
  i: integer;
begin
  with TRegistry.Create do
  try
     RootKey := HKEY_CURRENT_USER;
     OpenKey('SOFTWARE\' + Trim(ProgramName), true);
     WriteString('Language', dmMain.Language);
     WriteString('DBCDir', dmMain.DBCDir);
     WriteInteger('DBCLocale', dmMain.DBCLocale);
     WriteInteger('Locales', dmMain.Locales);
     case SyntaxStyle of
       ssInsertDelete: WriteInteger('SQLSyntaxStyle', 1);
       ssReplace: WriteInteger('SQLSyntaxStyle', 0);
       ssUpdate: WriteInteger('SQLSyntaxStyle', 2);
     end;

     OpenKey('QuestList', true);
     WriteInteger('ColumnCount', lvQuest.Columns.Count);
     for i := 0 to lvQuest.Columns.Count - 1 do
     begin
       WriteString(Format('N%d',[i]),lvQuest.Columns[i].Caption);
       WriteInteger(Format('W%d',[i]),lvQuest.Columns[i].Width);
     end;
     case dmMain.Site of
       sW: WriteInteger('Site', 0);
       sRW: WriteInteger('Site', 1);
       sT: WriteInteger('Site', 2);
       sA: WriteInteger('Site', 3);
     end;
  finally
    Free;
  end;
end;

procedure TMainForm.LoadFromReg;
var
  i, c: integer;
begin
  case ReadFromRegistry(Functions.TRootKey.CurrentUser, '', 'SQLSyntaxStyle', Functions.TParameter.tpInteger, 0) of
    0: SyntaxStyle := ssReplace;
    1: SyntaxStyle := ssInsertDelete;
    2: SyntaxStyle := ssUpdate;
  end;

  dmMain.Locales := ReadFromRegistry(Functions.TRootKey.CurrentUser, '', 'Locales', Functions.TParameter.tpInteger, 0);

  c := ReadFromRegistry(Functions.TRootKey.CurrentUser, 'QuestList', 'ColumnCount', Functions.TParameter.tpInteger, 0);
  if c > 0 then
  begin
    lvQuest.Columns.Clear;
    for i := 0 to c - 1 do
    begin
      with lvQuest.Columns.Add do
      begin
        Caption := ReadFromRegistry(Functions.TRootKey.CurrentUser, 'QuestList', Format('N%d', [i]), Functions.TParameter.tpString, 'Error');
        if LowerCase(Caption) = 'entry' then Caption := 'Id';

        Width := ReadFromRegistry(Functions.TRootKey.CurrentUser, 'QuestList', Format('W%d', [i]), Functions.TParameter.tpInteger, 40);
      end;
    end;

    case ReadFromRegistry(Functions.TRootKey.CurrentUser, 'QuestList', 'Site', Functions.TParameter.tpInteger, 0) of
      0: dmMain.Site := sW;
      1: dmMain.Site := sRW;
      2: dmMain.Site := sT;
      3: dmMain.Site := sA;
    end;
  end;
end;

procedure TMainForm.SetCreatureModelEditFields(pfx: string; lvList: TJvListView);
begin
  if Assigned(lvList.Selected) then
  begin
    with lvList.Selected do
    begin
      TCustomEdit(FindComponent(pfx + 'modelid')).Text := Caption;
      TCustomEdit(FindComponent(pfx + 'bounding_radius')).Text := SubItems[0];
      TCustomEdit(FindComponent(pfx + 'combat_reach')).Text := SubItems[1];
      TCustomEdit(FindComponent(pfx + 'gender')).Text := SubItems[2];
      TCustomEdit(FindComponent(pfx + 'modelid_other_gender')).Text := SubItems[3];
    end;
  end;
end;

procedure TMainForm.SetDBSpellList;
var
  list: TStringList;
  i: integer;
  UseSpellFileName: string;
begin
  ShowHourGlassCursor;
  UseSpellFileName := dmMain.ProgramDir+'CSV\useSpells.csv';
  if FileExists(UseSpellFileName) then
  begin
    list := TStringList.Create;
    try
      list.LoadFromFile(UseSpellFileName);
      for i := 0 to list.Count - 1 do
        Spells.Add(Pointer(StrToInt(list[i])));
    finally
      list.Free;
    end;
  end;
end;

function TMainForm.IsSpellInBase(id: integer): boolean;
var
  i: integer;
begin
  Result := false;
  for i := 0 to Spells.Count - 1 do
  begin
    if integer(Spells[i]) = id then
    begin
      Result := true;
      Exit;
    end;
  end;
end;

procedure TMainForm.edirentryButtonClick(Sender: TObject);
begin
  ClearFields(ttItem);
  LoadQueryToListView(Format('SELECT rlt.*, i.`name` FROM `reference_loot_template`'+
     ' rlt LEFT OUTER JOIN `item_template` i ON i.`entry` = rlt.`entry`'+
     ' WHERE (rlt.`entry`=%d)',[StrToIntDef(edirentry.Text,0)]), lvitReferenceLoot);
end;

procedure TMainForm.JvHttpUrlGrabberDoneStream(Sender: TObject; Stream: TStream;
  StreamSize: Integer; Url: string);
var
  list :TStringList;
  LastVer : integer;
begin
  try
    list := TStringList.Create;
    try
      list.LoadFromStream(Stream);
      {$IFDEF DEBUG}
        ShowMessage(List.Text);
      {$ENDIF}
      if list.Count=0 then
      begin
        if GlobalFlag then
          ShowMessage('Error: Updates not found.');
        IsFirst := false;
        Exit;
      end;

      LastVer := StrToIntDef(list[0], 0);

      if LastVer > CurVer() then
      begin
        if MessageDlg(Format(dmMain.Text[137],[CreateVer(LastVer)]), mtConfirmation, mbYesNoCancel, 0, mbYes) = mrYes then
        begin
          BrowseURL1.URL := 'http://code.google.com/p/truice/';
          BrowseURL1.Execute;
        end;
      end
      else
      begin
        if globalflag then
          ShowMessage(dmMain.Text[138]);
      end;
    finally
      list.Free;
    end;
  finally
    IsFirst := false;
  end;
end;

procedure TMainForm.JvHttpUrlGrabberError(Sender: TObject; ErrorMsg: string);
begin
  IsFirst := false;
  if GlobalFlag then ShowMessage(ErrorMsg);  
end;

procedure TMainForm.nUninstallClick(Sender: TObject);
var
  s: string;
begin
  if MessageBox(Application.Handle, PChar(dmMain.Text[140]),'Uninstall', MB_ICONQUESTION or MB_YESNOCANCEL)<>ID_YES then Exit;
  with TRegistry.Create do
  try
    RootKey := HKEY_CURRENT_USER;
    s := 'Software\' + Trim(ProgramName) + '\';
    DeleteKey(s+'lvSearchItem\Columns');
    DeleteKey(s+'lvSearchItem\Sort');
    DeleteKey(s+'lvSearchItem');
    DeleteKey(s+'QuestList');
    DeleteKey(s+'servers\localhost');
    DeleteKey(s+'servers');
    DeleteKey(s);
    s := dmMain.ProgramDir;
    DeleteFile(s+'CSV\');
    DeleteFile(s+'CSV\AreaTable.csv');
    DeleteFile(s+'CSV\CreatureFamily.csv');
    DeleteFile(s+'CSV\CreatureType.csv');
    DeleteFile(s+'CSV\Emotes.csv');
    DeleteFile(s+'CSV\Faction.csv');
    DeleteFile(s+'CSV\FactionTemplate.csv');
    DeleteFile(s+'CSV\GameObjectType.csv');
    DeleteFile(s+'CSV\GemProperties.csv');
    DeleteFile(s+'CSV\ItemBagFamily.csv');
    DeleteFile(s+'CSV\ItemBonding.csv');
    DeleteFile(s+'CSV\ItemClass.csv');
    DeleteFile(s+'CSV\ItemDmgType.csv');
    DeleteFile(s+'CSV\ItemInventoryType.csv');
    DeleteFile(s+'CSV\ItemMaterial.csv');
    DeleteFile(s+'CSV\ItemPageMaterial.csv');
    DeleteFile(s+'CSV\ItemPetFood.csv');
    DeleteFile(s+'CSV\ItemQuality.csv');
    DeleteFile(s+'CSV\ItemRequiredReputationRank.csv');
    DeleteFile(s+'CSV\ItemSet.csv');
    DeleteFile(s+'CSV\ItemSheath.csv');
    DeleteFile(s+'CSV\ItemStatType.csv');
    DeleteFile(s+'CSV\ItemSubClass.csv');
    DeleteFile(s+'CSV\Language.csv');
    DeleteFile(s+'CSV\Map.csv');
    DeleteFile(s+'CSV\QuestInfo.csv');
    DeleteFile(s+'CSV\QuestSort.csv');
    DeleteFile(s+'CSV\Rank.csv');
    DeleteFile(s+'CSV\ScriptCommand.csv');
    DeleteFile(s+'CSV\SkillLine.csv');
    DeleteFile(s+'CSV\SpellItemEnchantment.csv');
    DeleteFile(s+'CSV\Spell.csv');
    DeleteFile(s+'CSV\useSpells.csv');
    DeleteFile(s+'CSV\class.csv');
    DeleteFile(s+'CSV\race.csv');
    DeleteFile(s+'CSV\trainer_type.csv');
    DeleteFile(s+'CSV\spawnMaskFlags.csv');
    RemoveDir(s+'CSV');
    DeleteFile(s+'LANG\Default.lng');
    DeleteFile(s+'LANG\German.lng');
    DeleteFile(s+'LANG\Russian.lng');
    RemoveDir(s+'LANG');
    DeleteFile(s+'Truice.sql');
    with TStringList.Create do
    begin
      Add(':try');
      Add('del /Q Truice.exe');
      Add('if exist Truice.exe goto try');
      Add('del /Q uninstall.bat');
      SaveToFile(s+'uninstall.bat');
    end;
    ShellExecute(MainForm.Handle, 'open', PChar(s+'uninstall.bat'), nil, nil, SW_HIDE);
    Application.Terminate;
  finally
    Free;
  end;
end;

procedure TMainForm.btBrowseSiteClick(Sender: TObject);
begin
  if assigned(lvQuest.Selected) then
    dmMain.BrowseSite(ttQuest, StrToInt(lvQuest.Selected.Caption));
end;

procedure TMainForm.StopThread;
begin
  if Assigned(Thread) then
  begin
    Thread.Terminate;
    Thread.WaitFor;
    Thread := nil;
  end;
end;

procedure TMainForm.btDeleteQuestClick(Sender: TObject);
begin
  PageControl2.ActivePageIndex := SCRIPT_TAB_NO_QUEST;
  meqtScript.Text := Format(
  'DELETE FROM `quest_template` WHERE (`Id`=%0:s);'#13#10+
  'DELETE FROM `creature_questrelation` WHERE (`quest`=%0:s);'#13#10+
  'DELETE FROM `gameobject_questrelation` WHERE (`quest`=%0:s);'#13#10+
  'DELETE FROM `creature_involvedrelation` WHERE (`quest`=%0:s);'#13#10+
  'DELETE FROM `gameobject_involvedrelation` WHERE (`quest`=%0:s);'#13#10+
  'DELETE FROM `areatrigger_involvedrelation` WHERE (`quest`=%0:s);'#13#10
   ,[lvQuest.Selected.Caption]);
end;

procedure TMainForm.btDelQuestGiverClick(Sender: TObject);
begin
  if Assigned(lvqtGiverTemplate.Selected) then
    lvqtGiverTemplate.DeleteSelected;
end;

procedure TMainForm.btDelQuestTakerClick(Sender: TObject);
begin
  if Assigned(lvqtTakerTemplate.Selected) then
    lvqtTakerTemplate.DeleteSelected;
end;

procedure TMainForm.edSearchChange(Sender: TObject);
begin
  btEditQuest.Default := False;
  btSearch.Default :=  True;
end;

procedure TMainForm.btClearClick(Sender: TObject);
begin
  edgeholiday.Clear;
  edgedescription.Clear;
  edSearchGameEventEntry.Clear;
  edSearchGameEventDesc.Clear;
  edSearchPageTextEntry.Clear;
  edgeeventEntry.Clear;
  edgelength.Clear;
  edgeoccurence.Clear;
  edgeworld_event.Clear;
  edSearchPageTextText.Clear;
  edSearchPageTextNextPage.Clear;
  edQuestID.Clear;
  edQuestTitle.Clear;
  edQuestGiverSearch.Clear;
  edQuestTakerSearch.Clear;
  edZoneOrSortSearch.Clear;
  edQuestFlagsSearch.Clear;
  lvQuest.Clear;
end;

{---------- Creature stuff --------------}

procedure TMainForm.btClearSearchCreatureClick(Sender: TObject);
begin
  edSearchCreatureEntry.Clear;
  edSearchCreatureName.Clear;
  edSearchCreatureSubName.Clear;
  lvSearchCreature.Clear;
  edSearchCreaturenpcflag.Clear;
end;

procedure TMainForm.btSearchCreatureClick(Sender: TObject);
begin
  SearchCreature();
  with lvSearchCreature do
    if Items.Count>0 then
    begin
      SetFocus;
      Selected := Items[0];
      btEditCreature.Default := true;
      btSearchCreature.Default := false;
    end;
  StatusBarCreature.Panels[0].Text := Format(dmMain.Text[80], [lvSearchCreature.Items.Count]);
end;

procedure TMainForm.SearchCreature;
var
  i, KillCredit1_,KillCredit2_: integer;
  loc, ID, CName, CSubName, QueryStr, WhereStr, t, npcflag: string;
  Field: TField;
begin
  loc:= LoadLocales();
  ShowHourGlassCursor;
  lvSearchCreature.Columns[7].Caption:='name'+loc;
  lvSearchCreature.Columns[8].Caption:='subname'+loc;
  ID :=  edSearchCreatureEntry.Text;
  CName := edSearchCreatureName.Text;
  CName := StringReplace(CName, '''', '\''', [rfReplaceAll]);
  CName := StringReplace(CName, ' ', '%', [rfReplaceAll]);
  CName := '%'+CName+'%';

  CSubName := edSearchCreatureSubName.Text;
  CSubName := StringReplace(CSubName, '''', '\''', [rfReplaceAll]);
  CSubName := StringReplace(CSubName, ' ', '%', [rfReplaceAll]);
  CSubName := '%'+CSubName+'%';

  QueryStr := '';
  WhereStr := '';
  if ID<>'' then
  begin
    if pos('-', ID)=0 then
      WhereStr := Format('WHERE ((ct.`entry` in (%s)) OR (ct.`difficulty_entry_1` in (%0:s)))',[ID])
    else
      WhereStr := Format('WHERE (((ct.`entry` >= %s) AND (ct.`entry` <= %0:s)) OR ((ct.`difficulty_entry_1` >= %0:s) AND (ct.`heroic_entry` <= %0:s)))',[ID]);
  end;

  if CName<>'%%' then
  begin
    if WhereStr<> '' then
      WhereStr := Format('%s AND ((ct.`name` LIKE ''%s'') OR (lc.`name'+loc+'` LIKE ''%1:s''))',[WhereStr, CName])
    else
      WhereStr := Format('WHERE ((ct.`name` LIKE ''%s'') OR (lc.`name'+loc+'` LIKE ''%0:s''))',[CName]);
  end;

  if CSubName<>'%%' then
  begin
    if WhereStr<> '' then
      WhereStr := Format('%s AND ((ct.`subname` LIKE ''%s'') OR (lc.`subname'+loc+'` LIKE ''%1:s''))',[WhereStr, CSubName])
    else
      WhereStr := Format('WHERE ((ct.`subname` LIKE ''%s'') OR (lc.`subname'+loc+'` LIKE ''%0:s''))',[CSubName]);
  end;

  npcflag := edSearchCreaturenpcflag.Text;

  if npcflag<>'' then
  begin
    if rbExactnpcflag.Checked then
    begin
      if WhereStr<> '' then
        WhereStr := Format('%s AND (ct.`npcflag`=%s)',[WhereStr, npcflag])
      else
        WhereStr := Format('WHERE (ct.`npcflag`=%s)',[npcflag]);
    end
    else
    begin
      if WhereStr<> '' then
        WhereStr := Format('%s AND (ct.`npcflag` & %1:s = %1:s)',[WhereStr, npcflag])
      else
        WhereStr := Format('WHERE (ct.`npcflag` & %0:s = %0:s)',[npcflag]);
    end;
  end;

  KillCredit1_ := StrToIntDef(edSearchKillCredit1.Text,-1);
  if KillCredit1_<>-1 then
  begin
    if WhereStr<> '' then
      WhereStr := Format('%s AND (ct.`KillCredit1` =  %d)',[WhereStr, KillCredit1_])
    else
      WhereStr := Format('WHERE (ct.`KillCredit1` = %d)',[KillCredit1_]);
  end;

  KillCredit2_ := StrToIntDef(edSearchKillCredit2.Text,-1);
  if KillCredit2_<>-1 then
  begin
    if WhereStr<> '' then
      WhereStr := Format('%s AND (ct.`KillCredit2` =  %d)',[WhereStr, KillCredit2_])
    else
      WhereStr := Format('WHERE (ct.`KillCredit2` = %d)',[KillCredit2_]);
  end;

  if Trim(WhereStr)='' then
    if MessageDlg(dmMain.Text[134], mtConfirmation, mbYesNoCancel, -1)<>mrYes then Exit;

  QueryStr := Format('SELECT *,(SELECT count(guid) from `creature` where creature.id = ct.entry) as `Count` FROM `creature_template` ct LEFT OUTER JOIN locales_creature lc ON ct.entry=lc.entry %s',[WhereStr]);
  MyQuery.SQL.Text := QueryStr;
  lvSearchCreature.Items.BeginUpdate;
  try
    MyQuery.Open;
    lvSearchCreature.Clear;
    while not MyQuery.Eof do
    begin
      with lvSearchCreature.Items.Add do
      begin
        for i := 0 to lvSearchCreature.Columns.Count - 1 do
        begin
          Field := MyQuery.FindField(lvSearchCreature.Columns[i].Caption);
          t := '';
          if Assigned(Field) then
          begin
            t := Field.AsString;
            if i=0 then Caption := t;
          end;
          if i<>0 then SubItems.Add(t);
        end;
        MyQuery.Next;
      end;
    end;
  finally
    lvSearchCreature.Items.EndUpdate;
    MyQuery.Close;
  end;
end;

procedure TMainForm.SearchCreatureModelInfo;
var
  i: integer;
  ID, QueryStr, WhereStr, t: string;
  Field: TField;
begin
  ShowHourGlassCursor;

  ID :=  edCreatureModelSearch.Text;

  QueryStr := '';
  WhereStr := '';
  if ID<>'' then
  begin
    if pos('-', ID)=0 then
      WhereStr := Format('WHERE (`modelid` in (%s))',[ID])
    else
      WhereStr := Format('WHERE (`modelid` >= %s) AND (`modelid` <= %s)',[MidStr(ID,1,pos('-',id)-1), MidStr(ID,pos('-',id)+1,length(id))]);
  end;

  if Trim(WhereStr)='' then
    if MessageDlg(dmMain.Text[134], mtConfirmation, mbYesNoCancel, -1)<>mrYes then Exit;

  QueryStr := Format('SELECT * FROM `creature_model_info` %s',[WhereStr]);
  MyQuery.SQL.Text := QueryStr;
  lvCreatureModelSearch.Items.BeginUpdate;
  try
    MyQuery.Open;
    lvCreatureModelSearch.Clear;
    while not MyQuery.Eof do
    begin
      with lvCreatureModelSearch.Items.Add do
      begin
        for i := 0 to lvCreatureModelSearch.Columns.Count - 1 do
        begin
          Field := MyQuery.FindField(lvCreatureModelSearch.Columns[i].Caption);
          t := '';
          if Assigned(Field) then
          begin
            t := Field.AsString;
            if i=0 then Caption := t;
          end;
          if i<>0 then SubItems.Add(t);
        end;
        MyQuery.Next;
      end;
    end;
  finally
    lvCreatureModelSearch.Items.EndUpdate;
    MyQuery.Close;
  end;
end;

procedure TMainForm.edSearchCreatureChange(Sender: TObject);
begin
  btEditCreature.Default := False;
  btSearchCreature.Default :=  True;
end;

procedure TMainForm.lvSearchCreatureDblClick(Sender: TObject);
begin
  PageControl3.ActivePageIndex := 1;
  if Assigned(lvSearchCreature.Selected) then
  begin
    LoadCreature(StrToInt(lvSearchCreature.Selected.Caption));
    CompleteCreatureScript;
  end;
end;

procedure TMainForm.lvSearchCharDblClick(Sender: TObject);
begin
  PageControl8.ActivePageIndex := 1;
  if Assigned(lvSearchChar.Selected) then
    LoadCharacter(StrToInt(lvSearchChar.Selected.Caption));
end;

procedure TMainForm.lvSearchCreatureChange(Sender: TObject;
  Item: TListItem; Change: TItemChange);
var
  flag: boolean;
begin
  flag := Assigned(lvSearchCreature.Selected);
  if flag then
    lvSearchCreature.PopupMenu := pmCreature
  else
    lvSearchCreature.PopupMenu := nil;
  btEditCreature.Enabled := flag;
  btDeleteCreature.Enabled := flag;
  btBrowseCreature.Enabled := flag;
  nEditCreature.Enabled := flag;
  nDeleteCreature.Enabled := flag;
  nBrowseCreature.Enabled := flag;
  btBrowseCreaturePopup.Enabled := flag;
end;

procedure TMainForm.btEditCreatureClick(Sender: TObject);
begin
  PageControl3.ActivePageIndex := 1;
  if Assigned(lvSearchCreature.Selected) then
    LoadCreature(StrToInt(lvSearchCreature.Selected.Caption));
end;

procedure TMainForm.btDeleteCreatureClick(Sender: TObject);
begin
 PageControl3.ActivePageIndex := SCRIPT_TAB_NO_CREATURE;
  mectScript.Text := Format(
  'DELETE FROM `creature_template` WHERE (`entry`=%0:s);'#13#10
   ,[lvSearchCreature.Selected.Caption]);
end;

procedure TMainForm.btBrowseCreatureClick(Sender: TObject);
begin
  if assigned(lvSearchCreature.Selected) then
    dmMain.BrowseSite(ttNPC, StrToInt(lvSearchCreature.Selected.Caption));
end;

procedure TMainForm.LoadButtonScript(GUID: integer);
begin
  LoadQueryToListView(Format('SELECT * FROM `gameobject_scripts` WHERE (`id`=%d)', [GUID]), lvgbButtonScript);
end;

procedure TMainForm.LoadCharacter(GUID: integer);
begin
  ShowHourGlassCursor;
  ClearFields(ttChar);
  if GUID<1 then Exit;
  MyQuery.SQL.Text := Format('SELECT * FROM `'+CharDBName+'`.`characters` WHERE `guid`=%d',[guid]);
  MyQuery.Open;
  try
    if MyQuery.Eof then
      raise Exception.Create(Format(dmMain.Text[153], [Guid]));  //'Error: Char (guid = %d) not found'
    FillFields(MyQuery, PFX_CHARACTER);
    LoadCharacterInventory(GUID);
    MyQuery.Close;
  except
    on E: Exception do
      raise Exception.Create(dmMain.Text[154]+#10#13+E.Message);
  end;
end;
procedure TMainForm.LoadCharacterInventory(GUID: integer);
begin
  LoadCharQueryToListView(Format('SELECT ci.*, i.name FROM `'+CharDBName+'`.`character_inventory` ci LEFT JOIN `'+CharDBName+'`.`item_instance` ii'+
  ' ON ii.guid = ci.item LEFT JOIN `item_template` i ON i.entry = ii.itemEntry '+
  'WHERE ci.`guid` = %d ORDER BY ci.`bag`, ci.`slot`',[guid]), lvCharacterInventory);
end;

procedure TMainForm.LoadCharQueryToListView(strQuery: string; ListView: TJvListView);
begin
  LoadMyQueryToListView(MyTempQuery, strQuery, ListView);
end;

procedure TMainForm.LoadMyQueryToListView(Query: TZQuery; strQuery: string; ListView: TJvListView);
var
  i: integer;
begin
  ListView.Items.BeginUpdate;
  try
    ListView.Clear;
    if Query.Active then
      Query.Close;
    Query.SQL.Text := strQuery;
    Query.Open;
    while not Query.Eof do
    begin
      for i := 0 to ListView.Columns.Count - 1 do
        ListView.Columns[i].Caption := '';
      for i := 0 to Query.FieldCount - 1 do
        ListView.Columns[i].Caption := Query.Fields[i].FieldName;
      with ListView.Items.Add do
      begin
        Caption := Query.Fields[0].AsString;
        for i := 1 to Query.FieldCount - 1 do
          SubItems.Add(Query.Fields[i].AsString);
      end;
      Query.Next;
    end;
    Query.Close;
  finally
    ListView.Items.EndUpdate;
  end;
end;

procedure TMainForm.LoadSmartAI(entryorguid: integer; sourcetype: integer);
begin
    if entryorguid<1 then exit;

    ShowHourGlassCursor;
    ClearSmartAIFields();

    LoadQueryToListView(Format('SELECT `entryorguid` as `entry`,  `source_type` as `src`, `id`, `link`, `event_type` as `et`,  '+
      '`event_phase_mask` as `epm`, `event_chance` as `ec`,  `event_flags` as `ef`, `event_param1` as `ep1`,  `event_param2` as `ep2`, '+
      '`event_param3` as `ep3`, `event_param4` as `ep4`,  `action_type` as `at`,  `action_param1` as `a1`,  `action_param2` as `a2`, '+
      '`action_param3` as `a3`, `action_param4` as `a4`,  `action_param5` as `a5`,  `action_param6` as `a6`, `target_type` as `tt`, '+
      '`target_param1` as `t1`,  `target_param2` as `t2`,  `target_param3` as `t3`, `target_x` as `tx`, `target_y` as `ty`, '+
      '`target_z` as `tz`, `target_o` as `to`, `comment` as `cmt` FROM `smart_scripts` WHERE `entryorguid`=%d AND `source_type`=%d',[entryorguid, sourcetype]), lvcySmartAI);
end;

procedure TMainForm.LoadCreature(Entry: integer);
var
  i: integer;
  isvendor, istrainer, isEventAI, isEquip: boolean;
  npcflag: integer;
begin
  ShowHourGlassCursor;
  ClearFields(ttNPC);
  if Entry<1 then exit;
  // load full description for creature
  MyQuery.SQL.Text := Format('SELECT * FROM `creature_template` WHERE `entry`=%d',[Entry]);
  MyQuery.Open;
  try
    if MyQuery.Eof then
      raise Exception.Create(Format(dmMain.Text[81], [Entry]));  //'Error: Creature (entry = %d) not found'
    edctEntry.Text := IntToStr(Entry);
    FillFields(MyQuery, PFX_CREATURE_TEMPLATE);

    npcflag := MyQuery.FieldByName('npcflag').AsInteger;

    // is creature vendor?
    if npcflag and $80 = $80 then isvendor := true else isvendor := false;

    // is creature trainer?
    if npcflag and 16 = 16 then istrainer := true else istrainer := false;

    // is eventAI ?
    //if MyQuery.FieldByName('AIName').AsString = mob_eventai then
    isEventAI := true; //else isEventAI := false;

    if MyQuery.FieldByName('equipment_id').AsInteger <> 0 then isEquip:= true else isEquip:= false;

    MyQuery.Close;

    LoadQueryToListView(Format('SELECT `guid`, `id`, `map`, `position_x`,'+
      ' `position_y`,`position_z`,`orientation` FROM `creature` WHERE (`id`=%d)',
      [Entry]),lvclCreatureLocation);

    LoadQueryToListView(Format('SELECT clt.*, i.`name` FROM `creature_loot_template`'+
     ' clt LEFT OUTER JOIN `item_template` i ON i.`entry` = clt.`item`'+
     ' WHERE (clt.`entry`=%d)',[StrToIntDef(edctlootid.Text,0)]), lvcoCreatureLoot);

    LoadQueryToListView(Format('SELECT plt.*, i.`name` FROM `pickpocketing_loot_template`'+
     ' plt LEFT OUTER JOIN `item_template` i ON i.`entry` = plt.`item`'+
     ' WHERE (plt.`entry`=%d)',[StrToIntDef(edctpickpocketloot.Text,0)]), lvcoPickpocketLoot);

    LoadQueryToListView(Format('SELECT slt.*, i.`name` FROM `skinning_loot_template`'+
     ' slt LEFT OUTER JOIN `item_template` i ON i.`entry` = slt.`item`'+
     ' WHERE (slt.`entry`=%d)',[StrToIntDef(edctskinloot.Text,0)]), lvcoSkinLoot);

    if isvendor then LoadQueryToListView(Format('SELECT v.*, i.`name` FROM `npc_vendor` v'+
    ' LEFT OUTER JOIN `item_template` i ON i.`entry` = v.`item` WHERE (v.`entry`=%d)',
      [Entry]),lvcvNPCVendor);
    tsNPCVendor.TabVisible := isvendor;

    if isEquip then LoadCreatureEquip(StrToIntDef(edctequipment_id.Text,0));

    if isEventAI then
      LoadQueryToListView(Format('SELECT   `id`,  `creature_id` as `cid`,  `event_type` as `et`,  '+
      '`event_inverse_phase_mask` as `epm`, `event_chance` as `ec`,  `event_flags` as `ef`,  '+
      '`event_param1` as `ep1`,  `event_param2` as `ep2`,  `event_param3` as `ep3`, `event_param4` as `ep4`,  '+
      '`action1_type` as `a1t`,  `action1_param1` as `a11`,  `action1_param2` as `a12`,  `action1_param3` as `a13`, '+
      '`action2_type` as `a2t`,  `action2_param1` as `a21`,  `action2_param2` as `a22`,  `action2_param3` as `a23`, '+
      '`action3_type` as `a3t`,  `action3_param1` as `a31`,  `action3_param2` as `a32`,  `action3_param3` as `a33`, '+
      '`comment` as `cmt` FROM `creature_ai_scripts` WHERE `creature_id`=%d',[Entry]), lvcnEventAI);
    //tsCreatureEventAI.TabVisible := isEventAI;

    if istrainer then
    begin
      LoadQueryToListView(Format('SELECT `entry`, `spell`,'+
        ' `spellcost`, `reqskill`, `reqskillvalue`, `reqlevel`'+
        ' FROM `npc_trainer` WHERE (`entry`=%d)',
        [Entry]),lvcrNPCTrainer);
      // set spellnames in list view
      lvcrNPCTrainer.Columns[lvcrNPCTrainer.Columns.Count-1].Caption := 'Spell Name';
      for i := 0 to lvcrNPCTrainer.Items.Count - 1 do
        lvcrNPCTrainer.Items[i].SubItems.Add(SpellsForm.GetSpellName(StrToIntDef(lvcrNPCTrainer.Items[i].SubItems[0],0)));
    end;
    tsNPCTrainer.TabVisible := istrainer;
    LoadCreatureTemplateAddon(Entry);
    edclid.Text := IntToStr(Entry);
    edcoentry.Text := edctlootid.Text;
    edcpentry.Text := edctpickpocketloot.Text;
    edcsentry.Text := edctskinloot.Text;
    edcventry.Text := IntToStr(Entry);
    edcrentry.Text := IntToStr(Entry);        
  except
    on E: Exception do
      raise Exception.Create(dmMain.Text[82]+#10#13+E.Message);
  end;
end;

procedure TMainForm.CompleteCreatureScript;
var
  ctentry, Fields, Values: string;
begin
  mectLog.Clear;
  ctentry := edctEntry.Text;
  if ctentry='' then exit;
  SetFieldsAndValues(Fields, Values, 'creature_template', PFX_CREATURE_TEMPLATE, mectLog);
  case SyntaxStyle of
    ssInsertDelete: mectScript.Text := Format('DELETE FROM `creature_template` WHERE (`entry`=%s);'#13#10+
      'INSERT INTO `creature_template` (%s) VALUES (%s);'#13#10,[ctentry, Fields, Values]);
    ssReplace: mectScript.Text := Format('REPLACE INTO `creature_template` (%s) VALUES (%s);'#13#10,[Fields, Values]);
    ssUpdate: mectScript.Text := MakeUpdate('creature_template', PFX_CREATURE_TEMPLATE, 'entry', ctentry);
  end;
end;

procedure TMainForm.CompleteCreatureTemplateAddonScript;
var
  entry, Fields, Values: string;
begin
  mectLog.Clear;
  entry := edcdentry.Text;
  if entry='' then exit;
  SetFieldsAndValues(Fields, Values, 'creature_template_addon', PFX_CREATURE_TEMPLATE_ADDON, mectLog);
  mectScript.Text := Format('DELETE FROM `creature_template_addon` WHERE (`entry`=%s);'#13#10+
    'INSERT INTO `creature_template_addon` (%s) VALUES (%s);'#13#10,[entry, Fields, Values]);
end;

procedure TMainForm.GetCreatureDynamicFlags(Sender: TObject);
begin
  GetSomeFlags(Sender, 'CreatureDynamicFlags');
end;

procedure TMainForm.edctEntryButtonClick(Sender: TObject);
var
  KeyboardState: TKeyboardState;
  id: integer;
begin
  id := abs(StrToIntDef(TJvComboEdit(Sender).Text,0));
  if id = 0 then Exit;
  GetKeyboardState(KeyboardState);
  if ssShift in KeyboardStateToShiftState(KeyboardState) then
    dmMain.BrowseSite(ttNPC, id)
  else
    LoadCreature(id);
end;

procedure TMainForm.btcyLoadClick(Sender: TObject);
var
  id, sourcetype: integer;
begin
  id := abs(StrToIntDef(edcyentryorguid.Text,0));
  sourcetype := abs(StrToIntDef(edcysource_type.Text,0));
  if id = 0 then Exit;
  if (sourcetype = 0) and (edcysource_type.Text = '') then
  begin
    ShowMessage(dmMain.Text[158]);
    Exit;
  end;

  LoadSmartAI(id, sourcetype);
end;

procedure TMainForm.edctequipment_idDblClick(Sender: TObject);
begin
PageControl3.ActivePageIndex := 4;
LoadCreatureEquip(StrToIntDef(edctequipment_id.Text,0));
end;

procedure TMainForm.btSmartAIAddClick(Sender: TObject);
begin
	SmartAIAdd('edcy', lvcySmartAI);
end;

procedure TMainForm.btSmartAIDelClick(Sender: TObject);
begin
	SmartAIDel(lvcySmartAI);
end;

procedure TMainForm.btSmartAIUpdClick(Sender: TObject);
begin
	SmartAIUpd('edcy',lvcySmartAI);
end;

procedure TMainForm.btEventAIAddClick(Sender: TObject);
begin
	EventAIAdd('edcn', lvcnEventAI);
end;

procedure TMainForm.btEventAIDelClick(Sender: TObject);
begin
	EventAiDel(lvcnEventAI);
end;

procedure TMainForm.btEventAIUpdClick(Sender: TObject);
begin
	EventAIUpd('edcn',lvcnEventAI);
end;

procedure TMainForm.btExecuteEventAIScriptClick(Sender: TObject);
begin
  if MessageDlg(dmMain.Text[9], mtConfirmation, mbYesNoCancel, -1)=mrYes then
    ExecuteScript(mectScript.Text, mectLog);
end;

procedure TMainForm.btExecuteSmartAIScriptClick(Sender: TObject);
begin
  if MessageDlg(dmMain.Text[9], mtConfirmation, mbYesNoCancel, -1)=mrYes then
    ExecuteScript(mecyScript.Text, mecyLog);
end;

procedure TMainForm.btCopyToClipboardCreatureClick(Sender: TObject);
begin
  mectScript.SelectAll;
  mectScript.CopyToClipboard;
  mectScript.SelStart := 0;
  mectScript.SelLength := 0;
end;

procedure TMainForm.btCopyToClipboardSmartAIClick(Sender: TObject);
begin
  mecyScript.SelectAll;
  mecyScript.CopyToClipboard;
  mecyScript.SelStart := 0;
  mecyScript.SelLength := 0;
end;

procedure TMainForm.tsButtonScriptShow(Sender: TObject);
begin
  if edgbid.Text = '' then edgbid.Text := edgtentry.Text;
end;

procedure TMainForm.tsCharacterScriptShow(Sender: TObject);
begin
  case PageControl8.ActivePageIndex of
    1: CompleteCharacterScript;
    2: CompleteCharacterInventoryScript;
{    3: CompleteDisLootScript;
    4: CompleteProsLootScript;
    5: CompleteItemEnchScript;}
  end;
end;

procedure TMainForm.reaShow(Sender: TObject);
begin
  if (edcaguid.Text='') then edcaguid.Text := edclguid.Text;
  if (edcamount.Text='') then edcamount.Text := '0';
  if (edcabytes1.Text='') then edcabytes1.Text := '0';
  if (edcabytes2.Text='') then edcabytes2.Text := '0';
  if (edcaemote.Text='') then edcaemote.Text := '0';
  if (edcamoveflags.Text='') then edcamoveflags.Text := '0';
  if (edcaauras.Text='') then edcaauras.Text := '';
end;

procedure TMainForm.tsCreatureEquipTemplateShow(Sender: TObject);
var
  itemEntry: integer;
begin
  if (edceitemEntry1.Text='') then edceitemEntry1.Text := '0';
  if (edceitemEntry2.Text='') then edceitemEntry2.Text := '0';
  if (edceitemEntry3.Text='') then edceitemEntry3.Text := '0';

  if Assigned(lvclCreatureLocation.Selected) and (StrToIntDef(edclequipment_id.Text,0)<>0) then
    itemEntry := StrToIntDef(edclequipment_id.Text,0)
  else
    itemEntry := StrToIntDef(edctequipment_id.Text,0);
  if itemEntry <> 0 then
  begin
    edceEntry.Text := IntToStr(itemEntry);

  end;
end;

procedure TMainForm.tsCreatureModelInfoShow(Sender: TObject);
var
  model: string;
begin
  model := '';
  if Assigned(lvclCreatureLocation.Selected) and (StrToIntDef(edclmodelid.Text,0)<>0) then
    model := edclmodelid.Text
  else
  begin
    if (edctmodelid1.Text <> '') and (edctmodelid1.Text <> '0')  then
      model := edctmodelid1.Text;
    if (edctmodelid2.Text <> '') and (edctmodelid2.Text <> '0')  then
    begin
      if model <> '' then
        model := Format('%s,%s',[model, edctmodelid2.Text])
      else
        model := edctmodelid2.Text;
    end;
  end;
  if model <> '' then
  begin
    edCreatureModelSearch.Text := model;
    btCreatureModelSearch.Click;
  end;
end;

procedure TMainForm.tsCreatureOnKillReputationShow(Sender: TObject);
begin
  if trim(edctEntry.Text)<>'' then
    LoadCreatureOnKillReputation(edctEntry.Text);
  edckcreature_id.Text := edctEntry.Text;    
end;

procedure TMainForm.tsCreatureScriptShow(Sender: TObject);
begin
  case PageControl3.ActivePageIndex of
    1: CompleteCreatureScript;
    2: CompleteCreatureLocationScript;
    3: CompleteCreatureModelInfoScript;
    4: CompleteCreatureEquipTemplateScript;
    5: CompleteCreatureLootScript;
    6: CompletePickpocketLootScript;
    7: CompleteSkinLootScript;
    8: CompleteNPCVendorScript;
    9: CompleteNPCTrainerScript;
    10: CompleteCreatureTemplateAddonScript;
    11: CompleteCreatureAddonScript;
    13: CompleteCreatureMovementScript;
    14: CompleteCreatureOnKillReputationScript;
    15: {involved in tab - do nothing};
    16: CompleteCreatureEventAIScript;
  end;
end;

procedure TMainForm.tsCreatureTemplateAddonShow(Sender: TObject);
begin
  if (edcdentry.Text='') then edcdentry.Text := edctEntry.Text;
  if (edcdmount.Text='') then edcdmount.Text := '0';
  if (edcdbytes1.Text='') then edcdbytes1.Text := '0';
  if (edcdbytes2.Text='') then edcdbytes2.Text := '0';
  if (edcdemote.Text='') then edcdemote.Text := '0';
  if (edcdmoveflags.Text='') then edcdmoveflags.Text := '0';
  if (edcdauras.Text='') then edcdauras.Text := '';
 end;

procedure TMainForm.tsCreatureUsedShow(Sender: TObject);
begin
  LoadCreatureInvolvedIn(edctEntry.Text);
end;

procedure TMainForm.tsDisenchantLootShow(Sender: TObject);
begin
  if (edidentry.Text = '') then edidentry.Text := editDisenchantID.Text;  
end;

procedure TMainForm.tsEnchantmentShow(Sender: TObject);
begin
  if (edieentry.Text = '') then
  begin
    if ((editRandomProperty.Text='0') or (editRandomProperty.Text='')) then
      edieentry.Text := editRandomSuffix.Text
    else
      edieentry.Text := editRandomProperty.Text; 
  end;
end;

procedure TMainForm.LoadCreatureInvolvedIn(Entry: string);
var
  a, b, temp: string;
begin
  if trim(entry)='' then Exit;
  // STARTS
  MyTempQuery.SQL.Text := Format('Select qt.* from creature_questrelation ci' +
                                 ' INNER JOIN quest_template qt ON ci.quest = qt.Id' +
                                 ' where ci.id = %s', [Entry]);
  MyTempQuery.Open;
  lvCreatureStarts.Items.BeginUpdate;
  lvCreatureStarts.Items.Clear;
  while not MyTempQuery.Eof do
  begin
    with lvCreatureStarts.Items.Add do
    begin
      Caption := MyTempQuery.FieldByName('Id').AsString;
      SubItems.Add(MyTempQuery.FieldByName('title').AsString);
      SubItems.Add(MyTempQuery.FieldByName('Level').AsString);
      SubItems.Add(GetRaceAcronym(MyTempQuery.FieldByName('RequiredRaces').AsInteger));

      //Rewards
      a := '';    b := '';
      if MyTempQuery.FieldByName('RewardMoneyMaxLevel').AsInteger>0 then a := MyTempQuery.FieldByName('RewardMoneyMaxLevel').AsString + ' MML';
      if MyTempQuery.FieldByName('RewardOrRequiredMoney').AsInteger>0 then b := MyTempQuery.FieldByName('RewardOrRequiredMoney').AsString + 'c';
      if (a<>'') and (b<>'') then temp := a + ' + ' + b
      else temp := a + b;
      SubItems.Add(temp);

      SubItems.Add(GetZoneOrSortAcronym(MyTempQuery.FieldByName('ZoneOrSort').AsInteger));
    end;
    MyTempQuery.Next;
  end;
  MyTempQuery.Close;
  lvCreatureStarts.Items.EndUpdate;

  // ENDS
  MyTempQuery.SQL.Text := Format('Select qt.* from creature_involvedrelation ci' +
                                 ' INNER JOIN quest_template qt ON ci.quest = qt.Id' +
                                 ' where ci.id = %s',[Entry]);
  MyTempQuery.Open;
  lvCreatureEnds.Items.BeginUpdate;
  lvCreatureEnds.Items.Clear;
  while not MyTempQuery.Eof do
  begin
    with lvCreatureEnds.Items.Add do
    begin
      Caption := MyTempQuery.FieldByName('Id').AsString;
      SubItems.Add(MyTempQuery.FieldByName('title').AsString);
      SubItems.Add(MyTempQuery.FieldByName('Level').AsString);
      SubItems.Add(GetRaceAcronym(MyTempQuery.FieldByName('RequiredRaces').AsInteger));

      //Rewards
      a := '';    b := '';
      if MyTempQuery.FieldByName('RewardMoneyMaxLevel').AsInteger>0 then a := MyTempQuery.FieldByName('RewardMoneyMaxLevel').AsString + ' MML';
      if MyTempQuery.FieldByName('RewardOrRequiredMoney').AsInteger>0 then b := MyTempQuery.FieldByName('RewardOrRequiredMoney').AsString + 'c';
      if (a<>'') and (b<>'') then temp := a + ' + ' + b
      else temp := a + b;
      SubItems.Add(temp);

      SubItems.Add(GetZoneOrSortAcronym(MyTempQuery.FieldByName('ZoneOrSort').AsInteger));
    end;
    MyTempQuery.Next;
  end;
  MyTempQuery.Close;
  lvCreatureEnds.Items.EndUpdate;

  // Objective of
  MyTempQuery.SQL.Text := Format('Select * from quest_template ' +
                                 ' where RequiredNpcOrGo1 = %0:s OR' +
                                 ' RequiredNpcOrGo2 = %0:s OR RequiredNpcOrGo3 = %0:s OR' +
                                 ' RequiredNpcOrGo4 = %0:s ',[Entry]);
  MyTempQuery.Open;
  lvCreatureObjectiveOf.Items.BeginUpdate;
  lvCreatureObjectiveOf.Items.Clear;
  while not MyTempQuery.Eof do
  begin
    with lvCreatureObjectiveOf.Items.Add do
    begin
      Caption := MyTempQuery.FieldByName('Id').AsString;
      SubItems.Add(MyTempQuery.FieldByName('title').AsString);
      SubItems.Add(MyTempQuery.FieldByName('Level').AsString);
      SubItems.Add(GetRaceAcronym(MyTempQuery.FieldByName('RequiredRaces').AsInteger));

      //Rewards
      a := '';    b := '';
      if MyTempQuery.FieldByName('RewardMoneyMaxLevel').AsInteger>0 then a := MyTempQuery.FieldByName('RewardMoneyMaxLevel').AsString + ' MML';
      if MyTempQuery.FieldByName('RewardOrRequiredMoney').AsInteger>0 then b := MyTempQuery.FieldByName('RewardOrRequiredMoney').AsString + 'c';
      if (a<>'') and (b<>'') then temp := a + ' + ' + b
      else temp := a + b;
      SubItems.Add(temp);

      SubItems.Add(GetZoneOrSortAcronym(MyTempQuery.FieldByName('ZoneOrSort').AsInteger));
    end;
    MyTempQuery.Next;
  end;
  MyTempQuery.Close;
  lvCreatureObjectiveOf.Items.EndUpdate;

  tsCreatureStarts.TabVisible := lvCreatureStarts.Items.Count <> 0;
  tsCreatureEnds.TabVisible := lvCreatureEnds.Items.Count <> 0;
  tsCreatureObjectiveOf.TabVisible := lvCreatureObjectiveOf.Items.Count <> 0;
end;

procedure TMainForm.LoadGOInvolvedIn(Entry: string);
var
  a, b, temp: string;
begin
  if trim(entry)='' then Exit;

  // STARTS
  MyTempQuery.SQL.Text := Format('Select qt.* from gameobject_questrelation ci' +
                                 ' INNER JOIN quest_template qt ON ci.quest = qt.Id' +
                                 ' where ci.id = %s',[Entry]);
  MyTempQuery.Open;
  lvGameObjectStarts.Items.BeginUpdate;
  lvGameObjectStarts.Items.Clear;
  while not MyTempQuery.Eof do
  begin
    with lvGameObjectStarts.Items.Add do
    begin
      Caption := MyTempQuery.FieldByName('Id').AsString;
      SubItems.Add(MyTempQuery.FieldByName('title').AsString);
      SubItems.Add(MyTempQuery.FieldByName('Level').AsString);
      SubItems.Add(GetRaceAcronym(MyTempQuery.FieldByName('RequiredRaces').AsInteger));

      //Rewards
      a := '';    b := '';
      if MyTempQuery.FieldByName('RewardMoneyMaxLevel').AsInteger>0 then a := MyTempQuery.FieldByName('RewardMoneyMaxLevel').AsString + ' MML';
      if MyTempQuery.FieldByName('RewardOrRequiredMoney').AsInteger>0 then b := MyTempQuery.FieldByName('RewardOrRequiredMoney').AsString + 'c';
      if (a<>'') and (b<>'') then temp := a + ' + ' + b
      else temp := a + b;
      SubItems.Add(temp);

      SubItems.Add(GetZoneOrSortAcronym(MyTempQuery.FieldByName('ZoneOrSort').AsInteger));
    end;
    MyTempQuery.Next;
  end;
  MyTempQuery.Close;
  lvGameObjectStarts.Items.EndUpdate;

  // ENDS
  MyTempQuery.SQL.Text := Format('Select qt.* from gameobject_involvedrelation ci' +
                                 ' INNER JOIN quest_template qt ON ci.quest = qt.Id' +
                                 ' where ci.id = %s',[Entry]);
  MyTempQuery.Open;
  lvGameObjectEnds.Items.BeginUpdate;
  lvGameObjectEnds.Items.Clear;
  while not MyTempQuery.Eof do
  begin
    with lvGameObjectEnds.Items.Add do
    begin
      Caption := MyTempQuery.FieldByName('Id').AsString;
      SubItems.Add(MyTempQuery.FieldByName('title').AsString);
      SubItems.Add(MyTempQuery.FieldByName('Level').AsString);
      SubItems.Add(GetRaceAcronym(MyTempQuery.FieldByName('RequiredRaces').AsInteger));

      //Rewards
      a := '';    b := '';
      if MyTempQuery.FieldByName('RewardMoneyMaxLevel').AsInteger>0 then a := MyTempQuery.FieldByName('RewardMoneyMaxLevel').AsString + ' MML';
      if MyTempQuery.FieldByName('RewardOrRequiredMoney').AsInteger>0 then b := MyTempQuery.FieldByName('RewardOrRequiredMoney').AsString + 'c';
      if (a<>'') and (b<>'') then temp := a + ' + ' + b
      else temp := a + b;
      SubItems.Add(temp);

      SubItems.Add(GetZoneOrSortAcronym(MyTempQuery.FieldByName('ZoneOrSort').AsInteger));
    end;
    MyTempQuery.Next;
  end;
  MyTempQuery.Close;
  lvGameObjectEnds.Items.EndUpdate;

  // Objective of
  MyTempQuery.SQL.Text := Format('Select * from quest_template ' +
                                 ' where RequiredNpcOrGo1 = -%0:s OR' +
                                 ' RequiredNpcOrGo2 = -%0:s OR RequiredNpcOrGo3 = -%0:s OR' +
                                 ' RequiredNpcOrGo4 = -%0:s ',[Entry]);
  MyTempQuery.Open;
  lvGameObjectObjectiveOf.Items.BeginUpdate;
  lvGameObjectObjectiveOf.Items.Clear;
  while not MyTempQuery.Eof do
  begin
    with lvGameObjectObjectiveOf.Items.Add do
    begin
      Caption := MyTempQuery.FieldByName('Id').AsString;
      SubItems.Add(MyTempQuery.FieldByName('title').AsString);
      SubItems.Add(MyTempQuery.FieldByName('Level').AsString);
      SubItems.Add(GetRaceAcronym(MyTempQuery.FieldByName('RequiredRaces').AsInteger));

      //Rewards
      a := '';    b := '';
      if MyTempQuery.FieldByName('RewardMoneyMaxLevel').AsInteger>0 then a := MyTempQuery.FieldByName('RewardMoneyMaxLevel').AsString + ' MML';
      if MyTempQuery.FieldByName('RewardOrRequiredMoney').AsInteger>0 then b := MyTempQuery.FieldByName('RewardOrRequiredMoney').AsString + 'c';
      if (a<>'') and (b<>'') then temp := a + ' + ' + b
      else temp := a + b;
      SubItems.Add(temp);

      SubItems.Add(GetZoneOrSortAcronym(MyTempQuery.FieldByName('ZoneOrSort').AsInteger));
    end;
    MyTempQuery.Next;
  end;
  MyTempQuery.Close;
  lvGameObjectObjectiveOf.Items.EndUpdate;

  tsGOStarts.TabVisible := lvGameObjectStarts.Items.Count <> 0;
  tsGOEnds.TabVisible := lvGameObjectEnds.Items.Count <> 0;
  tsGOObjectiveOf.TabVisible := lvGameObjectObjectiveOf.Items.Count <> 0;
end;

procedure TMainForm.LoadItemInvolvedIn(Entry: string);
var
  a, b, temp: string;
begin
  if trim(entry)='' then Exit;
  // STARTS
  MyTempQuery.SQL.Text := Format('Select qt.* from item_template it' +
                                 ' INNER JOIN quest_template qt ON it.startquest = qt.Id' +
                                 ' where it.entry = %s',[Entry]);
  MyTempQuery.Open;
  lvItemStarts.Items.BeginUpdate;
  lvItemStarts.Items.Clear;
  while not MyTempQuery.Eof do
  begin
    with lvItemStarts.Items.Add do
    begin
      Caption := MyTempQuery.FieldByName('Id').AsString;
      SubItems.Add(MyTempQuery.FieldByName('title').AsString);
      SubItems.Add(MyTempQuery.FieldByName('Level').AsString);
      SubItems.Add(GetRaceAcronym(MyTempQuery.FieldByName('RequiredRaces').AsInteger));

      //Rewards
      a := '';    b := '';
      if MyTempQuery.FieldByName('RewardMoneyMaxLevel').AsInteger>0 then a := MyTempQuery.FieldByName('RewardMoneyMaxLevel').AsString + ' MML';
      if MyTempQuery.FieldByName('RewardOrRequiredMoney').AsInteger>0 then b := MyTempQuery.FieldByName('RewardOrRequiredMoney').AsString + 'c';
      if (a<>'') and (b<>'') then temp := a + ' + ' + b
      else temp := a + b;
      SubItems.Add(temp);

      SubItems.Add(GetZoneOrSortAcronym(MyTempQuery.FieldByName('ZoneOrSort').AsInteger));
    end;
    MyTempQuery.Next;
  end;
  MyTempQuery.Close;
  lvItemStarts.Items.EndUpdate;

  // Objective of
  MyTempQuery.SQL.Text := Format('Select * from quest_template ' +
                                 ' where RequiredItemId1 = %0:s OR' +
                                 ' RequiredItemId2 = %0:s OR RequiredItemId3 = %0:s OR' +
                                 ' RequiredItemId4 = %0:s ',[Entry]);
  MyTempQuery.Open;
  lvItemObjectiveOf.Items.BeginUpdate;
  lvItemObjectiveOf.Items.Clear;
  while not MyTempQuery.Eof do
  begin
    with lvItemObjectiveOf.Items.Add do
    begin
      Caption := MyTempQuery.FieldByName('Id').AsString;
      SubItems.Add(MyTempQuery.FieldByName('title').AsString);
      SubItems.Add(MyTempQuery.FieldByName('Level').AsString);
      SubItems.Add(GetRaceAcronym(MyTempQuery.FieldByName('RequiredRaces').AsInteger));

      //Rewards
      a := '';    b := '';
      if MyTempQuery.FieldByName('RewardMoneyMaxLevel').AsInteger>0 then a := MyTempQuery.FieldByName('RewardMoneyMaxLevel').AsString + ' MML';
      if MyTempQuery.FieldByName('RewardOrRequiredMoney').AsInteger>0 then b := MyTempQuery.FieldByName('RewardOrRequiredMoney').AsString + 'c';
      if (a<>'') and (b<>'') then temp := a + ' + ' + b
      else temp := a + b;
      SubItems.Add(temp);

      SubItems.Add(GetZoneOrSortAcronym(MyTempQuery.FieldByName('ZoneOrSort').AsInteger));
    end;
    MyTempQuery.Next;
  end;
  MyTempQuery.Close;
  lvItemObjectiveOf.Items.EndUpdate;

  // Source for
  MyTempQuery.SQL.Text := Format('Select * from quest_template ' +
                                 ' where RequiredSourceItemId1 = %0:s OR' +
                                 ' RequiredSourceItemId2 = %0:s OR RequiredSourceItemId3 = %0:s OR' +
                                 ' RequiredSourceItemId4 = %0:s ',[Entry]);
  MyTempQuery.Open;
  lvItemSourceFor.Items.BeginUpdate;
  lvItemSourceFor.Items.Clear;
  while not MyTempQuery.Eof do
  begin
    with lvItemSourceFor.Items.Add do
    begin
      Caption := MyTempQuery.FieldByName('Id').AsString;
      SubItems.Add(MyTempQuery.FieldByName('title').AsString);
      SubItems.Add(MyTempQuery.FieldByName('Level').AsString);
      SubItems.Add(GetRaceAcronym(MyTempQuery.FieldByName('RequiredRaces').AsInteger));

      //Rewards
      a := '';    b := '';
      if MyTempQuery.FieldByName('RewardMoneyMaxLevel').AsInteger>0 then a := MyTempQuery.FieldByName('RewardMoneyMaxLevel').AsString + ' MML';
      if MyTempQuery.FieldByName('RewardOrRequiredMoney').AsInteger>0 then b := MyTempQuery.FieldByName('RewardOrRequiredMoney').AsString + 'c';
      if (a<>'') and (b<>'') then temp := a + ' + ' + b
      else temp := a + b;
      SubItems.Add(temp);

      SubItems.Add(GetZoneOrSortAcronym(MyTempQuery.FieldByName('ZoneOrSort').AsInteger));
    end;
    MyTempQuery.Next;
  end;
  MyTempQuery.Close;
  lvItemSourceFor.Items.EndUpdate;

  // Provided for
  MyTempQuery.SQL.Text := Format('Select * from quest_template ' +
                                 ' where SourceItemId = %s ',[Entry]);
  MyTempQuery.Open;
  lvItemProvidedFor.Items.BeginUpdate;
  lvItemProvidedFor.Items.Clear;
  while not MyTempQuery.Eof do
  begin
    with lvItemProvidedFor.Items.Add do
    begin
      Caption := MyTempQuery.FieldByName('Id').AsString;
      SubItems.Add(MyTempQuery.FieldByName('title').AsString);
      SubItems.Add(MyTempQuery.FieldByName('Level').AsString);
      SubItems.Add(GetRaceAcronym(MyTempQuery.FieldByName('RequiredRaces').AsInteger));

      //Rewards
      a := '';    b := '';
      if MyTempQuery.FieldByName('RewardMoneyMaxLevel').AsInteger>0 then a := MyTempQuery.FieldByName('RewardMoneyMaxLevel').AsString + ' MML';
      if MyTempQuery.FieldByName('RewardOrRequiredMoney').AsInteger>0 then b := MyTempQuery.FieldByName('RewardOrRequiredMoney').AsString + 'c';
      if (a<>'') and (b<>'') then temp := a + ' + ' + b
      else temp := a + b;
      SubItems.Add(temp);

      SubItems.Add(GetZoneOrSortAcronym(MyTempQuery.FieldByName('ZoneOrSort').AsInteger));
    end;
    MyTempQuery.Next;
  end;
  MyTempQuery.Close;
  lvItemProvidedFor.Items.EndUpdate;

  // Reward from
  MyTempQuery.SQL.Text := Format('Select * from quest_template ' +
                                 ' where RewardChoiceItemId1 = %0:s OR' +
                                 ' RewardChoiceItemId2 = %0:s OR RewardChoiceItemId3 = %0:s OR' +
                                 ' RewardChoiceItemId4 = %0:s OR RewardChoiceItemId5 = %0:s OR' +
                                 ' RewardItemId2 = %0:s OR RewardItemId3 = %0:s OR' +
                                 ' RewardItemId4 = %0:s OR RewardItemId1 = %0:s OR' +
                                 ' RewardChoiceItemId6 = %0:s ',[Entry]);
  MyTempQuery.Open;
  lvItemRewardFrom.Items.BeginUpdate;
  lvItemRewardFrom.Items.Clear;
  while not MyTempQuery.Eof do
  begin
    with lvItemRewardFrom.Items.Add do
    begin
      Caption := MyTempQuery.FieldByName('Id').AsString;
      SubItems.Add(MyTempQuery.FieldByName('title').AsString);
      SubItems.Add(MyTempQuery.FieldByName('Level').AsString);
      SubItems.Add(GetRaceAcronym(MyTempQuery.FieldByName('RequiredRaces').AsInteger));

      //Rewards
      a := '';    b := '';
      if MyTempQuery.FieldByName('RewardMoneyMaxLevel').AsInteger>0 then a := MyTempQuery.FieldByName('RewardMoneyMaxLevel').AsString + ' MML';
      if MyTempQuery.FieldByName('RewardOrRequiredMoney').AsInteger>0 then b := MyTempQuery.FieldByName('RewardOrRequiredMoney').AsString + 'c';
      if (a<>'') and (b<>'') then temp := a + ' + ' + b
      else temp := a + b;
      SubItems.Add(temp);

      SubItems.Add(GetZoneOrSortAcronym(MyTempQuery.FieldByName('ZoneOrSort').AsInteger));
    end;
    MyTempQuery.Next;
  end;
  MyTempQuery.Close;
  lvItemRewardFrom.Items.EndUpdate;

  tsItemStarts.TabVisible := lvItemStarts.Items.Count <> 0;
  tsItemSourceFor.TabVisible := lvItemSourceFor.Items.Count <> 0;
  tsItemObjectiveOf.TabVisible := lvItemObjectiveOf.Items.Count <> 0;
  tsItemProvidedFor.TabVisible := lvItemProvidedFor.Items.Count <> 0;
  tsItemRewardFrom.TabVisible := lvItemRewardFrom.Items.Count <> 0;
end;

function TMainForm.GetZoneOrSortAcronym(ZoneOrSort: integer): string;
begin
  Result := '';
  if ZoneOrSort > 0 then
    Result := GetValueFromDBC('AreaTable', ZoneOrSort, 11)
  else if ZoneOrSort < 0 then
    Result := GetValueFromDBC('QuestSort', -ZoneOrSort);
end;

procedure TMainForm.edctnpcflagButtonClick(Sender: TObject);
begin
  GetSomeFlags(Sender, 'NPCFlags');
end;

procedure TMainForm.edctrankButtonClick(Sender: TObject);
begin
  GetValueFromSimpleList(Sender, 83, 'Rank', false);
end;

procedure TMainForm.edctfamilyButtonClick(Sender: TObject);
begin
  GetValueFromSimpleList(Sender, 84, 'CreatureFamily', false);
end;

procedure TMainForm.GetMechanicImmuneMask(Sender: TObject);
begin
  GetSomeFlags(Sender, 'Mechanic');
end;

procedure TMainForm.GetInhabitType(Sender: TObject);
begin
  GetValueFromSimpleList(Sender, 0, 'CreatureInhabitType', false);
end;

procedure TMainForm.GetMovementType(Sender: TObject);
begin
  GetValueFromSimpleList(Sender, 0, 'CreatureMovementType', false);
end;

procedure TMainForm.GetCreatureFlag1(Sender: TObject);
begin
  GetSomeFlags(Sender, 'CreatureFlag1');
end;

procedure TMainForm.GetSomeFlags(Sender: TObject; What: string);
var
  edEdit: TJvComboEdit;
  F: TUnitFlagsForm;
begin
  if Sender is TJvComboEdit then
  begin
    edEdit := TJvComboEdit(Sender);
    F := TUnitFlagsForm.Create(Self);
    try
      F.Load(What);
      if (edEdit.Text<>'') and (edEdit.Text<>'0') then F.Prepare(edEdit.Text);
      if F.ShowModal=mrOk then edEdit.Text := IntToStr(F.Flags);
    finally
      F.Free;
    end;
  end;
end;

procedure TMainForm.GetUnitFlags(Sender: TObject);
begin
  GetSomeFlags(Sender, 'CreatureFlags');
end;

function TMainForm.GetValueFromDBC(Name: string; id: Cardinal; idx_str: integer = 1): WideString;
var
  i: integer;
  Dbc : TDBCFile;
  Fname : TFileName;
begin
  if Name = 'Spell' then
    Result := SpellsForm.GetSpellName(id)
  else
  begin
    Fname := WideFormat('%s\%s.dbc',[dmMain.DBCDir, Name]);
    if FileExists(Fname) then
    begin
      dbc := TDBCFile.Create;
      try
        Dbc.Load(Fname);
        for i := 0 to Dbc.recordCount - 1 do
        begin
          Dbc.setRecord(i);
          if Dbc.getUInt(0) = id then
          begin
            Result := dbc.getString(idx_str);
            break;
          end;
        end;
      finally
        Dbc.Free;
      end;
    end;
  end;
end;

procedure TMainForm.GetValueFromSimpleList(Sender: TObject; TextId: integer;
  Name: String; Sort: boolean);
var
  F: TListForm;
  i: integer;
begin
  if Assigned(edit) and (edit.Name<>TJvComboEdit(Sender).Name) then
  begin
    lvQuickList.Free;
    lvQuickList := nil;
  end;

  F := TListForm.Create(Self);
  try
    SetList(F.lvList, Name, Sort);
    i := F.lvList.Items.Count;
    if (i>0) and (i<=15) and (Name<>'SAI_SourceType') and (Name<>'ChrClasses') then
    begin
      if not Assigned(lvQuickList) then
      begin
        lvQuickList := TTntListView.Create(Self);
        lvQuickList.Visible := false;
        lvQuickList.Parent := TJvComboEdit(Sender).parent.parent;
        lvQuickList.ViewStyle := TViewStyle(vsReport);
        lvQuickList.ShowColumnHeaders := false;
        lvQuickList.BorderStyle := bsSingle;
        lvQuickList.RowSelect := True;
        lvQuickList.ReadOnly := True;
        lvQuickList.HideSelection := false;
        lvQuickList.Font.Name := F.lvList.Font.Name;
        with lvQuickList.Columns.Add do
          Width := 25;
        with lvQuickList.Columns.Add do
          Width := 315;
        lvQuickList.Width := 350;
        SetList(lvQuickList, Name, Sort);
        edit := TJvComboEdit(sender);
        QLPrepare;
        lvQuickList.Visible := true;
        lvQuickList.SetFocus;
      end
      else
      begin
        lvQuickList.Free;
        lvQuickList := nil;
      end;
    end
    else
    begin
      if TextId <> 0 then
        F.Caption := dmMain.Text[TextId]
      else
        F.Caption := Name;
      F.Prepare(TJvComboEdit(Sender).Text);
      if F.ShowModal = mrOk then
        TJvComboEdit(Sender).Text := F.lvList.Selected.Caption;

      if ((Name = 'QuestSort') AND ((Sender as TComponent).Name = 'edqtZoneOrSort')) then
        TJvComboEdit(Sender).Text := '-'+F.lvList.Selected.Caption;
      if ((Name = 'ChrClasses') AND ((Sender as TComponent).Name = 'edqtSkillOrClassMask')) then
        TJvComboEdit(Sender).Text := '-'+F.lvList.Selected.Caption;
    end;
  finally
    F.Free;
  end;
end;

procedure TMainForm.GetValueFromSimpleList2(Sender: TObject; TextId: integer;
  Name: String; Sort: boolean; id1: string);
var
  F: TListForm;
  Text: string;
begin
  F := TListForm.Create(Self);
  F.Caption := dmMain.Text[TextId];
  try
    SetList(F.lvList, Name, id1, sort);
    Text := TJvComboEdit(Sender).Text;
    if (Text<>'') then F.Prepare(Text);
    if F.ShowModal=mrOk then
      TJvComboEdit(Sender).Text := F.lvList.Selected.Caption;
  finally
    F.Free;
  end;
end;

procedure TMainForm.btNewCreatureClick(Sender: TObject);
begin
  lvSearchCreature.Selected := nil;
  ClearFields(ttNPC);
  SetDefaultFields(ttNPC);
  PageControl3.ActivePageIndex := 1;
end;

procedure TMainForm.edcttrainer_typeButtonClick(Sender: TObject);
begin
  GetValueFromSimpleList(Sender, 141, 'trainer_type', false);
end;

procedure TMainForm.GetRace(Sender: TObject);
begin
  GetValueFromSimpleList(Sender, 142, 'ChrRaces', false);
end;

procedure TMainForm.GetSpawnMask(Sender: TObject);
begin
GetSomeFlags(Sender, 'SpawnMaskFlags');
end;

function TMainForm.GetActionParamHint(ActionType: integer; ParamNo: integer): string;
begin
  if (ActionType >=1) and (ActionType<=38)  then
  begin
    case ActionType of
        1: begin
           Result:='This action is pretty straightforward. When activated, the ' +
         'creature will say the specified text.';

         case ParamNo of
           1: Result := 'The text ID to the localized text entry that the creature should say';
           2: Result := 'Not Used';
           3: Result := 'Not Used';
         end;
        end;

        2: begin
          Result := 'The same as above except that the creature will yell the specified text when the action is activated.';

         case ParamNo of
          1: Result := 'The text ID to the localized text entry that the creature should say';
          2: Result := 'Not Used';
          3: Result := 'Not Used';
         end;
        end;

        3: begin
        Result :='When activated, the creature will do a text emote using the specified text. A text emote is what you would regularly see by using the /me slash command. ';
          case ParamNo of
            1: Result := 'The text ID to the localized text entry that the creature should say';
            2: Result := 'Not Used';
            3: Result := 'Not Used';
          end;
        end;

        4: begin
        Result :='When activated, the creature will play the specified sound. ';
          case ParamNo of
            1: Result := 'The sound ID to be played. Sound IDs are contained in the DBC files';
            2: Result := 'Not Used';
            3: Result := 'Not Used';
          end;
        end;

        5:begin
        Result :='When activated, the creature will perform a visual emote. Unlike a text emote, a visual emote is one where the creature will actually move or perform a gesture. ';
          case ParamNo of
            1: Result := 'The emote ID that the creature should perform. Emote IDs are also contained in the DBC but they can be found in the mangos source as well';
            2: Result := 'Not Used';
            3: Result := 'Not Used';
          end;
        end;

       6: begin
       Result :='Similar to the ACTION_T_SAY action, when this action is activated, it will choose at random a text entry to say. This action needs all three parameters to be filled and it will pick a random entry from the three.';
        case ParamNo of
          1: Result := 'The text ID to the localized text entry that the creature should say as choice one.';
          2: Result := 'The text ID to the localized text entry that the creature should say as choice two.';
          3: Result := 'The text ID to the localized text entry that the creature should say as choice three.';
        end;
       end;

        7: begin
        Result :='Similar to the ACTION_T_YELL action, when this action is activated, it will choose at random a text entry to yell. This action needs all three parameters to be filled and it will pick a random entry from the three. ';
        case ParamNo of
          1: Result := 'The text ID to the localized text entry that the creature should say as choice one.';
          2: Result := 'The text ID to the localized text entry that the creature should say as choice two.';
          3: Result := 'The text ID to the localized text entry that the creature should say as choice three.';
        end;
       end;

        8:begin
        Result :='Similar to the ACTION_T_TEXTEMOTE action, when this action is activated, it will choose at random a text entry to emote. This action needs all three parameters to be filled and it will pick a random entry from the three.';
        case ParamNo of
          1: Result := 'The text ID to the localized text entry that the creature should say as choice one.';
          2: Result := 'The text ID to the localized text entry that the creature should say as choice two.';
          3: Result := 'The text ID to the localized text entry that the creature should say as choice three.';
        end;
       end;

        9:begin
        Result :='Similar to the ACTION_T_SOUND action, when this action is activated, it will choose at random a sound to play. This action needs all three parameters to be filled and it will pick a random entry from the three.';
        case ParamNo of
          1: Result := 'The text ID to the localized text entry that the creature should yell as choice one.';
          2: Result := 'The text ID to the localized text entry that the creature should yell as choice two.';
          3: Result := 'The text ID to the localized text entry that the creature should yell as choice three.';
        end;
       end;

        10:begin
        Result :='Similar to the ACTION_T_EMOTE action, when this action is activated, it will choose at random an emote ID to emote visually. This action needs all three parameters to be filled and it will pick a random entry from the three.';
        case ParamNo of
          1: Result := 'The text ID to the localized text entry that the creature should use for an emote as choice one.';
          2: Result := 'The text ID to the localized text entry that the creature should use for an emote as choice two. ';
          3: Result := 'The text ID to the localized text entry that the creature should use for an emote as choice three. ';
        end;
       end;

        11:begin
        Result :='When activated, the creature will cast a spell specified by a spell ID on a target specified by the target type. ';
        case ParamNo of
          1: Result := 'The spell ID to use for the cast. The value used in this field needs to be a valid spell ID.';
          2: Result := 'The target type defining who the creature should cast on. The value in this field needs to be a valid target type as specified in the reference tables below.';
          3: Result := 'This field can only be 0 or 1. If it is 1, then the spell cast will interrupt any spells that are already in the progress of being casted; otherwise if the creature is already casting a spell and this field is 0, then this action will be skipped.';
        end;
       end;

        12:begin
        Result :='When activated, the creature will summon another creature at the same spot as itself that will attack the specified target. ';
        case ParamNo of
          1: Result := 'The creature template ID to be summoned. The value here needs to be a valid creature template ID. ';
          2: Result := 'The target type defining who the summoned creature will attack. The value in this field needs to be a valid target type as specified in the reference tables below. NOTE: Using target type 0 will cause the summoned creature to not attack anyone. ';
          3: Result := 'The duration until the summoned creature should be unsummoned. The value in this field is in milliseconds or 0. If zero, then the creature will not be unsummoned until it leaves combat. ';
        end;
       end;
        13: begin
        Result :='When activated, this action will modify the threat of a target in the creature`s threat list by the specified percent. ';
        case ParamNo of
          1: Result := 'Threat percent that should be modified. The value in this field can range from -100 to +100. If it is negative, threat will be taken away and if positive, threat will be added. ';
          2: Result := 'The target type defining on whom the threat change should occur. The value in this field needs to be a valid target type as specified in the reference tables below. ';
          3: Result := 'Not Used';
        end;
       end;

        14: begin
        Result :='When activated, this action will modify the threat for everyone in the creature`s threat list by the specified percent. ';
        case ParamNo of
          1: Result := 'The percent that should be used in modifying everyone`s ' +
            'threat in the creature`s threat list. The value here can range from -100 to +100.' +
          'NOTE: Using -100 will cause the creature to reset everyone`s threat to 0 so that everyone has the same amount of threat. It does NOT make any changes as to who is in the threat list. ';
          2: Result := 'Not Used';
          3: Result := 'Not Used';
        end;
       end;

        15:begin
        Result :='When activated, this action will satisfy the external ' +
          'completion requirement for the quest for the specified target defined by the target type.' +
        'This action can only be used with player targets so it must be ensured that the target type will point to a player. ';
        case ParamNo of
          1: Result := 'The quest template ID. The value here must be a valid quest template ID. Furthermore, the quest should have SpecialFlags | 2 as it would need to be completed by an external event which is the activation of this action. ';
          2: Result := 'The target type defining whom the quest should be completed for. The value in this field needs to be a valid target type as specified in the reference tables below. ';
          3: Result := 'Not Used';
        end;
       end;

        16: begin
        Result :='When activated, this action will call CastedCreatureOrGO() function for the player. It can be used to give quest credit for casting a spell on the creature. ';
        case ParamNo of
          1: Result := 'The quest template ID. The value here must be a valid quest template ID. ';
          2: Result := 'The spell ID to use to simulate the cast. The value used in this field needs to be a valid spell ID. ';
          3: Result := 'The target type defining whom the quest credit should be given to. The value in this field needs to be a valid target type as specified in the reference tables below. ';
        end;
       end;

        17:begin
        Result :='When activated, this action can change the target`s unit field values. More information on the field value indeces can be found at character data. ';
        case ParamNo of
          1: Result := 'The index of the field number to be changed. Use character data for a list of indeces and what they control. Note that a creature shares the same indeces with a player except for the PLAYER_* ones. ';
          2: Result := 'The new value to be put in the field. ';
          3: Result := 'The target type defining for whom the unit field should be changed. The value in this field needs to be a valid target type as specified in the reference tables below. ';
        end;
       end;

        18:begin
        Result :='When activated, this action changes the target`s flags by adding (turning on) more flags. For example, this action can make the creature unattackable/unselectable if the right flags are used. ';
        case ParamNo of
          1: Result := 'The flag(s) to be set. Multiple flags can be set by using bitwise-OR on them (adding them together). ';
          2: Result := 'The target type defining for whom the flags should be changed. The value in this field needs to be a valid target type as specified in the reference tables below. ';
          3: Result := 'Not Used';
        end;
       end;

        19:begin
        Result :='When activated, this action changes the target`s flags by removing (turning off) flags. For example, this action can make the creature normal after it was unattackable/unselectable if the right flags are used. ';
        case ParamNo of
          1: Result := 'The flag(s) to be set. Multiple flags can be set by using bitwise-OR on them (adding them together). ';
          2: Result := 'The target type defining for whom the flags should be changed. The value in this field needs to be a valid target type as specified in the reference tables below. ';
          3: Result := 'Not Used';
        end;
       end;
        20:begin
        Result :='This action controls whether or not the creature should stop or start the auto melee attack. ';
        case ParamNo of
          1: Result := 'If zero, then the creature will stop its melee attacks.' +
          'If non-zero, then the creature will either continue its melee ' +
          'attacks (the action would then have no effect) or it will start its melee attacks on the target with the top threat if its melee attacks were previously stopped. ';
          2: Result := 'Not Used';
          3: Result := 'Not Used';
        end;
       end;

        21: begin
        Result :='This action controls whether or not the creature will always move towards its target. ';
        case ParamNo of
          1: Result := 'If zero, then the creature will stop its melee attacks.' +
          'If non-zero, then the creature will either continue its melee ' +
          'attacks (the action would then have no effect) or it will start its melee attacks on the target with the top threat if its melee attacks were previously stopped. ';
          2: Result := 'Not Used';
          3: Result := 'Not Used';
        end;
       end;

        22:begin
        Result :='When activated, this action sets the creature`s event to the specified value. ';
        case ParamNo of
          1: Result := 'The new phase to set the creature in. This number must be an integer between 0 and 31 inclusive. ';
          2: Result := 'Not Used';
          3: Result := 'Not Used';
        end;
       end;

        23:begin
        Result :='When activated, this action will increase (or decrease) the current creature`s phase. ';
        case ParamNo of
          1: Result := 'The number of phases to increase or decrease. Use negative values to decrease the current phase. After increasing or decreasing the phase by this action, the current phase must not be lower than 0 or exceed 31. ';
          2: Result := 'Not Used';
          3: Result := 'Not Used';
        end;
       end;

       24:begin
        Result :='When activated, the creature will immediately exit out of combat, clear its threat list, and move back to its spawn point. Basically, this action will reset the whole encounter. ';
        case ParamNo of
          1: Result := 'Not Used';
          2: Result := 'Not Used';
          3: Result := 'Not Used';
        end;
       end;

        25:begin
        Result :='When activated, the creature will try to flee from combat. Currently this is done by it casting a fear-like spell on itself called "Run Away". ';
        case ParamNo of
          1: Result := 'Not Used';
          2: Result := 'Not Used';
          3: Result := 'Not Used';
        end;
       end;

        26:begin
        Result :='This action does the same thing as the ACTION_T_QUEST_EVENT does but it does it for all players in the creature`s threat list. Note that if a player is not in its threat list for whatever reason, he/she won`t get the quest completed. ';
        case ParamNo of
          1: Result := 'The quest ID to finish for everyone. ';
          2: Result := 'Not Used';
          3: Result := 'Not Used';
        end;
       end;

        27:begin
        Result :='This action does the same thing as the ACTION_T_CASTCREATUREGO does but it does it for all players in the creature`s threat list. Note that if a player is not in its threat list for whatever reason, he/she won`t receive the cast emulation. ';
        case ParamNo of
          1: Result := 'The quest template ID. ';
          2: Result := 'The spell ID used to simulate the cast. ';
          3: Result := 'Not Used';
        end;
       end;

        28:begin
        Result :='This action will remove all auras from a specific spell from the target. ';
        case ParamNo of
          1: Result := 'The target type defining for whom the unit field should be changed. The value in this field needs to be a valid target type as specified in the reference tables below. ';
          2: Result := 'The spell ID whose auras will be removed.';
          3: Result := 'Not Used';
        end;
       end;

        29:begin
        Result :='This action changes the movement type generator to ranged type using the specified values for angle and distance. Note that specifying zero angle and distance will make it just melee instead. ';
        case ParamNo of
          1: Result := 'The distance the mob should keep between it and its target. ';
          2: Result := 'The angle the mob should use. ';
          3: Result := 'Not Used';
        end;
       end;

        30:begin
        Result :='Randomly sets the phase to one from the three parameter choices.';
        case ParamNo of
          1: Result := 'A possible random phase choice. ';
          2: Result := 'A possible random phase choice. ';
          3: Result := 'A possible random phase choice. ';
        end;
       end;

        31:begin
        Result :='Randomly sets the phase between a range of phases controlled by the parameters. ';
        case ParamNo of
          1: Result := 'The minimum of the phase range. ';
          2: Result := 'The maximum of the phase range. The number here must be greater than the one in parameter 1. ';
          3: Result := 'Not Used';
        end;
       end;

        32:begin
        Result :='Summons a creature using the data specified in the separate summons table. ';
        case ParamNo of
          1: Result := 'The creature template ID to be summoned. The value here needs to be a valid creature template ID. ';
          2: Result := 'The target type defining who the summoned creature will attack. The value in this field needs to be a valid target type as specified in the reference tables below. NOTE: Using target type 0 will cause the summoned creature to not attack anyone. ';
          3: Result := 'The summon ID from the eventai_summons table controlling the position (and spawntime) where the summoned mob should be spawned at. ';
        end;
       end;

        33:begin
        Result :='When activated, this action will call KilledMonster() function for the player.'+
        'It can be used to give creature credit for killing a creature (note that it can be ANY creature including certain quest specific triggers). In general if the quest is set to be accompished on different creatures (e.g. "Credit" templates). ';
        case ParamNo of
          1: Result := 'The creature template ID. The value here must be a valid creature template ID. ';
          2: Result := 'The target type defining whom the quest kill count should be given to. The value in this field needs to be a valid target type as specified in the reference tables below. ';
          3: Result := 'Not Used';
        end;
       end;

        34:begin
        Result :='Sets data for the instance. Note that this will only work when the creature is inside an instantiable zone that has a valid script (ScriptedInstance) assigned.';
        case ParamNo of
          1: Result := 'The field to change in the instance script. Again, this field needs to be a valid field that has been already defined in the instance`s script. ';
          2: Result := 'The value to put at that field index. The number here must be a valid 32 bit number.';
          3: Result := 'Not Used';
        end;
       end;

        35:begin
        Result :='Sets GUID (64 bits) data for the instance based on the target. Note that this will only work when the creature is inside an instantiable zone that has a valid script (ScriptedInstance) assigned. ';
        case ParamNo of
          1: Result := 'The field to change in the instance script. Again, this field needs to be a valid field that has been already defined in the instance`s script. ';
          2: Result := 'The target type to use to get the GUID that will be stored at the field index. The value in this field needs to be a valid target type as specified in the reference tables below. ';
          3: Result := 'Not Used';
        end;
       end;

        36:begin
        Result :='This function temporarily changes creature entry to new entry, display is changed, loot is changed, but AI is not changed. At respawn creature will be reverted to original entry. ';
        case ParamNo of
          1: Result := 'The creature template ID. The value here must be a valid creature template ID.';
          2: Result := 'Use model_id from team : Alliance(0) or Horde (1).';
          3: Result := 'Not Used';
        end;
       end;

        37:begin
        Result :='Kills the creature ';
        case ParamNo of
          1: Result := 'Not Used';
          2: Result := 'Not Used';
          3: Result := 'Not Used';
        end;
       end;

        38:begin
        Result :='Places all players within the instance into combat with the creature. Only works in combat and only works inside of instances.';
        case ParamNo of
          1: Result := 'Not Used';
          2: Result := 'Not Used';
          3: Result := 'Not Used';
        end;
       end;

    end;
  end
  else
    Result:='';
end;

procedure TMainForm.edcnaction1_typeChange(Sender: TObject);
begin
  edcnaction1_type.Hint := GetActionParamHint(StrToIntDef(edcnaction1_type.Text,1),-1);
  edcnaction1_param1.Hint := GetActionParamHint(StrToIntDef(edcnaction1_type.Text,-1),1);
  edcnaction1_param2.Hint := GetActionParamHint(StrToIntDef(edcnaction1_type.Text,-1),2);
  edcnaction1_param3.Hint := GetActionParamHint(StrToIntDef(edcnaction1_type.Text,-1),3);
end;

procedure TMainForm.edcnaction2_typeChange(Sender: TObject);
begin
  edcnaction2_type.Hint := GetActionParamHint(StrToIntDef(edcnaction1_type.Text,2),-1);
  edcnaction2_param1.Hint := GetActionParamHint(StrToIntDef(edcnaction2_type.Text,-1),1);
  edcnaction2_param2.Hint := GetActionParamHint(StrToIntDef(edcnaction2_type.Text,-1),2);
  edcnaction2_param3.Hint := GetActionParamHint(StrToIntDef(edcnaction2_type.Text,-1),3);
end;

procedure TMainForm.edcnaction3_typeChange(Sender: TObject);
begin
  edcnaction3_type.Hint := GetActionParamHint(StrToIntDef(edcnaction1_type.Text,3),-1);
  edcnaction3_param1.Hint := GetActionParamHint(StrToIntDef(edcnaction3_type.Text,-1),1);
  edcnaction3_param2.Hint := GetActionParamHint(StrToIntDef(edcnaction3_type.Text,-1),2);
  edcnaction3_param3.Hint := GetActionParamHint(StrToIntDef(edcnaction3_type.Text,-1),3);
end;

procedure TMainForm.edcnevent_typeChange(Sender: TObject);
var
  s: array [1..4] of string;
begin
   s[3] := 'RepeatMin';
   s[4] := 'RepeatMax';

  case StrToIntDef(edcnevent_type.Text,-1) of
    0,1:
    begin
      s[1] := 'InitialMin';
      s[2] := 'InitialMax';
    end;
    2,12:
    begin
      s[1] := 'HPMax%';
      s[2] := 'HPMin%';
    end;
    3:
    begin
      s[1] := 'ManaMax%';
      s[2] := 'ManaMin%';
    end;
    4,6,7,11:
    begin
      s[1] := 'n/a';
      s[2] := 'n/a';
      s[3] := 'n/a';
      s[4] := 'n/a';
    end;
    5,13:
    begin
      s[1] := 'RepeatMin';
      s[2] := 'RepeatMax';
      s[3] := 'n/a';
      s[4] := 'n/a';
    end;
    8:
    begin
      s[1] := 'SpellID';
      s[2] := 'School';
    end;
    9:
    begin
      s[1] := 'MinDist';
      s[2] := 'MaxDist';
    end;
    10:
    begin
      s[1] := 'NoHostile';
      s[2] := 'NoFriendly';
    end;
    14:
    begin
      s[1] := 'HPDeficit';
      s[2] := 'Radius';
    end;
    15:
    begin
      s[1] := 'DispelType';
      s[2] := 'Radius';
    end;
    16:
    begin
      s[1] := 'SpellId';
      s[2] := 'Radius';
    end;
    17:
    begin
      s[1] := 'CreatureId';
      s[2] := 'RepeatMin';
      s[3] := 'RepeatMax';
      s[4] := 'n/a';
    end;
    else
    begin
      s[1] := '';
      s[2] := '';
      s[3] := '';
      s[4] := '';
    end;
  end;
  edcnevent_param1.Hint := s[1];
  edcnevent_param2.Hint := s[2];
  edcnevent_param3.Hint := s[3];
  edcnevent_param4.Hint := s[4];
end;

procedure TMainForm.GetActionType(Sender: TObject);
begin
  GetValueFromSimpleList(Sender, 0, 'ActionType', false);
end;

procedure TMainForm.GetEventType(Sender: TObject);
begin
  GetValueFromSimpleList(Sender, 0, 'EventType', false);
end;

procedure TMainForm.GetSAIEventType(Sender: TObject);
begin
  GetValueFromSimpleList(Sender, 0, 'SAI_EventType', false);
  SetSAIEvent(StrToIntDef(edcyevent_type.Text,0));
end;

procedure TMainForm.GetSAIActionType(Sender: TObject);
begin
  GetValueFromSimpleList(Sender, 0, 'SAI_ActionType', false);
  SetSAIAction(StrToIntDef(edcyaction_type.Text,0));
end;

procedure TMainForm.GetSAISummonType(Sender: TObject);
begin
  GetValueFromSimpleList(Sender, 0, 'SAI_SummonType', false);
end;

procedure TMainForm.GetSAIReactState(Sender: TObject);
begin
  GetValueFromSimpleList(Sender, 0, 'SAI_ReactState', false);
end;

procedure TMainForm.GetSAISourceType(Sender: TObject);
begin
  GetValueFromSimpleList(Sender, 0, 'SAI_SourceType', false);
end;

procedure TMainForm.GetSAITargetType(Sender: TObject);
begin
  GetValueFromSimpleList(Sender, 0, 'SAI_TargetType', false);
  SetSAITarget(StrToIntDef(edcytarget_type.Text,0));
end;

procedure TMainForm.GetSAIEventFlags(Sender: TObject);
begin
  GetSomeFlags(Sender, 'SAI_EventFlags');
end;

procedure TMainForm.GetSAICastFlags(Sender: TObject);
begin
  GetSomeFlags(Sender, 'SAI_CastFlags');
end;

procedure TMainForm.GetArea(Sender: TObject);
begin
  if not (Sender is TJvComboEdit) then Exit;
  AreaTableForm.Prepare(TJvComboEdit(Sender).Text);
  if AreaTableForm.ShowModal=mrOk then
    TJvComboEdit(Sender).Text := AreaTableForm.lvList.Selected.Caption;
end;

procedure TMainForm.GetClass(Sender: TObject);
begin
  GetValueFromSimpleList(Sender, 143, 'ChrClasses', false);
end;

procedure TMainForm.edcttypeButtonClick(Sender: TObject);
begin
  GetValueFromSimpleList(Sender, 85, 'CreatureType', false);
end;

procedure TMainForm.lvCharacterInventoryChange(Sender: TObject; Item: TListItem;
  Change: TItemChange);
begin
  btCharInvUpd.Enabled := Assigned(TJvListView(Sender).Selected);
  btCharInvDel.Enabled := Assigned(TJvListView(Sender).Selected);
end;

procedure TMainForm.lvCharacterInventorySelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
begin
  if Selected then with Item do
  begin
    edhiguid.Text := Caption;
    edhibag.Text := SubItems[0];
    edhislot.Text := SubItems[1];
    edhiitem.Text := SubItems[2];
  end;
end;

procedure TMainForm.lvclCreatureLocationSelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
begin
  if Selected then
  begin
    LoadCreatureLocation(StrToIntDef(Item.Caption,0));
    LoadCreatureMovement(StrToIntDef(Item.Caption,0));
    LoadCreatureAddon(StrToIntDef(Item.Caption,0));
  end;
end;

procedure TMainForm.lvcmMovementChange(Sender: TObject; Item: TListItem; Change: TItemChange);
begin
  btCreatureMvmntUpd.Enabled := Assigned(TJvListView(Sender).Selected);
  btCreatureMvmntDel.Enabled := Assigned(TJvListView(Sender).Selected);
end;

procedure TMainForm.lvcmMovementSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
begin
  if Selected then
    SetMvmntEditFields('edcm', lvcmMovement);
end;

procedure TMainForm.lvcnEventAIChange(Sender: TObject; Item: TListItem;
  Change: TItemChange);
begin
 btEventAIUpd.Enabled := Assigned(TJvListView(Sender).Selected);
 btEventAIDel.Enabled := Assigned(TJvListView(Sender).Selected);
end;

procedure TMainForm.lvcnEventAISelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
begin
  if Selected then
   SetEventAIEditFields('edcn', lvcnEventAI);
end;

procedure TMainForm.lvcySmartAISelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
begin
  if Selected then
   SetSmartAIEditFields('edcy', lvcySmartAI);
end;

procedure TMainForm.lvcySmartAIChange(Sender: TObject; Item: TListItem;
  Change: TItemChange);
begin
 btSmartAIUpd.Enabled := Assigned(TJvListView(Sender).Selected);
 btSmartAIDel.Enabled := Assigned(TJvListView(Sender).Selected);
end;

procedure TMainForm.LoadCreatureLocation(GUID: integer);
begin
  if GUID<1 then Exit;
  MyQuery.SQL.Text := Format('SELECT * FROM `creature` WHERE (`guid`=%d)',[GUID]);
  MyQuery.Open;
  try
    FillFields(MyQuery, PFX_CREATURE);
    MyQuery.Close;
  except
    on E: Exception do
      raise Exception.Create(dmMain.Text[86]+#10#13+E.Message);
  end;
end;

procedure TMainForm.LoadCreatureMovement(GUID: integer);
begin
    //LoadQueryToListView(Format('SELECT * FROM `creature_movement` WHERE (`id` = %d)',
    //  [GUID]),lvcmMovement); -- currently disabled; mangos had an inferior waypoint system
end;

procedure TMainForm.LoadCreatureOnKillReputation(id: string);
begin
  MyQuery.SQL.Text := Format('SELECT * FROM `creature_onkill_reputation` WHERE (`creature_id`=%s)',[QuotedStr(id)]);
  MyQuery.Open;
  try
    FillFields(MyQuery, PFX_CREATURE_ONKILL_REPUTATION);
    MyQuery.Close;
  except
    on E: Exception do
      raise Exception.Create(dmMain.Text[86]+#10#13+E.Message);
  end;
end;

procedure TMainForm.LoadCreaturesAndGOForGameEvent(entry: string);
begin
  MyTempQuery.SQL.Text  := 
    Format('SELECT gec.guid, gec.eventEntry, ct.entry, ct.name FROM `game_event_creature` gec '+
          'LEFT OUTER JOIN creature c on c.guid = gec.guid ' +
          'LEFT OUTER JOIN creature_template ct on ct.entry = c.id ' +
          'WHERE abs(`eventEntry`) = %s',[entry]);
  MyTempQuery.Open;
  lvGameEventCreature.Items.BeginUpdate;
  try
    lvGameEventCreature.Items.Clear;
    while not MyTempQuery.Eof do
    begin
      with lvGameEventCreature.Items.Add do
      begin
        Caption := MyTempQuery.fields[0].AsString;
        SubItems.Add(MyTempQuery.fields[1].AsString);
        SubItems.Add(MyTempQuery.fields[2].AsString);
        SubItems.Add(MyTempQuery.fields[3].AsString);
        MyTempQuery.Next;
      end;
    end;
  finally
    lvGameEventCreature.Items.EndUpdate;
  end;
  MyTempQuery.Close;

  MyTempQuery.SQL.Text  := 
    Format('SELECT gec.guid, gec.eventEntry, ct.entry, ct.name FROM `game_event_gameobject` gec '+
          'LEFT OUTER JOIN gameobject c on c.guid = gec.guid ' +
          'LEFT OUTER JOIN gameobject_template ct on ct.entry = c.id ' +
          'WHERE abs(`eventEntry`)=%s',[entry]);
  MyTempQuery.Open;
  lvGameEventGO.Items.BeginUpdate;
  try
    lvGameEventGO.Items.Clear;
    while not MyTempQuery.Eof do
    begin
      with lvGameEventGO.Items.Add do
      begin
        Caption := MyTempQuery.fields[0].AsString;
        SubItems.Add(MyTempQuery.fields[1].AsString);
        SubItems.Add(MyTempQuery.fields[2].AsString);
        SubItems.Add(MyTempQuery.fields[3].AsString);
        MyTempQuery.Next;
      end;
    end;
  finally
    lvGameEventGO.Items.EndUpdate;
  end;
  MyTempQuery.Close;  
end;

procedure TMainForm.LoadCreatureTemplateAddon(entry: integer);
begin
  if entry<1 then Exit;
  MyQuery.SQL.Text := Format('SELECT * FROM `creature_template_addon` WHERE (`entry`=%d)',[entry]);
  MyQuery.Open;
  try
    FillFields(MyQuery, PFX_CREATURE_TEMPLATE_ADDON);
    MyQuery.Close;
  except
    on E: Exception do
      raise Exception.Create(dmMain.Text[149]+#10#13+E.Message);
  end;
end;

procedure TMainForm.LoadCreatureAddon(GUID: integer);
begin
  if GUID<1 then Exit;
  MyQuery.SQL.Text := Format('SELECT * FROM `creature_addon` WHERE (`guid`=%d)',[GUID]);
  MyQuery.Open;
  try
    FillFields(MyQuery, PFX_CREATURE_ADDON);
    MyQuery.Close;
  except
    on E: Exception do
      raise Exception.Create(dmMain.Text[139]+#10#13+E.Message);
  end;
end;

procedure TMainForm.LoadCreatureEquip(ENTRY: integer);
begin
  if ENTRY<1 then Exit;
  MyQuery.SQL.Text := Format('SELECT * FROM `creature_equip_template` WHERE (`entry`=%d)',[ENTRY]);
  MyQuery.Open;
  try
    FillFields(MyQuery, PFX_CREATURE_EQUIP_TEMPLATE);
    MyQuery.Close;
  except
    on E: Exception do
      raise Exception.Create(dmMain.Text[139]+#10#13+E.Message);
  end;
end;

procedure TMainForm.btScriptCreatureClick(Sender: TObject);
begin
  PageControl3.ActivePageIndex := SCRIPT_TAB_NO_CREATURE;
end;

procedure TMainForm.GetLootCondition(Sender: TObject);
begin
  //GetValueFromSimpleList(Sender, 156, 'LootMode', false);
  GetSomeFlags(Sender, 'LootMode');
end;

procedure TMainForm.CompleteButtonScriptScript;
begin
  megoScript.Text := ScriptSQLScript(lvgbButtonScript, 'gameobject_scripts', edgbGUID.Text);
end;

procedure TMainForm.CompleteCharacterInventoryScript;
var
  guid, Fields, Values: string;
begin
  mehtScript.Clear;
  guid := edhiitem.Text;
  if Trim(guid) = '' then exit;
  SetFieldsAndValues(MyQuery, Fields, Values, ''+CharDBName+'`.`character_inventory', PFX_CHARACTER_INVENTORY, mehtLog);
  mehtScript.Text := Format('DELETE FROM `'+CharDBName+'`.`character_inventory` WHERE (`item`=%s);'#13#10+
    'INSERT INTO `'+CharDBName+'`.`character_inventory` (%s) VALUES (%s);'#13#10,[guid, Fields, Values]);
end;

procedure TMainForm.CompleteCharacterScript;
var
  guid, Fields, Values: string;
begin
  mehtLog.Clear;
  guid := edhtguid.Text;
  if guid='' then exit;
  SetFieldsAndValues(MyQuery, Fields, Values, ''+CharDBName+'`.`characters', PFX_CHARACTER, mehtLog);
  case SyntaxStyle of
    ssInsertDelete: mehtScript.Text := Format('DELETE FROM `'+CharDBName+'`.`characters` WHERE (`guid`=%s);'#13#10+
      'INSERT INTO `'+CharDBName+'`.`characters` (%s) VALUES (%s);'#13#10,[guid, Fields, Values]);
    ssReplace: mehtScript.Text := Format('REPLACE INTO `'+CharDBName+'`.`characters` (%s) VALUES (%s);'#13#10,[Fields, Values]);
    ssUpdate: mehtScript.Text := MakeUpdate(''+CharDBName+'`.`characters', PFX_CHARACTER, 'guid', guid);
  end;
end;

procedure TMainForm.CompleteCreatureAddonScript;
var
  caguid, Fields, Values: string;
begin
  mectLog.Clear;
  caguid := edcaguid.Text;
  if caguid='' then exit;
  SetFieldsAndValues(Fields, Values, 'creature_addon', PFX_CREATURE_ADDON, mectLog);
  mectScript.Text := Format('DELETE FROM `creature_addon` WHERE (`guid`=%s);'#13#10+
    'INSERT INTO `creature_addon` (%s) VALUES (%s);'#13#10,[caguid, Fields, Values]);
end;

procedure TMainForm.CompleteCreatureEquipTemplateScript;
var
  caguid, Fields, Values: string;
begin
  mectLog.Clear;
  caguid:= edceEntry.Text;
  if caguid='' then exit;
  SetFieldsAndValues(Fields, Values, 'creature_equip_template', PFX_CREATURE_EQUIP_TEMPLATE, mectLog);
  mectScript.Text := Format('DELETE FROM `creature_equip_template` WHERE (`entry`=%s);'#13#10+
    'INSERT INTO `creature_equip_template` (%s) VALUES (%s);'#13#10,[caguid, Fields, Values]);
end;

procedure TMainForm.CompleteLocalesQuest;
var
  lqentry : string;
begin
  meqtLog.Clear;
  lqentry:= edqtId.Text;
  if lqentry='' then exit;
  meqtScript.Text := MakeUpdateLocales('locales_quest', PFX_LOCALES_QUEST, 'Id', lqentry);
end;

procedure TMainForm.CompleteCreatureEventAIScript;
var
  id, Fields, Values: string;
begin
  mectLog.Clear;
  id := edcnid.Text;
  if id='' then exit;
  SetFieldsAndValues(MyQuery, Fields, Values, 'creature_ai_scripts', PFX_CREATURE_EVENTAI, mectLog);
  case SyntaxStyle of
    ssInsertDelete: mectScript.Text := Format('DELETE FROM `creature_ai_scripts` WHERE (`id`=%s);'#13#10+
      'INSERT INTO `creature_ai_scripts` (%s) VALUES (%s);'#13#10,[id, Fields, Values]);
    ssReplace: mectScript.Text := Format('REPLACE INTO `creature_ai_scripts` (%s) VALUES (%s);'#13#10,[Fields, Values]);
    ssUpdate: mectScript.Text := MakeUpdate('creature_ai_scripts', PFX_CREATURE_EVENTAI, 'id', id);
  end;
end;

procedure TMainForm.CompleteCreatureModelInfoScript;
var
  caguid, Fields, Values: string;
begin
  mectLog.Clear;
  caguid := edcimodelid.Text;
  if caguid='' then exit;
  SetFieldsAndValues(Fields, Values, 'creature_model_info', PFX_CREATURE_MODEL_INFO, mectLog);
  mectScript.Text := Format('DELETE FROM `creature_model_info` WHERE (`modelid`=%s);'#13#10+
    'INSERT INTO `creature_model_info` (%s) VALUES (%s);'#13#10,[caguid, Fields, Values]);
end;

procedure TMainForm.CompleteCreatureMovementScript;
{
var
  caguid,cmpoint, Fields, Values: string;
}
begin
  {mectLog.Clear;
  caguid := trim( edcmid.Text );
  cmpoint := trim( edcmpoint.Text );
  if (caguid='') or (cmpoint='') then exit;
  SetFieldsAndValues(Fields, Values, 'creature_movement', PFX_CREATURE_MOVEMENT, mectLog);
  mectScript.Text := Format('DELETE FROM `creature_movement` WHERE (`id`=%s) AND (`point`=%s);'#13#10+
      'INSERT INTO `creature_movement` (%s) VALUES (%s);'#13#10,[caguid, cmpoint, Fields, Values]); }
  //disable creature_movement
end;

procedure TMainForm.CompleteCreatureOnKillReputationScript;
var
  entry, Fields, Values: string;
begin
  mectLog.Clear;
  entry := trim(edctEntry.Text);
  if entry='' then exit;
  SetFieldsAndValues(Fields, Values, 'creature_onkill_reputation', PFX_CREATURE_ONKILL_REPUTATION, mectLog);
  case SyntaxStyle of
    ssInsertDelete: mectScript.Text := Format('DELETE FROM `creature_onkill_reputation` WHERE (`creature_id`=%s);'#13#10+
      'INSERT INTO `creature_onkill_reputation` (%s) VALUES (%s);'#13#10,[entry, Fields, Values]);
    ssReplace: mectScript.Text := Format('REPLACE INTO `creature_onkill_reputation` (%s) VALUES (%s);'#13#10,[Fields, Values]);
    ssUpdate: mectScript.Text := MakeUpdate('creature_onkill_reputation', PFX_CREATURE_ONKILL_REPUTATION, 'creature_id', entry);
  end;
end;

procedure TMainForm.CompleteCreatureLocationScript;
var
  clguid, Fields, Values: string;
begin
  mectLog.Clear;
  clguid := edclguid.Text;
  if clguid='' then exit;
  SetFieldsAndValues(Fields, Values, 'creature', PFX_CREATURE, mectLog);
  case SyntaxStyle of
    ssInsertDelete: mectScript.Text := Format('DELETE FROM `creature` WHERE (`guid`=%s);'#13#10+
      'INSERT INTO `creature` (%s) VALUES (%s);'#13#10,[clguid, Fields, Values]);
    ssReplace: mectScript.Text := Format('REPLACE INTO `creature` (%s) VALUES (%s);'#13#10,[Fields, Values]);
    ssUpdate: mectScript.Text := MakeUpdate('creature', PFX_CREATURE, 'guid', clguid);
  end;
end;

procedure TMainForm.CompleteCreatureLootScript;
var
  coentry, coitem, Fields, Values: string;
begin
  mectLog.Clear;
  coentry :=  edcoentry.Text;
  coitem := edcoitem.Text;
  if (coentry='') or (coitem='') then Exit;
  SetFieldsAndValues(Fields, Values, 'creature_loot_template', PFX_CREATURE_LOOT_TEMPLATE, mectLog);
  mectScript.Text := Format('DELETE FROM `creature_loot_template` WHERE (`entry`=%s) AND (`item`=%s);'#13#10+
    'INSERT INTO `creature_loot_template` (%s) VALUES (%s);'#13#10,[coentry, coitem, Fields, Values])
end;

procedure TMainForm.CompletePickpocketLootScript;
var
  cpentry, cpitem, Fields, Values: string;
begin
  mectLog.Clear;
  cpentry :=  edcpentry.Text;
  cpitem := edcpitem.Text;
  if (cpentry='') or (cpitem='') then Exit;
  SetFieldsAndValues(Fields, Values, 'pickpocketing_loot_template', PFX_PICKPOCKETING_LOOT_TEMPLATE, mectLog);
  mectScript.Text := Format('DELETE FROM `pickpocketing_loot_template` WHERE (`entry`=%s) AND (`item`=%s);'#13#10+
   'INSERT INTO `pickpocketing_loot_template` (%s) VALUES (%s);'#13#10,[cpentry, cpitem, Fields, Values])
end;

procedure TMainForm.CompleteSkinLootScript;
var
  csentry, csitem, Fields, Values: string;
begin
  mectLog.Clear;
  csentry :=  edcsentry.Text;
  csitem := edcsitem.Text;
  if (csentry='') or (csitem='') then Exit;
  SetFieldsAndValues(Fields, Values, 'skinning_loot_template', PFX_SKINNING_LOOT_TEMPLATE, mectLog);
  mectScript.Text := Format('DELETE FROM `skinning_loot_template` WHERE (`entry`=%s) AND (`item`=%s);'#13#10+
    'INSERT INTO `skinning_loot_template` (%s) VALUES (%s);'#13#10,[csentry, csitem, Fields, Values])
end;

function TMainForm.Connect: boolean;
var
  F: TMeConnectForm;
begin
  F := TMeConnectForm.Create(Self);
  try
    if F.ShowModal = mrOk then
      Result := true
    else
    begin
      Result := false;
      if not MyTrinityConnection.Connected then
        Application.Terminate;
    end;
  finally
    F.Free;
  end;
end;

function TMainForm.CreateVer(Ver: integer): string;
var
  a, b, c: integer;
begin
  a := ver div 10000;
  b := (ver - a*10000) div 100;
  c := ver - a*10000 - b*100;
  Result := Format('%d.%d.%d', [a,b,c]);
end;

function TMainForm.CurVer: integer;
begin
  Result := StrToInt(VERSION_1)*10000 +  StrToInt(VERSION_2)*100 +  StrToInt(VERSION_3); 
end;

procedure TMainForm.lvGameEventCreatureChange(Sender: TObject; Item: TListItem; Change: TItemChange);
begin
  btgeCreatureGuidDel.Enabled := Assigned(TJvListView(Sender).Selected);
  btgeCreatureGuidInv.Enabled := Assigned(TJvListView(Sender).Selected);
end;

procedure TMainForm.lvGameEventCreatureDblClick(Sender: TObject);
begin
  if assigned(lvGameEventCreature.Selected) then
  begin
    edctEntry.Text := lvGameEventCreature.Selected.SubItems[1];
    edctEntry.Button.Click;
    PageControl1.ActivePageIndex := 1;
    PageControl3.ActivePageIndex := 1;
  end;
end;

procedure TMainForm.lvGameEventCreatureSelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
begin
  if Selected then
    edgeCreatureGuid.Text := Item.Caption;
end;

procedure TMainForm.lvGameEventGOChange(Sender: TObject; Item: TListItem; Change: TItemChange);
begin
  btgeGOguidDel.Enabled := Assigned(TJvListView(Sender).Selected);
  btgeGOGuidInv.Enabled := Assigned(TJvListView(Sender).Selected);  
end;

procedure TMainForm.lvGameEventGODblClick(Sender: TObject);
begin
  if assigned(lvGameEventGO.Selected) then
  begin
    edgtentry.Text := lvGameEventGO.Selected.SubItems[1];
    edgtentry.Button.Click;
    PageControl1.ActivePageIndex := 2;
    PageControl4.ActivePageIndex := 1;
  end;
end;

procedure TMainForm.lvGameEventGOSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
begin
  if Selected then
    edgeGOguid.Text := Item.Caption;
end;

procedure TMainForm.CompleteNPCVendorScript;
var
  cventry, cvitem, Fields, Values: string;
begin
  mectLog.Clear;
  cventry :=  edcventry.Text;
  cvitem := edcvitem.Text;
  if (cventry='') or (cvitem='') then Exit;
  SetFieldsAndValues(Fields, Values, 'npc_vendor', PFX_NPC_VENDOR, mectLog);
  mectScript.Text := Format('DELETE FROM `npc_vendor` WHERE (`entry`=%s) AND (`item`=%s);'#13#10+
   'INSERT INTO `npc_vendor` (%s) VALUES (%s);'#13#10,[cventry, cvitem, Fields, Values])
end;

procedure TMainForm.CompleteNPCTrainerScript;
var
  crentry, crspell, Fields, Values: string;
begin
  mectLog.Clear;
  crentry :=  edcrentry.Text;
  crspell := edcrspell.Text;
  if (crentry='') or (crspell='') then Exit;
  SetFieldsAndValues(Fields, Values, 'npc_trainer', PFX_NPC_TRAINER, mectLog);
  mectScript.Text := Format('DELETE FROM `npc_trainer` WHERE (`entry`=%s) AND (`spell`=%s);'#13#10+
   'INSERT INTO `npc_trainer` (%s) VALUES (%s);'#13#10,[crentry, crspell, Fields, Values])
end;

procedure TMainForm.lvcoCreatureLootSelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
begin
  if Selected then
    SetLootEditFields('edco', lvcoCreatureLoot);
end;

procedure TMainForm.lvcoPickpocketLootSelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
begin
  if Selected then
    SetLootEditFields('edcp', lvcoPickpocketLoot);
end;

procedure TMainForm.lvcoSkinLootSelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
begin
  if Selected then
    SetLootEditFields('edcs', lvcoSkinLoot);
end;

procedure TMainForm.lvCreatureModelSearchSelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
begin
  if Selected then
    SetCreatureModelEditFields('edci', lvCreatureModelSearch);
end;

procedure TMainForm.lvCreatureStartsEndsDblClick(Sender: TObject);
begin
  PageControl1.ActivePageIndex := 0;
  PageControl2.ActivePageIndex := 1;
  if Assigned(TJvListView(Sender).Selected) then
    LoadQuest(StrToInt(TJvListView(Sender).Selected.Caption));
end;

{--------  GAMEOBJECT stuff -----------}

procedure TMainForm.btClearSearchGOClick(Sender: TObject);
begin
  edSearchGOEntry.Clear;
  edSearchGOName.Clear;
  edSearchGOtype.Clear;
  edSearchGOfaction.Clear;
  lvSearchGO.Clear;
end;

procedure TMainForm.btSearchGameEventClick(Sender: TObject);
begin
  SearchGameEvent();
  with lvSearchGameEvent do
    if Items.Count>0 then
    begin
      SetFocus;
      Selected := Items[0];
    end;
end;

procedure TMainForm.btSearchGOClick(Sender: TObject);
begin
  SearchGO();
  with lvSearchGO do
    if Items.Count>0 then
    begin
      SetFocus;
      Selected := Items[0];
      btEditGO.Default := true;
      btSearchGO.Default := false;
    end;
  StatusBarGO.Panels[0].Text := Format(dmMain.Text[87], [lvSearchGO.Items.Count]);
end;

procedure TMainForm.SearchGameEvent;
var
  i: integer;
  ID, Name, QueryStr, WhereStr, t: string;
  Field: TField;
begin
  ID :=  edSearchGameEventEntry.Text;
  Name := edSearchGameEventDesc.Text;
  Name := StringReplace(Name, '''', '\''', [rfReplaceAll]);
  Name := StringReplace(Name, ' ', '%', [rfReplaceAll]);
  Name := '%'+Name+'%';

  QueryStr := '';
  WhereStr := '';
  if ID<>'' then
  begin
    if pos('-', ID)=0 then
      WhereStr := Format('WHERE (`entry` in (%s))',[ID])
    else
      WhereStr := Format('WHERE (`entry` >= %s) AND (`entry` <= %s)',[MidStr(ID,1,pos('-',id)-1), MidStr(ID,pos('-',id)+1,length(id))]);
  end;

  if Name<>'%%' then
  begin
    if WhereStr<> '' then
      WhereStr := Format('%s AND (`description` LIKE ''%s'')',[WhereStr, Name])
    else
      WhereStr := Format('WHERE (`description` LIKE ''%s'')',[Name]);
  end;

{  if Trim(WhereStr)='' then
    if MessageDlg(PAnsiChar(dmMain.Text[134]), mtConfirmation, mbYesNoCancel, -1)<>mrYes then Exit;
}
  QueryStr := Format('SELECT * FROM `game_event` %s',[WhereStr]);

  MyQuery.SQL.Text := QueryStr;
  lvSearchGameEvent.Items.BeginUpdate;
  lvSearchGameEvent.Items.Clear;
  try
    MyQuery.Open;
    while not MyQuery.Eof do
    begin
      with lvSearchGameEvent.Items.Add do
      begin
        for i := 0 to lvSearchGameEvent.Columns.Count - 1 do
        begin
          Field := MyQuery.FindField(lvSearchGameEvent.Columns[i].Caption);
          t := '';
          if Assigned(Field) then
          begin
            if (Field.DataType = ftDateTime) or (Field.DataType = ftTime) or (Field.DataType = ftDate) then
            begin
              try
                t := FormatDateTime('yyyy-mm-dd hh:mm:ss',Field.AsDateTime);
              except
                t := '0000-00-00 00:00:00';
              end;
              if t = '1899-12-30 00:00:00' then t := '0000-00-00 00:00:00';
              
            end
            else
              t := Field.AsString;
            if i=0 then Caption := t;
          end;
          if i<>0 then SubItems.Add(t);
        end;
        MyQuery.Next;
      end;
    end;
  finally
    lvSearchGameEvent.Items.EndUpdate;
    MyQuery.Close;
  end;
end;

procedure TMainForm.SearchGO;
var
  i, type_, faction,data0_,data1_,data2_:integer;
  loc, ID, CName, QueryStr, WhereStr, t: string;
  Field: TField;
begin
  loc:= LoadLocales();
  ShowHourGlassCursor;
  ID :=  edSearchGOEntry.Text;
  lvSearchGO.Columns[5].Caption:='name'+loc;
  lvSearchGO.Columns[6].Caption:='castbarcaption'+loc;
  CName := edSearchGOName.Text;
  CName := StringReplace(CName, '''', '\''', [rfReplaceAll]);
  CName := StringReplace(CName, ' ', '%', [rfReplaceAll]);
  CName := '%'+CName+'%';

  QueryStr := '';
  WhereStr := '';
  if ID<>'' then
  begin
    if pos('-', ID)=0 then
      WhereStr := Format('WHERE (gt.`entry` in (%s))',[ID])
    else
      WhereStr := Format('WHERE (gt.`entry` >= %s) AND (qt.`entry` <= %s)',[MidStr(ID,1,pos('-',id)-1), MidStr(ID,pos('-',id)+1,length(id))]);
  end;

  if CName<>'%%' then
  begin
    if WhereStr<> '' then
      WhereStr := Format('%s AND ((gt.`name` LIKE ''%s'') OR (lg.`name'+loc+'` LIKE ''%1:s''))',[WhereStr, CName])
    else
      WhereStr := Format('WHERE ((gt.`name` LIKE ''%s'') OR (lg.`name'+loc+'` LIKE ''%0:s''))',[CName]);
  end;

  type_ := StrToIntDef(edSearchGOtype.Text,-1);
  if type_<>-1 then
  begin
    if WhereStr<> '' then
      WhereStr := Format('%s AND (gt.`type` = %d)',[WhereStr, type_])
    else
      WhereStr := Format('WHERE (gt.`type` = %d)',[type_]);
  end;

  faction := StrToIntDef(edSearchGOfaction.Text,-1);
  if faction<>-1 then
  begin
    if WhereStr<> '' then
      WhereStr := Format('%s AND (gt.`faction` = %d)',[WhereStr, faction])
    else
      WhereStr := Format('WHERE (gt.`faction` = %d)',[faction]);
  end;

  data0_ := StrToIntDef(edSearchGOdata0.Text,-1);
  if data0_<>-1 then
  begin
    if WhereStr<> '' then
      WhereStr := Format('%s AND (gt.`data0` = %d)',[WhereStr, data0_])
    else
      WhereStr := Format('WHERE (gt.`data0` = %d)',[data0_]);
  end;

  data1_ := StrToIntDef(edSearchGOdata1.Text,-1);
  if data1_<>-1 then
  begin
    if WhereStr<> '' then
      WhereStr := Format('%s AND (gt.`data1` = %d)',[WhereStr, data1_])
    else
      WhereStr := Format('WHERE (gt.`data1` = %d)',[data1_]);
  end;

  data2_ := StrToIntDef(edSearchGOdata2.Text,-1);
  if data2_<>-1 then
  begin
    if WhereStr<> '' then
      WhereStr := Format('%s AND (gt.`data2` = %d)',[WhereStr, data2_])
    else
      WhereStr := Format('WHERE (gt.`data2` = %d)',[data2_]);
  end;

  if Trim(WhereStr)='' then
    if MessageDlg(dmMain.Text[134], mtConfirmation, mbYesNoCancel, -1)<>mrYes then Exit;

  QueryStr := Format('SELECT *, (SELECT count(guid) from `gameobject` where gameobject.id = gt.entry) as `Count` FROM `gameobject_template` gt LEFT OUTER JOIN `locales_gameobject` lg ON gt.entry=lg.entry %s',[WhereStr]);

  MyQuery.SQL.Text := QueryStr;
  lvSearchGO.Items.BeginUpdate;
  try
    MyQuery.Open;
    lvSearchGO.Clear;
    while not MyQuery.Eof do
    begin
      with lvSearchGO.Items.Add do
      begin
        for i := 0 to lvSearchGO.Columns.Count - 1 do
        begin
          Field := MyQuery.FindField(lvSearchGO.Columns[i].Caption);
          t := '';
          if Assigned(Field) then
          begin
            t := Field.AsString;
            if i=0 then Caption := t;
          end;
          if i<>0 then SubItems.Add(t);
        end;
        MyQuery.Next;
      end;
    end;
  finally
    lvSearchGO.Items.EndUpdate;
    MyQuery.Close;
  end;
end;

procedure TMainForm.edSearchGOChange(Sender: TObject);
begin
  btEditGO.Default := False;
  btSearchGO.Default :=  True;
end;

procedure TMainForm.lvSearchGODblClick(Sender: TObject);
begin
  PageControl4.ActivePageIndex := 1;
  if Assigned(lvSearchGO.Selected) then
  begin
    LoadGO(StrToInt(lvSearchGO.Selected.Caption));
    CompleteGOScript;
  end;
end;

procedure TMainForm.lvSearchGameEventChange(Sender: TObject; Item: TListItem; Change: TItemChange);
var
  f: boolean;
begin
  f := Assigned(TJvListView(Sender).Selected);
  btGameEventUpd.Enabled := f;
  btGameEventDel.Enabled := f;
  pnSelectedEventInfo.Enabled := f;
  btgeCreatureGuidAdd.Enabled := f;
  btgeGOGuidAdd.Enabled := f;
  btScriptGameEvent.Enabled := f;
  lvGameEventCreature.Enabled := f;
  lvGameEventGO.Enabled := f;
  edgeCreatureGuid.Enabled := f;
  edgeGOguid.Enabled := f;
end;

procedure TMainForm.lvSearchGameEventSelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
begin
  if Selected then
  begin
    edgeeventEntry.Text := Item.Caption;
    edgestart_time.Text := Item.SubItems[0];
    edgeend_time.Text   := Item.SubItems[1];
    edgeoccurence.Text := Item.SubItems[2];
    edgelength.Text := Item.SubItems[3];
    edgeholiday.Text := Item.SubItems[4];
    edgedescription.Text := Item.SubItems[5];
    edgeworld_event.Text := Item.SubItems[6];
    LoadCreaturesAndGOForGameEvent(Item.Caption);
  end
  else
  begin
    lvGameEventCreature.Clear;
    lvGameEventGO.Clear;
    edgeCreatureGuid.Clear;
    edgeGOguid.Clear;
  end;
end;

procedure TMainForm.lvSearchGOChange(Sender: TObject;
  Item: TListItem; Change: TItemChange);
var
  flag: boolean;
begin
  flag := Assigned(lvSearchGO.Selected);
  if flag then
    lvSearchGO.PopupMenu := pmGO
  else
    lvSearchGO.PopupMenu := nil;
  btEditGO.Enabled := flag;
  btDeleteGO.Enabled := flag;
  btBrowseGO.Enabled := flag;
  btBrowseGOPopup.Enabled := flag;
  nEditGO.Enabled := flag;
  nDeleteGO.Enabled := flag;
  nBrowseGO.Enabled := flag;
end;

procedure TMainForm.btEditGOClick(Sender: TObject);
begin
  PageControl4.ActivePageIndex := 1;
  if Assigned(lvSearchGO.Selected) then
    LoadGO(StrToInt(lvSearchGO.Selected.Caption));
end;

procedure TMainForm.btDeleteGOClick(Sender: TObject);
begin
  PageControl4.ActivePageIndex := SCRIPT_TAB_NO_GAMEOBJECT;
  megoScript.Text := Format(
  'DELETE FROM `gameobject_template` WHERE (`entry`=%0:s);'#13#10
   ,[lvSearchGO.Selected.Caption]);
end;

procedure TMainForm.btBrowseGOClick(Sender: TObject);
begin
  if assigned(lvSearchGO.Selected) then
    dmMain.BrowseSite(ttObject, StrToInt(lvSearchGO.Selected.Caption));
end;

procedure TMainForm.LoadGO(Entry: integer);
var
  t: integer;
begin
  ShowHourGlassCursor;
  ClearFields(ttObject);
  if Entry<1 then exit;
  // load full description for GO
  MyQuery.SQL.Text := Format('SELECT * FROM `gameobject_template` WHERE `entry`=%d',[Entry]);
  MyQuery.Open;
  try
    if MyQuery.Eof then
      raise Exception.Create(Format(dmMain.Text[88], [Entry]));  //'Error: GO (entry = %d) not found'
    edgtEntry.Text := IntToStr(Entry);
    FillFields(MyQuery, PFX_GAMEOBJECT_TEMPLATE);
    t := MyQuery.FieldByName('type').AsInteger;
    MyQuery.Close;
    SetGOdataHints(t);
    SetGOdataNames(t);

    LoadQueryToListView(Format('SELECT `guid`, `id`, `map`, `position_x`,'+
      '`position_y`,`position_z`,`orientation` FROM `gameobject` WHERE (`id`=%d)',
      [Entry]), lvglGOLocation);
    LoadQueryToListView(Format('SELECT glt.*, i.name FROM `gameobject_loot_template` glt '+
      'LEFT OUTER JOIN `item_template` i ON i.`entry` = glt.`item`  WHERE (glt.`entry`=%d)',
      [StrToIntDef(edgtdata1.Text,0)]), lvgoGOLoot);
  except
    on E: Exception do
      raise Exception.Create(dmMain.Text[89]+#10#13+E.Message);
  end;
end;

procedure TMainForm.CompleteGOScript;
var
  gtentry, Fields, Values: string;
begin
  meGOLog.Clear;
  gtentry := edgtEntry.Text;
  if gtentry='' then exit;
  SetFieldsAndValues(Fields, Values, 'gameobject_template', PFX_GAMEOBJECT_TEMPLATE, megoLog);
  case SyntaxStyle of
    ssInsertDelete: meGOScript.Text := Format('DELETE FROM `gameobject_template` WHERE (`entry`=%s);'#13#10+
      'INSERT INTO `gameobject_template` (%s) VALUES (%s);'#13#10,[gtentry, Fields, Values]);
    ssReplace: meGOScript.Text := Format('REPLACE INTO `gameobject_template` (%s) VALUES (%s);'#13#10,[Fields, Values]);
    ssUpdate: megoScript.Text := MakeUpdate('gameobject_template', PFX_GAMEOBJECT_TEMPLATE, 'entry', gtentry);
  end;
end;

procedure TMainForm.edgeCreatureGuidButtonClick(Sender: TObject);
begin
  GetGuid(Sender, 'creature');
end;

procedure TMainForm.edgeGOguidButtonClick(Sender: TObject);
begin
  GetGuid(Sender, 'gameobject');
end;

procedure TMainForm.edgtEntryButtonClick(Sender: TObject);
var
  KeyboardState: TKeyboardState;
  id: integer;
begin
  id := abs(StrToIntDef(TJvComboEdit(Sender).Text,0));
  if id = 0 then Exit;
  GetKeyboardState(KeyboardState);
  if ssShift in KeyboardStateToShiftState(KeyboardState) then
    dmMain.BrowseSite(ttObject, id)
  else
    LoadGo(id);
end;

procedure TMainForm.edflagsChange(Sender: TObject);
var
  h: string;
  flag: int64;
  edit: TJvComboEdit;
begin
  edit := TJvComboEdit(Sender);
  if TryStrToInt64(edit.Text, flag) then
  begin
    h := IntToHex(flag,8);
    edit.Hint := Format('0x%s 0x%s', [midstr(h,1,4), midstr(h,5,4)]);
  end
  else
    edit.Hint := '';
end;

procedure TMainForm.GetGOFlags(Sender: TObject);
begin
  GetSomeFlags(Sender, 'GameObjectFlags');
end;

procedure TMainForm.tsGOShow(Sender: TObject);
begin
  PageControl4.ActivePageIndex := 0;
end;

procedure TMainForm.btExecuteGOScriptClick(Sender: TObject);
begin
  if MessageDlg(dmMain.Text[9], mtConfirmation, mbYesNoCancel, -1)=mrYes then
    ExecuteScript(meGOScript.Text, meGOLog);
end;

procedure TMainForm.btCopyToClipboardGOClick(Sender: TObject);
begin
  meGOScript.SelectAll;
  meGOScript.CopyToClipboard;
  meGOScript.SelStart := 0;
  meGOScript.SelLength := 0;
end;

procedure TMainForm.tsGOInvolvedInShow(Sender: TObject);
begin
  LoadGOInvolvedIn(edgtEntry.Text);
end;

procedure TMainForm.tsGOLootShow(Sender: TObject);
begin
  if (edgoentry.Text = '') then edgoentry.Text := edgtdata1.Text;
end;

procedure TMainForm.tsGOScriptShow(Sender: TObject);
begin
  case PageControl4.ActivePageIndex of
    1: CompleteGOScript;
    2: CompleteGOLocationScript;
    3: CompleteGOLootScript;
    4: CompleteButtonScriptScript;
  end;
end;

procedure TMainForm.btNewGOClick(Sender: TObject);
begin
  lvSearchGO.Selected := nil;
  ClearFields(ttObject);
  SetDefaultFields(ttObject);
  PageControl4.ActivePageIndex := 1;
end;

procedure TMainForm.lvgbButtonScriptChange(Sender: TObject; Item: TListItem; Change: TItemChange);
begin
  btgbUpd.Enabled := Assigned(TJvListView(Sender).Selected);
  btgbDel.Enabled := Assigned(TJvListView(Sender).Selected);
end;

procedure TMainForm.lvgbButtonScriptSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
begin
  if Selected then
    SetScriptEditFields('edgb', lvgbButtonScript);
end;

procedure TMainForm.lvglGOLocationSelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
begin
  if Selected then
  begin
    LoadGOLocation(StrToIntDef(Item.Caption,0));
    LoadButtonScript(StrToIntDef(Item.Caption,0));
    edgbGUID.Text := Item.Caption;
  end;
end;

procedure TMainForm.LoadGOLocation(GUID: integer);
begin
  if GUID<1 then Exit;
  MyQuery.SQL.Text := Format('SELECT * FROM `gameobject` WHERE (`guid`=%d)',[GUID]);
  MyQuery.Open;
  try
    FillFields(MyQuery, PFX_GAMEOBJECT);
    MyQuery.Close;
  except
    on E: Exception do
      raise Exception.Create(dmMain.Text[90]+#10#13+E.Message);
  end;
end;

procedure TMainForm.btScriptGOClick(Sender: TObject);
begin
  PageControl4.ActivePageIndex := SCRIPT_TAB_NO_GAMEOBJECT;
end;

procedure TMainForm.CompleteGameEventScript;
var
  entry, Fields, Values, s1, s2, s3, tmp: string;
  i: integer;
begin
  if not Assigned(lvSearchGameEvent.Selected) then Exit;
  
  meotLog.Clear;
  entry := edgeeventEntry.Text;
  if (entry='') then Exit;
  SetFieldsAndValues(Fields, Values, 'game_event', PFX_GAME_EVENT, meotLog);
  case SyntaxStyle of
    ssInsertDelete: s1 := Format('DELETE FROM `game_event` WHERE (`eventEntry`=%s);'#13#10+
      'INSERT INTO `game_event` (%s) VALUES (%s);'#13#10,[entry, Fields, Values]);
    ssReplace: s1 := Format('REPLACE INTO `game_event` (%s) VALUES (%s);'#13#10,[Fields, Values]);
    ssUpdate: s1 := MakeUpdate('game_event', PFX_GAME_EVENT, 'eventEntry', entry);
  end;

  s2 := Format('DELETE FROM `game_event_creature` WHERE abs(`eventEntry`) = %s;'#13#10,[entry]);
  s3 := Format('DELETE FROM `game_event_gameobject` WHERE abs(`eventEntry`) = %s;'#13#10,[entry]);

  if lvGameEventCreature.Items.Count > 0 then
  begin
    s2 := Format('%sINSERT INTO `game_event_creature` (`guid`, `eventEntry`) VALUES'#13#10,[s2]);
    for I := 0 to lvGameEventCreature.Items.Count - 1 do
    begin
      tmp := Format('(%s,%s)', [lvGameEventCreature.Items[i].Caption, lvGameEventCreature.Items[i].SubItems[0]]);
      if i<>lvGameEventCreature.Items.Count - 1 then tmp := tmp + ','#13#10 else tmp := tmp + ';'#13#10;
      s2 := s2 + tmp;
    end;
  end;

  if lvGameEventGO.Items.Count > 0 then
  begin
    s3 := Format('%sINSERT INTO `game_event_gameobject` (`guid`, `eventEntry`) VALUES'#13#10,[s3]);
    for I := 0 to lvGameEventGO.Items.Count - 1 do
    begin
      tmp := Format('(%s,%s)', [lvGameEventGO.Items[i].Caption, lvGameEventGO.Items[i].SubItems[0]]);
      if i<>lvGameEventGO.Items.Count - 1 then tmp := tmp + ','#13#10 else tmp := tmp + ';'#13#10;
      s3 := s3 + tmp;
    end;
  end;

  meotScript.Text := s1 + s2 + s3;
end;     

procedure TMainForm.CompleteGOLocationScript;
var
  glguid, Fields, Values: string;
begin
  meGOLog.Clear;
  glguid := edglguid.Text;
  if glguid='' then exit;
  SetFieldsAndValues(Fields, Values, 'gameobject', PFX_GAMEOBJECT, megoLog);
  case SyntaxStyle of
    ssInsertDelete: meGOScript.Text := Format('DELETE FROM `gameobject` WHERE (`guid`=%s);'#13#10+
      'INSERT INTO `gameobject` (%s) VALUES (%s);'#13#10,[glguid, Fields, Values]);
    ssReplace: meGOScript.Text := Format('REPLACE INTO `gameobject` (%s) VALUES (%s);'#13#10,[Fields, Values]);
    ssUpdate: meGOScript.Text := MakeUpdate('gameobject', PFX_GAMEOBJECT, 'guid', glguid);
  end;
end;

procedure TMainForm.CompleteGOLootScript;
var
  goentry, goitem, Fields, Values: string;
begin
  meGOLog.Clear;
  goentry := edgoentry.Text;
  goitem := edgoitem.Text;
  if (goentry='') or (goitem='') then Exit;
  SetFieldsAndValues(Fields, Values, 'gameobject_loot_template', PFX_GAMEOBJECT_LOOT_TEMPLATE, megoLog);
  meGOScript.Text := Format('DELETE FROM `gameobject_loot_template` WHERE (`entry`=%s) AND (`item`=%s);'#13#10+
    'INSERT INTO `gameobject_loot_template` (%s) VALUES (%s);'#13#10,[goentry, goitem, Fields, Values])
end;    

procedure TMainForm.lvgoGOLootSelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
begin
  if Selected then
    SetLootEditFields('edgo', lvgoGOLoot);
end;

procedure TMainForm.edgttypeButtonClick(Sender: TObject);
begin
  GetValueFromSimpleList(Sender, 93, 'GameObjectType', false);
end;

procedure TMainForm.SetGOdataHints(t: integer);
begin
    edgtdata0.Hint := dmMain.Text[94] + ' (data0)';
    edgtdata1.Hint := dmMain.Text[94] + ' (data1)';
    edgtdata2.Hint := dmMain.Text[94] + ' (data2)';
    edgtdata3.Hint := dmMain.Text[94] + ' (data3)';
    edgtdata4.Hint := dmMain.Text[94] + ' (data4)';
    edgtdata5.Hint := dmMain.Text[94] + ' (data5)';
    edgtdata6.Hint := dmMain.Text[94] + ' (data6)';
    edgtdata7.Hint := dmMain.Text[94] + ' (data7)';
    edgtdata8.Hint := dmMain.Text[94] + ' (data8)';
    edgtdata9.Hint := dmMain.Text[94] + ' (data9)';
    edgtdata10.Hint := dmMain.Text[94] + ' (data10)';
    edgtdata11.Hint := dmMain.Text[94] + ' (data11)';
    edgtdata12.Hint := dmMain.Text[94] + ' (data12)';
    edgtdata13.Hint := dmMain.Text[94] + ' (data13)';
    edgtdata14.Hint := dmMain.Text[94] + ' (data14)';
    edgtdata15.Hint := dmMain.Text[94] + ' (data15)';
    edgtdata16.Hint := dmMain.Text[94] + ' (data16)';
    edgtdata17.Hint := dmMain.Text[94] + ' (data17)';
    edgtdata18.Hint := dmMain.Text[94] + ' (data18)';
    edgtdata19.Hint := dmMain.Text[94] + ' (data19)';
    edgtdata20.Hint := dmMain.Text[94] + ' (data20)';
    edgtdata21.Hint := dmMain.Text[94] + ' (data21)';
    edgtdata22.Hint := dmMain.Text[94] + ' (data22)';
    edgtdata23.Hint := dmMain.Text[94] + ' (data23)';
    case t of
      0:
        begin
          edgtdata0.Hint := dmMain.Text[95] + ' (data0)';
          edgtdata1.Hint := dmMain.Text[96] + ' (data1)';
          edgtdata2.Hint := dmMain.Text[97] + ' (data2)';
          edgtdata3.Hint := dmMain.Text[97] + ' (data3)';
        end;
      1:
        begin
          edgtdata0.Hint := dmMain.Text[95] + ' (data0)';
          edgtdata1.Hint := dmMain.Text[96] + ' (data1)';
          edgtdata2.Hint := dmMain.Text[97] + ' (data2)';
          edgtdata3.Hint := dmMain.Text[98] + ' (data3)';
          edgtdata4.Hint := dmMain.Text[99] + ' (data4)';
        end;
      2:
        begin
          edgtdata0.Hint := dmMain.Text[96] + ' (data0)';
          edgtdata1.Hint := dmMain.Text[100] + ' (data1)';
          edgtdata3.Hint := dmMain.Text[100] + ' (data3)';
        end;
      3:
        begin
          edgtdata0.Hint := dmMain.Text[96] + ' (data0)';
          edgtdata1.Hint := dmMain.Text[101] + ' (data1)';
          edgtdata2.Hint := dmMain.Text[102] + ' (data2)';
          edgtdata3.Hint := dmMain.Text[95] + ' (data3)';
          edgtdata4.Hint := dmMain.Text[103] + ' (data4)';
          edgtdata5.Hint := dmMain.Text[104] + ' (data5)';
          edgtdata6.Hint := dmMain.Text[100] + ' (data6)';
          edgtdata7.Hint := dmMain.Text[98] + ' (data7)';
          edgtdata8.Hint := dmMain.Text[105] + ' (data8)';
        end;
      5:
        begin
          edgtdata0.Hint := dmMain.Text[95] + ' (data0)';
          edgtdata1.Hint := dmMain.Text[95] + ' (data1)';
        end;
      6:
        begin
          edgtdata0.Hint := dmMain.Text[96] + ' (data0)';
          edgtdata1.Hint := dmMain.Text[102] + ' (data1)';
          edgtdata2.Hint := dmMain.Text[106] + ' (data2)';
          edgtdata3.Hint := dmMain.Text[107] + ' (data3)';
          edgtdata4.Hint := dmMain.Text[95] + ' ?' + ' (data4)';
          edgtdata5.Hint := dmMain.Text[108] + ' (data5)';
          edgtdata6.Hint := dmMain.Text[109] + ' (data6)';
          edgtdata7.Hint := dmMain.Text[110] + ' (data7)';
        end;
      7:
        begin
          edgtdata0.Hint := dmMain.Text[95] + ' (data0)';
          edgtdata1.Hint := dmMain.Text[112] + ' (data1)';
        end;
      8:
        begin
          edgtdata0.Hint := dmMain.Text[113] + ' (data0)';
          edgtdata1.Hint := dmMain.Text[106] + ' (data1)';
          edgtdata2.Hint := dmMain.Text[98] + ' (data2)';
          edgtdata3.Hint := dmMain.Text[95]+' ?' + ' (data3)';
        end;
      9:
        begin
          edgtdata0.Hint := dmMain.Text[114] + ' (data0)';
          edgtdata2.Hint := dmMain.Text[115] + ' (data2)';
        end;
      10:
        begin
          edgtdata0.Hint := dmMain.Text[96] + ' (data0)';
          edgtdata1.Hint := dmMain.Text[97] + ' (data1)';
          edgtdata2.Hint := dmMain.Text[100] + ' (data2)';
          edgtdata3.Hint := dmMain.Text[97] + ' (data3)';
          edgtdata4.Hint := dmMain.Text[95] + ' ?' + ' (data4)';
          edgtdata5.Hint := dmMain.Text[95] + ' ?' + ' (data5)';
        end;
      18:
        begin
          edgtdata0.Hint := dmMain.Text[102] + ' (data0)';
          edgtdata1.Hint := dmMain.Text[107] + ' (data1)';
          edgtdata2.Hint := dmMain.Text[107] + ' (data2)';
        end;
      22:
        begin
          edgtdata0.Hint := dmMain.Text[107] + ' (data0)';
          edgtdata2.Hint := dmMain.Text[95] + ' ?' + ' (data2)';
        end;
      24:
        begin
          edgtdata1.Hint := dmMain.Text[107] + ' (data1)';
          edgtdata3.Hint := dmMain.Text[107] + ' (data3)';
          edgtdata4.Hint := dmMain.Text[107] + ' (data4)';
        end;
      27:
        begin
          edgtdata0.Hint := dmMain.Text[111] + ' (data0)';
        end;
    end;
end;

procedure TMainForm.edgttypeChange(Sender: TObject);
begin
  SetGOdataHints(StrToIntDef(edgttype.Text,0));
  SetGOdataNames(StrToIntDef(edgttype.Text,0));
end;

procedure TMainForm.edhtdataButtonClick(Sender: TObject);
var
  F: TCharacterDataForm;
begin
  if trim(TCustomEdit(Sender).Text)='' then exit;

  F := TCharacterDataForm.Create(Self);
  try
    F.Data := TCustomEdit(Sender).Text;
    if F.ShowModal = mrOk then
    begin
      TCustomEdit(Sender).Text := F.Data;
    end;
  finally
    F.Free;
  end;
end;

procedure TMainForm.edhtguidButtonClick(Sender: TObject);
begin
  LoadCharacter(StrToIntDef(TCustomEdit(Sender).Text,0));
end;

procedure TMainForm.edhttaximaskButtonClick(Sender: TObject);
var
  F: TTaxiMaskForm;
begin
  if trim(TCustomEdit(Sender).Text)='' then exit;
  
  F := TTaxiMaskForm.Create(Self);
  try
    F.Data := TCustomEdit(Sender).Text;
    if F.ShowModal = mrOk then
    begin
      TCustomEdit(Sender).Text := F.Data;
    end;
  finally
    F.Free;
  end;
end;

procedure TMainForm.SetFieldsAndValues(Query: TZQuery; var Fields: string; var Values: string;
  TableName: string; pfx: string; Log: TMemo);
var
  FieldName, tmp: string;
  C: TComponent;
  i: integer;
  FieldFound: boolean;
begin
  Query.SQL.Text := Format('SELECT * FROM `%s` LIMIT 1',[TableName]);
  Query.Open;
  for i := 0 to Query.Fields.Count - 1 do
  begin
    FieldName := Query.Fields[i].FieldName;
    FieldFound := true;
    C := FindComponent('ed'+pfx+FieldName);
    if Assigned(C) and (C is TCustomEdit) then
    begin
      tmp := SymToDoll(TCustomEdit(C).Text);
      tmp := StringReplace(tmp,'''','\''', [rfReplaceAll]);

      // if tmp is not number
      if not IsNumber(tmp) then
      begin
        if Values='' then Values := Format('''%s''',[tmp])
        else Values := Format('%s, ''%s''',[Values,tmp]);
      end
      else
      begin
        if Values='' then Values := Format('%s',[tmp])
        else Values := Format('%s, %s',[Values,tmp]);
      end
    end
    else
    begin
      C := FindComponent('cb'+pfx+FieldName);
      if Assigned(C) and (C is TCheckBox) then
      begin
        if TCheckBox(C).Checked then tmp := '1' else tmp := '0';
        if Values='' then Values := Format('%s',[tmp])
        else Values := Format('%s, %s',[Values,tmp]);
      end
      else
      begin
        Log.Lines.Add(Format(dmMain.Text[8],[FieldName])); // 'Warning: There is no one component assigned to field `%s`. It will assigned to default value if it has one.'
        FieldFound := false;
      end;
    end;
    if FieldFound then
    begin
      if Fields='' then
        Fields := Format('`%s`',[FieldName])
      else
        Fields := Format('%s, `%s`',[Fields, FieldName]);
    end;
  end;
  Query.Close;
end;

procedure TMainForm.FillFields(Query: TZQuery; pfx: string);
var
  i, j: integer;
begin
  for i := 0 to ComponentCount - 1 do
  begin
    if (Components[i] is TCustomEdit) then
      for j := 0 to Query.Fields.Count - 1 do
        if LowerCase(Components[i].Name) = 'ed'+pfx+LowerCase(Query.Fields[j].FieldName) then
        begin
          TCustomEdit(Components[i]).Text := DollToSym(Query.Fields[j].AsString);
        end;
    if Components[i] is TCheckBox then
      for j := 0 to Query.Fields.Count - 1 do
        if LowerCase(Components[i].Name) = 'cb'+pfx+LowerCase(Query.Fields[j].FieldName) then
          TCheckBox(Components[i]).Checked := (Query.Fields[j].AsInteger <> 0);
  end;
end;

procedure TMainForm.LoadQueryToListView(strQuery: string; ListView: TJvListView);
begin
  LoadMyQueryToListView(MyQuery, strQuery, ListView);
end;

procedure TMainForm.LoadLoot(var lvList: TJvListView; key: string);
var
  i: integer;
  id: string;
  table : string;
  s: string;

  procedure QueryResult_AddToList;
  var
    i: integer;
  begin
    MyQuery.Open;
    while not MyQuery.Eof do
    begin
      for i := 0 to MyQuery.FieldCount - 1 do
        lvList.Columns[i].Caption := MyQuery.Fields[i].FieldName;
      with lvList.Items.Add do
      begin
        Caption := MyQuery.Fields[0].AsString;
        for i := 1 to MyQuery.FieldCount - 1 do
          SubItems.Add(MyQuery.Fields[i].AsString);
      end;
      MyQuery.Next;
    end;
    MyQuery.Close;
  end;
begin
  lvList.Items.BeginUpdate;
  lvList.SortType := stNone;
  try
    lvList.Clear;
    // load creature loot
    MyQuery.SQL.Text := Format('SELECT `entry`, `item`, `ChanceOrQuestChance`, '+
      '`lootmode`, `groupid`, `mincountOrRef`, `maxcount`, '+
      '''creature_loot_template'' as `table` '+
      'FROM `creature_loot_template` WHERE (`item`=%s)',[key]);
    QueryResult_AddToList;

    // load gameobject loot
    MyQuery.SQL.Text := Format('SELECT `entry`, `item`, `ChanceOrQuestChance`, '+
      '`lootmode`, `groupid`, `mincountOrRef`, `maxcount`, '+
      '''gameobject_loot_template'' as `table` '+
      'FROM `gameobject_loot_template` WHERE (`item`=%s)',[key]);
    QueryResult_AddToList;

    // load item loot
    MyQuery.SQL.Text := Format('SELECT `entry`, `item`, `ChanceOrQuestChance`, '+
      '`lootmode`, `groupid`, `mincountOrRef`, `maxcount`, '+
      '''item_loot_template'' as `table` '+
      'FROM `item_loot_template` WHERE (`item`=%s)', [key]);
    QueryResult_AddToList;

    // load pickpocketing loot
    MyQuery.SQL.Text := Format('SELECT `entry`, `item`, `ChanceOrQuestChance`, '+
      '`lootmode`, `groupid`, `mincountOrRef`, `maxcount`, '+
      '''pickpocketing_loot_template'' as `table` '+
      'FROM `pickpocketing_loot_template` WHERE (`item`=%s)',[key]);
    QueryResult_AddToList;

    // load skinning loot
    MyQuery.SQL.Text := Format('SELECT `entry`, `item`, `ChanceOrQuestChance`, '+
      '`lootmode`, `groupid`, `mincountOrRef`, `maxcount`, '+
      '''skinning_loot_template'' as `table` '+
      'FROM `skinning_loot_template` WHERE (`item`=%s)',[key]);
    QueryResult_AddToList;

    // load enchanting loot
    MyQuery.SQL.Text := Format('SELECT `entry`, `item`, `ChanceOrQuestChance`, '+
      '`lootmode`, `groupid`, `mincountOrRef`, `maxcount`, '+
      '''disenchant_loot_template'' as `table` '+
      'FROM `disenchant_loot_template` WHERE (`item`=%s)',[key]);
    QueryResult_AddToList;

    // load fishing loot
    MyQuery.SQL.Text := Format('SELECT `entry`, `item`, `ChanceOrQuestChance`, '+
      '`lootmode`, `groupid`, `mincountOrRef`, `maxcount`, '+
      '''fishing_loot_template'' as `table` '+
      'FROM `fishing_loot_template` WHERE (`item`=%s)',[key]);
    QueryResult_AddToList;

    // load prospecting loot
    MyQuery.SQL.Text := Format('SELECT `entry`, `item`, `ChanceOrQuestChance`, '+
      '`lootmode`, `groupid`, `mincountOrRef`, `maxcount`, '+
      '''prospecting_loot_template'' as `table` '+
      'FROM `prospecting_loot_template` WHERE (`item`=%s)',[key]);
    QueryResult_AddToList;

    // load milling loot
    MyQuery.SQL.Text := Format('SELECT `entry`, `item`, `ChanceOrQuestChance`, '+
      '`lootmode`, `groupid`, `mincountOrRef`, `maxcount`, '+
      '''milling_loot_template'' as `table` '+
      'FROM `milling_loot_template` WHERE (`item`=%s)',[key]);
    QueryResult_AddToList;

   //load reference loot
    MyQuery.SQL.Text := Format('SELECT `entry`, `item`, `ChanceOrQuestChance`, '+
      '`lootmode`, `groupid`, `mincountOrRef`, `maxcount`, '+
      '''reference_loot_template'' as `table` '+
      'FROM `reference_loot_template` WHERE (`item`=%s)',[key]);
    QueryResult_AddToList;

    // load npc_vendor
    MyQuery.SQL.Text := Format('SELECT `entry`, `item`,  '''' as `ChanceOrQuestChance`, '+
      ''''' as `groupid`, '''' as `mincountOrRef`, `maxcount`, '+
      ''''' as `lootmode`, ''npc_vendor'' as `table` '+
      'FROM `npc_vendor` WHERE (`item`=%s)',[key]);
    QueryResult_AddToList;
  finally
    lvList.Items.EndUpdate;
  end;

  lvList.Columns[8].Caption := 'name';
  for I := 0 to lvList.Items.Count - 1 do
  begin
    id := lvList.Items[i].Caption;
    table := lvList.Items[i].SubItems[lvList.Items[i].SubItems.Count-1];
    MyQuery.SQL.Text := '';
    if table = 'creature_loot_template' then
      MyQuery.SQL.Text := Format('SELECT `name` FROM `creature_template` WHERE `lootid` = %s',[id]);
    if table = 'item_loot_template' then
      MyQuery.SQL.Text := Format('SELECT `name` FROM `item_template` WHERE `entry` = %s',[id]);
    if table = 'prospecting_loot_template' then
      MyQuery.SQL.Text := Format('SELECT `name` FROM `item_template` WHERE `entry` = %s',[id]);
    if table = 'milling_loot_template' then
      MyQuery.SQL.Text := Format('SELECT `name` FROM `item_template` WHERE `entry` = %s',[id]);
    if table = 'disenchant_loot_template' then
      MyQuery.SQL.Text := Format('SELECT `name` FROM `item_template` WHERE `DisenchantID` = %s',[id]);
    if table = 'npc_vendor' then
      MyQuery.SQL.Text := Format('SELECT `name` FROM `creature_template` WHERE `entry` = %s',[id]);
    if table = 'gameobject_loot_template' then
      MyQuery.SQL.Text := Format('SELECT `name` FROM `gameobject_template` WHERE `data1` = %s',[id]);
    if table = 'pickpocketing_loot_template' then
      MyQuery.SQL.Text := Format('SELECT `name` FROM `creature_template` WHERE `pickpocketloot` = %s',[id]);
    if table = 'skinning_loot_template' then
      MyQuery.SQL.Text := Format('SELECT `name` FROM `creature_template` WHERE `skinloot` = %s',[id]);
    if (MyQuery.SQL.Text <> '') then
    begin
      MyQuery.Open;
      s := '';
      while not MyQuery.Eof do
      begin
        s := Format('%s, %s',[MyQuery.Fields[0].AsString,s]);
        MyQuery.Next;
      end;
      s := MidStr(s, 1, length(s)-2);
      lvList.Items[i].SubItems.Add(s);
      MyQuery.Close;
      Application.ProcessMessages;
    end;
  end;
  lvList.SortType := stBoth;
end;

procedure TMainForm.pmSiteClick(Sender: TObject);
var
  lvList: TJvListView;
  par: TType;
begin
  lvList := lvQuest;
  par := ttQuest;
  if TBitBtn(TPopupMenu(TMenuItem(Sender).GetParentComponent).PopupComponent).Name='btBrowseCreaturePopup' then
  begin
    lvList := lvSearchCreature;
    par := ttNPC;
  end;
  if TBitBtn(TPopupMenu(TMenuItem(Sender).GetParentComponent).PopupComponent).Name='btBrowseQuestPopup' then
  begin
    lvList := lvQuest;
    par := ttQuest;
  end;
  if TBitBtn(TPopupMenu(TMenuItem(Sender).GetParentComponent).PopupComponent).Name='btBrowseGOPopup' then
  begin
    lvList := lvSearchGO;
    par := ttObject;
  end;
  if TBitBtn(TPopupMenu(TMenuItem(Sender).GetParentComponent).PopupComponent).Name='btBrowseItemPopup' then
  begin
    lvList := lvSearchItem;
    par := ttItem;
  end;
  if Assigned(lvList) and Assigned(lvList.Selected) then
  begin
    if TMenuItem(Sender).Name = 'pmwowhead' then
        dmMain.wowhead(par, StrToInt(lvList.Selected.Caption));
    if TMenuItem(Sender).Name = 'pmruwowhead' then
        dmMain.ruwowhead(par, StrToInt(lvList.Selected.Caption));
    if TMenuItem(Sender).Name = 'pmallakhazam' then
        dmMain.allakhazam(par, StrToInt(lvList.Selected.Caption));
    if TMenuItem(Sender).Name = 'pmthottbot' then
        dmMain.thottbot(par, StrToInt(lvList.Selected.Caption));
    if TMenuItem(Sender).Name = 'pmwowdb' then
        dmMain.wowdb(par, StrToInt(lvList.Selected.Caption));
  end;
end;

procedure TMainForm.QLPrepare;
var
  i, cnt: integer;
  P : TPoint;
begin
  cnt := lvQuickList.Items.Count;

  if Trim(edit.Text)<>'' then
  begin
    for i := 0 to cnt - 1 do
    begin
      if lvQuickList.Items[i].Caption = edit.Text then
      begin
        lvQuickList.Selected := lvQuickList.Items[i];
        lvQuickList.Selected.MakeVisible(false);
        break;
      end;
    end;
  end;

  lvQuickList.OnMouseMove := lvQuickListMouseMove;
  lvQuickList.OnMouseLeave := lvQuickListMouseLeave;
  lvQuickList.OnClick := lvQuickListClick;
  lvQuickList.OnKeyDown := lvQuickListKeyDown;

  lvQuickList.Height := 16 * cnt + 5;
  P := edit.ClientToScreen(Point(0,edit.Height));
  p := lvQuickList.ScreenToClient(P);
  lvQuickList.Left := P.X;
  lvQuickList.Top := P.Y+1;
  if lvQuickList.Top + lvQuickList.Height > lvQuickList.Parent.Height   then
    lvQuickList.Top := P.Y - lvQuickList.Height - edit.Height - 1;
end;

procedure TMainForm.lvcvNPCVendorSelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
begin
  if Selected then
  begin
    with TJvListView(Sender).Selected do
    begin
      edcventry.Text := Caption;
      edcvslot.Text := SubItems[0];
      edcvitem.Text := SubItems[1];
      edcvmaxcount.Text := SubItems[2];
      edcvincrtime.Text := SubItems[3];
      edcvExtendedCost.Text := SubItems[4];
    end;
  end;
end;

procedure TMainForm.lvcrNPCTrainerSelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
begin
  if Selected then
  begin
    with TJvListView(Sender).Selected do
    begin
      edcrentry.Text := Caption;
      edcrspell.Text := SubItems[0];
      edcrspellcost.Text := SubItems[1];
      edcrreqskill.Text := SubItems[2];
      edcrreqskillvalue.Text := SubItems[3];
      edcrreqlevel.Text := SubItems[4];
    end;
  end;
end;

function TMainForm.MakeUpdate(tn: string; pfx: string; KeyName: string; KeyValue: string): string;
var
  i: integer;
  sets, FieldName, ValueFromBase, ValueFromEdit: string;
  C: TComponent;
begin
  Result := '';
  sets := '';
  MyTempQuery.SQL.Text := Format('SELECT * FROM `%s` WHERE `%s` = %s',[tn, KeyName, KeyValue]);
  MyTempQuery.Open;
  if not MyTempQuery.Eof then
  begin

    for i := 0 to MyTempQuery.Fields.Count - 1 do
    begin
      FieldName := MyTempQuery.Fields[i].FieldName;
      ValueFromBase := MyTempQuery.Fields[i].AsString;
      C := FindComponent('ed'+pfx+FieldName);
      if Assigned(C) and (C is TCustomEdit) then
      begin
        ValueFromEdit := SymToDoll(TCustomEdit(C).Text);
        if ValueFromEdit <> ValueFromBase then
        begin
          if not IsNumber(ValueFromEdit) then ValueFromEdit := QuotedStr(ValueFromEdit);
          if sets = '' then sets := Format('SET `%s` = %s',[FieldName, ValueFromEdit])
          else sets := Format('%s, `%s` = %s',[sets, FieldName, ValueFromEdit]);
        end;
      end
      else
      begin
        C := FindComponent('cb'+pfx+FieldName);
        if Assigned(C) and (C is TCheckBox) then
        begin
          if TCheckBox(C).Checked then ValueFromEdit := '1' else ValueFromEdit := '0';
          if ValueFromEdit <> ValueFromBase then
          begin
            if sets='' then sets := Format('SET `%s` = %s',[FieldName, ValueFromEdit])
            else sets := Format('%s, `%s` = %s',[sets, FieldName, ValueFromEdit]);
          end;
        end;
      end;
    end;
    if sets<>'' then
      Result := Format('UPDATE `%s` %s WHERE `%s` = %s;',[tn, sets, KeyName, KeyValue])
  end;
  MyTempQuery.Close;
end;

function TMainForm.MakeUpdateLocales(tn: string; pfx: string; KeyName: string; KeyValue: string): string;
var
  i: integer;
  sets, FieldName, ValueFromBase, ValueFromEdit, loc ,FN: string;
  C: TComponent;
begin
  loc:= LoadLocales();
  Result := '';
  sets := '';
  MyTempQuery.SQL.Text := Format('SELECT * FROM `%s` WHERE `%s` = %s',[tn, KeyName, KeyValue]);
  MyTempQuery.Open;
  if not MyTempQuery.Eof then
  begin

    for i := 0 to MyTempQuery.Fields.Count - 1 do
    begin
      FieldName := MyTempQuery.Fields[i].FieldName;
      ValueFromBase := MyTempQuery.Fields[i].AsString;
      FN:= StringReplace (FieldName, loc, '',[rfReplaceAll]);
      C := FindComponent('ed'+pfx+FN);
      if Assigned(C) and (C is TCustomEdit) then
      begin
        ValueFromEdit := SymToDoll(TCustomEdit(C).Text);
        if ValueFromEdit <> ValueFromBase then
        begin
          if not IsNumber(ValueFromEdit) then ValueFromEdit := QuotedStr(ValueFromEdit);
          if sets = '' then sets := Format('SET `%s` = %s',[FieldName, ValueFromEdit])
          else sets := Format('%s, `%s` = %s',[sets, FieldName, ValueFromEdit]);
        end;
      end
      else
      begin
        C := FindComponent('cb'+pfx+FN);
        if Assigned(C) and (C is TCheckBox) then
        begin
          if TCheckBox(C).Checked then ValueFromEdit := '1' else ValueFromEdit := '0';
          if ValueFromEdit <> ValueFromBase then
          begin
            if sets='' then sets := Format('SET `%s` = %s',[FN+loc, ValueFromEdit])
            else sets := Format('%s, `%s` = %s',[sets, FN+loc, ValueFromEdit]);
          end;
        end;
      end;
    end;
    if sets<>'' then
      Result := Format('UPDATE `%s` %s WHERE `%s` = %s;',[tn, sets, KeyName, KeyValue])
  end;
  MyTempQuery.Close;
end;


procedure TMainForm.MvmntAdd(pfx: string; lvList: TJvListView);
begin
  with lvList.Items.Add do
  begin
    Caption := TCustomEdit(FindComponent(pfx + 'id')).Text;
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'point')).Text);
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'position_x')).Text);
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'position_y')).Text);
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'position_z')).Text);
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'waittime')).Text);
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'text1')).Text);
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'text2')).Text);
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'text3')).Text);
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'text4')).Text);
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'text5')).Text);
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'emote')).Text);
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'spell')).Text);
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'wpguid')).Text);
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'orientation')).Text);
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'model1')).Text);
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'model2')).Text);
  end;
end;

procedure TMainForm.MvmntDel(lvList: TJvListView);
begin
  LootDel(lvList);
end;

procedure TMainForm.EventAiDel(lvList: TJvListView);
begin
  LootDel(lvList);
end;

procedure TMainForm.SmartAIDel(lvList: TJvListView);
begin
  LootDel(lvList);
end;

procedure TMainForm.MvmntUpd(pfx: string; lvList: TJvListView);
begin
  if Assigned(lvList.Selected) then
  begin
    with lvList.Selected do
    begin
      Caption := TCustomEdit(FindComponent(pfx + 'id')).Text;
      SubItems[0] := TCustomEdit(FindComponent(pfx + 'point')).Text;
      SubItems[1] := TCustomEdit(FindComponent(pfx + 'position_x')).Text;
      SubItems[2] := TCustomEdit(FindComponent(pfx + 'position_y')).Text;
      SubItems[3] := TCustomEdit(FindComponent(pfx + 'position_z')).Text;
      SubItems[4] := TCustomEdit(FindComponent(pfx + 'waittime')).Text;
      SubItems[5] := TCustomEdit(FindComponent(pfx + 'text1')).Text;
      SubItems[6] := TCustomEdit(FindComponent(pfx + 'text2')).Text;
      SubItems[7] := TCustomEdit(FindComponent(pfx + 'text3')).Text;
      SubItems[8] := TCustomEdit(FindComponent(pfx + 'text4')).Text;
      SubItems[9] := TCustomEdit(FindComponent(pfx + 'text5')).Text;
      SubItems[10] := TCustomEdit(FindComponent(pfx + 'emote')).Text;
      SubItems[11] := TCustomEdit(FindComponent(pfx + 'spell')).Text;
      SubItems[12] := TCustomEdit(FindComponent(pfx + 'wpguid')).Text;
      SubItems[13] := TCustomEdit(FindComponent(pfx + 'orientation')).Text;
      SubItems[14] := TCustomEdit(FindComponent(pfx + 'model1')).Text;
      SubItems[15] := TCustomEdit(FindComponent(pfx + 'model2')).Text;
    end;
  end;
end;

procedure TMainForm.EventAIUpd(pfx: string; lvList: TJvListView);
begin
  if Assigned(lvList.Selected) then
  begin
    with lvList.Selected do
    begin
      Caption := TCustomEdit(FindComponent(pfx + 'id')).Text;
      SubItems[0] := TCustomEdit(FindComponent(pfx + 'creature_id')).Text;
      SubItems[1] := TCustomEdit(FindComponent(pfx + 'event_type')).Text;
      SubItems[2] := TCustomEdit(FindComponent(pfx + 'event_inverse_phase_mask')).Text;
      SubItems[3] := TCustomEdit(FindComponent(pfx + 'event_chance')).Text;
      SubItems[4] := TCustomEdit(FindComponent(pfx + 'event_flags')).Text;
      SubItems[5] := TCustomEdit(FindComponent(pfx + 'event_param1')).Text;
      SubItems[6] := TCustomEdit(FindComponent(pfx + 'event_param2')).Text;
      SubItems[7] := TCustomEdit(FindComponent(pfx + 'event_param3')).Text;
      SubItems[8] := TCustomEdit(FindComponent(pfx + 'event_param4')).Text;
      SubItems[9] := TCustomEdit(FindComponent(pfx + 'action1_type')).Text;
      SubItems[10] := TCustomEdit(FindComponent(pfx + 'action1_param1')).Text;
      SubItems[11] := TCustomEdit(FindComponent(pfx + 'action1_param2')).Text;
      SubItems[12] := TCustomEdit(FindComponent(pfx + 'action1_param3')).Text;
      SubItems[13] := TCustomEdit(FindComponent(pfx + 'action2_type')).Text;
      SubItems[14] := TCustomEdit(FindComponent(pfx + 'action2_param1')).Text;
      SubItems[15] := TCustomEdit(FindComponent(pfx + 'action2_param2')).Text;
      SubItems[16] := TCustomEdit(FindComponent(pfx + 'action2_param3')).Text;
      SubItems[17] := TCustomEdit(FindComponent(pfx + 'action3_type')).Text;
      SubItems[18] := TCustomEdit(FindComponent(pfx + 'action3_param1')).Text;
      SubItems[19] := TCustomEdit(FindComponent(pfx + 'action3_param2')).Text;
      SubItems[20] := TCustomEdit(FindComponent(pfx + 'action3_param3')).Text;
      SubItems[21] := TCustomEdit(FindComponent(pfx + 'comment')).Text;
    end;
  end;
end;

procedure TMainForm.SmartAIUpd(pfx: string; lvList: TJvListView);
begin
  if Assigned(lvList.Selected) then
  begin
    with lvList.Selected do
    begin
      Caption := TCustomEdit(FindComponent(pfx + 'entryorguid')).Text;
      SubItems[0] := TCustomEdit(FindComponent(pfx + 'source_type')).Text;
      SubItems[1] := TCustomEdit(FindComponent(pfx + 'id')).Text;
      SubItems[2] := TCustomEdit(FindComponent(pfx + 'link')).Text;
      SubItems[3] := TCustomEdit(FindComponent(pfx + 'event_type')).Text;
      SubItems[4] := TCustomEdit(FindComponent(pfx + 'event_phase_mask')).Text;
      SubItems[5] := TCustomEdit(FindComponent(pfx + 'event_chance')).Text;
      SubItems[6] := TCustomEdit(FindComponent(pfx + 'event_flags')).Text;
      SubItems[7] := TCustomEdit(FindComponent(pfx + 'event_param1')).Text;
      SubItems[8] := TCustomEdit(FindComponent(pfx + 'event_param2')).Text;
      SubItems[9] := TCustomEdit(FindComponent(pfx + 'event_param3')).Text;
      SubItems[10] := TCustomEdit(FindComponent(pfx + 'event_param4')).Text;
      SubItems[11] := TCustomEdit(FindComponent(pfx + 'action_type')).Text;
      SubItems[12] := TCustomEdit(FindComponent(pfx + 'action_param1')).Text;
      SubItems[13] := TCustomEdit(FindComponent(pfx + 'action_param2')).Text;
      SubItems[14] := TCustomEdit(FindComponent(pfx + 'action_param3')).Text;
      SubItems[15] := TCustomEdit(FindComponent(pfx + 'action_param4')).Text;
      SubItems[16] := TCustomEdit(FindComponent(pfx + 'action_param5')).Text;
      SubItems[17] := TCustomEdit(FindComponent(pfx + 'action_param6')).Text;
      SubItems[18] := TCustomEdit(FindComponent(pfx + 'target_type')).Text;
      SubItems[19] := TCustomEdit(FindComponent(pfx + 'target_param1')).Text;
      SubItems[20] := TCustomEdit(FindComponent(pfx + 'target_param2')).Text;
      SubItems[21] := TCustomEdit(FindComponent(pfx + 'target_param3')).Text;
      SubItems[22] := TCustomEdit(FindComponent(pfx + 'target_x')).Text;
      SubItems[23] := TCustomEdit(FindComponent(pfx + 'target_y')).Text;
      SubItems[24] := TCustomEdit(FindComponent(pfx + 'target_z')).Text;
      SubItems[25] := TCustomEdit(FindComponent(pfx + 'target_o')).Text;
      SubItems[26] := TCustomEdit(FindComponent(pfx + 'comment')).Text;
    end;
  end;
end;

procedure TMainForm.MyTrinityConnectionBeforeConnect(Sender: TObject);
begin
  try
//    MyTrinityConnection.Options.Charset := ReadFromRegistry(CurrentUser, '', 'Charset', tpString);
  except
//    MyTrinityConnection.Options.Charset := '';
  end;
  try
//    MyTrinityConnection.Options.UseUnicode := ReadFromRegistry(CurrentUser, '', 'Unicode', tpBool);
  except
//    MyTrinityConnection.Options.UseUnicode := false;
  end;
end;

procedure TMainForm.btCreatureLootAddClick(Sender: TObject);
begin
  LootAdd('edco', lvcoCreatureLoot);
end;

procedure TMainForm.btCreatureLootUpdClick(Sender: TObject);
begin
  LootUpd('edco', lvcoCreatureLoot);
end;

procedure TMainForm.btCreatureModelSearchClick(Sender: TObject);
begin
  SearchCreatureModelInfo();
  with lvCreatureModelSearch do
    if Items.Count>0 then
    begin
      SetFocus;
      Selected := Items[0];
    end;
end;

procedure TMainForm.btCreatureMvmntAddClick(Sender: TObject);
begin
  MvmntAdd('edcm', lvcmMovement);
end;

procedure TMainForm.btCreatureMvmntDelClick(Sender: TObject);
begin
  MvmntDel(lvcmMovement);
end;

procedure TMainForm.btCreatureMvmntUpdClick(Sender: TObject);
begin
  MvmntUpd('edcm', lvcmMovement);
end;

procedure TMainForm.btCreatureLootDelClick(Sender: TObject);
begin
  LootDel(lvcoCreatureLoot);
end;

procedure TMainForm.LootAdd(pfx: string; lvList: TJvListView);
begin
  with lvList.Items.Add do
  begin
    Caption := TCustomEdit(FindComponent(pfx + 'entry')).Text;
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'item')).Text);
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'ChanceOrQuestChance')).Text);
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'lootmode')).Text);
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'groupid')).Text);
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'mincountOrRef')).Text);
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'maxcount')).Text);
  end;
end;

procedure TMainForm.EventAIAdd(pfx: string; lvList: TJvListView);
begin
  with lvList.Items.Add do
  begin
    Caption := TCustomEdit(FindComponent(pfx + 'id')).Text;
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'creature_id')).Text);
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'event_type')).Text);
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'event_inverse_phase_mask')).Text);
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'event_chance')).Text);
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'event_flags')).Text);
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'event_param1')).Text);
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'event_param2')).Text);
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'event_param3')).Text);
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'event_param4')).Text);
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'action1_type')).Text);
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'action1_param1')).Text);
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'action1_param2')).Text);
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'action1_param3')).Text);
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'action2_type')).Text);
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'action2_param1')).Text);
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'action2_param2')).Text);
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'action2_param3')).Text);
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'action3_type')).Text);
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'action3_param1')).Text);
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'action3_param2')).Text);
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'action3_param3')).Text);
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'comment')).Text);
  end;
end;

procedure TMainForm.SmartAIAdd(pfx: string; lvList: TJvListView);
begin
  with lvList.Items.Add do
  begin
    Caption := TCustomEdit(FindComponent(pfx + 'entryorguid')).Text;
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'source_type')).Text);
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'id')).Text);
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'link')).Text);
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'event_type')).Text);
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'event_phase_mask')).Text);
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'event_chance')).Text);
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'event_flags')).Text);
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'event_param1')).Text);
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'event_param2')).Text);
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'event_param3')).Text);
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'event_param4')).Text);
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'action_type')).Text);
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'action_param1')).Text);
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'action_param2')).Text);
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'action_param3')).Text);
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'action_param4')).Text);
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'action_param5')).Text);
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'action_param6')).Text);
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'target_type')).Text);
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'target_param1')).Text);
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'target_param2')).Text);
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'target_param3')).Text);
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'target_x')).Text);
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'target_y')).Text);
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'target_z')).Text);
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'target_o')).Text);
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'comment')).Text);
  end;
end;

procedure TMainForm.LootUpd(pfx: string; lvList: TJvListView);
begin
  if Assigned(lvList.Selected) then
  begin
    with lvList.Selected do
    begin
      Caption := TCustomEdit(FindComponent(pfx + 'entry')).Text;
      SubItems[0] := TCustomEdit(FindComponent(pfx + 'item')).Text;
      SubItems[1] := TCustomEdit(FindComponent(pfx + 'ChanceOrQuestChance')).Text;
      SubItems[2] := TCustomEdit(FindComponent(pfx + 'lootmode')).Text;
      SubItems[3] := TCustomEdit(FindComponent(pfx + 'groupid')).Text;
      SubItems[4] := TCustomEdit(FindComponent(pfx + 'mincountOrRef')).Text;
      SubItems[5] := TCustomEdit(FindComponent(pfx + 'maxcount')).Text;
    end;
  end;
end;

procedure TMainForm.LootDel(lvList: TJvListView);
begin
  if Assigned(lvList.Selected) then
    lvList.DeleteSelected;
end;           

procedure TMainForm.SetLootEditFields(pfx: string;
  lvList: TJvListView);
begin
  if Assigned(lvList.Selected) then
  begin
    with lvList.Selected do
    begin
      TCustomEdit(FindComponent(pfx + 'entry')).Text := Caption;
      TCustomEdit(FindComponent(pfx + 'item')).Text := SubItems[0];
      TCustomEdit(FindComponent(pfx + 'ChanceOrQuestChance')).Text := SubItems[1];
      TCustomEdit(FindComponent(pfx + 'lootmode')).Text := SubItems[2];
      TCustomEdit(FindComponent(pfx + 'groupid')).Text := SubItems[3];
      TCustomEdit(FindComponent(pfx + 'mincountOrRef')).Text := SubItems[4];
      TCustomEdit(FindComponent(pfx + 'maxcount')).Text := SubItems[5];
    end;
  end;
end;

procedure TMainForm.SetMvmntEditFields(pfx: string; lvList: TJvListView);
begin
  if Assigned(lvList.Selected) then
  begin
    with lvList.Selected do
    begin
      TCustomEdit(FindComponent(pfx + 'id')).Text := Caption;
      TCustomEdit(FindComponent(pfx + 'point')).Text := SubItems[0];
      TCustomEdit(FindComponent(pfx + 'position_x')).Text := SubItems[1];
      TCustomEdit(FindComponent(pfx + 'position_y')).Text := SubItems[2];
      TCustomEdit(FindComponent(pfx + 'position_z')).Text := SubItems[3];
      TCustomEdit(FindComponent(pfx + 'waittime')).Text := SubItems[4];
      TCustomEdit(FindComponent(pfx + 'textid1')).Text := SubItems[5];
      TCustomEdit(FindComponent(pfx + 'textid2')).Text := SubItems[6];
      TCustomEdit(FindComponent(pfx + 'textid3')).Text := SubItems[7];
      TCustomEdit(FindComponent(pfx + 'textid4')).Text := SubItems[8];
      TCustomEdit(FindComponent(pfx + 'textid5')).Text := SubItems[9];
      TCustomEdit(FindComponent(pfx + 'emote')).Text := SubItems[10];
      TCustomEdit(FindComponent(pfx + 'spell')).Text := SubItems[11];
      TCustomEdit(FindComponent(pfx + 'wpguid')).Text := SubItems[12];
      TCustomEdit(FindComponent(pfx + 'orientation')).Text := SubItems[13];
      TCustomEdit(FindComponent(pfx + 'model1')).Text := SubItems[14];
      TCustomEdit(FindComponent(pfx + 'model2')).Text := SubItems[15];
    end;
  end;
end;

procedure TMainForm.SetEventAIEditFields(pfx: string; lvList: TJvListView);
begin
  if Assigned(lvList.Selected) then
  begin
    with lvList.Selected do
    begin
      TCustomEdit(FindComponent(pfx + 'id')).Text := Caption;
      TCustomEdit(FindComponent(pfx + 'creature_id')).Text := SubItems[0];
      TCustomEdit(FindComponent(pfx + 'event_type')).Text := SubItems[1];
      TCustomEdit(FindComponent(pfx + 'event_inverse_phase_mask')).Text := SubItems[2];
      TCustomEdit(FindComponent(pfx + 'event_chance')).Text := SubItems[3];
      TCustomEdit(FindComponent(pfx + 'event_flags')).Text := SubItems[4];
      TCustomEdit(FindComponent(pfx + 'event_param1')).Text := SubItems[5];
      TCustomEdit(FindComponent(pfx + 'event_param2')).Text := SubItems[6];
      TCustomEdit(FindComponent(pfx + 'event_param3')).Text := SubItems[7];
      TCustomEdit(FindComponent(pfx + 'event_param4')).Text := SubItems[8];
      TCustomEdit(FindComponent(pfx + 'action1_type')).Text := SubItems[9];
      TCustomEdit(FindComponent(pfx + 'action1_param1')).Text := SubItems[10];
      TCustomEdit(FindComponent(pfx + 'action1_param2')).Text := SubItems[11];
      TCustomEdit(FindComponent(pfx + 'action1_param3')).Text := SubItems[12];
      TCustomEdit(FindComponent(pfx + 'action2_type')).Text := SubItems[13];
      TCustomEdit(FindComponent(pfx + 'action2_param1')).Text := SubItems[14];
      TCustomEdit(FindComponent(pfx + 'action2_param2')).Text := SubItems[15];
      TCustomEdit(FindComponent(pfx + 'action2_param3')).Text := SubItems[16];
      TCustomEdit(FindComponent(pfx + 'action3_type')).Text := SubItems[17];
      TCustomEdit(FindComponent(pfx + 'action3_param1')).Text := SubItems[18];
      TCustomEdit(FindComponent(pfx + 'action3_param2')).Text := SubItems[19];
      TCustomEdit(FindComponent(pfx + 'action3_param3')).Text := SubItems[20];
      TCustomEdit(FindComponent(pfx + 'comment')).Text := SubItems[21];
    end;
  end;
end;

procedure TMainForm.SetSmartAIEditFields(pfx: string; lvList: TJvListView);
begin
  if Assigned(lvList.Selected) then
  begin
    with lvList.Selected do
    begin
      TCustomEdit(FindComponent(pfx + 'entryorguid')).Text := Caption;
      TCustomEdit(FindComponent(pfx + 'source_type')).Text := SubItems[0];
      TCustomEdit(FindComponent(pfx + 'id')).Text := SubItems[1];
      TCustomEdit(FindComponent(pfx + 'link')).Text := SubItems[2];
      TCustomEdit(FindComponent(pfx + 'event_type')).Text := SubItems[3];
      TCustomEdit(FindComponent(pfx + 'event_phase_mask')).Text := SubItems[4];
      TCustomEdit(FindComponent(pfx + 'event_chance')).Text := SubItems[5];
      TCustomEdit(FindComponent(pfx + 'event_flags')).Text := SubItems[6];
      TCustomEdit(FindComponent(pfx + 'event_param1')).Text := SubItems[7];
      TCustomEdit(FindComponent(pfx + 'event_param2')).Text := SubItems[8];
      TCustomEdit(FindComponent(pfx + 'event_param3')).Text := SubItems[9];
      TCustomEdit(FindComponent(pfx + 'event_param4')).Text := SubItems[10];
      TCustomEdit(FindComponent(pfx + 'action_type')).Text := SubItems[11];
      TCustomEdit(FindComponent(pfx + 'action_param1')).Text := SubItems[12];
      TCustomEdit(FindComponent(pfx + 'action_param2')).Text := SubItems[13];
      TCustomEdit(FindComponent(pfx + 'action_param3')).Text := SubItems[14];
      TCustomEdit(FindComponent(pfx + 'action_param4')).Text := SubItems[15];
      TCustomEdit(FindComponent(pfx + 'action_param5')).Text := SubItems[16];
      TCustomEdit(FindComponent(pfx + 'action_param6')).Text := SubItems[17];
      TCustomEdit(FindComponent(pfx + 'target_type')).Text := SubItems[18];
      TCustomEdit(FindComponent(pfx + 'target_param1')).Text := SubItems[19];
      TCustomEdit(FindComponent(pfx + 'target_param2')).Text := SubItems[20];
      TCustomEdit(FindComponent(pfx + 'target_param3')).Text := SubItems[21];
      TCustomEdit(FindComponent(pfx + 'target_x')).Text := SubItems[22];
      TCustomEdit(FindComponent(pfx + 'target_y')).Text := SubItems[23];
      TCustomEdit(FindComponent(pfx + 'target_z')).Text := SubItems[24];
      TCustomEdit(FindComponent(pfx + 'target_o')).Text := SubItems[25];
      TCustomEdit(FindComponent(pfx + 'comment')).Text := SubItems[26];
    end;
  end;
end;

procedure TMainForm.btFullScriptCreatureLocationClick(Sender: TObject);
begin
  PageControl3.ActivePageIndex := SCRIPT_TAB_NO_CREATURE;
  mectScript.Text := FullScript('creature', 'id', edctEntry.Text);
end;

function TMainForm.FullScript(TableName, KeyName, KeyValue: string): string;
var
  i: integer;
  s1, s2, s3, s4: string;
begin
  if trim(KeyValue)='' then exit;

  s1 := Format('DELETE FROM `%s` WHERE `%s`=%s;'#13#10,[TableName, KeyName, KeyValue]);
  MyQuery.SQL.Text := Format('SELECT * FROM `%s` WHERE `%s`=%s',[TableName, KeyName, KeyValue]);
  MyQuery.Open;
  if not MyQuery.Eof then
  begin
    s2 := Format('`%s`',[MyQuery.Fields[0].FieldName]);
    for I := 1 to MyQuery.FieldCount - 1 do
      s2 := Format('%s,`%s`',[s2, MyQuery.Fields[I].FieldName]);

    s4 := '';
    while not MyQuery.Eof do
    begin
      s3 := Format('%s',[MyQuery.Fields[0].AsString]);
      for I := 1 to MyQuery.FieldCount - 1 do
      begin
        if IsNumber(MyQuery.Fields[i].AsString) then
          s3 := Format('%s, %s',[s3, MyQuery.Fields[I].AsString])
        else
          s3 := Format('%s, ''%s''',[s3, MyQuery.Fields[I].AsString]);
      end;
      MyQuery.Next;
      if MyQuery.Eof then
        s4 := Format('%s(%s);'#13#10,[s4, s3])
      else
        s4 := Format('%s(%s),'#13#10,[s4, s3]);
    end;
  end;
  MyQuery.Close;
  Result := Format('%sINSERT INTO `%s` (%s) VALUES'#13#10'%s',[s1,TableName,s2,s4]);
end;

procedure TMainForm.btFullScriptCreatureLootClick(Sender: TObject);
begin
  PageControl3.ActivePageIndex := SCRIPT_TAB_NO_CREATURE;
  ShowFullLootScript('creature_loot_template', lvcoCreatureLoot, mectScript, edctlootid.Text);
end;

procedure TMainForm.ShowFullLootScript(TableName: string; lvList: TJvListView;
  Memo: TMemo; entry: string);
var
  i: integer;
  Values: string;
begin
  Memo.Clear;
  Values := '';
  if lvList.Items.Count<>0 then
  begin
    for i := 0 to lvList.Items.Count - 2 do
    begin
      Values := Values + Format('(%s, %s, %s, %s, %s, %s, %s),'#13#10,[
        lvList.Items[i].Caption,
        lvList.Items[i].SubItems[0],
        lvList.Items[i].SubItems[1],
        lvList.Items[i].SubItems[2],
        lvList.Items[i].SubItems[3],
        lvList.Items[i].SubItems[4],
        lvList.Items[i].SubItems[5]
      ]);
    end;
    i := lvList.Items.Count - 1;
    Values := Values + Format('(%s, %s, %s, %s, %s, %s, %s);',[
      lvList.Items[i].Caption,
      lvList.Items[i].SubItems[0],
      lvList.Items[i].SubItems[1],
      lvList.Items[i].SubItems[2],
      lvList.Items[i].SubItems[3],
      lvList.Items[i].SubItems[4],
      lvList.Items[i].SubItems[5]
    ]);
  end;
  if values<>'' then
  begin
      Memo.Text := Format('DELETE FROM `%0:s` WHERE (`entry`=%1:s);'#13#10+
       'INSERT INTO `%0:s` VALUES '#13#10'%2:s',[TableName, entry, Values]);
  end
  else
    Memo.Text := Format('DELETE FROM `%s` WHERE (`entry`=%s);', [TableName, entry]);
end;

procedure TMainForm.ShowFullEventAiScript(TableName: string; lvList: TJvListView;
  Memo: TMemo; entry: string);
var
  i: integer;
  Values: string;
begin
  Memo.Clear;
  Values := '';
  if lvList.Items.Count<>0 then
  begin
    for i := 0 to lvList.Items.Count - 2 do
    begin
      Values := Values + Format('( %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, '+''''+'%s'+''''+'),'#13#10,[
        lvList.Items[i].Caption,
        lvList.Items[i].SubItems[0],
        lvList.Items[i].SubItems[1],
        lvList.Items[i].SubItems[2],
        lvList.Items[i].SubItems[3],
        lvList.Items[i].SubItems[4],
        lvList.Items[i].SubItems[5],
        lvList.Items[i].SubItems[6],
        lvList.Items[i].SubItems[7],
        lvList.Items[i].SubItems[8],
        lvList.Items[i].SubItems[9],
        lvList.Items[i].SubItems[10],
        lvList.Items[i].SubItems[11],
        lvList.Items[i].SubItems[12],
        lvList.Items[i].SubItems[13],
        lvList.Items[i].SubItems[14],
        lvList.Items[i].SubItems[15],
        lvList.Items[i].SubItems[16],
        lvList.Items[i].SubItems[17],
        lvList.Items[i].SubItems[18],
        lvList.Items[i].SubItems[19],
        lvList.Items[i].SubItems[20],
        lvList.Items[i].SubItems[21]
      ]);
    end;
    i := lvList.Items.Count - 1;
    Values := Values + Format('(%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, '+''''+'%s'+''''+');',[
      lvList.Items[i].Caption,
      lvList.Items[i].SubItems[0],
      lvList.Items[i].SubItems[1],
      lvList.Items[i].SubItems[2],
      lvList.Items[i].SubItems[3],
      lvList.Items[i].SubItems[4],
      lvList.Items[i].SubItems[5],
      lvList.Items[i].SubItems[6],
      lvList.Items[i].SubItems[7],
      lvList.Items[i].SubItems[8],
      lvList.Items[i].SubItems[9],
      lvList.Items[i].SubItems[10],
      lvList.Items[i].SubItems[11],
      lvList.Items[i].SubItems[12],
      lvList.Items[i].SubItems[13],
      lvList.Items[i].SubItems[14],
      lvList.Items[i].SubItems[15],
      lvList.Items[i].SubItems[16],
      lvList.Items[i].SubItems[17],
      lvList.Items[i].SubItems[18],
      lvList.Items[i].SubItems[19],
      lvList.Items[i].SubItems[20],
      lvList.Items[i].SubItems[21]
    ]);
  end;
  if values<>'' then
  begin
      Memo.Text := Format('DELETE FROM `%0:s` WHERE (`creature_id`=%1:s);'#13#10+
       'INSERT INTO `%0:s` VALUES '#13#10'%2:s',[TableName, entry, Values]);
  end
  else
    Memo.Text := Format('DELETE FROM `%s` WHERE (`creature_id`=%s);', [TableName, entry]);
end;

procedure TMainForm.ShowFullSmartAIScript(TableName: string; lvList: TJvListView;
  Memo: TMemo; entry: string; sourcetype: string);
var
  i: integer;
  Values: string;
begin
  Memo.Clear;
  Values := '';
  if lvList.Items.Count<>0 then
  begin
    for i := 0 to lvList.Items.Count - 2 do
    begin
      Values := Values + Format('(%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, '+''''+'%s'+''''+'),'#13#10,[
        lvList.Items[i].Caption,
        lvList.Items[i].SubItems[0],
        lvList.Items[i].SubItems[1],
        lvList.Items[i].SubItems[2],
        lvList.Items[i].SubItems[3],
        lvList.Items[i].SubItems[4],
        lvList.Items[i].SubItems[5],
        lvList.Items[i].SubItems[6],
        lvList.Items[i].SubItems[7],
        lvList.Items[i].SubItems[8],
        lvList.Items[i].SubItems[9],
        lvList.Items[i].SubItems[10],
        lvList.Items[i].SubItems[11],
        lvList.Items[i].SubItems[12],
        lvList.Items[i].SubItems[13],
        lvList.Items[i].SubItems[14],
        lvList.Items[i].SubItems[15],
        lvList.Items[i].SubItems[16],
        lvList.Items[i].SubItems[17],
        lvList.Items[i].SubItems[18],
        lvList.Items[i].SubItems[19],
        lvList.Items[i].SubItems[20],
        lvList.Items[i].SubItems[21],
        lvList.Items[i].SubItems[22],
        lvList.Items[i].SubItems[23],
        lvList.Items[i].SubItems[24],
        lvList.Items[i].SubItems[25],
        lvList.Items[i].SubItems[26]
      ]);
    end;
    i := lvList.Items.Count - 1;
    Values := Values + Format('(%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, '+''''+'%s'+''''+');',[
      lvList.Items[i].Caption,
      lvList.Items[i].SubItems[0],
      lvList.Items[i].SubItems[1],
      lvList.Items[i].SubItems[2],
      lvList.Items[i].SubItems[3],
      lvList.Items[i].SubItems[4],
      lvList.Items[i].SubItems[5],
      lvList.Items[i].SubItems[6],
      lvList.Items[i].SubItems[7],
      lvList.Items[i].SubItems[8],
      lvList.Items[i].SubItems[9],
      lvList.Items[i].SubItems[10],
      lvList.Items[i].SubItems[11],
      lvList.Items[i].SubItems[12],
      lvList.Items[i].SubItems[13],
      lvList.Items[i].SubItems[14],
      lvList.Items[i].SubItems[15],
      lvList.Items[i].SubItems[16],
      lvList.Items[i].SubItems[17],
      lvList.Items[i].SubItems[18],
      lvList.Items[i].SubItems[19],
      lvList.Items[i].SubItems[20],
      lvList.Items[i].SubItems[21],
      lvList.Items[i].SubItems[22],
      lvList.Items[i].SubItems[23],
      lvList.Items[i].SubItems[24],
      lvList.Items[i].SubItems[25],
      lvList.Items[i].SubItems[26]
    ]);
  end;
  if values<>'' then
  begin
      Memo.Text := Format('DELETE FROM `%0:s` WHERE (`entryorguid`=%1:s AND `source_type`=%2:s);'#13#10+
        'INSERT INTO `%0:s` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, '+
				'`event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, '+
				'`action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, '+
				'`action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, '+
				'`target_y`, `target_z`, `target_o`, `comment`) VALUES '#13#10'%3:s',[TableName, entry, sourcetype, Values]);
  end
  else
    Memo.Text := Format('DELETE FROM `%s` WHERE (`entryorguid`=%s AND `source_type`=%s);', [TableName, entry, sourcetype]);
end;

procedure TMainForm.btPickpocketLootAddClick(Sender: TObject);
begin
  LootAdd('edcp', lvcoPickpocketLoot);
end;

procedure TMainForm.btPickpocketLootUpdClick(Sender: TObject);
begin
  LootUpd('edcp', lvcoPickpocketLoot);
end;

procedure TMainForm.btPickpocketLootDelClick(Sender: TObject);
begin
  LootDel(lvcoPickpocketLoot);
end;

procedure TMainForm.btFullScriptPickpocketLootClick(Sender: TObject);
begin
  PageControl3.ActivePageIndex := SCRIPT_TAB_NO_CREATURE;
  ShowFullLootScript('pickpocketing_loot_template', lvcoPickpocketLoot, mectScript, edctpickpocketloot.Text);
end;

procedure TMainForm.btSkinLootAddClick(Sender: TObject);
begin
  LootAdd('edcs', lvcoSkinLoot);
end;

procedure TMainForm.btSkinLootUpdClick(Sender: TObject);
begin
  LootUpd('edcs', lvcoSkinLoot);
end;

procedure TMainForm.btSkinLootDelClick(Sender: TObject);
begin
  LootDel(lvcoSkinLoot);
end;

procedure TMainForm.btFullScriptSkinLootClick(Sender: TObject);
begin
  PageControl3.ActivePageIndex := SCRIPT_TAB_NO_CREATURE;
  ShowFullLootScript('skinning_loot_template', lvcoSkinLoot, mectScript, edctskinloot.Text);
end;

procedure TMainForm.btGOLootAddClick(Sender: TObject);
begin
  LootAdd('edgo', lvgoGOLoot);
end;

procedure TMainForm.btGOLootUpdClick(Sender: TObject);
begin
  LootUpd('edgo', lvgoGOLoot);
end;

procedure TMainForm.btgtGotoSmartAIClick(Sender: TObject);
begin
	edcyentryorguid.Text := edgtentry.Text;
	edcysource_type.Text := '1';
	PageControl1.ActivePageIndex := 4;
  btcyLoadClick(Sender);
end;

procedure TMainForm.btGOLootDelClick(Sender: TObject);
begin
  LootDel(lvgoGOLoot);
end;

procedure TMainForm.btFullScriptGOLootClick(Sender: TObject);
begin
  PageControl4.ActivePageIndex := SCRIPT_TAB_NO_GAMEOBJECT;
  ShowFullLootScript('gameobject_loot_template', lvgoGOLoot, megoScript, edgtdata1.Text);
end;

procedure TMainForm.btVendorAddClick(Sender: TObject);
begin
  with lvcvNPCVendor.Items.Add do
  begin
    Caption := edcventry.Text;
    SubItems.Add(edcvslot.Text);
    SubItems.Add(edcvitem.Text);
    SubItems.Add(edcvmaxcount.Text);
    SubItems.Add(edcvincrtime.Text);
    SubItems.Add(edcvExtendedCost.Text);    
  end;
end;

procedure TMainForm.btVendorUpdClick(Sender: TObject);
begin
  if Assigned(lvcvNPCVendor.Selected) then
  begin
    with lvcvNPCVendor.Selected do
    begin
      Caption := edcventry.Text;
      SubItems[0] := edcvslot.Text;
      SubItems[1] := edcvitem.Text;
      SubItems[2] := edcvmaxcount.Text;
      SubItems[3] := edcvincrtime.Text;
      SubItems[4] := edcvExtendedCost.Text;
    end;
  end;
end;

procedure TMainForm.Button1Click(Sender: TObject);
begin
  PageControl3.ActivePageIndex := SCRIPT_TAB_NO_CREATURE;
  ShowFullEventAiScript('creature_ai_scripts', lvcnEventAI, mectScript, edctEntry.Text);
end;

procedure TMainForm.btctGoToSmartAIClick(Sender: TObject);
begin
	edcyentryorguid.Text := edctEntry.Text;
  edcysource_type.Text := '0';
  PageControl1.ActivePageIndex := 4;
  btcyLoadClick(Sender);
end;

procedure TMainForm.btcyFullScriptClick(Sender: TObject);
begin
  PageControl9.ActivePageIndex := SCRIPT_TAB_NO_SMARTAI;
  ShowFullSmartAIScript('smart_scripts', lvcySmartAI, mecyScript, edcyentryorguid.Text, edcysource_type.Text);
end;

procedure TMainForm.btFullScriptReferenceLootClick(Sender: TObject);
begin
PageControl5.ActivePageIndex := SCRIPT_TAB_NO_ITEM;
ShowFullLootScript('reference_loot_template', lvitReferenceLoot, meitScript, editentry.Text);
end;

procedure TMainForm.btShowCharacterScriptClick(Sender: TObject);
begin
  PageControl8.ActivePageIndex := SCRIPT_TAB_NO_CHARACTER;
end;

procedure TMainForm.btShowFULLCharacterInventoryScriptClick(Sender: TObject);
begin
  PageControl8.ActivePageIndex := SCRIPT_TAB_NO_CHARACTER;
//  ShowFullLootScript('item_loot_template', lvitItemLoot, meitScript, editentry.Text);
end;

procedure TMainForm.btFullCreatureMovementScriptClick(Sender: TObject);
begin
  PageControl3.ActivePageIndex := SCRIPT_TAB_NO_CREATURE;
  //mectScript.Text := FullScript('creature_movement', 'id', edclguid.Text); //disable creature_movement
  //ShowFullMvmntScript('creature_movement', lvcmMovement, mectScript, edclguid.Text);
end;

procedure TMainForm.btFullScriptGOLocationClick(Sender: TObject);
begin
  PageControl4.ActivePageIndex := SCRIPT_TAB_NO_GAMEOBJECT;
  megoScript.Text := FullScript('gameobject', 'id', edgtentry.Text);
end;

procedure TMainForm.btVendorDelClick(Sender: TObject);
begin
  if Assigned(lvcvNPCVendor.Selected) then
    lvcvNPCVendor.DeleteSelected;
end;

procedure TMainForm.btFullScriptVendorClick(Sender: TObject);
var
  i: integer;
  entry, Values: string;
begin
  PageControl3.ActivePageIndex := SCRIPT_TAB_NO_CREATURE;
  entry := edctEntry.Text;
  mectScript.Clear;
  Values := '';
  if lvcvNPCVendor.Items.Count<>0 then
  begin
    for i := 0 to lvcvNPCVendor.Items.Count - 2 do
    begin
      Values := Values + Format('(%s, %s, %s, %s, %s, %s),'#13#10,[
        lvcvNPCVendor.Items[i].Caption,
        lvcvNPCVendor.Items[i].SubItems[0],
        lvcvNPCVendor.Items[i].SubItems[1],
        lvcvNPCVendor.Items[i].SubItems[2],
        lvcvNPCVendor.Items[i].SubItems[3],
        lvcvNPCVendor.Items[i].SubItems[4]
      ]);
    end;
    i := lvcvNPCVendor.Items.Count - 1;
    Values := Values + Format('(%s, %s, %s, %s, %s, %s);',[
      lvcvNPCVendor.Items[i].Caption,
      lvcvNPCVendor.Items[i].SubItems[0],
      lvcvNPCVendor.Items[i].SubItems[1],
      lvcvNPCVendor.Items[i].SubItems[2],
      lvcvNPCVendor.Items[i].SubItems[3],
      lvcvNPCVendor.Items[i].SubItems[4]
    ]);
  end;
  if Values<>'' then
  begin
    mectScript.Text := Format('DELETE FROM `npc_vendor` WHERE (`entry`=%s);'#13#10+
      'INSERT INTO `npc_vendor` (`entry`, `slot`, `item`, `maxcount`, `incrtime`, `ExtendedCost`) VALUES '#13#10'%s',[entry, Values])
  end
  else
    mectScript.Text := Format('DELETE FROM `npc_vendor` WHERE (`entry`=%s);',[entry]);
end;

procedure TMainForm.lvcvNPCVendorChange(Sender: TObject; Item: TListItem;
  Change: TItemChange);
begin
  btVendorUpd.Enabled := Assigned(TJvListView(Sender).Selected);
  btVendorDel.Enabled := Assigned(TJvListView(Sender).Selected);
end;

procedure TMainForm.lvcoSkinLootChange(Sender: TObject; Item: TListItem;
  Change: TItemChange);
begin
  btSkinLootUpd.Enabled := Assigned(TJvListView(Sender).Selected);
  btSkinLootDel.Enabled := Assigned(TJvListView(Sender).Selected);
end;

procedure TMainForm.lvcoPickpocketLootChange(Sender: TObject;
  Item: TListItem; Change: TItemChange);
begin
  btPickpocketLootUpd.Enabled := Assigned(TJvListView(Sender).Selected);
  btPickpocketLootDel.Enabled := Assigned(TJvListView(Sender).Selected);
end;

procedure TMainForm.lvcoCreatureLootChange(Sender: TObject;
  Item: TListItem; Change: TItemChange);
begin
  btCreatureLootUpd.Enabled := Assigned(TJvListView(Sender).Selected);
  btCreatureLootDel.Enabled := Assigned(TJvListView(Sender).Selected);
end;

procedure TMainForm.lvcoCreatureLootDblClick(Sender: TObject);
begin
  PageControl1.ActivePageIndex := 3;
  PageControl5.ActivePageIndex := 1;
  LoadItem(StrToIntDef(TJvListView(Sender).Selected.SubItems[0],0));
end;

procedure TMainForm.lvgoGOLootChange(Sender: TObject; Item: TListItem;
  Change: TItemChange);
begin
  btGOLootUpd.Enabled := Assigned(TJvListView(Sender).Selected);
  btGOLootDel.Enabled := Assigned(TJvListView(Sender).Selected);
end;

procedure TMainForm.btTrainerAddClick(Sender: TObject);
begin
  with lvcrNPCTrainer.Items.Add do
  begin
    Caption := edcrentry.Text;
    SubItems.Add(edcrspell.Text);
    SubItems.Add(edcrspellcost.Text);
    SubItems.Add(edcrreqskill.Text);
    SubItems.Add(edcrreqskillvalue.Text);
    SubItems.Add(edcrreqlevel.Text);
  end;
end;

procedure TMainForm.btTrainerUpdClick(Sender: TObject);
begin
  if Assigned(lvcrNPCTrainer.Selected) then
  begin
    with lvcrNPCTrainer.Selected do
    begin
      Caption := edcrentry.Text;
      SubItems[0] := edcrspell.Text;
      SubItems[1] := edcrspellcost.Text;
      SubItems[2] := edcrreqskill.Text;
      SubItems[3] := edcrreqskillvalue.Text;
      SubItems[4] := edcrreqlevel.Text;
    end;
  end;
end;

procedure TMainForm.btTrainerDelClick(Sender: TObject);
begin
  if Assigned(lvcrNPCTrainer.Selected) then
    lvcrNPCTrainer.DeleteSelected;
end;

procedure TMainForm.btFullScriptTrainerClick(Sender: TObject);
var
  i: integer;
  entry, Values: string;
begin
  PageControl3.ActivePageIndex := SCRIPT_TAB_NO_CREATURE;
  entry := edctEntry.Text;
  mectScript.Clear;
  Values := '';
  if lvcrNPCTrainer.Items.Count<>0 then
  begin
    for i := 0 to lvcrNPCTrainer.Items.Count - 2 do
    begin
      Values := Values + Format('(%s, %s, %s, %s, %s, %s),'#13#10,[
        lvcrNPCTrainer.Items[i].Caption,
        lvcrNPCTrainer.Items[i].SubItems[0],
        lvcrNPCTrainer.Items[i].SubItems[1],
        lvcrNPCTrainer.Items[i].SubItems[2],
        lvcrNPCTrainer.Items[i].SubItems[3],
        lvcrNPCTrainer.Items[i].SubItems[4]
      ]);
    end;
    i := lvcrNPCTrainer.Items.Count - 1;
    Values := Values + Format('(%s, %s, %s, %s, %s, %s);',[
      lvcrNPCTrainer.Items[i].Caption,
      lvcrNPCTrainer.Items[i].SubItems[0],
        lvcrNPCTrainer.Items[i].SubItems[1],
        lvcrNPCTrainer.Items[i].SubItems[2],
        lvcrNPCTrainer.Items[i].SubItems[3],
        lvcrNPCTrainer.Items[i].SubItems[4]
    ]);
  end;
  if Values<>'' then
  begin
    mectScript.Text := Format('DELETE FROM `npc_trainer` WHERE (`entry`=%s);'#13#10+
     'INSERT INTO `npc_trainer` (entry, spell, spellcost, reqskill, reqskillvalue, reqlevel) VALUES '#13#10'%s',[entry, Values])
  end
  else
    mectScript.Text := Format('DELETE FROM `npc_trainer` WHERE (`entry`=%s);',[entry]);
end;

procedure TMainForm.lvcrNPCTrainerChange(Sender: TObject; Item: TListItem;
  Change: TItemChange);
begin
  btTrainerUpd.Enabled := Assigned(TJvListView(Sender).Selected);
  btTrainerDel.Enabled := Assigned(TJvListView(Sender).Selected);
end;

procedure TMainForm.edSearchItemChange(Sender: TObject);
begin
  btEditItem.Default := False;
  btSearchItem.Default :=  True;
end;

procedure TMainForm.btClearSearchItemClick(Sender: TObject);
begin
  edSearchItemEntry.Clear;
  edSearchItemName.Clear;
  edSearchItemClass.Clear;
  edSearchItemSubclass.Clear;
  edSearchItemItemset.Clear;
  edSearchItemInventoryType.Clear;
  edSearchItemQuality.Clear;
  edSearchItemFlags.Clear;
  edSearchItemItemLevel.Clear;
  lvSearchItem.Clear;
end;

procedure TMainForm.lvSearchItemChange(Sender: TObject; Item: TListItem;
  Change: TItemChange);
var
  flag: boolean;
begin
  flag := Assigned(lvSearchItem.Selected);
  if flag then
    lvSearchItem.PopupMenu := pmItem
  else
    lvSearchItem.PopupMenu := nil;
  btEditItem.Enabled := flag;
  btDeleteItem.Enabled := flag;
  btBrowseItem.Enabled := flag;
  btBrowseItemPopup.Enabled := flag;
  nEditItem.Enabled := flag;
  nDeleteItem.Enabled := flag;
  nBrowseItem.Enabled := flag;
end;

procedure TMainForm.lvSearchItemCustomDrawSubItem(Sender: TCustomListView; Item: TListItem;
  SubItem: Integer; State: TCustomDrawState; var DefaultDraw: Boolean);
var
  sText: string;
  n: integer;
  ACanvas : TCanvas;
  ARect: TRect;
  i: integer;
begin
{  TCustomDrawState = set of (cdsSelected, cdsGrayed, cdsDisabled, cdsChecked,
    cdsFocused, cdsDefault, cdsHot, cdsMarked, cdsIndeterminate);
}
  DefaultDraw := true;
  ACanvas := TCustomListView(Sender).Canvas;
  ARect := Item.DisplayRect(drBounds);

  if SubItem = 0 then // caption
  begin
    sText := Item.Caption;
    n := 4;
  end
  else
  begin
    sText := Item.SubItems[SubItem-1];
    n := 8;
  end;

  ARect := Item.DisplayRect(drBounds);
  ARect.Right := ARect.Left;
  for I := 0 to SubItem do
    ARect.Right := ARect.Right + TCustomListView(Sender).Column[I].Width;
  ARect.Left := ARect.Right - TCustomListView(Sender).Column[SubItem].Width;

  if (cdsFocused in State) then
  begin
    DefaultDraw := false;
    ACanvas.Brush.Color := clNavy;
    ACanvas.Font.Color := $00FFFFFF;
    ACanvas.Font.Style := [fsBold];
    ACanvas.FrameRect(ARect);
    ACanvas.TextRect(ARect, ARect.Left+n, ARect.Top, sText);
  end
  else
  begin
    DefaultDraw := false;
    ACanvas.Brush.Color := clWhite;
    ACanvas.Font.Color := ItemColors[integer(Item.Data)];
    ACanvas.Font.Style := [fsBold];
    ACanvas.TextRect(ARect, ARect.Left+n, ARect.Top, sText);
  end;
end;

procedure TMainForm.btNewItemClick(Sender: TObject);
begin
  lvSearchItem.Selected := nil;
  ClearFields(ttItem);
  SetDefaultFields(ttItem);
  PageControl5.ActivePageIndex := 1;
end;

procedure TMainForm.btEditItemClick(Sender: TObject);
begin
  PageControl5.ActivePageIndex := 1;
  if Assigned(lvSearchItem.Selected) then
    LoadItem(StrToInt(lvSearchItem.Selected.Caption));
end;

procedure TMainForm.btDeleteItemClick(Sender: TObject);
begin
  PageControl5.ActivePageIndex := SCRIPT_TAB_NO_ITEM;
  meitScript.Text := Format(
  'DELETE FROM `item_template` WHERE (`entry`=%s);'#13#10
   ,[lvSearchItem.Selected.Caption]);
end;

procedure TMainForm.btBrowseItemClick(Sender: TObject);
begin
  if assigned(lvSearchItem.Selected) then
    dmMain.BrowseSite(ttItem, StrToInt(lvSearchItem.Selected.Caption));
end;

procedure TMainForm.btBrowsePopupClick(Sender: TObject);
var
  pt: TPoint;
begin
  pt.X := TButton(Sender).Width;
  pt.Y := 0;
  pt := TButton(Sender).ClientToScreen(pt);
  TButton(Sender).PopupMenu.PopupComponent := TButton(Sender);
  TButton(Sender).PopupMenu.Popup(pt.X, pt.Y);
end;

procedure TMainForm.lvSearchItemDblClick(Sender: TObject);
begin
  PageControl5.ActivePageIndex := 1;
  if Assigned(lvSearchItem.Selected) then
  begin
    LoadItem(StrToInt(lvSearchItem.Selected.Caption));
    CompleteItemScript;
  end;
end;

procedure TMainForm.btSearchItemClick(Sender: TObject);
begin
  SearchItem();
  with lvSearchItem do
    if Items.Count>0 then
    begin
      SetFocus;
      Selected := Items[0];
      btEditItem.Default := true;
      btSearchItem.Default := false;
    end;
  StatusBarItem.Panels[0].Text := Format(dmMain.Text[116], [lvSearchItem.Items.Count]);
end;

procedure TMainForm.CompleteItemLootScript;
var
  entry, item, Fields, Values: string;
begin
  meitLog.Clear;
  entry :=  edilentry.Text;
  item := edilitem.Text;
  if (entry='') or (item='') then Exit;
  SetFieldsAndValues(Fields, Values, 'item_loot_template', PFX_ITEM_LOOT_TEMPLATE, meitLog);
  meitScript.Text := Format('DELETE FROM `item_loot_template` WHERE (`entry`=%s) AND (`item`=%s);'#13#10+
    'INSERT INTO `item_loot_template` (%s) VALUES (%s);'#13#10,[entry, item, Fields, Values])
end;

procedure TMainForm.CompleteDisLootScript;
var
  entry, item, Fields, Values: string;
begin
  meitLog.Clear;
  entry :=  edidentry.Text;
  item := ediditem.Text;
  if (entry='') or (item='') then Exit;
  SetFieldsAndValues(Fields, Values, 'disenchant_loot_template', PFX_DISENCHANT_LOOT_TEMPLATE, meitLog);
  meitScript.Text := Format('DELETE FROM `disenchant_loot_template` WHERE (`entry`=%s) AND (`item`=%s);'#13#10+
    'INSERT INTO `disenchant_loot_template` (%s) VALUES (%s);'#13#10,[entry, item, Fields, Values])
end;

procedure TMainForm.CompleteProsLootScript;
var
  entry, item, Fields, Values: string;
begin
  meitLog.Clear;
  entry :=  edipentry.Text;
  item := edipitem.Text;
  if (entry='') or (item='') then Exit;
  SetFieldsAndValues(Fields, Values, 'prospecting_loot_template', PFX_PROSPECTING_LOOT_TEMPLATE, meitLog);
  meitScript.Text := Format('DELETE FROM `prospecting_loot_template` WHERE (`entry`=%s) AND (`item`=%s);'#13#10+
   'INSERT INTO `prospecting_loot_template` (%s) VALUES (%s);'#13#10,[entry, item, Fields, Values])
end;

procedure TMainForm.CompleteMillingLootScript;
var
  entry, item, Fields, Values: string;
begin
  meitLog.Clear;
  entry :=  edimentry.Text;
  item := edimitem.Text;
  if (entry='') or (item='') then Exit;
  SetFieldsAndValues(Fields, Values, 'milling_loot_template', PFX_MILLING_LOOT_TEMPLATE, meitLog);
  meitScript.Text := Format('DELETE FROM `milling_loot_template` WHERE (`entry`=%s) AND (`item`=%s);'#13#10+
   'INSERT INTO `milling_loot_template` (%s) VALUES (%s);'#13#10,[entry, item, Fields, Values])
end;

procedure TMainForm.CompleteReferenceLootScript;
var
  entry, item, Fields, Values: string;
begin
  meitLog.Clear;
  entry :=  edirentry.Text;
  item := ediritem.Text;
  if (entry='') or (item='') then Exit;
  SetFieldsAndValues(Fields, Values, 'reference_loot_template', PFX_REFERENCE_LOOT_TEMPLATE, meitLog);
  meitScript.Text := Format('DELETE FROM `reference_loot_template` WHERE (`entry`=%s) AND (`item`=%s);'#13#10+
   'INSERT INTO `reference_loot_template` (%s) VALUES (%s);'#13#10,[entry, item, Fields, Values])
end;

procedure TMainForm.CompleteItemScript;
var
  entry, Fields, Values: string;
begin
  meitLog.Clear;
  entry := editEntry.Text;
  if entry='' then exit;
  SetFieldsAndValues(Fields, Values, 'item_template', PFX_ITEM_TEMPLATE, meitLog);
  case SyntaxStyle of
    ssInsertDelete: meitScript.Text := Format('DELETE FROM `item_template` WHERE (`entry`=%s);'#13#10+
      'INSERT INTO `item_template` (%s) VALUES (%s);'#13#10,[entry, Fields, Values]);
    ssReplace: meitScript.Text := Format('REPLACE INTO `item_template` (%s) VALUES (%s);'#13#10,[Fields, Values]);
    ssUpdate: meitScript.Text := MakeUpdate('item_template', PFX_ITEM_TEMPLATE, 'entry', entry)
   else
   meitScript.Text := Format('REPLACE INTO `item_template` (%s) VALUES (%s);'#13#10,[Fields, Values]);

  end;
end;

procedure TMainForm.LoadItem(Entry: integer);
begin
  ShowHourGlassCursor;
  ClearFields(ttItem);
  if Entry<1 then exit;
  // load full description for item
  MyQuery.SQL.Text := Format('SELECT * FROM `item_template` WHERE `entry`=%d',[Entry]);
  MyQuery.Open;
  try
    if MyQuery.Eof then
      raise Exception.Create(Format(dmMain.Text[117], [Entry]));  //'Error: item (entry = %d) not found'
    editEntry.Text := IntToStr(Entry);
    FillFields(MyQuery, PFX_ITEM_TEMPLATE);
    MyQuery.Close;

    LoadQueryToListView(Format('SELECT ilt.*, i.`name` FROM `item_loot_template`'+
     ' ilt LEFT OUTER JOIN `item_template` i ON i.`entry` = ilt.`item`'+
     ' WHERE (ilt.`entry`=%d)',[StrToIntDef(editentry.Text,0)]), lvitItemLoot);

    LoadQueryToListView(Format('SELECT dlt.*, i.`name` FROM `disenchant_loot_template`'+
     ' dlt LEFT OUTER JOIN `item_template` i ON i.`entry` = dlt.`item`'+
     ' WHERE (dlt.`entry`=%d)',[StrToIntDef(editDisenchantID.Text,0)]), lvitDisLoot);

    LoadQueryToListView(Format('SELECT plt.*, i.`name` FROM `prospecting_loot_template`'+
     ' plt LEFT OUTER JOIN `item_template` i ON i.`entry` = plt.`item`'+
     ' WHERE (plt.`entry`=%d)',[StrToIntDef(editentry.Text,0)]), lvitProsLoot);

    LoadQueryToListView(Format('SELECT mlt.*, i.`name` FROM `milling_loot_template`'+
     ' mlt LEFT OUTER JOIN `item_template` i ON i.`entry` = mlt.`item`'+
     ' WHERE (mlt.`entry`=%d)',[StrToIntDef(editentry.Text,0)]), lvitMillingLoot);

    LoadQueryToListView(Format('SELECT rlt.*, i.`name` FROM `reference_loot_template`'+
     ' rlt LEFT OUTER JOIN `item_template` i ON i.`entry` = rlt.`entry`'+
     ' WHERE (rlt.`item`=%d)',[StrToIntDef(editentry.Text,0)]), lvitReferenceLoot);

    if editRandomProperty.Text<>'0' then
      LoadQueryToListView(Format('SELECT * FROM `item_enchantment_template`'+
       ' WHERE (`entry`=%d)',[StrToIntDef(editRandomProperty.Text,0)]), lvitEnchantment)
    else if editRandomSuffix.Text<>'0' then
      LoadQueryToListView(Format('SELECT * FROM `item_enchantment_template`'+
       ' WHERE (`entry`=%d)',[StrToIntDef(editRandomSuffix.Text,0)]), lvitEnchantment);

  except
    on E: Exception do
      raise Exception.Create(dmMain.Text[118]+#10#13+E.Message);
  end;
end;

procedure TMainForm.SearchItem;
var
  i: integer;
  loc, ID, Name, QueryStr, WhereStr, t: string;
  class_, subclass, InventoryType, itemset, Quality_, flags, ItemLevel_: integer;
  Field: TField;
begin
  loc:=LoadLocales();
  ShowHourGlassCursor;
  ID :=  edSearchItemEntry.Text;
  lvSearchItem.Columns[8].Caption:='name'+loc;
  Name := edSearchItemName.Text;
  Name := StringReplace(Name, '''', '\''', [rfReplaceAll]);
  Name := StringReplace(Name, ' ', '%', [rfReplaceAll]);
  Name := '%'+Name+'%';

  QueryStr := '';
  WhereStr := '';
  if ID<>'' then
  begin
    if pos('-', ID)=0 then
      WhereStr := Format('WHERE (it.`entry` in (%s))',[ID])
    else
      WhereStr := Format('WHERE (it.`entry` >= %s) AND (it.`entry` <= %s)',[MidStr(ID,1,pos('-',id)-1), MidStr(ID,pos('-',id)+1,length(id))]);
  end;

  if Name<>'%%' then
  begin
    if WhereStr<> '' then
      WhereStr := Format('%s AND ((it.`name` LIKE ''%s'') OR (li.`name'+loc+'` LIKE ''%1:s'')',[WhereStr, Name])
    else
      WhereStr := Format('WHERE (it.`name` LIKE ''%s'') OR (li.`name'+loc+'` LIKE ''%0:s'')',[Name]);
  end;

  class_ := StrToIntDef(edSearchItemClass.Text, -1);
  if class_<>-1 then
  begin
    if WhereStr<> '' then
      WhereStr := Format('%s AND (it.`class` = %d)',[WhereStr, class_])
    else
      WhereStr := Format('WHERE (it.`class` = %d)',[class_]);
  end;

  subclass := StrToIntDef(edSearchItemSubclass.Text, -1);
  if subclass<>-1 then
  begin
    if WhereStr<> '' then
      WhereStr := Format('%s AND (it.`subclass` = %d)',[WhereStr, subclass])
    else
      WhereStr := Format('WHERE (it.`subclass` = %d)',[subclass]);
  end;

  InventoryType := StrToIntDef(edSearchItemInventoryType.Text,-1);
  if InventoryType<>-1 then
  begin
    if WhereStr<> '' then
      WhereStr := Format('%s AND (it.`InventoryType` = %d)',[WhereStr, InventoryType])
    else
      WhereStr := Format('WHERE (it.`InventoryType` = %d)',[InventoryType]);
  end;

  itemset := StrToIntDef(edSearchItemItemset.Text,-1);
  if itemset<>-1 then
  begin
    if WhereStr<> '' then
      WhereStr := Format('%s AND (it.`itemset` = %d)',[WhereStr, itemset])
    else
      WhereStr := Format('WHERE (it.`itemset` = %d)',[itemset]);
  end;

  Quality_ := StrToIntDef(edSearchItemQuality.Text,-1);
  if Quality_<>-1 then
  begin
    if WhereStr<> '' then
      WhereStr := Format('%s AND (it.`Quality` = %d)',[WhereStr, Quality_])
    else
      WhereStr := Format('WHERE (it.`Quality` = %d)',[Quality_]);
  end;

  Flags := StrToIntDef(edSearchItemFlags.Text,-1);
  if Flags<>-1 then
  begin
    if WhereStr<> '' then
      WhereStr := Format('%s AND (it.`Flags` & %d <> 0)',[WhereStr, Flags])
    else
      WhereStr := Format('WHERE (it.`Flags` & %d <> 0 )',[Flags]);
  end;

  ItemLevel_ := StrToIntDef(edSearchItemItemLevel.Text,-1);
  if ItemLevel_<>-1 then
  begin
    if WhereStr<> '' then
      WhereStr := Format('%s AND (it.`ItemLevel` =  %d)',[WhereStr, ItemLevel_])
    else
      WhereStr := Format('WHERE (it.`ItemLevel` = %d)',[ItemLevel_]);
  end;


  if Trim(WhereStr)='' then
    if MessageDlg(dmMain.Text[134], mtConfirmation, mbYesNoCancel, -1)<>mrYes then Exit;

  QueryStr := Format('SELECT * FROM `item_template` it LEFT OUTER JOIN locales_item li ON it.entry=li.entry %s',[WhereStr]);

  MyQuery.SQL.Text := QueryStr;
  lvSearchItem.Items.BeginUpdate;
  try
    MyQuery.Open;
    lvSearchItem.Clear;
    while not MyQuery.Eof do
    begin
      with lvSearchItem.Items.Add do
      begin
        Data := Pointer(MyQuery.FieldByName('Quality').AsInteger);
        for i := 0 to lvSearchItem.Columns.Count - 1 do
        begin
          Field := MyQuery.FindField(lvSearchItem.Columns[i].Caption);
          t := '';
          if Assigned(Field) then
          begin
            t := Field.AsString;
            if i=0 then Caption := t;
          end;
          if i<>0 then SubItems.Add(t);
        end;
        MyQuery.Next;
      end;
    end;
  finally
    lvSearchItem.Items.EndUpdate;
    MyQuery.Close;
  end;
end;

procedure TMainForm.btCopyToClipboardItemClick(Sender: TObject);
begin
  meitScript.SelectAll;
  meitScript.CopyToClipboard;
  meitScript.SelStart := 0;
  meitScript.SelLength := 0;
end;

procedure TMainForm.btExecuteItemScriptClick(Sender: TObject);
begin
  if MessageDlg(dmMain.Text[9], mtConfirmation, mbYesNoCancel, -1)=mrYes then
    ExecuteScript(meitScript.Text, meitLog);
end;

procedure TMainForm.btScriptItemClick(Sender: TObject);
begin
  PageControl5.ActivePageIndex := SCRIPT_TAB_NO_ITEM;
end;

procedure TMainForm.lvitItemLootChange(Sender: TObject; Item: TListItem;
  Change: TItemChange);
begin
  btItemLootUpd.Enabled := Assigned(TJvListView(Sender).Selected);
  btItemLootDel.Enabled := Assigned(TJvListView(Sender).Selected);
end;

procedure TMainForm.lvitItemLootedFromDblClick(Sender: TObject);
var
  id: string;
  table, QueryStr : string;
  lvList: TJvListView;
  i: integer;
  t: string;
  Field: TField;
begin
  if not Assigned(TJvListView(Sender).Selected) then Exit;
  id := lvitItemLootedFrom.Selected.Caption;
  table := lvitItemLootedFrom.Selected.SubItems[6];
  lvList := nil;
  QueryStr := '';

  if table = 'creature_loot_template' then
  begin
    QueryStr := Format('SELECT * FROM `creature_template` WHERE `lootid` = %s',[id]);
    lvList := lvSearchCreature;
    PageControl1.ActivePageIndex := 1;
  end;
  if table = 'pickpocketing_loot_template' then
  begin
    QueryStr := Format('SELECT * FROM `creature_template` WHERE `pickpocketloot` = %s',[id]);
    lvList := lvSearchCreature;
    PageControl1.ActivePageIndex := 1;
  end;
  if table = 'skinning_loot_template' then
  begin
    QueryStr := Format('SELECT * FROM `creature_template` WHERE `skinloot` = %s',[id]);
    lvList := lvSearchCreature;
    PageControl1.ActivePageIndex := 1;
  end;
  if table = 'npc_vendor' then
  begin
    QueryStr := Format('SELECT * FROM `creature_template` WHERE `entry` = %s',[id]);
    lvList := lvSearchCreature;
    PageControl1.ActivePageIndex := 1;
  end;          

  if table = 'item_loot_template' then
  begin
    QueryStr := Format('SELECT * FROM `item_template` WHERE `entry` = %s',[id]);
    lvList := lvSearchItem;
    PageControl5.ActivePageIndex := 0;
  end;
  if table = 'prospecting_loot_template' then
  begin
    QueryStr := Format('SELECT * FROM `item_template` WHERE `entry` = %s',[id]);
    lvList := lvSearchItem;
    PageControl5.ActivePageIndex := 0;
  end;
  if table = 'disenchant_loot_template' then
  begin
    QueryStr := Format('SELECT * FROM `item_template` WHERE `DisenchantID` = %s',[id]);
    lvList := lvSearchItem;
    PageControl5.ActivePageIndex := 0;
  end;         
  
  if table = 'gameobject_loot_template' then
  begin
    QueryStr := Format('SELECT * FROM `gameobject_template` WHERE `data1` = %s',[id]);
    lvList := lvSearchGO;
    PageControl1.ActivePageIndex := 2;
  end;

  if (QueryStr<>'') and Assigned(lvList) then
  begin
    MyQuery.SQL.Text := QueryStr;
    lvList.Items.BeginUpdate;
    try
      MyQuery.Open;
      lvList.Clear;
      while not MyQuery.Eof do
      begin
        with lvList.Items.Add do
        begin
          for i := 0 to lvList.Columns.Count - 1 do
          begin
            Field := MyQuery.FindField(lvList.Columns[i].Caption);
            t := '';
            if Assigned(Field) then
            begin
              t := Field.AsString;
              if i=0 then Caption := t;
            end;
            if i<>0 then SubItems.Add(t);
          end;
          MyQuery.Next;
        end;
      end;
    finally
      lvList.Items.EndUpdate;
      MyQuery.Close;
    end;
  end;

  if table = 'fishing_loot_template' then
  begin
    edotZone.Text := id;
    btGetLootForZone.Click;
    PageControl1.ActivePageIndex := 4;    
  end;
end;

procedure TMainForm.lvitItemLootSelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
begin
  if Selected then
    SetLootEditFields('edil', lvitItemLoot);
end;

procedure TMainForm.lvitMillingLootChange(Sender: TObject; Item: TListItem;
  Change: TItemChange);
begin
  btMillingLootUpd.Enabled := Assigned(TJvListView(Sender).Selected);
  btMillingLootDel.Enabled := Assigned(TJvListView(Sender).Selected);
end;

procedure TMainForm.lvitMillingLootSelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
begin
 if Selected then
    SetLootEditFields('edim', lvitMillingLoot);
end;

procedure TMainForm.btScriptItemLootClick(Sender: TObject);
begin
  PageControl5.ActivePageIndex := SCRIPT_TAB_NO_ITEM;
end;

procedure TMainForm.btItemLootAddClick(Sender: TObject);
begin
  LootAdd('edil', lvitItemLoot);
end;

procedure TMainForm.btItemLootUpdClick(Sender: TObject);
begin
  LootUpd('edil', lvitItemLoot);
end;

procedure TMainForm.btItemLootDelClick(Sender: TObject);
begin
  LootDel(lvitItemLoot);
end;

procedure TMainForm.btFullScriptItemLootClick(Sender: TObject);
begin
  PageControl5.ActivePageIndex := SCRIPT_TAB_NO_ITEM;
  ShowFullLootScript('item_loot_template', lvitItemLoot, meitScript, editentry.Text);
end;

procedure TMainForm.btFullScriptMillingLootClick(Sender: TObject);
begin
PageControl5.ActivePageIndex := SCRIPT_TAB_NO_ITEM;
ShowFullLootScript('milling_loot_template', lvitMillingLoot, meitScript, editentry.Text);
end;

procedure TMainForm.editentryButtonClick(Sender: TObject);
var
  KeyboardState: TKeyboardState;
  id: integer;
begin
  id := abs(StrToIntDef(TJvComboEdit(Sender).Text,0));
  if id = 0 then Exit;
  GetKeyboardState(KeyboardState);
  if ssShift in KeyboardStateToShiftState(KeyboardState) then
    dmMain.BrowseSite(ttItem, id)
  else
    LoadItem(id);
end;

procedure TMainForm.edcvExtendedCostButtonClick(Sender: TObject);
begin
  GetValueFromSimpleList(Sender, 152, 'ItemExtendedCost', false);
end;

procedure TMainForm.lvitDisLootChange(Sender: TObject; Item: TListItem;
  Change: TItemChange);
begin
  btDisLootUpd.Enabled := Assigned(TJvListView(Sender).Selected);
  btDisLootDel.Enabled := Assigned(TJvListView(Sender).Selected);
end;

procedure TMainForm.lvitDisLootSelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
begin
  if Selected then
    SetLootEditFields('edid', lvitDisLoot);
end;

procedure TMainForm.btDisLootAddClick(Sender: TObject);
begin
  LootAdd('edid', lvitDisLoot);
end;

procedure TMainForm.btDisLootUpdClick(Sender: TObject);
begin
  LootUpd('edid', lvitDisLoot);
end;

procedure TMainForm.btDisLootDelClick(Sender: TObject);
begin
  LootDel(lvitDisLoot);
end;

procedure TMainForm.btFullScriptDisLootClick(Sender: TObject);
begin
  PageControl5.ActivePageIndex := SCRIPT_TAB_NO_ITEM;
  ShowFullLootScript('disenchant_loot_template', lvitDisLoot, meitScript, editDisenchantID.Text);
end;

procedure TMainForm.tsItemInvolvedInShow(Sender: TObject);
begin
  LoadItemInvolvedIn(editEntry.Text);
end;

procedure TMainForm.tsItemLootedFromShow(Sender: TObject);
begin
  if (lvitItemLootedFrom.Items.Count=0) and (trim(editentry.Text)<>'') then
    LoadLoot(lvitItemLootedFrom, editentry.Text);
end;

procedure TMainForm.tsItemLootShow(Sender: TObject);
begin
  if (edilentry.Text ='') then edilentry.Text := editentry.Text;  
end;

procedure TMainForm.tsItemScriptShow(Sender: TObject);
begin
  case PageControl5.ActivePageIndex of
    1: CompleteItemScript;
    2: CompleteItemLootScript;
    3: CompleteDisLootScript;
    4: CompleteProsLootScript;
    5: CompleteMillingLootScript;
    6: CompleteReferenceLootScript;
    7: CompleteItemEnchScript;
  end;
end;
       
procedure TMainForm.tsMillingLootShow(Sender: TObject);
begin
 if (edipentry.Text = '') then edipentry.Text := editentry.Text;
end;

procedure TMainForm.editQualityButtonClick(Sender: TObject);
begin
  GetValueFromSimpleList(Sender, 119, 'ItemQuality', false);
end;

procedure TMainForm.editInventoryTypeButtonClick(Sender: TObject);
begin
  GetValueFromSimpleList(Sender, 120, 'ItemInventoryType', false);
end;

procedure TMainForm.editRequiredReputationRankButtonClick(Sender: TObject);
begin
  GetValueFromSimpleList(Sender, 121, 'ItemRequiredReputationRank', false);
end;

procedure TMainForm.GetStatType(Sender: TObject);
begin
  GetValueFromSimpleList(Sender, 122, 'ItemStatType', false);
end;

function TMainForm.GetDBVersion: string;
begin
  Result := '';
  MyTempQuery.SQL.Text := 'SELECT * FROM `version`';
  try
    MyTempQuery.Open;
    if not MyTempQuery.Eof then
      Result := MyTempQuery.Fields[0].AsString;
  finally
    MyTempQuery.Close;
  end;
end;

procedure TMainForm.GetDmgType(Sender: TObject);
begin
  GetValueFromSimpleList(Sender, 123, 'ItemDmgType', false);
end;

procedure TMainForm.editbondingButtonClick(Sender: TObject);
begin
  GetValueFromSimpleList(Sender, 124, 'ItemBonding', false);
end;

procedure TMainForm.edcyevent_typeChange(Sender: TObject);
begin
  SetSAIEvent(StrToIntDef(edcyevent_type.Text,0));
end;

procedure TMainForm.edcyevent_typeKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    edcyevent_typeChange(Sender);
end;

procedure TMainForm.edcyaction_typeChange(Sender: TObject);
begin
  SetSAIAction(StrToIntDef(edcyevent_type.Text,0));
end;

procedure TMainForm.edcyaction_typeKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    edcyaction_typeChange(Sender);
end;

procedure TMainForm.edcytarget_typeChange(Sender: TObject);
begin
  SetSAITarget(StrToIntDef(edcyevent_type.Text,0));
end;

procedure TMainForm.edcytarget_typeKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    edcytarget_typeChange(Sender);
end;

procedure TMainForm.LangButtonClick(Sender: TObject);
begin
  GetValueFromSimpleList(Sender, 125, 'Languages', false);
end;

procedure TMainForm.linkEventAIInfoClick(Sender: TObject);
begin
  BrowseURL1.URL := 'http://www.trinitycore.org/w/Creature_ai_scripts_tc2';
  BrowseURL1.Execute;
end;

procedure TMainForm.editPageMaterialButtonClick(Sender: TObject);
begin
  GetValueFromSimpleList(Sender, 126, 'PageTextMaterial', false);
end;

procedure TMainForm.editMaterialButtonClick(Sender: TObject);
begin
  GetValueFromSimpleList(Sender, 127, 'ItemMaterial', false);
end;

procedure TMainForm.EditMouseWheelDown(Sender: TObject; Shift: TShiftState; MousePos: TPoint;
  var Handled: Boolean);
var
  x: integer;
begin
  Handled := true;
  if TryStrToInt(TCustomEdit(Sender).Text, x) then
   TCustomEdit(Sender).Text := IntToStr(x - 1);
end;

procedure TMainForm.EditMouseWheelUp(Sender: TObject; Shift: TShiftState; MousePos: TPoint;
  var Handled: Boolean);
var
  x: integer;
begin
  Handled := true;
  if TryStrToInt(TLabeledEdit(Sender).Text, x) then
   TLabeledEdit(Sender).Text := IntToStr(x + 1);
end;

procedure TMainForm.editsheathButtonClick(Sender: TObject);
begin
  GetValueFromSimpleList(Sender, 128, 'ItemSheath', false);
end;

procedure TMainForm.editsocketBonusButtonClick(Sender: TObject);
begin
  GetValueFromSimpleList(Sender, 151, 'SpellItemEnchantment', true);
end;

procedure TMainForm.GetSpellTrigger(Sender: TObject);
begin
  GetValueFromSimpleList(Sender, 129, 'SpellTrigger', false);
end;

procedure TMainForm.editBagFamilyButtonClick(Sender: TObject);
begin
  GetValueFromSimpleList(Sender, 129, 'ItemBagFamily', false);
end;

procedure TMainForm.editclassButtonClick(Sender: TObject);
begin
  GetValueFromSimpleList(Sender, 130, 'ItemClass', false);
end;

procedure TMainForm.editsubclassButtonClick(Sender: TObject);
begin
  GetValueFromSimpleList2(Sender, 131, 'ItemSubClass', false, editclass.Text);
end;

procedure TMainForm.EditThis(objtype, entry: string);
begin
  if objtype='creature' then
  begin
    PageControl1.ActivePageIndex := 1;
    PageControl3.ActivePageIndex := 1;
    edctEntry.Text := entry;
    edctEntry.Button.Click;
  end;
  if objtype='gameobject' then
  begin
    PageControl1.ActivePageIndex := 2;
    PageControl4.ActivePageIndex := 1;
    edgtEntry.Text := entry;
    edgtEntry.Button.Click;
  end;
  if objtype='item' then
  begin
    PageControl1.ActivePageIndex := 3;
    PageControl5.ActivePageIndex := 1;
    editEntry.Text := entry;
    editEntry.Button.Click;
  end;
end;

procedure TMainForm.edititemsetButtonClick(Sender: TObject);
begin
  GetValueFromSimpleList(Sender, 132, 'ItemSet', true);
end;

procedure TMainForm.GetPage(Sender: TObject);
var
  edEdit: TJvComboEdit;
  F: TItemPageForm;
begin
  if Sender is TJvComboEdit then
  begin
    edEdit := TJvComboEdit(Sender);
    F := TItemPageForm.Create(Self);
    try
      if (edEdit.Text<>'') and (edEdit.Text<>'0') then F.Prepare(edEdit.Text);
      if F.ShowModal=mrOk then edEdit.Text := F.lvPageItem.Selected.Caption;
    finally
      F.Free;
    end;
  end;
end;

procedure TMainForm.GetMap(Sender: TObject);
begin
  GetValueFromSimpleList(Sender, 133, 'Map', true);
end;

procedure TMainForm.GetItemFlags(Sender: TObject);
begin
  GetSomeFlags(Sender, 'ItemFlags');
end;

procedure TMainForm.editFoodTypeButtonClick(Sender: TObject);
begin
  GetValueFromSimpleList(Sender, 148, 'ItemPetFood', false);
end;

procedure TMainForm.editGemPropertiesButtonClick(Sender: TObject);
begin
  GetValueFromSimpleList(Sender, 150, 'GemProperties', true);
end;

procedure TMainForm.nRebuildSpellListClick(Sender: TObject);
begin
  RebuildSpellList;
end;

procedure TMainForm.nReconnectClick(Sender: TObject);
begin
  Connect;
  UpdateCaption;
end;

procedure TMainForm.RebuildSpellList;
var
  list : TStringList;
begin
  ShowHourGlassCursor;
  MyTempQuery.SQL.Text :=
  'SELECT `SourceSpellId` FROM `quest_template` WHERE `SourceSpellId`<>0 '+
  'UNION ' +
  'SELECT `RequiredSpellCast1` FROM `quest_template` WHERE `RequiredSpellCast1`<>0 '+
  'UNION ' +
  'SELECT `RequiredSpellCast2` FROM `quest_template` WHERE `RequiredSpellCast2`<>0 '+
  'UNION ' +
  'SELECT `RequiredSpellCast3` FROM `quest_template` WHERE `RequiredSpellCast3`<>0 '+
  'UNION ' +
  'SELECT `RequiredSpellCast4` FROM `quest_template` WHERE `RequiredSpellCast4`<>0 '+
  'UNION ' +
  'SELECT `spell1` FROM `creature_template` WHERE `spell1`<>0 '+
  'UNION ' +
  'SELECT `spell2` FROM `creature_template` WHERE `spell2`<>0 '+
  'UNION ' +
  'SELECT `spell3` FROM `creature_template` WHERE `spell3`<>0 '+
  'UNION ' +
  'SELECT `spell4` FROM `creature_template` WHERE `spell4`<>0 '+
  'UNION ' +
  'SELECT `trainer_spell` FROM `creature_template` WHERE `trainer_spell`<>0 '+
  'UNION ' +
  'SELECT `spell` FROM `npc_trainer` WHERE `spell`<>0 '+
  'UNION ' +
  'SELECT `requiredspell` FROM `item_template` WHERE `requiredspell`<>0 '+
  'UNION ' +
  'SELECT `spellid_1` FROM `item_template` WHERE `spellid_1`<>0 '+
  'UNION ' +
  'SELECT `spellid_2` FROM `item_template` WHERE `spellid_2`<>0 '+
  'UNION ' +
  'SELECT `spellid_3` FROM `item_template` WHERE `spellid_3`<>0 '+
  'UNION ' +
  'SELECT `spellid_4` FROM `item_template` WHERE `spellid_4`<>0 '+
  'UNION ' +
  'SELECT `spellid_5` FROM `item_template` WHERE `spellid_5`<>0 '+
  'UNION ' +
  'SELECT `RewardSpellCast` FROM `quest_template` WHERE `RewardSpellCast`<>0 '+
  'UNION ' +
  'SELECT `RewardSpell` FROM `quest_template` WHERE `RewardSpell`<>0 ';
  MyTempQuery.Open;
  list := TStringList.Create;
  try
    list.BeginUpdate;
    while not MyTempQuery.Eof do
    begin
      list.Add(MyTempQuery.Fields[0].AsString);
      MyTempQuery.Next;
    end;
    MyTempQuery.Close;
  finally
    list.SaveToFile(dmMain.ProgramDir+'CSV\useSpells.csv');
    list.Free;
    ShowMessage('Spell List Rebuilded Successfully');
  end;
end;

procedure TMainForm.edotentryButtonClick(Sender: TObject);
var
  id: string;
begin
  GetArea(Sender);
  id := TJvComboEdit(Sender).Text;
  if id<>'' then
  LoadQueryToListView(Format('SELECT flt.*, i.`name` FROM `fishing_loot_template`'+
     ' flt LEFT OUTER JOIN `item_template` i ON i.`entry` = flt.`item`'+
     ' WHERE (flt.`entry`=%s)',[id]), lvotFishingLoot);
end;

procedure TMainForm.btScriptFishingLootClick(Sender: TObject);
begin
  PageControl6.ActivePageIndex := SCRIPT_TAB_NO_OTHER;
end;

procedure TMainForm.btFullScriptFishLootClick(Sender: TObject);
begin
  PageControl6.ActivePageIndex := SCRIPT_TAB_NO_OTHER;
  ShowFullLootScript('fishing_loot_template', lvotFishingLoot, meotScript, edotentry.Text);
end;

procedure TMainForm.tsOtherScriptShow(Sender: TObject);
begin
  case PageControl6.ActivePageIndex of
    0: CompleteFishingLootScript;
    1: CompletePageTextScript;
    2: CompleteGameEventScript;
  end;
end;

procedure TMainForm.tsProspectingLootShow(Sender: TObject);
begin
  if (edipentry.Text = '') then edipentry.Text := editentry.Text;
end;

procedure TMainForm.CompleteFishingLootScript;
var
  entry, item, Fields, Values: string;
begin
  meotLog.Clear;
  entry :=  edotentry.Text;
  item := edotitem.Text;
  if (entry='') or (item='') then Exit;
  SetFieldsAndValues(Fields, Values, 'fishing_loot_template', PFX_FISHING_LOOT_TEMPLATE, meotLog);
  meotScript.Text := Format('DELETE FROM `fishing_loot_template` WHERE (`entry`=%s) AND (`item`=%s);'#13#10+
    'INSERT INTO `fishing_loot_template` (%s) VALUES (%s);'#13#10,[entry, item, Fields, Values])
end;     

procedure TMainForm.btCopyToClipboardOtherClick(Sender: TObject);
begin
  meotScript.SelectAll;
  meotScript.CopyToClipboard;
  meotScript.SelStart := 0;
  meotScript.SelLength := 0;
end;

procedure TMainForm.btExecuteOtherScriptClick(Sender: TObject);
begin
  if MessageDlg(dmMain.Text[9], mtConfirmation, mbYesNoCancel, -1)=mrYes then
    ExecuteScript(meotScript.Text, meotLog);
end;

procedure TMainForm.lvotFishingLootSelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
begin
  if Selected then
    SetLootEditFields('edot', lvotFishingLoot);
end;

procedure TMainForm.lvotFishingLootChange(Sender: TObject; Item: TListItem;
  Change: TItemChange);
begin
  btFishingLootUpd.Enabled := Assigned(TJvListView(Sender).Selected);
  btFishingLootDel.Enabled := Assigned(TJvListView(Sender).Selected);
end;

procedure TMainForm.btGameEventAddClick(Sender: TObject);
begin
  with lvSearchGameEvent.Items.Add do
  begin
    Caption := edgeeventEntry.Text;
    SubItems.Add(edgestart_time.Text);
    SubItems.Add(edgeend_time.Text);
    SubItems.Add(edgeoccurence.Text);
    SubItems.Add(edgelength.Text);
    SubItems.Add(edgedescription.Text);
    SubItems.Add(edgeworld_event.Text);
    Selected := true;
    MakeVisible(false);
  end;
end;

procedure TMainForm.btGameEventDelClick(Sender: TObject);
begin
  if Assigned(lvSearchGameEvent.Selected) then
  begin
    PageControl6.ActivePageIndex := SCRIPT_TAB_NO_OTHER;
    meotScript.Text := Format(
    'DELETE FROM `game_event` WHERE `eventEntry` = %0:s;'#13#10 +
    'DELETE FROM `game_event_creature` WHERE abs(`eventEntry`) = %0:s;'#13#10 +
    'DELETE FROM `game_event_gameobject` WHERE abs(`eventEntry`) = %0:s;'#13#10
    ,[lvSearchGameEvent.Selected.Caption])
  end;
end;

procedure TMainForm.btGameEventUpdClick(Sender: TObject);
begin
  if Assigned(lvSearchGameEvent.Selected) then
  begin
    with lvSearchGameEvent.Selected do
    begin
      Caption := edgeeventEntry.Text;
      SubItems[0] := edgestart_time.Text;
      SubItems[1] := edgeend_time.Text;
      SubItems[2] := edgeoccurence.Text;
      SubItems[3] := edgelength.Text;
      SubItems[4] := edgedescription.Text;
      SubItems[5] := edgeworld_event.Text;
    end;
  end;
end;

procedure TMainForm.btgbAddClick(Sender: TObject);
begin
  ScriptAdd('edgb', lvgbButtonScript);
end;

procedure TMainForm.btgbDelClick(Sender: TObject);
begin
  ScriptDel(lvgbButtonScript);
end;

procedure TMainForm.btgbUpdClick(Sender: TObject);
begin
  ScriptUpd('edgb', lvgbButtonScript);
end;

procedure TMainForm.btgeCreatureGuidAddClick(Sender: TObject);
begin
  if Trim(edgeCreatureGuid.Text)<>'' then
  begin
    with lvGameEventCreature.Items.Add do
    begin
      Caption := edgeCreatureGuid.Text;
      SubItems.Add(edgeeventEntry.Text);
    end;
  end;
end;

procedure TMainForm.btgeCreatureGuidDelClick(Sender: TObject);
begin
  if Assigned(lvGameEventCreature.Selected) then
    lvGameEventCreature.DeleteSelected;
end;

procedure TMainForm.btgeCreatureGuidInvClick(Sender: TObject);
begin
  if Assigned(lvGameEventCreature.Selected) then
    lvGameEventCreature.Selected.SubItems[0] := IntToStr(-StrToInt(lvGameEventCreature.Selected.SubItems[0]));
end;

procedure TMainForm.btgeGOGuidAddClick(Sender: TObject);
begin
  if Trim(edgeGOguid.Text)<>'' then
  begin
    with lvGameEventGO.Items.Add do
    begin
      Caption := edgeGOguid.Text;
      SubItems.Add(edgeeventEntry.Text);
    end;
  end;
end;

procedure TMainForm.btgeGOguidDelClick(Sender: TObject);
begin
  if Assigned(lvGameEventGO.Selected) then
    lvGameEventGO.DeleteSelected;
end;

procedure TMainForm.btgeGOGuidInvClick(Sender: TObject);
begin
  if Assigned(lvGameEventGO.Selected) then
    lvGameEventGO.Selected.SubItems[0] := IntToStr(-StrToInt(lvGameEventGO.Selected.SubItems[0]));
end;

procedure TMainForm.btGetLootForZoneClick(Sender: TObject);
var
  id: string;
begin
  id := edotZone.Text;
  if id<>'' then
  LoadQueryToListView(Format('SELECT flt.*, i.`name` FROM `fishing_loot_template`'+
     ' flt LEFT OUTER JOIN `item_template` i ON i.`entry` = flt.`item`'+
     ' WHERE (flt.`entry`=%s)',[id]), lvotFishingLoot);
end;

procedure TMainForm.btFishingLootAddClick(Sender: TObject);
begin
  LootAdd('edot', lvotFishingLoot);
end;

procedure TMainForm.btFishingLootUpdClick(Sender: TObject);
begin
  LootUpd('edot', lvotFishingLoot);
end;

procedure TMainForm.btFishingLootDelClick(Sender: TObject);
begin
  LootDel(lvotFishingLoot);
end;

procedure TMainForm.edSearchItemSubclassButtonClick(Sender: TObject);
begin
  GetValueFromSimpleList2(Sender, 131, 'ItemSubClass', false, edSearchItemClass.Text);
end;
     
procedure TMainForm.edqtZoneOrSortChange(Sender: TObject);
begin
  if StrToIntDef(edqtZoneOrSort.Text,0)>=0 then rbqtZoneID.Checked := true else
  rbqtQuestSort.Checked := true;
end;

procedure TMainForm.edZoneOrSortSearchButtonClick(Sender: TObject);
begin
  if rbZoneSearch.Checked then
    GetArea(Sender)
  else
    GetValueFromSimpleList(Sender, 11, 'QuestSort', false);
end;

procedure TMainForm.btSearchPageTextClick(Sender: TObject);
begin
  SearchPageText();
  with lvSearchPageText do
    if Items.Count>0 then
    begin
      SetFocus;
      Selected := Items[0];
    end;
end;

procedure TMainForm.lvSearchPageTextSelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
begin
  if Selected then
  begin
    edptentry.Text := Item.Caption;
    edpttext.Text := DollToSym(Item.SubItems[0]);
    edptnext_page.Text := Item.SubItems[1];
  end;
end;

procedure TMainForm.btScriptPageTextClick(Sender: TObject);
begin
  PageControl6.ActivePageIndex := SCRIPT_TAB_NO_OTHER;  
end;

procedure TMainForm.CompletePageTextScript;
var
  entry, Fields, Values: string;
begin
  meotLog.Clear;
  entry :=  edptentry.Text;
  if (entry='') then Exit;
  SetFieldsAndValues(Fields, Values, 'page_text', PFX_PAGE_TEXT, meotLog);
  case SyntaxStyle of
    ssInsertDelete: meotScript.Text := Format('DELETE FROM `page_text` WHERE (`entry`=%s);'#13#10+
      'INSERT INTO `page_text` (%s) VALUES (%s);'#13#10,[entry, Fields, Values]);
    ssReplace: meotScript.Text := Format('REPLACE INTO `page_text` (%s) VALUES (%s);'#13#10,[Fields, Values]);
    ssUpdate: meotScript.Text := MakeUpdate('page_text', PFX_PAGE_TEXT, 'entry', entry) ;
  end;
end;

procedure TMainForm.SearchPageText;
var
  i: integer;
  ID, Name, QueryStr, WhereStr, t: string;
  next_page: integer;
  Field: TField;
begin
  ID :=  edSearchPageTextEntry.Text;
  Name := edSearchPageTextText.Text;
  Name := StringReplace(Name, '''', '\''', [rfReplaceAll]);
  Name := StringReplace(Name, ' ', '%', [rfReplaceAll]);
  Name := '%'+Name+'%';

  QueryStr := '';
  WhereStr := '';
  if ID<>'' then
  begin
    if pos('-', ID)=0 then
      WhereStr := Format('WHERE (`entry` in (%s))',[ID])
    else
      WhereStr := Format('WHERE (`entry` >= %s) AND (`entry` <= %s)',[MidStr(ID,1,pos('-',id)-1), MidStr(ID,pos('-',id)+1,length(id))]);
  end;

  if Name<>'%%' then
  begin
    if WhereStr<> '' then
      WhereStr := Format('%s AND (`text` LIKE ''%s'')',[WhereStr, Name])
    else
      WhereStr := Format('WHERE (`text` LIKE ''%s'')',[Name]);
  end;

  next_page := StrToIntDef(edSearchPageTextNextPage.Text, -1);
  if next_page<>-1 then
  begin
    if WhereStr<> '' then
      WhereStr := Format('%s AND (`next_page` = %d)',[WhereStr, next_page])
    else
      WhereStr := Format('WHERE (`next_page` = %d)',[next_page]);
  end;

  if Trim(WhereStr)='' then
    if MessageDlg(dmMain.Text[134], mtConfirmation, mbYesNoCancel, -1)<>mrYes then Exit;

  QueryStr := Format('SELECT * FROM `page_text` %s',[WhereStr]);

  MyQuery.SQL.Text := QueryStr;
  lvSearchPageText.Items.BeginUpdate;
  try
    MyQuery.Open;
    lvSearchPageText.Clear;
    while not MyQuery.Eof do
    begin
      with lvSearchPageText.Items.Add do
      begin
        for i := 0 to lvSearchPageText.Columns.Count - 1 do
        begin
          Field := MyQuery.FindField(lvSearchPageText.Columns[i].Caption);
          t := '';
          if Assigned(Field) then
          begin
            t := Field.AsString;
            if i=0 then Caption := t;
          end;
          if i<>0 then SubItems.Add(t);
        end;
        MyQuery.Next;
      end;
    end;
  finally
    lvSearchPageText.Items.EndUpdate;
    MyQuery.Close;
  end;
end;

procedure TMainForm.LoadPageText(Sender: TObject);
var
  entry: string;
begin
  entry := TCustomEdit(Sender).Text;
  MyTempQuery.SQL.Text := Format('SELECT * FROM `page_text` WHERE `entry`=%s',[entry]);
  MyTempQuery.Open;
  if not MyTempQuery.Eof then
    FillFields(MyTempQuery, PFX_PAGE_TEXT);
  MyTempQuery.Close;
end;

function TMainForm.DollToSym(Text: string): string;
begin
  Result := StringReplace(Text, '$B', #13#10, [rfReplaceAll]);
end;

function TMainForm.SymToDoll(Text: string): string;
begin
  Result := StringReplace(Text, #13#10, '$B', [rfReplaceAll]);
end;

procedure TMainForm.Timer1Timer(Sender: TObject);
begin
  if MyTrinityConnection.Connected then
    MyTrinityConnection.Ping;
end;

procedure TMainForm.Timer2Timer(Sender: TObject);
begin
    // Sync labels..
    if SAI_Event <> StrToIntDef(edcyevent_type.Text,0) then
        SetSAIEvent(StrToIntDef(edcyevent_type.Text,0));
    if SAI_Action <> StrToIntDef(edcyaction_type.Text,0) then
        SetSAIAction(StrToIntDef(edcyaction_type.Text,0));
    if SAI_Target <> StrToIntDef(edcytarget_type.Text,0) then
        SetSAITarget(StrToIntDef(edcytarget_type.Text,0));
end;

procedure TMainForm.btSQLOpenClick(Sender: TObject);
begin
  MySQLQuery.Close;
  MySQLQuery.SQL.Text := SQLEdit.Text;
  MySQLQuery.Open;
end;

procedure TMainForm.btScriptCreatureLocationCustomToAllClick(
  Sender: TObject);
begin
  PageControl3.ActivePageIndex := SCRIPT_TAB_NO_CREATURE;
end;

procedure TMainForm.SetGOdataNames(t: integer);
begin
  case t of
    0:
      begin
        edgtdata0.EditLabel.Caption := 'startOpen';
        edgtdata1.EditLabel.Caption := 'open';
        edgtdata2.EditLabel.Caption := 'autoClose';
        edgtdata3.EditLabel.Caption := 'noDamageImmune';
        edgtdata4.EditLabel.Caption := 'openTextID';
        edgtdata5.EditLabel.Caption := 'closeTextID';
      end;
     1:
      begin
        edgtdata0.EditLabel.Caption := 'startOpen';
        edgtdata1.EditLabel.Caption := 'open';
        edgtdata2.EditLabel.Caption := 'autoClose';
        edgtdata3.EditLabel.Caption := 'linkedTrap';
        edgtdata4.EditLabel.Caption := 'noDamageImmune';
        edgtdata5.EditLabel.Caption := 'large';
        edgtdata6.EditLabel.Caption := 'openTextID';
        edgtdata7.EditLabel.Caption := 'closeTextID';
        edgtdata8.EditLabel.Caption := 'losOK';
      end;
     2:
      begin
        edgtdata0.EditLabel.Caption := 'open';
        edgtdata1.EditLabel.Caption := 'questList';
        edgtdata2.EditLabel.Caption := 'pageMaterial';
        edgtdata3.EditLabel.Caption := 'gossipID';
        edgtdata4.EditLabel.Caption := 'customAnim';
        edgtdata5.EditLabel.Caption := 'noDamageImmune';
        edgtdata6.EditLabel.Caption := 'openTextID';
        edgtdata7.EditLabel.Caption := 'losOK';
        edgtdata8.EditLabel.Caption := 'allowMounted';
        edgtdata9.EditLabel.Caption := 'large';
      end;
     3:
      begin
        edgtdata0.EditLabel.Caption := 'open';
        edgtdata1.EditLabel.Caption := 'chestLoot';
        edgtdata2.EditLabel.Caption := 'chestRestockTime';
        edgtdata3.EditLabel.Caption := 'consumable';
        edgtdata4.EditLabel.Caption := 'minRestock';
        edgtdata5.EditLabel.Caption := 'maxRestock';
        edgtdata6.EditLabel.Caption := 'lootedEvent';
        edgtdata7.EditLabel.Caption := 'linkedTrap';
        edgtdata8.EditLabel.Caption := 'questID';
        edgtdata9.EditLabel.Caption := 'level';
        edgtdata10.EditLabel.Caption := 'losOK';
        edgtdata11.EditLabel.Caption := 'leaveLoot';
        edgtdata12.EditLabel.Caption := 'notInCombat';
        edgtdata13.EditLabel.Caption := 'log loot';
        edgtdata14.EditLabel.Caption := 'openTextID';
        edgtdata15.EditLabel.Caption := 'use group loot rules';
      end;
     4:
      begin
      end;
     5:
      begin
        edgtdata0.EditLabel.Caption := 'floatingTooltip';
        edgtdata1.EditLabel.Caption := 'highlight';
        edgtdata2.EditLabel.Caption := 'serverOnly';
        edgtdata3.EditLabel.Caption := 'large';
        edgtdata4.EditLabel.Caption := 'floatOnWater';
        edgtdata5.EditLabel.Caption := 'questID';
      end;
     6:
      begin
        edgtdata0.EditLabel.Caption := 'open';
        edgtdata1.EditLabel.Caption := 'level';
        edgtdata2.EditLabel.Caption := 'radius';
        edgtdata3.EditLabel.Caption := 'spell';
        edgtdata4.EditLabel.Caption := 'charges';
        edgtdata5.EditLabel.Caption := 'cooldown';
        edgtdata6.EditLabel.Caption := 'autoClose';
        edgtdata7.EditLabel.Caption := 'startDelay';
        edgtdata8.EditLabel.Caption := 'serverOnly';
        edgtdata9.EditLabel.Caption := 'stealthed';
        edgtdata10.EditLabel.Caption := 'large';
        edgtdata11.EditLabel.Caption := 'stealthAffected';
        edgtdata12.EditLabel.Caption := 'openTextID';
        edgtdata13.EditLabel.Caption := 'closeTextID';
      end;
     7:
      begin
        edgtdata0.EditLabel.Caption := 'chairslots';
        edgtdata1.EditLabel.Caption := 'chairheight';
      end;
     8:
      begin
        edgtdata0.EditLabel.Caption := 'spellFocusType';
        edgtdata1.EditLabel.Caption := 'radius';
        edgtdata2.EditLabel.Caption := 'linkedTrap';
        edgtdata3.EditLabel.Caption := 'serverOnly';
      end;
     9:
      begin
        edgtdata0.EditLabel.Caption := 'pageID';
        edgtdata1.EditLabel.Caption := 'language';
        edgtdata2.EditLabel.Caption := 'pageMaterial';
        edgtdata3.EditLabel.Caption := 'allowMounted';
      end;
    10:
     begin
        edgtdata0.EditLabel.Caption := 'open';
        edgtdata1.EditLabel.Caption := 'questID';
        edgtdata2.EditLabel.Caption := 'eventID';
        edgtdata3.EditLabel.Caption := 'autoClose';
        edgtdata4.EditLabel.Caption := 'customAnim';
        edgtdata5.EditLabel.Caption := 'consumable';
        edgtdata6.EditLabel.Caption := 'cooldown';
        edgtdata7.EditLabel.Caption := 'pageID';
        edgtdata8.EditLabel.Caption := 'language';
        edgtdata9.EditLabel.Caption := 'pageMaterial';
        edgtdata10.EditLabel.Caption := 'spell';
        edgtdata11.EditLabel.Caption := 'noDamageImmune';
        edgtdata12.EditLabel.Caption := 'linkedTrap';
        edgtdata13.EditLabel.Caption := 'large';
        edgtdata14.EditLabel.Caption := 'openTextID';
        edgtdata15.EditLabel.Caption := 'closeTextID';
        edgtdata16.EditLabel.Caption := 'losOK';
        edgtdata17.EditLabel.Caption := 'allowMounted';
      end;
    11:
     begin
     end;
    12:
     begin
        edgtdata0.EditLabel.Caption := 'open';
        edgtdata1.EditLabel.Caption := 'radius';
        edgtdata2.EditLabel.Caption := 'damageMin';
        edgtdata3.EditLabel.Caption := 'damageMax';
        edgtdata4.EditLabel.Caption := 'damageSchool';
        edgtdata5.EditLabel.Caption := 'autoClose';
        edgtdata6.EditLabel.Caption := 'openTextID';
        edgtdata7.EditLabel.Caption := 'closeTextID';
      end;
    13:
     begin
        edgtdata0.EditLabel.Caption := 'open';
        edgtdata1.EditLabel.Caption := 'camera';
        edgtdata2.EditLabel.Caption := 'eventID';
        edgtdata3.EditLabel.Caption := 'openTextID';
      end;
    14:
     begin
      end;
    15:
     begin
        edgtdata0.EditLabel.Caption := 'taxiPathID';
        edgtdata1.EditLabel.Caption := 'moveSpeed';
        edgtdata2.EditLabel.Caption := 'accelRate';
        edgtdata3.EditLabel.Caption := 'startEventID';
        edgtdata4.EditLabel.Caption := 'stopEventID';
      end;
    16:
     begin
      end;
    17:
     begin
      end;
    18:
     begin
        edgtdata0.EditLabel.Caption := 'casters';
        edgtdata1.EditLabel.Caption := 'spell';
        edgtdata2.EditLabel.Caption := 'animSpell';
        edgtdata3.EditLabel.Caption := 'ritualPersistent';
        edgtdata4.EditLabel.Caption := 'casterTargetSpell';
        edgtdata5.EditLabel.Caption := 'casterTargetSpellTargets';
        edgtdata6.EditLabel.Caption := 'castersGrouped';
      end;
    19:
     begin
      end;
    20:
     begin
        edgtdata0.EditLabel.Caption := 'actionHouseID';
      end;
    21:
     begin
        edgtdata0.EditLabel.Caption := 'creatureID';
        edgtdata1.EditLabel.Caption := 'charges';
      end;

    22:
     begin
        edgtdata0.EditLabel.Caption := 'spell';
        edgtdata1.EditLabel.Caption := 'charges';
        edgtdata2.EditLabel.Caption := 'partyOnly';
      end;

    23:
     begin
        edgtdata0.EditLabel.Caption := 'minLevel';
        edgtdata1.EditLabel.Caption := 'maxLevel';
        edgtdata2.EditLabel.Caption := 'areaID';
      end;
    24:
     begin
        edgtdata0.EditLabel.Caption := 'open';
        edgtdata1.EditLabel.Caption := 'pickupSpell';
        edgtdata2.EditLabel.Caption := 'radius';
        edgtdata3.EditLabel.Caption := 'returnAura';
        edgtdata4.EditLabel.Caption := 'returnSpell';
        edgtdata5.EditLabel.Caption := 'noDamageImmune';
        edgtdata6.EditLabel.Caption := 'openTextID';
        edgtdata7.EditLabel.Caption := 'losOK';
      end;
    25:
     begin
        edgtdata0.EditLabel.Caption := 'radius';
        edgtdata1.EditLabel.Caption := 'chestLoot';
        edgtdata2.EditLabel.Caption := 'minRestock';
        edgtdata3.EditLabel.Caption := 'maxRestock';
        edgtdata4.EditLabel.Caption := 'open';
      end;
    26:
     begin
        edgtdata0.EditLabel.Caption := 'open';
        edgtdata1.EditLabel.Caption := 'eventID';
        edgtdata2.EditLabel.Caption := 'pickupSpell';
        edgtdata3.EditLabel.Caption := 'noDamageImmune';
        edgtdata4.EditLabel.Caption := 'openTextID';
     end;
     27:
     begin
        edgtdata0.EditLabel.Caption := 'gameType';
     end;
     28:
     begin
     end;
     29:
     begin
        edgtdata0.EditLabel.Caption := 'radius';
        edgtdata1.EditLabel.Caption := 'spell';
        edgtdata2.EditLabel.Caption := 'worldState1';
        edgtdata3.EditLabel.Caption := 'worldstate2';
        edgtdata4.EditLabel.Caption := 'winEventID1';
        edgtdata5.EditLabel.Caption := 'winEventID2';
        edgtdata6.EditLabel.Caption := 'contestedEventID1';
        edgtdata7.EditLabel.Caption := 'contestedEventID2';
        edgtdata8.EditLabel.Caption := 'progressEventID1';
        edgtdata9.EditLabel.Caption := 'progressEventID2';
        edgtdata10.EditLabel.Caption := 'neutralEventID1';
        edgtdata11.EditLabel.Caption := 'neutralEventID2';
        edgtdata12.EditLabel.Caption := 'neutralPercent';
        edgtdata13.EditLabel.Caption := 'worldstate3';
        edgtdata14.EditLabel.Caption := 'minSuperiority';
        edgtdata15.EditLabel.Caption := 'maxSuperiority';
        edgtdata16.EditLabel.Caption := 'minTime';
        edgtdata17.EditLabel.Caption := 'maxTime';
        edgtdata18.EditLabel.Caption := 'large';
        edgtdata19.EditLabel.Caption := 'highlight';
     end;
     30:
     begin
        edgtdata0.EditLabel.Caption := 'startOpen';
        edgtdata1.EditLabel.Caption := 'radius';
        edgtdata2.EditLabel.Caption := 'auraID1';
        edgtdata3.EditLabel.Caption := 'conditionID1';
        edgtdata4.EditLabel.Caption := 'auraID2';
        edgtdata5.EditLabel.Caption := 'conditionID2';
     end;
     31:
     begin
        edgtdata0.EditLabel.Caption := 'mapID';
        edgtdata1.EditLabel.Caption := 'difficulty';
     end;
  end;
end;

procedure TMainForm.SetSAIEvent(t: integer);
begin
    case t of
    0:  //SMART_EVENT_UPDATE_IC
        begin
            lbcyevent_param1.Caption := 'InitialMin';
            lbcyevent_param2.Caption := 'InitialMax';
            lbcyevent_param3.Caption := 'RepeatMin';
            lbcyevent_param4.Caption := 'RepeatMax';
            lbcyevent_type.Hint := '';
            edcyevent_type.Hint := lbcyevent_type.Hint;
        end;
    1:  //SMART_EVENT_UPDATE_OOC
        begin
            lbcyevent_param1.Caption := 'InitialMin';
            lbcyevent_param2.Caption := 'InitialMax';
            lbcyevent_param3.Caption := 'RepeatMin';
            lbcyevent_param4.Caption := 'RepeatMax';
            lbcyevent_type.Hint := '';
            edcyevent_type.Hint := lbcyevent_type.Hint;
        end;
    2:  //SMART_EVENT_HEALT_PCT
        begin
            lbcyevent_param1.Caption := 'HPMin%';
            lbcyevent_param2.Caption := 'HPMax%';
            lbcyevent_param3.Caption := 'RepeatMin';
            lbcyevent_param4.Caption := 'RepeatMax';
            lbcyevent_type.Hint := '';
            edcyevent_type.Hint := lbcyevent_type.Hint;
        end;
    3:  //SMART_EVENT_MANA_PCT
        begin
            lbcyevent_param1.Caption := 'ManaMin%';
            lbcyevent_param2.Caption := 'ManaMax%';
            lbcyevent_param3.Caption := 'RepeatMin';
            lbcyevent_param4.Caption := 'RepeatMax';
            lbcyevent_type.Hint := '';
            edcyevent_type.Hint := lbcyevent_type.Hint;
        end;
    4:  //SMART_EVENT_AGGRO
        begin
            lbcyevent_param1.Caption := '';
            lbcyevent_param2.Caption := '';
            lbcyevent_param3.Caption := '';
            lbcyevent_param4.Caption := '';
            lbcyevent_type.Hint := '';
            edcyevent_type.Hint := lbcyevent_type.Hint;
        end;
    5:  //SMART_EVENT_KILL
        begin
            lbcyevent_param1.Caption := 'CooldownMin0';
            lbcyevent_param2.Caption := 'CooldownMax1';
            lbcyevent_param3.Caption := 'playerOnly2';
            lbcyevent_param4.Caption := 'else creature entry3';
            lbcyevent_type.Hint := '';
            edcyevent_type.Hint := lbcyevent_type.Hint;
        end;
    6:  //SMART_EVENT_DEATH
        begin
            lbcyevent_param1.Caption := '';
            lbcyevent_param2.Caption := '';
            lbcyevent_param3.Caption := '';
            lbcyevent_param4.Caption := '';
            lbcyevent_type.Hint := '';
            edcyevent_type.Hint := lbcyevent_type.Hint;
        end;
    7:  //SMART_EVENT_EVADE
        begin
            lbcyevent_param1.Caption := '';
            lbcyevent_param2.Caption := '';
            lbcyevent_param3.Caption := '';
            lbcyevent_param4.Caption := '';
            lbcyevent_type.Hint := '';
            edcyevent_type.Hint := lbcyevent_type.Hint;
        end;
    8:  //SMART_EVENT_SPELLHIT
        begin
            lbcyevent_param1.Caption := 'SpellID';
            lbcyevent_param2.Caption := 'School';
            lbcyevent_param3.Caption := 'CooldownMin';
            lbcyevent_param4.Caption := 'CooldownMax';
            lbcyevent_type.Hint := '';
            edcyevent_type.Hint := lbcyevent_type.Hint;
        end;
    9:  //SMART_EVENT_RANGE
        begin
            lbcyevent_param1.Caption := 'MinDist';
            lbcyevent_param2.Caption := 'MaxDist';
            lbcyevent_param3.Caption := 'RepeatMin';
            lbcyevent_param4.Caption := 'RepeatMax';
            lbcyevent_type.Hint := '';
            edcyevent_type.Hint := lbcyevent_type.Hint;
        end;
    10:  //SMART_EVENT_OOC_LOS
        begin
            lbcyevent_param1.Caption := 'NoHostile';
            lbcyevent_param2.Caption := 'MaxRange';
            lbcyevent_param3.Caption := 'CooldownMin';
            lbcyevent_param4.Caption := 'CooldownMax';
            lbcyevent_type.Hint := '';
            edcyevent_type.Hint := lbcyevent_type.Hint;
        end;
    11:  //SMART_EVENT_RESPAWN
        begin
            lbcyevent_param1.Caption := 'type';
            lbcyevent_param2.Caption := 'MapId';
            lbcyevent_param3.Caption := 'ZoneId';
            lbcyevent_param4.Caption := '';
            lbcyevent_type.Hint := '';
            edcyevent_type.Hint := lbcyevent_type.Hint;
        end;
    12:  //SMART_EVENT_TARGET_HEALTH_PCT
        begin
            lbcyevent_param1.Caption := 'HPMin%';
            lbcyevent_param2.Caption := 'HPMax%';
            lbcyevent_param3.Caption := 'RepeatMin';
            lbcyevent_param4.Caption := 'RepeatMax';
            lbcyevent_type.Hint := '';
            edcyevent_type.Hint := lbcyevent_type.Hint;
        end;
    13:  //SMART_EVENT_TARGET_CASTING
        begin
            lbcyevent_param1.Caption := 'RepeatMin';
            lbcyevent_param2.Caption := 'RepeatMax';
            lbcyevent_param3.Caption := '';
            lbcyevent_param4.Caption := '';
            lbcyevent_type.Hint := '';
            edcyevent_type.Hint := lbcyevent_type.Hint;
        end;
    14:  //SMART_EVENT_FRIENDLY_HEALTH
        begin
            lbcyevent_param1.Caption := 'HPDeficit';
            lbcyevent_param2.Caption := 'Radius';
            lbcyevent_param3.Caption := 'RepeatMin';
            lbcyevent_param4.Caption := 'RepeatMax';
            lbcyevent_type.Hint := '';
            edcyevent_type.Hint := lbcyevent_type.Hint;
        end;
    15:  //SMART_EVENT_FRIENDLY_IS_CC
        begin
            lbcyevent_param1.Caption := 'Radius';
            lbcyevent_param2.Caption := 'RepeatMin';
            lbcyevent_param3.Caption := 'RepeatMax';
            lbcyevent_param4.Caption := '';
            lbcyevent_type.Hint := '';
            edcyevent_type.Hint := lbcyevent_type.Hint;
        end;
    16:  //SMART_EVENT_FRIENDLY_MISSING_BUFF
        begin
            lbcyevent_param1.Caption := 'SpellId';
            lbcyevent_param2.Caption := 'Radius';
            lbcyevent_param3.Caption := 'RepeatMin';
            lbcyevent_param4.Caption := 'RepeatMax';
            lbcyevent_type.Hint := '';
            edcyevent_type.Hint := lbcyevent_type.Hint;
        end;
    17:  //SMART_EVENT_SUMMONED_UNIT
        begin
            lbcyevent_param1.Caption := 'CretureId (0 all)';
            lbcyevent_param2.Caption := 'CooldownMin';
            lbcyevent_param3.Caption := 'CooldownMax';
            lbcyevent_param4.Caption := '';
            lbcyevent_type.Hint := '';
            edcyevent_type.Hint := lbcyevent_type.Hint;
        end;
    18:  //SMART_EVENT_TARGET_MANA_PCT
        begin
            lbcyevent_param1.Caption := 'ManaMin%';
            lbcyevent_param2.Caption := 'ManaMax%';
            lbcyevent_param3.Caption := 'RepeatMin';
            lbcyevent_param4.Caption := 'RepeatMax';
            lbcyevent_type.Hint := '';
            edcyevent_type.Hint := lbcyevent_type.Hint;
        end;
    19:  //SMART_EVENT_ACCEPTED_QUEST
        begin
            lbcyevent_param1.Caption := 'QuestID (0 any)';
            lbcyevent_param2.Caption := '';
            lbcyevent_param3.Caption := '';
            lbcyevent_param4.Caption := '';
            lbcyevent_type.Hint := '';
            edcyevent_type.Hint := lbcyevent_type.Hint;
        end;
    20:  //SMART_EVENT_REWARD_QUEST
        begin
            lbcyevent_param1.Caption := 'QuestID (0 any)';
            lbcyevent_param2.Caption := '';
            lbcyevent_param3.Caption := '';
            lbcyevent_param4.Caption := '';
            lbcyevent_type.Hint := '';
            edcyevent_type.Hint := lbcyevent_type.Hint;
        end;
    21:  //SMART_EVENT_REACHED_HOME
        begin
            lbcyevent_param1.Caption := '';
            lbcyevent_param2.Caption := '';
            lbcyevent_param3.Caption := '';
            lbcyevent_param4.Caption := '';
            lbcyevent_type.Hint := '';
            edcyevent_type.Hint := lbcyevent_type.Hint;
        end;
    22:  //SMART_EVENT_RECEIVE_EMOTE
        begin
            lbcyevent_param1.Caption := 'EmoteId';
            lbcyevent_param2.Caption := 'CooldownMin';
            lbcyevent_param3.Caption := 'CooldownMax';
            lbcyevent_param4.Caption := 'condition';
            lbcyevent_type.Hint := 'val1,val2,val3 (?)';
            edcyevent_type.Hint := lbcyevent_type.Hint;
        end;
    23:  //SMART_EVENT_HAS_AURA
        begin
            lbcyevent_param1.Caption := 'SpellID';
            lbcyevent_param2.Caption := 'Stacks';
            lbcyevent_param3.Caption := 'RepeatMin';
            lbcyevent_param4.Caption := 'RepeatMax';
            lbcyevent_type.Hint := '';
            edcyevent_type.Hint := lbcyevent_type.Hint;
        end;
    24:  //SMART_EVENT_TARGET_BUFFED
        begin
            lbcyevent_param1.Caption := 'SpellID';
            lbcyevent_param2.Caption := 'Stacks';
            lbcyevent_param3.Caption := 'RepeatMin';
            lbcyevent_param4.Caption := 'RepeatMax';
            lbcyevent_type.Hint := '';
            edcyevent_type.Hint := lbcyevent_type.Hint;
        end;
    25:  //SMART_EVENT_RESET
        begin
            lbcyevent_param1.Caption := '';
            lbcyevent_param2.Caption := '';
            lbcyevent_param3.Caption := '';
            lbcyevent_param4.Caption := '';
            lbcyevent_type.Hint := 'Called after combat, when the creature respawns or at spawn.';
            edcyevent_type.Hint := lbcyevent_type.Hint;
        end;
    26:  //SMART_EVENT_IC_LOS
        begin
            lbcyevent_param1.Caption := 'NoHostile';
            lbcyevent_param2.Caption := 'MaxRange';
            lbcyevent_param3.Caption := 'CooldownMin';
            lbcyevent_param4.Caption := 'CooldownMax';
            lbcyevent_type.Hint := '';
            edcyevent_type.Hint := lbcyevent_type.Hint;
        end;
    27:  //SMART_EVENT_PASSENGER_BOARDED
        begin
            lbcyevent_param1.Caption := 'CooldownMin';
            lbcyevent_param2.Caption := 'CooldownMax';
            lbcyevent_param3.Caption := '';
            lbcyevent_param4.Caption := '';
            lbcyevent_type.Hint := '';
            edcyevent_type.Hint := lbcyevent_type.Hint;
        end;
    28:  //SMART_EVENT_PASSENGER_REMOVED
        begin
            lbcyevent_param1.Caption := 'CooldownMin';
            lbcyevent_param2.Caption := 'CooldownMax';
            lbcyevent_param3.Caption := '';
            lbcyevent_param4.Caption := '';
            lbcyevent_type.Hint := '';
            edcyevent_type.Hint := lbcyevent_type.Hint;
        end;
    29:  //SMART_EVENT_CHARMED
        begin
            lbcyevent_param1.Caption := '';
            lbcyevent_param2.Caption := '';
            lbcyevent_param3.Caption := '';
            lbcyevent_param4.Caption := '';
            lbcyevent_type.Hint := '';
            edcyevent_type.Hint := lbcyevent_type.Hint;
        end;
    30:  //SMART_EVENT_CHARMED_TARGET
        begin
            lbcyevent_param1.Caption := '';
            lbcyevent_param2.Caption := '';
            lbcyevent_param3.Caption := '';
            lbcyevent_param4.Caption := '';
            lbcyevent_type.Hint := '';
            edcyevent_type.Hint := lbcyevent_type.Hint;
        end;
    31:  //SMART_EVENT_SPELLHIT_TARGET
        begin
            lbcyevent_param1.Caption := 'SpellId';
            lbcyevent_param2.Caption := 'School';
            lbcyevent_param3.Caption := 'RepeatMin';
            lbcyevent_param4.Caption := 'RepeatMax';
            lbcyevent_type.Hint := '';
            edcyevent_type.Hint := lbcyevent_type.Hint;
        end;
    32:  //SMART_EVENT_DAMAGED
        begin
            lbcyevent_param1.Caption := 'MinDmg';
            lbcyevent_param2.Caption := 'MaxDmg';
            lbcyevent_param3.Caption := 'RepeatMin';
            lbcyevent_param4.Caption := 'RepeatMax';
            lbcyevent_type.Hint := '';
            edcyevent_type.Hint := lbcyevent_type.Hint;
        end;
    33:  //SMART_EVENT_DAMAGED_TARGET
        begin
            lbcyevent_param1.Caption := 'MinDmg';
            lbcyevent_param2.Caption := 'MaxDmg';
            lbcyevent_param3.Caption := 'RepeatMin';
            lbcyevent_param4.Caption := 'RepeatMax';
            lbcyevent_type.Hint := '';
            edcyevent_type.Hint := lbcyevent_type.Hint;
        end;
    34:  //SMART_EVENT_MOVEMENTINFORM
        begin
            lbcyevent_param1.Caption := 'MovementType (any)';
            lbcyevent_param2.Caption := 'PointID';
            lbcyevent_param3.Caption := '';
            lbcyevent_param4.Caption := '';
            lbcyevent_type.Hint := '';
            edcyevent_type.Hint := lbcyevent_type.Hint;
        end;
    35:  //SMART_EVENT_SUMMON_DESPAWNED
        begin
            lbcyevent_param1.Caption := 'Entry';
            lbcyevent_param2.Caption := 'CooldownMin';
            lbcyevent_param3.Caption := 'CooldownMax';
            lbcyevent_param4.Caption := '';
            lbcyevent_type.Hint := '';
            edcyevent_type.Hint := lbcyevent_type.Hint;
        end;
    36:  //SMART_EVENT_CORPSE_REMOVED
        begin
            lbcyevent_param1.Caption := '';
            lbcyevent_param2.Caption := '';
            lbcyevent_param3.Caption := '';
            lbcyevent_param4.Caption := '';
            lbcyevent_type.Hint := '';
            edcyevent_type.Hint := lbcyevent_type.Hint;
        end;
    37:  //SMART_EVENT_AI_INIT
        begin
            lbcyevent_param1.Caption := '';
            lbcyevent_param2.Caption := '';
            lbcyevent_param3.Caption := '';
            lbcyevent_param4.Caption := '';
            lbcyevent_type.Hint := '';
            edcyevent_type.Hint := lbcyevent_type.Hint;
        end;
    38:  //SMART_EVENT_DATA_SET
        begin
            lbcyevent_param1.Caption := 'Id';
            lbcyevent_param2.Caption := 'Value';
            lbcyevent_param3.Caption := 'CooldownMin';
            lbcyevent_param4.Caption := 'CooldownMax';
            lbcyevent_type.Hint := '';
            edcyevent_type.Hint := lbcyevent_type.Hint;
        end;
    39:  //SMART_EVENT_WAYPOINT_START
        begin
            lbcyevent_param1.Caption := 'PointId (0 any)';
            lbcyevent_param2.Caption := 'pathId (0 any)';
            lbcyevent_param3.Caption := '';
            lbcyevent_param4.Caption := '';
            lbcyevent_type.Hint := '';
            edcyevent_type.Hint := lbcyevent_type.Hint;
        end;
    40:  //SMART_EVENT_WAYPOINT_REACHED
        begin
            lbcyevent_param1.Caption := 'PointId (0 any)';
            lbcyevent_param2.Caption := 'pathId (0 any)';
            lbcyevent_param3.Caption := '';
            lbcyevent_param4.Caption := '';
            lbcyevent_type.Hint := '';
            edcyevent_type.Hint := lbcyevent_type.Hint;
        end;
    41:  //SMART_EVENT_TRANSPORT_ADDPLAYER
        begin
            lbcyevent_param1.Caption := '';
            lbcyevent_param2.Caption := '';
            lbcyevent_param3.Caption := '';
            lbcyevent_param4.Caption := '';
            lbcyevent_type.Hint := '';
            edcyevent_type.Hint := lbcyevent_type.Hint;
        end;
    42:  //SMART_EVENT_TRANSPORT_ADDCREATURE
        begin
            lbcyevent_param1.Caption := 'Entry (0 any)';
            lbcyevent_param2.Caption := '';
            lbcyevent_param3.Caption := '';
            lbcyevent_param4.Caption := '';
            lbcyevent_type.Hint := '';
            edcyevent_type.Hint := lbcyevent_type.Hint;
        end;
    43:  //SMART_EVENT_TRANSPORT_REMOVE_PLAYER
        begin
            lbcyevent_param1.Caption := '';
            lbcyevent_param2.Caption := '';
            lbcyevent_param3.Caption := '';
            lbcyevent_param4.Caption := '';
            lbcyevent_type.Hint := '';
            edcyevent_type.Hint := lbcyevent_type.Hint;
        end;
    44:  //SMART_EVENT_TRANSPORT_RELOCATE
        begin
            lbcyevent_param1.Caption := 'PointId';
            lbcyevent_param2.Caption := '';
            lbcyevent_param3.Caption := '';
            lbcyevent_param4.Caption := '';
            lbcyevent_type.Hint := '';
            edcyevent_type.Hint := lbcyevent_type.Hint;
        end;
    45:  //SMART_EVENT_INSTANCE_PLAYER_ENTER
        begin
            lbcyevent_param1.Caption := 'Team (0 any)';
            lbcyevent_param2.Caption := 'CooldownMin';
            lbcyevent_param3.Caption := 'CooldownMax';
            lbcyevent_param4.Caption := '';
            lbcyevent_type.Hint := '';
            edcyevent_type.Hint := lbcyevent_type.Hint;
        end;
    46:  //SMART_EVENT_AREATRIGGER_ONTRIGGER
        begin
            lbcyevent_param1.Caption := 'TriggerId (0 any)';
            lbcyevent_param2.Caption := '';
            lbcyevent_param3.Caption := '';
            lbcyevent_param4.Caption := '';
            lbcyevent_type.Hint := '';
            edcyevent_type.Hint := lbcyevent_type.Hint;
        end;
    47:  //SMART_EVENT_QUEST_ACCEPTED
        begin
            lbcyevent_param1.Caption := '';
            lbcyevent_param2.Caption := '';
            lbcyevent_param3.Caption := '';
            lbcyevent_param4.Caption := '';
            lbcyevent_type.Hint := '';
            edcyevent_type.Hint := lbcyevent_type.Hint;
        end;
    48:  //SMART_EVENT_QUEST_OBJ_COPLETETION
        begin
            lbcyevent_param1.Caption := '';
            lbcyevent_param2.Caption := '';
            lbcyevent_param3.Caption := '';
            lbcyevent_param4.Caption := '';
            lbcyevent_type.Hint := '';
            edcyevent_type.Hint := lbcyevent_type.Hint;
        end;
    49:  //SMART_EVENT_QUEST_COMPLETION
        begin
            lbcyevent_param1.Caption := '';
            lbcyevent_param2.Caption := '';
            lbcyevent_param3.Caption := '';
            lbcyevent_param4.Caption := '';
            lbcyevent_type.Hint := '';
            edcyevent_type.Hint := lbcyevent_type.Hint;
        end;
    50:  //SMART_EVENT_QUEST_REWARDED
        begin
            lbcyevent_param1.Caption := '';
            lbcyevent_param2.Caption := '';
            lbcyevent_param3.Caption := '';
            lbcyevent_param4.Caption := '';
            lbcyevent_type.Hint := '';
            edcyevent_type.Hint := lbcyevent_type.Hint;
        end;
    51:  //SMART_EVENT_QUEST_FAIL
        begin
            lbcyevent_param1.Caption := '';
            lbcyevent_param2.Caption := '';
            lbcyevent_param3.Caption := '';
            lbcyevent_param4.Caption := '';
            lbcyevent_type.Hint := '';
            edcyevent_type.Hint := lbcyevent_type.Hint;
        end;
    52:  //SMART_EVENT_TEXT_OVER
        begin
            lbcyevent_param1.Caption := 'GroupId (creature_text)';
            lbcyevent_param2.Caption := 'CreatureId (0 = any)';
            lbcyevent_param3.Caption := '';
            lbcyevent_param4.Caption := '';
            lbcyevent_type.Hint := '';
            edcyevent_type.Hint := lbcyevent_type.Hint;
        end;
    53:  //SMART_EVENT_RECEIVE_HEAL
        begin
            lbcyevent_param1.Caption := 'MinHeal';
            lbcyevent_param2.Caption := 'MaxHeal';
            lbcyevent_param3.Caption := 'CooldownMin';
            lbcyevent_param4.Caption := 'CooldownMax';
            lbcyevent_type.Hint := '';
            edcyevent_type.Hint := lbcyevent_type.Hint;
        end;
    54:  //SMART_EVENT_JUST_SUMMONED
        begin
            lbcyevent_param1.Caption := '';
            lbcyevent_param2.Caption := '';
            lbcyevent_param3.Caption := '';
            lbcyevent_param4.Caption := '';
            lbcyevent_type.Hint := '';
            edcyevent_type.Hint := lbcyevent_type.Hint;
        end;
    55:  //SMART_EVENT_WAYPOINT_PAUSED
        begin
            lbcyevent_param1.Caption := 'PointId (0 any)';
            lbcyevent_param2.Caption := 'pathID (0 any)';
            lbcyevent_param3.Caption := '';
            lbcyevent_param4.Caption := '';
            lbcyevent_type.Hint := '';
            edcyevent_type.Hint := lbcyevent_type.Hint;
        end;
    56:  //SMART_EVENT_WAYPOINT_RESUMED
        begin
            lbcyevent_param1.Caption := 'PointId (0 any)';
            lbcyevent_param2.Caption := 'pathID (0 any)';
            lbcyevent_param3.Caption := '';
            lbcyevent_param4.Caption := '';
            lbcyevent_type.Hint := '';
            edcyevent_type.Hint := lbcyevent_type.Hint;
        end;
    57:  //SMART_EVENT_WAYPOINT_STOPPED
        begin
            lbcyevent_param1.Caption := 'PointId (0 any)';
            lbcyevent_param2.Caption := 'pathID (0 any)';
            lbcyevent_param3.Caption := '';
            lbcyevent_param4.Caption := '';
            lbcyevent_type.Hint := '';
            edcyevent_type.Hint := lbcyevent_type.Hint;
        end;
    58:  //SMART_EVENT_WAYPOINT_ENDED
        begin
            lbcyevent_param1.Caption := 'PointId (0 any)';
            lbcyevent_param2.Caption := 'pathID (0 any)';
            lbcyevent_param3.Caption := '';
            lbcyevent_param4.Caption := '';
            lbcyevent_type.Hint := '';
            edcyevent_type.Hint := lbcyevent_type.Hint;
        end;
    59:  //SMART_EVENT_TIMED_EVENT_TRIGGERED
        begin
            lbcyevent_param1.Caption := 'Id';
            lbcyevent_param2.Caption := '';
            lbcyevent_param3.Caption := '';
            lbcyevent_param4.Caption := '';
            lbcyevent_type.Hint := '';
            edcyevent_type.Hint := lbcyevent_type.Hint;
        end;
    60:  //SMART_EVENT_UPDATE
        begin
            lbcyevent_param1.Caption := 'InitialMin';
            lbcyevent_param2.Caption := 'InitialMax';
            lbcyevent_param3.Caption := 'RepeatMin';
            lbcyevent_param4.Caption := 'RepeatMax';
            lbcyevent_type.Hint := '';
            edcyevent_type.Hint := lbcyevent_type.Hint;
        end;
    61:  //SMART_EVENT_LINK
        begin
            lbcyevent_param1.Caption := '';
            lbcyevent_param2.Caption := '';
            lbcyevent_param3.Caption := '';
            lbcyevent_param4.Caption := '';
            lbcyevent_type.Hint := 'used to link together multiple events';
            edcyevent_type.Hint := lbcyevent_type.Hint;
        end;
    62:  //SMART_EVENT_GOSSIP_SELECT
        begin
            lbcyevent_param1.Caption := 'menuID';
            lbcyevent_param2.Caption := 'actionID';
            lbcyevent_param3.Caption := '';
            lbcyevent_param4.Caption := '';
            lbcyevent_type.Hint := '';
            edcyevent_type.Hint := lbcyevent_type.Hint;
        end;
    63:  //SMART_EVENT_JUST_CREATED
        begin
            lbcyevent_param1.Caption := '';
            lbcyevent_param2.Caption := '';
            lbcyevent_param3.Caption := '';
            lbcyevent_param4.Caption := '';
            lbcyevent_type.Hint := '';
            edcyevent_type.Hint := lbcyevent_type.Hint;
        end;
    64:  //SMART_EVENT_GOSSIP_HELLO
        begin
            lbcyevent_param1.Caption := '';
            lbcyevent_param2.Caption := '';
            lbcyevent_param3.Caption := '';
            lbcyevent_param4.Caption := '';
            lbcyevent_type.Hint := '';
            edcyevent_type.Hint := lbcyevent_type.Hint;
        end;
    65:  //SMART_EVENT_FOLLOW_COMPLETED
        begin
            lbcyevent_param1.Caption := '';
            lbcyevent_param2.Caption := '';
            lbcyevent_param3.Caption := '';
            lbcyevent_param4.Caption := '';
            lbcyevent_type.Hint := '';
            edcyevent_type.Hint := lbcyevent_type.Hint;
        end;
    66:  //SMART_EVENT_DUMMY_EFFECT
        begin
            lbcyevent_param1.Caption := 'spellId';
            lbcyevent_param2.Caption := 'effectIndex';
            lbcyevent_param3.Caption := '';
            lbcyevent_param4.Caption := '';
            lbcyevent_type.Hint := '';
            edcyevent_type.Hint := lbcyevent_type.Hint;
        end;
    end;
    SAI_Event := t;
end;

procedure TMainForm.SetSAIAction(t: integer);
begin
    //Buttons
    edcyaction_param1.ShowButton := false;
    edcyaction_param2.ShowButton := false;
    edcyaction_param6.ShowButton := false;
    case t of
    8:
        begin
            edcyaction_param1.ShowButton := true;
        end;
    12:
        begin
            edcyaction_param2.ShowButton := true;
        end;
    53:
        begin
            edcyaction_param6.ShowButton := true;
        end;
    end;

    //Normal
    case t of
    0:  //SMART_ACTION_NONE
        begin
            lbcyaction_param1.Caption := '';
            lbcyaction_param2.Caption := '';
            lbcyaction_param3.Caption := '';
            lbcyaction_param4.Caption := '';
            lbcyaction_param5.Caption := '';
            lbcyaction_param6.Caption := '';
            lbcyaction_type.Hint := '';
            edcyaction_type.Hint := lbcyaction_type.Hint;
        end;
    1:  //SMART_ACTION_TALK
        begin
            lbcyaction_param1.Caption := 'Creature_text.groupid';
            lbcyaction_param2.Caption := 'duration';
            lbcyaction_param3.Caption := '';
            lbcyaction_param4.Caption := '';
            lbcyaction_param5.Caption := '';
            lbcyaction_param6.Caption := '';
            lbcyaction_param2.Hint := 'duration to wait before TEXT_OVER event is triggered';
            edcyaction_param2.Hint := lbcyaction_param2.Hint;
            lbcyaction_type.Hint := '';
            edcyaction_type.Hint := lbcyaction_type.Hint;
        end;
    2:  //SMART_ACTION_SET_FACTION
        begin
            lbcyaction_param1.Caption := 'FactionID (0 default)';
            lbcyaction_param2.Caption := '';
            lbcyaction_param3.Caption := '';
            lbcyaction_param4.Caption := '';
            lbcyaction_param5.Caption := '';
            lbcyaction_param6.Caption := '';
            lbcyaction_type.Hint := '';
            edcyaction_type.Hint := lbcyaction_type.Hint;
        end;
    3:  //SMART_ACTION_MORPH_TO_ENTRY_OR_MODEL
        begin
            lbcyaction_param1.Caption := 'CreatureID';
            lbcyaction_param2.Caption := 'ModelID';
            lbcyaction_param3.Caption := '';
            lbcyaction_param4.Caption := '';
            lbcyaction_param5.Caption := '';
            lbcyaction_param6.Caption := '';
            lbcyaction_param1.Hint := 'Or 0 in both fields to demorph';
            edcyaction_param1.Hint := lbcyaction_param1.Hint;
            lbcyaction_param2.Hint := lbcyaction_param1.Hint;
            edcyaction_param2.Hint := lbcyaction_param1.Hint;
            lbcyaction_type.Hint := '';
            edcyaction_type.Hint := lbcyaction_type.Hint;
        end;
    4:  //SMART_ACTION_SOUND
        begin
            lbcyaction_param1.Caption := 'SoundId';
            lbcyaction_param2.Caption := 'TextRange';
            lbcyaction_param3.Caption := '';
            lbcyaction_param4.Caption := '';
            lbcyaction_param5.Caption := '';
            lbcyaction_param6.Caption := '';
            lbcyaction_type.Hint := '';
            edcyaction_type.Hint := lbcyaction_type.Hint;
        end;
    5:  //SMART_ACTION_PLAY_EMOTE
        begin
            lbcyaction_param1.Caption := 'EmoteId';
            lbcyaction_param2.Caption := '';
            lbcyaction_param3.Caption := '';
            lbcyaction_param4.Caption := '';
            lbcyaction_param5.Caption := '';
            lbcyaction_param6.Caption := '';
            lbcyaction_type.Hint := '';
            edcyaction_type.Hint := lbcyaction_type.Hint;
        end;
    6:  //SMART_ACTION_FAIL_QUEST
        begin
            lbcyaction_param1.Caption := 'QuestID';
            lbcyaction_param2.Caption := '';
            lbcyaction_param3.Caption := '';
            lbcyaction_param4.Caption := '';
            lbcyaction_param5.Caption := '';
            lbcyaction_param6.Caption := '';
            lbcyaction_type.Hint := '';
            edcyaction_type.Hint := lbcyaction_type.Hint;
        end;
    7:  //SMART_ACTION_ADD_QUEST
        begin
            lbcyaction_param1.Caption := 'QuestID';
            lbcyaction_param2.Caption := '';
            lbcyaction_param3.Caption := '';
            lbcyaction_param4.Caption := '';
            lbcyaction_param5.Caption := '';
            lbcyaction_param6.Caption := '';
            lbcyaction_type.Hint := '';
            edcyaction_type.Hint := lbcyaction_type.Hint;
        end;
    8:  //SMART_ACTION_SET_REACT_STATE
        begin
            lbcyaction_param1.Caption := 'State';
            lbcyaction_param2.Caption := '';
            lbcyaction_param3.Caption := '';
            lbcyaction_param4.Caption := '';
            lbcyaction_param5.Caption := '';
            lbcyaction_param6.Caption := '';
            lbcyaction_type.Hint := '';
            edcyaction_type.Hint := lbcyaction_type.Hint;
        end;
    9:  //SMART_ACTION_ACTIVATE_GOBJECT
        begin
            lbcyaction_param1.Caption := '';
            lbcyaction_param2.Caption := '';
            lbcyaction_param3.Caption := '';
            lbcyaction_param4.Caption := '';
            lbcyaction_param5.Caption := '';
            lbcyaction_param6.Caption := '';
            lbcyaction_type.Hint := '';
            edcyaction_type.Hint := lbcyaction_type.Hint;
        end;
    10:  //SMART_ACTION_RANDOM_EMOTE
        begin
            lbcyaction_param1.Caption := 'EmoteId1';
            lbcyaction_param2.Caption := 'EmoteId2';
            lbcyaction_param3.Caption := 'EmoteId3';
            lbcyaction_param4.Caption := 'EmoteId4';
            lbcyaction_param5.Caption := 'EmoteId5';
            lbcyaction_param6.Caption := 'EmoteId6';
            lbcyaction_type.Hint := '';
            edcyaction_type.Hint := lbcyaction_type.Hint;
        end;
    11:  //SMART_ACTION_CAST
        begin
            lbcyaction_param1.Caption := 'SpellId';
            lbcyaction_param2.Caption := 'CastFlags';
            lbcyaction_param3.Caption := '';
            lbcyaction_param4.Caption := '';
            lbcyaction_param5.Caption := '';
            lbcyaction_param6.Caption := '';
            lbcyaction_type.Hint := '';
            edcyaction_type.Hint := lbcyaction_type.Hint;
        end;
    12:  //SMART_ACTION_SUMMON_CREATURE
        begin
            lbcyaction_param1.Caption := 'CreatureID';
            lbcyaction_param2.Caption := 'Summon type';
            lbcyaction_param3.Caption := 'duration in ms';
            lbcyaction_param4.Caption := 'StorageID';
            lbcyaction_param5.Caption := 'attackInvoker';
            lbcyaction_param6.Caption := '';
            lbcyaction_type.Hint := '';
            edcyaction_type.Hint := lbcyaction_type.Hint;
        end;
    13:  //SMART_ACTION_THREAT_SINGLE_PCT
        begin
            lbcyaction_param1.Caption := 'Threat%';
            lbcyaction_param2.Caption := '';
            lbcyaction_param3.Caption := '';
            lbcyaction_param4.Caption := '';
            lbcyaction_param5.Caption := '';
            lbcyaction_param6.Caption := '';
            lbcyaction_type.Hint := '';
            edcyaction_type.Hint := lbcyaction_type.Hint;
        end;
    14:  //SMART_ACTION_THREAT_ALL_PCT
        begin
            lbcyaction_param1.Caption := 'Threat%';
            lbcyaction_param2.Caption := '';
            lbcyaction_param3.Caption := '';
            lbcyaction_param4.Caption := '';
            lbcyaction_param5.Caption := '';
            lbcyaction_param6.Caption := '';
            lbcyaction_type.Hint := '';
            edcyaction_type.Hint := lbcyaction_type.Hint;
        end;
    15:  //SMART_ACTION_CALL_AREAEXPLOREDOREVENTHAPPENS
        begin
            lbcyaction_param1.Caption := 'QuestID';
            lbcyaction_param2.Caption := '';
            lbcyaction_param3.Caption := '';
            lbcyaction_param4.Caption := '';
            lbcyaction_param5.Caption := '';
            lbcyaction_param6.Caption := '';
            lbcyaction_type.Hint := '';
            edcyaction_type.Hint := lbcyaction_type.Hint;
        end;
    16:  //SMART_ACTION_SEND_CASTCREATUREORGO
        begin
            lbcyaction_param1.Caption := 'QuestID';
            lbcyaction_param2.Caption := 'SpellId';
            lbcyaction_param3.Caption := '';
            lbcyaction_param4.Caption := '';
            lbcyaction_param5.Caption := '';
            lbcyaction_param6.Caption := '';
            lbcyaction_type.Hint := '';
            edcyaction_type.Hint := lbcyaction_type.Hint;
        end;
    17:  //SMART_ACTION_SET_EMOTE_STATE
        begin
            lbcyaction_param1.Caption := 'emoteID';
            lbcyaction_param2.Caption := '';
            lbcyaction_param3.Caption := '';
            lbcyaction_param4.Caption := '';
            lbcyaction_param5.Caption := '';
            lbcyaction_param6.Caption := '';
            lbcyaction_type.Hint := '';
            edcyaction_type.Hint := lbcyaction_type.Hint;
        end;
    18:  //SMART_ACTION_SET_UNIT_FLAG
        begin
            lbcyaction_param1.Caption := 'unit_flags';
            lbcyaction_param2.Caption := 'Target';
            lbcyaction_param3.Caption := '';
            lbcyaction_param4.Caption := '';
            lbcyaction_param5.Caption := '';
            lbcyaction_param6.Caption := '';
            lbcyaction_param1.Hint := 'may be more than one field OR''d together';
            edcyaction_param1.Hint := lbcyaction_param1.Hint;
            lbcyaction_type.Hint := '';
            edcyaction_type.Hint := lbcyaction_type.Hint;
        end;
    19:  //SMART_ACTION_REMOVE_UNIT_FLAG
        begin
            lbcyaction_param1.Caption := 'unit_flags';
            lbcyaction_param2.Caption := 'Target';
            lbcyaction_param3.Caption := '';
            lbcyaction_param4.Caption := '';
            lbcyaction_param5.Caption := '';
            lbcyaction_param6.Caption := '';
            lbcyaction_param1.Hint := 'may be more than one field OR''d together';
            edcyaction_param1.Hint := lbcyaction_param1.Hint;
            lbcyaction_type.Hint := '';
            edcyaction_type.Hint := lbcyaction_type.Hint;
        end;
    20:  //SMART_ACTION_AUTO_ATTACK
        begin
            lbcyaction_param1.Caption := 'AllowAttackState';
            lbcyaction_param2.Caption := '';
            lbcyaction_param3.Caption := '';
            lbcyaction_param4.Caption := '';
            lbcyaction_param5.Caption := '';
            lbcyaction_param6.Caption := '';
            lbcyaction_param1.Hint := '0 = Stop attack, anything else means continue attacking';
            edcyaction_param1.Hint := lbcyaction_param1.Hint;
            lbcyaction_type.Hint := '';
            edcyaction_type.Hint := lbcyaction_type.Hint;
        end;
    21:  //SMART_ACTION_ALLOW_COMBAT_MOVEMENT
        begin
            lbcyaction_param1.Caption := 'AllowCombatMovement';
            lbcyaction_param2.Caption := '';
            lbcyaction_param3.Caption := '';
            lbcyaction_param4.Caption := '';
            lbcyaction_param5.Caption := '';
            lbcyaction_param6.Caption := '';
            lbcyaction_param1.Hint := '0 = Stop combat based movement, anything else continue attacking';
            edcyaction_param1.Hint := lbcyaction_param1.Hint;
            lbcyaction_type.Hint := '';
            edcyaction_type.Hint := lbcyaction_type.Hint;
        end;
    22:  //SMART_ACTION_SET_EVENT_PHASE
        begin
            lbcyaction_param1.Caption := 'event_phase_mask';
            lbcyaction_param2.Caption := '';
            lbcyaction_param3.Caption := '';
            lbcyaction_param4.Caption := '';
            lbcyaction_param5.Caption := '';
            lbcyaction_param6.Caption := '';
            lbcyaction_param1.Hint := 'smart_scripts.event_phase_mask';
            edcyaction_param1.Hint := lbcyaction_param1.Hint;
            lbcyaction_type.Hint := '';
            edcyaction_type.Hint := lbcyaction_type.Hint;
        end;
    23:  //SMART_ACTION_INC_EVENT_PHASE
        begin
            lbcyaction_param1.Caption := 'Value';
            lbcyaction_param2.Caption := '';
            lbcyaction_param3.Caption := '';
            lbcyaction_param4.Caption := '';
            lbcyaction_param5.Caption := '';
            lbcyaction_param6.Caption := '';
            lbcyaction_param1.Hint := 'may be negative to decrement phase, should not be 0';
            edcyaction_param1.Hint := lbcyaction_param1.Hint;
            lbcyaction_type.Hint := '';
            edcyaction_type.Hint := lbcyaction_type.Hint;
        end;
    24:  //SMART_ACTION_EVADE
        begin
            lbcyaction_param1.Caption := '';
            lbcyaction_param2.Caption := '';
            lbcyaction_param3.Caption := '';
            lbcyaction_param4.Caption := '';
            lbcyaction_param5.Caption := '';
            lbcyaction_param6.Caption := '';
            lbcyaction_type.Hint := '';
            edcyaction_type.Hint := lbcyaction_type.Hint;
        end;
    25:  //SMART_ACTION_FLEE_FOR_ASSIST
        begin
            lbcyaction_param1.Caption := '';
            lbcyaction_param2.Caption := '';
            lbcyaction_param3.Caption := '';
            lbcyaction_param4.Caption := '';
            lbcyaction_param5.Caption := '';
            lbcyaction_param6.Caption := '';
            lbcyaction_type.Hint := '';
            edcyaction_type.Hint := lbcyaction_type.Hint;
        end;
    26:  //SMART_ACTION_CALL_GROUPEVENTHAPPENS
        begin
            lbcyaction_param1.Caption := 'QuestID';
            lbcyaction_param2.Caption := '';
            lbcyaction_param3.Caption := '';
            lbcyaction_param4.Caption := '';
            lbcyaction_param5.Caption := '';
            lbcyaction_param6.Caption := '';
            lbcyaction_type.Hint := '';
            edcyaction_type.Hint := lbcyaction_type.Hint;
        end;
    27:  //SMART_ACTION_CALL_CASTEDCREATUREORGO
        begin
            lbcyaction_param1.Caption := 'Creature_template.entry';
            lbcyaction_param2.Caption := 'SpellId';
            lbcyaction_param3.Caption := '';
            lbcyaction_param4.Caption := '';
            lbcyaction_param5.Caption := '';
            lbcyaction_param6.Caption := '';
            lbcyaction_type.Hint := '';
            edcyaction_type.Hint := lbcyaction_type.Hint;
        end;
    28:  //SMART_ACTION_REMOVEAURASFROMSPELL
        begin
            lbcyaction_param1.Caption := 'Spellid';
            lbcyaction_param2.Caption := '';
            lbcyaction_param3.Caption := '';
            lbcyaction_param4.Caption := '';
            lbcyaction_param5.Caption := '';
            lbcyaction_param6.Caption := '';
            lbcyaction_type.Hint := '';
            edcyaction_type.Hint := lbcyaction_type.Hint;
        end;
    29:  //SMART_ACTION_FOLLOW
        begin
            lbcyaction_param1.Caption := 'Distance';
            lbcyaction_param2.Caption := 'Angle';
            lbcyaction_param3.Caption := 'EndCreatureEntry';
            lbcyaction_param4.Caption := 'credit';
            lbcyaction_param5.Caption := 'creditType';
            lbcyaction_param6.Caption := '';
            lbcyaction_param5.Hint := '0 = Monsterkill; 1 = Event';
            edcyaction_param5.Hint := lbcyaction_param5.Hint;
            lbcyaction_type.Hint := '';
            edcyaction_type.Hint := lbcyaction_type.Hint;
        end;
    30:  //SMART_ACTION_RANDOM_PHASE
        begin
            lbcyaction_param1.Caption := 'phasemask 1';
            lbcyaction_param2.Caption := 'phasemask 2';
            lbcyaction_param3.Caption := 'phasemask 3';
            lbcyaction_param4.Caption := 'phasemask 4';
            lbcyaction_param5.Caption := 'phasemask 5';
            lbcyaction_param6.Caption := 'phasemask 6';
            lbcyaction_type.Hint := '';
            edcyaction_type.Hint := lbcyaction_type.Hint;
        end;
    31:  //SMART_ACTION_RANDOM_PHASE_RANGE
        begin
            lbcyaction_param1.Caption := 'phasemask minimum';
            lbcyaction_param2.Caption := 'phasemask maximum';
            lbcyaction_param3.Caption := '';
            lbcyaction_param4.Caption := '';
            lbcyaction_param5.Caption := '';
            lbcyaction_param6.Caption := '';
            lbcyaction_type.Hint := '';
            edcyaction_type.Hint := lbcyaction_type.Hint;
        end;
    32:  //SMART_ACTION_RESET_GOBJECT
        begin
            lbcyaction_param1.Caption := '';
            lbcyaction_param2.Caption := '';
            lbcyaction_param3.Caption := '';
            lbcyaction_param4.Caption := '';
            lbcyaction_param5.Caption := '';
            lbcyaction_param6.Caption := '';
            lbcyaction_type.Hint := '';
            edcyaction_type.Hint := lbcyaction_type.Hint;
        end;
    33:  //SMART_ACTION_CALL_KILLEDMONSTER
        begin
            lbcyaction_param1.Caption := 'CreatureId';
            lbcyaction_param2.Caption := '';
            lbcyaction_param3.Caption := '';
            lbcyaction_param4.Caption := '';
            lbcyaction_param5.Caption := '';
            lbcyaction_param6.Caption := '';
            lbcyaction_type.Hint := '';
            edcyaction_type.Hint := lbcyaction_type.Hint;
        end;
    34:  //SMART_ACTION_SET_INST_DATA
        begin
            lbcyaction_param1.Caption := 'Field';
            lbcyaction_param2.Caption := 'Data';
            lbcyaction_param3.Caption := '';
            lbcyaction_param4.Caption := '';
            lbcyaction_param5.Caption := '';
            lbcyaction_param6.Caption := '';
            lbcyaction_type.Hint := '';
            edcyaction_type.Hint := lbcyaction_type.Hint;
        end;
    35:  //SMART_ACTION_SET_INST_DATA64
        begin
            lbcyaction_param1.Caption := 'Field';
            lbcyaction_param2.Caption := '';
            lbcyaction_param3.Caption := '';
            lbcyaction_param4.Caption := '';
            lbcyaction_param5.Caption := '';
            lbcyaction_param6.Caption := '';
            lbcyaction_type.Hint := '';
            edcyaction_type.Hint := lbcyaction_type.Hint;
        end;
    36:  //SMART_ACTION_UPDATE_TEMPLATE
        begin
            lbcyaction_param1.Caption := 'Entry';
            lbcyaction_param2.Caption := 'Team';
            lbcyaction_param3.Caption := '';
            lbcyaction_param4.Caption := '';
            lbcyaction_param5.Caption := '';
            lbcyaction_param6.Caption := '';
            lbcyaction_param2.Hint := 'updates creature_template to given entry';
            edcyaction_param2.Hint := lbcyaction_param2.Hint;
            lbcyaction_type.Hint := '';
            edcyaction_type.Hint := lbcyaction_type.Hint;
        end;
    37:  //SMART_ACTION_DIE
        begin
            lbcyaction_param1.Caption := '';
            lbcyaction_param2.Caption := '';
            lbcyaction_param3.Caption := '';
            lbcyaction_param4.Caption := '';
            lbcyaction_param5.Caption := '';
            lbcyaction_param6.Caption := '';
            lbcyaction_type.Hint := '';
            edcyaction_type.Hint := lbcyaction_type.Hint;
        end;
    38:  //SMART_ACTION_SET_IN_COMBAT_WITH_ZONE
        begin
            lbcyaction_param1.Caption := '';
            lbcyaction_param2.Caption := '';
            lbcyaction_param3.Caption := '';
            lbcyaction_param4.Caption := '';
            lbcyaction_param5.Caption := '';
            lbcyaction_param6.Caption := '';
            lbcyaction_type.Hint := '';
            edcyaction_type.Hint := lbcyaction_type.Hint;
        end;
    39:  //SMART_ACTION_CALL_FOR_HELP
        begin
            lbcyaction_param1.Caption := 'radius';
            lbcyaction_param2.Caption := '';
            lbcyaction_param3.Caption := '';
            lbcyaction_param4.Caption := '';
            lbcyaction_param5.Caption := '';
            lbcyaction_param6.Caption := '';
            lbcyaction_param1.Hint := 'Radius in yards that other creatures must be to acknowledge the cry for help';
            edcyaction_param1.Hint := lbcyaction_param1.Hint;
            lbcyaction_type.Hint := '';
            edcyaction_type.Hint := lbcyaction_type.Hint;
        end;
    40:  //SMART_ACTION_SET_SHEATH
        begin
            lbcyaction_param1.Caption := 'Sheath';
            lbcyaction_param2.Caption := '';
            lbcyaction_param3.Caption := '';
            lbcyaction_param4.Caption := '';
            lbcyaction_param5.Caption := '';
            lbcyaction_param6.Caption := '';
            lbcyaction_param1.Hint := '0-unarmed, 1-melee, 2-ranged';
            edcyaction_param1.Hint := lbcyaction_param1.Hint;
            lbcyaction_type.Hint := '';
            edcyaction_type.Hint := lbcyaction_type.Hint;
        end;
    41:  //SMART_ACTION_FORCE_DESPAWN
        begin
            lbcyaction_param1.Caption := 'timer';
            lbcyaction_param2.Caption := '';
            lbcyaction_param3.Caption := '';
            lbcyaction_param4.Caption := '';
            lbcyaction_param5.Caption := '';
            lbcyaction_param6.Caption := '';
            lbcyaction_type.Hint := '';
            edcyaction_type.Hint := lbcyaction_type.Hint;
        end;
    42:  //SMART_ACTION_SET_INVINCIBILITY_HP_LEVEL
        begin
            lbcyaction_param1.Caption := 'MinHpValue(+pct,-flat)';
            lbcyaction_param2.Caption := '';
            lbcyaction_param3.Caption := '';
            lbcyaction_param4.Caption := '';
            lbcyaction_param5.Caption := '';
            lbcyaction_param6.Caption := '';
            lbcyaction_type.Hint := '';
            edcyaction_type.Hint := lbcyaction_type.Hint;
        end;
    43:  //SMART_ACTION_MOUNT_TO_ENTRY_OR_MODEL
        begin
            lbcyaction_param1.Caption := 'Creature_template.entry';
            lbcyaction_param2.Caption := 'Creature_template.modelID';
            lbcyaction_param3.Caption := '';
            lbcyaction_param4.Caption := '';
            lbcyaction_param5.Caption := '';
            lbcyaction_param6.Caption := '';
            lbcyaction_type.Hint := '(or 0 for both to unmount)';
            edcyaction_type.Hint := lbcyaction_type.Hint;
        end;
    44:  //SMART_ACTION_SET_INGAME_PHASE_MASK
        begin
            lbcyaction_param1.Caption := 'Creature.phasemask';
            lbcyaction_param2.Caption := '';
            lbcyaction_param3.Caption := '';
            lbcyaction_param4.Caption := '';
            lbcyaction_param5.Caption := '';
            lbcyaction_param6.Caption := '';
            lbcyaction_type.Hint := '';
            edcyaction_type.Hint := lbcyaction_type.Hint;
        end;
    45:  //SMART_ACTION_SET_DATA
        begin
            lbcyaction_param1.Caption := 'Field';
            lbcyaction_param2.Caption := 'Data';
            lbcyaction_param3.Caption := '';
            lbcyaction_param4.Caption := '';
            lbcyaction_param5.Caption := '';
            lbcyaction_param6.Caption := '';
            lbcyaction_type.Hint := '(only creature TODO)';
            edcyaction_type.Hint := lbcyaction_type.Hint;
        end;
    46:  //SMART_ACTION_MOVE_FORWARD
        begin
            lbcyaction_param1.Caption := 'Distance in yards';
            lbcyaction_param2.Caption := '';
            lbcyaction_param3.Caption := '';
            lbcyaction_param4.Caption := '';
            lbcyaction_param5.Caption := '';
            lbcyaction_param6.Caption := '';
            lbcyaction_type.Hint := '';
            edcyaction_type.Hint := lbcyaction_type.Hint;
        end;
    47:  //SMART_ACTION_SET_VISIBILITY
        begin
            lbcyaction_param1.Caption := '0/1';
            lbcyaction_param2.Caption := '';
            lbcyaction_param3.Caption := '';
            lbcyaction_param4.Caption := '';
            lbcyaction_param5.Caption := '';
            lbcyaction_param6.Caption := '';
            lbcyaction_type.Hint := '';
            edcyaction_type.Hint := lbcyaction_type.Hint;
        end;
    48:  //SMART_ACTION_SET_ACTIVE
        begin
            lbcyaction_param1.Caption := '';
            lbcyaction_param2.Caption := '';
            lbcyaction_param3.Caption := '';
            lbcyaction_param4.Caption := '';
            lbcyaction_param5.Caption := '';
            lbcyaction_param6.Caption := '';
            lbcyaction_type.Hint := '';
            edcyaction_type.Hint := lbcyaction_type.Hint;
        end;
    49:  //SMART_ACTION_ATTACK_START
        begin
            lbcyaction_param1.Caption := '';
            lbcyaction_param2.Caption := '';
            lbcyaction_param3.Caption := '';
            lbcyaction_param4.Caption := '';
            lbcyaction_param5.Caption := '';
            lbcyaction_param6.Caption := '';
            lbcyaction_type.Hint := '';
            edcyaction_type.Hint := lbcyaction_type.Hint;
        end;
    50:  //SMART_ACTION_SUMMON_GO
        begin
            lbcyaction_param1.Caption := 'Gameobject_template.entry';
            lbcyaction_param2.Caption := 'DespawnTime in ms';
            lbcyaction_param3.Caption := '';
            lbcyaction_param4.Caption := '';
            lbcyaction_param5.Caption := '';
            lbcyaction_param6.Caption := '';
            lbcyaction_type.Hint := '';
            edcyaction_type.Hint := lbcyaction_type.Hint;
        end;
    51:  //SMART_ACTION_KILL_UNIT
        begin
            lbcyaction_param1.Caption := '';
            lbcyaction_param2.Caption := '';
            lbcyaction_param3.Caption := '';
            lbcyaction_param4.Caption := '';
            lbcyaction_param5.Caption := '';
            lbcyaction_param6.Caption := '';
            lbcyaction_type.Hint := '';
            edcyaction_type.Hint := lbcyaction_type.Hint;
        end;
    52:  //SMART_ACTION_ACTIVATE_TAXI
        begin
            lbcyaction_param1.Caption := 'TaxiID';
            lbcyaction_param2.Caption := '';
            lbcyaction_param3.Caption := '';
            lbcyaction_param4.Caption := '';
            lbcyaction_param5.Caption := '';
            lbcyaction_param6.Caption := '';
            lbcyaction_type.Hint := '';
            edcyaction_type.Hint := lbcyaction_type.Hint;
        end;
    53:  //SMART_ACTION_WP_START
        begin
            lbcyaction_param1.Caption := 'run/walk';
            lbcyaction_param2.Caption := 'Waypoint_data.PathID';
            lbcyaction_param3.Caption := 'canRepeat';
            lbcyaction_param4.Caption := 'Quest_template.entry';
            lbcyaction_param5.Caption := 'despawntime';
            lbcyaction_param6.Caption := 'reactState';
            lbcyaction_type.Hint := '';
            edcyaction_type.Hint := lbcyaction_type.Hint;
        end;
    54:  //SMART_ACTION_WP_PAUSE
        begin
            lbcyaction_param1.Caption := 'time';
            lbcyaction_param2.Caption := '';
            lbcyaction_param3.Caption := '';
            lbcyaction_param4.Caption := '';
            lbcyaction_param5.Caption := '';
            lbcyaction_param6.Caption := '';
            lbcyaction_type.Hint := '';
            edcyaction_type.Hint := lbcyaction_type.Hint;
        end;
    55:  //SMART_ACTION_WP_STOP
        begin
            lbcyaction_param1.Caption := 'despawnTime';
            lbcyaction_param2.Caption := 'Quest_template.entry';
            lbcyaction_param3.Caption := 'fail (0/1)';
            lbcyaction_param4.Caption := '';
            lbcyaction_param5.Caption := '';
            lbcyaction_param6.Caption := '';
            lbcyaction_type.Hint := '';
            edcyaction_type.Hint := lbcyaction_type.Hint;
        end;
    56:  //SMART_ACTION_ADD_ITEM
        begin
            lbcyaction_param1.Caption := 'Item_template.entry';
            lbcyaction_param2.Caption := 'count';
            lbcyaction_param3.Caption := '';
            lbcyaction_param4.Caption := '';
            lbcyaction_param5.Caption := '';
            lbcyaction_param6.Caption := '';
            lbcyaction_type.Hint := '';
            edcyaction_type.Hint := lbcyaction_type.Hint;
        end;
    57:  //SMART_ACTION_REMOVE_ITEM
        begin
            lbcyaction_param1.Caption := 'Item_template.entry';
            lbcyaction_param2.Caption := 'count';
            lbcyaction_param3.Caption := '';
            lbcyaction_param4.Caption := '';
            lbcyaction_param5.Caption := '';
            lbcyaction_param6.Caption := '';
            lbcyaction_type.Hint := '';
            edcyaction_type.Hint := lbcyaction_type.Hint;
        end;
    58:  //SMART_ACTION_INSTALL_AI_TEMPLATE
        begin
            lbcyaction_param1.Caption := 'AITemplateID';
            lbcyaction_param2.Caption := '';
            lbcyaction_param3.Caption := '';
            lbcyaction_param4.Caption := '';
            lbcyaction_param5.Caption := '';
            lbcyaction_param6.Caption := '';
            lbcyaction_type.Hint := '';
            edcyaction_type.Hint := lbcyaction_type.Hint;
        end;
    59:  //SMART_ACTION_SET_RUN
        begin
            lbcyaction_param1.Caption := '0/1';
            lbcyaction_param2.Caption := '';
            lbcyaction_param3.Caption := '';
            lbcyaction_param4.Caption := '';
            lbcyaction_param5.Caption := '';
            lbcyaction_param6.Caption := '';
            lbcyaction_type.Hint := '';
            edcyaction_type.Hint := lbcyaction_type.Hint;
        end;
    60:  //SMART_ACTION_SET_FLY
        begin
            lbcyaction_param1.Caption := '0/1';
            lbcyaction_param2.Caption := '';
            lbcyaction_param3.Caption := '';
            lbcyaction_param4.Caption := '';
            lbcyaction_param5.Caption := '';
            lbcyaction_param6.Caption := '';
            lbcyaction_type.Hint := '';
            edcyaction_type.Hint := lbcyaction_type.Hint;
        end;
    61:  //SMART_ACTION_SET_SWIMM
        begin
            lbcyaction_param1.Caption := '0/1';
            lbcyaction_param2.Caption := '';
            lbcyaction_param3.Caption := '';
            lbcyaction_param4.Caption := '';
            lbcyaction_param5.Caption := '';
            lbcyaction_param6.Caption := '';
            lbcyaction_type.Hint := '';
            edcyaction_type.Hint := lbcyaction_type.Hint;
        end;
    62:  //SMART_ACTION_TELEPORT
        begin
            lbcyaction_param1.Caption := 'MapID';
            lbcyaction_param2.Caption := '';
            lbcyaction_param3.Caption := '';
            lbcyaction_param4.Caption := '';
            lbcyaction_param5.Caption := '';
            lbcyaction_param6.Caption := '';
            lbcyaction_type.Hint := 'Use target_type = 8 (SMART_TARGET_POSITION)';
            edcyaction_type.Hint := lbcyaction_type.Hint;
        end;
    63:  //SMART_ACTION_STORE_VARIABLE_DECIMAL
        begin
            lbcyaction_param1.Caption := 'varID';
            lbcyaction_param2.Caption := 'number';
            lbcyaction_param3.Caption := '';
            lbcyaction_param4.Caption := '';
            lbcyaction_param5.Caption := '';
            lbcyaction_param6.Caption := '';
            lbcyaction_type.Hint := '';
            edcyaction_type.Hint := lbcyaction_type.Hint;
        end;
    64:  //SMART_ACTION_STORE_TARGET_LIST
        begin
            lbcyaction_param1.Caption := 'varID';
            lbcyaction_param2.Caption := '';
            lbcyaction_param3.Caption := '';
            lbcyaction_param4.Caption := '';
            lbcyaction_param5.Caption := '';
            lbcyaction_param6.Caption := '';
            lbcyaction_type.Hint := '';
            edcyaction_type.Hint := lbcyaction_type.Hint;
        end;
    65:  //SMART_ACTION_WP_RESUME
        begin
            lbcyaction_param1.Caption := '';
            lbcyaction_param2.Caption := '';
            lbcyaction_param3.Caption := '';
            lbcyaction_param4.Caption := '';
            lbcyaction_param5.Caption := '';
            lbcyaction_param6.Caption := '';
            lbcyaction_type.Hint := '';
            edcyaction_type.Hint := lbcyaction_type.Hint;
        end;
    66:  //SMART_ACTION_SET_ORIENTATION
        begin
            lbcyaction_param1.Caption := 'see tooltip';
            lbcyaction_param2.Caption := '';
            lbcyaction_param3.Caption := '';
            lbcyaction_param4.Caption := '';
            lbcyaction_param5.Caption := '';
            lbcyaction_param6.Caption := '';
            lbcyaction_param1.Hint := 'use target_type 8 (SMART_TYPE_POSITION) and define o or npc will face target';
            edcyaction_param1.Hint := lbcyaction_param1.Hint;
            lbcyaction_type.Hint := '';
            edcyaction_type.Hint := lbcyaction_type.Hint;
        end;
    67:  //SMART_ACTION_CREATE_TIMED_EVENT
        begin
            lbcyaction_param1.Caption := 'id';
            lbcyaction_param2.Caption := 'InitialMin';
            lbcyaction_param3.Caption := 'InitialMax';
            lbcyaction_param4.Caption := 'RepeatMin (if repeats)';
            lbcyaction_param5.Caption := 'RepeatMax (if repeats)';
            lbcyaction_param6.Caption := 'chance';
            lbcyaction_type.Hint := '';
            edcyaction_type.Hint := lbcyaction_type.Hint;
        end;
    68:  //SMART_ACTION_PLAYMOVIE
        begin
            lbcyaction_param1.Caption := 'entry';
            lbcyaction_param2.Caption := '';
            lbcyaction_param3.Caption := '';
            lbcyaction_param4.Caption := '';
            lbcyaction_param5.Caption := '';
            lbcyaction_param6.Caption := '';
            lbcyaction_type.Hint := '';
            edcyaction_type.Hint := lbcyaction_type.Hint;
        end;
    69:  //SMART_ACTION_MOVE_TO_POS
        begin
            lbcyaction_param1.Caption := 'x';
            lbcyaction_param2.Caption := 'y';
            lbcyaction_param3.Caption := 'z';
            lbcyaction_param4.Caption := '';
            lbcyaction_param5.Caption := '';
            lbcyaction_param6.Caption := '';
            lbcyaction_type.Hint := '';
            edcyaction_type.Hint := lbcyaction_type.Hint;
        end;
    70:  //SMART_ACTION_RESPAWN_TARGET
        begin
            lbcyaction_param1.Caption := '';
            lbcyaction_param2.Caption := '';
            lbcyaction_param3.Caption := '';
            lbcyaction_param4.Caption := '';
            lbcyaction_param5.Caption := '';
            lbcyaction_param6.Caption := '';
            lbcyaction_type.Hint := '';
            edcyaction_type.Hint := lbcyaction_type.Hint;
        end;
    71:  //SMART_ACTION_EQUIP
        begin
            lbcyaction_param1.Caption := 'equipentry';
            lbcyaction_param2.Caption := 'Slotmask';
            lbcyaction_param3.Caption := 'slot1';
            lbcyaction_param4.Caption := 'Slot2';
            lbcyaction_param5.Caption := 'Slot3';
            lbcyaction_param6.Caption := '';
            lbcyaction_param1.Hint := 'Creature_equip_template.entry';
            edcyaction_param1.Hint := lbcyaction_param1.Hint;
            lbcyaction_type.Hint := 'only slots with mask set will be sent to client, bits are 1, 2, 4, leaving mask 0 is defaulted to mask 7 (send all), Slots1-3 are only used if no entry is set';
            edcyaction_type.Hint := lbcyaction_type.Hint;
        end;
    72:  //SMART_ACTION_CLOSE_GOSSIP
        begin
            lbcyaction_param1.Caption := '';
            lbcyaction_param2.Caption := '';
            lbcyaction_param3.Caption := '';
            lbcyaction_param4.Caption := '';
            lbcyaction_param5.Caption := '';
            lbcyaction_param6.Caption := '';
            lbcyaction_type.Hint := '';
            edcyaction_type.Hint := lbcyaction_type.Hint;
        end;
    73:  //SMART_ACTION_TRIGGER_TIMED_EVENT
        begin
            lbcyaction_param1.Caption := 'id(>1)';
            lbcyaction_param2.Caption := '';
            lbcyaction_param3.Caption := '';
            lbcyaction_param4.Caption := '';
            lbcyaction_param5.Caption := '';
            lbcyaction_param6.Caption := '';
            lbcyaction_type.Hint := '';
            edcyaction_type.Hint := lbcyaction_type.Hint;
        end;
    74:  //SMART_ACTION_REMOVE_TIMED_EVENT
        begin
            lbcyaction_param1.Caption := 'id(>1)';
            lbcyaction_param2.Caption := '';
            lbcyaction_param3.Caption := '';
            lbcyaction_param4.Caption := '';
            lbcyaction_param5.Caption := '';
            lbcyaction_param6.Caption := '';
            lbcyaction_type.Hint := '';
            edcyaction_type.Hint := lbcyaction_type.Hint;
        end;
    75:  //SMART_ACTION_ADD_AURA
        begin
            lbcyaction_param1.Caption := 'Spellid';
            lbcyaction_param2.Caption := 'targets';
            lbcyaction_param3.Caption := '';
            lbcyaction_param4.Caption := '';
            lbcyaction_param5.Caption := '';
            lbcyaction_param6.Caption := '';
            lbcyaction_type.Hint := '';
            edcyaction_type.Hint := lbcyaction_type.Hint;
        end;
    76:  //SMART_ACTION_OVERRIDE_SCRIPT_BASE_OBJECT
        begin
            lbcyaction_param1.Caption := '';
            lbcyaction_param2.Caption := '';
            lbcyaction_param3.Caption := '';
            lbcyaction_param4.Caption := '';
            lbcyaction_param5.Caption := '';
            lbcyaction_param6.Caption := '';
            lbcyaction_type.Hint := 'WARNING: CAN CRASH CORE, do not use if you dont know what you are doing';
            edcyaction_type.Hint := lbcyaction_type.Hint;
        end;
    77:  //SMART_ACTION_RESET_SCRIPT_BASE_OBJECT
        begin
            lbcyaction_param1.Caption := '';
            lbcyaction_param2.Caption := '';
            lbcyaction_param3.Caption := '';
            lbcyaction_param4.Caption := '';
            lbcyaction_param5.Caption := '';
            lbcyaction_param6.Caption := '';
            lbcyaction_type.Hint := '';
            edcyaction_type.Hint := lbcyaction_type.Hint;
        end;
    78:  //SMART_ACTION_CALL_SCRIPT_RESET
        begin
            lbcyaction_param1.Caption := '';
            lbcyaction_param2.Caption := '';
            lbcyaction_param3.Caption := '';
            lbcyaction_param4.Caption := '';
            lbcyaction_param5.Caption := '';
            lbcyaction_param6.Caption := '';
            lbcyaction_type.Hint := '';
            edcyaction_type.Hint := lbcyaction_type.Hint;
        end;
    79:  //SMART_ACTION_ENTER_VEHICLE
        begin
            lbcyaction_param1.Caption := 'SeatID';
            lbcyaction_param2.Caption := '';
            lbcyaction_param3.Caption := '';
            lbcyaction_param4.Caption := '';
            lbcyaction_param5.Caption := '';
            lbcyaction_param6.Caption := '';
            lbcyaction_type.Hint := '';
            edcyaction_type.Hint := lbcyaction_type.Hint;
        end;
    80:  //SMART_ACTION_CALL_TIMED_ACTIONLIST
        begin
            lbcyaction_param1.Caption := 'ID';
            lbcyaction_param2.Caption := 'Stop after combat (0/1)';
            lbcyaction_param3.Caption := 'timer update type';
            lbcyaction_param4.Caption := '';
            lbcyaction_param5.Caption := '';
            lbcyaction_param6.Caption := '';
            lbcyaction_param1.Hint := 'overwrites already running actionlist';
            edcyaction_param1.Hint := lbcyaction_param1.Hint;
            lbcyaction_param3.Hint := '0 = OOC; 1 = IC; 2 = ALWAYS';
            edcyaction_param3.Hint := lbcyaction_param3.Hint;
            lbcyaction_type.Hint := '';
            edcyaction_type.Hint := lbcyaction_type.Hint;
        end;
    81:  //SMART_ACTION_SET_NPC_FLAG
        begin
            lbcyaction_param1.Caption := 'Creature_template.npcflag';
            lbcyaction_param2.Caption := '';
            lbcyaction_param3.Caption := '';
            lbcyaction_param4.Caption := '';
            lbcyaction_param5.Caption := '';
            lbcyaction_param6.Caption := '';
            lbcyaction_type.Hint := '';
            edcyaction_type.Hint := lbcyaction_type.Hint;
        end;
    82:  //SMART_ACTION_ADD_NPC_FLAG
        begin
            lbcyaction_param1.Caption := 'Number to add to flag';
            lbcyaction_param2.Caption := '';
            lbcyaction_param3.Caption := '';
            lbcyaction_param4.Caption := '';
            lbcyaction_param5.Caption := '';
            lbcyaction_param6.Caption := '';
            lbcyaction_type.Hint := '';
            edcyaction_type.Hint := lbcyaction_type.Hint;
        end;
    83:  //SMART_ACTION_REMOVE_NPC_FLAG
        begin
            lbcyaction_param1.Caption := 'Number to remove from flag';
            lbcyaction_param2.Caption := '';
            lbcyaction_param3.Caption := '';
            lbcyaction_param4.Caption := '';
            lbcyaction_param5.Caption := '';
            lbcyaction_param6.Caption := '';
            lbcyaction_type.Hint := '';
            edcyaction_type.Hint := lbcyaction_type.Hint;
        end;
    84:  //SMART_ACTION_SIMPLE_TALK
        begin
            lbcyaction_param1.Caption := 'Creature_text.groupID';
            lbcyaction_param2.Caption := '';
            lbcyaction_param3.Caption := '';
            lbcyaction_param4.Caption := '';
            lbcyaction_param5.Caption := '';
            lbcyaction_param6.Caption := '';
            lbcyaction_type.Hint := 'can be used to make players say groupID, Text_over event is not triggered, whisper can not be used (Target units will say the text)';
            edcyaction_type.Hint := lbcyaction_type.Hint;
        end;
    85:  //SMART_ACTION_INVOKER_CAST
        begin
            lbcyaction_param1.Caption := 'SpellID';
            lbcyaction_param2.Caption := 'castFlags';
            lbcyaction_param3.Caption := '';
            lbcyaction_param4.Caption := '';
            lbcyaction_param5.Caption := '';
            lbcyaction_param6.Caption := '';
            lbcyaction_type.Hint := 'if avaliable, last used invoker will cast spellId with castFlags on targets';
            edcyaction_type.Hint := lbcyaction_type.Hint;
        end;
    86:  //SMART_ACTION_CROSS_CAST
        begin
            lbcyaction_param1.Caption := 'SpellID';
            lbcyaction_param2.Caption := 'castFlags';
            lbcyaction_param3.Caption := 'CasterTargetType';
            lbcyaction_param4.Caption := 'CasterTarget param1';
            lbcyaction_param5.Caption := 'CasterTarget param2';
            lbcyaction_param6.Caption := 'CasterTarget param3';
            lbcyaction_type.Hint := '( + the original target fields as Destination target), CasterTargets will cast spellID on all Targets (use with caution if targeting multiple * multiple units)';
            edcyaction_type.Hint := lbcyaction_type.Hint;
        end;
    87:  //SMART_ACTION_CALL_RANDOM_TIMED_ACTIONLIST
        begin
            lbcyaction_param1.Caption := 'Script9 ids 1-9';
            lbcyaction_param2.Caption := '';
            lbcyaction_param3.Caption := '';
            lbcyaction_param4.Caption := '';
            lbcyaction_param5.Caption := '';
            lbcyaction_param6.Caption := '';
            lbcyaction_type.Hint := '';
            edcyaction_type.Hint := lbcyaction_type.Hint;
        end;
    88:  //SMART_ACTION_CALL_RANDOM_RANGE_TIMED_ACTIONLIST
        begin
            lbcyaction_param1.Caption := 'Script9 entry of script1';
            lbcyaction_param2.Caption := 'entry of script2';
            lbcyaction_param3.Caption := '';
            lbcyaction_param4.Caption := '';
            lbcyaction_param5.Caption := '';
            lbcyaction_param6.Caption := '';
            lbcyaction_type.Hint := '';
            edcyaction_type.Hint := lbcyaction_type.Hint;
        end;
    89:  //SMART_ACTION_RANDOM_MOVE
        begin
            lbcyaction_param1.Caption := 'maxDist';
            lbcyaction_param2.Caption := '';
            lbcyaction_param3.Caption := '';
            lbcyaction_param4.Caption := '';
            lbcyaction_param5.Caption := '';
            lbcyaction_param6.Caption := '';
            lbcyaction_type.Hint := '';
            edcyaction_type.Hint := lbcyaction_type.Hint;
        end;
    90:  //SMART_ACTION_SET_UNIT_FIELD_BYTES_1
        begin
            lbcyaction_param1.Caption := 'Value';
            lbcyaction_param2.Caption := '';
            lbcyaction_param3.Caption := '';
            lbcyaction_param4.Caption := '';
            lbcyaction_param5.Caption := '';
            lbcyaction_param6.Caption := '';
            lbcyaction_type.Hint := '';
            edcyaction_type.Hint := lbcyaction_type.Hint;
        end;
    91:  //SMART_ACTION_REMOVE_UNIT_FIELD_BYTES_1
        begin
            lbcyaction_param1.Caption := 'Value';
            lbcyaction_param2.Caption := '';
            lbcyaction_param3.Caption := '';
            lbcyaction_param4.Caption := '';
            lbcyaction_param5.Caption := '';
            lbcyaction_param6.Caption := '';
            lbcyaction_type.Hint := '';
            edcyaction_type.Hint := lbcyaction_type.Hint;
        end;
    end;
    SAI_Action := t;
end;

procedure TMainForm.SetSAITarget(t: integer);
begin
    case t of
    0:  //SMART_TARGET_NONE
        begin
            lbcytarget_param1.Caption := '';
            lbcytarget_param2.Caption := '';
            lbcytarget_param3.Caption := '';
            lbcytarget_x.Caption := '';
            lbcytarget_y.Caption := '';
            lbcytarget_z.Caption := '';
            lbcytarget_o.Caption := '';
            lbcytarget_type.Hint := 'None, default to invoker';
            edcytarget_type.Hint := lbcytarget_type.Hint;
        end;
    1:  //SMART_TARGET_SELF
        begin
            lbcytarget_param1.Caption := '';
            lbcytarget_param2.Caption := '';
            lbcytarget_param3.Caption := '';
            lbcytarget_x.Caption := '';
            lbcytarget_y.Caption := '';
            lbcytarget_z.Caption := '';
            lbcytarget_o.Caption := '';
            lbcytarget_type.Hint := 'Self cast';
            edcytarget_type.Hint := lbcytarget_type.Hint;
        end;
    2:  //SMART_TARGET_VICTIM
        begin
            lbcytarget_param1.Caption := '';
            lbcytarget_param2.Caption := '';
            lbcytarget_param3.Caption := '';
            lbcytarget_x.Caption := '';
            lbcytarget_y.Caption := '';
            lbcytarget_z.Caption := '';
            lbcytarget_o.Caption := '';
            lbcytarget_type.Hint := 'Our current target (ie: highest aggro)';
            edcytarget_type.Hint := lbcytarget_type.Hint;
        end;
    3:  //SMART_TARGET_HOSTILE_SECOND_AGGRO
        begin
            lbcytarget_param1.Caption := '';
            lbcytarget_param2.Caption := '';
            lbcytarget_param3.Caption := '';
            lbcytarget_x.Caption := '';
            lbcytarget_y.Caption := '';
            lbcytarget_z.Caption := '';
            lbcytarget_o.Caption := '';
            lbcytarget_type.Hint := 'Second highest aggro';
            edcytarget_type.Hint := lbcytarget_type.Hint;
        end;
    4:  //SMART_TARGET_HOSTILE_LAST_AGGRO
        begin
            lbcytarget_param1.Caption := '';
            lbcytarget_param2.Caption := '';
            lbcytarget_param3.Caption := '';
            lbcytarget_x.Caption := '';
            lbcytarget_y.Caption := '';
            lbcytarget_z.Caption := '';
            lbcytarget_o.Caption := '';
            lbcytarget_type.Hint := 'Dead last on aggro';
            edcytarget_type.Hint := lbcytarget_type.Hint;
        end;
    5:  //SMART_TARGET_HOSTILE_RANDOM
        begin
            lbcytarget_param1.Caption := '';
            lbcytarget_param2.Caption := '';
            lbcytarget_param3.Caption := '';
            lbcytarget_x.Caption := '';
            lbcytarget_y.Caption := '';
            lbcytarget_z.Caption := '';
            lbcytarget_o.Caption := '';
            lbcytarget_type.Hint := 'Just any random target on our threat list';
            edcytarget_type.Hint := lbcytarget_type.Hint;
        end;
    6:  //SMART_TARGET_HOSTILE_RANDOM_NOT_TOP
        begin
            lbcytarget_param1.Caption := '';
            lbcytarget_param2.Caption := '';
            lbcytarget_param3.Caption := '';
            lbcytarget_x.Caption := '';
            lbcytarget_y.Caption := '';
            lbcytarget_z.Caption := '';
            lbcytarget_o.Caption := '';
            lbcytarget_type.Hint := 'Any random target except top threat';
            edcytarget_type.Hint := lbcytarget_type.Hint;
        end;
    7:  //SMART_TARGET_ACTION_INVOKER
        begin
            lbcytarget_param1.Caption := '';
            lbcytarget_param2.Caption := '';
            lbcytarget_param3.Caption := '';
            lbcytarget_x.Caption := '';
            lbcytarget_y.Caption := '';
            lbcytarget_z.Caption := '';
            lbcytarget_o.Caption := '';
            lbcytarget_type.Hint := 'Unit who caused this Event to occur';
            edcytarget_type.Hint := lbcytarget_type.Hint;
        end;
    8:  //SMART_TARGET_POSITION
        begin
            lbcytarget_param1.Caption := '';
            lbcytarget_param2.Caption := '';
            lbcytarget_param3.Caption := '';
            lbcytarget_x.Caption := 'x';
            lbcytarget_y.Caption := 'y';
            lbcytarget_z.Caption := 'z';
            lbcytarget_o.Caption := 'o';
            lbcytarget_type.Hint := 'Use xyz from event params';
            edcytarget_type.Hint := lbcytarget_type.Hint;
        end;
    9:  //SMART_TARGET_CREATURE_RANGE
        begin
            lbcytarget_param1.Caption := 'creatureEntry (0 any)';
            lbcytarget_param2.Caption := 'minDist';
            lbcytarget_param3.Caption := 'maxDist';
            lbcytarget_x.Caption := '';
            lbcytarget_y.Caption := '';
            lbcytarget_z.Caption := '';
            lbcytarget_o.Caption := '';
            lbcytarget_type.Hint := '';
            edcytarget_type.Hint := lbcytarget_type.Hint;
        end;
    10:  //SMART_TARGET_CREATURE_GUID
        begin
            lbcytarget_param1.Caption := 'guid';
            lbcytarget_param2.Caption := 'entry';
            lbcytarget_param3.Caption := '';
            lbcytarget_x.Caption := '';
            lbcytarget_y.Caption := '';
            lbcytarget_z.Caption := '';
            lbcytarget_o.Caption := '';
            lbcytarget_type.Hint := '';
            edcytarget_type.Hint := lbcytarget_type.Hint;
        end;
    11:  //SMART_TARGET_CREATURE_DISTANCE
        begin
            lbcytarget_param1.Caption := 'creatureEntry (0 any)';
            lbcytarget_param2.Caption := 'maxDist';
            lbcytarget_param3.Caption := '';
            lbcytarget_x.Caption := '';
            lbcytarget_y.Caption := '';
            lbcytarget_z.Caption := '';
            lbcytarget_o.Caption := '';
            lbcytarget_type.Hint := '';
            edcytarget_type.Hint := lbcytarget_type.Hint;
        end;
    12:  //SMART_TARGET_STORED
        begin
            lbcytarget_param1.Caption := 'id';
            lbcytarget_param2.Caption := '';
            lbcytarget_param3.Caption := '';
            lbcytarget_x.Caption := '';
            lbcytarget_y.Caption := '';
            lbcytarget_z.Caption := '';
            lbcytarget_o.Caption := '';
            lbcytarget_type.Hint := 'Uses pre-stored target(list)';
            edcytarget_type.Hint := lbcytarget_type.Hint;
        end;
    13:  //SMART_TARGET_GAMEOBJECT_RANGE
        begin
            lbcytarget_param1.Caption := 'goEntry (0 any)';
            lbcytarget_param2.Caption := 'minDist';
            lbcytarget_param3.Caption := 'maxDist';
            lbcytarget_x.Caption := '';
            lbcytarget_y.Caption := '';
            lbcytarget_z.Caption := '';
            lbcytarget_o.Caption := '';
            lbcytarget_type.Hint := '';
            edcytarget_type.Hint := lbcytarget_type.Hint;
        end;
    14:  //SMART_TARGET_GAMEOBJECT_GUID
        begin
            lbcytarget_param1.Caption := 'guid';
            lbcytarget_param2.Caption := 'entry';
            lbcytarget_param3.Caption := '';
            lbcytarget_x.Caption := '';
            lbcytarget_y.Caption := '';
            lbcytarget_z.Caption := '';
            lbcytarget_o.Caption := '';
            lbcytarget_type.Hint := '';
            edcytarget_type.Hint := lbcytarget_type.Hint;
        end;
    15:  //SMART_TARGET_GAMEOBJECT_DISTANCE
        begin
            lbcytarget_param1.Caption := 'goEntry (0 any)';
            lbcytarget_param2.Caption := 'maxDist';
            lbcytarget_param3.Caption := '';
            lbcytarget_x.Caption := '';
            lbcytarget_y.Caption := '';
            lbcytarget_z.Caption := '';
            lbcytarget_o.Caption := '';
            lbcytarget_type.Hint := '';
            edcytarget_type.Hint := lbcytarget_type.Hint;
        end;
    16:  //SMART_TARGET_INVOKER_PARTY
        begin
            lbcytarget_param1.Caption := '';
            lbcytarget_param2.Caption := '';
            lbcytarget_param3.Caption := '';
            lbcytarget_x.Caption := '';
            lbcytarget_y.Caption := '';
            lbcytarget_z.Caption := '';
            lbcytarget_o.Caption := '';
            lbcytarget_type.Hint := 'Invoker''s party members';
            edcytarget_type.Hint := lbcytarget_type.Hint;
        end;
    17:  //SMART_TARGET_PLAYER_RANGE
        begin
            lbcytarget_param1.Caption := 'minDist';
            lbcytarget_param2.Caption := 'maxDist';
            lbcytarget_param3.Caption := '';
            lbcytarget_x.Caption := '';
            lbcytarget_y.Caption := '';
            lbcytarget_z.Caption := '';
            lbcytarget_o.Caption := '';
            lbcytarget_type.Hint := '';
            edcytarget_type.Hint := lbcytarget_type.Hint;
        end;
    18:  //SMART_TARGET_PLAYER_DISTANCE
        begin
            lbcytarget_param1.Caption := 'maxDist';
            lbcytarget_param2.Caption := '';
            lbcytarget_param3.Caption := '';
            lbcytarget_x.Caption := '';
            lbcytarget_y.Caption := '';
            lbcytarget_z.Caption := '';
            lbcytarget_o.Caption := '';
            lbcytarget_type.Hint := '';
            edcytarget_type.Hint := lbcytarget_type.Hint;
        end;
    19:  //SMART_TARGET_CLOSEST_CREATURE
        begin
            lbcytarget_param1.Caption := 'creatureEntry (0 any)';
            lbcytarget_param2.Caption := '';
            lbcytarget_param3.Caption := '';
            lbcytarget_x.Caption := '';
            lbcytarget_y.Caption := '';
            lbcytarget_z.Caption := '';
            lbcytarget_o.Caption := '';
            lbcytarget_type.Hint := '';
            edcytarget_type.Hint := lbcytarget_type.Hint;
        end;
    20:  //SMART_TARGET_CLOSEST_GAMEOBJECT
        begin
            lbcytarget_param1.Caption := 'goEntry (0 any)';
            lbcytarget_param2.Caption := '';
            lbcytarget_param3.Caption := '';
            lbcytarget_x.Caption := '';
            lbcytarget_y.Caption := '';
            lbcytarget_z.Caption := '';
            lbcytarget_o.Caption := '';
            lbcytarget_type.Hint := '';
            edcytarget_type.Hint := lbcytarget_type.Hint;
        end;
    21:  //SMART_TARGET_CLOSEST_PLAYER
        begin
            lbcytarget_param1.Caption := '';
            lbcytarget_param2.Caption := '';
            lbcytarget_param3.Caption := '';
            lbcytarget_x.Caption := '';
            lbcytarget_y.Caption := '';
            lbcytarget_z.Caption := '';
            lbcytarget_o.Caption := '';
            lbcytarget_type.Hint := '';
            edcytarget_type.Hint := lbcytarget_type.Hint;
        end;
    22:  //SMART_TARGET_ACTION_INVOKER_VEHICLE
        begin
            lbcytarget_param1.Caption := '';
            lbcytarget_param2.Caption := '';
            lbcytarget_param3.Caption := '';
            lbcytarget_x.Caption := '';
            lbcytarget_y.Caption := '';
            lbcytarget_z.Caption := '';
            lbcytarget_o.Caption := '';
            lbcytarget_type.Hint := 'Unit''s vehicle who caused this Event to occur';
            edcytarget_type.Hint := lbcytarget_type.Hint;
        end;
    23:  //SMART_TARGET_OWNER_OR_SUMMONER
        begin
            lbcytarget_param1.Caption := '';
            lbcytarget_param2.Caption := '';
            lbcytarget_param3.Caption := '';
            lbcytarget_x.Caption := '';
            lbcytarget_y.Caption := '';
            lbcytarget_z.Caption := '';
            lbcytarget_o.Caption := '';
            lbcytarget_type.Hint := 'Unit''s owner or summoner';
            edcytarget_type.Hint := lbcytarget_type.Hint;
        end;
    24:  //SMART_TARGET_THREAT_LIST
        begin
            lbcytarget_param1.Caption := '';
            lbcytarget_param2.Caption := '';
            lbcytarget_param3.Caption := '';
            lbcytarget_x.Caption := '';
            lbcytarget_y.Caption := '';
            lbcytarget_z.Caption := '';
            lbcytarget_o.Caption := '';
            lbcytarget_type.Hint := 'All units on creature''s threat list';
            edcytarget_type.Hint := lbcytarget_type.Hint;
        end;
    end;
    SAI_Target := t;
end;

procedure TMainForm.btFullScriptProsLootClick(Sender: TObject);
begin
  PageControl5.ActivePageIndex := SCRIPT_TAB_NO_ITEM;
  ShowFullLootScript('prospecting_loot_template', lvitProsLoot, meitScript, editentry.Text);
end;

procedure TMainForm.btProsLootAddClick(Sender: TObject);
begin
  LootAdd('edip', lvitProsLoot);
end;

procedure TMainForm.btProsLootUpdClick(Sender: TObject);
begin
  LootUpd('edip', lvitProsLoot);
end;

procedure TMainForm.btProsLootDelClick(Sender: TObject);
begin
  LootDel(lvitProsLoot);
end;

procedure TMainForm.lvitProsLootChange(Sender: TObject; Item: TListItem;
  Change: TItemChange);
begin
  btProsLootUpd.Enabled := Assigned(TJvListView(Sender).Selected);
  btProsLootDel.Enabled := Assigned(TJvListView(Sender).Selected);
end;

procedure TMainForm.lvitProsLootSelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
begin
  if Selected then
    SetLootEditFields('edip', lvitProsLoot);
end;

procedure TMainForm.lvitReferenceLootChange(Sender: TObject; Item: TListItem;
  Change: TItemChange);
begin
btReferenceLootUpd.Enabled := Assigned(TJvListView(Sender).Selected);
btReferenceLootDel.Enabled := Assigned(TJvListView(Sender).Selected);
end;

procedure TMainForm.lvitReferenceLootSelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
begin
   if Selected then
    SetLootEditFields('edir', lvitReferenceLoot);
end;

procedure TMainForm.lvQuickListClick(Sender: TObject);
begin
  edit.Text := lvQuickList.Selected.Caption;
  PostMessage(MainForm.Handle, WM_FREEQL, 0, 0);
end;

procedure TMainForm.lvQuickListKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if key = vk_escape then
    PostMessage(MainForm.Handle, WM_FREEQL, 0, 0);
end;

procedure TMainForm.lvQuickListMouseLeave(Sender: TObject);
begin
  edit.SetFocus;
  PostMessage(MainForm.Handle, WM_FREEQL, 0, 0);
end;

procedure TMainForm.lvQuickListMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  lvQuickList.Selected := TTntListItem(lvQuickList.GetItemAt(x,y));
end;

procedure TMainForm.LoadQuestCompleteScript(id: integer);
begin
  LoadQueryToListView(Format('SELECT * FROM `quest_end_scripts` WHERE (`id`=%d)', [id]), lvqtEndScript);
end;

procedure TMainForm.LoadQuestStartScript(id: integer);
begin
  LoadQueryToListView(Format('SELECT * FROM `quest_start_scripts` WHERE (`id`=%d)', [id]), lvqtStartScript);
end;

procedure TMainForm.lvqtStartScriptChange(Sender: TObject; Item: TListItem;
  Change: TItemChange);
begin
  btssUpd.Enabled := Assigned(TJvListView(Sender).Selected);
  btssDel.Enabled := Assigned(TJvListView(Sender).Selected);
end;

procedure TMainForm.lvqtEndScriptChange(Sender: TObject; Item: TListItem;
  Change: TItemChange);
begin
  btesUpd.Enabled := Assigned(TJvListView(Sender).Selected);
  btesDel.Enabled := Assigned(TJvListView(Sender).Selected);
end;

procedure TMainForm.lvqtStartScriptSelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
begin
  if Selected then
    SetScriptEditFields('edss', lvqtStartScript);
end;

procedure TMainForm.lvqtTakerTemplateChange(Sender: TObject; Item: TListItem; Change: TItemChange);
begin
  btDelQuestTaker.Enabled := Assigned(lvqtTakerTemplate.Selected);
end;

procedure TMainForm.lvqtTakerTemplateDblClick(Sender: TObject);
begin
  if Assigned( lvqtTakerTemplate.Selected ) then
    EditThis(lvqtTakerTemplate.Selected.Caption, lvqtTakerTemplate.Selected.SubItems[0]);
end;

procedure TMainForm.lvqtTakerTemplateSelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
begin
  if Selected then
    LoadQuestTakerInfo(Item.Caption, Item.SubItems[0]);
end;

procedure TMainForm.lvqtEndScriptSelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
begin
  if Selected then
    SetScriptEditFields('edes', lvqtEndScript);
end;

procedure TMainForm.lvqtGiverTemplateChange(Sender: TObject; Item: TListItem; Change: TItemChange);
begin
  btDelQuestGiver.Enabled := Assigned(lvqtGiverTemplate.Selected);
end;

procedure TMainForm.lvqtGiverTemplateDblClick(Sender: TObject);
begin
  if Assigned( lvqtGiverTemplate.Selected ) then
    EditThis(lvqtGiverTemplate.Selected.Caption, lvqtGiverTemplate.Selected.SubItems[0]);
end;

procedure TMainForm.lvqtGiverTemplateSelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
begin
  if Selected then
    LoadQuestGiverInfo(Item.Caption, Item.SubItems[0]);
end;

procedure TMainForm.SetScriptEditFields(pfx: string;
  lvList: TJvListView);
begin
  if Assigned(lvList.Selected) then
  begin
    with lvList.Selected do
    begin
      TCustomEdit(FindComponent(pfx + 'id')).Text := Caption;
      TCustomEdit(FindComponent(pfx + 'delay')).Text := SubItems[0];
      TCustomEdit(FindComponent(pfx + 'command')).Text := SubItems[1];
      TCustomEdit(FindComponent(pfx + 'datalong')).Text := SubItems[2];
      TCustomEdit(FindComponent(pfx + 'datalong2')).Text := SubItems[3];
      TCustomEdit(FindComponent(pfx + 'dataint')).Text := SubItems[4];
      TCustomEdit(FindComponent(pfx + 'x')).Text := SubItems[5];
      TCustomEdit(FindComponent(pfx + 'y')).Text := SubItems[6];
      TCustomEdit(FindComponent(pfx + 'z')).Text := SubItems[7];
      TCustomEdit(FindComponent(pfx + 'o')).Text := SubItems[8];
    end;
  end;
end;

procedure TMainForm.ScriptAdd(pfx: string; lvList: TJvListView);
begin
  with lvList.Items.Add do
  begin
    Caption := TCustomEdit(FindComponent(pfx + 'id')).Text;
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'delay')).Text);
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'command')).Text);
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'datalong')).Text);
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'datalong2')).Text);
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'dataint')).Text);
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'x')).Text);
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'y')).Text);
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'z')).Text);
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'o')).Text);
  end;
end;

procedure TMainForm.ScriptUpd(pfx: string; lvList: TJvListView);
begin
  if Assigned(lvList.Selected) then
  begin
    with lvList.Selected do
    begin
      Caption := TCustomEdit(FindComponent(pfx + 'id')).Text;
      SubItems[0] := TCustomEdit(FindComponent(pfx + 'delay')).Text;
      SubItems[1] := TCustomEdit(FindComponent(pfx + 'command')).Text;
      SubItems[2] := TCustomEdit(FindComponent(pfx + 'datalong')).Text;
      SubItems[3] := TCustomEdit(FindComponent(pfx + 'datalong2')).Text;
      SubItems[4] := TCustomEdit(FindComponent(pfx + 'dataint')).Text;
      SubItems[5] := TCustomEdit(FindComponent(pfx + 'x')).Text;
      SubItems[6] := TCustomEdit(FindComponent(pfx + 'y')).Text;
      SubItems[7] := TCustomEdit(FindComponent(pfx + 'z')).Text;
      SubItems[8] := TCustomEdit(FindComponent(pfx + 'o')).Text;
    end;
  end;
end;

procedure TMainForm.ScriptDel(lvList: TJvListView);
begin
  if Assigned(lvList.Selected) then
    lvList.DeleteSelected;
end;           


procedure TMainForm.btssAddClick(Sender: TObject);
begin
  ScriptAdd('edss', lvqtStartScript);
end;

procedure TMainForm.btssUpdClick(Sender: TObject);
begin
  ScriptUpd('edss', lvqtStartScript);
end;

procedure TMainForm.btssDelClick(Sender: TObject);
begin
  ScriptDel(lvqtStartScript);
end;

procedure TMainForm.btesAddClick(Sender: TObject);
begin
  ScriptAdd('edes', lvqtEndScript);
end;

procedure TMainForm.btesUpdClick(Sender: TObject);
begin
  ScriptUpd('edes', lvqtEndScript);
end;

procedure TMainForm.btesDelClick(Sender: TObject);
begin
  ScriptDel(lvqtEndScript);
end;

procedure TMainForm.GetCommand(Sender: TObject);
begin
  GetValueFromSimpleList(Sender, 135, 'ScriptCommand', false);
end;

procedure TMainForm.edsscommandChange(Sender: TObject);
begin
  ChangeScriptCommand(StrToIntDef(TJvComboEdit(Sender).Text, 0), 'ss');
end;

procedure TMainForm.edescommandChange(Sender: TObject);
begin
  ChangeScriptCommand(StrToIntDef(TJvComboEdit(Sender).Text, 0), 'es');
end;

procedure TMainForm.ChangeScriptCommand(command: integer; pfx: string);
begin
  case command of
    0:
    begin
      TJvComboEdit(FindComponent('ed'+pfx+'datalong')).Hint  := 'always 0';
      TJvComboEdit(FindComponent('ed'+pfx+'datalong2')).Hint := 'always 0';
      TJvComboEdit(FindComponent('ed'+pfx+'dataint')).Hint  := 'text to say';
      TJvComboEdit(FindComponent('ed'+pfx+'x')).Hint  :=        'always 0';
      TJvComboEdit(FindComponent('ed'+pfx+'y')).Hint  :=        'always 0';
      TJvComboEdit(FindComponent('ed'+pfx+'z')).Hint  :=        'always 0';
      TJvComboEdit(FindComponent('ed'+pfx+'o')).Hint  :=        'always 0';
    end;
    1:
    begin
      TJvComboEdit(FindComponent('ed'+pfx+'datalong')).Hint  := 'emote id from dbc';
      TJvComboEdit(FindComponent('ed'+pfx+'datalong2')).Hint := 'always 0';
      TJvComboEdit(FindComponent('ed'+pfx+'dataint')).Hint  := 'always empty';
      TJvComboEdit(FindComponent('ed'+pfx+'x')).Hint  :=        'always 0';
      TJvComboEdit(FindComponent('ed'+pfx+'y')).Hint  :=        'always 0';
      TJvComboEdit(FindComponent('ed'+pfx+'z')).Hint  :=        'always 0';
      TJvComboEdit(FindComponent('ed'+pfx+'o')).Hint  :=        'always 0';
    end;
    2:
    begin
      TJvComboEdit(FindComponent('ed'+pfx+'datalong')).Hint  := 'field index';
      TJvComboEdit(FindComponent('ed'+pfx+'datalong2')).Hint := 'value to set';
      TJvComboEdit(FindComponent('ed'+pfx+'dataint')).Hint  := 'always empty';
      TJvComboEdit(FindComponent('ed'+pfx+'x')).Hint  :=        'always 0';
      TJvComboEdit(FindComponent('ed'+pfx+'y')).Hint  :=        'always 0';
      TJvComboEdit(FindComponent('ed'+pfx+'z')).Hint  :=        'always 0';
      TJvComboEdit(FindComponent('ed'+pfx+'o')).Hint  :=        'always 0';
    end;
    3:
    begin
      TJvComboEdit(FindComponent('ed'+pfx+'datalong')).Hint  := 'always 0';
      TJvComboEdit(FindComponent('ed'+pfx+'datalong2')).Hint := 'transitTime';
      TJvComboEdit(FindComponent('ed'+pfx+'dataint')).Hint  := 'always empty';
      TJvComboEdit(FindComponent('ed'+pfx+'x')).Hint  :=        'destination coord x';
      TJvComboEdit(FindComponent('ed'+pfx+'y')).Hint  :=        'destination coord y';
      TJvComboEdit(FindComponent('ed'+pfx+'z')).Hint  :=        'destination coord z';
      TJvComboEdit(FindComponent('ed'+pfx+'o')).Hint  :=        'orientation';
    end;
    4:
    begin
      TJvComboEdit(FindComponent('ed'+pfx+'datalong')).Hint  := 'field index';
      TJvComboEdit(FindComponent('ed'+pfx+'datalong2')).Hint := 'flag to set';
      TJvComboEdit(FindComponent('ed'+pfx+'dataint')).Hint  := 'always empty';
      TJvComboEdit(FindComponent('ed'+pfx+'x')).Hint  :=        'always 0';
      TJvComboEdit(FindComponent('ed'+pfx+'y')).Hint  :=        'always 0';
      TJvComboEdit(FindComponent('ed'+pfx+'z')).Hint  :=        'always 0';
      TJvComboEdit(FindComponent('ed'+pfx+'o')).Hint  :=        'always 0';
    end;
    5:
    begin
      TJvComboEdit(FindComponent('ed'+pfx+'datalong')).Hint  := 'field index';
      TJvComboEdit(FindComponent('ed'+pfx+'datalong2')).Hint := 'flag to remove';
      TJvComboEdit(FindComponent('ed'+pfx+'dataint')).Hint  := 'always empty';
      TJvComboEdit(FindComponent('ed'+pfx+'x')).Hint  :=        'always 0';
      TJvComboEdit(FindComponent('ed'+pfx+'y')).Hint  :=        'always 0';
      TJvComboEdit(FindComponent('ed'+pfx+'z')).Hint  :=        'always 0';
      TJvComboEdit(FindComponent('ed'+pfx+'o')).Hint  :=        'always 0';
    end;
    6:
    begin
      TJvComboEdit(FindComponent('ed'+pfx+'datalong')).Hint  := 'map id';
      TJvComboEdit(FindComponent('ed'+pfx+'datalong2')).Hint := 'always 0';
      TJvComboEdit(FindComponent('ed'+pfx+'dataint')).Hint  := 'always empty';
      TJvComboEdit(FindComponent('ed'+pfx+'x')).Hint  :=        'destination coord x';
      TJvComboEdit(FindComponent('ed'+pfx+'y')).Hint  :=        'destination coord y';
      TJvComboEdit(FindComponent('ed'+pfx+'z')).Hint  :=        'destination coord z';
      TJvComboEdit(FindComponent('ed'+pfx+'o')).Hint  :=        'orientation';
    end;
    10:
    begin
      TJvComboEdit(FindComponent('ed'+pfx+'datalong')).Hint  := 'creature id to summon';
      TJvComboEdit(FindComponent('ed'+pfx+'datalong2')).Hint := 'lifetime of creature (in ms)';
      TJvComboEdit(FindComponent('ed'+pfx+'dataint')).Hint  := 'always empty';
      TJvComboEdit(FindComponent('ed'+pfx+'x')).Hint  :=        'coord x';
      TJvComboEdit(FindComponent('ed'+pfx+'y')).Hint  :=        'coord y';
      TJvComboEdit(FindComponent('ed'+pfx+'z')).Hint  :=        'coord z';
      TJvComboEdit(FindComponent('ed'+pfx+'o')).Hint  :=        'orientation';
    end;
  end;
end;

procedure TMainForm.CheckforUpdates1Click(Sender: TObject);
begin
  CheckForUpdates(true);
end;

procedure TMainForm.lvitEnchantmentChange(Sender: TObject; Item: TListItem;
  Change: TItemChange);
begin
  btieEnchUpd.Enabled := Assigned(TJvListView(Sender).Selected);
  btieEnchDel.Enabled := Assigned(TJvListView(Sender).Selected);
end;

procedure TMainForm.lvitEnchantmentSelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
begin
  if Selected then
    SetEnchEditFields('edie', lvitEnchantment);
end;

procedure TMainForm.btieEnchAddClick(Sender: TObject);
begin
  EnchAdd('edie', lvitEnchantment);
end;

procedure TMainForm.btieEnchUpdClick(Sender: TObject);
begin
  EnchUpd('edie', lvitEnchantment);
end;

procedure TMainForm.btieEnchDelClick(Sender: TObject);
begin
  EnchDel(lvitEnchantment);
end;

procedure TMainForm.btieShowFullScriptClick(Sender: TObject);
var
  id: string;
begin
  PageControl5.ActivePageIndex := SCRIPT_TAB_NO_ITEM;

  if editRandomProperty.Text<>'0' then id := editRandomProperty.Text else
    id := editRandomSuffix.Text;
  ShowFullEnchScript('item_enchantment_template', lvitEnchantment, meitScript, id);
end;

procedure TMainForm.EnchAdd(pfx: string; lvList: TJvListView);
begin
  with lvList.Items.Add do
  begin
    Caption := TCustomEdit(FindComponent(pfx + 'entry')).Text;
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'ench')).Text);
    SubItems.Add(TCustomEdit(FindComponent(pfx + 'chance')).Text);
  end;
end;

procedure TMainForm.EnchUpd(pfx: string; lvList: TJvListView);
begin
  if Assigned(lvList.Selected) then
  begin
    with lvList.Selected do
    begin
      Caption := TCustomEdit(FindComponent(pfx + 'entry')).Text;
      SubItems[0] := TCustomEdit(FindComponent(pfx + 'ench')).Text;
      SubItems[1] := TCustomEdit(FindComponent(pfx + 'chance')).Text;
    end;
  end;
end;

procedure TMainForm.EraseBackground(var Message: TWMEraseBkgnd);
begin
   Message.Result := 1;
end;

procedure TMainForm.ExecuteScript(script: string; memo: TMemo);
var
  Log: TStringList;
  FN: string;
begin
  ShowHourGlassCursor;
  ZSQLProcessor.Script.Text := script;
  try
    ZSQLProcessor.Connection.StartTransaction;
    ZSQLProcessor.Execute;
    ZSQLProcessor.Connection.Commit;
  except
    on E:Exception do
    begin
      ZSQLProcessor.Connection.Rollback;
      memo.Text := E.Message;
      Exit;
    end;
  end;
  memo.Text := dmMain.Text[10]; //'Script executed successfully.'
  Log := TStringList.Create;
  try
    FN := Format('%sTruiceLog_%s_%s_%s.sql',[dmMain.ProgramDir, VERSION_1, VERSION_2, VERSION_3]);
    if FileExists(FN) then Log.LoadFromFile(FN);
    Log.Add('-- '+DateTimeToStr(Now));
    Log.Add(script);
    Log.SaveToFile(FN);
  finally
    Log.Free;
  end;
end;

procedure TMainForm.EnchDel(lvList: TJvListView);
begin
  LootDel(lvList);
end;

procedure TMainForm.SetEnchEditFields(pfx: string;
  lvList: TJvListView);
begin
  if Assigned(lvList.Selected) then
  begin
    with lvList.Selected do
    begin
      TCustomEdit(FindComponent(pfx + 'entry')).Text := Caption;
      TCustomEdit(FindComponent(pfx + 'ench')).Text := SubItems[0];
      TCustomEdit(FindComponent(pfx + 'chance')).Text := SubItems[1];
    end;
  end;
end;

procedure TMainForm.SetFieldsAndValues(var Fields, Values: string; TableName, pfx: string;
  Log: TMemo);
begin
  SetFieldsAndValues(MyQuery, Fields, Values, TableName, pfx, Log);
end;

procedure TMainForm.ShowFullEnchScript(TableName: string; lvList: TJvListView;
  Memo: TMemo; entry: string);
var
  i: integer;
  Values: string;
begin
  Memo.Clear;
  Values := '';
  if lvList.Items.Count<>0 then
  begin
    for i := 0 to lvList.Items.Count - 2 do
    begin
      Values := Values + Format('(%s, %s, %s),'#13#10,[
        lvList.Items[i].Caption,
        lvList.Items[i].SubItems[0],
        lvList.Items[i].SubItems[1]
      ]);
    end;
    i := lvList.Items.Count - 1;
    Values := Values + Format('(%s, %s, %s);',[
      lvList.Items[i].Caption,
      lvList.Items[i].SubItems[0],
      lvList.Items[i].SubItems[1]
    ]);
  end;
  if values<>'' then
  begin
    Memo.Text := Format('DELETE FROM `%0:s` WHERE (`entry`=%1:s);'#13#10+
     'INSERT INTO `%0:s` (entry, ench, chance) VALUES '#13#10'%2:s',[TableName, entry, Values]);
  end
  else
    Memo.Text := Format('DELETE FROM `%s` WHERE (`entry`=%s);', [TableName, entry]);
end;

procedure TMainForm.CompleteItemEnchScript;
var
  entry, ench, Fields, Values: string;
begin
  meitLog.Clear;
  entry := edieentry.Text;
  ench := edieench.Text;
  if (entry='') or (ench='') then Exit;
  SetFieldsAndValues(Fields, Values, 'item_enchantment_template', PFX_ITEM_ENCHANTMENT_TEMPLATE, meitLog);
  meitScript.Text := Format('DELETE FROM `item_enchantment_template` WHERE (`entry`=%s) AND (`ench`=%s);'#13#10+
      'INSERT INTO `item_enchantment_template` (%s) VALUES (%s);'#13#10,[entry, ench, Fields, Values]);
end;

// Characters

procedure TMainForm.btCharSearchClick(Sender: TObject);
begin
  SearchChar();
  with lvSearchChar do
    if Items.Count>0 then
    begin
      SetFocus;
      Selected := Items[0];
    end;
    StatusBarChar.Panels[0].Text := Format(dmMain.Text[136], [lvSearchChar.Items.Count]);
end;

procedure TMainForm.SearchChar();
var
  i: integer;
  guid, name, account, QueryStr, WhereStr, t: string;
  Field: TField;
begin

  account := edCharAccount.Text;
  guid := edCharGuid.Text;
  name := edCharName.Text;
  name := StringReplace(name, '''', '\''', [rfReplaceAll]);
  name := StringReplace(name, ' ', '%', [rfReplaceAll]);
  name := '%'+name+'%';
  QueryStr := '';
  WhereStr := '';
  if guid<>'' then
  begin
    if pos('-', guid)=0 then
      WhereStr := Format('WHERE (`guid` in (%s))',[guid])
    else
      WhereStr := Format('WHERE (`guid` >= %s) AND (`guid` <= %s)',[MidStr(guid,1,pos('-',guid)-1), MidStr(guid,pos('-',guid)+1,length(guid))]);
  end;

  if account<>'' then
  begin
    if pos('-', account)=0 then
      WhereStr := Format('WHERE (`account` in (%s))',[account])
    else
      WhereStr := Format('WHERE (`account` >= %s) AND (`account` <= %s)',[MidStr(account,1,pos('-',account)-1), MidStr(account,pos('-',account)+1,length(account))]);
  end;

  if name<>'%%' then
  begin
    if WhereStr<> '' then
      WhereStr := Format('%s AND (`name` LIKE ''%s'')',[WhereStr, name])
    else
      WhereStr := Format('WHERE (`name` LIKE ''%s'')',[name]);
  end;

  if Trim(WhereStr)='' then
    if MessageDlg(dmMain.Text[134], mtConfirmation, mbYesNoCancel, -1)<>mrYes then Exit;

  QueryStr := Format('SELECT * FROM `'+CharDBName+'`.`characters` %s',[WhereStr]);

  MyQuery.SQL.Text := QueryStr;
  lvSearchChar.Items.BeginUpdate;
  try
    MyQuery.Open;
    lvSearchChar.Clear;
    while not MyQuery.Eof do
    begin
      with lvSearchChar.Items.Add do
      begin
        for i := 0 to lvSearchChar.Columns.Count - 1 do
        begin
          Field := MyQuery.FindField(lvSearchChar.Columns[i].Caption);
          t := '';
          if Assigned(Field) then
          begin
            t := Field.AsString;
            if i=0 then Caption := t;
          end;

//          if Field.FieldName = 'race' then
//            t := GetRaceAcronym(strtointdef(t,0))
//          else if Field.FieldName = 'class' then
//           t := GetClassAcronym(strtointdef(t,0));

          if i<>0 then SubItems.Add(t);
        end;
        MyQuery.Next;
      end;
    end;
  finally
    lvSearchChar.Items.EndUpdate;
    MyQuery.Close;
  end;
end;    

procedure TMainForm.btCharClearClick(Sender: TObject);
begin
  edCharGuid.Clear;
  edCharName.Clear;
  edCharAccount.Clear;
  lvSearchChar.Clear;
end;

procedure TMainForm.btCharInvAddClick(Sender: TObject);
begin
  with lvCharacterInventory.Items.Add do
  begin
    Caption := edhiguid.Text;
    SubItems.Add(edhibag.Text);
    SubItems.Add(edhislot.Text);
    SubItems.Add(edhiitem.Text);
  end;
end;

procedure TMainForm.btCharInvDelClick(Sender: TObject);
begin
  if Assigned(lvCharacterInventory.Selected) then
    lvCharacterInventory.DeleteSelected;
end;

procedure TMainForm.btCharInvUpdClick(Sender: TObject);
begin
  if Assigned(lvCharacterInventory.Selected) then
  begin
    with lvCharacterInventory.Selected do
    begin
      Caption := edhiguid.Text;
      SubItems[0] := edhibag.Text;
      SubItems[1] := edhislot.Text;
      SubItems[2] := edhiitem.Text;
    end;
  end;
end;

procedure TMainForm.CheckForUpdates(flag: boolean);
begin
  {$IFDEF CRAKER}
   Exit;
  {$ENDIF}
  if IsFirst then
  begin
    if flag then ShowMessage('Check For Updates currently in process!');
    Exit;
   end;
  GlobalFlag := flag;
  SetCursor(LoadCursor(0, IDC_WAIT));

  if Trim(dmMain.ProxyServer)<>'' then
  begin
   JvHttpUrlGrabber.ProxyAddresses := Format('http=http://%s',[dmMain.ProxyServer]);
   if Trim(dmMain.ProxyPort)<>'' then
   JvHttpUrlGrabber.ProxyAddresses := Format('%s:%s',[JvHttpUrlGrabber.ProxyAddresses,dmMain.ProxyPort]);
   end;
   JvHttpUrlGrabber.ProxyUserName := dmMain.ProxyUser;
   JvHttpUrlGrabber.ProxyPassword := dmMain.ProxyPass;
   JvHttpUrlGrabber.URL := 'http://truice.googlecode.com/hg/version.txt';
   try
    IsFirst := true;
    JvHttpUrlGrabber.Start;
   except
    IsFirst := false;
  end;
end;

end.
