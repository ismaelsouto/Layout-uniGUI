inherited FrmSeleccionEmpresaMaestro: TFrmSeleccionEmpresaMaestro
  ClientHeight = 481
  ClientWidth = 753
  Caption = 'Selecci'#243'n empresa general'
  ActiveControl = UniDBGrid1
  ExplicitWidth = 769
  ExplicitHeight = 520
  DesignSize = (
    753
    481)
  PixelsPerInch = 96
  TextHeight = 13
  inherited Contenedor: TUniPanel
    Width = 753
    Height = 481
    ExplicitWidth = 753
    ExplicitHeight = 481
    inherited PanelFiltro: TUniPanel
      Width = 751
      Height = 54
      ExplicitWidth = 751
      ExplicitHeight = 54
      inherited UBBRestauraFiltro: TUniBitBtn
        Left = 503
        Top = 20
        TabOrder = 4
        ExplicitLeft = 503
        ExplicitTop = 20
      end
      inherited UBBFiltrar: TUniBitBtn
        Left = 479
        Top = 20
        TabOrder = 5
        ExplicitLeft = 479
        ExplicitTop = 20
      end
      object UniLabel1: TUniLabel
        Left = 21
        Top = 5
        Width = 37
        Height = 13
        Hint = ''
        Caption = 'Nombre'
        TabOrder = 6
      end
      object UniLabel2: TUniLabel
        Left = 281
        Top = 5
        Width = 17
        Height = 13
        Hint = ''
        Caption = 'NIF'
        TabOrder = 7
      end
      object EXISTENTE: TUniComboBox
        Left = 408
        Top = 20
        Width = 71
        Hint = ''
        Style = csDropDownList
        Text = 'Todas'
        Items.Strings = (
          'Todas'
          'S'#237
          'No')
        ItemIndex = 0
        TabOrder = 2
        IconItems = <>
      end
      object UniLabel3: TUniLabel
        Left = 408
        Top = 5
        Width = 45
        Height = 13
        Hint = ''
        Caption = 'Existente'
        TabOrder = 8
      end
      object NOMBRCLI: TUniEdit
        Left = 21
        Top = 20
        Width = 253
        Hint = ''
        Text = 'NOMBRCLI'
        TabOrder = 0
      end
      object CIFCLI: TUniEdit
        Left = 281
        Top = 20
        Width = 121
        Hint = ''
        Text = 'CIFCLI'
        TabOrder = 1
      end
    end
    inherited UniToolBar1: TUniToolBar
      Width = 751
      ExplicitWidth = 751
    end
    inherited UniDBGrid1: TUniDBGrid
      Top = 90
      Width = 751
      Height = 355
      Columns = <
        item
          FieldName = 'NOMBRE'
          Title.Caption = 'Nombre'
          Width = 299
        end
        item
          FieldName = 'NIF'
          Title.Caption = 'NIF'
          Width = 140
        end
        item
          FieldName = 'EXISTENTE'
          Title.Caption = ' '
          Width = 32
          Alignment = taLeftJustify
          CheckBoxField.BooleanFieldOnly = False
          CheckBoxField.FieldValues = 'S;N'
          CheckBoxField.DisplayValues = ';'
        end>
    end
    inherited UniPanel1: TUniPanel
      Top = 445
      Width = 751
      ExplicitTop = 445
      ExplicitWidth = 751
      inherited UniPanel2: TUniPanel
        Left = 407
        ExplicitLeft = 407
      end
    end
  end
  inherited UniPanelPaginas: TUniPanel
    Left = 482
    Top = 449
    ExplicitLeft = 482
    ExplicitTop = 449
  end
  inherited ADVista: TFDQuery
    BeforeOpen = ADVistaBeforeOpen
    Connection = ADConnection1
    MacroData = <
      item
        Value = 
          'INTERNO,ADEmpresasGeneral.NIF,NOMBRE,CASE WHEN ADNIFLocal.NIF_AP' +
          'LICACION IS NULL THEN '#39'N'#39' ELSE '#39'S'#39' END EXISTENTE'
        Name = 'CAMPOS'
      end
      item
        Value = 
          'ADEmpresasGeneral LEFT OUTER JOIN ADNIFLocal ON (NIF=NIF_APLICAC' +
          'ION)'
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
    object ADVistaINTERNO: TIntegerField
      FieldName = 'INTERNO'
    end
    object ADVistaNIF: TStringField
      FieldName = 'NIF'
      Size = 12
    end
    object ADVistaNOMBRE: TStringField
      DisplayLabel = 'Nombre'
      FieldName = 'NOMBRE'
      Size = 120
    end
    object ADVistaEXISTENTE: TWideStringField
      DisplayLabel = ' '
      FieldName = 'EXISTENTE'
      Size = 1
    end
  end
  object ADConnection1: TFDConnection
    Params.Strings = (
      'DriverID=SQLite')
    FetchOptions.AssignedValues = [evLiveWindowFastFirst]
    FetchOptions.LiveWindowFastFirst = True
    LoginPrompt = False
    Left = 192
    Top = 216
  end
  object ADLocalSQL1: TFDLocalSQL
    Connection = ADConnection1
    DataSets = <>
    Left = 192
    Top = 240
  end
  object ADNIFLocal: TFDQuery
    LocalSQL = ADLocalSQL1
    SQL.Strings = (
      'SELECT DISTINCT !CAMPO_NIF NIF_APLICACION'
      'FROM !TABLA')
    Left = 424
    Top = 320
    MacroData = <
      item
        Value = Null
        Name = 'CAMPO_NIF'
      end
      item
        Value = Null
        Name = 'TABLA'
      end>
    object ADNIFLocalNIF_APLICACION: TStringField
      FieldName = 'NIF_APLICACION'
      Origin = 'CIFCLI'
      Size = 12
    end
  end
  object ADEmpresasGeneral: TFDQuery
    LocalSQL = ADLocalSQL1
    Connection = UniMainModule.ADConexionGeneral
    SQL.Strings = (
      'SELECT INTERNO,CIFCLI NIF,NOMBRCLI_1 NOMBRE'
      'FROM CLIENTES'
      'WHERE !FILTRO')
    Left = 336
    Top = 320
    MacroData = <
      item
        Value = Null
        Name = 'FILTRO'
      end>
    object ADEmpresasGeneralINTERNO: TIntegerField
      FieldName = 'INTERNO'
      Origin = 'INTERNO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object ADEmpresasGeneralNIF: TStringField
      FieldName = 'NIF'
      Origin = 'CIFCLI'
      Size = 12
    end
    object ADEmpresasGeneralNOMBRE: TStringField
      FieldName = 'NOMBRE'
      Origin = 'NOMBRE'
      Size = 120
    end
  end
end
