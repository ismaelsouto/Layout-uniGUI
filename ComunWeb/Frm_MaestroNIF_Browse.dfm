inherited FrmMaestroNIFBrowse: TFrmMaestroNIFBrowse
  ClientHeight = 471
  ClientWidth = 813
  Caption = 'Maestro de NIF'
  ActiveControl = NIF
  ExplicitWidth = 829
  ExplicitHeight = 510
  PixelsPerInch = 96
  TextHeight = 13
  inherited Contenedor: TUniPanel
    Width = 813
    Height = 471
    ExplicitWidth = 813
    ExplicitHeight = 471
    inherited PanelFiltro: TUniPanel
      Width = 811
      Height = 65
      ExplicitWidth = 811
      ExplicitHeight = 65
      inherited UBBRestauraFiltro: TUniBitBtn
        Left = 507
        Top = 26
        TabOrder = 4
        ExplicitLeft = 507
        ExplicitTop = 26
      end
      inherited UBBFiltrar: TUniBitBtn
        Left = 484
        Top = 26
        TabOrder = 3
        ExplicitLeft = 484
        ExplicitTop = 26
      end
      object UniLabel1: TUniLabel
        Left = 22
        Top = 12
        Width = 17
        Height = 13
        Caption = 'NIF'
        TabOrder = 5
      end
      object NIF: TUniDBEdit
        Left = 22
        Top = 26
        Width = 121
        Height = 22
        DataField = 'NIF'
        DataSource = DSCamposFiltro
        TabOrder = 1
      end
      object UniLabel2: TUniLabel
        Left = 149
        Top = 12
        Width = 37
        Height = 13
        Caption = 'Nombre'
        TabOrder = 6
      end
      object NOMBRE: TUniDBEdit
        Left = 149
        Top = 26
        Width = 335
        Height = 22
        DataField = 'NOMBRE_1'
        DataSource = DSCamposFiltro
        TabOrder = 2
      end
    end
    inherited UniToolBar1: TUniToolBar
      Width = 811
      ExplicitWidth = 811
    end
    inherited UniDBGrid1: TUniDBGrid
      Top = 101
      Width = 811
      Height = 334
      Columns = <
        item
          FieldName = 'PAIS'
          Title.Caption = 'Pa'#237's'
          Width = 34
        end
        item
          FieldName = 'NIF'
          Title.Caption = 'NIF'
          Width = 76
        end
        item
          FieldName = 'NOMBRE_1'
          Title.Caption = 'Nombre'
          Width = 244
        end>
    end
    inherited UniPanel1: TUniPanel
      Top = 435
      Width = 811
      ExplicitTop = 435
      ExplicitWidth = 811
      inherited UniPanel2: TUniPanel
        Left = 467
        ExplicitLeft = 467
      end
    end
  end
  inherited UniPanelPaginas: TUniPanel
    Left = 542
    Top = 439
    ExplicitLeft = 542
    ExplicitTop = 439
  end
  object UBActualizaNIF: TUniButton [2]
    Left = 720
    Top = 0
    Width = 89
    Height = 33
    Visible = False
    Caption = 'Actualiza NIF'
    Anchors = [akTop, akRight]
    TabOrder = 2
    OnClick = UBActualizaNIFClick
  end
  inherited ADVista: TFDQuery
    Connection = UniMainModule.ADConexionGeneral
    MacroData = <
      item
        Value = 'INTERNO,PAIS,NIF,NOMBRE_1'
        Name = 'CAMPOS'
      end
      item
        Value = 'DATOSFIS'
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
      Origin = 'INTERNO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object ADVistaPAIS: TStringField
      DisplayLabel = 'Pa'#237's'
      FieldName = 'PAIS'
      Origin = 'PAIS'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Size = 2
    end
    object ADVistaNIF: TStringField
      FieldName = 'NIF'
      Origin = 'NIF'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Size = 12
    end
    object ADVistaNOMBRE_1: TStringField
      DisplayLabel = 'Nombre'
      FieldName = 'NOMBRE_1'
      Origin = 'NOMBRE_1'
      Size = 120
    end
  end
  inherited ADCamposFiltro: TFDMemTable
    Active = True
    object ADCamposFiltroNIF: TStringField
      FieldName = 'NIF'
      Size = 12
    end
    object ADCamposFiltroNOMBRE_1: TStringField
      FieldName = 'NOMBRE_1'
      Size = 120
    end
  end
end
