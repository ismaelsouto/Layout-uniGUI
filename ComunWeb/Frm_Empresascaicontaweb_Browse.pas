unit Frm_Empresascaicontaweb_Browse;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Frm_Browse, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.Comp.DataSet, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.Comp.Client, Data.DB,  uniEdit,
  uniLabel, uniGUIClasses, uniBasicGrid, uniDBGrid, uniToolBar, uniButton,
  uniBitBtn, uniGUIBaseClasses, uniPanel, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt;

type
  TFrmEmpresascaicontaweb = class(TFrmBrowse)
    NIF: TUniEdit;
    UniLabel3: TUniLabel;
    NOMBRE: TUniEdit;
    UniLabel2: TUniLabel;
    UniLabel4: TUniLabel;
    CODIGO: TUniEdit;
    ADVistaCODIGO_EMPRESA: TIntegerField;
    ADVistaNOMBRE_COMPLETO: TStringField;
    ADVistaCIF: TStringField;
  private
    { Private declarations }
    function FiltroAdicional:String;override;
  public
    { Public declarations }
  end;

var
  FrmEmpresascaicontaweb: TFrmEmpresascaicontaweb;

implementation

{$R *.dfm}

uses MainModule, StrUtils;

{ TFrmEmpresascaicontaweb }

function TFrmEmpresascaicontaweb.FiltroAdicional: String;
begin
  result:=IfThen(CODIGO.Text='','','CODIGO_EMPRESA='+IntToStr(StrToIntDef(CODIGO.Text,0))+' AND ')+
          IfThen(NOMBRE.Text='','','UPPER(NOMBRE_COMPLETO) CONTAINING '+QuotedStr(UpperCase(NOMBRE.Text))+' AND ')+
          IfThen(NIF.Text='','','UPPER(CIF) CONTAINING '+QuotedStr(UpperCase(NIF.Text))+' AND ');
  if EndsText(' AND ',Result) then
    Delete(result,length(Result)-4,5);
end;

end.
