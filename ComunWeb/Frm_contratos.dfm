object FrmContratos: TFrmContratos
  Left = 0
  Top = 0
  ClientHeight = 454
  ClientWidth = 1025
  Caption = 'Documentos con CAI Sistemas'
  OldCreateOrder = False
  MonitoredKeys.Keys = <>
  PixelsPerInch = 96
  TextHeight = 13
  object UniToolBar1: TUniToolBar
    Left = 0
    Top = 0
    Width = 1025
    Height = 35
    Hint = ''
    ShowHint = True
    ParentShowHint = False
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
    ExplicitWidth = 961
  end
  object DBGrid1: TUniDBGrid
    Left = 0
    Top = 35
    Width = 1025
    Height = 419
    Cursor = crHandPoint
    Hint = ''
    DataSource = DataSource1
    WebOptions.Paged = False
    LoadMask.Message = 'Loading data...'
    Align = alClient
    TabOrder = 1
    ParentColor = False
    Color = clWindow
    OnCellClick = DBGrid1CellClick
    OnAfterLoad = DBGrid1AfterLoad
    Columns = <
      item
        FieldName = 'DOCUMENTO'
        Title.Caption = 'Documento '
        Width = 508
      end
      item
        FieldName = 'HASHSHA256'
        Title.Caption = 'Huella digital'
        Width = 340
      end
      item
        FieldName = 'consultar'
        Title.Caption = 'consultar'
        Width = 101
        Font.Color = clGreen
        Font.Name = 'cai !IMPORTANT'
        Alignment = taCenter
      end>
  end
  object DataSource1: TDataSource
    DataSet = ADMemTable1
    Left = 416
    Top = 96
  end
  object ADMemTable1: TFDMemTable
    FieldDefs = <>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    StoreDefs = True
    Left = 344
    Top = 88
    object ADMemTable1DOCUMENTO: TStringField
      FieldName = 'DOCUMENTO'
      Size = 100
    end
    object ADMemTable1INTERNO: TIntegerField
      FieldName = 'INTERNO'
    end
    object ADMemTable1HASHSHA256: TStringField
      FieldName = 'HASHSHA256'
      Size = 100
    end
    object ADMemTable1consultar: TStringField
      FieldName = 'consultar'
      Size = 1
    end
  end
  object Conexion: TFDConnection
    Params.Strings = (
      'DriverID=FB'
      'Database=www.caisistemas.es/3050:c:\cai\factura.gdb'
      'Password=masterkey'
      'User_Name=SYSDBA'
      'OSAuthent=No')
    Connected = True
    Left = 224
    Top = 272
  end
  object ADQuery1: TFDQuery
    Connection = Conexion
    SQL.Strings = (
      '')
    Left = 288
    Top = 280
  end
end
