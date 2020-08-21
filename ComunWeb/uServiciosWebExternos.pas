unit uServiciosWebExternos;

interface

uses ipssoaps, DB, DBClient, ipwxmlp, Classes;

type
  TResultado=record
              Resultado:TClientDataset;
              Error:String;
            end;
  TipsSOAPSH=class(TipsSOAPS)
    public
      Certificado:String;
  end;
  TProcedimientoXML=reference to procedure (cadena:String);
  TDummyClass = class
    class procedure ipsCertMgrCertList(Sender: TObject; CertEncoded: string; const CertSubject, CertIssuer, CertSerialNumber: string;
      HasPrivateKey: Boolean);
  end;
  TDomicilio=Record
    CodigoProvincia:Integer;
    CodigoMunicipio:Integer;
    CodigoPostal:Integer;
    Municipio:String;
    Sigla:String;
    Nombre:String;
    Numero:String;
    Bloque:String;
    Escalera:String;
    Planta:String;
    Puerta:String;
    OK:Boolean;
  End;
  TipwXMLpH=class(TipwXMLp)
    procedure TipwXMLpHStartElement(Sender: TObject; const Namespace, Element,
      QName: string; IsEmpty: Boolean);
    procedure TipwXMLpHEndElement(Sender: TObject; const Namespace, Element,
      QName: string; IsEmpty: Boolean);
    procedure TipwXMLpHCharacters(Sender: TObject; Text: string);
  private
    LeyendoRegistro:Boolean;
  public
    Certificado:String;
    NuevoRegistro:TProcedimientoXML;
    GrabaRegistro:TProcedimientoXML;
    NuevoDato:TProcedimientoXML;
    Rama:TStringList;
    Campos:TClientDataset;
    RutaComun:String;
    constructor Crear(AOwner:TComponent);
    destructor destroy;override;
  end;

function TokensCadena(cadena:string):TStringList;
function UTF8String(Cadena:WideString):String;
function SiglasCalle(paSiglas: string): string;
function Domicilio(Provincia,Localidad,Referencia:String):TDomicilio;
function RazonSocialAEAT(NombreCertificado,NIF:String;var Nombre:String):Boolean;
function DSRazonSocialAEAT(DescripcionCertificado:String;DSNIF:TDataSet;CampoNIF,CampoNombre:String;CampoApellido1:String='';CampoApellido2:String='';CampoNombreFisica:String='';AlmacenCertificado:String='MY';Contrasena:String='';ValidandoNIF:Boolean=True):TResultado;
procedure NuevoValor(Tokens:TStringList;DS:TDataSet;CadenaOrigen,CampoDestino:String);

implementation

uses SysUtils,ipwsoap,ipsCertMgr,StrUtils, Dialogs, SBWinCertStorage, JclStringConversions, Variants;

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

function Domicilio(Provincia,Localidad,Referencia:String):TDomicilio;
var
  ipwXMLp:TipwXMLp;
function ValorXPath(XPath:String):String;
begin
  Result:='';
  if ipwXMLp.HasXPath(XPath) then
  begin
    ipwXMLp.XPath:=XPath;
    Result:=UTF8ToString(ipwXMLp.XText);
  end;
