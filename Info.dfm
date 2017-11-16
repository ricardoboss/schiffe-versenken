object WindowInfo: TWindowInfo
  Left = 668
  Top = 403
  ActiveControl = Button1
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Informationen'
  ClientHeight = 250
  ClientWidth = 300
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 0
    Top = 0
    Width = 300
    Height = 32
    Align = alTop
    Alignment = taCenter
    Caption = 'Schiffe versenken'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsUnderline]
    ParentFont = False
    Layout = tlCenter
  end
  object Label2: TLabel
    Left = 15
    Top = 100
    Width = 124
    Height = 30
    Align = alCustom
    Alignment = taCenter
    Caption = 'Programm && Design:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    Layout = tlCenter
  end
  object Label3: TLabel
    Left = 175
    Top = 100
    Width = 108
    Height = 30
    Align = alCustom
    Alignment = taCenter
    Caption = 'Ricardo Boss'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    Layout = tlCenter
  end
  object Label4: TLabel
    Left = 15
    Top = 150
    Width = 99
    Height = 30
    Align = alCustom
    Alignment = taCenter
    Caption = 'Musik && Sounds:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    Layout = tlCenter
  end
  object Label5: TLabel
    Left = 175
    Top = 150
    Width = 109
    Height = 30
    Align = alCustom
    Alignment = taCenter
    Caption = 'Fabian Beron'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    Layout = tlCenter
  end
  object Label6: TLabel
    Left = 15
    Top = 50
    Width = 49
    Height = 30
    Align = alCustom
    Alignment = taCenter
    Caption = 'Version:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    Layout = tlCenter
  end
  object Label7: TLabel
    Left = 175
    Top = 50
    Width = 41
    Height = 30
    Align = alCustom
    Alignment = taCenter
    Caption = '1.0.0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    Layout = tlCenter
  end
  object Button1: TButton
    Left = 100
    Top = 200
    Width = 100
    Height = 30
    Caption = 'Schlie'#223'en'
    TabOrder = 0
    OnClick = Button1Click
  end
end
