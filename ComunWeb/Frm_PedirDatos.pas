unit Frm_PedirDatos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniDBEdit, uniEdit, uniLabel, uniToolBar,
  uniGUIBaseClasses, uniImageList,db, uniRadioButton,UniguiDialogs, uniPanel,
  uniCheckBox, Funciones, Frm_VisorHTML, uniCanvas, uniButton, uniBitBtn,
  ServerModule,strutils;

type
  TFrmPedirDatos = class(TUniForm)
    UTBBotonera: TUniToolBar;
    UBAceptar: TUniToolButton;
    UBCancelar: TUniToolButton;
    UniLabel1: TUniLabel;
    UniLabel2: TUniLabel;
    UniLabel3: TUniLabel;
    UniLabel4: TUniLabel;
    UniLabel5: TUniLabel;
    UniLabel6: TUniLabel;
    Nombre: TUniDBEdit;
    NIF: TUniDBEdit;
    Cargo: TUniDBEdit;
    DataSource1: TDataSource;
    procedure UBCancelarClick(Sender: TObject);
    procedure UniFormCreate(Sender: TObject);
    procedure UniFormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure UBAceptarClick(Sender: TObject);
  private
    Fcampo_a_cambiar: string;
    procedure Setcampo_a_cambiar(const Value: string);
    { Private declarations }
  public
    property campo_a_cambiar: string read Fcampo_a_cambiar write Setcampo_a_cambiar;
  end;

implementation

uses
  uniGUIApplication, MainModule, Frm_Firma_contratos;

{$R *.dfm}


procedure TFrmPedirDatos.Setcampo_a_cambiar(const Value: string);
begin
  Fcampo_a_cambiar := Value;
end;

procedure TFrmPedirDatos.UBAceptarClick(Sender: TObject);

begin
  // Comprueba que los 3 edits tengan valor y nif correcto
  if (trim(nombre.Text)<>'') and
     (trim(NIF.Text)<>'') and
     (trim(CARGO.Text)<>'') then
  begin
    ModalResult:=mrOk;
  end
  else showMessage('Debe rellenar correctamente los datos antes de continuar');
end;

procedure TFrmPedirDatos.UBCancelarClick(Sender: TObject);
begin
  close;
end;

procedure TFrmPedirDatos.UniFormCreate(Sender: TObject);
begin
  Monitorizarteclas(Self,[VK_RETURN,VK_ESCAPE],False);
  ModalResult:=mrCancel;
end;

procedure TFrmPedirDatos.UniFormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_ESCAPE:UBCancelarClick(nil);
    VK_RETURN:UBAceptarClick(nil);
  end;
end;

end.



