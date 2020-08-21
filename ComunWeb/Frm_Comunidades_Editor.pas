unit Frm_Comunidades_Editor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, Frm_Dialogo, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, uniGUIBaseClasses,  Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, uniPanel, uniToolBar, uniEdit, uniDBEdit,
  uniLabel, uniButton, FireDAC.DatS, FireDAC.DApt;

type
  TFrmComunidadesEditor = class(TFrmDialogo)
    Label1: TUniLabel;
    Label2: TUniLabel;
    CODIGO: TUniDBEdit;
    NOMBRE: TUniDBEdit;
    ADClienteCODIGO: TStringField;
    ADClienteNOMBRE: TStringField;
    procedure UniFormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function FrmPlantillasECPNEditor: TFrmComunidadesEditor;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication;

function FrmPlantillasECPNEditor: TFrmComunidadesEditor;
begin
  Result := TFrmComunidadesEditor(UniMainModule.GetFormInstance(TFrmComunidadesEditor));
end;

procedure TFrmComunidadesEditor.UniFormShow(Sender: TObject);
begin
  inherited;
  IF ADCliente.state=dsedit then begin
     CODIGO.ReadOnly:=True;
     CODIGO.Color := $00E7FFFF;
  end;
end;

end.
