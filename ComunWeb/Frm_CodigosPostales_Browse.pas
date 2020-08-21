unit Frm_CodigosPostales_Browse;

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
  TFrmCodigosPostalesBrowse = class(TFrmBrowse)
    ADVistaCPOSTAL: TIntegerField;
    ADVistaNOMBRE_PROVINCIA: TStringField;
    ADVistaNOMBRE_LOCALIDAD: TStringField;
    CPOSTAL: TUniEdit;
    UniLabel2: TUniLabel;
    NOMBRE_PROVINCIA: TUniEdit;
    UniLabel3: TUniLabel;
    NOMBRE_LOCALIDAD: TUniEdit;
    UniLabel4: TUniLabel;
    procedure UniFormShow(Sender: TObject);
  private
    { Private declarations }
    function FiltroAdicional:String;override;
  public
    { Public declarations }
  end;

function FrmCodigosPostalesBrowse: TFrmCodigosPostalesBrowse;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication, StrUtils;

function FrmCodigosPostalesBrowse: TFrmCodigosPostalesBrowse;
begin
  Result := TFrmCodigosPostalesBrowse(UniMainModule.GetFormInstance(TFrmCodigosPostalesBrowse));
end;

function TFrmCodigosPostalesBrowse.FiltroAdicional: String;
begin
  result:=IfThen(CPOSTAL.Text='','','CPOSTAL CONTAINING '+QuotedStr(UpperCase(CPOSTAL.Text))+' AND ')+
          IfThen(NOMBRE_PROVINCIA.Text='','','UPPER(NOMBRE_PROVINCIA) CONTAINING '+QuotedStr(UpperCase(NOMBRE_PROVINCIA.Text))+' AND ')+
          IfThen(NOMBRE_LOCALIDAD.Text='','','UPPER(NOMBRE_LOCALIDAD) CONTAINING '+QuotedStr(UpperCase(NOMBRE_LOCALIDAD.Text))+' AND ');
  if EndsText(' AND ',Result) then
    Delete(result,length(Result)-4,5);
end;

procedure TFrmCodigosPostalesBrowse.UniFormShow(Sender: TObject);
begin
  inherited;
  CPOSTAL.SetFocus;
end;

end.
