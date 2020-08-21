unit Frm_Provincias_Editor;

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
  TFrmProvinciasEditor = class(TFrmDialogo)
    Label1: TUniLabel;
    CODIGO: TUniDBEdit;
    Label2: TUniLabel;
    NOMBRE: TUniDBEdit;
    COMUNIDA: TUniDBLookupComboBox;
    UniLabel1: TUniLabel;
    ADComunidades: TFDQuery;
    DSComunidades: TDataSource;
    ADComunidadesCODIGO: TStringField;
    ADComunidadesNOMBRE: TStringField;
    procedure ADClienteBeforeOpen(DataSet: TDataSet);
    procedure ADClienteAfterClose(DataSet: TDataSet);
    procedure UniFormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function FrmProvinciasEditor: TFrmProvinciasEditor;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication;

function FrmProvinciasEditor: TFrmProvinciasEditor;
begin
  Result := TFrmProvinciasEditor(UniMainModule.GetFormInstance(TFrmProvinciasEditor));
end;

procedure TFrmProvinciasEditor.ADClienteAfterClose(DataSet: TDataSet);
begin
  inherited;
  ADComunidades.Close;
end;

procedure TFrmProvinciasEditor.ADClienteBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  ADComunidades.Open;
end;


procedure TFrmProvinciasEditor.UniFormShow(Sender: TObject);
begin
  inherited;
  IF ADCliente.state=dsEdit then begin
     CODIGO.ReadOnly:=True;
     CODIGO.Color := $00E7FFFF;
  end;
end;

end.
