object ItemLootForm: TItemLootForm
  Left = 203
  Top = 149
  BorderStyle = bsDialog
  Caption = 'Item Loot'
  ClientHeight = 437
  ClientWidth = 773
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
  object Panel1: TPanel
    Left = 0
    Top = 396
    Width = 773
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      773
      41)
    object btClose: TButton
      Left = 690
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = 'Close'
      ModalResult = 2
      TabOrder = 0
    end
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 773
    Height = 396
    ActivePage = tsLoot
    Align = alClient
    TabOrder = 1
    object tsLoot: TTabSheet
      Caption = 'Item Loot'
      object lvItemLoot: TJvListView
        Left = 0
        Top = 0
        Width = 765
        Height = 368
        Align = alClient
        BorderStyle = bsNone
        Columns = <
          item
          end
          item
          end
          item
          end
          item
          end
          item
          end
          item
          end
          item
          end
          item
          end
          item
          end
          item
          end
          item
            Width = 120
          end
          item
            Width = 120
          end>
        HideSelection = False
        ReadOnly = True
        RowSelect = True
        TabOrder = 0
        ViewStyle = vsReport
        AutoSelect = False
        ColumnsOrder = '0=50,1=50,2=50,3=50,4=50,5=50,6=50,7=50,8=50,9=50,10=120,11=120'
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
          end
          item
          end
          item
          end
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
    end
  end
  object MyQuery: TZQuery
    Connection = MainForm.MyTrinityConnection
    Params = <>
    Left = 65
    Top = 81
  end
end
