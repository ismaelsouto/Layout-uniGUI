inherited FrmCodigosPostalesEditor: TFrmCodigosPostalesEditor
  ClientHeight = 300
  ClientWidth = 279
  Caption = 'C'#243'digos postales'
  ExplicitWidth = 285
  ExplicitHeight = 329
  PixelsPerInch = 96
  TextHeight = 13
  inherited UniPanelPrincipal: TUniPanel
    Width = 279
    Height = 265
    ExplicitWidth = 279
    ExplicitHeight = 265
    object Label1: TUniLabel
      Left = 40
      Top = 13
      Width = 65
      Height = 13
      Hint = ''
      Caption = 'C'#243'digo Postal'
      TabOrder = 6
    end
    object Label2: TUniLabel
      Left = 40
      Top = 61
      Width = 104
      Height = 13
      Hint = ''
      Caption = 'Comunidad aut'#243'noma'
      TabOrder = 7
    end
    object Label3: TUniLabel
      Left = 40
      Top = 108
      Width = 43
      Height = 13
      Hint = ''
      Caption = 'Provincia'
      TabOrder = 8
    end
    object Label4: TUniLabel
      Left = 40
      Top = 156
      Width = 43
      Height = 13
      Hint = ''
      Caption = 'Municipio'
      TabOrder = 9
    end
    object Label5: TUniLabel
      Left = 40
      Top = 205
      Width = 26
      Height = 13
      Hint = ''
      Caption = 'AEAT'
      TabOrder = 10
    end
    object AUTONOMIA: TUniDBLookupComboBox
      Left = 40
      Top = 77
      Width = 193
      Height = 21
      Hint = ''
      ListField = 'NOMBRE'
      ListSource = DSComunidades
      KeyField = 'CODIGO'
      ListFieldIndex = 0
      DataField = 'AUTONOMIA'
      DataSource = DSCliente
      TabOrder = 1
      Color = clWindow
      ForceSelection = False
    end
    object PROVINCIA: TUniDBLookupComboBox
      Left = 40
      Top = 124
      Width = 193
      Height = 21
      Hint = ''
      ListField = 'NOMBRE'
      ListSource = DSProvincias
      KeyField = 'CODIGO'
      ListFieldIndex = 0
      DataField = 'PROVINCIA'
      DataSource = DSCliente
      TabOrder = 2
      Color = clWindow
      ForceSelection = False
    end
    object LOCALIDAD: TUniDBLookupComboBox
      Left = 40
      Top = 172
      Width = 193
      Height = 21
      Hint = ''
      ListField = 'DESCRIPCION'
      ListSource = DSMunicipios
      KeyField = 'LOCALIDAD'
      ListFieldIndex = 0
      DataField = 'LOCALIDAD'
      DataSource = DSCliente
      TabOrder = 3
      Color = clWindow
      ForceSelection = False
    end
    object AEAT: TUniDBLookupComboBox
      Left = 40
      Top = 221
      Width = 193
      Height = 21
      Hint = ''
      ListField = 'ADMINIST'
      ListSource = DSAEAT
      KeyField = 'CODIGO'
      ListFieldIndex = 0
      DataField = 'AEAT'
      DataSource = DSCliente
      TabOrder = 4
      Color = clWindow
      ForceSelection = False
    end
    object CPOSTAL: TUniDBEdit
      Left = 40
      Top = 29
      Width = 81
      Height = 21
      Hint = ''
      DataField = 'CPOSTAL'
      DataSource = DSCliente
      MaxLength = 5
      TabOrder = 0
    end
  end
  inherited UniToolBar1: TUniToolBar
    Width = 279
    ExplicitWidth = 279
    inherited UBPrimero: TUniToolButton
      ExplicitLeft = 134
    end
    inherited UBAnterior: TUniToolButton
      ExplicitLeft = 168
    end
    inherited UBSiguiente: TUniToolButton
      ExplicitLeft = 202
    end
    inherited UBUltimo: TUniToolButton
      ExplicitLeft = 236
    end
    inherited UBSalir: TUniToolButton
      ExplicitLeft = 68
    end
  end
  inherited ADCliente: TFDQuery
    BeforeOpen = ADClienteBeforeOpen
    AfterClose = ADClienteAfterClose
    Connection = UniMainModule.ADConexionGeneral
    SQL.Strings = (
      'SELECT * FROM CPOSTALES WHERE CPOSTAL=:CPOSTAL')
    Left = 184
    Top = 40
    ParamData = <
      item
        Name = 'CPOSTAL'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
    object ADClienteCPOSTAL: TIntegerField
      FieldName = 'CPOSTAL'
      Origin = 'CPOSTAL'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object ADClienteAEAT: TStringField
      FieldName = 'AEAT'
      Origin = 'AEAT'
      FixedChar = True
      Size = 5
    end
    object ADClienteAUTONOMIA: TStringField
      FieldName = 'AUTONOMIA'
      Origin = 'AUTONOMIA'
      Size = 2
    end
    object ADClienteLOCALIDAD: TIntegerField
      FieldName = 'LOCALIDAD'
      Origin = 'LOCALIDAD'
    end
    object ADClientePROVINCIA: TIntegerField
      FieldName = 'PROVINCIA'
      Origin = 'PROVINCIA'
    end
  end
  inherited DSCliente: TDataSource
    Left = 128
    Top = 40
  end
  object DSComunidades: TDataSource
    DataSet = ADComunidades
    Left = 136
    Top = 56
  end
  object ADComunidades: TFDQuery
    Connection = UniMainModule.ADConexionGeneral
    SQL.Strings = (
      'SELECT * FROM COMUNIDA')
    Left = 136
    Top = 40
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
  object DSProvincias: TDataSource
    DataSet = ADProvincias
    Left = 136
    Top = 120
  end
  object ADProvincias: TFDQuery
    MasterSource = DSComunidades
    MasterFields = 'CODIGO'
    Connection = UniMainModule.ADConexionGeneral
    SQL.Strings = (
      'SELECT CODIGO,NOMBRE FROM PROVINCI WHERE COMUNIDA=:CODIGO')
    Left = 136
    Top = 104
    ParamData = <
      item
        Name = 'CODIGO'
        DataType = ftString
        ParamType = ptInput
        Size = 3
        Value = Null
      end>
    object ADProvinciasCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Origin = 'CODIGO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object ADProvinciasNOMBRE: TStringField
      FieldName = 'NOMBRE'
      Origin = 'NOMBRE'
      Size = 60
    end
  end
  object ADMunicipios: TFDQuery
    MasterSource = DSProvincias
    MasterFields = 'CODIGO'
    Connection = UniMainModule.ADConexionGeneral
    SQL.Strings = (
      'SELECT * FROM LOCALIDADES WHERE PROVINCIA=:CODIGO')
    Left = 136
    Top = 160
    ParamData = <
      item
        Name = 'CODIGO'
        DataType = ftInteger
        ParamType = ptInput
      end>
    object ADMunicipiosLOCALIDAD: TIntegerField
      FieldName = 'LOCALIDAD'
      Origin = 'LOCALIDAD'
      Required = True
    end
    object ADMunicipiosPROVINCIA: TIntegerField
      FieldName = 'PROVINCIA'
      Origin = 'PROVINCIA'
    end
    object ADMunicipiosDESCRIPCION: TStringField
      FieldName = 'DESCRIPCION'
      Origin = 'DESCRIPCION'
      Size = 50
    end
  end
  object DSMunicipios: TDataSource
    DataSet = ADMunicipios
    Left = 136
    Top = 176
  end
  object ADAEAT: TFDQuery
    Connection = UniMainModule.ADConexionGeneral
    SQL.Strings = (
      'SELECT * FROM ADMINIST')
    Left = 128
    Top = 224
    object ADAEATCODIGO: TStringField
      FieldName = 'CODIGO'
      Origin = 'CODIGO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      FixedChar = True
      Size = 5
    end
    object ADAEATDELEGACI: TStringField
      FieldName = 'DELEGACI'
      Origin = 'DELEGACI'
      Size = 30
    end
    object ADAEATADMINIST: TStringField
      FieldName = 'ADMINIST'
      Origin = 'ADMINIST'
      Size = 30
    end
  end
  object DSAEAT: TDataSource
    DataSet = ADAEAT
    Left = 128
    Top = 240
  end
end
