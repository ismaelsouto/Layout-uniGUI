unit Frm_Registro;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniEdit, uniLabel, uniToolBar, uniGUIBaseClasses,
  uniPanel, uniPageControl, uniGroupBox, uniBasicGrid, uniDBGrid, Funciones,
  Data.DB,  Frm_VisorPDF,  uniButton, uniBitBtn, uniDBEdit, Frm_Provincias_Browse,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.Phys.Intf, FireDAC.DApt.Intf,FireDAC.DatS, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Frm_Provincias_Editor,IdSMTP, IdBaseComponent, IdMessage,uniGUIDialogs,
  uniMultiItem, uniComboBox, uniRadioGroup, uniCheckBox, uNuevaLicencia,
  Frm_Preguntar_Representante,FireDAC.Phys.fb, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.UI.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Phys,
  FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, FireDAC.Phys.IBBase;

type
  TPrograma = (caifac, caiconta, cailab, caifis, caisoc,cairen);
  TFrmRegistro = class(TUniForm)
    UniToolBar1: TUniToolBar;
    UBSalir: TUniToolButton;
    UBVerContrato: TUniBitBtn;
    DataSource1: TDataSource;
    UniGroupBoxDatos: TUniGroupBox;
    lbNombre: TUniLabel;
    lbDomicilio: TUniLabel;
    lbCP: TUniLabel;
    lbLoc: TUniLabel;
    lbpro: TUniLabel;
    UniDBEditNombre: TUniDBEdit;
    UniDBEdit3: TUniDBEdit;
    UniDBEdit4: TUniDBEdit;
    UniDBEditLocalidad: TUniDBEdit;
    UniDBEditProvincia: TUniDBEdit;
    UniBitBtn1: TUniBitBtn;
    lbNombre_ast: TUniLabel;
    lbTel1: TUniLabel;
    UniDBEdittelefono: TUniDBEdit;
    lbtel2: TUniLabel;
    UniDBEdit8: TUniDBEdit;
    lbFax: TUniLabel;
    UniDBEdit9: TUniDBEdit;
    lbPersona: TUniLabel;
    UniDBEdit10: TUniDBEdit;
    lbTel1_ask: TUniLabel;
    lbIBAN: TUniLabel;
    ADQuery1: TFDQuery;
    ADConnectionFactura: TfDConnection;
    ADPhysIBDriverLinkFACTURA: TfDPhysfBDriverLink;
    MaskEditIBAN: TUniEdit;
    ADQuery1CLAVEEMP: TIntegerField;
    ADQuery1CIFEMP: TStringField;
    ADQuery1NOMBREMP: TStringField;
    ADQuery1DOMICEMP: TStringField;
    ADQuery1CPOSTEMP: TStringField;
    ADQuery1POBLAEMP: TStringField;
    ADQuery1TELE1EMP: TStringField;
    ADQuery1TELE2EMP: TStringField;
    ADQuery1FAXEMP: TStringField;
    ADQuery1PERSOEMP: TStringField;
    ADQuery1DOMFAEMP: TStringField;
    ADQuery1CPOFAEMP: TStringField;
    ADQuery1POBFAEMP: TStringField;
    ADQuery1BANCOEMP: TStringField;
    ADQuery1TIPOEMP: TStringField;
    ADQuery1EMAILEMP: TStringField;
    ADQuery1NOMFAEMP: TStringField;
    ADQuery1FBAJAEMP: TSQLTimeStampField;
    ADQuery1NOUSUEMP: TStringField;
    ADQuery1PASSWEMP: TStringField;
    ADQuery1INTERNO: TIntegerField;
    ADQuery1CODIGO_PROVINCIA: TIntegerField;
    ADQuery1CODIGO_PROVINCIA_CORREO: TIntegerField;
    ADQuery1CONTRASENA_ADMINISTRACION: TStringField;
    ADQuery1EXTENSION: TStringField;
    ADQuery1TIPO_FACTURA: TIntegerField;
    ADQuery1CONTRASENA_ZIP: TStringField;
    ADQuery1EMAIL_GENERAL: TStringField;
    ADQuery1ACTUALIZAR_DESDE_LA_WEB: TStringField;
    ADQuery1PESO_PROGRAMAS: TIntegerField;
    ADQuery1ACTUALIZAR_DESDE_FACTURACION: TStringField;
    ADQuery1IDFRUTAS_CAICONTA: TIntegerField;
    ADQuery1IDFRUTAS_GENERAL: TIntegerField;
    ADQuery1IDFURL_CAICONTA: TIntegerField;
    ADQuery1CLAVE_ACTIVACION: TStringField;
    ADQuery1IDBASEDEDATOS: TIntegerField;
    ADQuery1EXENTO_DE_IVA_EMP: TStringField;
    ADQuery1IDFRUTAS_CAIFIS: TIntegerField;
    ADQuery1IDFURL_CAIFIS: TIntegerField;
    ADQuery1SUBORDINADA: TIntegerField;
    ADQuery1IDFRUTAS_CAILAB: TIntegerField;
    ADQuery1IDFURL_CAILAB: TIntegerField;
    ADQuery1IDFRUTAS_CAIFAC: TIntegerField;
    ADQuery1IDFURL_CAIFAC: TIntegerField;
    ADQuery1IDFURL_CAIMAE: TIntegerField;
    ADQuery1AVISO_IMPORTANTE_EMP: TStringField;
    ADQuery1IDFRUTAS_PORTALSII: TIntegerField;
    ADQuery1IDFURL_PORTALSII: TIntegerField;
    ADQuery1PERMISO_CERTIFICADO_CAI: TStringField;
    UBAceptar: TUniToolButton;
    UniLabel1: TUniLabel;
    UniLabel2: TUniLabel;
    mensaje: TIdMessage;
    UniGroupBoxNIF: TUniGroupBox;
    lbNIF: TUniLabel;
    UniDBEditNIF: TUniDBEdit;
    lbNif_Ast: TUniLabel;
    UniBitBtn2: TUniBitBtn;
    UniGroupBoxContenedorLicencia: TUniGroupBox;
    rgVersion: TUniRadioGroup;
    UniPanel1: TUniPanel;
    UniLabel3: TUniLabel;
    ADQuery1IDFRUTAS_CAISOC: TIntegerField;
    ADQuery1IDFURL_CAISOC: TIntegerField;
    ADQuery1TELEFONO_3_EMP: TStringField;
    ADQuery1IBANEMP: TStringField;
    ADQuery1OBSEREMP: TMemoField;
    ADQuery1OSOFTEMP: TMemoField;
    ADQuery1OHARDEMP: TMemoField;
    ADQuery1REPRESENTANTE_NOMBRE_EMP: TStringField;
    ADQuery1REPRESENTANTE_CARGO_EMP: TStringField;
    ADQuery1REPRESENTANTE_NIF_EMP: TStringField;
    UniLabel4: TUniLabel;
    UniDBEditREP_NIF: TUniDBEdit;
    UniLabel5: TUniLabel;
    UniLabel6: TUniLabel;
    UniLabel7: TUniLabel;
    UniDBEditRep_Nombre: TUniDBEdit;
    UniLabel8: TUniLabel;
    UniLabel9: TUniLabel;
    UniDBEditRep_cargo: TUniDBEdit;
    UniLabel10: TUniLabel;
    UniLabel11: TUniLabel;
    UniLabel12: TUniLabel;
    ADQuery1IDFRUTAS_CAIREN: TIntegerField;
    ADQuery1IDFURL_CAIREN: TIntegerField;
    procedure UBSalirClick(Sender: TObject);
    procedure UniFormCreate(Sender: TObject);
    procedure UniFormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure UBVerContratoClick(Sender: TObject);
    procedure UniFormShow(Sender: TObject);
    procedure ADQuery1BeforeOpen(DataSet: TDataSet);
    procedure ADQuery1CIFEMPChange(Sender: TField);
    procedure UBAceptarClick(Sender: TObject);
    procedure ADQuery1CIFEMPSetText(Sender: TField; const Text: string);
    procedure UniFormAjaxEvent(Sender: TComponent; EventName: string;
      Params: TUniStrings);
    procedure UniBitBtn1Click(Sender: TObject);
    procedure UniFormClose(Sender: TObject; var Action: TCloseAction);
    procedure UniBitBtn2Click(Sender: TObject);
    procedure UniLabel3Click(Sender: TObject);
    procedure EnviaCorreo_ERROR_EN_VERIFICACION(prog, IBAN: string; otro:boolean=False);
    procedure UniDBEditREP_NIFAjaxEvent(Sender: TComponent; EventName: string;
      Params: TUniStrings);
  private
    Hacer_controles: boolean;
    claveemp,empresa_a_borrar: Integer;
    Fprograma: TPrograma;
    FqueUsuario: integer;
    procedure Setprograma(const Value: TPrograma);
    procedure SetqueUsuario(const Value: integer);
    procedure envia_mensaje(cambiar_IDBASEDEDATOS: integer;prog,LICENCIA: string;indicar_si_se_borra_empresa: boolean);
    procedure cargaIBAN;
    function Error_al_ValidarNIF_y_Email(nif: string; var otro:boolean;prog:string): boolean;

    { Private declarations }
  public
    property programa :TPrograma read Fprograma write Setprograma;
    property queUsuario: integer read FqueUsuario write SetqueUsuario;
  end;

