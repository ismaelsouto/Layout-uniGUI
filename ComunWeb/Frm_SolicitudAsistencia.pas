unit Frm_SolicitudAsistencia;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  uniGUITypes, uniGUIAbstractClasses, uniGUIClasses, uniGUIRegClasses, uniGUIForm, uniGUIBaseClasses, uniLabel,
  uniMainMenu, uniImage, uniPanel, uniToolBar, uniImageList, uniEdit,
  FireDAC.Phys.FBDef, FireDAC.Phys.FB,  Data.DB, FireDAC.Comp.Client, uniMemo,
  FireDAC.UI.Intf, FireDAC.Phys, FireDAC.Phys.IB, FireDAC.Phys.IBDef,
  FireDAC.VCLUI.Wait;

type
  TFrmSolicitudAsistencia = class(TUniForm)
    ADWebCAI: TFDConnection;
    CONTACTO: TUniEdit;
    TELEFONO: TUniEdit;
    MOTIVO: TUniEdit;
    UniToolBar1: TUniToolBar;
    UBAceptar: TUniToolButton;
    UBSalir: TUniToolButton;
    Label1: TUniLabel;
    Label2: TUniLabel;
    Label3: TUniLabel;
    Panel1: TUniPanel;
    Memo1: TUniMemo;
    procedure FormCreate(Sender: TObject);
    procedure UBAceptarClick(Sender: TObject);
    procedure UBSalirClick(Sender: TObject);
  private
    { Private declarations }
    FLicencia:String;
    FPrograma:String;
  public
    { Public declarations }
    Constructor Create(AOwner: TComponent;Programa : string;ID_Usuario: Integer);overload;
  end;

implementation

uses StrUtils, Funciones;

{$R *.dfm}

constructor TFrmSolicitudAsistencia.Create(AOwner: TComponent; Programa : string;
  ID_Usuario: Integer);
begin
  inherited Create(AOwner);

  ADWebCAI.Open;
  FPrograma:=Programa;




  with CDSRestFacturaGDB('SELECT LICENCIA ' +
        'FROM USUARIOS ' +
        'INNER JOIN LICENCIAS_PROGRAMAS_WEB ON (USUARIOS.EMPRESA=LICENCIAS_PROGRAMAS_WEB.CLAVEEMP AND ' +
        '     LICENCIAS_PROGRAMAS_WEB.PROGRAMA=' + QuotedStr(Programa)+ ') ' +
        'WHERE IDUSUARIOS=' + IntToStr(ID_Usuario)) do
    try

//  Memo1.Hint  := QuotedStr(Programa) + ' - ' + IntToStr(ID_Usuario) + ' - ' + Fields.Fields[0].AsString;

      if not IsEmpty then FLicencia := Fields.Fields[0].AsString;
    finally
      free;
    end;

  UBAceptar.Enabled  := FLicencia <> '';
end;


procedure TFrmSolicitudAsistencia.FormCreate(Sender: TObject);
begin
  with CDSRestFacturaGDB('SELECT TELE1EMP FROM SERVICIOS INNER JOIN DATOS_EMPRESA ON (NUEMPSER=CLAVEEMP) WHERE LICENCIA='+QuotedStr(FLicencia)) do
    try
      if not IsEmpty then TELEFONO.Text:=Fields.Fields[0].AsString;
    finally
      free;
    end;
end;

procedure TFrmSolicitudAsistencia.UBAceptarClick(Sender: TObject);
begin
  if (trim(CONTACTO.Text)<>'') and (trim(MOTIVO.Text)<>'') then
  begin
    ADWebCAI.ExecSQL('INSERT INTO SOLICITUDES_ASISTENCIA(IDSOLICITUDES_ASISTENCIA,DEPARTAMENTO,LICENCIA,TELEFONO,CONTACTO,NOTAS,HORA,RECIBIDO) VALUES('+#13+
                     'GEN_ID(SOLICITUDES_ASISTENCIA,1),'+#13+
                     QuotedStr(IfThen(FPrograma='CAILABWEB','L',
                               IfThen(FPrograma='CAICONTA','C',
                               IfThen(FPrograma='CAICONTAWEB','C',
                               IfThen(FPrograma='CAIERP','G',
                               IfThen(FPrograma='FACTUFB','T',
                               IfThen(FPrograma='FISCAL','F',
                               IfThen(FPrograma='CAIFISWEB','F',
                               IfThen(FPrograma='RENTA','R',
                               IfThen(FPrograma='SOCIEDADES','S',
                               IfThen(FPrograma='GDI','D',
                               IfThen(FPrograma='PORTALEMP','P',
                               IfThen(FPrograma='CAIDOC','B')))))))))))))+','+#13+
                     QuotedStr(FLicencia)+','+#13+
                     QuotedStr(TELEFONO.Text)+','+#13+
                     QuotedStr(CONTACTO.Text)+','+#13+
                     QuotedStr(Copy(MOTIVO.Text,1,40))+','+#13+
                     'CURRENT_TIMESTAMP,'+#13+
                     '''N'')');
    with ConsultaAD(ADWebCAI,'SELECT TIEMPO FROM TIEMPOS_ESTIMADOS_LLAMADA WHERE IDTIEMPOS_ESTIMADOS_LLAMADA='+
                             IfThen(FPrograma='CAILABWEB','1',
                             IfThen(FPrograma='CAICONTA','3',
                             IfThen(FPrograma='CAICONTAWEB','3',
                             IfThen(FPrograma='CAIERP','5',
                             IfThen(FPrograma='FACTUFB','5',
                             IfThen(FPrograma='FISCAL','2',
                             IfThen(FPrograma='RENTA','2',
                             IfThen(FPrograma='SOCIEDADES','2',
                             IfThen(FPrograma='GDI','6',
                             IfThen(FPrograma='PORTALEMP','6',
                             IfThen(FPrograma='CAIDOC','3')))))))))))) do
      try
        if trim(Fields.Fields[0].AsString)<>'' then
          ShowMessage('Tiempo estimado de nuestra llamada: '+Fields.Fields[0].AsString);
      finally
        Free;
      end;

    Self.Close;
  end;
end;

procedure TFrmSolicitudAsistencia.UBSalirClick(Sender: TObject);
begin
  Self.Close;
end;

end.

