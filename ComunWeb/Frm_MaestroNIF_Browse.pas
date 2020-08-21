unit Frm_MaestroNIF_Browse;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, Frm_Browse, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.Comp.Client, Data.DB, FireDAC.Comp.DataSet, uniEdit,
  uniLabel, uniBasicGrid, uniDBGrid, uniToolBar, uniButton, uniBitBtn,
  uniGUIBaseClasses, uniPanel, uniDBEdit, Funciones;

type
  TFrmMaestroNIFBrowse = class(TFrmBrowse)
    ADVistaINTERNO: TIntegerField;
    ADVistaPAIS: TStringField;
    ADVistaNIF: TStringField;
    ADVistaNOMBRE_1: TStringField;
    ADCamposFiltroNIF: TStringField;
    ADCamposFiltroNOMBRE_1: TStringField;
    UniLabel1: TUniLabel;
    NIF: TUniDBEdit;
    UniLabel2: TUniLabel;
    NOMBRE: TUniDBEdit;
    UBActualizaNIF: TUniButton;
    procedure UBActualizaNIFClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    ActualizaNIF:TProcedimiento;
  end;

function FrmMaestroNIFBrowse: TFrmMaestroNIFBrowse;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication;

function FrmMaestroNIFBrowse: TFrmMaestroNIFBrowse;
begin
  Result := TFrmMaestroNIFBrowse(UniMainModule.GetFormInstance(TFrmMaestroNIFBrowse));
end;

procedure TFrmMaestroNIFBrowse.UBActualizaNIFClick(Sender: TObject);
begin
  inherited;
  ActualizaNIF;
  
end;

end.
