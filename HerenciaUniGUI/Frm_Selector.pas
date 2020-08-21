unit Frm_Selector;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Dialogs, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, Data.DB, uniBasicGrid, uniDBGrid, uniToolBar,
  uniGUIBaseClasses, Funciones, Vcl.Forms;

type
  TProcedimientoSeleccion=reference to procedure(Resultado:Integer;Dataset:TDataset);
  TFrmSelector = class(TUniForm)
    UniToolBar1: TUniToolBar;
    UBAceptar: TUniToolButton;
    UBCancelar: TUniToolButton;
    UniToolButton2: TUniToolButton;
    UBPrimero: TUniToolButton;
    UBAnterior: TUniToolButton;
    UBSiguiente: TUniToolButton;
    UBUltimo: TUniToolButton;
    UniDBGrid1: TUniDBGrid;
    DSSelector: TDataSource;
    UBEliminar: TUniToolButton;
    procedure UniFormCreate(Sender: TObject);
    procedure UBCancelarClick(Sender: TObject);
    procedure UBAceptarClick(Sender: TObject);
    procedure UniFormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure UniFormClose(Sender: TObject; var Action: TCloseAction);
    procedure UBPrimeroClick(Sender: TObject);
    procedure UBAnteriorClick(Sender: TObject);
    procedure UBSiguienteClick(Sender: TObject);
    procedure UBUltimoClick(Sender: TObject);
    procedure UniDBGrid1DblClick(Sender: TObject);
    procedure UniFormShow(Sender: TObject);
    procedure UBEliminarClick(Sender: TObject);
    procedure UniDBGrid1DrawColumnCell(Sender: TObject; ACol, ARow: Integer;
      Column: TUniDBGridColumn; Attribs: TUniCellAttribs);
  private
    { Private declarations }
    FResultado:Integer;
    FCampoADevolver:String;
//    FAncho:integer;
    FProcedimientoSeleccion:TProcedimientoSeleccion;
  public
    { Public declarations }
    constructor Crear(Caption:String;Dataset:TDataSet;Campos,Titulos:Array of String;ProcedimientoSeleccion:TProcedimientoSeleccion=nil;Ancho:integer=0;AnchosColumna: string='';PonerBotonDeBorrar:boolean=False;pintarCeldasDeRojo:boolean=False;MensajeMascara:String='');
  end;

implementation

uses
  uniGUIApplication, MainModule, Math;

{$R *.dfm}


constructor TFrmSelector.Crear(Caption: String; Dataset: TDataSet; Campos,
  Titulos: array of String;ProcedimientoSeleccion:TProcedimientoSeleccion=nil;Ancho:integer=0;AnchosColumna: string='';PonerBotonDeBorrar:boolean=False;pintarCeldasDeRojo:boolean=False;MensajeMascara:String='');
var
  i:Integer;
  Anchos:TStringList;
begin
  inherited create(uniGUIApplication.UniApplication);

  UBEliminar.Visible:=PonerBotonDeBorrar;

  Self.Caption:=Caption;
  DSSelector.DataSet:=Dataset;
  UniDBGrid1.Columns.Clear;
  IF ancho<>0 then
    Self.Width:=ancho;

  Anchos:=TStringList.Create;
  try
    if AnchosColumna<>'' then
    begin
      Anchos.Delimiter:=';';
      Anchos.DelimitedText:=AnchosColumna;
    end;
    for i:=0 to Length(Campos)-1 do
    begin
      with UniDBGrid1.Columns.Add do
      begin
        FieldName:=Campos[i];
        Title.Caption:=Titulos[i];
        if anchos.Count>0 then
          Width:=StrToInt(Anchos[i]);
      end;
    end;
  finally
    FreeAndNil(Anchos);
  end;
  FProcedimientoSeleccion:=ProcedimientoSeleccion;
  if pintarCeldasDeRojo then
    UniDBGrid1.OnDrawColumnCell:=UniDBGrid1DrawColumnCell;
  UBAceptar.ScreenMask.Enabled:=MensajeMascara<>'';
  UBAceptar.ScreenMask.Message:=MensajeMascara;
end;

procedure TFrmSelector.UBAceptarClick(Sender: TObject);
begin
  FResultado:=mrOk;
  Close;
end;

procedure TFrmSelector.UBAnteriorClick(Sender: TObject);
begin
  DSSelector.DataSet.Prior;
end;

procedure TFrmSelector.UBCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmSelector.UBEliminarClick(Sender: TObject);
begin
  DSSelector.DataSet.Delete
end;

procedure TFrmSelector.UBPrimeroClick(Sender: TObject);
begin
  DSSelector.DataSet.First;
end;

procedure TFrmSelector.UBSiguienteClick(Sender: TObject);
begin
  DSSelector.DataSet.Next;
end;

procedure TFrmSelector.UBUltimoClick(Sender: TObject);
begin
  DSSelector.DataSet.Last;
end;

procedure TFrmSelector.UniDBGrid1DblClick(Sender: TObject);
begin
  UBAceptarClick(UBAceptar);
end;

procedure TFrmSelector.UniDBGrid1DrawColumnCell(Sender: TObject; ACol,
  ARow: Integer; Column: TUniDBGridColumn; Attribs: TUniCellAttribs);
begin
  Attribs.Font.Color:=clred;
end;

procedure TFrmSelector.UniFormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Assigned(FProcedimientoSeleccion) then FProcedimientoSeleccion(FResultado,DSSelector.DataSet);
  Action:=caFree;
end;

procedure TFrmSelector.UniFormCreate(Sender: TObject);
var
  i:Integer;
begin
  UniDBGrid1.ForceFit:=True;
  ClientEvents.ExtEvents.Values['window.maximize']:='function window.maximize(sender, eOpts){'+#13#10+
                                                    '  sender.setHeight(sender.getHeight()-'+IntToStr(UniMainModule.DimensionesMax.Top)+');'+#13#10+
                                                    '  sender.setWidth(sender.getWidth()-'+IntToStr(UniMainModule.DimensionesMax.Left)+');'+#13#10+
                                                    '  sender.setPosition('+IntToStr(UniMainModule.DimensionesMax.Left)+','+IntToStr(UniMainModule.DimensionesMax.Top)+');'+#13#10+
                                                    '}';
  for i:=0 to UniDBGrid1.Columns.Count-1 do
    UniDBGrid1.Columns.Items[i].Menu.MenuEnabled:=False;
  MonitorizarTeclas(Self,[VK_ESCAPE,VK_RETURN],False);
  FResultado:=mrCancel;
end;

procedure TFrmSelector.UniFormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_RETURN:UBAceptarClick(UBAceptar);
    VK_ESCAPE:UBCancelarClick(UBCancelar);
  end;
end;


procedure TFrmSelector.UniFormShow(Sender: TObject);
begin
  Height:=Min(UniMainModule.DimensionesMax.Height+UniMainModule.DimensionesMax.Top,
              Height+60+28*DSSelector.DataSet.RecordCount-+UniDBGrid1.Height);
end;

end.
