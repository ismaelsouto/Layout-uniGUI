unit Frm_Comunidades_Browse;

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
  TFrmComunidadesBrowse = class(TFrmBrowse)
    ADVistaCODIGO: TStringField;
    ADVistaNOMBRE: TStringField;
    UniLabel2: TUniLabel;
    NOMBRE: TUniEdit;
    CODIGO: TUniEdit;
    UniLabel3: TUniLabel;
    procedure UniFormShow(Sender: TObject);
  private
    { Private declarations }
    function FiltroAdicional:String;override;
  public
    { Public declarations }
  end;

function FrmComunidadesBrowse: TFrmComunidadesBrowse;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication, StrUtils;

function FrmComunidadesBrowse: TFrmComunidadesBrowse;
begin
  Result := TFrmComunidadesBrowse(UniMainModule.GetFormInstance(TFrmComunidadesBrowse));
end;

{ TFrmComunidadesBrowse }

function TFrmComunidadesBrowse.FiltroAdicional: String;
begin
  result:=IfThen(CODIGO.Text='','','CODIGO='+IntToStr(StrToIntDef(CODIGO.Text,0))+' AND ')+
          IfThen(NOMBRE.Text='','','UPPER(NOMBRE) CONTAINING '+QuotedStr(UpperCase(NOMBRE.Text))+' AND ');
  if EndsText(' AND ',Result) then
    Delete(result,length(Result)-4,5);
end;

procedure TFrmComunidadesBrowse.UniFormShow(Sender: TObject);
begin
  inherited;
  CODIGO.SetFocus;
end;

end.
