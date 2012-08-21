unit DBCfile;

interface

uses Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs;

type
  PCardinal = array of Cardinal;
  PInteger = array of Integer;
  PArray = array of Char;

  PDBCFile = ^TDBCFile;
  TDBCFile = class
  public
    recordSize:   Cardinal;
    recordCount:  Cardinal;
    fieldCount:   Cardinal;
    stringSize:   Cardinal;
    fieldsOffset: PCardinal;
    data:         PChar;
    stringTable:  PChar;
    offset:       PChar;
    IsLocalized:  boolean;

    constructor Create;
    destructor Destroy; override;
    function Load(filename: WideString): boolean;

    procedure setRecord(id: Cardinal);

    function GetNumRows(): Cardinal;
    function GetCols(): Cardinal;
    function GetOffset(id: Cardinal): Cardinal;
    function IsLoaded(): boolean;

    function getFloat(field: Cardinal): Single;
    function getUInt(field: Cardinal): Cardinal;
    function getUInt8(field: Cardinal): Byte;
    function getPChar(field: Cardinal): pchar;
    function getString(field: Cardinal): WideString;
  end;
  TDBCFileStruct = record
      filename : WideString;
      fmt :  WideString;
  end;

const
    FT_NA='x';                                              //not used or unknown, 4 byte size
    FT_NA_BYTE='X';                                         //not used or unknown, byte
    FT_STRING='s';                                          //char*
    FT_FLOAT='f';                                           //float
    FT_INT='i';                                             //uint32
    FT_BYTE='b';                                            //uint8
    FT_SORT='d';                                            //sorted by this field, field is not included
    FT_IND='n';                                             //the same,but parsed to data
    FT_LOGIC='l';                                            //Logical (boolean)

    DBCFileStruct : array[0..245] of TDBCFileStruct =
    (
    	(filename: 'Achievement.dbc'; fmt: 'iiiissssssssssssssssissssssssssssssssiiiiiissssssssssssssssiii'),
    	(filename: 'Achievement_Category.dbc'; fmt: 'iissssssssssssssssii'),
    	(filename: 'Achievement_Criteria.dbc'; fmt: 'iiiiiiiiissssssssssssssssiiiiii'),
    	(filename: 'AnimationData.dbc'; fmt: 'isiiiiii'),
    	(filename: 'AreaGroup.dbc'; fmt: 'iiiiiiii'),
    	(filename: 'AreaPOI.dbc'; fmt: 'iiiiiiiiiiiifffiiissssssssssssssssissssssssssssssssiii'),
    	(filename: 'AreaTable.dbc'; fmt: 'iiiiiiiiiiissssssssssssssssiiiiiiffi'),
    	(filename: 'AreaTrigger.dbc'; fmt: 'iiffffffff'),
    	(filename: 'AttackAnimKits.dbc'; fmt: 'iiiii'),
    	(filename: 'AttackAnimTypes.dbc'; fmt: 'is'),
    	(filename: 'AuctionHouse.dbc'; fmt: 'iiiissssssssssssssssi'),
    	(filename: 'BankBagSlotPrices.dbc'; fmt: 'ii'),
    	(filename: 'BannedAddOns.dbc'; fmt: 'iiiiiiiiiii'),
    	(filename: 'BarberShopStyle.dbc'; fmt: 'iissssssssssssssssissssssssssssssssifiii'),
    	(filename: 'BattlemasterList.dbc'; fmt: 'iiiiiiiiiiissssssssssssssssiiiii'),
    	(filename: 'CameraShakes.dbc'; fmt: 'iiifffff'),
    	(filename: 'Cfg_Categories.dbc'; fmt: 'iiiiiiiiiiiiiiiiiiiii'),
    	(filename: 'Cfg_Configs.dbc'; fmt: 'iiii'),
    	(filename: 'CharacterFacialHairStyles.dbc'; fmt: 'iiiiiiii'),
    	(filename: 'CharBaseInfo.dbc'; fmt: 'bb'),
    	(filename: 'CharHairGeosets.dbc'; fmt: 'iiiiii'),
    	(filename: 'CharHairTextures.dbc'; fmt: 'iiiiiiii'),
    	(filename: 'CharSections.dbc'; fmt: 'iiiisssiii'),
    	(filename: 'CharStartOutfit.dbc'; fmt: 'ibbbbiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii'),
    	(filename: 'CharTitles.dbc'; fmt: 'iissssssssssssssssissssssssssssssssii'),
    	(filename: 'CharVariations.dbc'; fmt: ''),
    	(filename: 'ChatChannels.dbc'; fmt: 'iisssssssssssssssssissssssssssssssssi'),
    	(filename: 'ChatProfanity.dbc'; fmt: 'isi'),
    	(filename: 'ChrClasses.dbc'; fmt: 'iiiissssssssssssssssissssssssssssssssissssssssssssssssiiiiii'),
    	(filename: 'ChrRaces.dbc'; fmt: 'iiiiiisfiiiisissssssssssssssssissssssssssssssssissssssssssssssssisssi'),
    	(filename: 'CinematicCamera.dbc'; fmt: 'isiffff'),
    	(filename: 'CinematicSequences.dbc'; fmt: 'iiiiiiiiii'),
    	(filename: 'CreatureDisplayInfo.dbc'; fmt: 'iiiifisssiiiiiii'),
    	(filename: 'CreatureDisplayInfoExtra.dbc'; fmt: 'iiiiiiiiiiiiiiiiiiiis'),
    	(filename: 'CreatureFamily.dbc'; fmt: 'ififiiiiiissssssssssssssssis'),
    	(filename: 'CreatureModelData.dbc'; fmt: 'iisiisiffffiiiifffffffffffff'),
    	(filename: 'CreatureMovementInfo.dbc'; fmt: 'ii'),
    	(filename: 'CreatureSoundData.dbc'; fmt: 'iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii'),
    	(filename: 'CreatureSpellData.dbc'; fmt: 'iiiiiiiii'),
    	(filename: 'CreatureType.dbc'; fmt: 'issssssssssssssssii'),
    	(filename: 'CurrencyCategory.dbc'; fmt: 'iissssssssssssssssi'),
    	(filename: 'CurrencyTypes.dbc'; fmt: 'iiii'),
    	(filename: 'DanceMoves.dbc'; fmt: 'iiisisssssssssssssssssii'),
    	(filename: 'DeathThudLookups.dbc'; fmt: 'iiiii'),
    	(filename: 'DeclinedWord.dbc'; fmt: 'is'),
    	(filename: 'DeclinedWordCases.dbc'; fmt: 'iiis'),
    	(filename: 'DestructibleModelData.dbc'; fmt: 'iiiiiiiiiiiiiiiiiii'),
    	(filename: 'DungeonEncounter.dbc'; fmt: 'iiiiissssssssssssssssii'),
    	(filename: 'DungeonMap.dbc'; fmt: 'iiiffffi'),
    	(filename: 'DungeonMapChunk.dbc'; fmt: 'iiiif'),
    	(filename: 'DurabilityCosts.dbc'; fmt: 'iiiiiiiiiiiiiiiiiiiiiiiiiiiiii'),
    	(filename: 'DurabilityQuality.dbc'; fmt: 'if'),
    	(filename: 'Emotes.dbc'; fmt: 'isiiiii'),
    	(filename: 'EmotesText.dbc'; fmt: 'isiiiiiiiiiiiiiiiii'),
    	(filename: 'EmotesTextData.dbc'; fmt: 'issssssssssssssssi'),
    	(filename: 'EmotesTextSound.dbc'; fmt: 'iiiii'),
    	(filename: 'EnvironmentalDamage.dbc'; fmt: 'iii'),
    	(filename: 'Exhaustion.dbc'; fmt: 'iifffssssssssssssssssif'),
    	(filename: 'Faction.dbc'; fmt: 'iiiiiiiiiiiiiiiiiiiiiiissssssssssssssssissssssssssssssssi'),
    	(filename: 'FactionGroup.dbc'; fmt: 'iisssssssssssssssssi'),
    	(filename: 'FactionTemplate.dbc'; fmt: 'iiiiiiiiiiiiii'),
    	(filename: 'FileData.dbc'; fmt: 'isi'),
    	(filename: 'FootprintTextures.dbc'; fmt: 'is'),
    	(filename: 'FootstepTerrainLookup.dbc'; fmt: 'iiiii'),
    	(filename: 'GameObjectArtKit.dbc'; fmt: 'iiiissss'),
    	(filename: 'GameObjectDisplayInfo.dbc'; fmt: 'isiiiiiiiiiifffffff'),
    	(filename: 'GameTables.dbc'; fmt: 'sii'),
    	(filename: 'GameTips.dbc'; fmt: 'issssssssssssssssi'),
    	(filename: 'GemProperties.dbc'; fmt: 'iiiii'),
    	(filename: 'GlyphProperties.dbc'; fmt: 'iiii'),
    	(filename: 'GlyphSlot.dbc'; fmt: 'iii'),
    	(filename: 'GMSurveyAnswers.dbc'; fmt: 'iiissssssssssssssssi'),
    	(filename: 'GMSurveyCurrentSurvey.dbc'; fmt: 'ii'),
    	(filename: 'GMSurveyQuestions.dbc'; fmt: 'issssssssssssssssi'),
    	(filename: 'GMSurveySurveys.dbc'; fmt: 'iiiiiiiiiii'),
    	(filename: 'GMTicketCategory.dbc'; fmt: 'issssssssssssssssi'),
    	(filename: 'GroundEffectDoodad.dbc'; fmt: 'iis'),
    	(filename: 'GroundEffectTexture.dbc'; fmt: 'iiiiiiiiiii'),
    	(filename: 'gtBarberShopCostBase.dbc'; fmt: 'f'),
    	(filename: 'gtChanceToMeleeCrit.dbc'; fmt: 'f'),
    	(filename: 'gtChanceToMeleeCritBase.dbc'; fmt: 'f'),
    	(filename: 'gtChanceToSpellCrit.dbc'; fmt: 'f'),
    	(filename: 'gtChanceToSpellCritBase.dbc'; fmt: 'f'),
    	(filename: 'gtCombatRatings.dbc'; fmt: 'f'),
    	(filename: 'gtNPCManaCostScaler.dbc'; fmt: 'f'),
    	(filename: 'gtOCTClassCombatRatingScalar.dbc'; fmt: 'if'),
    	(filename: 'gtOCTRegenHP.dbc'; fmt: 'f'),
    	(filename: 'gtOCTRegenMP.dbc'; fmt: 'f'),
    	(filename: 'gtRegenHPPerSpt.dbc'; fmt: 'f'),
    	(filename: 'gtRegenMPPerSpt.dbc'; fmt: 'f'),
    	(filename: 'HelmetGeosetVisData.dbc'; fmt: 'iiiiiiii'),
    	(filename: 'HolidayDescriptions.dbc'; fmt: 'issssssssssssssssi'),
    	(filename: 'HolidayNames.dbc'; fmt: 'issssssssssssssssi'),
    	(filename: 'Holidays.dbc'; fmt: 'iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiisiii'),
    	(filename: 'Item.dbc'; fmt: 'iiiiiiii'),
    	(filename: 'ItemBagFamily.dbc'; fmt: 'issssssssssssssssi'),
    	(filename: 'ItemClass.dbc'; fmt: 'iiissssssssssssssssi'),
    	(filename: 'ItemCondExtCosts.dbc'; fmt: 'iiii'),
    	(filename: 'ItemDisplayInfo.dbc'; fmt: 'issssssiiiiiiiissssssssii'),
    	(filename: 'ItemExtendedCost.dbc'; fmt: 'iiiiiiiiiiiiiiii'),
    	(filename: 'ItemGroupSounds.dbc'; fmt: 'iiiii'),
    	(filename: 'ItemLimitCategory.dbc'; fmt: 'issssssssssssssssiii'),
    	(filename: 'ItemPetFood.dbc'; fmt: 'issssssssssssssssi'),
    	(filename: 'ItemPurchaseGroup.dbc'; fmt: 'iiiissssssssssssssssiiiiii'),
    	(filename: 'ItemRandomProperties.dbc'; fmt: 'isiiiiissssssssssssssssi'),
    	(filename: 'ItemRandomSuffix.dbc'; fmt: 'issssssssssssssssisiiiiiiiiii'),
    	(filename: 'ItemSet.dbc'; fmt: 'issssssssssssssssiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii'),
    	(filename: 'ItemSubClass.dbc'; fmt: 'iiiiiiiiiissssssssssssssssissssssssssssssssi'),
    	(filename: 'ItemSubClassMask.dbc'; fmt: 'iissssssssssssssssi'),
    	(filename: 'ItemVisualEffects.dbc'; fmt: 'is'),
    	(filename: 'ItemVisuals.dbc'; fmt: 'iiiiii'),
    	(filename: 'Languages.dbc'; fmt: 'issssssssssssssssi'),
    	(filename: 'LanguageWords.dbc'; fmt: 'iis'),
    	(filename: 'LFGDungeonExpansion.dbc'; fmt: 'iiiiiiii'),
    	(filename: 'LFGDungeonGroup.dbc'; fmt: 'issssssssssssssssiiii'),
    	(filename: 'LFGDungeons.dbc'; fmt: 'issssssssssssssssiiiiiiiiiiiiiiissssssssssssssssi'),
    	(filename: 'Light.dbc'; fmt: 'iifffffiiiiiiii'),
    	(filename: 'LightFloatBand.dbc'; fmt: 'iiiiffffffffffffffffffffffffffffff'),
    	(filename: 'LightIntBand.dbc'; fmt: 'iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii'),
    	(filename: 'LightParams.dbc'; fmt: 'iiiifffff'),
    	(filename: 'LightSkybox.dbc'; fmt: 'isi'),
    	(filename: 'LiquidMaterial.dbc'; fmt: 'iii'),
    	(filename: 'LiquidType.dbc'; fmt: 'isiiiiiffffifiiiiiiiiiiiffffiiiifffffffffffii'),
    	(filename: 'LoadingScreens.dbc'; fmt: 'isss'),
    	(filename: 'LoadingScreenTaxiSplines.dbc'; fmt: 'iifffffffifffffffii'),
    	(filename: 'Lock.dbc'; fmt: 'iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii'),
    	(filename: 'LockType.dbc'; fmt: 'issssssssssssssssissssssssssssssssissssssssssssssssis'),
    	(filename: 'MailTemplate.dbc'; fmt: 'issssssssssssssssissssssssssssssssi'),
    	(filename: 'Map.dbc'; fmt: 'isiisssssssssssssssssiissssssssssssssssissssssssssssssssiififfiiii'),
    	(filename: 'MapDifficulty.dbc'; fmt: 'iiissssssssssssssssiiii'),
    	(filename: 'Material.dbc'; fmt: 'iiiii'),
    	(filename: 'Movie.dbc'; fmt: 'isi'),
    	(filename: 'MovieFileData.dbc'; fmt: 'ii'),
    	(filename: 'MovieVariation.dbc'; fmt: 'iii'),
    	(filename: 'NameGen.dbc'; fmt: 'isii'),
    	(filename: 'NamesProfanity.dbc'; fmt: 'isi'),
    	(filename: 'NamesReserved.dbc'; fmt: 'isi'),
    	(filename: 'NPCSounds.dbc'; fmt: 'iiiii'),
    	(filename: 'ObjectEffect.dbc'; fmt: 'isiiiiiififi'),
    	(filename: 'ObjectEffectGroup.dbc'; fmt: 'is'),
    	(filename: 'ObjectEffectModifier.dbc'; fmt: 'iiiiffff'),
    	(filename: 'ObjectEffectPackage.dbc'; fmt: 'is'),
    	(filename: 'ObjectEffectPackageElem.dbc'; fmt: 'iiii'),
    	(filename: 'OverrideSpellData.dbc'; fmt: 'iiiiiiiiiiii'),
    	(filename: 'Package.dbc'; fmt: 'iiissssssssssssssssi'),
    	(filename: 'PageTextMaterial.dbc'; fmt: 'is'),
    	(filename: 'PaperDollItemFrame.dbc'; fmt: 'ssi'),
    	(filename: 'ParticleColor.dbc'; fmt: 'ibbbbbbbbb'),
    	(filename: 'PetitionType.dbc'; fmt: 'isi'),
    	(filename: 'PetPersonality.dbc'; fmt: 'issssssssssssssssiiiffff'),
    	(filename: 'PowerDisplay.dbc'; fmt: 'iiiiii'),
    	(filename: 'PvpDifficulty.dbc'; fmt: 'iiiiii'),
    	(filename: 'QuestFactionReward.dbc'; fmt: 'iiiiiiiiiii'),
    	(filename: 'QuestInfo.dbc'; fmt: 'issssssssssssssssi'),
    	(filename: 'QuestSort.dbc'; fmt: 'issssssssssssssssi'),
    	(filename: 'QuestXP.dbc'; fmt: 'iiiiiiiiiii'),
    	(filename: 'RandPropPoints.dbc'; fmt: 'iiiiiiiiiiiiiiii'),
    	(filename: 'Resistances.dbc'; fmt: 'iiissssssssssssssssi'),
    	(filename: 'ScalingStatDistribution.dbc'; fmt: 'iiiiiiiiiiiiiiiiiiiiii'),
    	(filename: 'ScalingStatValues.dbc'; fmt: 'iiiiiiiiiiiiiiiiiiiiiiii'),
    	(filename: 'ScreenEffect.dbc'; fmt: 'isiiiiiiii'),
    	(filename: 'ServerMessages.dbc'; fmt: 'issssssssssssssssi'),
    	(filename: 'SheatheSoundLookups.dbc'; fmt: 'iiiiiii'),
    	(filename: 'SkillCostsData.dbc'; fmt: 'iiiii'),
    	(filename: 'SkillLine.dbc'; fmt: 'iiissssssssssssssssissssssssssssssssiissssssssssssssssii'),
    	(filename: 'SkillLineAbility.dbc'; fmt: 'iiiiiiiiiiiiii'),
    	(filename: 'SkillLineCategory.dbc'; fmt: 'issssssssssssssssii'),
    	(filename: 'SkillRaceClassInfo.dbc'; fmt: 'iiiiiiii'),
    	(filename: 'SkillTiers.dbc'; fmt: 'iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii'),
    	(filename: 'SoundAmbience.dbc'; fmt: 'iii'),
    	(filename: 'SoundEmitters.dbc'; fmt: 'iffffffiis'),
    	(filename: 'SoundEntries.dbc'; fmt: 'iisssssssssssiiiiiiiiiisfiffii'),
    	(filename: 'SoundEntriesAdvanced.dbc'; fmt: 'iifiiiiiiiiifffiiiiffffs'),
    	(filename: 'SoundFilter.dbc'; fmt: 'is'),
    	(filename: 'SoundFilterElem.dbc'; fmt: 'iiiifffffffff'),
    	(filename: 'SoundProviderPreferences.dbc'; fmt: 'isiifffiifififffifffffff'),
    	(filename: 'SoundSamplePreferences.dbc'; fmt: 'iiiiiifffffffffff'),
    	(filename: 'SoundWaterType.dbc'; fmt: 'iiii'),
    	(filename: 'SpamMessages.dbc'; fmt: 'is'),
    	(filename: 'Spell.dbc'; fmt: 'iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiifiiiiiiiiiiiiiiiiiiiiiiiiiiiiifffiiiiiiiiiiiiiiiiiiiiifffiiiiiiiiiiiiiiifffiiiiiiiiiiiiiissssssssssssssssissssssssssssssssiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiifffiiiiiiiiiiiiiii'),
    	(filename: 'SpellCastTimes.dbc'; fmt: 'iiii'),
    	(filename: 'SpellCategory.dbc'; fmt: 'ii'),
    	(filename: 'SpellChainEffects.dbc'; fmt: 'iiiiiiisiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii'),
    	(filename: 'SpellDescriptionVariables.dbc'; fmt: 'is'),
    	(filename: 'SpellDifficulty.dbc'; fmt: 'iiiii'),
    	(filename: 'SpellDispelType.dbc'; fmt: 'issssssssssssssssiiis'),
    	(filename: 'SpellDuration.dbc'; fmt: 'iiii'),
    	(filename: 'SpellEffectCameraShakes.dbc'; fmt: 'iiii'),
    	(filename: 'SpellFocusObject.dbc'; fmt: 'issssssssssssssssi'),
    	(filename: 'SpellIcon.dbc'; fmt: 'is'),
    	(filename: 'SpellItemEnchantment.dbc'; fmt: 'iiiiiiiiiiiiiissssssssssssssssiiiiiiii'),
    	(filename: 'SpellItemEnchantmentCondition.dbc'; fmt: 'ibbbbbiiiiibbbbbbbbbbiiiiibbbbb'),
    	(filename: 'SpellMechanic.dbc'; fmt: 'issssssssssssssssi'),
    	(filename: 'SpellMissile.dbc'; fmt: 'iiffffffffffffi'),
    	(filename: 'SpellMissileMotion.dbc'; fmt: 'issii'),
    	(filename: 'SpellRadius.dbc'; fmt: 'ifif'),
    	(filename: 'SpellRange.dbc'; fmt: 'iffffissssssssssssssssissssssssssssssssi'),
    	(filename: 'SpellRuneCost.dbc'; fmt: 'iiiii'),
    	(filename: 'SpellShapeshiftForm.dbc'; fmt: 'iissssssssssssssssiiiiiiiiiiiiiiiii'),
    	(filename: 'SpellVisual.dbc'; fmt: 'iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii'),
    	(filename: 'SpellVisualEffectName.dbc'; fmt: 'issffff'),
    	(filename: 'SpellVisualKit.dbc'; fmt: 'iiiiiiiiiiiiiiiiiiiiiiffffffffffffffii'),
    	(filename: 'SpellVisualKitAreaModel.dbc'; fmt: 'iii'),
    	(filename: 'SpellVisualKitModelAttach.dbc'; fmt: 'iiiiiiiiii'),
    	(filename: 'SpellVisualPrecastTransitions.dbc'; fmt: 'iss'),
    	(filename: 'StableSlotPrices.dbc'; fmt: 'ii'),
    	(filename: 'Startup_Strings.dbc'; fmt: 'isssssssssssssssssi'),
    	(filename: 'Stationery.dbc'; fmt: 'iisi'),
    	(filename: 'StringLookups.dbc'; fmt: 'is'),
    	(filename: 'SummonProperties.dbc'; fmt: 'iiiiii'),
    	(filename: 'Talent.dbc'; fmt: 'iiiiiiiiiiiiiiiiiiiiiii'),
    	(filename: 'TalentTab.dbc'; fmt: 'issssssssssssssssiiiiiis'),
    	(filename: 'TaxiNodes.dbc'; fmt: 'iifffssssssssssssssssiii'),
    	(filename: 'TaxiPath.dbc'; fmt: 'iiii'),
    	(filename: 'TaxiPathNode.dbc'; fmt: 'iiiifffiiii'),
    	(filename: 'TeamContributionPoints.dbc'; fmt: 'if'),
    	(filename: 'TerrainType.dbc'; fmt: 'isiiii'),
    	(filename: 'TerrainTypeSounds.dbc'; fmt: 'i'),
    	(filename: 'TotemCategory.dbc'; fmt: 'issssssssssssssssiii'),
    	(filename: 'TransportAnimation.dbc'; fmt: 'iiifffi'),
    	(filename: 'TransportPhysics.dbc'; fmt: 'iffffffffff'),
    	(filename: 'TransportRotation.dbc'; fmt: 'iiiffff'),
    	(filename: 'UISoundLookups.dbc'; fmt: 'iis'),
    	(filename: 'UnitBlood.dbc'; fmt: 'iiiiissssi'),
    	(filename: 'UnitBloodLevels.dbc'; fmt: 'iiii'),
    	(filename: 'Vehicle.dbc'; fmt: 'iiffffiiiiiiiifffffffffffffffiiiififiiii'),
    	(filename: 'VehicleSeat.dbc'; fmt: 'iiiffffffffffiiiiiiiffffffiiifffiiiiiiiffiiiiiiiiiiiiiiiii'),
    	(filename: 'VehicleUIIndicator.dbc'; fmt: 'ii'),
    	(filename: 'VehicleUIIndSeat.dbc'; fmt: 'iiiff'),
    	(filename: 'VideoHardware.dbc'; fmt: 'iiiiiiiiiiiiiiiiiissiii'),
    	(filename: 'VocalUISounds.dbc'; fmt: 'iiiiiii'),
    	(filename: 'WeaponImpactSounds.dbc'; fmt: 'iiiiiiiiiiiiiiiiiiiiiii'),
    	(filename: 'WeaponSwingSounds2.dbc'; fmt: 'iiii'),
    	(filename: 'Weather.dbc'; fmt: 'iiiffffs'),
    	(filename: 'WMOAreaTable.dbc'; fmt: 'iiiiiiiiiiissssssssssssssssi'),
    	(filename: 'WorldChunkSounds.dbc'; fmt: 'iiiiiiiii'),
    	(filename: 'WorldMapArea.dbc'; fmt: 'iiisffffiii'),
    	(filename: 'WorldMapContinent.dbc'; fmt: 'iiiiiifffffffi'),
    	(filename: 'WorldMapOverlay.dbc'; fmt: 'iiiiiiiisiiiiiiii'),
    	(filename: 'WorldMapTransforms.dbc'; fmt: 'iiffffiffi'),
    	(filename: 'WorldSafeLocs.dbc'; fmt: 'iifffssssssssssssssssi'),
    	(filename: 'WorldStateUI.dbc'; fmt: 'iiiisssssssssssssssssissssssssssssssssiiiissssssssssssssssiiiii'),
    	(filename: 'WorldStateZoneSounds.dbc'; fmt: 'iiiiiiii'),
    	(filename: 'WowError_Strings.dbc'; fmt: 'isssssssssssssssssi'),
    	(filename: 'ZoneIntroMusicTable.dbc'; fmt: 'isiii'),
    	(filename: 'ZoneMusic.dbc'; fmt: 'isiiiiii')
    );

