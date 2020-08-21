object FrmDialogo2: TFrmDialogo2
  Left = 0
  Top = 0
  ClientHeight = 433
  ClientWidth = 605
  Caption = 'FrmDialogo2'
  OnShow = UniFormShow
  BorderStyle = bsDialog
  OldCreateOrder = False
  OnClose = UniFormClose
  OnKeyDown = UniFormKeyDown
  BorderIcons = [biSystemMenu, biMinimize]
  KeyPreview = True
  NavigateKeys.Enabled = True
  MonitoredKeys.Enabled = True
  MonitoredKeys.KeyHandleAll = False
  MonitoredKeys.Keys = <>
  OnAjaxEvent = UniFormAjaxEvent
  OnCreate = UniFormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object UniPanelPrincipal: TUniPanel
    Left = 0
    Top = 35
    Width = 605
    Height = 398
    Hint = ''
    Align = alClient
    TabOrder = 0
    BorderStyle = ubsNone
    ShowCaption = False
    Caption = ''
  end
  object UniToolBar1: TUniToolBar
    Left = 0
    Top = 0
    Width = 605
    Height = 35
    Hint = ''
    ButtonHeight = 33
    ButtonWidth = 34
    ShowCaptions = True
    TabOrder = 1
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
      OnAjaxEvent = UBAceptarAjaxEvent
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
    object UniToolButton4: TUniToolButton
      Left = 68
      Top = 0
      Width = 30
      Hint = ''
      Style = tbsSeparator
      Caption = 'UniToolButton4'
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
    object UniToolButton1: TUniToolButton
      Left = 234
      Top = 0
      Width = 30
      Hint = ''
      Style = tbsSeparator
      Caption = 'UniToolButton1'
      TabOrder = 8
    end
    object UBSalir: TUniToolButton
      Left = 264
      Top = 0
      Hint = 'Salir'
      ShowHint = True
      ParentShowHint = False
      Caption = 's'
      TabOrder = 9
      OnClick = UBSalirClick
    end
  end
  object ADCliente: TFDQuery
    AfterInsert = ADClienteAfterInsert
    CachedUpdates = True
    OnReconcileError = DatasetReconcileError
    AfterGetRecord = ADClienteAfterGetRecord
    Left = 328
    Top = 80
  end
  object DSCliente: TDataSource
    DataSet = ADCliente
    Left = 264
    Top = 88
  end
end
