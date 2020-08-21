inherited FrmEpigrafesEditor: TFrmEpigrafesEditor
  ClientHeight = 375
  ClientWidth = 540
  Caption = 'Ep'#237'grafes'
  ExplicitWidth = 546
  ExplicitHeight = 404
  PixelsPerInch = 96
  TextHeight = 13
  inherited UniPanelPrincipal: TUniPanel
    Width = 540
    Height = 340
    ExplicitLeft = -8
    ExplicitTop = 0
    ExplicitWidth = 540
    ExplicitHeight = 340
    object UniDBLookupComboBox1: TUniDBLookupComboBox
      Left = 15
      Top = 22
      Width = 178
      Hint = ''
      ListField = 'DESCRIPCION'
      ListSource = DSTipos
      KeyField = 'TIPO'
      ListFieldIndex = 0
      DataField = 'TIPO'
      DataSource = DSCliente
      TabOrder = 1
      Color = clWindow
    end
    object UniLabel1: TUniLabel
      Left = 15
      Top = 7
      Width = 20
      Height = 13
      Hint = ''
      Caption = 'Tipo'
      TabOrder = 2
    end
    object EPIGRAFE: TUniDBEdit
      Left = 208
      Top = 22
      Width = 90
      Height = 22
      Hint = ''
      DataField = 'EPIGRAFE'
      DataSource = DSCliente
      TabOrder = 3
    end
    object UniLabel2: TUniLabel
      Left = 208
      Top = 7
      Width = 40
      Height = 13
      Hint = ''
      Caption = 'Ep'#237'grafe'
      TabOrder = 4
    end
    object NOMBRE: TUniDBEdit
      Left = 15
      Top = 67
      Width = 502
      Height = 22
      Hint = ''
      DataField = 'NOMBRE'
      DataSource = DSCliente
      TabOrder = 5
    end
    object UniLabel3: TUniLabel
      Left = 15
      Top = 52
      Width = 37
      Height = 13
      Hint = ''
      Caption = 'Nombre'
      TabOrder = 6
    end
    object UniLabel4: TUniLabel
      Left = 15
      Top = 97
      Width = 76
      Height = 13
      Hint = ''
      Caption = 'CNAE de nivel 2'
      TabOrder = 7
    end
    object CCNAE_NIVEL_2_1: TUniDBEdit
      Left = 15
      Top = 112
      Width = 478
      Height = 22
      Hint = ''
      DataField = 'CCNAE_NIVEL_2_1'
      DataSource = DSCliente
      TabOrder = 8
      Color = clInfoBk
      ReadOnly = True
    end
    object UBBuscarCNAE2_1: TUniBitBtn
      Left = 493
      Top = 112
      Width = 24
      Height = 24
      Hint = 'Buscar CNAE nivel 2'
      ShowHint = True
      ParentShowHint = False
      Caption = 'B'
      ParentFont = False
      Font.Height = -15
      Font.Name = 'cai'
      TabStop = False
      TabOrder = 9
      OnClick = UBBuscarCNAE2_1Click
    end
    object UniLabel5: TUniLabel
      Left = 15
      Top = 142
      Width = 76
      Height = 13
      Hint = ''
      Caption = 'CNAE de nivel 2'
      TabOrder = 10
    end
    object CCNAE_NIVEL_2_2: TUniDBEdit
      Left = 15
      Top = 157
      Width = 478
      Height = 22
      Hint = ''
      DataField = 'CCNAE_NIVEL_2_2'
      DataSource = DSCliente
      TabOrder = 11
      Color = clInfoBk
      ReadOnly = True
    end
    object UBBuscarCNAE2_2: TUniBitBtn
      Left = 493
      Top = 157
      Width = 24
      Height = 24
      Hint = 'Buscar CNAE nivel 2'
      ShowHint = True
      ParentShowHint = False
      Caption = 'B'
      ParentFont = False
      Font.Height = -15
      Font.Name = 'cai'
      TabStop = False
      TabOrder = 12
      OnClick = UBBuscarCNAE2_2Click
    end
    object UniLabel6: TUniLabel
      Left = 15
      Top = 187
      Width = 76
      Height = 13
      Hint = ''
      Caption = 'CNAE de nivel 2'
      TabOrder = 13
    end
    object CCNAE_NIVEL_2_3: TUniDBEdit
      Left = 15
      Top = 202
      Width = 478
      Height = 22
      Hint = ''
      DataField = 'CCNAE_NIVEL_2_3'
      DataSource = DSCliente
      TabOrder = 14
      Color = clInfoBk
      ReadOnly = True
    end
    object UBBuscarCNAE2_3: TUniBitBtn
      Left = 493
      Top = 202
      Width = 24
      Height = 24
      Hint = 'Buscar CNAE nivel 2'
      ShowHint = True
      ParentShowHint = False
      Caption = 'B'
      ParentFont = False
      Font.Height = -15
      Font.Name = 'cai'
      TabStop = False
      TabOrder = 15
      OnClick = UBBuscarCNAE2_3Click
    end
    object UniLabel7: TUniLabel
      Left = 15
      Top = 232
      Width = 76
      Height = 13
      Hint = ''
      Caption = 'CNAE de nivel 3'
      TabOrder = 16
    end
    object CCNAE_NIVEL_3_1: TUniDBEdit
      Left = 15
      Top = 247
      Width = 478
      Height = 22
      Hint = ''
      DataField = 'CCNAE_NIVEL_3_1'
      DataSource = DSCliente
      TabOrder = 17
      Color = clInfoBk
      ReadOnly = True
    end
    object UBBuscarCNAE3: TUniBitBtn
      Left = 493
      Top = 247
      Width = 24
      Height = 24
      Hint = 'Buscar CNAE nivel 3'
      ShowHint = True
      ParentShowHint = False
      Caption = 'B'
      ParentFont = False
      Font.Height = -15
      Font.Name = 'cai'
      TabStop = False
      TabOrder = 18
      OnClick = UBBuscarCNAE3Click
    end
    object UniLabel8: TUniLabel
      Left = 15
      Top = 277
      Width = 76
      Height = 13
      Hint = ''
      Caption = 'CNAE de nivel 5'
      TabOrder = 19
    end
    object CCNAE_NIVEL_5_1: TUniDBEdit
      Left = 15
      Top = 292
      Width = 478
      Height = 22
      Hint = ''
      DataField = 'CCNAE_NIVEL_5_1'
      DataSource = DSCliente
      TabOrder = 20
      Color = clInfoBk
      ReadOnly = True
    end
    object UBBuscarCNAE5: TUniBitBtn
      Left = 493
      Top = 292
      Width = 24
      Height = 24
      Hint = 'Buscar CNAE nivel 5'
      ShowHint = True
      ParentShowHint = False
      Caption = 'B'
      ParentFont = False
      Font.Height = -15
      Font.Name = 'cai'
      TabStop = False
      TabOrder = 21
      OnClick = UBBuscarCNAE5Click
    end
  end
  inherited UniToolBar1: TUniToolBar
    Width = 540
    ExplicitWidth = 540
  end
  inherited ADCliente: TFDQuery
    OnCalcFields = ADClienteCalcFields
    OnNewRecord = ADClienteNewRecord
    SQL.Strings = (
      'SELECT * FROM EPIGRAFES WHERE TIPO=:TIPO AND EPIGRAFE=:EPIGRAFE')
    ParamData = <
      item
        Name = 'TIPO'
        DataType = ftString
        ParamType = ptInput
        Size = 1
        Value = Null
      end
      item
        Name = 'EPIGRAFE'
        DataType = ftString
        ParamType = ptInput
        Size = 5
      end>
    object ADClienteTIPO: TStringField
      FieldName = 'TIPO'
      Origin = 'TIPO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Size = 1
    end
    object ADClienteEPIGRAFE: TStringField
      FieldName = 'EPIGRAFE'
      Origin = 'EPIGRAFE'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Size = 5
    end
    object ADClienteNOMBRE: TStringField
      FieldName = 'NOMBRE'
      Origin = 'NOMBRE'
      Size = 200
    end
    object ADClienteIMPRIMIR: TStringField
      FieldName = 'IMPRIMIR'
      Origin = 'IMPRIMIR'
      Size = 5
    end
    object ADClienteCNAE_NIVEL_2_1: TStringField
      FieldName = 'CNAE_NIVEL_2_1'
      Origin = 'CNAE_NIVEL_2_1'
      Size = 2
    end
    object ADClienteCNAE_NIVEL_2_2: TStringField
      FieldName = 'CNAE_NIVEL_2_2'
      Origin = 'CNAE_NIVEL_2_2'
      Size = 2
    end
    object ADClienteCNAE_NIVEL_2_3: TStringField
      FieldName = 'CNAE_NIVEL_2_3'
      Origin = 'CNAE_NIVEL_2_3'
      Size = 2
    end
    object ADClienteCNAE_NIVEL_2_4: TStringField
      FieldName = 'CNAE_NIVEL_2_4'
      Origin = 'CNAE_NIVEL_2_4'
      Size = 2
    end
    object ADClienteCNAE_NIVEL_2_5: TStringField
      FieldName = 'CNAE_NIVEL_2_5'
      Origin = 'CNAE_NIVEL_2_5'
      Size = 2
    end
    object ADClienteCNAE_NIVEL_3_1: TStringField
      FieldName = 'CNAE_NIVEL_3_1'
      Origin = 'CNAE_NIVEL_3_1'
      Size = 3
    end
    object ADClienteCNAE_NIVEL_5_1: TStringField
      FieldName = 'CNAE_NIVEL_5_1'
      Origin = 'CNAE_NIVEL_5_1'
      Size = 5
    end
    object ADClienteCCNAE_NIVEL_2_1: TStringField
      FieldKind = fkCalculated
      FieldName = 'CCNAE_NIVEL_2_1'
      Size = 208
      Calculated = True
    end
    object ADClienteCCNAE_NIVEL_2_2: TStringField
      FieldKind = fkCalculated
      FieldName = 'CCNAE_NIVEL_2_2'
      Size = 208
      Calculated = True
    end
    object ADClienteCCNAE_NIVEL_2_3: TStringField
      FieldKind = fkCalculated
      FieldName = 'CCNAE_NIVEL_2_3'
      Size = 208
      Calculated = True
    end
    object ADClienteCCNAE_NIVEL_2_4: TStringField
      FieldKind = fkCalculated
      FieldName = 'CCNAE_NIVEL_2_4'
      Size = 208
      Calculated = True
    end
    object ADClienteCCNAE_NIVEL_2_5: TStringField
      FieldKind = fkCalculated
      FieldName = 'CCNAE_NIVEL_2_5'
      Size = 208
      Calculated = True
    end
    object ADClienteCCNAE_NIVEL_3_1: TStringField
      FieldKind = fkCalculated
      FieldName = 'CCNAE_NIVEL_3_1'
      Size = 208
      Calculated = True
    end
    object ADClienteCCNAE_NIVEL_5_1: TStringField
      FieldKind = fkCalculated
      FieldName = 'CCNAE_NIVEL_5_1'
      Size = 208
      Calculated = True
    end
  end
  object ADTipos: TFDMemTable
    Active = True
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    Left = 400
    Top = 48
    object ADTiposTIPO: TStringField
      FieldName = 'TIPO'
      Size = 1
    end
    object ADTiposDESCRIPCION: TStringField
      FieldName = 'DESCRIPCION'
      Size = 12
    end
  end
  object DSTipos: TDataSource
    DataSet = ADTipos
    Left = 400
    Top = 64
  end
end
