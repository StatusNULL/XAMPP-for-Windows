object fConfigUserDefined: TfConfigUserDefined
  Left = 487
  Top = 248
  Caption = 'User-defined log/config-files'
  ClientHeight = 901
  ClientWidth = 728
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  DesignSize = (
    728
    901)
  PixelsPerInch = 120
  TextHeight = 17
  object lHeader1: TLabel
    Left = 10
    Top = 10
    Width = 385
    Height = 17
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 
      'Enter user defined files. Files must be relative to xampp-basedi' +
      'r!'
  end
  object lHeader2: TLabel
    Left = 10
    Top = 35
    Width = 283
    Height = 17
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'Example: "apache\conf\extra\httpd-info.conf"'
  end
  object lConfig: TLabel
    Left = 22
    Top = 78
    Width = 48
    Height = 18
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'Config'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lLogs: TLabel
    Left = 366
    Top = 78
    Width = 35
    Height = 18
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'Logs'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object bSave: TBitBtn
    Left = 620
    Top = 858
    Width = 98
    Height = 33
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Anchors = [akRight, akBottom]
    Caption = 'Save'
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      3333333333333333333333330000333333333333333333333333F33333333333
      00003333344333333333333333388F3333333333000033334224333333333333
      338338F3333333330000333422224333333333333833338F3333333300003342
      222224333333333383333338F3333333000034222A22224333333338F338F333
      8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
      33333338F83338F338F33333000033A33333A222433333338333338F338F3333
      0000333333333A222433333333333338F338F33300003333333333A222433333
      333333338F338F33000033333333333A222433333333333338F338F300003333
      33333333A222433333333333338F338F00003333333333333A22433333333333
      3338F38F000033333333333333A223333333333333338F830000333333333333
      333A333333333333333338330000333333333333333333333333333333333333
      0000}
    ModalResult = 1
    NumGlyphs = 2
    TabOrder = 0
    OnClick = bSaveClick
  end
  object bAbort: TBitBtn
    Left = 514
    Top = 858
    Width = 98
    Height = 33
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Anchors = [akRight, akBottom]
    Kind = bkAbort
    NumGlyphs = 2
    TabOrder = 1
    OnClick = bAbortClick
  end
  object gbApache: TGroupBox
    Left = 10
    Top = 103
    Width = 708
    Height = 144
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'Apache'
    TabOrder = 2
    object mConfigApache: TMemo
      Left = 12
      Top = 22
      Width = 341
      Height = 111
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      ScrollBars = ssBoth
      TabOrder = 0
    end
    object mLogsApache: TMemo
      Left = 356
      Top = 22
      Width = 341
      Height = 111
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      ScrollBars = ssBoth
      TabOrder = 1
    end
  end
  object gbMySQL: TGroupBox
    Left = 10
    Top = 255
    Width = 708
    Height = 144
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'MySQL'
    TabOrder = 3
    object mConfigMySQL: TMemo
      Left = 12
      Top = 22
      Width = 341
      Height = 111
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      ScrollBars = ssBoth
      TabOrder = 0
    end
    object mLogsMySQL: TMemo
      Left = 356
      Top = 22
      Width = 341
      Height = 111
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      ScrollBars = ssBoth
      TabOrder = 1
    end
  end
  object gbFileZilla: TGroupBox
    Left = 10
    Top = 407
    Width = 708
    Height = 144
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'FileZilla'
    TabOrder = 4
    object mConfigFilezilla: TMemo
      Left = 12
      Top = 22
      Width = 341
      Height = 111
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      ScrollBars = ssBoth
      TabOrder = 0
    end
    object mLogsFileZilla: TMemo
      Left = 356
      Top = 22
      Width = 341
      Height = 111
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      ScrollBars = ssBoth
      TabOrder = 1
    end
  end
  object gbMercury: TGroupBox
    Left = 10
    Top = 558
    Width = 708
    Height = 144
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'Mercury'
    TabOrder = 5
    object mConfigMercury: TMemo
      Left = 12
      Top = 22
      Width = 341
      Height = 111
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      ScrollBars = ssBoth
      TabOrder = 0
    end
    object mLogsMercury: TMemo
      Left = 356
      Top = 22
      Width = 341
      Height = 111
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      ScrollBars = ssBoth
      TabOrder = 1
    end
  end
  object gbTomcat: TGroupBox
    Left = 10
    Top = 710
    Width = 708
    Height = 144
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'Mercury'
    TabOrder = 6
    object mConfigTomcat: TMemo
      Left = 12
      Top = 22
      Width = 341
      Height = 111
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      ScrollBars = ssBoth
      TabOrder = 0
    end
    object mLogsTomcat: TMemo
      Left = 356
      Top = 22
      Width = 341
      Height = 111
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      ScrollBars = ssBoth
      TabOrder = 1
    end
  end
end
