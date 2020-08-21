object FrmSelector: TFrmSelector
  Left = 0
  Top = 0
  ClientHeight = 330
  ClientWidth = 414
  Caption = 'FrmSelector'
  OnShow = UniFormShow
  OldCreateOrder = False
  OnClose = UniFormClose
  OnKeyDown = UniFormKeyDown
  KeyPreview = True
  MonitoredKeys.Keys = <>
  ActiveControl = UniDBGrid1
  OnCreate = UniFormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object UniToolBar1: TUniToolBar
    Left = 0
    Top = 0
    Width = 414
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
      Hint = 'Aceptar'
      ShowHint = True
      ParentShowHint = False
      Caption = 'V'
      TabOrder = 1
      OnClick = UBAceptarClick
    end
    object UBCancelar: TUniToolButton
      Left = 34
      Top = 0
      Hint = 'Cancelar'
      ShowHint = True
      ParentShowHint = False
      Caption = 'X'
      TabOrder = 2
      OnClick = UBCancelarClick
    end
    object UniToolButton2: TUniToolButton
      Left = 68
      Top = 0
      Width = 30
      Hint = ''
      Style = tbsSeparator
      Caption = 'UniToolButton2'
      TabOrder = 3
    end
    object UBPrimero: TUniToolButton
      Left = 98
      Top = 0
      Hint = 'Primer registro'
      ShowHint = True
      ParentShowHint = False
      Caption = '5'
      TabOrder = 4
      OnClick = UBPrimeroClick
    end
    object UBAnterior: TUniToolButton
      Left = 132
      Top = 0
      Hint = 'Anterior registro'
      ShowHint = True
      ParentShowHint = False
      Caption = '6'
      TabOrder = 5
      OnClick = UBAnteriorClick
    end
    object UBSiguiente: TUniToolButton
      Left = 166
      Top = 0
      Hint = 'Siguiente registro'
      ShowHint = True
      ParentShowHint = False
      Caption = '7'
      TabOrder = 6
      OnClick = UBSiguienteClick
    end
    object UBUltimo: TUniToolButton
      Left = 200
      Top = 0
      Hint = #218'ltimo registro'
      ShowHint = True
      ParentShowHint = False
      Caption = '8'
      TabOrder = 7
      OnClick = UBUltimoClick
    end
    object UBEliminar: TUniToolButton
      Left = 234
      Top = 0
      Hint = 'Eliminar Registro'
      ShowHint = True
      ParentShowHint = False
      Caption = '-'
      TabOrder = 8
      OnClick = UBEliminarClick
    end
  end
  object UniDBGrid1: TUniDBGrid
    Left = 0
    Top = 35
    Width = 414
    Height = 295
    Hint = ''
    DataSource = DSSelector
    Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgRowSelect, dgConfirmDelete]
    WebOptions.Paged = False
    WebOptions.FetchAll = True
    LoadMask.Message = 'Cargando datos...'
    Align = alClient
    TabOrder = 1
    OnDblClick = UniDBGrid1DblClick
  end
  object DSSelector: TDataSource
    Left = 192
    Top = 160
  end
end
