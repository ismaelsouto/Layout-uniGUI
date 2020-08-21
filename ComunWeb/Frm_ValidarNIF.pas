unit Frm_ValidarNIF;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniBasicGrid, uniDBGrid, uniToolBar,
  uniGUIBaseClasses, uniLabel, Data.DB;

type
  TFrmValidarNIF = class(TUniForm)
    UniToolBar1: TUniToolBar;
    UBAceptar: TUniToolButton;
    UBCancelar: TUniToolButton;
    UniDBGrid1: TUniDBGrid;
    UniLabel1: TUniLabel;
    dsNifs: TDataSource;
    procedure UniFormCreate(Sender: TObject);
    procedure UBAceptarClick(Sender: TObject);
    procedure UBCancelarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses
  uniGUIApplication, MainModule;

{$R *.dfm}


procedure TFrmValidarNIF.UBAceptarClick(Sender: TObject);
begin
  ModalResult:=mrOk;
end;

procedure TFrmValidarNIF.UBCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmValidarNIF.UniFormCreate(Sender: TObject);
begin
  ModalResult:=mrCancel;
  ClientEvents.ExtEvents.Values['window.maximize']:='function window.maximize(sender, eOpts){'+#13#10+
                                                    '  sender.setHeight(sender.getHeight()-'+IntToStr(UniMainModule.DimensionesMax.Top)+');'+#13#10+
                                                    '  sender.setWidth(sender.getWidth()-'+IntToStr(UniMainModule.DimensionesMax.Left)+');'+#13#10+
                                                    '  sender.setPosition('+IntToStr(UniMainModule.DimensionesMax.Left)+','+IntToStr(UniMainModule.DimensionesMax.Top)+');'+#13#10+
                                                    '}';
end;

end.
