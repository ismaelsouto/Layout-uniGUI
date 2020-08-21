object FrmVisorContrato: TFrmVisorContrato
  Left = 0
  Top = 0
  ClientHeight = 529
  ClientWidth = 947
  Caption = 'Aceptar documento'
  OnShow = UniFormShow
  OldCreateOrder = False
  OnKeyDown = UniFormKeyDown
  BorderIcons = [biSystemMenu]
  KeyPreview = True
  MonitoredKeys.Keys = <>
  Font.Height = -13
  PixelsPerInch = 96
  TextHeight = 16
  object UTBBotonera: TUniToolBar
    Left = 0
    Top = 494
    Width = 947
    Height = 35
    Hint = ''
    Visible = False
    ButtonHeight = 33
    ButtonWidth = 34
    ShowCaptions = True
    Align = alBottom
    TabOrder = 0
    ParentColor = False
    Color = clBtnFace
    ParentFont = False
    Font.Color = 14062137
    Font.Height = -24
    Font.Name = 'CAI'
    object UBAceptar: TUniToolButton
      Left = 0
      Top = 0
      Hint = 'Aceptar'
      Visible = False
      ShowHint = True
      ParentShowHint = False
      ImageIndex = 0
      Caption = 'V'
      TabOrder = 1
      OnClick = UBAceptarClick
    end
    object UBCancelar: TUniToolButton
      Left = 34
      Top = 0
      Hint = 'Cancelar'
      Visible = False
      ShowHint = True
      ParentShowHint = False
      ImageIndex = 1
      Caption = 'X'
      TabOrder = 2
      OnClick = UBCancelarClick
    end
  end
  object UniPanel1: TUniPanel
    Left = 0
    Top = 442
    Width = 947
    Height = 52
    Hint = ''
    Align = alBottom
    ParentFont = False
    Font.Height = -16
    TabOrder = 1
    Caption = ''
    Color = clMenuBar
    DesignSize = (
      947
      52)
    object UniCheckBoxAceptar: TUniCheckBox
      AlignWithMargins = True
      Left = 32
      Top = 15
      Width = 345
      Height = 20
      Cursor = crHandPoint
      Hint = ''
      Caption = 'He le'#237'do y acepto los t'#233'rminos y condiciones'
      ParentFont = False
      Font.Color = 14062137
      Font.Height = -16
      TabOrder = 1
      OnChange = UniCheckBoxAceptarChange
    end
    object UBConfirmar: TUniBitBtn
      Left = 404
      Top = 13
      Width = 201
      Height = 25
      Hint = 
        'Documento aceptado pulse para confirmar los cambios y cerrar la ' +
        'pantalla'
      Visible = False
      ShowHint = True
      ParentShowHint = False
      Caption = 'Confirmar cambios y cerrar'
      ParentFont = False
      Font.Color = clWhite
      Font.Height = -13
      TabOrder = 2
      OnClick = UBConfirmarClick
    end
    object UniBitBtn1: TUniBitBtn
      Left = 896
      Top = 13
      Width = 33
      Height = 25
      Hint = 'Imprimir presentaci'#243'n preliminar del documento'
      ShowHint = True
      ParentShowHint = False
      Caption = 'P'
      Anchors = [akTop, akRight]
      ParentFont = False
      Font.Color = clWhite
      Font.Height = -19
      Font.Name = 'cai'
      TabOrder = 3
      OnClick = UniBitBtn1Click
    end
  end
  object UniURLFrame1: TUniURLFrame
    Left = 0
    Top = 0
    Width = 947
    Height = 442
    Hint = ''
    Align = alClient
    TabOrder = 2
    ParentColor = False
    Color = clWindow
  end
  object UniScreenMask1: TUniScreenMask
    AttachedControl = UBConfirmar
    Enabled = True
    DisplayMessage = 'Guardando cambios ...'
    Left = 664
    Top = 432
  end
end
