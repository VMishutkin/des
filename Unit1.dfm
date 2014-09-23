object Form1: TForm1
  Left = 266
  Top = 123
  Width = 659
  Height = 368
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 142
    Height = 20
    Caption = #1048#1089#1093#1086#1076#1085#1099#1081' '#1090#1077#1082#1089#1090':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 8
    Top = 64
    Width = 51
    Height = 20
    Caption = #1050#1083#1102#1095':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 8
    Top = 96
    Width = 203
    Height = 20
    Caption = #1047#1072#1096#1080#1092#1088#1086#1074#1072#1085#1085#1099#1081' '#1090#1077#1082#1089#1090':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label4: TLabel
    Left = 8
    Top = 184
    Width = 291
    Height = 20
    Caption = #1048#1089#1093#1086#1076#1085#1099#1081' '#1047#1072#1096#1080#1092#1088#1086#1074#1072#1085#1085#1099#1081' '#1090#1077#1082#1089#1090':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label5: TLabel
    Left = 8
    Top = 240
    Width = 51
    Height = 20
    Caption = #1050#1083#1102#1095':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label6: TLabel
    Left = 8
    Top = 272
    Width = 211
    Height = 20
    Caption = #1056#1072#1089#1096#1080#1092#1088#1086#1074#1072#1085#1085#1099#1081' '#1090#1077#1082#1089#1090':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label7: TLabel
    Left = 203
    Top = 64
    Width = 3
    Height = 13
  end
  object Label8: TLabel
    Left = 168
    Top = 8
    Width = 3
    Height = 13
  end
  object txtKey: TEdit
    Left = 64
    Top = 64
    Width = 121
    Height = 21
    MaxLength = 8
    TabOrder = 0
    Text = '12345678'
  end
  object cmdCode: TButton
    Left = 288
    Top = 64
    Width = 75
    Height = 25
    Caption = #1064#1080#1092#1088#1086#1074#1072#1090#1100
    TabOrder = 1
    OnClick = cmdCodeClick
  end
  object Edit1: TEdit
    Left = 64
    Top = 240
    Width = 121
    Height = 21
    MaxLength = 8
    TabOrder = 2
    Text = '12345678'
  end
  object Button1: TButton
    Left = 272
    Top = 240
    Width = 97
    Height = 25
    Caption = #1056#1072#1089#1096#1080#1092#1088#1086#1074#1072#1090#1100
    TabOrder = 3
    OnClick = Button1Click
  end
  object InText: TEdit
    Left = 8
    Top = 32
    Width = 633
    Height = 21
    TabOrder = 4
    Text = #1042#1089#1077' '#1086#1090#1073#1086#1083#1080#1090' '#1080' '#1084#1091#1076#1088#1099#1081' '#1075#1086#1074#1086#1088#1080#1090
  end
  object OutText: TEdit
    Left = 8
    Top = 120
    Width = 633
    Height = 21
    TabOrder = 5
  end
  object Memo1: TEdit
    Left = 8
    Top = 208
    Width = 633
    Height = 21
    TabOrder = 6
  end
  object Memo2: TEdit
    Left = 8
    Top = 296
    Width = 633
    Height = 21
    TabOrder = 7
  end
end
