inherited FrmComunidadesEditor: TFrmComunidadesEditor
  ClientHeight = 95
  ClientWidth = 322
  Caption = 'Comunidades aut'#243'nomas'
  ExplicitWidth = 328
  ExplicitHeight = 124
  PixelsPerInch = 96
  TextHeight = 13
  inherited UniPanelPrincipal: TUniPanel
    Width = 322
    Height = 60
    ExplicitWidth = 322
    ExplicitHeight = 60
    object Label1: TUniLabel
      Left = 18
      Top = 14
      Width = 33
      Height = 13
      Hint = ''
      Caption = 'C'#243'digo'
      TabOrder = 3
    end
    object Label2: TUniLabel
      Left = 83
      Top = 14
      Width = 37
      Height = 13
      Hint = ''
      Caption = 'Nombre'
      TabOrder = 4
    end
    object CODIGO: TUniDBEdit
      Left = 18
      Top = 30
      Width = 59
      Height = 21
      Hint = ''
      DataField = 'CODIGO'
      DataSource = DSCliente
      TabOrder = 1
    end
    object NOMBRE: TUniDBEdit
      Left = 83
      Top = 30
      Width = 214
      Height = 21
      Hint = ''
      DataField = 'NOMBRE'
      DataSource = DSCliente
      TabOrder = 2
    end
  end
  inherited UniToolBar1: TUniToolBar
    Width = 322
    ExplicitWidth = 322
  end
  inherited ADCliente: TFDQuery
    SQL.Strings = (
      'SELECT * FROM COMUNIDA WHERE CODIGO=:CODIGO')
    Left = 232
    Top = 8
    ParamData = <
      item
        Name = 'CODIGO'
        DataType = ftString
        ParamType = ptInput
        Size = 2
        Value = Null
      end>
    object ADClienteCODIGO: TStringField
      FieldName = 'CODIGO'
      Origin = 'CODIGO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Size = 2
    end
    object ADClienteNOMBRE: TStringField
      FieldName = 'NOMBRE'
      Origin = 'NOMBRE'
      Size = 200
    end
  end
  inherited DSCliente: TDataSource
    Left = 232
    Top = 24
  end
end
