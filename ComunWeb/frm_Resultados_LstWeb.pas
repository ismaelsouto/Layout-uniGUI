unit frm_Resultados_LstWeb;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, Data.DB, uniGUIBaseClasses, uniBasicGrid, uniDBGrid,
  uniToolBar, frm_Listados_Personalizados_Editor, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Comp.Client,ACtiveX;

type
  TfrmResultadosLstWeb = class(TUniForm)
    DBGrid: TUniDBGrid;
    DataSource1: TDataSource;
    UniToolBar1: TUniToolBar;
    UBImprimir: TUniToolButton;
    UniToolButton3: TUniToolButton;
    UBSalir: TUniToolButton;
    UniToolButton1: TUniToolButton;
    ubExcel: TUniToolButton;
    procedure UniFormCreate(Sender: TObject);
    procedure UniFormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure UniFormClose(Sender: TObject; var Action: TCloseAction);
    procedure UBSalirClick(Sender: TObject);
    procedure UBImprimirClick(Sender: TObject);
    procedure UniFormShow(Sender: TObject);
    procedure ubExcelClick(Sender: TObject);
    procedure UniFormAjaxEvent(Sender: TComponent; EventName: string;
      Params: TUniStrings);
  private
    { Private declarations }
    QDataSet:TFDQuery;
    EnviarFichero:string;
  public
    { Public declarations }
    constructor Crear(DataSet:TFDQuery);
  end;

function frmResultadosLstWeb: TfrmResultadosLstWeb;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication, Funciones,  ServerModule,StrUtils,UniGuiDialogs;

function frmResultadosLstWeb: TfrmResultadosLstWeb;
begin
  Result := TfrmResultadosLstWeb(UniMainModule.GetFormInstance(TfrmResultadosLstWeb));
end;

constructor TfrmResultadosLstWeb.Crear(DataSet:TFDQuery);
begin
  inherited Create(uniGUIApplication.UniApplication);
  Self.QDataSet:=DataSet;
end;

procedure TfrmResultadosLstWeb.ubExcelClick(Sender: TObject);
var
  DS,ad:TFDQuery;
  Campos:String;
  i:Integer;
begin
  EnviarFichero:='';
  Campos:='';
  for i:=0 to DBGrid.Columns.Count-1 do Campos:=Campos+IfThen(Campos<>'',',','')+DBGrid.Columns.Items[i].FieldName+' "'+DBGrid.Columns.Items[i].Title.Caption+'"';
  DS:=TFDQuery(DBGrid.DataSource.DataSet);
  ad:=TFDQuery.Create(nil);
  with ad do
    try
      Connection:=DS.Connection;
      Transaction:=DS.Transaction;
      SQL.Text:='SELECT '+Campos+' FROM ('+DS.SQL.Text+')';
      for i:=0 to DS.MacroCount-1 do
        Macros.MacroByName(DS.Macros.Items[i].Name).AsRaw:=DS.Macros.Items[i].AsRaw;
      for i:=0 to DS.Params.Count-1 do
        ParamByName(DS.Params.Items[i].Name).Value:=DS.Params.Items[i].Value;
      Open;
      EnviarFichero:=IncludeTrailingPathDelimiter(UniServerModule.LocalCachePath)+'_'+FormatDateTime('yyyymmddhhnnsszzz',Now)+'_.xls';
      Coinitialize(nil);
      try
        ExportarUnaTabla3(ad,'Datos',EnviarFichero,True);
      finally
        CoUninitialize;
      end;
    finally
      Free;
    end;
//  UniSession.AddJS('ajaxRequest(' + Self.Name + '.form,''ENVIAFICHERO'',['''']);');

end;

procedure TfrmResultadosLstWeb.UBImprimirClick(Sender: TObject);
begin
  GeneraListado(UniServerModule,DBGrid,Uppercase(caption),[]);
end;

procedure TfrmResultadosLstWeb.UBSalirClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmResultadosLstWeb.UniFormAjaxEvent(Sender: TComponent;
  EventName: string; Params: TUniStrings);
begin
  if SameText(EventName, 'ENVIAFICHERO') then
  begin
    if FileExists(EnviarFichero)=False  then
      UniGuidialogs.showMEssage('asdfa')
    Else begin
      try
//        UniSession.SendFile(EnviarFichero);
      except
        on E:Exception do
          EnviarFichero:=E.Message;

      end;
    end;
  end;

end;

procedure TfrmResultadosLstWeb.UniFormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action:=caFree;
end;

procedure TfrmResultadosLstWeb.UniFormCreate(Sender: TObject);
begin
    MonitorizarTeclas(Self,[VK_ESCAPE],False);
end;

procedure TfrmResultadosLstWeb.UniFormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_ESCAPE then
    Close;
end;

procedure TfrmResultadosLstWeb.UniFormShow(Sender: TObject);
var
  i: Integer;
begin
  DataSource1.DataSet:=QDataSet;
  for i:=0 to dbgrid.Columns.Count-1 do
  begin
    if dbgrid.Columns.Items[i].Width<200 then
      dbgrid.Columns.Items[i].Width:=200;


  end;

end;

end.
