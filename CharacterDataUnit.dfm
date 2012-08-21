object CharacterDataForm: TCharacterDataForm
  Left = 387
  Top = 144
  Caption = 'Character Data'
  ClientHeight = 525
  ClientWidth = 630
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 484
    Width = 630
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      630
      41)
    object btOK: TButton
      Left = 467
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'OK'
      ModalResult = 1
      TabOrder = 0
    end
    object btCancel: TButton
      Left = 547
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
  object vleMain: TValueListEditor
    Left = 0
    Top = 0
    Width = 630
    Height = 484
    Align = alClient
    FixedColor = cl3DLight
    FixedCols = 1
    TabOrder = 1
    ColWidths = (
      309
      315)
  end
end
