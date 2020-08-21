unit Frm_contratos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  uniBasicGrid, uniDBGrid, uniToolBar, uniGUIBaseClasses, FireDAC.UI.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, FireDAC.DApt;

type
  TFrmContratos = class(TUniForm)
    UniToolBar1: TUniToolBar;
    DataSource1: TDataSource;
    ADMemTable1: TFDMemTable;
    DBGrid1: TUniDBGrid;
    ADMemTable1DOCUMENTO: TStringField;
    ADMemTable1INTERNO: TIntegerField;
    ADMemTable1HASHSHA256: TStringField;
    Conexion: TFDConnection;
    ADQuery1: TFDQuery;
    ADMemTable1consultar: TStringField;
    procedure DBGrid1CellClick(Column: TUniDBGridColumn);
    procedure DBGrid1AfterLoad(Sender: TUniDBGrid);
  private
  public
    { Public declarations }
  end;

function FrmContratos: TFrmContratos;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication, Frm_VisorPDF, ServerModule;

function FrmContratos: TFrmContratos;
begin
  Result := TFrmContratos(UniMainModule.GetFormInstance(TFrmContratos));
end;


procedure TFrmContratos.DBGrid1AfterLoad(Sender: TUniDBGrid);
var
  colindx: byte;
begin
  // your Column Index
  colindx := 2;

  DBGrid1.JSInterface.JSCode('var me='#1'; Ext.defer(function(){Ext.select(me.columnManager.columns['+ IntToStr(colindx) +'].getCellSelector()).setStyle("cursor", "pointer")}, 100);');
//  DBGrid1.JSInterface.JSCode('var me='#1'; Ext.defer(function(){Ext.select(me.columnManager.columns['+ IntToStr(colindx) +'].getCellSelector()).setStyle("font", "cai")}, 100);');
end;

procedure TFrmContratos.DBGrid1CellClick(Column: TUniDBGridColumn);
var
  Stream:TMemoryStream;
  NombreArchivo,fichero: string;

begin
  if column.Index=2 then
  begin
    fichero:='';
    with TFrmVisorPDF.Create(UniApplication) do
    begin
      ADQuery1.close;
      ADQuery1.sql.Text:='select CONTRATO_DFI from cai_documentos_firmados where interno='+IntTostr(ADMemTable1INTERNO.AsInteger);
      ADQuery1.Open;
      Stream:=TMemoryStream(ADQuery1.CreateBlobStream(ADQuery1.FieldByName('CONTRATO_DFI'),bmRead));
      try
        NombreArchivo:=FormatDateTime('yyyymmddhhnnsszzz',Now)+'.pdf';
        Fichero:=IncludeTrailingPathDelimiter(UniServerModule.LocalCachePath)+NombreArchivo;
        stream.SaveToFile(fichero);
      finally
        FreeAndnil(Stream);
      end;

      if fichero<>'' then
      begin
        Fichero:=IncludeTrailingPathDelimiter(UniServerModule.LocalCacheURL)+NombreArchivo;
        Caption:=ADMemTable1DOCUMENTO.AsString;
        Mostrar(fichero);
      end;
    end;
  end;
end;

end.
