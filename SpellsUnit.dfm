object SpellsForm: TSpellsForm
  Left = 288
  Top = 245
  BorderStyle = bsDialog
  Caption = 'Spells'
  ClientHeight = 453
  ClientWidth = 392
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 392
    Height = 412
    ActivePage = tsSearch
    Align = alClient
    TabOrder = 0
    object tsSearch: TTabSheet
      Caption = 'Search'
      object pnSearch: TPanel
        Left = 0
        Top = 0
        Width = 384
        Height = 41
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        object edSearchMask: TLabeledEdit
          Left = 0
          Top = 14
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
        Top = 41
        Width = 384
        Height = 343
        Align = alClient
        BorderStyle = bsNone
        Columns = <
          item
            Caption = 'Spell ID'
            Width = 70
          end
          item
            Caption = 'Spell Name'
            Width = 290
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
        TabOrder = 1
        ViewStyle = vsReport
        OnChange = lvListChange
        OnColumnClick = lvListColumnClick
        OnDblClick = lvListDblClick
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 412
    Width = 392
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      392
      41)
    object btOK: TButton
      Left = 229
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
      Left = 312
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
end
