object FrmFirmaContratos: TFrmFirmaContratos
  Left = 0
  Top = 0
  ClientHeight = 587
  ClientWidth = 1154
  Caption = 'Documentos pendientes de aceptar'
  OldCreateOrder = False
  OnClose = UniFormClose
  MonitoredKeys.Keys = <>
  OnReady = UniFormReady
  OnAjaxEvent = UniFormAjaxEvent
  PixelsPerInch = 96
  TextHeight = 13
  object UniPanel2: TUniPanel
    Left = 0
    Top = 0
    Width = 1154
    Height = 99
    Hint = ''
    Align = alTop
    ParentFont = False
    Font.Color = clWindow
    TabOrder = 0
    BorderStyle = ubsNone
    Caption = ''
    object UniLabel1: TUniLabel
      Left = 4
      Top = 43
      Width = 1154
      Height = 33
      Hint = ''
      Alignment = taCenter
      AutoSize = False
      Caption = 'DOCUMENTOS PENDIENTES DE ACEPTAR'
      Align = alCustom
      Anchors = [akLeft, akTop, akRight]
      ParentFont = False
      Font.Color = 14062137
      Font.Height = -19
      Font.Style = [fsBold]
      ParentColor = False
      Color = clBtnFace
      TabOrder = 1
    end
    object UniImage1: TUniImage
      Left = 161
      Top = 3
      Width = 190
      Height = 89
      Hint = ''
      AutoSize = True
      Stretch = True
      Url = 'https://www.caisistemas.es/firma_contratos/logo-caisistemas.png'
    end
  end
  object UniPanel1: TUniPanel
    Left = 0
    Top = 99
    Width = 161
    Height = 446
    Hint = ''
    Align = alLeft
    TabOrder = 1
    BorderStyle = ubsNone
    Caption = ''
  end
  object UniPanel3: TUniPanel
    Left = 1008
    Top = 99
    Width = 146
    Height = 446
    Hint = ''
    Align = alRight
    TabOrder = 2
    BorderStyle = ubsNone
    Caption = ''
  end
  object UniPanel4: TUniPanel
    Left = 0
    Top = 545
    Width = 1154
    Height = 42
    Hint = ''
    Align = alBottom
    ParentFont = False
    Font.Color = clWindow
    TabOrder = 3
    BorderStyle = ubsNone
    Caption = ''
  end
  object UniDBGrid1: TUniDBGrid
    Left = 161
    Top = 99
    Width = 847
    Height = 446
    Hint = ''
    ParentShowHint = False
    TitleFont.Height = -13
    DataSource = DataSource1
    Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgConfirmDelete, dgAutoRefreshRow]
    ReadOnly = True
    WebOptions.Paged = False
    LoadMask.Message = 'Loading data...'
    RowHeight = 24
    ForceFit = True
    Align = alClient
    Font.Height = -13
    ParentFont = False
    TabOrder = 4
    OnCellClick = UniDBGrid1CellClick
    OnDrawColumnCell = UniDBGrid1DrawColumnCell
    OnAfterLoad = UniDBGrid1AfterLoad
    Columns = <
      item
        FieldName = 'DOCUMENTO'
        Title.Caption = 'Documento'
        Title.Font.Height = -13
        Width = 389
        Font.Height = -13
      end
      item
        FieldName = 'HASHSHA256'
        Title.Caption = 'Huella'
        Title.Font.Height = -13
        Width = 232
      end
      item
        FieldName = 'FIRMADO'
        Title.Caption = 'Aceptado'
        Title.Font.Height = -13
        Width = 69
        Font.Height = -24
        Font.Name = 'Iconos !IMPORTANT'
        Alignment = taCenter
      end
      item
        FieldName = 'RUTA'
        Title.Caption = 'Leer / Aceptar'
        Title.Font.Height = -13
        Width = 116
        Font.Color = 14062137
        Font.Height = -24
        Font.Name = 'cai !IMPORTANT'
        Alignment = taCenter
        Hint = 'Pulse para leer y firmar el documento'
      end>
  end
  object DataSource1: TDataSource
    DataSet = ADMemTable1
    Left = 544
    Top = 144
  end
  object mensaje: TIdMessage
    AttachmentEncoding = 'UUE'
    BccList = <>
    CCList = <>
    Encoding = meDefault
    FromList = <
      item
      end>
    Recipients = <>
    ReplyTo = <>
    ConvertPreamble = True
    Left = 432
    Top = 224
  end
  object ADMemTable1: TFDMemTable
    Active = True
    FieldDefs = <
      item
        Name = 'DOCUMENTO'
        DataType = ftString
        Size = 200
      end
      item
        Name = 'FIRMADO'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'RUTA'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'CONTRATO'
        DataType = ftBlob
      end
      item
        Name = 'INTERNO'
        DataType = ftInteger
      end
      item
        Name = 'HASHSHA256'
        DataType = ftString
        Size = 256
      end
      item
        Name = 'EMPRESA'
        DataType = ftInteger
      end
      item
        Name = 'TIPO_FIRMA'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'FECHA_TOPE'
        DataType = ftDate
      end>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    StoreDefs = True
    Left = 560
    Top = 328
    object ADMemTable1DOCUMENTO: TStringField
      DisplayWidth = 61
      FieldName = 'DOCUMENTO'
      Size = 200
    end
    object ADMemTable1FIRMADO: TStringField
      DisplayWidth = 119
      FieldName = 'FIRMADO'
      Size = 1
    end
    object ADMemTable1RUTA: TStringField
      FieldName = 'RUTA'
    end
    object ADMemTable1CONTRATO: TBlobField
      FieldName = 'CONTRATO'
    end
    object ADMemTable1INTERNO: TIntegerField
      FieldName = 'INTERNO'
    end
    object ADMemTable1HASHSHA256: TStringField
      FieldName = 'HASHSHA256'
      Size = 256
    end
    object ADMemTable1EMPRESA: TIntegerField
      FieldName = 'EMPRESA'
    end
    object ADMemTable1TIPO_FIRMA: TStringField
      FieldName = 'TIPO_FIRMA'
    end
    object ADMemTable1FECHA_TOPE: TDateField
      FieldName = 'FECHA_TOPE'
    end
  end
  object UniScreenMaskBorrar: TUniScreenMask
    Enabled = True
    DisplayMessage = 'Borrando carpeta ...'
    Left = 160
    Top = 184
  end
  object ADMemTableRepresentante: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    Left = 656
    Top = 320
    object ADMemTableRepresentanteNOMBRE: TStringField
      FieldName = 'NOMBRE'
      Size = 100
    end
    object ADMemTableRepresentanteNIF: TStringField
      FieldName = 'NIF'
      OnChange = ADMemTableRepresentanteNIFChange
    end
    object ADMemTableRepresentanteCARGO: TStringField
      FieldName = 'CARGO'
      Size = 100
    end
  end
  object ADQuery1: TFDQuery
    Connection = Conexion
    SQL.Strings = (
      'select !campos'
      'from !tabla'
      '{if !filtro} where !filtro {fi}'
      '{if !order} order by !order {fi}')
    Left = 288
    Top = 280
    MacroData = <
      item
        Value = '*'
        Name = 'CAMPOS'
      end
      item
        Value = 'DATOS_EMPRESA'
        Name = 'TABLA'
      end
      item
        Value = Null
        Name = 'FILTRO'
      end
      item
        Value = Null
        Name = 'ORDER'
      end>
  end
  object ADQueryBlob: TFDQuery
    Connection = Conexion
    Left = 208
    Top = 344
  end
  object Conexion: TFDConnection
    Params.Strings = (
      'DriverID=FB'
      'Database=www.caisistemas.es/3050:c:\cai\factura.gdb'
      'Password=masterkey'
      'User_Name=SYSDBA'
      'OSAuthent=No')
    Left = 224
    Top = 272
  end
end
