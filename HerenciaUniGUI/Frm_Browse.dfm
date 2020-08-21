object FrmBrowse: TFrmBrowse
  Left = 0
  Top = 0
  ClientHeight = 388
  ClientWidth = 622
  Caption = 'Browse'
  OnShow = UniFormShow
  OldCreateOrder = False
  OnClose = UniFormClose
  OnActivate = UniFormActivate
  OnKeyDown = UniFormKeyDown
  BorderIcons = [biSystemMenu, biMaximize]
  KeyPreview = True
  MonitoredKeys.Enabled = True
  MonitoredKeys.KeyHandleAll = False
  MonitoredKeys.Keys = <>
  OnAjaxEvent = UniFormAjaxEvent
  OnCreate = UniFormCreate
  DesignSize = (
    622
    388)
  PixelsPerInch = 96
  TextHeight = 13
  object Contenedor: TUniPanel
    Left = 0
    Top = 0
    Width = 622
    Height = 388
    Hint = ''
    Align = alClient
    TabOrder = 0
    ShowCaption = False
    Caption = ''
    object PanelFiltro: TUniPanel
      Left = 1
      Top = 36
      Width = 620
      Height = 42
      Hint = ''
      Align = alTop
      TabOrder = 1
      BorderStyle = ubsNone
      Caption = ''
      object UBBRestauraFiltro: TUniBitBtn
        Left = 549
        Top = 12
        Width = 24
        Height = 24
        Hint = 'Elimina filtro'
        ShowHint = True
        ParentShowHint = False
        Caption = 'F'
        ParentFont = False
        Font.Height = -16
        Font.Name = 'cai'
        TabOrder = 2
        OnClick = UBBRestauraFiltroClick
      end
      object UBBFiltrar: TUniBitBtn
        Left = 525
        Top = 12
        Width = 24
        Height = 24
        Hint = 'Filtrar'
        ShowHint = True
        ParentShowHint = False
        Caption = 'f'
        ParentFont = False
        Font.Height = -16
        Font.Name = 'cai'
        TabOrder = 1
        OnClick = UBBFiltrarClick
      end
    end
    object UniToolBar1: TUniToolBar
      Left = 1
      Top = 1
      Width = 620
      Height = 35
      Hint = ''
      ButtonHeight = 33
      ButtonWidth = 34
      ShowCaptions = True
      TabOrder = 3
      ParentColor = False
      Color = clBtnFace
      ParentFont = False
      Font.Color = 14062137
      Font.Height = -24
      Font.Name = 'cai'
      object UBAnadir: TUniToolButton
        Left = 0
        Top = 0
        Hint = 'A'#241'adir Registro'
        ShowHint = True
        ParentShowHint = False
        Caption = '+'
        TabOrder = 1
        OnClick = UBAnadirClick
      end
      object UBModificar: TUniToolButton
        Left = 34
        Top = 0
        Hint = 'Modificar Registro'
        ShowHint = True
        ParentShowHint = False
        Caption = 'M'
        TabOrder = 2
        OnClick = UBModificarClick
      end
      object UBSeleccionar: TUniToolButton
        Left = 68
        Top = 0
        Hint = 'Seleccionar Registro'
        ShowHint = True
        ParentShowHint = False
        Caption = 'O'
        TabOrder = 3
        OnClick = UBSeleccionarClick
      end
      object UBConsultar: TUniToolButton
        Left = 102
        Top = 0
        Hint = 'Consultar Registro'
        ShowHint = True
        ParentShowHint = False
        Caption = 'C'
        TabOrder = 4
        OnClick = UBConsultarClick
      end
      object UBEliminar: TUniToolButton
        Left = 136
        Top = 0
        Hint = 'Eliminar Registro'
        ShowHint = True
        ParentShowHint = False
        Caption = '-'
        TabOrder = 5
        OnClick = UBEliminarClick
      end
      object UniToolButton4: TUniToolButton
        Left = 170
        Top = 0
        Width = 30
        Hint = ''
        Style = tbsSeparator
        Caption = 'UniToolButton4'
        TabOrder = 6
      end
      object UBPrimero: TUniToolButton
        Left = 200
        Top = 0
        Hint = 'Primer Registro'
        ShowHint = True
        ParentShowHint = False
        Caption = '5'
        TabOrder = 7
        OnClick = UBPrimeroClick
      end
      object UBAnterior: TUniToolButton
        Left = 234
        Top = 0
        Hint = 'Anterior Registro'
        ShowHint = True
        ParentShowHint = False
        Caption = '6'
        TabOrder = 8
        OnClick = UBAnteriorClick
      end
      object UBSiguiente: TUniToolButton
        Left = 268
        Top = 0
        Hint = 'Siguiente Registro'
        ShowHint = True
        ParentShowHint = False
        Caption = '7'
        TabOrder = 9
        OnClick = UBSiguienteClick
      end
      object UBUltimo: TUniToolButton
        Left = 302
        Top = 0
        Hint = #218'ltimo Registro'
        ShowHint = True
        ParentShowHint = False
        Caption = '8'
        TabOrder = 10
        OnClick = UBUltimoClick
      end
      object UniToolButton11: TUniToolButton
        Left = 336
        Top = 0
        Width = 30
        Hint = ''
        Style = tbsSeparator
        Caption = 'UniToolButton11'
        TabOrder = 11
      end
      object UBImprimir: TUniToolButton
        Left = 366
        Top = 0
        Hint = 'Imprimir Listado'
        ShowHint = True
        ParentShowHint = False
        Caption = 'P'
        ScreenMask.Enabled = True
        ScreenMask.Message = 'Generando informe...'
        TabOrder = 12
        OnClick = UBImprimirClick
      end
      object UBExportarExcel: TUniToolButton
        Left = 400
        Top = 0
        Hint = 'Excel'
        ShowHint = True
        ParentShowHint = False
        Caption = 'y'
        ScreenMask.Enabled = True
        ScreenMask.Message = 'Exportando datos a Excel'
        TabOrder = 14
        OnClick = UBExportarExcelClick
      end
      object UniToolButton9: TUniToolButton
        Left = 434
        Top = 0
        Width = 30
        Hint = ''
        Style = tbsSeparator
        Caption = 'UniToolButton9'
        TabOrder = 13
      end
      object UBSalir: TUniToolButton
        Left = 464
        Top = 0
        Hint = 'Salir'
        ShowHint = True
        ParentShowHint = False
        Caption = 's'
        TabOrder = 15
        OnClick = UBSalirClick
      end
    end
    object UniDBGrid1: TUniDBGrid
      Left = 1
      Top = 78
      Width = 620
      Height = 274
      Hint = ''
      DataSource = DSVista
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgRowSelect, dgAlwaysShowSelection, dgTitleClick, dgCancelOnExit]
      WebOptions.Paged = False
      WebOptions.PageSize = 40
      WebOptions.CustomizableCells = False
      WebOptions.FetchAll = True
      LoadMask.Message = 'Cargando datos...'
      Align = alClient
      TabOrder = 2
      OnAjaxEvent = UniDBGrid1AjaxEvent
      OnDblClick = UniDBGrid1DblClick
      OnTitleClick = UniDBGrid1TitleClick
      OnDrawColumnCell = UniDBGrid1DrawColumnCell
    end
    object UniPanel1: TUniPanel
      Left = 1
      Top = 352
      Width = 620
      Height = 35
      Hint = ''
      Align = alBottom
      TabOrder = 4
      BorderStyle = ubsNone
      ShowCaption = False
      Caption = ''
      object UniPanel2: TUniPanel
        Left = 276
        Top = 0
        Width = 344
        Height = 35
        Hint = ''
        Align = alRight
        TabOrder = 1
        BorderStyle = ubsNone
        ShowCaption = False
        Caption = ''
        object UniToolBar2: TUniToolBar
          Left = 0
          Top = 0
          Width = 344
          Height = 35
          Hint = ''
          ButtonHeight = 33
          ButtonWidth = 34
          ShowCaptions = True
          Align = alBottom
          TabOrder = 1
          ParentColor = False
          Color = clBtnFace
          ParentFont = False
          Font.Color = 14062137
          Font.Height = -24
          Font.Name = 'cai'
          object UBPaginaPrimera: TUniToolButton
            Left = 0
            Top = 0
            Hint = 'Primera p'#225'gna'
            ShowHint = True
            ParentShowHint = False
            Caption = '1'
            TabOrder = 1
            OnClick = UBPaginaPrimeraClick
          end
          object UBPaginaAnterior: TUniToolButton
            Left = 34
            Top = 0
            Hint = 'P'#225'gina anterior'
            ShowHint = True
            ParentShowHint = False
            Caption = '2'
            TabOrder = 2
            OnClick = UBPaginaAnteriorClick
          end
          object UBSeparadorPaginas: TUniToolButton
            Left = 68
            Top = 0
            Width = 176
            Hint = ''
            Style = tbsContainer
            Caption = 'UniToolButton4'
            TabOrder = 3
          end
          object UBPaginaSiguiente: TUniToolButton
            Left = 244
            Top = 0
            Hint = 'P'#225'gina siguiente'
            ShowHint = True
            ParentShowHint = False
            Caption = '3'
            TabOrder = 4
            OnClick = UBPaginaSiguienteClick
          end
          object UBUltimaPagina: TUniToolButton
            Left = 278
            Top = 0
            Hint = #218'ltima p'#225'gina'
            ShowHint = True
            ParentShowHint = False
            Caption = '4'
            TabOrder = 5
            OnClick = UBULtimaPaginaClick
          end
        end
      end
    end
  end
  object UniPanelPaginas: TUniPanel
    Left = 351
    Top = 356
    Width = 171
    Height = 27
    Hint = ''
    Anchors = [akRight, akBottom]
    ParentFont = False
    TabOrder = 1
    BorderStyle = ubsNone
    ShowCaption = False
    Caption = ''
    DesignSize = (
      171
      27)
    object LNUMERO_REGISTRO: TUniLabel
      Left = 1
      Top = 8
      Width = 40
      Height = 13
      Hint = ''
      Caption = 'Registro'
      Anchors = []
      ParentFont = False
      TabOrder = 1
    end
    object TOTAL_REGISTROS: TUniFormattedNumberEdit
      Left = 118
      Top = 3
      Width = 47
      Hint = ''
      Alignment = taRightJustify
      ParentFont = False
      Anchors = []
      TabOrder = 2
      TabStop = False
      Color = 15204351
      ReadOnly = True
      DecimalPrecision = 0
      DecimalSeparator = ','
      ThousandSeparator = '.'
    end
    object NUMERO_REGISTRO: TUniFormattedNumberEdit
      Left = 49
      Top = 3
      Width = 47
      Hint = ''
      Alignment = taRightJustify
      ParentFont = False
      Anchors = []
      TabOrder = 3
      TabStop = False
      Color = 15204351
      ReadOnly = True
      DecimalPrecision = 0
      DecimalSeparator = ','
      ThousandSeparator = '.'
    end
    object LTOTAL_REGISTROS: TUniLabel
      Left = 102
      Top = 8
      Width = 12
      Height = 13
      Hint = ''
      Caption = 'de'
      Anchors = []
      ParentFont = False
      TabOrder = 4
    end
  end
  object DSVista: TDataSource
    DataSet = ADVista
    Left = 280
    Top = 208
  end
  object ADVista: TFDQuery
    AfterOpen = ADVistaAfterOpen
    AfterDelete = ADVistaAfterDelete
    AfterScroll = ADVistaAfterScroll
    OnDeleteError = ADVistaDeleteError
    Transaction = ADTransaction1
    FetchOptions.AssignedValues = [evMode, evRecsSkip, evRecsMax, evRowsetSize, evAutoFetchAll]
    FetchOptions.Mode = fmManual
    FetchOptions.RowsetSize = 25
    FetchOptions.RecsSkip = 0
    FetchOptions.RecsMax = 50
    SQL.Strings = (
      'SELECT !CAMPOS'
      'FROM !TABLA'
      '{IF !FILTRO} WHERE !FILTRO {FI}'
      '{IF !GRUPO} GROUP BY !GRUPO {FI}'
      '{IF !ORDENACION} ORDER BY !ORDENACION {FI}'
      '')
    Left = 280
    Top = 176
    MacroData = <
      item
        Value = Null
        Name = 'CAMPOS'
      end
      item
        Value = Null
        Name = 'TABLA'
      end
      item
        Value = Null
        Name = 'FILTRO'
      end
      item
        Value = Null
        Name = 'GRUPO'
      end
      item
        Value = Null
        Name = 'ORDENACION'
      end>
  end
  object ADCamposFiltro: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    Left = 424
    Top = 216
  end
  object DSCamposFiltro: TDataSource
    DataSet = ADCamposFiltro
    Left = 424
    Top = 232
  end
  object ADTransaction1: TFDTransaction
    Left = 400
    Top = 136
  end
end
