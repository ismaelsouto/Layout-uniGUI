object FrmAvisoTimeOut: TFrmAvisoTimeOut
  Left = 0
  Top = 0
  ClientHeight = 129
  ClientWidth = 241
  Caption = 'FrmAvisoTimeOut'
  BorderStyle = bsNone
  OldCreateOrder = False
  MonitoredKeys.Keys = <>
  OnCreate = UniFormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object UniButton1: TUniButton
    Left = 62
    Top = 71
    Width = 105
    Height = 33
    Hint = ''
    Caption = 'Cancelar'
    TabOrder = 0
    OnClick = UniButton1Click
  end
  object UniLabel1: TUniLabel
    Left = 9
    Top = 9
    Width = 210
    Height = 56
    Hint = ''
    Alignment = taCenter
    AutoSize = False
    Caption = 'La sesi'#243'n se cerrar'#225' en  59 segundos'
    ParentFont = False
    Font.Color = 14062137
    Font.Height = -20
    TabOrder = 1
  end
  object UniTimer1: TUniTimer
    ClientEvent.Strings = (
      'function(sender)'
      '{'
      ' '
      '}')
    OnTimer = UniTimer1Timer
    Left = 192
    Top = 16
  end
end
