inherited FrmDialogo2: TFrmDialogo2
  ClientHeight = 106
  ClientWidth = 456
  Caption = 'FrmDialogo2'
  ExplicitWidth = 462
  ExplicitHeight = 135
  PixelsPerInch = 96
  TextHeight = 13
  inherited UniPanelPrincipal: TUniPanel
    Width = 456
    Height = 71
    ExplicitWidth = 456
    ExplicitHeight = 71
    object UniLabel1: TUniLabel
      Left = 227
      Top = 6
      Width = 37
      Height = 13
      Hint = ''
      Caption = 'Apellido'
      TabOrder = 1
    end
    object UniDBEdit1: TUniDBEdit
      Left = 227
      Top = 25
      Width = 194
      Height = 22
      Hint = ''
      DataField = 'APELLIDO_PROFESOR'
      DataSource = DSCliente
      TabOrder = 2
    end
    object UniLabel2: TUniLabel
      Left = 15
      Top = 6
      Width = 37
      Height = 13
      Hint = ''
      Caption = 'Nombre'
      TabOrder = 3
    end
    object UniDBEdit2: TUniDBEdit
      Left = 15
      Top = 25
      Width = 194
      Height = 22
      Hint = ''
      DataField = 'NOMBRE_PROFESOR'
      DataSource = DSCliente
      TabOrder = 4
    end
  end
  inherited UniToolBar1: TUniToolBar
    Width = 456
    ExplicitTop = 0
  end
  inherited ADCliente: TFDQuery
    Connection = UniMainModule.FDConnection1
    SQL.Strings = (
      'select *'
      'from profesores'
      'where ID_PROFESOR=:ID_PROFESOR')
    Left = 408
    Top = 8
    ParamData = <
      item
        Name = 'ID_PROFESOR'
        DataType = ftInteger
        ParamType = ptInput
      end>
    object ADClienteID_PROFESOR: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'ID_PROFESOR'
      Origin = 'ID_PROFESOR'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object ADClienteNOMBRE_PROFESOR: TStringField
      FieldName = 'NOMBRE_PROFESOR'
      Origin = 'NOMBRE_PROFESOR'
    end
    object ADClienteAPELLIDO_PROFESOR: TStringField
      FieldName = 'APELLIDO_PROFESOR'
      Origin = 'APELLIDO_PROFESOR'
      Size = 30
    end
  end
  inherited DSCliente: TDataSource
    Left = 344
    Top = 8
  end
end
