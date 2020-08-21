object FrmRegistro: TFrmRegistro
  Left = 0
  Top = 0
  ClientHeight = 412
  ClientWidth = 774
  Caption = 'Registro'
  OnShow = UniFormShow
  BorderStyle = bsDialog
  OldCreateOrder = False
  OnClose = UniFormClose
  OnKeyDown = UniFormKeyDown
  BorderIcons = [biSystemMenu]
  MonitoredKeys.Keys = <>
  OnAjaxEvent = UniFormAjaxEvent
  OnCreate = UniFormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object UniToolBar1: TUniToolBar
    Left = 0
    Top = 0
    Width = 774
    Height = 35
    Hint = ''
    ButtonHeight = 33
    ButtonWidth = 34
    ShowCaptions = True
    TabOrder = 3
    ParentColor = False
    Color = clBtnFace
    ParentFont = False
    Font.Color = 14062137
    Font.Height = -24
    Font.Name = 'cai'
    object UBAceptar: TUniToolButton
      Left = 0
      Top = 0
      Hint = 'Registrar el programa'
      ParentRTL = False
      Enabled = False
      ShowHint = True
      ParentShowHint = False
      Caption = 'V'
      TabOrder = 2
      OnClick = UBAceptarClick
    end
    object UBSalir: TUniToolButton
      Left = 34
      Top = 0
      Hint = 'Salir'
      ShowHint = True
      ParentShowHint = False
      Caption = 's'
      TabOrder = 1
      OnClick = UBSalirClick
    end
  end
  object UBVerContrato: TUniBitBtn
    Left = 737
    Top = 8
    Width = 24
    Height = 24
    Hint = 'Ver contrato'
    Visible = False
    ShowHint = True
    ParentShowHint = False
    Caption = 'B'
    ParentFont = False
    Font.Height = -15
    Font.Name = 'Cai'
    TabOrder = 4
    OnClick = UBVerContratoClick
  end
  object UniGroupBoxDatos: TUniGroupBox
    AlignWithMargins = True
    Left = 0
    Top = 149
    Width = 774
    Height = 203
    Hint = ''
    Margins.Left = 0
    Margins.Top = 0
    Margins.Right = 0
    Margins.Bottom = 0
    Visible = False
    Caption = ''
    Align = alBottom
    ParentColor = False
    TabOrder = 2
    ParentFont = False
    Font.Height = -13
    DesignSize = (
      774
      203)
    object lbNombre: TUniLabel
      Left = 15
      Top = 23
      Width = 45
      Height = 16
      Hint = ''
      Caption = 'Nombre'
      ParentFont = False
      Font.Height = -13
      ParentColor = False
      Color = clBtnFace
      TabOrder = 12
    end
    object lbDomicilio: TUniLabel
      Left = 15
      Top = 55
      Width = 51
      Height = 16
      Hint = ''
      Caption = 'Domicilio'
      ParentFont = False
      Font.Height = -13
      ParentColor = False
      Color = clBtnFace
      TabOrder = 13
    end
    object lbCP: TUniLabel
      Left = 15
      Top = 87
      Width = 77
      Height = 16
      Hint = ''
      Caption = 'C'#243'digo postal'
      ParentFont = False
      Font.Height = -13
      ParentColor = False
      Color = clBtnFace
      TabOrder = 14
    end
    object lbLoc: TUniLabel
      Left = 213
      Top = 87
      Width = 53
      Height = 16
      Hint = ''
      Caption = 'Localidad'
      ParentFont = False
      Font.Height = -13
      ParentColor = False
      Color = clBtnFace
      TabOrder = 15
    end
    object lbpro: TUniLabel
      Left = 514
      Top = 87
      Width = 51
      Height = 16
      Hint = ''
      Caption = 'Provincia'
      ParentFont = False
      Font.Height = -13
      ParentColor = False
      Color = clBtnFace
      TabOrder = 16
    end
    object UniDBEditNombre: TUniDBEdit
      Left = 104
      Top = 23
      Width = 642
      Height = 22
      Hint = ''
      DataField = 'NOMBREMP'
      DataSource = DataSource1
      Anchors = [akLeft, akTop, akRight]
      ParentFont = False
      Font.Height = -13
      TabOrder = 0
    end
    object UniDBEdit3: TUniDBEdit
      Left = 104
      Top = 55
      Width = 337
      Height = 22
      Hint = ''
      DataField = 'DOMICEMP'
      DataSource = DataSource1
      ParentFont = False
      Font.Height = -13
      TabOrder = 1
    end
    object UniDBEdit4: TUniDBEdit
      Left = 104
      Top = 87
      Width = 89
      Height = 22
      Hint = ''
      DataField = 'CPOSTEMP'
      DataSource = DataSource1
      ParentFont = False
      Font.Height = -13
      TabOrder = 3
    end
    object UniDBEditLocalidad: TUniDBEdit
      Left = 280
      Top = 87
      Width = 201
      Height = 22
      Hint = ''
      DataField = 'POBLAEMP'
      DataSource = DataSource1
      ParentFont = False
      Font.Height = -13
      TabOrder = 4
    end
    object UniDBEditProvincia: TUniDBEdit
      Left = 584
      Top = 87
      Width = 141
      Height = 22
      Hint = ''
      DataField = 'CODIGO_PROVINCIA'
      DataSource = DataSource1
      Anchors = [akLeft, akTop, akRight]
      ParentFont = False
      Font.Height = -13
      TabOrder = 5
      ReadOnly = True
    end
    object UniBitBtn1: TUniBitBtn
      Left = 722
      Top = 87
      Width = 24
      Height = 24
      Hint = 'Cambiar provincia'
      ShowHint = True
      ParentShowHint = False
      Caption = 'B'
      Anchors = [akTop, akRight]
      ParentFont = False
      Font.Height = -13
      Font.Name = 'CAI'
      TabOrder = 6
      OnClick = UniBitBtn1Click
    end
    object lbNombre_ast: TUniLabel
      Left = 755
      Top = 26
      Width = 10
      Height = 19
      Hint = ''
      Caption = '*'
      Anchors = [akTop, akRight]
      ParentFont = False
      Font.Color = 14062137
      Font.Height = -16
      Font.Style = [fsBold]
      ParentColor = False
      Color = clBtnFace
      TabOrder = 17
    end
    object lbTel1: TUniLabel
      Left = 15
      Top = 121
      Width = 61
      Height = 16
      Hint = ''
      Caption = 'Tel'#233'fono 1'
      ParentFont = False
      Font.Height = -13
      ParentColor = False
      Color = clBtnFace
      TabOrder = 18
    end
    object UniDBEdittelefono: TUniDBEdit
      Left = 104
      Top = 118
      Width = 121
      Height = 22
      Hint = ''
      DataField = 'TELE1EMP'
      DataSource = DataSource1
      ParentFont = False
      Font.Height = -13
      TabOrder = 7
    end
    object lbtel2: TUniLabel
      Left = 256
      Top = 121
      Width = 61
      Height = 16
      Hint = ''
      Caption = 'Tel'#233'fono 2'
      ParentFont = False
      Font.Height = -13
      ParentColor = False
      Color = clBtnFace
      TabOrder = 19
    end
    object UniDBEdit8: TUniDBEdit
      Left = 336
      Top = 118
      Width = 153
      Height = 22
      Hint = ''
      DataField = 'TELE2EMP'
      DataSource = DataSource1
      ParentFont = False
      Font.Height = -13
      TabOrder = 8
    end
    object lbFax: TUniLabel
      Left = 514
      Top = 121
      Width = 20
      Height = 16
      Hint = ''
      Caption = 'Fax'
      ParentFont = False
      Font.Height = -13
      ParentColor = False
      Color = clBtnFace
      TabOrder = 20
    end
    object UniDBEdit9: TUniDBEdit
      Left = 584
      Top = 118
      Width = 162
      Height = 22
      Hint = ''
      DataField = 'FAXEMP'
      DataSource = DataSource1
      Anchors = [akLeft, akTop, akRight]
      ParentFont = False
      Font.Height = -13
      TabOrder = 9
    end
    object lbPersona: TUniLabel
      Left = 465
      Top = 57
      Width = 98
      Height = 16
      Hint = ''
      Caption = 'Persona contacto'
      ParentFont = False
      Font.Height = -13
      ParentColor = False
      Color = clBtnFace
      TabOrder = 21
    end
    object UniDBEdit10: TUniDBEdit
      Left = 584
      Top = 55
      Width = 162
      Height = 22
      Hint = ''
      DataField = 'PERSOEMP'
      DataSource = DataSource1
      Anchors = [akLeft, akTop, akRight]
      ParentFont = False
      Font.Height = -13
      TabOrder = 2
    end
    object lbTel1_ask: TUniLabel
      Left = 232
      Top = 120
      Width = 10
      Height = 19
      Hint = ''
      Caption = '*'
      ParentFont = False
      Font.Color = 14062137
      Font.Height = -16
      Font.Style = [fsBold]
      ParentColor = False
      Color = clBtnFace
      TabOrder = 22
    end
    object lbIBAN: TUniLabel
      Left = 15
      Top = 148
      Width = 27
      Height = 16
      Hint = ''
      Caption = 'IBAN'
      ParentFont = False
      Font.Height = -13
      ParentColor = False
      Color = clBtnFace
      TabOrder = 23
    end
    object MaskEditIBAN: TUniEdit
      Left = 104
      Top = 146
      Width = 305
      Hint = ''
      Constraints.MaxHeight = 22
      Constraints.MinHeight = 22
      CharCase = ecUpperCase
      MaxLength = 41
      Text = ''
      TabOrder = 10
      InputMask.Mask = 'aa99 9999 9999 9999 9999 9999'
    end
    object UniLabel1: TUniLabel
      Left = 492
      Top = 90
      Width = 10
      Height = 19
      Hint = ''
      Caption = '*'
      Anchors = [akTop, akRight]
      ParentFont = False
      Font.Color = 14062137
      Font.Height = -16
      Font.Style = [fsBold]
      ParentColor = False
      Color = clBtnFace
      TabOrder = 24
    end
    object UniLabel2: TUniLabel
      Left = 421
      Top = 149
      Width = 10
      Height = 19
      Hint = ''
      Caption = '*'
      ParentFont = False
      Font.Color = 14062137
      Font.Height = -16
      Font.Style = [fsBold]
      ParentColor = False
      Color = clBtnFace
      TabOrder = 25
    end
    object UniLabel4: TUniLabel
      Left = 198
      Top = 90
      Width = 10
      Height = 19
      Hint = ''
      Caption = '*'
      ParentFont = False
      Font.Color = 14062137
      Font.Height = -16
      Font.Style = [fsBold]
      ParentColor = False
      Color = clBtnFace
      TabOrder = 26
    end
    object UniDBEditREP_NIF: TUniDBEdit
      Left = 584
      Top = 144
      Width = 162
      Height = 22
      Hint = ''
      DataField = 'REPRESENTANTE_NIF_EMP'
      DataSource = DataSource1
      CharCase = ecUpperCase
      ParentFont = False
      Font.Height = -13
      TabOrder = 27
      OnAjaxEvent = UniDBEditREP_NIFAjaxEvent
    end
    object UniLabel5: TUniLabel
      Left = 755
      Top = 146
      Width = 10
      Height = 19
      Hint = ''
      Caption = '*'
      ParentFont = False
      Font.Color = 14062137
      Font.Height = -16
      Font.Style = [fsBold]
      ParentColor = False
      Color = clBtnFace
      TabOrder = 28
    end
    object UniLabel6: TUniLabel
      Left = 468
      Top = 146
      Width = 103
      Height = 16
      Hint = ''
      Caption = 'NIF representante'
      TabOrder = 29
    end
    object UniLabel7: TUniLabel
      Left = 15
      Top = 176
      Width = 72
      Height = 16
      Hint = ''
      Caption = 'Nombre rep.'
      TabOrder = 30
    end
    object UniDBEditRep_Nombre: TUniDBEdit
      Left = 104
      Top = 175
      Width = 307
      Height = 22
      Hint = ''
      DataField = 'REPRESENTANTE_NOMBRE_EMP'
      DataSource = DataSource1
      ParentFont = False
      Font.Height = -13
      TabOrder = 31
    end
    object UniLabel8: TUniLabel
      Left = 421
      Top = 177
      Width = 10
      Height = 19
      Hint = ''
      Caption = '*'
      ParentFont = False
      Font.Color = 14062137
      Font.Height = -16
      Font.Style = [fsBold]
      ParentColor = False
      Color = clBtnFace
      TabOrder = 32
    end
    object UniLabel9: TUniLabel
      Left = 453
      Top = 174
      Width = 118
      Height = 16
      Hint = ''
      Caption = 'Cargo representante'
      TabOrder = 33
    end
    object UniDBEditRep_cargo: TUniDBEdit
      Left = 584
      Top = 174
      Width = 164
      Height = 22
      Hint = ''
      DataField = 'REPRESENTANTE_CARGO_EMP'
      DataSource = DataSource1
      ParentFont = False
      Font.Height = -13
      TabOrder = 34
    end
    object UniLabel10: TUniLabel
      Left = 754
      Top = 176
      Width = 10
      Height = 19
      Hint = ''
      Caption = '*'
      ParentFont = False
      Font.Color = 14062137
      Font.Height = -16
      Font.Style = [fsBold]
      ParentColor = False
      Color = clBtnFace
      TabOrder = 35
    end
    object UniLabel11: TUniLabel
      Left = 756
      Top = 90
      Width = 10
      Height = 19
      Hint = ''
      Caption = '*'
      Anchors = [akTop, akRight]
      ParentFont = False
      Font.Color = 14062137
      Font.Height = -16
      Font.Style = [fsBold]
      ParentColor = False
      Color = clBtnFace
      TabOrder = 36
    end
    object UniLabel12: TUniLabel
      Left = 449
      Top = 58
      Width = 10
      Height = 19
      Hint = ''
      Caption = '*'
      Anchors = [akTop, akRight]
      ParentFont = False
      Font.Color = 14062137
      Font.Height = -16
      Font.Style = [fsBold]
      ParentColor = False
      Color = clBtnFace
      TabOrder = 37
    end
  end
  object UniGroupBoxNIF: TUniGroupBox
    Left = 0
    Top = 35
    Width = 617
    Height = 114
    Hint = ''
    Caption = ''
    Align = alLeft
    TabOrder = 0
    ParentFont = False
    object lbNIF: TUniLabel
      Left = 15
      Top = 30
      Width = 19
      Height = 16
      Hint = ''
      Caption = 'NIF'
      ParentFont = False
      Font.Height = -13
      ParentColor = False
      Color = clBtnFace
      TabOrder = 1
    end
    object UniDBEditNIF: TUniDBEdit
      Left = 104
      Top = 30
      Width = 89
      Height = 22
      Hint = ''
      DataField = 'CIFEMP'
      DataSource = DataSource1
      ParentFont = False
      Font.Height = -13
      TabOrder = 2
    end
    object lbNif_Ast: TUniLabel
      Left = 208
      Top = 32
      Width = 279
      Height = 14
      Hint = ''
      Caption = '* Teclee su NIF y pulse el bot'#243'n para validarlo'
      ParentFont = False
      Font.Color = 14062137
      Font.Height = -12
      Font.Style = [fsBold]
      ParentColor = False
      Color = clBtnFace
      TabOrder = 3
    end
    object UniBitBtn2: TUniBitBtn
      Left = 502
      Top = 27
      Width = 83
      Height = 25
      Hint = ''
      Caption = 'Validar NIF'
      TabOrder = 4
      OnClick = UniBitBtn2Click
    end
  end
  object UniGroupBoxContenedorLicencia: TUniGroupBox
    Left = 617
    Top = 35
    Width = 157
    Height = 114
    Hint = ''
    Caption = ''
    Align = alClient
    TabOrder = 1
    object rgVersion: TUniRadioGroup
      Left = 2
      Top = 15
      Width = 153
      Height = 97
      Hint = 'Tipo de versi'#243'n '
      Visible = False
      Items.Strings = (
        'Base'
        'Advanced')
      ItemIndex = 1
      Align = alClient
      Caption = 'Versi'#243'n'
      TabOrder = 1
    end
  end
  object UniPanel1: TUniPanel
    Left = 0
    Top = 352
    Width = 774
    Height = 60
    Hint = ''
    Align = alBottom
    TabOrder = 5
    BorderStyle = ubsNone
    Caption = ''
    Color = cl3DLight
    object UniLabel3: TUniLabel
      Left = 17
      Top = 23
      Width = 242
      Height = 14
      Cursor = crHandPoint
      Hint = ''
      Caption = 'T'#233'rminos y condiciones de contrataci'#243'n'
      ParentFont = False
      Font.Color = 14062137
      Font.Height = -12
      Font.Style = [fsBold, fsUnderline]
      ParentColor = False
      Color = clBtnFace
      TabOrder = 1
      OnClick = UniLabel3Click
    end
  end
  object DataSource1: TDataSource
    DataSet = ADQuery1
    Left = 384
    Top = 8
  end
  object ADQuery1: TFDQuery
    BeforeOpen = ADQuery1BeforeOpen
    Connection = ADConnectionFactura
    SQL.Strings = (
      
        'select * from datos_empresa  INNER JOIN USUARIOS ON (USUARIOS.EM' +
        'PRESA=DATOS_EMPRESA.CLAVEEMP) WHERE idusuarios= :IDUSUARIOS')
    Left = 272
    ParamData = <
      item
        Name = 'IDUSUARIOS'
        DataType = ftInteger
        ParamType = ptInput
        Value = -1
      end>
    object ADQuery1CLAVEEMP: TIntegerField
      FieldName = 'CLAVEEMP'
      Origin = 'CLAVEEMP'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object ADQuery1CIFEMP: TStringField
      FieldName = 'CIFEMP'
      Origin = 'CIFEMP'
      OnChange = ADQuery1CIFEMPChange
      OnSetText = ADQuery1CIFEMPSetText
      Size = 14
    end
    object ADQuery1NOMBREMP: TStringField
      FieldName = 'NOMBREMP'
      Origin = 'NOMBREMP'
      Size = 40
    end
    object ADQuery1DOMICEMP: TStringField
      FieldName = 'DOMICEMP'
      Origin = 'DOMICEMP'
      Size = 40
    end
    object ADQuery1CPOSTEMP: TStringField
      FieldName = 'CPOSTEMP'
      Origin = 'CPOSTEMP'
      FixedChar = True
      Size = 5
    end
    object ADQuery1POBLAEMP: TStringField
      FieldName = 'POBLAEMP'
      Origin = 'POBLAEMP'
    end
    object ADQuery1TELE1EMP: TStringField
      FieldName = 'TELE1EMP'
      Origin = 'TELE1EMP'
    end
    object ADQuery1TELE2EMP: TStringField
      FieldName = 'TELE2EMP'
      Origin = 'TELE2EMP'
    end
    object ADQuery1FAXEMP: TStringField
      FieldName = 'FAXEMP'
      Origin = 'FAXEMP'
    end
    object ADQuery1PERSOEMP: TStringField
      FieldName = 'PERSOEMP'
      Origin = 'PERSOEMP'
    end
    object ADQuery1DOMFAEMP: TStringField
      FieldName = 'DOMFAEMP'
      Origin = 'DOMFAEMP'
      Size = 40
    end
    object ADQuery1CPOFAEMP: TStringField
      FieldName = 'CPOFAEMP'
      Origin = 'CPOFAEMP'
      FixedChar = True
      Size = 5
    end
    object ADQuery1POBFAEMP: TStringField
      FieldName = 'POBFAEMP'
      Origin = 'POBFAEMP'
    end
    object ADQuery1BANCOEMP: TStringField
      FieldName = 'BANCOEMP'
      Origin = 'BANCOEMP'
    end
    object ADQuery1TIPOEMP: TStringField
      FieldName = 'TIPOEMP'
      Origin = 'TIPOEMP'
      Size = 1
    end
    object ADQuery1EMAILEMP: TStringField
      FieldName = 'EMAILEMP'
      Origin = 'EMAILEMP'
      Size = 50
    end
    object ADQuery1NOMFAEMP: TStringField
      FieldName = 'NOMFAEMP'
      Origin = 'NOMFAEMP'
      Size = 40
    end
    object ADQuery1FBAJAEMP: TSQLTimeStampField
      FieldName = 'FBAJAEMP'
      Origin = 'FBAJAEMP'
    end
    object ADQuery1NOUSUEMP: TStringField
      FieldName = 'NOUSUEMP'
      Origin = 'NOUSUEMP'
      Size = 15
    end
    object ADQuery1PASSWEMP: TStringField
      FieldName = 'PASSWEMP'
      Origin = 'PASSWEMP'
      Size = 15
    end
    object ADQuery1INTERNO: TIntegerField
      FieldName = 'INTERNO'
      Origin = 'INTERNO'
    end
    object ADQuery1CODIGO_PROVINCIA: TIntegerField
      FieldName = 'CODIGO_PROVINCIA'
      Origin = 'CODIGO_PROVINCIA'
    end
    object ADQuery1CODIGO_PROVINCIA_CORREO: TIntegerField
      FieldName = 'CODIGO_PROVINCIA_CORREO'
      Origin = 'CODIGO_PROVINCIA_CORREO'
    end
    object ADQuery1CONTRASENA_ADMINISTRACION: TStringField
      FieldName = 'CONTRASENA_ADMINISTRACION'
      Origin = 'CONTRASENA_ADMINISTRACION'
      Size = 15
    end
    object ADQuery1EXTENSION: TStringField
      FieldName = 'EXTENSION'
      Origin = 'EXTENSION'
      Size = 3
    end
    object ADQuery1TIPO_FACTURA: TIntegerField
      FieldName = 'TIPO_FACTURA'
      Origin = 'TIPO_FACTURA'
    end
    object ADQuery1CONTRASENA_ZIP: TStringField
      FieldName = 'CONTRASENA_ZIP'
      Origin = 'CONTRASENA_ZIP'
    end
    object ADQuery1EMAIL_GENERAL: TStringField
      FieldName = 'EMAIL_GENERAL'
      Origin = 'EMAIL_GENERAL'
      Size = 50
    end
    object ADQuery1ACTUALIZAR_DESDE_LA_WEB: TStringField
      FieldName = 'ACTUALIZAR_DESDE_LA_WEB'
      Origin = 'ACTUALIZAR_DESDE_LA_WEB'
      FixedChar = True
      Size = 2
    end
    object ADQuery1PESO_PROGRAMAS: TIntegerField
      FieldName = 'PESO_PROGRAMAS'
      Origin = 'PESO_PROGRAMAS'
    end
    object ADQuery1ACTUALIZAR_DESDE_FACTURACION: TStringField
      FieldName = 'ACTUALIZAR_DESDE_FACTURACION'
      Origin = 'ACTUALIZAR_DESDE_FACTURACION'
      FixedChar = True
      Size = 2
    end
    object ADQuery1IDFRUTAS_CAICONTA: TIntegerField
      FieldName = 'IDFRUTAS_CAICONTA'
      Origin = 'IDFRUTAS_CAICONTA'
    end
    object ADQuery1IDFRUTAS_GENERAL: TIntegerField
      FieldName = 'IDFRUTAS_GENERAL'
      Origin = 'IDFRUTAS_GENERAL'
    end
    object ADQuery1IDFURL_CAICONTA: TIntegerField
      FieldName = 'IDFURL_CAICONTA'
      Origin = 'IDFURL_CAICONTA'
    end
    object ADQuery1CLAVE_ACTIVACION: TStringField
      FieldName = 'CLAVE_ACTIVACION'
      Origin = 'CLAVE_ACTIVACION'
      Size = 40
    end
    object ADQuery1IDBASEDEDATOS: TIntegerField
      FieldName = 'IDBASEDEDATOS'
      Origin = 'IDBASEDEDATOS'
    end
    object ADQuery1EXENTO_DE_IVA_EMP: TStringField
      FieldName = 'EXENTO_DE_IVA_EMP'
      Origin = 'EXENTO_DE_IVA_EMP'
      Size = 1
    end
    object ADQuery1IDFRUTAS_CAIFIS: TIntegerField
      FieldName = 'IDFRUTAS_CAIFIS'
      Origin = 'IDFRUTAS_CAIFIS'
    end
    object ADQuery1IDFURL_CAIFIS: TIntegerField
      FieldName = 'IDFURL_CAIFIS'
      Origin = 'IDFURL_CAIFIS'
    end
    object ADQuery1SUBORDINADA: TIntegerField
      FieldName = 'SUBORDINADA'
      Origin = 'SUBORDINADA'
    end
    object ADQuery1IDFRUTAS_CAILAB: TIntegerField
      FieldName = 'IDFRUTAS_CAILAB'
      Origin = 'IDFRUTAS_CAILAB'
    end
    object ADQuery1IDFURL_CAILAB: TIntegerField
      FieldName = 'IDFURL_CAILAB'
      Origin = 'IDFURL_CAILAB'
    end
    object ADQuery1IDFRUTAS_CAIFAC: TIntegerField
      FieldName = 'IDFRUTAS_CAIFAC'
      Origin = 'IDFRUTAS_CAIFAC'
    end
    object ADQuery1IDFURL_CAIFAC: TIntegerField
      FieldName = 'IDFURL_CAIFAC'
      Origin = 'IDFURL_CAIFAC'
    end
    object ADQuery1IDFURL_CAIMAE: TIntegerField
      FieldName = 'IDFURL_CAIMAE'
      Origin = 'IDFURL_CAIMAE'
    end
    object ADQuery1AVISO_IMPORTANTE_EMP: TStringField
      FieldName = 'AVISO_IMPORTANTE_EMP'
      Origin = 'AVISO_IMPORTANTE_EMP'
      Size = 250
    end
    object ADQuery1IDFRUTAS_PORTALSII: TIntegerField
      FieldName = 'IDFRUTAS_PORTALSII'
      Origin = 'IDFRUTAS_PORTALSII'
    end
    object ADQuery1IDFURL_PORTALSII: TIntegerField
      FieldName = 'IDFURL_PORTALSII'
      Origin = 'IDFURL_PORTALSII'
    end
    object ADQuery1PERMISO_CERTIFICADO_CAI: TStringField
      FieldName = 'PERMISO_CERTIFICADO_CAI'
      Origin = 'PERMISO_CERTIFICADO_CAI'
      Size = 1
    end
    object ADQuery1IDFRUTAS_CAISOC: TIntegerField
      FieldName = 'IDFRUTAS_CAISOC'
      Origin = 'IDFRUTAS_CAISOC'
    end
    object ADQuery1IDFURL_CAISOC: TIntegerField
      FieldName = 'IDFURL_CAISOC'
      Origin = 'IDFURL_CAISOC'
    end
    object ADQuery1TELEFONO_3_EMP: TStringField
      FieldName = 'TELEFONO_3_EMP'
      Origin = 'TELEFONO_3_EMP'
    end
    object ADQuery1IBANEMP: TStringField
      FieldName = 'IBANEMP'
      Origin = 'IBANEMP'
      Size = 30
    end
    object ADQuery1OBSEREMP: TMemoField
      FieldName = 'OBSEREMP'
      Origin = 'OBSEREMP'
      BlobType = ftMemo
    end
    object ADQuery1OSOFTEMP: TMemoField
      FieldName = 'OSOFTEMP'
      Origin = 'OSOFTEMP'
      BlobType = ftMemo
    end
    object ADQuery1OHARDEMP: TMemoField
      FieldName = 'OHARDEMP'
      Origin = 'OHARDEMP'
      BlobType = ftMemo
    end
    object ADQuery1REPRESENTANTE_NOMBRE_EMP: TStringField
      FieldName = 'REPRESENTANTE_NOMBRE_EMP'
      Origin = 'REPRESENTANTE_NOMBRE_EMP'
      Size = 100
    end
    object ADQuery1REPRESENTANTE_CARGO_EMP: TStringField
      FieldName = 'REPRESENTANTE_CARGO_EMP'
      Origin = 'REPRESENTANTE_CARGO_EMP'
      Size = 100
    end
    object ADQuery1REPRESENTANTE_NIF_EMP: TStringField
      FieldName = 'REPRESENTANTE_NIF_EMP'
      Origin = 'REPRESENTANTE_NIF_EMP'
    end
    object ADQuery1IDFRUTAS_CAIREN: TIntegerField
      FieldName = 'IDFRUTAS_CAIREN'
      Origin = 'IDFRUTAS_CAIREN'
    end
    object ADQuery1IDFURL_CAIREN: TIntegerField
      FieldName = 'IDFURL_CAIREN'
      Origin = 'IDFURL_CAIREN'
    end
  end
  object ADConnectionFactura: TFDConnection
    Params.Strings = (
      'Database=www.caisistemas.es/3050:c:\cai\factura.gdb'
      'User_Name=SYSDBA'
      'Password=masterkey'
      'DriverID=FBFACTURA')
    Connected = True
    LoginPrompt = False
    Left = 128
  end
  object ADPhysIBDriverLinkFACTURA: TFDPhysFBDriverLink
    DriverID = 'FBFACTURA'
    Left = 328
    Top = 8
  end
  object mensaje: TIdMessage
    AttachmentEncoding = 'UUE'
    BccList = <>
    CCList = <>
    Encoding = meDefault
    FromList = <
      item
      end>
    Recipients = <>
    ReplyTo = <>
    ConvertPreamble = True
    Left = 544
    Top = 8
  end
end
