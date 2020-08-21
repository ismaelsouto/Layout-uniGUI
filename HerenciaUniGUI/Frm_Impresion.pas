unit Frm_Impresion;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uADStanIntf, uADStanOption, uADStanParam,
  uADStanError, uADDatSManager, uADPhysIntf, uADDAptIntf, uADStanAsync,
  uADDAptManager, ppProd, ppClass, ppReport, ppComm, ppRelatv, ppDB, ppDBPipe,
  Data.DB, uADCompDataSet, uADCompClient, uniToolBar, uniGUIBaseClasses,
  uniImageList, ppParameter, ppDesignLayer, ppBands, ppCache, uniMemo;

type
  TFrmImpresion = class(TUniForm)
    UniImageList1: TUniImageList;
    UTBBotonera: TUniToolBar;
    UBImprimir: TUniToolButton;
    UBSalir: TUniToolButton;
    ADConsulta: TADQuery;
    DSConsulta: TDataSource;
    procedure UBSalirClick(Sender: TObject);
    procedure UBImprimirClick(Sender: TObject);
    procedure UniFormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  protected
    Informe:TppReport;
    RutaRtm:String;
    procedure Imprimir;virtual;
  end;

implementation

uses
  uniGUIApplication, Frm_VisorPDF, StrUtils, Funciones, ServerModule;

{$R *.dfm}


procedure TFrmImpresion.Imprimir;
var
  RutaFichero:String;
begin
  if ADConsulta.Active then ADConsulta.Close;
  Informe.Template.FileName:=RutaRtm;
  Informe.Template.LoadFromFile;
  RutaFichero:=ExportaAPDF(Informe,IncludeTrailingPathDelimiter(UniServerModule.LocalCachePath));
  if FileExists(RutaFichero) then
    TFrmVisorPDF.Create(UniApplication).Mostrar(ReplaceText(RutaFichero,UniServerModule.LocalCachePath,UniServerModule.LocalCacheURL))
  else
    ShowMessage('No hay datos que mostrar');
end;

procedure TFrmImpresion.UBImprimirClick(Sender: TObject);
begin
  Imprimir;
end;

procedure TFrmImpresion.UBSalirClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmImpresion.UniFormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_RETURN then UBImprimirClick(nil)
  else if Key=VK_ESCAPE then UBSalirClick(nil);
end;

end.
