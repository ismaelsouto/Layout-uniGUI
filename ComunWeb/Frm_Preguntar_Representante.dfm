object FrmPreguntarRepresentante: TFrmPreguntarRepresentante
  Left = 0
  Top = 0
  ClientHeight = 245
  ClientWidth = 581
  Caption = 'Grabe los datos del representante'
  BorderStyle = bsSingle
  OldCreateOrder = False
  BorderIcons = []
  KeyPreview = True
  MonitoredKeys.Keys = <>
  OnCreate = UniFormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TUniBitBtn
    Left = 138
    Top = 184
    Width = 257
    Height = 25
    Caption = 'Aceptar y grabar datos del representante'
    TabOrder = 3
    OnClick = Button1Click
  end
  object UniLabel1: TUniLabel
    Left = 16
    Top = 16
    Width = 89
    Height = 13
    Caption = 'NIF representante'
    TabOrder = 4
  end
  object UniLabel2: TUniLabel
    Left = 16
    Top = 67
    Width = 109
    Height = 13
    Caption = 'Nombre representante'
    TabOrder = 5
  end
  object UniLabel3: TUniLabel
    Left = 16
    Top = 120
    Width = 101
    Height = 13
    Caption = 'Cargo representante'
    TabOrder = 6
  end
  object UniDBEditRep_Nombre: TUniDBEdit
    Left = 16
    Top = 85
    Width = 516
    Height = 22
    DataField = 'REPRESENTANTE_NOMBRE_EMP'
    DataSource = DataSource_representante
    ParentFont = False
    Font.Height = -13
    TabOrder = 1
  end
  object lbNombre_ast: TUniLabel
    Left = 138
    Top = 35
    Width = 10
    Height = 19
    Caption = '*'
    ParentFont = False
    Font.Color = 14062137
    Font.Height = -16
    Font.Style = [fsBold]
    ParentColor = False
    Color = clBtnFace
    TabOrder = 7
  end
  object UniDBEditREP_NIF: TUniDBEdit
    Left = 16
    Top = 33
    Width = 109
    Height = 22
    DataField = 'REPRESENTANTE_NIF_EMP'
    DataSource = DataSource_representante
    CharCase = ecUpperCase
    ParentFont = False
    Font.Height = -13
    TabOrder = 0
    OnAjaxEvent = UniDBEditREP_NIFAjaxEvent
  end
  object UniLabel4: TUniLabel
    Left = 538
    Top = 87
    Width = 10
    Height = 19
    Caption = '*'
    ParentFont = False
    Font.Color = 14062137
    Font.Height = -16
    Font.Style = [fsBold]
    ParentColor = False
    Color = clBtnFace
    TabOrder = 8
  end
  object UniLabel5: TUniLabel
    Left = 538
    Top = 140
    Width = 10
    Height = 19
    Caption = '*'
    ParentFont = False
    Font.Color = 14062137
    Font.Height = -16
    Font.Style = [fsBold]
    ParentColor = False
    Color = clBtnFace
    TabOrder = 9
  end
  object UniDBEditRep_cargo: TUniDBEdit
    Left = 16
    Top = 138
    Width = 516
    Height = 22
    DataField = 'REPRESENTANTE_CARGO_EMP'
    DataSource = DataSource_representante
    ParentFont = False
    Font.Height = -13
    TabOrder = 2
  end
  object DataSource_representante: TDataSource
    Left = 312
    Top = 48
  end
end