function FrmRegistro: TFrmRegistro;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication, StrUtils, SBEncoding;

function FrmRegistro: TFrmRegistro;
begin
  Result := TFrmRegistro(UniMainModule.GetFormInstance(TFrmRegistro));
end;

procedure TFrmRegistro.ADQuery1BeforeOpen(DataSet: TDataSet);
begin
  if Empresa_a_borrar=-1 then
    ADQuery1.ParamByName('IDUSUARIOS').AsInteger:= queUsuario;
end;

procedure TFrmRegistro.ADQuery1CIFEMPChange(Sender: TField);
var
  otro: Boolean;
  hayempresa: boolean;
  msg,prog: string;
begin
   if sender.AsString<>'' then
   begin
     Hacer_controles:=True;

     self.Height:=440;
     UBAceptar.Enabled:=True;

    case programa of
      caifac: prog:='CAIFACWEB';
      caiconta: prog:='CAICONTAWEB';
      cailab: prog:='CAILABWEB';
      caifis: prog:='CAIFISWEB';
      caisoc: prog:='CAISOCWEB';
      cairen: prog:='CAIRENWEB';
      else prog:='ERROR';
    end;

     otro:=False;

     with ConsultaAD(ADConnectionFactura,'select CIFEMP,CLAVEEMP from DATOS_EMPRESA where UPPER(CIFEMP)='+QuotedStr(uppercase(Sender.AsString))) do
       try
         hayempresa:=not IsEmpty;
       finally
         Free;
       end;


     if hayempresa and Error_al_ValidarNIF_y_Email(Sender.AsString,otro,prog) then
     begin
       // Error al verificar--> Correo y aviso en pantalla
       cargaIBAN;
       EnviaCorreo_ERROR_EN_VERIFICACION(prog,MaskEditIBAN.Text,otro);
       if otro then
       begin
         UniGuiDialogs.ShowMessage('NO SE PUEDE REALIZAR EL REGISTRO'+#13+#10+
                   'El NIF introducido ya esta registrado en '+prog+'.'+#13+#10+
                   'Por favor, contacte con CAI Sistemas Informáticos para continuar el proceso.');
         UBAceptar.Enabled:=False;
       end

       Else begin
         UniGuiDialogs.ShowMessage('NO SE PUEDE REALIZAR EL REGISTRO'+#13+#10+
                   'No coincide el email introducido durante la solicitud de la prueba gratuíta del programa con las cuentas almacenadas en nuestra base de datos.'+#13+#10+
                   'Por favor, contacte con CAI Sistemas Informáticos para continuar el proceso.');
         UBAceptar.Enabled:=False;
       end;

     end
     Else begin
       with ConsultaAD(ADConnectionFactura,'select CIFEMP,CLAVEEMP from DATOS_EMPRESA where UPPER(CIFEMP)='+QuotedStr(uppercase(Sender.AsString))) do
        try
         if IsEmpty then
         begin
            // No existe
            UniGroupBoxDatos.Visible:=true;
            UniGroupBoxDatos.Enabled:=True;
            claveemp:=ADQuery1.FieldByName('CLAVEEMP').AsInteger;
            Empresa_a_borrar:=-1;
            cargaIBAN;
         end
         else begin
           // Cambia el mensaje si hay que pedir representante o no
           if TRIM(ADQuery1.FieldByName('REPRESENTANTE_NIF_EMP').AsString)='' then
             msg:='¡Sabemos que ya eres cliente de CAI! por eso para finalizar este proceso de registro solo falta que nos indiques los datos del Representante de la empresa.'
           else
             msg:='¡Sabemos que ya eres cliente de CAI! por tanto ya tenemos tus datos y no necesitamos pedirte ninguna información para finalizar este proceso de registro.';


           // Existe--> graba la empresa a borrar y se situa en la nueva
           ShowMessage(msg,procedure(Sender: TComponent; AResult: Integer)
            begin
              Hacer_controles:=False; // SI ES CLIENTE DE CAI NO SE HACEN CONTROLES (YA QUE LOS DATOS NO VAN VISIBLES)

              // Pide los datos de reprentante si no hay representante en la empresa
              if TRIM(ADQuery1.FieldByName('REPRESENTANTE_NIF_EMP').AsString)='' then
              begin
                with TFrmPreguntarRepresentante.Create(uniapplication) do
                 begin
                   DataSource_representante.DataSet:=self.ADQuery1;
                   ShowModal(
                   procedure(Sender: TComponent; AResult: Integer)
                   begin
                     if Aresult=mrOk then
                     begin
                       ADQuery1.Post;
                       UBAceptar.Visible:=True;
                     end
                     else begin
                       ADQuery1.Cancel;
                       UBAceptar.Visible:=False;
                       uniguidialogs.ShowMessage('Debe grabar obligatoriamente los datos del representante.');
                     end;
                   end)
                 end;
              end;
            end);
            //*************************************************!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!OJO
           Empresa_a_borrar:=ADQuery1.FieldByName('CLAVEEMP').AsInteger; // Graba
           UniGroupBoxDatos.Visible:=false;
           UniGroupBoxDatos.Enabled:=False;
           claveemp:=FieldByname('CLAVEEMP').AsInteger;


           // SE SITUA EN LA NUEVA EMPRESA
           ADQuery1.Close;
           ADQuery1.SQL.Text:='select * from datos_empresa where claveemp='+IntToStr(claveemp);
           ADQuery1.Open;
           UniGroupBoxNIF.Enabled:=false;
           ADQuery1.Edit;
           cargaIBAN;
         end;
        finally
          Free;
        end;
     end
     end
     else begin
       UniGroupBoxDatos.Visible:=False;
       self.Height:=186;
       UBAceptar.Enabled:=False;
     end;

