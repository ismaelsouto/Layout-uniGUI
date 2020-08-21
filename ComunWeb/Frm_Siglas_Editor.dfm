inherited FrmSiglasEditor: TFrmSiglasEditor
  ClientHeight = 104
  ClientWidth = 322
  Caption = 'Siglas'
  ExplicitWidth = 328
  ExplicitHeight = 133
  PixelsPerInch = 96
  TextHeight = 13
  inherited UniPanelPrincipal: TUniPanel
    Width = 322
    Height = 69
    ExplicitWidth = 322
    ExplicitHeight = 69
    object Label1: TUniLabel
      Left = 18
      Top = 14
      Width = 33
      Height = 13
      Hint = ''
      Caption = 'C'#243'digo'
      TabOrder = 1
    end
    object CODIGO: TUniDBEdit
      Left = 18
      Top = 30
      Width = 59
      Height = 21
      Hint = ''
      DataField = 'CODIGO'
      DataSource = DSCliente
      TabOrder = 2
    end
    object Label2: TUniLabel
      Left = 83
      Top = 14
      Width = 37
      Height = 13
      Hint = ''
      Caption = 'Nombre'
      TabOrder = 3
    end
    object NOMBRE: TUniDBEdit
      Left = 83
      Top = 30
      Width = 214
      Height = 21
      Hint = ''
      DataField = 'NOMBRE'
      DataSource = DSCliente
      TabOrder = 4
    end
  end
  inherited UniToolBar1: TUniToolBar
    Width = 322
    ExplicitWidth = 322
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
    Connection = UniMainModule.ADConexionGeneral
    SQL.Strings = (
      'SELECT * FROM SIGLAS WHERE CODIGO=:CODIGO')
    Left = 192
    ParamData = <
      item
        Name = 'CODIGO'
        DataType = ftFixedChar
        ParamType = ptInput
        Size = 2
        Value = Null
      end>
    object ADClienteCODIGO: TStringField
      FieldName = 'CODIGO'
      Origin = 'CODIGO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      FixedChar = True
      Size = 2
    end
    object ADClienteNOMBRE: TStringField
      FieldName = 'NOMBRE'
      Origin = 'NOMBRE'
      Size = 25
    end
  end
  inherited DSCliente: TDataSource
    Left = 240
  end
end
