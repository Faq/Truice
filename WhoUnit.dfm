object WhoQuestForm: TWhoQuestForm
  Left = 280
  Top = 208
  BorderStyle = bsDialog
  Caption = 'Quester '
  ClientHeight = 443
  ClientWidth = 563
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
    Width = 563
    Height = 402
    ActivePage = tsSearch
    Align = alClient
    TabOrder = 0
    object tsSearch: TTabSheet
      Caption = 'Search'
      object pnSearch: TPanel
        Left = 0
        Top = 0
        Width = 555
        Height = 97
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        DesignSize = (
          555
          97)
        object edWhoID: TLabeledEdit
          Left = 8
          Top = 66
          Width = 121
          Height = 21
          EditLabel.Width = 11
          EditLabel.Height = 13
          EditLabel.Caption = 'ID'
          TabOrder = 0
        end
        object edWhoName: TLabeledEdit
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
          Left = 476
          Top = 64
          Width = 75
          Height = 25
          Anchors = [akTop, akRight]
          Caption = 'Search'
          Default = True
          TabOrder = 2
          OnClick = btSearchClick
        end
        object rgTypeOfWho: TRadioGroup
          Left = 8
          Top = 0
          Width = 537
          Height = 49
          Caption = 'Quester type'
          Columns = 3
          ItemIndex = 0
          Items.Strings = (
            'creature'
            'gameobject'
            'item')
          TabOrder = 3
        end
      end
      object lvWho: TJvListView
        Left = 0
        Top = 97
        Width = 555
        Height = 277
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
        Groups = <>
        HideSelection = False
        ReadOnly = True
        RowSelect = True
        TabOrder = 1
        ViewStyle = vsReport
        OnChange = lvWhoChange
        OnDblClick = lvWhoDblClick
        ColumnsOrder = '0=60,1=300'
        ExtendedColumns = <
          item
          end
          item
          end>
        ExplicitTop = 95
      end
      object Panel2: TPanel
        Left = 0
        Top = 97
        Width = 555
        Height = 0
        Align = alTop
        BevelOuter = bvLowered
        Color = clInfoBk
        TabOrder = 2
        Visible = False
        object Label1: TLabel
          Left = 7
          Top = 6
          Width = 536
          Height = 26
          Caption = 
            '   At this page you can choose a Quester. Set quester type, ente' +
            'r ID or Name of quester and press "Search". Select found quester' +
            ' in list and press "OK" button.'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          ParentFont = False
          Layout = tlCenter
          WordWrap = True
        end
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 402
    Width = 563
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      563
      41)
    object btOK: TButton
      Left = 400
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
      Left = 480
      Top = 8
      Width = 75
      Height = 25
      Cancel = True
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 1
    end
    object btBrowseSite: TButton
      Left = 88
      Top = 8
      Width = 75
      Height = 25
      Caption = 'BrowseSite'
      Enabled = False
      TabOrder = 2
      OnClick = btBrowseSiteClick
    end
    object btEdit: TButton
      Left = 8
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Edit'
      Enabled = False
      TabOrder = 3
      OnClick = btEditClick
    end
    object btBrowseQuesterPopup: TBitBtn
      Left = 162
      Top = 8
      Width = 17
      Height = 25
      DoubleBuffered = True
      Enabled = False
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
      ParentDoubleBuffered = False
      PopupMenu = pmBrowseSite
      TabOrder = 4
      OnClick = btBrowseQuesterPopupClick
    end
  end
  object MyQuery: TZQuery
    Connection = MainForm.MyTrinityConnection
    Params = <>
    Left = 464
    Top = 72
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
  end
end
