unit Frm_MaestroNIF_Editor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, Frm_Dialogo, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  uniToolBar, uniGUIBaseClasses, uniPanel, uniMultiItem, uniComboBox,
  uniDBComboBox, uniDBLookupComboBox, uniEdit, uniDBEdit, uniLabel,
  Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls, DBEditC, Vcl.Buttons, Vcl.ExtCtrls,
  Frm_Paises_Browse, Frm_Paises_Editor, Frm_Provincias_Browse,
  Frm_Provincias_Editor, Frm_CodigosPostales_Browse, Frm_CodigosPostales_Editor,
  Frm_Localidades_Browse, Frm_Localidades_Editor, Frm_Siglas_Browse,
  Frm_Siglas_Editor, uniButton, uniBitBtn, Funciones, uniDBText;

type
  TFrmMaestroNIFEditor = class(TFrmDialogo)
    LPFAPELL1: TUniLabel;
    LPFAPELL2: TUniLabel;
    LPFNOMBRE: TUniLabel;
    LPJURIDIC: TUniLabel;
    Label5: TUniLabel;
    Label6: TUniLabel;
    Label7: TUniLabel;
    Label8: TUniLabel;
    Label9: TUniLabel;
    Label10: TUniLabel;
    Label11: TUniLabel;
    Label12: TUniLabel;
    Label13: TUniLabel;
    Label14: TUniLabel;
    Label15: TUniLabel;
    Label16: TUniLabel;
    Label17: TUniLabel;
    Label18: TUniLabel;
    Label19: TUniLabel;
    Label20: TUniLabel;
    Label21: TUniLabel;
    Label22: TUniLabel;
    Label23: TUniLabel;
    Label24: TUniLabel;
    PFAPELL1_1: TUniDBEdit;
    PFNOMBRE_1: TUniDBEdit;
    PFAPELL2_1: TUniDBEdit;
    NUMERO: TUniDBEdit;
    PISO: TUniDBEdit;
    PUERTA: TUniDBEdit;
    TELEFON1: TUniDBEdit;
    TELEFON2: TUniDBEdit;
    PJURIDIC_1: TUniDBEdit;
    CALLE: TUniDBEdit;
    NIF: TUniDBEdit;
    ESCALERA: TUniDBEdit;
    CPOSTAL: TUniDBEdit;
    BLOQUE: TUniDBEdit;
    BIS: TUniDBEdit;
    CPOBLACI: TUniDBEdit;
    POBLACIO: TUniDBEdit;
    CODIGO_ZIP: TUniDBEdit;
    CIFREFIS: TUniDBEdit;
    CLAVE_NIF_RESIDENCIA: TUniDBLookupComboBox;
    ADClienteINTERNO: TIntegerField;
    ADClientePAIS: TStringField;
    ADClienteNIF: TStringField;
    ADClientePFAPELL1_1: TStringField;
    ADClientePFAPELL2_1: TStringField;
    ADClientePFNOMBRE_1: TStringField;
    ADClientePJURIDIC_1: TStringField;
    ADClienteNOMBRE_1: TStringField;
    ADClienteSIGLA: TStringField;
    ADClienteCALLE: TStringField;
    ADClienteNUMERO: TStringField;
    ADClienteESCALERA: TStringField;
    ADClientePISO: TStringField;
    ADClientePUERTA: TStringField;
    ADClienteCPOSTAL: TIntegerField;
    ADClienteCPOBLACI: TIntegerField;
    ADClientePOBLACIO: TStringField;
    ADClienteCPROVINC: TIntegerField;
    ADClienteTELEFON1: TStringField;
    ADClienteTELEFON2: TStringField;
    ADClienteBLOQUE: TStringField;
    ADClienteBIS: TStringField;
    ADClientePOAMPLIA: TStringField;
    ADClientePAIS_RESIDENCIA: TStringField;
    ADClienteCLAVE_NIF_RESIDENCIA: TIntegerField;
    ADClienteCIFREFIS: TStringField;
    ADClienteCODIGO_ZIP: TStringField;
    LabelC1: TUniLabel;
    SIGLA: TUniDBEdit;
    CPROVINC: TUniDBEdit;
    PAIS: TUniDBEdit;
    CPAIS_RESIDENCIA: TUniDBEdit;
    UBBBuscrSigla: TUniBitBtn;
    UBBBuscarPais: TUniBitBtn;
    UBBCoigoPostal: TUniBitBtn;
    UBBBuscarPaisResidencia: TUniBitBtn;
    UniBitBtn4: TUniBitBtn;
    UBBBuscarProvincia: TUniBitBtn;
    ADClavesPaisResidencia: TFDMemTable;
    DSClavesPaisResidencia: TDataSource;
    ADClavesPaisResidenciaDESCRIPCION: TStringField;
    NOMBRE_1: TUniDBText;
    POAMPLIA: TUniDBEdit;
    ADClavesPaisResidenciaCLAVE: TStringField;
    ADClienteCPAIS_RESIDENCIA: TStringField;
    procedure UBBBuscarPaisClick(Sender: TObject);
    procedure UBBBuscrSiglaClick(Sender: TObject);
    procedure UBBCoigoPostalClick(Sender: TObject);
    procedure ADClienteCPOSTALChange(Sender: TField);
    procedure UBBBuscarPaisResidenciaClick(Sender: TObject);
    procedure UniBitBtn4Click(Sender: TObject);
    procedure UBBBuscarProvinciaClick(Sender: TObject);
    procedure UniFormCreate(Sender: TObject);
    procedure NIFAjaxEvent(Sender: TComponent; EventName: string;
      Params: TUniStrings);
    procedure ADClavesPaisResidenciaDESCRIPCIONGetText(Sender: TField;
      var Text: string; DisplayText: Boolean);
    procedure ADClienteCPROVINCGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure ADClienteNewRecord(DataSet: TDataSet);
    procedure NOMBREChange(Sender: TField);
    procedure ADClientePAISChange(Sender: TField);
    procedure ADClienteSIGLAChange(Sender: TField);
    procedure ADClienteCPOBLACIChange(Sender: TField);
    procedure ADClienteCalcFields(DataSet: TDataSet);
  private
    { Private declarations }
    function AntesDeGrabar:Boolean;Override;
    procedure PersonaFisica(Modificando:boolean);
    procedure ActualizaDetalles;Override;
  public
    { Public declarations }
  end;

