unit uNuevaLicencia;

interface

uses
  sysutils,sqlexpr,SoapConn, SOAPHTTPTrans, WinInet,dbclient,classes,midaslib,Funciones;

//type
//  TDummyClass = Class
//      class procedure HTTPRIOHTTPWebNodeBeforePost(const HTTPReqResp: THTTPReqResp; Data: Pointer);
//  End;

function DameNumeroLicencia(programa:string) : string;

implementation

function DameNumeroLicencia(programa:string) : string;
var
  loSw:    integer;
  loLlave: string;
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
    if pdonde = 'D' then
    begin
      lreturn := pcampo;
      for lsw := 1 to ldifer do
        lreturn := lreturn + pcon;
     end;

     if pdonde = 'I' then
     begin
       for lsw := 1 to ldifer do
         lreturn := lreturn + pcon;
       lreturn := lreturn + pcampo
     end;

     if pdonde = 'C' then
     begin
       lderec := ldifer div 2;
       lizqui := ldifer div 2;
       for lsw := 1 to lderec do
         lreturn := lreturn + pcon;
       lreturn := lreturn + pcampo;
       for lsw := 1 to lizqui do
         lreturn := lreturn + pcon;
      end;

     Result := lreturn;
  end;
end;

//function CDSRemoto(URL,NombreProveedor,Consulta:String;Owner:TComponent=nil):TClientDataset;
//var
//  SC:TSoapConnection;
//begin
//
//  SC:=TSoapConnection.Create(nil);
//  try
//    SC.UseSOAPAdapter:=False;
//    SC.URL:=URL;
//    SC.Connected:=True;
//    SC.RIO.HTTPWebNode.OnBeforePost:=TDummyClass.HTTPRIOHTTPWebNodeBeforePost;
//    result:=TClientDataset.Create(Owner);
//    with result do
//    begin
//      RemoteServer:=SC;
//      ProviderName:=NombreProveedor;
//      CommandText:=Consulta;
//      Open;
//    end;
//    SC.Connected:=False;
//  finally
//    FreeAndNil(SC);
//    GetFormatSettings;
//  end;
//end;
//
begin
   result := '';
   loLlave := '';

   for loSw := 1 to 5 do begin
     loLlave := loLlave + Pad(IntToStr(Random(99)),2,'0','I');
   end;

   if programa='PORTALEMP' then begin
      result := PAD(loLlave,10,'0','I');
      Insert('E',result,4);
      result := 'P' + result;
   end;

   if programa='PORTALSII' then begin
      result := PAD(loLlave,10,'0','I');
      Insert('S',result,4);
      result := 'P' + result;
   end;
   if programa='CONTABILIDAD' then begin
      result := PAD(loLlave,10,'0','I');
      Insert('N',result,4);
      result := 'C' + result;
   end;

   if programa = 'FISCAL' then begin
      result := PAD(loLlave,10,'0','I');
      Insert('S',result,4);
      result := 'F' + result;
   end;

   if programa = 'RENTA' then begin
      result := PAD(loLlave,10,'0','I');
      Insert('E',result,4);
      result := 'R' + result;
   end;

   if programa = 'SOCIEDADES' then begin
      result := PAD(loLlave,10,'0','I');
      Insert('C',result,4);
      result := 'S' + result;
    end;

   if programa = 'FACTURACION' then begin
      result := PAD(loLlave,10,'0','I');
      Insert('C',result,4);
      result := 'F' + result;
   end;

   if programa = 'LABORAL' then begin
      result := PAD(loLlave,10,'0','I');
      Insert('A',result,4);
      result := 'L' + result;
   end;

   if programa = 'GESTION' then begin
      result := PAD(loLlave,10,'0','I');
      Insert('E',result,4);
      result := 'G' + result;
   end;

   if programa = 'PAQUETE' then begin
      result := PAD(loLlave,10,'0','I');
      Insert('A',result,4);
      result := 'P' + result;
   end;

   if programa = 'GEST. DOCUMENTAL E INTERNA' then begin
      result := PAD(loLlave,10,'0','I');
      Insert('D',result,4);
      result := 'G' + result;
   end;

   if programa = 'CAIWII' then begin
      result := PAD(loLlave,10,'0','I');
      Insert('W',result,4);
      result := 'C' + result;
   end;

   if programa = 'CAIVBD' then begin
      result := PAD(loLlave,10,'0','I');
      Insert('B',result,4);
      result := 'V' + result;
   end;

   if programa = 'CAIDOC' then begin
      result := PAD(loLlave,10,'0','I');
      Insert('D',result,4);
      result := 'C' + result;
   end;

  if result<>'' then
  begin
    // comprueba que no exista el número de licencia en LICENCIAS_PROGRAMAS_WEB y en SERVICIOS
    with CDSRemoto('https://www.caisistemas.es/prueba/ado.dll/soap/IConexiones','Factura_gdb',
                   'select licencia from licencias_programas_web where upper(licencia)=upper('+QuotedStr(result)+')') do
      try
        if not IsEmpty then
          result:=''
      finally
        Free;
      end;
  end;

  if result<>'' then
  begin
    // comprueba que no exista el número de licencia en LICENCIAS_PROGRAMAS_WEB y en SERVICIOS
    with CDSRemoto('https://www.caisistemas.es/prueba/ado.dll/soap/IConexiones','Factura_gdb',
                   'select licencia from servicios where upper(licencia)=upper('+QuotedStr(result)+')') do
      try
        if not IsEmpty then
          result:=''
      finally
        Free;
      end;
  end;

end;


 { TDummyClass }

//class procedure TDummyClass.HTTPRIOHTTPWebNodeBeforePost(
//  const HTTPReqResp: THTTPReqResp; Data: Pointer);
//var
//  TimeOut: Integer;
//begin
//  // Sets the receive timeout. i.e. how long to wait to 'receive' the response
//  TimeOut := (30*1000);
//  try
//    InternetSetOption(Data, INTERNET_OPTION_CONNECT_TIMEOUT, Pointer(@TimeOut), SizeOf(TimeOut));
//    InternetSetOption(Data, INTERNET_OPTION_RECEIVE_TIMEOUT,  Pointer(@TimeOut),  SizeOf(TimeOut));
//    InternetSetOption(Data, INTERNET_OPTION_SEND_TIMEOUT,  Pointer(@TimeOut),  SizeOf(TimeOut));
//  except on E:Exception do
//    raise Exception.Create(Format('Unhandled Exception:[%s] while setting timeout to [%d] - ',[E.ClassName, TimeOut, e.Message]));
//  end;
//end;


end.
