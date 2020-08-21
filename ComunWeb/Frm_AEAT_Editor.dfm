inherited FrmAEATEditor: TFrmAEATEditor
  ClientHeight = 116
  ClientWidth = 531
  Caption = 'AEAT'
  ExplicitWidth = 537
  ExplicitHeight = 145
  PixelsPerInch = 96
  TextHeight = 13
  inherited UniPanelPrincipal: TUniPanel
    Width = 531
    Height = 81
    ExplicitWidth = 531
    ExplicitHeight = 81
    object Label1: TUniLabel
      Left = 24
      Top = 16
      Width = 33
      Height = 13
      Hint = ''
      Caption = 'C'#243'digo'
      TabOrder = 4
    end
    object Label2: TUniLabel
      Left = 99
      Top = 16
      Width = 69
      Height = 13
      Hint = ''
      Caption = 'Administraci'#243'n'
      TabOrder = 5
    end
    object Label3: TUniLabel
      Left = 306
      Top = 16
      Width = 52
      Height = 13
      Hint = ''
      Caption = 'Delegaci'#243'n'
      TabOrder = 6
    end
    object CODIGO: TUniDBEdit
      Left = 24
      Top = 32
      Width = 69
      Height = 21
      Hint = ''
      DataField = 'CODIGO'
      DataSource = DSCliente
      TabOrder = 1
    end
    object ADMINIST: TUniDBEdit
      Left = 99
      Top = 32
      Width = 201
      Height = 21
      Hint = ''
      DataField = 'ADMINIST'
      DataSource = DSCliente
      TabOrder = 2
    end
    object DELEGACI: TUniDBEdit
      Left = 306
      Top = 32
      Width = 201
      Height = 21
      Hint = ''
      DataField = 'DELEGACI'
      DataSource = DSCliente
      TabOrder = 3
    end
  end
  inherited UniToolBar1: TUniToolBar
    Width = 531
    ExplicitWidth = 531
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
    SQL.Strings = (
      'SELECT * FROM ADMINIST WHERE CODIGO=:CODIGO')
    ParamData = <
      item
        Name = 'CODIGO'
        DataType = ftFixedChar
        ParamType = ptInput
        Size = 5
        Value = Null
      end>
    object ADClienteCODIGO: TStringField
      FieldName = 'CODIGO'
      Origin = 'CODIGO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      FixedChar = True
      Size = 5
    end
    object ADClienteDELEGACI: TStringField
      FieldName = 'DELEGACI'
      Origin = 'DELEGACI'
      Size = 30
    end
    object ADClienteADMINIST: TStringField
      FieldName = 'ADMINIST'
      Origin = 'ADMINIST'
      Size = 30
    end
  end
end
