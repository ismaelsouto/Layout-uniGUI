object FrmVisorPDF: TFrmVisorPDF
  Left = 0
  Top = 0
  ClientHeight = 561
  ClientWidth = 901
  Caption = 'Visor PDF'
  OldCreateOrder = False
  OnClose = UniFormClose
  OnKeyDown = UniFormKeyDown
  BorderIcons = [biSystemMenu, biMaximize]
  KeyPreview = True
  MonitoredKeys.Enabled = True
  MonitoredKeys.KeyHandleAll = False
  MonitoredKeys.Keys = <>
  ActiveControl = UniURLFrame1
  Font.Name = 'Open Sans'
  OnCreate = UniFormCreate
  PixelsPerInch = 96
  TextHeight = 14
  object UniURLFrame1: TUniURLFrame
    Left = 0
    Top = 0
    Width = 901
    Height = 561
    Hint = ''
    Align = alClient
    TabOrder = 0
    ParentColor = False
    Color = clWindow
    OnFrameLoaded = UniURLFrame1FrameLoaded
  end
  object UniPDFFrame1: TUniPDFFrame
    Left = 0
    Top = 0
    Width = 901
    Height = 561
    Hint = ''
    Align = alClient
    TabOrder = 1
    ExplicitLeft = 40
    ExplicitTop = 192
  end
end
