unit Frm_Visor_Contrato;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniDBEdit, uniEdit, uniLabel, uniToolBar,
  uniGUIBaseClasses, uniImageList,db, uniRadioButton,UniguiDialogs, uniPanel,
  uniCheckBox, Funciones, Frm_VisorHTML, uniButton, uniBitBtn, uniMemo,
  uniURLFrame,strutils, ServerModule, uniHTMLFrame, uniFileUpload,DebenuPDFLibrary1612,
  Frm_PedirDatos,FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.Phys.Intf, FireDAC.DApt.Intf,FireDAC.DatS, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.UI.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Phys, FireDAC.VCLUI.Wait, uniScreenMask;

type
  TFrmVisorContrato = class(TUniForm)
    UTBBotonera: TUniToolBar;
    UBAceptar: TUniToolButton;
    UBCancelar: TUniToolButton;
    UniPanel1: TUniPanel;
    UniCheckBoxAceptar: TUniCheckBox;
    UniURLFrame1: TUniURLFrame;
    UBConfirmar: TUniBitBtn;
    UniBitBtn1: TUniBitBtn;
    UniScreenMask1: TUniScreenMask;
    procedure UBCancelarClick(Sender: TObject);
    procedure UBAceptarClick(Sender: TObject);
    procedure UniFormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure UniLabel5Click(Sender: TObject);
    procedure UniCheckBoxAceptarChange(Sender: TObject);
    procedure UniFormShow(Sender: TObject);
    procedure UBConfirmarClick(Sender: TObject);
    procedure UniBitBtn1Click(Sender: TObject);
  private
    documento,Firma,Pie,div_firma_cliente: string;
    Fcampo_a_cambiar: string;
    FModoConsulta: boolean;
    Fparametro_programa: string;
    procedure Setcampo_a_cambiar(const Value: string);
    procedure SetModoConsulta(const Value: boolean);
    procedure MostrarConfirmacion;
    procedure Setparametro_programa(const Value: string);
    { Private declarations }
  public
    FPadre:TUniForm;
    property campo_a_cambiar: string read Fcampo_a_cambiar write Setcampo_a_cambiar;
    property ModoConsulta: boolean read FModoConsulta write SetModoConsulta;
    property parametro_programa: string read Fparametro_programa write Setparametro_programa;

  end;

implementation

uses
  uniGUIApplication,  MainModule, Frm_Firma_contratos, IOUtils;

{$R *.dfm}


procedure TFrmVisorContrato.MostrarConfirmacion;
begin
  UniCheckBoxAceptar.Visible:=False;
  UBConfirmar.Visible:=True;
end;

procedure TFrmVisorContrato.Setcampo_a_cambiar(const Value: string);
begin
  Fcampo_a_cambiar := Value;
end;

procedure TFrmVisorContrato.SetModoConsulta(const Value: boolean);
begin
  FModoConsulta := Value;
end;

procedure TFrmVisorContrato.Setparametro_programa(const Value: string);
begin
  Fparametro_programa := Value;
end;

procedure TFrmVisorContrato.UBAceptarClick(Sender: TObject);
begin
  ModalResult:=mrOk;
  close;
end;

procedure TFrmVisorContrato.UBCancelarClick(Sender: TObject);
begin
  close;
end;

procedure TFrmVisorContrato.UBConfirmarClick(Sender: TObject);
var
  QP:TDebenuPDFLibrary1612;
  imagen,Quepagina,PageNum, PR,FH,IL,X: integer;
  ImageLeft, ImageTop, ImageWidth: Double;
  ImageLeftCAI, ImageTopCAI, ImageWidthCAI, ImageHeightCAI: Double;
  TextoSQL: string;
  IDDocumento: integer;
  fs: TFileStream;
  function NuevoID(Tabla: String): integer;
  begin
    if TFrmFirmaContratos(FPadre).ADQueryBLOB.Active then TFrmFirmaContratos(FPadre).ADQueryBLOB.Close;
    TFrmFirmaContratos(FPadre).ADQueryBLOB.SQL.Text:='SELECT GEN_ID('+Tabla+',1) FROM RDB$DATABASE;';
    TFrmFirmaContratos(FPadre).ADQueryBLOB.Open;
    Result:=TFrmFirmaContratos(FPadre).ADQueryBLOB.Fields[0].AsInteger;
  end;
