inherited FrmSiglasBrowse: TFrmSiglasBrowse
  ClientWidth = 644
  Caption = 'Siglas'
  ActiveControl = CODIGO
  ExplicitWidth = 660
  PixelsPerInch = 96
  TextHeight = 13
  inherited Contenedor: TUniPanel
    Width = 644
    ExplicitWidth = 644
    inherited PanelFiltro: TUniPanel
      Width = 642
      Height = 52
      ExplicitWidth = 642
      ExplicitHeight = 52
      inherited UBBRestauraFiltro: TUniBitBtn
        Left = 305
        Top = 20
        TabOrder = 4
        ExplicitLeft = 305
        ExplicitTop = 20
      end
      inherited UBBFiltrar: TUniBitBtn
        Left = 281
        Top = 20
        TabOrder = 3
        ExplicitLeft = 281
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
        Width = 210
        Hint = ''
        Text = ''
        TabOrder = 2
        OnKeyDown = FiltroKeyDown
      end
      object UniLabel3: TUniLabel
        Left = 16
        Top = 6
        Width = 22
        Height = 13
        Hint = ''
        Caption = 'Sigla'
        TabOrder = 6
      end
    end
    inherited UniToolBar1: TUniToolBar
      Width = 642
      ExplicitWidth = 642
    end
    inherited UniDBGrid1: TUniDBGrid
      Top = 88
      Width = 642
      Height = 264
      Columns = <
        item
          FieldName = 'CODIGO'
          Title.Caption = 'Sigla'
          Width = 26
        end
        item
          FieldName = 'NOMBRE'
          Title.Caption = 'Nombre'
          Width = 154
        end>
    end
    inherited UniPanel1: TUniPanel
      Width = 642
      ExplicitWidth = 642
      inherited UniPanel2: TUniPanel
        Left = 298
        ExplicitLeft = 298
      end
    end
  end
  inherited UniPanelPaginas: TUniPanel
    Left = 369
    Top = 354
    ExplicitLeft = 369
    ExplicitTop = 354
  end
  inherited ADVista: TFDQuery
    Connection = UniMainModule.ADConexionGeneral
    MacroData = <
      item
        Value = '*'
        Name = 'CAMPOS'
      end
      item
        Value = 'SIGLAS'
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
      DisplayLabel = 'Sigla'
      FieldName = 'CODIGO'
      Origin = 'CODIGO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      FixedChar = True
      Size = 2
    end
    object ADVistaNOMBRE: TStringField
      DisplayLabel = 'Nombre'
      FieldName = 'NOMBRE'
      Origin = 'NOMBRE'
      Size = 25
    end
  end
end
