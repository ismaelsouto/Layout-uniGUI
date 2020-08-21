inherited FrmGuiaRapida: TFrmGuiaRapida
  ClientHeight = 443
  ClientWidth = 630
  Caption = 'Gu'#237'a r'#225'pida'
  BorderStyle = bsDialog
  BorderIcons = [biSystemMenu]
  ExplicitWidth = 636
  ExplicitHeight = 469
  PixelsPerInch = 96
  TextHeight = 14
  inherited UniURLFrame1: TUniURLFrame
    Width = 630
    Height = 407
    ExplicitWidth = 620
    ExplicitHeight = 397
  end
  object UniPanel1: TUniPanel
    Left = 0
    Top = 407
    Width = 630
    Height = 36
    Align = alBottom
    Anchors = [akLeft, akRight, akBottom]
    TabOrder = 1
    ExplicitTop = 397
    ExplicitWidth = 620
    object UniCheckBox1: TUniCheckBox
      Left = 19
      Top = 9
      Width = 606
      Height = 17
      Caption = 'No volver a mostrar'
      TabOrder = 1
    end
  end
end
