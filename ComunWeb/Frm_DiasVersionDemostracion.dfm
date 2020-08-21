object FrmDiasVersionDemostracion: TFrmDiasVersionDemostracion
  Left = 0
  Top = 0
  ClientHeight = 135
  ClientWidth = 422
  Caption = 'Versi'#243'n demostraci'#243'n'
  OldCreateOrder = False
  OnClose = UniFormClose
  BorderIcons = [biSystemMenu]
  MonitoredKeys.Keys = <>
  PixelsPerInch = 96
  TextHeight = 13
  object lblQuedan: TUniLabel
    Left = 24
    Top = 24
    Width = 313
    Height = 13
    Hint = ''
    Caption = 'Quedan %d d'#237'as para la finalizaci'#243'n del periodo de demostraci'#243'n.'
    TabOrder = 0
  end
  object lblContinuar: TUniLabel
    Left = 24
    Top = 55
    Width = 237
    Height = 13
    Hint = ''
    Caption = #191'Deseas contratar ahora nuestro servicio de %s?'
    TabOrder = 1
  end
  object UniButton1: TUniButton
    Left = 16
    Top = 100
    Width = 117
    Height = 25
    Hint = ''
    Caption = 'Contratar Ahora'
    ModalResult = 6
    TabOrder = 2
  end
  object UniButton2: TUniButton
    Left = 152
    Top = 100
    Width = 262
    Height = 25
    Hint = ''
    Caption = 'Continuar con el periodo de demostraci'#243'n'
    ModalResult = 7
    TabOrder = 3
  end
end
