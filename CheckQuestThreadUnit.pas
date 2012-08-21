unit CheckQuestThreadUnit;

interface

uses
  Classes, SysUtils, Dialogs, Messages, MyDataModule, WideStrings,
  ZConnection, ZAbstractRODataset, ZAbstractDataset, ZDataset;

type
  TCheckQuestThread = class(TThread)
  private
    cq: integer;
    FQuestList: TList;
    Report:  TStringList;
    MyQuery: TZQuery;
    MyTempQuery: TZQuery;
    MyLootQuery: TZQuery;
    ErrorStr: string;

    function CheckQuestLog(qId: integer): string;
    procedure UpdateCaption2;
    procedure UpdateCaption3;
    procedure SetQuestList(const Value: TList);
  protected
    procedure Execute; override;
  public
    procedure Prepare(Connection : TZConnection);
    property QuestList: TList read FQuestList write SetQuestList;
    constructor Create(Connection: TZConnection; List: TList; CreateSuspended: boolean);
    procedure MyTerminate(Sender: TObject);
    procedure HandleThreadException;
  end;

implementation

uses Math, Functions, checkUnit;

{ Important: Methods and properties of objects in visual components can only be
  used in a method called using Synchronize, for example,

      Synchronize(UpdateCaption);

  and UpdateCaption could look like,

    procedure TCheckQuestThread.UpdateCaption;
    begin
      Form1.Caption := 'Updated in a thread';
    end; }

{ TCheckQuestThread }

{.$DEFINE QUICK}

procedure TCheckQuestThread.Execute;
var
  i: integer;
begin
  for i:=0 to FQuestList.Count - 1 do
  begin
    if Terminated then
      Exit
    else
    begin
      try
        cq:=integer(FQuestList[i]);
        CheckQuestLog(cq);
        Synchronize(UpdateCaption3);
      except
        on E: Exception do
        begin
          ErrorStr:=E.Message;
          if not(ExceptObject is EAbort) then
            Synchronize(HandleThreadException);
        end;
      end;
    end;
  end;
end;

procedure TCheckQuestThread.MyTerminate(Sender: TObject);
begin
  MyQuery.Free;
  MyTempQuery.Free;
  MyLootQuery.Free;
  Report.Free;
  FQuestList.Free;
end;

function TCheckQuestThread.CheckQuestLog(qId: integer): string;
var
  Log, fname: string;
  cid, i, j: integer;
  ErrCount: integer;
  WarnCount: integer;
  List: TWideStringList;
  ItemQuestGiver: integer;
  QuestGiverOtherCount: integer;
  QuestTakerOtherCount: integer;
    procedure Add(typ: integer; S: string; const Args: array of const); overload;
    begin
      Report.Add(Format(S,Args));
      if typ=1 then Inc(ErrCount);
      if typ=2 then Inc(WarnCount);
    end;

    procedure Add(typ: integer; S: string); overload;
    begin
      Report.Add(S);
      if typ=1 then Inc(ErrCount);
      if typ=2 then Inc(WarnCount);
    end;

