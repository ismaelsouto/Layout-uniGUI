unit Frm_Browse;


interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, ServerModule, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, uniLabel,
  uniSpeedButton, uniEdit, uniBasicGrid, uniDBGrid, uniButton, uniBitBtn,
  uniToolBar, uniGUIBaseClasses, uniPanel,  uniDBEdit, uniDBComboBox,
  uniComboBox, uniDBLookupComboBox, uniCheckBox, uniDBCheckBox, uniDateTimePicker,
  uniDBDateTimePicker, uniMemo, Dialogs, uniGUIDialogs, Funciones, UniImage,
  uniSpinEdit, Vcl.Forms, FireDAC.DatS, FireDAC.DApt;

type
  TU=class(TUniDBGrid);
  TB = class(TUniButton);
  TBB = class (TUniBitBtn);
  TFrmBrowse = class(TUniForm)
    UniDBGrid1: TUniDBGrid;
    DSVista: TDataSource;
    ADVista: TFDQuery;
    PanelFiltro: TUniPanel;
    ADCamposFiltro: TFDMemTable;
    DSCamposFiltro: TDataSource;
    UBBRestauraFiltro: TUniBitBtn;
    UniToolBar1: TUniToolBar;
    UBAnadir: TUniToolButton;
    UBModificar: TUniToolButton;
    UBSeleccionar: TUniToolButton;
    UBConsultar: TUniToolButton;
    UBEliminar: TUniToolButton;
    UniToolButton4: TUniToolButton;
    UBPrimero: TUniToolButton;
    UBAnterior: TUniToolButton;
    UBSiguiente: TUniToolButton;
    UBUltimo: TUniToolButton;
    UniToolButton9: TUniToolButton;
    UBSalir: TUniToolButton;
    UniToolButton11: TUniToolButton;
    UBImprimir: TUniToolButton;
    Contenedor: TUniPanel;
    UniPanel1: TUniPanel;
    UniPanel2: TUniPanel;
    UniToolBar2: TUniToolBar;
    UBPaginaPrimera: TUniToolButton;
    UBPaginaAnterior: TUniToolButton;
    UBSeparadorPaginas: TUniToolButton;
    UBPaginaSiguiente: TUniToolButton;
    UBUltimaPagina: TUniToolButton;
    UBBFiltrar: TUniBitBtn;
    UniPanelPaginas: TUniPanel;
    LNUMERO_REGISTRO: TUniLabel;
    TOTAL_REGISTROS: TUniFormattedNumberEdit;
    NUMERO_REGISTRO: TUniFormattedNumberEdit;
    LTOTAL_REGISTROS: TUniLabel;
    ADTransaction1: TFDTransaction;
    UBExportarExcel: TUniToolButton;
    procedure UniFormShow(Sender: TObject);
    procedure UBFiltrarClick(Sender: TObject);
    procedure ADVistaAfterScroll(DataSet: TDataSet);
    procedure UniDBGrid1AjaxEvent(Sender: TComponent; EventName: string;
      Params: TUniStrings);
    procedure UniFormCreate(Sender: TObject);
    procedure UniDBGrid1DblClick(Sender: TObject);
    procedure UBModificarClick(Sender: TObject);
    procedure UBPrimeroClick(Sender: TObject);
    procedure UBAnteriorClick(Sender: TObject);
    procedure UBSiguienteClick(Sender: TObject);
    procedure UBSalirClick(Sender: TObject);
    procedure UniFormClose(Sender: TObject; var Action: TCloseAction);
    procedure UBAnadirClick(Sender: TObject);
    procedure UBEliminarClick(Sender: TObject);
    procedure UBPaginaAnteriorClick(Sender: TObject);
    procedure UBPaginaPrimeraClick(Sender: TObject);
    procedure UBPaginaSiguienteClick(Sender: TObject);
    procedure UBImprimirClick(Sender: TObject);
    procedure UBULtimaPaginaClick(Sender: TObject);
    procedure UBUltimoClick(Sender: TObject);
    procedure UBSeleccionarClick(Sender: TObject);
    procedure ADVistaAfterOpen(DataSet: TDataSet);
    procedure UBConsultarClick(Sender: TObject);
    procedure UniFormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure UniDBGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FiltroKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure UBBRestauraFiltroClick(Sender: TObject);
    procedure UniDBGrid1DrawColumnCell(Sender: TObject; ACol, ARow: Integer;
      Column: TUniDBGridColumn; Attribs: TUniCellAttribs);
    procedure UniFormActivate(Sender: TObject);
    procedure UniFormAjaxEvent(Sender: TComponent; EventName: string;
      Params: TUniStrings);
    procedure UBBFiltrarClick(Sender: TObject);
    procedure ADVistaAfterDelete(DataSet: TDataSet);
    procedure ADVistaDeleteError(DataSet: TDataSet; E: EDatabaseError;
      var Action: TDataAction);
    procedure UBExportarExcelClick(Sender: TObject);
    procedure UniDBGrid1TitleClick(Column: TUniDBGridColumn);
  private
    { Private declarations }
    procedure ActualizaDetalles;
    procedure UniDBGrid1AfterLoadPaginaAnterior(Sender: TUniDBGrid);
    procedure UniDBGrid1AfterLoadPaginaSiguiente(Sender: TUniDBGrid);
  public
    { Public declarations }
    FFiltroConstante:String;
    Editor:TUniFormClass;
    FEditorModal:Boolean;
    MiEditor:TUniForm;
    Pagina:Integer;
    procedure Eliminar;Virtual;
    procedure Localizar(Condicion:String;SituarseAjax:boolean=False);
    procedure LocalizarID(ID:Variant);
    procedure BloqueDeDatos(Pag:integer;Scroll:Integer=0);
    constructor Crear(Editor:TUniFormClass;Filtro:String='';Ordenacion:String='';Campo:TField=nil;NombreCampo:String='';CallBack:TProcedimientoH=nil;EditorModal:Boolean=False;SoloLectura:Boolean=False);
    function FiltroAdicional:String;virtual;
    function UltimaPagina:Integer;
    procedure Filtrar; virtual;
    class function Anadir(Editor:TuniFormClass;FrmBrowse:TFrmBrowse=nil;Campo:TField=nil;NombreCampo:String='';CallBack:TProcedimientoH=nil;Mostrar:boolean=True):TUniForm;
    class function Modificar(Editor:TuniFormClass;Filtro:String;FrmBrowse:TFrmBrowse=nil;Campo:TField=nil;NombreCampo:String='';CallBack:TProcedimientoH=nil;Mostrar:boolean=True):TUniForm;Virtual;
    class function Consultar(Editor:TuniFormClass;Filtro:String;FrmBrowse:TFrmBrowse=nil;Campo:TField=nil;NombreCampo:String='';CallBack:TProcedimientoH=nil;Mostrar:boolean=True):TUniForm;Virtual;
  protected
    ImpresionApaisada:Boolean;
    NombreCampoSeleccionado:String;
    FOrdenAnterior:string;
    FCallBack:TProcedimientoH;
    CampoDestinoSeleccion:TField;
    function ObtieneNumeroRegistros:Integer;virtual;
    procedure SituaRegistroVista; virtual;
    procedure AsignaKeyDown(Panel:TUniPanel);
    procedure OrdenarPor(Columna:TUniDBGridColumn); virtual;
    procedure ConfirmarEliminar;virtual;
    function PuedeEliminar:Boolean;virtual;
    procedure RestauraFiltro(Panel:TUniPanel);
    procedure IniciaFiltro;virtual;
    procedure CambiaOrden;virtual;
    procedure AccionesDeSeleccion;virtual;
    procedure AsignaMacros(AD:TFDQuery);virtual;
  end;


