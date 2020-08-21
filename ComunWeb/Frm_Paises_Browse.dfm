inherited FrmPaisesBrowse: TFrmPaisesBrowse
  ClientWidth = 928
  Caption = 'Pa'#237'ses'
  ActiveControl = CLAVE
  ExplicitWidth = 944
  PixelsPerInch = 96
  TextHeight = 13
  inherited Contenedor: TUniPanel
    Width = 928
    ExplicitWidth = 928
    inherited PanelFiltro: TUniPanel
      Width = 926
      Height = 56
      ExplicitWidth = 926
      ExplicitHeight = 56
      inherited UBBRestauraFiltro: TUniBitBtn
        Left = 535
        Top = 22
        TabOrder = 4
        ExplicitLeft = 535
        ExplicitTop = 22
      end
      inherited UBBFiltrar: TUniBitBtn
        Left = 509
        Top = 22
        TabOrder = 3
        ExplicitLeft = 509
        ExplicitTop = 22
      end
      object CODIGO: TUniEdit
        Left = 457
        Top = 22
        Width = 52
        Height = 23
        Hint = ''
        Text = ''
        TabOrder = 2
        OnKeyDown = FiltroKeyDown
      end
      object UniLabel2: TUniLabel
        Left = 76
        Top = 6
        Width = 37
        Height = 13
        Hint = ''
        Caption = 'Nombre'
        TabOrder = 7
      end
      object NOMBRE: TUniEdit
        Left = 76
        Top = 22
        Width = 374
        Height = 23
        Hint = ''
        Text = ''
        TabOrder = 1
        OnKeyDown = FiltroKeyDown
      end
      object UniLabel3: TUniLabel
        Left = 457
        Top = 6
        Width = 33
        Height = 13
        Hint = ''
        Caption = 'C'#243'digo'
        TabOrder = 8
      end
      object UniLabel1: TUniLabel
        Left = 17
        Top = 6
        Width = 27
        Height = 13
        Hint = ''
        Caption = 'Clave'
        TabOrder = 5
      end
      object CLAVE: TUniEdit
        Left = 17
        Top = 22
        Width = 53
        Height = 23
        Hint = ''
        Text = ''
        TabOrder = 0
        OnKeyDown = FiltroKeyDown
      end
    end
    inherited UniToolBar1: TUniToolBar
      Width = 926
      ButtonWidth = 37
      ExplicitWidth = 926
      inherited UBAnadir: TUniToolButton
        ExplicitWidth = 37
      end
      inherited UBModificar: TUniToolButton
        Left = 37
        ExplicitLeft = 37
        ExplicitWidth = 37
      end
      inherited UBSeleccionar: TUniToolButton
        Left = 74
        ExplicitLeft = 74
        ExplicitWidth = 37
      end
      inherited UBConsultar: TUniToolButton
        Left = 111
        ExplicitLeft = 111
        ExplicitWidth = 37
      end
      inherited UBEliminar: TUniToolButton
        Left = 148
        ExplicitLeft = 148
        ExplicitWidth = 37
      end
      inherited UniToolButton4: TUniToolButton
        Left = 185
        ExplicitLeft = 185
      end
      inherited UBPrimero: TUniToolButton
        Left = 215
        ExplicitLeft = 215
        ExplicitWidth = 37
      end
      inherited UBAnterior: TUniToolButton
        Left = 252
        ExplicitLeft = 252
        ExplicitWidth = 37
      end
      inherited UBSiguiente: TUniToolButton
        Left = 289
        ExplicitLeft = 289
        ExplicitWidth = 37
      end
      inherited UBUltimo: TUniToolButton
        Left = 326
        ExplicitLeft = 326
        ExplicitWidth = 37
      end
      inherited UniToolButton11: TUniToolButton
        Left = 363
        ExplicitLeft = 363
      end
      inherited UBImprimir: TUniToolButton
        Left = 393
        ExplicitLeft = 393
        ExplicitWidth = 37
      end
      inherited UBExportarExcel: TUniToolButton
        Left = 430
        ExplicitLeft = 430
        ExplicitWidth = 37
      end
      inherited UniToolButton9: TUniToolButton
        Left = 467
        ExplicitLeft = 467
      end
      inherited UBSalir: TUniToolButton
        Left = 497
        ExplicitLeft = 497
        ExplicitWidth = 37
      end
    end
    inherited UniDBGrid1: TUniDBGrid
      Top = 92
      Width = 926
      Height = 260
      Columns = <
        item
          FieldName = 'CLAVE'
          Title.Caption = 'Clave'
          Title.Font.Height = -12
          Width = 68
          Font.Height = -12
        end
        item
          FieldName = 'NOMBRE'
          Title.Caption = 'Nombre'
          Title.Font.Height = -12
          Width = 335
          Font.Height = -12
        end
        item
          FieldName = 'INTRACOM'
          Title.Caption = 'Intracomunitario'
          Title.Font.Height = -12
          Width = 83
          Font.Height = -12
        end
        item
          FieldName = 'EXTRANJE'
          Title.Caption = 'Extranjero'
          Title.Font.Height = -12
          Width = 55
          Font.Height = -12
        end
        item
          FieldName = 'PARAISO'
          Title.Caption = 'Para'#237'so fiscal'
          Title.Font.Height = -12
          Width = 66
          Font.Height = -12
        end
        item
          FieldName = 'CODIGO'
          Title.Caption = 'C'#243'digo'
          Title.Font.Height = -12
          Width = 84
          Font.Height = -12
        end
        item
          FieldName = 'TGSS'
          Title.Caption = 'C'#243'digo TGSS'
          Title.Font.Height = -12
          Width = 97
          Font.Height = -12
        end>
    end
    inherited UniPanel1: TUniPanel
      Width = 926
      ExplicitWidth = 926
      inherited UniPanel2: TUniPanel
        Left = 582
        ExplicitLeft = 582
      end
    end
  end
  inherited UniPanelPaginas: TUniPanel
    Left = 655
    ExplicitLeft = 655
  end
  inherited ADVista: TFDQuery
    Connection = UniMainModule.ADConexionGeneral
    MacroData = <
      item
        Value = '*'
        Name = 'CAMPOS'
      end
      item
        Value = 'PAISES'
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
        Value = 'CLAVE DESC'
        Name = 'ORDENACION'
      end>
    object ADVistaCODIGO: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'CODIGO'
      Origin = 'CODIGO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object ADVistaNOMBRE: TStringField
      DisplayLabel = 'Nombre'
      FieldName = 'NOMBRE'
      Origin = 'NOMBRE'
      Size = 60
    end
    object ADVistaINTRACOM: TStringField
      DisplayLabel = 'Intracomunitario'
      FieldName = 'INTRACOM'
      Origin = 'INTRACOM'
      FixedChar = True
      Size = 2
    end
    object ADVistaEXTRANJE: TStringField
      DisplayLabel = 'Extranjero'
      FieldName = 'EXTRANJE'
      Origin = 'EXTRANJE'
      FixedChar = True
      Size = 2
    end
    object ADVistaPARAISO: TStringField
      DisplayLabel = 'Para'#237'so fiscal'
      FieldName = 'PARAISO'
      Origin = 'PARAISO'
      FixedChar = True
      Size = 2
    end
    object ADVistaCLAVE: TStringField
      DisplayLabel = 'Clave'
      FieldName = 'CLAVE'
      Origin = 'CLAVE'
      Size = 2
    end
    object ADVistaDIGITOS: TStringField
      FieldName = 'DIGITOS'
      Origin = 'DIGITOS'
      Size = 40
    end
    object ADVistaSOLO_DIGITOS: TStringField
      FieldName = 'SOLO_DIGITOS'
      Origin = 'SOLO_DIGITOS'
      FixedChar = True
      Size = 2
    end
    object ADVistaTGSS: TIntegerField
      FieldName = 'TGSS'
      Origin = 'TGSS'
    end
  end
  inherited DSCamposFiltro: TDataSource
    Left = 432
    Top = 264
  end
end
