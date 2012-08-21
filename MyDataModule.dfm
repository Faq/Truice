object dmMain: TdmMain
  OldCreateOrder = False
  OnDestroy = DataModuleDestroy
  Height = 352
  Width = 426
  object ActionList: TActionList
    Left = 104
    Top = 40
    object BrowseURL: TBrowseURL
      Category = 'Internet'
      Caption = '&Browse URL'
      Hint = 'Browse URL'
    end
  end
  object MyQuery: TZQuery
    Params = <>
    Left = 128
    Top = 144
  end
end
