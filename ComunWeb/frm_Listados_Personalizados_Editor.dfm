inherited frmListadosPersonalizadosEditor: TfrmListadosPersonalizadosEditor
  ClientHeight = 161
  ClientWidth = 893
  Caption = 'Listados y procesos personalizados'
  BorderStyle = bsSizeable
  ExplicitWidth = 909
  ExplicitHeight = 200
  PixelsPerInch = 96
  TextHeight = 14
  inherited UniToolBar1: TUniToolBar
    Width = 893
    ExplicitWidth = 893
    inherited ubExcel: TUniToolButton
      Visible = True
      OnClick = ubExcelClick
    end
  end
  object pnContenedor: TUniPanel [1]
    Left = 0
    Top = 38
    Width = 893
    Height = 123
    Hint = ''
    Align = alClient
    TabOrder = 1
    Caption = ''
    ExplicitHeight = 61
    object UniMemo1: TUniMemo
      Left = 1
      Top = 25
      Width = 891
      Height = 64
      Hint = ''
      BorderStyle = ubsFrameLowered
      ScrollBars = ssBoth
      Align = alTop
      ReadOnly = True
      Color = clInfoBk
      TabOrder = 1
      ExplicitTop = 41
    end
    object UniPanel1: TUniPanel
      Left = 1
      Top = 1
      Width = 891
      Height = 24
      Hint = ''
      Align = alTop
      TabOrder = 2
      BorderStyle = ubsNone
      Caption = ''
      object UniLabel1: TUniLabel
        Left = 7
        Top = 4
        Width = 61
        Height = 14
        Hint = ''
        Caption = 'Descripci'#243'n'
        TabOrder = 1
      end
    end
  end
  inherited DSConsulta: TDataSource
    Left = 304
  end
  inherited CDSParametros: TFDMemTable
    Left = 336
  end
  inherited ppReport1: TppReport
    Left = 440
    DataPipelineName = 'ppDBPipeline1'
  end
  inherited ppDBPipeline1: TppDBPipeline
    Left = 368
  end
  inherited DSParametros: TDataSource
    Left = 408
    Top = 0
  end
  inherited ppDBPParametros: TppDBPipeline
    Left = 472
  end
  inherited cdsconsulta: TFDQuery
    Left = 272
    Top = 0
  end
  inherited UniScreenMask1: TUniScreenMask
    Left = 512
    Top = 0
  end
  inherited UniScreenMask3: TUniScreenMask
    Left = 536
    Top = 0
  end
  object ADQuery1: TFDQuery
    FormatOptions.AssignedValues = [fvSE2Null]
    Left = 592
  end
end
