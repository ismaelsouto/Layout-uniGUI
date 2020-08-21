unit Frm_EnvioEmail;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniToolBar, uniGUIBaseClasses, uniMemo,
  uniHTMLMemo, uniEdit, uniLabel;

type
  TFrmEnvioEmail = class(TUniForm)
    UniToolBar1: TUniToolBar;
    UBAceptar: TUniToolButton;
    UBCancelar: TUniToolButton;
    UniLabel1: TUniLabel;
    ASUNTO: TUniEdit;
    UniLabel2: TUniLabel;
    MENSAJE: TUniHTMLMemo;
    procedure UniFormCreate(Sender: TObject);
    procedure UBAceptarClick(Sender: TObject);
    procedure UniFormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses
  uniGUIApplication, Funciones;

{$R *.dfm}


procedure TFrmEnvioEmail.UBAceptarClick(Sender: TObject);
begin
  ModalResult:=mrOk;
end;

procedure TFrmEnvioEmail.UniFormCreate(Sender: TObject);
begin
  ModalResult:=mrCancel;
  MonitorizarTeclas(Self,[VK_RETURN,VK_ESCAPE],False);
end;

procedure TFrmEnvioEmail.UniFormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_ESCAPE:ModalResult:=mrCancel;
    VK_RETURN:UBAceptarClick(nil);
  end;
end;

end.
