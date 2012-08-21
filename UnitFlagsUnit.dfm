object UnitFlagsForm: TUnitFlagsForm
  Left = 371
  Top = 279
  BorderStyle = bsDialog
  Caption = 'Unit Flags'
  ClientHeight = 274
  ClientWidth = 361
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  DesignSize = (
    361
    274)
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel: TBevel
    Left = 0
    Top = 232
    Width = 361
    Height = 42
    Align = alBottom
    Shape = bsTopLine
    ExplicitTop = 267
    ExplicitWidth = 530
  end
  object btCancel: TButton
    Left = 278
    Top = 241
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 0
  end
  object btOK: TButton
    Left = 197
    Top = 241
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
    OnClick = btOKClick
  end
  object clbMain: TCheckListBox
    Left = 8
    Top = 8
    Width = 345
    Height = 218
    Columns = 2
    ItemHeight = 13
    Items.Strings = (
      'UNKNOWN7'
      'NON_ATTACKABLE'
      'DISABLE_MOVE'
      'UNKNOWN1'
      'RENAME'
      'RESTING'
      'UNKNOWN9'
      'UNKNOWN10'
      'UNKNOWN2'
      'UNKNOWN11'
      'LOOTING'
      'PET_IN_COMBAT'
      'PVP'
      'SILENCED'
      'UNKNOWN4'
      'UNKNOWN13'
      'UNKNOWN14'
      'PACIFIED'
      'DISABLE_ROTATE'
      'IN_COMBAT'
      'UNKNOWN15'
      'DISARMED'
      'CONFUSED'
      'FLEEING'
      'UNKNOWN5'
      'NOT_SELECTABLE'
      'SKINNABLE'
      'MOUNT'
      'UNKNOWN17'
      'UNKNOWN6'
      'SHEATHE'
      'UNKNOWN18')
    TabOrder = 2
  end
end