begin

  ImageLeft:=0; ImageTop:=0; ImageWidth:=0;   ImageLeftCAI:=0; ImageTopCAI:=0; ImageWidthCAI:=0; ImageHeightCAI:=0;

 // TFile.WriteAllText(documento,HazPost(ReplaceText(documento,IncludeTrailingPathDelimiter(UniServerModule.LocalCachePath),UniServerModule.LocalCacheURL), ['t='+parametro_programa],'','','',true));
  // Crea el PDF
  HTMLaPDF(documento,ReplaceStr(documento,'html','pdf'),False);

  // Incluye la firma en el pdf con quickpdf ya que la función anterior no lo hace
  QP:=TDebenuPDFLibrary1612.Create;
  try
    QP.UnlockKey('jf77x88g5rt3bc3i99m44rs3y');
    // Open the file in direct access mode and store the file handle
    FH := QP.DAOpenFile(ReplaceStr(documento,'html','pdf'), '');


    // Loop through all the pages
    for PageNum := 1 to QP.DAGetPageCount(FH) do
    begin
     // Get a page reference to the current page
     PR := QP.DAFindPage(FH, PageNum);
     IL := QP.DAGetPageImageList(FH, PR);
      // Loop through all the images
      for X := 1 to QP.DAGetImageListCount(FH, IL) do
      begin
        // Determine the location and size of the image on the page
        if ImageLeftCAI=0 then
        begin
          ImageLeftCAI := QP.DAGetImageDblProperty(FH, IL, X, 501);
          ImageTopCAI := QP.DAGetImageDblProperty(FH, IL, X, 502);
          ImageWidthCAI := QP.DAGetImageDblProperty(FH, IL, X, 503) - QP.DAGetImageDblProperty(FH, IL, X, 501);
          ImageHeightCAI := QP.DAGetImageDblProperty(FH, IL, X, 502) - QP.DAGetImageDblProperty(FH, IL, X, 508);
        end
        else begin
          ImageLeft := QP.DAGetImageDblProperty(FH, IL, X, 501);
          ImageTop := QP.DAGetImageDblProperty(FH, IL, X, 502);
          ImageWidth := QP.DAGetImageDblProperty(FH, IL, X, 503) - QP.DAGetImageDblProperty(FH, IL, X, 501);
          //ImageHeight := QP.DAGetImageDblProperty(FH, IL, X, 502) - QP.DAGetImageDblProperty(FH, IL, X, 508);
        end;
        Quepagina:= PageNum;
      end;  // End image loop
    end;
    QP.DACloseFile(FH);

    QP.LoadFromFile(ReplaceStr(documento,'html','pdf'),'');
    QP.SelectPage(Quepagina);

    // Imagen de CAI
    if ImageLeftCAI<>0  then
    begin
      if ImageLeft=0 then // Si no hay imagen de cliente la primera que encuentra es la del cliente
      begin
        //imagen := QP.AddImageFromFile(Firma, 0);
        imagen := QP.AddImageFromFile(IncludeTrailingPathDelimiter(UniServerModule.FilesFolderPath)+'cai_firma.jpg', 0);
        QP.SelectImage(imagen);
        QP.DrawImage(ImageLeftCAI-10, ImageTopCAI+10, 200, 100)
      end
      else begin
        // Si hay imagen del cliente la primera que encuentra es la de CAI
        imagen := QP.AddImageFromFile(IncludeTrailingPathDelimiter(UniServerModule.FilesFolderPath)+'cai_firma.jpg', 0);
        QP.SelectImage(imagen);
        QP.DrawImage(ImageLeftCAI-10, ImageTopCAI+10, 200, 100);
      end;
    end;

    // Imagen firma cliente
    if ImageLeft<>0  then
    begin
      imagen := QP.AddImageFromFile(Firma, 0);
      QP.SelectImage(imagen);
      QP.DrawImage(ImageLeft-10, ImageTop+10, 200, 100);
    end;

    QP.CompressContent();
    QP.SaveToFile(ReplaceStr(documento,'html','pdf'));

  finally
    FreeAndNil(QP);
  end;


  // Guarda la Huella digital
  if not (TFrmFirmaContratos(FPadre).ADMemtable1.state in dsEditModes) then TFrmFirmaContratos(FPadre).ADMemtable1.Edit;
  TFrmFirmaContratos(FPadre).ADMemtable1.FieldByName('HASHSHA256').AsString:=HashSHA256(ReplaceStr(documento,'html','pdf'));
