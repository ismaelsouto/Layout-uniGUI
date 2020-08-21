unit Frm_UsuariosImportar;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniToolBar, uniGUIBaseClasses, uniBasicGrid,
  uniDBGrid, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Funciones, uniButton, uniBitBtn;

type
  TFrmUsuariosImportar = class(TUniForm)
    UniToolBar1: TUniToolBar;
    UBAceptar: TUniToolButton;
    UBCancelar: TUniToolButton;
    UniDBGrid1: TUniDBGrid;
    ADUsuarios: TFDMemTable;
    ADUsuariosUSUARIO: TStringField;
    ADUsuariosIMPORTAR: TBooleanField;
    DSUsuarios: TDataSource;
    ADUsuariosIDUSUARIOS: TIntegerField;
    ADUsuariosCONTRASENA: TStringField;
    UniBitBtn1: TUniBitBtn;
    UBBTodas: TUniBitBtn;
    procedure UniFormCreate(Sender: TObject);
    procedure UniFormClose(Sender: TObject; var Action: TCloseAction);
    procedure UBCancelarClick(Sender: TObject);
    procedure UBAceptarClick(Sender: TObject);
    procedure UBBTodasClick(Sender: TObject);
    procedure UniBitBtn1Click(Sender: TObject);
  private
    { Private declarations }
    FCampo:String;
    FIDUsuario:Integer;
  public
    { Public declarations }
    constructor Crear(Campo:String;IDUsuario:Integer);
  end;

implementation

uses
  uniGUIApplication;

{$R *.dfm}


constructor TFrmUsuariosImportar.Crear(Campo: String; IDUsuario: Integer);
begin
  inherited Create(uniGUIApplication.UniApplication);
  FCampo:=Campo;
  FIDUsuario:=IDUsuario;
end;

procedure TFrmUsuariosImportar.UBAceptarClick(Sender: TObject);
begin
  ModalResult:=mrOk;
  Close;
end;

procedure TFrmUsuariosImportar.UBBTodasClick(Sender: TObject);
begin
  ADUsuarios.First;
  while not ADUsuarios.Eof do
  begin
    ADUsuarios.Edit;
    ADUsuariosIMPORTAR.AsBoolean:=True;
    ADUsuarios.Next;
  end;
end;

procedure TFrmUsuariosImportar.UBCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmUsuariosImportar.UniBitBtn1Click(Sender: TObject);
begin
  ADUsuarios.First;
  while not ADUsuarios.Eof do
  begin
    ADUsuarios.Edit;
    ADUsuariosIMPORTAR.AsBoolean:=False;
    ADUsuarios.Next;
  end;
end;

procedure TFrmUsuariosImportar.UniFormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action:=caFree;
end;

procedure TFrmUsuariosImportar.UniFormCreate(Sender: TObject);
var
  i:Integer;
begin
  ModalResult:=mrCancel;
  UniDBGrid1.ForceFit:=True;
  for i:=0 to UniDBGrid1.Columns.Count-1 do
    UniDBGrid1.Columns.Items[i].Menu.MenuEnabled:=False;
  with CDSRestFacturaGDB('SELECT IDUSUARIOS,NOMBRE,CONTRASENA'+#13+
                         'FROM USUARIOS'+#13+
                         'WHERE EMPRESA=(SELECT EMPRESA FROM USUARIOS WHERE IDUSUARIOS='+IntToStr(FIDUsuario)+') AND'+#13+
                         '      COALESCE('+FCampo+',''N'')=''N'''+#13+
                         'ORDER BY NOMBRE') do
    try
      while not eof do
      begin
        ADUsuarios.Append;
        ADUsuariosIDUSUARIOS.AsInteger:=FieldByName('IDUSUARIOS').AsInteger;
        ADUsuariosUSUARIO.AsString:=FieldByName('NOMBRE').AsString;
        ADUsuariosCONTRASENA.AsString:=FieldByName('CONTRASENA').AsString;
        ADUsuariosIMPORTAR.AsBoolean:=False;
        ADUsuarios.Post;
        Next;
      end;
      ADUsuarios.First;
    finally
      Free;
    end;
end;

end.
