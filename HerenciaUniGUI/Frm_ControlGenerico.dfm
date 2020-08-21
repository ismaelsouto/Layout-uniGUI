object FrmControlGenerico: TFrmControlGenerico
  Left = 0
  Top = 0
  ClientHeight = 439
  ClientWidth = 776
  Caption = 'FrmControlGenerico'
  OldCreateOrder = False
  OnKeyDown = UniFormKeyDown
  BorderIcons = [biSystemMenu, biMaximize]
  KeyPreview = True
  MonitoredKeys.Keys = <>
  OnCreate = UniFormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object UniGenericControl1: TUniGenericControl
    Left = 0
    Top = 0
    Width = 776
    Height = 439
    Align = alClient
    Anchors = [akLeft, akTop, akRight, akBottom]
    Color = clBtnFace
  end
end
