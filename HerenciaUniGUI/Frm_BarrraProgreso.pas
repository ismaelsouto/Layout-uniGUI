unit Frm_BarrraProgreso;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniGUIBaseClasses, uniProgressBar, uniLabel;

type
  TFrmBarrraProgreso = class(TUniForm)
    UniProgressBar: TUniProgressBar;
    ULInfo: TUniLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses
  uniGUIApplication;

{$R *.dfm}


end.
