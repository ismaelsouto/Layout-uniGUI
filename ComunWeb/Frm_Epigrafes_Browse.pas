unit Frm_Epigrafes_Browse;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, Frm_Browse, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.Comp.DataSet, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.Comp.Client, Data.DB,  uniEdit,
  uniLabel, uniBasicGrid, uniDBGrid, uniToolBar, uniButton, uniBitBtn,
  uniGUIBaseClasses, uniPanel, uniMultiItem, uniComboBox, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt;

type
  TFrmEpigrafesBrowse = class(TFrmBrowse)
    ADVistaTIPO: TStringField;
    ADVistaEPIGRAFE: TStringField;
    ADVistaNOMBRE: TStringField;
    UniLabel1: TUniLabel;
    EPIGRAFE: TUniEdit;
    UniLabel2: TUniLabel;
    NOMBRE: TUniEdit;
    UniLabel3: TUniLabel;
    TIPO: TUniComboBox;
    procedure TIPOChange(Sender: TObject);
    procedure ADVistaTIPOGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
  private
    { Private declarations }
    function FiltroAdicional:String;override;
  public
    { Public declarations }
  end;

function FrmEpigrafesBrowse: TFrmEpigrafesBrowse;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication, StrUtils;

function FrmEpigrafesBrowse: TFrmEpigrafesBrowse;
begin
  Result := TFrmEpigrafesBrowse(UniMainModule.GetFormInstance(TFrmEpigrafesBrowse));
end;

procedure TFrmEpigrafesBrowse.ADVistaTIPOGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  inherited;
  Text:=IfThen(Sender.AsString='S','Sin Epígrafe',
        IfThen(Sender.AsString='B','Batea',
        IfThen(Sender.AsString='E','Empresarial',
        IfThen(Sender.AsString='P','Profesional',
        IfThen(Sender.AsString='A','Artística')))));
end;

function TFrmEpigrafesBrowse.FiltroAdicional: String;
begin
  Result:=IfThen(TIPO.ItemIndex=0,'','TIPO='+QuotedStr(IfThen(TIPO.ItemIndex=1,'S',
                                                       IfThen(TIPO.ItemIndex=2,'B',
                                                       IfThen(TIPO.ItemIndex=3,'E',
                                                       IfThen(TIPO.ItemIndex=4,'P','A')))))+' AND ')+
          IfThen(EPIGRAFE.Text='','','UPPER(EPIGRAFE) STARTING WITH '+QuotedStr(UpperCase(EPIGRAFE.Text))+' AND ')+
          IfThen(NOMBRE.Text='','','UPPER(NOMBRE) CONTAINING '+QuotedStr(UpperCase(NOMBRE.Text))+' AND ');
  if EndsText(' AND ',Result) then
    Delete(result,length(Result)-4,5);
end;

procedure TFrmEpigrafesBrowse.TIPOChange(Sender: TObject);
begin
  inherited;
  UBBFiltrarClick(nil);
end;

end.
