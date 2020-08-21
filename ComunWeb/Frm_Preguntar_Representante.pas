unit Frm_Preguntar_Representante;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes,uniGUIForm, Vcl.Controls, Vcl.StdCtrls, Vcl.Forms,
  uniGUIBaseClasses, uniGUIClasses, uniButton, uniBitBtn, uniEdit, uniLabel,
  uniFileUpload,SBWinCertStorage,SBX509, uniDBEdit, Data.DB, Funciones,uniGUITypes;

type
  TFrmPreguntarRepresentante = class(TuniForm)
    Button1: TUniBitBtn;
    UniLabel1: TUniLabel;
    UniLabel2: TUniLabel;
    UniLabel3: TUniLabel;
    UniDBEditRep_Nombre: TUniDBEdit;
    lbNombre_ast: TUniLabel;
    UniDBEditREP_NIF: TUniDBEdit;
    UniLabel4: TUniLabel;
    UniLabel5: TUniLabel;
    UniDBEditRep_cargo: TUniDBEdit;
    DataSource_representante: TDataSource;
    procedure Button1Click(Sender: TObject);
    procedure UniFormCreate(Sender: TObject);
    procedure UniDBEditREP_NIFAjaxEvent(Sender: TComponent; EventName: string;
      Params: TUniStrings);
  private
    DestName : string;
    DestFolder : string;

  public
    Certificado:TElX509Certificate;
    FICHERO_FACTURA:string;
  end;

var
  FrmPreguntarRepresentante: TFrmPreguntarRepresentante;

implementation

uses
  ServerModule;

{$R *.dfm}

procedure TFrmPreguntarRepresentante.Button1Click(Sender: TObject);
begin
  if trim(DataSource_representante.DataSet.FieldByName('REPRESENTANTE_NIF_EMP').AsString)='' then
  begin
   UniDBEditREP_NIF.SetFocus;
    raise Exception.Create('Debe grabar un NIF para el representante antes de continuar.');
  end;

  if trim(DataSource_representante.DataSet.FieldByName('REPRESENTANTE_NOMBRE_EMP').AsString)='' then
  begin
   UniDBEditRep_Nombre.SetFocus;
    raise Exception.Create('Debe grabar un nombre para el representante antes de continuar.');
  end;

  if trim(DataSource_representante.DataSet.FieldByName('REPRESENTANTE_CARGO_EMP').AsString)='' then
  begin
   UniDBEditRep_cargo.SetFocus;
    raise Exception.Create('Debe grabar un cargo para el representante antes de continuar.');
  end;

  ModalResult:=mrOk;
end;

procedure TFrmPreguntarRepresentante.UniDBEditREP_NIFAjaxEvent(
  Sender: TComponent; EventName: string; Params: TUniStrings);
var
  LNIF:String;
begin
  inherited;
  if not LanzaCambio(Sender,EventName,Params) then
    if SameText('CAMBIO',EventName) then
    begin
      LNIF:=CalcCifNif('ES',DataSource_representante.DataSet.FieldByName('REPRESENTANTE_NIF_EMP').AsString,True);
      if LNIF='MAL' then
        DataSource_representante.DataSet.FieldByName('REPRESENTANTE_NIF_EMP').AsString:=Params.Values['anterior']
      else begin
        DataSource_representante.DataSet.FieldByName('REPRESENTANTE_NIF_EMP').AsString:=LNIF;
      end;
    end;
end;

procedure TFrmPreguntarRepresentante.UniFormCreate(Sender: TObject);
begin
  AsignaCambioDBEdit(UniDBEditREP_NIF);
end;

end.
