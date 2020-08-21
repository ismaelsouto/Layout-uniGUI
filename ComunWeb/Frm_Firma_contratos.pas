unit Frm_Firma_contratos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, Data.DBXFirebird, uniBasicGrid, uniDBGrid,
  uniLabel, uniDBText, Data.DB,FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.Phys.Intf, FireDAC.DApt.Intf,FireDAC.DatS, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Provider, Datasnap.DBClient,  SqlExpr, uniPanel,
  uniPageControl, encddecd, uniGroupBox, uniEdit, uniMemo, uniDBEdit,
  uniToolBar,  uniButton, uniBitBtn, Vcl.Menus, uniMainMenu, uniMultiItem, uniComboBox,
  uniImageList, Vcl.ComCtrls, uniDateTimePicker, dateUtils, uniDBComboBox,
  uniDBLookupComboBox,  uniGUITypes, uniGUIAbstractClasses,   uniGUIClasses, uniGUIForm, uniGUIBaseClasses,
  uniGUIRegClasses, uniGUIDialogs, sbencoding, IdMessage, IdText,  IdSMTP,
  IdBaseComponent, strUtils, IdFTP,IdFTPList,IdFTPListTypes,IdFTPCommon,idallftplistparsers,
  uniCheckBox,uniScreenMask,IdExplicitTLSClientServerBase,IdSSLOpenSSL,
  Frm_Visor_Contrato, dxGDIPlusClasses, uniImage, FireDAC.Stan.Async,
  FireDAC.DApt, FireDAC.UI.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Phys, FireDAC.VCLUI.Wait, FireDAC.Phys.FB, FireDAC.Phys.FBDef;
type
  TFrmFirmaContratos = class(TUniForm)
    DataSource1: TDataSource;
    UniPanel2: TUniPanel;
    UniLabel1: TUniLabel;
    mensaje: TIdMessage;
    ADMemTable1: TFDMemTable;
    ADMemTable1DOCUMENTO: TStringField;
    ADMemTable1FIRMADO: TStringField;
    UniScreenMaskBorrar: TUniScreenMask;
    UniPanel1: TUniPanel;
    UniPanel3: TUniPanel;
    UniPanel4: TUniPanel;
    ADMemTable1RUTA: TStringField;
    UniImage1: TUniImage;
    ADMemTable1CONTRATO: TBlobField;
    ADMemTable1INTERNO: TIntegerField;
    ADMemTable1HASHSHA256: TStringField;
    ADMemTable1EMPRESA: TIntegerField;
    ADMemTableRepresentante: TFDMemTable;
    ADMemTableRepresentanteNOMBRE: TStringField;
    ADMemTableRepresentanteNIF: TStringField;
    ADMemTableRepresentanteCARGO: TStringField;
    ADMemTable1TIPO_FIRMA: TStringField;
    ADQuery1: TFDQuery;
    ADQueryBlob: TFDQuery;
    Conexion: TFDConnection;
    UniDBGrid1: TUniDBGrid;
    ADMemTable1FECHA_TOPE: TDateField;
    procedure UniFormAjaxEvent(Sender: TComponent; EventName: string;
      Params: TUniStrings);
    procedure UniFormReady(Sender: TObject);
    procedure UniDBGrid1CellClick(Column: TUniDBGridColumn);
    procedure UniDBGrid1DrawColumnCell(Sender: TObject; ACol, ARow: Integer;
      Column: TUniDBGridColumn; Attribs: TUniCellAttribs);
    procedure UniDBGrid1AfterLoad(Sender: TUniDBGrid);
    procedure ADMemTableRepresentanteNIFChange(Sender: TField);
    procedure UniFormClose(Sender: TObject; var Action: TCloseAction);
  private
    Fpasar_parametro_programa: string;
    function ExtractUrlFileName(const AUrl: string): string;
    procedure AbreVisor(consultando: Boolean);
    procedure Setpasar_parametro_programa(const Value: string);

  public
    Permitir_continuar: boolean;
    Mensaje_cerrar,Licencia,disco,equipo,usu,so,tipo: string;
    property pasar_parametro_programa: string read Fpasar_parametro_programa write Setpasar_parametro_programa;
  end;

