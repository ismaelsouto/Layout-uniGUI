unit Frm_SelectorRadioGroup;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniRadioGroup, uniToolBar, uniGUIBaseClasses;

type
  TFrmSelectorRadioGroup = class(TUniForm)
    UniToolBar1: TUniToolBar;
    UBAceptar: TUniToolButton;
    UBCancelar: TUniToolButton;
    UniRadioGroup1: TUniRadioGroup;
    procedure UniFormCreate(Sender: TObject);
    procedure UBCancelarClick(Sender: TObject);
    procedure UBAceptarClick(Sender: TObject);
    procedure UniFormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
    constructor Crear(Caption:String;Opciones:Array of String;Alto,Ancho:Integer);
  end;

implementation

uses
  uniGUIApplication, Funciones;

{$R *.dfm}


constructor TFrmSelectorRadioGroup.Crear(Caption: String; Opciones: array of String;Alto,Ancho:Integer);
var
  i:Integer;
begin
  inherited Create(uniGUIApplication.UniApplication);
  ModalResult:=mrCancel;
  for i:=0 to Length(Opciones)-1 do
    UniRadioGroup1.Items.Add(Opciones[i]);
  Height:=Alto;
  Width:=Ancho;
  Self.Caption:=Caption;
end;

procedure TFrmSelectorRadioGroup.UBAceptarClick(Sender: TObject);
begin
  ModalResult:=mrOk;
end;

procedure TFrmSelectorRadioGroup.UBCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmSelectorRadioGroup.UniFormCreate(Sender: TObject);
begin
  MonitorizarTeclas(Self,[VK_ESCAPE,VK_RETURN],False);
end;

procedure TFrmSelectorRadioGroup.UniFormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_RETURN:UBAceptarClick(nil);
    VK_ESCAPE:UBCancelarClick(nil);
  end;
end;

end.
