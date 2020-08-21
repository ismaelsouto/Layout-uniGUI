object FrmSelectorRadioGroup: TFrmSelectorRadioGroup
  Left = 0
  Top = 0
  ClientHeight = 133
  ClientWidth = 179
  Caption = 'FrmSelectorRadioGroup'
  BorderStyle = bsDialog
  OldCreateOrder = False
  OnKeyDown = UniFormKeyDown
  KeyPreview = True
  MonitoredKeys.Keys = <>
  OnCreate = UniFormCreate
  DesignSize = (
    179
    133)
  PixelsPerInch = 96
  TextHeight = 13
  object UniToolBar1: TUniToolBar
    Left = 0
    Top = 0
    Width = 179
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
    Font.Name = 'cai'
    ExplicitWidth = 278
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
  object UniRadioGroup1: TUniRadioGroup
    Left = 8
    Top = 41
    Width = 159
    Height = 85
    Hint = ''
    Anchors = [akLeft, akTop, akRight, akBottom]
    Caption = 'Selecci'#243'n'
    TabOrder = 1
    ExplicitWidth = 249
    ExplicitHeight = 175
  end
end
