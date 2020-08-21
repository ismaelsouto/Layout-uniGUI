unit Frm_Listados;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniGUIBaseClasses, uniButton, Data.DB,
  Datasnap.DBClient, uniEdit, uniDBEdit, uniPanel, uniBasicGrid,
  uniDBGrid, Data.FMTBcd, Data.SqlExpr, uniBitBtn, uniPageControl, uniCheckBox,
  uniLabel,UniGUIDialogs, uniSpeedButton, DateUtils, uniDateTimePicker, uniMemo,Math,
  uniScreenMask,StrUtils, uniTrackBar, ppDB,
  ppCtrls,ppBands, ppCache, ppComm, ppProd, ppReport,ppParameter,raCodMod,
  ppClass, ppDBPipe,
  ppRelatv, ppEndUsr,  ppPrnabl, ppDBBDE, ppStrtch, ppMemo,
  ppChrt,  ppVar, ppChrtDP,ppModule, clipbrd, uniToolBar, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.Stan.Async,
   ppDesignLayer, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdExplicitTLSClientServerBase, FireDAC.DatS, FireDAC.DApt;
//  TeEngine,Series,TeeProcs, Chart, DBChart,
type
  TListados = class(TUniForm)
    DSConsulta: TDataSource;
    CDSParametros: TFDMemTable;
    ppReport1: TppReport;
    ppHeaderBand1: TppHeaderBand;
    ppDetailBand1: TppDetailBand;
    ppFooterBand1: TppFooterBand;
    ppParameterList1: TppParameterList;
    ppDBPipeline1: TppDBPipeline;
    DSParametros: TDataSource;
    ppDBPParametros: TppDBPipeline;
    cdsconsulta: TFDQuery;
    UniScreenMask1: TUniScreenMask;
    UniToolBar1: TUniToolBar;
    UniToolButton1: TUniToolButton;
    UniToolButton2: TUniToolButton;
    ubExcel: TUniToolButton;
    UniScreenMask3: TUniScreenMask;
    UniToolButton3: TUniToolButton;
    procedure btImprimirConsulta;
    procedure UniFormShow(Sender: TObject);
    procedure cdsconsultaAfterOpen(DataSet: TDataSet);
    procedure UniToolButton1Click(Sender: TObject);
    procedure UBImprimirClick(Sender: TObject);
    procedure UBSalirClick(Sender: TObject);
    procedure UniFormCreate(Sender: TObject);
    procedure UniFormClose(Sender: TObject; var Action: TCloseAction);
    procedure UniFormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cdsconsultaBeforeOpen(DataSet: TDataSet);
  private
    { Private declarations }
    CDSListadosCondicionales:TClientDataset;
    Detalles:Array of TFDQuery;
    procedure AbrirConsultas(AbreDetalles:boolean=True);
    procedure InicializaListado;
    procedure AsignarValorParametros;
    procedure CreaComponentes(Listado:TDataset; MasterSource:TDataSource);
    function ListadosEmbebidos(Consulta:string):string;
    function AjustaSentencia(Sentencia:String):String;
  protected
    Conexion:TFDConnection;
    FIDDeListado:integer;
    SinArchivo:boolean;
    EjecutarProceso:boolean;
    Parametros:Array of String;
    Filtro:String;
    Imprimir_solo_a_PDF: Boolean;
    procedure EjecutaProceso;
    function ExportaAExcel(var titulo:string):boolean;virtual;
    function DaleValorAParametro(nombreparametro:string):string;virtual;
    function ValidacionesPrevias:boolean;virtual;
    procedure ParametrosManuales;virtual;
    procedure AnhadeParametro(parametro:string);
    function ValorManualAParametro(nombre:string):string;virtual;
    procedure SacaConsultaEnGrid;virtual;
  public
    { Public declarations }
    FMuestraMensajes:Boolean;
    FURLpdf:String;
    RutaPDF:string;
    FListaParametros:TStringList;
    class procedure GeneraPDF(Con:TFDConnection;IDListado:Integer;ParametrosValores:array of string;RutaFicheroPDF:String);
  end;

function Listados: TListados;

implementation

uses
  uniGUIApplication, MainModule, Funciones, ServerModule, Xc12Utils5,
  Frm_VisorPDF, ipshttps, FireDAC.Comp.Script, Firedac.Stan.Consts;

{$R *.dfm}

