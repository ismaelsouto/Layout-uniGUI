unit Frm_GuiaRapida;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, Frm_VisorPDF, uniGUIBaseClasses, uniURLFrame,
  uniCheckBox, uniPanel;

type
  TFrmGuiaRapida = class(TFrmVisorPDF)
    UniPanel1: TUniPanel;
    UniCheckBox1: TUniCheckBox;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function FrmGuiaRapida: TFrmGuiaRapida;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication;

function FrmGuiaRapida: TFrmGuiaRapida;
begin
  Result := TFrmGuiaRapida(UniMainModule.GetFormInstance(TFrmGuiaRapida));
end;

end.
