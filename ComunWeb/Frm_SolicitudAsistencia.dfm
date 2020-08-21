object FrmSolicitudAsistencia: TFrmSolicitudAsistencia
  Left = 0
  Top = 0
  ClientHeight = 209
  ClientWidth = 483
  Caption = #191'Alguna duda o consulta? Nosotros te llamamos'
  BorderStyle = bsSingle
  OldCreateOrder = False
  BorderIcons = [biSystemMenu, biMinimize]
  MonitoredKeys.Keys = <>
  OnCreate = FormCreate
  DesignSize = (
    483
    209)
  PixelsPerInch = 96
  TextHeight = 13
  object CONTACTO: TUniEdit
    Left = 11
    Top = 60
    Width = 343
    Height = 21
    Hint = ''
    Text = ''
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 0
    ExplicitWidth = 324
  end
  object TELEFONO: TUniEdit
    Left = 368
    Top = 60
    Width = 107
    Height = 21
    Hint = ''
    Text = ''
    Anchors = [akTop, akRight]
    TabOrder = 1
    ExplicitLeft = 349
  end
  object MOTIVO: TUniEdit
    Left = 11
    Top = 102
    Width = 464
    Height = 21
    Hint = ''
    MaxLength = 40
    Text = ''
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 2
    ExplicitWidth = 445
  end
  object UniToolBar1: TUniToolBar
    Left = 0
    Top = 0
    Width = 483
    Height = 35
    Hint = ''
    ButtonHeight = 33
    ButtonWidth = 34
    ShowCaptions = True
    TabOrder = 4
    ParentColor = False
    Color = clBtnFace
    ParentFont = False
    Font.Color = 14062137
    Font.Height = -24
    Font.Name = 'cai'
    ExplicitWidth = 464
    object UBAceptar: TUniToolButton
      Left = 0
      Top = 0
      Hint = 'Aceptar'
      ShowHint = True
      ParentShowHint = False
      Caption = 'V'
      TabOrder = 1
      OnClick = UBAceptarClick
    end
    object UBSalir: TUniToolButton
      Left = 34
      Top = 0
      Hint = 'Salir'
      ShowHint = True
      ParentShowHint = False
      Caption = 's'
      TabOrder = 2
      OnClick = UBSalirClick
    end
  end
  object Label1: TUniLabel
    Left = 11
    Top = 45
    Width = 99
    Height = 13
    Hint = ''
    Caption = 'Persona de contacto'
    TabOrder = 5
  end
  object Label2: TUniLabel
    Left = 368
    Top = 45
    Width = 42
    Height = 13
    Hint = ''
    Caption = 'Tel'#233'fono'
    Anchors = [akTop, akRight]
    TabOrder = 6
    ExplicitLeft = 349
  end
  object Label3: TUniLabel
    Left = 11
    Top = 87
    Width = 32
    Height = 13
    Hint = ''
    Caption = 'Motivo'
    TabOrder = 7
  end
  object Panel1: TUniPanel
    Left = 0
    Top = 144
    Width = 483
    Height = 65
    Hint = ''
    Align = alBottom
    TabOrder = 3
    TabStop = False
    Caption = ''
    ParentBackground = True
    ExplicitWidth = 464
    object Memo1: TUniMemo
      Left = 11
      Top = 3
      Width = 469
      Height = 62
      Hint = ''
      ShowHint = True
      ParentShowHint = False
      BorderStyle = ubsNone
      Lines.Strings = (
        
          'Indica persona de contacto, tel'#233'fono, motivo de la llamada y pul' +
          'sa el bot'#243'n "Enviar".'
        
          'Nuestros t'#233'cnicos se podr'#225'n en contacto tan pronto como sea posi' +
          'ble.')
      ParentFont = False
      Color = clBtnFace
      TabOrder = 0
    end
  end
  object ADWebCAI: TFDConnection
    Params.Strings = (
      
        'Database=www.caisistemas.es/3060:C:\INETPUB\VHOSTS\CAISISTEMAS.E' +
        'S\PRIVATE\UNID\DATA\ATENCION_CLIENTE.GDB'
      'User_Name=SYSDBA'
      'Password=Xau@37.'
      'CharacterSet=ISO8859_1'
      'DriverID=FB')
    LoginPrompt = False
    Left = 320
    Top = 32
  end
end
