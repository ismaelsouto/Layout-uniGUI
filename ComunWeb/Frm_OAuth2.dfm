object FrmOAuth2: TFrmOAuth2
  Left = 0
  Top = 0
  ClientHeight = 85
  ClientWidth = 146
  Caption = 'Autorizando'
  BorderStyle = bsNone
  OldCreateOrder = False
  MonitoredKeys.Keys = <>
  PixelsPerInch = 96
  TextHeight = 13
  object UniLabel1: TUniLabel
    Left = 9
    Top = 9
    Width = 120
    Height = 36
    Hint = ''
    Alignment = taCenter
    AutoSize = False
    Caption = 'Autorizando'
    ParentFont = False
    Font.Color = clRed
    Font.Height = -20
    TabOrder = 0
  end
  object UniButton1: TUniButton
    Left = 32
    Top = 39
    Width = 75
    Height = 25
    Hint = ''
    Caption = 'Cancelar'
    TabOrder = 1
    ScreenMask.Enabled = True
    ScreenMask.Message = 'Enviando correo...'
    OnClick = UniButton1Click
  end
  object UniTimer1: TUniTimer
    Interval = 500
    Enabled = False
    ClientEvent.Strings = (
      'function(sender)'
      '{'
      ' '
      '}')
    OnTimer = UniTimer1Timer
    Top = 8
  end
end
