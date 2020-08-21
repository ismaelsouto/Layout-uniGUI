unit Frm_Listados;



interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniGUIBaseClasses, uniButton, Data.DB,
  Datasnap.DBClient, uniEdit, uniDBEdit, uniPanel, uniBasicGrid,
  uniDBGrid, Data.FMTBcd, Data.SqlExpr, uniBitBtn, uniPageControl, uniCheckBox,
  uniLabel,UniGUIDialogs, uniSpeedButton, DateUtils, uniDateTimePicker, uniMemo,Math,
  SimpleDS, uniScreenMask,StrUtils, uniTrackBar, FBLScript,
  ppDB,
  ppCtrls,ppBands, ppCache, ppComm, ppProd, ppReport,ppParameter,raCodMod,
  ppClass, ppDBPipe,
  ppRelatv, ppEndUsr,  ppPrnabl, ppDBBDE, ppStrtch, ppMemo,
  ppChrt,  ppVar, ppChrtDP,ppModule, clipbrd, uniToolBar, uADStanIntf,
  uADStanOption, uADStanParam, uADStanError, uADDatSManager, uADPhysIntf,
  uADDAptIntf, uADCompDataSet, uADCompClient, uADStanAsync, uADDAptManager,
  uniImageList, ppDesignLayer;
//  TeEngine,Series,TeeProcs, Chart, DBChart,
type
  TListados = class(TUniForm)
    DSConsulta: TDataSource;
    ppReport1: TppReport;
    ppHeaderBand1: TppHeaderBand;
    ppDetailBand1: TppDetailBand;
    ppFooterBand1: TppFooterBand;
    ppParameterList1: TppParameterList;
    ppDBPipeline1: TppDBPipeline;
    DSParametros: TDataSource;
    ppDBPParametros: TppDBPipeline;
    UTBBotonera: TUniToolBar;
    UBImprimir: TUniToolButton;
    UBSalir: TUniToolButton;
    UniImageList1: TUniImageList;
    UniScreenMask1: TUniScreenMask;
    procedure btImprimirConsulta;
    procedure UniFormShow(Sender: TObject);
    procedure cdsconsultaAfterOpen(DataSet: TDataSet);
    procedure UniToolButton1Click(Sender: TObject);
    procedure UBImprimirClick(Sender: TObject);
    procedure UBSalirClick(Sender: TObject);
  private
    { Private declarations }
    Detalles:Array of TAdQuery;
    Parametros:Array of String;
    procedure AbrirConsultas(AbreDetalles:boolean=True);
    procedure InicializaListado;
    procedure AsignarValorParametros;
    procedure CreaComponentes(Listado:TDataset; MasterSource:TDataSource);
  protected
    FIDDeListado:integer;
    procedure InicializaEventosExtJS; virtual;
    function DaleValorAParametro(nombreparametro:string):string;virtual;
    function ValidacionesPrevias:boolean;virtual;
    procedure ConectaMDB;

  public
    { Public declarations }
  end;
function Listados: TListados;

implementation

uses
  uniGUIApplication, MainModule, Funciones, ServerModule,
  Frm_VisorPDF;

{$R *.dfm}

function Listados: TListados;
begin
  Result := TListados(UniMainModule.GetFormInstance(TListados));
end;


procedure TListados.CreaComponentes(Listado: TDataset;
  MasterSource: TDataSource);
var
  Consulta:TAdQuery;
  DS:TDataSource;
  SL:TStringList;
  i:integer;
procedure CreaComponentesParametros;
var
  i,j,k,z:integer;
  EsCheckORadioGroup,s:string;
  checkeado:boolean;
  contenedor:TStringList;
begin
  if Assigned(TADQuery(DS.DataSet).Params) then
  begin
    for i:=0 to TADQuery(DS.DataSet).Params.Count-1 do
    begin
      j:=0;
      while (j<Length(Parametros)) and (Parametros[j]<>TADQuery(DS.DataSet).Params.Items[i].Name) do j:=j+1;
      if j=Length(Parametros) then
      begin
        SetLength(Parametros,length(Parametros)+1);
        Parametros[length(Parametros)-1]:=TADQuery(DS.DataSet).Params.Items[i].Name;
      end;
    end;
  end;
