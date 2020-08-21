inherited FrmEmpresascaicontaweb: TFrmEmpresascaicontaweb
  ClientHeight = 457
  ClientWidth = 618
  Caption = 'Empresas caicontaweb'
  ExplicitWidth = 634
  ExplicitHeight = 496
  PixelsPerInch = 96
  TextHeight = 13
  inherited Contenedor: TUniPanel
    Width = 618
    Height = 457
    ExplicitWidth = 618
    ExplicitHeight = 457
    inherited PanelFiltro: TUniPanel
      Width = 616
      Height = 51
      ExplicitTop = 29
      ExplicitWidth = 668
      ExplicitHeight = 51
      inherited UBBRestauraFiltro: TUniBitBtn
        Left = 558
        Top = 21
        ExplicitLeft = 558
        ExplicitTop = 21
      end
      inherited UBBFiltrar: TUniBitBtn
        Left = 534
        Top = 21
        ExplicitLeft = 534
        ExplicitTop = 21
      end
      object NIF: TUniEdit
        Left = 424
        Top = 21
        Width = 110
        Hint = ''
        Text = ''
        TabOrder = 3
      end
      object UniLabel3: TUniLabel
        Left = 424
        Top = 6
        Width = 17
        Height = 13
        Hint = ''
        Caption = 'NIF'
        TabOrder = 4
      end
      object NOMBRE: TUniEdit
        Left = 71
        Top = 21
        Width = 347
        Hint = ''
        Text = ''
        TabOrder = 5
      end
      object UniLabel2: TUniLabel
        Left = 71
        Top = 6
        Width = 37
        Height = 13
        Hint = ''
        Caption = 'Nombre'
        TabOrder = 6
      end
      object UniLabel4: TUniLabel
        Left = 16
        Top = 6
        Width = 33
        Height = 13
        Hint = ''
        Caption = 'C'#243'digo'
        TabOrder = 7
      end
      object CODIGO: TUniEdit
        Left = 16
        Top = 21
        Width = 49
        Hint = ''
        Text = ''
        TabOrder = 8
      end
    end
    inherited UniToolBar1: TUniToolBar
      Width = 616
      ExplicitWidth = 616
    end
    inherited UniDBGrid1: TUniDBGrid
      Top = 86
      Width = 616
      Height = 336
      Columns = <
        item
          FieldName = 'CODIGO_EMPRESA'
          Title.Caption = 'Codigo'
          Width = 64
        end
        item
          FieldName = 'NOMBRE_COMPLETO'
          Title.Caption = 'Nombre'
          Width = 287
        end
        item
          FieldName = 'CIF'
          Title.Caption = 'NIF'
          Width = 97
        end>
    end
    inherited UniPanel1: TUniPanel
      Top = 422
      Width = 616
      ExplicitTop = 422
      ExplicitWidth = 616
      inherited UniPanel2: TUniPanel
        Left = 272
        ExplicitLeft = 272
      end
    end
  end
  inherited UniPanelPaginas: TUniPanel
    Left = 347
    Top = 425
    ExplicitLeft = 347
    ExplicitTop = 425
  end
  inherited ADVista: TFDQuery
    MacroData = <
      item
        Value = 'CODIGO_EMPRESA,NOMBRE_COMPLETO,CIF'
        Name = 'CAMPOS'
      end
      item
        Value = 
          'CLIENTES INNER JOIN (SELECT DISTINCT IDF,CODIGO_EMPRESA FROM DAT' +
          'OS_PRIVADOS_EMPRESA) T ON (T.IDF=CLIENTES.ID)'
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
        Value = 'CODIGO_EMPRESA DESC'
        Name = 'ORDENACION'
      end>
    object ADVistaCODIGO_EMPRESA: TIntegerField
      DisplayLabel = 'Codigo'
      FieldName = 'CODIGO_EMPRESA'
      Origin = 'CODIGO_EMPRESA'
      Required = True
    end
    object ADVistaNOMBRE_COMPLETO: TStringField
      DisplayLabel = 'Nombre'
      FieldName = 'NOMBRE_COMPLETO'
      Origin = 'NOMBRE_COMPLETO'
      Size = 43
    end
    object ADVistaCIF: TStringField
      DisplayLabel = 'NIF'
      FieldName = 'CIF'
      Origin = 'CIF'
      Size = 12
    end
  end
end
