unit uFirma;

interface

uses SBHTTPSClient,SBX509, Classes,
JvDBGrid, DBGrids, Graphics, DB, DBClient,Grids, Types,
SBUtils, ipshttps, ipscertmgr, ipscore,ipssoaps, ipwhttp;

type
  TDummyClass = class
//     class procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
//      DataCol: Integer; Column: TColumn; State: TGridDrawState);
//    class procedure DescripcionChange(Sender: TObject);
//    class procedure DBGrid1TitleClick(Column: TColumn);
//    class procedure JvDBGridDblClick(Sender: TObject);
//
    class procedure ipsHTTPSTransfer(Sender: TObject; Direction: Integer;
      BytesTransferred: Int64; PercentDone: Integer; Text: string);
    class procedure ipwHTTPTransfer(Sender: TObject; Direction: Integer;
      BytesTransferred: Int64; PercentDone: Integer; Text: string);
    class procedure ipsCertMgrCertList(Sender: TObject; CertEncoded: string;
      const CertSubject, CertIssuer, CertSerialNumber: string;
      HasPrivateKey: Boolean);

  end;

  TElHTTPSClientH = class(TElHTTPSClient)
    procedure ElHTTPSClientCertificateValidate(Sender: TObject;
            X509Certificate: TElX509Certificate; var Validate: Boolean);
    procedure ElHTTPSClientData(Sender: TObject; Buffer: Pointer;
            Size: Integer);
    procedure ElHTTPSClientPreparedHeaders(Sender: TObject;
      Headers: TStringList);
    procedure ElHTTPSClientSendData(Sender: TObject; Buffer: Pointer;
      Size: Integer);
    public
      Respuesta:String;
    private
  end;

    TipsHTTPSH=class(TipsHTTPS)
    public
      Certificado:String;
      Resultado:String;
  end;
  TipwHTTPH=class(TipwHTTP)
    public
      Resultado:String;
  end;

function HazPost(URL:String;
                 Parametros:Array Of String;
                 Certificado:String='';Password:String='';HacerGet:Boolean=False;
                 ipsHTTPSH:TipsHTTPSH=nil;
                 ipwHTTPH:TipwHTTPH=nil):String;

function Post(URL:String;Parametros:Array Of String;HacerGet:Boolean=False;HTTPSCLient:TElHTTPSClientH=nil):String;
function CrearElHTTPSClientH:TElHTTPSClientH;

  procedure GrabaDatos(Datos:String);

var
  VerPost,DecodificaPost:Boolean;

implementation

uses StrUtils, SBEncoding, JclSysInfo, SysUtils;

{ TElHTTPSClientH }


function CrearElHTTPSClientH:TElHTTPSClientH;
begin
  Result:=TElHTTPSClientH.Create(nil);
  with Result do
  begin
    respuesta:='';
    {$ifdef UNIGUI_VCL}
    OnSendData:=ElHTTPSClientSendData;
    {$endif}
    OnCertificateValidate:=ElHTTPSClientCertificateValidate;
    OnPreparedHeaders:=ElHTTPSClientPreparedHeaders;
    OnData:=ElHTTPSClientData;
  end;
end;

procedure TElHTTPSClientH.ElHTTPSClientCertificateValidate(Sender: TObject;
  X509Certificate: TElX509Certificate; var Validate: Boolean);
begin
  Validate:=True;
end;

procedure TElHTTPSClientH.ElHTTPSClientData(Sender: TObject; Buffer: Pointer;
  Size: Integer);
var
  i:Integer;
begin
  for i:=1 to Size do
    Respuesta:=Respuesta+PAnsiChar(Buffer)[i-1];
end;

procedure TElHTTPSClientH.ElHTTPSClientPreparedHeaders(Sender: TObject;
  Headers: TStringList);
begin
  Headers.Add('Content-Type: application/x-www-form-urlencoded');
end;

procedure TElHTTPSClientH.ElHTTPSClientSendData(Sender: TObject;
  Buffer: Pointer; Size: Integer);