end;
begin
  if Trim(Referencia)<>'' then
  begin
    Result.OK:=True;
    try
      with TipwSOAP.Create(nil) do
        try
          URL:='http://ovc.catastro.meh.es/ovcservweb/OVCSWLocalizacionRC/OVCCallejero.asmx';
          ActionURI:='http://tempuri.org/OVCServWeb/OVCCallejero/Consulta_DNPRC';
          SOAPPacket:='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:cat="http://www.catastro.meh.es/">'+#13#10+
                      '   <soapenv:Header/>'+#13#10+
                      '   <soapenv:Body>'+#13#10+
                      '      <cat:Provincia>'+{Provincia+}'</cat:Provincia>'+#13#10+
                      '      <cat:Municipio>'+{Localidad+}'</cat:Municipio>'+#13#10+
                      '      <cat:RefCat>'+Referencia+'</cat:RefCat>'+#13#10+
                      '   </soapenv:Body>'+#13#10+
                      '</soapenv:Envelope>';
          ContentType:='text/xml;charset=UTF-8';
          SOAPHeader:='SOAPAction: "http://tempuri.org/OVCServWeb/OVCCallejero/Consulta_DNPRC"';
          SendPacket;
          ipwXMLp:=TipwXMLp.Create(nil);
          try
            ipwXMLp.Input(TransferredData);
            Result.CodigoProvincia:=StrToIntDef(ValorXPath('/soap:Envelope/soap:Body/Consulta_DNP/consulta_dnp/bico/bi/dt/loine/cp'),0);
            Result.CodigoMunicipio:=StrToIntDef(ValorXPath('/soap:Envelope/soap:Body/Consulta_DNP/consulta_dnp/bico/bi/dt/loine/cm'),0);
            Result.CodigoPostal:=StrToIntDef(ValorXPath('/soap:Envelope/soap:Body/Consulta_DNP/consulta_dnp/bico/bi/dt/locs/lous/lourb/dp'),0);
            Result.Municipio:=Copy(ValorXPath('/soap:Envelope/soap:Body/Consulta_DNP/consulta_dnp/bico/bi/dt/nm'),1,30);
            Result.Sigla:=SiglasCalle(ValorXPath('/soap:Envelope/soap:Body/Consulta_DNP/consulta_dnp/bico/bi/dt/locs/lous/lourb/dir/tv'));
            Result.Nombre:=copy(ValorXPath('/soap:Envelope/soap:Body/Consulta_DNP/consulta_dnp/bico/bi/dt/locs/lous/lourb/dir/nv'),1,20);
            Result.Numero:=copy(ValorXPath('/soap:Envelope/soap:Body/Consulta_DNP/consulta_dnp/bico/bi/dt/locs/lous/lourb/dir/pnp'),1,4);
            Result.Bloque:=copy(ValorXPath('/soap:Envelope/soap:Body/Consulta_DNP/consulta_dnp/bico/bi/dt/locs/lous/lourb/loint/bq'),1,4);
            Result.Escalera:=copy(ValorXPath('/soap:Envelope/soap:Body/Consulta_DNP/consulta_dnp/bico/bi/dt/locs/lous/lourb/loint/es'),1,2);
            Result.Planta:=copy(ValorXPath('/soap:Envelope/soap:Body/Consulta_DNP/consulta_dnp/bico/bi/dt/locs/lous/lourb/loint/pt'),1,2);
            if StrUtils.StartsText('-',Trim(Result.Planta)) or
               StrUtils.StartsText('+',Trim(Result.Planta)) then
              Result.Planta:='';
            Result.Puerta:=copy(ValorXPath('/soap:Envelope/soap:Body/Consulta_DNP/consulta_dnp/bico/bi/dt/locs/lous/lourb/loint/pu'),1,2);
            if Result.Escalera+Result.Planta+Result.Puerta='TODOS' then
            begin
              Result.Escalera:='';
              Result.Planta:='';
              Result.Puerta:='';
            end;
          finally
            FreeAndNil(ipwXMLp);
          end;
        finally
          Free;
        end;
    except
      Result.OK:=False;
    end;
  end;
end;

function RazonSocialAEAT(NombreCertificado,NIF:String;var Nombre:String):Boolean;
var
  ipsSOAPSH:TipsSOAPSH;
begin
  Result:=True;
  try
    ipsSOAPSH:=TipsSOAPSH.Create(nil);
    with ipsSOAPSH do
      try
        Certificado:=NombreCertificado;
        with TipsCertMgr.Create(ipsSOAPSH) do
          try
            OnCertList:=TDummyClass.ipsCertMgrCertList;
            ListStoreCertificates;
          finally
            Free;
          end;
        AddNamespace('VNifV1Ent','http://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/burt/jdit/ws/VNifV1Ent.xsd');
        MethodURI:='http://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/burt/jdit/ws/VNifV1.wsdl';
        URL:='https://www1.agenciatributaria.gob.es/wlpl/BURT-JDIT/ws/VNifV1SOAP';
        Method:='VNifV1';
        AddParam('VNifV1Ent:VNifV1Ent','<VNifV1Ent:Nif>'+NIF+'</VNifV1Ent:Nif>'+
                                       '<VNifV1Ent:Nombre>'+Nombre+'</VNifV1Ent:Nombre>');
        SendRequest;
        XPath:='/env:Envelope/env:Body/VNifV1Sal:VNifV1Sal/VNifV1Sal:Nombre';
        Nombre:=XText;
      finally
        Free;
      end;
  except
    Result:=False;
  end;