begin
  //
  Synchronize(UpdateCaption2);  if Terminated then Exit;
  //

  Add(0, dmMain.Text[24], [qid]); //'quest = %d'

  ItemQuestGiver:=0;
  ErrCount:=0;
  WarnCount:=0;
  QuestGiverOtherCount:=0;
  QuestTakerOtherCount:=0;
  if qid<=0 then
  begin
    Add(1, dmMain.Text[25], [qid]); //'Fatal Error: Wrong quest id (%d)'
    Exit;
  end;
  MyQuery.Close;
  MyTempQuery.Close;
  MyLootQuery.Close;
  MyQuery.SQL.Text:=Format('SELECT * FROM `quest_template` WHERE `Id`=%d',[qid]);
  MyQuery.Open;
  if MyQuery.Eof then
  begin
    Add(1, dmMain.Text[26], [qid]); //'Fatal Error: Quest with entry = %d not found'
    Exit;
  end;
  //
  Synchronize(UpdateCaption2);  if Terminated then Exit;
  //

  // quest giver creature check
  MyQuery.Close;
  MyQuery.SQL.Text:=Format('SELECT * FROM `creature_questrelation` WHERE `quest` = %d',[qid]);
  MyQuery.Open;
  if not MyQuery.Eof then
  begin
    inc(QuestGiverOtherCount);
    if MyQuery.RecordCount>1 then
    begin
      Add(2, dmMain.Text[27]); //'Warning: There more than one quest giver:'
      while not MyQuery.Eof do
      begin
        Add(0,'-----> creature, entry = %d',[MyQuery.FieldByName('id').AsInteger]);
        MyQuery.Next;
      end;
    end
    else
    begin
      // one rec only
      cid := MyQuery.FieldByName('id').AsInteger;
      MyQuery.Close;
      MyQuery.SQL.Text:=Format('SELECT * FROM `creature_template` WHERE `entry`=%d ',[cid]);
      MyQuery.Open;
      if not MyQuery.Eof then
      begin
        if (MyQuery.FieldByName('npcflag').AsInteger and 2) <> 2 then
          Add(1, dmMain.Text[28], [cid]); //'Error: quest giver is creature with entry = %d, but (`npcflag` & 2) <> 2 '
        MyQuery.Close;
        MyQuery.SQL.Text:=Format('SELECT * FROM `creature` WHERE `id`=%d',[cid]);
        MyQuery.Open;
        if not MyQuery.Eof then
        begin
          if MyQuery.RecordCount>1 then
            Add(2, dmMain.Text[29], [cid]); //'Warning: There more than one location for quest giver (id=%d) in table `creature`'
        end
        else
          Add(1, dmMain.Text[30], [cid]); //'Error: Location for quest giver (id=%d) not found in table `creature`'
      end
      else
        Add(1, dmMain.Text[31], [cid]); //'Error: quest giver is creature with entry = %d, but there is no one record in `creature_template` with entry = %0:d'
    end;
  end;
  //
  Synchronize(UpdateCaption2);  if Terminated then Exit;
  //

  // quest giver gameobject check
  MyQuery.Close;
  MyQuery.SQL.Text:=Format('SELECT * FROM `gameobject_questrelation` WHERE `quest` = %d',[qid]);
  MyQuery.Open;
  if not MyQuery.Eof then
  begin
    inc(QuestGiverOtherCount);
    if MyQuery.RecordCount>1 then
    begin
      Add(2,dmMain.Text[27]);
      while not MyQuery.Eof do
      begin
        Add(0,'-----> gameobject, entry = %d',[MyQuery.FieldByName('id').AsInteger]);
        MyQuery.Next;
      end;
    end
    else
    begin
      // one rec only
      cid := MyQuery.FieldByName('id').AsInteger;
      MyQuery.Close;
      MyQuery.SQL.Text:=Format('SELECT * FROM `gameobject_template` WHERE `entry`=%d ',[cid]);
      MyQuery.Open;
      if not MyQuery.Eof then
      begin
        MyQuery.Close;
        MyQuery.SQL.Text:=Format('SELECT * FROM `gameobject` WHERE `id`=%d',[cid]);
        MyQuery.Open;
        if not MyQuery.Eof then
        begin
          if MyQuery.RecordCount>1 then
            Add(2, dmMain.Text[32], [cid]); //'Warning: There more than one location for quest giver (id=%d) in table `gameobject`'
        end
        else
          Add(1, dmMain.Text[33], [cid]); //'Error: Location for quest giver (id=%d) not found in table `gameobject`'
      end
      else
        Add(1, dmMain.Text[76], [cid]); //'Error: quest giver is gameobject with entry = %d, but there is no one record in `gameobject_template` with entry = %0:d'
    end;
  end;
   //
  Synchronize(UpdateCaption2);  if Terminated then Exit;
  //

  // item quest giver check
  MyQuery.Close;

  {$IFNDEF QUICK}
  MyQuery.SQL.Text:=Format('SELECT `entry` FROM `item_template` WHERE `startquest` = %d',[qid]);
  MyQuery.Open;
  {$ENDIF}

   //
  Synchronize(UpdateCaption2);  if Terminated then Exit;
  //

  if not MyQuery.Eof then
  begin
    inc(QuestGiverOtherCount);
    if MyQuery.RecordCount>1 then
    begin
      Add(2,dmMain.Text[27]);
      while not MyQuery.Eof do
      begin
        Add(0,'-----> item, entry = %d',[MyQuery.FieldByName('entry').AsInteger]);
        MyQuery.Next;
      end;
    end
    else
    begin
      // one rec only
      cid := MyQuery.FieldByName('entry').AsInteger;
      ItemQuestGiver:=cid;
      MyQuery.Close;
      MyQuery.SQL.Text:=Format('SELECT * FROM `creature_loot_template` WHERE `item`=%d ',[cid]);
      MyQuery.Open;
   //
  Synchronize(UpdateCaption2);  if Terminated then Exit;
  //

      if MyQuery.Eof then
      begin
        MyQuery.Close;
        MyQuery.SQL.Text:=Format('SELECT * FROM `gameobject_loot_template` WHERE `item`=%d ',[cid]);
        MyQuery.Open;
   //
  Synchronize(UpdateCaption2);  if Terminated then Exit;
  //
        if MyQuery.Eof then
        begin
          MyQuery.Close;
          MyQuery.SQL.Text:=Format('SELECT * FROM `item_loot_template` WHERE `item`=%d ',[cid]);
          MyQuery.Open;
   //
  Synchronize(UpdateCaption2);  if Terminated then Exit;
  //
          if MyQuery.Eof then
          begin
            MyQuery.Close;
            MyQuery.SQL.Text:=Format('SELECT * FROM `pickpocketing_loot_template` WHERE `item`=%d ',[cid]);
            MyQuery.Open;
   //
  Synchronize(UpdateCaption2);  if Terminated then Exit;
  //
            if MyQuery.Eof then
            begin
              MyQuery.Close;
              MyQuery.SQL.Text:=Format('SELECT * FROM `skinning_loot_template` WHERE `item`=%d ',[cid]);
              MyQuery.Open;
   //
  Synchronize(UpdateCaption2);  if Terminated then Exit;
  //
              if MyQuery.Eof then
              begin
                MyQuery.Close;
                MyQuery.SQL.Text:=Format('SELECT * FROM `disenchant_loot_template` WHERE `item`=%d ',[cid]);
                MyQuery.Open;
   //
  Synchronize(UpdateCaption2);  if Terminated then Exit;
  //
                if MyQuery.Eof then
                begin
                  MyQuery.Close;
                  MyQuery.SQL.Text:=Format('SELECT * FROM `npc_vendor` WHERE `item`=%d ',[cid]);
                  MyQuery.Open;
   //
  Synchronize(UpdateCaption2);  if Terminated then Exit;
  //
                  if MyQuery.Eof then
                  begin
                    Add(2, dmMain.Text[34], [cid]); //'Warning: quest giver is item (id=%d), but there is no one loot in tables *_loot_template and npc_vendor.  May be it is not error, just item need to be rewarded or gived from other quest.'
                  end;
                end;
              end;
            end;
          end;
        end;
      end;
    end;
  end;

  // creature quest taker check
  MyQuery.Close;
  MyQuery.SQL.Text:=Format('SELECT * FROM `creature_involvedrelation` WHERE `quest` = %d',[qid]);
  MyQuery.Open;
  if not MyQuery.Eof then
  begin
    inc(QuestTakerOtherCount);
    if MyQuery.RecordCount>1 then
    begin
      Add(2, dmMain.Text[35]); //'Warning: There more than one quest taker: '
      while not MyQuery.Eof do
      begin
        Add(0,'-----> creature, entry = %d',[MyQuery.FieldByName('id').AsInteger]);
        MyQuery.Next;
      end;
    end
    else
    begin
      // one rec only
      cid := MyQuery.FieldByName('id').AsInteger;
      MyQuery.Close;
      MyQuery.SQL.Text:=Format('SELECT * FROM `creature_template` WHERE `entry`=%d ',[cid]);
      MyQuery.Open;
      if not MyQuery.Eof then
      begin
        if (MyQuery.FieldByName('npcflag').AsInteger and 2) <> 2 then
        begin
          Add(1, dmMain.Text[36], [cid]); //'Error: quest taker is creature with entry = %d, but (`npcflag` & 2) <> 2 '
        end;
        MyQuery.Close;
        MyQuery.SQL.Text:=Format('SELECT * FROM `creature` WHERE `id`=%d',[cid]);
        MyQuery.Open;
        if not MyQuery.Eof then
        begin
          if MyQuery.RecordCount>1 then
            Add(2, dmMain.Text[37], [cid]); //'Warning: There more than one location for quest taker (id=%d) in table `creature`'
        end
        else
          Add(1, dmMain.Text[38], [cid]); //'Error: Location for quest taker (id=%d) not found in table `creature`'
      end
      else
        Add(1, dmMain.Text[39], [cid]); //'Error: quest taker is creature with entry = %d, but there is no one record in `creature_template` with entry = %0:d'
    end;
  end;
  //
  Synchronize(UpdateCaption2);  if Terminated then Exit;
  //

  // quest taker gameobject check
  MyQuery.Close;
  MyQuery.SQL.Text:=Format('SELECT * FROM `gameobject_involvedrelation` WHERE `quest` = %d',[qid]);
  MyQuery.Open;
  if not MyQuery.Eof then
  begin
    inc(QuestTakerOtherCount);
    if MyQuery.RecordCount>1 then
    begin
      Add(2,dmMain.Text[35]);
      while not MyQuery.Eof do
      begin
        Add(0,'-----> gameobject, entry = %d',[MyQuery.FieldByName('id').AsInteger]);
        MyQuery.Next;
      end;
    end
    else
    begin
      // one rec only
      cid := MyQuery.FieldByName('id').AsInteger;
      MyQuery.Close;
      MyQuery.SQL.Text:=Format('SELECT * FROM `gameobject_template` WHERE `entry`=%d ',[cid]);
      MyQuery.Open;
      if not MyQuery.Eof then
      begin
        MyQuery.Close;
        MyQuery.SQL.Text:=Format('SELECT * FROM `gameobject` WHERE `id`=%d',[cid]);
        MyQuery.Open;
        if not MyQuery.Eof then
        begin
          if MyQuery.RecordCount>1 then
            Add(2, dmMain.Text[40], [cid]); //'Warning: There more than one location for quest taker (id=%d) in table `gameobject`'
        end
        else
          Add(1, dmMain.Text[41], [cid]); // 'Error: Location for quest taker (id=%d) not found in table `gameobject`'
      end
      else
        Add(1, dmMain.Text[42], [cid]); // 'Error: quest taker is gameobject with entry = %d, but there is no one record in `gameobject_template` with entry = %0:d'
    end;
  end;
  //
  Synchronize(UpdateCaption2);  if Terminated then Exit;
  //

  if QuestGiverOtherCount=0 then Add(1, dmMain.Text[43]); //'Error: quest giver not found'
  if QuestTakerOtherCount=0 then Add(1, dmMain.Text[44]); //'Error: quest taker not found'

  //  'Warning: There is more than one different type quest giver (quest giver count=%d)'
  if QuestGiverOtherCount>1 then Add(2, dmMain.Text[45], [QuestGiverOtherCount]);
  
  // 'Warning: There is more than one different type quest taker (quest taker count=%d)'
  if QuestTakerOtherCount>1 then Add(2, dmMain.Text[46], [QuestTakerOtherCount]);

  // quest check begin
  MyQuery.Close;
  MyQuery.SQL.Text:=Format('SELECT * FROM `quest_template` WHERE `Id` = %d',[qid]);
  MyQuery.Open;
  // prev quest id check
  cid:=MyQuery.FieldByName('PrevQuestId').AsInteger;
  if cid>0 then
  begin
    MyTempQuery.SQL.Text:=Format('SELECT * FROM `quest_template` WHERE `Id` = %d', [cid]);
    MyTempQuery.Open;

    if MyTempQuery.Eof then
      Add(1, dmMain.Text[47], [cid]); //'Error: PrevQuestId=%d, but quest with this id is not exists'

    MyTempQuery.Close;
  end;
  //
  Synchronize(UpdateCaption2);  if Terminated then Exit;
  //

  // next quest id check
  cid:=MyQuery.FieldByName('NextQuestId').AsInteger;
  if cid>0 then
  begin
    MyTempQuery.SQL.Text:=Format('SELECT * FROM `quest_template` WHERE `Id` = %d',[cid]);
    MyTempQuery.Open;
    if MyTempQuery.Eof then
      Add(1, dmMain.Text[48], [cid]); //'Error: NextQuestId=%d, but quest with this id is not exists'
    MyTempQuery.Close;
  end;
  //
  Synchronize(UpdateCaption2);  if Terminated then Exit;
  //

  List:=TWideStringList.Create;
  try
    // Type check
    cid:=MyQuery.FieldByName('Type').AsInteger;
    if cid>0 then
    begin
      LoadSimpleIDListFromDBCFile(List, 'QuestInfo');      
      i:=List.IndexOf(IntToStr(cid));
      if i=-1 then
        Add(1, dmMain.Text[49], [cid]); //'Error: Type = %d, but Type with this id is not exists'
    end;

    // factions check
    for i:=0 to MyQuery.Fields.Count - 1 do
    begin
      if Pos(LowerCase('Faction'), LowerCase(MyQuery.Fields[i].FieldName))>0 then
      begin
        cid := MyQuery.Fields[i].AsInteger;
        if cid>0 then
        begin
          LoadSimpleIDListFromDBCFile(List, 'Faction');          
          j:=List.IndexOf(IntToStr(cid));
          if j=-1 then
            Add(1, dmMain.Text[50],[MyQuery.Fields[i].FieldName, cid]);
            //'Error: %s = %d, but Faction with this id is not exists'
        end;
      end;
    end;

    // ZoneID check
    cid:=MyQuery.FieldByName('ZoneOrSort').AsInteger;
    if cid>0 then
    begin
      LoadSimpleIDListFromDBCFile(List, 'AreaTable');
      i:=List.IndexOf(IntToStr(cid));
      if i=-1 then
        Add(1, dmMain.Text[51], [cid]); //'Error: ZoneOrSort = %d, but ZoneId with this id  is not exists'
    end
    else
    if cid<0 then
    begin
      LoadSimpleIDListFromDBCFile(List, 'QuestSort');
      i:=List.IndexOf(IntToStr(-cid));
      if i=-1 then
        Add(1, dmMain.Text[52], [cid]); //'Error: ZoneOrSort = %d, but QuestSort with this id is not exists'
    end;

  finally
    List.Free;
  end;

  // quest level check
  if MyQuery.FieldByName('MinLevel').AsInteger>MyQuery.FieldByName('QuestLevel').AsInteger then
    // 'Error: MinLevel (%d) > QuestLevel (%d)'
    Add(1,dmMain.Text[53],[MyQuery.FieldByName('MinLevel').AsInteger,
      MyQuery.FieldByName('QuestLevel').AsInteger]);
  //
  Synchronize(UpdateCaption2);  if Terminated then Exit;
  //

  // LimitTime check
  cid := MyQuery.FieldByName('LimitTime').AsInteger;
  if cid>0 then
  begin
    if cid<60 then Add(2, 'Warning: LimitTime = %d seconds',[cid]);
{    if MyQuery.FieldByName('QuestFlags').AsInteger and 16 <> 16 then
      Add(2, dmMain.Text[58], [cid]); //'Warning: LimitTime = %d seconds, but QuestFlags is not set to TIMED'
}  end;

  // items check
  for i:=0 to MyQuery.Fields.Count - 1 do
  begin
    fname := MyQuery.Fields[i].FieldName;
    if Pos(LowerCase('ItemId'), LowerCase(fname))>0 then // item field;
    begin
      cid := MyQuery.Fields[i].AsInteger;
