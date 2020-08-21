unit Frm_AceptacionContrato;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniLabel, uniToolBar, uniGUIBaseClasses,
  uniCheckBox;

type
  TFrmAceptacionContrato = class(TUniForm)
    UCBAceptar: TUniCheckBox;
    UniToolBar1: TUniToolBar;
    UBSalir: TUniToolButton;
    ULLeer: TUniLabel;
    procedure UBSalirClick(Sender: TObject);
    procedure ULLeerClick(Sender: TObject);
    procedure UniFormClose(Sender: TObject; var Action: TCloseAction);
    procedure UniFormCreate(Sender: TObject);
  private
    { Private declarations }
    FIDContrato:Integer;
  public
    { Public declarations }
    constructor Crear(IDContrato:Integer);
  end;

function FrmAceptacionContrato: TFrmAceptacionContrato;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication, Funciones, Frm_VisorPDF;

function FrmAceptacionContrato: TFrmAceptacionContrato;
begin
  Result := TFrmAceptacionContrato(UniMainModule.GetFormInstance(TFrmAceptacionContrato));
end;

procedure TFrmAceptacionContrato.ULLeerClick(Sender: TObject);
begin
  TFrmVisorPDF.Create(UniApplication).Mostrar('https://www.portalsii.es/contratos/'+IntToStr(FIDContrato)+'.pdf');
end;

procedure TFrmAceptacionContrato.UniFormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if UCBAceptar.Checked then
    ModalResult:=mrOk
  else
    ModalResult:=mrCancel;
  Action:=caFree;
end;

procedure TFrmAceptacionContrato.UniFormCreate(Sender: TObject);
begin
  ModalResult:=mrCancel;
end;

constructor TFrmAceptacionContrato.Crear(IDContrato: Integer);
begin
  inherited Create(uniGUIApplication.UniApplication);
  FIDContrato:=IDContrato;
end;

procedure TFrmAceptacionContrato.UBSalirClick(Sender: TObject);
begin
  Close;
end;

end.
