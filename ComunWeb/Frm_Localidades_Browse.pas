unit Frm_Localidades_Browse;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, Frm_Browse, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, uniGUIBaseClasses,  FireDAC.Comp.Client,
  Data.DB, FireDAC.Comp.DataSet, uniLabel, uniEdit, uniToolBar, uniButton, uniBitBtn,
  uniSpeedButton, uniPanel, uniBasicGrid, uniDBGrid, uniMultiItem, uniComboBox,
  uniDBComboBox, uniDBLookupComboBox, FireDAC.DatS, FireDAC.DApt;

type
  TFrmLocalidadesBrowse = class(TFrmBrowse)
    ADVistaPROVINCIA: TIntegerField;
    ADVistaNOMBRE_PROVINCIA: TStringField;
    ADVistaLOCALIDAD: TIntegerField;
    ADVistaDESCRIPCION: TStringField;
    DESCRIPCION: TUniEdit;
    UniLabel2: TUniLabel;
    LOCALIDAD: TUniEdit;
    LPROVINCIA: TUniLabel;
    UniLabel3: TUniLabel;
    PROVINCIA: TUniEdit;
    ADVistaCODIGO_MUNICIPIO: TIntegerField;
    procedure UniFormShow(Sender: TObject);
  private
    { Private declarations }
    function FiltroAdicional:String;override;
  public
    { Public declarations }
  end;

function FrmLocalidadesBrowse: TFrmLocalidadesBrowse;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication, StrUtils;

function FrmLocalidadesBrowse: TFrmLocalidadesBrowse;
begin
  Result := TFrmLocalidadesBrowse(UniMainModule.GetFormInstance(TFrmLocalidadesBrowse));
end;

{ TFrmLocalidadesBrowse }

function TFrmLocalidadesBrowse.FiltroAdicional: String;
begin
  result:=IfThen(LOCALIDAD.Text='','','LOCALIDAD='+IntToStr(StrToIntDef(LOCALIDAD.Text,0))+' AND ')+
          IfThen(DESCRIPCION.Text='','','UPPER(DESCRIPCION) CONTAINING '+QuotedStr(UpperCase(DESCRIPCION.Text))+' AND ')+
          IfThen(PROVINCIA.Text='','','UPPER(NOMBRE_PROVINCIA) CONTAINING '+QuotedStr(UpperCase(PROVINCIA.Text))+' AND ');
  if EndsText(' AND ',Result) then
    Delete(result,length(Result)-4,5);
end;

procedure TFrmLocalidadesBrowse.UniFormShow(Sender: TObject);
begin
  inherited;
  LOCALIDAD.SetFocus;
end;

end.