implementation

uses MyDataModule;

procedure assert(Expr: boolean);
begin
  if not Expr then raise Exception.Create('Incorrect field number');
end;

{ TDBCFile }

constructor TDBCFile.Create;
begin
  data := NIL;
  fieldsOffset := NIL;
  IsLocalized := true;
end;

destructor TDBCFile.Destroy;
begin
  if Assigned(data) then FreeMem(data);
  if Assigned(fieldsOffset) then SetLength(fieldsOffset,0);
  inherited;
end;

function TDBCFile.GetCols: Cardinal;
begin
  Result := fieldCount;
end;

function TDBCFile.GetNumRows: Cardinal;
begin
  Result := recordCount;
end;

function TDBCFile.GetOffset(id: Cardinal): Cardinal;
begin
  if (fieldsOffset <> nil) and (id<fieldCount) then
    Result := fieldsOffset[id]
  else
    Result := 0;
end;

procedure TDBCFile.setRecord(id: Cardinal);
begin
  offset := pchar(Cardinal(data) + id * recordSize);
end;

function TDBCFile.IsLoaded: boolean;
begin
  Result := data <> nil;
end;

function SwapEndian(Value: integer): integer; register; overload;
asm
  bswap eax
end;

function SwapEndian(Value: smallint): smallint; register; overload;
asm
  xchg  al, ah
