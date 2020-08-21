unit Frm_CAICONECTA;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniBasicGrid, uniDBGrid, uniMemo, uniDBMemo,
  uniPanel, uniPageControl, uniURLFrame, uniToolBar, uniGUIBaseClasses, Data.DB, DBClient,
  uniSplitter, ServerModule;

type
  TFrmCAICONECTA = class(TUniForm)
    DSMensajesLeidos: TDataSource;
    DSMensajesNoLeidos: TDataSource;
    UniPanel1: TUniPanel;
    UniPageControl1: TUniPageControl;
    UTSNoLeidos: TUniTabSheet;
    UniDBMemo1: TUniDBMemo;
    UTSLeidos: TUniTabSheet;
    UniDBGrid1: TUniDBGrid;
    UniPanel2: TUniPanel;
    UniURLFrame1: TUniURLFrame;
    UniSplitter1: TUniSplitter;
    UniToolBar1: TUniToolBar;
    UBSiguiente: TUniToolButton;
    UTBMarcarTodos: TUniToolButton;
    UniToolButton1: TUniToolButton;
    UBSalir: TUniToolButton;
    UniToolBar2: TUniToolBar;
    UBPrimero: TUniToolButton;
    UBAnterior: TUniToolButton;
    UBSiguiente2: TUniToolButton;
    UBUltimo: TUniToolButton;
    UniToolButton3: TUniToolButton;
    UniToolButton5: TUniToolButton;
    procedure UBSalirClick(Sender: TObject);
    procedure UniFormCreate(Sender: TObject);
    procedure DatasetAfterScroll(DataSet: TDataSet);
    procedure UTBMarcarTodosClick(Sender: TObject);
    procedure UniFormClose(Sender: TObject; var Action: TCloseAction);
    procedure MensajeGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure UBSiguienteClick(Sender: TObject);
    procedure UniPageControl1Change(Sender: TObject);
    procedure UBPrimeroClick(Sender: TObject);
    procedure UBAnteriorClick(Sender: TObject);
    procedure UBSiguiente2Click(Sender: TObject);
    procedure UBUltimoClick(Sender: TObject);
    procedure UniFormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure UniFormShow(Sender: TObject);
  private
    { Private declarations }
    programa:String;
    IDUsuario:Integer;
    procedure Filtrar;
    procedure ActualizaIDCAICONECTA;
    procedure ActualizaWeb(URL: String;ActualizarIDCAICONECTA:Boolean=True);
  public
    { Public declarations }
    Constructor Create(AOwner: TComponent;CDS:TClientDataset;Programa:string;IDUsuario:Integer);OverLoad;
  end;

function FrmCAICONECTA: TFrmCAICONECTA;
function MensajesWeb(IDUsuario:Integer;Primera:Boolean=False;Programa:String=''):TClientDataset;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication, Funciones, StrUtils;

function FrmCAICONECTA: TFrmCAICONECTA;
begin
  Result := TFrmCAICONECTA(UniMainModule.GetFormInstance(TFrmCAICONECTA));
end;