//  TFrmFirmaContratos(FPadre).ADMemtable1.FieldByName('DOCUMENTO').AsString:=TFrmFirmaContratos(FPadre).ADMemtable1.FieldByName('DOCUMENTO').AsString+' [Huella digital: '+TFrmFirmaContratos(FPadre).ADMemtable1.FieldByName('HASHSHA256').AsString+']';

  // Graba el documento como firmado
  IDDocumento:=NuevoID('CAI_DOCUMENTOS_FIRMADOS');
  TextoSQL:='INSERT INTO CAI_DOCUMENTOS_FIRMADOS('+#13+
  'INTERNO,'+#13+
  'DOCUMENTOS_A_FIRMAR_INTERNO_DFI,'+#13+
  'FECHA_DFI,'+#13+
  'EMPRESA_DFI,'+#13+
  'LICENCIA_DFI,'+#13+
  'TIPO_LICENCIA_DFI,'+#13+
  ifthen(TFrmFirmaContratos(FPadre).tipo='LOCAL','','IP_DFI,')+#13+
  ifthen(TFrmFirmaContratos(FPadre).tipo='LOCAL','NOMBRE_EQUIPO_DFI,','')+#13+
  'USUARIO_DFI,'+#13+
  ifthen(TFrmFirmaContratos(FPadre).tipo='LOCAL','DISCO_DURO_DFI,','')+#13+
  ifthen(TFrmFirmaContratos(FPadre).tipo='LOCAL','SISTEMA_DFI,','')+#13+
  'LEIDO_ACEPTADO_DFI,'+#13+
  'HASHSHA256)'+#13+
  'VALUES('+#13+
  IntToStr(IDDocumento)+','+#13+
  IntToStr(TFrmFirmaContratos(FPadre).ADMemtable1INTERNO.AsInteger)+','+#13+
  QuotedStr(FormatDateTime('mm/dd/yyyy hh:nn:ss',now))+','+#13+

  IntToStr(TFrmFirmaContratos(FPadre).ADMemtable1EMPRESA.AsInteger)+','+#13+

  ifthen(TFrmFirmaContratos(FPadre).ADMemtable1.FieldByName('TIPO_FIRMA').AsString='EMPRESA','null', QuotedStr(TFrmFirmaContratos(FPadre).ADQuery1.FieldByName('LICENCIA').AsString))+','+#13+
  QuotedStr(TFrmFirmaContratos(FPadre).tipo)+','+#13+
  ifthen(TFrmFirmaContratos(FPadre).tipo='LOCAL','',quotedstr(UniMainModule.RemoteAddress)+',')+#13+
  ifthen(TFrmFirmaContratos(FPadre).tipo='LOCAL',QuotedStr(TFrmFirmaContratos(FPadre).equipo)+',','')+#13+
  QuotedStr(TFrmFirmaContratos(FPadre).usu)+','+#13+
  ifthen(TFrmFirmaContratos(FPadre).tipo='LOCAL',QuotedStr(TFrmFirmaContratos(FPadre).disco)+',','')+#13+
  ifthen(TFrmFirmaContratos(FPadre).tipo='LOCAL',QuotedStr(TFrmFirmaContratos(FPadre).so)+',','')+#13+
  QuotedStr('S')+','+#13+
  QuotedStr(TFrmFirmaContratos(FPadre).ADMemtable1.FieldByName('HASHSHA256').AsString)+
  ')';

  TFrmFirmaContratos(FPadre).Conexion.ExecSQL(TextoSQL);

  // Graba el pdf
  fs := TFileStream.Create(ReplaceStr(documento,'html','pdf'), fmOpenRead);
  try
    if TFrmFirmaContratos(FPadre).ADQueryBLOB.Active then TFrmFirmaContratos(FPadre).ADQueryBLOB.Close;
    TFrmFirmaContratos(FPadre).ADQueryBLOB.SQL.Text:='SELECT * FROM CAI_DOCUMENTOS_FIRMADOS WHERE INTERNO='+IntToStr(IDDocumento);
    TFrmFirmaContratos(FPadre).ADQueryBLOB.Open;
    TFrmFirmaContratos(FPadre).ADQueryBLOB.Edit;
    TBlobField(TFrmFirmaContratos(FPadre).ADQueryBLOB.FieldByName('CONTRATO_DFI')).LoadFromStream(fs);
    TFrmFirmaContratos(FPadre).ADQueryBLOB.Post;
  finally
    fs.Free;
  end;

  ModalResult:=mrOk;
