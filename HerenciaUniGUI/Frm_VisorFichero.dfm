object FrmVisorFichero: TFrmVisorFichero
  Left = 0
  Top = 0
  ClientHeight = 546
  ClientWidth = 496
  Caption = 'Visor fichero'
  OnShow = UniFormShow
  OldCreateOrder = False
  OnClose = UniFormClose
  OnKeyDown = UniFormKeyDown
  BorderIcons = [biSystemMenu, biMaximize]
  MonitoredKeys.Keys = <>
  OnCreate = UniFormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object UniToolBar1: TUniToolBar
    Left = 0
    Top = 0
    Width = 496
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
    object UBSubir: TUniToolButton
      Left = 0
      Top = 0
      Hint = 'Subir fichero'
      ShowHint = True
      ParentShowHint = False
      Caption = 'u'
      TabOrder = 1
      OnClick = UBSubirClick
    end
    object UBEliminar: TUniToolButton
      Left = 34
      Top = 0
      Hint = 'Eliminar fichero'
      ShowHint = True
      ParentShowHint = False
      Caption = '-'
      TabOrder = 2
      OnClick = UBEliminarClick
    end
    object UBDescargar: TUniToolButton
      Left = 68
      Top = 0
      Hint = 'Descargar'
      ShowHint = True
      ParentShowHint = False
      Caption = 'k'
      TabOrder = 3
      OnClick = UBDescargarClick
    end
    object UniToolButton1: TUniToolButton
      Left = 102
      Top = 0
      Width = 30
      Hint = ''
      Style = tbsSeparator
      Caption = 'UniToolButton1'
      TabOrder = 4
    end
    object UBSalir: TUniToolButton
      Left = 132
      Top = 0
      Hint = 'Salir'
      ShowHint = True
      ParentShowHint = False
      Caption = 's'
      TabOrder = 5
      OnClick = UBSalirClick
    end
  end
  object UniURLFrame1: TUniURLFrame
    Left = 0
    Top = 35
    Width = 496
    Height = 511
    Hint = ''
    Align = alClient
    TabOrder = 1
    ParentColor = False
    Color = clBtnFace
  end
  object UniDBImage1: TUniDBImage
    Left = 318
    Top = 392
    Width = 128
    Height = 128
    Hint = ''
    Visible = False
    DataSource = DataSource1
    Center = False
  end
  object UniFileUpload1: TUniFileUpload
    OnCompleted = UniFileUpload1Completed
    Title = 'Subir fichero PDF'
    Messages.Uploading = 'Subiendo...'
    Messages.PleaseWait = 'Por favor espere'
    Messages.Cancel = 'Cancelar'
    Messages.Processing = 'Transfiriendo...'
    Messages.UploadError = 'Error de subida'
    Messages.Upload = 'Subir'
    Messages.NoFileError = 'Por favor seleccione un fichero'
    Messages.BrowseText = 'Seleccione...'
    Overwrite = True
    Left = 264
    Top = 160
  end
  object DataSource1: TDataSource
    Left = 200
    Top = 192
  end
end
