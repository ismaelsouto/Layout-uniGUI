unit Frm_CNAE_Browse;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, Frm_Browse, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.Comp.Client, Data.DB, FireDAC.Comp.DataSet, uniEdit,
  uniLabel, uniBasicGrid, uniDBGrid, uniToolBar, uniButton, uniBitBtn,
  uniGUIBaseClasses, uniPanel, Funciones, FireDAC.DatS, FireDAC.DApt;

type
  TFrmCNAEBrowse = class(TFrmBrowse)
    ADVistaORDEN: TStringField;
    ADVistaNIVEL: TIntegerField;
    ADVistaCNAE: TStringField;
    ADVistaNOMBRE: TStringField;
    UniLabel1: TUniLabel;
    CNAE: TUniEdit;
    UniLabel2: TUniLabel;
    NOMBRE: TUniEdit;
    procedure ADVistaNOMBREGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
  private
    { Private declarations }
    function FiltroAdicional:String;override;
    procedure Eliminar;Override;
    function PuedeEliminar:Boolean;Override;
  public
    { Public declarations }
  end;

function FrmCNAEBrowse: TFrmCNAEBrowse;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication, StrUtils, uniGUIDialogs;

function FrmCNAEBrowse: TFrmCNAEBrowse;
begin
  Result := TFrmCNAEBrowse(UniMainModule.GetFormInstance(TFrmCNAEBrowse));
end;

procedure TFrmCNAEBrowse.ADVistaNOMBREGetText(Sender: TField; var Text: string;
  DisplayText: Boolean);
begin
  inherited;
  Text:=IfThen(ADVistaNIVEL.AsInteger=2,DupeString('&nbsp;',2),
        IfThen(ADVistaNIVEL.AsInteger=3,DupeString('&nbsp;',4),
        IfThen(ADVistaNIVEL.AsInteger=5,DupeString('&nbsp;',6),'')))+Sender.AsString;
end;

procedure TFrmCNAEBrowse.Eliminar;
var
  Aux:Integer;
begin
  Aux:=TFDQuery(UniDBGrid1.DataSource.DataSet).RecNo;
  try
    UniMainModule.ADConexionGeneral.ExecSQL('DELETE FROM CNAE_NIVEL_'+IntToStr(ADVistaNIVEL.AsInteger)+' WHERE CNAE='+QuotedStr(ADVistaCNAE.AsString));
    TFDQuery(UniDBGrid1.DataSource.DataSet).Close;
    TFDQuery(UniDBGrid1.DataSource.DataSet).Open;
    TOTAL_REGISTROS.Value:=TOTAL_REGISTROS.Value-1;
  finally
    TFDQuery(UniDBGrid1.DataSource.DataSet).MoveBy(Aux-TFDQuery(UniDBGrid1.DataSource.DataSet).RecNo);
  end;
end;

function TFrmCNAEBrowse.FiltroAdicional: String;
begin
  result:=IfThen(CNAE.Text='','','UPPER(CNAE) STARTING WITH '+QuotedStr(UpperCase(CNAE.Text))+' AND ')+
          IfThen(NOMBRE.Text='','','UPPER(NOMBRE) CONTAINING '+QuotedStr(UpperCase(NOMBRE.Text))+' AND ');
  if EndsText(' AND ',Result) then
    Delete(result,length(Result)-4,5);
end;

function TFrmCNAEBrowse.PuedeEliminar: Boolean;
var
  Sentencia:String;
begin
  Result:=ADVistaNIVEL.AsInteger=5;
  if not Result then
  begin
    With ConsultaAD(UniMainModule.ADConexionGeneral,
                    'SELECT FIRST 1 CNAE FROM CNAE_NIVEL_'+IfThen(ADVistaNIVEL.AsInteger=3,'5',IntToStr(ADVistaNIVEL.AsInteger+1))+' WHERE NIVEL_'+ADVistaNIVEL.AsString+'='+QuotedStr(ADVistaCNAE.AsString)) do
      try
        Result:=IsEmpty;
      finally
        Free;
      end;
    if not Result then
      uniGUIDialogs.ShowMessage('Existen CNAES dependientes de este. No se puede eliminar');
  end;
end;

end.