end;

function DSRazonSocialAEAT(DescripcionCertificado:String;DSNIF:TDataSet;CampoNIF,CampoNombre:String;CampoApellido1:String='';CampoApellido2:String='';CampoNombreFisica:String='';AlmacenCertificado:String='MY';Contrasena:String='';ValidandoNIF:Boolean=True):TResultado;
var
  ipsSOAPS:TipsSOAPSH;
  ipwXMLpH:TipwXMLpH;
  Contador:Integer;
  i:Integer;
  DS:TClientDataset;
  TokensNombreAEAT:TStringList;
begin
  try
    ipsSOAPS:=TipsSOAPSH.Create(nil);
    with ipsSOAPS do
      try
        if AlmacenCertificado='MY' then
        begin
          SSLCertStoreType:=TipssoapsCertStoreTypes.cstUser;
          SSLCertStore:='MY';
          Certificado:=DescripcionCertificado;
          with TipsCertMgr.Create(ipsSOAPS) do
            try
              OnCertList:=TDummyClass.ipsCertMgrCertList;
              ListStoreCertificates;
            finally
              Free;
            end;
        end
        else begin
          SSLCertStoreType:=TipssoapsCertStoreTypes.cstPFXBlob;
          SSLCertStorePassword:=Contrasena;
          SSLCertStoreB:=AlmacenCertificado;
          SSLCertSubject:=DescripcionCertificado;
        end;
        if not DSNIF.Eof then
          repeat
            Contador:=0;
            Reset;
            AddNamespace('vnif','http://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/burt/jdit/ws/VNifV2Ent.xsd');
            MethodURI:='https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/burt/jdit/ws/VNifV2.wsdl';
            URL:='https://www1.agenciatributaria.gob.es/wlpl/BURT-JDIT/ws/VNifV2SOAP';
            Method:='VNifV2';
            repeat
              AddParam('vnif:Contribuyente','<vnif:Nif>'+UTF8String(DSNIF.FieldByName(CampoNIF).AsString)+'</vnif:Nif>'+
                                            '<vnif:Nombre>'+UTF8String(ReplaceText(ReplaceText(DSNIF.FieldByName(CampoNombre).AsString,'ª',''),'º',''))+'</vnif:Nombre>');
              DSNIF.Next;
              Inc(Contador);
            until DSNIF.Eof or (Contador=10000);
            try
              SendRequest;
              DS:=TClientDataSet.Create(nil);
              with DS do
              begin
                FieldDefs.Add('NIF',ftString,12);
                FieldDefs.Add('NOMBRE',ftString,120);
                FieldDefs.Add('NOMBRE_CAI',ftString,120);
                FieldDefs.Add('APELLIDO1_AEAT',ftString,50);
                FieldDefs.Add('APELLIDO2_AEAT',ftString,50);
                FieldDefs.Add('NOMBRE_AEAT',ftString,50);
                FieldDefs.Add('RESULTADO',ftString,30);
                FieldDefs.Add('NOMBRE_JURIDICA',ftString,50);
                for i:=1 to FieldDefs.Count do
                  FieldDefs.Items[Fields.Count].CreateField(DS,nil,FieldDefs.Items[Fields.Count].Name);
                CreateDataset;
              end;
              ipwXMLpH:=TipwXMLpH.Crear(nil);
              with ipwXMLpH do
                try
                  RutaComun:='/env:Envelope/env:Body/VNifV2Sal:VNifV2Sal/VNifV2Sal:Contribuyente';
                  Campos.AppendRecord(['/VNifV2Sal:Nif','NIF',LongInt(@DS)]);
                  Campos.AppendRecord(['/VNifV2Sal:Nombre','NOMBRE',LongInt(@DS)]);
                  Campos.AppendRecord(['/VNifV2Sal:Resultado','RESULTADO',LongInt(@DS)]);
                  NuevoRegistro:=
                  procedure(Cadena:String)
                  begin
                    if SameText(Cadena,RutaComun) then
                      DS.Append;
                  end;
                  GrabaRegistro:=
                  procedure(Cadena:String)
                  var
                    p: TBookMark;
                    _eof: Boolean;
                  begin
                    if SameText(Cadena,ipwXMLpH.RutaComun) then
                    begin
                      if StartsText('IDENTIFICADO',UpperCase(Trim(DS.FieldByName('RESULTADO').AsString))) or
                         ((UpperCase(Trim(DS.FieldByName('RESULTADO').AsString))='NO IDENTIFICADO-SIMILAR') and not ValidandoNIF) then
                      begin
                        if not ValidandoNIF then
                        begin
                          if Pos(Copy(TRIM(DSNIF.FieldByName(CampoNIF).AsString), 1, 1), '0123456789XLYZ') = 0 then
                            DS.FieldByName('NOMBRE_JURIDICA').AsString:=UpperCase(Trim(DS.FieldByName('NOMBRE').AsString))
                          else if Pos(Copy(TRIM(DSNIF.FieldByName(CampoNIF).AsString), 1, 1), '0123456789XLYZ') <> 0 then
                            DS.FieldByName('NOMBRE_AEAT').AsString:=UpperCase(Trim(DS.FieldByName('NOMBRE').AsString))
                        end
                        else
                          DS.Cancel;
                      end
                      else begin
                        p:=DSNIF.GetBookmark;
                        _eof:=DSNIF.Eof;
                        try
                          if DSNIF.Locate(CampoNIF,VarArrayOf([DS.FieldByName('NIF').AsString]),[]) then
                          begin
                            DS.FieldByName('NOMBRE_CAI').AsString:=DSNIF.FieldByName(CampoNombre).AsString;
                            if Pos(Copy(TRIM(DSNIF.FieldByName(CampoNIF).AsString), 1, 1), '0123456789XLYZ') = 0 then
                              DS.FieldByName('NOMBRE').AsString:='NIF inexistente para la AEAT'
                            Else if DS.FieldByName('NOMBRE').AsString=DSNIF.FieldByName(CampoNombre).AsString then
                              DS.FieldByName('NOMBRE').Clear
                            else if CampoApellido1<>'' then
                            begin
                              TokensNombreAEAT:=TokensCadena(DS.FieldByName('NOMBRE').AsString);
                              try
                                NuevoValor(TokensNombreAEAT,DS,DSNIF.FieldByName(CampoApellido1).AsString,'APELLIDO1_AEAT');
                                NuevoValor(TokensNombreAEAT,DS,DSNIF.FieldByName(CampoApellido2).AsString,'APELLIDO2_AEAT');
                                DS.FieldByName('NOMBRE_AEAT').AsString:=Copy(TokensNombreAEAT.DelimitedText,1,DSNIF.FieldByName(CampoNombreFisica).Size);
                              finally
                                FreeAndNil(TokensNombreAEAT);
                              end;
                            end;
                          end;
                        finally
                          DSNIF.GotoBookmark(p);
                          DSNIF.FreeBookmark(p);
                          if _Eof then
                            DSNIF.Next;
                        end;
                        DS.Post;
                      end;
                    end;
                  end;
                  ipwXMLpH.Input(ipsSOAPS.TransferredData);
                finally
                  FreeAndNil(ipwXMLpH);
                end;
              Result.Resultado:=DS;
            Except
              on E:exception do ShowMessage('Problemas en la autenticación con la AEAT. Verifique la validez del certificado utilizado');
            end;
          until DSNIF.Eof;
      finally
        Free;
      end;
  except
  end;
