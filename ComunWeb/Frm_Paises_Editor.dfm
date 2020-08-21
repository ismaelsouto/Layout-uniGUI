inherited FrmPaisesEditor: TFrmPaisesEditor
  ClientHeight = 230
  ClientWidth = 522
  Caption = 'Pa'#237'ses'
  ActiveControl = CODIGO
  ExplicitWidth = 528
  ExplicitHeight = 259
  PixelsPerInch = 96
  TextHeight = 13
  inherited UniPanelPrincipal: TUniPanel
    Width = 522
    Height = 195
    ExplicitTop = 39
    ExplicitWidth = 522
    ExplicitHeight = 195
    object Label1: TUniLabel
      Left = 32
      Top = 32
      Width = 33
      Height = 13
      Caption = 'C'#243'digo'
      TabOrder = 8
    end
    object Label2: TUniLabel
      Left = 32
      Top = 76
      Width = 27
      Height = 13
      Caption = 'Clave'
      TabOrder = 9
    end
    object Label3: TUniLabel
      Left = 103
      Top = 33
      Width = 37
      Height = 13
      Caption = 'Nombre'
      TabOrder = 10
    end
    object INTRACOM: TUniDBCheckBox
      Left = 139
      Top = 94
      Width = 97
      Height = 17
      DataField = 'INTRACOM'
      DataSource = DSCliente
      ValueChecked = 'SI'
      ValueUnchecked = 'NO'
      Caption = 'Intracomunitario'
      TabOrder = 4
    end
    object EXTRANJE: TUniDBCheckBox
      Left = 280
      Top = 94
      Width = 97
      Height = 17
      DataField = 'EXTRANJE'
      DataSource = DSCliente
      ValueChecked = 'SI'
      ValueUnchecked = 'NO'
      Caption = 'Extranjero'
      TabOrder = 5
    end
    object PARAISO: TUniDBCheckBox
      Left = 391
      Top = 94
      Width = 97
      Height = 17
      DataField = 'PARAISO'
      DataSource = DSCliente
      ValueChecked = 'SI'
      ValueUnchecked = 'NO'
      Caption = 'Para'#237'so fiscal'
      TabOrder = 6
    end
    object CODIGO: TUniDBEdit
      Left = 32
      Top = 49
      Width = 65
      Height = 21
      DataField = 'CODIGO'
      DataSource = DSCliente
      MaxLength = 5
      TabOrder = 1
    end
    object NOMBRE: TUniDBEdit
      Left = 103
      Top = 48
      Width = 385
      Height = 21
      DataField = 'NOMBRE'
      DataSource = DSCliente
      TabOrder = 2
    end
    object CLAVE: TUniDBEdit
      Left = 32
      Top = 92
      Width = 97
      Height = 21
      DataField = 'CLAVE'
      DataSource = DSCliente
      TabOrder = 3
    end
    object UniLabel1: TUniLabel
      Left = 32
      Top = 124
      Width = 55
      Height = 13
      Caption = 'Clave TGSS'
      TabOrder = 11
    end
    object UniDBEdit1: TUniDBEdit
      Left = 32
      Top = 140
      Width = 97
      Height = 21
      DataField = 'TGSS'
      DataSource = DSCliente
      TabOrder = 7
    end
  end
  inherited UniToolBar1: TUniToolBar
    Width = 522
    ExplicitWidth = 522
  end
  inherited ADCliente: TFDQuery
    OnNewRecord = ADClienteNewRecord
    Connection = UniMainModule.ADConexionGeneral
    SQL.Strings = (
      'SELECT * FROM PAISES WHERE CODIGO=:CODIGO')
    ParamData = <
      item
        Name = 'CODIGO'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
    object ADClienteCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Origin = 'CODIGO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object ADClienteNOMBRE: TStringField
      FieldName = 'NOMBRE'
      Origin = 'NOMBRE'
      Size = 60
    end
    object ADClienteINTRACOM: TStringField
      FieldName = 'INTRACOM'
      Origin = 'INTRACOM'
      FixedChar = True
      Size = 2
    end
    object ADClienteEXTRANJE: TStringField
      FieldName = 'EXTRANJE'
      Origin = 'EXTRANJE'
      FixedChar = True
      Size = 2
    end
    object ADClientePARAISO: TStringField
      FieldName = 'PARAISO'
      Origin = 'PARAISO'
      FixedChar = True
      Size = 2
    end
    object ADClienteCLAVE: TStringField
      FieldName = 'CLAVE'
      Origin = 'CLAVE'
      Size = 2
    end
    object ADClienteDIGITOS: TStringField
      FieldName = 'DIGITOS'
      Origin = 'DIGITOS'
      Size = 40
    end
    object ADClienteSOLO_DIGITOS: TStringField
      FieldName = 'SOLO_DIGITOS'
      Origin = 'SOLO_DIGITOS'
      FixedChar = True
      Size = 2
    end
    object ADClienteTGSS: TIntegerField
      FieldName = 'TGSS'
      Origin = 'TGSS'
    end
  end
end