//      if cid <> MyQuery.FieldByName('SrcItemId').AsInteger then
      begin
        if cid>0 then
        begin
          MyTempQuery.SQL.Text:=Format('SELECT `entry` FROM `item_template` WHERE `entry` = %d',[cid]);
          MyTempQuery.Open;
          if MyTempQuery.Eof then
            Add(1, dmMain.Text[62],[MyQuery.Fields[i].FieldName, cid]) // 'Error: %s = %d, but item with this id is not exists'
          else
          begin
            // check loot
            if (Pos('rewchoiceitemid',lowercase(fname))<>1) and (Pos('rewitemid',lowercase(fname))<>1) and
              (cid<>ItemQuestGiver) and (cid<>MyQuery.FieldByName('SrcItemId').AsInteger) then
            begin
              MyTempQuery.Close;
              MyTempQuery.SQL.Text:=Format('SELECT `entry` FROM `creature_loot_template` WHERE `item`=%d ',[cid]);
              MyTempQuery.Open;
              if MyTempQuery.Eof then
              begin
                MyTempQuery.Close;
                MyTempQuery.SQL.Text:=Format('SELECT `entry` FROM `gameobject_loot_template` WHERE `item`=%d ',[cid]);
                MyTempQuery.Open;
                if MyTempQuery.Eof then
                begin
                  MyTempQuery.Close;
                  MyTempQuery.SQL.Text:=Format('SELECT `entry` FROM `item_loot_template` WHERE `item`=%d ',[cid]);
                  MyTempQuery.Open;
                  if MyTempQuery.Eof then
                  begin
                    MyTempQuery.Close;
                    MyTempQuery.SQL.Text:=Format('SELECT `entry` FROM `pickpocketing_loot_template` WHERE `item`=%d ',[cid]);
                    MyTempQuery.Open;
                    if MyTempQuery.Eof then
                    begin
                      MyTempQuery.Close;
                      MyTempQuery.SQL.Text:=Format('SELECT `entry` FROM `skinning_loot_template` WHERE `item`=%d ',[cid]);
                      MyTempQuery.Open;
                      if MyTempQuery.Eof then
                      begin
                        MyTempQuery.Close;
                        MyTempQuery.SQL.Text:=Format('SELECT `entry` FROM `disenchant_loot_template` WHERE `item`=%d ',[cid]);
                        MyTempQuery.Open;
                        if MyTempQuery.Eof then
                        begin
                          MyTempQuery.Close;
                          MyTempQuery.SQL.Text:=Format('SELECT `entry` FROM `npc_vendor` WHERE `item`=%d ',[cid]);
                          MyTempQuery.Open;
                          if MyTempQuery.Eof then
                          begin
                            // 'Warning: %s = %d, but there is no one loot in
                            // tables *_loot_template and npc_vendor.
                            // May be it is not error, just item need to be
                            // created or rewarded from other quest.'
                            Add(2, dmMain.Text[63], [fname, cid]);
                          end;
                        end;
                      end;
                    end;
                  end;
                end
                else
                begin
                  if (Pos('reqitemid', lowercase(fname))=1) or (Pos('reqsourceid', lowercase(fname))=1) then
                  begin
                    while not MyTempQuery.Eof do
                    begin
                      MyLootQuery.SQL.Text:=Format('SELECT `guid` FROM `gameobject` WHERE `id` = %d',[
                        MyTempQuery.FieldByName('entry').AsInteger]);
                      MyLootQuery.Open;
                      if MyLootQuery.Eof then
                        // 'Error: %s = %d. Loot for this item is
                        // gameobject_loot_template.entry = %d, but gameobject
                        // with this id not found in `gameobject` table'
                        Add(1, dmMain.Text[64], [fname, cid, MyTempQuery.FieldByName('entry').AsInteger]);
                      MyLootQuery.Close;
                      MyTempQuery.Next;
                    end;
                    MyTempQuery.Close;
                  end;
                end;
              end
              else
              begin
                if (Pos('reqitemid', lowercase(fname))=1) or (Pos('reqsourceid', lowercase(fname))=1) then
                begin
                  while not MyTempQuery.Eof do
                  begin
                    MyLootQuery.SQL.Text:=Format('SELECT `guid` FROM `creature` WHERE `id` = %d',[
                      MyTempQuery.FieldByName('entry').AsInteger]);
                    MyLootQuery.Open;
                    if MyLootQuery.Eof then
                      //'Error: %s = %d. Loot for this item is
                      // creature_loot_template.entry = %d, but creature with
                      // this id not found in `creature` table'
                      Add(1, dmMain.Text[65], [fname, cid, MyTempQuery.FieldByName('entry').AsInteger]);
                    MyLootQuery.Close;
                    MyTempQuery.Next;
                  end;
                  MyTempQuery.Close;
                end;
              end;
            end;
          end;
        end;
      end;
    end;
  end;

  //
  Synchronize(UpdateCaption2);  if Terminated then Exit;
  //

 { //* reqsource check
  for i:=1 to 4 do
  begin
    cid:=MyQuery.FieldByName(Format('ReqSourceRef%d',[i])).AsInteger;
    if cid>0 then
    begin
      if cid>4 then Add(1, dmMain.Text[66], [i]); // 'Error: ReqSourceRef%d > 4'
      if MyQuery.FieldByName(Format('ReqSourceId%d',[i])).AsInteger=0 then
        Add(1, dmMain.Text[67], [i, cid]); // 'Error: ReqSourceId%d=0, but ReqSourceRef%0:d=%1:d '
      if MyQuery.FieldByName(Format('ReqItemId%d',[cid])).AsInteger=0 then
        Add(1, dmMain.Text[68],[i, cid]); //'Error: ReqItemId%1:d=0, but ReqSourceRef%0:d=%1:d '
    end;
  end;

  //
  Synchronize(UpdateCaption2);  if Terminated then Exit;
  //
              }
   //creature or go check
  for i:=1 to 4 do
  begin
    cid:=MyQuery.FieldByName(Format('ReqCreatureOrGOId%d',[i])).AsInteger;
    if cid>0 then
    begin
      MyTempQuery.SQL.Text:=Format('SELECT entry FROM `creature_template` WHERE `entry` = %d',[cid]);
      MyTempQuery.Open;
      if MyTempQuery.Eof then
        Add(1, dmMain.Text[69], [i,cid]) //'Error: ReqCreatureOrGOId%d = %d, but creature with this id is not exists'
      else
      begin
        // location check
        MyTempQuery.Close;
        MyTempQuery.SQL.Text:=Format('SELECT `guid` FROM `creature` WHERE `id`=%d',[cid]);
        MyTempQuery.Open;
        if MyTempQuery.Eof then
          Add(1, dmMain.Text[70], [i, cid]); //'Error: ReqCreatureOrGOId%d = %d, Location for creature not exists'
      end;
      MyTempQuery.Close;
    end;
    if cid<0 then
    begin
      MyTempQuery.SQL.Text:=Format('SELECT entry FROM `gameobject_template` WHERE `entry` = %d',[abs(cid)]);
      MyTempQuery.Open;
      if MyTempQuery.Eof then
        Add(1, dmMain.Text[71], [i,cid]) //'Error: ReqCreatureOrGOId%d = %d, but gameobject with this id is not exists'
      else
      begin
        /// location check
        MyTempQuery.Close;
        MyTempQuery.SQL.Text:=Format('SELECT `guid` FROM `gameobject` WHERE `id`=%d',[abs(cid)]);
        MyTempQuery.Open;
        if MyTempQuery.Eof then
          Add(1, dmMain.Text[72], [i, cid]); //'Error: ReqCreatureOrGOId%d = %d, Location for gameobject not exists'
      end;
      MyTempQuery.Close;
    end;
  end;

  Synchronize(UpdateCaption2);  if Terminated then Exit;


  // quest check end!
  MyQuery.Close;
  Add(0, '---------------------------------------------------');

  //'Check complete: %d errors, %d warnings'
  Add(0, dmMain.Text[73], [ErrCount, WarnCount]);
  Add(0, '');
