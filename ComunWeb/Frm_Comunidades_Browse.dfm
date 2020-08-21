inherited FrmComunidadesBrowse: TFrmComunidadesBrowse
  Caption = 'Comunidades aut'#243'nomas'
  ActiveControl = CODIGO
  PixelsPerInch = 96
  TextHeight = 13
  inherited Contenedor: TUniPanel
    inherited PanelFiltro: TUniPanel
      Height = 52
      ExplicitHeight = 52
      inherited UBBRestauraFiltro: TUniBitBtn
        Left = 442
        Top = 20
        TabOrder = 4
        ExplicitLeft = 442
        ExplicitTop = 20
      end
      inherited UBBFiltrar: TUniBitBtn
        Left = 418
        Top = 20
        TabOrder = 3
        ExplicitLeft = 418
        ExplicitTop = 20
      end
      object UniLabel2: TUniLabel
        Left = 71
        Top = 6
        Width = 37
        Height = 13
        Hint = ''
        Caption = 'Nombre'
        TabOrder = 5
      end
      object NOMBRE: TUniEdit
        Left = 71
        Top = 20
        Width = 347
        Hint = ''
        Text = ''
        TabOrder = 2
        OnKeyDown = FiltroKeyDown
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
      object UniLabel3: TUniLabel
        Left = 16
        Top = 6
        Width = 33
        Height = 13
        Hint = ''
        Caption = 'C'#243'digo'
        TabOrder = 6
      end
    end
    inherited UniDBGrid1: TUniDBGrid
      Top = 88
      Height = 264
      Columns = <
        item
          FieldName = 'CODIGO'
          Title.Caption = 'C'#243'digo'
          Width = 72
        end
        item
          FieldName = 'NOMBRE'
          Title.Caption = 'Nombre'
          Width = 314
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
        Value = 'COMUNIDA'
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
        Value = 'CODIGO'
        Name = 'ORDENACION'
      end>
    object ADVistaCODIGO: TStringField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'CODIGO'
      Origin = 'CODIGO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Size = 2
    end
    object ADVistaNOMBRE: TStringField
      DisplayLabel = 'Nombre'
      FieldName = 'NOMBRE'
      Origin = 'NOMBRE'
      Size = 200
    end
  end
end
