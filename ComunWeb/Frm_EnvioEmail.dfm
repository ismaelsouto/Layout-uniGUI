object FrmEnvioEmail: TFrmEnvioEmail
  Left = 0
  Top = 0
  ClientHeight = 315
  ClientWidth = 594
  Caption = 'Env'#237'o email'
  OldCreateOrder = False
  OnKeyDown = UniFormKeyDown
  KeyPreview = True
  MonitoredKeys.Keys = <>
  ActiveControl = ASUNTO
  OnCreate = UniFormCreate
  DesignSize = (
    594
    315)
  PixelsPerInch = 96
  TextHeight = 13
  object UniToolBar1: TUniToolBar
    Left = 0
    Top = 0
    Width = 594
    Height = 35
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
    ExplicitWidth = 596
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
    end
  end
  object UniLabel1: TUniLabel
    Left = 22
    Top = 48
    Width = 34
    Height = 13
    Caption = 'Asunto'
    TabOrder = 3
  end
  object ASUNTO: TUniEdit
    Left = 22
    Top = 67
    Width = 553
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 0
    ExplicitWidth = 555
  end
  object UniLabel2: TUniLabel
    Left = 22
    Top = 104
    Width = 40
    Height = 13
    Caption = 'Mensaje'
    TabOrder = 4
  end
  object MENSAJE: TUniHTMLMemo
    Left = 22
    Top = 120
    Width = 553
    Height = 178
    Anchors = [akLeft, akTop, akRight, akBottom]
    Color = clWindow
    TabOrder = 1
    ExplicitWidth = 555
    ExplicitHeight = 158
  end
end