begin
  with TStringList.Create do
    try
      Text:='////////////////////////DECODIFICADO/////////////////////////'+#13+
             ReplaceText(URLDecode(ReplaceText(ReplaceText(ReplaceText(ReplaceText(PAnsiChar(Buffer),'=','%3D'),'%D1','%C3%91'),'%C7','%C3%87'),'%25','%20')),'&','&'+#13)+#13+
             '////////////////////////CODIFICADO/////////////////////////'+#13+
             PAnsiChar(Buffer);
      SaveToFile(IncludeTrailingPathDelimiter(GetWindowsTempFolder)+'Post_CADES.txt');
    finally
      free;
    end;
end;


class procedure TDummyClass.ipsCertMgrCertList(Sender: TObject;
  CertEncoded: string; const CertSubject, CertIssuer, CertSerialNumber: string;
  HasPrivateKey: Boolean);
begin
  if Pos(TipsHTTPSH(TipsCertMgr(Sender).Owner).Certificado,CertSubject)>0 then
    TipsHTTPSH(TipsCertMgr(Sender).Owner).SSLCertSubject:=CertSubject;
end;

class procedure TDummyClass.ipsHTTPSTransfer(Sender: TObject;
  Direction: Integer; BytesTransferred: Int64; PercentDone: Integer;
  Text: string);
begin
  TipsHTTPSH(Sender).Resultado:=TipsHTTPSH(Sender).Resultado+Text;
end;

class procedure TDummyClass.ipwHTTPTransfer(Sender: TObject; Direction: Integer;
  BytesTransferred: Int64; PercentDone: Integer; Text: string);
begin
  TipwHTTPH(Sender).Resultado:=TipwHTTPH(Sender).Resultado+Text;
end;

function Post(URL:String;Parametros:Array Of String;HacerGet:Boolean=False;HTTPSCLient:TElHTTPSClientH=nil):String;
var
  i:integer;
  Contenido:String;
  Liberar:Boolean;
begin
  Contenido:='';
  for i:=0 to length(Parametros)-1 do
    if Parametros[i]<>'' then
      Contenido:=Contenido+IfThen(i>0,'&','')+ReplaceText(ReplaceText(ReplaceText(URLEncode(ReplaceText(Parametros[i],'%',' ')),'%3D','='),'%C3%91','%D1'),'%C3%87','%C7');
  Liberar:=HTTPSCLient=nil;
  if HTTPSCLient=nil then HTTPSCLient:=CrearElHTTPSClientH;
  try
    if HacerGet then
      HTTPSCLient.Get(URL+IfThen(Contenido='','','?'+Contenido))
    else
      HTTPSCLient.Post(URL,Contenido);
    result:=HTTPSCLient.respuesta;
  finally
    if Liberar then FreeAndnil(HTTPSClient);
  end;
end;

function HazPost(URL:String;
                 Parametros:Array Of String;
                 Certificado:String;Password:String;HacerGet:Boolean;
                 ipsHTTPSH:TipsHTTPSH;
                 ipwHTTPH:TipwHTTPH):String;
var
  i:Integer;
  SParametros:String;
  Liberar:Boolean;
begin
  SParametros:='';
  for i:=0 to Length(Parametros)-1 do SParametros:=SParametros+IfThen(i=0,'','&')+ReplaceText(ReplaceText(ReplaceText(URLEncode(ReplaceText(Parametros[i],'%',' ')),'%3D','='),'%C3%91','%D1'),'%C3%87','%C7');
  if VerPost then
    GrabaDatos(URL+#13#10+
               SParametros);
  if StartsText('HTTPS://',UpperCase(URL)) then
  begin
    Liberar:=ipsHTTPSH<>nil;
    if ipsHTTPSH=nil then ipsHTTPSH:=TipsHTTPSH.Create(nil);
    try
      ipsHTTPSH.ContentType:='application/x-www-form-urlencoded';
      if Certificado<>'' then
      begin
        ipsHTTPSH.Certificado:=Certificado;
        with TipsCertMgr.Create(ipsHTTPSH) do
          try
            OnCertList:=TDummyClass.ipsCertMgrCertList;
            ListStoreCertificates;
          finally
            Free;
          end;
      end;
      ipsHTTPSH.OnTransfer:=TDummyClass.ipsHTTPSTransfer;
      ipsHTTPSH.resultado:='';
      ipsHTTPSH.PostData:=SParametros;
      if HacerGet then
        ipsHTTPSH.Get(URL)
      else
        ipsHTTPSH.Post(URL);
      result:=ipsHTTPSH.Resultado;
    finally
      if Liberar then ipsHTTPSH.Free;
    end;
  end
  else begin
    Liberar:=ipwHTTPH<>nil;
    if ipwHTTPH=nil then ipwHTTPH:=TipwHTTPH.Create(nil);
    try
      ipwHTTPH.ContentType:='application/x-www-form-urlencoded';
      ipwHTTPH.OnTransfer:=TDummyClass.ipwHTTPTransfer;
      ipwHTTPH.resultado:='';
      ipwHTTPH.PostData:=SParametros;
      if HacerGet then
        ipwHTTPH.Get(URL)
      else
        ipwHTTPH.Post(URL);
      result:=ipwHTTPH.Resultado;
    finally
      if Liberar then ipwHTTPH.Free;
    end;
  end;
end;

procedure GrabaDatos(Datos:String);
var
  F:TextFile;
begin
  AssignFile(F,IncludeTrailingPathDelimiter(GetWindowsTempFolder)+'Post_CADES.txt');
  Rewrite(F);
  WriteLn(F,ReplaceText(URLDecode(ReplaceText(ReplaceText(ReplaceText(ReplaceText(Datos,'=','%3D'),'%D1','%C3%91'),'%C7','%C3%87'),'%25','%20')),'&','&'+#13#10));
  System.CloseFile(F);
end;

initialization
{$IFDEF ELDOS9}
SetLicenseKey('485E29B696E96A099866A1D9E58B6814415B97CFADC170C5C887408E8DB98200' +
  '3C884B8328BD6B5E6397B202EE728308D1652BE29D72DE2199DE11D180E66822' +
  '5B978F38E5A06E36A87F8CB026827A80177B1C009E7E229C3DDBAD8D263457AD' +
  '5ADC670972D65E2C41CF63FCB35385C4189482EB363BBD12046ABDC502E08692' +
  '4CC82637F98E737696C145F972BBF50A41A395252EF61932CA739BFBB94E482B' +
  '05BCD414D5FBF80537DA69C748B1F3F7B7AC7814428EB6CD82FF1D507E5B97D1' +
  'D08E57A138E3BECE31E6FB7353EE8AC6E6C93AF251BFE7063EF3E466620464D9' +
  '56186EEA80718DA24FB0CFF6E4C3B3971219D17CC11EB4EC9A117B03BAFB1FDC');
{$ELSE}
SetLicenseKey('6A042E82EE8C7024AFEEA8B2DA474B9209461C794032EB1B063E7B538E726D9F' +
  'BB9B764E45672C5FF1DF0F561D649F4F89C0C96B2A6A9F13752274D13054B23C' +
  'FEA79677BD4C524A8B8ECE9183389975D9BC33C1321AA1473B16A412885ABEA3' +
  'D98B4C6C1C0CC5D350709F32BE2D0888136F8BB5C7EF64E9EA2E2099CB61B72A' +
  '29F8E9236BE12E0CEC106CE67C08DED5950DBB1246680D9269E61B9636C28267' +
  '9E0864D06729C3D447546D19CF29801064F2FBD35AE4333A930E1B73851F78F4' +
  'AD1406DF67FA573EB5E25EBA46F4D1AB6AFAF9371581034320468E2FB91CAA51' +
  '5985917E8D5717C1D52609DC4954BE9A51664A85619E14C7EF1E92BE1C134135');
{$ENDIF}
end.