function FrmMaestroNIFEditor: TFrmMaestroNIFEditor;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication, UniGUiDialogs, Frm_MaestroNIF_Browse;

function FrmMaestroNIFEditor: TFrmMaestroNIFEditor;
begin
  Result := TFrmMaestroNIFEditor(UniMainModule.GetFormInstance(TFrmMaestroNIFEditor));
end;

procedure TFrmMaestroNIFEditor.ActualizaDetalles;
begin
  PersonaFisica(False);
end;

procedure TFrmMaestroNIFEditor.ADClavesPaisResidenciaDESCRIPCIONGetText(
  Sender: TField; var Text: string; DisplayText: Boolean);
begin
  inherited;
  Text:=Sender.Dataset.FieldByName('CLAVE').AsString+' - '+Sender.AsString;
end;

procedure TFrmMaestroNIFEditor.ADClienteCalcFields(DataSet: TDataSet);
begin
  inherited;
  with ConsultaAD(UniMainModule.ADConexionGeneral,'SELECT NOMBRE FROM PAISES WHERE CLAVE='+QuotedStr(ADClientePAIS_RESIDENCIA.AsString)) do
    try
      if not IsEmpty then
        ADClienteCPAIS_RESIDENCIA.AsString:=Fields[0].AsString
      else
        ADClienteCPAIS_RESIDENCIA.Clear;
    finally
      Free;
    end;
end;

procedure TFrmMaestroNIFEditor.ADClienteCPOBLACIChange(Sender: TField);
begin
  inherited;
  CambioCodigoMunicipio(CPOBLACI,ADClienteCPROVINC,ADClienteCPOBLACI,ADClientePOBLACIO,CPOBLACI);
end;

procedure TFrmMaestroNIFEditor.ADClienteCPOSTALChange(Sender: TField);
begin
  inherited;
