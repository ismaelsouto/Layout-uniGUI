unit Frm_AEAT_Browse;

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
  TFrmAEATBrowse = class(TFrmBrowse)
    ADVistaCODIGO: TStringField;
    ADVistaDELEGACI: TStringField;
    ADVistaADMINIST: TStringField;
    CODIGO: TUniEdit;
    UniLabel2: TUniLabel;
    DELEGACI: TUniEdit;
    UniLabel3: TUniLabel;
    ADMINIST: TUniEdit;
    UniLabel4: TUniLabel;
    procedure UniFormShow(Sender: TObject);
  private
    { Private declarations }
    function FiltroAdicional:String;override;
  public
    { Public declarations }
  end;

function FrmAEATBrowse: TFrmAEATBrowse;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication, StrUtils;

function FrmAEATBrowse: TFrmAEATBrowse;
begin
  Result := TFrmAEATBrowse(UniMainModule.GetFormInstance(TFrmAEATBrowse));
end;

{ TFrmAEATBrowse }

function TFrmAEATBrowse.FiltroAdicional: String;
begin
  result:=IfThen(CODIGO.Text='','','CODIGO CONTAINING '+QuotedStr(UpperCase(CODIGO.Text))+' AND ')+
          IfThen(DELEGACI.Text='','','UPPER(DELEGACI) CONTAINING '+QuotedStr(UpperCase(DELEGACI.Text))+' AND ')+
          IfThen(ADMINIST.Text='','','UPPER(ADMINIST) CONTAINING '+QuotedStr(UpperCase(ADMINIST.Text))+' AND ');
  if EndsText(' AND ',Result) then
    Delete(result,length(Result)-4,5);
end;

procedure TFrmAEATBrowse.UniFormShow(Sender: TObject);
begin
  inherited;
  CODIGO.SetFocus;
end;

end.
