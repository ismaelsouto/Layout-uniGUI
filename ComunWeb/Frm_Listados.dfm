object Listados: TListados
  Left = 320
  Top = 154
  ClientHeight = 641
  ClientWidth = 1031
  Caption = ''
  OnShow = UniFormShow
  BorderStyle = bsDialog
  OldCreateOrder = False
  OnClose = UniFormClose
  OnKeyDown = UniFormKeyDown
  BorderIcons = [biSystemMenu]
  KeyPreview = True
  MonitoredKeys.Enabled = True
  MonitoredKeys.KeyHandleAll = False
  MonitoredKeys.Keys = <>
  Font.Height = -12
  OnCreate = UniFormCreate
  PixelsPerInch = 96
  TextHeight = 14
  object UniToolBar1: TUniToolBar
    Left = 0
    Top = 0
    Width = 1031
    Height = 38
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
    object UniToolButton2: TUniToolButton
      Left = 0
      Top = 0
      Hint = 'Imprimir listado'
      ShowHint = True
      ParentShowHint = False
      Caption = 'P'
      TabOrder = 1
      OnClick = UBImprimirClick
      ExplicitLeft = -6
      ExplicitTop = 2
    end
    object ubExcel: TUniToolButton
      Left = 34
      Top = 0
      Hint = 'Excel'
      Visible = False
      ShowHint = True
      ParentShowHint = False
      Caption = 'e'
      TabOrder = 2
    end
    object UniToolButton3: TUniToolButton
      Left = 68
      Top = 0
      Width = 31
      Hint = ''
      Style = tbsContainer
      Caption = 'UniToolButton3'
      TabOrder = 3
    end
    object UniToolButton1: TUniToolButton
      Left = 99
      Top = 0
      Hint = 'Salir de este mantenimiento'
      ShowHint = True
      ParentShowHint = False
      Caption = 's'
      TabOrder = 4
      OnClick = UBSalirClick
    end
  end
  object DSConsulta: TDataSource
    DataSet = cdsconsulta
    Left = 128
  end
  object CDSParametros: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    Left = 192
  end
  object ppReport1: TppReport
    AutoStop = False
    DataPipeline = ppDBPipeline1
    PrinterSetup.BinName = 'Default'
    PrinterSetup.DocumentName = 'Report'
    PrinterSetup.Duplex = dpNone
    PrinterSetup.PaperName = 'A4'
    PrinterSetup.PrinterName = 'Default'
    PrinterSetup.SaveDeviceSettings = False
    PrinterSetup.mmMarginBottom = 6350
    PrinterSetup.mmMarginLeft = 6350
    PrinterSetup.mmMarginRight = 6350
    PrinterSetup.mmMarginTop = 6350
    PrinterSetup.mmPaperHeight = 297000
    PrinterSetup.mmPaperWidth = 210000
    PrinterSetup.PaperSize = 9
    ArchiveFileName = '($MyDocuments)\ReportArchive.raf'
    DeviceType = 'PDF'
    DefaultFileDeviceType = 'PDF'
    EmailSettings.ReportFormat = 'PDF'
    LanguageID = 'Default'
    ModalCancelDialog = False
    ModalPreview = False
    OpenFile = False
    OutlineSettings.CreateNode = True
    OutlineSettings.CreatePageNodes = True
    OutlineSettings.Enabled = True
    OutlineSettings.Visible = True
    ThumbnailSettings.Enabled = True
    ThumbnailSettings.Visible = True
    ThumbnailSettings.DeadSpace = 30
    ThumbnailSettings.PageHighlight.Width = 3
    PDFSettings.CompressionLevel = clFastest
    PDFSettings.EmbedFontOptions = [efUseSubset]
    PDFSettings.EncryptSettings.AllowCopy = True
    PDFSettings.EncryptSettings.AllowInteract = True
    PDFSettings.EncryptSettings.AllowModify = True
    PDFSettings.EncryptSettings.AllowPrint = True
    PDFSettings.EncryptSettings.AllowExtract = True
    PDFSettings.EncryptSettings.AllowAssemble = True
    PDFSettings.EncryptSettings.AllowQualityPrint = True
    PDFSettings.EncryptSettings.Enabled = False
    PDFSettings.EncryptSettings.KeyLength = kl40Bit
    PDFSettings.EncryptSettings.EncryptionType = etRC4
    PDFSettings.FontEncoding = feAnsi
    PDFSettings.ImageCompressionLevel = 25
    PDFSettings.PDFAFormat = pafNone
    PreviewFormSettings.PageBorder.mmPadding = 0
    RTFSettings.DefaultFont.Charset = DEFAULT_CHARSET
    RTFSettings.DefaultFont.Color = clWindowText
    RTFSettings.DefaultFont.Height = -13
    RTFSettings.DefaultFont.Name = 'Arial'
    RTFSettings.DefaultFont.Style = []
    ShowCancelDialog = False
    ShowPrintDialog = False
    TextFileName = '($MyDocuments)\Report.pdf'
    TextSearchSettings.DefaultString = '<FindText>'
    TextSearchSettings.Enabled = True
    XLSSettings.AppName = 'ReportBuilder'
    XLSSettings.Author = 'ReportBuilder'
    XLSSettings.Subject = 'Report'
    XLSSettings.Title = 'Report'
    XLSSettings.WorksheetName = 'Report'
    Left = 168
    Top = 8
    Version = '19.03'
    mmColumnWidth = 0
    DataPipelineName = 'ppDBPipeline1'
    object ppHeaderBand1: TppHeaderBand
      Background.Brush.Style = bsClear
      Border.mmPadding = 0
      mmBottomOffset = 0
      mmHeight = 13229
      mmPrintPosition = 0
    end
    object ppDetailBand1: TppDetailBand
      Background1.Brush.Style = bsClear
      Background2.Brush.Style = bsClear
      Border.mmPadding = 0
      mmBottomOffset = 0
      mmHeight = 13229
      mmPrintPosition = 0
    end
    object ppFooterBand1: TppFooterBand
      Background.Brush.Style = bsClear
      Border.mmPadding = 0
      mmBottomOffset = 0
      mmHeight = 13229
      mmPrintPosition = 0
    end
    object ppDesignLayers1: TppDesignLayers
      object ppDesignLayer1: TppDesignLayer
        UserName = 'Foreground'
        LayerType = ltBanded
        Index = 0
      end
    end
    object ppParameterList1: TppParameterList
    end
  end
  object ppDBPipeline1: TppDBPipeline
    DataSource = DSConsulta
    UserName = 'DBPipeline1'
    Left = 184
    Top = 88
  end
  object DSParametros: TDataSource
    DataSet = CDSParametros
    Left = 128
    Top = 56
  end
  object ppDBPParametros: TppDBPipeline
    DataSource = DSParametros
    UserName = 'DBPParametros'
    Left = 304
    Top = 64
  end
  object cdsconsulta: TFDQuery
    BeforeOpen = cdsconsultaBeforeOpen
    AfterOpen = cdsconsultaAfterOpen
    FormatOptions.AssignedValues = [fvSE2Null]
    Left = 56
    Top = 24
  end
  object UniScreenMask1: TUniScreenMask
    AttachedControl = UniToolButton2
    Enabled = True
    DisplayMessage = 'Generando informe...'
    Left = 104
    Top = 56
  end
  object UniScreenMask3: TUniScreenMask
    AttachedControl = ubExcel
    Enabled = True
    DisplayMessage = 'Generando informe...'
    Left = 208
    Top = 32
  end
end