end;
begin
  if Listado=CdsListadosCondicionales then
  begin
    //cdsconsulta.Fields.Clear; PROBLEMA
    if CDSConsulta.Active then CDSConsulta.Close;
    cdsconsulta.SQL.Text:=Listado.FieldByName('Sentencia').AsString;
    if Pos('[EMPRESA]',cdsconsulta.SQL.Text)>0 then cdsconsulta.SQL.Text:='/* :Empresa */'+cdsconsulta.SQL.Text;
    cdsconsulta.SQL.Text:=ReplaceText(cdsconsulta.SQL.Text,'[EMPRESA]',':Empresa ');
    cdsconsulta.SQL.Text:=ReplaceText(cdsconsulta.SQL.Text,'[FILTRO]',' ');
    cdsconsulta.SQL.Text:=ReplaceText(cdsconsulta.SQL.Text,'[VERSION]',QuotedStr('ADVANCED'));
    //if CDSConsulta.Active then CDSConsulta.Close;PROBLEMA
    //cdsconsulta.SQL.Text:=cdsconsulta.SQL.Text;PROBLEMA
    //CDSConsulta.Fields.Clear;PROBLEMA
    //CDSConsulta.Params.Clear;PROBLEMA
    //CDSConsulta.FetchParams; PROBLEMA
    DS:=DSConsulta;
    SetLength(Parametros,0);
  end
  else begin
    try
      with TppDBPipeline.Create(Self) do
      begin
        Name:=ReplaceText(Listado.FieldByname('TITULO').AsString,' ','_')+'_'+FormatDateTime('yyyymmddhhnnss',Listado.FieldByname('FECHA').AsDateTime);
        UserName:=Name;
        DataSource:=TDataSource.Create(Self);
        DataSource.DataSet:=TADQuery.Create(Self);
        TADQuery(DataSource.Dataset).Connection:=cdsconsulta.Connection;
        TADQuery(DataSource.Dataset).FormatOptions.StrsEmpty2Null:=False;
        DataSource.DataSet.Name:='CDS'+ReplaceText(Listado.FieldByname('TITULO').AsString,' ','_')+'_'+FormatDateTime('yyyymmddhhnnss',Listado.FieldByname('FECHA').AsDateTime);

        //Proveedor:=TDataSetProvider.Create(Self);
        //Proveedor.Name:='DSP'+ReplaceText(Listado.FieldByname('TITULO').AsString,' ','_')+'_'+FormatDateTime('yyyymmddhhnnss',Listado.FieldByname('FECHA').AsDateTime);
        //Proveedor.DataSet:=TSQLQuery.Create(Self);
        //TSQLQuery(Proveedor.Dataset).SQLConnection:=cdsconsulta.SQLConnection;
        TADQuery(DataSource.Dataset).SQL.Text:=Listado.FieldByName('Sentencia').AsString;
    //        TADQuery(DataSource.Dataset).SetProvider(Proveedor);
//        TADQuery(DataSource.Dataset).ProviderName:=Proveedor.Name; PROBLEMA
//        TADQuery(DataSource.Dataset).FetchParams; PROBLEMA

        DS:=DataSource;
        TADQuery(DataSource.DataSet).MasterSource:=MasterSource;

        SetLength(Detalles,Length(Detalles)+1);
        Detalles[Length(Detalles)-1]:=TADQuery(DataSource.Dataset);
        SL:=TStringList.Create;
        try
          SL.Text:=Listado.FieldByname('DESCRIPCION').AsString;
          if SL.Count>1 then TADQuery(DataSource.Dataset).IndexFieldNames:=SL.Strings[1];
          if SL.Count>0 then TADQuery(DataSource.Dataset).MasterFields:=SL.Strings[0];
        finally
          FreeAndNil(SL);
        end;
      end;
    finally
      FreeAndNil(Consulta);
    end;
  end;
  CreaComponentesParametros;

  Consulta:=TADQuery.Create(nil);
  Consulta.FormatOptions.StrsEmpty2Null:=False;
  Consulta.Connection:=UniMainModule.ADConexionMDB;
  ConectaMDB;
  Consulta.SQL.Text:='SELECT IDLISTADOSCONDICIONALES,TITULO,SENTENCIA,DESCRIPCION,FECHA FROM LISTADOSCONDICIONALES WHERE TIPO='+IntTostr(Listado.FieldByName('IDLISTADOSCONDICIONALES').AsInteger*-1);
  Consulta.Open;
  try
    while not Consulta.Eof do
    begin
      CreaComponentes(Consulta,DS);
      Consulta.Next;
    end;
  finally
    FreeAndNil(Consulta);
  end;
