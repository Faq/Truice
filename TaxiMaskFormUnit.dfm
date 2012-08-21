object TaxiMaskForm: TTaxiMaskForm
  Left = 350
  Top = 202
  Caption = 'Taxi Mask'
  ClientHeight = 456
  ClientWidth = 500
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 415
    Width = 500
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      500
      41)
    object btOK: TButton
      Left = 337
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'OK'
      ModalResult = 1
      TabOrder = 0
    end
    object btCancel: TButton
      Left = 417
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
    Width = 500
    Height = 415
    Align = alClient
    FixedColor = cl3DLight
    FixedCols = 1
    TabOrder = 1
    ColWidths = (
      309
      185)
  end
end