function Listados: TListados;
begin
  Result := TListados(UniMainModule.GetFormInstance(TListados));
end;


procedure TListados.CreaComponentes(Listado: TDataset;
  MasterSource: TDataSource);
var
  Consulta:TDataSet;
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
  if Assigned(TFDQuery(DS.DataSet).Params) then
  begin
    for i:=0 to TFDQuery(DS.DataSet).Params.Count-1 do
    begin
      j:=0;
      while (j<Length(Parametros)) and (Parametros[j]<>TFDQuery(DS.DataSet).Params.Items[i].Name) do j:=j+1;
      if j=Length(Parametros) then
      begin
        SetLength(Parametros,length(Parametros)+1);
        Parametros[length(Parametros)-1]:=TFDQuery(DS.DataSet).Params.Items[i].Name;
      end;
    end;
  end;
  ParametrosManuales;
end;

begin
  if Listado=CdsListadosCondicionales then
  begin
    //cdsconsulta.Fields.Clear; PROBLEMA
    if CDSConsulta.Active then CDSConsulta.Close;
    CDSConsulta.SQL.Text:=AjustaSentencia(Listado.FieldByName('Sentencia').AsString);

//    cdsconsulta.SQL.Text:=ListadosEmbebidos(cdsconsulta.SQL.Text);
//    Clipboard.SetTextBuf(Pchar(cdsconsulta.SQL.Text));

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
        DataSource.DataSet:=TFDQuery.Create(Self);
        TFDQuery(DataSource.Dataset).Connection:=Conexion;
        TFDQuery(DataSource.Dataset).FormatOptions.StrsEmpty2Null:=False;
        DataSource.DataSet.Name:='CDS'+ReplaceText(Listado.FieldByname('TITULO').AsString,' ','_')+'_'+FormatDateTime('yyyymmddhhnnss',Listado.FieldByname('FECHA').AsDateTime);

        //Proveedor:=TDataSetProvider.Create(Self);
        //Proveedor.Name:='DSP'+ReplaceText(Listado.FieldByname('TITULO').AsString,' ','_')+'_'+FormatDateTime('yyyymmddhhnnss',Listado.FieldByname('FECHA').AsDateTime);
        //Proveedor.DataSet:=TSQLQuery.Create(Self);
        //TSQLQuery(Proveedor.Dataset).SQLConnection:=cdsconsulta.SQLConnection;
        TFDQuery(DataSource.Dataset).SQL.Text:=AjustaSentencia(Listado.FieldByName('Sentencia').AsString);

        //TFDQuery(DataSource.Dataset).SetProvider(Proveedor);
        //TFDQuery(DataSource.Dataset).ProviderName:=Proveedor.Name; PROBLEMA
        //TFDQuery(DataSource.Dataset).FetchParams; PROBLEMA

        DS:=DataSource;
        TFDQuery(DataSource.DataSet).MasterSource:=MasterSource;
        SetLength(Detalles,Length(Detalles)+1);
        Detalles[Length(Detalles)-1]:=TFDQuery(DataSource.Dataset);
        SL:=TStringList.Create;
        try
          SL.Text:=Listado.FieldByname('DESCRIPCION').AsString;
          if SL.Count>1 then TFDQuery(DataSource.Dataset).IndexFieldNames:=SL.Strings[1];
          if SL.Count>0 then TFDQuery(DataSource.Dataset).MasterFields:=SL.Strings[0];
        finally
          FreeAndNil(SL);
        end;
      end;
    finally
      FreeAndNil(Consulta);
    end;
  end;
  CreaComponentesParametros;

  Consulta:=CDSRestFacturaGDB('SELECT IDLISTADOSCONDICIONALES,TITULO,SENTENCIA,DESCRIPCION,FECHA FROM LISTADOSCONDICIONALES WHERE TIPO='+IntTostr(Listado.FieldByName('IDLISTADOSCONDICIONALES').AsInteger*-1));
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

procedure TListados.EjecutaProceso;
begin
  cdsconsulta.ExecSQL;
  if FMuestraMensajes then UniGUIDialogs.ShowMessage('Proceso realizado');
end;

function TListados.ExportaAExcel(var titulo: string): boolean;
begin
  Result:=False;
end;

class procedure TListados.GeneraPDF(Con:TFDConnection;IDListado:Integer;ParametrosValores:array of String;RutaFicheroPDF:String);
var
  i:Integer;
