object FrmCAICONECTA: TFrmCAICONECTA
  Left = 0
  Top = 0
  ClientHeight = 490
  ClientWidth = 841
  Caption = 'CAICONECTA'
  OnShow = UniFormShow
  OldCreateOrder = False
  OnClose = UniFormClose
  OnKeyDown = UniFormKeyDown
  BorderIcons = [biSystemMenu, biMaximize]
  KeyPreview = True
  MonitoredKeys.Enabled = True
  MonitoredKeys.KeyHandleAll = False
  MonitoredKeys.Keys = <>
  OnCreate = UniFormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object UniPanel1: TUniPanel
    Left = 0
    Top = 0
    Width = 841
    Height = 153
    Hint = ''
    Align = alTop
    TabOrder = 0
    BorderStyle = ubsNone
    ShowCaption = False
    Caption = ''
    object UniPageControl1: TUniPageControl
      Left = 0
      Top = 0
      Width = 841
      Height = 153
      Hint = ''
      ActivePage = UTSNoLeidos
      Align = alClient
      TabOrder = 1
      OnChange = UniPageControl1Change
      object UTSNoLeidos: TUniTabSheet
        Hint = ''
        Caption = 'No leidos'
        DesignSize = (
          833
          125)
        object UniDBMemo1: TUniDBMemo
          Left = 16
          Top = 40
          Width = 803
          Height = 78
          Hint = ''
          DataField = 'MENSAJE'
          DataSource = DSMensajesNoLeidos
          BorderStyle = ubsNone
          Anchors = [akLeft, akTop, akRight, akBottom]
          ReadOnly = True
          TabOrder = 0
          Color = clInfoBk
        end
        object UniToolBar1: TUniToolBar
          Left = 0
          Top = 0
          Width = 833
          Height = 35
          Hint = ''
          ButtonHeight = 33
          ButtonWidth = 34
          ShowCaptions = True
          TabOrder = 1
          ParentColor = False
          Color = clBtnFace
          ParentFont = False
          Font.Color = 14062137
          Font.Height = -24
          Font.Name = 'cai'
          object UBSiguiente: TUniToolButton
            Left = 0
            Top = 0
            Hint = 'Siguiente registro'
            ShowHint = True
            ParentShowHint = False
            Caption = '7'
            TabOrder = 1
            OnClick = UBSiguienteClick
          end
          object UTBMarcarTodos: TUniToolButton
            Left = 34
            Top = 0
            Hint = 'Marcar todos como le'#237'dos'
            ShowHint = True
            ParentShowHint = False
            Caption = 'T'
            TabOrder = 2
            OnClick = UTBMarcarTodosClick
          end
          object UniToolButton1: TUniToolButton
            Left = 68
            Top = 0
            Width = 39
            Hint = ''
            Style = tbsSeparator
            Caption = 'UniToolButton1'
            TabOrder = 3
          end
          object UBSalir: TUniToolButton
            Left = 107
            Top = 0
            Hint = 'Salir de este mantenimiento'
            ShowHint = True
            ParentShowHint = False
            Caption = 's'
            TabOrder = 4
            OnClick = UBSalirClick
          end
        end
      end
      object UTSLeidos: TUniTabSheet
        Hint = ''
        Caption = 'Le'#237'dos'
        object UniDBGrid1: TUniDBGrid
          Left = 0
          Top = 35
          Width = 833
          Height = 90
          Hint = ''
          DataSource = DSMensajesLeidos
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgRowSelect, dgConfirmDelete]
          WebOptions.Paged = False
          LoadMask.Message = 'Loading data...'
          Align = alClient
          TabOrder = 0
          Columns = <
            item
              FieldName = 'SMENSAJE'
              Title.Caption = ' Mensaje'
              Width = 474
            end
            item
              FieldName = 'FECHA'
              Title.Caption = ' Fecha'
              Width = 105
            end>
        end
        object UniToolBar2: TUniToolBar
          Left = 0
          Top = 0
          Width = 833
          Height = 35
          Hint = ''
          ButtonHeight = 33
          ButtonWidth = 34
          ShowCaptions = True
          TabOrder = 1
          ParentColor = False
          Color = clBtnFace
          ParentFont = False
          Font.Color = 14062137
          Font.Height = -24
          Font.Name = 'cai'
          object UBPrimero: TUniToolButton
            Left = 0
            Top = 0
            Hint = 'Primer Registro'
            ShowHint = True
            ParentShowHint = False
            Caption = '5'
            TabOrder = 1
            OnClick = UBPrimeroClick
          end
          object UBAnterior: TUniToolButton
            Left = 34
            Top = 0
            Hint = 'Anterior registro'
            ShowHint = True
            ParentShowHint = False
            Caption = '6'
            TabOrder = 2
            OnClick = UBAnteriorClick
          end
          object UBSiguiente2: TUniToolButton
            Left = 68
            Top = 0
            Hint = 'Siguiente registro'
            ShowHint = True
            ParentShowHint = False
            Caption = '7'
            TabOrder = 3
            OnClick = UBSiguiente2Click
          end
          object UBUltimo: TUniToolButton
            Left = 102
            Top = 0
            Hint = #218'ltimo registro'
            ShowHint = True
            ParentShowHint = False
            Caption = '8'
            TabOrder = 4
            OnClick = UBUltimoClick
          end
          object UniToolButton3: TUniToolButton
            Left = 136
            Top = 0
            Width = 29
            Hint = ''
            Style = tbsSeparator
            Caption = 'UniToolButton1'
            TabOrder = 5
          end
          object UniToolButton5: TUniToolButton
            Left = 165
            Top = 0
            Hint = 'Salir'
            ShowHint = True
            ParentShowHint = False
            Caption = 's'
            TabOrder = 6
            OnClick = UBSalirClick
          end
        end
      end
    end
  end
  object UniPanel2: TUniPanel
    Left = 0
    Top = 159
    Width = 841
    Height = 331
    Hint = ''
    Align = alClient
    TabOrder = 1
    Caption = 'UniPanel2'
    object UniURLFrame1: TUniURLFrame
      Left = 1
      Top = 1
      Width = 839
      Height = 329
      Hint = ''
      Align = alClient
      TabOrder = 1
      ParentColor = False
      Color = clBtnFace
    end
  end
  object UniSplitter1: TUniSplitter
    Left = 0
    Top = 153
    Width = 841
    Height = 6
    Cursor = crVSplit
    Hint = ''
    Align = alTop
    ParentColor = False
    Color = clBtnFace
  end
  object DSMensajesLeidos: TDataSource
    Left = 472
    Top = 16
  end
  object DSMensajesNoLeidos: TDataSource
    Left = 272
    Top = 16
  end
end
