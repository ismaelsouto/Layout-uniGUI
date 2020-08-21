inherited FrmListadosPersonalizados: TFrmListadosPersonalizados
  ClientHeight = 598
  ClientWidth = 1074
  Caption = 'Listados y procesos personalizados'
  WindowState = wsMaximized
  ActiveControl = Titulo
  ExplicitWidth = 1090
  ExplicitHeight = 637
  DesignSize = (
    1074
    598)
  PixelsPerInch = 96
  TextHeight = 13
  inherited Contenedor: TUniPanel
    Width = 1074
    Height = 598
    ExplicitWidth = 1074
    ExplicitHeight = 598
    inherited PanelFiltro: TUniPanel
      Width = 1072
      Height = 60
      ExplicitWidth = 1072
      ExplicitHeight = 60
      inherited UBBRestauraFiltro: TUniBitBtn
        Left = 972
        Top = 27
        TabOrder = 3
        ExplicitLeft = 972
        ExplicitTop = 27
      end
      inherited UBBFiltrar: TUniBitBtn
        Left = 948
        Top = 27
        TabOrder = 2
        ExplicitLeft = 948
        ExplicitTop = 27
      end
      object UniLabel1: TUniLabel
        Left = 25
        Top = 10
        Width = 54
        Height = 13
        Hint = ''
        Caption = 'Descripci'#243'n'
        TabOrder = 4
      end
      object Titulo: TUniEdit
        Left = 25
        Top = 28
        Width = 924
        Hint = ''
        Text = ''
        TabOrder = 1
      end
    end
    inherited UniToolBar1: TUniToolBar
      Width = 1072
      ExplicitTop = 1
      ExplicitWidth = 1072
      inherited UBAnadir: TUniToolButton
        Enabled = False
        Visible = False
      end
      inherited UBModificar: TUniToolButton
        Enabled = False
        Visible = False
      end
      inherited UBSeleccionar: TUniToolButton
        Enabled = False
        Visible = False
      end
      inherited UBEliminar: TUniToolButton
        Enabled = False
        Visible = False
      end
      inherited UBImprimir: TUniToolButton
        Visible = False
      end
      inherited UniToolButton9: TUniToolButton
        Visible = False
      end
    end
    inherited UniDBGrid1: TUniDBGrid
      Top = 123
      Width = 1072
      Height = 439
      Columns = <
        item
          FieldName = 'TITULO'
          Title.Caption = 'TITULO'
          Width = 848
        end
        item
          FieldName = 'IDLISTADOSCONDICIONALES'
          Title.Caption = 'ID'
          Width = 64
        end>
    end
    inherited UniPanel1: TUniPanel
      Top = 562
      Width = 1072
      TabOrder = 5
      ExplicitTop = 562
      ExplicitWidth = 1072
      inherited UniPanel2: TUniPanel
        Left = 728
        ExplicitLeft = 728
      end
    end
    object UniPageControl1: TUniPageControl
      Left = 1
      Top = 96
      Width = 1072
      Height = 27
      Hint = ''
      ActivePage = UniTabSheet1
      Align = alTop
      TabOrder = 4
      OnChange = UniPageControl1Change
      object UniTabSheet1: TUniTabSheet
        Hint = ''
        Caption = 'Listados'
      end
      object UniTabSheet2: TUniTabSheet
        Hint = ''
        Caption = 'Procesos'
      end
    end
  end
  inherited UniPanelPaginas: TUniPanel
    Left = 805
    Top = 566
    ExplicitLeft = 805
    ExplicitTop = 566
  end
  inherited ADVista: TFDQuery
    BeforeOpen = ADVistaBeforeOpen
    LocalSQL = ADLocalSQL1
    Connection = ADConnection1
    Transaction = nil
    FetchOptions.AssignedValues = [evMode, evRecsSkip, evRecsMax, evRowsetSize, evRecordCountMode, evAutoFetchAll, evLiveWindowFastFirst]
    FetchOptions.LiveWindowFastFirst = True
    SQL.Strings = (
      'SELECT !CAMPOS'
      'FROM !TABLA'
      '{IF !FILTRO} WHERE !FILTRO {FI}'
      '{IF !GRUPO} GROUP BY !GRUPO {FI}'
      '{IF !ORDENACION} ORDER BY !ORDENACION {FI}'
      ''
      ''
      '')
    MacroData = <
      item
        Value = 'IDLISTADOSCONDICIONALES,TITULO,TIPOVALOR'
        Name = 'CAMPOS'
      end
      item
        Value = 'FDMemTable1'
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
  object ADPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink
    Left = 168
    Top = 184
  end
  object ADConnection1: TFDConnection
    Params.Strings = (
      'DriverID=SQLite')
    FetchOptions.AssignedValues = [evLiveWindowFastFirst]
    FetchOptions.LiveWindowFastFirst = True
    LoginPrompt = False
    Left = 240
    Top = 296
  end
  object ADLocalSQL1: TFDLocalSQL
    Connection = ADConnection1
    DataSets = <
      item
        DataSet = FDMemTable1
      end>
    Left = 80
    Top = 232
  end
  object FDMemTable1: TFDMemTable
    AfterOpen = FDMemTable1AfterOpen
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 152
    Top = 296
    object FDMemTable1TIPO: TIntegerField
      FieldName = 'TIPO'
    end
    object FDMemTable1IDLISTADOSCONDICIONALES: TIntegerField
      FieldName = 'IDLISTADOSCONDICIONALES'
      Required = True
    end
    object FDMemTable1TITULO: TStringField
      FieldName = 'TITULO'
      Size = 100
    end
    object FDMemTable1SENTENCIA: TMemoField
      FieldName = 'SENTENCIA'
      BlobType = ftMemo
      Size = 1
    end
    object FDMemTable1DESCRIPCION: TMemoField
      FieldName = 'DESCRIPCION'
      BlobType = ftMemo
      Size = 1
    end
    object FDMemTable1TIPOVALOR: TIntegerField
      FieldName = 'TIPOVALOR'
      Required = True
    end
    object FDMemTable1CODIGO_USUARIO: TIntegerField
      FieldName = 'CODIGO_USUARIO'
    end
  end
end
