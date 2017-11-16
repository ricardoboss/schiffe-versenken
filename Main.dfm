object Window: TWindow
  Left = 1991
  Top = 151
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Schiffe Versenken'
  ClientHeight = 650
  ClientWidth = 290
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = Menu
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object ComputerBoard: TGroupBox
    Left = 0
    Top = 0
    Width = 290
    Height = 300
    Caption = 'Computer'
    TabOrder = 0
  end
  object PlayerBoard: TGroupBox
    Left = 0
    Top = 350
    Width = 290
    Height = 300
    Caption = 'Spieler'
    TabOrder = 1
  end
  object MessageBox: TGroupBox
    Left = 0
    Top = 304
    Width = 290
    Height = 41
    Caption = 'Nachrichten'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    object Messages: TLabel
      Left = 16
      Top = 16
      Width = 3
      Height = 13
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
  end
  object Menu: TMainMenu
    Left = 293
    Top = 5
    object MenuGame: TMenuItem
      Caption = 'Spiel'
      object MenuNewGame: TMenuItem
        Caption = 'Neues Spiel'
        OnClick = MenuNewGameClick
      end
      object MenuClose: TMenuItem
        Caption = 'Beenden'
        OnClick = MenuCloseClick
      end
    end
    object MenuSettings: TMenuItem
      Caption = 'Einstellungen'
      object MenuShipDirection: TMenuItem
        Caption = 'Schiff Richtung'
        object ShipDirectionUpwards: TMenuItem
          Caption = 'Hoch'
          OnClick = ShipDirectionUpwardsClick
        end
        object ShipDirectionRightwards: TMenuItem
          Caption = 'Rechts'
          OnClick = ShipDirectionRightwardsClick
        end
        object ShipDirectionDownwards: TMenuItem
          Caption = 'Runter'
          OnClick = ShipDirectionDownwardsClick
        end
        object ShipDirectionLeftwards: TMenuItem
          Caption = 'Links'
          OnClick = ShipDirectionLeftwardsClick
        end
      end
      object MenuDifficulty: TMenuItem
        Caption = 'Computer Schwierigkeit'
        object DifficultyEasy: TMenuItem
          Caption = 'Leicht'
          OnClick = DifficultyEasyClick
        end
        object DifficultyMiddle: TMenuItem
          Caption = 'Mittel'
          OnClick = DifficultyMiddleClick
        end
        object DifficultyHard: TMenuItem
          Caption = 'Schwer'
          OnClick = DifficultyHardClick
        end
      end
    end
    object MenuInfo: TMenuItem
      Caption = #220'ber'
      OnClick = MenuInfoClick
    end
  end
end
