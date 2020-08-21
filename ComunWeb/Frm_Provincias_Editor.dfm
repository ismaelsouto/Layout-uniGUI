inherited FrmProvinciasEditor: TFrmProvinciasEditor
  ClientHeight = 154
  ClientWidth = 335
  Caption = 'Provincias'
  ExplicitWidth = 341
  ExplicitHeight = 183
  PixelsPerInch = 96
  TextHeight = 13
  inherited UniPanelPrincipal: TUniPanel
    Width = 335
    Height = 119
    ExplicitWidth = 335
    ExplicitHeight = 116
    object Label1: TUniLabel
      Left = 19
      Top = 15
      Width = 33
      Height = 13
      Hint = ''
      Caption = 'C'#243'digo'
      TabOrder = 1
    end
    object CODIGO: TUniDBEdit
      Left = 19
      Top = 32
      Width = 64
      Height = 23
      Hint = ''
      DataField = 'CODIGO'
      DataSource = DSCliente
      TabOrder = 2
    end
    object Label2: TUniLabel
      Left = 89
      Top = 15
      Width = 37
      Height = 13
      Hint = ''
      Caption = 'Nombre'
      TabOrder = 3
    end
    object NOMBRE: TUniDBEdit
      Left = 89
      Top = 32
      Width = 231
      Height = 23
      Hint = ''
      DataField = 'NOMBRE'
      DataSource = DSCliente
      TabOrder = 4
    end
    object COMUNIDA: TUniDBLookupComboBox
      Left = 19
      Top = 78
      Width = 301
      Height = 23
      Hint = ''
      ListField = 'NOMBRE'
      ListSource = DSComunidades
      KeyField = 'CODIGO'
      ListFieldIndex = 0
      DataField = 'COMUNIDA'
      DataSource = DSCliente
      TabOrder = 5
      Color = clWindow
      ForceSelection = False
    end
    object UniLabel1: TUniLabel
      Left = 19
      Top = 60
      Width = 53
      Height = 13
      Hint = ''
      Caption = 'Comunidad'
      TabOrder = 6
    end
  end
  inherited UniToolBar1: TUniToolBar
    Width = 335
    ExplicitWidth = 335
  end
  inherited ADCliente: TFDQuery
    BeforeOpen = ADClienteBeforeOpen
    AfterClose = ADClienteAfterClose
    Connection = UniMainModule.ADConexionGeneral
    SQL.Strings = (
      'SELECT * FROM PROVINCI WHERE CODIGO=:CODIGO')
    Left = 176
    ParamData = <
      item
        Name = 'CODIGO'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  inherited DSCliente: TDataSource
    Left = 136
  end
  object ADComunidades: TFDQuery
    Connection = UniMainModule.ADConexionGeneral
    SQL.Strings = (
      'SELECT * FROM COMUNIDA')
    Left = 248
    Top = 8
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
  object DSComunidades: TDataSource
    DataSet = ADComunidades
    Left = 248
    Top = 24
  end
end