end;


function TListados.DaleValorAParametro(nombreparametro: string): string;
begin


end;

procedure TListados.btImprimirConsulta;
var
  RTMStream:TStream;
  HoraInicio:TDateTime;
  i:integer;
begin

  if not ValidacionesPrevias then
    Exit;

  InicializaListado;

  AbrirConsultas;

  HoraInicio:=Now;

  if CDSConsulta.RecordCount>0 then
  begin
//    UniMemo1.Lines.Add('datos ');
    BorraFicheros('_*_.*');
    if CDSListadosCondicionales.FieldByName('SENTENCIA').AsString<>'' then
    begin
////      UniMemo1.Lines.Add(IncludeTrailingPathDelimiter(UniServerModule.FilesFolderPath)+'rtm\'+IntToStr(FIDDeListado)+'.rtm');
//      if not FileExists(IncludeTrailingPathDelimiter(UniServerModule.FilesFolderPath)+'rtm\'+IntToStr(FIDDeListado)+'.rtm') then
//      begin
//        // me traigo el fichero por ftp y lo cargo en caso de que no exista por lo que primero pregunto
//
////        UniMainModule.IdFTP1.Username:=EjecutaSQLRemota('http://www.caisistemas.es/prueba/ADOLI.dll/soap/Imodulodedatos','Aux','SELECT CampoU FROM Licencias');
////        UniMainModule.IdFTP1.Password:=EjecutaSQLRemota('http://www.caisistemas.es/prueba/ADOLI.dll/soap/Imodulodedatos','Aux','SELECT CampoC FROM Licencias');
//        //CopyFile(PWideChar('D:\xvrt\caisistemas.es\Data\RTM Listados Condicionales\'+IntToStr(FIDDeListado)+'.rtm',PWideChar(UniServerModule.FilesFolderPath+'/RTM/'+IntToStr(FIDDeListado)+'.rtm');
//        CopyFile(PWideChar(IncludeTrailingPathDelimiter(UniServerModule.FilesFolderPath)+'SimulaWeb\'+IntToStr(FIDDeListado)+'.rtm'),PWideChar(IncludeTrailingPathDelimiter(UniServerModule.FilesFolderPath)+'rtm\'+IntToStr(FIDDeListado)+'.rtm'),false);
////        UniMainModule.IdFTP1.Host:='ftp.caisistemas.es';
////        UniMainModule.IDFtp1.Passive:=true;
////        UniMainModule.IDFtp1.Connect;
////        try
////          try
////            if UniMainModule.IdFTP1.Size('/Data/RTM Listados Condicionales/'+IntToStr(FIDDeListado)+'.rtm')>0 then
////            begin
////              UniMainModule.IDFtp1.Get('/Data/RTM Listados Condicionales/'+IntToStr(FIDDeListado)+'.rtm',
////              UniServerModule.FilesFolderPath+'/RTM/'+IntToStr(FIDDeListado)+'.rtm',true,false);
////            end;
////          finally
////            UniMainModule.IDFtp1.Disconnect;
////          end;
////        except
////          UniGUIDialogs.ShowMessage('No se ha podido subir el listado a la Web.');
////        end;
//      end;
//      ppReport1.Template.FileName:=IncludeTrailingPathDelimiter(UniServerModule.FilesFolderPath)+'rtm\'+IntToStr(FIDDeListado)+'.rtm';
      ppReport1.Template.FileName:=IncludeTrailingPathDelimiter(UniServerModule.RutaLicencias)+'RTM Listados Condicionales\'+IntToStr(FIDDeListado)+'.rtm';
      ppReport1.Template.LoadFromFile;
      ppReport1.Reset;
      TFrmVisorPDF.Create(UniApplication).Mostrar(ReplaceText(ExportaAPDF(ppReport1,IncludeTrailingPathDelimiter(UniServerModule.LocalCachePath)),UniServerModule.LocalCachePath,UniServerModule.LocalCacheURL));
