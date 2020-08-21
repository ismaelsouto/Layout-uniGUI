unit Frm_EditorReglasNegocio;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.Comp.DataSet, FireDAC.DApt.Intf, Data.DB,
   FireDAC.Comp.Client, ServerModule, uniButton, uniBitBtn, uniPanel,
  uniToolBar, uniSyntaxEditor, uniGUIBaseClasses, uniBasicGrid, uniDBGrid,
  uniEdit, uniLabel, uniMultiItem, uniComboBox, uniDBComboBox,
  uniDBLookupComboBox, uniDBEdit, uPSCompiler, Funciones,
  uPSRuntime, uPSC_dateutils, UPSR_dateutils,  uPSR_DB, uPSC_DB, uPSUtils, MainModule, uniSyntaxEditorBase,
  FireDAC.DatS, FireDAC.Phys.Intf;


type
  TPSPascalCompilerH=class(TPSPascalCompiler)
  private
     ADS:array of TDataSet;
     AP:array of Pointer;
     ADefinicion:array of string;
  end;
  TFrmEditorReglasNegocio = class(TUniForm)
    ADReglasNegocio: TFDMemTable;
    ADReglasNegocioCALCULO: TMemoField;
    ADReglasNegocioCAMPOS: TStringField;
    UniDBGrid1: TUniDBGrid;
    DSReglasNegocio: TDataSource;
    CODIGO_FUENTE: TUniSyntaxEdit;
    UniToolBar1: TUniToolBar;
    UBAnadir: TUniToolButton;
    UBEliminar: TUniToolButton;
    UniToolButton1: TUniToolButton;
    UBPrimero: TUniToolButton;
    UBAnterior: TUniToolButton;
    UBSiguiente: TUniToolButton;
    UBUltimo: TUniToolButton;
    UniToolButton2: TUniToolButton;
    UBSalir: TUniToolButton;
    PanelFiltro: TUniPanel;
    UniLabel1: TUniLabel;
    UniLabel2: TUniLabel;
    ADCampos: TFDMemTable;
    ADCamposCAMPO: TStringField;
    CAMPOS_DATO: TUniDBLookupComboBox;
    CAMPOS_RESULTADO: TUniDBLookupComboBox;
    DSCampos: TDataSource;
    ADReglasNegocioCALCULO_S: TStringField;
    UniPanel1: TUniPanel;
    UniToolBar2: TUniToolBar;
    UBAceptar: TUniToolButton;
    UBCancelar: TUniToolButton;
    UniLabel3: TUniLabel;
    UniDBEdit1: TUniDBEdit;
    procedure UniFormCreate(Sender: TObject);
    procedure UBSalirClick(Sender: TObject);
    procedure ADReglasNegocioAfterPost(DataSet: TDataSet);
    procedure ADReglasNegocioAfterDelete(DataSet: TDataSet);
    procedure UBAnadirClick(Sender: TObject);
    procedure UBCancelarClick(Sender: TObject);
    procedure UBAceptarClick(Sender: TObject);
    procedure DSReglasNegocioDataChange(Sender: TObject; Field: TField);
    procedure ADReglasNegocioNewRecord(DataSet: TDataSet);
    procedure UBEliminarClick(Sender: TObject);
    procedure Filtrar(Sender: TObject);
    procedure ADReglasNegocioFilterRecord(DataSet: TDataSet;
      var Accept: Boolean);
    procedure UBSiguienteClick(Sender: TObject);
    procedure UBAnteriorClick(Sender: TObject);
    procedure UBPrimeroClick(Sender: TObject);
    procedure UBUltimoClick(Sender: TObject);
    procedure UniFormClose(Sender: TObject; var Action: TCloseAction);
    procedure ADReglasNegocioCalcFields(DataSet: TDataSet);
    procedure UniFormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    FRutaFichero:String;
    procedure GrabarDatos;
  public
    { Public declarations }
    FADS:array of TDataSet;
    FAP:array of Pointer;
    FADefinicion:array of String;
    FRN:TDataSet;
    constructor Crear(Formulario:TUniForm;ADS:array of TDataSet;AP:array of Pointer;ADefinicion:array of String;RN:TFDDataSet);
  end;
  TProcedimientoCambio = procedure of object;

  procedure Cambio(Campo:String;ADS:array of TDataSet;AP:array of Pointer;ADefinicion:array of String;RN:TFDDataSet;Filtro:String='';Nodos:TFDMemTable=nil;IDPadre:Integer=-1);
  function CompilaScript(Campo,Script:String;PADS:array of TDataSet;PAP:array of Pointer;PADefinicion:array of String;MuestraMensaje:Boolean=False):TPSPascalCompilerH;
  function ScriptOnUses(Sender:TPSPascalCompiler; const Name:AnsiString): Boolean;
  function Consulta(Conexion,Consulta:String):TDataSet;
  procedure Libera(DS:TDataSet);

