unit Frm_Dialogo;


interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Dialogs, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, uniGUIBaseClasses,
  uniEdit, uniDBEdit, uniButton, uniBitBtn, uniToolBar, uniPanel,
  uniLabel, Funciones, Frm_Browse, UniGuiDialogs, Vcl.Forms, FireDAC.DatS,
  FireDAC.DApt;

type
  TEstado=(Consultando,Insertando,Modificando,SinEstado);
  TFrmDialogo = class(TUniForm)
    ADCliente: TFDQuery;
    DSCliente: TDataSource;
    UniPanelPrincipal: TUniPanel;
    UniToolBar1: TUniToolBar;
    UBAceptar: TUniToolButton;
    UBCancelar: TUniToolButton;
    UBSalir: TUniToolButton;
    UniToolButton4: TUniToolButton;
    UBPrimero: TUniToolButton;
    UBAnterior: TUniToolButton;
    UBSiguiente: TUniToolButton;
    UBUltimo: TUniToolButton;
    UniToolButton1: TUniToolButton;
    procedure UniFormClose(Sender: TObject; var Action: TCloseAction);
    procedure UBPrimeroClick(Sender: TObject);
    procedure UBAnteriorClick(Sender: TObject);
    procedure UBSiguienteClick(Sender: TObject);
    procedure UBAceptarClick(Sender: TObject);
    procedure UBCancelarClick(Sender: TObject);
    procedure UniFormCreate(Sender: TObject);
    procedure UBUltimoClick(Sender: TObject);
    procedure UBSalirClick(Sender: TObject);
    procedure UniFormShow(Sender: TObject);
    procedure UniFormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ADClienteAfterGetRecord(DataSet: TFDDataSet);
    procedure UniFormAjaxEvent(Sender: TComponent; EventName: string;
      Params: TUniStrings);
    procedure UBAceptarAjaxEvent(Sender: TComponent; EventName: string;
      Params: TUniStrings);
    procedure ADClienteAfterInsert(DataSet: TDataSet);
    procedure DatasetReconcileError(DataSet: TFDDataSet; E: EFDException;
      UpdateKind: TFDDatSRowState; var Action: TFDDAptReconcileAction);
  private
    { Private declarations }
    Detalles:array of TFDDataSet;
    procedure Cancelar;
    procedure ConfirmacionCancelacion(Sender: Tcomponent;AResult:Integer);
    procedure SetBrowse(const Value: TFrmBrowse);
  protected
    FSeguirAnadiendo:Boolean;
    FControlDeClave:TUniControl;
    FMensajeDeClave:string;
    FBrowse:TFrmBrowse;
    function Modificado:Boolean;
    function EstaModificado:Boolean;virtual;
    function FiltroRegistroActual:String;Virtual;
    function EjecutarAceptar:Boolean;virtual;
    procedure ProcesosDespuesdeCancelar; virtual;
    function ProcesosDespuesdeGrabar(Modo:TUpdateStatus):boolean; virtual;
    procedure ProcesoDespuesDeLocalizar; virtual;
    procedure ProcesoAntesDeLocalizar; virtual;
    function PermitirLocalizar:boolean; virtual;
    function AntesdeGrabar:boolean; virtual;
    function CancelacionPersonalizada:boolean; virtual;
    function AceptacionPersonalizada:boolean; virtual;
    function LocalizarPorEliminacion:boolean; virtual;
    procedure MensajeDeClave(mensaje:string); virtual;
  public
    { Public declarations }
    ModificaCaption:String;
    Muestra,AdicionCaption,CaptionBrowse:Boolean;
    Estado:TEstado;
    Campo:TField;
    FCallBack:TProcedimientoH;
    NombreCampo:String;
    ComponenteAActualizar:TUniComponent;
    property Browse:TFrmBrowse read FBrowse write SetBrowse;
    function Guardar(Localizar:Boolean=True):Boolean;
    procedure AddListaDetalles(Detalle:TFDDataSet);
    procedure AbrirDetalles;
    procedure ActualizaDetalles;Virtual;
    procedure AnulaListaDeDetalles;
    procedure RefrescaRegistro;
  end;