implementation


{$R *.dfm}

uses
  uniGUIApplication, StrUtils, Math, uniGuiMainModule, Frm_Dialogo, MainModule;

procedure TFrmBrowse.ActualizaDetalles;
Var
  Lista:TList;
  i:integer;
begin
  Lista:=TList.Create;
  try
    ADVista.GetDetailDataSets(Lista);
    for i:=0 to Lista.Count-1 do
    begin
      if TDataset(Lista.Items[i]).Active then TDataset(Lista.Items[i]).Close;
      TDataset(Lista.Items[i]).Open;
    end;
  finally
    FreeAndNil(Lista);
  end;
end;

procedure TFrmBrowse.ADVistaAfterDelete(DataSet: TDataSet);
begin
  if Assigned(MiEditor) then
    TFrmDialogo(MiEditor).ActualizaDetalles;
end;

procedure TFrmBrowse.ADVistaAfterOpen(DataSet: TDataSet);
begin
  TFDQuery(DataSet).GetNextPacket;
  TFDQuery(DataSet).GetNextPacket;
  ActualizaDetalles;
end;

procedure TFrmBrowse.ADVistaAfterScroll(DataSet: TDataSet);
begin
  if TU(UniDBGrid1).CurrRow=0  then
  begin
    if Pagina>1 then
    begin
      BloqueDeDatos(Pagina-1,TFDQuery(UniDBGrid1.DataSource.DataSet).FetchOptions.RecsMax div 2);
    end;
  end
  else if {TU(UniDBGrid1).CurrRow}TFDQuery(UniDBGrid1.DataSource.DataSet).RecNo=TFDQuery(UniDBGrid1.DataSource.DataSet).FetchOptions.RecsMax then
    BloqueDeDatos(Pagina+1,TFDQuery(UniDBGrid1.DataSource.DataSet).FetchOptions.RecsMax div 2-1);
  NUMERO_REGISTRO.Value:=TFDQuery(UniDBGrid1.DataSource.DataSet).FetchOptions.RecsSkip+UniDBGrid1.DataSource.DataSet.RecNo;
end;

procedure TFrmBrowse.ADVistaDeleteError(DataSet: TDataSet; E: EDatabaseError;
  var Action: TDataAction);
begin
  if (Pos('DUPLICATE VALUE',UpperCase(E.Message))>0) or
     (Pos('PRIMARY OR UNIQUE KEY',UpperCase(E.Message))>0) then
    UniGuiDialogs.ShowMessage('Está intentando grabar un registro duplicado')
  else if (Pos('AT TRIGGER',UpperCase(E.Message))>0) then
    UniGuiDialogs.ShowMessage('La acción que intenta no se puede ejecutar posiblemente por mantener alguna dependencia sobre otra tabla '+#13+#10+E.Message)
  Else
    UniGuiDialogs.ShowMessage(E.Message);
  Action:=daAbort;
end;


class function TFrmBrowse.Anadir(Editor:TuniFormClass;FrmBrowse:TFrmBrowse;Campo:TField;NombreCampo:String;CallBack:TProcedimientoH;Mostrar:Boolean):TUniForm;
var
  evento:TKeyEvent;
begin
  if (FrmBrowse=nil) or ((FrmBrowse.MiEditor=nil) and FrmBrowse.UBAnadir.Visible and FrmBrowse.UBAnadir.Enabled) then
  begin
    if assigned(FrmBrowse) then
    begin
      evento:=FrmBrowse.OnKeyDown;
      FrmBrowse.OnKeyDown:=nil;
    end;
    try
      result:=TUniForm(Editor.NewInstance).Create(uniGUIApplication.UniApplication);
      TFrmDialogo(result).Campo:=Campo;
      TFrmDialogo(result).NombreCampo:=NombreCampo;
      with TFrmDialogo(result) do
      begin
        Estado:=Insertando;
        Browse:=FrmBrowse;
        UniToolButton4.Visible:=False;
        UBPrimero.Visible:=False;
        UBAnterior.Visible:=False;
        UBSiguiente.Visible:=False;
        UBUltimo.Visible:=False;
        UBAceptar.Visible:=True;
        UBCancelar.Visible:=True;
        UniToolButton1.Visible:=False;
        UBSalir.Visible:=False;
        ADCliente.Open;
        ADCliente.Insert;
        if Assigned(FrmBrowse) and CaptionBrowse then
          Caption:=FrmBrowse.Caption;
        Caption:='Añadir - '+Caption+IfThen(Tag=1,' - '+UniMainModule.AdicionCaption,'');
        FCallBack:=CallBack;
        if Mostrar then
        begin
          if not assigned(Browse) or Browse.FEditorModal then
            ShowModal
          else begin
            Browse.Contenedor.Enabled:=False;
            Show;
          end;
        end;
      end;
    finally
      if assigned(FrmBrowse) then FrmBrowse.OnKeyDown:=evento;
    end;
  end;
end;



procedure TFrmBrowse.AsignaKeyDown(Panel: TUniPanel);
var
  i:Integer;
begin
  for i:=0 to Panel.ControlCount-1 do
    if Panel.Controls[i].ClassType=TUniPanel then AsignaKeyDown(TUniPanel(Panel.Controls[i]))
    else if (Panel.Controls[i].ClassType=TUniEdit) and (Panel.Controls[i].Tag<>1) then TUniEdit(Panel.Controls[i]).OnKeyDown:=FiltroKeyDown
    else if (Panel.Controls[i].ClassType=TUniNumberEdit) and (Panel.Controls[i].Tag<>1) then TUniEdit(Panel.Controls[i]).OnKeyDown:=FiltroKeyDown
    else if (Panel.Controls[i].ClassType=TUniDBEdit) and (Panel.Controls[i].Tag<>1) then TUniDBEdit(Panel.Controls[i]).OnKeyDown:=FiltroKeyDown
    else if (Panel.Controls[i].ClassType=TUniDBNumberEdit) and (Panel.Controls[i].Tag<>1) then TUniDBNumberEdit(Panel.Controls[i]).OnKeyDown:=FiltroKeyDown
    else if (Panel.Controls[i].ClassType=TUniDBFormattedNumberEdit) and (Panel.Controls[i].Tag<>1) then TUniDBFormattedNumberEdit(Panel.Controls[i]).OnKeyDown:=FiltroKeyDown
    else if (Panel.Controls[i].ClassType=TUniFormattedNumberEdit) and (Panel.Controls[i].Tag<>1) then TUniFormattedNumberEdit(Panel.Controls[i]).OnKeyDown:=FiltroKeyDown
    else if (Panel.Controls[i].ClassType=TUniComboBox) and (Panel.Controls[i].Tag<>1) then TUniComboBox(Panel.Controls[i]).OnKeyDown:=FiltroKeyDown
    else if (Panel.Controls[i].ClassType=TUniDBComboBox) and (Panel.Controls[i].Tag<>1) then TUniDBComboBox(Panel.Controls[i]).OnKeyDown:=FiltroKeyDown
    else if (Panel.Controls[i].ClassType=TUniDBLookupComboBox) and (Panel.Controls[i].Tag<>1) then TUniDBLookupComboBox(Panel.Controls[i]).OnKeyDown:=FiltroKeyDown
    else if (Panel.Controls[i].ClassType=TUniCheckBox) and (Panel.Controls[i].Tag<>1) then TUniCheckBox(Panel.Controls[i]).OnKeyDown:=FiltroKeyDown
    else if (Panel.Controls[i].ClassType=TUniDBCheckBox) and (Panel.Controls[i].Tag<>1) then TUniDBCheckBox(Panel.Controls[i]).OnKeyDown:=FiltroKeyDown
    else if (Panel.Controls[i].ClassType=TUniDateTimePicker) and (Panel.Controls[i].Tag<>1) then TUniDateTimePicker(Panel.Controls[i]).OnKeyDown:=FiltroKeyDown
    else if (Panel.Controls[i].ClassType=TUniSpinEdit) and (Panel.Controls[i].Tag<>1) then TUniSpinEdit(Panel.Controls[i]).OnKeyDown:=FiltroKeyDown
    else if (Panel.Controls[i].ClassType=TUniDBDateTimePicker) and (Panel.Controls[i].Tag<>1) then TUniDBDateTimePicker(Panel.Controls[i]).OnKeyDown:=FiltroKeyDown;
end;

procedure TFrmBrowse.AsignaMacros(AD: TFDQuery);
begin

end;

procedure TFrmBrowse.BloqueDeDatos(Pag:Integer;Scroll:Integer);
begin
  UniSession.AddJS('ajaxRequest('+UniDBGrid1.JSName+', ''Demanda'', [''RecsSkip='+IntToStr((Pag-1)*TFDQuery(UniDBGrid1.DataSource.DataSet).FetchOptions.RecsMax div 2)+''',''Scroll='+IntToStr(Scroll)+''']);');
