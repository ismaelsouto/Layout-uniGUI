unit Frm_MuestraConsulta;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, Data.DB, uniBasicGrid, uniDBGrid, uniToolBar,
  uniGUIBaseClasses, FireDAC.Comp.Client;

type
  TFrmMuestraConsulta = class(TUniForm)
    UniToolBar1: TUniToolBar;
    UniToolButton2: TUniToolButton;
    UBImprimir: TUniToolButton;
    UBSalir: TUniToolButton;
    UniDBGrid1: TUniDBGrid;
    DataSource1: TDataSource;
    procedure UBImprimirClick(Sender: TObject);
    procedure UniFormCreate(Sender: TObject);
    procedure UniFormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure UBSalirClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    constructor Crear(Conexion:TFDConnection;Consulta:String);
  end;

implementation

uses
  uniGUIApplication, Funciones, ServerModule;

{$R *.dfm}


{ TFrmMuestraConsulta }

constructor TFrmMuestraConsulta.Crear(Conexion: TFDConnection;
  Consulta: String);
begin
  inherited Create(uniGUIApplication.UniApplication);
  DataSource1.DataSet:=ConsultaAD(Conexion,Consulta,False,True,nil,DataSource1);
end;

procedure TFrmMuestraConsulta.UBImprimirClick(Sender: TObject);
begin
  GeneraListado(UniServerModule,UniDBGrid1,Uppercase(caption),[],'',False);
end;

procedure TFrmMuestraConsulta.UBSalirClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmMuestraConsulta.UniFormCreate(Sender: TObject);
begin
  MonitorizarTeclas(Self,[VK_ESCAPE],False);
end;

procedure TFrmMuestraConsulta.UniFormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_ESCAPE then Close;  
end;

end.
