inherited FrmAEATBrowse: TFrmAEATBrowse
  Caption = 'AEAT'
  ActiveControl = CODIGO
  PixelsPerInch = 96
  TextHeight = 13
  inherited Contenedor: TUniPanel
    inherited PanelFiltro: TUniPanel
      Height = 54
      ExplicitHeight = 54
      inherited UBBRestauraFiltro: TUniBitBtn
        Left = 509
        Top = 20
        TabOrder = 5
        ExplicitLeft = 509
        ExplicitTop = 20
      end
      inherited UBBFiltrar: TUniBitBtn
        Left = 485
        Top = 20
        TabOrder = 4
        ExplicitLeft = 485
        ExplicitTop = 20
      end
      object CODIGO: TUniEdit
        Left = 16
        Top = 20
        Width = 49
        Hint = ''
        Text = ''
        TabOrder = 1
        OnKeyDown = FiltroKeyDown
      end
      object UniLabel2: TUniLabel
        Left = 65
        Top = 6
        Width = 52
        Height = 13
        Hint = ''
        Caption = 'Delegaci'#243'n'
        TabOrder = 6
      end
      object DELEGACI: TUniEdit
        Left = 65
        Top = 20
        Width = 210
        Hint = ''
        Text = ''
        TabOrder = 2
        OnKeyDown = FiltroKeyDown
      end
      object UniLabel3: TUniLabel
        Left = 275
        Top = 6
        Width = 69
        Height = 13
        Hint = ''
        Caption = 'Administraci'#243'n'
        TabOrder = 7
      end
      object ADMINIST: TUniEdit
        Left = 275
        Top = 20
        Width = 210
        Hint = ''
        Text = ''
        TabOrder = 3
        OnKeyDown = FiltroKeyDown
      end
      object UniLabel4: TUniLabel
        Left = 17
        Top = 6
        Width = 33
        Height = 13
        Hint = ''
        Caption = 'C'#243'digo'
        TabOrder = 8
      end
    end
    inherited UniDBGrid1: TUniDBGrid
      Top = 90
      Height = 262
      Columns = <
        item
          FieldName = 'CODIGO'
          Title.Caption = 'C'#243'digo'
          Width = 139
        end
        item
          FieldName = 'DELEGACI'
          Title.Caption = 'Delegaci'#243'n'
          Width = 184
        end
        item
          FieldName = 'ADMINIST'
          Title.Caption = 'Administraci'#243'n'
          Width = 184
        end>
    end
  end
  inherited ADVista: TFDQuery
    MacroData = <
      item
        Value = '*'
        Name = 'CAMPOS'
      end
      item
        Value = 'ADMINIST'
        Name = 'TABLA'
      end
      item
        Value = Null
        Name = 'FILTRO'
      end
      item
        Value = Null
        Name = 'GRUPO'
      end
      item
        Value = Null
        Name = 'ORDENACION'
      end>
    object ADVistaCODIGO: TStringField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'CODIGO'
      Origin = 'CODIGO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      FixedChar = True
      Size = 5
    end
    object ADVistaDELEGACI: TStringField
      DisplayLabel = 'Delegaci'#243'n'
      FieldName = 'DELEGACI'
      Origin = 'DELEGACI'
      Size = 30
    end
    object ADVistaADMINIST: TStringField
      DisplayLabel = 'Administraci'#243'n'
      FieldName = 'ADMINIST'
      Origin = 'ADMINIST'
      Size = 30
    end
  end
end
