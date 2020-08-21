unit Frm_Paises_Editor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, Frm_Dialogo, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, uniGUIBaseClasses,  Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, uniPanel, uniToolBar, uniLabel, uniEdit,
  uniDBEdit, uniCheckBox, uniDBCheckBox, uniButton;

type
  TFrmPaisesEditor = class(TFrmDialogo)
    Label1: TUniLabel;
    Label2: TUniLabel;
    Label3: TUniLabel;
    INTRACOM: TUniDBCheckBox;
    EXTRANJE: TUniDBCheckBox;
    PARAISO: TUniDBCheckBox;
    CODIGO: TUniDBEdit;
    NOMBRE: TUniDBEdit;
    CLAVE: TUniDBEdit;
    ADClienteCODIGO: TIntegerField;
    ADClienteNOMBRE: TStringField;
    ADClienteINTRACOM: TStringField;
    ADClienteEXTRANJE: TStringField;
    ADClientePARAISO: TStringField;
    ADClienteCLAVE: TStringField;
    ADClienteDIGITOS: TStringField;
    ADClienteSOLO_DIGITOS: TStringField;
    UniLabel1: TUniLabel;
    UniDBEdit1: TUniDBEdit;
    ADClienteTGSS: TIntegerField;
    procedure UniFormShow(Sender: TObject);
    procedure ADClienteNewRecord(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function FrmPaisesEditor: TFrmPaisesEditor;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication;

function FrmPaisesEditor: TFrmPaisesEditor;
begin
  Result := TFrmPaisesEditor(UniMainModule.GetFormInstance(TFrmPaisesEditor));
end;

procedure TFrmPaisesEditor.ADClienteNewRecord(DataSet: TDataSet);
begin
  inherited;
  ADClienteINTRACOM.AsString := 'NO';
  ADClienteEXTRANJE.AsString := 'NO';
  ADClientePARAISO.AsString  := 'NO';
end;

procedure TFrmPaisesEditor.UniFormShow(Sender: TObject);
begin
  inherited;
  IF ADCliente.state=dsEdit then begin
     CODIGO.ReadOnly:=True;
     CODIGO.Color := $00E7FFFF;
  end;
end;

end.
