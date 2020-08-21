unit Frm_DatosIdentificativos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniToolBar, uniGUIBaseClasses, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, uniLabel, uniEdit, uniDBEdit, uniButton, uniBitBtn, uniPanel,
  FireDAC.DatS, FireDAC.DApt;

type
  TFrmDatosIdentificativos = class(TUniForm)
    UniToolBar1: TUniToolBar;
    UBAceptar: TUniToolButton;
    UBCancelar: TUniToolButton;
    ADDatos: TFDQuery;
    ADDatosNOMBRE: TStringField;
    ADDatosPFAPELL1: TStringField;
    ADDatosPFAPELL2: TStringField;
    ADDatosPFNOMBRE: TStringField;
    ADDatosPJURIDIC: TStringField;
    ADDatosSIGLA: TStringField;
    ADDatosCALLE: TStringField;
    ADDatosNUMERO: TStringField;
    ADDatosESCALERA: TStringField;
    ADDatosPISO: TStringField;
    ADDatosPUERTA: TStringField;
    ADDatosCPOSTAL: TIntegerField;
    ADDatosCPOBLACI: TIntegerField;
    ADDatosPOBLACIO: TStringField;
    ADDatosCPROVINC: TIntegerField;
    ADDatosCADMINIS: TIntegerField;
    ADDatosCOMUNIDA: TStringField;
    ADDatosNIF: TStringField;
    ADDatosTELEFON1: TStringField;
    ADDatosTELEFON2: TStringField;
    ADDatosFAX: TStringField;
    ADDatosCONTACTO: TStringField;
    ADDatosDIRCONTA: TStringField;
    ADDatosDIRLABOR: TStringField;
    ADDatosDIRFISCA: TStringField;
    ADDatosDIRRENT1: TStringField;
    ADDatosDIRRENT2: TStringField;
    ADDatosDIRRENT3: TStringField;
    ADDatosDIRINTER: TStringField;
    ADDatosDIRTEMPO: TStringField;
    ADDatosHOJAS: TStringField;
    ADDatosSEGURIDA: TStringField;
    ADDatosCOPIAADI: TStringField;
    ADDatosREGISTRO: TStringField;
    ADDatosPAPELDGR: TStringField;
    ADDatosRENTUSUA: TStringField;
    ADDatosSOCIUSUA: TStringField;
    ADDatosFISCUSUA: TStringField;
    ADDatosBORRAR: TStringField;
    ADDatosSOCIBORR: TStringField;
    ADDatosVERSION: TStringField;
    ADDatosLENGUA: TStringField;
    ADDatosMESCOPIA: TIntegerField;
    ADDatosFECCOPIA: TSQLTimeStampField;
    ADDatosUSUARIO_NOMBRE: TStringField;
    ADDatosUSUARIO_CONTRASENA: TStringField;
    DSDatos: TDataSource;
    PanelContenedor: TUniPanel;
    NIF: TUniDBEdit;
    PFAPELL1: TUniDBEdit;
    PFAPELL2: TUniDBEdit;
    PFNOMBRE: TUniDBEdit;
    PJURIDIC: TUniDBEdit;
    CALLE: TUniDBEdit;
    NUMERO: TUniDBEdit;
    ESCALERA: TUniDBEdit;
    PISO: TUniDBEdit;
    PUERTA: TUniDBEdit;
    CPOSTAL: TUniDBEdit;
    POBLACIO: TUniDBEdit;
    CPOBLACI: TUniDBEdit;
    TELEFON1: TUniDBEdit;
    TELEFON2: TUniDBEdit;
    FAX: TUniDBEdit;
    CONTACTO: TUniDBEdit;
    Label10: TUniLabel;
    LAPELLIDOS: TUniLabel;
    LPFNOMBRE: TUniLabel;
    LPJURIDIC: TUniLabel;
    Label1: TUniLabel;
    Label14: TUniLabel;
    Label15: TUniLabel;
    Label16: TUniLabel;
    Label23: TUniLabel;
    Label3: TUniLabel;
    Label8: TUniLabel;
    Label6: TUniLabel;
    Label7: TUniLabel;
    SIGLA: TUniDBEdit;
    CPROVINC: TUniDBEdit;
    COMUNIDA: TUniDBEdit;
    CADMINIS: TUniDBEdit;
    UBBBuscaCodigoPostal: TUniBitBtn;
    UBBBuscrSigla: TUniBitBtn;
    UBBBuscaMunicipio: TUniBitBtn;
    UBBBuscarProvincia: TUniBitBtn;
    UBBBuscarComunidad: TUniBitBtn;
    UBBBuscarCodigoAEAT: TUniBitBtn;
    ADDatosCCOMUNIDA: TStringField;
    procedure UBBBuscrSiglaClick(Sender: TObject);
    procedure UBBBuscaCodigoPostalClick(Sender: TObject);
    procedure UBBBuscarProvinciaClick(Sender: TObject);
    procedure UBCancelarClick(Sender: TObject);
    procedure UBAceptarClick(Sender: TObject);
    procedure UniFormCreate(Sender: TObject);
    procedure UniFormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure UBBBuscaMunicipioClick(Sender: TObject);
    procedure ADDatosCPROVINCGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure UBBBuscarComunidadClick(Sender: TObject);
    procedure UBBBuscarCodigoAEATClick(Sender: TObject);
    procedure ADDatosCPOSTALChange(Sender: TField);
    procedure NIFAjaxEvent(Sender: TComponent; EventName: string;
      Params: TUniStrings);
    procedure ADDatosCPOBLACIChange(Sender: TField);
    procedure ADDatosSIGLAChange(Sender: TField);
    procedure DSDatosDataChange(Sender: TObject; Field: TField);
    procedure ADDatosCalcFields(DataSet: TDataSet);
  private
    { Private declarations }
    procedure PersonaFisica(Modificando:boolean);
  public
    { Public declarations }
  end;

