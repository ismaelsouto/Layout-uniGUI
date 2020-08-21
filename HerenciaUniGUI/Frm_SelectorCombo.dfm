object FrmSelectorCombo: TFrmSelectorCombo
  Left = 0
  Top = 0
  ClientHeight = 106
  ClientWidth = 317
  Caption = 'FrmSelectorCombo'
  BorderStyle = bsDialog
  OldCreateOrder = False
  OnClose = UniFormClose
  OnKeyDown = UniFormKeyDown
  BorderIcons = [biSystemMenu, biMinimize]
  KeyPreview = True
  MonitoredKeys.Keys = <>
  OnCreate = UniFormCreate
  DesignSize = (
    317
    106)
  PixelsPerInch = 96
  TextHeight = 13
  object UniToolBar1: TUniToolBar
    Left = 0
    Top = 0
    Width = 317
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
  object SELECTOR: TUniDBLookupComboBox
    Left = 24
    Top = 56
    Width = 260
    Hint = ''
    ListSource = DSSelector
    ListFieldIndex = 0
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 1
    Color = clWindow
    ExplicitWidth = 361
  end
  object DSSelector: TDataSource
    Left = 248
    Top = 8
  end
end
