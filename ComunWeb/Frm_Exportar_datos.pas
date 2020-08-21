unit Frm_Exportar_datos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniRadioGroup, uniToolBar, uniGUIBaseClasses,
  uniScreenMask,SQLConnectionC, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, sqlexpr,dbclient,strutils;

type
  TFrmExportarDatos = class(TUniForm)
    UniToolBar1: TUniToolBar;
    UBAceptar: TUniToolButton;
    UBSalir: TUniToolButton;
    RadioGroup1: TUniRadioGroup;
    UniScreenMask1: TUniScreenMask;
    FDQuery1: TFDQuery;
    FDQuerytablas: TFDQuery;
    procedure UBAceptarClick(Sender: TObject);
    procedure UniFormAjaxEvent(Sender: TComponent; EventName: string;
      Params: TUniStrings);
    procedure UBSalirClick(Sender: TObject);
  private
    FConexion: TFDConnection;
    procedure SetConexion(const Value: TFDConnection);
    { Private declarations }
  public
   property Conexion: TFDConnection read FConexion write SetConexion;
  end;

function FrmExportarDatos: TFrmExportarDatos;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication, Funciones, ServerModule;

function FrmExportarDatos: TFrmExportarDatos;
begin
  Result := TFrmExportarDatos(UniMainModule.GetFormInstance(TFrmExportarDatos));
end;




procedure TFrmExportarDatos.SetConexion(const Value: TFDConnection);
begin
  FConexion := Value;
end;

procedure TFrmExportarDatos.UBAceptarClick(Sender: TObject);
var
  Ruta: string;
begin
  createdir(IncludeTrailingPathDelimiter(UniServerModule.LocalCachePath)+'gdb');
  createdir(IncludeTrailingPathDelimiter(UniServerModule.LocalCachePath)+'xml');

  try
    case RadioGroup1.ItemIndex of
      0:
      begin
        Ruta:=copy(Conexion.Params.Values['DATABASE'],
                   Pos(':',Conexion.Params.Values['DATABASE'])+1,
                   Length(Conexion.Params.Values['DATABASE'])-Pos(':',Conexion.Params.Values['DATABASE']));
        CopyFile(PChar(Ruta),PChar(IncludeTrailingPathDelimiter(UniServerModule.LocalCachePath)+'gdb\'+ExtractFileName(Ruta)),False);
      end;

      1:
      begin
        // Procesa
        FDQuery1.Connection:=Conexion;
        FDQuerytablas.Connection:=Conexion;

        FDQuerytablas.Close;
        FDQuerytablas.sql.Text:= 'select rdb$relation_name '+
                                 'from rdb$relations '+
                                 'where rdb$view_blr is null '+
                                 'and (rdb$system_flag is null or rdb$system_flag = 0);';
        FDQuerytablas.Open;

        while not FDQuerytablas.eof do
        begin
          FDQuery1.Close;
          FDQuery1.sql.Text:='select * from '+FDQuerytablas.Fields.Fields[0].AsString;
          FDQuery1.Open;
          FDQuery1.SaveToFile(IncludeTrailingPathDelimiter(UniServerModule.LocalCachePath)+'xml\'+trim(FDQuerytablas.Fields.Fields[0].AsString)+'.xml');
          FDQuery1.Close;
          FDQuerytablas.next;
        end;
      end;
    end;

  finally
     ShowMessage('Los datos se han exportado correctamente en el formato seleccionado.'+#13+' Pulsa para comprimir los datos y descargar el fichero "datos.zip".',
                 procedure (Sender: Tcomponent;AResult: Integer)
                 begin
                   UniSession.AddJS(Self.Name+'.form.showMask(''Comprimiendo datos...'');'+#13#10+
                     'ajaxRequest('+Self.Name+'.form,''COMPRIMIR'',[]);');
                 end);
  end;
end;

procedure TFrmExportarDatos.UBSalirClick(Sender: TObject);
begin
  ModalResult:=mrCancel;
end;

procedure TFrmExportarDatos.UniFormAjaxEvent(Sender: TComponent;
  EventName: string; Params: TUniStrings);
begin
  if SameText(EventName,'COMPRIMIR') then
  begin
    Deletefile(IncludeTrailingPathDelimiter(UniServerModule.LocalCachePath)+'datos.zip');
    ComprimirCarpeta(IncludeTrailingPathDelimiter(UniServerModule.LocalCachePath)+ifthen(RadioGroup1.ItemIndex=0,'gdb','xml'),IncludeTrailingPathDelimiter(UniServerModule.LocalCachePath)+'datos.zip','');
    UniSession.AddJS(self.Name + '.form.hideMask();');
    UniSession.SendFile(IncludeTrailingPathDelimiter(UniServerModule.LocalCachePath)+'datos.zip');
    ShowMessage('Proceso finalizado.');
  end;
end;

end.