implementation

uses
  uniGUIApplication, StrUtils;

{$R *.dfm}


{ TFrmDialogo }

procedure TFrmDialogo.AbrirDetalles;
var
  i:integer;
begin
  for i := 0 to length(Detalles)-1 do
  begin
    if Assigned(Detalles[i].MasterSource) and
       Assigned(Detalles[i].MasterSource.DataSet) and
       (not Detalles[i].MasterSource.DataSet.Active) then
      Detalles[i].MasterSource.DataSet.Open;
    if Detalles[i].Active then Detalles[i].Close;
    Detalles[i].Open;
  end;
end;

function TFrmDialogo.AceptacionPersonalizada: boolean;
begin
  Result:=true;
end;

procedure TFrmDialogo.ActualizaDetalles;
var
  i:Integer;
begin
  for i:=0 to length(Detalles)-1 do
    if not Detalles[i].Active then
      Detalles[i].Open;
end;

procedure TFrmDialogo.ADClienteAfterGetRecord(DataSet: TFDDataSet);
begin
  ActualizaDetalles;
end;

procedure TFrmDialogo.ADClienteAfterInsert(DataSet: TDataSet);
begin
  ActualizaDetalles;
end;


procedure TFrmDialogo.DatasetReconcileError(DataSet: TFDDataSet;
  E: EFDException; UpdateKind: TFDDatSRowState;
  var Action: TFDDAptReconcileAction);
var
  clave:Boolean;
  msg:String;
begin
  clave:=False;
  if (Pos('DUPLICATE VALUE',UpperCase(E.Message))>0) or
     (Pos('PRIMARY OR UNIQUE KEY',UpperCase(E.Message))>0) then
  begin
    msg:='Está intentando grabar un registro duplicado';
    clave:=True;
  end
  else if (Pos('AT TRIGGER',UpperCase(E.Message))>0) then
    msg:='La acción que intenta no se puede ejecutar posiblemente por mantener alguna dependencia sobre otra tabla '+#13+#10+E.Message
  Else
    msg:=E.Message;


  if clave then
  begin
    if Assigned(FControlDeClave) then
      UniGuiDialogs.ShowMessage(msg+#13+#10+FMensajeDeClave,
                                           procedure (Sender: Tcomponent;AResult: Integer)
                                           begin
                                             if FControlDeClave.CanFocus then
                                               FControlDeClave.SetFocus;
                                           end)
    Else
      UniGuiDialogs.ShowMessage(msg);
  end
  Else
    UniGuiDialogs.ShowMessage(msg);

  Action:=raCorrect;
end;

procedure TFrmDialogo.AddListaDetalles(Detalle:TFDDataSet);
var
  i:Integer;
begin
  i:=0;
  while (i<length(Detalles)) and (Detalles[i]<>Detalle) do Inc(i);
  if i=length(Detalles) then
  begin
    SetLength(Detalles,length(Detalles)+1);
    Detalles[length(Detalles)-1]:=Detalle;
    Detalles[length(Detalles)-1].OnReconcileError:=DatasetReconcileError;
  end;
end;

function TFrmDialogo.AntesdeGrabar:boolean;
begin
  result:=True;
end;

procedure TFrmDialogo.AnulaListaDeDetalles;
begin
  SetLength(Detalles,0);
end;

function TFrmDialogo.CancelacionPersonalizada: boolean;
begin
  result:=True;
end;

procedure TFrmDialogo.Cancelar;
var
  i:integer;
begin
  for i := 0 to High(Detalles) do
    if Assigned(Detalles[i]) then
    begin
      Detalles[i].Cancel;
      if Detalles[i].CachedUpdates and (Detalles[i].ChangeCount>0) then Detalles[i].CancelUpdates;
    end;
  ADCliente.Cancel;
  if ADCliente.CachedUpdates and (ADCliente.ChangeCount>0) then ADCliente.CancelUpdates;
  if assigned(campo) then
  begin
    if not (Campo.Dataset.State in dsEditModes) then
      Campo.Dataset.Edit;
    Campo.Clear;
  end;
end;

