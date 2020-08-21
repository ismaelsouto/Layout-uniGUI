unit Frm_Mensaje;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniMemo, uniToolBar, uniGUIBaseClasses, Funciones,
  uniHTMLMemo, uniPanel;

type
  TFrmMensaje = class(TUniForm)
    UniToolBar1: TUniToolBar;
    UBSalir: TUniToolButton;
    UniMemoMensaje: TUniMemo;
    UniHTMLMemo1: TUniHTMLMemo;
    procedure UBSalirClick(Sender: TObject);
    procedure UniFormCreate(Sender: TObject);
    procedure UniFormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure UniFormClose(Sender: TObject; var Action: TCloseAction);
    procedure UniFormShow(Sender: TObject);
  private
    { Private declarations }
    FCaption:string;
  public
    { Public declarations }
    constructor Crear(Mensaje:String;qCaption:String='Mensaje';HTML:Boolean=False);
  end;

implementation

uses
  uniGUIApplication;

{$R *.dfm}


constructor TFrmMensaje.Crear(Mensaje:String;qCaption:String='Mensaje';HTML:Boolean=False);
begin
  inherited Create(uniGUIApplication.UniApplication);
  FCaption:=qCaption;
  if HTML then
  begin
    UniMemoMensaje.Visible:=False;
    UniHTMLMemo1.Lines.Text:=Mensaje;
  end
  else begin
    UniHTMLMemo1.Visible:=False;
    UniMemoMensaje.Lines.Text:=Mensaje;
  end;
end;

procedure TFrmMensaje.UBSalirClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmMensaje.UniFormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:=caFree;
end;

procedure TFrmMensaje.UniFormCreate(Sender: TObject);
begin
  MonitorizarTeclas(Self,[VK_ESCAPE],False);
end;

procedure TFrmMensaje.UniFormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_ESCAPE then
    Self.Close;
end;

procedure TFrmMensaje.UniFormShow(Sender: TObject);
begin
  Self.Caption:=fCaption;
end;

end.
