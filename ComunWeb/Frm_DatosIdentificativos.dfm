object FrmDatosIdentificativos: TFrmDatosIdentificativos
  Left = 0
  Top = 0
  ClientHeight = 348
  ClientWidth = 712
  Caption = 'Datos identificativos'
  BorderStyle = bsDialog
  OldCreateOrder = False
  OnKeyDown = UniFormKeyDown
  BorderIcons = [biSystemMenu, biMinimize]
  KeyPreview = True
  MonitoredKeys.Enabled = True
  MonitoredKeys.KeyHandleAll = False
  MonitoredKeys.Keys = <>
  ActiveControl = NIF
  OnCreate = UniFormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object UniToolBar1: TUniToolBar
    Left = 0
    Top = 0
    Width = 712
    Height = 35
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
    object UBAceptar: TUniToolButton
      Left = 0
      Top = 0
      Hint = 'Aceptar'
      ShowHint = True
      ParentShowHint = False
      Caption = 'V'
      TabOrder = 1
      OnClick = UBAceptarClick
    end
    object UBCancelar: TUniToolButton
      Left = 34
      Top = 0
      Hint = 'Cancelar'
      ShowHint = True
      ParentShowHint = False
      Caption = 'X'
      TabOrder = 2
      OnClick = UBCancelarClick
    end
  end
  object PanelContenedor: TUniPanel
    Left = 0
    Top = 35
    Width = 712
    Height = 313
    Hint = ''
    Align = alClient
    TabOrder = 1
    BorderStyle = ubsNone
    ShowCaption = False
    Caption = ''
    object NIF: TUniDBEdit
      Left = 149
      Top = 10
      Width = 161
      Height = 22
      Hint = ''
      DataField = 'NIF'
      DataSource = DSDatos
      TabOrder = 1
      OnAjaxEvent = NIFAjaxEvent
    end
    object PFAPELL1: TUniDBEdit
      Left = 149
      Top = 34
      Width = 154
      Height = 22
      Hint = ''
      DataField = 'PFAPELL1'
      DataSource = DSDatos
      TabOrder = 2
    end
    object PFAPELL2: TUniDBEdit
      Left = 309
      Top = 34
      Width = 157
      Height = 22
      Hint = ''
      DataField = 'PFAPELL2'
      DataSource = DSDatos
      TabOrder = 3
    end
    object PFNOMBRE: TUniDBEdit
      Left = 521
      Top = 34
      Width = 157
      Height = 22
      Hint = ''
      DataField = 'PFNOMBRE'
      DataSource = DSDatos
      TabOrder = 4
    end
    object PJURIDIC: TUniDBEdit
      Left = 149
      Top = 58
      Width = 529
      Height = 22
      Hint = ''
      DataField = 'PJURIDIC'
      DataSource = DSDatos
      TabOrder = 5
    end
    object CALLE: TUniDBEdit
      Left = 220
      Top = 82
      Width = 253
      Height = 22
      Hint = ''
      DataField = 'CALLE'
      DataSource = DSDatos
      TabOrder = 7
    end
    object NUMERO: TUniDBEdit
      Left = 479
      Top = 82
      Width = 49
      Height = 22
      Hint = ''
      DataField = 'NUMERO'
      DataSource = DSDatos
      TabOrder = 8
    end
    object ESCALERA: TUniDBEdit
      Left = 537
      Top = 82
      Width = 49
      Height = 22
      Hint = ''
      DataField = 'ESCALERA'
      DataSource = DSDatos
      TabOrder = 9
    end
    object PISO: TUniDBEdit
      Left = 588
      Top = 82
      Width = 39
      Height = 22
      Hint = ''
      DataField = 'PISO'
      DataSource = DSDatos
      TabOrder = 10
    end
    object PUERTA: TUniDBEdit
      Left = 629
      Top = 82
      Width = 49
      Height = 22
      Hint = ''
      DataField = 'PUERTA'
      DataSource = DSDatos
      TabOrder = 14
    end
    object CPOSTAL: TUniDBEdit
      Left = 149
      Top = 108
      Width = 65
      Height = 22
      Hint = ''
      DataField = 'CPOSTAL'
      DataSource = DSDatos
      TabOrder = 11
    end
    object POBLACIO: TUniDBEdit
      Left = 178
      Top = 132
      Width = 106
      Height = 22
      Hint = ''
      DataField = 'POBLACIO'
      DataSource = DSDatos
      TabOrder = 13
    end
    object CPOBLACI: TUniDBEdit
      Left = 149
      Top = 132
      Width = 25
      Height = 22
      Hint = ''
      DataField = 'CPOBLACI'
      DataSource = DSDatos
      CharCase = ecUpperCase
      TabOrder = 12
    end
    object TELEFON1: TUniDBEdit
      Left = 149
      Top = 204
      Width = 132
      Height = 22
      Hint = ''
      DataField = 'TELEFON1'
      DataSource = DSDatos
      TabOrder = 15
    end
    object TELEFON2: TUniDBEdit
      Left = 289
      Top = 204
      Width = 132
      Height = 22
      Hint = ''
      DataField = 'TELEFON2'
      DataSource = DSDatos
      TabOrder = 16
    end
    object FAX: TUniDBEdit
      Left = 149
      Top = 228
      Width = 132
      Height = 22
      Hint = ''
      DataField = 'FAX'
      DataSource = DSDatos
      TabOrder = 17
    end
    object CONTACTO: TUniDBEdit
      Left = 149
      Top = 252
      Width = 529
      Height = 22
      Hint = ''
      DataField = 'CONTACTO'
      DataSource = DSDatos
      TabOrder = 18
    end
    object Label10: TUniLabel
      Left = 21
      Top = 13
      Width = 17
      Height = 13
      Hint = ''
      Caption = 'NIF'
      TabOrder = 19
    end
    object LAPELLIDOS: TUniLabel
      Left = 21
      Top = 38
      Width = 115
      Height = 13
      Hint = ''
      Caption = 'Persona f'#237'sica: Apellidos'
      TabOrder = 20
    end
    object LPFNOMBRE: TUniLabel
      Left = 475
      Top = 38
      Width = 37
      Height = 13
      Hint = ''
      Caption = 'Nombre'
      TabOrder = 21
    end
    object LPJURIDIC: TUniLabel
      Left = 21
      Top = 62
      Width = 76
      Height = 13
      Hint = ''
      Caption = 'Persona jur'#237'dica'
      TabOrder = 22
    end
    object Label1: TUniLabel
      Left = 21
      Top = 86
      Width = 40
      Height = 13
      Hint = ''
      Caption = 'Domicilio'
      TabOrder = 23
    end
    object Label14: TUniLabel
      Left = 21
      Top = 112
      Width = 65
      Height = 13
      Hint = ''
      Caption = 'C'#243'digo postal'
      TabOrder = 24
    end
    object Label15: TUniLabel
      Left = 21
      Top = 136
      Width = 43
      Height = 13
      Hint = ''
      Caption = 'Municipio'
      TabOrder = 25
    end
    object Label16: TUniLabel
      Left = 21
      Top = 160
      Width = 43
      Height = 13
      Hint = ''
      Caption = 'Provincia'
      TabOrder = 26
    end
    object Label23: TUniLabel
      Left = 21
      Top = 184
      Width = 53
      Height = 13
      Hint = ''
      Caption = 'Comunidad'
      TabOrder = 27
    end
    object Label3: TUniLabel
      Left = 21
      Top = 208
      Width = 42
      Height = 13
      Hint = ''
      Caption = 'Tel'#233'fono'
      TabOrder = 28
    end
    object Label8: TUniLabel
      Left = 21
      Top = 232
      Width = 19
      Height = 13
      Hint = ''
      Caption = 'FAX'
      TabOrder = 29
    end
    object Label6: TUniLabel
      Left = 21
      Top = 256
      Width = 101
      Height = 13
      Hint = ''
      Caption = 'Persona de Contacto'
      TabOrder = 30
    end
    object Label7: TUniLabel
      Left = 21
      Top = 280
      Width = 62
      Height = 13
      Hint = ''
      Caption = 'C'#243'digo AEAT'
      TabOrder = 31
    end
    object SIGLA: TUniDBEdit
      Left = 149
      Top = 82
      Width = 41
      Height = 22
      Hint = ''
      ShowHint = True
      ParentShowHint = False
      DataField = 'SIGLA'
      DataSource = DSDatos
      CharCase = ecUpperCase
      TabOrder = 6
    end
    object CPROVINC: TUniDBEdit
      Left = 149
      Top = 156
      Width = 154
      Height = 22
      Hint = ''
      ShowHint = True
      ParentShowHint = False
      DataField = 'CPROVINC'
      DataSource = DSDatos
      TabOrder = 32
      TabStop = False
      Color = clInfoBk
      ReadOnly = True
    end
    object COMUNIDA: TUniDBEdit
      Left = 149
      Top = 180
      Width = 153
      Height = 22
      Hint = ''
      DataField = 'CCOMUNIDA'
      DataSource = DSDatos
      TabOrder = 33
      TabStop = False
      Color = clInfoBk
      ReadOnly = True
    end
    object CADMINIS: TUniDBEdit
      Left = 149
      Top = 276
      Width = 84
      Height = 22
      Hint = ''
      DataField = 'CADMINIS'
      DataSource = DSDatos
      TabOrder = 34
      TabStop = False
      Color = clInfoBk
      ReadOnly = True
    end
    object UBBBuscaCodigoPostal: TUniBitBtn
      Left = 214
      Top = 108
      Width = 24
      Height = 24
      Hint = 'Buscar c'#243'digo postal'
      ShowHint = True
      ParentShowHint = False
      Caption = 'B'
      ParentFont = False
      Font.Height = -16
      Font.Name = 'cai'
      TabStop = False
      TabOrder = 35
      OnClick = UBBBuscaCodigoPostalClick
    end
    object UBBBuscrSigla: TUniBitBtn
      Left = 190
      Top = 82
      Width = 24
      Height = 24
      Hint = 'Buscar sigla'
      Caption = 'B'
      ParentFont = False
      Font.Height = -15
      Font.Name = 'cai'
      TabStop = False
      TabOrder = 36
      OnClick = UBBBuscrSiglaClick
    end
    object UBBBuscaMunicipio: TUniBitBtn
      Left = 284
      Top = 132
      Width = 24
      Height = 24
      Hint = 'Buscar municipio'
      ShowHint = True
      ParentShowHint = False
      Caption = 'B'
      ParentFont = False
      Font.Height = -16
      Font.Name = 'cai'
      TabStop = False
      TabOrder = 37
      OnClick = UBBBuscaMunicipioClick
    end
    object UBBBuscarProvincia: TUniBitBtn
      Left = 303
      Top = 156
      Width = 24
      Height = 24
      Hint = 'Buscar provincia'
      ShowHint = True
      ParentShowHint = False
      Caption = 'B'
      ParentFont = False
      Font.Height = -16
      Font.Name = 'cai'
      TabStop = False
      TabOrder = 38
      OnClick = UBBBuscarProvinciaClick
    end
    object UBBBuscarComunidad: TUniBitBtn
      Left = 302
      Top = 180
      Width = 24
      Height = 24
      Hint = 'Buscar comunidad'
      ShowHint = True
      ParentShowHint = False
      Caption = 'B'
      ParentFont = False
      Font.Height = -16
      Font.Name = 'cai'
      TabStop = False
      TabOrder = 39
      OnClick = UBBBuscarComunidadClick
    end
    object UBBBuscarCodigoAEAT: TUniBitBtn
      Left = 233
      Top = 276
      Width = 24
      Height = 24
      Hint = 'Buscar c'#243'digo AEAT'
      ShowHint = True
      ParentShowHint = False
      Caption = 'B'
      ParentFont = False
      Font.Height = -16
      Font.Name = 'cai'
      TabStop = False
      TabOrder = 40
      OnClick = UBBBuscarCodigoAEATClick
    end
  end
  object ADDatos: TFDQuery
    OnCalcFields = ADDatosCalcFields
    Connection = UniMainModule.ADConexionGeneral
    SQL.Strings = (
      'SELECT * FROM ASESORIA')
    Left = 424
    Top = 176
    object ADDatosNOMBRE: TStringField
      FieldName = 'NOMBRE'
      Origin = 'NOMBRE'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Size = 40
    end
    object ADDatosPFAPELL1: TStringField
      FieldName = 'PFAPELL1'
      Origin = 'PFAPELL1'
      Size = 15
    end
    object ADDatosPFAPELL2: TStringField
      FieldName = 'PFAPELL2'
      Origin = 'PFAPELL2'
      Size = 15
    end
    object ADDatosPFNOMBRE: TStringField
      FieldName = 'PFNOMBRE'
      Origin = 'PFNOMBRE'
      Size = 10
    end
    object ADDatosPJURIDIC: TStringField
      FieldName = 'PJURIDIC'
      Origin = 'PJURIDIC'
      Size = 40
    end
    object ADDatosSIGLA: TStringField
      FieldName = 'SIGLA'
      Origin = 'SIGLA'
      OnChange = ADDatosSIGLAChange
      Size = 2
    end
    object ADDatosCALLE: TStringField
      FieldName = 'CALLE'
      Origin = 'CALLE'
    end
    object ADDatosNUMERO: TStringField
      FieldName = 'NUMERO'
      Origin = 'NUMERO'
      Size = 4
    end
    object ADDatosESCALERA: TStringField
      FieldName = 'ESCALERA'
      Origin = 'ESCALERA'
      Size = 2
    end
    object ADDatosPISO: TStringField
      FieldName = 'PISO'
      Origin = 'PISO'
      Size = 2
    end
    object ADDatosPUERTA: TStringField
      FieldName = 'PUERTA'
      Origin = 'PUERTA'
      Size = 2
    end
    object ADDatosCPOSTAL: TIntegerField
      FieldName = 'CPOSTAL'
      Origin = 'CPOSTAL'
      OnChange = ADDatosCPOSTALChange
    end
    object ADDatosCPOBLACI: TIntegerField
      FieldName = 'CPOBLACI'
      Origin = 'CPOBLACI'
      OnChange = ADDatosCPOBLACIChange
    end
    object ADDatosPOBLACIO: TStringField
      FieldName = 'POBLACIO'
      Origin = 'POBLACIO'
    end
    object ADDatosCPROVINC: TIntegerField
      Alignment = taLeftJustify
      FieldName = 'CPROVINC'
      Origin = 'CPROVINC'
      OnGetText = ADDatosCPROVINCGetText
    end
    object ADDatosCADMINIS: TIntegerField
      FieldName = 'CADMINIS'
      Origin = 'CADMINIS'
    end
    object ADDatosCOMUNIDA: TStringField
      FieldName = 'COMUNIDA'
      Origin = 'COMUNIDA'
      Size = 2
    end
    object ADDatosNIF: TStringField
      FieldName = 'NIF'
      Origin = 'NIF'
      Size = 12
    end
    object ADDatosTELEFON1: TStringField
      FieldName = 'TELEFON1'
      Origin = 'TELEFON1'
    end
    object ADDatosTELEFON2: TStringField
      FieldName = 'TELEFON2'
      Origin = 'TELEFON2'
    end
    object ADDatosFAX: TStringField
      FieldName = 'FAX'
      Origin = 'FAX'
    end
    object ADDatosCONTACTO: TStringField
      FieldName = 'CONTACTO'
      Origin = 'CONTACTO'
      Size = 40
    end
    object ADDatosDIRCONTA: TStringField
      FieldName = 'DIRCONTA'
      Origin = 'DIRCONTA'
      Size = 80
    end
    object ADDatosDIRLABOR: TStringField
      FieldName = 'DIRLABOR'
      Origin = 'DIRLABOR'
      Size = 80
    end
    object ADDatosDIRFISCA: TStringField
      FieldName = 'DIRFISCA'
      Origin = 'DIRFISCA'
      Size = 80
    end
    object ADDatosDIRRENT1: TStringField
      FieldName = 'DIRRENT1'
      Origin = 'DIRRENT1'
      Size = 80
    end
    object ADDatosDIRRENT2: TStringField
      FieldName = 'DIRRENT2'
      Origin = 'DIRRENT2'
      Size = 80
    end
    object ADDatosDIRRENT3: TStringField
      FieldName = 'DIRRENT3'
      Origin = 'DIRRENT3'
      Size = 80
    end
    object ADDatosDIRINTER: TStringField
      FieldName = 'DIRINTER'
      Origin = 'DIRINTER'
      Size = 80
    end
    object ADDatosDIRTEMPO: TStringField
      FieldName = 'DIRTEMPO'
      Origin = 'DIRTEMPO'
      Size = 80
    end
    object ADDatosHOJAS: TStringField
      FieldName = 'HOJAS'
      Origin = 'HOJAS'
      FixedChar = True
      Size = 2
    end
    object ADDatosSEGURIDA: TStringField
      FieldName = 'SEGURIDA'
      Origin = 'SEGURIDA'
      FixedChar = True
      Size = 2
    end
    object ADDatosCOPIAADI: TStringField
      FieldName = 'COPIAADI'
      Origin = 'COPIAADI'
      FixedChar = True
      Size = 2
    end
    object ADDatosREGISTRO: TStringField
      FieldName = 'REGISTRO'
      Origin = 'REGISTRO'
      FixedChar = True
      Size = 2
    end
    object ADDatosPAPELDGR: TStringField
      FieldName = 'PAPELDGR'
      Origin = 'PAPELDGR'
      FixedChar = True
      Size = 2
    end
    object ADDatosRENTUSUA: TStringField
      FieldName = 'RENTUSUA'
      Origin = 'RENTUSUA'
      FixedChar = True
      Size = 2
    end
    object ADDatosSOCIUSUA: TStringField
      FieldName = 'SOCIUSUA'
      Origin = 'SOCIUSUA'
      FixedChar = True
      Size = 2
    end
    object ADDatosFISCUSUA: TStringField
      FieldName = 'FISCUSUA'
      Origin = 'FISCUSUA'
      FixedChar = True
      Size = 2
    end
    object ADDatosBORRAR: TStringField
      FieldName = 'BORRAR'
      Origin = 'BORRAR'
      FixedChar = True
      Size = 2
    end
    object ADDatosSOCIBORR: TStringField
      FieldName = 'SOCIBORR'
      Origin = 'SOCIBORR'
      FixedChar = True
      Size = 2
    end
    object ADDatosVERSION: TStringField
      FieldName = 'VERSION'
      Origin = '"VERSION"'
      Size = 5
    end
    object ADDatosLENGUA: TStringField
      FieldName = 'LENGUA'
      Origin = 'LENGUA'
    end
    object ADDatosMESCOPIA: TIntegerField
      FieldName = 'MESCOPIA'
      Origin = 'MESCOPIA'
    end
    object ADDatosFECCOPIA: TSQLTimeStampField
      FieldName = 'FECCOPIA'
      Origin = 'FECCOPIA'
    end
    object ADDatosUSUARIO_NOMBRE: TStringField
      FieldName = 'USUARIO_NOMBRE'
      Origin = 'USUARIO_NOMBRE'
      Size = 15
    end
    object ADDatosUSUARIO_CONTRASENA: TStringField
      FieldName = 'USUARIO_CONTRASENA'
      Origin = 'USUARIO_CONTRASENA'
      Size = 10
    end
    object ADDatosCCOMUNIDA: TStringField
      FieldKind = fkCalculated
      FieldName = 'CCOMUNIDA'
      Size = 200
      Calculated = True
    end
  end
  object DSDatos: TDataSource
    DataSet = ADDatos
    OnDataChange = DSDatosDataChange
    Left = 424
    Top = 192
  end
end
