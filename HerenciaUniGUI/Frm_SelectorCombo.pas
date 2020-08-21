unit Frm_SelectorCombo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, DB, uniMultiItem, uniComboBox, uniDBComboBox,
  uniDBLookupComboBox, uniToolBar, uniGUIBaseClasses, Funciones;

type
  TProcedimientoSeleccion=reference to procedure(Resultado:Integer;KeyValue:Variant);
  TFrmSelectorCombo = class(TUniForm)
    UniToolBar1: TUniToolBar;
    UBAceptar: TUniToolButton;
    UBCancelar: TUniToolButton;
    SELECTOR: TUniDBLookupComboBox;
    DSSelector: TDataSource;
    procedure UBAceptarClick(Sender: TObject);
    procedure UBCancelarClick(Sender: TObject);
    procedure UniFormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure UniFormClose(Sender: TObject; var Action: TCloseAction);
    procedure UniFormCreate(Sender: TObject);
  private
    { Private declarations }
    FProcedimientoSeleccion:TProcedimientoSeleccion;
    FResultado:Integer;
  public
    { Public declarations }
    constructor Crear(Caption:String;Dataset:TDataSet;KeyField,ListField:String;ProcedimientoSeleccion:TProcedimientoSeleccion=nil;MensajeMascara:String='');
  end;

implementation

uses
  uniGUIApplication;

{$R *.dfm}


constructor TFrmSelectorCombo.Crear(Caption: String; Dataset: TDataSet;
  KeyField:String; ListField: String; ProcedimientoSeleccion: TProcedimientoSeleccion;MensajeMascara:String);
begin
  inherited create(uniGUIApplication.UniApplication);
  Self.Caption:=Caption;
  DSSelector.DataSet:=Dataset;
  SELECTOR.KeyField:=KeyField;
  SELECTOR.ListField:=ListField;
  SELECTOR.KeyValue:=DSSelector.DataSet.FieldByName(KeyField).Value;
  FProcedimientoSeleccion:=ProcedimientoSeleccion;
  UBAceptar.ScreenMask.Enabled:=MensajeMascara<>'';
  UBAceptar.ScreenMask.Message:=MensajeMascara;
end;

procedure TFrmSelectorCombo.UBAceptarClick(Sender: TObject);
begin
  FResultado:=mrOk;
  Close;
end;

procedure TFrmSelectorCombo.UBCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmSelectorCombo.UniFormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if Assigned(FProcedimientoSeleccion) then FProcedimientoSeleccion(FResultado,SELECTOR.KeyValue);
  DSSelector.DataSet.Free;
  Action:=caFree;
end;

procedure TFrmSelectorCombo.UniFormCreate(Sender: TObject);
begin
  MonitorizarTeclas(Self,[VK_ESCAPE,VK_RETURN],False);
end;

procedure TFrmSelectorCombo.UniFormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_RETURN:UBAceptarClick(UBAceptar);
    VK_ESCAPE:UBCancelarClick(UBCancelar);
  end;
end;

end.


