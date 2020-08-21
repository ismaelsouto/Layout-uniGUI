object FrmMuestraConsulta: TFrmMuestraConsulta
  Left = 0
  Top = 0
  ClientHeight = 484
  ClientWidth = 659
  Caption = 'Datos'
  OldCreateOrder = False
  OnKeyDown = UniFormKeyDown
  KeyPreview = True
  MonitoredKeys.Keys = <>
  OnCreate = UniFormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object UniToolBar1: TUniToolBar
    Left = 0
    Top = 0
    Width = 659
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
    ExplicitLeft = 1
    ExplicitTop = 1
    ExplicitWidth = 620
    object UBSalir: TUniToolButton
      Left = 0
      Top = 0
      Hint = 'Salir'
      ShowHint = True
      ParentShowHint = False
      Caption = 's'
      TabOrder = 3
      OnClick = UBSalirClick
      ExplicitLeft = 342
      ExplicitTop = 2
    end
    object UniToolButton2: TUniToolButton
      Left = 34
      Top = 0
      Width = 30
      Hint = ''
      Style = tbsSeparator
      Caption = 'UniToolButton2'
      TabOrder = 1
      ExplicitLeft = 336
    end
    object UBImprimir: TUniToolButton
      Left = 64
      Top = 0
      Hint = 'Imprimir Listado'
      ShowHint = True
      ParentShowHint = False
      Caption = 'P'
      ScreenMask.Enabled = True
      ScreenMask.Message = 'Generando informe...'
      TabOrder = 2
      OnClick = UBImprimirClick
      ExplicitLeft = 366
    end
  end
  object UniDBGrid1: TUniDBGrid
    Left = 0
    Top = 35
    Width = 659
    Height = 449
    Hint = ''
    DataSource = DataSource1
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgRowSelect, dgConfirmDelete, dgAutoRefreshRow]
    WebOptions.Paged = False
    WebOptions.FetchAll = True
    LoadMask.Message = 'Loading data...'
    Align = alClient
    TabOrder = 1
  end
  object DataSource1: TDataSource
    Left = 224
    Top = 232
  end
end
