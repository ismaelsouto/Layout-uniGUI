unit Frm_DiasVersionDemostracion;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIDialogs,
  uniGUIClasses, uniGUIForm, uniButton, uniGUIBaseClasses, uniLabel;

type
  TFrmDiasVersionDemostracion = class(TUniForm)
    lblQuedan: TUniLabel;
    lblContinuar: TUniLabel;
    UniButton1: TUniButton;
    UniButton2: TUniButton;
    procedure UniFormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
    constructor Crea (AOwner : TComponent; pAplicacion : string; pDias : Integer);
  end;

procedure MostrarDialogoDemo(Aplicacion : string; Dias : Integer; Callback:TUniDialogCallBackAnonProc);

implementation

uses
  uniGUIApplication, ServerModule, StrUtils;

{$R *.dfm}

procedure MostrarDialogoDemo(Aplicacion : string; Dias : Integer; Callback:TUniDialogCallBackAnonProc);
begin
  TFrmDiasVersionDemostracion.Crea(UniApplication, Aplicacion, Dias).ShowModal(Callback);


  if UniServerModule.ExtJSVersion[1]<>'4' then
    UniSession.AddJS('$("div#messagebox-1001_header-title-textEl").html("Confirmar");')
  else
    UniSession.AddJS('$("span#messagebox-1001_header_hd-textEl").html("Confirmar");')
end;


constructor TFrmDiasVersionDemostracion.Crea(AOwner: TComponent;
  pAplicacion: string; pDias: Integer);
begin
  inherited Create(AOwner);

  if pdias<0 then
  begin
    lblQuedan.Caption:='Ha finalizado el periodo de demostración';
    UniButton2.Caption:='Volver a '+UniServerModule.Title;
  end
  Else
    lblQuedan.Text  := Format(lblQuedan.Text, [pDias]);

  lblContinuar.Text  := Format(lblContinuar.Text, [IfThen(SameText(pAplicacion,'PORTALSII'),UniServerModule.Title,pAplicacion)]);
end;

procedure TFrmDiasVersionDemostracion.UniFormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := TCloseAction.caFree;
end;

end.
