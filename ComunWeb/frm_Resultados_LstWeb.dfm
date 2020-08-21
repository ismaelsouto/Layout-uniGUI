object frmResultadosLstWeb: TfrmResultadosLstWeb
  Left = 0
  Top = 0
  ClientHeight = 608
  ClientWidth = 1099
  Caption = 'Resultados'
  OnShow = UniFormShow
  OldCreateOrder = False
  OnClose = UniFormClose
  OnKeyDown = UniFormKeyDown
  KeyPreview = True
  MonitoredKeys.Keys = <>
  OnAjaxEvent = UniFormAjaxEvent
  OnCreate = UniFormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid: TUniDBGrid
    Left = 0
    Top = 35
    Width = 1099
    Height = 573
    DataSource = DataSource1
    Options = [dgEditing, dgTitles, dgColumnResize, dgColLines, dgRowLines, dgConfirmDelete, dgAutoRefreshRow]
    LoadMask.Message = 'Loading data...'
    Align = alClient
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 0
  end
  object UniToolBar1: TUniToolBar
    Left = 0
    Top = 0
    Width = 1099
    Height = 35
    ButtonHeight = 33
    ButtonWidth = 34
    ShowCaptions = True
    Anchors = [akLeft, akTop, akRight]
    Align = alTop
    TabOrder = 1
    ParentColor = False
    Color = clBtnFace
    ParentFont = False
    Font.Color = 14062137
    Font.Height = -24
    Font.Name = 'cai'
    object UBImprimir: TUniToolButton
      Left = 0
      Top = 0
      Hint = 'Imprimir listado'
      ShowHint = True
      ParentShowHint = False
      Caption = 'P'
      TabOrder = 1
      OnClick = UBImprimirClick
    end
    object UniToolButton1: TUniToolButton
      Left = 34
      Top = 0
      Width = 13
      Style = tbsSeparator
      Caption = 'UniToolButton1'
      TabOrder = 4
    end
    object ubExcel: TUniToolButton
      Left = 47
      Top = 0
      Hint = 'Excel'
      Visible = False
      ShowHint = True
      ParentShowHint = False
      Caption = 'e'
      TabOrder = 5
      OnClick = ubExcelClick
      ExplicitLeft = 94
      ExplicitWidth = 81
    end
    object UniToolButton3: TUniToolButton
      Left = 81
      Top = 0
      Width = 13
      Style = tbsSeparator
      Caption = 'UniToolButton3'
      TabOrder = 2
    end
    object UBSalir: TUniToolButton
      Left = 94
      Top = 0
      Hint = 'Salir de este mantenimiento'
      ShowHint = True
      ParentShowHint = False
      Caption = 's'
      TabOrder = 3
      OnClick = UBSalirClick
      ExplicitLeft = 141
      ExplicitWidth = 81
    end
  end
  object DataSource1: TDataSource
    Left = 144
    Top = 64
  end
end
