object FrmUsuariosImportar: TFrmUsuariosImportar
  Left = 0
  Top = 0
  ClientHeight = 422
  ClientWidth = 450
  Caption = 'Importar usuarios'
  BorderStyle = bsDialog
  OldCreateOrder = False
  OnClose = UniFormClose
  BorderIcons = [biSystemMenu]
  MonitoredKeys.Keys = <>
  ActiveControl = UniDBGrid1
  OnCreate = UniFormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object UniToolBar1: TUniToolBar
    Left = 0
    Top = 0
    Width = 450
    Height = 35
    ButtonHeight = 33
    ButtonWidth = 34
    ShowCaptions = True
    TabOrder = 0
    ParentColor = False
    Color = clBtnFace
    ParentFont = False
    Font.Color = 14062137
    Font.Height = -24
    Font.Name = 'cai'
    ExplicitWidth = 440
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
  object UniDBGrid1: TUniDBGrid
    Left = 0
    Top = 35
    Width = 450
    Height = 387
    DataSource = DSUsuarios
    WebOptions.Paged = False
    WebOptions.FetchAll = True
    LoadMask.Message = 'Loading data...'
    Align = alClient
    TabOrder = 1
    Columns = <
      item
        FieldName = 'USUARIO'
        Title.Caption = 'Usuario'
        Width = 359
        Color = 15204351
        ReadOnly = True
      end
      item
        FieldName = 'IMPORTAR'
        Title.Caption = ' '
        Width = 40
        CheckBoxField.AutoPost = True
      end>
  end
  object UniBitBtn1: TUniBitBtn
    Left = 399
    Top = 0
    Width = 34
    Height = 33
    Hint = 'Ninguno'
    Caption = 'N'
    ParentFont = False
    Font.Height = -24
    Font.Name = 'Cai'
    TabOrder = 2
    OnClick = UniBitBtn1Click
  end
  object UBBTodas: TUniBitBtn
    Left = 365
    Top = 0
    Width = 34
    Height = 33
    Hint = 'Todos'
    Caption = 'T'
    ParentFont = False
    Font.Height = -24
    Font.Name = 'Cai'
    TabOrder = 3
    OnClick = UBBTodasClick
  end
  object ADUsuarios: TFDMemTable
    Active = True
    FieldDefs = <
      item
        Name = 'IDUSUARIOS'
        DataType = ftInteger
      end
      item
        Name = 'USUARIO'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'CONTRASENA'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'IMPORTAR'
        DataType = ftBoolean
      end>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    StoreDefs = True
    Left = 208
    Top = 168
    object ADUsuariosIDUSUARIOS: TIntegerField
      FieldName = 'IDUSUARIOS'
    end
    object ADUsuariosUSUARIO: TStringField
      DisplayLabel = 'Usuario'
      DisplayWidth = 62
      FieldName = 'USUARIO'
    end
    object ADUsuariosCONTRASENA: TStringField
      FieldName = 'CONTRASENA'
    end
    object ADUsuariosIMPORTAR: TBooleanField
      DisplayLabel = ' '
      DisplayWidth = 6
      FieldName = 'IMPORTAR'
    end
  end
  object DSUsuarios: TDataSource
    DataSet = ADUsuarios
    Left = 208
    Top = 184
  end
end