end;

procedure TFrmBrowse.UBImprimirClick(Sender: TObject);
begin
  GeneraListado(UniServerModule,UniDBGrid1,Uppercase(caption),[],'',ImpresionApaisada);
end;

class function TFrmBrowse.Consultar(Editor: TuniFormClass; Filtro: String;
  FrmBrowse: TFrmBrowse; Campo: TField; NombreCampo: String;CallBack:TProcedimientoH;Mostrar:Boolean): TUniForm;
var
  evento:TKeyEvent;
begin


  if (FrmBrowse=nil) or ((FrmBrowse.MiEditor=nil) and FrmBrowse.UBConsultar.Visible and FrmBrowse.UBConsultar.Enabled and (FrmBrowse.Editor<>nil) and (not FrmBrowse.UniDBGrid1.DataSource.DataSet.IsEmpty)) then
  begin
    if assigned(FrmBrowse) then
    begin
      evento:=FrmBrowse.OnKeyDown;
      FrmBrowse.OnKeyDown:=nil;
    end;
    try
      result:=TUniForm(Editor.NewInstance).Create(uniGUIApplication.UniApplication);
      TFrmDialogo(result).Campo:=Campo;
      TFrmDialogo(result).NombreCampo:=NombreCampo;
      with TFrmDialogo(result) do
      begin
        Estado:=Consultando;
        Browse:=FrmBrowse;
        UBAceptar.Visible:=False;
        UBCancelar.Visible:=False;
        UBSalir.Visible:=True;
        UniToolButton4.Visible:=False;
        DesactivarControles(UniPanelPrincipal);
        if assigned(FrmBrowse) then
        begin
          ADCliente.MasterSource:=FrmBrowse.DSVista;
          if CaptionBrowse then Caption:=FrmBrowse.Caption;
        end
        else begin
          UBPrimero.Visible:=False;
          UBAnterior.Visible:=False;
          UBSiguiente.Visible:=False;
          UBUltimo.Visible:=False;
          UniToolButton1.Visible:=False;
          ADCliente.MacroByName('FILTRO').AsRaw:=Filtro;
        end;
        ADCliente.Open;
        Caption:='Consultar - '+Caption+IfThen(Tag=1,' - '+UniMainModule.AdicionCaption,'');
        FCallBack:=CallBack;
        if Mostrar then
        begin
          if not assigned(Browse) or Browse.FEditorModal then
            ShowModal
          else begin
            Browse.Contenedor.Enabled:=False;
            Show;
          end;
        end;
      end;
    finally
      if assigned(FrmBrowse) then FrmBrowse.OnKeyDown:=evento;
    end;
  end;
end;

constructor TFrmBrowse.Crear(Editor:TUniFormClass;Filtro:String;Ordenacion:String;Campo:TField;NombreCampo:String;CallBack:TProcedimientoH;EditorModal:Boolean;SoloLectura:Boolean);
begin
  inherited Create(uniGUIApplication.UniApplication);
  FCallBack:=CallBack;
  FEditorModal:=EditorModal;
  Self.Editor:=Editor;
  if (Ordenacion<>'') and (Assigned(TFDQuery(UniDBGrid1.DataSource.DataSet).MacroByName('ORDENACION'))) then
    TFDQuery(UniDBGrid1.DataSource.DataSet).MacroByName('ORDENACION').AsRaw:=Ordenacion;
  if Filtro<>'' then
  begin
    FFiltroConstante:=Filtro;
    TFDQuery(UniDBGrid1.DataSource.DataSet).MacroByName('FILTRO').AsRaw:=FFiltroConstante;
  end;
  Self.CampoDestinoSeleccion:=Campo;
  Self.NombreCampoSeleccionado:=NombreCampo;
  if SoloLectura then
  begin
    UBAnadir.Visible:=False;
    UBModificar.Visible:=False;
    UBEliminar.Visible:=False;
  end;
end;



procedure TFrmBrowse.Eliminar;
var
  Aux:Integer;