end;

{ TDummyClass }

class procedure TDummyClass.ipsCertMgrCertList(Sender: TObject;
  CertEncoded: string; const CertSubject, CertIssuer, CertSerialNumber: string;
  HasPrivateKey: Boolean);
var
  i:Integer;
  C1,C2:String;
begin
  C1:='';C2:='';
  for i:=1 to length(CertSubject) do
    if CertSubject[i] in ['0'..'9','a'..'z','A'..'Z','-'] then C1:=C1+CertSubject[i];
  for i:=1 to length(TipsSOAPSH(TipsCertMgr(Sender).Owner).Certificado) do
    if TipsSOAPSH(TipsCertMgr(Sender).Owner).Certificado[i] in ['0'..'9','a'..'z','A'..'Z','-'] then C2:=C2+TipsSOAPSH(TipsCertMgr(Sender).Owner).Certificado[i];
  if ContainsText(C1,C2) then
    TipsSoapS(TipsCertMgr(Sender).Owner).SSLCertSubject:=CertSubject;
end;

{ TipwXMLpH }

constructor TipwXMLpH.Crear(AOwner: TComponent);
var
  i:Integer;
begin
  inherited Create(AOwner);
  OnCharacters:=TipwXMLpHCharacters;
  OnStartElement:=TipwXMLpHStartElement;
  OnEndElement:=TipwXMLpHEndElement;
  Rama:=TStringList.Create;
  Rama.Delimiter:='/';
  Campos:=TClientDataSet.Create(nil);
  with Campos do
  begin
    FieldDefs.Add('RAMA',ftString,200);
    FieldDefs.Add('CAMPO',ftString,40);
    FieldDefs.Add('TABLA',ftLargeint);
    for i:=1 to FieldDefs.Count do
      FieldDefs.Items[Fields.Count].CreateField(Campos,nil,FieldDefs.Items[Fields.Count].Name);
    IndexDefs.Add('Indice','RAMA',[ixPrimary,ixUnique]);
    IndexName:='Indice';
    CreateDataset;
  end;
