object FrmPedirDatos: TFrmPedirDatos
  Left = 0
  Top = 0
  ClientHeight = 192
  ClientWidth = 510
  Caption = 'Confirme los datos del representante antes de continuar'
  BorderStyle = bsSingle
  OldCreateOrder = False
  OnKeyDown = UniFormKeyDown
  BorderIcons = [biSystemMenu]
  KeyPreview = True
  MonitoredKeys.Keys = <>
  ActiveControl = Nombre
  OnCreate = UniFormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object UTBBotonera: TUniToolBar
    Left = 0
    Top = 0
    Width = 510
    Height = 35
    Hint = ''
    ButtonHeight = 33
    ButtonWidth = 34
    ShowCaptions = True
    TabOrder = 0
    ParentColor = False
    Color = clBtnFace
    ParentFont = False
    Font.Color = 14062137
    Font.Height = -24
    Font.Name = 'CAI'
    object UBAceptar: TUniToolButton
      Left = 0
      Top = 0
      Hint = 'Aceptar'
      ShowHint = True
      ParentShowHint = False
      ImageIndex = 0
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
      ImageIndex = 1
      Caption = 'X'
      TabOrder = 2
      OnClick = UBCancelarClick
    end
  end
  object UniLabel1: TUniLabel
    Left = 16
    Top = 64
    Width = 105
    Height = 33
    Hint = ''
    AutoSize = False
    Caption = 'Nombre y apellidos del representante'
    TabOrder = 4
  end
  object UniLabel2: TUniLabel
    Left = 474
    Top = 64
    Width = 8
    Height = 16
    Hint = ''
    Caption = '*'
    ParentFont = False
    Font.Color = 14062137
    Font.Height = -13
    Font.Style = [fsBold]
    TabOrder = 5
  end
  object UniLabel3: TUniLabel
    Left = 16
    Top = 104
    Width = 89
    Height = 13
    Hint = ''
    Caption = 'NIF representante'
    TabOrder = 6
  end
  object UniLabel4: TUniLabel
    Left = 16
    Top = 144
    Width = 101
    Height = 13
    Hint = ''
    Caption = 'Cargo representante'
    TabOrder = 7
  end
  object UniLabel5: TUniLabel
    Left = 320
    Top = 104
    Width = 8
    Height = 16
    Hint = ''
    Caption = '*'
    ParentFont = False
    Font.Color = 14062137
    Font.Height = -13
    Font.Style = [fsBold]
    TabOrder = 8
  end
  object UniLabel6: TUniLabel
    Left = 474
    Top = 144
    Width = 8
    Height = 16
    Hint = ''
    Caption = '*'
    ParentFont = False
    Font.Color = 14062137
    Font.Height = -13
    Font.Style = [fsBold]
    TabOrder = 9
  end
  object Nombre: TUniDBEdit
    Left = 136
    Top = 62
    Width = 329
    Height = 22
    Hint = ''
    DataField = 'NOMBRE'
    DataSource = DataSource1
    CharCase = ecUpperCase
    TabOrder = 1
  end
  object NIF: TUniDBEdit
    Left = 136
    Top = 102
    Width = 169
    Height = 22
    Hint = ''
    DataField = 'NIF'
    DataSource = DataSource1
    CharCase = ecUpperCase
    TabOrder = 2
  end
  object Cargo: TUniDBEdit
    Left = 136
    Top = 142
    Width = 329
    Height = 22
    Hint = ''
    DataField = 'CARGO'
    DataSource = DataSource1
    CharCase = ecUpperCase
    TabOrder = 3
  end
  object DataSource1: TDataSource
    DataSet = FrmFirmaContratos.ADMemTableRepresentante
    Left = 248
    Top = 96
  end
end