procedure TFrmDialogo.ConfirmacionCancelacion(Sender: Tcomponent;AResult: Integer);
begin
  if AResult=mrYes then
  begin
    Cancelar;
    ProcesosDespuesDeCancelar;
    Close;
  end;
end;


function TFrmDialogo.EjecutarAceptar: Boolean;
begin
  result:=True;
end;

function TFrmDialogo.EstaModificado: Boolean;
begin
  result:=False;
end;

function TFrmDialogo.FiltroRegistroActual: String;
var
  i:Integer;
begin
  //Localizamos el registro que acabamos de insertar
  Result:='';
  for i:=0 to ADCliente.Fields.Count-1 do
    if pfInKey in ADCliente.Fields.Fields[i].ProviderFlags then
    begin
      if Result<>'' then Result:=Result+' AND ';
      if ADCliente.Fields.Fields[i].IsNull then
        Result:=Result+(ADCliente as IProviderSupport).PSGetTableName+'.'+ADCliente.Fields.Fields[i].FieldName+' IS NULL'
      else begin
        Result:=Result+(ADCliente as IProviderSupport).PSGetTableName+'.'+ADCliente.Fields.Fields[i].FieldName+'=';
        case ADCliente.Fields.Fields[i].DataType of
          ftString:Result:=Result+QuotedStr(ADCliente.Fields.Fields[i].AsString);
          ftDate,ftDateTime,ftTimeStamp:Result:=Result+QuotedStr(FormatDateTime('mm/dd/yyyy',ADCliente.Fields.Fields[i].AsDateTime));
          ftFloat,ftCurrency,ftFMTBcd:Result:=Result+Replacetext(FloatToStr(ADCliente.Fields.Fields[i].AsFloat),',','.');
         else
          Result:=Result+ADCliente.Fields.Fields[i].AsString;
        end;
      end;
    end;
end;

function TFrmDialogo.Guardar(Localizar:Boolean):Boolean;
var
  i:integer;
  Modo:TUpdateStatus;
  Filtro:String;
begin

  Result:=AntesDeGrabar;
  if EstaModificado or (not ADCliente.CachedUpdates) or Modificado then
  begin
    if Result then
    begin
      //Primero se graba la tabla maestra
      ADCLiente.CheckBrowseMode;
      Modo:=ADCliente.UpdateStatus;
      if ADCliente.CachedUpdates and (ADCliente.ChangeCount>0) then
      begin
        result:=ADCliente.ApplyUpdates(0)=0;
        ADCliente.CommitUpdates;
      end;
      if result then
      begin
        i:=0;
        while result and (i<length(Detalles)) do
        begin
          Detalles[i].CheckBrowseMode;
          if Detalles[i].CachedUpdates and (Detalles[i].ChangeCount>0) then
          begin
            result:=Detalles[i].ApplyUpdates(0)=0;
            if result then
              Detalles[i].CommitUpdates;
          end;
          Inc(i);
        end;
        if result then
        begin
          result:=ProcesosDespuesDeGrabar(Modo);
          if Localizar and PermitirLocalizar then
          begin
            if assigned(FBrowse) and
              (((EstaModificado or (not (Modo in [usUnmodified,usDeleted]))) and (not ADCliente.CachedUpdates or EstaModificado or (Modo in [usInserted,usModified])))
              or LocalizarPorEliminacion) then
              begin
                ProcesoAntesDeLocalizar;
                FBrowse.Localizar(FiltroRegistroActual,True);
                ProcesoDespuesDeLocalizar;
              end;
          end;
        end;
      end;
    end
  end;
  if Result and assigned(campo) then
  begin
    if not (Campo.Dataset.State in dsEditModes) then
      Campo.Dataset.Edit;
    Campo.Value:=ADCliente.FieldByName(NombreCampo).Value;
  end;
  if result and assigned(FCallBack) then FCallBack(Campo);
end;

function TFrmDialogo.LocalizarPorEliminacion: boolean;
begin
  Result:=False;
end;

procedure TFrmDialogo.MensajeDeClave(mensaje: string);
begin
  UniGuiDialogs.ShowMessage(mensaje);
end;