begin
  with TListados.Create(uniGUIApplication.UniApplication) do
    try
      FMuestraMensajes:=False;
      FIDDeListado:=IDListado;
      Imprimir_solo_a_PDF:=True;
      FListaParametros:=TStringList.Create;
      for i:=0 to Length(ParametrosValores)-1 do FListaParametros.Add(ParametrosValores[i]);
      Conexion:=Con;
      btImprimirConsulta;
      CopyFile(PChar(RutaPDF),PCHar(RutaFicheroPDF),False);
      DeleteFile(RutaPDF);
    finally
      Free;
    end;
end;

procedure TListados.btImprimirConsulta;
var
  HoraInicio:TDateTime;
  i:integer;
  p: string;
  stit: string;
  cdsTmp : TFDMemTable;
begin

  if not ValidacionesPrevias then
    Exit;

  InicializaListado;

  AbrirConsultas;

  HoraInicio:=Now;

  if EjecutarProceso then
    EjecutaProceso
  Else
  if CDSConsulta.RecordCount>0 then
  begin
    BorraFicheros('_*_.*');
    if CDSListadosCondicionales.FieldByName('SENTENCIA').AsString<>'' then
    begin
      if ExportaAExcel(stit) then
      begin
        // ExportarUnaTabla3 no funciona bien con cdsConsulta (posiblemente tenga problemas con SQLls con Executes Block)
        cdsTmp := TFDMemTable.Create(cdsConsulta);
        try
          cdsTmp.CloneCursor(cdsConsulta);

          ExportarUnaTabla3(cdsTmp,'Hoja', '', True, TexcelVersion.xvExcel97,IfThen(CDSListadosCondicionales.FieldByName('TITULO').AsString <> '', LeftStr(ReplaceInvalidFileNameChars(CDSListadosCondicionales.FieldByName('TITULO').AsString),200)+'.xls', ''));
        finally
          cdsTmp.Free;
        end;

//        if FMuestraMensajes and not cdsConsulta.IsEmpty then
//          uniGUIDialogs.ShowMessage('Proceso finalizado');
      end
      Else begin
        with TipsHTTPS.Create(nil) do
          try
            with CDSRestFacturaGDB('SELECT CampoU FROM Licencias') do
              try
                User:=Fields[0].AsString;
              finally
                Free;
              end;
            with CDSRestFacturaGDB('SELECT CampoC FROM Licencias') do
              try
                Password:=Fields[0].AsString;
              finally
                Free;
              end;
            LocalFile:=UniServerModule.LocalCachePath+IntToStr(FIDDeListado)+'.rtm';
            try
              Get(ReplaceText('https://www.caisistemas.es/privado/RTM Listados Condicionales/'+IntToStr(FIDDeListado)+'.rtm',' ','%20'));
            except
            end;
            SinArchivo:=not FileExists(LocalFile);
            if not SinArchivo then
            begin
              ppReport1.Template.FileName:=LocalFile;
              ppReport1.Template.LoadFromFile;
              DeleteFile(LocalFile);
            end
          finally
            Free;
          end;
        ppReport1.Reset;
        if SinArchivo then
          SacaConsultaEnGrid
        Else begin
          if Imprimir_solo_a_PDF =False then
          begin
            TFrmVisorPDF.Create(UniApplication).Mostrar(ReplaceText(ExportaAPDF(ppReport1,IncludeTrailingPathDelimiter(UniServerModule.LocalCachePath)),UniServerModule.LocalCachePath,UniServerModule.LocalCacheURL),nil,nil)
          end
          else
          begin
            RutaPDF := ExportaAPDF(ppReport1,IncludeTrailingPathDelimiter(UniServerModule.LocalCachePath));
          end;
        end;
      end;
    end;
  end
  else if FMuestraMensajes then
  begin
    IF Pos('/*#PW*/',CDSListadosCondicionales.FieldByName('SENTENCIA').AsString)<>0 then
      UniGUIDialogs.ShowMessage('Proceso finalizado')
    Else
      UniGUIDialogs.ShowMessage('Sin datos');
  end;
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
      FreeAndNil(DS);
      //Liberamos el pipeline
      FreeAndNil(DBPipeline);
      //Liberamos el TFDQuery
      FreeAndNil(Detalles[i]);
    end;
    SetLength(Detalles,0);
  end;