//  with ConsultaAD(UniMainModule.ADConexionGeneral,'SELECT CPOSTALES.LOCALIDAD,CPOSTALES.PROVINCIA,DESCRIPCION'+#13+
//                                                  'FROM CPOSTALES'+#13+
//                                                  'LEFT OUTER JOIN LOCALIDADES ON (LOCALIDADES.LOCALIDAD=CPOSTALES.LOCALIDAD AND LOCALIDADES.PROVINCIA=CPOSTALES.PROVINCIA)'+#13+
//                                                  'WHERE CPOSTAL='+IntToStr(Sender.AsInteger)) do
//    try
//      if not IsEmpty then
//      begin
//        ADClienteCPROVINC.AsInteger:=FieldByName('PROVINCIA').AsInteger;
//        ADClienteCPOBLACI.AsInteger:=FieldByName('LOCALIDAD').AsInteger;
//        ADClientePOBLACIO.AsString:=FieldByName('DESCRIPCION').AsString;
//      end
//      else
//        UniGuiDialogs.ShowMessage('No existe el código postal.');
//    finally
//      Free;
//    end;


  CambioCP(CPOSTAL,ADClienteCPOSTAL,ADClienteCPROVINC,ADClienteCPOBLACI,ADClientePOBLACIO,CPOBLACI,POBLACIO);
end;

