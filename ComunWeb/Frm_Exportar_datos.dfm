object FrmExportarDatos: TFrmExportarDatos
  Left = 0
  Top = 0
  ClientHeight = 131
  ClientWidth = 527
  Caption = 'Exportaci'#243'n de toda la base de datos'
  OldCreateOrder = False
  MonitoredKeys.Keys = <>
  OnAjaxEvent = UniFormAjaxEvent
  PixelsPerInch = 96
  TextHeight = 13
  object UniToolBar1: TUniToolBar
    Left = 0
    Top = 0
    Width = 527
    Height = 35
    Hint = ''
    ButtonHeight = 33
    ButtonWidth = 34
    ShowCaptions = True
    TabOrder = 0
    ParentColor = False
    Color = clBtnFace
    ParentFont = False
    Font.Color = 14062137
    Font.Height = -24
    Font.Name = 'cai'
    object UBAceptar: TUniToolButton
      Left = 0
      Top = 0
      Hint = 'Exportar datos'
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
  object RadioGroup1: TUniRadioGroup
    Left = 0
    Top = 35
    Width = 527
    Height = 96
    Hint = ''
    Margins.Left = 10
    Margins.Right = 10
    Items.Strings = (
      'Ficheros FIREBIRD'
      'Ficheros XML')
    ItemIndex = 0
    Align = alClient
    Caption = 'Seleccione el tipo de ficheros para la exportaci'#243'n'
    TabOrder = 1
    TabStop = False
    Columns = 2
  end
  object UniScreenMask1: TUniScreenMask
    AttachedControl = UBAceptar
    Enabled = True
    DisplayMessage = 'Exportando datos. Este proceso puede tardar unos minutos.'
    Left = 160
    Top = 64
  end
  object FDQuery1: TFDQuery
    Left = 336
    Top = 16
  end
  object FDQuerytablas: TFDQuery
    Left = 264
    Top = 8
  end
end
