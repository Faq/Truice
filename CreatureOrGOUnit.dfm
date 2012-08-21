object CreatureOrGOForm: TCreatureOrGOForm
  Left = 281
  Top = 182
  BorderStyle = bsDialog
  Caption = 'Creature or GO'
  ClientHeight = 453
  ClientWidth = 505
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 505
    Height = 412
    ActivePage = tsSearch
    Align = alClient
    TabOrder = 0
    object tsSearch: TTabSheet
      Caption = 'Search'
      object pnSearch: TPanel
        Left = 0
        Top = 0
        Width = 497
        Height = 97
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        DesignSize = (
          497
          97)
        object edID: TLabeledEdit
          Left = 8
          Top = 66
          Width = 121
          Height = 21
          EditLabel.Width = 11
          EditLabel.Height = 13
          EditLabel.Caption = 'ID'
          TabOrder = 0
        end
        object edName: TLabeledEdit
          Left = 136
          Top = 66
          Width = 265
          Height = 21
          EditLabel.Width = 28
          EditLabel.Height = 13
          EditLabel.Caption = 'Name'
          TabOrder = 1
        end
        object btSearch: TButton
          Left = 418
          Top = 64
          Width = 75
          Height = 25
          Anchors = [akTop, akRight]
          Caption = 'Search'
          Default = True
          TabOrder = 2
          OnClick = btSearchClick
        end
        object rgCreatureOrGO: TRadioGroup
          Left = 8
          Top = 0
          Width = 481
          Height = 49
          Caption = 'Creature or GO?'
          Columns = 3
          ItemIndex = 0
          Items.Strings = (
            'creature'
            'gameobject')
          TabOrder = 3
        end
      end
      object lvCreatureOrGO: TJvListView
        Left = 0
        Top = 97
        Width = 497
        Height = 287
        Align = alClient
        BorderStyle = bsNone
        Columns = <
          item
            Caption = 'ID'
            Width = 60
          end
          item
            Caption = 'Name'
            Width = 300
          end>
        HideSelection = False
        ReadOnly = True
        RowSelect = True
        TabOrder = 1
        ViewStyle = vsReport
        OnChange = lvCreatureOrGOChange
        OnDblClick = lvCreatureOrGODblClick
        ColumnsOrder = '0=60,1=300'
        Groups = <>
        ExtendedColumns = <
          item
          end
          item
          end>
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 412
    Width = 505
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      505
      41)
    object btOK: TButton
      Left = 342
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'OK'
      Enabled = False
      ModalResult = 1
      TabOrder = 0
    end
    object btCancel: TButton
      Left = 425
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 1
    end
    object btBrowseSite: TButton
      Left = 96
      Top = 8
      Width = 75
      Height = 25
      Caption = 'BrowseSite'
      Enabled = False
      TabOrder = 2
      OnClick = btBrowseSiteClick
    end
    object btEditCreatureOrGO: TButton
      Left = 8
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Edit'
      Enabled = False
      TabOrder = 3
      OnClick = btEditCreatureOrGOClick
    end
    object btBrowseCreatureOrGOPopup: TBitBtn
      Left = 170
      Top = 8
      Width = 17
      Height = 25
      Enabled = False
      PopupMenu = pmBrowseSite
      TabOrder = 4
      OnClick = btBrowseCreatureOrGOPopupClick
      Glyph.Data = {
        32010000424D3201000000000000360000002800000009000000090000000100
        180000000000FC00000000000000000000000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFF0000
        00FFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFF000000000000000000
        FFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF000000000000000000000000000000FF
        FFFFFFFFFF00FFFFFF000000000000000000000000000000000000000000FFFF
        FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00}
    end
  end
  object MyQuery: TZQuery
    Connection = MainForm.MyTrinityConnection
    Params = <>
    Left = 328
    Top = 24
  end
  object pmBrowseSite: TPopupMenu
    Left = 359
    Top = 26
    object pmwowhead: TMenuItem
      Caption = 'wowhead'
      OnClick = pmSiteClick
    end
    object pmthottbot: TMenuItem
      Caption = 'thottbot'
      OnClick = pmSiteClick
    end
    object pmallakhazam: TMenuItem
      Caption = 'allakhazam'
      OnClick = pmSiteClick
    end
    object pmwowdb: TMenuItem
      Caption = 'wowdb'
      OnClick = pmSiteClick
    end
    object pmruwowhead: TMenuItem
      Caption = 'ruwowhead'
    end
  end
end
