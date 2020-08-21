inherited FrmProvinciasBrowse: TFrmProvinciasBrowse
  ClientWidth = 761
  Caption = 'Provincias'
  ActiveControl = CODIGO
  ExplicitWidth = 777
  PixelsPerInch = 96
  TextHeight = 13
  inherited Contenedor: TUniPanel
    Width = 761
    ExplicitWidth = 761
    inherited PanelFiltro: TUniPanel
      Width = 759
      Height = 52
      ExplicitWidth = 759
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
      object CODIGO: TUniEdit
        Left = 16
        Top = 20
        Width = 49
        Hint = ''
        Text = ''
        TabOrder = 1
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
      object NOMBRE: TUniEdit
        Left = 71
        Top = 20
        Width = 210
        Hint = ''
        Text = ''
        TabOrder = 2
        OnKeyDown = FiltroKeyDown
      end
      object COMUNIDAD_AUTONOMA: TUniDBLookupComboBox
        Left = 283
        Top = 20
        Width = 153
        Hint = ''
        ListField = 'NOMBRE'
        ListSource = DSComunidades
        KeyField = 'CODIGO'
        ListFieldIndex = 0
        TabOrder = 3
        Color = clWindow
        ForceSelection = False
        OnKeyDown = FiltroKeyDown
      end
      object UniLabel3: TUniLabel
        Left = 283
        Top = 6
        Width = 104
        Height = 13
        Hint = ''
        Caption = 'Comunidad aut'#243'noma'
        TabOrder = 7
      end
      object UniLabel4: TUniLabel
        Left = 16
        Top = 6
        Width = 33
        Height = 13
        Hint = ''
        Caption = 'C'#243'digo'
        TabOrder = 8
      end
    end
    inherited UniToolBar1: TUniToolBar
      Width = 759
      ExplicitWidth = 759
    end
    inherited UniDBGrid1: TUniDBGrid
      Top = 88
      Width = 759
      Height = 264
      Columns = <
        item
          FieldName = 'CODIGO'
          Title.Caption = 'C'#243'digo'
          Width = 120
        end
        item
          FieldName = 'NOMBRE'
          Title.Caption = 'Nombre'
          Width = 345
          ReadOnly = True
        end
        item
          FieldName = 'COMUNIDAD_AUTONOMA'
          Title.Caption = 'Comunidad aut'#243'noma'
          Width = 239
          ReadOnly = True
        end>
    end
    inherited UniPanel1: TUniPanel
      Width = 759
      ExplicitWidth = 759
      inherited UniPanel2: TUniPanel
        Left = 415
        ExplicitLeft = 415
      end
    end
  end
  inherited UniPanelPaginas: TUniPanel
    Left = 489
    ExplicitLeft = 489
  end
  inherited ADVista: TFDQuery
    Connection = UniMainModule.ADConexionGeneral
    MacroData = <
      item
        Value = 'CODIGO,NOMBRE,COMUNIDAD_AUTONOMA'
        Name = 'CAMPOS'
      end
      item
        Value = 
          'PROVINCI LEFT OUTER JOIN (SELECT CODIGO CODIGO_COMUNIDAD,NOMBRE ' +
          'COMUNIDAD_AUTONOMA FROM COMUNIDA)  ON (CODIGO_COMUNIDAD=COMUNIDA' +
          ')'
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
        Value = 'CODIGO'
        Name = 'ORDENACION'
      end>
    object ADVistaCODIGO: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'CODIGO'
      Origin = 'CODIGO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object ADVistaNOMBRE: TStringField
      AutoGenerateValue = arDefault
      DisplayLabel = 'Nombre'
      FieldName = 'NOMBRE'
      Origin = 'NOMBRE'
      ProviderFlags = []
      ReadOnly = True
      Size = 60
    end
    object ADVistaCOMUNIDAD_AUTONOMA: TStringField
      AutoGenerateValue = arDefault
      DisplayLabel = 'Comunidad aut'#243'noma'
      FieldName = 'COMUNIDAD_AUTONOMA'
      Origin = 'NOMBRE'
      ProviderFlags = []
      ReadOnly = True
      Size = 200
    end
  end
  object DSComunidades: TDataSource
    DataSet = ADComunidades
    Left = 512
    Top = 176
  end
  object ADComunidades: TFDQuery
    Connection = UniMainModule.ADConexionGeneral
    SQL.Strings = (
      'SELECT '#39'--'#39' CODIGO,'#39'TODAS'#39' NOMBRE FROM RDB$DATABASE'
      'UNION'
      'SELECT CODIGO,NOMBRE FROM COMUNIDA')
    Left = 512
    Top = 160
    object ADComunidadesCODIGO: TStringField
      FieldName = 'CODIGO'
      Origin = 'CODIGO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Size = 2
    end
    object ADComunidadesNOMBRE: TStringField
      FieldName = 'NOMBRE'
      Origin = 'NOMBRE'
      Size = 200
    end
  end
end
