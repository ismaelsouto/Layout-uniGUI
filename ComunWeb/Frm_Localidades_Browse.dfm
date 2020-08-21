inherited FrmLocalidadesBrowse: TFrmLocalidadesBrowse
  ClientWidth = 843
  Caption = 'Municipios'
  ActiveControl = LOCALIDAD
  ExplicitWidth = 859
  DesignSize = (
    843
    388)
  PixelsPerInch = 96
  TextHeight = 13
  inherited Contenedor: TUniPanel
    Width = 843
    ExplicitWidth = 843
    inherited PanelFiltro: TUniPanel
      Width = 841
      Height = 52
      ExplicitWidth = 841
      ExplicitHeight = 52
      inherited UBBRestauraFiltro: TUniBitBtn
        Left = 460
        Top = 20
        TabOrder = 5
        ExplicitLeft = 460
        ExplicitTop = 20
      end
      inherited UBBFiltrar: TUniBitBtn
        Left = 436
        Top = 20
        TabOrder = 4
        ExplicitLeft = 436
        ExplicitTop = 20
      end
      object LPROVINCIA: TUniLabel
        Left = 283
        Top = 6
        Width = 43
        Height = 13
        Hint = ''
        Caption = 'Provincia'
        TabOrder = 7
      end
      object DESCRIPCION: TUniEdit
        Left = 71
        Top = 20
        Width = 210
        Hint = ''
        Text = ''
        TabOrder = 2
        OnKeyDown = FiltroKeyDown
      end
      object UniLabel2: TUniLabel
        Left = 71
        Top = 6
        Width = 37
        Height = 13
        Hint = ''
        Caption = 'Nombre'
        TabOrder = 6
      end
      object LOCALIDAD: TUniEdit
        Left = 16
        Top = 20
        Width = 49
        Hint = ''
        Text = ''
        TabOrder = 1
        OnKeyDown = FiltroKeyDown
      end
      object UniLabel3: TUniLabel
        Left = 16
        Top = 6
        Width = 33
        Height = 13
        Hint = ''
        Caption = 'C'#243'digo'
        TabOrder = 0
      end
      object PROVINCIA: TUniEdit
        Left = 283
        Top = 20
        Width = 153
        Hint = ''
        Text = ''
        TabOrder = 3
        OnKeyDown = FiltroKeyDown
      end
    end
    inherited UniToolBar1: TUniToolBar
      Width = 841
      ExplicitWidth = 841
    end
    inherited UniDBGrid1: TUniDBGrid
      Top = 88
      Width = 841
      Height = 264
      Columns = <
        item
          FieldName = 'PROVINCIA'
          Title.Caption = 'C'#243'digo provincia'
          Width = 107
        end
        item
          FieldName = 'NOMBRE_PROVINCIA'
          Title.Caption = 'Nombre provincia'
          Width = 364
          ReadOnly = True
        end
        item
          FieldName = 'LOCALIDAD'
          Title.Caption = 'C'#243'digo municipio'
          Width = 98
        end
        item
          FieldName = 'DESCRIPCION'
          Title.Caption = 'Nombre municipio'
          Width = 219
        end>
    end
    inherited UniPanel1: TUniPanel
      Width = 841
      ExplicitWidth = 841
      inherited UniPanel2: TUniPanel
        Left = 497
        ExplicitLeft = 497
      end
    end
  end
  inherited UniPanelPaginas: TUniPanel
    Left = 571
    ExplicitLeft = 571
  end
  inherited ADVista: TFDQuery
    Connection = UniMainModule.ADConexionGeneral
    MacroData = <
      item
        Value = 
          'PROVINCIA,NOMBRE_PROVINCIA,LOCALIDAD,DESCRIPCION,CAST(CAST(PROVI' +
          'NCIA*CASE WHEN LOCALIDAD<10 THEN 100 WHEN LOCALIDAD<100 THEN 10 ' +
          'ELSE 1 END AS INTEGER)||LOCALIDAD AS INTEGER) CODIGO_MUNICIPIO'
        Name = 'CAMPOS'
      end
      item
        Value = 
          'LOCALIDADES LEFT OUTER JOIN (SELECT CODIGO CODIGO_PROVINCIA,NOMB' +
          'RE NOMBRE_PROVINCIA FROM PROVINCI) ON (CODIGO_PROVINCIA=PROVINCI' +
          'A)'
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
        Value = 'PROVINCIA,LOCALIDAD'
        Name = 'ORDENACION'
      end>
    object ADVistaPROVINCIA: TIntegerField
      DisplayLabel = 'C'#243'digo provincia'
      FieldName = 'PROVINCIA'
      Origin = 'PROVINCIA'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object ADVistaNOMBRE_PROVINCIA: TStringField
      AutoGenerateValue = arDefault
      DisplayLabel = 'Nombre provincia'
      FieldName = 'NOMBRE_PROVINCIA'
      Origin = 'NOMBRE'
      ProviderFlags = []
      ReadOnly = True
      Size = 60
    end
    object ADVistaLOCALIDAD: TIntegerField
      DisplayLabel = 'C'#243'digo municipio'
      FieldName = 'LOCALIDAD'
      Origin = 'LOCALIDAD'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object ADVistaDESCRIPCION: TStringField
      DisplayLabel = 'Nombre municipio'
      FieldName = 'DESCRIPCION'
      Origin = 'DESCRIPCION'
      Size = 50
    end
    object ADVistaCODIGO_MUNICIPIO: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'CODIGO_MUNICIPIO'
      Origin = 'CODIGO_MUNICIPIO'
      ProviderFlags = []
      ReadOnly = True
    end
  end
  inherited ADTransaction1: TFDTransaction
    Connection = UniMainModule.ADConexionGeneral
  end
end