implementation

uses
  uniGUIApplication, StrUtils, uniGUIDialogs, Math, DateUtils;

{$R *.dfm}


{ TFrmEditorReglasNegocio }

procedure TFrmEditorReglasNegocio.ADReglasNegocioAfterDelete(DataSet: TDataSet);
begin
  GrabarDatos;
end;

procedure TFrmEditorReglasNegocio.ADReglasNegocioAfterPost(DataSet: TDataSet);
begin
  GrabarDatos;
end;

procedure TFrmEditorReglasNegocio.ADReglasNegocioCalcFields(DataSet: TDataSet);
begin
  ADReglasNegocioCALCULO_S.AsString:=Copy(ReplaceText(ADReglasNegocioCALCULO.AsString,#13#10,''),1,ADReglasNegocioCALCULO_S.Size);
end;

procedure TFrmEditorReglasNegocio.ADReglasNegocioFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  Accept:=((CAMPOS_DATO.KeyValue='') or (Pos(''''+UpperCase(CAMPOS_DATO.KeyValue)+'''',UpperCase(DataSet.FieldByName('CALCULO').AsString))>0)) and
          ((CAMPOS_RESULTADO.KeyValue='') or (Pos(','+UpperCase(CAMPOS_RESULTADO.KeyValue)+',',','+UpperCase(ReplaceText(DataSet.FieldByName('CAMPOS').AsString,' ',''))+',')>0));
end;

procedure TFrmEditorReglasNegocio.ADReglasNegocioNewRecord(DataSet: TDataSet);
begin
  ADReglasNegocioCALCULO.AsString:='Begin'+#13+
                                   'End;';
end;

constructor TFrmEditorReglasNegocio.Crear(Formulario:TUniForm;ADS:array of TDataSet;AP:array of Pointer;ADefinicion:array of String;RN:TFDDataSet);
var
  i,j:Integer;
begin
  inherited create(uniGUIApplication.UniApplication);
  FRutaFichero:=IncludeTrailingPathDelimiter(UniServerModule.FilesFolderPath)+'RN\'+Formulario.Name+'.xml';
  FRN:=RN;
  if FileExists(FRutaFichero) then ADReglasNegocio.LoadFromFile(FRutaFichero,sfXML);
  ADCampos.AppendRecord(['']);
  SetLength(FADS,Length(ADS));
  for i:=0 to Length(ADS)-1 do
  begin
    FADS[i]:=ADS[i];
    for j:=0 to ADS[i].Fields.Count-1 do
      ADCampos.AppendRecord([IfThen(Length(ADS)=1,'',ADS[i].Name+'.')+ADS[i].Fields.Fields[j].FieldName]);
  end;
  SetLength(FAP,length(AP));
  SetLength(FADefinicion,length(ADefinicion));
  for i:=0 to Length(AP)-1 do
  begin
    FAP[i]:=AP[i];
    FADefinicion[i]:=ADefinicion[i];
  end;
  CAMPOS_DATO.KeyValue:='';
  CAMPOS_RESULTADO.KeyValue:='';
  Caption:='Editor de reglas de negocio ('+Formulario.Caption+')';
end;

procedure TFrmEditorReglasNegocio.DSReglasNegocioDataChange(Sender: TObject;
  Field: TField);
begin
  if not Assigned(Field) then
    CODIGO_FUENTE.Lines.Text:=ADReglasNegocioCALCULO.AsString;
end;

procedure TFrmEditorReglasNegocio.Filtrar(Sender: TObject);
var
  Filtro,CampoDato,CampoResultado:String;
function EliminaNombreTabla(Campo:String):String;
var
  i:Integer;
begin
  Result:=UpperCase(Campo);
  i:=Pos('.',Result);
  if i>0 then
    Delete(Result,1,i);
end;
begin
  CampoDato:=EliminaNombreTabla(VarToStr(CAMPOS_DATO.KeyValue));
  CampoResultado:=EliminaNombreTabla(VarToStr(CAMPOS_RESULTADO.KeyValue));
  Filtro:=IfThen(CampoDato='','',' AND UPPER(CALCULO) LIKE ''%'''''+UpperCase(CampoDato)+'''''%'''+
                                   IfThen(CampoDato<>CampoResultado,' AND UPPER('',''||CAMPOS||'','') NOT LIKE ''%,'+UpperCase(CampoDato)+',%''',''))+
         IfThen(CampoResultado='','',' AND UPPER('',''||CAMPOS||'','') LIKE ''%,'+UpperCase(CampoResultado)+',%''');
  Delete(Filtro,1,5);
  ADReglasNegocio.Filter:=Filtro;
end;

procedure TFrmEditorReglasNegocio.GrabarDatos;
begin
  if not ADReglasNegocio.IsEmpty then
  begin
    if not DirectoryExists(ExtractFilePath(FRutaFichero)) then
      ForceDirectories(ExtractFilePath(FRutaFichero));
    ADReglasNegocio.SaveToFile(FRutaFichero,sfXML);
  end;
end;

procedure TFrmEditorReglasNegocio.UBAceptarClick(Sender: TObject);
var
  i:integer;
  Mensaje:String;
begin
  if ADReglasNegocio.IsEmpty then
    CODIGO_FUENTE.Lines.Clear
  else if ADReglasNegocio.Modified or (ADReglasNegocioCALCULO.AsString<>CODIGO_FUENTE.Lines.Text) then
  begin
    if not (ADReglasNegocio.State in dsEditModes) then
    begin
      DSReglasNegocio.OnDataChange:=nil;
      try
        ADReglasNegocio.Edit;
      finally
        DSReglasNegocio.OnDataChange:=DSReglasNegocioDataChange;
      end;
    end;
    ADReglasNegocioCALCULO.AsString:=CODIGO_FUENTE.Lines.Text;
    CompilaScript('',CODIGO_FUENTE.Lines.Text,FADS,FAP,FADefinicion,True).Free;
    ADReglasNegocio.Post;
  end;
end;

procedure TFrmEditorReglasNegocio.UBAnadirClick(Sender: TObject);
begin
  ADReglasNegocio.Append;
end;

procedure TFrmEditorReglasNegocio.UBAnteriorClick(Sender: TObject);
begin
  ADReglasNegocio.Prior;
end;

procedure TFrmEditorReglasNegocio.UBCancelarClick(Sender: TObject);
begin
  ADReglasNegocio.Cancel;
  if ADReglasNegocio.IsEmpty then
    CODIGO_FUENTE.Lines.Clear
  else
    CODIGO_FUENTE.Lines.Text:=ADReglasNegocioCALCULO.AsString;
end;

procedure TFrmEditorReglasNegocio.UBEliminarClick(Sender: TObject);
begin
  if not ADReglasNegocio.IsEmpty then
    ADReglasNegocio.Delete;
end;

procedure TFrmEditorReglasNegocio.UBPrimeroClick(Sender: TObject);
begin
  ADReglasNegocio.First;
end;

procedure TFrmEditorReglasNegocio.UBSalirClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmEditorReglasNegocio.UBSiguienteClick(Sender: TObject);
begin
  ADReglasNegocio.Next;
end;

procedure TFrmEditorReglasNegocio.UBUltimoClick(Sender: TObject);
begin
  ADReglasNegocio.Last;
end;

procedure TFrmEditorReglasNegocio.UniFormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  ADReglasNegocio.Cancel;
  TFDMemTable(FRN).LoadFromFile(FRutaFichero);
  Action:=caFree;
end;

procedure TFrmEditorReglasNegocio.UniFormCreate(Sender: TObject);
var
  i:Integer;
begin
  UniDBGrid1.ForceFit:=True;
  for i:=0 to UniDBGrid1.Columns.Count-1 do
    UniDBGrid1.Columns.Items[i].Menu.MenuEnabled:=False;
  MonitorizarTeclas(Self,[VK_ESCAPE],False);
end;

procedure TFrmEditorReglasNegocio.UniFormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_ESCAPE then
    Close;
end;

function ScriptOnUses(Sender: TPSPascalCompiler;
  const Name: AnsiString): Boolean;
var
  i:Integer;
begin
  if Name = 'SYSTEM' then
  begin
    Sender.AddType('TDateTime', btDouble).ExportName:=True;
    RegisterDatetimeLibrary_C(Sender);
    SIRegister_DB(Sender);
    Sender.AddDelphiFunction('function Euros(paValor: currency): currency');
    Sender.AddDelphiFunction('function Consulta(Conexion,Consulta:String):TDataSet');
    Sender.AddDelphiFunction('procedure Libera(DS:TDataSet)');
    Sender.AddDelphiFunction('function YearOf(const AValue: TDateTime): Word');
    Sender.AddDelphiFunction('function MonthOf(const AValue: TDateTime): Word');
    Sender.AddDelphiFunction('function DayOf(const AValue: TDateTime): Word');
    Sender.AddDelphiFunction('procedure DecodeDate(const DateTime: TDateTime; var Year, Month, Day: Word)');
    Sender.AddDelphiFunction('function EncodeDate(Year, Month, Day: Word): TDateTime');
    Sender.AddDelphiFunction('function FormatDateTime(const Format: string; DateTime: TDateTime): string');
    Sender.AddDelphiFunction('function StrToDate(const S: string): TDateTime');
    for i:=0 to Length(TPSPascalCompilerH(Sender).ADefinicion)-1 do
      Sender.AddDelphiFunction(TPSPascalCompilerH(Sender).ADefinicion[i]);
    for i:=0 to Length(TPSPascalCompilerH(Sender).ADS)-1 do
      AddImportedClassVariable(Sender,TPSPascalCompilerH(Sender).ADS[i].Name,'TDATASET');
    Result:=True;
  end
  else
    Result:=False;
end;

procedure Cambio(Campo:String;ADS:array of TDataSet;AP:array of Pointer;ADefinicion:array of String;RN:TFDDataSet;Filtro:String='';Nodos:TFDMemTable=nil;IDPadre:Integer=-1);
function CamposDependientes(Campo1,Campo2:String):Boolean;
var
  ID:Integer;
  BM:TBookmark;
begin
  Result:=False;
  with TFDMemTable.Create(nil) do
    try
      CloneCursor(Nodos);
      Filter:='CAMPO='+QuotedStr(Campo2);
      Filtered:=True;
      First;
      while not Eof and not Result do
      begin
        BM:=Nodos.GetBookmark;
        try
          Nodos.Locate('ID',VarArrayOf([FieldByName('ID').AsInteger]),[]);
          while not SameText(Nodos.FieldByName('CAMPO').AsString,Campo1) and (Nodos.FieldByName('IDPADRE').AsInteger<>-1) do
            Nodos.Locate('ID',VarArrayOf([Nodos.FieldByName('IDPADRE').AsInteger]),[]);
          Result:=SameText(Nodos.FieldByName('CAMPO').AsString,Campo1);
        finally
          Nodos.GotoBookmark(BM);
        end;
        Next;
      end;
    finally
      Free;
    end;
end;
var
  Exec:TPSExec;
  Compilado:AnsiString;
  CI:TPSRuntimeClassImporter;
  ProcedimientoCambio:TProcedimientoCambio;
  i:Integer;
  CamposResultado,CamposRecursivos:TStringList;
begin
  if Nodos=nil then
  begin
    Nodos:=TFDMemTable.Create(nil);
    Nodos.FieldDefs.Add('ID',ftInteger);
    Nodos.FieldDefs.Add('IDPADRE',ftInteger);
    Nodos.FieldDefs.Add('CAMPO',ftString,40);
    while Nodos.Fields.Count<Nodos.FieldDefs.Count do
      Nodos.FieldDefs.Items[Nodos.Fields.Count].CreateField(Nodos,nil,Nodos.FieldDefs.Items[Nodos.Fields.Count].Name);
    Nodos.CreateDataSet;
    Nodos.AppendRecord([Nodos.RecordCount+1,-1,Campo]);
  end;
  with TFDMemTable.Create(nil) do
    try
      CamposRecursivos:=TStringList.Create;
      try
        CloneCursor(RN,True);
        Filter:='UPPER(CALCULO) LIKE ''%'''''+UpperCase(Campo)+'''''%'' AND '+
                'UPPER('',''||CAMPOS||'','') NOT LIKE ''%,'+UpperCase(Campo)+',%'' '+
                IfThen(Filtro<>'',' AND '+Filtro,'');
        Filtered:=True;
        First;
        while not Eof do
        begin
          CamposResultado:=TStringList.Create;
          try
            CamposResultado.CommaText:=FieldByName('CAMPOS').AsString;
            if Nodos.IsEmpty or not CamposDependientes(Nodos.FieldByName('CAMPO').AsString,CamposResultado.Strings[0]) then
            begin
              with CompilaScript(Campo,FieldByName('CALCULO').AsString,ADS,AP,ADefinicion) do
                try
                  GetOutput(Compilado);
                  CI:=TPSRuntimeClassImporter.Create;
                  try
                    RIRegister_DB(CI);
                    Exec:=TPSExec.Create;
                    try
                      RegisterDateTimeLibrary_R(Exec);

                      for i:=0 to Length(AP)-1 do
                        Exec.RegisterDelphiFunction(AP[i],
                                                    trim(StringReplace(
                                                         StringReplace(trim(copy(ADefinicion[i],1,Pos('(',ADefinicion[i])-1)),'FUNCTION','',[rfIgnoreCase]),
                                                                                                              'PROCEDURE','',[rfIgnoreCase])),cdRegister);
                      Exec.RegisterDelphiFunction(@Euros,'Euros',cdRegister);
                      Exec.RegisterDelphiFunction(@Consulta,'Consulta',cdRegister);
                      Exec.RegisterDelphiFunction(@Libera,'Libera',cdRegister);
                      Exec.RegisterDelphiFunction(@YearOf,'YearOf',cdRegister);
                      Exec.RegisterDelphiFunction(@MonthOf,'MonthOf',cdRegister);
                      Exec.RegisterDelphiFunction(@DayOf,'DayOf',cdRegister);
      //                Exec.RegisterDelphiFunction(@EncodeDate,'EncodeDate',cdRegister);
      //                Exec.RegisterDelphiFunction(@DecodeDate,'DecodeDate',cdRegister);
      //                Exec.RegisterDelphiFunction(@FormatDateTime,'FormatDateTime',cdRegister);
      //                Exec.RegisterDelphiFunction(@StrToDate,'StrToDate',cdRegister);
                      RegisterClassLibraryRuntime(Exec,CI);
                      if Exec.LoadData(Compilado) then
                      begin
                        for i:=0 to Length(ADS)-1 do
                          SetVariantToClass(Exec.GetVarNo(Exec.GetVar(ADS[i].Name)),ADS[i]);
                        ProcedimientoCambio:=TProcedimientoCambio(Exec.GetProcAsMethodN('calcula'));
                        if @ProcedimientoCambio<>nil then
                        begin
                          try
                            ProcedimientoCambio;
                          except
                            UniServerModule.Logger.AddLog('El siguiente código no se ha podido ejecutar: '#13#10+FieldByName('CALCULO').AsString);
                            Raise;
                          end;
                        end;
                      end
                      else begin
                        UniServerModule.Logger.AddLog('El siguiente código no se ha podido cargar: '#13#10+FieldByName('CALCULO').AsString);
                        raise Exception.Create('Error de carga');
                      end;
                    finally
                      FreeAndNil(Exec);
                    end;
                  finally
                    FreeAndNil(CI);
                  end;
                finally
                  Free;
                end;
              while CamposResultado.Count>0 do
              begin
                CamposRecursivos.Add(CamposResultado.Strings[0]);
                CamposResultado.Delete(0);
              end;
            end;
          finally
            FreeAndNil(CamposResultado);
          end;
          Next;
        end;
        while CamposRecursivos.Count>0 do
        begin
          Nodos.AppendRecord([Nodos.RecordCount+1,IDPadre,CamposRecursivos.Strings[0]]);
          Cambio(CamposRecursivos.Strings[0],ADS,AP,ADefinicion,RN,'UPPER('',''||CAMPOS||'','') NOT LIKE ''%,'+UpperCase(Campo)+',%'''+
                                                  IfThen(Filtro<>'',' AND '+Filtro,''),Nodos,Nodos.FieldByName('ID').AsInteger);
          CamposRecursivos.Delete(0);
        end;
      finally
        FreeAndNil(CamposRecursivos);
      end;
    finally
      Free;
    end;
  if IDPadre=-1 then
    FreeAndNil(Nodos)
  else
    Nodos.Locate('ID',VarArrayOf([Nodos.FieldByName('IDPADRE').AsInteger]),[]);
end;

function CompilaScript(Campo,Script:String;PADS:array of TDataSet;PAP:array of Pointer;PADefinicion:array of String;MuestraMensaje:Boolean=False):TPSPascalCompilerH;
var
  Mensaje:String;
  i:Integer;
  ok:Boolean;
begin
  result:=TPSPascalCompilerH.Create;
  with result do
  begin
    SetLength(ADS,Length(PADS));
    for i:=0 to Length(PADS)-1 do
      ADS[i]:=PADS[i];
    SetLength(AP,Length(PAP));
    SetLength(ADefinicion,Length(PADefinicion));
    for i:=0 to Length(PAP)-1 do
    begin
      AP[i]:=PAP[i];
      ADefinicion[i]:=PADefinicion[i];
    end;
    OnUses:=ScriptOnUses;
    ok:=Compile('const campo='''+campo+'''; procedure calcula; '+Script+' begin end.');
    if MuestraMensaje then
      begin
      if not ok then
      begin
        for i:=0 to MsgCount-1 do Mensaje:=Mensaje+IfThen(Mensaje='','',#13)+Msg[i].MessageToString;
        uniGUIDialogs.ShowMessage(Mensaje);
      end
      else
        uniGUIDialogs.ShowMessage('Compilado OK');
    end;
  end;
end;

function Consulta(Conexion,Consulta:String):TDataSet;
begin
  result:=ConsultaAD(TFDConnection(UniMainModule.FindComponent(Conexion)),Consulta);
end;

procedure Libera(DS:TDataSet);
begin
  DS.Free;
end;

end.
