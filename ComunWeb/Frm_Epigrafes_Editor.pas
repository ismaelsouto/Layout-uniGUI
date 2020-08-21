unit Frm_Epigrafes_Editor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, Frm_Dialogo, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.Comp.DataSet, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, Data.DB,  FireDAC.Comp.Client,
  uniToolBar, uniGUIBaseClasses, uniPanel, uniButton, uniBitBtn, uniEdit,
  uniDBEdit, uniLabel, uniMultiItem, uniComboBox, uniDBComboBox,
  uniDBLookupComboBox, Funciones, Frm_CNAE_Browse, Frm_CNAE_Editor,
  FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt;

type
  TFrmEpigrafesEditor = class(TFrmDialogo)
    UniDBLookupComboBox1: TUniDBLookupComboBox;
    UniLabel1: TUniLabel;
    ADClienteTIPO: TStringField;
    ADClienteEPIGRAFE: TStringField;
    ADClienteNOMBRE: TStringField;
    ADClienteIMPRIMIR: TStringField;
    ADClienteCNAE_NIVEL_2_1: TStringField;
    ADClienteCNAE_NIVEL_2_2: TStringField;
    ADClienteCNAE_NIVEL_2_3: TStringField;
    ADClienteCNAE_NIVEL_2_4: TStringField;
    ADClienteCNAE_NIVEL_2_5: TStringField;
    ADClienteCNAE_NIVEL_3_1: TStringField;
    ADClienteCNAE_NIVEL_5_1: TStringField;
    EPIGRAFE: TUniDBEdit;
    UniLabel2: TUniLabel;
    NOMBRE: TUniDBEdit;
    UniLabel3: TUniLabel;
    UniLabel4: TUniLabel;
    CCNAE_NIVEL_2_1: TUniDBEdit;
    UBBuscarCNAE2_1: TUniBitBtn;
    UniLabel5: TUniLabel;
    CCNAE_NIVEL_2_2: TUniDBEdit;
    UBBuscarCNAE2_2: TUniBitBtn;
    UniLabel6: TUniLabel;
    CCNAE_NIVEL_2_3: TUniDBEdit;
    UBBuscarCNAE2_3: TUniBitBtn;
    UniLabel7: TUniLabel;
    CCNAE_NIVEL_3_1: TUniDBEdit;
    UBBuscarCNAE3: TUniBitBtn;
    UniLabel8: TUniLabel;
    CCNAE_NIVEL_5_1: TUniDBEdit;
    UBBuscarCNAE5: TUniBitBtn;
    ADTipos: TFDMemTable;
    ADTiposTIPO: TStringField;
    ADTiposDESCRIPCION: TStringField;
    DSTipos: TDataSource;
    ADClienteCCNAE_NIVEL_2_1: TStringField;
    ADClienteCCNAE_NIVEL_2_2: TStringField;
    ADClienteCCNAE_NIVEL_2_3: TStringField;
    ADClienteCCNAE_NIVEL_2_4: TStringField;
    ADClienteCCNAE_NIVEL_2_5: TStringField;
    ADClienteCCNAE_NIVEL_3_1: TStringField;
    ADClienteCCNAE_NIVEL_5_1: TStringField;
    procedure UniFormCreate(Sender: TObject);
    procedure ADClienteNewRecord(DataSet: TDataSet);
    procedure UBBuscarCNAE2_1Click(Sender: TObject);
    procedure UBBuscarCNAE2_2Click(Sender: TObject);
    procedure UBBuscarCNAE2_3Click(Sender: TObject);
    procedure UBBuscarCNAE3Click(Sender: TObject);
    procedure UBBuscarCNAE5Click(Sender: TObject);
    procedure ADClienteCalcFields(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function FrmEpigrafesEditor: TFrmEpigrafesEditor;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication;

function FrmEpigrafesEditor: TFrmEpigrafesEditor;
begin
  Result := TFrmEpigrafesEditor(UniMainModule.GetFormInstance(TFrmEpigrafesEditor));
end;

procedure TFrmEpigrafesEditor.ADClienteCalcFields(DataSet: TDataSet);
var
  i:Integer;
  Campo:String;
begin
  inherited;
  for i:=1 to 7 do
  begin
    case i of
      6:Campo:='CNAE_NIVEL_3_1';
      7:Campo:='CNAE_NIVEL_5_1';
      else Campo:='CNAE_NIVEL_2_'+IntToStr(i);
    end;
    with ConsultaAD(UniMainModule.ADConexionGeneral,'SELECT CNAE||'' - ''||COALESCE(NOMBRE,'''') FROM CNAE_NIVEL_'+Copy(Campo,12,1)+' WHERE CNAE='+QuotedStr(ADCliente.FieldByName(Campo).AsString)) do
      try
        ADCliente.FieldByName('C'+Campo).AsString:=Fields[0].AsString;
      finally
        Free;
      end;
  end;
end;

procedure TFrmEpigrafesEditor.ADClienteNewRecord(DataSet: TDataSet);
begin
  inherited;
  ADClienteTIPO.AsString:='E';
  ADClienteEPIGRAFE.AsString:='';
end;

procedure TFrmEpigrafesEditor.UBBuscarCNAE2_1Click(Sender: TObject);
begin
  inherited;
  TFrmCNAEBrowse.Crear(TFrmCNAEEditor,'NIVEL=2','',ADClienteCNAE_NIVEL_2_1,'CNAE').ShowModal;
end;

procedure TFrmEpigrafesEditor.UBBuscarCNAE2_2Click(Sender: TObject);
begin
  inherited;
  TFrmCNAEBrowse.Crear(TFrmCNAEEditor,'NIVEL=2','',ADClienteCNAE_NIVEL_2_2,'CNAE').ShowModal;
end;

procedure TFrmEpigrafesEditor.UBBuscarCNAE2_3Click(Sender: TObject);
begin
  inherited;
  TFrmCNAEBrowse.Crear(TFrmCNAEEditor,'NIVEL=2','',ADClienteCNAE_NIVEL_2_3,'CNAE').ShowModal;
end;

procedure TFrmEpigrafesEditor.UBBuscarCNAE3Click(Sender: TObject);
begin
  inherited;
  TFrmCNAEBrowse.Crear(TFrmCNAEEditor,'NIVEL=3','',ADClienteCNAE_NIVEL_3_1,'CNAE').ShowModal;
end;

procedure TFrmEpigrafesEditor.UBBuscarCNAE5Click(Sender: TObject);
begin
  inherited;
  TFrmCNAEBrowse.Crear(TFrmCNAEEditor,'NIVEL=5','',ADClienteCNAE_NIVEL_5_1,'CNAE').ShowModal;
end;

procedure TFrmEpigrafesEditor.UniFormCreate(Sender: TObject);
begin
  inherited;
  with ADTipos do
  begin
    AppendRecord(['S','Sin Epígrafe']);
    AppendRecord(['B','Batea']);
    AppendRecord(['E','Empresarial']);
    AppendRecord(['P','Profesional']);
    AppendRecord(['A','Artistica']);
  end;
end;

end.
