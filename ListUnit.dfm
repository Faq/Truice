object ListForm: TListForm
  Left = 532
  Top = 178
  BorderStyle = bsDialog
  Caption = 'List'
  ClientHeight = 452
  ClientWidth = 393
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 411
    Width = 393
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      393
      41)
    object btOK: TButton
      Left = 230
      Top = 9
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'OK'
      Enabled = False
      ModalResult = 1
      TabOrder = 0
    end
    object btCancel: TButton
      Left = 311
      Top = 9
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 1
    end
  end
  object pnSearch: TPanel
    Left = 0
    Top = 0
    Width = 393
    Height = 46
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    object edSearchMask: TLabeledEdit
      Left = 6
      Top = 18
      Width = 377
      Height = 21
      EditLabel.Width = 62
      EditLabel.Height = 13
      EditLabel.Caption = 'Search mask'
      TabOrder = 0
      OnChange = edSearchMaskChange
    end
  end
  object lvList: TTntListView
    Left = 0
    Top = 46
    Width = 393
    Height = 365
    Align = alClient
    Columns = <
      item
        Caption = 'ID'
      end
      item
        Caption = 'Value'
        Width = 300
      end>
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = '@Arial Unicode MS'
    Font.Style = []
    HideSelection = False
    ReadOnly = True
    RowSelect = True
    ParentFont = False
    SortType = stData
    TabOrder = 0
    ViewStyle = vsReport
    OnChange = lvList2Change
    OnColumnClick = lvListColumnClick
    OnDblClick = lvList2DblClick
  end
end
