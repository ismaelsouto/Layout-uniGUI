object FrmMensaje: TFrmMensaje
  Left = 0
  Top = 0
  ClientHeight = 337
  ClientWidth = 386
  Caption = 'Mensaje'
  OnShow = UniFormShow
  OldCreateOrder = False
  OnClose = UniFormClose
  OnKeyDown = UniFormKeyDown
  KeyPreview = True
  MonitoredKeys.Keys = <>
  ActiveControl = UniMemoMensaje
  OnCreate = UniFormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object UniToolBar1: TUniToolBar
    Left = 0
    Top = 0
    Width = 386
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
  object UniMemoMensaje: TUniMemo
    Left = 0
    Top = 35
    Width = 386
    Height = 302
    Align = alClient
    Anchors = [akLeft, akTop, akRight, akBottom]
    ReadOnly = True
    Color = clInfoBk
    TabOrder = 1
  end
  object UniHTMLMemo1: TUniHTMLMemo
    Left = 0
    Top = 35
    Width = 386
    Height = 302
    Lines.Strings = (
      'UniHTMLMemo1')
    Align = alClient
    Anchors = [akLeft, akTop, akRight, akBottom]
    ReadOnly = True
    Color = clWindow
    TabOrder = 2
    ShowToolbar = False
  end
end
