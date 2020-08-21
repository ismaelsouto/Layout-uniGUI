unit Funciones;

interface

uses Classes,Controls,ppReport, uniDBGrid, uniGUIServerUtils, UniGUiServer, uniLabel, FireDAC.Comp.Client, uniGUIForm, DB, raCodMod, uniGUIDialogs, uniGUIClasses,dbClient,
     Dialogs, uniDBRadioGroup, FireDAC.Stan.Option, uniDBUtils, Windows, UniTreeView, uniGUIAbstractClasses, FireDAC.Comp.DataSet, uniRadioGroup, uniDBEdit, IdSSLOpenSSL,
     clImap4, clMailMessage, ipwhttp, ipshttps, SBEncoding,DSHTTPLayer, SQLConnectionC, FireDAC.Stan.Param, ipscertmgr, SBRDN, SBCustomCertStorage, SBX509, XMLIntf, clSMTP,
     clTcpClientTls, clOAuth, Xc12Utils5, AbUnzper, AbZipper, AbArcTyp, AbZipTyp, AbUtils, AbConst, SQLExpr, WinInet, SOAPHTTPTrans, System.Net.HttpClient, uniDBLookupComboBox;

type
  TVersionnAplicacion=record
                        Version,Build:String;
                       end;
  TFDConnectionHelper = class helper for TFDConnection
    procedure EjecutaSQL(Sentencia:String;Transaccion:TFDTransaction);
  end;
  TArrayCadena=Array Of String;
  TProcedimientOAuth2=reference to procedure(AccesToken,RefreshToken:String;HoraExperacion:TDateTime);
  TProcedimientoH=reference to procedure(Campo:TField);
  TProcedimiento=reference to procedure;
  TDummyClass = Class
      class procedure HTTPRIOHTTPWebNodeBeforePost(const HTTPReqResp: THTTPReqResp; Client:THTTPClient);
  End;
  TUniDBGridH=class(TUniDBGrid)
    public
      function ColumnaActual:Integer;
      procedure SituaColumna(Columna:Integer);
      procedure PonEdicicon;
      procedure CancelaEdicion;
  end;


  TipsHTTPSH=class(TipsHTTPS)
    public
      Headers:TStringList;
      Resultado:String;
      class procedure ipsHTTPSTransfer(Sender: TObject; Direction: Integer;
        BytesTransferred: Int64; PercentDone: Integer; Text: string);
      class procedure ipsHTTPSHeader(Sender: TObject; const Field,
        Value: string);
  end;

  TipwHTTPH=class(TipwHTTP)
    public
      Resultado:String;
      class procedure ipwHTTPTransfer(Sender: TObject; Direction: Integer;
        BytesTransferred: Int64; PercentDone: Integer; Text: string);
      class procedure ipsHTTPSHeader(Sender: TObject; const Field,
        Value: string);
    private
  end;


  THiloEjecucion = class(TThread)
  public
    Constructor Create(Procedimiento:TProcedimiento;CreateSuspended:Boolean);
  private
    { Private declarations }
    HProcedimiento:TProcedimiento;
  protected
    procedure Execute; override;
  end;

  TPaginaPDF=Record
               Pagina:TMemoryStream;
               Cuenta:Integer;
               Ocurrencia:Integer;
             end;
  PPaginaPDF=^TPaginaPDF;

procedure UniDBLookUpComboBoxGetKeyValue(UCB:TUniDBLookupComboBox;const Value: string; var KeyValue: Variant);
procedure UniDBLookUpComboBoxRemoteQuery(UCB:TUniDBLookupComboBox;const QueryString: string; Result: TStrings);
function LookUpDataSet(DS:TFDDataSet;KeyField,ResultField:String;KeyValue:Variant):Variant;
function EjecutaComando(Directorio,Comando:String):DWord;
function capitalize(s: string): string;
function SiglasCalle(paSiglas: string):string;
function DescargaFicheroHTTPS(Usuario,Contrasena,FicheroLocal,FicheroRemoto:String):Boolean;
function LimpiarAcentos(const cadena: string) : string;
function CampoPK(DS:TFDDataset):String;
function Version(const AFileName: string): TVersionnAplicacion;
function PasaTabla(ConexionOrigen,ConexionDestino:TFDConnection;Tabla:String;CamposCambio,CamposValores,CamposDestino,ValoresDestino,CamposAEvitar:Array of String;DS:array of TFDDataSet;Filtro:String='';CampoIDError:String='';EvitarCampos:boolean=true;Tabla2:string=''):String;
procedure HTMLaPDF(RutaHTML,RutaPDF:String;IncrustarTrueType:boolean=True);
procedure FicheroAnsiAutf8(Fichero:String);
function SumaCampo(DS:TFDDataSet;Campo:String;Filtro:String=''):Currency;
function NombrePais(Clave:String):String;
function CSSVersion6:String;
function ConexionAD(Ruta:String;Usuario:String='SYSDBA';password:String='masterkey';Owner:TComponent=nil;NombreDriver:String='FB'):TFDConnection;
function FirebirdFloat(Valor:Real; ForzarSigno:Boolean = False):String;
function  PAD(pcampo: string; pcuanto: integer; pcon: string; pdonde: string): string;
function ObtenNIF(Entrada:String):String;
procedure EncriptarFichero(FicheroEntrada,FicheroSalida,Clave:String);
function HashSHA256(RutaFichero:String):String;
function FieldValueToFloat(F:TField):real;
function GetCertDisplayName(Cert : TelX509Certificate) : string;
function GetOIDValue(NTS: TElRelativeDistinguishedName; const S: RawByteString; const Delimeter: AnsiString = ' / '): AnsiString;
procedure CertificadoNombreNIF(Certificado,Clave:string; var sFIRNIF : string; var sFIRNOMBRE: string; var Organizacion: Boolean);
procedure AsignarParametros(Destino,Origen:TFDParams);
procedure AsignarMacros(Destino,Origen:TFDMacros);
function VaciaSeccion(HTML,Seccion:String):String;
function NombreProvincia(Codigo:Integer):String;
function EnlazadoConCAIMAE(IDUsuario:Integer;Programa:String):Boolean;
procedure FusionarPDF(Conexion:TFDConnection;IDsListadoPersonalizado:array of Integer;Modelo,RutaPlantilla,RutaPDF:String;Anagrama:String='';Ejercicio:String='';NIF:String='');
function ContenidoEtiquetaHTML(HTML,Etiqueta:String;var ok:Boolean):String;
function CadenaFicheroPDF(RutaFichero:string):String;
function HazPost(URL:String;
                 Parametros:Array Of String;
                 PFX:String='';DescripcionCertificado:String='';Contrasenha:String='';HacerGet:Boolean=False):String;
function EnviarCorreo(Servidor,Usuario,Contrasena,Remitente,Destinatario,Asunto,Cuerpo:String;Adjuntos:array of String;Firma:String='';ImagenCabecera:String='';Puerto:Integer=25;UsaTLS:TclClientTlsMode=ctNone;ClienteID:String='';Secreto:String='';Autorizacion:String='';RefrescoAutorizacion:String='';URLRedireccion:String='';ProcedimientOAuth2:TProcedimientOAuth2=nil):Boolean;
function SubirCorreoIMAP(Host,Usuario,Contrasena,Buzon,Remitente,Destinatario,Asunto,Cuerpo:String;Adjuntos:array of String;Firma:String='';ImagenCabecera:String='';Puerto:Integer=143;UsaTLS:TclClientTlsMode=ctNone;ClienteID:String='';Secreto:String='';Autorizacion:String='';RefrescoAutorizacion:String='';URLRedireccion:String='';ProcedimientOAuth2:TProcedimientOAuth2=nil):Boolean;
function AplicarInserts(DS:TFDQuery;Tabla:String):Boolean;
function NumeroRegistrosDataSet(DataSet:TFDQuery;Filtro:String):Integer;
procedure OcultaColumna(Grid:TUniDBGrid;Campo:TField);
procedure Notification(pTitle, pMessage:String);
function ListaCampo(DS:TFDDataSet;Campo:String):String;
function Download(Direccion,Fichero: string):Boolean;
function FechaEntreFechas(Fecha:TDateTime;FechaInicio:TDateTime;FechaFin:TDateTime): boolean;
{$IFNDEF SIN_GENERAL}
procedure CambioCP(EditCP:TUniCustomDBEdit;CP,Provincia,CodigoMunicipio,Municipio:TField;EditCodigoMunicipio:TUniCustomDBEdit=nil;EditMunicipio:TUniCustomDBEdit=nil);
procedure CambioCodigoMunicipio(EditCodigoMunicipio:TUniCustomDBEdit;Provincia,CodigoMunicipio,Municipio:TField;EditMunicipio:TUniCustomDBEdit=nil);
{$ENDIF}
function ValidaNIF(PAIS,NIF:String;Edit:TUniCustomDBEdit):Boolean;
function ValidaCampo(Edit:TUniCustomDBEdit;Consulta:TDataSet;Mensaje:String):Boolean;
procedure HabilitaControl(Control:TUniFormControl;Habilita:Boolean);
procedure EstiloBoton(UL:TUniLabel;URL,Target,Caption,Hint,Fuente:String);
function GetIP(const HostName: string): string;
procedure DameNombreCompleto(ppais, pnif, Entrada: string; var nombre,
  apellido1, apellido2, razon: string);
function LimpiarCaracteresDeNumero(Numero:String):String;
function CampoAnagrama(CampoNIF,CampoApellido:String;NombreCampo:String=''):String;
function CalculateDigits(iban: string): Integer;
function IBANCheck(iban: string): Boolean;
function TipoDeEmpresa(NIF:string):string;
procedure ActualizaDSGrid(Grid:TUniDBGrid);
function EsNumero(Cuenta:String):boolean;
procedure ExportarUnaTabla3(paTabla: TDataSet; paLibro: string; nombrefichero :string='';enviar:boolean=True; VersionExcel : TexcelVersion = TexcelVersion.xvExcel97; EnviarNombre:string =''; LibroNuevo:boolean=False; SobreEscribirFichero:boolean=True; SoloExportarTag0:boolean=False);
function Euros(paValor: Currency): Currency;
function EurosRound(const Value: Currency): Currency;
procedure BorraFicheros(Mascara: String);
function EjecutaSQL(Conexion:TFDConnection;Sentencia:String;Transaccion:TFDTransaction=nil;Parametros:TFDParams=nil;ListaMacros:TFDMacros=nil):Integer;
function EjecutaSQLEscalar(Conexion:TFDConnection;Sentencia:String;Transaccion:TFDTransaction=nil;Parametros:TFDParams=nil;ListaMacros:TFDMacros=nil):Integer;
function ConsultaAD(Conexion:TFDConnection;Consulta:String;Unidireccional:Boolean=True;Abrir:Boolean=True;Transaccion:TFDTransaction=nil;AOwner:TComponent=nil;Parametros:TFDParams=nil;ListaMacros:TFDMacros=nil):TFDQuery;
function ExportaAPDF(Informe:TppReport;RutaPDF:String;HacerZip:boolean=False;passwordzip:string='';nombrezip:string='';FicheroPDFDestino:String=''):String;
procedure GeneraListado(ServerModule:TUniGUIServerModule;
                        Grid:TUniDBGrid;Titulo:String;
                        Acumulados:array of String;
                        TextoEsquinaSuperiorIzquierda:String='';
                        Apaisado:Boolean=False;
                        MargenIzquierdo:real=6.35;MargenDerecho:real=6.35;Fuente:String='Arial';
                        TamanoTitulo:Integer=12;
                        TamanoCabeceraColumnas:Integer=8;
                        TamanoDetalle:Integer=8);
procedure DescargarArchivo(Servidor,Usuario,Contrasena,Ruta:String);
procedure DescargarArchivoFTP(Servidor,Usuario,Contrasena,Ruta1,Ruta2:String);
procedure DesactivarControles(Control:TComponent;Desactivar:Boolean=True;OmitirValorDeTabStop:boolean=False;ponerAspaAdbLookupComboBox:boolean=False);
function ActivarFormulario(FormClass:TUniFormClass):boolean;
function BuscarFormulario(FormClass:TUniFormClass):TUniForm;
function PersonaFisica(Pais: string; NIF: string): boolean;
function DirectorioTemporal: string;
function CalcCifnif(paIcif: string; paCif: string; paMensaje: boolean; CallBack:TUniDialogCallBackProc=nil): string;
function LetraONumeroDeUnCifNif(paCif: String): string;
function LetraDeUnNif(paDni: String): string;
procedure ObtieneServidorRuta(RutaBD:String;var Host,Ruta:String);
{$IFNDEF WEBBD}
function emailValido(const Value: String;Tipo:integer): boolean;
{$ENDIF}
function GeneraClave(Codigo: integer): string;
function Encriptar(Cadena,Clave:String):String;
function Desencriptar(Cadena,Clave:String):String;
procedure SiguienteLibre(Grid:TUniDBGridH;Append:Boolean=True);
function IndiceCampo(Grid:TUniDBGrid;Campo:TField):integer;
function  DosDecimales(Valor:extended): currency;

function ClientDataSet(Conexion:TFDConnection;Consulta:string;CDS:TFDQuery=nil):TFDQuery;
function ClientDataset2(Conexion:TFDConnection;Consulta:String;CDS:TClientDataset=nil;Owner:TComponent=nil;NingunoSoloLectura:Boolean=False):TCLientDataset;
{$IFNDEF SIN_GENERAL}
function PaisesIntraComunitarios:string;
{$ENDIF}
function CDSRemoto(URL,NombreProveedor,Consulta:String;Owner:TComponent=nil):TClientDataset;
procedure ModificaBDRemota(Servidor:string;RutaBD:string;Consulta:String);
procedure MessageDlg(const Msg:String;DlgType:TMsgDlgType; Buttons:TMsgDlgButtons;Callback:TUniDialogCallBackAnonProc=nil;Titulo:String='Confirmar');
procedure AsignaCambioDBEdit(Control:TUniControl);
function LanzaCambio(Sender: TComponent;EventName: string; Params: TStrings;Mensaje:String=''):boolean;
function TextoAReal(Texto:String):real;
function SQLsobreClientDataSets( Tablas : array of TDataSet; sSQL : String) : TFDQuery;
function SHA1(const AString: string): string;
procedure ComprimirCarpeta(Carpeta,NombreArchivo,Contrasenha:String;Mover:Boolean=True;Destino:String='*');
procedure DescomprimirCarpeta(Carpeta,NombreArchivo,Contrasenha:String);
function DescomprimirContrasenaValida(NombreArchivo,Contrasenha:String): Boolean;
function GeneraADQuery(query:TDataset;Conexion:TFDConnection;Tabla:string;Evitar:String='';Campos:String='';Valores:String=''):TFDQuery;
procedure IniciaParametrosAD(DSOrigen:TDataset;QueryDestino:TFDQuery;Indice:Integer=0;ParametrosAInicializar:String='';ValoresIniciales:String='');
function DameCadenaSql(query : TDataset; tabla,id : string; vid : integer;
        evitar : string = ''; scambiar : string = ''; vcambio : integer = 0) : string;
function DameCamposParaInsert(query : TDataset;evitar : string = '') : string;
function DameValoresParaInsert(query : TDataset; tabla,id : string; vid : integer;
        evitar : string = ''; scambiar : string = ''; vcambio : integer = 0) : string;
procedure CopiaCarpeta(Origen,Destino:String;Mover:Boolean=False);
function NumeroRegistros(Query:TFDQuery;MacrosNulas:String=''): Integer;
procedure MonitorizarTeclas(F:TUniForm;a:Array Of Integer;HB:Boolean);Overload;
procedure MonitorizarTeclas(F:TUniForm;a:Array Of Char;HB:Boolean);Overload;
procedure MonitorizarTeclas(Control:TUniControl;a:Array Of Integer;HB:Boolean);Overload
function IndiceNodo(Nodo:TUniTreeNode;Arbol:TUniTreeView):Integer;
procedure CambiaBlancoPorCero(Control:TUniControl);
function ValorTablaLookUp(Tabla:TFDDataSet;CampoLookUp,CampoResultado:String;Valor:Variant):Variant;
procedure InicializaRadioGroup(RG:TUniRadioGroup;Valor:String;a:Array of String);
function ActualizaCampoRadioGroup(RG:TUniRadioGroup;Campo:TField;a:Array of String):boolean;
function ADCodigosSEPA:TFDMemTable;
{$IFNDEF SIN_GENERAL}
function PaisIntracomunitario(Conexion:TFDConnection;Pais:string):Boolean;
{$ENDIF}
function Borrarcarpeta(Carpeta:String;BorrarRaiz:boolean=True):Boolean;
function ListadoPersonalizado(Conexion:TFDConnection;ID:Integer;UniDireccional:Boolean=True):TFDQuery;
function DameSentenciaDeListadoPersonalizado(ID:Integer):string;
function CAIInListInt(Valor: Integer; ValoresPosibles: array of Integer): boolean;
function CAIInListStr(Valor: string; ValoresPosibles: array of string; TextoParecido : Boolean = False): boolean;
{$IFNDEF SIN_GENERAL}
function CambioPais(Edit:TUniDBEdit):Boolean;
{$ENDIF}
function Iguales(a,b:real;tolerancia:real=0.001):boolean;
procedure VideoYouTube(ID:String;AutoPlay:Integer=1;Titulo:String='Vídeo de ayuda');
procedure AbrirURL(URL:String;Titulo:String='';CallBack:TUniDialogCallBackAnonProc=nil);
procedure LogAccesoOpciones(Usuario:string;CodOpcion:Integer;Aplicacion:String);
procedure EjecutaProceso(Procedimiento:TProcedimiento);
function GeneraInsert(COnexion:TFDConnection;Tabla:String):String;
function GeneraUpdate(COnexion:TFDConnection;Tabla,Filtro:String;CamposAEvitar:String=''):String;
procedure IgualaParametros(ConsultaParametrizada,Consulta:TFDQuery;LiberaConsulta:Boolean=False);
procedure IniciaParametros(Consulta:TFDQuery;Tabla:String);
procedure IniciaParametros2(Consulta:TFDQuery;Tabla:String;Parametros,Campos:Array of String);
procedure PoneNuloParametros(Consulta:TFDQuery);
function ClavePrimaria(Consulta:TFDDataSet):String;
procedure UnirPDFs(Fichero1,Fichero2:String;PonPaginaBlancoSiImpares:Boolean=False);
function CDSRest(Host,Ruta,rutacliente,Sentencia:String;ejecutar:boolean=false;Owner:TComponent=nil;Servidor:String='portalcai.es';Puerto:Integer=443;URLPath:String='/webservices/restserver.dll'):TClientDataset;
function CDSRestFacturaGDB(Sentencia:String;Owner:TComponent=nil):TClientDataset;
procedure ModificaFacturaGDB(Sentencia:String);

function Fecha_USA(pfecha : TDateTime) : string;
procedure LiberarComponente(Control:TUniControl);
function Conexion(Ruta:String):TSQLConnectionC;
function ClientDataSet3(Conexion:TSQLConnectionC;Consulta:PChar;CDS:TClientDataset=nil;Owner:TComponent=nil):TCLientDataset;
function NumeroPaginas(FicheroPDF:String):Integer;
function NodoXML(Raiz:IXMLNode;Nombres:array of String):IXMLNode;
function ValorNodoXML(Raiz:IXMLNode;Nombres:array of String):String;
function Trozo(Cadena:String;Delimitadores:String;Numero:Integer):String;
function ReplaceInvalidFileNameChars(const aFileName: string; const aReplaceWith: Char = '_'): string;
function SoloNumeros(paCantidad: string; paDevolverCero: boolean = True): string;
function SoloLetrasoNumeros(paTexto: string): string;
function DevolverNoCero(Valor1,Valor2:Double):Double;
function ValidaLOGINYPASSWORD(LOGIN,CONTRASENA:string;ValidarUsuario:Boolean=True):boolean;
procedure CompruebaDocumentos(programa,parametro: string;idusuario:integer;redirigir:string);
procedure LanzaFirma(FNumeroDeLicencia,parametro:string;redirigir:string);
procedure RGPD(programa:string;MiUsuario:integer; Miconexion:TFDConnection;redirigir:string);


implementation

uses
  ppTypes, ppPrnabl,  ppDBPipe, ppVar, ppMemo, ClipBrd,
  ppCtrls, Printers, StrUtils, SysUtils, Forms, Graphics, Math,
  {$IFNDEF SINCRONIZAR}
  Frm_VisorPDF,Frm_ControlGenerico,uServicioWeb,MainModule,ServerModule,Frm_OAuth2,
  {$ENDIF}
  uniGUIApplication, IDFtp,
  uniBitBtn, uniButton, uniComboBox, uniDBComboBox,
  uniCheckBox, uniDBCheckBox, uniDBDateTimePicker, uniPanel, uniPageControl, uniGroupBox,
  uniToolBar, Variants, JVCipher, UniGuiTypes,
  uniGUIFrame, SoapConn, FireDAC.Stan.Intf,
  IdHashSHA, WebPost, Provider, uniDBMemo, uniEdit, uniDateTimePicker, uniMemo, WinSock,
  DateUtils, idHTTP, IdSSLOpenSSLHeaders, DBXCommon, DBXDataSnap, DSConnect, IDMessage, IdSMTP, IdText, IdAttachmentFile, JclAnsiStrings, DebenuPDFLibrary1612,DBXFirebird, SBUtils, SBConstants,
  XLSReadWriteII5, XLSDbRead5, IDGlobal, EncdDecd{, AESObj, MiscObj}, IOUtils, IdFTPCommon,
  IdAllFTPListParsers, WideStrUtils, gtHtmlViewIntf, gtPDFEng, gtCstDocEng, gtCstPDFEng, FireDAC.Phys.FBDef, FireDAC.Phys.FB, IdCoderMIME, FireDAC.Phys.SQLiteVDataSet,RegularExpressions,
  Frm_Firma_contratos, Frm_Exportar_datos;

procedure UniDBLookUpComboBoxGetKeyValue(UCB:TUniDBLookupComboBox;const Value: string; var KeyValue: Variant);
begin
  if UCB.DataSource.State in dsEditModes then
    with TFDMemTable.Create(nil) do
      try
        CloneCursor(TFDMemTable(UCB.ListSource.DataSet));
        if (Length(Value)<=UCB.ListSource.DataSet.FieldByname(UCB.ListField).Size) and (Locate(UCB.ListField,VarArrayOf([Value]),[loCaseInsensitive])) then
          KeyValue:=FieldByName(UCB.KeyField).Value
        else
          UniSession.AddJS('ajaxRequest('+UCB.JSName+',''LIMPIA'',[]);');
      finally
        Free;
      end;
end;

procedure UniDBLookUpComboBoxRemoteQuery(UCB:TUniDBLookupComboBox;const QueryString: string; Result: TStrings);
begin
  with TFDMemTable.Create(nil) do
    try
      CloneCursor(TFDMemTable(UCB.ListSource.DataSet));
      Filtered:=True;
      Filter:='UPPER('+UCB.ListField+') LIKE '''+UpperCase(QueryString)+'%''';
      First;
      while not eof do
      begin
        Result.Add(FieldByName(UCB.ListField).AsString);
        Next;
      end;
    finally
      Free;
    end;
end;

function LookUpDataSet(DS:TFDDataSet;KeyField,ResultField:String;KeyValue:Variant):Variant;
begin
  Result:='';
  with TFDMemTable.Create(nil) do
    try
      CloneCursor(DS);
      if Locate(KeyField,VarArrayOf([KeyValue]),[]) then
        Result:=FieldByName(ResultField).Value;
    finally
      Free;
    end;
end;

