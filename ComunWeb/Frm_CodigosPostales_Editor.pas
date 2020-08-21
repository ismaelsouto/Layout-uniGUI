unit Frm_CodigosPostales_Editor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, Frm_Dialogo, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, uniGUIBaseClasses,  Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, uniPanel, uniToolBar, uniMultiItem,
  uniComboBox, uniDBComboBox, uniDBLookupComboBox, uniLabel, uniEdit, uniDBEdit,
  uniButton, FireDAC.DatS, FireDAC.DApt;

type
  TFrmCodigosPostalesEditor = class(TFrmDialogo)
    Label1: TUniLabel;
    Label2: TUniLabel;
    Label3: TUniLabel;
    Label4: TUniLabel;
    Label5: TUniLabel;
    AUTONOMIA: TUniDBLookupComboBox;
    PROVINCIA: TUniDBLookupComboBox;
    LOCALIDAD: TUniDBLookupComboBox;
    AEAT: TUniDBLookupComboBox;
    DSComunidades: TDataSource;
    ADComunidades: TFDQuery;
    ADComunidadesCODIGO: TStringField;
    ADComunidadesNOMBRE: TStringField;
    DSProvincias: TDataSource;
    ADProvincias: TFDQuery;
    ADProvinciasCODIGO: TIntegerField;
    ADProvinciasNOMBRE: TStringField;
    ADMunicipios: TFDQuery;
    ADMunicipiosLOCALIDAD: TIntegerField;
    ADMunicipiosPROVINCIA: TIntegerField;
    ADMunicipiosDESCRIPCION: TStringField;
    DSMunicipios: TDataSource;
    ADAEAT: TFDQuery;
    ADAEATCODIGO: TStringField;
    ADAEATDELEGACI: TStringField;
    ADAEATADMINIST: TStringField;
    DSAEAT: TDataSource;
    CPOSTAL: TUniDBEdit;
    ADClienteCPOSTAL: TIntegerField;
    ADClienteAEAT: TStringField;
    ADClienteAUTONOMIA: TStringField;
    ADClienteLOCALIDAD: TIntegerField;
    ADClientePROVINCIA: TIntegerField;
    procedure ADClienteBeforeOpen(DataSet: TDataSet);
    procedure ADClienteAfterClose(DataSet: TDataSet);
    procedure UniFormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function FrmCodigosPostalesEditor: TFrmCodigosPostalesEditor;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication;

function FrmCodigosPostalesEditor: TFrmCodigosPostalesEditor;
begin
  Result := TFrmCodigosPostalesEditor(UniMainModule.GetFormInstance(TFrmCodigosPostalesEditor));
end;

procedure TFrmCodigosPostalesEditor.ADClienteAfterClose(DataSet: TDataSet);
begin
  inherited;
  ADAEAT.Close;
  ADMunicipios.Close;
  ADProvincias.Close;
  ADComunidades.Close;
end;

procedure TFrmCodigosPostalesEditor.ADClienteBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  ADComunidades.Open;
  ADProvincias.Open;
  ADMunicipios.Open;
  ADAEAT.Open;
end;

procedure TFrmCodigosPostalesEditor.UniFormShow(Sender: TObject);
begin
  inherited;
  IF ADCliente.state=dsEdit then begin
     CPOSTAL.ReadOnly:=True;
     CPOSTAL.Color := $00E7FFFF;
  end;
end;

end.
