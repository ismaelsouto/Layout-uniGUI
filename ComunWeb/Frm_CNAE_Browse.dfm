inherited FrmCNAEBrowse: TFrmCNAEBrowse
  ClientHeight = 464
  ClientWidth = 714
  Caption = 'CNAE'
  ExplicitWidth = 730
  ExplicitHeight = 503
  PixelsPerInch = 96
  TextHeight = 13
  inherited Contenedor: TUniPanel
    Width = 714
    Height = 464
    ExplicitWidth = 714
    ExplicitHeight = 464
    inherited PanelFiltro: TUniPanel
      Width = 712
      Height = 52
      ExplicitWidth = 712
      ExplicitHeight = 52
      inherited UBBRestauraFiltro: TUniBitBtn
        Left = 442
        Top = 20
        ExplicitLeft = 442
        ExplicitTop = 20
      end
      inherited UBBFiltrar: TUniBitBtn
        Left = 418
        Top = 20
        ExplicitLeft = 418
        ExplicitTop = 20
      end
      object UniLabel1: TUniLabel
        Left = 16
        Top = 6
        Width = 27
        Height = 13
        Hint = ''
        Caption = 'CNAE'
        TabOrder = 3
      end
      object CNAE: TUniEdit
        Left = 16
        Top = 20
        Width = 49
        Hint = ''
        Text = ''
        TabOrder = 4
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
        TabOrder = 6
      end
    end
    inherited UniToolBar1: TUniToolBar
      Width = 712
      ExplicitWidth = 712
    end
    inherited UniDBGrid1: TUniDBGrid
      Top = 87
      Width = 712
      Height = 342
      OnTitleClick = nil
      Columns = <
        item
          FieldName = 'NOMBRE'
          Title.Caption = 'CNAE'
          Width = 1252
          ReadOnly = True
        end>
    end
    inherited UniPanel1: TUniPanel
      Top = 429
      Width = 712
      ExplicitTop = 429
      ExplicitWidth = 712
      inherited UniPanel2: TUniPanel
        Left = 368
        ExplicitLeft = 368
      end
    end
  end
  inherited UniPanelPaginas: TUniPanel
    Left = 443
    Top = 432
    ExplicitLeft = 443
    ExplicitTop = 432
  end
  inherited ADVista: TFDQuery
    MacroData = <
      item
        Value = '*'
        Name = 'CAMPOS'
      end
      item
        Value = 
          '(SELECT 1 NIVEL,CNAE_NIVEL_1.CNAE CNAE,CNAE_NIVEL_1.CNAE ORDEN,C' +
          'NAE_NIVEL_1.CNAE||'#39' - '#39'||CNAE_NIVEL_1.NOMBRE NOMBRE FROM CNAE_NI' +
          'VEL_1 UNION SELECT 2,CNAE_NIVEL_2.CNAE,CNAE_NIVEL_1.CNAE||CNAE_N' +
          'IVEL_2.CNAE,CNAE_NIVEL_2.CNAE||'#39' - '#39'||CNAE_NIVEL_2.NOMBRE FROM C' +
          'NAE_NIVEL_2 INNER JOIN CNAE_NIVEL_1 ON (CNAE_NIVEL_1.CNAE=CNAE_N' +
          'IVEL_2.NIVEL_1) UNION SELECT 3,CNAE_NIVEL_3.CNAE,CNAE_NIVEL_1.CN' +
          'AE||CNAE_NIVEL_2.CNAE||CNAE_NIVEL_3.CNAE,CNAE_NIVEL_3.CNAE||'#39' - ' +
          #39'||CNAE_NIVEL_3.NOMBRE FROM CNAE_NIVEL_3 INNER JOIN CNAE_NIVEL_2' +
          ' ON (CNAE_NIVEL_2.CNAE=CNAE_NIVEL_3.NIVEL_2) INNER JOIN CNAE_NIV' +
          'EL_1 ON (CNAE_NIVEL_1.CNAE=CNAE_NIVEL_2.NIVEL_1) UNION SELECT 5,' +
          'CNAE_NIVEL_5.CNAE,CNAE_NIVEL_1.CNAE||CNAE_NIVEL_2.CNAE||CNAE_NIV' +
          'EL_3.CNAE||CNAE_NIVEL_5.CNAE,CNAE_NIVEL_5.CNAE||'#39' - '#39'||CNAE_NIVE' +
          'L_5.NOMBRE FROM CNAE_NIVEL_5 INNER JOIN CNAE_NIVEL_3 ON (CNAE_NI' +
          'VEL_3.CNAE=CNAE_NIVEL_5.NIVEL_3) INNER JOIN CNAE_NIVEL_2 ON (CNA' +
          'E_NIVEL_2.CNAE=CNAE_NIVEL_3.NIVEL_2) INNER JOIN CNAE_NIVEL_1 ON ' +
          '(CNAE_NIVEL_1.CNAE=CNAE_NIVEL_2.NIVEL_1) ORDER BY 3) T'
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
    object ADVistaNIVEL: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'NIVEL'
      Origin = 'NIVEL'
      ProviderFlags = []
      ReadOnly = True
    end
    object ADVistaCNAE: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'CNAE'
      Origin = 'CNAE'
      ProviderFlags = [pfInKey]
      ReadOnly = True
      Size = 5
    end
    object ADVistaORDEN: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'ORDEN'
      Origin = 'ORDEN'
      ProviderFlags = []
      ReadOnly = True
      Size = 12
    end
    object ADVistaNOMBRE: TStringField
      AutoGenerateValue = arDefault
      DisplayLabel = 'CNAE'
      FieldName = 'NOMBRE'
      Origin = 'NOMBRE'
      ProviderFlags = []
      ReadOnly = True
      OnGetText = ADVistaNOMBREGetText
      Size = 208
    end
  end
end