function TFrmDialogo.Modificado: Boolean;
var
  i:integer;
begin

  Result:=ADCliente.Modified or (ADCliente.ChangeCount>0);
  i:=0;
  while (not result) and (i<length(Detalles)) do
  begin
    result:=Assigned(Detalles[i]) and Detalles[i].Active and
            ((Detalles[i].ChangeCount>0) or
             Detalles[i].Modified);
    i:=i+1;
  end;
end;


function TFrmDialogo.PermitirLocalizar: boolean;
begin
  Result:=True;
end;

procedure TFrmDialogo.ProcesoAntesDeLocalizar;
begin

end;

procedure TFrmDialogo.ProcesoDespuesDeLocalizar;
begin

end;

procedure TFrmDialogo.ProcesosDespuesdeCancelar;
begin

end;

function TFrmDialogo.ProcesosDespuesdeGrabar(Modo: TUpdateStatus):boolean;
begin
  result:=True;
end;

procedure TFrmDialogo.RefrescaRegistro;
begin
  if Assigned(Browse) and
     Assigned(ADCLiente.MasterSource) then
  begin
    ADCliente.MasterSource:=nil;
    try
      Browse.Localizar(FiltroRegistroActual);
    finally
      ADCLiente.MasterSource:=Browse.DSVista;
    end;
  end;
  ADCliente.Refresh;
end;

procedure TFrmDialogo.SetBrowse(const Value: TFrmBrowse);
begin
  FBrowse := Value;
end;

procedure TFrmDialogo.UBAceptarAjaxEvent(Sender: TComponent; EventName: string;
  Params: TUniStrings);
begin
  if SameText(EventName,'FOCUS') then
    UniSession.AddJS('ajaxRequest('+Self.Name+'.form,''ACEPTAR'',[]);');
end;

procedure TFrmDialogo.UBAceptarClick(Sender: TObject);
var
  aceptarcambios: boolean;
begin

  aceptarcambios:=AceptacionPersonalizada;
  if aceptarcambios then
  begin
    if Guardar then
    begin
      if FSeguirAnadiendo then
        ADCliente.Insert
      else
        ModalResult:=mrOk;
    end;
  end;
end;

procedure TFrmDialogo.UBAnteriorClick(Sender: TObject);
var
  ds: TDataSource;
begin
  if Guardar(False) then
  begin
//    ADCliente.Close;
//    try
      FBrowse.UBAnteriorCLick(Sender);
      ProcesoAntesDeLocalizar;
      ds:=ADCliente.MasterSource;
      ADCliente.MasterSource:=nil;
      try
        FBrowse.Localizar(FiltroRegistroActual);
      finally
        ADCliente.MasterSource:=ds;
      end;
      ProcesoDespuesDeLocalizar;
      UBAnterior.SetFocus;
//    finally
//      ADCliente.Open;
//    end;
  end;
end;

procedure TFrmDialogo.UBCancelarClick(Sender: TObject);
var
  cancelarcambios: boolean;
begin
  cancelarcambios:=CancelacionPersonalizada;
  if cancelarcambios  then
  begin
    if not UBCancelar.Focused then UBCancelar.SetFocus;
    if not Modificado then
      Close
    else
      Funciones.MessageDlg('¿Abandonar los cambios realizados?',mtConfirmation,mbYesNo,ConfirmacionCancelacion);
    end;
end;

procedure TFrmDialogo.UBPrimeroClick(Sender: TObject);
var
  ds: TDataSource;
begin
  if Guardar(False) then
  begin
//    //Se cierra y se abre el Query
//    ADCliente.Close;
//    try
      FBrowse.UBPrimeroClick(Sender);
      ProcesoAntesDeLocalizar;
      ds:=ADCliente.MasterSource;
      ADCliente.MasterSource:=nil;
      try
        FBrowse.Localizar(FiltroRegistroActual);
      finally
        ADCliente.MasterSource:=ds;
      end;
      ProcesoDespuesDeLocalizar;
      UBPrimero.SetFocus;
//    finally
//      ADCliente.Open;
//    end;
  end;
end;

