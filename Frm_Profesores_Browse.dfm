inherited FrmProfesoresBrowse: TFrmProfesoresBrowse
  ClientHeight = 494
  ClientWidth = 1094
  Caption = 'FrmProfesoresBrowse'
  ExplicitWidth = 1110
  ExplicitHeight = 533
  PixelsPerInch = 96
  TextHeight = 13
  inherited Contenedor: TUniPanel
    Width = 1094
    Height = 494
    ExplicitWidth = 733
    ExplicitHeight = 494
    inherited PanelFiltro: TUniPanel
      Width = 1092
      Height = 69
      ExplicitWidth = 731
      ExplicitHeight = 69
      inherited UBBRestauraFiltro: TUniBitBtn
        Left = 451
        Top = 33
        Visible = False
        ExplicitLeft = 451
        ExplicitTop = 33
      end
      inherited UBBFiltrar: TUniBitBtn
        Left = 427
        Top = 33
        Visible = False
        ExplicitLeft = 427
        ExplicitTop = 33
      end
      object UniDBEdit1: TUniDBEdit
        Left = 15
        Top = 33
        Width = 194
        Height = 22
        Hint = ''
        DataField = 'APELLIDO_PROFESOR'
        DataSource = DSCamposFiltro
        TabOrder = 3
      end
      object UniDBEdit2: TUniDBEdit
        Left = 227
        Top = 33
        Width = 194
        Height = 22
        Hint = ''
        DataField = 'NOMBRE_PROFESOR'
        DataSource = DSCamposFiltro
        TabOrder = 4
      end
      object UniLabel1: TUniLabel
        Left = 15
        Top = 18
        Width = 37
        Height = 13
        Hint = ''
        Caption = 'Apellido'
        TabOrder = 5
      end
      object UniLabel2: TUniLabel
        Left = 227
        Top = 18
        Width = 37
        Height = 13
        Hint = ''
        Caption = 'Nombre'
        TabOrder = 6
      end
    end
    inherited UniToolBar1: TUniToolBar
      Width = 1092
      ButtonWidth = 154
      ExplicitWidth = 731
      inherited UBAnadir: TUniToolButton
        ExplicitLeft = 48
        ExplicitTop = -4
        ExplicitWidth = 154
      end
      inherited UBModificar: TUniToolButton
        Left = 154
        ExplicitLeft = 202
        ExplicitTop = -4
        ExplicitWidth = 154
      end
      inherited UBSeleccionar: TUniToolButton
        Left = 308
        ExplicitLeft = 356
        ExplicitTop = -4
        ExplicitWidth = 154
      end
      inherited UBConsultar: TUniToolButton
        Left = 462
        ExplicitLeft = 462
        ExplicitWidth = 154
      end
      inherited UBEliminar: TUniToolButton
        Left = 495
        ExplicitLeft = 664
        ExplicitTop = -4
        ExplicitWidth = 154
      end
      inherited UBPrimero: TUniToolButton [5]
        Left = 649
        ExplicitLeft = 848
        ExplicitTop = -4
        ExplicitWidth = 154
      end
      inherited UniToolButton4: TUniToolButton [6]
        Left = 803
        ExplicitLeft = 818
        ExplicitTop = -4
      end
      inherited UBAnterior: TUniToolButton
        Left = 833
        ExplicitLeft = 1002
        ExplicitTop = -4
        ExplicitWidth = 154
      end
      inherited UBSiguiente: TUniToolButton
        Left = 987
        ExplicitLeft = 1156
        ExplicitTop = -4
        ExplicitWidth = 154
      end
      inherited UBUltimo: TUniToolButton
        Left = 1141
        ExplicitLeft = 1310
        ExplicitTop = -4
        ExplicitWidth = 154
      end
      inherited UBImprimir: TUniToolButton [10]
        Left = 1295
        ExplicitLeft = 1494
        ExplicitTop = -4
        ExplicitWidth = 154
      end
      inherited UniToolButton11: TUniToolButton [11]
        Left = 1449
        ExplicitLeft = 1464
        ExplicitTop = -4
      end
      inherited UBExportarExcel: TUniToolButton
        Left = 1479
        ExplicitLeft = 1648
        ExplicitTop = -4
        ExplicitWidth = 154
      end
      inherited UBSalir: TUniToolButton [13]
        Left = 1633
        ExplicitLeft = 1832
        ExplicitTop = -4
        ExplicitWidth = 154
      end
      inherited UniToolButton9: TUniToolButton [14]
        Left = 1787
        ExplicitLeft = 1802
        ExplicitTop = -4
      end
    end
    inherited UniDBGrid1: TUniDBGrid
      Top = 105
      Width = 1092
      Height = 353
      Columns = <
        item
          FieldName = 'APELLIDO_PROFESOR'
          Title.Caption = 'Apellido'
          Width = 184
        end
        item
          FieldName = 'NOMBRE_PROFESOR'
          Title.Caption = 'Nombre'
          Width = 124
        end>
    end
    inherited UniPanel1: TUniPanel
      Top = 458
      Width = 1092
      ExplicitTop = 458
      ExplicitWidth = 731
      inherited UniPanel2: TUniPanel
        Left = 748
        ExplicitLeft = 387
      end
    end
  end
  inherited UniPanelPaginas: TUniPanel
    Left = 823
    Top = 462
    ExplicitLeft = 462
    ExplicitTop = 462
  end
  inherited DSVista: TDataSource
    Top = 232
  end
  inherited ADVista: TFDQuery
    Connection = UniMainModule.FDConnection1
    MacroData = <
      item
        Value = '*'
        Name = 'CAMPOS'
      end
      item
        Value = 'profesores'
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
    object ADVistaID_PROFESOR: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'ID_PROFESOR'
      Origin = 'ID_PROFESOR'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object ADVistaNOMBRE_PROFESOR: TStringField
      DisplayLabel = 'Nombre'
      FieldName = 'NOMBRE_PROFESOR'
      Origin = 'NOMBRE_PROFESOR'
    end
    object ADVistaAPELLIDO_PROFESOR: TStringField
      DisplayLabel = 'Apellido'
      FieldName = 'APELLIDO_PROFESOR'
      Origin = 'APELLIDO_PROFESOR'
      Size = 30
    end
  end
  inherited ADCamposFiltro: TFDMemTable
    Active = True
    Left = 432
    Top = 176
    object ADCamposFiltroNOMBRE_PROFESOR: TStringField
      DisplayLabel = 'Nombre'
      FieldName = 'NOMBRE_PROFESOR'
      Origin = 'NOMBRE_PROFESOR'
    end
    object ADCamposFiltroAPELLIDO_PROFESOR: TStringField
      DisplayLabel = 'Apellido'
      FieldName = 'APELLIDO_PROFESOR'
      Origin = 'APELLIDO_PROFESOR'
      Size = 30
    end
  end
  inherited DSCamposFiltro: TDataSource
    Left = 440
  end
  inherited ADTransaction1: TFDTransaction
    Connection = UniMainModule.FDConnection1
    Left = 376
    Top = 120
  end
end
