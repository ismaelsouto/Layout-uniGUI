unit Frm_Siglas_Browse;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, Frm_Browse, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, uniGUIBaseClasses,  FireDAC.Comp.Client,
  Data.DB, FireDAC.Comp.DataSet, uniLabel, uniEdit, uniToolBar, uniButton, uniBitBtn,
  uniSpeedButton, uniPanel, uniBasicGrid, uniDBGrid, FireDAC.DatS, FireDAC.DApt;

type
  TFrmSiglasBrowse = class(TFrmBrowse)
    ADVistaCODIGO: TStringField;
    ADVistaNOMBRE: TStringField;
    CODIGO: TUniEdit;
    UniLabel2: TUniLabel;
    NOMBRE: TUniEdit;
    UniLabel3: TUniLabel;
    procedure UniFormShow(Sender: TObject);
  private
    { Private declarations }
    function FiltroAdicional:String;override;
  public
    { Public declarations }
  end;

function FrmSiglasBrowse: TFrmSiglasBrowse;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication, StrUtils;

function FrmSiglasBrowse: TFrmSiglasBrowse;
begin
  Result := TFrmSiglasBrowse(UniMainModule.GetFormInstance(TFrmSiglasBrowse));
end;

{ TFrmSiglasBrowse }

function TFrmSiglasBrowse.FiltroAdicional: String;
begin
  result:=IfThen(CODIGO.Text='','','UPPER(CODIGO) CONTAINING '+QuotedStr(UpperCase(CODIGO.Text))+' AND ')+
          IfThen(NOMBRE.Text='','','UPPER(NOMBRE) CONTAINING '+QuotedStr(UpperCase(NOMBRE.Text))+' AND ');
  if EndsText(' AND ',Result) then
    Delete(result,length(Result)-4,5);
end;

procedure TFrmSiglasBrowse.UniFormShow(Sender: TObject);
begin
  inherited;
  CODIGO.SetFocus;
end;

end.
