unit Frm_Provincias_Browse;

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
  TFrmProvinciasBrowse = class(TFrmBrowse)
    CODIGO: TUniEdit;
    UniLabel2: TUniLabel;
    NOMBRE: TUniEdit;
    ADVistaCOMUNIDAD_AUTONOMA: TStringField;
    DSComunidades: TDataSource;
    ADComunidades: TFDQuery;
    ADComunidadesCODIGO: TStringField;
    ADComunidadesNOMBRE: TStringField;
    COMUNIDAD_AUTONOMA: TUniDBLookupComboBox;
    UniLabel3: TUniLabel;
    ADVistaNOMBRE: TStringField;
    ADVistaCODIGO: TIntegerField;
    UniLabel4: TUniLabel;
    procedure UniFormShow(Sender: TObject);
  private
    { Private declarations }
    function FiltroAdicional:String;override;
  public
    { Public declarations }
  end;

function FrmProvinciasBrowse: TFrmProvinciasBrowse;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication, StrUtils;

function FrmProvinciasBrowse: TFrmProvinciasBrowse;
begin
  Result := TFrmProvinciasBrowse(UniMainModule.GetFormInstance(TFrmProvinciasBrowse));
end;

function TFrmProvinciasBrowse.FiltroAdicional: String;
begin
  if ADComunidades.Active=false then
  begin
    ADComunidades.Open;
    COMUNIDAD_AUTONOMA.KeyValue:='--';
  end;

  result:=IfThen(CODIGO.Text='','','PROVINCI.CODIGO='+IntToStr(StrToIntDef(CODIGO.Text,0))+' AND ')+
          IfThen(NOMBRE.Text='','','UPPER(PROVINCI.NOMBRE) CONTAINING '+QuotedStr(UpperCase(NOMBRE.Text))+' AND ')+
          IfThen(VarToStr(COMUNIDAD_AUTONOMA.KeyValue)='--','','COMUNIDA='+QuotedStr(VarToStr(COMUNIDAD_AUTONOMA.KeyValue))+' AND ');
  if EndsText(' AND ',Result) then
    Delete(result,length(Result)-4,5);
end;

procedure TFrmProvinciasBrowse.UniFormShow(Sender: TObject);
begin
  inherited;
  CODIGO.SetFocus;
end;

end.