//      TFrmVisorPDF.Create(UniApplication).Mostrar(ReplaceText(ExportaAPDF(Informe,IncludeTrailingPathDelimiter(UniServerModule.LocalCachePath)),UniServerModule.LocalCachePath,UniServerModule.LocalCacheURL));
//      UniMainModule.NombreDePDF:='_'+FormatDateTime('yyyymmddhhnnss',HoraInicio)+'_.pdf';
//      ExportaAPDF(ppReport1,UniServerModule.LocalCachePath+UniMainModule.NombreDePDF);
//      VisorPDF.ShowModal;
    end;
  end
  else
    UniGUIDialogs.ShowMessage('Sin datos');
end;

procedure TListados.InicializaEventosExtJS;
begin
//  btImprimir.ClientEvents.ExtEvents.Add('OnClick=function OnClick(sender, e)'#13#10'{'#13#10'  sendProcImpr('+
//    Self.Name+'.form);'#13#10'}');
end;

procedure TListados.InicializaListado;
  procedure LiberaDetalles;
  var
    i:integer;
    NombreProveedor:String;
    DS:TDataSource;
    DBPipeline:TppDBPipeline;
  begin
    for i:=0 to Length(Detalles)-1 do
    begin
      NombreProveedor:='DSP'+copy(Detalles[i].Name,4,length(Detalles[i].Name)-3);
      //Liberamos el datasource
      DBPipeline:=TppDBPipeline(FindComponent(copy(NombreProveedor,4,length(NombreProveedor)-3)));
      DS:=DBPipeline.DataSource;
//      Proveedor:=TDataSetProvider(FindComponent(NombreProveedor));
//      Query:=TSQLQuery(Proveedor.Dataset);
      FreeAndNil(DS);
      //Liberamos el pipeline
      FreeAndNil(DBPipeline);
      //liberamos el query
//      FreeAndNil(Query);
//      //Liberamos el Proveedor
//      FreeAndNil(Proveedor);
      //Liberamos el TClientDataset
      FreeAndNil(Detalles[i]);
    end;
    SetLength(Detalles,0);
  end;
begin
  LiberaDetalles; // Por si queda algo colgado de la ejecucion anterior
  If FIDDeListado=0 then Exit;

  IF CDSListadosCondicionales.Active then CDSListadosCondicionales.Close;
  CDSListadosCondicionales.SQL.Text:='SELECT * FROM LISTADOSCONDICIONALES WHERE IDLISTADOSCONDICIONALES='+IntTostr(FIDDeListado);
  ConectaMDB;
  CDSListadosCondicionales.Open;
  CreaComponentes(CDSListadosCondicionales,nil);
end;

procedure TListados.cdsconsultaAfterOpen(DataSet: TDataSet);
var
  j,i:integer;
  par : TADParam;
begin
  inherited;

  if CDSParametros.Active then
  begin
    CDSParametros.EmptyDataSet;
  end
  else begin
    IF Length(Parametros) = 0 then Exit;

    CDSParametros.FieldDefs.Clear;
    CDSParametros.Fields.Clear;

    for i:=0 to Length(Parametros)-1 do
    begin
      CDSParametros.FieldDefs.Add(Parametros[i],ftString,100);
      CDSParametros.FieldDefs.Items[CDSParametros.FieldDefs.Count-1].CreateField(CDSParametros);
    end;
    CDSParametros.CreateDataSet;
  end;
  CDSParametros.Append;

  For i:=0 to CDSParametros.FieldCount-1 do
  begin
    // Busco los parametros en CdsConsulta si es que existen
    par := CdsConsulta.Params.FindParam(CDSParametros.Fields.Fields[i].FieldName);
    IF assigned(par) then
    begin
        CDSParametros.Fields.Fields[i].AsString:=par.AsString
    end
    Else begin
    end;
  end;
  CDSParametros.Post;