function SiglasCalle(paSiglas: string): string;
begin
  Result:=IfThen(paSiglas='AA','ACERA',
          IfThen(paSiglas='AB','ARB',
          IfThen(paSiglas='AC','ACCE',
          IfThen(paSiglas='AD','ALDEA',
          IfThen(paSiglas='AE','ACEQ',
          IfThen(paSiglas='AG','ANGTA',
          IfThen(paSiglas='AI','AUTOV',
          IfThen(paSiglas='AJ','ATAJO',
          IfThen(paSiglas='AL','ALAM',
          IfThen(paSiglas='AN','ANDAD',
          IfThen(paSiglas='AO','APDRO',
          IfThen(paSiglas='AP','APTOS',
          IfThen(paSiglas='AR','ARRAL',
          IfThen(paSiglas='AT','ALTO',
          IfThen(paSiglas='AU','AUTO',
          IfThen(paSiglas='AV','AVDA',
          IfThen(paSiglas='AY','ARRY',
          IfThen(paSiglas='BA','BARDA',
          IfThen(paSiglas='BD','BRDLA',
          IfThen(paSiglas='BE','BELNA',
          IfThen(paSiglas='BJ','BJADA',
          IfThen(paSiglas='BL','BLQUE',
          IfThen(paSiglas='BN','BALNR',
          IfThen(paSiglas='BO','BARRO',
          IfThen(paSiglas='BQ','BQLLO',
          IfThen(paSiglas='BR','BRANC',
          IfThen(paSiglas='BV','BULEV',
          IfThen(paSiglas='BZ','BRZAL',
          IfThen(paSiglas='CA','CANAL',
          IfThen(paSiglas='CB','CBTIZ',
          IfThen(paSiglas='CC','CRCRO',
          IfThen(paSiglas='CÇ','CZADS',
          IfThen(paSiglas='CD','CUADR',
          IfThen(paSiglas='CH','CHLET',
          IfThen(paSiglas='CI','CINT',
          IfThen(paSiglas='CJ','CLLJA',
          IfThen(paSiglas='CK','CLLON',
          IfThen(paSiglas='CL','CALLE',
          IfThen(paSiglas='CM','CMNO',
          IfThen(paSiglas='CÑ','CÑADA',
          IfThen(paSiglas='CO','COL',
          IfThen(paSiglas='CP','CAMPO',
          IfThen(paSiglas='CQ','CANTO',
          IfThen(paSiglas='CR','CTRA',
          IfThen(paSiglas='CS','CASA',
          IfThen(paSiglas='CT','CUSTA',
          IfThen(paSiglas='CU','CJLA',
          IfThen(paSiglas='CV','CIRCU',
          IfThen(paSiglas='CW','CNVTO',
          IfThen(paSiglas='CX','CXON',
          IfThen(paSiglas='CY','CLEYA',
          IfThen(paSiglas='CZ','CZADA',
          IfThen(paSiglas='DH','DHSA',
          IfThen(paSiglas='DM','DEMAR',
          IfThen(paSiglas='EC','ESCA',
          IfThen(paSiglas='EG','ESPIG',
          IfThen(paSiglas='EI','EIRAD',
          IfThen(paSiglas='EM','EXTRM',
          IfThen(paSiglas='EN','ESTCN',
          IfThen(paSiglas='EP','ENTD',
          IfThen(paSiglas='ET','EXTRR',
          IfThen(paSiglas='EW','ESCAL',
          IfThen(paSiglas='FC','FBRCA',
          IfThen(paSiglas='FD','FALDA',
          IfThen(paSiglas='FN','FINCA',
          IfThen(paSiglas='GA','GALE',
          IfThen(paSiglas='GJ','GRANJ',
          IfThen(paSiglas='GL','GTA',
          IfThen(paSiglas='GR','GRUPO',
          IfThen(paSiglas='GV','G.V.',
          IfThen(paSiglas='GZ','GLLZO',
          IfThen(paSiglas='HY','HOYA',
          IfThen(paSiglas='JR','JDIN',
          IfThen(paSiglas='KA','CRA',
          IfThen(paSiglas='KD','CRRDO',
          IfThen(paSiglas='KL','CRRIL',
          IfThen(paSiglas='KO','COSTA',
          IfThen(paSiglas='KP','COOP',
          IfThen(paSiglas='KR','COSTE',
          IfThen(paSiglas='KS','CSTAN',
          IfThen(paSiglas='KT','CRTJO',
          IfThen(paSiglas='KY','CLYON',
          IfThen(paSiglas='KZ','CLLZO',
          IfThen(paSiglas='LA','LAGO',
          IfThen(paSiglas='LD','LDERA',
          IfThen(paSiglas='LG','LUGAR',
          IfThen(paSiglas='LL','LLNRA',
          IfThen(paSiglas='LM','LOMA',
          IfThen(paSiglas='LO','LOMO',
          IfThen(paSiglas='MA','MALEC',
          IfThen(paSiglas='MC','MERC',
          IfThen(paSiglas='MD','MIRAD',
          IfThen(paSiglas='ML','MUELL',
          IfThen(paSiglas='MS','MASIA',
          IfThen(paSiglas='MT','MONTE',
          IfThen(paSiglas='MZ','MAZO',
          IfThen(paSiglas='ND','NUDO',
          IfThen(paSiglas='NV','NAVE',
          IfThen(paSiglas='PA','PAS',
          IfThen(paSiglas='PB','PBDO',
          IfThen(paSiglas='PC','PALAC',
          IfThen(paSiglas='PD','PTDA',
          IfThen(paSiglas='PE','PRAJE',
          IfThen(paSiglas='PF','PARTI',
          IfThen(paSiglas='PG','POLIG',
          IfThen(paSiglas='PH','PRTAL',
          IfThen(paSiglas='PI','PISTA',
          IfThen(paSiglas='PJ','PSAJE',
          IfThen(paSiglas='PK','PATIO',
          IfThen(paSiglas='PL','PLZLA',
          IfThen(paSiglas='PN','PINAR',
          IfThen(paSiglas='PO','PTO',
          IfThen(paSiglas='PP','PAGO',
          IfThen(paSiglas='PQ','PQUE',
          IfThen(paSiglas='PR','PROL',
          IfThen(paSiglas='PS','PASEO',
          IfThen(paSiglas='PT','PNTE',
          IfThen(paSiglas='PU','PTA',
          IfThen(paSiglas='PX','PLLOP',
          IfThen(paSiglas='PY','PLAYA',
          IfThen(paSiglas='PZ','PLAZA',
          IfThen(paSiglas='QA','CANTR',
          IfThen(paSiglas='QD','CARRA',
          IfThen(paSiglas='QE','CTRIN',
          IfThen(paSiglas='QI','CRTIL',
          IfThen(paSiglas='QJ','COMPJ',
          IfThen(paSiglas='QL','CRRAL',
          IfThen(paSiglas='QO','CRRLO',
          IfThen(paSiglas='QR','CRO',
          IfThen(paSiglas='QT','CANTI',
          IfThen(paSiglas='QV','CUEVA',
          IfThen(paSiglas='RB','RBLA',
          IfThen(paSiglas='RC','RCON',
          IfThen(paSiglas='RD','RONDA',
          IfThen(paSiglas='RI','RBRA',
          IfThen(paSiglas='RL','CRLLO',
          IfThen(paSiglas='RM','RAMAL',
          IfThen(paSiglas='RN','RCDA',
          IfThen(paSiglas='RO','RTDA',
          IfThen(paSiglas='RP','RAMPA',
          IfThen(paSiglas='RR','CRROL',
          IfThen(paSiglas='RS','RESID',
          IfThen(paSiglas='RU','RUA',
          IfThen(paSiglas='SB','SBIDA',
          IfThen(paSiglas='SC','SECT',
          IfThen(paSiglas='SD','SENDA',
          IfThen(paSiglas='SN','SEND',
          IfThen(paSiglas='SR','SEDRA',
          IfThen(paSiglas='ST','SANTU',
          IfThen(paSiglas='TA','TRAS',
          IfThen(paSiglas='TO','TRRNT',
          IfThen(paSiglas='TR','TRVA',
          IfThen(paSiglas='TS','TRANS',
          IfThen(paSiglas='TV','TRVAL',
          IfThen(paSiglas='UN','NCLEO',
          IfThen(paSiglas='UR','URB',
          IfThen(paSiglas='V ','VILLA',
          IfThen(paSiglas='VA','VALLE',
          IfThen(paSiglas='VC','VECIN',
          IfThen(paSiglas='VD','VCTO',
          IfThen(paSiglas='VG','VEGA',
          IfThen(paSiglas='VI','VIA',
          IfThen(paSiglas='VL','VIAL',
          IfThen(paSiglas='VR','VREDA',
          IfThen(paSiglas='VV','VVDAS',
          IfThen(paSiglas='ZO','ZONA',
          paSiglas))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))));
end;

procedure CompruebaDocumentos(programa,parametro: string;idusuario:integer;redirigir:string);
var
  Consulta,FNumeroDeLicencia: string;
  Continuar,administrador: boolean;
begin
  Continuar:=true;

  if programa='PORTALSII' then
  begin
    consulta:='SELECT FECHA_CONTRATO,FECHA_DEMO,TIPO_LICENCIA,LICENCIA FROM USUARIOS_PORTALSII INNER JOIN LICENCIAS_PROGRAMAS_WEB ON (CLAVEEMP=EMPRESA) WHERE PROGRAMA='''+uppercase(programa)+''' AND IDUSUARIOS_PORTALSII='+IntToStr(IDUsuario)
  end
  else begin
    if programa='PORTALEMP' then
      consulta:='SELECT FECHA_CONTRATO,FECHA_DEMO,TIPO_LICENCIA,LICENCIA FROM USUARIOS_PORTALEMP INNER JOIN LICENCIAS_PROGRAMAS_WEB ON (CLAVEEMP=EMPRESA) WHERE PROGRAMA='''+uppercase(programa)+''' AND IDUSUARIOS_PORTALEMP='+IntToStr(IDUsuario)
    else
      consulta:='SELECT FECHA_CONTRATO,FECHA_DEMO,TIPO_LICENCIA,LICENCIA FROM USUARIOS INNER JOIN LICENCIAS_PROGRAMAS_WEB ON (CLAVEEMP=EMPRESA) WHERE PROGRAMA='''+uppercase(programa)+''' AND IDUSUARIOS='+IntToStr(IDUsuario);
  end;

  with CDSRemoto('https://www.caisistemas.es/prueba/ado.dll/soap/IConexiones','Factura_gdb',consulta) do
  try
    FNumeroDeLicencia:=FieldByName('LICENCIA').AsString;
  finally
    Free;
  end;

  if programa='PORTALSII' then
  begin
    consulta:='SELECT ADMINISTRADOR_'+programa+' FROM USUARIOS_PORTALSII WHERE IDUSUARIOS_PORTALSII='+IntToStr(idusuario)
  end
  else begin
    if programa='PORTALEMP' then
      consulta:='SELECT ADMINISTRADOR_'+programa+' FROM USUARIOS_PORTALEMP WHERE IDUSUARIOS_PORTALEMP='+IntToStr(idusuario)
    else
      consulta:='SELECT ADMINISTRADOR_'+programa+' FROM USUARIOS WHERE IDUSUARIOS='+IntToStr(idusuario)
  end;


  with CDSRemoto('http://www.caisistemas.es/prueba/ado.dll/soap/IConexiones','Factura_gdb',consulta) do
  try
    administrador:=Fields.Fields[0].AsString='S';
  finally
    Free;
  end;

  consulta:='select servicios.nuempser codigo_empresa,'+#13+
            'servicios.licencia licencia, '+#13+
            'cai_documentos_a_firmar.nombre_daf,'+#13+
            'cai_documentos_a_firmar.tipo_firma_daf,'+#13+
            'cai_documentos_firmados.interno,'+#13+
            '(select DATOS_EMPRESA.FECHA_TOPE_FIRMA_EMP from DATOS_EMPRESA where DATOS_EMPRESA.CLAVEEMP=SERVICIOS.NUEMPSER) FECHA_TOPE'+#13+
            'from servicios'+#13+
            'INNER JOIN cai_documentos_a_firmar ON (1=1)'+#13+
            'left outer join cai_documentos_firmados on'+#13+
            '(cai_documentos_a_firmar.interno=cai_documentos_firmados.documentos_a_firmar_interno_dfi'+#13+
            'and servicios.nuempser=cai_documentos_firmados.empresa_dfi)'+#13+
            'where cai_documentos_a_firmar.tipo_firma_daf=''EMPRESA'''+#13+
            'and UPPER(servicios.licencia)=UPPER('''+FNumeroDeLicencia+''')'+#13+
            'and servicios.licenciaaltaobaja=''A'''+#13+
            'and cai_documentos_firmados.interno is null'+#13+
            'union'+#13+
            'select     '+#13+
            'servicios.nuempser codigo_empresa,'+#13+
            'servicios.licencia licencia,'+#13+
            'cai_documentos_a_firmar.nombre_daf,'+#13+
            'cai_documentos_a_firmar.tipo_firma_daf,'+#13+
            'cai_documentos_firmados.interno,'+#13+
            'SERVICIOS.FECHA_TOPE_FIRMA_SER FECHA_TOPE'+#13+
            'from servicios'+#13+
            'left outer JOIN cai_documentos_a_firmar ON (servicios.tipo_licencia_ser=cai_documentos_a_firmar.tipo_licencia_daf)'+#13+
            'left outer join cai_documentos_firmados on'+#13+
            '(cai_documentos_a_firmar.interno=cai_documentos_firmados.documentos_a_firmar_interno_dfi'+#13+
            'and servicios.nuempser=cai_documentos_firmados.empresa_dfi  and UPPER(cai_documentos_firmados.LICENCIA_DFI)=UPPER('''+FNumeroDeLicencia+'''))'+#13+
            'where cai_documentos_a_firmar.tipo_firma_daf=''LICENCIA'''+#13+
            'and UPPER(servicios.licencia)=UPPER('''+FNumeroDeLicencia+''')'+#13+
            'and servicios.licenciaaltaobaja=''A'''+#13+
            'and servicios.TIPO_LICENCIA_SER IN (''WEB'')'+#13+
            'and cai_documentos_firmados.interno is null';

  if administrador then
  begin
    // Si es administracor continua con proceso de firma
    if (Trim(FNumeroDeLicencia)<>'') then
    begin
      with CDSRemoto('https://www.caisistemas.es/prueba/ADO.dll/soap/Imodulodedatos','Factura_gdb',consulta) do
      try
        if (not IsEmpty) then
        begin
          LanzaFirma(FNumeroDeLicencia,parametro,redirigir);
        end;
      finally
        Free;
      end;
    end
  end
  else begin
    // Si no es administrador si hay documentos por firmar vencidos avisa y lo saca del programa
    with CDSRemoto('https://www.caisistemas.es/prueba/ADO.dll/soap/Imodulodedatos','Factura_gdb',consulta) do
    try
      if (not IsEmpty) then
      begin
        while not eof do
        begin
          // Decide si permite_continuar o sale de la aplicación
          if ((FieldByName('FECHA_TOPE').Asstring='') or (FieldByName('FECHA_TOPE').Asdatetime<=Date)) then
              Continuar:=false;
          Next;
        end;

        if not Continuar then
        begin
          ShowMessage('No es posible entrar en la aplicación. Póngase en contacto con el Administrador',
                     procedure (Sender: Tcomponent;AResult: Integer)
                     begin
                       UniSession.AddJS('window.location.href='''+redirigir+''';');
                     end);
        end;
      end;
    finally
      Free;
    end;
  end;
end;

procedure LanzaFirma(FNumeroDeLicencia,parametro:string;redirigir:string);
begin
  with TFrmFirmaContratos.Create(UniApplication) do
  begin
    pasar_parametro_programa:=parametro;
    ShowModal(procedure(Sender: TComponent; AResult: Integer)
              begin
                if AResult=mrOk then
                 begin
                   ShowMessage('Gracias por aceptar todos los documentos.');
                 end
                 else
                   if mensaje_cerrar<>'' then
                   begin
                     mensaje_cerrar:=mensaje_cerrar+'\nSi una vez llegado a dicha fecha, existiese algun documento pendiente de firmar, el sistema bloqueará la entrada al programa hasta que se produzca la firma de dicho documento.';

                     //UniSession.AddJS('alert("'+mensaje_cerrar+'")');


                     if Permitir_continuar=false then
                       UniSession.AddJS('window.location.href='''+redirigir+''';');
                   end
                   else UniSession.AddJS('window.location.href='''+redirigir+''';');
              end);
    licencia:=FNumeroDeLicencia;
  end;
end;

procedure RGPD(programa:string;MiUsuario:integer; Miconexion:TFDConnection;redirigir:string);
var
  administrador: boolean;
  Fecha_baja_en_blanco: Boolean;
  dias_de_baja: integer;
  Fecha_baja: Tdatetime;
  consulta,FNumeroDeLicencia,Mensaje_RGPD:string;
begin
  if programa='PORTALSII' then
    consulta:='SELECT LICENCIA,ADMINISTRADOR_'+programa+' FROM USUARIOS_PORTALSII INNER JOIN LICENCIAS_PROGRAMAS_WEB ON (CLAVEEMP=EMPRESA) WHERE PROGRAMA='''+uppercase(programa)+''' AND IDUSUARIOS_PORTALSII='+IntToStr(miUsuario)
    else if programa='PORTALEMP' then
           consulta:='SELECT LICENCIA,ADMINISTRADOR_'+programa+' FROM USUARIOS_PORTALEMP INNER JOIN LICENCIAS_PROGRAMAS_WEB ON (CLAVEEMP=EMPRESA) WHERE PROGRAMA='''+uppercase(programa)+''' AND IDUSUARIOS_PORTALEMP='+IntToStr(miUsuario)
         else consulta:='SELECT LICENCIA,ADMINISTRADOR_'+programa+' FROM USUARIOS INNER JOIN LICENCIAS_PROGRAMAS_WEB ON (CLAVEEMP=EMPRESA) WHERE PROGRAMA='''+uppercase(programa)+''' AND IDUSUARIOS='+IntToStr(miUsuario);


  with CDSRemoto('https://www.caisistemas.es/prueba/ado.dll/soap/IConexiones','Factura_gdb',consulta) do
  try
    FNumeroDeLicencia:=FieldByName('LICENCIA').AsString;
    administrador:=Fields.Fields[1].AsString='S';
  finally
    Free;
  end;

  if administrador then
  begin
    with CDSRemoto('https://www.caisistemas.es/prueba/ado.dll/soap/IConexiones','Factura_gdb',
                 'select FBAJASER from servicios where upper(servicios.licencia)='+Uppercase(QuotedStr(FNumeroDeLicencia))) do
    try
      Fecha_baja:=FieldByName('FBAJASER').AsDateTime;
      Fecha_baja_en_blanco:=FieldByName('FBAJASER').AsString='';
    finally
      Free;
    end;

    dias_de_baja:=DaysBetween(Now,fecha_baja);

    if dias_de_baja<=10 then
    begin
      Mensaje_RGPD:='Licencia ' + FNumeroDeLicencia +' en baja.'+#13+#13+
      ifthen(Fecha_baja_en_blanco,'','Fecha de baja: '+FormatDateTime('dd/mm/yyyy',Fecha_baja))+#13+#13+
      'El Reglamento (UE) 2016/679, de 27 de abril de 2016 (RGPD) y la Ley Orgánica 3/2018, de Protección de Datos Personales, reconocen el derecho a la portabilidad de datos.'+#13+#13+
      'Le recordamos que según el contrato de prestación de servicio, es responsabilidad del usuario realizar la exportación de los datos que desee conservar antes de la finalización '+
      'de la relación contractual. Esta opción estará operativa durante los 10 días siguientes a la fecha de baja. Una vez transcurrido ese plazo, los datos serán eliminados de la base de datos.'+#13+#13+
      ' ¿Quiere ejercer el derecho a la portabilidad de datos ahora?';

      Funciones.MessageDlg(Mensaje_RGPD,mtConfirmation,mbYesNo,
                         procedure (Sender: Tcomponent;AResult: Integer)
                         begin
                           if AResult=mrYes then
                           begin
                             with TFrmExportarDatos.Create(UniApplication) do
                             begin
                               conexion:=MiConexion;
                               ShowModal(procedure(Sender: TComponent; AResult: Integer)
                                      begin
                                        if AResult=mrOk then
                                         begin
                                           UniSession.AddJS('window.location.href='''+redirigir+''';');
                                         end
                                         else
                                          UniSession.AddJS('window.location.href='''+redirigir+''';');
                                      end);
                             end;
                           end
                           else
                             UniSession.AddJS('window.location.href='''+redirigir+''';');
                         end,'Licencia en baja');
    end
    else
      ShowMessage('Servicio en baja desde el '+ifthen(Fecha_baja_en_blanco,FormatDateTime('dd/mm/yyyy',Date),FormatDateTime('dd/mm/yyyy',Fecha_baja)),
                 procedure (Sender: Tcomponent;AResult: Integer)
                 begin
                   UniSession.AddJS('window.location.href='''+redirigir+''';');
                 end);
  end
  else begin
    ShowMessage('No es posible entrar en la aplicación. Póngase en contacto con el Administrador',
               procedure (Sender: Tcomponent;AResult: Integer)
               begin
                 UniSession.AddJS('window.location.href='''+redirigir+''';');
               end);
  end;
end;

function CampoPK(DS:TFDDataset):String;
var
  i:Integer;
begin
  i:=0;
  Result:='';
  while (i<DS.Fields.Count-1) and not (pfInKey in DS.Fields[i].ProviderFlags)  do Inc(i);
  if i<DS.Fields.Count-1 then
    Result:=DS.Fields[i].FieldName;
end;

function SumaCampo(DS:TFDDataSet;Campo:String;Filtro:String=''):Currency;
begin
  Result:=0;
  with TFDMemTable.Create(nil) do
    try
      CloneCursor(DS,True);
      Filtered:=True;
      Filter:=Filtro;
      First;
      while not Eof do
      begin
        Result:=Result+FieldByName(Campo).AsCurrency;
        Next;
      end;
    finally
      Free;
    end;
end;

function AplicarInserts(DS:TFDQuery;Tabla:String):Boolean;
var
  Consulta:String;
  QueryInsert:TFDQuery;
  i,j:Integer;
begin
  with ConsultaAD(TFDConnection(DS.Connection),
                  'SELECT ''INSERT INTO '+Tabla+'(''||LIST(TRIM(RDB$FIELD_NAME))||'') VALUES(''||LIST('':''||TRIM(RDB$FIELD_NAME))||'')'''+#13#10+
                  'FROM RDB$RELATION_FIELDS'+#13#10+
                  'WHERE RDB$RELATION_NAME='+QuotedStr(Tabla)) do
    try
      Consulta:=Fields[0].AsString;
    finally
      Free;
    end;
  QueryInsert:=TFDQuery.Create(nil);
  try
    QueryInsert.Connection:=DS.Connection;
    QueryInsert.Transaction:=DS.Transaction;
    QueryInsert.FormatOptions.StrsEmpty2Null:=False;
    QueryInsert.SQL.Text:=Consulta;
    IniciaParametros(QueryInsert,Tabla);
    QueryInsert.Params.ArraySize:=10000;
    DS.First;
    while not DS.Eof do
    begin
      i:=0;
      while (not DS.Eof) and (i<QueryInsert.Params.ArraySize) do
      begin
        for j:=0 to QueryInsert.ParamCount-1 do
          QueryInsert.Params.Items[j].Values[i]:=DS.FieldByName(QueryInsert.Params.Items[j].Name).Value;
        DS.Next;
        Inc(i);
      end;
      QueryInsert.Execute(i);
    end;
  finally
    FreeAndNil(QueryInsert);
  end;
end;

procedure GeneraListado(ServerModule:TUniGUIServerModule;
                        Grid:TUniDBGrid;Titulo:String;
                        Acumulados:array of String;
                        TextoEsquinaSuperiorIzquierda:String;Apaisado:Boolean;
                        MargenIzquierdo,MargenDerecho:real;Fuente:String;
                        TamanoTitulo:Integer;
                        TamanoCabeceraColumnas:Integer;
                        TamanoDetalle:Integer);
var
  Informe:TppReport;
  i,j,AnchuraGrid:integer;
  VariablePagina,VariableFecha:TppSystemvariable;
  MemoInfo:TppMemo;
  LabelPagina:TppLabel;
  Espaciado,Anchura,HeightTotales:real;
  LabelTitulo:TppLabel;
  Primera:Boolean;
  Fichero:String;
begin
  Primera:=true;
  Espaciado:=1;
  Informe:=TppReport.Create(nil);
  Informe.Units:=utMillimeters;
  if Apaisado then Informe.PrinterSetup.Orientation:=TPrinterOrientation(1);
  Informe.AllowPrintToFile:=True;
  Anchura:=Informe.PrinterSetup.PaperWidth-MargenIzquierdo-3*MargenDerecho;
  try
    AnchuraGrid:=0;
    for i:=0 to Grid.Columns.Count-1 do AnchuraGrid:=AnchuraGrid+IfThen(Grid.Columns.Items[i].Visible,Grid.Columns.Items[i].Width,0);
    Informe.CreateDefaultBands;
    Informe.HeaderBand.Height:=Informe.HeaderBand.Height*2.5;
    Informe.DataPipeline:=TppDBPipeline.Create(Informe);
    Informe.AutoStop:=False;
    Informe.PreviewFormSettings.WindowState:=wsMaximized;
    Informe.PreviewFormSettings.ZoomSetting:=zsPageWidth;
    //Variable de página
    VariablePagina:=TppSystemVariable.Create(Informe);
    with VariablePagina do
    begin
      Band:=Informe.HeaderBand;
      VarType:=vtPageSet;
      Font.name:=Fuente;
      Font.Size:=TamanoDetalle;
      Left:=Anchura+MargenIzquierdo-Width;
      Alignment:=taRightJustify;
      Top:=Height;
    end;
    //Variable fecha
    VariableFecha:=TppSystemVariable.Create(Informe);
    with VariableFecha do
    begin
      Band:=Informe.HeaderBand;
      VarType:=vtDate;
      Font.name:=Fuente;
      Font.Size:=TamanoDetalle;
      Left:=Anchura+MargenIzquierdo-Width;
      Alignment:=taRightJustify;
      Top:=Height+Height;
    end;
    //Label página
    LabelPagina:=TppLabel.Create(Informe);
    with LabelPagina do
    begin
      Band:=Informe.HeaderBand;
      Caption:='Página: ';
      Font.Name:=Fuente;
      Font.Size:=TamanoDetalle;
      Left:=Anchura+MargenIzquierdo-Max(VariablePagina.Width,VariableFecha.Width)-Width-20;
      Top:=VariablePagina.Top;
    end;
    //Label fecha
    with TppLabel.Create(Informe) do
    begin
      Band:=Informe.HeaderBand;
      Caption:='Fecha: ';
      Font.Name:=Fuente;
      Font.Size:=TamanoDetalle;
      Left:=LabelPagina.Left;
      Top:=VariableFecha.Top;
    end;
    //Memor información
    MemoInfo:=TppMemo.Create(Informe);
    with MemoInfo do
    begin
      Band:=Informe.HeaderBand;
      Lines.Text:=TextoEsquinaSuperiorIzquierda;
      Font.name:=Fuente;
      Font.Size:=TamanoDetalle;
      Width:=LabelPagina.Width+5+VariablePagina.Width;
      Left:=MargenIzquierdo;
      Top:=VariablePagina.Top;
    end;
    LabelTitulo:=TppLabel.Create(Informe);
    with LabelTitulo do
    begin
      Band:=Informe.HeaderBand;
      AutoSize:=False;
      Caption:=Titulo;
      Font.Name:=Fuente;
      Font.Size:=TamanoTitulo;
      Font.Style:=[fsBold,fsUnderline];
      Left:=MargenIzquierdo;
      Height:=Height+1.5;
      Width:=Anchura;
      TextAlignment:=taCentered;
      SendToBack;
      Top:=0;
    end;
    for i:=0 to Grid.Columns.Count-1 do
    begin
      if Grid.Columns.Items[i].Visible then
      begin
        with TppLabel.Create(Informe) do
        begin
          Band:=Informe.HeaderBand;
          Caption:=Grid.Columns.Items[i].Title.Caption;
          Width:=(Anchura-Espaciado*(Grid.Columns.Count-1))*Grid.Columns.Items[i].Width/AnchuraGrid;
          Font.Name:=Fuente;
          Font.Size:=TamanoCabeceraColumnas;
          Font.Style:=[fsBold];
          Left:=MargenIzquierdo;
          Top:=Band.Height-Height-1;
          if i=0 then LabelTitulo.Top:=(Band.Height-Height)/2-LabelTitulo.Height/2;
        end;
        with TppLine.Create(Informe) do
        begin
          Band:=Informe.HeaderBand;
          Width:=(Anchura-Espaciado*(Grid.Columns.Count-1))*Grid.Columns.Items[i].Width/AnchuraGrid;
          Left:=MargenIzquierdo;
          Height:=Pen.Width;
          Top:=Band.Height-Height;
        end;

        //Si queremos poner el campo como acumulado lo ponemos
        j:=0;
        while (j<length(Acumulados)) and (uppercase(Acumulados[j])<>uppercase(Grid.Columns.Items[i].FieldName)) do j:=j+1;
        if j<length(Acumulados) then
        begin
          if Primera then
          begin
            Primera:=False;
            with TppLabel.Create(Informe) do
            begin
              Band:=Informe.FooterBand;
              Caption:='TOTALES';
              Width:=Anchura;
              Font.Name:=Fuente;
              Font.Size:=TamanoCabeceraColumnas;
              Font.Style:=[fsBold];
              Left:=LabelTitulo.Left;
              HeightTotales:=Height;
              Top:=0;
            end;
            with TppLine.Create(Informe) do
            begin
              Band:=Informe.FooterBand;
              Width:=Anchura;
              Left:=LabelTitulo.Left;
              Height:=Pen.Width;
              Top:=HeightTotales+Height;
            end;
          end;
          with TppDBCalc.Create(Informe) do
          begin
            Band:=Informe.FooterBand;
            DataPipeline:=Informe.DataPipeline;
            DataField:=Grid.Columns.Items[i].FieldName;
            TextAlignment:=taRightJustified;
            DisplayFormat:=',0.00';
            Width:=(Anchura-Espaciado*(Grid.Columns.Count-1))*Grid.Columns.Items[i].Width/AnchuraGrid;
            Left:=MargenIzquierdo;
            Font.Name:=Fuente;
            Top:=HeightTotales+Height;
            Font.Size:=TamanoDetalle;
          end;
          with TppLine.Create(Informe) do
          begin
            Band:=Informe.FooterBand;
            Width:=(Anchura-Espaciado*(Grid.Columns.Count-1))*Grid.Columns.Items[i].Width/AnchuraGrid;
            Left:=MargenIzquierdo;
            Height:=Pen.Width;
            Top:=HeightTotales+Height+Height;
          end;
        end;
        if (Grid.Columns.Items[i].Field is TStringField) or
           (Grid.Columns.Items[i].Field is TBlobField) then
        begin
          with TppDBMemo.Create(Informe) do
          begin
            Band:=Informe.DetailBand;
            DataPipeline:=Informe.DataPipeline;
            DataField:=Grid.Columns.Items[i].FieldName;
            case Grid.Columns.Items[i].Field.Alignment of
              taLeftJustify:TextAlignment:=taLeftJustified;
              taRightJustify:TextAlignment:=taRightJustified;
              taCenter:TextAlignment:=taCentered;
            end;
            Width:=(Anchura-Espaciado*(Grid.Columns.Count-1))*Grid.Columns.Items[i].Width/AnchuraGrid;
            Stretch:=True;
            Font.Name:=Fuente;
            Font.Size:=TamanoDetalle;
            Left:=MargenIzquierdo;
            MargenIzquierdo:=MargenIzquierdo+Espaciado+Width;
            if i=0 then Informe.GetBand(btDetail,0).Height:=Height;
          end;
        end
        else begin
          with TppDBText.Create(Informe) do
          begin
            Band:=Informe.DetailBand;
            DataPipeline:=Informe.DataPipeline;
            DataField:=Grid.Columns.Items[i].FieldName;
            case Grid.Columns.Items[i].Field.Alignment of
              taLeftJustify:TextAlignment:=taLeftJustified;
              taRightJustify:TextAlignment:=taRightJustified;
              taCenter:TextAlignment:=taCentered;
            end;
            if (Grid.Columns.Items[i].Field is TFMTBcdField) then
              DisplayFormat:=IfThen(TFMTBcdField(Grid.Columns.Items[i].Field).DisplayFormat='',',0.00',TFMTBcdField(Grid.Columns.Items[i].Field).DisplayFormat)
            else if (Grid.Columns.Items[i].Field is TBCDField) then
              DisplayFormat:=IfThen(TBCDField(Grid.Columns.Items[i].Field).DisplayFormat='',',0.00',TBCDField(Grid.Columns.Items[i].Field).DisplayFormat)
            else if (Grid.Columns.Items[i].Field is TCurrencyField) then
              DisplayFormat:=IfThen(TCurrencyField(Grid.Columns.Items[i].Field).DisplayFormat='',',0.00',TCurrencyField(Grid.Columns.Items[i].Field).DisplayFormat)
            else if (Grid.Columns.Items[i].Field is TFloatField) then
              DisplayFormat:=IfThen(TFloatField(Grid.Columns.Items[i].Field).DisplayFormat='',',0.00',TFloatField(Grid.Columns.Items[i].Field).DisplayFormat)
            else if (Grid.Columns.Items[i].Field is TIntegerField) then
              DisplayFormat:=TIntegerField(Grid.Columns.Items[i].Field).DisplayFormat;
            Width:=(Anchura-Espaciado*(Grid.Columns.Count-1))*Grid.Columns.Items[i].Width/AnchuraGrid;
            Font.Name:=Fuente;
            Font.Size:=TamanoDetalle;
            Left:=MargenIzquierdo;
            MargenIzquierdo:=MargenIzquierdo+Espaciado+Width;
            if i=0 then Informe.GetBand(btDetail,0).Height:=Height;
          end;
        end;
      end;
    end;

    if (Grid.DataSource.Dataset.ClassType=TFDQuery) and
       (trim(TFDQuery(Grid.DataSource.Dataset).SQL.Text)<>'') then
    begin
      TppDBPipeline(Informe.DataPipeline).DataSource:=TDataSource.Create(Informe);
      TppDBPipeline(Informe.DataPipeline).DataSource.DataSet:=TFDQuery.Create(Informe);
      with TFDQuery(TppDBPipeline(Informe.DataPipeline).DataSource.DataSet) do
      begin
        Transaction:=TFDQuery(Grid.DataSource.Dataset).Transaction;
        Connection:=TFDQuery(Grid.DataSource.Dataset).Connection;
        FetchOptions.Items:=[];
        SQL.Text:=TFDQuery(Grid.DataSource.Dataset).SQL.Text;
        for i:=0 to TFDQuery(Grid.DataSource.Dataset).MacroCount-1 do
          Macros.MacroByName(TFDQuery(Grid.DataSource.Dataset).Macros.Items[i].Name).Value:=TFDQuery(Grid.DataSource.Dataset).Macros.Items[i].Value;
        for i:=0 to TFDQuery(Grid.DataSource.Dataset).ParamCount-1 do
          Params.ParamByName(TFDQuery(Grid.DataSource.Dataset).Params.Items[i].Name).Value:=TFDQuery(Grid.DataSource.Dataset).Params.Items[i].Value;
        Open;
      end;
    end else
      TppDBPipeline(Informe.DataPipeline).DataSource:=Grid.DataSource;
    {$IFNDEF SINCRONIZAR}
    TFrmVisorPDF.Create(UniApplication).Mostrar(ReplaceText(ExportaAPDF(Informe,IncludeTrailingPathDelimiter(ServerModule.LocalCachePath)),ServerModule.LocalCachePath,ServerModule.LocalCacheURL));
    {$ENDIF}
  finally
    Informe.Free;
  end;
end;

function ExportaAPDF(Informe:TppReport;RutaPDF:String;HacerZip:boolean;passwordzip:string;nombrezip:string;FicheroPDFDestino:String):String;
var
  AbZipperAux: TAbZipper;
begin

  with Informe do
  begin
    Reset;
    AllowPrintToArchive := True;
    AllowPrintToFile    := True;
    Informe.DeviceType:='PDF';
    Informe.ShowPrintDialog:=False;
    Informe.PDFSettings.Author:='CAI Sistemas Informáticos S.L.';
    Informe.TextFileName:=IncludeTrailingPathDelimiter(RutaPDF)+'_'+FormatDateTime('yyyymmddhhnnsszzz',Now)+'_.pdf';
    Informe.ShowPrintDialog:=False;
    Informe.ShowCancelDialog:=False;
    try

      Informe.Print;
      if FicheroPDFDestino<>'' then
      begin
        UnirPDFS(FicheroPDFDestino,Informe.TextFileName);
        Result:=FicheroPDFDestino;
      end
      else
        result:=Informe.TextFileName;
      if not FileExists(result) then result:='';

      if HacerZip then
      begin
        // Comprimimos fichero y enviamos por email con contraseña
        AbZipperAux := TAbZipper.Create(nil);
        try
          AbZipperAux.FileName := IncludeTrailingPathDelimiter(AbZipperAux.BaseDirectory)+'.zip';
          if passwordzip<>'' then
            AbZipperAux.Password := passwordzip;
          AbZipperAux.BaseDirectory := ExtractFileDir(result);
          AbZipperAux.AddFiles(result,faAnyFile);
          AbZipperAux.CloseArchive;
          Result:=IncludeTrailingPathDelimiter(AbZipperAux.BaseDirectory)+AbZipperAux.FileName;
        finally
          AbZipperAux.Free;
        end;
      end;
    except
    {$IFNDEF SINCRONIZAR}
      on E:exception do
        UniServerModule.Logger.AddLog('Error en la generación del PDF: '+E.Message);
    {$ENDIF}
    end;
  end;
end;

procedure BorraFicheros(Mascara: String);
var
  MySearch: TSearchRec;
begin
  //Se borran los Listados que haya en el directorio
 {$IFNDEF SINCRONIZAR}
  if SysUtils.FindFirst(IncludeTrailingPathDelimiter(UniServerModule.FilesFolderPath)+Mascara,faAnyFile, MySearch)=0 then
  begin
    DeleteFile(PChar(IncludeTrailingPathDelimiter(UniServerModule.FilesFolderPath)+MySearch.Name));
    while SysUtils.FindNext(MySearch)=0 do DeleteFile(PChar(IncludeTrailingPathDelimiter(UniServerModule.FilesFolderPath)+MySearch.Name));
  end;
  SysUtils.FindClose(MySearch);
 {$ENDIF}
end;


function ConsultaAD(Conexion:TFDConnection;Consulta:String;Unidireccional:Boolean;Abrir:Boolean;Transaccion:TFDTransaction;AOwner:TComponent;Parametros:TFDParams;ListaMacros:TFDMacros):TFDQuery;
begin
   {$IFNDEF SINCRONIZAR}
  result:=TFDQuery.Create(AOwner);
  with result do
    try
      if Conexion.Connected=False then
        Conexion.Connected:=True;
      Connection:=Conexion;
      SQL.Text:=Consulta;
      if Assigned(ListaMacros) then
        AsignarMacros(Macros,ListaMacros);
      if Assigned(Parametros) then
        AsignarParametros(Params,Parametros);
      if Transaccion<>nil then
      begin
        Transaction:=Transaccion;
        UpdateTransaction:=Transaccion;
      end;
      FetchOptions.Unidirectional:=Unidireccional;
      if Unidireccional then
        FetchOptions.Mode:=fmAll;

      if not Unidireccional then
        FetchOptions.Mode:=fmAll;
      CachedUpdates:=not UniDireccional;
      if Abrir then
        Open;
    except
      Free;
      UniServerModule.Logger.AddLog(PChar('CONSULTA FALLIDA'+IFThen(Conexion.Connected,'(Conectado)','(No conectado)')+#13#10+'================'#13#10+Consulta));
      Raise;
    end;
   {$ENDIF}
end;

function Euros(paValor: Currency): Currency;
begin
  Result:=SimpleRoundTo(paValor,-2);
end;

// Fran : Esta que encontre me funciona mejor que Euros
function EurosRound(const Value: Currency): Currency;
var
  V64: Int64 absolute Result;
  Decimals: Integer;
begin
  Result := Value;
  Decimals := V64 mod 100;
  Dec(V64, Decimals);
  case Decimals of
    -99 .. -50 : Dec(V64, 100);
     50 ..  99 : Inc(V64, 100);
  end;
end;


procedure DesactivarControles(Control:TComponent;Desactivar:Boolean;OmitirValorDeTabStop:boolean;ponerAspaAdbLookupComboBox:boolean);
var
  i:integer;
  NumeroComponentes:Integer;
begin
  if ((Control is TUniForm) and (TUniForm(Control).ComponentCount>0)) or
     ((Control is TUniFrame) and (TUniFrame(Control).ComponentCount>0)) or
     ((Control.ClassType=TUniPanel) and (TUniPanel(Control).ControlCount>0)) or
     ((Control.ClassType=TUniGroupBox) and (TUniGroupBox(Control).ControlCount>0)) or
     ((Control.ClassType=TUniToolBar) and (TUniToolBar(Control).ControlCount>0)) or
     ((Control.ClassType=TUniTabSheet) and (TUniTabSheet(Control).ControlCount>0)) or
     ((Control.ClassType=TUniPageControl) and (TUniPageControl(Control).ControlCount>0)) or
     ((Control.ClassType=TUniContainerPanel) and (TUniContainerPanel(Control).ControlCount>0)) then
  begin
    if Control is TUniForm then NumeroComponentes:=TUniForm(Control).ComponentCount
    else if Control is TUniFrame then NumeroComponentes:=TUniFrame(Control).ComponentCount
    else if Control.ClassType=TUniPanel then NumeroComponentes:=TUniPanel(Control).ControlCount
    else if Control.ClassType=TUniGroupBox then NumeroComponentes:=TUniGroupBox(Control).ControlCount
    else if Control.ClassType=TUniToolBar then NumeroComponentes:=TUniToolBar(Control).ControlCount
    else if Control.ClassType=TUniTabSheet then NumeroComponentes:=TUniTabSheet(Control).ControlCount
    else if Control.ClassType=TUniPageControl then NumeroComponentes:=TUniPageControl(Control).ControlCount
    else if Control.ClassType=TUniContainerPanel then NumeroComponentes:=TUniContainerPanel(Control).ControlCount;
    for i:=0 to NumeroComponentes-1 do
       if Control is TUniForm then DesactivarControles(TUniForm(Control).Components[i],Desactivar,OmitirValorDeTabStop,ponerAspaAdbLookupComboBox)
       else if Control is TUniFrame then DesactivarControles(TUniFrame(Control).Components[i],Desactivar,OmitirValorDeTabStop,ponerAspaAdbLookupComboBox)
       else if Control.ClassType=TUniPanel then DesactivarControles(TUniPanel(Control).Controls[i],Desactivar,OmitirValorDeTabStop,ponerAspaAdbLookupComboBox)
       else if Control.ClassType=TUniGroupBox then DesactivarControles(TUniGroupBox(Control).Controls[i],Desactivar,OmitirValorDeTabStop,ponerAspaAdbLookupComboBox)
       else if Control.ClassType=TUniToolBar then DesactivarControles(TUniToolBar(Control).Controls[i],Desactivar,OmitirValorDeTabStop,ponerAspaAdbLookupComboBox)
       else if Control.ClassType=TUniTabSheet then DesactivarControles(TUniTabSheet(Control).Controls[i],Desactivar,OmitirValorDeTabStop,ponerAspaAdbLookupComboBox)
       else if Control.ClassType=TUniPageControl then DesactivarControles(TUniPageControl(Control).Controls[i],Desactivar,OmitirValorDeTabStop,ponerAspaAdbLookupComboBox)
       else if Control.ClassType=TUniContainerPanel then DesactivarControles(TUniContainerPanel(Control).Controls[i],Desactivar,OmitirValorDeTabStop,ponerAspaAdbLookupComboBox);
  end
  else begin
    if (Control is TUniBitBtn) and (ponerAspaAdbLookupComboBox=False) then TUniBitBtn(Control).Enabled:=not Desactivar
    else if (Control is TUniButton ) and (ponerAspaAdbLookupComboBox=False) then TUniButton(Control).Enabled:=not Desactivar
    else if (Control is TUniToolButton ) and (ponerAspaAdbLookupComboBox=False) then TUniToolButton(Control).Enabled:=not Desactivar
    else if (Control is TUnidbradiogroup ) and (ponerAspaAdbLookupComboBox=False) then TUnidbradiogroup(Control).ReadOnly:=Desactivar
    else if (Control is TUniComboBox ) and (ponerAspaAdbLookupComboBox=False) then
    begin
      if TUniComboBox(Control).TabStop or OmitirValorDeTabStop then
      begin
        TUniComboBox(Control).Color:=IfThen(Desactivar,clInfoBk,clWindow);
        TUniComboBox(Control).ReadOnly:=Desactivar;
        TUniComboBox(Control).TabStop:=not TUniComboBox(Control).ReadOnly
      end;
    end
    else if ((Control.ClassType=TUniDBEdit) or (Control.ClassType=TUniEdit)) and (ponerAspaAdbLookupComboBox=False) then
    begin
      if TUniEdit(Control).TabStop or OmitirValorDeTabStop then
      begin
        TUniEdit(Control).Color:=IfThen(Desactivar,clInfoBk,clWindow);
        TUniEdit(Control).ReadOnly:=Desactivar;
        TUniEdit(Control).TabStop:=not TUniEdit(Control).ReadOnly
      end;
    end
    else if (Control.ClassType=TUniDBNumberEdit) and (ponerAspaAdbLookupComboBox=False) then
    begin
      if TUniDBNumberEdit(Control).TabStop  or OmitirValorDeTabStop then
      begin
        TUniDBNumberEdit(Control).Color:=IfThen(Desactivar,clInfoBk,clWindow);
        TUniDBNumberEdit(Control).ReadOnly:=Desactivar;
        TUniDBNumberEdit(Control).TabStop:=not TUniDBNumberEdit(Control).ReadOnly
      end;
    end
    else if (Control.ClassType=TUniDBFormattedNumberEdit) and (ponerAspaAdbLookupComboBox=False) then
    begin
      if TUniDBFormattedNumberEdit(Control).TabStop  or OmitirValorDeTabStop then
      begin
        TUniDBFormattedNumberEdit(Control).Color:=IfThen(Desactivar,clInfoBk,clWindow);
        TUniDBFormattedNumberEdit(Control).ReadOnly:=Desactivar;
        TUniDBFormattedNumberEdit(Control).TabStop:=not TUniDBFormattedNumberEdit(Control).ReadOnly
      end;
    end
    else if (Control is TUniDBLookupComboBox)  then
    begin
      if ponerAspaAdbLookupComboBox then
        TUniDBLookupComboBox(Control).ClearButton:=True
      Else
        if TUniDBLookupComboBox(Control).TabStop  or OmitirValorDeTabStop then
        begin
          TUniDBLookupComboBox(Control).Color:=IfThen(Desactivar,clInfoBk,clWindow);
          TUniDBLookupComboBox(Control).ReadOnly:=Desactivar;
          TUniDBLookupComboBox(Control).TabStop:=not TUniDBLookupComboBox(Control).ReadOnly
        end;
    end
    else if (Control is TUniDBComboBox)  then
    begin
      IF ponerAspaAdbLookupComboBox then
        TUniDBComboBox(Control).ClearButton:=True
      Else
        if TUniDBComboBox(Control).TabStop  or OmitirValorDeTabStop then
        begin
          TUniDBComboBox(Control).Color:=IfThen(Desactivar,clInfoBk,clWindow);
          TUniDBComboBox(Control).ReadOnly:=Desactivar;
          TUniDBComboBox(Control).TabStop:=not TUniDBComboBox(Control).ReadOnly
        end;
    end
    else if (Control is TUniCheckBox) and (ponerAspaAdbLookupComboBox=False) then
    begin
      if TUniCheckBox(Control).TabStop  or OmitirValorDeTabStop then
      begin
        TUniCheckBox(Control).ReadOnly:=Desactivar;
        TUniCheckBox(Control).TabStop:=not TUniCheckBox(Control).ReadOnly
      end;
    end
    else if (Control is TUniDBCheckBox) and (ponerAspaAdbLookupComboBox=False) then
    begin
      if TUniDBCheckBox(Control).TabStop  or OmitirValorDeTabStop then
      begin
        TUniDBCheckBox(Control).ReadOnly:=Desactivar;
        TUniDBCheckBox(Control).TabStop:=not TUniDBCheckBox(Control).ReadOnly
      end;
    end
    else if (Control is TUniDBGrid) and (ponerAspaAdbLookupComboBox=False) then
    begin
      TUniDBGrid(Control).Color:=IfThen(Desactivar,clInfoBk,clWindow);
      if Desactivar then
      begin
        TUniDBGrid(Control).Options:=TUniDBGrid(Control).Options-[dgEditing];
        TUniDBGrid(Control).Options:=TUniDBGrid(Control).Options+[dgRowSelect];
        TUniDBGrid(Control).OnDblClick:=nil;
        TUniDBGrid(Control).OnMouseUp:=nil;
      end
      else begin
        TUniDBGrid(Control).Options:=TUniDBGrid(Control).Options+[dgEditing];
        TUniDBGrid(Control).Options:=TUniDBGrid(Control).Options-[dgRowSelect];
      end;
      for i:=0 to TUniDBGrid(Control).Columns.Count-1 do
        TUniDBGrid(Control).Columns.Items[i].Color:=IfThen(Desactivar,clInfoBk,clWindow);
    end
    else if (Control is TUniDBDateTimePicker) and (ponerAspaAdbLookupComboBox=False) then
    begin
      if TUniDBDateTimePicker(Control).TabStop  or OmitirValorDeTabStop then
      begin
        TUniDBDateTimePicker(Control).Color:=IfThen(Desactivar,clInfoBk,clWindow);
        TUniDBDateTimePicker(Control).ReadOnly:=Desactivar;
        TUniDBDateTimePicker(Control).TabStop:=not TUniDBDateTimePicker(Control).ReadOnly
      end;
    end
    else if (Control is TUniTreeView) and (ponerAspaAdbLookupComboBox=False) then
    begin
      TUniTreeView(Control).Color:=IfThen(Desactivar,clInfoBk,clWindow);
    end
    else if (Control is TUniMemo) and (ponerAspaAdbLookupComboBox=False) then
    begin
      if TUniMemo(Control).TabStop  or OmitirValorDeTabStop then
      begin
        TUniMemo(Control).Color:=IfThen(Desactivar,clInfoBk,clWindow);
        TUniMemo(Control).ReadOnly:=Desactivar;
        TUniMemo(Control).TabStop:=not TUniMemo(Control).ReadOnly
      end;
    end
    else if (Control is TUniDBMemo) and (ponerAspaAdbLookupComboBox=False) then
    begin
      if TUniDBMemo(Control).TabStop  or OmitirValorDeTabStop then
      begin
        TUniDBMemo(Control).Color:=IfThen(Desactivar,clInfoBk,clWindow);
        TUniDBMemo(Control).ReadOnly:=Desactivar;
        TUniDBMemo(Control).TabStop:=not TUniDBMemo(Control).ReadOnly
      end;
    end
  end;
end;

procedure DescargarArchivo(Servidor,Usuario,Contrasena,Ruta:String);
var
  NombreFichero:String;
begin
 {$IFNDEF SINCRONIZAR}
  if Pos('/',Ruta)=0 then
    NombreFichero:=Ruta
  else
    Nombrefichero:=ReverseString(copy(ReverseString(Ruta),1,Pos('/',ReverseString(Ruta))-1));

  Nombrefichero:=ReplaceText(
                 ReplaceText(
                 ReplaceText(NombreFichero,'+',''),
                                           'Ñ','N'),
                                           'ñ','n');
  DescargarArchivoFTP(Servidor,Usuario,Contrasena,Ruta,IncludeTrailingPathDelimiter(UniServerModule.LocalCachePath)+NombreFichero);
  UniSession.SendFile(IncludeTrailingPathDelimiter(UniServerModule.LocalCachePath)+NombreFichero);
  DeleteFile(IncludeTrailingPathDelimiter(UniServerModule.LocalCachePath)+NombreFichero);
 {$ENDIF}
end;

function ActivarFormulario(FormClass:TUniFormClass):boolean;
var
  i:integer;
begin
  i:=0;
  while (i<Unisession.FormsList.Count) and (TUniForm(Unisession.FormsList.Items[i]).ClassType<>FormClass) do Inc(i);
  result:=i<Unisession.FormsList.Count;
  if result then
    TUniForm(Unisession.FormsList.Items[i]).BringToFront;
end;

function BuscarFormulario(FormClass:TUniFormClass):TUniForm;
var
  i:integer;
begin
  i:=0;
  while (i<Unisession.FormsList.Count) and (TUniForm(Unisession.FormsList.Items[i]).ClassType<>FormClass) do Inc(i);
  if i<Unisession.FormsList.Count then
    result:=TUniForm(Unisession.FormsList.Items[i])
  else
    result:=nil;
end;

function PersonaFisica(Pais: string; NIF: string): boolean;
begin
  Result:=((Trim(Pais) = '') or (Trim(Pais) = 'ES')) and
          (Pos(Copy(Trim(NIF),1,1),'0123456789KLMXYZ')<>0);
end;

function CalcCifnif(paIcif: string; paCif: string; paMensaje: boolean; CallBack:TUniDialogCallBackProc=nil): string;
var
   loLetra:   string;
   loMensaje: string;
begin
   paCif:=UpperCase(paCif);
   Result := paCif;

   // si no es español o el cif esta vacio el cif esta bien
   if ((Trim(paIcif) <> '') and (Trim(paIcif) <> 'ES')) or (Trim(paCif) = '') then
      Exit;

   loLetra := LetraONumeroDeUnCifNif(Copy(paCif,1,8));

   if loLetra = '' then
      begin
         if paMensaje then
            uniGUIDialogs.ShowMessage('NIF incorrecto',CallBack);

         Result := 'MAL';
         Exit;
      end
   else begin
      if Length(paCif) = 8 then begin
         if Length(loLetra) = 1 then
            Result := paCif + loLetra
         else
            Result := paCif + Copy(loLetra,2,1);
      end;

      if Length(paCif) = 9 then begin
         if Pos(Copy(paCif,9,1),loLetra) = 0 then begin
            if paMensaje then begin
               if Length(loLetra) = 1 then
                  loMensaje := 'NIF incorrecto, el caracter de control debería ser ' + loLetra
               else
                  loMensaje := 'NIF incorrecto, el caracter de control debería ser ' + Copy(loLetra,1,1) + ' o ' + Copy(loLetra,2,1);

               uniGUIDialogs.ShowMessage(loMensaje,CallBack);
            end;

            Result := 'MAL';
         end;
      end;
   end;
end;

function LetraONumeroDeUnCifNif(paCif: String): string;
var
   loSw:      integer;
   loSuma:    integer;
   loControl: Integer;
   loCif:     string;
begin
   Result := '';
   loCif  := '';

   // Se pasa todo a mayúsculas limpio de espacios y de caracteres especiales}
   paCif := UpperCase(Trim(paCif));

   // Solo quiero letras y numeros

   for loSw := 1 to Length(paCif) do begin
      if (Pos(paCif[loSw],'0123456789ABCDEFGHIJKLMNÑOPQRSTUVWXYZ') <> 0) then
         loCif := loCif + paCif[loSw];
   end;

   try
      //El cif debe ser de 8 cifras, ya que la ultima es la que queremos calcular
      if Length(loCif) = 8 then begin
         //Comprobamos que sea un NIF}
         if (Pos(loCif[1],'0123456789') <> 0) then
            Result := LetraDeUnNif(loCif)
         else
            //Se comprueba que la letra que designa el tipo de cif sea correcta}
            if (Pos(loCif[1], 'ABCDEFGHJKLMNPQSUVWRXYZ') = 0) then
               Result := ''
            else // Se comprueba si es un extranjero (persona fisica), en ese caso se calcula el nif, cambiando la X o M o K o L, por 0, la Y por 1 y la Z por 2}
               if Pos(loCif[1],'KLMX') <> 0 then
                  Result := LetraDeUnNif('0' + Copy(loCif,2,8))
               else if loCif[1]='Y' then
                  Result := LetraDeUnNif('1' + Copy(loCif,2,8))
               else if loCif[1]='Z' then
                  Result := LetraDeUnNif('2' + Copy(loCif,2,8))
               else begin
                  loSuma:= StrToInt(loCif[3]) + StrToInt(loCif[5]) + StrToInt(loCif[7]);
                  for loSw := 1 to 4 do
                     loSuma := loSuma + ((2 * StrToInt(loCif[2 * loSw])) mod 10) + ((2 * StrToInt(loCif[2 * loSw])) div 10);

                  loControl := 10 - (loSuma mod 10);
                  // Se comprueba si es de tipo 'N' o 'P' o 'Q' o 'S' o 'R' o 'W', es decir, Corporaciones Locales (Ayuntamientos, etc.)
                  // y Organismos públicos.}
                  if Pos(loCif[1],'NPQSRW') <> 0 then
                     // loControl tipo letra
                     Result := Chr(64 + loControl)
                  else begin // Resto de tipos de CIF}
                     Result := Chr(64 + loControl);

                     // loControl tipo número}
                     if loControl = 10 then
                        loControl := 0;

                     Result := Result + IntToStr(loControl);
                  end;
               end;
      end;
   except
      Result := '';
   end;
end;

function LetraDeUnNif(paDni: String): string;
begin
  Result := Copy('TRWAGMYFPDXBNJZSQVHLCKET',StrToInt(Copy(paDni,1,8)) mod 23 + 1,1)[1];
end;

procedure ObtieneServidorRuta(RutaBD:String;var Host,Ruta:String);
var
  Auxiliar:String;
begin
  //Especificamos el servidor
  if (Copy(RutaBD,2,2) <> ':\') then begin
    if Copy(RutaBD,1,2) = '//' then begin //ruta NETBEUI
      delete(RutaBD,1,2);
      Host:=Copy(RutaBD,1,Pos('/',RutaBD) - 1);
      Ruta:=Copy(RutaBD,Pos('/',RutaBD) + 1,Length(RutaBD)-Pos('/',RutaBD));
    end else if Copy(RutaBD,1,2)='\\' then begin //ruta compartida
      delete(RutaBD,1,2);
      Host:=Copy(RutaBD,1,Pos('\',RutaBD) - 1);
      Ruta:=Copy(RutaBD,Pos('\',RutaBD) + 1,Length(RutaBD)-Pos('\',RutaBD));
    end else begin//Ruta TCPIP
      Host:=Copy(RutaBD,1,Pos(':',RutaBD) - 1);
      Ruta:=Copy(RutaBD,Pos(':',RutaBD) + 1,Length(RutaBD)-Pos(':',RutaBD));
    end;
  end else begin
    Host:='LocalHost';
    Ruta:=RutaBD;
  end;
end;


procedure ExportarUnaTabla3(paTabla: TDataSet; paLibro: string; nombrefichero :string='';enviar:boolean=True; VersionExcel : TexcelVersion = TexcelVersion.xvExcel97; EnviarNombre:string =''; LibroNuevo:boolean=False;
  SobreEscribirFichero:boolean=True; SoloExportarTag0:boolean=False);
var
  LibroXLS:TXLSReadWriteII5;
   i : integer;
begin
  {$IFNDEF SINCRONIZAR}
  if NombreFichero='' then
    NombreFichero:=UniServerModule.LocalCachePath+'Exportacion'+FormatDateTime('yyyymmddhhnnss',Now)+'.xls';
  LibroXLS:=TXLSReadWriteII5.Create(nil);
  try
    if SobreEscribirFichero or not Fileexists(NombreFichero) then
      LibroXLS.Version  := VersionExcel
    else
      LibroXLS.LoadFromFile(NombreFichero);

    if LibroNuevo then
      LibroXLS.Add.Name := paLibro
    else
      LibroXLS.Sheets[0].Name:=paLibro;




    with TXLSDbRead5.Create(nil) do
      try
        if SoloExportarTag0 then
          for I := 0 to paTabla.Fields.Count-1 do
            if paTabla.Fields.Fields[i].Tag <> 0 then
              ExcludeFields.Add(paTabla.Fields.Fields[i].FieldName);

        ReadDetailTables := False;
        XLS:=LibroXLS;
        if LibroNuevo then
          Sheet:=LibroXLS.SheetByName(paLibro).Index
        else
          Sheet:=0;
        Dataset:=paTabla;
        Read;
      finally
        Free;
       end;
    LibroXLS.SaveToFile(nombreFichero);
  finally
    FreeAndNil(LibroXLS);
  end;
  if enviar then
    UniSession.SendFile(NombreFichero, EnviarNombre);
 {$ENDIF}
end;

{$IFNDEF WEBBD}
function emailValido(const Value: string;Tipo:integer): boolean;
  function CheckAllowed(const s: string): boolean;
  var i: Integer;
  begin
  Result:= False;
  for i:= 1 to Length(s) do // illegal char in s -> no valid address
    if not (s[i] in ['a'..'z','A'..'Z','0'..'9','_','-','.']) then Exit;
  Result:= true;
  end;
var
  i,len: Integer;
  namePart, serverPart: String;
begin // of IsValidEmail
  Result:= False;
  if tipo=1 then
  begin
    i:= Pos('@', Value);
    if (i=0) or (Pos('..',Value) > 0) then Exit;
    namePart:= Copy(Value, 1, i - 1);
    serverPart:= Copy(Value,i+1,Length(Value));
    len:=Length(serverPart);
    // must have dot and at least 3 places from end, 2 places from begin
    IF (len<4) OR
       (Pos('.',serverPart)=0) or
       (serverPart[1]='.') or
       (serverPart[len]='.') or
       (serverPart[len-1]='.') then Exit;

    Result:= CheckAllowed(namePart) and CheckAllowed(serverPart);
  end;


  if tipo=2 then
  begin
    Result:= True;
    {$IFNDEF NO_CAIWII}
    // Compruebo que este correo no este ya registrado
    {$IFNDEF SINCRONIZAR}
    if not UniMainModule.ADConexionCAI.Connected then
    begin
      UniMainModule.ADConexionCAI.Params.Values['DATABASE']:=IncludeTrailingPathDelimiter(UniServerModule.RutaBD)+'caisistemas.GDB';
      UniMainModule.ADConexionCAI.Connected:=True;
    end;
    with ConsultaAD(UniMainModule.ADConexionCAI,'SELECT EMAIL FROM REGISTRADOS WHERE UPPER(EMAIL)='+QuotedStr(UpperCase(Value))) do
      try
        if not IsEmpty then
          Result:=False;
      finally
        Free;
      end;
    {$ENDIF}
    {$ENDIF}
  end;
end;
//>Para utilizarla basta con:
//  if emailValido ('ajpdsoft@ajpdsoft.com') then
//    showmessage('El E-Mail es correcto')
//  else
//    showmessage('El E-Mail NO es correcto');
//end;
{$ENDIF}

function  PAD(pcampo: string; pcuanto: integer; pcon: string; pdonde: string): string;
var
  lreturn: String;
  lsw    : Integer;
  ltamano: Integer;
  ldifer : Integer;
  lderec : Integer;
  lizqui : Integer;
begin

  ltamano := Length(pcampo);
  ldifer  := pcuanto - ltamano;

  if ltamano >= pcuanto then
     begin
        for lsw := 1 to pcuanto do
           lreturn := lreturn + pcampo[lsw];

        Result := lreturn;
     end
  else begin

// Rellenar por la derecha

     if pdonde = 'D' then begin
        lreturn := pcampo;

        for lsw := 1 to ldifer do
           lreturn := lreturn + pcon;
     end;

// Rellenar por la izquierda

     if pdonde = 'I' then begin
        for lsw := 1 to ldifer do
           lreturn := lreturn + pcon;

        lreturn := lreturn + pcampo
     end;

// Centrar el texto

     if pdonde = 'C' then begin
        lderec := ldifer div 2;
        lizqui := ldifer div 2;

        // Rellenar por la izquierda

        for lsw := 1 to lderec do
           lreturn := lreturn + pcon;

        lreturn := lreturn + pcampo;

        // Rellenar por la derecha

        for lsw := 1 to lizqui do
           lreturn := lreturn + pcon;
     end;

     Result := lreturn;
  end;
end;

function GeneraClave(Codigo: integer): string;
function  Round_Contable(pvalor : Double) : Int64;
begin
   Result := StrToInt(FormatFloat('0.',pvalor));
end;
var
   loDigito1: string;
   loDigito2: string;
   loDigito3: string;
   loDigito4: string;
   loCombina: string;
   loSw1:     integer;
   loSw2:     integer;
   loSw3:     integer;
   loTabla:   array [1..26] of string;
   loCodigo:  Double;
begin

   // 26 elementos que me dan 676 variaciones con repeticion

   loTabla[01] := 'A';
   loTabla[02] := 'B';
   loTabla[03] := 'C';
   loTabla[04] := 'D';
   loTabla[05] := 'E';
   loTabla[06] := 'F';
   loTabla[07] := 'G';
   loTabla[08] := 'H';
   loTabla[09] := 'I';
   loTabla[10] := 'J';
   loTabla[11] := 'K';
   loTabla[12] := 'L';
   loTabla[13] := 'M';
   loTabla[14] := 'N';
   loTabla[15] := 'O';
   loTabla[16] := 'P';
   loTabla[17] := 'Q';
   loTabla[18] := 'R';
   loTabla[19] := 'S';
   loTabla[20] := 'T';
   loTabla[21] := 'U';
   loTabla[22] := 'V';
   loTabla[23] := 'W';
   loTabla[24] := 'X';
   loTabla[25] := 'Y';
   loTabla[26] := 'Z';

   // CLAVE = digito1 + digito2 + digito3 + digito4 + digito5 + digito6
   // dado el numero de empresa "1234"

   // donde digito1 es el £ltimo    digito del numero de empresa
   // donde digito2 es el pen£ltimo digito del numero de empresa
   // donde digito3 es el segundo   digito del numero de empresa
   // donde digito4 es el primer    digito del numero de empresa

   // o sea "4321" lo invierto para que me de numero mayores
   // el digito5 y digito6 lo quito de la tabla de combinaciones

   loSw3    := 0;
   loCodigo := Codigo;

   while loCodigo > 676 do
      loCodigo := Round_Contable(loCodigo) / 2;

   for loSw1 := 1 to High(loTabla) do begin
      for loSw2 := 1 To High(loTabla) do begin
         loCombina := loTabla[loSw1] + loTabla[loSw2];
         Inc(loSw3);

         if loSw3 = loCodigo then
            Break;
       end;

       if loSw3 = loCodigo then
          Break;
   end;

   loDigito1 := Copy(PAD(IntToStr(Codigo),4,'0','I'),4,1);
   loDigito2 := Copy(PAD(IntToStr(Codigo),4,'0','I'),3,1);
   loDigito3 := Copy(PAD(IntToStr(Codigo),4,'0','I'),2,1);
   loDigito4 := Copy(PAD(IntToStr(Codigo),4,'0','I'),1,1);

   Result := loDigito1 + loDigito2 + loCombina + loDigito3 + loDigito4;
end;

function Encriptar(Cadena,Clave:String):String;
begin
  with TJvVigenereCipher.Create(nil) do
    try
      result:=EncodeString(Clave,Cadena);
    finally
      Free;
    end;
end;


function Desencriptar(Cadena,Clave:String):String;
begin
  with TJvVigenereCipher.Create(nil) do
    try
      result:=DecodeString(Clave,Cadena);
    finally
      Free;
    end;
end;

function EsNumero(Cuenta:String):boolean;
var
  i:Integer;
begin
  if Length(Cuenta)=0 then
    result:=False
  else begin
    i:=1;
    while (i<=Length(Cuenta)) and (Cuenta[i] in ['0'..'9']) do Inc(i);
    result:=i>Length(Cuenta);
  end;
end;

procedure SiguienteLibre(Grid:TUniDBGridH;Append:Boolean);
var
  i:Integer;
begin
  i:=Grid.CurrCol;
  while (i<Grid.Columns.Count) and Grid.Columns.Items[i].ReadOnly do Inc(i);
  if i=Grid.Columns.Count then
  begin
    if Grid.DataSource.DataSet.RecNo=Grid.DataSource.DataSet.RecordCount then
    begin
      if Append then
        Grid.DataSource.DataSet.Append
    end
    else
      Grid.DataSource.DataSet.Next;
    i:=0;
    while (i<Grid.Columns.Count) and Grid.Columns.Items[i].ReadOnly do Inc(i);
  end;
  Grid.SetCurrCol(i);
end;

function IndiceCampo(Grid:TUniDBGrid;Campo:TField):integer;
begin
  Result:=0;
  while (result<Grid.Columns.Count) and (Grid.Columns.Items[result].Field<>Campo) do Inc(Result);
  if Result=Grid.Columns.Count then Result:=-1;
end;

function  DosDecimales(Valor:extended): currency;
begin
  Result:=StrToCurr(FormatFloat('0.00',Valor));
end;


procedure ActualizaDSGrid(Grid:TUniDBGrid);
var
  DS:TDataSource;
begin
  DS:=Grid.DataSource;
  Grid.DataSource:=nil;
  Grid.DataSource:=DS;
end;

function ClientDataSet(Conexion:TFDConnection;Consulta:string;CDS:TFDQuery=nil):TFDQuery;
var
  Query:TFDQuery;
begin
  Result:=TFDQuery.Create(nil);
  with Result do
  begin
    Connection := Conexion;
    SQL.Text:=Consulta;
    Result.Open;
  end;
end;


{$IFNDEF SIN_GENERAL}
function PaisesIntraComunitarios:string;
begin
  {$IFNDEF SINCRONIZAR}
//   result:='''FR'',''NL'',''DE'',''IT'',''UK'',''IE'',''DK'',''GR'',''PT'',''BE'',''LU'',''SE'',''FI'',''AT'',''MT'',''EE'',''LV'',''LT'',''PL'',''CZ'',''SK'',''HU'',''RO'',''BG'',''SI'',''HR'',''CY'''
  result:='';
  with ConsultaAD(UniMainModule.ADConexionGeneral,'SELECT CLAVE FROM PAISES WHERE INTRACOM='+QuotedStr('SI')) do
    try
      while not Eof do
      begin
        result:=result+','+QuotedStr(FieldByName('CLAVE').AsString);
        Next;
      end;
    finally
      Free;
    end;
  if copy(result,1,1)=',' then delete(result,1,1);


 {$ENDIF}

end;
{$ENDIF}

function CDSRemoto(URL,NombreProveedor,Consulta:String;Owner:TComponent=nil):TClientDataset;
var
  SC:TSoapConnection;
begin

  SC:=TSoapConnection.Create(nil);
  try
    SC.UseSOAPAdapter:=False;
    SC.URL:=URL;
    SC.Connected:=True;
    SC.RIO.HTTPWebNode.OnBeforePost:=TDummyClass.HTTPRIOHTTPWebNodeBeforePost;
    result:=TClientDataset.Create(Owner);
    with result do
    begin
      RemoteServer:=SC;
      ProviderName:=NombreProveedor;
      CommandText:=Consulta;
      Open;
    end;
    SC.Connected:=False;
  finally
    FreeAndNil(SC);
    GetFormatSettings;
  end;
end;

procedure ModificaBDRemota(Servidor:string;RutaBD:string;Consulta:String);
begin
 {$IFNDEF SINCRONIZAR}
  try
    GetIFunciones.EjecutaSQL(Servidor,RutaBD,Consulta);
  except
    UniServerModule.Logger.AddLog('Error en sentencia remota:'+#13#10+
                                  Consulta);
  end;
 {$ENDIF}
end;

procedure MessageDlg(const Msg:String;DlgType:TMsgDlgType; Buttons:TMsgDlgButtons;Callback:TUniDialogCallBackAnonProc;Titulo:String);
begin
  uniGUIDialogs.MessageDlg('&#32;'+Msg,DlgType,Buttons,CallBack);
  {$IFNDEF SINCRONIZAR}

  if UniServerModule.ExtJSVersion[1]<>'4' then
    UniSession.AddJS('$("div#messagebox-1001_header-title-textEl").html("'+Titulo+'");')
  else
    UniSession.AddJS('$("span#messagebox-1001_header_hd-textEl").html("'+Titulo+'");')
 {$ENDIF}

end;

procedure CambiaBlancoPorCero(Control:TUniControl);
var
  EventoCero,NombreCampo:String;
begin
  if Control.ClassType=TUniDBEdit then NombreCampo:=TUniDBEdit(Control).DataField
  else if Control.ClassType=TUniDBFormattedNumberEdit then NombreCampo:=TUniDBFormattedNumberEdit(Control).DataField
  else if Control.ClassType=TUniDBDateTimePicker then NombreCampo:=TUniDBDateTimePicker(Control).DataField
  else if Control.ClassType=TUniDBMemo then NombreCampo:=TUniDBMemo(Control).DataField
  else if Control.ClassType=TUniEdit then NombreCampo:=''
  else if Control.ClassType=TUniFormattedNumberEdit then NombreCampo:='';
  EventoCero:='function change(sender, newValue, oldValue, eOpts){'+#13+
          'if (newValue=='''') then newValue=''0'';}';

  if Control.ClassType=TUniDBEdit then
  begin
    TUniDBEdit(Control).ClientEvents.ExtEvents.Values['change']:=EventoCero;
  end
  else if Control.ClassType=TUniDBFormattedNumberEdit then
  begin
    TUniDBFormattedNumberEdit(Control).ClientEvents.ExtEvents.Values['change']:=EventoCero;
  end
  else if Control.ClassType=TUniDBDateTimePicker then
  begin
    TUniDBDateTimePicker(Control).ClientEvents.ExtEvents.Values['change']:=EventoCero;
  end
  else if Control.ClassType=TUniDBMemo then
  begin
    TUniDBMemo(Control).ClientEvents.ExtEvents.Values['change']:=EventoCero;
  end
  else if Control.ClassType=TUniEdit then
  begin
    TUniEdit(Control).ClientEvents.ExtEvents.Values['change']:=EventoCero;
  end
  else if Control.ClassType=TUniFormattedNumberEdit then
  begin
    TUniFormattedNumberEdit(Control).ClientEvents.ExtEvents.Values['change']:=EventoCero;
  end;
end;

procedure AsignaCambioDBEdit(Control:TUniControl);
var
  EventoFocus,EventoBlur,EventoChange,NombreCampo:String;
begin
  NombreCampo:='';
  if Control.ClassType=TUniDBEdit then NombreCampo:=TUniDBEdit(Control).DataField
  else if Control.ClassType=TUniDBFormattedNumberEdit then NombreCampo:=TUniDBFormattedNumberEdit(Control).DataField
  else if Control.ClassType=TUniDBDateTimePicker then NombreCampo:=TUniDBDateTimePicker(Control).DataField
  else if Control.ClassType=TUniDBMemo then NombreCampo:=TUniDBMemo(Control).DataField
  else if Control.ClassType=TUniDateTimePicker then NombreCampo:=''
  else if Control.ClassType=TUniEdit then NombreCampo:=''
  else if Control.ClassType=TUniFormattedNumberEdit then NombreCampo:=''
  else if Control.ClassType=TUniDBLookupComboBox then NombreCampo:=TUniDBEdit(Control).DataField;

  EventoChange:='function change(sender, newValue, oldValue, eOpts){if (sender.controlaCambio==false){sender.controlaCambio=true;}}';
  EventoFocus:='function focus(sender, the, eOpts){'+#13+
               '  sender.oldValue=sender.'+IfThen(Control.ClassType=TUniDateTimePicker,'getRawValue()','getValue()')+';'+#13+
               '  sender.controlaCambio=false;'+#13+
               '}';
  EventoBlur:='function blur(sender, the, eOpts){'+#13+
              '  if ((sender.controlaCambio==true) && (sender.oldValue!=sender.'+IfThen(Control.ClassType=TUniDBDateTimePicker,'getRawValue()','getValue()')+')){'+#13+
              '    ajaxRequest(sender,''GENERA_CAMBIO'',[''campo='+NombreCampo+''',''anterior=''+sender.oldValue,''actual=''+sender.'+IfThen(Control.ClassType=TUniDBDateTimePicker,'getRawValue()','getValue()')+']);'+#13+
              '  }'+#13+
              '}';
  if Control.ClassType=TUniDBEdit then
  begin
    TUniDBEdit(Control).ClientEvents.ExtEvents.Values['focus']:=EventoFocus;
    TUniDBEdit(Control).ClientEvents.ExtEvents.Values['blur']:=EventoBlur;
    TUniDBEdit(Control).ClientEvents.ExtEvents.Values['change']:=EventoChange;
  end
  else if Control.ClassType=TUniDBFormattedNumberEdit then
  begin
    TUniDBFormattedNumberEdit(Control).ClientEvents.ExtEvents.Values['focus']:=EventoFocus;
    TUniDBFormattedNumberEdit(Control).ClientEvents.ExtEvents.Values['blur']:=EventoBlur;
    TUniDBFormattedNumberEdit(Control).ClientEvents.ExtEvents.Values['change']:=EventoChange;
  end
  else if Control.ClassType=TUniDBDateTimePicker then
  begin
    TUniDBDateTimePicker(Control).ClientEvents.ExtEvents.Values['focus']:=EventoFocus;
    TUniDBDateTimePicker(Control).ClientEvents.ExtEvents.Values['blur']:=EventoBlur;
    TUniDBDateTimePicker(Control).ClientEvents.ExtEvents.Values['change']:=EventoChange;
  end
  else if Control.ClassType=TUniDBMemo then
  begin
    TUniDBMemo(Control).ClientEvents.ExtEvents.Values['focus']:=EventoFocus;
    TUniDBMemo(Control).ClientEvents.ExtEvents.Values['blur']:=EventoBlur;
    TUniDBMemo(Control).ClientEvents.ExtEvents.Values['change']:=EventoChange;
  end
  else if Control.ClassType=TUniEdit then
  begin
    TUniEdit(Control).ClientEvents.ExtEvents.Values['focus']:=EventoFocus;
    TUniEdit(Control).ClientEvents.ExtEvents.Values['blur']:=EventoBlur;
    TUniEdit(Control).ClientEvents.ExtEvents.Values['change']:=EventoChange;
  end
  else if Control.ClassType=TUniDateTimePicker then
  begin
    TUniDateTimePicker(Control).ClientEvents.ExtEvents.Values['focus']:=EventoFocus;
    TUniDateTimePicker(Control).ClientEvents.ExtEvents.Values['blur']:=EventoBlur;
    TUniDateTimePicker(Control).ClientEvents.ExtEvents.Values['change']:=EventoChange;
  end
  else if Control.ClassType=TUniFormattedNumberEdit then
  begin
    TUniFormattedNumberEdit(Control).ClientEvents.ExtEvents.Values['focus']:=EventoFocus;
    TUniFormattedNumberEdit(Control).ClientEvents.ExtEvents.Values['blur']:=EventoBlur;
    TUniFormattedNumberEdit(Control).ClientEvents.ExtEvents.Values['change']:=EventoChange;
  end
  else if Control.ClassType=TUniDBLookupComboBox then
  begin
    TUniDBLookupComboBox(Control).ClientEvents.ExtEvents.Values['focus']:=EventoFocus;
    TUniDBLookupComboBox(Control).ClientEvents.ExtEvents.Values['blur']:=EventoBlur;
    TUniDBLookupComboBox(Control).ClientEvents.ExtEvents.Values['change']:=EventoChange;
  end
end;

function LanzaCambio(Sender: TComponent;EventName: string; Params: TStrings;Mensaje:String=''):boolean;
var
  Cadena:String;
begin
  result:=SameText(EventName,'GENERA_CAMBIO');
  if result then
    UniSession.AddJS(IfThen(Mensaje='','',Sender.Owner.Name+'.form.showMask('+QuotedStr(Mensaje)+');')+#13+
                     'ajaxRequest('+TUniControl(Sender).JSName+',''CAMBIO'',[''campo='+params.Values['campo']+''',''anterior='+PChar(Params.Values['anterior'])+''',''actual='+PChar(Params.Values['actual'])+''']);');
end;

function TextoAReal(Texto:String):real;
begin
  Result:=StrToFloatDef(ReplaceText(Texto,'.',','),0);
//  result:=StrToFloatDef(ReplaceText(ReplaceText(copy(Texto,1,Length(Texto)-3),',',''),'.','')+','+copy(Texto,Length(Texto)-1,2),0);
end;

{*******************************************************************************
  Funcion que se le pasa DataSets y sobre los cuales se hace una sentencia SQL (a traves de SQLLite)

  NOTAs Importantes :
  - Parece que alguna tabla de Tablas esta vacia (sin registros) da una excepcion chunga
  - Se hace sobre los registros visibles, es decir si tiene filter o mastersource... se ve afectado
*******************************************************************************}
function SQLsobreClientDataSets( Tablas : array of TDataSet; sSQL : String) : TFDQuery;
var
  ADConexioLocal: TFDConnection;
  ADLocalSQL1: TFDLocalSQL;
  i : Integer;
begin
  Result := TFDQuery.Create(nil);
  ADConexioLocal := TFDConnection.Create(Result);
  ADLocalSQL1 := TFDLocalSQL.Create(Result);
  // Preparamos conexión
  with ADConexioLocal do
  begin
    Name := 'ADConexioLocal';
    Params.Clear;
    Params.Add('DriverID=SQLite');
    with FormatOptions.MapRules.Add do begin
      SourceDataType := dtAnsiString;
      TargetDataType := dtAnsiString;
    end;
    LoginPrompt := False;
  end;
  // Asociamos DataSets a ADLocalSQL
  with ADLocalSQL1 do
  begin
    Name := 'ADLocalSQL1';
    Connection := ADConexioLocal;
    for I := Low(Tablas) to High(Tablas) do
      with DataSets.Add do begin
        DataSet := TFDMemTable.Create(ADConexioLocal);
        TFDMemTable(DataSet).Name := Tablas[i].Name;
        TFDMemTable(DataSet).CopyDataSet(Tablas[i], [coStructure, coRestart, coAppend]);
        Name := Tablas[i].Name;
      end;
    ADConexioLocal.Connected := True;
    Active := True;
  end;
  // Ejecutamos Sentencia SQL
  with Result do
  begin
    Connection := ADConexioLocal;
    SQL.Clear;
    Result.Open(sSQL);
  end;
end;

function SHA1(const AString: string): string;
begin
  with TIdHashSHA1.Create do
    try
      result:=HashStringAsHEX(AString);
    finally
      Free;
    end;
  {with TWebPost.Create(nil) do
    try
      Server:='www.caisistemas.es';
      Action:='/sha1.php';
      with Items.Add do
      begin
        Name:='cadena';
        value:=AString;
      end;
      if Execute then
        result:=PostResult;
    finally
      Free;
    end;  }
end;

function ClientDataset2(Conexion:TFDConnection;Consulta:String;CDS:TClientDataset=nil;Owner:TComponent=nil;NingunoSoloLectura:Boolean=False):TCLientDataset;
var
  Query:TFDQuery;
  DSP:TDataSetProvider;
  i:Integer;
begin
  {$IFNDEF SINCRONIZAR}
  try
    Query:=TFDQuery.Create(nil);
    try
      Query.FetchOptions.Unidirectional:=True;
      Query.Connection:=Conexion;
//      Query.SQL.Text:=Consulta;
      Query.Open(Consulta);
      if NingunoSoloLectura then
        for i:=0 to Query.Fields.Count-1 do
        begin
          Query.Fields[i].ProviderFlags:=Query.Fields[i].ProviderFlags+[pfInUpdate];
          Query.Fields[i].ReadOnly:=False;
        end;
      DSP:=TDataSetProvider.Create(nil);
      try
        DSP.DataSet:=Query;
        if CDS=nil then
          Result:=TClientDataset.Create(Owner)
        else
          Result:=CDS;
        Result.SetProvider(DSP);
        try
          Result.Open;
        except
          FreeAndNil(Result);
        end;
      finally
        FreeAndNil(DSP);
      end;
    finally
      FreeAndNil(Query);
    end;
  except
    UniServerModule.Logger.AddLog(Consulta);
    Raise;
  end;
  {$ENDIF}
end;

function Borrarcarpeta(Carpeta:String;BorrarRaiz:boolean):Boolean;
var
  DirInfo: TSearchRec;
  r : Integer;
begin
  if DirectoryExists(Carpeta) then begin
    Carpeta:=trim(Carpeta);
    if Carpeta[length(carpeta)]='\' then delete(carpeta,length(carpeta),1);
    r := FindFirst(Carpeta+'\*.*',FaAnyfile,DirInfo);
    while r = 0 do  begin
      if DirInfo.Attr=FaDirectory then begin
        if (Trim(DirInfo.Name)<>'.') and (Trim(DirInfo.Name)<>'..') then BorrarCarpeta(Carpeta+'\'+DirInfo.Name)
      end else DeleteFile(pChar(Carpeta+'\'+DirInfo.Name));
      r := FindNext(DirInfo);
    end;
    SysUtils.FindClose(DirInfo);
    if BorrarRaiz then
      result:=RemoveDirectory(PChar(Carpeta))=true
    else
      result:=True;
  end else
    result:=False;
end;


procedure DescomprimirCarpeta(Carpeta,NombreArchivo,Contrasenha:String);
begin
  {$IFNDEF SINCRONIZAR}
  with TAbUnZipper.Create(nil) do
    try
      TempDirectory:=UniServerModule.LocalCachePath;
      Password:=Contrasenha;
      FileName:=NombreArchivo;
      ExtractOptions:=[eoCreateDirs,eoRestorePath];
      BaseDirectory:=Carpeta;
      ExtractFiles('*');
    finally
      Free;
    end;
  DeleteFile(NombreArchivo);
 {$ENDIF}
end;

function DescomprimirContrasenaValida(NombreArchivo,Contrasenha:String): Boolean;
begin
  Result := False;
  {$IFNDEF SINCRONIZAR}
  with TAbUnZipper.Create(nil) do
    try
      try
        TempDirectory:=UniServerModule.LocalCachePath;
        Password:=Contrasenha;
        FileName:=NombreArchivo;
        TagItems(Items[0].FileName);
        TestTaggedItems;
        Result := True;
      except
        Result := False;
      end;
    finally
      Free;
    end;
 {$ENDIF}
end;


procedure ComprimirCarpeta(Carpeta,NombreArchivo,Contrasenha:String;Mover:Boolean=True;Destino:String='*');
begin
  if DirectoryExists(Carpeta) then
    with TAbZipper.Create(nil) do
      try
        FileName:=NombreArchivo;
        Password:=Contrasenha;
        StoreOptions:=StoreOptions+[soRecurse];
        DeflationOption:=doMaximum;
        FArchive.BaseDirectory:=IncludeTrailingPathDelimiter(Carpeta);
        AddFiles(Destino,faAnyFile);
//        if Mover then Borrarcarpeta(Carpeta);
        CloseArchive;
        if Mover then Borrarcarpeta(Carpeta);
      finally
        Free;
      end;
end;

procedure DescargarArchivoFTP(Servidor,Usuario,Contrasena,Ruta1,Ruta2:String);
begin
  with TIdFTP.Create(nil) do
    try
      DataPort := 21;
      UseExtensionDataPort := True;
      UserName:=Usuario;
      Password:=Contrasena;
      Host:=Servidor;
      Passive:=True;
      TransferType:=IdFTPCommon.TIdFTPTransferType.ftBinary;
      Connect;
      try
        Get(Ruta1,Ruta2,True,True);
      finally
        Disconnect;
      end;
    finally
      Free;
    end;
end;


function GeneraADQuery(query:TDataset;Conexion:TFDConnection;Tabla:string;Evitar:String='';Campos:String='';Valores:String=''):TFDQuery;
var
  CamposAEvitar:TFDQuery;
  ConsultaSQL:String;
  i:integer;
begin
  result:=TFDQuery.Create(nil);
  with result do
  begin
    result.FormatOptions.StrsEmpty2Null:=False;
    Connection:=Conexion;
    ConsultaSQL:='SELECT RDB$RELATION_FIELDS.RDB$FIELD_NAME CAMPO FROM RDB$FIELDS INNER JOIN RDB$RELATION_FIELDS ON (RDB$FIELDS.RDB$FIELD_NAME=RDB$RELATION_FIELDS.RDB$FIELD_SOURCE) WHERE RDB$COMPUTED_SOURCE IS NOT NULL AND RDB$RELATION_NAME=UPPER('+QuotedStr(Tabla)+')';
    try
      with TStringList.Create do
        try
          StrictDelimiter:=True;
          Delimiter:=';';
          DelimitedText:=UpperCase(Evitar);
          while Count>0 do
          begin
            if trim(Strings[0])<>'' then
              ConsultaSQL:=ConsultaSQL+' UNION SELECT '+QuotedStr(Strings[0])+' FROM RDB$DATABASE';
            Delete(0);
          end;
        finally
          Free;
        end;
//      if EvitarListaDeCampos<>'' then
//        ConsultaSQL:=ConsultaSQL+' UNION '+EvitarListaDeCampos
      CamposAEvitar:=ConsultaAD(Conexion,ConsultaSQL,False);
      for i:=0 to query.Fields.Count-1 do
        if not CamposAEvitar.Locate('CAMPO',VarArrayOf([query.Fields.Fields[i].FieldName]),[]) then
        begin
          Campos:=Campos+IfThen(Campos='','',',')+query.Fields.Fields[i].FieldName;
          Valores:=Valores+IfThen(Valores='','',',')+':'+query.Fields.Fields[i].FieldName;
          if query.Fields.Fields[i].Tag=777 then
            Params.CreateParam(ftBlob,query.Fields.Fields[i].FieldName,ptInput)
          else
            Params.CreateParam(query.Fields.Fields[i].DataType,query.Fields.Fields[i].FieldName,ptInput);
          if query.Fields.Fields[i].DataType=ftString then
            Params.Items[Params.Count-1].Size:=query.Fields.Fields[i].Size;
        end;
      result.SQL.Text:='INSERT INTO '+Tabla+'('+Campos+') VALUES('+Valores+')';
    finally
      FreeAndNil(CamposAEvitar);
    end;
  end;
  result.Prepare;
end;

procedure IniciaParametrosAD(DSOrigen:TDataset;QueryDestino:TFDQuery;Indice:Integer=0;ParametrosAInicializar:String='';ValoresIniciales:String='');
var
  i:integer;
  Stream:TMemoryStream;
  Parametros,Valores:TStringList;
begin
  if Trim(ParametrosAInicializar)<>'' then
  begin
    Parametros:=TStringList.Create;
    Parametros.StrictDelimiter:=True;
    Parametros.Delimiter:=';';
    Parametros.DelimitedText:=UpperCase(ParametrosAInicializar);
    Valores:=TStringList.Create;
    Valores.StrictDelimiter:=True;
    Valores.Delimiter:=';';
    Valores.DelimitedText:=UpperCase(ValoresIniciales);
  end;
  try
    for i:=0 to QueryDestino.Params.Count-1 do
      if assigned(Parametros) and (Parametros.IndexOf(QueryDestino.Params.Items[i].Name)<>-1) then
      begin
        if Sametext(Valores.Strings[Parametros.IndexOf(QueryDestino.Params.Items[i].Name)],'null') then
          QueryDestino.Params.Items[i].Clear
        Else
         QueryDestino.Params.Items[i].Values[indice]:=Valores.Strings[Parametros.IndexOf(QueryDestino.Params.Items[i].Name)]
      end
      else begin
        if QueryDestino.Params.Items[i].DataType=ftBlob then
        begin
          Stream:=TMemoryStream(DSOrigen.CreateBlobStream(DSOrigen.FieldByName(QueryDestino.Params.Items[i].Name),bmRead));
          try
            QueryDestino.Params.Items[i].LoadFromStream(Stream,ftBlob,Indice);
          finally
            FreeAndNil(Stream);
          end;
        end
        else
          QueryDestino.Params.Items[i].Values[indice]:=DSOrigen.FieldByName(QueryDestino.Params.Items[i].Name).Value;
      end;
  finally
    if assigned(Parametros) then
    begin
      Parametros.Clear;
      FreeAndNil(Parametros);
    end;
    if assigned(Valores) then
    begin
      Valores.Clear;
      FreeAndNil(Valores);
    end;
  end;
end;

function DameCadenaSql(query : TDataset; tabla,id : string;
          vid : integer; evitar : string; scambiar : string; vcambio : integer) : string;
begin
  Result := 'INSERT INTO ' + tabla + '('+DameCamposParaInsert(query,evitar)+')'+
            'VALUES ('+DameValoresParaInsert(query,tabla,id,vid,evitar,scambiar,vcambio)+')';
end;

function DameCamposParaInsert(query : TDataset;evitar : string = '') : string;
var
  i:integer;
begin
  result:='';
  With query do
    // copio todos los campos
    For i := 0 to FieldCount - 1 do
      IF (evitar = '') or not (SameText(evitar,Fields[i].FieldName)) then Result := Result + Fields[i].FieldName + ',';
  System.Delete(Result,Length(Result),1);
end;

function DameValoresParaInsert(query : TDataset; tabla,id : string; vid : integer;
        evitar : string = ''; scambiar : string = ''; vcambio : integer = 0) : string;
var
  posi,i : integer;
  aux: string;
begin
  result:='';
  with Query do
  begin
    For i := 0 to FieldCount - 1 do
    begin
      IF SameText(Fields[i].FieldName,id) then
        Result := Result + IntToStr(vid) + ','
      Else begin
        IF (evitar <> '') and SameText(evitar,Fields[i].FieldName) then
          Continue
        Else IF (scambiar <> '') and SameText(scambiar,Fields[i].FieldName) then
          Result := Result + IntToStr(vcambio) + ','
        Else begin
          // copio todos los campos que coincidan excepto el id de ficha
          // que ya lo tiene asignado
          IF Fields[i].IsNull then
            Result := Result + 'NULL,'
          Else begin
            Case Fields[i].DataType of
              ftBlob:Result:=Result+QuotedStr(Fields[i].AsString)+',';
              ftString,ftFixedChar, ftWideString, ftMemo, ftFmtMemo:begin
                                                                      // Quito los caracteres que no nos interesan
                                                                      aux := replaceText(replaceText(replaceText(Fields[i].AsString,'`',''),'"',''),'''','');
                                                                      Result := Result + 'CAST(SUBSTRING('+QuotedStr(aux)+' FROM 1 FOR '+IntToStr(Fields.Fields[i].Size)+') AS VARCHAR('+IntToStr(Fields.Fields[i].Size)+')),';
                                                                    end;
              ftSmallint, ftInteger, ftWord,ftLargeint:Result := Result + IntToStr(Fields[i].AsInteger) + ',';
              ftFloat,ftCurrency, ftBCD, ftFMTBcd:begin
                                                    Result := Result + FirebirdFloat(Fields[i].AsCurrency) + ',';
                                                  end;
              ftDate, ftDateTime,ftTimeStamp :Result := Result + QuotedStr(FormatDateTime('mm/dd/yyyy',Fields[i].AsDateTime)) + ',';
              ftTime:Result:=Result + QuotedStr(FormatDateTime('HH:mm:ss',Fields[i].AsDateTime)) + ',';
              end;
          end;
        end;
      end;
    end;
  end;
  System.Delete(Result,Length(Result),1);
end;

procedure CopiaCarpeta(Origen,Destino:String;Mover:Boolean);
var
  F:TSearchRec;
begin
  ForceDirectories(IncludeTrailingPathDelimiter(Destino));
  if FindFirst(IncludeTrailingPathDelimiter(Origen)+'*',faAnyFile,F)=0 then
  begin
    repeat
      if F.Attr and faDirectory=faDirectory then
      begin
        if (F.Name<>'.') and (F.Name<>'..') then CopiaCarpeta(IncludeTrailingPathDelimiter(Origen)+F.Name,
                                                              IncludeTrailingPathDelimiter(Destino)+F.Name,Mover);
      end
      else begin
        if Mover then
          RenameFile(PChar(IncludeTrailingPathDelimiter(Origen)+F.Name),PChar(IncludeTrailingPathDelimiter(Destino)+F.Name))
        else
          CopyFile(PChar(IncludeTrailingPathDelimiter(Origen)+F.Name),PChar(IncludeTrailingPathDelimiter(Destino)+F.Name),False);
      end;
    until FindNext(F)<>0;
    SysUtils.FindClose(F);
  end;
end;

function NumeroRegistros(Query:TFDQuery;MacrosNulas:String): Integer;
var
  i:integer;
  Macro:TFDMacro;
begin
  with TFDQuery.Create(nil) do
    try
      FormatOptions.StrsEmpty2Null:=False;
      Connection:=Query.Connection;
      Transaction:=Query.Transaction;
      SQL.Text:='SELECT COUNT(*) FROM ('+Query.SQL.Text+')';
      for i:=0 to Query.MacroCount-1 do
        MacroByName(Query.Macros.Items[i].Name).Value:=Query.Macros.Items[i].Value;
      for i:=0 to Query.ParamCount-1 do
        ParamByName(Query.Params.Items[i].Name).Value:=Query.Params.Items[i].Value;
      with TStringList.Create do
        try
          CommaText:=MacrosNulas;
          for i:=0 to Count-1 do
          begin
            Macro:=FindMacro(Strings[i]);
            if Assigned(Macro) then Macro.Clear;
          end;
        finally
          Free;
        end;
      Open;
      result:=Fields.Fields[0].AsInteger;
    finally
      Free;
    end;
end;

procedure MonitorizarTeclas(F:TUniForm;a:Array Of Integer;HB:Boolean);
var
  i:Integer;
begin
  F.MonitoredKeys.Enabled:=True;
  F.MonitoredKeys.KeyHandleAll:=False;
  for i:=0 to length(a)-1 do
    with F.MonitoredKeys.Keys do
      with TUniMonitoredKeyItem(Add) do
      begin
        KeyStart:=a[i];
        KeyEnd:=a[i];
        HandleBrowser:=HB;
      end;
end;

procedure MonitorizarTeclas(F:TUniForm;a:Array Of Char;HB:Boolean);Overload;
var
  i:Integer;
begin
  for i:=0 to length(a)-1 do
    with F.MonitoredKeys.Keys do
      with TUniMonitoredKeyItem(Add) do
      begin
        CharStart:=a[i];
        CharEnd:=a[i];
        HandleBrowser:=HB;
      end;

end;

procedure MonitorizarTeclas(COntrol:TUniControl;a:Array Of Integer;HB:Boolean);
var
  keydown:String;
  i:integer;
begin
  keydown:='';
  for i:=0 to length(a)-1 do
    keydown:=keydown+IfThen(KeyDown='','','||')+'(e.getKey()=='+IntToStr(a[i])+')';
  keydown:='function keydown(sender, e, eOpts)'+#13+
           '{'+#13+
           '  if ('+keydown+'){'+#13+
           '    ajaxRequest(sender,''TECLA_PULSADA'','+#13+
           '                [''tecla=''+e.getKey(),'+#13+
           '                 ''shift=''+e.shiftKey,'+#13+
           '                 ''control=''+e.ctrlKey,'+#13+
           '                 ''alt=''+e.altKey]);'+#13+
           IfThen(HB,'','    e.preventDefault();'+#13)+
           '  }'+#13+
           '}';
  if Control.ClassType=TUniDBEdit then
    TUniDBEdit(Control).ClientEvents.ExtEvents.Values['keydown']:=keydown
  else if Control.ClassType=TUniEdit then
    TUniEdit(Control).ClientEvents.ExtEvents.Values['keydown']:=keydown
  else if Control.ClassType=TUniDBFormattedNumberEdit then
    TUniDBFormattedNumberEdit(Control).ClientEvents.ExtEvents.Values['keydown']:=keydown
  else if Control.ClassType=TUniDBLookupComboBox then
    TUniDBLookupComboBox(Control).ClientEvents.ExtEvents.Values['keydown']:=keydown
  else if Control.ClassType=TUniForm then
    TUniForm(Control).ClientEvents.ExtEvents.Values['keydown']:=keydown
end;

function IndiceNodo(Nodo:TUniTreeNode;Arbol:TUniTreeView):Integer;
begin
  Result:=0;
  while (Result<Arbol.Items.Count) and (Arbol.Items.Item[Result]<>Nodo) do Inc(result);
  if Arbol.Items.Count=Result then Result:=-1;
end;

function ValorTablaLookUp(Tabla:TFDDataSet;CampoLookUp,CampoResultado:String;Valor:Variant):Variant;
begin
  with TFDMemTable.Create(nil) do
    try
      CloneCursor(Tabla);
      if Locate(CampoLookUp,VarArrayOf([Valor]),[]) then
        result:=FieldByName(CampoResultado).Value
      else
        result:=Unassigned
    finally
      Free;
    end;
end;

procedure InicializaRadioGroup(RG:TUniRadioGroup;Valor:String;a:Array of String);
var
  i:Integer;
begin
  i:=0;
  while (i<Length(a)) and not SameText(Valor,a[i]) do Inc(i);
  RG.ItemIndex:=IfThen(i=Length(a),-1,i);
end;

function ActualizaCampoRadioGroup(RG:TUniRadioGroup;Campo:TField;a:Array of String):boolean;
begin
  Result:=Campo.DataSet.State in dsEditModes;
  if Result then
    Campo.AsString:=a[RG.ItemIndex]
  else
    InicializaRadioGroup(RG,Campo.AsString,a);
end;

function ADCodigosSEPA:TFDMemTable;
begin
  Result:=TFDMemTable.Create(nil);
  with Result do
  begin
    FieldDefs.Add('PAIS',ftString,50);
    FieldDefs.Add('IBAN',ftString,2);
    FieldDefs.Items[Fields.Count].CreateField(Result,nil,FieldDefs.Items[Fields.Count].Name);
    FieldDefs.Items[Fields.Count].CreateField(Result,nil,FieldDefs.Items[Fields.Count].Name);
    CreateDataset;
    AppendRecord(['Alemania','DE']);
    AppendRecord(['Austria','AD']);
    AppendRecord(['Austria','AT']);
    AppendRecord(['Bégica','BE']);
    AppendRecord(['Bulgaria','BG']);
    AppendRecord(['Chipre','CY']);
    AppendRecord(['Croacia','HR']);
    AppendRecord(['Dinamarca','DK']);
    AppendRecord(['Eslovaquia','SK']);
    AppendRecord(['Eslovenia','SI']);
    AppendRecord(['España','ES']);
    AppendRecord(['Estonia','EE']);
    AppendRecord(['Finlandia','FI']);
    AppendRecord(['Francia','FR']);
    AppendRecord(['Gibraltar','GI']);
    AppendRecord(['Grecia','GR']);
    AppendRecord(['Holanda','NL']);
    AppendRecord(['Hungría','HU']);
    AppendRecord(['Irlanda','IE']);
    AppendRecord(['Islandia','IS']);
    AppendRecord(['Italia','IT']);
    AppendRecord(['Letonia','LV']);
    AppendRecord(['Liechenstein','LI']);
    AppendRecord(['Lituania','LT']);
    AppendRecord(['Luxemburgo','LU']);
    AppendRecord(['Malta','MT']);
    AppendRecord(['Monaco','MC']);
    AppendRecord(['Noruega','NO']);
    AppendRecord(['Polonia','PL']);
    AppendRecord(['Portugal','PT']);
    AppendRecord(['Reino Unido','GB']);
    AppendRecord(['República Checa','CZ']);
    AppendRecord(['Rumania','RO']);
    AppendRecord(['Suecia','SE']);
    AppendRecord(['Suiza','CH']);
  end;
end;


//********************************************
function TipoDeEmpresa(NIF:string):string;
begin
  Result:='INDIVIDUAL';
  if NIF<>'' then
    case NIF[1] of
      'A':Result:='SOCIEDAD ANONIMA';
      'B':Result:='SOCIEDAD LIMITADA';
      'C','D','N','P','Q','S':Result:='ENTIDAD';
      'E','G','H':Result:='COMUNIDAD BIENES';
      'F':Result:='COOPERATIVA';
    end;
end;

{*******************************************************************************
    iban = iban sin DC ej. ES0000120345030000067890

    es
    ES0700120345030000067890

*******************************************************************************}
function CalculateDigits(iban: string): Integer;
 var
  v, l: Integer;
  alpha: string;
  number: Longint;
  rest: Integer;
  s : string;
  function ChangeAlpha(input: string): string;
   // A -> 10, B -> 11, C -> 12 ...
  var
  a: Char;
  begin
   Result := input;
   for a := 'A' to 'Z' do
   begin
     Result := StringReplace(Result, a, IntToStr(Ord(a) - 55), [rfReplaceAll]);
   end;
  end;
begin

   s := UpperCase(iban);
   if Pos('IBAN', s) > 0 then
     Delete(s, Pos('IBAN', s), 4);

   s := s + Copy(s, 1, 4);
   Delete(s, 1, 4);
   s := ChangeAlpha(s);
   v := 1;
   l := 9;
   rest := 0;
   alpha := '';
   try
     while v <= Length(s) do
     begin
       if l > Length(s) then
         l := Length(s);
       alpha := alpha + Copy(s, v, l);
       number := StrToInt(alpha);
       rest := number mod 97;
       v := v + l;
       alpha := IntToStr(rest);
       l := 9 - Length(alpha);
     end;
   except
     rest := 0;
   end;
   Result := rest;
 end;

{*******************************************************************************
  Comprueba si el IBAN es correcto.

    Iban :     Tipo ES0700120345030000067890
 *******************************************************************************}
function IBANCheck(iban: string): Boolean;
begin
  result:=(iban='') or
          (ADCodigosSEPA.Locate('IBAN',VarArrayOf([Copy(ReplaceText(iban,' ',''),1,2)]),[]) and
           (CalculateDigits(StringReplace(iban, ' ', '', [rfReplaceAll])) = 1));
end;

function CampoAnagrama(CampoNIF,CampoApellido:String;NombreCampo:String=''):String;
begin
  result:='SUBSTRING(IIF(POSITION('' '',TRIM('+CampoApellido+'))=0,TRIM('+CampoApellido+'),REVERSE(SUBSTRING(REVERSE(TRIM('+CampoApellido+')) FROM 1 FOR POSITION('' '',REVERSE(TRIM('+CampoApellido+')))-1))) FROM 1 FOR 3)||'+#13+
          '       SUBSTRING(''TRWAGMYFPDXBNJZSQVHLCKE'''+#13+
          '                 FROM MOD(MAXVALUE(IIF('+CampoNIF+' STARTING WITH ''K'',CAST(SUBSTRING('+CampoNIF+' FROM 2 FOR 7) AS INTEGER)+20,'+#13+
          '                          IIF('+CampoNIF+' STARTING WITH ''L'',CAST(SUBSTRING('+CampoNIF+' FROM 2 FOR 7) AS INTEGER)+3,'+#13+
          '                          IIF('+CampoNIF+' STARTING WITH ''M'',CAST(SUBSTRING('+CampoNIF+' FROM 2 FOR 7) AS INTEGER)+9,'+#13+
          '                          IIF('+CampoNIF+' STARTING WITH ''X'',CAST(SUBSTRING('+CampoNIF+' FROM 2 FOR 7) AS INTEGER)+12,'+#13+
          '                          IIF('+CampoNIF+' STARTING WITH ''Y'',CAST(SUBSTRING('+CampoNIF+' FROM 2 FOR 7) AS INTEGER)+10000000+4,'+#13+
          '                              CAST(SUBSTRING('+CampoNIF+' FROM 1 FOR 8) AS INTEGER))))))-'+#13+
          '                          IIF(CHAR_LENGTH(COALESCE(IIF(POSITION('' '',TRIM('+CampoApellido+'))=0,TRIM('+CampoApellido+'),REVERSE(SUBSTRING(REVERSE(TRIM('+CampoApellido+')) FROM 1 FOR POSITION('' '',REVERSE(TRIM('+CampoApellido+')))-1))),''''))>=1,POWER(3,0)*POSITION(SUBSTRING(REPLACE(REPLACE(REPLACE(REPLACE(IIF(POSITION('' '',TRIM('+CampoApellido+'))=0,TRIM('+CampoApellido+'),REVERSE(SUBSTRING(REVERSE(TRIM('+CampoApellido+')) FROM 1 FOR POSITION('' '',REVERSE(TRIM('+CampoApellido+')))-1))),''W'',''A''),''X'',''B''),''Y'',''C''),''Z'',''D'') FROM 1 FOR 1),''NERJAÑFSKBOGTLCPHUMDQIV''),0)-'+#13+
          '                          IIF(CHAR_LENGTH(COALESCE(IIF(POSITION('' '',TRIM('+CampoApellido+'))=0,TRIM('+CampoApellido+'),REVERSE(SUBSTRING(REVERSE(TRIM('+CampoApellido+')) FROM 1 FOR POSITION('' '',REVERSE(TRIM('+CampoApellido+')))-1))),''''))>=2,POWER(3,1)*POSITION(SUBSTRING(REPLACE(REPLACE(REPLACE(REPLACE(IIF(POSITION('' '',TRIM('+CampoApellido+'))=0,TRIM('+CampoApellido+'),REVERSE(SUBSTRING(REVERSE(TRIM('+CampoApellido+')) FROM 1 FOR POSITION('' '',REVERSE(TRIM('+CampoApellido+')))-1))),''W'',''A''),''X'',''B''),''Y'',''C''),''Z'',''D'') FROM 2 FOR 1),''NERJAÑFSKBOGTLCPHUMDQIV''),0)-'+#13+
          '                          IIF(CHAR_LENGTH(COALESCE(IIF(POSITION('' '',TRIM('+CampoApellido+'))=0,TRIM('+CampoApellido+'),REVERSE(SUBSTRING(REVERSE(TRIM('+CampoApellido+')) FROM 1 FOR POSITION('' '',REVERSE(TRIM('+CampoApellido+')))-1))),''''))>=3,POWER(3,2)*POSITION(SUBSTRING(REPLACE(REPLACE(REPLACE(REPLACE(IIF(POSITION('' '',TRIM('+CampoApellido+'))=0,TRIM('+CampoApellido+'),REVERSE(SUBSTRING(REVERSE(TRIM('+CampoApellido+')) FROM 1 FOR POSITION('' '',REVERSE(TRIM('+CampoApellido+')))-1))),''W'',''A''),''X'',''B''),''Y'',''C''),''Z'',''D'') FROM 3 FOR 1),''NERJAÑFSKBOGTLCPHUMDQIV''),0),0)'+#13+
          '                          ,23)+1'+#13+
          '                 FOR 1)'+IfThen(NombreCampo<>'',' '+NombreCampo,'');
end;

function PaisIntracomunitario(Conexion:TFDConnection;Pais:string):Boolean;
begin
  with ConsultaAD(Conexion,'SELECT FIRST 1 CLAVE FROM PAISES WHERE INTRACOM='+QuotedStr('SI')+' AND CLAVE='+QuotedStr(Pais)) do
    try
      Result:=not IsEmpty;
    finally
      Free;
    end;
end;

function LimpiarCaracteresDeNumero(Numero:String):String;
var
  i:integer;
begin
  result:='';
  for i:=1 to length(Numero) do
    if Numero[i] in ['0'..'9',',','-'] then
      result:=result+Numero[i];
end;

procedure DameNombreCompleto(ppais, pnif, Entrada: string; var nombre,
  apellido1, apellido2, razon: string);
var PosicionComa,PrimerEspacio,SegundoEspacio:Integer;
var original : string;
var doble : string;
begin
  pPais := Copy(pPais,1,2);
  if not PersonaFisica(pPais,pnif) then begin
    Razon:=trim(Entrada);
    Apellido1:='null';
    Apellido2:='null';
    Nombre:='null';
  end else begin
    original := Entrada;
    Razon:='null';
    //Buscamos una coma
    PosicionComa:=Pos(',',Entrada);
    if PosicionComa>0 then begin
      //El Nombre será lo que hay a la derecha de la coma
      Nombre:=trim(copy(Entrada,PosicionComa+1,length(Entrada)-PosicionComa));
      doble := Entrada;
      Delete(doble,PosicionComa,length(doble)-PosicionComa + 1);
      doble := ReverseString(doble);
      //Buscamos el primer espacio
      PrimerEspacio:=pos(' ',doble);
      Apellido2:=ReverseString((trim(copy(doble,1,PrimerEspacio-1))));
      Delete(doble,1,PrimerEspacio);
      Apellido1:=ReverseString(trim(doble));
    end else begin
      doble := ReverseString(Entrada);
      PrimerEspacio:=pos(' ',doble);
      if PrimerEspacio>0 then begin
        Apellido2:=ReverseString(trim(copy(doble,1,PrimerEspacio-1)));
        Delete(doble,1,PrimerEspacio);
        SegundoEspacio:=pos(' ',doble);
        if SegundoEspacio>0 then begin
          Apellido1:=ReverseString(trim(copy(doble,1,SegundoEspacio-1)));
          Delete(doble,1,SegundoEspacio);
          Nombre:=ReverseString(trim(doble));
        end else begin
          Nombre    := ReverseString(trim(doble));
          Apellido1 := Apellido2;
          Apellido2 := '';
        end;
      end else begin
        Nombre:=trim(Entrada);
        Apellido1:='';
        Apellido2:='';
      end;
    end;
  end;
end;

function DameSentenciaDeListadoPersonalizado(ID:Integer):string;
begin
  With CDSRestFacturaGDB('SELECT SENTENCIA FROM LISTADOSCONDICIONALES WHERE IDLISTADOSCONDICIONALES='+IntToStr(ID)) do
    try
      Result:=Fields.Fields[0].AsString;
    finally
      Free
    end;

//  with CDSRemoto('https://www.caisistemas.es/prueba/ado.dll/soap/IConexiones','Factura_gdb',
//                 'SELECT SENTENCIA FROM LISTADOSCONDICIONALES WHERE IDLISTADOSCONDICIONALES='+IntToStr(ID)) do
//    try
//      Result:=Fields.Fields[0].AsString;
//    finally
//      Free;
//    end;
end;

function ListadoPersonalizado(Conexion:TFDConnection;ID:Integer;UniDireccional:Boolean=True):TFDQuery;
begin
  With CDSRestFacturaGDB('SELECT SENTENCIA FROM LISTADOSCONDICIONALES WHERE IDLISTADOSCONDICIONALES='+IntToStr(ID)) do
    try
      Result:=ConsultaAD(Conexion,Fields.Fields[0].AsString,UniDireccional,False);
    finally
      Free
    end;

//  with CDSRemoto('https://www.caisistemas.es/prueba/ado.dll/soap/IConexiones','Factura_gdb',
//                 'SELECT SENTENCIA FROM LISTADOSCONDICIONALES WHERE IDLISTADOSCONDICIONALES='+IntToStr(ID)) do
//    try
//      Result:=ConsultaAD(Conexion,Fields.Fields[0].AsString,UniDireccional,False);
//    finally
//      Free;
//    end;
end;

function GetIP(const HostName: string): string;
var
  WSAData: TWSAData;
  R: PHostEnt;
  A: TInAddr;
begin
  Result := '0.0.0.0';
  WSAStartup($101, WSAData);
  R := Winsock.GetHostByName(PAnsiChar(AnsiString(HostName)));
  if Assigned(R) then
  begin
    A := PInAddr(r^.h_Addr_List^)^;
    Result := WinSock.inet_ntoa(A);
  end;
end;

procedure EstiloBoton(UL:TUniLabel;URL,Target,Caption,Hint,Fuente:String);
begin
  UL.TextConversion:=txtHTML;
  UL.Text:='<span><a href="'+URL+'" target="'+Target+'" class="x-btn x-unselectable x-btn-toolbar x-box-item x-toolbar-item x-btn-default-toolbar-small x-noicon x-btn-noicon x-btn-default-toolbar-small-noicon" '+
           '   style="left: '+IntToStr(UL.Left)+'px; top: 1px; width: '+IntToStr(UL.Width)+'px; height: '+IntToStr(UL.Height)+'px; right: auto; margin: 0px;" hidefocus="on" unselectable="on" tabindex="0" title="'+Hint+'"> '+
           '<span role="presentation" class="x-btn-wrap" unselectable="on" style="height: 31px;"> '+
           '<span class="x-btn-button" role="presentation" style="height: 31px;"> '+
           '<span class="x-btn-inner x-btn-inner-center" unselectable="on" style="line-height: normal; font-style: normal; font-variant: normal; font-weight: normal; font-stretch: normal; font-size: 30px; font-family: '+Fuente+'; color: rgb(0, 180, 187);"> '+
           Caption+'</span> '+
           '<span role="presentation" class="x-btn-icon-el" unselectable="on" style=""></span></span></span></a></span>';



end;

procedure HabilitaControl(Control:TUniFormControl;Habilita:Boolean);
begin
  if Habilita then
  begin
    Control.TabStop:=True;
    Control.ReadOnly:=False;
    Control.Color:=clWindow;
  end
  else begin
    Control.TabStop:=False;
    Control.ReadOnly:=True;
    Control.Color:=clInfoBk;
  end;
end;

function CAIInListInt(Valor: Integer; ValoresPosibles: array of Integer): boolean;
var
  i: Integer;
begin
  Result := False;
  for i := Low(ValoresPosibles) to High(ValoresPosibles) do
  begin
    if ValoresPosibles[i] = Valor then
    begin
      Result := True;
      Break;
    end;
  end;
end;
function CAIInListStr(Valor: string; ValoresPosibles: array of string; TextoParecido : Boolean = False): boolean;
var
  i: Integer;
begin
  Result := False;
  for i := Low(ValoresPosibles) to High(ValoresPosibles) do
  begin
    if (ValoresPosibles[i] = Valor) or (TextoParecido and SameText(ValoresPosibles[i], Valor)  ) then
    begin
      Result := True;
      Break;
    end;
  end;
end;

{$IFNDEF SIN_GENERAL}
function CambioPais(Edit:TUniDBEdit):boolean;
begin
 {$IFNDEF SINCRONIZAR}
  Result:=True;
  if Edit.Field.AsString<>'' then
    Result:=ValidaCampo(Edit,
                        ConsultaAD(UniMainModule.ADConexionGeneral,'SELECT CLAVE FROM PAISES WHERE CLAVE='+QuotedStr(Edit.Field.AsString)),
                        'País inexistente');
 {$ENDIF}
end;
{$ENDIF}

function ValidaCampo(Edit:TUniCustomDBEdit;Consulta:TDataSet;Mensaje:String):Boolean;
var
  e:TUniCustomDBEdit;
  evento1:TFieldNotifyEvent;
  evento2:TDataChangeEvent;
begin
  if Edit.Field.AsString<>'' then
    try
      e:=Edit;
      Result:=not Consulta.IsEmpty;
      if not Result then
        uniGUIDialogs.ShowMessage(Mensaje,
                                  procedure (Sender: TComponent; AResult: Integer)
                                  begin
                                    evento1:=e.Field.OnChange;
                                    evento2:=TUniDBEdit(e).DataSource.OnDataChange;
                                    TUniDBEdit(e).DataSource.OnDataChange:=nil;
                                    e.Field.OnChange:=nil;
                                    try
                                      e.Field.Clear;
                                    finally
                                      e.Field.OnChange:=evento1;
                                      TUniDBEdit(e).DataSource.OnDataChange:=evento2;
                                    end;
                                    e.SetFocus;
                                  end)
      else
        UniSession.AddJS(Edit.JSName+'.setValue('+QuotedStr(Edit.Field.AsString)+');');
    finally
      FreeAndNil(Consulta);
    end;
end;

function ValidaNIF(PAIS,NIF:String;Edit:TUniCustomDBEdit):Boolean;
var
  LNIF:String;
  e:TUniCustomDBEdit;
  evento:TFieldNotifyEvent;
  evento2:TDataChangeEvent;
begin
  evento:=Edit.Field.OnChange;
  evento2:=TUniDBEdit(Edit).DataSource.OnDataChange;
  Edit.Field.OnChange:=nil;
  TUniDBEdit(Edit).DataSource.OnDataChange:=nil;
  try
    e:=Edit;
    e.Field.AsString:=CalcCifNif(PAIS,NIF,True);
    Result:=True;
    if e.Field.AsString='MAL' then
    begin
      Result:=False;
      e.Field.Clear;
      uniGUIDialogs.ShowMessage('NIF incorrecto',
                                procedure (Sender: Tcomponent;AResult:Integer)
                                begin
                                  e.SetFocus;
                                end);
    end;
    e.Text:=e.Field.Text;
  finally
    Edit.Field.OnChange:=evento;
    TUniDBEdit(Edit).DataSource.OnDataChange:=evento2;
  end;
end;

{$IFNDEF SIN_GENERAL}
procedure CambioCP(EditCP:TUniCustomDBEdit;CP,Provincia,CodigoMunicipio,Municipio:TField;EditCodigoMunicipio:TUniCustomDBEdit=nil;EditMunicipio:TUniCustomDBEdit=nil);
var
  e:TFieldNotifyEvent;
  e2:TDataChangeEvent;
begin
  if StartsText('99',CP.AsString) then
  begin
    if Assigned(Provincia) then Provincia.AsInteger:=99;
  end
  else
   {$IFNDEF SINCRONIZAR}
    with ConsultaAD(UniMainModule.ADConexionGeneral,'SELECT CPOSTALES.LOCALIDAD,CPOSTALES.PROVINCIA,DESCRIPCION'+#13+
                                                    'FROM CPOSTALES'+#13+
                                                    'LEFT OUTER JOIN LOCALIDADES ON (LOCALIDADES.LOCALIDAD=CPOSTALES.LOCALIDAD AND LOCALIDADES.PROVINCIA=CPOSTALES.PROVINCIA)'+#13+
                                                    'WHERE CPOSTAL='+IntToStr(CP.AsInteger)) do
      try
        if not IsEmpty then
        begin
          if Assigned(Provincia) then Provincia.AsInteger:=FieldByName('PROVINCIA').AsInteger;
          if Assigned(CodigoMunicipio) then
          begin
            e2:=TUniDBEdit(EditCP).DataSource.OnDataChange;
            e:=CodigoMunicipio.OnChange;
            CodigoMunicipio.OnChange:=nil;
            TUniDBEdit(EditCP).DataSource.OnDataChange:=nil;
            try
              CodigoMunicipio.AsString:=FieldByName('LOCALIDAD').AsString;
            finally
              CodigoMunicipio.OnChange:=e;
              TUniDBEdit(EditCP).DataSource.OnDataChange:=e2;
            end;
          end;
          if Assigned(Municipio) then Municipio.AsString:=FieldByName('DESCRIPCION').AsString;
          if Assigned(EditCodigoMunicipio) then
          begin
            if Assigned(CodigoMunicipio) and (FieldByName('LOCALIDAD').AsInteger<>0) then
            begin
              EditCodigoMunicipio.ReadOnly:=True;
              EditCodigoMunicipio.TabStop:=False;
              EditCodigoMunicipio.Color:=clInfoBk;
            end
            else begin
              EditCodigoMunicipio.ReadOnly:=False;
              EditCodigoMunicipio.TabStop:=True;
              EditCodigoMunicipio.Color:=clWhite;
            end;
          end;

          if Assigned(EditMunicipio) then
          begin
            if Assigned(Municipio) and (FieldByName('DESCRIPCION').AsString<>'') then
            begin
              EditMunicipio.ReadOnly:=True;
              EditMunicipio.TabStop:=False;
              EditMunicipio.Color:=clInfoBk;
            end
            else begin
              EditMunicipio.ReadOnly:=False;
              EditMunicipio.TabStop:=True;
              EditMunicipio.Color:=clWhite;
            end;
          end
        end
        else begin
          if Assigned(Provincia) and (Length(CP.AsString) in [4,5]) then Provincia.AsInteger:=StrToIntDef(copy(CP.AsString,1,Length(CP.AsString)-3),0);
          UniGuiDialogs.ShowMessage('No existe el código postal.',
                                    procedure (Sender: Tcomponent;AResult:Integer)
                                    begin
                                      if Assigned(EditCP) then EditCP.SetFocus;
                                    end);
        end;
      finally
        Free;
      end;
 {$ENDIF}
end;


procedure CambioCodigoMunicipio(EditCodigoMunicipio:TUniCustomDBEdit;Provincia,CodigoMunicipio,Municipio:TField;EditMunicipio:TUniCustomDBEdit=nil);
var
  e:TUniCustomDBEdit;
  evento1:TFieldNotifyEvent;
  evento2:TDataChangeEvent;
begin
 {$IFNDEF SINCRONIZAR}
  if CodigoMunicipio.asInteger<>0 then
  begin
    e:=EditCodigoMunicipio;
    if Provincia.IsNull then
      uniGUIDialogs.ShowMessage('Ha de seleccionar primero una provincia',
                                procedure (Sender: TComponent; AResult: Integer)
                                begin
                                  evento1:=e.Field.OnChange;
                                  evento2:=TUniDBEdit(e).DataSource.OnDataChange;
                                  TUniDBEdit(e).DataSource.OnDataChange:=nil;
                                  e.Field.OnChange:=nil;
                                  try
                                    e.Field.Clear;
                                  finally
                                    e.Field.OnChange:=evento1;
                                    TUniDBEdit(e).DataSource.OnDataChange:=evento2;
                                  end;
                                  e.SetFocus;
                                end)
    else begin
      with ConsultaAD(UniMainModule.ADConexionGeneral,'SELECT DESCRIPCION FROM LOCALIDADES WHERE PROVINCIA='+IntToStr(Provincia.AsInteger)+' AND LOCALIDAD='+IntToStr(CodigoMunicipio.AsInteger)) do
        try
          if IsEmpty then
          begin
            uniGUIDialogs.ShowMessage('Código de municipio inexistente',
                                      procedure (Sender: TComponent; AResult: Integer)
                                      begin
                                        evento1:=e.Field.OnChange;
                                        evento2:=TUniDBEdit(e).DataSource.OnDataChange;
                                        TUniDBEdit(e).DataSource.OnDataChange:=nil;
                                        e.Field.OnChange:=nil;
                                        try
                                          e.Field.Clear;
                                        finally
                                          e.Field.OnChange:=evento1;
                                          TUniDBEdit(e).DataSource.OnDataChange:=evento2;
                                        end;
                                        e.SetFocus;
                                      end);
            EditMunicipio.ReadOnly:=False;
            EditMunicipio.TabStop:=True;
            EditMunicipio.Color:=clWindow;
          end
          else begin
            Municipio.AsString:=FieldByName('DESCRIPCION').AsString;
            EditMunicipio.ReadOnly:=True;
            EditMunicipio.TabStop:=False;
            EditMunicipio.Color:=clInfoBk;
            UniSession.AddJS(e.JSName+'.setValue('+QuotedStr(e.Field.AsString)+');');
          end;
        finally
          Free;
        end;
    end;
  end
  else begin
    EditMunicipio.ReadOnly:=False;
    EditMunicipio.TabStop:=True;
    EditMunicipio.Color:=clWindow;
  end;
 {$ENDIF}
end;
{$ENDIF}

function Iguales(a,b:real;tolerancia:real=0.001):boolean;
begin
  result:=(a<=b+abs(tolerancia)) and (a>=b-abs(tolerancia))
end;

procedure VideoYouTube(ID:String;AutoPlay:Integer=1;Titulo:String='Vídeo de ayuda');
begin
 {$IFNDEF SINCRONIZAR}
  with TFrmControlGenerico.Create('<iframe width="100%" height="100%" src="https://www.youtube.com/embed/'+ID+'?autoplay='+IntToStr(AutoPlay)+'"></iframe>') do
  begin
    Caption:=Titulo;
    ShowModal;
  end;
 {$ENDIF}
end;

procedure AbrirURL(URL:String;Titulo:String='';CallBack:TUniDialogCallBackAnonProc=nil);
begin
 {$IFNDEF SINCRONIZAR}
  with TFrmControlGenerico.Create('<iframe width="100%" height="100%" src="'+URL+'"></iframe>') do
  begin
    Caption:=Titulo;
    ShowModal(CallBack);
  end;
 {$ENDIF}
end;

function FechaEntreFechas(Fecha:TDateTime;FechaInicio:TDateTime;FechaFin:TDateTime): boolean;
begin
  Result:=(Fecha=0) or
          (((FechaInicio=0) or (Fecha>=FechaInicio)) and
           ((FechaFin=0) or (Fecha<=FechaFin)));
end;

procedure LogAccesoOpciones(Usuario:string;CodOpcion:Integer;Aplicacion:String);
begin
  ModificaFacturaGDB(Format('UPDATE OR INSERT INTO LOG_ACCESO_OPCION (LICENCIA, CODOPCION, ANO, MES, CONTADOR, APLICACION) VALUES '+
                     '(%s, %d, %d, %d, ' +
                     // Lo hacemos asi porque se hace por UPDATE OR INSERT, si solo fuera update se podria poner 1 + CONTADOR
                     '1 + COALESCE((SELECT CONTADOR FROM LOG_ACCESO_OPCION WHERE LICENCIA = %s AND CODOPCION = %d AND ANO='+IntToStr(YearOf(Now))+' AND MES='+IntToStr(MonthOf(Now))+'),0),' +
                     ' %s) MATCHING (LICENCIA, CODOPCION, ANO, MES)'
                         , [QuotedStr(Usuario), CodOpcion, YearOf(Now), MonthOf(Now),QuotedStr(Usuario), CodOpcion, QuotedStr(Aplicacion)]));
end;

function Download(Direccion,Fichero: string):Boolean;
var
  MS: TMemoryStream;
  Http:TIdHTTP;
begin
  IdSSLOpenSSLHeaders.Load;
  Http:=TIdHTTP.Create(nil);
  try
    Http.IOHandler:=TIdSSLIOHandlerSocketOpenSSL.Create(Http);
    MS := TMemoryStream.Create;
    try
      Http.Get(Direccion, MS);
      MS.SaveToFile(Fichero);
    finally
      MS.Free;
    end;
  finally
    FreeAndNil(Http);
  end;;
  result:=True;
end;

function ListaCampo(DS:TFDDataSet;Campo:String):String;
begin
  Result:='';
  with TFDMemTable.Create(nil) do
    try
      CLoneCursor(DS,False,False);
      First;
      while not Eof do
      begin
        Result:=Result+FieldByName(Campo).AsString+',';
        Next;
      end;
    finally
      Free;
    end;
  if Result<>'' then Delete(Result,Length(Result),1);
end;

procedure Notification(pTitle, pMessage:String);
begin
 UniSession.AddJS(format('jQuery(document).ready(function($){$.notify("%s",{title: "%s", icon: "http:\\dominio.com\yourimage.png"});});',[pMessage,pTitle]));
end;

procedure EjecutaProceso(Procedimiento:TProcedimiento);
begin
  THiloEjecucion.Create(Procedimiento,False);
end;

function EjecutaSQL(Conexion:TFDConnection;Sentencia:String;Transaccion:TFDTransaction=nil;Parametros:TFDParams=nil;ListaMacros:TFDMacros=nil):Integer;
begin
  with TFDCommand.Create(nil) do
    try
      CommandText.Text:=Sentencia;
      Connection:=Conexion;
      if Assigned(ListaMacros) then
        AsignarMacros(Macros,ListaMacros);
      if Assigned(Parametros) then
        AsignarParametros(Params,Parametros);
      if Transaccion<>nil then Transaction:=Transaccion;
      Execute;
      Result:=RowsAffected;
    finally
      Free;
    end;
end;

function EjecutaSQLEscalar(Conexion:TFDConnection;Sentencia:String;Transaccion:TFDTransaction=nil;Parametros:TFDParams=nil;ListaMacros:TFDMacros=nil):Integer;
begin
  with TFDQuery.Create(nil) do
    try
      Connection:=Conexion;
      SQL.Text:=Sentencia;
      if Assigned(ListaMacros) then
        AsignarMacros(Macros,ListaMacros);
      if Assigned(Parametros) then
        AsignarParametros(Params,Parametros);
      if Transaccion<>nil then Transaction:=Transaccion;
      Open;
      Result:=Fields[0].AsInteger;
    finally
      Free;
    end;
end;


function GeneraInsert(COnexion:TFDConnection;Tabla:String):String;
begin
  with ConsultaAD(Conexion,
                  'SELECT ''INSERT INTO ''||'+QuotedStr(UpperCase(Tabla))+'||''(''||LIST(TRIM(RDB$FIELD_NAME))||'') VALUES(''||LIST('':''||TRIM(RDB$FIELD_NAME))||'')'''+#13#10+
                  'FROM RDB$RELATION_FIELDS'+#13#10+
                  'WHERE UPPER(RDB$RELATION_NAME)='+QuotedStr(UpperCase(Tabla))) do
    try
      Result:=Fields[0].AsString;
    finally
      Free;
    end;
end;

function GeneraUpdate(COnexion:TFDConnection;Tabla,Filtro:String;CamposAEvitar:String=''):String;
begin
  with ConsultaAD(Conexion,
                  'SELECT ''UPDATE ''||'+QuotedStr(UpperCase(Tabla))+'||'' SET ''||LIST(TRIM(RDB$FIELD_NAME)||''=:''||TRIM(RDB$FIELD_NAME))||'' WHERE ''||'+QuotedStr(Filtro)+
                  'FROM RDB$RELATION_FIELDS'+#13#10+
                  'WHERE UPPER(RDB$RELATION_NAME)='+QuotedStr(UpperCase(Tabla))+#13#10+
                  IfThen(Filtro='','',' AND TRIM(RDB$FIELD_NAME) NOT IN ('+UpperCase(CamposAEvitar)+')')) do
    try
      Result:=Fields[0].AsString;
    finally
      Free;
    end;
end;

procedure IniciaParametros(Consulta:TFDQuery;Tabla:String);
begin
  IniciaParametros2(Consulta,Tabla,[],[]);
end;

procedure IniciaParametros2(Consulta:TFDQuery;Tabla:String;Parametros,Campos:Array of String);
var
  i:Integer;
begin
  with ConsultaAD(TFDConnection(Consulta.Connection),'SELECT FIRST 0 * FROM '+Tabla) do
    try
      for i:=0 to Consulta.ParamCount-1 do
      begin
        if Assigned(FindField(Consulta.Params.Items[i].Name)) then
        begin
          Consulta.Params.Items[i].DataType:=FieldByName(Consulta.Params.Items[i].Name).DataType;
          Consulta.Params.Items[i].Size:=FieldByName(Consulta.Params.Items[i].Name).Size;
        end
      end;
      for i:=0 to Length(Parametros)-1 do
      begin
        Consulta.ParamByName(Parametros[i]).DataType:=FieldByName(Campos[i]).DataType;
        Consulta.ParamByName(Parametros[i]).Size:=FieldByName(Campos[i]).Size;
      end;
    finally
      Free;
    end;
end;

procedure PoneNuloParametros(Consulta:TFDQuery);
var
  i:integer;
begin
  for i:=0 to Consulta.ParamCount-1 do Consulta.Params.Items[i].Clear;
end;

function ClavePrimaria(Consulta:TFDDataSet):String;
var
  i:Integer;
begin
  Result:='';
  i:=0;
  while (i<Consulta.Fields.Count) and not (pfInKey in Consulta.Fields[i].ProviderFlags) do Inc(i);
  if i<Consulta.Fields.Count then
    Result:=Consulta.Fields[i].FieldName;
end;

{ THiloEjecucion }

constructor THiloEjecucion.Create(Procedimiento: TProcedimiento;
  CreateSuspended: Boolean);
begin
  inherited Create(CreateSuspended);
  HProcedimiento:=Procedimiento;
end;

procedure THiloEjecucion.Execute;
begin
  inherited;
  HProcedimiento;
  Free;
end;

procedure OcultaColumna(Grid:TUniDBGrid;Campo:TField);
var
  i:Integer;
begin
  i:=0;
  while (i<Grid.Columns.Count) and not SameText(Grid.Columns.Items[i].FieldName,Campo.FieldName) do Inc(i);
  if i<Grid.Columns.Count then Grid.Columns.Delete(i);
end;

function NumeroRegistrosDataSet(DataSet:TFDQuery;Filtro:String):Integer;
begin
  with TFDMemTable.Create(nil) do
    try
      CloneCursor(DataSet);
      Filter:=Filtro;
      Filtered:=True;
      Result:=RecordCount;
    finally
      Free;
    end;

end;

procedure IgualaParametros(ConsultaParametrizada,Consulta:TFDQuery;LiberaConsulta:Boolean=False);
var
  i:Integer;
begin
  for i:=0 to Consulta.Fields.Count-1 do
    if Consulta.Fields[i].IsNull then
      ConsultaParametrizada.ParamByName(Consulta.Fields[i].FieldName).Clear
    else
      ConsultaParametrizada.ParamByName(Consulta.Fields[i].FieldName).Value:=Consulta.Fields[i].Value;
  if LiberaConsulta then FreeAndNil(Consulta);
end;

procedure UnirPDFs(Fichero1,Fichero2:String;PonPaginaBlancoSiImpares:Boolean=False);
var
  QP:TDebenuPDFLibrary1612;
  RutaTmp:String;
begin
 {$IFNDEF SINCRONIZAR}
  QP:=TDebenuPDFLibrary1612.Create;
  try
    QP.UnlockKey('jf77x88g5rt3bc3i99m44rs3y');
    if FileExists(Fichero1) then
    begin
      if FileExists(Fichero2) then
      begin
        RutaTmp:=IncludeTrailingPathDelimiter(UniServerModule.LocalCachePath)+FormatDateTime('yyyymmddhhnnsszzz',Now)+'.pdf';
        RenameFile(Fichero1,RutaTmp);
        if QP.MergeFiles(RutaTmp,Fichero2,Fichero1)=0 then
          uniGUIDialogs.ShowMessage('Error '+IntToStr(QP.LastErrorCode));

        DeleteFile(PChar(RutaTmp));
        DeleteFile(PChar(Fichero2));
      end;
    end
    else begin
      CopyFile(PChar(Fichero2),PChar(Fichero1),False);
      DeleteFile(PChar(Fichero2));
  //    RenameFile(Fichero2,Fichero1);
    end;
    if PonPaginaBlancoSiImpares then
    begin
      QP.LoadFromFile(Fichero1,'');
      if QP.PageCount mod 2<>0 then QP.NewPage;
      QP.SaveToFile(Fichero1);
    end;
  finally
    FreeAndNil(QP);
  end;
 {$ENDIF}
end;

function EnviarCorreo(Servidor,Usuario,Contrasena,Remitente,Destinatario,Asunto,Cuerpo:String;Adjuntos:array of String;Firma:String;ImagenCabecera:String;Puerto:Integer;UsaTLS:TclClientTlsMode;ClienteID,Secreto,Autorizacion:String;RefrescoAutorizacion:String;URLRedireccion:String;ProcedimientOAuth2:TProcedimientOAuth2):Boolean;
var
  Mensaje:TclMailMessage;
  CopiaAdjuntos:Array of String;
  i:Integer;
begin
  {$IFNDEF SINCRONIZAR}
  Result:=True;
  Mensaje:=TclMailMessage.Create(nil);
  try
    Mensaje.BuildMessage(IfThen(ImagenCabecera<>'','<img src="'+ImagenCabecera+'" alt="">'+'<br><br>','')+Cuerpo+IfThen(Firma<>'','<br><br>'+Firma,''),Adjuntos);
    Mensaje.From.Email:=Remitente;
    with TStringList.Create do
      try
        Delimiter:=';';
        DelimitedText:=Destinatario;
        for I := 0 to Count-1 do
          Mensaje.ToList.Add.Email:=Strings[i];
      finally
        Free;
      end;
    Mensaje.Subject:=Asunto;
    Mensaje.Date:=Now;
    with TclSmtp.Create(nil) do
      try
        if EndsText('@GMAIL.COM',UpperCase(Usuario)) then
        begin
          if RefrescoAutorizacion<>'' then
          begin
            with TFrmOAuth2.Crear(ClienteID,
                                  Secreto,
                                  '',
                                  'https://www.googleapis.com/oauth2/v4/token',
                                  URLRedireccion,
                                  'https://mail.google.com/',
                                  RefrescoAutorizacion) do
              try
                if Assigned(ProcedimientOAuth2) then
                  ProcedimientOAuth2(AccesToken,RefreshToken,HoraExpiracion);
                Authorization:=AccesToken;
              finally
                Free;
              end;
          end
          else if Autorizacion<>'' then
            Authorization:=Autorizacion
          else begin
            SetLength(CopiaAdjuntos,Length(Adjuntos));
            for i:=0 to Length(Adjuntos)-1 do CopiaAdjuntos[i]:=Adjuntos[i];
            TFrmOAuth2.Crear(ClienteID,
                             Secreto,
                             'https://accounts.google.com/o/oauth2/auth?',
                             'https://www.googleapis.com/oauth2/v4/token',
                             URLRedireccion,
                             'https://mail.google.com/').ShowModal(procedure (Sender: Tcomponent;AResult: Integer)
                                                                   begin
                                                                     if AResult=mrOk then
                                                                     begin
                                                                       EnviarCorreo(Servidor,Usuario,Contrasena,Remitente,Destinatario,Asunto,Cuerpo,CopiaAdjuntos,Firma,ImagenCabecera,Puerto,UsaTLS,ClienteID,Secreto,TFrmOAuth2(Sender).AccesToken,'',URLRedireccion,ProcedimientoAuth2);
                                                                       if Assigned(ProcedimientOAuth2) then
                                                                         ProcedimientOAuth2(TFrmOAuth2(Sender).AccesToken,TFrmOAuth2(Sender).RefreshToken,TFrmOAuth2(Sender).HoraExpiracion);
                                                                     end;
                                                                   end)
          end;
        end
        else begin
          Password:=Contrasena;
        end;
        Username:=Usuario;
        Result:=(Password<>'') or (Authorization<>'');
        if Result then
        begin
          Server:=Servidor;
          Port:=Puerto;
          UseTLS:=UsaTLS;
          try
            Open;
            if Active then
            begin
              Send(Mensaje);
              Close;
            end;
          except
            //Si la autorizacion tiene valor y ha ocudido un error, reintentamos el envio pasandole la autorización a blanco, para provocar la petición de una nueva autorización
            Result:=False;
            if (Autorizacion<>'') then
              EnviarCorreo(Servidor,Usuario,Contrasena,Remitente,Destinatario,Asunto,Cuerpo,Adjuntos,Firma,ImagenCabecera,Puerto,UsaTLS,ClienteID,Secreto,'','',URLRedireccion,ProcedimientoAuth2);
          end;
        end;
      finally
        Free;
      end;
  finally
    FreeAndNil(Mensaje);
  end;
   {$ENDIF}
end;
function SubirCorreoIMAP(Host,Usuario,Contrasena,Buzon,Remitente,Destinatario,Asunto,Cuerpo:String;Adjuntos:array of String;Firma:String;ImagenCabecera:String;Puerto:Integer;UsaTLS:TclClientTlsMode;ClienteID,Secreto,Autorizacion:String;RefrescoAutorizacion:String;URLRedireccion:String;ProcedimientOAuth2:TProcedimientOAuth2):boolean;
var
  Mensaje:TclMailMessage;
  CopiaAdjuntos:Array of String;
  i:Integer;
begin
  {$IFNDEF SINCRONIZAR}
  Result:=True;
  Mensaje:=TclMailMessage.Create(nil);
  try
    Mensaje.BuildMessage(IfThen(ImagenCabecera<>'','<img src="'+ImagenCabecera+'" alt="">'+'<br><br>','')+Cuerpo+IfThen(Firma<>'','<br><br>'+Firma,''),Adjuntos);
    Mensaje.From.Email:=Remitente;
    Mensaje.ToList.Add.Email:=Destinatario;
    Mensaje.Subject:=Asunto;
    Mensaje.Date:=Now;
    with TclImap4.Create(nil) do
      try
        Username:=Usuario;
        if EndsText('@GMAIL.COM',UpperCase(Usuario)) then
        begin
          if RefrescoAutorizacion<>'' then
          begin
            with TFrmOAuth2.Crear(ClienteID,
                                  Secreto,
                                  '',
                                  'https://www.googleapis.com/oauth2/v4/token',
                                  URLRedireccion,
                                  'https://mail.google.com/',
                                  RefrescoAutorizacion) do
              try
                if Assigned(ProcedimientOAuth2) then
                  ProcedimientOAuth2(AccesToken,RefreshToken,HoraExpiracion);
                Authorization:=AccesToken;
              finally
                Free;
              end;
          end
          else if Autorizacion<>'' then
            Authorization:=Autorizacion
          else begin
            SetLength(CopiaAdjuntos,Length(Adjuntos));
            for i:=0 to Length(Adjuntos)-1 do CopiaAdjuntos[i]:=Adjuntos[i];
            TFrmOAuth2.Crear(ClienteID,
                             Secreto,
                             'https://accounts.google.com/o/oauth2/auth?',
                             'https://www.googleapis.com/oauth2/v4/token',
                             URLRedireccion,
                             'https://mail.google.com/').ShowModal(procedure (Sender: Tcomponent;AResult: Integer)
                                                                   begin
                                                                     if AResult=mrOk then
                                                                     begin
                                                                       SubirCorreoIMAP(Host,Usuario,Contrasena,Buzon,Remitente,Destinatario,Asunto,Cuerpo,CopiaAdjuntos,Firma,ImagenCabecera,Puerto,UsaTLS,ClienteID,Secreto,TFrmOAuth2(Sender).AccesToken,'',URLRedireccion,ProcedimientoAuth2);
                                                                       if Assigned(ProcedimientOAuth2) then
                                                                         ProcedimientOAuth2(TFrmOAuth2(Sender).AccesToken,TFrmOAuth2(Sender).RefreshToken,TFrmOAuth2(Sender).HoraExpiracion);
                                                                     end;
                                                                   end)
          end;
        end
        else
          Password:=Contrasena;
        Result:=(Password<>'') or (Authorization<>'');
        if Result then
        begin
          Password:=Contrasena;
          Server:=Host;
          Port:=Puerto;
          UseTLS:=UsaTLS;
          try
            Open;
            if Active then
            begin
              try CreateMailBox(Buzon); except end;
              AppendMessage(Buzon,Mensaje,[]);
              Close;
            end;
          except
            //Si la autorizacion tiene valor y ha ocudido un error, reintentamos el envio pasandole la autorización a blanco, para provocar la petición de una nueva autorización
            if (Autorizacion<>'') then
              SubirCorreoIMAP(Host,Usuario,Contrasena,Buzon,Remitente,Destinatario,Asunto,Cuerpo,Adjuntos,Firma,ImagenCabecera,Puerto,UsaTLS,ClienteID,Secreto,'','',URLRedireccion,ProcedimientoAuth2);
          end;
        end;
      finally
        Free;
      end;
  finally
    FreeAndNil(Mensaje);
  end;
   {$ENDIF}
end;

function HazPost(URL:String;
                 Parametros:Array Of String;
                 PFX:String='';DescripcionCertificado:String='';Contrasenha:String='';HacerGet:Boolean=False):String;
var
  i:Integer;
  ipsHTTPSH:TipsHTTPSH;
  ipwHTTPH:TipwHTTPH;
  SParametros:String;
begin
  {$IFNDEF SINCRONIZAR}
  SParametros:='';
  for i:=0 to Length(Parametros)-1 do SParametros:=SParametros+IfThen(i=0,'','&')+ReplaceText(ReplaceText(ReplaceText(URLEncode(ReplaceText(Parametros[i],'%',' ')),'%3D','='),'%C3%91','%D1'),'%C3%87','%C7');
  if not StartsText('HTTPS://',UpperCase(Url)) then
  begin
    ipwHTTPH:=TipwHTTPH.Create(nil);
    try
      ipwHTTPH.ContentType:='application/x-www-form-urlencoded';
      ipwHTTPH.OnTransfer:=TipwHTTPH.ipwHTTPTransfer;
      ipwHTTPH.resultado:='';
      ipwHTTPH.PostData:=SParametros;
      if HacerGet then
        ipwHTTPH.Get(URL)
      else
        ipwHTTPH.Post(URL);
      result:=ipwHTTPH.Resultado;
    finally
      ipwHTTPH.Free;
    end
  end
  else begin
    ipsHTTPSH:=TipsHTTPSH.Create(nil);
    try
      if PFX<>'' then
      begin
        ipsHTTPSH.SSLCertStoreType:=TipshttpsCertStoreTypes.cstPFXBlob;
        ipsHTTPSH.SSLCertStorePassword:=Contrasenha;
        ipsHTTPSH.SSLCertStoreB:=PFX;
        ipsHTTPSH.SSLCertSubject:=DescripcionCertificado;
      end;
      ipsHTTPSH.ContentType:='application/x-www-form-urlencoded';
      ipsHTTPSH.OnTransfer:=TipsHTTPSH.ipsHTTPSTransfer;
      ipsHTTPSH.resultado:='';

      if HacerGet then
        ipsHTTPSH.Get(URL+IfThen(SParametros<>'','?'+SParametros,''))
      else begin
        ipsHTTPSH.PostData:=SParametros;
        ipsHTTPSH.Post(URL);
      end;

      result:=ipsHTTPSH.Resultado;
      if copy(Result,1,1)='<' then
      begin
        SParametros:='Errores en la comunicación:'+#13#10+
                     'URL=> '+URL;
        for i:=0 to Length(Parametros)-1 do SParametros:=SParametros+#13#10+Parametros[i];
        UniServerModule.Logger.AddLog(SParametros);
      end;
    finally
      ipsHTTPSH.Free;
    end;
  end;
  {$ENDIF}
end;

function ContenidoEtiquetaHTML(HTML,Etiqueta:String;var ok:Boolean):String;
var
  Inicio,Fin:Integer;
begin
  result:='';
  Inicio:=Pos('<'+UpperCase(Etiqueta)+'>',UpperCase(HTML))+Length('<'+UpperCase(Etiqueta)+'>');
  Fin:=Pos('</'+UpperCase(Etiqueta)+'>',UpperCase(HTML));
  ok:=Inicio>Length('<'+UpperCase(Etiqueta)+'>');
  if ok then result:=trim(Copy(HTML,Inicio,Fin-Inicio));
end;


function CDSRest(Host,Ruta,rutacliente,Sentencia:String;ejecutar:boolean;Owner:TComponent;Servidor:String;Puerto:Integer;URLPath:String):TClientDataset;
var
  ModificaConexionCommand:TDBXCommand;
  Conexion:TSQLConnection;
  Proveedor:TDSProviderConnection;
begin
  Conexion:=TSQLConnection.Create(nil);
  with Conexion do
    try
      DriverName:='DataSnap';
      Params.Values['DriverUnit']:='Data.DBXDataSnap';
      Params.Values['DriverAssemblyLoader']:='Borland.Data.TDBXClientDriverLoader,Borland';
      Params.Values['.Data.DbxClientDriver,Version']:='16.0.0.0,Culture=neutral,PublicKey';
      Params.Values['Token']:='91d62ebb5b0d1b1b';
      Params.Values['Port']:=IntToStr(Puerto);
      Params.Values['HostName']:=Servidor;
      Params.Values['CommunicationProtocol']:=IfThen(Puerto=80,'http','https');
      Params.Values['URLPath']:=URLPath;
      Params.Values['DatasnapContext']:='datasnap/';
      Params.Values['Filters']:='{}';
      LoginPrompt:=False;
      Connected:=True;
      with DBXConnection.CreateCommand do
      begin
        try
          CommandType := TDBXCommandTypes.DSServerMethod;
          Text := 'TServerMethods1.ModificaConexion';
          Prepare;
          Parameters[0].Value.SetWideString(Host);
          Parameters[1].Value.SetWideString(Ruta);
          Parameters[2].Value.SetWideString(Rutacliente);
          ExecuteUpdate;
        finally
          Free;
        end;
      end;
      if ejecutar then
      begin
        with DBXConnection.CreateCommand do
        begin
          try
            CommandType := TDBXCommandTypes.DSServerMethod;
            Text := 'TServerMethods1.EjecutaSQL';
            Prepare;
            Parameters[0].Value.SetWideString(Sentencia);
            ExecuteUpdate;
          finally
            Free;
          end;
        end;
      end
      Else begin
        Proveedor:=TDSProviderConnection.Create(nil);
        try
          Proveedor.SQLConnection:=Conexion;
          Proveedor.ServerClassName:='TServerMethods1';
          Proveedor.Connected:=True;
          Result:=TClientDataSet.Create(Owner);
          Result.RemoteServer:=Proveedor;
          Result.ProviderName:='DataSetProvider1';
          Result.CommandText:=Sentencia;
          Result.Open;
        finally
          FreeAndNil(Proveedor);
        end;
      end;
    finally
      Free;
    end;
end;

procedure ModificaFacturaGDB(Sentencia:String);
begin
{$IFDEF RELEASE}
  with TFDConnection.Create(nil) do
    try
      ConnectionDefName:='Factura_GDB';
      try
        Connected:=True;
        ExecSQL(Sentencia);
        Connected:=False;
      except
        ModificaBDRemota('LOCALHOST','C:\CAI\FACTURA.GDB',Sentencia);
      end;
    finally
      Free;
    end;
{$else}
  ModificaBDRemota('LOCALHOST','C:\CAI\FACTURA.GDB',Sentencia);
{$ENDIF}
end;

function CDSRestFacturaGDB(Sentencia:String;Owner:TComponent=nil):TClientDataset;
var
  Con:TFDConnection;
begin
{$IFDEF RELEASE}
  Con:=TFDConnection.Create(nil);
  try
    Con.ConnectionDefName:='Factura_GDB';
    try
      Con.Connected:=True;
      Result:=ClientDataSet2(Con,PChar(Sentencia),nil,Owner);
      Con.Connected:=False;
    except
      {$IFNDEF SINCRONIZAR}
      UniServerModule.Logger.AddLog('Fallo conexión directa, intentando conexión SOAP. Número de conexiones en el POOL: '+IntToStr(FDManager.ConnectionCount));
      {$ENDIF}
      Result:=CDSRemoto('https://www.caisistemas.es/prueba/ado.dll/soap/IConexiones','Factura_gdb',Sentencia);
    end;
  finally
    Con.Free;
  end;
{$else}
   Result:=CDSRemoto('https://www.caisistemas.es/prueba/ado.dll/soap/IConexiones','Factura_gdb',Sentencia);
{$endif}
end;


function CadenaFicheroPDF(RutaFichero:string):String;
begin
  Result:='';
  if FileExists(RutaFichero) then
    with TDebenuPDFLibrary1612.Create do
      try
        UnlockKey('jf77x88g5rt3bc3i99m44rs3y');
        LoadFromFile(RutaFichero,'');
        Result:=SaveToString;
      finally
        Free;
      end
end;


class procedure TipsHTTPSH.ipsHTTPSHeader(Sender: TObject; const Field,
  Value: string);
begin
  if not Assigned(TipsHTTPSH(Sender).Headers) then TipsHTTPSH(Sender).Headers:=TStringList.Create;
  TipsHTTPSH(Sender).Headers.AddPair(Field,Value);
end;

class procedure TipsHTTPSH.ipsHTTPSTransfer(Sender: TObject; Direction: Integer;
  BytesTransferred: Int64; PercentDone: Integer; Text: string);
begin
  TipsHTTPSH(Sender).Resultado:=TipsHTTPSH(Sender).Resultado+Text;
end;

class procedure TipwHTTPH.ipsHTTPSHeader(Sender: TObject; const Field,
  Value: string);
begin
  if not Assigned(TipsHTTPSH(Sender).Headers) then TipsHTTPSH(Sender).Headers:=TStringList.Create;
  TipsHTTPSH(Sender).Headers.AddPair(Field,Value);
end;

class procedure TipwHTTPH.ipwHTTPTransfer(Sender: TObject; Direction: Integer;
  BytesTransferred: Int64; PercentDone: Integer; Text: string);
begin
  TipwHTTPH(Sender).Resultado:=TipwHTTPH(Sender).Resultado+Text;
end;


procedure FusionarPDF(Conexion:TFDConnection;IDsListadoPersonalizado:array of Integer;Modelo,RutaPlantilla,RutaPDF:String;Anagrama:String='';Ejercicio:String='';NIF:String='');
var
  Aux,Titulo:String;
  Cabeceros:TFDMemTable;
  Codificacion:TFDQuery;
  i,j,k,Posicion:Integer;
  Importe:Real;
  ListaPaginas:TList;
  PPagina:PPaginaPDF;
  MS:TMemoryStream;
  QP:TDebenuPDFLibrary1612;
  FormaDePago:Char;
  Parametro:TFDParam;
begin
  {$IFNDEF SINCRONIZAR}
  for i:=0 to Length(IDsListadoPersonalizado)-1 do
  begin
    with CDSRestFacturaGDB('SELECT SENTENCIA FROM LISTADOSCONDICIONALES WHERE IDLISTADOSCONDICIONALES='+IntToStr(IDsListadoPersonalizado[i])) do
      try
        if i=0 then
        begin
          Codificacion:=ConsultaAD(Conexion,Fields.Fields[0].AsString,False,False);
          Parametro:=Codificacion.Params.FindParam('EJERCICIO');
          if Assigned(Parametro) then Parametro.Value:=Ejercicio;
          Parametro:=Codificacion.Params.FindParam('NIF');
          if Assigned(Parametro) then Parametro.Value:=NIF;
          Codificacion.Open;
          for j:=0 to Codificacion.Fields.Count-1 do Codificacion.Fields[j].ReadOnly:=False;
          Codificacion.Name:='Codificacion';
        end
        else begin
          with ConsultaAD(Conexion,Fields[0].AsString,True,False) do
            try
              Parametro:=Codificacion.Params.FindParam('EJERCICIO');
              if Assigned(Parametro) then Parametro.Value:=Ejercicio;
              Parametro:=Codificacion.Params.FindParam('NIF');
              if Assigned(Parametro) then Parametro.Value:=NIF;
              Open;
              while not Eof do
              begin
                Codificacion.Append;
                for j:=0 to Fields.Count-1 do Codificacion.Fields[j].Value:=Fields[j].Value;
                Codificacion.Post;
                Next;
              end;
            finally
              Free;
            end;
        end;
      finally
        Free;
      end
  end;

  Cabeceros:=TFDMemTable.Create(nil);
  Cabeceros.FieldDefs.Add('CABECERO',ftString,50);
  Cabeceros.FieldDefs.Items[Cabeceros.Fields.Count].CreateField(Cabeceros,nil,Cabeceros.FieldDefs.Items[Cabeceros.Fields.Count].Name);
  Cabeceros.Open;
  Cabeceros.IndexFieldNames:='CABECERO';
  Codificacion.First;
  while not Codificacion.Eof do
  begin
    if not Cabeceros.Locate('CABECERO',VarArrayOf([Codificacion.FieldByName('CABECERO').AsString]),[]) then
      Cabeceros.AppendRecord([Codificacion.FieldByName('CABECERO').AsString]);
    Codificacion.Next;
  end;
  Cabeceros.First;

  QP:=TDebenuPDFLibrary1612.Create;
  try
    QP.UnlockKey('jf77x88g5rt3bc3i99m44rs3y');
    try
      ListaPaginas:=TList.Create;
      try
        with Cabeceros do
          try
            while not Eof do
            begin
              QP.LoadFromFile(RutaPlantilla,'');
              QP.ExtractPages(RecNo,1);;
              QP.SetNeedAppearances(1);
              j:=1;
              for i:=QP.FormFieldCount downto 1 do
              begin
                Titulo:=trim(QP.GetFormFieldTitle(i));
                if EndsText('&',Titulo) then
                begin
                  Aux:=RightStr(Titulo,Pos('_',ReverseString(Titulo))-1);
                  j:=Math.Max(j,StrToInt(LeftStr(Aux,Length(Aux)-1)));
                end;
              end;
              for i:=1 to Ceil(StrStrCount(Modelo,FieldByName('CABECERO').AsString)/j) do
              begin
                New(PPagina);
                with PPagina^ do
                begin
                  Pagina:=TMemoryStream.Create;
                  QP.SaveToStream(Pagina);
                  Pagina.Seek(0,0);
                  Ocurrencia:=i;
                  Cuenta:=j;
                end;
                ListaPaginas.Add(PPagina);
              end;
              Next;
            end;
          finally
            Free;
          end;
        if ListaPaginas.Count>0 then
          try
            if Codificacion.Locate('NOMBRE',VarArrayOf(['FORMA_PAGO']),[]) then
              FormaDePago:=Copy(Modelo,StrFind(Codificacion.FieldByName('CABECERO').AsString,Modelo,1)+Codificacion.FieldByName('POSICION').AsInteger-1,Codificacion.FieldByName('LONGITUD').AsInteger)[1];
            for j:=0 to ListaPaginas.Count-1 do
            begin
              QP.LoadFromStream(TPaginaPDF(ListaPaginas[j]^).Pagina,'');
              TPaginaPDF(ListaPaginas[j]^).Pagina.Seek(0,0);
              for i:=QP.FormFieldCount downto 1 do
              begin
                try
                  Titulo:=trim(QP.GetFormFieldTitle(i));
                  if SameText(Titulo,'ANAGRAMA') then
                    QP.SetFormFieldValue(i,Anagrama)
                  else if (EndsText('&',Titulo) and Codificacion.Locate('NOMBRE',VarArrayOf([LeftStr(Titulo,Length(Titulo)-Pos('_',ReverseString(Titulo)))+'_X']),[])) or
                          Codificacion.Locate('NOMBRE',VarArrayOf([Titulo]),[]) then
                  begin
                    k:=TPaginaPDF(ListaPaginas[j]^).Ocurrencia;
                    if EndsText('&',Titulo) then
                    begin
                      Aux:=RightStr(Titulo,Pos('_',ReverseString(Titulo))-1);
                      k:=(k-1)*TPaginaPDF(ListaPaginas[j]^).Cuenta+StrToInt(LeftStr(Aux,Length(Aux)-1))
                    end;
                    Posicion:=-1;
                    while (k>0) and (Posicion<>0) do
                    begin
                      Posicion:=PosEx(Codificacion.FieldByName('CABECERO').AsString,Modelo,Math.Max(0,Posicion)+1);
                      Dec(k);
                    end;
                    if Posicion>0 then
                    begin
                      if SameText(Codificacion.FieldByName('NOMBRE').AsString,'FORMA_PAGO') then
                      begin
                        case FormaDePago of
                          'I':QP.SetFormFieldValue(i,'Ingreso');
                          'G':QP.SetFormFieldValue(i,'Ingreso a anotar en CCT');
                          'A':QP.SetFormFieldValue(i,'Aplazamiento');
                          'U':QP.SetFormFieldValue(i,'Domiciliación');
                          'N','C','D':QP.SetFormFieldValue(i,'');
                          else
                            QP.SetFormFieldValue(i,'Otras formas de pago');
                        end;
                      end
                      else if SameText(Trim(Codificacion.FieldByName('TIPO').AsString),'X') then
                        QP.SetFormFieldValue(i,IfThen(Trim(Copy(Modelo,Posicion+Codificacion.FieldByName('POSICION').AsInteger-1,Codificacion.FieldByName('LONGITUD').AsInteger))=Codificacion.FieldByName('VALOR').AsString,'X',''))
                      else if SameText(Trim(Codificacion.FieldByName('TIPO').AsString),'AN') then
                      begin
                        if (not EndsText('D',UpperCase(Codificacion.FieldByName('VALOR').AsString)) and
                            not EndsText('I',UpperCase(Codificacion.FieldByName('VALOR').AsString))) or
                           (UpperCase(Codificacion.FieldByName('VALOR').AsString)[Length(Codificacion.FieldByName('VALOR').AsString)]=FormaDePago) then
                          QP.SetFormFieldValue(i,Trim(Copy(Modelo,Posicion+Codificacion.FieldByName('POSICION').AsInteger-1,Codificacion.FieldByName('LONGITUD').AsInteger)))
                      end
                      else if SameText(Trim(Codificacion.FieldByName('TIPO').AsString),'NUM') or
                              SameText(Trim(Codificacion.FieldByName('TIPO').AsString),'N') then
                      begin
                        Importe:=StrToFloat(ReplaceText(Trim(Copy(Modelo,Posicion+Codificacion.FieldByName('POSICION').AsInteger-1,Codificacion.FieldByName('LONGITUD').AsInteger)),'N','-'))/Power(10,Codificacion.FieldByName('DECIMALES').AsInteger);
                        if StartsText('+',Codificacion.FieldByName('VALOR').AsString) then
                          Importe:=Max(Importe,0)
                        else if StartsText('-',Codificacion.FieldByName('VALOR').AsString) then
                        begin
                          Importe:=Max(-Importe,0);
                        end;
                        if (EndsText('C',UpperCase(Codificacion.FieldByName('VALOR').AsString)) or
                            EndsText('D',UpperCase(Codificacion.FieldByName('VALOR').AsString))) and
                           (UpperCase(Codificacion.FieldByName('VALOR').AsString)[Length(Codificacion.FieldByName('VALOR').AsString)]<>FormaDePago) then
                          Importe:=0;
                        QP.SetFormFieldValue(i,FormatFloat(',0'+IfThen(Codificacion.FieldByName('DECIMALES').AsInteger=0,'','.'+DupeString('0',Codificacion.FieldByName('DECIMALES').AsInteger)),Importe));
                      end;
                    end;
                  end;
                  QP.UpdateAndFlattenFormField(i);
                except
                  UniServerModule.Logger.AddLog('Error en el campo: '+Titulo+' - '+Trim(Copy(Modelo,Posicion+Codificacion.FieldByName('POSICION').AsInteger-1,Codificacion.FieldByName('LONGITUD').AsInteger))+#13#10+
                                                'Fichero: '+Modelo);
                  Raise;
                end;
              end;
              QP.SaveToStream(TPaginaPDF(ListaPaginas[j]^).Pagina);
            end;
          finally
            while ListaPaginas.Count>1 do
            begin
              MS:=TPaginaPDF(ListaPaginas[0]^).Pagina;
              try
                TPaginaPDF(ListaPaginas[0]^).Pagina:=TMemoryStream.Create;
                QP.MergeStreams(MS,TPaginaPDF(ListaPaginas[1]^).Pagina,TPaginaPDF(ListaPaginas[0]^).Pagina);
              finally
                FreeAndNil(MS);
              end;
              TPaginaPDF(ListaPaginas[0]^).Pagina.Seek(0,0);
              FreeAndNil(TPaginaPDF(ListaPaginas[1]^).Pagina);
              Dispose(ListaPaginas[1]);
              ListaPaginas.Remove(ListaPaginas[1])
            end;
            QP.LoadFromStream(TPaginaPDF(ListaPaginas[0]^).Pagina,'');
            QP.SaveToFile(RutaPDF);
            Dispose(ListaPaginas[0]);
            ListaPaginas.Remove(ListaPaginas[0]);
          end;
      finally
        FreeAndNil(ListaPaginas);
      end;
    finally
      FreeAndNil(QP);
    end;
  finally
    FreeAndNil(Codificacion);
  end;
  {$ENDIF}
end;

function Fecha_USA(pfecha : TDateTime) : string;
begin
  result:=FormatDateTime('mm/dd/yyyy',pfecha);
end;

procedure LiberarComponente(Control:TUniControl);
var
  i:Integer;
begin
  if Control is TUniContainer then
  begin
    for i:=TUniContainer(Control).ControlCount-1 downto 0 do
      LiberarComponente(TUniControl(TUniContainer(Control).Controls[i]));
    FreeAndnil(Control);
  end
  else
    FreeAndNil(Control);
end;

function NombreProvincia(Codigo:Integer):String;
begin
  {$IFNDEF SINCRONIZAR}
  Result:='';
  with ConsultaAD(UniMainModule.ADConexionGeneral,'SELECT NOMBRE FROM PROVINCI WHERE CODIGO='+IntToStr(Codigo)) do
    try
      if not IsEmpty then result:=Fields[0].AsString;
    finally
      Free;
    end;
  {$ENDIF}
end;

function EnlazadoConCAIMAE(IDUsuario:Integer;Programa:String):Boolean;
begin
  with CDSRestFacturaGDB('SELECT ENLACES_CAIMAEWEB.EMPRESA'+#13#10+
                 'FROM ENLACES_CAIMAEWEB'+#13#10+
                 'INNER JOIN USUARIOS ON (USUARIOS.EMPRESA=ENLACES_CAIMAEWEB.EMPRESA)'+#13#10+
                 'INNER JOIN PROGRAMAS_WEB ON (IDPROGRAMAS_WEB=IDFPROGRAMAS_WEB)'+#13#10+
                 'WHERE IDUSUARIOS='+IntToStr(IDUsuario)+' AND PROGRAMA='+QuotedStr(Programa)) do
    try
      Result:=not IsEmpty;
    finally
      Free;
    end;
end;

function Conexion(Ruta:String):TSQLConnectionC;
var
  Con:TSQLCOnnectionC;
begin
  Con:=TSQLConnectionC.Create(nil);
  with Con do
  begin
       Drivername := 'Firebird';
       LibraryName := 'dbxfb.dll';
       VendorLib := 'fbclient.dll';
       GetDriverFunc := 'getSQLDriverINTERBASE';
       Params.Add('DriverUnit=Data.DBXFirebird');
       Params.Add('DriverPackageLoader=TDBXDynalinkDriverLoader,DbxCommonDriver160.bpl');
       Params.Add('DriverAssemblyLoader=Borland.Data.TDBXDynalinkDriverLoader,Borland.Data.DbxCommonDriver,Version=16.0.0.0,Culture=neutral,PublicKeyToken=91d62ebb5b0d1b1b');
       Params.Add('MetaDataPackageLoader=TDBXFirebirdMetaDataCommandFactory,DbxFirebirdDriver160.bpl');
       Params.Add('MetaDataAssemblyLoader=Borland.Data.TDBXFirebirdMetaDataCommandFactory,Borland.Data.DbxFirebirdDriver,Version=16.0.0.0,Culture=neutral,PublicKeyToken=91d62ebb5b0d1b1b');
       Params.Add('GetDriverFunc=getSQLDriverINTERBASE');
       Params.Add('LibraryName=libmysql.dll');
       Params.Add('LibraryNameOsx=libsqlfb.dylib');
       Params.Add('VendorLibWin64=dbxfb.dll');
       Params.Add('VendorLibOsx=/Library/Frameworks/Firebird.framework/Firebird');
       Params.Add('User_Name=SYSDBA');
       Params.Add('Password=masterkey');
       Params.Add('Role=RoleName');
       Params.Add('MaxBlobSize=-1');
       Params.Add('LocaleCode=0000');
       Params.Add('IsolationLevel=ReadCommitted');
       Params.Add('SQLDialect=3');
       Params.Add('CommitRetain=False');
       Params.Add('WaitOnLocks=True');
       Params.Add('TrimChar=False');
       Params.Add('BlobSize=-1');
       Params.Add('ErrorResourceFile=');
       Params.Add('RoleName=RoleName');
       if Pos('/3',Ruta)>0 then
         Params.Add('ServerCharSet=ISO8859_1')
       else
         Params.Add('ServerCharSet=');
       Params.Add('Trim Char=False');
       Params.Values['DATABASE']:=Ruta;
       LoginPrompt:=False;
    try
      Connected:=True;
    except
      Raise;
      FreeAndNil(Con);
    end;
  end;
  Result:=Con;
end;

function ClientDataSet3(Conexion:TSQLConnectionC;Consulta:PChar;CDS:TClientDataset=nil;Owner:TComponent=nil):TCLientDataset;
var
  Query:TSQLQuery;
  DSP:TDataSetProvider;
  CDSAux:TClientDataSet;
begin
  Query:=TSQLQuery.Create(nil);
  try
    if Conexion.Depura then ClipBoard.SetTextBuf(Consulta);
    Query.ParamCheck:=False;
    Query.SQLConnection:=Conexion;
    DSP:=TDataSetProvider.Create(nil);
    try
      DSP.Options:=DSP.Options+[poAllowCommandText,poRetainServerOrder];
      DSP.DataSet:=Query;
      if CDS=nil then
        CDSAux:=TClientDataset.Create(Owner)
      else
        CDSAux:=CDS;
      CDSAux.SetProvider(DSP);
      CDSAux.CommandText:=Consulta;
      try
        CDSAux.Open;
      except
        FreeAndNil(CDSAux);
      end;
    finally
      FreeAndNil(DSP);
    end;
  finally
    FreeAndNil(Query);
  end;
  Result:=CDSAux;
end;

function VaciaSeccion(HTML,Seccion:String):String;
var
  i,j:Integer;
begin
  i:=Pos('<'+UpperCase(Seccion)+'>',UpperCase(HTML));
  j:=Pos('</'+UpperCase(Seccion)+'>',UpperCase(HTML));
  Result:=HTML;
  System.Delete(Result,i+Length('<'+UpperCase(Seccion)+'>'),j-i-Length('<'+UpperCase(Seccion)+'>'));
end;

procedure AsignarParametros(Destino,Origen:TFDParams);
var
  i:Integer;
  Parametro:TFDParam;
begin
  for i:=0 to Origen.Count-1 do
  begin
    Parametro:=Destino.FindParam(Origen.Items[i].Name);
    if Assigned(Parametro) then
      Parametro.Value:=Origen.Items[i].Value;
  end;
end;

procedure AsignarMacros(Destino,Origen:TFDMacros);
var
  i:Integer;
  Macro:TFDMacro;
begin
  for i:=0 to Origen.Count-1 do
  begin
    Macro:=Destino.FindMacro(Origen.Items[i].Name);
    if Assigned(Macro) then
      Macro.Value:=Origen.Items[i].Value;
  end;
end;

function GetCertDisplayName(Cert : TelX509Certificate) : string;
begin
  try
    Result := GetOIDValue(Cert.SubjectRDN, SB_CERT_OID_COMMON_NAME);
    if Result = '' then
      Result := GetOIDValue(Cert.SubjectRDN, SB_CERT_OID_ORGANIZATION);
  except Result:=''; end;
end;

function GetOIDValue(NTS: TElRelativeDistinguishedName; const S: RawByteString; const Delimeter: AnsiString = ' / '): AnsiString;
var
  i: Integer;
  t: AnsiString;
begin
  Result:='';
  for i:=0 to NTS.Count-1 do
    if CompareContent(S, NTS.OIDs[i]) then
    begin
      t:=AnsiString(NTS.Values[i]);
      if t='' then Continue;
      if Result='' then
      begin
        Result:=t;
        if Delimeter='' then Exit;
      end
      else
        Result:=Result+Delimeter + t;
    end;
end;

procedure CertificadoNombreNIF(Certificado,Clave:string; var sFIRNIF : string; var sFIRNOMBRE: string; var Organizacion: Boolean);
var
  j : Integer;
  dummy : TElMemoryCertStorage;
  s : string;
  SS:TStringStream;
  ICertificado:Integer;
begin
  sFIRNIF  := '';
  sFIRNOMBRE := '';
  Organizacion := False;

  dummy := TElMemoryCertStorage.Create(nil);
  with dummy do
  try
    SS:=TStringStream.Create;
    try
      SS.WriteString(Certificado);
      SS.Seek(0,0);
      LoadFromStreamPFX(SS,Clave);
    finally
      FreeAndNil(SS);
    end;
    ICertificado:=0;
    while (ICertificado<dummy.Count) and not dummy.Certificates[ICertificado].PrivateKeyExists do Inc(ICertificado);

    Organizacion:=UTF8Decode(GetOIDValue(Certificates[ICertificado].SubjectRDN,SB_CERT_OID_ORGANIZATION))<>'';
    if Organizacion then
    begin
      if UTF8Decode(GetOIDValue(Certificates[ICertificado].IssuerRDN, SB_CERT_OID_ORGANIZATION_UNIT)) = 'FNMT Clase 2 CA' then
      begin
        s := GetOIDValue(Certificates[ICertificado].SubjectRDN,SB_CERT_OID_COMMON_NAME);
        sFIRNOMBRE:=Copy(s,1, PosEx(' - ', s)-1);
        if Pos('ENTIDAD ', sFIRNOMBRE) = 1 then
              sFIRNOMBRE:=Copy(sFIRNOMBRE,9, length(sFIRNOMBRE))
        else if Pos('NOMBRE ', sFIRNOMBRE) = 1 then
              sFIRNOMBRE:=Copy(sFIRNOMBRE,8, length(sFIRNOMBRE));

        if Pos('NOMBRE ', Copy(s,1, PosEx(' - ', s)-1)) = 1 then
              sFIRNIF:=Trim(Copy(s, PosEx(' - NIF ', s)+7, 12))
        else begin
              sFIRNIF:=Copy(s, PosEx(' - CIF ', s)+7, 200);
              sFIRNIF:=Copy(sFIRNIF, 1, PosEx(' - ', sFIRNIF)-1);
        end;
      end
      else
      if UTF8Decode(GetOIDValue(Certificates[ICertificado].IssuerRDN, SB_CERT_OID_ORGANIZATION_UNIT)) = 'CERES' then
      begin
        sFIRNOMBRE:=UTF8Decode(GetOIDValue(Certificates[ICertificado].SubjectRDN,SB_CERT_OID_ORGANIZATION));
        sFIRNIF:=ReplaceText(UTF8Decode(GetOIDValue(Certificates[ICertificado].SubjectRDN,'U'#4#$61)),'VATES-','');
      end;
    end
    else
    begin
      sFIRNOMBRE := UTF8Decode(GetOIDValue(Certificates[ICertificado].SubjectRDN,SB_CERT_OID_COMMON_NAME));  //   SB_CERT_OID_COMMON_NAME   #$55#$04#$03
      if sFIRNOMBRE = '' then
      begin
        // >2.5.4.4<>0.85.4.4< : Ruiz de la Plaza
        // >2.5.4.42<>0.85.4.42< : Antonio
        sFIRNOMBRE := TrimLeft(UTF8Decode(GetOIDValue(Certificates[ICertificado].SubjectRDN,#$55#$04#$04))
          + ' ') + UTF8Decode(GetOIDValue(Certificates[ICertificado].SubjectRDN,#$55#$04#$2A));
      end
      else
        if Pos('-',sFIRNOMBRE) > 0 then
          sFIRNOMBRE := Copy(sFIRNOMBRE,1,Pos('-',sFIRNOMBRE)-1);   // Quitamos el NIF
      sFIRNIF:=ReplaceText(UTF8Decode(GetOIDValue(Certificates[ICertificado].SubjectRDN,SB_CERT_OID_SERIAL_NUMBER)),'IDCES-','');
    end;
    sFIRNOMBRE:=ReplaceText(sFIRNOMBRE,'ñ','Ñ');
  finally
    Free;
  end;

end;

function FieldValueToFloat(F:TField):real;
begin
  if VarIsNull(F.Value) then
    result:=0
  else
    result:=F.Value;
end;

function HashSHA256(RutaFichero:String):String;
var
  FS:TFileStream;
  SHA:TIdHashSHA256;
  Hash:TIdBytes;
begin
  LoadOpenSSLLibrary;
  if TIdHashSHA256.IsAvailable then
  begin
    FS:=TFileStream.Create(RutaFichero,fmOpenRead);
    try
      SHA := TIdHashSHA256.Create;
      try
        Hash := SHA.HashStream(FS);
      finally
        SHA.Free;
      end;
    finally
      FS.Free;
    end;
  end;
  result:=EncodeBase64(@Hash[0],32);
end;

function NumeroPaginas(FicheroPDF:String):Integer;
var
  QP:TDebenuPDFLibrary1612;
begin
  Result:=0;
  QP:=TDebenuPDFLibrary1612.Create;
  try
    QP.UnlockKey('jf77x88g5rt3bc3i99m44rs3y');
    if FileExists(FicheroPDF) then
    begin
      QP.LoadFromFile(FicheroPDF,'');
      Result:=QP.PageCount;
    end
  finally
    FreeAndNil(QP);
  end;
end;

procedure EncriptarFichero(FicheroEntrada,FicheroSalida,Clave:String);
begin
  HazPost('https://portalcai.es/php/encripta.php',
          ['RUTA='+Base64EncodeString(FicheroEntrada),
           'DESTINO='+Base64EncodeString(FicheroSalida),
           'CLAVE='+Base64EncodeString(Clave)]);
//  with TAESEncryption.Create(nil) do
//    try
//      AType:=atECB;
//      KeyLength:=kl128;
//      Unicode := yesUni;
//      Key:= Clave+DupeString(#0,16-Length(Clave));
//      OutputFormat:=hexa;
//      PaddingMode:= TpaddingMode.PKCS7;
//      IVMode:= TIVMode.rand;
//      EncryptFileW(FicheroEntrada,FicheroSalida);
//    finally
//      Free;
//    end;
end;

function NodoXML(Raiz:IXMLNode;Nombres:array of String):IXMLNode;
var
  i,j:integer;
begin
  result:=Raiz;
  i:=0;
  while (result<>nil) and (i<length(Nombres)) do
  begin
    j:=0;
    while (j<Result.ChildNodes.Count) and (not SameText(Result.ChildNodes.Nodes[j].NodeName,Nombres[i])) do j:=j+1;
    if j<Result.ChildNodes.Count then
      Result:=Result.ChildNodes.Nodes[j]
    else
      Result:=nil;
    Inc(i);
  end;
end;

function ValorNodoXML(Raiz:IXMLNode;Nombres:array of String):String;
var
  Nodo:IXMLNode;
begin
  Nodo:=NodoXML(Raiz,Nombres);
  if assigned(Nodo) then
  begin
    if VarIsNull(Nodo.NodeValue) then
      result:=''
    else
      result:=Nodo.NodeValue
  end
  else
    result:=unassigned
end;

function ObtenNIF(Entrada:String):String;
var
  i:integer;
begin
  result:='';
  for i:=1 to length(Entrada) do
    if UpperCase(Entrada)[i] in ['0'..'9','A'..'Z'] then result:=result+UpperCase(copy(Entrada,i,1));
  if length(result)>9 then
    delete(result,1,length(result)-9);
end;

function FirebirdFloat(Valor:Real; ForzarSigno:Boolean = False):String;
begin
  Result := '';
  if ForzarSigno and (Valor > 0) then
    Result := '+';
  Result:=Result+ReplaceText(FloatToStr(Valor),',','.');
  if Result='NAN' then Result:='0';  
end;

function NombrePais(Clave:String):String;
begin
  {$IFNDEF SINCRONIZAR}

  with ConsultaAD(UniMainModule.ADConexionGeneral,'SELECT NOMBRE FROM PAISES WHERE UPPER(CLAVE)='''+UpperCase(Clave)+'''') do
    try
      Result:=FieldByName('NOMBRE').AsString;
    finally
      Free;
    end;
 {$ENDIF}
end;

function CSSVersion6:String;
begin
  Result:='.x-panel-body-default,.x-form-cb-label-default,.x-form-text-default{'+#13#10+
          '    font-size: 11px!IMPORTANT;'+#13#10+
          '    line-height: normal!IMPORTANT;'+#13#10+
          '}'+#13#10+
          '.x-title-icon-wrap{' +#13#10+
          '    display: none!IMPORTANT;'+#13#10+
          '}'+#13#10+
          '.x-tab-bar-default{'+#13#10+
          '  background-color:white!important;'+#13#10+
          '}'+#13#10+
          '.x-progress-text{display:none !important;}';
end;

function ConexionAD(Ruta:String;Usuario:String='SYSDBA';password:String='masterkey';Owner:TComponent=nil;NombreDriver:String='FB'):TFDConnection;
begin
  result:=TFDConnection.Create(Owner);
  with result do
  begin
    DriverName:=NombreDriver;
    LoginPrompt:=False;
    FetchOptions.Unidirectional:=True;
    FetchOptions.AutoFetchAll:=afDisable;
    Params.Values['USER_NAME']:=usuario;
    Params.Values['PASSWORD']:=password;
    Params.Values['CHARACTERSET']:='ISO8859_1';
    Params.Values['DATABASE']:=Ruta;
    try
      Connected:=True;
    except
      FreeAndNil(Result);
    end;
  end;
end;

function Trozo(Cadena:String;Delimitadores:String;Numero:Integer):String;
var
  Token,i:Integer;
begin
  Token:=1;
  i:=1;
  while (Token<Numero) and (i<=length(Cadena)) do
  begin
    if Pos(Cadena[i],Delimitadores)>0 then Token:=Token+1;
    i:=i+1;
  end;
  result:='';
  while (pos(Cadena[i],Delimitadores)=0) and (i<=length(Cadena)) do
  begin
    result:=result+Cadena[i];
    i:=i+1;
  end;
end;

procedure FicheroAnsiAutf8(Fichero:String);
var
  FS:TFileStream;
  MS:TMemoryStream;
begin
  FS:=TFileStream.Create(Fichero,fmOpenReadWrite);
  try
    MS:=TMemoryStream.Create;
    with MS do
      try
        ConvertStreamFromAnsiToUTF8(FS,MS);
        FS.Size:=0;
        FS.CopyFrom(MS,MS.Size);
        MS.Size:=0;
      finally
        FreeAndNil(MS);
      end;
  finally
    FreeAndNil(FS);
  end;
end;


procedure HTMLaPDF(RutaHTML,RutaPDF:String;IncrustarTrueType:boolean);
begin
  {$IFNDEF SINCRONIZAR}
  with TipsHTTPS.Create(nil) do
    try
      ContentType:='application/x-www-form-urlencoded';
      PostData:='HTML='+URLEncode(TIdEncoderMIME.EncodeString(TFile.ReadAllText(RutaHTML,TEncoding.ANSI)))+'&'+
                'TRUETYPE='+IfThen(IncrustarTrueType,'1','0');
      User:='ernesto';
      Password:='Cai2000';
      Post('https://portalcai.es/httpsprivado/html2pdf.dll/HTML2PDF');
      TFile.WriteAllText(RutaPDF,TransferredData,TEncoding.ANSI);
    finally
      Free;
    end;
  {$ENDIF}
end;

{ TUniDBGridH }

procedure TUniDBGridH.CancelaEdicion;
begin
  Self.CancelEditing(True);
end;

function TUniDBGridH.ColumnaActual: Integer;
begin
  Result:=Self.CurrCol;
end;

procedure TUniDBGridH.PonEdicicon;
begin
  Self.StartEditor(Self.CurrRow,Self.CurrCol);
end;

procedure TUniDBGridH.SituaColumna(Columna: Integer);
begin
  Self.SetCurrCol(Columna);
end;


{ TDummyClass }

class procedure TDummyClass.HTTPRIOHTTPWebNodeBeforePost(
  const HTTPReqResp: THTTPReqResp; Client:THTTPClient);
var
  TimeOut: Integer;
begin
  // Sets the receive timeout. i.e. how long to wait to 'receive' the response
  TimeOut := (30*1000);
  try
    Client.ConnectionTimeout:=TimeOut;
    Client.ResponseTimeout:=TimeOut;
  except on E:Exception do
    raise Exception.Create(Format('Unhandled Exception:[%s] while setting timeout to [%d] - ',[E.ClassName, TimeOut, e.Message]));
  end;
end;

function DirectorioTemporal: string;
begin
  {$IFNDEF SINCRONIZAR}
    result := UniServerModule.LocalCachePath;
  {$ENDIF}
end;


function ReplaceInvalidFileNameChars(const aFileName:  string; const aReplaceWith: Char = '_'): string;
var
  i: integer;
begin
  Result := aFileName;
  for i := 1 to Length(Result) do
    if not TPath.IsValidFileNameChar(Result[i]) then
      Result[i] := aReplaceWith;
end;

function PasaTabla(ConexionOrigen,ConexionDestino:TFDConnection;Tabla:String;CamposCambio,CamposValores,CamposDestino,ValoresDestino,CamposAEvitar:Array of String;DS:array of TFDDataSet;Filtro:String;CampoIDError:String;EvitarCampos:boolean;Tabla2:string):String;
var
  ListaCampos,ListaValores:TStringList;
  ConsultaOrigen:TFDDataSet;
  i,j,k:integer;
  ConsultaInsercion:TFDQuery;
  CamposAdicionales,CampoID,CalculoID:String;
begin
  CamposAdicionales:='';
  for i:=0 to Length(CamposCambio)-1 do
    CamposAdicionales:=CamposAdicionales+'('+CamposValores[i]+') '+CamposCambio[i]+',';

  result:='';
  try
    try
      ListaCampos:=TStringList.Create;
      ListaCampos.Delimiter:=',';
      ListaValores:=TStringList.Create;
      ListaValores.Delimiter:=',';
      ConexionDestino.ExecSQL('DELETE FROM '+Tabla+IfThen(Trim(Filtro)='','',' WHERE '+Filtro));
      ConsultaOrigen:=ConsultaAD(ConexionOrigen,
                                 'SELECT '+CamposAdicionales+Tabla+'.* FROM '+Tabla+IfThen(Trim(Filtro)='','',' WHERE '+Filtro));
      if EvitarCampos then
      begin
        with ConsultaAD(ConexionDestino,
                        'SELECT TRIM(RDB$RELATION_FIELDS.RDB$FIELD_NAME) CAMPO'+#13#10+
                        'FROM RDB$RELATION_FIELDS'+#13#10+
                        'INNER JOIN RDB$FIELDS ON (RDB$RELATION_FIELDS.RDB$FIELD_SOURCE=RDB$FIELDS.RDB$FIELD_NAME)'+#13#10+
                        'WHERE RDB$RELATION_NAME='+QuotedStr(UpperCase(IfThen(Tabla2<>'',Tabla2,IfThen(pos(' ',Tabla)=0,Tabla,copy(Tabla,1,Pos(' ',Tabla)-1)))))+' AND'+#13#10+
                        '      RDB$COMPUTED_SOURCE IS NULL',False) do
          try
            IndexFieldNames:='CAMPO';
            for i:=0 to ConsultaOrigen.Fields.Count-1 do
            begin
              if Locate('CAMPO',VarArrayOf([UpperCase(ConsultaOrigen.Fields.Fields[i].FieldName)]),[]) then
              begin
                j:=0;
                while (j<Length(CamposAEvitar)) and (UpperCase(trim(CamposAEvitar[j]))<>UpperCase(ConsultaOrigen.Fields.Fields[i].FieldName)) do j:=j+1;
                if j=Length(CamposAEvitar) then
                begin
                  ListaCampos.Add(ConsultaOrigen.Fields[i].FieldName);
                  ListaValores.Add(':'+ConsultaOrigen.Fields[i].FieldName);
                end;
              end;
            end
          finally
            Free;
          end;
      end
      else
        for i:=0 to Length(CamposAEvitar)-1 do
          if ConsultaOrigen.FindField(CamposAEvitar[i])<>nil then
          begin
            ListaCampos.Add(CamposAEvitar[i]);
            ListaValores.Add(':'+CamposAEvitar[i]);
          end;

      for i:=0 to Length(CamposDestino)-1 do
        if Pos('GEN_ID',UpperCase(ValoresDestino[i]))=0 then
        begin
          j:=ListaCampos.IndexOf(CamposDestino[i]);
          if j=-1 then
          begin
            ListaCampos.Add(CamposDestino[i]);
            ListaValores.Add('('+ValoresDestino[i]+')');
          end
        end
        else begin
          CampoID:=CamposDestino[i];
          CalculoID:=ValoresDestino[i];
        end;

      ConsultaInsercion:=ConsultaAD(ConexionDestino,
                                    'INSERT INTO '+UpperCase(IfThen(Tabla2<>'',Tabla2,IfThen(pos(' ',Tabla)=0,Tabla,copy(Tabla,1,Pos(' ',Tabla)-1))))+'('+ListaCampos.DelimitedText+') VALUES('+ListaValores.DelimitedText+')',True,False);
      try
        ConsultaInsercion.Params.ArraySize:=10000;
        while not ConsultaOrigen.Eof do
        begin
          k:=0;
          while (not ConsultaOrigen.Eof) and (k<ConsultaInsercion.Params.ArraySize) do
          begin
            for i:=0 to ConsultaInsercion.Params.Count-1 do
              if SameText(CampoID,ConsultaInsercion.Params[i].Name) then
              begin
                ConsultaInsercion.Params.Items[i].Values[k]:=ConexionDestino.ExecSQLScalar('SELECT '+CalculoID+' FROM RDB$DATABASE');
                if (Length(DS)>0) and (Assigned(DS[0])) then
                  DS[0].AppendRecord([ConsultaOrigen.FieldByName(CampoID).AsInteger,
                                      ConsultaInsercion.Params.Items[i].Values[k]]);
              end
              else if (Length(DS)=2) and SameText(DS[1].Name,ConsultaInsercion.Params[i].Name) and DS[1].Locate('ID1',VarArrayOf([ConsultaOrigen.FieldByName(DS[1].Name).AsInteger]),[]) then
                ConsultaInsercion.Params.Items[i].Values[k]:=DS[1].Fields[1].Value
              else
                ConsultaInsercion.Params.Items[i].Values[k]:=ConsultaOrigen.FieldByName(ConsultaInsercion.Params.Items[i].Name).Value;
            Inc(k);
            ConsultaOrigen.Next;
          end;
          ConsultaInsercion.Execute(k);
        end;
      finally
        FreeAndNil(ConsultaInsercion);
      end;
    except
      if ConexionDestino.InTransaction then ConexionDestino.Rollback;
      raise;
      if CampoIDError<>'' then result:=ConsultaOrigen.FieldByName(CampoIDError).AsString;
    end;
  finally
    FreeAndNil(ConsultaOrigen);
    FreeAndNil(ListaCampos);
    FreeAndNil(ListaValores);
  end;
end;

function Version(const AFileName: string): TVersionnAplicacion;
var
  FileName: string;
  LinfoSize: DWORD;
  lpdwHandle: DWORD;
  lpData: Pointer;
  lplpBuffer: PVSFixedFileInfo;
  puLen: DWORD;
begin
  FileName := AFileName;
  UniqueString(FileName);
  LinfoSize := GetFileVersionInfoSize(PChar(FileName), lpdwHandle);
  if LinfoSize <> 0 then
  begin
    GetMem(lpData, LinfoSize);
    try
      if GetFileVersionInfo(PChar(FileName), lpdwHandle, LinfoSize, lpData) then
        if VerQueryValue(lpData, '\', Pointer(lplpBuffer), puLen) then
          Result.Version:=Format('%.2d.%.2d',[HiWord(lplpBuffer.dwFileVersionMS),LoWord(lplpBuffer.dwFileVersionMS)]);
          Result.Build:=Format('%d.%d',[HiWord(lplpBuffer.dwFileVersionLS),LoWord(lplpBuffer.dwFileVersionLS)]);
    finally
      FreeMem(lpData);
    end;
  end;
end;

function LimpiarAcentos(const cadena: string) : string;
const
  CA='ÁÉÍÓÚÀÈÌÒÙÄËÏÖÜÂÊÎÔÛáéíóúàèìòùäëïöüâêîôûªº';
  CB='AEIOUAEIOUAEIOUAEIOUaeiouaeiouaeiouaeiou..';
var
  i,P:Integer;
begin
  Result:=cadena;
  for i:=1 to Length(Result) do
  begin
    P:=Pos(Result[i],CA);
    if P>0 then
      Result[i]:=CB[P];
  end;
end;

function SoloNumeros(paCantidad: string; paDevolverCero: boolean): string;
var
   loSw:       integer;
   loTamano:   integer;
   loCantidad: string;
begin
   loCantidad := '';
   loTamano   := Length(paCantidad);

   for loSw := 1 to loTamano do begin
      if Pos(paCantidad[loSw],'0123456789') <> 0 then
         loCantidad := loCantidad + paCantidad[loSw];
   end;

   if ((loCantidad = '') and (paDevolverCero)) then
      loCantidad := '0';

   Result := loCantidad;
end;

//***************************************************
function SoloLetrasoNumeros(paTexto: string): string;
var
   loSw:     integer;
   loTamano: integer;
   loTexto:  string;
begin
   loTexto  := '';
   loTamano := Length(paTexto);

   for loSw := 1 to loTamano do begin
      if Pos(paTexto[loSw],'ABCDEFGHIJKLMNÑOPQRSTUVWXYZ0123456789') <> 0 then
         loTexto := loTexto + paTexto[loSw];
   end;

   Result := loTexto;
end;

function DevolverNoCero(Valor1,Valor2:Double):Double;
begin
  Result := Valor1;
  if Result = 0 then  Result := Valor2;
end;
function ValidaLOGINYPASSWORD(LOGIN,CONTRASENA:string;ValidarUsuario:Boolean=True):boolean;
var
  i: Integer;
begin
  result:=Length(CONTRASENA)>=6;
  if not result then
    uniGUIDialogs.ShowMessage('Ha de insertar una contraseña mayor o igual a 6 caracteres.'+#13+#10+
                              'La contraseña ha de tener al menos un caracter numérico, una letra minúscula y otra mayúscula')
  else begin
    result:=TRegEx.IsMatch(CONTRASENA,'(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).*$');
    if not result then
      uniGUIDialogs.ShowMessage('La contraseña ha de tener al menos un caracter numérico, una letra minúscula y otra mayúscula')
  end;
  if result and ValidarUsuario then
  begin
    result:=Length(LOGIN)>=6;
    if not result then
      uniGUIDialogs.ShowMessage('Ha de insertar un nombre de usuario mayor o igual a 6 caracteres.')
    else begin
      i:=1;
      while (i<=Length(LOGIN)) and (LOGIN[i] in ['0'..'9','a'..'z','A'..'Z','_','-','.']) do Inc(i);
      Result:=i>Length(LOGIN);
      if not result then
        uniGUIDialogs.ShowMessage('Caracter '+LOGIN[i]+' no permitido en nombre de usuario')
    end;
  end;
end;

function DescargaFicheroHTTPS(Usuario,Contrasena,FicheroLocal,FicheroRemoto:String):Boolean;
begin
  Result:=False;
  if (FicheroLocal <>'') and (FicheroRemoto <> '') then
    try
      with TipsHTTPSH.Create(nil) do
        try
          User:= Usuario;   //
          Password:=Contrasena; //
          LocalFile:=FicheroLocal;
          Get(ReplaceText(FicheroRemoto,' ','%20'));
          Result:=True;
        finally
          Free;
        end;
    except
      Result:=False;
    end;
end;

function capitalize(s: string): string;
var
  flag: boolean;
  i : byte;
  t : Ansistring;
begin
  flag := true;
  s:=lowercase(s);
  t := '';
  for i := 1 to length(s) do
  begin
    if flag then appendstr(t, upcase(s[i]))
    else appendstr(t, s[i]);
    flag := (s[i] = ' ')
  end;
  result := t
end;

function EjecutaComando(Directorio,Comando:String):DWord;
var
  StartupInfo: TStartupInfo;
  ProcessInfo: TProcessInformation;
  pCurrentDir: pChar;
  CreResult:LongBool;
begin
  //Fill the record with 0's so you don't pass in random bollox to the API call
  FillChar (StartupInfo, SizeOf(StartupInfo), 0);
  //and tell it the size of itself
  StartupInfo.cb := SizeOf(StartupInfo);
  StartupInfo.dwFlags:=STARTF_USESHOWWINDOW;
	StartupInfo.wShowWindow:= SW_HIDE;  //setup default dir

  pCurrentDir := pChar(Directorio);
  //Now do the API call

  CreResult:=CreateProcess(nil, pChar(Comando), nil, nil, False, 0, nil, pCurrentDir, StartupInfo, ProcessInfo);
  if CreResult=true then
  begin
    try
      case WaitForSingleObject(ProcessInfo.hProcess, {12000)//test}INFINITE) of
        WAIT_ABANDONED:;
//            MessageBox(0, PChar('WAIT_ABANDONED'), PChar('Process returned'), 0);
        WAIT_OBJECT_0:;
//            MessageBox(0, PChar('WAIT_OBJECT_0'), PChar('Process returned'), 0);
        WAIT_TIMEOUT:;
//            MessageBox(0, PChar('WAIT_TIMEOUT'), PChar('Process returned'), 0);
        WAIT_FAILED:;
//            MessageBox(0, PChar('WAIT_FAILED'), PChar('Process returned'), 0);
      end;
      GetExitCodeProcess(ProcessInfo.hProcess, Result);
    finally
      CloseHandle(ProcessInfo.hThread);
      CloseHandle(ProcessInfo.hProcess);
    end;
  end
end;


{ TFDConnectionHelper }

procedure TFDConnectionHelper.EjecutaSQL(Sentencia: String;
  Transaccion: TFDTransaction);
begin
  with ConsultaAD(Self,Sentencia,False,False,Transaccion) do
    try
      try
        ExecSQL;
      except
        UniServerModule.Logger.AddLog('CONSULTA FALLIDA'+IFThen(Self.Connected,'(Conectado)','(No conectado)')+#13#10+'================'#13#10+Sentencia);
      end;
    finally
      Free;
    end;
end;

initialization
  SetLicenseKey('6A042E82EE8C7024AFEEA8B2DA474B9209461C794032EB1B063E7B538E726D9F' +
    'BB9B764E45672C5FF1DF0F561D649F4F89C0C96B2A6A9F13752274D13054B23C' +
    'FEA79677BD4C524A8B8ECE9183389975D9BC33C1321AA1473B16A412885ABEA3' +
    'D98B4C6C1C0CC5D350709F32BE2D0888136F8BB5C7EF64E9EA2E2099CB61B72A' +
    '29F8E9236BE12E0CEC106CE67C08DED5950DBB1246680D9269E61B9636C28267' +
    '9E0864D06729C3D447546D19CF29801064F2FBD35AE4333A930E1B73851F78F4' +
    'AD1406DF67FA573EB5E25EBA46F4D1AB6AFAF9371581034320468E2FB91CAA51' +
    '5985917E8D5717C1D52609DC4954BE9A51664A85619E14C7EF1E92BE1C134135');
end.

