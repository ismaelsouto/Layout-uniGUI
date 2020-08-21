unit Frm_VisorHTML;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniGUIBaseClasses, uniPanel, uniURLFrame;

type
  TFrmVisorHTML = class(TUniForm)
    UniURLFrame1: TUniURLFrame;
    procedure UniFormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
    constructor Crear(AOwner:TComponent;URL,Titulo:String);
  end;

implementation

uses
  uniGUIApplication;

{$R *.dfm}


{ TFrmVisorHTML }

constructor TFrmVisorHTML.Crear(AOwner: TComponent; URL,Titulo: String);
begin
  inherited Create(AOwner);
  UniURLFrame1.URL:=URL;
  Caption:=Titulo;
end;

procedure TFrmVisorHTML.UniFormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_ESCAPE then Close;
end;

end.
