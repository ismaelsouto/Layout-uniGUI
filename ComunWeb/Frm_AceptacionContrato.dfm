object FrmAceptacionContrato: TFrmAceptacionContrato
  Left = 0
  Top = 0
  ClientHeight = 102
  ClientWidth = 443
  Caption = 'Aceptaci'#243'n de t'#233'rminos y condiciones de contrataci'#243'n'
  BorderStyle = bsDialog
  OldCreateOrder = False
  OnClose = UniFormClose
  BorderIcons = [biSystemMenu]
  KeyPreview = True
  MonitoredKeys.Keys = <>
  ActiveControl = UCBAceptar
  OnCreate = UniFormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object UCBAceptar: TUniCheckBox
    Left = 32
    Top = 56
    Width = 313
    Height = 17
    Caption = 'He le'#237'do y acepto los t'#233'rminos y condiciones de contrataci'#243'n'
    TabOrder = 0
  end
  object UniToolBar1: TUniToolBar
    Left = 0
    Top = 0
    Width = 443
    Height = 35
    ButtonHeight = 33
    ButtonWidth = 34
    ShowCaptions = True
    Anchors = [akLeft, akTop, akRight]
    Align = alTop
    TabOrder = 1
    ParentColor = False
    Color = clBtnFace
    ParentFont = False
    Font.Color = 14062137
    Font.Height = -24
    Font.Name = 'cai'
    object UBSalir: TUniToolButton
      Left = 0
      Top = 0
      Hint = 'Salir'
      ShowHint = True
      ParentShowHint = False
      Caption = 's'
      TabOrder = 1
      OnClick = UBSalirClick
    end
  end
  object ULLeer: TUniLabel
    Left = 356
    Top = 56
    Width = 25
    Height = 13
    TextConversion = txtHTML
    Caption = 'Leer'
    ParentFont = False
    Font.Color = clHotLight
    Font.Style = [fsBold, fsUnderline]
    ParentColor = False
    Color = clBtnFace
    TabOrder = 2
    OnClick = ULLeerClick
  end
end