end;

procedure TCheckQuestThread.SetQuestList(const Value: TList);
begin
  FQuestList := Value;
end;

procedure TCheckQuestThread.Prepare(Connection : TZConnection);
begin
  MyQuery := TZQuery.Create(nil);
  MyTempQuery := TZQuery.Create(nil);
  MyLootQuery := TZQuery.Create(nil);
  Report := TStringList.Create;
  MyQuery.Connection := Connection;
  MyTempQuery.Connection := Connection;
  MyLootQuery.Connection := Connection;
end;
             
procedure TCheckQuestThread.HandleThreadException;
begin
  CheckForm.Memo.Lines.Add(ErrorStr);
  CheckForm.Memo.Lines.Add('');
  CheckForm.Memo.SelStart := CheckForm.Memo.Perform(EM_LINEINDEX, CheckForm.Memo.Lines.Count, 0);
  CheckForm.Memo.Perform(EM_SCROLLCARET, 0, 0);
end;

constructor TCheckQuestThread.Create(Connection: TZConnection;
  List: TList; CreateSuspended: boolean);
begin
  inherited Create(CreateSuspended);
  Prepare(Connection);
  FQuestList:=List;
  OnTerminate := MyTerminate;
end;

procedure TCheckQuestThread.UpdateCaption2;
begin
  CheckForm.pbCheckQuest.StepIt;
                                  // 'Check quest (%d) : %d%%'
  CheckForm.Label1.Caption:=Format(dmMain.Text[74], [cq, Round((CheckForm.pbCheckQuest.Position*100)/CheckForm.pbCheckQuest.Max)]);
  if Report.Count > 0 then
  begin
    CheckForm.Memo.Lines.AddStrings(Report);
    CheckForm.Memo.SelStart := CheckForm.Memo.Perform(EM_LINEINDEX, CheckForm.Memo.Lines.Count, 0);
    CheckForm.Memo.Perform(EM_SCROLLCARET, 0, 0);
    Report.Clear;
  end;
end;

procedure TCheckQuestThread.UpdateCaption3;
begin
  if Report.Count > 0 then
  begin
    CheckForm.Memo.Lines.AddStrings(Report);
    CheckForm.Memo.SelStart := CheckForm.Memo.Perform(EM_LINEINDEX, CheckForm.Memo.Lines.Count, 0);
    CheckForm.Memo.Perform(EM_SCROLLCARET, 0, 0);
    Report.Clear;
  end;
  CheckForm.pbCheckQuest.Position:=0;
  CheckForm.Label1.Caption:=dmMain.Text[75]; //'Check quest colmpete'
end;

end.
