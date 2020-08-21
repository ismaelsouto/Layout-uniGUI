unit uWebSocket;

interface




procedure Conectar(Certificado,Password:String;UsuarioWS:String='';PassWordWS:String='');
function ExisteConexion(GUID:String):Boolean;
procedure EnviarMensajeServidor(GUID,Mensaje:String);
procedure HazPing;
function Conectado:Boolean;
procedure Reinicia;
function DescargarJS(RutaFichero:String;Reintenta:Boolean=True):Boolean;

var
  PuertoWS:Integer;
  URLWebSocket,HostWS:String;

implementation

uses SBEncoding, SysUtils, Funciones, ipshttps, ServerModule, UNiGuiApplication, MainModule;

{ TWebSocket }

procedure Reinicia;
begin
  HazPost(URLWebSocket+'/desconectar',[],'','','',True);
  HazPost(URLWebSocket+'/reconectar',[],'','','',True);
end;

procedure HazPing;
begin
  HazPost(URLWebSocket+'/ping',[],'','','',True);
end;

function Conectado: Boolean;
begin
  try
    Result:=not Sametext(HazPost(URLWebSocket+'/conectado',[],'','','',True),'WebSocket desconectado');
  except
    Result:=False;
  end;
end;

procedure Conectar(Certificado,Password: String;UsuarioWS:String='';PassWordWS:String='');
begin
  HazPost(URLWebSocket+'/conectar',
          ['PUERTO='+IntToStr(PuertoWS),
           'CERTIFICADO='+Certificado,
           'PASSWORD='+Password,
           'USUARIO_WS='+UsuarioWS,
           'PASSWORD_WS='+PassWordWS],'','','',True);
end;


procedure EnviarMensajeServidor(GUID,Mensaje:String);
begin
  HazPost(URLWebSocket+'/enviar_mensaje',['GUID='+GUID,'mensaje='+Mensaje],'','','',True);
end;


function ExisteConexion(GUID: String): Boolean;
begin
  Result:=SameText(HazPost(URLWebSocket+'/guid_conectada',
                           ['GUID='+GUID],'','','',True),'1');

end;

function DescargarJS(RutaFichero:String;Reintenta:Boolean):Boolean;
begin
  if Reintenta then
    try
      Result:=Download(UniServerModule.ServidorWebSocket + '/sgcWebSockets.js', RutaFichero)
    except
      on E:Exception do
        begin
          UniServerModule.Logger.AddLog('Error en la descarga del javascripr: '+E.Message);
          Reinicia;
          Result:=DescargarJS(RutaFichero,False);
        end;
    end;
end;

end.
