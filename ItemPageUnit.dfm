object ItemPageForm: TItemPageForm
  Left = 268
  Top = 147
  BorderStyle = bsDialog
  Caption = 'ItemPage'
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
        Height = 41
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        DesignSize = (
          490
          41)
        object edPageID: TLabeledEdit
          Left = 8
          Top = 16
          Width = 121
          Height = 21
          EditLabel.Width = 39
          EditLabel.Height = 13
          EditLabel.Caption = 'Page ID'
          TabOrder = 0
        end
        object btSearch: TButton
          Left = 411
          Top = 13
          Width = 75
          Height = 25
          Anchors = [akTop, akRight]
          Caption = 'Search'
          Default = True
          TabOrder = 1
          OnClick = btSearchClick
        end
        object edText: TLabeledEdit
          Left = 136
          Top = 16
          Width = 265
          Height = 21
          EditLabel.Width = 21
          EditLabel.Height = 13
          EditLabel.Caption = 'Text'
          TabOrder = 2
        end
      end
      object lvPageItem: TJvListView
        Left = 0
        Top = 41
        Width = 490
        Height = 257
        Align = alClient
        BorderStyle = bsNone
        Columns = <
          item
            Caption = 'Page ID'
            Width = 60
          end
          item
            Caption = 'Text'
            Width = 330
          end
          item
            Caption = 'NextPage'
            Width = 80
          end>
        HideSelection = False
        ReadOnly = True
        RowSelect = True
        TabOrder = 1
        ViewStyle = vsReport
        OnChange = lvPageItemChange
        OnDblClick = lvPageItemDblClick
        ColumnsOrder = '0=60,1=330,2=80'
        Groups = <>
        ExtendedColumns = <
          item
          end
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
    Left = 412
    Top = 80
  end
end
