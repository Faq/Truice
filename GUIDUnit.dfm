object GUIDForm: TGUIDForm
  Left = 369
  Top = 146
  BorderStyle = bsDialog
  Caption = 'Get GUID'
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
        Height = 57
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        DesignSize = (
          497
          57)
        object edID: TLabeledEdit
          Left = 8
          Top = 22
          Width = 121
          Height = 21
          EditLabel.Width = 11
          EditLabel.Height = 13
          EditLabel.Caption = 'ID'
          TabOrder = 0
        end
        object edName: TLabeledEdit
          Left = 136
          Top = 22
          Width = 265
          Height = 21
          EditLabel.Width = 28
          EditLabel.Height = 13
          EditLabel.Caption = 'Name'
          TabOrder = 1
        end
        object btSearch: TButton
          Left = 418
          Top = 20
          Width = 75
          Height = 25
          Anchors = [akTop, akRight]
          Caption = 'Search'
          Default = True
          TabOrder = 2
          OnClick = btSearchClick
        end
      end
      object lvGUID: TJvListView
        Left = 0
        Top = 177
        Width = 497
        Height = 207
        Align = alClient
        BorderStyle = bsNone
        Columns = <
          item
            Caption = 'GUID'
            Width = 60
          end
          item
            Caption = 'map'
            Width = 80
          end
          item
            Caption = 'x'
            Width = 80
          end
          item
            Caption = 'y'
            Width = 80
          end
          item
            Caption = 'z'
            Width = 80
          end>
        HideSelection = False
        ReadOnly = True
        RowSelect = True
        TabOrder = 1
        ViewStyle = vsReport
        OnChange = lvGUIDChange
        OnDblClick = lvGUIDDblClick
        OnSelectItem = lvGUIDSelectItem
        AutoSelect = False
        ColumnsOrder = '0=60,1=80,2=80,3=80,4=80'
        Groups = <>
        ExtendedColumns = <
          item
          end
          item
          end
          item
          end
          item
          end
          item
          end>
      end
      object lvCreatureOrGO: TJvListView
        Left = 0
        Top = 57
        Width = 497
        Height = 120
        Align = alTop
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
        TabOrder = 2
        ViewStyle = vsReport
        OnSelectItem = lvCreatureOrGOSelectItem
        AutoSelect = False
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
  end
  object MyQuery: TZQuery
    Connection = MainForm.MyTrinityConnection
    Params = <>
    Left = 328
    Top = 24
  end
end
