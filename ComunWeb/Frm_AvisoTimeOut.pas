{
Puertos activos hasta ahora :
CAICONTA 3000
CAIFIS   3001
CAIFAC   3002
CAILAB   3003
}

unit Frm_AvisoTimeOut;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniLabel, uniPanel, uniGUIBaseClasses, uniTimer,
  uniButton, FireDAC.Comp.Client;

type
  TFrmAvisoTimeOut = class(TUniForm)
    UniButton1: TUniButton;
    UniTimer1: TUniTimer;
    UniLabel1: TUniLabel;
    procedure UniTimer1Timer(Sender: TObject);
    procedure UniFormCreate(Sender: TObject);
    procedure UniButton1Click(Sender: TObject);
  private
    { Private declarations }
    procedure ActualizaLabel;
  public
    { Public declarations }
    Conexion:TFDConnection;
    Restantes:Integer;
  end;

implementation

uses
  uniGUIApplication, StrUtils;

{$R *.dfm}


procedure TFrmAvisoTimeOut.ActualizaLabel;
begin
  UniLabel1.Caption:='La sesión se cerrará en '+
                     IfThen(Restantes>=60,
                            IfThen(Restantes div 60<10,'0','')+IntToStr(Restantes div 60)+':'+
                            IfThen(Restantes mod 60<10,'0','')+IntToStr(Restantes mod 60)+' minutos',
                            IntToStr(Restantes)+' segundos');
end;

procedure TFrmAvisoTimeOut.UniButton1Click(Sender: TObject);
begin
  Conexion.ExecSQL('EXECUTE BLOCK AS BEGIN END');
  Close;
end;

procedure TFrmAvisoTimeOut.UniFormCreate(Sender: TObject);
begin
  Restantes:=60*5;
  ActualizaLabel;
  UniTimer1.Enabled:=True;
end;

procedure TFrmAvisoTimeOut.UniTimer1Timer(Sender: TObject);
begin
  if Restantes=0 then
    UniApplication.Terminate('Ha superado el tiempo de inactividad. Se cerró la sesión')
  else begin
    Dec(Restantes);
    ActualizaLabel;
  end;
end;

end.