end;

procedure TListados.AsignarValorParametros;
var
  i,j:integer;
  CDS:TADQuery;
begin

  for i:=0 to length(Parametros)-1 do
  begin
    for j:=0 to length(Detalles) do
    begin
      if j=0 then
        CDS:=CDSConsulta
      else
        CDS:=Detalles[j-1];

      if CDS.Params.FindParam(Parametros[i])<>nil then
      begin
        CDS.Params.ParamByName(Parametros[i]).DataType:=ftString;
        CDS.Params.ParamByName(Parametros[i]).Value:=DaleValorAParametro(Parametros[i]);
      end;
    end;
  end;
end;


procedure TListados.AbrirConsultas(AbreDetalles: boolean);
  function BorraComentarios(SQL: String): String;
  var
    Aux,Aux2:Integer;
  begin
    Aux:=Pos('/*',SQL);
    while Aux>0 do
    begin
      Aux2:=Pos('*/',SQL);
      SQL:=ReplaceText(SQL,copy(SQL,Aux,Aux2+1-Aux+1),' ');
      Aux:=Pos('/*',SQL);
    end;
    Result:=SQL;
  end;
var
  i:integer;
  Transaccion:TTransactionDesc;
begin
  inherited;
  FBLScript1.Reset;
  FBLScript1.SQLScript.Text:=CDSListadosCondicionales.FieldByName('Sentencia').AsString;

//  Transaccion.IsolationLevel:=xilREADCOMMITTED;
//  Transaccion.TransactionID:=1;
//  cdsconsulta.SQLConnection.StartTransaction(Transaccion);
  try
    while not FBLScript1.EOF do
    begin
      if CDSConsulta.Active then CDSConsulta.Close;
      cdsconsulta.SQL.Text:=ReplaceText(FBLScript1.Statement,'[EMPRESA]',':Empresa ');
      cdsconsulta.SQL.Text:=ReplaceText(cdsconsulta.SQL.Text,'[FILTRO]',' ');
      cdsconsulta.SQL.Text:=ReplaceText(cdsconsulta.SQL.Text,'[VERSION]',QuotedStr('ADVANCED'));
      cdsconsulta.SQL.Text:=BorraComentarios(cdsconsulta.SQL.Text);
      try
        AsignarValorParametros;
      except
      end;

      if FBLScript1.StatementType<>stSetTerm then
      begin
        if FBLScript1.StatementType in [stSelect,stUnknow] then
          CDSConsulta.Open
        else if FBLScript1.StatementType in [stInsert,stUpdate,stDelete] then
          CDSConsulta.Execute
        else
          cdsconsulta.ExecSQL(cdsconsulta.SQL.Text);
      end;
    end;
//    cdsconsulta.SQLConnection.Commit(Transaccion);
  except
    Raise;
//    cdsconsulta.SQLConnection.RollBack(Transaccion);
  end;
  if AbreDetalles then
    for i:=0 To Length(Detalles)-1 do
    begin
      IF Detalles[i].Active then Detalles[i].Close;
      Detalles[i].Open;
    end;
end;



procedure TListados.UBImprimirClick(Sender: TObject);
begin
  btImprimirConsulta;
end;

procedure TListados.UBSalirClick(Sender: TObject);
begin
  Close;
end;

procedure TListados.UniFormShow(Sender: TObject);
begin
//
end;

procedure TListados.UniToolButton1Click(Sender: TObject);
begin
  btImprimirConsulta;
end;

function TListados.ValidacionesPrevias: boolean;
begin
  Result:=True;
end;

procedure TListados.ConectaMDB;
begin
  if UniMainModule.ADConexionMDB.Connected=false then
  begin
    UniMainModule.ADConexionMDB.Params.Values['DATABASE']:=IncludeTrailingPathDelimiter(UniServerModule.RutaLicencias)+'licencias.mdb';
    UniMainModule.ADConexionMDB.Connected:=True;
  end;
end;

end.



