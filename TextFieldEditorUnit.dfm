object TextFieldEditorForm: TTextFieldEditorForm
  Left = 294
  Top = 168
  Caption = 'Text Field Editor'
  ClientHeight = 394
  ClientWidth = 516
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl: TPageControl
    Left = 0
    Top = 0
    Width = 516
    Height = 394
    ActivePage = TabSheet
    Align = alClient
    TabOrder = 0
    TabStop = False
    object TabSheet: TTabSheet
      Caption = 'Text'
      object Panel: TPanel
        Left = 0
        Top = 320
        Width = 508
        Height = 46
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 1
        DesignSize = (
          508
          46)
        object btOK: TButton
          Left = 345
          Top = 12
          Width = 75
          Height = 25
          Anchors = [akTop, akRight]
          Caption = 'OK'
          ModalResult = 1
          TabOrder = 0
        end
        object btCancel: TButton
          Left = 426
          Top = 12
          Width = 75
          Height = 25
          Anchors = [akTop, akRight]
          Cancel = True
          Caption = 'Cancel'
          ModalResult = 2
          TabOrder = 1
        end
      end
      object Memo: TMemo
        Left = 0
        Top = 0
        Width = 508
        Height = 320
        Align = alClient
        TabOrder = 0
        OnKeyDown = MemoKeyDown
      end
    end
  end
end
