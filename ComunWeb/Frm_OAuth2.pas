unit Frm_OAuth2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniButton, uniGUIBaseClasses, uniLabel, uniTimer,
  Funciones, uniURLFrame;

type
  TFrmOAuth2 = class(TUniForm)
    UniLabel1: TUniLabel;
    UniButton1: TUniButton;
    UniTimer1: TUniTimer;
    procedure UniTimer1Timer(Sender: TObject);
    procedure UniButton1Click(Sender: TObject);
  private
    { Private declarations }
    FCLientID,FSecret:String;
    FAccesToken: String;
    FRefreshToken: String;
    FHoraExpiracion: TDateTime;
    FCode: String;
    FURLRedirect:String;
    FURLToken:String;
    procedure SetAccesToken(const Value: String);
    procedure SetRefreshToken(const Value: String);
    procedure SetHoraExpiracion(const Value: TDateTime);
    procedure SetCode(const Value: String);
  public
    { Public declarations }
    property HoraExpiracion:TDateTime read FHoraExpiracion write SetHoraExpiracion;
    property AccesToken:String read FAccesToken write SetAccesToken;
    property RefreshToken:String read FRefreshToken write SetRefreshToken;
    property Code:String read FCode write SetCode;
    constructor Crear(ClientUD,Secret,URLAutorizacion,URLToken,URLRedirect,Scope:String;TokenRefresco:String='');
  end;

implementation

uses
  uniGUIApplication, SBEncoding, ServerModule, uLkJSON, DateUtils, StrUtils, WebPost,
  MainModule;

{$R *.dfm}


{ TFrmOAuth2 }

constructor TFrmOAuth2.Crear(ClientUD,Secret,URLAutorizacion,URLToken,URLRedirect,Scope:String;TokenRefresco:String='');
var
  JSON:TlkJSONbase;
begin
  inherited Create(uniGUIApplication.UniApplication);
  FCLientID:=ClientUD;
  FSecret:=Secret;
  FURLToken:=URLToken;
  FURLRedirect:=URLRedirect;
  AccesToken:='';
  RefreshToken:='';
  if TokenRefresco='' then
  begin
    UniTimer1.Enabled:=True;
    UniSession.AddJS('window.open('''+URLAutorizacion+
                                      'response_type=code&'+
                                      'client_id='+FCLientID+'&'+
                                      'redirect_uri='+URLEncode(FURLRedirect)+'&'+
                                      'state='+IntToStr(Int64(Self))+UrlEncode('#')+UniMainModule.GUID+'&'+
                                      'scope='+URLEncode(Scope)+'&'+
                                      'prompt=consent&'+
                                      'access_type=offline'',''_blank'');')
  end
  else begin
    RefreshToken:=TokenRefresco;
    JSON:=TlkJSONbase(TlkJSON.ParseText(HazPost(FURLToken,
                                                ['client_id='+FClientID,
                                                 'client_secret='+FSecret,
                                                 'refresh_token='+RefreshToken,
                                                 'grant_type=refresh_token'])));
    try
      AccesToken:=JSON.Field['token_type'].Value+' '+JSON.Field['access_token'].Value;
      HoraExpiracion:=IncSecond(Now,JSON.Field['expires_in'].Value);
    finally
      FreeAndNil(JSON);
    end;
  end;
end;

procedure TFrmOAuth2.SetAccesToken(const Value: String);
begin
  FAccesToken := Value;
end;

procedure TFrmOAuth2.SetCode(const Value: String);
begin
  FCode := Value;
end;

procedure TFrmOAuth2.SetHoraExpiracion(const Value: TDateTime);
begin
  FHoraExpiracion := Value;
end;

procedure TFrmOAuth2.SetRefreshToken(const Value: String);
begin
  FRefreshToken := Value;
end;

procedure TFrmOAuth2.UniButton1Click(Sender: TObject);
begin
  if AccesToken='' then
    ModalResult:=mrCancel
  else
    ModalResult:=mrOk;
  Close;
end;

procedure TFrmOAuth2.UniTimer1Timer(Sender: TObject);
var
  JSON:TlkJSONbase;
begin
  if Code<>'' then
  begin
    TUniTimer(Sender).Enabled:=False;
    UniLabel1.Caption:='Autorizado';
    UniLabel1.Visible:=True;
    UniLabel1.Font.Color:=clGreen;
    UniButton1.Caption:='Aceptar';
    JSON:=TlkJSONbase(TlkJSON.ParseText(HazPost(FURLToken,
                                                ['code='+Code,
                                                 'client_id='+FClientID,
                                                 'client_secret='+FSecret,
                                                 'redirect_uri='+FURLRedirect,
                                                 'grant_type=authorization_code'])));
    try
      AccesToken:=JSON.Field['token_type'].Value+' '+JSON.Field['access_token'].Value;
      HoraExpiracion:=IncSecond(Now,JSON.Field['expires_in'].Value);
      if TlkJSONobject(JSON).IndexOfName('refresh_token')>-1 then
        RefreshToken:=JSON.Field['refresh_token'].Value;
    finally
      FreeAndNil(JSON);
    end;
  end
  else
    UniLabel1.Visible:=not UniLabel1.Visible;
end;

end.
