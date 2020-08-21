unit Frm_PideCadena;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  uniToolBar, uniGUIBaseClasses, uniGUIClasses, uniEdit, uniLabel, UniGuiForm,
  Vcl.Controls, Vcl.Forms;

type
  TFrmPideCadena = class(TUniForm)
    UniToolBar1: TUniToolBar;
    UBSalir: TUniToolButton;
    ULTexto: TUniLabel;
    VALOR: TUniEdit;
    procedure UBSalirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure UniFormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
    constructor Crear(Titulo,Texto:String;Tamano:Integer);
  end;

implementation

uses uniGUIApplication, Funciones;

{$R *.dfm}

constructor TFrmPideCadena.Crear(Titulo, Texto: String; Tamano: Integer);
begin
  inherited Create(uniGUIApplication.UniApplication);
  Caption:=Titulo;
  ULTexto.Caption:=Texto;
  VALOR.MaxLength:=Tamano;
end;

procedure TFrmPideCadena.FormCreate(Sender: TObject);
begin
  Funciones.MonitorizarTeclas(Self,[VK_ESCAPE,VK_RETURN],False);
end;

procedure TFrmPideCadena.UBSalirClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmPideCadena.UniFormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key in [VK_RETURN,VK_ESCAPE] then CLose;
end;

end.