function FrmDatosIdentificativos: TFrmDatosIdentificativos;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication, Frm_Siglas_Browse, Frm_Siglas_Editor,
  Frm_CodigosPostales_Browse, Frm_CodigosPostales_Editor,
  Frm_Localidades_Browse, Frm_Localidades_Editor, Frm_AEAT_Browse,
  Frm_AEAT_Editor, Frm_Comunidades_Browse, Frm_Comunidades_Editor,
  Frm_Provincias_Browse, Frm_Provincias_Editor, Funciones, StrUtils, uniGUIDialogs, Math;

function FrmDatosIdentificativos: TFrmDatosIdentificativos;
begin
  Result := TFrmDatosIdentificativos(UniMainModule.GetFormInstance(TFrmDatosIdentificativos));
end;

procedure TFrmDatosIdentificativos.ADDatosCalcFields(DataSet: TDataSet);
begin
  with ConsultaAD(UniMainModule.ADConexionGeneral,'SELECT NOMBRE FROM COMUNIDA WHERE CODIGO='+QuotedStr(ADDatosCOMUNIDA.AsString)) do
  try
    ADDatosCCOMUNIDA.AsString:=Fields[0].AsString;
  finally
    Free;
  end;
end;

procedure TFrmDatosIdentificativos.ADDatosCPOBLACIChange(Sender: TField);
begin
  Funciones.CambioCodigoMunicipio(CPOBLACI,CPROVINC.Field,CPOBLACI.Field,POBLACIO.Field,POBLACIO);
end;

procedure TFrmDatosIdentificativos.ADDatosCPOSTALChange(Sender: TField);
begin
  Funciones.CambioCP(CPOSTAL,CPOSTAL.Field,CPROVINC.Field,CPOBLACI.Field,POBLACIO.Field,CPOBLACI,POBLACIO);
end;

procedure TFrmDatosIdentificativos.ADDatosCPROVINCGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
var
  Consulta:TFDQuery;
begin
  if Sender.AsInteger<>0 then
  begin
    Consulta:=ConsultaAD(UniMainModule.ADConexionGeneral,'SELECT NOMBRE FROM PROVINCI WHERE CODIGO='+IntToStr(Sender.AsInteger));
    try
      Text:=Consulta.Fields.Fields[0].AsString;
    finally
      FreeAndNil(Consulta);
    end;
  end;
end;

procedure TFrmDatosIdentificativos.ADDatosSIGLAChange(Sender: TField);
begin
  ValidaCampo(SIGLA,
              ConsultaAD(UniMainModule.ADConexionGeneral,'SELECT CODIGO FROM SIGLAS WHERE CODIGO='+QuotedStr(SIGLA.Field.AsString)),
              'Sigla inexistente')
end;

procedure TFrmDatosIdentificativos.DSDatosDataChange(Sender: TObject;
  Field: TField);
begin
  if not Assigned(Field) and Assigned(POBLACIO) then
  begin
    POBLACIO.ReadOnly:=not CPOBLACI.Field.IsNull;
    POBLACIO.TabStop:=CPOBLACI.Field.IsNull;
    POBLACIO.Color:=IfThen(CPOBLACI.Field.IsNull,clWindow,clInfoBk);
  end;
end;

procedure TFrmDatosIdentificativos.NIFAjaxEvent(Sender: TComponent;
  EventName: string; Params: TUniStrings);
var
  LNIF:String;
begin
  inherited;
  if not LanzaCambio(Sender,EventName,Params) then
    if SameText('CAMBIO',EventName) then
    begin
      LNIF:=CalcCifNif('ES',ADDatosNIF.AsString,True);
      if LNIF='MAL' then
        ADDatosNIF.AsString:=Params.Values['anterior']
      else begin
        ADDatosNIF.AsString:=LNIF;
        PersonaFisica(True);
      end;
    end
end;

