inherited FrmMaestroNIFEditor: TFrmMaestroNIFEditor
  ClientHeight = 393
  ClientWidth = 623
  Caption = 'Maestro de NIF'
  ActiveControl = NIF
  ExplicitWidth = 629
  ExplicitHeight = 421
  PixelsPerInch = 96
  TextHeight = 13
  inherited UniPanelPrincipal: TUniPanel
    Width = 623
    Height = 358
    ExplicitWidth = 623
    ExplicitHeight = 358
    object LPFAPELL1: TUniLabel
      Left = 16
      Top = 131
      Width = 69
      Height = 13
      Caption = 'Primer apellido'
      TabOrder = 27
    end
    object LPFAPELL2: TUniLabel
      Left = 206
      Top = 131
      Width = 81
      Height = 13
      Caption = 'Segundo apellido'
      TabOrder = 28
    end
    object LPFNOMBRE: TUniLabel
      Left = 400
      Top = 131
      Width = 37
      Height = 13
      Caption = 'Nombre'
      TabOrder = 29
    end
    object LPJURIDIC: TUniLabel
      Left = 16
      Top = 171
      Width = 59
      Height = 13
      Caption = 'Raz'#243'n social'
      TabOrder = 30
    end
    object Label5: TUniLabel
      Left = 16
      Top = 211
      Width = 14
      Height = 13
      Caption = 'V'#237'a'
      TabOrder = 31
    end
    object Label6: TUniLabel
      Left = 92
      Top = 211
      Width = 80
      Height = 13
      Caption = 'Nombre de la v'#237'a'
      TabOrder = 32
    end
    object Label7: TUniLabel
      Left = 328
      Top = 211
      Width = 37
      Height = 13
      Caption = 'N'#250'mero'
      TabOrder = 33
    end
    object Label8: TUniLabel
      Left = 496
      Top = 211
      Width = 19
      Height = 13
      Caption = 'Piso'
      TabOrder = 34
    end
    object Label9: TUniLabel
      Left = 552
      Top = 211
      Width = 32
      Height = 13
      Caption = 'Puerta'
      TabOrder = 35
    end
    object Label10: TUniLabel
      Left = 16
      Top = 254
      Width = 43
      Height = 13
      Caption = 'C. Postal'
      TabOrder = 36
    end
    object Label11: TUniLabel
      Left = 282
      Top = 254
      Width = 43
      Height = 13
      Caption = 'Municipio'
      TabOrder = 37
    end
    object Label12: TUniLabel
      Left = 106
      Top = 254
      Width = 43
      Height = 13
      Caption = 'Provincia'
      TabOrder = 38
    end
    object Label13: TUniLabel
      Left = 292
      Top = 299
      Width = 51
      Height = 13
      Caption = 'Tel'#233'fono 1'
      TabOrder = 39
    end
    object Label14: TUniLabel
      Left = 452
      Top = 299
      Width = 51
      Height = 13
      Caption = 'Tel'#233'fono 2'
      TabOrder = 40
    end
    object Label15: TUniLabel
      Left = 16
      Top = 48
      Width = 19
      Height = 13
      Caption = 'Pa'#237's'
      TabOrder = 41
    end
    object Label16: TUniLabel
      Left = 95
      Top = 48
      Width = 17
      Height = 13
      Caption = 'NIF'
      TabOrder = 42
    end
    object Label17: TUniLabel
      Left = 440
      Top = 211
      Width = 40
      Height = 13
      Caption = 'Escalera'
      TabOrder = 43
    end
    object Label18: TUniLabel
      Left = 272
      Top = 211
      Width = 32
      Height = 13
      Caption = 'Bloque'
      TabOrder = 44
    end
    object Label19: TUniLabel
      Left = 384
      Top = 211
      Width = 16
      Height = 13
      Caption = 'BIS'
      TabOrder = 45
    end
    object Label20: TUniLabel
      Left = 330
      Top = 254
      Width = 90
      Height = 13
      Caption = 'Municipio (nombre)'
      TabOrder = 46
    end
    object Label21: TUniLabel
      Left = 16
      Top = 91
      Width = 209
      Height = 13
      Caption = 'Clave n'#186' identificaci'#243'n en pa'#237's de residencia'
      TabOrder = 47
    end
    object Label22: TUniLabel
      Left = 18
      Top = 299
      Width = 85
      Height = 13
      Caption = 'Pa'#237's de residencia'
      TabOrder = 48
    end
    object Label23: TUniLabel
      Left = 182
      Top = 299
      Width = 52
      Height = 13
      Caption = 'C'#243'digo ZIP'
      TabOrder = 49
    end
    object Label24: TUniLabel
      Left = 410
      Top = 171
      Width = 195
      Height = 13
      Caption = 'NIF representante del menor de 14 a'#241'os'
      TabOrder = 50
    end
    object PFAPELL1_1: TUniDBEdit
      Left = 16
      Top = 147
      Width = 169
      Height = 22
      DataField = 'PFAPELL1_1'
      DataSource = DSCliente
      TabOrder = 3
    end
    object PFNOMBRE_1: TUniDBEdit
      Left = 400
      Top = 147
      Width = 201
      Height = 22
      DataField = 'PFNOMBRE_1'
      DataSource = DSCliente
      TabOrder = 5
    end
    object PFAPELL2_1: TUniDBEdit
      Left = 206
      Top = 147
      Width = 179
      Height = 22
      DataField = 'PFAPELL2_1'
      DataSource = DSCliente
      TabOrder = 4
    end
    object NUMERO: TUniDBEdit
      Left = 328
      Top = 227
      Width = 49
      Height = 22
      DataField = 'NUMERO'
      DataSource = DSCliente
      TabOrder = 11
    end
    object PISO: TUniDBEdit
      Left = 496
      Top = 227
      Width = 49
      Height = 22
      DataField = 'PISO'
      DataSource = DSCliente
      TabOrder = 14
    end
    object PUERTA: TUniDBEdit
      Left = 552
      Top = 227
      Width = 49
      Height = 22
      DataField = 'PUERTA'
      DataSource = DSCliente
      TabOrder = 15
    end
    object TELEFON1: TUniDBEdit
      Left = 292
      Top = 315
      Width = 150
      Height = 22
      DataField = 'TELEFON1'
      DataSource = DSCliente
      TabOrder = 24
    end
    object TELEFON2: TUniDBEdit
      Left = 452
      Top = 315
      Width = 150
      Height = 22
      DataField = 'TELEFON2'
      DataSource = DSCliente
      TabOrder = 25
    end
    object PJURIDIC_1: TUniDBEdit
      Left = 16
      Top = 187
      Width = 385
      Height = 22
      DataField = 'PJURIDIC_1'
      DataSource = DSCliente
      TabOrder = 6
    end
    object CALLE: TUniDBEdit
      Left = 92
      Top = 227
      Width = 161
      Height = 22
      DataField = 'CALLE'
      DataSource = DSCliente
      TabOrder = 9
    end
    object NIF: TUniDBEdit
      Left = 95
      Top = 64
      Width = 143
      Height = 22
      DataField = 'NIF'
      DataSource = DSCliente
      CharCase = ecUpperCase
      TabOrder = 1
      OnAjaxEvent = NIFAjaxEvent
    end
    object ESCALERA: TUniDBEdit
      Left = 440
      Top = 227
      Width = 49
      Height = 22
      DataField = 'ESCALERA'
      DataSource = DSCliente
      TabOrder = 13
    end
    object CPOSTAL: TUniDBEdit
      Left = 18
      Top = 271
      Width = 55
      Height = 22
      DataField = 'CPOSTAL'
      DataSource = DSCliente
      MaxLength = 5
      TabOrder = 16
    end
    object BLOQUE: TUniDBEdit
      Left = 272
      Top = 227
      Width = 49
      Height = 22
      DataField = 'BLOQUE'
      DataSource = DSCliente
      TabOrder = 10
    end
    object BIS: TUniDBEdit
      Left = 384
      Top = 227
      Width = 49
      Height = 22
      DataField = 'BIS'
      DataSource = DSCliente
      TabOrder = 12
    end
    object CPOBLACI: TUniDBEdit
      Left = 282
      Top = 270
      Width = 43
      Height = 22
      DataField = 'CPOBLACI'
      DataSource = DSCliente
      MaxLength = 5
      TabOrder = 19
      Color = clWhite
    end
    object POBLACIO: TUniDBEdit
      Left = 330
      Top = 270
      Width = 150
      Height = 22
      DataField = 'POBLACIO'
      DataSource = DSCliente
      TabOrder = 20
      ReadOnly = True
    end
    object CODIGO_ZIP: TUniDBEdit
      Left = 182
      Top = 315
      Width = 104
      Height = 22
      DataField = 'CODIGO_ZIP'
      DataSource = DSCliente
      TabOrder = 23
    end
    object CIFREFIS: TUniDBEdit
      Left = 410
      Top = 187
      Width = 103
      Height = 22
      DataField = 'CIFREFIS'
      DataSource = DSCliente
      TabOrder = 7
    end
    object CLAVE_NIF_RESIDENCIA: TUniDBLookupComboBox
      Left = 16
      Top = 107
      Width = 585
      ListField = 'DESCRIPCION'
      ListSource = DSClavesPaisResidencia
      KeyField = 'CLAVE'
      ListFieldIndex = 0
      DataField = 'CLAVE_NIF_RESIDENCIA'
      DataSource = DSCliente
      TabOrder = 2
      Color = clWindow
    end
    object LabelC1: TUniLabel
      Left = 508
      Top = 254
      Width = 32
      Height = 13
      Caption = 'N'#250'cleo'
      TabOrder = 51
    end
    object SIGLA: TUniDBEdit
      Left = 16
      Top = 227
      Width = 41
      Height = 22
      ShowHint = True
      ParentShowHint = False
      DataField = 'SIGLA'
      DataSource = DSCliente
      TabOrder = 8
      Color = clWhite
    end
    object CPROVINC: TUniDBEdit
      Left = 106
      Top = 270
      Width = 140
      Height = 22
      ShowHint = True
      ParentShowHint = False
      DataField = 'CPROVINC'
      DataSource = DSCliente
      TabOrder = 17
      Color = clInfoBk
      ReadOnly = True
    end
    object PAIS: TUniDBEdit
      Left = 16
      Top = 64
      Width = 49
      Height = 22
      DataField = 'PAIS'
      DataSource = DSCliente
      TabOrder = 0
      Color = clWhite
    end
    object CPAIS_RESIDENCIA: TUniDBEdit
      Left = 18
      Top = 315
      Width = 131
      Height = 22
      ShowHint = True
      ParentShowHint = False
      DataField = 'CPAIS_RESIDENCIA'
      DataSource = DSCliente
      TabOrder = 21
      Color = clInfoBk
      ReadOnly = True
    end
    object UBBBuscrSigla: TUniBitBtn
      Left = 57
      Top = 227
      Width = 24
      Height = 24
      Hint = 'Buscar sigla'
      Caption = 'B'
      ParentFont = False
      Font.Height = -16
      Font.Name = 'cai'
      TabStop = False
      TabOrder = 52
      OnClick = UBBBuscrSiglaClick
    end
    object UBBBuscarPais: TUniBitBtn
      Left = 65
      Top = 64
      Width = 24
      Height = 24
      Hint = 'Buscar pa'#237's'
      Caption = 'B'
      ParentFont = False
      Font.Height = -16
      Font.Name = 'cai'
      TabStop = False
      TabOrder = 53
      OnClick = UBBBuscarPaisClick
    end
    object UBBCoigoPostal: TUniBitBtn
      Left = 72
      Top = 270
      Width = 24
      Height = 24
      Hint = 'Buscar c'#243'digo postal'
      Caption = 'B'
      ParentFont = False
      Font.Height = -16
      Font.Name = 'cai'
      TabStop = False
      TabOrder = 54
      OnClick = UBBCoigoPostalClick
    end
    object UBBBuscarPaisResidencia: TUniBitBtn
      Left = 150
      Top = 315
      Width = 24
      Height = 24
      Hint = 'Buscar pais residencia'
      Caption = 'B'
      ParentFont = False
      Font.Height = -16
      Font.Name = 'cai'
      TabStop = False
      TabOrder = 55
      OnClick = UBBBuscarPaisResidenciaClick
    end
    object UniBitBtn4: TUniBitBtn
      Left = 480
      Top = 270
      Width = 24
      Height = 24
      Hint = 'Buscar municipio'
      Caption = 'B'
      ParentFont = False
      Font.Height = -16
      Font.Name = 'cai'
      TabStop = False
      TabOrder = 56
      OnClick = UniBitBtn4Click
    end
    object UBBBuscarProvincia: TUniBitBtn
      Left = 246
      Top = 270
      Width = 24
      Height = 24
      Hint = 'Buscar provincia'
      Caption = 'B'
      ParentFont = False
      Font.Height = -16
      Font.Name = 'cai'
      TabOrder = 18
      OnClick = UBBBuscarProvinciaClick
    end
    object NOMBRE_1: TUniDBText
      Left = 18
      Top = 17
      Width = 54
      Height = 13
      DataField = 'NOMBRE_1'
      DataSource = DSCliente
      ParentFont = False
    end
    object POAMPLIA: TUniDBEdit
      Left = 508
      Top = 270
      Width = 93
      Height = 22
      Hint = 'Ampliaci'#243'n localidad'
      ShowHint = True
      ParentShowHint = False
      Constraints.MaxHeight = 22
      Constraints.MinHeight = 22
      DataField = 'POAMPLIA'
      DataSource = DSCliente
      CharCase = ecUpperCase
      ParentFont = False
      TabOrder = 22
      Color = clWhite
    end
  end
  inherited UniToolBar1: TUniToolBar
    Width = 623
    ExplicitWidth = 623
  end
  inherited ADCliente: TFDQuery
    OnCalcFields = ADClienteCalcFields
    OnNewRecord = ADClienteNewRecord
    Connection = UniMainModule.ADConexionGeneral
    SQL.Strings = (
      'SELECT * FROM DATOSFIS WHERE INTERNO=:INTERNO')
    ParamData = <
      item
        Name = 'INTERNO'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
    object ADClienteINTERNO: TIntegerField
      FieldName = 'INTERNO'
      Origin = 'INTERNO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object ADClientePAIS: TStringField
      FieldName = 'PAIS'
      Origin = 'PAIS'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      OnChange = ADClientePAISChange
      Size = 2
    end
    object ADClienteNIF: TStringField
      FieldName = 'NIF'
      Origin = 'NIF'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Size = 12
    end
    object ADClientePFAPELL1_1: TStringField
      FieldName = 'PFAPELL1_1'
      Origin = 'PFAPELL1_1'
      OnChange = NOMBREChange
      Size = 40
    end
    object ADClientePFAPELL2_1: TStringField
      FieldName = 'PFAPELL2_1'
      Origin = 'PFAPELL2_1'
      OnChange = NOMBREChange
      Size = 40
    end
    object ADClientePFNOMBRE_1: TStringField
      FieldName = 'PFNOMBRE_1'
      Origin = 'PFNOMBRE_1'
      OnChange = NOMBREChange
      Size = 40
    end
    object ADClientePJURIDIC_1: TStringField
      FieldName = 'PJURIDIC_1'
      Origin = 'PJURIDIC_1'
      OnChange = NOMBREChange
      Size = 120
    end
    object ADClienteNOMBRE_1: TStringField
      FieldName = 'NOMBRE_1'
      Origin = 'NOMBRE_1'
      Size = 120
    end
    object ADClienteSIGLA: TStringField
      FieldName = 'SIGLA'
      Origin = 'SIGLA'
      OnChange = ADClienteSIGLAChange
      Size = 2
    end
    object ADClienteCALLE: TStringField
      FieldName = 'CALLE'
      Origin = 'CALLE'
    end
    object ADClienteNUMERO: TStringField
      FieldName = 'NUMERO'
      Origin = 'NUMERO'
      Size = 4
    end
    object ADClienteESCALERA: TStringField
      FieldName = 'ESCALERA'
      Origin = 'ESCALERA'
      Size = 2
    end
    object ADClientePISO: TStringField
      FieldName = 'PISO'
      Origin = 'PISO'
      Size = 2
    end
    object ADClientePUERTA: TStringField
      FieldName = 'PUERTA'
      Origin = 'PUERTA'
      Size = 2
    end
    object ADClienteCPOSTAL: TIntegerField
      FieldName = 'CPOSTAL'
      Origin = 'CPOSTAL'
      OnChange = ADClienteCPOSTALChange
    end
    object ADClienteCPOBLACI: TIntegerField
      FieldName = 'CPOBLACI'
      Origin = 'CPOBLACI'
      OnChange = ADClienteCPOBLACIChange
    end
    object ADClientePOBLACIO: TStringField
      FieldName = 'POBLACIO'
      Origin = 'POBLACIO'
    end
    object ADClienteCPROVINC: TIntegerField
      Alignment = taLeftJustify
      FieldName = 'CPROVINC'
      Origin = 'CPROVINC'
      OnGetText = ADClienteCPROVINCGetText
    end
    object ADClienteTELEFON1: TStringField
      FieldName = 'TELEFON1'
      Origin = 'TELEFON1'
    end
    object ADClienteTELEFON2: TStringField
      FieldName = 'TELEFON2'
      Origin = 'TELEFON2'
    end
    object ADClienteBLOQUE: TStringField
      FieldName = 'BLOQUE'
      Origin = 'BLOQUE'
      Size = 4
    end
    object ADClienteBIS: TStringField
      FieldName = 'BIS'
      Origin = 'BIS'
      Size = 2
    end
    object ADClientePOAMPLIA: TStringField
      FieldName = 'POAMPLIA'
      Origin = 'POAMPLIA'
      Size = 40
    end
    object ADClientePAIS_RESIDENCIA: TStringField
      FieldName = 'PAIS_RESIDENCIA'
      Origin = 'PAIS_RESIDENCIA'
      Size = 2
    end
    object ADClienteCLAVE_NIF_RESIDENCIA: TIntegerField
      FieldName = 'CLAVE_NIF_RESIDENCIA'
      Origin = 'CLAVE_NIF_RESIDENCIA'
    end
    object ADClienteCIFREFIS: TStringField
      FieldName = 'CIFREFIS'
      Origin = 'CIFREFIS'
      Size = 9
    end
    object ADClienteCODIGO_ZIP: TStringField
      FieldName = 'CODIGO_ZIP'
      Origin = 'CODIGO_ZIP'
      Size = 10
    end
    object ADClienteCPAIS_RESIDENCIA: TStringField
      FieldKind = fkCalculated
      FieldName = 'CPAIS_RESIDENCIA'
      Size = 60
      Calculated = True
    end
  end
  object ADClavesPaisResidencia: TFDMemTable
    Active = True
    FieldDefs = <
      item
        Name = 'CLAVE'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'DESCRIPCION'
        DataType = ftString
        Size = 70
      end>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    StoreDefs = True
    Left = 432
    Top = 56
    object ADClavesPaisResidenciaCLAVE: TStringField
      FieldName = 'CLAVE'
      Size = 1
    end
    object ADClavesPaisResidenciaDESCRIPCION: TStringField
      FieldName = 'DESCRIPCION'
      OnGetText = ADClavesPaisResidenciaDESCRIPCIONGetText
      Size = 70
    end
  end
  object DSClavesPaisResidencia: TDataSource
    DataSet = ADClavesPaisResidencia
    Left = 432
    Top = 72
  end
end
