inherited FrmCodigosPostalesBrowse: TFrmCodigosPostalesBrowse
  ClientHeight = 429
  ClientWidth = 835
  Caption = 'C'#243'digos postales'
  ActiveControl = CPOSTAL
  ExplicitWidth = 851
  ExplicitHeight = 468
  PixelsPerInch = 96
  TextHeight = 13
  inherited Contenedor: TUniPanel
    Width = 835
    Height = 429
    ExplicitWidth = 835
    ExplicitHeight = 429
    inherited PanelFiltro: TUniPanel
      Width = 833
      Height = 51
      ExplicitWidth = 833
      ExplicitHeight = 51
      inherited UBBRestauraFiltro: TUniBitBtn
        Left = 539
        Top = 20
        TabOrder = 5
        ExplicitLeft = 539
        ExplicitTop = 20
      end
      inherited UBBFiltrar: TUniBitBtn
        Left = 515
        Top = 20
        TabOrder = 4
        ExplicitLeft = 515
        ExplicitTop = 20
      end
      object CPOSTAL: TUniEdit
        Left = 16
        Top = 20
        Width = 72
        Hint = ''
        Text = ''
        TabOrder = 1
        OnKeyDown = FiltroKeyDown
      end
      object UniLabel2: TUniLabel
        Left = 91
        Top = 6
        Width = 43
        Height = 13
        Hint = ''
        Caption = 'Provincia'
        TabOrder = 6
      end
      object NOMBRE_PROVINCIA: TUniEdit
        Left = 91
        Top = 20
        Width = 210
        Hint = ''
        Text = ''
        TabOrder = 2
        OnKeyDown = FiltroKeyDown
      end
      object UniLabel3: TUniLabel
        Left = 305
        Top = 6
        Width = 43
        Height = 13
        Hint = ''
        Caption = 'Municipio'
        TabOrder = 7
      end
      object NOMBRE_LOCALIDAD: TUniEdit
        Left = 305
        Top = 20
        Width = 210
        Hint = ''
        Text = ''
        TabOrder = 3
        OnKeyDown = FiltroKeyDown
      end
      object UniLabel4: TUniLabel
        Left = 16
        Top = 6
        Width = 65
        Height = 13
        Hint = ''
        Caption = 'C'#243'digo postal'
        TabOrder = 8
      end
    end
    inherited UniToolBar1: TUniToolBar
      Width = 833
      ExplicitWidth = 833
    end
    inherited UniDBGrid1: TUniDBGrid
      Top = 87
      Width = 833
      Height = 306
      Columns = <
        item
          FieldName = 'CPOSTAL'
          Title.Caption = 'C'#243'digo postal'
          Width = 185
        end
        item
          FieldName = 'NOMBRE_PROVINCIA'
          Title.Caption = 'Provincia'
          Width = 242
          ReadOnly = True
        end
        item
          FieldName = 'NOMBRE_LOCALIDAD'
          Title.Caption = 'Municipio'
          Width = 234
          ReadOnly = True
        end>
    end
    inherited UniPanel1: TUniPanel
      Top = 393
      Width = 833
      ExplicitTop = 393
      ExplicitWidth = 833
      inherited UniPanel2: TUniPanel
        Left = 489
        ExplicitLeft = 489
      end
    end
  end
  inherited UniPanelPaginas: TUniPanel
    Left = 580
    Top = 397
    ExplicitLeft = 580
    ExplicitTop = 397
  end
  inherited ADVista: TFDQuery
    Connection = UniMainModule.ADConexionGeneral
    MacroData = <
      item
        Value = 'CPOSTAL,NOMBRE_PROVINCIA,NOMBRE_LOCALIDAD'
        Name = 'CAMPOS'
      end
      item
        Value = 
          'CPOSTALES LEFT OUTER JOIN (SELECT CODIGO CODIGO_PROVINCIA,LOCALI' +
          'DAD CODIGO_LOCALIDAD,DESCRIPCION NOMBRE_LOCALIDAD,NOMBRE NOMBRE_' +
          'PROVINCIA FROM PROVINCI LEFT OUTER JOIN LOCALIDADES ON (CODIGO=L' +
          'OCALIDADES.PROVINCIA)) ON (CODIGO_PROVINCIA=PROVINCIA AND CODIGO' +
          '_LOCALIDAD=LOCALIDAD)'
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
    object ADVistaCPOSTAL: TIntegerField
      DisplayLabel = 'C'#243'digo postal'
      FieldName = 'CPOSTAL'
      Origin = 'CPOSTAL'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object ADVistaNOMBRE_PROVINCIA: TStringField
      AutoGenerateValue = arDefault
      DisplayLabel = 'Provincia'
      FieldName = 'NOMBRE_PROVINCIA'
      Origin = 'NOMBRE'
      ProviderFlags = []
      ReadOnly = True
      Size = 60
    end
    object ADVistaNOMBRE_LOCALIDAD: TStringField
      AutoGenerateValue = arDefault
      DisplayLabel = 'Municipio'
      FieldName = 'NOMBRE_LOCALIDAD'
      Origin = 'DESCRIPCION'
      ProviderFlags = []
      ReadOnly = True
      Size = 50
    end
  end
end
