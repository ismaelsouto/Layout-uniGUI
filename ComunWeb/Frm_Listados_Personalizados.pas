unit Frm_Listados_Personalizados;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, Frm_Browse, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.Comp.Client, Data.DB, FireDAC.Comp.DataSet, uniEdit,
  uniLabel, uniBasicGrid, uniDBGrid, uniToolBar, uniButton, uniBitBtn,
  uniGUIBaseClasses, uniPanel, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, Datasnap.DBClient, Soap.SOAPConn,
  ComObj,ACtivex,StrUtils,
  uniPageControl,Funciones,uniGUIDialogs, FireDAC.DatS, FireDAC.DApt,
  FireDAC.Stan.ExprFuncs, FireDAC.Phys.SQLiteDef, FireDAC.UI.Intf, FireDAC.Phys,
  FireDAC.Phys.SQLite, FireDAC.VCLUI.Wait, FireDAC.Phys.SQLiteVDataSet;

type
  TFrmListadosPersonalizados = class(TFrmBrowse)
    ADPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink;
    ADConnection1: TFDConnection;
    ADLocalSQL1: TFDLocalSQL;
    UniLabel1: TUniLabel;
    Titulo: TUniEdit;
    UniPageControl1: TUniPageControl;
    UniTabSheet1: TUniTabSheet;
    UniTabSheet2: TUniTabSheet;
    FDMemTable1: TFDMemTable;
    FDMemTable1TIPO: TIntegerField;
    FDMemTable1IDLISTADOSCONDICIONALES: TIntegerField;
    FDMemTable1TITULO: TStringField;
    FDMemTable1SENTENCIA: TMemoField;
    FDMemTable1DESCRIPCION: TMemoField;
    FDMemTable1TIPOVALOR: TIntegerField;
    FDMemTable1CODIGO_USUARIO: TIntegerField;
    procedure ADVistaBeforeOpen(DataSet: TDataSet);
    procedure UniFormClose(Sender: TObject; var Action: TCloseAction);
    procedure UBConsultarClick(Sender: TObject);
    procedure UniPageControl1Change(Sender: TObject);
    procedure UniFormShow(Sender: TObject);
    procedure UniDBGrid1DblClick(Sender: TObject);
    procedure UniFormActivate(Sender: TObject);
    procedure UniDBGrid1TitleClick(Column: TUniDBGridColumn);
    procedure FDMemTable1AfterOpen(DataSet: TDataSet);
  private
    { Private declarations }
    Conexion:TFDConnection;
    QTipo:integer;
    function FiltroAdicional:String;override;
  public
    { Public declarations }
    constructor Crear(Editor:TUniFormClass;Filtro:String='';Ordenacion:String='';Campo:TField=nil;NombreCampo:String='';CallBack:TProcedimientoH=nil;EditorModal:Boolean=False;SoloLectura:Boolean=False;Conexion:TFDConnection=nil;tipo:integer=0);overload;
  end;

function FrmListadosPersonalizados: TFrmListadosPersonalizados;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication, frm_Listados_Personalizados_Editor;

function FrmListadosPersonalizados: TFrmListadosPersonalizados;
begin
  Result := TFrmListadosPersonalizados(UniMainModule.GetFormInstance(TFrmListadosPersonalizados));
end;

procedure TFrmListadosPersonalizados.ADVistaBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  ADLocalSQL1.Active:=True;
  ADVista.MacroByName('FILTRO').AsRaw:=IFThen(ADVista.MacroByName('FILTRO').AsRaw<>'',ADVista.MacroByName('FILTRO').AsRaw+' AND ','')+' tipo='+IntTostr(QTipo);
end;

procedure TFrmListadosPersonalizados.UBConsultarClick(Sender: TObject);
begin
//  inherited;
 With TfrmListadosPersonalizadosEditor.Crear(ADVista.FieldByName('IDLISTADOSCONDICIONALES').AsInteger,Self.UniPageControl1.ActivePageIndex=1,Conexion) do
   ShowModal;

//
//  frmListadosPersonalizadosEditor.Crear();
//    ShowModal;
//frmLst347.Show
//  begin
//    ID:=;
//    EsProceso:=;
//    ShowModal;
//  end;
end;

procedure TFrmListadosPersonalizados.UniDBGrid1DblClick(Sender: TObject);
begin
  inherited;
  UBConsultarClick(Sender);
 end;

procedure TFrmListadosPersonalizados.UniDBGrid1TitleClick(
  Column: TUniDBGridColumn);
begin
//  inherited;

end;

