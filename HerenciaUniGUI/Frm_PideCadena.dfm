object FrmPideCadena: TFrmPideCadena
  Left = 0
  Top = 0
  ClientHeight = 121
  ClientWidth = 368
  Caption = 'Pide cadena'
  BorderStyle = bsDialog
  OldCreateOrder = False
  OnKeyDown = UniFormKeyDown
  BorderIcons = [biSystemMenu, biMinimize]
  KeyPreview = True
  MonitoredKeys.Keys = <>
  ActiveControl = VALOR
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object UniToolBar1: TUniToolBar
    Left = 0
    Top = 0
    Width = 368
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
  object ULTexto: TUniLabel
    Left = 19
    Top = 52
    Width = 28
    Height = 13
    Caption = 'Texto'
    TabOrder = 1
  end
  object VALOR: TUniEdit
    Left = 19
    Top = 68
    Width = 325
    TabOrder = 2
  end
end
