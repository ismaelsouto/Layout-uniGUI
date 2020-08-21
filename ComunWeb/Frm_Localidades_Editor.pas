unit Frm_Localidades_Editor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, Frm_Dialogo, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, uniGUIBaseClasses,  Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, uniPanel, uniToolBar, uniMultiItem,
  uniComboBox, uniDBComboBox, uniDBLookupComboBox, uniEdit, uniDBEdit, uniLabel,
  uniButton, FireDAC.DatS, FireDAC.DApt;

type
  TFrmLocalidadesEditor = class(TFrmDialogo)
    ADClienteLOCALIDAD: TIntegerField;
    ADClientePROVINCIA: TIntegerField;
    ADClienteDESCRIPCION: TStringField;
    Label1: TUniLabel;
    Label2: TUniLabel;
    LOCALIDAD: TUniDBEdit;
    DESCRIPCION: TUniDBEdit;
    UniLabel1: TUniLabel;
    COMUNIDA: TUniDBLookupComboBox;
    ADProvincias: TFDQuery;
    DSProvincias: TDataSource;
    ADProvinciasNOMBRE: TStringField;
    ADProvinciasCODIGO: TStringField;
    procedure ADClienteAfterClose(DataSet: TDataSet);
    procedure UniFormShow(Sender: TObject);
    procedure ADProvinciasNOMBREGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure ADClienteBeforeOpen(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function FrmLocalidadesEditor: TFrmLocalidadesEditor;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication;

function FrmLocalidadesEditor: TFrmLocalidadesEditor;
begin
  Result := TFrmLocalidadesEditor(UniMainModule.GetFormInstance(TFrmLocalidadesEditor));
end;

procedure TFrmLocalidadesEditor.ADClienteAfterClose(DataSet: TDataSet);
begin
  inherited;
  ADProvincias.Close;
end;

procedure TFrmLocalidadesEditor.ADClienteBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  ADProvincias.Open;
end;

procedure TFrmLocalidadesEditor.ADProvinciasNOMBREGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  inherited;
  Text:=Sender.AsString+' ('+Sender.DataSet.FieldByName('CODIGO').AsString+')';
end;

procedure TFrmLocalidadesEditor.UniFormShow(Sender: TObject);
begin
  inherited;
  IF ADCliente.state=dsEdit then begin
     LOCALIDAD.ReadOnly:=True;
     LOCALIDAD.Color := $00E7FFFF;
  end;
end;

end.