end;

destructor TipwXMLpH.destroy;
begin
  if Assigned(Campos) then FreeAndNil(Campos);
  if Assigned(Rama) then FreeAndNil(Rama);
  inherited;
end;

procedure TipwXMLpH.TipwXMLpHCharacters(Sender: TObject; Text: string);
var
  Cadena,Texto:String;
begin
  Cadena:='/'+Rama.DelimitedText;
  if Length(Cadena)>=Length(RutaComun) then
  begin
    Delete(Cadena,1,Length(RutaComun));
    if Campos.FindKey([Cadena]) then
    begin
      Texto:=Text;
      with TClientDataSet(Pointer(Campos.FieldByName('TABLA').AsLargeInt)^).FieldByName(Campos.FieldByName('CAMPO').AsString) do
        case DataType of
          ftTimeStamp:AsDateTime:=StrToDateTime(ReplaceText(UTF8ToString(Texto),'-','/'));
          ftFloat:AsFloat:=StrToFloatDef(ReplaceText(UTF8ToString(Texto),'.',FormatSettings.DecimalSeparator),0);
          ftInteger:AsInteger:=StrToIntDef(UTF8ToString(Texto),0);
          ftString:AsString:=AsString+UTF8ToString(Trim(Texto));
        end;
    end;
  end;
  if Assigned(NuevoDato) then NuevoDato(Text);
end;

procedure TipwXMLpH.TipwXMLpHEndElement(Sender: TObject; const Namespace,
  Element, QName: string; IsEmpty: Boolean);
begin
  if Assigned(GrabaRegistro) then GrabaRegistro('/'+Rama.DelimitedText);
  Rama.Delete(Rama.Count-1);
end;

procedure TipwXMLpH.TipwXMLpHStartElement(Sender: TObject; const Namespace,
  Element, QName: string; IsEmpty: Boolean);
begin
  Rama.Add(QName);
  if Assigned(NuevoRegistro) then NuevoRegistro('/'+Rama.DelimitedText);
end;

function UTF8String(Cadena:WideString):String;
begin
  Result:=ReplaceText(ReplaceText(JclStringConversions.WideStringToUTF8(Cadena),'&','&amp;'),'<','&lt;');
end;

function TokensCadena(cadena:string):TStringList;
begin
  cadena:=ReplaceText(ReplaceText(cadena,',',''),',','');
  while pos('  ',cadena)>0 do cadena:=ReplaceText(cadena,'  ',' ');
  Result:=TStringList.Create;
  Result.Delimiter:=' ';
  Result.DelimitedText:=cadena;
end;

procedure NuevoValor(Tokens:TStringList;DS:TDataSet;CadenaOrigen,CampoDestino:String);
var
  i:Integer;
begin
  DS.FieldByName(CampoDestino).Clear;
  with TokensCadena(CadenaOrigen) do
    try
      i:=0;
      while (Tokens.Count>0) and (i<Count) do
      begin
        DS.FieldByName(CampoDestino).AsString:=Copy(DS.FieldByName(CampoDestino).AsString+
                                                    IfThen(DS.FieldByName(CampoDestino).AsString='','',' ')+
                                                    Tokens.Strings[0],1,DS.FieldByName(CampoDestino).Size);
        Tokens.Delete(0);
        Inc(i);
      end;
    finally
      Free;
    end;
end;

end.