procedure TFrmDatosIdentificativos.PersonaFisica(Modificando: boolean);
begin
  if Funciones.PersonaFisica('ES',
                             ADDatosNIF.AsString) then
  begin
    PFAPELL2.Enabled:=True;
    PFAPELL1.Enabled:=True;
    PFNOMBRE.Enabled:=True;
    PJURIDIC.Enabled:=False;
    LAPELLIDOS.Enabled:=True;
    LPFNOMBRE.Enabled:=True;
    LPJURIDIC.Enabled:=False;
    PFAPELL2.Color:=clWhite;
    PFAPELL1.Color:=clWhite;
    PFNOMBRE.Color:=clWhite;
    PJURIDIC.Color:=clInfoBk;
    if Modificando then
    begin
      ADDatosPJURIDIC.Clear;
      ADDatosNOMBRE.AsString:=ADDatosPFAPELL1.AsString+' '+
                              ADDatosPFAPELL2.AsString+', '+
                              ADDatosPFNOMBRE.AsString;

    end;
  end
  else begin
    PFAPELL2.Enabled:=False;
    PFAPELL1.Enabled:=False;
    PFNOMBRE.Enabled:=False;
    PJURIDIC.Enabled:=True;
    LAPELLIDOS.Enabled:=False;
    LPFNOMBRE.Enabled:=False;
    LPJURIDIC.Enabled:=True;
    PFAPELL2.Color:=clInfoBk;
    PFAPELL1.Color:=clInfoBk;
    PFNOMBRE.Color:=clInfoBk;
    PJURIDIC.Color:=clWhite;
    if Modificando then
    begin
      ADDatosPFAPELL1.Clear;
      ADDatosPFAPELL2.Clear;
      ADDatosPFNOMBRE.Clear;
      ADDatosNOMBRE.AsString:=ADDatosPJURIDIC.AsString;
     end;
  end;
end;

procedure TFrmDatosIdentificativos.UBAceptarClick(Sender: TObject);
begin
  ADDatos.CheckBrowseMode;
  Self.Close;
end;

procedure TFrmDatosIdentificativos.UBBBuscaCodigoPostalClick(Sender: TObject);
begin
  TFrmCodigosPostalesBrowse.Crear(TFrmCodigosPostalesEditor,'','CPOSTAL DESC',ADDatosCPOSTAL,'CPOSTAL').ShowModal;
end;

procedure TFrmDatosIdentificativos.UBBBuscaMunicipioClick(Sender: TObject);
begin
  TFrmLocalidadesBrowse.Crear(TFrmLocalidadesEditor,'PROVINCIA='+IntToStr(ADDatosCPROVINC.AsInteger),'DESCRIPCION DESC',ADDatosCPOBLACI,'LOCALIDAD').ShowModal(
                              procedure (Sender: TComponent; AResult:Integer)
                              begin
                                if AResult=mrOk then
                                  with ConsultaAD(UniMainModule.ADConexionGeneral,
                                                  'SELECT DESCRIPCION'+#13+
                                                  'FROM LOCALIDADES'+#13+
                                                  'WHERE PROVINCIA='+IntToStr(CPROVINC.Field.AsInteger)+' AND'+#13+
                                                  '      LOCALIDAD='+IntToStr(CPOBLACI.Field.AsInteger)) do
                                    try
                                      ADDatosPOBLACIO.AsString:=Fields.Fields[0].AsString;
                                    finally
                                      Free;
                                    end;
                              end);
end;

procedure TFrmDatosIdentificativos.UBBBuscarCodigoAEATClick(Sender: TObject);
begin
  TFrmAEATBrowse.Crear(TFrmAEATEditor,'','CODIGO',ADDatosCADMINIS,'CODIGO').ShowModal;
end;

procedure TFrmDatosIdentificativos.UBBBuscarComunidadClick(Sender: TObject);
begin
  TFrmComunidadesBrowse.Crear(TFrmComunidadesEditor,'','CODIGO',ADDatosCOMUNIDA,'CODIGO').ShowModal;
end;

procedure TFrmDatosIdentificativos.UBBBuscarProvinciaClick(Sender: TObject);
begin
  TFrmProvinciasBrowse.Crear(TFrmProvinciasEditor,'','NOMBRE',ADDatosCPROVINC,'CODIGO').ShowModal;
end;

procedure TFrmDatosIdentificativos.UBBBuscrSiglaClick(Sender: TObject);
begin
  TFrmSiglasBrowse.Crear(TFrmSiglasEditor,'','CODIGO DESC',SIGLA.Field,'CODIGO').ShowModal;
end;

procedure TFrmDatosIdentificativos.UBCancelarClick(Sender: TObject);
begin
  ADDatos.Cancel;
  Self.Close;
end;

procedure TFrmDatosIdentificativos.UniFormCreate(Sender: TObject);
begin
  ADDatos.Open;
  PersonaFisica(False);
  AsignaCambioDBEdit(NIF);
  MonitorizarTeclas(Self,[VK_ESCAPE,VK_RETURN],False);
end;

procedure TFrmDatosIdentificativos.UniFormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_ESCAPE:UBCancelarClick(UBCancelar);
    VK_RETURN:UBAceptarClick(UBAceptar);
  end;
end;

end.
