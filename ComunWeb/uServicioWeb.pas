// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : https://www.caisistemas.es/prueba/ado.dll/wsdl/IFunciones
// Encoding : utf-8
// Version  : 1.0
// (23/09/2015 11:58:05 - - $Rev: 45757 $)
// ************************************************************************ //

unit uServicioWeb;

interface

uses InvokeRegistry, SOAPHTTPClient, Types, XSBuiltIns, SOAPHTTPTrans, System.Net.HttpClient;

type
  TDummyClass = Class
      class procedure HTTPRIOHTTPWebNodeBeforePost(const HTTPReqResp: THTTPReqResp; Client:THTTPClient);
  End;

  // ************************************************************************ //
  // The following types, referred to in the WSDL document are not being represented
  // in this file. They are either aliases[@] of other types represented or were referred
  // to but never[!] declared in the document. The types from the latter category
  // typically map to predefined/known XML or Embarcadero types; however, they could also 
  // indicate incorrect WSDL documents that failed to declare or import a schema type.
  // ************************************************************************ //
  // !:int             - "http://www.w3.org/2001/XMLSchema"[]
  // !:string          - "http://www.w3.org/2001/XMLSchema"[]


  // ************************************************************************ //
  // Namespace : urn:FuncionesIntf-IFunciones
  // soapAction: urn:FuncionesIntf-IFunciones#%operationName%
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : rpc
  // use       : encoded
  // binding   : IFuncionesbinding
  // service   : IFuncionesservice
  // port      : IFuncionesPort
  // URL       : https://www.caisistemas.es/prueba/ado.dll/soap/IFunciones
  // ************************************************************************ //
  IFunciones = interface(IInvokable)
  ['{4D59BE1D-9FE4-5C10-A615-B74769DDB6C7}']
    function  UnzipFile(const ruta: string; const destino: string): string; stdcall;
    function  EjecutaSQL(const Servidor: string; const RutaBD: string; const Sentencia: string): Integer; stdcall;
    function  EjecutaSQLConBlob(const Servidor: string; const RutaBD: string; const Sentencia: string; const CampoBlob: string; const Blob: string): Integer; stdcall;
  end;

function GetIFunciones(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): IFunciones;


implementation
  uses SysUtils;

function GetIFunciones(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): IFunciones;
const
  defWSDL = 'https://www.caisistemas.es/prueba/ado.dll/wsdl/IFunciones';
  defURL  = 'https://www.caisistemas.es/prueba/ado.dll/soap/IFunciones';
  defSvc  = 'IFuncionesservice';
  defPrt  = 'IFuncionesPort';
var
  RIO: THTTPRIO;
begin
  Result := nil;
  if (Addr = '') then
  begin
    if UseWSDL then
      Addr := defWSDL
    else
      Addr := defURL;
  end;
  if HTTPRIO = nil then
    RIO := THTTPRIO.Create(nil)
  else
    RIO := HTTPRIO;
  try
    Result := (RIO as IFunciones);
    if UseWSDL then
    begin
      RIO.WSDLLocation := Addr;
      RIO.Service := defSvc;
      RIO.Port := defPrt;
    end else
      RIO.URL := Addr;
    RIO.HTTPWebNode.OnBeforePost:=TDummyClass.HTTPRIOHTTPWebNodeBeforePost;
  finally
    if (Result = nil) and (HTTPRIO = nil) then
      RIO.Free;
  end;
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

initialization
  { IFunciones }
  InvRegistry.RegisterInterface(TypeInfo(IFunciones), 'urn:FuncionesIntf-IFunciones', 'utf-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(IFunciones), 'urn:FuncionesIntf-IFunciones#%operationName%');

end.