begin
  LiberaDetalles; // Por si queda algo colgado de la ejecucion anterior
  If FIDDeListado=0 then Exit;

  if Assigned(CDSListadosCondicionales) then FreeAndNil(CDSListadosCondicionales);
  CDSListadosCondicionales:=CDSRestFacturaGDB('SELECT * FROM LISTADOSCONDICIONALES WHERE IDLISTADOSCONDICIONALES='+IntTostr(FIDDeListado),Self);

  CreaComponentes(CDSListadosCondicionales,nil);
end;

procedure TListados.ParametrosManuales;
begin
 //
end;

procedure TListados.SacaConsultaEnGrid;
begin
 //
end;

procedure TListados.cdsconsultaAfterOpen(DataSet: TDataSet);
var
  j,i:integer;
  par : TFDParam;
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
      if (UpperCase(copy(trim(par.Name),length(par.Name)-1,2))='_F') or (Pos('_F#',par.Name)>0) and (par.AsString <> '') then
        // Tiene que venir como MM/DD/YYYY
        CDSParametros.Fields.Fields[i].AsString:=Copy(par.AsString,4,2) + '/' + Copy(par.AsString,1,2) + '/' + Copy(par.AsString,7,4)
      else
          CDSParametros.Fields.Fields[i].AsString:=par.AsString
    end
    Else begin
      CDSParametros.Fields.Fields[i].AsString:=ValorManualAParametro(CDSParametros.Fields.Fields[i].FieldName);
    end;
  end;
  CDSParametros.Post;
end;

procedure TListados.cdsconsultaBeforeOpen(DataSet: TDataSet);
begin
  if not Assigned(cdsconsulta.Connection) then cdsconsulta.Connection:=Conexion;
end;

function TListados.AjustaSentencia(Sentencia: String): String;
begin
  if Pos('[EMPRESA]',Sentencia)>0 then Sentencia:='/* :Empresa */'+Sentencia;
  Sentencia:=ReplaceText(Sentencia,'[EMPRESA]',':Empresa ');
  Sentencia:=ReplaceText(Sentencia,'[FILTRO]',Filtro);
  Sentencia:=ReplaceText(Sentencia,'[VERSION]',QuotedStr('ADVANCED'));
  {$ifdef CAICONTA}
  Sentencia:=ReplaceText(Sentencia,'[USUARIO]',IntToStr(UniMainModule.ADUsuariosID.AsInteger));
  {$endif}
  {$ifdef CAILAB}
  Sentencia:=ReplaceText(Sentencia,'[USUARIO]',QuotedStr(UniMainModule.ADUsuariosID.AsString));
  {$endif}
  {$ifdef CAIFAC}
  Sentencia:=ReplaceText(Sentencia,'[USUARIO]',IntToStr(UniMainModule.IdUsuario));
  {$endif}
  {$ifdef CAIFIS}
  Sentencia:=ReplaceText(Sentencia,'[IDEMPRESA]',IntToStr(UniMainModule.ADEmpresaEMPRESA.AsInteger));
  Sentencia:=ReplaceText(Sentencia,'[GENERAL]',UniMainModule.ADConexionGeneral.Params.Values['DATABASE']);
  {$endif}
  {$ifdef CAIREN}
  Sentencia:=ReplaceText(Sentencia,'[USUARIO]',QuotedStr(UniMainModule.ADUsuariosNOMBRUSU.AsString));
  Sentencia:=ReplaceText(Sentencia,'[CONTRASEÑA]',QuotedStr(UniMainModule.ADUsuariosCLAVEUSU.AsString));
  Sentencia:=ReplaceText(Sentencia,'[CONTRIBUYENTE]',IntToStr(UniMainModule.ADContribuyenteCONTRIBU.AsInteger));
  {$endif}
  {$ifdef CAISOC}
  Sentencia:=ReplaceText(Sentencia,'[IDEMPRESA]',IntToStr(UniMainModule.ADEmpresaEMPRESA.AsInteger));
  {$endif}
  {$ifdef CAIGERH}
  Sentencia:=ReplaceText(Sentencia,'[USUARIO]',IntToStr(UniMainModule.ADQUsuariosINTERNO.AsInteger));
  {$ELSE}
  {$if not defined(CAISOC) and not defined(CAIFIS) and not defined(CAIREN)}
  Sentencia:=ReplaceText(Sentencia,'[IDEMPRESA]',IntToStr(UniMainModule.IDEmpresa));
  {$ifend}
  {$endif}
  Result:=Sentencia;
end;

