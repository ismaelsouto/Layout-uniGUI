object FrmEditorReglasNegocio: TFrmEditorReglasNegocio
  Left = 0
  Top = 0
  ClientHeight = 508
  ClientWidth = 803
  Caption = 'FrmEditorReglasNegocio'
  WindowState = wsMaximized
  OldCreateOrder = False
  OnClose = UniFormClose
  OnKeyDown = UniFormKeyDown
  KeyPreview = True
  MonitoredKeys.Keys = <>
  ActiveControl = UniDBGrid1
  OnCreate = UniFormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object UniDBGrid1: TUniDBGrid
    Left = 0
    Top = 102
    Width = 803
    Height = 158
    Hint = ''
    DataSource = DSReglasNegocio
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgRowSelect, dgConfirmDelete]
    WebOptions.Paged = False
    WebOptions.FetchAll = True
    LoadMask.Message = 'Loading data...'
    Align = alTop
    TabOrder = 0
    Columns = <
      item
        FieldName = 'CAMPOS'
        Title.Caption = 'Campos resultado'
        Width = 100
      end
      item
        FieldName = 'CALCULO_S'
        Title.Caption = 'C'#225'lculo'
        Width = 663
      end>
  end
  object CODIGO_FUENTE: TUniSyntaxEdit
    Left = 0
    Top = 330
    Width = 803
    Height = 178
    Hint = ''
    Font.Height = -13
    Font.Name = 'Courier New'
    Align = alClient
  end
  object UniToolBar1: TUniToolBar
    Left = 0
    Top = 0
    Width = 803
    Height = 35
    Hint = ''
    ButtonHeight = 33
    ButtonWidth = 34
    ShowCaptions = True
    TabOrder = 2
    ParentColor = False
    Color = clBtnFace
    ParentFont = False
    Font.Color = 14062137
    Font.Height = -24
    Font.Name = 'cai'
    object UBAnadir: TUniToolButton
      Left = 0
      Top = 0
      Hint = 'A'#241'adir un registro'
      ShowHint = True
      ParentShowHint = False
      Caption = '+'
      TabOrder = 1
      OnClick = UBAnadirClick
    end
    object UBEliminar: TUniToolButton
      Left = 34
      Top = 0
      Hint = 'Eliminar el registro actual'
      ShowHint = True
      ParentShowHint = False
      Caption = '-'
      TabOrder = 2
      OnClick = UBEliminarClick
    end
    object UniToolButton1: TUniToolButton
      Left = 68
      Top = 0
      Width = 30
      Hint = ''
      Style = tbsSeparator
      Caption = 'UniToolButton1'
      TabOrder = 3
    end
    object UBPrimero: TUniToolButton
      Left = 98
      Top = 0
      Hint = 'Primer registro'
      ShowHint = True
      ParentShowHint = False
      Caption = '5'
      TabOrder = 4
      OnClick = UBPrimeroClick
    end
    object UBAnterior: TUniToolButton
      Left = 132
      Top = 0
      Hint = 'Anterior registro'
      ShowHint = True
      ParentShowHint = False
      Caption = '6'
      TabOrder = 5
      OnClick = UBAnteriorClick
    end
    object UBSiguiente: TUniToolButton
      Left = 166
      Top = 0
      Hint = 'Siguiente registro'
      ShowHint = True
      ParentShowHint = False
      Caption = '7'
      TabOrder = 6
      OnClick = UBSiguienteClick
    end
    object UBUltimo: TUniToolButton
      Left = 200
      Top = 0
      Hint = #218'ltimo registro'
      ShowHint = True
      ParentShowHint = False
      Caption = '8'
      TabOrder = 7
      OnClick = UBUltimoClick
    end
    object UniToolButton2: TUniToolButton
      Left = 234
      Top = 0
      Width = 30
      Hint = ''
      Style = tbsSeparator
      Caption = 'UniToolButton2'
      TabOrder = 8
    end
    object UBSalir: TUniToolButton
      Left = 264
      Top = 0
      Hint = 'Salir de este mantenimiento'
      ShowHint = True
      ParentShowHint = False
      Caption = 's'
      TabOrder = 9
      OnClick = UBSalirClick
    end
  end
  object PanelFiltro: TUniPanel
    Left = 0
    Top = 35
    Width = 803
    Height = 67
    Hint = ''
    Align = alTop
    TabOrder = 3
    BorderStyle = ubsNone
    Caption = ''
    ExplicitWidth = 727
    object UniLabel1: TUniLabel
      Left = 14
      Top = 12
      Width = 63
      Height = 13
      Hint = ''
      Caption = 'Campos dato'
      TabOrder = 1
    end
    object UniLabel2: TUniLabel
      Left = 340
      Top = 12
      Width = 86
      Height = 13
      Hint = ''
      Caption = 'Campos resultado'
      TabOrder = 3
    end
    object CAMPOS_DATO: TUniDBLookupComboBox
      Left = 14
      Top = 28
      Width = 313
      Hint = ''
      ListField = 'CAMPO'
      ListSource = DSCampos
      KeyField = 'CAMPO'
      ListFieldIndex = 0
      TabOrder = 2
      Color = clWindow
      OnSelect = FIltrar
    end
    object CAMPOS_RESULTADO: TUniDBLookupComboBox
      Left = 340
      Top = 28
      Width = 313
      Hint = ''
      ListField = 'CAMPO'
      ListSource = DSCampos
      KeyField = 'CAMPO'
      ListFieldIndex = 0
      TabOrder = 4
      Color = clWindow
      OnSelect = FIltrar
    end
  end
  object UniPanel1: TUniPanel
    Left = 0
    Top = 260
    Width = 803
    Height = 70
    Hint = ''
    Align = alTop
    TabOrder = 4
    BorderStyle = ubsNone
    Caption = ''
    DesignSize = (
      803
      70)
    object UniToolBar2: TUniToolBar
      Left = 0
      Top = 0
      Width = 803
      Height = 35
      Hint = ''
      ButtonHeight = 33
      ButtonWidth = 34
      ShowCaptions = True
      TabOrder = 1
      ParentColor = False
      Color = clBtnFace
      ParentFont = False
      Font.Color = 14062137
      Font.Height = -24
      Font.Name = 'cai'
      object UBAceptar: TUniToolButton
        Left = 0
        Top = 0
        Hint = 'Aceptar'
        ShowHint = True
        ParentShowHint = False
        Caption = 'V'
        TabOrder = 1
        OnClick = UBAceptarClick
      end
      object UBCancelar: TUniToolButton
        Left = 34
        Top = 0
        Hint = 'Cancelar'
        ShowHint = True
        ParentShowHint = False
        Caption = 'X'
        TabOrder = 2
        OnClick = UBCancelarClick
      end
    end
    object UniLabel3: TUniLabel
      Left = 34
      Top = 43
      Width = 86
      Height = 13
      Hint = ''
      Caption = 'Campos resultado'
      TabOrder = 2
    end
    object UniDBEdit1: TUniDBEdit
      Left = 132
      Top = 39
      Width = 653
      Height = 22
      Hint = ''
      DataField = 'CAMPOS'
      DataSource = DSReglasNegocio
      Anchors = [akLeft, akTop, akRight]
      ParentFont = False
      Font.Name = 'CAMPOS'
      TabOrder = 3
    end
  end
  object ADReglasNegocio: TFDMemTable
    Active = True
    AfterPost = ADReglasNegocioAfterPost
    AfterDelete = ADReglasNegocioAfterDelete
    OnCalcFields = ADReglasNegocioCalcFields
    OnNewRecord = ADReglasNegocioNewRecord
    Filtered = True
    FieldDefs = <
      item
        Name = 'CALCULO'
        DataType = ftMemo
      end
      item
        Name = 'CAMPOS'
        DataType = ftString
        Size = 200
      end>
    IndexDefs = <>
    IndexFieldNames = 'CAMPOS'
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    StoreDefs = True
    Left = 560
    Top = 56
    object ADReglasNegocioCALCULO: TMemoField
      DisplayLabel = 'C'#225'lculo'
      FieldName = 'CALCULO'
      BlobType = ftMemo
    end
    object ADReglasNegocioCAMPOS: TStringField
      DisplayLabel = 'Campos resultado'
      FieldName = 'CAMPOS'
      Size = 200
    end
    object ADReglasNegocioCALCULO_S: TStringField
      DisplayLabel = 'C'#225'lculo'
      FieldKind = fkCalculated
      FieldName = 'CALCULO_S'
      Size = 500
      Calculated = True
    end
  end
  object DSReglasNegocio: TDataSource
    DataSet = ADReglasNegocio
    OnDataChange = DSReglasNegocioDataChange
    Left = 560
    Top = 72
  end
  object ADCampos: TFDMemTable
    Active = True
    IndexFieldNames = 'CAMPO'
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    Left = 656
    Top = 56
    object ADCamposCAMPO: TStringField
      FieldName = 'CAMPO'
      Size = 40
    end
  end
  object DSCampos: TDataSource
    DataSet = ADCampos
    Left = 656
    Top = 72
  end
end
