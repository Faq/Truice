object ItemForm: TItemForm
  Left = 241
  Top = 174
  BorderStyle = bsDialog
  Caption = 'Item'
  ClientHeight = 367
  ClientWidth = 498
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
  object Panel1: TPanel
    Left = 0
    Top = 326
    Width = 498
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      498
      41)
    object btOK: TButton
      Left = 335
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'OK'
      Enabled = False
      ModalResult = 1
      TabOrder = 0
      OnClick = btOKClick
    end
    object btCancel: TButton
      Left = 415
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
      Left = 8
      Top = 8
      Width = 75
      Height = 25
      Caption = 'BrowseSite'
      Enabled = False
      TabOrder = 2
      OnClick = btBrowseSiteClick
    end
    object btLoot: TButton
      Left = 109
      Top = 8
      Width = 75
      Height = 25
      Caption = 'View Loot'
      Enabled = False
      TabOrder = 3
      OnClick = btLootClick
    end
    object btBrowseItemPopup: TBitBtn
      Left = 82
      Top = 8
      Width = 17
      Height = 25
      Enabled = False
      PopupMenu = pmBrowseSite
      TabOrder = 4
      OnClick = btBrowseItemPopupClick
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
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 498
    Height = 326
    ActivePage = tsSearch
    Align = alClient
    TabOrder = 1
    object tsSearch: TTabSheet
      Caption = 'Search'
      object pnSearch: TPanel
        Left = 0
        Top = 0
        Width = 490
        Height = 49
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        DesignSize = (
          490
          49)
        object edItemID: TLabeledEdit
          Left = 8
          Top = 16
          Width = 121
          Height = 21
          EditLabel.Width = 34
          EditLabel.Height = 13
          EditLabel.Caption = 'Item ID'
          TabOrder = 0
        end
        object edItemName: TLabeledEdit
          Left = 136
          Top = 16
          Width = 265
          Height = 21
          EditLabel.Width = 28
          EditLabel.Height = 13
          EditLabel.Caption = 'Name'
          TabOrder = 1
        end
        object btSearch: TButton
          Left = 411
          Top = 16
          Width = 75
          Height = 25
          Anchors = [akTop, akRight]
          Caption = 'Search'
          Default = True
          TabOrder = 2
          OnClick = btSearchClick
        end
      end
      object lvItem: TJvListView
        Left = 0
        Top = 49
        Width = 490
        Height = 249
        Align = alClient
        BorderStyle = bsNone
        Columns = <
          item
            Caption = 'Item ID'
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
        OnChange = lvItemChange
        OnDblClick = lvItemDblClick
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
  object MyQuery: TZQuery
    Connection = MainForm.MyTrinityConnection
    Params = <>
    Left = 276
    Top = 64
  end
  object pmBrowseSite: TPopupMenu
    Left = 424
    Top = 82
    object pmwowhead: TMenuItem
      Caption = 'wowhead'
      OnClick = pmSiteClick
    end
    object pmruwowhead: TMenuItem
      Caption = 'ruwowhead'
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
  end
end
