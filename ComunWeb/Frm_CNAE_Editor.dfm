inherited FrmCNAEEditor: TFrmCNAEEditor
  ClientHeight = 126
  ClientWidth = 453
  Caption = 'CNAE'
  ActiveControl = NOMBRE
  ExplicitWidth = 459
  ExplicitHeight = 155
  PixelsPerInch = 96
  TextHeight = 13
  inherited UniPanelPrincipal: TUniPanel
    Width = 453
    Height = 91
    ExplicitWidth = 453
    ExplicitHeight = 91
    object CNAE: TUniDBEdit
      Left = 22
      Top = 36
      Width = 81
      Height = 22
      Hint = ''
      DataField = 'CNAE'
      DataSource = DSCliente
      TabOrder = 1
      Color = clInfoBk
      ReadOnly = True
    end
    object UniLabel1: TUniLabel
      Left = 22
      Top = 20
      Width = 27
      Height = 13
      Hint = ''
      Caption = 'CNAE'
      TabOrder = 2
    end
    object UniLabel2: TUniLabel
      Left = 111
      Top = 20
      Width = 37
      Height = 13
      Hint = ''
      Caption = 'Nombre'
      TabOrder = 3
    end
    object NOMBRE: TUniDBEdit
      Left = 111
      Top = 36
      Width = 306
      Height = 22
      Hint = ''
      DataField = 'NOMBRE'
      DataSource = DSCliente
      TabOrder = 4
    end
  end
  inherited UniToolBar1: TUniToolBar
    Width = 453
    ExplicitWidth = 453
  end
  inherited ADCliente: TFDQuery
    OnUpdateRecord = ADClienteUpdateRecord
    Connection = UniMainModule.ADConexionGeneral
    UpdateOptions.UpdateTableName = 'T'
    SQL.Strings = (
      'SELECT *'
      'FROM'
      '(SELECT 5 NIVEL,CNAE,NOMBRE FROM CNAE_NIVEL_5'
      'UNION'
      'SELECT 1 NIVEL,CNAE,NOMBRE FROM CNAE_NIVEL_1'
      'UNION'
      'SELECT 2 NIVEL,CNAE,NOMBRE FROM CNAE_NIVEL_2'
      'UNION'
      'SELECT 3 NIVEL,CNAE,NOMBRE FROM CNAE_NIVEL_3) T'
      'WHERE CNAE=:CNAE')
    Left = 296
    Top = 32
    ParamData = <
      item
        Name = 'CNAE'
        DataType = ftString
        ParamType = ptInput
        Size = 5
        Value = Null
      end>
    object ADClienteNIVEL: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'NIVEL'
      Origin = 'NIVEL'
      ReadOnly = True
    end
    object ADClienteCNAE: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'CNAE'
      Origin = 'CNAE'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Size = 5
    end
    object ADClienteNOMBRE: TStringField
      FieldName = 'NOMBRE'
      Origin = 'NOMBRE'
      Size = 200
    end
    object ADClienteRAIZ: TStringField
      FieldKind = fkInternalCalc
      FieldName = 'RAIZ'
      Size = 3
    end
  end
  inherited DSCliente: TDataSource
    Left = 232
    Top = 24
  end
end