function MensajesWeb(IDUsuario:Integer;Primera:Boolean=False;Programa:String=''):TClientDataset;
begin
  result:=CDSRestFacturaGDB('SELECT '+IfThen(Primera,'FIRST 1','')+' MENSAJES.*,SUBSTRING(MENSAJE FROM 1 FOR 500) AS SMENSAJE '+#13+
                    'FROM MENSAJES'+#13+
                    IfThen((Programa='PORTALSII') or (Programa='PORTALEEM'),
                    'WHERE (UPPER(PROGRAMA)='+QuotedStr(Programa)+' OR '+#13+
                    '       ID IN (SELECT IDMENSAJES FROM MENSAJESPROGRAMAS WHERE UPPER(PROGRAMA)='+QuotedStr(Programa)+'))',
                    'WHERE (UPPER(PROGRAMA)='+QuotedStr(Programa+'WEB')+' OR '+#13+
                    IfThen(EndsText('WEB',UpperCase(Programa)),'UPPER(PROGRAMA)='+QuotedStr(Programa)+' OR '+#13,'')+
                    '       UPPER(PROGRAMA)='+QuotedStr('PORTALCAI')+' OR'+#13+
                    '       ID IN (SELECT IDMENSAJES FROM MENSAJESPROGRAMAS WHERE UPPER(PROGRAMA) IN ('+QuotedStr('PORTALCAI')+','''+Programa+'WEB'''+IfThen(EndsText('WEB',UpperCase(Programa)),','+QuotedStr(Programa),'')+')))')+' AND '+#13+
//                    '      COALESCE(ALTAOBAJA,'+QuotedStr('T')+')='+QuotedStr('A')+' AND'+#13+
                    '      ((NOT (ID IN (SELECT IDMENSAJES FROM MENSAJESLICENCIAS))) OR'+#13+
                    '       ((ID IN (SELECT IDMENSAJES FROM MENSAJESLICENCIAS)) AND (SELECT LICENCIAS_PROGRAMAS_WEB.LICENCIA FROM USUARIOS'+IfThen(SameText(Programa,'PORTALSII'),'_PORTALSII',IfThen(SameText(Programa,'PORTALEEM'),'_PORTALEMP',''))+
                    ' INNER JOIN LICENCIAS_PROGRAMAS_WEB ON (CLAVEEMP=EMPRESA) WHERE (UPPER(PROGRAMA)='''+IFThen(Programa='PORTALEEM','PORTALEMP',Programa)+'WEB'' OR UPPER(PROGRAMA)='''+IFThen(Programa='PORTALEEM','PORTALEMP',Programa)+''') AND IDUSUARIOS'+IfThen(SameText(Programa,'PORTALSII'),'_PORTALSII',IfThen(SameText(Programa,'PORTALEEM'),'_PORTALEMP',''))+'='+IntToStr(IDUsuario)+
                    ') IN (SELECT MENSAJESLICENCIAS.LICENCIA FROM MENSAJESLICENCIAS WHERE IDMENSAJES=MENSAJES.ID))) AND'+#13+
                    '      (FECHA_FIN IS NULL OR FECHA_FIN>='+QuotedStr(FormatDateTime('mm/dd/yyyy',Date))+')'+
                    'ORDER BY FECHA DESC,ID DESC')
end;

{ TFrmCAICONECTA }

procedure TFrmCAICONECTA.ActualizaIDCAICONECTA;
begin
  if DSMensajesNoLeidos.DataSet.FieldByName('ID').AsString<>'' then
    ModificaFacturaGDB(IfThen(SameText(Programa,'PORTALSII') or SameText(Programa,'PORTALEEM'),
                       'UPDATE USUARIOS_'+IFTHen(Programa='PORTALEEM','PORTALEMP',Programa)+' SET IDCAICONECTA='+DSMensajesNoLeidos.DataSet.FieldByName('ID').AsString+' WHERE IDUSUARIOS_'+IFTHen(Programa='PORTALEEM','PORTALEMP',Programa)+'='+IntToStr(IDUsuario),
                       'UPDATE USUARIOS SET IDCAICONECTA_'+Programa+'='+DSMensajesNoLeidos.DataSet.FieldByName('ID').AsString+' WHERE IDUSUARIOS='+IntToStr(IDUsuario)));
end;

procedure TFrmCAICONECTA.ActualizaWeb(URL: String;ActualizarIDCAICONECTA:Boolean);
begin
  if ActualizarIDCAICONECTA then
    ActualizaIDCAICONECTA;
  if URL='' then
    UniURLFrame1.URL:='about:blank'
  else
    UniURLFrame1.URL:=URL;
end;

constructor TFrmCAICONECTA.Create(AOwner: TComponent; CDS: TClientDataset;Programa:string;IDUsuario:Integer);
begin
  inherited Create(AOwner);
  Self.Programa:=Programa;
  Self.IDUsuario:=IDUsuario;
  DSMensajesNoLeidos.Dataset:=CDS;
  Filtrar;
  DSMensajesLeidos.DataSet.AfterScroll:=DatasetAfterScroll;
end;

procedure TFrmCAICONECTA.DatasetAfterScroll(DataSet: TDataSet);
begin
  ActualizaWeb(DataSet.FieldByName('LINK').AsString,DSMensajesNoLeidos.DataSet=Dataset);
end;

procedure TFrmCAICONECTA.Filtrar;
var
  ID:String;
begin
  with CDSRestFacturaGDB(IfThen(SameText(Programa,'PORTALSII') or SameText(Programa,'PORTALEEM'),
                 'SELECT IDCAICONECTA FROM USUARIOS_'+IFTHen(Programa='PORTALEEM','PORTALEMP',Programa)+' WHERE IDUSUARIOS_'+IFTHen(Programa='PORTALEEM','PORTALEMP',Programa)+'='+IntToStr(IDUsuario),
                 'SELECT IDCAICONECTA_'+Programa+' FROM USUARIOS WHERE IDUSUARIOS='+IntToStr(IDUsuario))) do
    try
      ID:=Fields.Fields[0].AsString;
    finally
      Free;
    end;
  with TClientDataset(DSMensajesNoLeidos.Dataset) do
  begin
    if Filtered then Filtered:=False;
    Filter:='ID>0'+ID;
    Filtered:=True;
//    TCLientDataset(DSMensajesLeidos.DataSet).CloneCursor(TClientDataset(DSMensajesNoLeidos.Dataset),True);
//    TClientDataSet(DSMensajesLeidos.DataSet).AddIndex('Indice','ID',[ixDescending]);
//    IndexName:='Indice';
//    IndexFieldNames:='ID';
  end;
  if not assigned(DSMensajesLeidos.DataSet) then
  begin
    DSMensajesLeidos.DataSet:=TClientDataset.Create(nil);
    TCLientDataset(DSMensajesLeidos.DataSet).CloneCursor(TClientDataset(DSMensajesNoLeidos.Dataset),True);
    TClientDataSet(DSMensajesLeidos.DataSet).AddIndex('Indice','ID',[ixDescending]);
  end;
  with TClientDataset(DSMensajesLeidos.DataSet) do
  begin
    if Filtered then Filtered:=False;
    Filter:='ID<=0'+ID;
    Filtered:=True;
    IndexName:='Indice';
  end;
  DSMensajesLeidos.DataSet.FieldByName('SMENSAJE').OnGetText:=MensajeGetText;
end;

procedure TFrmCAICONECTA.MensajeGetText(Sender: TField; var Text: string;
  DisplayText: Boolean);
begin
  Text:=ReplaceText(ReplaceText(ReplaceText(Sender.AsString,#0,''),#13#10,' '),#10,' ');
end;

procedure TFrmCAICONECTA.UBAnteriorClick(Sender: TObject);
begin
  DSMensajesLeidos.DataSet.Prior;
end;

procedure TFrmCAICONECTA.UBPrimeroClick(Sender: TObject);
begin
  DSMensajesLeidos.DataSet.First;
end;

procedure TFrmCAICONECTA.UBSalirClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TFrmCAICONECTA.UBSiguiente2Click(Sender: TObject);
begin
  DSMensajesLeidos.DataSet.Next;
end;

procedure TFrmCAICONECTA.UBSiguienteClick(Sender: TObject);
begin
  Filtrar;
  ActualizaWeb(DSMensajesNoLeidos.DataSet.FieldByName('LINK').AsString);
end;

procedure TFrmCAICONECTA.UBUltimoClick(Sender: TObject);
begin
  DSMensajesLeidos.DataSet.Last;
end;

procedure TFrmCAICONECTA.UniFormClose(Sender: TObject;
  var Action: TCloseAction);
var
  DS:TDataset;
begin
  if DSMensajesNoLeidos.DataSet.RecordCount>1 then
    ModalResult:=mrNoToAll;
  DS:=DSMensajesNoLeidos.Dataset;
  FreeAndNil(DS);
  DS:=DSMensajesLeidos.Dataset;
  FreeAndNil(DS);
end;

procedure TFrmCAICONECTA.UniFormCreate(Sender: TObject);
begin
  MonitorizarTeclas(Self,[VK_ESCAPE],False);
  UniDBGrid1.ForceFit:=True;
end;

procedure TFrmCAICONECTA.UniFormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_ESCAPE then
    Self.Close;
end;

procedure TFrmCAICONECTA.UniFormShow(Sender: TObject);
begin
  DatasetAfterScroll(DSMensajesNoLeidos.DataSet);
end;

procedure TFrmCAICONECTA.UniPageControl1Change(Sender: TObject);
begin
  UBSiguiente.Visible:=UniPageControl1.ActivePageIndex=0;
  if UniPageControl1.ActivePageIndex=0 then
    ActualizaWeb(DSMensajesNoLeidos.DataSet.FieldByName('LINK').AsString)
  else
    ActualizaWeb(DSMensajesLeidos.DataSet.FieldByName('LINK').AsString,False)
end;

procedure TFrmCAICONECTA.UTBMarcarTodosClick(Sender: TObject);
begin
  if not DSMensajesNoLeidos.Dataset.IsEmpty then
  begin
    DSMensajesNoLeidos.Dataset.Last;
    ActualizaIDCAICONECTA;
    Filtrar;
    UniURLFrame1.URL:='about:blank';
  end;
end;

end.