procedure TFrmListadosPersonalizados.UniFormActivate(Sender: TObject);
begin
//  inherited;

end;

procedure TFrmListadosPersonalizados.UniFormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action:=caFree;
  CoUninitialize;
end;

procedure TFrmListadosPersonalizados.UniFormShow(Sender: TObject);
begin
  inherited;
 {$ifdef CAILAB}
  With TUniLabel.Create(Self) do
  begin
    Parent:=PanelFiltro;
    Caption:='Código';
    Left:=641;
    Top:=10;
  end;

  With TUniEdit.Create(Self) do
  begin
    Parent:=PanelFiltro;
    Name:='EditCodigo';
    Left:=641;
    Top:=28;
    Width:=121;
  end;
  Titulo.width:=600;
  UBBFiltrar.Left:=763;
  UBBRestauraFiltro.Left:=UBBFiltrar.Left+UBBFiltrar.Width;
  {$endif}

  Filtrar;
end;

procedure TFrmListadosPersonalizados.UniPageControl1Change(Sender: TObject);
begin
  inherited;
  Filtrar;
end;


constructor TFrmListadosPersonalizados.Crear(Editor: TUniFormClass; Filtro,
  Ordenacion: String; Campo: TField; NombreCampo: String;
  CallBack: TProcedimientoH; EditorModal, SoloLectura: Boolean;
  Conexion: TFDConnection;tipo:integer);
  var i :integer;
begin
  inherited Crear(Editor,Filtro,Ordenacion,Campo,NombreCampo,CallBack,EditorModal, SoloLectura);
 {$ifdef CAILAB}
    ADVista.MacroByName('CAMPOS').AsRaw:=ADVista.MacroByName('CAMPOS').AsRaw+',CODIGO_USUARIO';
    With UniDBGrid1.Columns.Add do
    begin
      Title.Caption:='Código';
      FieldName:='CODIGO_USUARIO';
      Width:=150;
    end;
 {$endif};

  Self.conexion:=Conexion;
  Self.QTipo:=Tipo;
  ADConnection1.Connected:=True;
end;

procedure TFrmListadosPersonalizados.FDMemTable1AfterOpen(DataSet: TDataSet);
var
  i:Integer;
begin
  inherited;
  with CDSRestFacturaGDB('SELECT tipo,IDLISTADOSCONDICIONALES,TITULO,SENTENCIA,DESCRIPCION,case when ((UPPER(replace(replace(REPLACE(sentencia,'' '',''''),ascii_char(13),''''),ascii_char(10),'''')) containing ''/*#LW*/'')) then 1 else 0 END TIPOVALOR '+
                         {$ifdef CAILAB}',CODIGO_USUARIO '+{$endif}
                         'FROM LISTADOSCONDICIONALES where TIPO='+
                         IntToStr(QTipo)+' AND ((UPPER(replace(replace(REPLACE(sentencia,'' '',''''),ascii_char(13),''''),ascii_char(10),'''')) containing ''/*#LW*/'') OR (UPPER(replace(replace(REPLACE(sentencia,'' '',''''),ascii_char(13),''''),ascii_char(10),'''')) containing ''/*#PW*/''))'+
                         ' UNION SELECT -1 TIPO,-1 IDLISTADOSCONDICIONALES,'''' TITULO,'''' SENTENCIA,'''' DESCRIPCION, 1 TIPOVALOR'+
                         {$ifdef CAILAB}',-1 CODIGO_USUARIO '+{$endif}' FROM RDB$DATABASE') do
    try
      while not Eof do
      begin
        FDMemTable1.Append;
        for i:=0 to Fields.Count-1 do FDMemTable1.FieldByName(Fields[i].FieldName).Value:=Fields[i].Value;
        Next;
      end;
    finally
      Free;
    end;
  if FDMemtable1.State=dsInsert then
    FDMemtable1.Post;


end;

function TFrmListadosPersonalizados.FiltroAdicional: String;
begin
  result:=IfThen(Titulo.Text='','','upper(TITULO) LIKE '+QuotedStr('%'+Uppercase(Titulo.Text)+'%')+' AND ')+
         IfThen(UniPageControl1.ActivePageIndex=0,'TIPOVALOR=1','TIPOVALOR=0')+' AND '
 {$ifdef CAILAB}
         +IfThen(TUniEdit(Self.FindComponent('EditCodigo')).Text='','','CODIGO_USUARIO='+TUniEdit(Self.FindComponent('EditCodigo')).Text+' AND ')
 {$endif};

  if EndsText(' AND ',Result) then
    Delete(result,length(Result)-4,5);
end;


end.