end;

procedure TFrmRegistro.ADQuery1CIFEMPSetText(Sender: TField;
  const Text: string);
var
  LNIF: string;
begin
  if (Text<>'') then
  begin
    LNIF := CalcCifNif('ES', Text, True);
    if LNIF = 'MAL' then
    begin
      //ADQuery1CIFEMP.AsString:='';
      UniSession.AddJS('ajaxRequest('+Self.Name+'.form,''NIF'',[''valor='']);');
      ShowMessage('NIF incorrecto');
    end
    else begin
      //ADQuery1CIFEMP.AsString:= LNIF;
      UniSession.AddJS('ajaxRequest('+Self.Name+'.form,''NIF'',[''valor='+LNIF+''']);');
    end;
  end;
end;

procedure TFrmRegistro.cargaIBAN;
var
  TextoIBAN: string;

  function dameiban(cuenta: string): string;
  var
    digitos:integer;
  begin
    result:='';
    if cuenta<>'' then
    begin
      digitos:=CalculateDigits('ES00'+cuenta);
      if digitos<>0 then
      result:='ES'+IntToStr(digitos)+cuenta;
    end;
  end;
begin
   // trae e iban de la licencia y si no encuentra trae el de la empresa
   TextoIBAN:='SELECT FIRST 1 IBAN, IBANEMP' +#13+
              'FROM DATOS_EMPRESA' +#13+
              'LEFT OUTER JOIN LICENCIAS_PROGRAMAS_WEB ON (DATOS_EMPRESA.CLAVEEMP=LICENCIAS_PROGRAMAS_WEB.CLAVEEMP)' +#13+
              'WHERE DATOS_EMPRESA.CLAVEEMP='+IntTostr(ADQuery1CLAVEEMP.AsInteger)+#13+
              'order BY 1 desc';

   with ConsultaAD(ADConnectionFactura,TextoIBAN) do
   try
     if FieldByName('IBANEMP').AsString<>'' then
       MaskEditIBAN.Text:=FieldByName('IBANEMP').AsString
     else if FieldByName('IBAN').AsString<>'' then
       MaskEditIBAN.Text:=FieldByName('IBAN').AsString;
   finally
     Free;
   end;
end;

procedure TFrmRegistro.EnviaCorreo_ERROR_EN_VERIFICACION(prog,IBAN: string; otro: boolean);
var
  correo: string;
begin
  with TIdSMTP.Create(nil) do
    try
      Host := 'smtp.caisistemas.es';
      UserName := 'comercial@caisistemas.es';
      Password := 'Comercial_2000';
      Connect;

      // envío del correo a CAI
      mensaje.ContentType := 'text/plain';
      mensaje.CharSet := 'UTF-8';
      mensaje.From.Address := UserName;
      mensaje.From.Name := 'CAI Sistemas Informaticos SL';

      mensaje.Subject := 'ATENCIÓN!!!  [VERIFICACIÓN NIF-EMAIL ERRONEO] del Nuevo usuario de '+prog;

      with CDSRestFacturaGDB('SELECT LICENCIAS_PROGRAMAS_WEB.EMAIL FROM LICENCIAS_PROGRAMAS_WEB WHERE PROGRAMA='+quotedstr(prog)+' AND FECHA_DEMO IS NOT NULL AND CLAVEEMP='+
          '(SELECT EMPRESA FROM USUARIOS WHERE IDUSUARIOS='+IntToStr(queUsuario)+')') do
      try
        correo :=FieldByName('EMAIL').AsString; // Si está vacio --> no encuentra el email en la lista --> hay error y NO DEJA REGISTRAR
      finally
        Free;
      end;

      with mensaje.Body do
      begin
        clear;
        if otro then
        begin
          Add('ATENCIÓN! [VERIFICACIÓN NIF-EMAIL ERRONEO] del Nuevo usuario de '+prog+':');
          Add('');
          Add('***** EL NIF INTRODUCIDO YA EXISTE EN '+prog+'*****');
          Add('');
        end
        Else begin
          Add('ATENCIÓN! [VERIFICACIÓN NIF-EMAIL ERRONEO] del Nuevo usuario de '+prog+':');
          Add('');
          Add('***** EL EMAIL NO SE ENCUENTRA EN LA LISTA DE CORREOS DE CAI*****');
          Add('');
          Add('EMAIL EN REGISTRO: ' + correo);
        end;
        Add('');
        Add('*****************************************************************');
        Add('');
        Add('Descripción: Licencia de '+prog );
        Add('');
        Add('Nombre: ' + ADQuery1.FieldByName('NOMBREMP').AsString);
        Add('Empresa: ' + ADQuery1.FieldByName('CLAVEEMP').AsString);
        Add('Teléfono: ' + ADQuery1.FieldByName('TELE1EMP').AsString);
        Add('Dirección: ' + ADQuery1.FieldByName('DOMICEMP').AsString);
        Add('C. Postal: ' + ADQuery1.FieldByName('CPOSTEMP').AsString);
        Add('Población: ' + ADQuery1.FieldByName('POBLAEMP').AsString);
        Add('');
        Add('NIF: ' + ADQuery1.FieldByName('CIFEMP').AsString);
        //Add('Usuario: ' + USU);
        Add('IBAN GRABADO EN EMPRESA: ' + ADQuery1.FieldByName('BANCOEMP').AsString);
        Add('IBAN EN REGISTRO: ' + IBAN);


      end;

      mensaje.Recipients.Clear;
      mensaje.Recipients.Add.Address := 'mlomba@caisistemas.es';
      Send(mensaje);

      mensaje.Recipients.Clear;
      mensaje.Recipients.Add.Address := 'comercial@caisistemas.es';
      Send(mensaje);

//      mensaje.Recipients.Clear;
//      mensaje.Recipients.Add.Address := 'marketing@caisistemas.es';
//      Send(mensaje);

    finally
      Free;
    end;
end;

procedure TFrmRegistro.Setprograma(const Value: TPrograma);
begin
  Fprograma := Value;
end;

procedure TFrmRegistro.SetqueUsuario(const Value: integer);
begin
  FqueUsuario := Value;
end;

procedure TFrmRegistro.envia_mensaje(cambiar_IDBASEDEDATOS: integer;prog,LICENCIA: string;indicar_si_se_borra_empresa: boolean);
begin
  with TIdSMTP.Create(nil) do
  try
    mensaje.Clear;
    mensaje.Recipients.Clear;

    Host := 'smtp.caisistemas.es';
    UserName := 'mlomba@caisistemas.es';
    Password := 'Mlomba_2000';
    Connect;

      // envío del correo a CAI
      mensaje.ContentType := 'text/plain';
      mensaje.CharSet := 'UTF-8';
      mensaje.From.Address := UserName;
      mensaje.From.Name := 'Registro desde ['+prog+'] - CAI Sistemas Informaticos SL';

      mensaje.Subject := 'Registro de licencia desde ['+prog+']';

      with mensaje.Body do
      begin
        clear;
        Add('Se ha registrado una nueva licencia desde el programa ['+prog+']');
        Add('');
        Add('Nombre: '+ADQuery1NOMBREMP.AsString);
        Add('Licencia: '+LICENCIA);
        Add('');

        if indicar_si_se_borra_empresa then
        begin
          Add('Nº de empresa de la demo que se registró y que se borró: '+IntToStr(empresa_a_borrar));
          Add('Nº de empresa definitivo: '+IntToStr(ADQuery1CLAVEEMP.AsInteger));
        end
        else begin
          Add('Nº de empresa: '+IntToStr(ADQuery1CLAVEEMP.AsInteger));
        end;

        Add('');

        if indicar_si_se_borra_empresa then
        begin
          Add('IDBASEDEDATOS de la demo que se registró: '+IntToStr(cambiar_IDBASEDEDATOS));
          Add('IDBASEDEDATOS definitivo: '+IntToStr(ADQuery1IDBASEDEDATOS.AsInteger));
        end
        else begin
          Add('IDBASEDEDATOS: '+IntToStr(ADQuery1IDBASEDEDATOS.AsInteger));
        end;

        // AVISO
        if indicar_si_se_borra_empresa then
        begin
          // si los ID BASE DE DATOS NO COINCIDEN HAY QUE RENOMBRAR LA BASE DE DATOS A MANO Y CAMBIARLA DE SITIO
          if (cambiar_IDBASEDEDATOS<>ADQuery1IDBASEDEDATOS.AsInteger) then
          begin
            Add('');
            Add('*** ATENCION *****');
            Add('*** ATENCION *****');
            Add('LA BASE DE DATOS '+IntToStr(cambiar_IDBASEDEDATOS)+' DEBE SER RENOMBRADA A '+IntToStr(ADQuery1IDBASEDEDATOS.AsInteger)+' Y MOVIDA A SU CARPETA');
          end;
        end;

      end;

      mensaje.Recipients.Clear;
      mensaje.Recipients.Add.Address := 'mlomba@caisistemas.es';
      Send(mensaje);

      mensaje.Recipients.Clear;
      mensaje.Recipients.Add.Address := 'marketing@caisistemas.es';
      Send(mensaje);

      mensaje.Recipients.Clear;
      mensaje.Recipients.Add.Address := 'comercial@caisistemas.es';
      Send(mensaje);
  finally
    Free;
  end;
end;


function TFrmRegistro.Error_al_ValidarNIF_y_Email(nif: string; var otro: boolean;prog:string): boolean;
var
  mail: string;
begin

  result:=True;
  otro:=False;

  // Compruebo que no este ya contrtado otro porltaemp
  with CDSRestFacturaGDB('select DATOS_EMPRESA.claveemp from LICENCIAS_PROGRAMAS_WEB inner join DATOS_EMPRESA on datos_empresa.claveemp=LICENCIAS_PROGRAMAS_WEB.claveemp where '+
          'LICENCIAS_PROGRAMAS_WEB.programa ='+QuotedStr(prog)+' and UPPER(DATOS_EMPRESA.CIFEMP)='+QuotedStr(uppercase(nif))) do
    try
      result:=IsEmpty;
      otro:=not IsEmpty;
    finally
      Free;
    end;

  if otro then
  begin
    result:=True;
    Exit;
  end;

  if result then
  begin
    with CDSRestFacturaGDB('SELECT LICENCIAS_PROGRAMAS_WEB.EMAIL FROM LICENCIAS_PROGRAMAS_WEB WHERE PROGRAMA='+QuotedStr(prog)+' AND '+
            'FECHA_DEMO IS NOT NULL AND CLAVEEMP=(SELECT EMPRESA FROM USUARIOS WHERE IDUSUARIOS='+IntToStr(queUsuario)+')') do
      try
        mail:=UpperCase(Fields[0].AsString);
      finally
        Free;
      end;

    with CDSRestFacturaGDB('select CAI_EMAILS.CORREO_EMA from CAI_EMAILS inner join'+#13+#10+
        'DATOS_EMPRESA on DATOS_EMPRESA.INTERNO=CAI_EMAILS.interno_datos_empresa_ema'+#13+#10+
        'where UPPER(CAI_EMAILS.CORREO_EMA)=UPPER('+QuotedStr(mail)+') AND UPPER(DATOS_EMPRESA.CIFEMP)=UPPER('+QuotedStr(uppercase(nif))+')') do

    try
      result :=IsEmpty; // Si está vacio --> no encuentra el email en la lista --> hay error y NO DEJA REGISTRAR
    finally
      Free;
    end;
  end;
end;


procedure TFrmRegistro.UBAceptarClick(Sender: TObject);
var
  licencia,prog,texto,clausula_version: string;
  // DATOS DE LA EMPRESA A CAMBIAR
  cambiar_PROGRAMA: string;
  cambiar_IDBASEDEDATOS: integer;
  cambiar_IDFRUTAS_GENERAL: integer;
  cambiar_IDFURL_CAIMAE: integer;
  cambiar_ID: integer; //ID licencias_programas_web

begin
    Funciones.MessageDlg('Se va a proceder con la contratación del servicio ¿Deseas continuar?',mtConfirmation,mbYesNo,
    procedure (Sender: TComponent; AResult: Integer)
    begin
      if AResult=mrYes then
      begin

        if ADQuery1CIFEMP.AsString='' then
        begin
          raise Exception.Create('Teclee un NIF.');
          UniDBEditNIF.SetFocus;
        end;

        if Hacer_controles then
        begin
          if ADQuery1NOMBREMP.AsString='' then
          begin
            raise Exception.Create('Teclee un nombre.');
            UniDBEditNombre.SetFocus;
          end;

          if ADQuery1DOMICEMP.AsString='' then
          begin
            raise Exception.Create('Teclee un domicilio.');
            UniDBEdit3.SetFocus;
          end;

          if ADQuery1CPOSTEMP.AsString='' then
          begin
            raise Exception.Create('Teclee un código postal.');
            UniDBEdit4.SetFocus;
          end;

          if ADQuery1POBLAEMP.AsString='' then
          begin
            raise Exception.Create('Teclee una localidad.');
            UniDBEditLocalidad.SetFocus;
          end;

          if ADQuery1CODIGO_PROVINCIA.AsString='' then
          begin
            raise Exception.Create('Teclee una provincia.');
            UniDBEditProvincia.SetFocus;
          end;

          if Trim(MaskEditIBAN.Text)='' then
          begin
            raise Exception.Create('Teclee un IBAN.');
            MaskEditIBAN.SetFocus;
          end;


          // Comprueba que el IBAN sea correcto
          if Trim(MaskEditIBAN.Text)<>'' then
          begin
            if IBANCheck(MaskEditIBAN.Text)=false then
            begin
              MaskEditIBAN.SetFocus;
              raise Exception.Create('IBAN incorrecto.');
            end
          end;
        end;

        if ADQuery1REPRESENTANTE_NIF_EMP.AsString='' then
        begin
          raise Exception.Create('Teclee un NIF para el representante.');
          //UniDBEditREP_NIF.SetFocus;
        end;

        if ADQuery1REPRESENTANTE_NOMBRE_EMP.AsString='' then
        begin
          raise Exception.Create('Teclee un nombre para el representante.');
          //UniDBEditRep_Nombre.SetFocus;
        end;

        if ADQuery1REPRESENTANTE_CARGO_EMP.AsString='' then
        begin
          raise Exception.Create('Teclee un cargo para el representante.');
          //UniDBEditRep_cargo.SetFocus;
        end;

      //  if ADQuery1CODIGO_PROVINCIA.AsString='' then
      //  begin
      //    raise Exception.Create('Teclee una provincia.');
      //    UniDBEditProvincia.SetFocus;
      //  end;

        case programa of
          caifac: prog:='CAIFACWEB';
          caiconta: prog:='CAICONTAWEB';
          cailab: prog:='CAILABWEB';
          caifis: prog:='CAIFISWEB';
          caisoc: prog:='CAISOCWEB';
          cairen: prog:='CAIRENWEB';
          else prog:='ERROR';
        end;

        case programa of
          caifac: licencia:=DameNumeroLicencia('FACTURACION');
          caiconta: licencia:=DameNumeroLicencia('CONTABILIDAD');
          cailab: licencia:=DameNumeroLicencia('LABORAL');
          caifis: licencia:=DameNumeroLicencia('FISCAL');
          caisoc: licencia:=DameNumeroLicencia('SOCIEDADES');
          cairen: licencia:=DameNumeroLicencia('RENTA');
          else licencia:='';
        end;


        if empresa_a_borrar=-1 then
        begin
          // Graba datos
          if not (ADQuery1.State in dsEditModes) then adquery1.Edit;
          // Actualizar desde la web
          ADQuery1ACTUALIZAR_DESDE_LA_WEB.AsString:='SI';
          ADQuery1.Post;

          if rgVersion.Visible then
            clausula_version:=',TIPO_LICENCIA='+IntToStr(rgVersion.ItemIndex+1)+' '
          else
            clausula_version:='';

          // graba en licencia el IBAN,FECHA_DEMO=NULL, y FECHA_CONTRATO
          ADConnectionFactura.ExecSQL('UPDATE LICENCIAS_PROGRAMAS_WEB SET IBAN='+QuotedStr(MaskEditIBAN.Text)+',LICENCIA='+QuotedStr(licencia)+',FECHA_DEMO=NULL,FECHA_CONTRATO='+QuotedStr(FormatDateTime('mm/dd/yyyy',Date))+#13+
          clausula_version+#13+
          'WHERE PROGRAMA='+QuotedStr(prog)+' AND FECHA_DEMO IS NOT NULL AND CLAVEEMP=(SELECT EMPRESA FROM USUARIOS WHERE IDUSUARIOS='+IntToStr(queUsuario)+')');

          envia_mensaje(cambiar_IDBASEDEDATOS,prog,licencia,False);
          ModalResult:=mrOk;
        end
        else begin
          // Busca las licencias de los programas en demo que tiene los recorre
          // LES CAMBIA A LA LICENCIA LA EMPRESA
          // LE CAMBIA AL USUARIO LA EMPRESA
          // GRABA LOS DATOS EN LA EMPRESA DE ID_BASEDEDATOS y LAS RUTAS NECDSARIAS PARA CADA PROGRAMA
          // BORRA LA EMPRESA QUE SOBRA
          Texto:='SELECT PROGRAMA,IBAN, BANCOEMP,IDBASEDEDATOS,DATOS_EMPRESA.CLAVEEMP CLAVEEMP,LICENCIAS_PROGRAMAS_WEB.NUMERO_USUARIOS NUMERO_USUARIOS,LICENCIAS_PROGRAMAS_WEB.NUMERO_EMPRESAS NUMERO_EMPRESAS,' +#13+
                 'LICENCIAS_PROGRAMAS_WEB.TIPO_LICENCIA TIPO_LICENCIA,FECHA_DEMO,IDFRUTAS_GENERAL,IDFURL_CAIMAE,' +#13+
                 'IDFRUTAS_CAICONTA,IDFURL_CAICONTA,IDFRUTAS_CAIFIS,IDFURL_CAIFIS,IDFRUTAS_CAISOC,IDFURL_CAISOC,IDFRUTAS_CAIREN,IDFURL_CAIREN,IDFRUTAS_CAILAB,IDFURL_CAILAB,IDFRUTAS_CAIFAC,IDFURL_CAIFAC,ID' +#13+
                 'FROM DATOS_EMPRESA' +#13+
                 'INNER JOIN LICENCIAS_PROGRAMAS_WEB ON (DATOS_EMPRESA.CLAVEEMP=LICENCIAS_PROGRAMAS_WEB.CLAVEEMP)' +#13+
                 'WHERE LICENCIAS_PROGRAMAS_WEB.CLAVEEMP='+IntTostr(empresa_a_borrar)+#13+
                 'AND FECHA_DEMO IS NOT NULL'+#13+
                 'order BY 1 desc';

          with ConsultaAD(ADConnectionFactura,Texto) do
          try
            if not IsEmpty then
            begin
              if not (ADQuery1.State in dsEditModes) then ADQuery1.Edit;

              while not eof do
              begin
                cambiar_PROGRAMA:=FieldByName('PROGRAMA').AsString;
                cambiar_IDBASEDEDATOS:=FieldByName('IDBASEDEDATOS').AsInteger;
                cambiar_IDFRUTAS_GENERAL:=FieldByName('IDFRUTAS_GENERAL').AsInteger;
                cambiar_IDFURL_CAIMAE:=FieldByName('IDFURL_CAIMAE').AsInteger;
                cambiar_ID:=FieldByName('ID').AsInteger; // licencias programas web

                // CAMBIA LOS DATOS DE LA EMPRESA
                if ADQuery1IDBASEDEDATOS.AsInteger=0  then
                  ADQuery1IDBASEDEDATOS.AsInteger:=cambiar_IDBASEDEDATOS;

                if ADQuery1IDFRUTAS_GENERAL.AsInteger=0  then
                  ADQuery1IDFRUTAS_GENERAL.AsInteger:=cambiar_IDFRUTAS_GENERAL;

                if ADQuery1IDFURL_CAIMAE.AsInteger=0  then
                  ADQuery1IDFURL_CAIMAE.AsInteger:=cambiar_IDFURL_CAIMAE;

                // SEGUN PROGRAMA CAMBIA OTROS
                if cambiar_PROGRAMA='CAICONTAWEB' then
                begin
                 if ADQuery1IDFRUTAS_CAICONTA.AsInteger=0
                   then ADQuery1IDFRUTAS_CAICONTA.AsInteger:=FieldByName('IDFRUTAS_CAICONTA').AsInteger;

                 if ADQuery1IDFURL_CAICONTA.AsInteger=0
                   then ADQuery1IDFURL_CAICONTA.AsInteger:=FieldByName('IDFURL_CAICONTA').AsInteger;
                end;

                if cambiar_PROGRAMA='CAILABWEB' then
                begin
                 if ADQuery1IDFRUTAS_CAILAB.AsInteger=0
                   then ADQuery1IDFRUTAS_CAILAB.AsInteger:=FieldByName('IDFRUTAS_CAILAB').AsInteger;

                 if ADQuery1IDFURL_CAILAB.AsInteger=0
                  then ADQuery1IDFURL_CAILAB.AsInteger:=FieldByName('IDFURL_CAILAB').AsInteger;
                end;

                if cambiar_PROGRAMA='CAIFISWEB' then
                begin
                  if ADQuery1IDFRUTAS_CAIFIS.AsInteger=0
                    then ADQuery1IDFRUTAS_CAIFIS.AsInteger:=FieldByName('IDFRUTAS_CAIFIS').AsInteger;

                  if ADQuery1IDFURL_CAIFIS.AsInteger=0
                    then ADQuery1IDFURL_CAIFIS.AsInteger:=FieldByName('IDFURL_CAIFIS').AsInteger;
                end;

                if cambiar_PROGRAMA='CAISOCWEB' then
                begin
                  if ADQuery1IDFRUTAS_CAISOC.AsInteger=0
                    then ADQuery1IDFRUTAS_CAISOC.AsInteger:=FieldByName('IDFRUTAS_CAISOC').AsInteger;

                  if ADQuery1IDFURL_CAISOC.AsInteger=0
                    then ADQuery1IDFURL_CAISOC.AsInteger:=FieldByName('IDFURL_CAISOC').AsInteger;
                end;

                if cambiar_PROGRAMA='CAIRENWEB' then
                begin
                  if ADQuery1IDFRUTAS_CAIREN.AsInteger=0
                    then ADQuery1IDFRUTAS_CAIREN.AsInteger:=FieldByName('IDFRUTAS_CAIREN').AsInteger;

                  if ADQuery1IDFURL_CAIREN.AsInteger=0
                    then ADQuery1IDFURL_CAIREN.AsInteger:=FieldByName('IDFURL_CAIREN').AsInteger;
                end;

                if cambiar_PROGRAMA='CAIFACWEB' then
                begin
                  if ADQuery1IDFRUTAS_CAIFAC.AsInteger=0
                    then ADQuery1IDFRUTAS_CAIFAC.AsInteger:=FieldByName('IDFRUTAS_CAIFAC').AsInteger;

                  if ADQuery1IDFURL_CAIFAC.AsInteger=0
                    then ADQuery1IDFURL_CAIFAC.AsInteger:=FieldByName('IDFURL_CAIFAC').AsInteger;
                end;

                // Actualizar desde la web
                ADQuery1ACTUALIZAR_DESDE_LA_WEB.AsString:='SI';


                case programa of
                  caifac: prog:='CAIFACWEB';
                  caiconta: prog:='CAICONTAWEB';
                  cailab: prog:='CAILABWEB';
                  caifis: prog:='CAIFISWEB';
                  caisoc: prog:='CAISOCWEB';
                  cairen: prog:='CAIRENWEB';
                  else prog:='ERROR';
                end;

                // CAMBIA EN LA LICENCIA LA EMPRESA
                ADConnectionFactura.ExecSQL('UPDATE LICENCIAS_PROGRAMAS_WEB SET CLAVEEMP='+IntToStr(ADQuery1CLAVEEMP.AsInteger)+' WHERE ID='+IntToStr(cambiar_ID));

                // CAMBIA LOS DEMÁS DATOS
                if rgVersion.Visible then
                  clausula_version:=',TIPO_LICENCIA='+IntToStr(rgVersion.ItemIndex+1)+' '
                else
                  clausula_version:='';

                ADConnectionFactura.ExecSQL('UPDATE LICENCIAS_PROGRAMAS_WEB SET CLAVEEMP='+IntToStr(ADQuery1CLAVEEMP.AsInteger)+',IBAN='+QuotedStr(MaskEditIBAN.Text)+',LICENCIA='+QuotedStr(licencia)+',FECHA_DEMO=NULL,FECHA_CONTRATO='+QuotedStr(FormatDateTime('mm/dd/yyyy',Date))+#13+
                clausula_version+#13+
                ' WHERE ID='+IntToStr(cambiar_ID)+' AND PROGRAMA='+QuotedStr(prog));

                Next;
              end;

              // LE CAMBIA AL USUARIO LA EMPRESA
              ADConnectionFactura.ExecSQL('UPDATE USUARIOS SET EMPRESA='+IntToStr(ADQuery1CLAVEEMP.AsInteger)+' WHERE EMPRESA='+IntToStr(empresa_a_borrar));
              // BORRA LA EMPRESA QUE SOBRA
              ADConnectionFactura.ExecSQL('DELETE FROM DATOS_EMPRESA WHERE CLAVEEMP='+IntToStr(empresa_a_borrar));

              ADQuery1.Post;

              envia_mensaje(cambiar_IDBASEDEDATOS,prog,licencia,True);
              ModalResult:=mrOk;
            end
            else raise Exception.Create('Error al localizar la licencia. Contacte con CAI Sistemas Informáticos.');


          finally
            Free;
          end;
        end;
      end;
    end);
end;

procedure TFrmRegistro.UBSalirClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmRegistro.UBVerContratoClick(Sender: TObject);
begin
  with TFrmVisorPDF.Create(UniApplication) do
  begin
    Caption:='Contrato';
    Mostrar('https://portalcai.es/caifac/contrato.html');
  end;
end;

procedure TFrmRegistro.UniBitBtn1Click(Sender: TObject);
begin
  TFrmProvinciasBrowse.Crear(TFrmProvinciasEditor,'','NOMBRE',ADQuery1CODIGO_PROVINCIA,'CODIGO').Show;
end;

procedure TFrmRegistro.UniBitBtn2Click(Sender: TObject);
begin
  if trim(UniDBEditNIF.Text)='' then
    UniguiDialogs.ShowMessage('Teclee un NIF. ',procedure(Sender: TComponent; AResult: Integer)
    begin
      UniDBEditNIF.SetFocus;
    end);
end;

procedure TFrmRegistro.UniDBEditREP_NIFAjaxEvent(Sender: TComponent;
  EventName: string; Params: TUniStrings);
var
  LNIF:String;
begin
  inherited;
  if not LanzaCambio(Sender,EventName,Params) then
    if SameText('CAMBIO',EventName) then
    begin
      LNIF:=CalcCifNif('ES',DataSource1.DataSet.FieldByName('REPRESENTANTE_NIF_EMP').AsString,True);
      if LNIF='MAL' then
        DataSource1.DataSet.FieldByName('REPRESENTANTE_NIF_EMP').AsString:=Params.Values['anterior']
      else begin
        DataSource1.DataSet.FieldByName('REPRESENTANTE_NIF_EMP').AsString:=LNIF;
      end;
    end;
end;

procedure TFrmRegistro.UniFormAjaxEvent(Sender: TComponent; EventName: string;
  Params: TUniStrings);
begin
  if SameText(EventName,'NIF') then
  begin
    ADQuery1CIFEMP.AsString:=Params.Values['valor'];
  end;

  if SameText(EventName,'NIF_REPRESENTANTE') then
  begin
    ADQuery1REPRESENTANTE_NIF_EMP.AsString:=Params.Values['valor'];
  end;
end;

procedure TFrmRegistro.UniFormClose(Sender: TObject; var Action: TCloseAction);
var
  prog: string;
begin
  if ModalResult<>mrOk then
  begin
    case programa of
      caifac: prog:='caifac/inicio';
      caiconta: prog:='caiconta/inicio';
      cailab: prog:='cailab/inicio';
      caifis: prog:='caifis/inicio';
      caisoc: prog:='caisoc/inicio';
      cairen: prog:='cairen/inicio';
      else prog:='';
    end;
    UniSession.AddJS('window.location.href=''https://www.portalcai.es/'+prog+''';');
  end;
end;

procedure TFrmRegistro.UniFormCreate(Sender: TObject);
begin
  ModalResult:=mrCancel;
  MonitorizarTeclas(Self,[VK_ESCAPE],False);
  claveemp:=-1; empresa_a_borrar:=-1;
  AsignaCambioDBEdit(UniDBEditREP_NIF);
end;

procedure TFrmRegistro.UniFormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_ESCAPE then
    Self.Close;
end;



procedure TFrmRegistro.UniFormShow(Sender: TObject);
begin
  Hacer_controles:=True;

  ADQuery1.Open;

  // La versión solo visible para laboral y caiconta
  case programa of
    caifac: rgVersion.Visible:=False;
    caiconta: rgVersion.Visible:=True;
    cailab: rgVersion.Visible:=True;
    caifis: rgVersion.Visible:=False;
    caisoc: rgVersion.Visible:=False;
    cairen: rgVersion.Visible:=False;
  end;

  //UniGroupBoxContenedorLicencia.Visible:=rgVersion.Visible;

  if ADQuery1CIFEMP.AsString<>'' then
  begin
    // SI hay cif inabilita los datos
    UniGroupBoxNIF.Enabled:=false;
    UniGroupBoxDatos.Enabled:=false;
    UniGroupBoxDatos.visible:=True;
    // permite aceptar
    UBAceptar.Enabled:=True;
    self.Height:=440;
    cargaIBAN;
  end;
end;

procedure TFrmRegistro.UniLabel3Click(Sender: TObject);
var
  prog: string;
begin
  case programa of
    caifac: prog:='https://www.caisistemas.es/contrato-servicios-web.html?t=caifac';
    caiconta: prog:='https://www.caisistemas.es/contrato-servicios-web.html?t=caiconta';
    cailab: prog:='https://www.caisistemas.es/contrato-servicios-web.html?t=cailab';
    caifis: prog:='https://www.caisistemas.es/contrato-servicios-web.html?t=caifis';
    caisoc: prog:='https://www.caisistemas.es/contrato-servicios-web.html?t=caisoc';
    cairen: prog:='https://www.caisistemas.es/contrato-servicios-web.html?t=cairen';
    else prog:='';
  end;

  with TFrmVisorPDF.Create(UniApplication) do
  begin
    Caption:='Contrato';
    Mostrar(prog);
  end;
end;

end.