function FrmFirmaContratos: TFrmFirmaContratos;

implementation

{$R *.dfm}

uses
  uniGUIVars, MainModule, uniGUIApplication, ServerModule,Frm_VisorHTML, Funciones,
  Frm_PedirDatos;

function FrmFirmaContratos: TFrmFirmaContratos;
begin
  Result := TFrmFirmaContratos(UniMainModule.GetFormInstance(TFrmFirmaContratos));
end;

function TFrmFirmaContratos.ExtractUrlFileName(const AUrl: string): string;
var
  i: Integer;
begin
  i := LastDelimiter('/', AUrl);
  Result := Copy(AUrl, i + 1, Length(AUrl) - (i));
end;


procedure TFrmFirmaContratos.Setpasar_parametro_programa(const Value: string);
begin
  Fpasar_parametro_programa := Value;
end;

procedure TFrmFirmaContratos.UniDBGrid1AfterLoad(Sender: TUniDBGrid);
var
  colindx: byte;
begin
  // your Column Index
  colindx := 3;

  UniDBGrid1.JSInterface.JSCode('var me='#1'; Ext.defer(function(){Ext.select(me.columnManager.columns['+ IntToStr(colindx) +'].getCellSelector()).setStyle("cursor", "pointer")}, 100);');


//  UniSession.AddJS('var elements = document.getElementsByClassName("x-grid-cell-gridcolumn-1037" );'+
//                   'for (var i = 0; i < elements.length; i++) { var element = elements[i]; element.setAttribute(''style'', ''font: 11px/13px helvetica,arial,verdana,sans-serif;'');}  ');


end;


procedure TFrmFirmaContratos.UniDBGrid1CellClick(Column: TUniDBGridColumn);
var
  TextoSQL: string;
begin
  if (Column.Index=3) then
  begin
    if column.Field.AsString='B' then
    begin
      AbreVisor(True);
    end
    else begin
      if Trim(ADQuery1.FieldByName('REPRESENTANTE_NIF_EMP').AsString)<>'' then
      begin
        AbreVisor(False);
      end
      else begin
        with TFrmPedirDatos.Create(uniapplication) do
        begin
          ShowModal(
            procedure(Sender: TComponent; AResult: Integer)
            begin
              if Aresult=mrOk then
              begin
                // Guarda
                if ADMemTable1EMPRESA.AsString<>'' then
                begin
                  TextoSQL:='UPDATE DATOS_EMPRESA SET'+#13+
                            'DATOS_EMPRESA.REPRESENTANTE_NOMBRE_EMP='+QuotedStr(trim(ADMemTableRepresentanteNOMBRE.AsString))+','+#13+
                            'DATOS_EMPRESA.REPRESENTANTE_NIF_EMP='+QuotedStr(trim(ADMemTableRepresentanteNIF.AsString))+','+#13+
                            'DATOS_EMPRESA.REPRESENTANTE_CARGO_EMP='+QuotedStr(trim(ADMemTableRepresentanteCARGO.AsString))+#13+
                            'WHERE CLAVEEMP='+ADMemTable1EMPRESA.AsString;
                  Conexion.ExecSQL(TextoSQL);
                end;

                AbreVisor(False);
              end;
            end)
        end;
      end;
    end;
  end;
end;

procedure TFrmFirmaContratos.AbreVisor(consultando: Boolean);
begin
  with TFrmVisorContrato.Create(uniapplication) do
  begin
    parametro_programa:=Pasar_parametro_programa;
    FPadre:=Self;
    ModoConsulta:=consultando;
    ShowModal(
      procedure(Sender: TComponent; AResult: Integer)
      begin
        if Aresult=mrOk then
        begin
          if not (ADMemtable1.state in dsEditModes) then ADMemtable1.Edit;
          ADMemtable1.FieldByName('RUTA').AsString:='B';
          ADMemtable1.FieldByName('FIRMADO').AsString:='V';
          ADMemtable1.Post;
        end;
      end)
  end;

end;

procedure TFrmFirmaContratos.UniDBGrid1DrawColumnCell(Sender: TObject; ACol,
  ARow: Integer; Column: TUniDBGridColumn; Attribs: TUniCellAttribs);
begin
  case column.ID of
    0,1:
    begin
      if (ADMemtable1RUTA.AsString='B') then
        Attribs.Font.Color:=clGreen
      else Attribs.Font.Color:=clBlack
    end;
    2:
    begin
      Attribs.Font.name:='iconos !IMPORTANT';
      Attribs.Font.Size:=18;
      if (Column.Field.Value='V') then
        Attribs.Font.Color:=clGreen
      else Attribs.Font.Color:=clRed
    end;
    3:
    begin
      Attribs.Font.name:='cai !IMPORTANT';
      if (ADMemtable1RUTA.AsString='B') then
      begin
        Attribs.Font.Size:=12;
        Attribs.Font.Color:=clGreen;
      end
      else begin
        Attribs.Font.Size:=18;
        //UniSession.AddJS('ajaxRequest('+Self.Name+'.form,''COLOR'',[]);');
      end;
    end;
  end
end;



procedure TFrmFirmaContratos.ADMemTableRepresentanteNIFChange(Sender: TField);
begin
  // VALIDA NIF
  if Sender.AsString<>'' then
  begin
    UniSession.AddJS('ajaxRequest('+Self.Name+'.form,''NIF'',[]);');
  end;
end;

procedure TFrmFirmaContratos.UniFormAjaxEvent(Sender: TComponent; EventName: string;
  Params: TUniStrings);
var
  LNIF: string;
begin
  if SameText(EventName,'NIF') then
  begin
    LNIF := CalcCifNif('ES', ADMemTableRepresentanteNIF.AsString, True);
    if LNIF = 'MAL' then
    begin
      ShowMessage('El NIF '+ADMemTableRepresentanteNIF.AsString+' es incorrecto');
      ADMemTableRepresentanteNIF.AsString:='';
    end
    else begin
      if (Uppercase(ADMemTableRepresentanteNIF.AsString)<>Uppercase(LNIF)) then
        ADMemTableRepresentanteNIF.AsString:= LNIF;
    end;
  end
  else if SameText(EventName,'COLOR') then
  begin
    //UniDBGrid1.Columns[2].Font.color:=clred;
  end;
end;

procedure TFrmFirmaContratos.UniFormClose(Sender: TObject;
  var Action: TCloseAction);
var
  Fecha_a_mostrar: string;
begin
  //1- Si todos los documentos están firmados MrOk --> Permite Pasar
  //2- Si hay documentos sin firmar Mr Cancel y dependiendo de la fecha permite pasar o no y siempre pone mensaje

  Mensaje_cerrar:='';
  Permitir_continuar:=True;

  // recorre los contratos y si hay alguno pendiente de firmar el resultado es mrNONE --> sale de la aplicación
  modalresult:=mrok;
  ADMemTable1.First;
  while not ADMemTable1.eof do
  begin
    if ADMemTable1FIRMADO.AsString<>'V'then
    begin
      modalresult:=mrNone;
      // Construye mensaje y decide si permite_continuar o sale de la aplicación
      if ADMemTable1.FieldByName('FECHA_TOPE').Asstring='30/12/1899' then
        Fecha_a_mostrar:=FormatDateTime('dd/mm/yyyy',date)
      else
        Fecha_a_mostrar:=FormatDateTime('dd/mm/yyyy',ADMemTable1FECHA_TOPE.AsDateTime);

      mensaje_cerrar:=mensaje_cerrar+'Tenga en cuenta aceptar el documento '+ADMemTable1DOCUMENTO.AsString+' antes del día '+Fecha_a_mostrar+'\n';;

      if ((ADMemTable1.FieldByName('FECHA_TOPE').Asstring='30/12/1899') or (ADMemTable1.FieldByName('FECHA_TOPE').Asdatetime<=Date)) then
        Permitir_continuar:=false;
    end;
    ADMemTable1.Next;
  end;
end;

procedure TFrmFirmaContratos.UniFormReady(Sender: TObject);
var
  MiMensaje,MiFecha: string;
begin
  if Trim(Licencia)<>'' then
  begin
    Tipo:='WEB';
    if Assigned(UniMainModule.ADUsuarios.FindField('NOMBRUSU')) then
      usu:=UniMainModule.ADUsuarios.FieldByName('NOMBRUSU').AsString
    else if Assigned(UniMainModule.ADUsuarios.FindField('LOGIN')) then
      usu:=UniMainModule.ADUsuarios.FieldByName('LOGIN').AsString
    else
      usu:=UniMainModule.ADUsuarios.FieldByName('USUARIO').AsString;

    // Carga el grid de documentos
    with ADQuery1 do
    begin
      Close;
      SQL.Text:=
      'select servicios.nuempser codigo_empresa,'+#13+
      'servicios.licencia licencia, '+#13+
      'cai_documentos_a_firmar.nombre_daf,'+#13+
      'cai_documentos_a_firmar.tipo_firma_daf,'+#13+
      '('''') software_nombre,'+#13+
      'cai_documentos_a_firmar.interno,'+#13+
      'cai_documentos_a_firmar.contrato_daf,'+#13+
      '(select DATOS_EMPRESA.FECHA_TOPE_FIRMA_EMP from DATOS_EMPRESA where DATOS_EMPRESA.CLAVEEMP=SERVICIOS.NUEMPSER) FECHA_TOPE'+#13+
      'from servicios'+#13+
      'INNER JOIN cai_documentos_a_firmar ON (1=1)'+#13+
      'left outer join cai_documentos_firmados on'+#13+
      '(cai_documentos_a_firmar.interno=cai_documentos_firmados.documentos_a_firmar_interno_dfi'+#13+
      'and servicios.nuempser=cai_documentos_firmados.empresa_dfi)'+#13+
      'where cai_documentos_a_firmar.tipo_firma_daf=''EMPRESA'''+#13+
      'and UPPER(servicios.licencia)=UPPER('''+Licencia+''')'+#13+
      'and servicios.licenciaaltaobaja=''A'''+#13+
      'and cai_documentos_firmados.interno is null'+#13+
      'union'+#13+
      'select     '+#13+
      'servicios.nuempser codigo_empresa,'+#13+
      'servicios.licencia licencia,'+#13+
      'cai_documentos_a_firmar.nombre_daf,'+#13+
      'cai_documentos_a_firmar.tipo_firma_daf,'+#13+
      '(select cai_tipos_servicios.NOMBRE_DEL_PROGRAMA_WEB_TSE from cai_tipos_servicios where cai_tipos_servicios.codigo_tse=servicios.serviser) software_nombre,'+#13+
      'cai_documentos_a_firmar.interno,cai_documentos_a_firmar.contrato_daf,'+#13+
      'SERVICIOS.FECHA_TOPE_FIRMA_SER FECHA_TOPE'+#13+
      'from servicios'+#13+
      'left outer JOIN cai_documentos_a_firmar ON (servicios.tipo_licencia_ser=cai_documentos_a_firmar.tipo_licencia_daf)'+#13+
      'left outer join cai_documentos_firmados on'+#13+
      '(cai_documentos_a_firmar.interno=cai_documentos_firmados.documentos_a_firmar_interno_dfi'+#13+
      'and servicios.nuempser=cai_documentos_firmados.empresa_dfi and UPPER(cai_documentos_firmados.LICENCIA_DFI)=UPPER('''+Licencia+''') )'+#13+
      'where cai_documentos_a_firmar.tipo_firma_daf=''LICENCIA'''+#13+
      'and UPPER(servicios.licencia)=UPPER('''+Licencia+''')'+#13+
      'and servicios.licenciaaltaobaja=''A'''+#13+
      'and servicios.TIPO_LICENCIA_SER IN (''WEB'')'+#13+
      'and cai_documentos_firmados.interno is null ORDER BY 5';
      Open;
      try
        if (not IsEmpty) then
        begin
          while not eof do
          begin
            if not ADMemTable1.Active then ADMemTable1.Open;
            ADMemTable1.Append;
            ADMemTable1DOCUMENTO.AsString:=FieldByName('nombre_daf').AsString+ifthen(FieldByName('software_nombre').AsString<>'',' - '+FieldByName('software_nombre').AsString,'');
            ADMemTable1CONTRATO.AsVariant:=FieldByName('contrato_daf').AsVariant;
            ADMemTable1INTERNO.AsInteger:=FieldByName('interno').AsInteger;
            ADMemTable1FIRMADO.AsString:='X';
            ADMemTable1RUTA.AsString:='h';   // firmar
            ADMemTable1EMPRESA.AsInteger:=FieldByName('codigo_empresa').AsInteger;
            ADMemTable1TIPO_FIRMA.AsString:= FieldByName('tipo_firma_daf').AsString;
            ADMemTable1FECHA_TOPE.AsDateTime:=FieldByName('FECHA_TOPE').AsDateTime;
            ADMemTable1.Post;
            Next;
          end;
        end
        else begin
          UniApplication.Terminate('Error en la firma de documentos (Codigo de error <'+Licencia+'>)'); // Sino viene un valor correcto salgo de la web
          //Abort;
        end
      finally
        Close;
      end;
    end;

    // Datos empresa y servicios para fusionar
    // Carga el grid de documentos
    with ADQuery1 do
    begin
      Close;
      SQL.Text:=
      'select'+#13+
      'DATOS_EMPRESA.NOMBREMP,'+#13+
      'DATOS_EMPRESA.CIFEMP,'+#13+
      'DATOS_EMPRESA.DOMICEMP,'+#13+
      'DATOS_EMPRESA.POBLAEMP,'+#13+
      'DATOS_EMPRESA.CPOSTEMP,'+#13+
      '(select FIRST 1 NOMBRE_PRO FROM CAI_PROVINCIAS where codigo_pro=DATOS_EMPRESA.CODIGO_PROVINCIA) EMPRESA_PROVINCIA,'+#13+
      'DATOS_EMPRESA.TELE1EMP,'+#13+
      'DATOS_EMPRESA.TELE2EMP,'+#13+
      '(SELECT FIRST 1 CAI_EMAILS.CORREO_EMA FROM CAI_EMAILS where CAI_EMAILS.interno_datos_empresa_ema=DATOS_EMPRESA.INTERNO AND CAI_EMAILS.TIPO_EMA=''ADMINISTRACION'') EMPRESA_EMAIL_ADMINISTRACION,'+#13+
      'DATOS_EMPRESA.IBANEMP,'+#13+
      'DATOS_EMPRESA.REPRESENTANTE_NOMBRE_EMP,'+#13+
      'DATOS_EMPRESA.REPRESENTANTE_NIF_EMP,'+#13+
      'DATOS_EMPRESA.REPRESENTANTE_CARGO_EMP,'+#13+
      '(SELECT FIRST 1 CAI_TIPOS_SERVICIOS.NOMBRE_DEL_PROGRAMA_WEB_TSE FROM CAI_TIPOS_SERVICIOS where CAI_TIPOS_SERVICIOS.CODIGO_TSE=SERVICIOS.SERVISER) SOFTWARE_NOMBRE,'+#13+
      'SERVICIOS.VERSION_2016_SER,'+#13+
      'SERVICIOS.LICENCIA,'+#13+
      'SERVICIOS.LICENCIA_TRAMO_01,'+#13+
      'SERVICIOS.LICENCIA_TRAMO_02,'+#13+
      'SERVICIOS.CONCEPTO,'+#13+
      'SERVICIOS.USUARIOS_2016_SER,'+#13+
      'SERVICIOS.PERIODICIDAD_SER,'+#13+
      'SERVICIOS.FALTASER,'+#13+
      'DATOS_EMPRESA.BIC_EMP'+#13+
      'from servicios'+#13+
      'inner join datos_empresa on datos_empresa.claveemp=servicios.nuempser'+#13+
      'and UPPER(servicios.licencia)=UPPER('''+Licencia+''')';
      Open;
      try
        if (IsEmpty) then
        begin
          UniApplication.Terminate('Error en la firma de documentos (Codigo de error <'+Licencia+'>)'); // Sino viene un valor correcto salgo de la web
        end
      finally
      end;
    end;

    // Guarda datos representante
    try
      ADMemTableRepresentanteNIF.OnChange:=nil;
      if not ADMemTableRepresentante.Active then ADMemTableRepresentante.Open;
      ADMemTableRepresentante.Append;
      ADMemTableRepresentanteNOMBRE.AsString:=ADQuery1.FieldByName('REPRESENTANTE_NOMBRE_EMP').AsString;
      ADMemTableRepresentanteNIF.AsString:=ADQuery1.FieldByName('REPRESENTANTE_NIF_EMP').AsString;
      ADMemTableRepresentanteCARGO.AsString:=ADQuery1.FieldByName('REPRESENTANTE_CARGO_EMP').AsString;
      ADMemTableRepresentante.Post;
    finally
      ADMemTableRepresentanteNIF.OnChange:=ADMemTableRepresentanteNIFChange;
    end;

    // REcorre los documentos y saca un mensaje
    ADMemTable1.first;

    MiMensaje:='Hola. He detectado que tienes contratos pendientes de aceptar.'+#13+#13;
    MiMensaje:=MiMensaje+'Ten en cuenta que, dichos contratos deben ser aceptados antes de la fecha límite, siendo esta:'+#13+#13;

    while not ADMemTable1.eof do
    begin
      // Construye mensaje y decide si permite_continuar o sale de la aplicación
      if ADMemTable1.FieldByName('FECHA_TOPE').Asstring='30/12/1899' then
        MiFecha:=FormatDateTime('dd/mm/yyyy',date)
      else
        Mifecha:=FormatDateTime('dd/mm/yyyy',ADMemTable1FECHA_TOPE.AsDateTime);

      MiMensaje:=MiMensaje+'- Documento '+ADMemTable1DOCUMENTO.AsString+' '+MiFecha+'.'+#13;

      ADMemTable1.Next;
    end;

    MiMensaje:=MiMensaje+#13+'Llegada la fecha límite, si existiese algún documento pendiente de aceptar, el sistema cerrará la aplicación hasta que se acepten dichos documentos. Una vez aceptados, podrás volver a entrar con normalidad.'+#13+#13+
               'Podrás ver los documentos ya aceptados dentro de tu Gestor de Aplicaciones Web, entrando con tu usuario “Administrador”.'+#13+#13+
               'Por favor, una vez revisado cada contrato, marca la casilla “He leído y acepto los términos y condiciones”.';
    uniGuiDialogs.ShowMessage(MiMensaje);

  end
  else begin
    UniApplication.Terminate('Error en la firma de documentos (Codigo de error <'+Licencia+'>)'); // Sino viene un valor correcto salgo de la web
    //Abort;
  end;
end;

initialization


end.