procedure TFrmDialogo.UBSalirClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmDialogo.UBSiguienteClick(Sender: TObject);
var
  ds: TDataSource;
begin

  if Guardar(False) then
  begin
    //Se cierra y se abre el Query
//    ADCliente.Close;
//    try
      FBrowse.UBSiguienteClick(Sender);
      ProcesoAntesDeLocalizar;
      ds:=ADCliente.MasterSource;
      ADCliente.MasterSource:=nil;
      try
        FBrowse.Localizar(FiltroRegistroActual);
      finally
        ADCliente.MasterSource:=ds;
      end;
      ProcesoDespuesDeLocalizar;
      UBSiguiente.SetFocus;
//    finally
//      ADCliente.Open;
//    end;
  end;
end;

procedure TFrmDialogo.UBUltimoClick(Sender: TObject);
var
  ds: TDataSource;
begin
  if Guardar(False) then
  begin
    //Se cierra y se abre el Query
//    ADCliente.Close;
//    try
      FBrowse.UBUltimoClick(Sender);
      ProcesoAntesDeLocalizar;
      ds:=ADCliente.MasterSource;
      ADCliente.MasterSource:=nil;
      try
        FBrowse.Localizar(FiltroRegistroActual);
      finally
        ADCliente.MasterSource:=ds;
      end;

      ProcesoDespuesDeLocalizar;
      UBUltimo.SetFocus;
//    finally
//      ADCliente.Open;
//    end;
  end;
end;

procedure TFrmDialogo.UniFormAjaxEvent(Sender: TComponent; EventName: string;
  Params: TUniStrings);
begin
  if SameText(EventName,'ACEPTAR') then
    UBAceptarClick(nil)
  else if SameText(EventName,'SALIR') then
end;

procedure TFrmDialogo.UniFormClose(Sender: TObject; var Action: TCloseAction);
var
  i:integer;
begin
  if not Modificado then
  begin
    if assigned(FBrowse) then
    begin
      FBrowse.Contenedor.Enabled:=True;
      FBrowse.MiEditor:=nil;
    end;
    for i:=0 to Length(Detalles)-1 do Detalles[i].Close;
    ADCliente.Close;
    Action:=caFree;
  end
  else begin
    Funciones.MessageDlg('¿Abandonar los cambios realizados?',mtConfirmation,mbYesNo,ConfirmacionCancelacion);
    Action:=caNone;
  end;
end;

procedure TFrmDialogo.UniFormCreate(Sender: TObject);
begin
  CaptionBrowse:=True;
  FSeguirAnadiendo:=False;
  ModalResult:=mrCancel;
  MonitorizarTeclas(Self,[VK_ESCAPE,VK_RETURN],False);
  Estado:=SinEstado;
end;


procedure TFrmDialogo.UniFormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Enabled then
  case Key of
    VK_RETURN:if EjecutarAceptar then
              begin
                if UBAceptar.Visible then
                  UniSession.AddJS(UBAceptar.JSName+'.focus();'+#13+
                                   'ajaxRequest('+UBAceptar.JSName+',''FOCUS'',[]);')
                else if UBSalir.Visible then
                  UBSalirClick(nil);
              end;
    VK_ESCAPE:UBCancelarClick(nil);
  end;
end;

procedure TFrmDialogo.UniFormShow(Sender: TObject);
begin
  if Assigned(FBrowse) then
    ClientEvents.ExtEvents.Values['window.activate']:='function window.activate(sender, eOpts){'+#13+
                                                      '  '+FBrowse.Name+'.window.suspendEvent(''activate'');'+#13+
                                                      '  '+Self.Name+'.window.suspendEvent(''activate'');'+#13+
                                                      '  try{'+#13+
                                                      '    '+FBrowse.Name+'.window.toFront(false);'+#13+
                                                      '    '+Self.Name+'.window.toFront(false);'+#13+
                                                      '  }finally{'+#13+
                                                      '    '+Self.Name+'.window.resumeEvent(''activate'');'+#13+
                                                      '    '+FBrowse.Name+'.window.resumeEvent(''activate'');'+#13+
                                                      '  }'+#13+
                                                      '}';
end;

end.