procedure TListados.AnhadeParametro(parametro: string);
var
  hay: Boolean;
  I: Integer;
begin
  hay:=False;
  for I := Low(parametros) to High(Parametros) do
  begin
    if Sametext(Parametros[i],UpperCase(parametro)) then
    begin
      hay:=True;
      Break;
    end;
  end;

  if hay=false then
  begin
    SetLength(Parametros,length(Parametros)+1);
    Parametros[length(Parametros)-1]:=UpperCase(parametro);
  end;
end;

procedure TListados.AsignarValorParametros;
var
  i,j:integer;
  CDS:TFDQuery;
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
        if Assigned(FListaParametros) then
          CDS.Params.ParamByName(Parametros[i]).Value:=FListaParametros.Values[Parametros[i]]
        else
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
  Pos:TPoint;
  Consulta:String;
begin
  inherited;
  with TFDScript.Create(nil) do
    try
      Connection:=Conexion;//UniMainModule.ADConexionCAICONTA;
      ScriptOptions.CommandSeparator:='#';
      SQLScripts.Add.SQL.Text:=CDSListadosCondicionales.FieldByName('Sentencia').AsString;
      Connection.StartTransaction;
      try
        while not Eof do
        begin
          if cdsconsulta.Active then cdsconsulta.Close;
          Pos:=Position;
          ValidateStep;
          Consulta:='';
          for i:=Pos.Y to min(Position.Y,SQLScripts.Items[0].SQL.Count-1) do
            Consulta:=Consulta+IfThen(Consulta='','',#13)+copy(SQLScripts.Items[0].SQL.Strings[i],
                                                                  IfThen(i=Pos.Y,Pos.X+1,1),
                                                                  IfThen(i=Position.Y,Position.X,length(SQLScripts.Items[0].SQL.Strings[i]))-IfThen(i=Pos.Y,Pos.X+1,1)+1);
          Consulta:=trim(Consulta);
          if copy(Consulta,length(Consulta)-length(ScriptOptions.CommandSeparator)+1,length(ScriptOptions.CommandSeparator))=ScriptOptions.CommandSeparator then
            Consulta:=copy(Consulta,1,length(Consulta)-length(ScriptOptions.CommandSeparator));
//          Clipboard.SetTextBuf(Pchar(Consulta));

          Consulta:=AjustaSentencia(Consulta);

          Consulta:=ListadosEmbebidos(Consulta);
          Consulta:=BorraComentarios(Consulta);

          cdsconsulta.SQL.Text:=Consulta;
          try
            AsignarValorParametros;
          except
          end;
          if EjecutarProceso=false then
          begin
            try
              cdsConsulta.Open;
            except
              on E:EFDException do
                if E.FDCode<>er_FD_AccCmdMHRowSet then raise;
            end;
          end
        end;
        if Connection.InTransaction then
          Connection.Commit;
      except
        if Connection.InTransaction then
          Connection.Rollback;
        Raise;
      end;
    finally
      Free;
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

procedure TListados.UniFormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:=caFree;
end;

procedure TListados.UniFormCreate(Sender: TObject);
begin
  FListaParametros:=nil;
  FMuestraMensajes:=True;
  RutaPDF :='';
  Imprimir_solo_a_PDF := False;
  Filtro := ' ';
  EjecutarProceso := False;
  MonitorizarTeclas(Self,[VK_ESCAPE],False);
end;

procedure TListados.UniFormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  IF Key=VK_ESCAPE then Close;
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


function TListados.ValorManualAParametro(nombre:string):string;
begin
  Result:='';
end;

function TListados.ListadosEmbebidos(Consulta:string):string;
var
  i: Integer;
  k: Integer;
  lcond: string;
  s: string;
  c: string;
begin
  result:=Consulta;
  i:=Pos('/*[LC(',Result);
  while i<>0 do
  begin
    k:=1;
    while True do
    begin
      if Copy(Result,i+5+k,1)=')' then
      begin
        s:=Copy(Result,i,5+k);
//        Delete(s,Length(s),4);
        lcond:=DameSentenciaDeListadoPersonalizado(StrToInt(Copy(s,7,10)));
        s:=s+')]*/';
        Result:=ReplaceStr(Result,s,lcond);
        Result:=AjustaSentencia(Result);
        Break;
      end
      Else
        inc(k);
    end;
    i:=Pos('/*[LC(',Result);
  end;

end;

end.



