inherited FrmEpigrafesBrowse: TFrmEpigrafesBrowse
  ClientHeight = 447
  ClientWidth = 601
  Caption = 'Ep'#237'grafes'
  ExplicitWidth = 617
  ExplicitHeight = 486
  DesignSize = (
    601
    447)
  PixelsPerInch = 96
  TextHeight = 13
  inherited Contenedor: TUniPanel
    Width = 601
    Height = 447
    ExplicitWidth = 601
    ExplicitHeight = 447
    inherited PanelFiltro: TUniPanel
      Width = 599
      Height = 52
      ExplicitWidth = 599
      ExplicitHeight = 52
      inherited UBBRestauraFiltro: TUniBitBtn
        Left = 528
        Top = 20
        TabOrder = 4
        ExplicitLeft = 528
        ExplicitTop = 20
      end
      inherited UBBFiltrar: TUniBitBtn
        Left = 504
        Top = 20
        TabOrder = 5
        ExplicitLeft = 504
        ExplicitTop = 20
      end
      object UniLabel1: TUniLabel
        Left = 154
        Top = 6
        Width = 40
        Height = 13
        Hint = ''
        Caption = 'Ep'#237'grafe'
        TabOrder = 6
      end
      object EPIGRAFE: TUniEdit
        Left = 154
        Top = 20
        Width = 49
        Hint = ''
        Text = ''
        TabOrder = 1
      end
      object UniLabel2: TUniLabel
        Left = 209
        Top = 6
        Width = 37
        Height = 13
        Hint = ''
        Caption = 'Nombre'
        TabOrder = 7
      end
      object NOMBRE: TUniEdit
        Left = 209
        Top = 20
        Width = 295
        Hint = ''
        Text = ''
        TabOrder = 2
      end
      object UniLabel3: TUniLabel
        Left = 10
        Top = 6
        Width = 20
        Height = 13
        Hint = ''
        Caption = 'Tipo'
        TabOrder = 8
      end
      object TIPO: TUniComboBox
        Left = 10
        Top = 20
        Width = 139
        Hint = ''
        Style = csDropDownList
        Text = 'Todos'
        Items.Strings = (
          'Todos'
          'Sin Ep'#237'grafe'
          'Batea'
          'Empresarial'
          'Profesional'
          'Art'#237'stica')
        ItemIndex = 0
        TabOrder = 0
        IconItems = <>
        OnChange = TIPOChange
      end
    end
    inherited UniToolBar1: TUniToolBar
      Width = 599
      ExplicitWidth = 599
    end
    inherited UniDBGrid1: TUniDBGrid
      Top = 88
      Width = 599
      Height = 323
      Columns = <
        item
          FieldName = 'TIPO'
          Title.Caption = 'Tipo'
          Width = 123
        end
        item
          FieldName = 'EPIGRAFE'
          Title.Caption = 'Ep'#237'grafe'
          Width = 79
        end
        item
          FieldName = 'NOMBRE'
          Title.Caption = 'Nombre'
          Width = 400
        end>
    end
    inherited UniPanel1: TUniPanel
      Top = 411
      Width = 599
      ExplicitTop = 412
      ExplicitWidth = 599
      inherited UniPanel2: TUniPanel
        Left = 255
        ExplicitLeft = 255
      end
    end
  end
  inherited UniPanelPaginas: TUniPanel
    Left = 330
    Top = 415
    ExplicitLeft = 330
    ExplicitTop = 415
  end
  inherited ADVista: TFDQuery
    MacroData = <
      item
        Value = 'TIPO,EPIGRAFE,NOMBRE'
        Name = 'CAMPOS'
      end
      item
        Value = 'EPIGRAFES'
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
    object ADVistaTIPO: TStringField
      DisplayLabel = 'Tipo'
      FieldName = 'TIPO'
      Origin = 'TIPO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      OnGetText = ADVistaTIPOGetText
      Size = 1
    end
    object ADVistaEPIGRAFE: TStringField
      DisplayLabel = 'Ep'#237'grafe'
      FieldName = 'EPIGRAFE'
      Origin = 'EPIGRAFE'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Size = 5
    end
    object ADVistaNOMBRE: TStringField
      DisplayLabel = 'Nombre'
      FieldName = 'NOMBRE'
      Origin = 'NOMBRE'
      Size = 200
    end
  end
end
