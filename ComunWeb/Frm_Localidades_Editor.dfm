inherited FrmLocalidadesEditor: TFrmLocalidadesEditor
  ClientHeight = 142
  ClientWidth = 315
  Caption = 'Municipios'
  ExplicitWidth = 321
  ExplicitHeight = 171
  PixelsPerInch = 96
  TextHeight = 13
  inherited UniPanelPrincipal: TUniPanel
    Width = 315
    Height = 107
    ExplicitLeft = 102
    ExplicitTop = 99
    ExplicitWidth = 315
    ExplicitHeight = 107
    object Label1: TUniLabel
      Left = 18
      Top = 14
      Width = 33
      Height = 13
      Hint = ''
      Caption = 'C'#243'digo'
      TabOrder = 1
    end
    object Label2: TUniLabel
      Left = 83
      Top = 14
      Width = 37
      Height = 13
      Hint = ''
      Caption = 'Nombre'
      TabOrder = 2
    end
    object LOCALIDAD: TUniDBEdit
      Left = 18
      Top = 30
      Width = 59
      Height = 21
      Hint = ''
      DataField = 'LOCALIDAD'
      DataSource = DSCliente
      TabOrder = 3
    end
    object DESCRIPCION: TUniDBEdit
      Left = 83
      Top = 30
      Width = 214
      Height = 21
      Hint = ''
      DataField = 'DESCRIPCION'
      DataSource = DSCliente
      TabOrder = 4
    end
    object UniLabel1: TUniLabel
      Left = 18
      Top = 56
      Width = 43
      Height = 13
      Hint = ''
      Caption = 'Provincia'
      TabOrder = 5
    end
    object COMUNIDA: TUniDBLookupComboBox
      Left = 18
      Top = 72
      Width = 279
      Hint = ''
      ListField = 'NOMBRE'
      ListSource = DSProvincias
      KeyField = 'CODIGO'
      ListFieldIndex = 0
      DataField = 'PROVINCIA'
      DataSource = DSCliente
      TabOrder = 6
      Color = clWindow
      ForceSelection = False
    end
  end
  inherited UniToolBar1: TUniToolBar
    Width = 315
    ExplicitWidth = 315
  end
  inherited ADCliente: TFDQuery
    BeforeOpen = ADClienteBeforeOpen
    AfterClose = ADClienteAfterClose
    Connection = UniMainModule.ADConexionGeneral
    SQL.Strings = (
      
        'SELECT * FROM LOCALIDADES WHERE PROVINCIA=:PROVINCIA AND LOCALID' +
        'AD=:LOCALIDAD')
    Left = 168
    ParamData = <
      item
        Name = 'PROVINCIA'
        DataType = ftInteger
        ParamType = ptInput
        Value = 0
      end
      item
        Name = 'LOCALIDAD'
        DataType = ftInteger
        ParamType = ptInput
        Value = 0
      end>
    object ADClienteLOCALIDAD: TIntegerField
      FieldName = 'LOCALIDAD'
      Origin = 'LOCALIDAD'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object ADClientePROVINCIA: TIntegerField
      FieldName = 'PROVINCIA'
      Origin = 'PROVINCIA'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object ADClienteDESCRIPCION: TStringField
      FieldName = 'DESCRIPCION'
      Origin = 'DESCRIPCION'
      Size = 50
    end
  end
  inherited DSCliente: TDataSource
    Left = 120
  end
  object ADProvincias: TFDQuery
    Connection = UniMainModule.ADConexionGeneral
    SQL.Strings = (
      
        'SELECT CAST(CODIGO AS VARCHAR(10)) CODIGO,NOMBRE FROM PROVINCI O' +
        'RDER BY CODIGO')
    Left = 248
    Top = 48
    object ADProvinciasCODIGO: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'CODIGO'
      Origin = 'CODIGO'
      ProviderFlags = [pfInKey]
      ReadOnly = True
      Size = 10
    end
    object ADProvinciasNOMBRE: TStringField
      FieldName = 'NOMBRE'
      Origin = 'NOMBRE'
      Size = 60
    end
  end
  object DSProvincias: TDataSource
    DataSet = ADProvincias
    Left = 248
    Top = 64
  end
end
