unit Frm_ControlGenerico;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniGUIBaseClasses, uniGenericControl, Funciones;

type
  TFrmControlGenerico = class(TUniForm)
    UniGenericControl1: TUniGenericControl;
    procedure UniFormCreate(Sender: TObject);
    procedure UniFormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
    constructor Create(Objeto:String);
  end;

implementation

uses
  uniGUIApplication;

{$R *.dfm}


constructor TFrmControlGenerico.Create(Objeto: String);
begin
  inherited Create(uniGUIApplication.UniApplication);
  UniGenericControl1.ClientEvents.ExtEvents.Values['beforerender']:='function beforerender(sender, eOpts){sender.update('''+Objeto+''')}';
end;


procedure TFrmControlGenerico.UniFormCreate(Sender: TObject);
begin
  MonitorizarTeclas(Self,[VK_ESCAPE],False);
end;

procedure TFrmControlGenerico.UniFormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_ESCAPE then Close;
end;

end.