procedure TFrmMaestroNIFEditor.ADClienteCPROVINCGetText(Sender: TField;
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

procedure TFrmMaestroNIFEditor.ADClienteNewRecord(DataSet: TDataSet);
begin
  inherited;
  Dataset.FieldByName('INTERNO').AsInteger:=UniMainModule.ADConexionGeneral.ExecSQLScalar('SELECT COALESCE(MAX(INTERNO),0)+1 FROM DATOSFIS');
  Dataset.FieldByName('PAIS').AsString:='ES';
  Dataset.FieldByName('CLAVE_NIF_RESIDENCIA').AsInteger:=1;
end;

procedure TFrmMaestroNIFEditor.ADClientePAISChange(Sender: TField);
begin
  inherited;
  CambioPais(PAIS);
end;

procedure TFrmMaestroNIFEditor.ADClienteSIGLAChange(Sender: TField);
begin
  inherited;
  ValidaCampo(SIGLA,
              ConsultaAD(UniMainModule.ADConexionGeneral,'SELECT CODIGO FROM SIGLAS WHERE CODIGO='+QuotedStr(SIGLA.Field.AsString)),
              'Sigla inexistente')
end;

function TFrmMaestroNIFEditor.AntesDeGrabar: Boolean;
begin
  Result:=True;
  if ADClienteNIF.IsNull then
  begin
    result:=False;
    uniGUIDialogs.ShowMessage('El campo NIF debe tener un valor',
                              procedure (Sender: Tcomponent;AResult:Integer)
                              begin
                                NIF.SetFocus;
                              end);
  end;
end;

procedure TFrmMaestroNIFEditor.NIFAjaxEvent(Sender: TComponent;
  EventName: string; Params: TUniStrings);
var
  LNIF:String;
begin
  inherited;
  if not LanzaCambio(Sender,EventName,Params) then
    if SameText('CAMBIO',EventName) then
    begin
      LNIF:=CalcCifNif(ADClientePAIS.AsString,ADClienteNIF.AsString,True);
      if LNIF='MAL' then
        ADClienteNIF.AsString:=Params.Values['anterior']
      else
        ADClienteNIF.AsString:=LNIF;
        PersonaFisica(True);
    end;
end;

procedure TFrmMaestroNIFEditor.NOMBREChange(Sender: TField);
begin
  inherited;
  if Trim(ADClientePJURIDIC_1.AsString)<>'' then
    ADClienteNOMBRE_1.AsString:=ADClientePJURIDIC_1.AsString
  else
    ADClienteNOMBRE_1.AsString:=ADClientePFAPELL1_1.AsString+' '+
                              ADClientePFAPELL2_1.AsString+', '+
                              ADClientePFNOMBRE_1.AsString;
end;

procedure TFrmMaestroNIFEditor.PersonaFisica(Modificando: boolean);
begin
  if Funciones.PersonaFisica(ADClientePAIS.AsString,
                             ADClienteNIF.AsString) then
  begin
    PFAPELL2_1.Enabled:=True;
    PFAPELL1_1.Enabled:=True;
    PFNOMBRE_1.Enabled:=True;
    PJURIDIC_1.Enabled:=False;
    LPFAPELL1.Enabled:=True;
    LPFAPELL2.Enabled:=True;
    LPFNOMBRE.Enabled:=True;
    LPJURIDIC.Enabled:=False;
    PFAPELL2_1.Color:=clWhite;
    PFAPELL1_1.Color:=clWhite;
    PFNOMBRE_1.Color:=clWhite;
    PJURIDIC_1.Color:=clInfoBk;
    if Modificando then
    begin
      ADClientePJURIDIC_1.Clear;
      ADClienteNOMBRE_1.AsString:=ADClientePFAPELL1_1.AsString+' '+
                                ADClientePFAPELL2_1.AsString+', '+
                                ADClientePFNOMBRE_1.AsString;

    end;
  end
  else begin
    PFAPELL2_1.Enabled:=False;
    PFAPELL1_1.Enabled:=False;
    PFNOMBRE_1.Enabled:=False;
    PJURIDIC_1.Enabled:=True;
    LPFAPELL1.Enabled:=False;
    LPFAPELL2.Enabled:=False;
    LPFNOMBRE.Enabled:=False;
    LPJURIDIC.Enabled:=True;
    PFAPELL2_1.Color:=clInfoBk;
    PFAPELL1_1.Color:=clInfoBk;
    PFNOMBRE_1.Color:=clInfoBk;
    PJURIDIC_1.Color:=clWhite;
    if Modificando then
    begin
      ADClientePFAPELL1_1.Clear;
      ADClientePFAPELL2_1.Clear;
      ADClientePFNOMBRE_1.Clear;
      ADClienteNOMBRE_1.AsString:=ADClientePJURIDIC_1.AsString;
     end;
  end;
end;

procedure TFrmMaestroNIFEditor.UBBBuscarPaisClick(Sender: TObject);
begin
  inherited;
  TFrmPaisesBrowse.Crear(TFrmPaisesEditor,'','NOMBRE',ADClientePAIS,'CLAVE').ShowModal;
end;

procedure TFrmMaestroNIFEditor.UBBBuscarPaisResidenciaClick(Sender: TObject);
begin
  inherited;
  TFrmPaisesBrowse.Crear(TFrmPaisesEditor,'','NOMBRE',ADClientePAIS_RESIDENCIA,'CLAVE').ShowModal;
end;

procedure TFrmMaestroNIFEditor.UBBBuscarProvinciaClick(Sender: TObject);
begin
  inherited;
  TFrmProvinciasBrowse.Crear(TFrmProvinciasEditor,'','NOMBRE',ADClienteCPROVINC,'CODIGO').ShowModal;
end;

procedure TFrmMaestroNIFEditor.UBBBuscrSiglaClick(Sender: TObject);
begin
  inherited;
  TFrmSiglasBrowse.Crear(TFrmSiglasEditor,'','CODIGO DESC',ADClienteSIGLA,'CODIGO').ShowModal;
end;

procedure TFrmMaestroNIFEditor.UBBCoigoPostalClick(Sender: TObject);
begin
  inherited;
  TFrmCodigosPostalesBrowse.Crear(TFrmCodigosPostalesEditor,'','CPOSTAL DESC',ADClienteCPOSTAL,'CPOSTAL').ShowModal;
end;

procedure TFrmMaestroNIFEditor.UniBitBtn4Click(Sender: TObject);
begin
  inherited;
  TFrmLocalidadesBrowse.Crear(TFrmLocalidadesEditor,'PROVINCIA='+IntToStr(ADClienteCPROVINC.AsInteger),'DESCRIPCION DESC',ADClienteCPOBLACI,'LOCALIDAD').ShowModal(
                              procedure (Sender: TComponent; AResult:Integer)
                              begin
                                if AResult=mrOk then
                                  with ConsultaAD(UniMainModule.ADConexionGeneral,
                                                  'SELECT DESCRIPCION'+#13+
                                                  'FROM LOCALIDADES'+#13+
                                                  'WHERE PROVINCIA='+IntToStr(CPROVINC.Field.AsInteger)+' AND'+#13+
                                                  '      LOCALIDAD='+IntToStr(CPOBLACI.Field.AsInteger)) do
                                    try
                                      ADClientePOBLACIO.AsString:=Fields.Fields[0].AsString;
                                    finally
                                      Free;
                                    end;
                              end);
end;

procedure TFrmMaestroNIFEditor.UniFormCreate(Sender: TObject);
begin
  inherited;
  with ADClavesPaisResidencia do
  begin
    AppendRecord(['1','Corresponde a un NIF']);
    AppendRecord(['2','NIF/IVA (NIF operador intracomunitario)']);
    AppendRecord(['3','Pasaporte']);
    AppendRecord(['4','Documento oficial de identificación expedido por el país de residencia']);
    AppendRecord(['5','Certificado de residencia fiscal']);
    AppendRecord(['6','Otro documento probatorio']);
  end;
  AsignaCambioDBEdit(NIF);
end;

end.

