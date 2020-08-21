unit Frm_SeleccionEmpresaMaestro;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, Frm_Browse, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  Data.DB, FireDAC.Comp.Client, FireDAC.Comp.DataSet, uniEdit, uniLabel,
  uniBasicGrid, uniDBGrid, uniToolBar, uniButton, uniBitBtn, uniGUIBaseClasses,
  uniPanel, Funciones,
  uniMultiItem, uniComboBox, uniDBEdit, FireDAC.Phys.SQLiteVDataSet,
  FireDAC.DatS, FireDAC.DApt, FireDAC.UI.Intf, FireDAC.Phys,
  FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
  FireDAC.VCLUI.Wait;

type
  TFrmSeleccionEmpresaMaestro = class(TFrmBrowse)
    ADConnection1: TFDConnection;
    ADLocalSQL1: TFDLocalSQL;
    ADNIFLocal: TFDQuery;
    ADEmpresasGeneral: TFDQuery;
    ADVistaNIF: TStringField;
    ADVistaNOMBRE: TStringField;
    ADVistaEXISTENTE: TWideStringField;
    ADEmpresasGeneralNIF: TStringField;
    ADEmpresasGeneralNOMBRE: TStringField;
    ADEmpresasGeneralINTERNO: TIntegerField;
    ADVistaINTERNO: TIntegerField;
    UniLabel1: TUniLabel;
    UniLabel2: TUniLabel;
    EXISTENTE: TUniComboBox;
    UniLabel3: TUniLabel;
    NOMBRCLI: TUniEdit;
    CIFCLI: TUniEdit;
    ADNIFLocalNIF_APLICACION: TStringField;
    procedure ADVistaBeforeOpen(DataSet: TDataSet);
  private
    { Private declarations }
    procedure IniciaFiltro;override;
    function FiltroAdicional:String;override;
  public
    { Public declarations }
    constructor Crear(ConexionLocal:TFDConnection;CampoNIF,Tabla:String;Editor:TUniFormClass;Filtro:String='';Ordenacion:String='';Campo:TField=nil;NombreCampo:String='';CallBack:TProcedimientoH=nil;EditorModal:Boolean=False;SoloLectura:Boolean=False);
  end;

function FrmSeleccionEmpresaMaestro: TFrmSeleccionEmpresaMaestro;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication, StrUtils;

function FrmSeleccionEmpresaMaestro: TFrmSeleccionEmpresaMaestro;
begin
  Result := TFrmSeleccionEmpresaMaestro(UniMainModule.GetFormInstance(TFrmSeleccionEmpresaMaestro));
end;

procedure TFrmSeleccionEmpresaMaestro.ADVistaBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  if not ADEmpresasGeneral.Active then ADEmpresasGeneral.Open;
  if not ADNIFLocal.Active then ADNIFLocal.Open;
  if not ADLocalSQL1.Active then ADLocalSQL1.Active:=True;
  if not ADConnection1.Connected then ADConnection1.Open;
end;

constructor TFrmSeleccionEmpresaMaestro.Crear(ConexionLocal: TFDConnection;
  CampoNIF, Tabla: String; Editor: TUniFormClass; Filtro, Ordenacion: String;
  Campo: TField; NombreCampo: String; CallBack: TProcedimientoH; EditorModal,
  SoloLectura: Boolean);
begin
  inherited Crear(Editor,'',Ordenacion,Campo,NombreCampo,CallBack,EditorModal,SoloLectura);
  ADEmpresasGeneral.MacroByName('FILTRO').AsRaw:=Filtro;
  ADNIFLocal.Connection:=ConexionLocal;
  ADNIFLocal.MacroByName('CAMPO_NIF').AsRaw:=CampoNIF;
  ADNIFLocal.MacroByName('TABLA').AsRaw:=Tabla;
end;

function TFrmSeleccionEmpresaMaestro.FiltroAdicional: String;
begin
  result:=IfThen(NOMBRCLI.Text='','','UPPER(NOMBRE) LIKE '+QuotedStr('%'+UpperCase(NOMBRCLI.Text)+'%')+' AND ')+
          IfThen(CIFCLI.Text='','','UPPER(NIF) LIKE '+QuotedStr('%'+UpperCase(CIFCLI.Text)+'%')+' AND ')+
          IfThen(EXISTENTE.ItemIndex=0,'','EXISTENTE='+QuotedStr(IfThen(EXISTENTE.ItemIndex=0,'S','N'))+' AND ');
  System.Delete(Result,Length(Result)-4,5);
end;

procedure TFrmSeleccionEmpresaMaestro.IniciaFiltro;
begin
  inherited;
  NOMBRCLI.Text:='';
  CIFCLI.Text:='';
  EXISTENTE.ItemIndex:=0;
end;

end.
