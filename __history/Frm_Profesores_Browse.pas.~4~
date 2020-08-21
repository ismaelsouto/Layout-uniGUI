unit Frm_Profesores_Browse;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, Frm_Browse, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.Client,
  Data.DB, FireDAC.Comp.DataSet, uniEdit, uniLabel, uniBasicGrid, uniDBGrid,
  uniToolBar, uniButton, uniBitBtn, uniGUIBaseClasses, uniPanel, uniDBEdit;

type
  TFrmProfesoresBrowse = class(TFrmBrowse)
    ADVistaID_PROFESOR: TIntegerField;
    ADVistaNOMBRE_PROFESOR: TStringField;
    ADVistaAPELLIDO_PROFESOR: TStringField;
    ADCamposFiltroNOMBRE_PROFESOR: TStringField;
    ADCamposFiltroAPELLIDO_PROFESOR: TStringField;
    UniDBEdit1: TUniDBEdit;
    UniDBEdit2: TUniDBEdit;
    UniLabel1: TUniLabel;
    UniLabel2: TUniLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function FrmProfesoresBrowse: TFrmProfesoresBrowse;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication;

function FrmProfesoresBrowse: TFrmProfesoresBrowse;
begin
  Result := TFrmProfesoresBrowse(UniMainModule.GetFormInstance(TFrmProfesoresBrowse));
end;

end.
