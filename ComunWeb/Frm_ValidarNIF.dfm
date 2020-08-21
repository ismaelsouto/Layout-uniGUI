object FrmValidarNIF: TFrmValidarNIF
  Left = 0
  Top = 0
  ClientHeight = 447
  ClientWidth = 931
  Caption = 'FrmValidarNIF'
  WindowState = wsMaximized
  OldCreateOrder = False
  MonitoredKeys.Keys = <>
  OnCreate = UniFormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object UniToolBar1: TUniToolBar
    Left = 0
    Top = 0
    Width = 931
    Height = 35
    ButtonHeight = 33
    ButtonWidth = 34
    ShowCaptions = True
    Anchors = [akLeft, akTop, akRight]
    Align = alTop
    TabOrder = 0
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
  object UniDBGrid1: TUniDBGrid
    Left = 0
    Top = 35
    Width = 931
    Height = 412
    DataSource = dsNifs
    WebOptions.Paged = False
    WebOptions.FetchAll = True
    LoadMask.Message = 'Cargando datos...'
    ForceFit = True
    Align = alClient
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 1
    Columns = <
      item
        FieldName = 'NIF'
        Title.Caption = 'NIF perceptor'
        Width = 102
        Color = clInfoBk
        ReadOnly = True
      end
      item
        FieldName = 'NOMBRE_CAI'
        Title.Caption = 'Nombre perceptor'
        Width = 283
        Color = clInfoBk
        ReadOnly = True
      end
      item
        FieldName = 'NOMBRE'
        Title.Caption = 'Nombre propuesto por la AEAT'
        Width = 285
        Color = clInfoBk
        ReadOnly = True
      end
      item
        FieldName = 'APELLIDO1_AEAT'
        Title.Caption = 'Apellido 1'#186
        Width = 191
      end
      item
        FieldName = 'APELLIDO2_AEAT'
        Title.Caption = 'Apellido 2'#186
        Width = 175
      end
      item
        FieldName = 'NOMBRE_AEAT'
        Title.Caption = 'Nombre'
        Width = 213
      end>
  end
  object UniLabel1: TUniLabel
    Left = 89
    Top = 10
    Width = 718
    Height = 13
    Caption = 
      'Las columnas '#39'Apellido 1'#186' - Apellido 2'#186' - Nombre'#39' permiten cambi' +
      'ar esos datos en el perceptor en caso de que el NIF corresponda ' +
      'a una persona f'#237'sica.'
    TabOrder = 2
  end
  object dsNifs: TDataSource
    Left = 320
    Top = 168
  end
end
