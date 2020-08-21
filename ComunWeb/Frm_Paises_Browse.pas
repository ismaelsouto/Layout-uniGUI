unit Frm_Paises_Browse;

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
  TFrmPaisesBrowse = class(TFrmBrowse)
    ADVistaCODIGO: TIntegerField;
    ADVistaNOMBRE: TStringField;
    ADVistaINTRACOM: TStringField;
    ADVistaEXTRANJE: TStringField;
    ADVistaPARAISO: TStringField;
    ADVistaCLAVE: TStringField;
    ADVistaDIGITOS: TStringField;
    ADVistaSOLO_DIGITOS: TStringField;
    CODIGO: TUniEdit;
    UniLabel2: TUniLabel;
    NOMBRE: TUniEdit;
    UniLabel3: TUniLabel;
    UniLabel1: TUniLabel;
    CLAVE: TUniEdit;
    ADVistaTGSS: TIntegerField;
  private
    { Private declarations }
    function FiltroAdicional:String;override;
  public
    { Public declarations }
  end;

function FrmPaisesBrowse: TFrmPaisesBrowse;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication, StrUtils;

function FrmPaisesBrowse: TFrmPaisesBrowse;
begin
  Result := TFrmPaisesBrowse(UniMainModule.GetFormInstance(TFrmPaisesBrowse));
end;

{ TFrmBrowse1 }

function TFrmPaisesBrowse.FiltroAdicional: String;
begin
  result:=IfThen(CLAVE.Text='','','UPPER(CLAVE) CONTAINING '+QuotedStr(UpperCase(CLAVE.Text))+' AND ')+
          IfThen(CODIGO.Text='','','CODIGO='+IntToStr(StrToIntDef(CODIGO.Text,0))+' AND ')+
          IfThen(NOMBRE.Text='','','UPPER(REPLACE(NOMBRE,''ñ'',''Ñ'')) CONTAINING '+QuotedStr(ReplaceText(UpperCase(NOMBRE.Text),'ñ','Ñ'))+' AND ');
  if EndsText(' AND ',Result) then
    Delete(result,length(Result)-4,5);
end;

end.