end;

function TDBCFile.Load(filename: WideString): boolean;
var
  header, i: Cardinal;
  f: Integer;
  fmt: PArray;
  tmp: String;
begin
  if Assigned(data) then
  begin
    FreeMem(data);
    data := nil;
  end;
  f := FileOpen(filename, fmOpenRead);
  if f = -1 then 
  begin
    Result := false;
    Exit;
  end;
  FileRead(f, header, 4);
  if header <> $43424457 then
  begin
    Result := false;
    Exit;
  end;

  for i:= 0 to High(DBCFileStruct) do
	begin
  	if DBCFileStruct[i].filename = ExtractFileName(filename) then
  	begin
    	tmp := DBCFileStruct[i].fmt;
    	SetLength(fmt, Length(tmp));
      CopyMemory(@fmt[low(fmt)], @tmp[1], sizeof(fmt));
    	break;
  	end;
	end;
  if fmt = nil then
  begin
  	ShowMessage('Fatal Error - Couldn''t read DBC Format for file '+filename+#10#13#10#13+tmp);
    Result := false;
    Exit;
  end;

  FileRead(F, recordCount, 4);
  SwapEndian(recordCount);
  FileRead(F, fieldCount, 4);
  SwapEndian(fieldCount);
  FileRead(F, recordSize, 4);
  SwapEndian(recordSize);
  FileRead(F, stringSize, 4);
  SwapEndian(stringSize);
  SetLength(fieldsOffset, fieldCount+1);
  //ShowMessage('RC:'+IntToStr(recordCount)+' FC:'+IntToStr(fieldCount)+' RS:'+IntToStr(recordSize)+' FOS:'+IntToStr(High(fmt)));
  fieldsOffset[0] := 0;
  for i := 1 to fieldCount do
  begin
    fieldsOffset[i] := fieldsOffset[i-1];
    if (fmt[i-1] = 'b') OR (fmt[i-1] = 'X') then
      inc(fieldsOffset[i],1)
    else
      inc(fieldsOffset[i],4);
  end;
  data := PChar(AllocMem(recordSize*recordCount + stringSize + 1));
  stringTable := pointer( Cardinal(data) + recordSize*recordCount);
  FileRead(F, data^, recordSize*recordCount+stringSize);
  FileClose(F);
  Result := True;
end;

{ TRecord }

function TDBCFile.getFloat(field: Cardinal): Single;
begin
  assert(field < fieldCount);
  CopyMemory(@Result, offset + GetOffset(field), SizeOf(Result));
end;

function TDBCFile.getPChar(field: Cardinal): PChar;
var
  stringOffset : Cardinal;
  fieldid: Cardinal;
  i: Cardinal;
begin
  if dmMain.DBCLocale < 16 then
  begin
    if IsLocalized then
      fieldid := field + dmMain.DBCLocale
    else
      fieldid := field;
    assert(fieldid < fieldCount);
    stringOffset := getUInt(fieldid);
    assert(stringOffset < stringSize);
    Result := stringTable + stringOffset;
  end
  else
  begin
    // Autodetect DBC Locale
    for I := 0 to 15 do
    begin
      fieldid := field + I;
      assert(fieldid < fieldCount);
      stringOffset := getUInt(fieldid);
      assert(stringOffset < stringSize);
      Result := stringTable + stringOffset;
      if Result<>'' then
      begin
        dmMain.DBCLocale := I;
        Exit;
      end;
    end;
  end;
end;

function TDBCFile.getString(field: Cardinal): WideString;
var
  s: WideString;
begin
  s := getPChar(field);
  Result := UTF8ToString(@Pointer(s));
end;

function TDBCFile.getUInt(field: Cardinal): Cardinal;
begin
  assert(field < fieldCount);
  //ShowMessage('Field: ' + IntToStr(field) + ' Data: ' + (offset + GetOffset(field)));
  CopyMemory(@Result, offset + GetOffset(field), sizeof(Result));
end;

function TDBCFile.getUInt8(field: Cardinal): Byte;
begin
  assert(field < fieldCount);
  CopyMemory(@Result, offset + GetOffset(field), SizeOf(Result));
end;

end.