begin
  Aux:=TFDQuery(UniDBGrid1.DataSource.DataSet).RecNo;
  try
    TFDQuery(UniDBGrid1.DataSource.DataSet).Delete;
    TFDQuery(UniDBGrid1.DataSource.DataSet).Close;
    TFDQuery(UniDBGrid1.DataSource.DataSet).Open;
    TOTAL_REGISTROS.Value:=TOTAL_REGISTROS.Value-1;
  finally
    TFDQuery(UniDBGrid1.DataSource.DataSet).MoveBy(Aux-TFDQuery(UniDBGrid1.DataSource.DataSet).RecNo);
  end;
end;

procedure TFrmBrowse.ConfirmarEliminar;
begin
  if UBEliminar.Visible and UBEliminar.Enabled and (not TFDQuery(UniDBGrid1.DataSource.DataSet).IsEmpty) and PuedeEliminar then
    Funciones.MessageDlg('¿Eliminar el registro actual?',mtConfirmation,mbYesNo,
                         procedure (Sender: Tcomponent;AResult:Integer)
                         begin
                           if AResult=mrYes then Eliminar;
                         end);
end;

procedure TFrmBrowse.Filtrar;
var
  Filtro:String;
  i:integer;
  e:TDataSetNotifyEvent;
begin
  Filtro:=FiltroAdicional;
  if Filtro<>'' then Filtro:='('+Filtro+')';
  if FFiltroConstante<>'' then
    Filtro:=Filtro+IfThen(Filtro='','',' AND ')+'('+FFiltroConstante+')';
  if ADCamposFiltro.Active then
    for i:=0 to ADCamposFiltro.FieldCount-1 do
    begin
      if ADCamposFiltro.Fields.Fields[i].AsString<>'' then
      begin
        if Filtro<>'' then Filtro:=Filtro+' AND ';
        case ADCamposFiltro.Fields.Fields[i].DataType of
          ftString:if SameText(ADVista.Connection.DriverName,'SQLite') then
                     Filtro:=Filtro+'(UPPER(REPLACE("'+ADCamposFiltro.Fields.Fields[i].FieldName+'",''ñ'',''Ñ'')) LIKE '+QuotedStr('%'+UpperCase(ReplaceText(ADCamposFiltro.Fields.Fields[i].AsString,'ñ','Ñ'))+'%')+')'
                   else
                     Filtro:=Filtro+'(UPPER(REPLACE("'+ADCamposFiltro.Fields.Fields[i].FieldName+'",''ñ'',''Ñ'')) CONTAINING '+QuotedStr(UpperCase(ReplaceText(ADCamposFiltro.Fields.Fields[i].AsString,'ñ','Ñ')))+')';
          ftDate,ftDateTime,ftTimeStamp:Filtro:=Filtro+'("'+ADCamposFiltro.Fields.Fields[i].FieldName+'"='+QuotedStr(FormatDateTime('mm/dd/yyyy',ADCamposFiltro.Fields.Fields[i].AsDateTime))+')';
          ftInteger,ftSmallInt,ftLargeint:Filtro:=Filtro+'("'+ADCamposFiltro.Fields.Fields[i].FieldName+'"='+IntToStr(ADCamposFiltro.Fields.Fields[i].AsInteger)+')';
          ftFloat,ftCurrency,ftFMTBcd,ftBCD:Filtro:=Filtro+'("'+ADCamposFiltro.Fields.Fields[i].FieldName+'"='+ReplaceText(FloatToStr(ADCamposFiltro.Fields.Fields[i].AsFloat),',','.')+')';
        end;
      end;
    end;
  e:=TFDQuery(UniDBGrid1.DataSource.DataSet).AfterScroll;
  TFDQuery(UniDBGrid1.DataSource.DataSet).AfterScroll:=nil;
  try
    if TFDQuery(UniDBGrid1.DataSource.DataSet).Active then
      TFDQuery(UniDBGrid1.DataSource.DataSet).Disconnect;
    TFDQuery(UniDBGrid1.DataSource.DataSet).FetchOptions.RecsSkip:=0;
    TFDQuery(UniDBGrid1.DataSource.DataSet).MacroByName('FILTRO').AsRaw:=IfThen(Filtro='','','('+Filtro+')');
    TFDQuery(UniDBGrid1.DataSource.DataSet).Open;
    if TFDQuery(UniDBGrid1.DataSource.DataSet).Active then
    begin
      TOTAL_REGISTROS.Value:=ObtieneNumeroRegistros;
      NUMERO_REGISTRO.Value:=Min(1,TOTAL_REGISTROS.Value);
    end;
  finally
    TFDQuery(UniDBGrid1.DataSource.DataSet).AfterScroll:=e;
  end;
  Pagina:=1;
end;


function TFrmBrowse.FiltroAdicional: String;
begin
  result:='';
end;

procedure TFrmBrowse.FiltroKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Contenedor.Enabled and (Key=VK_RETURN) then
    UniSession.AddJS(Self.Name+'.form.showMask(''Consultando datos...'');'+#13#10+
                     'ajaxRequest('+Self.Name+'.form,''FILTRAR'',[]);');
end;

procedure TFrmBrowse.IniciaFiltro;
begin

end;

procedure TFrmBrowse.AccionesDeSeleccion;
begin

end;
procedure TFrmBrowse.CambiaOrden;
begin

end;

procedure TFrmBrowse.Localizar(Condicion: String;SituarseAjax:boolean);
var
  RecsSkip:Integer;
  i:Integer;
  DS:TFDQuery;
  Parametros:TUniStrings;
  Parametro:TFDParam;
  ParametrosEntrada:String;
  ad:TFDQuery;