end;

procedure TFrmVisorContrato.UniBitBtn1Click(Sender: TObject);
begin
  UniURLFrame1.JSInterface.JSCode('Ext.defer(function(){'#1'.iframe.contentWindow.print()}, 100);');
end;

procedure TFrmVisorContrato.UniCheckBoxAceptarChange(Sender: TObject);
begin
  (*
  //Firma CAI
  UniURLFrame1.HTML.Text:=ReplaceStr(UniURLFrame1.HTML.Text,'%CAI_FIRMA%','<img src="https://www.caisistemas.es/firma_contratos/files/cai_firma.jpg" width="200" height="100"/>');

  // Firma Cliente
  UniURLFrame1.HTML.Text:=ReplaceStr(UniURLFrame1.HTML.Text,'%EMPRESA_FIRMA%',div_firma_cliente);

  // Pie de página
  UniURLFrame1.HTML.Text:=ReplaceStr(UniURLFrame1.HTML.Text,'</html>','<br><br><span style=''font-size:6.5pt;font-family:"Verdana","sans-serif"''>'+Pie+'</span></html>');

  UniURLFrame1.HTML.SaveToFile(documento);
  *)


  MostrarConfirmacion;

end;

procedure TFrmVisorContrato.UniFormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_ESCAPE:UBCancelarClick(nil);
    VK_RETURN:UBAceptarClick(nil);
  end;
end;

procedure TFrmVisorContrato.UniFormShow(Sender: TObject);
var
  Stream:TStream;
  lista: TStringlist;
  Periodicidad,limites: string;
  lcif,ltexto: string;
  lsw: integer;

  function ToNumber(ptexto : string) : integer;
  var lsw : integer;
  var lnumeros : string;
  begin
       lnumeros := '0123456789';
       Result := 0;

       If ptexto = '' then
          ptexto := '0';

       IF ptexto <> '' then begin
          For lsw := 1 To length(ptexto) do begin
              IF pos(ptexto[lsw],lnumeros) = 0 then
                 Exit;
          end;
       end;

       Result := StrToInt(ptexto);

  end;
begin
  top:=30;
  Height:=TFrmFirmaContratos(FPadre).Height-30;
  // Dependiendo si es de tipo local o web, los mensajes son diferentes
  if (TFrmFirmaContratos(FPadre).tipo='LOCAL') then
    Pie:='Documento firmado electrónicamente por el usuario '+TFrmFirmaContratos(FPadre).usu+
         ' en el equipo '+TFrmFirmaContratos(FPadre).equipo+' con número de serie '+TFrmFirmaContratos(FPadre).disco+
         ' y sistema operativo '+TFrmFirmaContratos(FPadre).so+
         '. Este documento se almacenará junto con una huella digital que preservará la integridad del documento original.'
  else
    Pie:='Documento firmado electrónicamente. Este documento se almacenará junto con una huella digital que preservará la integridad del documento original.';

  // Firma en texto del cliente
  div_firma_cliente:='<div style="color:black;"><p style="border:solid; max-width: 220px;text-align: center;">'+TFrmFirmaContratos(FPadre).ADQuery1.FieldByName('NOMBREMP').AsString+'<br>'+FormatdateTime('dd/mm/yyyy',Date)+'<br>'+FormatdateTime('hh:nn',Now)+'<br>Usuario :'+TFrmFirmaContratos(FPadre).usu+'<br>I.P. :'+UniMainModule.RemoteAddress+'</p> </div>';

  documento:=IncludeTrailingPathDelimiter(UniServerModule.LocalCachePath)+'contrato'+TFrmFirmaContratos(FPadre).ADMemTable1INTERNO.AsString+'.html';
  if ModoConsulta then
  begin
     //UniURLFrame1.URL:=ReplaceText(documento+'?t='+parametro_programa,IncludeTrailingPathDelimiter(UniServerModule.LocalCachePath),UniServerModule.LocalCacheURL);
    UniURLFrame1.HTML.LoadFromFile(documento);
    UniPanel1.Visible:=False;
  end
  else begin
    top:=30;
    Height:=TFrmFirmaContratos(FPadre).Height-30;
    Lista:=TStringlist.Create;
    Stream:=TFrmFirmaContratos(FPadre).ADMemTable1.CreateBlobStream(TFrmFirmaContratos(FPadre).ADMemTable1.FieldByName('CONTRATO'),bmRead);
    try
      DeleteFile(documento);
      lista.LoadFromStream(Stream);
      // Fusiona

      {si es persona física y encuentra    , debidamente representado por %REPRESENTANTE_NOMBRE%, con NIF %REPRESENTANTE_NIF%.            lo sustituye por un punto}
      if PersonaFisica('ES',TFrmFirmaContratos(FPadre).ADQuery1.FieldByName('CIFEMP').AsString) then
        Lista.Text:=ReplaceStr(Lista.Text,', debidamente representado por %REPRESENTANTE_NOMBRE%, con NIF %REPRESENTANTE_NIF%.','.');


      Lista.Text:=ReplaceStr(Lista.Text,'%FECHA%',FormatdateTime('dd/mm/yyyy',date));
      Lista.Text:=ReplaceStr(Lista.Text,'%EMPRESA_NOMBRE%',TFrmFirmaContratos(FPadre).ADQuery1.FieldByName('NOMBREMP').AsString);
      Lista.Text:=ReplaceStr(Lista.Text,'%EMPRESA_NIF%',TFrmFirmaContratos(FPadre).ADQuery1.FieldByName('CIFEMP').AsString);
      Lista.Text:=ReplaceStr(Lista.Text,'%EMPRESA_DOMICILIO%',TFrmFirmaContratos(FPadre).ADQuery1.FieldByName('DOMICEMP').AsString);
      Lista.Text:=ReplaceStr(Lista.Text,'%EMPRESA_POBLACION%',TFrmFirmaContratos(FPadre).ADQuery1.FieldByName('POBLAEMP').AsString);
      Lista.Text:=ReplaceStr(Lista.Text,'%EMPRESA_CPOSTAL%',TFrmFirmaContratos(FPadre).ADQuery1.FieldByName('CPOSTEMP').AsString);
      Lista.Text:=ReplaceStr(Lista.Text,'%EMPRESA_PROVINCIA%',TFrmFirmaContratos(FPadre).ADQuery1.FieldByName('EMPRESA_PROVINCIA').AsString);
      Lista.Text:=ReplaceStr(Lista.Text,'%EMPRESA_TELEFONO%',TFrmFirmaContratos(FPadre).ADQuery1.FieldByName('TELE1EMP').AsString+ifthen(TFrmFirmaContratos(FPadre).ADQuery1.FieldByName('TELE2EMP').AsString<>'',' - '+TFrmFirmaContratos(FPadre).ADQuery1.FieldByName('TELE2EMP').AsString,''));
      Lista.Text:=ReplaceStr(Lista.Text,'%EMPRESA_EMAIL_ADMINISTRACION%',TFrmFirmaContratos(FPadre).ADQuery1.FieldByName('EMPRESA_EMAIL_ADMINISTRACION').AsString);
      Lista.Text:=ReplaceStr(Lista.Text,'%EMPRESA_IBAN%',TFrmFirmaContratos(FPadre).ADQuery1.FieldByName('IBANEMP').AsString);
      Lista.Text:=ReplaceStr(Lista.Text,'%REPRESENTANTE_NOMBRE%',TFrmFirmaContratos(FPadre).ADMemTableRepresentanteNOMBRE.AsString);
      Lista.Text:=ReplaceStr(Lista.Text,'%REPRESENTANTE_NIF%',TFrmFirmaContratos(FPadre).ADMemTableRepresentanteNIF.AsString);
      Lista.Text:=ReplaceStr(Lista.Text,'%REPRESENTANTE_CARGO%',TFrmFirmaContratos(FPadre).ADMemTableRepresentanteCARGO.AsString);
      Lista.Text:=ReplaceStr(Lista.Text,'%SOFTWARE_NOMBRE%',TFrmFirmaContratos(FPadre).ADQuery1.FieldByName('SOFTWARE_NOMBRE').AsString);
      Lista.Text:=ReplaceStr(Lista.Text,'%SOFTWARE_VERSION%',TFrmFirmaContratos(FPadre).ADQuery1.FieldByName('VERSION_2016_SER').AsString);
      Lista.Text:=ReplaceStr(Lista.Text,'%SOFTWARE_LICENCIA%',TFrmFirmaContratos(FPadre).ADQuery1.FieldByName('LICENCIA').AsString);
      Lista.Text:=ReplaceStr(Lista.Text,'%EMPRESA_WEB%','');  //*****WEB
      Lista.Text:=ReplaceStr(Lista.Text,'%FECHA_SERVICIO%',FormatdateTime('dd/mm/yyyy',TFrmFirmaContratos(FPadre).ADQuery1.FieldByName('FALTASER').AsDateTime));

      limites:=ifThen(TFrmFirmaContratos(FPadre).ADQuery1.FieldByName('LICENCIA_TRAMO_01').AsInteger=9999999,'Sin límite de empresas'+#13,'Hasta '+TFrmFirmaContratos(FPadre).ADQuery1.FieldByName('LICENCIA_TRAMO_01').AsString+' empresas'+#13);
      if Pos('CAILAB',Uppercase(TFrmFirmaContratos(FPadre).ADQuery1.FieldByName('CONCEPTO').Asstring))>0 then
        limites:=limites+ifThen(TFrmFirmaContratos(FPadre).ADQuery1.FieldByName('LICENCIA_TRAMO_02').AsInteger=9999999,'Sin límite de trabajadores anuales'+#13,'Hasta '+TFrmFirmaContratos(FPadre).ADQuery1.FieldByName('LICENCIA_TRAMO_02').AsString+' trabajadores anuales'+#13);
      if Pos('CAICONTA',Uppercase(TFrmFirmaContratos(FPadre).ADQuery1.FieldByName('CONCEPTO').Asstring))>0 then
        limites:=limites+ifThen(TFrmFirmaContratos(FPadre).ADQuery1.FieldByName('LICENCIA_TRAMO_02').AsInteger=9999999,'Sin límite de apuntes anuales'+#13,'Hasta '+TFrmFirmaContratos(FPadre).ADQuery1.FieldByName('LICENCIA_TRAMO_02').AsString+' apuntes anuales'+#13);

      if TFrmFirmaContratos(FPadre).ADQuery1.FieldByName('FALTASER').AsDateTime>=strtodate('01/03/2019') then
        limites:=limites+ifThen(TFrmFirmaContratos(FPadre).ADQuery1.FieldByName('USUARIOS_2016_SER').AsInteger=99,'Sin límite de usuarios simultáneos','Hasta '+TFrmFirmaContratos(FPadre).ADQuery1.FieldByName('USUARIOS_2016_SER').AsString+' usuarios simultáneos'+#13);

      Lista.Text:=ReplaceStr(Lista.Text,'%SOFTWARE_LIMITES%',limites);
      Lista.Text:=ReplaceStr(Lista.Text,'%SOFTWARE_DURACION%','1 Año');
      Lista.Text:=ReplaceStr(Lista.Text,'%SOFTWARE_PRECIO%','Según tarifa vigente');

      if TFrmFirmaContratos(FPadre).ADQuery1.FieldByName('PERIODICIDAD_SER').AsString='M' then Periodicidad:='Mensual'
        else if TFrmFirmaContratos(FPadre).ADQuery1.FieldByName('PERIODICIDAD_SER').AsString='A' then Periodicidad:='Anual'
          else if TFrmFirmaContratos(FPadre).ADQuery1.FieldByName('PERIODICIDAD_SER').AsString='T' then Periodicidad:='Trimestral'
            else if TFrmFirmaContratos(FPadre).ADQuery1.FieldByName('PERIODICIDAD_SER').AsString='S' then Periodicidad:='Semestral'
              else if TFrmFirmaContratos(FPadre).ADQuery1.FieldByName('PERIODICIDAD_SER').AsString='B' then Periodicidad:='Bianual'
                else Periodicidad:='';


      //EL CIF LO DEVUELVE FORMATEADO
      lcif := '';
      ltexto  := TRIM(TFrmFirmaContratos(FPadre).ADQuery1.FieldByName('CIFEMP').AsString);

      for lsw := 1 To Length(ltexto) do
      if Pos(ltexto[lsw],'0123456789')<>0 then
        lcif := lcif + ltexto[lsw];

      Lista.Text:=ReplaceStr(Lista.Text,'%SOFTWARE_FORMA_DE_PAGO%',periodicidad);
      Lista.Text:=ReplaceStr(Lista.Text,'%EMPRESA_MANDATOID%',PAD(IntToStr(ToNumber(lcif)),12,'0','I'));
      Lista.Text:=ReplaceStr(Lista.Text,'%EMPRESA_BIC%',TFrmFirmaContratos(FPadre).ADQuery1.FieldByName('BIC_EMP').AsString);
      Lista.Text:=ReplaceStr(Lista.Text,'%MANDATO_FECHA%',FormatDateTime('dd/mm/yyyy',Now));

      // firma CAI
      Lista.Text:=ReplaceStr(Lista.Text,'%CAI_FIRMA%','<img src="https://www.caisistemas.es/firma_contratos/files/cai_firma.jpg" width="200" height="100"/>');

      // Firma Cliente
      Lista.Text:=ReplaceStr(Lista.Text,'%EMPRESA_FIRMA%',div_firma_cliente);

      // Pie de página
      Lista.Text:=ReplaceStr(Lista.Text,'</html>','<br><br><span style=''font-size:6.5pt;font-family:"Verdana","sans-serif"''>'+Pie+'</span></html>');


      if parametro_programa='CAICONTA' then
      begin
			  Lista.Text:=ReplaceStr(Lista.Text,'%CAIEMAIL%','caiconta');
        Lista.Text:=ReplaceStr(Lista.Text,'%CAILOGO1COLOR%','#00B4BB');
        Lista.Text:=ReplaceStr(Lista.Text,'%CAILOGO1%','conta');
        Lista.Text:=ReplaceStr(Lista.Text,'%CAIWEB%','www.portalcai.es');
        Lista.Text:=ReplaceStr(Lista.Text,'%CAIDOMINIO%','cai');
      end
      else begin
        if parametro_programa='CAIFIS' then
        begin
          Lista.Text:=ReplaceStr(Lista.Text,'%CAIEMAIL%','caifis');
          Lista.Text:=ReplaceStr(Lista.Text,'%CAILOGO1COLOR%','#854000');
          Lista.Text:=ReplaceStr(Lista.Text,'%CAILOGO1%','fis');
          Lista.Text:=ReplaceStr(Lista.Text,'%CAIWEB%','www.portalcai.es');
          Lista.Text:=ReplaceStr(Lista.Text,'%CAIDOMINIO%','cai');
        end
        else begin
          if parametro_programa='CAILAB' then
          begin
            Lista.Text:=ReplaceStr(Lista.Text,'%CAIEMAIL%','cailab');
            Lista.Text:=ReplaceStr(Lista.Text,'%CAILOGO1COLOR%','#002D7C');
            Lista.Text:=ReplaceStr(Lista.Text,'%CAILOGO1%','lab');
            Lista.Text:=ReplaceStr(Lista.Text,'%CAIWEB%','www.portalcai.es');
            Lista.Text:=ReplaceStr(Lista.Text,'%CAIDOMINIO%','cai');
          end
          else begin
            if parametro_programa='CAISOC' then
            begin
              Lista.Text:=ReplaceStr(Lista.Text,'%CAIEMAIL%','caisoc');
              Lista.Text:=ReplaceStr(Lista.Text,'%CAILOGO1COLOR%','#FD7817');
              Lista.Text:=ReplaceStr(Lista.Text,'%CAILOGO1%','soc');
              Lista.Text:=ReplaceStr(Lista.Text,'%CAIWEB%','www.portalcai.es');
              Lista.Text:=ReplaceStr(Lista.Text,'%CAIDOMINIO%','cai');
            end
            else begin
              if parametro_programa='CAIFAC' then
              begin
                Lista.Text:=ReplaceStr(Lista.Text,'%CAIEMAIL%','caifac');
                Lista.Text:=ReplaceStr(Lista.Text,'%CAILOGO1COLOR%','#A6D031');
                Lista.Text:=ReplaceStr(Lista.Text,'%CAILOGO1%','fac');
                Lista.Text:=ReplaceStr(Lista.Text,'%CAIWEB%','www.portalcai.es');
                Lista.Text:=ReplaceStr(Lista.Text,'%CAIDOMINIO%','cai');
              end
              else begin
                if parametro_programa='PORTALSII' then
                begin
                  Lista.Text:=ReplaceStr(Lista.Text,'%CAIEMAIL%','sii');
                  Lista.Text:=ReplaceStr(Lista.Text,'%CAILOGO1COLOR%','#e96c00');
                  Lista.Text:=ReplaceStr(Lista.Text,'%CAILOGO1%',' SII');
                  Lista.Text:=ReplaceStr(Lista.Text,'%CAIWEB%','www.portalsii.es');
                  Lista.Text:=ReplaceStr(Lista.Text,'%CAIDOMINIO%','Portal');
                end
                else begin
                  if parametro_programa='PORTALEEM' then
                  begin
                    Lista.Text:=ReplaceStr(Lista.Text,'%CAIEMAIL%','portaleem');
                    Lista.Text:=ReplaceStr(Lista.Text,'%CAILOGO1COLOR%','#e96c00');
                    Lista.Text:=ReplaceStr(Lista.Text,'%CAILOGO1%','eem');
                    Lista.Text:=ReplaceStr(Lista.Text,'%CAIWEB%','www.portaleem.es');
                    Lista.Text:=ReplaceStr(Lista.Text,'%CAIDOMINIO%','Portal');
                  end
                  else begin
                    if parametro_programa='CAIREN' then
                    begin
                      Lista.Text:=ReplaceStr(Lista.Text,'%CAIEMAIL%','cairen');
                      Lista.Text:=ReplaceStr(Lista.Text,'%CAILOGO1COLOR%','#C12662');
                      Lista.Text:=ReplaceStr(Lista.Text,'%CAILOGO1%','ren');
                      Lista.Text:=ReplaceStr(Lista.Text,'%CAIWEB%','www.portalcai.es');
                      Lista.Text:=ReplaceStr(Lista.Text,'%CAIDOMINIO%','cai');
                    end
                  end;
                end;
              end;
            end;
          end;
        end;
      end;

      // Ñ
      Lista.Text:=ReplaceStr(Lista.Text,'Ñ','&Ntilde;');

      Lista.SaveToFile(documento);
      UniURLFrame1.HTML.LoadFromFile(documento);
      //UniURLFrame1.URL:=ReplaceText(documento+'?t='+parametro_programa,IncludeTrailingPathDelimiter(UniServerModule.LocalCachePath),UniServerModule.LocalCacheURL);
    finally
      FreeAndnil(Stream);
      FreeAndnil(lista);
    end;
  end;
  ModalResult:=mrCancel;
end;

procedure TFrmVisorContrato.UniLabel5Click(Sender: TObject);
begin
//   UniSession.AddJS('function openInNewTab(url) {var win = window.open(url, "_blank"); win.focus();} ; openInNewTab("https://www.caisistemas.es/CAI16/aviso_legal.html");');
end;

end.