begin

  DS:=TFDQuery(UniDBGrid1.DataSource.DataSet);
  ad:=TFDQuery.Create(nil);
  with ad do
    try
      Connection:=DS.Connection;
      Transaction:=DS.Transaction;
      for i:=0 to DS.Params.Count-1 do
      begin
        if ParametrosEntrada<>'' then ParametrosEntrada:=ParametrosEntrada+',';
        case DS.Params[i].DataType of
          ftInteger:ParametrosEntrada:=ParametrosEntrada+DS.Params[i].Name+' INTEGER=:'+DS.Params[i].Name;
          ftFloat,ftCurrency:ParametrosEntrada:=ParametrosEntrada+DS.Params[i].Name+' DOUBLE PRECISION=:'+DS.Params[i].Name;
          ftDateTime,ftDate,ftTimeStamp:ParametrosEntrada:=ParametrosEntrada+DS.Params[i].Name+' TIMESTAMP=:'+DS.Params[i].Name;
          ftString:ParametrosEntrada:=ParametrosEntrada+DS.Params[i].Name+' VARCHAR('+IntToStr(DS.Params[i].Size)+')=:'+DS.Params[i].Name;
        end;
      end;
      SQL.Text:='EXECUTE BLOCK'+IfThen(ParametrosEntrada<>'','('+ParametrosEntrada+')','')+#13#10+
                'RETURNS(RECSKIP INTEGER)'+#13#10+
                'AS'+#13#10+
                'DECLARE VARIABLE I INTEGER;'+#13#10+
                'BEGIN'+#13#10+
                '  RECSKIP=0;'+#13#10+
                '  FOR SELECT IIF('+Condicion+',1,0) FROM '+
                DS.MacroByName('TABLA').AsRaw+#13#10+
                IfThen(DS.MacroByName('FILTRO').AsRaw<>'','WHERE '+'('+DS.Macros.MacroByName('FILTRO').AsRaw+') OR ('+IfThen(trim(FFiltroConstante)='','','('+FFiltroConstante+') AND ')+'('+Condicion+'))'+#13#10,'')+
                IfThen(DS.MacroByName('ORDENACION').AsRaw<>'','ORDER BY '+DS.MacroByName('ORDENACION').AsRaw+#13#10,'')+
                '  INTO I'+#13#10+
                '  DO BEGIN'+#13#10+
                '  	IF (I=1) THEN'+#13#10+
                '      BREAK;'+#13#10+
                '    ELSE'+#13#10+
                '      RECSKIP=RECSKIP+1;'+#13#10+
                '  END'+#13#10+
                '  SUSPEND;'+#13#10+
                'END;';
      for i:=0 to MacroCount-1 do
        Macros.Items[i].AsRaw:=DS.MacroByName(Macros.Items[i].Name).AsRaw;
      for i:=0 to DS.Params.Count-1 do
      begin
        Parametro:=FindParam(DS.Params.Items[i].Name);
        if Assigned(Parametro) then
          Parametro.Value:=DS.Params.Items[i].Value;
      end;
      Open;
      RecsSkip:=Fields.Fields[0].AsInteger;
    finally
      Free;
    end;
  if SituarseAjax then
    UniSession.AddJS('ajaxRequest('+Self.Name+'.form,''SITUAR'',[''skip='+IntToStr(RecsSkip)+''',''condicion='+ReplaceText(Condicion,'''','\''')+''']);')
  else begin
    Parametros:=TUniStrings.Create;
    try
      Parametros.Values['skip']:=IntToStr(RecsSkip);
      Parametros.Values['condicion']:=Condicion;
      UniFormAjaxEvent(Self,'SITUAR',Parametros);
    finally
      FreeAndNil(Parametros);
    end
  end;

end;

procedure TFrmBrowse.LocalizarID(ID: Variant);
var
  PK:String;
begin
  PK:=CampoPK(ADVista);
  if PK<>'' then
  begin
    ADVista.Close;
    ADVista.FetchOptions.RecsSkip:=0;
    ADVista.Open;
    while (not ADVista.IsEmpty) and (ADVista.FieldByName(PK).Value<>ID) do
    begin
      while (not ADVista.Eof) and (ADVista.FieldByName(PK).Value<>ID) do ADVista.Next;
      if ADVista.Eof then
      begin
        ADVista.Close;
        ADVista.FetchOptions.RecsSkip:=ADVista.FetchOptions.RecsSkip+ADVista.FetchOptions.RecsMax;
        ADVista.Open;
      end;
    end;
    if ADVista.FieldByName(PK).Value<>ID then
    begin
      ADVista.Close;
      ADVista.FetchOptions.RecsSkip:=0;
      ADVista.Open;
    end;
    NUMERO_REGISTRO.Value:=ADVista.FetchOptions.RecsSkip+ADVista.RecNo;
  end;
end;

class function TFrmBrowse.Modificar(Editor: TuniFormClass; Filtro: String; FrmBrowse: TFrmBrowse;
  Campo: TField; NombreCampo: String;CallBack:TProcedimientoH;Mostrar:boolean): TUniForm;
var
  evento:TKeyEvent;
begin
  if (FrmBrowse=nil) or ((FrmBrowse.MiEditor=nil) and FrmBrowse.UBModificar.Visible and FrmBrowse.UBModificar.Enabled and (FrmBrowse.Editor<>nil) and (not FrmBrowse.UniDBGrid1.DataSource.DataSet.IsEmpty)) then
  begin
    if assigned(FrmBrowse) then
    begin
      FrmBrowse.SituaRegistroVista;
      evento:=FrmBrowse.OnKeyDown;
      FrmBrowse.OnKeyDown:=nil;
    end;
    try
      result:=TUniForm(Editor.NewInstance).Create(uniGUIApplication.UniApplication);
      TFrmDialogo(result).Campo:=Campo;
      TFrmDialogo(result).NombreCampo:=NombreCampo;
      with TFrmDialogo(result) do
      begin
        Estado:=Modificando;
        Browse:=FrmBrowse;
        UBAceptar.Visible:=True;
        UBCancelar.Visible:=True;
        UBSalir.Visible:=False;
        UniToolButton1.Visible:=False;
        if assigned(FrmBrowse) then
        begin
          ADCliente.MasterSource:=FrmBrowse.DSVista;
          if CaptionBrowse then Caption:=FrmBrowse.Caption;
        end
        else begin
          UBPrimero.Visible:=False;
          UBAnterior.Visible:=False;
          UBSiguiente.Visible:=False;
          UBUltimo.Visible:=False;
          UniToolButton4.Visible:=False;
          ADCliente.MacroByName('FILTRO').AsRaw:=Filtro;
        end;

        ADCliente.Open;
        ADCliente.Edit;
        Caption:='Modificar - '+Caption+IfThen(Tag=1,' - '+UniMainModule.AdicionCaption,'');
        FCallBack:=CallBack;
        if Mostrar then
        begin
          if not assigned(Browse) or Browse.FEditorModal then
            result.ShowModal
          else begin
            Browse.Contenedor.Enabled:=False;
            Show;
          end;
        end;
      end;
    finally
      if assigned(FrmBrowse) then FrmBrowse.OnKeyDown:=evento;
    end;
  end;
end;

function TFrmBrowse.ObtieneNumeroRegistros: Integer;
begin
  Result:=NumeroRegistros(ADVista,'ORDENACION');
end;

procedure TFrmBrowse.OrdenarPor(Columna:TUniDBGridColumn);
var
  e:TDataSetNotifyEvent;
begin
  if Columna.Field.FieldKind in [fkCalculated,fkInternalCalc] then
  begin
    uniGUIDialogs.ShowMessage('No es posible ordenar por este campo');
  end
  else begin
    e:=TFDQuery(UniDBGrid1.DataSource.DataSet).AfterScroll;
    TFDQuery(UniDBGrid1.DataSource.DataSet).AfterScroll:=nil;
    try
      TFDQuery(UniDBGrid1.DataSource.DataSet).Disconnect;
      TFDQuery(UniDBGrid1.DataSource.DataSet).FetchOptions.RecsSkip:=0;
      FOrdenAnterior:=TFDQuery(UniDBGrid1.DataSource.DataSet).MacroByName('ORDENACION').AsRaw;
      if TFDQuery(UniDBGrid1.DataSource.DataSet).MacroByName('ORDENACION').AsRaw=IfThen(UniDBGrid1.DataSource.Dataset.FieldByName(Columna.FieldName).DataType in [ftString],'UPPER("'+Columna.FieldName+'")','"'+Columna.FieldName+'"')+' DESC' then
        TFDQuery(UniDBGrid1.DataSource.DataSet).MacroByName('ORDENACION').AsRaw:=IfThen(UniDBGrid1.DataSource.Dataset.FieldByName(Columna.FieldName).DataType in [ftString],'UPPER("'+Columna.FieldName+'")','"'+Columna.FieldName+'"')
      else
        TFDQuery(UniDBGrid1.DataSource.DataSet).MacroByName('ORDENACION').AsRaw:=IfThen(UniDBGrid1.DataSource.Dataset.FieldByName(Columna.FieldName).DataType in [ftString],'UPPER("'+Columna.FieldName+'")','"'+Columna.FieldName+'"')+' DESC';
      CambiaOrden;
      TFDQuery(UniDBGrid1.DataSource.DataSet).Open;
    finally
      TFDQuery(UniDBGrid1.DataSource.DataSet).AfterScroll:=e;
    end;
    Pagina:=1;
    NUMERO_REGISTRO.Value:=Min(1,TOTAL_REGISTROS.Value);
  end;
end;

function TFrmBrowse.PuedeEliminar: Boolean;
begin
  result:=true;
end;

procedure TFrmBrowse.RestauraFiltro(Panel:TUniPanel);
var
  i:Integer;
begin
  for i:=0 to Panel.ControlCount-1 do
    if Panel.Controls[i].ClassType=TUniPanel then RestauraFiltro(TUniPanel(Panel.Controls[i]))
    else if Panel.Controls[i].ClassType=TUniEdit then TUniEdit(Panel.Controls[i]).Clear
    else if Panel.Controls[i].ClassType=TUniDBEdit then TUniDBEdit(Panel.Controls[i]).DataSource.Dataset.FieldByName(TUniDBEdit(Panel.Controls[i]).DataField).Clear
    else if Panel.Controls[i].ClassType=TUniDBNumberEdit then TUniDBNumberEdit(Panel.Controls[i]).DataSource.Dataset.FieldByName(TUniDBNumberEdit(Panel.Controls[i]).DataField).Clear
    else if Panel.Controls[i].ClassType=TUniDBFormattedNumberEdit then TUniDBFormattedNumberEdit(Panel.Controls[i]).DataSource.Dataset.FieldByName(TUniDBFormattedNumberEdit(Panel.Controls[i]).DataField).Clear
    else if Panel.Controls[i].ClassType=TUniFormattedNumberEdit then TUniFormattedNumberEdit(Panel.Controls[i]).Clear
    else if ((Panel.Controls[i].ClassType=TUniComboBox) and (Panel.Controls[i].Tag=0)) then TUniComboBox(Panel.Controls[i]).ItemIndex:=0
    else if ((Panel.Controls[i].ClassType=TUniDBComboBox) and (Panel.Controls[i].Tag=0)) then TUniDBComboBox(Panel.Controls[i]).ItemIndex:=0
    else if ((Panel.Controls[i].ClassType=TUniDBLookupComboBox) and (Panel.Controls[i].Tag=0)) then
    begin
      TUniDBLookupComboBox(Panel.Controls[i]).ListSource.DataSet.First;
      TUniDBLookupComboBox(Panel.Controls[i]).KeyValue:=TUniDBLookupComboBox(Panel.Controls[i]).ListSource.DataSet.FieldByName(TUniDBLookupComboBox(Panel.Controls[i]).KeyField).Value
    end
    else if Panel.Controls[i].ClassType=TUniCheckBox then TUniCheckBox(Panel.Controls[i]).Checked:=False
    else if Panel.Controls[i].ClassType=TUniDBCheckBox then TUniDBCheckBox(Panel.Controls[i]).Field.AsString:=TUniDBCheckBox(Panel.Controls[i]).ValueUnchecked
    else if Panel.Controls[i].ClassType=TUniDateTimePicker then TUniDateTimePicker(Panel.Controls[i]).Text:=''
    else if Panel.Controls[i].ClassType=TUniDBDateTimePicker then TUniDBDateTimePicker(Panel.Controls[i]).DataSource.Dataset.FieldByName(TUniDBDateTimePicker(Panel.Controls[i]).DataField).Clear;
  IniciaFiltro;
  UniSession.AddJS(Self.Name+'.form.showMask(''Consultando datos...'');'+#13#10+
                   'ajaxRequest('+Self.Name+'.form,''FILTRAR'',[]);');
end;

procedure TFrmBrowse.SituaRegistroVista;
begin

end;

procedure SituarAlFinal(Dataset:TDataset);
var
  evento:TDataSetNotifyEvent;
begin

end;

procedure TFrmBrowse.UBAnadirClick(Sender: TObject);
begin
  MiEditor:=Anadir(Editor,Self);
end;

procedure TFrmBrowse.UBAnteriorClick(Sender: TObject);
begin
  TFDQuery(UniDBGrid1.DataSource.DataSet).Prior;
end;

procedure TFrmBrowse.UBConsultarClick(Sender: TObject);
begin
  MiEditor:=Consultar(Editor,'',Self);
end;

procedure TFrmBrowse.UBEliminarClick(Sender: TObject);
begin
  ConfirmarEliminar;
end;

procedure TFrmBrowse.UBExportarExcelClick(Sender: TObject);
var
  DS,ad:TFDQuery;
  Campos:String;
  i:Integer;
begin
  Campos:='';
  for i:=0 to UniDBGrid1.Columns.Count-1 do
    if not (UniDBGrid1.Columns.Items[i].Field.FieldKind in [fkCalculated,fkInternalCalc]) then
      Campos:=Campos+IfThen(Campos<>'',',','')+ '"' +UniDBGrid1.Columns.Items[i].FieldName+'"'+' "'+UniDBGrid1.Columns.Items[i].Title.Caption+'"';
  DS:=TFDQuery(UniDBGrid1.DataSource.DataSet);
  ad:=TFDQuery.Create(nil);
  with ad do
    try
      Connection:=DS.Connection;
      Transaction:=DS.Transaction;
      SQL.Text:='SELECT '+Campos+' FROM ('+DS.SQL.Text+')';
      for i:=0 to DS.MacroCount-1 do
        Macros.MacroByName(DS.Macros.Items[i].Name).AsRaw:=DS.Macros.Items[i].AsRaw;
      for i:=0 to DS.Params.Count-1 do
        ParamByName(DS.Params.Items[i].Name).Value:=DS.Params.Items[i].Value;
      AsignaMacros(ad);
      Open;
      ExportarUnaTabla3(ad,'Datos');
    finally
      Free;
    end;
end;

procedure TFrmBrowse.UBFiltrarClick(Sender: TObject);
begin
  UniSession.AddJS(Self.Name+'.form.showMask(''Consultando datos...'');'+#13#10+
                   'ajaxRequest('+Self.Name+'.form,''FILTRAR'',[]);');
end;

procedure TFrmBrowse.UBModificarClick(Sender: TObject);
begin
  MiEditor:=Modificar(Editor,'',Self);
end;

procedure TFrmBrowse.UBPaginaAnteriorClick(Sender: TObject);
begin
  if Pagina<>1 then
    BloqueDeDatos(Pagina-1);
end;


procedure TFrmBrowse.UBPaginaPrimeraClick(Sender: TObject);
begin
  if Pagina<>1 then
    BloqueDeDatos(1);
end;

procedure TFrmBrowse.UBPaginaSiguienteClick(Sender: TObject);
begin
  if TFDQuery(UniDBGrid1.DataSource.DataSet).RecordCount=TFDQuery(UniDBGrid1.DataSource.DataSet).FetchOptions.RecsMax then
    BloqueDeDatos(Pagina+1);
end;

procedure TFrmBrowse.UBPrimeroClick(Sender: TObject);
begin
  if Pagina=1 then
    TFDQuery(UniDBGrid1.DataSource.DataSet).First
  else
    BloqueDeDatos(1);
end;

procedure TFrmBrowse.UBSalirClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TFrmBrowse.UBSeleccionarClick(Sender: TObject);
var
  CampoPK,i:Integer;
begin
  if not (CampoDestinoSeleccion.Dataset.State in dsEditModes) then
    CampoDestinoSeleccion.Dataset.Edit;
  CampoDestinoSeleccion.Value:=TFDQuery(UniDBGrid1.DataSource.DataSet).FieldByName(NombreCampoSeleccionado).Value;
  AccionesDeSeleccion;
  ModalResult:=mrOk;
  Self.Close;
  if assigned(FCallBack) then FCallBack(CampoDestinoSeleccion);
end;

procedure TFrmBrowse.UBSiguienteClick(Sender: TObject);
begin
  TFDQuery(UniDBGrid1.DataSource.DataSet).Next;
end;

function TFrmBrowse.UltimaPagina: Integer;
begin
  result:=max(ceil(ObtieneNumeroRegistros/(TFDQuery(UniDBGrid1.DataSource.DataSet).FetchOptions.RecsMax div 2))-1,1);
end;

procedure TFrmBrowse.UniDBGrid1AfterLoadPaginaAnterior(Sender: TUniDBGrid);
begin

end;

procedure TFrmBrowse.UniDBGrid1AfterLoadPaginaSiguiente(Sender: TUniDBGrid);
begin
  TFDQuery(UniDBGrid1.DataSource.DataSet).GetNextPacket;
  Sender.OnAfterLoad:=nil;
end;

procedure TFrmBrowse.UniDBGrid1AjaxEvent(Sender: TComponent; EventName: string;
  Params: TUniStrings);
var
  PaginaPosterior:Boolean;
  e1,e2:TDataSetNotifyEvent;
begin
  if EventName='Demanda' then
  begin
    e1:=TFDQuery(UniDBGrid1.DataSource.DataSet).AfterScroll;
    TFDQuery(UniDBGrid1.DataSource.DataSet).AfterScroll:=nil;
    try
      PaginaPosterior:=StrToInt(Params.Values['RecsSkip'])=TFDQuery(UniDBGrid1.DataSource.DataSet).FetchOptions.RecsSkip+TFDQuery(UniDBGrid1.DataSource.DataSet).FetchOptions.RecsMax div 2;
      TFDQuery(UniDBGrid1.DataSource.DataSet).Disconnect;
      e2:=TFDQuery(UniDBGrid1.DataSource.DataSet).AfterOpen;
      TFDQuery(UniDBGrid1.DataSource.DataSet).AfterOpen:=nil;
      try
        TFDQuery(UniDBGrid1.DataSource.DataSet).FetchOptions.RecsSkip:=StrToInt(Params.Values['RecsSkip']);
        TFDQuery(UniDBGrid1.DataSource.DataSet).Open;
        TFDQuery(UniDBGrid1.DataSource.DataSet).GetNextPacket;
        if PaginaPosterior then
        begin
          TFDQuery(UniDBGrid1.DataSource.DataSet).MoveBy(StrToInt(Params.Values['Scroll']));
          TUniDBGrid(Sender).OnAfterLoad:=UniDBGrid1AfterLoadPaginaSiguiente;
        end
        else begin
          TFDQuery(UniDBGrid1.DataSource.DataSet).GetNextPacket;
          TFDQuery(UniDBGrid1.DataSource.DataSet).MoveBy(StrToInt(Params.Values['Scroll']));
          TUniDBGrid(Sender).OnAfterLoad:=UniDBGrid1AfterLoadPaginaAnterior;
        end;
      finally
        TFDQuery(UniDBGrid1.DataSource.DataSet).AfterOpen:=e2;
      end;
      Pagina:=TFDQuery(UniDBGrid1.DataSource.DataSet).FetchOptions.RecsSkip div (TFDQuery(UniDBGrid1.DataSource.DataSet).FetchOptions.RecsMax div 2)+1;
      NUMERO_REGISTRO.Value:=TFDQuery(UniDBGrid1.DataSource.DataSet).FetchOptions.RecsSkip+UniDBGrid1.DataSource.DataSet.RecNo;
    finally
      TFDQuery(UniDBGrid1.DataSource.DataSet).AfterScroll:=e1;
    end;
  end
end;

procedure TFrmBrowse.UniDBGrid1DblClick(Sender: TObject);
begin
  if Assigned(CampoDestinoSeleccion) then
    UBSeleccionarClick(UBSeleccionar)
  else if UBModificar.Visible then
    MiEditor:=Modificar(Editor,'',Self)
  else if UBConsultar.Visible then
    MiEditor:=Consultar(Editor,'',Self);
end;

procedure TFrmBrowse.UniDBGrid1DrawColumnCell(Sender: TObject; ACol,
  ARow: Integer; Column: TUniDBGridColumn; Attribs: TUniCellAttribs);
begin
  if (UniDBGrid1.Columns.Count>1) and
      Assigned(TFDQuery(UniDBGrid1.DataSource.DataSet).MacroByName('ORDENACION')) and
     ((Pos('UPPER("'+UpperCase(Column.FieldName)+'")',UpperCase(TFDQuery(UniDBGrid1.DataSource.DataSet).MacroByName('ORDENACION').AsRaw))>0) or
      StartsText(UpperCase('"'+Column.FieldName+'"'),UpperCase(TFDQuery(UniDBGrid1.DataSource.DataSet).MacroByName('ORDENACION').AsRaw)) or
      StartsText(UpperCase('"'+Column.FieldName+'"')+' DESC',UpperCase(TFDQuery(UniDBGrid1.DataSource.DataSet).MacroByName('ORDENACION').AsRaw))) then
    Attribs.Color:=clInfoBk;
end;

procedure TFrmBrowse.UniDBGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Contenedor.Enabled then
  begin
    case Key of
      VK_RETURN:begin
                  if UBModificar.Visible then
                    MiEditor:=Modificar(Editor,'',Self)
                  else if UBSeleccionar.Visible then
                    UBSeleccionarClick(UBSeleccionar)
                  else
                    MiEditor:=Consultar(Editor,'',Self);
               end;
      VK_DELETE:ConfirmarEliminar;
    end
  end
end;

procedure TFrmBrowse.UniDBGrid1TitleClick(Column: TUniDBGridColumn);
begin

  OrdenarPor(Column);
end;

procedure TFrmBrowse.UniFormActivate(Sender: TObject);
begin
  if assigned(MiEditor) then
    MiEditor.BringToFront;
end;

procedure TFrmBrowse.UniFormAjaxEvent(Sender: TComponent; EventName: string;
  Params: TUniStrings);
var
  DS:TFDQuery;
  e:TDataSetNotifyEvent;
begin
  if SameText(EventName,'Situar') then
  begin
    DS:=TFDQuery(UniDBGrid1.DataSource.DataSet);
    e:=DS.AfterScroll;
    DS.AfterScroll:=nil;
    try
      if DS.Active then DS.Disconnect;
      DS.FetchOptions.RecsSkip:=(StrToInt(Params.Values['skip']) div (DS.FetchOptions.RecsMax div 2))*(DS.FetchOptions.RecsMax div 2);
      if trim(DS.Macros.MacroByName('FILTRO').AsRaw)<>'' then
        DS.Macros.MacroByName('FILTRO').AsRaw:='('+DS.Macros.MacroByName('FILTRO').AsRaw+') OR ('+IfThen(trim(FFiltroConstante)='','','('+FFiltroConstante+') AND ')+'('+Params.Values['condicion']+'))';
      DS.Open;
      Pagina:=DS.FetchOptions.RecsSkip div (DS.FetchOptions.RecsMax div 2)+1;
      DS.MoveBy(StrToInt(Params.Values['skip']) mod (DS.FetchOptions.RecsMax div 2));
      TOTAL_REGISTROS.Value:=ObtieneNumeroRegistros;
      NUMERO_REGISTRO.Value:=DS.FetchOptions.RecsSkip+DS.RecNo;
    finally
      DS.AfterScroll:=e;
    end
  end
  else if SameText('move',EventName) and
     assigned(MiEditor) then
    MiEditor.BringToFront
  else if SameText('FILTRAR',EventName) then
  begin
    Filtrar;
    UniSession.AddJS(Self.Name+'.form.hideMask();');
  end;
end;

procedure TFrmBrowse.UniFormClose(Sender: TObject; var Action: TCloseAction);
begin
  ADVista.Close;
  Action:=caFree;
end;

procedure TFrmBrowse.UniFormCreate(Sender: TObject);
var
  i:integer;
begin
  for i:=0 to UniDBGrid1.Columns.Count-1 do
    UniDBGrid1.Columns.Items[I].Sortable:=True;
  ImpresionApaisada:=False;
  ADVista.Transaction:=ADTransaction1;
  ADTransaction1.Connection:=ADVista.Connection;
  if Tag=1 then
    Caption:=Caption+' - '+UniMainModule.AdicionCaption;
  ModalResult:=mrCancel;
  ClientEvents.ExtEvents.Values['window.beforeclose']:='function window.beforeclose(panel, eOpts){return !'+Contenedor.JSName+'.isDisabled();}';
  UniDBGrid1.ForceFit:=True;
  ClientEvents.ExtEvents.Values['window.maximize']:='function window.maximize(sender, eOpts){'+#13#10+
                                                    '  sender.setHeight(sender.getHeight()-'+IntToStr(UniMainModule.DimensionesMax.Top)+');'+#13#10+
                                                    '  sender.setWidth(sender.getWidth()-'+IntToStr(UniMainModule.DimensionesMax.Left)+');'+#13#10+
                                                    '  sender.setPosition('+IntToStr(UniMainModule.DimensionesMax.Left)+','+IntToStr(UniMainModule.DimensionesMax.Top)+');'+#13#10+
                                                    '}';
  AsignaKeyDown(PanelFiltro);
  UniDBGrid1.WebOptions.PageSize:=TFDQuery(UniDBGrid1.DataSource.DataSet).FetchOptions.RecsMax;
  UniDBGrid1.OnAfterLoad:=nil;
  for i:=0 to UniDBGrid1.Columns.Count-1 do
    UniDBGrid1.Columns.Items[i].Menu.MenuEnabled:=False;
  Pagina:=1;
  IniciaFiltro;
  MonitorizarTeclas(Self,[VK_RETURN,VK_ESCAPE],False);
  MonitorizarTeclas(Self,[ord('A'),ord('a'),ord('M'),ord('m'),ord('E'),ord('e')],True);
end;

procedure TFrmBrowse.UniFormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Contenedor.Enabled then
  begin
    if (chr(Key) in ['a','A']) and (ssCtrl in Shift) then MiEditor:=Anadir(Editor,Self)
    else if (chr(Key) in ['m','M']) and (ssCtrl in Shift) then MiEditor:=Modificar(Editor,'',Self)
    else if (Key=VK_DELETE) or (chr(Key) in ['e','E']) and (ssCtrl in Shift) then ConfirmarEliminar
    else if Key=VK_ESCAPE then Close;
  end;
end;

procedure TFrmBrowse.UniFormShow(Sender: TObject);
var
  i:Integer;
begin
  if ADCamposFiltro.Active then
    ADCamposFiltro.Insert;
  if assigned(CampoDestinoSeleccion) then
  begin
    Caption:='Seleccionar - '+Caption;
    UBAnadir.Visible:=False;
    UBModificar.Visible:=False;
    UBEliminar.Visible:=False;
    if Editor=nil then
      UBConsultar.Visible:=False;
  end
  else begin
    UBSeleccionar.Visible:=False;
  end;
  UniSession.AddJS(Self.Name+'.form.showMask(''Consultando datos...'');'+#13#10+
                   'ajaxRequest('+Self.Name+'.form,''FILTRAR'',[]);');
end;

procedure TFrmBrowse.UBBFiltrarClick(Sender: TObject);
begin
  UniSession.AddJS(Self.Name+'.form.showMask(''Consultando datos...'');'+#13#10+
                   'ajaxRequest('+Self.Name+'.form,''FILTRAR'',[]);');
end;

procedure TFrmBrowse.UBBRestauraFiltroClick(Sender: TObject);
begin
  RestauraFiltro(PanelFiltro);
end;

procedure TFrmBrowse.UBULtimaPaginaClick(Sender: TObject);
begin
  BloqueDeDatos(UltimaPagina);
end;

procedure TFrmBrowse.UBUltimoClick(Sender: TObject);
var
  Pagina:Integer;
begin
  Pagina:=UltimaPagina;
  if Pagina<>Self.Pagina then
    BloqueDeDatos(Pagina,TFDQuery(UniDBGrid1.DataSource.DataSet).FetchOptions.RecsMax-1)
  else
    TFDQuery(UniDBGrid1.DataSource.DataSet).Last;
end;

end.
